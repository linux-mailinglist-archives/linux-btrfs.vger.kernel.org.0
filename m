Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A214C48D23F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 07:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiAMGJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 01:09:21 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:37474 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229889AbiAMGJU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 01:09:20 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 7tITn6MdT06Tn7tIUnAsy6; Thu, 13 Jan 2022 07:09:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1642054158; bh=1l5qdvMiu/GKTwXhXZfW/Fp7JYihTar7q235YmWyGjY=;
        h=From;
        b=rGQG8jyC06bhKybg2kTcFE4H+eSN41ugID0nu5LTYRZq/vhUqvvRo1yxTqI6GywbO
         gg1KbcAm05IgljGOGhJHXsAMhUqD8lcL/dv8m36L9JRuFK0g8oqR9PLQXbG/pxnitO
         T5v4pCYt5EwlJd/ZtRL5Z1ke0gmlak4wYOGF/RBXzhzYtsOC3dw8Yz+8JgXO6G+TUx
         n2mhHEVGXJhNHECzy/t/jNYPdF8Fo0OFldvlXcBsdPjxqD3iiCBqgrug6qdVlhVF6p
         PJWBe4DvtSnJfKiU8YH8AK2WyVHCp2uFG65/5SzVl+n7tcop+KCJfbLTqG6ml1hNjS
         UlAYSMxge5cdA==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61dfc20e cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=MXlVO_er3h7Nu3ZKPw0A:9 a=QEXdDO2ut3YA:10
Message-ID: <092d352f-0e4d-1636-5bf9-6f44fb549298@inwind.it>
Date:   Thu, 13 Jan 2022 07:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v4 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
 <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
 <ebd02efc-0ff0-0954-a7e6-308757d70e49@oracle.com>
 <f8d4c133-e76b-656f-9c13-174a79298a92@inwind.it>
 <324c7f27-05ee-c4bb-49a7-08c06a356b1c@oracle.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <324c7f27-05ee-c4bb-49a7-08c06a356b1c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBO9HVFB64BSWH/CO1CnCl3+IH9ZtcOoHT1w5KXG4vK94jIdyvVAWw3Hpju8YJW44OuLxjt90+J61EsAV0PEh+IE5iQTagogco4168El/qIiOp7OI45w
 9rPBVWKfhx9+EbDAIyf4Xm3uXy8MvOeFcRnl9vOtNmlBr8njsx1q2EM2QJRHBdWwWz4ImrS9RLz04ieLYhg1XTWKuWgdt5uFAOsuQo5dCfut/vSFCxidZoFM
 ed4+n+vjmQy4TYNrGepRhGW4ok41Fr3AzK3LvplCHa+Rj9/g7UVbODQ67aLFRYrqKpVvI6SNxdHpt/MrO5tMb/qmyw4cGK5vZGEEfkG03BM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/01/2022 04.17, Anand Jain wrote:
> 
> 
[...]
>>
>> Ok, I think that this case (where devt!=0 and bdev==NULL) should be inserted as comment in the structure before the devt field.
> 
> I will add but, did you find any pitfall for breaking such a case?
> Or are you submitting any patch based on this rule?

In a patch that I sent few days ago, I exported the major/minor
in <UUID>/devinfo/<devid>/major-minor sysfs property.
In order to do that, I taken the values from btrfs_device->bdev->bd_dev,
checking that bdev is not NULL.
So I didn't understood why we need to add copy of devt also
is the btrfs_device structure, because it is easy to taken the bdev one.

You answer was "we need that, because sometime bdev is NULL even
if a reasonable devt value exist", which is a valid reason.
So I suggest to add this info in the header so even the "next" developer
with a no so deep knowledge of the btrfs device life-cycle will be
aware of this case.

BR
G.Baroncelli
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
