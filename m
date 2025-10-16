Return-Path: <linux-btrfs+bounces-17888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E0FBE4281
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EBD19C7656
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143B3314CC;
	Thu, 16 Oct 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc5scoDz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCE1CDFD5
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627720; cv=none; b=rhlIe8dLyq8aDbwaHpXTYd5+Enu8fsE0b7fQeY6H9SRXs5SuVJAw+5Tyftr3+gZq4UKlcuTtokflVlA78hoqu1JfnPe6ZQ2iT/wg7NS6YmnxOEQggAxTRKhiFlREUdkgp5wW5aFBPSWzrSrcyFUXiDv3dLZgwK4MW5bNYMwhV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627720; c=relaxed/simple;
	bh=Z+htzNHkfJ1d7Dko3zKvBZBvS3FdcE1tyKgC4i+wIZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmHt83xFYjmmdHRvbxIUa0m1S4hQdUfz4TM/xAVUYIpz8v3emOBVlcD39mS9EkVdsv/EdFqDG3FWMIe4xuav4H8RdHdwJMkYlCuZ09hmd3rl+VZBsaIebCy6cKKXIwcEOVLkScCNK2TSTq98h4mA9TQWljIp91c+eKpa2X9aEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc5scoDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE9BC4CEF1
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627719;
	bh=Z+htzNHkfJ1d7Dko3zKvBZBvS3FdcE1tyKgC4i+wIZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oc5scoDzASYLliC2mpPJ3DoV9sw1d69fBczkhEv0Y753Pynsz3KxXYNTnh94Zzjqa
	 B0CoAAl6EuEFGm6QXomoiXhnNU+eBz4frL0BTfLESG8kOAaw51IRAeVy6i5Doi8iDk
	 ZOmvOPzABMkDQzNMJDPbP0iU4g84jfiav5DfOZK+0495eRUFax5MsGdtEYrbVZhDeR
	 v2LDXK5ybhL9hCKD+JyHBCFr2Yu/YRV0njvyw2D92CO2dJ6ESEARKDgnWh+NBiASyw
	 2FSsPuZjFSDN6b39Ib9fSzKejqRzHrg+sGnKU8T4TQ3RHKaBPuufYydvgR77uUIFMd
	 wZ4w5sF5HqNcg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07d4d24d09so138471166b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 08:15:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuTcath+VEUGGDPl4/5DN/wPgOSPcWUY1ZAhRMCIbrepxqG6ly
	JlM2Q6CKM40hc5aHiD8MoexlOqk7lDoDTEQ3fF9VdcYKW8ZNOIy0C8SxBNGGGrPBWpeol+iTgdd
	Ki3jBuZvCSKyqS6DWFyHpv8I0J/1KyZg=
X-Google-Smtp-Source: AGHT+IENOGhyI50igIQ00dk8b3QZ5i+fKbauYmWFLnPr4SIJKdXk4yieZnsOag9eN95jtd95rhgoDzmemeUZ9DgHTfg=
X-Received: by 2002:a17:907:5c8:b0:b40:2873:a60c with SMTP id
 a640c23a62f3a-b6472c5c6ddmr33427966b.3.1760627718379; Thu, 16 Oct 2025
 08:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016075351.3369720-1-tchou@synology.com>
In-Reply-To: <20251016075351.3369720-1-tchou@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 Oct 2025 16:14:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4OjcSJzPy=f=JhJMzYMxM2UQT994JbdmFdtNKi5Pb3UA@mail.gmail.com>
X-Gm-Features: AS18NWAd_SV7-SBuLOFBMZnvbaBav8-ZuQ_Sjk6_AUgla3pLJaH9FLNl5Y1bMFU
Message-ID: <CAL3q7H4OjcSJzPy=f=JhJMzYMxM2UQT994JbdmFdtNKi5Pb3UA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: don't send rmdir for same target multiple
 times with multi hardlink situation
To: tchou <tchou@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:55=E2=80=AFAM tchou <tchou@synology.com> wrote:
>
> From: Ting-Chang Hou <tchou@synology.com>
>
> In commit 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target

Please leave a space before the opening parenthesis, that's the right synta=
x.

> multiple times") has fixed the issue that btrfs send rmdir for same
> target multiple times by keep the last_dir_ino_rm and compare with
> it before sending rmdir. But there have a corner case that if the
> instructions that rm same dir not in a row, the fix will not work.
>
> Hardlinks of file are store in the same INODE_REF item, and if the

They are if they are in the same parent directory, that's an important deta=
il.

> number of hardlinks is too large and exceed the size of one metadata
> node can store, it will use INODE_EXTREF to store. The key of
> INODE_EXTREF is (inode_id, INODE_EXTREF, hash of name), so if there are

hash of name and parent inode number

> two dir have hardlinks to the same file, the INODE_EXTREF items will
> have cross sequence with two dir like below:

Suggestion: add a blank line to separate text from tree-dump output.
It makes things more readable and easier to the eyes.

