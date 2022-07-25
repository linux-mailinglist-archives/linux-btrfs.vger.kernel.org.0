Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8C58012C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiGYPK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGYPK5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 11:10:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F4637E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 08:10:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PF9J0P032091;
        Mon, 25 Jul 2022 15:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=KVw6PkoVdccLBmswJLjtKjutR/URXJJVy9X3gmz/vKU=;
 b=RDqnQ41KOH58lobxI0c6B7tXyc0lYGFG/u0Lf+/flQOjNnyI4Dc0OW9gu33BYqizGN/B
 xIJGR378YoX/5ZXjIQPTSbY4K//OAlvMhiFtkyzQhrtB8q/oqCqAunAGOU6vJcUdM82M
 TfnJnaJz1kPfUyBvVvT9l2xYu+QD3iXHLVnbLEgegNmbGcsUY2J7/WiKys4bszoMz9TH
 emB5HHcM6tqidcZwrotT2HK0fpiqqP/B+15/JdA9a39+uQ83N/xRS/qfbADzIOLQ4o+Q
 OilU1p6/i5q4ryePMqx8EEj8p1/y+F/GVh+1lGEZklD2S4hrjZgqTY5VNanwdK/MOFvo MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940kmnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 15:10:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PEU7qQ032993;
        Mon, 25 Jul 2022 15:10:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64qkyfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 15:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkYoBZOUWbLiJ6Wse5xbdXaiKnS8WwCmV38JnhbyI2qEaMJzWvvIKJJM4UJ016ns4WS0XrcGtsPZblXnpOyYPZcJksl8B6WcPx3qHRc1MaM3rMAFJeJe8uN7ghH2Vn9FHArkfzxT7mP5V8uL7t21PwpdF1WDbkyklmrrr4LmFw1xZOa14RvK9cNv/Wbd6M99FXTdeGKGauXq5qwn5jUhRVNOgUKTL6sR1TAImurlBZreqmViDrOqkS5XdKLE3vmhZjfG8cWmAlw6CZRzPRvCsZfAcX4PNZzFsDvvw/rHBprsKaEb418x+aOJQfazxtoXri6siiwg7R3ixacAJRXcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVw6PkoVdccLBmswJLjtKjutR/URXJJVy9X3gmz/vKU=;
 b=i8oxQpVJRDVduh6JP4GfXAHJLfgZryBOi+ioYdp4azlebO+G32dCN11lmw5+5dUCooSp2KIemAb/aSjFf8Am1rm6WUTbGqwscyM+YXavDaQpYvkL+4hQSuFJWkmn0RuZ61jDC1TSTaJTgv95njMJD4gzDn8w3ILVq90Wev5pzw3O8r2a83XUfevGRcJOGfy3fxxe2Vak2K/KXCaFmLA6t1x3kwIJBaqGgIGsII0UFNTazbVeY1pr+13kmnt5MqAKF8vjz4KwQuXUKpXr6ZAOdEdqmBf8GSxE40tW5WXinAX+3pzvYL29tomN6ZOr/+lLxEQlOdUuPVa6cG/kvJuxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVw6PkoVdccLBmswJLjtKjutR/URXJJVy9X3gmz/vKU=;
 b=AUvXiaZmUTzBZjumxkFO+aHZE+e8oo4IpqAll5i5eyEKoC3GmviSoAIIbfV+7vyo2l9jsVQGX/KIo7Qv5Sku/8P4fLEATA4dhU4a+wlIK0kXKoHh/pPeBGKrmqGY6NVCtP4G2k7NAD2qHh+q9xHHPi+5RKbe359S/CfAIfRkjYM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 15:10:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%7]) with mapi id 15.20.5458.019; Mon, 25 Jul 2022
 15:10:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] btrfs: introduce new device-state read_preferred
