Return-Path: <linux-btrfs+bounces-5033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024BF8C70E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 06:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADCAB22CED
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 04:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A729CEF;
	Thu, 16 May 2024 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJtlbv++";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iCwziAV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316FD271
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833244; cv=fail; b=ZMtC06QocxRRFzP7yatL58LFWKi9gOBgrK4pZH7LgfA96f3iM5AyaPPe5n3FVrVkS2/ktKRtQa7jHwq8OB8QFCf7T/KoRGvCfgfIR4TSx4hP+l07HKLuQlD9fKUgi0e0DTegBGyW6ZqsiMArefmK6nfnReVfgxn/1CYxz5mex6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833244; c=relaxed/simple;
	bh=iun8f7O3Dx3iIFmOMyrlqNjxb5XlUSdbrd0npbmqqD4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NMYkPnni2LVDiJbq97kSu75tE9NU2rHpG31zS8ThKsh8aGXaQaalS7KyJmU8zNTPFdxq2WF0SE9rc9ERrgSpOBIdUc8rv4ab/kHIRANeAagJ8+PXtvDxQ8g/9VDcm66mFldGciEABf4KY7H6y50vmUen7o+OdUSjZYwj4Mq+5JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJtlbv++; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iCwziAV/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44G0NYe9012892
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DyKyCsfQZzgAkZ//swls/U5z1ku3mGU2o+t1xbJUSMQ=;
 b=bJtlbv++lkdekG6126IaCNeBwYrdijEbzoa0orVLHreD7T62XGRrUkD3m99dXC3fgQEk
 AlBxGXQBddoas+s93QAZm8WkaQpHV/3HlRcwd4qol2TiO19vB0ADNQoSixg9brgS1Tjc
 IrfG6doX/j4wTGOrLtHAF5LD4cqs9xQhlqFxKYkqusqL6d4o4ON3KHH7hJ98HdsJ0Ew5
 qZIzy9Zki3/XNrsPPmJ+Y5HdeB6fllcK+UbDNPMxa6H8cQjXtJCO1NdVl+fPuKTBEULr
 qUyhjJtIND1D8opbk0yV0FV04xZqWrl7zrwZOddFlPW96KSVogqErKKg1g4YeRZOfSFN hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx36a4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:20:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44G45MRo018221
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:20:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4fwe7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 04:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuoypsP/QbS8CmtVEWkjuFyP9JZdCsFQdQZDdJuhom7jXx0YyDwUu6GB61VoeLvIaz6HvHDe32ur4vzOHKQWmd5om8pczSTMl7Q0DdR1MVMWg0Ohk20sqmVrdmRSZBHPxpe6lfCB94Tj3gC7nqovj8QvF+i0N1aytL6cqSS+5HcrhoqZUGQNfAxsjlQyhxHXaeQaaGCcYavwtV8uKT0GmOKr8906teV37TntLoklo99Y/tus/vKbgXrtWh/yfY/uBuZja4Pj9q0XqZJb8WHDccWfEd2vpiL5uefdpRgerrxozfV4JVn2UiKfTe4b0BFVZm8XqNK1rGB5xYvGuoZSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyKyCsfQZzgAkZ//swls/U5z1ku3mGU2o+t1xbJUSMQ=;
 b=TsMoJX+6Z/coM2mRcReVsZMW1IHH1Q++ZDULZ3inXlR5+rqeD0dJ5EMlqo2UBWFS2tUXvRlyOejyXMyssy7xDTidJ7xH9Ju47aFrgRz8OsbF6O2HYqIlg0FvwEzfA698OLrsuk1AYdw3t8v90jHWv140kSxBVPgq6eceLVDLlDJua4GmwJGQ4WzjyGLj+xwg/cyo8cQRUN58nTXbpxb/iVBNn94uN1MWoIT0zpf889qeq+FNbhH5rg8N3NRBw15se3a6I3XHM6PlaT9YRGNbvQ17ADOSWt1l37U/5d3Ziv+iYF+xXwob1+t9U2dx3/KX4sV2kjjmvt1Jo3pFQHxWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyKyCsfQZzgAkZ//swls/U5z1ku3mGU2o+t1xbJUSMQ=;
 b=iCwziAV/t3BRKY7qqkT+WPOt+5d9Zwwnmhe+p50zlDeB7Ve5yeeDLnhw8UCad+Fqntoa7wN8HxkOw/kzjjszOZse40NR2yjxtdBDnkjohtkkB18qCdb/hHUjsdxe+AcKv3rBQIdb4v7yOyF8AyMsn0x1wZHLZ2ZVJxIM59PfFHo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 04:20:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 04:20:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: drop bytenr_orig and fix comment in btrfs_scan_one_device
