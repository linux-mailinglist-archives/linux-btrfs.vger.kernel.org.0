Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33EF537317
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiE3Ags (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiE3Agr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:36:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64E10FCD;
        Sun, 29 May 2022 17:36:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T92vhf003652;
        Mon, 30 May 2022 00:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6QPhTb3MSdyXtP3VSSg4+wDMar38AQz1/zsO4d5vUk4=;
 b=w1q2zAR5WTAI8IyxaSS78x+06dBx+Y2UDvSsqDGSDkKdwW5Jtr9lfP/iCWUY1KN3TSfY
 /lViPwAEzH+wvsIexhlzVSVj/FAGKC056cReq4QRkE5liE6NP/LO1QvV5ugYT5w6d0wO
 MZdt9Sge33GMJBfHXkQ0WohSonz9SK7B+VZNm+13UuRaPb5xokwbmRAPyO63TxseChUN
 IRWY6GGVrfxFuE8aHgJG9cynS5D6fuyKzsHQjKFXwUCXoBotj0O467x9U615eEDVs99k
 VmnE0P1ty4UOoWwlkE/HCYCSsTTdY96f+F42EgKMrOECW3yVtaYHtIOFJU3jkgm/rbhw Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x1shh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:36:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0ZZq0040240;
        Mon, 30 May 2022 00:36:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kdfvud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiKFhkOXBwcyHP6peAf7ispcJyLv+29v/ydIKUVBOHwszBXNG47MOGMPiyyCb2wQw4HKKwZIRgYv7RGbO+1xiItIb6alFgLBOeajIeJD4FUzprY6zA0diooHf0Iao12iGMjE59WRj1GgRdd7eVnNpiloUIYQbeM6P7+WmOu2hN3MAvUtJ00nCZAoXxbNAkTpIgSxzl6n3ykNdXVncFyhD/nI4mZRKmYMdv3Y8FHW0VVvzCyVHPKGCn9R2gnJ7v1mba8iZ6l5cnFYx8zkkohTLyczjBRnEOUQSaFa90mM7fv9Bk20EQAzqgv06rhxX8SC+pzDEppXjQGPd3QpmfFWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QPhTb3MSdyXtP3VSSg4+wDMar38AQz1/zsO4d5vUk4=;
 b=miMX2NOza5GYGmiY7PBYsDDBjUpnj4BrF+1yb8Cthg2KpPt2PGVBCzUUfEGUgM1MIi9QhvEh+z9MtX41+6Sd2JFpx+BYHkSd6Bmdcvo02/pO9UMAKkG8rLmCwS7dJ/Ge1bvJZhTSNnoQlv++GF7FkFLdffl8R3LLEZC/Jko2ZjsQayY+UcOvfSDU4/he992t8fZ76Imuqv4NZWgw5OPRXN+InYcxZaWRj4hnbS42Z3W9KrJ3HvHSvTpOHs3M5Nbymq1ruKQK33W+c3IsFM6vKIEf/a296yN3ZwcH6OGjnI13WcpcfrwGFAF4axwCfasRqqP7DsPRMUUlHrWL5TJrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QPhTb3MSdyXtP3VSSg4+wDMar38AQz1/zsO4d5vUk4=;
 b=kItrV704P5cA0BApWD6bMJ+nn/H4i1pp38XhC0ruWrHquu3RTYUbwARsWVkbc86NKbFa5y1qdynQ2RqYZ+AMS0w/+jth6ThpVUIs4GKtH/QSgiWD2ycIxM9Jn5+qUNCzYfq/h7mL4SSAnm5EsB8jU4CLaou/RBKVouvIUkXlgPc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR1001MB2402.namprd10.prod.outlook.com (2603:10b6:405:31::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 00:36:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:36:38 +0000
Message-ID: <02c47a83-aba0-b3ba-8ce6-7a854825416f@oracle.com>
Date:   Mon, 30 May 2022 06:06:27 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 03/10] btrfs/141: use common read repair helpers
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-4-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f531c90e-b9e5-4753-8244-08da41d4752b
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2402:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2402D55C55C35714CFCF8FB2E5DD9@BN6PR1001MB2402.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLa8Emq6yuh5TK0TLGmRl4WFzobIoTytU8fIFOI+r0v3FiGwtfcMrmsGc/iFdyX6kbNxO5tKvszm9LBbBHj3PNQmyndicHUmLlbJsB7LeIQkvVkk5itDmhagOJCPPcCQMS8+RF65taOZAMsxc0/+ZfjYaDE9HnkOZWB+bzwWvvNRZe08cnS8XZFKUjMOJlLEsPoRKvjI0n38kyvOzl7EMUaQF2f2mFBjQb1TVFV7dcZ6GuxrFmXrtEcD0fOO9xkt1Hk8r7FQSSoKEWh5p/ET7bzdAf9eNjyVXKocPcB1E+hzzFgpD3Fx4ogvLGjjPj41Oos4FlOtFO46jEYovsR7otZm+9hKYE81ASlYOp/CucRIg57zkgPezsfP6jt0k/vCt5S+o+124guR4g17JJhQQnoVpFdnWlvZG2LJTKF8s2g8i4ExCgkKspeixYU1TwAoWfgHItNN3tl184cDqSG3RQXRsYFfmyhpVU9oPoJ+yu01T+JPrxc47h7zDm9TVSuQSSegCpH2Tx+rbapatu0nVk2Wn1IGY3nXyooWzxLqmOjtODbY4QIHO9ilYW2c3VwuVxQH7eH0oaV80rJP80dYywjUyrRDJU8RwFqqPn5uKBP8SD7Z/TU/48vDC7sm+Ny1l747GWbf9PGB6ms2ka1PMcnxz9+1AmSyB+uRf9nrK0hWaeEfsppfB+gbCsAozDTnegO/4GIt+iztf5oJVdmJtdxuicvL2nXLq9xCEAp2ftA1XIQU4GHyrcf4Z7ytDOTb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(316002)(31696002)(66476007)(66556008)(83380400001)(38100700002)(8676002)(66946007)(4326008)(2616005)(6486002)(44832011)(53546011)(508600001)(186003)(86362001)(8936002)(5660300002)(6512007)(2906002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xEaG4zRDRXcGl0NVJ2KzBhdmNKbDM2bFVLVm10UXhOdG5YUHM3QURDQ3dj?=
 =?utf-8?B?TzdZZDVkZTVoZk0wTGluRzg0MjVmZ2FGK2tyd00yTkdqM2x3WVNDSWFkeHpR?=
 =?utf-8?B?eGp2T3cybGpIS016UUdLNTN4RUZDekxxUDdrZ0lyYko5TjE5WmpUZkFZbGF0?=
 =?utf-8?B?UnhidTV4U0wrQUhyNGtyNm0rK25uVXZPdXFQV3h0UkZLWTROVExFc21MQU9F?=
 =?utf-8?B?NEYzTXhHRXJ1WlJUZkJNSGtZT2pjRzIzeWxaVEFBRDlYclJGYlR2S1R0RWNV?=
 =?utf-8?B?SERzMkI0Snllb2VFTnNyMjFHdmN5a3ovREZxTVJQNW5LalE2dzFDMHJwS0VR?=
 =?utf-8?B?ZnZNK0Z0WFV5Qjl6Z0dlVHBpL04raVN0a3dzenBNcEZTdWlRQXFwMUZCTkpT?=
 =?utf-8?B?cEdheGhwZ0wzaCt6UU9ZczJyL0Y4RUp5aG1qRjE2MXVQVWtPbTY0VUsvOUZz?=
 =?utf-8?B?ZmY3bTlnSWlEZFNsbVowUUkvZmhYeENXTTE0T0d5UHlFUTNhb1NMV1BXenR5?=
 =?utf-8?B?RlB3cFIyTUQ0bTJDczU2ODRZbEh5VlVyWHFhSEhhWG9WeHdJNStCYmlYUU5l?=
 =?utf-8?B?OGZYOVVJRlRqYWpUSG1XZzBSVkhvNjc4bHRWbGNZS2JiQlNNQWxZaEYra3ls?=
 =?utf-8?B?ZFhZYXdTYnBGZndkVTRyMU04RGRmaVl1T0p4V2NGa3lHQ24xM0kxZnllTzcv?=
 =?utf-8?B?TGlWU3ZaaThNd3NtaU8zS0txWWJrR1UrdndHaVJQRVQ2anFrOFNtZDdQeUND?=
 =?utf-8?B?Rnk4Vmh6Qk55OEZVcDhxYVFjM1YzaDZycEZLcVdyZnR5RFUwRlBjMkxRTnFO?=
 =?utf-8?B?QTRGWjUyaGc2cHdULzdPZGd0UFhqWW12VXZac0UwdG03MDNKR0RidGxhbWxZ?=
 =?utf-8?B?K0NJa3ZjVTR5MmwvVGZUU1pyS041eityZ05iN2hMZmorSk5tY3RmK3pHbWNC?=
 =?utf-8?B?cUdpak1vNk93SW02N0ZjK3libnhjVXhqa0RrQ2hGYUNZNDY4MEVIR1RORklE?=
 =?utf-8?B?WTMrUFpPbkltRkxXN0trNWxMV1p5SnpPY1dvM1U3ZnpndFNDTFdBUS9tMm81?=
 =?utf-8?B?a3hhcXcranlwczNqRWNjb3hJN2IrTGVpVTE2MWl0TlhQVitiZlFYSnA2bk5o?=
 =?utf-8?B?UitHNThZTGNmL1NIK2lIVGV5S1paU0lBckVBZnhCczd1dVBGSjdIak5kWXR4?=
 =?utf-8?B?RVBiRkZvZVl2Yi9Sb1ZvVjNiWFhZc2lLbkdGK0F3T2hHUGNIOGZsb2xwSW1H?=
 =?utf-8?B?ZGs3T0JpTmxiMXo4cThUQ0E1dlFiWFd0eWtDSXVlTGppSHBoYisxOEZHaHM3?=
 =?utf-8?B?ZnJSWlVKd2hWdWo0cG1rZEVJYkd2Qktuc1JSbmpLb3ljd2Y0dzZ0QzFPM29m?=
 =?utf-8?B?cVBXa2R0ejlaUmFYMHl6MXRVVUh1S1U1L3Boa3hVazBSZXFQRjhmSERnTjdM?=
 =?utf-8?B?Q05sMEZQcitlbkszbzZrQ1FzMFI1UDVUT3NuNjJucnc5VnhZR05zcXhrcTg1?=
 =?utf-8?B?aGx1bW1yY2ZjT3JkelQ0S3A3NDltUFl5bHVhb0J2VktLdWFNTHJONU1PTkFN?=
 =?utf-8?B?a3FQcHl6Q01KQWlUdGNzTklDdFduc1NpUitybFNNZUFBT0NSU1RPenNuQUhC?=
 =?utf-8?B?Lzhwa1YwZXg0QnRRZFJRd0wwZDdOcnhXRTM0bHNFL0JEVjZsYmdLNVBVTnN2?=
 =?utf-8?B?VHRRNUR4NklJMGgzdURiRlkwOW5La094cTJycEV4cGswUEhNNTdvZVBwVWx3?=
 =?utf-8?B?UGVaTHV5YmFtNnNBSVVncDYzaWt6V3hRL2ZuTnVvY2t4QzdTMFhxSk9NM3hm?=
 =?utf-8?B?NWUrWmtvbTR3YWNwcmxXbmJIVzBveXJTMW1JSzBsZ0dJaW1IeDhRY0xvRkxn?=
 =?utf-8?B?VzdubG9TNEtKUXYwQ05xcVArQkZZUU1zc1FkRFhjczdjWmNhWENUTXFBM2RY?=
 =?utf-8?B?eVgrR2MvRzU4Tk04VTl6Uk42RVpPeVFzRHhSYzJwckpqVUw4dXJPbDd0M3or?=
 =?utf-8?B?VWFjanp2ODdkQ25wQWVYNnpCK01NRWFIUHZBOTByblI1cjZ0Q3VkM3hPRjV6?=
 =?utf-8?B?Z254ekw3SUxMS0NJcU9QR3hyWmk1OUh0UEswblJtN0hUanVBaVhBZUp3SjNR?=
 =?utf-8?B?VHg2K0NaalJadkdQbkc0L0FHYUhVN3VkV3U4eWpZME5FSWF6MWFPUnpiNGJy?=
 =?utf-8?B?bXphWFVqV01zcVAwdzlSeml6aFBEZkhrRERyY2JNcEt3VU5hbFg3VzJMd25G?=
 =?utf-8?B?Z3phdmlHUTd6M3hia1hrWXphWERSQ3lydjl4UEZWRFk4TE8vd0RiSlZOSElt?=
 =?utf-8?B?Z3JaeHhyZ01wS3piRjAzUEJySUxEb1k5MjhaWDlNenBHRFhBQjIzZW40UVBB?=
 =?utf-8?Q?heC+k2nOT578fk6EQBwgntaewBKtst9x2LxTep8OLDvPy?=
X-MS-Exchange-AntiSpam-MessageData-1: e/lc8Q2CP3hPxBLxHud0YbZxZGlT8U+6HGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f531c90e-b9e5-4753-8244-08da41d4752b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:36:38.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRX69l8gmHA0ZYqCg+V5OVTWYT3UT7QUnt1M+0HLReOHJOujj6aJZBjQk1bBQ33n/bgSkT7rEFYRmbb4GOUGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2402
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300002
X-Proofpoint-GUID: KhuGVj3Sn4ONyicixpP2ny5eMpZfv8tL
X-Proofpoint-ORIG-GUID: KhuGVj3Sn4ONyicixpP2ny5eMpZfv8tL
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/22 13:49, Christoph Hellwig wrote:
> Use the common helpers to find the btrfs logical address and to read from
> a specific mirror.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/141 | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index 9fdcb2ab..90a90d00 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -25,7 +25,6 @@ _supported_fs btrfs
>   _require_scratch_dev_pool 2
>   
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>   
>   get_physical()
>   {
> @@ -69,8 +68,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   # one in $SCRATCH_DEV_POOL
>   echo "step 2......corrupt file extent" >>$seqres.full
>   
> -${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical=$(get_physical ${logical_in_btrfs} 1)
>   devid=$(get_devid ${logical_in_btrfs} 1)
>   devpath=$(get_device_path ${devid})
> @@ -85,16 +83,7 @@ _scratch_mount
>   # step 3, 128k buffered read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>   
> -# since raid1 consists of two copies, and the bad copy was put on stripe #1
> -# while the good copy lies on stripe #0, the bad copy only gets access when the
> -# reader's pid % 2 == 1 is true
> -while true; do
> -	echo 3 > /proc/sys/vm/drop_caches
> -	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> -	pid=$!
> -	wait
> -	[ $((pid % 2)) == 1 ] && break
> -done
> +_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>   

Same here too.

Otherwise. Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   _scratch_unmount
>   

