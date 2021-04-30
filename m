Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C136FAE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhD3MuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 08:50:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45058 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhD3MuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 08:50:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UCj2I4051877;
        Fri, 30 Apr 2021 12:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R15uS35b4gRi9yyxx9wqktwvasN/V8DSIwHVZ3I9WPY=;
 b=CvE7a5iyGEiA4WcBSEywSwE86t+q4c24ioPEbEqKqFAhTgnljdHxQM+dbTAXVuAbTxuU
 6U1AjLBmrczWm0BExCIzxSnO63BmbkjEmA9gWETH0pEYAf5sRoYEzmSyYDsFGgR3XV1m
 MnmzzHNO60neTYAN/2KRlh5mwc9MWSFUh698Koe/Zfd1+Tdq0wcZTd2GfMZLr2jtrX/g
 mSQVWxEhZQETcqyAW4Qs78wlFbqCaLSd7dokfMABpCgp4uM4ycVI3FJ8d2/OKKFoiKIT
 psR6NzJkPUnsre8QYHQSiRCo3dVr1oSy4Mhm7UNkfLGwRlMZJClRcX9l46OvxHQXDJbw PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 385afq7neg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:49:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UCjxZC128747;
        Fri, 30 Apr 2021 12:49:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 384b5bxr4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmfwZM2nRsRxgNlI0vP0zxTbTArR710oU4MyPnB9JzhMNKWCWCGCveXd5VIQJPzrIf3RkqtmCTIyukEty0K3Qin31HJI+g6s8Jc9IBFv7aR+ym6mI2gusOBvzFvJ8NBliODhZFh+6FBiLecCYM+9RE+tBRwWTaSsCWtyut6zZoDYucGAIT7mdfIDY/N1eiy4lolwrl7FMbbkPNCWyCovfrwSjun37bBHdySkxziZSs+qDWD4gclVXCfwdU5eYmed2+3gSW9drPb+KFGe8/vVZUL3VWax8t2/tH9haxfnKM9gKIsYrsBiDdDgYAYGSYFQQ2swdZSWOYY7uW3uRra/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R15uS35b4gRi9yyxx9wqktwvasN/V8DSIwHVZ3I9WPY=;
 b=REY3fmM8iknh+Wxc7AiJKRw8rAdTDDtclzxA2OnnVmceRCZMLdbvG/HVI2x50rxvTF5GiLSfHbUhQ55XQ1+Pf8qCzOCKKDUoa0EykwUhANQWVgcMhCDlcd/hRv+6CY1jURmTp6BOjGXJyczmV1RUp86mE42ZBl2ndFOROBWTE9UbbtUhiiimCdZJ5oyvVDaK5Yehlm8dzpciYo72YI4NeOBW6/YbnTlHzzENWoU0W6D7nf6dpRIavPq+3UbagYGsAXeLj1Oo/nWqkSU7vfaHVj3d8WcqJ6lJrgb8S44GaRzZBlksF2JNEU+E6RBARfeIKDURrJmi2ZxG7RDpxC+PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R15uS35b4gRi9yyxx9wqktwvasN/V8DSIwHVZ3I9WPY=;
 b=EqfBOvi+qgmcK0XxlsX7nFzgXxxcIdS05A51H9gP4EckNq4k+9OXT7xOQOhK/Q5I+A7YyF8arNBSuTgSPRV5xbesN9UYlc9nDMVw0D8TowazQPD9Tj1qqtUKfrptL1hKLYVEWpf6PKF7rFasq9c0RkFUrvxB2yedTzdj1y49E6A=
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Fri, 30 Apr
 2021 12:49:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 12:49:06 +0000
Subject: Re: [PATCH] btrfs: fix unmountable seed device after fstrim
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
 <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
 <CAL3q7H4Nt6Z5B5ZtqFgjR-=hDH+RhZe0XrWE27zvFpq90VNpMQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8a545d8d-0bdd-4cf5-1a65-fbdbeecb9b33@oracle.com>
