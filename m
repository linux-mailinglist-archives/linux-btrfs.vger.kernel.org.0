Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986ED6C695C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCWNTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 09:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCWNTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 09:19:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CCC659
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 06:19:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCxAGE009921;
        Thu, 23 Mar 2023 13:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7sfqvGmtLiMlxvjQ2I8D+TwdRkcdjraG5YuKjTOddDY=;
 b=Ap4pGA0j9KhlrAm/kqRQtpYvQZKPCrbjv44JvYJEEF7HbP8xduCiZ08z/CSl6xEgeMSK
 9oNuEE15Qhu5edSEI3JZxTd3iZWcQ+awEi2BjzYGmAsGzzRjbNG8l93M85++wkuV0mtO
 ADEH8Dhmzzy60f+X9ahctOslmJnRrvx8kS6hbeEMjGRh44YfeDCRcvtba1TFp6uUJavm
 oGK0W5hztdA3x5eWJyQ0jBrro9oZVuwCIM79TLZjjFJb2r32aiSJCzGD3pfTJhPR7pmZ
 C80FOg03OpvYZlQDcwQpSi1aaMKPSGtv5D5v1BF+tOSOyxUl8yvuFdD/M9IdOSglCmaa qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b3m84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 13:18:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ND3lgS022012;
        Thu, 23 Mar 2023 13:18:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgqav92wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 13:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVA4w7E/Ef9mNjlaHnxkOrhs8UoTZ66BZ2TId59V9ObPwCJF6shGWjv1CR/TOPFli+URnORAKFtKM7A0YmgP7Xjfpwl+4XBqMJojYAb7LWC+ttYFGuK/m/diYIfwXTlyqS8B58L+LFNLK+nzgU4f4OzmRbpS6d3Vk4pkiTi6/+WAEMc1yYs6gvACxO5saGXYl42cZhqEkeSCE0wMWSorieLwmmWxzLaDetaHw45EvF5wSx/opg5r8cD3FiHsBsllA8uTgrgrgQnKOLQ1TtO12miu2GQeavpSwEKGvZqGLV/3wxRti/DKIZGAmhfS6XhIAwKFrf2dbGbWj69buMOMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sfqvGmtLiMlxvjQ2I8D+TwdRkcdjraG5YuKjTOddDY=;
 b=Bsv+hAraMqqmdM8hq6D/G5uhoObiEn8XWAXeRXH9VCOKc1UdI9S9dKAC4ULPnqE5qEtBASeYGuJMqPloB07Rmvn+UxX7S5gLFvvnrc+8Q3fH1njElZlBMxSL2ho/KkN+ylSr0RvnK0AeKlj7bfJakaMu+ERJJyoxMNzdYt6yijtn2P8fHuBTVap1FjlXj+0xgiI16EldoWZo/1wtx/5Sqsw9vFSLtmgviu2IFvTN23q1IcQmuLaLxd2tlk0VmaML1sFfoBixFKWH2KoyLBZDjiD8hOl15b+tdACLo7r6dMzX5oHWaMJVo4ZfedzZdhsUL4OVvUBjrbrqFYIE8LMxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sfqvGmtLiMlxvjQ2I8D+TwdRkcdjraG5YuKjTOddDY=;
 b=R+uLlE8GNnJ02TUDtoDgghqyt/TUl0MSdx0Mq0gChjB7acT2qhTelelh/kU3Pr6GrsvsbLXjHKCbZR+7UKbzVuPQu2oRw+zFFT35BCCIRkq4MqbluF1Xf4x1eMLJGwl8loeWQWvQgG8rZKRglQOrwo+GUVZxScijsFoqJhrEBPk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 13:14:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 13:14:31 +0000
