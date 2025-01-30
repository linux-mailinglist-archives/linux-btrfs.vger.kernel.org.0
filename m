Return-Path: <linux-btrfs+bounces-11184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E1A23505
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 21:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367F43A2641
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A021F12F2;
	Thu, 30 Jan 2025 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PXNUMAfd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKrf5Q5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842F4A35;
	Thu, 30 Jan 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738268530; cv=fail; b=ECHjZgX5dBWM29gsKGPmORYb0OzY6It2Pvu7QH0OOwvKNXXNa1qEFR0Z0uRudCTtp+Nt8f/MPpClNhyn1vV1FaUiv159Ubmh7TrOILymw1xhBZ+JNQSMsemABXa5u/NoodUmHCbDMrg2A4MvHUog+WfHLHwf8dTLAIy8hgUjcsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738268530; c=relaxed/simple;
	bh=1GGlHvQz1iXt10zBXIR+FFUNRrpK3nSryLcYjFwP+98=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=U+FUJE3j+nTFVUKnMki3IsLo5YTpdrjGs9dJ7ftj6+8w1DAxW8OZzUdv/yO8CqQEQPu8L4iKDrU7fYbg6BMS/Yher7d+56n2Yy0/FKxYeX6b+v80unVjXsAKA5BF5NQhxkxBR5xjN85RiKgalhobJT3wZLrRjDI14HktJzzYDnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PXNUMAfd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKrf5Q5C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UK1qZ3029450;
	Thu, 30 Jan 2025 20:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=RpdH8k1akDRdUW0x9O
	+6gZd+8J7mNx56w3UkHHBsuaU=; b=PXNUMAfd8oz2ItaMH0Hkmr/0omhlaAWl23
	/4uE9bOBN2e/0qEt/P1Y8e7gFJmVKbdVsmiYDqSaCXPhTg8u/Po6nyB5ljnxDZM8
	Z/jDlFO4UmVBdijpF6NA48D/bB8Tph6AFQ9jrFkU4aaAgOR3ecssEt/iq7sXXdlX
	0HgOUeIFkd6Ho4QsG6Fze8s1z6nPaNE6ZUtbY1pnRD7n5CEzgsN9+dGu2W9//jb1
	zoIr7GWJcnvsTQdlb4CuvR7NZQ0WKIOf50/IH2FM/7z5985UhKxy12YjqqA8meT/
	EzmT1tOjMtengaTyheC1itpyx6w8wb/RoFsBVMU/aKRRaLhZgdbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gg3r0156-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:21:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJNS83006132;
	Thu, 30 Jan 2025 20:21:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gfhtjcwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBZzvoST9xvmNqYQLu09SXjv1bOlv8+SDs22ew9BpNU/iW1xBH22WUBZHMEnqTFua0X8YPU8luWYI55kylFqn+Righ1ZoD594vPZyj6KBX6f1k895756AZGXo11lZtdoDqj+7Igh7EPFQZPmrLkyyhYtQeJcSbnr0101GGMFWO35RXYFOMig41S9WlJYpOCpKfbu6rAiXeRzExkH11TRH6kVaPWFJ5yqyKlHw/u+MZuobeWUfHPLqapZOJM4sQ0OTrEKxgUeCOdBeyW4GA+0EH27IBQKH3q9nFN/nKtFCh1vdKAN8RderUbB+KAXh2m9f7+CEqmEWqaO+A/yT7B6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpdH8k1akDRdUW0x9O+6gZd+8J7mNx56w3UkHHBsuaU=;
 b=qbbHxK0pX/fskeptqc1qQaCWD0Th/mqZFogSmGIpN5EsdMRAXtsbQYLG+2vFquXb1dxII5NDLiSnslkwxBqc3jNFRJ/GZuUnao9tM/Hn9t20J62fUxQ55mnzBktwishDCW9PLtYyQEkAciKa0ajVMSJDbIzFsjzQrkjD2vyPcbKgQqV55x7A9wT2ijpOdJRTgVMt8uc5bYMAK1xj/u9dbS2m4AvgAOcSFZll8U3n2Bgdn9p1E5Tlx9UKzIUaFqrQwLPlL8Bp2nKMfnLf7VsrneSCp34la32E0A7iNjXBTkpWG3O0f+Q/06FIdl+IIEeYATx7gIXukBJc7Hve+Bi4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpdH8k1akDRdUW0x9O+6gZd+8J7mNx56w3UkHHBsuaU=;
 b=uKrf5Q5C1tmiAZTaLHIP/+1WP0UkEpNc5WUnmlDABaVQd58gi7eRazr8of1mQYtcVr8qGkYW4ZR+m/me9fijR7x+mYXyH2/DRpuU7D99+csa8mXOoIrY1xCDoXnkYbWbJ3bbcW3R7JF4pslfR5FG43FzdYJxUy+J6bLE2INRp8Q=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Thu, 30 Jan
 2025 20:21:46 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 20:21:46 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com> (Kanchan Joshi's
	message of "Wed, 29 Jan 2025 19:32:04 +0530")