Date:   Mon, 25 Jul 2022 23:10:36 +0800
Message-Id: <73edc0114c664b45f3d23b02dd71cd589ce3e2eb.1658409737.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1658409737.git.anand.jain@oracle.com>
References: <cover.1658409737.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c314ce7d-66c4-4ffd-64a2-08da6e4fdd17
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9m12Ih0xxofvqZVKAdVwK81wT8Wr4oflJLkSsD+MEQOeGq993DUYrrUU0X+37QyWfIEPISz/eD+4BCZ17Fq+Q5CYGXeiM2PuvCY1HL6BAU8Vo7fq+/Jr2lGQF/DlUXffj4Z1AWA81KWRGik59v0SCtrTTZcw/ocVcl6gyiCX2FT6uozIqn/NOVoFIPxUk5y6/f/kOZSwU+q9XbV0uzBqORB0BujDokNqyisTCjTp42HnpAtILQCVkpsjO51MudtxwycVH7QwphPJxCsnNbbxoAQn2TQ0bm5fKFh7arjtBEgaN5JNejaOco0j6t6BfRiYaLvec15r0myyIBmXJWUtfEo9aQdGb1VjFkfVO7GfN0KvhINtoNHVQksdaon5uvPpIoF1TpvHQ1kRIL7kLQg3V4t5kwFvA9//+gFXaP8mMk514f2SQk+FAdw+6WmBEzWiJ+SC0NfM3MtOzUJGchb5+MKUldx18qPNArsQvy420XcWDHcnUZc1uQcm2J/GlR+dq2TnWZP2yhlzRPNiMiN9R3Lm6PGyqnUWyqvBYTmlV3yWwPjZfo16TSiUe7DGPn882I0dLHCC6ivam2WRaT6pNHSSD0aEp2VeajxwpKXQfpMXhwGI3BM35euBaYZt80saWmTjLixg9GZhTM+nv2GWI+RPM6Rlw7j4A1knKyhwn2hKYcFxAsFLvLqbsJ66y3Lt3XRyKrAHvCFJaN6vx5bk/EmXXYdMLonGUisxtptLnqTC6aoJnz1o0EXx/tsNrNWz90FdNUbKlAwpMREErUNheAvhleY6LAPUaIsXVvX3GaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(396003)(346002)(6916009)(316002)(41300700001)(6506007)(478600001)(6486002)(6666004)(66946007)(44832011)(66476007)(66556008)(5660300002)(4326008)(8676002)(2906002)(8936002)(36756003)(86362001)(38100700002)(186003)(6512007)(83380400001)(2616005)(26005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Af8Yy8xtK3UL37TOenRY7o5cxUVIyMvf1cUsbag9v5ZH0Z5Wr4vqr5QeCrCM?=
 =?us-ascii?Q?6B3NC77E0smJB3OPo8hc1K1tYmmWyMlpFfLMfmW9y1KqWCwsGbpjall6qnbx?=
 =?us-ascii?Q?Bapm/N6LatH/LF6UCTjIk0d5E8EeChzugxPflVXQleydgwYMXby/TUyNo517?=
 =?us-ascii?Q?AaTawSMU2nK+L0/MmBQ/nDM/DwCiUru9j5gUGVOw5pcXbWBgnJ2+BjRqEmsA?=
 =?us-ascii?Q?21S/TNnsj9tMk2SJNarJZH4cYKFiRJ/6tqbILvyzYzhWd4BgxBrESSYwOzhs?=
 =?us-ascii?Q?J1fIe2QqI53NXsrpe/BqGLoDGLD3pirfimUXGqr2tqRllK2PRzV2ewbqyLcI?=
 =?us-ascii?Q?2PH3gTyKPRhrGASlPJpTyN3oucjIDJdk826A/+FNAA9As7q9xOHYt0xzdnKl?=
 =?us-ascii?Q?LRKPR5uE8Kz2uQ0Rt6XzspIwmW6/PrnfDhB/YjhzUEzLnXdoPv8czihDL8pe?=
 =?us-ascii?Q?prZdg9JflXvRjjVVr/tixBDITDqymvNxiUo+1UcYW4k8cLQElT8RGQ88QewR?=
 =?us-ascii?Q?2LJCCRdRZR238nX+sng8wAOr6HOZhqP76DIY2Ynxjo+xima7QByYk4xxFW9R?=
 =?us-ascii?Q?ppaw8z+F7hIniI+8ufXGkz+8iZcRctF1NTJXDNc5TzJB6Zrk76YAkRgW1X2q?=
 =?us-ascii?Q?elihkv1c0rPbJ39e9ao3hXIjxDT2aSqqHpAEZIYlIcNK2MFIQjoVLSlDBC3w?=
 =?us-ascii?Q?zaLLAJnSaa5W6E5EeX1d4v3BpOAhumQXoMr2CBJ2+2cShESs1/JY3aGseKTs?=
 =?us-ascii?Q?jNq6i8sDXKTvdAG1t1ZhTJf6tFLqhqFMcNlHux/ibbon9wchHKyAy6khpeMx?=
 =?us-ascii?Q?8us8dMS9vo2/rDk/WJ3Zl6fpqX6gkydq+wDHxRIn2ODxrUNTgjNp8/AV7q74?=
 =?us-ascii?Q?RyrHglGrGQlbPtmuX5HtVigXgYlDamLiUq1zvGFyR7aA/7KTv+5JsLp7cR7V?=
 =?us-ascii?Q?IocIJiT6SyBGmcy6rmDnyiI9WIom1y3gBC5SIblVHE4rSm+Z+7+T2oghCNDg?=
 =?us-ascii?Q?dhNVuaJjy5qlbDmJIOafVwSUIm75l0lH/S6PJZKIAPCxq7FQ2wWulvMxr+W0?=
 =?us-ascii?Q?TmYUkRMSswOBPRaMxVoT4h1IFJkuUX9tIYcLhtMAiir+JKh8ItxZX5j3mF5I?=
 =?us-ascii?Q?K9nB0uZtwRoQzftdZz+w8/BJriUTWa7vOrK6ujkt49EDMDD/cGwuCiWoDrmf?=
 =?us-ascii?Q?P0UJrBJPCDyjTD9bWxWaagJTJt80uy6eSEdOhdp+2nQrzZW2Q0d/mhq9YacH?=
 =?us-ascii?Q?+/8Ov3ZE/iTmjgIQU2cZ+9rE2vv6f06d9H6Gj8RB6zhBVAQ0B6L3F7pifEy+?=
 =?us-ascii?Q?wgva7166hMxqmGnLKBxZoEshNP4NCCXP6ywNw40MKmk44EL4170SMYZgeCeo?=
 =?us-ascii?Q?WPJKRqwnt+ffTw6y43n/wHpHnPg7B4T405HIruOmSM4aT7rmX1yUEhtoxZOO?=
 =?us-ascii?Q?WG6TNCGCnhq6AckFabO+sKMtedHV+DVRwcH3Ad0tFG6DfLuYZu97RpEP63UJ?=
 =?us-ascii?Q?iatmjHZSMdxdEaa8cwxvKjDavWv6KUp1VKbPr2dtHOmyUZzeQFvpTycYUmTJ?=
 =?us-ascii?Q?zeuas7IKBE32rpmbn6sGXW0dVb96wSKvCBAZsqMv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c314ce7d-66c4-4ffd-64a2-08da6e4fdd17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 15:10:52.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOfTmf9jIDa4cQWFsLYlzc4Gct3QEbCM+GY0BesRor2PVfBfrMbt/nxZ29jyJ5o2dQAJpDp+0Ugd3z86nE0IUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_10,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250062
