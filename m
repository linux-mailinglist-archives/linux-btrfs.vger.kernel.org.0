Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7750B154FD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 01:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBGAmB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Feb 2020 19:42:01 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:50933 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBGAmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 19:42:00 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri,  7 Feb 2020 00:41:19 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 7 Feb 2020 00:38:57 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 7 Feb 2020 00:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEHyg7mL2wp7XPPVC8ZCswAsqfl4g8i60BMitjKGNPTeJULQTRCvAazWonmN5pPxpDDYyRQJfuw9Y8ZeHgWVg7dsCGbLPVjcm3Nfylkc9u/WZ9axz3YtDAdj9Y1OPFTiJ9r4MnMucUOILCBfWJ/SyLdFaYf3dT8IViuHdlixfjKRwHGzgKRRMe0wUU5k/Cs0SAMcpPsZMEwaZi0zU118hMQDqlRt94xaL3+X7U70lVWI12NibOFlE059FWsMLqIKBxsAAqTsFHl0DXIg5fARIWico/RUNgBo75TzKCH8smZzeTxn/GiPO4khKrOTXboEqMCmkKV2ZVMpgOeoJfx5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8upFCzieVOvTm31/GP5O/8Rrj+2cXIOGmlL9gCcumuY=;
 b=lDwLaSUUJ3+Xf8e/6gq6HLbSW99lRT6d5av/G1Uwhgcufd7Na2TRYQSU/UHaCrBRIRDez1xLCVlwl+zj5Nja9rbdBrqAR2+sIp3cHMnKIsWHcp4ZHarQq2hT3AAgIHgtmmXEuCNfPbbizpmi3I6cyMTe8x7G/XpHNoLqrcWnNaCwI6zGOM9zPMP2bL3TcvNANdiN2qAtXmscsDAtDm2d1z6LoQjQ0qSA4S3AIqthSwFSxhBWyJXGVJYDRFddqgcXC3pYrXdYIOcKLKpuDwFF5mc1+cW7y1K+B7htIcKCNg0qnzLB1qxLyM/fCtItIvMUnetccrWy9IHoOBjRltKv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3218.namprd18.prod.outlook.com (10.255.137.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 00:38:56 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:38:56 +0000
Subject: Re: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
To:     Josef Bacik <josef@toxicpanda.com>, <fstests@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>
References: <20200206053226.23624-1-wqu@suse.com>
 <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
 <8199544d-c5cb-eb1e-ed7c-f9b170324997@suse.com>
 <7da58abd-eb5e-0a7f-f3bf-205f1daf95cd@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <60d80072-0606-19bc-d443-1a5ba8b97656@suse.com>
Date:   Fri, 7 Feb 2020 08:38:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <7da58abd-eb5e-0a7f-f3bf-205f1daf95cd@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0016.namprd07.prod.outlook.com (2603:10b6:a02:bc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Fri, 7 Feb 2020 00:38:55 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6948416f-5d53-4971-e518-08d7ab661d30
X-MS-TrafficTypeDiagnostic: BY5PR18MB3218:
X-Microsoft-Antispam-PRVS: <BY5PR18MB321848DCAA500B31A4450466D61C0@BY5PR18MB3218.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(8676002)(956004)(53546011)(2616005)(36756003)(5660300002)(8936002)(81156014)(81166006)(2906002)(31686004)(316002)(16576012)(66476007)(66946007)(186003)(66556008)(16526019)(6486002)(52116002)(31696002)(6706004)(478600001)(26005)(86362001)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3218;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etXICNHYSH1gdISDvOVtsqtYOpFCyEQQnd03srfdLB3/YN4quogUJhwUOCURR+0ggorhZSMuNH7W7Ye7YIT/GslS+hi3W23lQfPs5CL+YP0JnPeV6DaHalzx4Qt5jug2xWfclrrwuNxpfiF3rUEXX3ZlLiVmPVpwzaAdxPVzN/xgs1hnWCv1rHx1yJTSmlhTlsFK3FQw9ISJuqV9UAHRCBxevkjDbJnZOMxwAB8cXOgDKPt900e9zTCtfwXNLR3hL6QDhndtQFVOVmuJYuMVgrYWOZbgFOygXPQu6p6+AbLjPEAbWmlgFE+XudH0lPtnP4Mhdn7uc9CHR2zr15cdkqmjI/MfPwHkW/COaOXujBino8+Q7j3KNAQKgRYe1NINwNt77/OJVmQDxAM4bWUJgvbkWVaUYIJ1dx4gQHh60esX7VTQyg/K3p1cyfktFf9ju+ux8qbukKIDus02jlQAq1x4DRsXp2j5v7nq3zlgTMlyviVmU/j9xZmbMcUAYJ88s+mHJsIZxokOaY3kyH3JBgRN9p09r/91i62aPvigEGs=
X-MS-Exchange-AntiSpam-MessageData: /YIWcI9TU7VlmtSSycA+Gjk2NbGzbm2MXUtjnYdOxuisebtroKrkQiWc2vIBDzwjVc2v9jyhHky/RGKfYkp0WQn5Sb82iqYkCR2zWgpx2puanvjiTrgc95kXCOKjGdAf0vwy5Nkd4s5HqYUOOh/pHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6948416f-5d53-4971-e518-08d7ab661d30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:38:56.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz5snKVewGV5VybvjOI7l+ONdzufYn1XODP+0kPLveQCBERAXFldcWjD/v1Ia/XL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3218
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/7 上午8:38, Josef Bacik wrote:
> On 2/6/20 7:35 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/6 下午11:47, Josef Bacik wrote:
>>> On 2/6/20 12:32 AM, Qu Wenruo wrote:
>>>> Since commit fd0830929573 ("fsstress: add the ability to create
>>>> snapshots") adds the ability for fsstress to create/delete snapshot and
>>>> subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
>>>> handle multiple subvolumes under the same path.
>>>>
>>>> So manually disable snapshot/subvolume creation and deletion ioctl in
>>>> this
>>>> test case. Other qgroup test cases aren't affected.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Why not just fix _btrfs_get_subvolid?  You can use egrep to make sure
>>> the name matches exactly.  Thanks,
>>
>> Because we have other requirement, like limit tests.
>>
>> If we have other snapshots/subvolumes, they don't have the same limit,
>> thus unable to test qgroup properly.
>>
> 
> That's fair, but we should also fix _btrfs_get_subvolid since we know it
> doesn't work in this case.  Thanks,

Sure, another patch will address this soon.

Thanks,
Qu

> 
> Josef
