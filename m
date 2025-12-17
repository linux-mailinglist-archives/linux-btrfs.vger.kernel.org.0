Return-Path: <linux-btrfs+bounces-19845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480ECC8E13
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BCD30ACB67
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A779354AC4;
	Wed, 17 Dec 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRlTIxzn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660C35C19B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989504; cv=none; b=Nr3QTN5Dj4uBV+V5MBOFe8pKFWQkquc2glpBoq20HaTOIbr8mlO1iGeQQRPdQ4u6pFq+mOuKqONtGBbEkvGY9sWkIC/hvQS8U+HxyPNHYIv53//x11ka/xJZCSc6VyxDM/gyxu0dgEpvG44qQLofOpBQmsXgcoiu1TQdHE95dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989504; c=relaxed/simple;
	bh=TNvy7btdN9wv6SiY255isxOcdfs73lHqe/O5weIren4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDbqTiyOJ/hdFZ3w0Ej5Yq3FqBoaJBzpcp2KjQIgqqx8ErQZpHasBVorW+6ojxdgYwyJiYm3qWiGlRfIZf+BcJGFQYGLJ9mS34SaE0hqeyevNpegUBBUm7k7B1IuTYRTQZYF11IfFpSvb8wRGJMAwY3Fk3VcYR16Apoptugsvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRlTIxzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DB3C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765989503;
	bh=TNvy7btdN9wv6SiY255isxOcdfs73lHqe/O5weIren4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vRlTIxzn/akM2BOenYeN9N+cQv0m/q2KZp+QhNwqG3XwbyYgGk/ZVAFdkzaQuAlbR
	 3emUugiKyOwH5rjEgdrL3zX5qbzr20khZQj4OI42nhcDYvoBQxaS1Vo6bI4kNYLd+Z
	 5hRZGHpqAq4Rojepvfil7o0SEU4Vo/fRsRtJb0WLSZ9OFO2e6P0hrsaj9sjvmUN/gq
	 pd4JSJEtfaq2LuddLpSvhDdfIN2hrHd+61G+jO5wUn5Uc9rL13u3Oa1hkmSznbdB41
	 Pd1NAkG+XiFuA3qbLdv/sAuG3hTHRCtmTl8J9LeDe8K5anlREohQ+73xrNQN5glBer
	 7Bk1FhqhX8vqA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b75c7cb722aso1080441066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:38:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3FBaQ8kDKOtDmmiMOCItGREaQbRLpWAv2IvVBupxIrv7bbQic
	X5LYAOrbRXrwBHpylsYX9pCpFLQOqp+l53yL97QRnV0soSlURelRJmRJLtdX71KlWXwqirrIcMt
	uiL4eXZlytzd0jiA2ZaOOPWXIBMI7ujA=
X-Google-Smtp-Source: AGHT+IG+NrQabKOTgq7KyKkSnIE3iTWYwg3UjqzGRsp8KoB+Fn+sSRyfoo80pObOW5ulamItAFhIwIPSOVurFIfMg5E=
X-Received: by 2002:a17:907:1c0b:b0:b7a:1be1:984 with SMTP id
 a640c23a62f3a-b7d23a912c7mr1653395866b.64.1765989502330; Wed, 17 Dec 2025
 08:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com> <20251217134139.275174-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251217134139.275174-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Dec 2025 16:37:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dWNWgpkfB+ra38rccpPranT_SJXK4y-6DQAvpbH3gbg@mail.gmail.com>
X-Gm-Features: AQt7F2rLjMwF1tNxJzhtACbC20s753Rhm1nTgffSnbHqJrQxavH07j1K2S4zLek
Message-ID: <CAL3q7H6dWNWgpkfB+ra38rccpPranT_SJXK4y-6DQAvpbH3gbg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] btrfs: remove zoned statistics from sysfs
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:03=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Remove the newly introduced zoned statistics from sysfs, as sysfs can
> only show a single page this will truncate the output on a busy
> filesystem.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/sysfs.c | 52 ------------------------------------------------
>  1 file changed, 52 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7f00e4babbc1..f0974f4c0ae4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -25,7 +25,6 @@
>  #include "misc.h"
>  #include "fs.h"
>  #include "accessors.h"
> -#include "zoned.h"
>
>  /*
>   * Structure name                       Path
> @@ -1188,56 +1187,6 @@ static ssize_t btrfs_commit_stats_store(struct kob=
ject *kobj,
>  }
>  BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stat=
s_store);
>
> -static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
> -                                     struct kobj_attribute *a, char *buf=
)
> -{
> -       struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> -       struct btrfs_block_group *bg;
> -       size_t ret =3D 0;
> -
> -
> -       if (!btrfs_is_zoned(fs_info))
> -               return ret;
> -
> -       spin_lock(&fs_info->zone_active_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "active block-groups: %zu\n",
> -                            list_count_nodes(&fs_info->zone_active_bgs))=
;
> -       spin_unlock(&fs_info->zone_active_bgs_lock);
> -
> -       mutex_lock(&fs_info->reclaim_bgs_lock);
> -       spin_lock(&fs_info->unused_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "\treclaimable: %zu\n",
> -                            list_count_nodes(&fs_info->reclaim_bgs));
> -       ret +=3D sysfs_emit_at(buf, ret, "\tunused: %zu\n",
> -                            list_count_nodes(&fs_info->unused_bgs));
> -       spin_unlock(&fs_info->unused_bgs_lock);
> -       mutex_unlock(&fs_info->reclaim_bgs_lock);
> -
> -       ret +=3D sysfs_emit_at(buf, ret, "\tneed reclaim: %s\n",
> -                            str_true_false(btrfs_zoned_should_reclaim(fs=
_info)));
> -
> -       if (fs_info->data_reloc_bg)
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "data relocation block-group: %llu\n=
",
> -                                    fs_info->data_reloc_bg);
> -       if (fs_info->treelog_bg)
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "tree-log block-group: %llu\n",
> -                                    fs_info->treelog_bg);
> -
> -       spin_lock(&fs_info->zone_active_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "active zones:\n");
> -       list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list=
) {
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "\tstart: %llu, wp: %llu used: %llu,=
 reserved: %llu, unusable: %llu\n",
> -                                    bg->start, bg->alloc_offset, bg->use=
d,
> -                                    bg->reserved, bg->zone_unusable);
> -       }
> -       spin_unlock(&fs_info->zone_active_bgs_lock);
> -       return ret;
> -}
> -BTRFS_ATTR(, zoned_stats, btrfs_zoned_stats_show);
> -
>  static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
>                                 struct kobj_attribute *a, char *buf)
>  {
> @@ -1649,7 +1598,6 @@ static const struct attribute *btrfs_attrs[] =3D {
>         BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>         BTRFS_ATTR_PTR(, commit_stats),
>         BTRFS_ATTR_PTR(, temp_fsid),
> -       BTRFS_ATTR_PTR(, zoned_stats),
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         BTRFS_ATTR_PTR(, offload_csum),
>  #endif
> --
> 2.52.0
>
>

