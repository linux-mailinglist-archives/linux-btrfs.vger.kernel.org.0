Return-Path: <linux-btrfs+bounces-9694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB149CE437
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A6286573
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558681D4350;
	Fri, 15 Nov 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuL8NdMI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QirRSYqw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D961D434F
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682508; cv=fail; b=AvovLdGmzi5tPEjaFySiCtafwlrb7kklfSF0T0jMOBJ8ANcj7Vl1sKVfuTTYJ9qVeilpiqhOpK778cLrcrfdvw3eP19TUgCEmAjKIw0uvWHq5OmYTXrzqXCFmqsS3m0ExP9vPmHmtsO70A2/IXWvwiwrgIm2sFtCEiO/tQ7ZVhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682508; c=relaxed/simple;
	bh=BFHDymGuUvk83r1iZqYOf+MeW97zo1o/Nzb0D0VFGeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0pNl9V9I+TcIDQsVd1JNn1kEgq087M945N5KO7oooeCpJ9PnbFlbf1ZkVnO+H4YsBhrv5JXsgcjZuKDJ1Ak1Ou7DUGZROFbq3W+MllML5K1Xij+KGnCiTQzwnfjEvJaVvWoKm2l/fY/+MeNHH9tK5ibmmgNztJ3Y67/abPqFVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AuL8NdMI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QirRSYqw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCQOM029312;
	Fri, 15 Nov 2024 14:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SPMWIWztqEvnLtlYQfvugE0wdPJMjhoKrctVm4Vwn1Q=; b=
	AuL8NdMIShhmbuMYr6MphZHKyzFEP3AnBE41bSXZtCQcae/1abxj2Op81aZiFTxa
	5O+Uv0AsnsviX9ldF1bz7biAw815Nv+qGt1iefzJRe4nj4RGLiTROnSC5CP3GBm/
	OFsor+AleyCSNYHK9uQ7sGB+miqZ7ByFOI+eNtyL3JR6U3SbPAyZMshaVkuKpdYp
	HJlQmpv6w+xPelOwocgWlSi0C+yt3fhLuUAj+BmUaenT+imXvsQEfVkgFm1Wa38X
	QrNyXZW3LyvB3szoxc9tocs2eqydOUV4NnHposcMGsrSxcqMM2QB/4HmpyVZbClY
	EPNyAuIOejbRGCLYPZ6iqA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwukad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFE19F6036149;
	Fri, 15 Nov 2024 14:54:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c9ebw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNzx0hbtb0rloJaoqtoBuijHGizabprzI1YUZCd1n81SHYcYSVtLdlIdlIJEJyBg6hhcxcyFtLfxWZ/ZLR277XqBvrl8DKMfd5oXX5k3aGCnC/lMQBcf2pusxDhbCi9l1FiLltS+jkT249k9P61c9YB5PzWuXf7LCmcnhSVLSmj6VTYzUjMBYQafQWOx1x0IKYz8LiI0EsIxqz26Ni7yqVZiS36tDi/4AH7xAlBGoisvaUF4Kc9dDSA0AX7nJjL23JL3ormsLwhVwa8NQrsqrHShvhZ6sX0nTCA9ltXlPLMGOIWgxDTe5tMFnDIZwUcLy0/GnKjFi8/deBkmnvtLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPMWIWztqEvnLtlYQfvugE0wdPJMjhoKrctVm4Vwn1Q=;
 b=Aods9krkcuG3ZRk7DnzpSfKLsS1BDEX/4/XcGavR5pA03rteVKzFw8ss2GSyukzbQWnNzqZdIk4rKltzfqT6MXCz97jeUCQqs8GAsS2JiBymAv0tS1Y3pd/GEPP7EOpp1LyYJ2iCqXdaekaSXMYkOnLnni7imgnJFrizotTub1TjkmwbS7Gi1hMJVjFnWc5VoHrqwP/+G5ORGoBYQoTKR2Rq1q+RH5wT3Jm1gYbyrzv7k+8g7eR8HI34VIEkBpQEeAPKe1ssLpsXnEptJo4NGmaf0bmIfxhkrQk8CfAELU1ynt9tJWtwDCMYKW0wqCIwbpSJEBZ8LYQGXK6mWrNUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPMWIWztqEvnLtlYQfvugE0wdPJMjhoKrctVm4Vwn1Q=;
 b=QirRSYqw8M6vl1lrsFCHs4wVjHmuQX6+mrOiyO6w6v6U8JTBH7T4ZzUJ5TUEn2Q1S6iO7n7cRvYrtKgI/76vyWDHYbQavQj/hnouq/UtqzJ52EjwLknhOCeWAWUFglrxY/1zJZw4Vm3cNg3KAG/xwBmkktMVksYAXFDq5AZzy7M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:54:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:50 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 03/10] btrfs: add btrfs_read_policy_to_enum helper and refactor read policy store