Date:   Fri, 30 Apr 2021 20:48:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H4Nt6Z5B5ZtqFgjR-=hDH+RhZe0XrWE27zvFpq90VNpMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:3:2::29) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:3:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Fri, 30 Apr 2021 12:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db2ef47-799c-49f2-94a1-08d90bd65734
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4835B26152BC146A71AC05CAE55E9@BLAPR10MB4835.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14d5x6ak1QHgZlPzUoy+QJC+UdlAfHfRJYLWcDHuuSROeswrzLOpxR06uU4z+G+pMeiETMbnDEIx6tqufG153SGcBGYvUct5xecPWHXrQ6M3Zi1ky8yBV7w9EVi6Q5pf79+aImVIbh3Kaftwd7BWYHORbDlMqkJwp+xyU3hIlMckYLl1f7RIhfOtiu/D3AeT3HwHiElQprg8ks1cGSsK468PJzSxMqZoxSJQeOWJo2hzoK7UEcF8+P4jVLHT5ePRq4VXgEvzMz0O3Yss/E88vnHFXsliUtX40nxZQ9fD6RVaJflRlktrKhEKWZaiMmbG0WPZpQP3bWeeOGtVJm9lX0Sp9bkYPonTL3JcoHTCNiNUkdPxEzPNhgRlfi2G3XX7xiV+SJRmRgvtgdwcNBxYI+h3MpkpbxRPEtBki9wNpjiEuFjeFlFpCNXqoKPawcdpztwvXpqtwJsZetKHnKTqYWCsOcmotubhqz0cnsMJvXnbw9KCUlBvMAXvoMEApFfiY8foxil0Vjo5633LhaYQ6LWHHj66QCkjxYgaTvZWUMfbWellBGkITMT0q5JHo1mQLfYZnxwUj7wgqMnq9UrKb0n9L/nI0S5fc4VfrT3y6q9JiXfHUshR1NPLK44511PR1JjKPdVW6DRIsmN7jqTCQA1YPt7+hXBNCQ4KREru8QPcDqeUytA4+7CQxnNn16HD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(8676002)(478600001)(38100700002)(66556008)(6486002)(66476007)(66946007)(2906002)(186003)(44832011)(16526019)(26005)(53546011)(2616005)(956004)(31696002)(6666004)(6916009)(83380400001)(31686004)(54906003)(16576012)(316002)(4326008)(8936002)(36756003)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFMvWWk0TnMrQ1FtTVlVbkdQTjhnL2hGNzhtd1ZGckNxM3JLSCt1M3VOWGhj?=
 =?utf-8?B?QlFkUi81OVhTR2dWQVIvUTBCRkt5N1pFM29wZ2dCSjFvdnJVTU1qUWw1TytG?=
 =?utf-8?B?L1BWUkpRam01Rkh2d0EwK1pTUW1FVzNJRVU3TjBMdmo4MmZ3c0V0OFpVUUoz?=
 =?utf-8?B?QWxQVHltK1FrdzJFOFhNNllidy9MRE0rMVBnM2Q5UmpmSXN0MTJ2OXBuTEdS?=
 =?utf-8?B?UlZGNGR1bjNQTnFZZjBYVjlwc1BRcm9pcGJnQVNCa3Q1WmdSeHJPS3VYbkxq?=
 =?utf-8?B?b0lRbks0WlhKN3V4VFF2MXRvdUVTQjlrWDk0ZlROR0JncWxTdE1iQ1Uyd2Y4?=
 =?utf-8?B?cGlxcWFzUk5BUmtUQmF5QU9EUDMzQSt2ZVZMSW1ad251emdTT2tBRDNNTVhC?=
 =?utf-8?B?YWZhV0RKZHh3T1cvb0NsTVRrUDhNNEFnRFRiZGJiUjhicWlIMy8wM1h4Rk40?=
 =?utf-8?B?ajFia1B5bEpTVWFORU53czF3RC9Rc240T0M3WXRxUWFKckZKTFlLV21vT0Z3?=
 =?utf-8?B?SmhVMkRLdzVFNzhpNzBtWlV5UDI2MVFzYm9rTEgvM3EvTVBMbzNPcHE2OUty?=
 =?utf-8?B?NEllbVhONmFibjRISEd4M2VqOEdiWFBjV0VrcTNCdWM2SEJDT1Z3UWlZZ3JX?=
 =?utf-8?B?MkVLMFpXZmN0Y0hvOUhlQWgrVHdYTXh2QURZWHJKRWRkZm5vR1E5NzhHS2dE?=
 =?utf-8?B?bHQwekEzL3hhd1U0aS9ld1lkR3IzZ2JWaGVnS1BZelk5bmliVjRGZ1FTOHg0?=
 =?utf-8?B?U0tzeUw1YnMwQk9mK2g5bFQ5SDlIVnJ0ajN1d2hkTXNVOTZiTXBiMFdJYk9G?=
 =?utf-8?B?ei9ZaEsxVjZqUjd6TExvLzRsSWhmOEJPQkFRb0JYMjk4ejZ6WGZKeVhCWEdQ?=
 =?utf-8?B?WVBsOThuQ1hOeFJNb3JVR3lSUnBPZ1ZKYmJ3ZTVNcVgxaGllbUdXeWdEUW9h?=
 =?utf-8?B?dk8xbDRmYlJ5K1ZWOGZIZ3VvR21XMEtSS0l3ZXF6ZG01UzFXTVVwanVvd2gr?=
 =?utf-8?B?Vml3eTgrMXhCempWWkxmVHJ5TzMzeUhzUTlWendzZFhnSWdESVI0UzMrQ2Q5?=
 =?utf-8?B?L3pWUFkzNGNwelVmNFZxR2w0eldUeGtGQTRIdWdBdEdibWFITHpTVzNHWE5R?=
 =?utf-8?B?MWd2WjBSOVZITkZVN3BGZ3ZveXBOYjJYTTZmNDluVS9TSDJOZFowckx5d3lz?=
 =?utf-8?B?em1hM084eGJQVmt0U1ByT2IyRXNiKzlRQnl0b2FpazNneUw4RHgwMmVPRzdY?=
 =?utf-8?B?Z3hheXphc0kyUDF1aS9PWkZuM3c0cEN0WXJkUVVLb0J3REtNKzNQemhEUkpQ?=
 =?utf-8?B?ZlFNWGZmVVJDRnFwcHZDbjFFRkNtbURuTzJVaVFOenRhUVFXVW0zVE51aFZv?=
 =?utf-8?B?WkZneUNUd1JsWm9vS09BV2J5bS9mUjM4NXlvQSsxU2JjUHJoa3h5aFVOVkVM?=
 =?utf-8?B?ZUlwTTJHY0xtUVBvNytXdVgrS0d3dUZHOXQ0cGpRNEkxVWY1Ukw4eEhHcGhu?=
 =?utf-8?B?cnJOcHFUN3d1SzU2YmxsOFkyOXZRdEtabmRmcmhncmQzREFUenFHWFRva3JX?=
 =?utf-8?B?ZWlKandQSUhSVVJRbW1XRWRTUnhQa294WXFQMkVWREEybU1iazBjQ2ZrRjNH?=
 =?utf-8?B?aWFEYlNOaDMyeVZqL3hhS0k3ckI3VVphYXdoNDZsV3lBQnBGU1ppSitzd2pV?=
 =?utf-8?B?Vms3MnhBNHg4aDNpeUdRcXN0cnh0c3N3WGswTzZVNXNzYmtMVXQrNlpiSGNS?=
 =?utf-8?Q?TBCai9EUKeAlusg97+0fOdG4UhBBXDY7xs7aMHx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db2ef47-799c-49f2-94a1-08d90bd65734
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 12:49:06.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkfzRRU3APkpEm8BBZLC+CNU1iHSD+H2s/sjhb4UjwIlzpcfntAUAK3MTHiFKykVD5SwtToi+OPmSttId2H1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300092
X-Proofpoint-ORIG-GUID: 3KTV1aP6Kitu92eWNlOW-v0QbVYTISyP
X-Proofpoint-GUID: 3KTV1aP6Kitu92eWNlOW-v0QbVYTISyP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300092
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/4/21 8:14 pm, Filipe Manana wrote:
> On Fri, Apr 30, 2021 at 1:03 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> The following test case reproduces an issue of wrongly freeing in-use
>> blocks on the readonly seed device when fstrim is called on the rw sprout
>> device. As shown below.
>>
>> Create a seed device and add a sprout device to it:
>>          $ mkfs.btrfs -fq -dsingle -msingle /dev/loop0
> 
> An example of making things easier to the eye here, is adding a blank
> line before the mkfs line.
> The same applies to all the other similar places below.
> 
>>          $ btrfstune -S 1 /dev/loop0
>>          $ mount /dev/loop0 /btrfs
>>          $ btrfs dev add -f /dev/loop1 /btrfs
>>          BTRFS info (device loop0): relocating block group 290455552 flags system
>>          BTRFS info (device loop0): relocating block group 1048576 flags system
>>          BTRFS info (device loop0): disk added /dev/loop1
>>          $ umount /btrfs
>>
>> Mount the sprout device and run fstrim:
>>          $ mount /dev/loop1 /btrfs
>>          $ fstrim /btrfs
>>          $ umount /btrfs
>>
>> Now try to mount the seed device, and it fails:
>>          $ mount /dev/loop0 /btrfs
>>          mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>>
>> Block 5292032 is missing on the readonly seed device.
> 
> Colon ":" instead of ".", plus blank line.
> 
>>          $ dmesg -kt | tail
>>          <snip>
>>          BTRFS error (device loop0): bad tree block start, want 5292032 have 0
>>          BTRFS warning (device loop0): couldn't read-tree root
>>          BTRFS error (device loop0): open_ctree failed
>>
>>  From the dump-tree of the seed device (taken before the fstrim). Block
>> 5292032 belonged to the block group starting at 5242880
> 
> Missing colon and blank line too.
> 
>>          $ btrfs inspect dump-tree -e /dev/loop0 | grep -A1 BLOCK_GROUP
>>          <snip>
>>          item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 itemsize 24
>>                  block group used 114688 chunk_objectid 256 flags METADATA
>>          <snip>
>>
>>  From the dump-tree of the sprout device (taken before the fstrim).
>> fstrim(8) used block-group 5242880 to find the related free space to free.
> 
> Colon ":" and not ".", plus blank line.
> 
>>          $ btrfs inspect dump-tree -e /dev/loop1 | grep -A1 BLOCK_GROUP
>>          <snip>
>>          item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 itemsize 24
>>                  block group used 32768 chunk_objectid 256 flags METADATA
>>          <snip>
>>
>> Bpf kernel tracing the fstrim(8) command finds the missing block 5292032
>> within the range of the discarded blocks as below.
> 
> Same as before.
> 
>>          kprobe:btrfs_discard_extent {
>>                  printf("freeing start %llu end %llu num_bytes %llu:\n",
>>                          arg1, arg1+arg2, arg2);
>>          }
>>
>>          freeing start 5259264 end 5406720 num_bytes 147456
>>          <snip>
>>
>> Fix this by avoiding the discard command to the readonly seed device.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reported-by: Chris Murphy <lists@colorremedies.com>
> 
> The fix looks good. Don't feel forced to address the style comments
> above, consider them more a recommendation for the future.
> 

Yep. Thanks.
  Also, I have missed the re-roll count and its log here.
  I will just mention that here.
     v2:
        Fix commit changelog.
        Drop a code comment.
If David needs, I don't mind resending with these changes.

> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>> ---
>>   fs/btrfs/extent-tree.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 7a28314189b4..f1d15b68994a 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -1340,12 +1340,16 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>                  stripe = bbio->stripes;
>>                  for (i = 0; i < bbio->num_stripes; i++, stripe++) {
>>                          u64 bytes;
>> +                       struct btrfs_device *device = stripe->dev;
>>
>> -                       if (!stripe->dev->bdev) {
>> +                       if (!device->bdev) {
>>                                  ASSERT(btrfs_test_opt(fs_info, DEGRADED));
>>                                  continue;
>>                          }
>>
>> +                       if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
>> +                               continue;
>> +
>>                          ret = do_discard_extent(stripe, &bytes);
>>                          if (!ret) {
>>                                  discarded_bytes += bytes;
>> --
>> 2.29.2
>>
> 
> 

