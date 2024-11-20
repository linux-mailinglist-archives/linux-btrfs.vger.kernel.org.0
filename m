Return-Path: <linux-btrfs+bounces-9773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C29D39A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 12:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821331F22298
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7721A0AF5;
	Wed, 20 Nov 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RanGbSL1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G0/1aldZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435619F495;
	Wed, 20 Nov 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102857; cv=fail; b=u2VHaoeDyAwfiRZZLCr0DVTIwcHBQelIv4yxgZoNW1QO6tAEF3xZlNXiHBzw8xA/JogpYQgJ0cPG6r2A2jogCV/A47u3NiQzR62K/CvUSSi/U5iaOfrLBOcySIpcgLqbctOm14l6n/RtP+naQvCo8eAGnaHmptqPHujd+J0xZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102857; c=relaxed/simple;
	bh=XJnTl0drKOHaZdVhjwqxzB51ABJtYYvHuKC3ANPY5i4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V+3izYrVJtzaC4HCEQ7oZID0XA/JU444TlGcYqLPpUqu5Vmyma+6AAOOZv6s7xNTatT9brSedQx3sG2ps/KT5OFbJ/X96J6Tl176fGMRonCkxJDrXm/FKxOTgQ0gmihZ0z/ET8ddb/LAik2q2G/4FVdJ+ox8WgbIlrpipLdPfLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RanGbSL1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G0/1aldZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKBMbFu027945;
	Wed, 20 Nov 2024 11:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=mbvYFk/KJtQ2lyY+
	prK6IUV8VODThXyJzYEA6F0AvM0=; b=RanGbSL1DaM0sTQMpO/AHWirg1GmeFqZ
	PntGhTAb6zodgyk6AE0V4GFAXlQ6aHO9gy2G7rpjs2nqgVYey53ynMOZqg+i0Rcm
	AOkZNmO88qbygth2wpQi+oTTD/qg914WnWZcN+Do8EFQRZBhUPSsqQrYNsq0Tpu4
	LXZscS+x3pooGuTLL5cBpZ+QNP1/4tCc1B6cy1kOOmDJ06c5QDXZiUgpGWyt/ovP
	n7HhBBudhfKh3VO+5F3rf8i5HKbQC5WBp5o+mzDTSBLGjRCxF8Hkl0uVPjfJVoz5
	/i2l3AlYdkIjmTyq6+fAf/3bcD+ei+Mp2Eweggb0z47okDFGLjbrgw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5ajte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 11:40:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKA8lYD023063;
	Wed, 20 Nov 2024 11:40:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuaevxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 11:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNtTBwjmKhwRFMNAuW3Os32GBDkHQr0S/oBIsQdXuXH2zXeC2q/rDUJP/WFs2cqXI+5IfnSRfOcun3kdlttNFsvnunL+rsq2RbZP6AxzOduTCasOSueOukNhTAm/I6MNgnJGGF3kkWqk0kAIdBcQ4qLGedTiX9+ShhqJzxn1Pz8ejGcUsF7Jb4Is1ofilTxpIA1nv2rbEpt+hYMjJLOONPxmLtR+yJdvLPppYL5AdlQA0H5GQoNuyoTjm/fKCccdrLyPYE3P9um1+ZEpCqNmZon3tnuNT1v3RoRBaH+kKlwvcOvoUeiQVqcZCB0dGbiVCYlp6wyP2Hdjtr0STyYG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbvYFk/KJtQ2lyY+prK6IUV8VODThXyJzYEA6F0AvM0=;
 b=tuQ9SFLsHNcjXAxJXD9Co1Vz+FnLhcFnCMlcVfTrdmgk5GpnDOutVBE9RKSuYpyYdJQ7UTGgheE30g/wTvvgiQmDxsZN2iUTJfzmSMknKntFIq8BkuOoSqqOyxA6/aEjeux2g6Jf3rv0jUgca+tbTlAu3wRYo23rmpCUKECxM51RoiV+B5rj+GyaQ4gjfjxqSnAht90a/lLT19FmAhfLVpui4Ixcqm5CgTK5SpKrb/tnaU6ulVXJoC3REnIUy472ZWloZwv4yLJUlyjKHDikaFzWt7Z2OgdbsoLMPCj678ybmT+dd2BAwQkCm4Z8mSOiXHa78/Bwzv7ou3F8HB7H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbvYFk/KJtQ2lyY+prK6IUV8VODThXyJzYEA6F0AvM0=;
 b=G0/1aldZCeGQkgmHpOUH6lVCi5dAg4EuCVzudzhgjLtC2aQ1r66/IrypHLx3F7pFD44hLS0jyivMmpu8QjvrZ7ZUMFYMI4aHaPlhbwCwHqaRSnzAITBO0O7LBLNbpY+dWHeCMpEA2xVKr7vsvf+EBR96B/5r64NRqPcDmNhcnAQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 11:40:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 11:40:50 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH] fstests: fix blksize_t printf format warnings across architectures
