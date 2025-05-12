Return-Path: <linux-btrfs+bounces-13920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D11AB42A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29DC19E81C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D4298261;
	Mon, 12 May 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ir+UfW0A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cbLY1m91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4213298269
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073269; cv=fail; b=Ni8JEBXeRO330Cvsr3UDqfUYC6sfVv63GNm02LPbnzDMuGzYh24ieizorUCU7L3Zn8ET3BEtJVU186VMSXkwm4DP+J+leKp01Ogz34PT9H0DPhNTwf2K96D1+0OKuUFLH7azdetROpILeaWFMIfe58p6i9SWv21ILUXH46b0qRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073269; c=relaxed/simple;
	bh=Dt5WBckHKKTvOngCPjHQehGI/RmSEPfFPFSD3hsqU8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJa23US1hJPuvfGKdlz4m42AlK/0lEW2GtRwXO0f/eW7Em5X6vGTgKimmjPzqL653Br7C7jYrO6HrQFmIFdSsYINdr2Y0uVLIHEWV/zce+SEaO99G2smAc/TtU6oc4sZVH8jQy9OEwKVNCTcfNQGx00v/iLOWeL86yu8W0KIYpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ir+UfW0A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cbLY1m91; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0uYB003980
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NoHk50SXpgbtfvC6MyH6T4UfPJfmjPWi5H1SsGfmfKw=; b=
	Ir+UfW0A6PZfN6kOW8Ucl3niymaSLhaDdUSELiWggGifi3T5s2rBprXG+rXgqhX8
	B1hv2UZG9k2TNFZM1bz7n4f17HKcmmflcIRV7hpvFufyyQCSRj+jG8F7yvspey1p
	c2ADb/hj3IRmmfaQu+pV1aG1t7rTGgXsEDEbdYbUSknH7tAD8jX9g4KXsOGblVr/
	FDOhCz/SnjAdZ3w08fozhuXUGyeIlgLe3qrEsWRiSaqOFL8ajoXTrROIxM/aewxl
	sPDUV+INlyo2CT8iCwpD9/wW2OCae4EYdiF6QNienIkKLtWxGdkxCa6me1hxLBTZ
	5jCSBzUlR99ClQHlydxRpQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r354t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHTCdl002414
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:46 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012039.outbound.protection.outlook.com [40.93.6.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx3bu7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc4x8fMnP1UhhkdnKMwdRdenLcGdpLiAdOTU9sPVpaftDA2wHmU9AvPRSQEfO8OpLTjI0qTPRwxO+YUF3UVp8rveLxdidcSncpRqheqzRCUcmDAZzY7bwna0Uyz97jt27AKR8Z4j3mRNw4Hyszp15JSyofunWlqJolIUPMff2tuKWKIdqbuASQ4kLhj8meren7z9tn6SPk8RvZiY9CvjktSpTEzg93oHLZlLedR4i+ocCFOKlXh0+UHEle0fkubJOZq4sOUQ5aII+TrlZB8YkGaKzzDkD27zJsRDvMH9bRa6Hv/PqZ8O0KeCZjfBUwcyX+dM7cISfi38Bz7smqnk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoHk50SXpgbtfvC6MyH6T4UfPJfmjPWi5H1SsGfmfKw=;
 b=emz93vU5ILBf0QsPMyYAV35ztMx5SnWM1qjS+s+2Dfv1nUWIKxnViex6yb0zAArfWg8gsx2WQM75ECtoQAbR4i6dYZIfjryj9n22UMhAbbiKfwxZpO/uoNQKOvF7x+AEoOEk6ItL/Oc1n6UHnq8Ct0tmbbjZC+Q2uP3TZ7Z7NouxMXhIn03B4OQZrSi9L4wUUlYp+AOyNrRYDdPq5vGmfHQr6TJUC9gAzWGxkb4UckZasSVn1+KtpzULFauo+C6AgiDzIqLbhZAbj7HSaR2h4XmKDUJ35neE2Lz2GZ9flbRPUXTSegwTqM04CvixmaJ4ujn7aTmyBlN0z9FC8qs0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoHk50SXpgbtfvC6MyH6T4UfPJfmjPWi5H1SsGfmfKw=;
 b=cbLY1m91ntGmD5WzDR0suWW8AkW3FUStiKk3x9SKvj+VQr1WXz8vUBzQ+lmmn1n28SHh9SVPwm0BFYhOM/Av4Bhe7NJ++NoL8symIhWnHLHPnWI+Vz5UwVF0TW2jRERsVi9lCTSnZYa2JPPzqTkpbjvFkcQqhlwCfhb0/NmpNi4=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:07:43 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
Date: Tue, 13 May 2025 02:07:09 +0800
Message-ID: <0524659947f4ddd4eb3137d7fe1a8c4346182ef5.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ac36a4-8276-4263-c96a-08dd917fe434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UP4FpgaFxoarSsAUgUq7Tno04HYfEfcwrQQTmzYJI40uF8agjbX8KEy9MmBy?=
 =?us-ascii?Q?Iy0dSNlQYi/d2w5o5KNu4jg834IyQbAtGvAvhX8XDGeKdCbvBEfmjSadEf9T?=
 =?us-ascii?Q?JlLvvwjb4ZtY73PZRo68AOf4XprsxgnIMyLDAci8Cxb2kk7kq9CN9eGRECS8?=
 =?us-ascii?Q?waJA4flwg21DT05TNi912VapNAoHK/tJ7hqTiYicFPmQ+zIm23r6d5PLn6HM?=
 =?us-ascii?Q?9W3yxo8N1zP5Jl2xg666XwqX5FZy+LJ3pr8HPEHL0I5m3QRbOp4gShe3rMwB?=
 =?us-ascii?Q?1GcOGOuM6b5xNhdw84hNCQMcLIv2oMXv1P4Bi025qsPJhWsaSBwxmGJ4fuAg?=
 =?us-ascii?Q?BmPBktMYtiJl4u37N+yuFrhhGKcnr2kXc1Bx/7aWzwrHjNhWGfChOKBmAzM/?=
 =?us-ascii?Q?vHzGzwdCGcTChg8FzJXnoHr2bJ1CP/m4qo22KgVYECOkx+T08zSaSPzjrKAF?=
 =?us-ascii?Q?IXLtAdeg0IF0uENJbr3ZLem/fAFynvdX5ZP64QYrgj7FmSTqx8IKZ9dSenwe?=
 =?us-ascii?Q?rU5GXxhLu1AouoUjuKH0BOurcJHR3GQBVw2DIn6fj+6zvB7CsFCyo0qtMqM5?=
 =?us-ascii?Q?d3uSiaQmA15JKDzbxZb7vOKgK1pJBAJ7Y5XFk5myUi6HKdWFHdqeydARD/oq?=
 =?us-ascii?Q?UKY/no8DLNLbzAV+PdBsM+bLutBceKBbhkAvexGC5qpbs7/mzY2gGschntm1?=
 =?us-ascii?Q?7kEIPuv8DwUuCYJpwdUbqrsaUc9ZfdpHTgTEV/O2474L7Ts4tmHg0lbl9i7h?=
 =?us-ascii?Q?ZloB414GWJXxiII6s9oDzIS/MYql9KmlgU00CyMtomviRc2id8OVOKqMwKun?=
 =?us-ascii?Q?ApdqX33n6RPhXMJDu1071S7Po25I927ZNvFqdkZ2+i23xHuyqG+6J3pRvXqL?=
 =?us-ascii?Q?6gbxez5d1zWnUx8gEoEWc57uSem3phyotItWF+iOI4nSm+RgAVB1qLNdio3Y?=
 =?us-ascii?Q?Fbi6EyanC+Y3N+CTuzMzOSoibOi9/0oX9JuEwsoXF3qYHbI5c2ybZWHTP9CQ?=
 =?us-ascii?Q?nBoW9f3736N3w6zj/T8QNMFISBIldIJmKbnr9Q38fsqvIU0WWSPCiqx48lWu?=
 =?us-ascii?Q?ytF8nnpYXKQNoftFpHOTPCULWTLjJiFSegyjF13zOk6Th+kDzf2guI31c/ii?=
 =?us-ascii?Q?Cc/oahq1IaZIAsnfnL79g+ChVNRJUsKyDHgBrBKTCTNH1SSvWNDJ40H77tk6?=
 =?us-ascii?Q?HA6b1sspmq1RXPL6QGVFFMAXWAkt6KgUuvMccGuxzZasdZ2b52lUCzThd0pe?=
 =?us-ascii?Q?KXXv1HPJ0I/BaNboOlXsC8tclsQ6O786ee/FeQT4KSemZAOTBJn1GjCAO22z?=
 =?us-ascii?Q?h+1+UGz81kF+pqBIjeDA5jbkb4jy9nrQQeXdTk0utqzStdvW7l59vkdhYuR/?=
 =?us-ascii?Q?K0oqa0kd5BX9soRhZHPWrv/YSX+3BJGfyX1IeXztDryImkbCGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oam4ln3fhjk1Lk0zCWSV4kvb89zfbDlAVcfwElGdVvk9V+dmKibqWP+9S69m?=
 =?us-ascii?Q?V3XULZFVWRJI5YTtdJIv8fU7h0gsgzAWQuZkfWWMFc9YyTc/lr39mC8Ovq5R?=
 =?us-ascii?Q?iK0T1O4sdiSKObY3V/Td/CD45gEhQcwidgeWEdvRnTH2/Hx056fGD3rW2xIS?=
 =?us-ascii?Q?zJUPbGfS7yciLU2CPpeLJ0xGz6yp7BGqbntT9y4FiYz02dww8vwYHVsEc4cV?=
 =?us-ascii?Q?QX+tdC1G90fez8V7NgUepcbjyNMlP1qZ+o8bu9niGEG67+CB+p7KLX59kg3b?=
 =?us-ascii?Q?zPEMkwYiPcXSZkW/GCUcevypL76Ynv3dOeIqSzHbJmpFtzHpL/xVjx32P6HX?=
 =?us-ascii?Q?+fMqeSBqBfYtIPp+sjCnLEI8pBTqt+aW/LGLaeRGyCTrpOmMI3gieB6HaHbJ?=
 =?us-ascii?Q?8TBxJHmAn5nVs/51vYY7/ozTLdwTSkk/ZYECDZ/t+p6bfGy3xk/aF6GNxfRe?=
 =?us-ascii?Q?kyHYQLSM7+nG4qVe3P8xs25T6G56HodAWt0rAgmZNe9xP1+HWCP7WDpwmsG6?=
 =?us-ascii?Q?/iksR/5rrmwRuLqWH8mT9g2uY0WYC51hQejI+DsE01Tzh+zs2b+OBxA89jKg?=
 =?us-ascii?Q?4B0HUnn6TaddR/63JI40/ewihQTX0dkOXT+nGwupl22ByOgAOHggCZU7br0f?=
 =?us-ascii?Q?wFSO06tSEJjZX2uBjoWIZ16CRsGuQI4nMtXTH04grMzyn5F1nb287S2egGjf?=
 =?us-ascii?Q?gTUP53srJDr/V9Cw6/yr4dSPF8DtPmY9B/vzvvO8Gpn9qRoUvEQCmkDAXNO6?=
 =?us-ascii?Q?OqcFk2Ctbkva2LNnB+V+R766ZVlZ4j3B0dShB8mH6/TU/7cXZNfqZbZhyhat?=
 =?us-ascii?Q?QRaVEvwxI/fVtOoFl2p+mcIP/x5X1QHkKWuIgoCh1jgVzCpln5v2RyIqIuGp?=
 =?us-ascii?Q?r423FdcIuokjiC5yiYfVRLeZ4oze74mOR4gkiLJSRuvxyTT8nM3N+n47rP1p?=
 =?us-ascii?Q?Nk8RXA4p/jmqOtUne8PB7WjoGumSzXeL4u3AQLUpMue+bj9T1ZXXTcON5MVA?=
 =?us-ascii?Q?hTDnlBavMX7656i5/hcYUdeLaZV1Rnzq9bLHxTc4fVUgmkJDQwxHj8qOT6jp?=
 =?us-ascii?Q?ymRywkj1Gh1jzuGeTJg/YUKlKbga391pum6amvd/dVu/ImeCfdSeWiWU7yjK?=
 =?us-ascii?Q?eyb5c/fHFRt2gVW3l1ecYrT/xkzDvuqNmSrdmTqDpLpwQiHdeeEV1ze73wGI?=
 =?us-ascii?Q?fTNIXc9bVowD4s8t4xKFwoXnHSJPIHiKmtyghVhbnFZD8/wrMvKtmUrYPmfc?=
 =?us-ascii?Q?gyr/bD/7rmyJLdUksfteFXz+goEiqIt130msn6Q0J4TGGalmnBxthANPCllh?=
 =?us-ascii?Q?/sC4mtTsGV9TR3nZTobG0qY5BohmfqCk6Nu4eC5ulMBJpjXAzM/u47AZyu1k?=
 =?us-ascii?Q?u04nkQ+bkbcfamkfsR9iSl6ka8limCPLOrL/YigDwm0zylF4YMYLqo/hcy/h?=
 =?us-ascii?Q?64qIstwsJKxfR2ODJz7x30o+JBdzhsXJ0E5T6QqEwHngSGHIeTKaeSKSdnOl?=
 =?us-ascii?Q?63tA9wiKsNULVTsPtKSmLb+46T9suxiFxwgkoGv8bDxXOJYlbcUD5l7++PoY?=
 =?us-ascii?Q?Yn4oL5P6f5SIGAEiHwlyiOIIiAm7HnA6sNdHfSG/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wQRPEz9FOortE+fdotkwKLtQG2xBxVVOWESSO96hm28l4EINOhhjHS1tNV1smP6kI3Mfzo6PLh1rHfHHfg4z3MsMvdooymy9ZHom79D8p9Dl2k51fj3+xkYsIlbLJUBqQSvg6lmjyD8cW2CTjRxEBco5ooQJBQjjwwwcxPJ6kcIawlGuBqROoUS8P/TkvjE8QCb6azcDfc71n0JL0wzuGNSl5Oq8hKQXCsxmQeBkEINMdcQLVXW6ZQTidPWelQ0fM9TRdo+OoTNp5CLQoGYreWNc4A7jHHkZbS+lNzvvjHP1KmCSUR67TVbiBoW5HLq5gV/J9jDDWfvGHcJ+uIhI/T+ow0EgWEiE72BQ7jRUjylIyKF0+PWRVkd93fzBaNZ7QLt6VgAlLlc/lWHD3sM/Z+r61oJK5DpCca+PCIwo352hw0ta22P/CQv1DyTwQ3gkUZIkXRoeH3LkbhjrbY3HEf4/27WWnAnCEjzN3Upy+UeROHAvDuBGFVBYpue78m+7zTOxYUHap7jXOu2KkKWGCZDJgxPvuTtaDWukY73S77mXQsl+tGTXr7RHqMxV0VlehqEaekOPdNQqqusHy/7ZUtWIynQ4qKtytEOb0MQOA2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ac36a4-8276-4263-c96a-08dd917fe434
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:43.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14LW4tWbJjovBM/VkktANj/eM5I0sCaXmgaxJYWBCScJ1FqORx30YErq00hd8VwhdjvNHTlx6bHMXbC60tbZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXyTjw+E3MdoHw Ho/MHk8JpmF8LE1khr4PHaQ0Lx9B/ryFUcpc2U7Y51RJSpnHJI/9n8W5OymTk5JQq9Bh+1+lFLy FL+gqoZcAaAvZpog+T4sgp0WHA2bmdtynewUzahUTazqeCueVxxd90hdPyXTN7QhlW2nYNp3C9k
 g56z3rvqox3N7J2tg3i9Tb+QdSDNa3iWCa/gxQn9ev76XUqYLir9XLh6t7kon/SP3i39W2LuaC1 pT9tr05SkfxEP00B2TqJRn/X5sSvPFKn5sFfEHvxzoGRVRWXtmPiN2+Hw1bF4vSayu/nctm0GcN UD43Wq9RO74Qo3Y2yZ7EPCVLywAucaEQLcLIq+DKK3ENLnoXv7Gb+hGCCSf/vNZrzH+uCGSNRAF
 JKsGU+mEalTSYvc5LXD9dB8DmWODlo3i0t0lYNHlcddcrwPzY7yboaj1Mg25r4sSTmMHEZXi
X-Proofpoint-GUID: vSnoVcJsNGQ3w4UvCwleaSVDX0ooldZI
X-Proofpoint-ORIG-GUID: vSnoVcJsNGQ3w4UvCwleaSVDX0ooldZI
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682238f2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CSkJIDFBi86Yv6mB454A:9

Refactoring `btrfs_read_policy_to_enum()` to add new sysfs knobs, such as
device roles and block-group mapping. This commit introduces the
`btrfs_split_sysfs_arg()` helper function to parse string arguments in the
"string:value" format.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5d93d9dd2c12..6ba118d45a92 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1317,7 +1317,8 @@ static const char *btrfs_read_policy_name[] = {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 
 /* Global module configuration parameters. */
-static char *read_policy;
+/* NULL read_policy will set the raid1 balancing to the default */
+static char *read_policy = NULL;
 char *btrfs_get_mod_read_policy(void)
 {
 	return read_policy;
@@ -1329,16 +1330,10 @@ MODULE_PARM_DESC(read_policy,
 "Global read policy: pid (default), round-robin[:<min_contig_read>], devid[:<devid>]");
 #endif
 
-int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
+static int btrfs_split_sysfs_arg(char *param, s64 *value_ret)
 {
-	char param[32];
 	char __maybe_unused *value_str;
 
-	if (!str || strlen(str) == 0)
-		return 0;
-
-	strscpy(param, str);
-
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Separate value from input in policy:value format. */
 	value_str = strchr(param, ':');
@@ -1358,6 +1353,23 @@ int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 	}
 #endif
 
+	return 0;
+}
+
+int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
+{
+	int ret;
+	char param[32] = { 0 };
+
+	/* If the policy is empty, point to the default at index 0. */
+	if (!str || strlen(str) == 0)
+		return 0;
+
+	strncpy(param, str, sizeof(param) - 1);
+	ret = btrfs_split_sysfs_arg(param, value_ret);
+	if (ret < 0)
+		return ret;
+
 	return sysfs_match_string(btrfs_read_policy_name, param);
 }
 
@@ -1366,8 +1378,10 @@ int __init btrfs_read_policy_init(void)
 {
 	s64 value;
 
-	if (btrfs_read_policy_to_enum(read_policy, &value) == -EINVAL) {
-		btrfs_err(NULL, "invalid read policy or value %s", read_policy);
+	/* Verify whether the read_policy from modprobe is correct. */
+	if (btrfs_read_policy_to_enum(read_policy, &value) < 0) {
+		btrfs_err(NULL, "invalid read policy or value %s",
+			  read_policy);
 		return -EINVAL;
 	}
 
-- 
2.49.0


