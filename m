Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A874030BFC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhBBNk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 08:40:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhBBNiu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 08:38:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112DTpjF132169;
        Tue, 2 Feb 2021 13:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oM3oyJfKtwzR7CFADTZOU6hRBoYQ7h/zfxVRUQ8HH10=;
 b=wTzUkTZTtANI/QDxvc6gCHRyj6SH/2OQyPU0GGae36HRzpIX+4C/8ZqzN3keDlvA0Cxo
 Ldu/myhm4QeJ8ociYCo9KLyywHbvhaSjqrLzQCJEOVdEmCd87yqJp69sPJ3neKrWfo2O
 /VYd0+rJSnB8L5Pki6sN7x8CbyMFJqTsWWm7XNA3v0Cgm9hkmh4ISIWQyA8nGlmtqDrE
 D7DCzWyMdzIbe9YBb3sjZqbysLVcHGjOc2rKOkg3mjsWFFgUJB5QPiIQUeTmUEAzFb9o
 k9+2iPtkPavmrNCugaXXNIulezX+hLBVgPW+H4cwZ9NupY2l5Q1cZlsgA6MjWPpz4V8i 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36dn4wgnhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 13:37:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112DUxUu109208;
        Tue, 2 Feb 2021 13:37:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 36dhby8pbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 13:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVtxis6WFJRC/iUcRfNqEiZ4wYThMlOOz3SW0PBeHAKjiZLWUs2Y/8/iIvuoBFZivRtEMFdmFi8vKJyvWoarDLKSXtKH9FXxcz4tqh3wutf5AoYwWwFQnHMAYZH32cjYLQ7r66xniD5D5SBRlCj3/fWV+cEJkep6Q1Jc0ttPDpP9JktiKerIx0lZz3pq611e2ynlBlL+UbcJS+b61Cr69DekpcB/NPFVIXe0MmfCKUB2sTX5JFjJ1Y7x917qKK3mDJHYK1rEG/ZKhCX3cGUGw4g6kM72fv99rUYuQNK7B31XfTHqzGBjeoFDDfEUjWHJo2ivvkYqhS99h2kdThBxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM3oyJfKtwzR7CFADTZOU6hRBoYQ7h/zfxVRUQ8HH10=;
 b=ivj/X4JPeCST2nPMIdBVn1rsaOXc4BVmk1pkjhaFqeiKxYUUKwbih4XQDMX9TC4MedKW4cgiBNldMDXr6Zkl/x5e7fZawy+hSdA66WsqrV/ZFmNBUxctn8eFTOAqe8LSwdh1GHmVYFH1vx/KS9bvhxsobrI7jF6yaRL4IIVkQ/D1rleUcxcnZ6FNwsrtQiXEreZftzBHq1L7rwnsJVoachP4vB1oB+OAfonfeyxJevrSwb7aHsDXQOuj1U4VUNKGCGxmzuqEnTaPMSRD3auPA5Q8fM5rMnDXfmm5wRqxB2vfBK5he/WFSGj9pyvDjhgikpblpSjw/IcneJvSSShGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM3oyJfKtwzR7CFADTZOU6hRBoYQ7h/zfxVRUQ8HH10=;
 b=bRMnCqPt4HwvlX38jDw6GZSlb5ROwSeLlMmA1uC4D0+sHaBO/W51zyDm44El5d/BmJCjtCcgVdGaQwzFhehp9Ib5KleTl52F2ILaWdd9TAEiWY+c/S/MkV0ZiqY6JseY89HBeb2yQvhsq5d1I7yv+TJeuWBiI2mtmekxQ6jZyFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 2 Feb
 2021 13:37:56 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 13:37:56 +0000
Subject: Re: [bug report] Unable to handle kernel paging request
From:   Anand Jain <anand.jain@oracle.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
 <d55afd47-189f-e0a6-5577-0e89dab9e37d@gmx.com>
 <913e7523-5700-27ad-4045-200d83e37deb@oracle.com>
