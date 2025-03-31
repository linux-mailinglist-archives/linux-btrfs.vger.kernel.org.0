Return-Path: <linux-btrfs+bounces-12697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A97A76FF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 23:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C261671C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7321C184;
	Mon, 31 Mar 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q8FbJJ2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FCF7080D;
	Mon, 31 Mar 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455651; cv=none; b=BSZ1208/A9zqRx0tM7TEzeY84mbudY8fA+hXfXpv1zxAEgWqsRPna8NX6JPiXbvy8dsmWvHjQKkd66HC5oc/AFxfZ/aZbu9kelSKGRz/JfaVGCAIZeriMOZttux2Da5qFw+eeyz2GQrUiyKwb5u1Mi8//PKYoit44LPfjBQ2Ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455651; c=relaxed/simple;
	bh=hMQSMUh44erp4N8q6IyW/OEe5dQ0e24JRgxyticPm3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGEiwruhNqHfxmBrQyI8wgGpZU9a4a++039TGEAQp45/weYN6hJ/UMfaJAsK9fPYaDvRWsYUNBsm+VUt+IR2wBiSNU8xFiYoDWG/Qd8H92QhiP6LpfbFTl68LJN/3BV14IdrK+yAHIHX8vqwEpTrHkjkiCD6SQx6xIhVzRsMDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=q8FbJJ2U; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743455646; x=1744060446; i=quwenruo.btrfs@gmx.com;
	bh=Uso56pb8SuJXJToitq1Sfh07PwWrBACFK0dG374DTk4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q8FbJJ2UfY4cmIwgU9PRtc2lIKi8FKBWD62DAPlGgVSBvUTVLksPbKi8y/oBT/OF
	 /MvjYtWEC1fjqoIjWAEbRLAZuSgdChXIT3Hr/bckyaYfmFfC2K08Wv9dU5yehAsl1
	 1bwI9pWFJ20+8Q+72BR3726k2bBkmga+u9SPbbSZ12I7JU62+NwaowHeNVNbBbG/l
	 dvdNDAqGk/bQLT5mQiyUtCBXj455y+PiwWadCkAmzPot4xFlTerbHtIkJ3jKub6iu
	 MGPdTruiGoX59x1xUqFnepJs/3SdRd4jxx9AECzdcAu0VBkKKQZ+D+Fk2qQhUlIDp
	 6RaC731SSpv0Ofh0Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1tbIAA03lA-00LO1K; Mon, 31
 Mar 2025 23:14:06 +0200
Message-ID: <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
Date: Tue, 1 Apr 2025 07:44:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
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
In-Reply-To: <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wyx1ID2SLyDtKGYljXxoQ4MsjwjnTHtepavDI4MKCE8h/yCJYEP
 TKJsHqtwjUlf9+ZyGRMEua1vyg7u8allsbi/G6M1naWFvewEAbkDdmq4xJhiraZCjfh/pdk
 xaAXxHCFJfB1d8tO0qA5RKSqr50gsmqnE3yB2BTqqW8fwGSw/rj0KAqPUYMAWrovuAXPZNa
 qC1ixGSzS8V63L0doP47Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GUz/ptwjjPw=;LCFY6SXiqxR/zNFzbS/PXjWpnTh
 bkQdCjL3vos4cMu1EONFTcf7sU8CLI0EXpaGXjTgNLEPscIRPdAH4rZw/tQFzazfRTri0uzCs
 aVhphBdmG24PryrKr7CeFd/JyYVYq9sxxwoxR2zinSP4vNjWYE5wOl5JgtR8uJGih8TbZgnuv
 QaK13KqAOYjI7yCPWStdkzdc8Uqv8yl6SvZ4x9gef9Jd9kGro/xsexGzKnW/ZqYNXXTUFtZJi
 m5ll0n2dxsUI2UKTXOxKk58Bg4B6R5q3tUBDTUOJIgkHksJkNjG+SQxh062moyNeWbl/HcuXU
 hRDKnXNEd9GXyohBik7fw1TZdgAFb40SKhJzWOvXwexuJXiNbOFdvaEAvCoVPjxA6N240Lrjw
 tYQsxPFSFlab3N1bWh9B0W2uB/60e3ulikbLKH+H7hmP9NsW87XH4l+S7gimu/0e3M93NXlR7
 5mqXGcbFoCQ1RTIZ7xwZ38JhWlOrpCImVHVljlFwGHZWwcPYQmI5I6+yEodl6Po6RCY2X2j/D
 /iaXPqeZ4yL95Gvpx5YOmWiqak6NSxZiB2tvmRhmI56aQW1oq8rXj0DOPCobbX8wpbNB00qUo
 zLztBPRauFEieidjpoiH8lAP8Zpovy52ZczwfIuWEQh5JZsvFogubCDpNs3cR2VX//pvYz43Q
 UUfFMn/UFaanU8CZWS8Tf+agyG4edJuuwjY1qmIpPpvRoCsYaypfgA7HjF38oooQv04sfPVcq
 3vAMY2diNonG0b/Nbx0krkV0xfgWKXIe5WezTbTkgk/bWrnnnwDZDBNhk4a8HIQqJC3v8FGO7
 EuVDI1HcKQhcjnaWhYZXB3TFUxzgkicVL1X7qYVfEOCQwWtyAPfggAB2srokgVbbKVLycXwnA
 DaApJNh+rL5ufD23br3ryvQJGQFAAOA5VvIerw++etZGxuaHi+Z1cpYECITk2IfqJ9Eo+9P+c
 Xpu+Xzi3M4dxZdr1mKV7wWf2Dcp+B04PvozoJWsrYG7mkfWPHK8f/yP3zRSFkHLTCmE8fjo5i
 GPNsFF6jaysjgI9Me+v8W3J6mJ3PuNj+zWqIJzS9cpaIRXLGsoAjeRNbZFZk3okV0LEMkQeTa
 U3MOiZmMSfQfgKIpcEuybXgd7HcWuMudc1LpKPE6QMKv8AbKfN4CHOeIEn0AS1rZ/hG/q1+xs
 ZMtDPdRlCBDuhhZLKWk+Zgz5BfCZ/XMzJWktkSeWthbQerbeCxjC4q48nxihqNMdSzvbe0Jf7
 0w3G2qN2OrJrwNMuuJY4JKGWaBMYpdBFpZBqi/IpbaMD2LWla7txnhkIPPwnh0JIOSH4/OaJ9
 1wOTnHeW2l6FB3j0bugRPDYwgBhV9Jq0B+P861bN3+YJC1bTe1T0nOBm8t0RZ6B5VnTJj256v
 Poukc5u5FsMzDfVarDQ82VcXIfeB4RCc6ORhe1Z/GBaeCgQ7VffrQFTd+yJWlKHo0puUkVqCE
 KKXrIfg==



