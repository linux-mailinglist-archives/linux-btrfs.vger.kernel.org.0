Return-Path: <linux-btrfs+bounces-17212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26949BA2F72
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0AA188601B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A6296BC5;
	Fri, 26 Sep 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qvmxCsLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA53286D46;
	Fri, 26 Sep 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875711; cv=none; b=T3u+Q5cRQ++P2sGE1MUyjJus8bI83af+OQDCGkV8bjV2pKQOBd1EG+1C/jofa9KSSi1rHMH1M6wQK7jjGhbPmzCPE5VWaWL5Rs7PlkaEf3sV9h1RQGE+V7B/B4sKGbd8E9QvO0dJ3dRBOD6ofL5M/Svry4/5k4LZ6T6QHK+K6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875711; c=relaxed/simple;
	bh=K54KxtEqobUL10dLx7RmBWdq+aX2Vbg/1SQzKWv93aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFnXsOmjBguF1uD2c+FymkmNS1WFldlCvSTCrxkyhLY97wbKelAfB634xylZcEEoBc0QUgpsfwmJ/awno/if8XrP4LvfDk2BfKj2rDpC4jeLcD3NwIt+FSHyeAG1bHcYJhR1digpklD8cFZnaaDeFdsaBo5/lLt4KAsVfHpTB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qvmxCsLs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758875705; x=1759480505; i=quwenruo.btrfs@gmx.com;
	bh=lWVLB3EBYo7j38YIbftYov/VcLAJAGQpDLPBh/ngJqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qvmxCsLsZ1RScz32865hPhlTprrfJx477syLm6A5K4oTyRwkpSHzsPchUJTC2o4q
	 gDVBleaWd8dFTJF1tRVOQlyfdxMCLDJT08x80IGhUs8FPfTmCP3WDRQF8BAxKTMGh
	 Y7Xqk4Px6UvtmOYSX07iC+Uwml29K37ay0A78DAX+4OXCfkuhqGyK0ib2vCuASvQy
	 vvzxvlE7w2droaLhpfqXYcVsMBQZHYG4YmlWHG7VnXs+wJSjyPr94l1Y+29OeoQ9u
	 NIskegisvJnI5tO9VCuO+N7gPbZeNRzZBrJe63vOLAE2WVWgoZBkAf7VcMvOLAMhj
	 aUDLrstRrRJOrk6CUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1uHxb62Fia-0170eG; Fri, 26
 Sep 2025 10:35:05 +0200
Message-ID: <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
Date: Fri, 26 Sep 2025 18:04:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
To: Youling Tang <youling.tang@linux.dev>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250926074543.585249-1-youling.tang@linux.dev>
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
In-Reply-To: <20250926074543.585249-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTj4Ag+W6s99OBnQy/v03cijjq0Eh3n0ek2p1tRSQ85TO82/db3
 tnFuWIv4ocsp16AlDOWQkH4krdV5ZJULb8cX+Y0opKOkZr/e08rfU8ZA+j78zMxqxnwKTU7
 MvK+uHbEpHHDD9LF00zYwiRQoIaim823LX8AHZ0ZOXgujY+vupINrYWgDZ4PHjxo04ykg+C
 Af7g3IcbIgZeiDNHEX76A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LQ+3pE2eAXE=;FQRkmwu753BREr2U4X0VoYoa3tw
 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
 OcapsFF4t7xHOA==



=E5=9C=A8 2025/9/26 17:15, Youling Tang =E5=86=99=E9=81=93:
> From: Youling Tang <tangyouling@kylinos.cn>
>=20
> When I created a directory, I found that its hard link count was
> 1 (unlike other file system phenomena, including the "." directory,
> which defaults to an initial count of 2).
>=20
> By analyzing the code, it is found that the nlink of the directory
> in btrfs has always been kept at 1, which is a deliberate design.
>=20
> Adding its comments can prevent it from being mistakenly regarded
> as a BUG.
>=20
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   include/uapi/linux/btrfs_tree.h | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index fc29d273845d..b4f7da90fd0e 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -876,6 +876,7 @@ struct btrfs_inode_item {
>   	__le64 size;
>   	__le64 nbytes;
>   	__le64 block_group;
> +	/* nlink in directories is fixed at 1 */

nlink of what?

Shouldn't be "nlink of directories" or "nlink of directory inodes"?


There are better location like=20
btrfs-progs/Documentation/dev/On-disk-format.rst for this.

And you're only adding one single comment for a single member?
Even this is a different behavior compared to other fses, why not=20
explain what the impact of the change?


If you really want to add proper comments, spend more time and effort=20
like commit 9c6b1c4de1c6 ("btrfs: document device locking") to do it=20
correctly.

Thanks,
Qu

>   	__le32 nlink;
>   	__le32 uid;
>   	__le32 gid;


