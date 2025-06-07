Return-Path: <linux-btrfs+bounces-14543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493DAD0D57
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF12517326E
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA421C189;
	Sat,  7 Jun 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORaCwNJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BB4C8F
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749298826; cv=none; b=piLDD3C+j6oxQAh3p6C+RY1GvaebiqGtF1syJRE3FjM67VPosKPSLPc7fWonIBCzOdD/BS2TxKjZ+pA/SU6W48OYj6OuMGlde0yi0ufwyHY9jbWZxHaBbYOcsp/6Xtp89fVBKugA1CsPL2+d9OLlNA2OzYP5RjC9G8PmtQEX+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749298826; c=relaxed/simple;
	bh=bxI1pOJadgO9YNtZ71BMErkprcfbv/VWsaA985ZPo2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/+0SSCKi87YooCLBbCfeUpibQH4nG4vB1bPwaiO9RvztrXjXPed/VVt5KcjrzGTMTYzukJ0jgimpiIeNkOqyPufaa9qq3q0GChxIceeQKiKKUOwMziLIUL4J1M+wsThzVwG5b9x8lpri6VXlViPg+6F12P1tERNuPwNDzsHKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORaCwNJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167D3C4CEE4
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749298826;
	bh=bxI1pOJadgO9YNtZ71BMErkprcfbv/VWsaA985ZPo2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ORaCwNJ8urHvmGE7OyrnxhSMkjqMnY1JqiEgA4SwrfS/gfVaCzUGn1QJ1te0mUEuv
	 Ridjxv8CH6Skw9ljSg4or0YYBh1tndvK74vMSc7gmvJAusZM9eRvKtk3IdJsBU57cv
	 WckV0AUBbgqy8AH5wnzCrKv7e6G5Vp2OOX0XIvAbalo0ya5LxuITyzE85aVPU5XDOs
	 +inx3VXLoKcvbeQnQ9yJyPr3qD6BdKRYdIgLF9Cd4H3vHzAHIMfzfRZgPt/fS6orDT
	 UZkwKhsVxSUbbbHCPynA5ADY3aD6TnYwF6Y+GUuCc5yzYnL4pX5QqBvNT5o524RLoe
	 dhhLxTUtULByw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-addfe17ec0bso709049766b.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Jun 2025 05:20:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8i7nGDK7ZV2mO5cyFnCbrEGy7mC+gkzx1JWaUXuoSgOUn4LUs4bTDxJAp3Dw2D8UOU5FQS1IkU4JhgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvij0UjXNphLgIwo95/voEASHNHhDcHt+OQmwymbn3O0UFDYp0
	k9W460flCph+XR4XaTqDuYe2XDPpm/grRjRtUejrHe2bxPyWJOtuErDu1iaZHZYgPUvo2QJdqAq
	FmVI6K8DPoCnWkWNA5naim971UmwZ7T0=
X-Google-Smtp-Source: AGHT+IGcmgZxBl5iUJ3tVPTIhxMa7jEs1fMl05iTCCRXtxyJ/hbv/spPXprJG9FdPFpZd5X32QnyNrhwMfuS0TTzlGs=
X-Received: by 2002:a17:907:1c26:b0:ad8:942b:1d53 with SMTP id
 a640c23a62f3a-ade078951c7mr890570366b.27.1749298824677; Sat, 07 Jun 2025
 05:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607111531.28065-1-abinashsinghlalotra@gmail.com>
In-Reply-To: <20250607111531.28065-1-abinashsinghlalotra@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 7 Jun 2025 13:19:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6mBPDryyOtVWvv98+otergLUZxNN300R6PGwEgnvn+2g@mail.gmail.com>
X-Gm-Features: AX0GCFsLBHf5kILZAybHEA_Xvoh5ArU9Z2LeK5Hs17IrkJRfBJJ-kbOdY92VFN0
Message-ID: <CAL3q7H6mBPDryyOtVWvv98+otergLUZxNN300R6PGwEgnvn+2g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove ASSERT in populate_free_space_tree for
 empty extent tree btrfs_search_slot_for_read() returns 1 when no items are found
