Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B73E846C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhHJUgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhHJUgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 16:36:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF1C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:36:18 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v10-20020a9d604a0000b02904fa9613b53dso615030otj.6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieLbYwfoT9GlatJP6aIXsTNGdQhcXw4rmKQ3PbDgYus=;
        b=I0HTEBNH5EJYx/tSwWpOwVTeOvjnG5lyXzJZsRPeUTr0Ahgnv2F4JlcOdiEfD9PHKH
         ypzrOhhW0au3IEtguP3H4zUVqKyFaqhn94v5FHkj83mmQlyLq2oIJqtwcDnRPAXmD0ry
         57MB0hSLKre1sYkheyT0S26kRCg2ukOZ5qupzjSxsAOZZV7h1CV8XC/d60nfCxI0r3vi
         36/7NI1OXaTPYWqnf0qXFfA0Ua6CKe58oyfH7hDKliCLiNtLrMHGZefEJlB5qFr6vcJm
         eAsDDtMz0yzRyth4S/ndfeIFEbZSTLvmnE9G2vjJLbbTVCfFkFB4gOjNog2oW3PqO35N
         3a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieLbYwfoT9GlatJP6aIXsTNGdQhcXw4rmKQ3PbDgYus=;
        b=puNGx8nFCf8tj97MmYvcT254mz+HtzBUy0D6tlf2HXjywezC4ztfOzGCMIygBjJYHI
         bThu4wDovtPDqa8FVUrn64bZm8LLWmH2+xxbAq8FRKTLSIlmmdAy90yaDkAs5bIClHJB
         hfvg+MFAb3k+0up0C3uw8PWeRr7rdZ+Hw72ccFm88HaX9/lJszYEJyslwKcoumxkEEI6
         jp3uMieeXkIHI7ysRKZj3Q2pmMq9Eknn6kmSTgXiy/WmQ56Hu/OBtRs7rJXY870dYx2Y
         P05t7qP3bNiT3/E1ua7uzXzezyHaDNFohUlE2+26/YFpX15Xb4Esm3eyIE4n7S8oF8Xi
         daZQ==
X-Gm-Message-State: AOAM530FCfNw2If1mvJE92CgUiWygG+tSmQhGR1kVjohH8cHbsL6+FA5
        BAJrpAP8i8HLd8wIRD2X/aKmewhx0zz76YZPN3Y=
X-Google-Smtp-Source: ABdhPJw252hYXaj0ee5FwHtBchb566mixhU3Q8ucqIYaLA2bUnT+AnUWqHqN7bcFD2nIQ5d2OupYJ0VWy01ad7NwuGY=
X-Received: by 2002:a05:6830:438b:: with SMTP id s11mr22786176otv.133.1628627777987;
 Tue, 10 Aug 2021 13:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it> <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it> <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
 <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it> <CAGdWbB5mU-3J0wsha92Ry9HYdH1G7-0H05rza10RVLcKt1QKbQ@mail.gmail.com>
 <cf7399d4-1d41-5223-e633-e90ea4cde9e5@inwind.it>
