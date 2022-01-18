Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24B8492983
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 16:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiARPSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 10:18:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64928 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbiARPSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:18:17 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4SuI004506
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JEN9Pd6tVTlJzoxrePTUwboieH+g0HJscCWfUyrlr4U=;
 b=mSZj76/FRoDXZ3cF8yGfLkC9DJ6sY0XdXE/cac8sSXK/vg6mykbsNvlmOQe700IQ46mH
 hdOsrf3ZKXlkEAQRBQOG/QFYW75K6oGtlWMiIkV4rWFfaqXcNvLlLNTwZF1fM/GI8Lpj
 biSV+r+qyr5o1YS8Tu9YEUFpRDfJs+boFKdWwvZwx6qJV+NVzcfKearb/Rz2eUdCPcUV
 BJ9RpXuXoIvTTZfeD2bALT/swKMWvzTJfcgudeFrGIR5V3c3SiH1UXiKwgOrsepWpIbe
 51nSIC0PIOvuN0jlgxOZkZZ9bu5ccx8GfZ2s2UXAAeVx5Wb2Ohngr6HzSSVPQXgoMy+d pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnt6gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IFG2VI058255
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by userp3020.oracle.com with ESMTP id 3dkqqnjjq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOFOpGZYzwPvgKWWylEAnS6YIWr1stgH+Ac6erMjWKRAfVV9IS8V5qdcwl0AwQuutkfcdgSLt0wzCU3YGlT0N6HjMmzUR9Ym4XTcnm2sE6OHI7hITEDkiQeuH6KoM7glL29C0BVXKX9DSDSDqryotFR97d1ErdFXICn5n6//mzsqXzXUJJ50HSnnTcu5WvGVa5NXE7JG+w5kh6myw1YBY8/rjFBbbgNbYr02LXa1kCokdr+dL6VBM9oddRrZB2H5g1aMnEAOJsimYRY7Jddho11fdln3srRJaWCnf3PSBth9wjUJoU5ZD5xgrvMAAMLokMGnG11y3h+vN3Ys911Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEN9Pd6tVTlJzoxrePTUwboieH+g0HJscCWfUyrlr4U=;
 b=ElW2EY5ZyzNsI3rA14bt+ND8vEBmIclLwlK+o9KMcTGnV/54NnhMrxOXR9bSBfRBjbtQsaWz7UrxI1oi9wvoXFhiTy/5rPWidwHdcMvQ3iVmYSpsPquFMW/eGjzf061jKotGV7cVoYw6bPqz3WWV0pLLvVe0FXF0LY5m4sOMuMIKWvK0ZV35P0BvuDgnRuxm/Y2XLZOF/IfjpWlGVCsDSsYXxqDKKuqjbslswnUK/LCWL2Q/Uh5g/uAn55pOd4kgYHFE1O3KzFeejyvdTl0F+4j0bSyd+q28F4exDAlCWGJmBtc83Dt6I7xU/xl9BFYceGczYqz+iKYKxhvOEv12VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEN9Pd6tVTlJzoxrePTUwboieH+g0HJscCWfUyrlr4U=;
 b=aZIk7O8KrVf8GwWwXplHmwvAHDjh6dqkQB7BLGi7+C83wXjX19/+1s8gRSZMXuoRQsOhSHG90AMpvJoXTR6Bclgacp3BV+wPO81FUYfxUDwtdPw/ak4RzhxZ87PncNm0N0znxG3I5q/27Vnyn1eb1mO4VWqN/OhI1E3jcXj9X6I=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Tue, 18 Jan
 2022 15:18:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:18:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] device type and create chunk
