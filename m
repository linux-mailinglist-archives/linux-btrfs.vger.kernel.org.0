Return-Path: <linux-btrfs+bounces-11045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206FA197B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D13A9154
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935D215054;
	Wed, 22 Jan 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="am1x3a9u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b+nE8HWa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CD4A18
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567060; cv=fail; b=ePOlyaGXrkzbHi/v0GqGA2BaYZKGIj9koPLjrT3iqcrPNZm/xPrQOIxOLYmW0x/Nh7dia78nvhdKcJoHAAHjbD8xjES95KLCxtzC2bffB2nh/OGaQIAQYxL9aQLeUQURfijz6BPSE/zcDMz5IJCB58djpRmFIZFPR1hgrBA8pzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567060; c=relaxed/simple;
	bh=0fe0JOzetD3aNrM6FVGG+BFSRDqSl3NQa89sTJc48jk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hJfctNvjj10KZuUQN4xjiFjYNIHT847zbDh1DpRbU3h5y8L6n7WVIniMzRU3qRY2H4y0E/4NgHuhcjGLNcK/YslWrRpCqX96D9RrDiptHyqBbe6M9C4oSOe3Yq+FOxiiWkmAcZOrShJ0GH+o+9jFW61Yj3yQ9eerUnvo4LxNe3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=am1x3a9u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b+nE8HWa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGXgCn010935;
	Wed, 22 Jan 2025 17:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=DZwlIlf9pOWj6Qmw
	0bK0QpiqfPrcqFmtaHYoG6ttw/8=; b=am1x3a9ujNNBajuVbuOZ91c8kIJDAdvI
	NIYZvlfVhtpGKXlANdKqo2jureXyTNVkjwDMCDZEeeZ3anJurkyNxvQ6Rtp6ZoBZ
	8rJ22juKx5ZeZ7VxZLRUBLnaOWdZgUSx58+J2hhiWzXY4GfH1srTh5L82QbgX2q+
	3qPyF4WCJ/I5Mk6l4/JjXZep3eJJNtGz1yRo982SYb8oC7+Usol2SuskkT09f0Fj
	R+7Nu7dmsmhIsq54VHm9cuHNnOVmkkmjsBZMCakH/yPj07rWjfFm0DmjT3amqcaG
	jloqy2fke9F80fwWXJB8/73awRnB6xsdiWCTQ7lM9bjAl8hLPLlLcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx10qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 17:30:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGMHqJ038242;
	Wed, 22 Jan 2025 17:30:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a1kx5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 17:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEY13AJjoAmnVRlwlFiCGi/bm8ye5SD/uMBzf1P7qfTyqX6FURt5xreBDd0BzeyblYIBHDE7OmOPt5maEzoGJE7mumflPObehZWxV2M3xnIK7zgAq0AS0nBvlHHF7fJEIT3RywKdTEil+J34t+NLp4oY65yNXUGQr02nF6YBVv/B5M065F9uCDTXZ5MT3A8eTaYeJbjno3BPoumbjhdEcoACysAyZGYSKOK5pzYSTLz86zZbkqN/GDwd6RRFxgEWtdPMQVJZQhfQGAB31K8ur47ZKevv/js+BQ7eQDWH4su9pO2SyfiijGG8cQd6UmBtVlXSvXtgimosk4UVp/BJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZwlIlf9pOWj6Qmw0bK0QpiqfPrcqFmtaHYoG6ttw/8=;
 b=eqxJiS+Ds3l8xr8YiViIPFg+5GfbQSkWA2UcgLMuXUn+Y8HJqeLBqt7QB6vpUK+c9g9TzHXF3XADQHpKtqUupQgZMc3tA1KpuqL53KR2e/yoL+B9ShjjqS6D7TFzhcnpiBjz6YOI7cVoSRIt16FU1yOCrhtpXb2+WRWbFb8uIolho8r3EmQDiuqIXzZ8Qp/RyQ5GYRVl80stIw+3GDukFcMXzzRML4XhPW5qKQ5pm0LXzkgJoLUQ9EIe6K4hCpt9PqhOlXS/9+GbdUz/ThfvLnt//UYe5trG/jQPaViKhH8DYWBM3GBWo5gos0Gg87EV6oC4s4G0f/KcWKUQIgS21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZwlIlf9pOWj6Qmw0bK0QpiqfPrcqFmtaHYoG6ttw/8=;
 b=b+nE8HWaVTpfi+XCRssQ0ZORRhoCz7qkU+lFatQjlNLBcbj3uxMLDbdwscpMRONmq92XXod8mLCe9T+ppyXmIePIWyeOMAETM9Womk3aCiDFSOplcNOfNNbACf2zDWJ63JU9TYKpEq9hcKTDXkZhp/dKbfb3CekNCdxrlTk9Ees=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 17:30:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 17:30:48 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH] btrfs: sysfs: accept size suffixes for read policy values
