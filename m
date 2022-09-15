Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912D5B9429
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIOGLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOGLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 02:11:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75A923ED
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 23:11:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5WPOd021818;
        Thu, 15 Sep 2022 06:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KR1qb0rCFq9cYdGp0PcndN2Iuy79U1PEDUPu00SlqmU=;
 b=jeb9HBjhpGq+vM1zLV4NagYImHCDdZ8lmWSZsKs5GLdYbZehIhJPzE9k+yrvqBtHWUaA
 FxBOWBloWOL4+k6OgkdZ1q+Vf1FSI3bhEooPugd373TV1r6QEfWaPA++l1xdwU0zyeiZ
 5Uo2TjFlF9Hk59PaoLTR8+TduIuO8mvjOCtrQOtfjwJP9NLv+SobyhZpg42+qfiksLBq
 TYLT2eXEHwuU7bLhxJf28Et4agF/4p50k3h/KGsb6edomybjHOA24wyHNrlHmQamB62F
 +xBGendAPIW4Duux9k3UKGj0ZQ7/WiJeyltTGNeJMXz55YC6DY4PlKh5JfgcNboqD5e2 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypc6sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:11:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F3q6wq019482;
        Thu, 15 Sep 2022 06:11:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym5cr6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLwww3zrRlgGyR4ybZ4KIjsedpyF1M8mcM/yj+8XtdWlKZ/kEy3fdfTm+LkYf9TwspTgKq8fhcjwy+6WC3b8oIqdfhy/pjdCKc7YtHsMHH8lf2ipaLuukwt6lYIUe2Gvn35KixW6DpB+FzW3XVp9BdP1LXzKOUaVRFTyf2JzqjtSZwoSjlweuztIGPtNWRue091A5XXnGBoKkgNCZdfIeTUvliU9PuhTb81NxheZJh+jFEQMjcUSDTPxjjzzKEWdw69+pMuiX/H2w0vIY9pB+hWB1JFSB/nGNt75M1N7zX8LIWlNF1w2A7jVS6oO3yWbz/dZwDRm8fulzeGNANkEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR1qb0rCFq9cYdGp0PcndN2Iuy79U1PEDUPu00SlqmU=;
 b=dBENqr4haPhrFZdgfNL96T/nrv5C7pfimj9tQPffgVBHwrNUB9HBB6D/3ioZLIVHpSLrynCj4X/PgusZJj9MjEDKaNAfyQtp6ouKm8gvsc0ciutn4zQbRW4iOFnWuS8izjGw9PNJMzFxndeixCXSMX7TOxQJGJx2U+xK06ahQYS76YhIA2MnXn7vITTSopnc2xQlGTakhM2WgnA2KV+f+U8xQVrYUM2eP4V1NEPUIl4NMPF2rOa/n4ZJpbKxeotRj+ueC9opzP7IPit1d1Aj2RzWx/gee61m35R7iOkmIqmUW+dP53mqR+ueu03cCXBObGzPzzDlAxk+NOMk1w6XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR1qb0rCFq9cYdGp0PcndN2Iuy79U1PEDUPu00SlqmU=;
 b=Eh5mgaLEBMWaECzim1QdaHYkKgwqiJOcDulXVMLH+YcAXb3MJZbqqutfxwqFV58/u2ysD62ENYLY0ve82E0NdX7YTdt53jM3lg7eQG7cAIKj4mDhO5VsQ9CcYQtYNnPbnnpWl42yCkcW+s2z3QW3j/Jz+cdRyhOF76mHqWHO60s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 06:11:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:11:13 +0000
