Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE846903F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 06:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhLFFvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 00:51:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37178 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237370AbhLFFvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 00:51:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B64Uk73011523;
        Mon, 6 Dec 2021 05:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yNyFcT3iCNdHeAWvOT/z4RNurtVye8OpfFr8ujSK5sU=;
 b=f1i+Q+4WCHL/6mGvxsd/4ncQ2KzDGJRufIcuNqBPcGqMs25gUO9ZW1jlIkNEHP4rWRac
 g2+3fHPyKyNCHA6p8ozBhjDi05IYSuAIKRa+nTnzgtpsjw8MkvcRTdYcmtUpWeQEFoUU
 uOrE3oPQK8nashyg9cwdCGvyVo3RJEPxro4myxeKrpctkRq91qEw6IUY4Dj5XcMafNHL
 QRzWnd6BjQnO3RMwPBnvTkenc9TWHrFmQ6yaEwKWjb0AbdkpnHc+voYW0TqW4EhJ5T4d
 4S5ZGA8GVTwlhyBwfSca1saAHphev3p7UP7gO4M6w4B6dipYv/3MqDBkKVy5hd0WJcgk lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqxx1dcka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 05:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B65k2Tq063284;
        Mon, 6 Dec 2021 05:48:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3cr052wb26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 05:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/CUrN2Yi7uTvPG2jj5CIqeHxzHxmzWNUQ17bj6Y/VHOUtXYK/Z/e2MvXY4m/DrvSskLAdu+655yVN6gOhRTMuQhOm3s3rPrHJbNOS1zs/Eu/NQ5HllDAMi8nqw5cKoMSilTFMWWq2tVtTK5NgXeW/y8XAyaPNVuXL1Bvt9lx4UY8rRLLWCjYYRpgEB7kq0MHMjiUZcwzgu10uGdsEYhzqbUQyMq5C+B7/18ramkCqdmUj//8LIpfsrDYje5wi4zJZy57OLGNeuWJc9QX/pznW2LRGKhalHiLB2oGIMkRGaITAaeCMOIJrrwbXP6z1911/Mj2rlhEsteo0wa2ivieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNyFcT3iCNdHeAWvOT/z4RNurtVye8OpfFr8ujSK5sU=;
 b=gI8XgcSAU3cXuIySFL5iaPVz8L2NA510hGZdDVCpQ1rwuxbamH8JjuW8tJ63uJA4OTf9GMY2nxO4/xL7HgwjHI4Xlhv4bh1SwiLKeKQQDWmPyDI0kF1c0fyvrT2CTVbMPFUF9UF4k4xHA2IYg/NUiSxeQU9AOc6cKF1Hwnnx9pAVhF1FJEGVOu5ODSOuXmYmTVoqg9vkKQvETK3g16xWo5l7htvLqVtTIBLKe2mVoHFNZXdHUsgugJHJd69iFeCZFxF7SAzRfkfEEpKd868IqkeSCkAXkkZPi+uUlpkyosmh0sM9uSXLwrpM195dhZFNoU9s/MK4lD6BSYtrk8OHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNyFcT3iCNdHeAWvOT/z4RNurtVye8OpfFr8ujSK5sU=;
 b=0C0RwV/Ww+KBDcgSzkLNwTVDfh3HHxlUXcidVaj0xYZcmYWoDnSwJtd+eQW/7w1zgyaP+m+voYBhOWE9JHp6Td7gPAtAyC1uVIj4l6nVGq8lAs+iLDjcPX7ng9W5rX2ONNtyr7LkUm9pHPoR8gRQEMsQ19WwPU1UIeXGvTEZdmM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by SA1PR10MB5843.namprd10.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 6 Dec
 2021 05:48:02 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::75ca:e478:6788:d21d]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::75ca:e478:6788:d21d%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 05:48:01 +0000
References: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
 <YajcBNMm3dR4YI/N@debian9.Home> <YajqH1Njtqz0ZXF+@localhost.localdomain>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
