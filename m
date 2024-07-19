Return-Path: <linux-btrfs+bounces-6573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E3893743F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019E0282FDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518CC4F606;
	Fri, 19 Jul 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ta+z+X0E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B6383AE
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373423; cv=none; b=Q8hoh6BqVpVDSPM2KWmTYhtEeM9SlaXSjOe68pYKNBaZvXfWXtv6M84XZ+lZNrtXpIyLGZfRCyp8i8UtzrmQ/F2naJ38S/rDUf1YBKsG7Zfk3/B1gDRrEZycCscpmqcSUf/gvFjm+rP8uyY9C+VCkjavKnaSGvaRUrVbkCk51hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373423; c=relaxed/simple;
	bh=6uT5MQsnX/sK6O7eTLjtymKsnl3edqpXexqjH4RObds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGkC54LdOcFlcRQ55P0Xt0y6aGzeYz9eyRqFz+7pQz3uiBIWKTazd3JHxGqy1LbrhzwlMgdgVe8lYXRSiFR3MrEMqnk6+Vmh0AnIVWKOZ/zxNp/RHN3TyWO/WmUehj55mBh3dHSInL9dchDtKmES6bTYKgqz3Gp9jc73zIyNQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ta+z+X0E; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721373414; x=1721978214; i=quwenruo.btrfs@gmx.com;
	bh=4to7RjQFgIuuPjT9Jc3RSImGDQhTbkmz3P4g3ftEKZg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ta+z+X0EE61RDackiMkcnC9T3kO61RoHyqV4aeWQvDnqZcp/dSJFF6TExTqo+DlE
	 KBSYe5Zc9RSxAGFzT12Q42Oqjr8UH2G5WHZSNhDdRN0OW7zLkd6cI3e2MyHCe/GAK
	 soOM+TS2y6uE4KQJFvIBqKzh77T9xOwNbUdzu2xpEzG4Nc6AOu1u0Ykj7kawdS6W7
	 jOo/WFY17huI4/T/6b762BBUa0qi/HifPoEg99ycrp8OvovgKOsmWAdbdfvN9yBmh
	 WyNv7MiXJenbXVKwVyIIpxnGZuIwEo5mKQvocJLgBsTKZ+uVXmDYvasCwW/crKXKB
	 5nEQqBkp0MT538A1Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1s69XD1yzi-016YYO; Fri, 19
 Jul 2024 09:16:53 +0200
Message-ID: <99334ebf-583a-4295-be52-118c253d5fca@gmx.com>
Date: Fri, 19 Jul 2024 16:46:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] btrfs: always uses root memcgroup for
 filemap_add_folio()
To: Michal Hocko <mhocko@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>
References: <cover.1721363035.git.wqu@suse.com>
 <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
 <ZpoQ_28XHCUO9_TT@tiehlicka>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZpoQ_28XHCUO9_TT@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KbdDDDgr/1cJdqCNwuTSzP2bfOpD1vrDnGCTzGqFEooL3IahTk7
 pOG5a7RS9pp6r9vZbqRpL3kLBqxkPD7uUudQktuEFiAXBykVpAh/jUBKcGs5iHUs3K2kQyM
 y7Iu6kAgcSIgu2hIYkdzugESLER6X7BZlRtr/shddLoaNXYuTfgsCzNm3sZQGPRJT4lYP9A
 hSGzwgPsCOyy+UF57KYNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jaxs7ZjqOdc=;Bz98CavP1KczuakloC8xLjuQwzV
 fU4/De8IysS9XE1AeGjsdmDdbod3KUvuZGjhlbEJtDvjthPgs2KycEaqcxcEuVGbJZvzxGowy
 mdQSYpCEAld2DElN4RszBwdLZ2l7aFlvXgkDHZfEfdrut/coec69h7oDsi9IoLLXPuv+hRD8t
 F9CC+hSEjwkYwulXR6DU3McnEOJ8z4Q4HoJETV1+CyIt2i5CZeGxvcUenMLy5bkBBAvyB3uN0
 cH952uVZt19RJ52TJ8FHupLSj71ke78FdXZp7CIsf/EXrVEisQ5ApCVqVBSaFj17Y3hTy4lc8
 Pqd6qpNjIOUKOlH2nevOfdaSGAyOfuCJuoskchqvIvFFwRRzJX3G3mub6Qqqym5WLhrVi9vzw
 jnGdfQh+WVmH84X7HVTqme/fxjjyV+yhbzTBjavnSh2jOgO3qqpRtgfM633hPuAvFrIVNoV/a
 vjLuPfcyUtTO22ONktJJmQDQhFhE6qzgCnTi89YwrGyVySGUALPbsvB3ursG5L4CrXS+eqgDg
 Pb7/IPfVz6TJgim5kQyhCtqP9xGY5sZkUy04ZGAiNq01BUJQiU3yMWnKhHp84wlXK7v6/mf4B
 e1LUtwoMk+IcFXuyR0IxmDaJja4umP1lPqVfJ05UBWJHmYE0n+RcwW6Cet5xZabCG7VH3mWmA
 4fOkh7SndhjroUK/iPvwYbnuyyNNMt5cxgn2+OzXJWHgyBEb5kW4hWAPKSJc5lInJgZ7APkHM
 UYKHcHD0dxd760hIqRrF0w17QFOY+nSxhueEtVH1ARi6WKAvpWUOQzbV0DRznWRHFV4SMrrQ6
 r/wEorSrrqm1ZzGCoWffANCQ==



=E5=9C=A8 2024/7/19 16:38, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 19-07-24 14:19:05, Qu Wenruo wrote:
> [...]
>> @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct ext=
ent_buffer *eb, int i,
>>   	ASSERT(eb->folios[i]);
>>
>>   retry:
>> +	/*
>> +	 * Btree inode is a btrfs internal inode, and not exposed to any
>> +	 * user.
>> +	 * Furthermore we do not want any cgroup limits on this inode.
>> +	 * So we always use root_mem_cgroup as our active memcg when attachin=
g
>> +	 * the folios.
>> +	 */
>> +	old_memcg =3D set_active_memcg(root_mem_cgroup);
>>   	ret =3D filemap_add_folio(mapping, eb->folios[i], index + i,
>>   				GFP_NOFS | __GFP_NOFAIL);
>> +	set_active_memcg(old_memcg);
>
> I do not think this will compile with CONFIG_MEMCG=3Dn

My bad.

I'll fix it from the btrfs part so that @root_mem_cgroup would be
changed to NULL for the CONFIG_MEMCG=3Dn case.

Meanwhile, can we just define root_mem_cgroup as NULL globally?
That looks more reasonable to me, and if that's fine I can send out an
extra patch just for that.

Thanks,
Qu

>
>>   	if (!ret)
>>   		goto finish;
>>
>> --
>> 2.45.2
>

