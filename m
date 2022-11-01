Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D036143D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 05:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKAELC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 00:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAELB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 00:11:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330811581A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 21:11:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A13Fxws021573;
        Tue, 1 Nov 2022 04:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5W1JM6zZkNwqyC3mgAMtDUvZLTSN/0vZD3W2xH+b5Nw=;
 b=xWxnAq2Jgclym6MrtlMzZUnW40XpUvRfDBA8zUI0NoS25QjRP0xk42kUF3IWGAeFZLZq
 u+BswW+198n+Kk6GvzetHwADlM71TBS9vK2ue6OYmCrre0jGMYaZyJi6unb3Ln8lsazn
 QUsk5RVu2Zd66WacfpnYYNdhEU4ZbJ2CPMlYxb9oh2cHDRzk6D8HVrk7Kli6+vPmx27B
 fVR0nO28/Acw9bcqmJCsolFt4s6ZUV+4+wkTCMMDWtKpSlJyHK1taUgGZcQC9KWZ8ad4
 QdkP/MXqgyD5tkpB6QoXRzym3k6hYeQ6GKdHE8pgFiprOITNpwRuFAiFwc8W8+5C/yN/ RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2wmaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 04:10:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A13oiag037268;
        Tue, 1 Nov 2022 04:10:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3yt8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 04:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2WKkBiJT5HdH0zzpIyJTy8jQcST6+QlPqCktGe2UWuvgcziih7Ob0HvL9iy5+AfYw04ki2OyTgolrUhkW6HiCOF26jUvllZNrbjKgLeSI1KC5lJdoSQrUcth+gojS/H2VN50ZN2M9SZ+UpW44wM1LWX2+pA7yJ59cN6E0+06dX5zCQeyUAZhCKefqnmewGYCWyfnqM9Z/vP82SNlWzcRczAngbfK8bDdNpDr2GU2um5T+4TVUo+Y9LqzEwXhVC0QtQvjrLKQHdY3RigHyPK1/w6rwGO0hdxHwaYOHOFf42P1twFlA51hXPQoN2Fzrrc5YGX3cexZSPymoWOy4Kwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W1JM6zZkNwqyC3mgAMtDUvZLTSN/0vZD3W2xH+b5Nw=;
 b=HaUMC3G2jl+I6Asfd0rzb/LdMVIEKMY+q2BhpsEmkXZMHHfvCyeucqB7EF+WY7lFNlagMh0bF3iZk7rENmNYQbebqeTwRk5KMNSNssVcxxV7WpbOGIlP7nINKEdPlbiy/fBM7KrNndJMlbYz1H6TCNSyoRqNIFWdeZl4Wxz73DYadBL+FA/YV+fUvFypvkxNVIuYRoQNMNiNYDjVCZZs/LHIV+kjnM/NtBpBP0RLrW/LitqcyLl0u71SP2Juz5iXjyivfIeqOi6M5CJ6TH8Ax1vQjdkhn1Xk6qQgveTtJinY6DNsyesZh6BngYbSpSKBusX0kb5RxXcXuckeE750ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W1JM6zZkNwqyC3mgAMtDUvZLTSN/0vZD3W2xH+b5Nw=;
 b=0Fjy4PbezHA/+kisQ47IxHeF77B+GHM5JwjQw3Cqm4MQrM9Z3uRfLGux8vKZyqUFmRs9sgciATn1p6t92RSU8O8xsaLXcmCU5ZzoBjLj44kWfoYO+fQeW8vSTsByGQ2uAkejPT4GMSxqehou/GzKH3R+Qc59NJxlvMR/Uot/VQk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 04:10:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 04:10:51 +0000
