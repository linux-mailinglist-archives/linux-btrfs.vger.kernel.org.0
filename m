Return-Path: <linux-btrfs+bounces-4063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347489DD22
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45221F218BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464E131E23;
	Tue,  9 Apr 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ju+Gmak8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oa8i2ToT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E345BEA;
	Tue,  9 Apr 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673862; cv=fail; b=m/xDsRZ7MpMUUhev5+tOf6OVcIYVYb7ryYi5pQGKpI8+hPe/EfxEgB7MqTYxx3YubHREaPJ6Eznl+ZerFX63Ptl+Suy5eHDFZN86HKOK5qhDcF08oT57AqAi7N+nKQDS/VWtCCCl3TLWS3SJfxcDOoJYQEd0sqY+wfVg/kbhLls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673862; c=relaxed/simple;
	bh=ZpUHbfmGTMPFSSbwMBcWo/Baoat2vPyAN9SGa56krTI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q29Iuq49bOGAZID8/NgGayNZqaHQCwlWYu9I31oleTmTQ18e/rZafSCG7hIpukxGVeOx7p8sTNNcbw+xi6Srfkz/FrX1/i8CH6DCDQxaS8PJZ/qwqdA7JDMl9kJrvRkiVIrTV2W1UsvZi5YQUdPVq/RhFYHKl/3d/5s7wZJnsaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ju+Gmak8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oa8i2ToT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYsGN004416;
	Tue, 9 Apr 2024 14:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=yPUw9YhBl12rCan0nftRaySYIbWBAnIsCTMYdOKk7LY=;
 b=Ju+Gmak8Yo1XFDyf+3Tfuv5+Jwqlp9ftWsdNyev38c0Es8mwcGvSzqvgvnRbJZdedGzX
 68ZytWZFls6Q21tsmqbZF68iOogW2fgkN8C3AF2gaWIClODY0VrDqC11C7PXoOdpoaoG
 UIxAuZFsxGOzxHfVj6ARKP+HgLsrDnOWVdcY9+3SvUTgMDjLyglLRxEMVct6cnWkPvOc
 U3XvV1SrVSajhL2etir4CqfntFF0GDiRaMIk/3ldHPzBHoL8zNbMr2VwlrJvtl33vCfJ
 DGTu9cahSwDIX9mIbGpchoc0LppK1pX4IT34uFZ14d67nrlIv9Wz3v7eW6J9ZuVCtQVi Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvd4kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:44:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439EV9a9002880;
	Tue, 9 Apr 2024 14:44:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud39r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbenWLpqgKaKM9P6mUer01RunNkUBgdcmlsOzPd+Hf1fJ8qLz7i3R/1qdKODNICAicuTOwFpstT+NXlchIAdU4Fs6jf2GSDou2wcI95b6UtStlPsiGBXd16DTS/JWjI4K/9Q4b3cl0mBvHM4dI8hqyg5SSWqwiZbq86uyEasVcCOE/X6dAEuCoLsc93qwfCjfLNVOtyOGfsOujIREwTcfYB2OUMJmPkSIDO4Ls3+iuYSAnH/LX3+oQM+8KZ+MM+r5O7H1xHihkwbwznSgejwHds25VnrWnsdnkunKgogTfE7xfffB5Tj7r9Gj9M6WiQxr6MDlWwV9IBgZZWJjN7+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPUw9YhBl12rCan0nftRaySYIbWBAnIsCTMYdOKk7LY=;
 b=hbgBHOwXf7TVz4Q7Fvd/jPBfC9IywYpnAUTl4hSG9XYV6HO9LLkJuPmNrtjKT3vVT2DkLc8xSQbphqlaSMsCkUJzFHqZmJdTobRXU/rHAFJ179DjHhwmm5wcBWCc4b88I6EaHMGEPI2HAqSUMZj203hagltth/PeLv6zE2b/5DokjUfpembVlUtYaU/bNoFPGkM3hC98VPgWwBcegfQmeNKh8wJYGq2/AcPPd4lbHvrmH5j0W5MW61AJRV11TyNTQrmT6F+JYxFEgOCbsh++Iq5Pq2M9KugtJvVtqEgCmxlzJGvg2xO6Fje1dU5NlG+xcTde+TYY6N581SifGY7ydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPUw9YhBl12rCan0nftRaySYIbWBAnIsCTMYdOKk7LY=;
 b=oa8i2ToToJChCxD8QERfbnyVh8OlXzIxgundpB7N2pGdmsmCXMv3zaCAO7WngOYr5IJMiN+SAOACCB6wtlA2jf1hRItwGFaYbBWGGSFcliMtRGMeEbqE5cn4+ja7ixHQULPmUCrK795dfoIHE+cpRV/SPHiAsGoDdpSWv9LJjkg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB7027.namprd10.prod.outlook.com (2603:10b6:510:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 14:44:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:44:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/1] generic: move btrfs clone device testcase to the generic group
