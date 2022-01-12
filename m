Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075CF48BE06
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 06:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiALFGc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 00:06:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbiALFGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 00:06:31 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C3QJT6025152;
        Wed, 12 Jan 2022 05:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Lyz4cEdv3fDDizsTz9PQNvW/gz4MRnGX7wQxH64OtIc=;
 b=xU+76E3oqcINrEqUgpie+brR1uXHUbS+NoUe/GZXKSn3oROsgvrkIm1i4Rn5Rnna5jlR
 xosnquwQ0jxEnt6vDZ0eMvCzLr87UOjP+pDQK80ay4tZwUOsEdgKg4u7HQaECeKdocDN
 /wVEU/RG7BEaY5Mx4wNLR/fJE7uGFaOSvI09Ow3aDNqIpjet+01KNoi4WVXCMEZrnwj/
 zlO0RAU+n2CARMMC/jm/Wl48JFtAJjMUk5jypgnylwggzqKBzSa8RL2j5Hmra7CG8Eju
 cUYhLGYFjFHXeaFBOkJGa0SNGZ2EQNCKfxg8IxchbR98Mqp6uSFViDR65n1DxG21ZIk1 ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9d4gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C50UXe155907;
        Wed, 12 Jan 2022 05:06:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 3df0neyngc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buiFPn5dcLyKoGHr7kxd7JYrNAw6IA8/d4pkuYMN9ZnnogF0ZaTkwVcElEgSCoy3zhoR83qJS0EsgBDXEzMPGiceoaRz+H00dI+nZZRWubqD1+kCWcaK+rCOedZr1iLsqoIEr3Y/E7OwBMuZDO7UtvC5c/kCwW5XEfg8RlSSeIGf9EbBIR29mV5naRNmvclUG+5/elgDTbNR8Qu1S+64V801M6tCzavudrxfl5W1FGAh3L66YLF2By2TU8NchwIaTQ5z7+eirV3Bh/Xaf09uP8BGQi5bVPp5EADXXNPGpvxMHpY+vdmZeEwiuVDxv4NH5qIjvQ23DKDA7PSpyqi7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyz4cEdv3fDDizsTz9PQNvW/gz4MRnGX7wQxH64OtIc=;
 b=DWKZ0NKfZUhWAIOWFMGp5neF0sOv4r5cT7bOZopt8baInNJ2+yDUQ/VmHb6T76s1EZ9N6w+bM8rArgGkPlYInzlLpjKwzG1YVssBlAnCDHblD8GLhKExzQ5ADRAU/kSmCcYyuVAZYjoIKL4coBeltVVNwwKu6S780l00JZDX/RpM43EltHi0nCP0ubyT64sHpszwu1x8XVW2krclSaN5IDrdRaxfWiDl4JW1P2PDHw+Pn0qGkvM0pJn2Og/5HN8zwcigWnk5dLMA5Elr7MW/SypJbAcMnOPClmRNORTwEwJzTTVMuCMCL+jVJ3T3gTpYZeVJsWkrmw21cjJAqTWCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyz4cEdv3fDDizsTz9PQNvW/gz4MRnGX7wQxH64OtIc=;
 b=GSv2QuqLWu/G3gQTszg/s8CNCK5fLLE3egWUKj1HA9PurBYsd+kyKZpHfpZq6itEi7ezuw1E6zYMYL7Tsm3kin1fhu46TbXxeuRuAdenv7vfiGoByeJ1TIWiW2hGQvTWDwQnH/7SChJC0Mzu9ZjpGly2W0z2zutMvZxM8XYQZl4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3904.namprd10.prod.outlook.com (2603:10b6:208:1bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:06:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 05:06:21 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su, kreijack@libero.it
Subject: [PATCH v5 1/4] btrfs: harden identification of the stale device
Date:   Wed, 12 Jan 2022 13:05:59 +0800
Message-Id: <eefb5053c2c7c312210f705cba0347fa8b1768bc.1641963296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
References: <cover.1641963296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498c77e8-d7d3-4220-ff4f-08d9d5894611
X-MS-TrafficTypeDiagnostic: MN2PR10MB3904:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB390419A2E508E30149C81BD7E5529@MN2PR10MB3904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjI3Qlh3CmNfWZbI9E1vX6kf4cNFjcxrCr6OdSDWs9Cccivc/oLxhGqDd1ZIycMlvTvrVvMagabaPozPsAAdGs2P+jIvmhTmq1R3QDwYhWqLDKUgK0EQoTQjQ3VW8fI4aqYgEOiF5Uqn8AaE/DNHrclYRdWCxp75CnWx71m5ntXkSbE/AT+yHgMrypciDw4+J97cEb6iHkB3WqPb5eQcqRgu0TMFyqkwxGkDpteoFfL0wfPzrGQmd/3jSpEGuB8BkTfuhNpTziBvfQWIl7mwFiD+v/6SoZBkC3f1301VfJaMf2X9wQQ75RYTsXji2kYh6eL4rdywsmfA/rmoBSYA5489MiU0n7WI8yqVqDyuu8MevCFxJvPCsWgT4zD9WpNm0r90puLqIDqXrDTSCDi2RFVFfo/2EjWm4VZ4LSRyEQepfkBNbhRFAQ3vzxBFL+J47TG6LXKXHA2QaA5MLi1l8XapwlR5c9yv+1YOmew3EMJ8Z1Wl7HZrdJ/HTq1VPZV05FgMIQjCuLHTC0oOlY94wYYoFjmDDemt6gZE0K9Bv3deXlIkFMAWbk3vFmL9Yc4UI5gwHZtEg6sP1HO6vU7SBMW6ZKKgmv6RwVkjOvXC90UooPmYh9r9e/hN3+KreXcoB6QHQ59AB7BRQRy3VimQQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(44832011)(86362001)(83380400001)(36756003)(6506007)(5660300002)(508600001)(4326008)(6916009)(8676002)(316002)(6666004)(2616005)(6486002)(66556008)(66476007)(186003)(6512007)(8936002)(2906002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjQCoE6PND6HtrbNQUtVvvKS6IQbA9XTtIz4QOvdjH3ns9+aZB1PYpD+K1Zr?=
 =?us-ascii?Q?cupt57dNh0bt2ISvdX5peyR5AXrBND5B3kcw6aWKMx/9283SQxA2QxPDu+nh?=
 =?us-ascii?Q?gXxsLaiHR0MbSrLOw2qbpe2Fy8TMJ11gX2p5yXuB5ZNNGPEfP0mLrKvC5gx4?=
 =?us-ascii?Q?gYwO6m+gFzFX/JZ0LYzsSOpiF6M/gHfJPX7OqfBgeHKFQN0UlthRNLZWnTl+?=
 =?us-ascii?Q?duJbjZR0P5MdtuiBWKhXECq5PuWjwu/sRrCc/My1JfndpG345trvHxy/UxDj?=
 =?us-ascii?Q?s8krRgUaBonVn6u6JQLPZJmpq4u2vme4dCwSRvHGHulP+JI1K1NeMxmemup+?=
 =?us-ascii?Q?2WGuMMliUya+DdShp8wu5NORZ1mEkI2nGx2D65WCUEVawAYG7JHUiZpJx/Qi?=
 =?us-ascii?Q?CG18i+oB5RGkbyGCYhCGDO53B3zewl6e1t1mUi9NSN+xrBDm/8996vVrpmiK?=
 =?us-ascii?Q?IYrSIGbO/3HfHpFbY4eIL1e9nbJeXyutk/RbQf22geJWKlsKNE66Y9JApMjP?=
 =?us-ascii?Q?WO3bHxmiWDRgjii4a4q8ZPKtfjStD3Uo7M+LjSYEaVgYJBAsGEZTwjn3S3eV?=
 =?us-ascii?Q?3phrKyX6k0nOm0vWpKLSwQLweqz2UJyoH3OfDyb0AN272G9Gdde5qef0MNBa?=
 =?us-ascii?Q?ix9JNkB8m2HjhMHAZqt2NxEpv9+VHbZ4z+fBIYDODUD7nDqAiYTkdF8M9qx9?=
 =?us-ascii?Q?G2/Ixlr/+kp0LsAluNy5eDAKU126QY9Uz0Xu4rpGcnpug+w965rO3EodBd+v?=
 =?us-ascii?Q?/ke6uFML4y0WETqnsyWvlq6A3wMESujnkplr5En5ONijPCVWamyJ0nfYFJrM?=
 =?us-ascii?Q?d+WM/gePx9kHDEkfrapwSv7Bq50dh7qbMgaiKdGjBNuMk8cZQ2K9Ik8Nc0ri?=
 =?us-ascii?Q?Dq/luiR9W3fOlvK89DGV6YE8LBYHZieGAOg9nN1URusbc261oO0j92psXiNx?=
 =?us-ascii?Q?F4se4ynHqFnlMKHXfcCVx51cCZ4pMyr8mlaA2papvFM0bdM5SoiI5ZMyv6Vs?=
 =?us-ascii?Q?8WdKDJ1SsPjySiPr4QIFUqJRoPpnE0+t7tt4xuFy2LbeAY+woNIobTepa/i1?=
 =?us-ascii?Q?oTUSTgd0wrNwv3An4BXSoypGZZZff7JuNA9finjsLHGpmSCrDE3ZEQi9XoBs?=
 =?us-ascii?Q?UZ1thK2YMCCtdRal95Zn6ibiE8hKkYokGAns+h2U2RrYUO4ghhZmPeC5qJTM?=
 =?us-ascii?Q?htjCgJUq4OkRiHHbGzKaUoIMQCXwOkuatjFvwl8B8nJbwlUY0CnXzaCQUyhd?=
 =?us-ascii?Q?RSXb3l5yXSkz2+mCbyxaoGkneh+vHeGcNf67Ps8Ao4Tu/Gw1//YYu3E/+Zts?=
 =?us-ascii?Q?jvcetfUXczLwokbR7RH98MxaOyfYu71z8b2JkieF1tFLNEdtW/yXiLyrceYB?=
 =?us-ascii?Q?mXetJlQra4y9XuT4R2uk1TpjRMgOuN4TYRZXn6aAEn+orXN0IcKg17Aln4Ys?=
 =?us-ascii?Q?UMN1cQfedzo7j64KUjVGUQCdVOoAlvfmV92zCjE6SbCeSNBttgyGUCnw6nC6?=
 =?us-ascii?Q?YJBaK2i7WdT/CR0sZXHOjh+fGfrHChlMuRkDyxx7ylGEmX2MnwFdV+v5w+Pm?=
 =?us-ascii?Q?/QNwM4rh5zWb67rzhoOPveKDdkLsN37aiyHm/yd2+uW5koSDT59CpyDSsTjz?=
 =?us-ascii?Q?xhNgQD/lDAjzTNKj80H/Fo0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498c77e8-d7d3-4220-ff4f-08d9d5894611
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:06:21.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqT+2dDthCjjXxYNalZ6inklRvqMgwdgA2JD48YmujexI8HeFzRcNrm4FP3wp6TkrGQpGOrYz2axq5CghsW5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120028
X-Proofpoint-GUID: gG2dcO5U5wSvRlWoNz9OWuY9G1dAZrNa
X-Proofpoint-ORIG-GUID: gG2dcO5U5wSvRlWoNz9OWuY9G1dAZrNa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Identifying and removing the stale device from the fs_uuids list is done
by the function btrfs_free_stale_devices().
btrfs_free_stale_devices() in turn depends on the function
device_path_matched() to check if the device repeats in more than one
btrfs_device structure.

The matching of the device happens by its path, the device path. However,
when dm mapper is in use, the dm device paths are nothing but a link to
the actual block device, which leads to the device_path_matched() failing
to match.

Fix this by matching the dev_t as provided by lookup_bdev() instead of
plain strcmp() the device paths.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5: device_matched() now returns bool. On error return false.
    Add comments. Move the if(!device->name) to device_matched().
v4: Return 1 for device matched in device_matched()
    Use scnprintf() instead of sprintf() in device_matched()
v3: -
v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.
 fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b244acd0cfa..775d0cba2b9b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,15 +535,49 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-static bool device_path_matched(const char *path, struct btrfs_device *device)
+/*
+ * Check if the device in the 'path' matches with the device in the given
+ * struct btrfs_device '*device'.
+ * Returns:
+ *   true  If it is the same device.
+ *   false If it is not the same device or on error.
+ */
+static bool device_matched(struct btrfs_device *device, const char *path)
 {
-	int found;
+	char *device_name;
+	dev_t dev_old;
+	dev_t dev_new;
+	int ret;
+
+	/*
+	 * If we are looking for a device with the matching dev_t, then skip
+	 * device without a name (a missing device).
+	 */
+	if (!device->name)
+		return false;
+
+	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
+	if (!device_name)
+		return false;
 
 	rcu_read_lock();
-	found = strcmp(rcu_str_deref(device->name), path);
+	scnprintf(device_name, BTRFS_PATH_NAME_MAX, "%s",
+		  rcu_str_deref(device->name));
 	rcu_read_unlock();
 
-	return found == 0;
+	ret = lookup_bdev(device_name, &dev_old);
+	kfree(device_name);
+	if (ret)
+		return false;
+
+	ret = lookup_bdev(path, &dev_new);
+	if (ret)
+		return false;
+
+	if (dev_old == dev_new)
+		return true;
+
+	return false;
 }
 
 /*
@@ -576,9 +610,7 @@ static int btrfs_free_stale_devices(const char *path,
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
-			if (path && !device->name)
-				continue;
-			if (path && !device_path_matched(path, device))
+			if (path && device_matched(device, path) == false)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

