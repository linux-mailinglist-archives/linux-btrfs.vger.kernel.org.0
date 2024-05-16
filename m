Return-Path: <linux-btrfs+bounces-5037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7AC8C7501
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863541F24639
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD771459E2;
	Thu, 16 May 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gr7xFBa+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B3G2h/gG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF9143747
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857969; cv=fail; b=RBxPLuHFm1RiolnEqHHs2sPRLqiuqggIO4IJidSgHIxmx6KNhnDLP6rEA/MqEUAdVsXNPk6enNUsW3vr6GlxuW+adbwhaPOaVQSGc2/Y7CvSN1MNf24fTd48BuA7vjkwLzVTXpCeuOYXYIPAEXyXXaWc+p+cZOak2nbVwXoftLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857969; c=relaxed/simple;
	bh=NUTR+ZVtq/tfrIIO6YniA2IyaiUPiBP9WfhIuzyKesw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUeBSIJjn2sczebczQWkhgr6g3Enj6cXmV+mS+NQMc7BJLYPCSsm5P27OZYa41WLplDaIMnLHn1TfT788jDKoYq6xnlj1If0JMvB6Kg3K6GpySrJkw5rGii/wTJjeAQZu72EhQlx+F0BBY7Hpb6Krc453XSrdKjln0B+x6zGGHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gr7xFBa+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B3G2h/gG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GAnHBe028714
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OLbj5TAEAwQU/Ik6cUw/qqQlbE9f9IP/FfS3PmElj14=;
 b=gr7xFBa+X3fZWnm2EvegcqJ89WlO+aRO++PLcEhQV2iTzNNLenyEALdWlCZvvMWKoj30
 GZdvS0DCwZbLjxnO578bsm9CY/vbDPWyH6stMeN56c8Pn0X23dldy4LQnR8jXBJzBUVU
 rbEysG5FR1Y+POgzrALR0axvqwqyzjlVeB5nQbArbGoCAZcRxzBwKWhA2yJWYD4NGrFO
 Jn6DamH7Tv4OG0m66OKzQd4vM9Mqm+gtWs+Rs0JBsZHGvNy0H1BW8YNiHuHAPWwWOwpI
 181N+AWd7FmMQ/N52Bt0h7dZp0Ib4gIcjfByvUKqkqgEphHHRDqYIrpANM51erIYpbbz Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx36y30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GB7Fto018120
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4g9t51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNb0IHJGNJ26B7hO+ofTyZ1sgUod9dU/GMtEvcM7bXLHZlMiEoXjCwTk+jRTf+eBn9emqCqNn15NrzoAp9qYR0kllHjdvCDvMYKzLOO82pndm4dJmTtCmN0Tx9qWfhEbcE1NmLowauZF5xJpNOAT5lSNwXDsN5zz8z/GFMVH6PPQytR1KmC+RdwsRnOWVov6DDF/7Ef0d38cSPQpuVLfiFJHr+W/I1HMAXf2hPx90ullwYIH8IG0xgEpYdNJvVmnD85Xwv8vEdvWoqsfE4OpXhUOIoJ6KcLeYp1GQ0zLhGug5SI6SxfdB07u70lSOx0yDYH3QN5QdRVZVUz5EpWTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLbj5TAEAwQU/Ik6cUw/qqQlbE9f9IP/FfS3PmElj14=;
 b=HT9vuzluE52TgHG8lLzWo+zfgMrj+K2IAntdGNQCInQ2BIPHjLNObSUoSJtmHIl7H1eIBR3hCUb/AkpefstYZe02oEROIj1vSDDYnoVcu8AXJ+9EDtiuxjCGnTRrRYOeg3oi1fw1lMUSFo7VIu9O73SiSHQR6LRXL3H+LqhJx9m49QNXFm2zNA8BzTUXNZsQ5P2hGWFdYMn985YHqY1wWYxtnnX6YJBnthETvZfvf0jiGV8VzBUM5OCPe8PGvlime/56DCajQnF1OBO8AXzatuatc9mgCo4ZDMcRsnQv5hNRoMG7NCexCo/Y8y6GS46Lz3aqKk0J96Le8Z0lwyAtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLbj5TAEAwQU/Ik6cUw/qqQlbE9f9IP/FfS3PmElj14=;
 b=B3G2h/gGXb4bCPPZd06X0q6q0gofsnucw3jBiffS8s2LW47xr9lQrXCTlW63fWFP8ZZbUESZ5UjEOjb+vVwPS4T3AL7cljqBUEZjmhMCqXnwqtMamcA9rj2HNsxC+7e0WkcrU2jFeeeQxxOmPVSPwV977b3dSuSzT6u+3ErpIwM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:12:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:12:44 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 1/6] btrfs: btrfs_cleanup_fs_roots handle ret variable
