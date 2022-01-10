Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0844899B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiAJNXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:23:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbiAJNXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:23:35 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ACro48001421;
        Mon, 10 Jan 2022 13:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=q4GddoXD+y6Qo8njkZG7+oJ85WG+lZcKKm5dwdH1LiA=;
 b=J1pTnIeGOX3K+knx6h9LM+HIOs61XsUh01fRVO7wKvuORqw/iZmGiuWOhofCsiyx8YUX
 6hja82JjCrjXa9wvIsmlkPLuYkgZ16+905opGXLW6u9D8rB0lBT4jplGEJloSUR5Ob9f
 g16WqzvS/RKthQiq0wJBlCYdC0KWXuYno7qYNJ7J9u6Kjjm3ykDnKriNEagx7cHAutgM
 F6WsmsFrrVHHJ7n9Jk1SgCdTY7kls9CGiUUp/WAJkqf2QtHF0Mwtr7PQ3UoZCQ09PJH+
 bNl9/1WlorTu0/fcSTznna5QHdK1oNJJ0poAfTbQmCpj72zGQDQ8B20uc+DGnEkxdzot qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn7481tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ADC5mF010734;
        Mon, 10 Jan 2022 13:23:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3deyqvakeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkw9bjSS9PbPIFnBU42GpkKNkaNYlK7LrPWeOMjrxkf9Z0bYw1JlYaWDo3BpY+2+3V9E83BsbeJpL6VGMBChXHRV+RBBKcarcGWN5mzVQHGoKdqpFONvVwzoLXE0yUmnrcLPh5Ve3f9EDTmJ1K5HxOZGqtWTABnY6bvb2lI7YGdD7vmDV4pszLevVoHsd/GnqdtmJc8X58pVzb3Z3pdkySgNecPHIfRTW3kBGC78KTaJLgxf/cY+nduRJX5u2nDpFwaeBI2t0IiFL9LjP5GJZrxRixnrNnGH2ynwxyVIleYIOAGN0nCSVBe811WCPxkVJdVbojJ+YwiKosEcEyx0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4GddoXD+y6Qo8njkZG7+oJ85WG+lZcKKm5dwdH1LiA=;
 b=KspM1dBW5fCwn2KhAXw4CeLSfRMtp3+oIU74ZKpoLR/3xtOoB7FoHo5j6sY3PAYvVWRu7HW6r8iw8WPuy/Hzi1bpvUJbkGFNZv6nc025uzLvLJWCze7/aqIXBY8tHhD2taI3wqKSuf9VbhOM5QTpK4Uu7u5ovrzA4Uiw02bwgRfH0tGvDwQVrB2Ibj/+s1rYLlpFpgsJidVplRPupM8cyE3QUd3JA1nd3JF3MmneOBpMwk7WmMJ/nw6/TKeQLasKpy0Tb37lBx9PhHM9F/wBF/fx/CEJ/IJbO7PSPSmBHiF1uBMVSLgS2yTQaT7PKID9+spQytLk2+y9Gn+e3xAF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4GddoXD+y6Qo8njkZG7+oJ85WG+lZcKKm5dwdH1LiA=;
 b=o1H00KF5AX6/XROfJIzOBP5+pAB+c/+TnOrA8RNtBzpWyJKuXXiQGCPFI8GG/1MsFtBoef5rUFyjpNO+2H3xnqTv7WSNGfSOYF//IU2W7MS++ZmkZ4nzJe06XdMkIF4qYNEPdHBANtN1yfkf8sJF+fLCZ4+Kov6JKxPJwhCeN54=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 13:23:22 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 13:23:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v4 0/4] btrfs: match device by dev_t
