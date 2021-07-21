Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5743D0FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhGUM6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 08:58:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhGUM5I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DD981FEA7;
        Wed, 21 Jul 2021 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626874614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACSOqLjxdKypbguvriIn2aNR3FddUn7knx9Dv2QbmwE=;
        b=n/b1fl3ecyHZMi/6WIbjgf5cls+zJemQ1MOUkGfSdnHaytU9XIQntu0Nxx76h3BnwHIHQ1
        Ik6PEVpV89wDn7XahUFoLRcGmvvoHpdwtFSLRnojtE87LjWLl70r2auHHewAwYQURaVO0U
        0CqrL77M+5kM5XLds90DyZTX1YQz8X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626874614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACSOqLjxdKypbguvriIn2aNR3FddUn7knx9Dv2QbmwE=;
        b=FH1MGv0VUqlII3Qv7nLEnjfyHdjMsKsmnpuQ3t+FpBT4BNp8YQBKXwk7fHRDr+fYoSVw68
        86TtUebrHBXSGmAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 64FC0A3B87;
        Wed, 21 Jul 2021 13:36:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 482F7DA704; Wed, 21 Jul 2021 15:34:13 +0200 (CEST)
Date:   Wed, 21 Jul 2021 15:34:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210721133412.GE19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
 <7ae7a858-9893-c41c-ed96-10651c295087@suse.com>
 <b8fe8fa5-c022-187f-b10d-3f73e668008a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8fe8fa5-c022-187f-b10d-3f73e668008a@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 15, 2021 at 09:11:43PM +0800, Desmond Cheong Zhi Xi wrote:
> On 15/7/21 7:55 pm, Nikolay Borisov wrote:
> > 
> > 
> > On 15.07.21 г. 13:34, Desmond Cheong Zhi Xi wrote:
> >> Syzbot reports a warning in close_fs_devices that happens because
> >> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
> >> on each device.
> >>
> >> This happens when a writeable device is removed in
> >> __btrfs_free_extra_devids, but the rw device count is not decremented
> >> accordingly. So when close_fs_devices is called, the removed device is
> >> still counted and we get an off by 1 error.
> >>
> >> Here is one call trace that was observed:
> >>    btrfs_mount_root():
> >>      btrfs_scan_one_device():
> >>        device_list_add();   <---------------- device added
> >>      btrfs_open_devices():
> >>        open_fs_devices():
> >>          btrfs_open_one_device();   <-------- rw device count ++
> >>      btrfs_fill_super():
> >>        open_ctree():
> >>          btrfs_free_extra_devids():
> >> 	  __btrfs_free_extra_devids();  <--- device removed
> >> 	  fail_tree_roots:
> >> 	    btrfs_close_devices():
> >> 	      close_fs_devices();   <------- rw device count off by 1
> >>
> >> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> >> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> >> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> >> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > 
> > Is there a reliable reproducer from syzbot? Can this be turned into an
> > xfstest?
> > 
> 
> Syzbot has some reliable reproducers here:
> https://syzkaller.appspot.com/bug?id=113d9a01cbe0af3e291633ba7a7a3e983b86c3c0
> 
> Seems like it constructs two images in-memory then mounts them. I'm not 
> sure if that's amenable to be converted into an xfstest?

It would need to be an image from the time the warning is reproduced,
I'm not sure how much timing is also important. But iirc adding raw test
images to fstests was not welcome, so it would have to be a reproducer
and given that the syzkaller source is not human readable I'm not sure
it would be welcome either.

Maybe there's some middle ground when the image is created by mkfs and
filled with the data and then the mount loop is started from shell. But
that means to untangle the C reproducer.
