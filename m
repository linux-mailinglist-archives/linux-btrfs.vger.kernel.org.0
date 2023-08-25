Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8539E788BF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjHYOtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjHYOtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:49:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783482125
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:49:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDO0aO009073;
        Fri, 25 Aug 2023 14:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=y78thrKHqKEwx/1GSstmbRTdt9j/CSJv+FxzbOtnjpo=;
 b=Uxb3mkm4ceu1EVserD75nEGvrJTL84u+czUc8CPkLZt/w3tK2EiHamKpuVOFHQdcCaLz
 wWcIRGKyoDQ0sPlwsJ90PEHwOJIQfCwSqwO6LYc4pRaVgK9tOii32WwbyB8Pc73lwnC9
 hjxxwBOs+13DJhk5f9VVSzplrY6wOUBMyw/t3v82a7nwWR4Qpcuhutm6jM9oHVXBRgyo
 KSFuiBlfDwK+G8agT7SoLqmbudIIt27epn9gsj4uAKyNHnzlbQK7fwO6VuboPuqGxrY2
 NsUTpM7uGsBXf1j9VunwF7INJMy+glY3uEpbNcwJ/Var+Tb8GZ9rtqAM7uaDduHp6+qb 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytxgsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PElcgX035966;
        Fri, 25 Aug 2023 14:48:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yqx189-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsYb20thWbywPKXT6qE+RPh7hPn9LkfLSdqtFdxGMGZM/faE1pt+i3HMVbjf4aouy1yF2GQcLJWmRMPQj7d4crEE3n4IR6uf98YlNLOYdpXMKlwzP1AF4aqCjO1QjsNXuXheFBSolgGRfQMIQ73IY+J2LMi/EIh1u0he7RBKh76UABQL2nAjvFZHSDkSXej8nAeX6JZem+RIUqHCJ9E9KZXHPWKlLBPS4v/HIQwbXpqq5K2RSbyZtB3l2vX1lAo+FGIu36Cwk9Gsl4TAgO2vjWKLS9lpn1vovymujDtO78AeZORNiGgML/30iB+8wQViW0Gk3Xf+9OtMo/R6ZrVSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y78thrKHqKEwx/1GSstmbRTdt9j/CSJv+FxzbOtnjpo=;
 b=fLXm3izdqL5iy7zxSWqiafVOsgMebhYeetLENsCCKYl384MzHHe+iA+BXxLMEtzEFcfZPq9UB68C37oOIAeh5KtWd7QeVc+u4eS6Aqj5+phJVcuG+qh41AMHCDy/m3CokmLOZySssdCnBGgbW4bUJOaYuBHDZroCMitj10AvQY28Gufrho+iDk7q76Ko80Eni0bTSvts2UszGyH5ZscyeDoDdcg8mHOGmWHAz8dji4QjxwDVkMmM6n5H/u5fXv151Fm0AWNo97It33uHm4+DgKSh4I7wf05czFfO5moozS+K4HyJ+nAkGP9CRqWrZYhffQXq7Kc3F4JUNx5emjm/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y78thrKHqKEwx/1GSstmbRTdt9j/CSJv+FxzbOtnjpo=;
 b=qGYEx1eD2jR6P8QbI4NwZuvyRUHnXvNG9wYuz1EIaXpGcSydxH1XQ14ew5yupXxnvZmm2nTeFfUJDhQeigmBMOqqAhBvhKEgoCKe86v5AswNIRI88hPZ0BOGdCHd5h1PVDU+6ofXoJ0lc4ssXHkGc/eA5iYcZFBOukjJIAcrwP4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 14:48:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 5/5] btrfs-progs: test btrfstune -m|M ability to fix previous failures
