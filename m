Return-Path: <linux-btrfs+bounces-9706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C69CEEB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE391F264BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AC1D514F;
	Fri, 15 Nov 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqhFhjev";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EZpIkzv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4771D5177;
	Fri, 15 Nov 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684077; cv=fail; b=Bllkochndf5eoFh/+Fh+af0w9soWqgAWLTwULEYPxuQgUXErmxeXmDi4L2X+vyqBmDmjxzHszZh551YN/EOPYYpkAam9HEgtr/RQbpF09zLLT9x7euGFGRZLdL6V/tqPCM/KTNxmFw/gNsYYpyY5sLXnY2U+LjsPjUgWwIWiahM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684077; c=relaxed/simple;
	bh=pJSn5qBHw38cCA1R19RNk6jbvjHOywpHgP3HxPvAi3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/XkAKeAiMHM9Zk8/xIgs3v9sVxcBQ6Cob56QF2PWAOAXbG++7GWB52TCOIuIWpsioBdfRIr6ue+pDhRMfVGou4ltTnEuH1d970uwa/XRQ0/XFpi+8PKbdtrEQ4ULPpUf5wAKqWtFj7ZBVwC6yCa80iXr4QnPbrKfjpW8000tG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NqhFhjev; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0EZpIkzv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCS4l030507;
	Fri, 15 Nov 2024 15:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OxQELYtZzPklHLxPYQlH+PghGp4RkNZ3P6V3rocYuDY=; b=
	NqhFhjevpnXQ7p/YmpFsm1+wE3S+ZiuCCTZMdodLr9GJsUMmGErUB9+KVJI//SF8
	/abHdzy1UApmmbN2QoBh4dwm9VMaljP5Q/A1Hu+vt8bg8N2XpjRD12pIIcwHeuMR
	ElIRJOpselk6EecJ4B7XUDZjL1KGsSTiMqRCIyc5BUTzZLj0Q1f4LOO/fdcIhmjR
	9AeXlrxtlNyPhQky32n7geG4ghzK6bPKN0XmVLJ7Q0TuAyzjO26Sr/GisXQmiLwb
	kcFioFt27Sf1rF4BVWQdYI6ZDkxZxT61uJHaMzVKZUv+w51NJq1ahH6GScieMV9C
	F0vBltm/ovf5idc58aCaBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heufya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEQVhk000483;
	Fri, 15 Nov 2024 15:21:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbr0jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP7v+8MQ7Y/Gc7BUpfcllqM2ksU4nGDDrAwEahBJLt54qaFgWUxnQVKlvhxYl/4u9ebBy+VOYMBE1BZEcN52WN5RpTOSwY79IJDu99HiZO35Miv9Wwi7wNc0roLs/fD5Cf0sCFBVvvNkmGZgOgEP5OBmlNQeXNn1cPLM56SkL7nL8fd0rEpkHVT00b9EFnXGO5vzBWy9Oja4YaGLwMYuXojpeeej71HRlVmu4wZm+O8ruxMpkiPwVkxIJ6+YNHfgA1BUmqVKndUQTdb6pnkGe/RKWoWFQRZJ2VE2Yllk0zGwdsmmksiee1kV4s9VFBAqSRzh8Lz56MIIN4zERCzCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxQELYtZzPklHLxPYQlH+PghGp4RkNZ3P6V3rocYuDY=;
 b=Le62oYm8jSDUfI1za56Z2LocXknXT1Om1qaNxC1/x6FO8nU0eXS2v49W7Ib9f5suUNMoMW4SPdyXHclHy7bDiII9Wa5DdS4ofDuKEQ3tJmNorBqs0h9dT7LmYtTR+D3AXcglXLBuABY9ne7b4qvSmCpJCAcFc6d5yGRMlvwXmUNuYkCN5BnS2R+lHBjWElX9okc0AzwLGa1304yFzJdItYrtkB7d7UANiwllWGLFD6ITqfVxJGt6cYsW4ji+f39nHc+QgNzbgDB8xutla6Bitk082Lvf6dIA9gEsLihYl8ZlT+GgWFa4KTYSbaPamuNFqj+JsVRmXOxpzy98TguLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxQELYtZzPklHLxPYQlH+PghGp4RkNZ3P6V3rocYuDY=;
 b=0EZpIkzvNIOUdXShpSRjB4AIjrHEmWuMW7PZmJaiEJMbEM6zcI5FbJ7RCErUBBuZ45vc7XGhaCnZUT9QSLaqsRYnuN9SczwSUtUcZnTGK+SSuROqebn35M5AvYIhSgQnRQTyeefbPGeChzyYzRU/REfju/lWE+G9ENHO39JZRpo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 15:21:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:21:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: FS_MODULE_RELOAD_OPTIONS to control filesystem module reload options
