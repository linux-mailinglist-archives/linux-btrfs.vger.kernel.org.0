Return-Path: <linux-btrfs+bounces-9699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856CF9CE495
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0E280ED6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053B1D5146;
	Fri, 15 Nov 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSRDW/Ga";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xP1IMgi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653C1D432D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682524; cv=fail; b=jjLtWTjlpab7D8JkkWV4o54kShHb+d7wcwMHKgC6SEVZODixP/WefCWYDLBSfl6wDVjKFuvhMlJoClym+HbFHVJQNE5SMkndu7UUidDdVLF8GVgtYEwhEGUblaO323zpdjf1P7I13pyR27mZoUe1zONwVDpK3b9cZfWfrCvanvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682524; c=relaxed/simple;
	bh=wy2e3PSiO8u87DwjiL1m/EVMP27q8vdlCLaFNJuKSCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8RBz+wiqd3XCIPH92qPtVkUCXoSlSkxAYGA5F3YUXaC4OsnC0cYYlS4Tjf59AcGOkk8zo0rkQGYy1wtvnv95o1gIEc0GCxGdsVgCqeu3Q2lYgugBQEpYeRl/Mdcnw+kjRSPipSaJH3SOg3HELGO2pz3bXtCsfp/Jbj3D1w2IrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VSRDW/Ga; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xP1IMgi5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDD9r4019222;
	Fri, 15 Nov 2024 14:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oEvYARKFBI7o/E7KyRTlz25joxSxHOSs/6gp0OtR5r8=; b=
	VSRDW/GaLcQXjcgyKMj8vMozJYhAGr+imXedjPPxBi4apMxwzh5GyixNDmnIytQ+
	L2Egwj1wfp9RhbD5ai2yrYp/u8vlc7KyQ9qexuCP2bxMFbwibhuwbBLKaY/omjBi
	NGFEYKjCEc6XdMgxa7OobeQdK+Qaw4RxMXzvxLyGiqLydyE42RjJfuzZbLlWM471
	AlE9+8rXxOipue7a6d2EUSFyxIt0SfyULduh/aaxk5uytQFkMxpm14eDUipnvfE/
	gqDiAnYmttIPUzpobkrjCWouk+U4w+SMb4VzA80ay0efWl1d9MNrm+RYBtCiLJ0V
	ZZHnOUvPvlzvmmXPG/hlVA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2bhc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDGj9025853;
	Fri, 15 Nov 2024 14:55:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ca3x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfjIdioqa0XIUwVWnpofMkaFtTWleuXj8TCcym3ObqtwhZdo3Om1K0cWIjLan6MwKgPKwdslqKyIm9zOYf901Q13nZHyUK886GCAFSGZzD2M1oRv/SXN48RxYTFvESTUcZnY4Dw8Av1kpL3OQ96xl+63KKzAu/O1GX2SwA8iB198v4Z5/V7JmSN3G4bHT4Z98qDZpSxG8aHB7XpkG0QV440XdxUgvZ2vlAReZMwyIAl9nmeFkjZ0FCFRpFp04Au9kxp5ql8WL1OdzZcdDo3pwwQ2TC3RzW8TBgY2DvnRNN52PmV5Vl2qteF6SVX3brb1/8As4qzBMeXZx00AkMgKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEvYARKFBI7o/E7KyRTlz25joxSxHOSs/6gp0OtR5r8=;
 b=lPhneObeTzaicl3QK+WJurI/ivZybtqVm+p+s5ZEBL3fK4ezxBcDcLgu01fd3IxqrcGUX8CcdoG26aEj8ni9ev5g2F2Eh8grbcMFGNGhgiJsiQUWOtDWj3WDEJWzedi1BdrSKWlxmppKG0S2ePo1TUq5IYPlyIBrkPZ9dDzSadZjv9nUT4lX9BnhomkoKkBmPi9LtaY1rIxAV/SI2MT+uL3sO/9HDBP0GLeVoAW5tRcYxvnrdCmmwLs3/uKEd458gJrw+5Y6RFiM5j/i9Ju+I7U421Y292cbIMZ0xX0GnrRJtbagLSTkCfkBA5zmJyPvWlWYsiYuUTyUZW9eINUS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEvYARKFBI7o/E7KyRTlz25joxSxHOSs/6gp0OtR5r8=;
 b=xP1IMgi5ELh1VDxw8jcKVdbI3DnwrB0jelUa/1mCpWlI6DUYC/FTXzGU7IV3aSxb44lN+z+TSCI079jp/ahAiOmrgXBJiwwESgOg0mCLVNThzTtC/iZlG/tz8Od4kR/Uzv32uO/z7G+JlxAj3GaMIRORzODnMxa91Zj8hJgCnes=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:55:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:55:09 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 08/10] btrfs: fix CONFIG_BTRFS_EXPERIMENTAL migration
