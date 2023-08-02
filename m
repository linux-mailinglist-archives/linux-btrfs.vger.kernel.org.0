Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A976DB8B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHBXa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHBXaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DED2685
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiHME010904
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Hy5iAWU22itvtr7AoxGKVrYOugRxEPXcsjGk9NcVM4Q=;
 b=PoHpOABYc96LQJp0BJQ5LVubz00fZ8BOMFijAiQDLFQofT8DlSX6aepsqKOHO2x1sLM+
 kJC4LBYA+f5SzMFotUFppU90hXUF0XQBWR0q4HGNXE42Gmf8cm6gkYLrD8Q6xixeWbOb
 zEfOEPndyvwLUL3FoFj5AeJ2A4enS0kU8dMAVW5zPZuQg4XvQhnetAXIlkI+2lFaq515
 /zZLyf3dYXGUjDguf3Q1mzk9B35wmBOGPvkr+Zhoqx2BCD/vyRI5w0Mnh4sikAcD4I+h
 3Z0CXGGgubEQ98Tk4lKfGmM6NAQlpPyM0q9AsUrx5sJUF7HPUl/AqM+xnlxHruRwMZc/ Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu0csr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372N070a003938
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7ememr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXo184KYBHxUwASF45hEdWWUO011FHW9Zu8TktTD8YZmiMgfwUIiOy1nzCtno/7nHEbo0BdiYMJHKnqJHjZNDEJVECc0sMdukxkEKn9St9bNVWPjTVuBlxiHcyh87Oc6DnOBfewkP6SkcxRuk0Qbsuc1nVw5ukiV8PB1Jiy0hTM6+ilqlf49PGWszqtNOtEkxYoQFZ6LYH9JSeZkneSMGe4KQHl3w9xsK32rYLYlrurvKE7XvzBweDXf8+7vucvN7Ax9DvJHKu69nezLXbLnnod1AVSwhx+1AZrwUTRLjUe0r3odurf4wQ9ah/v41vDl2JpXLW4bRS8evXHKfgQiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy5iAWU22itvtr7AoxGKVrYOugRxEPXcsjGk9NcVM4Q=;
 b=Ud1PsjZO/nS5xKyUrmu697T+RRXXUsy4AGFrg22Ulne4dTt9PYqcp1nA5KRuu0KwBp+ov1PKAqZw+EqnW6ttQRNcnwIS2Qo19ZiuvAKeqSqkigqFFOk10ufktzRNgSZOuHnbpmFYllvTZUXITuGRGwcz85tXp+f5SKdbZ6//FCf8hEQbpwazrsqIEfBRwPHMjq41uahNyzotSuqH2TEeTPdsVbx7StZnlUtewBIdNNn68RH5cc85fSFsRBEKKom/JLydiPTUnTQ7+n2PhJ8on8znQdolHDuEuLNfMecLzsl0mi+EzZL8RXGmEFjLjk1OsJiySnNVJuAbxlToDGs7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy5iAWU22itvtr7AoxGKVrYOugRxEPXcsjGk9NcVM4Q=;
 b=CPm7RBpRbfUpuEE65Ay2tvAlqFuElvt/scXXPphOzGy7G/bGgacQ7VtnKOUhVBf7BuDmjYupdVN5WMBc9y0EWhXj2Dhp32wpvg922KPb2nII0n8VCtcnI5Kjs2wosHaEVgZKgJtSSM4EsTL9kbrnwbJjpZg9nZNRuvaYkuhSjz4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs-progs: fix duplicate missing device
