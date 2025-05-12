Return-Path: <linux-btrfs+bounces-13937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A114AB4306
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3497C1B6295E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D22C3741;
	Mon, 12 May 2025 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r5WyGn80";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vPqTbKi2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC85297120
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073463; cv=fail; b=uCTbuJmvOvkrEh985S/jqGyiZRiTx47jII40rVA0DNU2IAXbi72Pb3WErnFFesOToabUVC6y1l4dRWo0cnfetKq8c7s24T9jeN7SmvW6ioozDUu+Id2hFirg1h5PjsdwyvEnMALd3KMXlP4chXtjW8YD378Wl6yZmnTcGMMq0jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073463; c=relaxed/simple;
	bh=+qUS1foZ/+VWuL05vB2MwOYkAdW5Kn3FTuTNo0lDPJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiTK4+DG9uN7HM+UTchQI8OVMo0xbq/B0irOepyqwdEza297cvV+WZSSCqmcjdvSGkzBgMBkvmwUHwOZfOKgHdYy9KGs1JCeFF+U2yqqQre4+XI3B0zqrwn9d5+xOKLK8Eu3fPyrfppe5rVKuq0M5OY+c68vpRuzBddD1v2jm4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r5WyGn80; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vPqTbKi2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0uIO003990
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=U6IiuzN4+2Vmin1JN5yuAXysxL4O553X+poIaTLK7KE=; b=
	r5WyGn80CWXLO5rBwKlQxJII6m/SmINkL1vjQwJcIFCq/n6oR9vlR41kVx1eyLmH
	YbvukAn2ztb0mKOkOtosddeSOSep+CZClu+cPSqvVpbe5mADXoUhVif14qK1w3gs
	GUS9SC0q0qlWAB2tmpM9cWQBpbohWwVJinvMV2sgOlAqAUGsRIE2RQcqA+RdzQK7
	OwPXLw9B+il4D3h8GpmPXtPDFY57e91vX6GhQWlp0XlM1t9QzyEGigyI9zRNfAUl
	Q8iydWsiA+mPTQ/bshbJeilWPc/yUGwomWnSbcI5k40Cg3rDsZcuPpvxdaNIZHbm
	jCD1z4Ltv7mix0ykEe2l5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r35b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGqKHV002104
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:55 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e79e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmtVk86O4QiNqfU7EC3MkTg0zU3/4kstpSzJ2+MzepkIm+Un1CiVxGtUOdY1TrMSU5MOqsCYPuidmy9Qkb5JQwANURoFtoXhAkeyhmVylF2FuLC4AG54/Da3slmgysmw5/qhvSJc2JPa4oDO/WOCXRvm+B5W6IDK2KtJHzDtc5eJDnqnvJE0uE6oup1fWjkDUsDqEsueSreOvm8q0gd1RP2glbj1+w3t7Wo7BVDFy9VZHPCsahlefSpU5ctbPuRpXrULqHq8FM0vJj4G19bFRTEFsS3evMHCo/wNdZrHnLBFRN7FdHpnSEmsf3//GWM2fg6ACs2GJWPp5vtZanhwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6IiuzN4+2Vmin1JN5yuAXysxL4O553X+poIaTLK7KE=;
 b=tiikgyGqJuatqKDqQDO1s36F4n9WtkIP/IhgHc5OfNh4tfgWN53YfNrjUoV8zdoA1k0r6aEcXNcxIQaQlolllSh6w9d5/5NmYtqbTGD4SLohCZ1WkQ9IXkEyiNed9t0erX5YdF+loEzgkgdxOyyRrvgkbDSTIX2OkaMGYd7AjY4geI2XtgyY9zN2VabwaTdS8C76md/LZYScs6TtqWsm6Hxu/Cpi3d6sYyPn80XUDh4xgaO7hNgiOPijvxfYEfL3P+YoraD3TKvCiVPKCFhbvlVqgQzUHxNTyuYY+Tcva5XE8zQ6fjVaPfXiqiMMmdVmNH5U/Xc6xRQz7QFkKmJuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6IiuzN4+2Vmin1JN5yuAXysxL4O553X+poIaTLK7KE=;
 b=vPqTbKi2jc2yt7B5UGxTpZw1K7OussTja4bLflzZclWMjsAL1E2U3U8o/HH8HSn9HSgJDHGXgsg9j/EYF5kdLrrMzIN5nnxbR3xEuLLrU/ZMXuzb+rOYeT31VAuGwi9+AwUCNxkFsf75gdf2Zcr6g7WoAZpLXGaKrqaljYohYuo=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:53 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/14] btrfs-progs: mkfs: introduce device roles in device paths
