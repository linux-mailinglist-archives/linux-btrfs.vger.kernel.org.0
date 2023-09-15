Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E27A14B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 06:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjIOEOB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 00:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEOA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 00:14:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28412703
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 21:13:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EL0Goh031855;
        Fri, 15 Sep 2023 04:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hUi44kM0giO4rFwKmNqwxnhmTnu7uM7m2vPyjLtmycw=;
 b=14EHGmIOm2PsiWQl4lVgfT8lTlST/0/4dsT34b+H6G0Gpaec9FbNGphSk7otjt/f8Ety
 TIiimOeIIUJ3eFlvTM2b0N2F/2ZiNYm7PIxu/VwfAJ7Z2GpZ1nSymIlmgjyRgCzSwLOe
 SbwlfaZvz8cvHXGRDYXhATImMeLtVvqkPrlg3ZWAVI8EzZ7aYaB2B/uSyFLz0L22Sz/m
 u0B0CwT0oNTzvXcErFE5SQpNT776XQlNNzjt60OMmhOc5vXFjmGDpfzDL74Qsk/uws8D
 zGKMpQs4jUCu8v8yhS1iIE7y4AaxCdibGv+y4ii+8DtMV4z/Vi4bh7618Y88Uuy+6ehq Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7mxqxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F3FhXV028173;
        Fri, 15 Sep 2023 04:13:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5fvdgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT0VoW+MgV+AuAXc5aN+TZPrF0KFsW0pLfz5bBpbCoIOfEJQBdopp0Sple6je7NSGSuaYF3ruZ49THyDoZAsNjH7Jkw698K8APRa5+g1bhVP1fJ1jbeV3IOmlcEjw4dXBFowRzdzfOv8EaM3IcWTC7sOlZLB3wOpINLabGHigYvNiTOJJB1cMwvGDKsxgOIJu7asXnhTDsJzsOAPWSEGjWpXwMWHQdj5q05ybGM6a786G+ZKiuXEYWtcZT414JfzSqaMOuyRDorRoTbc4imkbu+b101RVnFx0Yte3tfQlC1j13nUKE3u9c8DdmHUbbpIEUI4Vod48eFDIOHt7gKvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUi44kM0giO4rFwKmNqwxnhmTnu7uM7m2vPyjLtmycw=;
 b=DwRXUm2RUFmlhl0whu8xDm6rXcX5AlgO+YPsu3lTw+D3y4UQehrIH6wqvwQS1Qxsm2wphGRVUllXo7dkq9a8doEeOCRHd8GCE7+DxVkmuYjV9+rdWCzCeITMa1KF5BpRtmAXi9TkWOtaln4nGXZJgVpUKMfIuLQEKcvNQVm19b2YpA58c+9QYVJnoj/vfn25uxv3xB41KgHr/EntpWQA9c2q0/n1DfBzBdTVCSyb9bhC0kom+2pJq0wlkA+LDJJXQn5b8jri9JJwg2wke84mbwbORmwSiKcKwWVRbER6EQcfsELhqJr1ORYRn+uiV/JZKCUupMhhws+GddSikuoMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUi44kM0giO4rFwKmNqwxnhmTnu7uM7m2vPyjLtmycw=;
 b=mV2+yo+FZ6OkUGUgBcebm2nZ61rtDpse3BO14bApcuO/AzH3JKapQnapXsjGC4wbuh+0xtD7AgC+njIW6XXDc8zVt6imzdWrMz/n/57CYXl1BRmuMRxxPrxmNQZ0mL6nr2STftVA/ecyprLGsZCYnZCsQAbQuMixbf7pmupNGwY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:13:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 04:13:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 2/4] btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
