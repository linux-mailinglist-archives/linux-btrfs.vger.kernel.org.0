Return-Path: <linux-btrfs+bounces-13942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F7AB4304
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A449B178AA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCC29ACC7;
	Mon, 12 May 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DhDiB0SA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JkCUGh2s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEF1E505
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073491; cv=fail; b=Pz22C7b4BedbKFqBVMxZ/Akm+rZZMdDhTgmklLCSQCa6eYIPAQrMn9VLPasqZTZuHbNVdk03+wHiTad4EqDnAAjuYCQ53k0glMflVT9rjwKEtTB8Rn0ITcskrNXIwQceo83wM28mslPAal3dfjpnoQIxXpwB2jH7vV0GcA7XMZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073491; c=relaxed/simple;
	bh=PEd7BEIZDbdI1F7w8umJ9YL6u9o3+OUHUajg1Ej8U/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWAK+Dwyi3F2JFhOicqWZ7hWv2f50mk/wSr2gn2NTyHsPWtFleNDG3Zq+aCaZ7JkU4yjeHQz458yJskxQtfLpxT3cGqRumQET51YXxyOZrIRVwgE1ae9sLk0Rn4fIsYvApbqBa9z7XxjybYhF+w1iSUrzLkW40sWBY5F5pNQzSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DhDiB0SA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JkCUGh2s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tLN003941
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WKny0LjskEcHLK1HKWB8aXFUmjxSKn76vtdqE96lRKw=; b=
	DhDiB0SAgaW/uKCO6YUl5b/hTZyY5Uxg900lv50+E7trr5XE+7NS1F6PveY0xDYs
	GnAP1U6WJ4/ZowD+yuccLQnaZm4u1feMjLDWpP0q1p8SMb4gaeWfygq8y3KlNPEh
	ygjZW/6f1E6xZTKSNaVj9lJOKbPg6LXK3cSYMXCamkeQOb+D/YYxTFcR6+Y0M3eE
	ucmddLbYClHcd8tCrJteAAM5xpDL93ebAb1DG9mhuyl6gX8fGGE58VRgLObe9zCx
	ZTUtnzf0t2/MTClbpdgEGUHAOX9nIRLWEcbPNKH69wBTO/nTkjUnsaxqebGb259I
	rq7YtwUZheuEQcyRzBbJhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwk71p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CI4Mc3036379
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:18 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q76d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBqg7MFwtpt3THthT1gVjb9BAfWXl8H8xu3u/gnP/PyBOwNcfISogKyQJGGRYcJkHAaruhCfgzTv5beVfvlmhzSmuo0yNxm/5w8psc4UYV6wFzjAV22i0NEJ9JKgy3n90j6qCc2lXoovQP5BIkJt1adQkFfvS8bxqCtSkhpkNH4iWkQHhqdtfS3jyY2BSi9mtbodHkc58VUfUif5ERl1rTx6KoSjrK6YOo4uzsdewY6I1PGriEE96SeG6P7CFlR+1YL8zqyVtiWj46xooN8+oYblp4fv4w76frgMP+HHPT3wuV28V6ZTdWgAvNH58FvFLqmNicEadd8hgAJ0At4r4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKny0LjskEcHLK1HKWB8aXFUmjxSKn76vtdqE96lRKw=;
 b=hYsZ7Vd/VY45tvlmPVAmKXt/eyDmtwSwIn7UFHONs0p5dxGTPE4hHz16ShvRvL4/6Qsuc1zRxaOx/hVHvtx3Xs4gGaD4o5kgRsN+ft/3fJcrjmZYE0JrJ54ryn89DRbJ7/wnC7/R7Eg2s4cAIkUEfnJhsBElD7d5bVBHVVyIcLtSlu4u05bnZ4Q4HVgH+W7C4kAk5shcHrejRLzpRA2YKzZiSk9Ryz47fIuSicNicmncds7N26cQbyDx1C7osXhUd18e+58zf1eZOFctV0+Es71BQcfRLQriib3erZBSzrreyERLN1jsgRMQHmDkAPHfNmdOVauNnS9h/NhGVaZ5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKny0LjskEcHLK1HKWB8aXFUmjxSKn76vtdqE96lRKw=;
 b=JkCUGh2s2oe1++hCSm3IuquTaTDbWXTIurdpXAHxY7HruNi35G4H7ksqcKATh40U27zkcIOxE8+shoqH00562cyXOvOVF6h7+5n7mDJA1c498McZQJxdSljXTZ5iTTrysnyKnTb1qiwSX8rEbqrFVI3fv6Fg4oY1uZHuh1REB5A=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:11:15 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:11:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/14] btrfs-progs: disable exclusive metadata/data device roles
