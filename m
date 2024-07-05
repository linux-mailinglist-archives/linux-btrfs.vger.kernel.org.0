Return-Path: <linux-btrfs+bounces-6250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA7928F5D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D01C21B16
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852ED146003;
	Fri,  5 Jul 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="W+cMsy6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD2A955
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219221; cv=none; b=uCkPbIIvJn4ukH3NzstX3k4tTRt1QHnK3Pn2IeKeedyMdrlg6QljIn5MuoNjkYD5Mfn1DrOLtH91KSYB/9XE5GB/20V160pIzVqwnxFGXfxFst20dTFszclAt0ebmQcbJjR97Gk4O7fWa/IybDrhgEAhODGq/ia0IntaEqw//0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219221; c=relaxed/simple;
	bh=LmWhiM8oFnIv0GctIUridyPbstsFJTA8bLnw9C52jv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqRLgd7X//h4nksJmMrnwDPyLynUwzYdMeH/0xHxlG7S/aMg7sQUakiUFgtK9GcvDg7R6fB95yhMGL/hfb1lKBgEHoZWtVLRLbnRtzv9xdm1vBA3OVnsK+mNNqFzRY59/pfDjy71RigGOT+3EfBWek+OuYhcTjooyWKGdT+MBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=W+cMsy6Y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720219215; x=1720824015; i=quwenruo.btrfs@gmx.com;
	bh=9izavcIldFZmymjYfKR9ewnBv0ZTn10NsevQ7JWtHaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W+cMsy6YSCIIjvL6Xeg7jkAuQdPPxu77M4f5nBB5DFXKVXbOop+IhvaUFb4hU7YU
	 apE0xgRkYyz/+PYmB6OEa/MfmxjnQ9e1nRzSNshLAoZixn4HzPfCnuX+l0spwB72B
	 D7ja/AZOhAOV3ZF8ClGDnD7uzccA8zgzITuJ9WGNDbS5Xx9mCyKgAo9rvsT4AbYkl
	 NDYYZ1KKUwW+VUrjtc6lLzbPKN2hsFLcJIIvpIjlEhUEdL937TKS61TLV8gZJDEpc
	 ON0MNmF9dIPS3xEBhO1+w3XTpsIBm2EilKLPhfkfVfcZpHW4yg123Qzgpt2NK5F8e
	 nytMy4wF1UmUwZ73xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1s6gqr0weo-015CFD; Sat, 06
 Jul 2024 00:40:15 +0200
