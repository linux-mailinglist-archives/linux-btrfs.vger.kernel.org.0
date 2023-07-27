Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EF76555A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjG0NxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjG0NxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 09:53:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA72D7E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:53:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDenn8023519
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 13:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=HRUbn4uaxq5cBZzqScmrSJFEOfkeGoV32j9rq1cAF8k=;
 b=lk4PX2qS2NcWr1ZkHoK3ZygzsezuWvJY0bZKor5wyHQCmvtu0dEXSYmp87IBB21p/TaC
 uvUx+vb893S0hBcHFXd1C4EkQEZz8pRPzYahSoyLOhopL3uqscx6EX4DiUe0tCsxsTE8
 AuuATWjfNCN/Qqij4SEBxFobJDvVp56ny1eMphw0J0cXB1ArUDfsX5MscnWyTY/x8UQR
 UrbeteBHqpA/GroSlbyM32xWt6ZwA5Ok/S6ZQu2ZzbsQpVPjmg7owtqX6dUpMBIEIvVo
 o4mFMyqbHFnyUQclbaNcs9QhQPLDSJlZowaWvFhYEybJKSTCBEJkbmSE4/v6Mh2un73e pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3srtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 13:53:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDjree025415
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 13:53:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j85stb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 13:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK7lgYdR6JOLrRn0jr5uEfJm1ZeVOsZ2p/LjemSXdxZ4tWD1ImuWC9A1+9sKGEWxFWOQvGgc7ciCjPrNUhQgdycknCZEklDqv9fUmv3DAKx0pEUDHE5mYtIrF7mpgAaeI+7375iXtX1OTTEK3eb/S7/yefkNXb3tRhONr8bZ8SD2c5y5DAd5weMlMLkC8PZQ4vriJVUYiVbRHJ5nTNR8PT6oVpO8/zHnllDoJF1sBoQb+cgIOBovQ+J16TsaKc03Qa22h1D5WdwI4US4F4vOi2sRF8MJTI4tR/MICDAMrzRDkhj85Xh7IRySdMMA5SCUqGVUD/JP9CkeynCx8+DgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRUbn4uaxq5cBZzqScmrSJFEOfkeGoV32j9rq1cAF8k=;
 b=RgxRlitv+oYe0Pt4WSE5pR6wSnhH2lKpGWx5o4WldGLnaW1DXa2ckQI1KM8lcO1k1gWOstAi4/T2ciakOvDRzharyjO5AnZBZ5pHJjeJkaPTojNMN44Df5t1exfB4NZjlfHFNKwEhC+NmAybrSV+IABprFT5Y1rOkn0hgQlkw55GDgpSBr6SXFwujXAbPccEXT5Z0awGV1g+BgQfhznt/55qhNEaxgNStLF47IblHbWDra5hi31nylFRGazsODhpR0s4UdICmUlVDWnrxVrjuIycH3XjRqWwkpa2/lVF85ClBkJmlefxh3iJObvlWFLzXHdhbBW7g3UCUX5oZEJ9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRUbn4uaxq5cBZzqScmrSJFEOfkeGoV32j9rq1cAF8k=;
 b=Xljm2DJwH/2WT6pzqBwcUHS0A2xodRvGs+yf0OvlmnugJo5fBFqyVpv8yFbPAqxsSoUuS1GLMS3eBxzcY4Sx1ECSNAjBmZc680jxcGhHdHpdStLI+q3ewwbNLtacrw0IvN1W72aCMYaiTymUUMlCYsoN32szKCxmn0ZXWW+HyjA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:53:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:53:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] Btrfs: improve message log due to race with systemd and mount
