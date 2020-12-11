Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3832D7852
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 15:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406375AbgLKO5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 09:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405326AbgLKO5Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 09:57:24 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818DC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 06:56:44 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t22so11232371ljk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wO8xnxtWSRokng5U3ts3OTeTCfxxxJ/rro8QBcdzShY=;
        b=myeydZdCzfWd2Ty+YyNvGJhSztg+pR5bF5xGM9tY3fEtM2X2dAo+zu94hMXsokpgwt
         oYEFKxlX28BhJbfk90ZCua60GkUvq79AU4HVsno/ly1a4HPSqgmH9N0KJ4e3MS8cXaEu
         E7QO4t8+c3GTJzRiuZNUYNA7sgBbQimrT3qDvEE79prdlkfGRIT3hZkzugcfMC0nU8n6
         3wyWqK2WSrJwfD17/Mr5uMuuo0I0G/QHNkJXEMgNhyr0wYPeC9arY9WRqaT63W5Cec2d
         c0ijWJc0R0kNyB2KqMw3TjRq3JX9JoPC70mHASIoL+UMda5KJzeKMOSYJE8iRgMZSXXR
         GisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wO8xnxtWSRokng5U3ts3OTeTCfxxxJ/rro8QBcdzShY=;
        b=BEUoXrxDAKIR801ef+BOOtDZ7W6VsRczRT9/hzoMVXi02yz86cgC81WjVJPv4FC6QA
         XBI0oK4J7Vbbhy5R5+sAJU4JvT0MZIUOSumlawyJ1ja/dqmZauB8hpH0O1kP7Oa5c7f/
         1yUI9D3AKBY9WwSQMhv/SdqqYThSDF+T9rW0kTzdHNrVtk4AUrXVt2oKLzHOH3RilbD8
         G43AMliVlx5QDezQzwAJnGTkOXHrWOJvHHRgIG5oGB2ErlUC1NbBYuMiQAo5qmT5pwJ/
         DtJY5cc6joETCFZFzdqKRWDOg8/QUqYxmdpuQRwn6r2RGTbKV82Whf/2CTQ7x/GTrLpl
         bMNg==
X-Gm-Message-State: AOAM531orXKu9uZ7O5PpuJc6MCogkBBsFSMszcu5lxw4qIUjMfKFXqyU
        iH6HMiKBygiNviznnt8SB8zLMirVOMmSpYxDK17Fb3UrPbTLPg==
X-Google-Smtp-Source: ABdhPJyuw6T+7+Gnshd8TEA0QlOq6QAXAt8miytit92NA3GzN+g5jc9YR1r93N6b5ZezI+2R+R0lI3bi2IjSrKso7Dg=
X-Received: by 2002:a2e:a374:: with SMTP id i20mr5174373ljn.101.1607698602650;
 Fri, 11 Dec 2020 06:56:42 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
In-Reply-To: <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Fri, 11 Dec 2020 20:26:31 +0530
Message-ID: <CAMaziXsEa5dhvLHyYu8KwdLLU8EHz4e+ueh7rMNLe5U8pBGJZg@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Chris Murphy <lists@colorremedies.com>,
        Community support for Fedora users 
        <users@lists.fedoraproject.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 12:32 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> If the journal doesn't have more information about why it says this,
> and if the error is reported in the journal by systemd-logind, enable
> debug logging for logind and reproduce and the try to figure out why
> logind is complaining:
>
> https://github.com/systemd/systemd/issues/15354#issuecomment-610385478
>
> There is a possibility there isn't enough contiguous space in the
> swapfile for the hibernation image. i.e. when you fallocate the
> swapfile, it may be comprised of one or even dozens of separate
> extents and if one of them isn't big enough for hibernation entry then
> it'll always fail.
>
> As far as I'm aware there isn't a way to ask fallocate for a minimum
> extent size. I've sometimes had to fallocate multiple files in a row
> to get a swapfile with few fragments and then delete the rest.
>
> You can use filefrag -v to see the extent sizes. Those extents are
> basically holes that swap code writes into. The swap code isn't
> writing swap or hibernation images via Btrfs. It's just asking Btrfs
> "what are the ranges and locations I can use" and Btrfs reports that
> and then the swap and hibernation code use those areas directly.
>
>
> > $ lsattr /var/swap/fedora.swap
> > ---------------C---- /var/swap/fedora.swap
>
> > UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /var/swap
> >    btrfs   subvol=swap,rw,nodatacow,noattime,nosuid,x-systemd.device-timeout=0
>
> OK you're confused. You do not need both chattr +C on the file and the
> nodatacow option. You only need one of those. You should realize that
> the nodatacow option applies file system wide. It's non-obvious but
> really only the VFS mount options can apply separately to bind mounts.
> And on Fedora, since subvolumes are mounted to specific mounts points
> and are thus effectively bind mounts behind the scenes, it seems like
> you can apply some mount options to specific subvolumes as if they are
> separate file systems. But that's not what's going on, they're just
> bind mounts. So you can do atime for one mount point, noatime for
> another. And same for ro or rw. Those are VFS options. The Btrfs mount
> options apply file system wide, that includes nodatacow, compress, and
> so on.
>
> Further problem now that you're using nodatacow is that you have a
> bunch of nodatacow files that have been created in the meantime. And
> those do *not* have chattr +C so you have no easy way to find them.
> You'd have to parse 'btrfs inspect-internal dump-tree' for the
> nodatacow flag.
>
> nodatacow files are also no compression and no data checksums. So I'm
> betting this is not what you want.
>


It's a SELinux error. Are there any SELinux experts here ?

I ran the command:

$ sudo ausearch -m AVC,USER_AVC,SELINUX_ERR -ts recent

and got the error:

time->Fri Dec 11 20:19:20 2020
type=AVC msg=audit(1607698160.378:357): avc:  denied  { search } for
pid=1362 comm="systemd-logind" name="swap" dev="dm-0" ino=256
scontext=system_u:system_r:systemd_logind_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0


If I run the command:

$ /sbin/restorecon /var/swap/fedora.swap

I get the following error:

time->Fri Dec 11 19:59:56 2020
type=AVC msg=audit(1607696996.854:323): avc:  denied  { read } for
pid=2523 comm="systemd-sleep" name="fedora.swap" dev="dm-0" ino=257
scontext=system_u:system_r:init_t:s0
tcontext=unconfined_u:object_r:var_t:s0 tclass=file permissive=0


My current SELinux label is :

unconfined_u:object_r:swapfile_t:s0 /var/swap/fedora.swap

When I run "/sbin/restorecon", the label changes to :

unconfined_u:object_r:var_t:s0 /var/swap/fedora.swap

IIRC, the correct label is etc_runtime or something like that.

Can any SELinux expert help me ?

-- 
Regards,
Sreyan Chakravarty
