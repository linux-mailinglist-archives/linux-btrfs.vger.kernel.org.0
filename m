Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49F5BFCC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIULLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIULLU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 07:11:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26028B2D6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 04:11:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8DNte000833;
        Wed, 21 Sep 2022 11:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=71hTSitAesJRhsz4sp+65ImCb1zkfMDwl627XFX5Jng=;
 b=HhJpF1Ks4cEFA6C7UtZI4OjddCaifEsqVyV588GJOv3f3jwrmqrbf9semBrQK6YF+TPJ
 TiMqL1tl72In1TltICfHCRBUi86jmDI1gdMGRAXwlytTWBi22zTGhchWaab9rh1VRgFN
 ksq0JAdSvvr0+fatmwzUrboxh11M4vAp0pl9Aw4Adm4uiKIWdRNCY1QZ6r3O9qW93m4g
 VjH9lXbfSAbf1kHe/+3onGIhyWMoRCX7BsUunO6rVzmMbDxM1bw+xSfuUDVXAcCoVOK2
 JRO3hTm8G0jGQrF4Zqgu5zC7+7gumf8R9dLCpeBt9AKCulMTGyEhMMS13+0JgVwhsw7S uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rhwgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 11:11:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28L8o2bA027858;
        Wed, 21 Sep 2022 11:11:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cpb4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 11:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK5HUJxmXfUA6VB0JfC/+GbSZoWrEUdFIe8q5FlaliaEdE1idcaShn7t8Aj9q3nrzCJ0PtoQp2WW2nn47goEM0djqcfU76KkSPRWrk+ZKfaAaa5zwINzOxAGq5divCeb1y4gIZjiXov2hNLJplXPQR/VgF9jT7Xm2dFphwnPp6PCkY1AGCPC/qgdMMD0R3HROgQqfqXKcYNJLoiKMIuqKsVFsSHbKZ+gwNiHFoXCCPQFSxXhvo3jPutJ6abku/TyywmZuBOlSbfI47HW5PLZkrQonrAvAsmoaMCfvwNACkK2dvErMjj2eIdJSn9tqVML4iJWf8zQKljLUHMGxUxy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71hTSitAesJRhsz4sp+65ImCb1zkfMDwl627XFX5Jng=;
 b=LOnTFUWfVUVI1+e6c4OWsqVaF6pv5PQuYbGNd7J6cTbUy51STHX8a51B+sBi0oHs5ypL+wmB2bW5er+l+pb3lfzo99eSHDcLcgVCCjuMOcluCgBmmrcy7wnFndXlQnJghvJx2pCP//07TrA0wQE2cDMvGrIEeC0VXd2EglsDD3SLQ1cNb87K0yxUedhXYDs5fpe6+jx8epv2AKNCsZ48EWVbPcfGj7YHAz2PkUlx4GpLvKPEDfJcQBuU64iCHeBQxGKOsbDoVlsdHQ0+WpUlk0yu4RyqxyWSWZf5lEbD6tvejwwyzNP9pEkV8TQAdoZstsuUteGlRHZNGpT2bSM4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71hTSitAesJRhsz4sp+65ImCb1zkfMDwl627XFX5Jng=;
 b=c403+V++/FQrwIYMvStzoycO8r4HkXlkuQB60ClWivPUs6UvjbQb5H+MPtm0+yBL4qxU4ONOnswc+MQOYqg7P6eU3Idsd2+5D7kB8dBMu+4Jh7bBBBmrL9Nss2w7Q3YwOSud9qjtd82PJfQuL2DCxpoUIUqbFj3SoEZtNdMfM6s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 11:11:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Wed, 21 Sep 2022
 11:11:13 +0000
