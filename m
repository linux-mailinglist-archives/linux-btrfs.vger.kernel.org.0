Return-Path: <linux-btrfs+bounces-2320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EC850FF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A93E1C2173A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50317BB6;
	Mon, 12 Feb 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XEY1MzPl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D3848D;
	Mon, 12 Feb 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731438; cv=none; b=sIQZrbcX1taDHZQyKHTPNzXrE+XsIyPZVyVE/VZvmsQquQF2H0Mg2wdZtVs6ULBLU6bEd7cMlLyjgqHZwBAInp9yHjMsvAuiOWwf47qNH4/TNUdHufWt3C75n0Khn8YeIL9GT5hbPuoOVtNXD7aPvOaNnFXaxwFZm7iDiHqUuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731438; c=relaxed/simple;
	bh=/z8+Ms5gxbKddtkDXpREuHZLAcrzBaXnwb4RyBFN+3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB8dVFjNNohdRDNORV1dtH9x/fdnmbQOUXPB5DotHjb0glt4t08jJP1wSvm00pkeyRvOZuigapNoC2LvQD4P+E5kPTBWMjyHfyZn+EzRn6v2+wueBZH5HlomPzOFA4rn/iMFALQhALmFyJcCmoz/TBrSK/aUQrJ5ln94lg2NtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XEY1MzPl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707731426; x=1708336226; i=quwenruo.btrfs@gmx.com;
	bh=/z8+Ms5gxbKddtkDXpREuHZLAcrzBaXnwb4RyBFN+3Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XEY1MzPlzW6K8ljNGvg77AgR/De2QVT2UrdszLBUGc9ov0VVNI/ibMHHOKjzMDNJ
	 eJVWL0nBwXlQgx927dEtOYIYlEK25vAeE2UL31VpguzmDXD7uvQM3yTHkrj5DOrKv
	 u/AZdXtOCfseGU6GLwdIzXQ3y+v23nlGdn7GljK3Tczs4GgrDATHBFb2Lvv3cZuVV
	 e3xOvv10iYpOqKgrv7gT6IaUQLygEKeAjsw+w1Tjmix0GZzywpUZsIzvWLy4L2pDS
	 eTtVd8C+imQBXdDe53zO9NO4dgCnmPfQes5MeaMAMUCWY9I9VS3SmkCG5I5bHzEOv
	 q/D67MO4/hy0iWEXKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6R1-1r0PFh0MXj-00aFsb; Mon, 12
 Feb 2024 10:50:26 +0100
Message-ID: <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
Date: Mon, 12 Feb 2024 20:20:21 +1030
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
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: HAN Yuwei <hrx@bupt.moe>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
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
In-Reply-To: <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rOVwObELpBOH23LM2cJGO25Vo+weycS41SvDmJSAPsTzt1Cx7uV
 8msAyQNagcrBWsytGRu9CCz8sdfJ9QyvTQyd5xYh4TAHrWOAR35U92/E67JY20GZDIhG2wR
 wQkyF0wbcWLMZnny4sjmOhFcSEsJSzcKXIvPo6bf/5dd2AltMcwJHIvkf9bFzoQO8a+tBvA
 M8AXJDJrhSR7KU7sGWn1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XpcwTZsztUg=;6HeiSVW/6WglKV0TZmKO38xs0bG
 Gk39Z5JchEt/xxPJThiquLuLYzDYiZqxHr7R5muj2y8MvkwEqH9uDmLp/SJgqsBlf1U0gMhFy
 T+mOpRsdNVDf3KAbJEoa8qqtTox/0rCWceE3NbHePFvMLz16Ec9YQIDdkit6RzQPjpxE0UuPn
 rPe40H+gobEAkMT87dmX4nuYM3lzsJGZ5H4G8lcgoIOuF8esItx1E4ejOkIh1n8DqavVExvJX
 8oiSooVGpD4JZhpZFq/uP4hvbcisLzRMoBb6+nIkzkLJbTOEEKltob2I2vW/kq1RTuOsSTb7T
 3fy4Q8VHrAak/kNqH2eRihH3AqUdRjXl+E4kw1yIyFicynkBnKzmpIq7lhEEmHwJ93Gco2b4z
 FQR5X6EZHEZuiVO1jAzN2mx/8I/qs6ocHInfoplpXpHSAIUstdN42n4x5JKJDl3rKSav0trny
 EMFCkG7P18Z4Lg3xxsrRweN460vclOSABz1Cao7LXIaQ4XIMs6Spbs+veDpjpo5KGj5VOjc6s
 0j+002kBaynRb3Zm0T+9a0EnGl+smNYLEQR0eKWzKgxlRgvr7HAWtJ4fkWsRjAx/dbKXzaxKr
 5phQFiDb2d7LFnIcfwwzWOSxaf0a26ziur0aG275zDjxXlnrGpTWz63r8zlynUtwQkrWUYS+P
 gxED5cvVXfzgO8QCn34CGznCulGmquGVgwZNaXs9DLCJwBVouAYwOf5GVqcG83BOIhH+GvhdJ
 l9r4wh7ucFa8ui/2m0+B0LwUtMCDXKSBCSypbFyGxmjys80h/GCkqbCgtVNKUWft2/JMke1OY
 WyalCr7rCBChCcd7Ar8KxCEZvCMiTkucIvGQVKEt52yM0=



On 2024/2/12 20:15, Johannes Thumshirn wrote:
> On 12.02.24 06:16, Qu Wenruo wrote:
>> Reported-by: HAN Yuwei <hrx@bupt.moe>
>> Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a-9=
e22-9d390aae84cc@bupt.moe/
>> CC: stable@vger.kernel.org # 5.10+
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>    fs/btrfs/disk-io.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index c3ab268533ca..85cd23aebdd6 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3193,7 +3193,8 @@ int btrfs_check_features(struct btrfs_fs_info *fs=
_info, bool is_rw_mount)
>>    	 * part of @locked_page.
>>    	 * That's also why compression for subpage only work for page align=
ed ranges.
>>    	 */
>> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_is_zoned(fs_info) && is_=
rw_mount) {
>> +	if (fs_info->sectorsize < PAGE_SIZE &&
>> +	    btrfs_fs_incompat(fs_info, ZONED) && is_rw_mount) {
>>    		btrfs_warn(fs_info,
>>    	"no zoned read-write support for page size %lu with sectorsize %u",
>>    			   PAGE_SIZE, fs_info->sectorsize);
>
> Please keep btrfs_is_zoned(fs_info) instead of using
> btrfs_fs_incompat(fs_info, ZONED).

At the time of calling, we haven't yet populate fs_info->zone_size, thus
we have to use super flags to verify if it's zoned.

If needed, I can add a comment for it.

Thanks,
Qu
>
> Otherwise,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

