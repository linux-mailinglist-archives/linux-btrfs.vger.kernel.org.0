Return-Path: <linux-btrfs+bounces-7617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B020962843
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B256BB221C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1333188003;
	Wed, 28 Aug 2024 13:08:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF7167D98
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850516; cv=none; b=FU5Tp+eQW1/4SE76OTYRLV+jZuKaanjDMH3WhjvvBXvzpJnXuO1xp5hrb7eFqvY+GCWtDoM6w6gHVIgIpwlbdzUl8xE/ygr8OXxwmFyOxwPUkIZYZ2VBq86ZvTKyciaY6MXidfrRgJRgGZ64N7CZCesoQe8suBp2wEvD1cmaLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850516; c=relaxed/simple;
	bh=Y7bzSuUD/3RkXrEZlRqSite5c3G1gSCYzekpQk7jeQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=atM1R3V8JtXlTGbZwfaEF5MLr6dyqFq3g90tVHGWaceIvltb2VNjNRmyJef+6PVsjH3q4jlfpcudbJxCoZkTvKyqW8opcNj2ry6e6MT9k51A1x55EYmmSp0ebPcRaUKjepUZJ+bNh0bEmNtXyhbivwqF584J1ZP2qf08N1gbAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wv4TB5wC2zyQfQ;
	Wed, 28 Aug 2024 21:07:42 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 67390180105;
	Wed, 28 Aug 2024 21:08:31 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 28 Aug 2024 21:08:30 +0800
Message-ID: <2a0a26e9-ae51-4e69-aa84-30681dc6284f@huawei.com>
Date: Wed, 28 Aug 2024 21:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH -next 00/14] btrfs: Cleaned up folio->page
 conversion
To: Josef Bacik <josef@toxicpanda.com>
CC: <willy@infradead.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<clm@fb.com>, <terrelln@fb.com>, <dsterba@suse.com>,
	<linux-btrfs@vger.kernel.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240823195051.GD2237731@perftesting> <20240823211522.GA2305223@perftesting>
 <20240826140818.GA2393039@perftesting>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240826140818.GA2393039@perftesting>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500014.china.huawei.com (7.185.36.63) To
 kwepemd500012.china.huawei.com (7.221.188.25)



在 2024/8/26 22:08, Josef Bacik 写道:
> On Fri, Aug 23, 2024 at 05:15:22PM -0400, Josef Bacik wrote:
>> On Fri, Aug 23, 2024 at 03:50:51PM -0400, Josef Bacik wrote:
>>> On Thu, Aug 22, 2024 at 09:37:00AM +0800, Li Zetao wrote:
>>>> Hi all,
>>>>
>>>> In btrfs, because there are some interfaces that do not use folio,
>>>> there is page-folio-page mutual conversion. This patch set should
>>>> clean up folio-page conversion as much as possible and use folio
>>>> directly to reduce invalid conversions.
>>>>
>>>> This patch set starts with the rectification of function parameters,
>>>> using folio as parameters directly. And some of those functions have
>>>> already been converted to folio internally, so this part has little
>>>> impact.
>>>>
>>>> I have tested with fsstress more than 10 hours, and no problems were
>>>> found. For the convenience of reviewing, I try my best to only modify
>>>> a single interface in each patch.
>>>>
>>>> Josef also worked on converting pages to folios, and this patch set was
>>>> inspired by him:
>>>> https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/
>>>>
>>>
>>> This looks good, I'm running it through the CI.  If that comes out clean then
>>> I'll put my reviewed-by on it and push it to our for-next branch.  The CI run
>>> can be seen here
>>>
>>> https://github.com/btrfs/linux/actions/runs/10531503734
>>>
>>
>> Looks like the compression stuff panic'ed, the run has to finish before it
>> collects the dmesg so IDK where it failed yet, but I'd go over the compression
>> stuff again to see if you can spot it.  When the whole run finishes there will
>> be test artifacts you can get to.  If you don't have permissions (I honestly
>> don't know how the artifacts permission stuff works) then no worries, I'll grab
>> it in the morning and send you the test and dmesg of what fell over.  Thanks,
>>
> 
> They all fell over, so I suggest running fstests against your series before you
> resend.  btrfs/069 paniced on one machine, btrfs/060 paniced on one machine.
> None of the machines passsed without panicing.  Thanks,
> 
Thank you for your test. When btrfs/060 and btrfs/069 failed due to my 
carelessness, Dan has issued a patch[1] to fix it. After applying his 
patch, it was still found that 3 test cases reported errors. I reverted 
my patchset and the error still persists, so the errors may not be 
caused by my patch. Below is the test log:

   Failures: btrfs/012 btrfs/249 btrfs/284
   Failed 3 of 322 tests

My xfstests project is forked from https://github.com/kdave/xfstests.git

> Josef
> 

[1]: 
https://lore.kernel.org/linux-btrfs/20240827153739.GY25962@twin.jikos.cz/T/#m3f3e28dad05a9c8385a72f5503a5b9c130b44c04


Thanks,
Li Zetao.

