Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F917D05B
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Mar 2020 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGVxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Mar 2020 16:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCGVxe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Mar 2020 16:53:34 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EE22073C;
        Sat,  7 Mar 2020 21:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583618013;
        bh=B4b7WxJELJF7J22jOK5yaznKHwPE1tN5KsKh1HLsZJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQVi0oODaJBHU0YsHHEYGXuh1j+wWxKs+8LS9mi6nK9hjPjjePD6gO48z0vGvtfSH
         dqZlBwLZBCFE2jccLbDZILaabLcyjE02UV3uutxz6LjVCV/Ptmuddf7rdKb2jMStOW
         x+779S5Z8H8vBFr/PLd2Mv+nH3gxNaPwHDcG8ogM=
Date:   Sat, 7 Mar 2020 13:53:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
Message-ID: <20200307215332.GR15444@sol.localdomain>
References: <00000000000096009b056df92dc1@google.com>
 <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local>
 <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
 <20191205113838.GC11438@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205113838.GC11438@Johanness-MacBook-Pro.local>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 12:38:38PM +0100, Johannes Thumshirn wrote:
> On Thu, Dec 05, 2019 at 11:07:27AM +0100, Dmitry Vyukov wrote:
> > The correct syntax would be (no dash + colon):
> > 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > close_fs_devices
> 
> Ah ok, thanks.
> 
> Although syzbot already said it can't test because it has no reproducer.
> Anyways good to know for future reports.
> 
> Byte,
> 	Johannes

Looks like there was a fix for this merged:

	commit 321f69f86a0fc40203b43659c3a39464f15c2ee9
	Author: Johannes Thumshirn <jthumshirn@suse.de>
	Date:   Wed Dec 4 14:36:39 2019 +0100

	    btrfs: reset device back to allocation state when removing

So telling syzbot:

#syz fix: btrfs: reset device back to allocation state when removing

In the future, please use the Reported-by line that syzbot suggested in its
original mail, so that bugs get automatically closed.
