Return-Path: <linux-btrfs+bounces-14129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D8ABD1E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EC83A696B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455A2641CC;
	Tue, 20 May 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeTTZtcn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eheBjcxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663B1BD01D;
	Tue, 20 May 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729733; cv=fail; b=JU7w5/uPjGE+7FEbjojl+VLc/Xzk5MlR9xeAQYBw6ZrGGwoh/JR/BnS26V93kXPJaY/XouuxkT5nflXzcUPuj4KtHuzqWAvxHsoMKDG4hWMrRM+cDBtJbGRD8EC59JwowXaniDmYxxRgu1BLEgREd2CPBa5MLtmSRELZs9rxjkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729733; c=relaxed/simple;
	bh=JjG2pSmAFUXuGQBAvH0aQ/2xAs5wdFVp0gO8Ui7AcRM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dAzzHxXskSK6Hi3A4RyKykpnhQaNIGRTogent+PfKU5bSWgetuT+of734DDlQ8knzww8utgeO0sIAI1dq7IzIc2gObQ2Eg8dq4vX9LGxdZoOLYQMyUHD1xHerrv13KUU4QAsbr5Ku0oq6cMTDY5cXpJFq4cpcrJBMoqnpPqvbrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HeTTZtcn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eheBjcxB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7FhvP018857;
	Tue, 20 May 2025 08:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=GRhSePkABIlYttyr
	ym8Y9jYMP6ImCrj612EY9iGHqYs=; b=HeTTZtcnBCR1oqNSOijjNsGbvaKgyZmV
	mK7GiI1yMkESbiGDOpMYB58JZLaY6bw8Ja3mp/c3CgJgPNabq7T6w/28HvWeQ2qt
	mDf084gD7U5TaiayCzbWxQUG0KrL+jCBVif6vda3KdLSUPh0pAfJwPMqfMaEpO9F
	TbZ4B9dzq7srehrH8MfvLffUaWBAQ9DVnrKg3UfbY4pB/ckP8cCKIavYAgjwAmUa
	exhRPYRiSF0q3YMAgg3ep/ZyEFU15rErVi7l+rCRUjbBmyVEUl8oeQMp4qQ/dnJu
	ezDh80rqa71KYbp2M01lC8lgkPLg0gs68w43MIJUrRhekEeg8FRieg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdtj8p9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6OLuv002288;
	Tue, 20 May 2025 08:28:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7fam8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TywFWlGmYh72t24vdz4IBP/kzT+KMUzzPkdYmZWsCRy7U6CcyLBszzXPx/LYf3gh3+4dpJDhdWG3Diea6uOaPyDHF3RJlrOkCDr0le859fdWVyX5fU7fUipxwgqFfqf1aNs+dvcT/OocBumVm7H+YV5+wjMVtQHud3pXiGi5GLLIHgM/H7HqWYOsX9IryhB9pFB3ULUcqggjrUBklr9CBdiY6HQrcKJPBWj3CAxkV1dj/3j9qtKI8zJB+oT5weUIvB3GFwaUDxTIQuckYtOI0MK6fl4lIC1bJkgVVYA+lxLkXWqjiUmMQ+z2K4WMD2X/kJn/y3N8fCtT/+A4bxHQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRhSePkABIlYttyrym8Y9jYMP6ImCrj612EY9iGHqYs=;
 b=ymnGHP9hgkM+PVC7t1YY373nijbB00L7KkiUiYywlrayvh19ca3tA5rei9VtYAXg2hEy4gT5CULw89mSJTARjL94ElvzTw5p04MHcGdxT2uK3kopCXy8Uyk4Dg+HyClNftYyKcVR6ujt559mphZ43cJI2YxW4yOnYFZhRpcp8oeo9SbdrXwieRAfEYAl72Qx/XRFVcqkAEcSd+CcKGLe/REGs9EhLytTuy+mTuqodb0vyOgnj3SlHfY+I/oOi1bdaxwU426CSnA3glDV680uESRjas/WeBIZIb1J3KLBOk7zo/5arXr1xzVwaTI1M10peJi9aWlABMe5mKy/PaY61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRhSePkABIlYttyrym8Y9jYMP6ImCrj612EY9iGHqYs=;
 b=eheBjcxBSBdCLn3iWX6yqgtQDOvPjLJtngj7+wwL0NJ9MvSzxYVsvOFS9baKobJZxmkDJEKhhSVRzTAz5Fn8UWKNPrZ7YJIKmjMR8bGNJ1XhvjmbyJnCcXq2ssk/Zfw7ydF9ULMCq3vM7jT28fjDyrwcLRZKdYvrztdECfGOIvc=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:28:47 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:28:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: new testcase to verify show_devname.
