Return-Path: <linux-btrfs+bounces-5451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7F8FBE82
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46160B2299D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8465C143744;
	Tue,  4 Jun 2024 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bTSs5Ogq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C413791C
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538929; cv=none; b=VOKxBiZN3Z7vUwB6wMUyxpqHd6/kXKItocBtRNSvApp7dJkoasQDUzfoFwn2kx2PD9gciFnnGA7aPEKawSlkQxS6i5ySJs2uV+y5yfWB7Zy+1dR/iyllLbVnE1j4CSjxzwRBZmIXFuDOegBgTFLMZCN5JvHPIYGLkhhBSvzytyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538929; c=relaxed/simple;
	bh=kLTMUWVREZNMwhdoc87kmjPP4THZuro38gt+8atssi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbiG0Cpnl6Jud6LUiSqx68SEgS9D93VU9ffQKiGBg0B9wEaVb99dZaEVcav+2HbAjvlbSOAgBe3laQkKT+kEBs2zPs8k1kUZCDyVr96zz5zXpu08Ue/nbnY+hQBooTuWr7vwmH2U+f8Ym9wjoT940hiUktDgFv6J9EE05jAqLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bTSs5Ogq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717538924; x=1718143724; i=quwenruo.btrfs@gmx.com;
	bh=8ZYsI09KaUKKJjf8Q6Lc5Fyx7OgUAtx66z8IsjXzr54=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bTSs5OgqfEXn8NJ28Wmtl9izQ/sADDgkv3QNzx6fQZesDUQU0qm6Bb3AxW03m68p
	 N0PuzaodYFkT/eVJ3w9/MmezRQTVbQjWLjuXMuFTyp2l1YrZLuilWJMqyiNeqscDv
	 FPRd7S84Cslt6hVb6TiaFoNArVK+8lmBtPumSKAnRKjSeHvonF36dnVWBbDgdB0Xx
	 u416UUHrzNw9JLT6W0+9j+iNuRkCMeasxtZ/37409X4GK1iwsrYEHYAjjcSg9Duz5
	 ukF7ih91/QhGXRmg/LMhCSR3CgzhskJKvXj1nsDCcRtHEt3mPIKuBMNTYWGmrSLk0
	 cMmmufrNyC74UrpzCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1rwXU11Rn0-00IFcm; Wed, 05
 Jun 2024 00:08:44 +0200
Message-ID: <b06a8ffc-f45b-4bf3-a5b3-64877771a549@gmx.com>
Date: Wed, 5 Jun 2024 07:38:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fix a check condition in misc/038
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <a49e6b43e3c140995567fea035017309b4bcd53c.1717480797.git.wqu@suse.com>
 <20240604155454.GA3413@localhost.localdomain>
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
In-Reply-To: <20240604155454.GA3413@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mc8IbCbRHK8nxj09P9K6L0doh9hxxHMF4ZB1sU+mLVGvegpGOu7
 0HcJVDNYWNCwnjUIkbsFILTBCq0Q/OIshhv0Mn0s9eBnv9aa2Fod6gjseh49b8RgpM1yc76
 0M/9EWdJgNkBdpZ5a5ZB3ZlYHCVaA9ZPNMA59E1gnzA76H6FnVeFmM4JiiJMtuTNDEbvvXv
 KRN+2shL2Qq/2TLOftzBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SnHCCpRZRvg=;FP6TF+oi/XYE2I0FwnYmOOwR10T
 W1E8cikoVNcv9mRvZDwEHlRiVYviQOwqdOBh/eCXMuBY9XZ114GskkxGxf4PiXF+zYSyAEyxc
 ErecL+VK6oTcCEw5vRQRycKAJCWnmRtDfbkAksPQ14TNZo0lghhIaJyHipuUh7m8EzOsZra3S
 xYv1/+IePSGu4K/Qb3VTbwLqimQ1+/GO2L8A6eaFePo68ZiDqxJxAfoSctVqGqjPwRG6qAuzw
 Y1xcKW2cYvToDQdDJP1RditZhJgNCiWPrcsTzZOKKJ6UHHX81FKfxT6T/SRatnr6Bmy3IDl81
 DQfmnbC01IhIYf98qwGMMNYe2z+WACjbIU6nFgxINEKus5kpgTqOGxKZNazqAUfcEopG19nW3
 QDH5Big6FNQ7yBoKAET/rpSantQ+mM4o30IGSw2Tu9FUH6/XVHSgkMCTa+f8eq7MKfRwZJRP6
 v9ljM5OaHccVID10QbUm12sZnpXbfJB1obOnKl+IFssOMx64t0UcuVclJZiI4SCsAWIhlSMB4
 02UBw42bj8jq/BWSPDyWP96fwUR9LDmp8UvTIGIyz9RlNMab8XFfD2K6yMg8nH1tZQ+h76YWy
 KBFw+E6YECe6pSnd845YWd0IgxEysf+NSKUJ7bmUBzEMOkgqik+l3t5opn2r4nhyB8EAhfMYn
 3MrLfttvACmThP/yJ8NMuL+uL6SFEP/bq15dUsrzEYP+WsVnO/89+5wGdfPlapThCf2Xgya3w
 9bxuA8/m+XwIE3WDkKH3HpjpI0N9m3xVsecPNPzGD+/rojl9VONA7EWYzHAts5JRNW/IHSpuj
 cgFQ/wpWg6NSMEQLb/+F3szAETsWfCfXyKUFZlzOT2l64=



