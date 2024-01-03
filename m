Return-Path: <linux-btrfs+bounces-1202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3704823891
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 23:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BFAB25D4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB791EB20;
	Wed,  3 Jan 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c3k8XxT6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8BA1EB2D;
	Wed,  3 Jan 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704321943; x=1704926743; i=quwenruo.btrfs@gmx.com;
	bh=EDgxTo0FLjH3OkoFzC+N54DonGH0TW+FCVaMdGYN/0c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=c3k8XxT6Cw2+PRNS13wGZIUs+uEuqjcuRoP7rPPNqDIU5seGML7+MaO00qlGMIdy
	 KUje65j/s37hqwV/Lz3R2H9FrtiNeqF/FqNSsxPEn5AdmcqWZlxYG+8Rl9tOb1Q9E
	 iltAFxHSWLUF2s2YoPI5gLZPVVsZhvwrZU6sW0HVx4KCePGuddlB3cA3BP97tN97C
	 QMnLM+xULVY0e1Ym9K9KUCj5SjZJi9OBj/SeORUwkm2q/Cc2rRucrJ81S0JHpiU5n
	 EAVd+GClsXhFKmDMfEThZB8d9PicnSLOO4ALA877FzqmostK5dD3sFCzpwNhhHJCt
	 6p4nDqcdZsUKCNmMHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDhhN-1rT6Lx2iV5-00Ao0c; Wed, 03
 Jan 2024 23:45:43 +0100
Message-ID: <a5a65a27-07bb-4399-bf28-1c27f9af6fbf@gmx.com>
Date: Thu, 4 Jan 2024 09:15:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kstrtox: add unit tests for memparse_safe()
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
References: <cover.1704168510.git.wqu@suse.com>
 <a56def269d7885840a19a57aca0169891f5f0f32.1704168510.git.wqu@suse.com>
 <20240103011700.222b2b5c@echidna>
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
In-Reply-To: <20240103011700.222b2b5c@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4vLaBayf1ocErKF+QHCfgLyuKXoqiLXZf1FmDtqvwVtQGImjrp
 cdZ+LMuUqDfbC8GCnxMjMuMffc5ENaU4H6Rh05ZPRWdyAIPIeBWlaHqWQTm2DHl20GcEOIE
 eufqrI5IEgZqPAKFH+3Kzw3VzdqayjmERfrdUvvtacCzYEsal4aa0eAI754tkWE3thuE0lc
 ziMBLADhp+bxrSi7q3e8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1+0LOf5gIEk=;Jfk+oH4h12B7dYPmQgQGQM8/RSY
 KPW06GvwGTULDn8OiwtdOgrR9bXIF3Lx5aJMXUotUZVkucxU7ASw2IJSG2TgpRDOWGRSI0Vwe
 KBBRvsnBgHySvENES5iHBF/E8ojFufSxPy9gqP2faKh+9Z0Vaadyg/O9Rh9riDV0uDNGLux4I
 hvGwDpNoEwLxUqiXwEA1M+KpgJBv9frnDaHB9qBamZYCG0MsYuOM6xQlFPwpKkgbnZ5UiwXyt
 7SBO8Ac8FNtM1Na9q4uA6vR3Z5hJcDvWBl3t+6qA2ktI5mFCREtT6FgqTW4mpDVtb/4TP7nOx
 UWhr0KLbjssNFlasks3VGu7fgKNGLYXQxMAF0LIIkAur/Bwp1nQn+SSARbyaGOpHB+nmsuYDP
 QsR7pe0OTFWSxDsU+hYyEBH3ntwfOcOExVRNs8oHA9rw+M89pFqaaZFoynpmqwLMFaNq68xxA
 51uW9+C4cIcIOVRyCpCgeJpGTzYt7snwX30l2lDyyGSP5BNZoIFU6hiFYEX21HJBAAbP8G/NE
 sD6X17IqVDLhkMQGSirw1g1Ltmg+LuaHIMqpsEYiWPqCgp2+2mppA+SLfsH2oUQg7GFvCieeN
 u43xSppXkqkYHxC7FqVHK1lq5geU05z5l+t8WvFrskebYrMQfsDFSu4nF1oAIOGtIkNfdQURP
 MuKqrs2MBsAVV2xp+gCxcpu9kvWt7HHdYNfQfwXEB5lQtzoND6kdxUG5g5WJuFNu1ndLpn1oY
 skEDBoJ8u+bqF5fxajKgfvKEZL4i54r/vMCpGG9xrTAFPcRq6OqRekvZ09cbWkDRQ+C9BB9Xs
 tTxNYkwFWsOB1BPgx0pH/IEFawPVliDvDQKxpriSHeG3hQ8wxpp1pDY8/DTguGKtfSnVIhp/E
 lAi7RCrpnUAEun9KpJCrsqEoWlBd6NuelTX5P9oGj/DYb6p+j1DrmkZ+mvQGNyMvGsCV2wIln
 AtQPWH0qJwiXtQ9PA9EVcmlZndw=