Message-ID: <91e2bcba-c326-4b5d-6242-e537b38ff455@oracle.com>
Date:   Tue, 2 Feb 2021 21:37:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <913e7523-5700-27ad-4045-200d83e37deb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:2425:cbb2:a031:9271]
X-ClientProxiedBy: SG2PR03CA0156.apcprd03.prod.outlook.com
 (2603:1096:4:c9::11) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:2425:cbb2:a031:9271] (2406:3003:2006:2288:2425:cbb2:a031:9271) by SG2PR03CA0156.apcprd03.prod.outlook.com (2603:1096:4:c9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Tue, 2 Feb 2021 13:37:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b00f94c3-47d3-4d9a-e51a-08d8c77fbf86
X-MS-TrafficTypeDiagnostic: BN0PR10MB5336:
X-Microsoft-Antispam-PRVS: <BN0PR10MB53364E6C2E319E234E3AA5F4E5B59@BN0PR10MB5336.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQkthneZ9j4gWUHN0tcnk89ELRU/9m4riH3+T9tSjzD9QZv5TLWvQZZIxBERRJbCPmnSLON0J2XgkiOeUymjHD/cjYByKVcxrKeueajKEcfCsvkfzY5q2aZoQood1m+RuSxJsSNER4PrXGuRFnn6q4otjfKC30f2DtLOt+e0gcByXlXiNtOeNenJ3OM/nnMJihhbrkgbABBDNNgjEhxFftRv/IQ5xhEOY22mpx7x1qxG8vjn7yQg8DUdgkkWkmeJkOC4ymdik4mY7D5OtVWv6RQdvkO9HZxmNoGHtQBgl9SK8rBNQAn3OSR4HBwfUDF+nX8gIb6q1xd8mMEGxIvWNj4kah/f70QrODB4kitQrFRF15E+Uw5XlvjQr7lipJbquQ7FYehvbnz6LFbHjQlSKiDPO7XCy7sxo8NRWRqfyVWMNLwwvMRv3q77Lx4kT82o3evmcdVHuIQZPCoB4fBwKP2w2s//wPoXZcqMPtI3rPnaPyqENLoT0eqRcEylT4VlaLUmRyvCFIBw7YL6wlOpF8CEblh5Gto1KRsdAsQXQix36F1P5ocrzZUC3IO4qG6aFpaZUxfhte2qOYNXj0rRorfHJVaeYTaE6zXOAFltsWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(2616005)(36756003)(45080400002)(186003)(16526019)(6666004)(478600001)(316002)(66946007)(66476007)(66556008)(8936002)(31686004)(44832011)(5660300002)(31696002)(86362001)(83380400001)(6486002)(8676002)(110136005)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHVZRm9yaFFhYTN6V1lBN1d0UzdiSFhwUmVKWlpLK2ZyY2R5T3AzaGFFY0Z0?=
 =?utf-8?B?ZFpxNlQvQ291bytSVjh3dFBnaXZzSkJUaDRXbTFoYVpja2pKalR4a3A3b0JH?=
 =?utf-8?B?WEdPSExFM01CV29iQXRubFFOZjFZK0RhVGF3WUwycVRqN0puTXpwb1lJbXRI?=
 =?utf-8?B?WHBodnMxdUJta2ZnTG1rUmVpcmtZQUdTWFcvYklkOHNYdTNWSkpzUHFFZHhU?=
 =?utf-8?B?cWhNaEJhNy9yZEJiYndzRGtLcVNRUmpoSkx6aU9MM284WmpsY0JJWk0zRGNG?=
 =?utf-8?B?czJYNWdjMTdrdUxMQThLLzFieGloYXBzS28xTCsyN1JPQkJpSDZtSW81dzF2?=
 =?utf-8?B?OE9PemY3eU1NbUNJNVNVaHhZNk84NWxwMWZabzZiS0FBQzEwNWV5bW9aL3VV?=
 =?utf-8?B?QW1sVTBxSUduUUlWYm52aEducWowR2lSbDY4SWxvWGVZaU4vclF1dk10TFRW?=
 =?utf-8?B?TjlFNG1rTHRGYnBjRkdQUjlvZzhrT3Y3RzVBenBZdlRGUkF2UXlmN1pmVHhC?=
 =?utf-8?B?S2dqaUszc0tiNThCMm5FQWEyL2hKaTMyUjlLdFJKVTFXazY0WEtmbERqOVoz?=
 =?utf-8?B?eTdXZjBZMFlXNldBK1NFckdmVGFrWkZEQnFVV3Y5VEp5R1VtZjllUkwvenBa?=
 =?utf-8?B?aW01aFhJSWpIbXNDWjduQWw5RTB4dmttNEhqWUl0aUJmMnVmVUgyNFpMREND?=
 =?utf-8?B?akVwNUc1YXgzRWQ3SFloMVZNcGJYMkFhVDBmb1ZkM09SbStHdnZlaEVUOGlH?=
 =?utf-8?B?UWppdjY3TTMwWjA5cGZwclR3SUpsT1h6QWc4NEYzblFwbnJVNnhzclNoQ3VV?=
 =?utf-8?B?OHp5T2lGQlJ2T1ptUjhCVzlLTVI0L250WnVGSGc2Rld1QlpRdTEzMDZaWEJ1?=
 =?utf-8?B?enZ6WUJ2WGxMKy9GR0RNdEdqRFlBYStFSis5a25RdTNadWJ2d1BxNlZNMlZJ?=
 =?utf-8?B?VmU0MmhkemQ0NFVGL2V4TjJmTHRLU2xuNnNOaitudVljaUpIWDJaNmtFVlFQ?=
 =?utf-8?B?SWhYdkhOWDBQMzRxaFlhWEdiMkp1N3FSV2pUNHZpOTJZSzA4YTdoVjNXQ0NQ?=
 =?utf-8?B?Yi9yVzlXbGI4dmFUWk5DMWZVbGdabnlNNW9SUzI5Q29YWUVBNnp5RStlRUMw?=
 =?utf-8?B?WEwzQ21FTUhyck13VEZPcER6YnlvUkllOVpUdzdlQWQzZDJnNnpsMXl6VDZM?=
 =?utf-8?B?My9xTmRnR1Vja2IvOWlIVjc3N0orZ3d5NXhIZkppb2I4Tk1KOHM4aTVCY1lW?=
 =?utf-8?B?MTQ0Y2RMeTBTUUFwaXc3WHFiQ3NadjNrYy9aR1ZnUm8zcjdhNUg2M0FyQlRa?=
 =?utf-8?B?V2hZbkVhOG5lTXVxcnVwbm1yYVZaUzR4RkN6ZXN5U0VrWjYrK3IrNWc0WCt1?=
 =?utf-8?B?aFV0aXJhSmRlU1RrZXREaGlZWDJFd1Z0TStPTi8rU3JCL0g2dXduWTF6WFI3?=
 =?utf-8?B?MGMyUEFjeUpTalhkTGxTbFJWMEtYbGYrenJZeW1sdkR2Y2tZQk5wOEw5OTJp?=
 =?utf-8?Q?EDhy1rLJzpIeO1vr+jd9tb6+nyu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00f94c3-47d3-4d9a-e51a-08d8c77fbf86
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 13:37:56.5116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3I/Ru2Mdd8ruWB8bYzx7lKIi+7xP7rjBUJhPPVNUtKDS8qdwSisrCsxoPeHKhWJzVqhUlvgADOu2h2BeEOFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020092
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



It is much simpler to reproduce. I am using two systems with different
pagesizes to test the subpage readonly support.

On a host with pagesize = 4k.
   truncate -s 3g 3g.img
   mkfs.btrfs ./3g.img
   mount -o loop,compress=zstd ./3g.img /btrfs
   xfs_io -f -c "pwrite -S 0xab 0 128k" /btrfs/foo
   umount /btrfs

Copy the file 3g.img to another host with pagesize = 64k.
   mount -o ro,loop ./3g.img /btrfs
   sha256sum /btrfs/foo

   leads to Unable to handle kernel NULL pointer dereference
----------------
[  +0.001387] BTRFS warning (device loop0): csum hole found for disk 
bytenr range [13672448, 13676544)
[  +0.001514] BTRFS warning (device loop0): csum failed root 5 ino 257 
off 13697024 csum 0xbcd798f5 expected csum 0xf11c5ebf mirror 1
[  +0.002301] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0, rd 
0, flush 0, corrupt 1, gen 0
[  +0.001647] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
[  +0.001670] Mem abort info:
[  +0.000506]   ESR = 0x96000005
[  +0.000471]   EC = 0x25: DABT (current EL), IL = 32 bits
[  +0.000783]   SET = 0, FnV = 0
[  +0.000450]   EA = 0, S1PTW = 0
[  +0.000462] Data abort info:
[  +0.000530]   ISV = 0, ISS = 0x00000005
[  +0.000755]   CM = 0, WnR = 0
[  +0.000466] user pgtable: 64k pages, 48-bit VAs, pgdp=000000010717ce00
[  +0.001027] [0000000000000000] pgd=0000000000000000, 
p4d=0000000000000000, pud=0000000000000000
[  +0.001402] Internal error: Oops: 96000005 [#1] PREEMPT SMP

Message from syslogd@aa3 at Feb  2 08:18:05 ...
  kernel:Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  +0.000958] Modules linked in: btrfs blake2b_generic xor xor_neon 
zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
[  +0.001779] CPU: 25 PID: 5754 Comm: kworker/u64:1 Not tainted 
5.11.0-rc5+ #10
[  +0.001122] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  +0.001286] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
[  +0.001139] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
[  +0.001110] pc : __crc32c_le+0x84/0xe8
[  +0.000726] lr : chksum_digest+0x24/0x40
[  +0.000731] sp : ffff800017def8f0
[  +0.000624] x29: ffff800017def8f0 x28: ffff0000c84dca00
[  +0.000994] x27: ffff0000c44f5400 x26: ffff0000e3a008b0
[  +0.000985] x25: ffff800011df3948 x24: 0000004000000000
[  +0.001006] x23: ffff000000000000 x22: ffff800017defa00
[  +0.000993] x21: 0000000000000004 x20: ffff0000c84dca50
[  +0.000983] x19: ffff800017defc88 x18: 0000000000000010
[  +0.000995] x17: 0000000000000000 x16: ffff800009352a98
[  +0.001008] x15: 000009a9d48628c0 x14: 0000000000000209
[  +0.000999] x13: 00000000000003d1 x12: 0000000000000001
[  +0.000986] x11: 0000000000000001 x10: 00000000000009d0
[  +0.000982] x9 : ffff0000c5418064 x8 : 0000000000000000
[  +0.001008] x7 : 0000000000000000 x6 : ffff800011f23980
[  +0.001025] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
[  +0.000997] x3 : ffff800017defc88 x2 : 0000000000010000
[  +0.000986] x1 : 0000000000000000 x0 : 00000000ffffffff
[  +0.001011] Call trace:
[  +0.000459]  __crc32c_le+0x84/0xe8
[  +0.000649]  crypto_shash_digest+0x34/0x58
[  +0.000766]  check_compressed_csum+0xd0/0x2b0 [btrfs]
[  +0.001011]  end_compressed_bio_read+0xb8/0x308 [btrfs]
[  +0.001060]  bio_endio+0x12c/0x1d8
[  +0.000651]  end_workqueue_fn+0x3c/0x60 [btrfs]
[  +0.000916]  btrfs_work_helper+0xf4/0x5a8 [btrfs]
[  +0.000934]  process_one_work+0x1ec/0x4c0
[  +0.000751]  worker_thread+0x48/0x478
[  +0.000701]  kthread+0x158/0x160
[  +0.000618]  ret_from_fork+0x10/0x34
[  +0.000697] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
[  +0.001075] ---[ end trace d4f31b4f11a947b7 ]---
[ +14.775765] note: kworker/u64:1[5754] exited with preempt_count 1
------------------------


