Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EA4DA395
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 20:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbiCOT60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351897AbiCOT6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 15:58:10 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960756408
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:56:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220315195641euoutp02f7a1534c9de157886fbbb7036f68be04~cphuxPd4m1862318623euoutp02T
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 19:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220315195641euoutp02f7a1534c9de157886fbbb7036f68be04~cphuxPd4m1862318623euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647374201;
        bh=WeT2OiKjyRSR+torxX2JuAR/sqg/VT5hyO6yN4/AqXg=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=iU5jt6btCVWddDBCczfngauafMCuIuNZqfb8/bPkKE/LDMu5S6hllwKzApWkm8U3q
         KOz373SHjHNl9wbFukpgIGI4QPVqQfoWsctVpeWG/xyM2+6eCIpFgcfeOMxSdrlVdm
         5kSp/l2WEVUg37zK9TPncQ2QRD4BlTYL3MG2O65Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220315195640eucas1p15195bbcf50efff97649295304cabe7fe~cphtr4mHw2468824688eucas1p1-;
        Tue, 15 Mar 2022 19:56:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.F0.10260.87FE0326; Tue, 15
        Mar 2022 19:56:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220315195639eucas1p28b1204d5dcfc5c5ff7f219bd142af606~cphsdG_j30266502665eucas1p2Z;
        Tue, 15 Mar 2022 19:56:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220315195639eusmtrp21349e4ca5f824e0a0aee399cd64bbf1b~cphscTnaW3175731757eusmtrp21;
        Tue, 15 Mar 2022 19:56:39 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-96-6230ef786b00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.F0.09522.67FE0326; Tue, 15
        Mar 2022 19:56:38 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220315195638eusmtip1537eeac3e9a448034a01b420608041db~cphsQsqlU0430704307eusmtip1A;
        Tue, 15 Mar 2022 19:56:38 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 15 Mar 2022 19:56:36 +0000
Message-ID: <bc4764d4-0532-6dac-fb4c-7325c0f3c626@samsung.com>
Date:   Tue, 15 Mar 2022 20:56:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     <dsterba@suse.cz>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220315142740.GU12643@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7djP87oV7w2SDF71CFqsvtvPZvH77Hlm
        i8W/v7NYrFx9lMmi8/QFJoueAx9YLP523WOyOP/2MJPFpEPXGC323tK2uPR4BbvF/GVP2S0m
        tH1ltrgx4SmjxZqbT1ks1r1+z+Ig4PHvxBo2j52z7rJ7nL+3kcWjecEdFo/LZ0s9Nq3qZPPY
        vKTeY/fNBqCC1vusHmcWHGH3+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8b27i1sBR95K1o/
        nmRuYOzg7mLk5JAQMJH49ekhWxcjF4eQwApGifM3/jBCOF8YJe5PbYFyPjNKTH+6kw2mpWHF
        JajEckaJtdsuMIIkwKquNqhBJHYzSkzaeo4JJMErYCex4MR0sCIWAVWJnk+T2SHighInZz5h
        AbFFBSIkXh75C1YvLOAl0fF2LVgNs4C4xK0n85lAhooIHGCTWLFvNVCCg4NNQEuisRPM5BQw
        ljh7JxaiXFOidftvqFZ5ie1v5zCDlEgIKEu8Xm8DcX+txNpjZ9hBJkoIvOKUuHrwNyNEwkVi
        +ccF7BC2sMSr41ugbBmJ/zshTpAQ6GeUmNryB8qZwSjRc3gzE8QGa4m+MzkQDY4SfWubWCDC
        fBI33gpC3MMnMWnbdKh7eCU62oQmMKrMQgqIWUgenoXkm1lIvlnAyLKKUTy1tDg3PbXYOC+1
        XK84Mbe4NC9dLzk/dxMjMD2e/nf86w7GFa8+6h1iZOJgPMQowcGsJMJ75oV+khBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmnuSPbjxPC59u+qb4ZHnh
        /6oGa0Ov9Ud8z5tpy00UydTj0j3qKDYvyN9h/4/nXN3lbR0C29ifsbAov2X49213tGCBitTW
        vOp67ZhI56I1814sDiiYyNzCMPHLZRZGq1WcShJvmzS1/cx2MMjPTYw8rWtlf2jDUf9D7KLd
        ItFz1qSE7ZRi+m8VGrjBafpioU++U9i+pzYms0uXLfRbfOu6x0/5G/Z93ZdShI8+ZrFnev2X
        pbRtOqeZoEffydvLvXx9NOQd1/Eotaz5WzZ1L09ofFx9slWE8bPzsX0q1//Z/L7QGlSg8q/b
        bI7/h8gHF7Xcgtjen0g/o8f0JYlF6cw7783rvkv984nWk9hxV4mlOCPRUIu5qDgRANMNwYn+
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7pl7w2SDHa8t7ZYfbefzeL32fPM
        Fot/f2exWLn6KJNF5+kLTBY9Bz6wWPztusdkcf7tYSaLSYeuMVrsvaVtcenxCnaL+cuesltM
        aPvKbHFjwlNGizU3n7JYrHv9nsVBwOPfiTVsHjtn3WX3OH9vI4tH84I7LB6Xz5Z6bFrVyeax
        eUm9x+6bDUAFrfdZPc4sOMLu8XmTnEf7gW6mAJ4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzt3VvYCj7yVrR+PMncwNjB3cXIySEhYCLRsOIS
        YxcjF4eQwFJGiUuLzzBBJGQkPl35yA5hC0v8udbFBlH0kVFi4ZzFYAkhgd2MEn83FIDYvAJ2
        EgtOTGcEsVkEVCV6Pk1mh4gLSpyc+YQFxBYViJBoWzaFGcQWFvCS6Hi7FqyGWUBc4taT+Uwg
        C0QEDrBJrNi3mh1i2wtWicM/2oG6OTjYBLQkGjvZQUxOAWOJs3diIXo1JVq3/4aaIy+x/e0c
        ZpASCQFlidfrbSDur5V4dX834wRGkVlILpqFZPMsJJNmIZm0gJFlFaNIamlxbnpusaFecWJu
        cWleul5yfu4mRmDy2Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE98wL/SQh3pTEyqrUovz4otKc
        1OJDjKbAYJnILCWanA9MX3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1M
        HJxSDUyy3cUm+nXFFx7an/p3iIPJvXje3nlz2kSnrj9t9mwnn3nFhfKHs5J1bYQDv7fnxZ3s
        cjr/xSnnz/o8r+ksX7fcvHPfP+iRsEtSV2yb3Gfxj09XhovPyd56sGuKAd+Pv0vvH7y2Iszw
        bfCDQ/cTn9l2BnGkTX8y+2fZ6lU/jplaRzPNW244feosPRNFmZMJT2fN5Go/7bHRzipcSP7l
        doXtCVN33lTRCrKb3cR4oaB04SoRr79im65FG1v/+nugg/llzuGJV448mpsjFfh+SlVCUV+p
        UkPsXNOVTaFP2tVjI/9KSWSmTsq7q/P8hVroW4ObzfO/Rkf/2j9pec7euYW+emcrs7VEay+s
        VDhrePChEktxRqKhFnNRcSIAy6dyvacDAAA=
