Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C34877ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 14:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiAGNEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 08:04:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60592 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347378AbiAGNEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 08:04:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207A8ecR016699;
        Fri, 7 Jan 2022 13:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ex5Wgc4MdFhstlGkMI23BIFkmuyi/B2MH0ocwftiDnY=;
 b=mvidmhaRQTpbtQESzmAZDmIVMTRW6iNoIwC3NWrhtHwxENcVYCfs6QOV9t1TcOJ6IcPG
 fbDXtgSJO+OnsAWIv7BZfQ11kk4ROtGJtPW1cB5dsXYOwrMPNInG+a1Gca0/Jj0DKnWc
 fxvD5GOUpgZIH0hcv6zU78D6pfqCLneCv1gOjqdzAqqHnLmJPE9nYgfEPDZTLF7gX+ey
 P9FrWYyecuEUCYjtaDJ1RttRMB7Dyqmq8F7HXpFjrUSJNBE8v4a+wmV3g4IM8Qf77Qbf
 9IfmWExH736WEmagCprXitOcQnO/9dqHKaooxJIVok2w1Y6qaG6fvp/CHP1j3gVuPNrD TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8a00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207D0GYA070929;
        Fri, 7 Jan 2022 13:04:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3de4w31x54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m21R7v5sVfh8bRTwDxd8kfxImomd+C1CANhzQQV6uUZKmWOEqQNCJeEivrq0CvXNWh9c8blhqW9nsj9BUpPwuUG0sVuDbXc4OUz1dQx3VoAfbd8QIsY77cUwrRujrMLztkAsemKNDo4u+fo7ibI58KOkx0MV6VrtGnS0TxmCM0SD0M4FmbVlh6jv7rxyfU/HST9Ck51HuVMtf5QgfpvYtJecAeSijm3rmZNQ+RI6E6ILD1Y7qKygyGRxbPCq2zxPPTeWkLo0QAR+asepZZxI1C8/NhTNZARFzvRBoswxwF/cBLN+oWMnzGsGBdRSINEcOzbK1aYuovPehqWaEEn7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex5Wgc4MdFhstlGkMI23BIFkmuyi/B2MH0ocwftiDnY=;
 b=guIQX0REWuRuNJvBTAZg4FNTCbnQvuK09Gt0MTkNwSI7RfWqMMYaijgmuaZQva1GwE8OCN/EC2xhJIT56/P1c/Lyg9fTMg/q1VyZTHuvpIQslgh7FZUU5RqXeZDjWBzKgAbix1tXfhTJEfX+vAZL6XXiV6Z38WeYLkQwCIXYVyL9qvK4lJUvomS0kdp25CNkSQMtdv8ue89mUVf9dQuBmCpeRsUjY7O4ZkVnkjAEm9L4h3feivswHs1exfZmac5pcn5S+3v59IvPPRU2uCELtW428iw+Z3/Zkx2q2TL63u9XZhYGtZ02cW5FUSsniu7gQrhljN1lb1eQr+GozYvMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex5Wgc4MdFhstlGkMI23BIFkmuyi/B2MH0ocwftiDnY=;
 b=mMxMFSt7crql/r3hN2AJoAb97bymfodsGgn8aon7FXz1/ew1MqHOdfNWFOrSY7v2A24D9YXkTca8ry863ncptkUJXAzn74KpnUX5KJrBX98psnOG9wOtKx5wpCfM9Fciu7cgnxh/baAOJClU6u1yWcM035AkvSnqNBrL/fVGf+E=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2995.namprd10.prod.outlook.com (2603:10b6:208:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:04:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 13:04:24 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v3 0/4] btrfs: match device by dev_t