>     item 0 key (404 INODE_EXTREF 111512) itemoff 16239 itemsize 44
>         inode extref index 4825 parent 403 namelen 4 name: 4824
>         inode extref index 5825 parent 402 namelen 4 name: 5824
>     item 1 key (404 INODE_EXTREF 398645) itemoff 16195 itemsize 44
>         inode extref index 4569 parent 403 namelen 4 name: 4568
>         inode extref index 5569 parent 402 namelen 4 name: 5568
>
> So when doing btrfs send, the instructions that rmdir for the two dir
> are not in a row, and the previous fix will not work.
>
> We use rbtree to keep all the dirs that already add into `check_dirs`,

Just say that the fix of this patch does that.
When you say "We use..." it gives the idea that's the code we
currently have before this patch.

> and compare with it before add a new dir into it.
>
> The reproduce steps are as below:

Same here, blank line.

>     $ mkfs.btrfs -f /dev/sdb3
>     $ mount /dev/sdb3 /mnt/
>     $ mkdir /mnt/a /mnt/b
>     $ echo 123 > /mnt/a/foo
>     $ for i in $(seq 1 10000); do ln /mnt/a/foo /mnt/a/foo.$i; ln /mnt/a/=
foo /mnt/b/foo.$i; done
>     $ btrfs subvolume snapshot -r /mnt/ /mnt/snap1
>     $ btrfs send /mnt/snap1 -f /tmp/base.send
>     $ rm -r /mnt/a /mnt/b
>     $ btrfs subvolume snapshot -r /mnt/ /mnt/snap2
>     $ btrfs send -p /mnt/snap1 /mnt/snap2 -f /tmp/incremental.send
>
>     $ umount /mnt
>     $ mkfs.btrfs -f /dev/sdb3
>     $ mount /dev/sdb3 /mnt
>     $ btrfs receive /mnt -f /tmp/base.send
>     $ btrfs receive /mnt -f /tmp/incremental.send

Suggestion: instead of pasting those lines with the $ and hardcoded
mount points and device paths, turn it into a configurable script and
paste it.
Like this:

#!/bin/bash

DEV=3D/dev/sdi
MNT=3D/mnt/sdi

mkfs.btrfs -f $DEV
mount $DEV $MNT

mkdir $MNT/a $MNT/b

echo 123 > $MNT/a/foo
for ((i =3D 1; i <=3D 1000; i++)); do
   ln $MNT/a/foo $MNT/a/foo.$i
   ln $MNT/a/foo $MNT/b/foo.$i
done

btrfs subvolume snapshot -r $MNT $MNT/snap1
btrfs send $MNT/snap1 -f /tmp/base.send

rm -r $MNT/a $MNT/b

btrfs subvolume snapshot -r $MNT $MNT/snap2
btrfs send -p $MNT/snap1 $MNT/snap2 -f /tmp/incremental.send

umount $MNT
mkfs.btrfs -f $DEV
mount $DEV $MNT

btrfs receive $MNT -f /tmp/base.send
btrfs receive $MNT -f /tmp/incremental.send

rm -f /tmp/base.send /tmp/incremental.send

umount $MNT

See, much easier to read, with more spaces and logical grouping, and
variables to define device and mount paths, so like this anyone can
copy paste this into a script, change the variables and immediately
test.
1000 iterations for the loop is also more than enough to trigger the
bug and it's a lot quicker than 10 000.

>
> The second btrfs receive command failed with:
>     ERROR: rmdir o4205145-4190-0 failed: No such file or directory
>
> Fixes: 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target multip=
le times")

A Fixes tag is meant to be used to identify commits that introduce a bug.
In this case, as you said in the first paragraph, that commit did not
introduce the bug.
It fixed cases of duplicated rmdir for the same directory as long as
we don't have extrefs, but it didn't introduce the bug for when there
are extrefs, it simply missed that case that already existed before.
In other words, the reproducer fails both before and after that commit.

Also, that's a very long and confusing subject:

btrfs: send: don't send rmdir for same target multiple times with
multi hardlink situation

I'm changing it to:

btrfs: send: fix duplicated rmdir operations when using extrefs

> Signed-off-by: Ting-Chang Hou <tchou@synology.com>
> ---
>  fs/btrfs/send.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 9230e5066fc6..c1b596e5f145 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4100,6 +4100,48 @@ static int refresh_ref_path(struct send_ctx *sctx,=
 struct recorded_ref *ref)
>         return ret;
>  }
>
> +static int rbtree_check_dir_ref_comp(const void *k, const struct rb_node=
 *node)
> +{
> +       const struct recorded_ref *data =3D k;
> +       const struct recorded_ref *ref =3D rb_entry(node, struct recorded=
_ref, node);
> +
> +       if (data->dir > ref->dir)
> +               return 1;
> +       if (data->dir < ref->dir)
> +               return -1;
> +       if (data->dir_gen > ref->dir_gen)
> +               return 1;
> +       if (data->dir_gen < ref->dir_gen)
> +               return -1;
> +       return 0;
> +}
> +
> +static bool rbtree_check_dir_ref_less(struct rb_node *node, const struct=
 rb_node *parent)
