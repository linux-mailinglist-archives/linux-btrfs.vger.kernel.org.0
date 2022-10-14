Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B255FE614
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJNAKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNAKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 20:10:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD036BC6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 17:10:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DM7N9G026507;
        Fri, 14 Oct 2022 00:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6eZJgeIHPQLO9yZh2ZsBSQE3qwZQJXpjprEZk3/QDV0=;
 b=AQOcCSHWIiPN5W9kDwWwQ5tbFrezzgQXCcWHlHa4vA3F/L7zTRDXwMP2b2Ip6AuWk9at
 Vdjwx9ujWc1dmUaPVZkLD1teVs8r1pHe1zl9w3VOvDEZaJ6FcYHUXzmRG4Kti4XCps/I
 rqcCrsFjZYFVpZV6w+S/aISqY0mgF/fwJvDGOO5H3oOnGyHJp+uDYoEXn+O5duqwfjv9
 eUeDRcZ+oh3DLyjVTU9WEFI1ylxZvYtWX3oft2/CVxZ5iGQ64D0SKGQ565nmHghm9N/Z
 NkYvypUlTtsvhKiXhr9GDcIwbL4O2EAy7fiimTo+Nvh8Vya4R+siKA32dfDEMv9B3okR 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6r4v8kyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 00:10:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DMD4Sq036407;
        Fri, 14 Oct 2022 00:10:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynd9rgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 00:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6T/3cIF2Kpg7RTTAjTVjpT9Ollb3eEmOfPUS71Kp2sWvwZjViBG0u9svZEFd8ri1zR+NxGCRl7MgXzdFRuolIHKmiMptqYbNYZ720E9JBn82X55sDWgCrLGuHW4tu8HXa9uhzQcoV26I79X8LQioh7oOfSlHmU7MPBNMZB1ntFX6sBnGzq/c/n6LqGA3HR1K3jx9wqoCFAjScwcrX8jE1LCBTMtSRp2tDUQSBf3v64BJJPQFO4dES4Oix2QlJQdq7MH6PD2S7zlxR72doexIijmcHIgsFzaNZy9UuBlPGFSfx6ajGYC7V6RwaWZRq887OsPzV0u8r+tkjv7x4Ek0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eZJgeIHPQLO9yZh2ZsBSQE3qwZQJXpjprEZk3/QDV0=;
 b=WS+HvHZ+/Zpv6pVweVDVf8TYoKWaEKfBXoB4m12fR38HwpXijpFjBmTbHvBdQhx1kigm3vpvDTGEmT3W97SR9Rg7PTfCz1Uf8rchP0kl9aGUwfm+q+tr+jAJL3Ekeg8Z8TXgjomzMWF6nOcHbO4arYx97U9XzY1qU5CvgHBt2AgDej6eGEki7aq2HWRT7oomHbcfWbh0s+GA5fHdMWo8gMvKeHGKuQQx2WOHvLpdPuIJjRNqgC65pCXgEDsH8SYKjjk8UMK3a0H4TU3lg3VFIkomTubyrhlv9tcMLgiA9OM3W7fVEHZrN9nh4X/tP/WP1xTNOku14CiCRBMB7FRrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eZJgeIHPQLO9yZh2ZsBSQE3qwZQJXpjprEZk3/QDV0=;
 b=V+oje0BpCzPtBZsMDT0nUEfjYhaa9lC67CgMPT5MB2nhcn/K26OMBqpFRULKm+aEIEaAetRO10juHIZDwO8r/IWmnrnKQ2/flg9IUNYX++OrLPg4ELPdb83uaTUBFk/TwYse9dem6k+1NrWLvy3G2KV0EeMhEeBfbE8Ur6z4G9c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 00:10:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 00:10:07 +0000
