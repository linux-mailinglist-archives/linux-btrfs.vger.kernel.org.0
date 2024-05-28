Return-Path: <linux-btrfs+bounces-5332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F28D27C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 00:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C81C23851
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BF13DDC9;
	Tue, 28 May 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="GM8b6H/N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D013DBBC
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934296; cv=none; b=IC002Lty1CmkHtGXX2fRaFQTcNxL61711YOfHxUmiWYSKSXYvByUaUip5TfkdvL/Ng6a38VQxIlEFmtZFjEBNfh+Q5syiA2aCgNdZCDN3wfg2HzOjMJm+6QDnkKWAfn3uvBO9Lf+e2l2MTPaZzbREk5EAl1T/bYz9vqZIbHMr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934296; c=relaxed/simple;
	bh=s6gGGoGa28fqfAB8/9ayz7igSKloxSfHhA3lG6vLIng=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=uryCYJ+8pBChyJensoQp+XG7dF2g+77zaFSfVWta56POOPVNU8Dipr9XGrLP/dgHlu53YGtem6p7slu6aw69TgZ6fJT0FAw+Rf7GrL5chiNwQY5eWq5DU50GPn5jVlBaYaBYidG26lIrooDgJFvjECHBoheDU9ORNrypmi8gefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=GM8b6H/N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f44b42d1caso10686215ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1716934294; x=1717539094; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/EZSjBSMpKdz0TS6eS7VGV2URZV9D9zcT9BZtnUab0=;
        b=GM8b6H/NI/J4Qf9kM2wuhid9bqfPp8E5toF/bXilsxb6fd1ucDnvHhFIG6rlrXHKHj
         7lSWnUYoIoBYChzDyl1SOPrh2aEUFSyLGGjn8keuFlHwG8xNe2Z/HJyIC9pBvkCw9DR4
         ExDIJuoVDAt2FwfYKLgXzh8Jg2RqrKxDwy0iQED8OUTYJ7YGH9CZP/tyspDgDNNfDKNx
         jj12Tio7nhH7DbmtucCRpea3IjT6KZ6mQEdAZIimzILqwGkC1pjTaUoY9k6WgZ9VgUNs
         qjg0/+PA13xi3YFTNgzMUj4C/nmI28WUyreMQ24epQw8GWORAnga+LrAcF5bxk98HjyF
         zLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716934294; x=1717539094;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/EZSjBSMpKdz0TS6eS7VGV2URZV9D9zcT9BZtnUab0=;
        b=SP2puBlirNLeDls6e3bzcVo59217s1el3WgtBiVlKCMpX5o3Rm1HiaVyDTBbJQDVy6
         O0z1fDbLbhGjAzKrP7inLHJoTMIGUNuhv73v7okc1uBoGDouqJmOnyF+d2KwP5HHCVF4
         iGOf4y6GzC9DdYgBDMJo2DQvRqMKxo84Afbb1r6wu3HEKQV8Ep0zOF2GxWJMWc9IXHZB
         RjZzFILaKuiL11bIfQKpWrldnO+Tke1dD2sVG9UgII0bPaQ7Bu0xt2sy+wLg0jXPoZ3I
         g6aowhCk8vR33ky7sHFKVjP9Deoco9ZGDnr3Es1VsIttTgpeDIs6j1ONVmkj6Loj/ufc
         M6dw==
X-Forwarded-Encrypted: i=1; AJvYcCXYAqsR3Us56pp7cINwEGvCv6F2WngDG/+/FZ/k7Qh69/IY472PK66tLF4maOErvLA7jxCbqxHEbpuwcttchffCqFpYH0Ox5AAsSVU=
X-Gm-Message-State: AOJu0Yw/w5eSFiC2dhugZxz8qeoGPLfq5YuFYxD4A7HijWnUKA/0kXfG
	Eymc+iErsVzl+CRJZMBzo8pqxQHv87SC7QiBr65ZgMy7dgPqsqAxtfccqQ0vPxA=
