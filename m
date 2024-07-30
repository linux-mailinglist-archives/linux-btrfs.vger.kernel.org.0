Return-Path: <linux-btrfs+bounces-6899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38050942253
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 23:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EB3B2359A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DD18E03F;
	Tue, 30 Jul 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uXQcWqxG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223E145FEF
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375693; cv=none; b=XyipBc9/s6tZNLC3KUVblLvGRA3vmfaZwgpRe3089OfTWp1B5IveYPuW77I7FV13+N13wvx1bXvITFi6y6NaPBPzG/M32U139clAgrB9NDf+S87xzlEZpu4biSey7fHXJnafoYeCcSxGexPwq4GzZnFTCDJocq2+taoXC1OUucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375693; c=relaxed/simple;
	bh=MXm8qW8sDBZpkLNqmt8DOYvdK2sXwBe3gnEIYRZU0b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=piV434rCUqwJ+Z+iw/9h1Tku56e7y4JfkVX4E48agGgWCxeyAfk3E7Haxw4ZOz08XHn0QLbu7SRn917GwkDJS+AtsnKwg6CNWX0IHqPEtt9REp5lD+gReAREwZDZi/uPM/dG66SCTGOyRSV98exh1biM9MVV+yTH5gxslT6pm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uXQcWqxG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722375658; x=1722980458; i=quwenruo.btrfs@gmx.com;
	bh=x2Girk0OdZTMh/kIMqKondg5wABVO4XTB0nMiZZpOzk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uXQcWqxGdF4p3hJwej1INhTAd7hcrvpuI/9XgAxUtwgylAdVVA/IVI90mZdlR/mX
	 Iuvt5j7IwDSVkqmhMQXQAwCRUy9SzJrCh/vrtDPoXgoduuJvuOz3Y289Qbgs5ZkXK
	 cXo1TOjzbgVZoUB8USwhHMyzIPP49qgBHyJ9bKZu3tx+MAq2YjRJkNwc487NgsIuW
	 LZRyCktVSDnwkse6WrL0D3TCiGJD9TM+CDEvsUPkghatv4J2lEOBRX/+k7F4oZRJC
	 m5Ad0pt9n4LLscfpiHLseLWlJ2NhozXAJ7T1snSzOGXmrH+6jUVSqWQeBf9gstdBK
	 UF1fKNuL40xTVRcFnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1sDolT0yjV-00wyr8; Tue, 30
 Jul 2024 23:40:58 +0200
Message-ID: <21c6a67f-620a-4133-a955-c5707618cff8@gmx.com>
Date: Wed, 31 Jul 2024 07:10:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240730142155.2154877-1-maharmstone@fb.com>
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
In-Reply-To: <20240730142155.2154877-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsZwpyjt7GWCwKOF4+61GTQzvBTYrvEJvlbUxdmLb3Sc4U0uCKJ
 i+DUQACSVny8Io4bczT98vCx+JExGetUcpGSkM2sqxaifN71JQV6ppq92K/c+t9zDO9gxiI
 aaRI8azXDyK/r3f5zJeHdnRDk+ljK+dki2pbjTFlM2zGMKrKYRSanxN+4yaB5BBsv+1g+6V
 YspU3lqVFWHA587jXQsSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vvhk06JJcIA=;XKExdOwxS+ggs6rZZUMs6hKd3En
 koPHS/RCInLPWKke8U7q7mvqmggqtSIQYER43/ua9tKn0N2dTSzyQBRQSGX/Xp+7Dxtz9ZXtA
 NT1QcQuOMtbyh7OicXfzZLR12dOoPpsh7nM4Fn0u2ZoyNmAXRDNnr8BnFklAA+3I6+/TAyRUz
 D5m7GS4fFPFk8WN4ztAanKeM/ah91qRR1PAWAq+SrF12IXjPXMs+h8LL5M+auCGX2TSQB7HcM
 rFywFiC9W92a37PJ+xvqQlt6pybP87AuyiHmyd7ojHl0kWjYknrlgAPgtWLUxDYW7pvIw01Ph
 1TSJ4cdbHD38rl1KFDmmxuGq5K96Nd6mevtNElVk2xZobzg1YbPKfqp5VkQeF1d0xI53rrnab
 NcfKH+AhUipFkeqR0FM0PgILdIB4T+r9VDnY/t2lkobn/X4bSkpcaD70AU9yZNv7+wx6x0//U
 7fvLqCbm0ugpDRf5ahfdaup/99R3VmTqkSTOjTjI9ysW3Oo2VY1cGBzcfpBGQqvi4gNFtqwC0
 I2B52Drp2CpTh/237APk1tpI/z6lgXWksjR9I9BhgikoILduOxCwRhJoC4xBTonueBpVFFgSa
 ARlT1a067LfSIeoiV+T7zqWcpL0CWBwrzhsRKBCjNbExWpEXI3bt41c18/DCQS49OC4KZtRf2
 okkqCst3KEEP0dKM06P2a9NiPRLWI6pvQKAiYJ+HBkosiWSK/Yx1RCx/XuKC/DoCOJM0BSoNN
 z12e9ZqpcWI7tKLGIJLPUWjVAeZ2KeBHsYyitlXrIRBC9/O8TevS5W5fMzmKIClIY0Ag8WifA
 S9RJJG+tJfTC2ZNm75G54wdQ==



=E5=9C=A8 2024/7/30 23:51, Mark Harmstone =E5=86=99=E9=81=93:
> This patch adds a --subvol option, which tells mkfs.btrfs to create the
> specified directories as subvolumes.
>
> Given a populated directory img, the command
>
> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol i=
mg/home/username /dev/loop0
>
> will create subvolumes usr and home within the FS root, and subvolume
> username within the home subvolume. It will fail if any of the
> directories do not yet exist.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
[...]
> @@ -570,6 +626,76 @@ static int traverse_directory(struct btrfs_trans_ha=
ndle *trans,
>   				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
>   			}
>
> +			if (S_ISDIR(st.st_mode)) {
> +				if (!strcmp(parent_dir_entry->dest_dir, "")) {
> +					strcpy(cur_dest, cur_file->d_name);
> +				} else {
> +					strcpy(cur_dest, parent_dir_entry->dest_dir);
> +					strcat(cur_dest, "/");
> +					strcat(cur_dest, cur_file->d_name);
> +				}
> +			}
> +
> +			if (!list_empty(subvols) && S_ISDIR(st.st_mode)) {
> +				struct rootdir_subvol *s;
> +				bool found =3D false;
> +
> +				list_for_each_entry(s, subvols, list) {
> +					if (!strcmp(cur_dest, s->destpath)) {
> +						found =3D true;
> +						break;
> +					}
> +				}
> +
> +				if (found) {

Although I'm still not a fan of merging subvolume creation now, before
we refactor the existing way of adding/linking new inodes, at least the
code style can be improved.

Under most case we prefer to reduce the indent by exiting early for
non-hit cases.

In this case, we prefer something like :

				if (!found)
					continue;
				/* do the subvolume add/link here */

Thanks,
Qu

