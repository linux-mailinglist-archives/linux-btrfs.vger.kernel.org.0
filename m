Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9713F438C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 05:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhHWDEf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 23:04:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52114 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbhHWDEe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 23:04:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17MJxaIF023554;
        Mon, 23 Aug 2021 03:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ic7gCQv0w7Sb6vEdZw+sHwG8T3Lgk3slt75lPQglIUc=;
 b=wDM22H6dSK9dUYd8vQWMo70qnNckPBYVxDsWiFv3wl5Do4k5ySnPldmxJLanZ+I9DPPF
 E+M06JlPpWt0Crwaz6YbPgBZgNe+XvWalgIkZCohCDpmFxKUGyamBOgk+GsilTmdPYGl
 z4EfcVtCSU/svlio/BdnC8DIWDwZmWq2YvaBlO3/Hs3xt0AG7mDe7EvYJpNCs92Oava9
 u3P6Cykwavp8dhHWYvQoyTfa82eoKG7ti6RUNIcU1lPYmAr9G20j0e4FXHZBEJ/H1ZNK
 PNW1t3sU7qkOZlbY/32V4OZCkjmXIf7A3NmuhFpY7zciY8j7p9U8xmziZQMVCxyfoW7o 8Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ic7gCQv0w7Sb6vEdZw+sHwG8T3Lgk3slt75lPQglIUc=;
 b=HX5v9IMWlpQwMTtovZ585O00StKcFqQq9r1H6LORL5AeMd1GhpmCwgnfBJTxKisOm+lN
 hSnoKCoWTiqagb3pQUxvOIh1NMRJre92FRWQ75+BO4ONoNvk8AnMLNTnqizI7utRpvgU
 jh1xmIEL8PG1oBMnhIGpr9cfW1FTGrr3zWwAHitbqsmRHisih5fP34p0yJ38JNCEsFRR
 OnaTurDPbOfbE+ZGFyA7PB9pRYtswqw5KLTTRaDWmU6PaMBus6OoGCbIkqnIIQrUTHlL
 wHowc+vgyfpSh6ytq86dQYUYtIUWj0u7YayM2/eeouuqusfrTZhTWvx8441PIuc6S5MP 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7n88ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 03:03:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17N318mg103437;
        Mon, 23 Aug 2021 03:03:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3020.oracle.com with ESMTP id 3ajsa2hvu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 03:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqHtan0fNTp3LY2L+HYqpzrqpLgqJQnJUgR1qh0g1QZ4FToiixu06/DwnPr4ob1Vwz8eZuiBDqcQKLVM3w0J0FwinEywEo7CE4pGOi5qjG4Sjfb+INaGXy6uNinwULuTjkdiEeJ6LPbHA4VvqK3YZnwbP9FbGIvUNoWuYV5vMgk1r08efmEgLUr+nhayfLCUjMSTTLVa52Gu5P5lw0J9JMFY8ooOSvhIavZeNeovp/2OrUvUgYneNWaA7wHM+5R4HVvFy4D7LrgWdyLlM0W3b0Hco5G3Ht40nvXPIDiLnCdT/bWEi/A+N09Wu7kdOpNdmp5N5ZFHR6AfXwOygJPtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic7gCQv0w7Sb6vEdZw+sHwG8T3Lgk3slt75lPQglIUc=;
 b=SHpZI6SB3opknwtL0tbMz4J+qQvNtMMkPlRD4Pd8F1wZ/Lgos0hlnkcv15uvbszc1wciM1CBXXtXUZooTJEajhJF5n+L8PWJk3Bw/YAUvUQWQ4F+F0A4PUzHOmA11fvMGdDl1TakVM0ioIldFl4F4IHQ83IkkmMriwH5R5oFw+97yPJFcYkJL+gB+MEs74SjaWAVcWSqF2wnML6a41LREycqPhYBYwgOSqCEN1bjRpVdIqzPtnufMaWsSTQ0huEk+adK1OhQLOaA0uHQt2tU2cbfpZVst7MeievGYfIZSgbh+QTk6z/xpMUM0W12o4SdpRN0yUaGUjAGK6t3tf/KdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic7gCQv0w7Sb6vEdZw+sHwG8T3Lgk3slt75lPQglIUc=;
 b=MnfPkmmL7bhkG1Ew3U2i7AlQBWAOWpYQoZAGvpG1kpsU/c+B6/vNPM+lHbT3RilGSh/h6BGjebNSAFaneMB2xGCcF/VQPrE8fWl3Bkr50N/t4fgbz4BfanQNqVyd8kJeS6IvbjHecYi7HE2uurZXWYfjgb2bTJhLPRgIoe1rfzU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4016.namprd10.prod.outlook.com (2603:10b6:208:180::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 03:03:42 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 03:03:42 +0000
Subject: Re: [PATCH v3 2/4] btrfs: save latest btrfs_device instead of its
 block_device in fs_devices
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1629458519.git.anand.jain@oracle.com>
 <61d6dafaff6a119f56782fb35b2374411585b634.1629458519.git.anand.jain@oracle.com>
 <v93yets9.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <658811fe-1b7f-9af5-1676-ec204e3a72c3@oracle.com>
Date:   Mon, 23 Aug 2021 11:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <v93yets9.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:db8b:d340:b999:7977] (2406:3003:2006:2288:db8b:d340:b999:7977) by SG2PR01CA0169.apcprd01.prod.exchangelabs.com (2603:1096:4:28::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 03:03:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db702ea-f99c-4c07-4ec5-08d965e29ccf
X-MS-TrafficTypeDiagnostic: MN2PR10MB4016:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4016ADA38F32989A3F3C7CF7E5C49@MN2PR10MB4016.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdAO0tdIXA8t0Cx7H7Y52w3QTm07edNJn/FKcpc9qMPOZhKmr1ZIYQsoaCaOtkAoeeOXCxGc9dFdf2RmQpoUtF4gkn3JSxcJuK13U5suFhNDePK1XC81b9/b87z9WIWy+veUQ7tlW8D5j4I5OnnhE2DGXS9R06YJPuYYNOvz0k/cecyiXPKSaPAOKK9Et1DbNvcWxplcH1hcbm0jTbSsKUBJHmDFVviPSH4nvYOI2EWIcNyxFlG3YdNQM7KQ0VU5b6Ke9kwS/xZJEXgkaKRYkJJ7ev56JUaVpv099AI6Lg/42jEZRYjwG/wIsHEccUlJ/xvxnDT95IrmfxqUByZhJvfP+K65RdsgT5YuJBvTHz8sxFdXNmHkV8/wCTdaL6wdj9ER1psPP2qN1q5+34QX12ZFxkkDfug+YvBBVrcyFot/rFC0R8ZQCjw7DUevzdiwHxtniJzmUK74fBveGF9MREWrAX2nXqFODigR29uTQSLsFhI8X4vQqPnTqky0MYYeuO91fkpNmo7YRbbhUdT3fsw92Hp9Wg7mL1xnD2qC+Eeb3xfu29+7cZl+7f05whQlhF9KXChFDJM0D6KvN+7p3MNGbOZZFCroQ8tszcjfVSw+V5wADZA2ikEkoWG14MyIvkhWHbwsq+st0RTJQbNXAZDRc+oF90fFyzVyOiUDOJzRCSkIuJzzTfVxMcTyNDR4ctCVfvfYd+ppONbHdrIVWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(36756003)(66476007)(66556008)(6486002)(316002)(5660300002)(2616005)(44832011)(38100700002)(4326008)(31686004)(53546011)(8676002)(66946007)(86362001)(31696002)(8936002)(186003)(4744005)(6666004)(6916009)(2906002)(781001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRLVVlmVWFQbkxDeTcxa0N4NkZIOHp0aUZJb2NFMWFCZ0Nrd1E3SHVMTUp0?=
 =?utf-8?B?TU5WakZ0M0lDTGcwY0UyVnVhSVpjOHZzNk5aQVg5VEZXUFlYR3ZwcHZqbFRO?=
 =?utf-8?B?QWJxMWEzWGlDMHBUN1BlRzRnUVNoSHJPd1JnUmhDTG56a0YwM040UkYrTUJN?=
 =?utf-8?B?b0ZEVjRJdzluZVVpMVB4V3p6bzBEczZoUEdTMlN1RC9EbSs4QnVPTnFWeWxX?=
 =?utf-8?B?ZjVWeVZPektvazBrV2hUejNIeXRhYmJLRFlnM0lzelh3NndkQitrTUx5cm5H?=
 =?utf-8?B?eUJqeEthWkw5LzBnU045RUR1VGg2QUhwa2pYcEFKOUJJRVlXcTE1MUdtWGNG?=
 =?utf-8?B?MGV4SWFXOVpYVWt1T1lXMUVHcUFrWG5ENEdMZnNWakZvZlJURWtVS2x0OTJK?=
 =?utf-8?B?Z3JieFVXMkhTdWtYR3ZCaTc5ZmpkWnRBZzVNZGlyY3I1K1NwYUNXMVNuVkky?=
 =?utf-8?B?Q0l3V3BxRFdrREpVMXZROTlaUk95V2ozV2UzV2t5Z3dPM1UrZlEyK1FqRHJw?=
 =?utf-8?B?LzFlSnRkQkljbXBLRlAyQ3NoRUdtVjF5OUhTZmZWRWhVcWNDR2lwQ2xUK09v?=
 =?utf-8?B?cVc3S0I3RFJEcHEyOGE3SlM3ZkdmUmQxTTY4UDhEOWZaWWk5NU1lcGRKWjdU?=
 =?utf-8?B?NnRsRSs4dWVxL0czR09HbTN1b28wTS9pS2FUY2RtS3I2ZU8xWHFmRnVmeDJM?=
 =?utf-8?B?cmxUd2l3YStWN3FSQ1BUdEZTdGZYLzFSZ3hHV0l6RzdKWXFGMW45ak9TSjhp?=
 =?utf-8?B?aGl6Z3NBRkNvaEI0V09RdEk4OTh3N3ZiY2crdXQyMjc4SXNDWC85cWhaekJ3?=
 =?utf-8?B?N0ExcWxmQy95K2JPMU93andhdXdIdzNvVVlYSXBDZ2tkWlRoY3JuaUdud3U3?=
 =?utf-8?B?VFNhcUxPYmhGeHMvRmZRckcvNGo2TDA4YjhCeGNkTDg1ZDV3d1dYcUdnUThP?=
 =?utf-8?B?NjhVYkNNWFBPMnl2SXM5emVxdTlGK2cwYml0UEs5aXpKS2FLN2QvcTEySDVF?=
 =?utf-8?B?dGlqR2l2WnVIYXNEU1NSMElEZWpTYWRPcjFTSVlCK1B2MTZqL21ZeDQ3TStr?=
 =?utf-8?B?d1M2YXZlWERyM2FrUlpPWVdKM1dRRjZ0bTdPNHRTdGg2dTNZQmhvVzVVVUNI?=
 =?utf-8?B?cDBLdzFuUzdlOXcyTUkwOENkZWZtd0tBeC9lMmpmaC9PbGxUdkg3d0J3RjF3?=
 =?utf-8?B?VUlsM2VZTEM1bEIyTElJU28rQXl5YWhJWFZCeTBiZHJ6Y2V1N2JxN3JOU2xM?=
 =?utf-8?B?S3lMMTJLK0RUcGJRZWRjSDdZNFovYWNmbkxPVlh1bFNrWjdOYXU3THpNWGRp?=
 =?utf-8?B?WUtNWVhweVJIbXE3OWE2d2pta0dVSGtncGlvcE11UWJybjcwUWtDQ09CZmhT?=
 =?utf-8?B?QnZNa3RFYmdoR3JYTm9RU0lIdG0zVEFqY2NxbDE2VlJaVXc3N3A1Q1FKVWt6?=
 =?utf-8?B?VnJBQjV3b3VMWEEyUEhJMnExZGloMmVhRXBQL1pjbnF6OWNHTWhGdXg1U1ZP?=
 =?utf-8?B?dVB0Q1h3VkhPOVdaallPMHFqMERMbG04QVdBVG91NHlxUG9YbmxEajhwcUhJ?=
 =?utf-8?B?UzJGSDJ2VC9OYVBISkgvbE5raXFWL3BLSzdaL0o0Sit2MzNrZkJMejFCdDlm?=
 =?utf-8?B?Y2Y5R1RKbDlmdnJSendQaXFSeExWTGZSbGZBOE1GUGdUOXJWTzE5dnVCNHM0?=
 =?utf-8?B?bUR5Rk1oOHc1eDRzNlhvblluUk5hOEdsRmlFYUNnOWRIUGRKMG5USXJnQ3l1?=
 =?utf-8?B?aVBESHV2SXN4YXpSb0U2Qnk2SDgxNm5Ka3RtR1RWbXpIWEM0cEdyQzJWZ3Fw?=
 =?utf-8?B?Mno1VjdCRDhZSjI3WEVrM2lkUFJPV055cmdPQTd2cVhyOVdPL2NPTUcxbFlr?=
 =?utf-8?Q?pUjYT9PdcunJc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db702ea-f99c-4c07-4ec5-08d965e29ccf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 03:03:42.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BsME+BlpaTDdnmhUbHbMrL1nEOU7UF42he//EyuLewjm/a2Tzp0RlEXmXyA1Wx4ncEMm8Oe2l1zxgCanJGBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4016
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230016
X-Proofpoint-GUID: Cvb-T2PKKi2HCzDJ1dO38mG8FFdlvPAB
X-Proofpoint-ORIG-GUID: Cvb-T2PKKi2HCzDJ1dO38mG8FFdlvPAB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/8/21 10:46 pm, Su Yue wrote:
> 
> On Fri 20 Aug 2021 at 19:28, Anand Jain <anand.jain@oracle.com> wrote:
> 
>> In preparation to fix a bug in btrfs_show_devname(), save the device with
>> the largest generation in fs_info instead of just its bdev. So that
>> btrfs_show_devname() can read device's name.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: born
>> v3: -
>>  fs/btrfs/disk-io.c   |  6 +++---
>>  fs/btrfs/extent_io.c |  2 +-
>>  fs/btrfs/inode.c     |  2 +-
>>  fs/btrfs/procfs.c    |  6 +++---

  Oops. It got in my boilerplate codes.
  I will fix and send v4.

Thanks, Anand
