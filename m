Return-Path: <linux-btrfs+bounces-13935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBEAB4303
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B421889D5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD802C2FD5;
	Mon, 12 May 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aU1kb7iB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dYTVezjg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E52C2FD0
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073452; cv=fail; b=n2Ybeqmdax4C3aiUjB3E3G8mw//GfX75YPgscGxTKkKZa50K8EZjK4YZMb5WI50Dj2VCYV4ouosiLuO38+5IjKuw0lTMfbN/wtmrKaLMq/2h6PjzfZwztsCQ26wveix7HREwrrOlqcN8ItfCsbjMgjJIlCRt7rxuJqwvNcEcOC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073452; c=relaxed/simple;
	bh=yVN9FNdz37SCJGYvqx1xVM63Kdg8m+zDVAbYxZ2ydYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKM75aVvgTczqnjE+o2PtTYYgyp/JyboHPZa+NNsGovJVuGxbHAhtlTmLeOB2XLHSiDme3Ao3GIoks9/PcYwroir4CN/FdLQIRIpXrbMeZZKiagLE3Epd29unSVrqdaeQWLDXCOjgimH0GUmGOHvtEIyftFJGTQ60c952fKEIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aU1kb7iB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dYTVezjg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0ve5026917
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L7jrtDkgWUrFxufrx+phOEarYQJSdv6RU5aPB7hSOS8=; b=
	aU1kb7iBtSNaFRmVvdDXTGyTeCrQo5RQ3Ih8I3Vg+p6BVsrTv3zsfPYQupS3TOWk
	UcoSSecui0Zp2D6ogEd9nBasu1cJambFeVAUfaapLQGBCRqqEnv28pjGNeaUguZm
	AcGzyNPWry+dlqsp7cQ9zkXBM6KaR7Km6foX7rsy4G+TDfOCwqUEb02cPJrC/dOU
	v5SVkQWHgTMKenoSisZgAeZVGuhu1GT1QENUJzst7SL04IV8hQpPjxkk8rVhPTg1
	W289KEVIGHVMogxa91TALtz3Wfa+f/WFap0SDndAqL+UidZGhSR0WuOuRERqnlzV
	jke8XTyzoJldnStcATtxXw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHYHcu033157
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:48 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dq759-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8RTNV0OtXbPSGivfAOxxdi2ToijePug6GKksNHImC8p1Pyh7BBT6TbAZI/6osKavi9u//3GdvFDCBjwMRPI2u99h5gplqmikWbC/9HwTM8RIbbYgNsUTigESKuvEo+YTuvHmQ3AmPTYX/ZgcnOkfKoM981gMzlSh6f7PEtMGv6KsLQeeH9afDEYHKPvoZOS0nFAjUblY4PWpIDsJPnUzbCcpWI9ar2mJZlNYgkLrzi9UILxTPy1yfP87M+M4txxf8b74xGVX+2CQ9PVN0lN6HzKHniJRqfUi/hm1ODZnrgQ3WsJzbQ8xCTu7qGnvp+7M3a1SV9OasE6+ZKbi/Mz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7jrtDkgWUrFxufrx+phOEarYQJSdv6RU5aPB7hSOS8=;
 b=JNiD4MlUvltDVu9ah2PVFr0nn7eyj9ORRa8AQxTicYy0DLhlFNJcWPvVD5srBs+jFIwVtFUZle9nev7N5PZIm9Stl3U9Py+alGpxCHMs6XPG+ju8ZkrVS0jBsK7faQF9yF76kF2GzU/q/0Z+mXZRqRS7LQ7+x3LveAzezb1WXDNWaI48FW2Vci/uvUNsZugVRVCJ11XK51iwVFx0goPNOzOMs39/zhMXWO1MhTyGFbjLDDIv7PCwXvzo5899vBFgdblzWeN1lt+xTZMZmqOumci0zUT5oQWP4gll60qRXsyYnXWlOb2/Ol6rBigxFDqI7wbQe/o+F8NdpjFDinh4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7jrtDkgWUrFxufrx+phOEarYQJSdv6RU5aPB7hSOS8=;
 b=dYTVezjgrU/NU+x6ybkuzfgZZDQjFZTSl0Pn7voifmY15nrDEhXBNwcUkbasFG2Wk5+K7rVhwY6aLIrvbAMTLp7LSFeXFYagvlrDfKQ8Zs4kxzd7XkjWppmnU53wWQdh7lgJm1tBWGFONd8Zyar121eycI91Riu/SjtdwUqYpos=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:45 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/14] btrfs-progs: mkfs: device argument handling with a list