Thanks, Anand



On 2/2/2021 7:28 PM, Anand Jain wrote:
> 
> 
> On 2/2/2021 6:23 PM, Qu Wenruo wrote:
>>
>>
>> On 2021/2/2 下午5:21, Anand Jain wrote:
>>>
>>> Qu,
>>>
>>>   fstests ran fine on an aarch64 kvm with this patch set.
>>
>> Do you mean subpage patchset?
>>
>> With 4K sector size?
>> No way it can run fine...
> 
>   No . fstests ran with sectorsize == pagesize == 64k. These aren't
>   subpage though. I mean just regression checks.
> 
>> Long enough fsstress can crash the kernel with btrfs_csum_one_bio()
>> unable to locate the corresponding ordered extent.
>>
>>>   Further, I was running few hand tests as below, and it fails
>>>   with - Unable to handle kernel paging.
>>>
>>>   Test case looks something like..
>>>
>>>   On x86_64 create btrfs on a file 11g
>>>   copy /usr into /test-mnt stops at enospc
>>>   set compression property on the root sunvol
>>>   run defrag with -czstd
>>
>> I don't even consider compression a supported feature for subpage.
> 
>   It should fail the ro mount, which it didn't. Similar test case
>   without compression is fine.
> 
>> Are you really talking about the subpage patchset with 4K sector size,
>> on 64K page size AArch64?
> 
>   yes readonly mount test case as above.
> 
> Thanks, Anand
> 
> 
>> If really so, I appreciate your effort on testing very much, it means
>> the patchset is doing way better than it is.
>> But I don't really believe it's even true to pass fstests....
> 
> 
> 
>> Thanks,
>> Qu
>>
>>>   truncate a large file 4gb
>>>   punch holes on it
>>>   truncate couple of smaller files
>>>   unmount
>>>   send file to an aarch64 (64k pagesize) kvm
>>>   mount -o ro
>>>   run sha256sum on all the files
>>>
>>> ---------------------
>>> [37012.027764] BTRFS warning (device loop0): csum failed root 5 ino 611
>>> off 228659200 csum 0x1dcefc2d expected csum 0x69412d2a mirror 1
>>> [37012.030971] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
>>> rd 0, flush 0, corrupt 9, gen 0
>>> [37012.036223] BTRFS warning (device loop0): csum failed root 5 ino 616
>>> off 228724736 csum 0x73f63661 expected csum 0xaf922a6f mirror 1
>>> [37012.036250] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
>>> rd 0, flush 0, corrupt 10, gen 0
>>> [37012.123917] Unable to handle kernel paging request at virtual address
>>> 0061d1f66c080000
>>> [37012.126104] Mem abort info:
>>> [37012.126951]   ESR = 0x96000004
>>> [37012.127791]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [37012.129207]   SET = 0, FnV = 0
>>> [37012.130043]   EA = 0, S1PTW = 0
>>> [37012.131269] Data abort info:
>>> [37012.132165]   ISV = 0, ISS = 0x00000004
>>> [37012.133211]   CM = 0, WnR = 0
>>> [37012.134014] [0061d1f66c080000] address between user and kernel
>>> address ranges
>>> [37012.136050] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [37012.137567] Modules linked in: btrfs blake2b_generic xor xor_neon
>>> zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
>>> [37012.140742] CPU: 0 PID: 289001 Comm: kworker/u64:3 Not tainted
>>> 5.11.0-rc5+ #10
>>> [37012.142839] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
>>> 02/06/2015
>>> [37012.144787] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
>>> [37012.146474] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
>>> [37012.148175] pc : __crc32c_le+0x84/0xe8
>>> [37012.149266] lr : chksum_digest+0x24/0x40
>>> [37012.150420] sp : ffff80001638f8f0
>>> [37012.151491] x29: ffff80001638f8f0 x28: ffff0000c7bb0000
>>> [37012.152982] x27: ffff0000d1a27000 x26: ffff0002f21b56e0
>>> [37012.154565] x25: ffff800011df3948 x24: 0000004000000000
>>> [37012.156063] x23: ffff000000000000 x22: ffff80001638fa00
>>> [37012.157570] x21: 0000000000000004 x20: ffff0000c7bb0050
>>> [37012.159145] x19: ffff80001638fc88 x18: 0000000000000000
>>> [37012.160684] x17: 0000000000000000 x16: 0000000000000000
>>> [37012.162190] x15: 0000051d5454c764 x14: 000000000000017a
>>> [37012.163774] x13: 0000000000000145 x12: 0000000000000001
>>> [37012.165282] x11: 0000000000000000 x10: 00000000000009d0
>>> [37012.166849] x9 : ffff0000ca305564 x8 : 0000000000000000
>>> [37012.168395] x7 : 0000000000000000 x6 : ffff800011f23980
>>> [37012.169883] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
>>> [37012.171476] x3 : ffff80001638fc88 x2 : 0000000000010000
>>> [37012.172997] x1 : bc61d1f66c080000 x0 : 00000000ffffffff
>>> [37012.174642] Call trace:
>>> [37012.175427]  __crc32c_le+0x84/0xe8
>>> [37012.176419]  crypto_shash_digest+0x34/0x58
>>> [37012.177616]  check_compressed_csum+0xd0/0x2b0 [btrfs]
>>> [37012.179160]  end_compressed_bio_read+0xb8/0x308 [btrfs]
>>> [37012.180731]  bio_endio+0x12c/0x1d8
>>> [37012.181712]  end_workqueue_fn+0x3c/0x60 [btrfs]
>>> [37012.183161]  btrfs_work_helper+0xf4/0x5a8 [btrfs]
>>> [37012.184570]  process_one_work+0x1ec/0x4c0
>>> [37012.185727]  worker_thread+0x48/0x478
>>> [37012.186823]  kthread+0x158/0x160
>>> [37012.187768]  ret_from_fork+0x10/0x34
>>> [37012.188791] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
>>> [37012.190486] ---[ end trace 4f73e813d058b84c ]---
>>> [37019.180684] note: kworker/u64:3[289001] exited with preempt_count 1
>>> ---------------
>>>
>>>   Could you please take a look?
>>>
>>> Thanks, Anand

