Return-Path: <linux-btrfs+bounces-8364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947498B8BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACA92822A4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAE19F431;
	Tue,  1 Oct 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X4IJSm10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7019D8B3
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776577; cv=none; b=V8+2WaQx73bS3L9b1ZbEnNfTIqPdK4eLNtJDmSE3mv/4DKfyKCQYieczYrfscrWkUZ4nVmCWvgXcZCV+6qZeIYU1YCqpvdVzUi1dFGpG//wVKUQTzQft5fnNeHvcn96p5dk4bGqPeA9AQktXHCufAPUtHUhrnUscF1X5jF+WicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776577; c=relaxed/simple;
	bh=2d0v63fWn6L+q7Ohd3+jr4LhvFdCkIokvBiaK4lq97g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ICQPci9rHED64PJq4mmr5QeHafGSe43ymZGkHtTUT6o/4X19T9AL6Zns5fwU8ciwOok81wBVOWoCKy5wN5/nEKJLZ/AQVuc5vMrmt1tpt1iZmd5phhKSBM/4xZTjDs/IjGeQ/L7hr5cDhNDR9NP96QyKixuTukl8Jt750t44cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X4IJSm10; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727776571; x=1728381371; i=quwenruo.btrfs@gmx.com;
	bh=MZno2iHxm0JEjo4I4oXXDLrLAABB1OIDw1S+DrdrdU4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X4IJSm10MuZGV4MbmWyK9JjVjwQFHJs0M5Lb/h3ZXX8VmhNHqlrE8knGKrdUpluO
	 zwXlMxcl5kyqHmqkdCOzUl0Omj0Qh656ScTrSbRxUMqn4l1haBQi+XfoUa7jrS/CY
	 7trQyCmrxMFIRQwXtzadYVwAj51dSIzwQAztTBQHhuVazhQ09Yota9dTth1PhdhMw
	 ykflOUNVE+KI3NxXl++rJJsoVRfReT+49FmSRJtjf7Oxq4Pkw82LKXMi5NMepTjsz
	 5GNhYrEVT43WM7RmdmhTgjGwzt7QKvzd2dfndWaMZX4xFrMxcvl/r7w5PoRzz3GG/
	 J7o4BxRl+oD9KQwRyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCbB-1sQTxS05I1-00S6s5; Tue, 01
 Oct 2024 11:56:11 +0200
Message-ID: <e1079749-007d-46e9-bd07-769b912a3922@gmx.com>
Date: Tue, 1 Oct 2024 19:26:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check: Almost a day of super bytes used # mismatches actual used
 #
