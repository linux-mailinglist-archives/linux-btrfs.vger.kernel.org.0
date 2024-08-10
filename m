Return-Path: <linux-btrfs+bounces-7089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88694DF3D
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 01:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BC8281B0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA7143884;
	Sat, 10 Aug 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kZlroqY4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508921CAAC
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723332974; cv=none; b=iMfcyhR02jMD189HeiyZ+mriDgOPqI+kpOlkyf97ZlQcTFQhJbUwtyyGxdmSdOMIZ9JL/X73LwC6WPMhCrtJ+L6YVQpJa5+aQhdfFv50lrfjBKCME1k+Thtpdy47qN6e6VToi/GvuxaNJzzu3IrFwe3zFaude3iwWUgE1/31Krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723332974; c=relaxed/simple;
	bh=i1iV0OGpj8dDhaLQJrYoSbhv81n8iq9/F6p5GFmjLvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mr1X44S7KWCiHeJAWuem+IoU/Le/z8vScfiimy3kQai2aJ9qZctfaMkS9g1uOMIL5gS7pqd5rm3MbaKmhIOF66Cp/P8kkX8NOJs4RalWlMiRb15cphtvo3yU3Wvoof63qtiN/LRzsuKShfKeFfjlaWSfd6cWvEedBV+HY444t7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kZlroqY4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723332966; x=1723937766; i=quwenruo.btrfs@gmx.com;
	bh=i1iV0OGpj8dDhaLQJrYoSbhv81n8iq9/F6p5GFmjLvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kZlroqY4CT21ew0Uynx5y9iIu7Ujp6/fDl+gTMEL6LzySpyXCZVt2z+HF7Uvkkx9
	 f/bTecPXioGF8TQ/vAbch2FM/fJ603nmQ31OE8s8+0smU47w9KLA0ILpg9bpemhkU
	 VYIYndLcjEWed4Yof20vLBSaOCUN9NY4n9xLOMzLmDLeF6/s3ZNpFLbg1C7878h+P
	 cZbJYe+xCD8Nji+92OwqGhttJ/4HklIvR7I2Mp6z4p5dEEVUjJOyjjMI7UGuITfcg
	 AmF13GT9bE41wsmp2MDetmQ3HBIjssiJa/Jn8/jlwkgfqcEu9bkZ0Ri1h4NjzBBw8
	 FiHe/SqT0CxqYf/lgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNtF-1rvZzH0c8b-00jrbj; Sun, 11
 Aug 2024 01:36:06 +0200
Message-ID: <3161f529-c9c1-4f98-8ee1-9e97cdff473d@gmx.com>
Date: Sun, 11 Aug 2024 09:06:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Colin S <linux-btrfs-ml@zetafleet.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
 <e42a03e0-df4f-45f8-a61e-3b44fcd387e3@zetafleet.com>
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
In-Reply-To: <e42a03e0-df4f-45f8-a61e-3b44fcd387e3@zetafleet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YozUuSitmwIVVD5+zZoe9uEgnY+FjP+stU8ziCFsHudfwY//SYT
 TkaFzsvsKvyVOge0IU4p9YWUGjyN1bD5e52og7INdUR7N5l94p7bp5ATGkkYftPTWLQhwRe
 eyicUApZQOEGD8OwIp+NJwI+1MUeb2ARlpCRb2/oEzFZHzykeodcxOsWYwTZs38FaWTsAt9
 /5sSGXOP1R9P9Qu6ZXgOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GzkRW2ajp9w=;qQ0pYctdG3MdYB9N2r9TxCmNGa5
 kne1yjni+iicmsCqiJ5V6ECZ6Ini/Xx7zPJpJ8gDj6KTftiwYbjR2Yfwf2jGfLSVr410QCt3W
 yLJs2jmI8GWE9YNhyrRoSvURSfwZ2//QPt/1Gc06McCf9HP8KETlTyJBM7vfAaXRnD7mPokSC
 d4jQoHj6pQvz7xN9mPMev00WKZY2vht9Y6WM3xXBj1CENWuYUfUC+MRw+MEr/iwuP9/mBHLz9
 lLPngSwwQzfLJOD70IKgdEaJjfUG4inX/mSFWRHd3U111cFAK6N78ZuKn/ILCA7pvoUmVXtWV
 Wns2Mwozo8MZhCSALgxv0vSAtXJ2toGQJCVtzltk/lUpAyMUrvwCswCGBSjzqE96PyYLTnTRN
 ROyXokH9hEfoIgytwRauSHy8C6HMLw4P5nbU6UrdCzwQiUI0lf5eaDLT1f7ke43VTKb+IlGXY
 nm0rlnoMOfXa4ePh7Kj4/GPO4w2NpT7eRiXIovMp3FZ2xClLqfBmbkpN+Kx5txxcWR70ewBdw
 /csQ7TRHBltKK5ZEaX+Qdjj6VfODMSya2O6XPJd90pO0O72uE98dhyaKCMBznwVw8MJWVXHre
 4xySPbr493u7PCAdC/9/W/nxQF8KSQi8lFdfcaMA2eUgg6Rx5NexGRPbsT8dUCuSoOW+xc/wf
 op4g5kFiVMxWFfvHK2KldBVRH4f/+6KDOHXw1OfRyQf8zSmbGcVxXKEUNChThrXTzczybaTkf
 qafISx5AijQsdkdb7hLnvC6tYjb8nKQg/pWgvif/lETN6PxTjQj6Uhd93zeFeTd+ucmN7pS42
 CUNLZ7UDG+mCn2yDlTkoAKTwB2khN1pafhTqQ+aNUjnvc=



=E5=9C=A8 2024/8/10 02:44, Colin S =E5=86=99=E9=81=93:
> On 09/08/2024 00:17, Qu Wenruo wrote:
>
>> Another possibility is, some NVME firmware has automatic dedup, thus th=
e
>> DUP profile makes no different than single.
>
> If this is a known behaviour of some firmware, is it possible/do
> benefits outweigh risks to store DUP copies with a simple transformation
> like fixed XOR to stop them from ever doing this?

As long as the firmware is a blackbox, doing those workaround makes no
sense.

>
>
> On 09/08/2024 02:31, Qu Wenruo wrote:
>
>>> Is there any sort of worst-case scenario data recovery tools (maybe 3r=
d
>>> party?) that does pattern-matching of the raw data or something? It's
>>> not like I need to recover videos or something, it's only a few text
>>> files with known names, locations and partially known content.
>> Unfortunately no.
>
> testdisk/photorec/scalpel do pattern matching recovery. Is there some
> special thing about the way btrfs stores data with single profile that
> would make them worse for btrfs than other filesystem? I guess if
> transparent compression is used then they will not see anything, but
> anything else?

AFAIK those repair tool needs at least some hint on the metadata, like
where the file starts and ends, and filenames etc.

Or it will just throw out tons of garbage and call it a day.

Thanks,
Qu

>
> Searching, there are some other third party utilities that claim to
> support btrfs and attempt tree reconstruction at
> <https://superuser.com/a/1752751> but I do not know anything about them.
>
> Thanks, and good luck OP,
>

