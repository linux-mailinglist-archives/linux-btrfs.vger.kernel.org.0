Return-Path: <linux-btrfs+bounces-18649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089CC30CAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DFB4281D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E62EBDD6;
	Tue,  4 Nov 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="CXlGXGVC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="u5SaXu9g";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="T3v0JfOA";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="xovdgGKk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender7.mail.selcloud.ru (sender7.mail.selcloud.ru [5.8.75.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEF2E8B8B;
	Tue,  4 Nov 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256265; cv=none; b=a/j6s9Iw1JO2qifZSPapwwFNGjjOmAvzTizQLkmhd6vr7xN1Wc9lQnI6OVpDVKIbY3dZiPZ6aFE2M/NsYVvF4q1K6/s6d8VF98yO9QcSZ5C0VbTcM+6G+KGrZFtjOUvRXEgPURIjQ0I0/sS6u/SlamgrsbYf+gfpeo5bg8o/pG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256265; c=relaxed/simple;
	bh=PzeEpfs4XQ8khKCgddMv3ZysOZTSEHJWELPss5Sd8Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3SZlUPGqKo7o1vAbQy8BdtCBArivHnOjyoEa5gxOj59+DqBxxGuOa7dS2g9kFLlfGvZ+a8RRV5JAj8buLw+Tlb4JyYKK80yuGqg14Omp6uF9Fa1cSzLTGQQy7PXBk2uj28JeDKB+XbfCJb9lz0p8wPGQcskfKKggh9sxZqxkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=CXlGXGVC; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=u5SaXu9g; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=T3v0JfOA; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=xovdgGKk; arc=none smtp.client-ip=5.8.75.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	List-id:List-Unsubscribe:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cwBP2P2We621Mi/XOMj9ZN+8+iVGjNLeiLZTgudXf2E=; t=1762256261; x=1762429061;
	 b=CXlGXGVCXFGyT0Qvt9QVjE9tCrSOvDItNoeLqfJ/MRjz8El8Zv3q4ofmWG5FJyt2y+LFyRQ882
	iQ7UhWK5zAsJaujKRtWagYztaJbWFnkEhbYJw2LDT66ZnTuP7o4jWGVlMK7yjMJDNBM/aqzW8n3NF
	qX4NaBG5fsqoNa/W43rY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cwBP2P2We621Mi/XOMj9ZN+8+iVGjNLeiLZTgudXf2E=; t=1762256261; x=1762429061;
	 b=u5SaXu9gzrXdNHaQddxaq3N5uNIzEiMs8Tuu0j2h+kDNdJLYU5mZLLrb48nffO3gPpmTQEy2kw
	k/KkqZTvR3DRSLR+9avStjFdTsjZEF3lHgGcdJ9q4+vdatra0TSv4rCDJ1Yi4RJgqdHGi8WXn8RGY
	c63Tz0Bdw97WxSu9y6P0=;
Precedence: bulk
X-Issuen: 1410789
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1410789:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251029.201254
X-SMTPUID: mlgnr61
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762256251; bh=cwBP2P2We621Mi/XOMj9ZN+
	8+iVGjNLeiLZTgudXf2E=; b=T3v0JfOA3neOcfNVUuEKgmYwj+jpzo5lyhvxUrm5MPsz5zvJBS
	M6LBTjBZy6QGC8otiqV8sEnNagm48Ltr/P/368/dbNEj6fDURlHY1abIQVjDwe3ruMQx5pogaHH
	mKy5Pqfc271F7xrsfR2vNLSnbljztQAtnytp3tjfCh9YWfspb4KOpXjgAkhDA4ikcbcuZqkN1w3
	Ob+qsbp0rYzJKkyCQxrxspHiSDc28ppfLKMqb0cQSLRhgC6IewTCxia/Ow8o3Dpq0Ja9X7kin6R
	pPw4I5jk0ZuttkyiOKYmDckZKciAcLG8Z6KmXUQvb+Wrd4/UpxrPNn6Rvk8LzsxD32w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762256251; bh=cwBP2P2We621Mi/XOMj9ZN+
	8+iVGjNLeiLZTgudXf2E=; b=xovdgGKk0xAqehSmgyaYaJ6k93wB5KoGddPEzk2VNOFcjERTe5
	i5Vp2c9RY4Ds0tZu+5QPkEHyGM4SuXDY2BAA==;
Message-ID: <98e33c86-f5f3-46c5-8dba-c28a459b4a45@foxido.dev>
Date: Tue, 4 Nov 2025 14:37:30 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: make ASSERT no-op in release builds
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102073904.2149103-1-foxido@foxido.dev>
 <20251104001800.GM13846@suse.cz>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <20251104001800.GM13846@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 03:18, David Sterba wrote:
> On Sun, Nov 02, 2025 at 10:38:52AM +0300, Gladyshev Ilya wrote:
>> The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
>> since these checks have no side effects and don't affect code logic.
> 
> Have you checked that none of the assert expressions really don't have
> side effects other than touching the memory?

Yes, but visually only. Most checks are plain C comparisons, and some 
call folio/btrfs/refcount _check/test_ functions where I didn't find 
side effects.

However, fs/btrfs/ has ~880 asserts, so if you know more robust 
verification methods, I'd be glad to try them.

>> However, some checks contain READ_ONCE or other compiler-unfriendly
>> constructs. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
>> was compiled to a redundant mov instruction due to this issue.
>>
>> This patch defines ASSERT as BUILD_BUG_ON_INVALID for !CONFIG_BTRFS_ASSERT
>> builds. It also marks `full_page_sectors_uptodate` as __maybe_unused to
>> suppress "unneeded declaration" warning (it's needed in compile time)
>>
>> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
>> ---
>> Changes from v1:
>> - Annotate full_page_sectors_uptodate as __maybe_unused to avoid
>>    compiler warning
>>
>> Link to v1: https://lore.kernel.org/linux-btrfs/20251030182322.4085697-1-foxido@foxido.dev/
>> ---
>>   fs/btrfs/messages.h | 2 +-
>>   fs/btrfs/raid56.c   | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
>> index 4416c165644f..f80fe40a2c2b 100644
>> --- a/fs/btrfs/messages.h
>> +++ b/fs/btrfs/messages.h
>> @@ -168,7 +168,7 @@ do {										\
>>   #endif
>>   
>>   #else
>> -#define ASSERT(cond, args...)			(void)(cond)
>> +#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
> 
> I'd rather have the expression open coded rather than using
> BUILD_BUG_ON_INVALID, the name is confusing as it's not checking build
> time condtitons.

The name kinda indicates that it triggers on invalid conditions, not 
false ones, but I understand that it can be confusing. While we could 
use direct sizeof() magic here, I prefer reusing the same infrastructure 
as VM_BUG_ON(), VFS_*_ON() and others.

Maybe adding a comment about its semantics above ASSERT definition will 
help clarify the usage? But if you prefer the sizeof() approach, I can 
change it - it's not a big deal.

