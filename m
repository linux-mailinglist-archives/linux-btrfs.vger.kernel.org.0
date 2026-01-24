Return-Path: <linux-btrfs+bounces-20987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NE+LzE+dWnXCgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20987-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:48:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90E7F17E
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DB5300B87F
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72D22A4E1;
	Sat, 24 Jan 2026 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YEM7RF2X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918003EBF0C
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291310; cv=none; b=OJG8yB0aOXd1KGsFXRQZagYbFPBI9lclOfMrRbv5ILtRLon2i2J0Ou6YsVCEeTjQqE+vMDqlGBC1P7tugT+nb9ICN/WubvVDFb8f5CfjY1g26ySjSDvPm6FiYYEAs8+aknHvvVc+dKwL5fQ1gb/QjWIfY5W3zLAcU9WTfEPf7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291310; c=relaxed/simple;
	bh=fR/6SyFiJxtJYS3gVQrRdZVYrUvM33oC0SJBILYyKSU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Gnyr2Rfm/JF6g3nhk7HWXhth62stytXMs+iUChexUsJObXny1dDOluvMt1ufI8eyQR6yqslth+XWtKCLQFIZyIJcWU/jMZgFDMO7QgGk3HZuvygNbyXbo+ZnxBhumASAJvZd+KC+z5eYOm7+bbi4xy+LEFaohe6tmzo8blthwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YEM7RF2X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801bc32725so25816165e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 13:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769291307; x=1769896107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU0cZEGXIAJVy+DG98cxvnB6IRjjC9I9ubBv7pWUP+s=;
        b=YEM7RF2XJ4DWMjukw3/0TVCecVyELi+50n+tIJqotcpSmCaNrxNWE0xuD/j3Z/oCoS
         tMBhtjTQfBGxDrFfqlKXwiI0H2uEK6yj2EOf0tFhCcHbbyJg9XnYnlZYDZOCcF0AMPHl
         kpYC5sdd94/F7RRYhmL93q3x54bSFWVsuMUC2pLq6hSz0SBZq8SQY7cc1mk6Gb+WtSNr
         +u7ay8Fan8tYVeW5aLXFt6gPUUnY8wO3kyhHICrLil+cER+jpT/go8uKB1Dg9Yu8T6s0
         2OVFNzhuLQlwowtQORBZAVVE1UmKw05CkeZwiiXPgS5f2yQT7M0LcTpDKiUMduHmGds4
         FgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769291307; x=1769896107;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU0cZEGXIAJVy+DG98cxvnB6IRjjC9I9ubBv7pWUP+s=;
        b=Pry1bFROf6M1AN1NTZ5/QKgtv+ReIN+wD9TdhrDOYYPNGCf7l+TrdHY92vls5oiIoR
         Lm8mBnUv4fKs6Kbd/Ke7cs3b7fBZsrhl2v40/nom9f2uVzTZcI8STsVFKhgoBq3/5hL9
         RqvZPbNCZc/3sECP8xgx6Y9slZr1D8lcUzgbQuA9+ZKvLCgciFVXtzYNVcNxfFaeczHS
         1J/oXdSXBQM0HX76dJ4Tt5XlUgz4BXWI9qK+22B1IgKFvAk4ukJobH1vl4+/qHcuOzA4
         DQ08i+zUG1bg/tAJVmjhXpIHI3+deuFDzHtKTDTeSez0ntQWtABKJwmZcDi8v4qjtEsg
         xSlg==
X-Gm-Message-State: AOJu0Yy4dv2vHmZUm+Wng7nlib6rTtPTas0eO5PJJ337jkVvHADOVhkc
	YSanGBdlsV5WJIydYitLg+kQMQUO4Pqzya+Y6YUr9oFoQSQmew4ZLNxUJZYDd1nzexz9FoS/SOw
	s7A7q
X-Gm-Gg: AZuq6aJDer1ZK/xN6/xj2pQ4vZcO5nr0P9arfm9hVg/hoOtytKcbi8zmR11UO6EYfN0
	aTyf1IdpfjGQU97ejj8N52PBUDvXDUC1XXo68UymdUhDMcrQAqasFagP+E5UNrcD7IgYN/6TtKz
	hkyN3ucCNpmxd756TciSPmwbl9WEpIhlWaN39kk6j+qZcxHjKBLRL0l4vvSOQHNktaQBMRvsOYd
	wprPPpdqBQltzByHDRmjeaG/30JOmRoOX8hFRrtVX8w74KIdNTHcubJ/x/iuiaMOQoYaaQCMFU0
	UQ5KCb7xiHzBebOWcqP4CcLxHbAYyL9PQ8ScqWBLzRWGdN/bc3MMaGyum5d6y6avkKbFajOo3ko
	zAK0TT40cuaz4d+4Nn5eXM7lupCJpARg34Cuc3YmHkVkXAMzEot17RARRG3Ok4ssLeUV69wBlFf
	3mZAxGf5a8U8CS3M8CsGlSJRw+oJ9f5uureLd75rQR9/wZ28zXwg==
X-Received: by 2002:a05:600c:34c7:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-4805cf5ec2cmr119225e9.22.1769291306907;
        Sat, 24 Jan 2026 13:48:26 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a42a626sm4885099a12.31.2026.01.24.13.48.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 13:48:26 -0800 (PST)
Message-ID: <8872e902-3ecb-4d6a-8bea-c79552db6f28@suse.com>
Date: Sun, 25 Jan 2026 08:18:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: get rid of compressed_bio::compressed_folios[]
 part 1
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1768866942.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <cover.1768866942.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-20987-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 1C90E7F17E
X-Rspamd-Action: no action



在 2026/1/20 10:30, Qu Wenruo 写道:
> Currently we have compressed_bio::compressed_folios[] allowing us to do
> random access to any compressed folio, then we queue all folios in that
> array into a real btrfs_bio, and submit that btrfs_bio for read/write.
> 
> However there is not really any need to do random access of that array.
> 
> All compression/decompression is doing sequential folio access.

Minor update in the for-next branch.

Replace the following pattern:

	bio_first_folio(fi, bio, 0);
	ASSERT(fi.folio);

With
	bio_first_folio(fi, bio, 0);
	if (unlikely(!fi.folio))
		return -EINVAL;

And for the zstd one, move the bio_first_folio() call and the check to 
the beginning of the function.


This is to avoid compiler warning about uninitialized access to 
folio_iter members, as if the bio is empty bio_first_folio() only 
initialize fi.folio to NULL without touching the remaining members.

Thanks,
Qu

> 
> The part 1 is some easy and safe conversion on decompression path.
> 
> The part 2 will handle the compression part, but unfortunately that will
> require some changes all compression path, thus will need some extra
> work.
> 
> And only after compression paths also got converted, we still need
> that compressed_folios[] array for now.
> 
> Qu Wenruo (3):
>    btrfs: use folio_iter to handle lzo_decompress_bio()
>    btrfs: use folio_iter to handle zlib_decompress_bio()
>    btrfs: use folio_iter to handle zstd_decompress_bio()
> 
>   fs/btrfs/lzo.c  | 48 +++++++++++++++++++++++++++++++++++++++---------
>   fs/btrfs/zlib.c | 19 ++++++++++++-------
>   fs/btrfs/zstd.c | 13 +++++++++----
>   3 files changed, 60 insertions(+), 20 deletions(-)
> 


