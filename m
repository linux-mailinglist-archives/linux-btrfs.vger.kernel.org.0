Return-Path: <linux-btrfs+bounces-17903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41DBE5693
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 22:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2A3439C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBA2DF13B;
	Thu, 16 Oct 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UbnYDV4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FA4409
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646941; cv=none; b=sZbdCsQ5qX+R9UGmn2CwydFnH4ye45c4ctNAFoPqilvD4K5TEtdq5Vt3wpyT6mFu5T1u3vlLbauSgw9L0jAfBVG/h+xiLLfzCawWpCFNdXM7a9VSm0MVsqNg2I2MdlYGXaIVRgM2UHvLqlesz7tRcAf7khXmiXYYqUvcbonoBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646941; c=relaxed/simple;
	bh=fC3T2fGwVrs+G384VBjSM+eVmK/gRgTtuezLYqQBqJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1CG0JJvO9XkhQ/DZTZ8k5B/y007gcJimp/JkJu3GoYKB8a8/zdQ+w2CnnGMu7lhyf89+WBuHoGbt6P/2SlkJJVEfb/B+pR13vGDFwjF7ujpm5JMTJWVL9600DYlPUxX4uHS4Qx5cYsWRSODcVwjCEh2C1SoBuBw68tDWft5oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UbnYDV4s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760646935; x=1761251735; i=quwenruo.btrfs@gmx.com;
	bh=GU+myowdDCkQxMmq9eBh7t1+7HGbjG0kPWx3JTyLt1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UbnYDV4s2N76XTgXBtaGPK46GaZBXtfEwA2k75O8H3zWQwheC9kU/v5clcoa0NsR
	 xNTLcn3IJ+WDURL6n8dZieBiWSAZn8SArfFzizqv09HIXvqTnGLLYYi4UprknHqv4
	 XcUPAjXk99GG/354cUr+3dBHi/BfQLWqG8pDffxWoelteowBEeTaubecrlD+TJLDt
	 pKMAd4k6Y0bwp9NHaAT63gmxpQsAnvUGCK1B8FZgXWR9RCEy3ykNVN7axuvDgR9Rk
	 EQq4ZWUJEEdtmc2x5qkwm4iwTIkUyVU/3DJk2aj1SwiqTT5HcFti6axR5FD03DdD0
	 /mLBR9AtOi5UpgQehg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1uPSdq21FY-00qDuY; Thu, 16
 Oct 2025 22:35:35 +0200
Message-ID: <c66eae15-2651-405c-a024-05a31e836fc5@gmx.com>
Date: Fri, 17 Oct 2025 07:05:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
 <20251016164224.GH13776@twin.jikos.cz>
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
In-Reply-To: <20251016164224.GH13776@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rySn3Ysqe//K/B7wMVbfsdXu2RN+b81mIEQK8F7O8qbL20ASpIx
 ZpMX6xMYD91EewhK8O/4Fe80d6MEdZlCDpf8e+lL2/gnM5AwFpNQfXLdrvKaDP6CmB1YdDm
 d1VqWpWHpUS83vRWqX37p1a6Ngso6ealT+uHEVFO6a/y+2krLti8KZvtGVIYt5aAJx7k72t
 pC6oSNEzKhHrbF5ItKijw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UMahmvFX9rA=;hc+J4fbabilIuEq9DQKVZ/OtRCS
 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
 c8ehQ==



=E5=9C=A8 2025/10/17 03:12, David Sterba =E5=86=99=E9=81=93:
> On Thu, Oct 16, 2025 at 03:02:30PM +1030, Qu Wenruo wrote:
>> It's a known bug that btrfs scrub/dev-replace can prevent the system
>> from suspending.
>>
>> There are at least two factors involved:
>>
>> - Holding super_block::s_writers for the whole scrub/dev-replace
>>    duration
>>    We hold that mutex through mnt_want_write_file() for the whole
>>    scrub/dev-replace duration.
>>
>>    That will prevent the fs being frozen.
>>    It's tunable for the kernel to suspend all fses before suspending, i=
f
>>    that's the case, a running scrub will refuse to be frozen and preven=
t
>>    suspension.
>>
>> - Stuck in kernel space for a long time
>>    During suspension all user processes (and some kernel threads) will
>>    be frozen.
>>    But if a user space progress has fallen into kernel (scrub ioctl) an=
d
>>    do not return for a long time, it will make suspension time out.
>>
>>    Unfortunately scrub/dev-replace is a long running ioctl, and it will
>>    prevent the btrfs process from returning to user space.
>>
>> Address them in one go:
>>
>> - Introduce a new helper should_cancel_scrub()
>>    Which checks both fs and process freezing.
>>
>> - Cancel the run if should_cancel_scrub() is true
>>    The check is done at scrub_simple_mirror() and
>>    scrub_raid56_parity_stripe().
>>
>>    Unfortunately canceling is the only feasible solution here, pausing =
is
>>    not possible as we will still stay in the kernel state thus will sti=
ll
>>    prevent the process from being frozen.
>=20
> I don't recall the details but the solution I was working on allowed
> waiting in kernel and not cancelling the whole scrub,

That will only allow the fs to be frozen, but not pm suspension/hibernatio=
n.

As I explained, pm requires all user space processes to return to user=20
space.

That's why your RFC patch doesn't pass Askar Safin's test at all, no=20
matter if the pm is configured to freeze the fs or not.

> which I think is
> the wrong solution and bad usability. That way scrub may never finish
> going over the whole filesystem.
>=20

That can be solved in user space, with minor changes to the return value=
=20
of the patches.

E.g. only return -ECANCELED for real cancelled runs, and return -EINTR=20
for interrupted runs, and let btrfs-progs to catch the -EINTR cases and=20
restart from the last scrubbed bytes.

Thanks,
Qu

