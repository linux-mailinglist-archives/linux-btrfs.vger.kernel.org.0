Return-Path: <linux-btrfs+bounces-8839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB715999AB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190CF1C23ACE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85E1F470D;
	Fri, 11 Oct 2024 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cs5+Yko/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BWI5hxgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6D1F8F1A
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728615002; cv=fail; b=CML0mTex1g35mX9yH+b7cxjuhosK2seqb4LGG/f4Srbooyiyy6eFYgdBL9GL5sPbMJ30GusYW3D+7FZCjt7BfUuw5o1j7nS89nYByYxhsFCWKUoXHH9btlVRyTcAhrB8Mi21KU5BTgjH65XBe5G5Im0g/idxZR+W0HPDRYQbh8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728615002; c=relaxed/simple;
	bh=TY9hOvKIwNu5+ajylBS5FShEOkdBlfS/qoToplKJQhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyI8nWracAqSaLWTMIbeqVXkQ2JmB3s0OuCwrZExhpCzaKHcmehxkhhHlKOHsJLB9mYrs+VaB1AamAx79HF9B1DeRbhkp13plp11aQJvYDX9S9s+jDV70vlQrBNNTrQ5yzlcW7fD+RyJnzI//Tpmm8rsFrFBr75X7UqY1tCP28E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cs5+Yko/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BWI5hxgH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtc76009430;
	Fri, 11 Oct 2024 02:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Csd5xkYD6/LTkMznQoTXWhWX0BOD5yqTfb0Rti2K38=; b=
	Cs5+Yko/UmcJe+wZfruZZPaMZDvJVFEr5qIyscbrH+FBLECEI5kTairqH+SME+c7
	olNXUH7ju6GIhsD6d29a1hRxdPd99w8TuCkWy3LrA5v/Ph9iZmDCHLt9mK1+R9y+
	680LXh6UzIy/TeXEBfpZKtxxVOiAlPTH8h0jXdIukmRxXOoZS7Pzcn5uOl5oKhpu
	1AbWsxcdWw5AEJNu78NIs+88VtO9hNaLpo417iivA28dIgr74juNL0Yl7MbP3ox7
	zGtH8MI/7Mu78KHTKHvvTwYO5L8pbF80vknaS+0DIFH9Bf8buBAUpQOODNM8Hj63
	0dvkrujN7r2Lma/eCAms5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306em328-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANUPiU017122;
	Fri, 11 Oct 2024 02:49:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwh5y81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPnz5s+7WKsOXwGzhiF2iWVdCq1+9UpRqfaX3wsE8DRYAfBWKYxf512kuQrveDu5fscJz5QeJQ3T8cSm6xSMcdHJ9flw/rWNPj6nRVGHWNN4YrtVFxdgDx8RyC+156Ac93+66M3WXuVU00c9+XROQnE26f0tfzPRnyDm1Ir7cRi9k1Hj3J6E1GPsN9f0l0pCbHjFsVEqBSKR78PUMhzii4mwp0jfyZpcRirIKuRdWtswtvXa6n9rELxrIbOrCu60yPAhhuMjh2W6PamzQwGv02118hDTouKjfwcDo1v43sWTlpIofOwL5PYW9YoYmzXZbYgFhm2Al/qd4vcT9bpSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Csd5xkYD6/LTkMznQoTXWhWX0BOD5yqTfb0Rti2K38=;
 b=HO8o62L6Ic5bkPJ+bxUZfSncMgt63fS4YqVc5o0vwG+eaC9lWkfmzk5RWW7ZlvH+dk55rD8019qEO5We0fzSqRUYz2aI4dhtp/jv1uq2Hon9uI3NIc1pH2sGaudi1gt+aXm8fB/wJPfPQRQ7XY098yMNn4ZyhgiqR0ceNi214dhyMm7+7YMRv6VMs9RbOkRqbcFbhjUl63F7MqVh+bWO88xR8y682n9zBqjYPALdllao7YwoVbebCiUHQUfFTZgzP/GT/cY+dOpem3mS6mLbuArhkURjcE8sTQS118Fe7OwIOD525EvAAIfffHgy2BvNAaTbHbg4QQC7i02Sg0Ihew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Csd5xkYD6/LTkMznQoTXWhWX0BOD5yqTfb0Rti2K38=;
 b=BWI5hxgHsnEzok3vlrw7GW+6k+JXicgsy4OkqP1qd20MPefkNZ89aQY5cb+dpdJBx4wVLXoWccUMYRaiWXVcdekysBvPyPYBijgNxXJl/fvIr/kUYd17XY771d8eiclhcF3AgILHFsOTL9EZJeg/F//j7f6qlfG2fupqtWLaVns=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6870.namprd10.prod.outlook.com (2603:10b6:8:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 02:49:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 02:49:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v2 3/3] btrfs: add RAID1 preferred read device
