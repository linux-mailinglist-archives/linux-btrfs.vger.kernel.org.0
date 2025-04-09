Return-Path: <linux-btrfs+bounces-12902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD5A81E91
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D38855E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC225A623;
	Wed,  9 Apr 2025 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AXOGL1i9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iXBxTTYo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB825A34A;
	Wed,  9 Apr 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184692; cv=fail; b=k+kCsJI3ZK8WJGh7HmK3KDEjZuqKf9P5SrhLQbNVk0HHOwitFnvQxnai6Qh3tnJrVb6MkBQrD/z5PRVIseZRH4s9LddB6F2ANJbR88zJ5nCf6pxxYomvLQ1UHt5YAbr2PyYiLHj+bziQilRMTFLqknM85HOfByllfh2T+kAxM3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184692; c=relaxed/simple;
	bh=M9CtTdgxLaSjxLYf/A34KmfVPKqJ9axah//YOCGlH6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuoS8Sz+3ckLuFgYsQ01edKgrO+xthQfUSfhiwNM46iVuK0gNB9VvN5FbILlgnRQmBLFCnQJu1BKAR04WhKoHQvywomwK1UZUFYxHuWBbXC4q5xXP/CODCzNqGX0jcYOTIvKMsGIQxIOtBDwweEGP4gykMdb2rtKp5Rdl24VZxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AXOGL1i9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iXBxTTYo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9vis020865;
	Wed, 9 Apr 2025 07:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bgaIB6uoCrHLvMYngKldlk1C5rzTf68zRwvVQIq7L0Y=; b=
	AXOGL1i9+m0kip6isQJWkDWjrEwquu2jioCC/orv4ljzAWR1AukX5bVJXTnyXbsx
	s54elwDz5PqtIKlqrFbFb2w3ZUwRYKjRomc/n89z48i8WWz19X0h8tcNcTsBlMKl
	n5EGtqMMLyrimqsQpGdGAHdsy45KBIZDdS8jvdESHcDGpAbpGM9tQ/phdvi0c8DB
	5xInh8yOp5MxyZ4w0CMRFXZp4GM8vc89n/2Z/CSXhwhG4LBBG7TLdRhvOqseQAFp
	BLXrFe6so0eFsaBZk6eO30Ql0n8p4eFwg1xb3yYSwp9uJy5X6ARoIAgBBzDj3P6/
	iIlNFxwhZcXG7LQiqFGd9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2xfev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53970ZKs013757;
	Wed, 9 Apr 2025 07:44:45 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttygrtg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jiq9kFIi4kbKqg8ylnxA9CgU0lJaHUwdgz7QklixcEvwuq4ku+SFtXYSGrHS5L09i8xTzoAKsJeLIB5BhTmgOAEqf6C/AUsLz9za+NN/2xlu34D17wwKD3hmqUTpZv69XyINRD336+JiTKcwtxjPXBnN0IfJZf3Wy5ApPF1JvAzTJ096GGV6AbhkDxE7qHrmgrwN27XkPGHo6rfaFCNIVfI24uTIbF5P5+3H+/5tGemD73MygUSKwiCkIEXHqkhXHsj96BMUAbEwjXX3s97D3ATJkE5qRiJaXnOqAQCOXlSHi5VPsAI8P+tsN66DDggwCx4XbdDnNmRtJiCQ37Eb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgaIB6uoCrHLvMYngKldlk1C5rzTf68zRwvVQIq7L0Y=;
 b=TR1bL/a/yvs+JQ9E11vvP6vkk76ur9MSv9m7Ioi0g95GsRdSj0kboGp8mDZO3bVyoorN8TVW5foBUg7v+SagKxJbl6hAqYoEaj506u7ktHEEwE2XW4Kk4DfAAgPuea0l1qsy3NoVTdxVbKgDa3TubksdYFMBeot7o6m5IgixEsd7DqQr7V9EqqAJTMGmlyg9ssaN8UaTU6yiID/yqM2rQ90Fa/u6dX8vEBzu48zDR/jB/d2BWGl+0aYQ+WcTKTdu+yd/FDoOJD6poaQ1tAOobXr5RfHrBVxgPseeV6XLbcaMhAtyixWuq+UWqALOuR51FZ/RYk9YZaOAMhTPdE8xJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgaIB6uoCrHLvMYngKldlk1C5rzTf68zRwvVQIq7L0Y=;
 b=iXBxTTYoiyQQp9fPKJkrvd/HZW00RIqYvQdu/Q85NLOjnNYk+T1wmOEwhihvz91jWX+VLZWWT9kG1fsU2sicg4ECv8pY1PpjbB8x4MFp3vpzajopx4k2bueOG0czg39af14BMfPC1dAMGMl72/hx6Z+c9ME8xucD7yN1QVGxN+o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:42 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 5/6] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Wed,  9 Apr 2025 15:43:17 +0800
