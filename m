Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7568F36A603
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYJT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 05:19:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57476 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJT0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 05:19:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13P9AM0A011886;
        Sun, 25 Apr 2021 09:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=c+JE3TkCKJWjgX9jMLENc13pbUF+Jk4hJ9+8ZrbZbRs=;
 b=UzslK42eO598Jx4BJBbfZ8+E+FoxhzlAdBup+fvgAcz8cOtW0sJ6Y/FDVyobqM8YyS0T
 rR9AQBzPmP1Gy+YzZs5OAnxdKmz0m/kp2SdJ6L4zsFj8MKe2Kdz97LdKnDKyjLsWFtw4
 BJsxnkbmDlSJqGqF4Pq/Ss4sYs2CkhwpcIZ8HOTX5T/f+ehOg39rxXl7sN11K+vAvuTQ
 c0yTf5SwEJDCr5nekEo1eAP6fMmBgYV0dHotiaI7dJRhXET86DNwev86Cnn7dUQusMe8
 H+5Vxo5c89xBjZGbnXxuvh7md1xQneT+RXrgr9M0v6zSCP7bEtFUi1JRCVDjLh/jJ5MD 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 384ars1c7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 09:18:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13P9AAaf063855;
        Sun, 25 Apr 2021 09:18:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3849cbqs0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 09:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G21fWM8CW3CCV8xKNOXLSz0X4/ydWNjteqZ0m61wsaZfOCyhHSnHgpEcnzpHzDjri+QAZNydRmwwNZivlqeinckbpT1yhJV/WSG1awG9M897APuJo4zy01dJkA1sYjbq10jwbU2kHyMQ1iH8r1ZWST5LNyhQ77ygiUd94unNYqmqmKQvTz8DqCJLYZX4NfWocs1AuieaidmM1N1BKCIrkDA5uMPzcfYtYChqwdW8XWb/I+hkWmlHhqJc8ZRVLdyW33Jzu8mNwZMhjuE//HppDacUk4NIW3GkKWZ/eskevn5iRibRex8tN+Pg+HPEcE0EIhPfHPvO6TU4z8cO5RxFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+JE3TkCKJWjgX9jMLENc13pbUF+Jk4hJ9+8ZrbZbRs=;
 b=DCvreVwUpZSGnEIe1P9twaPcEKcAL4Mr3DG8GBkJvuMnWpWqPmwIUjN7SuXuZro1oc84SuonZdDve1kQS1zRnLTGaInEorOWbUDQk4Zi4x9UTyWfiYW4M2Dc3Y76WdRCFMiK/ZQkUjn4AH1t2Ras43J5v+6jaut99vVg9fzdx6/0L2O0t/mChY7zpS2BsppMYmeKzYxmwmGj0DV8YyNdVaS/YonT22aRqOxT37SQ/5oGTJFv82boNnGo5SMlJgVS8a7vpYohgXH1px4jiYUvs1rOvC4auryr3XEopsSQT1oG3stLg4aNNntONEciQZ/NAPGfGA8oNlIx3urSnUoUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+JE3TkCKJWjgX9jMLENc13pbUF+Jk4hJ9+8ZrbZbRs=;
 b=GQkN76y1GrfLcRHw/DyVNpUJ9/AFpFXaPYp9LXfaWSNX077aQhOvd5Rph7meUxlA75LJRzMKPQlNf0gx6j9Gff0RrwkHo6BbMtdsesmfJNj0pN3xW/FN6zJJ1CIc9a5ORO/mbxLUhVWdHehda2KI89cY9uJEnPMrbkhgMv3Kih8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 09:18:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 09:18:40 +0000
