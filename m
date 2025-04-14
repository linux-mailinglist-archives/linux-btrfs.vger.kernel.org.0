Return-Path: <linux-btrfs+bounces-12991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E543DA8857F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836DB562650
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654032D11DB;
	Mon, 14 Apr 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Osyoiobh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3442DFA37
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639615; cv=none; b=ADq+LNa6geCG5kGscNtoFKD9SLo/u7T6fNiAOMslO7c+6MtUg/JMRBEr2koyrzNQSVcv8bD3TTljeDu7sUYGlcnThq8I7usMwgsvRPt+IOE+ZnC2BRmQujiJyobiLqgiUAcRmb7bg01gT30D6q1ELJxvZfEboDgDjfE/WmebJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639615; c=relaxed/simple;
	bh=2QUBlplyQJWl9S4zK6K4LHurh5B+0TICwmMWJN2IXjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVNwr/ee2nzjKucHXos2QEku6RXkd/JRQRKoo8MS4kPHFN3kOQFKpinaklZq67kMC9+mqweyow9AWt6YcO4zQCWxj2255Ifrb8H2VSEa5HtzHSb0xRX+et8m+tOg/ZkBG5pKsU8fiUxFytvD4Q1E71yE4L477VWmvf+TDexoE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Osyoiobh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39727fe912cso2094716f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744639611; x=1745244411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZANWr26SSzxqVBiw0ZxH74tF6wUKUhC5cuFBxT2B9Y=;
        b=OsyoiobhZ3YtbggWu9V2T2lz9ZNSXnaGUUGkauw5fNpBmHs247XcgeJngBJd+tt9gK
         N+6qjjxBKLV84fr9NXFs5IzkqbMdf9wfB7RJaUsdZSoM3dmpnFyWE0bzfZhFFee3AK0t
         sBJwPwx0a+2erY+SvqPbwH8zv2GF8DAhzBIhUN/PrrFoxhchSLfO7Z1NqCsUNwjfgyp5
         pIBNOWyQOGWfPznyO2LHrfYBCHV5icv+8ghUYyZ5e6GKM37hnJNbaAJU7CaXWvTZEX8o
         q6sj5KbDfxEXsEdW4k5V2fbL6rGoK9hYz+ItzxDdBZ/4u+cKcX1VwP+auZgSxy6JlcsR
         L2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639611; x=1745244411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZANWr26SSzxqVBiw0ZxH74tF6wUKUhC5cuFBxT2B9Y=;
        b=PgN496SlHUiexKVtWT9tx7b2IokKeovN3BtdQH+smdVyFpEhMjBIzIsShrmmEgvgoa
         pRcFjIip2zJ5kPUEVNUIlIjBiaYRVwo8hheRZUtFaf5uRL1a5seDdwxmyf7YmNhYIYav
         ScHE0R8wjCgK7MvBMm2mDPTW+STfYFYM4JvutPD76U+HZEGKjg5vlb0PzpqRVCRA/Dg2
         zTg65gBNtiKTGv8wIkdcRpoVcdU4JoSMkhc5TDjS0g7w+aZA09Rj39ibeJpwpgi3YUY6
         nl1MiPRtUBpNGDHGybn1YXP+vWAqPUX4nxN3jud2+yb0+vl45xge+Da+38g8rN1E4lVr
         m8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWGas9yQzR/LijYqySxD0foYFE4icbkC+bsn3/Wykf0Oq9/47Y6wuvC186858y8sRoxt1x7p5WMukA++A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwygKLMguoa6wlbuqQEvqfG+zLzJzQgEFAugOMjiwQNg5ZfDkP7
	r6jEpj5Ox+bd+k0D+BVXjy5xCvmzWccgoxS6S7VTOV+4/+Uaka2B7hDsIgurJ/Ni7MsUNlzBhra
	wECcWDnO8busD5UZLR5D+Oa7d9JoClWK+MkZvTw==
X-Gm-Gg: ASbGncvIHCFJwcZcfEv4UuT5FIrlzIzjB3OFI0P5hcUY9racaaS8oFYfhj8bxAiVJC7
	cvpGyplatCoM9GgaJ0f58L8G1hlSx869UNPHvbj0hkS52SewiX9JK5pxPv29GhuSk40gnemH1ic
	pSqg4SllUsFD/zqY/BU5tg
X-Google-Smtp-Source: AGHT+IGIEb3J2eaC+jpEeKoJQOWenQvI7Y7xQNvlpyXmkSIvuGR+dzo/NzSMEJQfpSPAALfI3ekbcx2r+teM4mNhkKs=
X-Received: by 2002:a05:6000:2582:b0:391:2c0c:1270 with SMTP id
 ffacd0b85a97d-39ea51d3250mr10332610f8f.1.1744639611467; Mon, 14 Apr 2025
 07:06:51 -0700 (PDT)
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
Date: Mon, 14 Apr 2025 16:06:40 +0200
X-Gm-Features: ATxdqUGmaNE0hisBQuDtH3seyNpXnSL7WLVbsXMaKZCMNBua4cNq-4zahUUW6HA
Message-ID: <CAPjX3Ff8BQr+Wh0WtsvKcBa1qxiyPCm=0tLW=OKFJCqtLOqkPw@mail.gmail.com>
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

Yeah, quite almost.

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

I think you missed this:

@@ -123,10 +123,6 @@ static int btrfs_del_inode_extref(struct
btrfs_trans_handle *trans,
        key.type =3D BTRFS_INODE_EXTREF_KEY;
        key.offset =3D btrfs_extref_hash(ref_objectid, name->name, name->le=
n);

-       path =3D btrfs_alloc_path();
-       if (!path)
-               return -ENOMEM;
-
        ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
        if (ret > 0)
                ret =3D -ENOENT;

Which was ironically the whole point ;-)

> @@ -131,7 +131,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_=
handle *trans,
>         if (ret > 0)
>                 ret =3D -ENOENT;

You can also directly return -ENOENT; here.

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

