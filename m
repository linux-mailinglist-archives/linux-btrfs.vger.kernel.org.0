Return-Path: <linux-btrfs+bounces-3313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26087C453
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EA9B222F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73D763E3;
	Thu, 14 Mar 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RLPWb42e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E673539
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448354; cv=none; b=bZZH8CN2YR5OG2/rCktc2gk8kZJEaG+4xiGUh9CQehktq0OBDhiQraQHT+cA7GBd9MjLLvnTpNw30esXBDZU1e5vV/3Z3GQ6db4UepEXJuG/1Zlbf/tWjjbnOIibeLlfDiWJtqhbF9iWaMmueqjMKSbRq7Z6gFRXTYd2vUsikiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448354; c=relaxed/simple;
	bh=meYeCB8uKZP6PomYWp82+qFvScOBZsBTGaTXaorbQIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtVhUEaK/XsRUEulk2/KKE+JyIdf1RLg6xvkci6+k1WTwa4n0PExviqtB71F2wbHgPr77m06ImZIRlfdETLVZ8kuKYAw96UOPBHuF6Rv+yLNgnEnJIakSo3fPRrV7SJnOoTPFoUxax8X8UoIOtRwtICM8jNJ02xdhQI0SU7Kvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RLPWb42e; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710448346; x=1711053146; i=quwenruo.btrfs@gmx.com;
	bh=2BBgEu4J+qpmmJ8zzMSyxi7vcx7+97i1gT1OKxsSPY0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RLPWb42eTKS5AgMRbsYZQoECWvDNpJlMhJJDTHFD7DRS1MGP/so3pbcgKqvrGmXk
	 fwKGiBxokPQQKw+0JszwtI0iD5jQLdiO2gHIIzjBIYb4+grnry/XlgK5pQuBTj75H
	 fRUiuJy+1Na8MIWoCiqTiKmyk7Op6jBJJdsgHk1umQqQuBNK2QbxGD6vUqjzbekNN
	 30UQFqc7OVey9TtFQEpL0BGBiYqxHhJoeCSukObrJqmDueiBi1bcfXeeMbCfqBTSQ
	 8xErlRjY0fuc46cBRDqTYKAer2/nJy7zzU3cRU+8DzUIjG8vwT1ofmkNJlZNdDtb2
	 YNBoT+/RE5KXtQEimQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1rTk2Z2IT8-00JLQg; Thu, 14
 Mar 2024 21:32:26 +0100
Message-ID: <1d612afa-3332-4edb-b459-e6aef91445c2@gmx.com>
Date: Fri, 15 Mar 2024 07:02:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: scrub: fix the frequency of error messages
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <c46343633e6198f315876179d31b3a66b66a8aa2.1710409033.git.wqu@suse.com>
 <CAL3q7H7Tn87T=Qcmo2-nZR-jSeTw7ZPdZWbUN7AQARpGsQYyBw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7Tn87T=Qcmo2-nZR-jSeTw7ZPdZWbUN7AQARpGsQYyBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RDwpjbNzQv0eBgxiDpg/zChY0HXRDq8ulsHXlgaIJuo+qHDvTYl
 eKT32o1JxnGcIgGDnmASAmuYKPnxv087GCUEwIcrEt4brELrrolXyRZqWZN5b/PJovfk22+
 dg88JRzq2k/GDnXytOaxRprJy9mvd8lk/P/kqpcdi6/lfeYSS/N4vSNQzJpz1C9RddevMw0
 04uijyPu3gshP+7GysLOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GsTsQ7d+jGM=;0INXrRIF9gIvYVL5SDKl3KzKI0U
 2AEvI7SMcrFFXSJiSlWIiej5V3zKHkZJxANi/g2Ez15F0etnhJOJwITrEu0Yu4t/bAX/9vuIG
 LRYJ3MZEruqFz/kZPb7QPib8+CRYkBIURxVzmzcxfvd9V80PonIwMxSuS/O0yDq9r8rcD0Trd
 OG8mDaPwfKPCMAQwB025FHJnynxTIhFWe4pCLq2WRUBOlO0i2QX2QCIbsaWlhguXdhc7+15Xl
 PKQn/voRPkhZcbY2mHsnKE2W+eyJiRkPNejLVarFtXTY622FzV25qhrS8HWxt7VidOUB0O7Au
 uvLmsFUBKOeAzTLoX3RRetfb0TgxE2PMV9MbNegQorsi5NkAG0mXj8Ax0QpZq35oX00jijChe
 6uEBUFyc9rsDkhfok5B2jZ5v6UAWK/wO+rfjkrmQb4TBJLpc7HHjucgNTSKpJHsx/Ycmrrhmp
 XvBSZY39XyRMv6iQNUz5E0LK5rGMB9EotTVhBOjjw/IaIHnSOLLPJNwheKiVxa1clSRgDmzuZ
 zSWANmeRhFLy0dymw0bnePB4LXJpDYcBx2yaB5oL0Ml4TXG4SknUl0NXBoA8wlF+grjsdhzeh
 PD31zXHQqxB00rLJq4AGgeLPPU0FXQb+NrJdKym0v/npiFDPkcMdjySUakGE5G1A38Dzz7d22
 N9MQAPmqgEZjN2rcg+XTuWd3gZu9jv3u+DGUc3FAUJyrZq6Hl292EqFCkC8cIvgtIw2VqKHa8
 I3U14UyQmbRETgCn6gkc7Ysli5N8EcnIXk64dznqF+33r47mC3iazSAjYoa9oYMqy/Zt2ig7L
 uwBaJ9K+IvaQ0war8ILs7j19AZbmATpPsqULs2Cl+7H68=



=E5=9C=A8 2024/3/15 04:21, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> +               }
>
> No need for the curly braces here, it's a single statement, so we
> follow the style of dropping them.
>
>
>>          }
>> -
>>   out:
>>          btrfs_free_path(path);
>>   }
>> @@ -889,12 +905,6 @@ static void scrub_stripe_report_errors(struct scru=
b_ctx *sctx,
>>                  }
>>
>>                  /* The remaining are all for unrepaired. */
>> -               btrfs_err_rl_in_rcu(fs_info,
>> -       "unable to fixup (regular) error at logical %llu(%u) physical %=
llu(%s)%llu",
>> -                                           logical, stripe->mirror_num=
,
>> -                                           dev->devid, btrfs_dev_name(=
dev),
>> -                                           physical);
>> -
>
> This hunk seems unintentional?

This is intentional:

  - Remove the "unable to fixup" error message
   Since we have ensured at least one error message is outputted for each
   unrepairable corruption, there is no need for that fallback one.

Since we have ensured we would at least output one line for each
unrepaired corruption (before rate limit though), that line is duplicated.

Thanks,
Qu
>
> Thanks.
>
>>                  if (test_bit(sector_nr, &stripe->io_error_bitmap))
>>                          scrub_print_common_warning("i/o error", dev,
>>                                                       logical, physical=
,
>> --
>> 2.44.0
>>
>>
>

