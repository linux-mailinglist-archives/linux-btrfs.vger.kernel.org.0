Return-Path: <linux-btrfs+bounces-9761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91649D207D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 07:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FAF1F220D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9714D2AC;
	Tue, 19 Nov 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PS6Wzipg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rhKaVcQx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A913B7B3
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999419; cv=fail; b=Ek8cTD2iQoGLsYXB/0lJhqyL2knp3k/qnBy+Hf9+3+BobXTtRUz2giBcA26iwqTZKSvLy0p45q89B7sRse3Hrrw36TLDue3NBZ6zXKp4bDh583Hx14ljLeGs1FKe1JyAru8SJEQMWjtQsg7sh1h6UB4fAyc49t7J9KKUenYEgbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999419; c=relaxed/simple;
	bh=DEH8W9Z9XH7Ji/wFQgQwJIkpU/dv55cQDz5MaX6Et88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdSWpD0woFlsgkfjk2WCCXUkIm0i0EsISTSDxQrMaj7HcU5ihUgRY9rNKGHWSDKsbWzeK+JRWyt+1w86NrRBOeQVzGt//8EJ3uyDWCTn7i6/zUo8TOefpbwd7HbUNjjifOqYHqLKI9LX2Yvtk+doJrAxIGWy7cAvZrtDwjaPF4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PS6Wzipg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rhKaVcQx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6BYWI018698
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=69q8ZSiLJN8W0mrIc0XdXqm0+FaF15PBGOBk50XqbUo=; b=
	PS6WzipgV0UI0gm3mAUehYJQ2PHynypgj9AI8+/hkh7kEJgf5v/+h+jEVb1KkVZ+
	JM9nr+nXNIr65jxqXa1AkWCsjLXm+J/0OMgSHAA3K+ftBtRF7jcMPPOIHLg4VyYY
	PfpuKvEH7jH6Orahahvmvz4/v1xAYyrn1x3SDBX7qhUT8MQiZYyMz+CKR7ugRQ3o
	/ZZ/uOnoXNrZ9+kGafQpadvkrAdTFW68yNtWeXjrcWAcF3SBhrNJLTtW+nHW/AqR
	Lyn6Ysv41x0wDXk3PpjSUBjvjf1MZuWSpRkBw7Topb3wMGH93q+ezPT0NFcdEyJf
	mV7waIooS2Dd4IaVzhjlVg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sm94y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ53scu036931
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8578q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAGy8hGQ02/29g0PnQFTW7rSm+9D3K3N7/lGvw5xpZ4xHr1eiqBEaWO9aevX/wkfUzchjzPVB1SRFZJU/wSbu1F/5i8zSvcKQ2f69wLt7WmjQzX/6vYZJ8ri/yYtc7mdHi6VqV4TneoJ5SSm1/HoD2+8kIDWN2A0Z41HaPIROlY23rtPwSL2QuxzIgJsAdkyqPS9yzjwbL8Xy0hgsxqa58WZQXwPzzRSe7bjC342sLe6B8KKnYgXKFkgEvMnxlrsORb0TA+8+fuhyf850eDsOHw7Sb24gKL4Cgtpf9kKUEBNW6ytj2QbhB8vpl0uJHWm3QjpepTZlo9BE7meRMMG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69q8ZSiLJN8W0mrIc0XdXqm0+FaF15PBGOBk50XqbUo=;
 b=Aawo+7TqGfVMr5NIWU2Rnshl4Cu07S3YTcFMSKl8dwHwtiapUL9ypzVt6ZmGR9x/0w3ymTc7Mp9BliKbqEbV7Pe7Tzy6JvjvlbvQs7CEvPM28Q5vlgqoWABPeTATwey7lWDvpNNoWPFdMA+CxlcHsWa1pLXAmYwjOh1jGvrwTftbdkGw8TYk8YlmSzukCVrXofN1M4nXkVJKFO7Aq+6I+NC6qJ+LlvnDkZonI9tY4rSAsT+XNyhFZfzm+9YGxNHFsT37Nro/jhY4/lNVMA2NqOfUSGTny66vFX/NTO12gzSEHR9/NnnDHXykwvTVD2VtBjuMeeTZi4a+5f1vvZ4yIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69q8ZSiLJN8W0mrIc0XdXqm0+FaF15PBGOBk50XqbUo=;
 b=rhKaVcQxJqupAgHlLVWI3I0Bi4hb1G+FGBUCIpTWfVE3ax8GV7bDPZX5zVqbhioLGmptJCDHDGvq3fCUd/dPbbayTcip4/GWovo8nkuLg/y0wDDpp0B185TaJddtE8mYRG4vjUeHpy32nNvq66gjuvjN7HUH56zkfg7RAXTpwEw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:56:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:56:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fix doc build errors correct hyperlink formatting
