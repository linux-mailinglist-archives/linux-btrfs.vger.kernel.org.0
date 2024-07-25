Return-Path: <linux-btrfs+bounces-6693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B37B93C341
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1241C213ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574943146;
	Thu, 25 Jul 2024 13:45:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13871DFD1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915150; cv=none; b=WYyy1TFbqNwhch/ue07Oajk2+tTNd5ucenRhytEPntNHRXJIDyQNZq7P0DFf5Uqbn0zgY0x1TzPs3hbG82qvpjVROtm5DHYcNSZLSIx58nR853tDTAmFnU7gxNi050YjG4iyairyoRvWLn6jGvQNjeweAw9zleyoMGRC1lQgTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915150; c=relaxed/simple;
	bh=rVpC02ZJcOttsE1pK2H5TS2WMM4Gx5Gx3eMNiVYO01I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c9lw+hWy7aNB4b6k4jTzrLrRLY2ChFcg+teR6Dztyzi9XhVQkZ59Gqb1PPI9zjoDzlsbllZNqqwwBeWQOwWl5PIJ6eNPinHWYutuqlG8z1RgDpDl8WKtm7nUd302IyAK/xDJFJYmZw0FJBaUIE177Ck87xqIFHV2UHLUnw83k8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WVBwW6XQLzxVDB;
	Thu, 25 Jul 2024 21:45:31 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C0392180102;
	Thu, 25 Jul 2024 21:45:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 21:45:35 +0800
Message-ID: <8857c1d6-fc60-489e-8311-52027ef81881@huawei.com>
Date: Thu, 25 Jul 2024 21:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: support STATX_DIOALIGN for statx
To: <dsterba@suse.cz>
CC: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
	<linux-btrfs@vger.kernel.org>
References: <20240620132000.888494-1-lihongbo22@huawei.com>
 <20240624160248.GO25756@twin.jikos.cz>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240624160248.GO25756@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/6/25 0:02, David Sterba wrote:
> On Thu, Jun 20, 2024 at 09:20:00PM +0800, Hongbo Li wrote:
>> Add support for STATX_DIOALIGN for btrfs, so that direct I/O alignment
>> restrictions are exposed to userspace in a generic way.
> 
> I looked at 8434ef1d8aafc523 that does also has some code coments, the
> generic changelog does not mention DIO vs other features like verity or
> inline files.
> 
> The statx manual page describes the high level meaning of the
> dio_*_align values, so this is filesystem and implementation dependent.
> So please mention what values can be expected for various features.
> 
> We do buffered io fallback on compressed data, on inline files too (I
> think), it may be possible on verity too.
Sorry, it was my oversight. I read the relative code, but I just find 
the fsverity and offset(size) and memory may affect the dio_*_align. I 
haven't found it related to compressed data and inline files. Does this 
miss the interception for the compressed data and inline files?

Also when `iomap_dio_rw` failed and return 0, it will fallback into 
buffered io. May be the dio_*_align values should not be affected by 
this situation.

Thanks,
Hongbo
> 

