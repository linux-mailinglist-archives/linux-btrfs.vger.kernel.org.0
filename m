Return-Path: <linux-btrfs+bounces-5032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE18C70DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 06:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135331F2400A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4029D512;
	Thu, 16 May 2024 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vf9vCajv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r/8/6sic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E37B667
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833187; cv=fail; b=WwZjqHAJLFBl0tAW4bhTnP1oCkidJconaCKG4o/SkUU/M/JIgol3rgZ9gF7RftogbDpUFfmLiV19LZ+s50HFfskmnqnMwaZ1owV88aUyn5F7P7H4DNfIIY61q0hD3rkVa6Nt+E2wXnFPTWLUVbuN6Gw1nGSK6XR7VRZoIfgAbH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833187; c=relaxed/simple;
	bh=qp4LXOYhxlT3cHLrf+Ag1FQ3aIuzz0AL46I0hWmUITY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PjJmx24tGHsRcejHcz9BrJNHIEGEfqsqj93nx/HLpMV+uz6EdE70OAAAMk6nxryua90sfu0wfmrWHjoY0DHChR+U2tGpLdv8m/yyHi7kzODBZfXIVQoJ2eJ4txirs6npdFlTZPaPHV89wFFHe6ZfkiZY7t6PQUh0WQpwZvQ09LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vf9vCajv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r/8/6sic; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FL0qgh016062
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=tX0FiAXF0WXd6ZLEb3Xpmbf7YLOSzBq7FhXlRo9I6+c=;
 b=Vf9vCajv9BTMwM5nu2aqkRb7F5leHOSP4dapBbZu0HfC7T7xnjeEjbfFHZIm9oXyrFEs
 8ivt0G9cz9zBsYiimSAErVv9kHdpLxNKI1clIy+4++zy9KISEUVUFQ3nHn6mPKs/O1ft
 MX0ZoroMU9bN8j1iyLsgMH/NLdzBFrD0yMXXvOJhsjUqfLv6cYptJG5nlMy8fRpq9nVk
 aLUNNQL76I0HmUXO29dYGG0435TV9Uf1ucZZd/7eJ8aDlZJBVEKIhT/eeHD7g22cnf4Z
 psPkc/pC4e0hQM5QwGTH9uiM2qDtTk4xqjaU55/av2s7ZHQUmfyIQoUPCECz/6+nvM0V Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc4hgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:19:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44G1B1Jo019282
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:19:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r877mew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWpJixYu4HvZqo4GYInj0I/tFWkLnYrn7Ms1WOnP2HtRBC+2XDnMKoYUTdkg2W3vUq95oaKDzgGrbXIj4wcRQsISYzrtyfLGiJqQc1YE+33gs0RcQIPjf5QPZuvzKZLjunpLbYriVTms+mf+67/DuEqco8OQBhK8QVrSEUTYiqyYYbdA1saiKW6KGKBzr3cuxLinZHP7hnxgxou98l7c1QoHBgtTj3GEFBWJvvCWAMRxc1bY3Biwhkalamlhy2lWDs8bqunPWM0fiGlRc1SpOPh3KZuFNUVYyWn4fJ9pRZMeQ4UwjRFGB2+wj9c9TsVuoRzyBrwj9Gd6S5h7dpmE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX0FiAXF0WXd6ZLEb3Xpmbf7YLOSzBq7FhXlRo9I6+c=;
 b=AkWrjJNGCImk6rhMZ2pVKbvjoj+OCOyPaDbePegxK/3GFTM6e6lR3/RKpDmcDikXUwZdvEnCyhkeFWQH+cqOJHtYpdHEf/vxf5tffN2RJNo0IuGG7y4DTMF0hWUT9f1VtFNSR+gfalGkm0S5wb9SliITG7OAnIVYgoKbdtXMtdK3oLZcDCQ+bBIZeOoFaYra1j/p5aV1J4t2OpBg7cVn+zDrKPPNhCbKX80RQzqfr44h/Foy9X1ogjGD0P3oknpqD0oX24qQSX0TfDa8NQ5SKiHYVCbf1RYr9U3OfWzDSgBcV0gC87Izwr10yAoUYt1l0jY/cTylUIALzKL33YmjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX0FiAXF0WXd6ZLEb3Xpmbf7YLOSzBq7FhXlRo9I6+c=;
 b=r/8/6sicqX3wayilJKGBLuWsfXKuboVSJ6VRT5YPhbdmY/lgjs8gzRwqieGX3RHYYr3O0dQjs2juWSVaZGbLZjf0k3qqDW0aPaIvJM2ZrOqqkkvK9MEQw0/Nng3iZq8VnIAT/o906cPcDBIFGp2kxB0EzCiTGQTaIRozQ3y14Dw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 04:19:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 04:19:42 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tune: fix btrfstune --help for -m -M option