Date: Tue, 19 Nov 2024 14:56:17 +0800
Message-ID: <824d05053d7eb72add171af60b6de6c4eee457ce.1731998908.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731998908.git.anand.jain@oracle.com>
References: <cover.1731998908.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df9b45c-e7fa-445b-33b3-08dd08675637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYbBeYpcJ7EUVOUpoo9r9BguLtr3buYQRBMsmDYiPD3ScodgVmc7dUqvntJN?=
 =?us-ascii?Q?i32E2fK0sz+qiwr7DAEtHDzVaLfrpkMiDa8VnmXsX3PVGBe65R2ojy4zybgt?=
 =?us-ascii?Q?dtqgxMDscHuBJemxcNy1wh29NQzbaqQT9IfN/nstVQuV4oQH1pkNff3CqZTK?=
 =?us-ascii?Q?2zdET33PzqjegWi4+wEkdXInGitQtRIRVbCvAEsQTZEw3ft2/PRBEnNIru0v?=
 =?us-ascii?Q?ExqojTCL3EnyEtLBMLz7BcPSQwobXFKoK8/n/13B4oCmDG0XClifMXEgaqFt?=
 =?us-ascii?Q?GxM2tuNUsckdrEV3hJOjc0CCKz+SG4quHNPRuoNjOkfpWDbbiAkAmBC0Dv2E?=
 =?us-ascii?Q?jK62rDCMZYumgRqJzTKi7e5xIFincBvkN6+aBGVL4mOwJBf6x9VrmmQ0AOkv?=
 =?us-ascii?Q?NY/UTHf7pek3sWKQzgZGdWl9yhnPiMTKWWYF3WK7o/FO79bADSa9n9HGune7?=
 =?us-ascii?Q?ge17SJaBt8IwwRJb370mWhW/SS8yOyOirtmeQCILf3uXMpIP8qFu7LrnonWQ?=
 =?us-ascii?Q?vuKTEGhpAl5V/UeKmJDKfhtT/HuW8KoAvcUWKFLxXivf5okGzZYuXPHLPBef?=
 =?us-ascii?Q?rdUjxpDok/Ygqj0on1rYYkeKTNsAuK6s5FVQ2bSuWyVpZjELR656xTiyNJRV?=
 =?us-ascii?Q?mr5wyg9t1tWKIL1/3WhJSBOxZpetfctEvzUTJNay0TtuavWNrh7+eapaIXtF?=
 =?us-ascii?Q?urBITRtkWA2UbtCC4qRMpbBVZS3DwW1MYMVaiYzuVLd8lNZbXwxEwCNNa+qc?=
 =?us-ascii?Q?2HfsYdMqlyLLo6DeH5mQy8xLo/kBZU4heR6TV/P1DZys+yLcDoxZ0pocaRgg?=
 =?us-ascii?Q?T4/1O1ImQ7sXj/Kd4KFIxxYX5QLA9Nu1HLGANnEHvZ65idg5F7L1Cd7I6N+V?=
 =?us-ascii?Q?0OczTk7bLkEndz05vTMm/uQBcW/8AdgvF8srLpKencuSrlj8DqlM27aiqwEV?=
 =?us-ascii?Q?Gml7nAhQzQRCwrRHbyXWTTRRFEC2J6O8nWrDfQmlo4dSN0FB5OfSQI/0jRIc?=
 =?us-ascii?Q?hP1WkovUh13KaPgwRh4bvXMu3quuAlUFs5sEnTYypyJsuieKzuUehy3hSAjd?=
 =?us-ascii?Q?hPKh7s6JAnOq6EqPUYSD79Ono2BN+hjXCTF0thWVhhJq9hdnHEnyeib6U1Yt?=
 =?us-ascii?Q?cXEw0soIYKG9bvwpZJ511S/EX15yYUSMPg16Dw4ERrx8pYleYydVx9EqIK/S?=
 =?us-ascii?Q?KbyWK/7Bos9eggGvxIpoS8EgdlEtPzwU8Y5jvjUxxngS4avCvLsfs9PZUa4L?=
 =?us-ascii?Q?QzIDmd8C47wOFKLZV1mpkLYkQ/buy+B+QSj9sZkakdyV7+LgZ+sYupKNvio4?=
 =?us-ascii?Q?jyge6fevQTKL9SbRo8pyBr4Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTR5CrgDYK/D2/TfoN6rmWmbXCYWHOZo8Q/EOVUVRE1EuqQRQhxX1wxh8S2B?=
 =?us-ascii?Q?0dPVX9xGrzV8S9M/K7FqX0Qv6rRJcCiodiavHNvA5kH8xjRErDVpfoQ/O2fu?=
 =?us-ascii?Q?z/Y4rDQYXPcNb67Xa95P9xriHceb+5QatsGP60ywId4ZReFgMhTZMxbsaTn3?=
 =?us-ascii?Q?HwUBWbMJ9a02m/+91GsHlQefr4DcF0jAgY5V1ivBnHXtfV9UYO8asuj9anpb?=
 =?us-ascii?Q?ZoJPz3KTO6s9rHAacOQlDFrlychYGlZrKvJ8aQgWRzJcTgkOdF7iv9cWOAp9?=
 =?us-ascii?Q?fkeRyHgFc1NGPeFyFygZ06QHfShpMojrfgj3Qhf2UiblCs4h8oEmIQrJEbeW?=
 =?us-ascii?Q?2U1BDpl7Jd8EbcFlEGJZp8JXj7n5iEektx2HZIT0ngPXE/IfCMh3UvnKmtwY?=
 =?us-ascii?Q?2q9CMgYYVBYFrPPZgigHQRSp4qV4HYSeuOsTNiZRB7oxVXaB3CgQv5xRXi3a?=
 =?us-ascii?Q?4KGtQvJCKAa30W+TPXcwISS1OxUsEFbp5hHiQBrDs0zupDrrPohCQvfXGdgw?=
 =?us-ascii?Q?KhlWYTSbN+zdTwfGLDxiHA2+YGnRsjYjBeuekydxUctkCKWz/DAYUir7ACyV?=
 =?us-ascii?Q?znnNNTi5EWpwXBXj3JaKkEuXbOkhm0s+ILO4WLEX5tFhz6bOX5FHDhNZb4Rz?=
 =?us-ascii?Q?k7OysWSQvuhYyykxgqVLYr9JSmwB5DX3aOkPVnrKiH08Pjr31DtuER+W1UzU?=
 =?us-ascii?Q?qKxiCrk82Yrw2wrQC+yRxD5VMRsVBa4dbdcexpD8qOo4zzbF23IyC152O/MW?=
 =?us-ascii?Q?9Bsrv6u7N73aFD3xD0MlXz22NtL2DmNPk+QTXMPMDBXmKNCdL2IlkFFyb2c9?=
 =?us-ascii?Q?tPWJNbS6vHimnnPZwr2+NQnzLmvT+BU2YYdC8ffE/6Oic/GlP0CsArW4/LK5?=
 =?us-ascii?Q?641bxtC8pO7zxS4a6Zzsp/eKR78K8VDx0e6IcpR+d0YtQjX5xvaOLoXWh8kT?=
 =?us-ascii?Q?op8RwvZol6ytJzuAnbALZR1jSBgBJKBnMO7FPyuEp+ZsVEkE/iU6XWuviyXF?=
 =?us-ascii?Q?vkQLRMwgBu/rarO8KTalIznyhH7e9S2buSjCOdKntn0FFP+IeL+xdIEiqsAD?=
 =?us-ascii?Q?78WmpssmTSu7u0oeSx/e6l25X6uF2k3Q/7U5c2soNC0HzNPNzbMwKj5/ZFEP?=
 =?us-ascii?Q?hpcj6u6QFii1xEeewRm0EHtfzrJ8Eq4nIMNVfIeh086TtUIkfEu5CYgti1Ji?=
 =?us-ascii?Q?ljUvUpC1MCDreNADMvWcA3LAEYIfo2O+aPAoRzY1+mka5UqMmCg2et+oS5a0?=
 =?us-ascii?Q?EVTCQB1wfUYhn0jHEPmkbvd6cM7/+2AkJQ9g6Nv0aFqlvx1KQXsbCjXoqHYu?=
 =?us-ascii?Q?ftuG6lMlmiimN6al3HbalxKTZNQRQN5p8lRmWzrhdGDkZaLAb2XaSCNg4tyF?=
 =?us-ascii?Q?W0NItqtGepVvuoHuD1QJCF/RLk9c8TQuSXb/Q8vrpRFFhGoYsU6tVW7pZTFi?=
 =?us-ascii?Q?UlZdQ1URzSUDkT9ctsu3TymcPD8REkz2ZDpm3eDHFQvVIXrvc0/qe4CyZWJh?=
 =?us-ascii?Q?/Dt+R4HRFc16NftYTGKEwIsU6PK4JIl+YmnrRtnihb/vG6WxHyWehnuO4IPD?=
 =?us-ascii?Q?0sLA2Nm/evCkNhXgZdDTYB0rp7Aa7cRQf2eujQQY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qNldX8MyEDVokTpkO9I2fXXKYx0tHuBNMVTwV50NQHXoK8Idl2Qcuk/htRck/K7geUF6B/EXDCO6J/thRi++mCZ4VpaYFFF6RoQEFwig9EoE1G4ktsGavpXcO6cbilK3+QJZd7tpjY/eULtT1ohbm6cRCITAa4a3/j2lbStlmzTsgeMiqvf14aibT7CjHBTDpxpJCHvFtJlSlJgPOs43m/F3RKyyLh2DlgXHniPhgC94NDb7Nt5ngWgEtPy3EDwVouZf/GkvkWmy3rHUMY5qibRQZRKXMUECM+n1rmqqZGlOgNWXAyE8XDwz8n7das2QsmP2pcN5X3X0tHigth1jyvyW+gEDUg6rz9usqZ4ZNkaz9k9ahgUv92FCARWr2sZgnKR08suYcC8kODWxfZ7lIJVvb9D11Fpabo9FM7QA+AdW9L7E+t6eHXgQcMB+y6dVWuA27QxDD5ovs9QcpZbObATcPL2FQAwK4c/PRYCt1XppDAylB+CPapKeifayZOJMUvXgZu5YqqE1rchTtBJjeQJkXJ7QZKkYRS5TKwCz7W16ldy4spi30C0niO89/Fe4J0mtZoPaAHcrZ4YEN8ztkQv7HBLVvwMLU4P0Wsi81Ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df9b45c-e7fa-445b-33b3-08dd08675637
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:56:47.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOP4h6H4JszIlHZ6Neca1DBdSw9DGihxRyohLXCmkPVAFPIFCMtL6/n80OmMQXsfnRUVexsBk0LRxSEY8M4gVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190051
X-Proofpoint-ORIG-GUID: 6aTHpRSTjAi6-nLZJLcHxyT5oV5qgnHy
X-Proofpoint-GUID: 6aTHpRSTjAi6-nLZJLcHxyT5oV5qgnHy

