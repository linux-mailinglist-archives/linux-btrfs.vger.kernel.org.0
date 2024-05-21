Return-Path: <linux-btrfs+bounces-5174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AC8CB29F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AFA1F2262D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDF148303;
	Tue, 21 May 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bdTAnBJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="enSxOJNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E57711E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311563; cv=fail; b=O2YMLZBcbjbOY6LlfQ6dpeuJBsFj3AMc01UCq8TWA8qviMLJgAl7wwyZ5X3J91t9yEXYAAeH4abi9ItMMI8Bnku3dNQBO4hwFXfVbDSIBmd+nn6DxmVx2IEr0xFtW8b6BH474mTF0xX4GKooeitR7mBxJ3abyFvG/lEyt9330Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311563; c=relaxed/simple;
	bh=paIhwbwkHPbpUZ/4Zp/5PcxC0NUlCE/GXlG9+sQxGgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiWVj8QSKB/AYfNLSim2TMP2gcYfLe6bdj30fBTR/pXxYHe4je2TcTm4DaKdTDZBhvrq8JHGBfDMOiAkqHPkN2V/0Hfh2NIrPja9oKuT8By3hzedxfVmmgNkm7kStS3NOiz1i+q2S2MK48L4RhQQt5cLVnEjr7BewqdU79N4OPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bdTAnBJL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=enSxOJNU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGx5wB008974
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+v2dMCkXtmBJwXLmhyHqHQz2SkhyDJfkv6GubW6dXW8=;
 b=bdTAnBJLXetmoh9QIxFh8ty/8nRPOngdYQTquN36H3y0Uz1rTEXTLpjRbbg5TTEQ7VdI
 l6jAjoBBsNsUWfsFcz94iP/ois3R03ci6CkPX+fz4G6dTBu1sKpPjBWolbT0bXZujEtR
 yTDNHeeJAjW1/FmfXEQMvTquHLXm181X6rx6J63XdzFJf9QJQ32mCOUIfHPeCQhjPll4
 fAdy7qgfUYWsG6Scvu3TasyYYl+JTbMXdnK8S+neCDwOLEtxHMeobvGI7t9xRoEQmaAg
 UBsiHobBUN29TK0mtveSpWbMHg0GU4K84a9HEDjjO+AU1s2n44pOautv1btiu934Kna5 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdwxpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGfbZO004968
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88sfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRrAbPxkyyWoeUOwntd/7GqKZ+bklRMhC/IJcIlN0nChV37ZHKKFP6fOTY+GwU5oQRlDVaWCBvu/OClyRAok3riO3zj2b9CwWjqSrQdQB9g0NRLsF0cKOWLrkulV/PeFbCTzrd4XuL1tV7zaxQXu9kP2AmPkceUG6WajuP6yA5COM5p92DhvCR2QS8pg6eUkjMX1L+CtWatKsvdXUs/0P83a9oUEe9mtRbDTmzTMoI/YGpF4Qei/Jgptlo4dFmx9dBzDXoLO7s3ofQiNa/R3GUxFxh3XypKjDC4X1h/JnslbQPXfu7B9Z+G5pX+cKsYTZyfhS7S8I+pzPbxgKhMiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v2dMCkXtmBJwXLmhyHqHQz2SkhyDJfkv6GubW6dXW8=;
 b=FAoOH7gqW2+y6gFHjgcV9qAiN2gJn+Xnf3AlWDQdAFxpeiAni7XKfyfiq9ZbZETMDA11iJxqG6NcMWjcFhmPmGHhjW2P6Zzp0Y9Z15SPzhglq0uXaqVUxDFHOk+6EnveqbJt7bLZjNS20GCZIibtcZT0YNTyj/FBC3okMcmftkVG6et+E3XYmemwbihY0v6ZP42BN8vNWu3i1yp+WbBDvNrWvIjriKcxb5MD/IxSDcliNbw+KTSZQieeqk5nD6oAotZDT3EfqoF2M/9dhLU6AksBXkX7CZqqPD06+5sKKdbSuT7/5tTfsSlOMf1mRFvQWwn3FYRxEeFWj72qOd4KYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v2dMCkXtmBJwXLmhyHqHQz2SkhyDJfkv6GubW6dXW8=;
 b=enSxOJNUyLRyQ2pvjvJVa7bb5BaxZRTbjaXhREtvR8+C+zH0oGm+tLnEpAC+c3rzR5+PDNNchpfqCjZshfzB+DoZkchkKLbLI6UtP9n0f7CmzhTndmnuo9NG/+fXRTnp9tOQIwK/klNvAfrf6GTEimrwe9/1EJvdZnLVL9lGKCA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 2/6] btrfs: rename ret to err in btrfs_recover_relocation()