Date:   Fri,  7 Jan 2022 21:04:12 +0800
Message-Id: <cover.1641535030.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e774b5-1aa2-43fd-3965-08d9d1de3a49
X-MS-TrafficTypeDiagnostic: BL0PR10MB2995:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2995A4F5BFB17E506276954DE54D9@BL0PR10MB2995.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLKS0Jsy3HTHezs/9b1yMuLhkV6AZ33xoTMlhnhzQjUdv2RnuBlQ3PpDHpoA0jSHJhYGAcPh88KB/fl1+pC0kOdfoSXxlD49fBD2NBX0huB8I1ys9CyB4TLzsKuV8Iupq5E6/EbyqTkRqIDrxESh4M3Lx/UbB/0URuk6ox/vEGXzgE9kT7ER7YyZKF35599kzocmRhGSV0wIjIQvjEGVlGcaNW9tNZxbOwH6o9HjDNpXitZfhUtQ4YypurYGBatVzJ5pTb909A2yhPGXCGiNdVSLVso+M7PLpUuCrKBZ4YljKATkpxMpsHJalFbD3RVhYsy31AV6T2kZkkKS3fx9OZUOT/7plOVtjaM2z2H+smj7J0c/kLTjFOhPzL5wrL0QncPAOCeWGSyg6yL5s3f0aRGX77NJaq1dmwEs1h36Lm54yvinbo4/FdR5ZxlKI0uVKd9bWSvf6TH/cXx+oTslLjHkaH/upcTdgkUEQn4C0ptB5gJZhCSJpcWMDH436tIASrIe/aQjiFNRRXXr0dR5syvv7icbUX4wYJcROaQavu5oClCF/7wcLETSAtxbnyFdRt1pjJ2X/GTnEz6QN/J0FDTjNXthZLfqz3qX4/DQtqNWWaP3lPOxj1wVaypHy/a7u/dslHhFpwZXnH9ZUfZaiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6666004)(186003)(83380400001)(316002)(38100700002)(6916009)(26005)(8676002)(44832011)(66476007)(508600001)(2906002)(86362001)(6512007)(4326008)(8936002)(66946007)(2616005)(36756003)(6486002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzbauo353IjXFwtNBi0FJF2NJg/IY4vOEOLpxZQs1Nq5AV6DKlxXDelDmPJR?=
 =?us-ascii?Q?yPZ6Q7Oa0B9/LYePGMkkjf3p1wNAfMrgjiRxt3RO19jpS6OV2w7NgA3OcAgM?=
 =?us-ascii?Q?mMsA/yvT6+/Wx9DiLE9gBjaeJormDYD4htFOUTGbdEl0neApMDrjjyByZ71I?=
 =?us-ascii?Q?v0dbAh8taclYWbNPLTuHk8MiWzyx/Tiwazkhw0+wswGVrFxfoJlCyQjeg2bV?=
 =?us-ascii?Q?XLlsfgzwx28M1jmyriEoazDltVH/wWlAjLDO0iB+6Krycxtd0PwosfrY1GqF?=
 =?us-ascii?Q?Ci7WbRLFbnHuWGknmA6JHKp1vCfXU5ycjWlv6DBWoBW98VMIELKwNxA0sHjd?=
 =?us-ascii?Q?OPo++6R555VaqYb2yvf2Lnqu/28BclcM+VwF2weGrLtS0JEJ8qF8B1O4RKtv?=
 =?us-ascii?Q?bqt9Jeiuv0N4YiWewGIBk5sx1O+xKhquHAByTlL0ZIyp6kq9BcEVlSozxkJ1?=
 =?us-ascii?Q?nJ0nnuuIMwmTZqXzh4m+17dJwc0XFgoc1ZO9B7t0Eh/4UcXtYS5yZEYGDD2b?=
 =?us-ascii?Q?EksUKOexMRniEAMFlAuoCW7fcazpz7TMx2AmYHqV1njJ+pBSSwB660RxCZSy?=
 =?us-ascii?Q?UYT/1ZKc2v4dUQTuCIf4KY6d0a7rN6vvNBD5JoXXc2Si0QO0NOfDYtpRp8mk?=
 =?us-ascii?Q?uuBWf7Uk1Gswc+t0vNmQRDqNfOcH8J/OWH/A+dGqewC5RV+tKFnYnANf6HtG?=
 =?us-ascii?Q?7oR6CcHubV17CybjmVChZ2wP8figS4aVWeMA30exbO2gMTUAp/WBUaH/PVrZ?=
 =?us-ascii?Q?f5hPYNTN4g0ERjXG8ADUInwruFb8lotQED4AHXfFqBIJA4sg8RqUWzNwMNMx?=
 =?us-ascii?Q?QfTnuqncnIktzburSJ8o+4fXNIWNGG//OnOV7ylKV8U3KQC996syydEMZbGB?=
 =?us-ascii?Q?Tg8RA9LnLwmrb7O65PRs+fVn3fdIX8jJtUX+e/ed4ZnFWKc8uSwRKxAewCH8?=
 =?us-ascii?Q?VggMVM6+U3htoRvunE9+Xqg2fj3WG+LEFXkKurwnfkD8DeWEIBH8u6KrFIFr?=
 =?us-ascii?Q?oXWNsKuVXSPw5raCxrvn2+3+850nTP4MdNIGZQguEwL/GG3Nx3M+DkPt/2ik?=
 =?us-ascii?Q?CajnbyslB1bJbVqi8sxJAh9NuFuVbBuX5JuogyCfg8BEr/Okt+5QNY+6bbg9?=
 =?us-ascii?Q?DrQ9v/cdEmOm5TsfCDrK1gp8poQJHpVDLLC78zeGiVVyDihdieIEiD4JlJMA?=
 =?us-ascii?Q?odGovqUZFdTONi9kVVbV8pF4aTzlRzitICH9KnL/uSJ3pvTGyNElYMWpFv9t?=
 =?us-ascii?Q?2badxGl4SUTibqFJPPjipMBYX2zsSdwIAaANQib8lxas8MuHJu4Np9ir41Mo?=
 =?us-ascii?Q?ZD0pAWJoVIxk/qBxxSWWPsz8bw1ckytVKxDtDuXF4BB9IBr7tqQzgb9i2Nui?=
 =?us-ascii?Q?U3FssGtg5aXsep1uVqtf0YYADoCs75CouLsALEElBDYMvSTb5aOUVxYSY8x8?=
 =?us-ascii?Q?jevMC7a37EK3UDKOLw4jLOyQ77+YpLJMZYJSnutxECXmQAbHYl1iu9fleXfy?=
 =?us-ascii?Q?v+YK3ekJxsOgf/37ngrKCJ2GAEEMjoAjlZI2l9ksEhNIm8nhhGCx5/jY0a/p?=
 =?us-ascii?Q?Hmm/4m/Uvf1GFT56mWxok2pj6owyI7QUimMwwLhnbW+4WbKX20N6PCQH1S4L?=
 =?us-ascii?Q?KfCdJJUBK2W6aTnI16JLUi0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e774b5-1aa2-43fd-3965-08d9d1de3a49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:04:24.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/qdt61Yy3T/W9dOqxDxQRfam+RmsKHFHcvZqYOLa7kBmUKN0WAM4WMj+Q2yePsiWAKKeyGihfqC6MZPn5SbjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2995
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070089
X-Proofpoint-ORIG-GUID: jA8Wz6lUmYpcTk6FAA0XYo0je6g0K0VY
X-Proofpoint-GUID: jA8Wz6lUmYpcTk6FAA0XYo0je6g0K0VY
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
 fs/btrfs/volumes.c     | 67 +++++++++++++++++-------------------------
 fs/btrfs/volumes.h     |  3 +-
 4 files changed, 39 insertions(+), 42 deletions(-)

-- 
2.33.1