Date: Thu, 16 May 2024 12:20:13 +0800
Message-ID: <0de852fd1caaf97aadd2ac62bf178c664069ed17.1715833048.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fb6ae9-db12-4f54-8122-08dc755f89be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8AE3IC4yMwTBEfNuSBa8Tc7fwBXKLQX1xIMkJw3iPiPpH98UwXY1QDODY/wO?=
 =?us-ascii?Q?+Nr/EHjSh8AEfe9ibTd6BeUrbQPy8c0ygqZg/nOOnAS9pNUlMIog6LColUeG?=
 =?us-ascii?Q?efcOtMeZYvIcJ43dLEV8+A0sDzkWs5HPTftlWhP/sdoEVomE7t0WsVdX5rYN?=
 =?us-ascii?Q?jz2oz9ReO7XI47bSp/91DAVI0X8AuRM7YNMDGd2+vBXNfV/PE6f6syV82QUC?=
 =?us-ascii?Q?GWdOIklw+FdrWeYDqt3MJdI62uAlpiDf4LedtC7QJIs9w+y0Whfo65QD5yls?=
 =?us-ascii?Q?qE9D9V4o18r0p4eFOiutTHNFjtFXi/gSIlSdW+2kJRc/8GWxD1HVgIYWrT8x?=
 =?us-ascii?Q?3YMZEP88SK7kmdH4EeaNiAMAnPVfxsGfU6LI5dICMhaxiy349aJfDIjLV6Y3?=
 =?us-ascii?Q?+TQKYwWB0YxA6qvci+gvI6Su/cTK3/gftWwERtUj+6HSfrIqBNE2wTvuwUA2?=
 =?us-ascii?Q?XV3+XRwNuBgpK6urCRZEB14Id2U0/5rwjieFgc8U2ryGvx7s3voJ7KG/8y7x?=
 =?us-ascii?Q?iaCqFW7C97q6AO59CdKA9Pe9fu47xcOQdfn/H8M1nHibHXYLJXCRX723AluG?=
 =?us-ascii?Q?vSgaMEJJbx946+/goe39mC/D1OH4S4zL2Yi5qV7cSZgYBtQTjR8BKDNj5eTk?=
 =?us-ascii?Q?b2JrQVk0jDDErCoHmz9Hs8AfMex4PHxuJox164L4gotsZNrszS1UR4Ik+bEa?=
 =?us-ascii?Q?u2r923SLZnWDL4XqmjHJHoPKSRNiHaqd1mlZKJrHT/I4wGS/1kqLkdXrL6TH?=
 =?us-ascii?Q?8YFlFODHeui8kDkNA9jooKbKp12UweSuVbR4+H49jJ7sdZoQS6QtHXmwZZey?=
 =?us-ascii?Q?DB62d7/AYOckG7MU8NZegRsOulvh6Duv8EMXjK1AaUMdmFzJ8EJS0QANgQUI?=
 =?us-ascii?Q?h6mvkMFuEgaCmXHdt8QrNng93RUfmbNq+sFfUnOdu03zNeEaMClZs9SDwgYH?=
 =?us-ascii?Q?mF/lmrVURS0RTiIpvTRbubjzlxWzsyHY9p0B4H3B77I00N1gODHWA0tUAfd5?=
 =?us-ascii?Q?ihqpRPjrUPqGT2lwq4102+8N+hlsN3K6CiJab6wPRuxTZ4zYJzmshO4XFV9n?=
 =?us-ascii?Q?MtujtgsFZhSBGgrX7tmqeINmglP9/7382c0CYYLP/m3tuz8nGpk6l7XLRao3?=
 =?us-ascii?Q?5A3UOp4PGa71uDZrQkEdDeI5FdX6SCMgJnEOHovF5s6FcZwF7Ze+K+eTBNdc?=
 =?us-ascii?Q?VUM3hgHL4zoYi6aWbo0qMKv2AizfyuNXspHqO8Q/Z2TVHF/MCiKxp4DQZnAd?=
 =?us-ascii?Q?oaEUDDpIzSQl+ONFzwhN0zpWlBjeDeGrsF699UUj3A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A8FPrN+1ygvWywSwqsG8QU6v6MmpRvnE5JBNKJ0ArLwb2DEXLXVa6X6JAzb7?=
 =?us-ascii?Q?txQKur9HVfNN5K8VlnJ8RefG2rhlHlu0ECL+rPnrAVvGWots2EGaX0bxyrLc?=
 =?us-ascii?Q?Udl/LOYIjr2ZlCEfL2DyIIjamCU9u4S55qPmQFzOnn6S7Ov1Ky+lgt7NJJVZ?=
 =?us-ascii?Q?cdfi9q7uW8je4EZl4vlSsNMLPFTpcIewb6nlpDmyGoafflv8gUIao3dTJEK/?=
 =?us-ascii?Q?eSHJ5VjKzOpAlsX7SRkW2C01XSwnnK06t0hfUyenia7KelAWDPWtjwa/OXmU?=
 =?us-ascii?Q?LCa037fApwEIx7XgaOHCJ/SjvThdMAbarBod8OmgIYhFuWSvEDvgXKsQD+pf?=
 =?us-ascii?Q?437+hMz2ohLPFc4LkStUpfF5m6G9x3ZPuGqZGIhmZSEXb4oSEFvVAVzYRQqV?=
 =?us-ascii?Q?CUlcJHk8tn1h6Q+1aaPlZ0AEWW4BEUsFkmV/BZkqPsdmvcq1GSqtscLHRzPI?=
 =?us-ascii?Q?+oYip3eJbiZct0UdRxzMJOcF6ukG2JT/eMWdVWU6RFajSNPP1ht7P2+eX2fg?=
 =?us-ascii?Q?XGNf2ytpX+YE0nrEEo/3FDFvT4aKQjmSa7gdvrKL4ncKKs3BHvSTU3D9wKUi?=
 =?us-ascii?Q?Okpplr6wZTCOXWfmYk5ZxQ6YWR8opCvmKCxO6QcoqRPdflV1+NVpkdeQEraC?=
 =?us-ascii?Q?mjx97RurGwgnqXcXKB5AezjlD68BY3wRSrvBPNO2oCXxfbXg+Owxbc1eKyno?=
 =?us-ascii?Q?P8IxIeebG0y4VC5UePxf7T3+RhzQAliCKpcBR0ZrRAjf3dcpe1dFzYPHdzAn?=
 =?us-ascii?Q?gfA/rtPEfZ1Xm1X8u9XHmY/oRelVaKSmmNRapVOvif69qSspxagZpEaRB3Me?=
 =?us-ascii?Q?EDfrBPdW9YSwXzQ6LHsGQMeLp/AbeWjnJvG/WUUxfdQ6VHyz50M/KhdisePF?=
 =?us-ascii?Q?RE1zcztfEsgOAZMOGTCxM6g1PZGShKi9ObVJpOfVG7wqPU0wgCuNz//Sn/7R?=
 =?us-ascii?Q?vRJyYZdhCCplgOuIyJ3ig/l2WJgThbZpKnjT45H14Wbyr0axU/+VdiuEiCK/?=
 =?us-ascii?Q?QX7E9xGPtqff59sVa3QlSykjOM8g2R8+8UU/EHKWf7jHr677gaW62JPe8F15?=
 =?us-ascii?Q?+wifADbBz6rXn4ZsQfWR2uEvBBvtw9QbEHI+ZumGU//mSZJ8Z2LzDTL0l4Gc?=
 =?us-ascii?Q?G/ShjT2sAS0fM3IIozxGmhjBdDQOYH6wmDAUaXgnCkPDW6YDBNO4HZvP+FhE?=
 =?us-ascii?Q?bOrXbxXuqb7Bdp3H88zRrPpFJFJ4u1n5+d5oIch1Di34bmKJ+BVJ+GZP+mFP?=
 =?us-ascii?Q?A0BhGKK9T4e8wEQtn/8YfdJ1TKMpMcAc7QFgrSwwI2dosfClmUIr93ffXj2C?=
 =?us-ascii?Q?Mn3oHOlTEs0V1l5wEimreDrZ+YzYyvnarcszCdT2u6Ub5rX79IUNUYTLaOuV?=
 =?us-ascii?Q?6HxmgXyvKQeH15mZs3J3tJy5TTcMHkBQQ/5HTHucPu9+3+KHibFVYcS7RFqH?=
 =?us-ascii?Q?WwYTZUdGYdjhBVb+dWPosdByFLAgO8JfU3xIf255Q0OrEs2SArUdvFmXcGTp?=
 =?us-ascii?Q?WBREpqSG2SzfzA/avgDqIW2u1orQTPeNSt8PIHyeKhcr+wjhFZTHFe9t2M3M?=
 =?us-ascii?Q?3ETLM1pidz2tf540iCwTpVoAzmbbsGGQfTNnGBLE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q3w/NFGdptTMmzd9ymwl/BIrGVExUSaHTCJQ/8ieflKyofwu+TO+elDvrouNFFR/U7ZFy73EnVyRL6hRgfWBSQrKuJu+dhEPONKL5hy2XU/3CD5RxU5NBSsUa6LOSNZNnLPa1NHaqU4zFth/ybwfbWv/P6lC8t2V9jKF4guu70JzF8IiWKPCttxfkJIi9ZdbHfOsVnXVreB/MDVgzSlQLZ4IyCI7cd7SDgnocHMbISRSEVrJIYnddabpcCASnqdVBe+O7HXPY4folv+3ls+7AkjpENGBGIWh2OGEgmsuHiFUdhNA4XX9pQQ3USiiwKjrO9sO2k4zv7p2xCl3o8iactXzBDPWQbUrWtXzl1NqHVsxJD4AGSV/Wb6IpsjYfB7GpNZCOFmERG/d8PE8QUUk8FKZkC1/R4IYRLrL7Dq1filDrbIiD8ZcbD1f5422hNP5Hjdixocr0I5gK+lNMhSxaqdNvRkJno1dcVKbp4UEW6ejZ720/OYBhj0SehLBnWblTYKupmaLRZeyinZjo4DCIC+qvjl+8UlTVs7SsRXCONFLntDobEYi/Hr8IZw1IASaWS98e2hLhu4uNsf2adrLO1TYS7Vd3rAyG0JOhkGIHzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fb6ae9-db12-4f54-8122-08dc755f89be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 04:20:37.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A5LmtGCzq565t0PF3+xZpJxjPPsFJ14r2seIKTe6r4hLGIBmG/pvAwVhSuRFtptvDTdP1KJGXQcSyHdivc1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160027
