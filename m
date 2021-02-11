Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB7319280
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBKSsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 13:48:03 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:41032 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230196AbhBKSrw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:47:52 -0500
Received: from venice.bhome ([78.12.25.19])
        by smtp-17.iol.local with ESMTPA
        id AGzWlzLoslChfAGzWlGA0T; Thu, 11 Feb 2021 19:47:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613069222; bh=c6/K5M8gMODr/RHru0HNp2c+0rtmF/I0zxzRFaLDduc=;
        h=From;
        b=TCFAHYhGVh+t3cWXLO32BkfB8iimt31ruqL7Ne1gErPEPvaKI8jCirhSLmTxAhImR
         GDT7kNXOAODW6RyXkfP1aUl86GJ1eR3/5eyhNf8uw42PuYuG1ubC5f/g8+ifXK8mal
         F/NrPdT/rE4Y20Wl3uW0gN0iTPh9mPBVkcoEfBqpn2lhTvifCPeGuZ1n9oYZbm11Nv
         FqO9bapd5yfqFHnhd1qkZVPm4jXHneSoOXR+SI16iHaAE8jdbfursUS25QYdkdbxGq
         IqnelWYuz/+CKzXDtDjJM0yZi6HpVybadlQiRRiqoSBc1Y6cw2TTRB8U/RM2RKfSrI
         w4azMSZK+j5GQ==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60257ba6 cx=a_exe
 a=cZ/q60u+NbBn6HfapJxCHg==:117 a=cZ/q60u+NbBn6HfapJxCHg==:17
 a=IkcTkHD0fZMA:10 a=a2Va9reMxmNHfdzgiWcA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 2/5] btrfs: add flags to give an hint to the chunk
 allocator
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-3-kreijack@libero.it>
 <3f283f4c-889f-aec1-7906-69fa72d1c09d@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <13849e89-ef98-459f-9cd9-c836ce73edc2@libero.it>
Date:   Thu, 11 Feb 2021 19:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3f283f4c-889f-aec1-7906-69fa72d1c09d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDFlJbM06YKp+kX0YFi2IBqzJy9UeL0Vcc6ia2rF09b3YlHBDRfENCyVXI41KPzG+bx43e1WtenPNRtgUIZMjU2PwiPkoh7xGEfa5dEbNCf8EvhWIE49
 KIOx5bnoYR5WClTQ0hqFrYuzXG/dXCZDQhifNKNuq+oPjABS/da+65eqzFUCuKhsDufNvf6EoNRGoZVObzmaz/PIresssVrSJ7k8oifVRYLYVn3LkOQFAJNq
 3ZWMTVnaIp+BiW2m4AM/6BxYUn2NjezcLCrWVd5RulbQqvr3xU9y58d7lYrZzM5x
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/21 5:09 PM, Josef Bacik wrote:
> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
[...]
>> +
>> +/* btrfs chunk allocation hints */
>> +#define BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT    3
>> +#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
>> +        BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) -1)
>> +#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
>> +        BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)
> 
> We just want to define the actual values that are going to disk, helpers can be defined elsewhere.  Thanks,

I will move BTRFS_DEV_ALLOCATION_MASK, BTRFS_DEV_ALLOCATION_MASK_COUNT. Instead I like
to left BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT here, in order to show how many bits
are available.

> 
> Josef

Ciao
Goffredo

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
