Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B39769486
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGaLSJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjGaLSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:18:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED174E55
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:18:01 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAj6kE032213
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ibnVrRF/6hIhuBav1zZoYNYtEf8m2cpA0E9A95Mc+bk=;
 b=fVzt46LDA1pVg7nfwYZ9fYrguZ5r1P9j3+LvKEdR4BVKi5xctEWTgrYFZzlJSWPscLq5
 7xCWfN7U1h37BNHn0T3QfLGMuyXZ5LslVpXhett0JRT8Txocq5cfk/48LdNOLONj3h26
 eK84nUO7aWBxATKODVwDRdSLh0whf/FDDOeZeh6Xgi6yn2zxX8Zt9qNMfhUempeHjUy1
 tlw81rxkiCO2RXpGRpU9eYQkKIk3EYBqPhWtYxEf0aEC1uoSqyAFOdT2OD5PZ4FQdtTt
 DNPgoDyNIT4FzPJokB8c88Gvra3+u5pwm8NDDdk92giuYAsl2CfBXiAJK6v/hcE4O3an aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc2bx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9OEN3038121
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7avwdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIEpQM/FQoobKjpXDElFAYVpfFpWgkg7cRzt1alOFJu7xDLipKXq0SgDZuEAIpu/JHeHwKEREf9+F/XmPCtzEiriMi0GFwmJL5kZvQUOMTM8RkZu8cwXejFuNI4nPPNFluQ1ewwFGJOSSyg3k0MWJNXPuN3TFSIeFUB61JAe1X+CM6K7IFo8PotJ0ciNPPyL9XGtdspsSoCUO1GiFbx5Nb/p1Duy2x+GryyymJ2nybo5OPW7lTrhVFHGRPsJCZxXaKiDrK51nU977QIduW8J5YOcPjTUNMCCf0lm1/RZ6Z+SKQCfM8e45MVd4Y8L/161IKytupa5wraC6gOK+R0XUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibnVrRF/6hIhuBav1zZoYNYtEf8m2cpA0E9A95Mc+bk=;
 b=ELx17u1a3GKSWncvsES0udlC+g+xhfi82H6mKK5d6n2nUyezxQ7iVdH7GehorYKrXzPfwrGh1RHiiBFFkPhwCcug/LKY0V0Zta9AXn+VtKA9XCOTwygcbursBUPOAZZE7PKRkprh18Eg+J8yVIZs4z9+InIVHGlmMMI83L3yRmKBk0bkTgxxeZaqISmxLpcCi0KLT3q3hYWC+fp1CRcNqdNyu3Un7JqJAvCNCUOjuOtH4rkRM6QhVFa7q5rBYnvoo/BUigp0an/tk6rYTmEBkR6+PAX/73l9vO0lpIwRXpFhbHvbqwxRfr9uu0HQP1ilxg7YDD2+WBrHmSvdAVGnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibnVrRF/6hIhuBav1zZoYNYtEf8m2cpA0E9A95Mc+bk=;
 b=eUNMhA9MgUvsUgITtXVS+2MPgZywDcdYo8Z69Y7wLoeysKYBKUU9sGn7RWTDwG3fQHcd+x2oAhy8Kom8F3R2RRBybir/HDiuf2JhndejOCS8/pwkk2Z2gpNKGPJQSZUWY8MeMZYaoSeGHCJLFfVJ4FPSQBua5N3xwepH4Af6LqQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:17:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:17:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/7] btrfs: fix metadata_uuid in btrfs_validate_super