Subject: Re: fstrim bug with seed+sprout
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQzVWt8CBTgkjBDWE-ZP1HN6gdLd6_7HD5rhxrPypjHYg@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bca03469-6f4d-fa4a-2493-2fbca3fe39ca@oracle.com>
Date:   Sun, 25 Apr 2021 17:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAJCQCtQzVWt8CBTgkjBDWE-ZP1HN6gdLd6_7HD5rhxrPypjHYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:ada7:5e74:421c:5670]
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:ada7:5e74:421c:5670] (2406:3003:2006:2288:ada7:5e74:421c:5670) by SG2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:3:18::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 09:18:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011b2d72-74e9-40d9-e479-08d907cb1cd1
X-MS-TrafficTypeDiagnostic: BLAPR10MB4834:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48349B11D4889F568BA4D1C4E5439@BLAPR10MB4834.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HqKP9ZqmC45cU6eFeGBFhY9b2U5Jj7Cy9/QCliehPIlOp3wU/R0w82B7+re4/rCvPBqtk0l6BkoiYV1g2bO+nxKzmgwvoryW3wfvhV0weYApTV9BlQ6YfjGtKQz9PIs+HbtvfhD5JcOHobLSr1G6kTVQHMJLjmH3BhWuyAz4gLPi6jArlY8N5ql9kONhRRDv8vWO8eJ52t8XAxWVxXxhxuaR2MORcMyUMgMjwjSr/PBphaIqITPiXq7UyA0P/M8ZOowMi8mcEXOWEY0dmRuRsY6AIJm+59wraJ87GBJMfHZ6MA6kjcqcR6hg21Q8RsV34MmevsTe/5sML2Mf+ZFCPwGgyEDxP4RBRKZnWCXXPSbNwgUJB9za21PfSEdxHa4AODDpQ1GASMYCd+Mkha6YeHIl+OLA+ouGW7ztda49vqctQqwku9u0FNKzGVeqUyV08CsnutHtjJiQrW/WtF0BJAy5lFrnQSalvOMkBudK3+R7rs8QvMP2LDadMwjQR4P6FTVQRoGsMXXRYCg/Gpa0PFjprZmzuUDkU9seb+DHo8PmuVE9fmaptBh06125hgz/pYVeppSUtcAYRkQjKyDHOkUXgG0ytfxVwZvSIhBcH0qADVmwuLkEiZjZdABHMaJPtoOH9526I4hDvZ2nIlkBhwLd2f+B/OZfpYTGc9nDO7eCQEaPKF8suOZDk9nBf5gIlF1tIv55G4zzPyR7rlKumlnRj+iA7ENBcXuhJ+0m868uL5rLVwO/5KPejHCWzHx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(8676002)(6486002)(83380400001)(31696002)(66556008)(66476007)(31686004)(38100700002)(36756003)(2616005)(44832011)(110136005)(316002)(66946007)(53546011)(6666004)(5660300002)(8936002)(86362001)(186003)(966005)(16526019)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UjJlenVDbWl2Z28zRUVhZnlLekJNTmdxa1NYY0dGMXFBM3VqL0h0Qmh1T3ds?=
 =?utf-8?B?TllYNDhFQWNBOVFjQitLaXE1VktDR1lhYzBpSUhDNFMyTGdHL0RkMjI5bVk0?=
 =?utf-8?B?WlVONWxIZEd2dU9yVTBFNTA5Y2d6QlR6aVJjSXJTTldOWFlxdzJYdldKTFRv?=
 =?utf-8?B?M2ZlbXVvS2tuOUV1MGtndk9QSHBBWmhic0FKOUhVL1JyUTNOTGNHbk4rK0hO?=
 =?utf-8?B?SVV4SmRvSndKd2RJWFdFU0d2VDgxTnIwaTdTWWxXUDVxNDdJSkRlN2pra0Nw?=
 =?utf-8?B?ZUJqTlNkRjdZbzNVMU9xYnMzQ2JKZUJkd002SUluQlZGbHlzM2tQb2hwaHAw?=
 =?utf-8?B?bjFRZndOUXp1VWdPMXJGSUhTYzZEWUtKSURUQmUreDVmekQ1MWhJTXBNcFgx?=
 =?utf-8?B?NkxhVWU2MTN3TGxja2ZycVBBTk92cHNFeGlqSFFELzhDMHJNZ0IxeDJQdWZ6?=
 =?utf-8?B?RVZXUWZhSzRKdWdacVVFUWl5OHU1V0NOQ3RScU1vTDFoOWJhNmJESGJpMG00?=
 =?utf-8?B?RUhjWUtFSy9XdTBlRlBQcFIzVFA3OXN2UVBwSXFLUUl3MkhESG1XMEYxOFhY?=
 =?utf-8?B?Q2E4VGZjNGNZTWxoS1dranpHdDhTS2w0Z0tOUGo2aGhGY0VvVGk4b3NQY2tt?=
 =?utf-8?B?MUhSai95OFZocFQ0UEhQQnFmUzJMenNmQzdHZDVBYlVLV3labWhHeU81ZTFr?=
 =?utf-8?B?bFIwMzhnRFRSQzIwK1dxc2NpQmF3eXBweDU4OE1rWUJsYkRRUDQwaFRwY2RU?=
 =?utf-8?B?VDBZY1IzUTNlTi81YktCMmR3ZnRzaHo3NkFKNmtMeHRNTFRNQlBGZjVQcXp1?=
 =?utf-8?B?eVlTa1cyUmhVdzFDeEthK0E5R3E2NnVHcGdEYXhPVW55akpDeWViTVRiQnBL?=
 =?utf-8?B?M01hMjBVMTN1R2Zqa1Bxd1BwdDlnUEpRQUVJQ01wVGNlZ0QyZUh1d2o3MEVQ?=
 =?utf-8?B?WUp5OHJpTFdIcVpxVHN1U3hJN2dZTjBXcm5PU0JqWUNzSDJ0dkhXdGtBbFNV?=
 =?utf-8?B?MU8ydDUxSDQvSkhmVEFDOTE5N0pNcGV5TzB4MHR4T2dKQkkxeHl5NDFVMzNT?=
 =?utf-8?B?ci9RNm1DMVBXUk9wNWt5a3YvSVdvWnNmeURyd3BlMk1pU2xDOXVka1Jsd3p1?=
 =?utf-8?B?MlBjb3BoMGdSeXB2RkhxZlovMjdmQSt0ZnpZcS9ESEZ5TjZwdVQxSzd1T2F5?=
 =?utf-8?B?QzFoTWlPZEhVWnBMRXZ4cktvYUtGQ01kNFhReEFFT3NJU3lYMUN2Vkkyb1VW?=
 =?utf-8?B?ODJYNkNTN3hSTzZvWUt3R1ZycjBVbklFOTBib29YU1Y4NUZpbndYbXNVS2xN?=
 =?utf-8?B?d2d0ZTNSRXExY29ieW5EeTEyZi9wYnBDcFdDeGplODdqOGtYU1hsRk1QRUx1?=
 =?utf-8?B?aktQTVVCdkVtTDY0YmlWVGU1OXBmMnZrMndkZCtkS0ZHTHFselQwc3FwbUxJ?=
 =?utf-8?B?aXlUYjhjSXhpeFBnMEdkTm5EcmhtMWxrNTVnVThIQmlDUmlDaFg2WWlNRU1l?=
 =?utf-8?B?TllxU1UxODIvbk5CVzRiYWFkTGRnQmpBWmFQeHZFcUlTK0VXRHUxbUZBcW9K?=
 =?utf-8?B?clROLzhab0FkakdXZVBJOWRuajZVMHkvaEViTVdOT0V6UzY2SlZpOU1qY3c3?=
 =?utf-8?B?YWZ2M2ErNTZseng1VDZ5N1FIYzNWS2RTSGR4c2Z4VnZ6WXhGRnJmY0kxYWdj?=
 =?utf-8?B?ME9CTmdrNVh6R0NtS21DSzVhQ3RmcVBLY0U2M3RnZ3RpR1pjbjhyVzZuWHpY?=
 =?utf-8?B?cGx3QTZWd1Q4UFlyTG40WkY3clRGNk1XMTVDeHU3eS9kekxsVEFPTVZSYzRu?=
 =?utf-8?B?aDRFZ3dGZXU3Z3RQNXZSbkZIeXYxR1dRbEU2cEdjSHkvSGp1WUdsUmlOM25o?=
 =?utf-8?Q?P8tH+BhoxpMVg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011b2d72-74e9-40d9-e479-08d907cb1cd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 09:18:40.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Pe6oxBNwtLrx9yLLTsFHcdUQzG004crWQhfV6YOne+nrHVgC+wKSt1q7sg8UGOPM2ZENIk8c9Zti4DRoc0kFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250068
