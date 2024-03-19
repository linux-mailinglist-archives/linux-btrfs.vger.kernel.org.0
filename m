Return-Path: <linux-btrfs+bounces-3423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C6880024
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043C5B227C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929A651AC;
	Tue, 19 Mar 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dzkusPUB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cdeTLr49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306735F84F
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860360; cv=fail; b=tBNNFmnXqnB7m3e7zu8m4eGCNdeIZABmHo3djHj0FBDCMW8XdiZLg9dNx2O719aBV5KhTDud0K8NDqx8U6KST9YuzvdD6i1ZiVfLKMq+QdETOadFBPjeHO0uLZZusBaLixysGN8gbo/+RUnUSCqXThptiiVL3wrPJx+gQ+8Yk3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860360; c=relaxed/simple;
	bh=KI0bfSu99hO0G6FxaD+r+3o+b/edGWEGsHxvTml2L4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTc4r092C8Z24tExw4ssE58XSyJ3WtyeT1WgDBxoGiIyE5zMTpPFVTkRso+XNXkZoT2dPsXDFaDYlj/wlBoL1DLQ+pDz+KQkdflFNsaRTKE06Y+4yvGgI7Qm+zy5k+iWkP92Jc2iya9gzM2llUH4rECHXtWahKN9NDwzptRlBks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dzkusPUB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cdeTLr49; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAIN4E020295
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+2y4LX2Tf84JVFYeAVFQ3TO9rIiVtkXK0X7oUdwqGUw=;
 b=dzkusPUBP3i0lbW8McuMSQJJfPJHnsJyWzAby74sSLEVo5yo2n8FPyy+DqPDGRO+rW0q
 3ZTK7N2Y4RtRboEyMRK1PUbHuY8E5LhxeGasbFeAwGHGarnLrZZR6hN5Rlq8ZBmrqSBN
 4qRlv0vI1EOAss3Qxjd+6DK6PcDxfRrzrVSyRwp9toyZUZJVsNoFA5dEESy6xO2jXNrH
 EPVA7ZHrgzlhVRhmemjZRp7r7zSqTBFHH3IWdv8sm5fAG0rMzd9pvogJ8X7cZ7oyNrNU
 OjdoHyR/m3p16TNQk9QaX4Y0Ptoe0D2Bz0ssVf94wykHbA6BnESiQ9VZRThASYGJUAhA VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcntq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDob1b003802
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cagk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l97abukGAyL0DcBkzx2Uh6UfFtHec+XiigP7ZKiWEndf2ILXRcX5umQ2Ky0krsfW8q3Mvn+t5Lvlv0z3bRrCL80ADLXiDCi5wTZOPzLHXJ2veMmhpa/NdHLhYmpJhNXJVjbq2DgfC1q/8lPwaY6nCXyXFr1Bc/cOwywiWk811wveut1bweCUkdvWJdKViXonRjKfHG0WP0EW+jPc5PLDp6occymz548n2rwCw7Z973bEgRZlNoK8wse0FgMICvOsJokmWBT6U9LbCigIKI06o1II/jqCz8jqgVNYSwZ3NDTugzLaz0eTWIkNQvWNBQ6IulY4+OnYcqLn6MoMmT/fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2y4LX2Tf84JVFYeAVFQ3TO9rIiVtkXK0X7oUdwqGUw=;
 b=UY68h8BtbJ1BICI2opgI7HTAGlzLc+CeZPb1/qQVlC5/vY3tvOjdaoKkYVwKDtxrgPUvPBATcgpLrKbi0vyuUdZx3njdS3/uGab6fP/v7cYWAz+fpNMkxC6LJTDGVP6oI4GqIvs9NObTNolRT6wFfK4u/4OVoY49A60lhisUT6rMNNwMe+iaqqSn3bsP4eA0beNzPqqlnuIYxYeSeEwo7alia7ePdcuIUnZcaM3sUWNznrxiLf0Dnieem+CR1PpwWODgF+ieLfQuTh73V5lJq8pU6DQ/PPB//DJBPDdAMeBamV1zvvjSIcnxtTqiESQeEZ6jmrsG6pafs20mQg78mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2y4LX2Tf84JVFYeAVFQ3TO9rIiVtkXK0X7oUdwqGUw=;
 b=cdeTLr495Z4HpLfPQuQqPZBO4Svc0hXV7YukxQfigvEVA0wuAMZXB5lEimnNMyjWY2avPFrFpLPNVDsqlGVJZgTRHTg3C1TT1k/8+SiL2X9oz0FSLy+MEXYzaXzlcotBFXNFmj4/Byg8KtwoWBE9YYB5Z1pXaNmNsXbehT/NlGw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:59:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:59:13 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 29/29] btrfs: fixup_tree_root_location rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:37 +0530