Date: Tue,  9 Apr 2024 22:43:42 +0800
Message-ID: <670fe32950d328b6a6dd071a53d8a25e50ce6647.1712673602.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB7027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vZIQ+sRe1RqS3V6A/jApceozY9JqLYU4KeH7c6PqDNL2Trfhi3dUi98wV48pPBrxVcWzUGAx/RSaAxHxzetAgcErdmy8FrjPG9e5OYwjw9DOW/4WZovKtgWTY2nW6DHNRC5uLcunXALzSe8a4nHtMeGuoKZkJ0MAPTeuq6AzC03OLYvpCOjCndzxhlzwEZ1hLfxJNwQMWiLvE09XhyQ44mbKGvACVGKbb83ufoy0+Dhgd6rGKXG0hL/r73O5/Oz6xyw0VvZRHT2tKp1cw72ItBZzTl02ZG33nxSTCOFpV6fanxtSTlsDLENg4cOPETGsy/jt9Vq7HQdwDorO7Y8Xc0ttDw2Ckhc9CqGo66nLeZ2/OrBVAW/DDWr92TZka7jSdI7a+UgPI1suUSsN24rHYUsG0+iBmgnHG6k4GCjSIzOjCkHrnZO1PjhN7N/paWEkgCZ6nKSLu1SsgWylZswaAEtMgcRNAYX0Q4MzuOfTqdvos8TgS6iVcWKmH9z/XEPVGNmTrTNhwMSVEplsudTZOpaXSa5ThVCWxmhlWRCY70sppuDNZcDjh8ULVH1rvXAT0iJbnhIOctMdXeDjnhp+DY7NwoR7Y4lACjdcosDmmJqvXx5vIFpxQJ6gm2AC3hiG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/DA3Nzilf5kzYwIZiRx/+24mRuKIaJtCIC4ZBQiLq/ccJ9c5MBVVHmdqv3Gd?=
 =?us-ascii?Q?PZzhX/Px58NKopshtOnrKt+JmScWmYqqgTikpMlyRrnJ0RSoEbZH84SHVugC?=
 =?us-ascii?Q?/VkcWYf+iDOu1XO/dx1sgY3Kf4pTZ1vE8q+JWdwFwMjo0MdzGaITshxsa18/?=
 =?us-ascii?Q?Ts/qu7gnInNAoZucnzpd3AKyTPmXtoJOCenIZK+OmV4ie0B/YVWmSLtHlF70?=
 =?us-ascii?Q?Y26IqFiFyptvn5SY2fQ8ZaNEitXYEiKyCpGk00M2krXQXbrWnIqf1R6hiITM?=
 =?us-ascii?Q?7BOtfsWydZ4Ad5lJJApcO9crgf03rxfXDxRqhPJZEh2hNLpXiyDa0Rkm9ora?=
 =?us-ascii?Q?hyVDUALnw6Bw1gZfK/PSRug/8X9g8/REkkO4+1GL+CTm22NOdi4Tp7y2FWCK?=
 =?us-ascii?Q?gYggZHZCYmSND9wUPJ9EtBRVoqTaZGGh1unDVlK+uKmU2akZzSqYipx3OZdD?=
 =?us-ascii?Q?xIDCISjhRETPkXiZkP1rCvIDSyGEAF2rY66J+lJTr0id+VHgBjgUXpOfvSXZ?=
 =?us-ascii?Q?fFH8ezHRnInl2YZ8SDlwieaNHJi/JsRjx+/5SZT4UFuXCRUSIr0YRseC7L7d?=
 =?us-ascii?Q?sP2iEBUbKKK9L4udLkIMPT2hMf0w06yIeW4i8SMkpQvO3XSWWAq5+n/p1aYi?=
 =?us-ascii?Q?VGS/KPo0PxFGOl0zZ2MzRW3+QxZKoy8Ut1Vv5kYRtj0md3O2RnLn/vddgbln?=
 =?us-ascii?Q?D1AcKISWdlVIG/wXZDVhgom5CDtTZLKAA6iA1KuYAECwrEcwSBXNczLmLSMY?=
 =?us-ascii?Q?tK5luatVlrRnVQGtScDq1dZXlT28YHFxjpjgKFQl3akV9Lxp04upm+GE129p?=
 =?us-ascii?Q?zXUux8wHSdf/3S2eNrkLy9TEx1GjbCG/8pHjmjQ/Z9LjhowDzeU8NYg6bkgp?=
 =?us-ascii?Q?pyf1yE3lrPbgrSQBi292CxbPCc17epqULDnpq0qYYX1mS0uoRT+0z1wTwimN?=
 =?us-ascii?Q?Wyn3zu302dbRn//fJ0sMYMNABv4p/DVcqeJPgPw4JjoUiMWdDA1geyijAbgd?=
 =?us-ascii?Q?tnZcKybVCpaRLAQ/yxizZwjIvHUjOx/sPyepXkQXTQZcpqDtZUSF0uQ7AWIg?=
 =?us-ascii?Q?C+m5aURXjoG5h4WSS7+lPqWWkK7Y+NcO4VfhFqolRuDIhPGcV/vtRJhnXgfy?=
 =?us-ascii?Q?vKdNxf/uiceJeQTd+hKzrOduDAySBUEG0NmLDOQB4yvFn4w6Wa4eypHgx3Gg?=
 =?us-ascii?Q?p+vSN8nvb2sit8Mc1ypuMqriQAxyGlJ1GDfs3FRVCDdL4D10jK5GWqg3GySz?=
 =?us-ascii?Q?BXInrFaLb0EDN0JoqwJS3HgWkssIPJMtcuJGVwJlhrFTLC9/c29O6RY1e/nV?=
 =?us-ascii?Q?ofRua2IhrN/OWMfCUJz1otJJizOuXmUH+ZayQ5t9HLX5hNLqXqVUvG+rvCKA?=
 =?us-ascii?Q?V+0MKbiYyA+WqjA5ohi7mS/9T/eLg4tppGaZ4a66FSI5nBqR63VEE2hQzHSZ?=
 =?us-ascii?Q?RswK/dZ7ng2LorVC3/6hms5VpmOKBg0v7HHv1OzD9Uj0rrRtMVytnIsdQG12?=
 =?us-ascii?Q?sTG0PBWI0urfEkkSZ4t5IX4jPCT0Hn4S3a4YyRlkrLhiL6usU8GznYoQC9tN?=
 =?us-ascii?Q?AkA7vBhQPpoOCWF10t7Hl9D/aHGxHbm9Fyou3ILqcXtwKsI+ecTPGayT3XHv?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SZqljAnebCXPcIhmP+a+84MxYmhuiV6jjpi4ODUij1Efp8pDNMSE+RtifGA+hajjOY1PtzOfXtqHWUhJARg8WLhazXkGn+e90SALaF9eQa4RvwjcwTC3Cf70GXuCyGhhE/ZWfg5uMHY1I7zcrFFFX6MkVjDYHmgTiNCKL4aiQ9Fy0ox0RA7gUAz5K7V6kiegegUh4d3+9Yl3u1Idm0JsJMpPQgyBa9Btr5+s0CzRGOUDrjrVGIb2yeeDBKcVXvTlVTtXjmxH/L7vgQ/Id+kjSj7wvIXeUw7AK5/Dapk1I/nfs3H9RNDFD8C++UwPqof1nGqmTXifNY3yQoaKrMQ5VgxnBZWsQ2JVPcFfk9gibnsGt1pU98xOvgIQqzE6atqaQJFHRqqPb32gnhnj44aj5OoNwM4yiT39FyNLtLKiBJ3aTSam1xM+52SgTvo0VcmfjO30kIkUz8mlV8xIqQ6l1ladKB6L8NNIuQkNAm+qhiqen8RMbDZwYj/TT2FBmKRDZGHe4/8dKlOJjCs69nPO29dKS1rS1dCou5IptmzU9XSdv1tpVLuJUVLtTGdJ4GqxTkBV1JsAgKayaznLXgE2X4bKn7gMtYIjmH5ITjD2XQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf11de60-b164-4656-b147-08dc58a38683
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:44:14.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH6kAuSaOwx0YS2jWDqOTyBkEKBMb0KkTMippOLGnyBxsp1xv5sn7CxDipiDYFWfG9zqEny/vrcc9eeD0P8lWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090096
X-Proofpoint-ORIG-GUID: vtI215G4hC7MTUqfAQGrjN0W-c4R-Vuu
X-Proofpoint-GUID: vtI215G4hC7MTUqfAQGrjN0W-c4R-Vuu

