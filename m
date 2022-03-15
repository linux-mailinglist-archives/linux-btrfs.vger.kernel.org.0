Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC84DA2B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbiCOSw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 14:52:25 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3857B04
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:51:12 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220315185109euoutp02d9eac0ea5077b489ff0dc14e86a1b3b0~coog0WCtO1232812328euoutp02G
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 18:51:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220315185109euoutp02d9eac0ea5077b489ff0dc14e86a1b3b0~coog0WCtO1232812328euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647370269;
        bh=nkc3Du4QNPEyOxxUTfMg29rYgsADp+pzAtd3I3uhNLw=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=UuqQhoAJRFtGGJX3trDcExa3z/fuvUiCuFg/Oll6LIW0nInDUqUrNkBaudTmcMpdG
         iH7lAimVgYmhbBUWzewo7JafQ11RuAcm1qD6ROhEd89zIunkLc4RhXNAYyVTBai4VL
         DLHy5j/ml8g352i5nqto9a6FBXkLEj/xuqEPlGdA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220315185108eucas1p28935b32e6b129c3d05201b94aaf8cd05~coofxZYQ81376113761eucas1p2b;
        Tue, 15 Mar 2022 18:51:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.EE.10260.C10E0326; Tue, 15
        Mar 2022 18:51:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220315185107eucas1p10d346295af21f069148baf696b14951c~coofJQ1T71940519405eucas1p1w;
        Tue, 15 Mar 2022 18:51:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220315185107eusmtrp1e432ee2b21badd22a26cb054eb36f85a~coofIdjiG0311703117eusmtrp1g;
        Tue, 15 Mar 2022 18:51:07 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-04-6230e01ce196
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.BF.09522.B10E0326; Tue, 15
        Mar 2022 18:51:07 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220315185107eusmtip1bc14dc9482a4ca69f6eda7fd69aa01cf~cooe_VQJM0357103571eusmtip1r;
        Tue, 15 Mar 2022 18:51:07 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 15 Mar 2022 18:51:04 +0000
Message-ID: <f034dc8c-ab78-3c4e-3ed4-8173dcdb2819@samsung.com>
Date:   Tue, 15 Mar 2022 19:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
CC:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
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
In-Reply-To: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djPc7oyDwySDO4dE7ZYfbefzeL32fPM
        FitXH2Wy6Dx9gcmi58AHFou/XfeYLM6/PcxkMenQNUaLvbe0LS49XsFuMX/ZU3aLCW1fmS1u
        THjKaLHm5lMWi3Wv37M48Hv8O7GGzWPnrLvsHufvbWTxaF5wh8Xj8tlSj02rOtk8Ni+p99h9
        swGooPU+q8fnTXIe7Qe6mQK4o7hsUlJzMstSi/TtErgyJux8zlZwgq/iUUM3YwPjae4uRk4O
        CQETibOde1i7GLk4hARWMEoc2/WeHcL5wijxbMl6JgjnM6PEmsWfmWBaHhz8DtWynFHi/IHF
        7HBVd15dY4RwdjNKrL48ixWkhVfATuLVns/sIDaLgKrEw1cHmSHighInZz5hAbFFBSIkXh75
        C7ZCWMBLouPtWrB6ZgFxiVtP5oPdISLQxyjR8OM22AZmgYWsEs1NH4C6OTjYBLQkGjvBGjgF
        YiW+rT/IAtGsKdG6/TfUIHmJ7W/nMIOUSwgoS7xebwPxTq3E2mNnwD6QEHjEKbF71g92iISL
        xOpVs6FsYYlXx7dA2TISpyf3sEA09DNKTG35wwThzGCU6Dm8mQlig7VE35kciAZHiXdtG1kg
        wnwSN94KQtzDJzFp23TmCYyqs5DCYhaSn2cheWEWkhcWMLKsYhRPLS3OTU8tNs5LLdcrTswt
        Ls1L10vOz93ECEyJp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nwnnmhnyTEm5JYWZValB9fVJqT
        WnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qBKcL/Fd8X9e3HxZdkvTP2fKB8uEWj
        26zCtMrzV+in0JU8G4IkvXzvti/ZEfy+QGN+/Pzt3nI/ODSitPc8dPX1Fn3ZcDGE+3vqxq8t
        n/P5ZEo4W6+3R1UUVv3cs+fVpHMm+d7Wd3/96uj9sXxB9gKThKTvQe2/GPxWF0pMbrU70fA2
        Rl/k566a2GiH/9GzxM+cTLzUsFI7u7py11MXGdUHbevW+3q9Vtoru2mD3/vYixvdPZJ1pr9t
        Ksmx8bp/IO/1p+oAk9XnYsW258lllrod9GGUvrHT7cCzOfFcq9JO2V177PrVrVXbZEn0hu3P
        rvxdWL9761JxlxTrKTy7+TssDkrxWbctVTv+fd4OrdsTlViKMxINtZiLihMBZiKlFPgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7rSDwySDA4/1LJYfbefzeL32fPM
        FitXH2Wy6Dx9gcmi58AHFou/XfeYLM6/PcxkMenQNUaLvbe0LS49XsFuMX/ZU3aLCW1fmS1u
        THjKaLHm5lMWi3Wv37M48Hv8O7GGzWPnrLvsHufvbWTxaF5wh8Xj8tlSj02rOtk8Ni+p99h9
        swGooPU+q8fnTXIe7Qe6mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyJux8zlZwgq/iUUM3YwPjae4uRk4OCQETiQcHv7N2MXJxCAksZZRY
        +6CXESIhI/Hpykd2CFtY4s+1LjaIoo+MEp0PW6A6djNK7Dy9HKyKV8BO4tWez2A2i4CqxMNX
        B5kh4oISJ2c+YQGxRQUiJNqWTQGLCwt4SXS8XQtWzywgLnHryXwmkKEiAn2MEg0/bjOCOMwC
        C1klbvVvY4ZYN4dNovfnP6DdHBxsAloSjZ1g3ZwCsRLf1h9kgZikKdG6/TfUVHmJ7W/nMIOU
        SwgoS7xebwPxTq3Eq/u7GScwis5Cct8sJHfMQjJpFpJJCxhZVjGKpJYW56bnFhvqFSfmFpfm
        pesl5+duYgSmkW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeM+80E8S4k1JrKxKLcqPLyrNSS0+
        xGgKDKSJzFKiyfnARJZXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp
        1cAkduXF9amfDpkFJTVfKoxte//VNuS+V3XDYovSkuvOhb+yv7QLV5xdLs2Svjb3pXquTW6V
        1svi9gkejSf3HHYSjndvE330XlMvqavpPMPOgGllDW5r5ZV+G1SsL85oZHv14cZzuSjLjAyF
        2UaZvmrHrjPIzduwXFEsVXn5TY8ku+5Uw5amaR1i3OWSIjfNZsmtPxe3Z75WuI+llpzvyvDQ
        bY7X93Au823aEHUroVYrS8QphyfbINP+WpfmqY19zm4Ou4IsLi5NlP8YPPVSlv2+wD/LLp7T
        uWXjOvOfd+3EWq3S0B9RdwqP33IofHUtJ1/i76e/09Y+/G/aO6Fl+X5J75XuHL4STxiKv2Rv
        VWIpzkg01GIuKk4EAPCaR86sAwAA
