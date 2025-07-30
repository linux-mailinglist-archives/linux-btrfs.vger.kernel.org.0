Return-Path: <linux-btrfs+bounces-15771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E298B16903
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 00:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963AF173A0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023BF22DA0F;
	Wed, 30 Jul 2025 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kRM2bDxM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB422A4EE
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914414; cv=none; b=j7X7urMXMQFO3ER6N/kuiz8zUq2NLdMB8h4JVK4XyVXdtKwja+48bIEm89S2nSOyfkTp6buHzpnPNQpjp+yXTVTXJzsOwlTURM6O7NUnlzu8ffCfkHaIWXAbBxmgWVlj4lZsX12wFlXVwqI18treYMIrPm+hqAM5q6EAZ81HQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914414; c=relaxed/simple;
	bh=eaUayyEn8WUxctq6/7PE6HIEsz4tw0SdABKpWHUgths=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4Um1Fp1CZGAVyhxHT2lZQUvqGQoJjyExLwrLq3ZdNbarNz+Yy0WZKiVtNSUlPwaharZzYp0Ion1AWJUzeWdlTXlZieR/Aw0a4YverRyYabR15rV2rX7SBuqdOM++uUjb7xGKh4Jb1rmS390XndCCc6pOBfKNznyzKb9m4cCjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kRM2bDxM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753914409; x=1754519209; i=quwenruo.btrfs@gmx.com;
	bh=TTIQIHjD52+C2sTo9oUCfUD6niTluWQZwt7sB/HBXuI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRM2bDxMSYMOpSxloozHucMCroKoZrXzb4EcL8NTTcXSTC1NRMogDxzPrfqwPj3b
	 Qsh0n81nVcQ1ULUwzXlap3M5Dj0rrCWBIRwEakneglojTmqqIEVHvdC8/G64F0Hi1
	 BhHmd4f/surNNyITxo1oY/a9h7JEmNKxq76E/sl7NWWwLNR5boar6wbUz56200zha
	 2yb+eOW5gptQObyF2ksNKOMlNIO+kujcE8/5tF3F+Xj0pqE1W/0/ujMjpXEqfOgCy
	 RxLaEc3ivNLSu8zZU5Lt5q8QAB88dBzCdPZntD9s6mggWifPfaEOdXr3S9to1f1J6
	 MX+vambgi/n9qqqvcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1ud4RN1jwv-012xfe; Thu, 31
 Jul 2025 00:26:49 +0200