Date: Wed, 20 Nov 2024 19:40:41 +0800
Message-ID: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: aa39bac1-7bb9-4225-d74e-08dd09582ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mg+Hmt9PTvM5qoCB4r0JhTbs0wBnussRPpjmlzc80oUyu1FhHySs/vJnK02S?=
 =?us-ascii?Q?IwEJOWk4NIl7P7mWP2mry9AHiN2i6kXXvvoYGZS974lScbZYPWTe9iT0LBlv?=
 =?us-ascii?Q?9sgrEK+iYmx57ZItJx4om2oqOlrlsh4bvctU4EoQ5HWlPxyLa7IyrNQQ3+v5?=
 =?us-ascii?Q?TPtkgUcCjXpbH5+NNQuNKsWe3D0bXSh6OleiO4875GwwsJN0pXiO9g6QVHlS?=
 =?us-ascii?Q?nxRFgJXPrJDPvx3U+CgsWOep392qDH23eNF0kXwpp9GaINbtz2+mc1TntwmH?=
 =?us-ascii?Q?gqfYNZH3JksMxrlttpn5gz5qQrHPSWJaXkKtbmWqlJJGNa4XwnI8VBoAuRld?=
 =?us-ascii?Q?Kyt129v8apaEINClHGWgBtNdW0uEMDf9PAxhHbeAgDh3Xjs69cQ47/iGPZMS?=
 =?us-ascii?Q?9Owr8eDET63mM0smR4APRCgwdFqddhDmanRTxlw3EusMiqVyuHIXkyPMLe8c?=
 =?us-ascii?Q?0l0k44788lgD8P/bEARCh8YjDlfWt/asiNFRggSrebpy7eT0ZbMTyEqKMEoe?=
 =?us-ascii?Q?sf01DRYYFpkID1fK/nmKodTN4E2spDy2ZrCRbbpZd4O3oOPxY3FzcGzbyCiv?=
 =?us-ascii?Q?px3x4w3rS6usiPLf2YsLXZ8WcIMJwcO6FwrSexcnj2RYNlKb2ZJeUBS0waFY?=
 =?us-ascii?Q?PhBL8X7mKc9uqhlNKWJeVPFDlotL/8xySNN5KR1nT+3FuGa2Ez/FEazAe6K+?=
 =?us-ascii?Q?RUZT1sPlDsLnQ1YXb5dYFz9bvGNXOhml3Kyg4CpyHeU+aAX9Gd/G4iqHnxvy?=
 =?us-ascii?Q?sM781NQ822VeQr0b0d5hgxvA2RXBgsy9ud62BFMQ6q7BLyUcNGpI54hxICnX?=
 =?us-ascii?Q?o0jPEbIXh3poBjneN+gbcLw9rOiI6v/GmrE4yk3n1c3kNBFx+fA30s7C06bH?=
 =?us-ascii?Q?KWyxrwjHoharsrIorkiZLW/JaHF/1NWkyRSVfu+klh0X2LN23pv/cn5n/du4?=
 =?us-ascii?Q?wpIujT1/9TD0SlfMSq/yf64cymditzEJvHN5t3uXbZpEhMxkcjyhhCVnF98P?=
 =?us-ascii?Q?E3YGSSC3zuZ5x2dle9a56JgbCr50Xb7IIsHyE2fYXMbzGIOBnQYzKJPr1+HO?=
 =?us-ascii?Q?wbvHnulMd523o2kSaaLD4Diejah7D5Kytb16fGNybv2EImk9Ci3WftL4o0mq?=
 =?us-ascii?Q?IChAVxsQ0rYDbO6iX980uSu3UeBN+shoPC8AFf0IPRQal5LVcT2SwbO8jcQ8?=
 =?us-ascii?Q?LRnnYfiU9RTLOCd4balbrupPhY4Pm5bMaD6kn/V891KrnfHF4s+RS5nxxG8x?=
 =?us-ascii?Q?lW0GOzJjD+7A9i2ZAOkoDd+FznO2ANQMLpPKT3qNsbQfAPeQOEpxOcsOR92Y?=
 =?us-ascii?Q?4PNGnDIhL0OJDba3BDYZ38+l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqJv1lQfey2lC5k57j/UMi1pSFYHthQ39B2aERWz7lDfASf5lUIDxr8mBTJH?=
 =?us-ascii?Q?jhZbnRV1SGQZ2A3OGuzjxwlCJIKfl0a058OvC0txJU7QQgPjM29NCKxhNifi?=
 =?us-ascii?Q?WIGeUXWRiQ8zyeHv/KeDRLEVzQQmIcNvBtx7zrT8qKwfNvrxCWMIthX7Zr++?=
 =?us-ascii?Q?TN2V59ejz72vTFIEK0TmfBXW4eM6Jv/XmFFrm6YmpKUucACyXnaR5MDHhpuf?=
 =?us-ascii?Q?iymEYXOg1njhgKr/0uM8XRusfgJ08EVx5YOQKu9IjXl/bp+2XBFnZB3kmlRv?=
 =?us-ascii?Q?C+8wQOCJAcyiHhZbcTlWQT9EHuXdv3eJvZUPnzDyJUhCA99XWYzB+Ohoc2ie?=
 =?us-ascii?Q?QKZc00jn7s4geiF/G7WrrJtf7UQG1Pe0sz8W98t1EKj7goV9JIdLm9DGlhpF?=
 =?us-ascii?Q?IfKwQqIMGNLEgns4DXiHUjXHG1skedrUPKk+BSZXjtUnAYpsuWAELhqcnOJf?=
 =?us-ascii?Q?GbDgs5WxUdLCnHJkPrEs3ROE43wi3xLIvUVp/70eLyNhwxh5tJt/xuzSDx0S?=
 =?us-ascii?Q?5Qk1+4RKlDzDitZOUCCWBkDhogDWpYaKLbDBfVH0BJ+4Xl6ck7EI+KeztayG?=
 =?us-ascii?Q?br7Z5zOp7qT+ky1Qk92F1Ny51jvrKv5icXIpdWk+d/2biqTv9RcGLG6U0bV9?=
 =?us-ascii?Q?Sj6bq014xMtDPqWH68Mwouw5b1UVWTSs910JCiZculNJ56CY5rzs/ZeEn9rc?=
 =?us-ascii?Q?F20+9WvDcbL78qDar2zZUgq7hmjJvwDf98M+IVVh/1RIVaqgeHLEdJUbHB6M?=
 =?us-ascii?Q?pPDdZYI2nZPrsJ0xRwZ+nPImDjMEw6IYchViswtYu9zBOeR89hFmw+vND641?=
 =?us-ascii?Q?gGiC2i5UdKhcyBL+3BnmQpYb719hPsqv/mo/nKM5Y/9HSH9CpP6/o6i7gd+/?=
 =?us-ascii?Q?4bFpPh4Cqqbs3YjArnvHqEgiRt7Y/xq7oxQm8hjvn2shypIOszVGy4T+k4ib?=
 =?us-ascii?Q?S2iJS4ejIXEG49PzIUoOpUjDCTNphHccJsiwXSHP9aEgoeCc/dRQDfWNCG1/?=
 =?us-ascii?Q?ycCKloWAoK5YYsZl8sp038iqXXIvCrSzF6bnFOTjfhUjFg6ppGwbx18nVt69?=
 =?us-ascii?Q?2oJeIqsW0YxWBt8kwMvXxYUCqH3OCF3LBArjpnOpTsmjeCNRs48IlNJPGn1Y?=
 =?us-ascii?Q?qVtmU6RzKWVssMYkycal9bOW4pS4Z3MoEQX/2DQE7OZH1IQI2DmgXIjEGQyI?=
 =?us-ascii?Q?jKTmqevJnPovnVbuNXRnAaO8PD4Ah0tsyjZYlhe+NKUwiKpn0dmPJQ262NGW?=
 =?us-ascii?Q?v2/ClDgESJLOdN1amgrQ1CvduGmKo7QZhHntjucFEJjfGtoQuCyAlx3cIt8w?=
 =?us-ascii?Q?CXIH6QRviv+Ih6t9B1JRgChSKajfY0YEp7qvUsGhG8zFQAlGiYWYYYvO2XI6?=
 =?us-ascii?Q?iir2rWcnOVhcxKBTMyOuHRtHWvi5rI5Bc5vAE36ucqxd84dx9H+i7neeEnmI?=
 =?us-ascii?Q?LudYklp6SP/0SCwNykXAXP92SlZccj74yy+fnQYlo0Yl68708rm6tTxm/4nP?=
 =?us-ascii?Q?VBTywU7wDO9I4uvr33HlQjv635bccNaaKiUDnRSOlJI0NyWGLWmXq+8WHENX?=
 =?us-ascii?Q?0z0/naIiotxG1tGlTYQwhjjVanWCTAGCm3AGr8/3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qLAhi0lB9kuTSHU5emD3ba17DUmVDM0wA2o0zYF2xBEJFMsmkW/Ik/7H2BLnsTuOLb0Fcr6VcfW/grZQBpYiVZy0BR5yBhS1etS8/rt/v7Wx6x1XCreY63dXmHYElU0ivr/HDDOYA7BvtWk0sU/DKjxBkFpTzLOQicZWyNTejuGVggch5HLvo7c/pd4r88WB/LpTS5uqPJ2cEFhnxLqJm3fME9hYRFShFgoiKK7wmgHNEU0Jw4DcvTkvKyffLfD+Ie3Dk+nm7mb/E+gn8zBBZ9J242PeKHPdcTlOuUQ308D3LOQxGnv3Ari7V/qGIxYYFbrl9pXYzzUEimIuIEsWkYKz+5/VEfUjk7MVbJsqpgH5X/UGuYNz2gOLwI9HbLbTr1BPBlzaIMwxMK/WdvgUiWUEFoaAomI69/I/W2mYcBe3oCCAOPcBqXoQl1rm7fL1R4r28X/BopSB6BjF+/L28OMScq44AUARECvsHkgWtLb1cOjQ5fvSK1fK6uwzRxgTO+WUQevLNUDtc5XdpSKeJq8yy13eWtdt4BpMK5Awkc/hkIef1yNc7gsRdeDmX2l21Du6ZG73mav6suV3bswK/l/P4LBkHvsbF89PGxgwZDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa39bac1-7bb9-4225-d74e-08dd09582ece
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 11:40:50.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxch94cCa3jav/sYJ70iLFRruucSAv7kYl6laEHUe3chHPZL+hf9h/wfAlgilKXi15B4HO89li45vOppAVsqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_08,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200080
X-Proofpoint-GUID: _tJF5BOPa79IFgq5XZGidJteW-eeE5sg
X-Proofpoint-ORIG-GUID: _tJF5BOPa79IFgq5XZGidJteW-eeE5sg

Fix format string warnings when printing blksize_t values that vary
across architectures. The warning occurs because blksize_t is defined
differently between architectures: aarch64 architectures blksize_t is
int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
as below.

 seek_sanity_test.c:110:45: warning: format '%ld' expects argument of type
 'long int', but argument 3 has type 'blksize_t' {aka 'int'}

 attr_replace_test.c:70:22: warning: format '%ld' expects argument of type
 'long int', but argument 3 has type '__blksize_t' {aka 'int'}

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/attr_replace_test.c | 2 +-
 src/seek_sanity_test.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
index 1218e7264c8f..5d560a633361 100644
--- a/src/attr_replace_test.c
+++ b/src/attr_replace_test.c
@@ -67,7 +67,7 @@ int main(int argc, char *argv[])
 	if (ret < 0) die();
 	size = sbuf.st_blksize * 3 / 4;
 	if (!size)
-		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
+		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);
 	size = MIN(size, maxsize);
 	value = malloc(size);
 	if (!value)
diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a61ed3da9a8f..c5930357911f 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
 		offset += pos ? 0 : 1;
 	alloc_size = offset;
 done:
-	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
+	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
 	return 0;
 
 fail:
-- 
2.47.0


