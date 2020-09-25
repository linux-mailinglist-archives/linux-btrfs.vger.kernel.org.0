Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DF278298
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgIYIVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 04:21:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbgIYIVP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 04:21:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 017A0478D1953CDB494F;
        Fri, 25 Sep 2020 16:21:12 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 25 Sep 2020
 16:21:06 +0800
Subject: Re: [PATCH] btrfs: block-group: fix a doc warning in block-group.c
To:     <dsterba@suse.cz>, <clm@fb.com>, <josef@toxicpanda.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1600778241-24895-1-git-send-email-tanxiaofei@huawei.com>
 <20200923094543.GL6756@twin.jikos.cz>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F6DA872.7000504@huawei.com>
Date:   Fri, 25 Sep 2020 16:21:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200923094543.GL6756@twin.jikos.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 2020/9/23 17:45, David Sterba wrote:
> On Tue, Sep 22, 2020 at 08:37:21PM +0800, Xiaofei Tan wrote:
>> Fix following warning caused by mismatch bewteen function parameters
>> and comments.
>> fs/btrfs/block-group.c:1649: warning: Function parameter or member 'fs_info' not described in 'btrfs_rmap_block'
> 
> IIRC there are way more formatting errors for the kernel-doc, so I'd
> rather fix them in one patch. Also for static functions or internal
> helpers the proper formatting is not that important as it's read by
> people and the acual parameters are what matters.
> 

Sure, there are many warnings in the other files from dir fs/btrfs/.
If fix them in one patch, it could be huge :)

> .
> 

-- 
 thanks
tanxiaofei

