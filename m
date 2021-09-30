Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8708F41D0CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 03:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbhI3BEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 21:04:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54718 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347528AbhI3BEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 21:04:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U0PSAO026134;
        Thu, 30 Sep 2021 01:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ObD8vBk1sgxlzHwMu+lPOi/NzjjY2Vnuld7RHSYVp7M=;
 b=l9rurYgbE4BK0s9NDyXAEHS0WiEsuqa2/rgovbT/mZHLy7sOwlvDjpEhlyWSdOesdRcF
 RflOQK2qaUD9dho9Q+clnaOJDVCW8dPq0XvE00ReUT0LX4X+/fFmluc8K9LcJ6OuywKx
 RAxbSRusl7tvbKn/xdHdoEcLgerpdao+Uz3IcLwCDGyQZeOBXDr4GU/s5ZBqTKPfOH8s
 /c2mmCfcczDy7Zd6+Kw4l+HNn2twKERe4n0VwvZBJYI3cUj2kvc+cJnKoOp189J/hoEB
 iOReL0IS3+o66NValJzP/da05b2BjTv8ZXL4QA6XMJTY5AsuZ2IkeHLHd+WHGPDYXAoO 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6d029a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 01:02:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18U11i2M117922;
        Thu, 30 Sep 2021 01:02:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3020.oracle.com with ESMTP id 3bceu69t15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 01:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrVS0XHQb2mYqdzHJ3cEUN4jSwAas3ruNveYIxBbyfwRL7B9kJqUz8e6D0hC2/z/Ir+DljMKTwMseSpS17vnphtW6YrDGBkaaG0Th0ws9Hk6jlpxudVrdfPeI25MdAdv+Gi8neGM1GfqSbXrZ+KCMY/dmJkx3Nd3uRMUud8ZmKm5XgcFUeI55NvJyNnIyzxaKzRdhdNncEWSq6Oh3cyidVbS0k1n8Zro7WPNY7lbxOhS33UPy9HcK4mgwIkUR+uOd9PxSTacFOhjJxRuasWYf9GaXu9/hOlWKNDFNSXgmClD59EmM1mSnL48MA8FY6FaY9YhCP0TB1Mn26XEspOoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ObD8vBk1sgxlzHwMu+lPOi/NzjjY2Vnuld7RHSYVp7M=;
 b=PTah/dd3b1fcP7Qqj2ORXJ8Eb1zY4vLoxH3VujpIifmas2OLIvU7po9CAFZyyPWiH4E7t/NSYnmR0XDs/G+JwLVJY7vprTS1qPuvEzZIkTN7vaf7COhcryPM0A1wmx23F19VKGT/lXyfsAzjVFbf16rgZ3dzKdrjMqyJwqF01K5dvjyGhkM/TjPlmm+F/LZAGW2FgbqXr3ZS3yxR678b1XtSW9Pkb5JwNNtWy9cS0eFagaIA8iTu6ipX1Q1GD1DKDF6Z8LXf4R6uAUTEyxLxmyxB3TwuY4S7SPFXRM0sNafJUfla16tOq7073dl+LbPzMIoQKrDRkv6mrk9TUPqgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObD8vBk1sgxlzHwMu+lPOi/NzjjY2Vnuld7RHSYVp7M=;
 b=PR9cLcDQ/y+AUt9iPZo0fhsLVfEf0Dbl7VKz7fMs/wpmTyidHopa8Ssood7+tqqb6wc6wNgdJIi4DnoK5D12CZ+P3EGqhM0UDwdGrULQ7k7QWZdP2mi0CFgBUDV6NOr6vJjaYxrHxi1rUrBSy4ynWDCbfqGRo/l0Eps9noHxLxQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 01:02:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 01:02:37 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
 <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
 <42ce59f6-4458-5cf9-351e-7fa81d62ebf5@suse.com>
 <c2828ccd-80a2-a7c9-0282-bb58046375c3@oracle.com>
 <02fed018-c02b-6c7b-f7c6-63f25d3743d1@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <025d1ac9-fe16-b427-cba0-40813147d9a7@oracle.com>
