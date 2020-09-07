Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7792025FAB7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgIGMvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 08:51:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgIGMv2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 08:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC9F0AC23;
        Mon,  7 Sep 2020 12:51:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C19FADA7C8; Mon,  7 Sep 2020 14:50:12 +0200 (CEST)
Date:   Mon, 7 Sep 2020 14:50:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 1/2] btrfs: free fs roots on failed mount
Message-ID: <20200907125012.GA28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1599157686.git.josef@toxicpanda.com>
 <1b78425a6899ac5689e432151b6bf6c6e73fd73c.1599157686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b78425a6899ac5689e432151b6bf6c6e73fd73c.1599157686.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 02:29:50PM -0400, Josef Bacik wrote:
> While testing a weird problem with -o degraded, I noticed I was getting
> leaked root errors
> 
> BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
> BTRFS error (device loop0): open_ctree failed
> BTRFS error (device loop0): leaked root -9-0 refcount 1
> 
> This is the DATA_RELOC root, which gets read before the other fs roots,
> but is included in the fs roots radix tree.  Handle this by adding a
> btrfs_drop_and_free_fs_root() on the data reloc root if it exists.  This
> is ok to do here if we fail further up because we will only drop the ref
> if we delete the root from the radix tree, and all other cleanup won't
> be duplicated.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'll add this to misc-next as this is the fix and does not need to wait
on the root pretty printing.
