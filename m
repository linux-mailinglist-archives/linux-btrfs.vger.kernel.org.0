Return-Path: <linux-btrfs+bounces-15714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA04B13D60
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FF67AC351
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360D270547;
	Mon, 28 Jul 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIWvDr5y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pcflVc6p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AD2701BD
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713433; cv=fail; b=VmEQaD9aLuDqmGFUrkBReE6xzv2Xn+x0hzMxxOgegpl8z26jpdz5mBlvuMkKYI4eAuUFUK0EGpbqHB6X0NP9PVFFgnw2v4nHcgO9v/KSSJifdPnbyXlHEPGvEm1tb8ee4m1++dnabEunt1iO0ubD165ORvOw2uSrA6EGgXNLbak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713433; c=relaxed/simple;
	bh=qRpzwc/0VOYQY0EDFpbtUsBm0vSiV3Hrnb1Vc22xDP8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nvYlLtmW7AiltjcFdi/Dk2WLW7jqsGUgOyeKe0GqUXbI7Y84mqUrjD5W6NHYWJ4kHQJ5Mb4fgWn4Ry0N5JPtLMWH60bFvWB8yBeoBTsNC2WWNa7XJFyvPRIcXvAMZ4DPtihLJZtxuvAK5hQyeI2ouC60P6QkqTXJlFV9aoodegw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aIWvDr5y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pcflVc6p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SEYlcd020118
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=XcdXJx2nGXWEfRa2
	cz7TaQsH1rlAhi7ApNw5GcdSDFE=; b=aIWvDr5yCqQBOQKIXi2BviM8JmRZpCis
	1OOB+PZ5j5nnB/l+9HY6ETIT0BEsaXjpN44bP1npMrWonUBeNeuPiY4WkrU1TfBB
	ajCSJ5N6LpWJ8If2T7kWKrSZUGnEhFKlT5Ge6pF4AkQiZIzKfsdQH1ldYQHdNxVB
	Ao3ovAFTRfk6dYfIzeGzu7Q0wh81CUFHOEvk9qTRxYlHOHqU508vDDaBKsVIUwuW
	zn0sIQdXlMNCl86KvlnzWIMP94Ug/ExVxdb53VNa/Zr8h9f3QKyHUtJs1SqcNVhN
	NQpUJA+gG5MG/QziyvlMQ/h8ngk+L6sZPYW+4aMaIrVg2JXkvzrv8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwmghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:37:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDumUY034491
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:37:09 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8whkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usG+/pOY+rkc1mFbuY2NbWlTIgqSiMWQpEdt5/4Jg4wjSpwVVqTLuZSGRfU5SAQRtCbt33xyB4yB15T3JCrIRWSBjBUVOLKh2miAON0qnANNobI50FiIPZjtGzbgjm57y9RdpcUDQARGsDx2yvZOlz0ZDOTCm9JlKuTVeL259hAqFcPdNDvU68Ykkf+yO/Udc8W1wcMcCYe7ZYbexwLAuKzkGAJMsdIUkZM6uOeeqlZ+TgIzOEAnaB7mBejXCadLX8BXRkAHlUj6oa/Rh0aB0ZTyY0DzWw82kDpMrrBCaEypNvBmKpV03k5wEOcKS4IyCfl+2/j+nrbN5r0R1HfiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcdXJx2nGXWEfRa2cz7TaQsH1rlAhi7ApNw5GcdSDFE=;
 b=pcR5iBxzht+Gkd4Yid2WDME7YdQsQcZlkRpXPeBTDXnoVOBc6I3sCcBosbTJgZb7GCD4I9GAQTPOQNdHDB72D08RhxbWnYFdAO1wWsJHMkt2Hogb0YupY/qYCm+DMoZogweR+BnqV+REJF6UZcwpsS8yaK3d2HmzEZRYdSfET2smwUroxNPxj3v8OYgo5thDlFuc0orrH2B7RlywlYOQ1h7mAozw9Gx5U/lsYeHt+FukpOtLxOFfdXgIRvg4f+TD/6hyv8ePsP+6jBmMn4L0KVz3TUxU8aKIdH7uuLqKkMVuflHWwUBYpl/WbPW+XxfxA5UPZPmLyGledV6qMrmf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcdXJx2nGXWEfRa2cz7TaQsH1rlAhi7ApNw5GcdSDFE=;
 b=pcflVc6podXhp2YTYOccYV2OYBTqm/KSmKqP8AMHB8YYuqgoY2ReZ6MFqAA7YrYpEmimpWzMuSxWY3iExOjTbPVOEpHBlomdel9AmwBHeU6nRDfRB1qNgtLnYOrE3OyZsCjgIp8N3CMA1GI2cOSnc+sZ8x6PoUjBzIVlWkh+iYk=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.25; Mon, 28 Jul 2025 14:37:07 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:37:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: use zero-range ioctl to verify discard support
