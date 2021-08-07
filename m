Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EE3E33AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Aug 2021 08:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhHGGAr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Aug 2021 02:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhHGGAr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Aug 2021 02:00:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969CCC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 23:00:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c137so18815255ybf.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wGB+/asJSPoc41ofj2ZnKjyZPjMEZafRbIoq2U+2BUs=;
        b=M3PqYR/R4B+2vtxotDZRVFkuQ/Snoluz5v+coU6P5MsptgKz/8TmNVmltF0BG/6yor
         r2WkGDULXeoJLkRUX9AS/WZyjj9nH6qDASwRQM+owfUUEany9aXKYn2QxfqMlm9cXZ/n
         leN/jXf1S9Pvb1O0LFFTYUMHy6bQHvNXM7CkKtk76LN4sVJ5ou0XNMsX+BrYCTJltnKd
         CLfRfXdTwG24pYlS2DXPtzLT/FzU5mQLyFUNavmDDmLY1uaoY8cAAPuXSVbq4+e6la15
         bNHr0wZntnfu167YMqxL1TjyGuaYV7iIP3YL4qQzLP+qaIA2Q6+5RqdoKMuO5vAokQeX
         Duzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wGB+/asJSPoc41ofj2ZnKjyZPjMEZafRbIoq2U+2BUs=;
        b=KqlnFEu/XlMLjSgOLuPj9dqXCVmpiHGeu4Dk9BJpHgYq13EkNLL64cr44DOsGYewpv
         mcvNjxCfxzCgi1HXI7XElGuuMCnMM8zJKJcOx6QiRaquHStcwYQzEXWt/2XloAYlOilw
         KWxo1FBxpWM+qyu+uhs0bTVcaFGI1iYErOCL2SvQVV+J6dnQrV4ANI+flio9J8ZjxEdD
         85TYhmKr0jRHkx/ovrTY13i4s+z1uBUCLALLlZv/0nn11sGBFwG1UvIhNh0pmmXQZDna
         qtK1lnGFavAwchcSevCgVwjwvsUlkCbN3EZpZSe02aJbuXfrsr4SjMFRW+HyZA94feLT
         lzYA==
X-Gm-Message-State: AOAM533j/PsocDDZuimfk8XpC0ai+sowohVaisHM4+0AORFBs0CFvtLJ
        +gMcg8Oh3ehBT2buXY8pxlb26vePCbgKaQmeeec=
X-Google-Smtp-Source: ABdhPJwjnljRM8D4jM89tKg361yTLQx6sSiusb222IK2kqKpPMgyCGUPaGAD2AOcGkQohESHWV4ZIRTBvkSrB1VOc+k=
X-Received: by 2002:a25:db89:: with SMTP id g131mr17510539ybf.302.1628316028649;
 Fri, 06 Aug 2021 23:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XPOB7xPibhbRaUrJ3fJUvH1m=9wVY-yA_Ytj6hXW0cqXA@mail.gmail.com>
 <30a749de-8228-05ad-13bc-15d6ac010e40@gmx.com>
In-Reply-To: <30a749de-8228-05ad-13bc-15d6ac010e40@gmx.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Sat, 7 Aug 2021 14:00:17 +0800
Message-ID: <CAFcO6XO5TC5sEo-C9JGC75JkNAzkOSSLA3a=bwQqXFFbRTZ7Gw@mail.gmail.com>
Subject: Re: A null-ptr-dereference bug in btrfs_rm_device in fs/btrfs/volumes.c
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, please do.

Regards,
 butt3rflyh4ck.