Message-ID: <5b9fe1ef-d78a-6604-60c5-eb5f2d1e92e4@oracle.com>
Date:   Wed, 21 Sep 2022 19:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/13] btrfs: fix missed extent on fsync after dropping
 extent maps
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1663594828.git.fdmanana@suse.com>
 <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
 <ab13659e-6166-7de5-986a-54f98bc74e66@oracle.com>
 <CAL3q7H7=hSQi1gVOOXB3g860iFz9YO9n6OTdZaJtmtbduNqcdw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7=hSQi1gVOOXB3g860iFz9YO9n6OTdZaJtmtbduNqcdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2f107b-f84a-46a0-46a4-08da9bc1feb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJTPhaib/XRk0AGEVgAcq7w3pi6M2jibxYsZn4r/RZ7QQpBxud0fy8tDgz/S1ZCt54G7l12do7bn/BP11R5ixp2WJnALOUvjuZSe1ReTZwi4qYFJHaf2aWazxukhNcUCKJYxSzGjBnJ+T1FREK24UcabSlFDVs7yri3QiclMSFViwNZcO/8fyff870Aq5K1Hv9SpEfq7fD4xQhRpa2MThWm8lpXvBJAEJofT6M5IN1kvoF9UES8hjird0iAzBsJZfXf3db0FlkpC4wvElrc4duqQWJ29AC7gob2/+nJgqUWtMmn33B/NYvmEsx+JCU3gQtsDgJWoKm7zntLua0zyR9MfHZY3L99rEktEtEJ3I8BP8p0qGPwdI8Un+iPGGa4QIBMCj08PIiCDGWQamFhVlV5sHjPt9TRwjLXHHprSo2tRsK0kCLBNNB1cqV+BqlkwsJAQNF0e0ulSRzLuJpP3o8Bfg+yYJRoj47ZTulSAiHt2NkOJovHasaWwu0jDu4zylAFPBjdpODze1BvAEb30c7EIBZjxfiVegHg9KzsXP0W10ELK/RljQBNGuxOuRqzHOtiZ9jD9au0wjVPyNEnpykFe4QAyM3Xev/GHHdBY3kz140BQbH4t1PqRbOOwd7SJurAS8+H4ybwZLjKQsLlj3ve/FkeK50O3mLkYT/nKss6KqYLSaXSZbhQOMcE6z8/FU8j2hZ5IO0M64AdqFvtkCM2ybeswh3O19w5Lr7PCAMjJd0CLEsEehaDhrmbGg0LqnDrV4gYzyNl8Q4gM+Xa3bUjy/lUssYvO0u9sBrAtTa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199015)(5660300002)(2616005)(186003)(316002)(44832011)(31686004)(6916009)(26005)(38100700002)(86362001)(6486002)(8936002)(6512007)(36756003)(4326008)(6506007)(41300700001)(66556008)(53546011)(478600001)(31696002)(83380400001)(66476007)(8676002)(2906002)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVqVUtIVjZnb1p6V3Y2ZDBQU0FZQWhGR2hiY3FSaXplMlBkUHJtRlFVRE1a?=
 =?utf-8?B?NDZLYzdUcHV0SXQ0RFdVUC93aUMxd09MNWVQeUV2S1kwbzR4WG01VzVlc1Ra?=
 =?utf-8?B?dklDSmM2alBISUlwMElWZXhKc1lEQVNCa05OWUpoUS9QYTlWVDFnWHRaY2xo?=
 =?utf-8?B?VWp4REd5NkwvOEVGT291OUo3RC8yQTVWR2hITnJSRTRnSnFFUURhWmZGSlNv?=
 =?utf-8?B?eUs4WUtGNnlLUnl3bklhUWNUWjZieDBTUTRSRDBTQ1JDVjRaWWE4V0NLWG92?=
 =?utf-8?B?U29vZ3J5dmZJRlBJTHlEQllkemhQRlFTYnYzaUFSUGQ0QUc1eEFXb3hEdWdx?=
 =?utf-8?B?S2phWEVvTWNqdkpPSHpxK1N3UGlpTHFTeERLY2ZEd1lwZ2w3VlFWUHRwaWFF?=
 =?utf-8?B?VzR3bkhFQ2Z1bEFGTXNxalhYRitMdGM3cGkvb095Z21aNFUwMkU5T2N4dEVy?=
 =?utf-8?B?MXV6eDhndmxrS1UrS24rbXowUFdpT2FKNVd2V2F5amZYZmt2OE5Za3M2VktQ?=
 =?utf-8?B?a3J3ZEVhQlBudzExenE3TXUxUzNvbGRkanZWN0VCVEt1bC93RTBXMHNScEx3?=
 =?utf-8?B?cDVxZlhPTk93VXBtcG56WlVIa2UrRmEvSENiNFYyMTlpN2lCNzFBdHRFdjg2?=
 =?utf-8?B?dXBlUGxBM28vNGhYWUplSERvUnJHbExhdkpSbzlqc3hsRFkzNTJpbEdiM3Yv?=
 =?utf-8?B?Qnd1NmZEVDNkeFpDU2NET1MyMEJDK1lud24xTTVNMXdCc0N3eW14eFhndUxD?=
 =?utf-8?B?WEpEQklNSzFnYUpJRzlUVUswRFVkUG1QVVZnMC8xWHhCdXZVUmRMVktqcENE?=
 =?utf-8?B?VlIwdGQ5L3BhY2VUdlJFaWQ1clJjcGFNTFhieVRMMXF0aUhTVitwN0tQUmZP?=
 =?utf-8?B?bjFBZ0hidE1la1NRTWRUS2lDZXlKTTFGTGdTODJhcmVjRW1taXpoaEJkQXdG?=
 =?utf-8?B?ano3T25CRU9DeVpvMG5ZaTFDbEhpbUxiaFltVXZ1VnpiZzZrOUtqenpSNUxF?=
 =?utf-8?B?aGphR1g0VmJnSklYL2o3MnFrb2xJWElZZGZxWC9DSmFoODhjTStTeXAwTHBE?=
 =?utf-8?B?dDJ3RVlwcThYclhQaXQ5UDZyVUNKcmowZE5FR1I0ejhVaVFDcjd1aXExeDgw?=
 =?utf-8?B?elpxNjhiQTBmRm5zNmdydlIrQXhzQmNJODc3a2s4dFdEUCtMWmtoYkVUUWNi?=
 =?utf-8?B?QnY0b2J2YTFJRGY0OWF6ZmZHbkhaa21SYlIyeFlKR3pjc2I4ekJqMlVKNUN6?=
 =?utf-8?B?LzgxWjZ5TUtjTHFNNUNjSnVEbytzOGtwR3ZUMldTREVCdzBhc09qWVR3SHdJ?=
 =?utf-8?B?OGlMZlZWQWZxNmR6bVZlVHYwZHBKckR3NVdDazZSZlVRZVk4aVhzc0VDRmZM?=
 =?utf-8?B?Ry94aWpMRFlLT2xjZnRPbld0NzR6SnJGQ21LTC9OVVhXQnRxd2hMSGZ5YU5x?=
 =?utf-8?B?NXNyZG4xNnJLc3dXdEo1MEZlYWs5OGpxOEM1NnlIWXhibTlROStXcnVFT09q?=
 =?utf-8?B?N3c1MFc3b3JqWjNlUWhORTlmY0tvbFFCT1ViZ01LSk1oOTNPUjJ5cnZJcmV0?=
 =?utf-8?B?V2lQUkk4VGErSTBqQlh6aWswMFlTUXhZSXdjOG14YnNqd1drTkhxKzQ1TXVj?=
 =?utf-8?B?am5hQkdDSlE0TThGMjUyK1o3d3Z5NWFOQys1ZFNKbXVIUU5tSUJmUDQvd0lW?=
 =?utf-8?B?eEx4QlVQWk0rTUtQVzcvR00vbkJPSTd1bmwxS1hESGdIWWs1Z1ZRaTRuQVo3?=
 =?utf-8?B?cFU4a2xXNWUreHd0UURYRHJNazJIY21TZGxVckp3MTVNZ2tScXlOU0thc1Vq?=
 =?utf-8?B?OXpoNW45K0lUMGZ2Sy9aWnhYeHBpc09nNHV0eGJQMUlqdk1MUHc4dUFIaUd0?=
 =?utf-8?B?TzVLaFFHbmQyVHphRlhRS25JWFkxdC9zSXFHekNFSVNkNkhFcS9Vcm1TdnhS?=
 =?utf-8?B?Vi9XMG90Qk4yRzBnOEpqNFA3NzVBME93aFFJeDVGeGRTYkhRcnp3SE5vVXBy?=
 =?utf-8?B?bExJOXNSYkZJN3Iwc2RsVFJWUDNkWXJDZ0xvbjdDL3hXTzJ2aGxtMmVRRnpz?=
 =?utf-8?B?WlpVUTZQbFUyRlY1QVorMXExWkNER0o0aXRqYWszYm9EaWFXNTZTTGtqU2NH?=
 =?utf-8?Q?OwpECwybjfK3omAEvoNBvUsOb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2f107b-f84a-46a0-46a4-08da9bc1feb6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:11:13.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94/WdLU0utv38nen1XZ2RWaMVhRCQKMjNFhYw25+yMbXPaBfSX+gU4fF1lvQ+cwJPSiztN3mI1qisFbqfavXsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210075
