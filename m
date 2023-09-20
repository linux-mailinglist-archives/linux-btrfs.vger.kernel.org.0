Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557C7A8EB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 23:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjITVvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 17:51:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502CCF
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 14:51:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ0GE003965
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AYDhyp8rjkxVudQMDX4LVXo/NS8mTpQGggejKwONcmw=;
 b=z6e68ncQUrVVM0ZlhjZNzZMKYs3l8MHdsvDwxHaCBIrDY1H5FTbjGiAdXm7uADFwowMo
 LOh+N6//RJWbtONZKwsU6N5lKJujpkU1X8ku5m4GrSUC9dI0dZSIAAYPLKBrGqL+2SgM
 qEs4d2wsT371HKqDmI7WYpB2FG3il6xfhUOEWGb75/5hPvKfiC1KMwH91VsaAQ+tHkK9
 tWyPDJ3NP8Xl4PkiqoCKPzPQMQW09hxiw740TC/CnpucloQ7sEjovqh4SxYTKZeOdSfO
 fwbz8BogwUNZJaobgUolMTedYQ1itVayOFpyrxR7UREkFZKhw3sHZ2VuoqFYk27WOkX5 Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53530g6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KLo2aT030751
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7pb78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcmyNsakKEQq0iCwaVEQ3pNP/IDWbzsSK3d9sf4L9tqaa8xrvakT/6dTyBtcXWnl321kEFSXgssbwYQJhxAQJUm+EntexxY2rr8nX+hDcyOkjhdC0qDTTLvFnH6IWQX59fyV3UpAvFXWvpFcjWFiO1Tz+im0Qe94Fv6d16+PC6YUDfJeHcrXyM11/P9D89fd8rH4pjp93AVVOOUJcOVSXDZtiCL1JvIj/0SG/JIEiubM5IxlLW3S+Gq7+QGm82U6jbBKJ4ws8WQPhR6nJMbpmt69RHlnlJhlgNRBsxCOgZEGdcmNlpbNQKJzcr06V+iAby4Y3y9gYxr1Is/1lAZzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYDhyp8rjkxVudQMDX4LVXo/NS8mTpQGggejKwONcmw=;
 b=KuqcLKz/Hoi+ncLZb7raLAYWA5g+JJE9U01b5nRzcvvuovbwUZe29WUSHgxlezzE/3ycZJSox6+ah9pNMyLnYXgdu+GM9K5dCkVACFYEjDBrhEdT8uoQcJTBJwOv7jTbtvZtOPSQMnVOz9Tz3kFcg8zY+J6HQixr2UaHRan1jWpTCYUSQzyXdjOmkHXRP9uQJTdjevY/k2VzPT5so4NUpWN6X8PrPZ942Ns9FTwu16cTc8IWPHCSuZrpYjiV7hZmN5Skh6vLf67pl6k6jC8epMoV693jnaeFEkkM19Uh1ElSx1AXfo9DXodEdA4QzhgN4PjRR0jNx+YLBvzec+mFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYDhyp8rjkxVudQMDX4LVXo/NS8mTpQGggejKwONcmw=;
 b=J58gLmSMD4uq/Iem5J4leg8OPaj92QaGFDhBaZb1WIW5fxDzbqaylbI8v9J6qbbkSICSEMqYuS+j4y/MauFo78+pE2EXJyz0HS9Rzk03dHxGoaAdbX5yFYUGNqr/CFyVAdZc1vduvX0fiFYfE3YYpMVcHmjSAiMdSQeuW6Ry5cY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 21:51:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 21:51:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/2] btrfs: reject device with CHANGING_FSID_V2
