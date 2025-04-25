Return-Path: <linux-btrfs+bounces-13425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF4A9CCD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F03BA157
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088427FD79;
	Fri, 25 Apr 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jE3j+PxV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/Li4GwL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB825CC7C;
	Fri, 25 Apr 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594726; cv=fail; b=mBpdHXjLBuA162Xk/sK0ZGhuCIuA2cpA/Og3NKZNoVLOmshhATen5ZNdhAocQdjKrET9FmVOS9sDz/IwONQOncs3KTlAZB4QF8JF6UFj/La/C5h4MF6QFBEBOoyav6pbXwLp1xU0l3BUJNiiC3Rz6HtbFfGys470mpKrUlySarc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594726; c=relaxed/simple;
	bh=vPtuf82U5I9xOHBm/BhAxp8m+H9R1idtkAOWsBgCmfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QStV4l6ElM6w5wNoNEabKWl98Zctmx4h7j5tAI0+v8gltFUa62Zns/0sOih+g8Z9JaKufCKKO18bJ8n1zswJ+egj4jIQZzwArTlWdfxJvCDjR12qHd/3wfgvU1XpoDpHiBqs3mP/astnV4gGJhVVDFxMrHHTW17QJKIAatbdHv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jE3j+PxV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/Li4GwL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtrQ9028225;
	Fri, 25 Apr 2025 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/6ZW5XVEdojLccGQZ6WSKzWToFddT4kOkVTaqZ3ussQ=; b=
	jE3j+PxVcg4f3xLmQ8sbF5vzoSIzNi3VnLRqqhon9MsdR6dp48RgakZvFPglQcch
	7LkTVBW+w2Le2A1E1tlTe6KsQfAuRN2cQl2L8gMa9kFbUfMN2c1ODSkVVX1zh06J
	38Ogi491q6aJnQxogVKhODjt8VEnErDLl0VbJ/iWMJ3OhvC/UyAEy3fD9TLWPSKP
	wnltF5Iyyh9m5ueOJJylacLT2L1O7ZdxAtO7AyMnhuwVE0FHh7YzfmeRzyryrus/
	2vYpYtC8Elnsolf+fOo2metGFofVYplj0/zvj58btSwwthDWORQ96JZLwBrRMkVh
	L1EO7VpuU0so7zURKs0VKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468c3br8er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:25:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFOINd030971;
	Fri, 25 Apr 2025 15:25:21 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010007.outbound.protection.outlook.com [40.93.10.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08sg8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j34CYRMBlW6ApM/PgIgsZCMn2jyH7IdOAubZUSZu/OwGFYuAz6tJ7IBQJE6gKD/QfRas/evqsqYeuO2YF0A+UQcu68/GzZIdm8gkE+D/ZrbPlXgwmKcd1RJucbk+BR3/nRyWb/MV0IDngvQofDXsafiyZfcfm5glvH1919ldSu4cVCm9/oRG3ss0uNeal8tO/fA4UnLxbgW/D5d1fQyODOPz1uVGk+TPMlHTyEap5XuyWgz1ux088crYqq/sF+SCm3fESC6ZL+m/kwjzqGEWQ900YR6Nox/hI740rancsa950afo7tZppLcOm4jYYYdQjgJ/Sp4GvDbch4sVdQm6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6ZW5XVEdojLccGQZ6WSKzWToFddT4kOkVTaqZ3ussQ=;
 b=tIfbUethSGCM6f56hM2pisMgJRwv+k4XC5yYDCvHZ+iW6aq5rwDZL/E3Z+18bsdFf1nBoPlDSi385FENl39lgwbwYmZHt12g1BjtaHfDqvN6asvgkh577hnp+kIw1nBS9U5GUE1X2Jj1GBnvMuBoCwVS9NaGWZof0UZERO/vPD0bz/CQzASKm6aLZGyTJIndSiCtmnEe76RY2mAmLjPGhDGEQWXAL0GomIMOas8xbA1LcmIzPDugkclJ+lNjaYvH4Ft3cXT9Tg1SVh5UuCg/DpcoQOb4AmYs0iQqpa05NgXoo+H5AEMfrve0U1saxZDAJfwGcewt277KaUbCu/lJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6ZW5XVEdojLccGQZ6WSKzWToFddT4kOkVTaqZ3ussQ=;
 b=c/Li4GwL1jtfrEotupA8ziEyIMqJzk8JbxLgsqqbzBUcwMWqPLeTLkB/AudBwkhZZ7/GDjGm03Ev20AW2fUcATIKG0Bs9eIe70ExG03mP57SzlbXXmK0p0498f2tMEFd674QqRUme/mYElVduXc8RBA8mUHJLejeyIJ5Zd7aaFE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:25:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:25:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v2] fstests: common/btrfs: add _ prefix to temp fsid helper functions
