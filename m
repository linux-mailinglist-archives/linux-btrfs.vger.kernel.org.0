Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C12F2F1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbhALMan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 07:30:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:36245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhALMam (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 07:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610454549;
        bh=7hUYoBatKdHp11YLsad3rs48K1CLRK2QwdcWFouTxU8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=czZjEf4SHgJDX9MdlceQ0qJUIRBULSLSaxSESu1MCnAx0i1Qjwyzs7KzzSGHosD5H
         /MP5Lo7Nq4ENgQhYIYtIr/D8LUQt9TUJdHGY60Z9uSOytZMkJ4OcaN6kQoUs4J/YSM
         auLhfS+5VDVqsVTG6shXVwaVF9VMnEIElFdLuf2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1kIWr546hz-00htz1; Tue, 12
 Jan 2021 13:29:09 +0100
Subject: Re: [PATCH] btrfs: make btrfs_dirty_inode() to always reserve
 metadata space
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210108053659.87728-1-wqu@suse.com>
 <e68db844-ec96-0ab4-1654-bd8cea6e78e0@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ad973dfe-0ff8-72c2-9b22-770999f3f379@gmx.com>
Date:   Tue, 12 Jan 2021 20:29:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e68db844-ec96-0ab4-1654-bd8cea6e78e0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QGcOGIjOatrx7xTeobGsKqfc3OBu7LJUFpban1c2r/Ryl1qKHDs
 iJysQJPUzyF0AS/b8rLm+Oh2dGDSCZ+vzmiUDsC0ElZRtvirUCbDdK4NIMNGQg0Dp2a/T6J
 c9XEjsYmLL57KEHgCPHm5cmVettJOTXgLRaiYyclIIZDGh/hfvPcosclwVNN1inGetEZehu
 qjafI4Fu+w9fBEJ2Ag26A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j9ZmurbRUJU=:na9pJBSoK8/OT9IAJ1QqGg
 HIVDX3NytobGVIRlppMvXk6dUm1qAwMzmn1PS9veSv65plCG1a8W7tsRpjQt3XFaTa1WPb39G
 eSCQOJlGpaBQATNYG9ydc0HtF4itH3k+yW6c8pN7czz7zxzhfik/02t2ZZadQsgSNxm7EzswU
 c1wtnK+6340WDNjAcE9zpNpqQjESbtPLLjQQoTPh7Tz1Ix6Lm6hHXCYAZuUvxrANa+GlbXXKf
 3iy1Xv91iAPMclmAbRcojAmJT2NcuBDIaQ7XSNeDG3AOpmvOL/l3Rsg47NtgaFmOp6MbTviOO
 eigAIyPey2xSgUhbHbnXxxhXQM71dDvRv+44AZL/2RVAU5w5f3X6Dy+ulGll/u8jzi7N8fYqK
 W2sdbP0g8iLaHTvGzfKRG7YBXvU01hIwHf3eBRkRliG2vzmZ1799DJW+SPNYkJXH9V7z38LcZ
 8ZwUrA7ZrGwcXfpD2GgHtGhwxrcngN9rd6xPi/xaK8vVaITD/VeAVhIcjlN7AOsPzFGgf3eBK
 jeeK/kkAc1+dxo33gnRZkSA36QCCbIIbGNHy0FwIMXu0dwUOFAfS36EO7bVYN+Lr2zF1BDta5
 h/232glSMUlkh/NshcVjRZr4TPbL4Lqo+dLfQfvAOEOAuOBH5RznX8LWI0gwSC/LlpRhHuVse
 qBhE1bKBsCXy/QL6WAq80WQ4euwFVbq+NEyVGegznhreZOHeGVLy4BkVkpT87IZImDJJ8Qg+N
 QfaTtQscecVcuAm3YUAqtzBrOs6c9E3NhnK6nsite1+I7XlFtmiLAu5H9w/HWjWYZmu16Uwir
 3szk508/sRwZT7uxyAXe2KHvCXImPM1qKfyO4kIYIZppi9VPZip2A0aNkB0fpEIEqwByXshes
 W63j8cvs7PAFKbCOSG/A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8B=E5=8D=888:19, Nikolay Borisov wrote:
>
>
> On 8.01.21 =D0=B3. 7:36 =D1=87., Qu Wenruo wrote:
>> There are several qgroup flush related bugs fixed recently, all of them
>> are caused by the fact that we can trigger qgroup metadata space
>> reservation holding a transaction handle.
>>
>> Thankfully the only situation to trigger above reservation is
>> btrfs_dirty_inode().
>>
>> Currently btrfs_dirty_inode() will try join transactio first, then
>> update the inode.
>> If btrfs_update_inode() fails with -ENOSPC, then it retry to start
>> transaction to reserve metadata space.
>>
>> This not only forces us to reserve metadata space with a transaction
>> handle hold, but can't handle other errors like -EDQUOT.
>>
>> This patch will make btrfs_dirty_inode() to call
>> btrfs_start_transaction() directly without first try joining then
>> starting, so that in try_flush_qgroup() we won't hold a trans handle.
>>
>> This will slow down btrfs_dirty_inode() but my fstests doesn't show too
>> much different for most test cases, thus it may be worthy to skip such
>> performance "optimization".
>
> btrfs_dirty_inode is called everytime file_update_time is called or
> atime is updated. Given the default mount option is to use lazy a_time
> I'd say we needn't worry about it. file_update_time, however, is called
> within the write path so this change potentially makes file write more
> expensive. So instead of testing with fstests it needs proper
> benchmarking with fio.

Thanks for the benchmark tool.

One of my biggest question is what tool should be used to properly
benchmark the patch.

Although I don't have extra physical machine, at least I can test with a
VM with cache=3Dnone mode using a dedicated SSD for this case.

Will update the patch to include the new benchmark result.

Thanks,
Qu

>
> <snip>
>