> +{
> +       const struct recorded_ref *entry =3D rb_entry(node, struct record=
ed_ref, node);
> +
> +       return rbtree_check_dir_ref_comp(entry, parent) < 0;
> +}
> +
> +static int record_check_dir_ref_in_tree(struct rb_root *root,
> +                       struct recorded_ref *ref, struct list_head *list)
> +{
> +       int ret =3D 0;
> +       struct recorded_ref *tmp_ref =3D NULL;

There's no need to initialize these variables.
It's not about being pedantic here, but unnecessary initializations
often trigger warnings from static analysis tools.
For example see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D966de47ff0c9e64d74e1719e4480b7c34f6190fa

> +
> +       if (rb_find(ref, root, rbtree_check_dir_ref_comp))
> +               return 0;
> +
> +       ret =3D dup_ref(ref, list);
> +       if (ret < 0)
> +               return ret;
> +
> +       tmp_ref =3D list_last_entry(list, struct recorded_ref, list);
> +       rb_add(&tmp_ref->node, root, rbtree_check_dir_ref_less);
> +       tmp_ref->root =3D root;
> +       return 0;
> +}
> +
>  static int rename_current_inode(struct send_ctx *sctx,
>                                 struct fs_path *current_path,
>                                 struct fs_path *new_path)
> @@ -4131,7 +4173,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>         u64 ow_inode =3D 0;
>         u64 ow_gen;
>         u64 ow_mode;
> -       u64 last_dir_ino_rm =3D 0;
> +       struct rb_root rbtree_check_dirs =3D RB_ROOT;

I'm moving this declaration to be right below the checks_dirs list
declaration, because these members are closely related and therefore
it makes more sense to have them close to each other.

You don't need to send another patch version.
I did those changes and rewrote sentences to fix grammar and make it
less confusing and more detailed and pushed the patch to for-next [1].

Also, do you plan to send a test case for fstests?

Thanks.

[1] https://github.com/btrfs/linux/commits/for-next/


>         bool did_overwrite =3D false;
>         bool is_orphan =3D false;
>         bool can_rename =3D true;
> @@ -4435,7 +4477,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                                         goto out;
>                         }
>                 }
> -               ret =3D dup_ref(cur, &check_dirs);
> +               ret =3D record_check_dir_ref_in_tree(&rbtree_check_dirs, =
cur, &check_dirs);
>                 if (ret < 0)
>                         goto out;
>         }
> @@ -4463,7 +4505,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                 }
>
>                 list_for_each_entry(cur, &sctx->deleted_refs, list) {
> -                       ret =3D dup_ref(cur, &check_dirs);
> +                       ret =3D record_check_dir_ref_in_tree(&rbtree_chec=
k_dirs, cur, &check_dirs);
>                         if (ret < 0)
>                                 goto out;
>                 }
> @@ -4473,7 +4515,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                  * We have a moved dir. Add the old parent to check_dirs
>                  */
>                 cur =3D list_first_entry(&sctx->deleted_refs, struct reco=
rded_ref, list);
> -               ret =3D dup_ref(cur, &check_dirs);
> +               ret =3D record_check_dir_ref_in_tree(&rbtree_check_dirs, =
cur, &check_dirs);
>                 if (ret < 0)
>                         goto out;
>         } else if (!S_ISDIR(sctx->cur_inode_mode)) {
> @@ -4507,7 +4549,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                                 if (is_current_inode_path(sctx, cur->full=
_path))
>                                         fs_path_reset(&sctx->cur_inode_pa=
th);
>                         }
> -                       ret =3D dup_ref(cur, &check_dirs);
> +                       ret =3D record_check_dir_ref_in_tree(&rbtree_chec=
k_dirs, cur, &check_dirs);
>                         if (ret < 0)
>                                 goto out;
>                 }
> @@ -4550,8 +4592,7 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                         ret =3D cache_dir_utimes(sctx, cur->dir, cur->dir=
_gen);
>                         if (ret < 0)
>                                 goto out;
> -               } else if (ret =3D=3D inode_state_did_delete &&
> -                          cur->dir !=3D last_dir_ino_rm) {
> +               } else if (ret =3D=3D inode_state_did_delete) {
>                         ret =3D can_rmdir(sctx, cur->dir, cur->dir_gen);
>                         if (ret < 0)
>                                 goto out;
> @@ -4563,7 +4604,6 @@ static int process_recorded_refs(struct send_ctx *s=
ctx, int *pending_move)
>                                 ret =3D send_rmdir(sctx, valid_path);
>                                 if (ret < 0)
>                                         goto out;
> -                               last_dir_ino_rm =3D cur->dir;
>                         }
>                 }
>         }
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.
>

