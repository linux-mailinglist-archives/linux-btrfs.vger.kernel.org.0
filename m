Return-Path: <linux-btrfs+bounces-12826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9531A7D2A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0F7170A5D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6684221DB1;
	Mon,  7 Apr 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQUf1VaX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HsBtoa2p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745C364BA;
	Mon,  7 Apr 2025 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997778; cv=fail; b=Sm70SfrHOSKgTEOhs4MLo5YTz3OBKTZOq7YeUmSbXnX97SLZVE6PpYhx2AGNonNtIKfcK6/QH7075DGlzA9oakvg9UnYAFJpsTDgyjPIE0uGiQ15S6IxOmciJw87HsQ3dJaO3zpE1iyW9kum+XCBwg0Z+DhPEALMbMSkplehGYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997778; c=relaxed/simple;
	bh=Yc+LBKStlivm+4oeHcCQpt5DU+YdskifgROQjI57Ra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U22KYEU55AOEdFGn510ti2Oi2/JkjE7GMXAXojjdN7cHY+Y3Z79a8DfgAm1V9blJqRVgerFQ6A6Qqbdd7G0s1eW27TiO0lQUPdBsz/L52D/uEmpEfuIC9i5MVZwpk5b7AF7Qrkh9OQ65zC0BtHsv30S+NH0xBNGUQyYSnDPlQkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQUf1VaX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HsBtoa2p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371CpQo000998;
	Mon, 7 Apr 2025 03:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=; b=
	AQUf1VaX3XqUXSJ9xkr8hZMdu7RdE9N3bNOQlKoE8yzl4i/WY5fi3NJ03F2QwCk/
	irpD6nFRqed2q2cMT9CPVkYefnvu51ewWIC8+KZj7KRxmWlGvTuReLeJdlF5rcj8
	rY9YYhykInPHB3Bmlxz5KDC8I2SO43hU0iKt0Z6WzxYldY81nNF/kvCHcH/txHJp
	7NUrIouiViUeSI52OCgHrPy5j/H6b66FbI91QJPXhbKU3KR4bqsEZ51tPy3pdGdz
	emWXQGkDRheDkYIWc3I6WTpNXNtAi6KeuUh4RGE9AoVZ6ZiObHNOnYezTGwGa4ZD
	qcRFMcQutn8us/IjJP2hHg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9snw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5371YI78013679;
	Mon, 7 Apr 2025 03:49:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydf0kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhf/USNqFPlGMfQWzVftuoie5B4EUo65x6QiJuLaNjQn17OUey7jlBJnqWLW30m93DkT8pRHRGyqCnIOZRddO3pHpKkTVe2Dsuw6jKjKTEb3zj3qm6nLzr65fXElfK7oFqq/3VuIL0Ig5B/UP599X5rYJ8M2Iv9rS0khfFK84e8nFytt2E7fRiJz2C+QWhLbu0VmUAQ1GSXJr2/7+wAcCEdA6AcHNk60GzqvD5b9IPjdyLjfVEPPIqd9cmV7Yy13apCW/nUlTw9i2Khhh7VVFIY0CiI/SpDDNorr3eiN8yFdMeNr6yr96Nen07jjTExssZI6aHg1t0j5VpQR8Mp2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=;
 b=jqGMs8rBq/llLVfgLoG4P8mSc8aPGP5N2rc71motpk30zkCv9UeIGXznTSCeFMSg0kc2uiAfAC2zcuZmMX2vMRcRSuvF+MV/Rq5frECWYtXl/ASLvd1xhBu9eUvLLUr2uClmbUJT82sCHC8CpYACZOumigbCdmvqanAiTOdNwiS5Nev/87tHUOP8Nh2JxHI8dBp3wh3FxDOs7TX7IXb+XHhiHiC9wmTL3uvvHjIO4IZln1Tam2IpRgMTtqYxITSJM6Qt02irRVZ4KV2IH5DjKXAXgaFoi7QCtKUokTieOU0hjHZk5EoVnrQsb2C3U/sSv/qlnC/RZLa7KhsGcTNvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=;
 b=HsBtoa2pTLffvdu9V2nD05hiv1GDLIeJVajxj6iGf5JSSKL28i/4lmpW0ZVwrx+1HDSp0XGE38e72eKxVpNVyHwGf6uTZETvwNrpqK3U42ZQ2PQbHp9pNIXTGHVaC+tEqL55PzTi8uB1M8Pu6aUkCDG1HfKpDC7+lDsg83MhugY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:31 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 3/6] fstests: filter: helper for sysfs error filtering