Date:   Mon, 10 Jan 2022 21:23:10 +0800
Message-Id: <cover.1641794058.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca86cfe-ed8f-47cd-e906-08d9d43c5fd1
X-MS-TrafficTypeDiagnostic: BLAPR10MB4852:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4852DD05D82ECEA325FABC19E5509@BLAPR10MB4852.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw52SBZBLPajCInESuVqHKL1gRm31p4zrrhOsIAdqO2E+yOCeb/+a58h68u/HZ54Lst+yuRHl0pFezABANXKnC82ZnuFWAHiaJ8GhDQGiXVwUNq5gD0oeSAH3y/SDvlpOKO+mUgD3F1zXD/Dj66IrxgaaK/+DN1/kkk/pEKF+wODJQUIxATF6dqi7PSczc9DitJwdgohAE/nbpbcxwvmpKQG/GfhADIJzaL72rNsTEajufLjBEFlk8ArzOo8Yg5Ti+MK873QXNzn8yyXqGziyBsCZoJu2ObTwGkb+z4Sg7yXoN3LDVV73yYKz+1qKC3ETE3B+2NqIp8Q84G+0f8d6THaeAekQQ1rVZfoLx7WenGTuFpmhYFlb2KX5wylBuO0D7XYcI41NWJjf0xE7GKkbMfd2RIdKJu3uzHvAjTBVXkIYWFdJ4SH0XRrO3g0BvfDV5EuPLm8f4vyaIdmL/WHUbUZa77eFrla+rHIYIy8m8HLJqgcAO5lHS7yH8VyrYUk78nPWnyPiqWOIh5gvvvi0HsGCxk6y9yCGwhms8vkR78cHV6WzFC2OjStIgQSEVLGjNo0M7LrH9GCNl3LzUGdrv2JEsai2yqqcXcgOi3v7E/6ZSziyzdLwUnsP2KbbAoJvkCt15sYRSbAK9huwhxj5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6486002)(44832011)(36756003)(83380400001)(66476007)(2616005)(6916009)(66946007)(186003)(2906002)(66556008)(26005)(38100700002)(6506007)(86362001)(8676002)(8936002)(316002)(6512007)(6666004)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3Tdo0KwIwEVQ2lKHAti+YdpS3K2mtflEwDRgpuKhjAunHpxGMlzQvcuC0fH?=
 =?us-ascii?Q?jnpxlu066UxYXdWLHjTNrsW8PHi5Snl790+aEHRSxPl9RYa+SaJiSz898Qg/?=
 =?us-ascii?Q?uMaygBhHKAHMVPVujoto5KEHTcySPOrUrUEw6KEc+VGyHmSdX9ujdurRFYP5?=
 =?us-ascii?Q?Xgu8rbdSlkU6sVUUN8zMmGEPUOwzYpYOE+oUPHYWxEnii50LDlL9fCAduABu?=
 =?us-ascii?Q?uj4PVU4tXadIoYyJ708YugPGDEG1e/aAYQEctu/MrtqXdTInwLqo+BVCeYbt?=
 =?us-ascii?Q?7UL83GCDmwfXBADclgd6DtvXZs/7BBm+jduXEihP34ehMtYhLTXxY2YAD0qC?=
 =?us-ascii?Q?NQdxWurL1uWSD/PyKBI4F7uxBv4pNBpyheMPl0UgmfLtq6nm5qFme8nWtExp?=
 =?us-ascii?Q?Vw4EiT50A4WFpdszK7njicwjtAiQOPZIaATFiTZS+9uvdvwuE6n6poONUlP7?=
 =?us-ascii?Q?MoYFhuQyIqiI4YffCSNC7+fEjmmfsCIlXD19Lli9IUbHAhIFQNBM/+TSMWqc?=
 =?us-ascii?Q?tx7oFwYaMQWaDTBbQU8xhmN2yek02TjAaaBnNntveXIqiTFSxj2MgBS8mToQ?=
 =?us-ascii?Q?r+XR5KVU5kToXn1GShUZ5RT1tgm/9TUbobc8FvRQrkSYhLZlgoMOk/KycUq1?=
 =?us-ascii?Q?EMqDtFLIHRgepUAlBM2/H1l4rGjVlQifHcMd0Ty4SvR3UCXRvKuKpnsTNnAw?=
 =?us-ascii?Q?IkVpvDAJsn1yqALm41ppeFKehl2mstLp5wlJ+8haHqqATRykTdiNk2lusugv?=
 =?us-ascii?Q?nJWWmQGcBt6ZYUz6al/+25tOaT/nRFqYcHHlX8jRu4SAk9DDSvtxhdqPZd6n?=
 =?us-ascii?Q?4juzGlOQKwo/VDUQ2yAM6Uy//W81ARUtKtH6PYqZSpj+J/9NctZ2N9UOv7eb?=
 =?us-ascii?Q?6iEytyUgYTERgC3ih36XEIhym0vRTPp61anGbfkhyV4aSv7y54/0MhNPnydm?=
 =?us-ascii?Q?iHJQIE0m78CnA5WDiBqTfk1tmlRXTy3cJs5DN559v9JFh7Gc+Es0qQlWUkGb?=
 =?us-ascii?Q?vffQRWM+veCe1x2WI333wgqL+HZXKKpBVppxzq5dRJ9Gu3Yh4DL/tFvxKWAC?=
 =?us-ascii?Q?SC3AU9ryZEd/HXEJ/cez2bacfTIj65YyRloVGZL9Y3zgPlxdVkD1O6OtL0+L?=
 =?us-ascii?Q?9H2xXBo/w9m5eLHXNEmI351TJqEnZDktm0RSY10K+lOZ+0r+gAt/eV2h8HTf?=
 =?us-ascii?Q?POJsZll5pZuiAPkSKQHgQQxJtTrp5usizbNjIQdVSdFLHHqFWBm0etmOF3AC?=
 =?us-ascii?Q?SI5MWGIXFW3whmI/+yMuj12U8Lyy0IsQzIyG4P/LGapSNui584YHb5e0J/uS?=
 =?us-ascii?Q?K3SpKlwwWhAoCEvvmJ60DRdu0i5JWgoMxjaqgjYAIXSw/5CBE1fbaIfUJIrR?=
 =?us-ascii?Q?p1/J7U6H8rMCO4IT1OmHcnndjIw2PBS7MIRuFlAJlNcXyUeOu/YZ1w8ui2J0?=
 =?us-ascii?Q?Pl+7+xi1yAU+cPfzA32yZ3mKr53crexgQINkjzLWN/F3HRqfKpoOTvl/Syqg?=
 =?us-ascii?Q?HGtOiuDu5jddFGkAC8VSblj3xf4k0cz0FKMQD7gI8RRDY91kpIr3lhMZbGTb?=
 =?us-ascii?Q?MrzOU9Y8SRh50AyBWIkV8dww2X6VnPqvurzT7nVCsmVRvt7V8KyqZZGhMg1k?=
 =?us-ascii?Q?jo3nvDH6WMmfM7OYaH20IZ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca86cfe-ed8f-47cd-e906-08d9d43c5fd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 13:23:22.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo0hKgoQuw2rQE6L+vfCtFAjmhc3LjO784X6K3k6dtLLTxbA0NTG8PHdraXpCHHLhO3WdNTmcKwtAcRjMVVtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100093
