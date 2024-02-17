Return-Path: <linux-btrfs+bounces-2463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A06858A84
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 01:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019BE1F22C12
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254E3D71;
	Sat, 17 Feb 2024 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k+x4ARHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F77EC9;
	Sat, 17 Feb 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128454; cv=none; b=TLhuCd/tD2FiGaGTGPwG4QSoGsrE5jPBbd8geQ93fEi0x0OmhKIr/U9gbA9/m0JxoDVTmFhsz5S9qhrwKhf2rleWyQ7XP80oURB175N6JBsvMmSNBy/SqVrPJ5Nkhakqi2Jq6zFMRng47AvcFY3YGrKT/ebx429AuoO4MZQCEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128454; c=relaxed/simple;
	bh=8pXpHaVfgZnmkIkSWzFd8+SXpitFE5+MCfM8ku/fHyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyfUFh5squyfafFWaiP2cSVD4Cy7KMM3x0zvuqCYB/FVDM05uu4LO0tZL4pDJRsSu4XDeOM8LUZA7ctNjCgJW3r/xl7khJJUimNKrB3Fpc2QB4QIBKhnu0FSFiMVrvXMduOB+8nkup4UlsBcnRxiIIjf3jjwRdrlid9BZZVyFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k+x4ARHf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708128436; x=1708733236; i=quwenruo.btrfs@gmx.com;
	bh=8pXpHaVfgZnmkIkSWzFd8+SXpitFE5+MCfM8ku/fHyA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k+x4ARHfsUFkWwaZk95HBo5uMTHFlcCLoi534culucD6oPnKVWutq+3nuiNLm7l3
	 5SnA3C17/DqOh0yzVsuRZps3Gd+vRcq9Hqq7D25tLw4zhH+e7P6bwcQWt6jVW1Lam
	 /Tij4ZL/B8V0SPFDMk4Y9I1rsQ7CddPY7sXIvpXcPcp42E6PFyZTBaJdwzW7SN7x1
	 jLWNLiqTcpqR/3rJ4NkIZSDvWIGp4JQxeREiUgPxfYFHdnLeMF7rCQP7C0vcpdEhS
	 sXWHowx7fu9dxOvVpaQ/ZpjYoRDzB5mawuDHdnL3BuVId5OKr47fBqeTDTjfzQviT
	 5XFJ9wymGWWHveeLAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDNf-1rAol22hXb-00qlgt; Sat, 17
 Feb 2024 01:07:16 +0100
Message-ID: <25afb718-9aa1-417a-95fb-144b39010932@gmx.com>
Date: Sat, 17 Feb 2024 10:37:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Content-Language: en-US
To: dsterba@suse.cz
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 HAN Yuwei <hrx@bupt.moe>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
 <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
 <20240214072931.GN355@twin.jikos.cz>
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
In-Reply-To: <20240214072931.GN355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMq/OdpVeWBbZ7LvyK5ZiOwZSFH+hf5Fr1v/3Tme5olJSWNnz97
 xT1YI5pZ4xr8UkcBxS0e7kCOiazFOHtzr7vHh9Id2eGb4hOzXNMDWewT43dRat8VDyFmtNJ
 LsR9Si4yGMUhyggbETslfVQwgzKpgt8kVx/2BgTPK3kIrKS7HHRuFV7Sc70TlIukwgSqHLn
 EzKVMftBbBcsZCTs3UzcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NBVXDrQXdHA=;kB70LvvLwUP7IgmQyi46+gtzGnB
 Ksp+K9MpeaRiwX6B3CV5E/9WbyPv8n2SkOAqwe2+lkeBqx8ebft6ZQHO31nOyjPRTBOMoN69m
 mSCNzqJjv2rO+dt6ec2opeXGMIA09cX+yQ4w/kdS7eGsYljShfL5Rx6gTsOb/CVvKtU+vUtaB
 EO8rmNSzmpII9GlFxh66a5BKYQHiPwG5ToXD1t+IiHrYJh+Ap57yAH4vB2wkF366qqyVLrafo
 seySKuq1HPBh1pTTxqr6j6ElcqRz/pJMbihRHM9oFCdHwYrtAgNicwfLq7jod8JUe99VZcCxa
 yVtt+MzTUnW0G250+DnnDu2w4vDpJj/DgpNnsLgbenIsPvQnMMDq1/164wz275X/CmN5DjTJ1
 AGtixRt9Q+9wYr6pUYN7Xh5dtGA7eB+M3N44i6nuQokB+Q4XsDh+9EBHhbdDU+rljEQh+c+Ml
 HWMVBw9+jQAFKuU+OURUIxgcRtz88c1I/VRVQnrHDzYpWKkn8vc1knkmbKrLA6NiyLEMs4cp8
 JGdA415AVVMV90TobFgIKkNOrkOoPudCQDGmIlj1zuPe6OdmarxB7L+FZHSM0OXaAtNEf39dX
 OcZ/3TpKJGyx4R+zi+1s9PjGbH2UgUA1c47SnqFSjSlwjjfEdOjr5gHs0LQFFvINsnM9bEr77
 5iSkg1w50328y299ym9CChu8R+56uBgW8sjshdtbKx6ISpYPAnTWJb3uzST9JJCNL7WKasUH/
 St/lwl4edOhZ5nW5ywi4lcvzjGqxQypvVJu1ZWioae/c8QM+ThlVJflStqvOEwFeJIUu9WKAH
 963ZMbJm7BSHpO4jzFhH+BPDs50nsrAF8HQhSBPRWHd6o=



