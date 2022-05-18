Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA152C05F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiERRHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiERRHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 13:07:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F378E6A009
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 10:07:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IEgFuL025604;
        Wed, 18 May 2022 17:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sVsUbFNTgUAFhZvNBJVq/zZm+uQ8qkuHZiAYiWCu7ls=;
 b=YaCq6uY2/7/Sec9DQ/ko5AJ/LxDnd3JXWp7kkOxeP2/nO/Cxm15YDr2C/aWOx32RYxX+
 3LABhl6EbzRwf0yUUp9lsVuZGw74/KzabTa10/MNlPh+fODnFn/B9TLwNrQd9dKH/prr
 gt7X66+LDDFMcRjgRZtzf8XbIosn2rzknq2YXZ0mIhEQ6HWdjdGOt1sKEs7MhVi9Ktlh
 IJ0/+14yylFBjCsx6wEY2rz9qT9r/l2r1G54x01eg6yNA+wRvKnWlI/Y3Y4CTXXKxKjH
 tJou0P1NonJn8wWSV/qG+rHwBwrkNPfWiuLcV6HYKfTsn9I5M6uWmhMFdtPlu7BXO6eu kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aahrd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 17:07:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IH0tFv014614;
        Wed, 18 May 2022 17:07:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22va0j7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 17:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyftxAP4FXBPrsL4ZgV3R++guXBXovDHlrQnTAXwvoxXGhgkNUW35fwyt8E0KqMNosr12rE5nlrJzY5Xb47xyNeNIY8jFBJjiOZurE0Td/HFR7/WHitZI7TTQmQ5g7E4QaYv5mSrKptMFdbnvtuRymZ4i1KiRD11MMb3h/ElL7NU9DK7ShvVkBeCMb1Tw/LaFLy3DLzaObKVylOTbO2dGUhVTPJEqeM26+A4Hd0TFnN8XaI9nrf3nkiBrnj70+ZV7CXQ9NWfEoe6jm5k+3naUsgrV24ST1wZolVdVv1rw3TA5sF0BcliB85G2iFX3jXnzybYZ76S+5JO1wvbJ6dSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVsUbFNTgUAFhZvNBJVq/zZm+uQ8qkuHZiAYiWCu7ls=;
 b=TRN9kC8P6UwS/ElDCEF0bgYeV6NAWgwDuK2SO/wt2bgTHf2Pq1g4Bo1IamqDX/lTgXwVjgzpEKd0yXajtmIiu8IWjLHdOz60BCOKv2TFVbsyKLF0A4KL6a2jHyrEDJHCkg91cjvqVTAehL8xO6G5adTeJPRpQa4+gAANBpcwWPJz4Q6kzju9om7TJ22YRXIjQHKS8YSFUSMVR3kjFxQruzI2mOQqs0VN9mP9jjHFAf5HwxIw1U2cAgJaos5UXjo88NIa1uFS9Jmiw5sfCqmsLUv7tl5jutdm7o/bOZ0qmVZWaNKrr2IP7NWEjKrSLeDznmJOqsnrca9F5Iomb8SMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVsUbFNTgUAFhZvNBJVq/zZm+uQ8qkuHZiAYiWCu7ls=;
 b=0Ho+cnfwSVY1KC8C8HP/31tLql6f/iK/fBjpaMcDIUlY0dmQPXU+IR6So5knC6MtjnILDW/W4NwOCnOaV1a3di2Ch8Tr1caRfe7B+1k3OI68ZrzFlG8syrszy5CU3TaWfGVhJzJN0fn34UX93ePEnOZfYu6mKeoKsMRLYFqVKIQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Wed, 18 May
 2022 17:07:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Wed, 18 May 2022
 17:07:29 +0000