Date:   Fri, 25 Aug 2023 22:47:51 +0800
Message-Id: <c41f12ec18aaeed59cc8d25bd42105727f6d1ec8.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
References: <cover.1692963810.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: bb666239-1683-41bf-c200-08dba57a5d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rRad7SsI2tRoIsEIlh7BNZR7UnJL5gK4mACHunva27vMXVfjaCPjTGbdnlHKRZsYl9CY+AFprovkuFpeUOZFvJxkeUn0Ffgs4NrNwOzyMtAako9sgcifH7H/0rd8IzE+xJrkBTePv+d2qA6uf73zVrYZSKB3UgPgEh5wdwGhsiaEyyur2mu5GxvbvZJbiRfyLzs6Ap4+F4VEmHRfIJz48o0lBFvZtqTTOkwyaA6Pi42tIIJlXjPEUzl+qAlFGkNpGUThjislO9QEAmTm0UDGuOootIwJZXaCr8hdajieFty8jdfZA3TK6BL76Nt7vYLufUhEj3Q07prUyRNdGEM/kCh749KGa1DoYBkFCQBjSgJhskWN0RTdP/G5WFl7gQUabtjH5uJagySk50CaA3lObcx5i7d7L8HG7biDDqf3V8lOoJRZRN+zro5MyfwCDaH3xola5UDcR7ubeQS5dpQFjuao/yVkFG0+VsPomDnv2edA3ER2ZKR+QbcG4ssM1Bmhd0qi4wNQiQnBUDcGDM7zlUggegpKAsDet1xqOSjhmq+/QFzm9amXJPOkeFDq0Y1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(1800799009)(186009)(451199024)(6486002)(6506007)(6666004)(44832011)(36756003)(38100700002)(86362001)(2616005)(83380400001)(2906002)(26005)(6512007)(66556008)(8676002)(66476007)(66946007)(5660300002)(4326008)(8936002)(316002)(41300700001)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CYAgFyKxEGpycXJJYyWzCJXMEMuCG3vTqsFGge6PQrQ7J4BEFRXkXLIsODW?=
 =?us-ascii?Q?70dDszQwNKbhABT08gaeihhz3BLNkfiWSH30wskZdMn6qVCZ5PVh8DhxPNGw?=
 =?us-ascii?Q?0BRbs577W97JMYSnwFheyHLoGxIK0C1uaizOIeLhpNygG8jAVQsRYCmZzOpx?=
 =?us-ascii?Q?vUJEUuhPpFuVIdjzNngH/onI3weHpF1NEuz3XRUPaFVhDS3Jg9KwXm0bmQWl?=
 =?us-ascii?Q?47ngQkyITxuD1ffVPLaTCIsnUXpNN6yviLdX+Ycz4X0J0v9p8S6qqbrZZ8GF?=
 =?us-ascii?Q?khjth/9XjnKqhE6IGUUiInuSsV763MteKs602Gw/pzxkcDzBZSlT0FVKtJKa?=
 =?us-ascii?Q?6S5fs5024fKluLkTY1f9SBowDSVRxnl9W07rwhEeLtAUNapjjkYRbVN4nJtH?=
 =?us-ascii?Q?/ySEj2iOyK3SE/qfDomWn5cOxxmFmUSgJoOB2AZ65o5VwSC5mG0yQBV5jOda?=
 =?us-ascii?Q?WcUu5ifHYiqAy5zTeyBDOaZKuNJFLEIAz41qFpFY8Pdly2GsHIncRVqCzYHb?=
 =?us-ascii?Q?JlyF3QT5qbIy7ECSw2APWzMhtL1tpqYh0MYS/CFGnhyXLpH4yG6JiVdBH15+?=
 =?us-ascii?Q?8hOA+zhXJf/01DxaGcRwUytRtyV140Zsy0zTHwSHv7ln3Q1GoSLdNo+/p447?=
 =?us-ascii?Q?nchREDBQsmP9RfNBYgONXIl76vhTrKJglsTlkYvoOYjlSIW6vjwixbDaW7Xv?=
 =?us-ascii?Q?DsSZB+PdlsB5YRrLs6XUoXPkkcByeBmeV+ajBChGxZvtA+4Ooq1uWw28HkML?=
 =?us-ascii?Q?8PkHTwzzCl0umKoDK03y79pQyEVZkBQ9t82LhBDcqGWtdi3f6nSGFm3jIH/K?=
 =?us-ascii?Q?fw1xCzRRsxwkrRf18mJmjDzM8Q5rnBUzpsouJ+hCRInEuEGGrPT7CL35fFpn?=
 =?us-ascii?Q?2dj9yULwxUoFBdphmSRwph3OrnHAhZhHocG4lmQhretchvbM72yOkeWghr4i?=
 =?us-ascii?Q?+MvJD5fsmrPwijX6lEIyvGzqMlXSi9SZGuIaEvIgFtiZi1+S7T0eiOdpu5AD?=
 =?us-ascii?Q?S9lMEoC5Nzfao6YmLDxziNN68MZ5wMP5jvl4o4mgoPW/P6/VvLCfZXLlQ3ca?=
 =?us-ascii?Q?awOouXhhBKFBRRsY/AeXHx1oji4Ko60vfGSv5IoCeGkaZuUSbIfpjQywIXhv?=
 =?us-ascii?Q?lDI+2RdZx7u8WJBUCDPld6l/BqMfhDfA84rBrWTF1qczPo9aGn8+x3aEJE8a?=
 =?us-ascii?Q?TXNRGPttN6axJxvNblmMPDOB/Tnboe2F0cXtvBFR345Ux4M1JelMbQ7CpvTK?=
 =?us-ascii?Q?BmmcMd2I9nBkFw2uKMo63uUb3n2AvwfMSpC0PCg3h1MhXNC7D2RAjz5xoMwc?=
 =?us-ascii?Q?tC+y/Hru5XB4iMLnhobn58HD+SXpcagYfjZaCbRn+gpcqGwlXCIJzgVCCRqn?=
 =?us-ascii?Q?rW8LDmMpnYqsHsK7kVgBm123j4SEuawzs8Cei3TEGnxxvY5JyoWbi+CtZNED?=
 =?us-ascii?Q?Tawl0ZcVEyOP+xdFd5MEKxvzHzg1kmh+4JcsRSjX4mpSw0ZmgRrV6hjcMujd?=
 =?us-ascii?Q?VSU8aEi7FdWGrqSqJWBsyV61naeT6jf2IV3yfThe/X2LUtOCfIX4+ODJ70p2?=
 =?us-ascii?Q?pGGsFtKUTIbMdJ6AXIbAVoYox9/6rtq5Zs0LyQM4Sw/PblMqS72anlc6SLi7?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MpYRNOmehCForVDr6pAWXsazhh17bAHbG7q123bVmrDgb+ZDNH4lgEW3S2I1mpYNU/JlWB3E+ww4kql1OlbSs6yPy3s9l0Ylwn5Gh2bXmiw8iF9Or+4W4vM9szulu2yHoB5t0EtHKlw8UK6ZFWkJqereccgG7yJMFt05hXzfCiLTVEJeCAOD74edB8ktsQAZs5/e8HH6IIFVePs1sDuinbwrAuiBY6nLNPNWJMuRa2N6baSOOv4RbgEmf3k+g15rI36wQOcuYVyt9qRbfM8frIQIkN4/wW3ghBM+cBLDVIO5O0hK6ODqgq2eJrrdm1bzEGZ7YbZ5ZBE8XEse9NB5oY18IddcfLgJNzbN1LN6jhtCJGosZhWDJDJREiubJHxzWbJtA3ya1NimJ1aqKz6mVPsGPonWmvws39CKYpu5JHafTInoltMpVcrxoHF4ZthzsJ9UPekDT5u17hd3GAEY9aj9Jhdz3WE07LM6c4TJ8e8tDZCAJssAVC5gvY82iyapz8W5nDnQJb3wu5E1odlN1QzhLuWDT5LLa43d3AuQ3eapbFxf+OXXBiiOh/BdZj3yJed9Z3QnD7LPYuUFeCQ25WPeXnuGGYQJckAB8uCDBUpnVKhSdNYkw+tiF+3OR31gB/HCjEbaOzdzI27baLPUscqPiSL7TbZkTWL3mY0F6MhnnKJ+DBQH5lU4eMZqh97IxZMUnaWLajNtLT/Lh63eafa44jKYgKhkeYFWHNZyOLlh6MpsBSqBsdsL3tK3XzMDRpKpz7Lk6ebYxx6eUoZb6bGO6RAOPqfXr8+j0JoF9W8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb666239-1683-41bf-c200-08dba57a5d25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:37.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIdqUpEaPtSQWKr++NFakNqcquPJmj3eOJsruZjwi5EhBpz92vEDEGg5+na5INfgEyOTUXRiSCzzsYetxIKAJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250132
