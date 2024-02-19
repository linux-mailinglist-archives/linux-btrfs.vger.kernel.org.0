Return-Path: <linux-btrfs+bounces-2533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66F85AC68
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A432859F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0F56B9E;
	Mon, 19 Feb 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gPexiJ0H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M8U17L4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1656B88;
	Mon, 19 Feb 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372154; cv=fail; b=t04tGCkrXQImsbUt6Qp5Bc7qHJBGJwYhox3ZzWySAry857Ky0fNdnqIhEAPCnRE6sq+pMiigSlTaDqhbcFk++qgYbOJHbs9IvSBVuEaXXcBtwy7zpfBVCYlGYd8mI4CdlgMR0cQsANBRS4bBRkIhRN2QVGypt12tp5hTGDIAZ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372154; c=relaxed/simple;
	bh=lEkdcFsQo7rtR1ifoPZsFvdSmAW5Q+Sx3PDyVZij8Es=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fm8owz7Jq4vrDZ+m8hMSfvY0YBaxh2GQYADUckgTBCFhXIIlcct+FHCkWBTBs2DIWRfN0zbbBJK6uF9Q9YH1h2Qdd4iAaALv3/2me7wqwo82xJFkyCWMhQQesw6LFRcm7bOfJr+CKPjWvI1LzJCxbfRsZCykDJieO1Hc8+1+Mjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gPexiJ0H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M8U17L4F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJfd9008574;
	Mon, 19 Feb 2024 19:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=M3X/1qrYcetE97vovxL6Zaj3uxoqqR0PjFF84rxsIls=;
 b=gPexiJ0H5ZRFIsyckFOUAXIWy4tJ8+OHALcainwaBKl6TV/TIkAWRm8Y+xX+uJTIYAJi
 pFP4Mwb7xpjA3v9fiFmvIdXHGfgX2OyF6rY8Ro9yq9L5da0bNfkV3tSlHTkLdQxzRM6G
 RZhGuPr9yXh6oo3B3u8nKbzAQ10/Il6Uu7iTdMujU13gqVjWVYFCnQNWL6Hp/6UhsBPx
 vloRzkxew8ptUHs9Sf/54s5vK+KzFdjl2clfJtyITEAkIkg+vt30Sv+XfhaoHgdHpkqX
 zzBS54CqtvqJyWfLk45LVcn7+8jgjeKsX/GJ03OYfgxuGRyqd6hMZF+hJKjBMe7fRE8K uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampavx61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JJf8mA021632;
	Mon, 19 Feb 2024 19:49:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86f7hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+IkwX8x4Iu0iyMTHhJF4XiRrkt+m4u7m+7XYn2zAHZykBSIVSEvNJ/YaabiIQhU4Q8bMuqnT8yM15pTsELtfvJFdnyYcjFUGedOBWeWPfgfq47hP9sFucTupppbVobE5V+LSeD1KnBtN1nmvDax1Z+OHfVWbwJyYEJDQRb6g9d8aS6onciN6XpzTUKQl36Y5s8hycHIKVvp5uKS7rR7FOzs85OUtH2lLp2WeEQFJ7/ovzQQQF9mQv858oX2Y3U8ilUZRoMu3TgKG7mp8DPFANUtpODEh45MKq/HZepIlC/w7L2TL0RacfDXPu32yRJ6Yag+ywsllRd+TcgTPSxulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3X/1qrYcetE97vovxL6Zaj3uxoqqR0PjFF84rxsIls=;
 b=IwTIXhYZGotCyYG4NbI/DEVuSMX3Ul/wdBWgftDskzsK5mMKaJIbBKfzOsj+/ZuuLv2aGezDHfui2Rqnc14mkFKFFHINfWUQPm5ROnEtp8tR/4LxidLhpft7gj5SKAGM5XwvdKN0XnfkNWYFOY+gNi3q1jnKiftgwvu8yz3QsNShvjr2nCTyGQiaxggGBOeOczXWwcZ3EduA/bs9HQJmpeXhFWztJGFC9IZex9Oh6CeVq6I5zQzYKSgIRiEkKkKI3szvs0JARgNs9IHnHDZ8q358p0WLc9daXWmJDzIn0//kwd/ca3edzCZvd51Pg8KHbHFMwWBx80mcM/FYubBH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3X/1qrYcetE97vovxL6Zaj3uxoqqR0PjFF84rxsIls=;
 b=M8U17L4FpGeSsZL4QSfIxHrD/th1gUoHTyBhvWMOd6FGyvfwD2FcPeAYhdvCo9gDSuxn0Ng/0oKqpTJ/NKfBGC6L9tsfG6B3xufj+F3C2XhINC9Mn3nkByK0w1FixoNfdkYw4QWiuLcAmQRiq9/iTrATSNhIUFXJ00C7u4BXIXI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 19:49:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 00/10] btrfs: functional test cases for tempfsid
