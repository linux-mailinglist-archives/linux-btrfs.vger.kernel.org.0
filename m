Return-Path: <linux-btrfs+bounces-9759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4839D207B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 07:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29380B2102B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93A146A60;
	Tue, 19 Nov 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gglB81ui";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SOK1da19"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA613B7B3
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999405; cv=fail; b=Pf5tdV/tAQcApsvAvNChF3KwmBDFbPM1qWS/ebaCjQYM/TAnO8Nhi30A+YzDpRDR2mp5v3Vz6g5Rk/YD1FOc7lYkw1SaEGswbGrg+W+Di6v5gjo12N/sdpcgkWLw3IY2JT/MYgPDuosW/q5XEVcHdywaDufUIuJLCSChwedLOGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999405; c=relaxed/simple;
	bh=mZJe5nH0fxgz/W7BLNkIyFH+tX44GNiuS01w4Td0HT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JO1h3/RCec1+/xZRPu3G1xRDtp7Q/lbRoOBsNhnK4P4Gto8rl8jUjMTpwMQ5V24py2FHhLmGPgCUv6xq6b9AqP6E+pw7/W0r38ny2mYJdW48Eed4xaS+/bzTG48yeSLhLrcpeaG0StJoGcBiOGQWeCcFNI4RrIGnlKyiVICBD0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gglB81ui; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SOK1da19; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6Bqwq021470
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ap9X1agMoh2V7I0904U97WkEy7Nv4jX4YpZXY9pSlio=; b=
	gglB81uiWAZCNCjUBR/3Y+fFGmC0OXPUBMmBlCTr7RiCAa1UIWVVEulPRq6RDcXB
	c4XAhmatvGfG2vNCfwj2M/mNEHoAOAI6W8A+3oWmOEvLd2bfasA0zPJ2iUsDUY0N
	nWS/7Y+wAikhrraGLUlyTzobQu1VvoKkLXqAIGlZk6wdAWNZ9gfAuQtrC3nlQyyg
	VW0mO84BcOCHws9rfrv7mUvfbWuZgSe4BhtSMLWZICXVBLRjpRNfJARpv+l2UX3O
	ucz/oMTYtP02ww1LL42lUGCBHg98RG8QTFezUSamI1ad8TeOSzk8tC5ILN5YaV2J
	A69myx4VuVJywCTjcPt3vg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkxsv6kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ4om2c039974
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu82mhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvE6iqeRsjzyiNWVj/EkcEQeQlYbmKdJvQ02+0hfOhrIUZYIHcqUtCwAqgBbQ63OQoe59SXpKZxQ2RV1BPaHH1WABJL9ffQwtZsXKVwYl6mhjJ2Honj7rOH4qLeG8V3HwodGEy28ej/GRDoYd+nQd3fKJmpcni+OeY/+VYtjlMtjQX0OmxEesO23YlNRySmj06l9hFlzA7SU8CqFYD1FAy7HIYwCfa3TPJFF/1lRK1j1MWY1fAsbP1urmJ84nQPkQo+aZg0ci4sGiqBvE2ZzgJHvWhP+hfxJr29toht3/waIuK+TqLmitRAdFJVVESOdK5MlOrAn+8gUU9pCI2LXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap9X1agMoh2V7I0904U97WkEy7Nv4jX4YpZXY9pSlio=;
 b=pcT/bg3smU/ujUkpjJoDB506j456P3/0+Tbf+gVKvC7NjkMZ0ZRymvqhrni8fmQFhEYWBTfv8NtxKcJqPxc/kgsUaXot037tFp5dya95MASxJ3m8+Jh0nAM6+b5tq02KdRNWmhnVm/7lcQVF4qewdjt7KOq0501s//NJ+JZjHSPo0UJPoLLy0CvDjLGr3dHF/apUmCkNytapxR6oMCVh0SozBhuy3m6YjkUuPfyjlKoZzpfZzNOijQZQ8nQGv1+CdWrnzEw1T835FFDfmZSzQLfpEUgxLM2yc+UBw4y0tRN252bt/6znXKyzPclc2B9Z/hvEz2db8DC7BZ9fixENLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap9X1agMoh2V7I0904U97WkEy7Nv4jX4YpZXY9pSlio=;
 b=SOK1da19tJJwiCnTmjnVFtHcLp1rBKsOvbyy20fTgRqpdILS0zVWj0rgQYELK8RpCDpKevgRyIJguSDu+UaNJhKNEbScK81aAO6gU+7B64C0r1NTeyY/PCDRdnCMhvwjzaI4Rgr4UULdLXeG5VfJzV1VOThCdiFffp+tySC/nyg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:56:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:56:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: fix doc compile error in CHANGES file