Date: Tue, 13 May 2025 02:09:31 +0800
Message-ID: <0d0760b55f859ee2aa526d5456d7b57f4c9de368.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b706cb-d8ae-4b5f-431d-08dd918062a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gKCkaWKAXW7c0u/JCzpe2b4I0ugQA+gcMntGZ0gTCsusS7aMgIdmmSGrSE9s?=
 =?us-ascii?Q?R42vOVCz8tYhD0OXj9cAJBDCqxx7O6IATLL1f+5TQ4frwZ/A/5TqM1l/pBCU?=
 =?us-ascii?Q?qhyXQ49h90IMeD4DhSBs8NlTcXMeKDUYthCmxY/LdXjqb490H+BZF4W8Onbg?=
 =?us-ascii?Q?UgOrr9beJy4P4BVC4eyqVLWudLiAwIvPaITERuA2EJmmIzuTO6SzVMj9K3jI?=
 =?us-ascii?Q?wjs9wnJj2XbizBtNg2JLR9g5vJjL1nfzpSDQ2aRwEDpR2Mk7Tp0t1JNjFjmJ?=
 =?us-ascii?Q?/rpnHiFuUqzAbwg4D0eIUDSklrI410qC23krj7aPyuhTSziK2qp8yCD09gQl?=
 =?us-ascii?Q?ONMRh/n2pOByELuHnGLX4C+VMXqnxxaSN+DjDL6LzCe5Vd6tTqvytQx1ZqRl?=
 =?us-ascii?Q?jGGOwTQ6Bk/7eiC06/CeeNQFzPxketSbpkRAVihPlpCbq8tBIpV66wys8kUm?=
 =?us-ascii?Q?bVHcxG0wHzKkBlFZp7wjMBqcoJXvMLPhwQEap5i4I9oIvE5MEoAgnL0cSAkr?=
 =?us-ascii?Q?AaNSti+0OiyjWnI6a+BkGBROHACmYL04h60iucdGKsdSX96wItAZ8xBAUE+h?=
 =?us-ascii?Q?mfw/qJRRvUWVV1T0Mi2OSho4dLeQazx2YTr24Lf6JgZlihKw0zEQu45TN044?=
 =?us-ascii?Q?YYkOLc0sLkGKYl+fKnn+8sXeg5EdVVjkp3daP1c9H82dk5NeDbcsrwxeRz7P?=
 =?us-ascii?Q?rKXPx19WicPKJNvV3ehvE6/lqNS0Vmuce/Q/7eezHE12D4G10wZpsIt5k7EH?=
 =?us-ascii?Q?34Tfwjs9QiZUvSW068d6r03eYbnGuQ9B1CGdafrORwfdl4/DBNf0M/3JIx4N?=
 =?us-ascii?Q?9Y49W/uwLKm0U9vNFxCbw/NYKsXff6rMhWB6gOtW5Y1E2nOrhIXHLzIeb0rz?=
 =?us-ascii?Q?yjATDBtSaKlQetIQkwDB0uMqOXp9gKf4Dnhpz0WA0dPuRui35bpI9Qhkk8Ng?=
 =?us-ascii?Q?lxeU5LY6aMOdUfoFWoXZs5spZEwbzy9j5sb88puAk4go/2vpPBRxjbRiSDkl?=
 =?us-ascii?Q?NdoYjy+gILv2zpHCsiQkgLJBQCWxmYx55hoPwKSAxU3bR7j6ENzn1d8Dg7z8?=
 =?us-ascii?Q?ww3dNrMZ3ZPUZM8PMnjwqOql+GSU0zou9IR+azAghlKlGrrj1STIx/XKO/4q?=
 =?us-ascii?Q?RoUYFmiU7mm0U5NP9L0bZXovTDyTQFywg0PdkvDftu/kzDA1j1QfoxDmd2Il?=
 =?us-ascii?Q?q8dDgDCVFIXi7HMv5u8G/9g5WaH5vRX5TH+/9dQqpwSGzuiFr9DcDzzt8Ktv?=
 =?us-ascii?Q?WIOv6mX2QJC4yGgtIoQgV3P0BZUhZRaZokj3QSKEh9M8RLBYPie+JYuAio/7?=
 =?us-ascii?Q?qSTHybLKOrKtG9wv3D/PesjzuhiRR2AQ8znevsHeGJg+zk7yFCsOMuWB7Gg4?=
 =?us-ascii?Q?QLInoXAY57U7xAL6emHn/sR6Dtsq1v6oI2jeq935LSdDPiPDsTtanhtu2eip?=
 =?us-ascii?Q?Tw/XzQXG5Y8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63GdKgJXBkWLXAqgBcr+SVHSdWd83PgqFG//EXtDrP1mtU2pEJNKRr9wjea2?=
 =?us-ascii?Q?1Duv/l50u7tpXzcdbAqcxh4yMDowVcHQnfoN/vYWCkRAPH+k9NNlzq1pvnR8?=
 =?us-ascii?Q?oTRZ8UpNpEH395hKI6WVS2biMxe7bvLry86NG51JhYVb1tjPfqE4UebC2p9T?=
 =?us-ascii?Q?6KOgcqKhlwtiLQmbelDrVYOhtwmeFRtXUzM/wZE75q9kwzvGVisCg2eTzvwN?=
 =?us-ascii?Q?0RS0KQho+VJDwp5cOE2h4Kqcq9GLxb9WDtGpWe1Hah/iCuXSgOk4IHjfBncf?=
 =?us-ascii?Q?v6EgAhruxv+ZNfHZkW+pG4q7n7f+65H0yDw8pGIEI0BT6T0KslUIxryjQRow?=
 =?us-ascii?Q?07GvgBNPrxW2bwVYp16AaTmfZZ3bnScfzmKwGa6s8UcOaBWKZm3MijSimQzi?=
 =?us-ascii?Q?bdbFsqFbji/V5lXSNd1sDm2p2BiaeHFiCJJ3eOeRpDwvVoV4fZQmgCKC6/z2?=
 =?us-ascii?Q?P7/5gEk5g+XzeAZCpFiVVcpmj0prjUQFFfTcJTf03OlcG5UN7L6EZ2Y0BBMY?=
 =?us-ascii?Q?gDKzAEqxI3/o3qWI2dR7WtkYdyORr0TtncWKKLXsqm0/43yNuzZspDEWhf7U?=
 =?us-ascii?Q?kDwFkAe9+0fwltKbasT/9z7OS9UPbRWPc0NXnWT7jnw3uMSxkEgs7Yhsd+fV?=
 =?us-ascii?Q?m1OKH9GvbKLq9ph3uPXWKDIhRJpQvBcbEop2JoVj6AD+foQXtWYuzx1nHzyV?=
 =?us-ascii?Q?j877gfdzfdBqvBHCNyH4h7Byy2JiN72PivPJ1Q1RtnMb9PDK3DK1BxQjOnkL?=
 =?us-ascii?Q?FTSX7prs67qvbAOhbvGlLSM3MGyWAYmg4vx6LkcCqhKSEFw3K0NcqVIufdf2?=
 =?us-ascii?Q?vNfKdHnt1ukDLy1XqlCDVGCTvgQp8m+PMS+HlHKE6pfTdiSa8u9O8wb9gakG?=
 =?us-ascii?Q?QfcgtZLze8GnrSMcvlAusTBhIbmyYj/sCjgD6k27D2fsAz4Wv0ae65LnDpqT?=
 =?us-ascii?Q?JByAPSI5sTCpV1CXZafp4WhWfGJ+rI/flgRllgf9x9BAsWrMA9SAAQPfC9Pb?=
 =?us-ascii?Q?2cN+WunJWjgZKCe1jpafG9/ilsggPR/SXwI09Jq3Ge3hpMzrAew0QusmEed6?=
 =?us-ascii?Q?985Xq6UF+giQgu8u43A2NKZbCpbd1PiFyFc9Ac/jDjQ6jJxJwubL/h9H/Xg5?=
 =?us-ascii?Q?01zutOgOWJ1ErRjQKxukJjiwAaG2EQpPlnnRoWJLnXDin4FUUbGuysB3Bk3R?=
 =?us-ascii?Q?wlo20trBL5kWqh5Is59v73kkP+bgmFBIRraBM6b/EImxZm2SSPSzAtjF1YPm?=
 =?us-ascii?Q?BqN85SOEA2+Tbc2iIZ1+kCb9d50xuvLWx1zkVGBqnuMM1dv1G0aNPoTaxnte?=
 =?us-ascii?Q?01BYejTNkfHOPdhK3sRZqkumRKPFBDrSScw8GByThDEuuCxnqEznHDeET6uE?=
 =?us-ascii?Q?hTTg6GnvqBeetIoHZo3E1LGUKDpNe35uJ+6TonaTAj+BIFUhqtj3cpsu3KQG?=
 =?us-ascii?Q?6uaZWK8flH/yLKXev9/7wQAlhoMcQaUQ1wK+8FQLM1dI0T8mKgEolqZ5NaY6?=
 =?us-ascii?Q?WMSOBHmnXT6Hta1cyjSU6wzyrp38pkZiGyc6nfacz65hecvHL9uPXAuQjgGg?=
 =?us-ascii?Q?u7jeIje2trW7eRKFLrjuYfydI7Lr13bLLK1Rqmfd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DN5Nk1eLIfdWGRjBJnzfbS/70xQ0OkQkYUX/RAtsyhZFacH/5p1d7uEVmVPD4Ew++I6yWloVuCVSMTy+tV3EQ/Iw7sFgcPWM3+e2FdOmeJVP6BQzHWMtVN69zT5BOTDvke0f7/NsOrTYmJ0hfY+3uXOV97VSl5Mz/9s23CVgnTCsR8901dE0vB3k0aE6UmOUqxB4jZB1P0Fg597ulC/s15DefX+6hITPTTodwJzj7fh1U/+MYUmpYHw6Euz1+AUdyPw7frkIQD0lvuRiPR1sXJv5oEoHYvzA1P7gwMB8dKUd5Lw6UjqZqqXeVladFJH7tBxPZbUAwUH9zvw+PWLDIEV2k1VzOBAXl5AC9vb0uJa/qY1SKrpKe4iEksBB0Ox0cBAtKJxFalviwt0wIb+t2JJKJCp36KlWIramOOljNxg/WAC5EsvwiDogUrIC/lYULYAXaVNm9R4CocqEc0h+X3cgrWG1T2mHm2oqhMHMmLt+Zg5ou1RD4W0HL3JnT1TZuqwLBltiUSdO4i60OpetoEiFqRndUpeyQbQe4kt506ST4qYnPk8m4zscc2swT1X2LaWvm7vDQGkPFwIqcD2LuAin83k9HXzGcMMYhW6v5nY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b706cb-d8ae-4b5f-431d-08dd918062a4
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:11:15.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlVbUuneR39Si90MOkcT4U4/WpvlIMLfyARTC8rrK4aWRJ7l2Wony739LLHDISwSMenfjQieNI1ioGWYtPrtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682239d0 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ZAhtQT0IYrBu6haanIkA:9 cc=ntf awl=host:13186
X-Proofpoint-GUID: t2diQWilQreHvR1kjE5TmotBfKd2ZFKT
X-Proofpoint-ORIG-GUID: t2diQWilQreHvR1kjE5TmotBfKd2ZFKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NyBTYWx0ZWRfX7K11IvsQOWSe Kj99ixrP0zxpgkhZ2xwVRJT34txLIpcBzqt/Fx2V1l8TzKrdy/ob+1xZFWc2b+7Y3tQ8hZSWOUR OYrSrV5FXI6n3imi3jLGyYTdhv6/Z0pzQGgKBy42nihcocOyd433DrMIt9840+DKgM5yvUGalJC
 4RFtOIKXaKo/sMnFJd1h5BZ7jJSrXouM++J8mBlaeKNUoJD0zSs0sPgce1m0K9Ph+zOJ0CE7Bh9 AL0u5P9BEmYtmLwnaLg5ImSU8ZaCuiLIB/A2kjVebPG4yngEDSn4l2GwxYjUKalUT5EyYI7P16u 6rC1FmrNbE8EB3f9eDx+ITOQ6dJVXAJxjTmPhXcvcJ/QQyY5dOC0zynUBoeLJW5PjLv546VbNil
 yOUbSeHscAGuVlpd5G/gsczuw7pDWEhVNNIX146QNrXwwqTBZt5rTiS2YdvRglZkqfdFKVz5

When exclusive device roles are set, the actual number of devices
available for allocation depends on the block group type (metadata or
data), rather than the total number of devices in the filesystem. The
total number of devices is widely used in the code; for example, `device
remove` and `mount` have to validate if they would satisfy the block group
profile based on the device roles.

These necessary changes will be implemented in both the kernel,
btrfs-progs, and fstests in a subsequent update, once the current
metadata-preferred and data-preferred device roles are stable. For now,
the metadata-only and data-only roles are marked as unsupported.

However, devices with metadata-preferred and data-preferred roles are
included in the total device count. Therefore, the above changes are not
required to support these roles, and the preferred roles are ready.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index e069d69e3304..e1b5c378b5d0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1703,6 +1703,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+	/* Keep until we support metadata-only | data-only devices */
+	if (device_count != metadata_device_count ||
+	    device_count != data_device_count) {
+		error("Metadata_only and or Data_only is not yet supported");
+		ret = 1;
+		goto error;
+	}
+
 	/*
 	 * Make sure devices marked as 'metadata preferred' end up at the top,
 	 * so that, it will be our bootstrap device.
-- 
2.49.0


