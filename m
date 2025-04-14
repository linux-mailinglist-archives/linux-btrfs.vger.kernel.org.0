Return-Path: <linux-btrfs+bounces-12992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75502A885DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C273BE441
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D627A124;
	Mon, 14 Apr 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JmtHzcMT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938E2749C6
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639816; cv=none; b=jULBt/WUzPbvdGy/VbqzuB/V8xmzZcnFQb+ji71klqXeD5PmYbTjAw2rQ5Vewimp5sjceSDTYH1f9UPmzKEThJgPHZmoBtJ1YFDYstOl6edj23mAIyWWf5VaSKeZ6+z2mhe6rJ3p2xYjq2eTdBSiITuC67UVOIB+ZM/zLWpqr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639816; c=relaxed/simple;
	bh=vDKshwSTLzfVb2b9QCGRuLoLV9vmwy7bdEHMCW4HXco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnfgJvwM/SII2KbIuWSyGmoTllBv+HV5olUfw0t3tmyUCLoo0JY3OTxilJ9Rsxt6bdSYcYSsba11GWgywnmvFUHnWnNhfMBtquMXPQqsExthlmWcAmDvH3MVn0SkxkOEM+5aMlYbiyGj4GmIkN1mXznBjI1I1JQXETGVrImg6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JmtHzcMT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac339f53df9so864493166b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744639812; x=1745244612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3ULzXYtgp5knes5jjtCb7NVfP7NhcV6WWSN7DiMNC0=;
        b=JmtHzcMTHHxQwX8jGlv0Ilp9i4Ot/f/2pFQ+/2+2dIAh4bOBDXtmw9W+EDhVvziJQW
         x+WxdRHD/FTySaQmmOuHD9gFBq69zHkiiNYIfQV9wdIVsbQrcdZ17EApD/3lNK7cIMOq
         32GItiv+XWXf1BLrFFU01rt40yuctHkUgOn6/Ckq4yxRC5TbdY+/5DS+Ft52aduM3Lrm
         CIcG4kf141QFMn34iruEro3ZJj5wU8wO7RILGaTuhUaZaaqsIqYfgZRMc6hkkYtiBNad
         hsN/zSGxNJmFV5VPrR+ZkRS4fpewCtiDBv8tP3Y0vySeLDYCNg4r9g+2n8zr0+hUfeo4
         OzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639812; x=1745244612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3ULzXYtgp5knes5jjtCb7NVfP7NhcV6WWSN7DiMNC0=;
        b=URc8F+a+DMsoI1Jb1BYBHYN+F8gPboPWasVt/gsxDOKa4xQMW5kB/WbUmvfdKUPAAD
         +ebiHzt/3etrK1Y/KqEe7NldGKEchTj6qi97G3RKkWcEAkwekZF9vp0SGMmtVMzAaLWa
         YbJRIFjyXwjZXW93uYXPOI8+WLj2HUNaZ1MvDLP0aUkw5qglVmtez6aWG4RCOxuM2RXe
         9FhcDa76k7zEjjHZL1yFQczZoaIUuLEUaIy91kPg2kkeglpayh2/jBmT/Gl/SFk4tjR9
         Yw9zZXesdBwQkAKGJQBV3TykGkzjJnDuzNGNtzF0mlDPvfUKZe7CmtuhHGwoFSygqaGp
         ByZw==
X-Forwarded-Encrypted: i=1; AJvYcCVbzWzABLkgOTX7tvbpIC/uNokA4WZL9Ay9tfGTgptJ7EYbfTu+2M5Dz1nXecVHJkff250K8wAr0JIJKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHl7E5MuLcIKqU7TkIph5VKPy0elRUmizjZeyRx1vKVEavoGPd
	uefn4+OCdtHAkWA4/GKFyozyGH5ciazNnZmEg7SmWdBrhQ/1YKN3atHZ8I2CZ3qe3QggSPfKtkn
	PpfaBO0yr6+i0DavQ7f8wSy+nRv6NTHebLz5f9w==
X-Gm-Gg: ASbGncu0X8BHINg6UYiFe43T/whBIUIzniK3L+6azxen/27qg/QaqyjLytoYtoesdTW
	/aBjIq/DiF5EbOz9RDIipUXjHVezaCMVPo0CYwI2aDJBQtBMdiXxoBtiLBqzqV7FlDtoOg3BeX5
	Xhza3YBfBdbbX7exKMcXuN
