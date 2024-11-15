Return-Path: <linux-btrfs+bounces-9700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE69CEFF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3338FB315DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62B1D5147;
	Fri, 15 Nov 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o0hbkYIF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VLJbh1v3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAC1D4333
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682530; cv=fail; b=fSh+QAz2wmUt7uosEdSJXESPdj6xQQyRP9/BwF2BQMQTIWu6zuKDZh7gmr/IQ1PssS7bDpG+ptID2lPOhjnGa85c1NG924782D9SIpETUfGdmY7O86VsMXecWvxjbuOniOo+/kugUxDttXc9sK5G6E4F97f5vug76xMc76VIPBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682530; c=relaxed/simple;
	bh=IF6x5mYvckeHTvTazKiGkIzeJE3YO+IuSCld3rA3Pcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqyVhPpPQdm4fPPleccWru1cBcSyhGreSuRYhlw6ffobZQ79jrenm9LH9OeJ5vElQh9lOKRnVZtVfeVWqJcxbIwrvtUNOBpLcTxxRwmX6Gm5fDuuqRyNR0CQ5IXmNP5k6oM3qhso88HLWFMctIHiOMbRgoypF/hmdk4K+CKLy0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o0hbkYIF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VLJbh1v3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCVjt005695;
	Fri, 15 Nov 2024 14:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LgZOqe4iRQLYxW8j4tgOXK1I04zS7upotjpJMBdRX78=; b=
	o0hbkYIF50iCu7GurAYdq0gyYmCX28GmKvvCVNo8i8TShFELCouJB0KQfzB1bE2d
	XYK1jkjEQJBh8NzI+rerc8cymD5W6K5UxlG7p2iIclrkY7gKzLkTxtcxcH1M7cdE
	eFCW0AyM3rQchxqHOc7Cex5muMs8gnPHMP0PbYDV18wvnSf3cwW+X4h7KXfAYmQm
	OWHKE0aS0mv2Urcenki3YkBVrOzhqiubWppBEtGm0PuVe0b7HbOJXHKMZdy0yZ11
	DzYUj84v30wn8kYVzoffKj+bTWNqoHp809kwpCo442I/4OMeHtM83Knp1ovDipbS
	4TjTpLTq3jadOrhJ4MxQZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkmp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDGjE025853;
	Fri, 15 Nov 2024 14:55:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ca41n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFY3IOTUzLZ5rsACUs81WJqCOZkhmuv/q2HszrLV7c/H6I95lNXcH8NiHutZ/0ozuREj9EZe2BSNw6fzCI2aV7HY8Ky9PdEihAJ7a6BPEFvBeP0ABECsY44DKy9yy+zwuDHmTghba/oqiEllcymkINKvQs/Pbhy2HOGn5QL1BmYiTu4AHYzEcgY2Oz/SQRUgVp3RHNL9sU1G6A9bg1pxJj632eCeSdbRNpqRhfyXbCaKAkgKLOwQ39Aeg3MzauemppHOPTMU+uFvOaVjsoinAAVi/YDR+BhBizy/LdRjYxLI3h1wvKq6jtmyf5nBnqtC7gHJxfvfgBgaSyJj+eEqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgZOqe4iRQLYxW8j4tgOXK1I04zS7upotjpJMBdRX78=;
 b=vFqbLVbjpnXkO0Oe8TuLxOyNgeX+B9qSEz8aPUfoRwZwahdXW7g623DeZnbp+c+se6ACEmh2hAoB0v1Zjl9za1cQWRstGhiSNuPolKkBGvv0iDj8gXAJFM+mp0ZnIISBXsxdgyEb1ljlhmfxJQenRVGLez/i5Mb+FJgB8KkTuTW8SV/YG/hg4S8jMZwGwAGa16fCwXafTO+YTdTyrhkIz2wvBze28Wtk5F1OrFpaSEkKPTLZFCNslXBKmIAVkw2oAkPAt8k3HlLeFkF6qzbjmNPU89HSbuVc3Asu5EIkLDaZnkYdF3QFbJdN2hTP06MFIo+n8ldRVf0s6YHHgOD1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgZOqe4iRQLYxW8j4tgOXK1I04zS7upotjpJMBdRX78=;
 b=VLJbh1v3YuINWZlk2mKV5C2mWVVc+FjMSOW7HEW0nC8L4T8N1qzMvwmeXjcoXDuJgiPt1K5BrLsXFnR1hOoINX3m/jJwsbbYjm1CmW/AM4tGicDHIE/eH8JNYr5S3i2kaG1SALznBSeGbTXMrcYA4YnIT/hc/xmqeNpJdjneII8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:55:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:55:12 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 09/10] btrfs: enable RAID1 balancing configuration via modprobe parameter