Making all in Documentation
    [SPHINX] man
Documentation/Kernel-by-version.rst:: ERROR: Anonymous hyperlink mismatch: 10 references but 0 targets.
See "backrefs" attribute for IDs.
    [PY]     libbtrfsutil

The build is complaining about the missing space after (2) and
<https:...>, as shown in the example below:

  v6.10-rc3 (2)<https://git.kernel.org/linus/07978330e63456a75a6d5c1c5053de24bdc9d16f>__,

The compiler interprets this as a backref attribute. Add a space to make
it render as text.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/Kernel-by-version.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/Kernel-by-version.rst b/Documentation/Kernel-by-version.rst
index d1adc3ee6ebf..1066a8a22afd 100644
--- a/Documentation/Kernel-by-version.rst
+++ b/Documentation/Kernel-by-version.rst
@@ -558,8 +558,8 @@ Fixes:
 ^^^^^^^^^^^^^^
 
 Pull requests:
-`v6.9-rc1 (1)<https://git.kernel.org/linus/43a7548e28a6df12a6170421d9d016c576010baa>`__,
-`v6.9-rc1 (2)<https://git.kernel.org/linus/7b65c810a1198b91ed6bdc49ddb470978affd122>`__,
+`v6.9-rc1 (1) <https://git.kernel.org/linus/43a7548e28a6df12a6170421d9d016c576010baa>`__,
+`v6.9-rc1 (2) <https://git.kernel.org/linus/7b65c810a1198b91ed6bdc49ddb470978affd122>`__,
 `v6.9-rc2 <https://git.kernel.org/linus/400dd456bda8be0b566f2690c51609ea02f85766>`__,
 `v6.9-rc3 <https://git.kernel.org/linus/20cb38a7af88dc40095da7c2c9094da3873fea23>`__,
 `v6.9-rc5 <https://git.kernel.org/linus/8cd26fd90c1ad7acdcfb9f69ca99d13aa7b24561>`__,
