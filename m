Return-Path: <linux-btrfs+bounces-14211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8776AC2D44
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10DE3BEC35
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10A1A315C;
	Sat, 24 May 2025 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bkkzpRQK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bwk4kRwj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357F7E1;
	Sat, 24 May 2025 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748059049; cv=fail; b=uvr2Iw5R1XKEtN6BZgH9LznNrwTv7TqtJ1BUSrhCukEI4W6zVFHMynRAtCTouBTzDKmGDnvsKBS5aDy8bXiuFXwDA7ztsxFPNcaJaf3iVm6JyCte2n5hWQo5tioMannwwIttu8OKOmiv0JSosCl7btRDfiuPKNAlyFur2WgYdvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748059049; c=relaxed/simple;
	bh=+j+XUUKLU2vYaXnya4Z6t0vWwBs3LbwXelSdB5/6k4g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B6vPdMn7zm+j4zEEdLP8FVr4UVAbb/7f/cjXqP4hJJWntXD2UHqKKGmUhJYGWAL5GkOhomdrItxuMMhOk6kQhYu3JEOqtchMri0QTIkTm+/rUKhDRxBWycYWqvg495CQmOGzAoctRGMCmtl1xngFfIbp4Pv0U4mg82kjB+5OL0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bkkzpRQK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bwk4kRwj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O3jrTH028894;
	Sat, 24 May 2025 03:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=+JUDXlQXM0tm8m54
	XKr3Wly6v1piU6BP/3xhw3JUwqY=; b=bkkzpRQKxn5PcqKJd/24neGVD8IDuIPj
	xCSK2jPzkvFxsv1RFoMkoJploTmE2kMkftKnmS1HAaG6v+e7VQJaVVTpu2D1uVRi
	LnD7xxHmhiNkabp0ZmqIWDZu7V1CUOSYaj+T5q/etRoHBb+Oi8NDpsOCLJsbuq4M
	SoO4KUol2JLey2ZIr0La5ZZRubvBaxaF1fIEss24fVnAs5/PjNGL0k5eZiZ0XDLz
	/pBM2ic8qFpZulSydf9/E+ioH/43E7diM5l2c+l47KRHQF0Bj8RRxJgA7RsoqRpb
	mPx2ZVp92hOZZYc4W9FwXoomjenhM+e8WkZhk7dRM8XyKAC30VNtXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u65d00j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1Y9sZ007412;
	Sat, 24 May 2025 03:57:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j6agef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwVJBauJIAVfwF0iPsLHct8p6BpWH5i51DIL0WKkUHmR2Cm5B81c2do6exfR50J4WxQPFFucoe5Kz1Rg8ZvIDIbpqEH42IlTPZEmhOIsH9xpyzl+Z2526aaX2J8f/TAONqJ7GBlCFLDPobrWMbB9gTNCLBDSwzl1cyKZ9yKPfU8sXU/tK9gNV+rROMBD4JPwyhS6GtUr0WhfA2se/gEItbA/0ji4qOQsd1AL7vKYBgtBWc4MboHuCMaw2syzecMahoJaSAba17kmN83nhvT/+4Vh7B5DZnXNvCPX1dItnPMifCM8rxSKcqFYAKY26lKHyVNjWzvt6SwfbVemATLdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JUDXlQXM0tm8m54XKr3Wly6v1piU6BP/3xhw3JUwqY=;
 b=inFSkzap9VupSQjdiY6Kao0SW2DVIWilkzNvc8uMh01cAVayUyk04z8cjXbz616cCZlMPSz0CA+eUbwXklJILy8i4o2608ihzY3neLbGYb4I10w+G5BmbWuJ1udjdK5Q5iuGIwLIBts1+4Zxv4cLwphSK9HfSWy99bbKouJUYSoBshrC/dy+/D1Iy8u98Ug9EbgPPRyHJpZhiUkJIB/o5mddcqrgGJrenWQkHedswAaJ5vFr1hhS3xCakKP6Cg7affBZLOiDp98LUfNb10c2D+mdbD4AFawRgX+X0J7tsX3Ge4PSR9iXaBgtquevAQixqTJ7ndE/B38rfmqb83k2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JUDXlQXM0tm8m54XKr3Wly6v1piU6BP/3xhw3JUwqY=;
 b=Bwk4kRwjJu0kgFkLWhxLS6jU9czLU32FFZVio43qwN8zD238RzxiQV5fkB1Oq+sJ3VYRqyeN8Uwm+hqfr+qruY45uHPlfmAsV0X+ZMGG1Fizc0xfzdxjTcGkyEYg/dseIyjpoSA+UmfsPvvS80pcdsVUsmV0EDkECI+YdBehZiw=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 03:57:19 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sat, 24 May 2025
 03:57:19 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH 0/2] fstests: cleanup duplicate initialization and avoid writing to .full