=E5=9C=A8 2024/6/5 01:24, Josef Bacik =E5=86=99=E9=81=93:
> On Tue, Jun 04, 2024 at 03:30:00PM +0930, Qu Wenruo wrote:
>> The test case always fail in my VM, with the following error:
>>
>>   $ sudo TEST=3D038\* make test-misc
>>      [TEST]   misc-tests.sh
>>      [TEST/misc]   038-backup-root-corruption
>>   Backup 2 not overwritten
>>   test failed for case 038-backup-root-corruption
>>
>> After more debugging, the it turns out that there is nothing wrong
>> except the final check:
>>
>>   [ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 no=
t overwritten"
>>
>> The _fail() is only triggered if the previous check returns false, whic=
h
>> is completely the opposite.
>>
>> In fact the "[ check ] || _fail" pattern is the worst thing in the bash
>> world, super easy to cause the opposite check condition.
>>
>
> Except we do this all of the time, we should be used to it by now.

Well that's true, but at the same time when one see such line, it will
takes more time to fully understand the check.

Thus that's why I hate such line, it takes me over 15 min to find out
that everything is fine, except the last line.

So I really hope no new comers would spend their time to fall into the
same hole.

>
>> Fix it by use a proper "if []; then fi" block, and since we're here als=
o
>> update the error message to use the newest slot number instead.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/misc-tests/038-backup-root-corruption/test.sh | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/test=
s/misc-tests/038-backup-root-corruption/test.sh
>> index 9be0cee36239..0f97577849cc 100755
>> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
>> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
>> @@ -61,4 +61,6 @@ main_root_ptr=3D$(dump_super | awk '/^root\t/{print $=
2}')
>>   slot_num=3D$(( ($slot_num + 1) % 4 ))
>>   backup_new_root_ptr=3D$(dump_super | grep -A1 "backup $slot_num" | gr=
ep backup_tree_root | awk '{print $2}')
>>
>> -[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not=
 overwritten"
>> +if [ "$main_root_ptr" -ne "$backup_new_root_ptr" ]; then
>> +	_fail "Backup ${slot_num} not overwritten"
>
> Don't we prefer just "$slot_num"?  I feel like I've gotten yelld at for =
this
> before.  Just change the existing thing to be correct

I thought we prefer ${} to be more safe, but since it's followed by a
space, it should be no difference.

I'll update the patch for more debugging, since on CI it fails (not sure
if it's kernel or something else), but I'm afraid the "if [] then; fi"
would be kept.

Thanks,
Qu
>
> [ "$main_root_ptr" -eq "$backup_new_root_ptr" ] || _fail "Backup $slot_n=
um not overwritten"
>
> Thanks,
>
> Josef
>

