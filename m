Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7916CB619
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjC1FcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1FcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:32:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7A19BC
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:32:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S4xbfi026557;
        Tue, 28 Mar 2023 05:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=X1yhyh6GJN+sLA7421cs8HQF9yVSgSZtmIsf5ov4H+k=;
 b=gYDRwrQf0xO026MZ5EIvSY/TSlkGa3FetcaYQoSVX89uhw84M2/DrgnyxjFIYai0tsy0
 +f+aJXMo/qOL9P7z4jLwfv5ECX7XDKaK9KMV3eNN2UL0D0hcyEYqiMa8oBCFusJNM/UG
 v3aPK6J3tCPgFI5Y2Ktr2JXwElD0OZ8UG2t/I0tZy5NATrC/kq0ZJ1qrYL0svsJAwkvz
 LxJwWxGqr9riy81o+4nr8jgPyx8bVqAGyM9scFgT99/RHwCxgzy12NaL6Vmkyn8CvckO
 ZveFdEISOT6ath/xhu/wRo+eqO95zrJq7mtvSOTq5SxvgcnFGaMvbe1ecIbcevfzMl1e ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pksps81rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 05:32:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32S43pKd032313;
        Tue, 28 Mar 2023 05:32:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqddpkdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 05:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5977pXIJu4PzkJudEbGtvBfe8QndUWKSFSR0ssqoDZ/uSbxM13AEUmhDB+gJ1JveNMWaD2Bf2EaQqrmgRk5UG9Fw5I0/rWx+MPf19rxEP1gTYV7XH3kXgGy5hz3vtTGAqlO9CCVXimmKPh5F1khUt40/9RHr+Hdxv52Py3RAkKgA2Bax6sOdm+Gd0cYZACRGXNO7xsUjTv66OqHJwKMtQt1D29Qfx4uiPQzMreWPAFrLFO9tgsvxlnnx0+TLlAaufNrrhqxTw1zesMFQR1yEwp7HJQkcyQg+lUfW1jsE2WgpNClY4GnGLa407rP2NDPLkpg+Z4WoSyVVFnJDn1L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1yhyh6GJN+sLA7421cs8HQF9yVSgSZtmIsf5ov4H+k=;
 b=l1ms6MxEM+vfZH/4gXYH07PWfATgp4j8Pnz54A3gN7lgvsv/AB9eIwpKnZFt0fdw9AzvGYl37Oc9mmlXZiJzkQqeLuaHot7mxKdqSwJAtq1dJ13j16Z2fneUGow7IcR/0rvecGmH2NKo/Kk7vFrtTSDPWrFVp8UASdgH4TpHLjNbdEQpMi7RATEtPlVBANUkiI6PCgoTIcwroADerLf/iubO7tcfLoBjMdyB7M6pRZrnSPeK4FysBaqswazE89Bz2KZjgTAVHrzZEZdiOPDrvEOqz69WdlAv+a68Thmcsb8bB9oMnewGrQszsN+rnlqjefeowCi7b4k1lf5GQrUUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1yhyh6GJN+sLA7421cs8HQF9yVSgSZtmIsf5ov4H+k=;
 b=uS0dEFNLiQPfE9J9LqKygI55gFTlgQujQd7YxZsxXE7/OeI+U9zX8PJH0q429iaJoy2+ZggUsB15z4DO4oyCnr9cWdLGvyE+nzL2Rg5ox0Xb1vatGaQBR3iZvTG92cCKlnpUG02b+7Zsb8loa0zBSSYvDTGnv1Iliy3mgRu92cs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 05:32:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 05:32:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fixup: Btrfs: change wait_dev_flush() return type to bool v2
