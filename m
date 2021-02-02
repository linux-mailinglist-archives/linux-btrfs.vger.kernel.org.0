Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488530BD7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBBLya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 06:54:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBBLy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 06:54:27 -0500
X-Greylist: delayed 1507 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 06:54:25 EST
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112BO7FX009364;
        Tue, 2 Feb 2021 11:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=i51biKQpzoF9ohKms+uRXMvnydhLVFDu7NNMxBqC04E=;
 b=oMhSPxfBtqHGeiXxtusYhLrnjRlt0Jr18dVHHU4Zh4ZWvungoM1KAMRdru+mk6GKYDXQ
 GMYC7ggPk7dveGGWBuipPszeq4URroZg+J3UKdt4+mS20Rb7w9G6HJefJcDMrE7wevX5
 7eI63MLufqtBxRWHdFXmvI+PBKGFVu8iH/lw91ypWWYfDu4OnAlaUaZX5a+BNdTHlLmI
 40YHvW4k+OIs2oV8fUbzyPMf1ckDB/FVStGJT05BAd1ABNL0SZnKhT0dOWzvCGOR1Vl+
 4YklUTA0O6l98CdYFfR9tIpHhBzPm+QmNALmxA1epqR1hJdgDL8SSz+Ie/tsLQmm2auw bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36dn4wg5sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 11:28:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112BQqTC010354;
        Tue, 2 Feb 2021 11:28:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 36dhcwh66d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 11:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXW7xf7jk2jpoueFzVB3/mLiEZyX9Sacab72y2aXpmWoZo2vZWWoG/nruMypj2xmw5+k7e14//Vs+zYDRn+KrfW2L9HcSb1866lrgDUMfz1AjpsauBMDGC2jjXXSeHlLUvzFpVlt5YfnaTGFxp23xu65uq1lnSBGBXlO4UhqmAB2ysVf/Ug0slMVu3KhdqNzSGsOXqhIWALQHqM9rI3HJ8OXKzleE4X+p0Tk6vcCICkLNpGK9MhEOqhQvj7gU4Xk8tcgc+yL+w3g9KlUbpHVWeXWFisgRCemYVeGO8cuHlk0nRouOCt0wO8xjBL8qd0PBJOsA677w36Z/jJxMBlkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i51biKQpzoF9ohKms+uRXMvnydhLVFDu7NNMxBqC04E=;
 b=Iae9fWm54t8nWdr0KmmV6fRPbTvVhQEoWjsr7Gi/pF+DHvDpzdMunPkYTKMhQjkhtrldFY6GtJRirCwigkF/GEpmmkSBEhdjFZ7OLfkMx92PtE8KZl4XVqmBsWvn3YqRp3kQqN8AYzxaxtCWHD7RAmx/NPOrI/B4CrK+YIOb/V0HJPQRXKc1AWMps3m97uZt7Cq0gbQ83FNSRaMZeuhx/RoZ+Ezs9tSPUzsE30sD6iUeH5C3DxaoXtPGM1BhIT29dRD8U8m/eCSNrN0hIAuVnDesiodZsyXuPtkutSAxRiS5GABCPWcwpMHn8x+oXyM3IQkexwowkGH92YtzM8MsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i51biKQpzoF9ohKms+uRXMvnydhLVFDu7NNMxBqC04E=;
 b=vwgbrr71dZGHwxZXXbOWsbBWOKL7rooTQm51Nf5gk32cnYmG0PlgEuSUXwSt4rwUtu+zqVNgdv8tZsJRVVGJfgfAG4xHlqMCoIv8HEvn98nKsmYc+xmQxSuIyhd6VL9ouZDEi8Wx35+JdIR/43k8hVH81U+HkuESCwxY9iaucbM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 11:28:29 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 11:28:28 +0000
Subject: Re: [bug report] Unable to handle kernel paging request
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
 <d55afd47-189f-e0a6-5577-0e89dab9e37d@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <913e7523-5700-27ad-4045-200d83e37deb@oracle.com>
