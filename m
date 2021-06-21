Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6C3AE7B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFUK6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:58:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8285 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUK6l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:58:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G7mY12xzcz1BQ01;
        Mon, 21 Jun 2021 18:51:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 18:56:25 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 18:56:24 +0800
Subject: Re: Please don't waste maintainers' time on your KPI grabbing patches
 (AKA, don't be a KPI jerk)
To:     Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0a9ae22c-44a0-6239-f61a-fa516f2a0de6@huawei.com>
Date:   Mon, 21 Jun 2021 18:56:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, Qu:

My contributions to the kernel in the past have mainly been on optimizing the performance of the ARM64 SMMU driver,
including the iova optimization, strict mode optimization, and the lazy mode optimization. Also working on the
development of some ARM SoC drivers.

When time and effort is allowed, I also contribute to other modules of Linux kernel, trying to find something can be
improved, and some cleanup work is being done.

In the future, I will continue to make more and more important contributions to the Linux community.

Thanks.
Zhen

On 2021/6/18 14:31, Qu Wenruo wrote:
> Hi Leizhen, and guys in the mail list,
> 
> Recently I find one patch removing a debug OOM error message from btrfs selftest.
> 
> It's nothing special, some small cleanup work from some kernel newbie.
> 
> But the mail address makes me cautious, "@huawei.com".
> 
> The last time we got some similar patches from the same company, doing something harmless "cleanup". But those "fixes" are also useless.
> 
> This makes me wonder, what is really going on here.
> 
> After some quick search, more and more oom error message "cleanup" patches just show up, even some misspell fixes.
> 
> 
> It's OK for first-time/student developers to submit such patches, and I really hope such patches would make them become a long term contributor.
> In fact, I started my kernel contribution exactly by doing such "cleanups".
> 
> But what you guys are doing is really KPI grabbing, I have already see several maintainers arguing with you on such "cleanups", and you're always defending yourself to try to get those patches merged.
> 
> You're sending the patch representing your company, by doing this you're really just damaging the already broken reputation.
> 
> Please stop this KPI grabbing behavior, and do real contribution to fix the damaged reputation.
> 
> Thanks,
> Qu
> 
> 
> .
> 

