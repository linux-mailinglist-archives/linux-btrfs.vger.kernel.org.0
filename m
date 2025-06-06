Return-Path: <linux-btrfs+bounces-14526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9074DAD00D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38553B1908
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BD28750C;
	Fri,  6 Jun 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jtb0rTcc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582F18641;
	Fri,  6 Jun 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207323; cv=none; b=o2clJCWRKqtoUHSpbO4b5In6XRFedJrsuL9aroxM2KxZ7yz6iJ0ZxAb845/91K7g+3UrUghIjVp1nfjkNJ8/X3u9BEeQ4kDvbrXEQiaa3qjjQ32F5Wn0/mrwa8PN3C9HHWmo439Isd4K5cbqUGjGQmnPBZYGIKUgJUr1EVyAPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207323; c=relaxed/simple;
	bh=udVf2+XQTcFTxc6avKMBobryghl9MGh33ozR0ADGJtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDFejoZMKOzOw7MbYNnxlMZSdy9tqYqiERi0rvTs20/aLXJu1OUK5w+Yt5Tp6GTpzQ8EC6I7z0U3mTpRrU8oY7dUN0sbid0PwN4XYqauuPeGuSKDc8H2oWB8xavLOF5RtQS9N9Lg/mizfuKlAp049lciZnCJyn7M9vXt/3xdVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jtb0rTcc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749207318; x=1749812118; i=quwenruo.btrfs@gmx.com;
	bh=SqYYPh2fm091x9WbWaB+ZN3g6yaRKG7c6eCLTsIHyPA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jtb0rTccWMar7LVw94oArXj2PONVlZcK6BQdP0GinfuPHWeDvqVPCnTGR4gWwCLk
	 dZoAy5OANiveFJcMyZ8R1HhYWdJ7XiPUZjEsndhAZ+aCUYIbF6hzW/GBg06m5OoGz
	 jcoElqXnqKriFpQpjwXTsdwC3gUHC7+orOh6Izg5fJiLz25PGYfxS81F1ltIDrcpG
	 4C98QYqtLGKNhenPVqMj6t/D9kBE1nY+Tr+PZJXgQOmY1aYeNCG6Awmvg8XD++YBT
	 A5NjfILsLmRbNcHCk0ZZNn4VagEU44N+883G6VwMGM8o52K/Pdh1JhXamavafEWAe
	 eFD2PrMp+ZtES4qd/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1uQn3B0IW4-00A8q1; Fri, 06
 Jun 2025 12:55:18 +0200
Message-ID: <0a94ae69-8d1b-48bf-8af0-9bfad801e038@gmx.com>
Date: Fri, 6 Jun 2025 20:25:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/730: exclude btrfs for now
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20250604062509.227462-1-wqu@suse.com>
 <aEAC5WTF_tGh_RpN@infradead.org>
 <76226c51-78c5-4113-a04d-694a50b98557@gmx.com>
 <aEBJCG1_VRDggo6N@infradead.org>
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
In-Reply-To: <aEBJCG1_VRDggo6N@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4j3MvDu3sI8PU5RXnqEUpFu059MroqYKk6vm/Ql74W3k2MyD+Pl
 nfUb8rQGHEbHbHas3qKSS+DCCb2rhDLy57lhidwqw/LLqkwCRf8dEKsEUG4bmpfUwoOdPjx
 zYjzMduS7XVjcIrdE66fBY18eledPyBfvV/Wl8P+W1u4xNaLfRXya2W984xvCYr8vZBS29d
 euwASMj3zDI2d2xkLXrFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3aWtCpZbqv4=;Ae57Lgu41va3Ql32Q3G+reOKZji
 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
 KUiQ=



=E5=9C=A8 2025/6/4 22:54, Christoph Hellwig =E5=86=99=E9=81=93:
> On Wed, Jun 04, 2025 at 06:47:41PM +0930, Qu Wenruo wrote:
>> Right, the ext4/xfs can go a superblock shutdown because they are singl=
e
>> device fs (except the external journal device),
>=20
> XFS also has a RT device in addition to that.
>=20
>> and fs_holder_ops handles
>> the single device failure by calling back into the super block shutdown=
 call
>> back.
>>
>> For a multi-device fs, it should go through the blk_holder_ops, which b=
trfs
>> doesn't provide when opening the devices.
>=20
> Yes, btrfs would need it's own fs_ops.  Alternatively we could add a new
> ->devloss super_operations method and change fs_bdev_mark_dead to
> something like:
>=20
> 	if (sb->s_op->devloss && sb->s_op->devloss(sb, bdev, surprise))
> 		goto done;
>=20
> 	<sync fs and stuff)
> 	if (sb->s_op->shutdown)
> 		sb->s_op->shutdown(sb);
> done:
> 	super_unlock_shared(sb);
>=20
> so that btrfs or other multi-device file systems don't have to duplicate
> the logic.

I learnt this the hard way.

I tried to implement a btrfs specific blk_holder_ops, and just use=20
btrfs_fs_info as the holder.

Test case generic/085 easily crash the kernel with freeze/thaw and=20
mount/unmount races.


Bcachefs is doing its own blk_holder_ops but with extra protection with=20
similar refcount and locks.

Considering btrfs doesn't got through the regular setup_bdev_super()=20
patch, I guess for now we have to duplicate the logic for now.

Thanks,
Qu

>=20
>> I guess it means, if a fs supports per-bdev shutdown, it won't hurt to =
also
>> provide a full-fs shutdown ioctl?
>=20
> Supporting it is a good idea in general as it enables a lot of good test
> coverage in xfstests.
>=20


