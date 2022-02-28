Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A144C6188
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 04:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiB1DJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 22:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiB1DJu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 22:09:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92C3D1E4
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 19:09:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S2lOLW015409;
        Mon, 28 Feb 2022 03:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5i7dIqppLdKZsY2RTJJLVWCk+94uXxNwfDSDA+JJOrg=;
 b=TUZM5KMAlerzmbJSmuBs4xRjskv34qMsqjU3/9Bxtcm+FpphUJglADdbwlWGxsw7zsup
 4NqXIPq/hDLBYmpsN+zXtH5qohKvC0akBH8Ey45gb6bd2ixZxbyzStsbm5v+yvxZQME/
 ZMSlYLr0EoHd8Sdlb6naQEGaCz7ro89QA6lnz+POCGS/Zj3zWkZjIN8hvyiYC+QZtsWh
 0mrwe2y58K6bHtIqJ6JCPrtjJcRsMMwzjciL65YVa8rCMKqcPF1piYt8x6Ca1s/uMvDA
 7LKylck/z0lgXpdo/LL1/tLgeVCalfv7ZeIhochRihtyZpfrY+J8Rb4sOYNJ8XtXQSMx CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efc3aau81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:09:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S319SY090208;
        Mon, 28 Feb 2022 03:09:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3efa8bx1u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iuk6zoqo7Gr7F3HdEMxckrxBF7Iw0ariVSBlreIv94sfJyNIcvudyKjyHeH9LnlvBwWFxEf8jAhzWpGTmS7C70MCuJU69L2UlwT0Q4/XMNxeQBPELE7YzGtBmjZei61gbqmAX86Q89bONomb+GmXZ1YF703HR4pyQZy5J08XChzdSufxkOsX9/qvZDUjTRyq3YFCXpkm/kW6PKAN7MZiUHuQxzd9FKbm90+/Bqry80d9efAjgDvGRkey+CeAl835oTgZ2J7DMHBn1wC4s8Q8rZAikm1PScBJj9Mh7ulU6crW6S7hHqAEHZsu0WuzS3qJmROmxI2hQfnxqC5k9lx8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i7dIqppLdKZsY2RTJJLVWCk+94uXxNwfDSDA+JJOrg=;
 b=hM8tf9yC6toyWQExokGYzp7+XOgbHLWeZ84QrGWpbkOlA+2HUJP1DzNq2i6OoG2rSDIKLDGQk6ShRDPiuEqFYQeEKA7lXaR7jSGPL66KOZASufznxdDr8sIarHoNS834dIbGx9FpLoHU5fqgrepJ1a5o41Px+3/a22vIe0b9rP6qDqo6Qfl41hZgFNrltsBoMPQsrsYAjyurh9GiyLZJatdsKdcn+vrJw/iUSogmqvtNAAqFs8WfcYpHf08sut/d1lJG/y5jI5tx8Ip4L2S1Zjx2W1wYTIL9oxucpkybAbxKZjuUnDcQvNkYqg94u9aADME/QyCqAQCQSQyfe2JoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i7dIqppLdKZsY2RTJJLVWCk+94uXxNwfDSDA+JJOrg=;
 b=wcf6sLheW2hh1mt4Meg6XUDfoa1R7RtWj33ecB4VkQY8h/ekxGWURlyBvualNUeLO10kMVOg03RWAXCWh5iOiFHaQsY8h4eupVoDoULSNCeYx0v4NP9qqk0C/g1J55X7F4xx0CQYK6a+nsTnKMiZmr7h0I7DklTCLamvmR4nhvs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 03:09:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:09:04 +0000
