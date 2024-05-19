Return-Path: <linux-btrfs+bounces-5092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976D8C931E
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 02:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AA31C20CF9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 00:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C9442C;
	Sun, 19 May 2024 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AqKM3iiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ow9wMLjC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26742376
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716078090; cv=fail; b=JkpbPtFL2vEJpHJAaLVYAobAVT7JqVAhpHD/tXor0WZYUWFs+wvhLw9NIXMJf1BKxbdrdZtUJaoaHZFW+cJJxkZ7n/Wt+ab4sUUMtQljLzDBKkh+hbYr7A6vxOBaXxHUio4i7ndkfDczvrKRjIamwvLH3ebsEBUT1NBlpEZdJbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716078090; c=relaxed/simple;
	bh=/a7yR8AF9aNEeZdDUZabc3fcI6zEd4cR74YNSH18GTk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qtXwvK8KOc8LP471uGk1fUlPXpv8FrAYzdtj3mPnBQ12Sdw0/Azdg9I0ThGdhD5MTjCWzMMogsl/WTvMFukgZ2PvZrjKLWkHKu7w2G6vR7DjQ1QD1SV7T8xWNpRuK8HUBUyLVFfKqYPUzFGxJzahN3+pL6qp3VVrN/sG/iyANYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AqKM3iiZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ow9wMLjC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44INMfdA001336
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 00:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=V0qGYtjlfp5eYr19hU81S62xF2jIFsohGgfSPLntVzY=;
 b=AqKM3iiZwOKvBYb2XTUfMnvaUW2hjEHIHxQzrrBvOBw4CEtj8kUxWm2y3oTxoOFHp325
 qfVMjjzbz8KuYVQ4Bn+WKot7Eo1DIJuErDE9nB3rOf+UdGugiy+W68YD+DelNfHyk3ax
 bBbj+G+9pDB6SK83ZUIuYes9W0i1JM5ZoXxmHzdbxpeL180iTBAv/TOsSa+SxpmFfkR8
 tX85nHLrGqxC77csM6AyuTzeVIVxY9UZ0Hv0qg7pXZ73OE/VG5NCq99BIN5rMNUk6Odw
 lKlnahlCAcaGtbnLEK01SYnYu91hB69RYlAcAxYY4b+d7ZudsTsY3GxT2ZCn3Bskw5zI 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv0q4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 00:21:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44IN0wXx005063
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 00:21:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js4wx43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 00:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0+0IxZYTvCElWgoiexEGHjvVzLLXWJY2fzQsx7MD+PYPxUM6Z1tO1ultpb+y47PMw+ZJ0lUEFFQ7IVAIWVLzSZ+yyUHB27AUAwKwsmi6xRI1jZsloLoWxtpOhue/W4UodyrZmULX3tvqVKO9cebO9MZL+1DAk0N/BZ9DzP/LVWukgRwZymBpH5JLURy9WcK5nW13A8Cc2eM+G09KBfjNW1BrDKzwT2t6JuwYdd4jV1OqEoMS9RKd/4tHkxUd2UHfEUy9UcFWFs+Be4ZA2rZPqC3Lj9AkOB+dCfo2eQ2kIV4lqL5lZKReMfa75WEjYStDAeXMmzDqbBOvNVrwBNIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0qGYtjlfp5eYr19hU81S62xF2jIFsohGgfSPLntVzY=;
 b=N4xrxugxJcQqCYMswrEQnOrKxaIsE/ts0u/KE7abeRRiibGiqFyWPQt50T6Si85QYYg/if/g59PcTtymrW+kqc3IvNhCG867X2p1ruJ5kE9dKEW65mACk0Iz0WsNVoH+Yqeq24gCmgOy3eNP6O1y/l/bHJej8tx1b33+/BvmBnTXHDm2hT0ChOAT6MxyaXev6nN/N7HQr3J5dF+ouDfOf0LG7pacNnYfAzeRsihHGu4QA06KAzDQgjsq917J/ZN/rPor7V5W/XX2nRYhmGfz/GJWL5C2yEu8VP9MJEKKRtxrLsWB6MpZpLjFz0P9v9ANi0mu6mNNxAcE30ssgmN+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0qGYtjlfp5eYr19hU81S62xF2jIFsohGgfSPLntVzY=;
 b=Ow9wMLjC4Yt9TsZU/J6EtXKm+hqeR89WxoBwUCpVK9iQb4yozMb7aDTNeu5IBsOGvSykcB4A3y1BQiPZYE6hIRFJEEk8Eeyzw4ztHZ0Mg6Iaj27nj6UXyLyTs04b5TbFIC1pNt2LmP+kNIV45olmnedKGJN2to1TTVGOfYAbCic=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Sun, 19 May
 2024 00:21:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Sun, 19 May 2024
 00:21:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: move btrfs_block_group_root to block-group.c
