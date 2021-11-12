Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A144E2C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 09:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhKLIHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 03:07:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2452 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230464AbhKLIHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 03:07:51 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC80hf3017006;
        Fri, 12 Nov 2021 08:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pjNpxkNjENJJPb/5FshApuWFHiX0D5ArBZDJtdWHklg=;
 b=KoCyeiJS9LAPAt4g9Q8r40W/lHvPttQrbbZpSnXZGSbWV+oPCoTG361dkb9kFY6aTZ73
 pjLIkZEqDpLhzh0g2/wv9NdsRq9N1uSW0LgyMxXaARwTwzgqDX/xE7WWmHGOCze8tTwH
 5iCSoCW45IdY3Jn8/MYOhNWze9d84KN50p35EgtPHtyKMyjuKpyWARJ5M4SKXLYZzB36
 zcZrIAqmtpkdfd2Yn7u14oak2QLYZ9I8oJdtPGOdfjJouFMiQoPvO0lvx9K9vn2DiYx8
 0Eb9nWS9jqM7BABDMaa82PrLXUMMoEeXNscQdwOdXaviR4TszyEYIXtlWKdW0siXEg+G nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c89bqnqr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:04:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7trve024455;
        Fri, 12 Nov 2021 08:04:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3c842etfy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y97KmEMnJFREOGfT1yZ12dbZdgPKE2ApM9XD68ma/cQN/9K9AVdciCcFxBzJFMHHexpZRjM8u0LJoEpFykR0yrtfHeH4vydA4zbCUNkMGT8A9K2Lp+/ZLHAlhMbiHc/fEJdG4/7ZfetahH4ecaNyRjHVsZ81r2EamAy8cNJPfqZ9a9EQazE0VFka1Ye8y7EsCD1sFvPnrJyGMCtrAitXmukIJYl1jWuNTdezaA2hAnpTXKEBASAvTVDv5ZWdPMM/Puan5D5RgCGgKp6cFZJf53swtqCr/3hANCoEghAFF8k2RTZpkVjJaVqybVgFqb6IkYS6LBKYRbAtmitUPrpFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjNpxkNjENJJPb/5FshApuWFHiX0D5ArBZDJtdWHklg=;
 b=nV+zH+nfFVDEy8WYA7bR3VecjURScZvlGqSrrubESi9JBq9f+XpXy78JtlKGazsFwHvFN4w6XyQFiO0tKQC4t4uAppPIvWUQqBPaZVPv6EQqwqs0ACcFJ3b51XfE2J5xUHjG6wyKWBMZ5qGGnAA52Te4Fi2rvgO4wZGMdfnE5fsZl/hJuSd60wnM79mUoel3CE0XkQ1bKZZaJsTCuM1XzGQTfoeDrgligr8E4df3KnnkhdTzJNEptM5qdWE031mrfiDxbrihx/f49r6usg+nBitkpKsnLR8nn+gegmNG1js5cC9toebea8c/0+P17wMLoaaHRceutk7nM55xPk+79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjNpxkNjENJJPb/5FshApuWFHiX0D5ArBZDJtdWHklg=;
 b=d8pCr54aQUX8VhbKGP8nJgRy596cJJNvYzSrC7nVODPWzMRN7BamCLGfR/w3vYA+/zzmIC5Kb0xmJ8rX1TgQxUXv3aIxCcHBfx/FzIoZnbpilW3pFHIdtONid37VALUjLp5hA0ePEffCq/rbhO5EGJLqsTcf2aI9jBSFGNldDMs=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 08:04:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.020; Fri, 12 Nov 2021
 08:04:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     josef@toxicpanda.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3 RFC] fsperf: enhancements supporting read policy benchmark