Message-ID: <b135361d-58ae-7bf9-fa3b-d11d5d5faaf9@oracle.com>
Date:   Fri, 14 Oct 2022 08:10:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
 <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
 <65b15910-fe1a-b6d7-2431-4badcfa0b134@oracle.com>
 <96de6625-fb23-b44b-b4ab-9aae52ab70c3@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <96de6625-fb23-b44b-b4ab-9aae52ab70c3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 05acb389-21ad-4d57-4560-08daad7873a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhnrjgFRoyygWxdENWI0/WqxFb4XXoK16vhpe4uhaPQbHU7uVIjUo7RXp8dHXT40GJCbYx81oPl40UYihRjzbApAQYkpRwkO869CIrvGBtd9f4yEpzHyPHuki6lra1PGp6s711DOKYzjZB5+JNyegOMwMnrJC1zuWM/9Ep2lUkUAAIWGDHKuoANZ8za7yR5RFz6ZzlsCq/XAz9vHA7f6DPa9GG/K66g+Hk+z5lvKDtj/s2SUdbKL2NsPhBv58Q1MmfmWcwmPA1l5KqeULIfY1HBgmkuC6F05lDXLFhU9VPd9kTTHqYCb7MnMUb8x9kiItbCUR0NNJ6noRnxybYosz1w10WREeiVBMqcFmGmhL4rLOn6qd6X8/xTn1kLLJvb/hR2yAPwUYgv+14F9MaW5mN9z/uz8M5Bfkt3oGmU7M00sbNCU5OD0TTPuTlxkcJG+MN/N/Epv1+0/IOonPOeZF/mpPmriFj2WQcSEyCrPOf1ce/0raC9cTc3k9wh9wq5M865AlRCGUf8JFQ7U76Na/9gKoeeoDNIsUp/wswe1LsrniGyEujNm+CZ2O1YnuXW+XUlgq/6qFJgfyjSdxBfcCf5WW3p8DgEQrvynQ2VSyeW0u6EGFADsvvOfgbhJkwRxlpL/2li7h+sx2/4SmPa+jimyYH8jW3OttsJzweN4I/eYKK13QpjQY7Pa48av5xRXHz8uwsUFLWDAaIFrI2gu1s1iMl6zWK1laGEt5x/d959ZsmTmTBSKp6H/IoIDwPjb9zizSijQP8Hmz+/ZzgDXoxB1msfhfQgkJfRz5vLQqqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(31696002)(86362001)(38100700002)(2616005)(66476007)(66556008)(2906002)(66946007)(110136005)(316002)(8676002)(36756003)(5660300002)(41300700001)(26005)(6486002)(6512007)(186003)(44832011)(478600001)(8936002)(6666004)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNaV0ZTRkhIdkdrSk5HeEVSUkRCeitvc0NmMUxKNVlMYXFSdExrUVcvU3hF?=
 =?utf-8?B?NFFtTnRuQUh3dXNVN1JEWllaWW95RlhENEtIbmI2K0hvSHhzSlhKUXlMeS9m?=
 =?utf-8?B?enRHSFBBVTg0OExLc0VBaWtSekU2N0VtTytCYkVsRjRoYUQ1bEdVM0R3QjNy?=
 =?utf-8?B?K2IzRWNUVmJHa0wzNW4wRFZiRkNZQzJxK3d3RnY4YllzV3pLcUVTMXc1ZjBE?=
 =?utf-8?B?NUJ0RUp1KzRsM1F0KzZCTnhxem9OSDVNRSthb2Nib3ZpTkFzWVkzTlliY0dn?=
 =?utf-8?B?K2F4TitWMXUwZzRXczVJTEdpSWwxVFBCVzNSZGZOLzdFRWd5MkZqeURLK09s?=
 =?utf-8?B?R2dxWkcreHQyZHd2dkVVSzJWVXlWeHBhRXhKc2ZtRmdESkNTOEtnYjZ6cXFn?=
 =?utf-8?B?aDE1WXVqcXZ0ZFRzL0VhZ09FU1hZUXdteUUxdjBhUC82M2xlR2ZZVHdrTjNt?=
 =?utf-8?B?Y1FCaitMNHNJR3Y3ZEF5Q1hicXc5OVBLV3IwTXdEVDdDZnp6QTNZNlFBUzVP?=
 =?utf-8?B?M3FkVTUzdDBOYlRpQTU1djBaTTBjNVJINUg1Ukt3UHhsbk5ZMFRhdkg4VTha?=
 =?utf-8?B?NzQxNDhEZkJucW91eU1HVi9Ja0hLTlNoU0ZWRWU5K3NSNzRKQlJTcXRhOHVY?=
 =?utf-8?B?Q1dBeDlnR0o3Ukw3aTN3Y21SeUpUekp5MTdHeEJnd3FSS29weFl4MDFzWWFG?=
 =?utf-8?B?Tmc1MVJjMHBHMjJWb2pUREtjRXErYk9ZNE1wUm93YmgwWHJkZVhtRFpJVDU1?=
 =?utf-8?B?Qm83Mi84akhpYkwxbkVVVysrUzA1MXN3c3VBNjg3Y1dwYitmVlQ2V2ZBMkEv?=
 =?utf-8?B?UW1QdzVjaHZBcEw3L2lmV1NXTTd6TWJPblR2N3F6aTVJRW9Md2lmMkdvakRQ?=
 =?utf-8?B?ckh3M2EwTVJJd3RVZXhyNUhrbjlxWEhuczVPc3pkUXlKdklMQ0w3a0pBZlJL?=
 =?utf-8?B?aG1OODZHWk82V243N1FxZk9TNlA0N0JaUDFZNXpsdDJVMFJVMEU0RzJiSjZV?=
 =?utf-8?B?a1F0cG1YUWtBZllYVkJ0ZEpCdjdiY1ltSE0xYWI0NEw4L0MvUC9TOEhLalFV?=
 =?utf-8?B?RUd2QnJ0cFRZS09qRTVkbHFnZVYvcllvQnh0TVd3MjR1WCszQzR3NUJLZEp6?=
 =?utf-8?B?Rzc4Q3ViVnl2MTd5cEJOeVhNRXVVTExkOEd0MDV4cy9vWXNuSFhaWmo5dkdl?=
 =?utf-8?B?MjVDY0tFM1NxSnNueE1CMmFNWC90Zy9mS1R2UjJaZzFBbFJmclNBaG0vanZa?=
 =?utf-8?B?aERQei9UU3lkVXd2WHQ5VVNhVTJyc0NZejZ2NnBLVmVlVmVGeGc3MWpJZXBD?=
 =?utf-8?B?bWZlaGFPcWUxNFlHTkUxWEFnRmk0UGpUMldjT3JDQWpEVGFFcnFXaXJtNmpu?=
 =?utf-8?B?Q1BvZURqSXMralZFQ1RtWTdEU3ROZWFUS3VSK3NsMi82Y29mbTFkNEtmQmFY?=
 =?utf-8?B?QmZ4K1pMODFNb2ZVeFQvQ3BlaEdCNHJFMy9VZStqU3ZmYTBQRkg1c0tjVzFp?=
 =?utf-8?B?TGJObHlSZkQ5T1BFZ0ZMMmJKSnhwVWRrZ0RQYUkvNmN5NnlYdVFmQzZoeVdS?=
 =?utf-8?B?Z0Z4NkUxeldNSXRNUGlwZW53c3dQaG9YT0lwME5yellCcjRJMXhNOW5qbHVx?=
 =?utf-8?B?cUpkeGY3ODEwU3JuSTBVd0YrSkVMR3RQQUlXRWZMYjA1S0FZVW1CYTRDQ2E1?=
 =?utf-8?B?ZVEvcHZpZmQvbmpwNWVKbE5aU3NEZnhMMlVOMFE0N3NuTlMrQ1N6ODBERWcx?=
 =?utf-8?B?M3JocjVOR0FZMmgxd3l5UW1lOUdFbjY0UnRENE9TNDFnL0wwc3hnL05FOFh4?=
 =?utf-8?B?anNqYWUyYStlMlRPMDl1bjRrVU8vMGZoL3E5c2s2cW5Zb1ROcTRmZTlHZTZL?=
 =?utf-8?B?a3poRUlMT0w3TnR5Wll6d1V0WFBmQmlHNEFoV2FVUkQ5OGxDSzlXeUwzYllk?=
 =?utf-8?B?OEo2OStTMy9UTFgzQ0c3NFJ2M0NsZFZzbWNlNTNXVWpvVjBORHEvQ3ljNXA3?=
 =?utf-8?B?OFhzaDdKNUhMTFdXNEVPbTl5UXJuY0NVRmxIMHhFcEYybTFyTzA2cUw4UDJ1?=
 =?utf-8?B?cUhJQmREejQwMnd6YnptOGpSV2pyaDJ6YzRMeGMxVVZ3MXB5TkxycFBEeHBz?=
 =?utf-8?Q?7jX81mM3Imo2sCZo0KYkICdmD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05acb389-21ad-4d57-4560-08daad7873a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 00:10:07.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLM5ByC6RXb5gfHjp7bdGuFQGu1FDIbvBDV7olgUiEf09yMsgu7onWrRnNazReSxNsxD5yWX7tqwjm0VQuMu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_10,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130135
