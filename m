Return-Path: <linux-btrfs+bounces-1047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE1818107
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 06:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4389B2862E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 05:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F866FB4;
	Tue, 19 Dec 2023 05:34:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9563AC
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VypZHWA_1702964035;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VypZHWA_1702964035)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 13:33:56 +0800
Message-ID: <5dc7ecdd-8bd3-4016-b8da-49ff306bcd3c@linux.alibaba.com>
Date: Tue, 19 Dec 2023 13:33:54 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231218150234.GB19041@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2023/12/18 23:02, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 12:14:35PM +0000, Johannes Thumshirn wrote:
>> Small Nit:
>> ext4, f2fs and xfs use the super_block, erofs uses 'sb->s_type' as well
>> here. Reiser uses the journal and so does jfs. So while these two might
>> not be the best examples in the world, all other is an exaggeration.
> 
> As of 6.8-rc every file system but btrfs should be using the superblock.

Just saw this by chance.  Currently EROFS uses 'sb->s_type' to refer
external binary source devices (blobs) across different mounts.  Since
these devices are treated readonly so such external sources can be
shared between mounts as some shared data layer.

Thanks,
Gao Xiang