=E5=9C=A8 2024/2/14 17:59, David Sterba =E5=86=99=E9=81=93:
> On Mon, Feb 12, 2024 at 08:20:21PM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/2/12 20:15, Johannes Thumshirn wrote:
>>> On 12.02.24 06:16, Qu Wenruo wrote:
>>>> Reported-by: HAN Yuwei <hrx@bupt.moe>
>>>> Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a=
-9e22-9d390aae84cc@bupt.moe/
>>>> CC: stable@vger.kernel.org # 5.10+
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>     fs/btrfs/disk-io.c | 3 ++-
>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index c3ab268533ca..85cd23aebdd6 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -3193,7 +3193,8 @@ int btrfs_check_features(struct btrfs_fs_info *=
fs_info, bool is_rw_mount)
>>>>     	 * part of @locked_page.
>>>>     	 * That's also why compression for subpage only work for page al=
igned ranges.
>>>>     	 */
>>>> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_is_zoned(fs_info) && i=
s_rw_mount) {
>>>> +	if (fs_info->sectorsize < PAGE_SIZE &&
>>>> +	    btrfs_fs_incompat(fs_info, ZONED) && is_rw_mount) {
>>>>     		btrfs_warn(fs_info,
>>>>     	"no zoned read-write support for page size %lu with sectorsize %=
u",
>>>>     			   PAGE_SIZE, fs_info->sectorsize);
>>>
>>> Please keep btrfs_is_zoned(fs_info) instead of using
>>> btrfs_fs_incompat(fs_info, ZONED).
>>
>> At the time of calling, we haven't yet populate fs_info->zone_size, thu=
s
>> we have to use super flags to verify if it's zoned.
>>
>> If needed, I can add a comment for it.
>
> Yes please add a comment the difference is quite subtle.
>

I'd say this patch can be dropped.

The reason is:

- I'm already working on the proper subpage handling for the
   @locked_page of a delalloc range

   The patchset is under testing now, the results looks fine for
   both regular and subpage cases.
   Will queue extra testing for subpage zoned.

- The rejection would cause future problems for detecting whether we
   have proper subpage + zoned support.
   Either we do not detect, or introduce a complex mechanism only for
   this one edge case.

   Thus I prefer not to detect.

- Subage + zoned is too niche for now
   The most common subpage usage would be aarch64 (especially for Apple
   M1/2 chips).
   For those Apple based ones, they have no ability to expand, thus won't
   hit any real zoned devices.
   For other aarch64 servers, they should have the ability to choose a 4K
   page size kernel if they really want to go zoned devices.

   This bug is only exposed with a helpful reporter using 16K page sized
   loongson board with SATA zoned disk.

Due to above reasons, I really prefer to keep the current situation, and
focus on the proper fix instead.

Thanks,
Qu