Date: Tue, 13 May 2025 02:09:26 +0800
Message-ID: <f4b5afcd92f5549fdae0d5488f9b90637d227ac1.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
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
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b4a27c-d907-4bf6-1f38-08dd9180556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dnO7opCopxrI/nGrqMAUykQeKtYTRkThZE8BJcTE9Ta+TH/Oz6/cRqXbGAt?=
 =?us-ascii?Q?6uuq9s1++VzFVC0/LBja6Qcs5odV8IzZ5qWeeXKPxU5sNkFvp6I7AsUXXslm?=
 =?us-ascii?Q?Y5RUBpQT0An25zVPhQdUmgP/jOw2SJXfpxs827qlXdziKzHgm5lEWr8xID/p?=
 =?us-ascii?Q?ImmyzpbkQixGYg5jEMFaNFln/N5dyswX/bXH4+rSKv3G3feRBEIpE8U1xAdM?=
 =?us-ascii?Q?CcNOh7Pny3XbAov+YT1JXUGg6uv4ZSvEmrMYYyAsowZR7swdZrk2oUZB/FIy?=
 =?us-ascii?Q?m5fsOZ26W0PNycOPkVhHOxbGVifEXG7uQpO+tGwLaZKVs7vXw4RfJm95kR1h?=
 =?us-ascii?Q?Sj6QYGp1F8jpn+Te3gZ1N2D3WeXpUB5FIb1ysCknaYoYK3Utm1uqz258sbnu?=
 =?us-ascii?Q?f0q/lHqgNJVI9VBK1skyl/o1Y0VPXt0Rw/ZHzRpMmaip0ItNKUxNhDWcwTsB?=
 =?us-ascii?Q?mYmpqs77Pa8WXpUSJfhc16A4e20SjYbMtsEv0od79VwimdcvzkVFNpis08Po?=
 =?us-ascii?Q?bMnCBV/W5+LxbJRb0/Jz8EI8MKvdDFA2QAeA6eO7IppG5Df33YW4wIiPHQDD?=
 =?us-ascii?Q?8ZzUBq0RAFdiuGLhIHV3D6M0JutQQaGbdoEYfkHQuM/NhwaLJajwkQzQrtnc?=
 =?us-ascii?Q?RsACkqwLFr1ghxtCdZrRin2ADMFrIZHP/V4gI6sj6zvBjb+ZMR5MSdk/ibTi?=
 =?us-ascii?Q?FMaeVby5HiJsrMjjbWD+/D74iFZb3I4YRmw7wZvTOSNWaPWp30tljpL4nWdG?=
 =?us-ascii?Q?P4cAwWeVtNf1Nz+VHE/z5a3gW7EHRweydiV1njFtXM3njVn3S2Fksbl4Nzrt?=
 =?us-ascii?Q?4bw2+Qu/GqAGWxYSXwX+ntHtx+em5X7/EEn5Zr/e5aB2cEaWSfhqGvLuk9bV?=
 =?us-ascii?Q?lfWd8TW7MwIeK1lIgxhKSW1cEw5Wzlg+IGqDYUfA9kfni+FoLNi6rlZpODJm?=
 =?us-ascii?Q?pqAhuC6JRcTb4CI36S6k5YMtjtqp8bCGW3i5GWDKnMqIk+GmiOMIbJPtZALS?=
 =?us-ascii?Q?Jd/B7VRkbHkRiEF9XvxG5E9FffWpypgJp3cs9h0GqOIIMKjUPdVCFkQNaLuR?=
 =?us-ascii?Q?6rO3FkW28VsVDrday8c9HOSYaDC2iyQLSGjLYRyOpW+nIET6zfJIWplo6er4?=
 =?us-ascii?Q?EZ+u6CEZZ1s1xpleHLz6AmlS6u+PVKP2m0G6dMr8kYcQyiumPKkhaAUZ7V0P?=
 =?us-ascii?Q?KFiXbfmBK3MXfOlugQlMEjyP+aMEaUd40+0oEBY78KVV0n4859vyCj4jRwe4?=
 =?us-ascii?Q?PnxHn5dU9MOfYqk7w2FzaGw5zo1/25v6mQuUxnTqsBrvIeGKQEDeqBYkpXjY?=
 =?us-ascii?Q?UmDNJi2ucDOjx69AqjGe7zBnqL07jpYeS/NJq/C3AbOY5MHKtAQo1os7RUZ8?=
 =?us-ascii?Q?FTi612aD7oJB5dyv7uT6okY3+kPfjmMNZ0KVSnnP7WtEA6HHcM8mjsxNHiYx?=
 =?us-ascii?Q?iJUP3+uWatU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxzkoZPs8JSKDT81m3J8HCcg5UhWjfBdJn8EARzgV+rwQk98vBWW+vr54tmm?=
 =?us-ascii?Q?a9lnDLGZdFZJcEtwyKgpV9HKgLFHBimE9qUFZbQ/bLeD68PCKYHt79JdQ6TJ?=
 =?us-ascii?Q?LNk/9QT8uCgWJzJLIgR50gxukKTnMXz7HMg4r8s/RF+IX80X/psHe82PcZQ0?=
 =?us-ascii?Q?aqMelSURWXhnuFZFtTUfg3D/8At391YEnmybJ1Igc7f5Y/ArNXKNfvq1AjTm?=
 =?us-ascii?Q?mmI+GjKqCBwX3N3PdSEXWSpTw26/HgiphpQb+AwxG4IJWILhKfk0F8swT1n/?=
 =?us-ascii?Q?C3B2mjVvVgHIR+g3a7gqW6+V5pBRrm2oVtr681p+snyTB1RHssXPbnN4/ffO?=
 =?us-ascii?Q?N8BMPloTQbDM34ElUtIvXo2rdbPX95PJIqyT4a44BMPfcSxBkeANX1DRIZOw?=
 =?us-ascii?Q?gdA3DAOj6nhbtvimmqNof1DMy+4oVgi3Hp7OPm/nL/nwo3THw9iCUlOy8gBL?=
 =?us-ascii?Q?gZem0JFctdnF0ZjIDe1d0kIMfQ/7XnGXMYJG80i/Tt1SXlonkA+ARBOyXqBC?=
 =?us-ascii?Q?1j8XuOweb1Q+QzL2R7JbrJuqMtBYqwgZe93DAx90ZtWoLA9QxS8S474EYm3u?=
 =?us-ascii?Q?RnkBkEQAJCo8cBz+jhRiVsDiaEPkXndGu03lG2Z85OCq4AAXq5qRngMEPAR7?=
 =?us-ascii?Q?DXSHnVqXASOv00/CRBbV/ZXiFkwy7+5vDre+k1rCXvo03S/vPHl7IvJMD9hg?=
 =?us-ascii?Q?ehanfHGwOhcYAjsUIiri0yDqguNGVUaMF8cTD3XcWK1IfqVISyLTOYqFkAyj?=
 =?us-ascii?Q?5UTJ7BGTKm0a55NrCXoyfYinEg6f+yaJJbrJaghvkAbsBFpzzYALcyhNcSam?=
 =?us-ascii?Q?DT858QvDMj5hxAXBmKDEb+OttyN2CT/JiDf30WI2dAGx7jT4D+KrWBGT7T8J?=
 =?us-ascii?Q?LVLG5G7QMKiKxZ92M4cXhjT37+VXFr6lUKlMOI48iRArO4eDPGy+UOIqalNt?=
 =?us-ascii?Q?C6PbHG4BwsaT85Hvqybu/OTNHtWx+EBW1r1Ov8lsqql6bzotoeOzSl91AeMQ?=
 =?us-ascii?Q?QgZnJfurXwtqeoQrsZjAyZfc+eqZLEBdoqK1175JeaTJqQtOkKbGlwK7Pbj+?=
 =?us-ascii?Q?5OKvXnL74ULjVZCiml8D5Z6idC23hc+ETSxagnmooJHc5H02b04k7GMAyric?=
 =?us-ascii?Q?B7hy/L2WdVQ/sD3GAHCSuN8PQuFMJExEw8eyTTpT+R0lsRTgyvQBrcmXoaTS?=
 =?us-ascii?Q?Mlh3VpP7ZaT+2d//ERLRfd8LZQWiJOpuzdcWaC0VNhiRwfbCdPBg5InuHxuo?=
 =?us-ascii?Q?bkTdKyR9fEmFzLQd3oSK9+LPl2dInWiya0oM7DPRaWX93xGypSKIwQ0nLrA8?=
 =?us-ascii?Q?IiBCPmDm9pZT+YO6oycgr51+aoon91qJebQJrV26FjdaEDvjTpzEeqHQ8MxZ?=
 =?us-ascii?Q?FECyi5EjHH/AyVUHIQ0HioDgDuduF1AFP91CFi8XaFHKv28qyDwhJLhjC41+?=
 =?us-ascii?Q?UmdjjuG4883i7Mj9pKIJUKRvJIZtZfo/wD8z1WbvJnrZF/2sDsPvLvShsIAu?=
 =?us-ascii?Q?XGNsYt4p4YTuShrFgq4IuBDIyhwdYWDgleANh8JDmXJ3RWOVgCgL2K1TICXk?=
 =?us-ascii?Q?I8aynHf4MSJkaSdOseJ9AO+Y6cFWqV2IU+F9qNHR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OE1sym/X+kEF8m4LyfbefKLlHskYGRzn0LgJRoFbU328GIe3T/P+JZXi+EP3Aiuo/7L7946Bi/PH/6uSgaYgu5czTRFIROUkDY6WrYroTKNJv+gLQ0EDvwFbnfkqizb3+fUR200/ube1gji66vO4Aw0HJdFbdvLj/K5ImdR4mt9b+ER/E0sfDt6gio4GBcETyRqE9V/mw3/SWjUfXcgXllUHGjFAKZAM/M0aPQwGpVXupqZc3I4zFYRCFFZ939ML6L2ZFvx+yraLhoJgoiMHpCKHft3FModtu6L/86OsCGwGH9UUfWk3a4iTuaihEU0PByp2pcOQyb0H/g0FoUdWughAD6XOfwjIyEYsgGwsbD7fcDmJBtFGzhNzKTeQstlcDa41KssmxvcRtUwPjrhuytXq5RXeni6SczBNKfocxIn7UhVSNISYz0uzZBFIPYg54sSSrKwtJ1RqEe7DLHJpmb0vmLR1d9FvCmr1+BiqAap1FrXlH7OtxYTcxfRP4wdDErY1pf6gHLryzhRTC0bQQyydrIMdUShl0jzsdl0ydYCNW1uXRvTUYcpUyC8sT5kcx9TaWHpnDwW3tFdIuFlHZCKrDqWIYXRxNo2PPfv34Hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b4a27c-d907-4bf6-1f38-08dd9180556c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:53.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhWHJO5jMc0EFL1UNi+7r4C4Ndo9mD+Dzae++IgHSOExbfmasYWjimum5vI4K7E7r/UbHRcpN1bKv4miMAVFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX75127zWCumMa tyeMlqEovpIAffIx9gWhqKf3VEB8kr1KjeMIQTeBys0jfyMCAcrcrlJOcWw8tB89/w7XmS+6vSX mazTjpmHFwTx1Nc1iAt47AcTyzlpUf7nV41fjSv/7UzBhPigUyu+GOqYH0glqVDb7sL/uOZLyQw
 6UwxkJtFzEWEyE0qpgxDBA8qHaY7Xw8PDnuK/LeRo6i1Fceeountit/qOl+ogQkMHmaqBo/oiMt PZ/Wuc7TIuZ0VNlPQ5CjzTWAuPUJrsRuwf4034AQM81WoQ0hLpyD3pCVXOzU82DasxGZcoIGaIU RXnTSCZ71nNnrVgEOvyTqfrX80++Ysz7Q8WSsKmxpOF8GSPm5Ywulac+hTVPURSByi21U7su/p9
 /H8Fks3AYHECbfdn2zbuaisCGiO9Z6MWQkmJS/i4U/EgmZnyXeIbUHd5zux+96uA6q6MhBM+