On 2024/1/3 00:47, David Disseldorp wrote:
> On Tue,  2 Jan 2024 14:42:13 +1030, Qu Wenruo wrote:
>
[...]
>> +		{"P", -EINVAL},
>> +
>> +		/* Overflow in the string itself*/
>> +		{"18446744073709551616", -ERANGE},
>> +		{"02000000000000000000000", -ERANGE},
>> +		{"0x10000000000000000",	-ERANGE},
> nit:                                   ^ whitespace damage

Sorry, I didn't get the point here.

I checked the patch it's a single space.
Or I missed/screwed up something?

>> +
>> +		/*
[...]
>> +
>> +		/*
>> +		 * Finally one suffix then tailing chars, to test the @retptr
>> +		 * behavior.
>> +		 */
>> +		{"68k ",		69632,			3},
>> +		{"8MS",			8388608,		2},
>> +		{"0xaeGis",		0x2b80000000,		5},
>> +		{"0xaTx",		0xa0000000000,		4},
>> +		{"3E8",			0x3000000000000000,	2},
>
> In future it'd be good to get some coverage for non-MEMPARSE_TEST_SUFFIX
> use cases, e.g.:
>    /* supported suffix, but not provided with @suffixes */
>    {"7K", (MEMPARSE_SUFFIX_M |\
>            MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
>            MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E), 7, 1},

That's a great idea, since I'm still prepare a v3, it's not hard to add
it into v3.

Thanks,
Qu
>
>> +	};
>> +	unsigned int i;
>> +
>> +	for_each_test(i, tests) {
>> +		const struct memparse_test_ok *t =3D &tests[i];
>> +		unsigned long long tmp;
>> +		char *retptr;
>> +		int ret;
>> +
>> +		ret =3D memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &retptr);
>> +		if (ret !=3D 0) {
>> +			WARN(1, "str '%s', expected ret 0 got %d\n", t->str, ret);
>> +			continue;
>> +		}
>> +		if (tmp !=3D t->expected_value)
>> +			WARN(1, "str '%s' incorrect result, expected %llu got %llu",
>> +			     t->str, t->expected_value, tmp);
>> +		if (retptr !=3D t->str + t->retptr_off)
>> +			WARN(1, "str '%s' incorrect endptr, expected %u got %zu",
>> +			     t->str, t->retptr_off, retptr - t->str);
>> +	}
>> +}
>>   static void __init test_kstrtoll_fail(void)
>>   {
>>   	static DEFINE_TEST_FAIL(test_ll_fail) =3D {
>> @@ -710,6 +941,10 @@ static int __init test_kstrtox_init(void)
>>   	test_kstrtoll_ok();
>>   	test_kstrtoll_fail();
>>
>> +	test_memparse_safe_ok();
>> +	test_memparse_safe_fail();
>> +
>> +
> nit: whitespace ^
>
>>   	test_kstrtou64_ok();
>>   	test_kstrtou64_fail();
>>   	test_kstrtos64_ok();
>
> With Geert's comments addressed:
> Reviewed-by: David Disseldorp <ddiss@suse.de>
>