Date: Fri, 15 Nov 2024 22:54:03 +0800
Message-ID: <4664157d202c375536d3c7d3d8545b38611e35bd.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f9b28c-752a-4ef0-e2af-08dd05857486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ay2SijsGdbHT19hF0B7UQvXW9FShcaiqcbs77YKNqNSUiSos7vR+EvVVwej9?=
 =?us-ascii?Q?dUl0mz0M47beON554cuVG7LsiZqQEeHtie8HdAvz23AaLsybuQaBfh8DK3JI?=
 =?us-ascii?Q?PIyjWwh2fXF39Le4qknCevsRJ9Wj7hPYZUYkiK8Os4iU69xTysE+/2B3YG0C?=
 =?us-ascii?Q?0DuxlHtaJ1tPChMqBHnWiE5mok19/moMTesf4pn6BzaCglqX7DM2MCpaSjL0?=
 =?us-ascii?Q?V5I0aCWfajXJbi+QP0BpA2ASSjLqE3AyuSLQLzdlCLHwBLRrchw7eXJsfpPG?=
 =?us-ascii?Q?SHBddQpfztkHDhZ3FLZ3BaMvEK0WBekYoAdk4Rp3R8jLLks5XE2AAcbLstYe?=
 =?us-ascii?Q?m4NIlJWPUDhx7pKv1nEamMxdQ7ZYz5u4zRMG8jSQtlDt8dCd9ni09CpkSXD5?=
 =?us-ascii?Q?tdz/BPCMLgsC3MYKPo4yoLqExxyoHCrmyy2IKpRQw0UQfkwmrTNBPV4WdViw?=
 =?us-ascii?Q?ddd3OYWj8NrfXxXIn/1djldGTNLXn9lNA5zWW4XSEBmPD64OL0amjMFt4dDo?=
 =?us-ascii?Q?pN9ndqXqjh01eDnvKLP0W4rW+sKcq+xCnMOR3jbxsfHr4mcHm6FjLhOI3zc/?=
 =?us-ascii?Q?OV3S/c86p909Y3le/R4V10WJMPVj19g7sL1FS+2IL0qpLsEsexr/2BKERc8b?=
 =?us-ascii?Q?sq+AYhq5YhI8b9+LY22wONLSDYiYyJOmVG6sv64l99eYObfHE1wTC1zWjS6e?=
 =?us-ascii?Q?GEAQMhsfCy24v0psoeK2Ny4ZDAtLA1mgVC0+Q0i5QdMU/q6Za997TnylqC/3?=
 =?us-ascii?Q?mqD7Zv6qBfHZUqZWA9Ye690pzXEKNNwnhzd0avkbsDi5lew1JBmRnU4eE6NT?=
 =?us-ascii?Q?cl0qCD7xQ6HNI8HFrf4Hu63gD3wf1ddy/KtCgwn6BVzHhpHcRdl6kUT6PaRr?=
 =?us-ascii?Q?I4SJgY/e089tSoOtorpY10xwXFgDzfMfH3f6V9kyWG2z93i/8XN8bB+uwTIN?=
 =?us-ascii?Q?GJcImHP8OLn/eiZQsD/XTgI/C641Cmj8Kye2og8NJx5ChLBKkSNPQ2uu23iN?=
 =?us-ascii?Q?sGetIW9QS7mg2GB9X22wyu0bii7wLad2JDubjh0E6rZGcphzdOkjJX9/yKqn?=
 =?us-ascii?Q?aWF3bNU9dblzHRbs7qEWL8Zq4pM75Xnj5oCjM9zKGeUB4MxssFfAhusjvIZS?=
 =?us-ascii?Q?0od9uABnl37VoowVaj4qj8Ml52wiMIE9dQXR2oXUQ4HG8bf/xjdGH8v8T4iv?=
 =?us-ascii?Q?g68u33ue1VJC6rP/LRzqemah/gE5cAoqb6ShjaQOipvJ/va+1jBxeKJDHaWf?=
 =?us-ascii?Q?+9vcQhq7pYvnGpIAXd86xQwA/Z3KrSLvILNGcTxhwwvEjzCmNi/k8xkZd8l4?=
 =?us-ascii?Q?TWrPRjIKzFgm1xooeJEolPgK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKvIen0eyAgCuhcMEx9fjmj4n0KfvpQd52Ihs68TQNwYaXR4qVGo4pxMq7DB?=
 =?us-ascii?Q?ziousS33VdDsqSlXYBWvsqnaltbuOJXHhwJJ9Qu22KJkuERECyreV8wU11sH?=
 =?us-ascii?Q?VowhpDK2pGMUXhBCPGKMFjdzvrrYspIB9PPcV2U5aJNI/ZLnHAKR3v0qZWoL?=
 =?us-ascii?Q?G0xjxhB/KUMXqyNKPMvMdOZxJ7JrNCf+FkDkJP0f/OlLOgUd9QMtf110FfS2?=
 =?us-ascii?Q?H2sj/T9hdkkWoyzzZgwTasclSlXLLieveBi6EFAYXeyUzB3wLsD6IF4Q/D6W?=
 =?us-ascii?Q?v7fh8IHHpSZmX6Fd13ayx/FrQhOX5Z0y3N0yhXOrnnq7eWmCyGFxObFbQnia?=
 =?us-ascii?Q?3Y7YdCR6MlpUTMJck3z5UlTTfm+VCQpG9Mq8mxwVs8JJ2Sx+3VaXbBc7l532?=
 =?us-ascii?Q?Pnb6bdPbfHVxqzB1pBoYGliwVlx8CB4wf0QisVhU42+Z1L2AsvTPcrKtXV80?=
 =?us-ascii?Q?K6GjXi8RipSJNLA2+SFDmD+CGYY6VmniJoLa9yeOTUZ5NoAyCh1/bkFzCpD7?=
 =?us-ascii?Q?plUQ5r/b604lR/pX0+Pcz88uhM6L/3KqPiiHrNPUysQ1mk/sGuzmaN/y6Z6I?=
 =?us-ascii?Q?D724OnFSiknzMRw0FvK406WVa3g/0+4GVu9Egxg6th1xRejA6JRFvUe3Olbm?=
 =?us-ascii?Q?SC3enEPJeTorKPZVNvggSNwUa6uu0cyrTE57pkrnQivIJVE0c5vLoUX3+iVX?=
 =?us-ascii?Q?V9E/UKQ2QJ6/fURG/OFxtA8fIQSC46cz2SzjsNG6yCs+AKhsJ/a+C3AZleLd?=
 =?us-ascii?Q?v9Utr2f9HFYOh5ryaWAseYE+WgG8wukJnTMqdCx5iFw8mkCA4+0CHopSxaVJ?=
 =?us-ascii?Q?k3tPFu0XiMXkenA6I7Ebe6hoOdQXN86QalcZSE+cSLcdLTqX9DosiJYoqU0C?=
 =?us-ascii?Q?W4zJndif/X5dV3GRvAPGsbYRoLgGlM+Hg2NFeiJnExGpjCCpU+RlBryMgpez?=
 =?us-ascii?Q?8iEGd4iJ33JWGpNIhX9C4yxKVw9ywwpOr1l1HYm2IwP1lZd0sCdCbCiahMJs?=
 =?us-ascii?Q?dlBES2gIZdm8hyS2w6aZbEI7RsT7taEWfR5srpNfC2BCK69wIFfB6rB0L3mC?=
 =?us-ascii?Q?Wn70pHWn01sdfILTczqyvUf5JIkwNGf8ycd+6Oh0SWMC6yZfGRdknNrMdjhF?=
 =?us-ascii?Q?KNIWCZT5TnJLLwPeA0jzogWHuZ8+svxtvoTTXZkPMYJXzkeduVIhacWK+U8a?=
 =?us-ascii?Q?Uibip1PYxlORoRvlcq/MjVqlpnetRIketsVkGjdzq5jDHYaEOmyrod77gvZg?=
 =?us-ascii?Q?DHWuKvZ1Ij5LhHOk17oipEBVt5dwjuK6DYC5IKqdeFtPpSlnKI7Wv/crh3aK?=
 =?us-ascii?Q?6P0o8qEosCkB62Ow+rNBIfY6QGM8Albbwce6BA3ALzRldgjW81DAIZg7+xfN?=
 =?us-ascii?Q?BEe8sU+2f6fzBGj1qkKUFKcHv+9XZoHlTJ6N/F8lGWpH6cmkJmC5kvaPBlL4?=
 =?us-ascii?Q?6GyMkVMr9mEz+0wEO53ZH/2DkVc4za72MkBnnk5G1sdQ93g5YNsRI6HF//PV?=
 =?us-ascii?Q?XDzdce3ZLDbgNWyrriqd1kOgxwI700jUxp9tGugGP0h3pP4jacBi3bWkx8XB?=
 =?us-ascii?Q?cQE2Xjw9ZPqxdA9dNTlBIiWvG4GszmbDFdWg3bQP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TUOoehkaSrZv+Rl0/scQGuMwbzXk1zU5WQWApsiWC3BF+evOExLofYuPV/L90t2rjcl45Gaq75mfW02a7mJ8EM9coRnN2TI4FGTlpD08taoopj749DiGaxMhE7nydlZhGI3rbx7604QpA0rifA3pobpKf87QRZEvok8+88wjUQjsI2SUExeg8cO9kDvJtKW0AZlSOILbSRPWoKyyWOGcN7f7i7oPQfYSCqPASsnhl2162h4zA7S6oTLUjMVrT5nsKEinW4pllpPTPIq1PdJT3nVmYW2zujy2xuRC+gCnPkExK+J4kboK8W4itx7yzAZgIK+pW17DkaUlSL0p7XqzXbcTu1h3gPetHoPMGbNibZ4iktVQJLWgfSmwPUHgF6E65xekWVh4ncMImPkr7Vynx66BuvnnKIbG4YU+088ddRh1nPJKV9JdeyX93V7FyX68cJyHICuzALfy73Ap2nWfwEHe3fm940MXXjpiolk6fqHoAc/xDzDSglXY2Qj3qmjcXP9gHxPHRtIN89NP/cCybae5lhf1XZddX43iMpAoEr6gc1DL6MyZRr4MkL+UfqETnCMVhszUJ3rKprs3QDl49LMe7MfDvj+jv46/k+BpN5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f9b28c-752a-4ef0-e2af-08dd05857486
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:50.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcD/7riMmQXGbFoUv659Jk2ZoH1kNfwa+L4zQeFEWTKJ7QcFnndLoJu/h6t/bC+F0HZDpplvLkxFv2SkIJ3hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150127
X-Proofpoint-GUID: M8I7oZyGCd_UGHzNvwm5dtGT5kB2LLx6
X-Proofpoint-ORIG-GUID: M8I7oZyGCd_UGHzNvwm5dtGT5kB2LLx6

Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
conversion of a string read policy to its corresponding enum value. This
reduces duplication and improves code clarity in `btrfs_read_policy_store`.
The `btrfs_read_policy_store` function has been refactored to use the new
helper.