X-Proofpoint-ORIG-GUID: E53w5OO-V5OD6orX1T6LB6SLzrMDeg8Q
X-Proofpoint-GUID: E53w5OO-V5OD6orX1T6LB6SLzrMDeg8Q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The misc-test/034-metadata_uuid test case, has four sets of disk images to
simulate failed writes during btrfstune -m|M operations. As of now, this
tests kernel only. Update the test case to verify btrfstune -m|M's
capacity to recover from the same scenarios.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 70 ++++++++++++++++------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 479c7da7a5b2..0b06f1266f57 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -195,13 +195,42 @@ check_multi_fsid_unchanged() {
 	check_flag_cleared "$1" "$2"
 }
 
-failure_recovery() {
+failure_recovery_progs() {
+	local image1
+	local image2
+	local loop1
+	local loop2
+	local devcount
+
+	image1=$(extract_image "$1")
+	image2=$(extract_image "$2")
+	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
+	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
+
+	run_check $SUDO_HELPER udevadm settle
+
+	# Scan to make sure btrfs detects both devices before trying to mount
+	#run_check "$TOP/btrfstune" -m --noscan --device="$loop1" "$loop2"
+	run_check "$TOP/btrfstune" -m "$loop2"
+
+	# perform any specific check
+	"$3" "$loop1" "$loop2"
+
+	# cleanup
+	run_check $SUDO_HELPER losetup -d "$loop1"
+	run_check $SUDO_HELPER losetup -d "$loop2"
+	rm -f -- "$image1" "$image2"
+}
+
+failure_recovery_kernel() {
 	local image1
 	local image2
 	local loop1
 	local loop2
 	local devcount
 
+	reload_btrfs
+
 	image1=$(extract_image "$1")
 	image2=$(extract_image "$2")
 	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
@@ -226,47 +255,55 @@ failure_recovery() {
 	rm -f -- "$image1" "$image2"
 }
 
+failure_recovery() {
+	failure_recovery_progs $@
+	failure_recovery_kernel $@
+}
+
 reload_btrfs() {
 	run_check $SUDO_HELPER rmmod btrfs
 	run_check $SUDO_HELPER modprobe btrfs
 }
 
-# for full coverage we need btrfs to actually be a module
-modinfo btrfs > /dev/null 2>&1 || _not_run "btrfs must be a module"
-run_mayfail $SUDO_HELPER modprobe -r btrfs || _not_run "btrfs must be unloadable"
-run_mayfail $SUDO_HELPER modprobe btrfs || _not_run "loading btrfs module failed"
+test_progs() {
+	run_check_mkfs_test_dev
+	check_btrfstune
+
+	run_check_mkfs_test_dev
+	check_dump_super_output
 
-run_check_mkfs_test_dev
-check_btrfstune
+	run_check_mkfs_test_dev
+	check_image_restore
+}
+
+check_kernel_reloadable() {
+	# for full coverage we need btrfs to actually be a module
+	modinfo btrfs > /dev/null 2>&1 || _not_run "btrfs must be a module"
+	run_mayfail $SUDO_HELPER modprobe -r btrfs || _not_run "btrfs must be unloadable"
+	run_mayfail $SUDO_HELPER modprobe btrfs || _not_run "loading btrfs module failed"
+}
 
-run_check_mkfs_test_dev
-check_dump_super_output
+check_kernel_reloadable
 
-run_check_mkfs_test_dev
-check_image_restore
+test_progs
 
 # disk1 is an image which has no metadata uuid flags set and disk2 is part of
 # the same fs but has the in-progress flag set. Test that whicever is scanned
 # first will result in consistent filesystem.
 failure_recovery "./disk1.raw.xz" "./disk2.raw.xz" check_inprogress_flag
-reload_btrfs
 failure_recovery "./disk2.raw.xz" "./disk1.raw.xz" check_inprogress_flag
 
 # disk4 contains an image in with the in-progress flag set and disk 3 is part
 # of the same filesystem but has both METADATA_UUID incompat and a new
 # metadata uuid set. So disk 3 must always take precedence
-reload_btrfs
 failure_recovery "./disk3.raw.xz" "./disk4.raw.xz" check_completed
-reload_btrfs
 failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
 
 # disk5 contains an image which has undergone a successful fsid change more
 # than once, disk6 on the other hand is member of the same filesystem but
 # hasn't completed its last change. Thus it has both the FSID_CHANGING flag set
 # and METADATA_UUID flag set.
-reload_btrfs
 failure_recovery "./disk5.raw.xz" "./disk6.raw.xz" check_multi_fsid_change
-reload_btrfs
 failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
 
 # disk7 contains an image which has undergone a successful fsid change once to
@@ -275,5 +312,4 @@ failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
 # during the process change. So disk 7 looks as if it never underwent fsid change
 # and disk 8 has FSID_CHANGING_FLAG and METADATA_UUID but is stale.
 failure_recovery "./disk7.raw.xz" "./disk8.raw.xz" check_multi_fsid_unchanged
-reload_btrfs
 failure_recovery "./disk8.raw.xz" "./disk7.raw.xz" check_multi_fsid_unchanged
-- 
2.31.1