Date: Fri, 11 Oct 2024 10:49:18 +0800
Message-ID: <8152126f6388d65a4a01f785caddefb796d671c2.1728608421.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
References: <cover.1728608421.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1451ccee-6e39-4c65-0b44-08dce99f5bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pL0mWZHKa+vB1YuPLTIN74Exw4T58+82Bgt/4gv4z9hXgHlfWziDmKKofyVj?=
 =?us-ascii?Q?8am7GH35K45ocpzZUZZOUfkutaDdE/8JCUpaN00mKvYf8S/DfBNzyY8+2Vpo?=
 =?us-ascii?Q?UhVcK9dhnZHuIQRpJ+MwrgkQ/D+q/qjsflNWdi6nz4KbQdASVbp5BorHMhFz?=
 =?us-ascii?Q?fgBgrXJNm8z+EMbM30Y+8N8wBf0RsnS9SRZ/jeIGaZSj4BPMwTSY8taiPecz?=
 =?us-ascii?Q?kMJ/vPOFfkl06hs+KEoV0zhtw9B/G3iqI1HR3/QQjVxbyZrzWY9PU43P6dNc?=
 =?us-ascii?Q?ycc8ZlX2NRRFb/8Cif5LznwvUxLfqJwUyNi9uZDfVUqEhYliHqt52YH/6nwC?=
 =?us-ascii?Q?5b6Y6xVYtFl2ca46rH+MmFv3N0nTy6I88SUqfiCmuNqySD/GSCEWN1j9E+s1?=
 =?us-ascii?Q?9zpqXu9VU+ahg5DJSOYNKyKGzhuZaTZnhsvexYckJq6V0mKlIvjZb7FN6QFU?=
 =?us-ascii?Q?kP1q/m3goSf/bOouHsIWpWZYVsojOFgs1UnvFWP054yP1pjHVNRUusaZLIzq?=
 =?us-ascii?Q?BDuxUAwItOdcgzJcpXIkA7Fs3OJvMC4sM9LzEhoe2MsR4CWPAvHJzidKl34G?=
 =?us-ascii?Q?9Wvgb5LFf0WQvddDUcWEl+yiajZuXn5Z++HNmqMSLKjhdM2eTaDm4kX6BseM?=
 =?us-ascii?Q?vKUeFvB61UjeYS6fYEDP4Rd37CNcRlHRd4EFFXHwDZFdJuLPM3Ef4TPbnn0r?=
 =?us-ascii?Q?u3QtIeDmBvUSunEnk390xK1nUqj4oNlOoPzdkwaD1ZJq4R7Z7JKIIE1ytR8x?=
 =?us-ascii?Q?J+ElJCIpDc8XF8CVokj3iznyQd77WKh9wT6LYIwaipOH9tAMrDFXPyGpYEqX?=
 =?us-ascii?Q?ASpLUarCIYXoszH/qbSNF9BxOkD3GfJP6RfSA/Ls8s9+D+nFIZBZsXAdix/3?=
 =?us-ascii?Q?ZoheOWtyVAM6OYox9WBY/jN/TOC+0V0Nai/JTYkXkSl/7y7iQd0TcSJIllJf?=
 =?us-ascii?Q?ux+jGexM2zfLRqRTjMfC3ozeWyrinGSWRaX3xEIHSXmnoEX17A93/SzVYvOL?=
 =?us-ascii?Q?9xRNh8rbRm3DRs+YPlsvOILvWK2T0HUxbwMYUbukKY0bcOGtqutFQ2ookWEn?=
 =?us-ascii?Q?K1tDfCG0mdakjV5LNvMIhBEayGbuXybZzWJWhXcRtR1Oj1yoqs0jk1kmS4Td?=
 =?us-ascii?Q?yw2uaVoZW0sg917pHLtQfdNseClwiKN/sMDPRcHhW0HPBv6+WXDFhqFQgrFF?=
 =?us-ascii?Q?lynC7+ocMmCtJNAHzUd19wd/kYMX0KKtP/oU/LYk5zxOAGAjXUFLsWCyQgFb?=
 =?us-ascii?Q?+LZ3O9VY6XnM7DY1UKAUxC49Od27bwtnpvpfM7HEdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTHnt7wFCIY22lwq8+diAlPcTujGnTTBw2fGRVppMEOYDADS7IU0WAGa3pIU?=
 =?us-ascii?Q?H6wZ3IRa2HMoYj0kYqyxLe0NOaCvxzo03dNtpwPcb/yioPKbsKikrLT89sYS?=
 =?us-ascii?Q?WP2oXxYNtZyZ0Ap5E59+kidXNWeufBj/Ztg5RVc8U6+ZzshP8GOOZE3eEFBl?=
 =?us-ascii?Q?uIHsWJaBoIKW14oiaSXRvGALtSX3fuVmXDkKucJ8/Ecc24BOzP7thSz9mBy/?=
 =?us-ascii?Q?od/JJidN/Fbk8wWUGm4o5U63B2HZuUTedmCM+HcagqrsajxDCWGvlDRz4GCw?=
 =?us-ascii?Q?waUx1t7j62F6Q5CqJ+RMu1emSNlSLJt14HG8VLpF0h7Dumgx2xJGXScTOBTs?=
 =?us-ascii?Q?LHkXkhSuqJxtwloZCrXJKaSLdmUTTjSV+vdH7TlcIZoBuB1cU3zZaaRPkjHp?=
 =?us-ascii?Q?aUTSTCU00K3YvpQcQDb9EUEMnC9IF4NEZHVuUwLhnMdP+Ki2P3OnloagVt/U?=
 =?us-ascii?Q?hCkf17u7gkWUnfsobmsVZR+Z3+0rBawNC8kvynZRljMmDAECKvcUvCzEXJNp?=
 =?us-ascii?Q?wlH6Bc7Pt3JIucYAxrouYan6S2WRJP/ftp86x9H7atrCC+bPq8Jow6F+IT0i?=
 =?us-ascii?Q?PqZGO1pq+DmL2QIjKBTt2bVKxJZ9sHuYpvXN7eLcq0YUlVa/015X7nzA2Re1?=
 =?us-ascii?Q?9LizncpwlZuKiV1CQUP03B8Ed0AAG3EbAdh6wm0p1iy7G0B3tkV6Q6OYLWkn?=
 =?us-ascii?Q?pddLdue+2xmJdJ+tnWGm3cD1hLw2eHNnveQlNB9D0N8J4eqvF6h2vakarOZ/?=
 =?us-ascii?Q?qm47bBaWEhboxDme9PYerGuDHjq8GKgc55Pn2u3NzBt+c4abj4PLH/lAZdBF?=
 =?us-ascii?Q?wv8+O9Tl2ftk+dUFFKTDj7CMf86OvN7d3RVpStUIlPCkJfGZfoDnnF4sB/za?=
 =?us-ascii?Q?cCwkrfDmC1RSN5nmaQsURI6WK0WjjYAIVKTOyuXgt+xCdRN1IYK5ES3GI5H4?=
 =?us-ascii?Q?opGP8zTKjK+wSybRrYlZgNXmWATSfdSriNjpM7H6Vn+05FTeDX3rDKbS+r1Z?=
 =?us-ascii?Q?m6mghA4a5FrlYSkyXfhLY4rhLbELe7a9mfsnAjccy0lMQas/vAz7dLd0XjJB?=
 =?us-ascii?Q?3DCpG5165siuNoffZSxi+mg112hve8sKHiHjR1G7F8TSCrNZRKpOMYa0w5pR?=
 =?us-ascii?Q?latbVrp7tBFOs1CxY1vizSV8FOQLJ6CecDCQp+6EE4IVSaMqicPuLOE/8LwW?=
 =?us-ascii?Q?3q5LvK6bIGNcuedKp4vMob0XzicIDOCsZRS9/ZgaOzezA/8ocYv5HEBJog2G?=
 =?us-ascii?Q?TGrHex+hrEW4hDoL92xRDEJvTH3A+I7l1b0+UVuX/ROn47b/ItYX0p6BoVWS?=
 =?us-ascii?Q?f+i7qhMbdpbL86HnlvQxktyHUL8efAgc/Hh+qQKOUw/4CSVmhQSQDnF14CDR?=
 =?us-ascii?Q?37NhaGOhWHqB0DWwUkecSe/q7Jdctxsv5UOFhC1C0XTxkBHGatJK8kORs711?=
 =?us-ascii?Q?m8Y9ZKUp3PGSLcO+SNsU1y3gUc+V42Q3krmtj1qcHI49Q2p5tnPPer8LOW7/?=
 =?us-ascii?Q?os0LAXD9Q1EjleI8qrgk/VC8aFvQbWu3OZ0Y9y7zUIj/8Ee9w0C1DWFJGM5+?=
 =?us-ascii?Q?b/KgPXb/Op2jdb4kU5YBNqqATE3ss7tLir1NBoZn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mKeNifYkWvyJpdIprbl/PQWlrGMAHZeVq/ZAj0D5p5ZVEbn+GzP3GiF1uXwrlj0e84FkXzgzx/gjB225cLNf0kQ1o34nWY1Z+wcCyY2AhZObIr3h+GTYk8g3KaiBXOcvUCuyCys5sHxdAJIVv/Qqv9/0bfadgGcPrWEtt6fHQE6E6BXzZOR3xNuChZBRdEqf2m/Pgt5RAbzqOgCihfo0RVw3EvyR2IGwDM16SRJWfYnUR5MpDyse/rj57Sbr5vYIXdYXXRAbCzrk0PgTfsfmsHxFkA98pjUhRLWjolbnnztN5fKuJwNp+ye9wSjy1xUi6cNLWU1U8+8EDEYJomgTat/FmW6JeK7FUJIvkbDH5p4dSwyqRJma5Fb5FEAg+p3DcJA7xs2421ab0xYWLAWvx6OK/AwPljnis+BjwaxUeNvXTKsuY+ZAydodP+6sG191RHLe0+ORmLrZf1gxcVpI5+TgTXzCcoiasU68FeRdrcVVzfTW9/W1NMAJ+LHKNf1r6t7Mdjug+On3j34fuBa96mBg2VM7z6kv3araFeqZm8LXx9ia/oGUWeakLf6cEVfMbHCGCqghzM5pu6433Okkbd1gHM0TIqNS4udqqQKzPcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1451ccee-6e39-4c65-0b44-08dce99f5bcf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 02:49:43.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWGooqZuYLDlUcF8u4c8P9X8Xpt0iVbLrcrv0XDyO3vxRePiqrvOS1Mf0FkQyizZFt06G+AKioExqPlmR6tcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110015
