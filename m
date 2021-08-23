Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C203F49D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhHWLcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:32:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21548 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbhHWLcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:32:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TMSn021819;
        Mon, 23 Aug 2021 11:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=r0g11iAd8pfJK2z/MPlYTks9JDxWh++Q1y0LwjNk23g=;
 b=pjojZ1rUy1JqUiyS8onRjEJTAeh9owehk8230XWHnc1GrJxqEjbGZEN0PwKjEvVyP8+i
 7VyfTj/va9KEh/6XK/uvAUDCov+fFDhNLPrlbdIdW1sOFRYs4ibfSjTFotVnwxpgzBkz
 xORXaT1mOP6lHkYJ8TmDVk+h8HjSjJ2b7+x4uPiN7Kcob/pnnIzwed1Tyq+SnryLClMP
 eFgPxtQlAGqx2YyTZm+LGoKlcPvAVjSFw+4shQcStlWdec99OXl0ijxPoA/9jWNIlK9C
 o22yuszS7lT4DCp2vF9Up8rEfTbgu35/qqIz0XcKqVS60pmB5scsS+jVBGAGVz5F1b6c Qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=r0g11iAd8pfJK2z/MPlYTks9JDxWh++Q1y0LwjNk23g=;
 b=vmpgGzg8+5AEUAkFZ1mSChqohrt3ZvgN6brLdnUst+mmB4hR9ALEMczexYSmdGLxttM7
 GiWaAjGDukCLAqIvRBUhwieNpKHAcjsn2BgYFBBIaV6yGAoLddyS0blhH95Tz6BO/xRC
 J6xWwy/x9RdVK43eNLZBCq7knYoqNHlV8uTiIplCvCOuJB7uYZy1Cqr/gxFii3C6o45Q
 D8FvVor2e/U3mDdSoWPOc3q9Cnufsol2n4Q2LdcF46sjOuIstQNjN87F9VTMDb+iR9yv
 5Fcks2u/mYbhpAAqvVmMh28boPq+vtqgWdgccAnR+v6U4RBsIxWIpf5Tk29hAMeYSQeF bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcf96aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NBVLxW021994;
        Mon, 23 Aug 2021 11:32:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3akb8sh71r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/wb72DjxR+uk+XngxB98o1kTn+9EFs9cHjZiursqkE2b7fuvcY/Nxk9x45Jdlb9rjntQM2mzyJ95AxCgp5XQdVz2+0TP3V86nmbMecVspR20GDIt3/OqMYFoaY4ZFIp89v/D+4SxpvgVLfcfdRoh1IAklWKELy/NojXV7Lh3U6vPJMM4ZWDm9lQVhBJ0NSKGfh6MtJs4UasBX8wiop+/hF8cPbHxrOoZfH2d1NRtH6YMGCDhD2XSU4YGeDIlYPqLa7evvVhPuBwDpOmm231EuiPEiBPXNkxSNj8Y5uwmzFefkwUqrJ4T8sjPMTVTWBFoOa1J6Eoq6t5Al5l7hw62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0g11iAd8pfJK2z/MPlYTks9JDxWh++Q1y0LwjNk23g=;
 b=Vne+1lAiAID6tT8EkUyaI094JfChFY0yOg/Uu5TwH0w0sYlVpQFPpYZERd1IlQLHgZG8Ri6MDS2rwa80Q4Id+ceAgP1EuN2iJkKXFAfF0u3C8BHlnhoJTP3CFcw9I2ZbUH2td+JBsy99OY/+Txke/NVguNFbKZEyFO8NIcMouPlYczukJib4LSIrwsceKPSETjAeFEVV9+gIwxHhylxNUgNyv1RM/UDpThn5hAOByXSg/xtH0ZgUsT6vBC0SxD1kwrnud30OWYsQAbHFr9aS8mmJHDeYvDb8D+7rw+vJ8CBzmM/p7e4hC6zAWj8dkl85xTu3LcNt0J1tf7Pq2gQZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0g11iAd8pfJK2z/MPlYTks9JDxWh++Q1y0LwjNk23g=;
 b=jTWsCF5YUTRL/WU69eHVEDlO0tHY5vTYqEBjeKDeYl84TcUPYA5/+hkmiL1lf6QatRb7ZM974jTdfMdQ3Qhg9+v54AhWtPcEt7rwIQvIi+QyFhUeF1ZsREWewdWStl3EphkO+KBplTskilZCF9FfK0lSZDMuAQYRZ2W4cAbr+9k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 11:32:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:32:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH RFC v4 3/4] btrfs: use latest_dev in btrfs_show_devname
