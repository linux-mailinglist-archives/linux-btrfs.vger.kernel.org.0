Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA077CCFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjHOMxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjHOMxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 08:53:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B3E65
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 05:53:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAi5fr031682
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 12:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Bpv1X0ZFZwOe6SJWYLINy3MWLZtm/DnJrEowtxLMSVo=;
 b=VyDnywVdcw2YXQDrr5NJ4vd09r0/6MmAPdyFkgmPa4v5EyFXe2YYsQnfi9g64adiqAfY
 scS2BmI+0yn2+cF5uWn2EQf8ghJ51g18Axw+wiiQdsAxMn4QKz8ONRc+ftG+lHkR8oNj
 MAeoEhRe6JvQBVfLAxU3W/f7qes2TiUadGaYC0goIGwcc/LzyxLzwVJUUz71ZjfMbo/7
 gU0M3mzVNB9JUuB3rUOEM2HYOWyi5MM/svpfIOBSWkiY2pro2pr58zpM7xv4BbADKQmh
 nzMgFuIXqndoSJtM+GbmtM6trE929dRFTOh4qHgHsdBuqFeYvZ+RzZhokr/Z/ct3qiJL cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3144kya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 12:53:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FCZn1s038861
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 12:53:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey7017ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 12:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijvVTROcXfi5SIv0o96QtdIuwV1ahEIVb2IwVT1SVS85qHekTO9FmtAOssJ4DINVO46oj6HGcAsdmdopu57xCsbtM7XzQEMmPpS0uttKLyXWb+IULtufsaL5rRBuWbjZjdxi+8gEYmyMKp1ghHQIRu2YPOrqrnyCq+54lxaWdMMOMCl5uObgteZ05dxzobrm0vVV6DwtgqYpf6Fwm35pxfydpS5P5Rbexr6SsQEXIsICDq/bwIra4tHN6feFT6fx/yZ3Ut9g9ZCCBdvr4RR6+v95xGOxQcS7ofQ0OJi4nejw5fg2I5jWi+dIgDqWxaH7HKfVYygG5CUcUmh7KDkTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpv1X0ZFZwOe6SJWYLINy3MWLZtm/DnJrEowtxLMSVo=;
 b=C9hK95vz34PGgiuzyogBy+2yqzEbPbOHJK3MqWYcp9wm/R4TosQV2L+2Pv0NM7NB2Jjed1+wNHP/jbKvFyTasUCBqW9I4yf48sW6Izvk1eJqTchjbD7AnEjQKI3NDN+PuT14tt319bAJoY4Cgau9LLuq9p7HBIAS8byIh4BywApB6m6CgefyEVUDbhmmJWMdcbGHDJTDNPhFR9ex3PeCX/JtbsWNThiJQf9c3WEnXZBZB6RHS143uN/ZHe4qsbGJerIp8YkObgP0B8oft9nCgBRIN9ytRXQA5uXGHYsiU1TmBsdiBJZNzU5c5KVSW8mQs9ve95AF+HwlHmBif8Z4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpv1X0ZFZwOe6SJWYLINy3MWLZtm/DnJrEowtxLMSVo=;
 b=uHymoQqsBRAgWRZYmlTUf1IRXnTJ5AW6N2hCtEkfDcaYKJ4SDjTGR4C2mHtIb8lJ1mkvpW9XL+UPTxvxrv1cI/6iTfZtRXmVkrLd3D+uBq/A/bIQzj1PMpQLvsNk/aSro2vtpP6lOP2Of/tWa/YVPzKArdBskzWgeCFIG6YHJeo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 12:53:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 12:53:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
