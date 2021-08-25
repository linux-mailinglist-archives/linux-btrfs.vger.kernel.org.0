Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167E3F6D44
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhHYCBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 22:01:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237216AbhHYCBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 22:01:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17ONQQEj025062;
        Wed, 25 Aug 2021 02:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xk0B+UfWYEImOeWzQ3QyRXHlUQRYStQVqJfQWhiRzcE=;
 b=AaK6Q4wHCBjcmSf9853RnMfKarrlDUYWrOgMDNpe6xSPWyULeDhS6ljxELaNkBjwGXjx
 gNYE6lEtyK9vWmKFZF44oaehyJyesn4HseMvWtmGRVYup+iDiZFH6DC+oogdnTh9Iz6W
 +X5N+hfEiyAYt6IVwzyUtxA1dXPjo81xe49R7ua9lxGnMScvpQQnuaMP0l8pnGYJtl+M
 ttuyY/0wHXJXTgcMzFjPSFt0LTtYbIbgnNhxEGIRPzdEu+59Ce1DidyWI3W6jsaaQgLc
 pofkzdMFjZCuQ3xoe9DM/7HJBSEbeROjH201Yt3/n3DcvKInam06aegxNSpEttCsNcjd ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xk0B+UfWYEImOeWzQ3QyRXHlUQRYStQVqJfQWhiRzcE=;
 b=OklusKuKZbeW3gy/MzFv/OzU+r+HCIrExw4TLMuMngUCSxV86XwtpPbusErRvEqoHUxq
 TP0ia9YjtKKOSz/etGCThsdTdEelSkqZ9cj2VaOszl95kHcF7hyQRx3tNjUAcamRbV07
 rCtSOiNoLcrm/iyiFOPIgrcW8XogSUqNmmKhopTguuwPdDjL3IKoT8Kvh3/dbwj9WGbS
 M/f2XfyRHJ6BCWdQr+ZNqsNAufCSK7szQPPwctT4bp276nIUdybKHaSjz5H+n2Pljule
 A38KDl36tyCcbQ5lDvzpSq7Kp/5GpxCdKP80cmZ9GSGFJwi5kekQj6SbwIjKrE6hhi4f 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amu7vtn2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 02:00:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P1pGd9138856;
        Wed, 25 Aug 2021 02:00:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3ajsa6bej1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 02:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP38T5XiLqVmPma6ULkTSQ4kl7+cc+o8ZCZdOi0hnakadaWNxbl6TvxW/bU95NTScuBQoKHOKP4vATTObDuNW0XSI1j5TIk9PXL+C2awIghQCNnYFEEzB/88tZSUb1/H+kllxxMiFNQ2l5bUeg2otBxh81f8UboQVnU1CUKnoVfWV9OwXUbrRGaHtJAMsD3qWPjgA9QVaPfd6TicYWjE1FpYZivanwLD8YvQCqKpTA0gJORXRsmysMs+Ygkw9xQczXpd5zxOn1UcKEMuq6QvCPC60FyITZNO56kUaUtz5x5crXfALgaPyGis/sEz1srcIuL4HgPZ4s9RIt0RRE9BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk0B+UfWYEImOeWzQ3QyRXHlUQRYStQVqJfQWhiRzcE=;
 b=EdAOrZouClmeWTxrXAGMJWbl38tyJ7nuJx2vd3VHM4OZ7DHEQ3I1muW+KF0O7tAMqISxkt+XEUGH8VcHoj88VotOIrho8gLtU+LOCx2dI7yxj7gPoJz1CWnEr3HPbZJEiuvB0suXf6g62WxhyLvN17zRvFGzeiTgO2RpNOtZ9qNquVY8XliitPDUN13PtxANwYBg0Q2+TcQUygx+dn0jYHpO6FYozqZgZD18YmYyg21nEGwaQ/+r/KFSNqdSJYcr/ox7fGmV5Y1z6HrEiudGVJiFJ7DWf4Qc6xc7G8mVnJFK5C4VWfBEau7Rqudp94UWQkTnDqP0a5AKj4q+j2CGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk0B+UfWYEImOeWzQ3QyRXHlUQRYStQVqJfQWhiRzcE=;
 b=DJtgr917MQjnHNTsJZqIG+dRLZVL5q6bRH+aV3UseccrJwja2xQkFOWUHKpiAvke1ez8b0r/Or6K7Jv8PH5mCKD0NPu5NPY1NftjZlLr6QgPS/4C0Mflsj2obTMdLPrpB3ulkMQGbgk/MgMuCpmru+KJ13mH5hZy1OKVgTbQD0o=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3060.namprd10.prod.outlook.com (2603:10b6:208:79::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 02:00:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 02:00:24 +0000
Subject: Re: [PATCH v2 3/7] btrfs: do not read super look for a device path
To:     Josef Bacik <josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <26639cd9f337a84b432b6627cd7c17b3d6d51e34.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <41d2c028-6af5-ab2b-91fa-1090d4258ba9@oracle.com>
Date:   Wed, 25 Aug 2021 10:00:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <26639cd9f337a84b432b6627cd7c17b3d6d51e34.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.1 via Frontend Transport; Wed, 25 Aug 2021 02:00:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e68f121-d722-43c1-c867-08d9676c19ea
X-MS-TrafficTypeDiagnostic: BL0PR10MB3060:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3060C03394D99A830B28F3A0E5C69@BL0PR10MB3060.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbeMzsrOuR7xMO0u4K+VARDvb/F2WPe/Sv6GzDwa/3YjWEchlzMBJGhLHbnoz4iaiFhdLbFAeWODO5XvO3/ING7Bo60VGAGuoqR1C0amVMMKXurmKAivbzKJkR6F2BZrvm6VMZodHeNRTjH5karFqk8taiOPmk38bXZSnBZ8UD5Pblw3g2DK0ksQTNccBOyz2W4PEpl/fM21x9VqcgFg8aSCDvn45Pnp/oy2a7U7L75dpHVU+FcHnaSGFmFGQtakfNndF/97T1T7gpphvX7FukjgoBoXQH/VGEg0m6SL/ntiVZFct23LGPDV7GS7umtAnkKWeXeJ8p4yTJbeQyihsx9eA5Of+cEuoeI5Fq5iHnTz8aT2KOqMhiLMU1LyWkYWSZvxNFnh7kpFzh8MYquphJRaclRymF0aBtjDzkfz51Y0inUKRztTfgLwtINeNgKyJK2X/JoYWEwEbB6hBB4Myp6ADIsSqyW10EH2zqgEtcg6KHoqUQNbdLVSyPFGyCQnAWeE3fYDpHw2XHMvx+NYoW0Tgyv1I/7ftM9BE8EQ8zNu88VjkJypgaRmQQr7UQkxA+ZNV42I0HLhj/EHOfrvBZrx1oatK2wrlARXY76p/ufpKSCr3pmq4eMZzMRr2+mwYPmy2O3qLcIGJd1PwW9jYcpfG1UwxkKdWDvecIm+Y84CI7OyALjKSlyOfIBx2yZyVtB8YnQ6wOwE0dzwlVo86/Ataw7odYEffQKPT5e8Wus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(36756003)(478600001)(16576012)(316002)(66476007)(6916009)(5660300002)(66556008)(6486002)(38100700002)(44832011)(31686004)(2906002)(956004)(53546011)(8676002)(66946007)(2616005)(4326008)(31696002)(86362001)(8936002)(186003)(26005)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGg0c1VnUDJYVVZuZnBEclVJajJVWUFkUHJ0cm1yaElvanNIZ1QzSEdYTnV4?=
 =?utf-8?B?MElkdDBWbmRzcGNmZHlsamQ4UkhJaGZGeW1wVy9XMjNrbDFhRW9FNkJqcEN4?=
 =?utf-8?B?bWdSejVXclpIMXlqY0R3aThlOWo5aUM0d0RUWGJyRmN3OXlNTDdSVW1tTTJH?=
 =?utf-8?B?cTlvMjl3NzV0YWdhZ29WY1RyZ2FrOWttMmY0bytzZ0N2bkxEemJFWnRraEc4?=
 =?utf-8?B?amJLZnVRejBQVkNyTUhKRVBKU2ZIZkY2T0dsQ0FsVHZyZ3VuclZqUHdGd0dE?=
 =?utf-8?B?Rm9qdmZmbXVLTFVCeGl5cDFYcGVlZ0V2MlI2TEQ2d2ozcVBtS3FZckc5RFhk?=
 =?utf-8?B?WitNbGFiZGlaMEFHSHNWWTRDUkZWV1lJb0Y0SDc4WXF2blQ3Qkt2M281R1Zy?=
 =?utf-8?B?a3h6RVc2bllQYyt3eXJaRmVwdUdYbWh6OXJnaStCbHMxUlJ0NDJoamFKRHd1?=
 =?utf-8?B?U2lNc0tlRTgxUWxpdXQwbTBSUi9XaFltWVBQbFo2Vy9jNk5XeitaQlppOVRI?=
 =?utf-8?B?TWt4Z1A2VlRYRSszUWhRY3g3c2FZR0FWWS9KOS9EZ0pqNFVNbURKQmxZYWpo?=
 =?utf-8?B?WmdkbHBtRlhTTHJTUTdodFF1MDNFdzVlWC9xSnpqcjZlR3cvZnlkWU9oTC9Q?=
 =?utf-8?B?RCtxQkRNUEU3cWRZaGdob2E4N2J2b3FBSis4NHdFYlp5Nkc5dWtKV2w2Y1pU?=
 =?utf-8?B?Ky9kNG1lMVM1NWdYMzFCd29VZjE0SjJuREgrVStzVkQvOGtFUVRDSEJFRnpN?=
 =?utf-8?B?TS9xeDhqZHNkK0tyNkU5T3pGUWQzbkhaN0ZPVWQrT2p2SHFBeE02ajljT0tZ?=
 =?utf-8?B?SU9qd1JYdXZsbkJKQ2lBc0NwVGpEVEM0RVNpdHZOaTBhTmEwUkJ0WlJucG4x?=
 =?utf-8?B?RmtmL1JBVzlkTitwUURsS1RqZVZvN2ltK1VOTzkwOGQyNnlGZ1JNazFra29a?=
 =?utf-8?B?UkFJbGVwcmZxdk9lZUVVMU5TeFdzZjZvY2I2emtudi9IQUR1bXY1SlVFYkZM?=
 =?utf-8?B?ZUxFM3JsZkc3bG40MjU1cnFWNVEzaTJBZGtkU0tlUkRidGlFdWdaSi9rUGJq?=
 =?utf-8?B?cXFlVlUvMzhGY3JrY2NLb0NNRVZvclRmTnRyNWhQMllYMG1ndTF1Q3IxMENG?=
 =?utf-8?B?dGFFdnpJTTlNa3ZoT21Ia3hKLy9mMzMrSFBKcmNwemNPd3NTTW1pY2hMZTUw?=
 =?utf-8?B?RUJ5S2hBNFVOVXk4Y3Q3cFdRT1ZnU05pN3RxcWZvcS9CckVmd1JJc0ZPN0NR?=
 =?utf-8?B?Ykk3T1lGUVc5REtXbUV0RkFYQlJpd2N2c0JMQUFDV0x4djQvbWwrcFBPWnds?=
 =?utf-8?B?ZXZiT2pFalJNbm0wRkxaQzZzZ2ZSK3Jzem9yY3pwWUtqVlhDNCsxM0ZhRG1D?=
 =?utf-8?B?cWc3RXlCU1FlZlpIZkE0clp4ODQ3cnVaUHYzMGRCQm4wVFU4YnNCVUJzOStt?=
 =?utf-8?B?dWhVNUdWNFZSRktsUmppZjFaSll6M3NXa09JeGZRb0Q1NC9xSVJaWTVJM2o2?=
 =?utf-8?B?dTdKRFBiY3R3bWU0Z2Q5L2RPSFp1QTFnSlRxdEN0a1FVVWlLbkI0UkdyVEt3?=
 =?utf-8?B?Q2NsazJla25yaVlIbG91SjlUbmhvc3BVMVpLWFNHYk9CUDN3dUc5ZzJCNGN2?=
 =?utf-8?B?WUdjc0FXRzd1MmtmZ1d0VnY0ZmJYUGJsR3hMdE5ram05V1o4ZytVSVhpR3ow?=
 =?utf-8?B?ZzlEenkxVGlkaXo4Vit5VVZkQWxWTjJCZTBtSmF6SVRVNFUvT2dKenFKVlly?=
 =?utf-8?Q?2BzcuWrUdYzQ38wyUopz88MPN0QyEKGcJRHtehj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e68f121-d722-43c1-c867-08d9676c19ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 02:00:24.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm6JShnKbAmHQAyrCNahRnKiS4Lixj/7qd7UYdUwM6WmElk2Egm9Jj3mDPeJOfQNZ+cHi07GJ/0V+HTNzY8C8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3060
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250009
X-Proofpoint-GUID: wALl_GtyJ7THbuGdHRWJ-TWHVk3jLWlZ
X-Proofpoint-ORIG-GUID: wALl_GtyJ7THbuGdHRWJ-TWHVk3jLWlZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> For device removal and replace we call btrfs_find_device_by_devspec,
> which if we give it a device path and nothing else will call
> btrfs_find_device_by_path, which opens the block device and reads the
> super block and then looks up our device based on that.
> 
> However this is completely unnecessary because we have the path stored
> in our device on our fsdevices.  All we need to do if we're given a path
> is look through the fs_devices on our file system and use that device if
> we find it, reading the super block is just silly.

The device path as stored in our fs_devices can differ from the path
provided by the user for the same device (for example, dm, lvm).

btrfs-progs sanitize the device path but, others (for example, an ioctl
test case) might not. And the path lookup would fail.

Also, btrfs dev scan <path> can update the device path anytime, even
after it is mounted. Fixing that failed the subsequent subvolume mounts
(if I remember correctly).

> This fixes the case where we end up with our sb write "lock" getting the
> dependency of the block device ->open_mutex, which resulted in the
> following lockdep splat

Can we do..

btrfs_exclop_start()
  ::
find device part (read sb)
  ::
mnt_want_write_file()?


Thanks, Anand


> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #405 Not tainted
> ------------------------------------------------------
> losetup/11576 is trying to acquire lock:
> ffff9bbe8cded938 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0
> 
> but task is already holding lock:
> ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&lo->lo_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         lo_open+0x28/0x60 [loop]
>         blkdev_get_whole+0x25/0xf0
>         blkdev_get_by_dev.part.0+0x168/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x161/0x390
>         path_openat+0x3cc/0xa20
>         do_filp_open+0x96/0x120
>         do_sys_openat2+0x7b/0x130
>         __x64_sys_openat+0x46/0x70
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (&disk->open_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         blkdev_get_by_dev.part.0+0x56/0x3c0
>         blkdev_get_by_path+0x98/0xa0
>         btrfs_get_bdev_and_sb+0x1b/0xb0
>         btrfs_find_device_by_devspec+0x12b/0x1c0
>         btrfs_rm_device+0x127/0x610
>         btrfs_ioctl+0x2a31/0x2e70
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#12){.+.+}-{0:0}:
>         lo_write_bvec+0xc2/0x240 [loop]
>         loop_process_work+0x238/0xd00 [loop]
>         process_one_work+0x26b/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>         process_one_work+0x245/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>         __lock_acquire+0x10ea/0x1d90
>         lock_acquire+0xb5/0x2b0
>         flush_workqueue+0x91/0x5e0
>         drain_workqueue+0xa0/0x110
>         destroy_workqueue+0x36/0x250
>         __loop_clr_fd+0x9a/0x660 [loop]
>         block_ioctl+0x3f/0x50
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&lo->lo_mutex);
>                                 lock(&disk->open_mutex);
>                                 lock(&lo->lo_mutex);
>    lock((wq_completion)loop0);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by losetup/11576:
>   #0: ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> stack backtrace:
> CPU: 0 PID: 11576 Comm: losetup Not tainted 5.14.0-rc2+ #405
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0xcf/0xf0
>   ? stack_trace_save+0x3b/0x50
>   __lock_acquire+0x10ea/0x1d90
>   lock_acquire+0xb5/0x2b0
>   ? flush_workqueue+0x67/0x5e0
>   ? lockdep_init_map_type+0x47/0x220
>   flush_workqueue+0x91/0x5e0
>   ? flush_workqueue+0x67/0x5e0
>   ? verify_cpu+0xf0/0x100
>   drain_workqueue+0xa0/0x110
>   destroy_workqueue+0x36/0x250
>   __loop_clr_fd+0x9a/0x660 [loop]
>   ? blkdev_ioctl+0x8d/0x2a0
>   block_ioctl+0x3f/0x50
>   __x64_sys_ioctl+0x80/0xb0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f31b02404cb
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 61 +++++++++++++++++-----------------------------
>   1 file changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0e7372f637eb..bf2449cdb2ab 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2313,37 +2313,22 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>   	btrfs_free_device(tgtdev);
>   }
>   
> -static struct btrfs_device *btrfs_find_device_by_path(
> -		struct btrfs_fs_info *fs_info, const char *device_path)
> +static struct btrfs_device *find_device_by_path(
> +					struct btrfs_fs_devices *fs_devices,
> +					const char *path)
>   {
> -	int ret = 0;
> -	struct btrfs_super_block *disk_super;
> -	u64 devid;
> -	u8 *dev_uuid;
> -	struct block_device *bdev;
>   	struct btrfs_device *device;
> +	bool missing = !strcmp(path, "missing");
>   
> -	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
> -				    fs_info->bdev_holder, 0, &bdev, &disk_super);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	devid = btrfs_stack_device_id(&disk_super->dev_item);
> -	dev_uuid = disk_super->dev_item.uuid;
> -	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> -		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -					   disk_super->metadata_uuid);
> -	else
> -		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -					   disk_super->fsid);
> -
> -	btrfs_release_disk_super(disk_super);
> -	if (!device)
> -		device = ERR_PTR(-ENOENT);
> -	blkdev_put(bdev, FMODE_READ);
> -	return device;
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (missing && test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> +					&device->dev_state) && !device->bdev)
> +			return device;
> +		if (!missing && device_path_matched(path, device))
> +			return device;
> +	}
> +	return NULL;
>   }
> -
>   /*
>    * Lookup a device given by device id, or the path if the id is 0.
>    */
> @@ -2351,6 +2336,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   		struct btrfs_fs_info *fs_info, u64 devid,
>   		const char *device_path)
>   {
> +	struct btrfs_fs_devices *seed_devs;
>   	struct btrfs_device *device;
>   
>   	if (devid) {
> @@ -2364,18 +2350,17 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   	if (!device_path || !device_path[0])
>   		return ERR_PTR(-EINVAL);
>   
> -	if (strcmp(device_path, "missing") == 0) {
> -		/* Find first missing device */
> -		list_for_each_entry(device, &fs_info->fs_devices->devices,
> -				    dev_list) {
> -			if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> -				     &device->dev_state) && !device->bdev)
> -				return device;
> -		}
> -		return ERR_PTR(-ENOENT);
> -	}
> +	device = find_device_by_path(fs_info->fs_devices, device_path);
> +	if (device)
> +		return device;
>   
> -	return btrfs_find_device_by_path(fs_info, device_path);
> +	list_for_each_entry(seed_devs, &fs_info->fs_devices->seed_list,
> +			    seed_list) {
> +		device = find_device_by_path(seed_devs, device_path);
> +		if (device)
> +			return device;
> +	}
> +	return ERR_PTR(-ENOENT);
>   }
>   
>   /*
> 

