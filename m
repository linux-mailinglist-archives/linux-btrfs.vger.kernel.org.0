Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D4B41D67F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349447AbhI3Jl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 05:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbhI3Jl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 05:41:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9EC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 02:39:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 138so5124395qko.10
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QycBD8J0jgk6syCksj4K/fUIlo6K68y675QsQ1SwEi4=;
        b=NFVc+qiDnC9N0LS0Mlr/hGIk4VoZmyOKxgWshq95z+cxDx9AtrdIxCKP52K8S8Fn/H
         yJ7WE+eYkQf5tpitHOa0OMhBO+U/krb6ICN7vvDFwA1/ypH8XMfC//EAYaYpn8G3sWw7
         d7nbco5NlbGmKcoPgFOvem9RvxfhM0BdONzM+ev89ThnPgTaOMnZD1xNJUVYmFfGfUZx
         z4r77iv9o0mNZUMtjiifHP0YdkN+B2lym4X2V2/W4WgS0XDEnQ77gePNY0iKrZilCKQ6
         0V3Js7zllMmUd/9JSyVv/cgCyJseYs1VxPZmgVHzjiAFgUi9u7/tEXeXqcTb19ufpm8G
         Qxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QycBD8J0jgk6syCksj4K/fUIlo6K68y675QsQ1SwEi4=;
        b=Lv+zaZWxDDFSKAbT3XGJUjdaUhtrkM/RmGPxScvpAt+5cvLl9h4LAuXVGFUkrsbF7N
         Q+Yf/nNCcOesuFCJ6pi5ZODtBghUdyqxGEWk0g1HcPyAJi2Kwya0mId8Q/J9kK2RleOH
         lLjkmSAnSCUc+fbxsFDS82im2/+NPq6sZzjPKOPrJsO/2mDvrCoG0GcfcasXqiSqXbsC
         VwJk3+M6TdtRzj32UUH8MTM9SC5ZtgrUjzXDOb0VSpLyPIeUkC6dGGhvXPU0y5mo0W70
         RCnGjL51E4nIOLcnfQ9No1gZCVgTrilGoNPf68lwMa+kLGR2T3GulEnE7ryLFVz3jLc7
         PxlA==
X-Gm-Message-State: AOAM531k8/fJDjIpl2s6kfo9zbLMxGCSvLX5YGz1GSPQqSZqLftwcx90
        rbFWIiW0GB6VMLd4ZFr1WykWQzFpI9Zy0pnnrmkvOiRMM60=
X-Google-Smtp-Source: ABdhPJz4J89QHS+z6Vcj3PGEE8bGJl5mQ2tGAmn7425q3gfdYKn6j9ZLbVjRZABByvRfkgrzcdIOXiEoXK+ITd3zx2g=
X-Received: by 2002:a37:b647:: with SMTP id g68mr3854732qkf.39.1632994784038;
 Thu, 30 Sep 2021 02:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930000042.10147-1-wqu@suse.com> <20210930000042.10147-2-wqu@suse.com>
In-Reply-To: <20210930000042.10147-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 10:39:07 +0100
Message-ID: <CAL3q7H6Z5saHXDUN-BHgw32_-HjB4EZ4ts0Ta=mkLXAmsopggQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 1:06 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There are two every basic send streams:

every -> very

