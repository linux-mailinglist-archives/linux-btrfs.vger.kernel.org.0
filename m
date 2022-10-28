Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF16109BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ1F2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1F2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 01:28:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025D1B574B
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 22:28:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO5US005891;
        Fri, 28 Oct 2022 05:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0Ph0YPABE7dYJX/CYoVVoV36gGXe5fpJfemfsbI0UUA=;
 b=zPisSU6fRGHtwO7fznFPFdW8hTjjpa/k6hj21/5ymTiRmzJwCLF9R6rIfBjULpOuU+Fk
 rH1SQaZv5n4GXxwl4cZ9xDMoAVjFcW7HpG4OqzM38Ebz6RvAtyqKLj3y8W38LbxEviZh
 evbc7l6U/9lfCKl3J1SifsucfiPoiHjechdYjjWCDckrkAc1+Ln/VxFRQ+zMmH+w+QEh
 1FaCXCA43H6lM+uYYpqGsGIZHDCjQo/Mt4ti5WqbSIDp+YtHNj3wPbwH/au+UMjIb8WW
 81v71fGlo5/E6VF8CytWjFmHeoXXV4gIvzJuxig9TJxHU/YpNglaQXl04JI+sPPMEFNF 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7uv6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:28:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S0WJse011640;
        Fri, 28 Oct 2022 05:28:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrqsdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlDpJXuMWaERQKvGgEXsGwYqXaluDSbjCOzLkhrHppyuFio6AQPPG6rx1yI0xhsMqhjpB0z13ntsKW4Ba8Np/M/n73rsVBhyW7q4ArdsILQY+eGX3cEKGmIQFdHAA/erMO1pJv3n//4zNlnnWfZs0yiD5exZH7LkiP/QdBjH28MSm5s80TI68XNisikUmUDU47ljzBffW3JXWsCmZ5qoEd9eNfvLPldGth0wH1DrDAm5plq8KJcGxTAfhtJDI0yyAMvE9s/QoCcy6QJmjqcFZxlMeOY77gMHNqWfEhFNOediRvcBvWnuZaE7dMG0XbAZIXWtZETyij32tkHVQcsa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ph0YPABE7dYJX/CYoVVoV36gGXe5fpJfemfsbI0UUA=;
 b=kvlTUEIVnJSKxbdYeDX2ggYfIazC+YYfyFCKVnPDRe+jEv+EYpgbE31L6Guw+QS+oZVOF0z57SuUL+I9UHdKjDC2RCP8YVOzqvReXr9t/R5W8hMxOLdD6DPMUGVfkMtsLuSrUCQ8fD1nfj0UYNuM8jsxISjADpCIguOxiRXrSkUvaP5P1SZqCbQ9h1hmVz4byole/wqHAJL89bpu86M9RpzYv4N3Wv59rngR/gv3hfRvxSMIqtPFH2sgqvGB4SkxZE6+qurMd2RvomDuuJh9+8tBdg7Ned82n7mg5H1zydFeuMjI2vsXxvpUBGPuRu06thA05d6dWs5bNaocRRfiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ph0YPABE7dYJX/CYoVVoV36gGXe5fpJfemfsbI0UUA=;
 b=RPKPsoGP4+0IHm3fSWNmZhYG5SGrdsnivnxGIORk/3UaAf3t/zP2dEQ0Kl7gK+1cQKGP4UF9LWGEXKmSe+VBC2ZOF6FwNcjyjJv4HQqFZUPbSJD9cZcYSbWTz7vixUWsOBCmoewsV2a8eDQMQIByVOvNEExhLvZmgdGHZmdKFJA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5253.namprd10.prod.outlook.com (2603:10b6:408:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 05:28:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 05:28:35 +0000
Message-ID: <d2b0a9e8-d3e8-53ef-2799-7d9f36a2c47b@oracle.com>
Date:   Fri, 28 Oct 2022 13:28:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/26] btrfs: move the file defrag code into defrag.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666811038.git.josef@toxicpanda.com>
 <927a6a7d5a5f77ea1e46e8a17cb0bf3328784588.1666811038.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <927a6a7d5a5f77ea1e46e8a17cb0bf3328784588.1666811038.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: ad79f930-1512-4420-e4fd-08dab8a54247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KYVyTJxj3/7hk7pnCoUsGqysk4MnfZdI9txgftpJQfA+aVPPXBlcsJVfcqo4mk2N5mgUlQBOKuqOqbZMjxSYP5EKoNgAzRWyN7zn0w5ZHu+SlcD6bmr7FeXFEJZzSI/c3fEyKAZDgjk2G/DrCNs2MjMIYQGjmEuH3l800i0bDem9vtGOepe72LJF3mfVbuFrWRnOV0tkmmHu1qKBEzhugcxwvpiA/ja47uQs5gW4UN5EO08kt0kH/vaucS4Nx7zTDGAR4/YUvyIGeh346QFhsIWsCxYNbtLBvdc1ZKEALza3wXUWVhPL/i/LsGaLv5hGJzZz9KUQ4Xgax4AJ8BEenCNuESB0a0mnkPKzIFbxWPyG1XrNBcLyvYwvtVgQcYwUiRDkgpxKY6MlmVc0Vcdr6XFr2BJ6L78pTI7wx60y5xXjfs7R1/lyxpyUoB+OYh+r6SLYPHNAj6W4Lk/FEtsqCEJTF8ns5KtPA4XDSul2aRTvv+GJB45Mvr0kN2LDc6zUIVnoT7lyd4Erp4aWDGTAyxd3hS6cjaSM8nqC6kFD8SVsWDjBvEpLW3WPJoDGUKI05JL30Hn6EWQWWyaqqBf2Zi15DgAIQuHs+fDjYPjk3C5ayTK49EFl0paQny+cHU/pu+eXUrbfqhr7QxaU/3AaPucmEcH31OyOmhnF9kd/K9MNqhLsNBE86XsyiL06W55+Z+4YkLPnE9qUewNetHvRDAu7iwNepKZTRUfOLvhc+d93arD2bDXRNnhraJVErlXeRn2EKs1d6DaB/xUrFUK3vwl4I35TaSp4Dac43wU0LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(478600001)(31686004)(2906002)(44832011)(5660300002)(8936002)(36756003)(558084003)(41300700001)(316002)(66476007)(66946007)(66556008)(8676002)(6486002)(6666004)(86362001)(6506007)(2616005)(186003)(31696002)(26005)(6512007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldOdlo1bENQaHBIWUJhUTRQdXh1amhJNWxnejl1bk1ldmNDV2RpSjhpeWQ0?=
 =?utf-8?B?Q3dzSW9qNHlhYnRJM0d6ZVlWMHNFZTRBRWhBM2xGSmc2QjgxS3M1d1Y2Vlg3?=
 =?utf-8?B?RGxoMW5tVkxTUmpqQUtsN0FmY2VKMU1mNUtiWFhVSlVMN0JlempGWjNTSy9C?=
 =?utf-8?B?WXpDb3VRL3ZlbnZPbTdCekZwWU9PS1dJQkFGRllNL0tDMitoeXVXMU9ncjZx?=
 =?utf-8?B?U0tXcXJxOWJiSkxVaFVXTk1Fa3RkM2FqejVKc283Rkg0RXJnMnpTN1I4clFX?=
 =?utf-8?B?bnlLQWl1Y2hML3ZXZGROOWVsb0FXZkxqRWxVeTNjMm45dHJsbEw2Szg5SElK?=
 =?utf-8?B?cS9CZWJWN2VWVHVQR0U0L05FR1JoM3d6TXNqZG5ZZzB5cmFYUDltNERtSmNj?=
 =?utf-8?B?eTRqWEtiWm8wcGlhN00rKzBJWHp6WkRoWDJoaGs4TUZEb1F1KzN6MERYSFlt?=
 =?utf-8?B?dmozc3VhdHlsNUlkU1c4dUZyZThhM2dKSDk2UzlaaGdmYXdCWHVQWTdHT0Uw?=
 =?utf-8?B?QkxGZ2pINVYwWTZmYWJsOEVabU1FRnE3V0YzQklJNmYyUksvRm83TWMzZWlZ?=
 =?utf-8?B?TGMvL3g4Q3FuZ1UwaVZkNFRJUHpuUVAyTnVWcTJKV2xLS3hwQzJhdFlyZ3ZV?=
 =?utf-8?B?UjZwRGFRMytlMlM0QXM2YzBQV00rMzBlR1c5NlVhSzUyUXRiTko3YTFwSVNy?=
 =?utf-8?B?T1h5T2U4TGIvYUVJMm1iZXVYQmhPdDNPSnJiTDVrT2gyME9yWjVJUlZveHhr?=
 =?utf-8?B?NG5NbVFiYTZhQlh2dFRUTlBZRjc1Y2Jwc09wYVMzZTFkK1drZHJhSjcraWpQ?=
 =?utf-8?B?eGIxa0tvNkxwRTc4VENFVTMrMmlobG9yQW51M0dGRWdTSTJ6ZTNubUFrM0ln?=
 =?utf-8?B?ZWNvRmZzYVFINVQrVVg0eTRmNUxLNUcvK2R1RTRONE5Wa2t4RU1BaHFqYVN0?=
 =?utf-8?B?ejFoblRQSmtyUVR1SE9DWlBQdzV3NGNweitva3pLTVdCcjN4L0EveUdNaUpr?=
 =?utf-8?B?RTlrM0hQR3F2eVl2RldnR1luV2Rnd3BtUEJjcUZPQzJRVnNKd1JjSFlSaFBm?=
 =?utf-8?B?QTA0OHFFMUlDeXBnYVV4Q25hTUxJbkVCcFpkNklINlpKWG5OMEhoVmRhTkta?=
 =?utf-8?B?cXBzVysyUnVkbWZkV3pRQjYxUGo0SjdtODR0OVFHbFVSOC9xUUM3VHdpNFZv?=
 =?utf-8?B?VVJFeFdYQTVCc0E1R1VOMmJ3OFVkZlcvK2FMNEM2QTRKUmZqWHFQbHEybjJ4?=
 =?utf-8?B?UE95ZEdSUHA3RzI0dk1yM2Q4Vkx5WWlNVUwwU1h1VVp5ZzZ5LzdNL3JNbE5Q?=
 =?utf-8?B?SHkzR3pXcXZmSkx0UDJKWlVGcUtDVFRqcU1jNld2ekcrVGxCRjVDY3hwalcr?=
 =?utf-8?B?NWxnYkhuNDhyVlNtTGJsOHJ0UkRaNHc2VXRhN21kZHhLcndIYmJWVkdWTWFU?=
 =?utf-8?B?UE52MDU4NjVsNTg0KzZRckNUMVFHcFBHZHc3djBFQ0dKNU4vWUtlVUswRnVB?=
 =?utf-8?B?ZVUxVkVUV2RxdWNvdG9rb0tOdDE0V3ppOFUwT0RHVDZpclN5S2VZQnBPQ1ZQ?=
 =?utf-8?B?QWFSbmEzVDNzaHN6STNRN0ZOa0V6ckFPWW5YMWx6dTBabTQ5czdRNUhUNnV2?=
 =?utf-8?B?aE5FbkdydVpLVHlQc21TM3VuczJtWVdCeDZMaW4wd3J1cnVjR2szeXovbCt3?=
 =?utf-8?B?SjljcGRSbzBudWVENEIzVnF1ZHM1alluMXVGQ2ljWGFXWmR0RCtrZ3dNUXRE?=
 =?utf-8?B?THRSdW43UGVBdHdWc2FwR0RVaFVITWp3WDZFdksrUlFwQkxRemtrKzIvWXEx?=
 =?utf-8?B?VEZBdHZJSnQzVHhQTFdHcjVwbzBJMkZMSzhZZ3ZyYkRtMTNZdkVWUUZTV042?=
 =?utf-8?B?aEFYR0hPR0szdEVFMk1GWENNWjAvMWtwSmNaU2VSc01naHB3T0NMOWhKci9i?=
 =?utf-8?B?Z1BpaTV3bW51eU1Pb2J2SkhIYTRJZzZLek5TbE13dVlXWGZNUVJ5NFpDRVhI?=
 =?utf-8?B?dzh4dEpPK1dMbERTUER4RUROazhGQXlpdXJacVdMSS9PVDYrblRVakhUdUtm?=
 =?utf-8?B?UmlYcXhwNlk3WGZINllXZ2pKMVozcXVnNGNxdEFQVmhQWm1CQ3FDblRtcXpX?=
 =?utf-8?Q?l9is5/cuNiilByBqp7Ce/u5//?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad79f930-1512-4420-e4fd-08dab8a54247
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:28:35.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDQixRBpUXGfBz+AoSWxjtiMIsNwTm3UCGRd+1Oy1ib/wnb+c4o8xDRZ8Xf+2fCgeh9t7x4gLo0+ziEp6U8Cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280034
X-Proofpoint-GUID: gX9r5nOYNwzM2XCXL3oy04Mnh1fFjQIG
X-Proofpoint-ORIG-GUID: gX9r5nOYNwzM2XCXL3oy04Mnh1fFjQIG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2022 03:08, Josef Bacik wrote:
> This is the other big portion of defrag code that has existed in
> ioctl.c.  Move it to its new home in defrag.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>

