Return-Path: <linux-btrfs+bounces-12638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB86A74209
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 02:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35487A6062
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA511C5D7F;
	Fri, 28 Mar 2025 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HNhPoC3n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KFwwuKbk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F414831F;
	Fri, 28 Mar 2025 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743125213; cv=fail; b=tBx8UU6D/tGmvXJm+17erBwL9gBBoa+jPTjXxztUcbleoA5TYnZD8OQr0W+7xathT/whp0jr5HiirukpvzaKOGXP7e6yehuBJY06id0XNGTfL+HPWmnGPfflpfvZJTrdpsj43k1CzTkt3RbUNNre9ntV28rvCQCXPbqMiYjGLp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743125213; c=relaxed/simple;
	bh=K64SfGlQJX+whJzXbBuoG6Ej5c4/qjC3QBouusLCjpY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NptkfNiBdrPHb6wjjqsuLbIa28Ops0bEMfUHOjdik2HAW9qxVz4j3M2igcemk7CZGKx54AhoMOqYojNNnnf7HX0EescXb9VaAphKQ+WFD/LcoXII/cHbyRuHVw/pZ9D5Kyqyq51pDQqEHOpHBAwb7hnDwWbOsL4st4qcWTWAXsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HNhPoC3n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KFwwuKbk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0tvTR016999;
	Fri, 28 Mar 2025 01:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=CMG8FnyWtuGZY3Jg
	bZ2qpg9Ht5ffEOr4diUmF9BLfuY=; b=HNhPoC3nCsFSQfeXbvKhzIw62BpqEdX+
	T/xMENW86IaiDvc/8SNxlXx1Vce64DmMcUC3E6Xzp3JdW5y4+d9P0sR0DLvTNLeP
	dBc05O+LZ0YmiUik7tsQWpw7Xx20akoZyPz6c4OrxSRmVC/q4EjkQ7PUEMyFkubA
	aJHI/gEbCvK7mGtIVHNcqBaVkbGn5QDE8esxqgcEEbcQ7LmLgr6n3ww6gsT1YOMJ
	RgDVdeprX+MBEVLqi74AQGufMgpQtV8nsfJjh3vS4W4PLdBa98p+ALrSMVIjlxY9
	JF4gcC5f8tTk5D2IZxtXqsSNxvD2JLx9TidXFcGEiYOjlutPYC9MYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5mdyga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 01:26:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52S15OjF008226;
	Fri, 28 Mar 2025 01:26:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6xtg81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 01:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsSZgXa5GpitQqtEghV7UP32OZI1LDNUJJqPzM6ZU6tr4Zju1/3jU4Ri1aH5FYnZBS5/FAc988cW9skK3jG58sexxR/BSmlRa0QXKDWKPzLcz03KiEblyMYJxYDDY5jf3Kf/3BVoWFl4+0NgBn2I84zv/ZoxAhZ6wqdh/zq8cikMYLGB3Qq8gpEe+eqN6013/+BpYCdjWzCUasZ18OZMR+bGpulgAY9BPTpZaeXOF6DzDYtidZvtSsNDKhD42jsj0KJdcdPf2PQo7E02x7qU8wfAoKQFj0P5TulxWKjrsX/kojS7c0uNH2ubtpu4lv2RcAeF8soUWWMbB4+bxInG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMG8FnyWtuGZY3JgbZ2qpg9Ht5ffEOr4diUmF9BLfuY=;
 b=ZUmzqMs6lvS7/z47kf7RFxYD4zcmqS5S2xmAEdOStp8kp2dEX6XN+bh1af969UhYutOevh4g6QxPfxSSgKRp/nS0/1JpzorlMuz/F6NIotUjLTHCauqlT2i63NeauxcjWpM/jgXUD1j10GF0p7L4rUwGKs1V9EbWNdKHu3bKzULy0BtwewId/y68F06xUX2zEsB/2XuEwqktX9UrPF3D0hbbj9al9Chj7p1Z+o9YqCDf0eRWz/usIC57KwczbrmS6fWayhSPzl7YVYxTN8jGJ08y7Cyk3zy5f5sGi36CsApxmUMRpIyEkWc+XRHRPr51out7D6ag/jzBrV6T2DixFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMG8FnyWtuGZY3JgbZ2qpg9Ht5ffEOr4diUmF9BLfuY=;
 b=KFwwuKbki/uqAHBx0QOD/R9lMrTNqlzhYvIIoulO1vD3HRx01g9b2qtccPxbGnkqY7IO5PDTbqpqVZ8hmDHIp4zPSIJ/hrCo7QNc0cvJWlsLjkM0m1VN3mTl3iUiADhNUD5ezo8R6IP5djPmDQoQ5vburvg4im/mzFejJOt5cFo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 01:26:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 01:26:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