Date:   Tue, 2 Feb 2021 19:28:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <d55afd47-189f-e0a6-5577-0e89dab9e37d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:594f:b4bd:cd09:1ee4]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:594f:b4bd:cd09:1ee4] (2406:3003:2006:2288:594f:b4bd:cd09:1ee4) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 11:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc6a9a9-c2ac-4c3f-e492-08d8c76da996
X-MS-TrafficTypeDiagnostic: BN0PR10MB5191:
X-Microsoft-Antispam-PRVS: <BN0PR10MB5191AE0ACB3C14B13BE552C2E5B59@BN0PR10MB5191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgcvwh8sgTPDNWgbM23+N30UNeiyM3AaXoZfU0ovB5JdBp7zBad/vwMg5mR4Z7AL54LzdxnzPkoQyY8HfjTkQWYSK5TkNJUD623mAxU30lWKxUJKrNmGui+CMPo73GnRc9s/1vOJh/X6mmYdaOG/WuRK5LeuOP4XsPrNLS22OYdjwGWGityM7egBXGvkCWXE2aPURPx/LqC5S7JtkZPhK/BC5RkxOurBndp/74SknKyGxqwWMnXV141sWSWuOCVoPueE4HNL/X0xO7hUUqVVbEFY/6Gr8oc8O5P9Tx/IzdLlHIfa67BOEMnoXrjw8ycgLPyzlZ/c7h5qrvZNmrpCm3NVXVXxvDNv6xzHqlN1V783JlhkvGf5BUT7zdDn8ZEeDtxyr7Ly0CIYdOA4/YwCtWET2lVD/fKXSwzry1pvlRbQfopaiuxEkB5ppbBsm5QVOc8jyI/ur3X0eKBtx6TVbnlFTDzJISwG2vDlj5I8Tr0oUwTz8aPk2C+Gz2H9V8oo1EKUsizEzjAIF8lD8BKxbwc8Jjj/giwADJtXoO3H4eqN48/TwT2gepIaFKlqMXKFiV49qDnRW9qi7bRMoZFBa6Y7tYxxEh5cjlVpZmAEw2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(396003)(366004)(2616005)(31686004)(8936002)(53546011)(44832011)(66476007)(5660300002)(6486002)(86362001)(83380400001)(478600001)(66946007)(36756003)(316002)(2906002)(31696002)(8676002)(110136005)(186003)(66556008)(45080400002)(6666004)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEhDZVJPYmJ1Z0Q4aG1JclV6bnNEOEVmN2QyVk9NUjFrbWMvbEVTM0xtUk1u?=
 =?utf-8?B?RG45dlpFaUN4NmJqS0pOVHlBRHhFcmhoblplRUt6V1BKalRwdG1Rc1JPcFFJ?=
 =?utf-8?B?SkdRcFpWS3R1ZFNaZE90TDlHamRPODdMS2V1NGNnL1h6ajNoNjFpQlRQUERw?=
 =?utf-8?B?VmdoSFVlVzBBejcwWkRFaGwwMG5YZzN6bUYvcTk1UmxaMU5RekRjc2phekFu?=
 =?utf-8?B?TTF3Q2h0ZlV3SExiUmFxZ2F3a3Q2dUJydGdoV0hQL2YzYUFEU3hWZTZ4OG83?=
 =?utf-8?B?U0NKUnArRnpKT2ZudTAwck5mRkVvR2phNTU2L0s1RVY5aGV5cVdGeDRmVmV1?=
 =?utf-8?B?U3BMR24xUSsyYjFGWXU4d1lUektMc3EvSHBjczhPcllSV0laUE9SVjJ6T096?=
 =?utf-8?B?VFZ6OUh6dUV4cVo4R01pcy9GMUxuU2ZhYVpmKzBZcWRSUjlzdWIxUlJqbXRr?=
 =?utf-8?B?YUtndi9UQW5mYjdzNkJmSVo3Y3kxai9IVVZCeVVuNmhrMVUxSjZXRDltZ3RO?=
 =?utf-8?B?MTFuWjlIM2UralBURDIvbVNxL3ZwZkpPV0NObkZ0Z3RNTVNLN2lId2hJSTJ1?=
 =?utf-8?B?aW9MZm9MSFNYZWE1cmdpZzE5a2JHOWIzWUpkdkNoTFNwYjREditBSndVK0NN?=
 =?utf-8?B?SG5DdmFsbjVlbUk1dzVDd2JwSzNqb01ySUNFR2Fpb0JncE5laEFvRDFPNDdV?=
 =?utf-8?B?UysrRkRtMXNzL2JJNnhLS1pYOGhzKzIvLy8zS0FDRlovSGRCRVZhOStYN1g3?=
 =?utf-8?B?QWZuUHJIMGpwNDZaUU0vWkx4UG96MFVnQTVJdThNOGxBLzk2bGNFV0xYVnli?=
 =?utf-8?B?NHc0dWk5Z0pYN09mUjlqNDJsZVZVYXYycC9tT3YyNGE2TnJaVjFXSkpDRjhm?=
 =?utf-8?B?UHFNbFRlM3BxelhMMmF4MmdiWFMzM1BsUXlwQzc4R3N5b2s2SERXVjdONzhL?=
 =?utf-8?B?OXpRRGp1Zmk1T2llaGdkbHhpTUZJOGtpM3VmK2JUd3FxaTd6Y3E0bWNGcWQw?=
 =?utf-8?B?TXJzS1BXQU9VU1JjT1A5SDF5UHNwa3JZaHUvUU0xa3hiR0tPbjdBUkZjbE1D?=
 =?utf-8?B?UHQyS1ZqMElLckVyTnRhR3VoT3JjMjh6TjJDVElzZ2VoMG13VlkwOVovUEdG?=
 =?utf-8?B?SVVJRi85NlJFdEtib2F6ck9mK3dCYm02U0VESC9zMndWVDNaUng1NFp3aDAx?=
 =?utf-8?B?Qk9DakdWRU5UWEw3cUNjSDQrclFINUhkKzdOaWQvSHlwQVIyb2IvQ3d5ZkVI?=
 =?utf-8?B?WjNKSGlEbklmWG9DSE81QnBCZjlOSWdBQ0w0ZFlkZUFNeTBtTnR3NzFMdFhD?=
 =?utf-8?B?VGFacm1ZVHRGTkpTeVBRVTExY2t2blpqandvNnkybEExSGExTCt3TXdPNGJs?=
 =?utf-8?B?UXMwU0RXelF3NHNzN0JnSW5IeTRTSmJTTmIvTlZJN2xGQ1piVzFIS2x0NW5P?=
 =?utf-8?B?K3JqbGNjVDRabGFXV0tmQUtBRy8vQThEbmZ1dWRRZnhhUklHd3pzOEZSUndn?=
 =?utf-8?Q?hXIT6ONY7aF3NUH7hlwp1fwrKjH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6a9a9-c2ac-4c3f-e492-08d8c76da996
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 11:28:28.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmW2GjSjRmYwjAdi36lNBH8MxyyXxZiohwtHsaOVSiVli8sFAolmT+22+w1i2RwFXvy6kqM6eYFbobdrDgNQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020079
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/2/2021 6:23 PM, Qu Wenruo wrote:
> 
> 
> On 2021/2/2 下午5:21, Anand Jain wrote:
>>
>> Qu,
>>
>>   fstests ran fine on an aarch64 kvm with this patch set.
> 
> Do you mean subpage patchset?
> 
> With 4K sector size?
> No way it can run fine...

  No . fstests ran with sectorsize == pagesize == 64k. These aren't
  subpage though. I mean just regression checks.

