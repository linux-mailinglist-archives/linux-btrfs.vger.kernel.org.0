Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFC4C6D35
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 13:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiB1Mw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 07:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiB1Mw0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 07:52:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7377A8C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 04:51:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S9nQsf021519;
        Mon, 28 Feb 2022 12:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GSw38MFFrDS0ioAtIlH+GZKo9DnQPY0gx+9y9GSQWtA=;
 b=ow5ACpKkxCOgU6ejrD0H9FoqufNPPanSuixZKXVDHdxkV0tJDyKGiVg39e4LT254pKsK
 Xft7VpOyyF0/M5BULybnVXwwkYTzhipwFnEwlPas32gtip8wNRmunSDRCQa943Z2OcoE
 G9YlTKnvpMA0X1R7WKYAHSexGX8zdBZQQ419DQM3e7Jat3aBNwLFEs/7GDt0UL5DqEdz
 4ub92+IEoFUL3GK/o9mT7rwCKnIBCXMyRxHXjJh4EDAnrvEYhCVqIB89Ux0ojrMmbPa6
 5RIO9aMHj6H9rc/lOIOk1gSqBKOZcgEPJQVG/6SIhNastxlPXssryFEjD07YYDjuUpgW WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1v51q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 12:51:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SCVsdL123363;
        Mon, 28 Feb 2022 12:51:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3ef9avep2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 12:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdfojkItp6UM+86pDnYjYQIjroQTCHTH4rDpL5dN+qcjxTS9s+OnCpXnEZLc7KXHH7LxlFVZcDczcYYKgrD7JVleuQPecoolDm+eHUcbFHBQtJX3pqjrFJAor9w3FfxJDdkaKE0Vutpo7xvyCgqt5caNnxQDFrgt3MCzvaIwcq6ySbOxWMVhAmoHrPXBEwIAKdpPCJT0f0ZSsNdIdDvEaBbUwd4XLJvU34O2QXy1lmZ0IG7j5VnnoBkIO5hizVaa/qtynFxvEftE5mZuDwSnWUWgs0oqHI4ka03C7bLdQtW+oqZYdW9OiNKG3i6boYtjtcLbvca6YfcDOjMB8VLdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSw38MFFrDS0ioAtIlH+GZKo9DnQPY0gx+9y9GSQWtA=;
 b=NTAYXaMdftoqqipWtb/7lFiZdouE+aVVAvY152GTWUCO1WA00Rz1l/JAv5/YnbNlD3SBYCu7TtYc1MFF2jXVyGR+ZATWtm1BdL9BEYcbJ83TsFfBytvCuKe6D1IecbMN/hoYdqEvV16NLMEsJz3bgwLmSPWtG3XaagTk1A4ZbqxUw/IzH1JYttanuVPfncfG+Qdl7Fv0WtqDfVm8SmlPwzd1Jg+Gh6tClHD40YV2xehqVJwz9gjD1RvevTaUuI6BvTJfSu7bVd4CyBzD029Dg7o2YE5mFFSPLJvsl5cClgeoMCVPemGk6Z0/fKs1fmgtiWEM09DZqOD+equ4OpHUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSw38MFFrDS0ioAtIlH+GZKo9DnQPY0gx+9y9GSQWtA=;
 b=SbQaSUlQI0IIVbLoPoEQHEw/Sv+M5mnliN8K+ZFhj2Mx9amRU3hSfYWw+qK+zSghC3B+QoRIcd7sabYW10KiCBGgSvsm4vN5WJJWIQI4QY1pD1yWe9OxCaG4DtTKJwMNp6o9P9UItURrr7Xr7W21MH1zQn9CTgJCbvH8RinqcIA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 28 Feb
 2022 12:51:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 12:51:36 +0000
Message-ID: <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
Date:   Mon, 28 Feb 2022 20:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
 <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbbbc103-145a-46a8-5feb-08d9fab90e1b
