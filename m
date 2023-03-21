Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED756C2E6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCUKLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUKLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 06:11:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6613DEF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 03:11:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HFeG022638;
        Tue, 21 Mar 2023 10:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LNfqqpdif6t3TL8MjBERqeocuIv5ybLUVMwFU/HSA/4=;
 b=SIXKjEdmhuC97FUyrVW6XpFtesSyVfXTZXEff4gt2g3LoywvqDtg1dcEdYyZaRmiRaI8
 oF9BFMRsp26KHHo/CeDroF42D+txqyz1aX1oXngwY2WxPFIFqTWaLgiDXoOOlJO0BNXS
 Xc2bSmDtyQtmXNsDlvS8Ss9Gd11FHS+uYgQ2pcziChsTRn5qvpX8rWCrhmeKxs/q3hwM
 wcvhoXn6loJOJLF2HmqIJAMtc6W7QKxB35j7MYzBsjZ42W+vohBp/c7JftIwnSrkCUYT
 04Y1eBPHnkplvhN3s7K75HMnFdhIMyhT6JBQMQb78eH2OXIp61C14GYsYOOAefZlthXa lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wgdvnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:11:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9vJ98010476;
        Tue, 21 Mar 2023 10:11:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3peqjnj9a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0xsqpVAJ2ZKt6hQCAttEWfpcTodceUXVagSDkg5SYnDl2ltcMfXJDOF6QB4+9hsoI3sZOEM62rGLpDpdm+5H/xl9guuRGT01FZQ6AIH6Hw+lIxVm9RqyAphSHZLVSu7oKNF/NQcd2E4QNCLY+ngEZ0Ipphd/3SmdSZG29mwOW9j6Z0ZepUObG6OhEy70sUZag3CnNBepEr9CBbWVGWLm7d1S8NFLaH+dqZCIPqhSnimR+AVHhgRfkPwYOGxdO+qfjUgcN9YQhFuNfK5ceQQNQ5bWp5gj2Z1TqCV+4cy7XOWHFHbJmM7izC7JtMGQYSu4HREBhQEfhmq0FoG1lp7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNfqqpdif6t3TL8MjBERqeocuIv5ybLUVMwFU/HSA/4=;
 b=godkrWnhkpnXQeb27cOJvw3QxPR7iT0ZkuqPfvVKdMBgr1P6aARTNunIMBVm0nYUcooWD//PiAxd2J2s5xuzg0doOs0lE9GLR7K0KKt3X9AUJ7x0J3Tw9L4ztZs9KALLiNJ+I7ag7UCowu9NdUEYCZrADu9fs4rxSiVKGzalhtDqrEbO/e/pTYharlnCHNQbfe2QoEXSLXtQm6+WV0x3Zc4/3k2DJkQkXcEtCi/IdLm1TYZAbynymemA41ptxriXv01z00k4VQzbCWURnx2cQyY16Wyt13+9+YInvO2ofqp2TIGBfOfb8CjmVUaDeHAi65QzNL6LLZ0CQsanJRRl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNfqqpdif6t3TL8MjBERqeocuIv5ybLUVMwFU/HSA/4=;
 b=Azoft5ITJ/qYVladw0sSp+JK+yoMq2NofzaX7VR2KP4sSudXZUADV/hpcl9ovOCz2RE0qwHvlkCF6Q+WmfwYHWPx7uc6awDOPXA56XBTT6l8WkKNA1AyYh09UYUHmSEFEcsyy2sJRIuTafVgm1KrnvLBqawtuqIjpDbzNdNY77Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7409.namprd10.prod.outlook.com (2603:10b6:610:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 10:11:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 10:11:09 +0000
Message-ID: <601f517a-2736-0f35-fde7-965de0daf36d@oracle.com>
Date:   Tue, 21 Mar 2023 18:11:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [RFC PATCH] btrfs: remove struct scrub_stx for superblock
 scrubbing
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
 <35929eb4-7467-6cae-3d5d-3f6b239c11a7@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <35929eb4-7467-6cae-3d5d-3f6b239c11a7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a783d8-2fab-4b6d-4b0e-08db29f4971d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCv9dtW0x7R4qVS4nA3oth8Z3ivga+t/KwTCO43m5OXXznlRQX44SghWwykYA1t5P/YP9DjKII5DL9mZetf+30r57DtDkQOqHHMF7MVd4V57DWNBaG63mzp9MgKncXTQb0sk1Zic8MTeBkhnyN9ShlvTYDxBCuklVRA1SbEhkQjV4f5sFSziLzReKZTyJyRPGo3JwozD7PJXwl+5BxnzVK8wkC2KL3AZKrnGSGvLvfJE+jndQNJ3PK8mqViU7TxTFMh66m+Gf4nHMjkxaIH0/YwKnlykjvT0Qnh1+HUt1/NekHNbIcEkRj5oLyXOiKCG/k/c2gQLLVD+Uf72QtqgY2ZoYCkhd1f+HiYxhLKaSyN2AdI0gPxOqYmgrxj2jc+6E4ZABSMWTWGTYkmt4kpn/PPPXQ5MDCDrbd97gkbpBIQpSDIvK0Xq6nsNBzmUVLzw7NeKRbMNakgdY7pqcNUFCmmeEFj3FsvOWiEHpKXJluGWlHF5NwqwKAWF45nO7n9aGJvX9qwn7LaedEU+FME4/cIN4Rt/SdIjIiqgHUDbVVlJGkun+clgX7oA9ujJGsguH3SBtX9UFNGseoEEB5Z6C74ljQpZUauzPWUn+SkRkxD9D0Nnt+vD4zXJlw2AdqU/KRHt2GN7JbOTGjaTktgWg4FYGsMySBuW0hEwu3lC6dsm6h1ISP+w/7jcGpoac6yc15lAZjABpWgSTjw+He2SDqC8HTFvGkCoYYqjODt3izc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(2616005)(8676002)(83380400001)(66556008)(31696002)(2906002)(5660300002)(66946007)(44832011)(41300700001)(86362001)(8936002)(36756003)(66476007)(38100700002)(6486002)(6666004)(31686004)(6506007)(316002)(110136005)(53546011)(186003)(26005)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVXWkoyOUNDTVdyR1Y2ZHNnNXFYSXR6c0JCR1NyYkpTR1piemJZSjZCYjdw?=
 =?utf-8?B?VG1FYzFQb2RjMW5UZXdObUhDcUZLMCt5Rng3UjV4S3I5VTZZblFsNXlHclBY?=
 =?utf-8?B?MVFtVnVLRkRYcG9DNFJJbzEwbWQwMzcwYXlxR0h2SllhKzl1VndUUUNDU0Rx?=
 =?utf-8?B?eERTNnhXVEtLRm1YdC9LVnF0enduaEdaazRLZlZHdzZVLy9HWmJ2QjZvd0p3?=
 =?utf-8?B?ekt2N29KNWdZbEpKTEZiS3IzK2FoaDhMeFpwajFXR24xYnlJZFFoMW9Ma3Fy?=
 =?utf-8?B?NFJ3RWtsQWZSQWpNcHlkN3B5aU5kNDI0bi9OZnc2R0YzUksvNEZZLzhIa01X?=
 =?utf-8?B?OWFGQ2hIRmtNbFVhaU9sRlNQZ1creG1rSEUrb2U1ci9TWE10S0llVEc4WnMw?=
 =?utf-8?B?UG8rSlJtalVvS1lsUEtqTE5vdXZPOHRabnF3NVZFeTNHL1BWcDVFSmJYblFI?=
 =?utf-8?B?QmdpWXNKSG9ZRWRrSW1FU3NRKzdCaFpmQUNWUGJOVnBIcU1zc0lhWUxTWkRC?=
 =?utf-8?B?ZlNlY1J5U3RybEJ6cG9rTUt1MEZuSllKZGI5VG9YOFhhWEFHWnhqK3luakZi?=
 =?utf-8?B?S1NiTXllMHVDT3cxT3Q4OEJvOUl6d21sclkrVmRwWmorZmxQaXlCTVhWWUUr?=
 =?utf-8?B?U3E4WVZDdUM4bW5taGVQY3lEWHZFK1hVWXhmeW45NVpjVnRWK2RBeFROV3BG?=
 =?utf-8?B?L3FnczZuajhxQTVOTXJHazBsblVIbWI0dTI2eURGMmN0K1o1QU0rTlRZVFRP?=
 =?utf-8?B?bkVWaHRRZ0JBZFR6ZFVzcU55Y2xrWVU0aVFVbGoxdWd1eEhYOGRBcVlENzZT?=
 =?utf-8?B?VXJrTDR6dWpWTEszbjlrMW5hUTZTUkl1dXlia3QvVFNld1Z6akpoSmFLMVBY?=
 =?utf-8?B?ZXZjSkRYV094ejBnSjl4a0FjR0JITTA1OE53Z1M5MTF1QlMxTk1zQ2htY1RQ?=
 =?utf-8?B?MWhNUkpSL2dEbFREVU51c29HL2Y0WUFmSzV1YU42aEl6VW5BK3pHbys5WFdY?=
 =?utf-8?B?MDgwOWtVSGEvS1RHckZiVCt5QXRvWmgvZEdjSlVQVGhOSnVuTnN5MkxQaTZ6?=
 =?utf-8?B?T3A3Q2RITGg3YW1Xc2l1cncyc1JwSVhSQTRoSkV5aWNqTFRTNHI4WmRwSU4v?=
 =?utf-8?B?VEtSVGk3VzA5TUhUc0lDS3N5bDhIekYrQjRqZ2pkQ28va2xVOXpwSWFscTdB?=
 =?utf-8?B?UFlrQkNRR1JSTXk0TXNiM1Nsc1YreEhtT21IN3F4UWl2RlZ6UTh4cE1TUTJE?=
 =?utf-8?B?TDRCZ0dCT0N0OC9lemw4Q2ZhdEZXWVpMYVYxU05CRzVmdjg4eE0vWk1nTU1C?=
 =?utf-8?B?emRZWWZ3VS90Slo4ZXBSRmY0bG90NkIzYVdDOXFJR254R3pWeUIyTzlRaWVl?=
 =?utf-8?B?UDBEZEtRMlVFd0M5MWhYWTZzYTRISUw3eEgvVHlPYlNQMVVXRkUzT1BHQzk3?=
 =?utf-8?B?VDFKOG8xUDZTMHRqcjZhc1oyRGFuRVJpNVQ3S3lNZXlrdno0ZmZFRWJtbXRz?=
 =?utf-8?B?RW01ZE5paGZRV1lOc3lkNjZxWEI1U0NtbkFuc2dqZWNKcW1IYTNYYlJKNmtw?=
 =?utf-8?B?cTloTXR2N3UrSlhsSDlEMHBaTU9RdHYxTmpROHpIdm9taWFpajRreVhXbGxM?=
 =?utf-8?B?LzE4TklKWUtwZXVBK2RGQ0REc2lKZUdVTExqdWZsOURLZDlMbXphcmFRT3Ev?=
 =?utf-8?B?UXJkdVJPMkxRNlFuNC9oRnFJTTVPMElGTVRYRjJ3WU9RKy9oY2NRb09OUzF2?=
 =?utf-8?B?MVMvMWJJTnhzUG5Jam9IR2pPdFVoc0paTXJWZDE0WktITUw0djZMeDNnamNp?=
 =?utf-8?B?SVpLakNSUGpVdUJGWTkwM2k3NmpCb2NIbUZpQlJvZ0d3M0F1clR6ZWZsRlN5?=
 =?utf-8?B?SE9OekdvZzgrUk5MakhjVk9jcjYvQVBIZzhNMkJEZFZtTFUrMmMvZ3MwaFVq?=
 =?utf-8?B?S3pRMTdBRG5mYVFIQXllOUJvbW9CdjlGdmx1OHZyUXM5OUMrV2ZuaFJ3R3Y4?=
 =?utf-8?B?K2w1NTZkakw5bndwdkZsM2sxQzVWU1FKTHIyNWxBUlFsZ0hCdUd2MVpvUGNN?=
 =?utf-8?B?ZXdKcHlHQTEwSnNReW9uNWEvQUQrNnZjeDM5c292QU9wNzRXLzd1djdLcVUz?=
 =?utf-8?Q?X/Xe8bXEsI5vu9eTqVlDtS/gs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: btMoSFFc9D7nfqTdiYGuZbI/yQpwGy+q8uERSWbptgYhIO8bKZ5/TzoFWCKXBIQgV2BPFk3LmRlW7gqOKePfyzpi6XFHmjLmj67dWfrqK3xovGLJB8iB3s5NCb5pL20D8GpQR+zFElVKEVjTangYPWolmV1PejnhEUa0IOIThNwDOcRHK6ZbZaJiablFavzz66AFqyh7ndwHM7KMQT0zjVtXxQRQoNUoorICVd21qmiaJ1y6MF/Bx+GxUyNC8Q1gYEIUPJOTs7s2VF6WXEl+mDwec1gqfYfRfL1AYB/3oHWK+c9xOu7QhCp5ArgtUxRgOj7hiO6ZneApNqIqAGI1NICghPfkSnSYQv2dcadSNYONSTDHK91NHWfgINxGxuBbKfm9r2U+TQQ0lVDPAy5nf1Pu+012DidEayszd40GBLffWwgzPD1s2ANOzs9rJftbt+U7tOwzHYaySQk0UvAGBts/5t29bbTNLq/6n/rx+ElifOrrd3Lx+HtswV5saK71ATpE7F5Zdx560zLWiiXAn3a2XorzjihuSQQxRclGCerD7+6+nF2hR3INWc1awhgsw1si1oAaoA4G/9iBWiresSRf8kf5HiDSaynObhXB3O4UY6jkF5045YRgT82gsxHfkZObT+UOJNx7HuAEIjhgmPlao354RK8qRWxjsRMyabGq8rZqZzf2muUzTvSslrBS9QO9kHmDFZCQEpLbyIFyigMmq0/DOD0soWewBRrijsB5jThv1gEMnKR607rv+f3bstLjaEDSM9DKdH6zzAsvHIwa6yym5xND5c46W89L68Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a783d8-2fab-4b6d-4b0e-08db29f4971d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 10:11:09.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXtJNYdyPhXQSXaZPt9n+g/z6ihn8DPBRpyCx4tdB/r+0GH2rZO1svORALVRxoAsgKQbjXR2TcJQe5DIn9RKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_07,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210079
X-Proofpoint-ORIG-GUID: AJHeBqTfdwKRhYmo-7ZQ-u_uloHwBbFS
X-Proofpoint-GUID: AJHeBqTfdwKRhYmo-7ZQ-u_uloHwBbFS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/21/23 15:26, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 13:23, Anand Jain wrote:
>> Following the patchset that implements reader-friendly scrub code
>> made the struct scrub_stx is no longer required for scrubbing 
>> superblocks.
>>
>>    btrfs: scrub: use a more reader friendly code to implement 
>> scrub_simple_mirror()
>>
>> Therefore, scrub_ctx does not need to be passed as a parameter,
>> (unless there are other plans for it).
>>
>> This patch cleans up the code and is built on top of the above patchset.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Looks good, if you're fine I can fold this into the offending patch in 
> the next update.
> 

IMO, this patch is a cleanup rather than a bug fix, so there
isn't offending patch. If it is folded to the patch 1/12, it
may be too many objectives in one patch.

Nonetheless, I have no objections if you still decide to fold it.

Thanks, Anand


> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/scrub.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index beccf763ae64..bc87277559d3 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -4909,12 +4909,12 @@ int scrub_enumerate_chunks(struct scrub_ctx 
>> *sctx,
>>       return ret;
>>   }
>> -static int scrub_one_super(struct scrub_ctx *sctx, struct 
>> btrfs_device *dev,
>> -               struct page *page, u64 physical, u64 generation)
>> +static int scrub_one_super(struct btrfs_device *dev, struct page *page,
>> +               u64 physical, u64 generation)
>>   {
>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>>       struct bio_vec bvec;
>>       struct bio bio;
>> +    struct btrfs_fs_info *fs_info = dev->fs_info;
>>       struct btrfs_super_block *sb = page_address(page);
>>       int ret;
>> @@ -4945,15 +4945,14 @@ static int scrub_one_super(struct scrub_ctx 
>> *sctx, struct btrfs_device *dev,
>>       return ret;
>>   }
>> -static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>> -                       struct btrfs_device *scrub_dev)
>> +static noinline_for_stack int scrub_supers(struct btrfs_device 
>> *scrub_dev)
>>   {
>>       int    i;
>>       u64    bytenr;
>>       u64    gen;
>>       int    ret = 0;
>>       struct page *page;
>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>> +    struct btrfs_fs_info *fs_info = scrub_dev->fs_info;
>>       if (BTRFS_FS_ERROR(fs_info))
>>           return -EROFS;
>> @@ -4976,7 +4975,7 @@ static noinline_for_stack int 
>> scrub_supers(struct scrub_ctx *sctx,
>>           if (!btrfs_check_super_location(scrub_dev, bytenr))
>>               continue;
>> -        ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>> +        ret = scrub_one_super(scrub_dev, page, bytenr, gen);
>>           if (ret)
>>               break;
>>       }
>> @@ -5172,7 +5171,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info 
>> *fs_info, u64 devid, u64 start,
>>            * kick off writing super in log tree sync.
>>            */
>>           mutex_lock(&fs_info->fs_devices->device_list_mutex);
>> -        ret = scrub_supers(sctx, dev);
>> +        ret = scrub_supers(dev);
>>           mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>           spin_lock(&sctx->stat_lock);

