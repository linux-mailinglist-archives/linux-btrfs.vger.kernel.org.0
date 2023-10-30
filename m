Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9E7DBB88
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjJ3OPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjJ3OP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D498D3;
        Mon, 30 Oct 2023 07:15:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDWdmQ029604;
        Mon, 30 Oct 2023 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=izLLPmALOtf9gtIjDggcXTcGkybV0UPK230Q4NodRj4=;
 b=QOAN46A5ii2pJa9ZFHe2Gm++501pFT0YJrfxdaQ7XFqONzu0HCET3dzCKTI8jpBixQpZ
 4VuXKpO3ydk5CPxgyguvw9nfBqwDyAwpTkrNtzCkpItdfomH8sA3nnroFXoIpkY7gyQf
 ECoLFmXRWZMT3A8aHb7UVLKujkPty4e9HpEBIOY4lJp4DE6a3LMNy//XRfRdGE0BC3rm
 WPIBhSSflkorRONcW/kME3CVXXntsodyf0OIN9HqzNm3wtvrFCzQSh+7TFPpypZCsCsg
 B/i7uDhRdSAVI9x0Y1qmsuFmQjKJvlaeoCGS3L1P/86lvtAtnEb9biCbDoOucs7l9+8M qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdtvx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3QV4001099;
        Mon, 30 Oct 2023 14:15:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4p7b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T86W9lBQGHfi45oST1p1WBuu8aP2ERlcMPjFl21wT3cd30xlrRMbWIWZvHp60KrmU0cJzxkuccu0C5fj6Q8fLlgn/Tcqa7m2fqM4+fI/OH1WE5EgfM/Lg9DE+F9ZldU07xX7B80+I6bOxYMIcSKsvATxr78XaWktT6tqpPuQTS7yXli+3Gu4GE7qslvi5ZCHomnMsgsOQPy4hZNUksZZl4najpQ0PioM1Lqx+PIZ/6rvpo/7q+GBBWQMxbpi4/b0PeEPBiHIOj8Rq4uXjchlopX0CHhp6sawneSH+Mv0I9f2KbN2EayOzNUj3wJMzuC8DeEn23b0Rj68UYEfOqs7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izLLPmALOtf9gtIjDggcXTcGkybV0UPK230Q4NodRj4=;
 b=nubQh8zF6wiMQo43kk0UUzzcky5/06Mh99If5Ukz+OeNMEzaPXmGFbDnsVKwE4hKrFVsk5skM3lOzV7F7CawHkYYlsAbqj3QCgIDWf5sr+Ey5LI8Yd9VfxcA4kO3ydzg4wodGFmWY+R58dIOPbf8SSQmqB5szi9uBvLVww2hUNycaEkn6waUePqEAVl3RxWe24hg/pmrQgO+mUmdX5pX239ve9137gl8azlp5sCH4iBqsMEmAjM43WGjROzOTA9o2eYmWAbgxTTNFegjmObZnKbZClbtWegUztDhFPeYZHZhAunlWCFyQUXjWdc3KqY5v5kP4KTqMy2ye6lctDcZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izLLPmALOtf9gtIjDggcXTcGkybV0UPK230Q4NodRj4=;
 b=JEcqNwTpAkQiiCaC4H9TeBdnCCb3x6XUd435Z3FZMjHDAQ5xHuOdNoWBOnRZPtRObs0FI9jnFTNNjGptcxHScMdSvZvHO1cstMuBSfquFbJcHE1cc3/yId12YIWc0X0I0xhmcIZQcBTz8PZFU9Hyo+aDMfZCloYuY71OZSPptaM=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:13 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 0/6 v3] btrfs/219 cloned-device mount capability update