Date: Tue, 19 Nov 2024 14:56:15 +0800
Message-ID: <e4fda6ed6633a59f6a8424c93c1b4a1362acfa28.1731998908.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731998908.git.anand.jain@oracle.com>
References: <cover.1731998908.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 635af71e-2581-484f-df05-08dd08675095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3O1pv3A5+BWUYY/XRqfih2Vr7QYRZkLKk7jr8LQINrJ+77GdsKUrZmj5l/WJ?=
 =?us-ascii?Q?PCBxBB+xLPmAcbthQCi/vwLJl2Y42bp7vfi4WkvjCKa2dCeueloDIO8mzlSO?=
 =?us-ascii?Q?+Mk71oYlJhxO6dR+Q0G3KZDmAXEgH1ng0OgO5J3rwE2bUacNVQQtBQxwViSs?=
 =?us-ascii?Q?OYQEp6Mzh6D1vt9sVHH9qeWYVnFeP2Vm/xXtN0ZG9E1r6ayJquC+H6EzmKrL?=
 =?us-ascii?Q?4sS09JZoRl5iwPbiZzoKh7K3KA0BHdV1m8CM5hG3DcmyYPeitlKPFi3zK/j0?=
 =?us-ascii?Q?mmRhStRPpuamArArSKtqlvH2ZY2zOsrPyljGMA/KWavRHnVtPlcSb7tM3om3?=
 =?us-ascii?Q?K0RnRBZNIsN1Xh0x3CwxiNVxnPDCpwDvYtlfmwXa3Nteh4tjvNO3C7pm926h?=
 =?us-ascii?Q?7PBxS1Y0gpgiLiBCz6DEbdyQ+O087FDC5qIwac6fr4N0Z6oPLJZP5dN5/yMh?=
 =?us-ascii?Q?DTadSnbFMaL91BAJA+kRqYPRe36GWeAxu7vv96K1DfqdiAO78mWf/DQgVlDt?=
 =?us-ascii?Q?SLTOGUy+5J+SsRt1XYCZJif73KWVAsL0GGCPcIDAGuB8ZPyoFiQG1dCbGf8h?=
 =?us-ascii?Q?GTjNxBrOJzrXqM3MX/1i4oBotMCjhMm30RrPatV5/bm0BsZnVex4Ne+5gtDM?=
 =?us-ascii?Q?ULmxs6fyIUAd39KWMu7/qNITdPsCUS6ouXIVwY9mzSSAqEKoS5XPwJzgsN9H?=
 =?us-ascii?Q?4vQvXRRz9Y28YyvaqtwX1r1aZOn4HlSlRIdBPhIuL2zGLFm0csUEYBdf9ZwZ?=
 =?us-ascii?Q?W/Tm5xGNQYeIkt1kBYZIndMj9X10KrniM2wTjUWA6WXN18xHTAqB/jqejFpE?=
 =?us-ascii?Q?XkhottZUdraxE2+pnSbNFdN3GxGjK+bSjjyvW8P0oySOiEI5jTDmjak+YO2c?=
 =?us-ascii?Q?6kC3GmVIzs9V/y6DMiXMmw9FnKll3fb3iy5K2L9rsf6XXy7/4nE6tLyw6vTK?=
 =?us-ascii?Q?LdV/9Imo/pWFA5+z4CguviCLd+fjT6/VjaniZtQv6LQX30tUp2+i4wjXTYx8?=
 =?us-ascii?Q?ekcip297oZphtpyGunqOZQuyx64HRsae/YcQet8b5uH37YKKMvWl+1mQFf9i?=
 =?us-ascii?Q?TRjA/85ciSTjxneHW3xqBPTXOSvQh5EA40PyTxKK6YFsRXhHNTuJiPr73Ewi?=
 =?us-ascii?Q?y2Md8UdljLW9T9Y49Isc1gR6hbnMsOzaidya+Kwi05hjkVQgvGcCIlrizvij?=
 =?us-ascii?Q?09ThWz1iaNblIjjyMzG8IPFGjHHpXzH1K9YUqV60mVsoqpzJNIQdlsJeBKiS?=
 =?us-ascii?Q?Sa1LPx6Sta/v1cb5ehqWOm3uXLutaPsIP4EHu5lxD8G2Az2GjJJoG8m6Hqmi?=
 =?us-ascii?Q?irNYWlnYJ3x/cKgIR3BRGKwE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xz0eLlJCcQc0QwEWcEr+U3Hdeb57njx6UttoypyB5Ri9yZ10stVcBRHdZjSL?=
 =?us-ascii?Q?UOaILJ6JtRJ2HZnS9CB+UxqrwzUvoPYdnkVVe0ZYjmjpBTsbDtLzSs/cjgZ7?=
 =?us-ascii?Q?fG0dpj/7j8IVYlL/tmJ3Te0PUKAwg889N7CsXNrxN41tAfqrZPCg9n1hmV4R?=
 =?us-ascii?Q?2xzg/Vs5oTno9tKgxZrTdQMTAM2OoZANGqfGVkPKKbG1b4lDjHV8U5hYElQm?=
 =?us-ascii?Q?PGTpkn8MsJgS35geK5V27MBYWFC1qAwubuNjhhi3u6I9Keolc/GKKEA4mYhF?=
 =?us-ascii?Q?W1f2+0go1xuzSNjLpC/C5v1ZcTRMSXQGHoBa95EK1SPaO3bV4DXW61l1w8SM?=
 =?us-ascii?Q?CElCGpmccNACBzDIiXsJSo/O5S6/69Bl2AbL1AeNeaPIqHK1t0bihSpABlLO?=
 =?us-ascii?Q?BxZXo3T3rY13byr0DuxjKBmTEtwtCVch9dmFCISpIWWXwarvnVZr5ohgihpG?=
 =?us-ascii?Q?4oLus/YhDi+Li+WGZ6vLlxB0nsSczRdu7ieT4NXD/Y77h+lK4yJJzzgmRuu6?=
 =?us-ascii?Q?OjDAU3TtdkhdDyZCNBZ11iFd/q6Fh00i1U/bxel3ioo4ZFQgVlzdlX/Mpzpj?=
 =?us-ascii?Q?2j/CWvSip9bDwXXbAzV47F8YVJH6eQA2xmdLZkeAau+lDddAAG4XB5a5868g?=
 =?us-ascii?Q?HXZuijHeyROI8+KfIC2w21Y7LgcNtZl5ElwUqnL6Un7bphf4A9BpTc0GNb8+?=
 =?us-ascii?Q?f9nJ6TRCPUpABVrN8UBbjgydhE05OYEdDWWfNKgiHgz2pNAMftSTx6d/GeKk?=
 =?us-ascii?Q?qBYm2kBZhEotXx/epzFSNzlXFXaP8OMi9icaN9rrHvRFjXIjLhFMccVvuW0Y?=
 =?us-ascii?Q?tpLPzGsUy3JP/HjF6W4PdIYlw4xgfx6C4C0hMRq2CTjkT3Jxwn1kTH4Thvzz?=
 =?us-ascii?Q?wQsULFcvSt43M1qLC9hdFPXcCF3SnZZZLnblfYZMJPgFzCw1dP913hiMN2xL?=
 =?us-ascii?Q?QO7VGxkoSOlVXI+78WyvViWMue9JUi/WxqggNgrkmx3PUgsv14zIByEZj7Li?=
 =?us-ascii?Q?uxFMq3JGpDkZq3bK9JbJkdYTfGafmZw9aY81bXXGvRAl0IUd7wqppr3zGKxY?=
 =?us-ascii?Q?gNwzxZ/pNtTBojJBbfSXKe9Caa8Y+lBFfn1sx1B6gOb5IQxwNnCmRQVwwSzx?=
 =?us-ascii?Q?rLRHmUaMcZ+5Da48RfdA+45QFxOiTFlfliZ0eVNZqoxrbgalYAOogtChTMIq?=
 =?us-ascii?Q?4jx/n/WPRH5Q2YsepTAq7SynZJTlJbS+yT3ypl0e2l+QRqeosxxkLEan8T66?=
 =?us-ascii?Q?XnQ6Of8RNQCRWkV7LgpGDg1T/Gssy+cqSpAZRgssITZIJ9+t5RVsKNI7/1ZT?=
 =?us-ascii?Q?m8UzTbK05byLD+DvxD6UVTzZ6L9xlp/gykH+zcshkWIvUGu74pfkmmTyTsWO?=
 =?us-ascii?Q?5RWynhhIcZdtj2mihFiqipvMYVTOMz+Ro5/58rhdiQgGIefxe8jKF9FHCjLo?=
 =?us-ascii?Q?az1Fw3Vw+CMY+xT1qiJiWikIKFJp3uRRr0tWCdp2u6ZMNfVjeoT59CWqPedO?=
 =?us-ascii?Q?ySjGTLY/9PHZJyypfEvStb5upZm+0G1obJy4uNf7e1VMPoxvXnlZcKgraT79?=
 =?us-ascii?Q?eJXs0wOLUk1YrKOVtQ5emEF69eCEVivIoiC1idoK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BA8e/+mHnrcus1qijDSUcN4g7pkRK2OyRgCPqUzsR8njnktWL46nGkWNwMKirDiUI9o+80e1gTVrAdl3BEp8zrh/iqe6nE6RAfEo8v5cfL8FH0WCDHpcc85+UnWWf9sM7cB/DPWqlKM34v4VmoiMg4j3XQdJLOD36WVqqKmwg2CoNoLSCnVTYquvqUnyPvMq70+kkKzSKF+PdnLJPsdYBQdKJgnczlPAY9JaV1k5a9vzTe4JgQPBNDJCjpiBcgt1NK8nd/uvYJlzzmkL4yUIYtJK9jcebP7smsA9eFCTYiSbvoFKQ/jrBk/d6iY201JNtUbpqfuRO9oHz0Yp5Tku9r5UZP5U2dcyrfJPG7KG/Oz+bsMXBN7B7BHYdVq3pHgbGCIyJJ1/ERTrtRUostvproSd40PGgJQvdvZZ+uotRDxasr7FeRTJAyvvCNhBRGQiQM484E2PJG8NTrRQJ7tjQQ+xbhj8+Ct8jm8IbNQRA18TWJmIMdghWXaSP/E782a3R5KYkQjVM0flg/lHajwTEwjwOMyTmwRAVz3tdzyiT/c55g+RGPfMxamdkQ2omPkediWmem3lzAlMvHegLFJsCqETXcvv9JO6hJfRVhIguc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635af71e-2581-484f-df05-08dd08675095
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:56:38.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64bunB2xCaUarIpz5kHpTcP/L7b4iu+sHpAwSzEULsaqHVEPWjaOCEM2CY5ieZTIBWyrJbTPMGqGDPwUSiV4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190051
X-Proofpoint-GUID: v0WmEYmWC2oDY4AxXOv-3MgLLQV0Uh0D
X-Proofpoint-ORIG-GUID: v0WmEYmWC2oDY4AxXOv-3MgLLQV0Uh0D