Date:   Thu,  3 Aug 2023 07:29:39 +0800
Message-Id: <fc7cb409a62fb54be7ec6c0515e4ad6a03d02bcf.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: ce22c1c2-e200-492e-eee4-08db93b06cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7z6xvsmSK8LgwndXEsTsL06T5l/fBmYFNAA/FGMyYAFMr0rE8qBlfbCRaYYIO9UvO1bybrFfO3n0JmsebhqUtWDCvIIE/E1Xywgpw1GnP2/BbsfDbWLCMSX67XO2t9BBcVLoX85Co/w3duHE5ByG0qRTrikGDBWHR630BN6ufmm0JcOuH2QtOMIL3ycPipyPE/wgingL47biWu/h4XAy+jYvRQ/k1RiFtSQO+O8E5KRmn0EGryxzwWmYosI7PEP6pBuogXyiRsn/ZmKC/zCOfCFX9myayXY0LOlQ7/UZVIvVNpGozKl7jbPlXbUum97Z4RXD9PJdf092Acd5nK0YEcPe3pFIeHeJfsLrOXgQN6DGjIn/hoAYd2iVz9BfYMtK1bpQNINZ7F1Fno9/VxYkjGaEalj9bbLZO5tF1HT672p0aKqgit9y91ZqNuTHuk6mprKQlqYFKXyZFu/sFGfM8onRvnkbDKYuTti1/pchUijmnl9eojdks0mlDuGWcLoM9tYOa6/zbO8TbE5J+NSHGP1UEKcthSm5v6C9e7nReYYHb8UGFZsg00EmMZp14+H1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvBcfk02mCWnM/wN9nuJ03xJ4p22zRY81wNktFZ8LsM7ARKm4o17/ETMezOu?=
 =?us-ascii?Q?8BXDn16jASVTY4UpR4icUDZMecozGNPdf2Q0IUGmdpU8+JcIKiOAGY8WpFTT?=
 =?us-ascii?Q?IezfBwS6RuNxG/4e3YJIJnWyzTC0gI8qAieNwt1/CVOvz9yhXHL1sQkSQEfa?=
 =?us-ascii?Q?oBm70uF9yBBGSqLhHLL86eIAXipKkdwG2ISt+pweGVHgz8VJ3utwgRQBNQJb?=
 =?us-ascii?Q?DK2lyd7TVsGxM5KHdn/ZWYfXkntAAjrknpj/EA6PMOEGh2pWhDJVw14EQqX9?=
 =?us-ascii?Q?5nnYE26iiCD1Kd834oJvJAOUlD4kNGgkH4hQPX5Xoy21pP4VPvTSdwyhIruI?=
 =?us-ascii?Q?8ZGuywAEY3i1CXheGCHjEMOLUG3WXhblCCMf8hL0YVYSuP7ka0cWWE8BqOMd?=
 =?us-ascii?Q?RgYJx1I3tvTVUiTPXtLqAa1OOjYEbuxCzv7gaZvIqk9omCPTz5mfYwKBKR2Q?=
 =?us-ascii?Q?ZdLgT1Jm9fQHBMqHo1egfdHGWCe5eaZqZ3CJqarETr9FGmK4JHOSj7y7cs/S?=
 =?us-ascii?Q?0LxOnAv8SiDTRvyr94hZSjCr5cJmKCJT4biHnf/DThlAiSxYkQS8lFzH9ho5?=
 =?us-ascii?Q?OrW6ed9sLx/F1CIAEVPkl0M7UX24b8JWRLpXbcWOkYWGBPF7mDvZ/H5C5Jof?=
 =?us-ascii?Q?r4sgYShP3ucipX/0x5cTbclQWJ1np9o51l9FrR2hsf8icBEWFA5xEqb4WU+C?=
 =?us-ascii?Q?HeEPHNaR9QWi75ePtFb4FRWcyKBjljqcN2ibHH0bnX6UxIMGkdUTLNlFV/yb?=
 =?us-ascii?Q?AkBWHsJed5RrTfcu7ueoiAOnMZPR/D2gfWRJD1ZFsgxz9N3JjXm/jDwfjULo?=
 =?us-ascii?Q?stRtiVuCQ/IK4gOmUmmrLWk5Myw4mFqhmkwW+JziISwP63TIVZbr7Y53sSAK?=
 =?us-ascii?Q?b8gGFUF6LRjB0azvAvSC0i/fyIrZjS+XkH4yL7g/awSvL20/coTQoKpS4fFs?=
 =?us-ascii?Q?kcbv+Q+Ib/nZXPBuWflmbqqTV+6Fe602lk45lkInVuma0JPuNOVBwpiKoJBX?=
 =?us-ascii?Q?KbOT6drGSkMLd0aB+rR1/UegZcAb9WbVVD6vFu1V7SZhSnmdy+WXetuQa7oi?=
 =?us-ascii?Q?o0kt88GqdoCuxLrPxjP4dFWosKq+25OiUlBQ7m7kCUuJrySfgtVdrBdhOygv?=
 =?us-ascii?Q?tL4ZnkC/h6OGMhUp9SwHGFYSD45EWFB7RabrmQ8eDcHeU0SZZgo7N0ioQdYZ?=
 =?us-ascii?Q?IEhaGtx03Bz7jDXZcpwfggQ4EhQEhSbCDB5hPsF+JCswfPnrEJtd/IRN/7ND?=
 =?us-ascii?Q?P+etYPlDAerGxGlePgTSAcb61tcUJSsFG/Yqw1oSWv+oOj+63EHBH360E4Fh?=
 =?us-ascii?Q?aiiocJSBUwVWd0HS62z9krHRU7NwL+KV0oP5FTSH+1pMi+zxE5Toh0QiTx/z?=
 =?us-ascii?Q?wRWEljwIjxi6txUcelHFNa4U7RFL64GcqijBJ3/CwCSl00T5q19UUoz3wGGL?=
 =?us-ascii?Q?pSGHTNMEzIL1I7AXwPWApnywQZnB0qqeWYD3nItwZsC0oTm2OpEx8NnHwG8h?=
 =?us-ascii?Q?2/lG0ClGWZIf+vnklOliobbTgfeQQRGWYR2NwJPILS5c5gVJwYasyPM7OIPJ?=
 =?us-ascii?Q?10Rxi6neTjn+Rzxl/Zst/9zNrQ19Ez2mYgKc7Opc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o8nG050Mrqv2wI7NgfbSOTYJkAR7r19MWEqRNhgHZokhm2R8Rys9ZB9q4Yk3ZT4wQIdL5mrNLXlxu6VD9gwQs5QaBhqSMrpVr9iPUCgAqBcXtwaV0AwBbyK8KPUUK/2KkDuQ2MPWWj9IHGPt4+D2es9/jPfXQhzQBZFnmjFNBE1mwJVflrO5eSgDm6fbm4UMCCSCWG+pDUXsHhTUf4JBQgE/fJUuizfoBMTVDmFTug9bHTkaCwu2hbzK6DS6fYWu09/pPgrG4ud1OmkMCf9LAkCk9eYW0joWT2ZhxKemyKthAf2mF/6gb+yG2/jVpL8T2PuGX3THzd3q8DYlD857ezE1jnZhrOmmB+y17tZjiRMpLvUU70N5VKbT0bK33MnljRjgxb32DKSlmRoOFYSeafJOlCRCEbFTsZKrecxXN9mJwiLR1Htqdtlo+WKkSqdysCP5PTHDleqnGJHNQdX9NIsa4o5KDWt/FHELsvdCVpvn18yqT4hGDjJeL31g/XtGdGwOB14xBELQRFatpX0UND+kSQy4YJg9n4eDs9b0L5HqyCU1bhBKduSl/6tCKXcnjl+SFKv5D4oLoDEAnlOGVbI8mt1PqP2eclvI49cTYyHvjT0RvxnZ65VPC1ztr3dC/QduH+nSfvDJYtVIhZoiZBBVzT0jr6VGkwxNxwUG7S+BfFt1JiSBqhRLIirtC6+7rhNJeZ7kV/aE3XhuJ+SBDWlIWflZqiVdWiMretYXwHuTVB6/ZGxGc7BvwCLk5uuSWMs2/hXwNjepds99wsCqUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce22c1c2-e200-492e-eee4-08db93b06cd2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:15.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLdHrWY27aLAfKuXMstxecS9zR7uCc4NXyiErsNh6tq8L9ZH5l8+DznBNQ6oDFF2DRMmBD9qT78reZ64YNHsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: eNmZhEafU0pv2oQd-hxdGQjlJEAKk_qK