Date: Mon, 28 Jul 2025 22:36:52 +0800
Message-ID: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DM6PR10MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c1d862-137a-4424-287c-08ddcde439be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0GFyQZA5dMUfExXF9wxPe+mANu8PNbJE4Cr8cA4/Ir5spu3Cd5OwxZCv5GQ?=
 =?us-ascii?Q?J0r+W6p2V4NMDWUEBZkUa6yuvy4fk3J795Mx6TNfr6SBW0UcwEKywmNBUp8w?=
 =?us-ascii?Q?jq1I9GMgg5HgSQsf8GuXWQIFgZ+Cb910LxTHVcH9BWxlR3aqbWR8KSNLON0v?=
 =?us-ascii?Q?a84Lgov3CcYj922OnnJPA4SPRaonVeLhz09/6KZbsWaim3AnRxioW1QjU8xm?=
 =?us-ascii?Q?gfD1T0GLL0c11DthBf5c+ibtBZYJyFyG/VJrKeXDD1B121wkHOjAaS38VHsh?=
 =?us-ascii?Q?X5zLt24L6XqftMp3nnrvvFPvKycg+JOGrNR8rEzLFCwRDFsUjEJKYFE1BBKy?=
 =?us-ascii?Q?XRsZF35j3v3C7tdu1EN3MQJD+xhEuMfjSRtbeo1HzCPOzZtL5mX1YeiCs9Q+?=
 =?us-ascii?Q?e+NMSJ7+HaTNRQiUWfF9kZzHJ5QsXtpyPYsuo/cs0BORm2nWEujiqZp1DuuM?=
 =?us-ascii?Q?c5DNNdxjRO+K4KDgMmnYKrrSTShjiEcEtj9oA4nnVdxRYQJk6mtPhqLWvXOm?=
 =?us-ascii?Q?E52Cwyx554hY/1EDD5FvbYuTbU2bBvhxK2LkIeYjHNR3fyWTsu/UHnuzDbNP?=
 =?us-ascii?Q?lysOSgvi0YN8UcHA9K6H00FS7tcqNVYaGYLWwRcoL3Qsf/p75yXcFXlJtz+o?=
 =?us-ascii?Q?rxsmzOH81iOxqs2j7w2m0+P6qtYJr982839s/c5fAR3hG5XNNU/KoJVNeehG?=
 =?us-ascii?Q?N9OjHDe74cziDz9ukEOolY14rbFznsa5VQn2lVg77hcvfTH8xdgiVNJ42T2S?=
 =?us-ascii?Q?G2H37S9eYPqIIyMsg1tfB9eeDIvRXaDEN6LVw5/KDe+Uc7loEZM9b8758tXk?=
 =?us-ascii?Q?m1q8GrJrpESwAwGJ1ga/9Ht7Gi73kuq21zFJuR7MGHddokLibg+GWfSL/sxy?=
 =?us-ascii?Q?UBFVF5mTmJ1XOZ5kRtjWuDnG3mFiTJe8kq/vm3bKalAwCnCtkcK+YEyiStcT?=
 =?us-ascii?Q?CStfGGH3dl597LFRkl9FRkvExnfi6qkNJBD0LbjdigVsVq/7PqdbLGSogKGp?=
 =?us-ascii?Q?HJim4tPMmLTITdgkaES8XujSaVkLmZpYCepCWimmML/C6FhohHlzmOT2nOxm?=
 =?us-ascii?Q?mb6Oyizqj7Yw9MHX9Nt03YeIV1LzQV34UsPyjHtaReYM8CWTH3zOp+XmNPd3?=
 =?us-ascii?Q?gX3ZJUDOCDJ2bts6aPoSpvfGO4Yj6UFl669UFEvsWkNYUxhep4ItsgSp7t4o?=
 =?us-ascii?Q?kyFuj/cXxV45gRIG37CIxjEYWX+kaK03cXzVojuVLo4mIpjhy2fZYfsiQMAU?=
 =?us-ascii?Q?zo4fByx8+IQTSCocDv2evhXq7RdQX5BU4oCrJAxMHXKCK0mUAth7vtKtUTNd?=
 =?us-ascii?Q?lgmS7kkuYo0PG1+a6/wcSBsthUbrqkOlpT/7Et+ltQOQgLcEffgM0HXT65v3?=
 =?us-ascii?Q?0w55prcyPIbOXex8wpwGcqdOVpICxHyWXptJJdY3lIKz43W2IuMSJE03/htx?=
 =?us-ascii?Q?+dImrs+L2KE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCrlt9NHMVFvLb8QSf68vyJUfayIyCbqmJC5PWA/w8TR7cNcb2k51NmpJiIi?=
 =?us-ascii?Q?Cx9FD0NSgL39zVQ2X7hKEpDp8jRtQqqDDqQu+0SezCNj0Pyw8/FQsYWZcJhC?=
 =?us-ascii?Q?AwC811TmnDlLi8GAwuLoBe3cyB/y+2iO4jkhYMnRh28MDM66PbSnqYOzYb2d?=
 =?us-ascii?Q?WkK0gSGYZQv6cTWYKhCH49ajwpDAKGGJzkgjx6KCU8Tl/NPnwOtViBbwqi7B?=
 =?us-ascii?Q?0Ws61Pn9tQQcnF9kvWF8Xj1BYFW1tNIHfiz4mSVRW3L9Ms4uKCVvlo4erJhr?=
 =?us-ascii?Q?JkP+HvZD5NsDsli0eLdEOVJ8b3VEbSp/ksgUc4aoOWnMCCHC4TQvyGMgwdHe?=
 =?us-ascii?Q?ep+a8aUpMLLu+mhCPUKsJPMRgNzQ5kFxoMLPft5VNPHEYS5Sy0g/YJdLZ+nD?=
 =?us-ascii?Q?6ZWSTph/UvYW71eUsyJ91PEFDMryGFG0biSTjrKAA17aq7YHyjbFm3AChCwm?=
 =?us-ascii?Q?G0jlvDJKoC3TXX/RjLZC2ah0A+fkr4MuM1NBEYVN54wncM9xjG1W1InyP9+4?=
 =?us-ascii?Q?K3NgtTsYakjrZe7h54dTQ9wvWIJgqgY4hgXsPcvT6ZHLf2q6kIKlibqx6GQG?=
 =?us-ascii?Q?1uNU6I+jmOKBuPQIKgOVEqd8XLXkRuMNVT59FhxaEsJVXbnLpS5Lyd88RLpG?=
 =?us-ascii?Q?yBVuiKQw0EqbFleTWVCGcz5PtGDibj/x2dgdxV8YcardS/y8fLW3h+gfjZnN?=
 =?us-ascii?Q?S4Hcugeq9qliYjpa0qdNK+7Jq9Mb36qqwVwk7tX59OP/Fr08CCxQx0KsdCzD?=
 =?us-ascii?Q?nI493CKMWXMBGKsI2Yrsyoewp7PLVsHzButB9S7juCqIOxT3darad2VLXr/8?=
 =?us-ascii?Q?EMlrwHQj6Mw7qSIcy+xs0GxVYYq//iHP7szP2/bO8ufAtJBrNrt4ob1E4UTS?=
 =?us-ascii?Q?ivuGDIBpIbvON5nttjWf04Ln2ErDxzfwnPRN9nXKMrL4467wlIyi0L57HXUc?=
 =?us-ascii?Q?uU+Smd2/mTL0DtceCd5lgYce2lHH7prE4/3wIy79ncNlV2MnpOPpUJqiI5TA?=
 =?us-ascii?Q?0m5rDF0Qy6vQbCSXnj7ZZB2IYjPE3CDH8br7JHRvO7dogO1F5jqtGYe1FAxu?=
 =?us-ascii?Q?u5cG1stBIW8gWQeLSrAJKgBsR/WIz/EfvGFJ8RBiGLR0LxO6TTHkqWj8QiDD?=
 =?us-ascii?Q?+3RMS0tVYcYiOFY2B3aCqXeQ/WBkvZLSNr3pYPk+uktalgqnSC+p6QFTew+C?=
 =?us-ascii?Q?aEpOyBQJd/Y5bEeFTiiZOuwkHSWJTHtMEPwQrtsj8CdSzzAB3yphkMb1NNPw?=
 =?us-ascii?Q?qSSWkAgXFI4fyRdAqzMk3L7n7eLtJGv9V8YqgUvD0DAkh9tETDGUWORE2R/N?=
 =?us-ascii?Q?22iF3ZDRCsHfSoeJ+SyEreFnlmmga80sxvwVqCHLsS1l9ttZC+LC9Id8vYpU?=
 =?us-ascii?Q?1WxS/wjjOTHoPV7z06ibELv2+m+HUAkPF/HltE1UcByaJvFVfPEn0WirI0W2?=
 =?us-ascii?Q?V4dj41MrjXwT8LnJ4DYyhmfK4Faoqh/TQMkf17ESY5hngA9kqAbDfX6ZT1c6?=
 =?us-ascii?Q?bryBbmpol1iN0bdqz2Ym2+iDK0uWy/Yjhsc6DMqD1NP51p86Uz7cYDgXYaU3?=
 =?us-ascii?Q?coFzSPWFb6SirX9tx03CKX5Mxw525XXswcWhpI5i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2qhLk7tbWTxaEgkaJbP/c4ds+E2tXqD4qrsQPZU0ve/oln1DDdwUWjGSbLfJLenC/3sjsurJxIoEhRpScWp1Xo28FYtaieW1gg7cpEn//OFVrXlspFhrqB5Qj+oqGa/TkfZ528AIl2TxwwukDcf5c1WQTQNF67BOXzEvFgg++RlspwU+JfC+ijbz+VZRGTr1U5mS0tdyaVJ8w6b9pZlo9wlABAvCbLdGf8Zl4NbjfXhH+pSxD5/YlcI1xRRutnASWLwssHFyORxZn4X9pYTGtRJl9CnjV3YvT5eRt8DWPmb6FhfxAPPJEPqxk0CZ9wEclcR2LA8otQweeDJh2MOfKh/VBIRZ3LWPMVv2pl5Lf0DTRFQdz9Fvh8T7XZQSEdzKMMND1YT5qi+itslxoakiqe57mzJ7JvLZ6BjoLqptKOj1FV0wo6dPJkBWYv5wvJS+6GbGd6Jk2K+Ng38UDFHndaf3rsL+CD2isnIuczgsdBzwmRpKjTnjQQNZ4aCa4AG0OLpZIXN039zUJwVbQp2etZ5RH+nZyeVRO9Y1XGSLNPJB5hI+UOlC+RdCOmspCGAdTCp7rEN0pctBaLrvfSRV1Y+egiDOQxZXpxrgGu8pO3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c1d862-137a-4424-287c-08ddcde439be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:37:06.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTvc2xM3BmBaJgR9MY8IubCxOLpzPPA6KlM1OFmJNAqpzq80gfMcu2xL2fgJmStddNAP2lML1JUvk6mYUAamdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280107
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=68878b16 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JynDN7ffP7NEwzpzogkA:9
 a=kXtnS4dV4MyXDVXLNudO:22
