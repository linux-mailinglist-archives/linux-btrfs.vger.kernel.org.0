Return-Path: <linux-btrfs+bounces-12244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F5A5E8CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 00:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D7E17449A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0A1F2367;
	Wed, 12 Mar 2025 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JIRruJLo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B2165F1F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823681; cv=none; b=tyPcZbgLz7Dq2cmi42Uimq/OfxrFssH1rMB8Y0tYidhO0DTSXGDRZmu+iATui4bd4/O6DG6YRzSzsdjC/UJp+Ku+4OGuvpKQMVbApIc5ajM3YYUa7jY7+bcEbHCNEYbgKwNz6S7vbJnXjdYnIJao/BKmxtSS27NNE868QJOlg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823681; c=relaxed/simple;
	bh=v7MITTJiZzGkUpXUFEHkzLRe0vlIUsBAq8dQPlt/9cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6OWVgvm1/DXvkYV2iCC/s9F4VB/Jsq79WgoM+d1+j+x64lMwqTVcizG1ryFzNlYBGF/XmmquaVCUD9lYOWpCcmr8X8uAK/Bj5dE/anH7ms0qu8lxet2t+gXDulm+ku2AkGpCgUvI+eqpWRBoFXE6wtBzHjMdUb8gcVOJ4CnJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JIRruJLo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741823677; x=1742428477; i=quwenruo.btrfs@gmx.com;
	bh=uOaxlWCPyV2MDHOQ5Zd3de2q215RxdIF/rGtgzKojL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JIRruJLo1N4F+VK2A3wv4ukow6RMXQQ6Zgym3e57O+elXCX/lNz4oKrBxINeHuPM
	 oQuOxR41QTSmYAHhCFGR3uql0Uei5avrD19ZZ+qeB/mX4EaH8AGnN6HQWwYf8pJHz
	 g1ZyBH5aWRXU2rCfa0oNHoHJ1yGDnx/Q4OQqukjjzEoZlJOpHcxwZTwStWhkbs3cP
	 YSgBJd+GZN0RIneKEqqXXtRk4YwbvFM5dSb+dNDiWkga9dIJzyRGQ78AJykwLKr7Q
	 vCgav5I0iN9MySCSHNmtlx+8x6g4TJCjKp2mkQmpeyATpYWo0NNwxA05Onn2yE/Lj
	 sZyc+Kh3aqPaWhWb2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1t7ykQ25zm-00xKCl; Thu, 13
 Mar 2025 00:54:37 +0100
Message-ID: <9c4856d2-50db-4c39-ade7-7afed2eea502@gmx.com>
Date: Thu, 13 Mar 2025 10:24:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 wqu@suse.com
References: <cover.1741631234.git.rgoldwyn@suse.com>
 <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
 <20250312140807.GO32661@twin.jikos.cz>
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
In-Reply-To: <20250312140807.GO32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AYp+EB3CWLi/S/xITyDeHwgH86NRPN0jo7YznFAH+n9VOOpC1fP
 qxqvMuNnyz1TayD9WfMgjalEp40hZSrUUlKt6I8uxvptcWQ25cdHca2zXhQXEKdKOFDmFt0
 JDl0Pmg4lSYWrCR9SGLkM5mvlLhwq1tJ3uDppBh3PLBTHf42onjnew7zWcFbohq38Nv+w+f
 +/6jfmUpvGcDX5PRSfRlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pL29CFRgHPE=;ZG3IOWZUbBKpFkds4+wA2D+Tkqp
 kpAEYnKybssEb4r+a3iAw2CnC5QzJfUn/wPz8xHCOlq9DrUOh8eWco+GOlUn7zlNa2PTj8xPJ
 tFmenzeqt94OP6ugDUpTPyOYCnEOLTRUHJsbHH6IFgqf0u3Pu4lV5hEMJXOi2TS4pixNtr+po
 VIHooNnLtv6rVTL65NUuFg/nVNRIvOHcwH3sor8FdWaB4f+x6l2wXrbv98L8DoG6qMrjwwwdd
 TRG1KdrFe0uYB9LgfVk8qXGBHmg1BndogzGUiX3ntWLMTDT+qFbTg774S/Bux5NJBIN5c2KLk
 G4mc6uB/Z4VEh7MRBfN5mwnlxTSM9XUaxiKXnUnaXSIOcu+jo+uIFn/mW19FY2xnP+H4QeBV9
 XrcOf3V7w10kCoUjn4wHBq3LzoBdRz+5Kc6VZmY7wK7yzsl0BoUKjijNU9rirCA7oPs0XcpJz
 JAJwDC4o690ZDlUiyS4a4MGUf0iwGnWUcDPRgaH12BQRYfyh1iEfCFXMCowS6DvDy2XvrokA9
 E4Z6qd3JCUDQx8GqDDjSZSOa+cTQu32RFkaIYRVXuD7lOf0iiKKrBocVdng3rkS/dZ+3BWQj1
 JRg0D8Mrr6PML11vqKdSR6HyCkvlfmX6m9NW+NXAaY5jSxNQAy2OmsunrLRJ7zvJVmZBS8A67
 5/cjCALAnQ00ny/j6pVq3s8qYlOfm2D6YYM5JzzpLJ2ojLRwSPGnKMrH2XmglE5FBuRYLrWCS
 JxgpVtDStlv4EdU9bho5HGercTVx3Qd/4wgJe/Z7/j3naRqBnUz0jVT/F6WuCy3J7RBMODnxg
 ckyHs2KBZ6xCIrFb/zO3YGosODJCzsyQn4nT6g9qkcz7xATpqI4DV/zDJTHs/Pa09pF53hkyo
 a8lnvO3ZwylevJq06sXhkEPPlQ8/Ckz7dQY+V8fl6BA1GLjiFkCZN5PlVy9IwVOP5SeRZ9bhq
 xNK3SuV7jk+NJmJiEMhDFJCSfQbEwqsYGCaCpVbLliA2bzHU1GCy9tWz2bphNL4+YQ4xsCBKb
 BfZ+4GoJoBgaGrjOkIFBF+Jha/bKJ+Or024T40OwDM90Cua6grDHe+N7qNw94C2tgl/uoPAte
 mNtDaIYgBuy+6LzK1lzBiTfDFZMsbEiZ6rs6OtkP6QTYWzJ8iiZCKuE/cW6s2wt/Lj1JMwLs8
 RgtBrf9LY3Kv25DKvUFmlzQCBQePixSv5Q2fbWWUnx1cJyN1+LUO/QjdS/IEsfBKD2zMgLEZ+
 bXMBoYQhbluPZciuFiZdT2jWKU7AFtAzcRChg01Jutlvd6ydj7t3BcWFzKRBbJe0/ssg8+aiN
 zLNQTLwnZDqQeOV8KfOg6E032UcxvnApC60bS7MIJgtmh+3qfqs+FcX+nDwotHx3CM7RoWDli
 tmN1i3kc2JzK9FpH11yeYyjlTX8BaR5DFzGItZa9S7VGi5zLxx0BEVnroaQN1HZ9kxvymWnZc
 +nbPuApW0m+Y6BI6jke/aQs7ZjcA=