Date: Fri, 15 Nov 2024 22:54:09 +0800
Message-ID: <6f5d7b5e910d5cc7b9b87adc91417402d3f3189e.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5987f6-1850-4c2c-51b3-08dd058581d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kL3avgBSRDakcyldaUVlwCTHbl3BulJHJ3CgXRKw6fb9eCpje/Mz+EU1kD6g?=
 =?us-ascii?Q?hl8o4cgditEMBmREkNuwuZcP5tTAaMvjRW3SyJhVh+tDmaXWadjnspbcAIAY?=
 =?us-ascii?Q?+sQPEbG92wQPfHQhLtt6HffpbrRN0TWY+i2pWKMxvUm9mfGQiT7qyY5Mbdmc?=
 =?us-ascii?Q?j5lcolWffXmkz0ZJrwi16yGT41Se2MOrF0hQtgsGsyeEf+zXVDuJ7gvcRI3j?=
 =?us-ascii?Q?I9YAY+Il5m8zqRYH86j1aIPXxcBAka33hSzzvfkq1FVtzLHRdfAR8ThqgMg8?=
 =?us-ascii?Q?wa+VGxnmD/Mi3XJuEMc51pI3EcucBtQvFydHUv8CR986KrWGRk98Cxfp/7rq?=
 =?us-ascii?Q?zLe4V8vu83fK2B7adRqGP1lAHVMEGXaU85pO5FCuolKoJyfd2Y7TGupA4sUA?=
 =?us-ascii?Q?rD6vp/5wxj6UTiBLRy2R4SsdWjg8Jvq0ODikQbkVNGnkPrHAAoq0H6bHUDY5?=
 =?us-ascii?Q?3r1dLx/OMXcSydIBDTal5GSbK+VbKUHjNOz0jWTc2l2N2C3u4qtEjzkjMJc2?=
 =?us-ascii?Q?e5a4bHuI2AM11SXri0H0yEjWloxjQE7Apj73yCA5/ikTOSYfGu5z8vUVELeP?=
 =?us-ascii?Q?ILdE89fcY/0gS7jbTiKiqVqL96w1Ena1l/uqCTHOFHfeT7fvgWn7MY1HuDMw?=
 =?us-ascii?Q?1cM4Wi7BAZbNlyKbEv85SMnHvo6Ax3wv3Z0t8bSq+PmEJmN5X3uJKuWB+ey9?=
 =?us-ascii?Q?VgEfNwY0vZsj9HSBGKkoYPopUnsjqQW0tL7Y75HVubPQU01ETL0AVnUHlkYC?=
 =?us-ascii?Q?FYa7bLxB0u7MRFTOXzByv7L7zrrvEbv1fEquuespBSkuh1bES+6R893U5kcU?=
 =?us-ascii?Q?t/1cY72glYxMgbeuT2S7zOZXplQz/TPB2BAne/Lbviu3akY4wculnbe7X26J?=
 =?us-ascii?Q?NN6yrf4QeRizXtxtfU+TnePmlo7kONA5NIcOwxkyZHIv2LV9AXLgBixfi95E?=
 =?us-ascii?Q?AK+31nNAtngZxwbTqG5B2TNQ1BppJvwIJv8ffeFn9aJpMgjd5XC/tHOZjwJc?=
 =?us-ascii?Q?j4f4CGKTMdVB3DPT7TebOQOle+2Vl+S2Wxe36h8WYr8stL1PNb0tZG53W/3P?=
 =?us-ascii?Q?aiYHCGKF7iJcPzYl+OD8dKpHPL47jIYOjmZvdJAeQAeWRXbSnq0XMXoV9ile?=
 =?us-ascii?Q?dXcw/QIm2TlzbwasFFj/0ABIYwgNRn+OMVXXOB5rAi0d3QdJGW3nchm+8P53?=
 =?us-ascii?Q?coD1QpxcFoGc2DtDNj5Iy1A0c0E6C0VF/HjciaH96+9C2EtfIsnq7RJ+yW1u?=
 =?us-ascii?Q?1Zf7j7NXlE6BDyRlMXlVNFAbJihc2w4BUUMNK4sKlfwMrSCrX/lbAD1ojrFh?=
 =?us-ascii?Q?eBiNAsoUIkdOnf2n0bakY7GD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHUuvuoJ1QGWmn51hdosXRrwC658HjfAhX37UHdMqzRKPouae0qnp70anRvi?=
 =?us-ascii?Q?NkXWP/iLOmAuVjDncHZD6p/pwl3LImafBHBlvtCF6kfe1zahMZDzjWjmsS2V?=
 =?us-ascii?Q?5SC4FqDY8N33oxlleI+Df3CVyXJNhKdvdquNRpib1mzFSefjF1INnzIqBU/5?=
 =?us-ascii?Q?ze5nm9fGAqhxpkqEEZm0U05bKqlQm4CxTAETWqCNlPReJutWV8kApwBHbobJ?=
 =?us-ascii?Q?0kwCtyfdmZsrwKp0OpNbA62yR+mujYnrbHFbNGMSJCwwYlKG4VN91NwpuVCO?=
 =?us-ascii?Q?wOHeez0g6wro54ecdcCKpatVEnfT3fkPlpUTPA2Gjgkm0c4IkMump0YqFh6b?=
 =?us-ascii?Q?ODuenk7khoSaEeCecUub6HSyq85wGIwTIcQS2km0QjNFbIVy5bJDBhTUblzF?=
 =?us-ascii?Q?1vTWkWHQ0i4uqxc7pgFXTT4nywbWxQCEncI9l6wNK4lPPxFuP9MTNx/W9Tiy?=
 =?us-ascii?Q?Kuxu6BW61J70jvASYn7VjXcI0TUG12XjbzFdJ2+RnaPNM7irHfAORSmnEfBX?=
 =?us-ascii?Q?RRnYLFPY7VwixyuNawAEf+/QjveLKfLC7vvaThCLGUkd/FXQwRc1voEOqfox?=
 =?us-ascii?Q?0iJJt4bCz2lbmLr/qvgWdJPnvtBjcJrbiBYkYU8hie4wL1HjMJlisAXYXAGA?=
 =?us-ascii?Q?IwOGLKzm0rWTjZWMMo0NhiZmcuccmt1DUxJxYFAgRpwftnmD2amD3ianH70C?=
 =?us-ascii?Q?0HqHoK+Ram16tToqqFi0v0QYUFG2vMfYFGEWX+D3BjyXqkICOic3KKwblDk/?=
 =?us-ascii?Q?4lTYIDcwDKTY1Z3rQd/y6ZOBCX6kfLCbB9e/ieiE6xsb6D9Hf5YYxnf03tlM?=
 =?us-ascii?Q?cO5cRKKj1ybJgMd2dAdUC1R4+y1sz1Mx0VmeVgo/AeDOAqJJJF5gFVdZr5Vk?=
 =?us-ascii?Q?GB/xaP47+3EbAF0qm2e9ODHl0wtmCZqDWM9C4Q3N5NhtAEe8x83+vIpAGYnl?=
 =?us-ascii?Q?s4MjDSLOqNoHaoJMdR8NbgnMozKL49V1Or32bniyXuoTDnMeGwvm0ToCeWkf?=
 =?us-ascii?Q?WcnYHO9nyKGxKXjODub4bxdZOBWq9NYxq8+aet0JMP2EsNK0Y4KWJbeSfZgQ?=
 =?us-ascii?Q?aFB0LmGWLRf/CHwN7xZtIRCoGCzkt3GDY5US69GL7nI724ASgE4VaRUAKwzg?=
 =?us-ascii?Q?8xgYYSw73CAEa68MEgrr1Zk/f9WsmUiI4Lub2i0lu4zFSwXG6DDp2HDnZonU?=
 =?us-ascii?Q?Fmc9ldO2qmMfL5OOKgeW3xS+KPKvq+9wYqfwVNOyxZbCsBQTLbSA1GHshQOz?=
 =?us-ascii?Q?g6+xrzouhXmfPc9+w/TCZw2i1vYn2TNWImGXnyzMBhWAdgm1+fq4MC0EQFnw?=
 =?us-ascii?Q?vBAsxrN0BkQWZbRLxBdKspwjeSKDMfSy9bBC2JK9Ssp5zFaJrvAuzwaFUrRl?=
 =?us-ascii?Q?XlLzKl3taExr0148RhQPAvgOMdoBMiH27JaSRHqqp3AOH70zt5Bc+V3t+lUM?=
 =?us-ascii?Q?rYn5XVpSy4lEbLuB+K+hJcbwz8j8bKxkakkmTsjoIh3DaMOWSUOmw3Rkb11Y?=
 =?us-ascii?Q?V7kWVLZ086qEf1p62gFTyArB7y7MrVkPTxBqkPwwT/7Emzo8vrr0tegnRsGZ?=
 =?us-ascii?Q?wcVRakBzrjZ95bkzG5YBLoVGVEB4qy/U6nEtPFUH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7gZm4pNvGAsk787qGHJ2m5dsmmkiavA/jgWWPMTErwwKTZLXvw2zY+OH+84tSgwbzLhRJ48fZmLYXRXLZqUktqkLUIOcVHrrJdQnvLwNCWOcBIHsc4EECZ/73eURcbu6przHAOKnBLfZ3g7GUHFlGRuUszTduirTzLNZ73E6YzvSIIHOWyg9UqcX8yKpOPcLttYaeG4FnrYQE58vKKjyu1uhb/1sQtVhn9jg9xLNfPgq4+5tfjfyAgSYaibHxhLHKNH7sgSEHWOwYoiBtPUTz/ImSlyDoQOTjLgF+WffwyAMxdxm2Ju2v4/vlErfodH99At6Fvof8EL7jRycgVix4DK6lZ+DoLRmWjLBLsPOtx+zrmYgqAOEmMz6SzrUn3Z/3g6vffrDpNsz5frAyxuO+5IQ+ccSVFsKZ2lPWpLYJaKQRXQAgCPAneOiS97ijaUFNT+FsHJhrS+fdjREpBGy4MU2y6Uq7hhlS/kNFay1n7GSGUmR1zkt5jQR/hJyzYZgTEDqMz80DHf6hOxjmKF0aAM1TxX9S8ZHJvrbqDhAAK+1fkX75bJaKzmnR08P7DRlcKrXXC6q6Gun2R9ZioWowbJ4wKO9cdw5BS50oXXFeHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5987f6-1850-4c2c-51b3-08dd058581d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:55:12.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AecLfWFo6yqzENLX1nPRDLB7L0SsqclhZopKtAWtjUxogeecCX8n7S+HuseJQH7XuCwtHrfIufozv5u+HPZg3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-GUID: t4ySHxbd2vRdx-FkxUA2roYAj3l2NZ0x