Message-ID: <844737a5-6153-698c-dc7c-693704134a2d@oracle.com>
Date:   Wed, 18 May 2022 22:37:20 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support
 for raid56 related checks
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220517145039.3202184-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 069fc22b-b22f-4c5e-b364-08da38f0e3cc
X-MS-TrafficTypeDiagnostic: SA2PR10MB4682:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB468299B729ED2A50ECE6AFBEE5D19@SA2PR10MB4682.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LUUhDFwzhtiFiNiKlib/zbmKyhijgJ8uxHj348iI0vOH9VlhHH7hQbms3WYTJXItgoZ4lXhp0WHknSJuRRRO/A0Vq29Lwqpd7Cayn5WVkBEe8OS10nxp3U1mnIWMWrI6Kh1C/bfpqfwIxye6enzCXpr5+DGQ2g7dYlh8K1y14SucX0NJIeeNDnJwtZGRiDrp0mo9OcApYUxJDREE0BeIaVKW1c6vvjgc6flMX3WOGUttoWq2ndeY+H9H62V2T75m6ipF9ainFu12DxWrpRpXMgUyOvpQP9w7xFHkgKiZYBK/snOcYSPKE8fq7CU+yr2p9pixbVFUn+Zu04yVilXd0HsPccDh5KYZJIJ8zsoHnn2IwzrRYv2+ytRTLAv8UXXdS3pz79gVlcSJQCcXpMLzSs4RfGwhlhgfWVi/Yt3V3TWd57UoJnsFCMCnS0NopNAlr+f0sp/Iuh3p3MBSi+CJ+N6bytbrUOXK8cmx9FmDvuWW1Vn09YGv0++JjvfckvnuIOre86asQ/kLARFZQFSMe4oQKZBSa/MjYGmgtFLFGN8hJG4Z6tcLStqfXZGVMfK/7uFt2L6oE9fVCnylkdyXkUP11sXX5jvWREoKB5+gYQLVwfKVdMouhXYnE3nScyzflV7x/T8cCiHHUYKoRjsukGX/BnAVxxTbp0nU96FoRvDRosJs8r3uudbGzPFFzzBtvFHJdIgE5Yh3a8dby2fsvfLK9jfrkXbjuxTEctGrgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66556008)(2616005)(36756003)(66476007)(66946007)(8936002)(5660300002)(508600001)(4326008)(8676002)(6486002)(31696002)(53546011)(6506007)(38100700002)(86362001)(2906002)(6666004)(110136005)(6512007)(186003)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzQzTXdKeGFBb1hOb3NQYk13S0ExbUhJVXlKNTZzQVF6MUtDQnpMUnh6czdW?=
 =?utf-8?B?dmZFQWdtUDJkVUtFMXN6NVhsT1o0bkczVG84OStXalpoQ21maTlXK0JRWHox?=
 =?utf-8?B?M3NraVVWUjMxNWk3K0lza1ppQml5cnYzUzZ5VXVyNExjZzRiSlM3dnpoKzFS?=
 =?utf-8?B?bWp5aUFIUjZrTk5wY3owUkF1eWNwc2cvdjl6RktWNmd0YStjdU8vZk1iYTdG?=
 =?utf-8?B?YzRONi9tV0pEbHpVNkRYY2RVT2VJeHFNY0M4UFUvL1Q4dGR1a1Ywdk1ONmlY?=
 =?utf-8?B?VndhRFZuL0pXSzFnMmtCbGZxT08zUGRmS2hRbEtJbzNRSHhZQXZIZkozL3dQ?=
 =?utf-8?B?SjJkL2lUaTVCcGU0OUdNaFZkUGE0YlJZVUdqMm12WTBFUkppMkkwL1N1OUww?=
 =?utf-8?B?VjAwejVsYTZQMlJtL0NnWmlMdTJqU2pwa3ArdEM1R2pSckFiOGtoZC9RZVVL?=
 =?utf-8?B?WTM5SzVkYTllWHlIMFprQ1p3OXIxZ3NXWngyK0p0em1mSTJ2ZGk5Sno5cnlE?=
 =?utf-8?B?WU8rdHAzMUloc0VHdng1a2F6enFrUFppZ1VnV3I5MXd6QUV6enh4WUFtZEFm?=
 =?utf-8?B?eE1CN3cwYm96WkFKZmszQ2RoczZyVzhUSHg5bS80UEY0OUFjeDhJK3FYejNx?=
 =?utf-8?B?Q3c2TENDTDFBQ21aUFBYU0ZsV2k3OVNwODFoalNqbDRHa0QxSURUY2ZsalBr?=
 =?utf-8?B?RkpYcGxqOWdzVVgyTi9XNll1YjhHQlJCUTZaVzJFMkVSbXByWVhUa2VOMm1R?=
 =?utf-8?B?SWFiZkRQN2VYUTNUZzRzdWJpOXpzMlM1WXBiOFcxYnFvRFZ0SG10dU5DQ0dY?=
 =?utf-8?B?L2Q2YmgyYkZDZUpiUE1LVmNhb0xRMjF6UUM5OHJOYWR0K0lMemJqOXA5S3NP?=
 =?utf-8?B?K3gxckxwd25SWTNhNjhyUkx2SG9Tci9ybTRDMUdGQnkzbW13RUkxUTlvT213?=
 =?utf-8?B?OFJwRlVLRjdtZ3V0b0tvVDNNZDNES2hWOXgzSDJXRS9TY3dWd0ZDbFV1akwz?=
 =?utf-8?B?RCtuRGZiNWsrOGdDb3FDOXpYRDV5UnhZdVFHMXFCMXBZd0E5TDhtc1NLRlRn?=
 =?utf-8?B?YlV2bVdLSGRZK0pGR2hwekMzWDlmZXNwMkdaR0ZPNCtCamRIL0ludG9sNnpR?=
 =?utf-8?B?TXlQZWxnK2htZ1JQcHlpNVVOcUNSRElVSzBLRHYwYTFYcXdyY1REYWFFc1VK?=
 =?utf-8?B?ejFlU0lNSHN0K2FDbnNrQTlJNVJCb0ZIcE15KzJZZ09OSHBEemgwa0U1Lzkv?=
 =?utf-8?B?L3RoUlZjVHRxdjdjR1RtN05rdHQvYnZVOWJRTXJNMXJjTWhNTlJSMm9TR1My?=
 =?utf-8?B?aHRCdnJpa0YvMkNhL1NOUEdqY0thL1E4SXF6OExRaGIzWDRWY1d6ZGY5bDlP?=
 =?utf-8?B?MGFwSkJMOTI5T2JUaDRwOUdwbzZ2akcwcTk5cDdiRUNYbjFtem5pR210N1lD?=
 =?utf-8?B?TGo4aExONmN1NFZIaUpDWnRZcjJ2V2pRTnR3bDFGWEdoWEZhamFaWUhUMWZV?=
 =?utf-8?B?d2Zjem0vaFdSSEwxdHAzUXRUb2V2cE1NSUNGMFdqd0dZYjJ2NjRUT0xxQ1g0?=
 =?utf-8?B?YUxsY05ET3UwR010TTRZK1ZWL2paOHVtWktzdUNOUStTQlpBenZSYmpMVkQx?=
 =?utf-8?B?amVjdTc5dE1zYUg4bXRlbzlJb1ZpQnVLSCt1MWtxV3VqbTJXVXlaTnppODFn?=
 =?utf-8?B?N2g0ZDdvaER4Tm56UVVNeVVGdHo3MXhOT1JEeHNtUW02cmVXMzg0cldvb1lX?=
 =?utf-8?B?ZDMxNGVMYUJpbUxmWFpEMjZFRzE4RzhBZDYvUmNTZURYc2lDQ3JYMmhzY3lY?=
 =?utf-8?B?bEtpL2xLZ1IrREh2QU1EeThmQUpQTWxEUEhnWmI4S1JSY0g2bWtCYVBOcHND?=
 =?utf-8?B?V2ZNendxbUxOUm1OTG9hT05zSW5ES3ArbWdpaHFlaVNtRHMxLzZzcjlzUUlB?=
 =?utf-8?B?N2VZNUt2QTgwRk41OURyeFM5SjJ4R25ia2ZuZTYxT1l6SUlzK2dkNkwvV2tM?=
 =?utf-8?B?NS8rMmlQbnV3TE8yeFdYbm1XRFJmRFNPM1ZXWWRRSWlPa0RtajFEbHlZNlBi?=
 =?utf-8?B?QjN3MXdBYVhGa1Z3U25PWng1YytrSFhCQlVVWExMcm5nSVYxSldieVpJYlBQ?=
 =?utf-8?B?NVBueVUvQWJyQjhNc1dUL0VmK3VFOWt2Y1hrbG4rZllPNzhONjl3dVQ3VFJk?=
 =?utf-8?B?MHFCYWlGMzlwSDJSNmtLYzdHYUZWWk4yUlVtYVAvb016NHF0Nm5pTlJDVFBB?=
 =?utf-8?B?Ti9KM2RrbjhGb0MvbGplNGVRNnRnVVo1OWlWQzFxQVU4KzZVV21RMGplT3ZQ?=
 =?utf-8?B?RjVVV3ZNM0NLRUpzZVAwdzRhRHJCbUtlNDdxenltZFdCaU12Q3ZSenhhdjUw?=
 =?utf-8?Q?Q7l7rvhwAwZsiXRNgl3jwq2T35Q6G6D/re/y6/cZw+Om1?=