On python3-sphinx 7.2.6. and python3-sphinx_rtd_theme 2.0.0 there are
build errors.

Making all in Documentation
    [SPHINX] man
../CHANGES:26: ERROR: Unexpected indentation.
../CHANGES:29: WARNING: Block quote ends without a blank line; unexpected unindent.
../CHANGES:204: ERROR: Unexpected indentation.
../CHANGES:205: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix them by adjusting the indentation in the CHANGES file. The sublist
should be indented two spaces further than the main list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 CHANGES                             | 22 +++++-----
 Documentation/Kernel-by-version.rst | 68 ++++++++++++++---------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/CHANGES b/CHANGES
index e2eed4b4390d..d7f326c450e1 100644
--- a/CHANGES
+++ b/CHANGES
@@ -22,10 +22,10 @@ btrfs-progs-6.11 (2024-09-17)
 btrfs-progs-6.10 (2024-07-30)
 -----------------------------
    * inspect:
-     * list-chunks: new command to print information about chunks (i.e.
-       the physical chunks as stored on devices), sortable; requires root as
-       it's using SEARCH_TREE ioctl
-     * tree-stats:
+      * list-chunks: new command to print information about chunks (i.e.
+        the physical chunks as stored on devices), sortable; requires root as
+        it's using SEARCH_TREE ioctl
+      * tree-stats:
         * new option -t to print only the given tree
         * add long options for size units
    * filesystem df: with increased verbosity print per-type information from sysfs