X-Proofpoint-GUID: D1Jkg2Po2mcKm5tvCeQL5hyL3LDvMSEU
X-Proofpoint-ORIG-GUID: D1Jkg2Po2mcKm5tvCeQL5hyL3LDvMSEU

Drop the single-use variable bytenr_orig and instead use btrfs_sb_offset()
in the function argument passing.
Fix a stale comment about not automatically fixing a bad primary
superblock from the backup mirror copies. Also, move the comment
closer to where the primary superblock read occurs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 34ba1892c62d..5596c0d054df 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1377,19 +1377,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
-	u64 bytenr, bytenr_orig;
+	u64 bytenr;
 	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
-	/*
-	 * we would like to check all the supers, but that would make
-	 * a btrfs mount succeed after a mkfs from a different FS.
-	 * So, we need to add a special mount option to scan for
-	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
-	 */
-
 	/*
 	 * Avoid an exclusive open here, as the systemd-udev may initiate the
 	 * device scan which may race with the user's mount or mkfs command,
@@ -1404,7 +1397,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	bytenr_orig = btrfs_sb_offset(0);
+	/*
+	 * We would like to check all the supers, but doing so would allow a
+	 * btrfs mount to succeed after a mkfs from a different filesystem.
+	 * Currently, recovery from a bad primary btrfs superblock is done using
+	 * the userspace command btrfs check --super.
+	 */
 	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
 	if (ret) {
 		device = ERR_PTR(ret);
@@ -1412,7 +1410,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	}
 
 	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
-					   bytenr_orig);
+					   btrfs_sb_offset(0));
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
-- 
2.41.0


