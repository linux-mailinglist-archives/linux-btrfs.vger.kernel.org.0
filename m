Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78D76DB87
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHBXaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjHBXaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35AC2D71
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:29:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiJLQ022058
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1hCDuCatCI5f8brB8ax0JFFnmLcQFU6/jhXSFCbPSII=;
 b=CddPZbPNRKYR4CnLjWETgmVBQ+d+NMQKu1ZIEleZB2z2N+CT4c8dMgBpVfPkc4BIpIzi
 iNdeyUpMXDM/cY7fgm76g+Mxcgltqa765TpERqxAoBVogN7SqQckP9WNQlp61j2PkQMC
 jeFYU+pbhYsEq47CAa1nW4OEIP/oxdusf3xIM34n9fBZMg4cpwmblwqQMpM5abi+FR20
 hnf85ykCILfgsDHPDcdfXeI3ggo3ZkS5YzjLYj0P+jFGHHBxwMPRd7MH1Uygw0cPUp0I
 Ve7nrdDnHwiNOE6Qc1Q/aSVCoizj3PTMhATm0N0PcYfqu+ILfoo2JZ3yM8dXyJeQepUW ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc8h20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:29:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372Mul2N006600
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:29:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7f3py1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEPOtOznReKKV+9OBATJ1vLZ+eNswmXyAVMm7VW67IJdwRKeGm3JzBn0alg3ECPRyHLiBcJ9d7WpzgEcwnb/igF3I5zZ+mk8TVc8tDK2N3rXknniy2c/3Nu+Fgw+TpFOWFKIBGdGQE8gU7GvjogFNADbetbx4iC8a5iAxiW6g4lD08GS4USnNax+izn6wURQ3nuZK0vPOgL6pk1EnccGZf1ycKlzPsAEArRl44I1insJlncj17DxmgOHxamkUpoJoXqNNBmeKY7KXpSr5KkmX+d9Y3wLdDBWuXCxN8++Jpk+TBVh2GKOUJelQDw1z4C8ZeWXxtiP2B5EGxAQao4wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hCDuCatCI5f8brB8ax0JFFnmLcQFU6/jhXSFCbPSII=;
 b=Oep2TA89//G6Dl1NhqD+pacWjcTjC9zesxM8OzSc49bHYMnKcj+74L9FHkSkGyIe1QjICSZgWMnTafrfetmARpSojiaRvcMlgHg+InRMFbvHU7i97Mbbm4xHt6CtbD/loxgGsaPtqRh3wzYW0/SNuuASv5tBu9HwGi9kttJDGxj/wmmXsVhXcx+61SrilxPWUjUGdR8wG3+4UEsRB8bL3o2AuZytUUrN0N/4CcMz271s+iJnBsfYimwVqNNvN5tCiGSZcNtYiBX2VgtnW3e0urBks3PlfD/VeJMg53x7xLXvwMcITGQVcN+DyeUYxUb0w0lDhChZHSACtEBdIF+qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hCDuCatCI5f8brB8ax0JFFnmLcQFU6/jhXSFCbPSII=;
 b=mikKOPytbDB+ov0+NBOjbT6jx5/4xLtkoNlOGTZLmqnGQUZ4GiPtVNr41EABtoEbO98uX/NoaeUZeT6423ISGNKGCpADiz1JtZn2GCwbsaqDEazZ6DrkeuM23F/rnTO2TcEOqfMjMz+7oFdExfiu0hF9B9WFmi03KDdmAN3BVvs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:29:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:29:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10 v2] fixes and preparatory related to metadata_uuid
