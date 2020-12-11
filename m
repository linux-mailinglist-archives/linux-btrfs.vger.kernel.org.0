Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489D52D78FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbgLKPRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 10:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406299AbgLKPQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 10:16:34 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE0C061794
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 07:15:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e7so11240552ljg.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TdfAdKYtdonS0ZKIaukoUFvKpjfLDmy6KStVsTkNkt8=;
        b=tx1B4PAXdN3qA2O1p67AabCwiP2ldkweHbKQ4K0k2idlVs18Jld+23WhayV3FIJEsi
         ea7UW8wunaeXRnKo2dSfnJ1ceMD5W7CHyXLuWvCTS9P9RD6xJKlmB7gPKLTblFyrkUTE
         mX6EjWB2PNNGUIL8DHdI9PFPYf10oz/TutLT5qGsgUDlAKzobWv9vz2WjjM2v1w86gY4
         EEgtPvFJded+th+et6LN9I45M1MBBYAceamTNKl/oeXOcRQsAMYGUBorRuYEgeEyap6S
         3EqarHkip/bMlC6C51+TxZZkza5IgMKaDNW89IoL4XXHTY6+fXd2C6WCVtXl4lNyTEhE
         Licw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TdfAdKYtdonS0ZKIaukoUFvKpjfLDmy6KStVsTkNkt8=;
        b=BHb5tIJCHLlC0lvS/J1q2qM4VSN3i8loN408x4bfUQHp/onCivA+dnGwFjhPaY9eu4
         sbJ2tVb0tKdjgtzM8JkojzBbBIJFYUzydwEv+j69an+KK27e0SpeC24n70RLQdSvF6ae
         /8hxK9t5KUJkL8m4UYExrjD68F9pXO4bquidOa+KqLI/TUBhTVmExZunyiod8qL6YyjK
         F49RU2a9Wj1aw++YeJT/qYbkdZ2JANqr362Y0psRjgC88Qy7olV0hTJiArh3xR4rKjI7
         wDgytJpWGc45ePvY24WMJ+yn0QBZrrwQd8jCG9HP/CBqsyExJ5xD7Hv9LJ1Z5zuJI7YI
         Rn+g==
X-Gm-Message-State: AOAM533nCpPWzzcrxymkS/syVW7LPw8SIQTVTn4gyjbqj11dBLpLACMH
        dgcneN5xN8y3XqZnarfBxLf72euw+JRpCyD2rQw2SUP07aUPBw==
X-Google-Smtp-Source: ABdhPJzl+wnGZ5WbhDeRLD6Y5jptexy6+7YQb7dOT0f7s6lvtGzcVTmP/Nf7im1pKdArLqcqFXmXrMgToaoIXaG4YZk=
X-Received: by 2002:a2e:a374:: with SMTP id i20mr5214571ljn.101.1607699752607;
 Fri, 11 Dec 2020 07:15:52 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com> <CAMaziXsEa5dhvLHyYu8KwdLLU8EHz4e+ueh7rMNLe5U8pBGJZg@mail.gmail.com>
In-Reply-To: <CAMaziXsEa5dhvLHyYu8KwdLLU8EHz4e+ueh7rMNLe5U8pBGJZg@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Fri, 11 Dec 2020 20:45:41 +0530
Message-ID: <CAMaziXsnM4eXFFSj8vRr-WHafmgniMzo8S5wdBs0rtf_K=rzeA@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Chris Murphy <lists@colorremedies.com>,
        Community support for Fedora users 
        <users@lists.fedoraproject.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 8:26 PM Sreyan Chakravarty <sreyan32@gmail.com> wrote:
>
> On Fri, Dec 11, 2020 at 12:32 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > If the journal doesn't have more information about why it says this,
> > and if the error is reported in the journal by systemd-logind, enable
> > debug logging for logind and reproduce and the try to figure out why
> > logind is complaining:
> >
> > https://github.com/systemd/systemd/issues/15354#issuecomment-610385478
> >
> > There is a possibility there isn't enough contiguous space in the
> > swapfile for the hibernation image. i.e. when you fallocate the
> > swapfile, it may be comprised of one or even dozens of separate
> > extents and if one of them isn't big enough for hibernation entry then
> > it'll always fail.
> >
> > As far as I'm aware there isn't a way to ask fallocate for a minimum
> > extent size. I've sometimes had to fallocate multiple files in a row
> > to get a swapfile with few fragments and then delete the rest.
> >
> > You can use filefrag -v to see the extent sizes. Those extents are
> > basically holes that swap code writes into. The swap code isn't
> > writing swap or hibernation images via Btrfs. It's just asking Btrfs
> > "what are the ranges and locations I can use" and Btrfs reports that
> > and then the swap and hibernation code use those areas directly.
> >
> >
> > > $ lsattr /var/swap/fedora.swap
> > > ---------------C---- /var/swap/fedora.swap
> >
> > > UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /var/swap
> > >    btrfs   subvol=swap,rw,nodatacow,noattime,nosuid,x-systemd.device-timeout=0
> >
> > OK you're confused. You do not need both chattr +C on the file and the
> > nodatacow option. You only need one of those. You should realize that
> > the nodatacow option applies file system wide. It's non-obvious but
> > really only the VFS mount options can apply separately to bind mounts.
> > And on Fedora, since subvolumes are mounted to specific mounts points
> > and are thus effectively bind mounts behind the scenes, it seems like
> > you can apply some mount options to specific subvolumes as if they are
> > separate file systems. But that's not what's going on, they're just
> > bind mounts. So you can do atime for one mount point, noatime for
> > another. And same for ro or rw. Those are VFS options. The Btrfs mount
> > options apply file system wide, that includes nodatacow, compress, and
> > so on.
> >
> > Further problem now that you're using nodatacow is that you have a
> > bunch of nodatacow files that have been created in the meantime. And
> > those do *not* have chattr +C so you have no easy way to find them.
> > You'd have to parse 'btrfs inspect-internal dump-tree' for the
> > nodatacow flag.
> >
> > nodatacow files are also no compression and no data checksums. So I'm
> > betting this is not what you want.
> >
>
>
> It's a SELinux error. Are there any SELinux experts here ?
>
> I ran the command:
>
> $ sudo ausearch -m AVC,USER_AVC,SELINUX_ERR -ts recent
>
> and got the error:
>
> time->Fri Dec 11 20:19:20 2020
> type=AVC msg=audit(1607698160.378:357): avc:  denied  { search } for
> pid=1362 comm="systemd-logind" name="swap" dev="dm-0" ino=256
> scontext=system_u:system_r:systemd_logind_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0
>
>
> If I run the command:
>
> $ /sbin/restorecon /var/swap/fedora.swap
>
> I get the following error:
>
> time->Fri Dec 11 19:59:56 2020
> type=AVC msg=audit(1607696996.854:323): avc:  denied  { read } for
> pid=2523 comm="systemd-sleep" name="fedora.swap" dev="dm-0" ino=257
> scontext=system_u:system_r:init_t:s0
> tcontext=unconfined_u:object_r:var_t:s0 tclass=file permissive=0
>
>
> My current SELinux label is :
>
> unconfined_u:object_r:swapfile_t:s0 /var/swap/fedora.swap
>
> When I run "/sbin/restorecon", the label changes to :
>
> unconfined_u:object_r:var_t:s0 /var/swap/fedora.swap
>
> IIRC, the correct label is etc_runtime or something like that.
>
> Can any SELinux expert help me ?
>
> --
> Regards,
> Sreyan Chakravarty


