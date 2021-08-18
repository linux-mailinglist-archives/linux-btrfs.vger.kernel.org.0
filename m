Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175BC3EF8F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhHREDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:03:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhHREDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:03:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I40sjh017701;
        Wed, 18 Aug 2021 04:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TxwrrFKfuYHDou77r43Itnzh2jo+aJtc5eXZ8o6Tofw=;
 b=y3Zls/6UQqTG7XLxOpUM4HR8pwLUPj08kC4+Qna3teEnrKNEhOqMxhcqBUbQA19dKU37
 TG7j/V9CmgWGXbdEGJa3tgKHB9nNHNOCknXWspYk1bkjD2OiJxI0M5Z02NvjemquBX2L
 OCGUiH9h74IAj+ELiHLzSoSbhlcO/pU3YcXSusfusCI1kIolwU2h3ywXbzwEO/sqgOb4
 hGjcZuN6Z5o3i29uuszFZTdQQ3clGc4fke+LJ8xXDB01LBFJq2jmHzmcZGe3MagbWuAi
 N+/awzGaouZumbRwofQ//O7q0F4boqRyHd6DL4ldei1pqf286LQyvAzXLj5jSK+4HrHS 7Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TxwrrFKfuYHDou77r43Itnzh2jo+aJtc5eXZ8o6Tofw=;
 b=oKQ3d8q9zAe2kfIyZucJw7jOl6Em+4ZcI7Ov4NCyyZlOU6ZwFdKkBPlCH9ONSnk/XYx4
 RSygQYI8NnQrQMG6CnkTJjmp3A12eKgkRSQKNOs72/gxtvnJuOEDY7bj4VSzJ64KA7Tm
 w+hhtjayQi4l7eQwg8n7FAoK77SVZjbaRMFnBqMa4MHeA8i1vHp0LsOJZSK/r17tHyWc
 8CAubqsykhJG8Ska9f26VOnzeWmVXTGh8HHRvDSp6ry4PZshTT6dHqXGSjzs5lwkn7BP
 2oKGDB0cjC8pK8PYlr6qfegp8PCNMiegk1PGgL3x/0hN+9/6fVnCsXLad97h6D3tsuku Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf1tet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 04:02:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I40wDB006875;
        Wed, 18 Aug 2021 04:02:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vgqpt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 04:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMcoMV007oqjVjynD8KY99h7G1MVePRo+UTivYQVkbUzzFtzlE48rYi1Uan1fFY9plUSappnPbS7QKOQX8S/fSYb9/6MHW3I5MnF47/RkLlCI43ZyV8WH0SiTDe/yIhq9fNAc526YMHVePlEGMzcqwkUhO+sUK/yglvQtbw4w/7ztsGX4UHRDGpx5dBmJ97wTggAE/EscdJUlt3br9y5FnyF0fLRG82m9ncNMUn7aAP40UACcz+HlKMC1g5Iw1PaTEWTqAK5w015qKZOkI0DHRD3eVjqTiefIjOU/rneP68q6Im5aYD2wbMRMdQuL1AeWg0IjHkingA/3BppixNKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxwrrFKfuYHDou77r43Itnzh2jo+aJtc5eXZ8o6Tofw=;
 b=WlLtjsbRgxp/E7Wt+d+PMykV1rOcE1mKyBMCtF2MhW4Gb4mUrQyPkj1gl0Z3e/p2BNcGK6yZjzxZdBOEXJfk80q4P9dXIF3bhaMB/zr7avHsCmoZkjmPLGNX98/zCEtOz+kWwlzkPD0K+UBUWh4NP9ZgqWy/AAqRAVhrKdMLKTQ1dEAoWyvCTzX1m079THY3vQFcrSEVavRuesD2mf6+bk6aJ6eKiV7PTnwIwT0vQM8G36bRPij+RwLK/MMZYmziOHFY+Lk3sTEGCCo3amJ99+IEB/Sz+cNVQas6utljFSIoKsZxUxSHdoGJnvSMPveNYFJn417UhuYL5UaKJWabFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxwrrFKfuYHDou77r43Itnzh2jo+aJtc5eXZ8o6Tofw=;
 b=obElMCxC3bcsBg4jM3yrtxOGazoTZMEyrTk6ZKcO6RQQR7eH8K3yhbGdYCCk+WxPeGCFZzDVi0x52a6Al0YE27vrNz9oZmBuqUo3UeyJS6nMaVLJ5pnNkcVEGCHFf+d9glvy39a5PGjk3Dgi2TXXcUO5pytgT3M8ZKV2JSVo2B0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3965.namprd10.prod.outlook.com (2603:10b6:208:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 04:02:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 04:02:55 +0000
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     dsterba@suse.cz, dsterba@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, nborisov@suse.com,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fd59564a-7841-f6e1-8b58-4e831996e35d@oracle.com>
Date:   Wed, 18 Aug 2021 12:02:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210817132419.GK5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0149.apcprd03.prod.outlook.com
 (2603:1096:4:c8::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0149.apcprd03.prod.outlook.com (2603:1096:4:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Wed, 18 Aug 2021 04:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc605dfe-9b74-4b73-9e1e-08d961fd0ee9
X-MS-TrafficTypeDiagnostic: MN2PR10MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39656222953FE72565D38F31E5FF9@MN2PR10MB3965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwRUJdJjPWRcpYfuG3KCWF2TP8nNogZJFOM4TRe9rOv+Dk32X99zUviWpDPDAseoZSyR6RWtgN9SEAuhHki3lRQFKj8uMZJBVj5tap8lGyQ6d8jEBWTv2JVweGqnCgv4FfT4Pb//Zet8zXq+rP/uk9Skq62FkAzsnyp016826zRiJUeaWsyR6z1vhcrauakT7foVsF55u9XKUxuhwjgMGOqOm22gtGG5aKuTPacRFsP9XkWv4kyA1wSqqWQmJsoP4tRnwFPDmt35KrTDuytfHd54S8BlLR0ohIv+9/rXIpWhYLDfNYvu8aJ2nV4MfzKIl1HXrwICB3IRmEbLbI5N95FwTxYfCPECI2KJB+a73LlL/hFclig6agSeJykJhDhmK0iocANEMNgGQbA1JV+4/X6mNrOf7BSmgEkUYu408X2/+UgtzK7zg+KwqMidTPzDzxy4TgbnYya85r5F4brsx+k6Bfohan4xkybeK6HqvXGSmKruswW1rae/q9Pq0pW76FIu49paOEI0IDx4pb4dgTxOX85bEugZRYLum/81hW05HdDujKY1cyTWENn9rt475k8RY8pkTqEL+0XwxtnMQohweM9LbZPKvLB8Fv702HXS5CW55CxphTbW6nU9IdtwiMsrTYjAEkcXwN7Mip9PQUokSURuEy6MJPN80H/o3Qx4+yI60B8Vut0S7gfVaV6AqZBwGTKXHN7EKAw47f/gbOPQeyC0PoJJJiWSYozBtI+M9lsSdbYhgFdL1NegeQaRP0fhex61r5Dp56KjnaBYGUA49F0Or6XkT+gmSG6B0IWTOiVOIW506vRrBi0yYb3X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(44832011)(66476007)(2616005)(66556008)(66946007)(26005)(53546011)(2906002)(6666004)(31686004)(8676002)(956004)(4326008)(6486002)(5660300002)(186003)(38100700002)(8936002)(478600001)(316002)(16576012)(83380400001)(36756003)(86362001)(31696002)(54906003)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VxbHpZQzR2ejhZSEI5ajJFODJnZlltd0FDL09OSGVoVlJydWx5VFcxOGxa?=
 =?utf-8?B?YVJjaUswZzhQY05xU3lPVjA5K0FTK09GTjRYK2RXK2tjR1BoY1hqRzhYM21O?=
 =?utf-8?B?N21sVk5sWXdLaitLTWpOT3hRYkQ5SVNQcGN4NndPNWorbnFTK2t4ZjJpSzlB?=
 =?utf-8?B?SDVwaUlvbjVSZEFyVkh3SlhGeUhRZFkzWmsxUzd0VjVuL1MwaEtRRUxhQ1Nn?=
 =?utf-8?B?SnM5RU8vaHlIV1hUeTJvR1prYmprZ1lLRW9XTTAvSnpxWm1MeDRKYk1TbEVZ?=
 =?utf-8?B?bDQ4RElRSzFBY1dpTUh4TGtoaytqV3crUHdqUlYwZWt2dmxyNjJZYXVGSVV4?=
 =?utf-8?B?TW1XckF6NStqNWNEakZ6RmUvZlA2KzFGczNENmFTSStBZHo2OUl2c0NUY1BT?=
 =?utf-8?B?dVlkTmt4Q3dlcllyVDZ1TzNtVnpYNER5S3Y1RVNNQXBKU2tiUDlmRUkvbUdY?=
 =?utf-8?B?SGhRd0FYZnRsNTA5OVhwaXZqZ21WSHR6U3VSMkY1ckdMWkI1azhrK2pKaHZR?=
 =?utf-8?B?Z0s2bDRMSkxpQ0xsa2xPcjNKdU1VTDJJdUxwZHRXYm9ZMDV3ckx5NTF5cWkx?=
 =?utf-8?B?K0NWSTdwcWovT0Flb2ZwLzlGQXdnMUUrRVI4aHBNYUkxZHpEaWE1V3k1RmtK?=
 =?utf-8?B?aUw2RW5HUW1MQTEwcnhreXNzWFFlY1d0Ymp5RkowdzB4dWx6YjRsQU10NWtF?=
 =?utf-8?B?dTYzYWgwZFVQb3JOMlppUmtsanVlbG01MFU5dnNMTTRERVdOUjc0NkVtdmlL?=
 =?utf-8?B?ZEdNOWduMzg5cU9kWTRDeXI0WGc2T1Z2aTF5eWtDbFhOQ2NJM1JqNzFIa1J5?=
 =?utf-8?B?S21iaDRUWTRyNTBkQzZBUXJBTXBxNExrbGg4Ym1GcEhWYUs0S2kwNVdicVRM?=
 =?utf-8?B?MWRhU2lzaEpKZURwakJzZ3loci9Jbldsa2xzM1lDWE9JNzA5eXk2NUdrU3BZ?=
 =?utf-8?B?blVKMnUwanNvUlJkR1RRZk1mVXlmUDRRWWxSL0RmOTF5NWRLUXBDbzJSZDEv?=
 =?utf-8?B?WFZ3UnF4aEtZb0ZrVjQwdHl2QVVFODNnajlKbTVKTXpOUFkraU5BQndoeG1q?=
 =?utf-8?B?akRQcXRaNzZhemFyMnhmbjhFcEtIbFVDZUxUeHBQMGswdm5PbWdpV2RpTjkx?=
 =?utf-8?B?ZnVtQnhrVWt3eGtJY0Y2RjJyMFJreGNCWm8wUU40cEFmU1ZhYTN5NjJSeTZB?=
 =?utf-8?B?cXZEMk5pbmRTRFROVmFaKzZrOU5EZzdHOU9JbWY2c2hGY1NPL0FWaitBdFdF?=
 =?utf-8?B?M3VhVVRsTktJU3NnRmZVdTM3b0dRUXBoUjlaWjF1Q0hMaEFsUDhjWjB1T0tu?=
 =?utf-8?B?WmFUQ3l2d3hSZEZOeHlEYUs3TkR5elRNTVU0ZHprNXNZN1FoZWhvRVNZb0RY?=
 =?utf-8?B?WHc3emsycEhET2ZGc2g0bGJmNTMrYUUxdWZUek9KUFpSRzZEUCt2Q0ZVQ3dt?=
 =?utf-8?B?ZjljeEJxMzlsMHFub2xFQkd3UzI3YXJOem1MR1Q2aS9QK292dFRzUk1BOWdN?=
 =?utf-8?B?VzhOKzlXaW5ySEM2ZXBZaGNiZUtNa0ZSMVBlOVAyZUc4US9kZkFZdUQ2Y29p?=
 =?utf-8?B?bGlTL2s3b2MrYllRYnZIenJSM013Z2Jta1pZVjNBUk40SzVwbFo4Z3VWWE03?=
 =?utf-8?B?M1RsR2NCY2tFWlJ3eTVWaUowaHZlMEoyWk5KYnZabzlNZEloNi9GM3oxRVRY?=
 =?utf-8?B?UUNRejYvRnNNWEJZUDZtQmQwMDdpMlcxUVFNbzdsTUtOVExuRFFTSFBoaXhk?=
 =?utf-8?Q?4KeP+myy567fdEyMBBbMIHbLwvi8rRn/1+ibl7L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc605dfe-9b74-4b73-9e1e-08d961fd0ee9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:02:55.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR9Whi7kVQGQWCGYsCwIyWlGjY1a8QdlKsT5MLAAbv3yAE42OIRLgbzUpSkWOc59JT7bMw/1OaZb2h0QKJWY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3965
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180024
X-Proofpoint-GUID: e5f4EDDjeNNQvj1p0tnQxvRIykqzhKHm
X-Proofpoint-ORIG-GUID: e5f4EDDjeNNQvj1p0tnQxvRIykqzhKHm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/08/2021 21:24, David Sterba wrote:
> On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
>> [PROBLEM]
>> Our documentation says that a DATA block group can have up to 1G of
>> size, or the at most 10% of the filesystem size. Currently, by default,
>> mkfs.btrfs is creating an initial DATA block group of 8M of size,
>> regardless of the filesystem size. It happens because we check for the
>> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
>> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
>> (default) DATA block group:
>>
>> $ mkfs.btrfs -f /storage/btrfs.disk
>> btrfs-progs v4.19.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    55.00GiB
>> Block group profiles:
>>    Data:             single            8.00MiB
>>    Metadata:         DUP               1.00GiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Incompat features:  extref, skinny-metadata
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1    55.00GiB  /storage/btrfs.disk
>>
>> In this case, for single data profile, it should create a data block
>> group of 1G, since the filesystem if bigger than 50G.
>>
>> [FIX]
>> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
>> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
>> later on assigned to ctl.num_bytes, which is used by
>> btrfs_make_block_group to create the block group.
>>
>> By removing the check we allow the code to always configure the correct
>> stripe_size regardless of the PROFILE, looking on the block group TYPE.
>>
>> With the fix applied, it now created the BG correctly:
>>
>> $ ./mkfs.btrfs -f /storage/btrfs.disk
>> btrfs-progs v5.10.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    55.00GiB
>> Block group profiles:
>>    Data:             single            1.00GiB
>>    Metadata:         DUP               1.00GiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Zoned device:       no
>> Incompat features:  extref, skinny-metadata
>> Runtime features:
>> Checksum:           crc32c
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1    55.00GiB  /storage/btrfs.disk
>>
>> Using a disk >50G it creates a 1G single data block group. Another
>> example:
>>
>> $ ./mkfs.btrfs -f /storage/btrfs2.disk
>> btrfs-progs v5.10.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    5.00GiB
>> Block group profiles:
>>    Data:             single          512.00MiB
>>    Metadata:         DUP             256.00MiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Zoned device:       no
>> Incompat features:  extref, skinny-metadata
>> Runtime features:
>> Checksum:           crc32c
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1     5.00GiB  /storage/btrfs2.disk
>>
>> The code now created a single data block group of 512M, which is exactly
>> 10% of the size of the filesystem, which is 5G in this case.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>
>>   This change mimics what the kernel currently does, which is set the stripe_size
>>   regardless of the profile. Any thoughts on it? Thanks!
> 


> Makes sense to unify that,

  Patch [1] also said the same thing 1.5years back.
  Probably in a wrong context and timing? ;-)

  [1]
 
https://patchwork.kernel.org/project/linux-btrfs/patch/1583926429-28485-1-git-send-email-anand.jain@oracle.com/

-Anand

 >  it works well for the large sizes.
> Please
> write tests that verify that the chunk sizes are correct after mkfs on
> various device sizes. Patch added to devel, thanks.
> 