Date: Mon,  7 Apr 2025 11:48:17 +0800
Message-ID: <594ed11fcc744e1f2d6f1e5f88929d9dba0dbb39.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fabd16-0a40-4e35-72b1-08dd7587343b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBuGETeUuopLcXJLY+GRPbgZjTL0PCrCHbiiBRYqsky2hNc0Ex9EsD0dsba4?=
 =?us-ascii?Q?U25SbSWPs2IDt+MIpO0rarAguhvbfVWxBGILt4TBBe8HA/mTK0rg/ylVlMIw?=
 =?us-ascii?Q?A4KdKFrY/H5SkYQ6uSoYLI/2GTkt6xq4bX9oFiyEcFdea0zXHl4q8p8rR4Wj?=
 =?us-ascii?Q?Wvp6bdndCH/gpwLuu+MWEFCfE4uN9NvXnrYqeNfXTlGRF67rRO499m/aG0uQ?=
 =?us-ascii?Q?phiVoDaJdmcvtt0YqT6G2FfYVjn0OObi1su+zvvS8GwXgMtoVWnZj6XkM1RV?=
 =?us-ascii?Q?DmHaJPHTtGcmUHmRjvGO3Igz1wNxgjrLTmnwuC5Y9IzkS7V6LGgiOFYOoXrU?=
 =?us-ascii?Q?30RpZV6NnyhLieKrq/cz302Kt8idpyzoZYE4rk/mzPsfmW/01XcmRKlay2Y/?=
 =?us-ascii?Q?dvlqcmAQt3duV3HWaeKjeg4Jfx6DuY/STmPxdaoyuDBzRgc+2tlcHsOznsPY?=
 =?us-ascii?Q?Gzc1bYJ761QUPLhP00jZ7ezZ77kxZ22Tu9zpIolF9j+D7lFJwF42kW+UKoF+?=
 =?us-ascii?Q?Sd0PZPYKYC2SIm/E61PL2jdWor2i5DCvWnCgaX82P983vikYatYB4UwUBTjV?=
 =?us-ascii?Q?UPfLeOqHOxWvZiXELkou1OsNPwdgxdfW/mc3quuV19GOSPY4eaoVMO1HJgo4?=
 =?us-ascii?Q?u1Q7X8T2COMszOmoP8EqtmFpDDUwnZONLnzfsBJ9FrYZde4QzrVvRVyirSue?=
 =?us-ascii?Q?pkcy9rIKKPKKepvkJF08fNMZ/2ATSbBQEYX0Fgf2QDbmaE4QDbaVqC1UZqAR?=
 =?us-ascii?Q?9d5gVctpavvwVm5u/UEqw6jXEn0ioaFZ+dWj2hGfnv2isFnMJFMqVn6Ppx9D?=
 =?us-ascii?Q?rMCs4D1eTtVfQzPnWHQbgwcZP4vxP4kcjKEYeJk1dUdxYjJ9//htY2h6EOxK?=
 =?us-ascii?Q?kpt66bjM4f3FBX9O7AdLGNlMa/ttGZB5z6FoEhRbdd44MvZ76rqSldFPs1Qt?=
 =?us-ascii?Q?C4ZKfGvfDGmi7tOoj1+M3Al4ErE9PDevl7fuy4aDH9CifGhXBQoM70hMSxaG?=
 =?us-ascii?Q?gUY2XhHqXPSQU/AH+bQ7M1XJhHjP/Z3L71XoX+p1CSLDwlf7BhDqwXGGMXbU?=
 =?us-ascii?Q?O3hwewYFWr9UGYq5dcuIJVRhgoGKIJMEL0tkcCyKw3GcqW0iWHQTiMoy9p0N?=
 =?us-ascii?Q?jnkAL6nXhWSu5aDlRl/Mja4iyw8HMi5bNN3BGlQlsL3BxPVlOx3X1qNeiBmZ?=
 =?us-ascii?Q?II+ejbRlHH+lLAWIA1C42eUYE15+KqzzxqOrwwLW//YTDGlCmuHhnmZ65iUX?=
 =?us-ascii?Q?cw+3/dNaHHVeP47LP8qcSPCooPH5AHTb93xKYpVhQMHiTaAvY+3dADbOp3s3?=
 =?us-ascii?Q?g5IDQwndsVoHhbGhVmqezO7jVig+AeQWfQScuOd6MEO+pWlyS35Nl1+0XduT?=
 =?us-ascii?Q?sjDAOB4d6Yh64EsWhWCh7Je3FeVL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFSsnIl0L9q2/Ne4QP/PPqS/P6niVnAukTTYALHNfSaBUnCiyp56RysKEyNo?=
 =?us-ascii?Q?Xiol4FAzod/J1Q2fBEOYWuYTP6Sxdg2QAB0gGqYjoxxYgLIjNU+7747n6RJ4?=
 =?us-ascii?Q?XtqUWijFZOPNw346XeVddpcwWZP0IUh8T4P2zhWXESB57OcG+xOlpsIEHiPS?=
 =?us-ascii?Q?umFBInKynU7bKWQ3KNFf00UxGEwqnHIOo5t/gefvd9WJHQPg3sdVWC5gYEJQ?=
 =?us-ascii?Q?9sM+19Tzqve68dgtrYgDVwutf1uuiPqu7S/XjhMao/I4Z0FZFQLk+2qDrmNJ?=
 =?us-ascii?Q?rrTgBbb6+py1oDLK1iqTzDNusC3HrL65JAXwxqIcIBfcYXlmc0jZIl9vo5XW?=
 =?us-ascii?Q?ZxnYKW8Qz2PCAYYfKFvTWroRl11xbmllxQ40Umv5dZZb5iMJ8nJKFlWTSLVV?=
 =?us-ascii?Q?BxLvPq7zFqvpovskoSX2YCiT55RtKEIO+bhbL/0OY9NTo1IlytkIisw+TA4+?=
 =?us-ascii?Q?eBUk/Mi6hgzmDZ8hwcjKWjvVk6KwqnRHnnq7LssHHrKcdxuU4ISMoneARIwn?=
 =?us-ascii?Q?weFRGspzSNgIzDnu+xrdHLt5p7J4ifj/ieuYljDikxHF/NjDOeqnIECVuLqF?=
 =?us-ascii?Q?5jscTnjYFwszziBldKkAXekO0MOXlR0CAOVYZitKhqhDIVKlZ4HFB0v3SLW2?=
 =?us-ascii?Q?qtPfo6ZuJheGYqRImYZCf87bS+QHD+KxKFW1iTB0t1NBEZxEGtV8zZJXf4SE?=
 =?us-ascii?Q?n1iJlURSw/EHHffH3y4el6s/S2iEWBn15p2Yjx1pc934/TALXK6y9Dl/61sw?=
 =?us-ascii?Q?qWk0K7Bz9RyJTIIRwKrdROrPeqelgZeb9oMvIkRvhv4IVM0IkHkRMySj0BzU?=
 =?us-ascii?Q?y2wiwlGFB3yHuB6jm8mrSW9F7R1KnsIYtydMjSTbOKnoYAqmvr1sTpzswl/d?=
 =?us-ascii?Q?i6njJ8orBI7zethWywriSno9SV1yqixGmKaKnEI1cRiWbEZmeALvf07g9QNm?=
 =?us-ascii?Q?Rq89SgP9rBpsOH+E2kivON236cSHG+perPGV/QQsjG74KdyEJ9wLIPnc2UCW?=
 =?us-ascii?Q?mJM4qSTRVC+F6vRGvqxERZfegN5kUTlcHNsWHNnur1lW4oZuWeBYSTlZ0ZyB?=
 =?us-ascii?Q?IAM6VxtcTX/ZMFrvQeVXLQM1H67C8kxiN58wXdNOYYfBVupxWbh2rP9MfF6h?=
 =?us-ascii?Q?iA2S538unIatVoWrj4WfJyZXDnwi0xAQ5ei/2kes49yHWzwzMFy7iozzvoqF?=
 =?us-ascii?Q?KIzvImPsdywl67vHrOpejFkxLHWUyQS+ctciLbiDAwdohSpzoJycsTyJ00VU?=
 =?us-ascii?Q?4sH3PrEyzaNXi20OUnGpQo8GAsNErz5T9AGfLCySau3+8Bx1OYbp9VZvm9U1?=
 =?us-ascii?Q?0UZJ79EPlgazIF9YG+U+UUrn+hGgxx12YtOLPrGNsbQbtaRQe9fm9mRcaBCk?=
 =?us-ascii?Q?D1rrziNhoIYyKnDTiMsR4/+hnGX8YEoHtBl48uVQSBMD4qQFW3DypRyfezPm?=
 =?us-ascii?Q?U4q9GCmDRCrDXnl8Ooxxre3pd1WUq9j9tb1SfDhVVtP1vDyaR/858lpNN39o?=
 =?us-ascii?Q?4ocBREwP1lbtrrjAAz0M2JWvwh2cto51QYB5ES+GZ7nCXbPSgoxr53FnwJf0?=
 =?us-ascii?Q?cyJ2YKMVVZBFgClcSR7rYJonpfwMP7c/wEK//FF5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VFdouCoM+AsP5CAecCSYKOweSyaqrjv5Fo4f/tqcley3UDnABu3vIpqU++WdV54TGwU9P/W/04DzGtcdoQLwYRX5TdkZsGj7QiO968CXVbsdigCmyZgMS/bTI4CChgGOfWu3eyzC7wA1xWElhlDRoyP12gNnWZ5CEGgPN6oWtICxjWq9S+fQ49zyV87RfTgZtsxfdQkKAdQIdXbDNtUfEgOrw6rLCSQyEpbUtLr/hnspIHozvnSJ3xojkkKjyg3ooX6OlCwT1RPwajyWHZ7HF24muUXQNZNPiQyUMKN1KwucsZgpyDnwzVd0zRBB/EjZholPVPUonzHOPJF6zqrajw4OEZA18lnHXyxh7/WYhkqCQ9Ebtkm+ZLU/gAmZjxCbRM2PaoDoAq+jSOEOPb4VFgLX+WV75BwCavpwQXFx5Wu7EskGKjpJXCnsBUey7tyZUA5dNyoBC/DpduxCMZqi1y13XIFgzrmCX6dDAoRw+mK8kHR7u2zpY+M3fA+WvYWUKwDlxWkoYZ3Q3dW+nsg2mXcWS7T3xlkzRkGW6iDRK502h4Hf0IN9Kh3gIyF2cMsqCQOFNFnZStWbGAMmmR3OsJbhMyxFUjSGyxivs1jJZ94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fabd16-0a40-4e35-72b1-08dd7587343b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:31.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0TB9q3oCiFyIG8WcayC7P06jJZnf12J7maZHSm87jTl4OjoeaWdGHP0tmBdSdAdHtkBhiDcbvQYKZpf18M1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: MGPi95xgSsXOaWif89InHetYcs8huqy5
X-Proofpoint-GUID: MGPi95xgSsXOaWif89InHetYcs8huqy5

Added filter helper to filter sysfs write errors, retain only the
error part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/filter | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter b/common/filter
index 1ebfd27e898e..bbe13f4c8a8d 100644
--- a/common/filter
+++ b/common/filter
@@ -674,5 +674,14 @@ _filter_flakey_EIO()
 	sed -e "s#.*: Input\/output error#$message#"
 }
 
+# Filters
+#      +./common/rc: line 5085: echo: write error: Invalid argument
+# to
+# 	Invalid argument
+_filter_sysfs_error()
+{
+	sed 's/.*: \(.*\)$/\1/'
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.47.0


