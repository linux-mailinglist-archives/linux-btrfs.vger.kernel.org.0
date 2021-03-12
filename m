Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4143385A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 07:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhCLGAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 01:00:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLF7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 00:59:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5svLo146162;
        Fri, 12 Mar 2021 05:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aNTJJc0jolxyEAxa9yeXhfD0G3B/wpewnU157+jC7L4=;
 b=aT1co2Ym+mcSLzSb9V5IaOmETicMdHqBjxKRjlPLCy8Vn4UNWxXcFvYOuTVexf5eq7h1
 ID0lY7u86iLMvj0P23DDzGuDSAUMmgqDdr+1sRcgSiXbORZbetBU2xcOvznnJR67HYAp
 JG5sIQJOv7UAhEkyusMSjaUmyCYHrlLQqRtS73QnhjbIJUOZ/RaEGlpj6mefK3pfAtB5
 /g1yifueQAECvDnEgXKWuwY4Ke7MKJV4pajldhdFco7gGHwRgXPo2NjXGRovPKVGsAhA
 6sT+WYmhrE0w0E3TB2I4szmvu7973HUrrv545RmBaJ4Q19paARpOyFWjqSWNSHIedBWa 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3741pmrvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:59:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C5t9UT130644;
        Fri, 12 Mar 2021 05:59:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 374kgw2cq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 05:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqjpQxQxuRMASK6eiC8J7a+LBK/2wCpeTuMBNBDQhJB/geXyRCrrhU9It0d3nyqsmKBpoHyPYcngyHmCH2D4WgOL+nn73H3GdqYQf8EWuhEb8Y+fmf1gE5HITU9Cm9nQT1kfPSr2aoJmHBtyF3y+upm49gytTLhDexU5swSwMyq93zVFjLbqA/aQmtpdTUN+qKWf/3rmDVbfwakAf3vYbN/RQdMDAOeKnr6wb3Xdhm347/xg2c3JbPrB6KAPIGWw1ugC/TVrBYnKvqGhmLkGGyzBzRawHcoby53mxYUQ5d79qIzickajdu23F7xj+wFXNmL3mK7ml6sQOVEn1DD/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNTJJc0jolxyEAxa9yeXhfD0G3B/wpewnU157+jC7L4=;
 b=fw+mgAdDkFDwj1M/GguOa/uOJKN2xKV/U+gVdJT1BpWB6u8kGk4/oHzogd8oouy+9yBmwZ6Z3laM23CSjp1Md2zOt8o4/BorUGOfGJ8KFNav2ElknlfwC4YhP/tLWH7djIocNBlzRQkgp63bpV3Wa8TPLRNU2m39Za+Hqc6OXVd368SfCZIRp+INb4YJemxdaDGDw9f/JZJ4Kvuw6g/GeaOvUes0OpoWmH2qcbjf8YblfjEEz8DqjRQJbCceeE3jKF/GYAVxI0+W/rQs3WiuvLOMWH21LOKoJPt0VocNQHMOAIT9mtF8mcQ8SW9RBDjnyRnHqVuehQNgq7QEK+gR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNTJJc0jolxyEAxa9yeXhfD0G3B/wpewnU157+jC7L4=;
 b=fdOCGraTN7axI3TURpYv1TlQCG6F61i8cpvC06zR9xUNImUs+v2gd6/3tBxqVV8EtAVhhMkDz+LLPT5HLqpocjTwUvvLB9AOA/KtfoJ0uwubqseysoSHm5bmi9NtX34vnWuOU3JyrRTGOysZqYVqH9oAbJYL1eNj0J8XBTlD8kE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 05:59:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 05:59:44 +0000