Given that ext4 also allows mounting of a cloned filesystem, the btrfs
test case btrfs/312, which assesses the functionality of cloned filesystem
support, can be refactored to be under the generic group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
Move back to generic

v2:
Move to shared testcase instead of generic.
commit log updated,
add _require_block_device $TEST_DEV.
add _require_duplicated_fsid

https://lore.kernel.org/all/440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com/T/#m576217a155aee49af607aa1f2aaa102ac92835e9

v1:
https://lore.kernel.org/linux-btrfs/dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com/

 common/rc             | 14 +++++++
 tests/btrfs/312       | 78 --------------------------------------
 tests/btrfs/312.out   | 19 ----------
 tests/generic/744     | 87 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/744.out |  4 ++
 5 files changed, 105 insertions(+), 97 deletions(-)
 delete mode 100755 tests/btrfs/312
 delete mode 100644 tests/btrfs/312.out
 create mode 100755 tests/generic/744
 create mode 100644 tests/generic/744.out

diff --git a/common/rc b/common/rc
index 3ef70dfdddaa..6b9d218e3b1c 100644
--- a/common/rc
+++ b/common/rc
@@ -5495,6 +5495,20 @@ _random_file() {
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
diff --git a/tests/generic/744 b/tests/generic/744
new file mode 100755
index 000000000000..5c7edf6499c1
--- /dev/null
+++ b/tests/generic/744
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 744
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
+_supported_fs generic
+_require_duplicate_fsid
+_require_cp_reflink
+_require_test
+_require_block_device $TEST_DEV
+_require_loop
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
diff --git a/tests/generic/744.out b/tests/generic/744.out
new file mode 100644
index 000000000000..1850a0ea2a5e
--- /dev/null
+++ b/tests/generic/744.out
@@ -0,0 +1,4 @@
+QA output created by 744
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp: failed to clone 'TEST_DIR/744/mnt2/bar' from 'TEST_DIR/744/mnt1/foo': Invalid cross-device link
-- 
2.39.3