Organization: Oracle Corporation
Message-ID: <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
Date: Thu, 30 Jan 2025 15:21:45 -0500
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS7PR10MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: d45efe07-18f9-4a00-0617-08dd416bb84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SArhgBIOrs5OiNnaYw1aGgsomCgBIOYSgu+mWH2ggSVUFQyBbnMQun5hcw9Z?=
 =?us-ascii?Q?bgmt8/F125DBPlXGgOQTScaoSurFU3jhi83EnL0bjGMuINVvP8Nj0m/vJadK?=
 =?us-ascii?Q?K/nbN1OP62aobFScjVrYEkw0QFRh3CFEq0/el9tZ1961aGuXhiLF3tbxGTly?=
 =?us-ascii?Q?jakC1dHtZ55adIDczPcnzKPDYgovjdt3QPu4hQlLVyfdqjQXkUu1cb5MUbOt?=
 =?us-ascii?Q?rmDvA+oEaWep1F5SKEHAwlnyhYM7ncxSu2DR/eBuzHJeNzfnagFykeePZ4Ab?=
 =?us-ascii?Q?BFG0U+TyN8uCLYUsIzRNeMoSm2UI5eS5QQBF9TwZ9AayEe19ufpgxsMcpv8S?=
 =?us-ascii?Q?rHOMT4vE1cs252cf9jK4QkKwl+DOlW+RnE30oMkPKtEXS7t6Uzt2kcQJEtuC?=
 =?us-ascii?Q?FFW8inhIl+eZ8nB4p6/oPxBqTyjYDWHF2W2uM4K6OuhmYJsDJA6uFsY67OJS?=
 =?us-ascii?Q?5cYTDb2ShpDNPCEEA3xORcw7u26ShB6cbo/3FH4SnnFfc2B98laRWarSeDex?=
 =?us-ascii?Q?382it8y65UvzCWsSiyClNch4oOkoMr/5MF5htYQAoPeH4LQh5isRUGwUpQoS?=
 =?us-ascii?Q?Zzr9fi6UJHgAyiZeddZAm1HGoiU1UTs7TMfFljZfE5IWQUTBdApkYw9WGYy+?=
 =?us-ascii?Q?kIzvzAtgA10KioFsRS4w+Jwkqm99qpsv+Mm4yFIwop7zYl0Z3j8T+UVdo+PJ?=
 =?us-ascii?Q?IEyeIlFy/RGBqBaoWFZImS4Iw9IakIU9azg/b1ICMw9JixHvKqDd+RJeDRsk?=
 =?us-ascii?Q?mLfLFhgzS6obiocJnZssKbwbTNtCm3O3HdiQuYogJhF6dVqpOftB1U3Zw24+?=
 =?us-ascii?Q?xskJeCbvQI3XvKIaDUBBE0/Et7c9cYoyJK9qqSxZkVfcTdUZjlVBkfd2EBBl?=
 =?us-ascii?Q?WYROgSR2tvTArKV3gTdzwwAGERhCI73FHAHEgsaIc0ZabNZh9J1AcNtIrtDA?=
 =?us-ascii?Q?eP/N9swHNheenjvxoOHXFXw5V95ZiftA5ph23S9ShwiCaGin7nhcRQEN500R?=
 =?us-ascii?Q?cKb04roN3/ZLm5rh+J7g4PnTLpUe7b6xr8ZLVzvipuNPAT06x6qCcnpWFE5s?=
 =?us-ascii?Q?+iEpCesRFDmPctCm7XBDNWkICqLUmg03+lrER8oCLaphk0DtwL4D4cVS72R1?=
 =?us-ascii?Q?ZiKEk/xKQwlnyomc5YPPZplqv6yiHv0u7Shg48GaH8X8VJ3wwPmZkYCm1ky6?=
 =?us-ascii?Q?VitOWBOjlkyJwjahQaSOBDxuC+FDkaT6bxtKr7MM0pLng3YJNsGXOZhSCw4l?=
 =?us-ascii?Q?a9+mb6W58aF3oHRjo43OrLWf614Hq3ceZlUXUcKnmZAFYHX5J5yjp4bHWwYm?=
 =?us-ascii?Q?DF+1cWfBJAovEwIUk6OUJ6Iw0qPP2y9zOrcUIFmBnhrp2IogJJERp3ltZ7mK?=
 =?us-ascii?Q?EmlpaX1HqydOruzxprV4eanVKidK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B62JMhiBbgtzGKCR2/eVjvaYbvayNQf1QkZEElgkhDDq2u/t5L8GjA/AUQ3u?=
 =?us-ascii?Q?Az0Dk5yUtRW9lCom45Cm6pqUVgyAVxDs+jxWl7cm7Vov3Qb4oHwp8qwBKQys?=
 =?us-ascii?Q?Yw6BzZ2OaHUGYaQ0jWRIJy6Eug/P3DUfOYkToyItvfc/bNeXnWq+NDo0kMp7?=
 =?us-ascii?Q?PFLWHqgArwjYtPxdADMKAsm3cwqAAw0GXqS0R5fCqK0kz6EiCK0TECkt+Kyy?=
 =?us-ascii?Q?42NtSc7/E/krL70qXRtI2GNIDY5J3AMTXe/Dgrnf5acsQXWPjvIAMJFVYtI8?=
 =?us-ascii?Q?+UIc301KI/rVAgLkqJTNB+FbA1BeXPeKbq+ftlk666za4B7XOCLSPpQk6l1f?=
 =?us-ascii?Q?i35N8V+58D6Ut9zSiYUA5z1OYvsraryD4JNmU8xUKQz6fjKhYnnAEjOslOV+?=
 =?us-ascii?Q?YK8id9gO3IfYtkCrFF9EawAb9HtvA+ADelEDUz8apJstMOrGm2tXzsmeMA19?=
 =?us-ascii?Q?qDvzpXLn3haA5vParQWXbT84/d5RftKY41MfeDS6w2jWgD51EG70c0IuUQfx?=
 =?us-ascii?Q?0aos7j4mY1ZXpNmk5e0CBssETckpRC+uL02fokZHLxXTJH8Tk3AcQKsuR1Gs?=
 =?us-ascii?Q?ZAidW8jOZz072AMJElUxcXqNTt1UQINLHs6ffqe3qy8oxgNW59ppqtHC4njN?=
 =?us-ascii?Q?3kMlX5vhcpryJPigqcJHKX/SjPeqLNQZASVtKnnY87soFCPfaFhS0bykwDus?=
 =?us-ascii?Q?8MSJ8sTl5/wezyxuz/IYp+QPLm76T9M81JtPefouMCrkad/E76n6mjap2d/W?=
 =?us-ascii?Q?oneXAsmsldboiBdDXkq3K52p/A7M4V3kCBABvMncco4BA+KtbhEYBjF56ikx?=
 =?us-ascii?Q?oIldrrLfoeWXXi7N0eBb1qREwTR9nEFbpz9NL6qXsPxGB80bLYV3LbhCeBhZ?=
 =?us-ascii?Q?zZn0C8oIo+l122FzB4P2S46NFnnSl0eBQNKChf/Nw1LAFqFCLoiNftNHkNJe?=
 =?us-ascii?Q?ippd6DL7k8DKV8wvtSPrNF1uk8kIWtn6+q6OCKYDjpvIHhIYwS3/3Tk5kLIr?=
 =?us-ascii?Q?tmk9XSy9v2oSAGVYs+eACbZJ+zcIYZkpBWplpJY/shgnST4VYC+LhGT7YOck?=
 =?us-ascii?Q?ISm3rP+NpRYQK7jv7oFkGYxi9GqdrG4k4eUMzjEaULTgDb6Cwes2Li9rUHyh?=
 =?us-ascii?Q?6IHJLcAD5qTCJSdSmXJvmCesA2FX4TyCppT8VZ+aJ/qNYAs1Szj1RZuQIImJ?=
 =?us-ascii?Q?RmCjDoDQubVXPdg80+nEPw8b5RR2X7PWujiSP20i7aNIIJN6uzNmgeq34fHu?=
 =?us-ascii?Q?PBfVr00gECmaqjwmZr/GPc4OvXbo1ybyFwXiHcpofq+4WxgREJSyIfUJT+q1?=
 =?us-ascii?Q?2AeDMlmKR4Z1npfAWNKnB7cnGTPF0TF4Ypv3qiJerz8859VQFCGmEwFK0C1q?=
 =?us-ascii?Q?uBqIwYCnYDMC1cTmAQGpr1ZzYORzJnLdKw7siWmACVlHhNLGK/uElPdndNH+?=
 =?us-ascii?Q?4qDncPY3LWRnwQep0rnVsT4+cZEjKB5ULj0Wj5W/223M5K4fn9f5KcsTkOjb?=
 =?us-ascii?Q?RjwcVAedhUKkYlgaukOIBtKDQt5WJmaVJEhaj4XxARQ9EM52Ulb+J2MDPLcR?=
 =?us-ascii?Q?bOBYGXASe+vwpGxFOAh0l3Sb5azA9jj8NtZRqt2rOd21/yAt4yCj4OGaabJX?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PARlw+mIIYRARHfoz0i/CV66MP9j+rnuPZqRV2jkHN05jrVzLo6xppSNrccsxydx/OprEmN94Zdnolpmi3Kp/tgDsQkbrcYdSuXSIeK4AWxks42mMfZsHKuOMFh35+p0A6Lc4RDVzUoKdXU3n66HWEA2TL0YoV2PksZHlMpBBqcIhsE8HPkfem1dJefUIxlbAsEY07SzkZzULZkItQna/eY0843DJdG/yEJcY5Eoxu+Bcy05QiTO0T/FvCzk8h5IBo23LVnRC/hzMt4+EUIDDoUV8NmMjW8hBGWib0qIQz6VaGDX+IfYJd4zWV6+XD8tg+16eDGFCvbcrUzGnxUnAp4MkwYyjk/BT4mp/IP/ud1OqwXfDhwOkTFlQh9Qa/zihVzA73EsqPRPNXH/ho24VTb0cHBB/qhIYTFucYf0jttcu2WdNQHhmOADpBdJhZLq/HlktJ7R39YTwIwifG9lHmVzo6mwN68dcMxUtNFLYIPps1Z+nlZ+sQOCZFZxzU7fcmYSKu5761YH9UtoZxfWQzPW3WMXMTjfmSQFb+mn360w82ArTdqojxStcUDYtCcz1ir7aS+zM6zkAWq+t9i7KhPlY3NyMsIqXSw/QjD1rMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45efe07-18f9-4a00-0617-08dd416bb84a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:21:46.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ww8LurLSVE8CkFkj/vPYjP2OPnnHWrEikRdH+NNRlfCLwPuoelXOhEc2tkmEkX0Pv2tZ5J27Tm17nLyKiSHb8f24UqsBFx21FGq0tjI4+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2501300155