Message-ID: <93a2df66-a60b-47a7-11af-24861fb22d86@oracle.com>
Date:   Tue, 1 Nov 2022 12:10:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/3] btrfs: Fix wrong check in btrfs_free_dummy_root()
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, linux-btrfs@vger.kernel.org
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
 <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fac86a-28a2-475c-f5d4-08dabbbf106a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW5CEh8krVjqGHH/mHkqB2yC7Umj1MEMHmkeqUL85kBj5FS6Y2WiYyUXbTWyO1UF7RnI+XJ4VDPGdBtgwVAAkgQZtrNPrIO86n5u/P5kNrpm+nCGfkmw6TRiOoAEKa/ru2wwJnsi8O+uMgTbOg1sOQceCnXpa1IoDox0IrJRXggugjGvsNvaHda+ESn3M49njw/STNyzUuMFWiqyWQdtOQiNANrWLo14tqqBx+O2Jzq1SdtpeUN6hE4+M90i7c+Ey8yuf7o2Qk+9w7cwgLHO4HpnQhqpw8o7BBYP/7QuB59IgsxVH2jMV6mnNtEri4r06K/X6uSI6C9luB+DdOjbCTLXkrfYX5abAfg0CgxpigYKNCl6HieSMRi0X+eQH87G6v7RgGp//mhFL/jKrE4Jbk4hczM/2VkYc2q4ys43xhDCoirGubJMpI7BzfMnCXFWLWKgRp9jYV+hqQKdT5dICAcnWdWlAQu6Clbgt/eRhRvdSz07SkemEj3yWg4y8zYmsDS64g1NVVe0RFwulKMoXlOWHeq3IF8xZp48ncY3IzNUxI+IzvqVdBjEODJAvEIAp+AuFguQsqUQzo1KVVwl7tAsHFgNzN1r8VFuj98d3Xhvex7I4x6krwyckCcM/WBAoT2R6cVGxusSczakPrnFhGFchoB/oNvGivWmzw3MApu8zIjLXECGKSfByLFB9R/Z64hhnTygTnadtRAWa9cFAp3RBV59BcCONXRrB4R6sHt6a6J/5GDJ+8HHzKWIByXLDAIrdKOzLRXFACq3uN/OYrZXCwPPtVi+sOGs1N3QAXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(6486002)(36756003)(2906002)(41300700001)(66556008)(31696002)(86362001)(316002)(66946007)(66476007)(8676002)(2616005)(26005)(186003)(6512007)(478600001)(38100700002)(6506007)(53546011)(6666004)(31686004)(5660300002)(44832011)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRwK09NV0tNM3FKUVhtVjRha0t3bEF1dFZrSHIwcFhMZlJNekM5WlZ2UDR1?=
 =?utf-8?B?RnFxZ3B2VFRIbVVTQVAvZDU3L1htS2VrUGFQM3hNYVlTMFBpVkwxWjJ3Nnh2?=
 =?utf-8?B?ZFdsYmZQTkVpazhvbERUNjJYdjBoNXRGanFoNTFBSmxvcVBrSHNsWjhiTE9s?=
 =?utf-8?B?bmpjaEZvMS8vWjNTUW1UbmY3YnhrcE55UjRuK2hVSnlINlZrL2lScHdXZUhy?=
 =?utf-8?B?UUdZcFMyMUJxa1U4VnlIL2g0MTJRMU15VGhJZ3VyZ2ZrRzRYRjhMMnZUU3JO?=
 =?utf-8?B?djlyS0hBWGh3ZmZmQmhDQlB3YTZQRm01UUFGQThFR0U1Q3JUTWJVM1lVSXR3?=
 =?utf-8?B?SVM2dG5BdjVBVjkxYjUyL1pFczE3cVVCeXROUFRWYnJ4b0ZlN3QwMlNvL1VK?=
 =?utf-8?B?V1I3ZFJkU2gxaEVpdUNxNlA5OTZNKzVUaEwrUlp1SzBjbW9DdittOVptazRF?=
 =?utf-8?B?YjhjcFpweGNScWRlL25iSGRNOTV6UFdkankwR1pKZDhyZUl1Y2JKbkRPTmJy?=
 =?utf-8?B?blhaa29PMnB5YTNWTkRZdUVNcXVKZzY3b3NwY3J5NXZOekI4M3dlTm5mVlY0?=
 =?utf-8?B?K0hmc05ZNHExaFpsUzBrNDhTdEh1SnlnYjNjRkhianhmZG9Ra0xNVFVCYTNI?=
 =?utf-8?B?WnJJSms3WWowb2dZVWNZVklHcm1qQ1NVc3V4ckc4d2dHQTM5OW9IWXE2K2s4?=
 =?utf-8?B?TnFrTmt6MTd0SDdsZGcxMFN5Z0ZTNXRhdncrZ0prcWY1Q3Z2ckp4bVpXSXRF?=
 =?utf-8?B?NHVoTDV2WmFnVEZaWWNzb3ErNEZ2Z1N2Q2ppaXpIbGlMeGpNdW9RTVU2VmNE?=
 =?utf-8?B?K0s3K2I4TVhRREFXVDU3SjR3UklJUWFaNnRTRlNZb3NsYndobzNVbllvVS8v?=
 =?utf-8?B?MUxpc2dGQmFPRnN3eTJPeS94N2NVWlJ3YncxMHBzWEZLK29HRFNrVVMxbk1I?=
 =?utf-8?B?WGNRODBvSU84U0oza29TdHdxYkJtc2VPVEhQQnV6QTBneVFqcE1RRFFZaW1U?=
 =?utf-8?B?TVF5dFlhbzZsVUdUNmJsb2JFK0Mzc1BrMmdONFBGbnZCbFlKU2lqdWZ5R3ZN?=
 =?utf-8?B?NmFiM0pGVWQwUzJQY3dKZksvOXllcTh0T2hqZlFMUjB1ZHRJY1B4M1JDV08x?=
 =?utf-8?B?S2ZIYngvNXpzZ1BFWkZGejlZOEdhZ1lvNTJZTDBwVTdqUGlFUW9RZU94ODk3?=
 =?utf-8?B?aTJBeUFCOUpVcXJRNEVzL1lIaXJpRGpEWmI5TUNWRml1THdXN2ZWQmFpQXpE?=
 =?utf-8?B?NmFDazJsR2xuRU0vck1ubHFBSzN6ZWl1eTlxN0IxaTRPbVhkSjRMMU1DM1F3?=
 =?utf-8?B?bGR4aDhGemJBbWZCaVVpdnZmSDIvRHo1YmU1cnVyNTl4T09IT3d2SVgyOFh6?=
 =?utf-8?B?R1VKb3NqOW84VlgvNjRob0VGQitLU3RobkpFclE1ZjZ6K3dZWWJoall0ZVF0?=
 =?utf-8?B?MURia3o3L0xETXBvaklFcFFXOWhuMHovQVhtSXpWc244VjcyVkMrVVk1cGxi?=
 =?utf-8?B?MzlMVG4rREdDVmRQNUY2Y3Zudmp0bWUyNldiQ1c3ZlZZOHQrcWdlaHhYZk1k?=
 =?utf-8?B?Mk9JTVFza0tkOE53T2pXMWQ4V1d3MDlhVkZyMnJpejhyT1NpLzhBSWdidXhi?=
 =?utf-8?B?UzhkQ1JLeGM0eXg2QTEzcFpmdkxEYW9aMXNVZVk5WjVySGE0Y2dhMG04VXcz?=
 =?utf-8?B?NGtzeWZ0a3dvdmdxN2E0Vm1uWE82ZERkbSs0VXdVdlhvb2Q1d1ZSeXBrcHFG?=
 =?utf-8?B?THM4NGRkOU5DazNXWklTRFAyRStyV0p5MzFRUjl1dmtERDFhRU5uTEJvbUZJ?=
 =?utf-8?B?bThBSjNmSU1FNWpHL0kzRVRwOVUwbG9wMEJKNTdRbFlBOFEyKy9sV0Fnckw1?=
 =?utf-8?B?aTBXdnN3OFI4dlQ2ekpMNUpWVjc4eWxtcjY5bnFwaXdwNFc5SERQVmFyOThN?=
 =?utf-8?B?UFZYWGZWMDZFamtRd1Zuc0puVkNjZm5aQi9Cd2NHT3ZQSHNXZExLRWlPUElk?=
 =?utf-8?B?dTQ4clRmWUFGcWFLNEdlaXUrQWE1ZmZvQmo3bVFPRUVxd3dPMTFubDV2bm9k?=
 =?utf-8?B?ZnB0ZEl3c0ZxaGFxZFNIMmtrUmZHNUJDMlV4OXJ6V0pRZGVTb280UG5Zangz?=
 =?utf-8?Q?CGtcNl8N0ei5fyu9QmvH5SOIp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fac86a-28a2-475c-f5d4-08dabbbf106a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 04:10:51.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RynvWjg19b5+3quZJd2l3O1z862BX0syxn/SZfDcgO/596FmXO9Lnbze6SihcL1IUoFj6TTl5zsSBlEjkYCDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_01,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010031