Date: Fri, 25 Apr 2025 23:25:06 +0800
Message-ID: <d6fa73abdd7dcbfd3d820ace74bff6075645314a.1745594537.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
References: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca7391b-b8f8-4fa7-310a-08dd840d624c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KA2Nf/2oXZ3fn8tMIhcfUREgbTNcTYaukj/jqvyHD71OJ9vAjyXN4HH0BCDr?=
 =?us-ascii?Q?ghLAs6aaSmZWJ4a9zOTrpopyjq+cTdza+05jG45dqpRezTDcM0QOHevJTPKQ?=
 =?us-ascii?Q?CIjzS0QAdW1DzOPKgS/wd53XIST2cP94fU7Gwpb8JpRQNWEAqH3EE/w3b3Gi?=
 =?us-ascii?Q?GK8xLkVQMFvj0OgFLTEnMkkLtzBcRPOW7cf4uT3uBVPvJPUzS/aouWIudwM8?=
 =?us-ascii?Q?Wl3Rk5mL6kN2UdV8BssxduWXoIWP+LGYiCF4AIbiAa7DFgQ41ndS2SjdhBgp?=
 =?us-ascii?Q?3SKCfwZnk8pESBn8Ntq77f6OsAjGjFBwdEB3I56MDExtQlIpXVdJcsDtK/ld?=
 =?us-ascii?Q?qJcu8HGvuTjRA+wC7mo+sSSVNW1IsrGZprs2KP/oiFSq0NFHjXhqid3jGSun?=
 =?us-ascii?Q?TowsgcGFJBULrVQz6m45oCflig4q83zdJZjI8KkgxCY5bLt8kgeOuca/T9il?=
 =?us-ascii?Q?CqT48iJuzwTOWlUdgMdQFhPll9pVVC5SmKYYCFDH5ZFHgbWpHmso90rX4mtI?=
 =?us-ascii?Q?XtsV5pxlCABIWBMB3I+EgehwtTX47o44Eg+brXsGeA/QgoQXctKHd/D5ikYb?=
 =?us-ascii?Q?PF1FaYOQqQuNhawOeVt2xwJE505VCgIFsXAuG3EtQ++MmlS59WQAr4ybdukZ?=
 =?us-ascii?Q?yfH0L0X5Tl8g1eKciXKW6595YXeyABP6lhNYcJalSnOKtLr3jI+0QsvUGDR4?=
 =?us-ascii?Q?G4sOSvg91JDPAU+g28JYBM6yVvtPmN2BVXf/MX5NA4wV+11PR32UzWwRlwcc?=
 =?us-ascii?Q?VX8q6rivSrjd4CjGqwsQJ3YIpM82mTTtnORzMtkhovvXWSdrze4OtX7bwq4M?=
 =?us-ascii?Q?LD3YiwvkmU9uX1ksfKOkx2/JvcUbYkVZyh9YWRRs8gsOw//4IyKbQJJ++P9Z?=
 =?us-ascii?Q?nfy7atgauUPDqZkp0CpBLV55Q1X6rKDJe+1rHItYl36asYgjcPcd/+YKHftb?=
 =?us-ascii?Q?WzbloVElazuAtww1IIet4pBejHLxIQ0il1NmnDb8cApzs5XhlD38adicBrfg?=
 =?us-ascii?Q?zsTXPwA7DB1QXc4+KOILrBWVbuJSbH2O8u31bZhdwU5/+AuVguWFvHl/nBaa?=
 =?us-ascii?Q?PBmxCOhT682ZNRSzOx8mmLx1Psxov1d6VRb8Gu55JdqEZXJ3MH3jSib/XV3p?=
 =?us-ascii?Q?+cpR3HehobhBsAEOVnn4EckCksaVg65gN7NzFRrCI5lIAY5nlPzqMfn+a5sM?=
 =?us-ascii?Q?/ZZi31vfv7qtqT3etdvlZqNj8AL55gIzzTQMAY0P8H58qJ4VhmT1k+ilk2Ry?=
 =?us-ascii?Q?ImOXDSJ69pv/8spb33kDQf/pOSjmNASfySa4K7+3yK6O9usBhI1OJ4GgRctg?=
 =?us-ascii?Q?1kezUJraXhDCN6yb7r98he/f7KKJzo2G/YUiGa2F++FvSmyLBYuwCfa4kT3n?=
 =?us-ascii?Q?UKZd5TAAXe27BE7rNwUYiiM9X9IzqaGnBf4z98sSSpatD67AVJonfP/ck2qB?=
 =?us-ascii?Q?bkVTmxtLSSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkDyHX5F6pgtv9P9Z80uPhcuF2/CP/tH+uiS84QA4pe+S1FrIdG5w5bp8xrJ?=
 =?us-ascii?Q?LydBNUj2O4EFesdXWCYFJRVy8fin3L/okn+W/lCPJKtOwnNBne2GEGUqI9h5?=
 =?us-ascii?Q?7MairCZlgbXC+dcUM1ocKb/f7AXAFn6gsisM52GCZxEJ2ftyIzFdOUROmsqC?=
 =?us-ascii?Q?zywbwKIZcUXE7J9EWtRRjJ7m1VH70tirN8RJJb3hOEicKQum+2gUcqT3L4i1?=
 =?us-ascii?Q?Wca21pZydXXnqwqXG9iGy1ZN794MhBht8U3CKSqvxm2NAVo5my9lLpJR8kTr?=
 =?us-ascii?Q?s4BY5Nj9d9I4pKbVZYwksIP7Jb+7EEKkQ/SkiG7ASwXs4si9nNNjlXB2wj8y?=
 =?us-ascii?Q?pnZ72XtyzFre4wNTRwSnINCPUPUYAzQAm6ZHGtfB6U5YMAi5uRzFYdiVcyCV?=
 =?us-ascii?Q?qZQ5sOrI5hR9fVEra0yOCAKFjue1b35T6mGeLsxeED/iDauYcQgT5L8pNjgs?=
 =?us-ascii?Q?pDuX3o6Nm85wgSyM1KeiiLleVNh646cDCVmtkzha52XCtobsRduLsJJyMyme?=
 =?us-ascii?Q?+kM3dlJ80+7Za9mMLfxOM4xdHFhrRlnKyGIxf6NeXGBVzUwPfRIj3ghTpFtM?=
 =?us-ascii?Q?0Pp7Y49bvLt9pYNlAYLgiXmoOq2kHNjJTFA+lcDmJg9+nv/g8qm66iHVOxcG?=
 =?us-ascii?Q?SX8UHpyR7KZNrEW8id+AoYuYwuDmHQYR7DpFcePYJ0oJdL/x6N84QrtqNLbI?=
 =?us-ascii?Q?buTV4qqtuICUMFpSO1BHFI2sMnpvS1wDj5paP2zN+AUJzLVbG4LHlzHlv0h+?=
 =?us-ascii?Q?W3oQPXR548IRXYoHbGzqxYwPPRBn7gI3wPG3fUkLIh1LxWl0VL0iIyCsSWsL?=
 =?us-ascii?Q?r8LI/8hDWoGiZyhSeuwonOwkLVB7z48yi2UdMS9pbPa7qdzr9uliNydof/Aw?=
 =?us-ascii?Q?4/JvkHKGhJV41xGtL8Df4ziICNDao+vajc7cQwO/7LTi6GI2HsMaR/UsJwg1?=
 =?us-ascii?Q?MQuV/kDdXcT/cqf6CSaAprhK+EC5B4w1oHRxAIHpNqNHi7PrR+8dzmGxWTpc?=
 =?us-ascii?Q?xk0MMsSzvStqLtyjq8DTzYG/LpLUnsnU3MZh5pilm+vPAxGC0Q+yq8ZQsrfA?=
 =?us-ascii?Q?IgshoGaVylEN5SOe5Ip3Pz7zVOHsCwOjW+j6zFpaNAnliKkW8Tk0A8DQs/KP?=
 =?us-ascii?Q?hxjOszc+Yjw4GpcWYOb7shxWMOSDSGzrsyNr8TZ6rco6RusYzuki+yyOgMHo?=
 =?us-ascii?Q?ZBfHTwp/chgVOK4irU5wmcnCTxOC20R6IRbEYQvC27bcq9Jysq+C9vip5kRu?=
 =?us-ascii?Q?4XCBjgjXMS+diLp0/GAyQZ1YMUr8BMfxjvb2B58n38zf2sAwUSrYwMvV/kad?=
 =?us-ascii?Q?568LuVapZ0ECYwwI9CJP0ZJRZ92LzbNKfa+RmKq9Y61ZT+UjbtFOcaDNs1lK?=
 =?us-ascii?Q?9iMRSofC+0aEvYh603CO7IUDEKq0lxT0cL21iErVbMLxJzusHtt+A0fUl3Kk?=
 =?us-ascii?Q?YSGT8qt54VmtBplUjLiMdLo3VKkhvzIPBFbJNB5C1xY5101wXtZb6w2ZqzhQ?=
 =?us-ascii?Q?G/9WP6NvbYn7qKQ6ubGtUmJOziml8ST0Jeh64H2vfv6ixoVBQAjxMilFuWSu?=
 =?us-ascii?Q?yUucHWUkChnHOSMV1x9tfEUhCf9NXoXpQ45q3bqZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	judsiH3mAySx5l7Z1snYNCxUmtf5Y7fTBGaQC4pSJW9B8AkT8QITH25j7nxbIVJmxeU782Gba/Wc8QhnzMvMlGL/bgXqbLd0FY9GauifQxsHhyzo3YHXIK65YAqfKpfl4+SCfOPtWKek/tDB7CwAS2ak8XlFbYM5EYU+BKLWsJr02U/GebC3r4xIHrgAA2i87U8wQanreQ+aHGjUdI+nW5s+0FOz9r2w+o1zTvACzxkzYMx8I6q3SNZQUux4JCmjHCJTzJGBuuQare0gYfBbRa2WywtpA3vQsr9NbNDORcK64Q2VfojakxuweJ9+CL0K2NAoDpACOYabY0VzFjLT+s+mN34IwXdmJJA6uDNK6rxndza/zAjgqZ3h1kOosy5+uvjHPPNKbabW1W4nqoCHLodwYWCPZbOz2X+VgOZmBfw0HPsSEjqjsqbDQO+fwW2wH3BcuxPe7yGMibRFROnV1kqnubVDj+V3ZC7GOmS23VBq+kO0+acp8peiZead/NTIoGRJaKfRyFcoqH8snE+a79WFz/TG/bt0zWEjNHi86ZbCrMooUPAlmtDS11okk3DP5pLaqCDzO9eGqfzZ+Z6VcTVbOYraHZhUQLU1B1j41AI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca7391b-b8f8-4fa7-310a-08dd840d624c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:25:17.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14f094d9UVwjp7aLHOwj0fzBzeV1BTWVjsvxsS0XeiSiH/w7JFd0D/8uDRToG2HuCpdHNU755uL88xRTfJiRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250109
