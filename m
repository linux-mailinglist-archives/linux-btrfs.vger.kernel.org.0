Return-Path: <linux-btrfs+bounces-11719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57176A4120B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12497A90D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0863204C19;
	Sun, 23 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lnbk3xfd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xYs1YJIr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6431DDE9;
	Sun, 23 Feb 2025 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349887; cv=fail; b=qWAvIoOLYRXkrpIGaKiPehv1+NUodaUdxFZkiugFrgf7p5lDt8yVcKadkDzTLhnVKQIhw0HGdaMQNZV/ESKmduWr09hDNhmMSO7R1ubo/l6ijvzGIDR/JQKo23s/xrCiNIuR2iN874p0CjqtlnP0fjhR48XpCF7iYJ/IyI+PhrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349887; c=relaxed/simple;
	bh=kaNSBWDmjDnsq8J0s8XxzPRfB1gQ/TjRKKrHul47RMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paLCy5LmbE0hqJHxq9MXDYJ4m7y2xQfOQQ2iPGQy37OHGn5F+lOYHxhtgFRHVdffD6qbBfE7hx4s/5mu7lRs/eH86KR3JwoZLwPom9pm92Xc0yuNGfE94Vn+sfA2Sonxc10z9jBhCqGcRIqKIoJp9zWKNWxtTBrKjzOQ7Ky88HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lnbk3xfd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xYs1YJIr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NLhgBq009008;
	Sun, 23 Feb 2025 22:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KTTe95ShnVqkHBpzgQAvL+z7GlAet8+//Wr7cH1h/QU=; b=
	lnbk3xfdvhVEPS02ySLrtefcDhqGdEo5q39Td6gRQVYFQJDuvUlymx6KCfEGBlcD
	N614n8SjzapFQF1yd5Ve1dKgXAD+8M7ln2zWTN378h9qn1soRFWyigxJnVHt/7cB
	7IcSG5SM7yTzJsu6bN4eIF7OVQzkSXiPsXPyms7WLFNBTopblD1udxlffhzMGoqI
	cEhkTQhTERS5KVwzBxSb01lgRyvfmY2n/ZxwEH6NR3E7JVm8BWl2ka2saZWFSHRV
	igxuE71Isy6fuszY/Gw7J5q/yPEA55f+TaBSNoWzBn2WrDZpyUxBu7zBzf/7kjaO
	Hqytv0HgX0K2MtBuKQey/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t1fkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:31:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51NJsaU5012590;
	Sun, 23 Feb 2025 22:31:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5188eg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK8b55ed3PywR2Ed2aO2xEM853zB5qeLvOQdaxqVfoKYYp3DsBPwSY2LxsLMR/V4pv/si3+OQNfgI/hL6z1ciUhtFtFd/HGc8rUoa0C2/5OyeCc9M2ubcCmQinUCRgFdIQVgseO0baLsIdeWUbxmEMwtEA3cWxqv9mrzbFxmV2dLdQfvrBjs7O5W8aH65S5GiK92umk9mguA5Ht6rmZhBiRDp9OBLcv7ptYjTiBhl+okN9FWCqGHHnWdZSRYflXbBrjcJtgNMuZ/pfec/KjYvkl/okb3vsBEruyFUEQVgnW/AdrE1fXIbNxWRGzrk+ajd4f/K0GmSuuUYG2orwVsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTTe95ShnVqkHBpzgQAvL+z7GlAet8+//Wr7cH1h/QU=;
 b=tO92CrMiag+zz2v5K1A3Ojt4s6+kXK7lkLYzrIQBRxaiLuBRwZSDNssFaJ5Fw7+GTdeTvjI7LUIpOrS0Wmd6rMdXdOQMBn64q46i9s/wCwVc1UeCJrfxQQwlh1LpPY0ZLXVjEqVh5we7hBydNVzo1fw1MpdyjBx9LADgUPP9khIyaN10gtjA5OA01NAraGjDlf6CsVrHwYJggKjEwTzJ+1ZZ1/OCD9ZbEHk0PwowRAM8ftnrycOcgI4koN8Ddd2knQVlMQcPuCncdl0pVPIM42lg43UJ1mlDFApYyTyXEjGacLgTw65BsVBEULp1kvpTFIkdUQ+NcRzr1yZp4YCOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTTe95ShnVqkHBpzgQAvL+z7GlAet8+//Wr7cH1h/QU=;
 b=xYs1YJIrQreSLoD6r9ctAArGnyAmhnpiPlb9ffITUHhd0h5d5EubP30LB0e4Il0/N/9t+p2gyvVfjCIwRXuTaWmFknPHgxKaiUpX8WOPnPr9EvoeeQ2hjTVoPYxtIj0dHyNdcsuiqGkbVxQhEsXnPwQVuXipFvuW96z8PDGTVcw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sun, 23 Feb
 2025 22:31:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 22:31:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org, fdmanana@kernel.org
