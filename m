Return-Path: <linux-btrfs+bounces-3338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F987DAF2
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 18:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5415282382
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601561BDCF;
	Sat, 16 Mar 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XtzH5N7X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aYeMi3TS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B918EA1;
	Sat, 16 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608598; cv=fail; b=lrc8u7tzfkljzry5PCdv/hI63WCWpSl1fTok79jsIP+P11lJqP4KdloZxBlDxzGHeJot2Aypvl7crBYk8725m3mrI5hF0YZ/w+SwXtMdvL6rJRAVo1WGtv/olJLH0JA0iyseDvT4NSkI739iBYy+klWzfelsrTVGrEooF96idjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608598; c=relaxed/simple;
	bh=Jyzxxvu4x+L33DCKH1baGWg8fTr3IOAqix9RfrIKW1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPLC2xTjOQ4m2FAYnVl1Rfp4GU1Oin3eNGan5uUuKXZRxcsN9AgacTkOzbZ21PFjtkurS9XU4pAF16xG63ENek82sHfed7j43gr7vwZU+eVYL9H35WgGhaS6JnhSD44smkUHbYTY0IzNZaEwPLqnxzB3KUezg8PS24zl68gQm3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XtzH5N7X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aYeMi3TS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42GCRMGd012051;
	Sat, 16 Mar 2024 17:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4nek190bEUSS6Asn71wMNw3Aoj1vnQ0v3H3ZpmIK6S8=;
 b=XtzH5N7XGQml10tgOTF/ifRTk/T0Z4Gpz3viXcJs9HIPIieAIfm4qYrXuJA7D+gDnu0D
 ZmxP5zKv6xt12EbnaPwMiQDJhe/PNfHxmXTnKyNSyRs0DAx+V74ggmQ7ZnzcM0sjIF9f
 dfZginIvK/tMuERkAS0H2bCqUDxUY9TCr/tLU/w+fwpqPshqMpgfekJVtHQRQxxtFCrt
 3shffB9OHmBrfKrTboKwmFeltBE8auGu4y5zVUxLSHE067KjT/6pxKhrH4YICSOJaMW2
 VGYmarjl8gSlXTVlNlvTovtAcZfdAmzuGSvDEiq7A96C509nJinl7BTE4mgEwakKQ58o 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu0h8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:03:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42GEWnX5024256;
	Sat, 16 Mar 2024 17:03:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v3h9s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+QzeQt0AYilIi/F+5aAzxr/qDifFWOGuoh3uzT92J3ovcv/byMJtOxgmh0TX4bo/Wdw7znGzzcWSrPB/VZD97lVZJUYfeIqrMyWhhHvkLaRnW2cWo7AM2RiNRfNuMhBnCefZbNytw0003Z4SbWcEv0XuqFlvs+sECs9SRcCXQ352Xexgw6NK4o8YeAX8DcmwlRJlwAGeRSnEBF01eUhF4yBCKm+AEnFqBLnknq5dqMSrz/+aJnObJ5FJrmOp9u4ymEyg+DW+/9A/LewBTva5Gflz31f+NkYH5yaoyuDLErURc4f94ZSIW4RDUbuCGOx4OgmTWjO8NHFtnNAsgeWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nek190bEUSS6Asn71wMNw3Aoj1vnQ0v3H3ZpmIK6S8=;
 b=bwV0sK/enulgGDi4b2F+IgEhasvyGcUhiEtPFtlM+dRuMcI304ZksmxuCrJejwAw+500skzJrsGal6cd1xXdJ+ganTZZo8rrxQ0hUxiG6j23eufZwgCF160OJaI+sn1H5oqHo9rRqyvycyMlYNaY6YIH/1ioyj9jDIWHkiVKySYRdJGSx+4iN1PYznS/RjJAdV41NnlWUnJ7moidQoqlJXAOshGPxoZxjSHmnfrOD/FjGqO37bOA/bvrTZRzlKc/HO0xm5sjjzGzDvN+agGQUZmuFY9GvGDKNaXXH+pfDh45HengYBG7BJfRp17UHgGiRp8tfYAFScH7Rx+1ZTKlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nek190bEUSS6Asn71wMNw3Aoj1vnQ0v3H3ZpmIK6S8=;
 b=aYeMi3TSKB5mFVX+/0viSly6Mtcs71o2zPNZBsviwHA8hljz/mcFH9Gz4+waqHPbU+J2fngqQgyYVMsVyF6MiX8gfKZPg/BwUJJlSsTlb8sVkM1set55AvkUnn7RIc2x7mK+4u1mdX1bRVtiy28T2s4M4ZcI8bMTG3foqOQLBmI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Sat, 16 Mar
 2024 17:03:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 17:03:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 1/2] shared: move btrfs clone device testcase to the shared group
