Return-Path: <linux-btrfs+bounces-5361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486E8D44C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 07:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E13B1F228E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F67143C55;
	Thu, 30 May 2024 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OqaG2S+H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA205143878;
	Thu, 30 May 2024 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046809; cv=none; b=JkfxdpfixeCIfT3ruX3QpHrgtnOwfZzLzM4ShBV9mArWhbZlpsxZz4s/eWkwgWC0/NPMhWMP0OAPpPN1FfFAdX3FihQPpmhwqTxQZH379ikwtpnbf/ugyMvABycbfRF6tpbwbSqt89mWGs/Nq25zOS1yENheMOMyDqAke0bit8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046809; c=relaxed/simple;
	bh=mnVinxMUHktZKPgzI5dmB7Ka9d0W42SiUpaFimLrj9I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j4fMT8NCLUTcIhWkjl5q3yMCzh/XeN/C4M8tpvpkLGlj6H4+wIHeuSQZu21Rkx8HLE0gkHChRsKpk3lQXj98Rgu5tLEohYAhd0RR19VTOvECP+Q7+RetLj3p14GPO9SK/HzUhrlLL3ysWu4yaJTQnNslyOzCSv/1SsKfeeXBYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OqaG2S+H; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717046787; x=1717651587; i=quwenruo.btrfs@gmx.com;
	bh=91NacwT4k2C/RCT9m/dd2NEzG3OnTL+i0oYrYWfYRWk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OqaG2S+HrKNZDJda8X3RDSrujafcNWQEjlOmg5EqXyDjrGt/Hogq03j52Z6Ka7MS
	 XWop3QeHcy4QvY9H349oCH8R7QmfWKxNW6QLSw275NEkTQi+Vg6kqwDQA59Mu4moB
	 uYnJjAIG/EZbygGFUC0Gsj1dbXdiWP4OMEFzK6Mc2FmkQqMf8iEt3uUniVCWkG6rp
	 pBDP5u/Ikxg+BEA+GWNQn+XRUHRJXCETkcYsEx/aFebnXbWxRafx2hT03NW8+RnyU
	 dEgdp29koNqSK/CsJYPQG+ADWNuZVI836+2aC5lMO+prsTK7ORdTIaMmWvRqaTCoC
	 YMuLU5y0kB8envtEbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsIv-1sWHHZ1OEB-00tzEn; Thu, 30
 May 2024 07:26:27 +0200
Message-ID: <e8c134ce-3253-414d-855a-bb1714402df2@gmx.com>
Date: Thu, 30 May 2024 14:56:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: David Hildenbrand <david@redhat.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
 <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
 <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
 <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
 <209ff705-fe6e-4d6d-9d08-201afba7d74b@redhat.com>
 <ff29f723-32de-421b-a65e-7b7d2e03162d@redhat.com>
 <d67dde35-0c14-4da2-8628-f4a27c32417a@gmx.com>