Date:   Thu, 30 Sep 2021 09:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <02fed018-c02b-6c7b-f7c6-63f25d3743d1@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 30 Sep 2021 01:02:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7302f8f2-32e8-4863-a108-08d983adfe6d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5187:
X-Microsoft-Antispam-PRVS: <BLAPR10MB518715EA238820A99B15070DE5AA9@BLAPR10MB5187.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXTeBVdLvb3nCJQGxO0bE9Dkz06RUmWObuITFkKinjJT9c7ufhOnuKiPtRCJCVvemhVCAVXgQd2F3SxI4O6HeYnsPEDtE4VCBJ8bwXzVgrxqS8Ff/cKBrrF287Dxp8x1I6RsaOgVtMF/6Lu+/c4rdUWJqV3sBpLYMjkO5esyQ8tleupelvgpIMn+hKt+rPRnbqrMtsNRY32t1qbpRUyuJkVLUPtrweBWHXKUo7H8jaH7ZjnmbfpOJFNnO4yVKxLu1ePRkjgJElnZmflEiIRJY7brdh5CjAm+RtyWQa6gbi2HO72gpLhMUOhvWfmpNWkntJoHX85f+xSb8LZQJvgL5RQRHPf7H0ZOWDzmkqFrem46xrZ4KknmEZVa+RVCZlFTdkB+CMyXr3AA9cATBrxFDSn48IOLPxhRVtHM/NbBQHG++vtRvRhgyi17rY/eyOcNmDdG6NPBIAlUpJ1/QYmLDv8K1sQR90v6MEbPrSp2rRTElU1Ew+GK9A8IJt2luW1+qpsIDlobEefNElVz/oiFNCHwWzxBoMopLl0V60Sqzq/Wq/7IIHiw57O42ov8p0PabR5zE45H/iu2FVEem8uKJCiigAveCzrw2BnUbang2YBS4y22GxGSL/DK7O7QZwR1wiAbwQeCdyacDjbxYrTVm95wcnRTpgCUj4AlUcQTcl0bLbufp/JfGrPYCuc/+HXCqf5lT8Wivz7UPrKZ588ozaKSik3kZGm9wVKK2Zq2UpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(26005)(2906002)(186003)(956004)(316002)(16576012)(8936002)(44832011)(8676002)(38100700002)(6666004)(36756003)(83380400001)(53546011)(31686004)(508600001)(66556008)(31696002)(66476007)(86362001)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjR6b05JM0FYVDlEczBSVUtRRU16SmxjWTVsY21BRTdNZW9acnVKVXVGVjZn?=
 =?utf-8?B?bXVXb05BWUNQbUQ2eFlRNndEcVJvNHA1Q0xTUS9xaWpTWkFRd21ycVVNTXRa?=
 =?utf-8?B?ZERXSlhQN2hLcUQycUpkYk9JY3RqV0M0ei9UTUZWeGRRN3JoSklzK1ZvR2xY?=
 =?utf-8?B?U1VnTTJYY29aTW4wM20yd0NYRGpkbStzYllwQlFlZUE2bkxoVFp0ekJXcjdF?=
 =?utf-8?B?aE9sM3VKNTc3c0JIeFFURjRCc0ZUa0J2b290Z3graVJMdE9hN3RmVUsrRUYx?=
 =?utf-8?B?eFBRSXZDYnhCT05RVXpNTEp5b2xFNDNRYXF5N1dzUHg5STc3ZUs3cTNwMFFy?=
 =?utf-8?B?MHN2ekVaQVlBQVNaaGJrSU5leFZtT0thcTRlWHp5OEtRZGh5c3VmcEVaK1VT?=
 =?utf-8?B?ZU1vSHVmeW1pOS9xeEh5YUlNUWNMYkovUkxxQUxERzBnZ04yZlRjSmo1WXJE?=
 =?utf-8?B?QkovNjNSWjdtR045VXc2cnRNSyttaFphRmdMSFdaRjMyTTFwbkJLUHNBZVla?=
 =?utf-8?B?TlFNM0JXMyt6ZERYK2JSemYvYkJ1dS9yWC9NOUtqUXA0WUFGMTRzTnhtbmFz?=
 =?utf-8?B?NUllRHVEQ0N6c241Q0J4MXNoRXlHMGRmVzhBWnRGc1E5c3lvRVEwQng0K2pw?=
 =?utf-8?B?b1UvRzZQQ2thYkpEdzFBZkFKc0IrdFRTTGIvRHltWjZua2tYTXhXb24rMlB6?=
 =?utf-8?B?bEdNZVhGZmY2UG1BenFPWmE1Vlc2Yk9kd2RaL3FpN2p0Tjhwc0FTTk5ZNkg1?=
 =?utf-8?B?aW5EYXF0cHpFNjljSG1Ha0Y1Vy9UMzlwOEplb2o3YTJCY3JrbUxYZzJ3K000?=
 =?utf-8?B?VXFRVzE3NysxeTVEKy9zQzlUR3BYc1I1Rzgwd0RhR2h6dGJhVFJHU2s0cmFL?=
 =?utf-8?B?dDNDazNRdnVTeDE5cXJkb1pFYkp5ZHBuVTdZMTFzS1FnYXdZaHBBZkFJY21l?=
 =?utf-8?B?NGJDVHB1aHoxdG43V0tvRlVKWURtMVBkV1Rtek45V0lramNrSFZLSkhlbVRs?=
 =?utf-8?B?bVlnejB3Zy9EaHlJSENHcmJtd0RwdE9wblIzOGNWVE9QVklteEdDMm9IUjlJ?=
 =?utf-8?B?dlhIVVBIZE81Y0FQSmZHM2l6ejNRWHJXNmN2OW5La1ZsTFlzQUxnemxIcWRO?=
 =?utf-8?B?Y0RsMWhZNFdLbitaMGJRM280OVRiOGpqazZOUUtnWk03WTVKTHpCakhjZGxs?=
 =?utf-8?B?T2JqVE8wNFNHSWxuWmVNM3R3R3JvekRldkx1RmM4RzNoNlFUa0lsd0oxZlFh?=
 =?utf-8?B?TE5GczFpY0Y3MmtaUUtiQURUckFydzZidzYwdE5DeFNOWDRKWmU3R0prUWw5?=
 =?utf-8?B?eGZNNjlBR2RJZW9VbG1XZUpnaDhVQWk5L2ZwUWtBaXAzbnJ0MWJDR1Vac09G?=
 =?utf-8?B?K3Ivd3JEYXpkaGRjZStDYkdFdjJVeGZ5QlcvdjVoN0crK0dBakhjS1o5NWRu?=
 =?utf-8?B?YjdKbkgwaXpMc2FsVnR6WjJrK1pFTjJDTXNidHlyS2MxbEdDa01zbm4zUzdF?=
 =?utf-8?B?UjJHaGxNQXBZQjVtakR2QWl2VWp2SGhSdERydWhJclBqUnhCUFp0RUM2aVE1?=
 =?utf-8?B?bkNMbXI1NkRjaHRiMGpiQSszdWZPVjBpQVZSNDA4cytINlo5VjNEaUg5SEkx?=
 =?utf-8?B?V2c4S0JnMnpxOXB4c25IZVhHVWowQko1NFF0TnNlYTJsdDZkV1dQZ2NiQUt0?=
 =?utf-8?B?ZlBZSlllaDQwVzlDZ0lISFppNkUzYlZvaVA0V1hCRmFOd2FUOUFJRkxnZ2hY?=
 =?utf-8?Q?bl7uEeU3ywhAcanHpGuAbVwUc39nWyX82zepDJK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7302f8f2-32e8-4863-a108-08d983adfe6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 01:02:37.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSReR6wMPGfQCUkgfX1vXvsyUym990UMDusgsBz+rbPfuupjVQxwWg71eILio7PxS5P0b8RlSLTIrgm5CK3cjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300003
