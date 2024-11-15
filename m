Return-Path: <linux-btrfs+bounces-9691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F0F9CE69F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6C7B2E664
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474641D4339;
	Fri, 15 Nov 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hd41THvB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMcIhjAl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB91BE87C
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682494; cv=fail; b=NIYSZfkCUDALnBorILdcFSXm2ApQEzkVevK3Nl0GqID0Lo+9YFRwOO1hoRVV76kYh0Bv3XDqCOLW7jxNYCIe6Je7vHMYTKSCtVBvpDMKo27srGxxPGisN9643kwV12kYwcOmtD4a+1b3VvPp1wqcpjWUdbb8Y5ZRN/D7RJ4xovw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682494; c=relaxed/simple;
	bh=hUsxHWJu5tutK5wYaUPK6y3Sttz2hWxEHJ7X8jev++0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gkKLMFRH7U9gZeBS7QG9xAR6Vc+TzX1YcwEqELxhNRS5lGpSsIaNHqDi+lP07nRS+nchvSI9PRQB5paftSSqCBxOtXTyMIYjJMfSlyB3MlUPVj/SUo9I3cbm4SzWHRA2Hkub+UM+mSR6yNiFg8X31oEekkTvrbIgEarggXwNRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hd41THvB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMcIhjAl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDHrt031715;
	Fri, 15 Nov 2024 14:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=2y8+QxizRAdIkDHW
	C0KH3h7UUQjYP3zSQbzxwhTEnVc=; b=Hd41THvBqMjn7hIvps9zoi/D3NVYFlMJ
	MF0OAJLsMxF637ld67V4NHRG9XI4NJYRXnEFBwq3l8BLIAnxSI7q89dN/27kG/yN
	g81v07zJgkM6X5YBKCVejoVQzQM2qvgPcCZRkgVe5H7jOtQX7m4z9ymOpOzcUY7M
	haQu1wzDPkiIIKdKPQiXw0KWkpY0JNYeWsr4KWYsorFdUBmsnQNAPuogEkyF2B/Q
	yHbkyxY5zPvPmo7AOkuBp3w9nQrOu9yjYkFZzS36XsuFS/1V5J6XoFPixQV5OIzS
	GolFGM8Ze5gg8/dIvN8p6te5xnFBRi66Kuze1hP7DajUcCTJH7dm3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heue3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFE1mv0000430;
	Fri, 15 Nov 2024 14:54:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbpwgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmAVyj83/1B2dlMk6RRMamVo5gFIfuf+rLSFlC6cClHqdrr3RJ2B0hGiQ3yRyg7zokR8JQWop1emI4GrijzOGs3dozlomncnYsSqKkEhJvzv+r70ZGezKBiPA5b9X7k1bPiylRc5oksRUlFGB9Pzl4yirSJadSVi+DyEYScKL1Q+YvhZ+ilNtz8rXQBWOkk+U2IptWigGakdFUP1yHMyATjyWymBqsgYlhYrbKtI/SiBHX/JT2efLXO1h/MHEL11CjnexUiZo4RpeXR/4GApikJSB/KkuahoRbcVUTPngVIILie0ShFtX/zKwzNyDsIYZMbcRdRwQ+vpi19wFY6umQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y8+QxizRAdIkDHWC0KH3h7UUQjYP3zSQbzxwhTEnVc=;
 b=DhrYbdaYsMD9BvWYivLl7sy9jiJq1Qi5BWplLy/lVua6ER9/sWYdQdUP7/NgzOFlONkSy3Vsw+L8TApSXx1xR7SP8Oq/1lD+mqP+YJQMbsaklJG5gi+dRQsJuHz5I1PzO8k4FzRGF3mR/diwLb+sBG531IgqpHctj7cZDU4vYGrBkU0jZoz0qKV5V7SSsO1a3EUoWk8VCSQlMKwmFJ3w5DhAu/1biVK5kE/ikykhcZRydVdD5Mwr2WPnBlfYwBPwhzQUTMQ07tJW0jtZN3SXOeyDfz2GA5kEOJ+zh/FCi3dkcKC50wFVQ2uiU9QLkct7/54FRvcP9AJExELBekld0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y8+QxizRAdIkDHWC0KH3h7UUQjYP3zSQbzxwhTEnVc=;
 b=TMcIhjAl67Il4LOj4bGmxZ/14SG2JJiyK5DSPhr8fsf3LIQFpBVMWDK07mDJKXTVopcDfAgTjDQYH3lR8h1r/3S53h2dspkh7JhHjwHsPuO/YKJNkCEUwjE+n2P8EkkhC2v64NDJA5ut/IlodTfdr59rEsfA/ua3FGCzuAUgkC0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:54:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 00/10] raid1 balancing methods