Date:   Thu, 27 Jul 2023 21:53:03 +0800
Message-Id: <41c08d979d1d994803317fbfd98fe91c1e9f6b9e.1690465916.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c84edd-7b1d-4db6-04cd-08db8ea8d230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwxU7oJqXJcng6xoioD4s7PivrcYyO5t/8KQJ9a/janAii1h2oIz2oD323orvXujxEDKpRCVAzjJLh9wTDy2IeeF/KKJw/drUj9Fg9ZlmNjPvohIuL08gDHl1frBp1I0TWWX6bCdz4fxXAgB8LD3yP18Oi73FJXVWzPQenCaQpniJ+wJ2/Aa0hlhnvkQIjnheP5+ct8oHIkwcBUOWxQ5iC44Bs/4NzpIH/G8dtajr6zVct6/XScVok6vn4zOe0WY7uMDCke43xBNCnEzAkp+jnW3dSSHgITamnVxmyv79f1HSGtJ+eZTeag02afbLjErM12ZN3UoZo2G9rb9tJUr4upg8mnrZAoj1pguMV1tyFd0FSTHgvW+JadWhf6rSUX+3+BVbWcy6wy+itkWpxYyPozUFoQw6O7BqllXMz0PZRl7MVR8B/hXxpvlCpPfzby4yAftNr89pcoUjHFGfCpZNuHHOFwEFmska1a7RN+9V0/yvpGADwLapFizA6UnAYuK6Ilf/FVYjrxGvIfYbVECMt0xdvjcr6MT/V9u4/KoBaWHJVf+SqHNvbkzzljK7vaF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(107886003)(86362001)(36756003)(2906002)(478600001)(38100700002)(186003)(2616005)(26005)(6506007)(44832011)(41300700001)(5660300002)(6666004)(6512007)(6486002)(316002)(66946007)(8676002)(66556008)(6916009)(83380400001)(4326008)(66476007)(15650500001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsTf0rLzSmoWYcCK7PdAPuggC9UpLfi4hfGV9r3rjfcBtvrW8FxgRJwE49sn?=
 =?us-ascii?Q?EPVib1kxXSQ7fjplWzUqp/ja9PQRcv7qN/QqUxPsHQYp+cspzm0UhUi7L6BZ?=
 =?us-ascii?Q?hN2GpAXRHVKW4Bhxo5VGCd6+VmPviD3spPEUdDHrBbEj0oQb9eMgUKKC9hyz?=
 =?us-ascii?Q?o1rcti09jjn48tJLJnaZoRLsYFzI5eT+97rVoGFluDIUpCgeRdpd/zWyY+Tk?=
 =?us-ascii?Q?JpHOdiAovdXGaRV3ZY5cnT0WfqLucg3L+jPegNmjmG8A/5TJq3fl86/8vRMA?=
 =?us-ascii?Q?fCYECwp4/pE8qgbhtYuW0ke68k5hblfzpkrDiojX9UddNxo74D1sqnil9MvC?=
 =?us-ascii?Q?3qTOGHoRwg/s7HpUjbF/Z0aSKE7aUyON52BHgyaFZChg4OsseYyha+Fs5Spw?=
 =?us-ascii?Q?/4H+LrEk5bx+Zi/Yy0v7XXNG69j0LjDptJCsky644n+LWU821aTCdL76/Ixe?=
 =?us-ascii?Q?1ej6hcVjKmZHHeAQrHhHMJxpYCpaj4qELbOXQlBgpc3Yq8TmcUzBrqVWEr3Z?=
 =?us-ascii?Q?LqeKdi0WYI5nC7FxQS7Q8w7wem6h/svO67w/3bxKqSsOZxZLrQxh3v8yH7Ud?=
 =?us-ascii?Q?3zACszgR2X/saY1R+u2YZb2QIgDAzjMe215H7Pz4t5mCNe5AyI6wohagqbId?=
 =?us-ascii?Q?nl7ju04F6igBZUns9fzqIPCudOboAxmJXaAO7z4gpSExSd3O8wWUwiJtPW4N?=
 =?us-ascii?Q?H7yDveu03QejYa/Ypu3LyYsabjLy6TfcpWflNiDfTo3Qoaen46FNNHL17sOF?=
 =?us-ascii?Q?H23CLEALzav54iybCXv66AbIZJxHs1lSbvfhBCvT2E9x8qIXPkj3sf1AExU+?=
 =?us-ascii?Q?DtDLgdtoBTsBf3ls5FNvx9jnqoxnYRZxkTv1WH+fYTuL63GAxZ07gPuhYWIy?=
 =?us-ascii?Q?VyKMtuITwOtEVJy+boUSLlamc8DEPyWbv7Z61Mieo/ajYqkkAyUoJylF0j80?=
 =?us-ascii?Q?W34w+O2mPJbFrZqC3Sf0pWxBejb1J/NY90SiwL6SoOyBeoWLsKt9BBni8U/Z?=
 =?us-ascii?Q?HYI74WnRmwZaNZ/S+dZ4+P+JePf/9hfBZM71dQ2Ge0ltGMdAJHl8evCfbEn4?=
 =?us-ascii?Q?lUaPtypaJQpImJsfObQfwT+ZulOQyrB7ZAEhqTkrNnTJVhrQyjA26EvjMJ51?=
 =?us-ascii?Q?Pfu+sgpcqtd/8pxvtSzr6KlCiU4OMQuRG4MmVh3swvxdAqYtgGtsrfYsssoD?=
 =?us-ascii?Q?nqDg2+hO1JKwMBDpsPvNoFqYOwZYAqkpO2xSbZDFE7Wely+Bz4R63Lm8dsFs?=
 =?us-ascii?Q?G+gsaqlbIsE2sf7owZz2JBKMPznsWyV8h49k0HSowx3tpe6DPhuSuWBrlJBg?=
 =?us-ascii?Q?susQVpS2S1PN4X8ZsjBcgDrgUvDsNNyCcVkQpglj0k+EZ6rDYbnUy97ORXrL?=
 =?us-ascii?Q?fOt+zTRwUNYr3xZH0nDCb5iS3CKWeTLQMmNve9HIFqtinAB9rZLWxMyYP3Mq?=
 =?us-ascii?Q?omgpVzbyQ/s/7Ay0u6hzsZsnptOGz3n8hVkQQk3Gk94GsJWj9nr57KMAcYfY?=
 =?us-ascii?Q?dIESNFszGGD0wPCxVR4I/2ZQQykMB2vL6fuF49yP53Qg9esHKysyttHRJnP4?=
 =?us-ascii?Q?wiVogzm4O5DKHm/YyygjD0vkr58MKsfOmc8M+MUy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3X6oh3Dt6QpPhXy8pcfUm4hTqNQ3K4LwOZXAa6tyAJUOFGceOKHSWKE4DTdAkb530FPZQvty06BZ3gbL89v/pryye+NOu1Rzd6iTJtWksWR42oUccHhqmUJKPeRpaRR2GTtCMfiGv6um/HOX1YC3tptraoM764ZDUeH4wCTyM/gnYmEYkUktaxXmqL5UZrp7a0W5c4HdxxYxlGi9u6223u+g8omVoK3a3Z5fVmt8TPTuJ8s0Kih6Ux1jl7+feJgW5x/WVMWK/3slYNQ+2m7Q1FNbZc0mlHimlrhKnI6tuNtt2qHLKb3zvprTTd1rzb05cb5PZBlEoIE7nWeBkX9noO5IMb1DV/xOMr5/sXFUUtvX2OiRv18o8+lS7LMFGZXJbD5u5p3Gk9YeSWEHKl8OF40toLmE6Er8pIbpnfsJnx6Opukn5UkD0aVvzvaEAVdG8stdKzIi+c9vJpNmfN36fJ1qdgpw2ZjrLF/bxwzxjFm8IF8sVX8HBDb8EuLuhtaZnFV6hetQ8mOwwuuSPpku1bBQlZPFIjttH6GZzoVsVu8QjM1QM7ywFI0/TR/2DPLdn6rqvXe9uEhwobDZCoYCQMk+wPN3fxh5Of8AqC1UkV3ZJz4Rll3Ocp/jgp3Yw5QWdng9woybwM9dZfZa49mpEOgzf2zfpjo4BzzIfiRVq3/T+9hpT4mW+kVVi+gkT2o+BIgakm+428kFRr4kVFEZpneFMDUAvtYGFcTMAudS3IUlVrwiCyFUfmQrw7F55HlA7w4XrlKG59n/tlxL8XB4Nw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c84edd-7b1d-4db6-04cd-08db8ea8d230
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 13:53:13.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn/sL+2cylCxN23fj4EF+mBs6qenWWYaEWYlKO/6MNQdxYZ+WTJTHD3NoW6Eh7Z1VjtpXzyVA8Xl2s9W3xelOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270124
X-Proofpoint-GUID: SQ6dSx5zjPnJcBdSD4Jd3W6SSFLTosIE
X-Proofpoint-ORIG-GUID: SQ6dSx5zjPnJcBdSD4Jd3W6SSFLTosIE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a race between systemd and mount, as both of them try to register
the device in the kernel. When systemd loses the race, it prints the
following message:

  BTRFS error: device /dev/sdb7 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted.

The 'btrfs dev scan' registers one device at a time, so there is no way
for the mount thread to wait in the kernel for all the devices to have
registered as it won't know if all the devices are discovered.

For now, improve the error log by printing the command name and process
ID along with the error message.

Signee-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1ebf8c2222ab..82ac9d3d0981 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -851,8 +851,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		if (fs_devices->opened) {
 			btrfs_err(NULL,
-		"device %s belongs to fsid %pU, and the fs is already mounted",
-				  path, fs_devices->fsid);
+"device %s belongs to fsid %pU, and the fs is already mounted. Scanned by %s (%d)",
+				  path, fs_devices->fsid, current->comm,
+				  task_pid_nr(current));
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EBUSY);
 		}
-- 
2.38.1

