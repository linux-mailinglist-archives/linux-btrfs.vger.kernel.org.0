Return-Path: <linux-btrfs+bounces-9670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF19C92FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086101F22626
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00701AB526;
	Thu, 14 Nov 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Kf4Nbu2E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD91AAE28
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615110; cv=none; b=kewBGWZzGeRMCU0v9ypHbj9wmLI/UESf5zWoYYQ/bMQUttp6+I900Rtua31qZpLjfvC6wLTGLFVANDu47JFMfrUwmGaBYEarTclahpqr867tfacLL11wxNzZLjljpcVln75VnxGbTKG3Fh9kAPgHukIXOMVBviujguLoa6GqV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615110; c=relaxed/simple;
	bh=yYpNP/HGu9Gs2KCfug2pfv4qbVjQIIWpk5yneQNZRFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KRgPWDncXzYlsDuwr1sF3VkWZGydFW/3MxC8GhIeSdgE0tMUnJjumqIpVwTkTFH1dM47Lm67u00tc3QuzsiN0oK3ZK/rjs73oAbeRQah7gpwY/sYg/sRCrmdOAyO62uftHAIir9XpcneDaZOYI45ggBFDcjFq8oWAmqNN6Wd2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Kf4Nbu2E; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731615102; x=1732219902; i=quwenruo.btrfs@gmx.com;
	bh=q5rcr3E6gjWk4q+WRAxHm/xrhQqY4fX2FMtS3TWdULg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Kf4Nbu2EJD+rHiMViDTz0XGbZMGsxEWY5924sxjhJB62W+l63CuLfZisZSTwTjIw
	 PoAxHmWgRFVPRuGFPA8W/La/5/9cG7iFJKG9+mDA/+KILC7qxTVg1U9M2Pn6zfplb
	 OgELVZp/fkDSmTqrG+4QoFF7AnBGnHaDVF6zlYlvA2xvbvHoE7zTvAfvKCBw7ZM6I
	 FyWjuLzfrwAoNHHwkNRQUYwAlPDMNuNuiYsKCWeHMNZ170VeIb4p2yLqlugAYVPY/
	 koiR5gfY7Zkrhs3nzl/m28L2w1fkEF9FTIFX8OnFYP9Mg5VRrYYLQleUbJXAUqLkz
	 YXU8uYatYj88xBd5ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1t9jB10NBJ-004QBO; Thu, 14
 Nov 2024 21:11:42 +0100
Message-ID: <ad2b1e16-595e-448a-b05a-66290f04a284@gmx.com>
Date: Fri, 15 Nov 2024 06:41:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove unused macros in ctree.h
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20241114152312.2775224-1-maharmstone@fb.com>
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
In-Reply-To: <20241114152312.2775224-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mG+wOtRZPKscpYcCy1Z7Ysir+uNpZTZSMEVLOyfXGmw6jU8BjZX
 mkCZ7fP3Puz/OktygKBnZC4FHxy0YwvnF+fpM/zqWzzD24elrd8LDCZDRrpiw8q3JeGahWg
 9zoYkR1KzsdNFM3ygV45vjf0vd0IdeFRrNp1VQVNLrRe4j3YXXTqaZ4jT48bjum0dm56ABB
 iP7/A6/spzBhWtEoP1HHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fEHx75gDYVo=;QejC3alk1aAXD1Vsnau63WWgZmI
 gDz+4sHsBJSmVZgrDFngMvRDqyA+hD7zDPAzVZ4TO7r8U8WL6+2VYbVftaQDq7qKdeiKzCGzG
 MIlqgbAGMlmSj1moNFMnM2+H7vcbJol5N396UMtYZpLyNSuMAcMUu+O9s5jRZnGPpIbABZJGl
 lj0VTxT1vqcQOQnyztWsucxV2DUyNZqetqJixnd/VKjnYMXO4wsxAfSV1atPVw9Z7KEiDjjKU
 5K5xXlI4vjcn3xg9o7AqAZkGEveP873sKmGBaRIqg6ZBjZOjMmxDXXG0+BR88mI9X0TY6LmaG
 6HAPugwfUW0fuIFLGcl4qUeBx2Hqzh4ror4QuLiHNTpLZNXFuY6cym48BUonQF7U6KeJzEL1d
 pjd4VSuhrFc90eMJcXhIVj0prB9Kb/PFMUs5w6rf3ueH8FPCJFAf1yys1+8BUteCew3WzpI3E
 yz6Ls7A4kUasdKqxaG5D2/N+xR5QYAEMThOK8+5R+Wg10yn/Tf3cB47THAbwPBvnhvSWjjWHP
 0jU6HnxJsSEmyXGLY4iT6WojbH+OzcNcaj3xKHcPdPhrkc9G2brw52VB94aQITszrpA7BAnBZ
 nvmERQRBvNlrxDHkNR6lH4JY2H+l/6ia9clz1Prl8cF5KBhIOQSBbbGay1MFbljJF6PuKdNPw
 URnhLToFelCF4s9xC4YSquaTy01LS27zCzmIMNTGGkQN0/KH6vz6fZoxYnW0AzW2wNjj2pDn+
 GoAmyBq8xPh1WK57KOg1427GwZxz7Ax0FaU/VSLQNozt0FMNyM27TLT9Laet8YbdTouk6ldDD
 nCIJ8BAZJRrdNw1gCb1YAAgBwrHekqgauIdRLnDd3cRsuR36G7A3qz6NvS1IBnpikjfSaIXb3
 9uidVN90MPI3Ylbx20FuY6D7d9er6MPx+nDD6wGP50qnrqh5OxsoxOf0H



=E5=9C=A8 2024/11/15 01:52, Mark Harmstone =E5=86=99=E9=81=93:
> The Private2 #ifdefs in ctree.h for pages are no longer used, as of
> commit d71b53c3cb0a. Remove them, and update the comment to be about fol=
ios.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

This is going to cause conflicts with the patch migrating private2 to
owner2:

https://lore.kernel.org/linux-btrfs/20241002040111.1023018-5-willy@infrade=
ad.org/

And that patch also removes the page opeartions.

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 317a3712270f..60c205ac5278 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -744,14 +744,11 @@ const char *btrfs_super_csum_driver(u16 csum_type)=
;
>   size_t __attribute_const__ btrfs_get_num_csums(void);
>
>   /*
> - * We use page status Private2 to indicate there is an ordered extent w=
ith
> + * We use folio status private_2 to indicate there is an ordered extent=
 with
>    * unfinished IO.
>    *
> - * Rename the Private2 accessors to Ordered, to improve readability.
> + * Rename the private_2 accessors to ordered, to improve readability.
>    */
> -#define PageOrdered(page)		PagePrivate2(page)
> -#define SetPageOrdered(page)		SetPagePrivate2(page)
> -#define ClearPageOrdered(page)		ClearPagePrivate2(page)
>   #define folio_test_ordered(folio)	folio_test_private_2(folio)
>   #define folio_set_ordered(folio)	folio_set_private_2(folio)
>   #define folio_clear_ordered(folio)	folio_clear_private_2(folio)


