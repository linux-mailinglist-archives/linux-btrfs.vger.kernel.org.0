Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2623CAF6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 00:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGOWwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 18:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGOWwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 18:52:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1BC06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 15:49:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w127so8583468oig.12
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJyJeIfP0FTzpICn7zS4idNx8UaUpqZ2iejzyr1BxLo=;
        b=obxMwyFutFhXcUVLD2xBFXR1N1IGfFOFoB1ET7Ir4l/weS6/RlrUpHOBehBRtTuBM2
         MGz9jSFJEmcagbPkRAbZoiT2g1mI/L9949B2kDVqxL+5zb1SnSFlO43PK6RPEFVcae1v
         fWwKHDGsY9eAG6Ntu1ukoWHLiwQbFtyBFSkCF8BkP/tCcXs5HE4vRQ40URZDiNwiDrzP
         3kAzIoMHUtQWZBydAzevmUoLr69Ksb9rF+SjeKNdlz44sV2rgbXE7HkLCSA/XPxShWr6
         jPmy3lFzr7o5Q8eCYrWrRrxPplR/Lpwkdsd1pNFL1jsTJ1CuShqnxHfV1k9DHrv/R0G4
         Ye1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJyJeIfP0FTzpICn7zS4idNx8UaUpqZ2iejzyr1BxLo=;
        b=Zg++h0aAHTmSoqQU+uc/WfDnDl6awpAqit4jkyBkq0HIuo3EON/pZ9u+J/tcTrtzHM
         16xGNuzAgQRpaX9L8LeV3unK7Ki/lcwkV8HvqZqLOYqTpAW4qpn+ZQll1ueIkkw30jOH
         fYHzcc479bFeXXUWPSQqJ54Y4omRxjwy2R0Xxzyu0bUTO6/+9RC8p2ufQTXPEltyhjEV
         z3sFDTn+o21T1AOXaQrWR9k53E/DyHK8X48oYFAC6AjtjhiHQapQ0yxDqlaDIHHl21qg
         zzWtSqsKeKH5FaOUenbGoHaeFHZ6o8pMZ5kfflWuC/CL+rRbwEhggctH8MoDcR44rKYo
         PaNQ==
X-Gm-Message-State: AOAM531EvL5MOHYUZ4hFUFlcVRNEZSrCpVIeB24da0b+a/PPmnozRLiT
        eC26Fn2ET9ICz2p6LQXMtaJwnnnQoL2Q8eD/esjI0L4iUAk=
X-Google-Smtp-Source: ABdhPJw95qPcgOKZbcLfd0160VR0a+qOz7MY6973JhH91R/NFlLFbdJNRIVMcZYUKY39qtaZf7i35wsjW1l+hu6TbkQ=
X-Received: by 2002:a05:6808:130f:: with SMTP id y15mr9619565oiv.26.1626389390357;
 Thu, 15 Jul 2021 15:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com> <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
In-Reply-To: <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 15 Jul 2021 18:49:39 -0400
Message-ID: <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> OK, lowmem mode indeed did a much better job.
>
> This is a very strange bug.
>
> This means:
>
> - The compressed extent doesn't have csum
>    Which shouldn't be possible for recent kernels.
>
> - The compressed extent exists for inode which has NODATASUM flag
>    Not possible again for recent kernels.
>
> But IIRC there are old kernels allowing such compression + nodatasum.
>
> I guess that's the reason why you got EIO when reading it.
>
> When we failed to find csum, we just put 0x00 as csum, and then when you
> read the data, it's definitely going to cause csum mismatch and nothing
> get read out.
>
> This can be worked around by recent "rescue=idatacsums" mount option.
>
> But to me, this really looks like some old fs, with some inodes created
> by older kernels.

I'm running:
kernel version 5.12.15-arch1-1 (linux@archlinux)

I've been running arch + btrfs since 2014. I keep arch linux fully
updated. I'm running new kernels and new btrfs progs. However, I
created this filesystem around 2014.

Is there an option to "update" my BTRFS filesystem? Is that even a thing?

I have multiple devices running on BTRFS filesystems created around
2014 to 2016. Are those all in danger of having some problems now?
BTRFS has been mostly problem-free for me since before 2014. I do
regular balance and scrubs. However, I'm getting worried about my data
now...

I hope I do not need to backup every device, recreate the filesystems,
and restore them. That would be weeks of work and I'm already
overworked... but losing data would be worse.

BTW, even my backup disks run on BTRFS filesystems that were created years ago.

> > Are any of these options appropriate?
> >
> > -  btrfs rescue chunk-recover /dev/mapper/xyz
>
> Definite no.
>
> Any rescue command should only be used when some developer suggested.

Thank you for reminding me! There's a lot of bad BTRFS advice on all
the various forums, and it is easy to be influenced by it when you are
a casual user like me.


> > - btrfs check --repair --init-csum-tree /dev/mapper/xyz
>
> This may solve the read error, but we will still report the NODATACSUM
> problem for the compressed extent.
>
> Have you tried to remove the NODATASUM option for those involved inodes?

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
says:
Note: If compression is enabled, nodatacow and nodatasum are disabled.

My mount options are:
rw,autodefrag,noatime,nodiratime,compress=lzo,space_cache,subvol=xyz

Do I understand it correctly? My compression option should already
"remove the NODATASUM".

>
> If it's possible to remove NODATASUM for those inodes, then
> --init-csum-tree should be able to solve the problem.

What do you recommend now?