X-Proofpoint-GUID: z8pO7YdP5oeVNbyRTgd-2pddd3-9GfCY
X-Proofpoint-ORIG-GUID: z8pO7YdP5oeVNbyRTgd-2pddd3-9GfCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwOCBTYWx0ZWRfXw1eaPY/h3V93
 iTYoNDT5sTQ9cz0aW79aeuI2C+yvC3kVnxNwFwXM9HacwTuxqksckR98hL24oUmHa2y4vgXCfI/
 HOSu+WhoMxgzqC7yu8HjG+zjqm7eOvm1ohWOnnQYWvqBzmRbAPsvTE3A8KyDsDp+fueDQrYBAsa
 wGpu6F5akdFpUcxHKcoUpFgu3uTa2f6lWtBlFhVhbtebpdJrysOsEDstWnL1YJsi8zQaSBOH4//
 L2r1Pmfc2qgns+bw4kkN38y1qCHqAEjXkvfBDAKl0mvBgM9ekyCfnVXGirNi5lAKB9lfJaZb2uH
 0BHGoSA5O0NQFidFeu/fEuM1RY696ORG0OJ/r3XrdFnYxlbTqW3hiCEPUCK5Hhcmao51RKwMljw
 USOihuU2uWaVYHvdhaSwNav7Bqc0gnNa0w4s4sKLg2Fq81tQniN5hOjlPdanLSGzFYkNWhCp