X-Proofpoint-GUID: egOULLLRdkkev-3pwfce8vyzjYGBKXxX
X-Proofpoint-ORIG-GUID: egOULLLRdkkev-3pwfce8vyzjYGBKXxX

When there's stale data on a mirrored device, this feature lets you choose
which device to read from. Mainly used for testing.

echo "devid:2" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/sysfs.c   | 32 ++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.c | 20 ++++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b157f407e0a..0e7b29282136 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3322,6 +3322,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->sectorsize = sectorsize;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_info->fs_devices->min_contiguous_read = sectorsize;
+	fs_info->fs_devices->read_devid = fs_info->fs_devices->latest_dev->devid;
 #endif
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9f506d46a94c..aa4c9cbaa61f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency" };
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency", "devid" };
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
@@ -1332,8 +1332,11 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 		if (i == BTRFS_READ_POLICY_ROTATION)
 			ret += sysfs_emit_at(buf, ret, ":%d",
 					     fs_devices->min_contiguous_read);
-#endif
 
+		if (i == BTRFS_READ_POLICY_DEVID)
+			ret += sysfs_emit_at(buf, ret, ":%llu",
+							fs_devices->read_devid);
+#endif
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1401,7 +1404,32 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 		return len;
 	}
+
+	if (index == BTRFS_READ_POLICY_DEVID) {
+		u64 value_devid;
+		BTRFS_DEV_LOOKUP_ARGS(args);
+
+		if (value == NULL || kstrtou64(value, 10, &value_devid))
+			return -EINVAL;
+
+		args.devid = value_devid;
+		if (btrfs_find_device(fs_devices, &args) == NULL)
+			return -EINVAL;
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    (value_devid != READ_ONCE(fs_devices->read_devid))) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->read_devid, value_devid);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%llu'",
+				   btrfs_read_policy_name[index], value_devid);
+
+		}
+
+		return len;
+	}
 #endif