The parameter is copied locally to allow modification, enabling the
separation of the method and its value. This prepares for the addition of
more functionality in subsequent patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fd3c49c6c3c5..7506818ec45f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,6 +1307,34 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
+static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
+{
+	bool found = false;
+	enum btrfs_read_policy index;
+	char *param;
+
+	if (!str || !strlen(str))
+		return 0;
+
+	param = kstrdup(str, GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
+		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
+			found = true;
+			break;
+		}
+	}
+
+	kfree(param);
+
+	if (found)
+		return index;
+
+	return -EINVAL;
+}
+
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
@@ -1338,21 +1366,19 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       const char *buf, size_t len)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
-	int i;
+	enum btrfs_read_policy index;
 
-	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != READ_ONCE(fs_devices->read_policy)) {
-				WRITE_ONCE(fs_devices->read_policy, i);
-				btrfs_info(fs_devices->fs_info,
-					   "read policy set to '%s'",
-					   btrfs_read_policy_name[i]);
-			}
-			return len;
-		}
+	index = btrfs_read_policy_to_enum(buf);
+	if (index == -EINVAL)
+		return -EINVAL;
+
+	if (index != READ_ONCE(fs_devices->read_policy)) {
+		WRITE_ONCE(fs_devices->read_policy, index);
+		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
+			   btrfs_read_policy_name[index]);
 	}
 
-	return -EINVAL;
+	return len;
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
-- 
2.46.1