In-reply-to: <YajqH1Njtqz0ZXF+@localhost.localdomain>
Message-ID: <87ilw2qo6z.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Mon, 06 Dec 2021 11:17:48 +0530
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
Received: from nandi (138.3.205.52) by SI2PR01CA0034.apcprd01.prod.exchangelabs.com (2603:1096:4:192::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 05:47:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72dba9e0-a418-4ead-1b5e-08d9b87bf5fb
X-MS-TrafficTypeDiagnostic: SA1PR10MB5843:
X-Microsoft-Antispam-PRVS: <SA1PR10MB584348A15DD744AD63026D9FF66D9@SA1PR10MB5843.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDItnZr/mVQ/HKBxvcjjU6kKFaBZsj240eYIpPmq2ya8HTAivWyh7+Ea/ifJzXSYh37vgXk9Iy8cTWPrWX/Ytyj+dMHuoXcz3n0GDJdt982fxcMs86V+V/JeE5mqViR/FtYoS1Adj9SiFEKiuX7GMYUo+95bAPUJ+rdjoxLVf9p/x4BVIeYalDiDvPGMNCaydQbWA8/I1ZFMdn8PRNOYFQO0G8D7i+iaAac8v3o8I63UnQ+dUsxaJyLKsfcxHC/qQ+vJMffZq2HelVCdgm/77omsLuzmm3Jtb8YLS6t1JqZluqKV/KwIRgfqetJex0O34WTycHpX/CYUkXa3Lc57sqOshw+5nNOUniw4uTLf0a0GJoQffQPtrJ1cd4grLF1WThJ6SW8Yerg2r2cTzhf8XM5JQC4BRjKHzTQcU5ck6YSq1mAieFu/rpJAc6/1lixQhGX6u7ptJH9v4vHS8D5CpvaKUm9wZJ+1t12FyHaIIuxz3AEtbBGF7HXygJ7N+w1raRTpSInIbk+6KaO2WE9JVVMG+LqpqIMoolR7ywxK0gUOR/ZzEBib+IHY7YnlvZKp+ZzClzf/Jo+cD4mr2AjrjUk9Mb3jcroXJBbrHdnR/R85N0rlh69NMB2h+Y6ee1KQiFS3TYZOrhSHmYIcliIB6zJbiOPV3flgqmgCxYX74HQRj3pgxh9gH/2+/8vc2KdEcAKlY5+DN6DqUylrVz+hWHpW14liPZwA2cd2rWoung0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6666004)(83380400001)(956004)(38350700002)(38100700002)(40140700001)(66476007)(9686003)(508600001)(4001150100001)(8936002)(52116002)(33716001)(53546011)(2906002)(5660300002)(86362001)(66946007)(6486002)(4326008)(26005)(8676002)(66556008)(316002)(30864003)(186003)(6496006)(6916009)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V58nbtGTilhTagVHgTw1oOn4ws9jEdsXikcyWqptz5lk+A001w1nlODhwFIw?=
 =?us-ascii?Q?7TfYG9E07EcZAzLJnDgFKNDXh3YAbKInIPBbbCRkS7n7K0QAJVB09TQZyFey?=
 =?us-ascii?Q?aQC2zwG7GFn8DwthMZddCoGztTGmltwEgi8FcLdCNymu03YdhIvF2ZTwqvO4?=
 =?us-ascii?Q?BGfFbqUD+nt3udcQfnjxpBcqTy+KNgSWttdZ0z+O/5I2FEkuTJSbcNdXFfpe?=
 =?us-ascii?Q?jLvINnSNUdD0cceh4UgU7x4YsIuGFg6RR4suvFX/3XjAw40NwaKcYSyRkOML?=
 =?us-ascii?Q?6oD1/YuYwXYg9kDTrslkZ9XwZgCBnJyOFT9C3XgCd+doQlMMQ6LOM5bZFoUZ?=
 =?us-ascii?Q?QuHZa/bOtAArjwDYHAsU9szj/EB2I3vMTaph+unJXlc4o6Z9iGhtya7BIh9v?=
 =?us-ascii?Q?hqQq0sfnVspTjpXVB+ohATau0bEmPCtb1KNY38RfBNYhyMgEVlYebqhDYfrC?=
 =?us-ascii?Q?xmt3BSwr/5tB7JCI9DNTX7ftnlyikYQNenaXkoVoLnvfHC0WFP7AOy0dyKMO?=
 =?us-ascii?Q?+1dTb+9+lDtbxTS1UNWQyFfXqMIbg8DFQBJAzVHS8m0xFEYO7/MqtKOZfD+B?=
 =?us-ascii?Q?kQhwqMIaWAa+BGTR1CiLwRJt+NXaWu323kUgF+D1y23xPfk8WKRyEjKiHUnQ?=
 =?us-ascii?Q?6f0j9OdhAjvfZG2vFNR0Zfl59J+y0sK+zKae96OjyrSXYdA/CW5vzn6sDuZe?=
 =?us-ascii?Q?0/thR44a1PzOC6rpWpIblApoj3GuUT8XtSQf5HavEtaWyUts63TAP15fHf60?=
 =?us-ascii?Q?5wMK60clON7MOG+7Q3om/CokYbCLYkQ27SCtbvVgNa/wXbLLHO1OsSX1hvZR?=
 =?us-ascii?Q?b2hkoms2oQtRNPDOcF+D1+6TzsgiYT6q9G+Ea2OPqJAxkDzWT0ZYF8Kiz72X?=
 =?us-ascii?Q?gyBwzD3JXi96C2Hsx7j/2NNB6TZ+XCF/RyePjcWJe82VZPHEtaQ4EYyx2dhq?=
 =?us-ascii?Q?fcOcYIUd4cRuRqMIHhV0ntPD4CZvN7eQXTKnempPHiQYwmk87g+aP1yQ1BRS?=
 =?us-ascii?Q?xtKxJciCi55ooJELRRqW7P1Dk2GDE3JmILe6prH2E5gLMwZBFX/UzZkalgcZ?=
 =?us-ascii?Q?f+Bl7ni+2Wh03z59bIYNXIVvHAF2GkOnNENs8Nu2b1lhCDryt3rDfA7kiGrO?=
 =?us-ascii?Q?g7FZQgUWg8wc8cYbyVXTeF3eMPB/zrhSF/BW2PTLBbXL/vQ/O141eiTU8RrV?=
 =?us-ascii?Q?pyvlTdm2HEJNtWTV52xGVQWATo658mWPq4Sgrvp2WtQdiNLEM1Vy3ix0GAtN?=
 =?us-ascii?Q?tmhWh4CooN08LowdmSKI90sXdZMPHOhAQfuHEwrvmCzPzqjlzXscv3oPiNsJ?=
 =?us-ascii?Q?1CrQkROR3NnyO1L066WJ6O5xZBomZHsVt6U50po+whN4s0m6Q5jET1P4FWBI?=
 =?us-ascii?Q?xk+MvY9wiSdDmGmopo3HLLmAIPd1stymxgWHh2UJFlC3w6cuVyMYuC0iknJI?=
 =?us-ascii?Q?DLpABGsupzN3PBb62ICdenDB2tD9N595pOfnXPBmLhN0huClO2qWgF/sukC1?=
 =?us-ascii?Q?r+ZsSk4J63NmdNTvsqEzUIaPFPOJ6bv5Hb+C5MA0ROZAnJ7hqXzMfCWWhqNs?=
 =?us-ascii?Q?7tQ3c5iVE1jRFkqNzQhhj2L0D+PyO1yHCWvo77VD+b0a0w7emvzkySICGC7P?=
 =?us-ascii?Q?nhqFs/XzSXLsF40/0XMhTdU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dba9e0-a418-4ead-1b5e-08d9b87bf5fb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 05:48:01.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT72cwRVp2G7b67yDMjhZsOAJ6QlpqqT8vVLk7H3XF6Lhnxh8ZL0kvp5rj0sWpEk9XurgZ0tNLV2GiNPaSPxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5843
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060035
X-Proofpoint-ORIG-GUID: -YvjXBdAkcCLL9840PvG_A5GzxjzdHdL
X-Proofpoint-GUID: -YvjXBdAkcCLL9840PvG_A5GzxjzdHdL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02 Dec 2021 at 21:15, Josef Bacik wrote:
> On Thu, Dec 02, 2021 at 02:45:24PM +0000, Filipe Manana wrote:
>> On Wed, Dec 01, 2021 at 01:18:52PM -0500, Josef Bacik wrote:
>> > We've been seeing transient errors with any test that uses a dm device
>> > for the entirety of the time that we've been running nightly xfstests
>> 
>> I have been having it on my tests vms since ever as well.
>> It's really annoying, but fortunatelly it doesn't happen too often.
>> 
>
> Yeah before this change we'd fail ~6 tests on every configruation on every
> overnight run.  With this change we fail 0.  It's rare, but with our continual
> testing it happens sooooooo much.
>
>> > runs.  This turns out to be because sometimes we get EBUSY while trying
>> > to create our new dm device.  Generally this is because the test comes
>> > right after another test that messes with the dm device, and thus we
>> > still have udev messing around with the device when DM tries to O_EXCL
>> > the block device.
>> > 
>> > Add a UDEV_SETTLE_PROG before creating the device to make sure we can
>> > create our new dm device without getting this transient error.
>> 
>> I suspect this might only make it seem the problem goes away but does not
>> really fix it.
>> 
>> I say that for 2 reasons:
>> 
>> 1) All tests that use dm end up calling _dmsetup_remove(), like through
>>    _log_writes_remove() or _cleanup_flakey() for example. Normally those
>>    are called in the _cleanup() function, which ensures it's done even if
>>    the test fails for some reason.
>> 
>>    So I don't understand why we need that UDEV_SETTLE_PROG at _dmsetup_create().
>> 
>>    And I've seen the ebusy failure happen even when the previous tests did
>>    not use any dm device;
>> 
>> 2) Some tests fail after creating the dm device and using it. For example
>>    btrfs/206 often fails when it tries to fsck the filesystem:
>> 
>>    btrfs/206 3s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad)
>>         --- tests/btrfs/206.out     2020-10-16 23:13:46.554152652 +0100
>>         +++ /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad      2021-12-01 21:09:46.317632589 +0000
>>         @@ -3,3 +3,5 @@
>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>         wrote 8192/8192 bytes at offset 0
>>         XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>         +_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>>         +(see /home/fdmanana/git/hub/xfstests/results//btrfs/206.full for details)
>>         ...
>> 
>>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/206.out /home/fdmanana/git/hub/xfstests/results//btrfs/206.out.bad'  to see the entire diff)
>> 
>>     In the .full file I got:
>> 
>>     (...)
>>     replaying 1239@11201: sector 2173408, size 16384, flags 0x10(METADATA)
>>     replaying 1240@11234: sector 0, size 0, flags 0x1(FLUSH)
>>     replaying 1241@11235: sector 128, size 4096, flags 0x12(FUA|METADATA)
>>     _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>>     *** fsck.btrfs output ***
>>     ERROR: cannot open device '/dev/sdc': Device or resource busy
>>     ERROR: cannot open file system
>>     Opening filesystem to check...
>>     *** end fsck.btrfs output
>>     *** mount output ***
>> 
>>    The ebusy failure is not when the test starts, but when somewhere in the middle
>>    of the replay loop when it calls fsck, or when it ends and the fstests framework
>>    calls fsck.
>> 
>>    I've seen that with btrfs/172 too, which also uses dm logwrites in a similar way.
>> 
>> So to me this suggests 2 things:
>> 
>> 1) Calling UDEV_SETTLE_PROG at _dmsetup_create() doesn't solve that problem with
>>    btrfs/206 (and other tests) - the problem is fsck failing to open the scratch
>>    device after it called _log_writes_remove() -> _dmsetup_remove(), and not a
>>    failure to create the dm device;
>> 
>> 2) The problem is likely something missing at _dmsetup_remove(). Perhaps add
>>    another UDEV_SETTLE_PROG there:
>> 
>>    diff --git a/common/rc b/common/rc
>>    index 8e351f17..22b34677 100644
>>    --- a/common/rc
>>    +++ b/common/rc
>>    @@ -4563,6 +4563,7 @@ _dmsetup_remove()
>>             $UDEV_SETTLE_PROG >/dev/null 2>&1
>>             $DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
>>             $DMSETUP_PROG mknodes >/dev/null 2>&1
>>     +       $UDEV_SETTLE_PROG >/dev/null 2>&1
>>      }
>>  
>>     _dmsetup_create()
>> 
>>   I can't say if that change to _dmsetup_remove() is correct, or what it's
>>   needed, as I really haven't spent time trying to figure out why the issue
>>   happens.
>> 
>
> I actually tried a few iterations before I settled on this one, but I was only
> trying to reproduce the EBUSY when creating the flakey device, I hadn't seen it
> with fsck.  So I originally started with your change, but it didn't fix the
> problem.  Then I did both, UDEV_SETTLE at the end of remove and at the beginning
> of create and the problem went away, and then I removed the one from remove and
> the problem still was gone.
>
> But since I've made this change I also have been investigating another problem
> where we'll get EBUSY at mkfs time when we use SCRATCH_DEV_POOL.  I have a test
> patch in our staging branch to make sure it actuall fixes it, but I have to add
> this to the start of _scratch_pool_mkfs as well.
>
> It turns out that udev is doing this thing where it writes to
> /sys/block/whatever/uevent to make sure that a KOBJ_CHANGE event gets sent out
> for the device.
>
> This is racing with the test doing a mount.  So the mount gets O_EXCL, which
> means the uevent doesn't get emitted until umount.  This would explain what
> you're seeing, we umount, we get the KOBJ_CHANGE event once the O_EXCL is
> dropped, udev runs, and then fsck gets an EBUSY.