Date: Sat, 24 May 2025 11:57:12 +0800
Message-ID: <cover.1748058175.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdbef08-71bb-49aa-cc5c-08dd9a7714a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oP0jiOXvTLDIy79y9Xdw2uei5oletOarCoXsjxt4DVVsK2HhsPNSjc1ylNm?=
 =?us-ascii?Q?xaIxh9UB9OqzlM4KldFPCwXXiwS93Jg7rfxKB0XfaOzjjotmClISqaMlwN2X?=
 =?us-ascii?Q?+xRLeweURPXqRNo5vpoSsn7umo7Rp6Li/CmqgXKd+O8khZPN6uYDj3TD5cLT?=
 =?us-ascii?Q?w5N892GbrId+8xXAgse1aMSQCPt/kE0g/egE7b1Lg2wCmP/YZWuDzEk1XzIu?=
 =?us-ascii?Q?h9emWhr05QVZHIJtII3u01vMJ3Fj6jw2C934H5+oQfdVAVdTWMckI86TgyJi?=
 =?us-ascii?Q?n6mg7QY3tazqbc6icD/Cqf3XaU3Gjs+P0AFJGlKocKNkBlCBTfAQQoXwvrdP?=
 =?us-ascii?Q?kffcB2SKoTgUCStY7Vc2x2HUE5BjlBYV5R01vtD3DFGdq4p9CXbSLoMc5jcd?=
 =?us-ascii?Q?f8qw9tgXKNSUORTzdHTKyguQ4p+WV+s7tVyYMBye90vIFiuRSZlyAYYkqjue?=
 =?us-ascii?Q?mLY6L/oSFo3JXxkvoDIjPS38+jhqQmhGMwsrDlcYgeaXNjVLkv3/fZVIdTB9?=
 =?us-ascii?Q?hMe15C9qNOKGT7psmFgZH2URzoFhkPo0UoFJTKBUpn5OdOzjAp5fEJjcyhEv?=
 =?us-ascii?Q?H2v9MrSXMTON/hSmgaVl7ZOEoFTcmuTT2tx+Q9DprsExNpoLhy06IFAoNJ35?=
 =?us-ascii?Q?fdoWnRyvAgiBVH1i+4L78fciO1Iznlrup3vs6MNGDelt3ybsbx5VzHFxuj7f?=
 =?us-ascii?Q?Nx55nXMUjox+eOIKt/eJ7ckP4/93v0CtNcURJUNR9CUgRmMvDmo6UhW0/Pi1?=
 =?us-ascii?Q?qv0SNCpPkPxU4lLq/64nWn6XlASIKkaZI0+/yhSuvk2ayZjJS8iO/TdZLR+G?=
 =?us-ascii?Q?CRWNXfI0bux1GI4TdKxakGILGroRaSR9CBnyi5w/Oc90RFhqRIa5SPaH0G/X?=
 =?us-ascii?Q?xBICWknCYr6WkjeOiQMXSyW8Zhoe5yo1VjPD7UfrSe998XvyNgsprcc1iHHd?=
 =?us-ascii?Q?PuEMH0PhXfWjNQKgGQWxXR2Z/iIxTd8GHjwG0nQdmR4MECJYL8ekINgUphJP?=
 =?us-ascii?Q?r9BCUhle3HdgrVTYPcb2IKw0DSlw8TQwqgn5OKLCQekv/3Z6LpRJBfHUnOzQ?=
 =?us-ascii?Q?OWAima8xNqbwgSPbNKU3aOzLjaRjPWnGOoJ74QCatB7dlFrt01cSFKvIIXbp?=
 =?us-ascii?Q?eMRfVqY/aH4FNfc/QwDsephzGDRwJ5EfsFwsS5kp7mOff9S//bJugJXISo/B?=
 =?us-ascii?Q?buT/60vFUPsU3yGqnr0M4Ti9UHKSsWIx4hi9j9gr/lwd9v2wqVDHfk/gYlU5?=
 =?us-ascii?Q?hyJ05GXj/UqNXtgCb8xAMuu6CIn117pYtu0E0nusbB4z1qyGK6RECQHWTBM0?=
 =?us-ascii?Q?Uwu6f9Mcz57+qqVTNUZR95DmgUVnF3LD0PTUXMGkgs6Zn+1IIJ9uV5q18lJ0?=
 =?us-ascii?Q?JeA7pQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9c/VKSZuqnwaQrMIXETUkXNa03379luLsICaVt7FMFpCsWNReuYrx+/vo9R?=
 =?us-ascii?Q?ubclY1yZdT4w6qs9AyTiaVSifox7hlkaX+mhDFDUyfhR3PNkibjX7vFbhNyG?=
 =?us-ascii?Q?3VccaQZr5GN7KCicXcpoGGT7SR1Yk/XzxWI5LnFlpk+PkpN3ClfKwp8wnj/4?=
 =?us-ascii?Q?3rmFREUoulLIuhdYznlITdXTqvEv/5HUm327ym92XVKWVjyRNDDjGIf5hQ4k?=
 =?us-ascii?Q?U9r75j0da8Wcg3QZ2CiSSGybmSCuj9QuVcX7OcVttlA2naKMEx97vUiyzwM8?=
 =?us-ascii?Q?W0WYmlR4absdWhKpedjDiWDaL6Su5NxK4d222JNg5RiE4fa7Zuj9930Elzin?=
 =?us-ascii?Q?Jbat/igMQrNFfBQwNsG/3dWz0jiUdtbSec5VwqiNqEz+fZrG72xrwU4aHGet?=
 =?us-ascii?Q?wlpLfLL8jBIBWjC/gHKnvbqiIcmQnOpcrZiTJJwsZaoV899E0VzGx9Rvlw5p?=
 =?us-ascii?Q?sdcBC9MOkZ75htBp7ilE29eAlZI+OBpEu/FE8HR4rFxvzC9HboD6FvsWq/6H?=
 =?us-ascii?Q?217Fa06abHVJpjXrxubGEqr50CvHNe+rpH+X4M+nMQcgnCMLLVMIjCC0DHLM?=
 =?us-ascii?Q?wW4PmTKihDWfMVqi7thIhgKpqMWUH3GRWoCXFwDt/iUzrlaML/IJ2EUI9UOe?=
 =?us-ascii?Q?9/OHPRrF40BmsvHOViifQZsMqLbeMWTmiFezQHNxNqz1jhGVpNfFhtpEQeeU?=
 =?us-ascii?Q?ji8IUjIqQygIzXmh5vGs2OW7meS121JeToyBwNuL5aLET+9D4kBre+XBTvkq?=
 =?us-ascii?Q?YjWrrLGJGxLlBUnJrcyp/vmxRcE60KcQGnTqwco60vMB5V2qc6M280sG0LVL?=
 =?us-ascii?Q?jkdgdrGRbjdB798gr2th2x0qYzcZ9qjrdnKc2IbZOAzizpFXfRHI9zo6j1Ql?=
 =?us-ascii?Q?ZlOuIV3wjUoz/b3Z/WCSQ6D4gqHJbVCCUR0bv8kbUSPArm88ydSY7cthWHJk?=
 =?us-ascii?Q?VUcQ6nNa0JpZfXTkotMD62FguHB4v9wuKIbn/mFqKBNBxU2qvT/wTiFzQ7lj?=
 =?us-ascii?Q?p23AR1Pd6h0IefLiqXcFOfdRVVeyLyICw/Qf/8AumBPN2rRqLsA1K9ixyv6s?=
 =?us-ascii?Q?LZ0TdLchGN2Dmgl9m8yknQVMk1yQ/LrbMvpSLAKbk80eangNo3rgK4cywg26?=
 =?us-ascii?Q?nZ4Ugtyw1RIkesCBaTYuofOz4cN/jwXSoKm+Oysmnz4C0fGvGtwzPtuS5Eqp?=
 =?us-ascii?Q?SyQdnRUY60vEYxuDxpNBYb/bdz3Wc2CNRv8EkHvA+CKnYpvmLWxgZhbcjSbY?=
 =?us-ascii?Q?eL2NVfxcthzhfk+x6kHnW/aaNR3DKp6uBSaeY2vlKxoJrjhR9my+AnB3vfN6?=
 =?us-ascii?Q?ii0AaI5FFEOGZLB9nrcJ4Bu+sdYn6+k0YK0pce85xBzdrYtGVlgeFdO8Yrzi?=
 =?us-ascii?Q?j6LwSjoT9trtk5ETS2mlInZhjkPH5CnsMpqrNFkK2uDkZxeIDNwaXinvEgqa?=
 =?us-ascii?Q?HAEaqoiPk5i18PPXWPDpB40ClGxSBBfz0/IXB8lDIojY+zN8c+k8aR4mrX3P?=
 =?us-ascii?Q?dwUyXdoLV6nH55cwRiwIuX5WXAV/q+77vHXsgdqF2twQi9nwahXy4F04tl4J?=
 =?us-ascii?Q?FTtQoU6ljG8NunracEPUkxU7oLK+UMXSHLlOIUG0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igQzQIblDzSHPJ6QhEihBhvWn2QECHhUjJPWV0dxC6KPZtsJSugqGZc0Xmg3J3ZGTGIORYHBauG6eQayta/7fwOsI9CseZwYI4v7EDb+9MOiNZSyg/TYuSiZSS4GgL7JQTgE2F0dmPuG1yLcMVzJ1hPf+yfonVeqsrNlLf4tfdgB1vbC9glOzfc8RZfnEp7lUIskB+THCxCwPwLzSooDIhjZ7BkgXUsXhW+/qsMCLtxx/xY2bsa+I3D34a8gK6I1CFxs4T6kNHlcoB5x/1sb2oQ6LgKBud1EzudP/klgRzh1NriHUmMVIdDFF0frKREB4MT3eCe9U4z0xOf3V2ZSHvpy0E0LndHsqzdqlJupG2UelEpAgVEq/1K0TZJkhcO2RcP9bH28PeQUSiKgEPM3J5xeaTxt0GBQRUQJMNIoUyixM/zSrxx7YcbLSZjIv7HEoonT7OaD/u60sqGSCV3+VzOHAsdjlGDu7q26hL3THFANM8zJtmrXErEjfTenyACzlGpze1ejROrm5PiuSA9Vh6g7N9mr+DtwsxrawjX6IMZg0U80SxgLo6Q8iLzcUilF67kqTJ3EG1W+E5zJRspvU4Xs76boj79lVQ+fdAWq1U8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdbef08-71bb-49aa-cc5c-08dd9a7714a5
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 03:57:19.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08qS5FTtwLlBATsSorfqn+YQkT0NJoJngKw7QrR5LeoCsyZC0tShQMhyGrVT9mT8FCDjdwcVgKzhefWUDUdjmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505240034
X-Proofpoint-GUID: rZRmqmIY3QIu3IjNNPsOgQLISwqkBGUK
X-Proofpoint-ORIG-GUID: rZRmqmIY3QIu3IjNNPsOgQLISwqkBGUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDAzNCBTYWx0ZWRfXynDr8hdfozO8 gdNhvmgsUK1iWi44Bn1k51+VV97qE/Nmkw99LSQKe3f7D6irjBWZlLeSwdpJkX+bRtSXkr2zTfH mxVaLMaeP5laUkSTiQy/cXuGvZtvUM0/Yeq/PQKT1QDgG82D7vhLI+yALSHyqTNQVUZ2y1Pdicl
 DAWMoCo/xA6Ie1rPA24haAZLEVDwuN2FsWLMBpvJEkyOEih1IeU2aJ8mtnbSw+g3NQ6DoMm3OTd TYykI8IoQbx7rosHxZypSKUlk1/lZp5E3Lf6UPb7FEYe1N1VZrrcW6deztDniNFNGsFtVXhDxjx WRR+VEHQfbq76qvk5RkOA6gmHIQKjZxXM9oHNTai9eZZZT5jqX3sTkhRD3QtCiZU4Lh/wAtr+bl
 bHEDIh+Z3AahATeXE4BnaTgNFQzpxpF4QjyRyd3PzaOEWWDhOYLQ4d2Q6u+SbgsSm/DbxBXT
X-Authority-Analysis: v=2.4 cv=NeHm13D4 c=1 sm=1 tr=0 ts=683143a3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7T73qEOyJCXcvnDJFn8A:9 a=zZCYzV9kfG8A:10

Patch 1/2 removes duplicate initialization and unnecessary comments from
the test template.
Patch 2/2, sent earlier [1], initializes seqres early to avoid writing to
.full.

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com/

Anand Jain (2):
  fstests: remove duplicate initialization in the testcase
  fstests: check: fix unset seqres in run_section()

 check           |  2 +-
 tests/btrfs/253 |  3 ---
 tests/ext4/053  | 10 ----------
 3 files changed, 1 insertion(+), 14 deletions(-)

-- 
2.49.0


