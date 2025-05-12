Return-Path: <linux-btrfs+bounces-13938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC5AB42FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378294A2A83
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC62C3742;
	Mon, 12 May 2025 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eeEwzn5x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uO/eTBUr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF229A9EE
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073463; cv=fail; b=B3If0xxeL88C/+CORlFc8PeKCFHqYb9ptmMtoYJ8/+Jsh0PaEBN0p/nBDXtxMIlHwXSfBpkwjqE7A0pdY9rYPmD+1Pq1dk7FqCvA2BP55PagOxDVY0PZYArCQrMxj372Fx2vrNXo3maKqx3KrRUsr5k513tgP3OIu5sgOFvPh+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073463; c=relaxed/simple;
	bh=y/xLLQWqF/OPFmhFJKtA++HyKFWSq+tBnxaqX6RYHPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANNeRUMb0onn5kaLqcR/isI2HISNdRVpRlAahjTKi4pMBMCLzFFStyy7qlNIxFQRhIv2YOe1GB/ynfE6DtvQIU70IbYngnsYmeIw4J5dtKa3F/Y3dAPC8TXH+q/vLEsQFeePpk4rMBpUjyYxEBREUShtCGGo2rIpizQaE57wd08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eeEwzn5x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uO/eTBUr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH10E3016623
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lHFJuXgi8eMS4oB0NnyJznA3IB/E9+LUvmTsB28evdM=; b=
	eeEwzn5xhDOtaoZw6DBaXEAn1uUkULdhWjq7/pq/0bx2jGOX5xMxVIidEKQ4kOj3
	DdBkDHJ/B58tOmzmMgR/ye9BU729SSVhxsK0EkAmboHbKCskZTMtNBhob/5w2CcT
	y8yoGLGTI7Pb8856wp4PXeTAy0M/3QC+DuJ1JGvEb80Fzwu5zsKJoTylfuesgB97
	AYlVEboAwyfnbDhBTNIj/EOPWqnChduRu2RZqWTwgGos0nV1re109AacZ7ZXurwe
	v6wFvbL2PN8SHN+pg54pmfGewr2DKLMm80cGEZPHe+FU19Ncv3o5ta2ax+koH5PB
	NDlKuKBEgdG38m3WcQzu8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epk5bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHdOGd022375
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:00 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88qa9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPim0P0Owf05kO/C1HJQcA6CJjLnxiBGTl/N0maxufB1V1kxXfPqnvPnCzrjbLy7zW9qfC1XEoQU+Qy3JxjN6oF+w/cJZI1pNjfbA90pvaoP1jwxlgeatWVKdZX0iNceP8zXhs+y3BCbytARQzgDFhiFRNRRcwanxBwlk0eSQdEBRz2bugPKBZ2H6DxcHCMBPqCSKXTZZ3OoCbAZrSC8eOhPvK1ReEf5VNUJHiLdBsKQ+IygtMtcM1E0YCCJjAW4R3yQ2FvUAokQziBTBNG2UsgLr4TD27dwq+A3LNkz+E9IeSjF0m0TeNiAzkC/maIuN/JAs+6VxrfJIrfcYUv28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHFJuXgi8eMS4oB0NnyJznA3IB/E9+LUvmTsB28evdM=;
 b=CwpeafAK7SYqmfSiYIxUqjg6ov/fOA3GeGoXAFUmXetxMXtdF5YSgyp5+rwIqIAh/OIsRbn2LOcHqYZ7L1NdlcEIbA8o3uniULA7VV6iNy9JDx2YsAITCZ9SMSdK6jaYLg8q4vY2wduc8WZy1FPaY2kWzF42SradS9OOxMwTskGhCnTGjwl4zLZFdtnqSPUWQ6Hz6XwXKUx5OsqQz4UsKQfRcWlvtX+FMjlh+ENGIaSNFw/UZPiJ+rgbm0X7SHkx/+nhBrOzvtWJLrNJOWzmXo8U4ccXqdM/BaAE09i+L3rvprUk4ugytRZ1L/IIyllx4Vw3YmTeWmMSunVpTO57Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHFJuXgi8eMS4oB0NnyJznA3IB/E9+LUvmTsB28evdM=;
 b=uO/eTBUr0XA1hkjfJ2QklsKjfHnPx92MiL13fxXb/CWfFvEPKtpibsdqNzKZTeUEsLjYqxgGIpBUY431QN2J/yUpML3Q6EdDKaqSgYq2CHUow44m1aNY5/XhbCoAtbv8xAsuBDG6EJbsO2foloI/vK4iJorNl5S7JxO2nORsPWU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:57 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/14] btrfs-progs: sort devices by role before using them