X-CMS-MailID: 20220315195639eucas1p28b1204d5dcfc5c5ff7f219bd142af606
X-Msg-Generator: CA
X-RootMTR: 20220315143148eucas1p157359f025cb46f8099385b48400bc638
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315143148eucas1p157359f025cb46f8099385b48400bc638
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
        <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
        <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
        <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
        <20220315135245.eqf4tqngxxb7ymqa@unifi>
        <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
        <CGME20220315143148eucas1p157359f025cb46f8099385b48400bc638@eucas1p1.samsung.com>
        <20220315142740.GU12643@twin.jikos.cz>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 2022-03-15 15:27, David Sterba wrote:
> 
> PO2 is really easy to work with and I guess allocation on the physical
> device could also benefit from that, I'm still puzzled why the NPO2 is
> even proposed.
> 
Quick recap:
Hardware NAND cannot naturally align to po2 zone sizes which led to
having a zone cap and zone size, where, zone cap is the actually storage
available in a zone. The main proposal is to remove the po2 constraint
to get rid of this LBA holes (generally speaking). That is why this
whole effort was started.

> We can possibly hide the calculations behind some API so I hope in the
> end it should be bearable. The size of block groups is flexible we only
> want some reasonable alignment.
>
I agree. I already replied to Johannes on what it might look like.
Reiterating here again, the reasonable alignment I was thinking while I
was doing a POC for btrfs with npo2 zone size is the minimum stripe size
that is required by btrfs (64K) to reduce the impact of this change on
the zoned support in btrfs.

> I haven't read the whole thread yet, my impression is that some hardware
> is deliberately breaking existing assumptions about zoned devices and in
> turn breaking btrfs support. I hope I'm wrong on that or at least that
> it's possible to work around it.
Based on the POC we did internally, it is definitely possible to support
it in btrfs. And making this change will not break the existing btrfs
support for zoned devices. Naive approach to making this change will
have some performance impact as we will be changing the po2 calculations
from log & shifts to division, multiplications. I definitely think we
can optimize it to minimize the impact on the existing deployments.

-- 
Regards,
Pankaj
