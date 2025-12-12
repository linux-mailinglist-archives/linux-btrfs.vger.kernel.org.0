Return-Path: <linux-btrfs+bounces-19687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96719CB8091
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F5E30552CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677322F49F0;
	Fri, 12 Dec 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SVg8Y8gN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1518C1F;
	Fri, 12 Dec 2025 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521279; cv=none; b=cXaaUR+wKCHi6f74X5pte2XxPv8ECSV03pb2Ne+6IMDz70cBdIJEyd0Ln74Hu/Rmk9y72MMzShs+QUBcfRAo3FI3I4cCzlsOyFS2l76KKGrHeTMwT1Lc2gDeidtjAl3i4RLfiW544IuTWcnl8c1h4h+fQvnfQvfEAZrPMCybogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521279; c=relaxed/simple;
	bh=n3/lX1sYugjwm8rIvUkvQ80oGbrdgKXlys1siN6rsUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PU6xAkPavEA4Wyx1J2wm7zfGHsVFf9DXEKt+e8/Lpl5U9DJx/FKFlsNBFEaWaHTn43NMKAIqfHZIvoHmA8uniBLMEmGTPRlHzZs/ltOZxnH0/nz5W72OMuaNhoplz/HF5veRpyIt0r1Ltg6Jvl01baAfT8+LVgHCtcfosMATRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SVg8Y8gN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765521275; x=1766126075; i=quwenruo.btrfs@gmx.com;
	bh=+73cvg+MJUHdK1siW/24y/fos6JSR4hXTeHTw+ZCmH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SVg8Y8gNkktIndVff91sTPVj+E7yPdZatf8HNbSZvn2XnsFRf+lBAsyZhaGvnNO3
	 UDj708Xbg1iLNFI4x0J8DN/wj+/FgkNdQ+rkKVq6cFpZ3uMSF2LLH9/ZbthNRSmok
	 /HaxSJpTusrjYwVLYqdYiH3kG+tnjaiim9Ndk38aPKU4UA5vrk1mkhHFPHVQs+4kd
	 rFocbAb26PG1rEeRTltDF8tOX0PCQI0Z8lW6b2hBwWpTxGzmgAjK1fdrw4psPrmRv
	 Tyo84+IaOWWfyewihDen0MQ9WlZiS43yoWjO/3NyFcvdo3E1tMF30QSlruu0vxtYa
	 7Fv7eWU7COc5pwTnMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1vyaeQ3cGm-00oSsf; Fri, 12
 Dec 2025 07:34:35 +0100
Message-ID: <1b5e66ff-9f50-44d3-89b5-2bb0322e7bf5@gmx.com>
Date: Fri, 12 Dec 2025 17:04:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix qgroup extent_changeset leak in page_mkwrite
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
References: <20251212050947.148242-2-eraykrdg1@gmail.com>
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
In-Reply-To: <20251212050947.148242-2-eraykrdg1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijYigvGcOV7Z+dLlBI9nKcMT+fepm/JIGYXarQtfJzvukSf4Pki
 nhYWsTin+m59Rf6/pG6yxZt17qohw4vujQ/ng9C8ygRjkhhjoFSycauJ0DCY8zp1/5swuWo
 4rGhXmc3L9cFWwC1134YgdNtsT8qy5yvuoiZg9zgq31il4P5cKd/zpEKAtYyOmj1F1YB6to
 ILEcZU1+G+G5UAchW0Q6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+zVcK9iy3Lc=;2cSYRAx3GQz3oeHsIoxblgrI+im
 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



=E5=9C=A8 2025/12/12 15:39, Ahmet Eray Karadag =E5=86=99=E9=81=93:
> syzbot reported a memory leak originating from ulist_prealloc()
> called from qgroup_reserve_data() in the btrfs_page_mkwrite()
> path. When btrfs_check_data_free_space() succeeds and
> btrfs_delalloc_reserve_metadata() later fails, we free the data
> reservation via btrfs_free_reserved_data_space(), but we never
> free the extent_changeset pointed to by data_reserved.
>=20
> Add the missing extent_changeset_free(data_reserved) in this
> error path, matching the other exit paths in btrfs_page_mkwrite()
> and the failure handling in btrfs_check_data_free_space().
>=20
> Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2f8aa76e6acc9fce6638
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>

Already fixed by this patch.

https://lore.kernel.org/linux-btrfs/ab2ab25d0598c04467a62e9e88c9131cec159c=
48.1765454225.git.fdmanana@suse.com/

And your fix doesn't even have a proper fixes: tag.

> ---
>   fs/btrfs/file.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7a501e73d880..4b05e72249e2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1910,6 +1910,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fau=
lt *vmf)
>   		if (!only_release_metadata)
>   			btrfs_free_reserved_data_space(inode, data_reserved,
>   						       page_start, reserved_space);
> +		extent_changeset_free(data_reserved);
> +		data_reserved =3D NULL;
>   		goto out_noreserve;
>   	}
>  =20