X-Google-Smtp-Source: AGHT+IHTQU8PmmECMD1h64ue4/AGFuh/+UzLJOnETMdIzBo20vXZf/4EqQUrQxxJsMIbVfq9H8iR4w==
X-Received: by 2002:a17:903:186:b0:1f3:3a05:1adf with SMTP id d9443c01a7336-1f4499092d7mr162326705ad.66.1716934293612;
        Tue, 28 May 2024 15:11:33 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822198909bsm8028841a12.25.2024.05.28.15.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2024 15:11:32 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <24829B5A-5F68-4B3A-AD4E-1AD9EFDE1D0E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5446AB5F-C01D-4F26-BF4D-BD52D8E1B75D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] statx: stx_subvol
Date: Tue, 28 May 2024 16:11:28 -0600
In-Reply-To: <b3b02658-ffc4-4bd9-b77a-af65ae359474@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>
To: John Garry <john.g.garry@oracle.com>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <20240312021308.GA1182@sol.localdomain>
 <b3b02658-ffc4-4bd9-b77a-af65ae359474@oracle.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_5446AB5F-C01D-4F26-BF4D-BD52D8E1B75D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On May 28, 2024, at 6:46 AM, John Garry <john.g.garry@oracle.com> wrote:
> 
> On 12/03/2024 02:13, Eric Biggers wrote:
>> On Thu, Mar 07, 2024 at 09:29:12PM -0500, Kent Overstreet wrote:
>>>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>>>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>>> +	__u64	stx_subvol;	/* Subvolume identifier */
>>>  	/* 0xa0 */
>>> -	__u64	__spare3[12];	/* Spare space for future expansion */
>>> +	__u64	__spare3[11];	/* Spare space for future expansion */
>>>  	/* 0x100 */
>> The /* 0xa0 */ comment needs to be updated (or deleted).
> 
> I would tend to agree. Was this intentionally not updated (or deleted)?

More correct would be to add the new stx_subvol field after the "0xa0"
comment so that it is clear at what offset in the struct this field is.

Cheers, Andreas






--Apple-Mail=_5446AB5F-C01D-4F26-BF4D-BD52D8E1B75D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmZWVpAACgkQcqXauRfM
H+A4QQ/+IFC+ipn32WPm2mM14CNmiYmrhv5RCNPU8Ectk5pHJQGow3HzwXGSGKRv
M4tj97Xw5Au3K9qP9s3QSNLpDrc3+KumXrr8vzg33XpnRXcSzNMxtcXdht3/DGYO
zqltGBq7u+Wm2S1yoRZwORU1YS/dq90ec0m6IBhszI3FAvLCH/tMj7dlTrTE3gSu
xWen9XZBYiTbj3m81J5nlppuqEsr3tF7LtJRyHUw5xqgpe47kv0GFohyCp3pv8et
r5fbv5I8uCNx6iSBk/o5ORLr8VVZJ4K5/0t96u0sPDLN9wOCV8NpYPXLeSUqPVr7
KGxIcTSFAUkUMQXi2NGkpkHm5aAGmpXH2QQSdKbQbXrKXEbo4rAe+4jJjNtiYMK4
vU7R0/6YGT+KBmL9J0/yvfshZNNb5l7ghzAq3x2Wt3TCPFGg0N6em1QKSb67IdbS
nCmsQ38n589juroHPFs4yEq2Lad+g05CT5Lml7UNVCj5Fg4Wq+2sL0/6tnrx9/Xu
Sh/knYTEPZy3Yevg0t4eol4TzLVzKm5PlKIVzctm4pAm5mNMXsS0OygEgpV57LXY
84UCpWL80GT7PHpeo8KzNuN14oYS2BW1aZdBgfSnyxhhSuKGbFDCLcr/N+leNeZr
M3rRe35/SHqXbzs2kpSz/mlf1m98bHjjsyRMKmPj2/a1tevPQg0=
=vnHt
-----END PGP SIGNATURE-----

--Apple-Mail=_5446AB5F-C01D-4F26-BF4D-BD52D8E1B75D--

