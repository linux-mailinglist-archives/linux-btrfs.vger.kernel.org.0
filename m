Return-Path: <linux-btrfs+bounces-12281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A085A60F61
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FCB1B6261A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6811FCFE7;
	Fri, 14 Mar 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3VagSI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361A1FCFC5
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949677; cv=none; b=Z4GDR0H8fWZLfdxozZw68IJofxWiXaMGfPiop5hvbQ91SJkmXtTQ+6uEMzovETG01N1W6HKbjOtGc6cWThdulRaQ1mvzlGwfRPGvmD2OfGOLpIay3erNCZ7g5YfIKS1knh6aLqaFp5FJOmGA/tanPd93/t/ve1vVp8N3s2ial9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949677; c=relaxed/simple;
	bh=ndIgdtcETIc5bHbtFFJxFN8rd8IfNkYcF5+cuCx47Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIN9kVEeoxjLJ1m/DBm6RaEtFIc5HTjNx7xf+7vSYnxUM+RVvYIOgwW5W2GWMoatXTO3hZYmSPH9aCdn5ZLktm78JiU1f5tYwxUOiDX9rQSot17GBBiJNljBKL0TTTMCnaasV7U8vZMhs+elPe/ZG4O9vmzwsFXeCjKae2fxbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3VagSI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90FBC4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949676;
	bh=ndIgdtcETIc5bHbtFFJxFN8rd8IfNkYcF5+cuCx47Jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D3VagSI7ZmOmBOOwfjWmnKpDtL+0EG8iDhNNqz98hVib1fOVf2XS45kuxn11n+nlJ
	 OnaGDdOfy4A/K8oLeD2t6rikRnsgvJ/JbrIb35rbkO0YNQn4DjFFdKgbpAIocLQ1bd
	 i3IvLUUQYBK9vog81y9C5s5ahvmTXLDd6SldULOw0JLJ9I1BoXRJkT4CF6mpViG54M
	 5KtKzcItd6Du/K5Ldd17EVXLokjSNkzLldXz3TxH1giHBqY3tcugaYvCDDEIVTrbfZ
	 i2yNV2KFqCeYBtnK8a8/A1GSKmIff2QAnsOe/xbxMIOsV/D8YTYsf4ko2r6On/5IuB
	 M/wX+B5iBAjog==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac289147833so345126766b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 03:54:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO9yNDvKDYTfR99pWg5El/jeSydyraMLHlf6k8NeKF/7jcAPtAbeu6cs0cdy8GPrMMR2CCVeYEIJHEwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9RzeuW9l4i9fHSfNEMlutUJO5Jbs1ZivfG3BAvlNVIqa7H47o
	1rDDT0XwFRWw7i65Shxz2R3nL+0zeqA5Xf7/6h97BCJcbZee7deBB4GKVUGxF1ZG5VwyB9eVECC
	NS/JPqJPhHoAFdhMQWn2mr2mJ3Lk=
X-Google-Smtp-Source: AGHT+IEJyCnRPr1HU4kESbB0UaTr0okzQe2LmkU8tHzFZlrdD+mxsoRngqQOcC8gEZLDmh67YGl+pOjhwllwFnWc/NE=
X-Received: by 2002:a17:907:2dac:b0:abf:7b38:7e64 with SMTP id
 a640c23a62f3a-ac330396bccmr230477066b.43.1741949675339; Fri, 14 Mar 2025
 03:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dac006d7-406b-4985-9a08-0d0a7a744e0d@stanley.mountain>
