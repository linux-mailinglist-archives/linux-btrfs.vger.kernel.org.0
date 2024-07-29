Return-Path: <linux-btrfs+bounces-6834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15493F834
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E511F21E56
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A218784E;
	Mon, 29 Jul 2024 14:26:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4015533F;
	Mon, 29 Jul 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263209; cv=none; b=Gru/xrl5v+5h5f4QpTMAw5LQqY0aboM5idAxTUlVKDaV5y5CHwwRIHX6i95mOvGlXk/6r/n0OEUiyeKCwVJLJrAi7whuTDNUWblC728IaH1133Ef9PQR4cWWB9e//FLw7VKJQ5ZAV38YIHicZ8VV6q+4g64sjuBWXKta/puCU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263209; c=relaxed/simple;
	bh=Zjebs/s3gr+IkMh+R0WwcrOXD7xjkUF3lR211kKExgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iooR8T68H1y15VBAW9LgnXfHzuddw+09vWBT4cT1Hm5cFbis5Q6GWQZsX4JsQ7zSOMKACvHC0qUCMvz0Yfid2YevwiJAlnM/z1DmuceXGSNS9VT2Ilbcf42jHN0tRAkXUbcRf0ONyw4bVbFzD+2JJqf+EVhgWBhP48qwzzKanoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXgYF0qrzzPtKM;
	Mon, 29 Jul 2024 22:22:25 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A9D2180100;
	Mon, 29 Jul 2024 22:26:42 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:26:41 +0800
Message-ID: <1a8ac690-e48a-324c-a006-42fcf29d52be@huawei.com>
Date: Mon, 29 Jul 2024 22:26:40 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: Christoph Hellwig <hch@infradead.org>
CC: Filipe Manana <fdmanana@kernel.org>, <chuck.lever@oracle.com>,
	<zlang@kernel.org>, <fstests@vger.kernel.org>, <linux-mm@kvack.org>,
	<hughd@google.com>, <akpm@linux-foundation.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
 <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
 <ZqelcfdBQzc93w80@infradead.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <ZqelcfdBQzc93w80@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/7/29 22:21, Christoph Hellwig 写道:
> On Mon, Jul 29, 2024 at 09:53:52PM +0800, yangerkun wrote:
>> But after commit a2e459555c5f("shmem: stable directory offsets"),
>> simple_offset_rename will just add the new dentry to the maple tree of
>> &SHMEM_I(inode)->dir_offsets->mt with the key always inc by 1(since
>> simple_offset_add we will find free entry start with octx->newx_offset, so
>> the entry freed in simple_offset_remove won't be found). And the same case
>> upper will be break since we loop too many times(we can fall into infinite
>> readdir without this break).
>>
>> I prefer this is really a bug, and for the way to fix it, I think we can
>> just use the same logic what 9b378f6ad48cf("btrfs: fix infinite directory
>> reads") has did, introduce a last_index when we open the dir, and then
>> readdir will not return the entry which index greater than the last index.
>>
>> Looking forward to your comments!
> 
> I agree to all of the above.
> 

Thanks, I will try to write a patch for this!