Date:   Mon, 30 Oct 2023 22:15:02 +0800
Message-Id: <cover.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2cfb9e-6354-41b4-6c40-08dbd952a24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3mhf2MdyZv8OaNZRKR1Rp5v/2sep0YvmW1HODs6Z886mmpxpf5sfsh0q3TdyFC42yhbFxbtGy2VXsmHhyz2Go3HYoIvRDET2d+193Jce2gYrtTDCW+d6b6DpYg9luXF/+kOkbqjm+ONkTu19BtHAiKd/2yk4v6KpZgqiDktDUsilYa8aRIVif5oNIK94vrKN28PX/A0oiCiFCTST5IZR+sye+zdaagbyyJl3K1XYFUsHIPkgQZdHFVg879+Syu6R6nNTiz0tF+8iWavTRxg3vfb3oEGZKq+eCNMGo8DMVKadugiDZ8UV4oHUcaxROEUBMi+46n08ejCdnISBtSRm6gvhvDUdtQXZ4vOl7iWHiea2aybHYxU/YbaaSEadQQTZP48jt2AE0r4Kb7kNjjwdE5gk5p/TTJrmr/rMQyKTbEMGkJjsasIkhT/i2HTNOvF783rdJpD1ihbQja8M1HnANrO9z5ZPGoJFvHQ4WXGr+t+U2MeJOLQ9qCRUZMDlp5WN/OxxySzL88+Ndxb0b+3BjmwCZXJdDGkwk/JuBK6O+2dCj07Q/pYM8z2sitvc7/j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(15650500001)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcKGJXTOPJ71KQmnTwD4E1BRKVnTZ03mAkylH4G08iS/+iU+u6Yt/wmX/cZW?=
 =?us-ascii?Q?fxi6KGLX7uqQWcs5Evh6GynsBbRBsqO7ysZQugz89YqCAzOiN+7STVcIzJmz?=
 =?us-ascii?Q?HAqqRbhfuibvj/ZsePNRe5+2DawJiwlz+T6PG69DJdJUaBNoXnM9F+0B8b8f?=
 =?us-ascii?Q?CDJmicbii+268lEP4gkbW7Zsl0lNzehheIpbFop4xAOKo6poboHd1obDdWDg?=
 =?us-ascii?Q?pcPQ47B7EJKVwStG5uG3P70Qi+VPnuJX69qwvnLmweRvVQug3FFBzm4pnxGQ?=
 =?us-ascii?Q?4gG1LWf/UDcEen7Wn6fXrY3adxoskKJIujFpgqcbon40AduOSrzwpsCOLnTL?=
 =?us-ascii?Q?f5y10XZCBnSWt8sq4KvI+k8tPUaeV1cil07ScAsXlRemqWIA280lezAdoAav?=
 =?us-ascii?Q?FQ2pHI59FL1wQXqza7oW9gzbVRPlIZhdZgkQmY4QkBJrWTMmfZiceYDpZYq7?=
 =?us-ascii?Q?upQx6mgRYM1w3vxP5Jzjyxh9pFcNEKxthhqEodTcIwp1BbkpcwhDgLclovxJ?=
 =?us-ascii?Q?i2BOHcBIGF42Sav3jIo/5S5imACyiJeD1eT/JlUubRDnjt2vD3nrzbj3abOs?=
 =?us-ascii?Q?9RgLSH9beYt/KLYbcbzQrRdET75+EpU5k5/FiERMMWVa9YWDUDQacy1f6ygM?=
 =?us-ascii?Q?FFBS2CCAXhOZccFgJCGRo68MzfZvg/vebNhxf0koyxUtTfsmHYCx81eWqj6p?=
 =?us-ascii?Q?hbT90M1P6P/d5uKztep0eC348ARSPO2r5o0rY2sgg/qBZBlrvFWoHdNt0SWM?=
 =?us-ascii?Q?MIhF9H9ItH29E40bsTTgep0cSdojhnnnj+xjhMjouke6V26xHBPf0CCtTjE6?=
 =?us-ascii?Q?4MFntZSOQer3ZulgjileuBwEtLauJjYyYavUOycAbQoBMMREoGN4myb3/HpR?=
 =?us-ascii?Q?fdO7DoMzL/5yNdJTps2RggtGercE1smLxnuZ770brojE4cwcsz0fm5wGK2sy?=
 =?us-ascii?Q?J3OWPzKZtNdWdJVz3+YxIN1Qw2wKdSH+qKhzWSTOvrt7oohccR7sG0V+wjhf?=
 =?us-ascii?Q?FQ93HWpFG/nE2fhorw1UTGu2+FIFAlRh7MvrvtsTtvcQp25cgqZLOtXpcVPO?=
 =?us-ascii?Q?RT+R0/oBmtUVzPcy19HdLOzGDmngvZuxprWJAGmd8Qoy/T0odFBy7cVvhfUC?=
 =?us-ascii?Q?msP2YSh9LGVhjqZlyXescVN2RF2aUqQazsxB5goGZt4Sfs+RvzUhoGPxKjMg?=
 =?us-ascii?Q?BIT8NXWBTqTPR2Oax2FNocAHSK1X9ijRVtkOIxXeTf2KUfT3g9QOj+ngrxA2?=
 =?us-ascii?Q?OCOEgVUCOAOo9U0sf8ELLjAdFb7CA+Y0Oefkk1SCvHdFvm4ceAYzXDX0bNmw?=
 =?us-ascii?Q?exf4d7mpF/y0XxlwhwFH1f/You4dCz0pCbqHJH7pkys9z16y96YiYz1KRq+e?=
 =?us-ascii?Q?kkdFl7YKxVaqKKaBoJpmz58R5SyQQB6slVi8Q7EU2ubMi9Fsgbv4daIFEBLn?=
 =?us-ascii?Q?NdoA9JqN1Uul8yb3MCHzoksCOKthKV2yAhV5qZOMu9lX1nNTuf7NHasY+G0x?=
 =?us-ascii?Q?NR+79e+a3+R+4HmZ46HO/2jxgh7UFLkZnomrL/xgsn9dcdEpV/qGJLg1p2BV?=
 =?us-ascii?Q?JGBeY0ilJCY74RB/T3koSbtJCzK3EPVD6VtWHqi7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y6l7qXcLlgyLJybjZ63OO42VgmW4dOKs5RHRRa2MAP+U8u1+A0cwKFSnix82aBTJFrJApMttGNgUrT8kSz0SCOK+HSJIaboxqi+uxlY/MUfvQxkrYFYtQ5p+Hz8vqT0seLHmB3xS6K/OtmiYo71bRwG1NKBLfIPgLUL7lMcIMtkmTSlcyqxi9qa96qUnC1dSo8dgSV+rEv46FxjVkjhKIx6KkLD0R3NNs77FJ9n1QJBsXerJlb4G5b8MLyqkd/+AcLumYEArWgBcNlFmlDuU7ugnpsGMY9sNc1AqPx6QbNZe5RVO145ce/oevQw4ioAOONZ41uKRWiSmqs4Mmmn6ff7Uh8UENLEFmEJ2R17PeTX6tA3tdqApmEs6HP02faDSqUGDpUiczGUo+NoGtT4XiBJUjyUrMWsculpkbTsplnikZT6QJiFtIHPvCl8MFiL6+2BusK/OMq3o+/M9K9DiD54PqZ3/W9AJnUNIcQ6ErAwlmXDesgSbqZpvzJPf77e+NfvINfRQyl9Nh3MyLlLbOZttuaD2UDAkt/7bWPy9wjoOG4o/8C9/Xaw/GxprxH65l0KfD+sh8Zbh0OkIeJ+MfMtw3chi9YG8Od47sKEM8OBB0Gq7FMD0U3bDK2PpBrPJV0obAsvhEzqGJ3yHZMXrkXyYcm5OkNCQzKzg22bA6Y7Dd5JwTSsKVRh5EH1NcrNProiXGG/x79nr6X9qvhFsdCg90FajL/QhSVV8lWs0sPZDPynxPkh0tSuy7hDTJRxfVAK9NrrSDshZckugtv2l9gjs/VuWVJbPejDEsk4/bPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2cfb9e-6354-41b4-6c40-08dbd952a24e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:13.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsD/XJWdoHe3XAs4kEJnv4QSzt7kDE1lHjLdhyNIl3qGxhIr1+f9UGRvSRLhtxsFfhERy1ZMoRjtz3pCP6GeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=889 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-ORIG-GUID: 8g_WOrMKB__z64-OQvxCksCue5jsKjin
X-Proofpoint-GUID: 8g_WOrMKB__z64-OQvxCksCue5jsKjin
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3:
Split changes into smaller discrete patches.
Add a helper function to check if the temp-fsid is supported.
Check for the second failure only when the temp-fsid is not supported.

v2:
Patch 1/2 has been added, which performs the cleanup of the local
variables and the _clean_up() function. Patch 2/2 in v2 restores
the code where it tests clone-device that it does not mount if the
temp-fsid feature is not present in the kernel.

Fixes btrfs/219 bug when temp-fsid is supported in the kernel.

Anand Jain (6):
  common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
  common/rc: _destroy_loop_device confirm arg1 is set
  common/btrfs: add helper _has_btrfs_sysfs_feature_attr
  btrfs/219: fix _cleanup() to successful release the loop-device
  btrfs/219: cloned-device mount capability update
  btrfs/219: add to the auto group

 common/btrfs    | 12 ++++++++
 common/rc       | 10 +++++--
 tests/btrfs/219 | 74 ++++++++++++++++++++++++++++---------------------
 3 files changed, 63 insertions(+), 33 deletions(-)

-- 
2.39.3