X-Proofpoint-GUID: NCkWRiAFru0matfEkVglR7f_Zg7vS3tW
X-Proofpoint-ORIG-GUID: NCkWRiAFru0matfEkVglR7f_Zg7vS3tW
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/09/2022 18:27, Filipe Manana wrote:
> On Tue, Sep 20, 2022 at 11:19 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 19/09/2022 22:06, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When dropping extent maps for a range, through btrfs_drop_extent_cache(),
>>> if we find an extent map that starts before our target range and/or ends
>>> before the target range, and we are not able to allocate extent maps for
>>> splitting that extent map, then we don't fail and simply remove the entire
>>> extent map from the inode's extent map tree.
>>
>>
>>> +             if (testend && em->start + em->len > start + len)
>>
>>    %len comes from
>>
>>          u64 len = end - start + 1;
>>
>>    IMO >= was correct here; because including %start + %len is already
>>    after the range as in the original code. No?
> 
> No, > is the correct thing to do. It only matters if the extent map's
> range ends after our range.

  Got it.

> Try the math with a simple example, with a start of 0 and a length of
> 4096 (end offset if 4095), and you'll see.

Thanks.


> Thanks.
> 
>>
>>> +                     ends_after_range = true;
>>>                flags = em->flags;
>>>                gen = em->generation;
>>>                if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
>>> -                     if (testend && em->start + em->len >= start + len) {
>>> +                     if (ends_after_range) {
>>>                                free_extent_map(em);
>>>                                write_unlock(&em_tree->lock);
>>>                                break;

