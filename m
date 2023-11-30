Return-Path: <linux-btrfs+bounces-451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E767FEE13
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 12:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D821C20EBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324133D3A8;
	Thu, 30 Nov 2023 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt0THIbD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348813D398
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 11:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00762C433CA
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701344418;
	bh=fq5WrGkvB9lgWqSGJmQOthnC/oiQLTXd29Ym3fBlC4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mt0THIbDF7dxQuJkRDhz53MicPBauN9FXisEKiirKd3jLJfrr1WPFTEF5uojf1L+t
	 s/i6Wew95I07+YZ623Gg5JGKAyclm1n4eXqTn84WBux806fxxIW3tMQeAsAjczb2yj
	 yYHABikyQdmIUVo+xghWdNdzfyRv4STLjfuVjwlcQA4DYj/gD7jAjTADksY7SsGuV7
	 mNigrqb36ZoLbw2FYNJg8ewfzn1xDHA8Dj5G3U5tVkZa4G2OLoNWq0fMnfBWYDBsIq
	 w2TKqlBG5JosK8ogX0P1ALLzsd9u049LDBjrvBGLhJkVBLoLgnkl6pGS5ZRQUI/GAT
	 SX0M97BIY0WEg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a00cbb83c82so116671166b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 03:40:17 -0800 (PST)
X-Gm-Message-State: AOJu0YzD6+Ioon9vZpcg++NfP3ZmV3RmJL8R8MvvGHnkAajJ9opFOhJR
	d1pxbUchvqfEgeWALZwenQFlmOQZe2Vx9xMdsfQ=
X-Google-Smtp-Source: AGHT+IEgUf7txEYaaZDniHEgGasBdcC8wKRKKiY7EZHt5MLysxu5f7QRf9JYfoeyN/OwJqGvUjFme7feaU00mstW1MY=
X-Received: by 2002:a17:906:fcc:b0:9bd:a75a:5644 with SMTP id
 c12-20020a1709060fcc00b009bda75a5644mr14104257ejk.16.1701344416370; Thu, 30
 Nov 2023 03:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a8b4385143d66feec39e3925a399c118846a686.1701281422.git.josef@toxicpanda.com>