X-MS-TrafficTypeDiagnostic: MW5PR10MB5807:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58071D2F2D58CB49C0086F4FE5019@MW5PR10MB5807.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieAhT2j5IlXKt37Lw6WqV6iWphiDwCll1eWHNFO+7eK84gNj9bxtJUmlXAqv7FRKmQltTGJtAsUmKjd9FTmYAk4ftS1bPquwT61LYChUeGYBC8tqstKxK4cP4v2/NMVLrJa8CbH70v+Lg4BcoOpJy6Ro9eIw8XKdeZV41fY+TnxV64bpKiDgnNaCzyO0BYicnNtPzKZa2QZZkO/+Y8Nxo0NgpPbLlqt/zdsJyT7BsZka71Fy66hwDSQ+DEAKR8NsJ7YRrklPOlK5DV7k1Hb88Hke/02c4o1NNHH6E3rlQviMGHz+tFEMjcnm9rM3tgT3zQCQqYQWu0sF/+pbsTQLh30HOGFEPEudqyWvhVN83Ri2LruzZd9aDCWmYfRfdlXbN+Vv7NZ88yeI9VHEMtsACnHNmKcF+uaoHM2q8kWlELm8gRCb6qaDbPKqgAKEA/sADpw+mLeCra4QU1jlpVOPdD+At+vmSETIR/AeME7fLjBrpGfet+HtPGM0CF61cUvFZjHJ5cj+UotJE+Dce8yq75/3SwL+B/WwiYvf1+bfAhv/CFdK/OLXxPtSPIG7LoIP3OAKsMrh80SQeVQabkzlpD1YvE1AIR/B4/2pZMmC/JUuImw+k1itXBy4UvAop50s4qSizhnndf79B5fK+4vaMFjCoqJ9KswAucWr9/IWzPjvW5wP4liGWSSW3mA0bhWGJR1Rli4ygii8P3fU7+upfv6nF/14Re+qHICfaLepnVAP2Xdwb+UXih3+mRvmq+pyFJSq1B10R5h1mnVCNTTHZQrHIPbNX4tV8BtDTnG2LLVfrLU5+qr4B0Wm7XBC0cM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(6486002)(2616005)(966005)(5660300002)(8936002)(31686004)(26005)(44832011)(83380400001)(110136005)(36756003)(316002)(6506007)(2906002)(31696002)(8676002)(66574015)(6512007)(6666004)(66476007)(38100700002)(66556008)(53546011)(66946007)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxDdndqVjJLdzJtUUoxWXArKytINEtCOG96V0lEbUFYRDNwM0l0VU5zeklI?=
 =?utf-8?B?Y1JvcmRUTytGbEgvdkVtMXZGdDFoNnR5UU5qKzZhRTdWNVN1bDNWYjlNQTVr?=
 =?utf-8?B?alpMMlhINWtoK3RYWjlwSDBsbTdya3BKTjA3VHp4WHlMQmI3cVZ2V0JNaFgx?=
 =?utf-8?B?NTlNL3pDbHNNZFkzTWtIeDFTOVhNbi9SWlJJdy9XL245cHpUeFl0RnBPaXdX?=
 =?utf-8?B?czBQOUpsU3Bsc3VIYWtWVWx6bitBZHVoY0I5MG9OK1laZUNFWEp3M0FSS01H?=
 =?utf-8?B?aEVPM1o0ZFBUS2ZwT2o1V3ltaGkvU0t1OHZqNWl1VmNlampsY2EyTE03azhh?=
 =?utf-8?B?Y3NiZGVwVmxmOUtORUxTbDBBOGlYM1dLaWlRa0huaWFqaVFJMSt5L1d4WXpM?=
 =?utf-8?B?L1ladlNneWxMbUVTYVJpRkphZVdVb1VtVnBhU0oxY1BoM29vLzZsRk5lME1S?=
 =?utf-8?B?RitIWnV2a05aaXJDRTVXTG1PS0lxN3pkUFU2RVJLd09Od1lSVDVKOTJOYzlW?=
 =?utf-8?B?R29GUHZYT28yMkVmYU9QbkZyZHJIWnRHY1FiQzkzYWFzcFpxZUQyWW5jY2NI?=
 =?utf-8?B?RzRjazNNb0VOUStCNEtiRHJmOGI2K3I2STZvRVNwNzJWMkhQRnIvd2JtKzB3?=
 =?utf-8?B?U29rcGl6Q2QyaytCUFNLbERuVnRRdFEwU3N6Q0lkQzExUmttUmdyWFdCWjdo?=
 =?utf-8?B?dzRaWDFwLzlaZHlQUEt2VzFVcVFNZTNPNUxPYjVwZWxUbFNTc1U3ZUZyZFBH?=
 =?utf-8?B?TUdzdHBMY3VZbVNkM3FIUkNoazcrYUswZ2JlUnIzcTFVbGZ0SUhreldmRzFh?=
 =?utf-8?B?cGdkK2ROWm4raDJlYlRHWHNJVmFyVmJLaldob2ttVUYrUThUYXU4QjdudERB?=
 =?utf-8?B?T0JaNjVNeHhNdld2cTArTXpNQWYvUVhXZjhkRENkQXdCNk85STBIVWN2UGds?=
 =?utf-8?B?WGUyKzkrbWM1MlZ5V2xaelJKSGVFelBFV1lSOExXcjdXQWZON0licFBHSFRM?=
 =?utf-8?B?c0FBdDBMVTl3WlJ0bXo5YmdHYnpvV24rNk9KeFN0VEJrNStjd0RMRmdaa3Y2?=
 =?utf-8?B?SWFxeFp6ZjVtcGppNFMyRXJ2TFhDbUpnY3B0MUlYWnVmTVJBYlVkc3B4QVlV?=
 =?utf-8?B?SlNhNll6MnllejhuRUJQTFdyMDBEVVhLR2tHbHgxNVF2dW1BdURuUnRWUHZO?=
 =?utf-8?B?WmUxY1lPTWp1Q1prQ2FpeHhKdjYzS2U2Yzd1R0Y0MVpCemJXZ3cyWE5JdGdu?=
 =?utf-8?B?eHcrRXNIS1VrN3hwdXBLbXR1RmIzMk12SVJmaUptRHpZMTUyWm04YzltbVFN?=
 =?utf-8?B?U2NqbVgwMTA3Z25hS0F5K1cxdnZ3OGhhR3dXM01pczU0QXF1N3dybmRtV2tL?=
 =?utf-8?B?dC94MkdEL2JyT1RkUkUvczBsdldxZWkrdlNsWmxHVmR6OURHd0pWK0d1NWcr?=
 =?utf-8?B?SEhEMklKRnJHd2FBb0N3WGhlTGswU3pPUEpub2dIbU4yTVZjWmlaQ0doOFdz?=
 =?utf-8?B?K0RKZ2g3YjREWXg0a0k0Sml4dDIvWGNYbFFJQlNEL1FWUlBJNy9Sc2pqMHpq?=
 =?utf-8?B?ejI1d0VUbWhlVUR5MGZGNEQ1NC9Va1JxRGVrcTl1SVUxdjJHWDNHeVQ2Lzlu?=
 =?utf-8?B?TGtucXR2RExnelVrUTFPWkJFc3VyeG5HSmN1b0VMaGtUTDQwMDJneW9iVjNu?=
 =?utf-8?B?cHBpRlc5OHRQRXpweHlRSTZRSEJzeC9sV1R4VmFQQWJydGNQdDUzMEozcGYy?=
 =?utf-8?B?TjRvTkJnZDFxcm1VdjhiUUlIc2tDREM1OHpUQ1VHWCszTDc5NDZUQXpWY3pN?=
 =?utf-8?B?OEI4blpiN2xRVkdnbUFqTkgvdU4yOE8wb1ZiMk5zNEQ5b3pCS0xNTFpnVjNU?=
 =?utf-8?B?L2tNUnpnZmFLa21oVTRvRDlzaitoZG41aU9qSWpNa0lGQ2g1TSt1aHRkL1Bn?=
 =?utf-8?B?TktDaHE4OEtiWXpUWWVsTzRnRk5hWG5DODdhQ2VYNjNFaXlYMzV3cVFtVk1J?=
 =?utf-8?B?QUpQYldmUTNscW9jSEZnczlXUWVldUJId2orWEJuYk1nUzRtMUVrQXpqZ3o1?=
 =?utf-8?B?Q1lXc2dYYWF2UmdGRE02Z3JVMFAwZURSSnVucmpVT0FEWG1FRlpiNXpKNnZ1?=
 =?utf-8?B?T0RNUUNrL1lTWUYzZmc0YnNZNG1rLysvczNjbmZJTlhOVjdpTmNBa241NERl?=
 =?utf-8?Q?wUHJM0MJI7H331lj6zTxY8c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbbc103-145a-46a8-5feb-08d9fab90e1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:51:36.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW2r0XWjvkIcKcL4erObknZYmzh9/3cBTf0OKc4FT6//Wal+fEM6VVu/TeTF+uKx11ulYRaBWe8gEedOuKE1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280069