Date:   Tue, 15 Aug 2023 20:53:24 +0800
Message-Id: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5331144e-b889-4f92-9718-08db9d8ea76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/7hzSTMZIyt8YnJ91CDU7lWVH+8TtF56SXnp9ovIeweumhjBiejh3b6vWOS+EYEU9nFIfjshLkEqQ7Bh6Y+uUcq4yozrIcQYvUBcviIToD2e/yljmDCFCuQOt6YK3Hy9CJgcvh8X4oMgunHl0mDI5KjCsPx6YRB2Q9fsZX1m3KdO2uGFnybgRVqLP650vuaGro7J4Yj44BKSK73jTdJUI4v2Dy7rhZWWBcn8I4E315ddD1FtU3ien+gUHRvk9bB9lpda+hoAT/xNtZ+oDksnwyum3uODgs+yLPL/uSAKqJIZ+7DkilAGW06H0v3cpNVh6mLVT2GsnTyqkR6rlcr1/dfwI84utOA+LZMNt393ovR0mVFvoo0EULnIpdyFC2yR8nLCZhIk6RU1H7f8SlKfJsieqNPk4gyL5kxD6Uufjr0Ip3qrOiSdgiasCZZKTku8lD0rgyea+v7rsQJ7dUTvGH1Ju4v5TMl6NyTRdGET9QxwMzE2Ecc79LO3ayLMUbgiDUdF+3ewsHBpDFR5fX9c+043+rNlGUv+c4cIr2jxf8AL3ez0CMcO5iQy0ZijRVd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199024)(1800799009)(186009)(6916009)(86362001)(2906002)(36756003)(66556008)(66946007)(66476007)(6486002)(2616005)(6512007)(316002)(8676002)(6506007)(478600001)(26005)(83380400001)(5660300002)(38100700002)(44832011)(41300700001)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqXzV2ZvnHPVhZK9hqf+9fauTuiG4bswlHXY3zRThnDEzouYj6yDA7/hXwLq?=
 =?us-ascii?Q?gaqy024L2NHeCiC8Pd2YumKqbsazWvXYWYSv5RhNnFOStNDU/H463Ucz0Zpg?=
 =?us-ascii?Q?R7dVa/z4yD14wDLR0rMH5khd2s0xxgCuCcxslS+kpVgIPwQjaxXA46p31zFT?=
 =?us-ascii?Q?No4kWo9fOBfx6Rl1z2p/On87NA1I/e9T7urT0Bku242CRDLoE5RTNN7ODpPZ?=
 =?us-ascii?Q?/cPaOjbR6y+9tF4DFckMEfSWMcLcvldU4qNgxpdgA7BcAO44CoEpEjjfRa6B?=
 =?us-ascii?Q?cZ8dNSXoNcKtZBCahQh8LzNi0+PbDFXTmFhZZ6PgCGB6bSWEL7KhWYSNOVSO?=
 =?us-ascii?Q?KWwvyaV9l/jMfALL+NKIy2KUSAJqXR0QzdVKSW3nHK6DLds2j+5g7/aOc1Ow?=
 =?us-ascii?Q?d05irxzqpIFw8WeULy9yYDhpDr+/XXZE1tfiSMwmqaLB7Sw9qL85enzRz/uF?=
 =?us-ascii?Q?EJFsz3U/bdYu5SSW22uI6vEN07aRdDxRNcJl/CjIDmEqADoZbP+JSwti2bhz?=
 =?us-ascii?Q?BfNYAhh9jlw6lvxYqOGwLqVXwSc/fr8x37YqfsTbL/SmbHDeW7Bj7sdUJCEK?=
 =?us-ascii?Q?pOIevgdQIzz20qmQoQi9cBNgcJfHgtfderAyoRR1GP8pMkuI89gark2JCIl6?=
 =?us-ascii?Q?/3C4dsPP1gDM4quvv05qK0eBiivs+JIp0vyce7/sy3cEbODJfpqZVZ3vwgCr?=
 =?us-ascii?Q?54t33cOki9MP/DNW+8v26wI+jaAfKjnEGtb69QLLBYiUNi0UON9mA4OvBkcf?=
 =?us-ascii?Q?tnWgoUVsWa4A8gGd/+tX186hCsr3ioQ8A6rnfUtG4Lx2oa/jBwAL4jtIU3pj?=
 =?us-ascii?Q?cQljGFvCs5TSfeSjj7CK9TFMsuQyGOTN4bA+2NpWqD878ymyAa53MMFyu0R3?=
 =?us-ascii?Q?09hlOOaZrT8Prkg1CkDjkIEcU96W5lH9Pggot+OpQ++EkAdyDzoqtTNz0jdB?=
 =?us-ascii?Q?LGIkx+zKEOd8NH8AssQOPlw54fHljVNJVcRVIyAf6LAPs9x5lCb6cedPKeDr?=
 =?us-ascii?Q?TKtPBV0vLDIq9PU0Hp5CCU5mL796fBpWbSSxQh849+6gbZ6kEl4g/gUMeLLS?=
 =?us-ascii?Q?dbt/QGm4P+uMGl6fqHa1r00/ID3hmbwOlcdKhtOHHbH48YjSrOFR95Z4ASXd?=
 =?us-ascii?Q?h+C3aVn2SuOWuK7DRDSVKT1QkDuZCZ0blE9STRjSqYF0vn2uUKOsdv4X8Ly5?=
 =?us-ascii?Q?X7mMchSrRzngDiyjLcnsLD9vUbcvbYSTwuKtfrJ26GUwxDTjftKfV21mXeAH?=
 =?us-ascii?Q?k6YodXbC4dx+ANjrTXkeoXXthJRsEgbNQoywNAsYm5Rx3YrnDQHkLupCWATG?=
 =?us-ascii?Q?blvcsWuNlt2lDypqbrkeTh7P+TGVCvumbdogsdqSRnYSVnhRlNP6pyhIagsH?=
 =?us-ascii?Q?llSCkQu7qzcF7ZYKmbYOp75evDRl/CiPGnWInyR8w8ZvgfT2erglCmhqIa5n?=
 =?us-ascii?Q?fSrRZ0HQo0MGCXvcP8vcN2r5TCZzjnzu737bg3cL1Rjyam5WPsv28J8dQzEp?=
 =?us-ascii?Q?8AfJ7fnEiJO3wyYA/l80OxdSG4u2R8AmGwEoXAaC8JNOOrtw13Vtu1EofNoY?=
 =?us-ascii?Q?eM9ePidUyheo5L3kJX7jLkndg2AF6A6uJjPpRb3vbHVbgmtLb2y52rW1F94v?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3M7Etx5GXlPPjlOkf2Pvg+XVVXNOxo4rV0BSAjVYX8lwDbBCgJ5ic0tDGg1WoKknjC029MojdQpA2wxVQs2Ezbm4QrxytnKeszXV2pbEge/iI5pSU+29m+QrvWytwlvYNv3Xd3H6kT8lFCmwn1cPmaFwhe87qtrCVn5t3D1x0IdObXc1rdooN37QY4R4G5NSDcZYjuZo3zVffiz1/lb9Lm4f+dSSLuqqer36KLUfoQ1Vr71B895qu3Hg7fh2UXL1/5Oj4z/CbkpWqj6I6Ky5piHoJ3w4wqBfW1xomdmcv2KwriWhAdZKm83cx7AskeY24BSE3swDYN5grxWROzIP13VcItGF9gPTknWK5Z8aWD9AvLSO5T6zRO0GsgMkCMlkhh2tsh5mHTSbhEyKYD4Rn30Kndd/qWR4d3CdbHovpdu+9rm1alwzzli7M3xOyNCAaHrHy6Jm2zIe3GAC9VdiVE8CXbHgyLb99DwBCw27PKk4GG9mZD2bZKyoztCvevXjPmPoiGvl30wBxjq8SZSI7MiGoDysV1/+6p7oijdUvShcUYY+VQkTFbZR2bdlc+E1UI4K8tolFp2lRt9vmzIRCbiDut6WEFWQJz/3HFse7N/gmsDfg3e4Rj5UvkQ7xPxnBYcd63xwYkOKYmvanxxJCIcgbcQ2jdYrcy3K17j1uTQImrWuwpbdujNvG1HUzGf1ET+41vKUbxEi+LWIQ0aniCmkaKdzdTDkKuFl5OMbLeAP5A6Y8pdYWD4yM0I1vlc1fn0W4AgRC894CxH3K0WSEQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5331144e-b889-4f92-9718-08db9d8ea76b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 12:53:42.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s2J6roUvO9qwGGb3F0BnAvaj17/kweI3f8FBrysz+fHNOWrkl4Pzvc3xnAysdpVqepR6xv58X1vizTgeAGjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_13,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150114