> Long enough fsstress can crash the kernel with btrfs_csum_one_bio()
> unable to locate the corresponding ordered extent.
>
>>   Further, I was running few hand tests as below, and it fails
>>   with - Unable to handle kernel paging.
>>
>>   Test case looks something like..
>>
>>   On x86_64 create btrfs on a file 11g
>>   copy /usr into /test-mnt stops at enospc
>>   set compression property on the root sunvol
>>   run defrag with -czstd
> 
> I don't even consider compression a supported feature for subpage.

  It should fail the ro mount, which it didn't. Similar test case
  without compression is fine.

> Are you really talking about the subpage patchset with 4K sector size,
> on 64K page size AArch64?

  yes readonly mount test case as above.

Thanks, Anand


> If really so, I appreciate your effort on testing very much, it means
> the patchset is doing way better than it is.
> But I don't really believe it's even true to pass fstests....



> Thanks,
> Qu
> 
>>   truncate a large file 4gb
>>   punch holes on it
>>   truncate couple of smaller files
>>   unmount
>>   send file to an aarch64 (64k pagesize) kvm
>>   mount -o ro
>>   run sha256sum on all the files
>>
>> ---------------------
>> [37012.027764] BTRFS warning (device loop0): csum failed root 5 ino 611
>> off 228659200 csum 0x1dcefc2d expected csum 0x69412d2a mirror 1
>> [37012.030971] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
>> rd 0, flush 0, corrupt 9, gen 0
>> [37012.036223] BTRFS warning (device loop0): csum failed root 5 ino 616
>> off 228724736 csum 0x73f63661 expected csum 0xaf922a6f mirror 1
>> [37012.036250] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
>> rd 0, flush 0, corrupt 10, gen 0
>> [37012.123917] Unable to handle kernel paging request at virtual address
>> 0061d1f66c080000
>> [37012.126104] Mem abort info:
>> [37012.126951]   ESR = 0x96000004
>> [37012.127791]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [37012.129207]   SET = 0, FnV = 0
>> [37012.130043]   EA = 0, S1PTW = 0
>> [37012.131269] Data abort info:
>> [37012.132165]   ISV = 0, ISS = 0x00000004
>> [37012.133211]   CM = 0, WnR = 0
>> [37012.134014] [0061d1f66c080000] address between user and kernel
>> address ranges
>> [37012.136050] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [37012.137567] Modules linked in: btrfs blake2b_generic xor xor_neon
>> zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
>> [37012.140742] CPU: 0 PID: 289001 Comm: kworker/u64:3 Not tainted
>> 5.11.0-rc5+ #10
>> [37012.142839] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
>> 02/06/2015
>> [37012.144787] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
>> [37012.146474] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
>> [37012.148175] pc : __crc32c_le+0x84/0xe8
>> [37012.149266] lr : chksum_digest+0x24/0x40
>> [37012.150420] sp : ffff80001638f8f0
>> [37012.151491] x29: ffff80001638f8f0 x28: ffff0000c7bb0000
>> [37012.152982] x27: ffff0000d1a27000 x26: ffff0002f21b56e0
>> [37012.154565] x25: ffff800011df3948 x24: 0000004000000000
>> [37012.156063] x23: ffff000000000000 x22: ffff80001638fa00
>> [37012.157570] x21: 0000000000000004 x20: ffff0000c7bb0050
>> [37012.159145] x19: ffff80001638fc88 x18: 0000000000000000
>> [37012.160684] x17: 0000000000000000 x16: 0000000000000000
>> [37012.162190] x15: 0000051d5454c764 x14: 000000000000017a
>> [37012.163774] x13: 0000000000000145 x12: 0000000000000001
>> [37012.165282] x11: 0000000000000000 x10: 00000000000009d0
>> [37012.166849] x9 : ffff0000ca305564 x8 : 0000000000000000
>> [37012.168395] x7 : 0000000000000000 x6 : ffff800011f23980
>> [37012.169883] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
>> [37012.171476] x3 : ffff80001638fc88 x2 : 0000000000010000
>> [37012.172997] x1 : bc61d1f66c080000 x0 : 00000000ffffffff
>> [37012.174642] Call trace:
>> [37012.175427]  __crc32c_le+0x84/0xe8
>> [37012.176419]  crypto_shash_digest+0x34/0x58
>> [37012.177616]  check_compressed_csum+0xd0/0x2b0 [btrfs]
>> [37012.179160]  end_compressed_bio_read+0xb8/0x308 [btrfs]
>> [37012.180731]  bio_endio+0x12c/0x1d8
>> [37012.181712]  end_workqueue_fn+0x3c/0x60 [btrfs]
>> [37012.183161]  btrfs_work_helper+0xf4/0x5a8 [btrfs]
>> [37012.184570]  process_one_work+0x1ec/0x4c0
>> [37012.185727]  worker_thread+0x48/0x478
>> [37012.186823]  kthread+0x158/0x160
>> [37012.187768]  ret_from_fork+0x10/0x34
>> [37012.188791] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
>> [37012.190486] ---[ end trace 4f73e813d058b84c ]---
>> [37019.180684] note: kworker/u64:3[289001] exited with preempt_count 1
>> ---------------
>>
>>   Could you please take a look?
>>
>> Thanks, Anand