Date:   Thu, 21 Sep 2023 05:51:13 +0800
Message-Id: <83e6a50ea2040a27e0dc05a09a9213b79e8938c8.1695244296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695244296.git.anand.jain@oracle.com>
References: <cover.1695244296.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a0caf0-8d1e-4446-3db7-08dbba23c18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DCKiJhQt6mRvB1FarR3QvcPfau1cMObzte9UVNIbEJEpHjPZ9nU8IC5G9AvBlomFJxNA8N8GeFc4KE/cnm9AeeHZV407jXZQVDc2sH+BVpAyd4kd05yIsyHkGjjA5jSYjXQB90YPUdbShFdf36c6Yl3Aq9Mu/4ndBUK4TOBodNyJQqdvXOA8k0evUtMhB8LaPGs84dLGrSzVtE9nmehloivxknndM1FYzb8/wFYrfl3YX4exIZq5fiiU/Axan4z54U6OA9yVWe89WybN+E0AHBiwrHYROyzsr3w7boelKrnfZFGujsbKOq3LW4euoWIoDvzyq45F31h4Ie2h3FeY0424Gd3BMeIApGmwbVOYBN9jolL8Syd7sasQz+IrVMvzvvtuAi+uvaJwxbF9ujAPTVOtPHhzeKYe3EEWd3d85ApU9cHvc+FdzubjQCiYaX8UfcNtCumhzLACtpreE+0WMybV5GAj0X29NahCl9hbHHjM5PeV7ibf1JCR4biXiGC/1eQdr2ygRYEmSN+cK7+8V4geVeVdSs35GQ01uodobPb4DXSMk+idg76XaLbFrXD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(478600001)(6486002)(6666004)(6506007)(36756003)(38100700002)(2906002)(26005)(8676002)(44832011)(83380400001)(8936002)(5660300002)(2616005)(41300700001)(66556008)(4326008)(316002)(107886003)(66946007)(6916009)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpUDNYS2Pcq622vTUBzXzWC2VF7Mm7U3pmN3YNo6pZIJZAh7qr5Me5aq67Ax?=
 =?us-ascii?Q?+ykEiGcQUlhbVxcCmU4DpEJtNji0uFnoR0qluk7A8I8RGEMOlP5cInwic4ki?=
 =?us-ascii?Q?S0P3Di/1EzA5OiUsspq6dYZHUueQFrlrmOkFOWVtEAdyzeKZAvf6iSh7H1d/?=
 =?us-ascii?Q?0UZAJiFgVHFwUNd+KaQNYLdSrYASF5a0fDPz0lqRKrXx8utEADdlllABjakB?=
 =?us-ascii?Q?6b7MdCvac9KxorUoLCiStRf6OoLwQx9/m9ydgeJLcW1irWWIDE5WuZvmc/WF?=
 =?us-ascii?Q?utv2qamWBSbKFLbselnhfpC23RNYxsIdf6sXTvB3BOKwsqQMhH5n15YqtXgF?=
 =?us-ascii?Q?/OLSGiFM3yMs34j2s4I/bts9w09fmeJxTIBKrtxUD4JwqztRh44ZXhXEiAlN?=
 =?us-ascii?Q?+dLYhPq1+OsBVPmfABlYsNQRtWDX1utFTnq6knY7KkPZO6xSoOnp8D2W+7Yw?=
 =?us-ascii?Q?7/TEgmLa0tzr3y6u2lQ6VWWgVuaOa22JiRbjE6GnEQ3T1u6tBwydc9bgGUz7?=
 =?us-ascii?Q?bWUm7w7Ybj4TK5LgUilDEgJaBemj6E9VRvGvIs/X/2FQu8kmCnlZiiMUE1Fw?=
 =?us-ascii?Q?RnAfaEoGu7d5Ufw9gNK64efGRkKeYFCQZCQv02K/8SEliHCMXiBDa91KDYrw?=
 =?us-ascii?Q?lbI4QUFc8MlRUDw119zK50YVk9rR3EE2TWAhskjsYRIPfCvWlvJDIpnw3F/E?=
 =?us-ascii?Q?S7IsBqyuWJa4g9Z5YljOZk6I0TL0IOe+H4efa64SNuEacptCp0y7GTOaVF9R?=
 =?us-ascii?Q?zxUs3bChptjSPcnB3VpVgBKT13z87gVtBsmkSkXm442dh2zebNFfZt6kV9OS?=
 =?us-ascii?Q?/724sjhxXtswg/x1IXns/+qbvLID/GkeZ95SdZgDccpTkGbJI+R30dsC4ylc?=
 =?us-ascii?Q?AS77Lv2OBWTdcuOw3TInDxL4sUYZv//mECPqD1LJYGRYhdxiOhT2gIhzq727?=
 =?us-ascii?Q?oSqXMKIbt26CKbKt3ncsliAXjLwBD7+yuO2RWqPc2L30v+f4sKT8adM7ZoQO?=
 =?us-ascii?Q?+O/HJyLfHH1EPbRnnN3fS8FkHPXL0G8pTycfVfFhebJZTkBGFmQbJGikas4C?=
 =?us-ascii?Q?ObIGYjg+gaMKugL9R3U86kXvdIZTm3BN3GuHxFiwt4cDjBj8gY70Gn5/63pE?=
 =?us-ascii?Q?AMpESOqRDIFM5yDu0YYv/AstcPMfG9B71r6QWrADJiSfuR0rCT9pG4Fxluqn?=
 =?us-ascii?Q?iAfutVOIXfrdKmgl0lflFpz6AQmmpAFMq8Enl+fYA+36BRLloLImDjm5EAJh?=
 =?us-ascii?Q?pzonZxx86XLknPGHN9IjdKYbsxrseJjrbyYSLHlyxi4Ix6b1CZQQt7Qe1aaA?=
 =?us-ascii?Q?2XezOhKxUrcnC3sRF1hNXTnRxTXZBvDP6ewDDgz3IVQDK2gdfuHzLcIRwwaD?=
 =?us-ascii?Q?IzM3TA9NO+SdiqrScg2lSEb7RHxqta+F5BY84FrPzO0kcNAXzbq7q6f6fhkU?=
 =?us-ascii?Q?aIAoQqEs7GyV+/e8ZlbhJXFAQ+BpPXuI+p3gB060X7UfSOPFqJAZfpiZVpG0?=
 =?us-ascii?Q?dqD4MfMt58KfsuoHEdUbWK7p0GVbBFLibdxBbcLYOgXgmfh5UFgyWoHYeyoj?=
 =?us-ascii?Q?JkQ6nrIDJcRHclk+qarhm30PgSbGaquNLIyN8UT6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zJJKRwLpre0LWrREjHHKoxPRF0KqUmuZ5jC/A/rwlHQcbIowaAXTG1CMEcCepV0HGaqMArlYVOKR7yKNK/Avsi2Achx9e3AgZI7vzdsNY3DQ4IZyblgWo0+ePMZje4Ul1VVTkh3Lr1AyoKTC3LwkKcRvInLDKx0UOPkuJ0kVP/KAcj2ii6BNCsKZGG57chpextZEMG2/X5gipOBcP+4N1YZjI70BUXThaHM0phsO4p2scX+POfQx7tF003vwlrWnYNdFkVE144tpfTsGpaUFH4Lz3uiTxB08gEqAkEDZvZyMgJh61OV4svYX9WxsoHINlpkgGcrfOP176StA0FMGg2cHvg/JWaoh9c8YrNm64SwcjtQnOqXpax0aWFeUPPHjqlOeFN14SJtLhsgZwM7bjCojA2sO3euYim82nLyCqYEvPmMKl7PGkf63IUebNjyM/7OfnrWGrQhBZw8J199/6XeWQEWK08lB8rYMRABpEzMiuDf7rU+pZuOcH1SpT1HF3hbOf34di/hlcTTAcf/qORMuM5nQ9Frhw4g8+4MoYOPnpbIcyaHVpcIS8PRJTX7Yr8XnoADnSM5XmE4DVtihGtiNE4rOPEshBHwKOsq6RFNg9rFhO2b/FZKyyU08dLtMLOY8HWEZ0uOl/OFDEGly3HBCkgVyE3ave6APiCeiJhv+LmP8vOBf4DY1J1ntVHI2Fa2szdT2qJXsq6bHPoKxUe+WNv/mKqBrvnu0n/vusINJBn3p1w3XAcA7o5+t5sGaZIx9SDG3O7mQqmRdK/nl+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a0caf0-8d1e-4446-3db7-08dbba23c18d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:51:33.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otmEZamA6gMX+Es1XJ5DYsVSo3UvHZZjG3K7CImKO12z/8oZ6Ddn8s+xw8PZxCrfXfqLM3nQCTNhDRURuXfX9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200183
