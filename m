Return-Path: <linux-btrfs+bounces-15362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1463AFDED5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 06:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10A61C228F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98022268C42;
	Wed,  9 Jul 2025 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IoCu3ZM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zr+uOM1Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528613A3F2;
	Wed,  9 Jul 2025 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752036027; cv=fail; b=uCImlSRKJwjcIjxVWrBxtWf/b6P+n/0TyUeo3uxR6Bn/pakOwR6bN5C77Ksg8exkCg2EICqjsehP7+oci7Cc0zvYGJnLpBBJTQzwLLuTplP9Fup8e+Up8AX0dn5ox4D9WQEZ3+Gq1o319DuIF7CaySWmYjh3VKUnHfDiQ5JeC6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752036027; c=relaxed/simple;
	bh=ZI4zMZRyL0Mqx410To9QZY+QED0RummDnTHv0JcNCNI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rf3OZ0iNnbhm9iA/nkWWaDpPwEdVTlZUJdRRzy0U/YPCqKXQE2aj2qIjjeOYQLaGJDs60l75WMa2lGGX7xTp6o+mrrv9L9JoxTBRA0TCWbUUep3RJ5OmdLJMM/Qman+uOQq+K7jqywT6vR53OWi+x4YyStACW8/RIq08/xColLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IoCu3ZM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zr+uOM1Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694akua029774;
	Wed, 9 Jul 2025 04:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=x9eQyUJCsT3aF6RK
	m2Srcv9dxktga4XJycUyxmJbGuY=; b=IoCu3ZM49ZayaK45nv6Ig6c6YI49Igws
	d0HhDLPdQpVGx6awxdbVyad63ECChpiA9lTeB50kx8Fz0ibKgoNP8OfzWDFyUGu2
	RJPWcgl1lUHWFauPet1UCm9pnoG9acOcXp5ygY1terBa4JzEpeJDwORZc8K51Mjm
	Pi+HHdaG2DClonFFAMUnw61uwEVABvXiDrMau3xb5Q1qgbYLWYI1z63GZK2n1+Hs
	Upn9jsvFt+rwIw2aBZfU29ieKW+w/qOdcYy1SVjAYmvUlZ9nnTGM/RZrKkFlR/UD
	3b6Swm1eLz8aHtM+H06Xb2itbIPQerhZEQ7ZThQtl31S9CV+UGeWSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47shj2005d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 04:40:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5694E2lm024219;
	Wed, 9 Jul 2025 04:40:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgaq7eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 04:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDcow7r+yzgs9LBasO2q6c3F6Fd4eiVVWAUbpt1t80GlKfA08a66DNPeTxKnb9Miajyrz/nZDPKidses3TPMGeWxF6L5t/6hNOZyuDVIqTUKr7dDLtOSwsfdETCorJZCnt/ZCxUac6RcyLmH3cgV4YLjb20P4Ad0MMFIQgWsUuI6A1BgDLrjE7Jt4yjFAT+LpV0Av/EFkTx4PxvoBeAfNCZnBz1zNCGoez3m2f+ZMh2GRBjr4g0Oh0lK+pP/LuOYoL8KV5lh+v11AvzvHwvzLVic9DhzN1uXBC7EXRQ6fTE4KL0Eu/yDiny7WDxbm1fWk64GPeRYt9lqbjdRm+Ik4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9eQyUJCsT3aF6RKm2Srcv9dxktga4XJycUyxmJbGuY=;
 b=SZa6IZROlohI+ITcblTPd1og+eD6uX5LwE92ME1FOrHKnfgVN6TtdJbfxVukbeqNiiFXJ2JF1y7sm5nUFzOqRjdVaes1k8QrSRzUrraFlJHnKE+0upzCycVW0hJJLZb8VX1QK/3B1felRCT9fV4yXvF7UWkeMz83nECs6gNFbMxW9FtaPLo/V5OEjgieE5x6fU3GaP+JOPc+erO1d7RblEule887Ii7219vD7yDWTt1PbezHO5rlRjQEqmxRqS+R+SJeLR3xHD5Q/Ztuz4qS/xdNg5YOB5uqGZpaMEwzCnbjU/RpH5J3uHuCHovSKKnTMirVaUWqJv/PWEc9X8QffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9eQyUJCsT3aF6RKm2Srcv9dxktga4XJycUyxmJbGuY=;
 b=Zr+uOM1ZgK/m6VUBgtysat9/1rrBWfN8BXrz5K/jDBZ/wY84X0+WGa7koVy6PzjVFNlWlTa/kswkFOn7xGDngm55Z5WiKXOege/MzQMCv7co+Fnk+iiJ5wyoVytXl9uGUoSpC+rYyWi/WBwBI0BnELeR561UNkFb0gjhNr7yxYA=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS0PR10MB8008.namprd10.prod.outlook.com (2603:10b6:8:1fc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 04:40:21 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 04:40:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: generic/042: increase filesystem image size
Date: Wed,  9 Jul 2025 12:40:10 +0800
Message-ID: <05033925fe12eccf80c07396edb9acc8e1cb6778.1752035731.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS0PR10MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ea99cf-2419-476d-ed69-08ddbea2b66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1h7lQCMmphdLKOy9YDKh5OjPMBCrCJAp7jPUTqMqIm6z7Wb1opzAbAKEyrPn?=
 =?us-ascii?Q?sPVTSVXqg8SQUbQ7D6OtmGjt1Zho16UYvPoXNQK7b84oF35Bj5L0bul5RJu7?=
 =?us-ascii?Q?F0ptYwTVxa6cbi/Hn/o27nIdHZBXpQoLPSFtYE3TTnRxPhh68AtogOypTvfy?=
 =?us-ascii?Q?HBFjQkIqwTLUCkqIXcjk3HKtKNfwNBkBz9V14ggLM8FdsaSizJZ6BQJYI1ER?=
 =?us-ascii?Q?0uGi3lLWKJfwPNMNH9tg7rMQRwyGzqUcs1nd+W5UjgWiHgN/NXTX+V4h4Viu?=
 =?us-ascii?Q?u5XY1JYaOCVlCyCBpOwry5lTjIh/pXiox+KO3r6PQZUdUogt2Zde48dpSSXM?=
 =?us-ascii?Q?C3HoLmmHVjLgsimvnuei61Ffx7qyZUM0C9y8+FpZS0cTrRdmGB/skmF8jc+M?=
 =?us-ascii?Q?C32obgDUqqQV6yAaGw5XCVmChclLVN2vtZXU7cTrpFi/61YApx/iqACB8iP7?=
 =?us-ascii?Q?NwLL6CUp38Hy9L1MFf8aYJVTxXDQKExrWLCc06dNIRkJ+sPCVnwcmrhkeBUw?=
 =?us-ascii?Q?BZG1EoihLY63RTCFqr+Vjt5pZ1YtiXgrCDmvamA0O/g3SxVWDtb7+x3y+Aa3?=
 =?us-ascii?Q?APbMcyL9WK9fBWExu5/rGpnmVoVdDgl2axH0BWwgVsKWiUk0QcO6Y8kMTXK/?=
 =?us-ascii?Q?2IdQ5BNer45EoddVwTj/trjSelfqTOIkQKZFVehTaM6JKMwyRvNQpDGqownX?=
 =?us-ascii?Q?2NmfSsdqg4R4y8gS9xQ+AluljjKMeCKJdlcVeyVp3IPBD4iLs2X4RKjEt56Y?=
 =?us-ascii?Q?cb6tTjNuiWdPqgEoiBoF+aRy/eS7xDeUjEmmw3R76hBgFNOnB7n4/uoIKC2d?=
 =?us-ascii?Q?9p26GrkEv+cip4nq1rx0XwKVUlsycK/K+axPL6zM0hxTzamELf0wkoj87z7h?=
 =?us-ascii?Q?SKMGH450mupW7snsHOpQVBAcw8146bAggsDq82CLCAK1jHYnAXdnndzD2cdX?=
 =?us-ascii?Q?33lxVEFAvKKulF2ciFgJH02+TEPjlm0Is0L9HidZUTR1U8pomtbBqKflqFyp?=
 =?us-ascii?Q?giT52gFY6fDl5yZDgvrtPqwFLpeCeNmWJzFJUJKZS/YEQGirqCVhKx5kIB21?=
 =?us-ascii?Q?0BviF2RQlpkSZMurS1nP1+U3LZDqqt64/B9rq//ISjKSQhr9u55c3ZntqF+B?=
 =?us-ascii?Q?JVR3sytP/QDbfEOM+iUlliW6R7+O800wY9MSF0VHwEd0hK7GNoFnIWTNccOp?=
 =?us-ascii?Q?Naq2C2wKHH5qdsMsZIt5niOu0tQCeCRdfoMYw1VVbSTS4FmJjmOw1C21lN66?=
 =?us-ascii?Q?M+/FZ3/RSwyguqjPY2cJgGOx5bLPR+9cZpZrK1Hw4w7+83lMoJB/NyxvCg1z?=
 =?us-ascii?Q?o+z+nbOzb6pEOON1dzliDyH/xj22PpmbNBKUOHOU5Zb3No7EyPokf6vAJSqz?=
 =?us-ascii?Q?qzLO1wuh+rSH1ccbcm21a+8ZsoWh2B2/JhOyMCknlegY5F+7vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ih+1ycZW49fJJlGmsqoTVEvhnehzwB6lUi3m4KhBUu1gWhSboaKuu5kYHpt/?=
 =?us-ascii?Q?6yTewiNdxcpLiXo35pGdsKNd0NCe48oxaHA9a+V75DbXIRoKek4oxZeE1P2h?=
 =?us-ascii?Q?rqzi5Fgz6ySL1NVdV5aq8+LySvy+HgIG/7q8l0WCCaNKeci8l32JUbrCZR0S?=
 =?us-ascii?Q?2/4FFpHW2LcNqgV/XW2vvvnsUpnOt5y5EVwL61lBHtRjSanyd3FNhue4EVzV?=
 =?us-ascii?Q?a0ckkMN2wneLwMVA9yBTtZ3GHOzz7d+4xcQWLKQfupY/wBRdkdda7SiT5HEK?=
 =?us-ascii?Q?UQDOjqVOvCSPwdpcRxFhdKgpAoBRnnB6jt1Iq/iAzRrYaD0zzyCwOzCdgHFZ?=
 =?us-ascii?Q?RdddHnsqmvIioFrb9zCMPwkXmrB51KF1iZGQke5yhf+lM6bj0MNPBzmOOSTY?=
 =?us-ascii?Q?nLh2VOCI0o6bVJ9mayPvGJREsCsn669r3Otde8gRF+SkOws9tHD8gijjCi7Z?=
 =?us-ascii?Q?QK7tTF1nreCBUF9edeGLTQqzDVgBtEh5Ev1bzQFVIhcwmy4x6Jls3FvWt6ll?=
 =?us-ascii?Q?3zqEA3ZX2JyUoKWmWF27XXxiPDj/NFnRUNWIS+dyAMUrHRBK2/ORl+9iPArH?=
 =?us-ascii?Q?Y+H8be3PpqPNYRinOiI4c9mj9+1XcqI9lTb+i0KOA7meNKJEFEsflxzF9Tfu?=
 =?us-ascii?Q?ZdCxTHgys/hnT+uluxv9zd524XYlQoOw3YklvT+XRkN/duuuAJ0O5WUmnFbF?=
 =?us-ascii?Q?ffhPFDYVZJI1kXklZZMSFm/e/0ugCL+ZAQ0O5fQ2VYFcQM5RFZJXIZmxFrqD?=
 =?us-ascii?Q?aJgoaOP8TN3T7MqD1HQiSoza6vYvSUUhpw8/FanMqsPQCwR2az57YTeR9kcF?=
 =?us-ascii?Q?XLxfczV6Q1gXEKPQqXAQkhzBLDWXkezZU9hIAquiPWL0gzOvnpVcEh+4GtkY?=
 =?us-ascii?Q?tekz2/dX/uiqRoyx0KdMhTF7jMpZePKYBCF4fOcTiDoXaHtjRfWuXEWAILQf?=
 =?us-ascii?Q?667pgcu4Y4XyDfJK5HSUCnP8gbTjQBFkWFF4Jq87jNDBznhUK8jKayp5rpkh?=
 =?us-ascii?Q?/dm3aa+6tOkqZ4FqJjxOLuQO4/LsFV/8dotIIhrzq8mIB6ntUQ77+GUOUwQx?=
 =?us-ascii?Q?h6vI75D9NTsGuQo1QpwZ8WLR3oHogoDoCi3YWsGVEWYnj92WFuobwxVE7i9P?=
 =?us-ascii?Q?GXqURF/GvYV/M/XiqLF1vEj2m3lSdJNKE0VxG2Rr8YUKRHuDgm/TVaIxq6fg?=
 =?us-ascii?Q?2lqMZ/FyD1cewASRoCgkcy7Nx4TopGkE1BKkmSWnXB05F0GSuvtg8sWfedh2?=
 =?us-ascii?Q?29mFG2dtF5+bwY7dlx5PEnWQeDXRHYifVrG/5487/03nZIFHg2on7bfgKxaU?=
 =?us-ascii?Q?umt58b2ihJp+i3Q/qdnuutBBHudMVF6VJ/qiWc/EWUyfVF4uu84l3wk6+vvM?=
 =?us-ascii?Q?xuF3q4/iSm9OU5vVyn7GOOV42R08ltdBioHqwOe+n3YxSclV8ykJfJ3iVn5S?=
 =?us-ascii?Q?W1IOPy8VDQHzg2N5B2ZDNl/fjDEKO3Y5+DNLTrtmIgzYBFbEPgmUVfJCwcP1?=
 =?us-ascii?Q?RiZEp9JNmh0QDTHAuzVVGZCl/W/V+Dh2PqxLReU9cDPpHgrrkHlZSI8+MY06?=
 =?us-ascii?Q?Ra3NzaJmiuUF/lAsLTW10mcSr83yGbpxhEC0yY2v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QyXxY3fGNEPgCQhmVfNZ/fBgQx1qQkPRVcuPHqViMIYbQfAlktEWsAGcakyoepYZIigpE/3OdXh0q4TmBgZXTxggvK5DSqEAkXFq8nE/C3AD6VD6V4QglpyfJYxRCEzqCkvCa8gLSU1bsbtJ7TIojinMBCm0P1EJNmmmFyRsWJpdoJclxMPTpYmFYVqmE02zzHi13nw8YXClGbs3NMjCJJAAFbfohhXMVsAAUz+AnSaMQxgwiQ0ds5p8lhPTEkK0Gq6L6Ln0Khkc1Nne7DQwyiJqe4TCPLfsy1Y3I6UWJ7ws5lfb5VNkOC8JaIAMxGMCPaKTXWTxrwX1f6IZaKNtgYrtN0RdbqUvXWtwp0X2qOeAc8NyCFbSulwqYDqE/jT7lWaYIBC823NHfsef1EtmSHMpMmYMC+t1s8mm1ctLjYV/erZrtOLJjbqRp1AAAjVCL5E0JAs/otw5Arh+G7WgpfNlK6jkAAA0ZGRdG4tmi5rnxo7HhbxlxaDEvrWo9D+KTe94Sc7H+809baUD8497DuKxi5GtCsapjEmxUXJtQzgnNIDTuB7DmE+uy2Onta9BmNGXotRfTQqHtZQ7gRGR3x+TFeapD1Uh0CkrUh+9G5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea99cf-2419-476d-ed69-08ddbea2b66e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 04:40:21.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8952FzIp4Ovf8VQJqn3OTsaX8yJeE10PMRZX1sPcklKPSfjbFo0IiYHwvRvzGLq2NTdRE72VqwZMCBMzJai+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAzOCBTYWx0ZWRfXzHeDJvIr1/bl 7krmSR6hCA/4mT5YtylwEMosCFy6YwlG/AKV7/YWzP01mGpLD8Q9Ae01F7pJU+uz1jtYgsk4VDU KA6XP+0xOdjZ4YQG/MC2fkIOrl5vAEtegr+nX4Z45Mygl70U2PqJl40dajyWcqI2BP5KiuKHRdH
 iuY8m+OhjvrgqQAnsThR+TL5iEeXoocf6ci2GGhF9mHHdZiorcGaq0/57hioF3xxvRT2XE4Cdiu iTUZWw0GxyJf1btWY0UrNkkVGUX/P63LXCLqROJhbVUo/QQ2XKK4rTZutCBSnFpc7iCumit+lqv Bv72FsunoP0ayaGOrOCg9BrYVtRhNErjbxCSUVDpaE2xCGHwbJpNByT2Q4tZQQULvJ22E+dRLhM
 OT+ra4fuxOOt2TGZVLP6H1uKqAt/Hx8aBnIBE6lBzKphbCPr8/j7R4CEQJq6BX6v/l1V1dKT
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=686df2b8 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1aLMZdONxn7pKrVZINAA:9
X-Proofpoint-ORIG-GUID: ml0bcl3WoTgDdI36R-bMuT5HWLjQut22
X-Proofpoint-GUID: ml0bcl3WoTgDdI36R-bMuT5HWLjQut22

During testing for shutdown, I found that generic/042 sets a size of
25M, which is too small for btrfs. Setting it to 128M.

wrote 26214400/26214400 bytes at offset 0
25 MiB, 6400 ops; 0.0468 sec (533.618 MiB/sec and 136606.1900 ops/sec)
ERROR: '/mnt/scratch/042.img' is too small to make a usable filesystem
ERROR: minimum size for each btrfs device is 114294784

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/generic/042 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/042 b/tests/generic/042
index ced145dde753..6cd2e7a3703a 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -26,7 +26,7 @@ _crashtest()
 	img=$SCRATCH_MNT/$seq.img
 	mnt=$SCRATCH_MNT/$seq.mnt
 	file=$mnt/file
-	size=$(_small_fs_size_mb 25)M
+	size=$(_small_fs_size_mb 128)M
 
 	# Create an fs on a small, initialized image. The pattern is written to
 	# the image to detect stale data exposure.
-- 
2.50.0


