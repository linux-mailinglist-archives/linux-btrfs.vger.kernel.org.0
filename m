Return-Path: <linux-btrfs+bounces-20003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDFCDE185
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 21:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B73300BBAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFDA291C1F;
	Thu, 25 Dec 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jH4HaYJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24272289E17;
	Thu, 25 Dec 2025 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766695795; cv=none; b=h1EwT2ARKBw9XUFFyi2Cfn5uUGxeRA5ok88jya9p329nZiLSkRl2mGxnZi5qOINIZLnzG8iqxu7a8lhhOCNskUxtZYr2CPHpya6azmNa3Bw2UCT2OYWsLrw///spFFvGh9N4f/FCaxC5EgHDTfzxDahyGt6V94VJyPSZ1BJxdTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766695795; c=relaxed/simple;
	bh=Fbmst4588JxxaUcSK7GdQ6n5iyZHDK1y+dnxetVfHdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr6l3sUhh8K0LsKV8ad6gRHZcYWs+Y9RaGmzTGp7J3o3ptaRO2eV7vMNcMTH0ZnNQy8BJ2A8E1ScjeKK7X35nx84dsWb/qonMFt6sDY8XsabSqGZzpA2Yyoba2zbhB8VBDMGNL7Ixy4LuaWL7ARI5ufBoGW6sGM9jmiypG7pHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jH4HaYJ8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766695791; x=1767300591; i=quwenruo.btrfs@gmx.com;
	bh=H8DNmthdVWgSa/ohcDsNCZbYtFfuPq05LCbN+07RNAo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jH4HaYJ85jR+haIe8s6jQ1ndWy9fDr+PBhK8+VXLz0dJRCXBTf5jV7qpN6hs3AgO
	 eSdicQDju1vShOdTroEd9wRTwgfBGsLiYX3+rF9+DvIhKNVCMZ5DMCLLFj6MbugJP
	 GfctiZUFeb6D/Sw5LE/m7l5T78VIswn4LoqOwNEWIbxjho06i7ZMGR8tmemW8McfP
	 P0G8BLB78uKjyVK+BHzwjmOYDiDxLsH9vfI1PQqKTk/XPsiEb4pYQL+2Y8H8FcGq4
	 vn9KoZv6geZ+BgYUJXPQd4rV3KFFaqO0DQ89DkhsQNq62dqf9P7bOcUzh4U/8cM1T
	 yQLD/Zm2EG6S21K78g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1vlVai2Nj4-00FX7f; Thu, 25
 Dec 2025 21:49:51 +0100
Message-ID: <5ba227a9-034c-4e3e-964c-d13f8f3ec2b8@gmx.com>
Date: Fri, 26 Dec 2025 07:19:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
To: Zilin Guan <zilin@seu.edu.cn>, clm@fb.com
Cc: dsterba@suse.com, sunk67188@gmail.com, dan.carpenter@linaro.org,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20251225102727.967360-1-zilin@seu.edu.cn>
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
In-Reply-To: <20251225102727.967360-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KaR8++pf/13E322lfOO49sL61evPsVNYHTE6zDAp69GN8qNw1s9
 +pCm6oOVs+ILaPPoGRH+RlHEhP0D2J18SWfEugIhmWEOlDd7g89+RawmPmv4TPXT131/XVI
 CQr0VADEJXKK4TfCUbi9GUed7On2aj74I7WEdR30EBv5GT43OW4x730r6+AmK55EgaRSUp/
 RtzUpZY6F0YAUVHC6Mvcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:afeCE50+VYw=;jq0fIGjSl7mrGu68YvJqk4zc8fu
 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



=E5=9C=A8 2025/12/25 20:57, Zilin Guan =E5=86=99=E9=81=93:
> btrfs_alloc_dummy_root() allocates a root with a reference count of 1.
> Then btrfs_insert_fs_root() is used to insert the root into the fs_info.
> On success, it increments the reference count. On failure, it does not.
>=20
> Currently, if btrfs_insert_fs_root() fails, the error handling path
> jumps to the out label immediately without decrementing the reference
> count of tmp_root, leading to a memory leak.
>=20
> Fix this by calling btrfs_put_root() unconditionally after
> btrfs_insert_fs_root(). This correctly handles both cases: on success,
> it drops the local reference, leaving the root with the reference held
> by fs_info; on failure, it drops the sole reference, freeing the root.
>=20
> Fixes: 4785e24fa5d23 ("btrfs: don't take an extra root ref at allocation=
 time")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>   fs/btrfs/tests/qgroup-tests.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests=
.c
> index e9124605974b..0d51e0abaeac 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -517,11 +517,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesiz=
e)
>   	tmp_root->root_key.objectid =3D BTRFS_FS_TREE_OBJECTID;
>   	root->fs_info->fs_root =3D tmp_root;
>   	ret =3D btrfs_insert_fs_root(root->fs_info, tmp_root);
> +	btrfs_put_root(tmp_root);
>   	if (ret) {
>   		test_err("couldn't insert fs root %d", ret);
>   		goto out;

This will lead to double free.

If btrfs_insert_fs_root() failed, btrfs_put_root() will do the cleaning=20
and free the root.

Then btrfs_free_dummy_root() will call btrfs_put_root() again on the=20
root, cause use-after-free.

So your analyze is completely wrong.

Thanks,
Qu

>   	}
> -	btrfs_put_root(tmp_root);
>  =20
>   	tmp_root =3D btrfs_alloc_dummy_root(fs_info);
>   	if (IS_ERR(tmp_root)) {
> @@ -532,11 +532,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesiz=
e)
>  =20
>   	tmp_root->root_key.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
>   	ret =3D btrfs_insert_fs_root(root->fs_info, tmp_root);
> +	btrfs_put_root(tmp_root);
>   	if (ret) {
>   		test_err("couldn't insert fs root %d", ret);
>   		goto out;
>   	}
> -	btrfs_put_root(tmp_root);
>  =20
>   	test_msg("running qgroup tests");
>   	ret =3D test_no_shared_qgroup(root, sectorsize, nodesize);