X-Proofpoint-GUID: 3P_X7JCcGZ9fR9JReTjMm8wTwuNLf7zD
X-Proofpoint-ORIG-GUID: 3P_X7JCcGZ9fR9JReTjMm8wTwuNLf7zD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 17:21, Qu Wenruo wrote:
> 
> 
> On 2022/2/28 17:01, Anand Jain wrote:
>> On 28/02/2022 16:54, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/28 16:00, Anand Jain wrote:
>>>> On 28/02/2022 15:05, Qu Wenruo wrote:
>>>>> [BUG]
>>>>> There is a report that a btrfs has a bad super block num devices.
>>>>>
>>>>> This makes btrfs to reject the fs completely.
>>>>>
>>>>>    BTRFS error (device sdd3): super_num_devices 3 mismatch with
>>>>> num_devices 2 found here
>>>>>    BTRFS error (device sdd3): failed to read chunk tree: -22
>>>>>    BTRFS error (device sdd3): open_ctree failed
>>>>>
>>>>> [CAUSE]
>>>>> During btrfs device removal, chunk tree and super block num devs are
>>>>> updated in two different transactions:
>>>>>
>>>>>    btrfs_rm_device()
>>>>>    |- btrfs_rm_dev_item(device)
>>>>>    |  |- trans = btrfs_start_transaction()
>>>>>    |  |  Now we got transaction X
>>>>>    |  |
>>>>>    |  |- btrfs_del_item()
>>>>>    |  |  Now device item is removed from chunk tree
>>>>>    |  |
>>>>>    |  |- btrfs_commit_transaction()
>>>>>    |     Transaction X got committed, super num devs untouched,
>>>>>    |     but device item removed from chunk tree.
>>>>>    |     (AKA, super num devs is already incorrect)
>>>>>    |
>>>>>    |- cur_devices->num_devices--;
>>>>>    |- cur_devices->total_devices--;
>>>>>    |- btrfs_set_super_num_devices()
>>>>>       All those operations are not in transaction X, thus it will
>>>>>       only be written back to disk in next transaction.
>>>>>
>>>>> So after the transaction X in btrfs_rm_dev_item() committed, but 
>>>>> before
>>>>> transaction X+1 (which can be minutes away), a power loss happen, then
>>>>> we got the super num mismatch.
>>>>>
>>>>
>>
>>
>>>> The cause part is much better now. So why not also update the super
>>>> num_devices in the same transaction?
>>>
>>> A lot of other things like total_rw_bytes.
>>>
>>> Not to mention, even we got a fix, it will be another patch.
>>>
>>> Since the handling of such mismatch is needed to handle older kernels
>>> anyway.
>>
>>   Ok.
>>
>>
>>>>> [FIX]
>>>>> Make the super_num_devices check less strict, converting it from a 
>>>>> hard
>>>>> error to a warning, and reset the value to a correct one for the
>>>>> current
>>>>> or next transaction commitment.
>>>>
>>>> So that we can leave the part where we identify and report num_devices
>>>> miss-match as it is.
>>>
>>> I didn't get your point.
>>> What do you want to get from this patch?
>>>
>>> Isn't this already the behavior of this patch?
>>
>>   Let me clarify - we don't need this patch if we fix the actual bug as
>> above. IMO.
> 
> Big NO NO.
> 
> The damage is already done, we must be responsible for whatever damage
> we caused, especially the damage has already reached disk.
> 
> Just fixing the cause and call it a day is definitely not a responsible 
> way.
> 
> Especially when the damage is done, you have no way to mount it, just
> like the reporter.
> 
> You dare to say the same thing to the end user?