Date: Thu, 16 May 2024 12:19:03 +0800
Message-ID: <4fba8ba903d32bba3f8f92db50823fd7aea38bc4.1715831939.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d160878-5495-4552-ca6a-08dc755f68d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yafvQma6jVqhwAo8i42hdYJUId5dfjmVbfoGODkW9lrnkPzjjD8t+CdYQFVW?=
 =?us-ascii?Q?nXjHZfJnVX4jHLtDiH9Lunv2GCxCzHkCyOi1+J0Ycldd7qOLxrD+1poqrzMK?=
 =?us-ascii?Q?n9jcyJpQFcngokEm3YbP2qulTDb44jmIVqJJqVeDMJznGJ/UOHn6JIGebF8h?=
 =?us-ascii?Q?8HH5ugS76ob8w84pGr04H35ATQZ7XFIx6cLroEJdV6MdOo0eU/6yhRCoIMaD?=
 =?us-ascii?Q?uESHsMJXD9Y6/wVlyR6EO7ip56OqHwOEXK2HRb3NXRLgtGXcR+7LkW5Xx5n7?=
 =?us-ascii?Q?idpbZDscrPMZd/YvWoOVyBRALfIhhJkxnkFlPqQlVLgdOPj+jHt+vAdoQ9cW?=
 =?us-ascii?Q?O8FNLAopg+XELObvU/Eh5q/nMh/BqFIa3sQ4CHNVcVzEycFL4u96JImRRWJZ?=
 =?us-ascii?Q?/Nt3lduID4QdDEmoi9o6b05BEuaB8T/prGFS/bVMAm19gH0o56ELnA/HeTn5?=
 =?us-ascii?Q?Vp7M2O82CSqLuqamCPfJm1+GoJdtz2NcqXj5rzBCP3l6DwBvUBMfsKrQB7Um?=
 =?us-ascii?Q?8Y0YsaZZcTpVvaN26rLBP7M+bUbejDGlgG5q+YKnrY9l616q/ARypmbAC7UX?=
 =?us-ascii?Q?00TRs0cPM5JGKDUnpi8ugHpdG7TiQ0dG0bpc2aOy8u/pO52xicbSLSYpQ8sX?=
 =?us-ascii?Q?BYSexV2xpdWxSyI3FrdLAXlN5tBFESZksB51XIZs58y5Eia5c1Fakq/RXPwY?=
 =?us-ascii?Q?8vnJKs33s9QrqJTY5RwYlX+zY4tXEfvwmM1dYo/8wbmKWEtoSv32ltAGzoLp?=
 =?us-ascii?Q?RAxwqLJSBVBJqnXW3SSYcMt1vZnTLA0Z9oPmpD/DJ0OQrovgsrGjiB89iuJU?=
 =?us-ascii?Q?MOF6ivIS+lqe8qErP3d8BmzTr0X27bFqrUIY0ZPGjLOtBy5Nc5J0yOmfztNk?=
 =?us-ascii?Q?th0J0z782ITn/GsvzPyT1i4KxdPtOFQd2LguMEUJvYFvFrM6Ligxxknl3HAl?=
 =?us-ascii?Q?UqEncLoZQCfvQzYNwRxsb+bJ2zmgO34vTxn8C+lvH1F6vKRkU1aXQQlVRiO2?=
 =?us-ascii?Q?XwvzWoMa9/RM61JTNXTb2Lxzz9LlphyNhZz8yRUkirI+2MDa9BFgYv0+SY3A?=
 =?us-ascii?Q?mt0/jXEoXYesC9Xx5JZj1+8BsWA7hzyXslQ4mhPYf4U1DaiPZuXz2XtGoTsG?=
 =?us-ascii?Q?cMcOLYC6Phe0RA0BxRg+bMh+yhUiE4Wyu8oZfQxMWXC2lF8x4PkX5TnFM4CQ?=
 =?us-ascii?Q?n/EcJQr0LGthiTn01TTf5UkEdymF5LzVhbkRQrVrRRCPMKzRaWgO/nCCGA7p?=
 =?us-ascii?Q?1blPwRbEtdbyua1gaGHeCG/QmBrgNozq2Ha/ZBkNWg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CX76F+oK46A4b8swUfB6r6Nqcev6wSnlQohjJZdBlaQNXbtAYm/2879Xsp/q?=
 =?us-ascii?Q?zR+0zpPS8cv8BUR32kQGuO9GAZEaVtu9h2hRIq4yuPdAnkw/MZb1yntbygNM?=
 =?us-ascii?Q?fGt+mV5D00DkyGdg2F/3zVVjyWTu0BlyovPc/ByWJVMzn4nENjt6zkguV5Ia?=
 =?us-ascii?Q?IU8tezTleGjYqMkYbswp+hMYI2XHtvHhRNUAFNq/dOFGIec6StGTeYCn6tdV?=
 =?us-ascii?Q?YIeDXorogdlbHaA9Umn5Q/Ujnd5JfXwtw4BcGBncRB41wCF+4OMi5nYkkpPH?=
 =?us-ascii?Q?bUeQ7/RUU8j6Y8HzxkVxzn6DvmwjIVCQM1fIe0KkDwHA6rSlz7Cx7is91Ti/?=
 =?us-ascii?Q?8PJcUsNgIVyWcZvij6jstFuZFjOq4atkt4pxB/0sPJbeMNKJNiUwgFItwQj9?=
 =?us-ascii?Q?uOLu0Jv7pS3PPLvgeebM6zq+lcEJTj99C/5jM6NW6EC0rGhKkcgF1fOVzWsz?=
 =?us-ascii?Q?Rjmrw4faIKKApCduQ6UxaokFDiGgy0lnNpMGU4vfQUOPKqCEJ86OBbbUzYG+?=
 =?us-ascii?Q?XBeEHu68VQMDcpBcrD9INwW63zFV/LW/2CjtofX2hOp6QWli3NldpCVXjwlc?=
 =?us-ascii?Q?pTKQ0Fyso0fzC/MqGCFCI3i4vvTSuXXc150IkAg/YkicJscmUS2SQwEen53/?=
 =?us-ascii?Q?J9mpLKx5vFrwCteYUyBPaxfmNnUWG0eu8r1+ct7gtoproW5mGltLHW4A4jtf?=
 =?us-ascii?Q?LSX0jX7UyJKpNsC3z4MyiO7CnJcgHcPJ7ZkJh63U7cz/BMsRuNPYfa1Cvwas?=
 =?us-ascii?Q?g1FQW/p2qFNIf/QDDSCh1j3pk3I7JZ9SUD4vVetaAUJQqk1C3ljjAdebfLma?=
 =?us-ascii?Q?az0rmNUtx5d++aPRs2EstIf8gJxe7auN1nr/qZ8+w7gUhLnWoWTr4/ZnSr4W?=
 =?us-ascii?Q?1nPRWWVS67a2xRVOpcY9E08eZDwwLfYeQhdynZ0QFow72zrLK1WTK6dCJq96?=
 =?us-ascii?Q?4oT4v0qKKev3reFnWml9D1nju2x4GE+mu0vaYMY8F55JFvEV6BhfSrjF5Dvn?=
 =?us-ascii?Q?p5ahV0qTavy1XaB743ONlqrWh7UAJJ0ETDdsjiN3CAMS41lU57ptuWIitwnN?=
 =?us-ascii?Q?O7i8HyL0KyaSftD/T+1ML9VsOoxFDOMEJAbPbggirxHukAdQbyxbgD9Hz2E5?=
 =?us-ascii?Q?dMGQOjiwqn9f0fookSQzwZcId6OJKp72G9PG3RZxdydo7Rrehhsp2oqne8Eq?=
 =?us-ascii?Q?mHPN9/Qp1/F2gPrK9dIXtnWX0HJPL34pL3T1OQRgNjRFhhG9YuYdJXbQNHig?=
 =?us-ascii?Q?vXavtG1um+VkIhUXkBpc9zBi+P5YyIgzw+Y3jHw5/nqc/MjcvQlrtCPv9QGh?=
 =?us-ascii?Q?Sx9WSB1hWbSNtSXkkaomfnPaA+4v8Wg8j0dBEOhcwh/TEQDZi/rfn7GJB1/m?=
 =?us-ascii?Q?/mMWaqgyjr3o4IsbWfhznpAkHRdbMG1iwI6N2XXssJH0w5Bq5cb3H8NgsIbh?=
 =?us-ascii?Q?aAfOY5fP3eGgUiK1zYLvR1MRO9C6qlQ8sIuDK/f7CmUh9zNrUPx/jeOpuVGZ?=
 =?us-ascii?Q?MNlxpIbJoq3KAp1Kc9iMH/q/DFSU2I7OqukjUXeY3JJXg2P39BaLs6s7z0UK?=
 =?us-ascii?Q?BpSqtk8NYdbJA3TWKxFNDJnbdYBcpvWrymxWcFMb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HIGuxEyI3EcDnAJrgSJ0vB+Se3csMkYa/pDjDnhLZAl5OPF3W498ioVl1rVdzY9+UTzk+S3jcnUi4x7tb8Y+7Q09zSwX02ldbomhUSfZ5EfQmDI0D2tCJlVMok6hE1yrTkLO4fmwFcE4uEHGUYAK+Wo2M6KBz1EO2/CDAlJZULJeiR90nk8M6mD+H8RDbvMUbF1/7H5YiB2FhkVydWr0+JuoDHz+irpx/5QgIGlbXuK3DKUWJ3fDuIN588/kB6LlKJGdc4mLQoJ5eQjlmGGxLYFcYLMUwU1Ni0DH62/imsjNPwM4TmeqGvVa/WfeOKFIfUpjuGNf+WNpxbqwkojaRxQDUb2Fr/GHpG01ygQmhQBG9HqBD5oAWo5XqVs2Y0u4ELcTRp8OabzOm2z4u0VoegsmVCgfgB3+8rhtL0XvXD3qlbh2pOqaWBBqEdbbtojng4dT5ZTUjS6TsN1HdHl9udUgK763Z/8K2/O9mQ+9FTca7sWC6z7n2s8L9/KMNXHtml/YsyKVByUzaUO9Ooxx4Hf7mogYjPgHnxJgh/fm1DGvIUxuBMvtsbjd2SnO5nWlm8BkQ5EqnuuTT8NNEHn1OXs+oZ2oIchHRD3LczohlLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d160878-5495-4552-ca6a-08dc755f68d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 04:19:42.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFfekiT4yZeeHGSwy5rxy4srbPeqOZaObjGgMSoHU3vpIjqUxsICRSa1uFyHR142Qic9QfBwIKTnUa1QUlYSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160027
