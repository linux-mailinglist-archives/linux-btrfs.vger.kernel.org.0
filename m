Return-Path: <linux-btrfs+bounces-4759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BAC8BC60E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0256E1C20FFC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D040855;
	Mon,  6 May 2024 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLPSxWDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ppk9Atj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30242062
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964744; cv=fail; b=sOAigPHMOZ7+JGxNhAuiGTk9SDXIc4wWqBF6RsuIOGRzBwLTBwixf/wUcsVrRMb48QH8kXYELFRq8vh5Tpxc/tlpKbukKpSMuHhUoGktwMB5DWvoJrdU0HxHJjH23cOVoDpLLEFnryW2pD0EN6XIVmCxOCR+WTZKl8ECLzAtySY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964744; c=relaxed/simple;
	bh=81C0yVN3owSj2j2+4jp3yCX8lydduas7Pf+hiEjsC4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGpN+MUANayv5d70J49zAm+lr118/QTUbbatjuM9PnOyIqj5HaMQw5tEM2VJGm3P6/NmnxJTJOcgRCluI2Jw8JsyajIOHTBCMWt1no/wOzNj6S2Xqg1m8DlHNd7hNoDLLz15HGZxVC9GKXptcqwqQBjwj7X53LgbxS5GbXPOycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLPSxWDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ppk9Atj1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445Lodou024928;
	Mon, 6 May 2024 03:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=XYU6epzK/+e2/0ZvEgcGGAzysaGDB1hLcOvc+k4kCtQ=;
 b=jLPSxWDUIB5BmhaUg7QU9EI8+DJsgzAj2mECIGbudVZ/FTBf899J5+24aRlyM+yJTMxg
 4J2KMovqAin/GKISdMpotKgriNDZvWssCT3NZyhuZdK1eLZbEIzJ8JFelJTj1iXF/UDS
 4X8oBTTfLQpMTBvPs2/nKbwBZr135T81l0ezUsustAiWw+ouKw15k4Yp04BCffGuKeav
 iBy0yDNJTRCJId8ucFcHn6C9FIxYEx1P7pj81bbKgv+JWaVXRLWNki6dK34+bAbeuA0A
 u4X9QT+0GugBJqSthXeRBlVriHLx/VabCgtrwlPCveGEXcuO8+EPdRkpMy8NzRotuB4u mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcsqw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4461MUl7006964;
	Mon, 6 May 2024 03:05:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf61xw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e96moF7Po9Zn7g2O29dhJCR3vI1idtxThJwJF4+0bBp55/utd9e9419HUQhllvjy7b+dbusUJr0C3yLsPTf2K0EbeR+Z87mx57AWORkCrqtgCwaRb2/clQ+9hAd5ofkCsbheBBAvfwnJNVrqWqigvWIcK6+aFFA/SUKgkJuGu7izF2EjbuirJj40AsmJ0dl9A5x2+xJD/+u2Z37/yemBhJzPkE0S0g5XefJIW5W47XhDam8TU27Gvui3sFzu8d6/o+iYX4vAXJlwMdDX0uf+Omdphi50f3re8suOfy4HrdSzJn9OGsYlLnqRGnHinFBRbNh0ADvJ4CSrWn/zPBo9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYU6epzK/+e2/0ZvEgcGGAzysaGDB1hLcOvc+k4kCtQ=;
 b=l6QXLJ8TsxGtS1+mIq7wApyqEsEL6rjOwuIUKg2jd5F5kMAMfrgIkYy3Fapo7dypCWLHaKER0Q458D03Vw33YIcvo9akO0D3gLOUVIEhOePKCna0X+6VrQ8XWDSZvHptFucPB52GTvzjPOnNwie5+Zy72LtPMf/JEhrPwQh24JeT1ZSI9qDFwONYzoMzEWS9oe0IeCAdIb2Cyly0Y2V5aswLXX49S8lYOg3EU8UBMsof+hlE8lX60DX1sXvBCRGRGlNcjUJZFlRJEYkFmTRqxZNi6Oj9VWGfUz2EJ+4j604tplQIUScT4ioYucEwxqalkio8MiW9y9e3K46CLwYTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYU6epzK/+e2/0ZvEgcGGAzysaGDB1hLcOvc+k4kCtQ=;
 b=Ppk9Atj1KRTfwtvVQ2ub8/eTVqhZdwF+jXYnFUVBy5dWjcpWVp4U2AjNCY85xlj2QN8elqeqtFZr7+BtqGTz1MRK4f2xyn5CUcTT/xxwg+VM9+/wll1fBh2bSIrs+EQ7rdVFuHx3omV/4nHug8GgQFqIOtcrFoYYgANOJg90qh0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 03:05:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:05:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