Date:   Thu,  3 Aug 2023 07:29:36 +0800
Message-Id: <cover.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d861aa3-72a0-4e29-da3c-08db93b0600e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QudGiPKw9lb/AdUf0lngDWsAPwgr6t21jukbZM4vTTi85Sz9EkC8OfSfl6Amc4VqEY0imleOEZPm1oMBzYiFUbyS577IyS8YWbUc6ARd+7RfFiykk4adrdUwW5zei/zwuczurTKvyR/z8BFbzhHy1dlWaiCiJtuKhjIdXgJ+VlbOV9Ac6NkTRBndtN5Xe5cvOi65W7GBRBpFzg6Hz5UfQNxa+peDub8G9hPZY5HNKhdIhpzdcY0Qro1mMpjdryvk4mgoxGKkfrEBmN6oIeVJLkJ0sEyOkCjlDgRLk/8uX63TQMkG7hOiceucXWMF1ULhPaPsC4IQCHdGVdaed8FnRAhcqBH1fPLvlPTybq2+GivOT9YXIyuo8lHBG8qTaMCwk1aCZm+f7WfipyEn3vZYbF3R0kh9UUoe4+VdxenDvCLM+OH5oMAQCSiuaYrTozXxGkfyC+1AffVpL/pcFIRbRo7j33tSeDuZL5tNOWuPNPW688zH3ePWwIFWtXbl3YXte9t63ePEoKxps0NXEJt/ERE7hbP1JKvvFhZOJmGWlWWJa3MBBPGkwTkAJzgxKNZ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0of4o2WHSxfxzlFqqFuY7eacUb6n87m7hSeLJOn0ivRc+Cnz5UQb9oGd+GW?=
 =?us-ascii?Q?6LGIYQ7FhMggLhUxJ9bQbU00FC2V/SID8z4toVhrRgRPpbFyCIgmLyxZfbr/?=
 =?us-ascii?Q?lgmfsIkHNSg/rr2QerNpaYZ6svUKo2dsMCndPpTOSlXTpNrYRdFNzVl0r5g5?=
 =?us-ascii?Q?hqXlcQ7WUNo5imstRfFimq46+QjyNq+/HZL+MpDvv4FWBR3Ysgc/zVkXRfT/?=
 =?us-ascii?Q?biyFr3J01GwsBaAp5qPFH7pQ6gQcMX2STXBA5eTDoHxrBMiv2VTA0KB9EWi9?=
 =?us-ascii?Q?gE5sYu53ayZ4Ti4k8PjtZE/x3RyX9tLD7C7QBt6TgUxUp7rfsCD0YdgbxOeI?=
 =?us-ascii?Q?BLDb+x0JhKHNu3VTJSbAkr9Iq41/kNnNGkMVKOOEVUPr+VyBwcQBnFBKIaIk?=
 =?us-ascii?Q?QA0ZO0eH6WKcWojW+X+q1IEfev4yvAR2BkrZTaXLA3mWvfp87uoaUI0dGPSZ?=
 =?us-ascii?Q?JW/ynMdaTuECnloOPsq8aE7l1eQYTFuS2/8J1qY8lEVLslX91NPcdAoLp+Uf?=
 =?us-ascii?Q?k2smBvZQ407eFsjUVesuvP03+ZvG/uH5XJhlmMGoLEb6iZV3nqelDaVjOrIC?=
 =?us-ascii?Q?PpxMMrtjoExW/oPDGLGab+9NnleQ+xTUf2ppq6YF1ZTB4DiPraSnS41TOfWq?=
 =?us-ascii?Q?ES02GtR7nAJ7e7c31YF6LVqxgwp+4Nv4MhrSJIJdm1aANQjFdum6lldw15Mm?=
 =?us-ascii?Q?2pk8LGt7/VWg3BzH+FhF8lQXOQd7WP7gZzwWvlVETWI2AbJPsf2jGjLCuXQb?=
 =?us-ascii?Q?Uvwlo99xcpvZaLvfokK1OqYg437i8nIO06691TCYMYad56vNZiGELUnAlgtR?=
 =?us-ascii?Q?KWQcIWTCJnsnimr3e6BwNnKvmhCH2a/Mp06buTHjemBY/PvrOTCkCEthuz5t?=
 =?us-ascii?Q?o5GsoAfzQCcauaNr2Q6OzDnFi19pmipXL62C3Fz19oqiZdTTVv13gtnBE/Ih?=
 =?us-ascii?Q?J7/4Wcpw0e/jOdbbBVkjT5DWqIva4PLP30gw17efpq96JZG61tfUD3Ls/FlH?=
 =?us-ascii?Q?L70+rqHDuYmnrZ1KflHmc6XkimHShjja3W9DUSxZXH08c4vtQEVnY5ntlTh5?=
 =?us-ascii?Q?bnCaRa14dN3fxXDO6r/rXsLx11jzqEcOBLlbuDoEU2LgQQGsq3+Tl0rhS4JS?=
 =?us-ascii?Q?ZT7tjHLEY66VYRJUYbakg44V6Fnb66k/8nen9Hg7ABoR4kdMFdiOKirT+4nY?=
 =?us-ascii?Q?1gbNurrY6BQEMXAfDQOzzhZ3h9n4Q5ElY+Y+TPAAe2yqRXHQBXwMJcOtEeo6?=
 =?us-ascii?Q?NiVYnBtqTMhvNbKoYcCm5o67wqnRO1eGw9Tj++N+mSJ/qb5nHOYkUYXoXT/C?=
 =?us-ascii?Q?EuCkHbEtt45+xJ6Di/AC6bjPkZmpHhNXODzOnmuQuWjQtWu7EBugm7u4pCr7?=
 =?us-ascii?Q?pPyRW43gS4dYZ+LdNt/2NlRKPC/I2iWArHDLlinrPo+sazBpxLwOvNRFpdiX?=
 =?us-ascii?Q?j9Ion1B3l1AUj1Z4ya4ZQrc8FgWKr2W+bTK5fbJzugJ1k11KLvby/GIMESWc?=
 =?us-ascii?Q?NnEXl3bkBd3SRXSlNNvH9C6MBK5rcdK06h1rM1QHEL3p2ecc6+t13g/sAgTM?=
 =?us-ascii?Q?pGAfPUDArucS70ucfrbHYOr4k2E9eTSqSXoSs86S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aXW3CQmqpZGNBSS1ngk/BX5ckqgBDbR/J+BXzmHk3jF6BW/c62BNg2tAkl0i0Kqyd0CyOHodcc/OZVJX6geYTYKmn3zUxFseZ5rTHS/Cpro5VHQkCF2YGZcs2Xl1h+LPOFAnpXFPvp9TGS/xNZK3roiSmjHQuz6W72zrid+gzVu+lQvCSLaflMcb6lSPORH+C8tQ1Re6S9M2ykxUzeQuxErFnep9MZauNJGOcnLYEd/vrUEej0lA7cIHuy23C5LVSkzqQrWSRl2l6zZvk6Pv42M8PLzw19VMKAh/m0J8Wp6gJ837NF9fPZwHgkwgSpYz7FZqqAWa4AFY9skws1YEgVsQDVPKOQsRkgRavzJcPozTMuh5PbvA+mizeMAHUq7gZB3B1M7EzyG08hiQZHjFfrlVgkl6QIEDjtu5O+EmtFendQlExa9FBZtOEapWv30Ek464CYAxEFLIpnqrIiEGpqT4NosGZcq2B9YVZoFc8Cb1HMWHmq8n2UzZuFjQgVdRusmlU9u+C79ZaNd0z5An0tU2MzERjCgYAx0RUrWLGzkNDagzFrrcvrSqMpUH/yMf18qoCdLXCpxZg4go66HlsqRpeM2wFP6HyW7GX4SVvVDx+xU2OGziPnvuyVl6/tsF144ACe2hNrrVJNdvGTCFi0uBousLzZbqbliMMGiB32hqCuo6y+nQINQ59BwxG+INfPOJD2xeHdzuvocb3rh0ysdPt3/A8A6gQCNgakZypFoOovjH5yM/ATqAml3IyYIYR5djtbCun2xosn5d0Vb+WQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d861aa3-72a0-4e29-da3c-08db93b0600e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:29:54.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA/HX1eE5TUVUDhx6Ohx2DkCPWdVwbm4Jyolw/ESojAnOOvWzoTmOjL41IHiS+TdoOWCrnp6WkAYK8GjT4hBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020208