Cc: zlang@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/226: fill in missing comments changes
Date: Mon, 24 Feb 2025 06:30:33 +0800
Message-ID: <3d3d2b2c4f1d214749417581f7194fb7bbd0eaef.1740349141.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
References: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a29d6ad-9511-4222-3525-08dd5459c4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWQ7V/sYVkf1WGEd1iC9KfXEiqrUkPIqq2jBbzPPXRFQapqu8j0oNKiXp0yr?=
 =?us-ascii?Q?gyezJqbGqs39eMBn4OLQG8WhgnN9EAl5H20K1LuFmEKimqZiyG+1pEKKJmoz?=
 =?us-ascii?Q?5Lgele2AYyqsfy1sw3vAT0ZnS8mp9eAB/KJSwvXX4NAQYN/raeT3Nw348x5c?=
 =?us-ascii?Q?BxzE+N5jxnmwDZZc+gKwoBeSZxOqK/nWqng+hHNUw+QEn6K7oMDl/U0vJPKl?=
 =?us-ascii?Q?5Z1YLjP+qdoKI76isFj95ZEeMHqb4pGHDuqS2Bay/O+3GpWS4S+JtI8+KxmE?=
 =?us-ascii?Q?hJsP+KFVcG9/N4NfuOQFV5ZGK+6eWXhzQCw9jQV2a7XR8vIsW/W5WDnyiI1q?=
 =?us-ascii?Q?r3mpZQgz+5MqrVgkT01h1xzXVNZagHlo3ns8zaJSTmeWRD1LArkJf/9Ul5pS?=
 =?us-ascii?Q?QnptVdWVHqSOUar2uI46eWmv090mOeFfr6gv5Ec3y/+e9eUcopfJo87ze3jQ?=
 =?us-ascii?Q?fJOmfVFOP4Auc5SlrZ4CRzIISaTIGzOlCldAKtF6babMb7Bm2ZDwQuhE1JEu?=
 =?us-ascii?Q?Qnrh5M8cOlLhPHnIiuwRbszHqi0xMrKE7HFLbEfibuxMoZmTQIFdk+ixFWQV?=
 =?us-ascii?Q?zUkhIaOBGOdkmJ/6o2MVnEWMJCBFVMENsp3Y/Gmc1iM030OYoUmdtM3bCVJv?=
 =?us-ascii?Q?ccA4YLdfSf8pXrmiqrfcYNa8AHuW3TWxYKMH13IDrO3c2/SySUWGdbwYsdNf?=
 =?us-ascii?Q?fXOnNXb1/uDfoHbwhwdFzbZOtgtMlZIxX7aXp+LjOXJ5efOgiwIfCmCw4e49?=
 =?us-ascii?Q?ESAEQDtXOtKoa+IzMcsCt/NpiqVLx+keRvUE5lW8YHg+Zxephcz2Fu8nVda9?=
 =?us-ascii?Q?7juGPIYKitb3/tNh+s2TChJ4KOm9nnYV7fAmzJh0/Y9xv3xx4+ncUY/Jilh2?=
 =?us-ascii?Q?CQYnNEGo6atPOdFPDsYfgIEoXzcZDSuw9j55CbwpbaYWKQm27EEfpHPbbijI?=
 =?us-ascii?Q?giiLjvYuqhgMPg0AVYWCDpTfCqbgVkfBhrfu7w9/BoQfb0AMv/4kr+fqGpqb?=
 =?us-ascii?Q?cS6uopbIIyMLm6ES1VQTv0lD6P1mclShT7JyVOVnPekDsFcdqOk9xGhOvxFK?=
 =?us-ascii?Q?U0NUqMX+etMzLq1KigHmXn7w3Q5r1oLvlIZoufzcTwW9yFBDQjufrm2b4/Si?=
 =?us-ascii?Q?37LFBc/FetL0J4RGoHjtywPLjrIPItRkevff6cf9avyeXlYeComIKxhGjZT0?=
 =?us-ascii?Q?LrpiRejCyo0cYiA47x9N/HsLi66A9lwRdZ0XlydPgx6uuw0qdFwwVgbOeE2n?=
 =?us-ascii?Q?Rgb1mmz/NajKtK/UhG8db99oh8K+RV98UY5+4eFDvZyAJ2ekgA1d8to7YuaF?=
 =?us-ascii?Q?2tTtroA7CTF7cj/nAvbFTV6Al03MoloQoTr+VndNNdysTrQKIZDwbWUf1nDQ?=
 =?us-ascii?Q?u4xnvi5rdE/K9R9LjLjq4jCK2Wn7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUra1d4Xb+Q8xA2iCas83T4bmkOHGlp7ggEVFWpx0LLyVKgq/TOM5x0jGuzl?=
 =?us-ascii?Q?m7AtmxZR973cIeT+ayu5HW1SBFC3cD9hDoLz66o1c6p+XHR/2DiIoK0DGmRd?=
 =?us-ascii?Q?bgRekGa/nEE+24u6di2uB6nuB2+07c7Vx/DqXRBysnXBeyOSfW13E/Z+1Kax?=
 =?us-ascii?Q?bwZmOrn9wLTIWXzDZthP5jDW3q/4Y+L1FoAxcf85fqSkx6WgarzZ1bnbnLec?=
 =?us-ascii?Q?8C2NLvVrXd3yAefgyMvF5v53KqLIdPwwS62ogikLPdPUok3zfibh3FVnw2sQ?=
 =?us-ascii?Q?qg3qJXFSzuT6ssTpeDaAIBSj3+KgSh8iIGLbf16p6MqZL7yz7FSomi9RtWl5?=
 =?us-ascii?Q?v2MFfunyr9uokgDxjAHIGy+5kJSR0NwwnwyFJVOUnmn7GmAo+/7dBIPMFn2t?=
 =?us-ascii?Q?g5Evf3l8gRYiZFRLIe7Q06MAlBulHmAp2x0xfJqpulqduPDLEcVNTyr8MP7z?=
 =?us-ascii?Q?7HWshTRzVzVcj3paBMmllw16g6o4j+uOmhUERKs9r0CbblbNQbTkeaP7L67F?=
 =?us-ascii?Q?hgcJ0PfPADax/+SfsV7GOjYSiHWKsEBE1d25A+nMXQCzDIFL8a9Pb124fgWp?=
 =?us-ascii?Q?zv1LmP12xs4wr8V2Glrp20g0Ww89GLKAHCfdmIQ69pEahUM6G0ryroTLhVMV?=
 =?us-ascii?Q?l6itlHLnEW0F2I+YF7ZviVUfPXAoFY57dX+9StCUwOuh9bbSd5etVsEB+/uT?=
 =?us-ascii?Q?gIA9mCzmLldDus+cdLKZSeK4LTWvgc6E4ID+QyJTYIxIlFRXFxssSXPbKrG2?=
 =?us-ascii?Q?bTptC9fI8m1idXpt0fPVqZ0WmsJn3o05LOT2rCCY1ra5fH+4OjMKP9kLfP8T?=
 =?us-ascii?Q?DH13A+qIQcnq4WLhiVGbJRurlFTC+qHlYLhqzFR9q0DR0hI/V2lMPnpjwmpE?=
 =?us-ascii?Q?5IPUM5Vt7+jGQuu4ci7w7cZNCvSX/DEPDszdmsIWyMOgtfqdqhBuvExx6yh1?=
 =?us-ascii?Q?aiAI0CtL07TiLwnLouw9oJWYA/KOyEmRlkuJAtVcSx4w6Au7RTLnCNrKgXI4?=
 =?us-ascii?Q?6abKbJepGIe2RAccqFRW+LHF4AQBPV8gRYnhshWzNR7RwCvsMyxxx68mnfPs?=
 =?us-ascii?Q?oWDa8sjNH1UsDifnRq98gyi9zNs++kxigm6ZN0oSGAteTELpzHGbpDUlftqu?=
 =?us-ascii?Q?w+oxNDVFqd+L4xRUvbJaonatyEuWcOcLO4m9JX5NKGQe+gNpQTDUOgFmz8Gy?=
 =?us-ascii?Q?oV1ByKAq1a936PV7gxpDNgGcCHb6sdzEtWxXm2aXdaXBRV+K9ILKuatsMOES?=
 =?us-ascii?Q?Vi29uXR7YiD7OvLSD6SF4GJ9nQbPiYlbNwRKgCYBtZCxTVNt2RVD9tbZ5RES?=
 =?us-ascii?Q?OQkvLXZ0ucRwkExTAapcJIKNsLFFn0TOJOvbVBbARmdluueQ8hyMXoNQJmD7?=
 =?us-ascii?Q?LuLnqOQIMsiekq1bxipagKFrGnBwvzzQhXdaYa3O/yRO+5cUrQ6TrzoRpYxZ?=
 =?us-ascii?Q?3+ZfsoB69Puls8cvc9j+VKBUH7zo5P/QiQ2DDmcf9540MDwtKbpa5r8FJzAy?=
 =?us-ascii?Q?kxc6am0BpWNOj4drbvMEy4xJQffcaOk9EfaflFoafxjOMUITHUzD/0H/mKDZ?=
 =?us-ascii?Q?dixEnvrsoIxA5gP6UxXWq/1oTb4+Q3GLdA+Kl2yq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wmmNyiAee4ieLmmj7CB55nPy3w7e/YMINkwidxBvmvsu++BzqjLvdNgxIBcF0ZHAaEHQ5uOGKyi+dpbwsbmsMAfk7ZojOIpRKYG5nvou+aS18m7xOAeEDieCv8WE73wRx6dfXrC4KQDAsmTuTKqRIM+WfTsl4VBK853nHdZRaoHnIMwtPR54OmIod4rh+0nfY2OHqIS8JS/DxLVA1Ot468X+C47Lsadht35jEcEYYcQ7uK1Xyxt0jP0wKbVO20K4AnS51/wAYo4Tt2hQuIHo1sWPzCY+5fMVKPa+44QOra837yB5M+sh1kH3mT8C/aYw2d2s9r8/VgRS6EociNm/q+zSFWVI+GkO9FwJCaehJqalgVzbEk1KJ7Hd9Ys0DsJ+u3NAq1PsE/ChYI/tCnImDAlmzp1pfuKRTLixLjvzWejkpQtHJqYfWFGrj5bK2RVtm2FDXTWNK5X5ub4d+TQdxvbtSGD4cVc9YSd3b6eLhqOHAHY8GqiGOs35hV0v49o0XhuEDk4B/sLtT6vpVLwwIwzzsdleuw2fZL+2yXqEArasy9dRiR54J2qnnwhIeIr7z8BNJE8QzkS/rtIfYuoBLc/f0Lq8G6UyHDU+XO+2OoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a29d6ad-9511-4222-3525-08dd5459c4b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 22:31:08.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV1XWGeR9B+1fCOaTpxbfnSdjUQTmS1yIVjL9IQDXuq7ITFxp1thQUYuZaiIlC82Wr39OFHMkqyLj2DAUJCmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_10,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502230178
X-Proofpoint-GUID: _X09Px1-g25C3-W4qmlMPfVfTlMbffZH
X-Proofpoint-ORIG-GUID: _X09Px1-g25C3-W4qmlMPfVfTlMbffZH

From: Qu Wenruo <wqu@suse.com>

Adds the comments that were previously missed.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
v2: fix comments - drop reason for the nodatasum requisite.

 tests/btrfs/226 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 359813c4f394..afab5868b224 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
 
 _scratch_mkfs >>$seqres.full 2>&1
 
-# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
-# btrfs will fall back to buffered IO unconditionally to prevent data checksum
-# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
-# So here we have to go with nodatasum mount option.
+# RWF_NOWAIT only works with direct IO, which requires an inode with
+# nodatasum (otherwise it falls back to buffered IO).
 _scratch_mount -o nodatasum
 
 # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
-- 
2.47.0