@@ -596,14 +596,14 @@ Other notable changes:
 ^^^^^^^^^^^^^^^
 
 Pull requests:
-`v6.10-rc1 (1)<https://git.kernel.org/linus/a3d1f54d7aa4c3be2c6a10768d4ffa1dcb620da9>`__,
-`v6.10-rc1 (2)<https://git.kernel.org/linus/02c438bbfffeabf8c958108f9cf88cdb1a11a323>`__,
-`v6.10-rc3 (1)<https://git.kernel.org/linus/19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4>`__,
-`v6.10-rc3 (2)<https://git.kernel.org/linus/07978330e63456a75a6d5c1c5053de24bdc9d16f>`__,
+`v6.10-rc1 (1) <https://git.kernel.org/linus/a3d1f54d7aa4c3be2c6a10768d4ffa1dcb620da9>`__,
+`v6.10-rc1 (2) <https://git.kernel.org/linus/02c438bbfffeabf8c958108f9cf88cdb1a11a323>`__,
+`v6.10-rc3 (1) <https://git.kernel.org/linus/19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4>`__,
+`v6.10-rc3 (2) <https://git.kernel.org/linus/07978330e63456a75a6d5c1c5053de24bdc9d16f>`__,
 `v6.10-rc5 <https://git.kernel.org/linus/50736169ecc8387247fe6a00932852ce7b057083>`__,
 `v6.10-rc6 <https://git.kernel.org/linus/66e55ff12e7391549c4a85a7a96471dcf891cb03>`__,