Date: Fri, 15 Nov 2024 22:54:08 +0800
Message-ID: <4abbb1e359944c0b2b65b43fc0f8fa0f95b14753.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 314d66e7-ac6e-4def-f543-08dd05857fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkAnmOwvrDiYda0/bFxPV5TmgGDpyq10hIg6b/5BQ2QyQyWm+woJ4k0Twg3J?=
 =?us-ascii?Q?hqqvS0x2sm101ImctNMJNM322pCYzA0yREEjkFOAOTlHiBowQK1WBZ1mEMFW?=
 =?us-ascii?Q?yV+XsJLDALVHWe8+QzXvTT5xCClOGa1Xnq/S0Bk7sY4rYwootA5Qkn+EXyTF?=
 =?us-ascii?Q?5aT/SdaxS+2xbKySTGDj/Z1nUiEiNN84NS1wEpudOgyzwRMc+cMMdqwg/wxm?=
 =?us-ascii?Q?wO18g6T2HbS19/o2WQaQHwlWDeM6ijpSHObbT+TDQH3uFddXR+/rw+kOlM0v?=
 =?us-ascii?Q?uD+4jrNNGOSZvqzSaE2qJFza30GPt09hwLlGY2yQ778VYKDHg+3xhE1SVjdJ?=
 =?us-ascii?Q?PQ2mvPH5pzMWlUVPgUv9uJs2YUuWdZytfOIIKXS4j/Bm+pL/nM9yywvZgJB6?=
 =?us-ascii?Q?6AJ69iC2d4cbCKbR7eetXEKlLiJN78/1qCVtR/wqaq2imxcqSYfmB+DTFkun?=
 =?us-ascii?Q?8tqDOufw21glMbu2AXdk12DA3nug0oHfqn4/ZkElNfkrBdbH5TkUNp5egS7P?=
 =?us-ascii?Q?3bG5voHibjWSuIJWWHi761Ruxc9lChMo5YElYz08o25oktKu366QJSgYPSFF?=
 =?us-ascii?Q?uT+FKkgyaVzbEAEF04u9aSP5Fxlb7WAXb3U9GsNgyYQ31K9GenAJgUb0HJe3?=
 =?us-ascii?Q?D3gfSXBFVmElkVRf4caaksmbwf5oOyZlaigS3bxXTV4QlrNJ3hGXMAvxmeKj?=
 =?us-ascii?Q?JtQ7IPtdg1aFLeRhET7dHk+O8pAMmxJTMU0/+Q2uMmA58irCgDJpcFM2Qo02?=
 =?us-ascii?Q?YA5eASEPiVWayfqj1+PCbiwiyRv9IM+j3RG9XQ0lYSwuC4Spb0oOrV+mG7bR?=
 =?us-ascii?Q?pMOGNmLQbm3sANBkzHDN45uwiaLsmqyBMVJ7gHv2o2j1aKfrzaB+K4BgYGMp?=
 =?us-ascii?Q?7exXMTMKI9TC6T4s4cMjGsbdd7nLrMxS34BTTGegCYW7uwO+MBwxI+lsgzyn?=
 =?us-ascii?Q?14RrNmF8MTP3+UrsSpWoqh1Lk4kL2o90r7gA1mwY8yXVj3DyUe2HWqvLqzh2?=
 =?us-ascii?Q?Vh/TLkPd1Yw4ZNnlmF7iO32KjKMzS5xkF3NT8xtQ+2tn/CaSyFEvb24gDOdc?=
 =?us-ascii?Q?JldQTIvwtkZNSCqeBb5NY5kykdYAK6BcwCndUEz7f3PioNQGmS49pDq+ommH?=
 =?us-ascii?Q?Ib7/fFMpqihqDoFkqRa3DM19ARV0HyJmocJHOB8yyQda91Plhh6hJI19tmCG?=
 =?us-ascii?Q?RqFjxNAZ68IEfC/XFama4vXwFb4HIBfDX0boZvIHsIIH+gt4nJsn+Mt4H5tX?=
 =?us-ascii?Q?WiQsEpOoahOwh4/5ov2Gdlx8RbVvTHWN9zs7as2/a9mmzvwKnn6BZbvl4Mj+?=
 =?us-ascii?Q?HH8lomUTMrK+8iouZR66IjwI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3R32IqAg544ZqRhOR/k4rapM2wqkjSMxHksgcM+cAVFfVLTsDOjSSknMfCse?=
 =?us-ascii?Q?yXpi9RIpn1Ey6irvRTONd1CG2M8sW4sObaeKg9j85SYeJl2b8Gi6Z2rECXdI?=
 =?us-ascii?Q?Id89A2ygSMb7IFhIQhjAamXf1dQuZOwUqT9manJtB9nDPys8pzAwxqAjBXAb?=
 =?us-ascii?Q?muHDWOVvCiu23dBogob3RCCb8x9Krqj5ChO52DHZbeNaNHVKO3fQ4L5fCEG+?=
 =?us-ascii?Q?CPkkg9evUrFjLMXMeFH+dGmec+/tS7nb4cgS1tC/ZbFpR9hG4e60y/pGYkcc?=
 =?us-ascii?Q?/OYxAOtfVAa/oZosQarSZGo5fLX3sgPQ618aLhQip2xjli8G0bijQEXoTrGi?=
 =?us-ascii?Q?fpkGOBuJctIwLJkyZYU8vcbno6+EBVWmV5H66VzPXQhAOVvItr/ggWfvRkyr?=
 =?us-ascii?Q?A268HuZE+2mBQN8e0KyuZIGY/zxvSIf6GuR4fTvpJVpNd1fIf1j5atv7sRJ0?=
 =?us-ascii?Q?eQz9cu2kw1k8V6Vv0C0EanmL+Tys5vp56uQ5gwLUau2AHh1GpwczwQRgQxNV?=
 =?us-ascii?Q?vWRt3sPZ3dm3Tbu1NKAzOlkZjuJ0HAKx99JBNBTrC3DZdOf7GV2RDqZXhhgV?=
 =?us-ascii?Q?F5UiV5R7OMKJZG48orEW1JX4xCCkAyTt68ZZPKXwf6FEly5N/rpUVOMzS/8n?=
 =?us-ascii?Q?u8+QR4dnAxjwaUFxJKLxS9L0TosQ9hDvtKO2Cc1oRXlLvC65mNCuJC8UpZQn?=
 =?us-ascii?Q?GbKaSh7tDKbRnXadhWxQTrl0HYNu7R2wZTG4J2Sd/X1d7Lhui/WSSXgLIydQ?=
 =?us-ascii?Q?OBnGt68Rl4/P/Q3OJpCW0e1HZ2yCzhhr6JLhmub+01vYvh89RAL8gkKZtWk4?=
 =?us-ascii?Q?aRS8i6EDyQsqekN3ZHgpvE8qHbgDtv1l0Zz+4tFPOCZL+tyMjZbIE57g4MFJ?=
 =?us-ascii?Q?cNbTBuOegP3N3z5DxEULTt+Thh2Q7U16XGRpraFB9I1Fbm4KevqzbXGJ9FBi?=
 =?us-ascii?Q?tCX5E2a0//6Tb8gBQIhFfsII2SsgeNla58somQV+dIUFJbi72OJZB43wxiQl?=
 =?us-ascii?Q?DGbFZy6UG9jamUvFcE025LU6RbCziC8ucGm0csnSoksMPuPijr/+Um0qnisC?=
 =?us-ascii?Q?PYcr2JngMsLMfqvtETrvFEttoeGY+nuUYXT/3KTRZVztE3/oImyolObUPsDQ?=
 =?us-ascii?Q?A4lUa/1oHTeFywsPtiPbIFKtAuL0pAN3XNplPT9GB6/TE0n/oJGBVsN7BzF8?=
 =?us-ascii?Q?JGEreIMzZidaqi64HthAk3QH4s/U8xFIvLoILGseTaGFxnbIk3c0uptW64lC?=
 =?us-ascii?Q?I5LOlxBPT1H2Gd3m1gdZe+jUorV3dk47wCfZUXIXA4/tOWc31Z+05DNGZhcY?=
 =?us-ascii?Q?seZppKECOtCdhB+zoM4nvIxHhmSVpiwBruQdLKqQW21LaodEgHMbdAVl43lh?=
 =?us-ascii?Q?UVSM8s8ZwOZDJr9TjVF7Ql+Kyy+2IIHBJyqRo4rSIAdLY3uDUhmgwS7LpDiD?=
 =?us-ascii?Q?VpLNLkRK0b3PNfyY8xgY/L8zfdtu3Rt+wtgxwzcdJukddJoec5ZyKmHuxr9t?=
 =?us-ascii?Q?jCHLKCRncaRWLMNER2OmB/f2ZO9pQXkFy4r1SJ90y6o3FOSAyB5obIpIYgTN?=
 =?us-ascii?Q?mC0SbxJIQv8a0QlLjq0Bv0eRtX27xwgCfNanzgDQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yRJpn5cKW8vu+JDxxJQh3SnB/bKoikjctNL4fscg0tCdnI6j0MaUkA0JKUFIkwhD3TlqugMLMmiKlB4rmXaGrBlD+d0OEBif/Fw5v9MkYxloMveFG7UU6n2KkS46AByVMwGrSIt+Qmx23YhkSOAFWeN2+FwH91no9vIxo9nR3E4XvuRI/TK3Z9wKhcohBAepGvDmrHxbLuHQ9ZQafrtiyRDGEeBd4DXjq6vv8O81B+nXl0q36t4dX40wTxrXSAjHRcAkA2Y/cvGesLuzmefaz1NTRxSgFs0DHAUlxE31FPnu10SYZsY9tLH5P7FezIbQay+UcBJxZx6s/2PK0HeFISMINzaOYthwswB9IyykOHPE9g4UR9Kks324NKn6MPN2P0RrTlpBD9o/6KXUZjxX/u9r4gVGmgrpo0JXV+aL9R8arx2BLhhdnimA1z7mjzMj8A7HGxR1Mu40sYVEMshblNk/7WZ+jypSQZB/QAmTPLsuPIbcTh2tCMAmZLzexSKzhgbLZX6RHpixgZNITDodgCnj6tLwrD8RsaNjkzu82lb5CtvBtEhoJKOcLxhyRexNZQ6l3Az6rsTLNTJ2nfpDA0OMiJnZhpW7rUkLHCFsfCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314d66e7-ac6e-4def-f543-08dd05857fb2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:55:09.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/k50b4A5P1QirFpBSNj2lDeaHGtZB4GQFz1VF0BDeEDlPyZGvcU4UvgzIB8OHQ0faCn+zbz/+L+EXjij/v5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: a5O3PeoZOuPERrQRZ3kZeFtYe8PCoL4a
X-Proofpoint-GUID: a5O3PeoZOuPERrQRZ3kZeFtYe8PCoL4a

Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
CONFIG_BTRFS_DEBUG") migrated some features from CONFIG_BTRFS_DEBUG to
CONFIG_BTRFS_EXPERIMENTAL. We could also move the corresponding sysfs
entries for these features, as there is no point in retaining the sysfs
interfaces once the feature is moved.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 96d0480d1b9e..50b8b8847dd4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 /* Remove once support for raid stripe tree is feature complete. */
@@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
-- 
2.46.1