X-Proofpoint-ORIG-GUID: kIEfggcuM5zSu3WSHbBO6FLQB6h-tfGv
X-Proofpoint-GUID: kIEfggcuM5zSu3WSHbBO6FLQB6h-tfGv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250068
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/04/2021 11:11, Chris Murphy wrote:
> kernel 5.11.12-300.fc34.x86_64
> btrfs-progs v5.11.1
> 
> When I create a seed device, add a 2nd device and remount rw. The seed
> has not been removed. Then fstrim the mounted file system, there is no
> error.
> 
> Later, I notice I can still mount the sprout without error, but the
> seed can't be mounted.
> 
> # btrfs fi show
> Label: 'btresq'  uuid: 4ed49145-a1d4-45f7-9131-3e9ef71d0bc4
>      Total devices 1 FS bytes used 2.36GiB
>      devid    1 size 3.27GiB used 3.27GiB path /dev/vda3
> 
> Label: 'btrsprout'  uuid: ded321fb-c2d5-41e2-83f3-b29c56559492
>      Total devices 2 FS bytes used 2.36GiB
>      devid    1 size 3.27GiB used 3.27GiB path /dev/vda3
>      devid    2 size 28.13GiB used 1.28GiB path /dev/vda4
> 
> # mount /dev/vda3 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/vda3,
> missing codepage or helper program, or other error.
> # dmesg | grep -i btrfs
> 
> [  209.944938] BTRFS info (device vda3): using free space tree
> [  209.944954] BTRFS info (device vda3): has skinny extents
> [  209.950240] BTRFS error (device vda3): bad tree block start, want
> 5373952 have 0
> [  209.950278] BTRFS warning (device vda3): couldn't read tree root
> [  209.951611] BTRFS error (device vda3): open_ctree failed
> # btrfs check /dev/vda3
> Opening filesystem to check...
> checksum verify failed on 5373952 wanted 0x0000000000000000 found
> 0x3e76427c81028f58
> checksum verify failed on 5373952 wanted 0x0000000000000000 found
> 0x3e76427c81028f58
> bad tree block 5373952, bytenr mismatch, want=5373952, have=0
> Couldn't read tree root
> ERROR: cannot open file system


