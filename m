Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4F60710A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJUH35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUH3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:29:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BCD2ED67
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:29:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Owk5019257;
        Fri, 21 Oct 2022 07:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=e3AAdhzbDfJu1XjJYoa5aNWaxnLranY1HoZ1xXJnbyU=;
 b=TIr83l5Cyr7hQjl2fpegU8YWCJ1yuWOJCErxmb7EiiVSirOS3hK5ZBEXeXS7kjL302jF
 C5LQStpMalkUETwzQPtd0j/Q06dmLtuGi7C25qrl2g15t/CEhmvnJaylQA3Z6LRsRh55
 aIYkj9l9ywrDk6K7stLX4FuIv3Vh/NEjnWgEBZMGMZ1H1QrcS6GlvaQgEDKJTx3javEm
 yXb5F8LZnnoXBCgT4emIVeJHAegf51pqVfy04hY8cGKdpI452b1GacS1BmJm54GmLjw7
 GqGFUOxxUaIuMKHQKvXbtbubwwoDxf0rTRclomtklUg+jKSl+USHeTlwgUmDZlNavIJJ PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwau3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:29:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Ahnj014676;
        Fri, 21 Oct 2022 07:29:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu9gv96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alvCiDoTbbMsQmCTVAVqkRQ5yQXNbUwDxOZmk0Y7WXiBmRffZ2J/QgYfZZFib2qaTOEAho132HwXu+6QypdCW2zlboyKciGAgD03Mm+Cg4bpYj8Q6H5/UklCX4OzawI3fHvQ7bK0+e4vQ0sG7c+hH37FqBI+g+Zy8eCkEM6SjWbX8wPwAP7aDLc8l/Y6wJUfLiSbGK7NxJ5HuNYBlN3rF9Guy5XosHhH2V2Xn1n0k8nrAk8cQoqsZEWm40HjHcIu1AQzcEJ0R4Kv0vIOtQiNMtGWzbtpKoDE9lr6kAY4VmrMEsBXHbv2CKBzFHXoepNbHjk3yaQ9uuKVHS7AA0bsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3AAdhzbDfJu1XjJYoa5aNWaxnLranY1HoZ1xXJnbyU=;
 b=U0bbNLZuzd0CZOcsRGxnMIPDd37szVnx8Q2QYBNfouMuoa19aBfejh4Dq7S9kAUaFnSojiY5uB7RgLJ97NokyKsPizcH+WkVSU1drGQaBFIhPE+CSQ1srAwUGinjwQu+o8+d3svSgwCWI5lFBtY6I7U3n+4GUD3+iG+6IwHKYvD7yCP9ZK/50ERsC/9TcWB0Z27BwBeQh+9cfb8YG1H2M5/XrIfSqVkZo8lndwca1PpPNR+nbB1mi3KzLpoRAJseVbR/HHTEAEj++usAlEfuj/XUkKeLQ+J9yzNRP0F8jXndIpwGVBtFni20F1FEMPN1uB1N+pXA/jmWHkSixYP1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3AAdhzbDfJu1XjJYoa5aNWaxnLranY1HoZ1xXJnbyU=;
 b=oZLl1cCmm8Y4gY5XsBYKxU80UbCjPkjl6Arrp8WA+QZMYCwsakoWVfnHAROvgJ9kmQGVfbrKbYQ7OJwBVrFk0Gmf1hheA9ooUIsUxG45ku58TnsM8wsG3Iy6I9dc61WpaKHL4c8O5fDqdL+lp2DL8XqBmaV3GsUEZ5uEnYIsMXc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6281.namprd10.prod.outlook.com (2603:10b6:510:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 07:29:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:29:41 +0000
Message-ID: <27920a10-d3fe-6432-20a6-9647aa2fd5ec@oracle.com>
Date:   Fri, 21 Oct 2022 15:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 12/15] btrfs: rename struct-funcs.c -> accessors.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <ee569c3a6fca1c6675d1acd47bdaced15f666cf1.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ee569c3a6fca1c6675d1acd47bdaced15f666cf1.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 52033a2b-007a-417a-e706-08dab3360473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQhyiQ4tXMDI7EtnI0BTYwl+W76USPJQR1+erO1vaTPmT4EIo4PF/hVK88m0Xb8XsLxYMPtTvAj958eZqoTxM82WMQtsvnPoVHAjagPZuf2moLMIM89WALBkxx5p+20LlqADXJYh40FLiNALCARkxMHKj7Cg+XQVHlcZbwvx0CK5l/xZAXXdEHidNVJkpUrXOY8Sf/HumG6v+7/S5b1yyxE+LYODpqlb4BVKVuzb4y4U96yecFdgChdgcS9qWIFN2IRIz6zlONu21kdGH8m+qwKtbLVRJKDky5Y0tszcOXLBGXWg+TKqw3hXXjCVpxSODJBIwNOR1nQCrKHfHS5IIdZ8VuFUJpYuDrHdjjsmKKSheyCM3kWGncm2NJ8up4jhmKU4yhStpvcEIG9+xQhVlLvhHVe4C8LiWMt55hUUnGaNm0UxtJkl4dYFXJ3gz4H5bte2HFay5VE3nU7o5WjFx5GaAQlzlcwySOANLURh9u+eQQf5z5oTEkxRPlIysC7VPIYZCqAqj2R4AHb/WYXCFEPUbuSbZPK0EE6vNzNk2UKsDZ3nBge8LTrb1uWuTwrjAtPrmheVmqAnTklS/mLKaOcfFIoB3dhGhLWyfmLCf2fEKoWjQyqKUtLWj0uSJVaxrMvOczvDZJm4EoTxy3fi6wSrvh+zNUHjX/TXtGIG4taCc3Y967cZeVIUqV5E8Dv4Hw5eLtpi5gqJ3f5o9jcDsr3lf738SexqVv2GOxa8nOa4NHeLdBYIeViFr8L2WOWEu8GCqQjuRzRDu7rAGXvLcv4fQeG4HARP2wl6Iwe6ajk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(6486002)(31686004)(38100700002)(478600001)(8936002)(5660300002)(316002)(41300700001)(36756003)(6506007)(4326008)(8676002)(66556008)(66946007)(6666004)(53546011)(66476007)(44832011)(2616005)(83380400001)(26005)(186003)(31696002)(6512007)(4744005)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFk3ek1wN252dWtJNGJ3cnFnMnRZa01IWmtWNmdWMk1GSlN0eisyajltT0xL?=
 =?utf-8?B?N1daMGg3MDhyeERmK0RxMlcrRXczZUp6NU8xU3JsVEtEN0FaNmdNVTNUekMx?=
 =?utf-8?B?OHFBMWNzaWh2RTltWnB0eEM5RFhZRDcwZ05lOUxGVzgrL3VFU0NWMDZJZkdq?=
 =?utf-8?B?cDNpbEZCU0lYaGxQOW16QTZUWTNyL0FBRzhUVDBNL2Z0RUNwMlRZMXVxbDFH?=
 =?utf-8?B?SGI4TG9Ed2pmNkg3TTVvdksxb050dzJBSTNIcWMwWi9pUndFWmJNeFBKZytm?=
 =?utf-8?B?a1IxcXN6WlZKb3dSTGd6OHMvOE11U3F6cXVNZ0F4Y0dQY2ZpWjZJWjNSZEdz?=
 =?utf-8?B?RnlWQlUzWHR3TmNSSWVNWFlMY1N3aXA4QXJTMnlsWXdNRWNtcHF1VEY5bnBM?=
 =?utf-8?B?alFSc3BDaXBSRGhxTWtsNEdWMDdpZlNRdGVVa0U0VDhjdGsvd3c3SmgrSndp?=
 =?utf-8?B?c2l2aGlLbFdIUGxUQ3hpd1pkRWt4Q0IrNWpBd3YwQ2dtM0pkbTl4OTZpRmlz?=
 =?utf-8?B?cEx6cFQxR2EyL3BEUXVBekhRR3N5OWR2QXJmR1dZSGdDMTNxZ05td0l4KzJr?=
 =?utf-8?B?ZzFCV0tSZjEwSE4rYVlaR0FxdmwvelNwbjlqU0dWWndyUVg0TWg0emg5SlpG?=
 =?utf-8?B?R2tqSnJRZ2hSMmlwMHhScUxibFBOZGtjNmRUUDg2UTJ1M2ZUUUMrQzBmOUdN?=
 =?utf-8?B?MmFVRHVXQWpKSUYwQjMvbkMxRFd0T2ZuQVFxcjgwVTBuM2RrYlovakRNWlNR?=
 =?utf-8?B?Y24wTnViK0VCd3Z0SG5FZEM4L2pRL3V6RjYyYzFmZmVYazBlcVYzeFJRZENF?=
 =?utf-8?B?UmpLMmdQYTh3UVF2WkxOK2JRSHMrUEFQaDFqak1vU0VBdWlNZkdjM2VjQUZ5?=
 =?utf-8?B?amgvZkhNUCtYelc2cnptdElqQ0IwbXk1Wkl6SlNQb1UvNmlhMEVLalgzM3ov?=
 =?utf-8?B?KytFUFJRWUUrZXluc3c2OUJaN21oQ2tLRU4vUks3eHJSWW1uSTc1UW9PeWVG?=
 =?utf-8?B?ZEE3b2dwenoyZWRObzMwTXR1V3pFVU1UUUM4VHc2K21IUDdlL0k3YVJzOWUv?=
 =?utf-8?B?ZXF0MGRkajRWbFVVQ0hWaUtleUYwNkxqOEFET1pnbHR1SmJnOFpJV2hjc1Ry?=
 =?utf-8?B?RHBGb2tuRjE0eXRsYlgrZDc5M2t3bmdQVDhCY2hUaldSYzVOK3JNN0p4TEdi?=
 =?utf-8?B?aTIrRDhCeDdoK2g2YUQwWXZDNzd2R2NDTkw5eVRjaEtHNVh1K3MyWDdIRnIx?=
 =?utf-8?B?Ykc1Wm1hMHp5aFRqNWxnUDFMSDduMEFwdjcrVVdhdXZoSHBRT3E5VE82akNo?=
 =?utf-8?B?eHZkNTNTZWtnaGNGZk13dVBJeHkzbUgzY3B5QWxLTTJRcFpwM2gvSWQ0VDIx?=
 =?utf-8?B?OFVad3lBbGM0dnlZdE0yL01pNU9HdS9aOGJ5QWptNUhvR3JwNEpaZGVsNVBh?=
 =?utf-8?B?aEs1ZW51VkJESmJBaXQya0tpcjMvZkRTQkxQSzZGNk1lWGgxYS9VMzVmdkV2?=
 =?utf-8?B?NkN6bFJXc1d5MTN6cjFmZk5LREVLQVYveUtld1htQlFxU2ZWdnlFdzl3U1JV?=
 =?utf-8?B?YmQyTitxT1RzV2w1dTB3ZER5K2VDcmV4Ukl6UVpKMUZrRkJGRXg5RENjWWtC?=
 =?utf-8?B?RW1wZ2FvUi9jNzh6U05EcnQ1SngyZTZMNFVvWEppTlR6MjFaSmVkWVltc1Z0?=
 =?utf-8?B?V3RnZUZ0eXIzcEd2TUFJMExCN0hNLyt4U1YzWU9MOEc5c0p4OW9yeS9rd0Zj?=
 =?utf-8?B?STdFc1FOYjE4NitIVW02cDVwelFoWGt2dS9MQndLdEpZaC9rUi9Sekc1ZUMx?=
 =?utf-8?B?WkRXa1kzMVhiQnZobGVQMDlzczlIY2RVWmtaZXJNMlJLbENQRmsvWlFVY0hR?=
 =?utf-8?B?cUEyTCtTRm1oZTJwZlJYRFQ1WjRrRXI1dGE5SGtHdFNXQzU5THZwWUIyVm82?=
 =?utf-8?B?Nkc4Z0M3L2QvNGpsM3hBNDhEWlc5dzFmSFgyWUk2blNaVW9NUGZSUXN1cUVZ?=
 =?utf-8?B?RjJiK2lXYUZKaFF5cUtKb2RFZ0xMbmdKOWMraFpYYlN2MFl4VGNxUDN0b2lq?=
 =?utf-8?B?b3o3a3RiOUMwSUhRSE51QTBjQVFuMDFBbmJ3OGEzYWxrdzFMWHZvTnFEZEkv?=
 =?utf-8?Q?fe6PlmcedPKiOpkylf2mBoL/g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52033a2b-007a-417a-e706-08dab3360473
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:29:41.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 392UqAcXXb6Rv/86CvkxF9PBIqNiezO6nN6dRHpYlddjpxA+9P0ez6GMKCA9Z7On/o1p87gBPtLcO1eLbJnhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210044
X-Proofpoint-GUID: Lz8YF6kg8Yvpi_2VCbsPmQd8idZXV94B
X-Proofpoint-ORIG-GUID: Lz8YF6kg8Yvpi_2VCbsPmQd8idZXV94B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> Rename struct-funcs.c to accessors.c so we can move the item accessors
> out of ctree.h. accessors.c is a better description of the code that is
> contained in these files.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