Date: Wed, 22 May 2024 01:11:08 +0800
Message-ID: <26786b9831677135798001d84ad11962b2be08f1.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: d7da083a-a522-4463-2004-08dc79b93697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LMwSr54iXUfYxU83S/DKCAFauFvEx07zQjylyVOrDGDDsSrKQkoqeJEnhGFw?=
 =?us-ascii?Q?XtOiWksEkATbVtVa21wyJPwnaYRIIxlqGD56WOScKChbhHYqj31XiP1ervwf?=
 =?us-ascii?Q?2CnFwUrh4uU8rU1GAFT81/BLZB30C/8XzDo6o9hLHaGUsAC5AVEk1Ga8HgI1?=
 =?us-ascii?Q?pUUBbn3mtGhmKY8PCsDgZNoJPM5aBUTpiPONByUCkLlfiC3YPVKHFEemWAfY?=
 =?us-ascii?Q?WNwLxxkLXNbtjimlPgfLGDW6b1zqKOsOfwCu1ZxVx8pIos2ntbrazTTjEL2d?=
 =?us-ascii?Q?I2iLdcmuFQne5Cb2L6qnE8JoffkLmunP0ROYnDUdVVFelNeUPCtROtsH1Hvv?=
 =?us-ascii?Q?WTU/13ZkbjSDNrAhYYzNiO3Tx8P708PfmlPvT4lXVB5Vk6B9OO3OlZW96cX8?=
 =?us-ascii?Q?G0t3IIf2jg07XNfgXk4NIYIe0ksX8vwUXQpjiyD3YelQHDlFWx6nDli+BBdA?=
 =?us-ascii?Q?WVJ1yOfimdrzGvWCciw9pA3p+ZuWwR0elWg+to6bn5gSB+pNOYQMLmlTze97?=
 =?us-ascii?Q?E+HHIWUWVGD/AMDezaD1nNN7Hro0BNjbVdaIZffSNBfPH8A3uWQjUThaavMr?=
 =?us-ascii?Q?CAgxGg38koUa8rom2rcxnjtZlUb9VKBdOQB0T+4OIiaD9xzFrvXthNXIAaMX?=
 =?us-ascii?Q?2nfEoJGNAVn8QGSBfZ7Yg5wCAFGgyC+srQKxtwUQ81ZLekDFiLqpwHZXxJt8?=
 =?us-ascii?Q?Oj/+3PFsk31zNaXkM8QDulpL/L9dRXPAx6P15eAZ37zBfjM1fxp/gcOLbtXD?=
 =?us-ascii?Q?NNlxCXbomh4ZmY0Af9h4xO6Z7whL0qiAyffjAlP4GFnY3rhvagwDgxCCKs4Z?=
 =?us-ascii?Q?eiswwlE7YgdV8sJWCd2Zk46U8+/tEQp49PcXY8xZsPWdAkpAUOdQU6VP3wwN?=
 =?us-ascii?Q?+av6IM0/0YBAwR1BvaDZ1n02+f4ZXV1Chm1pZSiRD7slGGxicF7oHWFSd7lP?=
 =?us-ascii?Q?2Zyc1iuWPMJIaKuqe6Zl8DjH2cb4/40AJj3o40nOtbMghNqj2RyQ+AxWc111?=
 =?us-ascii?Q?T2R5AYM319moVdoJnVKHXPjFiZv4McCG2eNoxqPE12thpzkld3Cpojl1P+SK?=
 =?us-ascii?Q?f+4QNrt5lhRDvF70sau9LrvTseDcFVN0AC4FNVtYgygMFjmt8aYLlNhtfTVl?=
 =?us-ascii?Q?5ZWD5xki1MG13GlPuwU20Rc+7jRJawsRx5ELgUTdB8ryHVr4qSckRFJeA2u8?=
 =?us-ascii?Q?oC80giA2Lc4F2J18VYPTMivN9Kn0qN+hn42GOAdmh3vdt08wKwdAhgYe/N/t?=
 =?us-ascii?Q?e9U8YXXlLkbn3AQs28zby0QaCj3pQbJMJ3p5iDEwqg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+SPoXwRsM7FRjOzjCq7MZVU5sEeCu4jjRv/84nBK1zE7kiuJHc9VBEThusVD?=
 =?us-ascii?Q?Ny1BcGxM7VFx9rKwpDPrcE3owaKaH+Qht5F87dJHXq0PgbTl2HVZau9O5Nas?=
 =?us-ascii?Q?R4gEhOseT2LnxgWjBOzQwemTHLRLB8v57EN0CudyvQutyCrexlzG6OR1bVEe?=
 =?us-ascii?Q?AT8tDrFlRCu9TUg8ZcfRM71Afekeuj2aaCyRB+TAloISWFQ4B32IGxloV6y5?=
 =?us-ascii?Q?rDQWzihNJd+aOC3FRJB18Q8l5qY7e2sJUKsqq0kjfs6kRMixMN7+xyTMz7qj?=
 =?us-ascii?Q?sJHaF0BtTWUKq5Q24JV0EdhN24LLV9HmMLYegNXHzNb7YpZdLiov9iCHVrRY?=
 =?us-ascii?Q?010N+f0OPQEcw3aKGI56WjaOn0OQnwp/gwRZ5Qkdr5aNh3U7Swli3B7rXMJr?=
 =?us-ascii?Q?Hm19jywGbgkJBbmxfLHcJ449wWhWK0f2paq6ROdyjRNPO/srbUxVgF4++/Eq?=
 =?us-ascii?Q?gdiOeyMi6l6rkOvZoIBLqmb9Vwt/XW/FGz/UwhIIPJm4IU8I3MVPX6G6AVoq?=
 =?us-ascii?Q?lNfW5JswXHraHMvsncMSHWhBgmLUmVc3BTpbKo7PJdy4n7afzvhDEGcr+fL2?=
 =?us-ascii?Q?RY6aFJWDAUb5VdphVahDkyQnB5/10oN7eMvDIeQsnmEguGuYNUWsnfnA5luD?=
 =?us-ascii?Q?NA5fYxfCoGo+9zzZ95Uy19wEgzE07aSwHsk3OL547QrQp0P9fS7v8Ubrrfu2?=
 =?us-ascii?Q?+4i5DTjddUaB1KNgKLbG/5ln5DExowpHdcYMGglrupJ9zYnVRb4D7yw17vcM?=
 =?us-ascii?Q?7bWHXvbtz22sRE6GDnTK+V83SWZlEwgP2dEsnnavHaQW/ONJYnhgYaE0ZaMN?=
 =?us-ascii?Q?dfzK/TmF9q96gL4NQ2oaQjIjNKCGzLQzDiTZ6JKQ7I3mGJij/94CH5OfdeAW?=
 =?us-ascii?Q?GzgiJezVduj2TxFJsUDiIlZVssxH/z0QNgcuoBioGJ2hw5wdu5H7hg1mD6C2?=
 =?us-ascii?Q?BAXl/jfJgitKXxsvqjgZifHMjLJxY1kG6ITL2W8aJw+gNO0p6vg5cdKVkpo3?=
 =?us-ascii?Q?pYyNdYsyzJtog7GyMDHbLjbHWfHT7Sdt1Pg1gPb5Idpn2fimG9Wk1CXaU2Nz?=
 =?us-ascii?Q?9KjlAJW6GmdpHrnrFoELNgth/tSG3T7g19Nv87mDch1ZbcaAZtpD5CwLgFmb?=
 =?us-ascii?Q?LnZYU1dFAbxSYdXXS5X4GoUbP5COCKtqBQfMkHxQsRmMTjT3rvArIfXFaCVv?=
 =?us-ascii?Q?s1HmnglaQFqdTeQskECm6WafqiehHFqLMSR14aIg+ED2i6CDLX16VnmxBaLs?=
 =?us-ascii?Q?ts+ihVWfnmdKTZM/di1Qi75XebW7sHDAcE7DmW7i19FQEKg9JGsMOfpH481K?=
 =?us-ascii?Q?pRbaxvcRXiiU72+xbEuupxwfq6OasoqZox45UjQ0EJTVIvjCOaDenQdIPcdK?=
 =?us-ascii?Q?1LjqIHd3p5DgR+p/eaTSUyzA5g5SJcCsXP9alyE+33S7GgxihQ9/9g8Kqa0F?=
 =?us-ascii?Q?pOardLy/rJ5f7rrRuQ2E1wBN7Yj+i3ixZkOdRJ2WHXWy2qg4iVHOVIg2wzwC?=
 =?us-ascii?Q?w71+kxO8+D0vl9VuB9qZH2oDE4ZopbdremUEPcyxd2iPJ3/d6VzeNwbwBa6/?=
 =?us-ascii?Q?yDcGm3XwRK/b2E8o3TW/Iri5D3zSWGdt464MLl0LabLdQxyQq0PIrzrGSfOs?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c7nprt3MyOHeJ4QNMC/DnfrX/YSBkJ5eS23l0uyiOFFzMhgS2GeSQxKfBV3s9QvoIxhF0MflcHloA6Wn/Sej/ekROV9SnAON+XrrGWYM+sqlyLidDZjrtoF9cpaESIHJGoRNQN8U09hQG2Bm6PPg2XstoWGP/Hr1ATi31oqJZ/XMi2lK9I4vy958xEgVygQuz6WJCoUtLf43rXZ+xWYz0DM2d4x9mI8PXPJUTynrcb8BJLgeQI7SQVvAbGWd7QLYdcOHBEPhZc/N7rtEqAaUPYFI/UjbQQ3yDx5XEwJHcW8XruKNYcMHaEPWmB5I1+6ui8YcEHkJO+t4+W3sdJTo8dO0zwmn2UTV0rmO0/rfDjBHpl8GPAU1LgIbJ8QktbgBK56tXsWhamDD3F0WvnXYWg9YdVwqaeJYT17chsnkcwbs3PiPpMx8GFLFnm0yLJusY3G9WU0SiGTMLJVqLF7sjY+BndmKrRjtddzDSdj0YKPQ1st3YGa1669+VSaCLbOxe7p3HK1DiBwTz7CKGp8W1p0Fyxo7LmqxPOpL/A06jYO9cwKhY1BJ531Hxcg9w+eEtu6lEXubxud690nxpL2gGT2AuM5GQIiRYuY/HKKqOzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7da083a-a522-4463-2004-08dc79b93697
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:37.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLOCX7R20lt+/Eoj/4yCFaGeZ1lcozRI2PVsX914mtQ5P6yQdus06atHqJ6F4wEq3FUB6zRHJtlHkeqxLB6DYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: INQLLAvkKZu21Q0J9bj4bVrfVFTtnLL7
X-Proofpoint-GUID: INQLLAvkKZu21Q0J9bj4bVrfVFTtnLL7

In the function btrfs_recover_relocation(), currently the variable 'err'
carries the return value and 'ret' holds the intermediary return value.
However, in some lines, we don't need this two-step approach; we can
directly use 'err'. So, optimize them, which requires reinitializing 'err'
to zero at two locations.

This is a preparatory patch to fix the code style by renaming 'err'
to 'ret'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: title changed
v3: splits optimization part from the rename part.

 fs/btrfs/relocation.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8ce337ec033c..d0352077f0fc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4234,17 +4234,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (err < 0)
 			goto out;
-		}
-		if (ret > 0) {
+		if (err > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
+		err = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4266,16 +4265,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				err = PTR_ERR(fs_root);
+				if (err != -ENOENT)
 					goto out;
-				}
-				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				err = mark_garbage_root(reloc_root);
+				if (err < 0)
 					goto out;
-				}
+				err = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4297,11 +4293,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	err = reloc_chunk_start(fs_info);
+	if (err < 0)
 		goto out_end;
-	}
 
 	rc->extent_root = btrfs_extent_root(fs_info, 0);
 
-- 
2.41.0