Date:   Tue, 28 Mar 2023 13:31:27 +0800
Message-Id: <be5e43a3f8333200a69ba85e9c62eb943871c811.1679980900.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
References: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 683c1aad-d4ff-4cbc-5f69-08db2f4dc210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSnAxjdqsXZvWBCGOi5K+NTnAf2WLEL0AXj3ZGVhUIMM+y2R607+USsQW8J8QSwub9rTjrBQY6o5B+O82qsSYm7SA3hl2xQDej9ZCWc0MYC/RG+e2BXWbL3Erx61A0+ZRCLMIj01O8pXY73edH0iF+bVervcHNcLoTYuQfqlX+h1svmaWzg/xqVDbG9xBro6yVTaCGVuFTm9je4htVtDHkUu/xaNxRgh/qomF+Hcr2GGhm/iTWpxGZKdGCd4D/jBUwLPa6qtL7+gUSbUKoNIeIrJAOrFCV2YwqDE8hjTF0ghEmSvxzbRDWu0SPQCeyOKM7JqbB8EtnIir7CNxupiGCiJozVbUrb1ZovnkBSC5bzy6cA1uZ7d8lRbgmvWuHQLZ0CK+IFQkW0sGNfV9dVTuyGKW+YVvFbb3vT4y72+k/ZUaq7JrVdbBD429TOksqxIO+ExhUobe2u1mpu6sB4xW1BxyKCpgIFjBI16yw0LCCcu9auELxdrLaY184KGgVaTb22hKDpYbDbJ6hU+TlnxhiXtpAdfmUlNzjIKD9XLpSQkdGqMQQt6x8OaHxI9X39B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(478600001)(66946007)(38100700002)(41300700001)(66476007)(66556008)(8676002)(4326008)(316002)(8936002)(5660300002)(83380400001)(44832011)(6486002)(2906002)(26005)(6506007)(6512007)(36756003)(186003)(2616005)(107886003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2Ry0/n9iNx160cOo/Sa+xLP1GcIbNM4+OvVAe1jDr92YGgIMi9HhOv8HsR7?=
 =?us-ascii?Q?y6pBHx4APLdzRHjpnfSuR3DiTRSVbJk04qJga3GG536xp471MRwpO0aDYHjI?=
 =?us-ascii?Q?qt/bDnMzBLBQMbFEKhoeM/poYpwk7pywRbzZ+FDXBSHcW2tGbaRBma/f+ftj?=
 =?us-ascii?Q?xGsd7nd53/4LcuVYRxyQ/VImWbwQZXHS1hN8pY2q+jAHNeFjPLyQuWVjL1fF?=
 =?us-ascii?Q?zEpvySw1KgkliOpNcyp9lllFYCab3n/Y9W/qdOrrpmy9FsNBz8tkVJYoIFC9?=
 =?us-ascii?Q?NgUkn6gEGx87uhBzQkNkIpt9UPOFHAAolm7Somyt5J6JzZbZrgLbjI7bVfxk?=
 =?us-ascii?Q?DbjTz55AConjeZ6X6Vqu2MKeytrAMLqVqkVnpdqPzsuaa/w/6cGWV4/wmkqJ?=
 =?us-ascii?Q?MF+JJikp4jNGfiZz79kPrBEAcDsE53vacukHKQ1UcyMkccKF6I5sm7KAqzRi?=
 =?us-ascii?Q?vXX9U0MWUgqdPK3WjN01rv+cJjrO0CAon+RY6/fc9AezseeZNFuF0k9196uG?=
 =?us-ascii?Q?RTqyKANlRKASiUGcXn1MaSDfdaAWsna8qrXRezIw7IPQ9R+0SjoeNRfs/NAF?=
 =?us-ascii?Q?+NpevQRYfDWDMctpdok/CqRSGO9A8GIdsAaZK1IkHsDQd56ISVQSON3lxfJu?=
 =?us-ascii?Q?3YDwjvfDhNvT0PmevjaI6neQ2tDFjxMHoZ3bkuemhmJXOrso2e1Zgl+CedVx?=
 =?us-ascii?Q?1op7wo/hBN38MQJyCC3NY1zE/YANAtnSlBQs1wiAdzN4jIBiD1qx7R158bjR?=
 =?us-ascii?Q?mrO7U7KMibIUbHKMSZcaZ6eeFVLQncVn/cL/F3Dsl2pz7OAq2oBGoF4JNGai?=
 =?us-ascii?Q?mhJ2Wn6ZH6V6a1TVFiBDc7lgRekSCbd3hljCBLkW6aWwQItIiQ3W0uARHXb+?=
 =?us-ascii?Q?61ZHFIV2eYF6fh9FIISm7awv1h4cX8dJCRuRpgXfDmrvru28jpdLywN+/hzT?=
 =?us-ascii?Q?9Ij3dhQ+S5XPsuFtzAcWTlp7AKKvpvCCn73XczJpzkJtzH8km+TIA/WtlJp/?=
 =?us-ascii?Q?0LyVCwSV864lBqA4cIidMnCRqdUswDGeQ1c/hmuJY6LOM9wsyK7AuAK4jWrz?=
 =?us-ascii?Q?JRLL2o3uyxb38x3r0WhrJnM50rL5PGxxsn6ylsaZIdsyKuine1+IFDC4NgKN?=
 =?us-ascii?Q?Hnglk8hlw/4iU6GW4nfMuU3bwmxithVBaHJAgvq894okjUBAyZbmXCUY7wpa?=
 =?us-ascii?Q?h/JibgY5d+r4T2JRlCUiueQGicKW5SPVxJHtX0TMS+J9GizYrr2ojIY4FkHy?=
 =?us-ascii?Q?CCB7xYVULiy1utttuq4Rxp0MzSlx+7TM08ilBHWx/1ApNLeVMSUG/dpdk8sQ?=
 =?us-ascii?Q?8nx0ybC2WEHOoSmM/PMREJUAjvWLTg2mkYI7zCDz0PzQKR4OPzwbKOTqxAWS?=
 =?us-ascii?Q?XgovZjFGTDx218yy3mk62g6/e4H0ausgm5ANo4XrQNswD5gHxgsPhquSCkPz?=
 =?us-ascii?Q?wxBgoCVhqvE8um6E89DF6UjK91DqNbVOjQehwh0RsACtiultx0my6WERuotX?=
 =?us-ascii?Q?Z9+oEi60cChlMsNMYYdrVuZouu+P3wiznXe0zkxhGHpx4r5JILLlZTpvNhul?=
 =?us-ascii?Q?RiQyEnMaWC1qHUAi5oZ2O6KS2ZucuPOZtpUkg85f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T9yjFY+W41AOpeqrBJJIsbMpmx9fkrSYs9QRjPWzzFGf05NokkkqHL8eAmR4mauALgTLBSpjvWFvVJmAyTNfm0RgVDWVC6b5YYZoQLsvpKHBO0LRJz7xq02r5q5UO3L6cRR8xGmp0H4bNt5fBxgwGtMYFd0J2xNfRQD7PU+lkzl/uk/R00nTrUaYB2709J2wPe+KDcbiRbX7H3AIFXaTTFcZx7ty2X59morlll/e0M1zn0srf1j+Gm6Xu/AgqKvUgNv6XjallalBcUKIkwqPS9rfQcPolTEGLdERGo9uJX26c/J9MGj3rs3tUjE93DbzP16M9i2Gm9Tj8uI1vNCV6KK6NYOzjgTVr7ZA4hsodwxZAJqdMOnphE6ROArUtUeXqMfPl9m2w+byvghQJaAjUjF828NoQVvKWCbhm8dJ33l1NzSkBsQhVBwOPjmL0goxGXETRBvXWUXm+EpMiF0J5KmUAIe+bM04TJBebxh8TANhSXGQ9am45qo2+7TggYfvWq4B/D7XKsbrHtK2GV4SMb1RgDFOysqR4zqwYSPwlMCpim03xJc6ZaifcmTasPDW3iPlNDVM8QI2YF7ltjmWr/eLAV/B93MIX0lZU0guTirkG+s8Iki6jqypFc/dfBCOhOmMiUWoQCVc7/8SQeLVvtOKSXp+vtskzRKXIwQiVUixPwpg+tbBw3Ue6fF4cwVq/rwnuwdhtrn+aWoRb4b1ysVoe/uXOZ+5tIMMCAkrWYASkgMFrvaIr60nZOVK6fo/alCiW9N3ljEwopihBlVY6tS61J1xA+0d353Bp7e22YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683c1aad-d4ff-4cbc-5f69-08db2f4dc210
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:32:02.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ohvhh5FVfpWlebd6tyxOXtoESgDBFNwt6cqnn3Ff2JmLep47cDZxyH53Hi8NAV3Q/C30YHepD1+5+kImLMgdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280044
X-Proofpoint-GUID: wGQNwoix9r6Z_3WquxOJDh1G1CUvUfTE
X-Proofpoint-ORIG-GUID: wGQNwoix9r6Z_3WquxOJDh1G1CUvUfTE
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A fixup for the patch:
 Btrfs: change wait_dev_flush() return type to bool v2

In v2:
Fixes:
 Update write_dev_flush() to return false upon success and true upon errors.
 Remove the local variable ret in barrier_all_devices().
 Correct the bug where errors_wait was incremented upon success.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Dave,

I am sending this patch as a fix-up while I am still waiting to hear
whether patch 4/4 will be dropped. If you would prefer to have this
series sent as v2 with patch 4/4 removed, I can do that.

 fs/btrfs/disk-io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1f9e2a2a8267..a240e77448e0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4102,24 +4102,24 @@ static void write_dev_flush(struct btrfs_device *device)
 
 /*
  * If the flush bio has been submitted by write_dev_flush, wait for it.
- * Return false for any error, and true otherwise.
+ * Return true for any error, and false otherwise.
  */
 static bool wait_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = &device->flush_bio;
 
 	if (!test_and_clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
-		return true;
+		return false;
 
 	wait_for_completion_io(&device->flush_wait);
 
 	if (bio->bi_status) {
 		device->last_flush_error = bio->bi_status;
 		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
-		return false;
+		return true;
 	}
 
-	return true;
+	return false;
 }
 
 /*
@@ -4131,7 +4131,6 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 	struct list_head *head;
 	struct btrfs_device *dev;
 	int errors_wait = 0;
-	blk_status_t ret;
 
 	lockdep_assert_held(&info->fs_devices->device_list_mutex);
 	/* send down all the barriers */
@@ -4160,8 +4159,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
 			continue;
 
-		ret = wait_dev_flush(dev);
-		if (ret)
+		if (wait_dev_flush(dev))
 			errors_wait++;
 	}
 
-- 
2.39.2

