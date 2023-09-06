Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55879415E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbjIFQY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjIFQY6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:24:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5911998;
        Wed,  6 Sep 2023 09:24:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386G9VUi021119;
        Wed, 6 Sep 2023 16:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=tQaqm76InSLya93phrNoVqAE5i7NQ9+Feb7una/iCS4=;
 b=D7OOdZVMik5kCWfsNQFIJJMfMv1WBZ5kgCyaEEBPatBui4oTXrmj0/OFE1XLMn6QQVpM
 NNffezM824lYY34XW/1LEe8mrJa3UHPl1pUznZfCvZJosa74JUu7j+mOGt0zSUThHRq4
 g+N+vRt/U4io3eQwPm5FNLA1IHBq70Lh0bNrj+44BT/XtWsUPdVpPnX4PMcIGYSS1VlN
 /ryvZhjsXx8mhhNOMcI45bdWjvJzyayQRngsrgiB1cTy7vt4cUx2cS1i1BlrROVBjO+y
 g3LFvbebu/XyBm75IlnLtXtepsVmz4AmVmMfQqHfJ+JbNyGGqvGl/kwQooQPtNEp4p/W 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxvpp01gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 16:24:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386Fvo2H006579;
        Wed, 6 Sep 2023 16:24:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6ynfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 16:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INnwa7Hfb1C8PNBPS770N6W574GOBrwKrWOX3F5h4K98cWxAeEI2NuhzL/aRH5amju77ew1B2RGyWQsG/Xs4xN03/McoxRI7skSuZWOlVO92qC9A9e1T/8GA0tcr9pxR0EJmNIaEvxVfSyyRrhDKdmFWCzvw+9p8Ul2E6yXuZw5ekc+C7jYXJj2dRCtzB65VmLL+FWU02YtUdjZsIuJPakphJnAjRwqzmknuQ5l3txiS95U4b0uJpguxwSpbxCPDX49+1xHwRO08JlC+3Vn2fwFiQ0kV7/SDz2Bp8NxDwDwLeWNaXrillmSEBxqrZOzfaInKuUOtcGIZoOVe02VhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQaqm76InSLya93phrNoVqAE5i7NQ9+Feb7una/iCS4=;
 b=YMZUEvgCbjARbbJy0GYvCqrB0+1bsayHSschMeGZbAk7XpUtFmZv+W5uL6c3pkX1nDDTI6EZD4TpALOFYuTgqmIrNyeYr7JzRvRFAri6p9/9N2412DI5vrTkbX8b80XZBBbbw59gTISYjtCNWV/9+hNgW3NcgO8yfVocMeTOhjPRzZGsYFta74WzGX8tuIgx4DuYZWIudoDaOupHlCYgp04YHoy9Lc05oe1VdB2TQhYtHSkIszr8NLZPmOf3t2+w97eemtoC2phHU807hlRbPzpsdKqL72N5H2q8s8qc8ZqMJgmxLnjsK6nK8UJ+c18+1lDiPOCIVF2LwIq9tqpjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQaqm76InSLya93phrNoVqAE5i7NQ9+Feb7una/iCS4=;
 b=gLCkgXecIyYNshyUKJ/lYcIYlYWejhAueFIpr/c+At5BQx1CCoxhnu6Ayv70g3KuSrRLvuLvX0R4/AeYaRA6N0qu9RvEW6EcbhWdlb4xrbNEIGRaLPv72DsUjDGooA6lLAOU5kshFhLRXYt5OLbQJlObqE5QY9TsBjPoGxo4BwQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:24:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:24:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/185 update for single device pseudo device-scan
