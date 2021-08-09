Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED95D3E4DAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhHIUQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIUQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 16:16:09 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025DC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Aug 2021 13:15:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so19355934otu.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Aug 2021 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNzzQaP2wE9LzIAKQAuQat9PjXgwxZ4CQ133gbYyORo=;
        b=UbRMS/q0T38Uh/sURIGRT6A7fPStOiyDHBqjQ3luwoalt1BI2sdX3p2/N/+1gL/PCy
         cBm0tcXpUPrG6rXkAySsAvmAHGzKRrQNdnSas3zzxBCE0vzYc3n3hydrZ+Iv3iLKqi1z
         7aoKYOPEmC6SaSZXkHCX3pWT2bEMnu4P91IyfdkQ+Uj4rsmVunSTyc54+PIUhyru9rFq
         64PjboB93KW2BY2Gs3dbcKFDMde8uBq8fAiBzFIJRhkMX0KDWIIYe0e5ZIewjCB/aoo0
         7UwTrbmKAeXH+w5ciNLCBWthH8EdBhjfz9jfvHh4wP5WLcoXroCkMXOCWPHEj8nNf3OX
         9+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNzzQaP2wE9LzIAKQAuQat9PjXgwxZ4CQ133gbYyORo=;
        b=DE+z0HA+WGBrTntiwN5Ln8ktFc6DJOujhDMEdnXA5fYZxVMvEI42c5wougor+7PSwv
         1izLgCYeH5vxfPZoKGH+bt4hy0DolFYSfq3BjV4U4a72nbcVrmq6ELA3yefyJ0oJboph
         mK5ZwF9HrhQ2qBdhgE94aPImOjMykzmbonO3amV1/Sw9ZKPTTjHehwFX7ram8oht0hQJ
         /UFfuSqwsieaAKRlFfMnGa+I1f9PgC56pzyvZXXSQEmgvQdjVkKVKbxrxIUjcD2lTv2g
         czU4mVLRyr/H0XONyd2bPHPfY0OJsSZG5WwZ3GdbwpBSiJ7Pmy/zgW5cSPdmnDHfG6TI
         8lHg==
X-Gm-Message-State: AOAM5332lG/yep6YnU5+7R6Ec/5NxXVZwd+pRLs77Jfls+oskPCGFMdo
        1+ms35tm9BU0ZBDNRy7FZB2DDKaU4VRNBgSap3s=
X-Google-Smtp-Source: ABdhPJxDlt5AMqnjrzPJNvzPe9GIHYg/xvNVg0y7Y6r7FyiwdJvkI1ZR7XVGhyqqBG/2deoGF2fycuvn4utFn3wAOko=
X-Received: by 2002:a9d:74d4:: with SMTP id a20mr5119632otl.211.1628540147142;
 Mon, 09 Aug 2021 13:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com> <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it>
In-Reply-To: <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it>
From:   Dave T <davestechshop@gmail.com>
Date:   Mon, 9 Aug 2021 16:15:36 -0400
Message-ID: <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     kreijack@inwind.it
Cc:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 9, 2021 at 3:29 PM Goffredo Baroncelli <kreijack@libero.it> wro=
te:
>
> On 8/8/21 9:48 PM, Dave T wrote:
> > On Sun, Aug 8, 2021 at 8:10 AM <devel@roosoft.ltd.uk> wrote:
> >>
> >> On 05/08/2021 17:46, Dave T wrote:
> [...]
> >>
> >> Try mounting the subvolume with it's subvolume ID. System only generat=
es
> >> unit files from the fstab it does not follow them , so if you are vagu=
e
> >> in your fstab the systemd unit files will also be vague.
> >
> > Thank you for the tip. I appreciate your interest in my issue.
> > However, I don't fully understand what to change.
>
> I think that Alexander is suggesting to add something like ',subvolid=3D5=
' to the line of fstab where /mnt/btrtop/root is mounted.

I see. Thank you (and Alexander). I will add that! EDIT: I just added
it and tested mounting, umounting. It seems to work exactly the same
as previously. findmnt now reports:

=E2=94=9C=E2=94=80/mnt/btrtop/root                       /dev/mapper/rootlu=
ks
                               btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D5,subvol=3D/

>
> I add that if it is a systemd bug, it would help to look at the .mount fi=
les generated by systemd:
>
> $ sudo ls /run/systemd/generator/*.mount
>
> Can you share the content of the  systemd units where you ask to mount '/=
mnt/btrtop/root' ? It could help the diagnose.
>
Thank you. Good tip. I had not looked at those files before. Here are
the generator files (before my change to add ,subvolid=3D5).

# cat /run/systemd/generator/-.mount
# Automatically generated by systemd-fstab-generator
[Unit]
Documentation=3Dman:fstab(5) man:systemd-fstab-generator(8)
SourcePath=3D/etc/fstab
Before=3Dlocal-fs.target
After=3Dblockdev@dev-disk-by\x2duuid-28D099A\x2d49D92\x2d4487C\x2d48113\x2d=
4A231CAD0EEF2.target
[Mount]
Where=3D/
What=3D/dev/disk/by-uuid/28D099A-9D92-487C-8113-A231CAD0EEF2
Type=3Dbtrfs
Options=3Drw,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3D/@btrto=
p/snapshot



# cat /run/systemd/generator/mnt-btrtop-root.mount
# Automatically generated by systemd-fstab-generator
[Unit]
Documentation=3Dman:fstab(5) man:systemd-fstab-generator(8)
SourcePath=3D/etc/fstab
After=3Dblockdev@dev-disk-by\x2duuid-28D099A\x2d49D92\x2d4487C\x2d48113\x2d=
4A231CAD0EEF2.target
[Mount]
Where=3D/mnt/btrtop/root
What=3D/dev/disk/by-uuid/28D099A-9D92-487C-8113-A231CAD0EEF2
Type=3Dbtrfs
Options=3Dnoauto,nofail,rw,noatime,nodiratime,compress=3Dlzo,space_cache




# cat /run/systemd/generator/srv-nfs-var-cache-pacman.mount
# Automatically generated by systemd-fstab-generator
[Unit]
Documentation=3Dman:fstab(5) man:systemd-fstab-generator(8)
SourcePath=3D/etc/fstab
Before=3Dlocal-fs.target
[Mount]
Where=3D/srv/nfs/var/cache/pacman
What=3D/var/cache/pacman
Type=3Dnone
Options=3Dbind


> And finally, what happens if you mount/unmount from command line (e.g. ma=
nually) /mnt/btrtop/root ?

It works as expected. It mounts and unmounts and there are no errors
and the extra nested mounting doesn't occur. I just ran through a
testing cycle of multiple mounts and unmounts to verify this.

Also, in recent days I stopped mounting and umounting /mnt/btrtop/root
and just left it mounted all the time. However, when checking today, I
still found a nested mount:

=E2=94=9C=E2=94=80/srv/nfs/var/cache/pacman
=E2=94=82
=E2=94=82 =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman


>
> BR
>
> > Here are the relevant lines from my fstab. I added line numbers
> > because the lines will get wrapped in email.  I don't see what part of
> > this is vague:
> >
> > 1. # cat /etc/fstab
> > 2. UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
> > rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3D/@btrtop/snap=
shot
> > 0 0
> > 3. UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
> > noauto,nofail,rw,noatime,nodiratime,compress=3Dlzo,space_cache    0 0
> > 4. /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  =
0 0
>
> I don't know if it matters, but why you set as 'none' the filesystem type=
 ? However according to askubuntu/stackoverflow it seem the right thing to =
do...

That is the way I have always done bind mounts.

I can send more complete systemd logs if needed, but this is what it
looked like hourly (before I stopped unmounting):

Aug 03 15:00:12 systemd[1]: mnt-btrtop-root.mount: Deactivated successfully=
.
Aug 03 16:00:06 btrbk_run.sh[2376252]: mounting btrbk btrtop volumes...
Aug 03 16:00:06 btrbk_run.sh[2376252]: OK: mounted [/mnt/btrtop/root] (1 of=
 3)
Aug 03 16:00:06 btrbk_run.sh[2376252]: OK: mounted [/mnt/btrtop/home] (2 of=
 3)
Aug 03 16:00:06 btrbk_run.sh[2376252]: OK: mounted mount
[/mnt/btrtop/user] (3 of 3)
Aug 03 16:00:06 btrbk_run.sh[2376252]: Finished mounting btrbk btrtop volum=
es.
Aug 03 16:00:11 btrbk_run.sh[2376356]: un-mounting btrbk btrtop volumes...
Aug 03 16:00:11 btrbk_run.sh[2376356]: OK: un-mounted
[/mnt/btrtop/user] (1 of 3)
Aug 03 16:00:11 systemd[1]: mnt-btrtop-user.mount: Deactivated successfully=
.
Aug 03 16:00:11 btrbk_run.sh[2376356]: OK: un-mounted
[/mnt/btrtop/home] (2 of 3)
Aug 03 16:00:11 systemd[1]: mnt-btrtop-home.mount: Deactivated successfully=
.
Aug 03 16:00:11 btrbk_run.sh[2376356]: OK: un-mounted
[/mnt/btrtop/root] (3 of 3)
Aug 03 16:00:11 btrbk_run.sh[2376356]: Finished un-mounting btrbk
btrtop volumes.
Aug 03 16:00:11 systemd[1]: mnt-btrtop-root.mount: Deactivated successfully=
.
Aug 03 17:00:06 btrbk_run.sh[2387185]: mounting btrbk btrtop volumes...
Aug 03 17:00:06 btrbk_run.sh[2387185]: OK: mounted [/mnt/btrtop/root] (1 of=
 3)
Aug 03 17:00:06 btrbk_run.sh[2387185]: OK: mounted [/mnt/btrtop/home] (2 of=
 3)
Aug 03 17:00:06 btrbk_run.sh[2387185]: OK: mounted mount
[/mnt/btrtop/user] (3 of 3)
Aug 03 17:00:06 btrbk_run.sh[2387185]: Finished mounting btrbk btrtop volum=
es.
Aug 03 17:00:10 btrbk_run.sh[2387275]: un-mounting btrbk btrtop volumes...
Aug 03 17:00:10 btrbk_run.sh[2387275]: OK: un-mounted
[/mnt/btrtop/user] (1 of 3)
Aug 03 17:00:10 systemd[1]: mnt-btrtop-user.mount: Deactivated successfully=
.
Aug 03 17:00:10 btrbk_run.sh[2387275]: OK: un-mounted
[/mnt/btrtop/home] (2 of 3)
Aug 03 17:00:10 systemd[1]: mnt-btrtop-home.mount: Deactivated successfully=
.
Aug 03 17:00:10 btrbk_run.sh[2387275]: OK: un-mounted
[/mnt/btrtop/root] (3 of 3)
Aug 03 17:00:10 btrbk_run.sh[2387275]: Finished un-mounting btrbk
btrtop volumes.
Aug 03 17:00:10 systemd[1]: mnt-btrtop-root.mount: Deactivated successfully=
.
Aug 03 18:00:06 btrbk_run.sh[2398488]: mounting btrbk btrtop volumes...

As mentioned, I have (temporarily) stopped unmounting these volumes
and I just leave them mounted all the time. The logs now look like
this:

Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
3) was already mounted. Nothing to do.
Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
3) was already mounted. Nothing to do.
Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
3) was already mounted. Nothing to do.
Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop volum=
es.
Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
3) was already mounted. Nothing to do.
Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
3) was already mounted. Nothing to do.
Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
3) was already mounted. Nothing to do.
Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop volum=
es.

>
> >
> > The path /var/cache/pacman is not a subvolume, but it resides on btrfs
> > subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
> > "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
> > additional mount operation seems to be causing these nested mounts of
> > my bind mount for  /srv/nfs/var/cache/pacman .
> >
> > P.S. I cannot test without using systemd. (I'm not even sure I
> > remember how to use a non-systemd distro anymore!)
> >
>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