X-Proofpoint-GUID: npsRZo3udUGFGENDe2jxA-l4PP3RXpM-
X-Proofpoint-ORIG-GUID: npsRZo3udUGFGENDe2jxA-l4PP3RXpM-
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/09/2021 20:51, Nikolay Borisov wrote:
> 
> 
> On 29.09.21 г. 15:44, Anand Jain wrote:
>>
>>
>>>>> flap means going up and down. The gist is that btrfs fi show would show
>>>>> the latest device being scanned, which in the case of multipath device
>>>>> could be any of the paths.
>>
>>    But why the problem is only when a device flaps? Or it doesn't matter?
> 


> Because when the device re-appears it will be the last device scanned by
> btrfs scanning code.

  It shouldn't be so fragile that we merely depend on the order of the
  btrfs device enumeration. Device orders can be random. It shouldn't
  matter. Even if it is working fine before the disappear-reappear cycle,
  it is just by luck.

  To show the list of btrfs devices that are unmounted, we use
  btrfs_scan_devices(). In btrfs_scan_devices(), we extensively use
  libblkid to enumerate btrfs devices. Few important lines of it are
  as below.

-----------------
367 int btrfs_scan_devices(int verbose)

<snip>

381         ret = blkid_get_cache(&cache, NULL);
382         if (ret < 0) {
383                 errno = -ret;
384                 error("blkid cache get failed: %m");
385                 return ret;
386         }
387         blkid_probe_all(cache);
388         iter = blkid_dev_iterate_begin(cache);
389         blkid_dev_set_search(iter, "TYPE", "btrfs");
390         while (blkid_dev_next(iter, &dev) == 0) {
391                 dev = blkid_verify(cache, dev);
392                 if (!dev)
393                         continue;
394                 /* if we are here its definitely a btrfs disk*/
395                 strncpy_null(path, blkid_dev_devname(dev));
-----------------

  So, you mean to say the blkid_dev_set_search() always finds all three
  paths containing the same fsid+uuid+devid?
  But, only its order varies when the a underlying device disappears and
  reappears.

  For example:
   Device order before /dev/sdb disappeared
    /dev/sda  MAJ:MIN??
    /dev/sdb  MAJ:MIN??
    /dev/mapper/3600140501cc1f49e5364f0093869c763  MAJ:MIN??

   Device order after /dev/sdb reappeared
    /dev/sda  MAJ:MIN??
    /dev/mapper/3600140501cc1f49e5364f0093869c763  MAJ:MIN??
    /dev/sdb  MAJ:MIN??

  Could you please help to find the MAJ:MIN of the devices before and
  after the disappear-reappear cycle? Are we sure the reappeared device
  has the same MAJ:MIN as before? is it shown as a new device? If not
  then it could be block layer problem too.

  So as said we shouldn't depend on the order of the device enumeration.
  Your fix makes sense to an extent but, still depend on the device
  order of reporting. Let us say we dd a device to another device
  then, btrfs fi show will show the last enumerated device by blkid
  (I think). If yes then, it is wrong.

  Could we make it order neutral? I don't know how. I think the only
  choice is to list all the devices in a tree format. Similar to
  lsblk(8).

Thanks, Anand

> It can be reproduced by following steps: > 1) Validate 'btrfs fi show' is showing /dev/mapper/xxxx for all fs's
> 1) Unplug one of the cables from the FC adapter < this can be simulated
> by simply doing 'echo 1 > /sys/block/sdd/device/delete' for the given
> path device >
> 2) Wait for the paths/drives associated with the downed port to disappear
> 3) Check again that 'btrfs fi show' still lists the /dev/mapper entry
> 4) Reattach the cable to the hba port <this can be simulated by
> rescanning the HBA or w/e bus you have: echo "- - -" >
> /sys/class/scsi_host/host1/scan >
> 5) Check that 'btrfs fi show' is now shows /dev/sdX devices for all mpio
> fs's
> 
>>
>>>>    Do you mean 'btrfs fi show' shows a device of the multi-path however,
>>>>    'btrfs fi show -m' shows the correct multi-path device?
>>>
>>> Yes, that's a problem purely in btrfs-progs, as the path devices are
>>> opened exclusively for the purpose of multiapth.
>>
>>   Ok. All parts of the test case is with an unmounted btrfs, I am
>> clarified, now.


