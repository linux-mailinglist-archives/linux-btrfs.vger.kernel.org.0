Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5346980B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245506AbhLFOLf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 09:11:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46302 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245700AbhLFOLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 09:11:18 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6D7xsS006635;
        Mon, 6 Dec 2021 14:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=cS2KHfPhhJIwxQ8qXCqdsLpO3zpPRaXHVVk2ZeVGeu0=;
 b=tMVlFPWwcqAInYsxodIfuczxwRsZ/Fm43VThegyHK+tinVo+FeZaws/kX6qe1PduGdJs
 4xjlyMiVfx6s95VOCyoN5Dq7w+q9Jjlxi/BPCVZ4zicSNuhTB7/poJabu+u2Oep7FF4C
 NKMdRofyfVJaiNGdKVoTVvi12JaGh4LuY4CdWiBjG52X/BEgrX+xhXdDWeIieHGFl/i0
 X27mxlFzJ6aYDTcM2HwTXlUKtF4I21zdTDh5I2ctKx/VZzQeNIABEZONqVhsDxIS0FHX
 UcAmd1RFpRlidgb58o8W071Cag43XzStlAzhDQ/89uTzX1XlcQh+p7mNdHlU7FgdCfwt sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72a6cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:07:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6E63dj007433;
        Mon, 6 Dec 2021 14:07:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3020.oracle.com with ESMTP id 3cr053faht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJBv55qsh4uOQGR1H5t8g+Ak/o3+Dp7eS9yYjZYAlFXgB0gWrS2H+9Yk9lIt+6SoIJThYv13929hmv3Yd8A4efkna2jgY/eTHOvma6lsQdC0hcsnvEtyt/ttErU1RdOJaj/YgyySQpCri+ptGyaCBY5Kz+UOAna0U1epACO+mdZEIYseTHCgYW5fqijrMdTxDzRpafbtJRJ8hQjg9daInj1S+e9GdAqla5R+gRBbPHPVvuVrJISUWscDW0o8EKDdSSlrBBPIlQYXyvNooA0z930l5b/mbwhnG3v9Hk81SWvp+e2SEd5t1A72sqRKDa9c63R/TjKtkoZc0sKcOc921g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS2KHfPhhJIwxQ8qXCqdsLpO3zpPRaXHVVk2ZeVGeu0=;
 b=csqViXObN91cZFqkypz7O90QSAz6zSsKOZR7HHuvPA/u0QkbSxH3s6S4FB13zJqVGVXxk6y1a1AJz5NUHy7b8fk0HU15ROKXTh52mIqdcu6019NHFdQuG/9dCd7zSMzzlDV3OJHTwPZzTzgMI4/WH+3o6MGjfqpy8bOHNEa5dvnXNSkiKV50iIHGlgDxvK/nJnyU1ZMJloqY6WbCyLLnXaEwf056Ll6dPQaYNCmdwNC0XMzJWEyUQAYPl6k5zdaU+pcRQWu7WobrSHsYHNi5LznbX5rhsJ4w9OU38/GHUwypbNDkXoUoW9ynOvSQa6BdkaLSmB97ECF73hFM+ufJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS2KHfPhhJIwxQ8qXCqdsLpO3zpPRaXHVVk2ZeVGeu0=;
 b=dXc6kNOXD51CL29vjgt6L2fz3O6n0B2cCmdmQAWYJ6O//XXhg78clz8VDdmploBZf2f8K2Sedq3ZHixnNCygv4cH5F56QCdRmBU4BUKg6LGFop+7WEedXhmoDIZc14txFt676/lL/HzvHRY+9aFTWTUd0FwumSrxbFeiSL+7TzY=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by SN6PR10MB2976.namprd10.prod.outlook.com (2603:10b6:805:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 14:07:42 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::75ca:e478:6788:d21d]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::75ca:e478:6788:d21d%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 14:07:42 +0000
