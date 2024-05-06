Return-Path: <linux-btrfs+bounces-4760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0338BC60F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DF01F21C8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E412242AB1;
	Mon,  6 May 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XITrXNNa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XH3X09Yt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56834206F
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964748; cv=fail; b=cFcpZpSf1E2GKmxCE4B7rZ7INUfHpWGXq5uPPCTa1Ba1OYz9AXwSPxcwftgAw9piz74DDM0qoQvvffeon9XWYbv0JnOJEH5pdvNCHukxwJCjxWwjaew+DjrjihvHtExlIc+By4AiR7mqO/Rn6a60JCk6jQuRXJ+3cKwqzac0Nng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964748; c=relaxed/simple;
	bh=HbM7g9g9KmsxCqujP2IeZ5t01WoELewNMzKlkj/1+B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B00CypM94j70lxmnAc52lLeeo2kVOQMlw9bEr1S9r7ySI2hFB0a2bulxA/2kyZgGaZqHJ/i/5VLf1IirTxswtbI7Mb9Ot0ETTwexrAm0Fn9kl3cTxG+UlOy3fY00nnwH87WCLpjUjv5kspBS1wyFvynngh9iMVO3DZQp63GfRTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XITrXNNa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XH3X09Yt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445MVorG007496;
	Mon, 6 May 2024 03:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=0ojAu7Ucp/S6VGxtrKUIdjSluhnJsX/+/X5KyZc0C2o=;
 b=XITrXNNaZvS09UDMbB+YLqJwZdXa9Fiu9rr2XLFYH2SSQWwYu4rFBKyKy5ps/Oi31r+T
 S+9YFZIw6IPc+6Z8I+zdYSsSjLCZOf9GgDJXUSMuWglX64TvO3xJIxdlPjnKUPRrMheW
 Mr+yp5Yeiqee9VIxIXHFeBu9UdeDf5qucVAnQLh8aZc/wtewQBmwCXVGRzyxvLPWirLN
 d1XSwyXWyC18LlwjQWzp0l+Kb4b9xroSYMsosQaPXMOMZ8Sry/da90epuHAetG2wsq7Q
 aHmqqHsRMcqdWw5an0qr7LtDcj5VKZGxyAbno1EJMGvUT/xxtg0hiiTZaYPtDBzP445b kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2dsn6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4461h4vN039348;
	Mon, 6 May 2024 03:05:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf51qn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW/0itnVPphL7UIijHXKrl/RPJRKYJA2CCQRNWj2LzNtoqgQZ9M1+jzIGygIzBgIU1ZGx9iHMciOSz+I4DJszAj5ERCZ/8N8WnwzUUgAKd0YSleUO7ZfDq0hXYpf6FYplJaFhnH33apVIw7hYDEIQcEi2UUP5/e+8F0/a6OvYN3SuF8nnQlrV0GSyZV17v+uUk35ouOqddjNi7P1I/DLnwifRHJjPLKrJ+XtTZrsCxOYFtb9Eh74Nt4RBIzbeexlLY8DeICg80wzaQZsONCOKnEt8jOAZYR8vNco6H4VtZIT+UiOzDU5MQPJe06xzyY7xkOEdBNPmNIx1hf0xPOqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ojAu7Ucp/S6VGxtrKUIdjSluhnJsX/+/X5KyZc0C2o=;
 b=OXM2z4zTKY6HMnijZfZXTeTCGrQjldr0cV+5+qrzJj9uyA5sUTViD8WumLiSq/vvuUJX9fzCL8D42KtDToooYaV+2l5rkLoY7ZT4csRcL5lLgs2Cz6RW+rKbjqbqArUq/y1brNmzW6dtg5HTCtJ/CDlm+pQ3MEsB+EwHZ5MY/Pu6tzqD+JioTUOXNkSEsXAbY7W78OQDgNgUNXzFHNYrq0dmZ76HP/FyOeZoCacECiSI5uGqo+UXqr7335z0+d69Mwga4U4ZecoOcafmXc9Wy1DszcauuyTSv26+BnDOnSbD1IA+eWmr7+Y6aATEcgRwxI+ZxVrp+k4lJmJGwxoj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ojAu7Ucp/S6VGxtrKUIdjSluhnJsX/+/X5KyZc0C2o=;
 b=XH3X09Ytm6iyqGbt0AysJKRH8SJnKHFSfJnwQziet/M+GUVmoMD6hSkxOj4XO5BCCdKDEKheABE1/FXBNPHGM7iAapjY8nR8p++wl3DkL7zn2irx9fOXBd0kPcGlO8BFDr8xqzFBHWFIDYd/p8UQfchzHPkHPTG56/M1wonbRts=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 03:05:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:05:40 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