X-Proofpoint-ORIG-GUID: t4ySHxbd2vRdx-FkxUA2roYAj3l2NZ0x

This update allows configuring the `raid1-balancing` methods using a
modprobe parameter when experimental mode CONFIG_BTRFS_EXPERIMENTAL
is enabled.

Examples:

- Set the RAID1 balancing method to round-robin with a custom
`min_contiguous_read` of 192k:
  $ modprobe btrfs raid1-balancing=round-robin:196608

- Set the round-robin balancing method with the default
`min_contiguous_read` of 256k:
  $ modprobe btrfs raid1-balancing=round-robin

- Set the `devid` balancing method, defaulting to the latest
device:
  $ modprobe btrfs raid1-balancing=devid

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c   |  5 +++++
 fs/btrfs/sysfs.c   | 29 +++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h   |  5 +++++
 fs/btrfs/volumes.c |  5 ++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d52f7f6e2de7..ecadc8e0dcfb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2552,6 +2552,11 @@ static const struct init_sequence mod_init_seq[] = {
 	}, {
 		.init_func = extent_map_init,
 		.exit_func = extent_map_exit,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	}, {
+		.init_func = btrfs_raid1_balancing_init,
+		.exit_func = NULL,
+#endif
 	}, {
 		.init_func = ordered_data_init,
 		.exit_func = ordered_data_exit,
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 50b8b8847dd4..50bc4b6cb821 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,11 +1307,28 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 static const char * const btrfs_read_policy_name[] = { "pid", "round-robin", "devid" };
+
+/* Global module configuration parameters */
+static char *raid1_balancing;
+char *btrfs_get_raid1_balancing(void)
+{
+	return raid1_balancing;
+}
+
+/* Set perm 0, disable sys/module/btrfs/parameter/raid1_balancing interface */
+module_param(raid1_balancing, charp, 0);
+MODULE_PARM_DESC(raid1_balancing,
+"Global read policy; pid (default), round-robin:[min_contiguous_read], devid:[[devid]|[latest-gen]|[oldest-gen]]");
+
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
+#else
 static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
+#endif
 {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	char *value_str;
@@ -1354,6 +1371,18 @@ static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *va
 	return -EINVAL;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int __init btrfs_raid1_balancing_init(void)
+{
+	if (btrfs_read_policy_to_enum(raid1_balancing, NULL) == -EINVAL) {
+		btrfs_err(NULL, "Invalid raid1_balancing %s", raid1_balancing);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#endif
+
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e6a284c59809..f0fb0c0c2f7d 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -47,5 +47,10 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
 int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
 				struct btrfs_qgroup *qgroup);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value);
+int __init btrfs_raid1_balancing_init(void);
+char *btrfs_get_raid1_balancing(void);
+#endif
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 90d84fb664aa..2b31fdffea08 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1327,11 +1327,14 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
-	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Set min_contiguous_read to a default 256kib */
 	fs_devices->min_contiguous_read = 256 * 1024;
 	fs_devices->read_devid = latest_dev->devid;
+	fs_devices->read_policy =
+		btrfs_read_policy_to_enum(btrfs_get_raid1_balancing(), NULL);
+#else
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #endif
 
 	return 0;
-- 
2.46.1