Date: Sun, 19 May 2024 08:20:41 +0800
Message-ID: <cab027dd541768375585dc32f14b160abba476c9.1716077975.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb1c2fc-35a5-4384-00c4-08dc77999de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cqUXaVVpxG61zmhjgPn+vaMO6ijDG3+LXBwJDLGX5BYcoxuM+EoaQe88olLS?=
 =?us-ascii?Q?qjEGMiVA5YfMEJKzOpMvH8NIeBXASlWP2OhjoUbM4VqBCuYJLD8GcvKobQ29?=
 =?us-ascii?Q?n31c/Su04tM7dUai/j8A9KpOPXwE9CppT61zL1RhowI6WEXmJbuusQ/y5UVD?=
 =?us-ascii?Q?8eESojhvLdfFTUAuI+JRhdSnOwtm8X/zaYQD4XyJFOS08CqfLyH7hcJu/nTI?=
 =?us-ascii?Q?s0bhhxKhFXRmuvo2l08aRBT8+XLJbfHLaRxIOIIDlx1yuECJDQoGA+5Ns73K?=
 =?us-ascii?Q?tgMvNwpxCRk9EP3kPNyfXSsThsQvpne/qc+XCj04VKgkiTl46niVIrjb97wK?=
 =?us-ascii?Q?F+7Ow6w7imyeAMgcBoelHoj5JMHog9iLsaxl0pxfa48187tk3PSAZuM+gy0/?=
 =?us-ascii?Q?4+3qJwwTE4EUQf1xI8MHBHR7PVHf9VGo9dMXiq1GcV4qzQnUq47PJKWltudZ?=
 =?us-ascii?Q?VA5Qau/xKfNLAPaBHJRG2H2qSKood43bgPghe97F6RhYSdco6T98GGo5ULph?=
 =?us-ascii?Q?XDrQ1eGdqKs2cZYMKqeA3eCVV9+R5uslQyPwGR9aSjcxaL03cMTou5i3R+Er?=
 =?us-ascii?Q?9aHPi3Cw7jzdAaMhjOBU80AcGfvgNHaQTD0RJst2bLvV2Ru/t1FvONml4TNC?=
 =?us-ascii?Q?/bKc6jRyeXDTT8Nu33pz0cyBt3npHI5xOThsF52Pw4qgksNS5E/hg4Y8Q2FZ?=
 =?us-ascii?Q?yoXM3V8t1r1d7FzBNuhVZMBVSvBCU5RriIrzpM4OPPyhwhQbmQ9regv7bG5U?=
 =?us-ascii?Q?qmppdVrYGl1hQF7mhUPpcm6eRKGPFzaR7sf6wHtCMr6sVb+tXIVZpXRgoamz?=
 =?us-ascii?Q?BosWDqmBY0LxAr+jlbLjZ+6c8DN0+3dFwqhKDN2z+42G4LBSdDT0y3TJhhOj?=
 =?us-ascii?Q?V4jTOodUbgTGFgjQSeo6SweG6gTEwS2dZAzyZPpjAvX3YbwypJe6fZ44Si1G?=
 =?us-ascii?Q?6mpBOaTpIT333aK9tgkLgAyKAhhZOTq4XklNkLhKJh4XA83Qxvii6ooaM3Gq?=
 =?us-ascii?Q?otXQe6PVzChJlIU7DT134X8y6z4GS8+G9HG8YBJgnLOrf52inm8peVxFDui7?=
 =?us-ascii?Q?XlNHwbJxVkfOScoRwrIaZJvOrU8iYy5Sq+8goLwCrJH5I8fJ2uEkpNMITtB5?=
 =?us-ascii?Q?Z9G72wcS8Z+JPXZeGRoOCSjOoUboZKEDj7MJeYOfLwBgwN2ELZRmkMe7xfT6?=
 =?us-ascii?Q?pfwzExsLn26iRkR5V7X/dEP6pNKuDupkopsKjdxzz6cCwYVRK+Sv7EpXHqia?=
 =?us-ascii?Q?dvJNREvDMGKQhS/Jiz4idAZ0KofyLak5XglOFyMTdQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UVC15epOBf5WnDMRgNRzEwXxAglegGlS1tT8QzRErtGK8NbpjBbqK1WUs9WA?=
 =?us-ascii?Q?pF/1ZnNETMDnZn3RtHCO/DwQ+PchY/wRAlnwC9JXYrYFqjzjcEzFpN+CX1q5?=
 =?us-ascii?Q?2UjgzKLM1OeoheWQNwKGLGgkxjRna1oRz7Oj8aQBMSEkoVW5XMukz0HFqvUq?=
 =?us-ascii?Q?7T6JqIYkDm0gZngrTlrq8AI1CZuBhX3I2/UDksRuAaflCiO4Bz0ApxGvFPG9?=
 =?us-ascii?Q?NAK2OaFhnrzeRZY7QiszVbhG5uooi9eKmAaRjXT7evYIvT0Dufrwx114KKIN?=
 =?us-ascii?Q?ZHehnSk/LA1+/iPAqCnaul4V5XV7sk/Gq7iOIV1goleTrFgJGBbeQN8IeL0G?=
 =?us-ascii?Q?18/jcA3TOhEoC7LMPp8so5aQnzMVlXiqJao6K3/FBunVvCQC9kOD6N8GuoA8?=
 =?us-ascii?Q?ddNZjzcIvMw3gXFBui+yLg3R1GYuNlFL/m9IvQNoTdRN3APYdtXLjzKlpfEk?=
 =?us-ascii?Q?DQxIhDdnJEEwZyaVFo0eIYyZUJs4ca/3OZmQvyWxElBSmknVAxSTtLr9qh51?=
 =?us-ascii?Q?R/vwrPKDcU+t6Dgij17K1WjzvnwReK3vY3cxYmwkMcMLeIBAeT0Lu1WxGBSd?=
 =?us-ascii?Q?foMdsW+9IpT5Ndkg4RHmCr5LJ+cs706SVKI9wztWUTz3NaFxUF0/ANFlZmwm?=
 =?us-ascii?Q?UeydEtfTdvq7+LFr5oIQG9JJ68gplTxHXLKsjZ+PtufwtRTKKNmbf0m6Bcav?=
 =?us-ascii?Q?LCfB1HJir5HxkYJIvhtGiMVQVksnaT3iiXbUxkooyI4vVNQ111FXVFhq9oJB?=
 =?us-ascii?Q?KxKKW2bnN3/HmVgjbs25Sj+BcDQz29X9aFrQ2dlakbIWduxaTJAam3zulGiX?=
 =?us-ascii?Q?/yJxg0f5mJqIa8mdWyYo6TGFrdtcpEHDUFhSMFTNM80YabUjvOiYX6/2PcCv?=
 =?us-ascii?Q?5eE7nU/EpQxFV5k8zHOIhr8rUaH8AmryO7dotirAYj1559IOAheFOOLoN17K?=
 =?us-ascii?Q?YicVu0sebTiWrU5QScbKFMJbCCN+FPt+SR8cu92Vz9DQFUSkcIn0JAY7ggJ+?=
 =?us-ascii?Q?Z5AGuDsocNSmvhdD73DkQt0gUynEb12Tjj8aGmlWg7Z7J4/zYiSsUWGs0G6k?=
 =?us-ascii?Q?DFGdMUDs/o4urTjNmiM+G+IjOY4ZIoKr92LaxFX0XCdeKiWK3XijFb8qFa6U?=
 =?us-ascii?Q?sXeZChMQtMj3LPJ0vUNM6s/kpXTt3tfnYLcJ+bNnpak0Pt6L9CiYI8gM8KyA?=
 =?us-ascii?Q?h0J3PXGB4TD+1wAxsbANZ9oIs7F6uH78q7JgGUbgAiyZuw4YjeuoJJHmJ74P?=
 =?us-ascii?Q?tTlkwtDCKzy/V5P1cTb1bPPPlNnBDtgYEWwgrTu3bG+pwlLUrS5JRULfNs0s?=
 =?us-ascii?Q?1TwcJglZEEJ+v4a54JASHW1NFMAE3dihvFqWMtwWAyff42PoiL7VFPN4MgmG?=
 =?us-ascii?Q?rGpP4XT52P1ZQr8uSvnafUygzSL47214qXFhdPZSKjoTGho1q15jddWpre/q?=
 =?us-ascii?Q?K5ZvjRNm7+Hgwt2X7wZgAD/erf5yZYZu9byXwOrs2SBS0KnXxe/1eEtqSJKH?=
 =?us-ascii?Q?1kXIAamGZT2ToBgpq7WcCt9DYfxbSoSVFdKZ4j7OrbPdoJIa1sCugiSN+VXG?=
 =?us-ascii?Q?SyUjedrETJF1udx92PHoK0VF1Z2ERcet89Rd1oRlVnsoYFa+fqw+asdddds/?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bnn3ezG6qGLsKOoasprQ/j7KQhmprifI/PJNTIi16g03t7GtaKllliLDzL2n2bdDg6hTZWAniqfUhRT26LvLholcwYaK5F8xHVThalqJYd3Q+lkoTHDCRrX8K62kOB/VuzJaO6Gb9jNya2HDVGSYLQvLjGv7xZFM+oklAPGJ7mksGl/9SbM8PUvQZaBAXc23pfa/59qI8PUZfWIEXpzWoLyN3lmlBlRFdmZhYLYkgQISK6156sh8SwxtQus/QxiZKNpBHhXSlDuOWZwNOM+fcwiolZh36rrGY64mTbtGNp7pH05wmYiBVCmeHUiFYOWGxYBrAFagvJHOQUS9MslmE4aO0TMXeb4qJn7MfQcp9xwzLho6A2UFmfGi5kl4Jllk8trUJalZNNRtWouYcpCB+HkkNN4ZSdwS/kXSg1xwTzCpd8va7uYPU9We2zH5ZNz9rHYiGhoufJXS0yLiZAi6eE3XDwlsfhAWrPXWOB46Gf54LXQnf69FynGVPotK6vOheycfDlvLien62v7eVft2VYGdYLzHqk9V/jwpuv/UEvahYl+OiiwPMQO4FE1kY002/NXoJgpESG8RGOFb2NkRggoxALh1n5habsK0uU4trNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb1c2fc-35a5-4384-00c4-08dc77999de5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 00:21:24.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtAKR4FkpQ4PBaYsy7qNrPvLwzLKDmCOr/vdcCRK5bF1FiLi8MRxY9ipw3teukbbES00gP4C4iiF+avriMPCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405190001
X-Proofpoint-GUID: 0q7CziL8PR7FGPE4bVRrUbgDtL3Wkea0
X-Proofpoint-ORIG-GUID: 0q7CziL8PR7FGPE4bVRrUbgDtL3Wkea0

The function btrfs_block_group_root() is declared in disk-io.c; however,
all its callers are in block-group.c. Move it to the latter file and
declare it static.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 fs/btrfs/disk-io.c     | 7 -------
 fs/btrfs/disk-io.h     | 1 -
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1e09aeea69c2..9910bae89966 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1022,6 +1022,13 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 	}
 }
 
+static struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
+		return fs_info->block_group_root;
+	return btrfs_extent_root(fs_info, 0);
+}
+
 static int remove_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_path *path,
 				   struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e6bf895b3547..94b95836f61f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -846,13 +846,6 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return btrfs_global_root(fs_info, &key);
 }
 
-struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
-{
-	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
-		return fs_info->block_group_root;
-	return btrfs_extent_root(fs_info, 0);
-}
-
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 76eb53fe7a11..1f93feae1872 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -83,7 +83,6 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr);
-struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
-- 
2.41.0


