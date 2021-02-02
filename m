Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48D30BAD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 10:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhBBJXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 04:23:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45798 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhBBJWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 04:22:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1129FnCE188817;
        Tue, 2 Feb 2021 09:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=w26Rlt1DU0b+Pku+lnYjWmYKxVEAWCtuF8QytI3UppQ=;
 b=gWFA/MEt0QhTH04BoDRsWHR1KUPppu/KDnK6sUb6mfsmc8U219sA20iZ2Ufdbg5bJ1c3
 6PCUPXaKl1BI7iy/0mnhnqP11lPWftfeoeR39ldgzMG8ikkpWuuytxUckjsOvNYwSwUH
 pP4NVqfYiuONyIjF6KNQItamJzGv0aNQimkUk9nfdy8CtjfXIe420AsCGQ2zy75Pkfrw
 2ta7i0X6B1pOYkJmGW/SDNxm89RkymNo1V16Hy0bvkq9GYRhzkXmYo/w7ir/lBbs0Yrc
 M4z1NfnxIhI8fT5xzjElHVpvm+m24G3oQO40FHkjC1A5OhqloU8Y3ZonOnBFk72IMPWJ Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyasv7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 09:21:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1129Evpw133782;
        Tue, 2 Feb 2021 09:21:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 36dhbxxn53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 09:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0h4cY9FGqe4rVvANX3yLXltvKp16B+xOG9gZi+sw/d9vIx7TtRcGxNXJ7BoNC/FXWx4iXAqnX8QSKSdavBJbTv9hvImL4/0WNVbZrj7ktxe2y1n/STf20+2vY9cgce3t4NjeaYviVfqmYLjd4tGyMMaqouQL/k8SQQRMmfREs4KvN3SR6jCmc7qfr4pMIXoFJPnzRUsiFI3YLFcuCxzFyTjDNgSgA4iAS72lq7k9jt5IU6wuUMXYTHtVHwUBRZPgzRAEA1hgyjS9FNrUa2hkjHcDH6OZBzu4mAntX+YvWBSqx/R6tjKWJHgOH4STfOjWAlimmduohagnyS6pS1qdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w26Rlt1DU0b+Pku+lnYjWmYKxVEAWCtuF8QytI3UppQ=;
 b=YCA8C7ja1MDNJwPuGfbRmPJvrIr/YouhYrb9r5IcDuDiOlAkX6dHjs0qLSK7b1vnoqFrmBvcTJtmC74jI9lDF+VZkMGAx5oQNYMMio4i14XkjJ8eq2Db8njvtrjArIQ07EwZxkmgPH5dPvk5hDpqA+9Yufi4XXZ1ejZVqmHxiIhp2w8YIolldDw5QMDTRv4KWzWYOuTHfi6RlGp2nOm1KgnWRP8iqG+etoUglNfTg2/2z16o9rdycl2ZlPOpqOgjHkEwfXD9Klzfp7fDspfyCp5LAc5GrT5y09wiAbnuZgE6E4GbGa8Ha0UkoMCV5yVgUh2n9/yecB1Thuh+Is7vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w26Rlt1DU0b+Pku+lnYjWmYKxVEAWCtuF8QytI3UppQ=;
 b=sr/VQjB8Vd2Yo6ndIHbEJMMsQFLS0eeQQESU6eX3QdjP4MzwV9B6RIobMY0Vye4Q3J3osY/5FFbHbXa1WEAH9WdapJ2BHfSb+diqV5S2DDnHdDgOLPPVD0/l8oLqRiSyclksymeaDwCE92+yUL9GMWLT8G8ou3ud7bAW6W5OBNE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3618.namprd10.prod.outlook.com (2603:10b6:408:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 09:21:12 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 09:21:12 +0000
Subject: [bug report] Unable to handle kernel paging request
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
Date:   Tue, 2 Feb 2021 17:21:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:3d13:e439:ea65:32c2]
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:3d13:e439:ea65:32c2] (2406:3003:2006:2288:3d13:e439:ea65:32c2) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 09:21:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa485239-3c2d-4564-6a52-08d8c75be1fc
X-MS-TrafficTypeDiagnostic: BN8PR10MB3618:
X-Microsoft-Antispam-PRVS: <BN8PR10MB361800616A00561B9A17B125E5B59@BN8PR10MB3618.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWDRVkLPB0ywdRiWYjOdzwSeLijiL4nPLEbfn4pep9i+re2SJtL7LXQIJu2REnLO89DRrGIhfZ4e6D948LuwK8UsiuVwGbI1lu/b4axgH4ZgvS96DqptMebzQcONMUSXSMQSMUgBV6WGBZB0v31iPcka1uqmbzLvDmi1Wv4ik/9XhtD/l75mI2fdkinYWkycEHVP0Dbr6h14fVRpNyBOCHJPN8eys91YtxzmKwMR+B6AVEC8f0AlqN5S5KAFgpVE1pVelDL0cKhilfKy6YNHF2LJMZELHuOTzBzypDaWncJrMQM9V/Eg4xuXuX1CBxks13o/cP5NEZN/6E7ew4P5UBUVpplFc+RvyeUJPLlzo1JCC7arJC7LU6cYT5ihGLzQPV6H7D3PZviRj2h6xI2IZEU4ijZU0YczajnkCTE5qCbH/7eZ+7emY3TiqAAVLwcHyCdTBpRwhp1X0yjrGjVpdcZ+tZsJ3AtSnSDPLy262kwrGek2jvyT2le5LB3s/aSxwAvBjKOOuPC2bB5mTyIh/OZxftP2AxyZ6DQMJ4uzf1bT9Q2YiA1skkGFix0W76OGK3g5xt6sbO5LWVHTHuzFOnntHapdNOxVAPCp3m/+y5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(66946007)(16526019)(478600001)(66556008)(36756003)(8936002)(2906002)(6666004)(66476007)(186003)(45080400002)(6486002)(83380400001)(31686004)(86362001)(316002)(2616005)(5660300002)(8676002)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnZNQ3hOSCtoRzY5NndLWmg5VVhNVUdLTUtnWlN2ZGttU0pyOXVGak9qSEl2?=
 =?utf-8?B?ZHdqaUhnSkg5ZEUzQnUzbmZlZWp2eWl0TmQreDVPLzA2YWw4MjllUStMTXpW?=
 =?utf-8?B?cDcrbGtNRU1maHcwQ0h0UEQ0YkpDcWFUU05vYmVvRjFUemlIN3loZHlmQ1ZT?=
 =?utf-8?B?S3UvVEJJS0praWZCRlp5Y1FCVyt6dWdoQ2tEY1VWRHhpNUtsOXkrWFovZFZm?=
 =?utf-8?B?UkJVVmFFbkF4NzJvRkRKeU9sM3pFcUFGcHZlcDVLMlF3eW82NTg4cU5CS1Vh?=
 =?utf-8?B?M1l6QitHNjBFeG4wd1RjQkdNbGd3V2FHT010d01FRzc0cnJRNDhOT3lZQXZr?=
 =?utf-8?B?TTM3K2RmV3RlK3JFUXhpd2pkUVBqZDJXNUc4a1d0TVlzUkdRYncybzJxWHJS?=
 =?utf-8?B?MWhzQk9VYyt0Qzk2c0pldXEzTFRmQjl6ZG5oQTJlV2ZVTlRyS2dFUHhFNFV3?=
 =?utf-8?B?LzVYeWdneVRWQTgrdkpCNXgzaWNGSHJkbzRYVDBwcTRmMmVZYVlMN3ZieVhE?=
 =?utf-8?B?Qm96UlZtejkyU1BVM29LVmtUY2VhMzlOdUZjdjB0a2Q4YW9KTm5YZCtuQjIy?=
 =?utf-8?B?MnV1RGcyR2tydlk4WVBwb2tyRTNUTURKWlJZOC9tekcvZXpKaEZzdldSaVpt?=
 =?utf-8?B?ajlmMDVqRnp2TmpxcU5BMno1NVdJMjdqbllqd2JLakNEVnpUeVJjL25naXQ3?=
 =?utf-8?B?eEpDTDMxbytWRGVvQzlVU0VqemRXU1BpUE1jRVhsM3d0TVU0NFhnNTkxdVdK?=
 =?utf-8?B?bFhKc3VKaEx4K0xldC82MC92OXpwQnk0Qk9CMVBYbWVaTUNSaUpndVFyZmhX?=
 =?utf-8?B?cjQxUmRFbjhSaFMzSTNBZ1VjY3VmeE1kbVZod1F4eU44RTVKSmJISTR4bGcz?=
 =?utf-8?B?S0ZKdUcxWUhXbFErejY5WFdkUkx3MVFnUHQvVjcvc2h2K3Eybkt5TkV4bnJK?=
 =?utf-8?B?NmtYVGtONHIwaDMydmJud3Y5RjFvQTlzM3V3T3dnb2NFbm5MNjhVRHpiODMr?=
 =?utf-8?B?TDBMTE05MW9pNjJxTkt4V3Rtd2VoNFdIcGJtMDdUakhsa0pWWGdzdVV6Wlo0?=
 =?utf-8?B?cjFBNENYSDV2Y0ZmeDU1emoyYW55c2tWMUJrWEZUTDBaWU9UaVJUNDNCdWFG?=
 =?utf-8?B?QmtIQnI1MUQrQ1cwK1VJcVVNNDU4bWtnbGU0V2JPOHdHTSthVU9mWTdmbk10?=
 =?utf-8?B?SDhVODg4MVRaVVFPTzdJYXNCWHZPU3hFOGRhSjZMUTVLaFpGOUVpWWlHcFhi?=
 =?utf-8?B?cVZJSERmVktLYVVwbFcwc2x0L3dKc28zT1lhL0pQWktvb3lpRkNINDJ2OUc5?=
 =?utf-8?B?UzNmRUF3QkdxdFc1K3J4UHlHRmdBeC9PWkFCUlNoZ0orQWhMdkx2Q2R4Qndu?=
 =?utf-8?B?cUpHL0NxdHM4ejZXM1JDWVNUaDgyYWVkQVYwazREZ1V5eVZ0dlZiMVhVdUZW?=
 =?utf-8?B?NVJpOGFCM3h6eEpidllXZ2Q3RTU3UFdNckd0Q09yRlh2NmxaZkUrUFdNSk8y?=
 =?utf-8?Q?QXA+6OSGu4K76r+ppybz5/y9nA7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa485239-3c2d-4564-6a52-08d8c75be1fc
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 09:21:12.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQcIDhO6BhrY+oIB5vJ0z9d/Wq5/hWVyZdoxnG40i1QbuHltFlK/ueBWNZ+6hFo/gnk3Imd8+dlhVE/DvQso7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3618
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020065
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020065
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Qu,

  fstests ran fine on an aarch64 kvm with this patch set.

  Further, I was running few hand tests as below, and it fails
  with - Unable to handle kernel paging.

  Test case looks something like..

  On x86_64 create btrfs on a file 11g
  copy /usr into /test-mnt stops at enospc
  set compression property on the root sunvol
  run defrag with -czstd
  truncate a large file 4gb
  punch holes on it
  truncate couple of smaller files
  unmount
  send file to an aarch64 (64k pagesize) kvm
  mount -o ro
  run sha256sum on all the files

