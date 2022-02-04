Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C84A989B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358136AbiBDLzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:55:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35276 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiBDLzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:55:04 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220204115503euoutp02272e2cc92930885d3f312f4391f0298d~QkzFAFWyg2922729227euoutp02N
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 11:55:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220204115503euoutp02272e2cc92930885d3f312f4391f0298d~QkzFAFWyg2922729227euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643975703;
        bh=EpAWyTrVaw/SKDA52Ob5TYAfYsDG4mcXfAjNQzgPj8g=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=KouCu35c26s8xQ5P2JMIN43OeaL9UbiX9uqhcGR/TIxV9w98xMWfAE7b3CUww5Aok
         h9gWwDnDz0kBorQ44gNY94bXOqfBRW+r9Pioz1SKvqgexVQNB8eguDoEtNx9T4cC+h
         /08B8+sdWYjx8adIj21STKEQXgYo4HNQ303cB2N0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220204115503eucas1p153334be71f328083e077c26de77d72e6~QkzEujWHv0815908159eucas1p1K;
        Fri,  4 Feb 2022 11:55:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.CD.10260.7141DF16; Fri,  4
        Feb 2022 11:55:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220204115503eucas1p26d55cbac1c9135d2b4f1af90e9dab7e9~QkzEYQDLA2458324583eucas1p2P;
        Fri,  4 Feb 2022 11:55:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220204115503eusmtrp13b29fc2c72b9bb249816596822fdafd0~QkzEXUjcf0741907419eusmtrp1l;
        Fri,  4 Feb 2022 11:55:03 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-e2-61fd14171a7a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.D9.09522.6141DF16; Fri,  4
        Feb 2022 11:55:02 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220204115502eusmtip131fdff5e56481be40eac8ab904815099~QkzENe0--1207212072eusmtip1T;
        Fri,  4 Feb 2022 11:55:02 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.224) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 4 Feb 2022 11:55:01 +0000