To: avinashlalotra <abinashlalotra@gmail.com>
Cc: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com, clm@fb.com, 
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	avinashlalotra <abinashsinghlalotra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 12:16=E2=80=AFPM avinashlalotra <abinashlalotra@gmai=
l.com> wrote:
>
>  but populate_free_space_tree() has ASSERT(ret =3D=3D 0) which panics on =
empty
>  extent trees. Empty extent trees are valid (new block groups, after

No, an empty extent tree is impossible.
There are always some metadata trees and a default subvolume tree,
even on empty fs, and therefore there are metadata extents allocated
and the extent tree is not empty.

You could have checked that with a fs just created with mkfs.btrfs for
example...
So no, that's not the reason why the assertion is being triggered.

I also suggest next time to use a shorter subject instead of this:

"btrfs: remove ASSERT in populate_free_space_tree for empty extent
tree btrfs_search_slot_for_read() returns 1 when no items are found"

That has to be the longest subject I have ever seen. There's no need
to explain everything in a subject, just summarize.

>  deletions) so remove the assert and handle ret =3D=3D 1 by skipping the =
scan
>  loop.
>
> Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
> Signed-off-by: avinashlalotra <abinashsinghlalotra@gmail.com>
> ---
>  fs/btrfs/free-space-tree.c | 62 ++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 0c573d46639a..beffe52dfa59 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1115,43 +1115,45 @@ static int populate_free_space_tree(struct btrfs_=
trans_handle *trans,
>         ret =3D btrfs_search_slot_for_read(extent_root, &key, path, 1, 0)=
;
>         if (ret < 0)
>                 goto out_locked;
> -       ASSERT(ret =3D=3D 0);
>
>         start =3D block_group->start;
>         end =3D block_group->start + block_group->length;
> -       while (1) {
> -               btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0=
]);
> -
> -               if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> -                   key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> -                       if (key.objectid >=3D end)
> -                               break;
>
> -                       if (start < key.objectid) {
> -                               ret =3D __add_to_free_space_tree(trans,
> -                                                              block_grou=
p,
> -                                                              path2, sta=
rt,
> -                                                              key.object=
id -
> -                                                              start);
> -                               if (ret)
> -                                       goto out_locked;
> +       if (ret =3D=3D 0) {
> +               while (1) {

There's no need to surround everything with such an if statement and
add yet more indentation to the code...

Anyway this was already fixed several days ago at:

https://lore.kernel.org/linux-btrfs/f60761dc5dd7376ac91d0a645bd2c3a59a68cee=
7.1749153697.git.fdmanana@suse.com/

Thanks.


> +                       btrfs_item_key_to_cpu(path->nodes[0], &key, path-=
>slots[0]);
> +
> +                       if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> +                           key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> +                               if (key.objectid >=3D end)
> +                                       break;
> +
> +                               if (start < key.objectid) {
> +                                       ret =3D __add_to_free_space_tree(=
trans,
> +                                                                      bl=
ock_group,
> +                                                                      pa=
th2, start,
> +                                                                      ke=
y.objectid -
> +                                                                      st=
art);
> +                                       if (ret)
> +                                               goto out_locked;
> +                               }
> +                               start =3D key.objectid;
> +                               if (key.type =3D=3D BTRFS_METADATA_ITEM_K=
EY)
> +                                       start +=3D trans->fs_info->nodesi=
ze;
> +                               else
> +                                       start +=3D key.offset;
> +                       } else if (key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM=
_KEY) {
> +                               if (key.objectid !=3D block_group->start)
> +                                       break;
>                         }
> -                       start =3D key.objectid;
> -                       if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY)
> -                               start +=3D trans->fs_info->nodesize;
> -                       else
> -                               start +=3D key.offset;
> -               } else if (key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY) {
> -                       if (key.objectid !=3D block_group->start)
> +
> +                       ret =3D btrfs_next_item(extent_root, path);
> +                       if (ret < 0)
> +                               goto out_locked;
> +                       if (ret)
>                                 break;
>                 }
> -
> -               ret =3D btrfs_next_item(extent_root, path);
> -               if (ret < 0)
> -                       goto out_locked;
> -               if (ret)
> -                       break;
> -       }
> +       }
>         if (start < end) {
>                 ret =3D __add_to_free_space_tree(trans, block_group, path=
2,
>                                                start, end - start);
> --
> 2.43.0
>
>

