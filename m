Return-Path: <linux-btrfs+bounces-20020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F119CDE7A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11607301B4BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B797314B6E;
	Fri, 26 Dec 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FC6nnE+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D75314A6E;
	Fri, 26 Dec 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766736236; cv=none; b=QfO2yfNvN3PqGatO7JR/LQshAPROFEDeR0+fKPomHODT+QDzoLsHM9Lm8zi0yXucXNiIKRjEDfDcX8icPxGUhpaOCZMiQJO3Q75ghrwnxMrOuKlgpDf6OTXWbijJCekI0ztF/l9xeJxtySVH23ILiWi7sTLg+Fc2U0Z/4zePer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766736236; c=relaxed/simple;
	bh=PQvbVXj0kQ863Zyc0dsnJj5990dKOjwRWzmBZAH+l8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3fyw9jCNaIlsZV6kUKh9bndJC2osA//msKknK/fqqogLRNDs+OIsB/InBy4e9M6Z73dcItBHHjPO45NTtPXKROy2xlfuMZAPbqu76YpA/iM2wrhNgCPKSGpRXGrRPGOfbZQ9FAEE71gjm1WTwrS6MmgolB04UBlpIPlLXB/mmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FC6nnE+e; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766736222; x=1767341022; i=quwenruo.btrfs@gmx.com;
	bh=/0Dx9Ntr79nlVmqD10aUsnh+weS9fwWLJpVv7gElihM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FC6nnE+e6SAr+00Yk+c3H1a9NTAADBAMfO5TKmm747+CpyS7iOmIjlg2c5Y/zMHx
	 jOMqIc9eyJ+F1BpogwNvxEbPSGfBw3JWPy2ynIO8FL/yo61wSpw/VAWv/HS+nJ6tv
	 aVjbdV3Etv/fHNAv19YfLpkZlg+bCwxVoX5XcLNxSqLhEWZWtqLbtlGifFgm9+OzJ
	 5DNXnk5WC1pEjKrvj0XT6++Ag1nTSwxQS7eYcZyHFCi6zFlUVC70N1AlSGo3D55mv
	 pxBNdisRfKOVpY7qM1f1oNfvc55rMz4A/I9O0zgdIvEOu/UpGs2YflqVzYCfs2xlY
	 VMPQGh3jCkivIj9Agw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Qr-1w86dK17lD-00eli0; Fri, 26
 Dec 2025 09:03:42 +0100
Message-ID: <fb336d1c-ce68-403c-9a7a-556906c05112@gmx.com>
Date: Fri, 26 Dec 2025 18:33:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tests: Fix memory leak in btrfs_test_qgroups()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: clm@fb.com, dan.carpenter@linaro.org, dsterba@suse.com,
 jianhao.xu@seu.edu.cn, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunk67188@gmail.com
References: <d0fac5ff-9159-4d13-8813-5de8e9bb6484@gmx.com>
 <20251226072956.1734175-1-zilin@seu.edu.cn>
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
In-Reply-To: <20251226072956.1734175-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tjt9Mqp3x34WuSLvJxdw7bEIka5jPmspX6BXhh08dL3B4HoxLnp
 Lv6ic5iASnPeWjwBBSs3VLdRBQo/4+C2uv78+fHaCnvEhT29z32uB4bYMoMQG+JCvfroB+r
 70WdVG8uAzc/oWRysCsaSx8zGsQyNSxlHIIoNuj/jYJWfe46glAKHB6ohqjDxgg2wRh0/LY
 X0KQ8hE8EFUtTzXVzf80g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fJ6SNoiCoFA=;nzP5KEOU9w4kSh54+KbY9XxXLBb
 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
 3XbLzxbsP4LqRRcYE=



