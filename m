Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7023FD3EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbhIAGoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 02:44:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3422 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242135AbhIAGoQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 02:44:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1816G4s6003697
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=TxLaFnSxn0iCdTUaDKVFQkQ6gWGEknUbGUrHA2K+T1w=;
 b=fQJ5ptzl9oq61M74rDPMHSEktm+o4qf25H69Yq1YGzInkxs731ptpfM0pB1qXjeo43bV
 DX6knvye6JdcpOS35JyTD7YVLsSY38H5o31BXkJ7sSsZPsh6IDD1K1K3QXlh99WWNkmZ
 wG5nxymFL1rkRpyEHR1A5v0qH2Bq+1wzYbbjQ/O8SjQsO3uqXrzocchxb2BF0SVgVum1
 uhJeZDYOucd+sT3jp91DqjRf3Cw/AA1Iw5JVleFR7lo+P7tbTBo4U31So8ekzE9glnun
 oBUwScyQSMC6Wrc9fW/UfseKKe7KwzKA9Fjzkp2/H6SdHBr0h2V24lvUcndCskwLB8wd Hg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=TxLaFnSxn0iCdTUaDKVFQkQ6gWGEknUbGUrHA2K+T1w=;
 b=DObXxSd4MR4em5n7acYsWoY3ReGIrAAm2rQvtnD2g9strEDLulnHRGqE3uhJLc04qoRY
 dc9siyYgGLwx2afBgdb1wRM36+s0lsvkvymkiZWr9gZBtDCXa4WG70BwX3YQ79fXUfnH
 jE+MccU2+uMPNGzGk1AwfW63CSpmPII0xQTWdiYABVMFsvMbe1GF1ecBQGyxb8ruvYLE
 VF9fpC0vFNrsCB29uORzr9LGFsPJmUxPSXlHKu2Z20AEH7GnHvzWeEvddSUYKb4lZiwp
 M8835mNvQDVSu5Py68xhlIO+7crCzBA+u1PbJuBBydosVOuZKK8Z+jbE5SY3ON4H8ARk XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aserr3e96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1816QOuL003073
        for <linux-btrfs@vger.kernel.org>; Wed, 1 Sep 2021 06:43:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3030.oracle.com with ESMTP id 3arpf5vyey-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 06:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbl2nxKu4P8vlwQn4kSveU+Gl3XIxouc3p2ZRo6Q3wL8qqcgwueqYKCorqz7kqOJ+AoNUjxEMYtoCmNoCDqPg4z6UEF47K/+NujyDPio7yXxxXTIPnF7fWGs5EWCMpc9vMX2Cg05nE3bMAG7aNmMoRYi5m4uo6+mFjOuEEmyvDCxUIZQBbXgYcSyO6geZsQL4GahaaxNZnceEwi8T6Uz2dn0PFjaaFfRlgncFF9B+vD2D2UihYcfC3pDrYW0Lhad4CK6frQ+yXsSYdRgmU5WHGvE7KqhY2w2adf18Q2NHo4/uYvCMpknlgyv1kIuv/lRAkw3SO3xkdMGZZORiMAH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxLaFnSxn0iCdTUaDKVFQkQ6gWGEknUbGUrHA2K+T1w=;
 b=VRTDXkgX39S6pZ9pkrykFzF23ughdw9WRCNxnu9GQe1wg9OfRaUmxXVQjE6JwEHkFkRAfmBk8p3XzrRjTMHMnY/orYMuwqTrTOff+fX9AhrHkHADHDNV2CN19xmTa7ynTUFLjoBZbvV32ZD5CqlT53rOwECLtmIAIZvf98tKuhaIckhLfhdcEGHaMMM0gLhfJl3UbU8XWJzrSHS7Y2xElfIbxYH0PCTiS31nql8Hh6yg+vsQGNyih+MA6F4woKIowX1uqXLp+GXJGcyyrjDIFlotWvolEcGQxk9ZYNzeLbfdJgmvPxO7ekAvz5dhWziCl772xqSqtI1KCC/+IHsQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxLaFnSxn0iCdTUaDKVFQkQ6gWGEknUbGUrHA2K+T1w=;
 b=pYJ7yaObO0ESNcDX0R3n1JVPf0D1LknP0X0SE95scvd5m/zo6lLlofMV7kSHGvCIzDZT0gFmp3KoN3OatyPhlQakr9kOn1owFmhE4Lq/D+1fXJ6RB4xz1ycJ9Bu5WzIbl0q0LhJHmsZzBGYubMWYXOJC2h87FLBjVIHur2tQvK0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 06:43:17 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:43:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: use num_device to check for the last surviving seed device