> (a/m/ctime and uuid omitted)
>
>   Stream 1: (Parent subvolume)
>   subvol   ./parent_subv           transid=3D8
>   chown    ./parent_subv/          gid=3D0 uid=3D0
>   chmod    ./parent_subv/          mode=3D755
>   utimes   ./parent_subv/
>   mkfile   ./parent_subv/o257-7-0
>   rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
>   utimes   ./parent_subv/
>   write    ./parent_subv/source    offset=3D0 len=3D16384
>   chown    ./parent_subv/source    gid=3D0 uid=3D0
>   chmod    ./parent_subv/source    mode=3D600
>   utimes   ./parent_subv/source
>
>   Stream 2: (snapshot and clone)
>   snapshot ./dest_subv             transid=3D14 parent_transid=3D10
>   utimes   ./dest_subv/
>   mkfile   ./dest_subv/o258-14-0
>   rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
>   utimes   ./dest_subv/
>   clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./dest_s=
ubv/source clone_offset=3D0
>   chown    ./dest_subv/reflink     gid=3D0 uid=3D0
>   chmod    ./dest_subv/reflink     mode=3D600
>   utimes   ./dest_subv/reflink
>
> But if we receive the first stream with default mount, then remount to
> nodatasum, and try to receive the second stream, it will fail:
>
>  # mount /mnt/btrfs
>  # btrfs receive -f ~/parent_stream /mnt/btrfs/
>  At subvol parent_subv
>  # mount -o remount,nodatasum /mnt/btrfs
>  # btrfs receive -f ~/clone_stream /mnt/btrfs/
>  At snapshot dest_subv
>  ERROR: failed to clone extents to reflink: Invalid argument
>  # echo $?
>  1
>
> [CAUSE]
> Btrfs doesn't allow clone source and destination has different NODATASUM

... and destination files have different ...

> flags.
> This is to prevent a data extent to be owned by both NODATASUM inode and
> regular DATASUM inode.
>
> For above receive operations, the clone destination is inheriting the
> NODATASUM flag from mount option, while the clone source has no
> NODATASUM flag, thus preventing us from doing the clone.
>
> [FIX]
> Btrfs send/receive doesn't require the underlying inode has the same
> flags (thus we can send from compressed extent and receive on a
> non-compressed filesystem).
>
> So here we add a new command line option, '--clone-fallback', to allow
> btrfs-receive to fall back to buffered write to copy data from the
> source file.
>
> Since such behavior can result much less clone operations, which may not
> be what the end users really want, and can hide bugs in send stream.
> Thus this behavior must be explicitly specified by the new option.
>
> And we will output a warning message each time such fallback is
> triggered if the user wants extra debug output.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-receive.asciidoc | 13 ++++++
>  cmds/receive.c                       | 60 ++++++++++++++++++++++++++--
>  2 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-r=
eceive.asciidoc
> index e4c4d2c0bf3d..3b88643abe5f 100644
> --- a/Documentation/btrfs-receive.asciidoc
> +++ b/Documentation/btrfs-receive.asciidoc
> @@ -65,6 +65,19 @@ dump the stream metadata, one line per operation
>  +
>  Does not require the 'path' parameter. The filesystem remains unchanged.
>
> +--clone-fallback::
> +allow failed clone operation to fallback to buffer copy from source file=
.

operation -> operations

buffer -> buffered

For this type o documentation, I don't think it's relevant to mention
it's doing buffered IO.

Something like:

when clone operations fail, attempt to directly copy the data instead

> ++
> +Clone operations have various requirement which can be affected by thing=
s like
> +mount options (source file has no NODATASUM flag while current fs is mou=
nted
> +with NODATASUM), sectorsizes (the stream is from 4K sectorsize fs while =
the fs
> +is in 64K page size).

As this is documentation and not code, it should be "sector size", not
sectorsize.
It should also use "filesystem" instead of "fs", to be more clear for
users and consistent with the rest of the man page.

This also misses mentioning the nodatacow case.

Maybe something like:

"When the source and destination filesystems have a different sector
size or when only one of them
was mounted with either the 'nodatacow' or the 'nodatasum' mount
option, clone operations can fail."

It's not complete either, as nodatacow (and therefore nodatasum) might
have been set through chattr and not through mount options, but I
think many users will be able to infer that due to the previous
mention of 'nodatacow'.

> ++
> +This option allows users to let receive to handle such failed clone with
> +buffered copy from the source, at the cost of less clone operations and =
even
> +some unexposed send bugs. Thus this behavior must be explicitly specifie=
d by
> +the user.

"and even some unexposed send bugs" - This is confusing and scary, if
I were a user, most likely I would not use a tool mentioning something
like that in its documentation, except for testing.

We don't know if we currently have any bugs that result in the kernel
issuing invalid clone operations, so that should not be mentioned as
it makes no sense.


Maybe something like:

"This option makes the receive process attempt to manually copy data
from the source to the destination file when a
clone operation fails due to the cases mentioned before. When this
happens, extents will end up not being shared between the files."

> +
>  -q|--quiet::
>  (deprecated) alias for global '-q' option
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 48c774cea587..60691b9b61ae 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -76,6 +76,8 @@ struct btrfs_receive
>         struct subvol_uuid_search sus;
>
>         int honor_end_cmd;
> +
> +       bool clone_fallback;
>  };
>
>  static int finish_subvol(struct btrfs_receive *rctx)
> @@ -705,6 +707,44 @@ out:
>         return ret;
>  }
>
> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 len=
,
> +                        u64 dest_offset)
> +{
> +       unsigned char buf[SZ_32K];
> +       u64 copied =3D 0;
> +       int ret =3D 0;
> +
> +       while (copied < len) {
> +               u32 copy_len =3D min_t(u32, ARRAY_SIZE(buf), len - copied=
);
> +               u32 written =3D 0;
> +               ssize_t read_size;
> +
> +               read_size =3D pread(src_fd, buf, copy_len, src_offset + c=
opied);
> +               if (read < 0) {
> +                       ret =3D -errno;
> +                       error("failed to read source file: %m");
> +                       return ret;
> +               }
> +
> +               /* Write the buffer to dest file */
> +               while (written < read_size) {
> +                       ssize_t write_size;
> +
> +                       write_size =3D pwrite(dst_fd, buf + written,
> +                                       read_size - written,
> +                                       dest_offset + copied + written);
> +                       if (write_size < 0) {
> +                               ret =3D -errno;
> +                               error("failed to write source file: %m");
> +                               return ret;
> +                       }
> +                       written +=3D write_size;
> +               }
> +               copied +=3D read_size;
> +       }
> +       return ret;
> +}
> +
>  static int process_clone(const char *path, u64 offset, u64 len,
>                          const u8 *clone_uuid, u64 clone_ctransid,
>                          const char *clone_path, u64 clone_offset,
> @@ -788,8 +828,17 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>         ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args)=
;
>         if (ret < 0) {
>                 ret =3D -errno;
> -               error("failed to clone extents to %s: %m", path);
> -               goto out;
> +               if (ret !=3D -EINVAL || !rctx->clone_fallback) {
> +                       error("failed to clone extents to %s: %m", path);
> +                       goto out;
> +               }
> +
> +               if (bconf.verbose >=3D 2)
> +                       warning(
> +               "failed to clone extents to %s, fallback to buffered writ=
e",
> +                               path);
> +               ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_off=
set,
> +                                   len, offset);
>         }
>
>  out:
> @@ -1238,11 +1287,13 @@ static int cmd_receive(const struct cmd_struct *c=
md, int argc, char **argv)
>         optind =3D 0;
>         while (1) {
>                 int c;
> -               enum { GETOPT_VAL_DUMP =3D 257 };
> +               enum { GETOPT_VAL_DUMP =3D 257, GETOPT_VAL_CLONE_FALLBACK=
 };
>                 static const struct option long_opts[] =3D {
>                         { "max-errors", required_argument, NULL, 'E' },
>                         { "chroot", no_argument, NULL, 'C' },
>                         { "dump", no_argument, NULL, GETOPT_VAL_DUMP },
> +                       { "clone-fallback", no_argument, NULL,
> +                               GETOPT_VAL_CLONE_FALLBACK},

The option is not listed and summarized at "cmd_receive_usage" (--help outp=
ut).
It should be.

Code wise, it looks good, thanks.

>                         { "quiet", no_argument, NULL, 'q' },
>                         { NULL, 0, NULL, 0 }
>                 };
> @@ -1286,6 +1337,9 @@ static int cmd_receive(const struct cmd_struct *cmd=
, int argc, char **argv)
>                 case GETOPT_VAL_DUMP:
>                         dump =3D 1;
>                         break;
> +               case GETOPT_VAL_CLONE_FALLBACK:
> +                       rctx.clone_fallback =3D true;
> +                       break;
>                 default:
>                         usage_unknown_option(cmd, argv);
>                 }
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