Subject: [PATCH v2 3/4] btrfs-progs: convert: refactor __btrfs_record_file_extent to add a prealloc flag
Date: Mon,  6 May 2024 11:04:57 +0800
Message-ID: <3953c91e40178273e0896b544e0a7bf9f219deb0.1714963428.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714963428.git.anand.jain@oracle.com>
References: <cover.1714963428.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 23235a7b-6a48-4a89-433f-08dc6d79666d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wycVZ+f7nCS4NfEGtJTlYS31AT/KW9+HVsTdz6FOJ2F81pYBwjTsA6oQbiKj?=
 =?us-ascii?Q?kKoIVKgxnGqxT0WPHQAr5TqXI7yBzCUPhoPbQhtECOhHVNT/g0Zahgyzgxv4?=
 =?us-ascii?Q?DeshoAC4MUtftltSB1szsKJ9clY2zxifGZCyWAeWAimEEO0V6+kivlI8qte1?=
 =?us-ascii?Q?KWvax7OcKz5nWrts4PQXZYlE7DSfgJsrUy9B+2huR281pXjAUlSE0V3Ao81v?=
 =?us-ascii?Q?YGkIlOUNLB8K0t2o5sMMCirXBsxFvQ1MGtIyEfCNmrR0jrv6KD48J6uO3+t3?=
 =?us-ascii?Q?GRoOIRHZ6HkQgzL7O5kaydVTH9Xa9gUxJB0x0gGAvFGTVqETrx0DcBwIXSFt?=
 =?us-ascii?Q?wJ7tO8BSVhaIuYVS6adulfSjv/7uc2xxrjj7eyrR4m3c+jBpzAQVP0H4Tgm9?=
 =?us-ascii?Q?efX3ErM1b9m+jj2aOKjLNgemq3ds94JwcwnFs/dKgkUUz08x+yU7Py8NN3W5?=
 =?us-ascii?Q?kdlHkVxLTfWouY7Ipb55pXwnOeqlarOHZyPftTWkRAfXASekk7QWyqhqCNMN?=
 =?us-ascii?Q?HfcIOAgqWfQ7x9shRD9exEv8bN3dhB7vFtaDFJnr3JgEobz01RcjClvDhsg1?=
 =?us-ascii?Q?qdUd3ovzV6rGOH3QptAVm9KjOQheGHk1e4SUf7i1MyGDE2iNj2PSJ/G9esdU?=
 =?us-ascii?Q?AV9Kb4PgVZg4h2BbyCuKh8oIlQNU6QLXJI3onXEZjaQfqw9hqbxpi377zXcV?=
 =?us-ascii?Q?yGpXXaMiJtaibhAR8Fc9byNxvkWvwtbxJyi5+GQEMctERPp0pDFCNFx+oIaG?=
 =?us-ascii?Q?aZhxF1cEVSdASqAnXLpDmjunPo64Ynj06YcHxHXcO/1cznFQcsPHHfyGB3oQ?=
 =?us-ascii?Q?jYL2PlZJlKtrCsNO6aDyw/2qPB7xgOlIoLcndJa+bESzCCmCHlBvYXmZWUlq?=
 =?us-ascii?Q?d6DKP+d2mzbpiG8iwenpOAG2nt4NJLgIIjZBtKqn0evLft7AqtA1QLKXEqBm?=
 =?us-ascii?Q?j+s5MUG50i9WwFcza/0wNSyePJMQx81j5900/Yeyz0ZgNbpAjxCtREhyQxT2?=
 =?us-ascii?Q?fI1/E9Ph7Faatd4ApCWs5HUSQP4zRVr4G4fOpApFdxX1aLIafOcI+mW2uk+J?=
 =?us-ascii?Q?gUAiKOATVOYZi9cV+WAYU9cQhJeBypw8l1gLyaqENNb7U79JwzZijNWdngpP?=
 =?us-ascii?Q?nernFct4E/lh9NVQ52JjLcxpzREHZ+D6b6cZ7CCFtNMpo1zx/N/CdLgjwLSU?=
 =?us-ascii?Q?baXFrD1YkhJBh6X0l0WhSBD3L3TfhSqlLKcPq43kyGZJB5cHxYWELlVPhGwl?=
 =?us-ascii?Q?r4dXvkuHrDVuWpWnnmmXcBX98+ATDqrP4sa8y6SSBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i/i1VLtqTGSXqlKVaK67wuUd8zaGhuWQ9ZSr3DMV0/RnxDZXotsXrSs4q9ne?=
 =?us-ascii?Q?OeeaxZEea+/gS30ngBoAiWeoZwO/7bWCuQ/sK0tJOoNOfK9gqKGAD/mmLBAl?=
 =?us-ascii?Q?LjrQFwJbnrPavwjmYuJ2x0PM7ONQyX84eUj/ZotESEbn4OMuzWbPZq78ixO3?=
 =?us-ascii?Q?FJ16SAg4nTMgnsY/2nZNYbXIONgYRAU482HGz0FJhntLoi8Ickn4tjHD/696?=
 =?us-ascii?Q?QMb3hgFpfE9hYCTdceGT5tRSN/3lz8Z15ZeNWK4PkOmrYYnuqMeuMMXIY1T8?=
 =?us-ascii?Q?fj+e37Dr7kbOfAQrYS6VifxZlVK6+4hzVCtXv9gqaqKdQhysayZeqVVe3YOK?=
 =?us-ascii?Q?mTbNPl+Z5r+GlopLrJgIVepXcsoCS5MNmwLKBZi3bSrWp/9CwfBzNV7XjaHH?=
 =?us-ascii?Q?cebKAaPO7V05XQJF1chxbTdFbWg6q5OKofatffBO6yM+Yb+b5Pxe28T2zL2Z?=
 =?us-ascii?Q?cjbZqBkyafXnIwfPvsNEcxUpZYVUDsUJsPQFnbvzYgT7jeBZ69hVqRoO1hDm?=
 =?us-ascii?Q?80SwNjzE2FN2fYhUfJVvCLIloKs0LVK5XSZFjCZx4i4hQRxiJJxgZZVXbiAA?=
 =?us-ascii?Q?UwhgnKYbyyPUqLTLa3IMzlOvZ5oN1RgC0qn5NPfKDmUybLnJT+4oZbdFuHMn?=
 =?us-ascii?Q?5n8ofE4MNbXM9oeYAoUpYG1KOSy76WoT5O4rNwR2BaVZh4cKmmkfOZiFL0JQ?=
 =?us-ascii?Q?GwJn8+YoxAm8Dg9m+BciOW83UgHYb5Qi98RN92tMKcaQLSxy1EXDkHSxMAFX?=
 =?us-ascii?Q?4vFvok8S0ToJb3D2lcsv1mvc/iUPDiEjXkTucNKyjzUx6SgUASiEl4zokGt5?=
 =?us-ascii?Q?k987mhkFzHEMzHaCYrkM0IGw3sfrDdfRHwqLn6jTXMwV5LUV8WuMMDHVpXgJ?=
 =?us-ascii?Q?tvqo/WXFsS3nCoGqUkX1MjG3iez46Ja2MMOa4Sxk202QBIlgy10gGxs6jOlK?=
 =?us-ascii?Q?ZbWsMiOFUg/Vg8ijnpF37piohfYG0us8kqqv1KUfP7nrB6Chy28a24JRRRQX?=
 =?us-ascii?Q?umba7ZhxFp0TUC4OApiLykyVzwTucOl37I+my5iYbkcMlxj1vS7u4h41TwDX?=
 =?us-ascii?Q?4O0ybdY/c7+mugJotNnfUqwv0eZCl5n7WoRBxD1TPW6UQi9ePd1yTr8j7IWG?=
 =?us-ascii?Q?elexbRbGPZuPFFxiXYTRivw8WAOykv1WLMQceL60KOC9sQ1ecm46VNe/WnW5?=
 =?us-ascii?Q?/wbhNpmyDE/Jt/Z16CClGh5DiJB54RSexiFmYfgO42pcXdVioa1OIHV+hlEz?=
 =?us-ascii?Q?VLCSW5KXdRIFDC8EGb9FQWqmG8KbbEQJitaDEGK77V2p70O+GugjtDi54UPM?=
 =?us-ascii?Q?0mWUhyKBk9yBfhLI8z+A5yJHqWmvVmW6UvR2xcKpCiwVWbqbOnfJsn4J0KwF?=
 =?us-ascii?Q?ud7LMU5JJc+mH3d9NzuV/o6ZNNaK8DCM+hF3ClSTD0G4wRxoeIVYeIIk7l4A?=
 =?us-ascii?Q?Lk34hqorNavFVuv15AAJywNEVGNs1df5Losh37HfhReehEUoyhlfmGO6aBAT?=
 =?us-ascii?Q?DTmXw68ltEfR/BXHGDNR6lJ+Ac0DXBvDV8kBRAhrJD3XvPLmCm12Xaq5gdBe?=
 =?us-ascii?Q?118xBxKMZ1bo+6i7p8RgbHve7et2EC5O52CcoR/kZO/rqWd5EBZ6L0fiL/7k?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	10y1BtwX/Gfbh7U9ySupkI3vVl5rpvR20qgw5PaueC/3mFAA+cou+INqlHoGzIjNSMR9TzhRlshx6AfUxRNT8wbT0U/SyO5Yau6pXDeHQZd0eZRSks8+BWZDsKa67O4ml5nOnRIqQVwrisexsz/pLB6KMJsdc0B0Gz4HT8U2L5b5v0S+rZuY+q6R0ok8dFOgZuk3D+p1av1Fj8OEPPU4izetgB5pk0xapQHETyk+LrXXUeDyfP/NZzwLYGVmhnYMMl+N8F9Qw4ER9MKeEf21ecs8fUKICORDn7hR4a+ZUcV4qlNQtKDhTvRl8hoTciBblLdHIjc9/suj7HsVDqqsqy59TvCtukvSBZBFXSjt0rQL6bLs9xjOj1BcoEve9bXy6zMS/HXtvp7fm17jgyuf8x7yyy4H/JYQbXd4fDFZERf1jnmWPQWUkOmqEzFTFJFRHOoyDZ4Ayudbx6BHX+PcCBylrr3GnuFKf8FBTJLxtEea/UgqnV526iDR7HuSOGdfzA5MWFotFUFitHn0g21nHayHmmHKRZY6bLbANrdt3BMfyEbb+TD0V97YP3chvWoJDedaR7IlWBhrZW5oSe8dOPNX0Iy24BzrU0TsngDYTNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23235a7b-6a48-4a89-433f-08dc6d79666d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:05:35.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYh5yn2XjFvOcdkMVgkEPrcq/nQUWqoEBw/pqzIiiaeg1BpNDzc0HgE+g4fOu/5S+YRG+HLAy5CPjbbHzJ23rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060014
