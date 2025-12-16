Return-Path: <linux-btrfs+bounces-19802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4ECC49EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AADCD314FA8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB4324B0C;
	Tue, 16 Dec 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmg5po1U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCF319619
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904643; cv=none; b=HiMWsZFgQKkWuO90m8zXRJnBfpIZKAa1qxCz3QBXhxxACiUVLKkCoQgTyT7UYXPJ/+9AeGXmH4ptxqlICArrEtmPNxDX3+rLnt3uQCiI8dWDAm21Pxa964WYaE3rr7DspfD58tu20V7PZEQT/e1jcAqZP5Lvk85TFfC7uieBLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904643; c=relaxed/simple;
	bh=PigkXIt8LWcAdmEnKmeT/u8Fq5lEqCTrVAykFBbh3Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqkFjMTKp8LWntLkwcYUpWa6kx4HEfaqhy4fkKz+Um6k4opNzf3IVybgDELxIuR3PE8JYm5RQvvq5TCRz2qJR6W1ytsf0cG1NfZw6K5hErrLgK+tzN/l1n7B8cIMOyMZCkV+8wjpdZe2rGy62djylLwrxsymjkoG9wuXi7qGjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmg5po1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C9AC19422
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904642;
	bh=PigkXIt8LWcAdmEnKmeT/u8Fq5lEqCTrVAykFBbh3Pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mmg5po1UA+mueg8sybLorYAzQbeLwLhuDE1Q+/FgYN5hIZhGGMzBbR3JV5voeov0w
	 ZtM3pmh12JuInuaZCAeJjQjIkWhyjgM/RUWMzGLOOAOY4EZEqiiQIFyeKDWG5Ja8GH
	 YU4rJCxFmK4uKdYQCZqiRW+RvdcxPDMki4dLOiIKvtNnGClRj6Gslcm6AuxtQmhgyY
	 WvrYO/bQp3Q/cLbj2xB7KeolJEtherg2stEDzXdMIMqh9ysWUCTsAiT91YxB0tyhNL
	 fFJeqjupIfUloLOl/q+NcFCyQPqYWSkBAuCLXO/DOaHnctwnfEm2JIUjG4f6ZIQD0A
	 dHZv/SR1STj8g==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7277324204so779087066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:04:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyRN0rEoEJariA3JdYVOg/qwSDtYoz6sgJVMdpi3vzlwIWMpwKr
	eQ6J8FJp6JpoCumRmZ3uCmGkdQIdnVtPVE47IGGuvqPFJaefGoiQ9or0g3Wu290yXYWQ7xizbC4
	Kwe17p4DEyYjIkEzmbKT41k1QvRL6ARo=
X-Google-Smtp-Source: AGHT+IG/nyaKURBuUwXFHeTwGxlakTw0bm68A2+6fzTbC313z0F7ZoAn5BAKDrLHXddt+WECGyx3O9d2JCplE/PI0rg=
X-Received: by 2002:a17:907:d19:b0:b76:23b0:7d70 with SMTP id
 a640c23a62f3a-b7d23ad8414mr1748833166b.39.1765904641170; Tue, 16 Dec 2025
 09:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765899509.git.fdmanana@suse.com> <e6a497f1873cb9d8f7c734ffc8d4ab31641a1164.1765899509.git.fdmanana@suse.com>
 <20251216170051.GL3195@twin.jikos.cz>
In-Reply-To: <20251216170051.GL3195@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Dec 2025 17:03:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H57X80kjUJpXpx__jethFOjqzsFNmDXNS-3RZ1AMm_aTQ@mail.gmail.com>
X-Gm-Features: AQt7F2rJpI7g_UB6pzFbgGJZ3QTp_8t6CIQnmNsvehy2OcxHD1gTfByIgoqjVRQ
Message-ID: <CAL3q7H57X80kjUJpXpx__jethFOjqzsFNmDXNS-3RZ1AMm_aTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: don't call btrfs_handle_fs_error() after
 failure to join transaction
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 5:00=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Dec 16, 2025 at 04:33:18PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > In btrfs_find_orphan_roots() we don't need to call btrfs_handle_fs_erro=
r()
> > if we fail to join a transaction. This is because we haven't done anyth=
ing
> > yet regarding the current root and previous iterations of the loop deal=
t
> > with other roots, so there's nothing we need to undo. Instead log an er=
ror
> > message and return the error to the caller, which will result either in
> > a mount failure or remount failure (the only contextes it's called from=
).
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/root-tree.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index 40f9bc9485e8..a30c7bc3f0e5 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -264,8 +264,9 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *f=
s_info)
> >                       trans =3D btrfs_join_transaction(tree_root);
> >                       if (IS_ERR(trans)) {
> >                               ret =3D PTR_ERR(trans);
> > -                             btrfs_handle_fs_error(fs_info, ret,
> > -                                         "Failed to start trans to del=
ete orphan item");
> > +                             btrfs_err(fs_info,
> > +                       "failed to join transaction to delete orphan it=
em: %d\n",
>
> btrfs_err and the other helpers don't need "\n"

Yes, I missed that in this patch, the other similar ones don't have
the new line.
Will remove on commit time if there are no other changes needed.