=E5=9C=A8 2025/3/13 00:38, David Sterba =E5=86=99=E9=81=93:
> On Mon, Mar 10, 2025 at 03:29:07PM -0400, Goldwyn Rodrigues wrote:
>> @@ -1731,30 +1711,7 @@ static int extent_writepage(struct folio *folio,=
 struct btrfs_bio_ctrl *bio_ctrl
>>   	 */
>>   	bio_ctrl->submit_bitmap =3D (unsigned long)-1;
>>
>> -	/*
>> -	 * If the page is dirty but without private set, it's marked dirty
>> -	 * without informing the fs.
>> -	 * Nowadays that is a bug, since the introduction of
>> -	 * pin_user_pages*().
>> -	 *
>> -	 * So here we check if the page has private set to rule out such
>> -	 * case.
>> -	 * But we also have a long history of relying on the COW fixup,
>> -	 * so here we only enable this check for experimental builds until
>> -	 * we're sure it's safe.
>> -	 */
>> -	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
>> -	    unlikely(!folio_test_private(folio))) {
>> -		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> -		btrfs_err_rl(fs_info,
>> -	"root %lld ino %llu folio %llu is marked dirty without notifying the =
fs",
>> -			     inode->root->root_key.objectid,
>> -			     btrfs_ino(inode), folio_pos(folio));
>> -		ret =3D -EUCLEAN;
>> -		goto done;
>> -	}
>> -
>> -	ret =3D set_folio_extent_mapped(folio);
>> +	ret =3D btrfs_set_folio_subpage(folio);
>
> The removed part is from a recent patch "btrfs: reject out-of-band dirty
> folios during writeback" to make sure we don't really need the fixup
> worker. So with the rework to remove EXTENT_FOLIO_PRIVATE it's changing
> the logic a again. I'm not sure we should do both in one release, merely
> from the point of caution and making 2 changes at once.
>
> I can keep the 2 patches in misc-next and move them to for-next once the
> 6.15 pull request is out so you don't have to track them yourself.
>
> Also question to Qu, if you think the risk is minimal we can take both
> changes now.
>

I'm hiding the new change behind EXPERIMENTAL is to get more testing
before we're 100% sure.

Although personally speaking I'm confident the cow fixup is useless and
are just hiding other bugs (e.g. the one I fixed for various error
paths), but the most common objection I can remember is some hardware
specific behaviors, that I can not verify.

So just to be extra safe, I prefer to get it tested on all architectures
for at least 2 releases, before moving it out of experimental flag.

I totally understand Goldwyn's push for iomap integration, but I believe
this one can be pushed a little later, as we have more low-hanging fruits:

- Fully remove the usage of folio ordered and checked
   That's depending on the removal of cow fixup

- Remove the async extent behavior
   So that the compression happens after the blocks are submitted as
   bbios.
   This allows us to handle compressed write just like any regular
   writes, and allows us to align the writeback path to iomap.

So I still tend to delay this change.

Thanks,
Qu