X-Proofpoint-GUID: M5upc7lTFDpGKXK3DxwZz3fsVtDgfabU
X-Proofpoint-ORIG-GUID: M5upc7lTFDpGKXK3DxwZz3fsVtDgfabU

This preparatory patch adds an argument '%prealloc' to the function
__btrfs_record_file_extent(), to be used in the following patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: pass btrfs_record_file_extent() actual flags instead of has_prealloc boolean.

 common/extent-tree-utils.c |  8 ++++----
 common/extent-tree-utils.h |  2 +-
 convert/main.c             | 10 ++++++----
 convert/source-fs.c        |  5 +++--
 convert/source-reiserfs.c  |  2 +-
 mkfs/rootdir.c             |  3 ++-
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
index 34c7e5095160..53c10734408d 100644
--- a/common/extent-tree-utils.c
+++ b/common/extent-tree-utils.c
@@ -122,7 +122,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *root, u64 objectid,
 				      struct btrfs_inode_item *inode,
 				      u64 file_pos, u64 disk_bytenr,
-				      u64 *ret_num_bytes)
+				      u64 *ret_num_bytes, u64 flags)
 {
 	int ret;
 	struct btrfs_fs_info *info = root->fs_info;
@@ -229,7 +229,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_file_extent_type(leaf, fi, flags);
 	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
 	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
 	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
@@ -265,7 +265,7 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid,
 			     struct btrfs_inode_item *inode,
 			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes)