Content-Language: en-US
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
In-Reply-To: <d67dde35-0c14-4da2-8628-f4a27c32417a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cAbGcalo1YyG/DQdE32BpDqIhB53B2DM56zfnUPStKYEh31ktH
 0zMAiXQ8V+993vZ25YsKipeIppv+Sh/Vl0WetmJ+vTK4waeLfBH4mkI6VQQfrmRheUg6DFN
 7UnhBFc1I8Rm3tHvNXJ855rpvfItrYTr4eSm4ByHy9H3KIMHqYAAHbzfYb2ZdKJSQzcOOsg
 VFFr573qRj9U9iahqH8mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6zKZO6u+jFk=;5sj+Mt5JtUz08Frv+BqGP+3a8QF
 Bbds6PXE3uOnVaQjQjVMK2kkmqkPjoPcCsJGUE2v4m4Yc1OGGD+u97mZAyzxm8rV7XrUY2NK8
 H57ualm2LAmIPLaJU6R06EXDdzNbaAs9BRopNFu6D88rxyjM3ypb1XasQiSDVDg+NzBo3+uxC
 XvzRlbTtLvaiIX3Px5SuG1+wXaD59OWjTPpI+VwV14gkPSLdl3gW3tTpB3SIJGcv/rCxOABvQ
 q6r4Gg2bSJpGFXicBBetyF6z5BTSHbxpoh7HgpnwRFRQRYV+bOOV9VPIjq9RONi3/7fVhiyJS
 K0TzBwX27Ymb/k8PUxPP/KParrVYObUHPMZ+7DJ6w5xBShcseFxFvfr6gmUeyj9T2WetZmI5Q
 CVkST22UN9YzO4VHCSVcKEFrBiWJPoqOqzOPjZOw/o0aHDJ+3Q9GH6M0c58SxNFZC6URbEzhV
 EnJnOlf1HA21Zo/lyy1+DQzgxT3gywpSAEMbEfuZ2KLFDlC0Yarl2HcDfAWsK7j+F9C9N40Ue
 ht+FnkCUILnqA8hR4zNYYw30muQ2fubw8Hh+8zfI20gDVoCz+bUr923uCWGOMME+ab3DTGX+w
 5b4BMz7V/sTArQ4RQlni35SH7K11hQb0lt1L3UBVXpJ83V7CiieLaJiLIWY3Eoh3B6MkHiVqi
 AtBZV9JbvSmmdg1B42HrqeVoBzAXo8oayELC/YHU0YgadLireSfoBgThy6zBAbU5Mp4Joagyk
 N64IwXrxgYxRN/L2O41L8cq8onJukytklIyZms/bPr5R3QDfnQwFINOfSwysA9Oy3NnyBZ7NF
 F7us5tj0FFr270KdDZ+jIo72jbV0ht3EuJLaO6mJ/BhAg=



=E5=9C=A8 2024/5/30 08:07, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/5/29 16:27, David Hildenbrand =E5=86=99=E9=81=93:
>>
>> A little bird just told me that I missed an important piece in the dmes=
g
>> output: "aops:btree_aops ino:1" from dump_mapping():
>>
>> This is btrfs, i_ino is 1, and we don't have a dentry. Is that
>> BTRFS_BTREE_INODE_OBJECTID?
>>
>> Summarizing what we know so far:
>> (1) Freeing an order-0 btrfs folio where folio->mapping
>> =C2=A0=C2=A0=C2=A0=C2=A0 is still set
>> (2) Triggered by kswapd and kcompactd; not triggered by other means of
>> =C2=A0=C2=A0=C2=A0=C2=A0 page freeing so far
>
>  From the implementation of filemap_migrate_folio() (and previous
> migrate_page_moving_mapping()), it looks like the migration only involve=
s:
>
> - Migrate the mapping
> - Copy the page private value
> - Copy the contents (if needed)
> - Copy all the page flags
>
> The most recent touch on migration is from v6.0, which I do not believe
> is the cause at all.
>
>>
>> Possible theories:
>> (A) folio->mapping not cleared when freeing the folio. But shouldn't
>> =C2=A0=C2=A0=C2=A0=C2=A0 this also happen on other freeing paths? Or ar=
e we simply lucky to
>> =C2=A0=C2=A0=C2=A0=C2=A0 never trigger that for that folio?
>
> Yeah, in fact we never manually clean folio->mapping inside btrfs, thus
> I'm not sure if it's the case.
>
>> (B) Messed-up refcounting: freeing a folio that is still in use (and
>> =C2=A0=C2=A0=C2=A0=C2=A0 therefore has folio-> mapping still set)
>>
>> I was briefly wondering if large folio splitting could be involved.
>
> Although we have all the metadata support for larger folios, we do not
> yet enable it.

After some extra code digging and tons of trace_printk(), it indeed
looks like btrfs is underflowing the folio ref count.

During the lifespan of an extent buffer (btrfs' metadata), it should at
least has 3 refs after attached to the address space:

1) folio_alloc() inside btrfs_alloc_folio_array()
2) folio_ref_add() inside __filemap_add_folio()
3) folio_add_lru() inside filemap_add_folio()

Even if btrfs wants to release the folio of an eb, we only do:

- Detach the folio::private
- put_folio()

So even if an eb got released, as long as it is not yet detached from
filemap, its refcount should still be >=3D 2.

Thus the warning is indeed correct, by somehow btrfs called extra
put_folio() on the eb page which is already attached to the btree inode.

I'll continue digging around the eb folio refs inside btrfs, meanwhile I
will also test some extra checks for eb folios on their refcount.

Thanks,
Qu

