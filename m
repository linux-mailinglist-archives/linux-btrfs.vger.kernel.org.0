Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBF43DC8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJ1H7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 03:59:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhJ1H7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 03:59:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S7Rhmh023429;
        Thu, 28 Oct 2021 07:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DjABg5hfNGOgNRPUSEaxAbT9mwuMTDDDyzhjMMtbJqw=;
 b=aZtXZHkJ2SMZ/Jfe81To1rOYnGI7S69nwHd+x4WiYckA7EC1tGq6Hew3OOFEUeG2hHgQ
 deDUlJ0zGY1SoPkwU8QgfBYFomxyRnfadD/N5zghwqNoPosDlj3PoD3GQAJHU5gt2QTU
 mx3gsdRaa2aktZEcXXgntonUTXhq6ej7M4x1ifTuaMwzNYaMB5Pe/iDo3MadahHF9IyT
 YhVEiaKyXK+BNl7zFB5JZKIFiK02i5CqP5CriUn0PZs6SH6GUbxDmEcSsGW4xrc18UZv
 aPi85C23hm8hSef+VPa53GO5EePoh/+UAC04zOYTgXsJBIigXdQzzX6umdQ07itICpoN VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byhqr92b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 07:57:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19S7q3Lc019652;
        Thu, 28 Oct 2021 07:57:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 3bx4h3p8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 07:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH+hINZWomnDptQ4NE6oVzGmrKVFV29Zv1FFqdYY50v88UEGvRjmlt95YK3N4yglkNMKYnwkk+17k5/kEgFxeaBhulbyBJpvRDgx7O66NkOTZPXYamBC3LRouRwCDW4BRm97qbjIB2pKYgma9aZ7AtBggr7GYomN2KhyePHxJydjZ7QanDIx54Bc/yEAtLb4b22gJDyWXvnWpSOazMzfOsP/Qq3XmL+T1JuHAyTMTy/UhZwdcx8relJEuR9ptCjgAunuIWg6AwvzVfUBMp618o8Vd+4mvjNkIpCL7jwyb0XZnL8QAGhU7wxMa940F2wMjVTJtExYcgci7y5xGhiBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjABg5hfNGOgNRPUSEaxAbT9mwuMTDDDyzhjMMtbJqw=;
 b=Mmr1LalOqHBimjoq8Ea0QD2Q2ij7duCdapIJUKABDLcq6NWP/L4qpM6wEP2pdeTsjlhDVVKwawfdroyUXCq54tysdGux7b+gahcTuIteBnB4nYXY0VGlQC7zzxaHYmMa2eKGqMIsmbOJ90udmcmBVPc2VcROymBMambiSGL/Ek/Ttjbu0udlHGq2QoqPh3PTKltRoezpC9xKk8KJgEBLA/kn/rF2cntcpCxTMQD/yOxrV/jjp3qUbNawJvQ8eFD0+YQVZm4wzwl7JoenaqACM2E9YtDEJfj4hjl8zUUNavVPrKhdaYmCijIKjCxNox7IWgdjD009grmdz4/Ecvs3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjABg5hfNGOgNRPUSEaxAbT9mwuMTDDDyzhjMMtbJqw=;
 b=I6F3/HtdkfXNsJZ0zLKXNzosom3IlYnIoOZlZ3z30PszDVLI9M1HHNi0kDMeltfdkSCTDBs7d/YgJ+q6yzRaajgWMWPpS7xma/IcnlLF2UgMcBUNGD2qk3wxqyAsPsr3J5624TprA5FChG+6p2cjTfJrK9Fl3JT60DUKMtKzNmY=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2930.namprd10.prod.outlook.com (2603:10b6:208:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 07:57:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 07:57:12 +0000
Message-ID: <7231b62b-7b84-d061-f3bb-fea0fbf891d9@oracle.com>
Date:   Thu, 28 Oct 2021 15:57:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs: Don't set balance as a running exclusive op in
 case of skip_balance
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211027135334.19880-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211027135334.19880-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Thu, 28 Oct 2021 07:57:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a938f1-1131-4e35-efcf-08d999e88c8c
X-MS-TrafficTypeDiagnostic: BL0PR10MB2930:
X-Microsoft-Antispam-PRVS: <BL0PR10MB293071EF7E1DB3AAE9B9A3B3E5869@BL0PR10MB2930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+hCh0+kuhpIVFRHFTpDdyiUG/BIzzeACRCUtvrMQffrGNqKbZ3+QPGM+6DwEAn3hIxwb01VmMBJiLCPr9dcF5VGb8bKuTlXS9v2gnCfFc9iQ2AfbmF7fOb6etJlnrhHxMONgP8aTB2XLDlqZK5ezs/400/BQ3Ktc00WNuBK9QzVaNL4rkCYBcpDy6ZAC4tQHRb4JnP9Y3mQJykxK29jcKvRb5+TiTEf8HkUNNSd9EPaSytXBF3M07SCiaTkAbLlGuNooZG0EcCjSmVh2zGnchLQ6XAan3rjDblO8UNDzdVTVvluzFAQ8L/gprf6cOpLjZBBVT5UIrYU9D6Rtml8edfUSrPMYh+QhrT5zM/pkpotYEgaGvR/unrXxSIeUbGynC57ihm8dfyIrXsLvBlIWUWvQA4KxqanUSM18SegmVmR2tYaQvFtnvuf8P4FtC9YczNxbiAydBL0BmjVvymck0OEeeMTX8SEnD0fJYbNDil5XmiEE4Teqg3Fy+WjA4oyCBfKeXZakMwk6mH5uSD9yr2xiWOziJZwH2MyGpqklwk6T7jRXNTZEx2TDXGpcYCKIp+lqYtVdt8s1JAmLPLK7WuMgrol9t3XEGuaiWXfmAQZBArasvArWOMTWjB8rDFXWKm6qGDGvb53r0GJCOZ08nnDZhfh0b0d9HilLUwZ2QhYRifRMiK7I9DD4SasRr86WkhazZNXAAcIi0hf06dXPbiXhzJ0yNoN3SJ/N1nVyW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(86362001)(36756003)(16576012)(186003)(31696002)(83380400001)(2906002)(38100700002)(8936002)(316002)(6486002)(956004)(66946007)(26005)(53546011)(6666004)(8676002)(66556008)(2616005)(31686004)(66476007)(5660300002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdpUzlpZnlpQVM3OHRIZkFERk1IajZOdDVZTFU3QmI3cUFXRFlYUlJ5bWtY?=
 =?utf-8?B?d0dQMmdyU3JTV2w4Mk1KVjBXYXAwVEZqakxJOGV5MTlSYytrK0EwK0ZJcjNz?=
 =?utf-8?B?MTJlTit3UUFNam5qNVdESUZwQXJGM2drcWYvMkdDOFJvQ1FTZVB5TkNqV1ps?=
 =?utf-8?B?MzdiZmd3Vm1oV2ZBaUZHZGtmNXRwYzFsSytuUWsySEdwVlc2M0dKYm5XS0R2?=
 =?utf-8?B?R0lJU1gvZ0lxQTRwOWJMUDdaWEs0Q3hseGVkSFZ6WHNmMWdDeCsrazZ3Ny90?=
 =?utf-8?B?UUhUZFJJS0Z1SEZ5SjU4bDNJMnc5dGV3eWhSa2RESytHQVc3ZUUySXdOMjE0?=
 =?utf-8?B?TnAwbVVCYVBwR29IUlBCSUVnZnRuQ0VJcXlvYU9Zc1FJdDNZVUp4RHdmSE1j?=
 =?utf-8?B?WUx2cWVTUDZtS0NzSWpzL2h1OUhuV1JzeU5Fa2duYmV4UzBtQVdKNWwxZlVy?=
 =?utf-8?B?cUhBMVd2eWRJN1VvOTRpMjV5aWxucUhUc0g5aEpGQVVHZTV5aXJVblZQV3M1?=
 =?utf-8?B?WHZucXB4OWVMNTViRXBNejFwRmVVeUF3eVpVenRicGxsSVh4T21BVXUwSjlY?=
 =?utf-8?B?b0hRWnJNcmZNVHZGL3JobjAxRG96OXZhSHozczgrbUIwUENhZmdwbkZyQm1w?=
 =?utf-8?B?aDJvOVY4bGZmZGhlcHVVMXYyRXpkMjhjVksvbnJZeGs4Z3RGNzhYa2RobW1M?=
 =?utf-8?B?SUw2Nmdkb0ovanN0VktkaVJlMk4xUFJLMWd4SXdseUpwWVNERUpDNlFHR1ZP?=
 =?utf-8?B?YmZZOWJ5U25RMlFkRXhJck1wWWRTNktUdE1rSVhNOTR3aEZsbjZHR09WdUJy?=
 =?utf-8?B?L2pmZE8xRjUzMEJab3h4dm51MExvU2JldC95cUlDVGJIa0NGeDM2VHB2c29X?=
 =?utf-8?B?bVlzMVpyVjJOTlNkKzFOR1U2QThyWUNhaE91MVFPUEpBejVDa0tVd3RyUGhx?=
 =?utf-8?B?TXFPYzdURlFoeDVxeFM3WFp5NmJhKzF6WjlpNHY3VEJjeTRZMHQ1T2NOY0xX?=
 =?utf-8?B?K3kvQUppMXA5YndEZSswcWFTcjI4aGZKVVdHSGpMaXE0dk1UUzJpV2ZRUDF3?=
 =?utf-8?B?UUQ3blE0UG5GMzJWQ1p1eE9pZEVwTndpenJtVXpYbm5MckRYM1o3RW5QSExR?=
 =?utf-8?B?aHg0Q09CbStQRmwybnpsWlN0cXkyS2xOMTNTeHFaMUlyS2tHMkw4bXA5QW9C?=
 =?utf-8?B?YW03RkpLYkc2NVBreFpYSnFjbEswYzNkRmZzNjV3Yk9tQ1VhbnFXdTVORVJR?=
 =?utf-8?B?OHB1cWU2UHFLR25kMEI0ZiswUlZQU1dXMzFMd0dySGE4TkxRRW9kRUdNbVVB?=
 =?utf-8?B?c2g0SnFacW41QVA1OTR5TWNYc3BZYjBFVDcyTmkyRHhVYkU0cjVMSEVQcVFt?=
 =?utf-8?B?OHk2U09DbUFJTE10enBvSnk3SjRRMnQzeU5hWnJ3MVlkbEp2K2svbDJIZGx5?=
 =?utf-8?B?T3ltN0pCTVpWQnRYakxMc3FyNFc3NnQ3dnZlb2svYkxqZFNkNG9Nd2dMWVZI?=
 =?utf-8?B?c1QxaTV1Q0Z1dnlrSks3SDlGNlI3czRlUlF4aG9YalVMZkhzQ0NTOVo5OHJu?=
 =?utf-8?B?aFlsWTN4WVpOWW9yMVZSajlXOGhLVGpoZkIzdktPTGdCcW5OeW85MVo1YjNv?=
 =?utf-8?B?WnVSdzBDcVJwQTcyekVrNG54NEhSRWZFa05mM3hTQlZkV3BGWDNBcG9Kc3lI?=
 =?utf-8?B?ZEVLdXNiM29RTU9mOXdHVXhYUkZuQ3MrSDhNd1VYKzgwMlJ1OEZVeDY0L1pO?=
 =?utf-8?B?TW41dTU0OTVpbldKQVNPLzVRTG5OVFIweTVEQ0lUTDdjbDVmYTdDZXFFRUJy?=
 =?utf-8?B?RVRHeHFuUURIYWF3TTVBSWYwdk8va2gxRlMxNEhwa08xdEdiT0hpZHVMc1A4?=
 =?utf-8?B?UWdxMlJuekZUdXRmNFRQQlhtNzE1YzV2RXJNZmcrNjNLbFpkbUZaSG5ZUWdS?=
 =?utf-8?B?aFR0S3hkK29Ncm92SnM5aTFzQk0vcWZJa1ptYWliYlVpT3Fja0xtM0JwWlIy?=
 =?utf-8?B?cS9kT1Eyb3BDSWh0NGxYSjdoYWk0ZEFNM0pKdjR0aTROdTNCQloyN2ZPVEs5?=
 =?utf-8?B?VmltOVJSamZ4a1RraDhES0tjRE90N21NUXJJZlNuRVFYb0lGaDF4TXA2Z1FJ?=
 =?utf-8?B?dlJrUjhzSlp0Z3NYWnJiWU5MVElXNi9hTWlZbFh5cWFyR29TazRrK2ZxcWdi?=
 =?utf-8?Q?GuLFgfKIeEMXyARmtEYvwII=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a938f1-1131-4e35-efcf-08d999e88c8c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 07:57:12.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ4Bvnu8wNxd8wOnoyAaY+htT6ki04gHZ9lJJvVCu4rDb5LwMsYXakLyYBJ+C5cYb2esLi117YxGMJeyM8pyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280040
X-Proofpoint-GUID: RRv1YU8hwrpQviYOLX-rbhCmYvAknDQh
X-Proofpoint-ORIG-GUID: RRv1YU8hwrpQviYOLX-rbhCmYvAknDQh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2021 21:53, Nikolay Borisov wrote:
> Currently balance is set as a running exclusive op in
> btrfs_recover_balance in case of remount and a paused balance. That's a
> bit eager because btrfs_recover_balance executes always and is not
> affected by the 'skip_balance' mount option. This can lead to cases in
> which a user has mounted the filesystem with 'skip_balance' due to
> running out of space yet is unable to add a device to rectify the ENOSPC
> because balance is set as a running exclusive op.
> 
> Fix this by setting balance in btrfs_resume_balance_async which takes
> into consideration whether 'skip_balance' has been added or not.
> 

Hmm, no. I roughly remember it was purposefully to avoid replacing
intervened with the half-completed/paused balance. As below.
Not sure if it is ok now?

Before patch: Can't replace with a paused balance.

------------
$ btrfs bal start --full-balance /btrfs
balance paused by user

$ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
ERROR: unable to start device replace, another exclusive operation 
'balance' in progress

$ mount -o remount,ro /dev/vg/scratch1 /btrfs
$ mount -o remount,rw,skip_balance /dev/vg/scratch1 /btrfs

$ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
ERROR: unable to start device replace, another exclusive operation 
'balance' in progress

$ umount /btrfs
$ mount -o skip_balance /dev/vg/scratch1 /btrfs

$ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
ERROR: unable to start device replace, another exclusive operation 
'balance' in progress
------------


After patch: Replace is successful even if there is a paused balance.

------------
$ mount -o skip_balance /dev/vg/scratch1 /btrfs

[ 1367.567379] BTRFS info (device dm-1): balance: resume skipped

$ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs   <----

[ 1391.318192] BTRFS info (device dm-1): dev_replace from 
/dev/mapper/vg-scratch1 (devid 1) to /dev/mapper/vg-scratch0 started
[ 1408.243475] BTRFS info (device dm-1): dev_replace from 
/dev/mapper/vg-scratch1 (devid 1) to /dev/mapper/vg-scratch0 finished


$ btrfs bal resume /btrfs
Done, had to relocate 5 out of 12 chunks
------------

Thanks, Anand


> Fixes:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> I'm inclined to put a Fixes: ed0fb78fb6aa ("Btrfs: bring back balance pause/resume logic")
> tag since this is the commit that moved the exclusive op tracking of
> resume_balance_async to btrfs_recover_balance. However that's far too back in the
> past and given the commit message of that commit I wonder if doing this
> re-arrangement in older kernels is correct. David what's your take on this,
> perhahps just a stable tag would be sufficient?
> 
> 
>   fs/btrfs/volumes.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 546bf1146b2d..bff52fa1b255 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4432,6 +4432,20 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
>   		return 0;
>   	}
>   
> +	/*
> +	 * This should never happen, as the paused balance state is recovered
> +	 * during mount without any chance of other exclusive ops to collide.
> +	 *
> +	 * This gives the exclusive op status to balance and keeps in paused
> +	 * state until user intervention (cancel or umount). If the ownership
> +	 * cannot be assigned, show a message but do not fail. The balance
> +	 * is in a paused state and must have fs_info::balance_ctl properly
> +	 * set up.
> +	 */
> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +		btrfs_warn(fs_info,
> +	"balance: cannot set exclusive op status, resume manually");
> +
>   	/*
>   	 * A ro->rw remount sequence should continue with the paused balance
>   	 * regardless of who pauses it, system or the user as of now, so set
> @@ -4490,20 +4504,6 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
>   	btrfs_balance_sys(leaf, item, &disk_bargs);
>   	btrfs_disk_balance_args_to_cpu(&bctl->sys, &disk_bargs);
>   
> -	/*
> -	 * This should never happen, as the paused balance state is recovered
> -	 * during mount without any chance of other exclusive ops to collide.
> -	 *
> -	 * This gives the exclusive op status to balance and keeps in paused
> -	 * state until user intervention (cancel or umount). If the ownership
> -	 * cannot be assigned, show a message but do not fail. The balance
> -	 * is in a paused state and must have fs_info::balance_ctl properly
> -	 * set up.
> -	 */
> -	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> -		btrfs_warn(fs_info,
> -	"balance: cannot set exclusive op status, resume manually");
> -
>   	btrfs_release_path(path);
>   
>   	mutex_lock(&fs_info->balance_mutex);
> 

