Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9577FAFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353246AbjHQPkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353317AbjHQPkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 11:40:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5030DA;
        Thu, 17 Aug 2023 08:40:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HFT1o4002805;
        Thu, 17 Aug 2023 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=lie4D7edqdcOJGaIkzp474dTf1HicU5bOeyP4RtORoM=;
 b=lQqan3GmX9oa4wCAGlm3Nd2gTdYBfJISAHQcNj6JevSgkpFzdIR/v9xQO6l2cAqf//pW
 X6s5dCJA5l79wSLXP8Qs4aUc1/vuGIv+4ELbyz94PaNQjno+SzTDlKEiPbxRBXambnEf
 +DNThL6jaVoAv9AS9uQPucfuCnQVVXQIJRR7TLAMuYkwQc1WF04XZHEUxrWYU/NapRho
 dccVCbaAAvwQhyGX3HWru1ObvO8U2cbHHJszVHdy62sl7TYv5XnCOyBkUgQWvBuyj9xn
 ibUtxRpJr0i67LSXwhYQ3lSaHgqOXWdiqMYLAE0tZ+u0FXDeQd8geLCLfDL2NFgqs/fV iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c9rvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 15:40:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HEESAR027346;
        Thu, 17 Aug 2023 15:40:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1uyx5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 15:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcL7ye4LSTmmr7nkBzF9QoXscJCVJBUbuAo2sy/m+ye5imfiARxmP90mSJPeTmJ4A9nN0jFevNktUif0bwWLSqTbsQYkKUQRtWTtLF255Tgw+sA32Dd4d2oKnke/RHkSFbaiBKhmNy3LnYaUJRkUH1ptDa4Ns35bzycdcTy7CYHeUnqH6/QGMuMoIC4wsMdyGd6VSiSiTqVfO2754L1Vd7xNbcaFW4u2/JyLeoraBi8M+Z0N48LGH15fSRuEwAsVsn9ZVRf/GzTFF5LSjP1tcsAvE4GOfcqxKJhEZ/H5GDUa/venBS5PgTEKHtPiWQt9xAFgvbLBOI1nIhtuRANoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lie4D7edqdcOJGaIkzp474dTf1HicU5bOeyP4RtORoM=;
 b=bW1uuLg91wxbcYCY7DZNG24fY/k6w7L74G7kfy2OePqDa7e0U/pJ4g0JGBOf23AvcQyw1pjcLoXMkPrEPAjFs/D6x+2csW5JpAH1jD03E6qHMNYJ6z4DC7B8s90/8OdrRYb6SaETGIPiqVt0To/Bjs3ut9mINFoEHLGGHClo4XDgdEVl8hEh8gX3iXIoqIddNa8gyIgPJv6Z+1fjSGkfsdZnEWPqiW3uPHrhdg4h9dlN8R5JCOHpfmAhUpifozgygJ1VcNvvWSDE952eZdHjMkxNOmbxwgkJFNWWy86E5QJdjsIuV6GyVM9yS3C5Xzax8yoKEQumrTBRiH8SAp3s5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lie4D7edqdcOJGaIkzp474dTf1HicU5bOeyP4RtORoM=;
 b=SBaoaU+yOns+ZVUAigPj05KrYw/FbDKB8o9Dg8TZv7SutS2DP9H9+5O1tDyrXvmMB1ORAHAGZRuAfEcAU6IkFxLjsIfLTuj4Z5av5XAueQ/ECBhmCYSRoc47A7YDbDZlJTAMH7KYEUioAySW3A+1XOlbUE9r7StxD1e1eVpXXGg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 15:40:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 15:40:11 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com, ddiss@suse.de
