Return-Path: <linux-btrfs+bounces-11741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C6A41EBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEE23A3C7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B45245025;
	Mon, 24 Feb 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBARy4hG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A3ZLrJN7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6A23BD0F;
	Mon, 24 Feb 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399341; cv=fail; b=WdvWFV4hRhpKeduqXwTiIDa26n2V1Zmcb9mPXuzlMOLKNladoEILfwtJUunedsoLxYqvWmF4hrZmdeVeVedfY+KIOM/hW+lR8emxcXZSys0jZH7frk2kNlSn0iYq2mnPDzzGYiOM44L/b2sl1z5RMphsmlLpMpUy92S35qWnuVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399341; c=relaxed/simple;
	bh=uI9pPZNfIPcmUM5YFtCyG3TFbjB+jPBlcgkLfp6Pgls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koHZ9KLM5vcPSuhUOqC9UT7JB1tW9sXWHvjyrsImxsqtbIx/c7m4FUQynej/bwj5FoQw3xkTCk3zj7s0GZLYFwxvwakLPDwoSv12iKgBvxzG99KXnG8G1UI9/6BUr8lD1ERbpfVUFbc+4tVnz+O7FEuVLDq/dYnOvzsoOVdZ3N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lBARy4hG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A3ZLrJN7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMj4F017594;
	Mon, 24 Feb 2025 12:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s/QaSYrWfhnP5A3jumplwix4Y/tRkV7DX3GjUedR8gc=; b=
	lBARy4hG5SSOWuSqiLqfIzR7kdWEhg3+9UuokP6WhwFd1paedKyS7x3ZkhAi7xqC
	tKbVqoPvIKKLcATzbCOzCKviMJeOpLthgIMS3hcxKSSjfDGSASqU6QKIcQL47V1z
	kgRmtUXWu59P04cN1C6cGSU8JSqk4PjXpTvNSJl1UcWAZfVtrCTsRJiY//J6bU+E
	eEJqyBAYDQYc3HMUsqBOjua3rIEW16rL8KzUkg3Z3d0UMEEibPeKCSh2MzwAbOCY
	ntE1zxKPS5RCFhBL1M8MHmHAl1IwEDeX7ut+Jvr7W8cVd95/VWuIpfqnCtD1cxcl
	6KG7qL4N5TZQ3qXTrbrA0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5602ech-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OB0MCx007532;
	Mon, 24 Feb 2025 12:15:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51djuju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeJWWPKwrhubhbgT8WpyXHSNzbyW8W/PJ/G0c9rI9iNl+60CZ6hFOv1aU5F09GqbHOF8TsK70ZXQ5MkjXa2FueFcy981KFvQFjUW80Upyp3hy2CSQRt2V8Aa4RCh3nUsIM7MEBFJ9PPsP/T02KS0yxU0eyAYWN67rI+Mfual2UH9ML+nl7p+UQ7mE/MAk8kWWIj+XwzNPyP7nx/hJcOjjHoAGOyDfwH/W5aEri/J2RNFaGjXgh+LMfVuzNvaHT52OJICDpKpw9mpOXWC3/8Y+UhxJU4dqRENEtgo9VHnBHN1fATCoGHzbAZeDLyN+HhIuIUFBomnfMn8s3d1agjXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/QaSYrWfhnP5A3jumplwix4Y/tRkV7DX3GjUedR8gc=;
 b=w4MHdkKV3nhUY8MOhAyzUnqu5m3hbghZOh3yXbl/hd+ItLXhLLizZvRE2LB0P0kJD0TsVDuobO8eSpMlwRkNk7oR3PC51rDvncNCZDjw5Is1BfZGp6V9OfWSiYWjvtqmqiH4iuBEvKzYnUfKGTfOTLpKAKUwdCDkuHUVCYDSrtvJ9GUKzXhgFJrul7Ax6saJjvBlQsdts5I9LYn6WHqQ+tNczBI/oMJ+myiuILhujUb3xm8rfnHgT5StJTZqs0cZJ2odRmomHndvgpDB9eLwv5RVhBHbEr+XiTsDlY7QcqSBaL7GWd9iDWEENM0ZHxEpB50Itm/iXdwweaVtdCNRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/QaSYrWfhnP5A3jumplwix4Y/tRkV7DX3GjUedR8gc=;
 b=A3ZLrJN77Jl2+fz2tjBOMRqEz1NRmdMrADEjb8lmQ9FOElzWbHsKc6Ai7PhE/1+3l/q5EkBVVI83SG4/q+191G4mWCOYTTCGDctx6jCgCuoFBVr23QLsTq9MwStbRNjMi2nloIklYYaPBrTqVzkU61vNs3Y0PjI9k5S0pO5FO+I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 4/5] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Mon, 24 Feb 2025 20:15:07 +0800
