Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195D53AC0D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhFRCgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 22:36:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5033 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 22:36:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5jXg4gFYzXh5P;
        Fri, 18 Jun 2021 10:28:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 10:33:55 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 10:33:54 +0800
Subject: Re: [PATCH 1/1] btrfs: tests: remove unnecessary oom message
To:     <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210617083053.1064-1-thunder.leizhen@huawei.com>
 <20210617203518.GZ28158@twin.jikos.cz>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5f6198a7-3d3a-603e-73fe-b56c0b71fbf9@huawei.com>
Date:   Fri, 18 Jun 2021 10:33:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210617203518.GZ28158@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/18 4:35, David Sterba wrote:
> On Thu, Jun 17, 2021 at 04:30:53PM +0800, Zhen Lei wrote:
>> Fixes scripts/checkpatch.pl warning:
>> WARNING: Possible unnecessary 'out of memory' message
>>
>> Remove it can help us save a bit of memory.
> 
> Well, we have a few more messages in tests regarding failed memory
> allocations.  Though I've never seen one in practice, I think it's not
> a big deal to have that one here as well. The failures in the testsuite
> are intentionally verbose and saving a few bytes in optional development
> feature hardly bothers anyone.

The calltrace of the OOM message contains all the information printed by
test_err() here. I don't think anyone wants to see a bunch of unhelpful tips
when locating an OOM problem.

> 
> Where bytes can be saved are error messages for the same type of error,

It also saves a dozen bytes of binary code.

> that I've implemented in the past, see file fs/btrfs/tests/btrfs-tests.c
> array test_error that maps enums to strings.

As mentioned above, I don't think these "no memory" strings are necessary,
unless the rest of the test can continue to run healthy. Otherwise, no one trusts
the test results in the OOM situation. They're going to locate the OOM problem
first, and these information are pointless.

> 
> .
> 

