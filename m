Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA73EA806
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhHLPxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 11:53:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhHLPxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 11:53:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B0261FF5E;
        Thu, 12 Aug 2021 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628783606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2q0A/coQFwqBSuVcyXsF0R7oesMeHAt0aGAIiyJS3Sg=;
        b=Y8UCUtdVkeZZSD/b/zQelqCp4JuS78wwdZMcb9hTkXml99ZbVpbDguA66C399jbylXKMyN
        uoBCaJ3qB7p6pvXjZ9teegJvmNHjyrebMlyUzNHb+geoVnWf8pwRtBZvFzjNz7Bit09O+j
        S0p4174DzhYry4L6J9IgFA8IyQab+b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628783606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2q0A/coQFwqBSuVcyXsF0R7oesMeHAt0aGAIiyJS3Sg=;
        b=bKPzILz34oRvqZbcLC8wu1iU4MBhVamsgVwm3iqEpg9414MmZB6eJ0A/qt3oD+ZZBqqsFW
        7ZwWgOtq5SbgF5DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66933A3F74;
        Thu, 12 Aug 2021 15:53:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D04B7DA733; Thu, 12 Aug 2021 17:50:32 +0200 (CEST)
Date:   Thu, 12 Aug 2021 17:50:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210812155032.GL5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210727071303.113876-1-desmondcheongzx@gmail.com>
 <20210812103851.GC5047@twin.jikos.cz>
 <3c48eec9-590c-4974-4026-f74cafa5ac48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c48eec9-590c-4974-4026-f74cafa5ac48@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 11:43:16PM +0800, Desmond Cheong Zhi Xi wrote:
> On 12/8/21 6:38 pm, David Sterba wrote:
> > On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
> >> When removing a writeable device in __btrfs_free_extra_devids, the rw
> >> device count should be decremented.
> >>
> >> This error was caught by Syzbot which reported a warning in
> >> close_fs_devices because fs_devices->rw_devices was not 0 after
> >> closing all devices. Here is the call trace that was observed:
> >>
> >>    btrfs_mount_root():
> >>      btrfs_scan_one_device():
> >>        device_list_add();   <---------------- device added
> >>      btrfs_open_devices():
> >>        open_fs_devices():
> >>          btrfs_open_one_device();   <-------- writable device opened,
> >> 	                                     rw device count ++
> >>      btrfs_fill_super():
> >>        open_ctree():
> >>          btrfs_free_extra_devids():
> >> 	  __btrfs_free_extra_devids();  <--- writable device removed,
> >> 	                              rw device count not decremented
> >> 	  fail_tree_roots:
> >> 	    btrfs_close_devices():
> >> 	      close_fs_devices();   <------- rw device count off by 1
> >>
> >> As a note, prior to commit cf89af146b7e ("btrfs: dev-replace: fail
> >> mount if we don't have replace item with target device"), rw_devices
> >> was decremented on removing a writable device in
> >> __btrfs_free_extra_devids only if the BTRFS_DEV_STATE_REPLACE_TGT bit
> >> was not set for the device. However, this check does not need to be
> >> reinstated as it is now redundant and incorrect.
> >>
> >> In __btrfs_free_extra_devids, we skip removing the device if it is the
> >> target for replacement. This is done by checking whether device->devid
> >> == BTRFS_DEV_REPLACE_DEVID. Since BTRFS_DEV_STATE_REPLACE_TGT is set
> >> only on the device with devid BTRFS_DEV_REPLACE_DEVID, no devices
> >> should have the BTRFS_DEV_STATE_REPLACE_TGT bit set after the check,
> >> and so it's redundant to test for that bit.
> >>
> >> Additionally, following commit 82372bc816d7 ("Btrfs: make
> >> the logic of source device removing more clear"), rw_devices is
> >> incremented whenever a writeable device is added to the alloc
> >> list (including the target device in btrfs_dev_replace_finishing), so
> >> all removals of writable devices from the alloc list should also be
> >> accompanied by a decrement to rw_devices.
> >>
> >> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> >> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> >> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> >> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> >> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   fs/btrfs/volumes.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 807502cd6510..916c25371658 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> >>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> >>   			list_del_init(&device->dev_alloc_list);
> >>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> >> +			fs_devices->rw_devices--;
> >>   		}
> >>   		list_del_init(&device->dev_list);
> >>   		fs_devices->num_devices--;
> > 
> > I've hit a crash on master branch with stacktrace very similar to one
> > this bug was supposed to fix. It's a failed assertion on device close.
> > This patch was the last one to touch it and it matches some of the
> > keywords, namely the BTRFS_DEV_STATE_REPLACE_TGT bit that used to be in
> > the original patch but was not reinstated in your fix.
> > 
> > I'm not sure how reproducible it is, right now I have only one instance
> > and am hunting another strange problem. They could be related.
> > 
> > assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
> > 
> > https://susepaste.org/view/raw/18223056 full log with other stacktraces,
> > possibly relatedg
> > 
> 
> Looking at the logs, it seems that a dev_replace was started, then 
> suspended. But it wasn't canceled or resumed before the fs devices were 
> closed.
> 
> I'll investigate further, just throwing some observations out there.

Thanks. I'm testing the patch revert, no crash after first loop, I'll
run a few more to be sure as it's not entirely reliable.

Sending the revert is option of last resort as we're approaching end of
5.14 dev cycle and the crash prevents testing (unlike the fuzzer
warning).
