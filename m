Return-Path: <linux-btrfs+bounces-5358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E98D4176
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 00:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF841C23028
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B93178361;
	Wed, 29 May 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oQShsQ+r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F36169ADC;
	Wed, 29 May 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022335; cv=none; b=GqueN9IgUxYXvt/XoNLncgKiaf3+wA4oqge0w5BSeGqERGtpqYpBFrA6rBmvqJ51x6qRj1ug69GS8/VHPXhrGEB77zk4KR0DAIEiUq2y/M07qoV9rUKe7TQSENItExuAcO7TBCa5/fF5lykV66j3JeWpZRYBvQihU7YwgcxiB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022335; c=relaxed/simple;
	bh=JFiZ/vr1rm7cLa4a2ftkIuJ6oF1Zj3SgMk+NCrYSJq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTThiWiRbxY3AS0rXbvLw6FEk90OuqyCIBbXYFuYkF/GdX2U7AaOkSYYe57B3ecdil8KNdkkd/dcU0IP8OD2kGnR7Ybkv8R2ybnPVhv0A9s5wYqANv4N9av8ekPk8S6C4T4ewEcjKi9HofzlfKHlHLg/NGto2q5XiT32Ka6d3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oQShsQ+r; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717022247; x=1717627047; i=quwenruo.btrfs@gmx.com;
	bh=sh0xK1DLoCdr3LhWiQ/YVo7atV5IjlZ+EcoRVqczCOQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oQShsQ+rj5nwkhzsmzkqMVSX+TW2yeqrdGhYH1mnHMhpaMZx7vdPUJx5ZrIL9EYW
	 zMX7adwELr2XI84L0MIcVWw/U6uuxWm1I2sB41oxmHtOnAp8PTgMnPRE/iDKmLiVH
	 WIukUj0rEvLmbOYO5lzGRNd+StpvjMGheQ2hNbND76vMdDTR98eimMcLTZiKHr+gI
	 qRgY5t9XDEDxbJTJtdnrPAihkJGDQhVtbi2rZUnwLzC0m3U1r+Fvno+Gh7BrWbX7k
	 FrHH60urumA4Bdo+r+hYrjcnyN6lAcc396LsyEpncX3q9+Y+hGpwSGkFoNi390nr9
	 CSlmhL6Z3djUqvPzjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1sXXL33ect-0152kW; Thu, 30
 May 2024 00:37:27 +0200
Message-ID: <d67dde35-0c14-4da2-8628-f4a27c32417a@gmx.com>
Date: Thu, 30 May 2024 08:07:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
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
In-Reply-To: <ff29f723-32de-421b-a65e-7b7d2e03162d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7Nm64HO8281pK1tOLI4ApY7qFkfLtxwwHP6+vDGV/auwm1+t8Z
 mLbds0rwyq+7KKzpJVNjO84EclwUhiJg/PnjSJ8J/n7F+smIlOCxWvBnAgu+E3n375O1GIM
 ecARfq5mq74F/VusyYP7p7OwW8Mxz/tPYjAWGH1jgGmQ8EW6ZTdu+fmjocQbfcvsLh7rrob
 f9HrdkgJZm7sEgDQQOINg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XPtvCe11CWI=;5zcsxHF7mU3S4ErU4fNM26tBw8h
 MrZ0XCLn80CzuNHBiJ8AMAOdNQ71dgvhY2GtdG9yfgeCk1N9tTSRvQl8IsFb3OwnzxK1UUQEI
 PPYg+wv4hXcJfVuXRZakWjDBo7RbbZLAfOjROV1imwLRYyqQtHlaMvkd4PcG+9ggRH4GTeHwh
 ceIclglt8vOhkh1k/KwbEbrNdlYFGYQhNqgrq6x0udfngTzVhDpL72Qaw1bxkoz2nXYDBODZc
 55FU8aw2PWCTGsakTxQfRvShq/oQYg7Hs3QWjyow1HZb2BZOCi4UNVghYNPpOdoDRcoqWx9NE
 jLHwDVx7NHqrhUsEpa6K6zxDCsNnMLllePbqZPn5144czxO4jKbeC6PD0/LyQ9P+5m6maWJKP
 vJaO3oPobs7xTF3zA7zNRRVKYXztalay75lMsw5Q4zyIX0CBJ/c9bBHZJ4B3+q7a0jS3QDv98
 ThYC0+BNKYg0azuJpudst670HpZO3oNWIAr+CY46erNZy14g5agvvnqZnb8moPnGfVX59CYzm
 godMFRUufaaipaBDBKSXRm67jxT8U+JEijiUsw2l399P37pOO08niwCW1b5W3M0fhWvT5aFma
 NBBLHGffuLDgN93p8vIf8Hz0qcEvY/U54xsd6oX8kfTKLgc7XKX14aOZOAKUQiVwxYdDNUTJP
 6v9G3lpQEno5Ac/WaCQ2eyD4tCViCe0GeQG/pi2upmH3ATlNw9OAYg02Mck/cma7icV3HelKF
 MlaTS8HOufokb+QD62h45EQekY1/WAkR9ULtvestrgOyW3x2UiCRdfr78k8OxzkzDI3dwwWXZ
 ZuR+7kbdvSH+Pc0oXGEyd7Faym+X9N3TPdDWFxpbymcq8=