Date:   Fri, 12 Nov 2021 16:04:36 +0800
Message-Id: <cover.1636678032.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Fri, 12 Nov 2021 08:04:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c48ded-0302-4706-c032-08d9a5b31b73
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4980D1A7EC03F5CDD442D249E5959@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrv2Xl3ZukXM9ApdRmQyOi22Fy3zGlw0XWGNiUT93cAC8QPsNAC6I/z6VD8IwGrblcdAPMAuSH/jo4EGNLjApiVoPR/sQru/OjbuIXAIiPP3K1n16OaRXyn2v8lClbkj9hB6vXQeBVhxJOLJkL6AC/rJtH94BpyeUHuDFuSHSnY/3CABqSjhpcQDjVr1ZDCo7EZysPJ+5eX2v0zbD9k0C67+gGPyvIRZXRKKmZEnFz6kvgCNnBNBVDfLkx0FccE+V5HpP3xYcW1O8+7TLC/gByI3Rv6rek8bEJAwY+7406kU7sQ41GDtN0wJX/QQHW9RGJQTRWgXT3ldRnFta8hxMOEi1tIIPI30zklpfkU0NYqmrEGr3cCFzvmVqCjFiMIr2tyKxsvGPIjreU99a6MkbZ8vQScj8rK63I5x4KPMEY0leg+CdR8XT72tNWk34Cmt8HUm59J9sX+raEid5n7/ZwEzulp5/bWimv9Bxt2xvj6LP3bHM5lw0jvYyAyXAiU7CJkA+AL1i0ZEw42i7t5VCgbAcyfAoZy2KCEzXGfvu8q6MU/8UhD1t+JOOP9KKMTCrdNvoDGQSSjoM8eBhX3FgsqWj1zq6Ir7r0cqEn4bhjJCH8F0Zf/i756gpDjIEMd31qf1jE7hycZjbceYA9pJD7L61Es3VKoYo/2RDSIdBO97zYUTjfwiDJ2E57m+4KW1tnfAWlZwaZXwuCBx2vJU8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(83380400001)(44832011)(66946007)(52116002)(2906002)(4326008)(6486002)(508600001)(6666004)(38100700002)(316002)(8936002)(38350700002)(66556008)(66476007)(6916009)(26005)(2616005)(5660300002)(956004)(6512007)(186003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZQmcdQHqv2JeP9XEgw897T4Ty7fFEwiUc43DEwOFnmXmcwdgGkUQe50Bbg3?=
 =?us-ascii?Q?rLDaNaxqcdUnLgdupKkdAaGGYUreTYDSiYrP1dwMwW82pWJYjSMfyDO8P5wa?=
 =?us-ascii?Q?9z+9utCaMXvr3OeHLacqOPzsYhfXLaG3PlYPyM5Nps/wpxrblkN0sYoe06Xn?=
 =?us-ascii?Q?FfrZfqLgFfpDnKjQj3HlOU3QGlnx1n2iqW8cT+Hb88F6KaPrT6t8CtMH3XuT?=
 =?us-ascii?Q?ZkZhPuFTiVFG/e9a3L/lQEXSMQeosNYlXxnP2T0y3vI2JDLwYqEsQf5vrucC?=
 =?us-ascii?Q?5ZY81kuZ/ejQUJws1G5cYi83QThSJUjthIXOEo3twLt+wFF7R/TADFj0dPVd?=
 =?us-ascii?Q?onE1hzmDHHdaYU+AbafJC4uK6vJcu5Cxcij8hDGgva3qP0RFsBQDm5aBaQIa?=
 =?us-ascii?Q?8qV6Wer+yePVImhFIkFt1J9l/j6uzM6rrFvm8tdO1Ym0IuYUsHQWb/EmAe+W?=
 =?us-ascii?Q?asCRIiNmGyPkJ/Ra+x7y0I3K7+ahvVF2JJn/P59kIaYSbCb6Cb6BEPs8OfM5?=
 =?us-ascii?Q?i2XUfND09E4T0rUebGgh4W7+5jEMn7EwrzkNJ1iA4v0hPiuJFrebcDqW52GA?=
 =?us-ascii?Q?1e6bL8jSt2YHPH6bgkXBOVNg9XqBWHa+z3n381z9QHVYGpquajFgw+9c2T/V?=
 =?us-ascii?Q?ImkpEpLoi4pvalwCftk7Tdox0dEuQnYg14hUeilqN3yypDyA3fTMIFIeXdA1?=
 =?us-ascii?Q?rJXCskugXNxj2np5H9UoMV44yUg+K1vUlaYjLwJFx703lmQC7CrN3cyWmEvc?=
 =?us-ascii?Q?ubAZB5FnRvpW0f240NTr+IsDasUdCmhmBeKLlYV7lOV8PLs4135LYS1WYDns?=
 =?us-ascii?Q?ZJjj8sqgFmPnG6mOLYnbYpdgaq60nxN2jOeKik75qQ/9TSgpB0/0bCUxSwge?=
 =?us-ascii?Q?Rrov1XmsMiAjUS2XXBZlrnp2y/CQazP7UJpumVO7+TPU7cW9zvPajvT76Jjp?=
 =?us-ascii?Q?wtoPiwTFdGTnV+WvGSCl+kx0ZTsf6EoifUNFd8wUHtzNzRZH7isR8saGG5lp?=
 =?us-ascii?Q?Du+aAWBl2zPoeLB/JVVVAv6DN7TjrcF9Y/NKv2qVV4KuYxjh7tZepLszMGEH?=
 =?us-ascii?Q?KDHqAiVjnvm9057mTG1csC2P/lTzdEOYi4CV5B1Kf4gTh5hA8yx7pZJV876+?=
 =?us-ascii?Q?P6nGNAvrH4huq0YgfT6Ot0KQDuO1HSNUMix2Rw0Od1X/MzaRcWuYjdXNGJoU?=
 =?us-ascii?Q?CwCi0WNWjtKNjQ4R2nOlXs1TMSl8oRwtze+q2lot3hbzhSApuza2/LaNyBSC?=
 =?us-ascii?Q?dlYEzW0j8tDAqm+POgRxKJIrR8h1O83ZH3VP0UX7niFWFlvsNvZvJogHZMbP?=
 =?us-ascii?Q?oRdfxMzkQ/IHb5W5mgN+gkzFOk7He8Bn3ePSFROsjIxyB24b7syYjO9Jje2m?=
 =?us-ascii?Q?ULaBhhfrLkGCrWe4ulNQ/9GWMBEEfOUxzZDGEbQZAyvjNkDxixoulsKIApPE?=
 =?us-ascii?Q?IM+yZoRC0b7Ox2r3+k8IVUI+GV+M29UWVTWlvC6cb1bzu1r3L28OQgbwCW/I?=
 =?us-ascii?Q?3m8ClPwsodDrdW0XJUYnAddUUCL4hXG8g1DOTwdLfWcfSJJ9/OYDQy2HelvF?=
 =?us-ascii?Q?4vOiIH83iJQcoqH7WHjC4/t8Nx7FDfqYACM8bTNg5lp6sLAJTvPLyWyvT78W?=
 =?us-ascii?Q?4LSCDvedHZwMkFGFSipNqMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c48ded-0302-4706-c032-08d9a5b31b73
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:04:53.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQHStTz/UDo2XiKuvfc4kTNYuz3U/xW2+m4xRpqRtQJKDCeBQDNkE0/3X1jywQlpjlA6K4bPDOevjvXHSz7AqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=850 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120043
X-Proofpoint-GUID: fCX3nZnb8T_HeHjcNSIiTdcnVGaS2w8R
X-Proofpoint-ORIG-GUID: fCX3nZnb8T_HeHjcNSIiTdcnVGaS2w8R
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am sending this early to seek feedback on the best way to benchmark 
more than one read policy.

Patch 1,2 adds helpers to support a new setup.
Patch 3 adds a generic readonly dio fio benchmark script.

How to run:
Manage the read policy in the config file as required.

For example:

$ cat local.cfg
    [main]
    directory=/mnt/test

    [btrfs-pid]
    device=/dev/vg/scratch0
    mkfs=mkfs.btrfs -f -draid1 -mraid1 /dev/vg/scratch1
    mount=mount -o noatime
    readpolicy=pid
    
    [btrfs-new-policy]
    device=/dev/vg/scratch0
    mkfs=mkfs.btrfs -f -draid1 -mraid1 /dev/vg/scratch1
    mount=mount -o noatime
    readpolicy=new-policy

$ ./fsperf -c btrfs-pid diorandread
snip

$ ./fsperf -c btrfs-new-policy -t -C btrfs-pid diorandread
::
btrfs-new-policy test results
diorandread results
     metric         baseline   current    stdev         diff      
==================================================================
read_lat_ns_max     1.36e+08   1.09e+08       0   -20.02%
write_iops                 0          0       0     0.00%
read_clat_ns_p50     2277376    2244608       0    -1.44%
write_io_kbytes            0          0       0     0.00%
read_clat_ns_p99    12910592   11862016       0    -8.12%
write_bw_bytes             0          0       0     0.00%
read_iops            5680.85    5848.49       0     2.95%
write_clat_ns_p50          0          0       0     0.00%
read_io_bytes       1.40e+09   1.44e+09       0     2.95%
read_io_kbytes       1363496    1403708       0     2.95%
write_clat_ns_p99          0          0       0     0.00%
elapsed                   61         61       0     0.00%
read_bw_bytes       23268780   23955418       0     2.95%
sys_cpu                12.42      13.41       0     7.93%
write_lat_ns_min           0          0       0     0.00%
read_lat_ns_min       164944     189882       0    15.12%
write_lat_ns_max           0          0       0     0.00%

Anand Jain (3):
  fsperf: add a few helper functions
  fsperf: get the running section in the setup
  fsperf: add a new test case diorandread

 local-cfg-example        |  6 ++++++
 src/fsperf.py            |  2 +-
 src/utils.py             | 45 ++++++++++++++++++++++++++++++++++++++++
 tests/dio-randread.py    | 22 ++++++++++++++++++++
 tests/randwrite-2xram.py |  2 +-
 tests/untar-firefox.py   |  2 +-
 6 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 tests/dio-randread.py

-- 
2.33.1