X-Proofpoint-GUID: 2smln909xUhEIY4EecYBim1eUFu69EIN
X-Proofpoint-ORIG-GUID: 2smln909xUhEIY4EecYBim1eUFu69EIN
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682239b1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=an3KzC_Ynz1gRnHH20QA:9 cc=ntf awl=host:13185

Users can append :m, :d, :monly, :donly, or :none to device paths in
mkfs.btrfs to specify device roles for metadata and data.

   :m (:metadata): Preferred for metadata, can use other bg type if space
	is low.
   :d (:data): Preferred for data, can use other bg type if space is low.
   :monly (metadata-only): Exclusive for metadata.
   :donly (data-only): Exclusive for data.
   :No preference; used if preferred devices are full.

Examples:

   mkfs.btrfs /dev/sda:m /dev/sdb:d

	/dev/sda prefers metadata, /dev/sdb prefers data.

   mkfs.btrfs /dev/nvme0n1:monly /dev/sdb:donly

	/dev/nvme0n1 only metadata, /dev/sdb only data.

   mkfs.btrfs /dev/sdc:m /dev/sdd:d /dev/sde

	/dev/sdc prefers metadata, /dev/sdd prefers data,
	/dev/sde has no preference.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 0dbc09339f24..0bf6938f9026 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -403,9 +403,15 @@ static int create_raid_groups(struct btrfs_trans_handle *trans,
 }
 
 static const char * const mkfs_usage[] = {
-	"mkfs.btrfs [options] <dev> [<dev...>]",
+	"mkfs.btrfs [options] <dev[:profile]> [<dev[:profile]...>]",
 	"Create a BTRFS filesystem on a device or multiple devices",
 	"",
+	"Device-specific roles or profiles:",
+	OPTLINE(":m|:metadata", "Preferred for metadata block-group allocations"),
+	OPTLINE(":d|:data", "Preferred for data block-group allocations"),
+	OPTLINE(":monly|:metadata-only", "Must be used for metadata block-group allocations only"),
+	OPTLINE(":donly|:data-only", "Must be used for data block-group allocations only"),
+	"",
 	"Allocation profiles:",
 	OPTLINE("-d|--data PROFILE", "data profile, raid0, raid1, raid1c3, raid1c4, raid5, raid6, raid10, dup or single"),
 	OPTLINE("-m|--metadata PROFILE", "metadata profile, values like for data profile"),
@@ -1002,12 +1008,14 @@ static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
 struct device_arg {
 	struct list_head list;
 	char path[PATH_MAX];
+	enum btrfs_device_roles role;
 };
 
 static struct device_arg *parse_device_arg(const char *path,
 					    struct list_head *devices)
 {
 	struct device_arg *device;
+	char *colon;
 
 	device = calloc(1, sizeof(struct device_arg));
 	if (!device) {
@@ -1015,6 +1023,7 @@ static struct device_arg *parse_device_arg(const char *path,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	/* Copy path and type (separated by ':'), then replace ':' with null. */
 	if (arg_copy_path(device->path, path, sizeof(device->path))) {
 		error("Device path '%s' length '%ld' is too long",
 		      path, strlen(path));
@@ -1022,6 +1031,17 @@ static struct device_arg *parse_device_arg(const char *path,
 		return ERR_PTR(-EINVAL);
 	}
 
+	colon = strstr(path, ":");
+	if (colon) {
+		device->path[colon - path] = '\0';
+		if (parse_device_role(colon + 1, &device->role)) {
+			error("Invalid device profile");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		device->role = 0;
+	}
+
 	list_add_tail(&device->list, devices);
 
 	return device;
@@ -1184,6 +1204,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 min_dev_size;
 	u64 shrink_size;
 	int device_count = 0;
+	int metadata_device_count = 0;
+	int data_device_count = 0;
 	pthread_t *t_prepare = NULL;
 	struct prepare_device_progress *prepare_ctx = NULL;
 	struct mkfs_allocation allocation = { 0 };
@@ -1561,6 +1583,28 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			goto error;
 	}
 
+	list_for_each_entry(arg_device, &arg_devices, list) {
+		enum btrfs_device_roles role = arg_device->role;
+
+		if (role == BTRFS_DEVICE_ROLE_NONE ||
+		    role == 0 ||
+		    role == BTRFS_DEVICE_ROLE_METADATA ||
+		    role == BTRFS_DEVICE_ROLE_DATA) {
+			metadata_device_count++;
+			data_device_count++;
+		} else if (role == BTRFS_DEVICE_ROLE_METADATA_ONLY) {
+			metadata_device_count++;
+		} else if (role == BTRFS_DEVICE_ROLE_DATA_ONLY) {
+			data_device_count++;
+		}
+
+		if (mixed && role != BTRFS_DEVICE_ROLE_NONE && role != 0) {
+			error("Mixed mode can't put metadata and data to separate devices");
+			ret = 1;
+			goto error;
+		}
+	}
+
 	arg_device = list_first_entry(&arg_devices, struct device_arg, list);
 	file = arg_device->path;
 	ssd = device_get_rotational(file);
@@ -1584,14 +1628,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		u64 tmp;
 
 		if (!metadata_profile_set) {
-			if (device_count > 1)
+			if (metadata_device_count > 1)
 				tmp = BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE;
 			else
 				tmp = BTRFS_MKFS_DEFAULT_META_ONE_DEVICE;
 			metadata_profile = tmp;
 		}
 		if (!data_profile_set) {
-			if (device_count > 1)
+			if (data_device_count > 1)
 				tmp = BTRFS_MKFS_DEFAULT_DATA_MULTI_DEVICE;
 			else
 				tmp = BTRFS_MKFS_DEFAULT_DATA_ONE_DEVICE;
@@ -1774,15 +1818,17 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			goto error;
 		}
 	}
-	ret = test_num_disk_vs_raid(metadata_profile, device_count, mixed, ssd);
+	ret = test_num_disk_vs_raid(metadata_profile, metadata_device_count,
+				    mixed, ssd);
 	if (ret)
 		goto error;
 
-	ret = test_num_disk_vs_raid(data_profile, device_count, mixed, ssd);
+	ret = test_num_disk_vs_raid(data_profile, data_device_count, mixed,
+				    ssd);
 	if (ret)
 		goto error;
 
-	if (opt_zoned && device_count) {
+	if (opt_zoned && data_device_count) {
 		switch (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		case BTRFS_BLOCK_GROUP_DUP:
 		case BTRFS_BLOCK_GROUP_RAID1:
-- 
2.49.0