@@ -199,13 +199,13 @@ btrfs-progs-6.6 (2023-11-03)
      future)
    * dump-tree: output sequence number for inline refs
    * fixes:
-     * fi resize: fallback to lowest devid when 1 does not exist, previously the
-       command would fail with "No such device"
-     * fi usage: fix "devices 0 != 1" message and broken output on multi-device
-       filesystem
-     * open files in non-blocking mode when reading fsid, this could hang when
-       trying to open fifo files or some special character devices, was observed
-       with 'prop set/get'
+      * fi resize: fallback to lowest devid when 1 does not exist, previously the
+        command would fail with "No such device"
+      * fi usage: fix "devices 0 != 1" message and broken output on multi-device
+        filesystem
+      * open files in non-blocking mode when reading fsid, this could hang when
+        trying to open fifo files or some special character devices, was observed
+        with 'prop set/get'
    * experimental:
       * mkfs: parametric zone size for emulated zoned mode
    * other:
diff --git a/Documentation/Kernel-by-version.rst b/Documentation/Kernel-by-version.rst
index c76a9c040115..d1adc3ee6ebf 100644
--- a/Documentation/Kernel-by-version.rst
+++ b/Documentation/Kernel-by-version.rst
@@ -512,20 +512,20 @@ Pull requests:
 Core changes:
 
 -  convert extent buffers to folios:
-   - direct API conversion where possible
-   - performance can drop by a few percent on metadata heavy
-     workloads, the folio sizes are not constant and the calculations
-     add up in the item helpers
-   - both regular and subpage modes
-   - data cannot be converted yet, we need to port that to iomap and
-     there are some other generic changes required
+    - direct API conversion where possible
+    - performance can drop by a few percent on metadata heavy
+      workloads, the folio sizes are not constant and the calculations
+      add up in the item helpers
+    - both regular and subpage modes
+    - data cannot be converted yet, we need to port that to iomap and
+      there are some other generic changes required
 
 -  convert mount to the new API, should not be user visible:
-   - options deprecated long time ago have been removed: inode_cache,
-     recovery
-   - the new logic that splits mount to two phases slightly changes
-     timing of device scanning for multi-device filesystems
-   - LSM options will now work (like for selinux)
+    - options deprecated long time ago have been removed: inode_cache,
+      recovery
+    - the new logic that splits mount to two phases slightly changes
+      timing of device scanning for multi-device filesystems
+    - LSM options will now work (like for selinux)
 
 - convert delayed nodes radix tree to xarray, preserving the
   preload-like logic that still allows to allocate with GFP_NOFS
@@ -576,9 +576,9 @@ Performance improvements:
   delayed allocation bits, applies to several common workload types
 
 - features under CONFIG_BTRFS_DEBUG:
-  - sysfs knob for setting the how checksums are calculated when submitting IO,
-    inline or offloaded to a thread, this affects latency and throughput on some
-    block group profiles
+   - sysfs knob for setting the how checksums are calculated when submitting IO,
+     inline or offloaded to a thread, this affects latency and throughput on some
+     block group profiles
 
 Notable fixes:
 
@@ -644,29 +644,29 @@ Pull requests:
 User visible features:
 
 - dynamic block group reclaim:
-  - tunable framework to avoid situations where eager data allocations prevent
-    creating new metadata chunks due to lack of unallocated space
-  - reuse sysfs knob bg_reclaim_threshold (otherwise used only in zoned mode)
-    for a fixed value threshold
-  - new on/off sysfs knob "dynamic_reclaim" calculating the value based on
-    heuristics, aiming to keep spare working space for relocating chunks but
-    not to needlessly relocate partially utilized block groups or reclaim newly
-    allocated ones
-  - stats are exported in sysfs per block group type, files "reclaim_*"
-  - this may increase IO load at unexpected times but the corner case of no
-    allocatable block groups is known to be worse
+   - tunable framework to avoid situations where eager data allocations prevent
+     creating new metadata chunks due to lack of unallocated space
+   - reuse sysfs knob bg_reclaim_threshold (otherwise used only in zoned mode)
+     for a fixed value threshold
+   - new on/off sysfs knob "dynamic_reclaim" calculating the value based on
+     heuristics, aiming to keep spare working space for relocating chunks but
+     not to needlessly relocate partially utilized block groups or reclaim newly
+     allocated ones
+   - stats are exported in sysfs per block group type, files "reclaim_*"
+   - this may increase IO load at unexpected times but the corner case of no
+     allocatable block groups is known to be worse
 
 - automatically remove qgroup of deleted subvolumes:
-  - adjust qgroup removal conditions, make sure all related subvolume data are
-    already removed, or return EBUSY, also take into account setting of sysfs
-    drop_subtree_threshold
-  - also works in squota mode
+   - adjust qgroup removal conditions, make sure all related subvolume data are
+     already removed, or return EBUSY, also take into account setting of sysfs
+     drop_subtree_threshold
+   - also works in squota mode
 
 -  mount option updates: new modes of 'rescue=' that allow to mount images
-   (read-only) that could have been partially converted by user space tools
-  - ignoremetacsums  - invalid metadata checksums are ignored
-  - ignoresuperflags - super block flags that track conversion in progress
-                       (like UUID or checksums)
+    (read-only) that could have been partially converted by user space tools
+     - ignoremetacsums  - invalid metadata checksums are ignored
+     - ignoresuperflags - super block flags that track conversion in progress
+                          (like UUID or checksums)
 
 Other notable changes or fixes:
 
-- 
2.47.0