Subject: Re: [PATCH 2/3] btrfs: do not init dev stats if we have no dev_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <af4642aa2c513f65cd41e17ac1be3ceca9cf4815.1615479658.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7a5002b2-681c-88d5-28ce-1181f049927a@oracle.com>
Date:   Fri, 12 Mar 2021 13:59:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <af4642aa2c513f65cd41e17ac1be3ceca9cf4815.1615479658.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 05:59:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa52771-bdb5-4046-76ea-08d8e51c08aa
X-MS-TrafficTypeDiagnostic: BLAPR10MB5137:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5137BDFDF3F6BF057BFCACA8E56F9@BLAPR10MB5137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ul8FTXRAhfQWO3YHVZE4pZBGdcSNnXH0EOT4jPs334oU9qrG9kci4/xYAF8TIkAJs9RIrRCEkutNAxhK2XKrmHfHyq76cDqA7zXqDWe9gOGi3ea2CTy5mZtKLg7151dTJRtcTEMkexmTa8x1T7K16uEuiMQJs1oOvmyNUN7SJIgISIiglMv2dpFWxvFtewmbt1JoERTDwaZQCmVuv3Y4R597JYZhppfkIuuruBYyt/lZFjdGb1rb0NBKAKZBQF62Cn9VP3xWhd1ivoiN8viQEfCPvvTP7w7rRoIl31nn3BAyuXnN1jy1RYIVMx4FVKVAs9nFGgI7gFTp21E3rbEVWXG2Fuuwvw2X7U4jZ/BOFE5AH6f9Rs3p+cLySuPp8OkYd8/EvFJ9GVI2vVO+CccgnxDaNvYVp1kCiHZ6sDRW7T5UBaniqq8e3nsG50oSQYBgyueNJ7zx3J061Eq/ubymb0MOJoBwSnmUhDdNEI901xF9K17sfW3jwWG55gtPoiJeWbEMfolWE6Nsj0FIpgD+Qr/IzUouLrpQtai4q92Nz9l06B6KqMmoU8SGbsDqGFUv19GhnB2IigNokQA9SLEy/P1qnA4GSaJGeBabmEWmdAiK1uUMYedY3Tej3VQA1dg9JIyt3pDjA6WTj2Dz2Nl9Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(66476007)(66946007)(4326008)(53546011)(66556008)(478600001)(5660300002)(44832011)(86362001)(2616005)(956004)(16526019)(186003)(6666004)(26005)(6486002)(2906002)(36756003)(16576012)(31686004)(316002)(31696002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmRzR3ErMUhvVnMyem5OdjBGd3ZDWGJJNktNV0NXTzBjUkloNmFCdVo1YjlQ?=
 =?utf-8?B?VTZKaXE3aTlBWnJtZU1PMmx4b3VWTWFRNG9oSzQyazNIdER0OERJUm1JVDl5?=
 =?utf-8?B?MjRjOWp5b1llUmJsOHVnejVUakJiNk5CWWhHWFNZVWQwNU50YjZUQ0dFdXFt?=
 =?utf-8?B?TFNQcGIvQnpidTd5dWxQTU45c3oxRWJmY3psdXQxdHJUZGZ3QUlDSmFjV3M3?=
 =?utf-8?B?a01adTR4dGpOVlV2VzE4WE0rNzd3aExUckkyV05CemFUb1VRaithNno1RHNw?=
 =?utf-8?B?Sk5FQ055MXpLNmVNYXRGRWtQbHRIeHpKRmM5Vk9YSklYRFhSVlB4VndBMjhm?=
 =?utf-8?B?eEtGa2tDcmN6T2tUcDhPeVVmSis1Ny9SUzJDZjROYUhkSy8zcTZENjBmMW12?=
 =?utf-8?B?ZFB4andaT0ZqUXJQV3JBMTJtd3ZlaCtmN29iclJteDVJRFFhbEF5Q0FUenVj?=
 =?utf-8?B?M2Q2R0VkS0FsZW5iT1AyN3ZNM25wQ2UvSEdVSnNRZWlJb0NnZjJBTFhGdFlD?=
 =?utf-8?B?UG9QVFJGdktWR2FBZG5kT2k2Ymp0cEx4cnRiUDBwaGpPRzdWQnI0Z3ZEbi9j?=
 =?utf-8?B?NmJqQlkzaDRNaDZOSjQ1SXMxdkRBOEgwUEFReDBqMU9ZNm9DbStVQ0EwTFU0?=
 =?utf-8?B?Vk1kZUNtcndHQTFMYkxnU0Z4RFkvT0ZxS0pjRWRRVnBOR012T1FDanhpVWEw?=
 =?utf-8?B?MTZKaXMvSVVaeGN2dU9JVTF0aTBVQWt6SE9ISGN4NDVLMFVwaERmb3NpaGZS?=
 =?utf-8?B?TDU5U2dpMWgwT0IwSlBtQXM1L1VGYnp5cVNvMmZRUnB2cStVTE8zZDluT0dW?=
 =?utf-8?B?RFlVendrTmlad1BoUWRtSHUvNFdHUVRFVnhkZ3FpOElWQVUvUjRTY0ZzZExy?=
 =?utf-8?B?ZTN1bzZWVDZRMkQ0YzFQNklUbzh1VzZsbytDcTBRQnZPK1FNNXUwOWJNVThh?=
 =?utf-8?B?L3BDUHJCMktESndDM2w5ZmFVWlZHdjE1SnB1Uy9neVdIVjl4eis2YnBLSXlN?=
 =?utf-8?B?QlRjS2gxcUxNRXlTSzlxMXRlZmR4SWFtK3RMSXVacy94bSt1S3RMVU0vSGtN?=
 =?utf-8?B?c0tnOFN0SmJZcE5JSkNXQlVBVE8vZkFNRzA2T21SUWl2ZU9jd3Z5S1BUcTNi?=
 =?utf-8?B?cnNBbzZrcnNYcGw1NVNXY2psV0Y5QTJ1K05FWmhDUnZxYlNiZ1FMblk0QS81?=
 =?utf-8?B?dzkrS04wbkpySXVac2J3M0JwYVFQd0RDelV5TGxxQnFYSUtMdDY1L3g1NlhY?=
 =?utf-8?B?dURqVjloYml4ZUZXclZOMnBzcnpTREk4NjhGeXU2WjVqZHVkMVBSci9LUDVM?=
 =?utf-8?B?K0lrbWVnempUS2xNd1FXakZRT0JQODJ3bEVDTGI4NDdEQlVUZzl4K1RPSStO?=
 =?utf-8?B?c21wT3BGN0NOYnRhOGowSW1TN1Fndk9PSFh5Y3MzTFo3MHUrTEY1QjFNRDJG?=
 =?utf-8?B?bmp2elo1OWgrMHBWN2lJQi9rUFlJb0tZc2hMMXJScHl4MVdVU2hjWkNXMEtE?=
 =?utf-8?B?VTlMa3N5Z3RCd0NjMUI2TnBpOGRCRkVPTUF3THppM2hWQ0NidkxiTktaSVUw?=
 =?utf-8?B?dTJxaTEvdWY3ZjZQVU9QNDk5Ymp1bTdic3pxOHFWR0F5ek9IS0NhSk5wZDBD?=
 =?utf-8?B?ZGNLUjlIR1hRVUowb0NLdWdYT3dRa3NHRW42QitTdVQyWkNOT1Nab2ZMeEdS?=
 =?utf-8?B?U28vRmV6VzNJRDU5bDFGblhTTndFZXdoa3BzQlRkNUFpMm82R2VyeTloWmJC?=
 =?utf-8?Q?AAzBSEKALXmAcZ4jVjUaj1B1+6BFaQu4eNaaWMS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa52771-bdb5-4046-76ea-08d8e51c08aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 05:59:44.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a55aEZNTHCEr+mjeGmacvT676tXUHhfmRqB0raLwk4Z9VXR2IHGLoZ95cFcpgcgn+spevO4aZ+qSTwjvQ06RvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120041
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120041
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/21 12:23 am, Josef Bacik wrote:
> Neal reported a panic trying to use -o rescue=all
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000030
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> CPU: 0 PID: 4095 Comm: mount Not tainted 5.11.0-0.rc7.149.fc34.x86_64 #1
> RIP: 0010:btrfs_device_init_dev_stats+0x4c/0x1f0
> RSP: 0018:ffffa60285fbfb68 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff88b88f806498 RCX: ffff88b82e7a2a10
> RDX: ffffa60285fbfb97 RSI: ffff88b82e7a2a10 RDI: 0000000000000000
> RBP: ffff88b88f806b3c R08: 0000000000000000 R09: 0000000000000000
> R10: ffff88b82e7a2a10 R11: 0000000000000000 R12: ffff88b88f806a00
> R13: ffff88b88f806478 R14: ffff88b88f806a00 R15: ffff88b82e7a2a10
> FS:  00007f698be1ec40(0000) GS:ffff88b937e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000030 CR3: 0000000092c9c006 CR4: 00000000003706f0
> Call Trace:
> ? btrfs_init_dev_stats+0x1f/0xf0
> btrfs_init_dev_stats+0x62/0xf0
> open_ctree+0x1019/0x15ff
> btrfs_mount_root.cold+0x13/0xfa
> legacy_get_tree+0x27/0x40
> vfs_get_tree+0x25/0xb0
> vfs_kern_mount.part.0+0x71/0xb0
> btrfs_mount+0x131/0x3d0
> ? legacy_get_tree+0x27/0x40
> ? btrfs_show_options+0x640/0x640
> legacy_get_tree+0x27/0x40
> vfs_get_tree+0x25/0xb0
> path_mount+0x441/0xa80
> __x64_sys_mount+0xf4/0x130
> do_syscall_64+0x33/0x40
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f698c04e52e
> 
> This happens because we unconditionally attempt to init device stats on
> mount, but we may not have been able to read the device root.  Fix this
> by skipping init'ing the device stats if we do not have a device root.
> 
> Reported-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>
