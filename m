Return-Path: <linux-btrfs+bounces-9-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772637E4FBA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 05:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316ED2814BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 04:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8526FAF;
	Wed,  8 Nov 2023 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rZFlyBm/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="easkZS/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6D6117;
	Wed,  8 Nov 2023 04:29:09 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB3610DA;
	Tue,  7 Nov 2023 20:29:09 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJwYu005557;
	Wed, 8 Nov 2023 04:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=F6QQVyzf/HA7VVRoki0PqpImgvrpBw+EUV7JlYKV0m0=;
 b=rZFlyBm/bxsWVR0Gn/cf80HN1lC6Oo19E09QJI9ulwfppZkYMn/vm2T4wiQH3Ir+LpH0
 kLmsCNzKbAAyv576CkYBPwMnY9V9wGI32+PPJ1aAog5JU/2Yqy+QcpaTzeGyx8vd7stK
 1rMxe2uZHk7hDp/dA8VLbpChkZ+xq9zHzQ/+1NpRShODbXmCjgLwgghJKNoibA22ohza
 1bcSQyjRksYrgj3r4coD+JO8isZHHiGpg92CvBwllud9up7vNFrX5wAPrfDiDG3eGPgr
 2AI7q9F/4fD4REFhIufuS/e3xQWOkoOHpZ/TGO3+yKs4xr3NtqwIlNVcCyWuG36I/wRb fA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23ghpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Nov 2023 04:29:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A840iuH000599;
	Wed, 8 Nov 2023 04:29:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1x547c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Nov 2023 04:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IptZO78YLSgo4YqrrwCtW9QxndmgbKQCduBA0nbaTp+8j71B+Xt6q0aOBXhuuBVUJNlsCUFlKI1ctde+E58J59MDVTLJTRidnQymIzI4x8OlOw6EE9JyKzxVsF9LolVkqdVWOmEcRNnUzhRcIkD34xmn+VolyhQQ0t+Yf7vURZt9J6tVG5E9mY/+APVagDMM6Muu9sWBPlKCuWiTsIShcPe91gwkp1cZiBqmz/DIomcpLGqcwvgSn7R5XEIl9P7nca0bcUq4a6BI6MC0Ugmge6d3V9THSv64QB5nVvpyQHzyEsx5yfTh8s4M/qVr5tj+QlvFEqXQWCC54QO5XhRk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6QQVyzf/HA7VVRoki0PqpImgvrpBw+EUV7JlYKV0m0=;
 b=EbspbrELY2kV2FB82Kn/qFozCxxh4FpXD8n/rm7tyfr3zsr61BjIRvLYhrrxltBuM6vv+46AjpCOW5ASjw0VIM7Chi+0FVJf9XoKV1oDRqnIdjHJNjDggvgTXTHkpzRICwVL6J8qkj5I4peEl7r2HxE9rcA6H9RsEJRAPv03RPb4EWG1hKn9sAKcylILErZnmzxVwy4yPqk6uIZUIq4bhY1qmpzGuMm8t6A3HJSSWOKEtK58PZKpjclLA9TISU7p0PlZkZ0v58M049W3DgK5o5u0tha5fCjsmbiMH3Z7pD4Hwd7MlG/YQ4bE6Nkwun6a+LEUmnbPSufJPboaA6/vOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6QQVyzf/HA7VVRoki0PqpImgvrpBw+EUV7JlYKV0m0=;
 b=easkZS/jWuccPP9oL/UI5rVc39qBlxmOH6ZydPuFdJMwrvvvJPME/mGOGIBKfJmn7MUBvh7cybWTcZW4QXNiONz9Jh3tQlL/I9WYaAnv1FbBA8J7yFZg5ZeoYeUbEDoktZ5f5DpeOHF1/g20wArZLr9OTzrhNhsO8uvBaalQ39k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5155.namprd10.prod.outlook.com (2603:10b6:208:320::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 04:29:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 04:29:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: [PATCH] common/btrfs: add _btrfs_get_fsid() helper
Date: Wed,  8 Nov 2023 12:28:57 +0800
Message-Id: <887706aa6c981aff219b0b2faca614e8ee2323b3.1699417639.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d220a1-5153-4513-0115-08dbe0133bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a/1wXirRXK1AEnZKQLNYPDvabIQvT/zwLjyIY0woyzSFBMZcpU40xHFeT9qq1YSLmRTqgJWTpx5HTfQolNtQuodLxnXZOcl7+SNRT5alpsnupJkcJmJmTle3YlWoUoCn8nzRrCiBLhMgA6rSQPS6h6xEyt2K292DmfHnYcWgZ8gpR0MkNl6FVe+8l73mg+x3H0T1Q97V/1cpkkIOcMJYS3lvKTzO5BB4D6TEvNfwU0tmRSoqz7ma+mk9/8FgolHJTns4G9PTlpemTCn8i5tutbMp1pfX0CGKx8GQjBLS1lt5HUG5d+wRTWfrOw9eLTEwNDVbMwo6CO8nOxa/40kzQ+ZZdU1yeQ6q/08yjjEYjuAmuPkCACFgH2Z3BR5sJzfKxDobPEv8JYs92DmX4/D5SU05CYXz1m+7ZcQ8EkQkUtCN13GCEYL7FzxZ1r8j0uQDDKGF+CgxBn4Mv44VZbEQt1vtFDLu05uAKUbdcWZza+oxPI74cu0ZTrvOZH6vPI5XcU+1Erj4LTAT0tzCrzGVJ+AhkyEd1UcAZoZdf8NB2CafdVUbNDxVO/OXjluxi/8L
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6486002)(66476007)(36756003)(86362001)(38100700002)(83380400001)(6512007)(2616005)(66556008)(66946007)(6506007)(6666004)(26005)(5660300002)(41300700001)(44832011)(6916009)(2906002)(8936002)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WAaYDik07cVj4oMoN6Yyx2+pGpYWuCe9mjT5LdbdAd3n5cKNRFqiW0ooFtEm?=
 =?us-ascii?Q?cZVrHZFq2l/zDw7bNjkoh2AP882u32LxRs5xkA5yaAT3DB3r0l0FmlJZiSmd?=
 =?us-ascii?Q?t4ubA78Mi92SDP6SZQ39R9T6hnEmK3cuGf1crR9Vnf5Q+1uFfWuN2Wdy8f3N?=
 =?us-ascii?Q?UafpcdMNnavyrgoPAM9rnk7WQa6t5/QUqzkvgQD3dU4HckPXZQL1RbGqUHWc?=
 =?us-ascii?Q?IeyTt/e28QfEFWf4MfCCbgSaZqk5r0LChUrJ2tUIiZxe0B5kZyNXgzh+LqN+?=
 =?us-ascii?Q?Pq1pg+unte+GT/5+INJ2A3vyrS1nhyMwaqCuh5tkaSbayAeuWu8W1IBW5K0U?=
 =?us-ascii?Q?ux1HAle1/lA8Eup8DPIBy24kVgLMRPBgRfeFVja5uDnRoyfXXg2vUhnAjgZ4?=
 =?us-ascii?Q?03NEtgSvvy4iXz8cot/QNRxGNVk/lDEqtySAeDeJotEky25GLMcij/tc/wIU?=
 =?us-ascii?Q?5j856i3MKrVYx2ifyd8UMwAg/lpSiitDCJJMKx4y0TzDUmsYqn8AL55sytVm?=
 =?us-ascii?Q?30hW1K/82lw/BT+XPV42yJpx3LFhEwfTzPGef3xZue9Bm69z2xEn2JYLU9ya?=
 =?us-ascii?Q?YoU3DkppFVDlPc06uj9UNYR9T+33wm19YAvelYJfCNZoSNlu/4tk4cbRs/D0?=
 =?us-ascii?Q?xeCC/MFzjv+DtQUzW2An3YAXZunZgD8nzVIMKzmZwoNBI6sSfjTUvdSIH6A0?=
 =?us-ascii?Q?B8G/Aqkt8BPmv2IPaPu+lxV0n5RMnByMyAxfPKtix1xXmGyM90XZDKfA/ggN?=
 =?us-ascii?Q?9DjqujmmOkC3L9YzWinqbxtLRxGUDAxTAFVROvNoBocTGvMjm04jSgZfjx8T?=
 =?us-ascii?Q?7cv4tzyUwf9YL5YPsCvQrE8KQrptbu8P3vOOjnBcX6F4E2NSbVS0gDM+eYqJ?=
 =?us-ascii?Q?gq4xJ5/jxfKVIVHPkdzvUIZmI0yfQs57oJO4gmiSPmU5Flyhefz0aMMOfFuf?=
 =?us-ascii?Q?MC82dr1mNFctNgkPgRrh2Im/SNd0y1Hu4kr168tgRmwIghYQGZ0+ON1SpReW?=
 =?us-ascii?Q?FM1Nxm+mmYoWEygHOKlP8Logqq95QJWA8KZVjNowVOJWllHY2VaaCMXmWsJu?=
 =?us-ascii?Q?micuY26B4lEKWuqlQQNorrfzreNSfYWSCYBhHbW4JaH11t+upv/UcKGgwAlx?=
 =?us-ascii?Q?5HpWrVI7zS8L8Fm45sooYhMAtoiuw1Y/6JAKcOnJF6LYFsWZrLxy5vyW/Cua?=
 =?us-ascii?Q?J8sadf9Q+ow50kQ+P9mEnIgDUG8h7k9qLN1oqo0lOXE7VdoEd82C7P8MBZl7?=
 =?us-ascii?Q?cbp1q+tb3p4DJXQhey5rfothgM/yCQvztPADszk5TwnIGa+39dTZqOHxgWZo?=
 =?us-ascii?Q?Um3cOAfkdA2E/AhwqNeaKmfnmRLAbgOxiMe03UZTaBJt+twp5FQy41447HIS?=
 =?us-ascii?Q?OABJbhYu+hxwLbg+iZs1cG6KNPG0z7ZlqDLwl4kyOFD0mAs6/A2V16Q0t1+m?=
 =?us-ascii?Q?M38cs50bItPO9Bp7kWQoYdhWvFtfj6bMVTS+gtFZOpa4gGyL2FBWAvv01N1n?=
 =?us-ascii?Q?la+WVRiPG4+9alGDM2P3GYNqXkkCAeFl3CnxOiiTtaOLEHjy/6QiYPt1Gi9U?=
 =?us-ascii?Q?9IDO96zLy34NINpgBqpp4yOdPa91fEiRCgFMBjPb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CsNMhpNkq1QqLYfifws3xQOtTuxKV685x1qqWZg/5N4/0nF0l7welenUoR9wjGnca8UGrNEOzVS9Tr7vgREHy04RyFMp9HW86JFERB7HlBtn7JAt4bgWBrXAgyjpo6wmVv+FpFeG6ga7ZY7WC/ZNEHU6kY2GdYt/nllrG1kk9L0C3bmbO0IF4QCLy2t6Zn1shTCS9bXfW2qxTS/OgfD9oYGEsaIAtsEt/WKXWkYmsmko/nJbbIP294C4ODqIXMaBBpjxXW7+BR7Q1MG+dArA8Q5srzk2U3fi0FlfN9q5o2yJvRCf2fnxgR/z6GFg4f3DdshC0jey3bPId8bXG9cUHwTPoSvUxkvDVVcl0RZMEFHr8ou0GiHvlLYBSPy52/rhioUwmQJ/H1Iy51OVlUyxxWBbNk3IMUeAvz53Y8oK906JEWD6ilcXC5KgFnGuWgMJIRtyhUq8hcpI50go4bb/WQdS6w5Mau2B+jBOryo485jIvtDt++JGpHs2UcDqA+fa+w23dyfcUmSAF1/Xa6i6jtl0j8lv1psDoV0Go5m0mVosaYxIQ6tLkz+rWe3Qv+HxMXZeVTrM8zQF/rmMDffdp1RvKVQR5F8YNrh172+Wh8ISrW00MaIQheHWspwACIazFdZQzCQRuHeiGTs/R8+gT7g1Y+9IgBYa/9MvKRjvbZv62eVceLiofc12Ke0AuhbtIxo9ADt6zTBvksqgA2draLbR3TC+eibI65p4dyhcaYlwuiw2FGy1FFa1km3ebFQaQXGTTYYDTbNIDItFla4VQzugBQt3BGarJWR0C3FoCIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d220a1-5153-4513-0115-08dbe0133bf0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:29:02.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzinfg+KPWvV4eYDD1uX5C9X73CyyhB0BpKGIuGr5Py306tFETH0d0epK2LGLn6K+PDD/JLQ5MwJH0yn3VOEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=979 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080035
