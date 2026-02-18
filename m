Return-Path: <linux-btrfs+bounces-21759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG5PObDUlWnFVAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21759-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:03:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B881573E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5495302AF27
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215A341058;
	Wed, 18 Feb 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V+GnKqXK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FE340A69
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426965; cv=pass; b=VU3FVbnHO976JuJuBfQBXkziBPmP9+YZlhcd4XAATIMhwws1IgMogE4qfLPwGns26snI4Hh34EfQBqzs319DHY6AMHvmYAtKzXEO4689R740nBqUNd0g8j7vQ+Nmy4QYn9UIgHYLYEsIUkTG7hmHd+UiY2GObM75W4maIxn5sWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426965; c=relaxed/simple;
	bh=udw/ZyTsHuwFOVBESJ/+qihOlfdgJM950rv/L+IknkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjcbdoa2wkjwh20v5C56y2NutykiFwqkdmLvon+hn8rwXs8sKKlbV8w7avmIIt/v05MynX9EHLMTzsSB7Bxj0hHzHT9+vsz8Wd55U6cOeaYr0o88vdjVrbXjUertHGi+J2PwL4xlONUmBrm10HNQXWi6KisJAeFI4/pkhgNFcyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V+GnKqXK; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so30084185e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 07:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426961; cv=none;
        d=google.com; s=arc-20240605;
        b=TxbqHD1pjdj+bFCjacPj4FGhhkddhnkSfuRc7H6nfBNfmAtS4z1DVbcVG9LXGwZTzs
         wQOdLNhd67oEWLrhuQXflTNQYBp/taV8LZaG9Mpids9YZtTzcoB/hYuzBTNKTCva/vt+
         hz2b9PuDhAyJjhzcNDI/HkdVwreNRjc/L1qmYGIN4BPJnsxPVmWM/gmfHkMD8NSIvlSU
         OM4i1lQ0nPitZfGb26cJOaXDVbNHNDNeGOEKX4go2movQlXYwpS0ZG5KJbKVjVgKdF8/
         ObISTEreLEqUrFtGTY58Kzgj2xSwb73VOjpPc6e9qIP++Q+dt1tKqBPh8g0Qoib0a9IJ
         m+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        fh=1monpwvYwye7QsOIVwSZ81I2Fu9dsv/VhHEBcZZu+Fw=;
        b=H4mhEp4yr4VIt069f2dv4df0lXctgr0yyCM/4LgRiGrsW8JUQpDd0+hZEZkFgtB3Vf
         EOysI7cmgUmYvB9gTzuh/sKP36Z+V2uga8Lt2mdr7mCIhTabs2+atSg0FyioysqwbHXi
         kCpJUHa2554UoXBPCq8iTdtqhO+j96j4/nH3lSllEtQmdmf9Mn/kDLQswp1nB4qQ3ahW
         emXLvDtrVHF0C8JG6OMCNZjxTHkCjCax2JtDyce3YTaO+dxZOnfKatdwkr5L8PMGEMpM
         IJN0YjZRTZgBIbDP+KyEEtxo7Dfq4ru/zBwWG2r2PeQnvzb5DCIyTiTsWke30rQLlFp4
         Wnpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771426961; x=1772031761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        b=V+GnKqXK60xaSJp2fZlMcxdqrWZWlyuvIxe5b7z69Ycpo06PAVrcE3DCVe/4lZrO/h
         a+LO52LcjnX8RPeBK38FQIbRW2t5p4QgITq+b/seBVc/nm8DgOLLqche7ucqkW+eNFTx
         86b98NQeX+5wShMg78VxLBTt2Gb3pkePa66IxvmX9wLJtxCSESq+Z6XCorkI3JvF8p4h
         JDybHtZvBeRBUu5TOfSx6DYsqOBLm76/FxdI0/8LkqE4wQJ6UVd2/wkTRxhETewCN9DT
         rxOCv/fQG2yvP1X6FKrQGxkEixttaZJdnZ+xExYL17sx/PL1qn8HaPZwO669LT/7rci7
         v2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426961; x=1772031761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f2knTNw8Y0yBkMXA6kc+4x2KQKgICuj4A91rn0T+Sg=;
        b=feJ9B22/eN3BLt2Po325YKL0iG/QBB6pP52crdFsKCdXk7O09U8y8K/8gAyFPJhJvk
         0quXbs75BkXe3PMD7OS285fuV8ioL0R/1Tca3m3NHs436RY+i5sK+4z7UT+duWOz7peI
         h4Sp9M7CKajQleqFKwVuLpfyzEDtO1xyVNk8X08WNx09T9kCfS76bXDATXXgz6hwW8jF
         zl8XUkMmeV+Jdawq8KEPtcnByLAiVWQuz2aBDTf/z/V5JcuhLduqk8HlcbKhg/V3lvdo
         J/BKohbUS/FmvcZCseRF0uCx7rm5LaIqh2Z+lXgcJPiZBC7qq8jPNondq4vlU0f7Yokb
         56aA==
