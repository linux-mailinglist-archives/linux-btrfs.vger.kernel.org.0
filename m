Return-Path: <linux-btrfs+bounces-8199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F59845A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 14:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E8D1F210BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B91A707D;
	Tue, 24 Sep 2024 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT65Rs3s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848219F417
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179970; cv=none; b=fNIeXWgwnk5JGVGoMTVkq74icbcvpC06A9izGhbFQlzw78lARr4Wxy5TJNk2VipP9VfnqCB44PPAIO5zg+/i/voUSv5DMSAz9h83LtFe28rdf4WAO4yPIl2axbFOEIHgHVhNbiNl4FjBIQsQpNs+fwmHrN0jAqkDrJeXFL/CIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179970; c=relaxed/simple;
	bh=77LF5pjpAeFD9r/Ixw6Nq75NArdKbAEtwjM0J8of61c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKIfRIuny34q8NjHlE3fYd+aZZf50duvpRkIuzLKTc6KChavbixpM7f75QipGO96gbWYyh2pGRw0QQq7qKzbwWlGajlMhkS1Nr0926AX4py9y1Agk5Lp4hKfQGvQt4bJNiqPsMSG/wC+xuy8ozm5w6vevzgwN+QAb463c1huhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT65Rs3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50BAC4CEC4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727179969;
	bh=77LF5pjpAeFD9r/Ixw6Nq75NArdKbAEtwjM0J8of61c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lT65Rs3sqPm5hbSiMz2UdN35TMaHQM7u4Of5AuoV9NZRb2WQeVjHm4kwps/QqI1bk
	 CHj6nNlaoxz2+m+HbkKgCzp2YyV3skBD/8404NzGEwuHY3iBdFtfTrdK4x577huqNJ
	 GsvrnoMrG9aBOmiOl3fRYMqZNiWDPMtO677sdTF7HjlHy3/BYcWe54dy2O0nLtYHF5
	 naB2ejnk5xn/R8vjehVqNTFJhc2vYWm2lv8MgrD+4uk3h1hRaGdJWNsu0lGksdZa7o
	 iLx5QIfkHdV4U4KPusjrvu8VqPz2JUcEEzBEP1rFOM829qzztQlgxDyVhsAuq1Z3zK
	 NhpDlATlSUyQA==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso5875985f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:12:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVH2MBZZ/27fj4WhB9EXyEdKsMkAnoT8vDqV9mMJI8O+3fTFPw
	I5dQMIyjYan0U8Oq7s72p+kJ38e5DRMpu9RXzCP4N9kSZrbN6uILRNPODEQlQIXS2avJU+CRNkB
	FOqNf+7nzmJ9e27v/VB9P9zT+vJg=
X-Google-Smtp-Source: AGHT+IFlxW0z3K74zjlBhDYt8u+LVId6jTfcRdLT4A18oSB1FYTL8vis3Tc/97ygHJmE7IiWYAVkD+DBWrdDkyb7F3o=
X-Received: by 2002:adf:e74c:0:b0:374:bde8:66af with SMTP id
 ffacd0b85a97d-37a4238cb41mr11882886f8f.57.1727179968181; Tue, 24 Sep 2024
 05:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727154543.git.wqu@suse.com> <c6408ea85cd10e4042df528708dd9c2ec1db78c0.1727154543.git.wqu@suse.com>
In-Reply-To: <c6408ea85cd10e4042df528708dd9c2ec1db78c0.1727154543.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 24 Sep 2024 13:12:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
Message-ID: <CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: canonicalize the device path before adding it
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 6:18=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> Inside btrfs we solve the path using LOOKUP_FOLLOW, which follows the
> symbolic link and grab the proper block device.
>
> But we also save the filename into btrfs_device::name, still resulting
> the weird path.
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
> ---
>  fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b713e4ebb362..8acb3c465783 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super=
_block *sb)
>         return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>  }
>
> +/*
> + * We can have very wide soft links passed in.

Wide? Did you mean wild in the sense of unusual?

> + * One example is "/proc/<uid>/fd/<fd>", which can be a soft link to
> + * a proper block device.
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
> +       if (ret) {
> +               pr_info("path lookup failed for %s: %d\n", dev_path, ret)=
;

Why not btrfs_info(), or better yet, btrfs_warn()?

It accepts a NULL fs_info argument and allows for a more standardized
btrfs message, with a proper prefix, etc.


> +               goto out;
> +       }
> +       resolved_path =3D d_path(&path, path_buf, PATH_MAX);
> +       strncpy(canonical, resolved_path, PATH_MAX - 1);

Please don't use strncpy(). This is strongly discouraged due to
security issues, see:

https://github.com/KSPP/linux/issues/90
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-n=
ul-terminated-strings

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
> +       device =3D device_list_add(canonical_path ? canonical_path : path=
,

Can use the shortcut:    canonical_path ?: path

The rest looks fine, thanks.


> +                                disk_super, &new_device_added);
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