X-Proofpoint-ORIG-GUID: Svx5eGPAINuTSNri0yjstoQeM4HWA1n1
X-Proofpoint-GUID: Svx5eGPAINuTSNri0yjstoQeM4HWA1n1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/1/22 10:53, Zhang Xiaoxu wrote:
> The btrfs_alloc_dummy_root() use ERR_PTR as the error return value
> rather than NULL, if error happened, there will be a null-ptr-deref
> when free the dummy root:
> 
>    BUG: KASAN: null-ptr-deref in btrfs_free_dummy_root+0x21/0x50 [btrfs]
>    Read of size 8 at addr 000000000000002c by task insmod/258926
> 
>    CPU: 2 PID: 258926 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x34/0x44
>     kasan_report+0xb7/0x140
>     kasan_check_range+0x145/0x1a0
>     btrfs_free_dummy_root+0x21/0x50 [btrfs]
>     btrfs_test_free_space_cache+0x1a8c/0x1add [btrfs]
>     btrfs_run_sanity_tests+0x65/0x80 [btrfs]
>     init_btrfs_fs+0xec/0x154 [btrfs]
>     do_one_initcall+0x87/0x2a0
>     do_init_module+0xdf/0x320
>     load_module+0x3006/0x3390
>     __do_sys_finit_module+0x113/0x1b0
>     do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixes: aaedb55bc08f ("Btrfs: add tests for btrfs_get_extent")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/tests/btrfs-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 9c478fa256f6..d43cb5242fec 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -200,7 +200,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>   
>   void btrfs_free_dummy_root(struct btrfs_root *root)
>   {
> -	if (!root)
> +	if (IS_ERR_OR_NULL(root))
>   		return;
>   	/* Will be freed by btrfs_free_fs_roots */
>   	if (WARN_ON(test_bit(BTRFS_ROOT_IN_RADIX, &root->state)))