Date:   Wed,  1 Sep 2021 14:43:01 +0800
Message-Id: <d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630478246.git.anand.jain@oracle.com>
References: <cover.1630478246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 06:43:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34953027-3c25-441b-a0f5-08d96d13c7cd
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR10MB2795ED1D6D37893D2C5C8AEFE5CD9@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prFGizvhA5f6vZXIwLKhWEDLWvKnVSbmbpeH98SvzLbaP1qp2StUIHlRs3hXiKMVecCwaiHcksM9FV3rOQYMlwzTMnmeCNFk/MnOowPDFTBzL30ozZBgctQnck7q6PpRiOeaORftv88FBXQDZ8Gq2mMAXsDSlhMUDdY/wpwMV9lkjfx/gy7zFM3abYK2HqVaLBBoSjtMLL2/+TySrbNp/m/7RW1GJ9owjUj8KUds7o0ccfgASeGYoOTe4PTmdrga5jHFcMJA7Hc2rS0xdt+bAmnS7mP0X+Dpc2v/MrfxVfuPy+SbvuOMn+wLmRuMiPPlhPV6Q8w9+R77Ozf6iKk6nUa8SQBxeWxhkxh3m7HD3KxcyOvzypcff67uzQyrWMP4I3fR7ANZMd/36TH6gRKj7ub1YQyhF1Ii26J58n4zBHIbenjg6D27xyjBOsF+CyG6ko91OMTwu3Ao9HEeC6rkBZ37pCRtHjfwhIoqtsuDovAux6IMUYl03UEk/Q5SGYl2KV2fF6/owqiyPOb5R2mRfAcRhj6FGiWPTCsPC9ffuokZ3XqgSMTwB42S0zJSi5rawrsjDDcjbXkAL4DgUo25SBUA7UJlGAk24i6qWqHukcuEoUDLOgD6AHYL8vsylfoIG3SF54PTgVOVViPxFy9JxqSpZbH//vmpszNAKHPxhwvk9+JCUolmGDuV30qWzDxkHDpIHzvyJm1hgZLOCmzcxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(66946007)(6512007)(26005)(186003)(316002)(86362001)(38100700002)(8676002)(66476007)(52116002)(6486002)(83380400001)(478600001)(38350700002)(36756003)(44832011)(2616005)(66556008)(8936002)(6666004)(6916009)(6506007)(5660300002)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpV3J1SqQW5OvaLZCac8bi7anr2ILUY7gCBTpZzZXaJDXrg5qiMLc2YR4j05?=
 =?us-ascii?Q?Hud9QPwMNTlWuIiWBB2Rypm4+IOW6Vqa160yhLU4xLut21u6kSoQpQ5nU+qI?=
 =?us-ascii?Q?o0fDwLzUgqY9KtrzZ6rYDW0B1Jm+RWhP0f8VLl7a67rAyXFxhhEtRn5AVhym?=
 =?us-ascii?Q?Fe8D9EbEtMXogldY7NruUgaZ25Dv9kdpI6Ntp+SHDVl3k8qpVYeCj4C/9TEj?=
 =?us-ascii?Q?UvkYUhdZmbEJDo1ZMWRL/iLw3TR770SGXvykxY3uEQcPIrxJ3f8hKEBQRwjf?=
 =?us-ascii?Q?zyO2j8NP7POsJBiloN6uwpjoViX3weA8Log+nWM1fEY6oICw1VvVRPg5doq/?=
 =?us-ascii?Q?KcEBAoF+NZZm/5BbGvde3sauRSVgMYOZtW/hqKqq29IQDcIAJDQEXJPHHPFT?=
 =?us-ascii?Q?W0f2WhzHiVox+9bdmbAiTzrKnk5p1PX/QShaoOLERJzTdy0OOY+FIMVHaoWs?=
 =?us-ascii?Q?w053e5HiNM0xNDLIwC5O1pyoUvy7KO9dQT3I/Ud3ifGSqllkRoMeUAbmvgov?=
 =?us-ascii?Q?bW98sdcJHWpYN3RCv1QNOx0Hx64WHNVG+24wn825S3lC9ibH7LOO83H7EU4s?=
 =?us-ascii?Q?MLThyELwXZMVF8WJQBt8of85E3o3xI04BFq0OJY8A9XIHjgBMmvC2qnwiXBK?=
 =?us-ascii?Q?7BTYOqvNHnkGKEwLp6IzmBWfoEilIscEOQW0bOz4UC49pPF4ZeYULq7dhnS+?=
 =?us-ascii?Q?G0D1Rekp0G8RkGrwUuFv6wDAYZfIwztAff/ful4Ea6qhdqso1CjnlNwC7g/J?=
 =?us-ascii?Q?wFcvMDiOWU6Ieig/0n2bmcCY74RIA+wCx7/TjCnNvPb7rsO5rxJSpXyQJ2jQ?=
 =?us-ascii?Q?uiGNsPEnOpQ/J75jQWpIdv8+5DbnU4OlylQCJxGQDgTYWkdrNxANmw4veIzZ?=
 =?us-ascii?Q?dkgSMx5GWTDY6uNa/i1FSFEHS+KStND7utX8QGCpuir/F1HWecFKPQDc33e1?=
 =?us-ascii?Q?limSI/k2lANYa/pap/yGhyAdb83cXc4415as4ML1wRYovV4yDOda0GraByK0?=
 =?us-ascii?Q?ixtCeXyfkhbssT4iX1xFgRI22Kfu+JmjA4dY7SFOY3ZaX5nTEkzJmSuElplV?=
 =?us-ascii?Q?GDKricf59HnrItSYaElyL6NAtelJxhxkkT/AgBIrFxVzc+OBnpyFMX5vsjar?=
 =?us-ascii?Q?QUis2D/MJivFII5JHatd/LI22onoeobO6y5X4l2I76TsncuWCK8VS/SWlDZv?=
 =?us-ascii?Q?J1/vQJz4gzuyLPoRu+L9zyV3o1CLLhgfjhE//6PkQjl+2rNibWkFiJMBDcbv?=
 =?us-ascii?Q?iNINI93RbUmkrZ/9SxhbCFjMLutuRRaQDkYTsSvwZ0g7QMqYWo/PFEhYYdlk?=
 =?us-ascii?Q?ixRacuqix2LOx5WGXUKagSZU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34953027-3c25-441b-a0f5-08d96d13c7cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:43:17.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVO47yerZlQWZDajdgo+TiGuEUJ+DSgmW+5n9gsNJOBoYNJ1W4W/0O+U9IPY9APIxMr6VO1OQpbEbJ+1h3WUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010035
X-Proofpoint-GUID: P5616nUXbdKCUjkVecPiSqANgUR_kAgJ
X-Proofpoint-ORIG-GUID: P5616nUXbdKCUjkVecPiSqANgUR_kAgJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For both sprout and seed fsids,
 btrfs_fs_devices::num_devices provides device count including missing
 btrfs_fs_devices::open_devices provides device count excluding missing

We create a dummy struct btrfs_device for the missing device, so
num_devices != open_devices when there is a missing device.

In btrfs_rm_devices() we wrongly check for %cur_devices->open_devices
before freeing the seed fs_devices. Instead we should check for
%cur_devices->num_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 53ead67b625c..5b36859a7b5e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2184,7 +2184,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	synchronize_rcu();
 	btrfs_free_device(device);
 
-	if (cur_devices->open_devices == 0) {
+	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
 		close_fs_devices(cur_devices);
 		free_fs_devices(cur_devices);
-- 
2.31.1

