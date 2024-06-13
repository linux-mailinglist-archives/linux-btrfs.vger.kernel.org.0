Return-Path: <linux-btrfs+bounces-5719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD8907E11
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC6F1F22545
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC713DDAB;
	Thu, 13 Jun 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VPdepbs1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8B13A260
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313800; cv=none; b=S+AwyR3sJUry5CB1t0yGaAIcJajs/iMaMhPf5RusxddxxO+UTZ09RAJVwkP8FujpF3MRUdOLr0FiaZYvTy5mnJiczYF+kCPO3uWtPQCrdn9zNk41TGgqP8dRW6u8vd+ZuX848mmR+g6GPj/OXALUUuLKYlgb6GjnxyrE38cC75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313800; c=relaxed/simple;
	bh=kmxUmhlUziYgzUp41x18HZYeckiR1hWpU7Xr3vavVHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmyHWcDe2P4m4kJRIQxaf50TOWk/HkEtzlAm8x6AZ+N2F/esJluVzW/R0QpOkizo4nNvfdQgcklzsmb0p0rWHkzGdgnEmwGxaVftrfuExKD3DWiYPwEzKey4b3UhS3t3fB7ozvPvqMExzbSrXuN4lemIrGnxH0mtypz+HaBcvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VPdepbs1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718313795; x=1718918595; i=quwenruo.btrfs@gmx.com;
	bh=evvlYjIeYu77dlhIHmMu1dxTygVXOJc7pVgtO8XP8w8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VPdepbs1fWmelnFwzTuwktVW8/DwSZe0ewks46iW3voqRcSG/t1/M1Wdj1VzSmPH
	 jDoCe56s+oRQCm2Y7NVJjXcFKi5YXxayLGxR4ez0aEC2gcBLPLVabms+TDPmXUkrm
	 hhfqUi+2MMikYBHFDHj6EEDwJvXDc94tl5PxaAVMsy9KhkhrY9pFijvkDS0huBs2k
	 TFNInRfocHMhyYol10kJh+7+HV4tGgIaZ4OavzZPSp3LQcIyiJ+7jXvSt9l+wflvc
	 jbuSVFc9Jojiii18PHmtpld/D8V7F45pTlxEb16nATHdJOGk/6eOCo0uyQmtd0qxN
	 pf1izi49Ve0/EMa8BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1sKe8i188M-0060fw; Thu, 13
 Jun 2024 23:23:14 +0200
Message-ID: <997729f7-c772-423e-9556-88120521eb85@gmx.com>
Date: Fri, 14 Jun 2024 06:53:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: rescue= mount options enhancement to support
 interrupted csum conversion
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718082585.git.wqu@suse.com>
 <20240611164308.GA247672@perftesting>
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
In-Reply-To: <20240611164308.GA247672@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JwmDoYZPcWS8rMwwE0C8YfxFm/ENahoajWmhAWRWcRSFS+jwn+i
 cjcEK0fh4uu89maNvMMvBYsrqUf+6lw3LXFxXgXF04YQscjcc/ZN6CguiLfCylccGVdaJ+c
 2XO2t3dZqZuJ0PZ1cR+CA6rT5JYWkxCMnWOe6gJN1XVk8OvcQWVlOnxhGjjrbqANbIbTpAF
 qFjsNk/UqtPAHpkymMOwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HmBluIPUXhI=;LnhU/WXHUktX9im2+mVbmbru+m9
 D5tazxI090mmB3JnFnzVLggRWRA81+8LAghDWET/uooYvIhPUlVhulQ+V/+sDBg4bmH71N0jU
 6i2QDVjYxfIm43HhmhM7vjWBuWS+LeixrSEMdJhw95WqqkqtIrF7gMrTxg/iLdg5iJ1/Ek6Wx
 fD6j600pH98SNG2KHVigThpV3NJjOGgKYfOLvWh1Xdtl0WOy8IBHx8sDf/Rm2oRRK9PxF6wSG
 sfxAqro6ZdMOYffw/UgbduqcXTf7aegd/YxUomSZvmR2Ylfp9ZYf6JgFxyaCuw/rvIxKyP7LS
 GHCa0r2c+Pm1cJVDV7WuKbZtIdEVQnwQ/f+fFsAdBCvZGNyZU64u2jbQFfSU/xxTlmwcW8p4e
 JJGI5LxXQX5RW32IHderkdaLL3GtyHpN/EDHg5M50muIE44Knxr53bP5x+Fop5g9T6f0ehHLU
 x0YQkBrJacbEFGUy5b6d7di56dQuBsCq6+rk1lhZOXx2059lpcZEgE73PQA1Zu0lYKU02cJQQ
 giiDCicfMiXwIx+R73nBkfEfH9ipCvuDxPv1cJfC04HPZGFtWy/jUWOWcHc5NgpDL/zXC1/eA
 riJbt4UMeH6U2cOV7QDMucJjC5uYrHz/iqXHltFeCq/FMs8OmPR8ZWsca7lFR/leyovLCgxmA
 +JKGt9A9Eys8b/wyRCo97lwVtq6dnLIRcruS4srgw2gIGAul9hFTTwL/poInL61dg2UJLvQPX
 TtWVGJxNoTci/uRgNnopVo+rECqCdjU5YqoLrn8IHkIvXTBOoiBN+HPK2ykrM21W065qScuSC
 A+qgx8obBR17afMlOB1QRONN9t4bbIBxwb6+jy/F20wWI=



=E5=9C=A8 2024/6/12 02:13, Josef Bacik =E5=86=99=E9=81=93:
[...]
>>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Could you update the docs in btrfs-progs/wherever we're keeping the read=
thedocs
> stuff so that these new flags are documented?  Thanks,

Sure, I'll send out the btrfs-progs updates along with the updated patchse=
t.

Thanks,
Qu
>
> Josef
>