Message-ID: <b3a9c3e0-fbc4-4051-9306-0ae255fabfde@gmx.com>
Date: Thu, 31 Jul 2025 07:56:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
To: Boris Burkov <boris@bur.io>, Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20250730103534.259857-1-naohiro.aota@wdc.com>
 <20250730185232.GB874072@zen.localdomain>
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
In-Reply-To: <20250730185232.GB874072@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iYXejsy2CxmJuSXI1cqQibeZHTCiEdobG20ga9kRL/3hTJ2Kj3G
 ElC5/JdhCz9uQazyEyquzJnT3WXCnMqzyBkCUTZEpruqrHdYZY+8G1/xzqd7Ytj8lOIkk+U
 reIb9NakOhzUKrgOI7h9bmF8eWuFkfthbznA44GtTeyBc+JFD1/c4M8rX3czzV+SP1IBWox
 sS+8Ha9PYRmTQ9Tbvso7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:03pqcgYo/8M=;ZalkzaA7xTa1TurCIawmtChGKkf
 zzuEDG4XsXcdnQfRQtt11q0yEQGuteYOpAmXLi0lfEzB9PrT5FTnDvHeZlJNZb7vxJ12UAIWs
 aO4S3oJoqkSm6+9JuMP/btagFoC8jw8l9idrhjMBUgu32ObRdNT3ARrgFwXwCRyym3O/y40wg
 BmBeNuvj9iKVN6fQVUiTGhh2Gdifp4LRYTZp8w2ErK70h9VXRFa0UtJCmeIRDJzVtBKHOqy//
 8UUJ9hR0vXjXHlVIbzPD63KuT0Ov4LrDme0QBOjWmDZrupffPVPXw6opQ/LMOyUHJldMl2rxx
 rRCSWPZM6rBq0HofuGjCg3+SRIYUKdUY0wnxzaiSLkh3SjH/07C5jmQ6fhlye7BWAKcRl5e2d
 gHBlewwprLC+d+QYfSzLeKxdf8zaPauvJcAQkCWFa6IvGaSmPIjVhFU5ipd7RO1bQZfjw97Qo
 T2UCSfDk0y439wUOt3IRA5z9/fPanCEeSrjJuftbW9VXIJrt/wndGvzKCGHoqAnS6USTHAnfD
 9wEg8SMfGw5bgrL1B5+q7p6glCewt9BPWwcFLJWGuYGqb56SbNSOIrE0KpvYKSFUNWzGJhPHi
 r8SOZUiB2vrf9qxWZ3ZDs2t58gVS4Ou+ROgHflbTOoTY3fvdCI7Hn0m2P5QOswFoTk+OIQHRa
 RgZCv/KgPiYSb96uuHfZ6eFhCoRGMYR/f+jxeswlHOTSokniAIk8juKLOulwufy5rvIc+w5ts
 30K8evAEvnEIzCi4oiZw4nVXGNhQA2DtJUXkUsBixzEDodtMBkBsRF+JyjD7sPnLWWh2Akb5b
 BevZjMKiOivBy3sHLh79CH0+fo5vJuz5dTCDazmmQ+tikMYKY2iOAG7MsJsfmEv/m7G09eszY
 GSnnOQdvaBhfw7LqUvax+sSOvXCyBCyAxlhL1VBXq1eyRXuUUlVX0eizX+FQuS65hha921N9a
 Hhc2+uhsEz7NlxjR0l5E2A9UQVMLSYR++UE2huzpAvn3soYOAoGhFoDaTZjRhybTBfMsUonS7
 NzVPju2JMtis1nW9M3DLCcIQnkvVQutDcSWl8NGI5S1TbqcxDUSSjRVYFoMFsD9zdNhgtgWtD
 GOc6rIwFLejunHIB6i6ejDnZVlAZnxIP8WKR7uQdlhkfDzsC6xAALTGEc9La8bVfblPlEsg1c
 PsVn7Hr0Sf4O3Y0hgdQPExW1VrcAttC/bcvrk2LhhXjoLbp89djin3T6yBSYzByuQON+OkXsT
 ppNEsQvnCna4A0Oiffg3m8bWgx7Adndze9qffD4d0aaW6Nog+PGGPKw74MaoMF7OZWDN8InlB
 cg9eyA5irARHJU+dMa+NggyxpSpOdFN3FLjF/hezn/f+0R1a7h0n4sdEb9n8QGPkEnyKozdLI
 tY7Q0ahX35Fl9e1DjZioiU5h1jOZfYnFXRRzSyiJjSksHQWAxmrl7VvOu/ByBRGUEj+midPzg
 bZl6BcUr1Ut/weQnm9aLQ5n2DRjMC+tr2x0LhwdQio4cRSVztvnFjVTivzC4CFRA0Nd98/ka+
 b8NQ/Bh78vbSR8HSa1MO5kCnmRs/ol80qmiTLdeaq50xL9Di4/kBDj6O41hniTJBgz76fo7Ur
 RM2iqJmnGJaMrsm6Jo/EWPPGAFf7h+nnfeOYIGFl7DASGQmJOe6SJop6C9QkVuvjFZyO64CpU
 VTTCWHxKGNT/x4qGg2n4C2TM8mGF1vJP7uYyg/KuBeVf85Fi6M3UmqutXXgeVCIjG99gSU0TA
 nPJKLrFMjLvUJn7WtW+OKz0Pf34MKZ8biWkXd8NMcCH5ZPRK8oHmSYAi+MBbTF8MwCrVRFH7l
 wra5g/ODOJtGW1oBAc8UoRIx1QhbuqbukFOqAyZxKl0vMg1b3+G+BIJUptt3CBTVUk1ORh9uy
 nx3qz2B0YGgbC52sCk7O1eKhfNOTOdivrsiODeCBOWZM/UawM0yhbLDAzt90O+Y2NcWVMOkN9
 Faz26W1oFa69SurUXEWI3Du7wD4g0vpXOW9UqqDnQ3CyOY+uhHg/lbIXKhBB6mh1sBIyk87XT
 d9QXS7TpL9wy87BEGuNtBwUuZXRmh/ox89mFwD1OopEBsSHhGKfOMoQ5wLd+LBJp3zYCbJ1TW
 u61VjTAfJPAcDlQBvBjtNDLnRlkG1phh1yabrEkoHVJe96DkanvNeQB88bdqnPikBaYGVrcW4
 yEsbvwtshatr4XXoE575RtWyDFcJ/mEQS+j+R7HVaQs9PWtvr++V/XdhlPUZt3RHftL5psl1e
 4eRHcNe2nrqTASZu+YNdMn3nQ7f8qhWvU624zvwPQLDOc/QhZv0LMgfeBl/qg1tN14afm/gYc
 lDEAvBl1GKHfgJfbHl6lu9IixRxa4mvtsQNTGWVd2PCFEZA33HH6nctbYDMnVQ0Exa3g8jhsz
 bJRzLNENID4reob4Cia2pdhfHIYfz8SJriEWrkAYrNk2AboNdVuu0OGHIXDs9XqMFKySWPgCC
 29lJZuoDriyhYKAA7y/p4EotkMuvg0AXM0xtxeY27LjH42JSCdIOq+oktGXrTvuoacVd1J4uI
 L83GMajYTlxSybfQZWup0v+CHYHGhS6C/ykPr+gZNfkjLqaoVhjnU7nMKIlSKmitj3gRk/Smp
 Qgtg35y5iiuVTKJb3s1nQeri2HsgtRGsZJLrS4jrfOqcNBdvMLM84OvCkRlPzOb+NqrQyPNvj
 9mxRyzHd9sFchPfmAu6vlBJ30Hh4kTad2mWo/5nNu7vgWnAvTe2OpzZuUQ2GzaYLHN74ys4gL
 FL4vKqw+2l78BPE6F4vEFmHE60siEbYBVHFH2y8TDUdFwa253obvDVXEcRn9ONCBvAFcbvK8d
 ie6acp0kHYn7VJQ0Pt53b1uyPr7uyOZ7OjrtbVKtkFBU2ccQ4Zdkj7tcx0+yp21iFjwslOUFf
 EfR46GAfMPMAfoN2rx7x0CLdKBZUk3xIZKBHWcaPkQ4+S/xtglOwJVU/iFkmDPQHyOWGGeoC6
 iOYFSYiBBsigMTNB39TVjcgCpcoA002WDISqLYsJf90AkvMCnW/oXDz+VAUlyn0GJyNoOeDGp
 GOwQWDlT32+TyTZuPWpexq/uBDIvmbuRJU4v6ohjRk50Ma+JW1wutGJgA3zTqsNWhYJKMROD3
 79bby38lOZU+AuzcAOrW3unf3dEwqKQE9cjzYeAQqV72Q4E+mEm9n6am4cjuh8TZxRyGtCrRR
 wZ1BTbkK1f9w6pDJ0M3qEPjZZrxdSjtzLtnNPpHgSc7Vvq8lp6yRZdlg/3dKDE+zpL/3mK0zP
 9tGxC79Ko/TWwFvr0MVRpZL1otAOMyg3fFW0kOAUJ0ko/UCymFHW52AnsY7eIwLLs35MedkTV
 dOSSfNOJ2KMGUw6MJnC+I2OSiVWjgDgltIOrZqVBevtJUQQ6eL2NrHFb4/k0pBDBavDjJFLWQ
 ZYiCdrvSdqao9yFOyRGaphhg2DQgWbdlELOrwu6eX5PqskzJ6z7ZFqz/GmUk5qFGkAVTZGDiU
 bxfiAnVpU1IRA8QUzHHznAdp1QBcyx/T4hKQafIb4qr4e8QvQ+1xPzDgn5TgKK3VuATrvafSy
 E+1TN3Hk2csnTpSuDIe/8ocRHdlNdV5Y8Q/K++WAJHLVeuqmYbDBS3nPQ9XYYxMe5g==



