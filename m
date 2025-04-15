Return-Path: <linux-btrfs+bounces-13029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE33A896FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E2C189DE3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6D27466A;
	Tue, 15 Apr 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jAFl6HjY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4D27E1D5;
	Tue, 15 Apr 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706611; cv=none; b=MDIdchwBsLUDxl9lHP4xq7eZAQyhrwFDz7Dm4OVyBboaF2U30rxH5SKmro5B+id3V2NNQni326fI7KvlvHfLEe/uJOK6L97lQZN5saNDYQrVY5OcPfUNAIingJZEnAUPT7uz+qy76CoiTig0HziRvAXACLdAiUjOhTXYw32J1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706611; c=relaxed/simple;
	bh=lBX4AYtJyqzdVQmpzdfXQ4V1LhGQ+xqARXbj4c6l2Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugItz17M4wU8DEzfdjjsbhX9kUTWNqhxI+19kfhxywE3QAcI34sbmjpcZuuv8ZWj5qAWF68WHxUs5geefzr2Gcog/7naTpdu5p3i/9YDaH9z7DHKSQDl4LjHkYrsN1FELAFeVp2DAd/2dsihj7gZDayl4YwQLMVRpjTo4APwIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jAFl6HjY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744706601; x=1745311401; i=quwenruo.btrfs@gmx.com;
	bh=pN7q+oHOfO4wSGoqH92rN+7td71JaT3iZ7QcKGWuW/s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jAFl6HjYB1kwxqMFv20Qu9Tbn8lEQ3/P29YW4/ySVobc8Lx+rLI1hFsC04/IgeL/
	 Rq0EZGYw6p/3zP6ywK4sdr2Hm69XOdVYTKeuprZe34EV7Jj9IaMNo1hj5lErfOqjN
	 y8ZfLVL8eq2+AA+x9Rbu/B2kh97CO0j1nGEtxkNwaTLkdNv8lOOF7zNx9MR0W6ofG
	 ZQQ+zaHR8Tn+hEdbs7ktlE9vNoboAw7hVL/IEzZEyteEZPyAdCQUYSy4Diir6s7od
	 SLlMUl7FFOBXBpN2J++5nK2NSH9Zp/BsXJSgXEQRLL6sEvr2dKs+SBg7Dzr8NbLXw
	 zzTIvng4WM1j4FcCXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1twsei2Rum-0058dM; Tue, 15
 Apr 2025 10:43:21 +0200
Message-ID: <472ae717-5494-44ae-973a-85249a65d289@gmx.com>
Date: Tue, 15 Apr 2025 18:13:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415083808.893050-1-frank.li@vivo.com>
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
In-Reply-To: <20250415083808.893050-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/VhVOQYOWeBNRSa1wm4vWRlrzI+grHxxwKcm0dZT3TJEeRsIg8b
 ckFcqYrIVz4VGnizrMRiF0nkWPjf0HRvTEtkbEA0Y4PBTDvDqKCUfntve3Q58IWC9t0ZdfK
 emTw7VszL7g7LXc1KjkfQ8RDdMXu+bCubWhF+WT7UwYLITfpov/3Nd8SVBwnL0Ydc/E0vl+
 BBDaCokFB6y3BlYLZpGDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q6lzJs80GsM=;JVUC5XH4KPwsHUT/W2IopiYhAuK
 yxVx5lX/ue0B1nTRMi9YQlOFqQA6mHRM4f9JtgrQ8vzR3p8qnA8+Apaw57wGtJGqLxx6dvM5h
 tlJQT5hyOqVk3w+bd7jl1v6EM60kPXzL+0SBGuq+eJPrJtgZ//lY/nfpF0ckIJGfP6DEJI8ud
 7OQ3IqZaNaNEH5f1rjgDHj9TEL5+TzABwwxrUHcL79RYadJNkwYzICDesbVvKCbAdpHvrQhuf
 hy8CN3HN0pzPST3en+bsp57hec0SeQSSUdVUQrH+5PQyPwXyaV20O7AEPpy2QEeAiPhJxYoe0
 dT9c4qthcShE/fOs7SSAnvD7LH7mQeyT95LrqXfzDSu7xA3xnTCIgeMFDzlDOt9HRi9YZPBcP
 UINKLll2DEUL0ku1v2VpvagTdNUtA9NGfYco3CV09lvewYn8wrKBtPIPoPRB+ebIMbAIfwSjO
 QT5y338jMuY0ZpLHyh/gSXJK/hJ7Kz9MgBu06ZUgdsHp8OdTK3zmt68mDHYbPGM68N4YJJN4C
 e8bLsQl+KBAYCPmtV5CN+tBZHQDhb3CC3TsfJ/dYu9apRckj6j5kSwpLOvjLsv1ppFP6M232z
 5ouBP0u2UxvaixHW2E+7bkfe+jgH0v4N4fDgvwKOhXT8XnlKMcuu/25XnVk1oeggKAPvXvnmu
 5OZo+YoGzsMYsM3FXMsdBJ11WLyhjRw03aUSdl7pPhkBAkhnq6i8V9+MtGQTGOHVXEBai+zKs
 HdgfBKX2dg9U2DKJktf+mOvGrO0yvjvRQIIfxRCKsYB1jsifnqppbsn0g+43UQqbwy/EpeUG/
 3yYnfS9ZNV3a9wExCzMWZk7bdzQC2PEcl0wuPrUVIhjdpkYCTTCRSuxEK4g1Fq6dLzDbkboJB
 qO9D4C6GgeyOdbNPXH7fGnDZb9asJoxuOzX5eA9mwFwXXmHPFUJTReDjpYK+2WlyZLzGOw7ER
 jZFX2PRHvdSwwIvoJLc7eQMKgBqGYdSQFqoHh6rDE1EtgREt1wZDkJ/qn6PuoWG4Ac0PF7pet
 7lAC9pa1a2WqLiC96ecWOxLn8dBxHnP41yG0g4nzlAvA26SCUDjya9KxUELNd9k8bzVjH9cad
 3d6qy00lNCQ5JRrXRnR2z348oWq3mMInKsqZSf0KmJplFN2dqL9VZZ7WPbM7wqZAQpfQnjSop
 32rBP3HteSUx0g1I+UT2Ba6AWQHju+2XfCJnduwo4mebYn3R05K9RxEzJtnPF0CBgv+ATNCxh
 4C8D8dsPcX2eT55kL70Iae7YJnKOd0k1mcPVO5a4aTS/C8Wj+qKD0jy8ogbNOphDbsuqvmOAA
 WtBN1+pP36DUL+2mjWVjwC7XXVST0vRaNZtZUhubbGXeXOLMbKSQ3cir0uPT7pNur8Ys1ZlQx
 8rlkyaBTT4hKcOOzVSRYVUMIgql0Zi/OQmPbm6MTABRbdKdTjbL/yhId6yIe/VseB4H0XGkMe
 AZ+o98w==



=E5=9C=A8 2025/4/15 18:08, Yangtao Li =E5=86=99=E9=81=93:
> It seems that it has never been used, so remove it.

History please.

>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/btrfs/delayed-ref.h | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index f5ae880308d3..78cc23837610 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -262,7 +262,6 @@ enum btrfs_ref_type {
>   	BTRFS_REF_NOT_SET,
>   	BTRFS_REF_DATA,
>   	BTRFS_REF_METADATA,
> -	BTRFS_REF_LAST,

The _LAST or _NR suffix can be utilized to do sanity checks, and this is=
=20
not part of the on-disk format.

And if this exposed by some automatic tools, please also mention it.

>   } __packed;
>  =20
>   struct btrfs_ref {