Date: Tue, 13 May 2025 02:09:24 +0800
Message-ID: <1c45f4ffb1edbee914271b04b2aa82bb32ed3be2.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db1cea2-8501-49b3-0add-08dd9180506e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGKH9KHrqqKJ6cKY4WC2wYAuD/HVE8H2EClM5ECyT7As9FanWeYfIaSHnlp+?=
 =?us-ascii?Q?fy2uIA5ugn5y5rKRowOde3sd4QDobNIN5KKdagRZWwtPCc8fWlzQz1fpRXV9?=
 =?us-ascii?Q?GgfFhu5nrb2kT5+W6JcaZveWjwJWfi7k5n1VS9GpKgP9BnpXazbHhUe7ZV/X?=
 =?us-ascii?Q?u3O4Am3Y/28t0gnNIplQYYnb7S6kCNoCoypcpRHZlrat45ASc1lfluZxQBeO?=
 =?us-ascii?Q?2q0xNTmlJBxtuSHWWb3qVkV7Dmd09t2WuRpC8hp0eXdXHy/FrMhJ+mtPBNzA?=
 =?us-ascii?Q?LH5IWXORN+kz+DzX3iD/kdK4zGOSdh1Rz9rzeh+tyNfJQE+m0Fk/LCqAO3lS?=
 =?us-ascii?Q?Yd13+Z1jNTrpvJYSCF8yL0lrgED1B7VLwHb4Zb3DxV4KHEXJhol8NgMnGbki?=
 =?us-ascii?Q?m1zMrUXnz/yKqabOVBR6QSQNIk2marRYw/78umeempKP+T3AvoHWzTwkEtas?=
 =?us-ascii?Q?Ow4zUWRA1pUMwuKQu3MoONMKIiCIgKaqnsBf8BY0eWuLksUI45KlqQj3RWNa?=
 =?us-ascii?Q?eT1aLQsjRcDDHnMWy8P1YxEvJ8GtOK5lQpa5q+5xJwqgfNgzkVbhpHrvugbZ?=
 =?us-ascii?Q?tiHczpXM5h28dDrOTYTij61cXGsNDeBwf9ewwxtuL7HP7jOIdN/I8q5zlbuu?=
 =?us-ascii?Q?FoyUvLEcRpf15r7MBaG+JzJu8tTTm8lWW3G4n3cgNKesGA9GhRxvithaNGVh?=
 =?us-ascii?Q?VZin09SxyNnRFj5GGtS76ft+ktdKZc7fG+unChrsg0A8OTayKCOflFoP8Lb3?=
 =?us-ascii?Q?eI1f6e0it5hw73mpBYwq8CizFAKJPhk0TYZOXx5mwufLt8PNfGOaCFlbmAVT?=
 =?us-ascii?Q?uw6aefRU2qyQ1Sv7CQRzkC4V79v/L38q81B4E3TQuu/IjaYXWjsG0Bhnk7zl?=
 =?us-ascii?Q?YQRmMm9wj293udwN68wzXaIeBlySxEbXQgDH/lRu9tP+BeUtJJacGVhgUGVP?=
 =?us-ascii?Q?xTcTmOX5lnwdrf6hCJTfpvNqgB6OSjBS5hz9zaJp+X0y8a2PCD1bKcwjRwK8?=
 =?us-ascii?Q?xIghUsxjFjT1WvihNQVk7VmcVjLg0N2r+m8tUBfXmkXXrdvXgds73m+PbCE8?=
 =?us-ascii?Q?ivEPbhAym5MOvQcAi4c60eSZQQBKWQpzp7C5v8Kg2agFlQVbCX/m38fhu0WM?=
 =?us-ascii?Q?ZrkHU/4z9QeQw3Ly6ZBxGWCfKwdUZ4MtZ/3PiOW2UDoUCfmM9GZACwEZ7eHP?=
 =?us-ascii?Q?x+wX3bPZtPtqGVLFUGetnp7TYfyou3m6m+GbNdQzWC8sojbs2qsncWa1RzBf?=
 =?us-ascii?Q?zEdFXQSqXZ/2tbDuoZbK9JFbDPMGd6TNL32Bqp0red10V/oY4vxtW/D1PrKw?=
 =?us-ascii?Q?+VC60n1X9EoEUwCr+9ZFDxkQrC+5oeEwG70H6g6ANRdnlno2MjchG+PyeFAO?=
 =?us-ascii?Q?KtwTRe7fuahUKJaytqM0QvtAU7u/Umjt1LySBrdzgK3nlzqBfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tV/l0hz1k+eFwF1KZEh20a1Q2pEoL0mBdYyzoxQfSq44kXm8Dlxb2XtCcfXz?=
 =?us-ascii?Q?iDhQADS8xlT7QpTPqhzmnYLOYwMwbymnWFRhiKZngSADhuqg17aE9gBbNNgy?=
 =?us-ascii?Q?cLaGtPentE7o/rCzdrTKXOC1HaLmm+JRWClN/d9ZbKrEKYTHC7vNJiSACG7+?=
 =?us-ascii?Q?4ushtj/VS5Zdj/I+LJ1p6MgUgtY4u5jGsC4zUG3bNHWFp2g3V8q+JWlWh72G?=
 =?us-ascii?Q?u6DP91ggoXwdCvgJgkpCpwx5S2L8bJgNm50IJ8Y6c5ajfoyRzeE20g5hhQYF?=
 =?us-ascii?Q?NI3KEpIwywa6doAhyGYDUd3rYqLcJmhffDATLHTObaX/+iEB9dAXn+dA2mLf?=
 =?us-ascii?Q?tX7vt/MftReFRgvNCcr1Xsl6RGLJB7/EHKo6hkMfyicIvKEWQO8AG3/XGyWZ?=
 =?us-ascii?Q?3HlT8IPAeublQ8j8IAI6SLgGBFkHjOYa+WLNH+Nejy1Fok58F6kC9C+uEeHN?=
 =?us-ascii?Q?14Z+QkNgx5/rplOGtx4jxNue6p5D3vsbdal+jMP0o6J+iIK0u7KYYo6zP3TM?=
 =?us-ascii?Q?iM01sCJO8OXlL9e1bnCJa0h3GpazphbIfasMEMWhyUD49uEx//400vQk0iNe?=
 =?us-ascii?Q?e9ZKEyT3ZSMLwnmHxrBD4sDLHx712xt15DS6ar9slkIBKuBN2Ilhx2cX/AgT?=
 =?us-ascii?Q?azc9BOnn/O4gQ2jooTztXUGrR8UsMhhC8aPSjpTohgfu8ZxNFfkDBpbM5ZsT?=
 =?us-ascii?Q?aqPHrYzty8IuvAU8cx9HhwH2TD8y2bj81VhtTnatU3ylVjnq+r+R2G4AiwN9?=
 =?us-ascii?Q?JAqKmRAXdqH4yGiw/0PESD5UDZmYMNc53Fyw4GRWA2metXts4ZL0OFlDrDFJ?=
 =?us-ascii?Q?+Y2eIENaXbU8CydZ5N0pMG6fLEFdGDUXUZ1DnHKgCJU62UHi+v9ZtE7dy4vz?=
 =?us-ascii?Q?jzs6AOqUXrKHrkqhlx8vY/Be9mZyfQmiwS6OolgJrBDwrFWE2D9NlyGHfOdr?=
 =?us-ascii?Q?O5Y7tMmJ6YxbPsUoVF0Gw5pjBCliRNO8meWlp2MwZHjH9+wgIodHutoaA3Ol?=
 =?us-ascii?Q?Dzr5BDBHbbmUxwZ6gCKE7/U+KgS3kw36HK9jU9iiZCSkPq4oiT3CtZRBLtAx?=
 =?us-ascii?Q?B98aCr2q9uZlJPuFb4ZW+kspcxfliTQi6QyYrI56cRLvBR+G+WVFdkCfshjJ?=
 =?us-ascii?Q?EYghHFU+qguKjdXRApXSnn94r6xpemrEWE4LTmlUh4cy6CnTvODXVqkpmpmr?=
 =?us-ascii?Q?KgNgdNZcn3PXHg4weYYtXwq9WhBsaIoX1gKWXqOVtizA3N8zRqPlkB+HeY3X?=
 =?us-ascii?Q?y0qMBYy1FjsQKWRr3/97qOqki0ZaRFPJ5Np71msABpCcv7mIYAeIN72D5UaW?=
 =?us-ascii?Q?ZbZCfgWgwvASEg64qR04XyLJxoXfw7AafT640U3GatNnHRFP7o1DFTgVGQGE?=
 =?us-ascii?Q?uSN+V2YUM9K+2tPLXzD1rAQjhnV1VgL/RcXIdEyZlVsA6jY6w14BCtmibCNz?=
 =?us-ascii?Q?R2Zp/0Vq29YkmnpVo2Qebkt847NQAkygj6DbaDhXH3sBvDeZ1leKmnzGPGYv?=
 =?us-ascii?Q?YIqKvt3AZ9kqqoNcLZCf564K0p1OqVT5DGI9woQopKwTRU4D3eMritmvm4Vp?=
 =?us-ascii?Q?XDN+8Ql1URh2nasE8bl0w8RTbx4CIIhDs1NME2l5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/hFx+GhJJP8ZL5NC3mYn0CK3GI//QjUo2Wj22Koat6K7+Y4eXBPFEsDeRe9iXc61Uxkh17v6RMm7mo8TTCPs807yBIRyQ3AIqR0nwtNZKOtk6w1wDXA3Zap6opQhew7ZTqC7HOqB7wSWnYcsOuCCw3ERFgNMv+GugGGhqK8Q/R+i/YbQ1vfw03W2b3dJt1PCJsYQtQuqP0k24g/F/MQRFbZGRB4R0YjD6ze4z07V2172ymWkBY3Ab9BczB3UQh3IoFWor3F6jbeM5Bt1QuwS3VzdlEKry7Ph4T5xmEOYqpsfqlMym9CnD9lLoYIWRDTDo3rf4UAOAtRR5xHYtpCxcHhXzlnE5bUYnTPHJfyexuTM1I6bbUZByuNEwDat8jRW2EKMCDyT+KbIlbR+0re/bJ4Hwcbsdjk4YLSTcCfRCNkeZmz+UFwdWtkkwNMWAxhSgM87eumDpWG2QIatIirJWSFoc+HiW0emjwfi2puhxbhukiIWg2ivRCWwyhSMruyM69wNS9ZKAXivp881Rg651iUh18tQqiRv1NYXLphAK6Pf4ZJQqZzUyM3cmzltkqjMswJRIvCSHlsn7+lexU8Dg69CGKSSN4mMqb7zjAYAXNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db1cea2-8501-49b3-0add-08dd9180506e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:44.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNIdJp2vp1Fme0GKsfbdrPFuf9lVSqNBfxxNr/AetOcEfv1NEAJ+fe5i91gnsx2fw5TmGnYwuSOsJLekFvjPUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX54ApICHMZ4EV WQtoLoCyCLwZErvN9befBXJ99nQclctOgmLbav8jsWkS5x2SIhvkScgABNet6obz0DAL7sLeCrJ ycKgPd0KZ7sOV6NCsf7ggwTn5mWNWYCeYN3SP7UUaxIesPxOugdvBIAyKCPO4JJUfFN5TEjE19p
 Kkx92JwPknn6v36nQxx0yjIKFX+A38TyzEfEWpuIKOYlI0ul/t+tj62y2t8z8UJq9cevdw39jLt bEWWI94NXPe//f9mzwN66roDaCZSDy9I7DJ1xvp9do5wy7JixAJ90eTW0MNdntNiyD73khYA9t7 2iJ4FvfyeJMNZUA2SFNDNLqEccWkmLV/W8GspAuezEhwXxS2HcIL+TJGazDt/fbp6w+6yYSkWOH
 eavRsY/Zj/zj+RsqHjCboH3oxexocbB6/NuJwdEbQ9U2tMa/XkwB0/9rSbXi73zW6zYppESU
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682239aa b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=asKacWe_QcPULm4nRwgA:9 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: XdJc7Hz6rHIeG3uG3rAQ-LVaDC0VgqP7
X-Proofpoint-GUID: XdJc7Hz6rHIeG3uG3rAQ-LVaDC0VgqP7