X-Proofpoint-ORIG-GUID: eNmZhEafU0pv2oQd-hxdGQjlJEAKk_qK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_read_sys_array() adds a missing device with its devid only.
So, any subsequent btrfs_find_device(..devid, uuid) call in the
open_ctree_fd() still fails resulting in addition of duplicate
struct btrfs_device to the list, as shown below.

open_ctree_fd()
::
 btrfs_setup_chunk_tree_and_device_map()
  btrfs_read_sys_array()
   read_one_chunk()
    btrfs_find_device()
    fill_missing_device() <--- dev_uuid wasn't updated
    list_add()
  btrfs_read_chunk_tree
    read_one_dev()
       btrfs_find_device(..,devid, dev_uuid,..); <-- fails
       list_add
       fill_device_from_item(leaf, dev_item, device);

This ends up having two btrfs_device for the same missing devid.

For example:

(btrfstune is compiled with a boilerplate code to dump the device list,
as in the mailing list).

Before:

There are two device with devid 1.

$ btrfstune -m ./disk4.raw
warning, device 1 is missing
[fsid: 95bbc163-671a-4a0a-bd34-03a65e4b338c]
	size:			120
	metadata_uuid:		95bbc163-671a-4a0a-bd34-03a65e4b338c
	fs_devs_addr:		0xdb64e0
	total_rw_bytes:		1048576000
	[[UUID: 703a4cac-bca0-47e4-98f6-55e530800172]]
		sb_flags: 0x0
		sb_incompact_flags: 0x0
		dev_addr:	0xdb69a0
		device:		(null)
		devid:		1
		generation:	0
		total_bytes:	524288000
		bytes_used:	127926272
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096
	[[UUID: 00000000-0000-0000-0000-000000000000]]
		sb_flags: 0x0
		sb_incompact_flags: 0x0
		dev_addr:	0xdb3060
		device:		(null)
		devid:		1
		generation:	0
		total_bytes:	0
		bytes_used:	0
		type:		0
		io_align:	0
		io_width:	0
		sector_size:	0
	[[UUID: 1db7564f-e53b-46ff-8a33-a8b2d00d86d1]]
		sb_flags: 0x1000000001
		sb_incompact_flags: 0x141
		dev_addr:	0xdb6e90
		device:		/tdev/disk4.raw
		devid:		2
		generation:	6
		total_bytes:	524288000
		bytes_used:	127926272
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096