X-Proofpoint-GUID: B7T50Ud39gGByiM4zFJHRoGAzsoh163w
X-Proofpoint-ORIG-GUID: B7T50Ud39gGByiM4zFJHRoGAzsoh163w

The -m | -M option for the btrfstune, sounds like metadata_uuid is being
changed which is wrong, the fsid is being changed the original fsid is
being copied into the metadata_uuid. So update the help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index cfb5b5d6e323..7ae48fe6e80b 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -113,8 +113,12 @@ static const char * const tune_usage[] = {
 	"UUID changes:",
 	OPTLINE("-u", "rewrite fsid, use a random one"),
 	OPTLINE("-U UUID", "rewrite fsid to UUID"),
-	OPTLINE("-m", "change fsid in metadata_uuid to a random UUID incompat change, more lightweight than -u|-U)"),
-	OPTLINE("-M UUID", "change fsid in metadata_uuid to UUID"),
+	OPTLINE("-m", "change fsid to a random UUID, copy original fsid into "
+		      "metadata_uuid if it's not NULL. Incompat change "
+		      "(more lightweight than -u|-U)"),
+	OPTLINE("-M UUID", "change fsid to UUID, copy original fsid into "
+		      "metadata_uuid if it's not NULL. Incompat change "
+		      "(more lightweight than -u|-U)"),
 	"",
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
-- 
2.39.3


