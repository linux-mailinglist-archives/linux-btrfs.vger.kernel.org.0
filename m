Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F146C669F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCWLcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjCWLcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 07:32:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C712046
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 04:32:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hump019326
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uDwzA7W0RXd9fp5I79xFj48d9rdde/BTe9AyQf4RXiE=;
 b=t5BW/rbiZSBGuvF1Yi9czyWzt/94T+46e3DEMV3eN3i+egqRTQPBqBKK6Tq/oTrzosO/
 vCG2/VQhYn7JECxSLzHc49jtuQuydu0xCHfFB64OgnoUpt+wXSwZDpsdLqMhQ0/5AdQv
 w5PYPKJqn8571BwCevSyI6segJSD50pntynYu0bDuoJG4Emvza4nWTZXTtwYo1zEWrVN
 +J9mOA0cZ95Fv7iUv9PNPdzk2uvr34ql1tYKtsCfihNQybSJRWqtDr0pLQKSquFDB5i0
 f1yQT/4YIwgBxySlizbes4ufUZkN24tNn+ACkyqAGnao70aSnfMR0nfU48E4c9ucS0RR 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bckjrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:32:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NBDng2008453
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:32:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgnq80tww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTbn9b4A+/lfJCn8VidDUgmNR+yQBgt2a88rp79HEph6t/MH/sg+6exurxwuYZlHv8PqxcOn+f1fhQEbLRA65OZqTHkvuS6ZaBE+r81YnYScjn+u38y5ccy6CAk7LpKFAfsiUda9cVK+5XSQcw/MGW6qnGMm5eGNH3BzS5VAkCS8HNEre29Zr8nMP8qBaTxXsoNRFXV60Z7/q3ZkVo2i2zS5tAQzfKb2LJWcnK6dzwWdY4TxrwcShYYda9fKUWSN/zXWjq/YIfbigSBWY8vHrLJFK5SFWkBgJS23Kswxmp/831bonOpVt/A/6DmyoTR1ZDmCKGr5bKh11trZamdczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDwzA7W0RXd9fp5I79xFj48d9rdde/BTe9AyQf4RXiE=;
 b=jNQaBzwlY3TIX8kVb3xSMlMfgN0yJXEdcC92FKFdJ/7V3iLkj1OfG9MDkPoRa3vbQlrgXvArWc4CMWu3XfjEhCdKAzrdaacfQxpwSQOOBDpS71juDlHecf4O3tF0o3r4Mc8Eg1USTmW7gJPNgFwViYxiylk87IxPfJ3+L5pSn4/6pidb2T4ogIa8rUA1w1XcR6IqIUmWhb2cBm3SHTuCNefTjBg0Y0UISFSnJCieUgNiIY64WfuxpyBPRth1hp92XOhiIeA8nq6Ind9MmDYr3eRfDZESEPYAh2+kug/T4Hw0fwdqX4x4ni2jwejN1slVyP2Gd97u1OU64goB28fgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDwzA7W0RXd9fp5I79xFj48d9rdde/BTe9AyQf4RXiE=;
 b=RTQrw2LsRsXyqOgd2osUFZIp3re/CARmI6+g0oQ3oQQDLyIqAU8OlFjVuCp56jWEDng4ABRcrJ/w3WV9iZHkIhBK4vecilWPQJfvdixJ+VXc9LQyWo7SXiehJTkqa95Fs70B4n8Ri6X1XBZoxw1i3FjH8MamkDSYgUHn9RN4PQs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:32:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 11:32:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: move comment to the related code
