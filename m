Return-Path: <linux-btrfs+bounces-11733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC670A4171E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B24D173560
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C3158558;
	Mon, 24 Feb 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="M3n/wK3S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13311FDA;
	Mon, 24 Feb 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385123; cv=none; b=WN3/GSf88ySUEtZQirdEWLrK+jO6UVxNCIRrEA7qs6YHFwtq+cVBjrmAqJA+wctrx2WJE0vuLkBtQoqfLOpeETycFTPSNPTnPF/6J3l9Z1udrpXaavnexATaPLdbqPWAYGSNbpnOrnJyJP3fJGCBTJHTRTt3BrgYF6SbzzKPezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385123; c=relaxed/simple;
	bh=W5lZdY14/HdzaoveUbN230UTomBrJvRsRjGOsNuyHy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvfenV19S8o9hQe/IhZeidfkFBjxE7ZYtyKMEXtpUQ3fEdwEJPrea1Hg0VIwlSeJhTT16Kz+cZVZWOaz7b1PK2lOdECXcgoDEEyyf4bSkGtzhC1nz9jBnPsv+oSw0KJ5LVkgc5TvHNwIpj/s4LpmYJumehn+BEmew6fw+xwcl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=M3n/wK3S; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740385105; x=1740989905; i=quwenruo.btrfs@gmx.com;
	bh=n8wsHkddx/G85nADsnXvMHHb2TKzYYRjQ+Xo0MY2eog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M3n/wK3SY3qPduvWW06cPc3yA2btZecXk0nv+oXfOl9GPEh6IDvU7V/RpaB6sod9
	 a4q1+82Vu58chQel4QduXy8eAm29grPmkkQ4QSFom26bwnXAPIp434Sdjs/QvFpqH
	 N95ZpbyxZclON1m9/6WMYZG+MlRybWgXBbFkjCYMZRgzwXaAuqXp103c5CWKJsgGy
	 Km9a3woaI57pazfuQlwuO8465oRqDGp82Ji0Y+adBoRmpWxCYnceu5NOlp/F4TUGv
	 eE8RJpuHTAccGKOI+AwMZJT8qBg+EOO6FEDyIdgGj2QkDLdkR5WCiNC42jepZ46lS
	 DeokN/ZWotPOiBqrJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1tL9j23pDA-00wNxZ; Mon, 24
 Feb 2025 09:18:25 +0100
Message-ID: <0d9f6477-04c2-486a-ae72-c39b6d235891@gmx.com>
Date: Mon, 24 Feb 2025 18:48:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root in
 btrfs_next_old_leaf()
