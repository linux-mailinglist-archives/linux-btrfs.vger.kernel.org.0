Return-Path: <linux-btrfs+bounces-1059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1518188D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C307A284A92
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEB19BC0;
	Tue, 19 Dec 2023 13:48:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E5199A2
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vyr8pAw_1702993704;
Received: from 192.168.71.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vyr8pAw_1702993704)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 21:48:25 +0800
Message-ID: <f397132d-a0af-4d69-8fc9-57e488a7bf9b@linux.alibaba.com>
Date: Tue, 19 Dec 2023 21:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20231218044933.706042-1-hch@lst.de>
 <20231218044933.706042-6-hch@lst.de>
 <04e599b9-5d6d-4ac0-bf74-da9bedfb585f@wdc.com>
 <20231218150234.GB19041@lst.de>
 <5dc7ecdd-8bd3-4016-b8da-49ff306bcd3c@linux.alibaba.com>
 <20231219121911.GA21959@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231219121911.GA21959@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/19 20:19, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 01:33:54PM +0800, Gao Xiang wrote:
>>>> ext4, f2fs and xfs use the super_block, erofs uses 'sb->s_type' as well
>>>> here. Reiser uses the journal and so does jfs. So while these two might
>>>> not be the best examples in the world, all other is an exaggeration.
>>>
>>> As of 6.8-rc every file system but btrfs should be using the superblock.
>>
>> Just saw this by chance.  Currently EROFS uses 'sb->s_type' to refer
>> external binary source devices (blobs) across different mounts.  Since
>> these devices are treated readonly so such external sources can be
>> shared between mounts as some shared data layer.
> 
> Makes sense for that somewhat unusual use case.  Note that this means
> you can't really use blk_holder_ops based notifications from the block
> driver, but for read-only devices that's not all that important anyway.

Yeah, anyway even if notifications is used in the future, I will think
more about this later.

Thanks,
Gao Xiang

