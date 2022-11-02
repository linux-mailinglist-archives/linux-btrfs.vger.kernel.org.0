Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C661566B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 01:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKBAMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 20:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBAMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 20:12:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B612623
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 17:12:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4JR4028857;
        Wed, 2 Nov 2022 00:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ngwh8IH8q6TJe39guG5HFJkk+g10w8KGvTPWK+Tm+iM=;
 b=cjvKn3k6rMoPvx4239Q4IntU+UIyAbMnUq9QhjGgWoPIy+yn5T47q9veuZUuZcVlqlDI
 Q8Ae/M7EGmnKFZXVQzf3SnnFi7G/n8XIdfeVg/Ke/uZnQnNXn0NbvHauahmxDS97AEfR
 YG5/XjHrlAXXZquv3xl1NaDC08QW88VHeYJWk6I/KZtrVCaDJTVZbQ+0BnZwLX5Needy
 iS+jD6Dw2Z4O88L3nDvlX2GLXgJRLd9HbxEVStqFlK0vxw98x8i5GmvrDr1T5aoDGtWJ
 M+jgfFK90cU49KMzY0G5CLtxbiSTIcapVm5oHaSWBtEe+5Anm1k8Em6c/m3REWWYli8x Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtg7s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 00:12:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KWHVb037391;
        Wed, 2 Nov 2022 00:12:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmb92qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 00:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N91W1bHWX80gBXHOlqM5K14vD/pe7JVAL+CuGhYATWenLtp80HPvGomU0eKm4UbSj49pmbc60flMFaZTfm7pgkWbjjT2k5cbLM5EGBuAbfXlcFTlonUEiauNLMMS1n3AicVTTt4mpqzLHFFGtT3fsOG+vpLRlAPRZGi8oWZEm/ykqu8pjQLjYiXEdCpZ/7QNnrjNMwwuoo/ZQDanLYy9eNs6v2PjtW0u8pyuz0wi5o8eXgL/CD029TxEUyRobAn+ry/WVDMbm1g4siXWkP9lZCbdfsQ3nfJ/iXyrnVjwCANxG6i4AVIDA6pDJtsuZBr6dRU/qe9m7/K5+ZYnJw8xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngwh8IH8q6TJe39guG5HFJkk+g10w8KGvTPWK+Tm+iM=;
 b=E/VyK4notIWC8+dilVUp28njqNQR5+pGuIl6hUPxlTIZaPl0sgtu087utK+dWMUz/q3jJg0jgol0bHPf9JoucB/LiRY1kn9O2elGjmAGdWdo/cvD+qOXw7c2TrScqYj8RyZ+oJsGB05vgQTQ+gL0B79/Vsff02to7AArGJzF1EihewRsMT5KarSWN//TZJRz9wWaR8xpGCIoEBaQNgdgVv643uvAKGfw+r2LvSFZMOTG4Cq/qTSPGH5owZxtc/PAN8m19tH8p/A+cjH7XCM5/SlsG0ZAjiw7wWAK0U1mvD6qtV2yqg9NhQO10TIM7NKW1sBjUfJC2zEP42Z1Q/aUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngwh8IH8q6TJe39guG5HFJkk+g10w8KGvTPWK+Tm+iM=;
 b=Nt2qPO+kcAWnxk0BbgWPReKs6tUGgy8IxuUUxHgmh6nFDpoGMqsC710uEI37fxJJ2w/b7RZXfQUFc0zb31yLEMJxpNldHyTOmXWsBpZbAUNobC7OnxhQPEeHMTnGLGkW2zWJMb7RK/xEvhxv6HBqYtKeH+xLrCXPpYNrcQlQ8WE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 00:12:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 00:12:12 +0000