Date: Tue, 20 May 2025 16:28:33 +0800
Message-ID: <cover.1747729098.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH8PR10MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a621d4b-68b2-48d8-18ba-08dd9778570a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DiUy8+e+miz4kGDN8W9OdJIPhwoVHHvFe+dNdmF0sHO4qQYdNAHc27/iV2iN?=
 =?us-ascii?Q?v+vGDh14X4QzLUGmAJ3DY41kj9z//O8Keot64ZNHWuXjF9Gkzk1pqRyotzNF?=
 =?us-ascii?Q?UdylYNxamGxM6NJ2rgR4BUNTnyT82KYyIjj9yapkqMDcPH8SYx9nABFZvv3T?=
 =?us-ascii?Q?4szl6Q0ZHRte7N4zOcgOXF2TTB6bsk72Qyzx2KwD5BrCKZ6jYeicBi/DiOHs?=
 =?us-ascii?Q?y+hriCm21pEAImgMGzecPDPRStKll+R2d819N4PGCNsDvgOJKZ0G5KpXUOcO?=
 =?us-ascii?Q?ZZErhloanDcgJfjvfQdNmELzH5eV/ElejPUMR2RG+pIQStX2w7dXRYX0wOuS?=
 =?us-ascii?Q?VizVugHxoPQOV4DV3ALinpYru30KJihtqV3BEQM9E8NXEPc/ogZpWGjIAnLy?=
 =?us-ascii?Q?jvedS8RWd+dRpYuimUH8sFhwFZrzFVt9QqmaWC3mRIX5u9Qhp2jVYvt8oTSN?=
 =?us-ascii?Q?4odfKqHt0uNoiYEJG4KkH/gIKufcPsNJbuDqWB0Cmm1zPPBFkjm8v+iWdV2F?=
 =?us-ascii?Q?AZneQtaavYJ6kJ7IvvV/UKMqP5I3bNuNm1+a7aBfe9gM9Mkju3B31ToRnoE1?=
 =?us-ascii?Q?/+1JlPtwKNSlV7O9GW9SQTyTANSUKcBC2moGU3wbc7px5RxZSeMg0E7SPfGZ?=
 =?us-ascii?Q?+1y5lD0mSudiljFk4RyDytW4q6mDXm71H1B63DKHbg5V/bhk7fD12poChcfP?=
 =?us-ascii?Q?B7m9kEcM3Fhq9NuwV/r+RgjrYJ7ZKwkxwF0eMske0op7AfH2QKcI/l92SGGz?=
 =?us-ascii?Q?G2Sx4NRI4trxPkgwemwmVELBg713pzyEvxa0pwZEHlmdFPsnYRxtT5Dn0F7n?=
 =?us-ascii?Q?+f8oXhLA4ReD2+135cdHVxMD7xN4Ya4TDnRaq9x0frzhXzF+dnJ7QC6COSJG?=
 =?us-ascii?Q?oQ0C3yhBpNLE1mw6gaSJ/RZHSqDdnbpaDK2w7uAFH0SbN1Kv1D+BPyjZxSVW?=
 =?us-ascii?Q?qjmt4PdzS02OPnHFS+4sNQGc7aIgnMVTvckANVCoUpSaa8HLU2UhbbBmlW5M?=
 =?us-ascii?Q?ofO0W/OYGobLRyFCJe93xq5XVYptth+h5x6Aknt9MeMVN8/BXMXXQNzhV9HM?=
 =?us-ascii?Q?c3xkzfYCP/n4HURTUvc11bNGWpYV9KWzGACrNjPTHO0hT3OeT70fvPTX4fy7?=
 =?us-ascii?Q?BxbcMVu3AR2DFqxMxFcG6lGm85FP/cpWvhrEqxIJfz7j0o2QQv6peH3gst5T?=
 =?us-ascii?Q?q9RH55Z3HESZg75HA8EZNe7kvM+bRgZlugwlSHlDIQTkyfbaMup3VhH2H1O4?=
 =?us-ascii?Q?1TcnsiS3eIBcTzqAvRUN64k17IYcEPB59C8bCQtVnRf29TD6ytuJTlBd0ubz?=
 =?us-ascii?Q?+tnbqWh7NvlpEs3+wUhrw1lk0XycEkVpt6CgU9WEPLnob5FTTIxwTx5YYAYA?=
 =?us-ascii?Q?33kUoFQCJEZNO+0grTtala83yg9xSOIoG0Ub95hQWC74vxLRiRcUUAdk8kxA?=
 =?us-ascii?Q?k2VtjC2iU0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLt6K5hc2nKRr7DP03hXG9CZLyOsr4ibnIFsKyAnpoV2QEx7Y/kP0HV+r+d8?=
 =?us-ascii?Q?Z9ORW1dLX4lCwzMR585tOTZuoWghEUXCsAz8pbvphWBNHwm429/4f4jAnydi?=
 =?us-ascii?Q?+gDzcKGaGrGaY6X+pl43UZibvEvKc8ywD8gnTermvV1OmWz5ko4yodqjn6Se?=
 =?us-ascii?Q?jwfVfb2ukBLXMiJH7Mo/expulax06oe/rZWzmT2HgFuNCwJQ25DlU6j7hbEU?=
 =?us-ascii?Q?2vMfsVQrz48NRHWCn/fh507Rlm+/6SGHpIPUqbnK6A2X/lICb1+uYd8kMsbf?=
 =?us-ascii?Q?fvnYqQZSE/Rqlp4pR50Bzu8uegnXiBMoT8zsnIKAooxt20YnXnjf3pY8eA/o?=
 =?us-ascii?Q?SJbZ008+qKe81+ecT6Y/+kAwn7KiPK/fWPbMYGdNh2qUBeFP/qr46Q53jc0a?=
 =?us-ascii?Q?ikLTxBpgHjEhCVmoAFPOtSVykXwtNcqGZhLYTnAC5SYtqbM3DbrYEkkKAy6Y?=
 =?us-ascii?Q?10qb9YG7p89d7GB13AKFGstpw9iorKcwXG1sXW5BZ1iZBn7f937k/u8E0Bl/?=
 =?us-ascii?Q?njzIZgqArBM8AYIODFdMrbygBDI2hBy8WhJIYNs7poF6VFiVEd/sZHgB9dmZ?=
 =?us-ascii?Q?BJir/jk0j05NUlIvcNMSW4Ccc78bUSTm0VKAQlb6TY/71a1S16rGQAjgUiAL?=
 =?us-ascii?Q?wMollzrF3AmKLAzUa7oCBM6rwoZfs6b08Np5UAuTjEvMcfSJJJ0jTn1cxIkV?=
 =?us-ascii?Q?nlz35WQBRFIsBlsCENDVVf0P7KgOZ8hdey9yiVcV+Nza1vlgDrYLaEW847q+?=
 =?us-ascii?Q?A6y/YusiQTDAGrF/flIo8dUxa1gViPLlGYlb+xDYjc9RkAlSRIQqLy1XlEQ4?=
 =?us-ascii?Q?8oeIJZxoz5fRc9SBWCpLUAOZ5jKI9bJBOmKmByx+cNHzg+kAMqWU7ivIPxa2?=
 =?us-ascii?Q?JkhkyC8Py4aMaaycX3ZFhYjbSkUTNZ0uFo8nQj4I+PNAkPA4WGZ1V317mjs4?=
 =?us-ascii?Q?wqYmURmp4gXfRB+P0tjbLBlVWwByZ+fQQxoq/wTIwdgpXaQgeJDhaj6dpnd0?=
 =?us-ascii?Q?uH/wW7NBGQr88Rg6vhq94hTJasV903Qh64mHkxmXMdNKmZlE9S13ADCasbD/?=
 =?us-ascii?Q?XYO643P2VfSSkNufON+RUOdm53pb893pnJjG7PSrQpuITvJiYHQVQwyPEQDI?=
 =?us-ascii?Q?9Ez6nwe2XQA5QZTLR1HJhspQ6yuHT9xXzP5j61ifTRj7XvutTg7x47oXaRtw?=
 =?us-ascii?Q?/+eqj47YzxGKZS4ioNh/GHLzAcYGTJr+QFLJlv45OEPAv6PyYuzSnRdm8UXm?=
 =?us-ascii?Q?fsTFJ0nUs+Od6+6z5/p1ctUtBr4En1RVJmekNcTH0YyVZdlkWiycU6tMh9+C?=
 =?us-ascii?Q?YlIRAaiwbxC2qF2KUpsy8jOp3GLAcJIsk7xDgHXzgS2cI2/ko2ghXW+vhG/W?=
 =?us-ascii?Q?+XsXIf8Z3vIA0TxX0S0Mxg93b+G6kEomp28X7miwsUMoX7E8ZA57NT2dcJvk?=
 =?us-ascii?Q?c6ouiHCByIhFH1ioVjWaLMKE7Oh+FprKktg5Ww50N0lWkHDU0t6klY8fjW2w?=
 =?us-ascii?Q?6XGynq2fW5FIk+ANx3mlswEMPk99Xy1W6oPpT0RlhtCE2By/z7zOFjlBHckb?=
 =?us-ascii?Q?m111VgRMxDWC9scHmoqAFhao7xxN+9zQeUR4ctC1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9oR+MmZEKjCU9T2mtS6VYUXaQlATz+PmkxBENsiso+g8Gpyh+x6KtAvWGq+C/whJ7Ai4JZ57iVXVgAPXynp3W3ku5THQsMcvQxqceUKiXRPtlWahjjoFAsUBsirpCTnx/MBFRYUFDInfwWB0alUu0eK0snWSHypUuXJG82v3IkOMOSAQ4sLBOQOJQtqbzBE0yvM7vJfPM/GNt3pXUOsnWdLLrJlRbgbVgfny7Bx4Pr3S8jNohEEcg35H9dhHEW+y21htLQSOIFkm5pnwhdvjv/NrlY9NErLP0sRyD9Jm2mUnlygv46K3II8CVbpqNzCo7uJm44iaUl1HGOzCtYx8phFaN2e7SrIl/zAyo31mO/5b0k+9ltOe5WHRj4kHCQ3yvqzhA4PFBtV/MNhLvixT9rrzOg9Tx9OI6SgtyYiOb6MK81y0WMncW8PZlUwJHuO3IDsUqcKSdSYcUnZGP48UZzQCddH6NpEE7H4tz8VJdUzQMIhLZAFgX9fzOhLH5wjHEygpo+eIRfAc8GNq85OtZwF5bxjanzsQ+oqk/Am2WXxAcjDtlpk4cjlIyRnHdU7WdpRQYVqAzs+Z2FZ+Tb8U8Wzk/bNgnWMdWi3GEsN6mhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a621d4b-68b2-48d8-18ba-08dd9778570a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:28:47.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iBlLjZXsaVsAVSHKNPifYnX6Xc3MK1tDffzeYA9Bq6MOxNj/kLtcR4HqwavYn/6YxXWcCCZHfzea5JACm24eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2OSBTYWx0ZWRfX7pp2Rx1JHtL1 dcbFa7oq+7ds6Y1xdBZE7p6flNUwDQuInPnnOpsYnhSVmNG4Ien6S/Rd85eIZQjSxU6qQuBurEX /4wHAgQ6Q0tNx18WSmpP5tqSEG9xztzs4uJVZQSJeM3owcnhiPDOtLBEuJMHqlvsZU5Re/TQaNt
 SFl/4o6Wj9bl28MnpnMoa+gb296iQbcXRnMCeidDK9Mzm9HC0xPATwGUv0FWiQBPP3y3yGzRXxG XRrL3dH4rUyLeRB8QrJxN2UROM8Xkx2krvNGBlEB0d/zXj4r1/bR91N5CG8h0oENQpPj0YhQFpC EbMaRX1IRa+pDEQr93AapvAea4zMnR6Xm8CYiVLA52mfOV80cNHAGhe402EfR1HtBCrO+AZxExu
 fpXvmO2pMiXSgaB9qo26WNFqkQqk9lb4Nka3MousLXzRAMW/GX/DvTXOPJOfTevo+l5UyiB6
X-Proofpoint-ORIG-GUID: ZsGcM9HE8U4_03v_9O0hdqibEH6qkZRI
X-Authority-Analysis: v=2.4 cv=D+VHKuRj c=1 sm=1 tr=0 ts=682c3d42 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=X100QswJD2lKzj8MJ7cA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ZsGcM9HE8U4_03v_9O0hdqibEH6qkZRI

Mismatch causes mount -a (UUID) to fail with -EBUSY in libmount 2.37.4.
In libmount 2.40.2 with Btrfs, it shows 'successfully mounted' instead
of 'already mounted', kernel without fix.

Anand Jain (2):
  fstests: new test case to verify show_devname() device path
  fstests: btrfs: new test: show_devname() on multi-device volumes

 tests/btrfs/329       | 107 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out   |  19 ++++++++
 tests/generic/765     |  74 +++++++++++++++++++++++++++++
 tests/generic/765.out |   6 +++
 4 files changed, 206 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/generic/765
 create mode 100644 tests/generic/765.out

-- 
2.49.0