In-Reply-To: <cf7399d4-1d41-5223-e633-e90ea4cde9e5@inwind.it>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 10 Aug 2021 16:36:07 -0400
Message-ID: <CAGdWbB5Z_u9eJuVBEe4e8VQBMyCt3vk+dqc+wCxb99u6+26Uow@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     kreijack@inwind.it
Cc:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 4:17 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 8/10/21 6:27 PM, Dave T wrote:
> > On Tue, Aug 10, 2021 at 12:17 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >>
> >> On 8/10/21 6:03 PM, Dave T wrote:
> >>> On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> [...]
> >> What is more interesting is the dependencies between srv-nfs-var-cache-pacman.mount and nfs-server.service. I suspect (but I don't have any proof) that systemd is confused by the tuple {btrfs subvolume, bind mount, nfs dependecies}.
> >>
> >> What happens if you restart the nfs-server ?
> >
> > As part of this issue, nfs clients have been experiencing slowness and
> > sometimes hangs. I have restarted the nfs server service a few times
> > while this issue was happening and it seems to temporarily resolve the
> > client issues, but I'm not 100% sure because a specific incident will
> > resolve eventually on its own without any intervention by me. But
> > future incidences of slowness or temporary hangs are continuing and I
> > do think this is all related.
> >
> > Restarting the nfs server service does not make the nested mounts we
> > are discussing go away. I have to unwind them with multiple calls to
> > umount -- although the number of calls is less than the number of
> > nested mounts, which I find confusing. Typically just 2-3 calls to
> > umount will unmount a nesting 5-6 deep.
> >
> > Clients connect to a number of different nfs shares from this server,
> > yet none of the others wind up with nested mounts like
> > srv-nfs-var-cache-pacman.mount . All mounts are configured the same
> > way, using the same bind mount parameters in fstab.
> >
>
> Unfortunately I don't have any more suggestions..

The replies you have given so far have already helped me understand
the issue a little better. Thank you.
>
> My opinion is that the problem is not related to the btrfs itself, but it is more a side effect of the interaction between systemd and btrfs. What about looking to the log ?

Yes, I agree.

>
> $ sudo journalctl -u  srv-nfs-var-cache-pacman.mount
>
> Then check the log near the mount/unmount

    -- Boot 48833b09370b46a4ade0c1979438be90 --
    Jul 24 22:29:00 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacman...
    Jul 24 22:29:00 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman.
    -- Boot d11dc578c1c342b3a44bbf7d266c4049 --
    Jul 25 12:37:31 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacman...
    Jul 25 12:37:31 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman.
    -- Boot a4e09d4b507c4e4e949f03c3ffe11081 --
    Jul 25 14:15:33 nfssrvr systemd[1]: Mounting /srv/nfs/var/cache/pacman...
    Jul 25 14:15:33 nfssrvr systemd[1]: Mounted /srv/nfs/var/cache/pacman.
    Jul 25 18:27:56 nfssrvr systemd[1]:
srv-nfs-var-cache-pacman.mount: Deactivated successfully.
    Aug 05 11:39:10 nfssrvr systemd[1]:
srv-nfs-var-cache-pacman.mount: Deactivated successfully.

Those last two lines are my intervention (manually unmounting). I
don't see anything else of interest to this in the logs.
>
> To avoid this problem enterely, what about using a symlink instead of the bind mount ?
>
> Something like
>
> # rmdir /srv/nfs/var/cache/pacman ; ln -sf /var/cache/pacman /srv/nfs/var/cache/pacman

As far as I know, that's not a recommended practice for NFS shares. I
don't know why. I'll look into it. Thanks for the idea.
>
>
> BR
> GB
>
> >>>
> >>>>
> >>>> [...]
> >>>>>
> >>>>> As mentioned, I have (temporarily) stopped unmounting these volumes
> >>>>> and I just leave them mounted all the time. The logs now look like
> >>>>> this:
> >>>>>
> >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
> >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>
> >>>> This told another story. It seems that "btrbk" itself already try to mount the btrfs subvolume. I understood that it was the systemd unit to do that. Could you share the content of btrbk_run.sh ?
> >>>>
> >>>
> >>> # systemctl cat btrbk.service
> >>> # /usr/lib/systemd/system/btrbk.service
> >>> [Unit]
> >>> Description=btrbk backup
> >>> Documentation=man:btrbk(1)
> >>>
> >>> [Service]
> >>> Type=oneshot
> >>> ExecStart=/usr/bin/btrbk run
> >>>
> >>> # /etc/systemd/system/btrbk.service.d/override.conf
> >>> [Service]
> >>> ExecStart=
> >>> ExecStart=/usr/local/bin/btrbk_run.sh
> >>>
> >>>
> >>> # cat /usr/local/bin/btrbk_run.sh
> >>> #!/bin/bash
> >>>
> >>> /usr/local/bin/btrbk_mount
> >>>
> >>> /usr/bin/btrbk --config /etc/btrbk/btrbk.conf run
> >>>
> >>> # 2021-08-05 My first troubleshooting step is to disable unmounting
> >>> these shares.
> >>> # /usr/local/bin/btrbk-umount
> >>>
> >>>
> >>> # cat /usr/local/bin/btrbk_mount
> >>> #!/bin/bash
> >>>
> >>> btrbk_mount() {
> >>>
> >>> echo "mounting btrbk btrtop volumes..."
> >>>
> >>> findmnt /mnt/btrtop/root
> >>> if [[ $? -ne 0 ]]; then \
> >>>     mount /mnt/btrtop/root
> >>>     if [[ $? -ne 0 ]]; then \
> >>>       echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
> >>>     else
> >>>       echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
> >>>     fi
> >>> else
> >>>     echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. Nothing to do."
> >>> fi
> >>> findmnt /mnt/btrtop/home
> >>> if [[ $? -ne 0 ]]; then \
> >>>     mount /mnt/btrtop/home
> >>>     if [[ $? -ne 0 ]]; then \
> >>>       echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
> >>>     else
> >>>       echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
> >>>     fi
> >>> else
> >>>     echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. Nothing to do."
> >>> fi
> >>> findmnt /mnt/btrtop/user
> >>> if [[ $? -ne 0 ]]; then \
> >>>     mount /mnt/btrtop/user
> >>>     if [[ $? -ne 0 ]]; then \
> >>>       echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
> >>>     else
> >>>       echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
> >>>     fi
> >>> else
> >>>     echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. Nothing to do."
> >>> fi
> >>>
> >>> echo "Finished mounting btrbk btrtop volumes."
> >>>
> >>> }
> >>>
> >>> btrbk_mount
> >>>
> >>> # end of file /usr/local/bin/btrbk_mount
> >>>
> >>>
> >>>>
> >>>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop volumes.
> >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
> >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
> >>>>> 3) was already mounted. Nothing to do.
> >>>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop volumes.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> The path /var/cache/pacman is not a subvolume, but it resides on btrfs
> >>>>>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
> >>>>>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
> >>>>>>> additional mount operation seems to be causing these nested mounts of
> >>>>>>> my bind mount for  /srv/nfs/var/cache/pacman .
> >>>>>>>
> >>>>>>> P.S. I cannot test without using systemd. (I'm not even sure I
> >>>>>>> remember how to use a non-systemd distro anymore!)
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >>>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> >>>>
> >>>>
> >>>> --
> >>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> >>
> >>
> >> --
> >> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
