Return-Path: <linux-btrfs+bounces-8198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B598451D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 13:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D6C1C22A1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7F136330;
	Tue, 24 Sep 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz6ykiOd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27D824AD
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178515; cv=none; b=JNqEt8OeGxgOUqkFXMwpinnKumgSlG2kfApkQJjgTgZmWm3ImUK75gdoOT3KbMPwmX6Tfr/qNkagVVQluk2ByIyPwj0twPxZqZjwmqFU2ssp4RtfALXjbzXcFUtjutHmEKJ04vo4NIy108pjQl81sGXZ6Wxzd4YAfER8hYT3qIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178515; c=relaxed/simple;
	bh=8E7uwvCWmrAyenqnII1iiVXKBUuJkKndwLdQwUj873I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkmZ+HjOb/Z7W2KlxR9DrmUAZ5ns/aeiFWCFGlE3U9vhKS0zGRnqtcxPIPbI6QzEGu5ia/5gLidDuSl0Flsidx0BbJglpcdls5Ac8DfqZO4WwVJPwGtp4k5JuGUpAVojM8ITEO7EGBzlRVr/+eMjQhc7Ore9phCMSL9wu73aCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz6ykiOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED2C4CEC4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727178515;
	bh=8E7uwvCWmrAyenqnII1iiVXKBUuJkKndwLdQwUj873I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dz6ykiOdzXKA8aWpHJoX79HpgL9dIvdtEGZGnEZmMoy6N1WFAJ0AEpWOrU7C0l97Z
	 W/Edu+A8ME5pUdicC/U8qw7z7rnVnliIHj3cb44iLUBl7LOGWTnFfbvns4Yzai/TOv
	 tuvzkgzSbX0/CMgZGkf+4aJ/QXRfHoD+1/8jQ1ILbnfOQiBKi6qu/AGpVUbFVlCMMY
	 iL8bXsgdptLf46zr3i163Gc7fQAz/BcLzw0YDt/pFl+G81acuAyY3WNZ1dvK4lcdd+
	 TTGhQauktq6wrdqiPdITCC57+AR1Ki4/+UejSIgQa1q7ZNSid2qFetIX7b936L6oGJ
	 Az+yfyJurYd8A==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so7800751a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 04:48:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHKiRj9eKn+nW6KJrPyZn8fXCxfMHSfpTzHD9XOEFpV5tvgoSp
	RvfE1VwaDSgxTPUd5ugjxufSw3mbzAd/J2Z7Dvr1Gkpin9MKQX31FbSPnq326WMZA96j9hP5Sre
	x2Eq5hq3P7Gr4nEYVwiGSGqJSd6w=
X-Google-Smtp-Source: AGHT+IG7HPvGPavoDm5q1ygsag3BwVwL539QWGWY7+WF4Gz5E4eg2vtGaVe9Y6cJzbSH6r5LXn4wjqZiSKIaZj0CqJw=
X-Received: by 2002:a17:907:3e05:b0:a91:158c:8057 with SMTP id
 a640c23a62f3a-a91158c908bmr469404066b.54.1727178513700; Tue, 24 Sep 2024
 04:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727154543.git.wqu@suse.com> <bb5f08852d68f7424b1113deb74586527912c290.1727154543.git.wqu@suse.com>
In-Reply-To: <bb5f08852d68f7424b1113deb74586527912c290.1727154543.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 24 Sep 2024 12:47:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5c3CiWSaag8Sb=Wrqtj6CRYAkEA9bj69TuVgjKh-YNDA@mail.gmail.com>
Message-ID: <CAL3q7H5c3CiWSaag8Sb=Wrqtj6CRYAkEA9bj69TuVgjKh-YNDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: avoid unnecessary device path update for the
 same device
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 6:17=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEM]
> It is very common for udev to trigger device scan, and every time a
> mounted btrfs device got re-scan from different soft links, we will get
> unnecessary renames like this:
>
>  BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 transid =
7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (11096)
>  BTRFS info (device dm-2): first mount of filesystem 2378be81-fe12-46d2-a=
9e8-68cf08dd98d5
>  BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algorithm
>  BTRFS info (device dm-2): using free-space-tree
>  BTRFS info: devid 1 device path /proc/self/fd/3 changed to /dev/dm-2 sca=
nned by (udev-worker) (11092)
>  BTRFS info: devid 1 device path /dev/dm-2 changed to /dev/mapper/test-sc=
ratch1 scanned by (udev-worker) (11092)
>
> The program "mount_by_fd" has the following simple source code:
>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <sys/mount.h>
>
>  int main(int argc, char *argv[]) {
>         int fd =3D open(argv[1], O_RDWR);
>         char path[256];
>
>         snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>         return mount(path, argv[2], "btrfs", 0, NULL);
>  }
>
> Note that, all the above paths are all just pointing to "/dev/dm-2".
> The "/proc/self/fd/3" is the proc fs, describing all the opened fds.

This is redundant to say, we all know everything inside /proc belongs
to procfs, and self/fd/X corresponds to an open fd by the calling
task.

> The "/dev/mapper/test-scratch1" is the soft link created by LVM2.

What would be more useful here is to have all the steps to reproduce
the problem:

1) How you invoke that test program, what the arguments are;
2) Any other steps that one should run to reproduce the problem.

Can we also get a test case for fstests?
Even if it's caused by a race and it doesn't always trigger, with
several people often running fstests frequently, possible regressions
will be quickly detected.

>
> [CAUSE]
> Inside device_list_add(), we are using a very primitive way checking if
> the device has changed, strcmp().
>
> Which can never handle links well, no matter if it's hard or soft links.
>
> So every different link of the same device will be treated as different
> device, causing the unnecessary device name update.
>
> [FIX]
> Introduce a helper, is_same_device(), and use path_equal() to properly
> detect the same block device.
> So that the different soft links won't trigger the rename race.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Since there's a publicly accessible report for this, at
https://bugzilla.suse.com/show_bug.cgi?id=3D1230641, can we please at
least get a Link tag here?

> ---
>  fs/btrfs/volumes.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 995b0647f538..b713e4ebb362 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -732,6 +732,32 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super=
_block *sb)
>         return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>  }
>
> +static bool is_same_device(struct btrfs_device *device, const char *new_=
path)
> +{
> +       struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
> +       struct path new =3D { .mnt =3D NULL, .dentry =3D NULL };

This can simply be: ... =3D { 0 }

But I don't mind this more verbose initialization.

With the change log fixes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       bool is_same =3D false;
> +       int ret;
> +
> +       if (!device->name)
> +               goto out;
> +
> +       old_path =3D rcu_str_deref(device->name);
> +       ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
> +       if (ret)
> +               goto out;
> +       ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
> +       if (ret)
> +               goto out;
> +       if (path_equal(&old, &new))
> +               is_same =3D true;
> +out:
> +       path_put(&old);
> +       path_put(&new);
> +       return is_same;
> +}
> +
>  /*
>   * Add new device to list of registered devices
>   *
> @@ -852,7 +878,7 @@ static noinline struct btrfs_device *device_list_add(=
const char *path,
>                                 MAJOR(path_devt), MINOR(path_devt),
>                                 current->comm, task_pid_nr(current));
>
> -       } else if (!device->name || strcmp(device->name->str, path)) {
> +       } else if (!device->name || !is_same_device(device, path)) {
>                 /*
>                  * When FS is already mounted.
>                  * 1. If you are here and if the device->name is NULL tha=
t
> --
> 2.46.1
>
>