References: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
 <YajcBNMm3dR4YI/N@debian9.Home> <YajqH1Njtqz0ZXF+@localhost.localdomain>
 <87ilw2qo6z.fsf@debian-BULLSEYE-live-builder-AMD64>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
In-reply-to: <87ilw2qo6z.fsf@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <87fsr5rfmk.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Mon, 06 Dec 2021 19:37:31 +0530
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:404:15::33) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
Received: from nandi (138.3.205.52) by TYAPR04CA0021.apcprd04.prod.outlook.com (2603:1096:404:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 14:07:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822534c7-a2bd-4ee5-8383-08d9b8c1c4b7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2976:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2976A43353E2E51FD438F6E0F66D9@SN6PR10MB2976.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t29KR91Wf6wNtxYELgx/jgFWaXRZumRJu1Vzw+bXETBQqCckH1Im5m/W2yJ+3tZAyMy0coHCW43IY8GuLZdJA5yujr/Pm7he2j969GnGn20BSirkOjOa5MQSsUTge9mVslaOF0K5ZQx6VGbqwbEKI9kCeXQvrH9siBW6w04a048CNCEYJzlS+boRV1e8bDaZWb1Qas3FxFiKBubg61fv7kJDRpUUV2KbisbTB76rYu0DjtHe+YNrsIlkOkMNfx98vnqDV4Dh4TUgblBMBZWnCywtP34qtIzvZfr263rBaZ8DuwnR8SH1cGBdB8zmqaJpGKi9xqJAfoGx02t8c3g15zNhVZPcZfLKDF4uPJuENcQI+l5bFGBKNVkqz3N37X+7XNJfdG+f49htE1jsJIqfwRloIw32hJG1aGNa/kFNBfhKZ0HceXAIm9WkXmKdezU7+tiZogInylau6RJH8FQzms/tz7POWFla26TwK97liQjxLpdhWvLO6a2ouFHam2PdonbE/bXX402gDcyOk5aZecSjG48GQR6oqo5a/wpltxNxeIgljIALR2t6KK9PRYum7hDzoIilMRCOz63BFGqaCOZ3PLHpW4mVDBCLtz+0WH9Ie6dKOoY0T3/V3mbgSNGEMrXK+WcRw7bQCN7f7yPcDTGTzxwwa/VUe9N0Q5XAfxEIGLfhLjh2dbEPjJh84f4LuQ0IYAIO2NPQ9crg6JCKuwN9tzCb0v5dsGOckXpu2CA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(86362001)(53546011)(9686003)(66946007)(38350700002)(316002)(66476007)(6916009)(52116002)(6496006)(5660300002)(6666004)(6486002)(83380400001)(508600001)(66556008)(30864003)(38100700002)(4326008)(26005)(2906002)(8936002)(186003)(956004)(4001150100001)(8676002)(33716001)(40140700001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YQ0k1lx9X2KU6VQUX9MRu8NbhpDclPyJj7/dwPWflNeVO9ITSNdkOYX0/cU?=
 =?us-ascii?Q?gLR1BUvZwLpyyzaC+7nzfXbTSFVV13wwV8GYZigldUGDop7maArqpptA6VuT?=
 =?us-ascii?Q?qxE9MmurxLicUJRLenRJhK9/Schub3JII5WOw3azJVIahjQxQzK/pS+aPQVi?=
 =?us-ascii?Q?N4CciF9tY5j7Ozb1UbC7AtigGV6WGxTlnxHdlkB28G1oXVzHHKh5z82D6PGC?=
 =?us-ascii?Q?BjBhZd3oKhuwkXFCWm2dF0ENt4ST9OTX1kwzI4jzxWAxAQuRcncj+DmyXpQU?=
 =?us-ascii?Q?zQZAU2qslnsRYnbo2FpshRvqoVXnw3sbDejbHmzzilatYOod/cJtFWWSjJ3a?=
 =?us-ascii?Q?MSsjeYmJZQGvF4ECex0zZ2vmIvjj/ANrYZe20S233R5eMVvNIRUBFE7up2i8?=
 =?us-ascii?Q?in9VVYZ9vGFdDCbeWrJMspl7gLAsT9kLodcaLGdqHYTdun9WntiexwPFNU8a?=
 =?us-ascii?Q?761FLDyALmr2BA+USAozGRMCPVy+JW1vTXS4elbPQzrHxuxoEVDmimx3+Ya4?=
 =?us-ascii?Q?rZggV3SEs4ZU9JOJ93FsjCA6a1B3xylQvVkGFca8S+qwUZe1s0bLRgUk1sBk?=
 =?us-ascii?Q?ZxYzm0tiZ1wcJOenV77v1PZKN7HBG3G4PCk+zzofp8WR4EZ1PEduBCz+wUKw?=
 =?us-ascii?Q?y71tE3M2FPIudVUaDUs4+emwMQ/o+5XdcUvHhFRmhpQRil4y0bNPK1ZsswEq?=
 =?us-ascii?Q?M2KfIN+0J7JF/lTulj/ar2iGDv7c2uIO01wihtrWzgx180Z33SJ+vUc+rsSB?=
 =?us-ascii?Q?32lwPUfhByntT2OtFGieOxL3R+8YaQvHGMckYRzdSfjqxZvkrPn7Ka4fA/6N?=
 =?us-ascii?Q?2nnN1bT7oc/kJT2fO/WBCOYMSgH6aMd3fucb5PMgD1NOspgODutRx6axEi7j?=
 =?us-ascii?Q?4hYD57gqk9jvwkgJ/8dkitLDzquPYJ+K8TaG1/m4JM2sGFPffpxr5Puxj0ed?=
 =?us-ascii?Q?v0UTIn16OpKIptY9JJcUfoJO17aNLc+12KGX3xTsrg1nBy14C7kK5Xn9yZo2?=
 =?us-ascii?Q?phf3NqgYM/iRiAWOY3qUxbue31UojEJtBVm90Tw9xKxO7loEPw9K5Kq3DF4s?=
 =?us-ascii?Q?j/4BqbjQZuuRx5WDtOUx87opL/kSqKgcuNTRSOEx862RROGz/GdLMiqQwIGp?=
 =?us-ascii?Q?cpyREr465QsOHmv7X8OuGP6o15fdv4KJfXngJc4u3FwDY948bFKF4nvpDSXY?=
 =?us-ascii?Q?4NCAih/0tOI+JygjwVJ9DF0fkb9n5+j5osIjajZmCrsJiA5TBNdk9tyLUzpd?=
 =?us-ascii?Q?n/ivO/C4CendG4BZXxVPP8vzoFVi3Y3hDoiR7NeWqvzbCXhXypVeOTmcmj64?=
 =?us-ascii?Q?n5OU/eI+jnWaWRbe5veNLu6EffJK/FG7LJhm9eEldjH/gAS0Hybw7bDIsB13?=
 =?us-ascii?Q?bvkc7tVLCt+x+M3Q9mf7h8YjW3tS8i6eJM4RQmSRegStPmpqYWD5iVHapB0M?=
 =?us-ascii?Q?pAasojXxmnWfgNlyhOCydMGWmCq8RKO/grhaGN0xAYFYHMWMXoU1SVX/j/N8?=
 =?us-ascii?Q?d0HE5KFtzo4qvkgOdRe4jDylQoHu0Tl8G+hfA2BpwNHzJoKcgkjx1IltYZe3?=
 =?us-ascii?Q?U0qE4JWBqEJ8gQhYKM/IBrMazYapCclgM5Di0Vj6F3kFASDxKXAkZICCjmXG?=
 =?us-ascii?Q?RYMoM632kHZWcW7yrpWDJj4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822534c7-a2bd-4ee5-8383-08d9b8c1c4b7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:07:42.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1kTs9hTuASoMhH1eQRQT7dqagha2u3gSu+2xAgtm1KAOcdrcK6CFtyKWR6lvz01XZi0UYMa2M88WWjFdMCKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2976
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060088
X-Proofpoint-ORIG-GUID: LOfPpTGHrBrSqmqUjMvO-KR3RJTumpDM
X-Proofpoint-GUID: LOfPpTGHrBrSqmqUjMvO-KR3RJTumpDM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06 Dec 2021 at 11:17, Chandan Babu R wrote:
> On 02 Dec 2021 at 21:15, Josef Bacik wrote:
>> On Thu, Dec 02, 2021 at 02:45:24PM +0000, Filipe Manana wrote:
>>> On Wed, Dec 01, 2021 at 01:18:52PM -0500, Josef Bacik wrote:
>>> > We've been seeing transient errors with any test that uses a dm device
>>> > for the entirety of the time that we've been running nightly xfstests
>>> 
>>> I have been having it on my tests vms since ever as well.
>>> It's really annoying, but fortunatelly it doesn't happen too often.
>>> 
>>
>> Yeah before this change we'd fail ~6 tests on every configruation on every
>> overnight run.  With this change we fail 0.  It's rare, but with our continual
>> testing it happens sooooooo much.
>>
>>> > runs.  This turns out to be because sometimes we get EBUSY while trying
>>> > to create our new dm device.  Generally this is because the test comes
>>> > right after another test that messes with the dm device, and thus we
>>> > still have udev messing around with the device when DM tries to O_EXCL
>>> > the block device.
>>> > 
>>> > Add a UDEV_SETTLE_PROG before creating the device to make sure we can
>>> > create our new dm device without getting this transient error.
>>> 
>>> I suspect this might only make it seem the problem goes away but does not
>>> really fix it.
>>> 
>>> I say that for 2 reasons:
>>> 
>>> 1) All tests that use dm end up calling _dmsetup_remove(), like through
>>>    _log_writes_remove() or _cleanup_flakey() for example. Normally those
>>>    are called in the _cleanup() function, which ensures it's done even if
>>>    the test fails for some reason.
>>> 
>>>    So I don't understand why we need that UDEV_SETTLE_PROG at _dmsetup_create().
>>> 
>>>    And I've seen the ebusy failure happen even when the previous tests did
>>>    not use any dm device;
>>> 
>>> 2) Some tests fail after creating the dm device and using it. For example
>>>    btrfs/206 often fails when it tries to fsck the filesystem:
>>> 
>>>    btrfs/206 3s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad)
>>>         --- tests/btrfs/206.out     2020-10-16 23:13:46.554152652 +0100
>>>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad      2021-12-01 21:09:46.317632589 +0000
>>>         @@ -3,3 +3,5 @@
>>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>         wrote 8192/8192 bytes at offset 0
>>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>         +_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>>>         +(see /home/fdmanana/git/hub/xfstests/results//btrfs/206.full for details)
>>>         ...
>>> 
>>>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/206.out /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad'  to see the entire diff)
>>> 
>>>     In the .full file I got:
>>> 
>>>     (...)
>>>     replaying 1239@11201: sector 2173408, size 16384, flags 0x10(METADATA)
>>>     replaying 1240@11234: sector 0, size 0, flags 0x1(FLUSH)
>>>     replaying 1241@11235: sector 128, size 4096, flags 0x12(FUA|METADATA)
>>>     _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>>>     *** fsck.btrfs output ***
>>>     ERROR: cannot open device '/dev/sdc': Device or resource busy
>>>     ERROR: cannot open file system
>>>     Opening filesystem to check...
>>>     *** end fsck.btrfs output
>>>     *** mount output ***
>>> 
>>>    The ebusy failure is not when the test starts, but when somewhere in the middle
>>>    of the replay loop when it calls fsck, or when it ends and the fstests framework
>>>    calls fsck.
>>> 
>>>    I've seen that with btrfs/172 too, which also uses dm logwrites in a similar way.
>>> 
>>> So to me this suggests 2 things:
>>> 
>>> 1) Calling UDEV_SETTLE_PROG at _dmsetup_create() doesn't solve that problem with
>>>    btrfs/206 (and other tests) - the problem is fsck failing to open the scratch
>>>    device after it called _log_writes_remove() -> _dmsetup_remove(), and not a
>>>    failure to create the dm device;
>>> 
>>> 2) The problem is likely something missing at _dmsetup_remove(). Perhaps add
>>>    another UDEV_SETTLE_PROG there:
>>> 
>>>    diff --git a/common/rc b/common/rc
>>>    index 8e351f17..22b34677 100644
>>>    --- a/common/rc
>>>    +++ b/common/rc
>>>    @@ -4563,6 +4563,7 @@ _dmsetup_remove()
>>>             $UDEV_SETTLE_PROG >/dev/null 2>&1
>>>             $DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
>>>             $DMSETUP_PROG mknodes >/dev/null 2>&1
>>>     +       $UDEV_SETTLE_PROG >/dev/null 2>&1
>>>      }
>>>  
>>>     _dmsetup_create()
>>> 
>>>   I can't say if that change to _dmsetup_remove() is correct, or what it's
>>>   needed, as I really haven't spent time trying to figure out why the issue
>>>   happens.
>>> 
>>
>> I actually tried a few iterations before I settled on this one, but I was only
>> trying to reproduce the EBUSY when creating the flakey device, I hadn't seen it
>> with fsck.  So I originally started with your change, but it didn't fix the
>> problem.  Then I did both, UDEV_SETTLE at the end of remove and at the beginning
>> of create and the problem went away, and then I removed the one from remove and
>> the problem still was gone.
>>
>> But since I've made this change I also have been investigating another problem
>> where we'll get EBUSY at mkfs time when we use SCRATCH_DEV_POOL.  I have a test
>> patch in our staging branch to make sure it actuall fixes it, but I have to add
>> this to the start of _scratch_pool_mkfs as well.
>>
>> It turns out that udev is doing this thing where it writes to
>> /sys/block/whatever/uevent to make sure that a KOBJ_CHANGE event gets sent out
>> for the device.
>>
>> This is racing with the test doing a mount.  So the mount gets O_EXCL, which
>> means the uevent doesn't get emitted until umount.  This would explain what
>> you're seeing, we umount, we get the KOBJ_CHANGE event once the O_EXCL is
>> dropped, udev runs, and then fsck gets an EBUSY.
>
> I started debugging this issue late last week. Among several tests which
> failed, xfs/033 was failing once in a while because the umount syscall
> returned -EBUSY. Debugging this further led me to the following,
>
> 1. Mounting an fs causes udev to invoke xfs_spaceman (via udisksd => xfs_info).
>    This causes the per-cpu counter at mount->mnt_pcp->mnt_count to increase by
>    1.
> 2. Unmount at this stage causes the umount syscall to fail since the refcount
>    on struct mount is greater than 2.
>
> I changed my test disks from the regular /dev/sd* devices to loop devices. I
> then added loop devices to be ignored by udev with the following change in
> /lib/udev/rules.d/60-persistent-storage.rules,
>
> KERNEL!="sr*|loop*", IMPORT{builtin}="blkid"
>
> This led to xfs/033 execute fine for 100 times without failure.