Subject: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file data extents
Date: Mon,  6 May 2024 11:04:58 +0800
Message-ID: <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714963428.git.anand.jain@oracle.com>
References: <cover.1714963428.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acb0284-3234-405c-e736-08dc6d796908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zg0YLGkxBTPJ3JqgZPiGA8g3PxePv5FcQ67Bd2onL2TyAHCZKjFwASinkh1X?=
 =?us-ascii?Q?TjPxugfcX1+L6lA0LAn+cMdPXcdymnKcwFE9Cj6vQAJ0aS8a83+g+Wm/q/0b?=
 =?us-ascii?Q?JPD541EgIKgZdggkXPkYSdqGb3zipNlzGTbrmnBpckQbJCZrjc70uCQGly0r?=
 =?us-ascii?Q?SoebD1SOocg5z8IEu6UTd8AUZb8nG6n2SH/x16nC6GaNMVSOWVWyVs7ggOtZ?=
 =?us-ascii?Q?hit6tB0TN6+/1YFaLfCyJuNOLHf4GCpW9ysXZgw6L58ouN9e8eQKNHFIbwG7?=
 =?us-ascii?Q?8vGUF0CD9sZqeFoKQM4r2NWTq5riXTDSpr4exZ+DLuM4IElJDlJ/kq649fIB?=
 =?us-ascii?Q?NVTNG5HPFDDggoJncz1M4986wiBcU+DQrSUTWc8m81oOkDkcjoKZ7dMzBpk6?=
 =?us-ascii?Q?pqIaknrakBkdkiI5SSFg+iTXTcBmJM30NaFkUJxokeAHCKXBt9x6FE+3jho+?=
 =?us-ascii?Q?VlBo8mq+mkzACiYPv62Q7O7KGJl7u2La3KcQii+NzBdywsl9CdepB+0Py/Pe?=
 =?us-ascii?Q?Nd8OAoDaShvrxoQrDpmH6arkAbROLukkdaZXdyXtuuIzvCzQAqBBSzIBHZx6?=
 =?us-ascii?Q?jkCYc7OI7QfXJhpGO5d7SoK7TbY6L1boCz1hlYS8RwH5Ozvez3Jn3Rh7EtOa?=
 =?us-ascii?Q?vcFuN4gjeJ30cjwKIFi3e8ovxYXhbgwrarwI2POFEECCxEV6MGGsxR4C1J5P?=
 =?us-ascii?Q?CF7HbFYtlY1I6dcGmu3e/AsolkcXqHlPq7R+ohTMPpQ/8g37uOK7WX2yvUoL?=
 =?us-ascii?Q?c8t88VA/XiKZ3sDj3xzYDYDy6gFoUCSd5bwfX4521qHOHqQgCinVIlT+A1ps?=
 =?us-ascii?Q?WIEwq1dw0jwvSLi5/rg33PKhFiDq7OjwDXAfNM51Yhp/5ZfXKUJbJXzN+aGR?=
 =?us-ascii?Q?qud14VWkjsDswlY1wrm8yIgx0ebGe6bio1tLMnD3A1TKpcpoTSw7AmRX/3ML?=
 =?us-ascii?Q?MgD/j6rE5lfdgVDQn7s3eHJ0iH0GJTF5+ZEEHetp/ANG+PiA8FNONXZATSNi?=
 =?us-ascii?Q?lshFQ7wMkq5B2XX/P6PwwwFsPxNL5q4YzxbHBtpSSaVnoqPGrPj0walHfnb5?=
 =?us-ascii?Q?0t7DBfL4xc/A9EiG2ir7ki2E1j4Nupzisun9mi0J9Eek7mFniOF723Kzyl/d?=
 =?us-ascii?Q?SXuPQZBpbYAfdsekGWuH9T5j1wZaIKwTTlPznobSVzUmtxk2WEQm2+RihCzH?=
 =?us-ascii?Q?oLyPrkc6ujtRohrX9q+1takHCKv0Mf6mOhMGzt4TEt36z+v31F0rd1N5ifT4?=
 =?us-ascii?Q?PV9GBn4jJbwRE1vOfMOQD1uN7FUsHvIXyCSNx9H4pQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tFD0eI0iEezRkC8iS8vfxlO7Ae9cdauOoozTZHN1vY+d071j7GdEden5mcY1?=
 =?us-ascii?Q?P6Tlx8uX3pl+nQii4Q/2TBTV4cSBZIboRvmc6jB2cnY6W42c7FLilZ3pnCuS?=
 =?us-ascii?Q?imr2Xl92gaYvyiRuvhTmZnPoaox2Ky/8l+OQvvoCBxdpA7R2wQDKF1r75G7Q?=
 =?us-ascii?Q?uKjBrQz7xddMcyRz4XCc344GRB8o/zEDDWcibA2dky9tub1E3704/ytaSQV5?=
 =?us-ascii?Q?oP8JAxZQT0EChkLXWcv5QYsfrbUdECaPfRz6+pJ87kFTN4xvFRYmS1Uhs93i?=
 =?us-ascii?Q?zowbSSNd+MDBrocZQ1hjoXhA2FR7KaAY0Mxniu72IZIjP5pb609lcij6gR6P?=
 =?us-ascii?Q?mV/mTScXHxg4vCHiWYO39w9BSyypcuRZYolGvDY42Vaqn22H58kpcV+Kjev9?=
 =?us-ascii?Q?WblJpv0sSGhDGi/8Ou9qAwHVDIPiN1LBiJAR8aisYZce61YyrC3n8806NYVV?=
 =?us-ascii?Q?/oKBQZpDTBtIMHv4yhpCpjvRF3ROxqbagi5iCrxw2KUOHgCrcPtydLZCnwdq?=
 =?us-ascii?Q?KjGnQ28/C27nbOm3gu+s14gcpbvixnRV5UcQoQbvUln/+hQ/AcDCRhjfey/R?=
 =?us-ascii?Q?1fo+o8FQRiz0GZNNUHDjTWjQp0KlMH0vOa/uGg0Sn0WPX800q3ECsDPATaxp?=
 =?us-ascii?Q?S2L5aIcoWvC8Od1A/ooUQ8ifI/kqb0l2J4wV2SXSqcXgA0XwkG1YkwlY0nsV?=
 =?us-ascii?Q?bFTg2ms1Nokrht7GAxGN4eZ9z12g7hcSX/dLI9ywHEa5Fapo5Celyk8RwQJC?=
 =?us-ascii?Q?U8ZJSaHg/nRJtRfCdjAtcYyx4fp7FWbvWpYL3uZ6Z+ukKdmmwVE108e96PTZ?=
 =?us-ascii?Q?B0QwXKYRLAVNoTYhbqRXaRfJ5GdOM4MQXnSBNKA/JnJ23tBql72Lzw6nNmY/?=
 =?us-ascii?Q?HUi7EWur/S8a+BOZiR4sSh71HKhPYZj2cHqRuKWI5Jxz08Js2C4ab+xXdjT7?=
 =?us-ascii?Q?mTf06Hjed843NPLFU2M0xJd8JugEbAwnH2cU8Kos+ALN+qXz7nleLGL9Q6Pu?=
 =?us-ascii?Q?bRI+NkBGcwGGesqn2j5RQpgTlfsr0kG1k172AndpGeG3xkolahoUqKxb0+D1?=
 =?us-ascii?Q?fXdUMRJatFHzKu4QC2fUveEq4AwspRzlowZNrZavOT0HBJhRSPSEG+Bv0X3H?=
 =?us-ascii?Q?FkklzPizx/At5S5kM8UirlenswYhoArVpeKxehUFsItgq9lIT5hegfSXol0M?=
 =?us-ascii?Q?xLgxgnTGcWwV1iX9RjT5/p6M5s5jNXIi3L850u6OAzTf3uj6kd6lpIrXKuYD?=
 =?us-ascii?Q?ScbbIabGdD1Gc/hwez1DzqeasBy/RB/DMmcX5dtle4O6YRajg4wvIcvEDjtO?=
 =?us-ascii?Q?DcyVgAmCdvWJa4+jglzO9NycNJAekQ7HUYbN4WCrUY9oSf3FWzlZ7BvnJZxq?=
 =?us-ascii?Q?qVc8utYmXRTjpkAaRUIwYfyBAf/rDPBgaq/jfWeBtQmawEykmVhe6SugEBdY?=
 =?us-ascii?Q?svFBLN1cOS5XTrL2i5CTCr2GEnNyyvWEtMj/6UzVL3hyG5R0t77n45eOsxFc?=
 =?us-ascii?Q?H6h6n3nDiPMxqglARTdJgBfhHGkK3pR8PjVAn5uyFAhC49Y21pWIfD8kE7MK?=
 =?us-ascii?Q?cMt2HcT0AXC0VV6BCZFawWfgivTI5JeIGHnCdM550qE+x2P1QpJ8k6e5tR0K?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QBk6SZ3Drm9SOk3gPovJ9ZhfGDLT23GxGP2b5WlUpDANTDyNlIA5bOcuYcLkv2ZsXl0qUah1LGB8O/pgzgyImrqxmEJobZ8uF4n6DEtUhOiqMUD99+qQX5wU+Oew2WCL7N6V/0ER0g2p0Qm6WBqzQfJUtCz03+uP2Fayw+/sQ7vfmeC+aR1au1slf7Y6ZibGYr4lBCwr6mQGkq7PG0b11Ewx+ETyiMq5ClDUxIr0JIkhk/vBRuzSHhfBD1mx3onLPiPGjTRpTHsfH+7dtLMaJsHOPz5sBTdYK6fLm46Zv6+Tgj7+et5D8io+2wQI3QJoCyFif9mfoQXuWp3vyfF/GTBcCYoDxbAyyB6gSQYrdtDdAnM+BE2HXNaSnI3cRObtRlmTPdF5H8HHZMRjRhTOXwMZcdFsiSy+oLG1X+/zDdnlNkN3InNuZilb/lt2drJgXseIDvjje2zv+AWwSSuWR5jmOvi92x5TLPNWSn+OfvhK8xSyRVcRsAbJ/amrsAECLwK+XV1jlzl2T/XswodmggwrY7ASdAAXPimGvY9L2yzQw+EgoSCszjpJHwrd4845nKS/dU3QxE2YitoHOC+/GpHR7CziOH8feqjqcmu0f3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acb0284-3234-405c-e736-08dc6d796908
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:05:40.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm4sKuIkBqjgq77ABq2nqlj1vnDwbOcVo0gpuMtI9XttJM3MdQITqWaf6mTilEnsoC8JXHTCnfxPkyapJsjEAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060014
X-Proofpoint-GUID: IiJIPOUq5sGYrg5OQdlocf7zsTjpeiSf
X-Proofpoint-ORIG-GUID: IiJIPOUq5sGYrg5OQdlocf7zsTjpeiSf

