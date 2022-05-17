Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1452A16D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiEQMZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbiEQMZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 08:25:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797B4755B
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 05:25:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220517122526euoutp021497c9d964f89c7480d9595a88b65b97~v5AucuLQ01792217922euoutp02M
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:25:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220517122526euoutp021497c9d964f89c7480d9595a88b65b97~v5AucuLQ01792217922euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652790326;
        bh=dzDfwsCa0kUUWPIOFHmte5+5Y6+mRY6q2x1TxVUyvB0=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=BQJsJ/7L4qTEl9AMJA3aXrkLbU6YxPoD7JSselKzpkLsat8PAzwrBXe4Mehu7Nu2Y
         Y93Z2upkAAsIly+HMbFxnyU9DsLTObPTMsmEtL7jYWEx4veUAnJ4kwf9rWn/FlMCOv
         ZxZPCG5hpkc9byqfKIe+UnK7scyhdJYBHTsaRARU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517122526eucas1p272ecbff0ba41920947abd6e4b89b0335~v5AuSKDCB0582605826eucas1p2Y;
        Tue, 17 May 2022 12:25:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.50.10260.63493826; Tue, 17
        May 2022 13:25:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517122526eucas1p2b58d5a3e21979bacc5ee67bce176488b~v5AtwEiVS0582605826eucas1p2X;
        Tue, 17 May 2022 12:25:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517122526eusmtrp218e15fa612bbd4b027ec7a9db56b3a49~v5AtvTbB52067820678eusmtrp2e;
        Tue, 17 May 2022 12:25:26 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-26-62839436e010
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.06.09522.53493826; Tue, 17
        May 2022 13:25:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517122525eusmtip1a47cb89de54e4578b56f0f1e9ca6f911~v5Ato0Yf81578015780eusmtip1T;
        Tue, 17 May 2022 12:25:25 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.7) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 17 May 2022 13:25:19 +0100
Message-ID: <13636a7a-b585-0577-d939-656473576ad0@samsung.com>
Date:   Tue, 17 May 2022 14:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs:zoned: Fix comment description for
 sb_write_pointer logic
Content-Language: en-US
To:     <dsterba@suse.cz>, <naohiro.aota@wdc.com>,
        <Johannes.Thumshirn@wdc.com>, <dsterba@suse.com>,
        <gost.dev@samsung.com>, <linux-btrfs@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220517121334.GB18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzneV2zKc1JBtffyFtc+NHIZLH493cW
        i79d95gsLj1ewW4x8fhmVgdWj/VbrrJ4nFlwhN3j8yY5j/YD3UwBLFFcNimpOZllqUX6dglc
        GftX9rEV/GGumHmhia2BcRJzFyMnh4SAicSyf/NYuxi5OIQEVjBKfNq/mQXC+cIoceZqAxOE
        85lRon3LOSaYli1nPkIlljNKLDnzkgWu6uy5+1DDdjJK7F/Syt7FyMHBK2AnsXV1Fkg3i4Cq
        xN+OLnYQm1dAUOLkzCcsILaoQITEtFln2EBsYYEwifd73oLZzALiEreezAfbJiIwg1Hi5PMz
        TCAz2QS0JBo7weZwChhLnFs4lQWiXlOidftvdghbXmL72zlQjypK3Fz5iw3CrpVYe+wMO8hM
        CYE7HBLz90yBKnKR+H3nFZQtLPHq+BZ2CFtG4v/O+VDvV0s8vfGbGaK5hVGif+d6NpCDJASs
        JfrO5ECYjhJ/nhpCmHwSN94KQpzDJzFp23RmiDCvREeb0ARGlVlIATELycOzkDwzC8kzCxhZ
        VjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmmdP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVE
        eA0qGpKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MBXP
        a3wSduxjUJXE2aWeAQXMe88vm71u5gHdnpTLV7ZcXirC+u9wj8mLzvVGOW2XFc4un/evTWmr
        lcynsCPLA1sru333rTCO/P7Of5J47Tfm40FWe7YUuCRstZix/dO+HxEBVvcdsn5NNDMTZzMJ
        K69nP/rToHaz5yNe3p8r7x4XmZTEvVn/UkBwrjpz0aNy99dtF378KqxKzdSpO3nhK+Pv37Zd
        7fGeG274vlAyWrRNQG6SVCKbgO/V9n+vjPhZy1R+HLrAIZ8oKiZja6PE/ibxQMaPVd5XzV9+
        CH5l8Xr5wzzbcuPtX+z2Xlm14phqkNTd9V1xnY0xYqmW6VnhPzZZ9F1IOv636pTpLNHgYiWW
        4oxEQy3mouJEAJ3D/yuiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7qmU5qTDHQtLvxoZLJY/Ps7i8Xf
        rntMFpcer2C3mHh8M6sDq8f6LVdZPM4sOMLu8XmTnEf7gW6mAJYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYz9K/vYCv4wV8y80MTWwDiJuYuR
        k0NCwERiy5mPTF2MXBxCAksZJdo3b4BKyEh8uvKRHcIWlvhzrYsNougjo8TqR3sZIZydjBJr
        9k4HynBw8ArYSWxdnQXSwCKgKvG3owusmVdAUOLkzCcsILaoQITEg91nWUFsYYEwiQUvNzGB
        2MwC4hK3nswHu0JEYAajxMnnZ6BO2sYocf/5ahaQBWwCWhKNnWBDOQWMJc4tnMoC0awp0br9
        NzuELS+x/e0cqA8UJW6u/MUGYddKvLq/m3ECo8gsJDfNQrJ7FpJRs5CMWsDIsopRJLW0ODc9
        t9hQrzgxt7g0L10vOT93EyMwCrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4TWoaEgS4k1JrKxK
        LcqPLyrNSS0+xGgKDJiJzFKiyfnANJBXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2a
        WpBaBNPHxMEp1cA0Kb+f5+R7yQ0fPy94PIvvys3nd9ZaewulzPq4lc9nycRp2sn2fPPPhQfd
        keNUCLm7TWfVkRWnDngdVvfd8ZVt97uEy9L2J7Y3z7/G++6rjOMhj5QTlUdcOF9pRYpduy/w
        vyTkeulUhfNW9b8s2c4+vxAYaWbL/Pt09oSVx9/evvDOqdqNr3a2kbz+2ua2T51h85KSAjbt
        yb7P8/GnTivP9d5460+swbs3sWrleT3U2PFnafC3cLutd1W/hXfekzu520zmxf2iy+IeS9vk
        ViUY5Zhu2vilxKH7To2O/+RyllvSR25ZlzSeOLPjiElF/f6Tuh6+O8ulJpncqw2O2+vaf1Zv
        /+eXn5OEPn6r4fCtUGIpzkg01GIuKk4EABr100BLAwAA
X-CMS-MailID: 20220517122526eucas1p2b58d5a3e21979bacc5ee67bce176488b
X-Msg-Generator: CA
X-RootMTR: 20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404
References: <CGME20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404@eucas1p2.samsung.com>
        <20220517082255.28547-1-p.raghav@samsung.com>
        <20220517121334.GB18596@twin.jikos.cz>
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-05-17 14:13, David Sterba wrote:
> On Tue, May 17, 2022 at 10:22:55AM +0200, Pankaj Raghav wrote:
>> The comments describing the logic for evaluating the sb write pointer
>> does not represent what is done in the code. Fix it to represent the
>> actual logic used.
> 
> It would be good to briefly describe what is the actual mistake in the
> comment, so one can have an idea without looking to the code.
I should have done that. I will send a v2 with a more descriptive commit
log. Thanks
