Return-Path: <linux-btrfs+bounces-3384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A346687F5E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DBE282524
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68B7BAEC;
	Tue, 19 Mar 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLDjh+KR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Itrq8wzm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0752F26
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710817157; cv=fail; b=GQAc9LX8mUwoAVJjjhYwp4gTGoQRWxBL3Ykp6x/0MmOBjB8gSA4SandK/Sc7AT1y0sfMQWV3BcjeLsmudukdTYigIuAc+mAD7DzT4qKOwVtZWmDL4nMtn+LqYx5Dwj02/o3KuW0MrPadotmLPNYTZaVynmypibu0CN8u+U0WIdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710817157; c=relaxed/simple;
	bh=mXq755NrhqRnRReK2iT4NqNdYQWWu0FQCJk8w4xdqyI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f6mRkGGBXoVTU5G/gEwrFgcwUB+wRLdk7PP1GKAsrrb+nma4ZBMrOkCW/QsUD+MWiPJ3DVRgjwmX+4WRsRhrmdUmfD/XoNcrfcCN8pC3A46sKTLHpSjUtoRPEpNOXaHWfmmeGmpiSToTaciHiC8+581nvUuYoSfAHvvILhJhks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLDjh+KR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Itrq8wzm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J1E3cU004355;
	Tue, 19 Mar 2024 02:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Qv77XcgkIdYwUBbHdb+uta8cpgSGRFCIa7nwaBSVVvc=;
 b=dLDjh+KR+Y1qR30vb5Q0H8uHcMPYItjXzvRCoAnoCDZFx4gaZgXcdQRBgWGUbRtMTMdH
 0hvFmtlcyVILnNvQTmNErKpOJPl306+m4jqYcFgW2EvgQBNGUtL0vU6BOBrFvg1A/nUe
 KfcE1ZYi8ZI+qOseHQgZvSTqQGdtOnN/NZLeujwbe/ujDlTXw4Zj41P4yj4mPu6iQ+4j
 oj8Toj5FiaAtvlO+XQkgO4i2A3Rb3o5AG0EbbJzpGOQaXWeTCUCQJdPO2OwDW232VaZd
 v8bv85piwnFnsuJnasDk4+3CHz2uNLYwsOAbjDOGE+t3j201VCXLR3OT/UqZhQb15RAG Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272vdu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 02:59:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42J0R0HV003681;
	Tue, 19 Mar 2024 02:59:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5mjmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 02:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNd68dsoF+0p5fLPa1nwaXpxbtaooNq/fCEWW76ib51GBLDVbSfEU3rHtVXmY1QPhtOuwyAx8w+OSR0NVovCd3YwZlBZzgVuKfyR7GeMdg0a+akwCWnujpBc7o7f3b0QQRiNkddbbS13rtvPZfBp9TRLGr7/LUB8eZc40Hydh5rNB6ztgLKo2dP/cxkO0zCVp1MWEdJ30mTNDoeDc8MXhuHxFwwI1qOy/NL37UDuEDDudtt1js3n0AF0myOVEpfwrbtQPf78es0I8FHehkQAsubz1ZawGVbOBxojjBEjQ+YZ0SaLKLTE1XtaApHJXFw29YXPm1tJR2oJZEy+MzWg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv77XcgkIdYwUBbHdb+uta8cpgSGRFCIa7nwaBSVVvc=;
 b=cdhho9g+UvgWTa2QMOsVhmqxVykah3LM4/eESI3lv+BcuWYdl5wL2n92CIUKRt7SmJlpyI0mjDwCmUWT4iUcr6/ClAH7Eotv53G0iXuQ77KL/1XqAX5Kpq6bU6IE2h8j6RRyR4XjPCxjNieLefRdWB/UwtOU540U+3lauiZWOfPI8HG/scVw7Ay+8qf5HBcHxN1YeNUCcKzhZFLFKi9jIyrUHHR94DOqdzJR42BZO4HDev+PH/dk/z5fdF/WOokeq1EU486mEWj3GF9PFb1HkWXJxJWxERHRn9mbiNq1/OZ+IFH7cPA5cAEKWRWsVbA58n78nraAzy2/4/gQ9H2Hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv77XcgkIdYwUBbHdb+uta8cpgSGRFCIa7nwaBSVVvc=;
 b=Itrq8wzmtpp9Lb4hWXv8qIxwIiphPNRXMVtbFXBGFGTGMfZx/LpE2l9cnqMzFYIBXryJm4GxJvzXa723jCfNhEoA8jJJgfyaoU0IF3c57+KIWq2q2zPnoH2Wzs7CdM8+CdN63MCVBb/oaVultFLinmfi8WqaRlOxKUKm/97GHhc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 02:59:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 02:59:07 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>,
        Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: return accurate error code on open failure
