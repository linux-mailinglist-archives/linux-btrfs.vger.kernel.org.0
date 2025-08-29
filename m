Return-Path: <linux-btrfs+bounces-16519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB51B3B03A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476951C81F62
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6919E992;
	Fri, 29 Aug 2025 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tO/tOjLt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FB3FE7
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429672; cv=none; b=SM9S7gzdbg+3a6kTHRXsSaO1cKs74VJ5cpeXqR3Ayf+zv2+w9HRVZv1R5lczhNzKc6mcBIH3HIcBLGdZ1Kq89U8sN0ctRXEhKM/xk3zlgNbV6ixGguqknDtqhTvMpyxn7zSAMTRrtLMqqmn50p1jT6/6AsuXZeJQSJeyt46CnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429672; c=relaxed/simple;
	bh=hSc4KrccZ4aNLcu8F8ekkyrXiiVz3HpXi3drP0hrq1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLrG9VOfE3YhiVe+4OtiKNpR4/X2D651v3dqanc4+5AjAyXZ9AnRgXnji/Vv7cnirTnh9+48wqhbh3Ff2pxxBXHOqYPqZi1xHVHj3ehY6gbcbw4BsuxsmMLkcBBZ7MEkywRFCw+C4gBRUDSKb6me4iW/hx5wOJkK82w/NwI3KUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tO/tOjLt; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756429665; x=1757034465; i=quwenruo.btrfs@gmx.com;
	bh=hSc4KrccZ4aNLcu8F8ekkyrXiiVz3HpXi3drP0hrq1U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tO/tOjLtpHMqbZHSzkwKY46Ip0pKRNLxeiX7DBqOdftQLhQWZiYNX6OXErOU+/HF
	 wSwfkOQm7tuTZ42FwAK55dQmP2qQ7O8A3UL48s3NQMUxqBsrbpb+SstBXoPZjl73q
	 e39IN85Cqn19y8fsQ7DGAZJoVNiUzK/Yws8bCALha/PEeYr0kyF4EjBc9GAYYmITI
	 VDyAjioxgcGWm1HvZC37TjAe6GTXRIiDr/pJuWwuR7jZm/Z6yYauRrDdM/MuQVZHj
	 z3yHjMqERs+PKEqVug2WsT9/vatStljLebhk8cpOA7+06XVJw/gUH6noCaR4w7CWW
	 d2QF8mKp4iQBKxr0IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1uvub13NS3-00Fjhm; Fri, 29
 Aug 2025 03:07:45 +0200
Message-ID: <191ecafc-7b80-497a-9124-a7ad571a682f@gmx.com>
Date: Fri, 29 Aug 2025 10:37:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
 <20250828233011.GE29826@twin.jikos.cz>
 <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
 <20250828234542.GG29826@twin.jikos.cz>
 <48b9874a-2139-47cf-81f5-3af8ecfa8dc7@gmx.com>
 <20250829005026.GI29826@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250829005026.GI29826@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCDBkE3DzzPJYdAMIDVwZH+de7mbLcl0oQqOcQHnwyLGLbzMw8P
 zzmdMarJZtdg609OxBpted3LGR9u2VziGkBJBzDAAYIfgWpBae1FcrM4Wa+8stlPa9bbfb4
 e397FLFPrRvUqsKMjC0GWhJd6TUnCAF0KxUqvcTDZZZUDn4kt4EBOpMHs49HdgVD+DFVqKc
 m9fluc/KybDriITZOVy5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UeEqZiasDpM=;52dfI0YH/GJXrQHbj7qvfUTQnIb
 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



=E5=9C=A8 2025/8/29 10:20, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 29, 2025 at 09:20:13AM +0930, Qu Wenruo wrote:
>>> On 16k page systems the array will have one entry, similar to what we
>>> have now with 64k page systems because of how INLINE_EXTENT_BUFFER_PAG=
ES
>>> is calculated as BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE
>>
>> It still doesn't work well for 64K page sized systems. As I mentioned,
>> the 16K cachep will have no space for any folio entry, and only 64K one
>> makes sense.
>>
>> If you really want to use kmem_cache infrastructure with variable sized
>> array, please move the extent buffer cache to a per-fs basis, so we
>> don't need all those weird "optimization", just a single eb cache no
>> matter the page size/node size.
>=20
> This shifts away from the idea I wanted to implement, per-fs kmem cache
> does not make sense to me due to the internal overhead of a kmem cache.

Personally speaking, I do not think the current per-module kmem cache is=
=20
that reasonable.

The per-module one makes eb leakage detection much harder, it can only=20
be done at module unload time, not fs unmount time.

Yes, the current per-module one makes it much easier to share the eb=20
pool across all fses, but it's not a perfect logical fit when node size=20
is a per-fs attribute.

And to be honest, I prefer a logically easier-to-understand structure=20
other than something that focuses on "optimization" (which sometimes are=
=20
even immature), and easier-to-understand one always wins for long term=20
maintainability (and more flex).

> I hoped that 2 sizes would capture the most common page sizes combined
> with node size with a little overhead of the indirection, I did not try
> to do most efficient representation of the pages and ebs. I'll think if
> there's an intersection what we both could find reasonable to implement
> or will drop the patches.

Or go with a kcallocated pointer. It will get the space saving (at least=
=20
for x86_64) but still uses the per-module pool, but that also means=20
extra error handling and reduce the benefit of kmem cache (we still need=
=20
to extra memory allocation).


I can not find a perfect solution, but with the recent bs > ps support,=20
I really start doubting about a lot of per-module designs.

I mean if the eb cache is already per-fs, we will never go with the=20
compromise of 16K/64K solution in the first place.

Thanks,
Qu



