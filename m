Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16253FBF13
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhH3Wmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 18:42:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49738 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhH3Wmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 18:42:38 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17ULwsBO013444;
        Mon, 30 Aug 2021 22:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jOciWafDKLjmFQtogEUbRxcvQSXZY9ZCUtdmO9mWXDg=;
 b=mPDl+LbcwIbyku7ncyxKhnRqS0Dg7gp1PVEbdpT7y/hqaXGjwLJ7D10eYoarm0ne7I7E
 gSAsmC52M1J256PtnEvfkMSRiz9koeJfBfYKLVP4KpDF/Gl36jP58HFIbeD2P1tWfY0I
 Qoti7lXTtVHvamIiXN4TtOYtFJxmCHyBB8rh0TuXnW/W6Q8fv2viKBRc+Oj4TQ99VJYL
 BMJVtpOTUAOjQ9XXL75NGGqK25FJHDcZFUdaSNuwDESb913OKp74cRrEVVqtS7YdC1/W
 1j6NPvV7B3xHq0X3/TItW1CMNkpaOyiepohFaR8MRHV9Hz0FEDnK//n+JrwFHWLdZHVz QQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jOciWafDKLjmFQtogEUbRxcvQSXZY9ZCUtdmO9mWXDg=;
 b=YqF74qs0QqUm6OT/kevxwc1IVjDHgIHiQRrK91Cmb5YUk8J5XgkqG61BvKld9pYEqkQt
 9Vm9baFQOLHn4hTI+DHnDhuZAIiny43lPJKcSGXtIxHFG2V/Pykh2VH6KSRKpAg9fYK4
 NFjCh38xIzMJIRGfNhWysnJ88QxmGv6vLAkTWHvrgXVT4eTZ9S9GMLLdAjqguZkhZuT7
 gW7PEuG+DNGs5TIL90NrFecgKEUPx8CneZoHnRBNUwr4ui0gekhIeT4hTbM1KysYdHyA
 EKZ1Fgv7I6obKad63P2XEu6F+0CCqmgNw6eTZjz4HMupv7W1cOPtM4G/QSZWAthVs6Me +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxwjta1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 22:41:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UMZimr121562;
        Mon, 30 Aug 2021 22:41:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3aqb6cqk6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 22:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRs6KvcJZjSb9XEBlNgQGKJ7OMrgHh/vsCYxDQu8atePSgpqY7on2+K1cyBw2ZIHMbyy9n1f1fT3K5KYN0Qwaj+JlrRBS6hLPBdwgBcezEAQEjmVbClZ56jm1hgWo/0kAlbd+T47fbS9H1gC4S1vgkaY5Fg/p8PwBqcR9TYX9bpFoekeuEAjrSCV+nr9OAhGxjJK5Xys9aNEjaHdG2lD3Jaz/jSRlxp+e1XoTGoREPpVu9VL1NAkvpa/Ki13TsH1BX9oGJgjZAPQolHUXOScYBDHNwLLI6AgwNSxpk3obWBTmnPAjg0/I0w7Gvp5v5oArtpMXgJDOL0rOyIlrxMyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOciWafDKLjmFQtogEUbRxcvQSXZY9ZCUtdmO9mWXDg=;
 b=jq4SvQkJOGg9r/+3XmxAJG8TsKwiZxSfBBD7z7kzJJMul0jWz5PxtBSTpD9rPclyVoRX0Vw9LjSaprOzdw0ICavrUnyS58/1dRwzAJLICMUNOjiHnwnQ0qHh0yOydl8o8Zn0nTw22JsGRyJY5QVE4ATrHViSEA7Gb3aK4f2AjYtH/04DBxsUG0iu9NycazB7f2KL4Rm1/H26+PDW4yybqTIfgFa+ltIySMGq7P3dMcIKuhn8j4a0kChh19p9JWNojhYXe4FleWcmsZGqKqE8aB9aHJArUnZQHlvs/uOL3lQPLPvvb1qX05nRbXnL7busmokiFmHkZgj8jzzvwrXqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOciWafDKLjmFQtogEUbRxcvQSXZY9ZCUtdmO9mWXDg=;
 b=Shmw1sLISG2OxYqXG+xx44IGJHAA/UVYw7gCC8Y5/9uv7z7saJadIFOr3jt+GgjizZMb98v3HOLoyG6uKyJrGx107ag0S7uT30ostzzp1hA/IvswW9YZ2m44H74WO6QqvaZMGZdCOPN2BYLbKGvsecSoAeNmAaEH/UrmBklKFQ0=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3839.namprd10.prod.outlook.com (2603:10b6:208:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 22:41:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 22:41:33 +0000
Subject: Re: [PATCH V5 0/4] btrf_show_devname related fixes
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
References: <cover.1629780501.git.anand.jain@oracle.com>
Message-ID: <34118c32-0d7f-426b-7596-4372315599ea@oracle.com>
Date:   Tue, 31 Aug 2021 06:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <cover.1629780501.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0248.apcprd06.prod.outlook.com (2603:1096:4:ac::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 22:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893f7ba1-3373-4615-9365-08d96c075111
X-MS-TrafficTypeDiagnostic: MN2PR10MB3839:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3839BD813156883A740A9E2BE5CB9@MN2PR10MB3839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qUG4Avl0d3CIbxm5c/ng0s3/G07rkZtw7HDdCkgqlblPc2/jWzEuoIAVHz5WggRZGEVSCOi9cuZLuhTUiysozSQK9J7FaKi28JIIQxGzoElgzd7wvcex9tSRL7G2UqP70l51pjzZ2mnEecrY9lEr6O3TTPIXDSeWfxilHot92cw24vzwtYQPhJo6kVNuSwee2rNaB88fMetH/oEt7W7Tn0bAZdVLYN0Ig4HhXqDkgHp/axCMZSBzOZL1Fa4M/E8jDfEAhlCqVV7udvLODmvtfjnuzgp9IeLkesCaLmqghYK5KIrrPNp95x7qHRyFZAFp43oKbrYhaCsV/ezN70urKwEJu5sL6t58a2rSePbzh+mtUZFAvQq8H/tt6WofP+d1OxiMaaiUbM0JFp2xXwIaEi6OkgJaFEOwPt2e77qeYtAj1gq3yRGf6TEwiavsZOfQDjD2P531DVIwfJQJ32RZcVr2tARYXEnEY/XG0B4ucCjJxj9R57JnUatfR5RtauyX/FuRHnfrb97mswncWhmTTLtY75Gy9mYIomCQsX4zTTxgTkbfu+8Uf0ymYnhUsFWxo/DH1AnyKR4LcQm1KQ2NvRSQLp2k+I3/NqSPR/wVkXN2RNMwJxNpqmEz9ugTwQR3MpWcg8Uud60SnFpC0FViJr48CWz6IwGVXn3ropb8yxg1nrg2jBw5cy+rypKouycEIfaTbTKs2nfvOKl3rt9aAL5m1fJwoj5hRDMQNyYwqecq/sF8H30kKLWkQE7cwbLhh8kE0efWvFyGuXEONDaqee+0Xs/xmTOrNkyD8+FR0ua9Po3H0BG7WweD34G82Sj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(346002)(136003)(2906002)(31686004)(316002)(2616005)(86362001)(956004)(66556008)(66946007)(4326008)(44832011)(36756003)(5660300002)(966005)(16576012)(83380400001)(6486002)(8936002)(53546011)(38100700002)(478600001)(8676002)(26005)(6666004)(186003)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFMyY29SV1hGL2Y2RWs4TTcvTzJWMXlyZVYvQ3YwN0pTOG5OelR4SWlnREty?=
 =?utf-8?B?YVg3L3A4U3NPcWJ2UzZuenlnSW9nZitlMlZjS0NKakYzV0kyU0ROZXF2dUdl?=
 =?utf-8?B?eURKUitTUUUwUThKY2ZQM2hKYVRvdXZmenBtWE93K1BBdktLanFkL0NmM05U?=
 =?utf-8?B?OHhZZDVuNnZWRzJYV2M0UmFjRk1JWWVBUHQwaGpMT25KM0ZxT0IrcExUNXp3?=
 =?utf-8?B?Vmt6MDBwamtJUEtoV1pGVjNkNGZqNUxwVHNmdkpkN2ViKzFmd2lFYk1pSXVu?=
 =?utf-8?B?SFpzWkFPblhCU0YvbExVd3IrTW5zS0tvTVdRUUlBc08yV2VBRjRLL3lIcUpa?=
 =?utf-8?B?eTR2UFhCand3NDFUV21SbWl4UEcxMkNidi8wSDV4RkNXVThRNjFrVUZhREZY?=
 =?utf-8?B?VHFPYWt5RmI1R1FCQjlKN1Fyc1dpa0FYdlJmVkxGZFlQVUNQWnFzVkZMcFh0?=
 =?utf-8?B?WWFLTW9sbUF4My9CM3M2WWpEalVTR2Y4YzljT3BJcmpQYUtHdUpWdUxGNVNQ?=
 =?utf-8?B?bW1XVjR4QVQvTGlsSjhsck9jTmRyZmczMGo2eVQ2TjE4M1JRdDduV2dVcUtW?=
 =?utf-8?B?eDlSSkpJN0x6TTdiRHJMYmtQYjFkLzlIejJSN0pmY0ZZTC9GMUNDcEhaZU82?=
 =?utf-8?B?S1hZem90ZnZSU2oxYmxpOXlCbXRCQkVMZVk4WjcyN0hRL09RRVZSTmFiZmU0?=
 =?utf-8?B?clpncFJSMzR6OFgrcjJYNjdKMFhKbUxzaDBva1N2ZVBlWGRSRXJEZHVXdXNz?=
 =?utf-8?B?Nzl1eTEyeW9xdGQrczVQWkxpcm85Y3ZrZ3Z6eWlEQlUxMnJjeEYzYlg3dDdZ?=
 =?utf-8?B?ckFVSHlJdjZobmdtWFIyRnhyL1c0aWswMHZxd3hHM0ZWSTJNMklhSEk1S0Q2?=
 =?utf-8?B?NHR3Z2svdU0xS1U3TDhHbXZkQ3RnWU16M0YrcmlqckNQTDZMc3J6SFQ1d29p?=
 =?utf-8?B?aHBlUDliQ0RBQjlBVys4Z00ybDltajltdFBxeDhud2wvNFNUTWN5d0lCVDBY?=
 =?utf-8?B?Q0JzNzRnTTJBL2NIdGZZQlZNUUhqeTFqNFljQmg3c2Q5TWFYTmU1MDdWWGoy?=
 =?utf-8?B?eENONnpsdDhUMVVzMHJQaEE4TVU2VFlCS054ak5nakFIeGl5bUJGbXVqZktF?=
 =?utf-8?B?aEFTQVFqNUdtYzhFYUY3R1dFdi9Ja3E2NDVzYml3WGE4NFBDTitFb01jaFd3?=
 =?utf-8?B?azh0OTFCMDIrcWZDeGlGMHU4RVlUKzFiMk13WThMYVRGS3BMWDFGQlNER2ln?=
 =?utf-8?B?UmZ1TG9VYjZpcWhmYXI0TDNwaDVUbXU0bkJaNVFtUklpNGNNeS80bjFLWE9m?=
 =?utf-8?B?THkyMC9FM1RENG13czBhcTNVUXcveExBVWJsWVhFTVcwWEhBN3kzekJVckJv?=
 =?utf-8?B?bjRXL0VBVkxDNmFRQzZTK096cTZIMmM1Q2JBbXRFM2l3dENaWFlXbmFWWi9T?=
 =?utf-8?B?c3hWZTUxM1YyTHBwM0V4L2hzcmozL3ZKYjJCanZ1WGpUdld0L054NDFJcnRL?=
 =?utf-8?B?QW1wRThicHkxd2c4bklxcllrc2ZuSXEzMFZocDE3NEsxRjJ0aXFxMGJqdTQ5?=
 =?utf-8?B?a0JydWRqOE9tRFZOSHplQmsvRVUrejUwUDNpRUtVbXdMaTJZQ0tTQlFMdlho?=
 =?utf-8?B?c0lBVm0yOEs5UkpGeEtFT2tlYlphNWNoeE1RLy9mSEQ3aFNHZTM0UG81M28y?=
 =?utf-8?B?V0tGRDFZTllSa2JKT054eUZhTU5GWFJERUNTSDNrbGlFN0Q5SGVnVjVIaWlE?=
 =?utf-8?Q?Aljcrk0+JTQpxJY7AWUwwgO6X8VmKllgij+BUNW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f7ba1-3373-4615-9365-08d96c075111
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 22:41:33.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAYxYgZcuvF+AIcegioTVViGaHQsDc/l7C7CK/857Sht9CsOGiJBMa+j+2bm6iwWHX6KgRsUkdk1scQBWTLr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3839
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300142
X-Proofpoint-ORIG-GUID: Ygal_mUMea3yHPNwf7OfbO4fZzBdHm1G
X-Proofpoint-GUID: Ygal_mUMea3yHPNwf7OfbO4fZzBdHm1G
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping.

This patchset is fixing a bug reported by btrfs/238.

Here I am proposing to remove traversing the device list in 
btrfs_show_devname(), instead use device->name as stored in 
fs_devices::latest_dev.

Kindly review/comment.

Thx, Anand



On 24/08/2021 13:05, Anand Jain wrote:
> v5: Patches reorged.
>   Patch (btrfs: consolidate device_list_mutex in prepare_sprout to its parent)
>   moved into a new set as it has a dependency on an older patch in the ML.
>   Change log updated.
> v4: Fix unrelated changes
> v3: Add missing rcu_lock in show_devname
> v2: Use latest_dev so that device path is also shown
> 
> Su Yue reported [1] warn() as a result of a race between the following two
> threads,
>    Thread-A: function stack leading to btrfs_prepare_sprout()
> and
>    Thread-B: function stack leading to btrfs_show_devname()
> 
> [1]  https://patchwork.kernel.org/project/linux-btrfs/patch/20210818041944.5793-1-l@damenly.su/
> 
> While btrfs_prepare_sprout() moves the fs_devices::devices into
> fs_devices::seed_list, the btrfs_show_devname searched for the devices
> and found none, leading to the warning as in [1] (above).
> 
> The btrfs_prepare_sprout() uses device_list_mutex however
> btrfs_show_devname() don't and, the device_list_mutex in
> btrfs_show_devname() was removed by the patch 88c14590cdd6
> (btrfs: use RCU in btrfs_show_devname for device list traversal)
> for the perforamcne reasons.
> 
> This series does not intend to reintroduce the device_list_mutex in
> btrfs_prepare_sprout() but instead saves the pointer to btrfs_devices
> in the fs_devices::latest_dev so that btrfs_show_devname() can use it.
> 
> patch 1 converts fs_devices::latest_bdev type from struct block_device to
>          struct btrfs_device and renames it to latest_dev
> patch 2 btrfs_show_devname() uses the fs_devices::latest_dev::name to show
>          the device path in the /proc/self/mounts
> patch 3 fixes a stale latest_dev pointer after the sprout operation
> patch 4 fixes an old comment about the function btrfs_show_devname()
> 
> Anand Jain (4):
>    btrfs: convert latest_bdev type to struct btrfs_device and rename
>    btrfs: use latest_dev in btrfs_show_devname
>    btrfs: update latest_dev when we sprout
>    btrfs: fix comment about the btrfs_show_devname
> 
>   fs/btrfs/disk-io.c   |  6 +++---
>   fs/btrfs/extent_io.c |  2 +-
>   fs/btrfs/inode.c     |  2 +-
>   fs/btrfs/super.c     | 26 ++++----------------------
>   fs/btrfs/volumes.c   | 17 ++++++++---------
>   fs/btrfs/volumes.h   |  2 +-
>   6 files changed, 18 insertions(+), 37 deletions(-)
> 