Message-ID: <b9fb4121b33c2b06ee0bcee74472c117481d2555.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r07geEOIbGvaOdLDRbbjVKEf/FEH3XlJDNnvMMgitL9UHUrCYyz029v7HwbG2dZOQQK2kP3GWcR/k89kho2C2HEhQqUeOq5O2b9NKB85bDpXX+TSBXIJL81is3txA7FfI6P+saeEP6bRtcofGJDEOuqDzC5W6tqRdusTz9eu6fpNE4AS4Kp2JxeHHTd6GT1QfbP6Seith9HuceszYxw2yTuBCvNxuAe92+b8Grh+oUWFIZzK7qMlWya/tnGKdDeIqeG1zHPiqsX//8HOJo9Lizc4kwduTGPf/fdyFmsowB6KLjcMJUVe8jV4X+lU8I0QSXVKMwL8eFxQ/5qlUk3R50o0VnkSku/TYUVbp1xgvj0yAlmfIwIDguObiesurQEfD/e1HeWT08oIlJmstO3sT8XqGBBvDj+HsawuKeXgkOB9HNhl3kr1d/4Gv+uYhhuHW2j4xjuHyLPfNIf8JTVjiyhuON6ipDiAPk6WoYD1ehTfpZb5P6Vi+ZJB3PM9estq32opebg5FEkxX6blmgklJYkUyKLwxJrvCjT0nJO8PAC5LFDrKJvzMAKciLUjUwCgsUbqG54wqCXLgLNXqLpZUZpIasuYdwN4PlQTg+wLxqA2rogUiJEHmMr5BVlqQHsF/tNGGZDxGOA4EkUZ7bsvgnKbdMPBfNf6eHcrVM0sQT0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LNvo28GzRMrWq2YkOkAu5x5oJCO2iJ2OOiAzKIK5TfaQUx5E23VF3NOWd7I0?=
 =?us-ascii?Q?fpAhZ+jo71Fje7LaRwXIV6H9hCI8ASj2Ev+7D/s0sH51FaEY0xveAMbH5NHx?=
 =?us-ascii?Q?TxvvluXMyJOnkqheqI4LOsih5kUHzKL75jifrZmEMTcuHcKOXfZg9o6skMFH?=
 =?us-ascii?Q?pUexUfsnxOnSUKO6a6SHSRgSJKZCV/BWk9X564LkeEopq14Oh/5NuS7HebjC?=
 =?us-ascii?Q?TqhEOraNwp2kyyXZga6cJX1s2EfU6rlee9zWfvk6smsDXTUjqQpOCouMeIUM?=
 =?us-ascii?Q?0HKoEdOfLPnUx816eeTGYHY4i+zNHy1dIlFffi9giP/wwXE3E3lMV9qS+XG0?=
 =?us-ascii?Q?EZK6X2hmkswZ/LYEo3hK+yd0f8DSYpxF3+cKKDtxqeL2K9Jk3VnYBRyklNYd?=
 =?us-ascii?Q?0xj7eN4wiZVQM75xGy6UEhjSz+9oPsGbZv24IR+qYKX560Gu9AvjENkhufH7?=
 =?us-ascii?Q?4v/SFXFXugY1pY6ElGzmO0GccqWhfohmXqMEcNCLOvWoZUg6vV9SFavkWqAd?=
 =?us-ascii?Q?CHFkauVjdW7mzFwX3EkWSecrukT/oYR8Jb1BoO8CScpKpOZjc3SNFvJDtAN+?=
 =?us-ascii?Q?mNf+pXI5otXbv4HZTcu/KoYMbRxfFxB/2bJt6gZ72Mk5vHLVb4tgYbtNqdEj?=
 =?us-ascii?Q?sBNW7aZtobyvd3WUSPJDXqGzzXgrzU0XfeYclnQ9UtInOdePLWnxuee9XI10?=
 =?us-ascii?Q?VHQHMFmMErB8n7UFJ57TxEm4dKBknLE8F3SLsJrAkky2wLvh4x9mYYEtuHjn?=
 =?us-ascii?Q?oHhO1YW8BBhOTpGMboqnWU/rJ8zbFvYqrgja8UX2iTdmIRt9sCU45LiU5A3R?=
 =?us-ascii?Q?Y+xmAnFwS8iwZR1lXZR5FHLWWl8LGtCU+FSrS9+ob6xQTLT47/FuQsevfYPa?=
 =?us-ascii?Q?Wm97oeUTIVR6my4kaFCvbe73gfl3v7fAVQikggKayzHiPEs0jUGbygGEMUFs?=
 =?us-ascii?Q?GyVH0jHIrNvWptr2UFPezGo0xTfP6HKEgW3OPnPLlfpK0JQTxsd2NdYwq768?=
 =?us-ascii?Q?C5mXMUcGxda46q+LttMP5uinIMeFC6sg3ppaGI9W6ZCZUzf1nXqD1Hk7mstP?=
 =?us-ascii?Q?6erfeMRkU7IXBlviVYlSXvLU0rzcFjtSQ/cKoqSCrVgBeMDJsVlEnE5f8Keb?=
 =?us-ascii?Q?dPGIHIqiFp4rd07//+t+wArpZzu3Q0Q2UDLdbKH8imALdIWvVNCoYV6/lpV/?=
 =?us-ascii?Q?6sEcTraEJfnDyjwdXeBNJ4OsIRhnrOgA2I03Hzw11t6GBQSyV44tqmW+Cfuw?=
 =?us-ascii?Q?O5bE0TwCuykzfTvpTUh81CzA1oYV14pFTf03GSb9qy7CKoM81cMZ6Rbp13mU?=
 =?us-ascii?Q?eLXb6Ln9evK68IxGxAkk6pLM180d6wkbCJszf/CVGf+/sT8HP8KWPTvBmMIm?=
 =?us-ascii?Q?aPuFMdIZfFcmzL9BRKzry/96KTfL08iGkehKTayCZlsUJIAm1vBtf3b6efL9?=
 =?us-ascii?Q?gOqnIM+XXTeBQ9ztF+1c2Ci8ytvoKsPEK2vcHEgi6gpW/wvATtwEKIRbAK5w?=
 =?us-ascii?Q?8WhirRIaDnlSG89lFjSeJFXwNWN9tzqAlsVCntT0IFLRzXXCzBAJYA/rP3nw?=
 =?us-ascii?Q?F0bW6K/n6+9IN0LqyqkQEfaOanB+qNqOeZSD7aV+fR+ErJtZ2rtNtV2Khmkq?=
 =?us-ascii?Q?XDQwV3LsFRk7kiLB3vyctgpi+o11NDSux7HO9TIA4nRi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BVK0irBg7OQs4LOxhvFtrWDvkHLZaojaat1VoWjdrgQrSipdyYlIl4+eUjI1Dju5iVlBzD1iJFz60jZ5voIzwbJsyTmVxrBmW7+mgz15GCfr7Ul0+UVWHskLBCQ++iUlo8ay5SNp+EiE8Tbo1ZukKWFfWqdU2YCUXUJmulHIISHEtFIM64zCTTLQEaVNSa4reVKVBipkSUVtWI/Tx+SoiL6LO72lZtqtluvuP5PyY/vzni12cyBoS/PAAwjuzc1kr0gIUgVV5Eht97Su+nx8a4kk5YyNbk/4SqHINMRgZ/t2y4+Ow40F01I5voIRQjd9SSJcZG0YfCaXYS93DgKPUv9jJeHJlkZg/s4YIXTOSWQl6r79XujN9ACQsVEujBkZpaENUw72NGnF7yEOhaP67jE/faTt2y9HphucTS6CThgs1AZvnUVITUZaRigQk98xOn2XiXTXAUzovta3dY6hCW3gBDLmRfCP5kwgVxeZ3zIZQpTDTt9ddYJ71IKg6y79ioqUWzUAb7vvxop4avJMyzOoVGQz/OdxpOfT/+wzv+8heDZFE9njshBt40Ktyp3NBImK/rZT+62y4Odb2gTFcUzpOlAv6L0+WHHRPr5cZKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772dfab0-e8ec-43c3-050b-08dc4825239b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:59:13.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfzRsPmhtF/Wa7WW51nD2ZSjeltJhzTLVyBx10vXF1feuIN63do9O9816zEXd6L7HqWcbYCaSfVzj7UEugYziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190114