Date:   Fri, 15 Sep 2023 12:08:57 +0800
Message-Id: <4514fc6c2ae49957e349a9b186a61ed11a0b7d4d.1694749532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1694749532.git.anand.jain@oracle.com>
References: <cover.1694749532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: cf67154c-8006-49c8-4b30-08dbb5a22887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s7Dt3Q5aoCfJXiEfCDCn+uTYa+aKCBBHEAvG6MiFdQM9lNVVfHl8VqFeVLEDn0xm2IeKR2dfZg+La6rtEtxb8KOoKRQVuPYIxDHm+Eh9sUnhppRt9rZMehGe8BtiJOML3Kfp/RvQMSX5qw+9d2gmWIeyd9rALHJmSClclavrzTLTei+6Qt1pCgx3WtPGEVwKQIsHeTAWqA7OD2qJWIR+GcoR6IkjLgDteuuXtIi0e6BeZeAFQPK4Cb7oG6Is92K+a8D50vwheiQAiEoKu5fCr1hdUV8WjlV7cM44wfCrBGdBLQe27fSZIs+DaOKauH4gSbrIeJMKt7RSt/4TEyWp2iXOOKmzOOEfzAsDaPRRcvE3kVA8FbA2pyQiDfoh4YbMegHN2yWwI2LC0G290nNhvLA0FUk10zmxlourTuqRJR96IeSFBepJUoU732YYtM/ghkqV7zKAer85Sdx3ijHPkGcGeO+Vd8p7X19tfeeooLiXb12DQZpvhwhQ+93JGPcZ47fiS/GMICbRiFbL0j9TJoVvrgpMzBpfT1oR4OPlhRdKiCGyUA2zVkpCtgusghq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(5660300002)(6486002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(6506007)(2616005)(6666004)(4326008)(26005)(6512007)(66476007)(66946007)(478600001)(2906002)(38100700002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7wAvVWG1YcTgdG38Y14cqpdTCIfqk6N5spsvopO9ijIMad5fUzOaIOWGfyR?=
 =?us-ascii?Q?if+IJN/xfx2KWusywIeLVpTvQIp5mIcKtjUyVKuuIT0pOFzyO8fBV97ebJAr?=
 =?us-ascii?Q?TfgskOxxNQRi2jojAZAKusHE+BOgB4hK2ya22Iv5br26rxI6oEjWaEgRnlRB?=
 =?us-ascii?Q?N6lt0DhLHaCRz2sXxxds7FboafMdBrbbTAjknZooUJFxEV7n5Ec0ePBXJSJQ?=
 =?us-ascii?Q?rpVq9HJDNQ7vXRjzt4+Hq+pKpfeQ8YrHjoUlkpyutEHflMXMiD0FSHZPspef?=
 =?us-ascii?Q?RmjkX4rXcl4n7Avvm9uQBUeeTMCD0nQpFzoc7tQfZbjRUQVP0Eq2lgrQr170?=
 =?us-ascii?Q?rA25c89WKW5dQh9OnDaHf/1uy3aNNznWj6jlSvsbOs7X8XwGkZYjHQX0+k9n?=
 =?us-ascii?Q?Hg8EzlO+HBaTO6lg+NRo3P2n6YmBBGWDSIMSOZOePJe+1fkGoKbUOhXI6qnx?=
 =?us-ascii?Q?KsI6VZB9BgGPxnh0uuY7fiVuRdkKMkWzD3d99QX2bzkjU+LQ9n5uS5Le8Dt3?=
 =?us-ascii?Q?4/inai2NZdWe4FD/QPbIDqmrS1VP2AUcTmDizdJCtj4jiSLqWAu8eDQQE74b?=
 =?us-ascii?Q?Oi4vWNzKLpoPAx/2PStkyUKeNb35WaowuPSkWcsp2NLa1d8GSb2UPrzvGdaS?=
 =?us-ascii?Q?NjS1fghAP2+BDZ4ce8OOGjv7QpG2oNrNDug1hccozfbPcHxrXOhaSsu3dtjN?=
 =?us-ascii?Q?9rd2lNaKS1GKLVFZjGe1wyVbVqrdbrP98dS4lQn3Vu2ysT/WTFP6bXNJA55t?=
 =?us-ascii?Q?p2DRezv8/R2kS71Y3gP3NN/yZSugywwcac9ApmmiwHxeN2LKBcotYbQZJcOn?=
 =?us-ascii?Q?ydbUuMaCgPoGYQSEIGlr4q2F4FlkSTn8NlRoasjbbV/Ci1G6o9wI1iX1CJ5x?=
 =?us-ascii?Q?MNAUuY7p6XLDbyj2TW9Lo6YL5j0FAvwH+h21NVGwFU09xPKkCzjtGfpubrZj?=
 =?us-ascii?Q?NlmRV+A0z1hYkpuqZmnSTxppJjgyctbHHGqPC4k8mP+5GRPfouOFbfU0HGci?=
 =?us-ascii?Q?Y9ujDzi6PqER5W3PDtlPbwCZz7020heXjTIqppv9HhNGdk2V89AhJxJ1f8Sq?=
 =?us-ascii?Q?Po4CNkCJ5+d1FwpN64QMVHmxdPA6v/CponSVYbP3DMSkW7NXiZov8iShvIOz?=
 =?us-ascii?Q?aTyhhWJF3Uba0mmBPBK9YRBeynPNULZOdCnqvioijztGWSxyLJjPcok7SBct?=
 =?us-ascii?Q?Xfr6ZdQk44smvXfl0UlpC1I8rcxJMsRjF1EZlGqWlT6dsq/opNMe3CuykbEj?=
 =?us-ascii?Q?QywMSEJT/gUNRuiX4EvHFfYRnrl7biBRVgmCB3wkm0pIPD2X8nHICWBXV/Rb?=
 =?us-ascii?Q?uGQp4rpsHjK9/TfstT19WXY5YSiOIhZ37DLS+APtlBlTkKsiB05Z8lzxWG6c?=
 =?us-ascii?Q?YFqZwfQLzE/DwIlrlGlzUgE1QLKLyUAZyd4ESNLaVM/I88BScv//If/+1poz?=
 =?us-ascii?Q?DH4l0+2DKt4flALeCoYuzi70xU5aQuE2W2vbntOJjq9WPv8xzH7a+8PqjZC6?=
 =?us-ascii?Q?S6ZG0fhpAEHvSpnC4WDDtEAkY0dBxH6nW2U1SxSpYoaqQpuD/WoespU/Cx7c?=
 =?us-ascii?Q?zqzvf2JWL5tIMmDVQHoeb9z51puXH+kSaneEuXQfu7UZr/cXmGC9R9dUpnZd?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PUfb5u8uKjKcw2mDNr/3qV+2Iz1Xc0P1vO2mt1qtIwDPVX3vBLSzppNUc7SUHnx13m4QjaEfOKW2Yfy6vVx/m+KaorS9L8BPCJLWgoe2DMN+1iLJ683QG0bNw7ytwu6DdrSzTZ6jWAWf3oAse9LVOzNH60FEQqF+7hsFZwhQXa5Xirz49tKVjGaL0rJpMCelHIEDym4KPV2pBzWSuH5gXNIP3PODWiH7akAs7IgjwoPkecrWGCfC2nBXpVBmJu6akF0tyODWs5LnkZcnF1zkQN+kuLccK9Ce5ARKplpyGUiacS84SwE1MtH9YW0nAPxX4CDtEP5VcAvVqPGbS3sF9V4jj8wJMkhnMKO01Emjy/dBDtsWeQ6Og4/NzxkmOBO0DP/Y5fSM/9gNcFb3oBHVtuv+FfknOWGN4BktPT08595Bp9CSLqZ/+sU7Pkpwrv7SE2Hv90ktI+2BhveS1iqESdzRbb4QTvIWxTnrZVEUSbVcy0RXcm4Xgp4nLy0BV3rR9Uf3bI0y9fkGNOBaarXuh9EkOVkhb9A+7hSRcdksMB4tkI9/3tVYosem4sZb+i64+A+RWTSxV7+etdVzjTAH0hsGA5QYXIiKVlg1NTwB9piUWuSn6p4dKlCvL12C5HEo48GCO753y4876DxibZqh582Pzy6b05Zm75HylsJxAqv+uv3zBNiqkKy4HMI2ELRsjBgNm/TLOoztNCXRNQ6QhK2NGlOBlaEaTXOPKHy6bNAsI968wjYZNRQteJRR1Ta522+laD8pan+sqOyst7pmXT0LVJfmhoBJDBYvlgg3VPY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf67154c-8006-49c8-4b30-08dbb5a22887
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:13:47.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsfM/QRBoNCO7n8rFV3Eu3zARWVkt1zAEW2Zplf/D0R+va0JKh9ppytrCG2Pu3FKguDC3E5Iez2ulrM5fxX7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_03,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150037
X-Proofpoint-ORIG-GUID: pXcy4OTfqed_cDc-vvx1IV7hnDyG07U0
X-Proofpoint-GUID: pXcy4OTfqed_cDc-vvx1IV7hnDyG07U0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of the code and functions in this patch is copied from the kernel.
Now, with this patch applied, there is no need to mount the device to
complete the incomplete 'btrfstune -m|M' command (CHANING_FSID_V2 flag).
Instead, the same command could be run, which will successfully complete
the operation.

Currently, the 'tests/misc-tests/034-metadata-uuid' tests the kernel using
four sets of disk images with CHANING_FSID_V2. Now, this test case has been
updated (as in the next patch) to test the the progs part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 193 +++++++++++++++++++++++++++++++++++++---
 kernel-shared/volumes.h |   1 +
 2 files changed, 182 insertions(+), 12 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index e3f8ee3e0242..6a1ec0d907e0 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -338,6 +338,159 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 	return NULL;
 }
 
+static u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
+static bool match_fsid_fs_devices(const struct btrfs_fs_devices *fs_devices,
+				  const u8 *fsid, const u8 *metadata_fsid)
+{
+	if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	if (!metadata_fsid)
+		return true;
+
+	if (memcmp(metadata_fsid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE) != 0)
+		return false;
+
+	return true;
+}
+
+/*
+ * First check if the metadata_uuid is different from the fsid in the given
+ * fs_devices. Then check if the given fsid is the same as the metadata_uuid
+ * in the fs_devices. If it is, return true; otherwise, return false.
+ */
+static inline bool check_fsid_changed(const struct btrfs_fs_devices *fs_devices,
+				      const u8 *fsid)
+{
+	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		      BTRFS_FSID_SIZE) != 0 &&
+	       memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
+}
+
+static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
+				struct btrfs_super_block *disk_super)
+{
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (match_fsid_fs_devices(fs_devices, disk_super->metadata_uuid,
+					  fs_devices->fsid))
+			return fs_devices;
+	}
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by a device that
+	 * has an outdated pair of fsid/metadata_uuid and
+	 * CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
+/*
+ * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
+ * being created with a disk that has already completed its fsid change. Such
+ * disk can belong to an fs which has its FSID changed or to one which doesn't.
+ * Handle both cases here.
+ */
+static struct btrfs_fs_devices *find_fsid_inprogress(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices,  disk_super->fsid))
+			return fs_devices;
+	}
+
+	return find_fsid(disk_super->fsid, NULL);
+}
+
+static struct btrfs_fs_devices *find_fsid_changed(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where scanned device is part of an fs that had
+	 * multiple successful changes of FSID but currently device didn't
+	 * observe it. Meaning our fsid will be different than theirs. We need
+	 * to handle two subcases :
+	 *  1 - The fs still continues to have different METADATA/FSID uuids.
+	 *  2 - The fs is switched back to its original FSID (METADATA/FSID
+	 *  are equal).
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		/* Changed UUIDs */
+		if (check_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
+		    memcmp(fs_devices->fsid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) != 0)
+			return fs_devices;
+
+		/* Unchanged UUIDs */
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0)
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
+static struct btrfs_fs_devices *find_fsid_reverted_metadata(
+				struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle the case where the scanned device is part of an fs whose last
+	 * metadata UUID change reverted it to the original FSID. At the same
+	 * time fs_devices was first created by another constituent device
+	 * which didn't fully observe the operation. This results in an
+	 * btrfs_fs_devices created with metadata/fsid different AND
+	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
+	 * fs_devices equal to the FSID of the disk.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (!fs_devices->changing_fsid)
+			continue;
+
+		if (check_fsid_changed(fs_devices, disk_super->fsid))
+			return fs_devices;
+	}
+
+	return NULL;
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   struct btrfs_fs_devices **fs_devices_ret)
@@ -352,11 +505,18 @@ static int device_list_add(const char *path,
 			      (BTRFS_SUPER_FLAG_CHANGING_FSID |
 			       BTRFS_SUPER_FLAG_CHANGING_FSID_V2));
 