X-Proofpoint-ORIG-GUID: SzJDwRje_vrJbLckNyFaTbWWcrq1-s_q
X-Proofpoint-GUID: SzJDwRje_vrJbLckNyFaTbWWcrq1-s_q


Hi Kanchan!

> There is value in avoiding Copy-on-write (COW) checksum tree on a
> device that can anyway store checksums inline (as part of PI). This
> would eliminate extra checksum writes/reads, making I/O more
> CPU-efficient. Additionally, usable space would increase, and write
> amplification, both in Btrfs and eventually at the device level, would
> be reduced [*].

I have a couple of observations.

First of all, there is no inherent benefit to PI if it is generated at
the same time as the ECC. The ECC is usually far superior when it comes
to protecting data at rest. And you'll still get an error if uncorrected
corruption is detected. So BLK_INTEGRITY_OFFLOAD_NO_BUF does not offer
any benefits in my book.

The motivation for T10 PI is that it is generated in close temporal
proximity to the data. I.e. ideally the PI protecting the data is
calculated as soon as the data has been created in memory. And then the
I/O will eventually be queued, submitted, traverse the kernel, through
the storage fabric, and out to the end device. The PI and data have
traveled along different paths (potentially, more on that later) to get
there. The device will calculate the ECC and then perform a validation
of the PI wrt. to the data buffer. And if those two line up, we know the
ECC is also good. At that point we have confirmed that the data to be
stored matches the data that was used as input when the PI was generated
N seconds ago in host memory. And therefore we can write.

