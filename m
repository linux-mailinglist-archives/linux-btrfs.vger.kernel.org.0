Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4F432306
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJRPi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRPi4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:38:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81657C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 08:36:45 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z24so15593491qtv.9
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YeUjt4nrPKNcYdrJUtIFooFB4JZl0AmPcHs4Gd0Q7W8=;
        b=GQKuuqPaIF4aJ/ucGroGqGtX7hX2nMVroYWEvOGdRyjnT//sm8H80RpBk1XpPN+0Y3
         FksF/wxiY9CfKCgyUzkBvOXwh36R4A9Ipe6177HSzKSg08gF7kpEjxwpiYdAqRlk4Ui+
         7ZrxCskefWqUKZDbrOyKEFOK1fM4jszreu1Nzm5IXB+DuuXBy3ydiXhnfTHqT60hQDZM
         Z6pLC9hXQAUASAcGKingRsrnphWYq04o+a8vAy9Ox3YtWOZX+SyVcX11vZBJOqBEguiH
         LBuLpqNH6ZIlFR255cVl2Uww9UyZzEhVWuHanSGTTjgZqm405F3RHX8Irqb0CV0O0YAv
         dNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YeUjt4nrPKNcYdrJUtIFooFB4JZl0AmPcHs4Gd0Q7W8=;
        b=Jk5Kmpec/pQsyBI3DJuW3Gs/Td8PiGC5ctQLZWNCUKNHo9m7MswFUd2mKthoQosvZC
         CgkzKkf2DqHIvgwIQ1OQbGNM13nyADDa+yze1iBrlis0fgXvKAwMy2SJGxbptpW4w3cf
         XJcFUlkNE+hcimhUbhBkRzT7P0hOEvDIvIDCvYXBbv1Yj9FizsKVoWZ7JvmBTBHuvsVC
         yjCz8aI/7yQKO687M6pmXaddab0Fw3Fq0zgM42AP1uDnM77TiUIsMukdjt8zBGfObKK3
         GTZXly0nAz2BGwQFiI0mLwytq88vm3m2qWqjdIBMyICc5U3UbztX8GW71osTKBpEZ8y6
         OIyQ==
X-Gm-Message-State: AOAM531T35oWFlEdVbb9T5H9BENBWXLPPTh7+otEn7q5RPX8XplNUT2b
        IAYavFypqjW53EQqM6ldG75kltzvzPBq62Rrn+I=
X-Google-Smtp-Source: ABdhPJz0/tQ96SBVDmEEPwdeo9M9hDsJHD8eqsq1ipp2UeQi4do7NhUqzPLAlMnKJnDkQfgcc9Urncfyh4rEVs38bYE=
X-Received: by 2002:ac8:5895:: with SMTP id t21mr9598754qta.329.1634571404518;
 Mon, 18 Oct 2021 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211018144109.18442-1-dsterba@suse.com>
In-Reply-To: <20211018144109.18442-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 18 Oct 2021 16:36:08 +0100
Message-ID: <CAL3q7H6fiN0Sgu_o5xVYCDd8sw6=Q4+-4szXbMC8a-THjvxSpA@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 3:43 PM David Sterba <dsterba@suse.com> wrote:
>
> This is send protocol update to version 2 with example new commands.
>
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support. In order to have something to test,
> there's an extended and a new command, that should be otherwise harmless
> and nobody should depend on it. This should be enough to validate the
> non-protocol changes and backward compatibility before we do the big
> protocol update.
>
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
>
> Protocol changes:
>
> - new command BTRFS_SEND_C_UTIMES2
> - appends OTIME after the output of BTRFS_SEND_C_UTIMES
> - this is an example how to extend an existing command based on protocol
>   version
>
> - new command BTRFS_SEND_C_OTIME
> - path BTRFS_SEND_A_PATH
> - timespec attribute BTRFS_SEND_A_OTIME
> - it's a separate command so it does not bloat any UTIMES2 commands,
>   and is emitted only after inode creation (file, dir, special files).
>
> The patch should be a template for further protocol extensions

Seems very neat and good to me.

>
> RFC:
>
> - set __BTRFS_SEND_C_MAX_V1 to the last command of the version or one
>   beyond?

Is there any advantage of one approach compared to the other?
I don't see any, and it seems good as it is now .

