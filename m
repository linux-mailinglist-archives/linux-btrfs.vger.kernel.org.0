Return-Path: <linux-btrfs+bounces-2087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B538084852A
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF987B2634D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334295D73C;
	Sat,  3 Feb 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="cOohjmJU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1F5D734
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Feb 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706955574; cv=none; b=RQmd97c+yrwYng2h2B9VRmNihS9BNZYHLcxLs//NsNpjEZ5htQhz7NyX6x1YoyYgIIy/fRyLu+Lb5QOzZp558UMbOleS9Sap6ZHAwI7x2fFR8pCKsIUjSP1DlZ6+wgxtQcbBU+y0TVtE38E1oQ3ILtVBBy8Akp4Iew6pWmQg0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706955574; c=relaxed/simple;
	bh=reY7chjoSxV+jH1YMP0l75BvPvJTD10fCWWCn6txpxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKOKme4cZ32zYqUaiIiq6fIGxojLJEP3094E1gewqzyat1hcLSBQ51FpijDgE70j5l44cL7lunzI2Jq1AVrLuzlWn/SV7BdUENdVj+PKxO2iekiY6J7+8loxOrkS+ZULvjx0QVT7O+ISv6/LKvxS9WHe5EfOopGyRVdkCEpLocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=cOohjmJU; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1706955567;
	bh=bWrnU/dg/OYPdRD7b7+b1eJzJK56GtRpq0rlti+8Hzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cOohjmJUjYvuPITCkDag2wBBU9CiyNSbfDOcJO8+l1CKQJNNQh8EGnYvt2wfT+/Uc
	 0ADMhzJznpMUqDEMaXKjMO50XonY8q9ngP0+nchZpgrtRILOMQbTb3nVtpsPkxL3Mj
	 CpHa64xTwS5vLlF/I5MvDWlYw42Dku7hp1BhsqVY=
X-QQ-mid: bizesmtpipv603t1706955489tpsr
X-QQ-Originating-IP: Llb6LFUJsTGHFl62xFagGm1svDJMZhkd4XzKyl8isRU=
Received: from [IPV6:240e:381:70b1:9300:e4c3:6 ( [255.159.17.4])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Feb 2024 18:18:08 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4P9A04rRMf6VepxcCSz7Vzft1BDCwPr6pSHSJmPM8u5WMq53lP/1
	MygqITmgdzQ1mv5+UcoyZQ5jPBbGtPpvK8idbUHNQb7k6HRfWG4ynG8ZuWuATVh7gss5TsW
	8SpiuzMYL3h5Gpmf8oCPjZI1x3MFERS/IenRw4Kvp/C/H2ZwK17pBOAcd01cOci9aSGeQf8
	mel1iVaF5gZVoNEWFQ4J5HBjxppbgsWIk7z8oJfTnkqtNtdNmEwGs1zzhQWMnFGjM2vjzyk
	k0mUjMiyi5kTX/PVIXdmo8RLK1a+EAV0h0yEs0YhaJBUU81VWzvZrdkULVRNwBdoqylDHFT
	LoK0zTHk7bT8gSstHXYJmd9gjD5B9DgwD0KNF2c
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17880903625146154224
Message-ID: <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
Date: Sat, 3 Feb 2024 18:18:09 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Content-Language: , en-US
In-Reply-To: <20240202121948.GA31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

When mkfs, I intentionally used "-s 4k" for better compatibility.
And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384, which 
should be ok.

btrfs-progs is 6.6.2-1, is this related?

在 2024/2/2 20:19, David Sterba 写道:
> On Fri, Feb 02, 2024 at 04:13:13PM +0800, 韩于惟 wrote:
>> Hi All,
>>
>> I have built a RAID1 volume on HC620 using kernel 6.7.2 with btrfs debug
>> enabled.
>>
>> Then I started BT download and sync, and it oops. dmesg in
>> https://fars.ee/N4pJ
> The system has 16K pages and uses a zoned device, this crashes in the
> end io write callback that does not seem to have subpage support:
>
> [ 1863.303324]    ra: ffff8000025364b0 end_bio_extent_writepage+0x110/0x220 [btrfs]
> [ 1863.303413]   ERA: ffff800002533464 btrfs_finish_ordered_extent+0x24/0xc0 [btrfs]
>
> [ 1863.303638] Call Trace:
> [ 1863.303639] [<ffff800002533464>] btrfs_finish_ordered_extent+0x24/0xc0 [btrfs]
> [ 1863.303736] [<ffff8000025364b0>] end_bio_extent_writepage+0x110/0x220 [btrfs]
> [ 1863.303831] [<ffff8000025d4510>] __btrfs_bio_end_io+0x50/0x80 [btrfs]
> [ 1863.303924] [<ffff8000025d5118>] btrfs_submit_chunk+0x378/0x620 [btrfs]
> [ 1863.304016] [<ffff8000025d5524>] btrfs_submit_bio+0x24/0x40 [btrfs]
> [ 1863.304109] [<ffff800002535628>] submit_one_bio+0x48/0x80 [btrfs]
> [ 1863.304204] [<ffff80000253a2bc>] extent_write_locked_range+0x31c/0x480 [btrfs]
> [ 1863.304298] [<ffff800002510dc8>] run_delalloc_cow+0x88/0x160 [btrfs]
> [ 1863.304393] [<ffff80000251186c>] btrfs_run_delalloc_range+0x10c/0x4c0 [btrfs]
> [ 1863.304486] [<ffff800002536d1c>] writepage_delalloc+0xbc/0x1e0 [btrfs]
> [ 1863.304579] [<ffff800002539874>] extent_write_cache_pages+0x274/0x7a0 [btrfs]
> [ 1863.304672] [<ffff80000253a4c4>] extent_writepages+0xa4/0x1a0 [btrfs]
> [ 1863.304765] [<900000000252ee14>] do_writepages+0x94/0x220
>


