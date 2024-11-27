Return-Path: <linux-btrfs+bounces-9927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6F9DA118
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 04:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD2C284978
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 03:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A8C7581A;
	Wed, 27 Nov 2024 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lzWe1ThW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8E42A9D
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677466; cv=none; b=evzKBuH6wW4wOkQVOJCWyos/xoJaheShBe7uaSUvv8BQTKKuVyyImEF/Q7muS+HTTDpEfLBPUrUErtVQzJnXCHBqP6afSZ81wM3TThhDzWx448WMYwa+PwLApU+DnQxDeIqpA7W+NqbMIj4VJGXi93CLYIC+HK2qb+pFpMA8uJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677466; c=relaxed/simple;
	bh=zrZgPvYQEKiH5QglYSrI9+JznS13AL1fNgnaU2YaeEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGl5TCv8z+40OB7/upgKyW1e40bSBs0fOld0OAogsciGK+Wc6wJ5pM/nO4j+7BINLdE80fvFJONUGJxqtFaaHnJAjbBAlCgWz26r4L5Sp+wPnYLH+X/+zT7Yd8Ko3kAU9gcpO6Q8h9i3WS4cjz2UGbpQZ0lHH43jiyZFUBoSLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lzWe1ThW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732677461; x=1733282261; i=quwenruo.btrfs@gmx.com;
	bh=Bwp7DWIwggxJ68ZUwPh6ofJMesTgF8tWClUhlNLRjh0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lzWe1ThWSImtQGaLeJlOuRgxFpLqyF3sj2zOtr2Q8MuHzMtCRRBbKC0PxbtcNpqT
	 MA6HQrgzQ5bei4Avjepb5APdTnUyNEdEOiVmyHgG2MF8+KnJoyCi3XXM334QPJTmF
	 Pc8XWT6VFoKTTIIW5zUeKmRHH83q0jBtTbIZbPFiNQHt1sL8UVkcUkNV6YNsstvaG
	 GrLRpbJQyxTjuVQQ/M3QrXSh9TxWFQKj+69oyYwpL/bFAdyQvfs7Jgsiw7KFfMQm4
	 S4Z4WHpV9rkOTTlZdr+L0djkk+qjGSByCNTmrad09FIES3UppcJFQt0p6rF9sdGeV
	 tErMX8z9m7mcFqwWsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mbir8-1tpjUh085u-00iP1f; Wed, 27
 Nov 2024 04:17:41 +0100
Message-ID: <cfc9177b-ab53-40c2-b627-0045e9348938@gmx.com>
Date: Wed, 27 Nov 2024 13:47:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
To: Brett Dikeman <brett.dikeman@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
 <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
 <CAFiC_bzov3zete3VabFQQMQ3rUS-TdHikNqRMUW_xggFmrtoNw@mail.gmail.com>
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
In-Reply-To: <CAFiC_bzov3zete3VabFQQMQ3rUS-TdHikNqRMUW_xggFmrtoNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tP7ELbxK8YaJjDbV76f0dxaxrrX6ATRowglUWsMn6eYfSqrxgWE
 hjS3TIWiKYQWngFYao0/YZ8SrV4+6u+XZQ0KVzJFOgT3j8Pqzcfle8EPn4+LTmEqRfxmNPR
 pbSC48iP5UXPkoRC++8kOWX8WpS15AWuNY/3dfTz4RNUYysaI1iLvvavDxodRS2cyoIl5oq
 i9FPdIrKzSSx+Wflmfb2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kwQPRVhxDYI=;ENtGxTjwGVUxmivtVA7AEIjD87C
 D3uBRMMaoC5CxSSZyhTPZIHqD1mK0FiQIM6cAdPbUv02suvJDM+mDU9vleMXq4AWzta+mLQdA
 mgOBj1F7YyQt6wArQqVmMJw8Az4zjgy9U2ZmcJUMN92FcvUEqqFcIIXymyvvOrFYFTJP/jUkx
 +GLfbUKUd+c93LGsHQh5IYuHZXZc30zgNrHcoSRzHQhjFG2LWGUR4wqbTLS+wmRgA+vjVaLbP
 dWHrcZkNIeVdwOIs1ik13AEHNhbspRea92VnJtmUoNTkEkJ2g/CsaTkzEU+qa2+nw5Ttbulr8
 rJ1BHW3Gx1FeZSkuy/VI3VeWmfolorBajQlzmAcPkTix5naL6TqAjPkJyxz7m5Qq3TehC0jb2
 tmyslOXIizrQPQNuL8OE8PuQ4c8LU8BAoZlEJCvnk2nxRXhSOvRp+gw6Tlqb8ZPw2f9DFKsyp
 gAh1swg+RoXT6Pt4Z7rR0yM8u0BZT0t9KLmj9VjscRp5PnTLPy0cbw/D0kuOZE/SXIV7Pawkq
 9bXic2aV9Zl67mntJ3MYoZODcxdItY08q9hDM5Afpwqr1+eZ4WFF3bHickP/+phkPNLWa/k6Z
 8tYwKX3TGIdenNeiSQfcXS8ctvF0SrHVPTYw6A1epJufj5VapW2KcWPmNaDPSPn5dAaFb3XQW
 PrMJiiNSdPi+MvzcIbCmM8Kv4Kkx42xmLtirWarPOyWXe8BTpP2M9gvYs8v5Ic5Sb/dOiWEoO
 bBR6QMkGei5WG6tkq6Z7lrcQJQbmYdYqXBjdBHxHoShyGjs1ucYGyukmhvhJpJf6rpcJ+JGov
 NBLLn12IpGNcuXYms6q12kmJGL5jekZriwWJh7dQLXf/F7sUfUIW5b5Mv/tJClNIG9stOp3ar
 smW98Iorvqx2Pa/7/wJQoVVdmljw5U6G4qqvprJR+9BXsc9ECng+NH9Y8



=E5=9C=A8 2024/11/27 09:39, Brett Dikeman =E5=86=99=E9=81=93:
> On Tue, Nov 26, 2024 at 4:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>
>> Inode cache is what you need to clear.
>
> Brilliant! Thank you, Qu. It did mount cleanly. Shame Debian's
> toolchain is so out-of-date. I pinged the maintainer asking if they
> could pull 6.11.
>
> Is there anything I could have done that would have caused the
> corrupted inode cache?

It's not corrupted, but us deprecating that feature quite some time ago.
And then a recently enhanced sanity check just treat such long
deprecated feature as an error, thus rejecting those tree blocks.

>
> 'btrfs check' thought the second drive was busy after unmounting, but
> a reboot cured that.
>
> check found the following; Is the fix for this to clear the free space c=
ache?

I'd recommend to go v2 cache directly.

You may not want to hear, but we're going to deprecate v1 cache too.

V2 cache has way better crash handling, I have not yet seen a corrupted
v2 cache yet.

Thanks,
Qu
>
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space cache
> block group 6471811072 has wrong amount of free space, free space
> cache has 42901504 block group has 43040768
> failed to load free space cache for block group 6471811072
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 1504346918912 bytes used, no error found
> total csum bytes: 1466184264
> total tree bytes: 2501361664
> total fs tree bytes: 718209024
> total extent tree bytes: 106008576
> btree space waste bytes: 375584870
> file data blocks allocated: 1512284389376
>   referenced 1380845105152