Date:   Tue, 18 Jan 2022 23:18:00 +0800
Message-Id: <cover.1642518245.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58544cbc-3e19-4ec7-170e-08d9da95be80
X-MS-TrafficTypeDiagnostic: MW5PR10MB5806:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58063E97EF7AFD99808293C6E5589@MW5PR10MB5806.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyEffi75P5SRB8UVnPersGoCj6FHHpVoSF21KPN3W3VJwY63TtQ9BwH1c9gOJTL5ejJhNbifBGp5kzrNZ3VYqAp5DTezBQQAR10JnVBc8286gK1Fdr8M6o66hVomhGUlc7G4TZqhx4f1CeDONMQO/FrtIPGwfCk1z1Ldl9BOvYAWO0/sprb+FJeM64Eghx4r0sVBT5fQGB+GI/Bg0WfFgRwl630RV27LZ8qB/HZrBpWrt886b72YIQS+iXnivVxKpiBj2EbmJLcNPPWV6uH7dWoMBInk/2wFXuINmNJ+OyifNv8GgGDqEsknIeP51SfSGdfVhLCQvxM2qqX7CLkvSQQnkXrP58BZesNvhu5+LeYHGXbGDOq3svIIGynH5V2pRdCUlY54lLKwJFaVU+KXY9A4KAuefHxtXjlvBQ6qNErkfb2EVAk8woVeaVfI4UmkELkCUHJy4MP0nwAYHPH+IFHvHoFKWGQylOWDjoim8S3i6N1yOed/919YIgoJYp8Yk8rN+XRYNyMgoHRgbtUVWKtZru1oghA4+WFgcF/aorN8yAgLp96Fo0/v162iVcO1WnZEFQd5SHpWrom644ZAT4rArXqEpfy7/h27dUq8LZ0IcZtgWuaLzxGcK8oernWlpozeImUtdar1tFxaEczrhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6916009)(316002)(44832011)(66946007)(6506007)(5660300002)(8676002)(8936002)(6512007)(66476007)(6666004)(36756003)(86362001)(2906002)(26005)(66556008)(2616005)(508600001)(186003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOEGbhqATNW5F85Et68hlz2g5lel/kdSHcy0nIUxw/W4U9+e2wwYjnI6ky8E?=
 =?us-ascii?Q?lN6alAPr+5fxOMaS4DWyq1l2vdApJjXrb2a0L8YsPLhvRrydtOelNZEqsKSY?=
 =?us-ascii?Q?fBMPOesHwSt2vyXkZOrR+vAtWpbZLOMPVTJfM6A0vy8g8utmkPVx3qObd+u6?=
 =?us-ascii?Q?6Lsqe7EPRLANDczDwEsxNtRc3zh6kKBOn4Lw16CntilsyT0Krper+m6/fxp2?=
 =?us-ascii?Q?Uffqw5JR7B/NNvIVlLleHJ8+KGgnTrNDqerZYsLPOoL2TR0Y6uif6kKYefLE?=
 =?us-ascii?Q?oOjEMTDd5D8MmG3/AHSr686hOMwKpnBVdPPje0bdTXu9FmIwmBnL7no+JA2/?=
 =?us-ascii?Q?rG+St6LhQXU3jpA+5xa536sPhnF7H0iokqt3/YaofKvbpTb4wuK8yzkIU6qG?=
 =?us-ascii?Q?8svAhjL0qXVojYlazyjCAIcnJByx+K0oI4BQnZcm/Z4DS77248hRFZr8+O3H?=
 =?us-ascii?Q?XpqUMlXp1+nzIwd/ORzCB9+m2yKJjEG0xmbL57NZXQUc+F66DrCa4Tr+zu91?=
 =?us-ascii?Q?8b6cm60aOjASstvSwU/PsQgHrfm6V2//5kJSQySypPqo52qt95v1u9gqb6wE?=
 =?us-ascii?Q?XC40Z9XI6B/L8uVweXvOkghV25GH+di7HnEkzpKuXpYcLXgHwmWJGwWsV/qc?=
 =?us-ascii?Q?uA3pA4JHobpaMVBGUBvlQdfD2eDE4YiKehPyP0Pdv6hvhXeX5fEspRdzn26W?=
 =?us-ascii?Q?KExYnf4DASzQW9apRghxkm5VrnaILHfgHQbivOrSGv9h00EaC9mAD+Xu6z5O?=
 =?us-ascii?Q?uThlQigCgL05ouFMdUpugDAAqNL0M1GS29AXqT3iTWerQ13T/JU7lOtWGSPD?=
 =?us-ascii?Q?vsCh0S2Z6m4RRsBOA/bsYu20LHjtoHVtEaG8feJnY8Xc2Cd7dZGeU36dTEq3?=
 =?us-ascii?Q?SBYHZkMMJXjXCfD0GEPoCSiO5ShHoa6d81HGikmOGqFhJ/aJW0XzZyIAjzPe?=
 =?us-ascii?Q?fU1MLr+JcV0xwm5CZXbmyB+GG31WRfQXnLLu2MsjWi8KObsr9xRaReE/Tkgv?=
 =?us-ascii?Q?juXfywliTLTT7Si/M2tSFG/xdNLO5q1S16Ix7je4xEmnEA8sCNkegqhiCQXE?=
 =?us-ascii?Q?UmSkaRYPEQGsZvN/QP4T4ucAYN1H6SOkgJh5sMbrMcF6BajVaY1ppYsHqw6c?=
 =?us-ascii?Q?09GTqstJUZlw/NS1ZuKTcMsYNxXnA/sxmd2W/eIiM8AI6JVFQXud7sDVzNr8?=
 =?us-ascii?Q?zMHUzTa+ThBi1FbufByjWQUC4nL67OBWUqpJUGPkzAxHMfTTTkhJfHX/b2zJ?=
 =?us-ascii?Q?qhciWouWoupCBsUWA4DT513qznRKzoSiP9qmFFeTytMMCRj6GDK8n/vz+Mh3?=
 =?us-ascii?Q?/iXAwwgmbMXYvwGeqt+7BC5/KS9Bz+pFBu3oND2a/MIr9PKoM23qE5WPZBIR?=
 =?us-ascii?Q?Pl32DjlvQTxlQB4WSwHN5xOTfAXsZAei4AOZDndvp2FMB3KkA3Q5G/t8wv0R?=
 =?us-ascii?Q?ayvTMKDaHPd5MXtYvoHW/2KuM4P8h6fG7XYbbuBtn/uv2XMpylV9qCon+lOS?=
 =?us-ascii?Q?Z4otAqsx71mE9+C1U4AumNTnt+R6KqXL2jjlQQLaj7XQwzXl3EOL6uAw0RKU?=
 =?us-ascii?Q?n51cHkeIUmZZaGJj8H0WGkDl5XrY8EN8It+mdV+2JHVHCTeuD1LJuHy1s/tZ?=
 =?us-ascii?Q?9WeDP3MDDZ0dLtLeIWTYyVg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58544cbc-3e19-4ec7-170e-08d9da95be80
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:18:13.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWPK23Vbzw/3QhK40f7da0kyreiIPG/Z0ynhuhbqBru+AKuQq5yJ1WyVPYGsbLCWoGZclRy24qs16FNxGRi0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180094
X-Proofpoint-GUID: A-mzqHsmMdkoX2A9VYJfQgf6V8COVQew
X-Proofpoint-ORIG-GUID: A-mzqHsmMdkoX2A9VYJfQgf6V8COVQew
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had these patches as part of experiments with the readpolicy I am
sending it now. This is different from the allocation_hint mode patch-set
where I use the device type to make the allocation destination automatic.

Patch 1/2 keeps the device's type in the struct btrfs_device so that we
could maintain the status if there are mixed devices in the
filesystem.

And if so, then patch 2/2 shall take care of arranging the disks by the
order of latency so that metadata chunks can pick disk with low latency
and data can pick the disk with higher latency.

By having fewer restrictions and not hard coding the chunk allocation
destination helps to cause the spillover to the available disk space
instead of causing the spurious ENOSPC.

Anand Jain (2):
  btrfs: keep device type in the struct btrfs_device
  btrfs: create chunk device type aware

 fs/btrfs/dev-replace.c |  2 +
 fs/btrfs/volumes.c     | 90 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     | 26 +++++++++++-
 3 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.33.1