Date: Fri, 15 Nov 2024 22:54:00 +0800
Message-ID: <cover.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 596728ba-a4cc-4247-6a66-08dd05856d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4L3RgZGzSUET5GdWoBecAQcV+m/WFZWzh3PlPtxx43X2K3ktr6wQpkfCm6N7?=
 =?us-ascii?Q?HGBJQywxszDS+091EfkPWOOCqWDfvs/ca4riB1+J7NN+EanhdMO2rX5hcEjU?=
 =?us-ascii?Q?myMJU9B30KE0ZDyaklPPSnlZ0AVlRXBDm7cUApmw35/jgHsTfmYN/0xlHMIZ?=
 =?us-ascii?Q?2OO7yFSQwE9NxqhC2+yBxgN0AA+jqDp3Bkx8nWMJ4nFu4fSmEThfoE4s7L7b?=
 =?us-ascii?Q?aE4hpl+CDUMUhCfqv8qvYj6NvCsa0btVbNEUg0WC4wPllxTE63y4TuqzOkqu?=
 =?us-ascii?Q?1UDWHxHMwkzXBPglfU2MiXywGADJuf0UHP5g5xgPlyNLMxCF+Iaa1FtdwlRf?=
 =?us-ascii?Q?0FFr6wjAQ4cJPyXNA+zhHtGp7R8pIXvIm21IZR8zctN6l8JLQ3fN22c3ZTPo?=
 =?us-ascii?Q?Hah5yMKypCgg6jnI/EmGQSWptRlMSD803YP8JY2Xa8S3gSyU3C+C4AYRLbG2?=
 =?us-ascii?Q?N0q+c05i96LNN30cszx9yD33QC7CRDoi+cyRSpFWHvp6luO8byG4aceCYJuq?=
 =?us-ascii?Q?Fx1iE5K0DQ0b5+nrZBjN17hO4iFDOWUKRwZnZ9TYf+cLAOJtOI1WzKknzE2n?=
 =?us-ascii?Q?n+zSkf6Aq01yOsJ2AtUi5HJqCB92Kkja009QNo1fvoy5wJX5/98LHsYgk61d?=
 =?us-ascii?Q?wDuY4jPxRrAXxFl38YicvMVOeA1jcv6oqCESnnVbBNrGJqbtAU8gsFGZ/D1b?=
 =?us-ascii?Q?Kv/1ifdeOihPbSuTqUw2IHhMiA5vkpD7mCscOG2Lgrkg9r3keGaDhEbzLKuV?=
 =?us-ascii?Q?UbnySoZHvaxA0yPyh/w3juU3S3ZWKjoqm91WoBfuT64+vZ5oilzGB3waheiX?=
 =?us-ascii?Q?AKzkVNnJFRsPl2UjqVFjhMqUet/ZgSChYxOZgJrBlqYuPa/SCdiqAkdEJDUr?=
 =?us-ascii?Q?OCguoN1RgiZUae2L1GM9/mk5PiorbPO+q2fNyJYhYfISPdn9+zcdoWhYcumU?=
 =?us-ascii?Q?IfTDJOfZf2/LutR+GWiYT7e6EZn2Qmb19DVGtpuFp2+NmHXtmaQ6E1o87DBD?=
 =?us-ascii?Q?anCvbdyDoVwkQCP/IuY2UWK6fzaYm0/hFkBbDNSzg7Q2YFT/N6XwuuEdQGRA?=
 =?us-ascii?Q?HXca5+MHSZbrFVc0TsMYJPjoRkc/UTpPSVeMiKt8KqcTsK+PAtfQcvqwmzmJ?=
 =?us-ascii?Q?qzqv7r5MvT6puwN5KV+XgBPlXCHm+DOep3GjRHGugyTzlsoZ9TC05nDsQp0v?=
 =?us-ascii?Q?XrwGh+3QPcTque47aMUsfP6Igm6wy2eE6LusfokmOK5+wgVxG0uvHVIhjW5B?=
 =?us-ascii?Q?3oWoyQt0IYEjC4wXszVBB0ugJqPyEO6r4/kdhgpn7D1EKbeG0R4kXOg5rICX?=
 =?us-ascii?Q?jEzk0In7shxyWQW5XBS+9Cot?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFIrDSQ59/CFFZgJ9UtStirPBEnAsrd8Qq1/cQWYLeLmXftP7OG/2iEI8KOo?=
 =?us-ascii?Q?uoMkHiqJr5RiFNnGIulZfxT2oY+p0Vp0zKsZ6WvM/QLhxuRdZhGX3rLpckqU?=
 =?us-ascii?Q?IT7sFsrnLiwV+jgyCCEHYB5/rQuziriq3XNPO6F9poRj6V3/nlAMa64Izv94?=
 =?us-ascii?Q?hnhR06m/7wz5lAZvYVJ4PyKJrdQUKgqPrbJQd3KniLiZl5qhZid4CSqx7RD+?=
 =?us-ascii?Q?rHMnI0p7OyllotXMklOMiwz74qQ+GHqbt5TsUUDSC4tOOb2iP1Pja21DRuzy?=
 =?us-ascii?Q?Ywke1hdOp4dDt3WCvux5xWNT8Dfu8/h/3p6oB55b/kFEn5gSgxiJq/1Tmkz4?=
 =?us-ascii?Q?aIEXEh5TBEmAA61r3hYks9w3p9X7FXpfv8qNf9hce963/446CAPkugbKTL5c?=
 =?us-ascii?Q?d55Ul7IPwR0VRh3ISO35XQcj79UxffSoyu6D+JlLOZeZ9zPN1UXZypmOVqeC?=
 =?us-ascii?Q?sqB7OpLIIWv4dX04vAfJvqD0Rp1TegrWqNq1+cAFfym7J3Jt61WnrUW/g9aM?=
 =?us-ascii?Q?IAArwwtIYttCptEbKget/Ay40vBZG0N2NI95j75Ee0Y6T+WWwNkGSdRJFS0p?=
 =?us-ascii?Q?kYl/PO8AyYgNuRVa+YahetIHoxifJ1fFf9AxzSdoNHIAYvpoDzpZ9YXAMkl0?=
 =?us-ascii?Q?TS08blWuwR1vbXL43r5UWUqzP4TylgzBZOMDmWW8mzGqT297Mq6uejJC/rAb?=
 =?us-ascii?Q?3WNZuNhs0FtSlVQR8ch2pkkROOkFyvVfSoDyyFUbPH0YejMWtGsOGtMnCRNm?=
 =?us-ascii?Q?x/4dc53Q4fgAlMB+eL4vvsr02Oju7HW/r4t9w0CGtn5pKc2jr0UYbrMMkmke?=
 =?us-ascii?Q?/J+h+v7Hk/HGKk2b0t8AYxmnHsgeMbQNISglB61J44THVl2nHR5+1V+OnrhX?=
 =?us-ascii?Q?9Ghb+8YlbX6F9OsQln/JgX9217DDHyd4rGrrPWcG4cNt4MEB70w5R/1WhTun?=
 =?us-ascii?Q?i/UsbB/HpKkE7Fi6HMSJIW46zdOo6CRosySSd7sz274VGfXp3Mkd1scbiJVO?=
 =?us-ascii?Q?rqmvRdn2vA2TnMWcksC0qPUox/MW3Y5g4K+QjdO2UGvQa0LdTO0u9/8d6QqJ?=
 =?us-ascii?Q?TiFORxy1CQMh8jA7Kho2Onmm2C2RLkCCNStLXlE2voszCMNe3s9Yv8Kp2+QE?=
 =?us-ascii?Q?z4I/RoDu5IoUR3Db0yfftPdllt239qjGsQqHD+lfjLI0kgnPB0VzXCEYHgTd?=
 =?us-ascii?Q?PjTrqS5kvmmJcZk1c/xxW5bgmRv7cQmvRJ/gJ0C0vsqW1kDbOwWslakVpNZh?=
 =?us-ascii?Q?I8Wi2dJhBiMWDMeMTfy/rw/rZOf5xKspxzQgEAlQEjJMTMHFkJmr31aWg2kL?=
 =?us-ascii?Q?75ZSjGONCnRVUiSXIc9jjx+fXKpaqUr656yBsqT9EfMquypM2Mbhm7dMon/1?=
 =?us-ascii?Q?x17GDRUsI+/GTWNknQh16Y6Jw9itkFA1fTiS2OLJds53HB3uuDG9gSBVnell?=
 =?us-ascii?Q?l5xeoDVC9PTH7UZgQsIWAZNH9ID/ZOxJO/qqRVEOsRqMopNWwWBsN/Quo7ur?=
 =?us-ascii?Q?KT7B9QWN4lPipQCNEz1aMYtj9RziTjvxm3PhR6KDR7jaEsrNKQXzxa4DmkNZ?=
 =?us-ascii?Q?gTHtpXf6QH6zMy2wAU6vtjkj0dD04C8Hri/Q8qZY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9RMpyqTDGmjdw3b7/h+15m7CTKg2BF1Z9OBZeSORXUahLM9MnjISBgP3x8+OP63soj15VOK1qCmVgrPH3LiA9X/4wrhuiORYGO6nW3m0To8u6wZC+0o4HjRGF5YuMObBp2hgOJy0qVp+Mb69YjQqejUH5voxaQdGDWnXNRfNuaUholuSj8odkW3sAe3bedVQFs2x4qh+UogtQ06u/A8oN0KuqVN6nCrOxwcdOvjl0v/oqlHfMjr5g9TuusatG00gjwe2I+5m459lGWi6ZE9vAbtATGNxc4Mj/i4z2aUwljBKXcZmtUHVz59uogd4a292TAEqc4fPgkdWqp3wm96LbiIW6RfauHzY3qgi8nKSsz9KcdHgLQKTGJG0X3F7Hd9D7BiVWaIBoW8YgQzVEOZCQaM1WIV8MPDArHXa0HbKFGQf84ct/KTJW4sx6rAms3Boq9wJl28gSzIm/GSAu7+Sq2G2XIzCcV/gY6wZwH3gkA9yIHhjgQIfQvAImkss2YBjwpGpetlwKMbqJRZmL7XjKPQsdPEA4Zo5mVIj8dOumDLeuV6PEs8reaxiL6eSooPndAKOgzCPiObx4bB+XLFpPKH1H09cZLlobGp/lW/rF3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596728ba-a4cc-4247-6a66-08dd05856d57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:38.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRvUNYuRqVpXDz7jyDqLLzu+dWuimEkoVLS4SbVK+725IcD8P3fUMssU/Q+MUZihlQsQ4T6U3zb2x5CoDLXzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: OHEinb7Ly4viWk51NlJsg7VgTi6KHxRy