Date: Sat, 16 Mar 2024 22:32:33 +0530
Message-ID: <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710599671.git.anand.jain@oracle.com>
References: <cover.1710599671.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 014f5732-4ab6-4bfc-00cc-08dc45daf0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sTmVp31IctECfWkLOeJw0H2o6IFzXfa91wgN4QUwcqMqCLsDOxdYwup7wjcrwAiijmNhfmf6F7N0W71zdKWk3beK4Uf4J1hWxXZ5LMyITYau51BKBuIUGjO83k9BET/TvOMDCusR300X8MPs7KL7+l2wWbzJkDGcVAa4TIgdwlwIlX2ConkStxER8OQj1UD0IXsoxXhmuy/o0y5/6yH/ZcGfmapHq5yxlnAZiachIwbPl9k9wUBi2Tq0963yUNns9jZNVArUwim5hawivATGIUeO8sV7A9XJ6f8xLcZCFi3mUspcPfuAqie5dYZhi6DODP93RORfsACaWBpCGgbwZA022duINlV7dnim8/dpeJdxvF0LG3oGhpgCC4m8RfVPTDL59SSb0Pgm9nsL+I6DeEvBQyowFJmzKUl/gJNvJvKFIUzGuD1yThjb9NVCyjZoyHJS+1DH2PyHGGUQMJh6nbUJVPtqpjINJKUvU+doWdH+xp1auMs9wG5H6rLpJmDsVtpEMp65rJTrSJ6kYZ1xBt9MglUgxi33meDrvaBl7kv2b26XlYCGgYDYexHH/RsoatRsXtptLBoFktJApZvRhEzFO+fU1WQErGS6L1bXL7+NXPAIGDRcSJ7BnClgGqC+HRdGWj5STEvx9qMVHdgENlVc49XHRQTG+ONDgOfqiBg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gqC1RoVC96pRZyDvlNg9dr0anmF9qhoZbAAPA8Eeq68sEkcLXqJr3zKGXSFQ?=
 =?us-ascii?Q?u+MfukTa8g6szBzp28hlG/ZIrX2ma2rjbpxVtc2LqSZMVMwgEW5XTICRETU1?=
 =?us-ascii?Q?xRlimV5tRKtGUc+BxZRpDFN3p+7K8jKlV5nVwkpOGccCDBjZLC8Yxd8fid3Q?=
 =?us-ascii?Q?W0hjpkO8x+fpol+rYuXpVsKg/R27t+eSjoQUt2rzrt5SnSvZ62g8cIN/cPVA?=
 =?us-ascii?Q?/++I/RZqt9YytJrxVEIWFVI27xxq1s0xSTvMbTd3gVpOLP1EyNjs0b4y2pr3?=
 =?us-ascii?Q?wJku/KLdQwjDkkHOUIdmVGq02kFBxAXREU2D/a8ME4WXN1szWlXkJOKo0580?=
 =?us-ascii?Q?ho/w4JBQBdXG/kGN1QNr9Vu8Al6X2yP+UARH47ey/QZSVdnYNabGS5o8OFTA?=
 =?us-ascii?Q?HtozTL+nXFv17hFMGzOuzqklG62pn+Oj+bgyWGbr1tD5Sbkb5rZZ6kJBlQ0J?=
 =?us-ascii?Q?6pILs22RkMtlNYwwHptnuiy3s7q4P3aa6TnSRq/QScbE7LMW+e+UbeqBNw+c?=
 =?us-ascii?Q?njOpdLemCrYeAc+wyLXXgrLb3RMy23lUGToW4utMTV9VzwoimEmtO8/rsBvG?=
 =?us-ascii?Q?v37e5suS1iH46Zr7Rr5oYJz3mFpEWtS/X4BliM4wyBLlpkdE6d5a/3BYxedF?=
 =?us-ascii?Q?2YfDB856VZDP3l6DbBEzZWhPHVsJAA3FBShjR7UuSLJRAusZN7U7j6nTiZCN?=
 =?us-ascii?Q?97FpwgZeTkf2iNiKwa2tPPM3odKPNib45Gcd43zA9pgWXPYzE1ey6ofvwcTw?=
 =?us-ascii?Q?EmzQcqgJpsAL/yKjjIMJmpCTlRddZiIGF2kpTg8wXfWAo5L6cxwxIMkEvFUt?=
 =?us-ascii?Q?MxTvMAB2vXqpMDAQpqLX1357ehYP80jdxUEh1ZUTm5Iy60KfQYcimfHd0Gr9?=
 =?us-ascii?Q?mzBkXDOu0PkqkePugDZLdKrdJBkPHCNQ8LqUKsod5yh+0Mi5LU7St8qc+wd9?=
 =?us-ascii?Q?yE0maRmbNrJWlBgvES3552gTrLBMVeAvt9e4czBHWxEDJhH6CH6ZL4ydFpm8?=
 =?us-ascii?Q?0D8TmFk0l2xTP/dprFT9PH7TvI4CiwQ/ve89XElItL46jSyUWMbd22EOyiSO?=
 =?us-ascii?Q?5aNM5TKXcjUpdrBaWkCkmxqfh9N/tWJ4qeUjofRDdT7JaU8ckP8JAV0vCE5v?=
 =?us-ascii?Q?3EJAVlrFifRHt6cLM7yrs6krq7GvWNGi2/Vx+tkVBgsDh1g8EoN6w0pE6qIE?=
 =?us-ascii?Q?YDV1/b+PRTocI/FXCySqiFnllvZKJqhMH1aY0DPhX/qIRCKEhBCSNfkybn13?=
 =?us-ascii?Q?GtFxvPNFnC5bzTCb7N319C9WRUEsv/IQFnFy4jXfukX1eMahYYfjNNCsrEqz?=
 =?us-ascii?Q?iyCGsfXXRUUSvhmMCEPk89bnr6Mr2N3VbH0lxzXq97xjmP3jdqR4NSQ8XDf8?=
 =?us-ascii?Q?RyWWllcRB3JN5ZtAWa4lf5hT7WKjz26JQWLCbzmogw93vCOGwXFbRP5hS/H1?=
 =?us-ascii?Q?Qcx24JUY468VXkTrPRfodMcZbNIvDA7CRTPQNbXGluprkq/aaCIxwd/u/H0O?=
 =?us-ascii?Q?oGjHH+DPCE85tjpYEVORNQgWA1MwwIPHMoT4ABlMAHWkvulfbYm8FYuRW03G?=
 =?us-ascii?Q?ee3ncjqyvKmRps2gDmBMq2rv1fyz3wxr0xMNDcb3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ThRI1tVtSO0/YCE72bE8ISB5rM2FJnfalQxfD+G05gleVIlXTwp7HMfqQDHjZTQncjCUXsW2HTnQ3S/UMS1vdbTa8/1uhe4WPzmlINk8Bcrwczco661sACPwzE+fqtkGFp5uyfmexkt8Ara0CB4icAnHfh8G4ZLmRNZ6r3d/sTsyNdH2y1AxQld07EdTS20MLaM7K5HrEi32BAicmM7Lv8jhAtZ+zO0MFF3W2TY0Urcj7PdIIgGeeeCOxacOu4um/RcM69DRXJxh7uf5h1mWIxfQIc1O5pYTNWr7ZfbEK3h7E+h6HcaoMuyMFYWmOAvwdsLmFydWQznYFJSExCfBB280KLSZv/QVxztu1aFoKabfgYfpw91Qiw6V1FJKPyc4tXjHCRZYUTf/zvqgCP7bc2HQU3DDf8rn7ouCXOt5tMp5RXK2SCPh1blO9gJuemHFwzGoLIwLXARU9TTOLYda9dnbsePqgufS8ssz1ixTGsxSVmuaVA6JCXZGxl6XVykKKlM4qGdXr3KtISUgRMTQnhO2HVkphE4MSeFox4PRK755iRCp6aAN8XZBxlMqPcTkxAQSzQONE1yY13YG6L6BZxQO+OA90RZmGTbFdZr0KXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014f5732-4ab6-4bfc-00cc-08dc45daf0bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 17:03:02.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMIdQuLZvGyrTv4EdfrSLOLgEM3VZF2KyMc1b3iAA01gbhHgDnOr1anQHrxskDqWWmlauiQiTdlPA0ZJ2Qurmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-16_14,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160134