You have a btrfs-progs patch to recover from that situation. Right?
Plus, I suppose you are sending a kernel patch for the actual bug
which is causing this corruption. No?

This patch is the reporter side fix. I don't encourage fixing the
reporter because a similar corruption might happen for reasons unknown
yet. For example, raid1 split-brain? Which is not yet completely
analyzed and test-cased yet.

In my POV.

Thanks, Anand



>>>> Thanks, Anand
>>>>
>>>>
>>>>> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
>>>>> Link:
>>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/ 
>>>>>
>>>>>
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Changelog:
>>>>> v2:
>>>>> - Add a proper reason on why this mismatch can happen
>>>>>    No code change.
>>>>> ---
>>>>>   fs/btrfs/volumes.c | 8 ++++----
>>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>>>> *fs_info)
>>>>>        * do another round of validation checks.
>>>>>        */
>>>>>       if (total_dev != fs_info->fs_devices->total_devices) {
>>>>> -        btrfs_err(fs_info,
>>>>> -       "super_num_devices %llu mismatch with num_devices %llu found
>>>>> here",
>>>>> +        btrfs_warn(fs_info,
>>>>> +       "super_num_devices %llu mismatch with num_devices %llu found
>>>>> here, will be repaired on next transaction commitment",
>>>>>                 btrfs_super_num_devices(fs_info->super_copy),
>>>>>                 total_dev);
>>>>> -        ret = -EINVAL;
>>>>> -        goto error;
>>>>> +        fs_info->fs_devices->total_devices = total_dev;
>>>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>>>>>       }
>>>>>       if (btrfs_super_total_bytes(fs_info->super_copy) <
>>>>>           fs_info->fs_devices->total_rw_bytes) {
>>>>
>>