X-Proofpoint-GUID: 0wqJ7XXC7Q9r86-wy0bmRRLnCmQlbV_Z
X-Proofpoint-ORIG-GUID: 0wqJ7XXC7Q9r86-wy0bmRRLnCmQlbV_Z

Fix the code style for the return variable. First, rename ret to ret2,
compile it, and then rename err to ret. This helps confirm that there are
no instances of the old ret not renamed to ret2.

Also, there is an opportunity to drop the initialization of ret to 0,
with the first use of ret2 replaced with ret. However, due to the confusing
git-diff, I refrain from doing that as of now.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/inode.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 952c92e6dfcf..d890cb5ab548 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5443,29 +5443,29 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	int ret;
-	int err = 0;
+	int ret2;
+	int ret = 0;
 	struct fscrypt_name fname;
 
-	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
-	if (ret)
-		return ret;
+	ret2 = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
+	if (ret2)
+		return ret2;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	err = -ENOENT;
+	ret = -ENOENT;
 	key.objectid = dir->root->root_key.objectid;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = location->objectid;
 
-	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
-	if (ret) {
-		if (ret < 0)
-			err = ret;
+	ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
+	if (ret2) {
+		if (ret2 < 0)
+			ret = ret2;
 		goto out;
 	}
 
@@ -5475,16 +5475,16 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	    btrfs_root_ref_name_len(leaf, ref) != fname.disk_name.len)
 		goto out;
 
-	ret = memcmp_extent_buffer(leaf, fname.disk_name.name,
+	ret2 = memcmp_extent_buffer(leaf, fname.disk_name.name,
 				   (unsigned long)(ref + 1), fname.disk_name.len);
-	if (ret)
+	if (ret2)
 		goto out;
 
 	btrfs_release_path(path);
 
 	new_root = btrfs_get_fs_root(fs_info, location->objectid, true);
 	if (IS_ERR(new_root)) {
-		err = PTR_ERR(new_root);
+		ret = PTR_ERR(new_root);
 		goto out;
 	}
 
@@ -5492,11 +5492,11 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
 	location->type = BTRFS_INODE_ITEM_KEY;
 	location->offset = 0;
-	err = 0;
+	ret = 0;
 out:
 	btrfs_free_path(path);
 	fscrypt_free_filename(&fname);
-	return err;
+	return ret;
 }
 
 static void inode_tree_add(struct btrfs_inode *inode)
-- 
2.38.1


