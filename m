Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E316E53C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDQVSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDQVSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 17:18:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546D358E
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 14:18:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dm2so67965464ejc.8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681766288; x=1684358288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6qXMgIRTfV7fpTXvR+YGYP0H7mXH2bEvArwahsBkSA=;
        b=OnI5G3RS7LIPY0IUS8x6SPOruFxm//vrvGhcR54P6YI/TnpgaZwJp34sWBbi9o2v2u
         6vwui0o0C8ZFOKQst9mUSOf2GMogY2CajdX4ImUYNWgqeCgEsEuPoNHQiD4OrUk6wIJK
         nyDXkIaLcCEhPU0A7uzcURvNdTglhSFvNHEhzu61ZkMTvWmnjsR/xg9uzPhYM3a3NlKH
         Pew2JRVFpKZgjEO1JfVq6MccWtMbvIjKEE6D1CjeXWlGNbNweLHcSlaj3XbR+qfYyPAt
         kxfT0ZXHayd2gWy+0lUDN34x07CeTdYgJdre70GcTNQqOzOgh9jPYGYiTeAnemWSvfxq
         ShFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766288; x=1684358288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6qXMgIRTfV7fpTXvR+YGYP0H7mXH2bEvArwahsBkSA=;
        b=XoLMWiYFseU0N+lupm/sbcrPfqPXiIEA0w7KHh57m+wGM8/T1i7nB19uZNa7R9IAdV
         aiEcaoJYyYzOw4iTzP8KnN34rhMLAr1I+gv8OXj0LnOqKLVl4UeEilxq5s5wckCZDF+7
         VNHafFRKF49lIHOJ+zJGWi3rFgWL59Ys4izzpgVMMvcEWRuPEt9LyYxjE0oVCZi1m0PQ
         /wG57AYxhD2lmZHlFNBfiAebWwBwTmAAZZVBjwUHu9SQiVLWnV7ISkMLmx3p1LLTmui/
         /JlQidTAi3WTvmV8K7WE/Y8qRHNmcK4rO6CVzUMSA+GM+rNZflQVbEy2Et4oQKMHwiqK
         LtPg==
X-Gm-Message-State: AAQBX9cBA9/eVey4AEL4Y3fxHlkCB+9syn/Ie+eotrh/fYna8oM1PLmV
        eV0+rmEu67/5N3dfBSwiQ4qTWXM/duwB/J/acVE=
X-Google-Smtp-Source: AKy350baehx90PekgQNuUfe2w/qoEKTsehvzeZ7R0OnVE3Fs5d8PZMyhMiLcu2tDUuXZFMyUN9ZEV4r4KCEYXckIz9k=
X-Received: by 2002:a17:907:7661:b0:94e:ef3c:1d7c with SMTP id
 kk1-20020a170907766100b0094eef3c1d7cmr8897551ejc.75.1681766288265; Mon, 17
 Apr 2023 14:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230417094810.42214-1-wqu@suse.com>
In-Reply-To: <20230417094810.42214-1-wqu@suse.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Mon, 17 Apr 2023 23:17:55 +0200
Message-ID: <CAL5DHTGrj93FwEZziUsyZiGQyHZh3G1z6FKi1twP+G5TCY740g@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path resolution
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I made btrfs-progs, with `devel` branch and the patch.

Running the `btrfs inspect logical-resolve` against the top level
subvol works, like the example you showed.
# ${btrfs_prog_path}/btrfs inspect logical-resolve 13631488 $mnt
````
$mnt/subv1/file
````

But if running against the a mount subvol it gives useless error:
# mount:
````
/dev/loop20 on /mnt/subtest type btrfs (...,subvol=/subv1)
````
# ${btrfs_prog_path}/btrfs inspect logical-resolve 13631488 subtest
````
ERROR: cannot access 'subtest/subv1': No such file or directory
````

Note to self:
#How to build btrfs-progs
````
apt install make autoconf automake autotools-dev autoconf automake
build-essential e2fslibs-dev libblkid-dev zlib1g-dev libzstd-dev
libudev-dev python3.8 python3.8-dev liblzo2-dev libbtrfsutil-dev
make install_python
./autogen.sh && ./configure --disable-documentation
--prefix=/home/torstein/btrfs-progs/BIN
````


