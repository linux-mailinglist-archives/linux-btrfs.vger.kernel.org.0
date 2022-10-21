Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6036071D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJUINJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJUINH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:13:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62629230805
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:13:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L7mtQV027838;
        Fri, 21 Oct 2022 08:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yW0M23BG+EiniFUZ2hHF1R8oABIyS+9rML1omSuISs0=;
 b=xUFJhMO5jFHPOc6q0pdGu4xZ3bl4v65eytU6okPbCWetjyXkeUovL9S2nzONCaUnMmz9
 5I09LPM1C0oL92pr7wz1KzEAKLQJrtSsaxPb+SUoIR/f4JGIZRZq2bgUOUelkCdxCbgo
 sapkZco0Lvta04ZJHNJe5jKqd6Cc43sL4mUqjlcwKMjS4Ciwxw6IBXcPhMlH4Tj81eJW
 hE4XcZ3NEbSzuzBRL4FHjixNOdcHYkvr6mPdob6OXvlvY++iWhWYigTKBGJRnwdW49rT
 jDO1XFPgI9mHmaPxoXawcINjhxpkOWadeBPqXxgFv1uJ2u1W3koib2Sql/nOns+AawYn DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtra47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 08:12:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5d9SN038600;
        Fri, 21 Oct 2022 08:12:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr31xtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 08:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2CoAEooVNlSzUPwhxixRqjWERZFpXxvxlt9Y8tdGubYv+QpjpHeSnuJ8MIMEElfmB9I6lFLsvUtbrEBBqrvqXhImVy5V29MzKitOw1+QymPP+SQWZarvWVcU83BolBqetJiuXEqoJqFru7PFiCNsM1Vn3ynv7Q0MHfNSbOp5HE+rWz8tfiSGiQbrcvOKlSsBcwCe/yx9VeOiz2/hn7uOJiSTwyTx++yOeodWznAfEpOCE0JrfIVDt+X24GOmSHvYx3fY46zT7nNM6XshL45s7oiQbna7s7MFmzWQlzIfkFEhFK4M8lD4Sjxx+a4+PMT/6hIoC81KIHit7lJ4TpRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW0M23BG+EiniFUZ2hHF1R8oABIyS+9rML1omSuISs0=;
 b=ExB+QsUhsYQWVe5O3Ot+00KzFSvseOha7mE65wyDTmgC49M7J/0FMaRFqpYoYDv+cSsSeVoSM64YuM8pK9nvkTvGDGUgD4G9cyY99dalwIy6QkbL3HL0yklNJeJiJ0Wpd0fw1Vh3oBZce1mKAGXwMq0w2cKQSxHzwO3OOBBOJDIG/ZMNOD/W14AN679SsgViRTVuhY8LnwToORT1NJ+pDj1vfgqSV4etz0VOeo1ZSeKBLe58Zaje1WVuDXRNfvrDZCt1DMI7iQQPH+MwqCNbdx89+qJL15zqKjYkEQtEftqs0wR/AQBe3TShusad+SuBY3wFuCoGw4o4nqmF4RiPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW0M23BG+EiniFUZ2hHF1R8oABIyS+9rML1omSuISs0=;
 b=XMDygkhOAFet18I+sYC96MiciI2veqx0LbvnGkDnfyqF4Vn7+EW7pGZ4cLeRUiSNBgAoL0KaKZf5L3u71SVuXEW/2V/6ef7DYeTFM9iwdg8WFDxyXBFRaQy9BWQPGEVabWDcFDpvm/ViMJK6mEEwMzyk5ZOnXolivxQfSy/kdZs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5246.namprd10.prod.outlook.com (2603:10b6:5:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 08:12:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 08:12:43 +0000
Message-ID: <7550a460-a620-24e4-0e14-24078bf5eb63@oracle.com>
Date:   Fri, 21 Oct 2022 16:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
References: <20221021004403.eAzonZxNBMdAJAaPolyLYWT1R8ItQyLpUcdyy7uAquQ@z>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221021004403.eAzonZxNBMdAJAaPolyLYWT1R8ItQyLpUcdyy7uAquQ@z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 00208c48-0a85-48f0-cfb0-08dab33c0741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3JTv5YuWiSL1sHxKeGqjUyTAI3wWQUa+Wbg3sQPkWFJL1wf17zVXPJygcoWwScCNzI+GM0EqX2Z3+WKeP9IgFsXy/dY0x5XnDp5E9JApJ7VtRUxILdHmeVA4Qs58tZe0dLW6Gxmf/NhJN7ZFTlcTwWLq2BC5mUYQpSRVeqayszEHKeW5nOIVlTNHUKgECOYRG9gk//EMtwygefU59Lwq2qjLG3WXVQ4Xw8HjASUblpqaiYzBmBR9F4QqtO60oqrlF0dWKwkDPjF+esTUlHaO6pb/2XrrTwdkyli4MplMcvtSovRR29phrngHxMy0yhPk6lix2bIgxhanj6pSCuZoxBcyhA9B8bbYt5mSLC26EKWTsggv+smDc2ikVMwmr5RGCKtNjaI+U0RT0qxN0RyMVHfiKBmIFBtfCvmK5mAFQAc5MxtHI5zphXfylzK2txZdfFrHmVIV7mhyq2Y01MRcDfykvXJ4AnkIljnX51gQl9dboiuPcxM8im0pG2FzkqbZ1Iq/arKz9UdW5fMA8OgRowGeJctmtPo6Eyo0tzg7o5Zpp/kCUcd9kAjvakgou1wbiNC3UnychARu6hUEEsAqytSKPr4GpUvmi8pvEHiQMIqwaC+fNWz6cQOlmOK2gaC6cGYxOgR5ATME4HYBT3mRBK/UU28lW1KLRMMF/S533KCRkXOqtRW0FD2dOVq9tlx7CUtZBZ0HKeCE8gotp2F9CIwOjlvZlldxIPuyrfnbofgRTQAzEX3myUTdwdtHbZVfQPq+/0+n4LuvgTa3f6+OaK+7jl6VtK/p6IrTqT2VjOj8LG3di5Hz7RbKIMOTwI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(8676002)(66556008)(66476007)(54906003)(66946007)(6666004)(4326008)(41300700001)(26005)(2616005)(44832011)(86362001)(186003)(83380400001)(31696002)(36756003)(2906002)(53546011)(6506007)(5660300002)(8936002)(6512007)(478600001)(38100700002)(966005)(31686004)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dMNU1SOC9qN3ZiRERWbVhnd1JUNmtqVnE2M3grNVFzWUdOYmZyT3NjUEEz?=
 =?utf-8?B?MGUyVFZjZXFkd2QvaHNsQ214M0oxRmlwSURpeDV3TGxTb0xEeHB6ZG1QRGNh?=
 =?utf-8?B?dnJtWHF4V2I3eFJEOW5tT3l1NHZ3NEJkeTAycU9yeTB1VGMwUThEYUJqanM3?=
 =?utf-8?B?WUFVdUN0dnNGOUhrZVRva3VOWkl0WU5kdEtwazFSTzJKK3NQNkZlbjl4dUs1?=
 =?utf-8?B?Y00xZVZIdDdjWHdFc3lNbTBzM3pDaWFjRnRoRVg2V1JSRlpHK1ZBeCtUQXNM?=
 =?utf-8?B?cmt5S1paUERhYTlqNy9uZWkxRFFsaklESmF5RVRMU2dUcVlaaG1sUmVjVVl5?=
 =?utf-8?B?Nm5mdFZqeGY2ZFRQNXNZb3orUmVhdGFqOHRWVnhSL2xwK3F2MjFGdVdOT09Y?=
 =?utf-8?B?dTNhZW5nQnlrRlpPd2FUcHprRFdDZmwyQzNJK3F0Zm5QdHZDVmNrL3MyT3Ro?=
 =?utf-8?B?RlFXdFBtdWdjQ2dnK3N3SG1WRlBvSEgzbTVxUG1YYld3eDVvM3E5NDlUazBU?=
 =?utf-8?B?VWNIYmwrdjBEeWJxYlYyWnZ1Y2JhcGhWeW1uTm1FaGs2dGVBTTJ3eDc4ZUVy?=
 =?utf-8?B?RUFTRTZZcjBQSnFRWWJxa29lVU1PNG1XV0dBaUZuMWJSaUFzeXNVNUJmbEZX?=
 =?utf-8?B?cVh2TzIyQ245RkZFQUNJYngxSkZJc05uZU1FaFFDeEhZQnBPSGRUZjZEOVM3?=
 =?utf-8?B?a3k4dDBuTmhhdDkrZ0NRdW1ydG0yeGp5RG5OdC8ySmhYbzJNMHBnZzFUaC85?=
 =?utf-8?B?eFQvakloZEVEZWdOK0hLS016TXN5a2dodzE3RjJ5d0pwUXN5bEtjRWY3MlNq?=
 =?utf-8?B?eW96ZVN0dTlCLzFkemMvcXJtY1RCYVE5aTl0M05zb0F1UldWcjgrYmVKcEps?=
 =?utf-8?B?R1NuS2dodG9IeTBxc3dXeWFmV0o0R1FOZS8zOGhlL3pEcjZjMU9nZFhZSnQ2?=
 =?utf-8?B?bnZiNjVVRHdUZ0w2UnRjYmpIbjVZeURJdzVaUElrMVlWMkJCY28xYmRjd1Zo?=
 =?utf-8?B?SWg5S1N3TE9MenRuSUpIWVNFK1RldUhyemxwOVRBbXJSQVVTVXhwSkk0aXpw?=
 =?utf-8?B?aFBvV3RQT3JQb3FtZUJmeE5RUzVaZ0JYMGhDdjI0cE1lbkRESUZMNzhnQ2dj?=
 =?utf-8?B?bE8wTzRkWk9pVW5QbkY2YVpCSHZIZllkOGVFRE9LeFk0YmNudjhtdUo2Y1NQ?=
 =?utf-8?B?dFhxbG5wZEIyd01CcmJqYkJ1NjJ5R3MwZDFUTzV6VDF6WW8vdG1SdHlWdDN2?=
 =?utf-8?B?M0QvSytZUlpzMUJPa1M2YTBiRGhZTm5xQ0owdXJRTTIyNWRBbzkwQVhVTDIv?=
 =?utf-8?B?VmIxY2o3UVFRT0gwR0VtcmF3b0l5VEY4MEFua3Nhbjd2b2E0R09sL2xsbmVi?=
 =?utf-8?B?bGMrTi91VzRnOGZ3OHh3Zkw3MVJUcU81aUg3ZjBvcUVPNVpUMjYxMnE5K21k?=
 =?utf-8?B?cWE3bWtnRFpBVS80b3lYSnUvTGVOS2JYSEdzUUhmck5rNDQxaWZBRTJ0NExP?=
 =?utf-8?B?SnpZU080Q0RQRHBUblkyd2wydzQ0MDRGcWdqcFRuT2l5Rll5QXc2SXEvVkNJ?=
 =?utf-8?B?UU5TeGY3V1VkK3FTSXZpTVVJQ01mTitmOWNXeXYzcHhtZ2hyTzhHeFpocTBk?=
 =?utf-8?B?S3JsYUY2S21WczRrY0hITlJaMDVVakJUMElPOVowYnBHTC9Dc1V0Wlhrellt?=
 =?utf-8?B?b2lFTjJ3RmlJWUxkdkEvUldIb2pxTDExbnR3SzU5dWJHSFNSUW43VlUxanBP?=
 =?utf-8?B?VUwyd05Xdk5WelhncEo2L2svb2wyQkNlaWxnbXFwVnRUeHRVSURhZFllSU80?=
 =?utf-8?B?T3RxSmw4V1dzRmNYRWZoOGtjdm1LdCt6MVdkbTdkUmpjTkVyVFE3aHdWU2t2?=
 =?utf-8?B?NmNHSU02RTZwWmxkZVpLcTJlL1h3TTJOcW1vU0FraFpaM0pPZmpOUDFMcm9X?=
 =?utf-8?B?US8vSXA4WFVDRzdQNGpScFlod1R2R1B6bE9Ga2hhbThHTDkwemhsd2xJM0cz?=
 =?utf-8?B?Ni9ZUlBhNkZKR2pGMTlNT0ptWEJObCtkWjRNdlVBamFYdk8rUGtsdGFXWGp5?=
 =?utf-8?B?dlN6a3NBL3BPSzd1Z2VFK0Uyd1hBNEtlazA0bnpjb3lid1FMa0Q1Q3dhbk5X?=
 =?utf-8?B?Z2IyZHA0cC9uRFU0QU4zUEdrUzFvTG4wcEo5QjVrUHEvU1BqYjdnb2hQUmN0?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00208c48-0a85-48f0-cfb0-08dab33c0741
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:12:43.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6mjaI20j+SUKtMWuCBnWF+scQCWQmXpGklXT3aXtP4AAupyv1R5aukQ9itbxGTViz4yxzCW24FkX6/3JkAW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210047
X-Proofpoint-ORIG-GUID: TmtZ6qAu5by0UUIRkl2v-C4FVzw8g27N
X-Proofpoint-GUID: TmtZ6qAu5by0UUIRkl2v-C4FVzw8g27N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/10/2022 08:44, Qu Wenruo wrote:
> [BUG]
> There are two reports (the earliest one from LKP, a more recent one from
> kernel bugzilla) that we can have some chunks with 0 as sub_stripes.
> 
> This will cause divide-by-zero errors at btrfs_rmap_block, which is
> introduced by a recent kernel patch ac0677348f3c ("btrfs: merge
> calculations for simple striped profiles in btrfs_rmap_block"):
> 
> 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
> 				 BTRFS_BLOCK_GROUP_RAID10)) {
> 			stripe_nr = stripe_nr * map->num_stripes + i;
> 			stripe_nr = div_u64(stripe_nr, map->sub_stripes); <<<
> 		}
> 
> [CAUSE]
>  From the more recent report, it has been proven that we have some chunks
> with 0 as sub_stripes, mostly caused by older mkfs.
> 
> It turns out that the mkfs.btrfs fix is only introduced in 6718ab4d33aa
> ("btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk")
> which is included in v5.4 btrfs-progs release.
> 
> So there would be quite some old fses with such 0 sub_stripes.
> 
> [FIX]
> Just don't trust the sub_stripes values from disk.
> 
> We have a trusted btrfs_raid_array[] to fetch the correct sub_stripes
> numbers for each profile.
> 
> By this, we can keep the compatibility with older fses while still avoid
> divide-by-zero bugs.
> 
> Fixes: ac0677348f3c ("btrfs: merge calculations for simple striped profiles in btrfs_rmap_block")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Viktor Kuzmin <kvaster@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216559
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 94ba46d57920..39588cb9a7b6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7142,6 +7142,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	u64 devid;
>   	u64 type;
>   	u8 uuid[BTRFS_UUID_SIZE];
> +	int index;
>   	int num_stripes;
>   	int ret;
>   	int i;
> @@ -7149,6 +7150,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	logical = key->offset;
>   	length = btrfs_chunk_length(leaf, chunk);
>   	type = btrfs_chunk_type(leaf, chunk);
> +	index = btrfs_bg_flags_to_raid_index(type);
>   	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
>   
>   #if BITS_PER_LONG == 32
> @@ -7202,7 +7204,14 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	map->io_align = btrfs_chunk_io_align(leaf, chunk);
>   	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
>   	map->type = type;


> -	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
> +	/*
> +	 * Don't trust the sub_stripes value, as for profiles other
> +	 * than RAID10, they may have 0 as sub_stripes for older mkfs.
> +	 * In that case, it can cause divide-by-zero errors later.
> +	 * Since currently sub_stripes is fixed for each profile, let's
> +	 * use the trusted value instead.
> +	 */
> +	map->sub_stripes = btrfs_raid_array[index].sub_stripes;

It is a potential security threat, we have to fix this in the kernel. 
However, the code is doing correct to read from the disk instead of 
setting it to the expected value. So if the read sub_stripes is 
incorrect, why not return EUCLEAN so that the user will upgrade the 
btrfs-progs to fix the mkfs instead.

IMO.



>   	map->verified_stripes = 0;
>   	em->orig_block_len = btrfs_calc_stripe_length(em);
>   	for (i = 0; i < num_stripes; i++) {

