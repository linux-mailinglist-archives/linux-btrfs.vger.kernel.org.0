Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFC12FB1E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgACRIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 12:08:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:52420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgACRIl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 12:08:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92E28AB9B;
        Fri,  3 Jan 2020 17:08:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9041CDA795; Fri,  3 Jan 2020 18:08:30 +0100 (CET)
Date:   Fri, 3 Jan 2020 18:08:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Fix transaction abort when rmdir'ing a subvol
Message-ID: <20200103170830.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191218222029.49178-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218222029.49178-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 05:20:26PM -0500, Josef Bacik wrote:
> btrfs/004 with my new fsstress was sometimes failing with a transaction abort
> while trying to remove a root ref.  This turned out to be because of how we stub
> out subvol links in snapshot'ed subvolumes.  The specific steps are detailed in
> "btrfs: fix invalid removal of root ref", but they are relatively
> straightforward.  A xfstest is forthcoming, I want to get an overnight run of
> fsstress with these patches in place to make sure there are no other
> rename+removal shenanigans left.  With these patches we pass my basic test and
> no longer abort the transaction.  Thanks,

Reviewed-by: David Sterba <dsterba@suse.com>

As 2 and 3 are the real fixes, independent of 1, I'll queue them for
next week's pull request.
