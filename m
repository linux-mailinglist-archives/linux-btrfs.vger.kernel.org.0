Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26DE3EFA0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 07:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhHRF2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 01:28:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40824 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhHRF2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 01:28:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I5GXhY028865;
        Wed, 18 Aug 2021 05:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zp8iP4VdhP9op5Fxehten+oY4e1E+X4/U5jKkq/JJ0c=;
 b=Ox2TrS9Om/6WXbOxULvX2QmabsXjrQPzyTdPNZnDTwuPCpadsTiSIzjVYRIAc7dpa6nV
 MHcbKJhISxFZoXIeIFvnaD2+dKTuV18wAYupmD6Wr+gDTdkTsIFR8GfUEXW3wm4qi9jn
 xmee26X9EeOjkb7f8gIufjJ40uua6SdBsR+Vtc6b2Gh0kYEGyg3uUpRNoEofNoLq4EYQ
 TNsJ1QiuQEz46/+DLpVUuJDPS8rNF7twLSWYIIYA/tNRHbFjaF+6eOfU0BffSlpykGvZ
 HrtQyVBzdDhYZnoir9eU0gmGKkxXSmCg8Q8kTnRB3O+eQA+M5zUUz1KBWwqfXEc8uyBI 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Zp8iP4VdhP9op5Fxehten+oY4e1E+X4/U5jKkq/JJ0c=;
 b=JVVtT/9IoxfaYpKLALwMyVFLTu5xJlIPuTmgp539dCHJdU5PeDFAm+V6xEbgZjdnVr2V
 UUrxXnxR14+P7vF5gc5mCgAlGqv1M9N80+N2xMwd3gO7sY0zb+TnZI4Peqm1q/+/F1gg
 7wHUIV8PbrTTvYRBW/8c7Q80GPwkhS1cJX/Y4yCImpT9kPRl3tEp7ujRAMkoIKtDYXoG
 2W3TSUT6ip8XC2mXvQIL+TiGpSly2hjy850sU3UjNN1twp7Wmn6qgLzule8ZdR8j7Dp3
 cZlM9AYytDY/Uc/5C6ylK7m+8tlnsnqlMqpKwg06Abl5MlmRLzcKQ5ifCubvkgAM9BWw NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mspw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 05:27:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I5EoTc076405;
        Wed, 18 Aug 2021 05:27:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3ae5n8tjs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 05:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnGddxZxbPpt15QyZ/hBIAFFdPN9bDD0OmS+78D8JsWSoYUNX0miNVBl15t0liHvG+KctwnewE3n4d1diOlSZLKvAQ3uyJbL77uUNdVCKS6Z/1nc3s8S+9XHzkhfp0p6a+NlYj85p6lITUsszvqeTF4QR0vqLE8nlCSHp/haLWOUgPf+Z/Ms/lRcgZCTKtbEZTqhfb6+ES6zA+esv+bSfmDXIu3u7TS33fxwUNr7y+06x6jJ8iQuBLfuLkaTQ5+eat4yKhQYXX3V6PddYcahsNXpuFhb/qhg3n7bQVSIGg6RoqQu2onzSRJ9ThOIagT1WBqkPb6w0MCBbHUgfNZRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp8iP4VdhP9op5Fxehten+oY4e1E+X4/U5jKkq/JJ0c=;
 b=i9KHgHCSSxFnLK81Nd9VHE6xpBsqfZKd+g2FnYlV18+OVq/8SZb5IClpPDMfT+As+/HfsrazzmdmhF2LTrhZKSCHPKt0nC+YB/Zg9gaHC6rKn4DYG+nLqS8z64zxt4qs/k14V1bmoBZ7GkbQNAfg3wBI5T+vsEOViimY95ftM0H+WZBV5YVSJd1k6dvX/KK+aKOl4VCIO4qSHnf7aMwcYLc0eDjNNW5yrW38UbMFR9OAu1fj+kmrk0/c6/+sqpHdeIQrTUa8UKtvv6oy8FDPVhHdOrrD/VsVIIQ/ebD/u0M3aFCxczS8sC1kkYFOE1ic/KoxH63mma9rnhPCRqQ4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp8iP4VdhP9op5Fxehten+oY4e1E+X4/U5jKkq/JJ0c=;
 b=qiun4AC1/21Ly+XIv/U0JtdCG1Gws02l97bi+Ayx9OHmkXms1U8zjgjcIZtCcnuAnEpDLRz858XODsupuCHHxh675YTJrU+qScFoyvETj23fU1pojfBzTFWSEZ9MPBYrMcTG0YyqgtcZj27SGILEGqQSZureqWp0wy3cHjNAZ3o=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 05:27:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 05:27:54 +0000
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <63cd4e76-72b4-7b99-ae94-075dfaf78bb7@oracle.com>
Date:   Wed, 18 Aug 2021 13:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210809182613.4466-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0093.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0093.apcprd01.prod.exchangelabs.com (2603:1096:3:15::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 05:27:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc408656-f56c-4a7d-73e1-08d96208ede2
X-MS-TrafficTypeDiagnostic: BLAPR10MB4834:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4834925102DD6EEABEAF17A9E5FF9@BLAPR10MB4834.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUOm7P3vPU/VXbLVcOTMkXfu+phtW5+HwSMX7sIj+wxajNL1F/a0HV9O/BWdTi+YIuhBKzbWawhRJHrFMArUi6mG8JG8pd/NsgISJEQnUG9OC93UYDYYIcHYo1QUElDd8Gy+IUstTY9F86eMiDqhc20Zr6xbGZpWMcXjy6bDtqUjtHp205svM5vsXIokgim5D4p3BfRzTw4t3xpZNrR6OupUoxPp2cqQZ3oI99m4iTlstkIsVKS1omHtJNz7LM+8LHM0dCqL0UJugzO5mcfwxN5BqOer4JHwx8qB1eITOAc8I8PhJ450vAVpGW63EinfwWU3HDgf/mWcFc6NPolbwwXYU+kIiZGEsnZ6Jp0tcclIKuHO91uhxS0T6oN/MzNK65nRogSB8kjazQSvNMCDsy4FlvfCTlZkN4zGfr9Z6Df5q70Knk/KGJbkaS9SJbmFN1wa0ryQOOWj28651qE15bWysCT5s+urgqVJ8KdrwfbjOdhUN5Q4oBxhOL58vd3TjQiozmnD0Yq5SU9W9xpkmpAqol5/NJhuhDl78rQ1O5xTzd4zPMOew/mehd/VBQM9nuvw9UfD0JPhpG9O29TMoIVS3Uydl+Xi/8Y4N46oOX+760b0Cv2ZArrcsFOSSL1fPYvsgz3dDdjnJGIPt2zI0L8naUzBsYhab3wsxj9MgXlTw5JiTDtXRwdfbRhoZq0eMuzlwIrp+K87xUFbYt8vQr0HglnO4MDi79a10+eTu4/IsIRaKiRgSvf1LN/SlSXgN1kiQqZ/jm4scw5m86ZJi+bNZcWViyEkNxuGLSg2W64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(31686004)(86362001)(956004)(2616005)(31696002)(6666004)(8936002)(38100700002)(83380400001)(44832011)(6486002)(478600001)(8676002)(36756003)(26005)(186003)(316002)(966005)(5660300002)(53546011)(2906002)(16576012)(66946007)(66476007)(66556008)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RQRnBSQ2lNaHNDYmhlZitxQzlaWm1pajRPN3NZMkxoMEdENStmbHZmWmRz?=
 =?utf-8?B?c0ErSGcrbGswU0wzcDNsV2pFVWc0OWYyVmRTak5xcGNQYlZTU2tRbGlOWDNs?=
 =?utf-8?B?b2s5dDg5QjJuWnJIWm1XY045bXZKenpxczMrdWhHeVVXMTJ4WlFrN3BvRVNr?=
 =?utf-8?B?Sk1VNXNpV2VaSEUvN1k4c05XcVZnaTdKcm1IUWI4cTBHakFhbU9uRXJLNkQz?=
 =?utf-8?B?R0I4NkxOL092ZzFtUnQwQk9WSEkxY2tVMllWRTJUL3A2QTlZLy9wOTRMUDRr?=
 =?utf-8?B?dW51cHFkQmp6N3haS3l5QURLclIycE5uRVFpajlheG5ad2JGSmhsZWcyajNB?=
 =?utf-8?B?a3JLSDNoYWhnb3FjZ3kzL2VSRmVrcUZrZnNYb2x0ancrTmxhSkJNcWc4TUEz?=
 =?utf-8?B?blIzN2pMbU1NZTlLQ3c3SEE3WmpQUkdvYXhEWndhMTB2czVNMncybnlCZVMr?=
 =?utf-8?B?Q0hncUF5eERDck4wOHRQUUhXVDRKV3g5SzZSaVNjM0ZBN1RXM0NlaWU3RWxN?=
 =?utf-8?B?YkZkTWNFSlQxZDd0UFRMWXYyNmJ5RW13aTllSzZUVkF3T0phemFTN0VRanFn?=
 =?utf-8?B?R3BwRjBZQ2tnK3ZhSkNmZnlnMWNEczlqc0ZKbDFwalpkbXFqUnlYTXBKNS94?=
 =?utf-8?B?WGowL2k0Nk5UNzVDM2RGeVhIdW1BSzBFcGVIK0FoSGpoMC9lcElmZkhJNUFR?=
 =?utf-8?B?OXpPWXlmTE5ERENTMHUvYkxXVkdyQnBEMzQ5aDZMRWpSV2x3Tm4rQnZ1N0pR?=
 =?utf-8?B?WndLYlFlRzhUc1Bqa2NlRFZtSU0veHhPODhPaFpMZndpMjhTQ1RBUHhMT3Rj?=
 =?utf-8?B?aVpIU3ZJYkJnc3I5SlJ1Y3VxYXhQdE1OVURvUVdOMTY5M1BmNTBGNElKT2pU?=
 =?utf-8?B?L2FJWE5ic1diYXBpem5MUEdvVjRhQ2dPUEVyNmszWitybThUVENhb1dZZnFL?=
 =?utf-8?B?WjJpUk95dksxWFpaSEhpY0p3WUZFdUw3aGxLNUtjY2VUbGtVZlJOMjZpbElS?=
 =?utf-8?B?eGpWc0NCRCtEcVVwdnkwUklpWGVJK293WE5jZE1ZOGZHY0VXT20zTW04ay9p?=
 =?utf-8?B?SE5nSGYrMkZKR2QwbFhQMkhOZ01pcE9wdENxZjZaeDBhbXFqZ2JibVBjTEtT?=
 =?utf-8?B?NzJYdHlUZlhkRE8zYXpvOXFKK25jcUZrT0crck1pY3ZPNnZDR04vMFBSekha?=
 =?utf-8?B?MHdDMExXSGtmeU5uSFVOU1Bjbk9xa29vSUN3cHNyejIyNXgyMmR5UTBsVVgz?=
 =?utf-8?B?d0ZUZEl5cXNBSVVtV3M0c2VmWlNWMmw3NlpvSnFhSndyTzJFR0M3NkdoTlZZ?=
 =?utf-8?B?ejcwcWJjT0Yzb1RKZ1lhd2thditGcGdhNkExTzNnclJlc2M5Q3VHVGswb2dF?=
 =?utf-8?B?ZkNMZlB5Q2VtRERiRUpnTHJNcm1XdFZnd3Q4MVZYaGw0a0lHN0RobFA0ZzBv?=
 =?utf-8?B?a1lQZ1R4T1NDelppd21LVUE2U2U4d1Z3S0FacG10czBCczZ4RzI3eTJ5Q0ha?=
 =?utf-8?B?THB1RWpvTmNhM20zR0tBVm54eElYWE0xZGt6Tk1UWkZaRElCclRFVTVWSENU?=
 =?utf-8?B?VUdXcUdGSDdCN2d1UnFmZkJKZEhHVlNUV0FIaVorOVhrNVJwSWVMcXFLdzJj?=
 =?utf-8?B?cGNUMFoyR3R3R2NnVHVkbFZOUUVjaEwzeVdYd3E5WVV4OGxzL3RZM3ZsNVlW?=
 =?utf-8?B?MXBpUlN3aHdpWkk5a2NMYXdxU21UMGRzVmhmQXRJcFpRTTBnK1k5ZFlwNnJH?=
 =?utf-8?Q?wzgQC9G7DZLRdBGByeFoJ/lL2mIRZeK9KWHgJA2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc408656-f56c-4a7d-73e1-08d96208ede2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 05:27:54.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFBe2qGBZgGqX9NPJ3oCp7C+OvQAz1lOlY4ucMm3JLisiZqf9KhU/IMxnHHX1/zpyLfeGN58mY7uXwklIF83TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180033
X-Proofpoint-ORIG-GUID: TvewYsDsV5Snq3Pl1RTEAnUGNMS7MDST
X-Proofpoint-GUID: TvewYsDsV5Snq3Pl1RTEAnUGNMS7MDST
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/08/2021 02:26, Marcos Paulo de Souza wrote:
> [PROBLEM]
> Our documentation says that a DATA block group can have up to 1G of
> size, or the at most 10% of the filesystem size. Currently, by default,
> mkfs.btrfs is creating an initial DATA block group of 8M of size,
> regardless of the filesystem size. It happens because we check for the
> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
> (default) DATA block group:


> $ mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v4.19.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>    Data:             single            8.00MiB
>    Metadata:         DUP               1.00GiB
>    System:           DUP               8.00MiB
> SSD detected:       no
> Incompat features:  extref, skinny-metadata
> Number of devices:  1
> Devices:
>     ID        SIZE  PATH
>      1    55.00GiB  /storage/btrfs.disk
> 
> In this case, for single data profile, it should create a data block
> group of 1G, since the filesystem if bigger than 50G.
> 
> [FIX]
> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
> later on assigned to ctl.num_bytes, which is used by
> btrfs_make_block_group to create the block group.
> 
> By removing the check we allow the code to always configure the correct
> stripe_size regardless of the PROFILE, looking on the block group TYPE.
> 
> With the fix applied, it now created the BG correctly:
> 
> $ ./mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>    Data:             single            1.00GiB
>    Metadata:         DUP               1.00GiB
>    System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  PATH
>      1    55.00GiB  /storage/btrfs.disk
> 
> Using a disk >50G it creates a 1G single data block group. Another
> example:
> 
> $ ./mkfs.btrfs -f /storage/btrfs2.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
> Node size:          16384
> Sector size:        4096
> Filesystem size:    5.00GiB
> Block group profiles:
>    Data:             single          512.00MiB
>    Metadata:         DUP             256.00MiB
>    System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  PATH
>      1     5.00GiB  /storage/btrfs2.disk
> 
> The code now created a single data block group of 512M, which is exactly
> 10% of the size of the filesystem, which is 5G in this case.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good to me.

I hope there isn't any xfstests/tests/btrfs test case that is hardcoded
to the older block group alloc (like swap file test with relocation?).
But then the test case will need a fix, not btrfs-progs. So

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
> 
>   This change mimics what the kernel currently does, which is set the stripe_size
>   regardless of the profile. Any thoughts on it? Thanks!
> 
>   kernel-shared/volumes.c | 40 +++++++++++++++++++---------------------
>   1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index aeeb25fe..3677dd7c 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -1105,27 +1105,25 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
>   	u64 type = ctl->type;
>   	u64 percent_max;
>   
> -	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> -		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> -			ctl->stripe_size = SZ_8M;
> -			ctl->max_chunk_size = ctl->stripe_size * 2;
> -			ctl->min_stripe_size = SZ_1M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
> -		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
> -			ctl->stripe_size = SZ_1G;
> -			ctl->max_chunk_size = 10 * ctl->stripe_size;
> -			ctl->min_stripe_size = SZ_64M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS(info);
> -		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> -			/* For larger filesystems, use larger metadata chunks */
> -			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -				ctl->max_chunk_size = SZ_1G;
> -			else
> -				ctl->max_chunk_size = SZ_256M;
> -			ctl->stripe_size = ctl->max_chunk_size;
> -			ctl->min_stripe_size = SZ_32M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS(info);
> -		}
> +	if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->stripe_size = SZ_8M;
> +		ctl->max_chunk_size = ctl->stripe_size * 2;
> +		ctl->min_stripe_size = SZ_1M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
> +	} else if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->stripe_size = SZ_1G;
> +		ctl->max_chunk_size = 10 * ctl->stripe_size;
> +		ctl->min_stripe_size = SZ_64M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS(info);
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		/* For larger filesystems, use larger metadata chunks */
> +		if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> +			ctl->max_chunk_size = SZ_1G;
> +		else
> +			ctl->max_chunk_size = SZ_256M;
> +		ctl->stripe_size = ctl->max_chunk_size;
> +		ctl->min_stripe_size = SZ_32M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS(info);
>   	}
>   
>   	/* We don't want a chunk larger than 10% of the FS */
> 

