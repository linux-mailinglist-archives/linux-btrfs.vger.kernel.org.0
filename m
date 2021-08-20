Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22CE3F2A78
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhHTLCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:02:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50958 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhHTLCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:02:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FB401FE03;
        Fri, 20 Aug 2021 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629457286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeRjLjwQhRqYl9HoHzlGb6oujq7wKFT0mdf81J1lNx0=;
        b=RJ/Hdaoib0dDB4d1GdtcW3qfzpK/CLYIfXn/gYFFw/BOqbGEXvVYcw6zb0xJ5WfmrON8lP
        ALPaiXPE1LmXFmvWNDkQG1Gvs3wFZWAAHk3IFkzg+0RPEKaaRRBW3S29EuEoK8dm064LT9
        JYwyXAIZKqBlzMUEwOUWgfzz3/jnfKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629457286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeRjLjwQhRqYl9HoHzlGb6oujq7wKFT0mdf81J1lNx0=;
        b=wjYdJtwhWia0lEM7XI7U7xBXdE0VTkqjL1/bBxurEXO9O9dseihR+h9snGQoIB94sWqnNM
        98QpeQF4fI+aUDDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0C561A3B8B;
        Fri, 20 Aug 2021 11:01:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FDECDA730; Fri, 20 Aug 2021 12:58:28 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:58:28 +0200
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
Message-ID: <20210820105828.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210812103851.GC5047@twin.jikos.cz>
 <3c48eec9-590c-4974-4026-f74cafa5ac48@gmail.com>
 <20210812155032.GL5047@twin.jikos.cz>
 <1e0aafb2-9e55-5f64-d347-1765de0560c5@gmail.com>
 <20210813085137.GQ5047@twin.jikos.cz>
 <a5690ae1-28ba-a933-6473-e9c1e5480f0c@gmail.com>
 <20210813103032.GR5047@twin.jikos.cz>
 <89172356-335f-1ca3-d3a2-78fac7ef93fb@gmail.com>
 <20210819173403.GI5047@twin.jikos.cz>
 <e9c5bb00-b609-aff9-fc95-ca1c5b9c2899@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c5bb00-b609-aff9-fc95-ca1c5b9c2899@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 11:09:05AM +0800, Desmond Cheong Zhi Xi wrote:
> On 20/8/21 1:34 am, David Sterba wrote:
> > On Fri, Aug 20, 2021 at 01:11:58AM +0800, Desmond Cheong Zhi Xi wrote:
> >>>>> The option #2 does not sound safe because the TGT bit is checked in
> >>>>> several places where device list is queried for various reasons, even
> >>>>> without a mounted filesystem.
> >>>>>
> >>>>> Removing the assertion makes more sense but I'm still not convinced that
> >>>>> the this is expected/allowed state of a closed device.
> >>>>>
> >>>>
> >>>> Would it be better if we cleared the REPLACE_TGT bit only when closing
> >>>> the device where device->devid == BTRFS_DEV_REPLACE_DEVID?
> >>>>
> >>>> The first conditional in btrfs_close_one_device assumes that we can come
> >>>> across such a device. If we come across it, we should properly reset it.
> >>>>
> >>>> If other devices has this bit set, the ASSERT will still catch it and
> >>>> let us know something is wrong.
> >>>
> >>> That sounds great.
> >>>
> >>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>> index 70f94b75f25a..a5afebb78ecf 100644
> >>>> --- a/fs/btrfs/volumes.c
> >>>> +++ b/fs/btrfs/volumes.c
> >>>> @@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
> >>>>                    fs_devices->rw_devices--;
> >>>>            }
> >>>>     
> >>>> +       if (device->devid == BTRFS_DEV_REPLACE_DEVID)
> >>>> +               clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
> >>>> +
> >>>>            if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> >>>>                    fs_devices->missing_devices--;
> >>>
> >>> I'll do a few test rounds, thanks.
> >>
> >> Just following up. Did that resolve the issue or is further
> >> investigation needed?
> > 
> > The fix seems to work, I haven't seen the assertion fail anymore,
> > incidentally the crash also stopped to show up on an unpatched branch.
> > 
> 
> Sounds good, thanks for the update. If there's anything else I can help 
> with, please let me know.

So are you going to send the patch with the fix?