Date:   Mon, 23 Aug 2021 19:31:40 +0800
Message-Id: <1ffa15f29c6913e51a60c48b1040d8306daa6e67.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3b88e47-280a-45ed-3826-08d966299ffd
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4206F6A96F20B6A497D9A8AFE5C49@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yQW9PXZ4QC4KoZbagVRVVABKRjX6YC9VR4HfVHnxr9Z+47orMXrnmcwzDHjB2fihrVSvKU4hVV9IvsY4L/UCeIKXgxgW4zizjNdBqE/IRTHZx9iLs55D9C2Rd6C0UmqfxzZ13Ouz+i420l0ZLAMds3CNYvlBHjox+ga8+cnmduMRdD8aLv4YoqcDZTkStO9FL6Xet3lHOeCmEqDDN9Bgvizcs+Jxytl8xgjKxItP06l0y3vf3I3wRS4sIvkMzSR7lub3MXpn7kq7XEqWx+9nn/D4cokrptiG+jRfKSrZT9IQ8oD0v6Jzq7DzmcqZVpSLqKIJ2hEXhgSK/XEruwr9vf9z9x+74K/+OcCEWdCcB4MHsCu6DG2DjA8xYMRoY3z0Vt9Lm949pYG1GbZvM0WM+vKEV3Bbkc3/u5bj0881hYb4F0oTbBnkDwDx2d5wWmN+TsvIXFvaW0wLVKFEdBabyfPqfFFJA4xSAwa9ixAJnZ9eXY53GEN8Pbd/oSi0Ck/lAXxeaDsp2vH6sIJGAQPsS8JSg5sHQ3Woc4WaeAz6t4maowMfagsIIz0Gw5K/Tu5aql1JV4lwpsNrmBdManY948feC2lbCAWfZqF1eNVcMUJYNpSPfaTqDQ1+7XQM4BfM+mhk04Z1t74uxdznsYS6//tWjDT3fjHCG8EboPPL3wFKDzmsCopwPHaQEjFm5DWBW1Yd+etpC6lwD3ABTduDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6666004)(52116002)(66476007)(38350700002)(6512007)(26005)(478600001)(38100700002)(6486002)(6916009)(86362001)(316002)(83380400001)(2906002)(44832011)(66946007)(8676002)(4326008)(6506007)(8936002)(66556008)(956004)(5660300002)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZO+1AC2wodYDo+TJI/2LT7G4gDgloR8y4qAqz2ce8QTwjb83MITg5jfYsW38?=
 =?us-ascii?Q?fsNFn/AtVbb94dzeZ9qQgVM+1h49VotjxTCTBxNDHGcdGoPfE6mR93mJbkRx?=
 =?us-ascii?Q?PasOuTo6snRd4hAWN8/BbaMv34Li4PHSBiV8VCUkmEElu7ETIMIiNM6+IB3R?=
 =?us-ascii?Q?cGe6PhVHRT/QsTo3Ubv/ZV87vn8OR66RoPqN9UWtdhIbo46uR0uPtZHA1Kma?=
 =?us-ascii?Q?mdzFrl/MCkjcRK+v4pAovFPS32B069RZe3+JDODkNzALCy6i1zZe7paF+bNJ?=
 =?us-ascii?Q?yDvq3RXs7gwL4oeEovrT4okMjmCM10C7xQNmG2R50l/bB48Op4FXdRjGKymg?=
 =?us-ascii?Q?577o9RNDeod425wO8Z5eVG7O9Hpfq6BrVIY+REJRWGnFOslTX+iAC5fkmHA7?=
 =?us-ascii?Q?QcoZCzZZzSz8K0bouuIIHcLLjC+Gf+24bta2nbWfq0Zd3xmjp54jBf0fu5oV?=
 =?us-ascii?Q?k23alNR5jduZYTB+eV24TCnBVBg/op7v6fad8yX+VbV8CXIMp8XfaGxDXwdA?=
 =?us-ascii?Q?GGk4zx8L4LVteTirF4rnV9xlxXU7qiJlpGJt2tD0B4Vc9aypT8WOcVRRpSIH?=
 =?us-ascii?Q?Atn1E5HckfKKKWpzS0iiRjSqmrh3KzDtUPaoLhF+ovNjtL9Y4v1dL2sRzwAR?=
 =?us-ascii?Q?KE/e4s35zbRuLUiPMLfBnsb5BH1gxLR2CQlVPMG5j3QFHriVEmzKbytbp5fE?=
 =?us-ascii?Q?9YKPREXnzsxNWnrBRvfvMklTyYlxTb3iJVyz/qUVY7qb/iznZ2pJ77osUtxj?=
 =?us-ascii?Q?s45PpY5/c8DyGaPXf9/CtmBYqKQdM3Pwvwe8zvEWbvKo+Uj/4bXOcs2I2nbs?=
 =?us-ascii?Q?EPKD8Uk9jWRochltnml1IOmuhS5vcHLoSa5kZGlh2HfTOWelH+lZYyLtBAXY?=
 =?us-ascii?Q?a9biN/WcQcZosAf8JO4osysKwHGzw8q1nIIxY14J4VjGE/pkxVrPBqR4vFxO?=
 =?us-ascii?Q?VoTRjEgjFMDUG/hCUsz0uiFsvo43qEBtvUI7jZeKKsFqG91tkZIU8uKmQgk9?=
 =?us-ascii?Q?ICs438dhVDV0pIpCTH35RflvC5oGMpUB8eu/tkkG8aQMRJBaMPxLpSnvrOyr?=
 =?us-ascii?Q?/JgOfhq7qHMIFwXY9jIOxv/mKZAePKV/uIdMmFR8co4uvtOLdSdriAaH9BRH?=
 =?us-ascii?Q?6GOuB70387rAtJF6By7AsSYRYAAtN59JsSfxYYO5joC95tjzp8TLMzp0lvb/?=
 =?us-ascii?Q?16XbZNrSAnf0dm4dXv5Xsese6f24uCQrxKn17fOyC0cb3nsi4Pbn4WNsVgDt?=
 =?us-ascii?Q?mPI4VC5QXS+KLSJxODuFno7ubxWApRXCC12ah3rm4RDVfvYVQUw8d5Wd1iMk?=
 =?us-ascii?Q?dDl88s73GRoWQn6RfmQgr6Mg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b88e47-280a-45ed-3826-08d966299ffd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:32:01.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHjrZEHpsgr0oSh0/UdrXHY/MihgDEcJnK9neUkE63oGCITi32Zp5pzHVGYh7dIzx6cO9Zgzne0NAzX8xoOc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230077
X-Proofpoint-GUID: 8CdiZtmO7A9IUpajMVaQrt0dJT6SZdX_
X-Proofpoint-ORIG-GUID: 8CdiZtmO7A9IUpajMVaQrt0dJT6SZdX_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

latest_dev is updated according to the changes to the device list.
That means we could use the latest_dev->name to show the device name in
/proc/self/mounts. So this patch makes that change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because,
With this patch, /proc/self/mounts might not show the lowest devid
device as we did before.  We show the device that has the greatest
generation and, we used it to build the tree. Are we ok with this change
and, it won't affect the ABI? IMO it should be ok.
 
v2 use latest_dev so that device path is also shown
v3 add missing rcu_lock in show_devname
v4 -

 fs/btrfs/super.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 64ecbdb50c1a..61682a143bf3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,30 +2464,12 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
 
-	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
-	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-			continue;
-		if (!dev->name)
-			continue;
-		if (!first_dev || dev->devid < first_dev->devid)
-			first_dev = dev;
-	}
-
-	if (first_dev)
-		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
+	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name),
+		   " \t\n\\");
 	rcu_read_unlock();
+
 	return 0;
 }
 
-- 
2.31.1

