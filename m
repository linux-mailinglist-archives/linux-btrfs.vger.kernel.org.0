Return-Path: <linux-btrfs+bounces-21499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKogJiDqiGmZygQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21499-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:55:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31210A0D7
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9276B300C901
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B073246F0;
	Sun,  8 Feb 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsRAk9+l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329813019CB
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580505; cv=none; b=lNH2T9roghANKnlGtpjexHmJNXU97eFDjvYVRq1xZUGEtbCCvJjnJ7P88I8F5ytzI9F2diS/7x/Zr4wsBXC7ec7XyqwBF4weuv/PQhB6kEM3T4mXuG7bY7f7mVnDgYF8XxVsScrkYhk6JZAh3t4vByaR8UUu5V+imsoV10RAu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580505; c=relaxed/simple;
	bh=Nl2agSyU/JmVpkkVc8jDjW20GmrkSLm99Vm8dnk6ySE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siNCpjQ5EzGixbZiWdwoWRoKSn329+sUf/yfRL4dPP7ZuS+sJaNXYrG1DX3TFSOe/dv0B9gaOiM/+/TSoOzWhGs7B6dvd09iHUpSJcJqLFtSNutQzB9aAQ04RW+KIn42V0z8Hz+qNXc8SOkYKp+hJpCeLc1AdsLDkp107YBE8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsRAk9+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0CAC4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770580504;
	bh=Nl2agSyU/JmVpkkVc8jDjW20GmrkSLm99Vm8dnk6ySE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PsRAk9+l2cg1SvPWYY1NjMegzwatIzBvS+LmKNvKMKExL6YMjLtqQpYITZ+jq0qcx
	 FHL8iEGNlR/oYmkBlg/TMwRU2J2H7eVRAuzxAp+6wEFrqwUmxHFIoDzst3wRfZkBLK
	 FMzeGh8cSkF2ugt6XkVjptYkFMiwp2UzQSBL4HD7ELJXZuZDd4HuZ4efLkKGxWxOyt
	 DwI4l8Gmw53indAR7/ZXLmJguIgBJlEOeUq2/HIcqREcKEc+Hk0zUrvjS/JFukTdrv
	 otp3w14tyP2sztEyPLS04/h5YNsjpLaycdBvuualUqVhXjdw3ATIr5N1TDNKRvdUgi
	 NJeNqnp6qALpw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c6700so634873666b.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 11:55:04 -0800 (PST)
X-Gm-Message-State: AOJu0YwDgO7upRcwZd3yoc++TiCSRj6nqoieUJ79aArcw1FOTIiIj0w1
	6caMZZ1ExF9bjmQYaZxeIgGVDVSCVOQiH0yz/mOOI4hle5s/ryT/Kg/acfzG1H4sneICH3tryJJ
	AnP2nn35ILfnvOCzunuh8MV4dl1Xrf68=
X-Received: by 2002:a17:907:9706:b0:b76:63b8:7394 with SMTP id
 a640c23a62f3a-b8edf376df1mr520003966b.51.1770580503301; Sun, 08 Feb 2026
 11:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765899509.git.fdmanana@suse.com> <d95588f0ae2023c3b12817f868b26929eceb63b5.1765899509.git.fdmanana@suse.com>
 <20260208185321.1128472-1-clm@meta.com>