=E5=9C=A8 2025/3/31 20:36, Daniel Vacek =E5=86=99=E9=81=93:
[...]
>>>                        btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>                        btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>                        btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>> +             } else if (strncmp(param->string, "zstd-fast", 9) =3D=3D=
 0) {
>>> +                     ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
>>> +                     ctx->compress_level =3D
>>> +                             -btrfs_compress_str2level(BTRFS_COMPRESS=
_ZSTD,
>>> +                                                       param->string =
+ 9
>>
>> Can we just use some temporary variable to save the return value of
>> btrfs_compress_str2level()?
>
> I don't see any added value. Isn't `ctx->compress_level` temporary
> enough at this point? Note that the FS is not mounted yet so there's
> no other consumer of `ctx`.
>
> Or did you mean just for readability?

Doing all the same checks and flipping the sign of ctx->compress_level
is already cursed to me.

Isn't something like this easier to understand?

	level =3D btrfs_compress_str2level();
	if (level > 0)
		ctx->compress_level =3D -level;
	else
		ctx->compress_level =3D level;

>
>> );
>>> +                     if (ctx->compress_level > 0)
>>> +                             ctx->compress_level =3D -ctx->compress_l=
evel;
>>
>> This also means, if we pass something like "compress=3Dzstd-fast:-9", i=
t
>> will still set the level to the correct -9.
>>
>> Not some weird double negative, which is good.
>>
>> But I'm also wondering, should we even allow minus value for "zstd-fast=
".
>
> It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` still
> works the same. Hence it defines that "fast level -3 <=3D=3D=3D> fast le=
vel
> 3" (which is still level -3 in internal zstd representation).
> So if you mounted `compress=3Dzstd-fast:-9` it's understood you actually
> meant `compress=3Dzstd-fast:9` in the same way as if you did
> `compress=3Dzstd:-9`.
>
> I thought this was solid. Or would you rather bail out with -EINVAL?

I prefer to bail out with -EINVAL, but it's only my personal choice.

You'd better wait for feedbacks from other people.

Thanks,
Qu>
>>> +                     btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>> +                     btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>> +                     btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>>                } else if (strncmp(param->string, "zstd", 4) =3D=3D 0) =
{
>>>                        ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
>>>                        ctx->compress_level =3D
>>
>> Another thing is, if we want to prefer using zstd-fast:9 other than
>> zstd:-9, should we also change our compress handling in
>> btrfs_show_options() to show zstd-fast:9 instead?
>
> At this point it's not about preference but about compatibility. I
> actually tested changing this but as a side-effect it also had an
> influence on `btrfs.compression` xattr (our `compression` property)
> which is rather an incompatible on-disk format change. Hence I falled
> back keeping it simple. Showing `zstd:-9` is still a valid output.
>
> --nX
>
>> Thanks,
>> Qu
>