Date:   Thu, 23 Mar 2023 19:32:16 +0800
Message-Id: <b186e39f1c4bd938270918ff0411f9c8ba6e8934.1679571105.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e717b33-8984-454b-3e08-08db2b924d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQh8LpwuT543vLXud82H+IbT8MuR/o498cCp6gou6pO1JXj74N70pcYsTkCLirbFBComZ9ahYqWtatVAvClQ/57J3ocN+9pKrymF3SMkMbS5X2zw2tjg0zPwp/GvjJU5YT/gVtY1kSkY7Vw5xUicoevqO1bqUf0tYQRO7fx1vvI4LXMfZPH8gx4sVzCQvdnyQ8v80h4stAnUtkwrcfSJ/Ypdh6B/UwZatFm9iUFSC5kI/vjFxqFQKS0L87L17EPQVkgEqocWjg9ppsMFEm6szEAT41C+FMDSZovtNlTLqEK5i4X7DSVCsC1HO+tQ9hq/lAlD+2jBun31zTznRDuMUNeYGQ/tl2byOUS8NhIcfizPdtLmTuGzGJEArn3zDruUItei/6sEr0TUIAske3qg26imjO7Pib3cmnLcQ4+xL96V5D1MY9OcIHW5wicwUbuOYGia3WLZAIpfm/IndvQ7ljiEIDi2+uAira1GhaV4MXoEeg/Tkj1wSpKERM963mNx2RhVvmspGdQv4IZ0PmTyynGKzhItXlmBAazM5XwrW4zGLMzggxOM1oCYaKWPiSxp4vr4wpXt61lrHbqh0VYqWmMFiiZycDlHZqBUX5e/5X2siP09PL7AZakOU/Li2jiIkcq7keVo+p0j+iQLS1Sq/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199018)(6512007)(38100700002)(36756003)(316002)(478600001)(6486002)(86362001)(83380400001)(2616005)(6506007)(6666004)(107886003)(186003)(44832011)(2906002)(66946007)(5660300002)(8936002)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bCnBvVSy0EPihrSNgX2PHijgWpFgT0MMpP+Fkne4L3LFWlci4UPcjbyfAhR?=
 =?us-ascii?Q?KWUI0R4qyd+sAYE1d50StCfCBo3RoEeJE/ivsBb8y0/zaYvw4nOghO3/M9P1?=
 =?us-ascii?Q?OJGaHo+fkhupj0pPI3KtLr3MLw1O0aKIJNqHRzessG+JRXGhJxraHdqliI7J?=
 =?us-ascii?Q?xzkXAfw874BTUEYa9dHZ/h1MbNthieY+nTSr2y5waqKiR8AbNcz9JaOsES8b?=
 =?us-ascii?Q?ISd8U4WqUQ6NaCnmq7ZQC0ZIJsc/DXZdC/OCoffU9BIoew1U+3MXcJxkltRj?=
 =?us-ascii?Q?sntGKjmhU2U69G2/ewaQj0PjECaas0go4bOe87dvx9pXQ0b5i/w/kLtnDVv/?=
 =?us-ascii?Q?v6kdELo5hQ8F4C8fbRNSjWBKBBzFBpo4pv6JrIzFUb3qmcENkvSWAIqGf/2I?=
 =?us-ascii?Q?QG7laJXsFhzhzSCYESxnJQR5juc3oJmd2/zBDMrFnYjakctn9PF/DtIsK03d?=
 =?us-ascii?Q?kekRII3QYYU3g9DCJUzEoQcddm2Brt2MNaS3NTDt3BvElphOQpjm73oDOM0U?=
 =?us-ascii?Q?7XT9zYMTqIUBrvuEQu42e6YHECtqXOjjj6yJyARJHg3ZfLJ4vJyXyNKR2VJn?=
 =?us-ascii?Q?CEuMx1/Z2xHGPiX0ogmOJwMKuAi4c5NETOW09uQQ391eZTmNkAC4Tlld0TLf?=
 =?us-ascii?Q?tOPZuFA11fk2cDG60p1d6lfesOHm2vfkwvQdfEzrGHczSznvsyQBdSmPbvNX?=
 =?us-ascii?Q?X8StkiqsUTknT8zUSjt582DkTHkPuqHOezYkabpHal6l02HwaNQcpESUQpbE?=
 =?us-ascii?Q?Hpjsi3CrZb9ztkwAss8Avf+ZW71cDLBzQfkEuZIq2VrRHaDRiBbkw/o5qpua?=
 =?us-ascii?Q?c7rSheScYFlOW3Vv8XRKqvnWQ4pP0g0izUX0SBGRUtFiPIGVMDKGbZ32b9so?=
 =?us-ascii?Q?wKeoK33UaJdx3qZmDxlStZ25mmzV6Gn/VEuj5ve5g04L6FNolb602a7EaVhx?=
 =?us-ascii?Q?OhPir6BrZpk3hTGnz9yUIuVX9mhEsQPY/V+e8I3VUJvpi6C0JFXJFThTG1AD?=
 =?us-ascii?Q?OpdPC3ik6QBcnrdCzLMpi+X0j78zZ4oMep6HVyXRQGroRwQAMT+vXO5JoOxF?=
 =?us-ascii?Q?2ZiJFDSY70xapWBBQdudoZk1T+BSj78hRceMtqikeL3SljZn9viMZ7I3DITk?=
 =?us-ascii?Q?Qi4qHNIUV4JdEThfMAZ6u4A+p6Mvj0roruxhIdhhioDA8Delh1jHieBPhRIg?=
 =?us-ascii?Q?N/odTy8xmuNHrX+31r/tcoJLQfrKcOXCZqIDCp9nTJjynF8Wey4RRJMurcub?=
 =?us-ascii?Q?sJOy95vbuX2sjbAjcw/kkUMcOwNOKaOdu4ssGaPZDj3URiH8GcqL7sdVPXPy?=
 =?us-ascii?Q?h1U0sk0kX+N2yyaTTjgr5viyFB9HimFtTOkYXhKkQrH+jwEv/bC58gtji6S8?=
 =?us-ascii?Q?9bMbcbBnW9gaO8xe2UEspFWC8ziPms90dGY4z54afqt6o8EQ1tYS2WY2FV5P?=
 =?us-ascii?Q?hgC8OAEGTlbMIf/xsqfZepZk91g93YTP471fj0EUBKCQh7qTXRzQW5JFUUHW?=
 =?us-ascii?Q?UeswSjVAhNGu4kOAYadYvIgIgtn1LnvhnzxzL7WkeNrDuCFOFrypaWBzRn1e?=
 =?us-ascii?Q?I/sYPyaybGTbSWf3sq+0Zc/3ceRktgXN6pz9cm8Mypcl6QTIkNFRCcxBSO8o?=
 =?us-ascii?Q?R1BVx/HGZxCE4DibmBUkTvs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hXtXmsgH1Hr2m/bcHCUMgyYeVXtL2jmPkUGtC7LF9N2GDkF4llNJ6kaYUgGJxDl6HdzBpwM2ObmuvlWqgMGFoqJhjHtqmHDW6/vYWVJjMkfOeH649fEV8ivyASXok4lbsk9OlAnBSO3IOHtCl5erbiiZPK9vJuH4TvJpjGj3GT8ksgug0wPoFLgrIKdO5H5VxvOcs9EIcyMJr55hh1u04kApV9p2ZoGJ453hgTfmDaxolrLaNgUWuMY7YfoPhOsljutdEt4muLHIy4vXbcbLIvRq1tkHuo3LgpADxugcQfoSwP4VX4O8yLHsDiiHnR+aBk/1hV8ljYCdaWmE8YCr7GRGjJJwqcHUHDSuUGvdsOn0HjsOFRWwnIHtd6ue/ug4LvytLpFAdSIwUUExNcsj7jhQn+HO64wdulHKVn/3+/w7CVSpK16RNfBRkqVtatM+i62JUHJaYlwT0VlFK6hMH20fT3176EnfChOghzuWgHNUMWthbZ+Zs7eZW900uWk5/Kd74WIV72t1xMQUtt2sriDnhBCo7n4UQFbPHZK5sZdngdjp/4f0+jymiBAwn/AdM6V8IeK1F//EmR0g80ymPBGXh7Hdo5LjOUNWJ53xIkXvl/sWxgRv4dP3xoFYVh53MHPWkedLDjxqXlkP/vZr0O9PbmytjTU8Pha7Lv7Erari+OhmBztYLfpKLbMYKQEVndpyqQ8iFJaGU6EzNewwNweLpjp2aNIItv5bG/+uEe/IlOfsFYstYZF92wtBjiImhYJ5KCg/331vit+uXbrMBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e717b33-8984-454b-3e08-08db2b924d29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:32:36.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCWtc44ZVJ/ebKQZoXzJB0YlMsm71I8+KUiyilfjI33sP13iW1OOjurQlxE3HyoJhnSKiI+319Gve4jBoLxdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230087
X-Proofpoint-ORIG-GUID: jws9kub_EZ3EcPmulzjXMtF1BmPKMCJS
X-Proofpoint-GUID: jws9kub_EZ3EcPmulzjXMtF1BmPKMCJS
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 12659251ca5d  ("btrfs: implement log-structured superblock for ZONED
mode") moved only the code but not its related comment. Move to the comment
code where it makes sense.

(no functional change).

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cc1871767c8c..e04b10a73d3b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1360,13 +1360,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 
 	lockdep_assert_held(&uuid_mutex);
 
-	/*
-	 * we would like to check all the supers, but that would make
-	 * a btrfs mount succeed after a mkfs from a different FS.
-	 * So, we need to add a special mount option to scan for
-	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
-	 */
-
 	/*
 	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
 	 * initiate the device scan which may race with the user's mount
@@ -1381,6 +1374,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
+	/*
+	 * We would like to check all the supers, but that would make
+	 * a btrfs mount succeed after a mkfs from a different FS.
+	 * So, we need to add a special mount option to scan for
+	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
+	 */
 	bytenr_orig = btrfs_sb_offset(0);
 	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
 	if (ret) {
-- 
2.38.1