Date: Tue, 19 Mar 2024 08:28:18 +0530
Message-ID: <9513db9f506a07101dc17b0959f7855234c50035.1710816565.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F7XPMqWdOkgAKHCo4Bp4rCgLy+0FD0rOUGgz4O9Kuz9Uj4ReMe0pP0CEynJyFYS0NQ6DvRPzwWtjz1zyIkWAI0aV49+J16WDepQ6YOesiYBhLqSsbN9c6gvJJt/DqrJ87cJsGDw3hGjbGPD6Dnaf3kJm2jxxilpkilDnMprvRiPmRlAcRKqcAuH4/+vKaLkaiK+jEqmjoz9Ggdsbxp55/dWxJnaT9aiEJRckli9GK56b3lcY6wRKT+pJ4SilFL1MQ1C6XvCVOMJ3i8ZkrQu+DoZt2vr+mGAnOEBQyWAbRgje6YWu8Dd9pJdUi1voLUmFmwvyhqlm1KclE1C2WneL9zb+pYvF4aiIPv1bifAfZinKBFsRl8kME3kcp+RZtcj9R83j1IACFA23C4LzT4ngrs/nRgdaES9OUwrDHypDN2rNpdbD/IiY9IWX5tGp8PmfXXMz/7UYpAmlzwTaSLsxnRmz60Y94WlMPJ1rndBCMvdTbyUZuWnIeekfwKjGUCqvJ1k6MFbFOCSAAHBmnrakm7W3srmgjjerX0TPQonG5Qtzdgh1u8zwFEEdH4KaJDCIVP7+/ryv1ZxNEdGESNrrCpnTlZzfVpwIR/Vr+wRUg3Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BNvoByapKSAvPtbq+F8F0jYRAf62P5y8v/m5pcV6VII4z0OpArB+kPtaz17/?=
 =?us-ascii?Q?FaAbsqgBLIDXwJO2dL6dkPOiomV7rVBFUfwp1foBFUz/X4FW980V6aOlAzzG?=
 =?us-ascii?Q?+hsyIKA4LtW/b3vCSk1xB96ILQy/bkwo99DWzjmjzC96fCNPXzC7NxXQCOPh?=
 =?us-ascii?Q?2IHFJUhB5YZyzbGuWon2lUIuKYQw5agy7HjPYaUPgzjgNxaoNlOcyQX2s4WY?=
 =?us-ascii?Q?uyHTldtt8Q6LL2rM21sJrqD+Xaj5PYSqPms7iivvMz5H58V1himVVXXHzyCt?=
 =?us-ascii?Q?GjQpvhpL74Ya39BToX19k4n3biNTRu1IwYrqqeun9NgojjzOHAbT8eI7C/1M?=
 =?us-ascii?Q?RRYWYa+gDlVOn4D1s/VILNPCcKFf+7CRnRuX17J1CbZANpuI0poAT4zpYwIk?=
 =?us-ascii?Q?8jJNMi8ERgL9rcyXzqisC5g731whZ3w4KcXurVNKh2Z3SrEggrowbhcZZb8X?=
 =?us-ascii?Q?JpWwasZOdcelepNXEtgyIvbrX68sDXgTypa2fFGg8oS8Wu6KXFLMzMbXSX1I?=
 =?us-ascii?Q?n3SYpeJdE6q+uyTWA6zERZEx+GsJ2bdjozfdDa5rrGxlX7VtBPRwtHM7vXZn?=
 =?us-ascii?Q?QmmV5fnu5LCt4U8qNJsfbPKfDjWQFAGb3gWRw+NA/xEBw5kPgg1HfhOFPB8W?=
 =?us-ascii?Q?djhDLTpPifvHj6dM/P/2NunZY9pUiIzyNXPDi8dNTvi4SMqnGAtyXmFRab2R?=
 =?us-ascii?Q?09w+W03wW2FLAHHjwM9f4Oyk2g9RN/N397rX+NF5Y9GigGqxY5I8F8UiQo7G?=
 =?us-ascii?Q?02FuXuJN4J+NEieoEC2SpF6kySPx7+KhlD9baA3AYzdX6JyMx6hnobvQzdrd?=
 =?us-ascii?Q?KlPK3K+WzVt3MLfDRoq7YBoVrfGl/IvrGJnmAAAtiR/WSJ0Niz3kc7r6h/NU?=
 =?us-ascii?Q?yhAqykylfkswHrDzlL51HDlfDV8bX3lI9lBE84ZbAx7hlV3ttALkY+4q0gFj?=
 =?us-ascii?Q?Nf7GEzhp08j5KEXoS784zOop4c/W+jPoPNWr3wMBOECJOQ1VS8YA/thoaYpq?=
 =?us-ascii?Q?xoZcg1+XSrbKKK/aaSYdv4Z2CMqybu5Y2oNfLM16fKzaTDi/wWB8Yq3HBu4Q?=
 =?us-ascii?Q?v66s46Z0igpjQtRkQ0vg1BgNh2KfIpnxvjg6HJ5vlb3vIjXFHI2PzO9katym?=
 =?us-ascii?Q?/RdppVpET9QkydpniV2Ka0/XPbTKiE5Ebb9YE7V1sw4vjN30iqfjKptdbGkc?=
 =?us-ascii?Q?RB04Aal2tQF2PfSMc56VA1I82XmM/jGCfhAkHSIA+gntELxybSZkSK1zr0NG?=
 =?us-ascii?Q?jyFf1L0h9d4ZqLIyhSeNDqAva4qyZ/3AlBaKEAkYRN5GDfMiPvRq4b+ygxnv?=
 =?us-ascii?Q?YUKhD4Izm9v1AJJCRYlEtb8EZTEyq3uR3VYAltU0PRIHdvCDZdw5S0wubBkf?=
 =?us-ascii?Q?SCySGwCQmpA6W64UeeSs2LcpUGWb2OQEivJZd8zbp3U9Uu1mO0e2NYNgTFSr?=
 =?us-ascii?Q?3jaJHvVjSckhYps281MhE/ACTUgE9GlsyUC+LcNysYEhLtF0eCB1GlqGxoEo?=
 =?us-ascii?Q?jmTC8ePRsm0LQC5Q10m/ZZQW7sLv+1B0EcRkFE46wSRWVu1Do2pStocdOcQj?=
 =?us-ascii?Q?WgUKrqUQDAT5o7Yq1luxfmkt3SbsaElaBtccMqDW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aU8G8CEY6sk6Lng2qwsKnQsUwK2RBF7W7Ams9xk8ttl1jv0yM+1aoDr2aUcE/Lrc6GEmE1bBGUM+ijIjBawkQihD5Q6bAQnWocgqStMsQIebVq602z93S8pTAIcVD7nHfL9DxZKEbyPz7WrE6KoT5/6UYZ2mIpbAjcY9dTAu2Bx03omWxvWMPYIiQxuVaNUX05QoyYn58rUfj0X1Ooqdb/o18O9NfKjhSATIr+uJlstNC+xsnsxLV9rykiFsfM2ibAt2516KsLNetSQPhOKbDTufY+OiRSOm3sTl/bdgYAsVSCk0qiMYz1VazBa/HqQ3AJwn5I9VWeKyyksGuvQpBBWV60uJ3udftQlqUSQI2jYQoaCs2kRN3etk18rlNigGh1s5tmWUO2eBqPgrx91Wr1UDzorzKLbBaTzNzTVCttKVdVY5FlPiaRog3RSI4P99oN0khIURvPOf3+S1UwMVwil8m/33kg6DA9NloYZL78vyo5VPwBJLbGdNf/Hea3JOq3cTY43Ug/tSoDsWQZ3Z+J8ki+FFQgC1S2fgiEfFm8q1NqRayCktlB8ks7pTbx9EZ78tjJQQtE2gvqNdOt9Tyb1nLE4MPjTkjN8jK6kdlDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d0253c-01c1-4ed8-510a-08dc47c08aec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:59:07.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe8M2z10ovm8XXsBZOAkcKqv+mLlo4eiL5O4Mp1OMuRrVHI9BQyTWxK41M0d+gcFkp7LyPEjuQLQSYn6dyzmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190021
