Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23EF77BD11
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHNPam (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjHNPaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:30:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE410D1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:30:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiLT5019893
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=tYyhi+h52Tq4bpgrknJu3UfD+TszSWwufFbKa6vUTIY=;
 b=iBGE+ajZNjNN6KqpAUQF62pTORD1kxv+iKopVZ6wnh6gfYDDtQ80SPdyyMRS8rKFIz+y
 zmcLMVfPOE7j2qMn2IJKorHAzOsJlXE+RbCGv1VGYbzzjtoBjbfDNwWcwhKUWyX9rp8l
 BDqnvNm2KLzjJ1qJSGDa4Qnnga+dQpdu2zGsYWfE88T+9BOp0hBExZ8JTTHs3CiOU0K+
 7XxRWOr4LkTQlwG3kWI0uUk5RmXDgnJWbOO510zrZHO7uHsQDbrCv1XE2q/x0aJsrLPg
 fFzyQrfGo6S50GuRIyQClbXbeI2HNFQwSRjSdqkFlKbLV2Pmbi3D6UgAWWG2G5vgKYvm ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30stvud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EExgv9019785
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3ua0x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YADHSsK9Z3l3K7FLkoc9pUty06XjquSACDq71XpnTwUluVv5nNyQ3yRa+O0tSSIe314nwSFSqT8+eyKxsov1dYp+RI/VzteTW/UjmDWjqno5Jq3UaxDxiiK/uAuE9eEOEJonwbO7bBsgLY9OC8CeiEx04w2QLuZza3tJburnYRcxQq+BySfoUkWHVI/TGNCeRtCdmQmwHF0Obe+Xw9jwncmPaaJ5aIHEOV8sk+3Xwt69tg8UTzs8Z8EO2Oeo86IdHapvSUN4Lu41P6aA4Zb67eDOKaWLPZlz2bHUzf4KdDMHWZieywJViJ4Pxre/oFWOsc4lW0ffV1MnPyRYE7xGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYyhi+h52Tq4bpgrknJu3UfD+TszSWwufFbKa6vUTIY=;
 b=k0LC8dyR/bxhTryp0cBufRsMzyUfcEkTA9+dgL5DO/SEEzxPov1L8YFzvRvLME5QQzyrn3h62wYGWPYyc7W5En1fOnsXWu3eR9FWo3Z/dyOCKoPtoXKaahYDtpQ0smwkn+01G/xrLxtWP51LZdxDaACU6iVJbQvOnJHNgzcOLYnnN6ZOmX3zHiX8IFdgs3fxzNZT2DXzeX1ZgiA8e8jw8MVglL8m622UNh1ODXKtELRXnSoGLo6tYZ2HhTi6qZaFt+GU/b4o0ca7oKempAt9f4KyV/ZakloG3cmirawUa4t4b70Yf+2yBxXIPlAEBpNCxfyorq2u109b6GjRM7t3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYyhi+h52Tq4bpgrknJu3UfD+TszSWwufFbKa6vUTIY=;
 b=Taf8/lRZ2jEZjmhgnQUQW4+OdDt+LRN6cpowpmTRyxzmJ0Y+qt83JQI6sVjurR2Dq6B1kJyFKKXZ8JR4ByiJAjx5CWY84fv5doK7H4wH44z5T7/u+0JW8S58AZm20IFEcul4RZJUdNS2xhdXjhS+zaD7xvYkRCA3pbsmc4HTidk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:30:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:30:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs-progs: test btrfstune -m|M ability to fix previous failures
Date:   Mon, 14 Aug 2023 23:28:12 +0800
Message-Id: <af8ae1adbb827a1de806af25a63622b19d6765de.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2fcbec-ffe6-4177-64e5-08db9cdb5b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymLlrN2aaBhdOT/Kvkqi24CsKs/x1kS0HtNLib/CXHIuY9j/xxARMNBRjSb0NAXT9wv7i/v/RxNKrPpN8d/pma46wn/M4ZcsXLwzAO6qnNwEr8S6saw52eTyXio5ucCFUbWcxbj0iIy9/pk36BzPxk6izHerv8KwTWunX4UnxHpIMgx2tqkG+p1iq/2n/51sj+WTOwFVZT5bCDNOVHGGFaLhLGZbjhzm7d1hgX0B/IoDUBDovA+J58sCDTH4RQUBIui+1/xv2mvveFsNipVm+ErxjLfmLEP8GmCL3JoysH8VrYfkfVSUPIj9fifqTDS+hRwXwQQOcjVTEsIKpHrqngSLDQXraZ9VwMGR7vwpaZFICJez3BFPipeBCW78KzIVG/qyFhzktQYc0M0nWd2pooXq0XRRq+2OPFBnqMV9HJy3MeSPYc2WyFrsbCJSmxLCgFWbzDJbbPUjX4DvNbnaAugWdgH0Ar1IMTMww/22evrNC5MjnHhK0UlWfBkUd6KSeltNaKxijX71v7VS1p/V5nrNa88b0I7aYeer6+SJg+w6CMVhn671zCDfqE7i3OwN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(186006)(1800799006)(6486002)(6506007)(6512007)(36756003)(38100700002)(86362001)(83380400001)(2616005)(26005)(2906002)(478600001)(44832011)(5660300002)(66476007)(66946007)(8676002)(8936002)(41300700001)(66556008)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsUSPOrCpIcfus4IYfA0BJ/pZE3onoVjhXtMHrmPFfXI/U9ueDs9Qj0+TVcR?=
 =?us-ascii?Q?tWIhNxx7FQwXjZer0EGXmJB7ZcOrEoMFdPkqyG0Y6o2e7L9u2N6v8Ibpo0/R?=
 =?us-ascii?Q?Dwvg04NktI4BTRe6Og5OHu7RI9WINraL0Q0vFq+ZSf5GPHXFLFXLXydLAKGp?=
 =?us-ascii?Q?sMTTO8Hhu8X5048GEwySWerLWdfn45rFwoxrv/nhVWvxrZ5hYdElw5r+Xf8p?=
 =?us-ascii?Q?jFOOk4XH7DxV6NYhWqwXgS10ZCHwHHwjDtr3S31ON4GE+b18ls7D1jOvRfs2?=
 =?us-ascii?Q?hnTOcRwSjB8XWzdvkhVsw9s0XbQE6XXPqbZag0W8eKk2FTK41FP1UYmaiFMg?=
 =?us-ascii?Q?vwACuzoMArz7cjhbpgDZYOxLcr7FMsg9NJW7dGzNCAKx0xmmb8BrmjsJwfFI?=
 =?us-ascii?Q?7qLf/d2fQy3d2OHlPwtFMj4JLK9OEi8B7jtephQ0ba5U3OZoXd+QH6CCaC/0?=
 =?us-ascii?Q?NFt8acytdji2ycxJMbUo6iTYY8YY7DXKKXXb8hnNaTyRENIlpk6ybdSUJrg6?=
 =?us-ascii?Q?pDes2EYAXcX4dMep4rQ05cCEw830YoVlYI7ZJm/qSoeArTRG1pYBKmCBBLbv?=
 =?us-ascii?Q?xFiUDSUHwCgiJ/TG7Zcmd6IuoG2s6901U92BTKTAh6d7U9a9f+/J/YMCfdXy?=
 =?us-ascii?Q?85wal4DenJCrBAPPPjAbz/RK9ok2oAaHAwUHRbbW087Wtw9CAk8eV1CEv6Le?=
 =?us-ascii?Q?xW3ASK8FCoKUP9v+X4zE8hpYuJOCOiLZAL4Uq5uQb5lF1Gj9QCQG4it95wQD?=
 =?us-ascii?Q?ZBSuZ+KaJI93x8GYtPXXCcGen7Daoa+VyqmzWEMTkiuQVFBNQqqkaOpSHPfy?=
 =?us-ascii?Q?OlkdmPOeUHj5sbIoIxpmnHa+rOK9gauoiSaAFNGMaUsT/YZ0bcetbna8nnYa?=
 =?us-ascii?Q?lyJ6ss9gfjhhFg7zyTO8VxeEjzI+Hewf6oFc47IHI3zZOH5YtsRBS92rT6w6?=
 =?us-ascii?Q?cnIAkg154/xTtUxL8kbeLWW6FD8O+0SqBYjzthWagWorUn/pKkiPKbO5u0Tb?=
 =?us-ascii?Q?up68BzgmtGvwHFFpX3lY5ZClhjuKlQQEIrBYxCevTSfsTXGhg8dCwFQ7zlk0?=
 =?us-ascii?Q?5dIqk1iQTQqun4HWcJ5wAzxsRNFolOr7Y27wkcK6LMRsG5QDJzg7a341vUYW?=
 =?us-ascii?Q?QSZ5S+93+ugHllsUjcrffGXsLxsjqu3VfVy0ecASmGkN3AcTZwz+ofMqd8BL?=
 =?us-ascii?Q?AIy3BlLw54VYH12aAAtUZnkyr/DZKYKAEYY9jtVwtjNOmdK4rGCK6oNAgzDD?=
 =?us-ascii?Q?SBoDZOZF9Cbhfp6cKSluLmD0z53FA7e7jyNvI9HWUn08DRbQYhfrQDVsjDig?=
 =?us-ascii?Q?Vcg0XkvH2oK1qgmoTPMhpQRXMbK75s1Ud6K0YxoYaimXrFYWq9DBEmoS1mPp?=
 =?us-ascii?Q?h88Xr+mdg9otZM/aEY3UVW3mxkKBZTgEa5d2grQ73bNmYZoaT8OpA2EDS5KQ?=
 =?us-ascii?Q?AGCMfWfVjrsf6qcZrinmV/eCOKNpPv2oMhug1sHLAtB6Mpjt0xNUM9CRKAa9?=
 =?us-ascii?Q?CU9Twh2KsqRRKHvdZBTs5UpP8O4alv7jbxB5/g9QN2S1jhMsDwpCOwbfkKED?=
 =?us-ascii?Q?nKCP8muMZIwX5AFLhiUyeArVZ7jvLmwJRIdfKfTHsRf3/U1MwaVZFcdQQTKq?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bTdpfBVUIPrxALDiH2pMskg8rmDxUJuenNdfFfRZkMZ/3O+dBwxq1wdmUjfEAgu2SDzNfGFPMxRJWo08ApWNY6mW06FwzTEg/Qrx/IZzgSFrFc/8eH+ac0VU1ACwQcGvpBDVW561NqCAXHAmy4mfSINz4NEkM/tfmspcxyy7EQMD4K4ksKzgwrTlR8qGCIfNKubZjvutdOqurZqBqXeye/bdMsSYCk2Qp6B9/1+rZIWBlqZxcN3GK8sMJP7sqHL4fll39NUozLF0Jdd5L7hQMSu1TtF+5Vt6EHpz4Zr9bwq+0XVTfsExmES9SqoLNXtyTXcADB4U0s37GTyGCFHLg65V6qPOVHTiRAy5v8rEkgiozgxzVs0jLUnO0quuBhuH2hmCVK3GjoZS2kwsqQtGpXpisYynURSBKj1GsSY1mx/ipByGHP580pETMC8HYwkbCs/Rm+Yv/xmkCe7CK3AQnjqrg/Tdwivmc/SEFCfPOXZUM4dVma3Q+qTaVdC68OrOvfVgxMPQNezAyTq2MC8R5wm4KgtIk4kJtKpIOaYdkqMPaNVy9YfGDqgqROvcIBWltjs6oTT5Ec/Me7UihIQCNRgio4HzKtXZgs8JEL10Bo5uRXgcshuy8CQp7IhTOfhYJvNirXqO8FiBF8uZao+Z03j8m45DSPQ/7mjyRUQ99V/DhGZ8mxfAUhfCEAQAVHJrNOSbtn4oyWF/rJq7dpUn2DRpvphX04QGO90R15Lu03tu5gb43cl2V06qo5ZlwOSNqznYMQfJQis98142HSkvEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2fcbec-ffe6-4177-64e5-08db9cdb5b0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:30:14.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2AMxLVbuHX4cmLdIkipo20ODRfkNnpsCFfzIuia3YqVRGwP8GdrBVKHapgNMhq+ldvmKQQZd9jMXgyEJX3ycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: VKidIuyVJHlJhmYo950JagggGzQNuu3Y
X-Proofpoint-ORIG-GUID: VKidIuyVJHlJhmYo950JagggGzQNuu3Y
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
index f2daa76304de..6aa1cdcb47ae 100755
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
2.39.3