-	if (metadata_uuid)
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
-	else
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+	if (changing_fsid) {
+		if (!metadata_uuid)
+			fs_devices = find_fsid_inprogress(disk_super);
+		else
+			fs_devices = find_fsid_changed(disk_super);
+	} else if (metadata_uuid) {
+		fs_devices = find_fsid_with_metadata_uuid(disk_super);
+	} else {
+		fs_devices = find_fsid_reverted_metadata(disk_super);
+		if (!fs_devices)
+			fs_devices = find_fsid(disk_super->fsid, NULL);
+	}
 
 	if (!fs_devices) {
 		fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
@@ -381,7 +541,20 @@ static int device_list_add(const char *path,
 	} else {
 		device = find_device(fs_devices, devid,
 				       disk_super->dev_item.uuid);
+		/*
+		 * If this disk has been pulled into an fs devices created by
+		 * a device which had the CHANGING_FSID_V2 flag then replace the
+		 * metadata_uuid/fsid values of the fs_devices.
+		 */
+		if (fs_devices->changing_fsid &&
+		    found_transid > fs_devices->latest_generation) {
+			memcpy(fs_devices->fsid, disk_super->fsid,
+			       BTRFS_FSID_SIZE);
+			memcpy(fs_devices->metadata_uuid,
+			       btrfs_sb_fsid_ptr(disk_super), BTRFS_FSID_SIZE);
+		}
 	}
+
 	if (!device) {
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device) {
@@ -435,19 +608,15 @@ static int device_list_add(const char *path,
                 device->name = name;
         }
 
-	/*
-	 * If changing_fsid the fs_devices will still hold the status from
-	 * the other devices.
-	 */
 	if (changing_fsid)
-		fs_devices->changing_fsid = true;
-	if (metadata_uuid)
-		fs_devices->active_metadata_uuid = true;
+		fs_devices->inconsistent_super = changing_fsid;
 
 	if (found_transid > fs_devices->latest_generation) {
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_generation = found_transid;
 		fs_devices->total_devices = device->total_devs;
+		fs_devices->active_metadata_uuid = metadata_uuid;
+		fs_devices->changing_fsid = changing_fsid;
 	}
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index d68ef0dc221a..ac9775647e12 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -111,6 +111,7 @@ struct btrfs_fs_devices {
 
 	bool changing_fsid;
 	bool active_metadata_uuid;
+	bool inconsistent_super;
 };
 
 struct btrfs_bio_stripe {
-- 
2.38.1

