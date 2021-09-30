Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5041DA43
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbhI3Mx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbhI3Mx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:53:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54566C06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 05:52:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i132so5652492qke.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X5+pqkpJTKrIopzNUZihYWxdOb09KFVkjzzT3O4iqYg=;
        b=NiBQBPXx8i9u8tiuf1Tvu1TLchtaqIATMTRw8G/O7W6E0mDrEowxyMGR22Ry3mG7mp
         BsNHzlUIviifffILjdrh3pplja4lOnpzOoqVJ6k0F26c+MKL2JSbppryndTKTzLcHBu9
         vLlPCj5GlM0jE7PQgOEorYdKT4t/NKJM0eQfUe08qvKmvcxepN/nUDD2VOw8aCpQ0NIP
         U7zcIJsLvwTfAv8kor5lAJOQw3XhPmkWLq59T9xjdE45hbBX0W2wRWP3FBQGpvPJ6/da
         NHhdPiNG0dxyOlwdxKoEnBAaqayc2S6EhRod8dsyC3+HYPa/QQyJ4nn1pJlKuSUBpmpY
         ++ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X5+pqkpJTKrIopzNUZihYWxdOb09KFVkjzzT3O4iqYg=;
        b=kssPd6JsNY9i/Xg1wH30X0SVJj6Hw03GhhKZ/bY0qWC1lqI0Y4uA1p9mT0L9oQjhqE
         rpyRQpZt4bfn/qmOLhU1R6TNQyjPxIAiFAc6PFRQLsGVF5KqeVIvTnPYWvfynV0n/MVX
         lW8FG2RfUsm86C1FTLweHEThJg6zcA23ozz156EZbzW6afoYZ00hXZh7kLVjB7DL/Chb
         C15OsrvdFSJ+typLYApXgIHG9TobVVL90qyQHs4yopcwdlF9I7oVVZDnBDWTFDECsG5P
         i0zG8iRmlHWyJxCVy0xui3YzCjV9dheI3cqWsSnOL7FLLgNaJ1dBnlK8EiRgwHZdSDc1
         TdAQ==
X-Gm-Message-State: AOAM532SFLmnIaHAavpOAwfA+tdEya54nhRpL0ezV8lfHsSY4aIQOtOT
        xRQ9Mgw9ZyRr08Cl/4ll09nnbjgd8j4pSxEqdqd+qDkXv+A=
X-Google-Smtp-Source: ABdhPJyo0dw5lR0HBmD9p6UTKjZ3SXF1zCW+KNThBXsrhhqjyUrywsd88o+NNqCOu6iIN/q4JoEAwEsZzojyRWXsCIY=
X-Received: by 2002:a37:b647:: with SMTP id g68mr4569432qkf.39.1633006334415;
 Thu, 30 Sep 2021 05:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210930114855.39225-1-wqu@suse.com> <20210930114855.39225-2-wqu@suse.com>
In-Reply-To: <20210930114855.39225-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 13:51:38 +0100
Message-ID: <CAL3q7H5=fB+7xqE6R+ppTrFtZY=k1xfEBByfvAYWxuAL6=h4Vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 1:34 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There are two very basic send streams:
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
> Btrfs doesn't allow clone source and destination files have different
> NODATASUM flags.
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
>  Documentation/btrfs-receive.asciidoc | 12 ++++++
>  cmds/receive.c                       | 62 ++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-r=
eceive.asciidoc
> index e4c4d2c0bf3d..9c934a399a9c 100644
> --- a/Documentation/btrfs-receive.asciidoc
> +++ b/Documentation/btrfs-receive.asciidoc
> @@ -65,6 +65,18 @@ dump the stream metadata, one line per operation
>  +
>  Does not require the 'path' parameter. The filesystem remains unchanged.
>
> +--clone-fallback::
> +when clone opeartions fail, attempt to directly copy the data instead.

 opeartions -> operations

> ++
> +When the source and destination filesystems have different sector sizes,=
 or
> +when source and destination files have differnt 'nodatacow' and/or 'noda=
tasum'

when source -> when the source
differnt -> different

> +flags (can be set per-file or through mount options), clone operations c=
an fail.

inside the parenthesis:  can be set per file/directory or through mount opt=
ions

> ++
> +This option makes the receive process attempt to manually copy data from=
 the
> +source to the destination file when a clone operation fails (caused by a=
bove

by above -> by the above

Better yet, "for the reasons mentioned before".

> +reasons). When this happens, extents will end up not being shared
> +between the files, thus will take up more space.

Sorry, I hate to be picky just about language stuff, but this is user
oriented so it matters.
For simple things like the typos, checkpatch.pl from the kernel should help=
.

The rest seems fine to me, and after the corrections:  Reviewed-by:
Filipe Manana <fdmanana@suse.com>

Thanks.

> +
>  -q|--quiet::
>  (deprecated) alias for global '-q' option
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 48c774cea587..31746d571016 100644
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
> @@ -1197,6 +1246,8 @@ static const char * const cmd_receive_usage[] =3D {
>         "                 this file system is mounted.",
>         "--dump           dump stream metadata, one line per operation,",
>         "                 does not require the MOUNT parameter",
> +       "--clone-fallback when clone operations fail, attempt to directly=
 copy"
> +       "                 the data instead"
>         "-v               deprecated, alias for global -v option",
>         HELPINFO_INSERT_GLOBALS,
>         HELPINFO_INSERT_VERBOSE,
> @@ -1238,11 +1289,13 @@ static int cmd_receive(const struct cmd_struct *c=
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
>                         { "quiet", no_argument, NULL, 'q' },
>                         { NULL, 0, NULL, 0 }
>                 };
> @@ -1286,6 +1339,9 @@ static int cmd_receive(const struct cmd_struct *cmd=
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