On Fri, Aug 6, 2021 at 5:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/8/6 =E4=B8=8B=E5=8D=885:52, butt3rflyh4ck wrote:
> > Hello, there is a null pointer dereference bug in the btrfs_rm_device
> > function in fs/btrfs/volumes.c.
> > When a user invokes a BTRFS_IOC_RM_DEV_V2 ioctl to remove a volume devi=
ce,
> > it would call btrfs_ioctl_rm_dev_v2 function to implement. And
> > btrfs_ioctl_rm_dev_v2 would call btrfs_rm_device,
> > if the id of the volume device is illegal, it would trigger a
> > null-ptr-deref bug to cause DoS.
> > Fortunately, invoking this function requires =E2=80=98CAP_SYS_ADMIN=E2=
=80=99 advanced
> > permissions.
> >
> > Ok, let us see the code as follows:
> > btrfs_ioctl_rm_dev_v2
> > ``````
> > static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
> > {
> >          struct inode *inode =3D file_inode(file);
> >          struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> >          struct btrfs_ioctl_vol_args_v2 *vol_args;
> >          int ret;
> >          bool cancel =3D false;
> >
> >          if (!capable(CAP_SYS_ADMIN))   ///------------>  =E2=80=98CAP_=
SYS_ADMIN=E2=80=99  need
> >                  return -EPERM;
> >
> >           ...
> >
> >          vol_args =3D memdup_user(arg, sizeof(*vol_args));  //
> > -------------> copy a user data from 'arg' to vol_args.
> >          if (IS_ERR(vol_args)) {
> >                  ret =3D PTR_ERR(vol_args);
> >                  goto err_drop;
> >          }
> >
> >         ...
> >
> >                 if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
> > //---------------> here would judge vol_args->flags
> >                  ret =3D btrfs_rm_device(fs_info, NULL, vol_args->devid=
);
> >   // ------------->call btrfs_rm_device
> >          else
> >                  ret =3D btrfs_rm_device(fs_info, vol_args->name, 0);
> >
> > ````
> >   if the vol_args->flags is  BTRFS_DEVICE_SPEC_BY_ID, it would  also
> > call  btrfs_rm_device function,
> > the second arg type is a pointer,but the second arg is NULL, the third
> > arg is a id of volome device.
> >
> > Let us see the code as follows:
> > btrfs_rm_device
> > ````
> > int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_p=
ath,
> >                      u64 devid)
> > {
> >          struct btrfs_device *device;
> >          struct btrfs_fs_devices *cur_devices;
> >          struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> >          u64 num_devices;
> >          int ret =3D 0;
> >
> >          mutex_lock(&uuid_mutex);
> >
> >          num_devices =3D btrfs_num_devices(fs_info);
> >
> >          ret =3D btrfs_check_raid_min_devices(fs_info, num_devices - 1)=
;
> >          if (ret)
> >                  goto out;
> >
> >          device =3D btrfs_find_device_by_devspec(fs_info, devid,
> > device_path); // ------------>  this function would get a volume
> > device by devid.
> >
> >          if (IS_ERR(device)) {
> >                  if (PTR_ERR(device) =3D=3D -ENOENT &&
> >                      strcmp(device_path, "missing") =3D=3D 0)
> > //-----------------> use device_path pointer,  but device_patch is
> > NULL.
> >                          ret =3D BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
> >                  else
> >                          ret =3D PTR_ERR(device);
> >                  goto out;
> >          }
> > ````
> > btrfs_find_device_by_devspec would lookup  a volume device by devid,
> > ```
> >   * Lookup a device given by device id, or the path if the id is 0.
> >   */
> > struct btrfs_device *btrfs_find_device_by_devspec(
> >                  struct btrfs_fs_info *fs_info, u64 devid,
> >                  const char *device_path)
> > {
> >          struct btrfs_device *device;
> >
> >          if (devid) {
> >                  device =3D btrfs_find_device(fs_info->fs_devices, devi=
d, NULL,
> >                                             NULL);
> >                  if (!device)
> >                          return ERR_PTR(-ENOENT);  // -----> if not
> > lookup a device, it return -ENOENT error.
> >                   return device;
> >          }
> >
> >        ....
> >
> > ```
> > After returning an -ENOENT error, it would call strcmp to compare
> > device_path with 'missing'.
> > As our previous analysis, device_path is NULL, it would  trigger a
> > null-ptr-deref bug.
> >
> > crash log:
> > root@syzkaller:/home/user# ./btrfs_rm_device
> > [   46.204657][ T8385] loop0: detected capacity change from 0 to 32768
> > [   46.218173][ T8385] BTRFS: device fsid
> > 195aeaee-03bd-442f-8f6e-93f8f339d194 devid 1 transid 7 /dev/loop0
> > scanned by btrfs_rm_device (8385)
> > [   46.238597][ T8385] BTRFS info (device loop0): disabling tree log
> > [   46.239838][ T8385] BTRFS info (device loop0): disk space caching is=
 enabled
> > [   46.241198][ T8385] BTRFS info (device loop0): has skinny extents
> > [   46.253597][ T8385] BTRFS info (device loop0): enabling ssd optimiza=
tions
> > [   46.286692][ T8385] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000
> > [   46.288135][ T8385] #PF: supervisor read access in kernel mode
> > [   46.289222][ T8385] #PF: error_code(0x0000) - not-present page
> > [   46.290308][ T8385] PGD 4618d067 P4D 4618d067 PUD 4616b067 PMD 0
> > [   46.291469][ T8385] Oops: 0000 [#1] PREEMPT SMP
> > [   46.292247][ T8385] CPU: 0 PID: 8385 Comm: btrfs_rm_device Not
> > tainted 5.14.0-rc4+ #4
> > [   46.293485][ T8385] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
> > [   46.295205][ T8385] RIP: 0010:btrfs_rm_device+0x487/0x6d0
> > [   46.296136][ T8385] Code: fe 74 18 45 89 f4 e9 91 fd ff ff 48 89 df
> > 45 89 ec e8 bd e3 f9 ff e9 2f ff ff ff 48 c7 c7 6a d1 a2 84 b9 08 00
> > 00 00 4c 89 ee <f3>b
> > [   46.299535][ T8385] RSP: 0018:ffffc9000560bd90 EFLAGS: 00010246
> > [   46.300588][ T8385] RAX: fffffffffffffffe RBX: 0000000000000000
> > RCX: 0000000000000008
> > [   46.301961][ T8385] RDX: fffffffffffffffe RSI: 0000000000000000
> > RDI: ffffffff84a2d16a
> > [   46.303374][ T8385] RBP: ffff88804939c000 R08: ffff888013010600
> > R09: 0000000000000001
> > [   46.304793][ T8385] R10: 0000000000000001 R11: 00000000001357f7
> > R12: 0000000000000008
> > [   46.306238][ T8385] R13: 0000000000000000 R14: fffffffffffffffe
> > R15: ffffffff83d8c123
> > [   46.307614][ T8385] FS:  000000000214a880(0000)
> > GS:ffff88803ec00000(0000) knlGS:0000000000000000
> > [   46.308999][ T8385] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   46.310141][ T8385] CR2: 0000000000000000 CR3: 0000000046200000
> > CR4: 00000000000006f0
> > [   46.311604][ T8385] Call Trace:
> > [   46.312123][ T8385]  btrfs_ioctl+0xba8/0x31b0
> > [   46.312821][ T8385]  ? __x64_sys_ioctl+0x7b/0xb0
> > [   46.313655][ T8385]  __x64_sys_ioctl+0x7b/0xb0
> > [   46.314460][ T8385]  do_syscall_64+0x35/0xb0
> > [   46.315454][ T8385]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   46.316501][ T8385] RIP: 0033:0x44f51d
> > [   46.317178][ T8385] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
> > 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> > 4c 24 08 0f 05 <48>8
> > [   46.320656][ T8385] RSP: 002b:00007ffc361763e8 EFLAGS: 00000283
> > ORIG_RAX: 0000000000000010
> > [   46.321991][ T8385] RAX: ffffffffffffffda RBX: 0000000000400530
> > RCX: 000000000044f51d
> > [   46.323410][ T8385] RDX: 0000000020001d80 RSI: 000000005000943a
> > RDI: 0000000000000005
> > [   46.324773][ T8385] RBP: 00007ffc36176400 R08: 0000000020001db0
> > R09: 0000000000000000
> > [   46.326029][ T8385] R10: 0000000000000000 R11: 0000000000000283
> > R12: 00000000004042a0
> > [   46.327388][ T8385] R13: 0000000000000000 R14: 00000000004ca018
> > R15: 0000000000000000
> > [   46.328775][ T8385] Modules linked in:
> > [   46.329458][ T8385] CR2: 0000000000000000
> > [   46.330389][ T8385] ---[ end trace 1cb21b999dbc3d91 ]---
> > [   46.331249][ T8385] RIP: 0010:btrfs_rm_device+0x487/0x6d0
> > [   46.332180][ T8385] Code: fe 74 18 45 89 f4 e9 91 fd ff ff 48 89 df
> > 45 89 ec e8 bd e3 f9 ff e9 2f ff ff ff 48 c7 c7 6a d1 a2 84 b9 08 00
> > 00 00 4c 89 ee <f3>b
> > [   46.335928][ T8385] RSP: 0018:ffffc9000560bd90 EFLAGS: 00010246
> > [   46.337120][ T8385] RAX: fffffffffffffffe RBX: 0000000000000000
> > RCX: 0000000000000008
> > [   46.338710][ T8385] RDX: fffffffffffffffe RSI: 0000000000000000
> > RDI: ffffffff84a2d16a
> > [   46.340164][ T8385] RBP: ffff88804939c000 R08: ffff888013010600
> > R09: 0000000000000001
> > [   46.341611][ T8385] R10: 0000000000000001 R11: 00000000001357f7
> > R12: 0000000000000008
> > [   46.343055][ T8385] R13: 0000000000000000 R14: fffffffffffffffe
> > R15: ffffffff83d8c123
> > [   46.344521][ T8385] FS:  000000000214a880(0000)
> > GS:ffff88803ec00000(0000) knlGS:0000000000000000
> > [   46.346265][ T8385] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   46.347470][ T8385] CR2: 0000000000000000 CR3: 0000000046200000
> > CR4: 00000000000006f0
> > [   46.348918][ T8385] Kernel panic - not syncing: Fatal exception
> > [   46.350160][ T8385] Kernel Offset: disabled
> > [   46.350978][ T8385] Rebooting in 86400 seconds..
> >
> > the attachment is reproduce.
>
> Awesome analyse and reproducer.
>
> >
> > Regards,
> >     butt3rflyh4ck.
> >
> BTW, would you like us to use "butt3rflyh4ck" as reported-by user name?
>
> Normally we use real names for reported-by, not sure if "butt3rflyh4ck"
> would work here.
> (Awesome hacky ID though)
>
> Thanks,
> Qu



--=20
Active Defense Lab of Venustech