Fix this issue by adding the UUID to the missing device created in
fill_missing_device().

After:

$ btrfstune -m /tdev/disk4.raw
warning, device 1 is missing
[fsid: 95bbc163-671a-4a0a-bd34-03a65e4b338c]
        size:                   120
        metadata_uuid:          95bbc163-671a-4a0a-bd34-03a65e4b338c
        fs_devs_addr:           0x161f380
        total_rw_bytes:         1048576000
        [[UUID: 703a4cac-bca0-47e4-98f6-55e530800172]]
                sb_flags: 0x0
                sb_incompact_flags: 0x0
                dev_addr:       0x161c060
                device:         (null)
                devid:          1
                generation:     0
                total_bytes:    524288000
                bytes_used:     127926272
                type:           0
                io_align:       4096
                io_width:       4096
                sector_size:    4096
        [[UUID: 1db7564f-e53b-46ff-8a33-a8b2d00d86d1]]
                sb_flags: 0x1000000001
                sb_incompact_flags: 0x141
                dev_addr:       0x161fe90
                device:         /tdev/disk4.raw
                devid:          2
                generation:     6
                total_bytes:    524288000
                bytes_used:     127926272
                type:           0
                io_align:       4096
                io_width:       4096
                sector_size:    4096

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Update change log

 kernel-shared/volumes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 81abda3f7d1c..92282524867d 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2077,12 +2077,13 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	return readonly;
 }
 
-static struct btrfs_device *fill_missing_device(u64 devid)
+static struct btrfs_device *fill_missing_device(u64 devid, u8 *uuid)
 {
 	struct btrfs_device *device;
 
 	device = kzalloc(sizeof(*device), GFP_NOFS);
 	device->devid = devid;
+	memcpy(device->uuid, uuid, BTRFS_UUID_SIZE);
 	device->fd = -1;
 	return device;
 }
@@ -2150,7 +2151,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 		map->stripes[i].dev = btrfs_find_device(fs_info, devid, uuid,
 							NULL);
 		if (!map->stripes[i].dev) {
-			map->stripes[i].dev = fill_missing_device(devid);
+			map->stripes[i].dev = fill_missing_device(devid, uuid);
 			printf("warning, device %llu is missing\n",
 			       (unsigned long long)devid);
 			list_add(&map->stripes[i].dev->dev_list,
-- 
2.38.1