X-Proofpoint-GUID: jwpnkiYV3UrQO9ufKBKtYcApCp1w2avr
X-Proofpoint-ORIG-GUID: jwpnkiYV3UrQO9ufKBKtYcApCp1w2avr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparatory patch and introduces a new device flag
'read_preferred', RW-able using sysfs interface.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d5d0717fd09a..ca9812cabece 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1785,6 +1785,58 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
 
+static ssize_t btrfs_devinfo_read_pref_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t btrfs_devinfo_read_pref_store(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
+{
+	int ret;
+	unsigned long val;
+	struct btrfs_device *device;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	/*
+	 * lock is not required, the btrfs_device struct can't be freed while
+	 * its kobject btrfs_device::devid_kobj is still open.
+	 */
+	device = container_of(kobj, struct btrfs_device, devid_kobj);
+
+	if (val &&
+	    !test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
+		set_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		btrfs_info(device->fs_devices->fs_info,
+			   "set read preferred on devid %llu (%d)",
+			   device->devid, task_pid_nr(current));
+	} else if (!val &&
+		   test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
+		clear_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		btrfs_info(device->fs_devices->fs_info,
+			   "reset read preferred on devid %llu (%d)",
+			   device->devid, task_pid_nr(current));
+	}
+
+	return len;
+}
+BTRFS_ATTR_RW(devid, read_preferred, btrfs_devinfo_read_pref_show,
+	      btrfs_devinfo_read_pref_store);
+
 /*
  * Information about one device.
  *
@@ -1798,6 +1850,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, read_preferred),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5639961b3626..f04a177136b5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -85,6 +85,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
+#define BTRFS_DEV_STATE_READ_PREFERRED	(6)
 
 struct btrfs_zoned_device_info;
 
-- 
2.33.1