X-Proofpoint-ORIG-GUID: BmnIw-hNDbPzAKyRfF-F0Z5BFGeuIrf5
X-Proofpoint-GUID: BmnIw-hNDbPzAKyRfF-F0Z5BFGeuIrf5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
Consolidating preparatory, cleanups and bug fixes, these patches can be
merged independently.

Addressed the comments received on some of the patches, relevant changes
are mentioned in the individual patch.

The patches here were part of an earlier patchset...
  [PATCH 0/2] btrfs-progs: fix dump-super metadata_uuid
  [PATCH 00/11] btrfs-progs: fix bugs and CHANGING_FSID_V2 flag
  [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options

Anand Jain (10):
  btrfs-progs: dump-super print actual metadata_uuid value
  btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID
    flag
  btrfs-progs: fix duplicate missing device
  btrfs-progs: track missing device counter
  btrfs-progs: tune: check for missing device
  btrfs-progs: track changing_fsid flag in fs_devices
  btrfs-progs: track num_devices per fs_devices
  btrfs-progs: track total_devs in fs devices
  btrfs-progs: track active metadata_uuid per fs_devices
  btrfs-progs: tune: consolidate return goto free-out

 kernel-shared/print-tree.c                 |  8 +---
 kernel-shared/volumes.c                    | 23 +++++++++--
 kernel-shared/volumes.h                    |  6 +++
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++--
 tune/change-uuid.c                         |  4 +-
 tune/main.c                                | 47 +++++++++++++++++-----
 6 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.38.1