X-Forwarded-Encrypted: i=1; AJvYcCXspIBu4ClAO/VtQ5AoDHUWIv6+9DT+nhQE0/Z3L4km+Pyt51iEV64h1zvztPVXLdxuB7l84hKJ+S96EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsSWz3DggmYuUL8CdfNe6gOXRIOz08NIY2cmp2TEtLX59ztTY
	YOW3T7qNlkiFKdNcdcn84iL3PrfuPcJkRF4QD0Z57qeGtrqiZg1ZsSdNjVs5ke95N/3JitwcN2s
	J5g6i2BJf4KFrnIcMXIpfyeI9WXuoYVS5pNqeMHEe5Q==
X-Gm-Gg: AZuq6aK0jcJBh8mjo1vI36NuK5831S+aaNu2R2RqNJ4mSsIiJl/kRuDAfP+S5ErMfan
	8DK3m4vMG09lhdn9VMPsvQGRzgWRYKcvENQdNQu/6XLzC9Zz7lLUdU7zUc6CCCABijE3MawKmje
	WBo6RLPWr3GINj7qfI6BzYTP5dcbTLfk/rSXAoUpUJ6MOc+0Pe2r9xQU5L2kXso4541MIC++5OR
	Gbfp6NghTMkeBrrQlMNX9cfZ5/lIuCjC9fvrz2KDjoThozrgXhBhJ1xAMckp1aTFHafgHOV93yQ
	hhwawM4pbn/71T3YZsi8DxeJtHiyqezIsvIY5JQP0SOL309QgeR47M7lOiaoFlnYDYHLkc0rNpO
	JJmiS
X-Received: by 2002:a05:600c:1c25:b0:483:54cc:cd97 with SMTP id
 5b1f17b1804b1-48379bfc340mr230018315e9.36.1771426961169; Wed, 18 Feb 2026
 07:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-17-neelx@suse.com>
 <20260208152448.3300594-1-clm@meta.com>
In-Reply-To: <20260208152448.3300594-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 16:02:29 +0100
X-Gm-Features: AaiRm50heuopm7EY7a7udAfEdRYxhS7H4B61tJOKCzqxGFffQrIvg06EGcnPVCY
Message-ID: <CAPjX3FegzEdCxfBq4mqW2mP_GDDuyS4NOQqgDThWdAHhr2tCOg@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] btrfs: select encryption dependencies if FS_ENCRYPTION
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,toxicpanda.com:email,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21759-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 78B881573E1
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:25, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We need this to make sure the appropriate encryption algorithms are
> > turned on in our config if we have FS_ENCRYPTION enabled, and
> > additionally we only support inline encryption with the fallback block
> > crypto, so we need to make sure we pull in those dependencies.
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
> commit 0ab45d92f6f53371d87e1a302f09b56218d02546
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: select encryption dependencies if FS_ENCRYPTION
>
> This commit adds select statements for encryption-related dependencies when
> FS_ENCRYPTION is enabled, including encryption algorithms, inline crypto, and
> the block layer inline encryption fallback.
>
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index ede184b6eda16..216a5707b099c 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -16,6 +16,9 @@ config BTRFS_FS
> >       select RAID6_PQ
> >       select XOR_BLOCKS
> >       select XXHASH
> > +     select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
> > +     select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
> > +     select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
>
> Are the dependencies for FS_ENCRYPTION_INLINE_CRYPT and
> BLK_INLINE_ENCRYPTION_FALLBACK satisfied?
>
> Looking at fs/crypto/Kconfig:38, FS_ENCRYPTION_INLINE_CRYPT depends on
> 'FS_ENCRYPTION && BLK_INLINE_ENCRYPTION'. Similarly, in block/Kconfig:204,
> BLK_INLINE_ENCRYPTION_FALLBACK depends on 'BLK_INLINE_ENCRYPTION'.
>
> When BTRFS_FS=y with FS_ENCRYPTION=y but BLK_INLINE_ENCRYPTION=n (which is
> valid), Kconfig will generate warnings:
>
>   WARNING: unmet direct dependencies detected for BLK_INLINE_ENCRYPTION_FALLBACK
>   WARNING: unmet direct dependencies detected for FS_ENCRYPTION_INLINE_CRYPT
>
> The build will fail when compiling fs/crypto/inline_crypt.c because
> BLK_INLINE_ENCRYPTION guards the required function definitions and struct
> members:
>
>   fs/crypto/inline_crypt.c:259:15: error: implicit declaration of function
>       'blk_crypto_derive_sw_secret'
>   fs/crypto/inline_crypt.c:317:9: error: implicit declaration of function
>       'bio_crypt_set_ctx'
>   fs/crypto/inline_crypt.c:418:45: error: 'struct bio' has no member named
>       'bi_crypt_context'
>
> Should BLK_INLINE_ENCRYPTION also be selected when FS_ENCRYPTION is enabled?

That's correct.

--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -18,6 +18,7 @@ config BTRFS_FS
     select XXHASH
     select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
     select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
+    select BLK_INLINE_ENCRYPTION if FS_ENCRYPTION
     select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
     depends on PAGE_SIZE_LESS_THAN_256KB


Thanks.

--nX

>   select BLK_INLINE_ENCRYPTION if FS_ENCRYPTION
>   select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>   select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
>   select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
>
> >       depends on PAGE_SIZE_LESS_THAN_256KB
> >
> >       help
>