The discard_supported() function currently checks
/sys/block/sda/queue/discard_granularity to determine if discard
is supported, assuming a non-zero value means support is available.

However, this isn't always reliable. For example, on a virtual device,
discard_granularity may be non-zero (e.g., 512), but an actual
ioctl(BLKDISCARD) call still fails with EOPNOTSUPP.

Example:

$ cat /sys/block/sda/queue/discard_granularity
512

$ ./mkfs.btrfs -vvv -f /dev/sda
...
Performing full device TRIM /dev/sda (3.00GiB) ...
discard_range ret -1 errno Operation not supported
...

One workaround is to also check discard_max_bytes for a non-zero value.

$ cat /sys/block/sda/queue/discard_max_bytes
0

But a better and more direct way is to test discard support by issuing
a BLKDISCARD ioctl with a zero-length range. If this call fails with
EOPNOTSUPP, discard isn't supported.

This patch changes discard_supported() to use that method.

Signed-off-by: Anand Jain anand.jain@oracle.com
---
 common/device-utils.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..d95d406d9676 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -53,30 +53,24 @@
  */
 static int discard_range(int fd, u64 start, u64 len)
 {
+	int ret;
 	u64 range[2] = { start, len };
 
-	if (ioctl(fd, BLKDISCARD, &range) < 0)
-		return errno;
+	ret = ioctl(fd, BLKDISCARD, &range);
+	if (ret < 0)
+		return -errno;
 	return 0;
 }
 
-static int discard_supported(const char *device)
+static bool discard_supported(int fd)
 {
 	int ret;
-	char buf[128] = {};
 
-	ret = device_get_queue_param(device, "discard_granularity", buf, sizeof(buf));
-	if (ret == 0) {
-		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
-		return 0;
-	} else {
-		if (atoi(buf) == 0) {
-			pr_verbose(3, "%s: discard_granularity %s", device, buf);
-			return 0;
-		}
-	}
+	ret = discard_range(fd, 0, 0);
+	if (ret == -EOPNOTSUPP)
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
@@ -278,7 +272,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 		 * is not necessary for the mkfs functionality but just an
 		 * optimization.
 		 */
-		if (discard_supported(file)) {
+		if (discard_supported(fd)) {
 			if (opflags & PREP_DEVICE_VERBOSE)
 				printf("Performing full device TRIM %s (%s) ...\n",
 				       file, pretty_size(byte_count));
-- 
2.50.0


