Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20E537320
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiE3Aoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiE3Aog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:44:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519B1D307;
        Sun, 29 May 2022 17:44:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T8sAkg003279;
        Mon, 30 May 2022 00:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DNzl4Ofh/tz4Mfg/VJ/0/128USED9dvYHuu8BAZ5B/w=;
 b=p9PvRkbeyyt8EiDnKPULpDHb7nIFSH8ytAXuaaC0DKnP/G80/H6W1k0ER0ruuMSW/8Yd
 g0aUir6I6RCI2i9665EPtCdp5Jc68SI2Uz4DLNe+9Ldx1SuBL1VZiFMoXBWaVipMx5Mf
 qdVvJmBPDsuR5cGRawPcggDJLcXcEivA7+9HvwbAH3SLXwlfPdQgPQKPlCbWlpAOSxKO
 WsJgDc8thJhx/AjX3UtmJJfWeM9DHOBHh2b/FgdHhgVBywerQSdsEVIUHY2ZKt5o5ZmZ
 SBow/5JxYUfYapgCt8JeoOAQjWCehKdjXkVW3qgft3OR1HaqZl4Vu0KDmJMRSX+ssGAa TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x1sp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:44:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0dxOm022961;
        Mon, 30 May 2022 00:44:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hq8a3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPo7NCFYg5tmyNGX7Ymb+tjXalaDZsZzb1NWMBQJKWn/lClLdahaXqTO1pAaV17vjWUj4h8OaSxj48mkjKz8qvby3/STdyaxS8YyAeaR/6yC2Rbv7NUmC0qRjH+d0Cza/q3QG3NESk/fL4siu7SwgQCHk3pBEqsWrfnPFmUm82otzRGypgBBoSlR8o/LO2uw1Mdt+BqnK7I7OEOcMiH3ipTgCbV1cwG6x0aj1sDFb1Gb60yuzHR77o5q0evIZ0dTeeLrjzUISIQHmOXmrAcpvTi1RbkirMzjz8jFCzFdks7lrR3jjFj4ONjn+CvqGHamTiGxVsReUdRKtVEI3DtCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNzl4Ofh/tz4Mfg/VJ/0/128USED9dvYHuu8BAZ5B/w=;
 b=L6r2v+ig4NwC95hYI895rgSO3AP5HlHJtQzmk5rD1lQyuHFjU7+Prmi3qFzqpKriBlzNCxb3AMp2zhD1mMJSrNA34zhiYICKFLO0a1gSFttWktSZnkI1EB3uuSUKV+pdgcBq+QFeDm3RPHm9/6vJdEj7/6b/2PFcRYafQuKAq7WbgBFWEjfX0ZIZcCBPHZmPVaIwZdfUD0TM17W/+Lfp9XLKNGGi/7x+IDAm4Hp8aLILk5/IQgVriWbU96GSFZOPhFNxmnpGIiRGqFPkS9oeOdJ+0B6GDOEYWWOhZcOxvtec3rU5+JvsDlpfo5kG8I1bOTQvYb7Q30h0hAvHVYKxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNzl4Ofh/tz4Mfg/VJ/0/128USED9dvYHuu8BAZ5B/w=;
 b=FNNBt4ATBb0NcFcyXhkiJGOL8Er6q9e/Iexc3/6UIW//7WPuPgcguMDhIzNvhd+aaPIGkERw4SoPILUI04iNhE57GkllWKGM/3DlKm79lZ+g2R+EDMpj7E/MKYU0OhWHkcRUZGohsN1v+rO1BhAhPioC/3qP/98FCPXTWispXKw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR10MB1399.namprd10.prod.outlook.com (2603:10b6:903:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Mon, 30 May
 2022 00:44:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:44:27 +0000