This patch, along with the dependent patches below, adds support for
ext4 unmerged  unwritten file extents as preallocated file extent in btrfs.

 btrfs-progs: convert: refactor ext2_create_file_extents add argument ext2_inode
 btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file inode pointers
 btrfs-progs: convert: refactor __btrfs_record_file_extent to add a prealloc flag

The patch is developed with POV of portability with the current
e2fsprogs library.

This patch will handle independent unwritten extents by marking them with prealloc
flag and will identify merged unwritten extents, triggering a fail.

Testcase:

     $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=1 conv=fsync status=none
     $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=2 conv=fsync seek=1 status=none
     $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
     $ dd if=/dev/zero of=/mnt/test/foo bs=4K count=1 conv=fsync seek=6 status=none

     $ filefrag -v /mnt/test/foo
     Filesystem type is: ef53
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:      33280..     33280:      1:
	   1:        1..       2:      33792..     33793:      2:      33281:
	   2:        3..       5:      33281..     33283:      3:      33794: unwritten
	   3:        6..       6:      33794..     33794:      1:      33284: last,eof

     $ sha256sum /mnt/test/foo
     18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo

   Convert and compare the checksum

   Before:

     $ filefrag -v /mnt/test/foo
     Filesystem type is: 9123683e
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
      ext:     logical_offset:        physical_offset: length:   expected: flags:
      0:        0..       0:      33280..     33280:      1:             shared
      1:        1..       2:      33792..     33793:      2:      33281: shared
      2:        3..       6:      33281..     33284:      4:      33794: last,shared,eof
     /mnt/test/foo: 3 extents found

     $ sha256sum /mnt/test/foo
     6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  /mnt/test/foo

   After:

     $ filefrag -v /mnt/test/foo
     Filesystem type is: 9123683e
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:      33280..     33280:      1:             shared
	   1:        1..       2:      33792..     33793:      2:      33281: shared
	   2:        3..       5:      33281..     33283:      3:      33794: unwritten,shared
	   3:        6..       6:      33794..     33794:      1:      33284: last,shared,eof
     /mnt/test/foo: 4 extents found

     $ sha256sum /mnt/test/foo
     18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:

. Remove RFC
. Identify the block with a merged preallocated extent and call fail-safe
. Qu has an idea that it could be marked as a hole, which may be based on
  top of this patch.
. Updated the change log.

 convert/source-ext2.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 convert/source-ext2.h |  3 +++
 convert/source-fs.c   | 25 ++++++++++++++++++++--
 convert/source-fs.h   |  1 +
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 477c39d9d658..9de591e34c18 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -208,6 +208,54 @@ static u8 ext2_filetype_conversion_table[EXT2_FT_MAX] = {
 	[EXT2_FT_SYMLINK]	= BTRFS_FT_SYMLINK,
 };
 
+int ext2_find_unwritten(struct blk_iterate_data *data, int index,
+			bool *has_unwritten)
+{
+	ext2_extent_handle_t handle;
+	struct ext2fs_extent extent;
+	struct ext2_source_fs  *src = (struct ext2_source_fs *) data->source_fs;
+
+	if (ext2fs_extent_open2(src->ext2_fs, src->ext2_ino,
+				src->ext2_inode, &handle)) {
+		error("ext2fs_extent_open2 failed, inode %d", src->ext2_ino);
+		return -EINVAL;
+	}
+
+	if (ext2fs_extent_goto2(handle, 0, index)) {
+		error("ext2fs_extent_goto2 failed, inode %d num_blocks %llu",
+		       src->ext2_ino, data->num_blocks);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	memset(&extent, 0, sizeof(struct ext2fs_extent));
+	if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
+		error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
+		       src->ext2_ino);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	if (extent.e_pblk != data->disk_block) {
+	error("inode %d index %d found wrong extent e_pblk %llu wanted disk_block %llu",
+		       src->ext2_ino, index, extent.e_pblk, data->disk_block);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	if (extent.e_len != data->num_blocks) {
+	error("inode %d index %d: identified unsupported merged block length %u wanted %llu",
+			src->ext2_ino, index, extent.e_len, data->num_blocks);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
+		*has_unwritten = true;
+
+	return 0;
+}
+
 static int ext2_dir_iterate_proc(ext2_ino_t dir, int entry,
 			    struct ext2_dir_entry *dirent,
 			    int offset, int blocksize,
diff --git a/convert/source-ext2.h b/convert/source-ext2.h
index 026a7cad8ac8..19014d3c25e6 100644
--- a/convert/source-ext2.h
+++ b/convert/source-ext2.h
@@ -82,6 +82,9 @@ struct ext2_source_fs {
 	ext2_ino_t ext2_ino;
 };
 
+int ext2_find_unwritten(struct blk_iterate_data *data, int index,
+			bool *has_unwritten);
+
 #define EXT2_ACL_VERSION	0x0001
 
 #endif	/* BTRFSCONVERT_EXT2 */
diff --git a/convert/source-fs.c b/convert/source-fs.c
index df5ce66caf7f..88a6ceaf41f6 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -31,6 +31,7 @@
 #include "common/extent-tree-utils.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
+#include "convert/source-ext2.h"
 
 const struct simple_range btrfs_reserved_ranges[3] = {
 	{ 0,			     SZ_1M },
@@ -239,6 +240,15 @@ fail:
 	return ret;
 }
 
+int find_prealloc(struct blk_iterate_data *data, int index,
+		  bool *has_prealloc)
+{
+	if (data->source_fs)
+		return ext2_find_unwritten(data, index, has_prealloc);
+
+	return -EINVAL;
+}
+
 /*
  * Record a file extent in original filesystem into btrfs one.
  * The special point is, old disk_block can point to a reserved range.
@@ -257,6 +267,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 	u64 old_disk_bytenr = disk_block * sectorsize;
 	u64 num_bytes = num_blocks * sectorsize;
 	u64 cur_off = old_disk_bytenr;
+	int index = data->first_block;
 
 	/* Hole, pass it to record_file_extent directly */
 	if (old_disk_bytenr == 0)
@@ -276,6 +287,16 @@ int record_file_blocks(struct blk_iterate_data *data,
 		u64 extent_num_bytes;
 		u64 real_disk_bytenr;
 		u64 cur_len;
+		u64 flags = BTRFS_FILE_EXTENT_REG;
+		bool has_prealloc = false;
+
+		if (find_prealloc(data, index, &has_prealloc)) {
+			data->errcode = -1;
+			return -EINVAL;
+		}
+
+		if (has_prealloc)
+			flags = BTRFS_FILE_EXTENT_PREALLOC;
 
 		key.objectid = data->convert_ino;
 		key.type = BTRFS_EXTENT_DATA_KEY;
@@ -316,12 +337,12 @@ int record_file_blocks(struct blk_iterate_data *data,
 			      old_disk_bytenr + num_bytes) - cur_off;
 		ret = btrfs_record_file_extent(data->trans, data->root,
 					data->objectid, data->inode, file_pos,
-					real_disk_bytenr, cur_len,
-					BTRFS_FILE_EXTENT_REG);
+					real_disk_bytenr, cur_len, flags);
 		if (ret < 0)
 			break;
 		cur_off += cur_len;
 		file_pos += cur_len;
+		index++;
 
 		/*
 		 * No need to care about csum
diff --git a/convert/source-fs.h b/convert/source-fs.h
index 25916c65681b..db7ead422585 100644
--- a/convert/source-fs.h
+++ b/convert/source-fs.h
@@ -153,5 +153,6 @@ int read_disk_extent(struct btrfs_root *root, u64 bytenr,
 		            u32 num_bytes, char *buffer);
 int record_file_blocks(struct blk_iterate_data *data,
 			      u64 file_block, u64 disk_block, u64 num_blocks);
+int find_prealloc(struct blk_iterate_data *data, int index, bool *has_prealloc);
 
 #endif
-- 
2.39.3