X-MS-Exchange-AntiSpam-MessageData-1: U2CSfhpfYVUjzVZlzDnuWcaX1AjLxGOo+H0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069fc22b-b22f-4c5e-b364-08da38f0e3cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:07:29.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN0GRWWp6R/boC3ASSFcVButuZxCR7/lshYn83fUZezKQz1Uo6E0xquyI+uUzI0/lrIxTZH47aNesMsBDMhA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_06:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180101
X-Proofpoint-ORIG-GUID: mnxFGIBF2vXuxCvtMiZg8aWUKf5yoEWU
X-Proofpoint-GUID: mnxFGIBF2vXuxCvtMiZg8aWUKf5yoEWU
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/17/22 20:20, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> The following functions do special handling for RAID56 chunks:
> 
> - btrfs_is_parity_mirror()
>    Check if the range is in RAID56 chunks.
> 
> - btrfs_full_stripe_len()
>    Either return sectorsize for non-RAID56 profiles or full stripe length
>    for RAID56 chunks.
> 
> But if a filesystem without any RAID56 chunks, it will not have RAID56
> incompt flags, and we can skip the chunk tree looking up completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   fs/btrfs/volumes.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 58f3eece8a48c..0819db46dbc42 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5769,6 +5769,9 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>   	struct map_lookup *map;
>   	unsigned long len = fs_info->sectorsize;
>   
> +	if (!btrfs_fs_incompat(fs_info, RAID56))
> +		return len;
> +
>   	em = btrfs_get_chunk_map(fs_info, logical, len);
>   
>   	if (!WARN_ON(IS_ERR(em))) {
> @@ -5786,6 +5789,9 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>   	struct map_lookup *map;
>   	int ret = 0;
>   
> +	if (!btrfs_fs_incompat(fs_info, RAID56))
> +		return 0;
> +
>   	em = btrfs_get_chunk_map(fs_info, logical, len);
>   
>   	if(!WARN_ON(IS_ERR(em))) {