Message-ID: <97d1de75-62ec-dcf8-2d0d-e783a07a24fd@oracle.com>
Date:   Wed, 2 Nov 2022 08:12:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/40] btrfs: simplify btree_submit_bio_start and
 btrfs_submit_bio_start parameters
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667331828.git.dsterba@suse.com>
 <5f4b7a11669006529515316bececcddbdf513534.1667331828.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5f4b7a11669006529515316bececcddbdf513534.1667331828.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 404744cb-7989-47c4-8bf3-08dabc66e3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXJi+3zlNMxxabedPAyVOmCNcU3HvgJI1QLrWHXxJDojpAvDSBJZGw5QmNECFL/3x16AOTElmMvjJb20/ri4jgdopYk6vq+AYKtcJBjcM6WMfkORvcfmenhf4vhKFgPXmVHqe+2pYxXIshPhzOfaZK94/7vmB6AfkFj4tMfviQcz0L0+JCjc2EhSeVRT/FuMWA/3f3+7UNIkzfHi3XOuD6nCCjXhOMFXSZ+HN5L19RAz/JNVJTCp8X9lZc/BgGWsqbnroj0qsH5cpHdPRG9DoC/NLTotRKOyufKE4rF8XbIjdh3YxVnIyPzf7B0Zek5f5ottE3AYW8O7bQoIdIUH24OY1Zw1lOv0YcHzHDWUolqurl2wtomVbH/YmNzPVGa7VpVGyFAS5xH2sQUu8NTwSjHZyqGnVufr2eyuh2p/r1rSGoZo0nBIB+esCo8V4nyCdyWExTR96OHuKYZu4iOCvlGxDxdPJyBrw31sVFeZvzahWyE21xt8CGhnjg0+Gm8FCVmQNK6ejxeMr3MubmygGJbp/BdtlYeLrhBekH8Y10V2I6YPuDNFjbnlU14YkdfA0OnNGftNLkZdPoNI36nLzlHSDCE15h7EHRzwTfksGmP+tNP6TWbKjKqvuPj582mhmCieGA/YazT/JuVpq5+glU0G8eeQiC6peJMwGTRUUaWbcloGPQQfPhqSh4TuPdHRFFwKoob6RXtaAx1DO2/J/wWIkUEC3FUoe4YXmnCZsFZrEjGNlQ2aziyPzFpzCX4ULGktM1bx8AT+bmlJq0Zo7QnfqN1OOed/MRfUees7Lrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(26005)(6512007)(2616005)(478600001)(83380400001)(6506007)(6666004)(186003)(4744005)(2906002)(44832011)(66556008)(66946007)(316002)(66476007)(6486002)(8676002)(8936002)(5660300002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VldXUEttZzlEMEZSM21DK3V1RVpLQ0RNaERUbXNkdG8zMUpSYnd1M2lPSDYw?=
 =?utf-8?B?RWk2U012QzB4SmpVTUZtNUVNcFpOb2U1YzExM1FoV3pvSXhncjRMTkRFaWwr?=
 =?utf-8?B?N25EbVpkbFlKcE10QTcxT0gzM2pZUkYyeks5cE9QSmxpTW1EUGNTcnFkVUtE?=
 =?utf-8?B?Nk81ZU5iQXNiMFRIZ2NiYkwwby9PUmFCRTE1S0VXNC84UDl5MHlmeVA4TjNI?=
 =?utf-8?B?c1RaVkJmaUo5ckJ6RlVTN1hMTmpCdHhQWkUvMFlPcVpuNWswYnlEdSt5dER2?=
 =?utf-8?B?eDc3V1lhbStvZnVjaHhaUXp0UGRDaFgvQ1N3YnIvSGc5ZWw4bW1VRU1oUzJM?=
 =?utf-8?B?VlZrWVRIZnJYRlY0RDRudGNKZ3VUY0dXencxQjZXZWFZNnVpQ29BQk55bjVJ?=
 =?utf-8?B?Z252RUw2dkJwMWFGNDN1UWk2b0lNMUdqWS9LZlhWaGNKZGtBRXhIcTViRjdn?=
 =?utf-8?B?eDBPT09saE94U1ZyTHM1N3VONmFva0NVWTlmVTZia1NMTmtiRkNpb1FUUDEv?=
 =?utf-8?B?bGpQZUlkTUF6TS9mbkE3VmRiSDdBcTg2TUdFdVU5VzFLbnVwNEZoTUR3bWNR?=
 =?utf-8?B?NC9VN09xMm1Pb0V0VnVnNmJUMUwrc2dKSkl4UDBWTEEybjVLNEZEQ0EzUFBK?=
 =?utf-8?B?Z2FVUTFsY0YxTTNibjg4dWtLdEphNHpPZk1pTm9WNktVMXNrL0pQNE9lTXlY?=
 =?utf-8?B?aGhqNTNFVHVRM2VEZ3hzMGxMT0ZIdmJWT1JOV0pmb1Z6akxFd2x4QU4xT21N?=
 =?utf-8?B?Y2YwU29jc3V6d003KzRSYTUrcUtweXNKTUIrNGs0YXI1YUhFSmtvN0p6SFR6?=
 =?utf-8?B?YnkvdkEyYm00bjBSdVdobUpWVitRcW9lS0NvRW90TXdRVzhrdGFpWXRRcHFr?=
 =?utf-8?B?NDJPNno5MktEM2JjaTNBWE5ESEtDVlpTRVBsNUpLREZObU53NWxZeFk5L0xI?=
 =?utf-8?B?dE9FZjN0MzIybzkxZDRTdEJYUk1UOXRmQ2hxSVc2bHprQytXVklzSEZuN2JW?=
 =?utf-8?B?MXNXZ3lSR0dOeGQ0WXp2c1hTMWlFS0l0WVVPTW5sQ0RFMWR2ck1sTGhRVHd0?=
 =?utf-8?B?SUp5UDdHMzFhYXNXMVFXUlRqVXpWeWpjSTBxTG9OSytmVkFoZVREZDEwVkl4?=
 =?utf-8?B?ckx2ZngzRFVSQlMwNEo0OGE5R2dnTXpFNjJpRTFJM2RoOUdBenVDY2wwYkY3?=
 =?utf-8?B?RDNFNjI4cjJEQ1lVMFhWdUpLaGpIV204R0lNZ1hFNmRtS2VRdUIwRXdqMkVm?=
 =?utf-8?B?S0hKNDNJOXJyYjVZNnVSV0FjckdxZG5QUlY2OVdVcXVrNzFaTHF0QTNkb0xh?=
 =?utf-8?B?Y0ZjSys3WmRwRVhSbUZ4c0k2SE5CUklQSkVLekhadFZUeExEOHluUWJGbWI4?=
 =?utf-8?B?ci9FSWpTRVdYYVprOFZRODk0SWxpVkdNQUREL2M0K1lJRENOWk0wQk5nQW91?=
 =?utf-8?B?Ymo5dzRTQ1lsdXFGRGtmZGxoeEpKcTBiZ2h6QUtNaGV6YzFzbjNQUVo2OXRL?=
 =?utf-8?B?OS9hQ1N0bGVzNzh1QXhwcnltb05YL3ZIbjB1ZlIwbUMyMTlXbWpmRVhZNmJm?=
 =?utf-8?B?RjBzYmpnRkNUUUE3Z3c0Q2dMWGR2Z3BZaWF2OGM4eitCSUJwK3JCaUwreGs4?=
 =?utf-8?B?RGtha1dNRkI2VFVqRVFYdmhNa0VaQ0FJdDlsNGdqYU9FUlIrTEV1SGZqdm0x?=
 =?utf-8?B?R01nS1hiaGkzMENQaHRkcmxzckg2c2VIc1RueHZ5R3B4NWdaUE9sTk5nVU1y?=
 =?utf-8?B?SUZwSFNZdS9zdk9OOWxlSlVzSVlaTER0dDlRNm1Ba1hVTUY2bTdTSVpyYUpU?=
 =?utf-8?B?c3FoRU13UHU2VjVHVHJ6MG1pUjh3UnlTN2t5T2thK0VNUTJsRnFQV1RQV0pp?=
 =?utf-8?B?SDVzVE4xblJ3ZWhyMDBaOUN2ck1yT3RZeEdhekN4Ym1iMmZLR2U5WFl5dGVy?=
 =?utf-8?B?SmdaOHQxSGRQckkyOEtlaXRnamxZMkRKUVpobEJJZ1I3SE50QkkwVzc0ZTNN?=
 =?utf-8?B?RStQRFcyUTF6ZEhWR21sMk1hbm84b2NmU0N0NWFyd1IrcUFBbzQ3SW9MTEtX?=
 =?utf-8?B?czVhYXZiV0N4dmY5OFJocUZNUHhEWVRvWTdWK1ZlV0FtRGVtWTF2UVliWVZt?=
 =?utf-8?Q?4UrLngz9cKq3J30lcGcrUUfUi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404744cb-7989-47c4-8bf3-08dabc66e3ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 00:12:12.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZkXenNYE1kjs3Qh7051TYRUY8aboUSSWkvQWoCrSLoYV6smn/JCHpgrQpZyh9Zw/BgScVrnZSjpxFiGX3l6/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_11,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010163
X-Proofpoint-GUID: VK-vtbopH9gAKRvXTKg3BnAIv5P3U60u
X-Proofpoint-ORIG-GUID: VK-vtbopH9gAKRvXTKg3BnAIv5P3U60u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 962e39b4f7cb..2a61b610e02b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2550,8 +2550,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
>    * At IO completion time the cums attached on the ordered extent record
>    * are inserted into the btree
>    */
> -blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
> -				    u64 dio_file_offset)

> +blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
  Remove the semicolon at the end of the function declaration.

>   {
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
>   }