Date: Tue, 20 Feb 2024 03:48:40 +0800
Message-Id: <cover.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c2df2f-caaf-44ea-3e0f-08dc3183d35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u8jikc+FiDoGYYy0BJp9YoFWDBM8gOsPK3hq0DcBnhei7U7bSy3xRW+gepGLIp6HNCi9ZKO4puost93Mek5ZLBHHQhYYfl9tTIgS7afQGB9pkoXlr1u7A95WWrPU2wXQEKCR0X4fTkQqIKc4Ej+4Jnj9pmK2u2U+BdfBXYk9DbI85wCYBFnp2WPW51FSeJvbKQx5lRW6Ah5Dr91KxefyQsEMQYSmfUGCbCjROeoPNTOWpj98V3QJGPgjKirEnv2IDe6AlaTudXb6nbNQsBeuMbgtc8CIAgFpJ0DdJj2arBA4fEEySr1u8geQ7gG43I0pRX7D2XZhATMQMjpOj0PGAWSwCOySKSy4o/HLZgQwp9yykWYXEIi/p0jPv8UYka+qgi/Cus+XIurCE4k5j/kU05J/yJKMG7mW8tpdOCpEzxQDdFt6N50ZDz1uxCXue7WxuIgprCHDtI9cEKMKS1SUeU2uxXAOB9BVkBUa3nrEaEyVQxrx6i77hypxV58CdwDu4g9KAchsDDWi5TVNuuSgtCoL5mHX3hw8FDBpRukj8rU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LtkccTZJgh7DjbYvvI5VdZS+Yp41vth28m6Smal94sR3zIai1F+Z13An1dSb?=
 =?us-ascii?Q?PZpTE8yCmRpsQ1Rcp+ShHFQQazp2q9HBsquTOT9L70wIbziYLE2SlBHiP1Gd?=
 =?us-ascii?Q?a3QamvPMkbM1P2fLWNNowPbZF275+xaftRxzpn3Ob2mXV0xnHGVETuwgOhqG?=
 =?us-ascii?Q?ZhbIuRT50p4cUYO6jBk6TieqXl6xFJ1I4seGa7VjN0mCh9ePF6YcV4X/oyWg?=
 =?us-ascii?Q?hKs/GqcqC9rr9XZ/hT/mqIcDYOZwrR9hBsM6FBFqscWlzb5gj0hj7PlsDCuN?=
 =?us-ascii?Q?3JBdjk2AVgSv6VRcGi08UO67qdN/JTuDsmgFWPc70iVS/0iF81ZLdEqQif+z?=
 =?us-ascii?Q?JJT4ObS752jJrDzZPqJbs0DrClXADIsT7vI5yKAB6VzT/khHb5WOLFRGcL6t?=
 =?us-ascii?Q?vgsIjaexrw07oDda3PsGFVNRhOD2KoAR1TIBpiTvyVPEmvj59q9b7g/APLiJ?=
 =?us-ascii?Q?7bAyMX3J5f3SSlHQjN880iKiGq0YQfeYpVJk3y5pydhp/wSFDbnHb+vftT6M?=
 =?us-ascii?Q?JEnU4KC232YPjTTay7VT+TxMb8woNYJS1d3FTkBlZEyetqUTn1aV3gnd8j0W?=
 =?us-ascii?Q?IF/a+2i+2J5VNr09Mrr0MBcABgbnXwtE5kerhqcLdzYcKvHsUgkhResk/jnN?=
 =?us-ascii?Q?p00qW0GqiWcVVa3OFlbuenGXPj2zZyfv7hYbqx2tjKfTSyu0OMz7r9ve068X?=
 =?us-ascii?Q?Ylg8yiEAfDQtyDEgJwX2VB88w6oCFncRjVEX8Qia0wqfd1sTQKb6f8TpS1k6?=
 =?us-ascii?Q?umwb0Gc/+Etw4MyZOv6ryUgiQzWdNTlGR8LlmBFXxD2OKF5+eHuZGJVy6UYi?=
 =?us-ascii?Q?1um9qdbn7qhFAM9eRBv+cuTRC7DXpGvZjVAD84tlnML3MaNoDbmM/Vv4f1zC?=
 =?us-ascii?Q?yRTfczDDcNsPY8LboCUsOFmsnHP1dgg5KiY1gd28QcxXSMMO9Bnrhx3abVfo?=
 =?us-ascii?Q?9RzDYCzyvceWmqrPNcck4CZyKi12wrrAce70L7N9WOabm8IFIQTr9p//wj2d?=
 =?us-ascii?Q?kRDvwboyfjayACROpGGgSaaUD1DfHx6TjY8dxpJxPlDukGzyVSQPy1Z+gH56?=
 =?us-ascii?Q?islK482VhOPg33nlybZV7LlD4CYL1qijfSJLZ3J8Hr8Sh10J1qaOsvOAAMrk?=
 =?us-ascii?Q?JWMmdwTz+m6MWXHyyzuQMRk2RS+rttidUMFudr1y/Xn8E+UsnP3Nf+kl+OM4?=
 =?us-ascii?Q?T75OV5vzIWAVIVbcnSvsRrRftG7SwdoFk1AuG5NkytqQJtA1yzGvGq8ZXtkx?=
 =?us-ascii?Q?oGnNXgWM/MkR+By6RpWFjQydDZUGQ8Is+Ac6fxIfqMEBlqObFRS3FnKZQjbL?=
 =?us-ascii?Q?dzNlD3sT1+vjOJLiHMy546B89dX+38OLIRLLuVCbGtjgY3fqMPwgvIgugFjr?=
 =?us-ascii?Q?qFRpbK8q74q+v+5/YHwD8JPFIG8oG8omrMlAlnxDhf5Yq8OnJSv1llwKMzKF?=
 =?us-ascii?Q?oKi2Xfw34u7nDyR0nVbBgGLT+iHj+CQlQxCGluMRDmYfQc8f1D58E3nDwvlK?=
 =?us-ascii?Q?IopLEFALLhQH1TH5sbzuvLCBKl9CsHI+5eg1x4uYQ9D/nelWfxc3SWwp2f+I?=
 =?us-ascii?Q?3d8fyKyu7Pk5GGcZM9bAMXcXXevYYuuUdJunGDHf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZEsysFvCjFagRo0htyDIfZ9tQtf83U+86ghDn69FWR1Ts/q+Kv2NNo3ioyrj0OyBczX7bdbLuwwSqLkKsP+GTxrYgKfEX3s/bYW4r+SonOjFwlkDgWuialVV5kojbONTEjaq367/XKIaWyjXIuAE+NgIVvNjTd6r5mS3abNJU/wizdSAJXD8HLVVrB4xzuDVeK0CnyVx8eTqtdgmBj+X8JFBT9Rn3klmQIAO4FpfhJ6ntUJEnqkcBEUE23uygtZmJqQRWoLmXD7snRLenHRKZsQFVtWW4Y/8Fxd6FCvfKmSszp9IOZrNzWUk66BYs4v2rHIC/HA3lJASI0lm1MCg51I5wKuWtfDvNxZS6Q4whi1nZMIOz4OWVejMzEH7aoOWKDJQEzwjFM8b4ZxsS1nqwn6ccd/5d5uj8LHQ0b8bZCbsgR7vzI92BwstjWHbz/jboMP9sQKQ6hTaba3vGHVzDEVCkafThj9X+zXAgnW5skPfVzm42ON7aoUg7q9wlIiUiwNLlwdxg/iWAup+pEqR2ZISncGiCneUht0YKzxVIVVjdjuSQLR7faxeR3RsO8PDgblNWbjkFEwSQlR+1iOqCtJHYxBEJjVzLLeM70gF/YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c2df2f-caaf-44ea-3e0f-08dc3183d35c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:03.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAQGgudtXJvgiBHfNT3snySJgMMTM+gIVEt4siykUz9itWF0I1H6hs5v7/UHN4icQwh2AM7V9fnQjY5diD6NWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=581 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190150