X-Proofpoint-ORIG-GUID: O63o-B7TXArYV9rb4S21MR1Sp7aj_tRD
X-Proofpoint-GUID: O63o-B7TXArYV9rb4S21MR1Sp7aj_tRD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
where the device in the userspace btrfstune -m|-M operation failed to
complete changing the fsid.

This flag makes the kernel to automatically determine the other
partner devices to which a given device can be associated, based on the
fsid, metadata_uuid and generation values.

btrfstune -m|M feature is especially useful in virtual cloud setups, where
compute instances (disk images) are quickly copied, fsid changed, and
launched. Given numerous disk images with the same metadata_uuid but
different fsid, there's no clear way a device can be correctly assembled
with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
disk could be assembled incorrectly, as in the example below:

Before this patch:

Consider the following two filesystems:
   /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
operation fails.

In this scenario, as the /dev/loop0's fsid change is interrupted, and the
CHANGING_FSID_V2 flag is set as shown below.

  $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"

  $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop0
  flags			0x1000000001
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		9
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	1

  $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop1
  flags			0x1
  fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		10
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	2

  $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop2
  flags			0x1
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		8
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	1

  $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
  superblock: bytenr=65536, device=/dev/loop3
  flags			0x1
  fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
  metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
  generation		8
  num_devices		2
  incompat_flags	0x741
  dev_item.devid	2