+
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
 		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8912ee1d8b54..87a072fa9be4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5966,6 +5966,23 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 }
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_read_preferred(struct btrfs_chunk_map *map, int first,
+				int num_stripe)
+{
+	int last = first + num_stripe;
+	int stripe_index;
+
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		struct btrfs_device *device = map->stripes[stripe_index].dev;
+
+		if (device->devid == READ_ONCE(device->fs_devices->read_devid))
+			return stripe_index;
+	}
+
+	/* If no read-preferred device, use first stripe */
+	return first;
+}
+
 static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_chunk_map *map, int first,
 			     int num_stripe)
@@ -6079,6 +6096,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		preferred_mirror = btrfs_best_stripe(fs_info, map, first,
 								num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVID:
+		preferred_mirror = btrfs_read_preferred(map, first, num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f9c744b87b61..b5ade9d41fe7 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -308,6 +308,8 @@ enum btrfs_read_policy {
 	BTRFS_READ_POLICY_ROTATION,
 	/* Use the lowest-latency device dynamically */
 	BTRFS_READ_POLICY_LATENCY,
+	/* Read from the specific device */
+	BTRFS_READ_POLICY_DEVID,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
@@ -442,6 +444,9 @@ struct btrfs_fs_devices {
 	/* Min contiguous reads before switching to next device. */
 	int min_contiguous_read;
 
+	/* Device to be used for reading in case of RAID1. */
+	u64 read_devid;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.1