> - drop UTIMES2 before release?

Seems pointless.
Not only because of the dedicated otime command, issued only on inode
creation, but because the utimes command can actually
be issued several times when processing an inode, mostly due to
delayed renames and rmdir (and possibly other cases I don't remember
atm).
So not having otime in the utimes command helps reduce the stream size
and processing.

> - naming?

Seems fine to me.

>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/send.c            | 73 ++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/send.h            | 11 +++++-
>  include/uapi/linux/btrfs.h | 12 +++++--
>  3 files changed, 91 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index afdcbe7844e0..ca9eba5f2de3 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -84,6 +84,8 @@ struct send_ctx {
>         u64 total_send_size;
>         u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
>         u64 flags;      /* 'flags' member of btrfs_ioctl_send_args is u64=
 */
> +       /* Protocol version compatibility requested */
> +       u32 proto;
>
>         struct btrfs_root *send_root;
>         struct btrfs_root *parent_root;
> @@ -312,6 +314,15 @@ static void inconsistent_snapshot_error(struct send_=
ctx *sctx,
>                    sctx->parent_root->root_key.objectid : 0));
>  }
>
> +static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> +{
> +       switch (sctx->proto) {
> +       case 1:  return cmd < __BTRFS_SEND_C_MAX_V1;
> +       case 2:  return cmd < __BTRFS_SEND_C_MAX_V2;
> +       default: return false;
> +       }
> +}
> +
>  static int is_waiting_for_move(struct send_ctx *sctx, u64 ino);
>
>  static struct waiting_dir_move *
> @@ -2507,6 +2518,7 @@ static int send_utimes(struct send_ctx *sctx, u64 i=
no, u64 gen)
>         struct extent_buffer *eb;
>         struct btrfs_key key;
>         int slot;
> +       int cmd;
>
>         btrfs_debug(fs_info, "send_utimes %llu", ino);
>
> @@ -2533,7 +2545,12 @@ static int send_utimes(struct send_ctx *sctx, u64 =
ino, u64 gen)
>         slot =3D path->slots[0];
>         ii =3D btrfs_item_ptr(eb, slot, struct btrfs_inode_item);
>
> -       ret =3D begin_cmd(sctx, BTRFS_SEND_C_UTIMES);
> +       if (proto_cmd_ok(sctx, BTRFS_SEND_C_UTIMES2))
> +               cmd =3D BTRFS_SEND_C_UTIMES2;
> +       else
> +               cmd =3D BTRFS_SEND_C_UTIMES;
> +
> +       ret =3D begin_cmd(sctx, cmd);
>         if (ret < 0)
>                 goto out;
>
> @@ -2544,7 +2561,8 @@ static int send_utimes(struct send_ctx *sctx, u64 i=
no, u64 gen)
>         TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
>         TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
>         TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_CTIME, eb, &ii->ctime);
> -       /* TODO Add otime support when the otime patches get into upstrea=
m */
> +       if (proto_cmd_ok(sctx, BTRFS_SEND_C_UTIMES2))
> +               TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, eb, &ii-=
>otime);
>
>         ret =3D send_cmd(sctx);
>
> @@ -2555,6 +2573,43 @@ static int send_utimes(struct send_ctx *sctx, u64 =
ino, u64 gen)
>         return ret;
>  }
>
> +static int send_inode_otime(struct send_ctx *sctx, const struct fs_path =
*fsp, u64 ino)
> +{
> +       int ret;
> +       struct btrfs_path *path;
> +       struct btrfs_inode_item *ii;
> +       struct btrfs_key key;
> +
> +       if (!proto_cmd_ok(sctx, BTRFS_SEND_C_OTIME))
> +               return 0;
> +
> +       path =3D alloc_path_for_send();
> +       if (!path)
> +               return -ENOMEM;
> +
> +       key.objectid =3D ino;
> +       key.type =3D BTRFS_INODE_ITEM_KEY;
> +       key.offset =3D 0;
> +       ret =3D btrfs_search_slot(NULL, sctx->send_root, &key, path, 0, 0=
);
> +       if (ret) {
> +               if (ret > 0)
> +                       ret =3D -ENOENT;
> +               goto out;
> +       }
> +
> +       ret =3D begin_cmd(sctx, BTRFS_SEND_C_OTIME);

Missing error handling here.

Thanks.

> +       ii =3D btrfs_item_ptr(path->nodes[0], path->slots[0], struct btrf=
s_inode_item);
> +       TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fsp);
> +       TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, path->nodes[0], =
&ii->otime);
> +       ret =3D send_cmd(sctx);
> +
> +tlv_put_failure:
> +out:
> +       btrfs_free_path(path);
> +
> +       return ret;
> +}
> +
>  /*
>   * Sends a BTRFS_SEND_C_MKXXX or SYMLINK command to user space. We don't=
 have
>   * a valid path yet because we did not process the refs yet. So, the ino=
de
> @@ -2633,6 +2688,9 @@ static int send_create_inode(struct send_ctx *sctx,=
 u64 ino)
>         if (ret < 0)
>                 goto out;
>
> +       ret =3D send_inode_otime(sctx, p, ino);
> +       if (ret < 0)
> +               goto out;
>
>  tlv_put_failure:
>  out:
> @@ -7269,6 +7327,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struc=
t btrfs_ioctl_send_args *arg)
>
>         sctx->flags =3D arg->flags;
>
> +       if (arg->flags & BTRFS_SEND_FLAG_VERSION) {
> +               if (arg->version > BTRFS_SEND_STREAM_VERSION) {
> +                       ret =3D -EPROTO;
> +                       goto out;
> +               }
> +               /* Zero means "use the highest version" */
> +               sctx->proto =3D arg->version ?: BTRFS_SEND_STREAM_VERSION=
;
> +       } else {
> +               sctx->proto =3D 1;
> +       }
> +
>         sctx->send_filp =3D fget(arg->send_fd);
>         if (!sctx->send_filp) {
>                 ret =3D -EBADF;
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index de91488b7cd0..eeafbe2fdd9f 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -10,7 +10,7 @@
>  #include "ctree.h"
>
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
> -#define BTRFS_SEND_STREAM_VERSION 1
> +#define BTRFS_SEND_STREAM_VERSION 2
>
>  #define BTRFS_SEND_BUF_SIZE SZ_64K
>
> @@ -48,6 +48,7 @@ struct btrfs_tlv_header {
>  enum btrfs_send_cmd {
>         BTRFS_SEND_C_UNSPEC,
>
> +       /* Version 1 */
>         BTRFS_SEND_C_SUBVOL,
>         BTRFS_SEND_C_SNAPSHOT,
>
> @@ -76,6 +77,14 @@ enum btrfs_send_cmd {
>
>         BTRFS_SEND_C_END,
>         BTRFS_SEND_C_UPDATE_EXTENT,
> +       __BTRFS_SEND_C_MAX_V1,
> +
> +       /* Version 2 */
> +       BTRFS_SEND_C_UTIMES2,
> +       BTRFS_SEND_C_OTIME,
> +       __BTRFS_SEND_C_MAX_V2,
> +
> +       /* End */
>         __BTRFS_SEND_C_MAX,
>  };
>  #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d7d3cfead056..c1a665d87f61 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -771,10 +771,16 @@ struct btrfs_ioctl_received_subvol_args {
>   */
>  #define BTRFS_SEND_FLAG_OMIT_END_CMD           0x4
>
> +/*
> + * Read the protocol version in the structure
> + */
> +#define BTRFS_SEND_FLAG_VERSION                        0x8
> +
>  #define BTRFS_SEND_FLAG_MASK \
>         (BTRFS_SEND_FLAG_NO_FILE_DATA | \
>          BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
> -        BTRFS_SEND_FLAG_OMIT_END_CMD)
> +        BTRFS_SEND_FLAG_OMIT_END_CMD | \
> +        BTRFS_SEND_FLAG_VERSION)
>
>  struct btrfs_ioctl_send_args {
>         __s64 send_fd;                  /* in */
> @@ -782,7 +788,9 @@ struct btrfs_ioctl_send_args {
>         __u64 __user *clone_sources;    /* in */
>         __u64 parent_root;              /* in */
>         __u64 flags;                    /* in */
> -       __u64 reserved[4];              /* in */
> +       __u32 version;                  /* in */
> +       __u32 reserved32;
> +       __u64 reserved[3];              /* in */
>  };
>
>  /*
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