It is normal that some devices aren't instantly discovered during
system boot or iSCSI discovery. The controlled scan below demonstrates
this.

  $ btrfs device scan --forget
  $ btrfs device scan /dev/loop0
  Scanning for btrfs filesystems on '/dev/loop0'
  $ mount /dev/loop3 /btrfs
  $ btrfs filesystem show -m
  Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
	Total devices 2 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3

/dev/loop0 and /dev/loop3 are incorrectly partnered.

This kernel patch removes functions and code connected to the
CHANGING_FSID_V2 flag.

With this patch, now devices with the CHANGING_FSID_V2 flag are rejected.
And its partner will fail to mount with the extra -o degraded option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Moreover, a btrfs-progs patch (below) has eliminated the use of the
CHANGING_FSID_V2 flag entirely:

   [PATCH] btrfs-progs: btrfstune -m|M remove 2-stage commit

And we solve the compatability concerns as below:

  New-kernel new-progs - has no CHANGING_FSID_V2 flag.
  Old-kernel new-progs - has no CHANGING_FSID_V2 flag, kernel code unused.
  Old-kernel old-progs - bug may occur.
  New-kernel old-progs - Should use host with the newer btrfs-progs to fix.

For legacy systems to help fix such a condition in the userspace instead
we have the below patchset which ports of kernel's CHANGING_FSID_V2 code.

   [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel

And if it couldn't fix in some cases, users can use manually reunite,
with the patchset:

   [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options

 fs/btrfs/disk-io.c | 10 ----------
 fs/btrfs/volumes.c |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc577b3c53f6..95746ddf7dc3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3173,7 +3173,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u32 nodesize;
 	u32 stripesize;
 	u64 generation;
-	u64 features;
 	u16 csum_type;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -3255,15 +3254,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	disk_super = fs_info->super_copy;
 
-
-	features = btrfs_super_flags(disk_super);
-	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
-		features &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
-		btrfs_set_super_flags(disk_super, features);
-		btrfs_info(fs_info,
-			"found metadata UUID change in progress flag, clearing");
-	}
-
 	memcpy(fs_info->super_for_commit, fs_info->super_copy,
 	       sizeof(*fs_info->super_for_commit));
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc8d46cbc7c5..c845c60ec207 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -791,6 +791,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 
+	if (fsid_change_in_progress) {
+		btrfs_err(NULL,
+"device %s has incomplete FSID changes please use btrfstune to complete",
+			  path);
+		return ERR_PTR(-EINVAL);
+	}
+
 	error = lookup_bdev(path, &path_devt);
 	if (error) {
 		btrfs_err(NULL, "failed to lookup block device for path %s: %d",
-- 
2.38.1