Date: Tue, 13 May 2025 02:09:27 +0800
Message-ID: <e2c01879bcaee43fa60a8f53e73941fdfb887ba9.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bc9060-977f-45d7-e84f-08dd91805807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++RZAFzT8tbmhvesO1VmOlHpVKMyAz/amlGQliN/uhsvi0txYdbIleLq+S83?=
 =?us-ascii?Q?8TGKUlLxipRA7PK13SzntL2ZND2JzyiXE2GoEIYUsybDXPWzmQ7cAl5bnoUI?=
 =?us-ascii?Q?uLEBTMcXKoMvVAG9pgV/wbmcjiWbbACOypqotD42SVc9tLsuNM8gMAr9W0EN?=
 =?us-ascii?Q?fgnX1+HGdskKBeLyIHS+Bgl11tlmLS+kFLckAfOwxPDtaB0ATARmJeSR9cqZ?=
 =?us-ascii?Q?A2OnSWSA/laouh7fMOf745K/tx2zmOvd/IzRQNj+0m64d4KNYl4ieGsPsn5x?=
 =?us-ascii?Q?X3yicW4h3++sslrUh3tG5tqtZPKzUA9WAiV/n1xOmNNmsOt0mqn2Y8oOnjFS?=
 =?us-ascii?Q?+zaTS5tw4m6y7YVgvMIC9zgttDgpTD2hz0bcQj3swQwfIyfOLFojkVon2mox?=
 =?us-ascii?Q?gpK0HHNoOX123TlrkGcs79761xyP0aQITZ6bR5318F001l1g2KQzpVdzGah6?=
 =?us-ascii?Q?vYveBHUmRXLp9OobSjKJBT6ufJek17iZg3NBzll2Ze/EwkAB0X0uezU9gLOL?=
 =?us-ascii?Q?d+sdrxC39Vb3VWhYGtUlIeYiMk92Y93m6afF6YjOmcXPCviuzCsNANiVXIPL?=
 =?us-ascii?Q?aHhe/jouHaqwULV6AleqLtdNK98CzGy6a1k5hAFXgelmJ/RMq/Y4SN4i7zRS?=
 =?us-ascii?Q?cCkGt+y89984ZaE04Z4bPwSItvQUdf2AqSlBXeXB3YQxTjzg8QcCEX/rt4Lv?=
 =?us-ascii?Q?OdNzXtpquKQ8Ap8TYmkg6VGLxEFP+9Fu1alcsl0Q+tcEx2KglnjLRkD+xjRR?=
 =?us-ascii?Q?PWaua/xvRO/9ARzOsvHwjex6UGWnRj8zl1gfJAPSlBQsPnXEMHJrbuXwQBFS?=
 =?us-ascii?Q?d0oU6HNxPXpL2dkQESMLAx0G5KiI4E8vdFpK+6m/+3CrhU0rM3nbC6buMkv5?=
 =?us-ascii?Q?MLiZ35Xj2CqHUsh1qaZtHZaZJ9dK2/BF3SEBGDL4usK9zWT4z7deZTcDEf3y?=
 =?us-ascii?Q?zun6FDK0JeMJGqD6xSgIflypNV7DTPng+FgmRV7g04wpP7YRyYZk/RCzlP+p?=
 =?us-ascii?Q?D5NnnmMOryGvAK9G4RIFScw2j/xbID0+OYLnfxoBOzjx+8gY0U9TCUpJcDL9?=
 =?us-ascii?Q?6Vpd4Eqth8e7/F2yo1BnAKgi6F0ccNsEkRSy1YfSjqqe/a/a4Oug6/UQw0hp?=
 =?us-ascii?Q?w088lqh+6AOkKptkoATxuDdUCEuWRFcGMYSf5bWKCCq5Dzbj4fIa8SmgBFO5?=
 =?us-ascii?Q?ssH1O9x3DnqdgDN7TEGHpDXATYAvjsowwP81JBH4StWUwq6Lcl4x6zKFnjCv?=
 =?us-ascii?Q?viyqRcVlC33v3wisG14lfw4m5AIpr5cybkOMscqcrFi3cuKMoS75WGEd42++?=
 =?us-ascii?Q?9UroLMq7cjXGxc4pQicHT4+bJvqpX5inmbZPLjXzxMgSXgMJ6JphgUZLcFNi?=
 =?us-ascii?Q?eRkIrn2hGO6eaq5+k4K80FKLTzWQURWufvFppv3/HdD/YN6Qi0kWmpPnc3my?=
 =?us-ascii?Q?ml9Q4RZe8To=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TgYT9Kry2r5b/KgA7UGms5V/M9a/NsnUom505FKxblAf3QpNK/Pa98u04brB?=
 =?us-ascii?Q?XXbNR/ApdJlBAR6V5AD8rP6buIB/15xQpAHBEkTVVwjTHkoKfFaeyjzeT/cX?=
 =?us-ascii?Q?m6oj9syafmSS/4ThNQERnXTlK4G6+Z4nnVgt9InTxEy7VFmQ/cVb615lciPd?=
 =?us-ascii?Q?mvjMd29W1BIvAHw2Ngtjhc5Yji6jGdxP9CA7uZn7VxBppnR1lUqBwt6gbyaC?=
 =?us-ascii?Q?S41Vb2p4VNbr//w2V6p1i6jEpCN+xeHLuhG51payLGtCR+AaMHWw5LJd5k6Q?=
 =?us-ascii?Q?vc+tbT/UY29JQOd3hAVA6Y4nTdeNPKzRRNRz91h3fNeN7CDX0aXnYCeO2TNE?=
 =?us-ascii?Q?kWGUR1bbJXYmnd6kzr35J861mtfCSJQccyfq+eX4X2viAdpHhBfQYA6M6gIQ?=
 =?us-ascii?Q?ytMonFSk7+CRemtfq8Mh9pEp8Nihd52/d0b4aMbgqBhkWkAUgWx3x2S5OLK9?=
 =?us-ascii?Q?CECXYTLDsJyoo/EmPjQgDF8aN96aRjLpn8quONKEaaoIBr3Au+0NQhPAranD?=
 =?us-ascii?Q?d7ylQ6yK9vtPiLDIsLHPu4wXGWU9GJcuGbd3sX6cJD0UiGCSFFFDqg24nlKb?=
 =?us-ascii?Q?j7OGqQQI2gLWhYyYZXXXehzBWZWyt12KMYx/wqqIHT6aM6PfOiSmv4TVreGP?=
 =?us-ascii?Q?WifR9Cy/CB2kcus8a122xZr9M7InBe2M7Yyt89nA4ZqBRhywm2hpPPsyo4uU?=
 =?us-ascii?Q?FCQ1gVsNx6KbOe6gdhWBChMI6R6SZ1GR3Apo2nh1spu6p/Uyedz1i3rkFXMY?=
 =?us-ascii?Q?0cpWngmxcReTh76swqp/qDlbe+Ywb0U2N8U4xv2GolsLVtp3f2i2Gw8rJUH0?=
 =?us-ascii?Q?AhFM/HySAccp34FYL/5l5GUvGVr121bTIaNViq2z6nIpsP1H+ZgTZS+AnWKR?=
 =?us-ascii?Q?O24sEbyYJEVv+2QMuYOJ7BIqOvduCJtbgKrOFJWUdewvhsazoLfoWrMc9O2w?=
 =?us-ascii?Q?xBv18GPPrhyyXLu/DodIQaioh/IB8uzTBwD9y3gYmfJ6GNk4QWxx8LeXX2IM?=
 =?us-ascii?Q?/YGvmcN3bDf2XSvJjGsTEcQn3L5rPYObLJ0OpTCzKry/7TdHqCFtjTEZSfu+?=
 =?us-ascii?Q?6FPoNh4Vi7pc3fnms3mCGNvBv5+xsO7W6U6kvOGejr3EBckgEpB8nthUONFH?=
 =?us-ascii?Q?kL4SYKf0Ky0460Gz6Xostbwh1OQYiuxRw15Qcbw6wMyWCq/wLSoHU2ev38AT?=
 =?us-ascii?Q?DB6pcLTRFsD37tuJQ/RQvEi96slyUhrsZzXbtXf0ZPuPWrSXBhYsLzpLsM2z?=
 =?us-ascii?Q?ABcCTTm6g6JjVb6/jDMGw4xj7z7S40+YCNj8hSy12LOCtoYlELJ/QI/UHbJE?=
 =?us-ascii?Q?MdUjDlvIdUcl743InhxT6niol1LSr7f8rCTLzpMUq70v7OyGQy1DMc/ZEPtB?=
 =?us-ascii?Q?hQlOUIJRwPLGIqiElld9aZMl6C1rBku/MYQs2LtOy9JAXqMyKG2/Zk0Xuf0c?=
 =?us-ascii?Q?a4XGyyyuxGNVKKgGVHWULrjl5m+tutCOBE+C2z2CBHOJXEuliX64k/A32DPV?=
 =?us-ascii?Q?uRW76zUyZxQjFpajVcFOkCXfVWEwE1TLSgV798RwmWrI93cCDeMXU3YA6Z2Y?=
 =?us-ascii?Q?KW7/n3JDb+nX6gcknUJaXoz0P2LYe3UA8V4yo9yR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	33OjrTPn3ygy5NfpWfFupcDIMzd8mq+/E84Wijq2P/Ynt5nOYUBuujshbOuFyFzoZrXIgUv/EsZz2FWqyLvuCKcgx1PyS5O2cf6TZouE4GSxm6iUSqT1rSQD7UHiYiGYnA3p/QfYUQURjt/UWNWWtW5GTlT6/uQCBCIPalm0WgILJuS0ofQ8I6CBxWqEkJe1hZtiVevCyB7MnQueHcRkcN70y73z/u7sjUroLDQ+gTMUMeI656YXxEoWEaV5Vrp1DUXiCPVaZhqwMNpu+Vsakub/NJENnrhrKnumB06tYukBdmBZRn8VV8YPgKuQ10dFnMWutqUVligB06bDNTAFCoxzGHrcSwG4nhw1zRv3NNu28Lo03YlDqG1HIq0z3RuG4BY6gTd9DYfZlZT392bxhVy49ubhWpB1d53kpvXp/1IkaLFfW0OPt6O03wJP8FqMq5jzWgQGgAlf73g4ah25lwScgoVqN9fySwhcApOHqzyTDLVShXsdCukzuWfaxGmLiQ8oIAi1LYiuPBrqvHG/YcB3skxXI3tIRpJvzF1mCXjPIGPk0t9F+dfcuWUrwBB34i1Nboj2ArHYqeWaM8N4LmPpBsU9+f/W2wDFQiVp/Xk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc9060-977f-45d7-e84f-08dd91805807
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:57.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMOHbuuay08YXRiqPUzcmeanB55Ogsq7Ensy0SbgpJV0lV7Ug/e4RrdqlkIW6PM+rL+58WyPoY2Ax06KQRjLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX9sr8ork931Oo C/AN6bt+3NeawarHXmJlTlOfbDL8+jbfNuSff+R9+xouQEuv83JMyOjrFGbSsPrC0prQTjjDx3H Zu/TA7Wq4olVCSc4/uV+k02cXJDyIgnyvyWKWY384d8K+dBHxocAiPrDLjCp9sxpZbPC9d+QbgL
 2LII+DVWFkxYzu5TBQMO13SketNk5kKTofSLEOeg+Hhk46IRBxTTHrDGVP5BlmcC3++K3+Gp85r hUQuDxoXbktSknxsCXh5KwQXMgFD4zWEWgeqNDWyDuCu5Drb3ZAKVbIUZxiKzLBqG501niCU8/t my4bqYZsFJaG9IGlK7QbDFfih6BEaQRJr2T7l/uIkLIZwN6TNwuO1nCkq16oZf+yMKLgHrBtQvy
 gMyBrDXZ6tKIFk9XZvWyiWoU+oVmWoE2MgvSoNx2ddZdRJOH1U0VeW1pN+chHzEC4xxPTMjg
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682239b4 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGUEWL77nNM5zh0JKWAA:9
X-Proofpoint-ORIG-GUID: tIhAP9w6h0UWLdCgC4oeK1aoJAa7TCYg
X-Proofpoint-GUID: tIhAP9w6h0UWLdCgC4oeK1aoJAa7TCYg