Message-ID: <84b4e71b-d15e-f980-caf9-81c7f1524538@oracle.com>
Date:   Mon, 30 May 2022 06:14:17 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 06/10] btrfs/157: use _btrfs_get_first_logical
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-7-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a044c3a0-3e0a-41ac-a89b-08da41d58c9a
X-MS-TrafficTypeDiagnostic: CY4PR10MB1399:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB13995E97F7A8E2A2FFFE568FE5DD9@CY4PR10MB1399.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wxln9hRYKHivVP+bI24IOQBHwOdV988qKQiWDPjuCSZ5DhIy1gmYzAS6BiTAlLfK3pUDM1E+pLS5fvLG4unXUDiI8VbruhaRj9HD67zj5l1KRmuoVXAmw+A2dcvpQBG9ov98bw1hlRzDJwegzq+3dlMIxFuyw6/D4hSahHtu3ZmOJ8Ld4wzsxodC3yoWqPvXl+cS3ulPBx/cZaRSo+3lmDdBtPU9p69gMduyNBdmVba2x0FRoq9LNq8AS1YevxBGvp6S5XhCmtK9Ob0xdKoWtkTpLgRn++yxjSLSNsJJ/tiQVBVzNyG0U2yVHXCabeTzCI6Q+bTYj/GVaJ9Ab+eXi4jp0Ux6lGZPFymSaHFok2uUrAoIYTl2wFsYBTAzeRHApPitsRE0NtJrkogtKE/QDVRVWEJqKFQ663AkpZaxXejY6qm9DY2GL4TajhrYPso+JMXXmaC5CtRUAh/sz1F7+iC7DZINRpMe6S24CTGXcQ+gpj2S7ud6jHR52turn9rfmJULBkvKw+a7rRIwcSQ2gxB76/bNCh9scr7nxuvdVR246dfqXpjolhkWSO3fTTxa/azwrqH+fRaMEoPUSDiTC/eXxUVhxJh6cd+YiGjEE0XvYesEzBPzjCfQjHwj3vsKdfz3jgpygJuJN7CovesMl8fZ+Q1CT88svd4qre5NCo7fB7sy8Ll9OMqegd5ksFSyFABXST55y7UMFeXPKju7D165o8tij1T3pHUFpM6p5RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(316002)(31696002)(66476007)(66556008)(83380400001)(38100700002)(8676002)(66946007)(4326008)(2616005)(6486002)(44832011)(4744005)(53546011)(508600001)(186003)(86362001)(8936002)(5660300002)(6512007)(2906002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9BWmkwTFRNNHdjRzdUNUdpTmVNck1rYjBwSDZwaGx3R0xtSWRQQTdzcEFL?=
 =?utf-8?B?L1JuU1lSWnNxT1kyMVNiMjRWc0NTY0NXOEVybXlWWHpobHVSeFh4aUtoV3JB?=
 =?utf-8?B?Q0lycDhsYWVBcThjc0NSZk1uR1RnZVdwM3Rkc2VQeUdRdTZYK09ub2JVWGUz?=
 =?utf-8?B?NGo2dllmNUdiYy9wSG1wRlVZdUdZN0tDSzV1d1oreGxwUGFkOTZHUGZvMWRR?=
 =?utf-8?B?aStWSnZrYlJtOHhZaTYyTldKMEkrd0crT1g1dmlsdVlvSkdWOXVCdmY5QVBC?=
 =?utf-8?B?MXc4Tkp5SVIxOUZxcEJWc0pBT3ovMFBwcngwaHNINEdUb0lGWGhxMG00dS9V?=
 =?utf-8?B?UExHRFFXOUNMYWRxaTVpUTBwbnlEWE5zZU1uT01CY1ljOUZHWFl2UlhZL2E5?=
 =?utf-8?B?MDl2S0hiTDVQRXROcnpVdEE3TnRUQ3I2RFNzaW1yanR4b2VtYzM3NVd4UVFM?=
 =?utf-8?B?RHA1d1VDV0gxVVNVc2cvZmQzY21XekZ2ZlovcDcvQ1FPbndGajNFaW5jdGJ0?=
 =?utf-8?B?QkNlUnJSNmd2YnkrMExrRXFKL1JEN1E1TDBlL1plOHZxc1VzYU5DeFRMeUZZ?=
 =?utf-8?B?dFhmcVluM2s1cjh6dDQ3RUFtYXRpUjJNVXk4NzZYd1BPNVkrZlZXNEEvOUZF?=
 =?utf-8?B?eG5QVVNYWXRPTFZ3WkJxTzdxWHByRjIwSmRmQm05elJiK09aZU9oQndyekhO?=
 =?utf-8?B?UGxsUEN1MXBUUjJuTTd0K2oveHVBbEUxbW10ak1pSjZsQzZtUVVmS1diK0Nh?=
 =?utf-8?B?L3hVS0d6Qm05TTlTeS9zWXVDNyszTFE1ZXhkQlBUYmdwdVRiRlR2YVBUSG9P?=
 =?utf-8?B?MjY2YnUyTUlxN0hUL1huM1NEbkExSzREZC9Wc2t1L3RTYkxMWXZnRnc0UVRm?=
 =?utf-8?B?V1laWWJsRmFZbzdOMXkwY05Xc1R4cnU5c1RqN3l5bnFzUTExMmw2dDdrUEpx?=
 =?utf-8?B?L2hsaVVMYUF6S0NkVkdHRDl6R2hkRDdDVFdBZ0dXc2pTTEM5NDV5TmkwTjNi?=
 =?utf-8?B?TmYvNGl2NWE4VCtQVVVnbGVCcTEzbWxEK0VscGdhYUtGS3pDVmZQbHBGdWpt?=
 =?utf-8?B?VUo5dHlCZzlvaGgxbG8wNFYzV1JaYVU1VC9GNG1rcUZRdVN2ei9NclB0ZTZr?=
 =?utf-8?B?UFMwWTVKTzhRUUQ3UHg3U29CMW5nSXJNN1d5M3htbFVHMFdLZjFadXhRVk9a?=
 =?utf-8?B?S1hjaGNjTTBLeHBSTUVUR2d2bDJyaWpXVlcvSXhCelpvNEQvL2RQc2Z4dTkr?=
 =?utf-8?B?cGF2cmtBZEU4bUpPWlNCbDlxYWJFUXdTRVFZa2NkdnoyZjdYSklOeHl5N2NP?=
 =?utf-8?B?L09CdnhpSHBKT3UxVW1HZFZETU11ZGc0RTE1LzN5UnBEdlFoWWRpOHVhNHJC?=
 =?utf-8?B?OXR1ZzB1Tm1mek8wdUZsazJTazdXZzhHY1RDVnlNOHhUUEF0ekFoc0lsVEwy?=
 =?utf-8?B?MElTdGxKWlVmZFcweXo0ZnptdkIyM2EydG02a1huSlVjT1JGOTQ1VS9WbWZB?=
 =?utf-8?B?bm5DNkhXTFZocnFYM0d6QWFBSWFpNHNZOXFoR29FdVRaQWtYM3BPeURlcWxm?=
 =?utf-8?B?TUJmQnVEbmRCb21iSHlSd1o0ZUtNaHJhQ2ZJQjVwWktDNVIxRUVKTFdyazFS?=
 =?utf-8?B?NFNsS3AxaHViRGxEdXRYOHRoZzlGYWJxK1JFVzcyN2hOWm8vYktNd3kzOGdm?=
 =?utf-8?B?NkpKQ0RGNHdVdHJYMFBlRWFmeS9FUHJKY2l0c243QXdWT2JFdWlUZmltNFpX?=
 =?utf-8?B?TzhWRUF4ZUJDV1c2YkpXK3NNVGZRajdZZ2hUZGUxLzJaV1hkNVEvMk1Fby9E?=
 =?utf-8?B?czU2Uy9OZlh3cVMraVA0N0p6c012bmpoa3NkQTRIS3hmU2tPdEoxd1EwZEJp?=
 =?utf-8?B?ZkdyZ1FJOFlXSzRmYlVLWVlLeWtuYk14WFFUdFE3ODFLQWRjb1o4M3B0RUJ3?=
 =?utf-8?B?d2JaRmJEQ052aENNWjlqUlp3WThxY2d5N29KNjhPckhEek5oNmg3b3JWeWVF?=
 =?utf-8?B?UlRDSDNwbENxa0JTaFN3cHZmdEV6c2FCUk9zYmdWSGFzSEVBSFFjZURZd05Q?=
 =?utf-8?B?ajJRMGV5c3BzbW5iMjNsVlNCbXVSbXhvOU5JZjdXQSswTlQ1N3Fwb29xTWZl?=
 =?utf-8?B?UCtXWUJOWXdYd1R5WU5YK1hKbG1PelBWa0JWNUFsdTJLZHgvY2FUQ1FHM2dm?=
 =?utf-8?B?K1BsdVM1T0FRMkUranpoVjZkcCtRUDgwQjBsbnJXemYxRnVYSG9ZdVFZNkJa?=
 =?utf-8?B?Q1EvdUp4NmxWRWNUNlMxclQ4QkE2SkNyeUJRK1VmZlRzdnQ1anBkNEhyVVhw?=
 =?utf-8?B?dzlhY2VscDZnWk9qNU1xUHBnemJjbUxuQ0htcHhXc2Nyd096VTE3Vm1QdUYv?=
 =?utf-8?Q?HRuoe8oGnt2SNL7r3ZPwlU4eBVzf07gCgPfMWGZsrbVW4?=
X-MS-Exchange-AntiSpam-MessageData-1: mbGIhrWDxzMv5mcr79V490owpljz/Lm0GbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a044c3a0-3e0a-41ac-a89b-08da41d58c9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:44:27.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC/r416IHODl9o0HSIz/+LclYH5yl9OAmqaMqJtoBcTuDoIZdgGhL2m7hv/Id5IP+DRRxjSf8CN1jQPXofLCZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1399
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300003
X-Proofpoint-GUID: rFaXq5AoozPSGtWaXMpYYCx8dMASJwAA
X-Proofpoint-ORIG-GUID: rFaXq5AoozPSGtWaXMpYYCx8dMASJwAA
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>


On 5/27/22 13:49, Christoph Hellwig wrote:
> Use the _btrfs_get_first_logical helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/157 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 343178b7..022db511 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -71,7 +71,7 @@ _scratch_mount $(_btrfs_no_v1_cache_opt)
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
>   	"$SCRATCH_MNT/foobar" | _filter_xfs_io
>   
> -logical=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   _scratch_unmount
>   
>   phy0=$(get_physical 0)