I also got the following allow rules from "sesearch --allow | grep swap"

allow devices_unconfined_type device_node:blk_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow devices_unconfined_type device_node:chr_file { append
audit_access create execute execute_no_trans getattr ioctl link lock
map mounton open quotaon read relabelfrom relabelto rename setattr
swapon unlink write };
allow devices_unconfined_type device_node:file { append audit_access
create execute execute_no_trans getattr ioctl link lock map mounton
open quotaon read relabelfrom relabelto rename setattr swapon unlink
write };
allow devices_unconfined_type device_node:lnk_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow files_unconfined_type file_type:blk_file { append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto rename setattr swapon unlink write
};
allow files_unconfined_type file_type:chr_file { append audit_access
create execute execute_no_trans getattr ioctl link lock map mounton
open quotaon read relabelfrom relabelto rename setattr swapon unlink
write };
allow files_unconfined_type file_type:dir { add_name append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto remove_name rename
reparent rmdir search setattr swapon unlink write };
allow files_unconfined_type file_type:fifo_file { append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto rename setattr swapon unlink write
};
allow files_unconfined_type file_type:file { append audit_access
create execute execute_no_trans getattr ioctl link lock map mounton
open quotaon read relabelfrom relabelto rename setattr swapon unlink
write };
allow files_unconfined_type file_type:lnk_file { append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto rename setattr swapon unlink write
};
allow files_unconfined_type file_type:sock_file { append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto rename setattr swapon unlink write
};
allow filesystem_unconfined_type filesystem_type:blk_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow filesystem_unconfined_type filesystem_type:chr_file { append
audit_access create entrypoint execmod execute execute_no_trans
getattr ioctl link lock map mounton open quotaon read relabelfrom
relabelto rename setattr swapon unlink write };
allow filesystem_unconfined_type filesystem_type:dir { add_name append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto remove_name rename
reparent rmdir search setattr swapon unlink write };
allow filesystem_unconfined_type filesystem_type:fifo_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow filesystem_unconfined_type filesystem_type:file { append
audit_access create execmod execute execute_no_trans getattr ioctl
link lock map mounton open quotaon read relabelfrom relabelto rename
setattr swapon unlink write };
allow filesystem_unconfined_type filesystem_type:lnk_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow filesystem_unconfined_type filesystem_type:sock_file { append
audit_access create execmod execute getattr ioctl link lock map
mounton open quotaon read relabelfrom relabelto rename setattr swapon
unlink write };
allow kern_unconfined proc_type:dir { add_name append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto remove_name rename reparent rmdir
search setattr swapon unlink write };
allow kern_unconfined proc_type:file { append audit_access create
execmod execute execute_no_trans getattr ioctl link lock map mounton
open quotaon read relabelfrom relabelto rename setattr swapon unlink
write };
allow kern_unconfined proc_type:lnk_file { append audit_access create
execmod execute getattr ioctl link lock map mounton open quotaon read
relabelfrom relabelto rename setattr swapon unlink write };
allow kern_unconfined sysctl_type:dir { add_name append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto remove_name rename reparent rmdir
search setattr swapon unlink write };
allow kern_unconfined sysctl_type:file { append audit_access create
execmod execute execute_no_trans getattr ioctl link lock map mounton
open quotaon read relabelfrom relabelto rename setattr swapon unlink
write };
allow kern_unconfined sysctl_type:lnk_file { append audit_access
create execmod execute getattr ioctl link lock map mounton open
quotaon read relabelfrom relabelto rename setattr swapon unlink write
};
allow swapfile_t swapfile_t:filesystem associate;
allow updfstab_t swapfile_t:file getattr;


I have no idea what it means.

I have no clue about SELinux.

-- 
Regards,
Sreyan Chakravarty