X-Proofpoint-ORIG-GUID: 9caIrj4WTpun2Cl7McUv7V0K641PtGnj
X-Proofpoint-GUID: 9caIrj4WTpun2Cl7McUv7V0K641PtGnj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4: Return 1 for device matched in device_matched()
    Use scnprintf() instead of sprintf() in device_matched()
    Change log updated drop commit id
    Use str[0] instead of strlen()
    Change logic from !lookup_bdev() to lookup_bdev == 0

v3: Added patch 3/4 saves and uses dev_t in btrfs_device and
    thus patch 4/4 removes the function device_matched().
    fstests btrfs passed with no new regressions.

v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.

--- original cover letter -----
Patch 1 is the actual bug fix and should go to stable 5.4 as well.
On 5.4 patch1 conflicts (outside of the changes in the patch),
so not yet marked for the stable.

Patch 2 simplifies calling lookup_bdev() in the device_matched()
by moving the same to the parent function two levels up.

Patch 2 is not merged with 1 because to keep the patch 1 changes local
to a function so that it can be easily backported to 5.4 and 5.10.

We should save the dev_t in struct btrfs_device with that may be
we could clean up a few more things, including fixing the below sparse
warning.

  sparse: sparse: incorrect type in argument 1 (different address spaces)

For using without rcu:

  error = lookup_bdev(device->name->str, &dev_old); 


Anand Jain (4):
  btrfs: harden identification of the stale device
  btrfs: redeclare btrfs_stale_devices arg1 to dev_t
  btrfs: add device major-minor info in the struct btrfs_device
  btrfs: use dev_t to match device in device_matched

 fs/btrfs/dev-replace.c |  3 ++
 fs/btrfs/super.c       |  8 ++++-
 fs/btrfs/volumes.c     | 68 ++++++++++++++++++------------------------
 fs/btrfs/volumes.h     |  4 ++-
 4 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.33.1

