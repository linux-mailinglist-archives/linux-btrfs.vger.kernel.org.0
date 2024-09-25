Return-Path: <linux-btrfs+bounces-8224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A0985795
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A451B243A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A7147C79;
	Wed, 25 Sep 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvZRc2Tm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23D482D8
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262307; cv=none; b=SEjQskzFGQ48pZGDLpQOBKCjXT1C81cg0BAUP093BDfVXcOjhUnOBsg4iQxTbrKy6odJJutuK6J2+WpGyzVLaSkCea4wQKsU+SDbjbAlP43rKRW9+AxFo/KXQr2EHAq93YrYfIynzndh7WCIMm6Uw1SrzxXM98sEh0ci5n94dWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262307; c=relaxed/simple;
	bh=IUiOIm0z1DeLo3h92/ihWs0hAp9AfMbjhwACdFf6UX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLacGQLiNOkmsMYH/YA4JdKcSuO8TT7jdjffRNWIPwsD8WwLZaqDqoooJKxThKRQ419xNPZR2tVZ6QWAoFtSYCpJqE5QjPg/WzbCygzP2dIDmCS2D8yPyCXHV/X2lmBahtaVe17HHM+lfqSYchaibHojl5srLqhG6JpOl46MLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvZRc2Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55543C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727262307;
	bh=IUiOIm0z1DeLo3h92/ihWs0hAp9AfMbjhwACdFf6UX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uvZRc2TmeDcxPeGTVwQv0HpN3dXnIK14i5RyC/HFwFNiEi69lvfM66hzamaPpYYaK
	 fsYwp5tuaa5JfSx43OHecpIEMEs/mrXxemjtKsSqi8VOJVmGrzaUzrwSkzFq7/IRXY
	 dd7XMMUKLboC3D/QWcwO0W3lNlshInLMEASYKdv2LRl2VdyNXL34C8sVMQNfYUSdA3
	 6koBHOKkOve1mXwQbvjE8xex1KOf/iiR6Mpv/1vVEIMxS/D+pHsqd9Wcu+YSBY8mp2
	 aRTHCheZAe0jRzfWtVnPid2cAhPOeF8GmdrOKu4Ny7XeH23yTJ+99CRjAmPiretUyT
	 8qBiB8YDqEedw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a90349aa7e5so963736866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 04:05:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywd4aNRI4vHNcZtvLLdsfU5pwgreddVJ1Wl03m5YlfLRoL8r+8b
	v3/G3GaNDeulX83smLfVCpNUA+eWqe3SLm8++0IJ/B3aJlxUJb7Oo0+g/EdUW0RX7sNkZt+pmlL
	svB946+4WIJ33bs9Uql1N8Yv4Q2Y=
X-Google-Smtp-Source: AGHT+IGeCfMF9sCMcnal0iHJa7OqtumzwogIdBX7tRIH/h46J2x5t/J0/7Zn3AlK4SYo3U5IDMWBdwK/03RL18GTc4c=
X-Received: by 2002:a17:907:e210:b0:a8e:a578:29df with SMTP id
 a640c23a62f3a-a93a03200admr185532166b.6.1727262305721; Wed, 25 Sep 2024
 04:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727222308.git.wqu@suse.com> <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
