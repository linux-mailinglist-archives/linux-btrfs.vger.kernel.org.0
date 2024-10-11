Return-Path: <linux-btrfs+bounces-8842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22573999B94
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E10B2185E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF61CCB40;
	Fri, 11 Oct 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOWVx+T4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSghggCA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7F322E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620268; cv=fail; b=b4Mk1iRe0dmXAla1LyxKR5rbkFyGZGY6AVxyXDbvDOM9O9T9HSxw9IuOQ4INLqAhUhl8YGA3c0DOL0+IYzrGUVnOb8DD9bE6wNQXMkaqE0h81UpFYZwKMr/USlihbfraOkzonLZl7WSkXCltmAabewVV7qUCS3DuPus07l323gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620268; c=relaxed/simple;
	bh=CKyvzDovqVssoP9edIVoDrH+vQUYppwPxMGhzAbfGdc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TV+ccS32cdZGCkP/R+X6pHUUDWF1+K/GIr63S9GRAzZ+keIeFiE3a7OrSawMQzutNzZXz3SWit0vPOXcUgyYa/xffWx01p+EqgpeZUf6IsPr4jvCuL5IBRNr4eOV0yUztvWLcO1yU4/E6Hz64HD8LSDsjez4RRUsQ864tK7LQk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YOWVx+T4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSghggCA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdSA012144
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=ZYxz1LwjCRNZME3B
	kvC/983bh/uNgU/iFAgRdp+O+5w=; b=YOWVx+T4WnPgiTjoFVlFLd1k13Luu5bS
	QCtwBpXe1IZZBiYi614uLH6U0AWx3Bnjxv7T5PtSicGVtuyCeI9CFXWLpw3dEVeQ
	6lR5e+OaonrWOEBYL0Mydsauz4oLQ8OtKyQM3eT8BBd8zbwwG66RJe10Xrcsi363
	QRrIxTXptxLo4WRnZ4cYz/GtxEi+Dlf/J7eZMCqX1TfduuFnsVmEDtKfA1paxTp7
	QoLFWNlRG6iFfVAv9XFilp1axPdABuMk7nntZEfyStCQUeKFn86WBzSBJ5PqwruG
	/ztL2m3FR6Es7TTA/VlFe4fRcBwCSg+PiytOrqVNrP2m69z8Edq/ew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pkxsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:17:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B39OWA034287
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:17:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwavene-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8I8bIbHXY16HmevbZIrXQA7scekSQIHdgfwi1FCiXU/3Z4EfCZL2fwmdchTgAPsuAoWxVCscTDSSWDD+LYYlhtieRcUCzuOawS3k+XRS7vuCKXDxzW8hgyUZixKkJN9HzKTOOokmedKz7zJG0t6uMMZCglRoZC2Io3dk6PgNSSjcpvpvt5LjlwzAyrzd13u6DcYHM7Cg+XaTtVOwZgNBxoUczZi5eRm3J4pCdfxrUuhH+v3ebovviz7ZBENWkCakwAL95Ki0T5j99XlICvr7f20oWrQU6yKHkFdYbgBNDIbal/WBYurRt/IgpY0J+D63KGbD+8artqXnvndT+GSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYxz1LwjCRNZME3BkvC/983bh/uNgU/iFAgRdp+O+5w=;
 b=Bg2GuDhP6FlNkAhgcgEuIYwMMKd7az6mhY0u7jIhpSf048NvH5/uqsVhHcLm8qaXUbkrH6pkeKixWxdx96krDk0HN9nMVV1iBr2qlwAsfTWbhAjlq7FOfEl7eWtwOHs2Or3Lr1tDrZFprcpEWD/k4AUgMGu/rsFQiiSQD2DxS0zdW2nNjarvHQ+PSZq0BrSR6cnmL+pjM6Y/bhv1HCKPwahmtj/DZYKAwBC407CofXCjZHU3wipr84JV1kxMfvRFUg9GXoOmBJLyvKH1dsuR1tTaddU8Y0oPZnKXnksVxezp6yJP7hT/D2Agb5RMO8oWyaHfezssJXZcZx4OKCPHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYxz1LwjCRNZME3BkvC/983bh/uNgU/iFAgRdp+O+5w=;
 b=BSghggCA3CDexKerW0EQVY4zA5mJZRnitxrpDRVKRAUuDutLp8g20gKBQH85998mOIX30+X6Ci030XTFRKez1n0izgwMlK0bqSBepqll2NmlZbCHVtEnoeiVqn6JH9j5XoU1Toht4tTap7S7D0eOwTZCwZn2hmqMkPLlRjZGZVA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 04:17:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 04:17:41 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix usage warning in common/help.c