In-Reply-To: <dac006d7-406b-4985-9a08-0d0a7a744e0d@stanley.mountain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 14 Mar 2025 10:53:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Rr9Pa3yXsCs7Jt0bTdNc+Xr-d2k4tPoZRq2m+bmR=VQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq_cm9QCWdrP7_qfsz6vM2CdUHo9MfjHTy3x1YE31kNkLPHwcR90UrNwGk
Message-ID: <CAL3q7H6Rr9Pa3yXsCs7Jt0bTdNc+Xr-d2k4tPoZRq2m+bmR=VQ@mail.gmail.com>
Subject: Re: [bug report] btrfs: make btrfs_iget() return a btrfs inode instead
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:12=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Filipe Manana,
>
> Commit 991961deef25 ("btrfs: make btrfs_iget() return a btrfs inode
> instead") from Mar 7, 2025 (linux-next), leads to the following
> Smatch static checker warning:
>
>         fs/btrfs/export.c:222 btrfs_get_parent()
>         error: double free of 'path' (line 217)
>
> fs/btrfs/export.c
>     146 struct dentry *btrfs_get_parent(struct dentry *child)
>     147 {
>     148         struct btrfs_inode *dir =3D BTRFS_I(d_inode(child));
>     149         struct btrfs_inode *inode;
>     150         struct btrfs_root *root =3D dir->root;
>     151         struct btrfs_fs_info *fs_info =3D root->fs_info;
>     152         struct btrfs_path *path;
>     153         struct extent_buffer *leaf;
>     154         struct btrfs_root_ref *ref;
>     155         struct btrfs_key key;
>     156         struct btrfs_key found_key;
>     157         int ret;
>     158
>     159         path =3D btrfs_alloc_path();
>     160         if (!path)
>     161                 return ERR_PTR(-ENOMEM);
>     162
>     163         if (btrfs_ino(dir) =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
>     164                 key.objectid =3D btrfs_root_id(root);
>     165                 key.type =3D BTRFS_ROOT_BACKREF_KEY;
>     166                 key.offset =3D (u64)-1;
>     167                 root =3D fs_info->tree_root;
>     168         } else {
>     169                 key.objectid =3D btrfs_ino(dir);
>     170                 key.type =3D BTRFS_INODE_REF_KEY;
>     171                 key.offset =3D (u64)-1;
>     172         }
>     173
>     174         ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>     175         if (ret < 0)
>     176                 goto fail;
>     177         if (ret =3D=3D 0) {
>     178                 /*
>     179                  * Key with offset of -1 found, there would have =
to exist an
>     180                  * inode with such number or a root with such id.
>     181                  */
>     182                 ret =3D -EUCLEAN;
>     183                 goto fail;
>     184         }
>     185
>     186         if (path->slots[0] =3D=3D 0) {
>     187                 ret =3D -ENOENT;
>     188                 goto fail;
>     189         }
>     190
>     191         path->slots[0]--;
>     192         leaf =3D path->nodes[0];
>     193
>     194         btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>     195         if (found_key.objectid !=3D key.objectid || found_key.typ=
e !=3D key.type) {
>     196                 ret =3D -ENOENT;
>     197                 goto fail;
>     198         }
>     199
>     200         if (found_key.type =3D=3D BTRFS_ROOT_BACKREF_KEY) {
>     201                 ref =3D btrfs_item_ptr(leaf, path->slots[0],
>     202                                      struct btrfs_root_ref);
>     203                 key.objectid =3D btrfs_root_ref_dirid(leaf, ref);
>     204         } else {
>     205                 key.objectid =3D found_key.offset;
>     206         }
>     207         btrfs_free_path(path);
>                                 ^^^^
>
>     208
>     209         if (found_key.type =3D=3D BTRFS_ROOT_BACKREF_KEY) {
>     210                 return btrfs_get_dentry(fs_info->sb, key.objectid=
,
>     211                                         found_key.offset, 0);
>     212         }
>     213
>     214         inode =3D btrfs_iget(key.objectid, root);
>     215         if (IS_ERR(inode)) {
>     216                 ret =3D PTR_ERR(inode);
>     217                 goto fail;
>                         ^^^^^^^^^

Fixed in the for-next branch at github:

https://github.com/btrfs/linux/commits/for-next/

The fix is just to return ERR_CAST(inode) instead of the goto.

Thanks.

>
>     218         }
>     219
>     220         return d_obtain_alias(&inode->vfs_inode);
>     221 fail:
> --> 222         btrfs_free_path(path);
>                                 ^^^^
>
>     223         return ERR_PTR(ret);
>     224 }
>
> regards,
> dan carpenter
>

