Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CF694173
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 10:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjBMJj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 04:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBMJiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 04:38:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A0166F1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 01:38:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8OKfX030980;
        Mon, 13 Feb 2023 09:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=acMzrlcdSMhSlO75cxuwZvMOuCyh/izDUky0D3d3E/I=;
 b=1LSkunNNAhzg0OmMysGaf7I5yLooqVNDEUlG1jtZl9Awgx2h8gZQFClr0G2kJn6M2LdF
 21cIpN3ggpA4dUdtWC+9QL8FMh7qvkiCCEX8Ex13Fs5ByItl7RGgrxPF/SFnp4/ud3h9
 jXnkLFeT5DkP0Mo+lf9NZU1lg1Fnh474Fx0uqc1CK5YV/C+R/ABvanidfsM9g3ScS6Db
 n3ncEExLP+WVPR+gHI4oqe0hmwwL96p5VsDNjwQqtwmpu23QB22N+IXjZsxn0jJD1XoI
 d/ZModnIKx2Aw6DVqaTBtb6rD1xCh9SR7LqnIZrwsoVfLwO0RnrAwrmwzMiqBiOPtztH bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtta41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:38:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31D755Z4017849;
        Mon, 13 Feb 2023 09:38:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4banp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7ceUtwzOXivl/Uw2qbx+84fdt0ZScnWt3WXPV35+cjX/dGxPhtsSJ4GsaoFX6dHRXQfweyd300qQh7esuuqlbBOmoUnieWfXziKXepQnZPXYgHnyMfOpTHIVWxuyiGw0q2fnubso3WxNW9FYqCGTNUxWy1SfC7uXsV3hb2Wz8a5J4x6aLvlKpixgLeUP/vPd7cGFNlm2C7Lh2/MrsFXUAX6unXjTapeAIjEAa5RmtDxVhO2IP4bxG+1SO1sI0Gl9NoeaZCIDnvKwBG3tf2lPqsthy63ZMwHoc+SnAanRJe65qKB2P4Wj2I6QBqjTl6Gryoak+IxIk2fQ5IhH3SHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acMzrlcdSMhSlO75cxuwZvMOuCyh/izDUky0D3d3E/I=;
 b=djCdw7AlsC3WGR+TUiLgYqaLt7FsW4GbWse9u0GEgUx4qdN9i+Gnu6iZObqAnaGCb7s2ArkoJRuolimtR9z6JurMqyvhHaY/XJ2xcHPVwG2DPXJD7y/dlp0JBFndu5WspDg762NCXVxIwXAiFtYRSPbcLjYybQ4UC8UsJk6qqmxyU3HI4OCVPRlbdV4x3pm2AijnPRmwGpoPi+80/eo6hsZjpzNq3+cusm+0KEB8samA4fpVV3t1NBDH0GSMr3jWQTt4I+8HpH/dpszwS7DxnKy7LuAzMLhMs8fvQtWP7TOTZSl2ZUdW2sm7xcIFadV4CqWgPWVQrazzAWJdPuYEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acMzrlcdSMhSlO75cxuwZvMOuCyh/izDUky0D3d3E/I=;
 b=pTvqrIEax+und6X64BafZ5S37HZAguEXvgMJTXjINK6Tjk0Ztoy/33NHnUT4gLVFD4kE3hnoPGLbAo6H9remcF6ry+bkNFK1UKAy5z2cEnrcp6/3DndDT1JN1AM6pcTfXfdDdofGs3Kky+9FkM+UGv4E6KdBbV8rF0erOdV9PJw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 09:38:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 09:38:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] btrfs-progs: prepare helper device_is_seed
