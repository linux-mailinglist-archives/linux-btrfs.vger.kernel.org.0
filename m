Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47896490BC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 16:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiAQPuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 10:50:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57840 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237375AbiAQPuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 10:50:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HE8Dt0025460
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 15:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5b5a0zmeAA4z2AMUGUMJ++AcgnoBbgAkNLCr49OcnG0=;
 b=YsEInkF2CI9KjOsjJ4jX9ej2TuF/nKq3ITEgbRt/jZkOHwZ76NkyAH6nayLxKR9CyIu7
 LoXg3/X4hOq7az2PXkityMi3RG3CQ5ghi1GNOYeWOoLyugry60OuHWTBlmmEfiE4D0rZ
 q85nqDFAcPcvmvufoVuxalegq9y6AKBpdi8KwohQG0DbR/+AI1oXPHP4psi9YGxjlQPG
 Y3mP/o5BZ4wFiCRMZtjNBTc1X6yQ/wKfa5F61dQnCc1rcnyHP0ZBeI+tc7GgyH8ciDJE
 itLjjXVD+gd5ZsqU/GCu7GXNOgqsj/YMeoCrPR3MYLI/EG7h/5cdHTuFGmjOHGl1URZF 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dkn22urxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 15:50:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20HFnw5J163902
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 15:50:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3dkqqkxubn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 15:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBTUnTLFJBL279LhxZymsdYDMWfKnRwpm+ldcE/ykcMRIb4NxZFvzfQFetIXVGppEfTwI3F7JVbhUkk9cJGI5Ckgr6IZngQnv6laF6FXrScdaTYZcI3KNgXBpK94KKq1q+icbF1bIApvLLxRMFwgH1/bK9dprr7AZGTKUTAgqIhThb45Ci59nmubHZ9rRku/tw360gonY2LYxHcV/WTeOVjS+yL9r2cWlVRrC7PGjDeBhoGU/ZRtA8kWngY/ajSUZiQ6/CCy3m75ZVSx4Oc7rbLFp88fqnzBLZAP3n2gDN2IAdnMnaaVTHTE6raWPRnr9E2abGvJWX0Oa+3cf00nTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b5a0zmeAA4z2AMUGUMJ++AcgnoBbgAkNLCr49OcnG0=;
 b=QRs7/aQjLYdXNr9pUzltTLn0pfdOpSrJWxwSlFMCo+fJGUeYWo+peWCgAtUnxBJhCYOqlBDCR+M5nbi82oK+iz8pRGbE9Qpvjaq+aVNLBN+RLxn14nhNtFq/HSKGC4S6sNLWpzFUvNvPDi3zwxV9I0LzBqIxCcUNke5fk4+Ssz6bBt3Er/DkWJ8dzBPhQlF1cOZzGle4n+5nC7XPY02D67LAP7eWNRWs7uw+iiuEgpArqCK66L6bcg5RZQWMkmbaF4XbZ5LCY62o1OIlrxKZkl3l6IEewnXoKSpg6wcLA7s2OxvEpihWecGR+VfPVFuzVOxoBzKzsyjmjR346bXslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b5a0zmeAA4z2AMUGUMJ++AcgnoBbgAkNLCr49OcnG0=;
 b=I597UMM2N7VrtCbN7UPFDBRXzCDUifbt49NSiba0+L6YAlyuTTEcgTRXqlkcmNKedNcZlxnPvqsCIqPzpBV+lewEZ/eSS77f7XPGbkymx5rj99ticqwYzjVo6/iuuddsPFj3SEEaVtoT9YIy1Z9YIhsTK08pHbpXHD/iRcxhTPs=
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by CY4PR10MB1639.namprd10.prod.outlook.com (2603:10b6:910:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 15:50:47 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::a0f6:56e6:4c6d:5b8b]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::a0f6:56e6:4c6d:5b8b%6]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 15:50:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs: simplify fs_devices member access in btrfs_init_dev_replace_tgtdev
Date:   Mon, 17 Jan 2022 23:50:39 +0800
Message-Id: <c4fbee1481dc132b77f2922acb3d679c9c7bf47b.1642434590.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d203f126-f786-43e5-d64d-08d9d9d120e8
X-MS-TrafficTypeDiagnostic: CY4PR10MB1639:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1639A3EC9C4738C99824C7ACE5579@CY4PR10MB1639.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OETcsmmNbRXUQ3UW+Xaj6NPs/EGsgVpHHCENMr+pc8DKXhFLEyIRm0HR87tvM/wIwOweweh27rFxWv32+WpAUjfCZwBoc2llsZ+6tz0KKiS9asIoHZzbWJZkRk9q+fbqn6q8XgZpdJLRHBJzzalSZucs31tcBd2MMn6VdR4OmU0iIQgMwosnvcix7M1HBBbYVUzsp571eMFX3LrA5WfcKIObaQQZ6cfDEWX44xvjD7i/0fLfjVOMnlKvouECXTzsq3YwJLH/n4rQjIAD7kVGIZMxw1wOZWtfFwrf+qflNqqwWPWXrfPpE0ixpoXg2efz5e2v8p7bAVp2WddHRbykRSJZ9N/qYPhZgOG3RjbiDCh9gHkdETmfJ8GjD+RMXH+yxmC3lMOa+/+tWlibH3YsSgo2XRG3fjLyhIcFS9WZRfwwcWSHby9tddVjQ37+aAylJdVPAuyrveMUIJZs+Wfr1ESWuw5Chl8CzPVD90IFxgegKOrcseSpe22Eehq6ohvJBcdZyNLQVnha/bJb2gBridlum2X2lHKngUaB8DvswuUz8X8S7K8a7LzspuhfhI9YFGZo66tHdLH4d6kfgMvSHUNbqW03QfpMo8ZuRqwojgZJKzjDLQKc4ua25Oa/AJNBSQc5rzQAtnG9v9Kxaw1o5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6916009)(316002)(2906002)(6666004)(66556008)(66476007)(66946007)(44832011)(38100700002)(2616005)(508600001)(83380400001)(6512007)(6486002)(86362001)(5660300002)(36756003)(186003)(8676002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9T/Uyk2Z6Ft2Koca7ZgA4rnLP01QVGras7GtWJaelbHP8lHja4U31ePE5DeW?=
 =?us-ascii?Q?eftTk0ZvTuPZKxsq22PwsvP7I3yYivfm906O4W8abAOna40HAL5hsky8os9n?=
 =?us-ascii?Q?12txz4X+MSkfkCcP85ygEnbjq4JS/X0iBWaR8xj3mn2IMFH8YkZIccOM9Ndx?=
 =?us-ascii?Q?6O4HoPHYbcowbPql5vU/i/V2D3DtxdrJgWdI0b7TNf6mhHLRKtCf2Ny3o3J6?=
 =?us-ascii?Q?0Y26pYBp53oF/hFVirTKdrcwtGGub8OPek9aHPJ1Tay4jGivXERdPbCgXUoz?=
 =?us-ascii?Q?lM/LMFD1XtEGN5qVDyEB1hN1uwxT6v8GSEfy7mJ6Dgt+kCW75Nh5UuM2pc2t?=
 =?us-ascii?Q?QzgQVA/qmy6QtWdBZFtag4doJ2hcLiUV0Y4khijSj95MqkOVC8+fZqTI4QcF?=
 =?us-ascii?Q?97z7WjEztJxAoTgRgxL2ElS6j7NkRP9QXdGEhLJpzQqNwLdtY7XZWE6v+16N?=
 =?us-ascii?Q?++PA3nt1k9o0QHGvjOQhaVl3yX3JVldXGfF9ZBStIuYncnexgfQJqIoRGeUr?=
 =?us-ascii?Q?Q9GoWMy+001Xp7Mnia3i6ZxADoS2Xz4Yf2NwAkxG/QNfCU5A8fPB0AQaeA31?=
 =?us-ascii?Q?S2ojksFcwy/xkx2rY/fspSQo2pf8XbVXk+72rGaB8TvQItBZfTMcnY2wuiEa?=
 =?us-ascii?Q?5PY8JNydGrW2CtKtpSgUIApCExksYm+XUN5pLnXfv0yiaeNlXRranO2hx75d?=
 =?us-ascii?Q?tEkT+X5yutk4NLYkOS6pDX4pFUsnZSE6koWEDLEWZGcC/wP95Wgk4/x2pzQ/?=
 =?us-ascii?Q?SrARdicptMRDlLTBxp+VSn7mst/sMI62HTfdbAAW55cvos/J0kI4NcsfS91D?=
 =?us-ascii?Q?HpY9eVNX2CjPW9Y3YWfvlAQeMAZCQP9pC4PdLtJAhQ0DgTBtCbotVara1aOU?=
 =?us-ascii?Q?jeo1jc7yv+gnEdHNKG0VOm7Z5a2ZRlHfK41RwBwrQ/ciVI/0uQQSAZFzIcW4?=
 =?us-ascii?Q?FgTPRykQMz3pQZuIFVb6gRoNryBG6C6b0K0OE7MQGaIoOrDegqPt0Mx1R02n?=
 =?us-ascii?Q?T/DqLdD0NkMv1oCq6Vn9dntGdBAcJMMnkywWqzVH2DZ7mQninC5XiLo8I48a?=
 =?us-ascii?Q?vLWhQTFFzRojw2ciaoGrCvo8Drwrd1Sbqu0oLRuT283F/96et5kBZTM1EnmB?=
 =?us-ascii?Q?cu+2VECAcJzFWG/sdZXBFN7BO0eLcMJy6kqS+25EI+qP7CEViEI/ukovDlHr?=
 =?us-ascii?Q?pMcmdZg+SdnWk3vPPTIgNVfzm4OGiappTjpxAUxT2R3R5AkKoCvVaNuxMCU1?=
 =?us-ascii?Q?aowPp/hCgjVMqg7/VniqxmnrVIiKzDzAsD44dF8XwbkyhfWSS6dpbcDVpimN?=
 =?us-ascii?Q?YMq5PQVxxllI7Y8LJtyJ/4vjKLGMfsUVo1ZnnqSyIdAl76f1AusVC5D03EeN?=
 =?us-ascii?Q?iIkN3I1JbRydLTY6p0cTuUNFjMDoX1qjG4syU6sILtT3YSani5RK8xdoHCs9?=
 =?us-ascii?Q?f14b94BXX4R+IjugtCXBAS7ZSPFEd9yXWLDmu5pnBFgOgteF9Dx6DSmHKawS?=
 =?us-ascii?Q?md3mrk73LfvxvIyl0BYNZpvwCpLTLAE8+AlJ0ADOOrdO+bseJNlyfUEhjKY+?=
 =?us-ascii?Q?KK51AyBJsnkCAdiTJ0vGisqy7EY7KAX9sDKgJjeejmOWpDepnAaa+CrbxXu5?=
 =?us-ascii?Q?5DgH4qGqzWH5HuRJbghT9OM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d203f126-f786-43e5-d64d-08d9d9d120e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:50:47.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL6ZYrQIBda9Qr6WY6vkMacyCjHUI/sfNWDpJ201vUCpCzMk3cWgDxSY2XLS0KGhXWtkYWD99mIZ5nwM1gFbVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1639
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10229 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170101
X-Proofpoint-GUID: quWtaOeXRQH8aTjOJv1ruFCTXoUgvOVm
X-Proofpoint-ORIG-GUID: quWtaOeXRQH8aTjOJv1ruFCTXoUgvOVm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_init_dev_replace_tgtdev() we dereference fs_info to get
fs_devices many times, instead save a point to the fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 289d6cc1f5db..71fd99b48283 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -243,6 +243,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 				  struct btrfs_device *srcdev,
 				  struct btrfs_device **device_out)
 {
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
 	struct block_device *bdev;
 	struct rcu_string *name;
@@ -271,7 +272,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 
 	sync_blockdev(bdev);
 
-	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (device->bdev == bdev) {
 			btrfs_err(fs_info,
 				  "target device is in the filesystem!");
@@ -323,17 +324,17 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->mode = FMODE_EXCL;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
-	device->fs_devices = fs_info->fs_devices;
+	device->fs_devices = fs_devices;
 
 	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
 		goto error;
 
-	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	list_add(&device->dev_list, &fs_info->fs_devices->devices);
-	fs_info->fs_devices->num_devices++;
-	fs_info->fs_devices->open_devices++;
-	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_add(&device->dev_list, &fs_devices->devices);
+	fs_devices->num_devices++;
+	fs_devices->open_devices++;
+	mutex_unlock(&fs_devices->device_list_mutex);
 
 	*device_out = device;
 	return 0;
-- 
2.33.1

