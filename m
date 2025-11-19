Return-Path: <linux-btrfs+bounces-19161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37806C71224
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 22:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 146FB350239
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115922ED873;
	Wed, 19 Nov 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tKyTez3u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4876296BBB
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587212; cv=none; b=rkcGnuXnhIf0Smlo6H02Co1iJBii4Do9ng3SRqbmNAYxqhki7Ktm3581PVmAJZ+IB5rZ0LjO2/pd2HnAtoXH7HdC6/TYuVt50EwQ6tcrQSslNCmJ6quYpNjyyNMiBm7PKyTcVN4+a7qNoqlb77XOMjojxfmofKC5XPEqmMV51yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587212; c=relaxed/simple;
	bh=yvQdlU+RALtFg087OfAp56SsPfvZVz7gCIZZ8nNe2zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QLyQAGe5hjj0ovXkSHuCdFCZKxNRb2pdS91zI9t3eBHot2sg93FBDcVGAHNEPfLCEsy5z2REoF/OcPleAQBG6wn7DHTY7RWrsuPnEUNOXA9aYVMz/8Oy/jhFDK3loovtwtYs+UoJXleNwflZg++ahIx9QOlf93Q52HTPVRv56GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tKyTez3u; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763587203; x=1764192003; i=quwenruo.btrfs@gmx.com;
	bh=C4JHoptEOeuB7iGihcwxxHtiDt9fkOnCF5TA2SHRgMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tKyTez3ufsuIRiYhyy50NSRutIEnZCgNjaCu2OgQQBzbuHJAMKbzth/7bnNTqzE/
	 4HRy/DgVoATcS2ysPfQE/jGCb/sBQvH98S9s7pjpb9Kr1StrOrhtvqpnapiCOrOcS
	 5Rj/jqx9oGn5NgGnVsq5yHd4XG1iH0OnJtGJaRU/esQi8E7RMpFO+Ki0Z9oVnFkXX
	 HOENKJyFT/lZi/zJCQ7dBOMgTYXG3pZMvmeHZl4U+KW9I6ZXC1olvyiIsJGb32Ubx
	 M2RtjT8rFHEeFUR1f78IJMMIozsRl0JKyxbrP5VH5zTMpz1oncpeehWCIBqCqleO7
	 4/nsCifN0I9oAEAdYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryTF-1vygb80g8T-00fUzn; Wed, 19
 Nov 2025 22:20:03 +0100
Message-ID: <c569ce6a-7430-40a7-b52f-1003852ccdc3@gmx.com>
Date: Thu, 20 Nov 2025 07:50:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use test_and_set_bit() in
 btrfs_delayed_delete_inode_ref()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
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
In-Reply-To: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oBJK0Y0/mFc6+wFbF0w0FfSWmyiYiCLVF+9vcuWoqBYo1ReZLaO
 2lPti7t1QQm28wWutQWzlpX96bE0rCnHbyr3Ph129PwLwUlQotBBwHn40QNFM8TokcSGoIE
 9HwW89aD4gl4JM7CzMfIgraB5JiFkv4pMExfEcGxsWo5tgseJoGKqD0vFpdm6/bT7XkMOOl
 VJZn2l/m4wZZS75qKbbAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MrnhpPGYb80=;4/wO0qC1PfOEMMsl0pYrtNI+vhj
 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
 PDxH3GnLs4ehkQDvYkRe94dColF9tlZJ7QyZXv



=E5=9C=A8 2025/11/19 23:12, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Instead of testing and setting the BTRFS_DELAYED_NODE_DEL_IREF bit in th=
e
> delayed node's flags, use test_and_set_bit() which makes the code shorte=
r
> without compromising readability and getting rid of the label and goto.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/delayed-inode.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index e77a597580c5..ce6e9f8812e0 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -2008,13 +2008,10 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_=
inode *inode)
>   	 *   It is very rare.
>   	 */
>   	mutex_lock(&delayed_node->mutex);
> -	if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
> -		goto release_node;
> -
> -	set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
> -	delayed_node->count++;
> -	atomic_inc(&fs_info->delayed_root->items);
> -release_node:
> +	if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flag=
s)) {
> +		delayed_node->count++;
> +		atomic_inc(&fs_info->delayed_root->items);
> +	}
>   	mutex_unlock(&delayed_node->mutex);
>   	btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>   	return 0;