In-Reply-To: <20260208185321.1128472-1-clm@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 8 Feb 2026 19:54:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53HbPeHMjyJcq+w=LMNJ63Ryx8TT=sWNFo_ETfTgD2fQ@mail.gmail.com>
X-Gm-Features: AZwV_QgDZQZJDobJlTlqiyOnST9B8NafUDEJtejVbdorkpTJDFZ8LI1P4Q-O74s
Message-ID: <CAL3q7H53HbPeHMjyJcq+w=LMNJ63Ryx8TT=sWNFo_ETfTgD2fQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use single return variable in btrfs_find_orphan_roots()
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21499-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,meta.com:email]
X-Rspamd-Queue-Id: EC31210A0D7
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 6:53=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We use both 'ret' and 'err' which is a pattern that generates confusion
> > and resulted in subtle bugs in the past. Remove 'err' and use only 'ret=
'.
> > Also move simplify the error flow by directy returning from the functio=
n
> > instead of breaking of the loop, since there are no resources to cleanu=
p
> > after the loop.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch se=
t
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these revi=
ews
> are already useful.  I've kept the headers to make it easier to double ch=
eck
> that I'm actually replying to the right email, but please let me know if =
any
> parts of this are incorrect:
>
> commit 8670a25ecb2fbc35d4e58f8f522e7d5b735d6778
> Author: Filipe Manana <fdmanana@suse.com>
>
> btrfs: use single return variable in btrfs_find_orphan_roots()
>
> This commit refactors btrfs_find_orphan_roots() to use a single return
> variable 'ret' instead of both 'ret' and 'err', and simplifies the error
> flow by directly returning from the function instead of breaking out of
> the loop.
>
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index 6a7e297ab0a7a..a7171112d638f 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
>
> [ ... ]
>
> > @@ -217,8 +217,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *f=
s_info)
> >       BTRFS_PATH_AUTO_FREE(path);
> >       struct btrfs_key key;
> >       struct btrfs_root *root;
> > -     int err =3D 0;
> > -     int ret;
> >
> >       path =3D btrfs_alloc_path();
> >       if (!path)
> > @@ -230,20 +228,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info =
*fs_info)
> >
> >       while (1) {
> >               u64 root_objectid;
> > +             int ret;
> >
> >               ret =3D btrfs_search_slot(NULL, tree_root, &key, path, 0,=
 0);
> > -             if (ret < 0) {
> > -                     err =3D ret;
> > -                     break;
> > -             }
> > +             if (ret < 0)
> > +                     return ret;
> >
> >               leaf =3D path->nodes[0];
> >               if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> >                       ret =3D btrfs_next_leaf(tree_root, path);
> >                       if (ret < 0)
> > -                             err =3D ret;
> > -                     if (ret !=3D 0)
> > -                             break;
> > +                             return ret;
> > +                     else if (ret > 0)
> > +                             return 0;
> >                       leaf =3D path->nodes[0];
> >               }
> >
> > @@ -252,34 +249,33 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info =
*fs_info)
> >
> >               if (key.objectid !=3D BTRFS_ORPHAN_OBJECTID ||
> >                   key.type !=3D BTRFS_ORPHAN_ITEM_KEY)
> > -                     break;
> > +                     return 0;
> >
> >               root_objectid =3D key.offset;
> >               key.offset++;
> >
> >               root =3D btrfs_get_fs_root(fs_info, root_objectid, false)=
;
> > -             err =3D PTR_ERR_OR_ZERO(root);
> > -             if (err && err !=3D -ENOENT) {
> > +             ret =3D PTR_ERR_OR_ZERO(root);
> > +             if (ret && ret !=3D -ENOENT) {
> >                       break;
>                         ^^^^
>
> Does this code lose the error code from btrfs_get_fs_root()?

It does indeed. Fix sent here:

https://lore.kernel.org/linux-btrfs/6400dc5103b5ddbe543961b4e865e311ab39679=
0.1770580302.git.fdmanana@suse.com/

Thanks.

>
> The refactoring moved 'int ret' from function scope (line 217 in the old
> code) to loop scope (inside the 'while (1)' loop). When btrfs_get_fs_root=
()
> fails with an error like -ENOMEM or -EIO, the code breaks out of the loop=
.
> However, the 'ret' variable containing the error is scoped to the loop bo=
dy
> and goes out of scope after the break.
>
> The function then returns 0 at line 303, losing the error code. This
> violates the commit message's stated intent to "directly return from the
> function instead of breaking of the loop."
>
> Looking at btrfs_get_fs_root() in fs/btrfs/disk-io.c, it can return:
> - -ENOMEM if path allocation fails (line 1316)
> - -EIO or other errors from btrfs_read_tree_root() (line 1301)
> - errors from btrfs_init_fs_root() (line 1310)
> - -EIO from btrfs_search_slot() (line 1323)
>
> If btrfs_get_fs_root() fails during mount due to memory pressure or I/O
> errors, the mount will succeed instead of failing. This can lead to
> filesystem corruption because the orphan root handling is incomplete but =
the
> mount proceeds anyway.
>
> Shouldn't this 'break;' be 'return ret;' to match all the other error pat=
hs
> in the refactored function?
>
> > -             } else if (err =3D=3D -ENOENT) {
> > +             } else if (ret =3D=3D -ENOENT) {
> >                       struct btrfs_trans_handle *trans;
> >
> >                       btrfs_release_path(path);
> >
> >                       trans =3D btrfs_join_transaction(tree_root);
> >                       if (IS_ERR(trans)) {
> > -                             err =3D PTR_ERR(trans);
> > -                             btrfs_handle_fs_error(fs_info, err,
> > +                             ret =3D PTR_ERR(trans);
> > +                             btrfs_handle_fs_error(fs_info, ret,
> >                                           "Failed to start trans to del=
ete orphan item");
> > -                             break;
> > +                             return ret;
> >                       }
> > -                     err =3D btrfs_del_orphan_item(trans, tree_root,
> > -                                                 root_objectid);
> > +                     ret =3D btrfs_del_orphan_item(trans, tree_root, r=
oot_objectid);
> >                       btrfs_end_transaction(trans);
> > -                     if (err) {
> > -                             btrfs_handle_fs_error(fs_info, err,
> > +                     if (ret) {
> > +                             btrfs_handle_fs_error(fs_info, ret,
> >                                           "Failed to delete root orphan=
 item");
> > -                             break;
> > +                             return ret;
> >                       }
> >                       continue;
> >               }
>