I.e. the goal of PI is protect against problems that happen between data
creation time and the data being persisted to media. Once the ECC has
been calculated, PI essentially stops being interesting.

The second point I would like to make is that the separation between PI
and data that we introduced with DIX, and which NVMe subsequently
adopted, was a feature. It was not just to avoid the inconvenience of
having to deal with buffers that were multiples of 520 bytes in host
memory. The separation between the data and its associated protection
information had proven critical for data protection in many common
corruption scenarios. Inline protection had been tried and had failed to
catch many of the scenarios we had come across in the field.

At the time T10 PI was designed spinning rust was the only game in town.
And nobody was willing to take the performance hit of having to seek
twice per I/O to store PI separately from the data. And while schemes
involving sending all the PI ahead of the data were entertained, they
never came to fruition. Storing 512+8 in the same sector was a necessity
in the context of SCSI drives, not a desired behavior. Addressing that
in DIX was key.

So to me, it's a highly desirable feature that btrfs stores its
checksums elsewhere on media. But that's obviously a trade-off a user
can make. In some cases media WAR may be more important than extending
the protection envelope for the data, that's OK. I would suggest you
look at using CRC32C given the intended 4KB block use case, though,
because the 16-bit CRC isn't fantastic for large blocks.

-- 
Martin K. Petersen	Oracle Linux Engineering