Message-ID: <cbac9a8b-7db4-dc54-1f1d-4dc48e5dfcc9@oracle.com>
Date:   Thu, 23 Mar 2023 21:14:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix mkfs/mount/check failures due to race with
 systemd-udevd scan
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
References: <998486a6a1bddf36c3d3dc92df08eaa1b3a6ee7f.1679557827.git.anand.jain@oracle.com>
 <20230323195710.433E.409509F4@e16-tech.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230323195710.433E.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:404:a6::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 937f4013-03f6-4073-ebf9-08db2ba0899e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0VfSRkw7N35GviBkOqus4nCUWHfMftlJJ2bQnQh5lyisMP8wORYYACuCMVdomfuIrKVzmEPbmWHxii9Fr3vnlNj2DQrjKcolCiL6HD3TCxlpOiwV7VDz1Bb0VnYqawkeXJu572cFKRwN36/3v1xnVg3UmR21RbQ1cV9uHlXHYllKhNVPpY/dIDRcfK7ys5rpPdy3g+Zy2y7dxHMCzRjtf7Ckg8i+gwU4g8l8mYawT8BOsPTjp2ceNotJ/2SQ+bzLVTQTtTKoIkoY3ZB6XoQxWqteLp13Ahjt6eh9EctgILWUaAj5PO/iHYKz6O9Pqi7OK36y9kHkQ4d+QpSaSnuJc2X7eP9dov/X+a/FrfQ3KRDpSnEcG/VQlLcYFHze7UrNg210ws0Sc5b7YsyuLG3sKVMAhT+qTxdK9prUx8ws7KwCx5Qil+dfiB4U87iFlPKzDKAN1hV+CintGPbC7TCE6Wpxov3jSELLAx1fF0o62QZSfc/Vv4s0J3umVUaqLD6RKj2EVZgPdYLIvLYliOv6OW4rG0dswDM/Akjki2BjV9ub1h8OiuQsWTj1GKaR7MLe/4HXu43J1mxT2R4FU9LJaXFnpIRL3+vecl/WdIG/kQcyZEJOCqVREwBT/h9BlZZ+niRfYbClyUKAQSlwlmop83L9TkNcYCP3b1rMVfuS7owF8HrepJ+0sAMg7bnxJdd5hegv63ZFQefSaf8grKi58So8PrACwSsElF5QqErQzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(8676002)(31686004)(36756003)(2906002)(5660300002)(8936002)(41300700001)(6506007)(6512007)(83380400001)(6666004)(53546011)(38100700002)(54906003)(86362001)(31696002)(44832011)(6486002)(966005)(478600001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRLMXE4Zk96Tk1qUlFqbXYvdE5mdStlZ2JKZmhGQUlnb1VwQXlDK0hQZnNK?=
 =?utf-8?B?akxBSDNCeHRaYi9VWkplUUV3cEZmSU4xN2Yxa0pRTTZuMDlsMmlhMGI1b2g3?=
 =?utf-8?B?Q2Nob2JMYWdySWgxTG9wQTcvWWpmOVZBQ1psMWp3Q0d0QnZMVkpRM2FFWTJJ?=
 =?utf-8?B?OXI4dkFKb0xiandidkhDcTNBUXZYMFFLYWcydFVVcE41d2dvdmhSTlQyQzRj?=
 =?utf-8?B?WHF0TWR1bDZrV0dhVnBMVkY5aExUN0tKRy9nMjdqUUZhbkZjQjhoNjM4U0Iw?=
 =?utf-8?B?Wjd0a0xwUUxoZHhoS2FwTFIxcndmMGpjWkdlME9YemhtUGErY3kydVpkTmlq?=
 =?utf-8?B?Um5ZNVhJRW5rS3dKS3p3bzZ0NlV1QmVOZllWdWpqZUpLOWFqWmwzdFBJY0VK?=
 =?utf-8?B?U05zWnJXUEhZZnNnWUE0UzE4VlpDb1JCRitzbmljZDd2UlpuWTBZVG4rdU1S?=
 =?utf-8?B?cUprc1lkNldPOWlYYmRMNE92b2liVncrU0xGTHQyTitLNmlWWnZwVjd2SUM0?=
 =?utf-8?B?N0FPc0puS1haOVk2QkZURkVkL0dBRVA0Wi81Q1h4ZXlkaVJ5TXpEb0lNNkpz?=
 =?utf-8?B?OTR0Zm0wR05SSFJ4OGNHN2ppV2RmWGFnN1dCaU5yOXdtelhwNkVSMkxRb0lO?=
 =?utf-8?B?RVBpeUpSZnBGWnZ3NGl0b3dPUVRvQmpNZFIzcHUwTkxaa2ZOYkZCejFNSzJ3?=
 =?utf-8?B?K0d2WTd5SDZCZ0QrYVVuWXZoOUdQRmpKTGdaSmRibVp5MVVYRFFsSnkxTTR1?=
 =?utf-8?B?emJmaDBOeG91NkI5U0RUaXA5Y3k0cEJyOERQQXBDNVRVRXRTWVlzdkwwZWc3?=
 =?utf-8?B?NHdsYjZtdVREdFdYdlN0VXFmWkpLNTd6ZDc5bEhMQmtXRDNCZGJudXdrbEVT?=
 =?utf-8?B?WS9ERWpHS0N5YkpjMzJTanpDaWlBVEdjR3pZYzl5OGdobkNwTzBuaDEvYXRD?=
 =?utf-8?B?T1VJdWFGYTdxMlRWcXliKzdZSzVYV0JSQlZFcHVtR1BRcHo0ZklFSkVwWStE?=
 =?utf-8?B?OUpuLzUvRStsNWdiRm80WlQ5TVhNWmMrQzBnckdwVVl6K3pnaFVUTG5lcVpE?=
 =?utf-8?B?NjlrMXpSUGJtQUd5RlpuK3ZyV3RORkg3RnBMRWRNNjZpYUdVQ2RTQXZ2VjlM?=
 =?utf-8?B?UktFN1FtMFpUdk1VSHFzZHRGb3pFS2k0NW5aMUN5TGZaMlJPS1BlMHc1NEEy?=
 =?utf-8?B?WlFqVy9NMjRDVTQ5M3BzVjZ6QlhrK0JoVmhWdDA3Vy9lbTdFdWpUY2pIVUVN?=
 =?utf-8?B?T0VqRWN3SnBieDVTTjFKcjdxNmlmd240WjlnSEZaNFBaeE1GRURmRnVzNC9X?=
 =?utf-8?B?VjhRMmNVV1FkdTZGSnZLcnFGalNMT0VPNWFJSmdWb0t3M24wOGJUTDJjU0FV?=
 =?utf-8?B?d3Q4NjQxaXR3K0p1OVZVb1JpQmgzckpQaUF2b3RuazMvMVAxTFBGcDNITDhx?=
 =?utf-8?B?SXpoaEFONjNtVE10UkNnenhoVTloTldKWWlqVE9yMFlNMTEvU2tuQmV2eWw0?=
 =?utf-8?B?UG9BNS9kVG51cmZIWHVyaEtLOWlKanoySDRXWlJHVmFnQUdaOFFvL0JMNndy?=
 =?utf-8?B?Mm9lT0M3WmxiaWlKcVRBNXFhVk9WMlZDS1E2a29kQ0R5V01aOE1wdzVaMHJY?=
 =?utf-8?B?VG5hZlczekhnK3lPYkhJKzNqSU5lTFBSOS9DRjRmUGtJR0xXSDFPcXgrb214?=
 =?utf-8?B?M0JVYzRBQ1JMeU5MZFVTZEpWRXdIS0NaOU5lREQrQVBnZFRPZFBKdnJ6N2tr?=
 =?utf-8?B?MWRPNmc4aTJMNGFneWpsR3lCeWZtWXBxdWY0MG9JYlRkMllvK0daa1VpamF2?=
 =?utf-8?B?MWxLaTBEbjRNcmxKOFl2SnM3bTYwYm5pNWlvbU9oN29HRG9ZSk40Z2NuSTBU?=
 =?utf-8?B?cktocXJwU25jRkFXZGtQbVRJRStYM0VjcU16S1JVdlNJS0dOWUtlS1lvNHli?=
 =?utf-8?B?czNwSEZYeEN1R2oxUDk5ZDhCU0NYOTRKZnBLekVEODU2YVRDOXluUmRXRGx2?=
 =?utf-8?B?QU5xZjFUa1d3cjh5R09IRkJHTXg5czJ5T0NtMGcxN0FQZTg5cFNEMStvdkxr?=
 =?utf-8?B?K2NVY2NNREpiaUdwRGRiSkNQRVR0VGlWekxFTEVtUTd3Y0pUdUJtYUNEbzBh?=
 =?utf-8?B?TVNhK2JzSkc2bkQ3NE5zcWhCbXQzZjYxRytaMEFqUHRSZGQ4UFFJOTNXMTJm?=
 =?utf-8?Q?Cukb3S4H7aBlK8Apoj4FB7s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gyzFqf6ps+vZSAMTt7ockN3ugIJOdr7D3ewzNPjGjgC0VLRj4+m9B6Ld9yvqEEpyiWPf9Z+CpDGUpAE/iGKyPSQqCkkmAT7m9iRzzpDXDWVEsd489ckJ8lkHlYMlAeafOXGWqkyVWF7NQI+5XK8HABsSor2Jy77ywL4K+8WtwcGNmpldria6Tt0rNgXBjFD8GByDjIHoRl02kc66frkePlqA6Kj3s2l9fh9B+8/7+nF6OjJnsF6eVwhuRNNEMFh0+iwDSwj/8CvGfBdOl8+CwGyVu7aJjf0o0Jxt+rnZEhrVB874Maiwc9cm16TVbOEwY7zLbr/lQIA9JIiv6LIx29OKtao8DDMZ9dnkG+m7pSuePywPRmaHnIJIPh3XdI3dbXzrPJAPLuKAtC9uK/rjLuWEdUNwrPFHC5TqX8HGoyPg9GSVhA2X1Eom5gaKDFyPl/XVlqkQ+FtY5Ka8zBKxADE54hCUsbrISWbt/CP/HDS+6aOZl/RpXtb2TyfIg8r4FDQobk+W0HqRn746lfZFvmNkZgj1X+tnSMWmutuuUMJPNCjc+gZz1G9aXCg9pM76YYBl0ZTWx+JLJqmKPh3I7Fkh5SLBFJmu6cmCpG3P4ytBdsxpJlue3oFTjsEHQW8pujH6t6NejfL/P7X/491P1aahjP7NRE2353tMRYSNUWHNVU6FBeFBTghIk+7JNkQToYgPEunTQUy8otBkSvTSIq9FgbM0QvhbeGlBHDc/GnBozlQiw2RPRiqk+BBixoB2v6qWp9lFOWQa6inBOiiYBj5+6cuewdWDcozUPxiPDVJDUEsJ7B1nEeQ3URqkfLOR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937f4013-03f6-4073-ebf9-08db2ba0899e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 13:14:30.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o55Fa/bdV3lp/tb5VLmEVemKlJFWbWEHzFDzjurfSJ5QbfMsEMWy0f+jIut1N/1Mx3B9ncic+9pUJzPzCTnc/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230101
X-Proofpoint-ORIG-GUID: DIN22d2lCvWWXdMM7trrRZvR7I8mIkhE
X-Proofpoint-GUID: DIN22d2lCvWWXdMM7trrRZvR7I8mIkhE
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/03/2023 19:57, Wang Yugui wrote:
> Hi,
> 
>> During the device scan initiated by systemd-udevd, other user space
>> EXCL operations such as mkfs, mount, or check may get blocked and result
>> in a "Device or resource busy" error. This is because the device
>> scan process opens the device with the EXCL flag in the kernel.
>>
>> Two reports were received:
>>
>>   . One with the btrfs/179 testcase, where the fsck command failed with
>>     the -EBUSY error; and
>>
>>   . Another with the LTP pwritev03 testcase, where mkfs.vfs failed with
>>     the -EBUSY error, when mkfs.vfs tried to overwrite old btrfs filesystem
>>     on the device.
>>
>> In both cases, fsck and mkfs (respectively) were racing with a
>> systemd-udevd device scan, and systemd-udevd won, resulting in the
>> -EBUSY error for fsck and mkfs.
>>
>> Reproducing the problem has been difficult because there is a very
>> small timeframe during which these userspace threads can race to
>> acquire the exclusive device open. Even on the system where the problem
>> was observed, the problem occurances were anywhere between 10 to 400
>> iterations and chances of reproducing lessen with debug printk()s.
>>
>> However, an exclusive device open is unnecessary for the scan process,
>> as there are no write operations on the device during scan. Furthermore,
>> during the mount process, the superblock is re-read in the below
>> function stack.
>>
>>    btrfs_mount_root
>>     btrfs_open_devices
>>      open_fs_devices
>>       btrfs_open_one_device
>>         btrfs_get_bdev_and_sb
>>
>> So, to fix this issue, this patch removes the FMODE_EXCL flag from the scan
>> operation, and adds a comment.
>>
>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Link: https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>>   This patch should be cc-ed to stable-5.15.y and stable-6.1.y. As for
>>   stable-5.10.y and stable-5.4.y, a conflict fix is necessary, which I
>>   will send separately.
>>
>>   fs/btrfs/volumes.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 93bc45001e68..cc1871767c8c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1366,8 +1366,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>>   	 * So, we need to add a special mount option to scan for
>>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>>   	 */
>> -	flags |= FMODE_EXCL;
>>   
>> +	/*
>> +	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
>> +	 * initiate the device scan which may race with the user's mount
>> +	 * or mkfs command, resulting in failure.
> 

> for  FMODE_READ | FMODE_EXCL, we need some sleep/retry,
> for  FMODE_WRITE | FMODE_EXCL, we should fail immediately?

  Sorry I don't understand the context here what represents the we here?

  In the LTP testcase the two sides are
   mkfs.<vfs|btrfs> side (FMODE_WRITE|FMODE_EXCL) and
   device-scan side (now: FMODE_READ, before: FMODE_READ|FMODE_EXCL)

> scan race with with mkfs may result worse?

  In the above example, the mkfs.<vfs|btrfs> failed immediately without
  the patch and with the patch it is successful.

Thanks, Anand

> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/03/23
> 
> 
>> +	 * Since the device scan is solely for reading purposes, there is
>> +	 * no need for FMODE_EXCL. Additionally, the devices are read again
>> +	 * during the mount process. It is ok to get some inconsistent
>> +	 * values temporarily, as the device paths of the fsid are the only
>> +	 * required information for assembling the volume.
>> +	 */
>>   	bdev = blkdev_get_by_path(path, flags, holder);
>>   	if (IS_ERR(bdev))
>>   		return ERR_CAST(bdev);
>> -- 
>> 2.38.1
> 
> 