=E5=9C=A8 2025/12/26 17:59, Zilin Guan =E5=86=99=E9=81=93:
> On Fri, Dec 26, 2025 at 07:24:45AM +1030, Qu Wenruo wrote:
>>>> @@ -517,11 +517,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32
>>>> nodesize)
>>>>        tmp_root->root_key.objectid =3D BTRFS_FS_TREE_OBJECTID;
>>>>        root->fs_info->fs_root =3D tmp_root;
>>>>        ret =3D btrfs_insert_fs_root(root->fs_info, tmp_root);
>>>> +    btrfs_put_root(tmp_root);
>>>>        if (ret) {
>>>>            test_err("couldn't insert fs root %d", ret);
>>>>            goto out;
>>>
>>> This will lead to double free.
>>>
>>> If btrfs_insert_fs_root() failed, btrfs_put_root() will do the cleanin=
g
>>> and free the root.
>>>
>>> Then btrfs_free_dummy_root() will call btrfs_put_root() again on the
>>> root, cause use-after-free.
>>>
>>> So your analyze is completely wrong.
>=20
> Hi Qu,
>=20
> Thanks for the review. I apologize for any ambiguity in my previous
> communication.
>=20
> I believe there might be a misunderstanding regarding which root is
> being freed at the 'out' label.
>=20
> The 'out' label calls:
>      btrfs_free_dummy_root(root);
>      btrfs_free_dummy_fs_info(fs_info);
>=20
> It explicitly frees 'root', but it does not free 'tmp_root'.

OK, my bad, indeed it's a different root.

In that case it's correct to move the free_root immediately after=20
btrfs_insert_fs_root().


And since you're here, you may also want to modify the error message of=20
the subvolume tree, it's copy-pasted from the fs root one, which is not=20
correct anymore (it's not fs tree but the first subvolume tree).

>=20
> If btrfs_insert_fs_root() fails for 'tmp_root', the 'tmp_root' is not
> added to 'fs_info', so btrfs_free_dummy_fs_info() won't free it either.
>=20
> Therefore, if we jump to 'out' on failure without calling
> btrfs_put_root(tmp_root), the reference count of 'tmp_root'
> remains 1 (from allocation), and it is never freed, causing a leak.
>=20
> My patch moves btrfs_put_root(tmp_root) before the error check.
> - On success: ref is 2 (alloc + insert), put() drops it to 1
> (held by fs_info).
> - On failure: ref is 1 (alloc), put() drops it to 0, freeing it
> immediately.
>=20
> Please let me know if I missed anything or if there are any further
> improvements I can make to the patch.
>=20
>> And considering you're sending quite some patches and most of them are
>> rejected, next time if you believe you find some
>> memory-leak/use-after-free, please hit them in the real world with
>> kmemleak/kasan enabled with the call trace.
>>
>> I believe kmemleak/kasan more than you, and that will save us a lot of =
time.
>=20
> Regarding your concern about my previous patches: I admit I may have
> submitted a few incorrect patches early on. In those cases, although
> the proposed fixes were either inappropriate or deemed unnecessary by
> the community, the issues identified were real.
>=20
> We have reviewed our previous submissions and found that most of them
> have been accepted. Despite this, we will enforce stricter verification
> processes in the future. Currently, our team enforces a strict
> verification process: we manually confirm there is a clear path missing
> a free before reporting a leak, and every patch undergoes a double-check
> by at least two members.

If that's the case, please add them with proper tags.

>=20
> I am dedicated to improving the kernel by detecting potential
> vulnerabilities through static analysis. I hope my efforts contribute
> positively to the community.
>=20
> Thanks,
> Zilin Guan
>=20
>>>
>>> Thanks,
>>> Qu
>>>
>>>>        }
>>>> -    btrfs_put_root(tmp_root);
>>>>        tmp_root =3D btrfs_alloc_dummy_root(fs_info);
>>>>        if (IS_ERR(tmp_root)) {
>>>> @@ -532,11 +532,11 @@ int btrfs_test_qgroups(u32 sectorsize, u32
>>>> nodesize)
>>>>        tmp_root->root_key.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
>>>>        ret =3D btrfs_insert_fs_root(root->fs_info, tmp_root);
>>>> +    btrfs_put_root(tmp_root);
>>>>        if (ret) {
>>>>            test_err("couldn't insert fs root %d", ret);
>>>>            goto out;
>>>>        }
>>>> -    btrfs_put_root(tmp_root);
>>>>        test_msg("running qgroup tests");
>>>>        ret =3D test_no_shared_qgroup(root, sectorsize, nodesize);
>>>
>>>
>=20


