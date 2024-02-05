Return-Path: <linux-btrfs+bounces-2105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C38849928
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B3D1C215B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D701A58B;
	Mon,  5 Feb 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZHl+7ESC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5MMr7Rm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8705199A2
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133531; cv=fail; b=rUmnejeEyW6J/P6nzj1zVmbPdST05hMwabR2EGgnakV9R2cg7kbZ1NhJxgDRSkeH/IOCw/eGMKS0XYdphbu/1d/HFpiQIf3sjfWXXG0+3kzO+x6fl+F2aoldcpQUN+l54r9mUT3GhBekHX32prgF91K9+NYAmiM2LAePugEg1iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133531; c=relaxed/simple;
	bh=GicBFwwgbPgc5sIq8JPBHldzDLQNLG/GH6Q0zp5LFeU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D/2AURLuHZq4WoRd5EKuoJOkkHeF7GoM9hsogJ/Ie12vXr57SYD+8bRsKzsW6sV5G8nUM/2EqkCquP1GqfNFCKzXqqO3tLMeuPbGBsQIBxaryxVO2MBGpa7JqaUNhmIWH90NIKmBKAlJJsxogIAqF+QtMza0o23He4potDcFjhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZHl+7ESC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5MMr7Rm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159OgIQ016645;
	Mon, 5 Feb 2024 11:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=UTyHan/yHKvl5SZUE1wG5n2yFcudTEoFCtR/HisjWaU=;
 b=ZHl+7ESCJ0Ak8iSUlekQu8J1Ln0M3mL0p0iiiAdtI8FsRz4TnkcqiDN0ZCS/itzYTNcC
 OQ/MXQAjcSCL90U9AY0F/EEIL2gtzzVcJzHBsEHAz+euHBxDw4yPjf6FAn8Cn+TKRF/7
 9WvYnWzAU/PEKdIPIqDqbVX7U/CsSnoUQ7VB6yp6yYebHKBMthd3FduQ1Frr0lnJSh7g
 iCLhIyEn3X9+P2o9KMYEkYTrRmbA9z1T8SQy5PbkcGYDcGZojZWr2vOA8P74QiBM8lY9
 VCI2C5mnh0PAm75wyOCadx8ML1n91VRWpeKmlK4+LylubhOQ6TFiGM2NQDcbs3mvyMsH UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbbmak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 11:45:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4159tLtQ038405;
	Mon, 5 Feb 2024 11:45:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5kba7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 11:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJVG+KJIsBWoTg16ZdFgZfVE0axdmGBionaxUmKKLP4YcX1pHGzlpM/4F7RyVg2pIcTZBttoOENna+5m2gjsH6t0zq/EzBOnnlG25Yl+hfcAj/zqAKIaXGhRR2xO8eXffVjhJOsiqfnYYD6rXSK89yuDzuzMHLhkq0osp+6uekgiE65Z4f1+stLWMTH8+IFRLo0bpOPO8NX2SldXdaP7d14L+4BoTCJpJsZuUObiZ/9p9nSdAhjROThp/BYZWK7YoUEmiLErL6UU+e0f7RBnmnmqSIKKCNrf0ojLbyW4bPygv9EZOPfhwFQ5nCoFKn9RFdexYOkthraNnTpH8Dd7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTyHan/yHKvl5SZUE1wG5n2yFcudTEoFCtR/HisjWaU=;
 b=ZlwL5847hK8Fjjk542zAuqgUHyKCmQsZz6HLsr6LmT9IGrXtlr6jVR5rOHqHT4KQAWC8gRB7q+wvIoVfv9rfUPm+9HHCzUN0sigveOKum/jAwmjRLCDrAw0V2i6/ln05Or18SX3f8Wdga/uy9fkjKqzW/+cYWIFhHaN4TmhnwgEuAdWkOGKM/aY+pBkjekjWGlD8i1iLyebwZbU1FD+kkfz59vhZTCLNt3A1I3qo6iOiN3Fz69HsgZnIKb6g6tY9mVbsTqp4/tNWNkw6+Hi16we69VPLkSLMymvN6p0+YL9tJSIejKs/eZyPz+QAzLQUwGZQsF4xJgGXkqTJ9v6VbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTyHan/yHKvl5SZUE1wG5n2yFcudTEoFCtR/HisjWaU=;
 b=D5MMr7RmPUIblwtjGFw/n/RfRiCl/3honcamfKWENUZGRIsqW5ZB/QmozKG0D0cgfpaQX0ifXMO5UIxoJkWU1ITbbosTW89+vOXKTYuaLh/3HuDeHMLVxQzyiCrlOGaFj9kpa6S6FeWVvD1JBzKs3hIAtqD3DE2/i+8aTCLMh4g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 11:45:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.027; Mon, 5 Feb 2024
 11:45:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, aromosan@gmail.com, bernd.feige@gmx.net
