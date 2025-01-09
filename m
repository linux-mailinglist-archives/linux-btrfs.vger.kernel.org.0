Return-Path: <linux-btrfs+bounces-10811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C4A06C86
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 04:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46387A16C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B1A487BF;
	Thu,  9 Jan 2025 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C4C3APYr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dWWEMHAR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188213A26D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394845; cv=fail; b=ezeTRdac1O3eZ1EDmlCYsKFSAM51mZQwPaZ2KFJDnNOAbHdjKFhAnSEzO5uM2BiQC4T1BOehEcnIN2OX8x8B3+e+Zj5ibhL7/I1gcfthpuI7mF9ipU7YCM83lEncQ+ewmac1fBXb4P0coTwX0m9rLdfiJMRXHSim7C/xD2O/XPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394845; c=relaxed/simple;
	bh=Aww/rktSJjLge9xLOZFAPW3GB8tjWry0voRnLvDmMaE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FBjsT+ZiJIW+xuGLqgRvvYzLaJBlthHblbuSqruyXuoiTqB0MLe4lN/atb3z0KDzr7asgQrOkohC05aOGxbQvK+ZS2HhghlYDH9XqnpMl8aaOMU8uE2GFbTXNSJEaPq4aAvcSP68qy0vaHtRsQuzR1ap0W1ayPishdwUkKTC9PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C4C3APYr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dWWEMHAR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508M9Whc004399;
	Thu, 9 Jan 2025 03:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=2z0kuCORNyPAnzJ2
	ZvrkyNzL/E8lVzJsxks7521upYU=; b=C4C3APYrMB5uY1BgSAd71DX5uxZ5BCCb
	kA1rRlNgG5cX7gpwHfHNERb8EEHZeTavVNOiTHHyqpmgU72fJleisxJz4XNgCrX+
	fsueVWS6qD2emd0ZRJfmPka2rnWB1sNmj+Nl1xMLSAlEFvbSmCVCyikhNH8yEbIb
	y3wzBctC1rjttQlP+xQWiOHN7/NCwlJl2fU334PG+nQocKiS3VSQHo8sYeel0aKs
	aPX/M/7J9bCvUk9dzu1ObPRq/NtbxkwcNwH+g52yloZ23opUuNqpl4S8jIU6+LBn
	IazzYD1Injcx6G/QwsGzNRrn81iE8KLnwsr3vEiwZ7hIYt/w56LsyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk08e6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 03:54:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5093GfGb010934;
	Thu, 9 Jan 2025 03:53:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueae11t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 03:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWyKZCwBITYO2AaK+r1JFdaQDL5a0TJnUHPhjIheouMM/xpSzlNey/21sfjRG8XyMwJWbALr5qdn31CEqws6E1k6g+1qVLHP5emyfVV59rfGmRZFdnt7XDlcC0akxQceTUgqvA4ahyBZWB8qV7epCpX4RHdeXQ/IDGv26Z+0n5Y2mribbH2FptI1zdXzA0VqKmv2o4pxXuiuHDvv2EKc/YyGl0tsVlTyCQEQTvJPukp5OmLLp01HErirjTmsiiOVZL7748l0xosZTU0B1TCzabot/BivVlWljypQ/WJxIf07GeAWJSABt4bFeBKbzC2PCugeCh85QGr8QQgGAR08mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z0kuCORNyPAnzJ2ZvrkyNzL/E8lVzJsxks7521upYU=;
 b=JPivVRe6+2wNunr7Jp2k4R5fbCukwkWKwiLSZYThBaS5Cb654h63p6cvttNXyzgFrCbu+DMSqWM++hI/m0tKH8RCH8eFQrWzrmWzrHP9g98ELSpbD3OwTDcKTzlSkXag1uEwZdjbjOjzaonxvQyR7jkAF3assNA9BTTXqmn8XpgodNyoqK9OvedFU5y/Q5dpxL3wuVsVE0l/EcfqMnIb9qRqu6LSBRnvr38JYHfujMo4pTF5bcWOGqwTg7zqtWOkhCruDYYJks0KMH67H086jOqbGI7pDBpUi9JmRPYtHocnw/NxCTrAlATZ9AAy2XBZPhm6IipGzbFVbM0AEG/W+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z0kuCORNyPAnzJ2ZvrkyNzL/E8lVzJsxks7521upYU=;
 b=dWWEMHARQiGsXnHTATdtiAGW8ZuPrLUvZG5rFoLtrqSpGBocb50aibBf0Zn/Qix6pq1CPYKemX4NOQJx6WoEnyjlFhwlxb6HdpqYkp8ScSogOOGnWTcTBQgD3kSGW3B9E/IpwBV8dBNCkRz39qpwyAEAp0YZoILw5V3BXoLOEl8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYXPR10MB7921.namprd10.prod.outlook.com (2603:10b6:930:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 03:53:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 03:53:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [GIT PULL] fstests: btrfs changes staged-20250109
Date: Thu,  9 Jan 2025 11:52:53 +0800
Message-ID: <20250109035340.43412-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYXPR10MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c59a30-4350-435b-a95a-08dd30613e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fqajMVLG+c/XBCvk5k0ypPKNTcPwRtuAPL2YJaroD8osKdYVi6r4ofuhiw7H?=
 =?us-ascii?Q?47389dA5dwOzItPYrdhrS0+dnZ2pm78zxgigmSP4lq67MRIt8orB+ZI2GSsq?=
 =?us-ascii?Q?/++unWj+viz6EtS245Vg8l8V0fWWkEw2PeZ7LeX5g86TbGgSdcZGFvfzr1gr?=
 =?us-ascii?Q?HTKcZls5DS4j8YqUT+JQjZhlte17VPI9qM0FRKt1q3wKdx+zvvMFCZiPjh4l?=
 =?us-ascii?Q?X8NWak2Ty1z4mUuiSTDWIClGn/fJzDfzk0O7EK3UmGCWUiNgxk73MRbYYG7q?=
 =?us-ascii?Q?Cteliwi7f4iKVI8ZK8shXAxiZNZgi4yWgZaNkpY4ub3igBLyCQIpgIiGqX3H?=
 =?us-ascii?Q?5GaVuvLVKVWm71lbRz9bfX3WkXC1ytGynttH3DmbPVAgdFFxItuh91Zc7hgi?=
 =?us-ascii?Q?G7TVOZjAdVb0W4k4u4bVq+RQVSYiP2/HQOyQ+jOFnDZbAntx8PqlL/r+Qysc?=
 =?us-ascii?Q?J9hxJlgBF/WGI4vhdpdPJ8WWG9PUU/3jChFPd2qu9pVYOf8ZWtKI+HOSKl7Z?=
 =?us-ascii?Q?FeUgTaYiNgasxKKFpAmsPmHz7BxAkoq9NUmm862d4x3C7yWGONRKhWeITo1/?=
 =?us-ascii?Q?3xct47ZfhH5/u2p2OwPp07YB8HttIByLVu409B5WElaLw1jZR9XTJqXo825b?=
 =?us-ascii?Q?erXZLqfrzK8yc6R83gH0h0wuqPI8hEnZI6mufD18+CWNkMydfBUIGyu5L2BD?=
 =?us-ascii?Q?jKt/6Ok5hpfmdlG5ETCY1jB0aVgZE81X30+cxUtSoc5Vy4dx6UcqaL6EKCBd?=
 =?us-ascii?Q?ccLnLSCOPFBQve4w58niPiyV8++FTypcaIlG7JpISt7uL1jtKYHwIRVPv+OH?=
 =?us-ascii?Q?OurrCs8biKlzXH0lmKtJRyQSXyFg6+bXz+/88IJJHhOJ3+nb20K/Dh9iQVm6?=
 =?us-ascii?Q?tYwklKu1+1sK3oCiWYehaSxpIMo8aGbQSRlZ2QumVEFl5f91FXTiejRigIl4?=
 =?us-ascii?Q?7kK/O291nNMjaWfCMkXe1mL5B/ErGyBFNz0Z97xVvA+/xRIsHD8GkfuRjJyf?=
 =?us-ascii?Q?147WOkxUK+TneOPYMrY6RA052pA/vC2QfLCbnW9y/ZvFnamGY+HxCnvCzAZs?=
 =?us-ascii?Q?GWDQ8MrH91zLPgKYdY+w0WPmUnZP5dRvuskkUlZaCPu2sThgZCUef9/A/9nm?=
 =?us-ascii?Q?oHJG+ZXCBsvLb/pDFNvyrs7FoPIDPDyvO5gvUNVcf7W5KlA5t8PICk3DyOr5?=
 =?us-ascii?Q?IUW4XVMwndtOqkepPEiH11cOezKbGFRX1BSxuGIAwZl/t9AMgdM+GxK4uMVU?=
 =?us-ascii?Q?HHmoV9dXKXQVzA3nbPyEcXclYWYLBd3x/q46BFH8wCMPTdcTjkCo2tamEl5Q?=
 =?us-ascii?Q?ybZOPXxvjAP+DzanxrQDXubGw7eV2vaqw1AoyiMIszv5pQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHjTPDRIDLVznodEIvqzpBvUTfpz6zgI0PWHBriNrGpu2UeNYTgmt0edwHDO?=
 =?us-ascii?Q?6/l1s4Msi1hD1fLYZsHw1O/UUFRJJPMsxI7eiBCp70/sx55hchNEHOd7xUfw?=
 =?us-ascii?Q?Jr1R/vTkzF8K0+WaGKnZ/PUKIx5m25MChgJk55pdXEr+QpEFR1Rl8u8yNKCi?=
 =?us-ascii?Q?Yl7ZcbbPgB7EnsjBhWM1K8zrmOXOJsLk5hmyYaQVtVXzkDSRre/i6YMREtqe?=
 =?us-ascii?Q?IfIYBAFTiQ38aJBFmr1XXU0T1XyLLIdcL6eLtErRUOBmibRoiSnibNXKtIlW?=
 =?us-ascii?Q?d8Fg5TJouf0C70hhTn/CeI/bF+DiRNaiu7WUaUwsS4XqCByECuyF/W5bfmhQ?=
 =?us-ascii?Q?S7isssO+x2pF3zamlio18MOmRhNsoW/kQZX0y0kSD1o+0n182uMfiuFiZQWa?=
 =?us-ascii?Q?RcvW+RkRG3e/BhFs1IUM0hUrf+FBwSR06oFX0ls8GHhFemldz3t909ckd6yQ?=
 =?us-ascii?Q?nBqacoEMeHRudWgaxXi69izaQNMm4mvCWclIFA4ZROza7De4lvOFEQ3zUArG?=
 =?us-ascii?Q?1Vit2qvIyEDnnliLimTDtNZ62Ra7asdhgptKbPs4oYgiJjCwrXoYiN8GSnTP?=
 =?us-ascii?Q?MiOfw5DABzpYhxzM5GMReBZ3Ir1Ccw5TThi6RRE/BKMsf8Z2iq7IUU1cHLAJ?=
 =?us-ascii?Q?dMly2sgPUX4/IP6Z6nZMHvlNlPnR1HwIFeBLNy66RtWPgu9J4y0WSw1lzerU?=
 =?us-ascii?Q?0f2VifDOR6rxTDlafFqEtQfdrEBYoxSXMud3TDfZvuqumZFNh4OXz8Ep+IV/?=
 =?us-ascii?Q?V/dwfxUli/bI7pJHl8vUm7J5xGEo0P1TwPs/EECaLAZ8q6qi1CiFPeiJ/Ekb?=
 =?us-ascii?Q?iD6DLG3VTn3Wlq9NtNitMCoYXCbYRiIXTpHlLRziWDOdsSEmVmMK+bUoN1jb?=
 =?us-ascii?Q?jPUOs9wyOdqi/EDUQ/yNy7IiloO5IZ2PP2oK80b7q0kTgOGWqWTp8+qEJP9Q?=
 =?us-ascii?Q?I5O6/VyihO7PHYnZCJ6f8kXLzpBkGrhrvRSwUCY7VFkgMaY7q6VMuPIAQjnE?=
 =?us-ascii?Q?w+MJOoZPlGQbcKFonBfTSS14uKieRxI0ZXweglOrGc9ZQq5aipZZCCzD5XF/?=
 =?us-ascii?Q?xsaWIm9nHAvSMNgEmSAFXfmgx+L+uGsvNw5u8M5QOQwtvujUuurXBHSrX9Y4?=
 =?us-ascii?Q?Yy8HEQ+KR0mi2CHFA7k39+5oEyeX0vTp4CVPYLTdoDJ8q7uQj6Y+nASxowoU?=
 =?us-ascii?Q?Z9OJ4qNiRAMvMax8pb2wBKDup0iE/GITtAGHEvg4MCLbpOjTIJEUzLP5EA4N?=
 =?us-ascii?Q?AkmI+4YD2FfYrcYrMHCHhnArtidG6V9PJYXX/x0SrpocVoeAFIaIuh8N/jlR?=
 =?us-ascii?Q?Nzir8asBnpluSzZRMjG+JISh3tf1OGzkP6H4TpuP7ykep43IWPUr463dpvbI?=
 =?us-ascii?Q?8RainZSAnZ4qlsy0tSXte+mql10MS/bo91dl7YfNrsi8TJDfxVw7HnB23XLT?=
 =?us-ascii?Q?FPj3A+OcwaP88Mi7xpnlJGPqKty0syO23BTxdfWkM/BxM/7cTieVVW+oStJC?=
 =?us-ascii?Q?Js2QqyRtYYYDhB/8XCb+0VL9wusF0Ji8BEIKvMpYboLyc8PPVvKsRJFVryIN?=
 =?us-ascii?Q?3J21ICNz3v3xMF0eeFUpoWetoiPrBNA111DZy+n2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zKLI11OcGnUCS0wqW1cNSa5phq4N6GaoH5p89wCrobzVwRW6lLTuyobrxS4QnErBdHESCFoTxxwjJbnyyQsqUcMbN8KJSAkO83cYmcGPV60BQDh7Qoat3RZMDabJWr7szgsSRp1p9okvTjYs/Zx5o82GKIuF+Hegb2JODbEbEkXtpVD3LIEVmEr5Wakh8atV7OYF6xORTMiiaXKDh+MagFkiNL9rGX/B9AiHmZi/a+QKiasZky6JC0b0bnetrUdPV0DAfolwBOuveG2yiGb+uNo/0TdhKm/+wC/gLqcBXn7BAQ0QutICrn3jsGA55gcXK8cymMOGC3sIUdoONNVJ/+rrb8fbiGwDV0NuLuig666HacXxQZWYR4S41fbhEvg0CUmqlLnMT/svXX4VArPH1PCPIYXGMbqaAu2qyZOyybfHM5mX0NNRVHBZlAp9Skk1kABldFeKHPMfowAdn10X2Wm3i5D/aep++JYHYdUofGBW5srJKBEK2Tvk1ts3VH+shdXs86o9J1/49O7fzSJ99yeutQiXJchXZSlRUcrvUyVe73j/HNyP/5v6r54eGh1vEiDGH5Si7KAhlPkNo3sacJ3B4Af9XRDdcUbvESY4mU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c59a30-4350-435b-a95a-08dd30613e2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:53:57.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD5RptfUE8t5OqZkcRNO44TrHzDw+A6dP8P+fJhn7pCrntkz+xeGAg1KnurWYeOf1DOZqxwK/asbPyejA2aaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_01,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501090028
X-Proofpoint-ORIG-GUID: RQmhuy6BtiHhKWnfVX9SCBtR0TkjOly9
X-Proofpoint-GUID: RQmhuy6BtiHhKWnfVX9SCBtR0TkjOly9

Zorro,
	Please pull these small changes; they have been reviewed and tested.

Thank you.
The following changes since commit d862cf27d1b44de3e3d0b8380d22ef43b308ca32:

  generic/530: only use xfs-specific mkfs options when testing on xfs (2024-12-19 18:18:47 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250109

for you to fetch changes up to 73e44e1ba7bf072a9e4f77bc3ac6a60eebe0102a:

  btrfs: test cycle mounting a filesystem right after enabling simple quotas (2025-01-09 11:00:37 +0800)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: test cycle mounting a filesystem right after enabling simple quotas

Mark Harmstone (2):
      configure: use pkg-config to find liburing
      btrfs: add test for encoded reads

Qu Wenruo (1):
      btrfs/326: update _fixed_by_kernel_commit

 .gitignore                      |   2 +
 VERSION                         |   8 +-
 common/btrfs                    |  32 ++++++
 m4/package_globals.m4           |   4 +-
 m4/package_liburing.m4          |   8 +-
 release.sh                      |   2 +-
 src/Makefile                    |   1 +
 src/btrfs_encoded_read.c        | 195 +++++++++++++++++++++++++++++++++
 src/btrfs_encoded_write.c       | 226 ++++++++++++++++++++++++++++++++++++++
 src/feature.c                   |   4 +-
 src/vfs/idmapped-mounts.c       |   6 +-
 src/vfs/idmapped-mounts.h       |   2 +-
 src/vfs/tmpfs-idmapped-mounts.c |   6 +-
 src/vfs/utils.c                 |   4 +-
 src/vfs/utils.h                 |   6 +-
 src/vfs/vfstest.c               |   6 +-
 tests/btrfs/326                 |   7 +-
 tests/btrfs/328                 |  31 ++++++
 tests/btrfs/328.out             |   2 +
 tests/btrfs/333                 | 233 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out             |   2 +
 21 files changed, 761 insertions(+), 26 deletions(-)
 create mode 100644 src/btrfs_encoded_read.c
 create mode 100644 src/btrfs_encoded_write.c
 create mode 100755 tests/btrfs/328
 create mode 100644 tests/btrfs/328.out
 create mode 100755 tests/btrfs/333
 create mode 100644 tests/btrfs/333.out