X-Proofpoint-GUID: 9Z6qZkKeyb34ERfykKdM_IglRfVharA-
X-Proofpoint-ORIG-GUID: 9Z6qZkKeyb34ERfykKdM_IglRfVharA-

We have two instances of reading the btrfs fsid by using the command
'btrfs filesystem show <mnt>' turn this into an easy-to-use helper
function and also use it.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 14 ++++++++++++--
 common/rc    |  5 +----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index fbc26181f7bc..f91f8dd869a1 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -457,13 +457,23 @@ _scratch_btrfs_is_zoned()
 	return 1
 }
 
-_require_btrfs_sysfs_fsid()
+_btrfs_get_fsid()
 {
 	local fsid
+	local mnt=$1
 
-	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
+	fsid=$($BTRFS_UTIL_PROG filesystem show $mnt |grep uuid: |\
 	       $AWK_PROG '{print $NF}')
 
+	echo $fsid
+}
+
+_require_btrfs_sysfs_fsid()
+{
+	local fsid
+
+	fsid=$(_btrfs_get_fsid $TEST_DIR)
+
 	# Check if the kernel has sysfs fsid support.
 	# Following kernel patch adds it:
 	#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
diff --git a/common/rc b/common/rc
index 7f14c19ca89e..b2e06b127321 100644
--- a/common/rc
+++ b/common/rc
@@ -4721,7 +4721,6 @@ _require_statx()
 _fs_sysfs_dname()
 {
 	local dev=$1
-	local fsid
 
 	if [ ! -b "$dev" ]; then
 		_fail "Usage: _fs_sysfs_dname <mounted_device>"
@@ -4729,9 +4728,7 @@ _fs_sysfs_dname()
 
 	case "$FSTYP" in
 	btrfs)
-		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
-							$AWK_PROG '{print $NF}')
-		echo $fsid ;;
+		_btrfs_get_fsid $dev ;;
 	*)
 		_short_dev $dev ;;
 	esac
-- 
2.39.3


