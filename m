Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48CF3EB2FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbhHMIzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Aug 2021 04:55:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33418 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbhHMIzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Aug 2021 04:55:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 05A5A1FF9C;
        Fri, 13 Aug 2021 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628844872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKztcLf2d4k8bDI38Cu5+a60cMYobZpnVwo1seklPVQ=;
        b=TMdpIcb9FxXvAwqdRfPVurKmRsmvcfXAi5ngnIm7RbS7CEKx5dCk7XYHQHpjvxwX8Rl+k9
        GhyeBAoD8Ieu/Jx9UJNYIySdnGtiIoCXDKnjt1lLsZ2/rttf103qub7/LaLXFwmiE+oQNo
        +QScgjxgpU7XJvhcX0jLP5aAji6w8ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628844872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKztcLf2d4k8bDI38Cu5+a60cMYobZpnVwo1seklPVQ=;
        b=Q+UMEs0h51TUdPzzuTchpKv2LFtAE3W/PXPPNRkfqDW4GwZoB7RI4ojkXpBhhOX5ruJb1O
        8jE2biAU70DAs+CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE421A3B84;
        Fri, 13 Aug 2021 08:54:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E9E6DA733; Fri, 13 Aug 2021 10:51:38 +0200 (CEST)
Date:   Fri, 13 Aug 2021 10:51:38 +0200
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
Message-ID: <20210813085137.GQ5047@twin.jikos.cz>
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
 <20210812155032.GL5047@twin.jikos.cz>
 <1e0aafb2-9e55-5f64-d347-1765de0560c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0aafb2-9e55-5f64-d347-1765de0560c5@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 13, 2021 at 01:31:25AM +0800, Desmond Cheong Zhi Xi wrote:
> On 12/8/21 11:50 pm, David Sterba wrote:
> > On Thu, Aug 12, 2021 at 11:43:16PM +0800, Desmond Cheong Zhi Xi wrote:
> >> On 12/8/21 6:38 pm, David Sterba wrote:
> >>> On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
> >>>> --- a/fs/btrfs/volumes.c
> >>>> +++ b/fs/btrfs/volumes.c
> >>>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> >>>>    		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> >>>>    			list_del_init(&device->dev_alloc_list);
> >>>>    			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> >>>> +			fs_devices->rw_devices--;
> >>>>    		}
> >>>>    		list_del_init(&device->dev_list);
> >>>>    		fs_devices->num_devices--;
> >>>
> >>> I've hit a crash on master branch with stacktrace very similar to one
> >>> this bug was supposed to fix. It's a failed assertion on device close.
> >>> This patch was the last one to touch it and it matches some of the
> >>> keywords, namely the BTRFS_DEV_STATE_REPLACE_TGT bit that used to be in
> >>> the original patch but was not reinstated in your fix.
> >>>
> >>> I'm not sure how reproducible it is, right now I have only one instance
> >>> and am hunting another strange problem. They could be related.
> >>>
> >>> assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
> >>>
> >>> https://susepaste.org/view/raw/18223056 full log with other stacktraces,
> >>> possibly relatedg
> >>>
> >>
> >> Looking at the logs, it seems that a dev_replace was started, then
> >> suspended. But it wasn't canceled or resumed before the fs devices were
> >> closed.
> >>
> >> I'll investigate further, just throwing some observations out there.
> > 
> > Thanks. I'm testing the patch revert, no crash after first loop, I'll
> > run a few more to be sure as it's not entirely reliable.
> > 
> > Sending the revert is option of last resort as we're approaching end of
> > 5.14 dev cycle and the crash prevents testing (unlike the fuzzer
> > warning).
> > 
> 
> I might be missing something, so any thoughts would be appreciated. But 
> I don't think the assertion in btrfs_close_one_device is correct.
> 
>  From what I see, this crash happens when close_ctree is called while a 
> dev_replace hasn't completed. In close_ctree, we suspend the 
> dev_replace, but keep the replace target around so that we can resume 
> the dev_replace procedure when we mount the root again. This is the call 
> trace:
> 
>    close_ctree():
>      btrfs_dev_replace_suspend_for_unmount();
>      btrfs_close_devices():
>        btrfs_close_fs_devices():
>          btrfs_close_one_device():
>            ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, 
> &device->dev_state));
> 
> However, since the replace target sticks around, there is a device with 
> BTRFS_DEV_STATE_REPLACE_TGT set, and we fail the assertion in 
> btrfs_close_one_device.
> 
> Two options I can think of:
> 
> - We could remove the assertion.
> 
> - Or we could clear the BTRFS_DEV_STATE_REPLACE_TGT bit in 
> btrfs_dev_replace_suspend_for_unmount. This is fine since the bit is set 
> again in btrfs_init_dev_replace if the dev_replace->replace_state is 
> BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED. But this approach strikes me as 
> a little odd because the device is still the replace target when 
> mounting in the future.

The option #2 does not sound safe because the TGT bit is checked in
several places where device list is queried for various reasons, even
without a mounted filesystem.

Removing the assertion makes more sense but I'm still not convinced that
the this is expected/allowed state of a closed device.