We're sorting the devices based on whether they're for metadata or data
before we start allocation on them. The way we've set up the roles means
that sorting them one way works best for metadata, and sorting them the
other way works best for data.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/device-utils.c   | 34 ++++++++++++++++++++
 common/device-utils.h   |  1 +
 kernel-shared/volumes.c |  5 +++
 kernel-shared/volumes.h |  2 ++
 mkfs/main.c             | 69 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..84883e551899 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -35,6 +35,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/zoned.h"
+#include "kernel-shared/volumes.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/device-utils.h"
@@ -653,3 +654,36 @@ int cmp_device_id(void *priv, struct list_head *a, struct list_head *b)
 	return da->devid < db->devid ? -1 :
 		da->devid > db->devid ? 1 : 0;
 }
+
+int btrfs_cmp_role(enum btrfs_device_roles a, enum btrfs_device_roles b,
+		   bool assend)
+{
+	if (a == 0)
+		a = BTRFS_DEVICE_ROLE_NONE;
+
+	if (b == 0)
+		b = BTRFS_DEVICE_ROLE_NONE;
+
+	if (assend)
+		return a > b ? -1 : a < b ? 1 : 0;
+	else
+		return a < b ? -1 : a > b ? 1 : 0;
+}
+
+/*
+ * Sort or reverse sort device list for metadata or data.
+ */
+int cmp_device_role(void *type, struct list_head *a, struct list_head *b)
+{
+	const struct btrfs_device *da = list_entry(a, struct btrfs_device,
+						   dev_list);
+	const struct btrfs_device *db = list_entry(b, struct btrfs_device,
+						   dev_list);
+	u64 *profile = type;
+	enum btrfs_device_roles role_a = da->type;
+	enum btrfs_device_roles role_b = db->type;
+	bool assend = ((*profile & BTRFS_BLOCK_GROUP_TYPE_MASK) ==
+			BTRFS_BLOCK_GROUP_DATA);
+
+	return btrfs_cmp_role(role_a, role_b, assend);
+}
diff --git a/common/device-utils.h b/common/device-utils.h
index cef9405f3a9a..4c832047756d 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -59,6 +59,7 @@ ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
 ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);
 
 int cmp_device_id(void *priv, struct list_head *a, struct list_head *b);
