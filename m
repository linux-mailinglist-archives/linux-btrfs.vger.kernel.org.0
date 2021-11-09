Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7688F44ACC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbhKILil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 06:38:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24298 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239543AbhKILik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 06:38:40 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9A1Apq023916;
        Tue, 9 Nov 2021 11:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nnuZ3gVU+iN2moN5n1zcIGCxmAOqd73jTEoqd+dqFlw=;
 b=iXcgR1b7YTnNz6+B9niDk69y4uQ+2lb1RjxLY7vP3E2MZBn9MtB1wfIY5exrGSuZvH09
 xVBt1qJS0rDBZzLxq5blv1Z64+eCIId9G6CikKyrL8ESbvzA9ILdbUothDbuEuSrTxR2
 xRTH7in3kpCHFrd4erV8xJQ9PltALXa5ozvT3Rt28wUW8Ta6R1HZpT3LaWfyUTN4U6Dw
 7eutGsemXtJhVhqXIrCS06yIjzLHEWEW0eE2xUTk4sX1jsav1rJw871fM5es2wfcTAnL
 qBhLOPwL039y43x1ieE+8HFUtCp3wmRZIicDNjg13ICYBlm/Ropf9WN3F8ohe9EKxIbp OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6t709pmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:35:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BGG1v027196;
        Tue, 9 Nov 2021 11:35:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3020.oracle.com with ESMTP id 3c5hh3fkqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI+EVqkDg2zxBor1a174dac4qKXTWMQd9QsovSmbsPsboPA2d3NhM7Me6bbKrXhsRqLuccacDzasXs1aSDCB5kBKTQEyMvhooOyIXxhNF7+X3zDypFxAqB2YjEUquuw6FFzsnzYzcg2AgKyfGa1VwbzMxxYV0qMnu2SH7dUIm8Vm2twJDZuu8n5kDroNZw4fAWbpn9YXontRItfVZBw+CD+uRdURjdAxGEHLNzFp6q7ulUct+kLY4FqLeCsllAHo2NSF/cvZNSUmjPLl3LdypwJQkTVRxuTSbD40huy7u8/B/EmPO9ulWQjEvgvqtE4soXvEUZxBeGSN4ej1xtAJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnuZ3gVU+iN2moN5n1zcIGCxmAOqd73jTEoqd+dqFlw=;
 b=GjBRtA4weA2OxcaW88XPhakZ65fFp6ksiTi6Uqc8H2hvJ7yuBRbk4AEd6b21BULKAwnxtXbJlIvJHnNZV7DgFHWlulLB3V4Kwz2oiBvpMd6Dkw8FH34x1rW60yAnlE/kpeI4bHK+nIkDgE1tA+PmqaSOXlTGFM5jPuY2pk5HVll+gG8jZos2mZtzhm0cxH5bsA73dcV+J0ia5PrdagjqGB6+JfIy3eG9VhNLBRtUHKryPlJEbpoFCse8izyoquxRZ5ekp9szwt90ty2K2M+gr287C8WMmffM5liCLvIrb+SghHh22l1KYpcUFC4Z/amkRYvslbU/F0agCFESFJ5gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnuZ3gVU+iN2moN5n1zcIGCxmAOqd73jTEoqd+dqFlw=;
 b=lPViUSN1hpgXMNwuSM4Jn4cX43x+Y7co0/7orjXFIbN6x/BWUm59G9WQDYkJ339+9Z6eZvVfeopc5jPLZZoy3PazkWWdeOT9V0PLrPcVNeoZmCyQmGSKlZ5UBU/xL3y0fsJ9vcvIrFrUKxKomBz6T24hDy0k6ti/trJlwQLRrQs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 11:35:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 11:35:48 +0000
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
Date:   Tue, 9 Nov 2021 19:35:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211108142820.1003187-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SI2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.5 via Frontend Transport; Tue, 9 Nov 2021 11:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37465b10-a41a-4933-0120-08d9a375139b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5137:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5137FD37BE303BE6517A166EE5929@BLAPR10MB5137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E66i5tsuWjajvWO7PrxvYtQRWWfJxk6Zh+uDcTjq4qo757F0EjkuTGsZ2Dwl1fApyYL+4P46z7kljSOtLL6WIPAOASsVhN0K8hC9u6Exyz0J0LeldHn/P6+mLtA+I6kZ5xjma6jKjFme5sOUml0alpoTqnt1Dv5RSqYKBZbKCbQ9PjDvLcWVYTBUiEpLujH7O/6r7l2bx8Dk9GOlz72JjY6ZDSylHb1SlH5yFVivqkaDVSZZggrfrMfD+CUkG0TCsSN8bS4CCFRBprqIvzPOqMvoS+Oc/4BEQ+J8bNRF2M0YAltwOJ0iio5XIUYdWHYrzIBalW+EvYPevJD9jWAySqH/RE2mJF1u5+Ry4Ns0IB9uVmjaAx1mJyUGmmF1KNbZCmrDCl5uFlypq4373Lo44Bvr+ROydJBuFJJJ1wF5E/q0LYzx2c6qwAKKQ3IKYJ+e9+MsPMG15pICvfLd01Avplx59gu8nhhrYE5BAw2avr1fp1bAfSvl+vZfcs0pIRsLNggYgF2VgJvu7npEzZ4nY02D0xSB+tB04AmW8k0VHHmi7snBPU3zt1WrXtrgYf9a5HGSX9dpE/U2pranaX6eFRjfRtDCQTn9jWhFs+l9mbTE3dJYqxEaO5x4ScFi41cf4wJgYCTH5zGZYUl1ikpyyMQ3HWvpCVCPlRXXOfRhWw3S3qdLYRZvYFlzB/0c0wGVTAt+fRly1A6D/tKsB+JK4Wztxugf9N1NCXHIf/674yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(83380400001)(44832011)(66946007)(8936002)(6486002)(6666004)(16576012)(186003)(38100700002)(36756003)(8676002)(31686004)(66476007)(66556008)(5660300002)(53546011)(2616005)(2906002)(86362001)(26005)(31696002)(956004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHo5S1B0NzcwSGYzbWt5T2NLUlZ2SnVGOTFqakx4TUt2UTN1eHN0ODIvYTdU?=
 =?utf-8?B?VUhIVm9aY3JJVWVDeHNqamNHc1RlZFlZVEpEVTNNdFROc0wxcDd6VmdwTkNO?=
 =?utf-8?B?ZVJGR1c1Sjh4a3BhaVowT1krMUZ0eXMvSS9LVmxibVZmQ2VHSUZjUGpDclZK?=
 =?utf-8?B?dlloNzgzbDlaRzJ2bzNxSHhFMHVHUHJ3OFV1bjZ5NGRFaTJHV3VNa2pIVW1W?=
 =?utf-8?B?Rm14YkZFMkxBTnhqU1NuTVdjam9rZG1vbFVBRmRPRDFFOE14dHBVcm1reGpE?=
 =?utf-8?B?dmNlNzAySFBxTVdwd01iMUtiK0Fld210Y3NBNjlqaS9ocFg5Zit3eWlqWmpU?=
 =?utf-8?B?b3Q4Q2tCTzZJRjFtTW0yZDdGSyszajZPU25oWldXK1ZHV1VhUFUzUzY5YTZz?=
 =?utf-8?B?TkRiQ0JXZ3pqR3cralF2dFlYb2dyN3laVm1TOTBZeUFwN1dybllVSURHV0xl?=
 =?utf-8?B?b2o3TGxrQTJMYm90Q1hwMGQ0Mmp0Tk5PQmFnNkFEbnFHeVVkWm9IdGtJWmRG?=
 =?utf-8?B?bG5HcG41MDFHQ28ycWFkY1NmSkJyME4xd3kwd1VwbzhFU3lBdzNPSjZFeWl1?=
 =?utf-8?B?RDdKVWIzT01UL05iVk1wWVBQblNFQ2pDTzNnQ3NDSHpnVUxEanhWblR5N0hL?=
 =?utf-8?B?MTExd0hUT1JpUmtBVWxPc3V3VDBLSEN4OHZpbnNrcFhDTXN4ZlN6eGxnb3JS?=
 =?utf-8?B?emVnOERYenRiQ2p6aEF2Z2NHdDQwWVdQdCs5Y3Q5QmdJdjJCZXNrRXVTWkVX?=
 =?utf-8?B?bWZjeEREaC80NDczSDdhNGdOejFJakVOLzg5MDBBV1QwMGI0VkhUVXVLYVVq?=
 =?utf-8?B?aEJiMGVZN3FaYzNjV1V0c3hyS1NpNmtHdW1uUlVKVlpTVmlsTDlJUnFNRHND?=
 =?utf-8?B?QlRHZU9Ea3VOSHdFZ2ZlZUJMWjV6c01YZExheUNnZkxySTdvNkY3MU5raFdZ?=
 =?utf-8?B?S1FnOHdHWmc5VnUwUGRiVUd1OUJqSE5aTWZYTGhwMk16YWczVUtZMzdZTWZP?=
 =?utf-8?B?VFRmZzl6dERxMWhDanJISDR4cUwyYmhlcE1MeDhWVzRBaHdTcTVLZ2NNNXJY?=
 =?utf-8?B?Vzg3SkFFbnFwL2hCeE9TalB3T2lhbi9WdmVzTmx5MXpEQVNZcFBobkdOMUlP?=
 =?utf-8?B?cVluMVdDbDhPT2VKZkpsUDVuT2xZcCtYb0M4S3R3REJtbTRPUkRHREVxdWhV?=
 =?utf-8?B?SEd5S3Uyd2dKUkRYc0crTExNa1VIMTd4eGo4djB4Uytwc3J2c29SQlZScCtj?=
 =?utf-8?B?Um1qdVlrNXhzMkZQblBkNHM3U0huaFlXWUZPNGYrRFladksrNS94aFNKUUsx?=
 =?utf-8?B?MWxjKyt3em1qbnBWL2xoRHNGblBZSjNOdFFXNytXOUtIV0V2eGRMWFVTM1dP?=
 =?utf-8?B?UHpJZVYzOEpKU1BFUzg0NnVWVzlvYmMwZDUvUnBLaTQrUmExWU1Bb05rWmhw?=
 =?utf-8?B?aTFCTlNHbjl3dHVFczZON3Q4dTh1K0Zxd0R3WEtZR0lKdTlyaE9vRzlib1ZW?=
 =?utf-8?B?U3lYczRmTEp0VTJtSXpzZnBwM1ZoQnErQUswMi9leGQ5eWNTc0dJSURZbG1o?=
 =?utf-8?B?SngwQkgrQjRZMWxxb0YyQU4xcHhPZ1ZobU44OVlKS2lSdElRZ3V6ZkxzQmdJ?=
 =?utf-8?B?bmdEVWJYa2d3VGt2WThFTVdvV05rQ1JWV2Z3bVZLU3NhM2wyYTFYUlZlVGow?=
 =?utf-8?B?SmMwTHprdzhIZWg0SXdPZWxXS0R2aXc4bjVSQTZ5R2Nyc3R1cmRxemVCQXZT?=
 =?utf-8?B?M2Q2NkJDc24zL1VmUEo1OHFsSEVZVEVjY3U0YXRtS3F6NG9RZDlaSlVmQlNr?=
 =?utf-8?B?QXFJL01Tcm5WY2JuQkhUZmFtL3FXWDc0dDgxbkRnaW9NWWQ2ZHdRRkpBVWNl?=
 =?utf-8?B?Z29nYVpJTnlvRGJGUlQ5d1ZQKzN1RHlUVjJ0UUFJWmZ3UzJ5MG5Gd0Q2ai9F?=
 =?utf-8?B?MTYycWd2T1BsdldBd05tR3p5SjZjc1pHKytoSFVOaHdvbmZCZjZnQXNHRGVP?=
 =?utf-8?B?Y1YxRzY1a3c5REQ4VCttTUg4ZmN6N1VGR0tlQktXSHpYSDU5QVRLU1A5M0tZ?=
 =?utf-8?B?bTBlODdYWDBnTTdMdGpvV3JyS0dYME90K2RraUtwV0RWNTR2MHdHbHhVT0lT?=
 =?utf-8?B?RFlKaFFpRmRyS3VsZUV0UVY2TmNEc1dTV1hBN1dFK3FUQ1VrdXNhelE3Tjlv?=
 =?utf-8?Q?F7JywFDyaxJxFWQaVHy4p38=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37465b10-a41a-4933-0120-08d9a375139b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 11:35:48.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K1vtmrlFgWP8IFVPM0vUKrNcL+sBHaLT2SM/s7sMmsGoFB00AyPn5JTNxuKTLOzcoFFUPr3pwRdFkNZe71E7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111090069
X-Proofpoint-GUID: uS2rx7q2MBwUgl0FoXfMs1FD8Fok3W0x
X-Proofpoint-ORIG-GUID: uS2rx7q2MBwUgl0FoXfMs1FD8Fok3W0x
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 10:28 pm, Nikolay Borisov wrote:
> Current set of exclusive operation states is not sufficient to handle all
> practical use cases. In particular there is a need to be able to add a
> device to a filesystem that have paused balance. Currently there is no
> way to distinguish between a running and a paused balance. Fix this by
> introducing BTRFS_EXCLOP_BALANCE_PAUSED which is going to be set in 2
> occasions:
> 
> 1. When a filesystem is mounted with skip_balance and there is an
>     unfinished balance it will now be into BALANCE_PAUSED instead of
>     simply BALANCE state.
> 
> 2. When a running balance is paused.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/ctree.h   |  3 +++
>   fs/btrfs/ioctl.c   | 13 +++++++++++++
>   fs/btrfs/volumes.c | 11 +++++++++--
>   3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7553e9dc5f93..8376271bfed1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -613,6 +613,7 @@ enum {
>    */
>   enum btrfs_exclusive_operation {
>   	BTRFS_EXCLOP_NONE,
> +	BTRFS_EXCLOP_BALANCE_PAUSED,
>   	BTRFS_EXCLOP_BALANCE,
>   	BTRFS_EXCLOP_DEV_ADD,
>   	BTRFS_EXCLOP_DEV_REMOVE,
> @@ -3305,6 +3306,8 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
>   				 enum btrfs_exclusive_operation type);
>   void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
>   void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info);
> +
>   
>   /* file.c */
>   int __init btrfs_auto_defrag_init(void);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 92424a22d8d6..f4c05a9aab84 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -414,6 +414,15 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>   	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
>   }
> 



> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
> +{
> +	spin_lock(&fs_info->super_lock);
> +	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> +	       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> +	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
> +	spin_unlock(&fs_info->super_lock);
> +}
> +

This function can be more generic and replace its open coded version
in a few places.

  btrfs_exclop_balance(fs_info, exclop)
  {
::
	switch(exclop)
	{
		case BTRFS_EXCLOP_BALANCE_PAUSED:
	  		ASSERT(fs_info->exclusive_operation ==
				BTRFS_EXCLOP_BALANCE ||
                  		fs_info->exclusive_operation ==
				BTRFS_EXCLOP_DEV_ADD);
			break;
		case BTRFS_EXCLOP_BALANCE:
			ASSERT(fs_info->exclusive_operation ==
				BTRFS_EXCLOP_BALANCE_PAUSED);
			break;
	}
::
  }


>   static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
>   {
>   	struct inode *inode = file_inode(file);
> @@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
>   			if (fs_info->balance_ctl &&
>   			    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {


>   				/* this is (3) */
> +				spin_lock(&fs_info->super_lock);
> +				ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
> +				fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;

Here you set the status to BALANCE running. Why do we do it so early
without even checking if the user cmd is a resume? Like a few lines
below?

     4064 if (bargs->flags & BTRFS_BALANCE_RESUME) {

I guess it is because of the legacy balance ioctl.

     4927 case BTRFS_IOC_BALANCE:
     4928 return btrfs_ioctl_balance(file, NULL);

Could you confirm?

-Anand

> +				spin_unlock(&fs_info->super_lock);
>   				need_unlock = false;
>   				goto locked;
>   			}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cc80f2a97a0b..e87f9ac440c2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4355,8 +4355,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>   	ret = __btrfs_balance(fs_info);
>   
>   	mutex_lock(&fs_info->balance_mutex);
> -	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
> +	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
>   		btrfs_info(fs_info, "balance: paused");
> +		btrfs_exclop_pause_balance(fs_info);
> +	}
>   	/*
>   	 * Balance can be canceled by:
>   	 *
> @@ -4406,6 +4408,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>   static int balance_kthread(void *data)
>   {
>   	struct btrfs_fs_info *fs_info = data;
> +	bool paused = false;
>   	int ret = 0;
>   
>   	mutex_lock(&fs_info->balance_mutex);
> @@ -4432,6 +4435,10 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
>   		return 0;
>   	}
>   
> +	spin_lock(&fs_info->super_lock);
> +	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
> +	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> +	spin_unlock(&fs_info->super_lock);
>   	/*
>   	 * A ro->rw remount sequence should continue with the paused balance
>   	 * regardless of who pauses it, system or the user as of now, so set
> @@ -4500,7 +4507,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
>   	 * is in a paused state and must have fs_info::balance_ctl properly
>   	 * set up.
>   	 */
> -	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED))
>   		btrfs_warn(fs_info,
>   	"balance: cannot set exclusive op status, resume manually");
>   
> 

