Return-Path: <linux-btrfs+bounces-1419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2E82C660
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19490B23136
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FDD168C0;
	Fri, 12 Jan 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jFoSYmH2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E623C8
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705091602; x=1705696402; i=quwenruo.btrfs@gmx.com;
	bh=NxAwff9WboRuKpG/967gR+NGJ3DZsv8WJ4mdPH0dXME=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jFoSYmH22/3fekahjWjgo2S1ytBVT1ryfj59keB7wL1Rdd2vVPni+owXWCYXaeBZ
	 qFPyMZPSTVEtdDXXGE3O6q2FPF+f9UeEP4n3sH5vB1voph3JCkbsfkPGa8IYiTIyL
	 INJYR6m4CzMJl13C9dvXlt6l/kCs0afgLow75hSrqg6GqRoz1s6GRMySJ/2kosIeP
	 ldu6/Vcca9YKpgJkxqG8ETn20UGrgZ7D1YU+jX6tL8oRz6qwCJqTeonvakQaKyI9Z
	 ldoGpKDnvr3Lmqc5wIwBIh+yFuELpUIGltcwb8ZebhLvP4fOwk22DBDQRHsttqucG
	 QsFpu5K8G2N1vo/52w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1r9TlQ0W5K-00tobJ; Fri, 12
 Jan 2024 21:33:22 +0100
Message-ID: <7e908c1f-d14f-4562-ae1e-1431c091b140@gmx.com>
Date: Sat, 13 Jan 2024 07:03:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: tree-checker: dump the tree block when
 hitting an error
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
 <20240112153602.GP31555@twin.jikos.cz>
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
In-Reply-To: <20240112153602.GP31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c7OVIfT3oCIJ9dwrpmQSf3dy7zVNwTXOX1QAHSuOlXPYEqWOBAx
 u3Oz6qECyPfuSiOzbkiXmmZS4styRlwLdUBgdbzO6bl5Vf+unh7kZ2GorOkV6xgY/Vw2I2m
 ilgP6ofleuBD45MjpXE6KQtuFO3cIi/2xhPl5KJP60Jbqkt+Y1oqHVVr81l/b7oXl2doMCT
 a+iE49XWN8U34WBmDHx+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXlchq2cQeg=;LvAsozIONLSDxIwWU9Lu4LCilYm
 5dZoyttlQiBe4LXVd/n8ThvBHy91YfpInrQj8N5FYh4Y5VepXk53Ao/dn5N8yPsWGWM8sOY5C
 i+L8Uw1guYbhL9tiGeY/UhpUTa4xIKgtyoBScWeQHcaq4ysdLTejBX/Z9UHcSsVDpMB1swgLo
 fVBHlq7gl3emqibVHKV09qGooDVnlQLevlXVJKxF5ka8b1T2NvpNL6nnRb/aDCJu/pd1dnlmF
 BYZofiAAbTP0b0fnM7ceJogP/ndHIxNejuA+6nCyPHg/d6YmvccyoNWlMEgrGmSs4IEvZjKNU
 lB8/egKypBAH/5omOE0jZ1vI6PXEBU7//PCWaIXNQrqo7V2hBOy+z16eKaCW98DlqSwRsxPXZ
 BENE4ODax056OXFRnn1sI5Zn1l2j3AwMmfE6U1Yz5vxr8d2Lsd+VmKXUnBQIkhPN5PNyqifOh
 fRAtLOma6bErbPP2Q99AHfcK1z945/1U+leWt5tRgTk9DrzMKwcdN8dxORyQlu1YscfzHcvmV
 XrlHlf6zKvyvljZ4pgkpueR+GVS54/5wTnePLjitIa9LVry9frNiS8mQiC+WenxVvoOytGQm8
 L9CMEBa+ct6tD/MN62SjaxITX4vI3tdlrTKeRwcUleMQPL4kXHmNUxJQaIXLg0h0x934RT52d
 s3WRc/iU5Wt62lMvGzdNBprWSeIZoruL+GJLLdS+rwPphL0quhxXF8qj1Dtp1LNGnpzxWemHD
 ZZOVr9EoP61EWcwvLbADEKdSHQqSBWpksJFfwjB8nASPmo5pFEw3wjMTZgFDSkHLAaMMdEgfa
 5BSc7GqEHX93ofz7MggM/SWlzSfad35FRMPw66QWkLPigrXMyWU/WRiA7Y4rPsObZf85UBmts
 r9j/aui7g6JhD5a8ubU3jB/VrnfBi9/Qr8/9wcc5mGTts2bYJogruAIzPRJFwmgEaV7cWugxy
 1sZFVflsbEc/oNRLeIc71sOMaPU=



On 2024/1/13 02:06, David Sterba wrote:
> On Fri, Jan 12, 2024 at 01:16:20PM +1030, Qu Wenruo wrote:
>> Unlike kernel where tree-checker would provide enough info so later we
>> can use "btrfs inspect dump-tree" to catch the offending tree block, in
>> progs we may not even have a btrfs to start "btrfs inspect dump-tree".
>> E.g during btrfs-convert.
>>
>> To make later debug easier, let's call btrfs_print_tree() for every
>> error we hit inside tree-checker.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to devel, thanks.
>
>> ---
>>   kernel-shared/tree-checker.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.=
c
>> index 003156795a43..a98553985402 100644
>> --- a/kernel-shared/tree-checker.c
>> +++ b/kernel-shared/tree-checker.c
>> @@ -33,6 +33,7 @@
>>   #include "kernel-shared/accessors.h"
>>   #include "kernel-shared/file-item.h"
>>   #include "kernel-shared/extent_io.h"
>> +#include "kernel-shared/print-tree.h"
>>   #include "kernel-shared/uapi/btrfs.h"
>>   #include "kernel-shared/uapi/btrfs_tree.h"
>>   #include "common/internal.h"
>> @@ -95,6 +96,8 @@ static void generic_err(const struct extent_buffer *e=
b, int slot,
>>   		btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "node",
>>   		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot, &vaf);
>>   	va_end(args);
>> +
>> +	btrfs_print_tree((struct extent_buffer *)eb, 0);
>
> Printing the eb should not require writable eb, but there are many
> functions that would need to be converted to 'const' so the cas is OK
> for now but cleaning that up would be welcome.

I tried but failed.

Most of the call sites are fine to be constified, but there is a special
trap inside bfs_print_children(), where we call extent_buffer_get(),
which can never be called on a const eb pointer.

Thus that's why we are still using the ugly forced convert here.

Thanks,
Qu
>