> However, other tests which use device mapper devices are still failing
> arbitrarily. 

This failure occurs because 60-persistent-storage-dm.rules has the following,

# Add inotify watch to track changes on this device.
# Using the watch rule is not optimal - it generates a lot of spurious
# and useless events whenever the device opened for read-write is closed.
# The best would be to generete the event directly in the tool changing
# relevant information so only relevant events will be processed
# (like creating a filesystem, changing filesystem label etc.).
#
# But let's use this until we have something better...                                                                                          
LABEL="dm_watch"
OPTIONS+="watch"

Hence any change to the device will generate a uevent causing udev's internal
blkid to be invoked. This ends up forking and executing xfs_spaceman.

>
> Looks like a simple mount operation causes udev to indirectly invoke
> xfs_spaceman as described by the output of perf script,
>
> bash 50034 [002]  2541.601278: sched:sched_process_fork: comm=bash pid=50034 child_comm=bash child_pid=50044
> mount 50044 [003]  2541.601851: sched:sched_process_exec: filename=/usr/bin/mount pid=50044 old_pid=50044
> systemd-udevd   173 [000]  2541.620525: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50048
> systemd-udevd   173 [000]  2541.621071: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50051
> systemd-udevd   173 [000]  2541.621562: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50052
> systemd-udevd   173 [000]  2541.621971: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50053
> systemd-udevd   173 [000]  2541.622657: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50054
> udisksd   588 [000]  2541.675852: sched:sched_process_fork: comm=udisksd pid=588 child_comm=udisksd child_pid=50058
> xfs_admin 50058 [000]  2541.676645: sched:sched_process_exec: filename=/usr/sbin/xfs_admin pid=50058 old_pid=50058
> xfs_admin 50058 [000]  2541.677317: sched:sched_process_fork: comm=xfs_admin pid=50058 child_comm=xfs_admin child_pid=50059
> xfs_db 50059 [000]  2541.677569: sched:sched_process_exec: filename=/usr/sbin/xfs_db pid=50059 old_pid=50059
> udisksd   588 [003]  2541.687075: sched:sched_process_fork: comm=udisksd pid=588 child_comm=udisksd child_pid=50060
> xfs_info 50060 [001]  2541.687843: sched:sched_process_exec: filename=/usr/sbin/xfs_info pid=50060 old_pid=50060
> xfs_info 50060 [001]  2541.688362: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50061
> xfs_info 50061 [003]  2541.688615: sched:sched_process_fork: comm=xfs_info pid=50061 child_comm=xfs_info child_pid=50062
> xfs_info 50062 [001]  2541.688810: sched:sched_process_fork: comm=xfs_info pid=50062 child_comm=xfs_info child_pid=50063
> xfs_info 50062 [001]  2541.688944: sched:sched_process_fork: comm=xfs_info pid=50062 child_comm=xfs_info child_pid=50064
> losetup 50063 [003]  2541.689058: sched:sched_process_exec: filename=/usr/sbin/losetup pid=50063 old_pid=50063
> tail 50064 [000]  2541.689169: sched:sched_process_exec: filename=/usr/bin/tail pid=50064 old_pid=50064
> xfs_info 50060 [001]  2541.690200: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50065
> findmnt 50065 [003]  2541.690501: sched:sched_process_exec: filename=/usr/bin/findmnt pid=50065 old_pid=50065
> xfs_info 50060 [001]  2541.692154: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50066
> xfs_spaceman 50066 [003]  2541.692345: sched:sched_process_exec: filename=/usr/sbin/xfs_spaceman pid=50066 old_pid=50066
>
> xfs_spaceman in turn causes ref count on struct mount to increase. Hence an
> unmount operation can fail with -EBUSY error.
>
>>
>> This is a very long email to say that udev is causing spurious failures because
>> of behavior I don't entirely understand.  We're going to need to sprinkle in
>> UDEV_SETTLE_PROG in different places to kill all of these different scenarios.
>>
>> What do we think is best here?  Put UDEV_SETTLE_PROG at the start of any
>> function that needs to do O_EXCL?  So this would mean
>>
>> _dmsetup_create
>> _dmsetup_remove
>> *_mkfs
>> *_mount
>> *_check
>>
>
> To be honest, I don't understand udev well enough. But as pointed above, a
> simple invocation of mount is causing xfs_spaceman to be executed (indirectly)
> by udevd.  Hence, may be executing UDEV_SETTLE_PROG is probably not
> sufficient.
>
>> That would be safest, and I can certainly do that.  My initial approach was just
>> to do it where it was problematic, but the debugging I did yesterday around
>> btrfs/223 failures and the fact that udev is queue'ing up events that get
>> delivered at some point in the future makes it kind of hard to handle on a
>> case-by-case basis.  Thanks,
>>
>> Josef


-- 
chandan