Date: Thu, 16 May 2024 19:12:10 +0800
Message-ID: <2a831fc01d65612914702b968174945f2f7e1c79.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: a99888b9-ee3b-4458-93c9-08dc75991c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4WVTSkXq5aIMWpY6BYKvCJVZjOMPQbDNRIg11gLlFWgv3iBM+PvMtRKiS43I?=
 =?us-ascii?Q?wt/C4MRc84KthYGOJ3HeHi/wK0g/5AjaAEWCsNC69YGqC9ntwMpsk++XOyyS?=
 =?us-ascii?Q?yU9d2fVlOHCvpixuHw/bQJCNuj8AEdJqMbgxy+DdwmGiCJmr6Ax3RLV4IVi4?=
 =?us-ascii?Q?pQkZSNaftwGG6DXbiSqv1WKe+nZm0d7HxFMAFxmCzd8Ue4uhEC+cXAIHHzMb?=
 =?us-ascii?Q?RZZ4zgZJCJF87LhftRo6OqCK7ZMNlLGjWyWE+7sBeHr1BeMFcQ8zhG0iIGJG?=
 =?us-ascii?Q?FWziUXYHbDyREFeWmViKmkLbqxGlUW/wv/cGA/a9Mc8ebxNTaqf/BWEAXqCb?=
 =?us-ascii?Q?zwN3QqlWAuyUxiyFZ9g6UZcmZaW4OitZqTf2zAU6LDjivbpnEWUI3+4+1V/2?=
 =?us-ascii?Q?OyInn7nUX9bbfGYKA/ASIIyvBGtHPxnx8aqnZhPzmbxIvnDZy9NVYJ/23mKz?=
 =?us-ascii?Q?7ZKKrRLcgLm5xU9ED/2y8g1fVcTriRwvtoSDuNZ7zo8RNs86SBDsm+R0HNH4?=
 =?us-ascii?Q?CDqIUVEiDVfLZj/QjX5ASq2Akz7fKSqA2olaklzsQ1zYzbdKRzwskjfX0MR8?=
 =?us-ascii?Q?TKchOpU+BmNDHQf/Ord5HBoLhlHfu2zdHMs3JStXQo/3QhNZx6wRAuIfseHA?=
 =?us-ascii?Q?RPcnelfyhqy3F9FQHXw8PkkJ4zHkWPB1KZ+mMj3rEz8EDarnXMUc2ywaz1ey?=
 =?us-ascii?Q?9hY7AJ6vGa6xOGbAzjS1A7OBkcvvGdwFGWx9Z2lPjBrRoP1l7h0JR1yacoWR?=
 =?us-ascii?Q?ZDDt3RE3sYBw4wLGvIUrn9GebhHWYikTJ6udMpRQ9+c7nH4P4fYxAgHLIv+E?=
 =?us-ascii?Q?NHNvFhkn8Wrc0BYA0D1d4kIVZT70fLm1wHMwLcAKiAHuVlNO4PqfKHgskH2Z?=
 =?us-ascii?Q?R7Fo+6g/0l93BkqrfCwd7AwQubTgKr2nW6GyuylWACu4+2HZsmtUqMygDSHf?=
 =?us-ascii?Q?bvrRx7lHLAZ2hEC/eTZ5HsGeoUvW8MJ+s3FThnBHQ5E4bUtSyfrP7S/I1ZbS?=
 =?us-ascii?Q?6LzVM/Px26Jj274yNnuKMaNX/NxN3HaRoG6qZ6a6M5ra71Wst3K+ieIW5lBr?=
 =?us-ascii?Q?AQ360tc3mYZsDcUC5E53kXQDMJLUa/9HtDewAmDk4LaZVUqhemXHJkaWHsrP?=
 =?us-ascii?Q?0zQckrhtGuqb3HG08dT9/XPVBQw0naSqiOEr1wEyRK2gSQfYoUNgxb2Nb2h9?=
 =?us-ascii?Q?Aq9muc2jLEqAAw59148/NxeesTz85w5QZrUhSRePsA+c1dlQC4DE8scKwYCu?=
 =?us-ascii?Q?MVdqGnifMb5opLgYvOv7qWkO1zvrK7wMSWO6Pe9spg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pmIzHlL8mfigIEGdYa9dGQvUYT8R4yjjyMaB/162imMyM8A4MNxD90F528/c?=
 =?us-ascii?Q?S67/rzV2MM8Adens3haxTHCbezSJUMQbj4v68NTsMTsw6u/zLE4uC1A39lcU?=
 =?us-ascii?Q?4LS29TgWi7HRbyU3bdcAPapPwtiktwRDyadobLTZiLkcROTVxx9qjo8z+Raq?=
 =?us-ascii?Q?5uspQMAQn5hj8K1T8o6MQUvXvHkBh8tWW+tbEPewU3Bt8ParJPVhVB6VTL9v?=
 =?us-ascii?Q?lEoxEiwZXO+GqZRB3NGunWdFpmRai/x360SWqcM0DHN+RLJWs6H5E0O9GhS7?=
 =?us-ascii?Q?csrcEn+sCwPh504cGo/FMkFczmTXwpPUTIDNGYyL9tc7qOsiXAsNmtDcxh0x?=
 =?us-ascii?Q?JOip8vo+XCBqSnK6E3ngSZaDk/Y45cJUyXvtfNi6V0K6CTPPXpYQ8ZfryNRn?=
 =?us-ascii?Q?+UJnVnKMa1oNIsobKwgIGvQPniTmjUlI3kbB8+gGk87ll0ZTakXS7jjd9vyz?=
 =?us-ascii?Q?FRDYzcHcZfe7eBISI+UsWLQQXxwUoN5VMlsPytQSeWb+8fKN/QcZJUvLUe50?=
 =?us-ascii?Q?nwoRaIcl6xyieaP3QQ7xL2KWNgWwS2lHgj6yx8Dxis2bH5i2QPK58CA998/1?=
 =?us-ascii?Q?uFsY0fs5H++BpCff7JXmZuhGeDbEBvCMFj2HdCsZCC/11YGQeH61Od4bLdgx?=
 =?us-ascii?Q?ujmvGCxN084Gfila2mslZdy7uJ1CPCBUs8FenuH03J5vcgGQz3VuZYwWjOnG?=
 =?us-ascii?Q?wuWE4VNlbG2Slh9/K/NGgD+ufPdcMGBPlhCD7YvHFtlQ+hL4MkHuAkc4FFRV?=
 =?us-ascii?Q?glaaT/WLBY0dA98Kz3BxWlw0oMRh0s1qt7054KXGu1LEaAsKTRlmc8iug1Wv?=
 =?us-ascii?Q?wdgWUCz3ErppvLQKqyg/T2B0uzs0u6Vc6XWx59Ojtf7Sp4cWvFVZSviVanp3?=
 =?us-ascii?Q?be8/POjRmJcodZ2dZK/T4CSsGdJIcEtxyydK+XmEnUhShmnB+m/US+6nntly?=
 =?us-ascii?Q?SgBWOdJRpndBqq93NsawqewpM1kHmzrjWyVuVaST13k7QbSiBEM79Ou6jplw?=
 =?us-ascii?Q?LfvQ6ZmQW+Evw4kENhpCQ4Hf9YPpkmpAJvhyPzHNV1Tfl44FhufEzoL2fnI8?=
 =?us-ascii?Q?P6iygU+BE7ImTwmWOPu85WiPCFaHuleBlM6DLnRzKXPSB2CLxuNevXc9xblK?=
 =?us-ascii?Q?zBOmv/8fCRcTgX0hDYLhwBVG5/AnkeB0ngaUI2dQIbk5cX/+9Z9XuIcq5j5S?=
 =?us-ascii?Q?0+obl35VsdogxOqUGL/wyeLXFeLy6G/EUKbeNwaNUooR//FKH12z0mWfWknD?=
 =?us-ascii?Q?KF/XqhsdeCBnOkvA3A+kkknNYDxBBP2f/X89VjoRQeXDa7IVhFR1dUr25Gbl?=
 =?us-ascii?Q?Jc3rMXPG7dSB2ujPhiFis7Wpw6Qui9J2QPonX447ykD9CSR3Vh7NmXiLcN+f?=
 =?us-ascii?Q?di/5dGJtMJ15SqNLfzlNWr0/sy+KduMTcR68KIUltK/cAYDH/O0ClFMFaH48?=
 =?us-ascii?Q?knjr+4gSUPcOGPqxPN8aHHm4Zt5npjNwCXcLT+vkslfWwTUpebdZhtUpux76?=
 =?us-ascii?Q?V8albyw9XdKVQV7EZa1aRyH5Dnq4/2X9Tmrs2a8FlfyZsV78IwNDpXoJRM92?=
 =?us-ascii?Q?TOj5O/gUJha8fJ55iyf3bFDdkK+qI9oobe/3fnyvNGN+pvWNKo3lHBpLbchp?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qZKYAMU3fwrUd1q3ZTtDW4GUAuygpdA7ExkztuOw+skhK318x79iNcoQpEIcO/Ixf6KYHv3WQN+tO/qvlKvOgf5Wch8BKSKlLs4mfYgxBOzmIGz1TH9gcjWJMwtTOvTdpU6k/MYnBJ4niLQsGu5QWIJ3zigOOXFYE53+yz7gEiPYUfqq1WWD0QiP9aiFpc0eQ+LQQNhClexatCizez40z+6XnyzPNEdRmETRccLhoq7m8spGp0ntRxX9lYnNuv66kcsP7LY3sfltR1Yhdi8ktQtXpOU7oVYPnN+41csyDRROuEAvmSoJIG63y4BtzwFKJYPag0JUik9qbFM25R5LvzGtB+OeZm4FebfEqNMNFYBJFnvXLwWA3JF/WWTXDl7Bbr8I2jxFYql4snPIHZAtvA1cFYch3tLvF25glrxxPElody725KBnlRVUuLbW1thmtitCvJCUtvlWJYj5DYmvVZc7vduLvpv5T0B1y9oNZb9ynfpjMiwiawJxL+yda+arnVus6NA8eIlOoiLc7RZHlxUxZbfMsu8qKP6w1/tjtqfMvrWujEu+IjORx6sGy2VukL1xixOYJzmc73n5+U77/BWcCMB/ix92b9SU0PjMzjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99888b9-ee3b-4458-93c9-08dc75991c28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:12:44.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfHaWLS7ItQzCiwVmeLEldDbqF5d3BzuO/D2lM1i0HFJo9RhYFejfe+B8jJSZ7teO/Xh62bCt2/ftY0IJQS6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160080
