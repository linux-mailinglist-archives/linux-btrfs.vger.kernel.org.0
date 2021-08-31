Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F033FC668
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhHaLKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:10:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13152 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241366AbhHaLKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:10:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V986Mw010869;
        Tue, 31 Aug 2021 11:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T9b/Ksh2Q850DGFEDgDNtQW9K/dobDw6Ope1tO/mxlc=;
 b=NtBAtKFdH3Srf7e/ZVRElrwp9j4yqDuiPfCfDFHA5WGghA18N+AyDDOHISriSo0R7Tzf
 IBp+/vAsSdZAOQA/W7QCXxbX3yB03upRREC25IZyORtf48PGZfp1sH1fG542Ux52Tt7n
 UtxdTQSCT7EpsYDsA5sO7dqmP6FjjdM6ePnRxAq3wEEunVIMDWdh4QCVu9XaPrhFNRnA
 F3zDrsgxJhSCZTe8QxSWxpci/pRcksFwqsfaVCxCQ/fTWRFTs2mEIJXt/95iz8k2t3yH
 GWbLGQdL9jxQs48d0l0KIehpqhpYGcl3bfpMtw88vh55p8nnR+1TQ+cD+StgD8bJcSJb Fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T9b/Ksh2Q850DGFEDgDNtQW9K/dobDw6Ope1tO/mxlc=;
 b=Uv1xo54Qn/DaYcLoOi+DhvTVrKDxOyDBRPYh3aT7uVciOdDyECV6h3gcrewyOYpnHNz+
 D2qXKq098fD2rA8U436AF7FgE3USTCxUFplDD3kRX4FQ8Puh6quuz2CeabpidxbtLrN8
 So5QnaWw9N//I4fr2esbH7XelVH62eqjPw88Dx+t1eIjXVa6/7N0Jyu9xroz7pQKvFur
 wUbrqq2Bepr4oojkWXD7cuAUEMOEuq0ibjvT+IGWcKe++8MhFQmFCrUQ2JQrIjMp4Ftg
 IHFe0G+Q2tz8pXgLISoy2LG/ry5Aq7+228ngoJoRlI2yzhxXeUYHV2ysuqiz9j+dcR/r RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aserr0puk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:09:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VB5cI0083358;
        Tue, 31 Aug 2021 11:09:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3aqcy4h0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awVEvsuqIidgd6hh+EYcSL8RxAOuEmeHVeWhP8J5wmaOBUm1YVI60VuCnM5c2fJ2lPKFcrmSC02NY8HjfqGX8FV2ovvj+QRUxzC9sGFc7SXV+fL0cQMQJF2QH6dRBO924YgzNZO4oaiV0aglIXkLHolRS+yF2T8BHh/tyOLqB3VsAmBd3AhWtqEidLxD68uMl8TkF7t0lcIKEJPu9tuspBh9QRnaW0xbgv3TgCQgtZC7yfz5CSd6DTI3OGw1G9j6ggqMh/YvzkjbsqK1LR4zH6PVpN9NZmC0JXxPBrEGH77XgE1YFbeu1cvD2C6AL5y2caDvtL6xlpndYQvMpkeXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9b/Ksh2Q850DGFEDgDNtQW9K/dobDw6Ope1tO/mxlc=;
 b=ROt/XNJRAI3tcLQ6pQEUnWmP/c11Pi9cuxiF3UR+K2LbLOdKYV1/fH/ZIe7kkosMwPBkk4vKS+QQtqUKFBwc9KFqERjC0tWBACsU118RxCpWxEGYOF3lmyY+a4CyOgtZgIlEzMI4Ds9sPZYgqDhut2boTQ9oISkkzWWIOHIG+SDGOZGKGtXZdzch8WHUt8GQ1LboU/bg7ydvEXXLq060qbGSkeusOrAobWoteq9KW8NORmE6OA+NFkyTP1FOP6P5rdiJG5P0cckZ26vSi+azUG8MGFMw9MLatBRLdlJGUJSkYTdChUhzWk47K7WwlXDuLTdO+7TPqhGLF5DIu8vpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9b/Ksh2Q850DGFEDgDNtQW9K/dobDw6Ope1tO/mxlc=;
 b=iZ0MMOwpKfIo899AJGAFr6qd1t1SdcSOQ23s7lg2kLKzdzkLwKc9MdN/whOxq/CTl7XOJLFUWHayEczulbNJJeixntGoGtiwI7+7DTF5h2mIetI/9V9lls1KEklZJ15wMzhRbhy7jtVDrOyNmpOR1ucuZFj0BIQZKoUe4YQe9y8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 11:09:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 31 Aug 2021
 11:09:17 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <250cfece-1d7f-b98a-b930-36baa34b8b72@oracle.com>
