Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688B9B4D7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfIQMJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 08:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbfIQMJv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 08:09:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DEE3AFC4;
        Tue, 17 Sep 2019 12:09:49 +0000 (UTC)
Date:   Tue, 17 Sep 2019 14:09:48 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/7] btrfs: don't prematurely free work in
 reada_start_machine_worker()
Message-ID: <20190917120948.GD12128@x250>
References: <cover.1568658527.git.osandov@fb.com>
 <15b3aebf569f2a2831bc852789935fae37798f8d.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b3aebf569f2a2831bc852789935fae37798f8d.1568658527.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 11:30:55AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, reada_start_machine_worker() frees the reada_machine_work and
> then calls __reada_start_machine() to do readahead. This is another
> potential instance of the bug in "btrfs: don't prematurely free work in
> run_ordered_work()".
> 
> There _might_ already be a deadlock here: reada_start_machine_worker()
> can depend on itself through stacked filesystems (__read_start_machine()
> -> reada_start_machine_dev() -> reada_tree_block_flagged() ->
> read_extent_buffer_pages() -> submit_one_bio() ->
> btree_submit_bio_hook() -> btrfs_map_bio() -> submit_stripe_bio() ->
> submit_bio() onto a loop device can trigger readahead on the lower
> filesystem).
> 
> Either way, let's fix it by freeing the work at the end.


Also remove the local fs_info variable as it got obsolete.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