Subject: [PATCH] btrfs: do not skip re-registration for the mounted device
Date: Mon,  5 Feb 2024 19:45:05 +0800
Message-Id: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb37032-8d4e-4102-d7fa-08dc263fef3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zYx4c3Ug60hla+KLkARTokWN6pqDM1tQBj993vSg1z1yPFGha3KhUZjCNG8fwI64tfkgpHzIP1IRhL9L9lFrl2qC6I8KPD+Y2Yw9weFsTO2gqyqD/JhM1I3qtUEZNIWXE2/ZaYFXi1Q3PfxvnwTYPLizFYCeKIKg6/YKUV37I8MPyy4wrxSY5WuAg3JO0JLRIFH2Zpbq9Y3dU6yWVHWKnuxCbvaLBcj4uaVg/1iqkoBXQp6A2dmJ0+OE8yO40JZ1Admzv3rRVVZLm7i82hbzzXa06xbdarKVkyiJk+oefOy7tsAFzDGN0sjzFe62QAR6txLRQghiMdOChR1IIogXzVt7+pmiNh1xyxuz9w36HwdcKvR2Tr4ZaM10fDxCl7rzBt0z2I/msz10/IrTuODhO6sd1tgYhcVtRr0cZSJFJXuqvKUZODEvDF3NXxkOxfk5sxHSUVoiaQIv9jmjrf+oFHrGulRPDO/BZxBkVX0ASLF1xBpFJQ9XBkfB+oJLGwRHsqikU8dir/xlcwrMxRJYoK2PpZYE8nVZVaS9BtjGR4MEAYhnhYMafdbYlWEOilYi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(6666004)(6506007)(26005)(6512007)(2616005)(86362001)(38100700002)(36756003)(44832011)(478600001)(2906002)(83380400001)(5660300002)(66556008)(66476007)(66946007)(8936002)(8676002)(6916009)(6486002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2QLzVD0Evv6JjiaHCimD6X8Hc7mbOh78V4vOOXcr+oZLMPAY22lgsHyQKLyq?=
 =?us-ascii?Q?16tJYOPfrclf71wNO/HYMuZJSN2Mi4a0x0DX+/VHX9TMmm0xb3Fgi4nuhfm8?=
 =?us-ascii?Q?KYUdpeckZqERGh+T5MOuUwhcSKIQo87CasUAet6Il3/FbUB6Ger4Pse82HHH?=
 =?us-ascii?Q?xMwC5dvMQNnX7Dau7XrpZpkIuBMUuyRQkThR77G6RNjoTP4+6hHGtpvA1NZt?=
 =?us-ascii?Q?VYAHiD+b34HYNrd7OsIT4XZPWDqTI+7Hwmge+7bvzFGPbgzQe3QOoVFKZszm?=
 =?us-ascii?Q?g/LWadq82v7rLDhyxe+3MMxPN1LRsK25knSTrXXhqVPch8QFnDPzyAyuioae?=
 =?us-ascii?Q?VG38mwmPJBwvQrczq4iVjMiKyFGy58CdfokOJVBq+hNKlbycXPTXR35D4sZY?=
 =?us-ascii?Q?+0dRKq6VR9C5Nc2vj5320bbDvAMubcxyr8T5ZvhIzqsgfDG0b3Qr+oyZWgeP?=
 =?us-ascii?Q?E+oS4ib8KqZCUtwZcI2AOcM1Zx+qS89Ly491gLADzwFbSsDqU6krPt1yckrw?=
 =?us-ascii?Q?wrRIS4INAhhY8aluDiaMTS2ByB8aLMj6CMnK5lOjEfhRBYGe0jtXy5Wmo826?=
 =?us-ascii?Q?LFxhsN0brvm1g6kIi9x/fjSOprXOMTxCqDgrDsO09gUYu14m+3IPndSgz5Qz?=
 =?us-ascii?Q?d11GgP+biDlQia0bA3Xwhw3wJSKbVEw7rh+WMutipbhwnfwILStvoyi4XxE5?=
 =?us-ascii?Q?dtsyfRn3adZSm5GlrlT2c/c/XJuO7KD3qgGOliJDizY2a1Odrv9EN85NNz9D?=
 =?us-ascii?Q?1AzWedEhPQ5hOmTOL0Wc09z9ahU3y3X9Asu6JnJiTNv3IMtGTddqQkDmuXLC?=
 =?us-ascii?Q?2EinGz2opyL3W+/uajBuPhpcZqA/hDIm/6NUg3HjBqb8I601HSs9t3jExajp?=
 =?us-ascii?Q?WByizz11vAejhOA34Rf225So5m6ZqI677Xv5coimqDYUaqsOHHZXiZwajKly?=
 =?us-ascii?Q?4MatA6SJtObyxbSiLh9NwKkpPw6wV6ffqy0PpUziy7E6oOxTk6WJQR81vdhA?=
 =?us-ascii?Q?wbAGT2ruScblWkfHO2oyXcabDYVXX+iQ47a0ZbN80TQrd0JLR+cBfVRHJ85A?=
 =?us-ascii?Q?bEV+sepXZW9lZbRH2ZzmOo3suVJ9x2n59ufVesBZXb1WcE3u08xGxxSaNlt5?=
 =?us-ascii?Q?t85lgxERrE6ur5wdjVlLu5BPuhCChHc9+bVTTYTmORJMB4293HQc76tEYjhP?=
 =?us-ascii?Q?Branra80e37cE3P9Rs2SI2oMMalIL/6asFQ7/PoBRGTGaQlnidw7jIY3mYix?=
 =?us-ascii?Q?cge4UJ5P01H2kMJBmQTN2/84YHYAFKMSaXeclrB6SUYGk8Gz09ERN4A/CeYD?=
 =?us-ascii?Q?A0XsS6qk+SukpjeIhZ2G5mmv8v/mogkI7804frC1FB3EiOF5JWff5+xJ4QDE?=
 =?us-ascii?Q?erXkOSHzd64+tIbH7ItpTTcbkFlL5Gpb/0OF3HQLAeyqQPSGL4QV5v8cuSJA?=
 =?us-ascii?Q?mbGNAYEt85vNXxCsPrB5E0/Hpp1SZWcJ0RABv40UaXJPUez+pNxMYZF9Buf6?=
 =?us-ascii?Q?WMnDlRJwuQ4aYWIhOk6n9xxvCZpYVFRtisQEmu+viLnaHm45fo8MkVu0jvEO?=
 =?us-ascii?Q?SyURtauOWL0367Qvtb6dv7jts19f34VTzXaMHg57?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EZGjcpht/ODJIsQOA+UpkErGpFey5/W/ricCE9ohHMt5HJMO/228VwbIwc6aHhEfursR9Y9O0mdNwvipdvhiQzohl3PEDOdAixBpZYQQMhZYTUFhv6ktznpmmn7cWQk/buX7VpOOQoKA8VGnV2CnVpovfj3uQaxgLFGKWlY9QanUH/KLbX+pDZaB+uNAp9ZV4Wi0H09LB8VC5ZdhMuF1+nQSaMiPialhB2mKwvxiJC439A8Vk33pFNjG2lrIp7I4vwr2JMdRkdIFW6a7N+cwrjnTj30m08Qpgi2dyzxHWL/l6ZSepbi1idvivQzy7ye/pPalD2GbgeUahzzDvUNmtN3NHLVNbuPM7ufNuGi3XYf+DB5+PTu+0kgMYemTML/RFeaTJewxYY0+wIHrqoB2i/prS/yWc4Wlpoq1ky2d5TeFxkjiVLEVkYfDU6WQHDx6IWgAQAaQt2EK4+jVGUtBwWcbf5PA14jU5A7i+MJqHua3HDo3b3DJEp1K76gpAXSzkYySyMG+t5s/RSPtcIlVj2r2CJo6K1rRGNk9XCPfwVNBjd7Mmk1Lltgc4UM2OzNa2PvMssTRq1ZD4A4i0WQUmPTt9xfGwNRtYGXvTuf4LWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb37032-8d4e-4102-d7fa-08dc263fef3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:45:21.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By3NQpDlEbEYnGkq+keLKRaREeHuf+w/qnCeztpYRIxZcRAPKBORvnaBgUFx1uB14cazbGiHbkflsmZDmzHT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050089
X-Proofpoint-GUID: ux6e1k-xL7tn_mfCS9ReZTJceriQD6yd
X-Proofpoint-ORIG-GUID: ux6e1k-xL7tn_mfCS9ReZTJceriQD6yd

We skip device registration for a single device. However, we do not do
that if the device is already mounted, as it might be coming in again
for scanning a different path.

This patch is lightly tested; for verification if it fixes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
I still have some unknowns about the problem. Pls test if this fixes
the problem.

 fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.h |  1 -
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 474ab7ed65ea..192c540a650c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    dev_t devt, bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device->devt == devt) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1316,6 +1341,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_device *device = NULL;
 	struct bdev_handle *bdev_handle;
 	u64 bytenr, bytenr_orig;
+	dev_t devt = 0;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1355,18 +1381,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	ret = lookup_bdev(path, &devt);
+	if (ret)
+		btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
+			   path, ret);
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
+	if (btrfs_skip_registration(disk_super, devt, mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s\n",
+			  path);
+		if (devt)
 			btrfs_free_stale_devices(devt, NULL);
-
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
 		goto free_disk_super;
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..4ed281f0d1bd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -792,5 +792,4 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
-
 #endif
-- 
2.39.3