+int cmp_device_role(void *type, struct list_head *a, struct list_head *b);
 
 #ifdef BTRFS_ZONED
 static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t count,
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index b5b1a53a4a90..e70f2bb9bc89 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -26,6 +26,7 @@
 #include <stddef.h>
 #include <string.h>
 #include "kernel-lib/raid56.h"
+#include "kernel-lib/list_sort.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
@@ -1726,6 +1727,10 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/* start and num_bytes will be set by create_chunk() */
 	ctl.start = 0;
 	ctl.num_bytes = 0;
+
+	/* Sort devices according to device block-group type preference. */
+	list_sort(&type, devs, cmp_device_role);
+
 	init_alloc_chunk_ctl(info, &ctl);
 	if (ctl.num_stripes < ctl.min_stripes)
 		return -ENOSPC;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 2bb299eead8c..bea772a9681b 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -351,5 +351,7 @@ int btrfs_bg_type_to_nparity(u64 flags);
 int btrfs_bg_type_to_sub_stripes(u64 flags);
 u64 btrfs_bg_flags_for_device_num(int number);
 bool btrfs_bg_type_is_stripey(u64 flags);
+int btrfs_cmp_role(enum btrfs_device_roles a, enum btrfs_device_roles b,
+		   bool assend);
 
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 0bf6938f9026..2101e63c80e6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1047,6 +1047,62 @@ static struct device_arg *parse_device_arg(const char *path,
 	return device;
 }
 
