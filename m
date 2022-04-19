Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C23506BF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiDSMN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349838AbiDSMMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 08:12:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD0F36165
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 05:07:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JBsRKW019231;
        Tue, 19 Apr 2022 12:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/beyHJVI6O/JozUjOEgEQdV/o40bf850/A5lLZi+2a0=;
 b=UURrS6oz7ktp+fA6MA9qbqHX/1OD2GeWeRKwgD+qmt6ssxYcNvwgjbRYngD5pzx2umLr
 GBkF/lEk2NiwALZOZTuvsmI168LjJneaKgrH3scrN6XYcEYXfpdOcmDz0P78DdXmi86y
 wk3XS1V6Z97QBO3zWy8RuZ9RWaWMbNNaXTWOx0HWGLvW7NFeiOTLz9t4PlFN36BRLF42
 5uRmrQL6i+Atypl0VXSDKphA0974r5nEPo7DKzDeMyndOEz6Y+HuV2st9RBiu3OG9QcV
 CVTHBk47LlztAtZRskynNF49Ft3l27JN1pCvkIFzL1+YR6k1hjtaIOwgt9IXzAZbADrO zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2nt36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 12:07:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JC0dpW024435;
        Tue, 19 Apr 2022 12:07:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm82fuc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 12:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehczOh3e/F0UxEkT2uWa1bQyvMd8QhMdztOmCJ8Dqj6qaZ2aAWuc7LnUw2BxtxYSpIivbcjK168NJRytI8iQDUVm8PwZqyqJikhEcS0tjZa8E58eH4bcechLgN5BlcDrpeDyRbgL53kf42nddMcpk2hefX7MJ98V7wPuiedCqmuejIq3hwBy77p2AeSNge0n+xxzvLxRJDFs3ouMsVn4GXszpWVnivHtNiU4PeLVrEXro5NwV4MbWJToGfpryL7ed1zGGs4y6Owhb8gPJNAX87Tsh6eKqd93Bo3FZiNfivE9H1wcgXkt4tkJdpGlrn0KVAj9fvcPrAZ1WM3z9ZPk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/beyHJVI6O/JozUjOEgEQdV/o40bf850/A5lLZi+2a0=;
 b=IdfmcKJrw/obrGsYwlAVf1HXLE9gyQBnG0PP9HVHlEYKNw82jmVMQEBntu+9y0xpLyy1dLVZTuR+0B/Roz/0+61rQ6jDWDOcA6oeWxQev3xzToHQsXVgBky+ZnuKpNoWCMa1/Z+Md0Rsk04VwFgNLFr89FVvE0uz8KO6/KLquGe4jySL8wvSPSSmH/QATGtx7HQXCrbEC/sCoINrvGd7jhe2+OE0hhc4NLfoDP0x1ythpBM4O1B07WchJXldEnAsWjc58jqQ4zv6nUnKuvUZFEz/Oz4BDxAQ77Jd/p3icmlnY6NLLxnmZnEzHj1OW6udcBJWj9b5KScbGQ+d+ID0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/beyHJVI6O/JozUjOEgEQdV/o40bf850/A5lLZi+2a0=;
 b=GZ+2828b+RP4uN03FMCWGSeqMMElI64jolVbC4FYqIo6mAJ9lDUVuBNaIwt5Z00N1Gsfh7zkNQl+3mf18mvfLirrrAcar0Xl4kzTIE20HrFYBYjj9hiUzv8T8X4V6jWHAT1maUded2boVQzjw6f58E5KZI4kv+9R8dViIu/G1Bk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB3864.namprd10.prod.outlook.com (2603:10b6:610:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:07:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 12:07:24 +0000
Message-ID: <3f94efa2-e53a-f032-6ff4-3b8994489b02@oracle.com>
Date:   Tue, 19 Apr 2022 20:07:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2436f2e-19fc-4b43-aa4b-08da21fd29f2
X-MS-TrafficTypeDiagnostic: CH2PR10MB3864:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB38644D7C9474772453E5AE04E5F29@CH2PR10MB3864.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onYBZUk2EqR3Azsu13VnCMByjHuPYuLOHuIT2cCtHDz0rySusIib5aSSR2/CqBB7NymVTLNlxfDZus0KgUynq8AYBeo4O0SYkciEzSSBsVPejv2tCgzn1UTbHktTXI2chQGMdW4903SQLb6fIaf7uWX0mD1U2a00wVKq9fk+Abfm+bFMu1vDOAiSwDDiZ2exK7OQYbxlvEH/Yrsc/0eSUSmEHyrHrt59F2iYR0dUz9Qdl8697vxT8TnzcMqBu+FNGCPG8qAzRACQApTPazHoqYFP+Qwa5dLaYc23KCe114wilSlCIyS7TGF3TMMzbt8q+/4W8YddjL+ChKz33Nj30oYk1p8HVqiWD91EHgLp5Nssti/mbr/Ls6Wh0hIJtx6t2yzMaeDNIFixRc36Z7AW0w8dFn8HC282B7ZUxoEUf8Nwz4gnv72FGcU8YkdzpsZx1PnkZDPmIxLREswsO1C1OADAs66FgW0N+xNMqO9q/rd1YpuuzhFTz2xM/mG3+GEqMhtnRecwCsDzaFaw4cHYAttQnbieyAHPZMq80Qo0WetT8pbWI3tv/vDQBhvOejUNFHSkC8Lnvh+EBB6qyBPLxY+ejkFVzQu3OZXrlsY/moIY0RiNxhTy+oqrwIa0MxFXototuSymPAGDdZz40Zo4QaaMV5VV15zfOXnt+yp5CQZz3dGmevDcdCGC8O5YKuChvtSXI/vPOqCgu9op52eXHFKqeM2wdrNfp9qs4nhfw2X0qRDXMfGvj7H9jWRtoAla
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2616005)(6666004)(86362001)(31686004)(8676002)(8936002)(6512007)(38100700002)(83380400001)(5660300002)(26005)(186003)(6506007)(53546011)(66476007)(66556008)(66946007)(44832011)(36756003)(2906002)(508600001)(6486002)(316002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9MNzJqL2h3OGc3ZnB2ZmJtZWUwejY4a2tDUXcrYU41aEZCSnBIZ0NLbGI3?=
 =?utf-8?B?WHpPKzZLM1Q1a1czSFgzdGVHU3lIaUtJSTVsZk5JdGtLWVU3c3QzVmo3bzhr?=
 =?utf-8?B?dlpYcXRxT3AxTjdYRnBybFlXTHQ1djZZMjlsSUNRT0N4bW5yUTNUZXU5M216?=
 =?utf-8?B?SS9LcHh4NG1mTnVxcHIzNmVIaUVBQ3JraCtIdVh1VkJFRW4wVkpDajR4Y296?=
 =?utf-8?B?VEhHbjhzY3FJQ083OUtJVWUrZzNFNnlQdUdPeHQ4S1JYNVV4Y2lrRDcvUEJr?=
 =?utf-8?B?YUU4UmQrVHUvZk1JeU1hNHEwYWNyZFB4aVEzcFZrUk04RG93cHFNbUFiOERB?=
 =?utf-8?B?R2lkWGM5bnFJUVhoSzF3Z2JEVjNQbEhwZm9IQ0lHWi9ndVYraUlHMDRwSW5k?=
 =?utf-8?B?RFdBbUdFNXZIL3piWFdMZkJjK29zcEY5eWVHUnBhd0w0UTdNSlZyZ09WNUZt?=
 =?utf-8?B?VitUbGthTmNSVnlKdnRaYXIrcnBFK016MWVYc1l6ZkZ3dFFLejJqV0VMNXd5?=
 =?utf-8?B?aXVpcjlJYkFWZ2kxdjhFVitTSVgyZ1pmQVZLSVh2T3FKTm9pYkI4QzBCR1FJ?=
 =?utf-8?B?MFNUUnpVVytESjg2a21UNDQrRVhpTEF6U0loVDY0N0JYL1ZDZUpQSksrWkxB?=
 =?utf-8?B?QWIzb3RBU25QUDByOXV3eXVHYjVPZ0JHVjlTcFkwNXo1NVEwdWdkbWpuSTEy?=
 =?utf-8?B?WFhuYXkyeU1kdWxyOEtjbW5ZVjduRzVDVWlodTVySHdIYVA2eE9qSnBmc0pa?=
 =?utf-8?B?QUkvNm0rS0lzWjVpL01BSHdBSHBWWURhbS84NmlZbW04Nmc1aWRlanF3cys1?=
 =?utf-8?B?Y0lYY0xIditlektweEJ6bGNSK1p3REd1cnVIak9KRi9PbzNpSzVmcmVBS0w2?=
 =?utf-8?B?dis1SEhGcmFVdkRSdCtmNlNhclgwY08zMzNha1BLeDRjRyswREZqeWREVTAr?=
 =?utf-8?B?blArSytEbVllU25jTlIyRlc5c29Sa1FFcFJjcE1TM2lFMzRXa29lc3B3bGF2?=
 =?utf-8?B?ZGJwQkk4dTA1R280R1RHaGNncnljeTJQMnFNV0tUV1FUL1BiSVVFS3NpVXdk?=
 =?utf-8?B?OEREaWxLb1A2SFQrbFpoblRYNzV5S29jTWpPWndXcGFMUzlzSDF5MVVON2hM?=
 =?utf-8?B?WHd1TG9ZMCtXSWJPQUpkeFJJTktxa3Zna2h4eHFFUnRyTHZxMEJCYjI2OFdN?=
 =?utf-8?B?MitUcHV3czFxNDBrcDhaRFd0ZXVBZ05yRGthTE4xN2MrR0lUM3JGTExEcUZF?=
 =?utf-8?B?bVBES0toWHhoV3NFakJqc1dpWlpCM3dJaG9adlJrREJuNE5aOVZFdFBpZ2lU?=
 =?utf-8?B?QXkvbXg4cnV0Z0NsZEdlYW4rS3pTTGxKUzdrMXV5b2xVNU9DRnMxVXZTZnpn?=
 =?utf-8?B?RnJxeWw3cHhKcXF5ZXVXeituREtVYmhHY0IrMTNieUNFTm5jMklxcVBIVWow?=
 =?utf-8?B?TXU1TDFtdHlaS1hNakFJMWEyM24wY283NFhKTTl5Qlp5RC9aT3BiUTh0OVRF?=
 =?utf-8?B?bTBnYno4dWwyTnBxNzczSW9aNlJpQW5xbVg0SCt6M2lIM3NlQkNsUkZiamc3?=
 =?utf-8?B?YXZHNW5oZVdDSXhTR1FwVEs4alpzRCs3YldRcW5DTTB0QXVReU1tYzNFL3V2?=
 =?utf-8?B?YnVQYUZxZFpzcUQ1TlpubE5GMFpHNEJiSndudGVOTmZuZjl1a2Y5MWtvU09L?=
 =?utf-8?B?cmRmVE1MV2YxTXlTUGVpWkNaOEwybC90bUowamhsNkxmMkV1Q1oxVWdYbVJp?=
 =?utf-8?B?QW9QTmN4UER6d1lDT0VsRy9qbjZrc3E4bWM0cG5sV09YM0pta1YwTy9LLzNh?=
 =?utf-8?B?R1lwamVMQTNlRC9KcFFvTVF0a25McExlSUFNOE42S2ZOQ0djY0VQRlkxUTM3?=
 =?utf-8?B?RlhUazRXdnIxUTNlWDJSV2FKN1NKdml0QnozRVczRjhNZm9WQjZXaFVTZ2I4?=
 =?utf-8?B?Sk5uYjVuL2lEOURPMnpXMUZMVkpodXlmWXcwSTZOMjRiS0xFTTN0OCtBaU9v?=
 =?utf-8?B?VnA0d2tOeUp2MnpaalZ1Vmw2MDY0bXVmaG4vMmwwakw2WmFadndsckxqZTZO?=
 =?utf-8?B?VU93RUtLYzZwQ0dUVytXZkxZY0h2Z0dzR091YmJWUVhaam5YM0JSMmNadkZR?=
 =?utf-8?B?V3JCZ29Rc2p5bDhwNGxRZzdXVVpiSkFMSUdBRVBWUHNneTF4N1RDYW05K3Zv?=
 =?utf-8?B?M01VN1VkWUllZ1o3U0lqcXVjYXVaOWR3N0tya3hHQ2dOYmJTaUZVWVVDdXN5?=
 =?utf-8?B?RlNBZHJQc3ZndkF3U2ZOUFZnZVFEYXlmSzU3Y1p0OGpQRXR6U25YTkZWcUZJ?=
 =?utf-8?B?akp3WTg5YTgrZ29xaW1KcWtCQmhWdFhYRnhwZ0VpKzhEQUdNWk1PQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2436f2e-19fc-4b43-aa4b-08da21fd29f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 12:07:24.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCIN+t7Ad52Ay+ViRF2WITwgkE6/zwLAaYLQ9H0YfABV04Tgus11eOoMl+dhYKZyHmIyJeuN3+7PojXD7FFA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3864
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_05:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190068
X-Proofpoint-GUID: ALRyTrpjx_KS0rZc-b-cSvPTAUV2CAi0
X-Proofpoint-ORIG-GUID: ALRyTrpjx_KS0rZc-b-cSvPTAUV2CAi0
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/22 19:37, Qu Wenruo wrote:
> [BUG]
> The following sequence operation can lead to a seed fs rejected by
> kernel:
> 
>   # Generate a fs with dirty log
>   mkfs.btrfs -f $file
>   mount $dev $mnt
>   xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>   cp $file $file.backup
>   umount $mnt
>   mv $file.backup $file
> 
>   # now $file has dirty log, set seed flag on it
>   btrfstune -S1 $file
> 
>   # mount will fail
>   mount $file $mnt
> 
> The mount failure with the following dmesg:
> 
> [  980.363667] loop0: detected capacity change from 0 to 262144
> [  980.371177] BTRFS info (device loop0): flagging fs with big metadata feature
> [  980.372229] BTRFS info (device loop0): using free space tree
> [  980.372639] BTRFS info (device loop0): has skinny extents
> [  980.375075] BTRFS info (device loop0): start tree-log replay
> [  980.375513] BTRFS warning (device loop0): log replay required on RO media
> [  980.381652] BTRFS error (device loop0): open_ctree failed
> 
> [CAUSE]
> Although btrfs will replay its dirty log even with RO mount, but kernel
> will treat seed device as RO device, and dirty log can not be replayed
> on RO device.
> 
> This rejection is already the better end, just imagine if we don't treat
> seed device as RO, and replayed the dirty log.
> The filesystem relying on the seed device will be completely screwed up.
> 
> [FIX]
> Just add extra check on log tree in btrfstune to reject setting seed
> flag on filesystems with dirty log.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

a small nit below.

> ---
>   btrfstune.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/btrfstune.c b/btrfstune.c
> index 33c83bf16291..7e4ad30a1cbd 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
>   						device);
>   			return 1;
>   		}
> +		if (btrfs_super_log_root(disk_super)) {
> +			error("this filesystem has dirty log, can not set seed flag");

Also, add a note on how to overcome dirty log. Mount / unmount?

Thanks, Anand

> +			return 1;
> +		}
>   		super_flags |= BTRFS_SUPER_FLAG_SEEDING;
>   	} else {
>   		if (!(super_flags & BTRFS_SUPER_FLAG_SEEDING)) {

