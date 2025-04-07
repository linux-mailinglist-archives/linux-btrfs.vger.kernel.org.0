Return-Path: <linux-btrfs+bounces-12829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60698A7D2A1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A98188DB18
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19759221DB1;
	Mon,  7 Apr 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBO4N94e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cc/apqdT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60721A3A8A;
	Mon,  7 Apr 2025 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997800; cv=fail; b=W6vOnOdqmdmGb62LtpuA/ld5GPzMclHxW+3YtQKRFaVv651Fel9zXMzXZ+79jBJl2x13WKxXRcR88hqD9j+MGRT0It2asuU34kEjYv1rz9LYtTF/gpJsSgUi9hxPspuf1QXH1CO+19aFlvT1SLxmU/XN9E4VLQ0LlLctRDPTNLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997800; c=relaxed/simple;
	bh=RhfEqtJgBdB15cja38uaaryi+F2zJAUkguGPwA9Dazc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tkh8hijaPa+Z20vrnKGAmiizwUkAYvuEcdtYHm7y9IX+awnfsfurmfIcPZfIUNK0ifGVG+SATpyij5YUxYFD2XtU49RRCuOjq6IHVEOP2nUqYvgB//LEiH896fhKNILuFm3WfT5hw6ifkQgs1qY1EUF+P1Cuy98T+0H3AXQb58M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBO4N94e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cc/apqdT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371MB1p028184;
	Mon, 7 Apr 2025 03:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GqWqe6tXAyLLVqJB1yto8mk4kYzkAizpVAPnI0qkP/c=; b=
	aBO4N94e/h9v8tunC5W4k/z8XuTZgZIAnEV4LwGJGO0AkMEwSrQ95eeie+blbIAV
	jhpqv5xZ1OqjyU0+PCUDKzED3H6cOk6sVEnFo71TQVb5VUCMR6BPLA341gIJCLS/
	rerPEooay37tMOKghfAuzlIBcHAyhxHcJtpZrHr/qpMQm4m0VilNPy4xuQoi0d81
	RU5cwSwQBreqCSPeaQF9xhKsdcCWLG/HU+FN5TUyOzL8Rfb+KABA6i+lyugb3onS
	bTdT7hdelaILAwTNGiuMLZvr9L/dztyOntqxWwaf265sCrjRv5gF8H3qPbU5i6HK
	jqSrRHHzXlrVzlIcpSieSQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2thp3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5372tFd1013700;
	Mon, 7 Apr 2025 03:49:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydf0qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcXoeKo0JKYbSmcobrwWtg7TP0deWCO4Uis9zYS42Iv65Hqgsw6x78pK21G67/ZsRFKe5asxFQe1ytQR+ldl64JRwu8P3DwJFFRb81qMTnm7o+GGeopxco4EJrutbjnVb4aW0c6Xgn9gUkGTprcHAF1mI/Cu35+oCN+e1spK5Cktozm8NDFVKKonVWYK1sLkzGmsYShw7UQ82aRTkrrKUicRR8TKTjZZBqUPWtmyagFREsgWphVda2eSYTpt+HkDHCT0BiaCzxDwLgh/RhjVevnB5XUR6r1yylpb7Yrm2wbE/vlj9llOg6HAF4jeYbOLZrHkM6OUiKUdLSzQyvE28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqWqe6tXAyLLVqJB1yto8mk4kYzkAizpVAPnI0qkP/c=;
 b=b/8cNSi2GqGCsjsZALIfZ6GiBQagFPqI7eEo/gkFv6SIZ0mts5kX2kah2CG/zor4tAYyo324/Wz9Ejs4ZwANao9x6ySWex8VrPe3y6qPVrDCHdjxerQopePh/thIQRj0oNn+tVVplioAj+poca5SGlVhMlA1Veve1GycU+lk7uYiuY278s9LnFywQrqCSN9IY9Oj/Srw1anCACmELcsG6Ptts0M1+QKnKDa/bQoTemkfkzmDXiy6HIKRlNJfLSUQRqZnyho2PIlaq2C30A9iB8Ygjqpurm5OXABC36xGHlo/Ymy/h4u6BKjVkveI/nHZa0w7l77TPY9ipmOrh2ZyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqWqe6tXAyLLVqJB1yto8mk4kYzkAizpVAPnI0qkP/c=;
 b=cc/apqdT8R8ciFSxf2qQASfTAKlYELutUo3f+mdYRBpf6xFJMeZwfbVMb+wZNGz/l6zQ6ujxi4KPj+Td50lhtJo5DlGuJxtaFaX3hr/Mpj7T6dijVJ7prmCxW7TDPfnaewlJLBidAPgR0og9TiINN6l3vpymjCUfQtBOOCqLGC8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 6/6] fstests: btrfs: testcase for sysfs chunk_size attribute validation