X-Proofpoint-GUID: mspbYr8HJz-Or29nmUdmRlOEuPMSrLpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwOSBTYWx0ZWRfX2FdmwQlGauoa KO5zcbXiLJKWhxGqILqdZCj9Z3jEE2/ZXt1A+ooXiRTGhDB7JY1N93FWsrbgE92DlCKvJsvB2M8 2+xAo7Y6FUJqlsW5HPG9zVSmGACG1kbAOvsUs2jfjZmHWrf2QF3kk+Z6GrepBgBIKZoyoXVWz74
 ISUnqXnfG/L98BlThOwTngqgBbBTUALPvxk1Cjjw3btfFVW4unSWuhGBCpgDeZip4LQkm+g+QDl k4m9eB6Khke6mHdlZ5flvrdQYpDR9ZPyt+eUeM+zotM2cfr3XepY+AAPxj4C5IZWVR0K2qoKg59 hlA3IWXqw/BMH1786aM4Mh/WKkil2nDZXLlJfclKJEdav06pHDu55tS4neBi7g9b8J120EWhVNT nA7cIYIo
X-Proofpoint-ORIG-GUID: mspbYr8HJz-Or29nmUdmRlOEuPMSrLpe

Just adding a _ prefix to the two temp fsid helper functions and
a rename in common/btrfs to keep the coding style consistent.

Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
rename _mkfs_clone to _btrfs_mkfs_clone

 common/btrfs    | 6 +++---
 tests/btrfs/311 | 4 ++--
 tests/btrfs/313 | 6 +++---
 tests/btrfs/314 | 2 +-
 tests/btrfs/315 | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 3725632cc420..6a1095ff8934 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -942,7 +942,7 @@ _has_btrfs_sysfs_feature_attr()
 # Print the fsid and metadata uuid replaced with constant strings FSID and
 # METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
 # it matches to or TEMP_FSID. This helps in comparing with the golden output.