I started debugging this issue late last week. Among several tests which
failed, xfs/033 was failing once in a while because the umount syscall
returned -EBUSY. Debugging this further led me to the following,

1. Mounting an fs causes udev to invoke xfs_spaceman (via udisksd => xfs_info).
   This causes the per-cpu counter at mount->mnt_pcp->mnt_count to increase by
   1.
2. Unmount at this stage causes the umount syscall to fail since the refcount
   on struct mount is greater than 2.

I changed my test disks from the regular /dev/sd* devices to loop devices. I
then added loop devices to be ignored by udev with the following change in
/lib/udev/rules.d/60-persistent-storage.rules,

KERNEL!="sr*|loop*", IMPORT{builtin}="blkid"

This led to xfs/033 execute fine for 100 times without failure. However, other
tests which use device mapper devices are still failing arbitrarily.

Looks like a simple mount operation causes udev to indirectly invoke
xfs_spaceman as described by the output of perf script,

bash 50034 [002]  2541.601278: sched:sched_process_fork: comm=bash pid=50034 child_comm=bash child_pid=50044                                                
mount 50044 [003]  2541.601851: sched:sched_process_exec: filename=/usr/bin/mount pid=50044 old_pid=50044
systemd-udevd   173 [000]  2541.620525: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50048
systemd-udevd   173 [000]  2541.621071: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50051
systemd-udevd   173 [000]  2541.621562: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50052
systemd-udevd   173 [000]  2541.621971: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50053
systemd-udevd   173 [000]  2541.622657: sched:sched_process_fork: comm=systemd-udevd pid=173 child_comm=systemd-udevd child_pid=50054
udisksd   588 [000]  2541.675852: sched:sched_process_fork: comm=udisksd pid=588 child_comm=udisksd child_pid=50058
xfs_admin 50058 [000]  2541.676645: sched:sched_process_exec: filename=/usr/sbin/xfs_admin pid=50058 old_pid=50058
xfs_admin 50058 [000]  2541.677317: sched:sched_process_fork: comm=xfs_admin pid=50058 child_comm=xfs_admin child_pid=50059
xfs_db 50059 [000]  2541.677569: sched:sched_process_exec: filename=/usr/sbin/xfs_db pid=50059 old_pid=50059
udisksd   588 [003]  2541.687075: sched:sched_process_fork: comm=udisksd pid=588 child_comm=udisksd child_pid=50060
xfs_info 50060 [001]  2541.687843: sched:sched_process_exec: filename=/usr/sbin/xfs_info pid=50060 old_pid=50060
xfs_info 50060 [001]  2541.688362: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50061
xfs_info 50061 [003]  2541.688615: sched:sched_process_fork: comm=xfs_info pid=50061 child_comm=xfs_info child_pid=50062
xfs_info 50062 [001]  2541.688810: sched:sched_process_fork: comm=xfs_info pid=50062 child_comm=xfs_info child_pid=50063
xfs_info 50062 [001]  2541.688944: sched:sched_process_fork: comm=xfs_info pid=50062 child_comm=xfs_info child_pid=50064
losetup 50063 [003]  2541.689058: sched:sched_process_exec: filename=/usr/sbin/losetup pid=50063 old_pid=50063
tail 50064 [000]  2541.689169: sched:sched_process_exec: filename=/usr/bin/tail pid=50064 old_pid=50064
xfs_info 50060 [001]  2541.690200: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50065
findmnt 50065 [003]  2541.690501: sched:sched_process_exec: filename=/usr/bin/findmnt pid=50065 old_pid=50065
xfs_info 50060 [001]  2541.692154: sched:sched_process_fork: comm=xfs_info pid=50060 child_comm=xfs_info child_pid=50066
xfs_spaceman 50066 [003]  2541.692345: sched:sched_process_exec: filename=/usr/sbin/xfs_spaceman pid=50066 old_pid=50066

xfs_spaceman in turn causes ref count on struct mount to increase. Hence an
unmount operation can fail with -EBUSY error.

>
> This is a very long email to say that udev is causing spurious failures because
> of behavior I don't entirely understand.  We're going to need to sprinkle in
> UDEV_SETTLE_PROG in different places to kill all of these different scenarios.
>
> What do we think is best here?  Put UDEV_SETTLE_PROG at the start of any
> function that needs to do O_EXCL?  So this would mean
>
> _dmsetup_create
> _dmsetup_remove
> *_mkfs
> *_mount
> *_check
>

To be honest, I don't understand udev well enough. But as pointed above, a
simple invocation of mount is causing xfs_spaceman to be executed (indirectly)
by udevd.  Hence, may be executing UDEV_SETTLE_PROG is probably not
sufficient.

> That would be safest, and I can certainly do that.  My initial approach was just
> to do it where it was problematic, but the debugging I did yesterday around
> btrfs/223 failures and the fact that udev is queue'ing up events that get
> delivered at some point in the future makes it kind of hard to handle on a
> case-by-case basis.  Thanks,
>
> Josef


-- 
chandan