Message-ID: <fb969f68-9492-a078-e0c2-1780e0d1f0b4@samsung.com>
Date:   Fri, 4 Feb 2022 12:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB7416DCAEB7C986441C1BCC1F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.224]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7riIn8TDeYf5bOY1D+D3eLCj0Ym
        i79d95gs/jw0tDj/9jCTxaXHK9gt1tx8yuLA7jGx+R27x85Zd9k91m+5yuIxYfNGVo/Pm+Q8
        2g90MwWwRXHZpKTmZJalFunbJXBltG2ay1TwmaPiyrUjbA2M/exdjBwcEgImErdv13UxcnEI
        CaxglDg3tYMVwvnCKPHtwRRmCOczo0RD81pWmI5LF9Ug4ssZJS6e+QI0iROi6MxtNojELkaJ
        JStbwBK8AnYSCyatYAOxWQRUJB6+OMkGEReUODnzCQuILSoQIfHyyF8mEFtYIEpi6aUNYL3M
        AuISt57MZwIZKiIwjVHi/PJb7CAOs8BkRonGCU+ZQU5iE9CSaOwEa+AUiJVofrKEBaJZU6J1
        +2+oQfIS29/OYQaxJQSUJS5tfcEIYddKrD12BmymhEA/p8TOBX+hEi4Sq06+YYKwhSVeHd/C
        DmHLSJye3MMC1cAoMbXlDxOEM4NRoufwZiZIIFlL9J3JgWhwlJgwfxk0tPkkbrwVhDiIT2LS
        tunMExhVZyEFxiwkT89C8sMsJD8sYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZiQ
        Tv87/nUH44pXH/UOMTJxMB5ilOBgVhLhzZ72O1GINyWxsiq1KD++qDQntfgQozQHi5I4b3Lm
        hkQhgfTEktTs1NSC1CKYLBMHp1QDkw2f2uxlzcqds/Qz9u1LK1U5rlyv8bPl2ESV13rb/307
        5fcw/N8Jye2l5Yycm0veTbv+MX4F6xmXzY+aVtvUz/U0T9E4fOvD/j+K13Zqdoj61m/rfX8u
        98kB4freG+ncXw+w1jB+3X3+i5Qj44Zfc4WchK6zyFyefol7DccBrbyvK5uLtWULI/2rnPNY
        dTiZvEJvafR+tOIUKcma8s0+5UPt3fksB6R+aIcx26m6Jp89U7Rr5y77sss1Df7HzC6/FBEN
        TtEQe+oR2n/ZP2xzYbxmu8mGvV9i8/6LzPu/tPb3BPs9SV/e7U/0PVi5L/zO7GsLMwUbnc2P
        3bpj6dGyaKHOVFXhYKOo1ey3Wn10lFiKMxINtZiLihMBQtjOTbcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7piIn8TDV5eNrGY1D+D3eLCj0Ym
        i79d95gs/jw0tDj/9jCTxaXHK9gt1tx8yuLA7jGx+R27x85Zd9k91m+5yuIxYfNGVo/Pm+Q8
        2g90MwWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehltG2ay1TwmaPiyrUjbA2M/exdjBwcEgImEpcuqnUxcnEICSxllLh2YSZzFyMnUFxG4tOV
        j+wQtrDEn2tdbBBFHxklHs2YzgLh7GKUOHd1JRNIFa+AncSCSSvYQGwWARWJhy9OskHEBSVO
        znzCAmKLCkRItC2bArZBWCBKYumlDWAbmAXEJW49mc8EMlREYAqjRPOFX6wgDrPAZEaJxglP
        mSHWPWCUuHVrNjPI4WwCWhKNnWDdnAKxEs1PlrBATNKUaN3+G2qqvMT2t3Og/lGWuLT1BSOE
        XSvx6v5uxgmMorOQHDgLySGzkIyahWTUAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGR
        vO3Yz807GOe9+qh3iJGJg/EQowQHs5IIb/a034lCvCmJlVWpRfnxRaU5qcWHGE2BoTSRWUo0
        OR+YSvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphSlk9KOaa5
        RWiTh1RS1/L+nzXWiq3+W9XexJz3+/2id2FF1q2Tux6K7+e53CX2641xx9KnBy986Uvfe60l
        auvi9E8Z7Vld63LlbixdxvqH48vXEm7+O9Fbn/JZNYl3V8j+rF945fFasbfhmatDzj78KHWV
        c9a5o+XLj5yevVn0VmvAkw2iCntr47K5v2fceGyQXaexLI2l9MatifoBJdP6vRWT7c21nYrl
        475mbU0TqvWJOZb3qba8orJy5u3y0inhjjs83tz9xp7dIXrTKnJ7heEvRh2p4DexuyKszE+f
        k4889znXvf5ZldzJeqEHa982Fdv+/Xhv05y0ANEbDFZ349+nRiTWic1+v87k838lluKMREMt
        5qLiRACMGDvlbQMAAA==
X-CMS-MailID: 20220204115503eucas1p26d55cbac1c9135d2b4f1af90e9dab7e9
X-Msg-Generator: CA
X-RootMTR: 20220204091546eucas1p178596598790b945cb5033dd3938ef505
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220204091546eucas1p178596598790b945cb5033dd3938ef505
References: <CGME20220204091546eucas1p178596598790b945cb5033dd3938ef505@eucas1p1.samsung.com>
        <20220204091542.78118-1-p.raghav@samsung.com>
        <PH0PR04MB7416DCAEB7C986441C1BCC1F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-02-04 11:42, Johannes Thumshirn wrote:
> On 04/02/2022 10:15, Pankaj Raghav wrote:
>> Remove the redundant assignment to zone_info variable in
>> btrfs_check_zoned_mode function.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  fs/btrfs/zoned.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 3aad1970ee43..e3f6f24718d2 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -655,7 +655,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>>  			struct btrfs_zoned_device_info *zone_info =
>>  				device->zone_info;
>>  
>> -			zone_info = device->zone_info;
>>  			zoned_devices++;
>>  			if (!zone_size) {
>>  				zone_size = zone_info->zone_size;
> 
> Ack for the removal of the redundancy, but wouldn't this make to code look
> nicer in the end:
> 

I agree. I went with the initial patch to remain consistent with rest of the
code where zone_info was initialized. But given the formatting at this location
it is better to go with your suggestion.

I will send a v2 soon.

-- 
Regards,
Pankaj
