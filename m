Return-Path: <linux-btrfs+bounces-21757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KjpBOPRlWlEVAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21757-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:51:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4081572E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4F130265A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA933123F;
	Wed, 18 Feb 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Btz8khYt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185A33372A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426256; cv=pass; b=gMJxcFLxRAJVCKNgEPMsNA8eM3Vgm13+GJv+2Wb9pMwNyvazS0U5btp9gCkuLxEmCFv05l2F+psUo0rzUm0h5G68b6rIWNe9sOhRNwq/UfWNXJmSvHuPcGQPktn6w6HOcaqvh0/y+vV1gQEv40r60WmHNAaiPTJRmxJt97pV/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426256; c=relaxed/simple;
	bh=ayix/lpTEKTXsxUj2iKsjlFXfV7GOzT2zS6Ou5e131g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR7uZSXmSsEkXaKegZg5Y8TnxKKZU1PR0I6C6pW80eGNJcdH6EuquHLRc8ob86GbwMLS0fac4wK6M6Ds7c5IE52bj/cZ1aBP7xwuks9H+PAsCQCO/zUJkXhA85lADWrrAtoaapIi+OMYJrVA6qCwWZRwIAwVvophQDMqfSktMbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Btz8khYt; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436e87589e8so6438650f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 06:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426254; cv=none;
        d=google.com; s=arc-20240605;
        b=hrKrFSUVL5NqtNQQmFJvRKxp5mgI4v401Um0xhV4F/4LFXzMvboeav54G50iR//UpB
         Bk2rLYhex7qvnnwOlI/WxIa6Ub1uJeAH+BFMVG+txCJF1fL71wz3mK7hHE5slcfb2Xt0
         UqwAK4r3z4DD4Qia6h5TaykZQUJhSXlp4Oo+IjHDfHnIg5iGaxQ32I+CEZ+bOfmq4abJ
         D5VkBIP+kGdTsK7NqAJ05r5umm7Wn9fTSVRFX5lU+HyXWASVJFyIcmxDwwY+iPmG4h6T
         2mLkU+URoGSYtzfXXz62WO2f+UPtqYCgftJn7JVhWUzkDtl/02aZHPCAFqsnzI8ABLqI
         wAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        fh=01Ivp+39pJqT6CGCAVXzY9dBj+XNP4adcgCtiVhHMtU=;
        b=a/ru0qc3HbSoT+aIuDJsOSmvKHeIH3fe94mHG/MHEkLLWzOYlmqqicGFHAVKQde6e+
         q/yTIZl0efpCmnRosqREuNYveVJqkAW74VP/6jHronexlsakJnHAZ7JEekQELdPrgyFW
         3abH2vF1Ybn69gYQMy1/T7APQQ9BFSk2H4gACI0isiQ/IuuBnquSZ+mhvVhhVtOHZEZB
         BMF+BJEDXrSglKQRBHg6ps0nrgnmNIGvSF8vjpiWboRmTQTjypWy4XferLtWgaGNuq3k
         N7YP0zczeIpwqgllfjojQA8iCRXkli77PSRcWpjymHs5bt3Gu8k9ZAxkO467ZQSg8gic
         27bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771426254; x=1772031054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        b=Btz8khYtvNNsriVVeD6o6jXJ0W2Zjd7ItjK9kGtxHF5uZn0F5QYETeWA82Y7lAVbrW
         yOQ6GtzDcDWe/G5oPOHJNjHzsZXf05USpHbBMIipOB3s7eKpXmDec1mzLJ2OH5T/s+0J
         Z/Vc0AqWQ+cLF7wop8hhzL5WfTkLd6hQHLIKVREKCqJkxO844CVseJhe3vYj1Bh+eHJ2
         iIjdx9MMC4kLwixNEVvqD4EsyN3YAynm84fmsxoPNV3KskrOS/rKWKvbrAtf1YYV/QT4
         dX6q/hlUf6TSdswnyntXVAnnCgPVeDg5/om0obqPjDIOVQVYytb1jrq08em9DV1YqqdJ
         yLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426254; x=1772031054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgscmaEOFxBbw8YrW9Yjg3xpxOoa9kw0yRjQzXqorpc=;
        b=wt2ZhoCFqXuN75TLWJk2b+xnCysmQhZvIXZCHVVo3CKXa4XdvBzrb90sRK/SwIWAgg
         VoFQ/Po0SU8RY3b/kyvyUDbSoMoAMuRaZR3cjIhJzWbVZIcxe1kewE5cIMgdcI6E7vEL
         bSltBPNCbwgZ/NW1O48P1NR1qWQk0Ypy5DcBj4BiaZLX/chmfiWUShNGOe2Vg1y8tuQh
         vRqeBAtwDxHbc7lV28GPm4lWGSRvVmXgis3bpSN0BaNgnGZ383WmoTcHOvbfhPcHHlQD
         OE4Oie1jdHPt8UZqvU+gC0mXHMqFbKXtSlVNgotIIgJp6eqK2wfHViQxId0d/L5K25j/
         +9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOPc1334gPT0SC7qCp1BM7pp+oY1nUnSRxVbCQwLp47ouYM2jQ5N3Dxl57Gi6RZbibJ8V7jTnzI5xnzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBysSWkQVNJ2FJQUftOakgfu1g5R49Ml9cAyC+jc53YxOZYxV
	uFU1c/2sUIy9xY9HmvYSTYUMyAljyrVSzRabvap/wypuwuvwBZ/mRuBOpBSm7MGxlEx2u5JGL73
	96kd6KUTfe1utvlRYUBA0b+bm6munbpOPobb6pgx++w==