Date:   Mon, 13 Feb 2023 17:37:41 +0800
Message-Id: <1eb9319975967eb52107c9355d712f9eb9d96cf7.1676124188.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676124188.git.anand.jain@oracle.com>
References: <cover.1676124188.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: daf76e36-f492-4ab0-829b-08db0da60316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKVSLFiykulBoUkfx7qiu8jDP0WvxqjNZ4Tw43pq4ZodFBYrvOwSlfhdrL3tQzVdNs1hL9oDfL8AA8eUo+na/BwuV/3mo6NGIk85pmXqtbsUXp7QreizkQTf0xTQXAJK6lqeOB0/EyjeF4Jx2Gz5LAVfISzW/O4cJmUXVk/NI7BX7CuTVS2gu+sbUEF1My4prKRnIrGzFCZjTXJyoMmKE7nf7bGuSCX+Gt2OdMEHXrp4LBLC1hoUlKU3eu2DVV+8F1WHcXB8j8R9L3iyRERameyYcNvJyL9hdvgVYiZxKRrSOBvdrVSjFz7F7mmDStiszk/NJgnKYkeZYo2+ksIG0L8af9jVOvF5VbjjnTitEpo7KN87pLS9Jb3AqJccd1aO9+4UKknEepDh1VS/0bOHOuixNyHZ1mJciAtLVw0n42gEBCAwxCecaWpIn8DpSSJ4941vKghhGuPctZqT547evUt0ZtLeXgq55Xi1Te9SVuGsD5Wc1IRBr3v0PlZHQ+zmgo9gTa2gRxUy0LlT0MksetJII+bYAPuyudAIq6zApEThuqokFPLN03K+/muOARvyDCW7SHjiflO7lck/1JUf7hasnC58YW4VYoeKeP8rP5pGq10aoeLWCD6noE5KX6y/vq+53yln9wcMfoUcsXAb8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(8676002)(6916009)(478600001)(6486002)(41300700001)(8936002)(44832011)(2906002)(83380400001)(38100700002)(5660300002)(186003)(26005)(6512007)(6666004)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGMbouohgVh7CBWn2xEFgWyHil/Gu+kZpg17CrZSvmzLy2ZL9rCxjrtON6bV?=
 =?us-ascii?Q?JRVpoCGDwwcISHmYDdFD1hlBZyOCG+ZMlToQnokOXDomaKRIeZssMVQKfouu?=
 =?us-ascii?Q?WwavY6kP2FXNf8xXyobeN2pe3xmhRBg1mu9SZdJ/J0gf+vmmwlmno3Yx2Okz?=
 =?us-ascii?Q?xZKncMmmy7ZzO8TIZEp7X6ylmPO+p+NjRGM1neMJJbemsuB/rAve49gq4PaJ?=
 =?us-ascii?Q?C3lQZqS3KTW3Yjaj6WAfWECScdLH2OAxsZG/YMQZ8YYOV+qD+yXgXiT/BDpV?=
 =?us-ascii?Q?QT4JMPdef+pC5nQ7fYtahBw/IdWtv2Wo3K69V0s6t8frqg5TvYjGqjPmj2fv?=
 =?us-ascii?Q?1R9uFBZ5vKLVesE1G3qxAqQ7xJ8NQbAjwAtoMfaIeSgHWc7JxrJsr89kPaDM?=
 =?us-ascii?Q?8fyQzKwa0pe3d2x5L/QmaiJk/0g/Q+Dnus99+QbUr1C3jT549enbRubLoeae?=
 =?us-ascii?Q?CqpmYzXpiolbijdwXMBjXj6wzEb57jdjgZpfzEhf6PPa9irhEg9Y6WAmr8bS?=
 =?us-ascii?Q?4WMjm6WicD18u5LrWevzo380OJpTOb0qjBQWTjaUQCCYG3yVDIx25cOoH3kD?=
 =?us-ascii?Q?YANlQm/EXqe6e4kzcII063+55BEyRNUrQzqCT3uNEzWG8k2Znw737jVMUjhf?=
 =?us-ascii?Q?4WEGfT6ZheWBOpUekdt0jxKVvNgIwmHof5Y5SLPz8yMCa83jBD7au/xxGCng?=
 =?us-ascii?Q?Gt2cMzLYlVVSblooEQt5X3B2tfyL7IMqbeXFKxP/qoJhSW67vbrwprPk+c4t?=
 =?us-ascii?Q?N8DdMqEOsM2kmxTUrhDZIlAOMTzz4HANmIl/tqCu13ZzFMm8AVCjcqV2WVN8?=
 =?us-ascii?Q?Ic66l3u5fHBTUBqjxWl1AitR54WCiaN/to6pDvXW2MshWY3+M0+dB0gATAgz?=
 =?us-ascii?Q?u3Gbo8rrQxwVNEPk3PluJeD9Cp/tPoKp14gyMET2SBfR75XUncOMeNHwkYZQ?=
 =?us-ascii?Q?HoDLex77lWWWw2oUzHd9Syn3IoOcYMr5saio+6UmUYsDC+esXmffNP5x0Pq+?=
 =?us-ascii?Q?h611m8nkRG1/L6vGvhgq6IZDBpzS8EawgNtRpDXm9GAnuQ7OOG4T6k8GYgb/?=
 =?us-ascii?Q?hSBUxTy/rtnkzWRgdcgjNczvhf9Wi7feVrPfP19FFdFrUB25TuTBIAXyyYaz?=
 =?us-ascii?Q?ZPM/+xq6+Iz5LsFfwFiepH+VWQ8P4FexWnw8TRmB+kdsgDWpJVi2kacwGAiB?=
 =?us-ascii?Q?i31exEs920c6yHYR+cBO6F3nRS/n59dyCkgZZBqfOYyWh4Sf9e8S6fkpMsGJ?=
 =?us-ascii?Q?c7lm8Vz03fYXf3SLZzQ3TfIFOpaZZ/A23Lm+3qcKhXoDS49yQYzZEm/jz8+V?=
 =?us-ascii?Q?loKYobDt5ecZg3XJ3+ORRiWonxbyqsUpFmT1NcXaXHpcXZUZRxlvydFe1NW7?=
 =?us-ascii?Q?AEdjdxK7VHYSCEBhwKLOeNS2rKhQHpET3terOhWG/f8pSHUVO+s7t0VQz6yf?=
 =?us-ascii?Q?pYPjhI/K8R5yeBbPDn1V1ZnEJFY+zlIhv01ifmgM/Ewj+BUt7+SsF1rQ89He?=
 =?us-ascii?Q?A00IRAjPjXGkAbALqNj174UPJlIWrVMn2NEUHjz5ykidB1/lCKYA9fjmJLyu?=
 =?us-ascii?Q?+VUkblPB3a7wGEvnennTxW5mHQyl+5YEfqsVn7rwpKNXIxBeHijAqlSH0zah?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cCzZprBdCM77ZVDdswCXUz3dy2mGUOLM6VvQ2INS0Z80LTxrxBVMdoaXrk1NnCbxHUNGC2eSUWD9QVtwAtp2QIUvkm/3/CDvgiEZkIvFwpM0RcygCZisVppH/yHGE5izJsgaJsuUO2Ci+8aUM5urKI4svdZQcpTyOXFxqMiP7GIAfMCblmLQutThMnJyzvzMsSMPhK5BTnUEtUyc60od90coe+NfbxgYXiWCwmeFCxsU+xVgL36eFIf22NayPVzwkTpY9gCSha9jDs2Bs2XDI7wxA6/qqNs/JTkPyVw81Z8Jgp/vsznDayPDw8CdLGcWUe5RvnfFyBKvzY1hndUEPiXojm/6fEBPqT/LrNPzsxXyuVchgGZ6irUixqyUJ6E3uVAvoPnMtkjbV+tyqVmLV0JIybwL7SOtpcjNXlXq8LuPIfYIkchccet1GlIl8bvEidJsrD6tG5K6O8/zLq63ByVc4QAONwvJdQgz+H/D3SP/FKiGd00S4OU64eaUDOc/eRhYcrUyfYroyBFO1P49ucBgv2LYlmgAjxbwMVWckLevG7sQU+lAgEK3k+d8DsfStdfOKzPztsUbzOcRnUdTWrHPFXqbR56YiIGq8+nTcgetNKz3/UX3nAYbtRArC9QWvR+F3zPTVzQdMieXnnulYteXuvo9f+abU5AgWlHHrgKjhJ193snXnphKbKQ5sGfj0uFW03oYbwogaRlEh+gPJxPlahPWtDiFB3IYeXi5GT5akcvMbEaAEZWapge+u4KdBMRgGE1+8oEmUEWzSUXqzZy1OhcJPgKv1V4ygwiPKyy3xOZu7qWzAPa8CyihmKX16LxVv2Mv0fCcUJMWUxKG3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf76e36-f492-4ab0-829b-08db0da60316
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:38:07.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ao8mABHpv/hyJdX1obU6LsxjINyOsEOj90e/YshYhFBjAq+zlXC+yu1874JFEfUZAD/qq7YVbtv4MFLobBTXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130086
X-Proofpoint-ORIG-GUID: JGn071yd5-q7M1Vqx94-rcWSHBsbPrhr
X-Proofpoint-GUID: JGn071yd5-q7M1Vqx94-rcWSHBsbPrhr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