X-Proofpoint-ORIG-GUID: yEJo0uPDlpMleLxYUfcYsG1d1yKsBDkx
X-Proofpoint-GUID: yEJo0uPDlpMleLxYUfcYsG1d1yKsBDkx
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>>>> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>>>>
>>>>   Why not move bool mod_init_result into the (non-const) struct
>>>> init_sequence?
>>
>> Any comment on this suggestion?
> 
> Why you want to change the init_sequence array into non-const then?

   We can remove an isolated array mod_init_result to contain the result.
   Instead struct init_sequence can have results as a member.


>>>>> +    /*
>>>>> +     * If we call exit_btrfs_fs() it would cause section mismatch.
>>>>> +     * As init_btrfs_fs() belongs to .init.text, while 
>>>>> exit_btrfs_fs()
>>>>> +     * belongs to .exit.text.
>>>>> +     */
>>>>   Why not move it into a helper that can be called at both exit and
>>>> init?
>>>
>>> IIRC the last time I went the helper path, it caused section mismatch
>>> again, as all __init/__exit functions can only call functions inside
>>> .init/.exit.text.
>>>
>>> Thus the helper way won't solve it.
>>
>> Really? Maybe it was something else because, I see it as working.
>> As below.
> 
> You removed __exit, which removed the section type check.

  Yeah. We don't need __exit return type in the helper function. It does 
not make sense in the helper function.