X-Proofpoint-GUID: f9prcf9Sdnj23eZsHgjH-qZJ6iwZrdkq
X-Proofpoint-ORIG-GUID: f9prcf9Sdnj23eZsHgjH-qZJ6iwZrdkq

v2: Each individual patch has undergone numerous fixes based on the
feedback received. Please refer to the individual patches.

This patch set validates the tempfsid feature in Btrfs, testing its
functionality and limitations. Also, has one minor bug fix.

Anand Jain (10):
  assign SCRATCH_DEV_POOL to an array
  btrfs: introduce tempfsid test group
  btrfs: create a helper function, check_fsid(), to verify the tempfsid
  btrfs: verify that subvolume mounts are unaffected by tempfsid
  btrfs: check if cloned device mounts with tempfsid
  btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
  btrfs: introduce helper for creating cloned devices with mkfs
  btrfs: verify tempfsid clones using mkfs
  btrfs: validate send-receive operation with tempfsid.
  btrfs: test tempfsid with device add, seed, and balance

 common/btrfs        | 67 ++++++++++++++++++++++++++++++++++
 common/rc           | 15 +++++++-
 doc/group-names.txt |  1 +
 tests/btrfs/311     | 89 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 ++++++++++++
 tests/btrfs/312     | 85 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 ++++++++++
 tests/btrfs/313     | 55 ++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 ++++++++
 tests/btrfs/314     | 81 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 ++++++++++++
 tests/btrfs/315     | 79 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out |  9 +++++
 13 files changed, 561 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

-- 
2.39.3