In-Reply-To: <8a8b4385143d66feec39e3925a399c118846a686.1701281422.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 30 Nov 2023 11:39:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ycvwfRhnFysXpOp7qdek8AbYVfY8qRE_WOYeHpcYEsw@mail.gmail.com>
Message-ID: <CAL3q7H7ycvwfRhnFysXpOp7qdek8AbYVfY8qRE_WOYeHpcYEsw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: cache that we don't have security.capability set
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:10=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> When profiling a workload I noticed we were constantly calling getxattr.
> These were mostly coming from __remove_privs, which will lookup if
> security.capability exists to remove it.  However instrumenting getxattr
> showed we get called nearly constantly on an idle machine on a lot of
> accesses.
>
> These are wasteful and not free.  Other security LSM's have a way to
> cache their results, but capability doesn't have this, so it's asking us
> all the time for the xattr.
>
> Fix this by setting a flag in our inode that it doesn't have a
> security.capability xattr.  We set this on new inodes and after a failed
> lookup of security.capability.  If we set this xattr at all we'll clear
> the flag.
>
> I haven't found a test in fsperf that this makes a visible difference
> on, but I assume fs_mark related tests would show it clearly.  This is a
> perf report output of the smallfiles100k run where it shows 20% of our
> time spent in __remove_privs because we're looking up the non-existent
> xattr.
>
> --21.86%--btrfs_write_check.constprop.0
>   --21.62%--__file_remove_privs
>     --21.55%--security_inode_need_killpriv
>       --21.54%--cap_inode_need_killpriv
>         --21.53%--__vfs_getxattr
>           --20.89%--btrfs_getxattr
>
> Obviously this is just CPU time in a mostly IO bound test, so the actual
> effect of removing this callchain is minimal.  However in just normal
> testing of an idle system tracing showed around 100 getxattr calls per
> minute, and with this patch there are 0.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/btrfs_inode.h |  1 +
>  fs/btrfs/inode.c       |  7 +++++
>  fs/btrfs/xattr.c       | 59 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 5572ae52444e..de9f71743b6b 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -69,6 +69,7 @@ enum {
>         BTRFS_INODE_VERITY_IN_PROGRESS,
>         /* Set when this inode is a free space inode. */
>         BTRFS_INODE_FREE_SPACE_INODE,
> +       BTRFS_INODE_NO_CAP_XATTR,
>  };
>
>  /* in memory btrfs inode */
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 096b3004a19f..f8647d8271b7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6225,6 +6225,13 @@ int btrfs_create_new_inode(struct btrfs_trans_hand=
le *trans,
>         BTRFS_I(inode)->generation =3D trans->transid;
>         inode->i_generation =3D BTRFS_I(inode)->generation;
>
> +       /*
> +        * We don't have any capability xattrs set here yet, shortcut any
> +        * queries for the xattrs here.  If we add them later via the ino=
de
> +        * security init path or any other path this flag will be cleared=
.
> +        */
> +       set_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags)=
;
> +
>         /*
>          * Subvolumes don't inherit flags from their parent directory.
>          * Originally this was probably by accident, but we probably can'=
t
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 3cf236fb40a4..caf8de1158b9 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -382,6 +382,56 @@ static int btrfs_xattr_handler_set(const struct xatt=
r_handler *handler,
>         return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>  }
>
> +static int btrfs_xattr_handler_get_security(const struct xattr_handler *=
handler,
> +                                           struct dentry *unused,
> +                                           struct inode *inode,
> +                                           const char *name, void *buffe=
r,
> +                                           size_t size)
> +{
> +       int ret;
> +       bool is_cap =3D false;
> +
> +       name =3D xattr_full_name(handler, name);
> +
> +       /*
> +        * security.capability doesn't cache the results, so calls into u=
s
> +        * constantly to see if there's a capability xattr.  Cache the re=
sult
> +        * here in order to avoid wasting time doing lookups for xattrs w=
e know
> +        * don't exist.
> +        */
> +       if (!strcmp(name, XATTR_NAME_CAPS)) {
> +               is_cap =3D true;
> +               if (test_bit(BTRFS_INODE_NO_CAP_XATTR,
> +                            &BTRFS_I(inode)->runtime_flags))
> +                       return -ENODATA;
> +       }
> +
> +       ret =3D btrfs_getxattr(inode, name, buffer, size);
> +       if (ret =3D=3D -ENODATA && is_cap)
> +               set_bit(BTRFS_INODE_NO_CAP_XATTR,
> +                       &BTRFS_I(inode)->runtime_flags);
> +       return ret;
> +}
> +
> +static int btrfs_xattr_handler_set_security(const struct xattr_handler *=
handler,
> +                                           struct mnt_idmap *idmap,
> +                                           struct dentry *unused,
> +                                           struct inode *inode,
> +                                           const char *name,
> +                                           const void *buffer,
> +                                           size_t size, int flags)
> +{
> +       if (btrfs_root_readonly(BTRFS_I(inode)->root))
> +               return -EROFS;
> +
> +       name =3D xattr_full_name(handler, name);
> +       if (!strcmp(name, XATTR_NAME_CAPS))
> +               clear_bit(BTRFS_INODE_NO_CAP_XATTR,
> +                         &BTRFS_I(inode)->runtime_flags);
> +
> +       return btrfs_setxattr_trans(inode, name, buffer, size, flags);
> +}
> +
>  static int btrfs_xattr_handler_set_prop(const struct xattr_handler *hand=
ler,
>                                         struct mnt_idmap *idmap,
>                                         struct dentry *unused, struct ino=
de *inode,
> @@ -420,8 +470,8 @@ static int btrfs_xattr_handler_set_prop(const struct =
xattr_handler *handler,
>
>  static const struct xattr_handler btrfs_security_xattr_handler =3D {
>         .prefix =3D XATTR_SECURITY_PREFIX,
> -       .get =3D btrfs_xattr_handler_get,
> -       .set =3D btrfs_xattr_handler_set,
> +       .get =3D btrfs_xattr_handler_get_security,
> +       .set =3D btrfs_xattr_handler_set_security,
>  };
>
>  static const struct xattr_handler btrfs_trusted_xattr_handler =3D {
> @@ -473,6 +523,11 @@ static int btrfs_initxattrs(struct inode *inode,
>                 }
>                 strcpy(name, XATTR_SECURITY_PREFIX);
>                 strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
> +
> +               if (!strcmp(name, XATTR_NAME_CAPS))
> +                       clear_bit(BTRFS_INODE_NO_CAP_XATTR,
> +                                 &BTRFS_I(inode)->runtime_flags);
> +
>                 err =3D btrfs_setxattr(trans, inode, name, xattr->value,
>                                      xattr->value_len, 0);
>                 kfree(name);
> --
> 2.41.0
>
>