load_device_info() checks if the device is a seed device by reading
superblock::fsid and comparing it with the mount fsid, and it fails
to work if the device is missing (a RAID1 seed fs). Move this part
of the code into a new helper function device_is_seed() in
preparation to make device_is_seed() work with the new sysfs
devinfo/<devid>/fsid interface.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/filesystem-usage.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 5810324f245e..bef9a1129a63 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <limits.h>
+#include <uuid/uuid.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
@@ -700,6 +701,21 @@ out:
 	return ret;
 }
 
+static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
+{
+	uuid_t fsid;
+	int ret;
+
+	ret = dev_to_fsid(dev_path, fsid);
+	if (ret)
+		return ret;
+
+	if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE))
+		return 0;
+
+	return -1;
+}
+
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -710,7 +726,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args dev_info;
 	struct device_info *info;
-	u8 fsid[BTRFS_UUID_SIZE];
 
 	*devcount_ret = 0;
 	*devinfo_ret = NULL;
@@ -754,8 +769,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 		 * Ignore any other error including -EACCES, which is seen when
 		 * a non-root process calls dev_to_fsid(path)->open(path).
 		 */
-		ret = dev_to_fsid((const char *)dev_info.path, fsid);
-		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
+		ret = device_is_seed((const char *)dev_info.path, fi_args.fsid);
+		if (!ret)
 			continue;
 
 		info[ndevs].devid = dev_info.devid;
-- 
2.39.1

