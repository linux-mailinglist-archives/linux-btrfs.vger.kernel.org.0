Return-Path: <linux-btrfs+bounces-16915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A82B83133
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 08:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1A21893859
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D727B4F7;
	Thu, 18 Sep 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lGzsQ3+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8B26AE4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175379; cv=none; b=NDGbFgW5UmG/MO9V11jW3wruDNJiGboikxv8LKW6Tc45W8o5N/KN3IPMs28G/59/Sd79/b1VtqVmm64klYLRoLJaT0vXzxsUFCMAzFukU5uK97yeu/W4ehXc3hVjHZB4CBJ3N02YAHefkzExzBjFV+A9++TnrkAyWOaNhTotr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175379; c=relaxed/simple;
	bh=Xl5nEcgCbvbLJp+oLRXOq6/Qy5Rn04qnP0HN+Dax2AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9zt8bCMJR1l8zlnpWep9N+Q3E5QJhJ4Dv/aU3Znox21iw5zj3ghFqXiBn/c/ECWsQY2inskzuZVX6J9HAHqY702ARQt0+5COTk/QKfYd/RDsFvqjvil0N5piy1+HInP1b0gDSRC2TYFlPuM1NhyKYR9O4Vj2YU12XJYRL85tdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lGzsQ3+e; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758175374; x=1758780174; i=quwenruo.btrfs@gmx.com;
	bh=uanZpZ8GivCLb4/Lj6H3LtN7qAj2T2Cny6IWAlARhxE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lGzsQ3+ePcVV1WbGeT4xAdMbGvC5J8Cxn369c35uk3a52mPhDZUdWvKFv/URnNgQ
	 Qd/gUuv/kcmEKjdRPYWhIK0b2rKdbqMghcPSZ5ioEQV4xX5vG3Hd05HdQuuv0DW94
	 V3idM3SCxRARhrigT1qgyusHmqX6Cv71MmEgz4CvVO7Q8U2kCgh1mHTk97AcXReZq
	 ZHToq++Zc/LiICutaNB/Ihu+5mmxCy0KO0EALaOg0KyRGxNIezaqGytgpIruoxnRc
	 Jj5ZzfxQHRvDOS0J/RpIM6S7O2Gkl6iW0p793MIQV8Jzlm4uEM0k6A/UwbhvMGBXm
	 EE6S7PfMgFLGdvdPVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1uDEPT22is-00s7jn; Thu, 18
 Sep 2025 08:02:54 +0200
Message-ID: <06193e9e-213a-4cac-8649-4da2c7e54e48@gmx.com>
Date: Thu, 18 Sep 2025 15:32:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject invalid compression level
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <3aa4ab3069efeb71fa0197430e91df74139ebfa3.1756117561.git.wqu@suse.com>
 <20250918030131.GI5333@twin.jikos.cz>
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
In-Reply-To: <20250918030131.GI5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fg5qew0TJB2Un3sKltkQz8UNdgj1rUnmkcgMXp85H6OCUkuBMtD
 qIX3LYMGH9D4aopQF1wOYoo74dtkDTpyO3fCJIeLBp0HEqvwYX4fcmjq4u9+3WycJdIZPBF
 S2uognw8+U1+oZTC4bHMDkcb2JBXZsLpoemmHFzFPP0eFwUuIpipcM+lrd+MClilrmbSS9z
 vb97raqMN/CHsikG+sJYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gp9bxanvXyM=;Nzy1ACmtDVgIVva/oQL2ZfQhAxb
 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



=E5=9C=A8 2025/9/18 12:31, David Sterba =E5=86=99=E9=81=93:
> On Mon, Aug 25, 2025 at 07:56:26PM +0930, Qu Wenruo wrote:
>> Inspired by recent changes to compression level parsing by Calvin Owens=
,
>> it turns out that we do not do any extra validation for compression
>> level, thus allowing things like "compress=3Dlzo:invalid" to be accepte=
d
>> without extra warning or whatever.
>>
>> Although we accept levels that are beyond the supported algorithm
>> ranges, accepting completely invalid levels are beyond sanity.
>>
>> Fix the too loose checks for compression level, by doing proper error
>> handling of kstrtoint(), so that we will reject not only too large
>> values (beyond int range) but also completely insane levels like
>> "lzo:invalid".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>
>=20
>> +	btrfs_err(NULL, "failed to parse compression option '%s': %d", string=
, ret);
>=20
> I don't see how printing the %d/ret improves the error message, there
> will be probably ERANGE or EINVAL.
>=20

Pushed with that ret part dropped.

Thanks,
Qu