=E5=9C=A8 2025/7/31 04:22, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jul 30, 2025 at 07:35:34PM +0900, Naohiro Aota wrote:
>> btrfs_subpage_set_writeback() calls folio_start_writeback() the first t=
ime
>> a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE t=
ag
>> even if there are still dirty pages in the folio. This can break orderi=
ng
>> guarantees, such as those required by btrfs_wait_ordered_extents().
>>
>> Consider process A calling writepages() with WB_SYNC_NONE. In zoned mod=
e or
>> for compressed writes, it locks several folios for delalloc and starts
>> writing them out. Let's call the last locked folio folio X. Suppose the
>> write range only partially covers folio X, leaving some pages dirty.
>> Process A calls btrfs_subpage_set_writeback() when building a bio. This
>> function call clears the TOWRITE tag of folio X.
>>
>> Now suppose process B concurrently calls writepages() with WB_SYNC_ALL.=
 It
>> calls tag_pages_for_writeback() to tag dirty folios with
>> PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. Th=
en,
>> B collects tagged folios using filemap_get_folios_tag() and must wait f=
or
>> folio X to be written before returning from writepages().
>>
>> However, between tagging and collecting, process A may call
>> btrfs_subpage_set_writeback() and clear folio X=E2=80=99s TOWRITE tag. =
As a result,
>> process B won=E2=80=99t see folio X in its batch, and returns without w=
aiting for
>> it. This breaks the WB_SYNC_ALL ordering requirement.
>>
>> Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retain=
s
>> the TOWRITE tag. We now manually clear the tag only after the folio bec=
omes
>> clean, via the xas operation.
>=20
> I'm a little bit nervous about this for two reasons:
>=20
> 1. we previously tried something very similar for extent_buffer
>     writeback and did not land it after all:
>     https://lore.kernel.org/linux-btrfs/ff2b56ecb70e4db53de11a019530c768=
a24f48f1.1744659146.git.josef@toxicpanda.com/
>     That patch was very intentional about clearing it later than at the
>     moment of set_writeback, so I want to be sure we aren't missing
>     something along those lines. I'm trying to think of some way this
>     logic might fail to ever clear TO_WRITE, for example.

