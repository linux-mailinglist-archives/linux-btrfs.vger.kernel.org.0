Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFA5B9B84
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIONBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIONBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:01:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F19C230
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:01:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FCRmjh008401;
        Thu, 15 Sep 2022 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PGm/n4ij1l+0zFsvOqAP3MH7UgGZpMcVowck0q4y+/s=;
 b=aU9VoL5kKJomvf4UCDsMxkkiV0Gu1sZCxzvcXP++8u9/tfwFrun8Mpyl0lvsKRN5lM2F
 sb4hYkWNaMmKnXtK4oQMOAnSSQJPImM9EakpNDT+MPg01gJwUdqsQZN7ztPTdKBKz6su
 acqsRnqFnbJJy0YQR7wNhzuymZ4iGkfQ6238M2pf0Ej6XCh+rxcLnAxB1oni87DybyTE
 lOb3IHQzWx0gIJaSEJXKkChVFz43K/ouxM4A87kadPSM3vLuQkWzc3vyzDOsZvzwMUJ+
 L0PDuUem4j/ToiUuzeYbt/BvcMhpPaW23A0Y0h1oOrP/YAZBQTP7+aApu8Rc85q7aiMM Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypdamw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 13:01:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBUTdB037949;
        Thu, 15 Sep 2022 13:01:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym5wyx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 13:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIyG2/hhXYzyrQkoC+m35yEUY4TgCL27+nSCyTtc7raW8HGsHM7K3mKVS1nmS4hwZRPm/EBQ8Yu5bMgDrHRfJyJPWlcbg700IWStpioMFGun331CU4Yt4ciFooukpW07LITwElb2BBFavv0LcUSahbk+nTq8F2wx+pXAtNZUPBPFLGgoJAy3LSMgeTWtcg32DnPkQ/lsfV46sYGiov3QuHbXaaxAeSOnb6L2J8JZtdOz6d6nN7mHTkX6YsH9gvPlEUB8n2d2ofJ6XB6gHBqL+S91oC79WDTuEp74Doc8EJqOPnUeWfUsq3u6Vwuk5EeKLocGsGGu2NxdWNto+pPVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGm/n4ij1l+0zFsvOqAP3MH7UgGZpMcVowck0q4y+/s=;
 b=dUxRK8BHpccYJArP86vKxKYlp1emh5sz5AP1snIQ62v99vWx3BTvWZgPz4XGDolbG9B1zsXn5AyQspjc1NG9VpQtz/yo34S+pLGeYrdPZvCxT2/+fbcroutc9vzZ9p3lcZsJNBVgP0KisCskBu6wvoe76HV0iz/kF40xZF/Y1ytUfhBUQpOaxAPVmEuc21ndwISCoNNPgxluPtNZ1f86sgSffIr0ISNi+4wzRpHET6bsInG+yTDQUHCrVvSBcT0XXzSRU7VX81kpCYVksi4iEo8HQ3RQAA8yUVIJMqu7EmLBVIGFLXea6z9bQaZWBuJgqqo5Jp0PsREYOG/4pcQfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGm/n4ij1l+0zFsvOqAP3MH7UgGZpMcVowck0q4y+/s=;
 b=J09+V7lbq6w30X7mQESU99oISTtljFJseUPEmkqb9eFgk6MrgKHbjMNiAxJbcfETe2zlNZx/egZvtP8M7KZ2+1/47MkcSslzuOtW9uCqAgjGF9Q5Lxxm6vodKC05AT1+UFSCfuKWdzK0mV1K5nRvXC6LSKcP6UWLihFGFozTonE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6346.namprd10.prod.outlook.com (2603:10b6:303:1ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 13:01:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:01:37 +0000
Message-ID: <894003f9-5813-9bfe-5b99-7fc500ecf909@oracle.com>
Date:   Thu, 15 Sep 2022 21:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 14/15] btrfs: use a runtime flag to indicate an inode is a
 free space inode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <d8e32fa383bfa555cf49c9b184c45699bdc84ea3.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d8e32fa383bfa555cf49c9b184c45699bdc84ea3.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 253ffe68-4601-4402-d54e-08da971a6c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LitfUG8WMxljNSjIQi6yWOHiKLNgSbD8J+j7IopV0uxcDKeDLlK3h05erBsdMT23Wr5NSOBmWLjRx5AF/4gV7732kZvRBY+EH+OlzuPvM7iXnXbBLjs7BR83uhSkz2XFvJbqJinEP/OXzaX5Fi9/+yJzkV12ajS7o8kgp5rxF2aboe3CtZoCuA8uNYynUWMb56ZI/9Az9txARAgndQ7mzI3lPjieZTd0uO4nnQF6GLvWFDFhK9zXtKY8FAYLM+sc9/CqwjjS5JsQYhUGYfql0ioEd5dyQV/+8hiLuKt1et+M9ZCYDIlRxxEeEc0cxIZjuHfUwDkt4AwcTjH6JDElehNoxaYR6g3sK8FEMF3PPmTkerIIz4qIhXdmuKH+5Tq+XI2XUsR9Jj8+uYZk/EeRVxIpmUaI5zp494+Iyl7uTrsBxrn9BmZsS7fVEqD8rlf0FeT6JVNn6mQWVHqrbeybH5NhUtVzQJMgxyhgTWlVnbdOgo/b1c0ZSl3xV+T1KaJjSCQsBjO1S6GUDeDpMVM55e/XjFF0eeh6JUJSqogrnStQYes23amUWXEZplYp3MLsTiL6sFaoNtQ5K/hEHcYOqKIVKZv08l5Vq9qij1fsW0FUXq8C6u9SWkVGmA9G8X+kit9Y6AQ08YWwcy+VEA3Qles6Xo3u1lNOp3lByyoeKJvIg6k1TODhnRZZkOsLCEahaN2VaW58JYAYtqBLcAX96j04d0+giCSJDlTLE7NbHDvIwyDuca94Z+REdOMzhN9MpRKaUKCSDcpLl5ntCcv9h5jIvLKCEGqlL4N+Fv13y0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(31686004)(44832011)(4744005)(2906002)(36756003)(316002)(6486002)(66556008)(66476007)(38100700002)(8676002)(86362001)(5660300002)(31696002)(66946007)(8936002)(478600001)(26005)(2616005)(186003)(6512007)(41300700001)(6506007)(6666004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGV2bDRPWFBzRk91aG1Xc2s4aXpkM0NOSjA0REp2OCt6ZUtLV2daQ0w5ZStJ?=
 =?utf-8?B?amd1dVVQbVNaR0JQTWNaMmZoeXZmcTBrcExsZjJid0FFdFRWVUc4bGtZTC9r?=
 =?utf-8?B?a0xEOTVHVEJuWDk0MUtlRWdxSU1MdW1wMUpFVFRHUUhZRmFSRWJBTVZoRVNN?=
 =?utf-8?B?MWdUWlg3ZHZpOEVBOUxjTTRWdkJma3h0OWlhRGdFYUpMdzRxQkJMUGRzZmdD?=
 =?utf-8?B?TlEzM2Z3TW9MeFNITTBtZkNFMVVrbSt5NWVTQmFjM1gycjZBeFlJbzNyVWdE?=
 =?utf-8?B?RVVJdmJ0N2R6dGEwbXN4TEY3RXFoVUtMQVZhTjVGNmJ0dmFaUi9qVmpTbkx5?=
 =?utf-8?B?RXhObHAySWpLOUN0Umx3am55Z1M1TDNtZDI5bGowUndIaFBsODQvUXAyTzFP?=
 =?utf-8?B?NTFPdFBkY1NZeXdhMkxXNUUxWUJqN3FoSmU3aFAvUXVTeGxRbDN5cGhLOUk0?=
 =?utf-8?B?dzA0ZXZtckp0R0pDZnRjcWNSQkJ0cjUybmsyTVkxMFZMZ2ZUYlFmZjROYnpv?=
 =?utf-8?B?eVdMTlp6cWV3VEt2MHVpZGNtSkxtQ3pZWDZ6R2FJcXRhanlmYTRZanloaDVZ?=
 =?utf-8?B?R1lIT0UyYzJZOXN6QURrNUNGcjd2eURXdWFCZGdJTjZuR3V3Vmo4eG10QzZI?=
 =?utf-8?B?MVROUzYvSnllR3BHQTN2dUJMN2JUcU4zMDNtZHVCMHppWWFZb0x4ZnMwWnV1?=
 =?utf-8?B?Yndqb1FKeCtkU3IzcktRaVpSOFpkeE5xUXBjWllSSTFwYzVQVVJKYnpwYWhZ?=
 =?utf-8?B?RERzNEV3KzhhblpwZDFITGpVLzAxQ1lETzhMcjQ0UVUxTUxqVGVOT1pObzZ0?=
 =?utf-8?B?TFpoZDIzWmdzU0NSZTdteTdiRU9uTDM0Um1BWHpSQWREaExwNDJUTUJzTXZI?=
 =?utf-8?B?cGl3VFpOUVVoZjhFcnVCN1A1amQyQjFhVS94WGlOaHdyK0c0NXhLN01CYnJi?=
 =?utf-8?B?dTk3WVU2ZG9xZGdFb0dnWXppbjhLUGNDRWdLa1YzVkhnZTkzZnEwaTVwMVZj?=
 =?utf-8?B?VVduM2pvS1Q1a003V0pxZWZLWDhnUjhOdG5yaVMwcWY0Nm1KcVRBWnJac0dT?=
 =?utf-8?B?UmU2Ym1iSTBtVnRpbDB3ampvYys3UlJzeEFGbjhIcFdPZElDbW1OalBUbXBs?=
 =?utf-8?B?L0JJRHhtNE1kMHhsQzFYMTVteHRUWUc0N29RUUtQVndKekdSWC9ZMFVGdERr?=
 =?utf-8?B?Zzg1U2MrT2ZxelBaQmRUS1p6ODBiVnUrckcwazc4MEx3L0hWWEtPcHNUdnVt?=
 =?utf-8?B?SXNaNEZBQWtPQjRZc0dhdzBqR0s5SU1ER2JFVkJUd2diTThYQ1k3TU41K0g0?=
 =?utf-8?B?VklkTDE0OHRlT0JDdDAyS3hvL2NrNVdVZUtQWmdTZXR4bTBESlZpWXNRWlVk?=
 =?utf-8?B?YSt0L2M4aHNnK0EzcWZXakJad0pjM1pIQkttZm84S2FobWtSa3BJaGd3eEVw?=
 =?utf-8?B?NVJ5eGljNDFSSEtvR0l5d3ZncEVaTzVsZEJxMXBFMzNmZno0SFhzM2dGd3Nh?=
 =?utf-8?B?L2RDZEliWTZ1dmR4TzNCcUw4VWlqRUVPZjBGaXR1U2ZIYnNlUmJhR2phRC8w?=
 =?utf-8?B?eGhNZks2OXhsbmpUdWtLRS9KMXg3b1IyaE9PVmZoSVVWV2lkbEhxT1U0NG5O?=
 =?utf-8?B?emY0clJHN0VpYTlCYWhlblpycW1KUGVia3dvRFdTS0kzdEkyS1hlMmNHbFJL?=
 =?utf-8?B?Ym9pZXhnNWZLb0J0L2R1TnNuck5ZTUZKd3FiaEdyTmdSdUtDUzAwOUNwZkVk?=
 =?utf-8?B?QVgzdDVkNTY0aVFYRHk0S3ozeE94SUd0K29yVzV3S1ZNb3JtdUZZS2Y3R2xh?=
 =?utf-8?B?aFNZMTc3NVlvZExiME4xa1dSUUFVdDBhSnBMblExMlZPeFl1cGZHQ3V3WUVD?=
 =?utf-8?B?elIwVURqZkRic0J5RHdtR2dQMkxMa09SbDVsTm9Ka040MzFyRHBBejRMKzRr?=
 =?utf-8?B?eVJvNXhwYnJCSzFMSThqMktRWGNOZktyclg3OGRYVXJHRVU4QTI1OWQwZHNy?=
 =?utf-8?B?b0FySEtaZVlZQ0NjLzJTNWFaNDU0KzVGc0dSYSs5QXQzUFRhbjdxUjBERFlq?=
 =?utf-8?B?QjdGTk9hRGQ2VGpERWt4cFZNSjJlZ2Z1UTB0U09wd0ZOeDR6QzIxN3BhaUJa?=
 =?utf-8?B?cU5LM05seHE1alluV2o5K1J4WXV1TGVFL0ZicWdXcUk1S3Q2bmR4eVZPVExS?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ffe68-4601-4402-d54e-08da971a6c70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 13:01:37.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBEJX2paiopOKFZArx3F3fkWa+tnss/x3hlyhBz1ZkWpOxNjVkCLztG3+Ohk5GOUIxf65JiH8k+lj3H38LHQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150073
X-Proofpoint-ORIG-GUID: g6Eu9pNpxN2XvcK4QLZDRpgCx999XNhL
X-Proofpoint-GUID: g6Eu9pNpxN2XvcK4QLZDRpgCx999XNhL
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> We always check the root of an inode as well as it's inode number to
> determine if it's a free space inode.  This is problematic as the helper
> is in a header file where it doesn't have the fs_info definition.  To
> avoid this and make the check a little cleaner simply add a flag to the
> runtime_flags to indicate that the inode is a free space inode, set that
> when we create the inode, and then change the helper to check for this
> flag.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