X-Gm-Gg: AZuq6aKKTdfHGTRt2y4qegTI8C1TiBNsstottT/vrgpafDzyrj4szLfNkMB1rMMpCTv
	mHa2w74FfJr7sNPgn2bQOqnDQkTx1HIL8vafdFBZQCdiLcUtNCm/FCI4AZ7g4c3OWM3B80HZOUR
	PTA0/tfP6CIkKif3igCFna+vvEOwSoC9Tv5H4OLkSKELlC4hKOZ5nNWmCwIZMUF0ISe0KW6P6VP
	4gGDRRHPcwabSJOFzsUISX4P0Vf/g89gtOu5b7+lYbLx1XUh/GRxngAEq1QrheXmXIkbDs4tkCA
	QE4l/dQgPrOGTL554UG//tU3C+pRW70JmEdo9nLuHZoESCuubfDCcHZz7ADlJIu+jtj4PnAqI4Y
	ZvEPmeDfZ4C7kjwA=
X-Received: by 2002:a05:6000:4284:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-43797913f31mr29698913f8f.34.1771426253517; Wed, 18 Feb 2026
 06:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-15-neelx@suse.com>
 <20260208152914.3379032-1-clm@meta.com>
In-Reply-To: <20260208152914.3379032-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 15:50:42 +0100
X-Gm-Features: AaiRm5279eD5QNXNIKOKA9PJgdBQDs7fON79j563pfmi1shHVB7og3gAxuO5tGo
Message-ID: <CAPjX3FcyGRN4PZSJCjj37TtK3cYjkBK8qiguPRZFDyQ1igH4cQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/43] btrfs: handle nokey names
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21757-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 8D4081572E7
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:30, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >
> > For encrypted or unencrypted names, we calculate the offset for the dir
> > item by hashing the name for the dir item. However, this doesn't work
> > for a long nokey name, where we do not have the complete ciphertext.
> > Instead, fscrypt stores the filesystem-provided hash in the nokey name,
> > and we can extract it from the fscrypt_name structure in such a case.
> >
> > Additionally, for nokey names, if we find the nokey name on disk we can
> > update the fscrypt_name with the disk name, so add that to searching for
> > diritems.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit fabad1c3ea82184fba8e78ce1da1b2fbe8c34fae
> Author: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>
> btrfs: handle nokey names
>
> This commit adds support for handling nokey names in btrfs, enabling
> proper hash calculation and disk name extraction for long encrypted
> filenames when the encryption key is unavailable.
>
> > diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> > index 6e10dd4a4e9e1..75c213bd826e9 100644
> > --- a/fs/btrfs/dir-item.c
> > +++ b/fs/btrfs/dir-item.c
> > @@ -228,6 +228,27 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
> >       return di;
> >  }
> >
> > +/*
> > + * If appropriate, populate the disk name for a fscrypt_name looked up without
> > + * a key.
> > + *
> > + * @path:    The path to the extent buffer in which the name was found.
> > + * @di:              The dir item corresponding.
> > + * @fname:   The fscrypt_name to perhaps populate.
> > + *
> > + * Returns: 0 if the name is already populated or the dir item doesn't exist
> > + * or the name was successfully populated, else an error code.
> > + */
> > +static int ensure_disk_name_from_dir_item(struct btrfs_path *path,
> > +                                       struct btrfs_dir_item *di,
> > +                                       struct fscrypt_name *name)
> > +{
> > +     if (name->disk_name.name || !di)
> > +             return 0;
> > +
> > +     return btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
> > +}
> > +
>
> [ ... ]
>
> > @@ -263,6 +287,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
> >
> >       if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
> >               return NULL;
> > +     if (ret == 0)
> > +             ret = ensure_disk_name_from_dir_item(path, di, name);
> >       if (ret < 0)
> >               di = ERR_PTR(ret);
> >
>
> Does ensure_disk_name_from_dir_item() leak memory when it allocates a
> disk name? Looking at the call chain:
>
> btrfs_unlink_subvol() at inode.c:4583 calls btrfs_lookup_dir_item_fname(),
> which calls ensure_disk_name_from_dir_item(), which calls
> btrfs_fscrypt_get_disk_name() at fscrypt.c:34, allocating memory via
> kmalloc() and storing it in name->disk_name.name.
>
> However, btrfs_unlink_subvol() cleans up with fscrypt_free_filename() at
> include/linux/fscrypt.h:503, which only frees name->crypto_buf.name, not
> name->disk_name.name.
>
> The same issue appears in btrfs_search_dir_index_item() at line 405, which
> also calls ensure_disk_name_from_dir_item().
>
> For nokey encrypted filenames, wouldn't this leak memory on every
> successful lookup?

Should `name->crypto_buf.name` equal to `name->disk_name.name` in this case?
How about this:

--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -243,10 +243,18 @@ static int ensure_disk_name_from_dir_item(struct
btrfs_path *path,
                       struct btrfs_dir_item *di,
                       struct fscrypt_name *name)
 {
+    int ret;
+
     if (name->disk_name.name || !di)
         return 0;

-    return btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
+    ret = btrfs_fscrypt_get_disk_name(path->nodes[0], di, &name->disk_name);
+    if (ret)
+        return ret;
+
+    name->crypto_buf.name = name->disk_name.name;
+    name->crypto_buf.len  = name->disk_name.len;
+    return 0;
 }

 /*

Thanks.

--nX