X-Proofpoint-GUID: 7dYFcBj2qloDIHlPbNf0X9NE85h7Fpwi
X-Proofpoint-ORIG-GUID: 7dYFcBj2qloDIHlPbNf0X9NE85h7Fpwi

When attempting to exclusive open a device which has no exclusive open
permission, such as a physical device associated with the flakey dm
device, the open operation will fail, resulting in a mount failure.

In this particular scenario, we erroneously return -EINVAL instead of the
correct error code provided by the bdev_open_by_path() function, which is
-EBUSY.

Fix this, by returning error code from the bdev_open_by_path() function.
With this correction, the mount error message will align with that of
ext4 and xfs.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 rename ret_err in v1 to ret and existing ret to ret2.

v1:
 https://lore.kernel.org/all/dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com/

 fs/btrfs/volumes.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5f002347d167..7919df386332 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1184,23 +1184,30 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	int ret = 0;
 
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
-		int ret;
+		int ret2;
 
-		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
-		if (ret == 0 &&
+		ret2 = btrfs_open_one_device(fs_devices, device, flags, holder);
+		if (ret2 == 0 &&
 		    (!latest_dev || device->generation > latest_dev->generation)) {
 			latest_dev = device;
-		} else if (ret == -ENODATA) {
+		} else if (ret2 == -ENODATA) {
 			fs_devices->num_devices--;
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
 		}
+		if (ret == 0 && ret2 != 0)
+			ret = ret2;
 	}
-	if (fs_devices->open_devices == 0)
+
+	if (fs_devices->open_devices == 0) {
+		if (ret)
+			return ret;
 		return -EINVAL;
+	}
 
 	fs_devices->opened = 1;
 	fs_devices->latest_dev = latest_dev;
-- 
2.38.1