Message-ID: <b954c65f-3344-47a0-a983-ec60f472f6f6@gmx.com>
Date: Sat, 6 Jul 2024 08:10:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1720159494.git.wqu@suse.com>
 <20240705145543.GB879955@perftesting>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240705145543.GB879955@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HherBA9iqobJFFy115uiWzek4Con5FczajIaVmUXbt3VODMQaaN
 SSi/QAWTfSTMk45Yz0RY+jZrGMrSH1OX1OwT+nSzHaEWDD2D3XY54NnwoSzZgZLzbUZGiaz
 N9ayiEzAm7fTH3x9bNuV+4qE2Qibc34cfUghF9pvLfAlplBW9O9y8LGtoaiovp3ggX/i1Qy
 1bJLwmGLc0EL+HQ85Dxyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dx1SY7V4/Sc=;OpjX5wWETC/lziIRTbqH8xcZgc4
 a+uKWXd14Pzj1aRtSqh36QJ8Gtndq1E0GRJu1h2T5nWqr9yBeAM9Op8f8J9dlqBHIPcgHPJl+
 Ydn/HK1js4NGXZLKvttEcEcq9wn56MY6GyW3esY9ugoIdEKRq0oSocGXXUtc9c0n0eNwyTrQ8
 7/t9h/JBirYQtKrp69wL1Cc8mXGoUuqhjokyt/+RdKP8xy6BdeLkWoZAfuCVzk+Zpiw6oKIGB
 vmUjUFw2qE8RjjgfE3u/Xi/LhTPmfKgwjWotj0Ev/3hzC6ewfNnOFsAFUTMm/4gtvVy7KDdGa
 r4JQbt0iaxi5OyYsMmvMJdnMcoDI8PhwBs5hwD+aojyFU45CAHHJv44nbAInOik2CYdy/pDnp
 YjuoclzwPrw/VNjSjG7NBOO72O/+XHwYHXiukiILzEaOAkBspGRVfw49lmFe3Oz2caiiObVWc
 aV2ckckpCTuo/0Uxnx1N1IuDyOTK9a+gSsG7jnGZzCkbxCxWFA4BeGXraJ45YylnBt5uCmJcr
 3w06PZV/nCuIzJrZ0SxPpuJi8RnqvDRq7bFS6qQhJirSrRHHyXUlyGW/vPpxHkKGApnF+9ih8
 jAuQ6lK8sAltoRMhgO5WemNNZWBR3bj/ne8fnJmzGUCGl+zSZdycQkdY0L0bVrz5LWKQJOIgm
 XVHv4pSZz9J1buywocyO2TxhHM2z8J8v/MbL3Pv4k5riIYavjBta5TVli7srSw+g3/0roI3zQ
 M/9g2k1EC9ScMrO8rKFt6mPHl6Zs4956VHyXoQewDbVghUyi7BvrHz7/VwzxRTOTCYEZEsnA2
 PVWzLgAwjmAmqeSzi0IqeNK8bOXCsKPBFAbl40M8Kd478=



=E5=9C=A8 2024/7/6 00:25, Josef Bacik =E5=86=99=E9=81=93:
> On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
>> This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
>> DEBUG builds.
>>
>> There are 3 call sites utilizing __GFP_NOFAIL:
>>
>> - __alloc_extent_buffer()
>>    It's for the extent_buffer structure allocation.
>>    All callers are already handling the errors.
>>
>> - attach_eb_folio_to_filemap()
>>    It's for the filemap_add_folio() call, the flag is also passed to me=
m
>>    cgroup, which I suspect is not handling larger folio and __GFP_NOFAI=
L
>>    correctly, as I'm hitting soft lockups when testing larger folios
>>
>>    New error handling is added.
>>
>> - btrfs_alloc_folio_array()
>>    This is for page allocation for extent buffers.
>>    All callers are already handling the errors.
>>
>> Furthermore, to enable more testing while not affecting end users, the
>> change is only implemented for DEBUG builds.
>>
>> Qu Wenruo (3):
>>    btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
>>    btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
>>    btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()
>
> The reason I want to leave NOFAIL is because in a cgroup memory constrai=
ned
> environment we could get an errant ENOMEM on some sort of metadata opera=
tion,
> which then gets turned into an aborted transaction.  I don't want a memo=
ry
> constrained cgroup flipping the whole file system read only because it g=
ot an
> ENOMEM in a place where we have no choice but to abort the transaction.

Well, I'm already seeing mem_cgroup_charge() soft locks up, possible due
to the _NOFAIL flag and larger folios at filemap_add_folio().

Thus the _NOFAIL flag is not only affecting page allocation, but also
passed to mem cgroup related code, and that can already be problematic.

>
> If we could eliminate that possibility then hooray, but that's not actua=
lly
> possible, because any COW for a multi-modification case (think finish or=
dered
> io) could result in an ENOMEM and thus a transaction abort.  We need to =
live
> with NOFAIL for these cases.  Thanks,

In that cgroup controlled case, I'm wondering how it would even handle
btrfs extent buffer allocation.

Wouldn't all the eb charged to certain cgroup meanwhile the eb pages are
a shared resource for all btrfs operations?

If so, I'd say the mem cgroup on btree inode is already problematic, and
we should eliminate the behavior other than using _NOFAIL to workaround it=
.

Thanks,
Qu

>
> Josef
>