-check_fsid()
+_check_temp_fsid()
 {
 	local dev1=$1
 	local fsid
@@ -979,7 +979,7 @@ check_fsid()
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
 
-mkfs_clone()
+_btrfs_mkfs_clone()
 {
 	local fsid
 	local uuid
@@ -990,7 +990,7 @@ mkfs_clone()
 	_require_btrfs_mkfs_uuid_option
 
 	[[ -z $dev1 || -z $dev2 ]] && \
-		_fail "mkfs_clone requires two devices as arguments"
+		_fail "_btrfs_mkfs_clone requires two devices as arguments"
 
 	_mkfs_dev -fq $dev1
 
diff --git a/tests/btrfs/311 b/tests/btrfs/311
index 51147c59f49b..9ac997dbba61 100755
--- a/tests/btrfs/311
+++ b/tests/btrfs/311
@@ -47,7 +47,7 @@ same_dev_mount()
 	md5sum $SCRATCH_MNT/foo | _filter_scratch
 	md5sum $mnt1/bar | _filter_test_dir
 
-	check_fsid $SCRATCH_DEV
+	_check_temp_fsid $SCRATCH_DEV
 }
 
 same_dev_subvol_mount()
@@ -69,7 +69,7 @@ same_dev_subvol_mount()
 	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
 	md5sum $mnt1/bar | _filter_test_dir
 
-	check_fsid $SCRATCH_DEV
+	_check_temp_fsid $SCRATCH_DEV
 }
 
 same_dev_mount
