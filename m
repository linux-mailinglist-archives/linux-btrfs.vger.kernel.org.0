Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAF767050
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjG1PQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1PQd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:16:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC86187
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:16:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4Nqt021138
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=GQhzFGAGsDVSr6OjvwEvAbVQ73tfCHU6wben3Eg49cE=;
 b=WcEWiXiEL1nEXFfBeGWrMAcbGVJ1KA8yomfuTiBanGmgZtzTJ2aYqV30Kozv1TQECd9r
 zEtN9J1ZSooAKJo3zZKrG7VTnygRPTbzAykEMW3dVSqLt9KBLU4JFybMI6DR6GSxFAH1
 3PmPqDvP2i8hKW+iroFdG11tQxbfdzrp+GZ4SEG5qUvEvfvHNpKvgzSmYx4NmDxo84EQ
 ZQYBM5EulDM+V8gzuhANO4qc2Fb2xf0i5HgTIBik1/bsPHtf70fYls317fjM2MiMRMgO
 57TyaO6kHkfJIGalwkYeVrs/xUKNdaMGsVV3OdhxwwLpEZK4W3SrLwATUuH589tCYsUc Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu4381-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE5M5l011804
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9ebqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYvpKVBhwDFXzy1IDTGTHK78QQQ2IfN/W5dBJnek25zzc5tgE8wz3if1LSuEWxzaRUJVXudGHW0qPDI1ccEAzenvZyPuUxkUqJECdfvHFLnyQv/wabwkXLNVz35/oyk9eiqBHLVA9HdsbQ4bDN0pKiHvZjGnRvCZT11iRQLSrt8fc/l4pBJWbqWAuJeYqeHO1Sv7fulgeuCZc3mOl8jNFy60/aTdywEkDkwUANa99ggR23BhXxCAGUwQe69csgjptRUe9jPq+roceahoMvfVlZQg1ckzDIehsRDhF7S5uUn6h44iUjO42WaJsz+uNiICELh0iWZl0BbpCJ0IrTJsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQhzFGAGsDVSr6OjvwEvAbVQ73tfCHU6wben3Eg49cE=;
 b=Wmiw27bylafbXS1xH7qjW8h1EUPZ7q0oFHI1B9XXahgIQYs0f0SiYoU/vGx2N2N9xtgxLFA2+spC+UyE7DPGD2O0mi1q14UxlXV9LAXmYX82NxUgh6IkW1ShJuV/+WQWE3PY7DQCJNh18j0FjaePNjwUku7rEVoq/7BXlScHiHG/BFPdB0hFJSUAmttwJFIDnjITyAvn54oS535+s28ggosMo/82Q0VM9YjDLS7BDi1cqYdNDbOeQk/77Rd8Yq3fPF4t3HfcXCqGSQbF8tIQzCNO1ZkNpJILrJQPrWlFmIl+9zadYW4q//Z7Mug7CnUWAvO9W/hZ+fkVTZmc7I1rOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQhzFGAGsDVSr6OjvwEvAbVQ73tfCHU6wben3Eg49cE=;
 b=Vh6gnQeWZ6379QdiwDMGK2wosOYLDXR89AOK21nLYzbJu4SA8olOSOGcDF/BaBytDFyyDZgc5D/8P5Gkvswkyp559dEvnWcY28IwhH6sGFvB9wwVmwVm7bbZGqKlDPs1kUNHt9PHNun859cMhtAsTD8aCYg1d/lvF8ROBvXfwfs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:16:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:16:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/4] metadata_uuid misc cleanup and fixes part2