X-Proofpoint-GUID: MGLQtQGMgyls4yb1FoOEwhFkY_gSU1He
X-Proofpoint-ORIG-GUID: MGLQtQGMgyls4yb1FoOEwhFkY_gSU1He

Since err represents the function return value, rename it as ret,
and rename the original ret, which serves as a helper return value,
to found. Also, optimize the code to continue call btrfs_put_root()
for the rest of the root if even after btrfs_orphan_cleanup() returns
error.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Add a code comment.
v2: Rename to 'found' instead of 'ret2' (Josef).
    Call btrfs_put_root() in the while-loop, avoids use of the variable
	'found' outside of the while loop (Qu).
    Use 'unsigned int i' instead of 'int' (Goffredo).

 fs/btrfs/disk-io.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..d38cf973b02a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2925,22 +2925,23 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 {
 	u64 root_objectid = 0;
 	struct btrfs_root *gang[8];
-	int i = 0;
-	int err = 0;
-	unsigned int ret = 0;
+	int ret = 0;
 
 	while (1) {
+		unsigned int i;
+		unsigned int found;
+
 		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+		found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
-		if (!ret) {
+		if (!found) {
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
-		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
+		root_objectid = btrfs_root_id(gang[found - 1]) + 1;
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < found; i++) {
 			/* Avoid to grab roots in dead_roots. */
 			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
 				gang[i] = NULL;
@@ -2951,24 +2952,25 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->fs_roots_radix_lock);
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < found; i++) {
 			if (!gang[i])
 				continue;
 			root_objectid = btrfs_root_id(gang[i]);
-			err = btrfs_orphan_cleanup(gang[i]);
-			if (err)
-				goto out;
+			/*
+			 * Continue to release the remaining roots after the first
+			 * error without cleanup and preserve the first error
+			 * for the return.
+			 */
+			if (!ret)
+				ret = btrfs_orphan_cleanup(gang[i]);
 			btrfs_put_root(gang[i]);
 		}
+		if (ret)
+			break;
+
 		root_objectid++;
 	}
-out:
-	/* Release the uncleaned roots due to error. */
-	for (; i < ret; i++) {
-		if (gang[i])
-			btrfs_put_root(gang[i]);
-	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