Date:   Tue, 31 Aug 2021 19:09:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0105.apcprd06.prod.outlook.com
 (2603:1096:3:14::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0105.apcprd06.prod.outlook.com (2603:1096:3:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 11:09:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f3949d-54bf-43c6-69fb-08d96c6fc648
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB492963C8524C862CC2AD7029E5CC9@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dJ2UxPJGkdql4ftVENTKCtDyAZKcciEn5e1qzqjRGFm0n/S21sbg+iMgGbjMTEBDQIhRaxCiAgrnIKMX4YFZEAPnMMVrYxQLpNnBUBe38HSSfV608xUyBhr2WCrCzOXNuPgANfJmuPj/RboFtkHMZ4Z10kpomfk3gxprr0TN2hxGaTBTrF+aYuAuu5MRJD4GiOw1J6XKGuJjlvARjqxyBd7PQtooomvXKFhl71jRKbMsU9yuTCwP1z0NrFNThDEZ07BPTIFHRow3QI0SKQHk0tftEUQt5X6295vQez/tRTGfyySPvIkb49I1ARcG9S1wUvTAB4axc8A8qSAzSvEOVQAawOTf5SbSA0KnNzpIr/r4GkRqvraZ5Wbt5gX9WsUOsTpV1qS2haY+9zJ3SDD7q4vWa/xj7b41bXPZETs6RiZzvfC7fklvKhmTPrNQeN+68XehiFhztNDs9jLA5CI34Tkz6Gb7D2LnqcPNBfuQaidJ0q/n9cwkiAkuDipGgvOLvqx4Amd/cDC66rlAbNfwa4zwCfNljDqSKAn8b9lJ2a3pi7avdc/4bgjPloPgPcgEmEvhSDkepCuu3fBAThcfWqzTZFD8+Ks/eDs2E+z79D0eZAuVII3mHDi5oLpm0jEeMk01npODTopXPuy5E7l2F2GImmERIJQvzsd2bGWJwFdvo5ZQm+uNcVTyGXHFPSWCpZZLrPtJxkEmL6Ji5GO0FcUDb61ujWcbmDZLbmyPtDO3x8AY91pDKfYCV/0QZ4gIhA0/DccT+qWgqJtOdh4tbme6hkuswUzWrKdKnin+hswbVNGAlLAZc3XlQOL9TTO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(31696002)(6486002)(4326008)(38100700002)(5660300002)(36756003)(86362001)(26005)(66946007)(6916009)(6666004)(2906002)(478600001)(2616005)(16576012)(44832011)(53546011)(83380400001)(186003)(316002)(956004)(66556008)(8936002)(66476007)(31686004)(8676002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU5taWNSOStlVm8rVG15bEl6c0tDUEFzS0hRdFhGejNTZEkzUUtEMlhHTXF5?=
 =?utf-8?B?bnVRZGoxVDFKOFR2L24rNjV2TkUzcWxiVk91M0p3OVNuWHZhV1UxWTZiN0E0?=
 =?utf-8?B?dnMybWNHOFBva1FRRVREaWJsTTdKVE8rSDhHZjBaeU5RSm0zdUxVdzZvT3Fm?=
 =?utf-8?B?YWVTc3d0SElHQzZBN3dHZGdWMnE5RTdldUxsUStZUVl1cE41aDU4OXhzS1pP?=
 =?utf-8?B?cHRYcE95UW9abTJGTk9oL09SMkNtTmJIMEM0ZThaQUFKbDgvOTRmVHpSSE5N?=
 =?utf-8?B?R2xXbzVXTUh2eURJMXo0bXFoeTQwd1JOdHc0UGp1c21pZ0lFcjNjUGxadTR1?=
 =?utf-8?B?d0YwSzlmSmdrZHJQVlVSdyt6LzltTzFnMmJpdDRycGhuTkM2NXlzRnI2SVA4?=
 =?utf-8?B?OG1jNzhKSUg3ampXWVBLempsR2wzZXFlZy9qcmNrY1JVQTJLQnFOMlhpN1V1?=
 =?utf-8?B?aXE4WnhIZXV4SUpVd2psaWhyWXNzN1NnbmZCeFhQaFJBK3daemRXMWt1MHN6?=
 =?utf-8?B?b2pGREFOMVUvb2ZVekVSdGE2bmZ5b256Y2s1bmdiWTJGNjhwekFsbTE0U3lM?=
 =?utf-8?B?WUxQMHVXUk9mempmeWVCMTBnYUx6Q0hlcTF0WkdEMG5YaFVqUVlySlR0OHNO?=
 =?utf-8?B?NlJKM1VjZGQyR3hOUmhKRmcybXhVQ3Q0NGNyc0p0YmlPR0d1cFE3a1Qrc2FH?=
 =?utf-8?B?a09seHM0SmVBQUREbTlCZnI1QlR2dXB5QkpsTDF1b2FTM1Y4V2Z5WTVwbnEz?=
 =?utf-8?B?Q0NCZ2V6T2MrMWpqSGJXN1hLQVNIa1duaEp6NGNTSkUxK1Y1dnAwNUxNYTd4?=
 =?utf-8?B?dUJQUEV5U0dCa1QwbktwQ3pLVzBpVHVUK3hUejZoWWQ1R24rT2h0NEh5OWls?=
 =?utf-8?B?cjc2aDFuTWJwdXpSS0pNalJudGprSkp0QTZ0N1NvaHprNS9jTFE5VkVEVG5t?=
 =?utf-8?B?UTQxQVVaT2ZFTm9CWnBYRm03Y2I3MjRnYWVKM1p4ZDNBK0VkOWlKMlB5OEUr?=
 =?utf-8?B?ay9RdVJlaU1OdGhBNlBQcnR3MVQwV2gwNTZRTXpwNmFyU0hhaUdUVFVNMjVD?=
 =?utf-8?B?d21NVW1hb0RGcHMzc2Q1Z0htNy9yZFFkSTJDN2dJdzQ3MkF0WHVUcmMyVHdX?=
 =?utf-8?B?RHJNMnJhTHlqQ3dNOTAvZVNUMWdueDVUaitjNEZ1b2lHRmFsWGNkeTVOWTMw?=
 =?utf-8?B?Ym9WT2JJd2dDMUpseTJYTXphZEVVOHVUSldFakpQME9OeXV3ZnFBbjhtakFW?=
 =?utf-8?B?ZUZZNW95eHpqanByQ2IwMlZEVzlSYkFrc1h3VHI4cjl5NTQvQ2Y2ZVNPZmlk?=
 =?utf-8?B?b1pOV3lMazRzTXhuOXZwUEFBZDhYUW5rVW5Cb0o2YTJqeS9xb0xWR0dSZlQ2?=
 =?utf-8?B?RXowZjZKZEUraXpCcnFhYlM0WmpXR0JnbGFtWmt6blRwY1VIUnRYSWVESUNU?=
 =?utf-8?B?dmMzMGlDZ1hYQk5uUllwcDFPL2E3MktrTTZsaXUrMHJPYWREUFF1dC96SW05?=
 =?utf-8?B?ZmtLRnlNRGFVa1dMaW56U0JGUGY1c3J3N3lGK2ZWZldUMWlrM1BSNUpyWHFs?=
 =?utf-8?B?OUJNR0d4b0dkWjB0NGpaWTdHK2tnTzdLbzd6NXp4OUwwdnBqbHVkMXYxS01k?=
 =?utf-8?B?S3lBN0toSElJcDIvN2U3Ym00aE5lMldPbU5RbExSelVkWmJSUW8xZm1TTTFv?=
 =?utf-8?B?Q1FZSldsdi91MDZyTlVacVgyWXVFWkQycVJEQ0o1UmNEdi80NWE4SWhVakl1?=
 =?utf-8?Q?f6HZL/0Npom4dA4ApyRyVR4EqtXjKrze2Bzj7fW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f3949d-54bf-43c6-69fb-08d96c6fc648
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 11:09:17.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lJBGDCUnLaf/sj7+6S/JnBQ3ZJBk9AM4ijrvHg+FdbZOfPjML4aEOZ3eE6/PMju24PexPFvlfbXnRDaYbqRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310064
X-Proofpoint-GUID: Osd7mPDVoJ0R5aqlU01S7wgBLm5yNVME
X-Proofpoint-ORIG-GUID: Osd7mPDVoJ0R5aqlU01S7wgBLm5yNVME
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


btrfs_load_block_group_zone_info () and btrfs_search_slot() were the
slowest and, they are called more than 2127 times each (trace buffer
has rolled over there isn't all the data).

Sorted in the ascending order of time spent.. and bottom few...
<snip>
19472.64 us | btrfs_search_slot [btrfs]();
23294.26 us | btrfs_load_block_group_zone_info [btrfs]();
23315.21 us | btrfs_load_block_group_zone_info [btrfs]();
224534963 us | } / btrfs_read_block_groups [btrfs] /

Most likely because the zoned devices are slow, and we have to read
all the block groups during mount, so there is not much that can be
done about it.

But let's see what part in btrfs_load_block_group_zone_info() is taking
most of the time. Could you please help get this output?

$./ftracegraph btrfs_load_block_group_zone_info 2 "*:mod:btrfs" "mount
 > /dev/vg/scratch0 /btrfs"

Thx.


On 31/08/2021 01:17, Jingyun He wrote:
> Hi,
> I have attached the result of
> $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
> /dev/vg/scratch0 /btrfs"
> 
> Please kindly check.
> Thank you very much.
> 
> On Mon, Aug 30, 2021 at 9:05 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>> was taken by btrfs_read_block_groups().
>>
>> -------------------
>>    1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>>    1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>>    0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>>    0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>>    0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>>    0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>>    0) 0.865 us | btrfs_discard_resume [btrfs]();
>>    0) $ 228254398 us | } /* open_ctree [btrfs] */
>> -------------------
>>
>> Now we need to run the same thing on btrfs_read_block_groups(),
>> could you please run.. [1] (no need of the time).
>>
>> [1]
>>     $ umount /btrfs;
>>     $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>> /dev/vg/scratch0 /btrfs"
>>
>> Thanks, Anand
>>
>>
>> On 30/08/2021 14:44, Jingyun He wrote:
>>> Hi, Anand,
>>> I have attached the new result.
>>> Kindly check.
>>>
>>> Thank you.
>>>
>>> On Mon, Aug 30, 2021 at 9:27 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>>
>>>> Our open_ctree() took around ~223secs (~3.7mins)
>>>>
>>>>     1) $ 223375750 us |  } /* open_ctree [btrfs] */
>>>>
>>>> Unfortunately, the default trace buffer per CPU (4K) wasn't sufficient
>>>> and, the trace-buffer rolled over.
>>>> So we still don't know how long we spent in btrfs_read_block_groups().
>>>> Sorry for my mistake we should go 1 step at a time and, we have to do
>>>> this until we narrow it down to a specific function.
>>>>
>>>> Could you please run with the depth = 2 (instead of 3) and use the time
>>>> command prefix. Also, pull a new ftracegraph as I have updated it to
>>>> display a proper time output.
>>>>
>>>> $ ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/vg/scratch0
>>>> /btrfs"
>>>>
>>>> Thanks, Anand
>>>>
>>>> On 29/08/2021 17:42, Jingyun He wrote:
>>>>> Hi, Anand
>>>>>
>>>>> I have attached the file.
>>>>> Could you kindly check this?
>>>>>
>>>>> Thank you.
>>>>>
>>>>> On Sun, Aug 29, 2021 at 7:47 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>>
>>>>>> On 28/08/2021 19:58, Jingyun He wrote:
>>>>>>> Hello, all
>>>>>>> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
>>>>>>> btrfs to store the files.
>>>>>>>
>>>>>>> When the device is almost full, it needs about 5 mins to mount the device.
>>>>>>>
>>>>>>> Is it normal? is there any mount option that I can use to reduce the mount time?
>>>>>>>
>>>>>>
>>>>>>
>>>>>>      We need to figure out the function taking a longer time (maybe it is
>>>>>>      read-block-groups). I have similar reports on the non zoned device
>>>>>>      as well (with a few TB full of data). But there is no good data yet
>>>>>>      to analyse.
>>>>>>
>>>>>>      Could you please collect the trace data from the ftracegraph
>>>>>>      from here [1] (It needs trace-cmd).
>>>>>>
>>>>>>      [1] https://github.com/asj/btrfstrace.git
>>>>>>
>>>>>>      Run it as in the example below:
>>>>>>
>>>>>>      umount /btrfs;
>>>>>>
>>>>>>      ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"
>>>>>>
>>>>>>      cat /tmp/ftracegraph.out
>>>>>>
>>>>>>
>>>>>> Thanks, Anand
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Thank you.
>>>>>>>
>>>>>>