To: Michigan Color <rt7946ebay@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAP1eV0erLQOGTXDAgm0Y0cVxOL+x0_7ES5nq=_bu3-8kkR52-g@mail.gmail.com>
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
In-Reply-To: <CAP1eV0erLQOGTXDAgm0Y0cVxOL+x0_7ES5nq=_bu3-8kkR52-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2gq74Valpt4kvvHdXbFYpGkgAtOh2aQJNg6fLSaWMAZv0zy08Vr
 n/1r8vvjbMUCjBejXXI+qb0xJI8POtCj4DIdBPK+8jUxPuhHxcIVgIiFN7RmadAvS7iceG3
 GBNfly6vaXA7JDodDpUm1jurcfMja/VkFSdOd8z1MkmPdI6nryFd4daZiLBh3L01pa9eUV3
 RwYvBqlCYuHuggLfxBPTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gEp8jC0Jazc=;Nocxy9oCxop7gy1hZCUqsr6ROyO
 qtamdFO9ecFj9Hm9+2E3Ge8cmqtZW1UQHr4+uE9wbdSGmYb5lYBpODH4Uu0dmmHT/E8NrvR5+
 WrTcZziaMY4PdkCyyb9cMicviqMx7tm4f4bLaeaBFsNNtd8/5wGXnFYYEwYkPufAP63O4YOn/
 NZPQvU4hRzmsQzvKUvaD0kqWwWxbk9oXL66/2zJM3GrcMQqia4tR6M/hUQLlJgs9QzMFbg2rn
 Sg+oWDONv0/Gr8ys/HFja4UKPbNnfpkxki6SCXeQWRe0nPGnB3W0pFwWtCp2GqYUV8PtN40lm
 SWzWGIwHJyWPelTia8o7jDHmT1SNyaDmdmfT4hVmTIfTkTDneMpfbIGyNOJqRGCQHXrcBqjEa
 BrGZp7caGjfJb38vwf7zr64Hm8SOZp+59iuGleM5oxCOiuCIKJd68u6KBkpfTFL7LyC7/aAHr
 ZJmKEXaTgHKPpZasM39jlI0yUXTdR6JfC/BoAtDT8fI1smhqUyXpcEbZYhDrJmKKwugZU8e4e
 ho1+xAL95XMYMa5Tu9CGtULawh3FjXaFc8oxREADFhi7gbqdPkmAvPhlcNydpMyKVA9Ju2+n9
 fQAlUpXamfmyqHX235S330wzQOqCaRsi3TZETM5A9XNpF5Dnx8GJKiwRz8XWvxnUphvOxU3Ea
 MySMdAVTmxrppqNd2m66vQPi0Zs4pYz3CQBDNM5GJdT3NUvrudhcxvJ1hsc25fMqyx/2y3kMe
 ZAN0QNZ3jYTTuH+TpvEnNPeC51AGyqxyEyzBkpkU/I1KhYymMNW+LnoWFGxJFJt+cMtDs1V6i
 JyDpUhrxFIZCKolQcAEuJz2g==



=E5=9C=A8 2024/10/1 19:14, Michigan Color =E5=86=99=E9=81=93:
> This is about a 500G BTRFS volume on a 1TB Samsung 980 PRO.  (Nowhere
> near enough TBW written to exceed the warranty coverage...)  NVMe
> drive is being replaced.
>
> Had a physical write failure on a root partition, and the kernel made
> the fs read-only for that boot.  I was able to ddrescue the entire
> volume to a file on another drive, except for 16k at sector 423725416.
>
> On a clone of the ddrescue image I made, I'm running btrfs check
> --repair.

Please don't.

At least run a plain readonly one before that, to provide us enough info
on what's going wrong.

>  It's been in the checking extents phase for about 18 hours
> now.  About every 12 seconds, it prints:

That's definitely something wrong.
>
>     super bytes used 456946466816 mismatches actual used 456946434048.
> I can press enter to make a blank line, and see it's still printing
> that about every 12 seconds.

The line is printed in check_block_groups(), which normally should only
be called once.

But for repair mode, it can be looped again and again for each repaired
block group accounting.
That's why it's running for so long and so many loops.

I even believe it's in a dead loop, and that's why we do not recommend
to run --repair *AT ALL*.


>
> btrfs inspect-internal dump-tree | grep -c EXTENT_DATA shows about 7 mil=
lion.
>
> It's not printing one line per extent, is it?  If it's a few days,
> that's one thing.  But, if it's going to be 7 million extents as 12
> seconds each, well...
>
> I almost wish I had tried filewise copying the volume before running
> this, to see how that went.

That should be the first thing to do, mount it with -o ro,rescue=3Dall,
and copy whatever you want.

And I believe that will handle everything except the bad 16K.

>  I could always abort this, re-write from
> the image file I made, and try that.  But, if I needed to go through
> check again that would of course set me back close to a day.

You only need a readonly check, and that should be very fast, and we can
determine what to do next then.

DO NOT TRY --REPAIR EVER, unless told by a developer.

Thanks,
Qu
>
> System is an up to date Arch installation, but the kernel is from a
> few months ago since AMD released code that prevented the system from
> booting.
>