X-Google-Smtp-Source: AGHT+IELmTa6kdG3m1wAOWSwzEYUsnM/AZVCS9gi1W5ygeB0nf9Akb94M2AIebg2Cbph/RHIMED8A0XttdyPTJBTj2w=
X-Received: by 2002:a17:907:3d91:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-acad36da6b2mr1186418366b.59.1744639811991; Mon, 14 Apr 2025
 07:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411034425.173648-1-frank.li@vivo.com> <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
 <SEZPR06MB526928EBDA13B6463D7EE00BE8B32@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB526928EBDA13B6463D7EE00BE8B32@SEZPR06MB5269.apcprd06.prod.outlook.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 14 Apr 2025 16:10:01 +0200
X-Gm-Features: ATxdqUGqwksgvRY6yOhrk3sIyK_6RLT1HyjWUkZFMqMHqeY4xOQJGFeLp1V1UxM
Message-ID: <CAPjX3FcGaV9rQXRodznCud+_zzHao3ZWfNnuFAv=ut=uGi3MPw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_truncate_inode_items()
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"dsterba@suse.com" <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 at 15:34, =E6=9D=8E=E6=89=AC=E9=9F=AC <frank.li@vivo.co=
m> wrote:
>
> Hi Daniel,
>
> > And what about the other functions in that file? We could even get rid =
of two allocations passing the path from ..._inode_ref() to ..._inode_extre=
f().
>
> I made the following changes, is this what you meant?
> I will do the rest if that's ok.
>
> Thx,
> Yangtao
>
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 3530de0618c8..e082d7e27c29 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -105,11 +105,11 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle=
 *trans,
>
>  static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
>                                   struct btrfs_root *root,
> +                                 struct btrfs_path *path,
>                                   const struct fscrypt_str *name,
>                                   u64 inode_objectid, u64 ref_objectid,
>                                   u64 *index)
>  {
> -       struct btrfs_path *path;
>         struct btrfs_key key;
>         struct btrfs_inode_extref *extref;
>         struct extent_buffer *leaf;
> @@ -131,7 +131,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_=
handle *trans,
>         if (ret > 0)
>                 ret =3D -ENOENT;
>         if (ret < 0)
> -               goto out;
> +               return ret;
>
>         /*
>          * Sanity check - did we find the right item for this name?
> @@ -142,8 +142,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_=
handle *trans,
>                                                 ref_objectid, name);
>         if (!extref) {
>                 btrfs_abort_transaction(trans, -ENOENT);
> -               ret =3D -ENOENT;
> -               goto out;
> +               return -ENOENT;
>         }
>
>         leaf =3D path->nodes[0];
> @@ -156,8 +155,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_=
handle *trans,
>                  * Common case only one ref in the item, remove the
>                  * whole item.
>                  */
> -               ret =3D btrfs_del_item(trans, root, path);
> -               goto out;
> +               return btrfs_del_item(trans, root, path);
>         }
>
>         ptr =3D (unsigned long)extref;
> @@ -168,9 +166,6 @@ static int btrfs_del_inode_extref(struct btrfs_trans_=
handle *trans,
>
>         btrfs_truncate_item(trans, path, item_size - del_len, 1);
>
> -out:
> -       btrfs_free_path(path);
> -
>         return ret;

And if I look correctly you can also directly return 0 here.

>  }
>
> @@ -178,7 +173,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *tr=
ans,
>                         struct btrfs_root *root, const struct fscrypt_str=
 *name,
>                         u64 inode_objectid, u64 ref_objectid, u64 *index)
>  {
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         struct btrfs_key key;
>         struct btrfs_inode_ref *ref;
>         struct extent_buffer *leaf;
> @@ -230,7 +225,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *tr=
ans,
>                               item_size - (ptr + sub_item_len - item_star=
t));
>         btrfs_truncate_item(trans, path, item_size - sub_item_len, 1);
>  out:
> -       btrfs_free_path(path);
> +       btrfs_release_path(path);
>
>         if (search_ext_refs) {
>                 /*
> @@ -238,7 +233,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *tr=
ans,
>                  * name in our ref array. Find and remove the extended
>                  * inode ref then.
>                  */
> -               return btrfs_del_inode_extref(trans, root, name,
> +               return btrfs_del_inode_extref(trans, root, path, name,
>                                               inode_objectid, ref_objecti=
d, index);
>         }

