Return-Path: <linux-btrfs+bounces-3416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703588001A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CF6B22482
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6220657BD;
	Tue, 19 Mar 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kahsmesg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QK1wy6ic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C1651BD
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860311; cv=fail; b=ZcurAG2jW6IGAmCNyXtDH/Is7qzfw0kSeBwFSZWSRc/+yx5DwMjGXR1H/ElHAwC5mTtEWlPidsjQb58g5vcrSFSv2yuJNkMCP9bgoMEMOVKa1VVhxuMWALj6oN/k49fjbLDrJs9ZbuDdhTGzkqajVVK1raoJh49eoCEg66VpFzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860311; c=relaxed/simple;
	bh=MpOUtukWvQQtZSpzmoUEkiBRr2eS814J4ex4J+TGqHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ob9GIKj5xdJvY0vs8Ih5EAoXsImJbBP+83uqEhsbxLdxFn2WiL/rR9uojDTnGC/zjZ3z7GxKP50xMetKWWOQulr/42SE6lQKX5FIpfCB5vSGxpZCzxJYxXzi4xl5WQgSu74+daFB+9PsRI5IwcZGBP5JNsGhyx7qUGyGe+TUmVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kahsmesg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QK1wy6ic; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAI14E010964
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=PBFmmBW4nFo+X6+72zVA7nLVje+E5nZAi8Tk3B35OrM=;
 b=KahsmesgeuOspyLdsxPy4zqRYf1og+rQ7iQO9rATdJCD9n164AGeaBe8dm2jbEsNNuO7
 l8AcK9NZhQxJRrai1RmCLhP3yEh3cb8Vx2gKpcn4vH8m3xbiyUy6i3o3iG0BQ3aDhyru
 MPLw22vL6TrSdpXQv0gBpDMnCcjnOZmb5WbyV7k8LRA93zH+V9OfRrTVnJjjcsPI5E56
 Jnl8AQ1NDn3fY/ormZxN0TE+2s6cwDkkJvqMhjKDt8qdYcK0sHtI+iMTldRKpfR3gPKZ
 06pHQHenYi6bj4iUIq5HibT6fm0Qff1th96laonpyZBAxF3uUJAbZ+qmmMqRsdU702Fg 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115reg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEKOu4015748
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6v86h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FozG1JDIYOuQ7l6XKTjDtUL+Hol46LaKyKIV7WGNCUAT4T1i5r2DdeU6ip+d5GIOf3TYdAycPSBJ0TUPQu0U7RXcKv1jeLF5k5i1FUSVwnzbPScRGLVYG2RsprEz9xxr+M1JryvWogR+WGtxvtcNWMGHFveH99KFkUxZrCRf2EMb+wMdQwHXogTd1Y1aF/Kubef6e2fecBHukGbOOimNrxYBd1dJXctk6u9mIsSq1O+uDw3T2oRa0WvR3Ge2cZxkcl/uF94VgZs46BISRgn1Ehud6OmsbwQ+Q6po3DKcnGlvLlf7FXX8+k8K0m/f9n30UaYWS9S9SydvnpbWFOnyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBFmmBW4nFo+X6+72zVA7nLVje+E5nZAi8Tk3B35OrM=;
 b=Ou31qMbQnTcbfYUJfjcFDE8H2i/yPfDb/y/r407PcL7LzlVie5ExR1H9WuptiPBmira8hTrPHhp7tPEIr9mYBsEgf3DBLaLIPyX/fjA6JbKicsaGQy6xOH4dOA/f/TqNgCOCbzjAHuFDytJLX96l16/2kH3kPrd82iI6NQicblayaiYsC0ijFd5d9VB+khYlU/PFmmpGc1ChIL5kYNGSXBdGltNhbNs2V8eJ151t2CbiELrKQ2kYRfrbZPL5dqemIM+qIWF0KJTaixHFK3hhAGF1ZXy3ixBH2PJikEuDnCsLmXA3lPo1i4cQPI9gEXTYuQuwHLaX0xuhOSPu4QwTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBFmmBW4nFo+X6+72zVA7nLVje+E5nZAi8Tk3B35OrM=;
 b=QK1wy6icTbQZijhFGtGokLCR04C+IhFKdKoQEcOR1z4s9L6IooMX6UvsgupGGq1M+JeyTR7C8vyybua02czESQOGfW02UuCJzm9jM86oAuf6QV/xfjF+RXHGF+HliyVjOtROluQqFDXDMID/OutKf/Fg8fLVsg4Cu1jzVZlm89Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:58:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 21/29] btrfs: quick_update_accounting rename err to ret2
