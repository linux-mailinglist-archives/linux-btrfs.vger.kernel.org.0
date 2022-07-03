Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B0564390
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jul 2022 03:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGCBmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Jul 2022 21:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCBmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Jul 2022 21:42:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBED65D8
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Jul 2022 18:42:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 262DXAre006316;
        Sun, 3 Jul 2022 01:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=78oRm1H5SoHHR58uny3VmDs7CklkoCsGATdVL2RFr6o=;
 b=yv//jzqvLUt2ioUveDi++i3tjrEaAcgY/kzeDtui3AoKarcDspS6y7lcGKZE+ogiM3PR
 WAZwTVj7CLoqsalJTr1gRDi9XO/xXEY9y0rV463djOi9MnKij0LetFl14hxxyE2Poh3l
 WrDjjLRQnbQiyDEoDOwpVk7XV2qKDv65BPY7V7djZHshBlIjXpQovmEcGJDRXjfB8IUv
 TVTD/CmGvehY50ZkTQsNBHBxuNWnwlDqNriJF5srIbXshvRY+9/TOCicPQrJWMcXbJ9h
 fyNlLYDlmPw+0IhEaU1j5Se5X6JSBxve9kRwJmousRxXMJFy7qD0O1XA4oot6O4YbU0n ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2cm0h3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Jul 2022 01:41:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2631fpFE005247;
        Sun, 3 Jul 2022 01:41:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf6wun2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Jul 2022 01:41:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcS/BpgjZxMXeE5MsCrrvvHvJJaPq7mQ5IMQIFkadSuoGAiS4gzQ5hJ4764uU1Pg3MO23v+FP11T+DYqVkKvaPfkfgBDeAaKwbWIXxRYeqZJac+J1irjlCInLp064vJ/ECkumtnKssryfF2PUm2i9OObrbEMMqAuj2XsSA9Az7D7h454nvtCsUKeUhyMTZUYhcbuXa5Z/syEklTJwKlfPLHj97dUFCGiGS+k6yhANXN4EmdlobgXLLLANvBmCdIvXvWX2esr51PFKIY4agPPkyi7q4qg5XYZYCliJ5Lj6ZWrCZE4EFMdfiBY9XM8UIKU/G2c7h/8lNFhuEJIf/XvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78oRm1H5SoHHR58uny3VmDs7CklkoCsGATdVL2RFr6o=;
 b=Mw3If9QfSF10UoN/Gq5aVzZeQohPJxhkW5YTENJM733XEiMnxLxPNx85FkEKOQ4Wn5w/biqyBOVlf7uk/kYZvcZVNSUK2WpqYhx6vZb7RIQlvUv3VRDhox3v/yH0vDc26AHN48t1q0TkFPUeiv6u2a2y8yurZb8CiYlvoynHJjgkGHLRLeXVTOut2erc9B5gchIW+0CKW++Daw3/vv44s/2CpiVItGcFBu1Gfg8rO67IPMvLYglmy7/KmOfA4Wr6p430ZvBjNbc0uMC3wb0TUHYq2I+Q3j4LEZPr69xwpZ07MZ1uH05eXePjPSeu05h59U8RMFCk7kx2Yuon0VEu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78oRm1H5SoHHR58uny3VmDs7CklkoCsGATdVL2RFr6o=;
 b=NBujHNb+wxtqb/K/IezVWs2Ggx2YtYjAKmv8jyHwZtFshcsXCCB6lmvuiUozWNm9Q/aONkzcX6GbjCcxKIxfli5Es4lXBAxuUlU2ykm21Jat5nAud1ChBTfBNmGheEGRTk98WzGkwwx/n1IFLmmDsWOJmqZ4nI71ELCGVpfX5ko=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3472.namprd10.prod.outlook.com (2603:10b6:208:119::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Sun, 3 Jul
 2022 01:41:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::957a:9b8f:bb27:2173%9]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 01:41:17 +0000