-`v6.10-rc7 (1)<https://git.kernel.org/linus/cfbc0ffea88c764d23f69efe6ecb74918e0f588e>`__,
-`v6.10-rc7 (2)<https://git.kernel.org/linus/661e504db04c6b7278737ee3a9116738536b4ed4>`__,
+`v6.10-rc7 (1) <https://git.kernel.org/linus/cfbc0ffea88c764d23f69efe6ecb74918e0f588e>`__,
+`v6.10-rc7 (2) <https://git.kernel.org/linus/661e504db04c6b7278737ee3a9116738536b4ed4>`__,
 `v6.10-rc8 <https://git.kernel.org/linus/975f3b6da18020f1c8a7667ccb08fa542928ec03>`__,
 
 Performance improvements:
@@ -632,8 +632,8 @@ Notable fixes or changes:
 ^^^^^^^^^^^^^^^
 
 Pull requests:
-`v6.11-rc1 (1)<https://git.kernel.org/linus/a1b547f0f217cfb06af7eb4ce8488b02d83a0370>`__,
-`v6.11-rc1 (2)<https://git.kernel.org/linus/53a5182c8a6805d3096336709ba5790d16f8c369>`__,
+`v6.11-rc1 (1) <https://git.kernel.org/linus/a1b547f0f217cfb06af7eb4ce8488b02d83a0370>`__,
+`v6.11-rc1 (2) <https://git.kernel.org/linus/53a5182c8a6805d3096336709ba5790d16f8c369>`__,
 `v6.11-rc2 <https://git.kernel.org/linus/e4fc196f5ba36eb7b9758cf2c73df49a44199895>`__,
 `v6.11-rc3 <https://git.kernel.org/linus/6a0e38264012809afa24113ee2162dc07f4ed22b>`__,
 `v6.11-rc4 <https://git.kernel.org/linus/1fb918967b56df3262ee984175816f0acb310501>`__,
-- 
2.47.0