=E5=9C=A8 2024/5/29 16:27, David Hildenbrand =E5=86=99=E9=81=93:
> On 28.05.24 16:24, David Hildenbrand wrote:
[...]
>> Hmm, your original report mentions kswapd, so I'm getting the feeling
>> someone
>> does one folio_put() too much and we are freeing a pageache folio that
>> is still
>> in the pageache and, therefore, has folio->mapping set ... bisecting
>> would
>> really help.
>>
>
> A little bird just told me that I missed an important piece in the dmesg
> output: "aops:btree_aops ino:1" from dump_mapping():
>
> This is btrfs, i_ino is 1, and we don't have a dentry. Is that
> BTRFS_BTREE_INODE_OBJECTID?
>
> Summarizing what we know so far:
> (1) Freeing an order-0 btrfs folio where folio->mapping
>  =C2=A0=C2=A0=C2=A0 is still set
> (2) Triggered by kswapd and kcompactd; not triggered by other means of
>  =C2=A0=C2=A0=C2=A0 page freeing so far

 From the implementation of filemap_migrate_folio() (and previous
migrate_page_moving_mapping()), it looks like the migration only involves:

- Migrate the mapping
- Copy the page private value
- Copy the contents (if needed)
- Copy all the page flags

The most recent touch on migration is from v6.0, which I do not believe
is the cause at all.

>
> Possible theories:
> (A) folio->mapping not cleared when freeing the folio. But shouldn't
>  =C2=A0=C2=A0=C2=A0 this also happen on other freeing paths? Or are we s=
imply lucky to
>  =C2=A0=C2=A0=C2=A0 never trigger that for that folio?

Yeah, in fact we never manually clean folio->mapping inside btrfs, thus
I'm not sure if it's the case.

> (B) Messed-up refcounting: freeing a folio that is still in use (and
>  =C2=A0=C2=A0=C2=A0 therefore has folio-> mapping still set)
>
> I was briefly wondering if large folio splitting could be involved.

Although we have all the metadata support for larger folios, we do not
yet enable it.

My current guess is, could it be some race with this commit?

09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method")

For example, when we're allocating an extent buffer (btrfs' metadata
structure), and one page is already attached to the page cache, then the
page is being migrated meanwhile the remaining pages are not yet attached?

It's first introduced in v6.8, matching the earliest report.
But that patch is not easy to revert.


Do you have any extra reproducibility or extra way to debug the lifespan
of that specific patch?

Or is there any way to temporarily disable migration?

Thanks,
Qu
>
> CCing btrfs maintainers.
>

