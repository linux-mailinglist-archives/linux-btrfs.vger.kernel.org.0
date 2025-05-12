Return-Path: <linux-btrfs+bounces-13929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18773AB432A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7960B3AF03D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4529A9CD;
	Mon, 12 May 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsHf6QER";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l0EqxjlK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F029711B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073427; cv=fail; b=nyBX47r+cQKcKOu+Ou1ylZ5LQ3/PZbinzOP3zh3ONMDROWlS17SufMviE4De7zNaW8zD+T4C4y8lTKohJFe52KcyNR2SI0jjkQAjxzDn87z1fyCnF6SNajybJGe6Xa7wQt1N3n8OGJUgf7zJkwOvT9XubCHLzzEJzWoA2onEjSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073427; c=relaxed/simple;
	bh=vbwhN0vo3vR4IVmwgLJcMWU5MvrKa2TLr8ymT3FyAuk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQg4EQ+Wvv0yaADP+K9aLg0CbZbRxacxp9BdfbU1FhetTZ2D5xUqzFTOEpxEnhUlX5DfM/VmihaQ890ldzG+kMr9e6QT91Ae6TumQZWVLV8+DYjdt8CJRw7QoSMvws4OXFXabaeR7ltioXdg483n1rlCgQax4J6QHwBDPptWBd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LsHf6QER; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l0EqxjlK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0thW003937
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rzqiu0NlDtMfulLDKqkVfKMsyx1K3fFqN0tHI+kqfV8=; b=
	LsHf6QERHlUTmHgWDkmSP7dde9UN4uXNIlGj+aiCzCAtP342fyngZ5FbwZZK/TjE
	Bvr2IT4i8stgHOvn9U7OvA0VqulSt4W40B3W0HKtqOHdNqMD3zI+snfQZtza+aq7
	dKLmK8VU3YNab3I/IRqDXsUrx8cWeYPaGaUZ/ejkbJqjUsj0z0fFPJJXo2hZeFnp
	1osgqNBk/KDX9GGAZCiq5Kkh9I561J+oJcYMKJblfB41RQqrGCB1X5JnswpgRNtL
	j5Cbo8hyW2gqcbcAy7Pdve3jRdePzkk16tlezo0514mOJ7/e2emokcSixUfFvxkC
	TcXcOCCDG3AWhhNKzfZB5A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwk701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CI7Fx0015484
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:22 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011029.outbound.protection.outlook.com [40.93.13.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q26q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI3Inv+KKh5t5DdbqJdjCRc9NcUs7oOfcNb4CYA7/3w5MBr/u0xtDgkJJoyGILRRl67O16EyvKj+RVJuyTS+42hoXPpSV9xMqw2+097xjWg4Qdj0Hnh1JlwqPVeDEWW0k/qs5qzIDSgx17zn3gKe6ike+E5WfJQfoEO9PA+6mALSbQUNp5iROnNo+nQQ1aiQls4gAiM8KSzBKTvstQTU8eMlIRcIqgGRHswicsrclEdqhbJFR7o6XJDpBG3fTTD5QMKBtw1ApqSKisdd3SYynlchOpROcPD3vSXZVEqRdzz47xnkO4+UKEe4cFsbHJirwLElfJ85cj/j+wTioIvaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzqiu0NlDtMfulLDKqkVfKMsyx1K3fFqN0tHI+kqfV8=;
 b=JmwQkzsG5aRn3ubbHPCp3hi4uWUKDaLR1Ee8NSK+b+BRtb40PzlTj1cTo04794nE6+baPRJ6sPNjNmPIfVcvFHngV6dW3XJE4YkfuXQOasn/CYtlzcfe0j2nJhINS6I9S4lAFLhxbbXUu3YSqfVfa6KG3k91ukngGy9EE4NyI20KjCkzciFeWdadPET7ZH1bj+x3m1wWlcyYDEsNeeScw6wb2KdH7GFs9QBiMHEa66Tt3wDeWu0mfPE0YVYw9IoGxlbQdnuhg+Aw/ru7WKgZrmbnK+n0QvtUfmuS3D13ZWMBlirUSGhv9emuFcNViCvsuhbrEK+L31C8dqZ8jOToNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzqiu0NlDtMfulLDKqkVfKMsyx1K3fFqN0tHI+kqfV8=;
 b=l0EqxjlKycqHG+ai4O+sk1FJR85TC2tmkwu3PH+X3T6FrYsESIVncdWmS0zfBhxIsSNI7DkCddTiBY85VDYWxDBDpjRA8sjLYDZt2NtoqcnnVV8/GaVGjwMIwQlEgimVJ+DuIfvCVw2ngCQpSRGdhq6gwdXab3d8W/N29za2QwA=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:19 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:19 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/14] btrfs-progs: minor spelling correction in the list-chunk help text
