Return-Path: <linux-btrfs+bounces-8148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD597DA56
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77558B21F55
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4017C217;
	Fri, 20 Sep 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aoUZDTZR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCE168BE
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726869189; cv=none; b=XOmCXrxehTMYsrxT9JbH62SSkEP6ZKA++B0Z9xVZo7kBhJ8T/GmStCdRLTK8bpBaAyHgRwbK6cWTVHq64DKiBLikn/BB7knQQ8QsdvDoTkRpJEWEjRQxQHwEnlUlkKS5ub4zBj3hNEuNURd6mzrltDuDnY7gsTOIfLpE5fD+mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726869189; c=relaxed/simple;
	bh=KAWsMuwESyKKUrkkFOf4HjAezJRbEkq33mW3B2J6ZhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS/JtOxTsusTIdbKyp2oYjtvUv4aHrGiVv1ScIwpZNZMPPrVgZRA5FYH/W/Aj0AGhBsXCRfp5urSFid6QX3VmIuodvVUl7j6ULl+IZGdQ3ERv9JN0FoGIWv+h2+hw53q4is9BQ9DOW6wxF2zt6d7XqBVpGuT0HHjOioFu5S2j04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aoUZDTZR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726869181; x=1727473981; i=quwenruo.btrfs@gmx.com;
	bh=KAWsMuwESyKKUrkkFOf4HjAezJRbEkq33mW3B2J6ZhY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aoUZDTZR+jMPLhY/Xf3grLfgQM0F2kuk7P19kd9DjZ7o1lYQo8lAw7aft0uFOPzi
	 s6GGpMvC6VJYsBovwsy57gXNeEFvxMF86flsiqBF7YNP6/x0J1lZP//9xQgp5b62d
	 DG769X4T5CSQXjkdP+mKOyi5J+0/mxHYdotijWAdzzW2lL0sRK1ruED54b86Ajbgl
	 g0q8UTz/QESSwxv3UL2uxdeEKJZ6FFi0QUrqgECxT8JAv0/zGVOPL0cq60eHOw86L
	 uqXRcSLhkuuJ5+XzG61DOadLDZ6e1Bnd9NYEKI4YxNwacQW7MbFXdNJKEo17h5uG7
	 FTXKKZgUX6iZTcMVtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUowV-1sQzUr2vAX-00PcDi; Fri, 20
 Sep 2024 23:53:01 +0200
Message-ID: <e32715a9-a972-46a7-8d67-2ad531ab72d8@gmx.com>
Date: Sat, 21 Sep 2024 07:22:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: libbtrfsutil: fix the CI build failure which
 requires manual intervention
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <d148df614aef86dd6244dad3e0726750a3176b34.1726793990.git.wqu@suse.com>
 <cac5a710-63ab-469c-bfcc-327da82fa036@suse.com>
 <20240920142802.GD13599@twin.jikos.cz>
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
In-Reply-To: <20240920142802.GD13599@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j3MUijxTr08GbAzz/I9gqkZ6PldScPsFTw1xYcNaCcAhdL24i1u
 BuDviSv3tLdp20T44GnNI1zsttvx974fPG5dVDS/jPjEYaGyfOgNw2fgbXxUKKfL0w0PJjG
 mbfV56iuDgF5xtXz1m1ZFgCwtZZQRoQMqkoCkmqeFpL6zBJGWm7KTMa+gcW2r+UaAr2Jkd+
 2Q3BJsYI6FTbkc8U5mcuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VzohUJl9Fac=;sIrfTxTUJu821ljBaXpyGkv7Q3F
 yTUbA1Odoyls4XhE0WUZYQnG0SPel/Z6E9R3+uPWNR3fWiU4+0p/ZRL+V6106cyVpTtxOqk62
 xHaKUaR0dAmbip7FQfFd6DRPBc939pCBoJ786G69vTEhIiBwCd9biuWe0s5VnbUzD0eZIIJXu
 vjcWYMtpgWY6cm4aG9BGOPMId2+8GpYfzwnGV6mW12EOippDdtKs0cRUjVcsHayJpGoXqrOun
 OtJMi46Achc68WNgmSM+JU62gJgkgs8qL1LWn1fGfJ1VgSmjrOznzmV5plNhA+nDNsZsj69hj
 EkOye2epXR2JIk6oYfStfgGbwzZOtNkLAEeFY2+gdvAkIuFuBXO2O4oPudFiVEWIHsuITYRzI
 +ftp+UtEN+cvhMNxxJhWyXRw7sOYFkh2yzZPQjk+NK2orSFVY1kzecwf1o4v2OcbWabX/GbAb
 bYv+ujxVJao6B2BMUJigoAQ+m4eorfC+WcpxfSnomF2HU1PxBM7D0hS8cx6Is6HhXZKDNCD6C
 nO6W/1d7keyQETlm4rpkEI9oZz5Qd22cbjqoy8txRvR+EiJhfFqxFxlqpt3kWnmNyRdJZ02Vb
 LnH45kEuFtDRN7B+hYvCgBht0wPwHfrZ4LZ569VRE56DdKgs8IjZAMVgbuKzrLvfyWuM6svGk
 6nRshp8rj6DSLMZ+h5wrXi5ETiBDCEvDlArU9DU5tQIqW+fadNpmLDL2FYUw8twzOpwRAeG5M
 eKMXUbqlVkB4DZ/pcQAZAPWbOoe+WswhVkY2ljF4/iy+kDUS4aYlOJVV8Nd9kDMo8PPu67xsq
 ok7Ey1Tl8NIhNsBrNceXpO+Q==



=E5=9C=A8 2024/9/20 23:58, David Sterba =E5=86=99=E9=81=93:
> On Fri, Sep 20, 2024 at 02:04:50PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/20 10:29, Qu Wenruo =E5=86=99=E9=81=93:
>>> Currently the libbtrfsutil python binding requires `pypi-README.md` as=
 a
>>> temporary file to act as the longer description.
>>>
>>> But it requires the build to be run twice to generate the temporary
>>> file, preventing CI to properly build the package.
>>>
>>> Fix it by removing the exception raising, after copy_readme().
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Please discard this one.
>>
>> The offending patch shouldn't even be pushed to devel, introducing too
>> much hassles but doesn't even bother to resolve the self-introduced pro=
blem.
>
> I've removed the patch from devel again, the long description is for
> pypi.org so not critical right now, the versions can't be resubmitted so
> next opportunity is 6.11.1. Until then some solution will emerge.
>

I'll rebase the newer fix to a standalone patch to do the long
description correctly.

Thanks,
Qu