Subject: [PATCH] fstests: use btrfs check repair for repairing btrfs filesystems
Date:   Thu, 17 Aug 2023 23:40:04 +0800
Message-Id: <2c89e68e7a34f1d0545f19e9e178e258f777c027.1692286458.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 628c06dd-18a4-400b-d12d-08db9f383de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TjN5GgBJDnQy9YI2nqbSYM+CbpCDowoGs3QCdUapAV/PSlZlvBfzbABFRm1QmoBrAPjgBket8KDa34MFERJl/6aokFvSXfPy0XGo8JTprl6X2yu4lvOja+i9g3zJZbTaVR3fkRK/7IWiL6iPw/h0jft3N/2kTUmJ+tqvzRFTJyhq4cdCFdD4jqOo1MdL0fY2rJTPEo5EtpC+rnomCRo3REYo0IVkOcINMUO1yheVdQwxaCA771e3IUpcJCSQEGe152vN3uikq4b4V3kHxky2ylrmuSnoCMRFn00BY7jReGYG42o6+vAk4FeaGNBHqT1ImXdIqHslxIYWPABkANEo8LwvGFW3FhdCuMzdANn024GSrthhgvESbAhf/DypXC3QJ9hAwfTxFIuuJSGAMnnFDinf5she560bGC9ghclWt9r1UJm0Rx8DseKsxcWxsGNzqG3M0AhDf1Oyk8KtSdW35rWVQWtZipOJg0MpMCnJ/sZOXjidWPS+aEKA4lCLxrZom/M4pe6lgqF6YT5FWSVX7sJGD4Ev7w3fZ4yWT0/DasulFN8ighPVcYIAd9fYAX9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0Hgy3hnjoLSV0SXtwmpV8YA8JlAnMfHMzgbqAODWcY3SwjIuBx4/aJx4G22?=
 =?us-ascii?Q?eKwrgHsxTznU/6WjzL1tUPfmYZZbdTbjdOpaLyBgHVrEOPv/kxy0E2FRfe9L?=
 =?us-ascii?Q?xPe5mp2i3C6aTGGn8+vbvZRnEoeXlg11UzubQynTIwha1yu+V7PxNwKKzrwc?=
 =?us-ascii?Q?Qfc34SXb0gnXgaj3/xsgXkbqmehtTu8YLKJnzclnfxxEthWPRTzrIq9DnQ8H?=
 =?us-ascii?Q?BHGKQff8BO0PbTz6K3OntjztdJMjVcSYbdtj8GdQzmAqPoRsh4nUzlqTUFaY?=
 =?us-ascii?Q?y5yU1l4Ei2iTS5A7M/iJu7cgb6+quR9UlYKuAhnFRffJoJ9bz+xBFujRJxEY?=
 =?us-ascii?Q?xGrjZxopiVFksX8UfsVAVffMIAS6cNkX4LIe2HPD+UIyS4GSvszZjhHJMO4t?=
 =?us-ascii?Q?3N84y0WW3rfKu/W790dyBrZBancIaU3aZIuodRu8j0UiPcK706JIg8JXa2gc?=
 =?us-ascii?Q?VW+HQNzok6iHEYn+CrT6LCXsm15aFEtnuj74mdvKKIFzceLtRM+nmesLG/3I?=
 =?us-ascii?Q?ZwAOjBdYaIo5r7lLj6NXGM13EwEI7s+3d0q4KiLmaepJ7EhBip/bdclYK3eE?=
 =?us-ascii?Q?sPi54VETFmyej/BKFcHtk1nxOumkxMrLivoBtt6gHApv2Ile5UOekHHKY3hx?=
 =?us-ascii?Q?4n0PXLqYJGmyJRbbZmmKbEYlqIDIwHp9mtaighU9wKinHr91wilCHfUBjs4R?=
 =?us-ascii?Q?qp53AHz0Syw0kDvGUkcHrrA3rRE4jqqEi6poBKgZPvV4XM05BQHOEO4uu1KP?=
 =?us-ascii?Q?rnb9zJ4kFLdznshj6Z2pJYBinvLCIw7nxd9M4XR6uxn/sBNqpbN+dxCIdlYU?=
 =?us-ascii?Q?Furx82OEwb0YmnbtvbvsPtNZcytvR0IFpRuSrsMdt/0Lmvna0d+Xjo+Zvsxl?=
 =?us-ascii?Q?nrQZseTqJvpJeooAPDOpdz/Q/EkHEsmvdqct4lkXH7RjcJD//Gwd40hMMvcL?=
 =?us-ascii?Q?hE8Dfwbb80JfCl2ID3MnKMb1TVSX60/F68EETkwoAatmeensPoHzCvEjK/vJ?=
 =?us-ascii?Q?qfte36ot6b1vbuZIYurFDLmAxTifevN8VJIwqFh4jPfan/zxZZcryqbfsU1J?=
 =?us-ascii?Q?iTWdNKjp6vHK8vbYg1l8OwlfEXg2saBQR6dPhtU/nrZPUfgwtIUO6VdkyE8T?=
 =?us-ascii?Q?A2MzhVJL3u3T9OYW2HQ3iwpvdknVcUaLp6/BPW6eSvsHf59Vds1yvhCbH6W4?=
 =?us-ascii?Q?TsMykvocuZEUjLEjH2ZF6dQjdwHn248E/AyQQ0lyn3pMnshnLAzCNlOdkhnU?=
 =?us-ascii?Q?Y3GcOrOCCL12G8OvE2/4gjnWyq643CAy1mqAhqk0orzijS7i1j6p2ZB8EMm6?=
 =?us-ascii?Q?p5GlzKvt00D03VtNiHRunBydIaSxD/qnlyoqY/ldQp0eV1WfZEvRgWJ00Vi3?=
 =?us-ascii?Q?k8odoS9iLpovWPXodCRCo8OPDXGAQ6m0oQ31KZHj/buSDY4+siH7qcmd8m0A?=
 =?us-ascii?Q?7dFk/fEjh1UbzWlT1kYGtDfugKJzAltG6TX4VFRnAosNnKwkx0X+WzKemH74?=
 =?us-ascii?Q?vaL2NVL2HdHDZSkZk9+2283p3pHH3EfIaQpFmN+LunQ4l1aghwySzDx6QcIK?=
 =?us-ascii?Q?ko95aLBcUwbVApIdGYT5c+wUaBIKb1pllYyNbVkhYk7OedRc8BNzEgSrk4aw?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZvNYNXCeje1m5Sz8XSPe8d8F9skYGlWgVujwBVlgFYGZ/2rgBhToI+KWqhpMWgdOvkBF7dLnaDK/z7rMMqkDeSSQCwJez4+0osuaH5msKy3JDsi9LKG0XV6Ecaiz16KLqfLTtkJcUsB2OdbOgWZ/N3mw+p8UHSrlueap7XfBglEgTAIwbXuxqvaNEDfKa56NB8SG1/otF+OhynImyjIcNF6ArI5GVtyTKfygxuymjYjEEDf58bVTD+ImVuJA/W29onVVkTP1UsfW5s0QBbIalnGoBJ/FgVZdIsbJSAlL/6/Jysv9T6bo9lQRirykp1HvxrKKCZhmVmN5kPOq3+BW+OvsjdtKhedOVQPM68DhQ+/CrrbnFFbTU1BWoR53Zxapo9+YQFIVEnQENbZJb+Vmk6EJBce0N0W6I/iVnFg5sLCDP/lT4dpsv1+d6jDSxdLTvXBFCETPDCRqM0q1raePSPP0dkjx2sFhpgFkLEzTqaNm0hTlsAsT802VXj1oDPYsnl1fobldWDnIkBtQMU3NyOZPfMeFqH32p51ikzKNY5BCL8QnrfLJfbGT7HUJZzpPAc/MalUb0eVjBwskMrMFxgPgI54iVymk24k5c06rdsF5L21gJKXgwZp0EwKGnAHNWWlNYuW5fNc0sGe0iQ1OLIiJpP2lXx9G82a5y4Hr7uUBdK8p0UAqDc0cjZUnEnG5oN6sRWBXawBy4jn74rG+4t1bgaASdgDSedqGQONRk/mDfj/kvVXbx5yU+mz7uugHZQPbGv8HSVyXxYb6rX3hktEk1glwASA+/3VUg07fh59zYIPAVlU4CoSghHP92Q3v
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628c06dd-18a4-400b-d12d-08db9f383de0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:40:10.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGN94sKfmstAIpbJuEJ8pqGs0+3sR+icXTOvkn5RKE10GafQdWDTaiNFjMBYcdc68ubceb55L1QnL67717DnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_10,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=910 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170140
X-Proofpoint-GUID: M1heTtENOp9FcWcnu1BAFnABLZAtBedb
X-Proofpoint-ORIG-GUID: M1heTtENOp9FcWcnu1BAFnABLZAtBedb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two repair functions: _repair_scratch_fs() and
_repair_test_fs(). As the names suggest, these functions are designed to
repair the filesystems SCRATCH_DEV and TEST_DEV, respectively. However,
these functions never called proper comamnd for the filesystem type btrfs.
This patch fixes it. Thx.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 66d270acf069..49effbf760c0 100644
--- a/common/rc
+++ b/common/rc
@@ -1177,6 +1177,15 @@ _repair_scratch_fs()
 	fi
 	return $res
         ;;
+    btrfs)
+	echo "btrfs check --repair --force $SCRATCH_DEV"
+	btrfs check --repair --force $SCRATCH_DEV 2>&1
+	local res=$?
+	if [ $res -ne 0 ]; then
+		_dump_err2 "btrfs repair failed, err=$res"
+	fi
+	return $res
+	;;
     bcachefs)
 	# With bcachefs, if fsck detects any errors we consider it a bug and we
 	# want the test to fail:
@@ -1229,6 +1238,11 @@ _repair_test_fs()
 			res=$?
 		fi
 		;;
+	btrfs)
+		echo 'btrfs check --repair --force "$@"' > /tmp.repair 2>&1
+		btrfs check --repair --force "$@" >> /tmp.repair 2>&1
+		res=$?
+		;;
 	*)
 		# Let's hope fsck -y suffices...
 		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
-- 
2.39.3