Message-ID: <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
Date:   Mon, 28 Feb 2022 11:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e476283e-86a1-40be-d3e7-08d9fa67ad51
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5138B9254732CD9938D551BDE5019@BLAPR10MB5138.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiM1iQC4DgyV0p0pXFz6XnnVwdvmd6SAM2GFh2e0sNLEBuLL8leUpKosx7ZDXi7R6kMxCRaAtS9G1uJLn8gCtnEQ20PNGzujzzfZnYLztrI2pNZktWPZtV35MhWGAMbJubduI1Pq9L1IlRizSjOKFAMiAjoJMPNk297StdvDVjePAKN1sXqR0uZUfo1l56QvQEjvaUDiw8seoHDYakSA5yAdAhsEhAdsj4NLAs7xVYW4uJfP+F7PDi6rENEbM9BNBUDFEDRebxLR2pt9mqMg+TpxYVvhsi6EmgcSxS3Of1KjnpQKgg73pjpabEQNepeeD29RYXwwSwcgw2H/bFhb4c5fCF0YcQCoIq9DlGgWUY/lYDDwsQNM5gr45+w973n+EAM81peE7niaCRxhqKh3RMVGImEiWScr+F48nsYukxNx7Sc/tR/RC/qP+aHKjcJcG7d1bv2TIiwn2C7D2DMjR15H66+8sedAxQyTxN/ZSJyTWaND3uUm79KpshXRVLF0tCTO5jnX4hY5eliTEjf37DvZ7Lbzo6mVpL6VMs3EE959otXfaTdggqNnqGyx4VA7g+AaQ+ul+eXhijoy++YBcpiLNF4WWK9lKh+q0mDYi5lmNEtjbiToefXvrYgF8OFVoLJub+RFXDIgZSTQJ3R6ykTlGyizbjXk/wyf80T6D7L1YPtKYVdI+Nc0HGwVyKTNjL45nGXKQENTOPkd+Qrsis/2dLDL9GKbJyh4TChaQCDefk28UXBzi74/jLtP/9Ew81f8o+0rK6Geo9+zxWVUXM44I/wZjJWerbzIqdTUnlkkcV9gKZI2QeujN96CPKGg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(966005)(6486002)(2616005)(508600001)(8936002)(36756003)(31686004)(5660300002)(44832011)(6506007)(53546011)(186003)(4326008)(31696002)(316002)(66946007)(8676002)(38100700002)(6512007)(86362001)(83380400001)(66574015)(66556008)(66476007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5oakZFcmdzTDdvNm9Sa3dLWE0xelhUWFc2N3o3ZVpodlRLNUVwU0JuL0Qw?=
 =?utf-8?B?WFBSdVAyZW00S2dTMmlpVXRFaXBsWDYvTjJCVXJWM0dMYml6RnBWaVNHdGtW?=
 =?utf-8?B?V2R0UEZOUHJ2L00rcFFKdWdDTVVjc1prL1BMNGVRTWtDVHFKbksvQUlLWDA1?=
 =?utf-8?B?SU9uZDNIQkZQR1BTMjVBL0RNOVNXcnR1VFhVU2Q0MFFXVXBGSzBZeUora1hY?=
 =?utf-8?B?RjZIaGhlSG05UTdadk81NDJPdVJQSFZ4V0o0NlNtWnF4M3UvWUtxcXA5Y0dn?=
 =?utf-8?B?UEh2ZGJUclo4NWs3d0JGbmtYZDdHVXV3d2pJN0xrSGw1QThrb3p5dFljTVZ5?=
 =?utf-8?B?RlNPR0grYXBtamx3aDBncmZnYlF1SFJMS1pkdlpKa3BQdzJ2aHlITmJpRnR3?=
 =?utf-8?B?RThnc2NHaUhsdk1qOERRZlFSOHlhQVgxZERDQTJPdkEvRndhYVl4em5zaEFV?=
 =?utf-8?B?ZU1KcXlYa2k4VFgrQXRqdWtLZkJWRmgxTWtlV3IxWEUzTjlDZTNMbm9qdmZX?=
 =?utf-8?B?eWMvajZNWkpVSndxV0Jtd0R5Z1lsamYydFZlSEpFZEhaV1gvV1E3SUMzcERL?=
 =?utf-8?B?TXVMbWxMTlpObmNZckFBM0lQQ28ydlVLckNqc2ZxdHo0SmVZdk5nMDNNd0ZW?=
 =?utf-8?B?M1k1S0FyMGN6WUhmb0JnYWhzUS9DdmhzSG0vR25IR0FxRUtrNXYwdmxqZUpD?=
 =?utf-8?B?eDVESjJ4ZThUSURHbjBPRHZKV01aVTZSbHE1dUhSczEyOEF1NmpZcGJvcytw?=
 =?utf-8?B?Y2ZxSWxGQ0dyc2lOR2R4THB0Ylp1K3AyM01YczFZQWFNYnlwR3hMVU1LMGtK?=
 =?utf-8?B?MmswZDFpWG16aTFYaVpzWWxBSSs2SzNlTENjVUZtS0FnbUhyTUxjdXZnaWRY?=
 =?utf-8?B?L0R6RE1YL3lndWdWMk1lTFlLV3JHQURxVGZabFFoVkhFZDRzU3d1Uy9LMVh0?=
 =?utf-8?B?K25ySGtZb2MzVzJOVzlTZkwyMGxoRzFNZExPWldqUmZaQVQxaXVKN3pObWUr?=
 =?utf-8?B?NWFObC9SYlREaEtWN0JicVo0OThiWlROWU83czVyelQzeGFjOGdWS0FwV0tw?=
 =?utf-8?B?bTNHRjRVejAyUmhrQm5IYWlIeHhQZ3BxV1BmeEozZ2YxLytGMTcxa2kvb0ll?=
 =?utf-8?B?d0wyQjNsV25uc2NGbytnR3QyY2Q2REhLdVR0L0tWdVRFUUxpTjNORlJnR1E1?=
 =?utf-8?B?MHBKbjdzeklpMFllTk0zOHVvT0NtOVo3R2Noc3NReDRYbk5lSTBrTks1UGpP?=
 =?utf-8?B?dDRBR0RsVnJrUHVKZlJGTE1hNEIzT1ZQd1ErZHNFS1RNR1RMUzExT0lSRWlU?=
 =?utf-8?B?MW9LRkpPNFhaNkhiM2R4NmJDcHBqWWZ6blo5bnhadGpuT0N6Z2wrLzhQRW1M?=
 =?utf-8?B?bFpQRDZjeGJRYm5jNG9zRTA2SjNSeG1hMTRkK3ZTODRtQXFRaW5ZUnlEWU92?=
 =?utf-8?B?S0I5TWtINWRvdTNFNlpqbkNLWEFEeUs4QitlVllCYWxFNjNKUjE5THdxZ25E?=
 =?utf-8?B?WEd6TUtoa1hyQVFIRFF1dEJlVFc5aWlxcCtCQ3g5LzVwZ3gvaXVLSkpVajNv?=
 =?utf-8?B?aXRCQldFdXozUE4rK2RMTDhOT0lOdGV1Q3dnUW8rRW9OZlJ2TjZ1RDZqd1h3?=
 =?utf-8?B?MS9qWkdJd1RUUzk2VTUvWjNXT3N5UkNmYWh6NUUvYUlRN0VGVzV6NHpaZndz?=
 =?utf-8?B?T0g0anRacHUwcExHKy83cFBKR0hLOXRycjhpOGFrRVg4bGdKWDNSbk5lZk9F?=
 =?utf-8?B?MzRFdFBOSnFoam5BNk9keGhrUHFOQ0pFbkRsVnNWdTIxSG5RNjhBS282R3dO?=
 =?utf-8?B?TTdSOVBOTysrZmRnbWFFSGtuM0hwWmczVVNiTHNNdUtJRXlpS1dYSWhIbkxN?=
 =?utf-8?B?VnhWTlpXWFZnUUhsTGw1UGZDNXB1azZTQU44d0M2M1hMc1RLSVdGSW9QNVhs?=
 =?utf-8?B?RSswVmlYZEpvbGdPSHlCMHRRRmRQUzJxNjZMSmRjbk51SldSQlVDcDRPNHdy?=
 =?utf-8?B?dFhwVEJoU2FnYWFQK1pMV1AvNFVucGRMYU1vbXZsSThjeEFSV2ZpSmEyMTBv?=
 =?utf-8?B?b1h4SHB0cjk1VktIRDYxVnJIODIvVUFSSC8rZWxVMDB4Sm9pN1dsQ0pLRWVh?=
 =?utf-8?B?a3JWVVdUSkdnTEhMdE9uLzdla1p0RWlaSGFzMGtPTHpXcVJ2RmVOeHJTck9O?=
 =?utf-8?Q?K9WuelPTVckvZyunXKKszHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e476283e-86a1-40be-d3e7-08d9fa67ad51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:09:04.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JtOIKXSmW2cUBM37V/FWEaP68UgM1X1sj07ZKuTazEob/U9Ntg5S40xtWV9sbvTdoXEmOZeqsUkZtiZC4ibfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280017
X-Proofpoint-GUID: gbvjb-QTc6b4fmeg6AozcwR7vH67t2Uw
X-Proofpoint-ORIG-GUID: gbvjb-QTc6b4fmeg6AozcwR7vH67t2Uw
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 07:51, Qu Wenruo wrote:
> [BUG]
> There is a report that a btrfs has a bad super block num devices.
> 
> This makes btrfs to reject the fs completely.
> 

> [CAUSE]
> It's pretty straightforward, if super_num_devices doesn't match the
> deviecs we found in chunk tree, there must be some wrong with the fs
> thus we can reject the fs.
> 
> But on the other hand, super_num_devices is not determinant counter,
> especially when we already have a correct counter after iterating the
> chunk tree.

Cause analysis is incomplete, given that SB write is the last. The root
(and thus chunk tree) and super_num_devices will be consistent always.
Do we know how the miss-match happened?

Thanks, Anand


> [FIX]
> Make the super_num_devices check less strict, converting it from a hard
> error to a warning, and reset the value to a correct one for the current
> or next transaction commitment.
> 
> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 74c8024d8f96..d0ba3ff21920 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	 * do another round of validation checks.
>   	 */
>   	if (total_dev != fs_info->fs_devices->total_devices) {
> -		btrfs_err(fs_info,
> -	   "super_num_devices %llu mismatch with num_devices %llu found here",
> +		btrfs_warn(fs_info,
> +	   "super_num_devices %llu mismatch with num_devices %llu found here, will be repaired on next transaction commitment",
>   			  btrfs_super_num_devices(fs_info->super_copy),
>   			  total_dev);
> -		ret = -EINVAL;
> -		goto error;
> +		fs_info->fs_devices->total_devices = total_dev;
> +		btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>   	}
>   	if (btrfs_super_total_bytes(fs_info->super_copy) <
>   	    fs_info->fs_devices->total_rw_bytes) {