diff --git a/tests/btrfs/313 b/tests/btrfs/313
index 5a9e98dea1bb..7d09aaad1a7d 100755
--- a/tests/btrfs/313
+++ b/tests/btrfs/313
@@ -30,15 +30,15 @@ mnt1=$TEST_DIR/$seq/mnt1
 mkdir -p $mnt1
 
 echo ---- clone_uuids_verify_tempfsid ----
-mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+_btrfs_mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
 
 echo Mounting original device
 _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
-check_fsid ${SCRATCH_DEV_NAME[0]}
+_check_temp_fsid ${SCRATCH_DEV_NAME[0]}
 
 echo Mounting cloned device
 _mount ${SCRATCH_DEV_NAME[1]} $mnt1
-check_fsid ${SCRATCH_DEV_NAME[1]}
+_check_temp_fsid ${SCRATCH_DEV_NAME[1]}
 
 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
 echo cp reflink must fail
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index d931da8f0293..01646157c833 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -36,7 +36,7 @@ send_receive_tempfsid()
 	local dst=$2
 
 	# Use first 2 devices from the SCRATCH_DEV_POOL
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_btrfs_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
 	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
diff --git a/tests/btrfs/315 b/tests/btrfs/315
index f8785e830fa7..b9fdba6a2326 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -32,7 +32,7 @@ seed_device_must_fail()
 {
 	echo ---- $FUNCNAME ----
 
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_btrfs_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 
 	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
 	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
@@ -45,7 +45,7 @@ device_add_must_fail()
 {
 	echo ---- $FUNCNAME ----
 
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_btrfs_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
 	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
-- 
2.49.0


