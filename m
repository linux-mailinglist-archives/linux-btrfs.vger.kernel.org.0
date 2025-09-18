Return-Path: <linux-btrfs+bounces-16911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C92B82969
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 03:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2CD4A50EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73E23C38C;
	Thu, 18 Sep 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="W4W6oU+T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7823BD01
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160528; cv=none; b=O3Q0FBi11s43rqXdWU1oWJoYNKUiuovB3ps0pquCKAhSmBM6t0VH/NKw7Tn9Pt7pLVxJXsXU//h9Wa/8/E6AjYoO4hhDXyGLdLqXDb6d67uQRf3T52efTfl+/vH6Lqm7+ZWARv2e0hO0+4cqhZX3H51V06NQOCVP3aIgd3uperU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160528; c=relaxed/simple;
	bh=88u80AZeBiPfheQSh/BYHuu4/NopV1conJJyNvB3tE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6oI1ZLwsgk9eiije9Lg83/sxatZticF++eW+Wba7eAdJkAvyDx7fHs1+XRAV3kJGGrq6DQWXkYn9Nl8Qq/cbir7V1PKUaWRDRwauD1EBICNkddbTAHO6Pt/oIGLNX+GOKigSHRAz+O2hgGFi2DuYkpcW6t8mxE4yo5grRaQuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=W4W6oU+T; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1758160498;
	bh=Bs6TB7rbIOM7PcpxnaEq9ldBGByOL3az3NbK3gX/C4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=W4W6oU+T9+HbzVn+NWxEMkr06pQTIJgYMXK1cj8vctS52T4scU46yt7XCCOdibOZb
	 etMCKG06CxUZQGkmHfbqvPOLnC1xZnUqgK/9WjkzTaZNv00oAR/yvhWqIE2sYVij9C
	 yeoJ4Ap8ckiuuP9mpPM0va6F4fuAqHBNt9bN2cMI=
X-QQ-mid: zesmtpsz3t1758160492td4220e47
X-QQ-Originating-IP: t5Qhc3nL7BTP26yPQF8RqotW5U/dNkA8elvU/nM4DQA=
Received: from [198.18.0.1] ( [123.134.104.63])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Sep 2025 09:54:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10581934576532113467
Message-ID: <1350529CBB385708+9801e76a-3fab-4069-a947-1b847c64dbef@bupt.moe>
Date: Thu, 18 Sep 2025 09:54:53 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: performance issue when using zoned.
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
 <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
 <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
 <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
 <b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
 <tencent_29ACBA272F8BC2BE2BCCB091@qq.com>
 <c3260c71-10bf-4315-8cb6-f42933c12b55@wdc.com>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <c3260c71-10bf-4315-8cb6-f42933c12b55@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MjwVM+RCn0CzO80XmJmtkIqMPiZLZ6YBm6rQa4deKJ5EZjvZkTczLaGr
	ChCsSjI7P6Y5WCFXMDUxUALOtlWVPpUU5fIAwp4X4vjYzuFAEDUZzcmJ8X+ePMyGp1iFofS
	uz2Bgy7+2DUxWfHzpVMsbl+oKudSi6ZsVYFUE9eaX9vHhB+FF5KQLp74DqgZlbSbYn4wYkv
	+hsZ0whGEa0CbIx7w0Yl4ydxslx7Ma+c65wX/9+4FcpiyG89KS0U5+r4nW9LP69u8LQUgbD
	vdFS5q9s/jCA/JQGFpLg9jpW/ZmWZoKpBcW667rTdEcdBsbOgSqv/vIgMSDmHhesc7s6MdU
	1bsaTLP4u1lDTuNQQddJT/max1zLZIbms3cYKLdICS3uR60IuslbFEX0LyM9CFvmccts3Qh
	InD0wkJJUu+b3GIPHcP5GAInD2dql9mvI7+NlKmZSrqmFWUzbN2So892zsy7HbGdNowqdSB
	CtiMyAVIiatp7CfA4qZC1oN00Jy/J9TSl0UHku5UDAv+I2HkLcNp0gOeYoBq6JPlppkQneF
	LOrqk3znCo/frVcRuZsVIMnDD9pqOA8f80GNEzskKM1UK776WKE0BuffmCp8+a4y2nsd3yn
	WY2FPaUxmjpjXG/H333/PRq8WE7HfM+6V42+iLPEPnzk61KRe4RsG1lwUdxkBXtoGDwYDXX
	ne0ici92Gxz3W8VYSZMe//oAFjroDuK/8JxTSwMWv+eSmmahHt4m8qWDHgfsBEi0oaT49wI
	S5oCeXqh410SOGrgJFqcHaKE3RInNrWjs2l0B3Z8XGR2jQK8zn7WwtZuH7UlDJbXMpzTdrO
	BoJJ4roBaaqaosaeEVreMuk/uM+KbztCHNcZkYbC4m8xtPKHd/CjfM0C6ppJPACYidF2gg+
	yYkSoAqgx0RmgIJ0I0a3/Mc2hHsTm2yN6caPLB57OLJIBzyE3yH4ftKnZUOHlN1VzXJU1Zj
	E6GZPeFWjO+j4851I2mpzeRur
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