Yep. It is fstrim. I could reproduce.
But we rightly skip discard to the rdonly devices [1]... I am looking more.

[1]
-----------------
static int btrfs_trim_free_extents(struct btrfs_device *device, u64 
*trimmed)
{
         u64 start = SZ_1M, len = 0, end = 0;
         int ret;

         *trimmed = 0;

         /* Discard not supported = nothing to do. */
         if (!blk_queue_discard(bdev_get_queue(device->bdev)))
                 return 0;

         /* Not writable = nothing to do. */
         if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
                 return 0;
------------

Thanks, Anand


> # mount /dev/vda4 /mnt
> # btrfs scrub start /mnt
> scrub started on /mnt, fsid ded321fb-c2d5-41e2-83f3-b29c56559492 (pid=2508)
> # btrfs scrub status /mnt
> UUID:             ded321fb-c2d5-41e2-83f3-b29c56559492
> Scrub started:    Sat Apr 24 22:45:53 2021
> Status:           aborted
> Duration:         0:00:00
> Total to scrub:   2.36GiB
> Rate:             0.00B/s
> Error summary:    no errors found
> [root@localhost-live ~]# dmesg
> ...
> [  235.034276] BTRFS info (device vda4): using free space tree
> [  235.034292] BTRFS info (device vda4): has skinny extents
> [  244.815594] BTRFS error (device vda4): scrub on devid 1: filesystem
> on /dev/vda3 is not writable
> [  244.815689] BTRFS info (device vda4): scrub: started on devid 2
> [  244.818387] BTRFS info (device vda4): scrub: finished on devid 2
> with status: 0
> 
> 
> /dev/vda3 "seed"
> dev_item.total_bytes    3512729600
> dev_item.bytes_used    3510632448
> 
> lsblk --bytes
> ├─vda3      252:3    0  3512729600  0 part
> 
> 
> /dev/vda4 "sprout"
> dev_item.total_bytes    30204211200
> dev_item.bytes_used    301989888
> 
> lsblk --bytes
> └─vda4      252:4    0 30204214784  0 part
> 
> # btrfs-image -c9 -t4 /dev/vda3 vda3.btrfsimage
> checksum verify failed on 5373952 wanted 0x0000000000000000 found
> 0x3e76427c81028f58
> checksum verify failed on 5373952 wanted 0x0000000000000000 found
> 0x3e76427c81028f58
> bad tree block 5373952, bytenr mismatch, want=5373952, have=0
> Couldn't read tree root
> ERROR: open ctree failed
> ERROR: create failed: -5
> # btrfs-image -c9 -t4 /dev/vda4 vda4.btrfsimage
> 
> 21.5M image file:
> https://drive.google.com/file/d/1yhbijHXACWu5FvRfTrf2EjTBzIaFx8wQ/view?usp=sharing
> 
> I haven't tried to reproduce this yet, so I'm not certain it was the
> fstrim. But it seems pretty clear that the file system on vda3 "seed"
> is damaged and it's OK on vda4 "sprout", and the damage show metadata
> has been zero'd out consistent with misapplied trim. And vda4 probably
> survives because enough metadata has already been cow'd to the sprout.
> 
> # btrfs rescue chunk -v /dev/vda3
> this device is seed device
> recover prepare error
> Chunk tree recovery failed
> # btrfs rescue chunk -v /dev/vda4
> All Devices:
>      Device: id = 2, name = /dev/vda4
> 
> Scanning: DONE in dev0
> DEVICE SCAN RESULT:
> Filesystem Information:
>      sectorsize: 4096
>      nodesize: 16384
>      tree root generation: 60
>      chunk root generation: 58
> 
> All Devices:
>      Device: id = 2, name = /dev/vda4
> 
> All Block Groups:
>      Block Group: start = 5242880, len = 8388608, flag = 4
>      Block Group: start = 1095761920, len = 268435456, flag = 4
>      Block Group: start = 3511681024, len = 268435456, flag = 4
>      Block Group: start = 3813670912, len = 33554432, flag = 2
>      Block Group: start = 3847225344, len = 1073741824, flag = 1
> 
> All Chunks:
>      Chunk: start = 5242880, len = 8388608, type = 4, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 5242880
>      Chunk: start = 13631488, len = 8388608, type = 1, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 13631488
>      Chunk: start = 22020096, len = 1073741824, type = 1, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 22020096
>      Chunk: start = 1095761920, len = 268435456, type = 4, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 1095761920
>      Chunk: start = 1364197376, len = 1073741824, type = 1, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 1364197376
>      Chunk: start = 2437939200, len = 1073741824, type = 1, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 1, offset = 2437939200
>      Chunk: start = 3511681024, len = 268435456, type = 4, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 2, offset = 1048576
>      Chunk: start = 3813670912, len = 33554432, type = 2, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 2, offset = 303038464
>      Chunk: start = 3847225344, len = 1073741824, type = 1, num_stripes = 1
>          Stripes list:
>          [ 0] Stripe: devid = 2, offset = 336592896
> 
> All Device Extents:
>      Device extent: devid = 1, start = 5242880, len = 8388608, chunk
> offset = 5242880
>      Device extent: devid = 1, start = 13631488, len = 8388608, chunk
> offset = 13631488
>      Device extent: devid = 1, start = 22020096, len = 1073741824,
> chunk offset = 22020096
>      Device extent: devid = 1, start = 1095761920, len = 268435456,
> chunk offset = 1095761920
>      Device extent: devid = 1, start = 1364197376, len = 1073741824,
> chunk offset = 1364197376
>      Device extent: devid = 1, start = 2437939200, len = 1073741824,
> chunk offset = 2437939200
>      Device extent: devid = 2, start = 1048576, len = 268435456, chunk
> offset = 3511681024
>      Device extent: devid = 2, start = 303038464, len = 33554432, chunk
> offset = 3813670912
>      Device extent: devid = 2, start = 336592896, len = 1073741824,
> chunk offset = 3847225344
> 
> CHECK RESULT:
> Recoverable Chunks:
>    Chunk: start = 5242880, len = 8388608, type = 4, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 5242880
>        Block Group: start = 5242880, len = 8388608, flag = 4
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 5242880, len =
> 8388608, chunk offset = 5242880
>    Chunk: start = 1095761920, len = 268435456, type = 4, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 1095761920
>        Block Group: start = 1095761920, len = 268435456, flag = 4
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 1095761920, len =
> 268435456, chunk offset = 1095761920
>    Chunk: start = 3511681024, len = 268435456, type = 4, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 2, offset = 1048576
>        Block Group: start = 3511681024, len = 268435456, flag = 4
>        Device extent list:
>            [ 0]Device extent: devid = 2, start = 1048576, len =
> 268435456, chunk offset = 3511681024
>    Chunk: start = 3813670912, len = 33554432, type = 2, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 2, offset = 303038464
>        Block Group: start = 3813670912, len = 33554432, flag = 2
>        Device extent list:
>            [ 0]Device extent: devid = 2, start = 303038464, len =
> 33554432, chunk offset = 3813670912
>    Chunk: start = 3847225344, len = 1073741824, type = 1, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 2, offset = 336592896
>        Block Group: start = 3847225344, len = 1073741824, flag = 1
>        Device extent list:
>            [ 0]Device extent: devid = 2, start = 336592896, len =
> 1073741824, chunk offset = 3847225344
>    Chunk: start = 13631488, len = 8388608, type = 1, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 13631488
>        No block group.
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 13631488, len =
> 8388608, chunk offset = 13631488
>    Chunk: start = 22020096, len = 1073741824, type = 1, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 22020096
>        No block group.
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 22020096, len =
> 1073741824, chunk offset = 22020096
>    Chunk: start = 1364197376, len = 1073741824, type = 1, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 1364197376
>        No block group.
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 1364197376, len =
> 1073741824, chunk offset = 1364197376
>    Chunk: start = 2437939200, len = 1073741824, type = 1, num_stripes = 1
>        Stripes list:
>        [ 0] Stripe: devid = 1, offset = 2437939200
>        No block group.
>        Device extent list:
>            [ 0]Device extent: devid = 1, start = 2437939200, len =
> 1073741824, chunk offset = 2437939200
> Unrecoverable Chunks:
> 
> Total Chunks:        9
>    Recoverable:        9
>    Unrecoverable:    0
> 
> Orphan Block Groups:
> 
> Orphan Device Extents:
> 
> Check chunks successfully with no orphans
> Chunk tree recovered successfully
> 
> 