To: Ma Ke <make24@iscas.ac.cn>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250224075937.2959546-1-make24@iscas.ac.cn>
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
In-Reply-To: <20250224075937.2959546-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PE6r0G1K6qU4wJar4LD1jU1ER4JaCInrue1/qb0cbVnsagj/iFY
 6woJyHQk1dOH4zffCuDBS7eD7qoRmQl7nT2/50SYwHhgZfyhLfbPqiTMtOqNqs/SNQ/9PnD
 ydAAhtOE5VcBjW4/cbqirVPhebCKrKzaN2XofhuujhP8NQtY0A3e2O5Cua3cnGBGfV26Hfq
 /q51PIoc/lSP+CXuz2/0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GAhmzB0pPUA=;vUgeJlxxGCkvO5gBYy85DDBaJTQ
 7P0CUZ+gorunJwd8rAdFDl/tekrrsz1T0Vhe6PpT7Ez79WPAt2KfbCYIOA7PmqettlTdNVhCD
 hAhx2fAinDExuRT7PAVWyoSZNxHy9PDHcc3jgllZzUih6j6onCHpKxysFG/axc8jVqGTRgiH0
 mZRJIHtG7ue4uaPW/CDYebeMthwqzHBNRKgGFYO2w3eyPcQuqPJTGm38mTNTIjO+jmRBlworn
 CfXSCXXhxp4kIJXUhP0JuBoho41Zd3hNTxvtx/kQdFHPrp1kJ63CkHtLAnOj7d/pR24TsXkUa
 DZB8q3EqHPMW9bW9Fcd/79YpIGIGeF8Z67L05qMB9Kdlr5IqnMpCspQ27iPnT6x0ZSONqXsAX
 wuo9KfB0ue+VqPnnULNbojXImfhOT3XpzbwbRGhDeE1yZcYtcBQOS1h7zz6EyKETXAOYZxfIG
 T7/TFE939WgCEoghvSLDSed4HQMWYkzP2Q7hLATOgymtOT2x5vQ1wlUrbQ14i+WYetcf3I/Ez
 XHZW9D2V0hFjGQ0i/uHV4AsV9jTydFTZDPP/6GMhbS2VXJRjMhMy841cSqFqcES7uL2UmQIpz
 lPj4lctXydjHgRP1iLVpKI3XNMyBNcSR8GuuiK0Zy/UaolLbbKIMGhxjRVpB4l+tsQDeUvQyD
 BaHNo2IHQZql7njxKw5S7tA1qX3gLVufBTqA2/K8ou//gNRX4fVZ1mXzFXZuNt+mu2LXUQdmf
 Fce++k9jAdkCIVIhP4cxZn9q25eyQLtXHjiXc/YInMrmfv57yQO9FApD6peDD27cgqsiZCcRs
 2iazjF+08WU9ySMWnXf/caPIJCzGMtH03e1WEHbHF6K0bWsZVsZ0jCvNfyL+CJ02rCHui8JbG
 jmu9neEmvN5KKY9Q7bn+PL4iTfkNuUsHraCMLVhV1+X4rGWSHF/3sfAMgWY3W5tkqMkdwytPw
 C7lbJOGsWomrygtCQ5rhA7c8yAbGp/jrimLCEwAvrtHMUjlo/kYIhx04xXHehw3BFB2+Rr6/c
 YU+KQX15X7QB68s9eotR5XMS9eouSlYNIPWParCrXLheGr8PgYEuqnj9nQODkwwfr4SHZCJmk
 3av/IEGguL11hjdohkmY9RrsTMJB0qZFY/ONd8zlJZlP/2SFPyB8JcuF18xRrop3sR94b5iLI
 ruqcthCuudI+VntbuaQpJrT5MIBM46riWiKOfuX22q2zPilrGvLOJOSvzE10EWigNwhvZdfN6
 G993CPJJK3PzLgagAMOKxX2FNeumbi54s4B7V8pmUaYq/v+LgTOfarbeE7BSA8rBAq1t8NQsm
 HZmAUpGM4EnekfJju9uFT2eaNpisbs3daQu3T37XvhEbCCL/M1fkFXwwq7OuELdpbSPVAxsNm
 Lmv4fx5vQfmhMkq8MS8Lgq0XSazxN/n4UpyPfkzmsD/wTGZr53UA1WoHA1



=E5=9C=A8 2025/2/24 18:29, Ma Ke =E5=86=99=E9=81=93:
> btrfs_next_old_leaf() doesn't check if the target root is NULL or not,
> resulting the null-ptr-deref. Add sanity check for btrfs root before
> using it in btrfs_next_old_leaf().

Please provide a real world call trace when this is triggered.

There is a prerequisite, the extent tree can only be NULL if
rescue=3Dibadroots is provided and the extent root is corrupted.

And "rescue=3D" mount options can only be specified for a fully read-only
fs (no internal log replay or any other thing to write even a bit into
the fs).

Previously read-only scrub can still be triggered on such fs, but
6aecd91a5c5b ("btrfs: avoid NULL pointer dereference if no valid extent
tree") fixed that.

And if you hit such a case in real world, please provide the call trace
so that we know we're not missing some critical situations that extent
tree is accessed for read-only operations.

Thanks,
Qu

>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: d96b34248c2f ("btrfs: make send work with concurrent block group =
relocation")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   fs/btrfs/ctree.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4e2e1c38d33a..1a3fc3863860 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4794,13 +4794,17 @@ int btrfs_next_old_leaf(struct btrfs_root *root,=
 struct btrfs_path *path,
>   	int level;
>   	struct extent_buffer *c;
>   	struct extent_buffer *next;
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_fs_info *fs_info;
>   	struct btrfs_key key;
>   	bool need_commit_sem =3D false;
>   	u32 nritems;
>   	int ret;
>   	int i;
>
> +	if (!root)
> +		return -EINVAL;
> +
> +	fs_info =3D root->fs_info;
>   	/*
>   	 * The nowait semantics are used only for write paths, where we don't
>   	 * use the tree mod log and sequence numbers.