Date:   Fri, 28 Jul 2023 23:16:13 +0800
Message-Id: <cover.1690541079.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 60806037-df39-445e-7229-08db8f7d9de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xBAMqKuGiCPGH/oONc/Uf9zsLuVeUK3+xpXqNl3bv8CoLPSdGLGEjBgXkP6QSuVW6nMJQqjcn+DZFOt7t4h5Di5yyM9ImkYmFxCcbrTRpFIg5aipRpdWF5cLx0jafB6sWGbvVdZ8hph22Jua6qy2l3Svvv1U0i5eAYOCcBfpqGMkCJZ9tTiKMelCV6Or7EiOEDNRUXfWgd9PKGzww4rbrVNrl+4HAL5wQeTEm6lZE6+N9CNJAAoWVlz6wSc4QNeiGd9sq8gdzu4JLL3H7qEkT+mRs4k3hGLxcDhqny8ulFJ0RaSU1ocNevlGdT1d7OrbA8q+97RMa3C587oUeAjnfbBOpJAkWZAG+eYV5/8cyJvBxaChg807B9qu6uzsLoCPER9dkmBylNhKdP2yRIqtVGH7csiDDSTnYyjY6yA/mXhSWuE213915yv+lnNi8TwtSMlITjIV3vW49i58CvUdrFW/Jwu7cZd19eXHb5THFHojmTf6958ui4NyBkS3SZ5JPTxI7SHj0XsGv7lZDGZYBRZc0Z0nyd2W56+p3S5wnomZKmgWXjCiN6z0/ePM7UV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(478600001)(6486002)(2906002)(36756003)(66556008)(6666004)(6916009)(66476007)(66946007)(4326008)(44832011)(4744005)(38100700002)(316002)(186003)(8676002)(86362001)(5660300002)(26005)(83380400001)(6506007)(8936002)(2616005)(107886003)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nn5bfFmYBgo06HEOqbCNg0dFcWT9fmOCPv/1sOQOHDo2fOcO2GNGqt35c5A2?=
 =?us-ascii?Q?N/68+D1DlksAyzng8GNJQYXWvYLBHpOa0lCucxodazcAmyZh4qtTZ3WYsOon?=
 =?us-ascii?Q?48jtNx+jbTNGyWTwlivfx0l81JKHDawm6XKlaN519V4ppz26eDGk7PNRmN7u?=
 =?us-ascii?Q?2oHPCYvxQ+G010zgkUEdeC5mitUWcey2SUqb2J9cvfhQTuD7asj/tYEXZ3vC?=
 =?us-ascii?Q?PaTE5IK8wNUqMEZpyBgNQ2fkYrk9UIhrUeGHHjvw/dVCAi5dcQTosOL7mBKb?=
 =?us-ascii?Q?ehev8QxGD+P1VshbBdj7C2o8r5X5VA3j07MbSkQDoJesXO0FKkP2D4x9iQ4M?=
 =?us-ascii?Q?K2nWuujtNwhA00zWFpIoipwKArKoSYbRrhIrTznsZa79rsXTLyZskgzWiBL9?=
 =?us-ascii?Q?OKb3My2Q/2OWZvk7yGGsCNaAT6gdoRF2J0rRe66WJARbg5/kvrNcsiWgzJh8?=
 =?us-ascii?Q?D6JQxUTxWdNzaye9e8B2lYzrGCAQm0wXUtEUrvZvFYu2U774frjLJmILBcfN?=
 =?us-ascii?Q?ZwSMDZwboGcVgkS1EhJwqWYQQtIWGIJK6vxuitrCxcHdnY+HGi5UrNlhtHRZ?=
 =?us-ascii?Q?r4qnor1blvW4bhH5htwZbCeUzcGyBEj0MMVGQep2RFFCHmk+2NRvo29WXFsE?=
 =?us-ascii?Q?npFzNuOs1d89KCZzSFs/H6UcPAMhgtLOOCt3dUS/CTkTqvUW4qQYfAJKQPOa?=
 =?us-ascii?Q?kflKxtqUumc3mPX3surKIWeP8pvQJlkcSi6Mrq1uhQeFLo4ioo5uz4gVXGeM?=
 =?us-ascii?Q?n0YvqFWdF37RHv/Qo7jfctaz1e7p+Mdk4g/mrjmzl0RyIokZB7ZlynjR42/y?=
 =?us-ascii?Q?U8/3zuzdtMhxlazj6XKYBcQj3QQIStH9iXiXI3HJI3p1hwJDGm/jhK60lxJl?=
 =?us-ascii?Q?T1vlgD+KboBiYwHOpFFRy8AnBhJMxoGInYJyr+XaiS7MZVWmM7KgFrpAEIpf?=
 =?us-ascii?Q?5fNvQu1wovCDj1L4ELgV9rTr8vdr4ZfR3HlROXmxg7Yg4Bk/6H4KsEz8+XGn?=
 =?us-ascii?Q?LWfUHouaY8Tb1F1se7jtSo5d5Hs6Ghqxk6wvSl1Mj8p4TWBCyAQy+E/gM9UK?=
 =?us-ascii?Q?j3gfHALdVTIr+duz40HA7oNL1yIKwd+yJW1tgRNsVGYIhmU3JCFFFxFIjnW2?=
 =?us-ascii?Q?c5sNgPSsE258EOq58m7SnU2m0wiwk4YFOcxv6GjtmKT4BvMDQXzBkbIaUzjv?=
 =?us-ascii?Q?GRbHpYzCdbyQOQxRw+ECyuLvKKdRbH5la4+DfJhNX3CQdI0YrjgAzk8vJt7G?=
 =?us-ascii?Q?sHFsbSftcsU0zC9uEVSJE5e0piFDsUxidJo09MFBf4nGvsCHG2T+Xl0TDdmh?=
 =?us-ascii?Q?7G/AZd/6stvhqLGfh+GuDqAJA0WI7C3HvYvG4WGFb19jp8ozm4dD1619BV2u?=
 =?us-ascii?Q?3AdZ0ZY4S0rwt18Ma5wKqeuN+7wp29KBMXxDw5qv77HDsd4ZYHiQNpcvY+MK?=
 =?us-ascii?Q?fX0VD/5hf1D6MgbGQag8Oa1b/j1x06IAvKYXd6ZUYswAXLXcL+DolJUpWOKT?=
 =?us-ascii?Q?JU6br/q/PYCQUM3WunmCiJnEFL/sI0nqReY6aGEk6KtUu56DHYeBGy2ifBDx?=
 =?us-ascii?Q?gkH+8BN8t6vg14n3oa8GkYnhD7hM84qGmYHaoVSw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fy94lQRmZcWVnS/q9hW7pUMf1h4JbmSQRkCJefMi1ToFRNBnIpV5mycTIoX0L5Bw6JosLislWucdtovVRenxudGKWfm7PDlNfzXYzFSplOFUXdv2seH+ZohRloZJURYmacvOuTXX+zJJJR9fazZ+KXGORPmt/EdX9BfwIvh4PRcrcqFsth2Oy7RTiKINg9mlzDtJhH5m9XN5ksQlDyxS5KdHGBdjk+IMqtebFyDUgspylR7cYz4qJLxu27W/UOaKLzorqcJ3jl670JxwqpVcMvganpnNV8+BXgyVs7shAlzw696GsrNpUFCwwov65m/93mcaCKFSHzfNQm+WwGCfDh9mluk0KfwHYAdpVtu6UqiUp1MUSfrqJfmVTWLcGfUxfqL/fsbuytB8UhcI5/pKC04j/vY+cGD9Nglkml/cUYL6ywoF91LBv/ZwlOkvhMw3VFRG9Fgy1Ot5mcMBVlbelzKLmYEK0B8CNSojVi/vhwLDZjvfhfan3qggDe92zfA3+hDNWqzAIdXcBjJbw51esJFxCMDfkqTiH03XvDJrxiTKHbE7CV4WfLDLpoH0thNEA3dgblGsTGSmoOA1542FfuqQo5D3+FJg2aWHr+5/dfZE2ZuFV2smT18rCvdEhYyHi8/MtKXS6JQBIu+QFq3mYTdg45VP+wUz2SuGL1g65MaCa0B7aX5pDgO/mRPMqSw1Vm0ybZIobtoQAUaMDws4DKDyynzgse7VJZdPlrP2UbqQFx2xOvuN/fmwOgXF25GodiXWh9l0SqsXz50z6NpNHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60806037-df39-445e-7229-08db8f7d9de1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:16:28.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNkGrCuCYao+89JL6td0Mrc4z7k3KN7w5sgD5G4sctBt5Piw7nnnx5wZAby7lvcJxnlm8mdPm75hpJtKiA09qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280140
X-Proofpoint-ORIG-GUID: K2SAqycpChHH44Xb31ShM8ov71vxLj0K
X-Proofpoint-GUID: K2SAqycpChHH44Xb31ShM8ov71vxLj0K
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These patches are independent and not related. Please ref to the
patch for details.

Anand Jain (4):
  btrfs: simplify memcpy either of metadata_uuid or fsid
  btrfs: fix fsid in btrfs_validate_super
  btrfs: fix metadata_uuid in btrfs_validate_super
  btrfs: drop redundant check to use fs_devices::metadata_uuid

 fs/btrfs/disk-io.c | 36 ++++++++++++++++++------------------
 fs/btrfs/volumes.c | 12 ++++--------
 2 files changed, 22 insertions(+), 26 deletions(-)

-- 
2.38.1