Date:   Mon, 31 Jul 2023 19:16:35 +0800
Message-Id: <35e2982c9d712253aff6d5c771ed6a3820a5090f.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3a4baa-72c1-4802-063d-08db91b7caf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Onu7oVY1VF/cEwXoo/pf7N7OouhKtX1HLYLtfO/z5lzQTdMhvHmhje/kZSHax5uedRIs5IcKaJyUF9rPc+UIoLjWumK0gBz/uo2knkv4mkGqfi+4JFesAsJt1FhbphOzUbGRJIKb1uFEexb3dcB3/q8RWfJpHGyHpn9b9cOaiWOfP86zbaQYhJ2DRoQiBITlLsh2r0jXDLsW47PsGNt1kXSGslNBwnaeK+Mz8rkwWElDBnR6gMEr6MbbXGT87Ou3Fg/qX/WwO8TWb0uH0KKY6LJfZ69R2J5ymdWb6weFAEHWuyHqBr2kv/dnm7YU8kIGWNBFuyZiy1PnK0c/qWLkEwDWjD7/qDk0V4+RHx/E1YsikbgOjXQEOFroiCDny+Pl9nvFEDeOrLf7FVrGgA1CjpqJ2MUM0g6IonhjF7G7dpjBjHCxrfBsb4tdVnUI/lFadERNv5cO0BQlHmmS9c0668GJNFSjnuBRhuDo63tDV7n8KXUPMI1KX95BDhrZtf51CsJ56iT0XBfaHva7RZSDwQ+zsuA/83SxVVBvamoYRa8B5053BEIJf4DWzxMBWRyB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+VoZxK6hIQzXcBB+FxXNWuDPnU6qfzQErhLboH5CUPc9CRyGhvvtLpd4oAF?=
 =?us-ascii?Q?jcUcYVJXCDhkzPxKjleH9NIs6MqrysorYRSaBzMj6oLARKj5rLzWykvZwieS?=
 =?us-ascii?Q?ERMi5yOmO+JJsERhwHvZG23DGbzwgKDZPFOIQbhEDTym1kJZCq/4ni+6JCBC?=
 =?us-ascii?Q?Zv9HEFRvst0MIJWOjvUmOoBp9O9Rz2g8BBvq1fAdpodzP31KgNZUDEZWN0NG?=
 =?us-ascii?Q?0bAnAQqE7TAtns6Hq16vDLc38lnkwe8Tzub6dGRmqgOpfu7Kx/ZqUC0N9pno?=
 =?us-ascii?Q?sPxHNymp1eo41c4pIPDSMO2KeKYLJCHXDXrLOf1lXuqIjrMKurjVwS0Tqs0K?=
 =?us-ascii?Q?pWvIr2PGc4qo5E8agNYpfDP44B3E4KNrR8CMCA6YAHYmtMM54Tu2hNtGKlph?=
 =?us-ascii?Q?JWyRYIsyRh/kSiOoninUplZ22OThp9N2WlM8f2zPOKE/HjkFKfia4/qvxCzD?=
 =?us-ascii?Q?TgqAVdjPNrC5mMfzXEJvB31GfFHBWjwm1L41QJjVzLJb0WNJCvMJnM25E3T5?=
 =?us-ascii?Q?Wqpucr/gyT51sYP4Gs1zZ3XobMFpzToOwnjv5BHGmay3KJd2jf6/3BPfDJQX?=
 =?us-ascii?Q?cT6RPG5JDl/Ica3Vkl0esrluoZINasSpr9qWxsGbgYXOZvwfvfuknuP/YEuL?=
 =?us-ascii?Q?PTlrUAHbFQfzhe8SybarTossjZcl412WW0v1NJ5T33arRqhEMXjROwAC2wUK?=
 =?us-ascii?Q?RiEoYpvo1pnD1++kL243FjqLMdv3E5lklfozSdzBGDvRkJbf8IpgcQ9wBH1X?=
 =?us-ascii?Q?c4EptaX7GCDCNfnnku9YABvMd+6/9FFyt8NPVtI6JzKx4sOjGKUpNfELrFnx?=
 =?us-ascii?Q?THOXHimvEfUccKX91Ljnl2hC0glIDTVYGZA6e9XG/FxIahBFAKOWDZX07h+D?=
 =?us-ascii?Q?plU23y9/67t27e1Jq/VRo+TFJHI052N+bkjYxHY8wkk7LriR5KQ6SCU4r1ib?=
 =?us-ascii?Q?70Pi/CqQPl6sTC3dVwcHmMb7Pbpxj9Z64YCG2eMdm1SdIi8k0DNQhNuqduDx?=
 =?us-ascii?Q?W6BWN5yVJqoKAwMcdPsoD9vTE/IpKRGCNboc4MApqjpz3WDP1XXAybGv+XvJ?=
 =?us-ascii?Q?nhcWVZPPArkkBHOzs59mtBQTkURxWaQCsF80S54MKrajlib6K5NWtYZ6bzwp?=
 =?us-ascii?Q?hb/TEx0L+vvb5BACaVBauxYFX1wSPiz2PJTIE7JORTVWeeVqWIM0Wbb/GJbu?=
 =?us-ascii?Q?M16a3S8l+n9SFS1ozaFF+5IUfwUimQqbUUlK09R+27ljSYWeAdq94AFxsF9+?=
 =?us-ascii?Q?i2SUlFCkdYLb5g4WQiI/NlJ1cqAx5JCchTXEDJGlEjmQDgIfzlrEw6jI3gip?=
 =?us-ascii?Q?pZj/hOWDf9zXM/0Ydl8u+0tKPpA7E1L9A2GqKGO+LcvMootXZdG6fXE6GHfm?=
 =?us-ascii?Q?9z5I9DkyMNllyE8J6d+AEHpxalKCcwlVE0lGsNj9rxl6ASAOTp0veX2BzPug?=
 =?us-ascii?Q?TmoHPlDRyw2KvSWdw2NZdoYkitMmpdFHL3KJzAlfSRTcz3mvuHK2IQtjB/4V?=
 =?us-ascii?Q?O/p3PkeNrcyqL5AaJLIYLslIDtIUoYpz+8Ts+9N+GVzdVaSv+qYiMqOu3gjD?=
 =?us-ascii?Q?F8sEXJ83ruxMQp15Kygt295reasWSrqmaiNaqDEV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FHbq2hFE7iDN2FWVDMBvQ1WdN2WPyMnp3oedYuow7fZA5ClgMveDh26eWrZdp9De3C7uCf/kajMG8Riw9r0V4Aqyb0xypaG1Yt9bi5NRJ2SlwImmfF+IVtJgMsGtGMMzAbIUdFUclQgXK9ZRJPK1yBG+mYhtt/CaJYsZrY0F3b8Y3Lm6kP5lqUORNugsJNE7jbvXxx8scnFhoVl358UlNjIm43lAkT/2lRSxIvfSKbDgnyCiI07XyJAUOSDpWkauQyx2XPO3NRfD0rfIyl6Vm5ABpCMx15MsZBHpf0Rhb9Yf1iFsX3ZjwT9N/iDDzEsj95FDMCGKLuVjUMM5S5tOytLPW2HtI3nI1qD1cEb7NgiUqEh1ZLm4Z0Bb9v+wkkOQ+rOpKB9yG+Ck4YlrtLwpUs2+2wvkVzBPu80P/t4/grMi4mo/onJ6fa6yGhMLA7hzcWaJU44NyV8DhNYVXvm/LSMVQlyeLx95AiCfD8GIqieHja3pNfncsAHRiaaAVL8PENVMldBFJfjwrmDB/mOnaSTDbSvvnMveZK2Qx/8yWPwsrRibapB8Fq8Wk4CNz/JtX9UBPEFtXSwW7kkAPTa79jVWdY7gEnC2HfwDAHb5VRZDe8bs+m49jHn27OP9w8iISC1DClbvxF4Ja30ykJXIDaH9oOyxbAAl/OgkEP8ctfP/BwKl97sOhMD5URgOAdoR0qVRan6NrE50uBKm9GA1SShIJjUWhvVzc68e7cit8+ClFVZuVbeN9mtOP+72cRVClaelj4HgwoP2FisOwYKslw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a4baa-72c1-4802-063d-08db91b7caf4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:17:57.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hl8UJJUv/i/Kdb32tDyo2hh3B9Ye9X8zH7ApaMMJvlu3AJSML19O/2+/cI7u2ijR/reFhQ7ucFlx3ECw0t4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: cZ-YDGlOzGEQXxySXPYJYktrPbxg-9PY
X-Proofpoint-GUID: cZ-YDGlOzGEQXxySXPYJYktrPbxg-9PY
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_validate_super() should verify the metadata_uuid in
the provided superblock argument. Because, all its callers expects it to
do that.

Such as in the following stacks:

  write_all_supers()
   sb = fs_info->super_for_commit;
   btrfs_validate_write_super(.., sb)
     btrfs_validate_super(.., sb, ..)

  scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

However, it currently verifies the fs_info::super_copy::metadata_uuid
instead.

Fix this using the correct metadata_uuid in the superblock argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f2279eb93370..e2fb11e89279 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2380,13 +2380,11 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
-	    memcmp(fs_info->fs_devices->metadata_uuid,
-		   fs_info->super_copy->metadata_uuid, BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(sb),
+		   BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 "superblock metadata_uuid doesn't match metadata uuid of fs_devices: %pU != %pU",
-			fs_info->super_copy->metadata_uuid,
-			fs_info->fs_devices->metadata_uuid);
+			  btrfs_sb_fsid_ptr(sb), fs_info->fs_devices->metadata_uuid);
 		ret = -EINVAL;
 	}
 
-- 
2.39.2