Date: Tue, 13 May 2025 02:09:18 +0800
Message-ID: <864ab0fc0921b489b951d39b3e6cc9864a657d6e.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: c71f8caf-d0fb-4882-faec-08dd9180411d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5Z3yNBN5cwPz2RYLIlMUKhzZfkpqBfW02cX1uiYkogPUnIy8SO4HOfxDUZ1?=
 =?us-ascii?Q?ZnxBhi6Mg/0jhbM5a3LJFPwlt/vK4eXIPNze8mD6Bz+dR3pBekQxBQgLtwDm?=
 =?us-ascii?Q?ACqGtetu8nirsbi4RgH/vqLI8OAFZRiqFOncauOT7dRhagIworJZtkrH7UXi?=
 =?us-ascii?Q?9/vwJi7d3zabTV7QLdYVzG5khp1UghTHpPnGCLTgq17u3HXfkaQiYanLcvHJ?=
 =?us-ascii?Q?jm8Cu42g4Qs9NcCoEHXQxwsSuIL1rLov4IxL6R4PZf5/Yy2ROTBbE7HW68Tp?=
 =?us-ascii?Q?AwV28IJLHwmWAhtvfRJPKSN1G7cNfgQahkek83mqA6QhLITi9X3+WKKOl6tX?=
 =?us-ascii?Q?5qQjFwmONRxXWMKNHk8WI/RYXxqZiSMn4dKZk6NqM9sGBBOfJwrhpMW6elxL?=
 =?us-ascii?Q?OCz7IQgJ3mEn8FdpGQxfqQVaQo4hS54ZwqJldZea1z5dPUIgL6xNIZitmkt5?=
 =?us-ascii?Q?yD6rzi2ShCLxQv/wtJi8Fg+rmaRpVKz6u9Ak2nk+u1QxCUyTGn48Oe4c2Daz?=
 =?us-ascii?Q?okc0h5zPGPLaKQ1vpTQ888Ft6ytK7yGZ5ZKl2vbj7JJMOsilXcJ0qcDPkGon?=
 =?us-ascii?Q?KVFQR1lmc4fWmLHF02MdYKhH5i1E5vbd+yySWURvZtRiJJrnW7mDpO2UyERZ?=
 =?us-ascii?Q?yRlCtkGRbKScGKz46NZIxHSh3tDje4YU1TOrJ5YM/gR2gcYQizVp1QrWAmWK?=
 =?us-ascii?Q?WiYLu+1tl61YyuSodxZ41hK+VKT2t2P+z0z9tN/f4N+ekoE+9wP/38p3FzlJ?=
 =?us-ascii?Q?sYOGx7pBTDEtvlph6+SOKq9ZkDF3A5imlsN0xY5aJBI1TWludk18+oEVMsry?=
 =?us-ascii?Q?IApncIct/Cd+EDF9qPWTVpQrI3bui18Dzr/EF0uGmsNXle7UPC5yNhTr+ZEX?=
 =?us-ascii?Q?vmADfjUgiXtIdDqynZ3C7/gCCTio93swlYPUH4xRy/VcOh+Eope2Z7KibYJx?=
 =?us-ascii?Q?sNaBrse8Kd+rSgQCNVRQPVKhAsnEiw7E+QmoJCTk34xhgZU/S5CMFMLdVFB5?=
 =?us-ascii?Q?sEl426oBty4rGzTbSSCwtT7TJwRsURVM1fJvf016cRZKrgKbQLf93kqwZ/Kl?=
 =?us-ascii?Q?7x3aSCHRG6NNx4/m173n3D7G5iUq8UywONhHAMQlrVclJuo3MPtvHJ378ieq?=
 =?us-ascii?Q?9pTEv5yvPQfc8qMIs0t22qTrOrsrNIDzUe/E9D4M152OSwfTKGnoovSKqq/L?=
 =?us-ascii?Q?OBhw89pljz14dG9e5sfzPUSbCev95vRnQ2yOWAQXyg59q4UA3ENcXciNaS2/?=
 =?us-ascii?Q?4hzBBij9KvulSe26toJ1Yp53yHuxx45UzOBJxC+RJoPti0nJwVvvmTd6G1KU?=
 =?us-ascii?Q?zuhbXZAlVEMCtNK7ZzvN4EPVvOXn9SgPBZ4eYm8zyasFJKPibprFahTqHWUX?=
 =?us-ascii?Q?h+7kPWxzZVwsmHBBE2g9l7k3Gzy/K/m8FRrmIKfBrFm3Rz8kVVkldPlTBz4H?=
 =?us-ascii?Q?Eqy6tfVirts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6i3fCwBaK0JX6USfVRlhlc15frNGhJ97T5vqmHaJKp1ZKGq+2APUsjzglYs4?=
 =?us-ascii?Q?v1/bKdImkXZNJimv9wpYJQ2puVtxvGaePHMVoLu3Q+VhBBmJVM7/gWbGURb6?=
 =?us-ascii?Q?dmUNYXNXLngaYaTMgptQqVRuASwreUy7TgRofsq2h9VXqmxnL5n+52J49BuL?=
 =?us-ascii?Q?dW42a4hh9mir8JMJ2n6Gj7VDuQG1aw0L7DcdNVhWrFpQtEpMJ6NSWkhXnNOx?=
 =?us-ascii?Q?S/6tWWrQ0JVADlIrzYQUqYAESzTixhUvX339+VzDeEVoCGRlG3C/v2VG9AFF?=
 =?us-ascii?Q?LSC8tVTkZymrorHRKblvv/gJkvN2ivaiuOPNIlPP3HgGUARhnk6TldxsVsgQ?=
 =?us-ascii?Q?yu73TrU/11CkLn54l5q6VRzXTrUO+AFocNAMYyxqbI8CiOBKDIfXi1T6ZSV8?=
 =?us-ascii?Q?n3GCJrHrsOpKXCc3y87AyeLoMqp1WYm/263rjV1tBSb37c+TiAO88dfU36qZ?=
 =?us-ascii?Q?75Xqucew7C/25BbhU2QAQNaV1c/w5CcmCCpTwAM/SoTAtoqL7Xjc/4uLx+JT?=
 =?us-ascii?Q?yCWCJUKQgC/5CcD6qvKAOdU+QzJVNtlEySOrO7uPRa3srKOY03hHiTpWUqgh?=
 =?us-ascii?Q?Z6bBkJdkhCdAxd+HcvyaoeheFVWouotrEb5la3Td1cqa9X6eDbegQ7JqnlNx?=
 =?us-ascii?Q?gh9IWVUE/KnCNMI/wS9K7i/4PxQnYWMPcbElBUW4dZCiL+eo7W57aiqMT1st?=
 =?us-ascii?Q?eKQPmfTJwufK9E8mzhZWtkRIBmxNuQLRJGWqa5EsHkTzGe7zqc4INhLXeLCW?=
 =?us-ascii?Q?e/CSr47fsWcNL8EJ0WtKI5wUnA6Hrczm9G2fUplEnUdVRQ33DNs7DxD0qdg5?=
 =?us-ascii?Q?LqPhbwcbsNczaTFarnS9J9B1+yFVkfjyxygoUO77jd7ifORR43pmJV1lBPcZ?=
 =?us-ascii?Q?T60uGdxESLnjFP9Yz3fOL5Ii6sSiCMmVRAjjT1QKSRkkXDOFI2mIRQE1FKFN?=
 =?us-ascii?Q?IIoI/jXkM4CiFg4BG91u8T1eEoy7txiAKYJTCyOqYsoM+S4dGi2LKh2Hzs0Q?=
 =?us-ascii?Q?RbitiRmybls8SxBNy/SRAOGYj46H3uV/KKjncvWx3DmhUGJL1+XO/IPBDKSB?=
 =?us-ascii?Q?JnvM9i8uvaGx/LYgfFzO8g4cEfuhr2svm32IUhXh/epRrul3GH7VmE6uSHiE?=
 =?us-ascii?Q?QVFiB/9m7p30AO3cNJqzvfMXDmuIYvivNf3U/b8B7SK0sJKjn6EZfihrm0Z6?=
 =?us-ascii?Q?/7nBtXklNdFW3gxPHPJKNEnLUOm52UZyw9FA73FuymLbBPQ/7Xv9JxHuqtWR?=
 =?us-ascii?Q?X67Ltbrs0NAonC7P+d1WQzBs1vFkoe5eF8FYmbmdysrKifVyuyxc22fyH1ew?=
 =?us-ascii?Q?Obeb0EaNxJWP2tKcDktjfQCVEhQKNDsSEvL6qH5jwfGebyv6wID25d23tH7v?=
 =?us-ascii?Q?wpseK80yEOu9UI30J+Tsze71D9CABrAFHn0tTA6vwg1y+3WxtTEJSyU6rY3Q?=
 =?us-ascii?Q?ZwEJXOjDnbhMOrCuvq/TSkzpARkRcQ7wOOvDpTTxEzX6sonbIpXv02FwfTpA?=
 =?us-ascii?Q?PoURnigiN9S11RblotvUupIkQB6T6DJErbN2VVjfFXmwjh0Vk2W5eHTHuFMw?=
 =?us-ascii?Q?SIsEGLVUtPGAY7o7L9/3NB/XORHSLa/Oc1MNMAVb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LEmYAiYnH4sRUAQ1yX01bnMKM+kiUtu1y5uFWUtSJKNl2c25m4pCMgN2eYIV6HSBgBUIHi/qnjP6+jjBhirFhRXDT9ktc92cBTEQXKJrDjZFdUgti5rTuB5xbTPaeNIJwnrZz3r1UHK+tQJIJYfiRw4KLDyBovk+K44brpA9EUsVbPCsRYCyz7qt6OUfYUKo6JeNpojhrKwGmp+JRUWw0o8Pqrq/XThik7u2Qu6DSZNcKRxbf+c9IufKNPeli2rwWHJh/yOTmOMQ9vUYQOmPg8lo0/UZrYrmNnkmtSJMl6GfCWfBkfF5ZYcuilMF+vSrAmUsl8ITw0cvPasRmhX8tOjSmnrWH4yPRcNItpASbmREDweX6MuhMFOLEHkQIO2LGOHJFNmLo4Y4ckAkW5yT97OJchXpqNsQrSDK4egCPi1FezA6hVwW2hNT4z0esLam0hQakoPfm8s4LobSzzEDwqAO3RBUu5zHU7ulqfYdgw9NsSKZoUmSaRHQ71rP7hlH8jQBb03RoK1fyYWDsYgapwlVEVQAf0Wzq9cGDg1Eyxrq4kXPzMYHacYJa/SpHihJ9a+0Lpp/5cQV74CNgclUD29a/lA6chnAyKPq/7JlGFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f8caf-d0fb-4882-faec-08dd9180411d
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:19.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbesaoFztF1aM0f6knFMn3kgLxSZzphotCyKq0aqtGtbRSr4RSH9fpT3kK35uXh1GjA37Fi2yLmOOfB70vOjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=6822398f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bFxwg8KsvIQOAo_fbRQA:9
X-Proofpoint-GUID: BfiExOdu6HqzgijvQr-cRjUEVd3jbyr6
X-Proofpoint-ORIG-GUID: BfiExOdu6HqzgijvQr-cRjUEVd3jbyr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX1juRBopVbwp2 MC4eMheVLF3Ag5aNBt433GGBAA1syi9XaOjLpiWsLJVsEksKnbhUXKBHaa6l+/eLzto7nkv5DgX BJ3R8Kmko+k+ncIDsimABXLjl+VhAsnhnT38u5It09PpBUGXMQ29pk3qZYhcVPrGvsUyEpOQkCp
 QfcAR/+txIW8Vv1AG2xP6Fv3BDX2ChQedHCv4sVjEAeuI8XhkF4mPj+ilMQrrzJytsXktfi/nDO yoJrKnYxnv+7qoQh5QOPXeaMOtVX0LiTm+wHLmEfgrkTirKSfzd8dsnVgGvfessIar4z8KJRz/K zXuHAYXPdanSbO1KlutDq54VO3mQe9H3Ll47mpbKeXiVFAtOLvEu6SOrfOBbvTuJfwpZoM1TJIq
 BuTOED8Bk+6k+nDBEqB9cIfpWc0YQ8oZ3SJJEs6/jSgqAyctjLtyykcltlfial3Ip+K6Ix2/

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index d689e085703a..04c466c8afe5 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -692,7 +692,7 @@ static const char * const cmd_inspect_list_chunks_usage[] = {
 	"btrfs inspect-internal list-chunks [options] <path>",
 	"Enumerate chunks on all devices",
 	"Enumerate chunks on all devices. Chunks are the physical storage tied to a device,",
-	"striped profiles they appear multiple times for a ginve logical offset, on other",
+	"striped profiles they appear multiple times for a given logical offset, on other",
 	"profiles the correspondence is 1:1 or 1:N.",
 	"",
 	HELPINFO_UNITS_LONG,
-- 
2.49.0