+static int btrfs_device_update_role(struct btrfs_fs_info *fs_info,
+				    struct list_head *devices)
+{
+	struct device_arg *arg_device;
+	struct btrfs_device *device;
+
+	list_for_each_entry(device, &fs_info->fs_devices->devices,
+			    dev_list) {
+		bool found = false;
+
+		list_for_each_entry(arg_device, devices, list) {
+			if (strncmp(arg_device->path, device->name,
+				    strlen(device->name)) == 0) {
+				device->bg_type = arg_device->bg_type;
+				found = true;
+				break;
+			}
+		}
+		/*
+		 * This may fail if the device scan detects the mapper path
+		 * while the argument specifies its DM path. Use MAJ:MIN?
+		 * However, get an example first.
+		 */
+		if (!found) {
+			error("Device not found in the arg '%s'", device->name);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int cmp_device_arg_role(void *type, struct list_head *a,
+			       struct list_head *b)
+{
+	const struct device_arg *da = list_entry(a, struct device_arg, list);
+	const struct device_arg *db = list_entry(b, struct device_arg, list);
+	u64 *profile = type;
+	enum btrfs_device_roles role_a = da->role;
+	enum btrfs_device_roles role_b = db->role;
+	bool assend;
+
+	assend = ((*profile & BTRFS_BLOCK_GROUP_TYPE_MASK) ==
+		  BTRFS_BLOCK_GROUP_DATA);
+
+	if (role_a == 0)
+		role_a = BTRFS_DEVICE_ROLE_NONE;
+
+	if (role_b == 0)
+		role_b = BTRFS_DEVICE_ROLE_NONE;
+
+	if (assend)
+		return role_a > role_b ? -1 : role_a < role_b ? 1 : 0;
+	else
+		return role_a < role_b ? -1 : role_a > role_b ? 1 : 0;
+}
+
 /* Thread callback for device preparation */
 static void *prepare_one_device(void *ctx)
 {
@@ -1237,6 +1293,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	LIST_HEAD(subvols);
 	struct device_arg *arg_device;
 	LIST_HEAD(arg_devices);
+	u64 bg_metadata;
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1605,6 +1662,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * Make sure devices marked as 'metadata preferred' end up at the top,
+	 * so that, it will be our bootstrap device.
+	 */
+	bg_metadata = BTRFS_BLOCK_GROUP_METADATA;
+	list_sort(&bg_metadata, &arg_devices, cmp_device_arg_role);
+
 	arg_device = list_first_entry(&arg_devices, struct device_arg, list);
 	file = arg_device->path;
 	ssd = device_get_rotational(file);
@@ -2064,6 +2128,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (opt_zoned)
 		btrfs_get_dev_zone_info_all_devices(fs_info);
 
+	if (btrfs_device_update_role(fs_info, &arg_devices)) {
+		ret = 1;
+		goto error;
+	}
+
 raid_groups:
 	ret = create_raid_groups(trans, root, data_profile,
 			 metadata_profile, mixed, &allocation);
-- 
2.49.0


