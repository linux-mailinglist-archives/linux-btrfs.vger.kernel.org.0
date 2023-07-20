Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D675ABC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGTKPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGTKPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:15:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80513E
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:15:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K93wn5025488
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=guB1cKqmSj5n7W//4UD80ZyEXPsAx01UQQbKCLZO+h1z21YwjDj6jukMwHfEC7bmWv/j
 et5TkEEYNvo/ym1pwRekLkUG1I5ZWktj0UBFgqwuSOOyRIt02bANyKu9orQ/KIlnK2c4
 d99XztidRnnAN3xjnovS1+R9PnrdkY8Aos1DzA5Zkl8U3ffUJwDmJLiEpiwo3az/Weic
 sTH+Ok+YziJqlE/admZcV7QkbaCrTUL2uHy/w+g4jZpBpEGl/lKZgrBnOXllbzQi5Kxm
 hIrqoDP/ULQmXMz92JbhWEg6Jk9cyk+6RuHyEV+LfDT7Er2HCjgPZWynbhkoaQbFwhrf Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ry1m4g1mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7RYHK023850
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8kp3m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho0VYCiSqgCmeBGyxFaSaSoOELzv5y2vvbfoEUMujkXC7xC/FL/nAa2hniWBb/1OANtcF8X5eCnCDMPPuwPzLS0Ugio+IqVgpu/KbnaBNWvBlf04ptWk4cjQeWt6XMzV9FFPcedh8dPkN3sU8Y2/6o4gJ29lCYT4Vs88PGUtBEuf6+ro57ERD76pBta7JrzMIK18KOZiNZSQD7cmjuFgm8qteYt1Sq8Y8aGr591vflWWPsWGaEuNPvMTkCRlrc7ULGNrfjVg5jaGCwgWPbm+DvJJPezjP5CLEksCNtZt2jtCljssIk12KR+VjovrEcmIOJS5WiJMxhHpEq2CD5lZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=OeCavf+fqwRJij1lBF/GLplXMT/y9qMe4Z7CIDT0HG8mmmoPNnGex1NYOouPblYwEAsTGvUrwkF1D4ZcuOCjwiSZpEZU6Ae1C5IDAvrWgp2L9719XTFioC5sN0N5hipbLW6dgscjQGoMrN7gch2NIH5YOkv15O3Wqg+Sfk9xAI9RYzevsmOYGN8uoo7a5z8O6NEqmWbVsZtZwxk+t5ciS4fypvv1rDaNbAjdxuSeSamnl0pHAYegFlpfZNs/6VnnNn7v9Q5qilSc81xtbFGlcP1ri9TVhrT1TGChLQjTCSLOXEWuUqbtKC4tddYaQczy50AL3HmXckOlmN9ygs1knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiyXID3pMRS0zzPU2HVLSZoz7tYUrMLZRLHbkEN5Gok=;
 b=y+wcPvCRfGl5pf2rITc/asyu3Pe9CQil33zw2fzxyIjgKIKtlHSIBLQ2onIXUIx4UAuZzRAAdJl4Xo5yYk67vHpYuksROe2f2TyG8sFBc5qRpl60lh7z1f5oXbA9kdDQOAPO/dpVmsbgYsJgDXNNmXG7d1FUo7jWXhqq0rb4/w4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.27; Thu, 20 Jul
 2023 09:04:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:04:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID flag