Date: Fri, 15 Nov 2024 23:20:52 +0800
Message-ID: <2a9d4263abc83059fc911198dd2adfaee89ac8a9.1731683116.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731683116.git.anand.jain@oracle.com>
References: <cover.1731683116.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4811d9df-e83d-4bbc-3345-08dd05892329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0HreLKRQ3YAH+DzhVYkwFLZMgQ6qWJwJ9e1yUiXkTRm1Mx3IAxkORymaKc3A?=
 =?us-ascii?Q?OU/lSg4sY6snO2wVUA7hud6QPOp6tEhBidJqEvoK+Tvz5z813x4xgrCJQVlp?=
 =?us-ascii?Q?nPkGTwmO2m+BbdfEML4Z9M7gziCHzjioFrxbsckTd8o8OUryBO0DDu/kH3sR?=
 =?us-ascii?Q?/cWkjyvzUHfosoInBiS6ALkYRjV8gdmAbSw2SFmuSGb079SGenv8bclllIde?=
 =?us-ascii?Q?jz4s2ZP0Q9Fke0eLaibaUPQ1m0dVLzS6wrDg4FX8RTc+FNh/hWCMaJrWKgL4?=
 =?us-ascii?Q?/Xf88QRS7Ou35AV245k5QceA82S1ww/s6fYGrgUBmLrD0sYYEL7H0Y2I1TnY?=
 =?us-ascii?Q?nQhoeXuGZdYpOAnaAKD+7xC7WQY9PZGwIIl4iGTKUjb2UEZ7mNkDtrVZ7EPJ?=
 =?us-ascii?Q?niKFJGvu7AffNDF1pD8F4K99PQXf4a5yS4u9xJfmfNhBiugJMjl/IzRyh5WP?=
 =?us-ascii?Q?iaXnKQAnOpcrFp9VLN9lOsHzkmmxjksnadjiIRWPDMS+zXUcwrIWEBoZ5Nto?=
 =?us-ascii?Q?zodqp4tUENRFMy7oniXp131nnhNSHE56BKHo45/19yesAVLi5IRtacigEHev?=
 =?us-ascii?Q?17IwJSL0JyQ9EXGxcSvzLT9fSw1aktBW89eP6BGQSqmAy8jHCDLe5a9/Di1A?=
 =?us-ascii?Q?B2gCpbxJy67yyV1CnM1BMLP+Sku9fcQTTZILEW8XdipUtGKqy+1PFPjgejBx?=
 =?us-ascii?Q?uyDtwmjaEJpPdVN0C0Vv4JkY/tcTS3UuJANTMDOdZfKqSbk36K3MVv02vLs1?=
 =?us-ascii?Q?J0O4jga1jF5dMgaPv6Z2tel93fNo1hwsmg59ihfgMSyX6XIlFtHl5qMmRzaI?=
 =?us-ascii?Q?e6vvLdq8M8xlMe0r1mYgqY3h3nVcvgrZ2hgR+cFKwhR5+z1KIX0QWd3MgtrR?=
 =?us-ascii?Q?AGAOSc6cqX/ta0GYmKqOCB7sd2UAr9phQG56IhCbyRcqTJEvoSGa9RurL2Xz?=
 =?us-ascii?Q?BAOU0XPoSill8OB87C+9/r71qLiPkNpYh79Gt5NFbTZxrp5q99snZ5WBfgwQ?=
 =?us-ascii?Q?XpUY7mDPq44z9w4BnjBTuhLTAGn1RaGGntMvL+3PG0MNJ+5KiY0ovsn1oJRz?=
 =?us-ascii?Q?WHb+3saTwqPaM2p2WOG0W4Q9r4RPHKUipT/CYaqMiBpnHKGqiVcbZgIuXF5z?=
 =?us-ascii?Q?JqusL27ZQyv4acnwFRbQd1h9wRlk2aSFt7wdlgcvLAzm/3kOkXAWZl+3ueZo?=
 =?us-ascii?Q?DeuWQhzv59QsHLL1mvd4ldhCTcrJZVqNj/mujNO6bXM6spGLG/4fgmp9YeCc?=
 =?us-ascii?Q?3arG+V3JWuzsyvrMEg9g8HfyjQGedGMwirMAuM+51qpLa5QCfSlxm1UVmGqI?=
 =?us-ascii?Q?PyzXBfCYjY4uEy2k3lj/z8pI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jd3PQez16uVayyVDzNM4Ik2ayTMT0UXA0PTB2TmhBVilevPYtXQK1lvplhpc?=
 =?us-ascii?Q?Lpbfd96DkD2yhaLqUYHqXyI4KRCUSvnyERKTJ23dcnytFwLF+TVfJ/SmSl4K?=
 =?us-ascii?Q?WRh13h+5CCS9/4jPOLATuwrQCTHnN97AVNjI2+Iyj2Z47Xd+BkuYA23/YtxN?=
 =?us-ascii?Q?7+gp+c1ZP3cSOVVF3VSHGYbE21mYECiRaqe0X3znLOCawAWNYimwlljhJ7JP?=
 =?us-ascii?Q?QOukR+taRgCLb8C8CfxJGwAJug64+kkXg1r8uSvRluLMA4zHnhCjLpQC1hgS?=
 =?us-ascii?Q?EOviIGclUgtcDyMw6pbwtGJrS3bZGMBSWAtdEB6DFQ1V6DwA6FvB/oR+11wk?=
 =?us-ascii?Q?spGbm8nX1mULoLlmnbzukstX/DuXoPVLyvNGk6eihBRfnrwJesPTuPPRVkGY?=
 =?us-ascii?Q?nwAppjxNdV/WZ1zIiuoeEsn09lgB0OZz2QotJAZFda4gswF5LbJJxZK2WDvD?=
 =?us-ascii?Q?9PfE7WnNbHqmnzKgQ0mYE4mtTwOv/KJTcp0RqxmYAaW1DpTzykOxxJ96d7BM?=
 =?us-ascii?Q?OkMEWBnEYcNE7iZLtm0x8Kr3T4fYp/iFv3WLh7TI7PGbxDGmeTy84uzzzD2l?=
 =?us-ascii?Q?sINaoiYXkTWRgxzHblDpHru6KDO9bt1MsyVLLcaCkkBAE+BQOoBg6iuRDD91?=
 =?us-ascii?Q?QkDagajuh3EpaLf0cURAD7533ZsmUmH2DnCSVK6tcRkM2G3FqnEaR05alHOZ?=
 =?us-ascii?Q?Fc9GXPl9IgyN5oxAMqZliTb0mehUO8ccP/SizmaLFNDRl4j2HvfWelTJhZgj?=
 =?us-ascii?Q?STIKfQdc9nrXdqdZ9ZP1D2/yQdxS327jIaXwmbGI8kFxskanfteRHV+sAMBI?=
 =?us-ascii?Q?EYZINgvJKKzOtjPNoBpasJgWyYYSDFtQiR8SkkU40o7krO5zoUjsdsdxriee?=
 =?us-ascii?Q?Pjm8Ja+W1sbHBZxQd7/E80yB83HHLHq+a591VzHpRRvaP7Mkgj0xuYEy519k?=
 =?us-ascii?Q?KsKRa0co17nVN++nFU7qiqGmYSbJAyxEox29ihPwzi93tDZqJHzRmhFRtBog?=
 =?us-ascii?Q?V9sfRvVyTrh+tOq+1JBdPzktuZMxmD2mkDylYMw20syl3TutOKaTY43BPr0l?=
 =?us-ascii?Q?muO2mnEHKgYUWsyqbGKZmk/V1YH8sZdvP2NLTqxofZmN9a2842cuQ85MSazN?=
 =?us-ascii?Q?B7EY7PgqKH/VcDjDYRr44b7wWueXOgzYcqgsAXXMsveJrpyXQOLu9ScfuaUA?=
 =?us-ascii?Q?8dUXrZXot7Mrnr+yhwJSGOiXo+6ds5/l4YxxlzsAzgkNhWgeanN5ovmqH9ag?=
 =?us-ascii?Q?/q94lwBgxPYJi6gvhuAzV0+omNsAb5pryRwNo6ODvz/rS6ie7d+Jn5VZ5uK9?=
 =?us-ascii?Q?HTXVckkg/tXdHW6b/6wz7mXsTjrT11v9W2eW/LHJMbOczhvm1zgXyoS0bOZ+?=
 =?us-ascii?Q?AOTdVufqucPj/s6PpSkGcE8gHUgthTa3+sn7nhZgXZHYDCfP/v53nsRNww5+?=
 =?us-ascii?Q?QZy+mAiBRIlyChV1V1b3tyAsMmOl/GsVt/h/BYh7rMyuK5VI81CsbP3GNNl2?=
 =?us-ascii?Q?4yj62Yx5hZx0WREWnpZKNEZ5w+VMARR7AKk64W0fpeC/7xySY2AfbKD55Xy+?=
 =?us-ascii?Q?0MMOgdbk+0lH/Jbr3S6MuEbyA0hfWCtE61ijVvjb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bp1R9f0Y8hsRWc9JZQsM9aklTt9JznUrQ9QA7YWoMTmayturCPBRPBUSjrvq/Zr/aa5D8+wKBp82oD+mru3SNoO3kLR/3BnvNogSXLKvTZTEumFIlZEP7o412fCo+u7HAYWyIujYjU+f1YXJxi1XYy0YHzzmkV5Wsy3cV0bhyHeKgwyoXexn9LBH/rK90nat2wxW0hEw+WR+maeKgIxoUW4Pifq/93UNY/MEhlLvzjFg2fUTBsEaxKklATvvqcuUw0vXeWslWL0UqfZd75ZJEIixm1SECAsOYFdH+v8vqfgmbZPritp1TTzC77kxs3+erzDLdfSqf7ZIKF3EcDAjDsQdoTMjHWBJUIAjtExDh3666kqk9oM/oQmBIOkKzDpz2Cm08PyAibliLx3Id5Ln5rSLpC7StSZtZGQhhMsuuipNnzrGgjIhhVT3CeXrpGj0WMNBsWokY79lS8DUTejh5LlTvxxBT+zREplJq3tql+OjCKryGXfSdkuFnj17xCfKQ+ncYdl/JIelzNT0xKnCRjbRII0Q5ofuPIUsJZmYYmNtHhfQfj7bX3e9/71709BU7JiVLfeD6THnQjYoqgiUF098MiVJyDq75bLCTcI4/jY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4811d9df-e83d-4bbc-3345-08dd05892329
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:21:11.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQTm1rZD8eh/3HqsX7w0gFK10BsNK+Nro2VNqihiZFhorlqLznyx30/IqspiOkzppFCuxRYMEZilJ0oB6KQpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150130
X-Proofpoint-ORIG-GUID: bG49KggVVr8UjvDT8RQ0K3WHfuoLiuh4
X-Proofpoint-GUID: bG49KggVVr8UjvDT8RQ0K3WHfuoLiuh4

Extend module reload logic to allow passing additional options via
`FS_MODULE_RELOAD_OPTIONS`. This enhancement enables more flexible
configuration during module reloads, which can be useful for testing
specific module parameters.

Maintains existing behavior for `TEST_FS_MODULE_RELOAD`.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 check | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/check b/check
index d8ee73f48c77..ced86466a4bb 100755
--- a/check
+++ b/check
@@ -937,11 +937,12 @@ function run_section()
 
 		# Reload the module after each test to check for leaks or
 		# other problems.
-		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
+		if [[ -n "${TEST_FS_MODULE_RELOAD}" ||
+		      -n "${FS_MODULE_RELOAD_OPTIONS}" ]]; then
 			_test_unmount 2> /dev/null
 			_scratch_unmount 2> /dev/null
 			modprobe -r fs-$FSTYP
-			modprobe fs-$FSTYP
+			modprobe fs-$FSTYP ${FS_MODULE_RELOAD_OPTIONS}
 		fi
 
 		# record that we really tried to run this test.
-- 
2.46.1