+			     u64 num_bytes, u64 flags)
 {
 	u64 cur_disk_bytenr = disk_bytenr;
 	u64 cur_file_pos = file_pos;
@@ -276,7 +276,7 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 		ret = __btrfs_record_file_extent(trans, root, objectid,
 						 inode, cur_file_pos,
 						 cur_disk_bytenr,
-						 &cur_num_bytes);
+						 &cur_num_bytes, flags);
 		if (ret < 0)
 			break;
 		cur_disk_bytenr += cur_num_bytes;
diff --git a/common/extent-tree-utils.h b/common/extent-tree-utils.h
index f03d9c438375..dce48c43faf5 100644
--- a/common/extent-tree-utils.h
+++ b/common/extent-tree-utils.h
@@ -31,6 +31,6 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid,
 			     struct btrfs_inode_item *inode,
 			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes);
+			     u64 num_bytes, u64 flags);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index f18fab4a236c..fb0f97d949d4 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -337,7 +337,7 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 	}
 	ret = btrfs_record_file_extent(trans, root, ino, inode, bytenr,
-				       disk_bytenr, len);
+				       disk_bytenr, len, BTRFS_FILE_EXTENT_REG);
 	if (ret < 0)
 		return ret;
 
@@ -426,7 +426,8 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 
 		/* Now handle extent item and file extent things */
 		ret = btrfs_record_file_extent(trans, root, ino, inode, cur_off,
-					       key.objectid, key.offset);
+					       key.objectid, key.offset,
+					       BTRFS_FILE_EXTENT_REG);
 		if (ret < 0)
 			break;
 		/* Finally, insert csum items */
