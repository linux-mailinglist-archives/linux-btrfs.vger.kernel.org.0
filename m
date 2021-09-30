Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686141DB1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbhI3Ndg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350215AbhI3Nde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 09:33:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C05C06176C
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 06:31:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x9so5697038qtv.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/tZkRsNPreeOcfYwsHzXyc4sF7FLgsvEUvOXlg5Oqi0=;
        b=keU58Xo6pemjPSH3N2sOEhLeNEbsJdH91Cng79zjKBG8GJw0nO44712sBaorl2CBVG
         RsQp4kCcSTk+sPerB5vQqJsYukXKkv+mS/ECrkqNKgH3WqLTs+RISL/VA87LE5+rpWuW
         VPiL8vF8REz+wRCN5BOdgifZNeX14pyh8CB/p0KW5PNdAIJf9578TUexfCIGeZM2vgp5
         yUEaW3mnnwIl8Ge0lqiStxDvz1TahPwPVQrsM5p2bjRAUndQ9Irmv42qUyM4j8K0XEg/
         WiC2nJRhcMsOj+1AZnwCmVEO7pl4qsu6QF9VLJaxs4EGxibradk/xRUEm96NvqiaXgKY
         veXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/tZkRsNPreeOcfYwsHzXyc4sF7FLgsvEUvOXlg5Oqi0=;
        b=75VGDTC3PJpe4bllr2WSO2inOYs04nNGlhKay3gLSy9BqhpdpuzHFHI7tkA78ayOcy
         SzH+cVOrbThI49mS4H0hjsTfMgALGbyAzL3boHNlmD7QSTa/UAOlE836bRF+AbNPngzy
         5ZaWcTnyx/PTIdqIKgeTCbXwp6yEDwG6159FsnIveVwJPSbTTfPzWco6uTwKDCcVfJoU
         /YBrfz5toRm81gFr5E9xM9aX7ZfgsDVkZDzY/2dz4+OIy8ws0VUxnQ44geiNNcMp5Gzn
         7YjH1sybAE/jsgrciE20hfrrCWF0SmHTeJox/CBfMapgp89wZa0h1bj8VPBfLvz/K/3i
         JNvg==
X-Gm-Message-State: AOAM531Llq3nwBIPbJMeVXehIbFF/pJWkPKUPK0XyVH6QQ2ZWR/jitv+
        yolOJgGRmar3DHGbXbWX29QJtc+XHZ1GN01Qo8s=
X-Google-Smtp-Source: ABdhPJwWYx/ljDu82x6oXfm07ipjar0qmP4BeVpyU+Xd82/P7raSxp+sNUif7TEc7zc7+/G1xG51KUocemtoQYZUTws=
X-Received: by 2002:ac8:4f0b:: with SMTP id b11mr6613615qte.124.1633008711071;
 Thu, 30 Sep 2021 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210930114855.39225-1-wqu@suse.com> <20210930114855.39225-2-wqu@suse.com>
 <933152a1-e37e-192c-734b-77f5f1735c8b@cobb.uk.net>