在 2025/9/17 23:48, Johannes Thumshirn 写道:
> On 9/17/25 10:28 AM, HAN Yuwei wrote:
>>> On 9/17/25 6:20 AM, HAN Yuwei wrote:
>>>>> Can you try attached (untested) patch?
>>>> [   18.935640] BTRFS error (device sdc): zoned: 39020 active zones on /dev/sdc exceeds max_active_zones 128
>>>> [   18.937335] BTRFS error (device sdc): zoned: failed to read device zone info: -5
>>>> [   18.957042] BTRFS error (device sdc): open_ctree failed: -5
>>>> [   19.037902] BTRFS error (device sdd): zoned: 31419 active zones on /dev/sdd exceeds max_active_zones 128
>>>> [   19.040650] BTRFS error (device sdd): zoned: failed to read device zone info: -5
>>>> [   19.060349] BTRFS error (device sdd): open_ctree failed: -5
>>>> Seems still rejecting mount existing volume.
>>> Ok next try attached.
>> still unable to mount.  I added a dmesg line to output these variables.
>>
>> [  308.351272] Btrfs loaded, experimental=on, debug=on, assert=on, zoned=yes, fsverity=yes
>> [  312.379478] BTRFS: device label DATA4 devid 1 transid 7830 /dev/sdc (8:32) scanned by mount (3163)
>> [  312.383098] BTRFS info (device sdc): first mount of filesystem 2662c5a3-eac0-477a-a82a-b298a16dae02
>> [  312.383122] BTRFS info (device sdc): using crc32c (crc32c-lib) checksum algorithm
>> [  313.327698] BTRFS error (device sdc): zoned: 39020 active zones on /dev/sdc exceeds max_active_zones 128
>> [  313.327745] BTRFS error (device sdc): zoned: bdev_max_active_zones: 0 bdev_max_open_zones :128
>> [  313.327931] BTRFS error (device sdc): zoned: failed to read device zone info: -5
>> [  313.344515] BTRFS error (device sdc): open_ctree failed: -5
>> [  313.355690] BTRFS: device label DATA2 devid 1 transid 12067 /dev/sdd (8:48) scanned by mount (3163)
>> [  313.358828] BTRFS info (device sdd): first mount of filesystem 6a75f34b-1b2e-40f5-87ef-d83d980148b8
>> [  313.358844] BTRFS info (device sdd): using crc32c (crc32c-lib) checksum algorithm
>> [  314.175037] BTRFS error (device sdd): zoned: 31419 active zones on /dev/sdd exceeds max_active_zones 128
>> [  314.175106] BTRFS error (device sdd): zoned: bdev_max_active_zones: 0 bdev_max_open_zones :128
>> [  314.175326] BTRFS error (device sdd): zoned: failed to read device zone info: -5
>> [  314.200332] BTRFS error (device sdd): open_ctree failed: -5
> Ah ok, so this is a bit different from what I've thought.
> 
> It isn't that your device is reporting max_open_zones as 0 but 128
> (which is the BTRFS default as well so I got the wrong impression).
> 
> The quick hack would be to ignore the max_active setting in this case.
> This should make your device being mountable again and we can have a fix
> for the next -rc.
> 
> The real fix (but a bit more involved) will be to finish all zones above
> max_active/max_open and eventually balance them to reclaim the half
> written zones.
> 
> Please find the patch attached. I'll send a formal one once it works
> successful.

applied this patch only on 6.17.0-rc6 and got successfully mounted, but 
after initial 170MiB/s speed, it keeps at steady ~30MiB/s using "cp -r". 
And what I copied is all "big files" (300MiB~6GiB) so there shouldn't be 
any IOPS issue.

Also, these is my machine's spec. if needed:
Linux dist.: Arch linux
CPU: AMD Ryzen 5 3400G @ 3.7GHz
GPU: AMD Radeon Vage 11 (Integrated GPU)
Memory: 16GiB 2666
Disks: WDC HC620 (HSH721414ALN6M0) fw ver:T108 Power On Hours:26729

Is there any performance metrics I can collect for investigating?


