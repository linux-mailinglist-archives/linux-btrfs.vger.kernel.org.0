Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE9446C4F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 05:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhKFER0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhKFERZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Nov 2021 00:17:25 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2727C061570
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 21:14:44 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id b17so20917062uas.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 21:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gw8ENl+sB0BVoOVlwYE8Chb5kAkqWPI7GfTd6TMyapA=;
        b=dxuEWaB873zU3FZ1HQbZsgBMF0sdFmtiYmleUEXP10z+fvYP6W6yTwgaundy29HErh
         9FvN+gylNJCP/HZ5AYHttjC9b8Pcoo4BtsntVZoeBVXieW4a1vUBMbgiGxOtKyv3jHL2
         kmnHNNuP+pvhez02BpSsE0Npe4GLfMxik9pex+se8ZUxYpEL6BSVXI2lat+PPqUEjUTn
         K6Pj+JvoWhqRKIuFWiQUHigo1h772EYuSXVAjgh9Yeq/kTRsoIG4o0evD51Th9YubY8D
         z16UhRXmiVyrZ8YGszS/n7x8YcUU+17YJ5A5CLdt1zJceRwcNV7g4+ycj7TupqtRcius
         fawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gw8ENl+sB0BVoOVlwYE8Chb5kAkqWPI7GfTd6TMyapA=;
        b=dxE/ZHL1xvOhw/RDgoW3kAvjj6V4dT+1pxgaERPz4blh6zWF05XL1lIYtByzvj4oUo
         uO/HHuaS4s+2Oq5Sw3CfPmb9oRcabjZbOE8A9OFcXIQWTZdQbb/zbpKfoaN+VCn+wWfb
         W+dAzIAIBQZievb3/mCSSVCroPpNUC6VISq0cqSuR6G9/zhg99299OyJvgf2kGnzHUn7
         VLSdhT1Ef7bTzWMW5VOWTK75IqhXhokVDi0ARazN/T5PBAqigQOfYUpmus3dwamszdwS
         W6/VpGLwnNd/C+Z1VZZnLRxm0BLyp2HyDblOa97MLeXLmONqs1y1cSfmWn/Xwqx5So+F
         nenw==
X-Gm-Message-State: AOAM533GusG6jy6quNaVl910iHBiVPJZ6zgL4mYaZBBleThf5uJOf8R6
        ssnW53zUdzQcZ38C7zU4jCrEu6AHNeAV3SYgMfpLzhJH7s4=
X-Google-Smtp-Source: ABdhPJw8UyDvHk7NQsGfjpbHEG9kyzd3pvJuHDjQNuLb6U3bdF/kYUhjm6TL6/00t0vonWVDLN/1c9DBBHl2kdpd82E=
X-Received: by 2002:ab0:378b:: with SMTP id d11mr39443415uav.61.1636172082673;
 Fri, 05 Nov 2021 21:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it> <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it> <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
 <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it> <CAGdWbB5mU-3J0wsha92Ry9HYdH1G7-0H05rza10RVLcKt1QKbQ@mail.gmail.com>
 <cf7399d4-1d41-5223-e633-e90ea4cde9e5@inwind.it> <CAGdWbB5Z_u9eJuVBEe4e8VQBMyCt3vk+dqc+wCxb99u6+26Uow@mail.gmail.com>
In-Reply-To: <CAGdWbB5Z_u9eJuVBEe4e8VQBMyCt3vk+dqc+wCxb99u6+26Uow@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Sat, 6 Nov 2021 00:14:31 -0400
Message-ID: <CAGdWbB7a6yPO59ROgNjzG8ysqevA_Q3HuUhJ4jwd6dSGxhJxeQ@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     devel@roosoft.ltd.uk, Phillip Susi <phill@thesusis.net>,
        kilobyte@angband.pl, kreijack@inwind.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following up on this topic, I came across this github issue today:

[bind entries in fstab are made recursive regardless of options =C2=B7
Issue #1204 =C2=B7 systemd/systemd =C2=B7
GitHub](https://github.com/systemd/systemd/issues/1204)

I think that is the explanation. I will do more testing to confirm.

On Tue, Aug 10, 2021 at 4:36 PM Dave T <davestechshop@gmail.com> wrote:
>
> On Tue, Aug 10, 2021 at 4:17 PM Goffredo Baroncelli <kreijack@inwind.it> =
wrote:
> >
> > On 8/10/21 6:27 PM, Dave T wrote:
> > > On Tue, Aug 10, 2021 at 12:17 PM Goffredo Baroncelli <kreijack@inwind=
.it> wrote:
> > >>
> > >> On 8/10/21 6:03 PM, Dave T wrote:
> > >>> On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwi=
nd.it> wrote:
> > [...]
> > >> What is more interesting is the dependencies between srv-nfs-var-cac=
he-pacman.mount and nfs-server.service. I suspect (but I don't have any pro=
of) that systemd is confused by the tuple {btrfs subvolume, bind mount, nfs=
 dependecies}.
> > >>
> > >> What happens if you restart the nfs-server ?
> > >
> > > As part of this issue, nfs clients have been experiencing slowness an=
d
> > > sometimes hangs. I have restarted the nfs server service a few times
> > > while this issue was happening and it seems to temporarily resolve th=
e
> > > client issues, but I'm not 100% sure because a specific incident will
> > > resolve eventually on its own without any intervention by me. But
> > > future incidences of slowness or temporary hangs are continuing and I
> > > do think this is all related.
> > >
> > > Restarting the nfs server service does not make the nested mounts we
> > > are discussing go away. I have to unwind them with multiple calls to
> > > umount -- although the number of calls is less than the number of
> > > nested mounts, which I find confusing. Typically just 2-3 calls to
> > > umount will unmount a nesting 5-6 deep.
> > >
> > > Clients connect to a number of different nfs shares from this server,
> > > yet none of the others wind up with nested mounts like
> > > srv-nfs-var-cache-pacman.mount . All mounts are configured the same
> > > way, using the same bind mount parameters in fstab.
> > >
> >
> > Unfortunately I don't have any more suggestions..
>
> The replies you have given so far have already helped me understand
> the issue a little better. Thank you.
> >
> > My opinion is that the problem is not related to the btrfs itself, but =
it is more a side effect of the interaction between systemd and btrfs. What=
 about looking to the log ?
>
> Yes, I agree.
>
> >
> > $ sudo journalctl -u  srv-nfs-var-cache-pacman.mount
> >
> > Then check the log near the mount/unmount
>
>     -- Boot 48833b09370b46a4ade0c1979438be90 --
>     Jul 24 22:29:00 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacma=
n...
>     Jul 24 22:29:00 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman=
.
>     -- Boot d11dc578c1c342b3a44bbf7d266c4049 --
>     Jul 25 12:37:31 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacma=
n...
>     Jul 25 12:37:31 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman=
.
>     -- Boot a4e09d4b507c4e4e949f03c3ffe11081 --
>     Jul 25 14:15:33 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacma=
n...
>     Jul 25 14:15:33 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman=
.
>     Jul 25 18:27:56 nfssrvr systemd[1]:
> srv-nfs-var-cache-pacman.mount: Deactivated successfully.
>     Aug 05 11:39:10 nfssrvr systemd[1]:
> srv-nfs-var-cache-pacman.mount: Deactivated successfully.
>
> Those last two lines are my intervention (manually unmounting). I
> don't see anything else of interest to this in the logs.
> >
> > To avoid this problem enterely, what about using a symlink instead of t=
he bind mount ?
> >
> > Something like
> >
> > # rmdir /srv/nfs/var/cache/pacman ; ln -sf /var/cache/pacman /srv/nfs/v=
ar/cache/pacman
>
> As far as I know, that's not a recommended practice for NFS shares. I
> don't know why. I'll look into it. Thanks for the idea.
> >
> >
> > BR
> > GB
> >
> > >>>
> > >>>>
> > >>>> [...]
> > >>>>>
> > >>>>> As mentioned, I have (temporarily) stopped unmounting these volum=
es
> > >>>>> and I just leave them mounted all the time. The logs now look lik=
e
> > >>>>> this:
> > >>>>>
> > >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volu=
mes...
> > >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (=
1 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (=
2 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (=
3 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>
> > >>>> This told another story. It seems that "btrbk" itself already try =
to mount the btrfs subvolume. I understood that it was the systemd unit to =
do that. Could you share the content of btrbk_run.sh ?
> > >>>>
> > >>>
> > >>> # systemctl cat btrbk.service
> > >>> # /usr/lib/systemd/system/btrbk.service
> > >>> [Unit]
> > >>> Description=3Dbtrbk backup
> > >>> Documentation=3Dman:btrbk(1)
> > >>>
> > >>> [Service]
> > >>> Type=3Doneshot
> > >>> ExecStart=3D/usr/bin/btrbk run
> > >>>
> > >>> # /etc/systemd/system/btrbk.service.d/override.conf
> > >>> [Service]
> > >>> ExecStart=3D
> > >>> ExecStart=3D/usr/local/bin/btrbk_run.sh
> > >>>
> > >>>
> > >>> # cat /usr/local/bin/btrbk_run.sh
> > >>> #!/bin/bash
> > >>>
> > >>> /usr/local/bin/btrbk_mount
> > >>>
> > >>> /usr/bin/btrbk --config /etc/btrbk/btrbk.conf run
> > >>>
> > >>> # 2021-08-05 My first troubleshooting step is to disable unmounting
> > >>> these shares.
> > >>> # /usr/local/bin/btrbk-umount
> > >>>
> > >>>
> > >>> # cat /usr/local/bin/btrbk_mount
> > >>> #!/bin/bash
> > >>>
> > >>> btrbk_mount() {
> > >>>
> > >>> echo "mounting btrbk btrtop volumes..."
> > >>>
> > >>> findmnt /mnt/btrtop/root
> > >>> if [[ $? -ne 0 ]]; then \
> > >>>     mount /mnt/btrtop/root
> > >>>     if [[ $? -ne 0 ]]; then \
> > >>>       echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
> > >>>     else
> > >>>       echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
> > >>>     fi
> > >>> else
> > >>>     echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. No=
thing to do."
> > >>> fi
> > >>> findmnt /mnt/btrtop/home
> > >>> if [[ $? -ne 0 ]]; then \
> > >>>     mount /mnt/btrtop/home
> > >>>     if [[ $? -ne 0 ]]; then \
> > >>>       echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
> > >>>     else
> > >>>       echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
> > >>>     fi
> > >>> else
> > >>>     echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. No=
thing to do."
> > >>> fi
> > >>> findmnt /mnt/btrtop/user
> > >>> if [[ $? -ne 0 ]]; then \
> > >>>     mount /mnt/btrtop/user
> > >>>     if [[ $? -ne 0 ]]; then \
> > >>>       echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
> > >>>     else
> > >>>       echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
> > >>>     fi
> > >>> else
> > >>>     echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. No=
thing to do."
> > >>> fi
> > >>>
> > >>> echo "Finished mounting btrbk btrtop volumes."
> > >>>
> > >>> }
> > >>>
> > >>> btrbk_mount
> > >>>
> > >>> # end of file /usr/local/bin/btrbk_mount
> > >>>
> > >>>
> > >>>>
> > >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk bt=
rtop volumes.
> > >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volu=
mes...
> > >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (=
1 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (=
2 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (=
3 of
> > >>>>> 3) was already mounted. Nothing to do.
> > >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk bt=
rtop volumes.
> > >>>>>
> > >>>>>>
> > >>>>>>>
> > >>>>>>> The path /var/cache/pacman is not a subvolume, but it resides o=
n btrfs
> > >>>>>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounte=
d at
> > >>>>>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root=
. This
> > >>>>>>> additional mount operation seems to be causing these nested mou=
nts of
> > >>>>>>> my bind mount for  /srv/nfs/var/cache/pacman .
> > >>>>>>>
> > >>>>>>> P.S. I cannot test without using systemd. (I'm not even sure I
> > >>>>>>> remember how to use a non-systemd distro anymore!)
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> --
> > >>>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.i=
t>
> > >>>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0=
B5
> > >>>>
> > >>>>
> > >>>> --
> > >>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > >>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > >>
> > >>
> > >> --
> > >> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > >> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> >
> >
> > --
> > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
