Return-Path: <linux-btrfs+bounces-7721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8930967F8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 08:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DA11C21E9E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07468155398;
	Mon,  2 Sep 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hLKVW//8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45314EC7D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258944; cv=none; b=m9/Qu+enN8dw7cyktrG+x8E7+yuAodJ+X9o7KWU+HH6azDDpSVmlTITbOqk7T1PKzo1PDVn1xe7TVgLUsq9qR0iNmXtoPg0OJqbHhf8RbPshkt0wMENE75jxOEdDT2YCD2cYElPqFy6Z4PkND7ucKPhNr1ZdfX4q79xYCQ3/qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258944; c=relaxed/simple;
	bh=BhkgMj0nwW4AuRV9wcDJXuDkHvsYVXFpHNxXlPEPSeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jz6kR+c8pSVcs+OFz1qjqLURxqXxwVoIE15snroqpZ35rh/46Ugc544Ls3Phw6yM0jGlBwNA1C8nLf1TrMo0mz+YVO8UDFTmQD8UcvVjqJUTQ9OwBbvepyCs8yHP32ocRol/XP6Z1PyVdtISORJjnC2Qm3ZFYa40BEJRAEjq8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hLKVW//8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725258879; x=1725863679; i=quwenruo.btrfs@gmx.com;
	bh=BhkgMj0nwW4AuRV9wcDJXuDkHvsYVXFpHNxXlPEPSeM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hLKVW//8FmLeI8e0vs+0B6cC9cKklQTbTdisqmvbg2OTClGXPBUWomVzLltq1CJu
	 OTxNNIQnJzNguCWrE4briEixNvGFDf/SPTQY+mENQ4Nf5YYnbyVstZkaq5yEFMnWP
	 gMVJZnxurgwU8BU3sGW5DVuyOOK3xhHDSfunOXf/bQlkSNhpS7l1NTPMG2rp9Of8n
	 mQCSPDba9DNmLL02n5akCLFTurL3C0ArRcSRl/aqW344zhDZw2wqfTFGWJshXidc2
	 nMjmnIpS8EI8VIQPGs0vcFD82FhVplH6xYLcZN6QfQIbr3IfmNYyqEwCMiczJKjhF
	 3Xma98F7G35a86RCOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeQr-1sY2Jx1qJH-00WDyS; Mon, 02
 Sep 2024 08:34:38 +0200
Message-ID: <609ec427-3a1a-42c8-9fd2-1d62ddcc56fc@gmx.com>
Date: Mon, 2 Sep 2024 16:04:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupt BTRFS can't be get into a consistent state
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
 <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
 <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
 <c70ac7be-c670-4b89-ae8c-bd34fb505997@gmx.com>
 <2a4a6f58-da36-456e-89b1-dde0a7b4f5ea@wiesinger.com>
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
In-Reply-To: <2a4a6f58-da36-456e-89b1-dde0a7b4f5ea@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jIRpo4JxC8oSxAglw2P9SYEyUEysUvUSv8xh6XC03glStEmNKRF
 55Ecq3tJMsc0kPsLW2vJwyXJd3aoKEP7Kxuw0wmwpVfHVybOQ+bhtlya1LMt+gUbGn1Gpag
 GmoeRRtAkPkklQictrhoxj9Fx3H6ye7T+mwoBkJft2OlfdUJkzRljaA68GmCTPoOE+iwyG7
 UI2fQVYvNtZEKWGNK5e1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s1yn4dzMn0c=;DODAVLgBG6yAQIOht6kSyoezo3R
 OxneLnHsDXLiVZY/wXzvt4+46zqMip55H2rvcjIKXktf86eSSVXI+U5Z5gmL5t2/WCdbm3Wcn
 Wdd9XgYZ7pgxG60Av2inPX7iq9UQrmMx8s6QUs+Im0f/LReQcVs+Kx6/OBxh1oHqHSQYyI/VM
 c7htvcRmY+9nLfnDHvdFBk8b9UAQJFE2KgtwYK3blVkgxqQRPCDdwGh9RaBMuGaBKaNk/kPfg
 V811N5zL65jOXeec2CrZnFBqxs5/fO1FF82vYfq6J0j7RhTiu9lpax/4EcGU4ivGluQz1r4Gt
 jGmp9eqZcsK7r7qj8ynSUBmn0FA9M1s45HwanR2zTIAHoEWoFmSdZv6xEgpHtvw2n/uLwkNVN
 Ky6spTTE9dQwVQmzkAykfvcS1+g1O7EeNvRGQfjWK1frHqAnmJVhBh03HtKF5J226yB5YODx1
 oypQ5fs7WxuWlmQzXz8Jo6ehHwfZHOuz4K05NLIgZJ9NK64H59PY14lSZ9i1Mk2oiASn1//Mn
 puzB4Y59oAeELGt8DnBJwGnQc9KoZmtS71Fnr2K/ThqGsJ6g2E1wsOuu/KMDPEGk/wk/p8dBk
 puQc7aVNquT7eMHzZniPSItrRheQt6cgrR/KY6HHf82AvaIatRroYTlPdFHRMZPdyRKOuNErp
 cMVzcCuHoCo8TCaBwHYY4BehZPmP5STfalEEdFQqRdWLaMv+ukCL4/equOT2Go1XaTrutyzsD
 gutKf7TMZs3pROGG16AyBclEhry8SwEACDQ0XCO67KPrqtjUCxUNRurUH0HwdlxVarPHHOR6q
 YR/OWPaoa7vTLi+fi8J5kLTA==



=E5=9C=A8 2024/9/2 15:54, Gerhard Wiesinger =E5=86=99=E9=81=93:
> On 02.09.2024 07:43, Qu Wenruo wrote:
[...]
>
>
> Send you full log file in a private E-mail.

The filenames is "after-repair". Any check before any repair attempt?

Still looks like one or more bad tree blocks.

Thanks,
Qu