Message-ID: <ebf7b037-2c08-8232-6b61-8a97ee22a1ea@oracle.com>
Date:   Sun, 3 Jul 2022 09:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
References: <20220630160319.2550384-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220630160319.2550384-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 166f5dc0-56da-45e5-2ded-08da5c951f77
X-MS-TrafficTypeDiagnostic: MN2PR10MB3472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l88EkbYQhyFwPgV/2pLAnC4RQP9XiFd2LnFxli1N1uqnCITDO9ukiXZF03A7d33gTceTrJDyLgnONQAllFnR+HK4NW1JQY2Uf7XloSMosuD7aCyU5oZ8c71SakVq29nICPtpChQZ+puPQNxTTfbGiScW12v1YcoxbOuAUrleejNrw57JWldbeMQ9jtO0xaJXB5/83Ijh8AaEWxzqXJt5ShgPVXv9pp3F/rh9cfUxAD5pOEvXJemS45fqgvW76Eg/7VdPpJTZP7zf2LxAvZOvRx0gh+R5Jvb1eSHYlbqzRoNjpcOxpkEa2VrTpt2kkEQ9yXP0wC0L6d9ernjT1nykSP0F05AzED3UJ5dp+g3cx5dmdcUWTtXnJSRxT54nlPEV88vXVke8WM5qHF/wrTBES+V2KiFVqa5kDiVdXbVk7vD1Lfvo6RdqHg6zhNjhwj+HkstR4/y2cFIyMncxL4FRKlbSJ7RrHc62Lu/0TfcdMHB52qQ9FUWQ/gOw1viNpnntc7ASuxFGFzhVJ9/nW7efxqehNjGzz6+fIv3FDz9EjN+XVJNteVvWZ+OM9Ru10wfaUCRdpP8HUgRM9Ub8j7IAatqf98/4lM6bSPD5Ha0zSWnkNt2xdyxMOLEEa2gvltJGCw2ni0nG0lXesAxP6sgHsXWZpilO+cOcCdnHFbk9FUV40dEBljMPZJUSRhMyL5sOBUFLU7NOHNGrbwxCKeqb9AfvZBLjGcpS7SJo1YnvL4y6tcz3r8m1K1lzSoeD846C7Vfpdyry0bie3xI1C53SefoIf9IG5tqbDWPeVqCTVSieFKYCENRSTmXtaW6NC4u0JyR1Sh8pP6wm06bJWJAYXjgAhGnB4E82inN9RLqn/6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(66556008)(66476007)(4326008)(8676002)(66946007)(36756003)(316002)(83380400001)(6666004)(31686004)(38100700002)(53546011)(478600001)(31696002)(26005)(6512007)(41300700001)(8936002)(6486002)(186003)(44832011)(4744005)(5660300002)(6506007)(2906002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5ZZWpDL2tjZFB2cDc2Um9aZHh5bWw4dFhKWEFuVmlaaDlBK21LT1NXSkli?=
 =?utf-8?B?MkpCc3R1V3czNzNjOFQzdmRxdmNpZFpGU1dHbHk2M3FuOWhKWE9yVm9KMlJS?=
 =?utf-8?B?SEV2cVB4YnpubitWZ0ZNNGpFdG1UU1QvNmR2aFQrMGtHTmpGQS9ac05LU1Mz?=
 =?utf-8?B?L3pOd3BMbjBybkpjNWpTSUkrVnJUOVM4NUZkOUp0OWhyREhZVlFDQWExNnYy?=
 =?utf-8?B?d3dGWjVoOHZuQlBqcHgyRGczZWxuWXpoZDQ1am5rcU0wMkszeUY2VVNzM3dQ?=
 =?utf-8?B?Z1Y5NVBNN3B6eElDMUE2SWZvZ1ZkL2x5UDQrQkZZeHN1ZExadjdEV0cwZkxx?=
 =?utf-8?B?blVxY2R1bkxFSTZUS0trWCtJL1VRTU5qM0RtNHFzK1R1T3V3YzRBMnhaL3Rq?=
 =?utf-8?B?V2Jqbzd6cnhSdDNPMTg1c3lCcDJzM2dxOFpBSHdTa2FNeEpkbWJmRmxJTVlx?=
 =?utf-8?B?MlVEbytHTld2eE9peUlrZHJZVTNwbTczMFJLRFBpTVlUejQ2aXdUSHc1NU1K?=
 =?utf-8?B?RHQ0c1owK1ZINW9LK0NBWDhNZFVrME9UMUFQTkdDbnl2bkpvRG9qN1ZIUDNi?=
 =?utf-8?B?Z2l3NmVKcXNRWDE2L3RMOFNQaHVoaktvVUZpTk9PeDE4RFkyeGM4WUFDd0RS?=
 =?utf-8?B?WG5pWFZhMUZ5bFpKQVV0bGR2Z20wWnpiS0dIR3ZzYmg1dEdObkV2RmZPUnpG?=
 =?utf-8?B?V0tzMlhNTmt4VmdNdSs2SEJjRk1mN3FpS0hPdVY4MmxIN1lXa1UyVWVxcU1Y?=
 =?utf-8?B?OFB6QmNkRDliWEo4bEhBR2xmbjdMNktqNERCYjVsb1Y2SUZkMnc4WURHd1hh?=
 =?utf-8?B?ZWtBMDNDalJ3am16R25ReTBiZzZ1SGN5d1pkRnVZNWNKNU8rTlh3cEJHTUQr?=
 =?utf-8?B?aVRFRzUzUzJxOUQ4M1pIK2svMDFia0xsellyVkxCSGZMWEdmNjlFRy8xYXdl?=
 =?utf-8?B?NGlmd3lWNGlZYnU5dU0wd1dsdSs5aHVrNlNnR3YwanFwRHpzNkRGTHI2NXRK?=
 =?utf-8?B?L1BJZnZrRGN3MHpndXVIMExKbzF4WVIwU1ZmQmd4dmlnVmJlZ0Rtb2h0YnQv?=
 =?utf-8?B?d0dDdmdLZm1NSVdMNWdhWiszdWVkT0xrdXNObmlpL20zZCtCU1lLTkJrY0lr?=
 =?utf-8?B?S2FraVVLYkV1MEFMbmh4ODVjSkVTNnc1M1FrZFV5RlI0UzE5VmNkV21mdFFO?=
 =?utf-8?B?ZFZMckh6a2wveGEzMEpMbE5SNDhnSzdZWTZ5VlU2Q3VlbmxxMjNjQ0lrQ3Av?=
 =?utf-8?B?NDByY3VUREFpd1JlajhxdEhmdkl3cllPbVhEb281cnJMM0tmUDJyUHFWSUVn?=
 =?utf-8?B?dEc1Qlh6c1lhQ2FlOHo0RnpYeFovdTJ0MXNSQVNocE5ER3EwMS8yTTZBaVVF?=
 =?utf-8?B?bzZKeXA4VTYweE1FU1A1TTNxMWJGOTBnekEzUGpLeFZ1NE4wODd5NENFQkhh?=
 =?utf-8?B?VSs4am1zclhDOVZwQlRDY3RXSXhUWmJxOTlNdEYrQ1BmcVpjdFBSR011aWNq?=
 =?utf-8?B?dzNGcEhoSXoycE44QUNzVGhReFlyM0Y3eVoyMzNlSitSQ09DVGE1aURSY1Vj?=
 =?utf-8?B?RHZPWEk3bXl3dGVBdHF4alhYRkNhQkc0VXhVSnQwTXVzczczZUpxTHkxU3Vr?=
 =?utf-8?B?OGpqdlBOZlRsdTBtVDRQSUgyaUtBWDVHNG9kRVk3REtLS1F4bEZsaGV3UnYr?=
 =?utf-8?B?cThUZStPM0lFVnkxV0ZqNmE0OGpPMlgrOXNGWXBESDlweFA5NkdXaTNqdnF5?=
 =?utf-8?B?R1QvQ291bVZDNFZlcFNYTmRpS09VMmppWG50SXNwVmJwZ1BlN3dvbVJ6NW92?=
 =?utf-8?B?ME5UYm1iU3dzMEhsQ3MzbS9oc21RUy9XcG5BR3JlOXY3N0ZYaHB2Sm1QbXZm?=
 =?utf-8?B?RUx5Y3h2ZExnLzVvRUZNYk1SdS9kaXFVWk4zM3JKWTRxaFdBUnlDT3VVUVla?=
 =?utf-8?B?Tno4ckZNbGRjNk5Tc1hPUWhkQ200K2d5b3FXQVhVRDdqOWw2NXEyd2VIc1VZ?=
 =?utf-8?B?ei9taUpobTQwMEY3RHRHOFRmSWluVlRaVVpyNUVDSWRtZ2QwRFJDQVFMZ1FE?=
 =?utf-8?B?Mlg5T2tHZFg4eEE2YnJYQ3BoZDZsb2pQUFAzOEpXbVhTclViT1ZJUDd6NmVi?=
 =?utf-8?Q?8RX7j5CzmFu/Jzs4iGtydC2LE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166f5dc0-56da-45e5-2ded-08da5c951f77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 01:41:17.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+SyPHzj2HqRkbtrG1z55IDjlVWNqttnOEh94m8QuK/DXEDCSMjtFbTbPD5CzetI1yAkWhMKmYb44jp6omkuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3472
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-02_21:2022-06-28,2022-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207030007
X-Proofpoint-GUID: Z4cwCHpYE9m8riCMYGKshi9txIixdbtv
X-Proofpoint-ORIG-GUID: Z4cwCHpYE9m8riCMYGKshi9txIixdbtv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/07/2022 00:03, Christoph Hellwig wrote:
> Don't leak the bioc on normal completion.
> 
> Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/zoned.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7a0f8fa448006..e92bd5582cab3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1759,7 +1759,7 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
>   		break;
>   	}
>   	memalloc_nofs_restore(nofs_flag);
> -
> +	btrfs_put_bioc(bioc);
>   	return ret;
>   }
>   

Why not call put also during return -EINVAL a few lines above?

  if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
	 return -EINVAL;

-Anand