Date:   Thu, 20 Jul 2023 17:03:57 +0800
Message-Id: <30c59990140b572b0336effd2ae1902c7e07ffa8.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689841911.git.anand.jain@oracle.com>
References: <cover.1689841911.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 982afacb-d1d9-47cd-67be-08db89004dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSmDougWMLGMKx//T1SSQ6YbYb0oxeadzYpuO4ScyOEkewUtBfUOB9hvuxL7RoxNgxnR5AhA2OkxvcrXaakkL+FGoB0lyEom1xqB19KE18wGi3KreGQGMAzHtKBbmkgDrY+lhBG5pzmyozm5oKQ1TPQX2LPzvmO80R9s8vgq33JNQRCyJXPlWlRiDZo34/AgR1Nv7KmcungWp+FPzinYTbMMxY5N8FMtdmMwq9iqNYNA9P5e04kuRDHjA6Vnelz+N6X0DP43gmKPqkr5lX2xml2wuKsSaLm7BxI6OGemUiMr9XQM4hq3VZq5TyJhvYEWTyInxDxRwDAe0sotq4oCDl3r5WJVPwCQmdBSibuvJc4zbBLsavwEiVqHoKE7gKQgUI8G+2+D6/Liob2jyuq9E19ynn7wCSUzDp82+r3DdtC3eXcC26JqpCI8RrV8Fblome8Afzw0nTngPP3dGtweo26ER/Wcst2nwPzhlezak6AKOi47ogCs0DJHS0hqCvU3nEfWhXVaYaorvhJ9EzFDUDldTr+0epAjSsvrrUdFyrPlzwHfxvo11d9vn66iAOHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(6666004)(6916009)(316002)(6486002)(6512007)(26005)(186003)(41300700001)(6506007)(478600001)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(44832011)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svmRsT0hhaKhhTO/3ojRnPjLhtBYZnjwx9w5WFe685JxX1xKTFhc+3A7hrpL?=
 =?us-ascii?Q?AOhC/J53t837XQqZh465G+FH/Md0lvthfEDlE4wBNMdRETypqu6iW7kUdBhP?=
 =?us-ascii?Q?yT+eG2u6CTmEyaxTGKw5IN+rS+cBumJlIYhf5fZ8pvr/p9ounMn3csd1dmmQ?=
 =?us-ascii?Q?yaWSVSPkqNaIgZmwXLeCd4zKsK4yHm9qjWki0wgyq3c5Yyyt2YqSiJp6O7yS?=
 =?us-ascii?Q?wl/4Gx3PR31jk4et6IRM73HX5TxL7pLmqgCywOprYybV0GYxfTq8HccvOrcc?=
 =?us-ascii?Q?XI14TGl6EdCtNTg01thA+zRV0rnDQLK8vc41yUScAnIH5qzj5Ikw7jzTvlGy?=
 =?us-ascii?Q?Z/WHGeknaB+rIKgSSZR3ZAmEXIDejS36faDKslxO5iDpVB8vi+i/AhpdxXb6?=
 =?us-ascii?Q?j67WsmBjHq4Yl6QSq7u11qbHAaPbEin7/EAPlIVevbeMZOqUpWOaXoHXabZw?=
 =?us-ascii?Q?lRPQXVTMUibmms9blNwvm2wA2R7GrM7tvaS83A5MX6j6OJRfeH2dbBesfwg0?=
 =?us-ascii?Q?sBimbeq9eWLu3QnJ+EXMTVsAp6L80nO4Qs8wREiN8GGNlyFelYPghHHECVtm?=
 =?us-ascii?Q?ByJVhX62TjFSRWWFc9XxO6IPlDwA7P2XFPrc3liHDvWFwVlyWKrdvRwv81Tu?=
 =?us-ascii?Q?zkgPLjitjvNpldQJa/S+YZh6Qvi72FipYmih5suzfPk7C9ZptsjuKlNiclgb?=
 =?us-ascii?Q?K3PoB6/zxMqIk7PlVIpIxqhYUuHW6OuJoSEUKo6dKOxv29XbyvI2kWW+dQcx?=
 =?us-ascii?Q?Ni+VtfsRlQvs4YZPiZoIMDDDC7cpNU45f4hcSniObNJ4B4c8TWwrYXDaaU6l?=
 =?us-ascii?Q?6FMU41Il+4t3TQ9U/bPJxTXzdRDZBkbp+onKr8tXpulBP7mydZng13r3Nm+8?=
 =?us-ascii?Q?WGaOEjAhnMpIu6b7vScm2sUK0z1v9fbKdTTK4HsQY6jA5XmpXURUavrDo5Rt?=
 =?us-ascii?Q?nUQmOJv6YpWh6TmngQoWxAERfbag1SO6uoETeMxbbZUSIcUGIl8wKkM06XSK?=
 =?us-ascii?Q?EDLvU2G4hI/KAryeEB61zQaZ+u2ZggQQF2EOP41Oww926yczhvnrgQCdJ4YZ?=
 =?us-ascii?Q?xzzHjOugNHWkKXID4OfJJaBWxYCsl5YOGGd6crhkogq5BO6iamxy2PbZ4yXX?=
 =?us-ascii?Q?s5//uHFOWq2ye9Pe38v3IAejt/Jprcm9JQGosv9+4AyQa9F74s47mrp/t8HI?=
 =?us-ascii?Q?9VsY551P49xH/gQM1G7L7VJjzFYnmUZmdA48alJpediGjbiIB5zmBgJSJ3Zj?=
 =?us-ascii?Q?ONYgMMxm8ZrtRCOk+D3F9Eh20ync8l0ulmU7adL94rCPli5klxs7UwHT4Mr/?=
 =?us-ascii?Q?w5nnW3o2cwLV5KtsxQp//XH4Wq54sutFyrW/2Vk6SDc+QOgW1/F4+z3Qm4WG?=
 =?us-ascii?Q?JmEEAWZ12CAEnVTWHGEwjBjE+PD5JqwEzOVv77Jii48t5VmEPHHwRqgmRAnt?=
 =?us-ascii?Q?mJB2uVSwmKlzjNFo3XtcmJywBaBa0axQfbBkHv/q7cBihsC/V5YXp4543ru6?=
 =?us-ascii?Q?bESYrCZPLS8P7QxiC1G/GEZqEz0gP1cQx+YTeoJQcKVIaegjYYO+NrBz0F6O?=
 =?us-ascii?Q?xYQkZc/hIYfpPm4B7CtIGUFHcg0HgZ4C/hsU9igW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tkWWi9ITCPg0wGkIwhyS8cwgqs2NqYENm9jsXarib15Sufso/TV4Imfwas3lLpV7ztDgCD0919PfDhlxpn6U9IgABq72unAAU+l0UedzAusQe/tbT+jh+aAucKevgOibr6NoPthFPU5sBKndGMPgUT5BAfZfMucbpx+ZssAndQGCYMgZkz63DKRzQqcZbi7yyzrdcbdpkT6YoMhJCZrSBZKsBcW4fN9z0vIgZ/4qC5wbL6+IsjiaYbhqazn6Z9C8kiJt2L3VLIvsMWGRPLbIBU087V96aSIEX/GFZAfbDpOHmVZnvYSmWytJ6l3HXqwvaE91GKvTVwksQdj+GaAkZ2Z4U06omyTA5Gp1TyMpphZQ75Gf8lYiHdmmWhzgdByYjw3NEPhqr43ZtuKLDlpOeqYEwV/VSOVG8rqGO3B1X9bC/02FPo7EEQPGF/2ir4bNxeQtJ7fG5nQff9HEizGIvnrXvN4Ag7ikqI2a9tgC3xrUNeBgJvRDZCeTdx1mN842v2nBZ1Woyjenz7cWmLSp8VigXe6Gn9geTae/58oTYng899bzymviZKydw9CzCL0ekGaX6S4yF6HTU/9yHPi//Oomy7KGz7NRNOLG+q/q8T3/QV77ORd2/gEOF9DO/VChngsy55X+YLd0CcK8/yvPB0M0O570wEjbcx8rdkjXJ7uQW+omqLiUKahnVf+UyuMjR6iKTAUTIg3GX/jNunJzu2mHS4nTus/Pb3Mez9KqnR8+5g2kkAUog4iG8im2ABvCWa/QkVSwEAGiefqXxFvfZw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982afacb-d1d9-47cd-67be-08db89004dcf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:04:20.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyJR37eE3AQ4wZDr6dk0yVHJoCbIC97SBUZ0w6ks5kE6oplFYWJWEooVDiwG+tcnnYxTko1gGDtEZgYJgG00OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200075