X-CMS-MailID: 20220315185107eucas1p10d346295af21f069148baf696b14951c
X-Msg-Generator: CA
X-RootMTR: 20220315141431eucas1p211ee887321bb49977a7ce30543bbbf3c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315141431eucas1p211ee887321bb49977a7ce30543bbbf3c
References: <20220314073537.GA4204@lst.de>
        <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
        <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
        <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
        <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
        <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
        <20220315135245.eqf4tqngxxb7ymqa@unifi>
        <CGME20220315141431eucas1p211ee887321bb49977a7ce30543bbbf3c@eucas1p2.samsung.com>
        <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
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

Hi Johannes,

On 2022-03-15 15:14, Johannes Thumshirn wrote:
> Please also make sure to support btrfs and not only throw some patches 
> over the fence. Zoned device support in btrfs is complex enough and has 
> quite some special casing vs regular btrfs, which we're working on getting
> rid of. So having non-power-of-2 zone size, would also mean having NPO2

I already made a simple btrfs npo2 poc and it involved mostly changing
the po2 calculation to be based on generic calculation. I understand
that changing the calculations from using log & shifts to division will
incur some performance penalty but I think we can wrap them with helpers
to minimize those impact.

> So having non-power-of-2 zone size, would also mean having NPO2
> block-groups (and thus block-groups not aligned to the stripe size).
>

I agree with your point that we risk not aligning to stripe size when we
move to npo2 zone size which I believe the minimum is 64K (please
correct me if I am wrong). As David Sterba mentioned in his email, we
could agree on some reasonable alignment, which I believe would be the
minimum stripe size of 64k to avoid added complexity to the existing
btrfs zoned support. And it is a much milder constraint that most
devices can naturally adhere compared to the po2 zone size requirement.

> Just thinking of this and knowing I need to support it gives me a 
> headache.
> 
This is definitely not some one off patch that we want upstream and
disappear. As Javier already pointed out, we would be more than happy
help you out here.
> Also please consult the rest of the btrfs developers for thoughts on this.
> After all btrfs has full zoned support (including ZNS, not saying it's 
> perfect) and is also the default FS for at least two Linux distributions.
> 
> Thanks a lot,
> 	Johannes

-- 
Regards,
Pankaj