In-Reply-To: <933152a1-e37e-192c-734b-77f5f1735c8b@cobb.uk.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 14:31:14 +0100
Message-ID: <CAL3q7H4n-PO0CPTruzpxbFP2EDfsrtNZMjDLsYCyifOUyULwEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 2:20 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 30/09/2021 12:48, Qu Wenruo wrote:
> > [BUG]
> > There are two very basic send streams:
> > (a/m/ctime and uuid omitted)
> >
> >   Stream 1: (Parent subvolume)
> >   subvol   ./parent_subv           transid=3D8
> >   chown    ./parent_subv/          gid=3D0 uid=3D0
> >   chmod    ./parent_subv/          mode=3D755
> >   utimes   ./parent_subv/
> >   mkfile   ./parent_subv/o257-7-0
> >   rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
> >   utimes   ./parent_subv/
> >   write    ./parent_subv/source    offset=3D0 len=3D16384
> >   chown    ./parent_subv/source    gid=3D0 uid=3D0
> >   chmod    ./parent_subv/source    mode=3D600
> >   utimes   ./parent_subv/source
> >
> >   Stream 2: (snapshot and clone)
> >   snapshot ./dest_subv             transid=3D14 parent_transid=3D10
> >   utimes   ./dest_subv/
> >   mkfile   ./dest_subv/o258-14-0
> >   rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
> >   utimes   ./dest_subv/
> >   clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./dest=
_subv/source clone_offset=3D0
> >   chown    ./dest_subv/reflink     gid=3D0 uid=3D0
> >   chmod    ./dest_subv/reflink     mode=3D600
> >   utimes   ./dest_subv/reflink
> >
> > But if we receive the first stream with default mount, then remount to
> > nodatasum, and try to receive the second stream, it will fail:
> >
> >  # mount /mnt/btrfs
> >  # btrfs receive -f ~/parent_stream /mnt/btrfs/
> >  At subvol parent_subv
> >  # mount -o remount,nodatasum /mnt/btrfs
> >  # btrfs receive -f ~/clone_stream /mnt/btrfs/
> >  At snapshot dest_subv
> >  ERROR: failed to clone extents to reflink: Invalid argument
> >  # echo $?
> >  1
> >
> > [CAUSE]
> > Btrfs doesn't allow clone source and destination files have different
> > NODATASUM flags.
> > This is to prevent a data extent to be owned by both NODATASUM inode an=
d
> > regular DATASUM inode.
> >
> > For above receive operations, the clone destination is inheriting the
> > NODATASUM flag from mount option, while the clone source has no
> > NODATASUM flag, thus preventing us from doing the clone.
> >
> > [FIX]
> > Btrfs send/receive doesn't require the underlying inode has the same
> > flags (thus we can send from compressed extent and receive on a
> > non-compressed filesystem).
> >
> > So here we add a new command line option, '--clone-fallback', to allow
> > btrfs-receive to fall back to buffered write to copy data from the
> > source file.
> >
> > Since such behavior can result much less clone operations, which may no=
t
> > be what the end users really want, and can hide bugs in send stream.
> > Thus this behavior must be explicitly specified by the new option.
> >
> > And we will output a warning message each time such fallback is
> > triggered if the user wants extra debug output.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  Documentation/btrfs-receive.asciidoc | 12 ++++++
> >  cmds/receive.c                       | 62 ++++++++++++++++++++++++++--
> >  2 files changed, 71 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs=
-receive.asciidoc
> > index e4c4d2c0bf3d..9c934a399a9c 100644
> > --- a/Documentation/btrfs-receive.asciidoc
> > +++ b/Documentation/btrfs-receive.asciidoc
> > @@ -65,6 +65,18 @@ dump the stream metadata, one line per operation
> >  +
> >  Does not require the 'path' parameter. The filesystem remains unchange=
d.
> >
> > +--clone-fallback::
> > +when clone opeartions fail, attempt to directly copy the data instead.
> > ++
> > +When the source and destination filesystems have different sector size=
s, or
> > +when source and destination files have differnt 'nodatacow' and/or 'no=
datasum'
>
> typo: "different"
>
> > +flags (can be set per-file or through mount options), clone operations=
 can fail.