X-Proofpoint-GUID: glr8w18twrhOIRgYdwWIrjUmWNR_xg47
X-Proofpoint-ORIG-GUID: glr8w18twrhOIRgYdwWIrjUmWNR_xg47

Given that ext4 also allows mounting of a cloned filesystem, the btrfs
test case btrfs/312, which assesses the functionality of cloned filesystem
support, can be refactored to be under the shared group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
Move to shared testcase instead of generic.
Add _require_block_device $TEST_DEV.
Add _require_duplicated_fsid.

 common/rc            | 14 +++++++
 tests/btrfs/312      | 78 --------------------------------------
 tests/btrfs/312.out  | 19 ----------
 tests/shared/001     | 89 ++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/001.out |  4 ++
 5 files changed, 107 insertions(+), 97 deletions(-)
 delete mode 100755 tests/btrfs/312
 delete mode 100644 tests/btrfs/312.out
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

diff --git a/common/rc b/common/rc
index 36cad89cfc5d..2638dfb8e9b3 100644
--- a/common/rc
+++ b/common/rc
@@ -5408,6 +5408,20 @@ _random_file() {
 	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
 }
 
+_require_duplicate_fsid()
+{
+	case "$FSTYP" in
+	"btrfs")
+		_require_btrfs_fs_feature temp_fsid
+		;;
+	"ext4")
+		;;
+	*)
+		_notrun "$FSTYP cannot support mounting with duplicate fsid"
+		;;
+	esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/btrfs/312 b/tests/btrfs/312
deleted file mode 100755
index eedcf11a2308..000000000000
--- a/tests/btrfs/312
+++ /dev/null
@@ -1,78 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2024 Oracle.  All Rights Reserved.
-#
-# FS QA Test 312
-#
-# On a clone a device check to see if tempfsid is activated.
-#
-. ./common/preamble
-_begin_fstest auto quick clone tempfsid
-
-_cleanup()
-{
-	cd /
-	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
-	rm -r -f $tmp.*
-	rm -r -f $mnt1
-}
-
-. ./common/filter.btrfs
-. ./common/reflink
-
-_supported_fs btrfs
-_require_scratch_dev_pool 2
-_scratch_dev_pool_get 2
-_require_btrfs_fs_feature temp_fsid
-
-mnt1=$TEST_DIR/$seq/mnt1
-mkdir -p $mnt1
-
-create_cloned_devices()
-{
-	local dev1=$1
-	local dev2=$2
-
-	echo -n Creating cloned device...
-	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
-
-	_mount $dev1 $SCRATCH_MNT
-
-	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
-								_filter_xfs_io
-	$UMOUNT_PROG $SCRATCH_MNT
-	# device dump of $dev1 to $dev2
-	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
-							_fail "dd failed: $?"
-	echo done
-}
-
-mount_cloned_device()
-{
-	echo ---- $FUNCNAME ----
-	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
-
-	echo Mounting original device
-	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
-	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
-								_filter_xfs_io
-	check_fsid ${SCRATCH_DEV_NAME[0]}
-
-	echo Mounting cloned device
-	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
-				_fail "mount failed, tempfsid didn't work"
-
-	echo cp reflink must fail
-	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
-						_filter_testdir_and_scratch
-
-	check_fsid ${SCRATCH_DEV_NAME[1]}
-}
-
-mount_cloned_device
-
-_scratch_dev_pool_put
-
-# success, all done
-status=0
-exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
deleted file mode 100644
index b7de6ce3cc6e..000000000000
--- a/tests/btrfs/312.out
+++ /dev/null
@@ -1,19 +0,0 @@
-QA output created by 312
----- mount_cloned_device ----
-Creating cloned device...wrote 9000/9000 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-done
-Mounting original device
-wrote 9000/9000 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-On disk fsid:		FSID
-Metadata uuid:		FSID
-Temp fsid:		FSID
-Tempfsid status:	0
-Mounting cloned device
-cp reflink must fail
-cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-On disk fsid:		FSID
-Metadata uuid:		FSID
-Temp fsid:		TEMPFSID
-Tempfsid status:	1
diff --git a/tests/shared/001 b/tests/shared/001
new file mode 100755
index 000000000000..3f2b85a41099
--- /dev/null
+++ b/tests/shared/001
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 001
+#
+# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
+# operation between these two mounts fails.
+#
+. ./common/preamble
+_begin_fstest auto quick clone volume tempfsid
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+
+	$UMOUNT_PROG $mnt2 &> /dev/null
+	rm -r -f $mnt2
+	_destroy_loop_device $loop_dev2 &> /dev/null
+	rm -r -f $loop_file2
+
+	$UMOUNT_PROG $mnt1 &> /dev/null
+	rm -r -f $mnt1
+	_destroy_loop_device $loop_dev1 &> /dev/null
+	rm -r -f $loop_file1
+}
+
+. ./common/filter
+. ./common/reflink
+
+# Modify as appropriate.
+_supported_fs btrfs ext4
+_require_duplicate_fsid
+_require_cp_reflink
+_require_test
+_require_block_device $TEST_DEV
+_require_loop
+
+[[ $FSTYP == "btrfs" ]] && _require_btrfs_fs_feature temp_fsid
+
+clone_filesystem()
+{
+	local dev1=$1
+	local dev2=$2
+
+	_mkfs_dev $dev1
+
+	_mount $dev1 $mnt1
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
+	$UMOUNT_PROG $mnt1
+
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
+}
+
+mnt1=$TEST_DIR/$seq/mnt1
+rm -r -f $mnt1
+mkdir -p $mnt1
+
+mnt2=$TEST_DIR/$seq/mnt2
+rm -r -f $mnt2
+mkdir -p $mnt2
+
+loop_file1="$TEST_DIR/$seq/image1"
+rm -r -f $loop_file1
+truncate -s 300m "$loop_file1"
+loop_dev1=$(_create_loop_device "$loop_file1")
+
+loop_file2="$TEST_DIR/$seq/image2"
+rm -r -f $loop_file2
+truncate -s 300m "$loop_file2"
+loop_dev2=$(_create_loop_device "$loop_file2")
+
+clone_filesystem ${loop_dev1} ${loop_dev2}
+
+# Mounting original device
+_mount $loop_dev1 $mnt1
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
+
+# Mounting cloned device
+_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
+
+# cp reflink across two different filesystems must fail
+_cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
+
+# success, all done
+status=0
+exit
diff --git a/tests/shared/001.out b/tests/shared/001.out
new file mode 100644
index 000000000000..56b697ca3972
--- /dev/null
+++ b/tests/shared/001.out
@@ -0,0 +1,4 @@
+QA output created by 001
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp: failed to clone 'TEST_DIR/001/mnt2/bar' from 'TEST_DIR/001/mnt1/foo': Invalid cross-device link
-- 
2.39.3