Message-ID: <857ac8099f6e3f7d584d573a1e3f93a2271f9dfb.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1740395948.git.anand.jain@oracle.com>
References: <cover.1740395948.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d0e490-d8fa-4614-ddfe-08dd54ccf0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wVNYFyBeKF1oYZcje47B4HJi/PMompzUdaWrZPYSViCfMZD1tgZ3O2S5ZM8?=
 =?us-ascii?Q?ab8aU3UCpZ2PjB3cMJbKd8/ncZm+FAg872ymT2BBnpptoRyUoghsfi+OoBwY?=
 =?us-ascii?Q?j/aqrg/9Noy8VQBcdTXM7pv0knZV80lvYxiBlP1MG67aPg1r6LzZ+vcJxYJi?=
 =?us-ascii?Q?wfUBWfDPnbjZzbzKxBSKsjxGdlCTdhvYFJqSBN9DSnc6jIO0ouUIHm23Ej7Q?=
 =?us-ascii?Q?WTVEX01e7Tc3nZsfe4d3pviYlOK3Z2o9PpUwo6oMzcsAeU15mSFQYbjamyGb?=
 =?us-ascii?Q?UjuvTkHynxaTBrYJy/yL6xig/DfsSBBV7Z4fDuUTf6s78oIp8jbmnOs4os1E?=
 =?us-ascii?Q?A1bpLe3eiAQ1P/YM3fI3RWUeJNEnZTGiroSzERj9HX6keAvpeKQELN0j7Y8y?=
 =?us-ascii?Q?havdkc8xv954tTBGpe20/68yzzWykUIDHgQxK99z6zfY7qRirUImON71d2PV?=
 =?us-ascii?Q?EfQqdZ4BlGIKAI7NI2jP5SEe7GcDtn62QpH6UgPovaufS4xZ4k5wX0914Xex?=
 =?us-ascii?Q?ZqAOYXGhU0tgog5popAAUCLBi/+rH6IecOXDvlFaik9TO0jYDRZUFqJZOWSO?=
 =?us-ascii?Q?SsbFL+UpH6JIZNqaa/cpzrovFTtSExh1x3MexCAjljuOnIO5d3+RN8t45fxm?=
 =?us-ascii?Q?5p4WkpEDvKDRT+0dfjkjWx00kefFNZ6t0474mwqFOHpKSBsmDFTIUhTIn92b?=
 =?us-ascii?Q?1i4QYiIPYGvyB22Cl2SCfw5O/wlaUYLvE/iVmckV8MTrfvmoARDHNOrHbXJs?=
 =?us-ascii?Q?uuD3hYZCZa9u3Rish5x2hO4ms+bKd6FPpLSPsaOb7b6mGx74GTFn1ijyo7CL?=
 =?us-ascii?Q?jYtK6FG22W/8r55N71Oq500+rfRvmsBHS/5FgFrIenHgOOTvYAW0eGKfe88O?=
 =?us-ascii?Q?h0Ox2T1/xcwOWCSrWJlnLAHrjDuhmqmXxqipyi/cSlfORDCJz6uNJszmzzHN?=
 =?us-ascii?Q?tjs0EWbwTfNbMk2E3KDu5Z4Emd1E4KVcnx/Jp4YdiV+qJ2rVwrKpA/BvYxto?=
 =?us-ascii?Q?S8rNNmg1Qv4QCQD9lR+kTmjPdCujKRLSGuBWw4idHrsEaZgnh9SmxXCgTT4P?=
 =?us-ascii?Q?3tQralZzSFV2tl8dReIbxgog7tQCoKzzistbwYfEl6Tru86s2Yva/QI67J7f?=
 =?us-ascii?Q?fPjf3VwFPe4O+T/bGza8eU7hz95GcwQOYOksrkygHE5qJf6co9dM7bKD+Nx3?=
 =?us-ascii?Q?p3sJvUOA4cur5yA8uDpTG7LWQukSknpBE96Ei4tXOd6O12xock3aH0XVJrLo?=
 =?us-ascii?Q?m4yeW9tbLXRdg2VvZewJTz5N94Rnm43ftitdnAQCnLOUYC+pcWL3BAit8hBq?=
 =?us-ascii?Q?aMdrYVW2IR66XPLRx43CVWFetrWu1KCeDBD8ZaDNDgcZ1n/i8ksEz2zzIubm?=
 =?us-ascii?Q?hSoxtvuyvZ+2PWv1dTZBmypsqaA7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xf69LmB2KU9yciGNOol+fbDawHKK/y5X8SSp4+lTkkwhOBcligiegjEcYIXd?=
 =?us-ascii?Q?Xdj/xrqMg6XiHgnJf2uAVdqnDJdcmBKTRg8CqJcVYAiqVRjjp4ihQju+91lg?=
 =?us-ascii?Q?LngCJlKPA63TpHLypYjn3zamlCW08JhM6BpYoT6vBxJbI9f8isO9Rc+2X0rN?=
 =?us-ascii?Q?THBPgFOMYx2QybcZYeY0JVGl8MU1lIQ2K578vHzwAcc4pnDIyxivH3F0oIyv?=
 =?us-ascii?Q?yk/KUWQLjHB6ZQV9DxwjMm6mpFvA4p0WEVxjv46bAGENk/8Hu8PrOHNTQXrf?=
 =?us-ascii?Q?FLcuuQgITZYWgDHz62bbMYDrH6s7PIfHU02YXHAYcC/JmtViIQfy7rS+X8NP?=
 =?us-ascii?Q?ynJoyB5p29GgJrsEnfcP2wjuCBvS8TCW6DUVNGtd0xWnYBom60IiQyC8m4M6?=
 =?us-ascii?Q?lLXSHVcCG+mE/zmuzupbsRJI71iM+zlRfoJLyb5ZLYKv8U6XrNL0ugc0m3AD?=
 =?us-ascii?Q?yp50LWrtt4o3413NHa8ZcfsyMqHVbiXLxhIFgQqiroJzetQP/Dh9YaXlI00d?=
 =?us-ascii?Q?zwExamhVrq+SIuGmsEYvniRZVMGpdgoYkMbS3///NQSroGhkRMI19cUtM5Pb?=
 =?us-ascii?Q?N6ScNX6+ttN8jWxAcb9fMthKaBvPGF3kVfU/2V7EjC9DhoSxMHU7JbYZiOHi?=
 =?us-ascii?Q?ogwIOyKn6/wipmITm0UrpSHA7uqmOkVM5NzspCz9ORTBPG1dIr/cwHoQIIXi?=
 =?us-ascii?Q?21+G+OjT8F5PwN+IUvcH65D8Njh0aI60gMeyVG19f5YyNIG6RABqnlfOW4Lo?=
 =?us-ascii?Q?R/3UBF8IJFGUlquoJ2qkqQV4WItj8WV1EMbqHFaQGuCifAlabMdYYpqK/gPO?=
 =?us-ascii?Q?/ehOcrrUMThySuh2XFTKMCRo85GOJ9sajiCKFF0GBSVf/uKWCuQN7gAS1SjN?=
 =?us-ascii?Q?xxRcEP0SWJ1rHavS0JsKUV6ibbB3VEncXmCWq/7xIMDyhz0Hpa+b5237heMz?=
 =?us-ascii?Q?+zjD3qr298u4FzAe42EwdTCFGjCGnfNpX8VKE3j1BbRmI/DB2U+cHAaKQ5HS?=
 =?us-ascii?Q?MnQzMxB6lqGTEt5uJOomGaMqAf8/4+VeqhxyWnsspLB5Ne9xRCbRMaMb15p3?=
 =?us-ascii?Q?Nyd0hh5Grt3jmqFVLhD1alTaVCCsaD0Q0zjdY5gji1pQ0NTjaNz351ZWvQby?=
 =?us-ascii?Q?92qo5K2zogFe0lZxEDL1zW5M9xQakNSfAsm56RSIK6+XgtTf/G7S4UYn8QDD?=
 =?us-ascii?Q?bD4RR5zvZOaLAX2i11ZJd1okYoToAwQGIrvGWh12DV5Mj61rJyJO+uoAO8Wk?=
 =?us-ascii?Q?elYWvedhH2izQiPvkYE7n6iaQRPwgpcWQ3CFPlCEAuid6MKRZ9mFABFjC3vN?=
 =?us-ascii?Q?WhhWff1NiZXLe2c1lIaWxnpMgDzMKSWgxK9kWJn+5Lb8chOBK07FOHZHgLqP?=
 =?us-ascii?Q?/KcwgjobxbRSlRlExmzpItyPI9iUQmpDBc5Ry9hgBr2raIjlXKWY2Zskm3D7?=
 =?us-ascii?Q?tF50tUlfkhrGgt2qXEK0ZPIt0+R4+lN/gjlcW1Fpm9h/NT4dmeN5shuHxMWr?=
 =?us-ascii?Q?iAJgPzW1P0+0ME6qGoMtgwYqO8ioEQabZyA0HF+SFFHVyDRJJknHr0O3vd4Z?=
 =?us-ascii?Q?H380KXgtkILdTV5uXeZsG2gCODT1IY1/140cYPcw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4/NnlhPV1RO5GUV1iDk60mJVIrDkmH9yB4g8jooJ7opt/CsFMMFAlY/51FeXidp9UNPoaRcpNNZ5nIrs9wjygpwmJETwxZhSVKz+4vK2rQya/uGxcV75wLQyGJLzwUkl7X7zzk2pTI9MPYkkP/r4KE51VGyr6a/PPRF9h2a1s2brhQ+W0umy1aEKRVA0TYHuj99SYSQw/rUNU+/5CeA8oy3A5kKQxi7+UgZ3tXLutcZDb1YH0VcYAV3AcWsz8DpS+P4SR2hFcCoPrMvqUdJZz+ZSREEPMBvahiy5BerEfvgkE99SqqHn0hfiuRaoSD0VD49FQNNun1iJ5wfx8DAsq5EQWHwuiUNpJi47aZwEExlufEJ/f123wnOmZW9W4WKCmftVKBOhZd44U7jl7VxW7b7AgCI1ydSZOtoGmjv3Sjyc/q/JhLwXMho0AXV2HOuLEHafozW9I9t3CEgFmuDMq0ECVeybXlxASux/J2CO6I6tqRQTcKcOa48x1GIA7RJNB6axyHFHcxifm2XlYnUo2Sjk8/n1ju6SFI9osd0dw3jaidsl7h7GylOO0/j4Bd6rkB/CpqVqXULFpBCF0eJnUDsDIYTH74u4UxDWbhqM79c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d0e490-d8fa-4614-ddfe-08dd54ccf0c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:34.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLZ3suo7jHsVsNLo/pA2h346h+rAJYf/os2ZXEcXkHXy5eXFKQ47nopAvVQjoSneK1FKxyAgNbWfkzqRq/ajgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-GUID: w_1JvQJEE1WTQ7dV-esvfD2QM9SZHfbH
X-Proofpoint-ORIG-GUID: w_1JvQJEE1WTQ7dV-esvfD2QM9SZHfbH

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 19 +++++++++++++++++++
 tests/btrfs/329.out | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..48849ac82706
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Verify sysfs knob input syntax for read_policy round-robin
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
+verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..eff7573adb6a
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,19 @@
+QA output created by 329
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.43.5