X-Proofpoint-GUID: OHEinb7Ly4viWk51NlJsg7VgTi6KHxRy

v3:
1. Removed the latency-based RAID1 balancing patch. (Per David's review)
2. Renamed "rotation" to "round-robin" and set the per-set
   min_contiguous_read to 256k. (Per David's review)
3. Added raid1-balancing module configuration for fstests testing.
   raid1-balancing can now be configured through both module load
   parameters and sysfs.

The logic of individual methods remains unchanged, and performance metrics
are consistent with v2.

----- 
v2:
1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
2. Correct the typo from %est_wait to %best_wait.
3. Initialize %best_wait to U64_MAX and remove the check for 0.
4. Implement rotation with a minimum contiguous read threshold before
   switching to the next stripe. Configure this, using:

        echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

   The default value is the sector size, and the min_contiguous_read
   value must be a multiple of the sector size.

5. Tested FIO random read/write and defrag compression workloads with
   min_contiguous_read set to sector size, 192k, and 256k.

   RAID1 balancing method rotation is better for multi-process workloads
   such as fio and also single-process workload such as defragmentation.

     $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
        --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
        --time_based --group_reporting --name=iops-test-job --eta-newline=1


|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
| rotation|            |            |        |        |
|     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
|   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
|   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
|  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
| devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |

   rotation RAID1 balancing technique performs more than 2x better for
   single-process defrag.

      $ time -p btrfs filesystem defrag -r -f -c /btrfs


|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 18.00s| 3800   | 0      |
| rotation|       |        |        |
|     4096|  8.95s| 1900   | 1901   |
|   196608|  8.50s| 1881   | 1919   |
|   262144|  8.80s| 1881   | 1919   |
| latency | 17.18s| 3800   | 0      |
| devid:2 | 17.48s| 0      | 3800   |

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method is preferable as default. More workload testing is
needed while the code is EXPERIMENTAL.
While Latency is better during the failing/unstable block layer transport.
As of now these two techniques, are needed to be further independently
tested with different worloads, and in the long term we should be merge
these technique to a unified heuristic.

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method should be the default. More workload testing is needed
while the code is EXPERIMENTAL.

Latency is smarter with unstable block layer transport.

Both techniques need independent testing across workloads, with the goal of
eventually merging them into a unified approach? for the long term.

Devid is a hands-on approach, provides manual or user-space script control.

These RAID1 balancing methods are tunable via the sysfs knob.
The mount -o option and btrfs properties are under consideration.

Thx.

--------- original v1 ------------

The RAID1-balancing methods helps distribute read I/O across devices, and
this patch introduces three balancing methods: rotation, latency, and
devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
option and are on top of the previously added
`/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
RAID1 read balancing method.

I've tested these patches using fio and filesystem defragmentation
workloads on a two-device RAID1 setup (with both data and metadata
mirrored across identical devices). I tracked device read counts by
extracting stats from `/sys/devices/<..>/stat` for each device. Below is
a summary of the results, with each result the average of three
iterations.

A typical generic random rw workload:

$ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
  --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
  --group_reporting --name=iops-test-job --eta-newline=1

|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
| rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
| latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
| devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |

Defragmentation with compression workload:

$ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
$ sync
$ echo 3 > /proc/sys/vm/drop_caches
$ btrfs filesystem defrag -f -c /btrfs/foo

|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 21.61s| 3810   | 0      |
| rotation| 11.55s| 1905   | 1905   |
| latency | 20.99s| 0      | 3810   |
| devid:2 | 21.41s| 0      | 3810   |

. The PID-based balancing method works well for the generic random rw fio
  workload.
. The rotation method is ideal when you want to keep both devices active,
  and it boosts performance in sequential defragmentation scenarios.
. The latency-based method work well when we have mixed device types or
  when one device experiences intermittent I/O failures the latency
  increases and it automatically picks the other device for further Read
  IOs.
. The devid method is a more hands-on approach, useful for diagnosing and
  testing RAID1 mirror synchronizations.

Anand Jain (10):
  btrfs: initialize fs_devices->fs_info earlier
  btrfs: simplify output formatting in btrfs_read_policy_show
  btrfs: add btrfs_read_policy_to_enum helper and refactor read policy
    store
  btrfs: handle value associated with raid1 balancing parameter
  btrfs: introduce RAID1 round-robin read balancing
  btrfs: add RAID1 preferred read device
  btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
  btrfs: fix CONFIG_BTRFS_EXPERIMENTAL migration
  btrfs: enable RAID1 balancing configuration via modprobe parameter
  btrfs: modload to print RAID1 balancing status

 fs/btrfs/disk-io.c |   1 +
 fs/btrfs/super.c   |  22 +++++-
 fs/btrfs/sysfs.c   | 181 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/sysfs.h   |   5 ++
 fs/btrfs/volumes.c |  86 ++++++++++++++++++++-
 fs/btrfs/volumes.h |  14 ++++
 6 files changed, 286 insertions(+), 23 deletions(-)

-- 
2.46.1