> > ++
> > +This option makes the receive process attempt to manually copy data fr=
om the
> > +source to the destination file when a clone operation fails (caused by=
 above
> > +reasons). When this happens, extents will end up not being shared
> > +between the files, thus will take up more space.
>
> Send/receive and the storage savings available by storing snapshots are
> important btrfs features for many sysadmins. I think the documentation
> needs to be a bit clearer.
>
> 1) It says that the fallback happens when the clone operation fails
> "caused by above reasons". Is that right? Is it **only** those cases
> that can cause EINVAL error? In the earlier email discussion there was
> mention of different compression settings - would that cause a problem?
> What about new features like the VerifyFS stuff being worked on (I have
> no idea - just choosing a work-in-progress item as an example). If these
> are the only two cases, I think there needs to be a code comment in the
> kernel code that returns this error that if any other cases are
> introduced the documentation for --clone-fallback needs to be updated.
>
> 2) In any case, "caused by above reasons" sounds a bit unnatural to me
> (native English speaker). I would suggest replacing "(caused by above
> reasons)" with "in this way".
>
> 3) And maybe add another sentence: "A warning message will be displayed
> when this happens, if the --verbose option is in effect".
>
> > +
> >  -q|--quiet::
> >  (deprecated) alias for global '-q' option
> >
> > diff --git a/cmds/receive.c b/cmds/receive.c
> > index 48c774cea587..31746d571016 100644
> > --- a/cmds/receive.c
> > +++ b/cmds/receive.c
> > @@ -76,6 +76,8 @@ struct btrfs_receive
> >       struct subvol_uuid_search sus;
> >
> >       int honor_end_cmd;
> > +
> > +     bool clone_fallback;
> >  };
> >
> >  static int finish_subvol(struct btrfs_receive *rctx)
> > @@ -705,6 +707,44 @@ out:
> >       return ret;
> >  }
> >
> > +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 l=
en,
> > +                      u64 dest_offset)
> > +{
> > +     unsigned char buf[SZ_32K];
> > +     u64 copied =3D 0;
> > +     int ret =3D 0;
> > +
> > +     while (copied < len) {
> > +             u32 copy_len =3D min_t(u32, ARRAY_SIZE(buf), len - copied=
);
> > +             u32 written =3D 0;
> > +             ssize_t read_size;
> > +
> > +             read_size =3D pread(src_fd, buf, copy_len, src_offset + c=
opied);
> > +             if (read < 0) {
> > +                     ret =3D -errno;
> > +                     error("failed to read source file: %m");
> > +                     return ret;
> > +             }
> > +
> > +             /* Write the buffer to dest file */
> > +             while (written < read_size) {
> > +                     ssize_t write_size;
> > +
> > +                     write_size =3D pwrite(dst_fd, buf + written,
> > +                                     read_size - written,
> > +                                     dest_offset + copied + written);
> > +                     if (write_size < 0) {
> > +                             ret =3D -errno;
> > +                             error("failed to write source file: %m");
> > +                             return ret;
> > +                     }
> > +                     written +=3D write_size;
> > +             }
> > +             copied +=3D read_size;
> > +     }
> > +     return ret;
> > +}
> > +
> >  static int process_clone(const char *path, u64 offset, u64 len,
> >                        const u8 *clone_uuid, u64 clone_ctransid,
> >                        const char *clone_path, u64 clone_offset,
> > @@ -788,8 +828,17 @@ static int process_clone(const char *path, u64 off=
set, u64 len,
> >       ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args)=
;
> >       if (ret < 0) {
> >               ret =3D -errno;
> > -             error("failed to clone extents to %s: %m", path);
> > -             goto out;
> > +             if (ret !=3D -EINVAL || !rctx->clone_fallback) {
> > +                     error("failed to clone extents to %s: %m", path);
> > +                     goto out;
> > +             }
> > +
> > +             if (bconf.verbose >=3D 2)
> > +                     warning(
> > +             "failed to clone extents to %s, fallback to buffered writ=
e",
>
> I think this message needs to tell the user how many bytes which they
> expected to be cloned are now being duplicated. Something like "failed
> to clone NNNNNN bytes to FILE, fallback to copying data".

That is a good idea.
Perhaps even keep track of a sum to report once receive completes, so
that the user knows how many bytes in total were not
shared/deduplicated (we can easily have tens, hundreds of thousands or
more clone operations).

Adding the full path of the source file, instead of only the
destination file, could also be nice to have, as it can be used
afterwards for running simple deduplication tools.

>
> Graham
>
> > +                             path);
> > +             ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_off=
set,
> > +                                 len, offset);
> >       }
> >
> >  out:
> > @@ -1197,6 +1246,8 @@ static const char * const cmd_receive_usage[] =3D=
 {
> >       "                 this file system is mounted.",
> >       "--dump           dump stream metadata, one line per operation,",
> >       "                 does not require the MOUNT parameter",
> > +     "--clone-fallback when clone operations fail, attempt to directly=
 copy"
> > +     "                 the data instead"
> >       "-v               deprecated, alias for global -v option",
> >       HELPINFO_INSERT_GLOBALS,
> >       HELPINFO_INSERT_VERBOSE,
> > @@ -1238,11 +1289,13 @@ static int cmd_receive(const struct cmd_struct =
*cmd, int argc, char **argv)
> >       optind =3D 0;
> >       while (1) {
> >               int c;
> > -             enum { GETOPT_VAL_DUMP =3D 257 };
> > +             enum { GETOPT_VAL_DUMP =3D 257, GETOPT_VAL_CLONE_FALLBACK=
 };
> >               static const struct option long_opts[] =3D {
> >                       { "max-errors", required_argument, NULL, 'E' },
> >                       { "chroot", no_argument, NULL, 'C' },
> >                       { "dump", no_argument, NULL, GETOPT_VAL_DUMP },
> > +                     { "clone-fallback", no_argument, NULL,
> > +                             GETOPT_VAL_CLONE_FALLBACK},
> >                       { "quiet", no_argument, NULL, 'q' },
> >                       { NULL, 0, NULL, 0 }
> >               };
> > @@ -1286,6 +1339,9 @@ static int cmd_receive(const struct cmd_struct *c=
md, int argc, char **argv)
> >               case GETOPT_VAL_DUMP:
> >                       dump =3D 1;
> >                       break;
> > +             case GETOPT_VAL_CLONE_FALLBACK:
> > +                     rctx.clone_fallback =3D true;
> > +                     break;
> >               default:
> >                       usage_unknown_option(cmd, argv);
> >               }
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