Date:   Thu,  7 Sep 2023 00:24:43 +0800
Message-Id: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f45349-00c2-4249-d41d-08dbaef5cb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKlscwD8fhPxG3lVAmXA5WDjH/DFp6YmctAqoR/dzkm16kihUYtQ58Ih0rDzKtg0fs2g07QOV8Q9twqZ74wfazp5qXpQoN5qVgDW+l8KoZzsXzZLGNPKz/qP0UE3MgKTVvNYue/3eJ3aw2iFjMLvS6l7QH3pDncSLBbN8eQx548oTqZ6Y+testt+5ra+aDuA0jmAm4H6IxpQEGlUNCrsWmG6a50MK3n4fxZxc2SR98LuXkDLu/xAROuuu8QxjTNiXVdHTzBPkyeNuRKsegmXjSxDeF36jcICvcJAhiJcl2/zq+59MT/DFG6rdHvEo9uRMutMBrVHmkhziZIuhyr3ZB4XF6TrXUrLPMf+AwE5TFr8XkAyoVE3qY+vOHTZgYyRN/NjttLuJQBt96jxpVEsvv3If5tjn6dGqqyS4wTCFrEob1buYHSwgVBYEFfmcJy6gnVyEoeoOyf0AZoWHX8Cp88QWtF7yvwXe91gOYN4x2nhdKx9ZujEHqftfvpL5j7WVGIIIuavv2NE2ppVj7MipHXwmr5E9UbCjPa771CwIdZM/VpRWf1/eJT/iTWRYlal
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(6512007)(478600001)(83380400001)(2616005)(15650500001)(26005)(2906002)(66476007)(6916009)(44832011)(66556008)(66946007)(8676002)(41300700001)(4326008)(316002)(5660300002)(8936002)(36756003)(86362001)(38100700002)(450100002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3b3++44hSA7ZKVv1stizq/AgHpZKFRYGqpAmzyGiATU7qensSozoj+OkHu8?=
 =?us-ascii?Q?oIdronr4JzGgxzmrLLSKQC9quS6Goy0guOiSq34deIg1CUAFTcALHZ2fIszu?=
 =?us-ascii?Q?kSaiuKuj7kp2O/H4aXPZxqMidGfu09tpa9bQqBGEwWNEJ8QJwXL2ZdjmZxzz?=
 =?us-ascii?Q?WRqcsAgaGE+z2EvPpIzfqSuo1FovXas3yTjZcCIlTqvUS+P1PLqaFFfAuvKl?=
 =?us-ascii?Q?WD+s/8HM7wPvF84NA4aa+Ig2P6da7uV6M2vS4drtNZoHy11g2GVsCTMyNkyJ?=
 =?us-ascii?Q?18ALTjbq9QZdX3q8fgx1L8HSTYBPx0wD9UdUOuTBAjH5YLADeNF93uZZZsMq?=
 =?us-ascii?Q?HDfV9gUDoZY6WQofC0l8UdGH1S46Gh5mlq8r8J3rTs6WT/+OfFA3uklYElgI?=
 =?us-ascii?Q?2E/KAyB5ooln1hR35zR+5HRd5W/Cpm0Q70Nuo7LHD89Y1+gHZnxiJ1R/I/Pd?=
 =?us-ascii?Q?TI0pngpdTdaKpyORYK9gnH293GOh0q7iRebCemfFsFWN8UsXRh+lWgVYRqaJ?=
 =?us-ascii?Q?prIF/yQNTL24FwNOpCdZYp0Wvsyl3Q6dJzW1VsfrayFQT4+32g/Y/x29jd+k?=
 =?us-ascii?Q?8YvUzdcuWz/7p70S/pEftb1ISPRvUdH7++D1g/vyyW9Ikc4npH4ZainX38is?=
 =?us-ascii?Q?EExDMLWamh4SEMmbJgTeUbQXQsvmOD2SE/iKUOkWgUKEGI/4xZDUeQc0/HIq?=
 =?us-ascii?Q?FV8LGj28LxStU5MMwbLWHlYj16BsuIKEBOvzlBdDn+3Tw7cciAxtdUYtgaAl?=
 =?us-ascii?Q?drFI2nqcIfdszRPU0mvFygop0HR4X99lYvQ345KqXkL3LLJPJ1Mi5osbiqXA?=
 =?us-ascii?Q?Sph3QPn0r2h+cgR9RRJyUUiaPycRL/J7foFWHTVPst0kzMPh7M6NpZEmE48m?=
 =?us-ascii?Q?o8y+XKveL5isk4dRYB1o7kkyoK9MeomZa3zeD2JxJwvK49xkG3LeuBjlns/s?=
 =?us-ascii?Q?UX5+H28pUo3oC+H/MQdyZW5Kpr/WjerF9IP5mNa+R99lCEMsNflE166bD0gx?=
 =?us-ascii?Q?EMqUqX5IsfWvISHLZtaQrk7f3UcU5+S4VqfC5GlGujHhgnO2ZJFSCQIn3bTW?=
 =?us-ascii?Q?Pdu+nc6MAaPg11E5Ea4qAenHRK5SeVFY+2lqfCSFLSwD1Ji4HFgWYSeAfcxQ?=
 =?us-ascii?Q?ykZp1r28g1CqK+tBECe5z3FCiuVuUK92B35dKCpb5xJiHpcOLjLiskrwfVK8?=
 =?us-ascii?Q?KYnfrx7yh1bIi4T3TiQ6iBxcui45Nd4T4J04awgV/aYTCdWC+TJqjc5tumGf?=
 =?us-ascii?Q?LbWVGmUZSk+caivgJj3+TyH1xH2g8xS8Hums2spgxpcl7LwmhgEXvkYpQUF5?=
 =?us-ascii?Q?86tRAgQDt1Vs76Ls+9Xep9F/AXZC+/LWjrfhQ/FKd5ucmFVye3yxuXFMd9Hd?=
 =?us-ascii?Q?R2Voq6C9k+WBen+KZ5cfolP3udbG7CtvUWoSTObyCKhbVtUrD5yEHzwQTL4D?=
 =?us-ascii?Q?y7/qeoRwDoPWhg82rsYrbhx99ixbpioaL0ZwbtHCUG9x/F8domQcK5UOoDwc?=
 =?us-ascii?Q?PMQUZ39Z8jBWyTIPO3PpqJ9ASw0Gg0Xa/lE/znDj5D7MFLxQpIO0ZrJnHC6m?=
 =?us-ascii?Q?R9cP2kdjcBn8VLH9D95oEK07JiTLF3te+k1dNKbQcp3N16Ogi5HqFOFU+hG2?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pNSGQsg0L4uOhab5qMAuow5vTGJLco+eg8wo3XQPU564HdPP73fBk9/qadRtJrDOLdRjAEEVqQObG/zivXrORvBdpwvg3GJViqubpschMlr+lA/pqNf/mhyZXqia5ljl7K6Pe631cVNk7/VrERRmICwLTH0LfUyzO8B6xfM3IvSthZUA+BLgMYqF79nudKUI5I0kYy2yedovM3ESfMX1Tq7g9OO7T0wiYurId9zBXZBblO7CPOyrsSo0UT9CFd4dndBiEAH32rQSquqBy5yeVdKgwQdNhK/LSTJGVxFn5UoC8aq/bYVJwgLn9yYl8VK+qWBdig9926QlYZWGHfV0mGJSfp0E+wkBjQT2A/HRNROs8DU8iZPksrcBLQvZyEMyXAnkGQ1QClqySh9fiFJIrqkq6ua7z5aApnWPdifdn6uuKzh5P3tUKFeMT6WHzakMgsgeqDPXDz3MULDqsFdIM3aluj/7KWvXSbHNAbbRQseJ1TgHFraNwTH9mEm69TBrAebni7rAM214+XVUub2T5B4v/vrE0FnWYK3SnrMVlmefJnNtGJYKDsLeM2SuqNLsFXo1Lp2o+3n6y3lxk5pjIBOT73Q5jIYGmvoce28SHpzCzZC/4DPNOnP5HCtk5CGrsb/4c6wjjJ15e5+wyfL6qtJMQs/xwPhO4GTlwXEW2kgaLasJjBiUWLfcQLFaop1ZOFbbM9LXRSyUiUK5S7huWTfj6ac1FtQlXMQSKcSJ+HVmR8cfSNZ1Fc5X1r+ezBq2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f45349-00c2-4249-d41d-08dbaef5cb16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:24:50.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DTurdtRWKAiNYo+lx59qOOnJZkWqGYIjM7lDhmiRVr8zJ7Xm9kngLpQyHixQDydwLMmy4zThPUcf7LGNAN/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060143
X-Proofpoint-GUID: 0oxXNvjt-IVF_68_pKVVxoXXqzWrX-S5
X-Proofpoint-ORIG-GUID: 0oxXNvjt-IVF_68_pKVVxoXXqzWrX-S5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As we are obliterating the need for the device scan for the single device,
which will return success if the basic superblock verification passes,
even for the duplicate device of the mounted filesystem, drop the check
for the return code in this testcase and continue to verify if the device
path of the mounted filesystem remains unaltered after the scan.

Also, if the test fails, it leaves the local non-standard mount point
remained mounted, leading to further test cases failing. Call unmount
in _cleanup().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/185 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/185 b/tests/btrfs/185
index ba0200617e69..c7b8d2d46951 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
 # Override the default cleanup function.
 _cleanup()
 {
+	$UMOUNT_PROG $mnt > /dev/null 2>&1
 	rm -rf $mnt > /dev/null 2>&1
 	cd /
 	rm -f $tmp.*
@@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
 	echo ..:$? >> $seqres.full
 done
 
-# Original device is mounted, scan of its clone should fail
+# Original device is mounted, scan of its clone must not alter the
+# filesystem device path
 $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
-[[ $? != 1 ]] && _fail "cloned device scan should fail"
 
 [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
 						_fail "mounted device changed"
-- 
2.39.3