Date: Thu, 23 Jan 2025 01:30:34 +0800
Message-ID: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a40be38-91c4-4147-0c26-08dd3b0a823f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKxBA1LHxWMTn9ODB+Z4W5WL9GPt8VAkN8F/oB88PwYuqk6mko+IaHJivzNE?=
 =?us-ascii?Q?tGZ7LdqMlsD1LKsGW8svapNTL+WQRPuQtRyhuMohtoVDIc9afe/vDbYLQA5V?=
 =?us-ascii?Q?3ZwJ3I3ungeaECr7Nb6+cIUUyz6SJjwlSldei36P6w5JlHsgtq8k0ysXF/H1?=
 =?us-ascii?Q?FCJrKY7MIGlqsw/u9tYZhFTx11ZjQFjtphb2eJ3fLU0hxSC8MxG5nT3mUkLh?=
 =?us-ascii?Q?KSmvBR35aykOTXxZaGZ0LcoWIhKO7eYVJvaYzGKVqxzLvucJuRVt1URNsdVY?=
 =?us-ascii?Q?rGkShRX7b+3/75DJO4HU8ho3BGZLa6Ha0v2km3LIOb4Ilrp5ERAa961KdcAx?=
 =?us-ascii?Q?23gHR07lCNSPsG4BWjNvQ1cy9hEtqFvE3onxjjvBG2cY80gItkqtkaHAnzrn?=
 =?us-ascii?Q?MdKvBiZCaTkERtKsvDKwyBvpLZAV8nT1zlrXQ/kU2mF09o7bccDVB7qpqzzE?=
 =?us-ascii?Q?TIkyqOJURntC715tc5STiAiKdGqTzZ4C/2iIw0x/0oe1Asv5EEeso2a91Giq?=
 =?us-ascii?Q?S8wW0Z12k1wMWN4mfqZM/as4vGDgTShSFgVE12RP41Z5Tady1Wmg0CicyDV2?=
 =?us-ascii?Q?MV0CLkVYb8LBCVGHBRLRyzhaoU9lw+T6hMKMmTKpgozuTGBFfUJv8MOiUV3a?=
 =?us-ascii?Q?vP+wKlcnLLYRaBLZ665FTivwAyT7tNz8+tTJBt068PvG5gf4aW6qI6rQXIuY?=
 =?us-ascii?Q?+xEUJyGqrk34nDNykQKdAOREw2GT5ia3B9yl2vI2k114rqlJSGkYFtd7GJB3?=
 =?us-ascii?Q?ygBaca1rBqGVHV2uhiayFuW0gWyWDOPC+865XCWfjado9gfqnuLWp4T6nQBj?=
 =?us-ascii?Q?I76XYIbZ0uYx50okarKbu9h5huwitNFpZ+POGIaz+nrl5LmTYMtGcBqQEZ1K?=
 =?us-ascii?Q?HwLhm9BH464TfHmhlTYi+NnrFMNlPqbFgI+S1bI/MVwvyOMlwDQE3GLaw5pL?=
 =?us-ascii?Q?NLriEsIGXvgsW5TXxqgHyvOj12PdNMkTX4Y5n0iU0pFQao7Vnu7kjBGsYfdX?=
 =?us-ascii?Q?P/9P2yQSxbSahw0KgTYPC/JkRFgmmpd6aQe6d7wUZEUjPbbFG9EHxn6xnZG7?=
 =?us-ascii?Q?hkUOsPNN4wgnKXL9zgIBAil0U1qZxO9M0rScdpPwTPdTshInpEApXotZDMK4?=
 =?us-ascii?Q?RG25n73ZdfuBFNBB+x5YY9gYFb1/Z9LqOJLwpTKUjipUygyLlEN6PlejbTAl?=
 =?us-ascii?Q?2gkoKWhMWE6vwQCekovWiE2yw+FRNbMeC7u6nXkARc7QNEhgMR3nuYoVUmnF?=
 =?us-ascii?Q?ZV0GkGIHlYb7gv65Uc4iQLvHfwruV4qojhALQkiiBUUkwERPpztoArkzFgWX?=
 =?us-ascii?Q?lqT+WZwOXnyCSQXUVnnzEVYmWmnFBo4eJu1t5CZR90ePnKFpjdYYNuPFZmbV?=
 =?us-ascii?Q?3bjZVgnUzn6SwvBNQxjNgz54GLtI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyqCZFS8kL9R/zmeYuCRxuwDzDJdLTQNHXWkZsHtt2Cc5qM3B0wvMce/tBNp?=
 =?us-ascii?Q?Ur+rEv3A70sl1KWBBVHFh5Uy6sOhooi3JyXNcek6th9bbYr2lyFX3svAQsHa?=
 =?us-ascii?Q?tEYvGTuljsbJyg4GOCnb1imUmYmbbn8lenenMo00SDUXcsbO35ktqiXPfhj/?=
 =?us-ascii?Q?kx0tuzrMfNeuZleOZEVlXSvie87oKkYpd1hWCcKnqIA9jNSotXMHoTRin4iA?=
 =?us-ascii?Q?pmEtAp0QPl1Hloj3ulO6L68K0mV4PJQwifwaPRgr0cuk4JxeKFTIzDaEqz5f?=
 =?us-ascii?Q?FbSwF+n4ukZSQuxCI0JCAWSUOQtOjjqJsX3AYqtTmcu0BDUHt9AFilaRO8AO?=
 =?us-ascii?Q?5CHJAtkiQBfj1rkp75WFZblDLkS3Nu7VOID+gfc5oB8B5+wWZEDU2mxBjoSc?=
 =?us-ascii?Q?psbJ8sQOk6WIoboJGFyI3dpYmtrw/yEkTOHbt5yzokj4C0GEPsup2pjt+kvL?=
 =?us-ascii?Q?U6ihyr/g6s/tXuVd7iOWfr+Lto/N79+kAVtmVJ3OEF5K2MfulAC0+eC6Wih7?=
 =?us-ascii?Q?ivZoUA4JV2NbTa6lPvK1j7N+hOQcVZBtduMK1JJhNPgXu3HTxPgLW+MQmrxA?=
 =?us-ascii?Q?LmYVCbGH7cLmIvgDVGvty1LmDY44kL+5lXaBjZ0rDS5UWg8MEktwkEdqJ1Yt?=
 =?us-ascii?Q?lEyWoh7AOQxRSuE9z/BxR8kdSmACj2z9tBtETDTmfsOy2JShz68mEVwYQUQ5?=
 =?us-ascii?Q?6qtGayL8waPjFrxfF9KNp3pANGUg2YL5sukxa1vO2M4KDUOEVVfyRaDlWubA?=
 =?us-ascii?Q?UX7ZBMyXd3ymxZ/VEpCBmQO/wqmoIMzgy5koNT2ArNuQgHQWzLzyx9Kmem3r?=
 =?us-ascii?Q?WIBuYkdCPzDoZyM6hjFdf2wy1oCGq5Ed667z4ULmvUQVkMegXPKCS8K9jFD2?=
 =?us-ascii?Q?WnAQ2HjmwZgI9XJg38w6DmWDayXDrx5cyjkXsKnqtBbmUG8KNrOO/TlUcz2V?=
 =?us-ascii?Q?7Zy30Q1NvsUfGc1mJrSJR5BXv38Ec0InMOLiKt9YzbqSOt2p6Z548tUxzfZv?=
 =?us-ascii?Q?hS3UZYnWvKIBU4slszLCSGSpWr2BI6A4gflCAmhYW45izdwyS/RjhmyaHy50?=
 =?us-ascii?Q?EtsU++O8M2Ck8bpzYRfabC3Q/0srzUNO+Z7BHeReMr8J09heh6OP1bqQiTMi?=
 =?us-ascii?Q?S/f0Efi9TmnJ6ssSPD57I3aXLnARmX9wzz4sM1BLXdM32v6eBYcFzW7sa9C2?=
 =?us-ascii?Q?CiIEZbNToJlOjd/xurw5JNrEFZmgeO+l2PkLtnnVBprnnf+f3Q6+SqwDvrSi?=
 =?us-ascii?Q?yco3RHcCl51P35G0J+YiFWw0ni5RFKlaQdy7M0zoDXNOLIJWHGIIiEwWeI7/?=
 =?us-ascii?Q?gGzxlqyaXszCBVaiIEiWN9jddxyV5Fa6GoTyQWAQVxNyUkhk2iE1ZfUNJen6?=
 =?us-ascii?Q?6lpsrRctu5ohtZsxFLoaUQE0Xb3tahwhwEBI8N38I8kAbmjEHtd6m0w/UkVd?=
 =?us-ascii?Q?mthWfaalzjDQdg+dProPF+6rlwo24KN5QGBZSuAxUKmUMuq7oDKZAXu6Y7ek?=
 =?us-ascii?Q?NJpkhWMV2AOjQ0741VdlSBh3fkybD33kIxdAWxcpe55LC2rim3B52w8kOM72?=
 =?us-ascii?Q?0hoBCtg4Uf/kFWN2Nrc4/A+n/vhkGVrnJ4GUCspP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KRcxi7zdBDolQGuH5mMsFDwkHZ1NNgqiO2xh84hCUBU+k/nGKLwJ1a0MPEa3lXH5RDm8feY/Q5T9pQd10/WKu6UyyUGPs0ym9mX2NkN05JMp1YwJ4w/jHdzr8t6lQpUnoYcqtr/8DU+Q7TG2yu5ftRulTNBUS47Kgu0PuUwZ8rY4zFwQ6tBV4SNO2Uh6GUQL8aA1VZmybhnfZQEs9vwk2J8bj5+1jnrWkUgoi4+Vq/HLzDggjKyqQRndYiodLVfOO6Y1+BvWt+jg7gYLMWmkox9OEwrPKWIZUrE0hnKGwGn0+AmpdC3Ut+KaKycpUAI6lQ3muoiV7OWoX5KZkWDMLfml9MbczI4KveaZ1IJ7M5mz0Xf/Hg11bQFeLgjZuR4al3LTHagI0v2lEIPc0d70ZLgwYC7v8iazC8TKYLKfXeDUuKJ92IjWvye9ASOa/uryFI+D40yT8k6xWPvwIRiXe/593AzYJ7Do5Zu1TLe11phrNW4TfcxOVem82BseWsm8BQYjshRki2DBAHu2T5W2ruRbW4UDuGmQ/mI/gFipE7/u+RS1Z0A1+mCMsAaF//PxXPq790AXtOx4WGd/Cfgxosx0IlVN4OFXy1cSxw1Ok0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a40be38-91c4-4147-0c26-08dd3b0a823f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 17:30:47.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Cx9If54pvqW7luT+99XpIPhflOJezJWI1I6icGXGVkDBihb7/yuU8Q3RCa38xFdmIhujDfPMcFHrkTUpOaong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220128
X-Proofpoint-ORIG-GUID: Cqam3F1FV8zDPWqf-SfOhr4ynWC88Psw
X-Proofpoint-GUID: Cqam3F1FV8zDPWqf-SfOhr4ynWC88Psw

We now parse human-friendly size values (e.g. '1G', '2M') when setting
read policies.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Note that only read_policy accepts these suffixed values - show() displays
values without suffixes, consistent with other sysfs knobs like chunk_size.

 fs/btrfs/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..66aac3aae2e9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1342,17 +1342,17 @@ int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 	/* Separate value from input in policy:value format. */
 	value_str = strchr(param, ':');
 	if (value_str) {
-		int ret;
+		char *retptr;
 
 		*value_str = 0;
 		value_str++;
 		if (!value_ret)
 			return -EINVAL;
-		ret = kstrtos64(value_str, 10, value_ret);
-		if (ret)
+
+		*value_ret = memparse(value_str, &retptr);
+		retptr = skip_spaces(retptr);
+		if (*retptr != 0 || *value_ret <= 0)
 			return -EINVAL;
-		if (*value_ret < 0)
-			return -ERANGE;
 	}
 #endif
 
-- 
2.47.0