@@ -438,7 +439,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 		hole_len = cur_off - hole_start;
 		if (hole_len) {
 			ret = btrfs_record_file_extent(trans, root, ino, inode,
-					hole_start, 0, hole_len);
+					hole_start, 0, hole_len, BTRFS_FILE_EXTENT_REG);
 			if (ret < 0)
 				break;
 		}
@@ -455,7 +456,8 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 	 */
 	if (range_end(range) - hole_start > 0)
 		ret = btrfs_record_file_extent(trans, root, ino, inode,
-				hole_start, 0, range_end(range) - hole_start);
+				hole_start, 0, range_end(range) - hole_start,
+				BTRFS_FILE_EXTENT_REG);
 	return ret;
 }
 
diff --git a/convert/source-fs.c b/convert/source-fs.c
index 66561438866e..df5ce66caf7f 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -262,7 +262,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 	if (old_disk_bytenr == 0)
 		return btrfs_record_file_extent(data->trans, root,
 				data->objectid, data->inode, file_pos, 0,
-				num_bytes);
+				num_bytes, BTRFS_FILE_EXTENT_REG);
 
 	/*
 	 * Search real disk bytenr from convert root
@@ -316,7 +316,8 @@ int record_file_blocks(struct blk_iterate_data *data,
 			      old_disk_bytenr + num_bytes) - cur_off;
 		ret = btrfs_record_file_extent(data->trans, data->root,
 					data->objectid, data->inode, file_pos,
-					real_disk_bytenr, cur_len);
+					real_disk_bytenr, cur_len,
+					BTRFS_FILE_EXTENT_REG);
 		if (ret < 0)
 			break;
 		cur_off += cur_len;
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3edc72ed08a5..746892ff0a8d 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -365,7 +365,7 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 		return ret;
 
 	return btrfs_record_file_extent(trans, root, objectid, inode, offset,
-					key.objectid, sectorsize);
+					key.objectid, sectorsize, BTRFS_FILE_EXTENT_REG);
 }
 
 static int reiserfs_convert_tail(struct btrfs_trans_handle *trans,
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 4ae9f435a7b7..cb6659319b7d 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -411,7 +411,8 @@ again:
 
 	if (bytes_read) {
 		ret = btrfs_record_file_extent(trans, root, objectid,
-				btrfs_inode, file_pos, first_block, cur_bytes);
+				btrfs_inode, file_pos, first_block, cur_bytes,
+				false);
 		if (ret)
 			goto end;
 
-- 
2.39.3


