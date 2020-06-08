Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9E1F13C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgFHHoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 03:44:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:7302 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgFHHoS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 03:44:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gQHh69nmz2d;
        Mon,  8 Jun 2020 09:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591602257; bh=2mzJFIyHQXhgZJ7s08SWH4/BavzSldhyd85ewPhkWIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sqbj5ALUn9ho/97H8dcv77GsPybebh+OnNef/KhEehV7shB7Dqz2V2EUTz2XFn9d+
         4GwbmYGaxSgqXdxcNvJ9fMEheMxj2P3fihliFwx+sNUmk68U1mXZzlzlcPI6wbya+j
         q5WN6591YCYQHaFooCSZzgl8OO9sHPpfEULqa1q2Q6r+mIAt7QEIVAhtY2ZT6C62B5
         Dvn1ueEekJ1+yxgljAdwwgVNdgvUqlrc6TPqLZ97n4iUH2MBXZcMowgj1W7WHnd5nr
         VQf1OE1u6X7T9nyOvS/kfpkVG0IhXRlj2r+0U98eMwCzywMZ/O7FVH57jJKuIcFcDz
         KBa+afiJvHDjg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 8 Jun 2020 09:44:15 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
Message-ID: <20200608074414.GA1124@qmqm.qmqm.pl>
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com>
 <20200608072000.GA6516@qmqm.qmqm.pl>
 <4e6fd959-f04c-6c0d-9e13-86942ef47f12@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e6fd959-f04c-6c0d-9e13-86942ef47f12@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 08, 2020 at 03:24:10PM +0800, Qu Wenruo wrote:
> On 2020/6/8 下午3:20, Michał Mirosław wrote:
> > On Sun, Jun 07, 2020 at 03:25:12PM +0800, Qu Wenruo wrote:
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/disk-io.c |  6 ++++++
> >>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
> >>  fs/btrfs/qgroup.h  |  2 +-
> >>  3 files changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index f8ec2d8606fd..48d047e64461 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
> >>  	ASSERT(list_empty(&fs_info->delayed_iputs));
> >>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
> >>  
> >> +	if (btrfs_qgroup_has_leak(fs_info)) {
> >> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> >> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
> >> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");
> >> +	}
> > 
> > This looks like debugging aid, so:
> > 
> > if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> > 	btrfs_check_qgroup_leak(fs_info);
> > 
> > would be more readable (WARN() pushed to the function).
> 
> We want to check to be executed even on production system, but just less
> noisy (no kernel backtrace dump).
> Just like tree-checker and EXTENT_QUOTA_RESERVED check.

In that case I suggest:

btrfs_err(...);
WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));

as I expect people look for messages before the Oops for more information.

Best Regards,
Michał Mirosław