---------------------
[37012.027764] BTRFS warning (device loop0): csum failed root 5 ino 611 
off 228659200 csum 0x1dcefc2d expected csum 0x69412d2a mirror 1
[37012.030971] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0, 
rd 0, flush 0, corrupt 9, gen 0
[37012.036223] BTRFS warning (device loop0): csum failed root 5 ino 616 
off 228724736 csum 0x73f63661 expected csum 0xaf922a6f mirror 1
[37012.036250] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0, 
rd 0, flush 0, corrupt 10, gen 0
[37012.123917] Unable to handle kernel paging request at virtual address 
0061d1f66c080000
[37012.126104] Mem abort info:
[37012.126951]   ESR = 0x96000004
[37012.127791]   EC = 0x25: DABT (current EL), IL = 32 bits
[37012.129207]   SET = 0, FnV = 0
[37012.130043]   EA = 0, S1PTW = 0
[37012.131269] Data abort info:
[37012.132165]   ISV = 0, ISS = 0x00000004
[37012.133211]   CM = 0, WnR = 0
[37012.134014] [0061d1f66c080000] address between user and kernel 
address ranges
[37012.136050] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[37012.137567] Modules linked in: btrfs blake2b_generic xor xor_neon 
zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
[37012.140742] CPU: 0 PID: 289001 Comm: kworker/u64:3 Not tainted 
5.11.0-rc5+ #10
[37012.142839] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 
02/06/2015
[37012.144787] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
[37012.146474] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
[37012.148175] pc : __crc32c_le+0x84/0xe8
[37012.149266] lr : chksum_digest+0x24/0x40
[37012.150420] sp : ffff80001638f8f0
[37012.151491] x29: ffff80001638f8f0 x28: ffff0000c7bb0000
[37012.152982] x27: ffff0000d1a27000 x26: ffff0002f21b56e0
[37012.154565] x25: ffff800011df3948 x24: 0000004000000000
[37012.156063] x23: ffff000000000000 x22: ffff80001638fa00
[37012.157570] x21: 0000000000000004 x20: ffff0000c7bb0050
[37012.159145] x19: ffff80001638fc88 x18: 0000000000000000
[37012.160684] x17: 0000000000000000 x16: 0000000000000000
[37012.162190] x15: 0000051d5454c764 x14: 000000000000017a
[37012.163774] x13: 0000000000000145 x12: 0000000000000001
[37012.165282] x11: 0000000000000000 x10: 00000000000009d0
[37012.166849] x9 : ffff0000ca305564 x8 : 0000000000000000
[37012.168395] x7 : 0000000000000000 x6 : ffff800011f23980
[37012.169883] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
[37012.171476] x3 : ffff80001638fc88 x2 : 0000000000010000
[37012.172997] x1 : bc61d1f66c080000 x0 : 00000000ffffffff
[37012.174642] Call trace:
[37012.175427]  __crc32c_le+0x84/0xe8
[37012.176419]  crypto_shash_digest+0x34/0x58
[37012.177616]  check_compressed_csum+0xd0/0x2b0 [btrfs]
[37012.179160]  end_compressed_bio_read+0xb8/0x308 [btrfs]
[37012.180731]  bio_endio+0x12c/0x1d8
[37012.181712]  end_workqueue_fn+0x3c/0x60 [btrfs]
[37012.183161]  btrfs_work_helper+0xf4/0x5a8 [btrfs]
[37012.184570]  process_one_work+0x1ec/0x4c0
[37012.185727]  worker_thread+0x48/0x478
[37012.186823]  kthread+0x158/0x160
[37012.187768]  ret_from_fork+0x10/0x34
[37012.188791] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
[37012.190486] ---[ end trace 4f73e813d058b84c ]---
[37019.180684] note: kworker/u64:3[289001] exited with preempt_count 1
---------------

  Could you please take a look?

Thanks, Anand