Message-ID: <05d5c8fb-f213-85fa-c1de-8827236987f0@oracle.com>
Date:   Thu, 15 Sep 2022 14:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 03/15] btrfs: move btrfs_init_async_reclaim_work prototype
 to space-info.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <57fcc1acc5720b8edf4b3d6bc2df224a8e196d4d.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <57fcc1acc5720b8edf4b3d6bc2df224a8e196d4d.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d18b4e-b6cf-4dfb-85a2-08da96e11712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2IQ1n9WTXXl+mOAU5hBu1WWUBiuiTykvoaYA1PacwexFZtmJNKiOwk/tbIMAYTs/x3GrxU0nZD+vK+y+SZhK85my8+8ORWKajbQR2ObcWU0/q0Zj22hcbTGIhaccAWkgsvbf7IC6AtENbnlRmXzk8Ds99zM7F8ZA4AAlJhyKKVYzQKm08xnixHImZkaqWLJSQ78PC4kiUTHzBgqJETM5bxBINtR36/bQKmJQ3TKmK6/9L6FJ1JHe7yegsn5bnHUtl+nCqydooHjYQs/g/HWqAw6mJWPfjX5dQI2ixCINLXbS1CF8bKEFmkva2vduptER1R4hWonJz131t6nWcOttEZ2shFPkTFmRw40MAdBkCMJLFFUWYo3vkjesjhuL9x9mzAQPLwB6QOfEWAZGYOlGGYt3bkG+l/geKdIO2w7H80Tlim1/3kpSzKHzKOLGB4IoaO4NElD393V86s4WY6UqUGTwwg2OCG+FwaS9I9s3vzmQHillz9u/mrBnreE8l7mq9anjOD6FawqV2k4Yuko4qeAR90EvPixsjciDKKV1RkpQGkybeUJS1pjnaGoE4LR4PmiiRhF2yEMbqreovPVOF5hE/wJwr5PSxrSFSkFWnWM2gV7cydEgZbBscVKgmCDpzhWxd0dqvWwxEewUSJ87ulnI1/ktl/1CieZSBbq2h7fnXiZBtOjHvuaRLUfv7Uaj7IjwL8VjNy+de/GawgZw4w91J3C/u+uWxPPueVghJc3NTR5w+hiMVbMgyyaKwfLgSWU9S4SP3faNVlmvbNt1TWslLe8urzlKp5F+OWo1q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(186003)(41300700001)(8936002)(44832011)(2616005)(5660300002)(478600001)(6486002)(316002)(86362001)(31696002)(558084003)(66556008)(66946007)(6666004)(8676002)(6512007)(66476007)(6506007)(53546011)(31686004)(38100700002)(2906002)(36756003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNYZzdTaHhqdHVnWkkwTHRSUHhLM2JDQkN3ak16azZKUGRvUDdsMFhuamVU?=
 =?utf-8?B?ZlgyZE1wTCt3N0R4by9xSjhSSjhQOWIvamNCTFBiMk1xanZQSDJPZDc4Z3o0?=
 =?utf-8?B?bHJVV0NCcEQ2b0ZTVmM3K0ZGaW5zZ2pPVmRTRHdZZXp5eEIvYlhNMHJDUkV1?=
 =?utf-8?B?ZTNocGhoc3dpRVgyRlFHcTVXL0NYUHl3bGJVQ3hTdjhPWHkxT2xxb05JY0ZY?=
 =?utf-8?B?UGdVZktPWG9aeUFRZFNaVkQ5dWNTRVJrQmlPbTJRN1dWNXFKOFRzTzFyT3d1?=
 =?utf-8?B?a0pjeVlWWGg2VTg4SjJsTTNVMjhEeUt2cmVNdzNxc1lmaGNhRWx6UXpuTjlM?=
 =?utf-8?B?ZWtIbVZzbFpSZ21TMGlFY2pxVnZ2YTFrUVJuZk44ZmZDNXRLSjliaHgxRWZj?=
 =?utf-8?B?amJzSllFYXdzRW41bkJFZ3h4cUZxTG1MK0U2Tk8yWjRLUnhSdmlIRVoxSzN2?=
 =?utf-8?B?clhjZHhUbDlWS0NrQkdqcG0wYnByWkowN2ZIRzRzb2lwaVBiNXBaYmlLZFBO?=
 =?utf-8?B?SFhwU2pGZGlsS29QcTE0am80S1dtbW5BNG5sNGwxdjd1V3hJclFjQWI4UDk5?=
 =?utf-8?B?eCtkWjJrcDJPa1pETGRvYmNOTHNTWkFrWEN4VDlRRWVhZWpkYm5sY0NFZ2xK?=
 =?utf-8?B?Y0VDZUNTL28vZGpBZGIyZHRtWFRLbDdNWlNZamJUazhPWnFncG1lMnc4eVNK?=
 =?utf-8?B?SW5uS3kvTVVVT25od1oxcDN4L2dTNzM2cXJvNlhadEpuSjFnUG41emYxZk45?=
 =?utf-8?B?ekVQMVZ2NGY1K1kycEh2SVg2RFZROXQ4OXpYNWdvM3Jna3hjZUV3KzJwS0t1?=
 =?utf-8?B?MnJIUmFzRjFzV05nUGpINUI4NHBNYTI5dUJ5RHJkMWtqelZLODZCNVh2cUwx?=
 =?utf-8?B?bDNjbkhIVk14VThYL0JuZGQzNFRpLzFWT1ljVW9WVzQ0UU84ZUl1VEQxWlJY?=
 =?utf-8?B?UGZKSjYxYW5ObThYajhKR2hxS0gxVWJPZ3JjOUpndkdNT1lzR2RkaDBjRUhB?=
 =?utf-8?B?KzdvZEJ1YUptZ2c4YWxVRkg3TmFrckc5SkhzbjVoZlJ3WUIxaXFVNzlSMFlW?=
 =?utf-8?B?MjlJd1NBV3YzOThueFhWNldiWGljalZnT3ZjRDNSaGExQXIwQzVGajJUN1lP?=
 =?utf-8?B?TnozVVI4YnFIM2JtZ0hIL0hqSEN3eVpBRWZpMWYwejA0YXY3RjdINFZITzVJ?=
 =?utf-8?B?eDV4aHIzRXV6WkphVmVsZTg0Mlp5VTUxTk56UjJlQ1BEWGFXNVhWdzZwbERE?=
 =?utf-8?B?d3UxTzkvOGdQM01OQVNLQUk5T1Y0RE1uQzl1aVNUUjZuamRUc1lnNkpTVVlW?=
 =?utf-8?B?OTFma3hsckhiMXE4WGMyZ01oS3VrS3RjRVpwdFJKL2JKSncyREk3QjRxSFUy?=
 =?utf-8?B?MjBSelpOZHAxZ094VzlIOStYYjBzTGxVQk5RWjRUSVdqWE5ZcWVxbmMrSnNl?=
 =?utf-8?B?dWZBT0NaNkZUQ3QxRjczVXU5RUMzcDVibWVPa3k3aWljYjV3czBnNVFMWjVU?=
 =?utf-8?B?aUN1TEtrTCtxTkZTTnpOT1NTdkJwYXgzN0VLSW1LWVFiTHZzWHdSd08vdTdK?=
 =?utf-8?B?em1idnBydkhHVlcvOTB3emtqM0U3TllHRFNtdzllZHhLRlo3NUFhNHJIbWdu?=
 =?utf-8?B?STg2MU9GZ204QnFNT28wejg0cmIxbDRUc3U4Z2N2Z0pnbnFYNGZPWXhuOUhx?=
 =?utf-8?B?Y2ptaDc4T1F2YS9XM3pUQVF5b1V1OWpybFhzZGVzbjFzaTdnS2JTRDY3ODV5?=
 =?utf-8?B?dVZsRS9yRmxVZ1RHb1NWTUxOS2NjSjFYekwvbUxtLzJOSmpjdjZkbHlhenNy?=
 =?utf-8?B?QW94NlV1ejZRZVBqalFjTFpKT1JuOVptNkxXY1N5TWt2UW9Qclc4RDhDdEdU?=
 =?utf-8?B?TUwrSXZwNk82WXJQTXZsbDJoUm5haVRPNUFaV1JsQmsrZ240bXRoOFU5djlh?=
 =?utf-8?B?WTFBVWVrZk9VNmJYV3RjQTJjT1M1bGlJYmZDYlpEeDVCVGJ0NzhmK3BLU2ZQ?=
 =?utf-8?B?MjhGUzRFUEFxM0tmT2xaUldtd2FvN2RsUXFXS0kvNGlreitQRXU5aXJLY2hy?=
 =?utf-8?B?UnJqSU55R1lxS2NCd2liQlk4cUNhWWE2eDBmVzUxekVzM1BiOFR6S2NmWHBt?=
 =?utf-8?Q?qa+Zq7UQM0zg1GbQbI73rFxRE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d18b4e-b6cf-4dfb-85a2-08da96e11712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:11:12.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q16/G7+oMee164alnYgBDBEMJUvaKkm7WN7Of5XSPv2sXh85GGeHnspR1hLcWJswH4aBaXtA5W1hc9wdanK3WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150032
X-Proofpoint-ORIG-GUID: lvWpSnlSHoTmAn4sAs63nhBLccdLXyZG
X-Proofpoint-GUID: lvWpSnlSHoTmAn4sAs63nhBLccdLXyZG
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> The code for this helper is in space-info.c, move the prototype to
> space-info.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