Message-ID: <b4a2791c47d6d5b4ed32762044d0d3dfce24a11c.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8dbf2b-5ac8-48f9-9a14-08dd773a6373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LxKyH8abf+WxGBn0iWkBAteyWH2xrRRgwdA+DG1AIYnhfKL2nxFyXZOcgsBx?=
 =?us-ascii?Q?ALKewa5BP0PczuFya2Bgb/e8vuZDTtSrkV7FE9g7u6FGfMMS+sHQHoC7RaMF?=
 =?us-ascii?Q?HtNvbAXzGTYNH3Sh2XpOnbCzZiZZ634dZTunIT5nTI1YYQauDvGmkscM38KB?=
 =?us-ascii?Q?ufLpX2jEkhsoCyrE9l3zFMWCUsMf6ir+jZ4ONLK4BLHBHb52hSeHLTqTxiiT?=
 =?us-ascii?Q?qVDYQR3KTSJt0Lvx5zFeCTSVcyvB1i910In+O3VrdkD+KRc8XKSJvma8p8CE?=
 =?us-ascii?Q?ETjzbtduQLTNvwJ5CmynLQrjpAZ3qMdzOQswzAMaN2XB3CScQc/S7+WvD+GR?=
 =?us-ascii?Q?5ZvJ5YGJshMJzz5667WtVp2hIR9LvkbkrucJRBR9pZuv9O+8KObwGIyBMby9?=
 =?us-ascii?Q?rKrc4kq6et50v4OFaRZXJRPmT9kApVyzIGQ4LrU71Astu2PhA0SHx2jGX1uq?=
 =?us-ascii?Q?y4lRHqbSZopr9DeZygIEWs1KxJgz0E6/rbf7QRRiZsW4Y2nYd7bHLFpumsmL?=
 =?us-ascii?Q?z9kDcRhwy7+AKNi1qO869rvimPUkvqainD9U5xSIX9w4x3uNOB0+x+tZxbDQ?=
 =?us-ascii?Q?R5bEHpG7Z8FnjSReHWze2zNuduBH0vvT5CENAihdf5fjaOBm+Wp27ZzU7sS0?=
 =?us-ascii?Q?fTx+2krQysFGPtTAglprcldBooNHfLy3mRNfAn8P6X5cn/Bo7wCEnwdN24HY?=
 =?us-ascii?Q?/1XCzmaMopaI0stK/OY+npnU0AitDC3wfmoxUQQkPMwtDAqdK+AYmf3oOStM?=
 =?us-ascii?Q?Jz0bUX0zC1estgqYqONP/IUrwF4eEzWLrcw1to8egl21fc1X01UC9GLqlZHX?=
 =?us-ascii?Q?lLZObb13Pnba17P805Ze8frrYJBuqsan8mRRPqmcy89TF9w+WI7mFgpSnddv?=
 =?us-ascii?Q?kMbHw0n7JBPLAEUO2drzdgnXGuwowEoRdIxAqX/EB/uuDCkSpyce3rbFfSgK?=
 =?us-ascii?Q?Njto1Z+jIdWKg+Rc9oZpZaBi+QYmyCsrY7D7BQZ6C3WmqiXCBQJ0zHRAgxMG?=
 =?us-ascii?Q?DT58RlBdGax9UiPBC81hdsAexJXCpXJuLo6lJglWPgsuVgMHzXT+Fpe00P3n?=
 =?us-ascii?Q?qmKub1wZp1YQnaLj0Cv3tii1U38FkqFquknW+2GXN62Zd/b1Y7iGhlFuzv/k?=
 =?us-ascii?Q?IIuUwEVwuGLofQ0lG83NNsceBSnCiIV5rP0w5pVX0zozAh2YUjRyk7JMvmN2?=
 =?us-ascii?Q?IFRKv3pWIhW+vy2o6Eqv1FDTk3UCLMvThKF31V2QsGSFExhShRRy/gz5lXWR?=
 =?us-ascii?Q?uBwr1JAUC3B4KD+s5lgXuZGJe+lVcP0ZxmaueD10QAAJhfUQD+muFeoKbSdt?=
 =?us-ascii?Q?Fh+rcRb6azBLm23pGCpZh2vgsXqtQm18/vHBpWZxtu0Nab5g0gA6y+xO4FRW?=
 =?us-ascii?Q?fbX89J6fsIdeip370xBN4UExo+mT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyfIBHBktZRbcfdAYJ/9wWLPv5DqIfS9Gva2qUCPiOb2QI9LrbyiO0ZUa+pT?=
 =?us-ascii?Q?k3I84y/emjqyblawX2Ndd+NjxZ1CaKHzm5Kk71SG9D6SfZ2jN0sij+1rHGwO?=
 =?us-ascii?Q?jgAu/frUK4eF3D7O1SX5Wqh8L86Sg87P6/hpEZhPO/po+LmNBEFsdgEJcpTl?=
 =?us-ascii?Q?nkFu+AzYEce09bkF7CwZBBCeuTCycegi405uWboeEycKt6ZTrefcmDKHD1UM?=
 =?us-ascii?Q?Xwdc5m/5/bT/COelWu+fi6tRUgs2DiBNDcMledZHDAGWDbwkdMTy3ANWSTXi?=
 =?us-ascii?Q?i3ovpjmmh53nzRc3UR4rOOEtrHDqIMOOZZQ70M1O0qwNSp2jlfUNlcsZfS5t?=
 =?us-ascii?Q?MjBF+RSSnMG5sVBBYzCYr/u+nNFlvBf1C6Wgs3hsJGySdYL/KJystTMW2CD2?=
 =?us-ascii?Q?EalmHwNkB+cVjZ0VlznER6eGYtyRTWFv0sH4THIUlndgjyq5hKJh8ACWRB2i?=
 =?us-ascii?Q?jsUXOWcilG/Gp8SFmyMP/8l/i7Z2/Z7SuNDy9NcbGluT2Aq+g7KY2oIVGYs9?=
 =?us-ascii?Q?HYobX12g5fYncF6+/hiZkKSBovZo43AXox3irgZmKh53MCG9sJHeUuZnfItt?=
 =?us-ascii?Q?c/k6DpjD9fP3Rtr7q7fx9vLXOvGVq3rGMGjtht6KzWDNcgHySOhWMf8r+G11?=
 =?us-ascii?Q?g16/h7j1LsXTFceuT+nCLbANh2DtdRzvvXsYbihCoNofLODquACzHRlUbIj2?=
 =?us-ascii?Q?zYgFoLuAknUFSV6AV08ElGy6tIPOqCubnVOq+uSMPf0zdjmOMaV7voEOZQXP?=
 =?us-ascii?Q?Xu+E30dFbXiKzCb0AnccpLoYJiajVO8ySJlKNMbUZ9PbsKcot6pEGmwTFnCE?=
 =?us-ascii?Q?+wXBJUgec1GMey2T0Ar06E0zJMD9IvLNiEXCJoLf281YWm/DCckmgTk3INb4?=
 =?us-ascii?Q?kzPWpiuYMrAACmocpO2NPWAw0GqXNn7adDzHwxwisJ1nDxfoYWcuX8tG9Chu?=
 =?us-ascii?Q?UT2SWfWovBSMXHMi/GcgGQdGePewQ58aQVqd5B4iLfEDo+eWQXFM8P8G8Fn4?=
 =?us-ascii?Q?60zqeQ8G1cWGR6F77eS+u+hYQif8k2B+8UMgseSsnwXy+uhreid/0uWcr/zj?=
 =?us-ascii?Q?Ex1MhbeMd3w2J4zveA2TKIer5q482pvoUmrbkaHf7jYXN6cih7Yz0VqHvF/w?=
 =?us-ascii?Q?rRSR25AyZP//MEoTBEXnt/vKrj/mQwhcKIY/v6TZjuzTu2DDFB1UCavJDSIh?=
 =?us-ascii?Q?/PEP7MOCjeKy8XnMrnWniMf0KE+F0ru9HylP/I/jMaSvxpzlYODabqRxF+OL?=
 =?us-ascii?Q?VAY5yDcFaTpEQrZH/wpGHQNi9uOriI5+MWy72kGuqc4Pafc3r2gMKKcy5V3X?=
 =?us-ascii?Q?I208ZpKpz5AHL49u/JOh+EXnyPp+iRxzYoE6kVpcmMpJuOcuYpbpHytFr74n?=
 =?us-ascii?Q?NjSBnG6MYTPm0k8XTFWWwA4rBFGE3JVOD/nvlMBd8uLRiNXhzm7Q4lZh45Ow?=
 =?us-ascii?Q?9gyO+IGXh9MFZOzAfciofeeCURwY/u31UYdQ08cGvwFq9PgmXTuTYdPwSaft?=
 =?us-ascii?Q?vc2XEMy7SxhgxAh09ROurxO7G0HpEVspA05xwhUZMwkM7AyGwAZ48DmsolPO?=
 =?us-ascii?Q?TcqdIdlwX+FBn2LVoGIQ5Lv3lpUschERDx5NaeTj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bbu0lNAvF3zYzT1nSshQK8Gq6PwhFtZ92MF8B2I10X+lea9hWEYnFO8oHqvBtUwdIQG+gJ138xhs2sLnP4gVr8Nup7qYYG7wUlBiCZWLpa8aZurMx4yS9wimuAwBpRvQxbbx25U+TYPGhh8N4J4GhAcP5FBEBoBxKLqpsJ8NeMAu0+iqS8ATR3HCI/VU8q8tDAt7pCJr+XwcFyqXYv9Tyddq/QfBWAmOsJKRC2/cZsWUjHrB9DrQWGFc5SAGgReeXZy7VQ8Ae9sGXbKEiiBr4j4s3e3ZUn3BygawTnlc9hpHUXNn73oiY5anW5fxXcwRfVR3tC2vwoOGZ9blFZxgqxlrzdo0B5EvPGEFBTTxFUFLkR5hhjnlgdZ+iOG9uHmXNqqjvOS/S0DCuNHhby//kLFhsm3zTwqRXvNlqleTVA7tnqUscCZFQ/w41H2JYmw+Oz25bIYMI6xA0TyPQs38egrBOhDVFHMn+di9Inv+5N3g4aK0xsnBL1/mU2Vr8ySsl7VVz/uFVaso2NqfQ9uHktpZPHNUdix6cgnha5x3+ruzuQJdKlpUYEqb7FMondIIFAalG+MZjGwjDKtN9/eT8Kd+qQj2y5bxS71080y4QHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8dbf2b-5ac8-48f9-9a14-08dd773a6373
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:42.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD33ph7WAE1rhlyzyTp3GsyrYqnXeJpX/a/O/j5HlF2bwDGk1VhvuUr5JgXy4YbovU7Dn+tX1QFWAGUzmChFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090035
X-Proofpoint-GUID: M2opnUEjtgRVTCLgpLfZBEmHa2ltrCoT
X-Proofpoint-ORIG-GUID: M2opnUEjtgRVTCLgpLfZBEmHa2ltrCoT

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 21 +++++++++++++++++++++
 tests/btrfs/329.out | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..f4faddedf076
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,21 @@
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
+_require_test
+_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
+
+_verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
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
2.47.0


