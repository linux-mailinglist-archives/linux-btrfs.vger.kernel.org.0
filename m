Return-Path: <linux-btrfs+bounces-7122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D91294EC4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3245C1F2205C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD6178390;
	Mon, 12 Aug 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="oFNIYytW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE316BE2C
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464240; cv=none; b=BAjjhPZJ03wTYs6uwqJG2/QX1fCDkDiSU9J/mJ4ByJgfMusq6gEmrZM0Cwmds3KtTMp2UwJfX7OgoFVJN8ea1Y6x2OPy5l0jMPHxM3XfCJR4EeN246x9m0beU3kf8lyydMqjhaOtvuVrA8Hh8kEg7CpeXRvFWtwWoTxewoGhVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464240; c=relaxed/simple;
	bh=1CtL2wEPGtNYkmup9JH4Pxu3lkJZ8+OVRCzNog3I1d4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R4ODJjMGxMwcKJVM6R+/AdM3ChmSDk5EKHEUAYktGt97eWrztMa8KnCLVGBhgv4d1LapiWVf1MNQgL8JXiaF+yhBtnnTRR7ge2uWFyh5dK12HubowuxaGU2qHatKt32cAld2J+zfIn8+CHT9HNlKeGOhdrmSUIGfZFMLuu1eA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=oFNIYytW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efdf02d13so7154597e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723464236; x=1724069036; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHB6Syh0cqRJ7/Goc9rsKVI9ZgMN8/vxCzgWlnm4/aQ=;
        b=oFNIYytWby3cQscxiJwBblsWqyiBMnJsbJ93DyHRAENd0KCevt7wHF7IoruhKLfztI
         dmR6tHi8FthiTfY/aW7Tl5ZmmJQ8fqYiemzPICCvdQ8nE0exbrTlFgn16um+immxokRO
         fLuJv7I5GmR4EnIaQqjvq3kM7P03hqYynNLJ9LwqGVwGUXVGEi8Vt0ZusEcjDOxDGtNV
         u5Updn8l+XlhWDECorL9KDwLkE3pafB7kzvZb4TKTLaX2UPFtJaB/qAfLaTyEQ6p/O2K
         97xu8E0pUlX8FsE5AqaPaH9ZMgX3pnGCx4tknszJXgYJ1HtuSTiBNlqPXXQ/jCy4q/9b
         pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464236; x=1724069036;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHB6Syh0cqRJ7/Goc9rsKVI9ZgMN8/vxCzgWlnm4/aQ=;
        b=PX54ruDVlLzmZk80Peih47vGrdLhqNm8JP0hwckLknlIUsZ3wq+jajiWIjQloiEfix
         jHBHsNxVH08BQpqNaLLgAGG06PhT9PbeioSJLWNujBfGCILpCbyiEdvRnjOiHvTpPjgJ
         PnSy/oBCTFIfKzgvzWaeXK1cDw5LiZaPtBiycW4UxBi8dByhxTf9ZV98rxFMYvSGCHAF
         p5G4+SatKPqFSGdohNUXRMFtt+B/cjxZ3LZBAOiFBGziUI+mMlzgxq60qh5WIO90bkUn
         o97KSYVcKSpy6QdqzO3+i03+heszYpo4ENnV7tHeHMPOFrPCUyY8VdGRZpG97DM1U2Qk
         rOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaz8LCtrAstK7RyW+l+qR/TRHApu8Tt/yhKJj2P54Q/sG7FXbiKHfyCnst3MHzIURrzjEZTMErUYzRyU03OY4aVTrXaiTdSgTuMUo=
X-Gm-Message-State: AOJu0YxU3Q90CJJeeqj9Nd+2RJWTJrDOjEIMj1uez/9XrZ/LwLCbxwPT
	LK5Vr23Wm880CLq1uhU68IY9XVDUjM/NeCJH5VduEeVJYmO/d97eMlcyrLpaB3c=
X-Google-Smtp-Source: AGHT+IEIBPq7k8bmmrdas9+km1vcCguP3K6w3+cBirOZrHyHEm53RRwXodm5mM+x7Jxa8GnLAChUbg==
X-Received: by 2002:a05:6512:6ca:b0:52c:e17c:cd7b with SMTP id 2adb3069b0e04-530ee98e033mr7616121e87.22.1723464236247;
        Mon, 12 Aug 2024 05:03:56 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:d9c2:3add:a642:dbcb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fe69sm225021466b.43.2024.08.12.05.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 05:03:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
Date: Mon, 12 Aug 2024 14:03:44 +0200
Cc: "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
 <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 12. Aug 2024, at 12:54, Johannes Thumshirn =
<Johannes.Thumshirn@wdc.com> wrote:
> On 12.08.24 12:37, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>>  fs/btrfs/volumes.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 37a09ebb34dd..f28fa318036b 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -551,7 +551,7 @@ struct btrfs_io_context {
>>   * stripes[data_stripes + 1]: The Q stripe (only for RAID6).
>>   */
>>   u64 full_stripe_logical;
>> - struct btrfs_io_stripe stripes[];
>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>  };
>>=20
>>  struct btrfs_device_info {
>> @@ -591,7 +591,7 @@ struct btrfs_chunk_map {
>>   int io_width;
>>   int num_stripes;
>>   int sub_stripes;
>> - struct btrfs_io_stripe stripes[];
>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>  };
>>=20
>>  #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
>=20
> Looks good to me,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Out of curiosity, have you encountered any issues with this patch =
applied?

I only compile-tested it.=