Date: Fri, 28 Mar 2025 09:26:24 +0800
Message-ID: <20250328012637.23744-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: ed29a17a-c588-49ea-de05-08dd6d979a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LBMsHuU6RX/+4DH4PrC+SpFYJWzrvBKUCmW3SYg+XWcB+QVP92C98ods73n8?=
 =?us-ascii?Q?sozPM5MpSXRoGcaQZKu4ZAKNWIlvIcZePb2MhqwUAivymEVbRFSOOhgwNb1q?=
 =?us-ascii?Q?NODrM89QWa59urbJrza8NdCAO0c5pYskvgSswr/iyEMQewZN11ox/VlKvlE6?=
 =?us-ascii?Q?yRmnvR8b9/9x6UL+GQuIwXoAjbNBHS29obznzZz3JYbeYPJjoT0ocrHGZQjt?=
 =?us-ascii?Q?SIAW7EJju25qPrOrPn3vEXWu03bamMdwOEh+xASW3IxH15iFDRI5+TQPaIbJ?=
 =?us-ascii?Q?9d9BnjRQzsHgQnH3e1YaJSGqvbzkIVg6PQerkrpKfnQVBaEq4RoTaYJBJ3xG?=
 =?us-ascii?Q?c9vNjzoJ5eJ/4ib3tTlq81JJA41Q2OrXVaLreTE4GB4DXwWCD/y9zrkvPal5?=
 =?us-ascii?Q?YoW5O2LQ4mPp/0dua+U7XDOMA4wPUUS/efL+sSixHJ219eRbJk4tcxzSjPR5?=
 =?us-ascii?Q?/P89JZxos4e0o+belc2g9PXuGnjAkACUCkvhbHk85bQbn+tsvTeFyNv/288/?=
 =?us-ascii?Q?xgtjjN4VymIhCSPj8CvdHZxUyalW3Jujn1jbGnGHmrQEP56YMUMUeQ2tke+z?=
 =?us-ascii?Q?kXJgj0WVlmYzSsNEf9uJDjKmR5YHQxjY341Gzh8Qh6vds5/E1P/+c6+GnEDm?=
 =?us-ascii?Q?cX6+N4H98EUSm54MDvRWSJR5EIQ/bVZCRfUeIN2YyYj1fRVA5MmyxnuHw8kF?=
 =?us-ascii?Q?qIZxw+IAIXqR1dJxowBq+OknrqbZfIuXTOpcGSA9NisD1pvlSFogbfdiGCvv?=
 =?us-ascii?Q?8PJKtfc4JskR/uwOvyY+EETwbmjbxwRf2935fZ5Ux7+jYe9du9I8IARA62DT?=
 =?us-ascii?Q?sCAoO/5KkXgbvT/tKOskyQfqoi5Y5p0y+ehciNU2lZXut7rRCmM0j0y+lHzJ?=
 =?us-ascii?Q?ibRmonv8PDS4xjnr2muuHbLZzO4dO0eoyQzKypzh2as0Tr+00hhzwQGD9swW?=
 =?us-ascii?Q?7LAIg7215EZCu5QN+5AZrkYvTXjLjyZuyXcjd1wKz7I6f2aIsRZRLUCtQ0n+?=
 =?us-ascii?Q?31vIUew82Fo90Ue6gg1/73qYzpGTCYzoSzSn+qO2RuJ/0Ld2Cc5wfm7C55sc?=
 =?us-ascii?Q?rwz5SUsDIFiV6wodtc9QYD/dFt5+CBnb2uFeIHWqMvmvkpkuyZNivb/3m73j?=
 =?us-ascii?Q?/nw0K7XCCH4DRsuYEPvb0sjJRqJgBe0jJTrEuJOVyqpaH/MiX5ngi/Dr/OQd?=
 =?us-ascii?Q?o1Nfy9eJQ/ln1ksWz8PoDrf/LdFj/OxktjiKXCZe4SUWEU4N0Qz25AfcxVr1?=
 =?us-ascii?Q?+IwWurRCkv2f1OJ4ROvVIsC2N5hFkZIkJFkXKiVqFX0GKQKzTciX7ry3pf9V?=
 =?us-ascii?Q?Acja24s8m+Yd81855we0+m4zCzMHuQpcC4/eDWpL2Jg9n9LHCAeIioJ3MDbn?=
 =?us-ascii?Q?YcS60XCCVU5xh3rqM5gNOHQVWQf9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NK0Clav+bUZYlPifXkMz1Z3vMi9aghyNhh5cP2XsnKC3Pd9dpzeOQNrHWXLJ?=
 =?us-ascii?Q?oL3e72l1xjz/cgd2E3GBIemNd7Bxd2Ylhezfj8MV/79l08rXI087ZExT5wUE?=
 =?us-ascii?Q?AyXYQqk16g6yGNOnCLWqaI95aL8e9bD//dEJpMk6qzJ6pRJa7qWuDqMVN7eK?=
 =?us-ascii?Q?WJgn+5bxci8KEsf3GjISTt87JFa3uq1+JJY4RFVWr4YVYt8T1NCaymuCWDP8?=
 =?us-ascii?Q?gWWUXHMVINQvD13FzLci6/K2LEAb01iIHL5BiNhYNZlKYU49hgOOqRzCtYyM?=
 =?us-ascii?Q?sqkMkEj+xVTDOr0yoR0EsEjFUA/sFOvkPLDYMYf4Vlk24KdS119hVkR++VMW?=
 =?us-ascii?Q?FjjSM+AMhs0+7HnRRZJ2sXllcdn4gjL6daSrq6saBQ6eiIxPDGIciEdfEl6x?=
 =?us-ascii?Q?wNfChT98EO8jhlxbKv8jf+g1fD/UYYmJHhVOwtBng2nLnLUjaLwtjIkBCgMS?=
 =?us-ascii?Q?70ft2n6eeE+85ogvvLNOSb02ud1f/O+VrOJ3bdieHTtp55dUJAOiYiQRTT8E?=
 =?us-ascii?Q?0FS7q/NUXY8zpIGXr+CY44D430Zc3uJvzAI41P6U+2//P+URvoinNw7Ex4AA?=
 =?us-ascii?Q?L9aPHCGFOz4jiPGkhUJfGehOz3KIVx4U3dTZq4X9CQRKCOJbDjzSKqUOj0Y+?=
 =?us-ascii?Q?vu7X7kzPOOjlExIBkNTSsS3zYUMMY1bunhWsuUQ9Ff1k/9I9uIH2wRPiuaDD?=
 =?us-ascii?Q?QsK/oSP2nAZJiwYBcQCR3mEOu8wmdkEqCvLqQbz/5691N7K3FNVrh1tO4gqP?=
 =?us-ascii?Q?5gJVPuqzrVyASNlkyB20Lby1f3KFEE6K3dKglF6tzC56YtTT+0JI6JNkl+PU?=
 =?us-ascii?Q?pKSHxifAC4URsmVPPrqItWVgHCNt2OyInoz9eXD1pbtYzpHeVopjrbvHKIDX?=
 =?us-ascii?Q?wIZQ63gBpvg8FtZ7OkPwitOZUXx4DwydpaSNDVOyUqHSdhXM0GFZxYQ92t9O?=
 =?us-ascii?Q?LqXRVaIRoeQdbx8h46Zkx6G34KAu0dF82fnw7cjDYOIjLg8XVFroH4rlq/2p?=
 =?us-ascii?Q?LFrf4ymw/IqsQTD01ytQJV5IDPhD8qTNdOFTQw8WaC7AFwZALr+sVn3vu+7B?=
 =?us-ascii?Q?X9FEogKBkRO69NdT7MR8Fr2ZXMmw3mAGitfOQvzVNjNgiRudGM9qFBJtV3AK?=
 =?us-ascii?Q?4kuUH71LMBF+pjSmDihg+BmcegDZHtxleEvasPYrAPeRiIRFbbbvuh40NBQf?=
 =?us-ascii?Q?lWR4D8BdMEkaBbC/wb+jsnQd+LeHxnFbaHdRFJ469sZfvClh019r3WJQJx8G?=
 =?us-ascii?Q?g3IxGnxrYZwjgET1QqeLYJc0xdmt3iXkiTmoTWcyPEufovxJUPTtt2mPhVrl?=
 =?us-ascii?Q?cuhU6MuM94WBSbzW7npIc3ouAv7bFji4foDxBUXRF9kcUiImlJsAiDogI4W7?=
 =?us-ascii?Q?3+QKBC3SPIZlvcgd6l9mCShXUev34k6JrAfk9Zii7eCEr2yMy1N9zm4Dxn+5?=
 =?us-ascii?Q?7hbTHhT+ug747+d4o25KdU0w2U7TKGzkYpT7Mwvtq0p96nulreJiXO2mVcUT?=
 =?us-ascii?Q?UZ5IMOOLbaYLCZqx9PoAYAug7WGsjbfQQlO1MeFNeXSm4acJznWQOa6NtCaI?=
 =?us-ascii?Q?8WD5vYj8TM6v4OXod8jUQTz2aoZqvAFpG3TzYTAz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oA8G53gtTmbXgQQDGPscLioPTp8qi9IYPzINcFQoCoMmPPuWaoUPXTOnEwhU8YesB6IkleTXl6zed42rbIhp8aY4gcjemon4heD+3fVPCTaDXSb/T/0a/np6L69nzvEUJ5NUvCHCrnvX6dUGJITii6mS193JCR70LJCCo+hoLecPv3XG9lOpc4pCp8q6EYgCywh8R+t1fT6W5jTx1Y8tC3rVoD3b3eEjpVlUvFt6511oAz0Tik93DqI5v9jNtpq3hTlQzqDKcZPkpqy2PyPT1beKhlJ5jYSi03a6nCm/SJ2PWuk/BkeayGp0QiFr3mvrplWSqi7iHG1hcjLd/09DuwdL1/uLMqYUHonm22QzFmk+ANp6LDxX7fw6p89BF9Gw+8g+sIzpdoQwOYXTBuOIBVuaTOXiGmNH2nML238UIxc33YGudAmTQxoebpb9zZSbKwuzb4mnEJQ4GFmcXbyVj+LLjVz5Sx7N3YxFIx4tnGvWXTKU9abghqJAf6qDvTJLthaBMpC6mcWa/HVdACI6IXd2njC1me338C++XRW8dtRTQrP/yQvBgFIzdg0fl+x/9pxCbVr3nIHjPG63ovmwI+rArQGIM69QN6R1c+0ToQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed29a17a-c588-49ea-de05-08dd6d979a74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 01:26:45.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlL039z0Z+QoQtE/Zv8SXfv3VfpZN9+glcUKJXFyeeL/AeqQe33MGiMnSgDj7BvLJEFlDZeSuJ8W9kqGqaM4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=886 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280008