Storing device arguments in a list provides the advantage of sorting
devices according to their designated roles. Which is a necessary
change to implement distinct device roles.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 82 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 0823d378779d..0dbc09339f24 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -999,6 +999,34 @@ static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+struct device_arg {
+	struct list_head list;
+	char path[PATH_MAX];
+};
+
+static struct device_arg *parse_device_arg(const char *path,
+					    struct list_head *devices)
+{
+	struct device_arg *device;
+
+	device = calloc(1, sizeof(struct device_arg));
+	if (!device) {
+		error_msg(ERROR_MSG_MEMORY, NULL);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (arg_copy_path(device->path, path, sizeof(device->path))) {
+		error("Device path '%s' length '%ld' is too long",
+		      path, strlen(path));
+		free(device);
+		return ERR_PTR(-EINVAL);
+	}
+
+	list_add_tail(&device->list, devices);
+
+	return device;
+}
+
 /* Thread callback for device preparation */
 static void *prepare_one_device(void *ctx)
 {
@@ -1156,7 +1184,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 min_dev_size;
 	u64 shrink_size;
 	int device_count = 0;
-	int saved_optind;
 	pthread_t *t_prepare = NULL;
 	struct prepare_device_progress *prepare_ctx = NULL;
 	struct mkfs_allocation allocation = { 0 };
@@ -1186,6 +1213,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	enum btrfs_compression_type compression = BTRFS_COMPRESS_NONE;
 	unsigned int compression_level = 0;
 	LIST_HEAD(subvols);
+	struct device_arg *arg_device;
+	LIST_HEAD(arg_devices);
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1392,7 +1421,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
 
 	stripesize = sectorsize;
-	saved_optind = optind;
 	device_count = argc - optind;
 	if (device_count == 0)
 		usage(&mkfs_cmd, 1);
@@ -1515,6 +1543,13 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	for (i = 0; i < device_count; i++) {
 		file = argv[optind++];
 
+		arg_device = parse_device_arg(file, &arg_devices);
+		if (IS_ERR(arg_device)) {
+			ret = 1;
+			goto error;
+		}
+		file = arg_device->path;
+
 		if (source_dir && path_exists(file) == 0)
 			ret = 0;
 		else if (path_is_block_device(file) == 1)
@@ -1526,10 +1561,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			goto error;
 	}
 
-	optind = saved_optind;
-	device_count = argc - optind;
-
-	file = argv[optind++];
+	arg_device = list_first_entry(&arg_devices, struct device_arg, list);
+	file = arg_device->path;
 	ssd = device_get_rotational(file);
 	if (opt_zoned) {
 		if (!zone_size(file)) {
@@ -1725,10 +1758,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	for (i = saved_optind; i < saved_optind + device_count; i++) {
-		char *path;
+	list_for_each_entry(arg_device, &arg_devices, list) {
+		char *path = arg_device->path;
 
-		path = argv[i];
 		ret = test_minimum_size(path, min_dev_size);
 		if (ret < 0) {
 			error("failed to check size for %s: %m", path);
@@ -1793,17 +1825,18 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	opt_oflags = O_RDWR;
-	for (i = 0; i < device_count; i++) {
+	list_for_each_entry(arg_device, &arg_devices, list) {
 		if (opt_zoned &&
-		    zoned_model(argv[optind + i - 1]) == ZONED_HOST_MANAGED) {
+		    zoned_model(arg_device->path) == ZONED_HOST_MANAGED) {
 			opt_oflags |= O_DIRECT;
 			break;
 		}
 	}
 
 	/* Start threads */
-	for (i = 0; i < device_count; i++) {
-		prepare_ctx[i].file = argv[optind + i - 1];
+	i = 0;
+	list_for_each_entry(arg_device, &arg_devices, list) {
+		prepare_ctx[i].file = arg_device->path;
 		prepare_ctx[i].byte_count = byte_count;
 		prepare_ctx[i].dev_byte_count = byte_count;
 		ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
@@ -1814,6 +1847,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					prepare_ctx[i].file);
 			goto error;
 		}
+		i++;
 	}
 
 	/* Wait for threads */
@@ -1973,11 +2007,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			goto error;
 		}
 		if (bconf.verbose >= LOG_INFO) {
-			struct btrfs_device *device;
+			struct btrfs_device *tmp;
 
-			device = container_of(fs_info->fs_devices->devices.next,
-					struct btrfs_device, dev_list);
-			printf("adding device %s id %llu\n", file, device->devid);
+			tmp = container_of(fs_info->fs_devices->devices.next,
+					   struct btrfs_device, dev_list);
+			printf("adding device %s id %llu\n", file, tmp->devid);
 		}
 	}
 
@@ -2174,10 +2208,8 @@ out:
 	close_ret = close_ctree(root);
 
 	if (!close_ret) {
-		optind = saved_optind;
-		device_count = argc - optind;
-		while (device_count-- > 0) {
-			file = argv[optind++];
+		list_for_each_entry(arg_device, &arg_devices, list) {
+			file = arg_device->path;
 			if (path_is_block_device(file) == 1)
 				btrfs_register_one_device(file);
 		}
@@ -2209,6 +2241,14 @@ error:
 		free(head);
 	}
 
+	while (!list_empty(&arg_devices)) {
+		struct device_arg *head;
+
+		head = list_entry(arg_devices.next, struct device_arg, list);
+		list_del(&head->list);
+		free(head);
+	}
+
 	return !!ret;
 
 success:
-- 
2.49.0