Date: Mon,  7 Apr 2025 11:48:20 +0800
Message-ID: <a3cfe616dc7ede9987c18698f1692a6d3c158b6d.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b09e9a-2d49-4987-09c6-08dd75874050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEyrOZbS3Hm8rOfiaBABH0XuIOxSR936YSqBcJO/TqdM9YQ3xCtuXPYrqNNW?=
 =?us-ascii?Q?sM2+acsz36o9M1cZ1VPtP2+879BkmOcC0hqtkaiswb4QhNi1a5wWw8B6Un1i?=
 =?us-ascii?Q?Frg1a+r9Z0h3DqAGDcSfxXq+DyWXNw3Ks0TjUrEH/0HTkYrC33CeFZ5Ojdye?=
 =?us-ascii?Q?b67onVo/ztlmDhfWxaTurqlNemPWxwlGeDM6pxqbdBmklmT40guIk3KZJGdM?=
 =?us-ascii?Q?GSYBcwQWAoZU3YGtzFYVmnZAHUeffSIuxwV+TCHKMVOp/5TJMPiVAXbphYSQ?=
 =?us-ascii?Q?EboYswBKmJhmlmEMKZAYBWZl1BeV30RCGHobhp/W7GXsLDOb75A6N4nu9TyF?=
 =?us-ascii?Q?IE6JesXDThJEfsXexTcni56ILhhxFHZzVDgQ534qpC8yGcUf1F7v/Albrm2o?=
 =?us-ascii?Q?Us56bDmp3vkOImwhBzyZyty6eNorbf9KlXwP2odHcGL5M0rYQzSPzLl+f46I?=
 =?us-ascii?Q?zc6HI+C5V30oqhKMJgvAPdgetPHuwhwLd3CV2cqL91eo6fy8Qc1LFqGZcZFS?=
 =?us-ascii?Q?98IAUIv68ihk3QtvDtDm+UkK3sCOaayB/PfpFvNz0Omxibnsyb680O55aBSN?=
 =?us-ascii?Q?UaceBpmxwUqEuYzkejF7I8trNgCehbVNZw8OV/wYTGleZzIy3NKo4lUUF+G6?=
 =?us-ascii?Q?R8HAeCmEjvwxoueLEy0gxYO8iQCoA41EE+kw/6CIGeilte2i2aR4Qx5l8KdN?=
 =?us-ascii?Q?h6/IgDjnZsIgUP7kfhCAo+Qb+JZ9I/DstqYR/Tiq2u8BgS5Wb79Q07J30aC0?=
 =?us-ascii?Q?laMnkvhXXrDZQtS5L73o4InM3QDUCyXXLkFf8eBXtp0Lfgdm0bPAEcfGDN7a?=
 =?us-ascii?Q?TL0h2YE8hmBHonyKeZIzliKhuTqM0QHqvDJRHZH7TmAeRKpBCQZwQqOqcp4v?=
 =?us-ascii?Q?Rxad1IHktz26pL/KZ4nrArdUrgrIwzho0R7h0zBLaaSln4DuzVIOA45XtAQ3?=
 =?us-ascii?Q?CSTlmCmuKOwFKEMcfrXSTUGxhBJ/dN5SEJRJEDxe3x/kv8Cd4KRD/5eTYhEe?=
 =?us-ascii?Q?ZXqmMsn8jPt5ev7N71oFuEsvRpUAyATvl84ceUogbwz6dgW5/aB0xFO6L+I4?=
 =?us-ascii?Q?IY9TZk04oicwLfyVGrlgzyiwuC99ELUvSwIsuEUhF9fvr1i1uDf1UetRaICy?=
 =?us-ascii?Q?XbGY8eU+bTsCLgkzlWwheU1EoDqOaCKsHh8XpW0dEHEy5jHfAUAj5CqWR1Dg?=
 =?us-ascii?Q?hoUaKz5j7s0aou9SSzlMacgf9NGynvjXfqlFkESYn1TBTJ/EbYUZ93qjh1St?=
 =?us-ascii?Q?CO7tMviKNd95iBNoK1/a8i87gCCgmjdwCNFFTgNUS6jz9XPqo3IrcO4rLxQj?=
 =?us-ascii?Q?xQ5PA3REtHKc+nkm2A9GQJLyeSAtXjF5//EoyPNPHKCCLoY/Z5IJ8i0piuyx?=
 =?us-ascii?Q?pOjFHjC6EpCfK1KE18oCVSBVLtAi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNlMykjzD4OStpJGHvz7dT7BdLtxB9gru6UC+CRPv+HtSC5zmwsk+TK6TD0C?=
 =?us-ascii?Q?SZHl2Oz33kOt+KzDo18P0H0x3aX2JnGN5C5lwo3/RPNji++s0wWq8WdQGSE5?=
 =?us-ascii?Q?SAa9JGYncFaInW3wOjxJfmvOUux9uC+mckATy+mJLq/NJ+lja+sxNy3MGJSW?=
 =?us-ascii?Q?NTHrnziYB2o9GVU045QQqQlUOVz2giXZhWueNCHlYYDH/WQOBJkTswoc19YZ?=
 =?us-ascii?Q?uHuMHZMy+xrxtSe6LeuZVnFAHgmGZhDHkqHh4TWV3ZS2oWICRDpqpwRW+PHJ?=
 =?us-ascii?Q?oCycTgyy9ZVCZbQEm4DXI1rP5mR19iPE7Z6VM7ggXPWqMsNVUp0ESmmpvoM/?=
 =?us-ascii?Q?oM1ZN3ZIXpV+q4xSQqXPECypNtcM0jSGOiJqqHP2xd1yKJpxWK5ldZZ0Qrk2?=
 =?us-ascii?Q?wSHdWCnDfgAJu0sHgL4u7tQybX8gUECaIc9HQFjUPjMKj0I65Fx94py9IHPm?=
 =?us-ascii?Q?f3IMUKZ7LNoM6f8TzTpcp1CjqNc3JN5IJj7BnN8T7w74oa0Nnf7A42idPc8A?=
 =?us-ascii?Q?9Ia7qNaLooIflVaFI/inErkatmhUBU9T40QP3X9yovqzvnWaiegW6/J3kwxg?=
 =?us-ascii?Q?Nxh1hnpNU8c0nbi2NwqPtJxb3hHTuMhyfVsIy1Hygff3JlgaFDjz6mVDB+eH?=
 =?us-ascii?Q?pDTmgzwh6ev2GmpQ62rHbC0v/6yCE726mOzRmDcEjATlqWQ+XPotUUxvp8vY?=
 =?us-ascii?Q?G4Z0XyNljvdtNC0twJfEAzfdysNNOeCcwXfwc5RJeGFqY0hRVshnfVVcfxKk?=
 =?us-ascii?Q?mv8Qc+mSYc0s1mKE6MdajJ3PkUlvVT0rv94iD+hWgf9a5qLFYlYhvic6Vszg?=
 =?us-ascii?Q?avbMhjXtTmIo7/9HdwYwfNpn3LDdalx3+V2gCwN/sNSDqs+q8OjlAMVkUJkZ?=
 =?us-ascii?Q?9PpVBApZ5HjGVS6P7WPtfOfOkazhMBzjOYP2rd6RZNpNVbIQWxBIIIh/Nx0y?=
 =?us-ascii?Q?sxEj8wvq0jXhNYUZKHb+l6Mlh2yT/Nje5l+fkMHfx2yEv6Su0Gckxkh/HuJU?=
 =?us-ascii?Q?6GWGtudxuTF4yx0Y0GzL1RT/lmfHrRP4Sf9KTcl5C0HkMwUYDnbjcZiU3eB/?=
 =?us-ascii?Q?FZk4gC282/8jI51yKGHEsHO0IeNqw/6fVhhCY4h20kSMu6or7leyzGIXpb/e?=
 =?us-ascii?Q?yPxfjSM8ZzKzdUObeHm7Z7zaRIOvkmjRPg0c9hfyXGn5u2rklQKencGgea1J?=
 =?us-ascii?Q?2TzFAo1Sfhbc8KP9+aS0cfi3SYuzaYgyXkoXFLuwt120rsyzIcnbgITkweok?=
 =?us-ascii?Q?x+XPFlW9FWk7GB0i/maAKzExoFWxaE1K1f9lsbxUkQkPNAvQDNR46U3dwMEp?=
 =?us-ascii?Q?4SsvtqbaZb5rPVDhS+XgjRx/guz42whkk8uSN5XRZre/vORi5NKotfz/fzSK?=
 =?us-ascii?Q?jX5Uil9amzNfdmEfHy74/ApYhH2qmqjy/98YXuSYtrVM8bvjBUEd+goe99gc?=
 =?us-ascii?Q?e3lPhnVq0PNYNLQzb+detRJiDMOs6lq8PKJMOLOla5dAW3P8z+IkpWyZ4LzD?=
 =?us-ascii?Q?dvkkzAHIAI/j2aR4CABoLNa7Rz5E15YDIQrmpgmvwuPtkRaGCd8kYtZqVVxt?=
 =?us-ascii?Q?SMtrU51RjcDvTBf/55wm24MdK8Rj5XUEvbbZ0MXC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lz01zFCdD3YMhjhyP7eAhXkhVDFttrWQ/wLl1Kk2Nxgl1mY5SS1uF/7bqYQE97Znr4FlotP0xuVf30xJ9uRgHcZ86+Xw1lIOwzS36ERKGeixNpYSIUYd29A+qiLGTPb8r+zNHEp5x0wYXnIY7o0FeXsKRSxCfzSA11KEqh8+dSGnGv1pAnxxvczTcAWKxQyzziNgZ+PKGZEXuc6hjJGkyrjIyJ/BoBxFf9nDse9mNf/o7IEO7swghn2I6y9HqJaiTGNJ5pLtBzQ94xSPLXalX4QF8qJP/5mNTE3rxe7iKG3y8Qd7308fEoGrgjd79h5dVyVtY4qjDIU197vvhNXP9WApbo07OJkutm2mJrfOS3/HwBDi+O1p8AJXHBb80dRyEbKXKyrUtPLGgk7j3i1DKFY1hvn5nJ51xQJM08YfC5tL01jNZTgTwucGBCUFoeCyxUQggxSL9WvhIw9rS2oLC0XY8LAT7+SP1WPU9AIuRPYgBTa3xh+OpNOmA+Tr5pEVrAjmEseYh30NhGLfgBonL1MLae25+D+1DTXyTPLYi/zoMSTINEl9SLiMdrIVzoQlQ3x9AsJPuzsJwF089UHs7zYUOLnmcBRGR0SHw8L/ilA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b09e9a-2d49-4987-09c6-08dd75874050
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:52.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Soa4V1zEfotGVUbl129LjyeJ8pQetE1NTN6fCdP0QWDl+Jd6IiyFa5QvqtlUbImSddH5YEMiBuvw7y2AA18aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: bYpIUPZAASZmkIocofrD_k1oyQfHloqF
X-Proofpoint-GUID: bYpIUPZAASZmkIocofrD_k1oyQfHloqF

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax allocation/data/chunk_size.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/334     | 19 +++++++++++++++++++
 tests/btrfs/334.out | 14 ++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

diff --git a/tests/btrfs/334 b/tests/btrfs/334
new file mode 100755
index 000000000000..fd1ac67f9000
--- /dev/null
+++ b/tests/btrfs/334
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 334
+#
+# Verify sysfs knob input syntax for allocation/data/chunk_size
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
+_verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
+
+status=0
+exit
diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
new file mode 100644
index 000000000000..f64f9ac09499
--- /dev/null
+++ b/tests/btrfs/334.out
@@ -0,0 +1,14 @@
+QA output created by 334
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
2.47.0