X-Proofpoint-GUID: Lt0_cUnNh_CEndG2z-BYJ6YrY7thQ_F6
X-Proofpoint-ORIG-GUID: Lt0_cUnNh_CEndG2z-BYJ6YrY7thQ_F6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfstune -m|M operation changes the fsid and preserves the original
fsid in the metadata_uuid.

Changing the fsid happens in two commits in the function
set_metadata_uuid()
- Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
- Stage 2 updates the fsid in fs_info->super_copy (local memory),
  resets the CHANGING_FSID_V2 flag (local memory),
  and then calls commit.

The two-stage operation with the CHANGING_FSID flag makes sense for
btrfstune -u|U, where the fsid is changed on each and every tree block,
involving many commits. The CHANGING_FSID flag helps to identify the
transient incomplete operation.

However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 flag, and
a single commit would have been sufficient. The original git commit that
added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for changing
the metadata uuid"), provides no reasoning or did I miss something?
(So marking this patch as RFC).

This patch removes the two-stage commit for btrfstune -m|M and instead
performs it in a single commit.

With this change, the CHANGING_FSID_V2 flag is unused. Nevertheless, for
legacy purposes, we will still reset the CHANGING_FSID_V2 flag during the
btrfstune -m|M commit. Furthermore, the patchset titled:

	[PATCH 00/16] btrfs-progs: recover from failed metadata_uuid

will help recover from the split brain situation due to two stage
method in the older btrfstune.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 371f34e679b4..ac8c2fd398c2 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -33,7 +33,6 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	u64 incompat_flags;
 	bool fsid_changed;
 	u64 super_flags;
-	int ret;
 
 	disk_super = root->fs_info->super_copy;
 	super_flags = btrfs_super_flags(disk_super);
@@ -66,14 +65,6 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 
 	new_fsid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
-	/* Step 1 sets the in progress flag */
-	trans = btrfs_start_transaction(root, 1);
-	super_flags |= BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
-	btrfs_set_super_flags(disk_super, super_flags);
-	ret = btrfs_commit_transaction(trans, root);
-	if (ret < 0)
-		return ret;
-
 	if (new_fsid && fsid_changed && memcmp(disk_super->metadata_uuid,
 					       fsid, BTRFS_FSID_SIZE) == 0) {
 		/*
@@ -106,8 +97,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	trans = btrfs_start_transaction(root, 1);
 
 	/*
-	 * Step 2 is to write the metadata_uuid, set the incompat flag and
-	 * clear the in progress flag
+	 * For leagcy purpose reset the BTRFS_SUPER_FLAG_CHANGING_FSID_V2
 	 */
 	super_flags &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
 	btrfs_set_super_flags(disk_super, super_flags);
-- 
2.39.3