I believe one of the reason we didn't land it is, Josef got a better=20
solution using xarray for extent buffers, so that we directly set/clear=20
the tag on buffer_tree now.

But the new problem is, I didn't see where we clear the TOWRITE tag from=
=20
buffer tree now...
I can find caller using buffer_tree_clear_mark() to clear DIRTY and=20
WRITEBACK, but not for TOWRITE.

This may be a new bug?

> 2. Similarly, how will this interact with the extent_buffer case? That
>     uses the eb radix now so I guess it's separate? But it is still
>     touching the folio writeback bits at write_one_eb.

For metadata all the tags are migrated to the buffer tree, and the page=20
tags no longer makes much sense (we still set that, but don't rely on it=
=20
for writeback at all).

With that said, the patch should be safe for metadata.

Thanks,
Qu

>=20
> Sorry for the hassle, but just want to be extra careful, as this was
> already a big pile of bugs for us quite recently.
>=20
> Thanks for the fix, of course,
> Boris
>=20
>>
>> Fixes: 55151ea9ec1b ("btrfs: migrate subpage code to folio interfaces")
>> CC: stable@vger.kernel.org # 6.12+
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>   fs/btrfs/subpage.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index c9b3821957f7..67cbf0b15b4a 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrf=
s_fs_info *fs_info,
>>  =20
>>   	spin_lock_irqsave(&bfs->lock, flags);
>>   	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits)=
;
>> +
>> +	/*
>> +	 * Don't clear the TOWRITE tag when starting writeback on a still-dir=
ty
>> +	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
>> +	 * assume writeback is complete, and exit too early =E2=80=94 violati=
ng sync
>> +	 * ordering guarantees.
>> +	 */
>>   	if (!folio_test_writeback(folio))
>> -		folio_start_writeback(folio);
>> +		folio_start_writeback_keepwrite(folio);
>> +	if (!folio_test_dirty(folio)) {
>> +		struct address_space *mapping =3D folio_mapping(folio);
>> +		XA_STATE(xas, &mapping->i_pages, folio->index);
>> +		unsigned long flags;
>> +
>> +		xas_lock_irqsave(&xas, flags);
>> +		xas_load(&xas);
>> +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
>> +		xas_unlock_irqrestore(&xas, flags);
>> +	}
>>   	spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>  =20
>> --=20
>> 2.50.1
>>
>=20