X-Proofpoint-GUID: KtKmKE-0YHF1fdYzq8bnJ3mzXSxovupw
X-Proofpoint-ORIG-GUID: KtKmKE-0YHF1fdYzq8bnJ3mzXSxovupw

Zorro,

Please pull this branch, which includes test cases for sysfs syntax
verification of btrfs read policy and chunk size. v4 has been on the
mailing list for a month now, along with fix from Filipe and Zoned
testcase from Johannes.

Please note that the commit:
 "fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch"

has the changes discussed with Naohiro, including his review-by tag,
(which is missing in your patches-in-queue branch).

Test case number for above commit is changed to btrfs/335 following
the integration of the sysfs patches.

Thank you.

The following changes since commit d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe:

  common/rc: explicitly test for engine availability in _require_fio (2025-03-17 00:43:12 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests/tree/staged-20250328 

for you to fetch changes up to 208a7f874df38bf873137d00634783422965a7ab:

  fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch (2025-03-28 08:25:55 +0800)

----------------------------------------------------------------
Anand Jain (5):
      fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
      fstests: filter: helper for sysfs error filtering
      fstests: common/rc: add sysfs argument verification helpers
      fstests: btrfs: testcase for sysfs policy syntax verification
      fstests: btrfs: testcase for sysfs chunk_size attribute validation

Filipe Manana (1):
      btrfs/058: fix test to actually have an open tmpfile during the send operation

Johannes Thumshirn (1):
      fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch

 common/filter       |   9 ++++
 common/rc           |   3 +-
 common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/058     |  28 +++++++++--
 tests/btrfs/329     |  19 +++++++
 tests/btrfs/329.out |  19 +++++++
 tests/btrfs/334     |  19 +++++++
 tests/btrfs/334.out |  14 ++++++
 tests/btrfs/335     |  62 +++++++++++++++++++++++
 tests/btrfs/335.out |   7 +++
 10 files changed, 317 insertions(+), 5 deletions(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out
 create mode 100755 tests/btrfs/335
 create mode 100644 tests/btrfs/335.out