man. 17. apr. 2023 kl. 11:48 skrev Qu Wenruo <wqu@suse.com>:
>
> [BUG]
> There is a bug report that "btrfs inspect logical-resolve" can not even
> handle any file inside non-top-level subvolumes:
>
>  # mkfs.btrfs $dev
>  # mount $dev $mnt
>  # btrfs subvol create $mnt/subv1
>  # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
>  # sync
>  # btrfs inspect logical-resolve 13631488 $mnt
>  inode 257 subvol subv1 could not be accessed: not mounted
>
> This means the command "btrfs inspect logical-resolve" is almost useless
> for resolving logical bytenr to files.
>
> [CAUSE]
> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
> to the subvolume.
>
> Then to handle cases where the subvolume is already mounted somewhere
> else, we call find_mount_fsroot().
>
> But if that target subvolume is not yet mounted, we just error out, even
> if the @path is the top-level subvolume, and we have already know the
> path to the subvolume.
>
> [FIX]
> Instead of doing unnecessary subvolume mount point check, just require
> the @path to be the mount point of the top-level subvolume.
>
> So that we can access all subvolumes without mounting each one.
>
> Now the command works as expected:
>
>  # ./btrfs inspect logical-resolve 13631488 $mnt
>  /mnt/btrfs/subv1/file
>
> And since we're changing the behavior of "logical-resolve" (to a more
> user-friendly one), we have to update the test case misc/042 to reflect
> that.
>
> Reported-by: Torstein Eide <torsteine@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-inspect-internal.rst      |  3 ++
>  cmds/inspect.c                                | 54 ++++++++-----------
>  .../test.sh                                   | 25 ---------
>  3 files changed, 24 insertions(+), 58 deletions(-)
>
> diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
> index 4265fab6..69da468a 100644
> --- a/Documentation/btrfs-inspect-internal.rst
> +++ b/Documentation/btrfs-inspect-internal.rst
> @@ -149,6 +149,9 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <path>
>
>          resolve paths to all files at given *logical* address in the linear filesystem space
>
> +        User should make sure *path* is the mount point of the top-level
> +        subvolume (subvolid 5).
> +
>          ``Options``
>
>          -P
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 20f433b9..dc0e587f 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -158,6 +158,9 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>         int ret;
>         int fd;
>         int i;
> +       const char *top_subvol = "/";
> +       const char *top_subvolid = "5";
> +       char *mounted = NULL;
>         bool getpath = true;
>         int bytes_left;
>         struct btrfs_ioctl_logical_ino_args loi = { 0 };
> @@ -216,6 +219,23 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>                 goto out;
>         }
>
> +       /*
> +        * For logical-resolve, we want the mount point to be top level
> +        * subvolume (5), so that we can access all subvolumes.
> +        */
> +       ret = find_mount_fsroot(top_subvol, top_subvolid, &mounted);
> +       if (ret) {
> +               error("failed to parse mountinfo");
> +               goto out;
> +       }
> +       if (!mounted) {
> +               ret = -ENOENT;
> +               error("mount point \"%s\" is not the top-level subvolume",
> +                     argv[optind + 1]);
> +               goto out;
> +       }
> +       free(mounted);
> +
>         ret = ioctl(fd, request, &loi);
>         if (ret < 0) {
>                 error("logical ino ioctl: %m");
> @@ -258,39 +278,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>                                 path_fd = fd;
>                                 strncpy(mount_path, full_path, PATH_MAX);
>                         } else {
> -                               char *mounted = NULL;
> -                               char subvol[PATH_MAX];
> -                               char subvolid[PATH_MAX];
> -
> -                               /*
> -                                * btrfs_subvolid_resolve returns the full
> -                                * path to the subvolume pointed by root, but the
> -                                * subvolume can be mounted in a directory name
> -                                * different from the subvolume name. In this
> -                                * case we need to find the correct mount point
> -                                * using same subvolume path and subvol id found
> -                                * before.
> -                                */
> -
> -                               snprintf(subvol, PATH_MAX, "/%s", name);
> -                               snprintf(subvolid, PATH_MAX, "%llu", root);
> -
> -                               ret = find_mount_fsroot(subvol, subvolid, &mounted);
> -
> -                               if (ret) {
> -                                       error("failed to parse mountinfo");
> -                                       goto out;
> -                               }
> -
> -                               if (!mounted) {
> -                                       printf(
> -                       "inode %llu subvol %s could not be accessed: not mounted\n",
> -                                               inum, name);
> -                                       continue;
> -                               }
> -
> -                               strncpy(mount_path, mounted, PATH_MAX);
> -                               free(mounted);
> +                               snprintf(mount_path, PATH_MAX, "%s%s", full_path, name);
>
>                                 path_fd = btrfs_open_dir(mount_path, &dirs, 1);
>                                 if (path_fd < 0) {
> diff --git a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
> index 2ba7331e..d20d5f74 100755
> --- a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
> +++ b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
> @@ -51,34 +51,9 @@ run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1/subvol1
>
>  run_check "$TOP/btrfs" filesystem sync "$TEST_MNT"
>
> -run_check_umount_test_dev
> -
> -run_check $SUDO_HELPER mount -o subvol=/@/vol1 "$TEST_DEV" "$TEST_MNT"
> -# Create a bind mount to vol1. logical-resolve should avoid bind mounts,
> -# otherwise the test will fail
> -run_check $SUDO_HELPER mkdir -p "$TEST_MNT/dir"
> -run_check mkdir -p mnt2
> -run_check $SUDO_HELPER mount --bind "$TEST_MNT/dir" mnt2
> -# Create another bind mount to confuse logical-resolve even more.
> -# logical-resolve can return the original mount or mnt3, both are valid
> -run_check mkdir -p mnt3
> -run_check $SUDO_HELPER mount --bind "$TEST_MNT" mnt3
> -
>  for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$vol1id" "$TEST_DEV" |
>                 awk '/disk byte/ { print $5 }'); do
>         check_logical_offset_filename "$offset"
>  done
>
> -run_check_umount_test_dev mnt3
> -run_check rmdir -- mnt3
> -run_check_umount_test_dev mnt2
> -run_check rmdir -- mnt2
> -run_check_umount_test_dev
> -
> -run_check $SUDO_HELPER mount -o subvol="/@/vol1/subvol1" "$TEST_DEV" "$TEST_MNT"
> -for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$subvol1id" "$TEST_DEV" |
> -               awk '/disk byte/ { print $5 }'); do
> -       check_logical_offset_filename "$offset"
> -done
> -
>  run_check_umount_test_dev
> --
> 2.39.0
>