Date: Fri, 11 Oct 2024 12:17:19 +0800
Message-ID: <3ec35c42add1b57d547c9cbd90213a645c7335c9.1728459736.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: eb06109e-38e5-4ca1-2d8b-08dce9aba62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTNkNlNHbjZERmxZbGNMcHd3WGcxSEUydVhSRFI3cEZVTlNQQzJNVGk1NVBt?=
 =?utf-8?B?M2FIOXlBOVBLRi9RVnNtVXFHVHdDQXlSTDhVKzNISmlqNlpPOUhUNGppOTIz?=
 =?utf-8?B?ODhoT3YvQ20xR3lnWXdRSkV3WFFCalZsSTRraGdOODVVaFVtN0lyeEN4RFV0?=
 =?utf-8?B?M085S3NnMlorNzEwL3ZHcm5TWTBZRkdqd0tnUkRDZkxGaUxMVjBpb0czV3VG?=
 =?utf-8?B?Q2t3L2t5TjlnZ0pnSlgvaEJhclJtV0RiUk5aZ3BsWG1TbkRueUF6emVNNVVj?=
 =?utf-8?B?aG93V0FobUZ4NnI3eFpYRDdMV2FXMUVTS3IwYXRlUVR4Tm5xbk5OR0JQd296?=
 =?utf-8?B?QVlrekQ5YWhkc1g1dnRSNi81Y0d0NWl1VEZhdHhYMHQ0VkdYaG4wWmh2KytC?=
 =?utf-8?B?U21pNWUvNEx6TjN1blRXYVYvQ2xPM1k4ckphYUJUVEZoMDFWa0NiQWlDVldi?=
 =?utf-8?B?R2MwaGNYdU5QSmlrSUdaUDBienExZmNadzJodVllb1NRb0E4a09scEw3Y2Zt?=
 =?utf-8?B?RTlRK2kxNkJ0cHZvZ0JWZXNOZGRacVBFMUtWQUUvdVpCTmZORFhQMmtwZ3pu?=
 =?utf-8?B?Slg1WWpRVDhjTS9ZZ1RHVW8xK01LMS9vNU5yNGtKL0dwOXd2OFJxRnIxVEUx?=
 =?utf-8?B?MEhrQlg0bFdCTTAwbktYcm95TzVKYUp5MkFSWkNBRG5sZ1NEeXVsVmlsRDIz?=
 =?utf-8?B?UlZvbGthL1oyN1o4QWR2U3A4UU5tUk9pQmRna0FYQ0tuZitnUXNQOVRmUVJN?=
 =?utf-8?B?YmQyMnh0RnJ5blU4eHRlOFVaZFRHUTFTTWNKT2Ztc3ZjNzYwRU1xQTVNUDdU?=
 =?utf-8?B?KytVUHlRVmVCUmtRbjlhS0V0OU1LVThUc0FOb2M4VHJWZzQ4bzFRM3dOQ3dJ?=
 =?utf-8?B?TDRLU1FKK05kTEdLZ2xWNFYrUFUvbWF3TC80T0Q5QnQ2cU56VjlSbXNrTzU0?=
 =?utf-8?B?VUVUS3NKMjJzd0pVQWVtc2p2cWdhdmo5MjdIa1JwL01FQ2g1NzlMS2lQVjFl?=
 =?utf-8?B?b1Y1bjk4Z3p4aTZZSFlUSklBMTJBbnJ5bTJzblhHemJyVFFQS2xBeFpVbTZm?=
 =?utf-8?B?VjVUTWlQV0tRNU00akdYMDZHMy9xdU1BcXhKTUhpR1daSzRHWUZoYVhMTTdh?=
 =?utf-8?B?UUZUb2Jkb2xEUUtUVXBOdGQ0MDhrdjVkb0xLVmx1SFg5ak02TjY1elU5SVZF?=
 =?utf-8?B?MWxVdTBleEwxd2tQREFUdll2M2U1anh4dlE5K0RSQW1OalA1RlVud1dJbnQ1?=
 =?utf-8?B?Um5HQ1h1eVpxT0h6WU1RQ1N0Y0FYdWlpM3J3QmdFb3BJanoyTUwyUHZLYWZo?=
 =?utf-8?B?VmM5bThxR0phTFNDWGFDZnFIT2ZvaHA4a2ZGNnRQMEZiemE0VVplR0orUFE2?=
 =?utf-8?B?NENMMXpvVlhSSDMwaDg4MEltWHJvVjNxS3lVNFFRMTdrUFdWZlRSc1U4SXZp?=
 =?utf-8?B?UnFsTE9saUtkY2s3VFltNy8wdE1ZVUV5WVNNQ0ErcGZ5Skk2SWIxSVZPMld4?=
 =?utf-8?B?b0RNOFlzWnprNm1CRXhDSUR6anhqZE1lVnFLVHVJdG5tYjlCTFVhNURPQVZu?=
 =?utf-8?B?TkxUZi9aNlgwRmhWSEtGeFVaVlBEVHQwdzBqVUVqQlI5RStYSHMwRXhyR2tE?=
 =?utf-8?B?cmVqdVdDdHJGZkh2N3FNaDVYcXlLWU1xc1kyc1duUTV0cHRqNWRHSStDam52?=
 =?utf-8?B?ZTRXeHJCNXpOSytHdDNJWWI3cUFJbTZjUEprTE90ZzFKOEpRT0lRTy9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZwL0pGaFdLY1AxK0l5NW4zQ0YxbFN2LzVXUmZiQy91U1V0QmxLWHhTVTJi?=
 =?utf-8?B?VUp5MXgrQ0ZCQ0YrRXNLbDViY3RERXRzME15VUdYVDd4ZWYzc0hrQ3JIa3Bu?=
 =?utf-8?B?SFYvVExjeG0zNTlsTmk5MnlCSStHNUZMT2RqcDJjV3NTaDMrcTczY3phZzU0?=
 =?utf-8?B?ZHVDZVgxTHovSlE4aTVUZmJGdXVJWUtIdU5vNGNmWk9kS01tWVRsOVRHZ3V5?=
 =?utf-8?B?dGNFTmRDeFNHK0FTL1Q5M3ZDUUNtTHpYbGk1QncxREVCVGR2eU1uRzZ5VTlO?=
 =?utf-8?B?bGJnVmlNUnJxaEx3S1ZKTWYwRFNIZzBpelFOb0FsdEZacElYZW5zOWNFemR1?=
 =?utf-8?B?Nk5lUmh1VldWbWJYMUhsT2ZlSWJ2aW9KdC94TnpLdWcxWHJNRlZqNmxnYkZX?=
 =?utf-8?B?TGd1KzFvQ0p6YklNZzA2TFYyYVdOWEh2STk4bzNjdldtbVplZCtGTHJXY0t4?=
 =?utf-8?B?cFVTT2xicGMrMkhjMzZBMkJ3K2h5MGlPVkp4dzFIaVAwZU1aQ3pmS1cvL1hh?=
 =?utf-8?B?V2QzbXJwcndiSTljNkFHejZwYk1TZmJ6QWl5ZE1nWnFoRVgvZUpvcDI5YWFB?=
 =?utf-8?B?Vy9xMXNSWGZIbnJGazNiMFBLQThtQlVZcVlzL3NWT2F6R3g3MDZZUmFnMkRz?=
 =?utf-8?B?KytZbS9uRTFnQ0hEeFBmVFZiTVNMbzRVQ0h3aEh0VHBlR3JUTWk3b2tBR3hn?=
 =?utf-8?B?MnpUS1ZTZWdsaEZCbjlqUEJNSVp1c3NJSkZtVkd6enJQWHk2QTNBcU9EWlhS?=
 =?utf-8?B?LytmelYxRC9LZDhEa0JGc0hEMVVGYzVPVDY1N0Q0V09SbEVmT1BxL1p5czBq?=
 =?utf-8?B?OFNmOVNFangwaFpMRUMwUzNHaVFONGMrWlhqck1yQ2ljTGdwSkplRmtoNkkx?=
 =?utf-8?B?RlUrWEdvai9ZQ210WFQzL3FFQ284MjYzRUdJT3l6MmdFVW1HYWp0bGlmVGFi?=
 =?utf-8?B?eWJ5anRGMzdvK2gxdWtJSnl6VENCMFp5Ym5EOXF6a0p2dDRmMkpKSkFJa3ha?=
 =?utf-8?B?enZkUUpGQW5GczM5b1hpUGFHWlBJUlRkemFjVDBJQjVVSXk3MVhYaTR6UnNE?=
 =?utf-8?B?WU5GaHF6K2ZJT3hEeS92OFBCK3FGdUtaY0ZJcW5ZS0F4cGtsZk5ZaDFmOTR4?=
 =?utf-8?B?MlIzNmVxSmRIdWNvbXNTc2VHdXlzUHB0b1FEQkt4d2VUUnpXTDBHbE02VlFp?=
 =?utf-8?B?amNTMS95R2dHZENaK2dkeHVzTWFoZ3Z3cmg3VllKQWR5YjRJZlJ5VVVKYlE4?=
 =?utf-8?B?U1VmRU5jQUd3eSswQmkvcTVxWnR0Uy9lN3hFWGlFK2N2cWJxTmtGRkVxamdt?=
 =?utf-8?B?NzVvMXNFUUFIamU5VWk4QmE1NzVva1RuV0hYWk9ET291N1ROcks5YkxWZ2xK?=
 =?utf-8?B?TG1QL21UUEdUQmtZdWFuZ2lyV0NlbGgvMUVsZ0VOaGxjZmNIYTRUMS9ud0pY?=
 =?utf-8?B?amxMU0psRU9RM29TaVlUMG5zVVozN3cvQ24wMEEzTXZlYXVtR0NaTXQzVExS?=
 =?utf-8?B?UEU4YXFHVXR1Y2dybGtZWlQzVzZqRk4ydHZ1ZXYwcnFXY0Fwa0puazFVdlpZ?=
 =?utf-8?B?dkJlWDJweEQzcmpBY25SU1pBZEhzSEZOZUcxd3l0bXF1Q2FkUlROOVc4em9p?=
 =?utf-8?B?cFdTc0YyeDJBNVdvaE1oSnlZaXRBMFk5V0lxRmd6dXZnbm5rSVQzRytLemw4?=
 =?utf-8?B?S1I1RUU5UGdyN0Y4UGdCcFM2a0JpUEwvRmY4bnRhWXdNd2pjT3NWekhTN3lR?=
 =?utf-8?B?QzZNUno0M0FPbG5odXZHbWlubmpqVm12WUFQRTJrMnFrOEUxOXdmYmYweUlY?=
 =?utf-8?B?UkNGTURwdi9GZnpSL3hHQU4vVFVhVmdvSk54c1NEMnBWQkppVjRiY3JzNzla?=
 =?utf-8?B?ZmZLVkFGdTM2Mm1LWVg1dk1YcXNWZHYvUitKL0xEblpTelY1ZWgyQjZCZ3Zr?=
 =?utf-8?B?T0xjaUZhOWlIVGVUZHlYTG9YTkNqREpxa2ZzTitsSWljR2NUM2ZyMHp4dnFI?=
 =?utf-8?B?dHJlYmRyZUV5KzBYTGMwaVJ3aEVad2F6UDdHSG5WTmZyUTJvOHBOdWd5TW1Q?=
 =?utf-8?B?akxjL2VlWDRlaEVPYUg3L0MwZk1vRFlpOUk1QXEwMEt2enAxTXBZSXVzTHg5?=
 =?utf-8?Q?S8IYAoaQkIKw1xs0mwaXi4zWc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tc9gwpbrdnQkMditqEsdmPtwERDncf5PBeCpIPYRTlL7N2OZMt7GUS/V9BGWuFwP7qXine7sVAnpB0hnb/3VKywHoznzS6X9wwj2nmouIDUjrqpjG7DcCpHeWQZ1BcBC1nM+XGtPw1q4On3i+S1VXTRTP+9A4PShDN5QtZdAUyEksX/7ZAeiDQtQ8Apc3ew4clsKesOULh5T7g4a4sIIuWTtEae/Kjqo/wkIhT3aiRwpmbA1w6dD2URrHHM2/FiRoJlgEIAO/72nO6cZ3+Bi8dbzZHyohIsOHR6XS4aqmo7JJtvf176Bsi68raF9HXVrk3ZzHXQR6wO5h01m6qIOlCC4DcPlKkZau8uCdbxoYBR3+x+wqwUC94grR67SJCq9NrqJn9Hy7jZmGC3yf0dXRU1jykoT/nwxs4XalAuezoJhE1r0pn18j/eLgIqSVsgywcE+EUM7YAEOjwMkabQekdgwz3gfD6n1nRBcB0/0oHKSwIfOXhzJk3sssltEAIQV6DJd7OwJCfvT+Tpxw7ObwGrMZo0B9km5uhsJnf9XaWzzv8keNKVDwOVW/m6uyF7hl8pAGsf6bK62wZZd5gpR/7XmjA8sezR2uStIj3uBMr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06109e-38e5-4ca1-2d8b-08dce9aba62b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 04:17:41.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKwjhD8wQWsWVHPdl7hDsQlYiwH3P1ugOVbcqy8F/WdQwjtjr0yk2rHnfrIaDmUtE7T9gOrM6qKrqA0U9WV77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110024