Date: Tue, 19 Mar 2024 20:25:29 +0530
Message-ID: <1f4bdab06e7acee3118c0278d7f16a352146ccf5.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zTNEBOwU7GLBueqKtxwandD+vnJtdXDuByRagZjDKtpGI6UThC6tCqpcCSvYO4OFcYIry7BA2+O/+WB30j44S6T7XQNfc1aswThrrRtXx9yQ+/24rEcxpT0PeZYGqAeqtdXU8AHqIVZbqqBewDo84gEqx7pymHQOaewA79LT8hZLd7l9o1fCaLN8SqfmI3CPXCZOQq/9eTuKZv9f7ipprpHzo68Z80k+S7qrIzrd586uZhs6S+8WRMxE8ZSYcgOMRpVtbNheGfWboo99tv5Un3HH5VBnscygWh3ZF5+SLhqqYj9d+/C/dqjWawb/gLW29K02k/kr74xxkVckYO9jg1epTRD8BFDj8jkQHRes0xVD1Z9II6PE4k430pIDBfh+B9rIcPgOHHkx0F4bw9EIEdvmw1gzXB5pR3ogRzgwDNK8dZpDGv8gk3XBTA61/2e+TfCwL5EqfgPl82oXT6IyJL1sWhJVm0HlmS3yB36S1jStDpoY9JllpTfp6miPrN7S4t7mj5SezQJKp2n7FiawDux8JjL1T3jJTXSJW2rWlGoFg1NPoBG7kkqXvp/gVh0waj5ROcYlKxuYD0KN8KZ8MT1A56wNEdwoUqF6wiYjmk09jf/5vCLx7svJj5YLCCDZJ4F+QYRfHvSPgQhVz3O8N/oGD6k+Daw26U6Utcq+rVw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rV0kfj8IsaJr7lcyp4LhUEbD5fF8NdnbM6oxEu7h5Dqq3Ub4v7y7M5kYHPEX?=
 =?us-ascii?Q?igMm0oPTVzfNd1d+ErxMSGOLvm9CK6ZalADMx0uPCWBbHcnRmiqBN+YYZOYp?=
 =?us-ascii?Q?Un+D8MoU+bisraGeTgWsPNArrpzTH9R7KM+v4rjLGqYdDO7upEzHRDOkOp+m?=
 =?us-ascii?Q?5/1tqAR051KSpAIVq5Ajs8xt6SFzTIyaJiNGfW80UgEaA5nLJW2FzENNufCf?=
 =?us-ascii?Q?97yUWGqVub3V9sFdRv2SZSzijl6ItW+9ZmKeqI+KXd7Udi2V7BhDe8Eh9OrJ?=
 =?us-ascii?Q?D+q+Z+aXKHFW/ia9GK78F61MFggMd8fBM1ofaIoqeyEa/K++nWzuWik6N15Y?=
 =?us-ascii?Q?BNsv56eqADF9rrb5RRvT4Cy/c6xxfMiJFMwOZpOraHdT5ASDX8AUlHTyuoYZ?=
 =?us-ascii?Q?RNfB2/nmG5EzgM2WwDWnXa6pkqK2+zDdihFdkjHM7zV529lTDKpV2AjvF//w?=
 =?us-ascii?Q?jt9c2gnrYuQg6ynpCgfcWM5Z6ppUtfl1oJ6W6Qx77UtTdzmvBBNwDdxmfUBW?=
 =?us-ascii?Q?f46K5IwgN51jeyAQkGIEWh738KGLdPScUgSZyikL2xJ5XZOMTXA3frUzQ5PA?=
 =?us-ascii?Q?nRQGAAQNugOb29YRaIiVESYnp2O9vnR5ulXSgOfG/ZGJiNaHmPYs0RzUgt10?=
 =?us-ascii?Q?Foq5WOmD2qwAImzT64Got4e6Eto/ueLauZVymWKxedi2yitW/hOGFMspm6i2?=
 =?us-ascii?Q?apWL/mxF6dxX6gHLggF0Clu6eGqaCTKN0Zy8B2jpa4pBi867DB/3qNdwubKJ?=
 =?us-ascii?Q?WoNkiSu2cPsECCDCPs+5zHkULMvbRSOZ2tkUvB6+6BoVR2+1ApHal6C9fDMe?=
 =?us-ascii?Q?tYDoklZBZjMzJgbczdr4zZCyZba4cxNivtiedTaQE92QuwYn6C4aIHHjp2qr?=
 =?us-ascii?Q?jQHnduDauNZhKv91z1MAPR2dhWvp7Br1UKgtJEXCBt/n1cARhHKEZNaIlnD2?=
 =?us-ascii?Q?ox/79eqguhw85A4hDSlpohEo06BZJfAqEc6Z733sdjzFweOomzBnArNuOT4C?=
 =?us-ascii?Q?4dJTmgwHDCm+XiH0WXC8kDAzT3r2z2gaz/N4v+fuy8GuwDndchn81tpMztOh?=
 =?us-ascii?Q?VQ/a//huOYAR/RoQ6kVVtjCZWcsudBnwXMzvH42Q33swN6eFcjP5cdE8SyF5?=
 =?us-ascii?Q?ymFBhMuA7W4fvGRnaOKD11bg3pY1j6PZM0jUuPz8gcIjFXS7MoNEHpiasSBm?=
 =?us-ascii?Q?ApwjWTP9udlDdagQPkZdYFoayHZNSjRldCLP50YTr1HOKgVY9yz/lcw6vKzJ?=
 =?us-ascii?Q?lUbsYoxf4gecrPTOpyVdtHfb+5WTXw52V9HJ4MAMsOSLiDz9J6Sw1jd/ar4f?=
 =?us-ascii?Q?5SGLGw8LVJYI67vJ0uLlFSCYUmLGmzWbVVYq3I72XxtMB0GVNnm0gAGcZe5H?=
 =?us-ascii?Q?sKwWvZQjPLidyFAM9JrXSlSFa6lmqCpvt+qt+68XLCUOSOndunQtUcTjzbDV?=
 =?us-ascii?Q?3KDeQYHgXe0ubh3nb9r+VOOrQgvoheYrKVk4+h+BzJiqCZQbLUoY9wH3swuJ?=
 =?us-ascii?Q?Go4qIlYXAv9JWZ/Lu/kAsFYo1g4WjNg9wmE5DNxBaJbcEUyjr4tdUY8O4spy?=
 =?us-ascii?Q?I27jgyjeh0WdeV9+spzN1tsIXmxTaRPFo3nW7ZgTMpvP1FNTrxg4xW2/lMBR?=
 =?us-ascii?Q?RnHmjGhTU3UAjZr1kJrKZEepg6GIGfTQMTgfZiw4deyI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tiWJnEcVersBcDDr/ixZN7AMBV5zoA5P0chu1NX31AUy8i21sDtAkW8h8VaT5v8bncfooVeagve3oF3zpgP0XLGXy5cDLSYpdt1yXYCI5TxaQQZe0ONSqjne7dd3/tLQELeWJphFRdaXgBjfxd1EbpL8PQtAgYTUaOu8QqblKIGiLoglQbpOfPyvkwViY5NuiFXa27wkQ5FtBiXV8Y/gVTWHM2P6Z+S4uagx+KBAY0jTy8Dyc0gioHcGjm9THoXxEPdPEFE7QJYtbvPJxKU4O6O+rJW6srUkOc8huldVxjMzDoGl5K6vFCRe6TedQFXNyxgjzA1Slsoe3eh1GpCKsFq6ZcWJVHH1yUTYU9c5yZJNjNYImckLVHp2dFs8o0M92TcM6UD8xzIy5xm7/iRgjom13AIoPaIhqtEEbEAZQnV4Y4iwq+zfNl7x1OFwC0d6HoGAG3VXC3xRLy3hoidmMKTIuG0Bm3GCo5nKPn5EW6XHdc3N+MNTl7KTEKZ8ibJYFNp6XtaUUeDt1qDmK/n8vMmG6dTnTF3cBtGFWjg5Jj7lkff3I42jQN2lbsVE9cDJzNUSYS9Dq5AzzHDlitY1+ONVYsoICortw26N0pDrKXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d9136c-f30e-4c40-cd07-08dc48250607
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:23.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4UA+HQBXQiozQyqFKizdtvWLtfmyTK22lBz0LL4J/s09DBulr0eVL0WwEBM8P7xzO3KE10p4n90GlRaPomnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: gaGHgc2lVN3q0mw-phEOyHiKZhtf2MJz
X-Proofpoint-ORIG-GUID: gaGHgc2lVN3q0mw-phEOyHiKZhtf2MJz

In quick_update_accounting err is used as 2nd return value, rename it to
ret2.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/qgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5f90f0605b12..23a08910fa67 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1541,16 +1541,16 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_qgroup *qgroup;
 	int ret = 1;
-	int err = 0;
+	int ret2 = 0;
 
 	qgroup = find_qgroup_rb(fs_info, src);
 	if (!qgroup)
 		goto out;
 	if (qgroup->excl == qgroup->rfer) {
 		ret = 0;
-		err = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
-		if (err < 0) {
-			ret = err;
+		ret2 = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
+		if (ret2 < 0) {
+			ret = ret2;
 			goto out;
 		}
 	}
-- 
2.38.1