In-Reply-To: <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Sep 2024 12:04:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4BfZ91ifh5FrmeZn_6xRsEQT+nrLwTZuJ8cW8dA-dbYA@mail.gmail.com>
Message-ID: <CAL3q7H4BfZ91ifh5FrmeZn_6xRsEQT+nrLwTZuJ8cW8dA-dbYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: canonicalize the device path before adding it
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEM]
> Currently btrfs accepts any file path for its device, resulting some
> weird situation:
>
>  # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/
>
> The program has the following source code:
>
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <sys/mount.h>
>
>  int main(int argc, char *argv[]) {
>         int fd =3D open(argv[1], O_RDWR);
>         char path[256];
>         snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>         return mount(path, argv[2], "btrfs", 0, NULL);
>  }
>
> Then we can have the following weird device path:
>
>  BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 transid =
7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
>
> Normally it's not a big deal, and later udev can trigger a device path
> rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
> will show up in mtab.
>
> [CAUSE]
> For filename "/proc/self/fd/3", it means the opened file descriptor 3.
> In above case, it's exactly the device we want to open, aka points to
> "/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2".
>
> Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
> follows the symbolic link and grab the proper block device.
>
> But inside btrfs we also save the filename into btrfs_device::name, and
> utilize that member to report our mount source, which leads to the above
> situation.
>
> [FIX]
> Instead of unconditionally trust the path, check if the original file
> (not following the symbolic link) is inside "/dev/", if not, then
> manually lookup the path to its final destination, and use that as our
> device path.
>
> This allows us to still use symbolic links, like
> "/dev/mapper/test-scratch" from LVM2, which is required for fstests runs
> with LVM2 setup.
>
> And for really weird names, like the above case, we solve it to
> "/dev/dm-2" instead.
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b713e4ebb362..668138451f7c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super=
_block *sb)
>         return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>  }
>
> +/*
> + * We can have very weird soft links passed in.
> + * One example is "/proc/self/fd/<fd>", which can be a soft link to
> + * a block device.
> + *
> + * But it's never a good idea to use those weird names.
> + * Here we check if the path (not following symlinks) is a good one insi=
de
> + * "/dev/".
> + */
> +static bool is_good_dev_path(const char *dev_path)
> +{
> +       struct path path =3D { .mnt =3D NULL, .dentry =3D NULL };
> +       char *path_buf =3D NULL;
> +       char *resolved_path;
> +       bool is_good =3D false;
> +       int ret;
> +
> +       path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +       if (!path_buf)
> +               goto out;
> +
> +       /*
> +        * Do not follow soft link, just check if the original path is in=
side
> +        * "/dev/".
> +        */
> +       ret =3D kern_path(dev_path, 0, &path);
> +       if (ret)
> +               goto out;
> +       resolved_path =3D d_path(&path, path_buf, PATH_MAX);
> +       if (IS_ERR(resolved_path))
> +               goto out;
> +       if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
> +               goto out;
> +       is_good =3D true;
> +out:
> +       kfree(path_buf);
> +       path_put(&path);
> +       return is_good;
> +}
> +
> +static int get_canonical_dev_path(const char *dev_path, char *canonical)
> +{
> +       struct path path =3D { .mnt =3D NULL, .dentry =3D NULL };
> +       char *path_buf =3D NULL;
> +       char *resolved_path;
> +       int ret;
> +
> +       path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +       if (!path_buf) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D kern_path(dev_path, LOOKUP_FOLLOW, &path);
> +       if (ret)
> +               goto out;
> +       resolved_path =3D d_path(&path, path_buf, PATH_MAX);
> +       ret =3D strscpy(canonical, resolved_path, PATH_MAX);
> +out:
> +       kfree(path_buf);
> +       path_put(&path);
> +       return ret;
> +}
> +
>  static bool is_same_device(struct btrfs_device *device, const char *new_=
path)
>  {
>         struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
> @@ -1408,12 +1472,23 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>         bool new_device_added =3D false;
>         struct btrfs_device *device =3D NULL;
>         struct file *bdev_file;
> +       char *canonical_path =3D NULL;
>         u64 bytenr;
>         dev_t devt;
>         int ret;
>
>         lockdep_assert_held(&uuid_mutex);
>
> +       if (!is_good_dev_path(path)) {
> +               canonical_path =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +               if (canonical_path) {
> +                       ret =3D get_canonical_dev_path(path, canonical_pa=
th);
> +                       if (ret < 0) {
> +                               kfree(canonical_path);
> +                               canonical_path =3D NULL;
> +                       }
> +               }
> +       }
>         /*
>          * Avoid an exclusive open here, as the systemd-udev may initiate=
 the
>          * device scan which may race with the user's mount or mkfs comma=
nd,
> @@ -1458,7 +1533,8 @@ struct btrfs_device *btrfs_scan_one_device(const ch=
ar *path, blk_mode_t flags,
>                 goto free_disk_super;
>         }
>
> -       device =3D device_list_add(path, disk_super, &new_device_added);
> +       device =3D device_list_add(canonical_path ? : path, disk_super,
> +                                &new_device_added);
>         if (!IS_ERR(device) && new_device_added)
>                 btrfs_free_stale_devices(device->devt, device);
>
> @@ -1467,6 +1543,7 @@ struct btrfs_device *btrfs_scan_one_device(const ch=
ar *path, blk_mode_t flags,
>
>  error_bdev_put:
>         fput(bdev_file);
> +       kfree(canonical_path);
>
>         return device;
>  }
> --
> 2.46.1
>
>