X-Proofpoint-ORIG-GUID: _GktzPWtuMXDqRxu7sTxxJOsxmPtr1W-
X-Proofpoint-GUID: _GktzPWtuMXDqRxu7sTxxJOsxmPtr1W-

On systems with glibc 2.34 and 2.39, the following warning appears when
building the binary, causing concern that something has failed.

    [CC]     common/help.o
common/help.c: In function ‘usage’:
common/help.c:315:58: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  315 |                 fprintf(outf, "No short description for '%s'\n", token);
      |                                                          ^~
common/help.c:312:46: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  312 |                 fprintf(outf, "No usage for '%s'\n", token);
      |                                              ^~

The compiler warns that in some code paths, the token is `NULL`. Silence
the warning by checking if the token is `NULL`.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/help.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/help.c b/common/help.c
index 6cf8e2a9b2ae..eff9aac537db 100644
--- a/common/help.c
+++ b/common/help.c
@@ -309,10 +309,11 @@ static int usage_command_internal(const char * const *usagestr,
 	ret = do_usage_one_command(usagestr, flags, cmd_flags, outf);
 	switch (ret) {
 	case -1:
-		fprintf(outf, "No usage for '%s'\n", token);
+		fprintf(outf, "No usage for '%s'\n", token ? token : "");
 		break;
 	case -2:
-		fprintf(outf, "No short description for '%s'\n", token);
+		fprintf(outf, "No short description for '%s'\n",
+							token ? token : "");
 		break;
 	}
 
-- 
2.43.5