X-Proofpoint-GUID: -ebLY8OVxlEahlr_lxGTDaPW2dJ4VH6t
X-Proofpoint-ORIG-GUID: -ebLY8OVxlEahlr_lxGTDaPW2dJ4VH6t
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit
  btrfs-progs: dump-super print actual metadata_uuid value

fixed the value of the super_block::metadata_uuid to be printed as it
is, without tweaking it depending on the METADATA_UUID flag.

Apply similar counter tweak in the common helper functions used to read
the metadata_uuid so that test-cases still be successful.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 77a310d54f0f..dba31db90368 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -15,6 +15,19 @@ if [ ! -f /sys/fs/btrfs/features/metadata_uuid ] ; then
 	_not_run "METADATA_UUID feature not supported"
 fi
 
+has_metadata_uuid_flag() {
+	local dev="$1"
+
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+		dump-super "$dev" | egrep -q METADATA_UUID
+
+	if [ $? -eq 0 ]; then
+		echo true
+	else
+		echo false
+	fi
+}
+
 read_fsid() {
 	local dev="$1"
 
@@ -24,9 +37,14 @@ read_fsid() {
 
 read_metadata_uuid() {
 	local dev="$1"
-
-	echo $(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
-		dump-super "$dev" | awk '/metadata_uuid/ {print $2}')
+	local flag=$(has_metadata_uuid_flag $dev)
+
+	if [ "$flag" == "true" ]; then
+		echo $(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+			dump-super "$dev" | awk '/metadata_uuid/ {print $2}')
+	else
+		read_fsid $dev
+	fi
 }
 
 check_btrfstune() {
-- 
2.39.3

