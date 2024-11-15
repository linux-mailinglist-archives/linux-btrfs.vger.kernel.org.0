Return-Path: <linux-btrfs+bounces-9698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595099CE93A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F831B324BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A41D47DC;
	Fri, 15 Nov 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nBx/C8vB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EMm24QNm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D61D4352
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682520; cv=fail; b=DuFRTz4vtCMoQiNbYxZzKSiH7ISwwI+sfuXcNirPEUP7X4Fy1tAXQ/lcypb7cq3cxOio+VFgrVRcnHDuMWyOXMxCdp1rOa1+7Ox/UCIbIp0qK++3td6+d3S8Bg8/3Cn6cyQpmPvfghsB1/xSG+gIBcBKgzBTSLxrN8dGCp7Brj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682520; c=relaxed/simple;
	bh=uqgKBbMbaiP+EC54pDdaY0tTseyJ4r60NA9N+yh9RjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAaJI3sx23reEvd4TOSb9CY8cBZXxKSiT2WISZilRT5mLu59yZ/Q3s9M8EtgmCqrAhSALJQGeHy/yKFdC0ZTyYQ31EmHeVZGEvmkf6bJIYx9jrqwV0R2Vw8Mzg+E17WTiDi0S+HjUQwlDnS9SkFmJlyrK5fU9mZOlyLyn6eg4/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nBx/C8vB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EMm24QNm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDfUF032164;
	Fri, 15 Nov 2024 14:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HCejvsq6TaO1hWg/sI8WCCAvubtrapNoTeCBQFJ1Nv4=; b=
	nBx/C8vB3L7yTTnRY/yT/NUXZ/A2gGULA5ug4EsJnt8q0fMjIEaL9Y64EFH2NYmv
	OMs7+tNk/rWBaBJTuIjObr6+uYSh6BVRWZRH69gFarpd/4mNO81qL8AOMr6uayH1
	S3hkN5jJaxaY1b3pqCIjt7qsFIh2g84GR0RDocHxUMenVQvNVmEzpF+CSRRa9tPQ
	h6O/e9rDCixNRdTJGZWf938EiEWZBW+g2sbSgK71R/KxOEN7C7KFck8mBpa5H3Fd
	8lWIMBSX2uXc+o75EoVj+Pj1xaEWFBHq/0mwPlXs2qEbe/+YTN+P1iQ0NmebVJh6
	ujxHVm2OhyBF5Ha6ypAAKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heue52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDnN5005705;
	Fri, 15 Nov 2024 14:55:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6crfkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9BCpN9lppHw3MDjSzwH/llnHU2t8iz6ZN7lZWAhgb50qILnkU0OcHrbY49z09oZD5EodWqyQr5cM0W/oTw1FP0FbWl27j4Ml6M2Vx/QeYv34wfmpcSP2gWrb4lnnJi8LrWEXie0YzhAXR7bAmtALHYOurz0Tr/6kWO4oQcOzuMgJ5pXZfH7XhsTaCkwgRIz4uSmHFD9qC0keZTOJJTcXr3/q9EEJR4I6mZB5J5iYh0W5rCIaiAo7IKiemSdrZqyQR+7e0I3Os7aeYbzZ/LFvuzDrES/G7OdDJPKAMByba7eV1qDQ2l1rd+Dvhtn8Cl2Qqz5ObfUuRtVUfSr4/t+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCejvsq6TaO1hWg/sI8WCCAvubtrapNoTeCBQFJ1Nv4=;
 b=cB5hA1WCN7L0YWsxdadS6fegtd7UWNqxJc4QZZjOzJO0kIfNjUXR0wS3thxxinALtElhGN7RLgl9fFIr27wO27EgcuMgelJ08XZ+rit6ll/3ayX1OZuBKT/6cdwl74XCdvk6upDRZWjifc0RM51eRiMQCpKKprcIo1gFAK/9yYVoQQAgUYNvslrqTJZrM6lreqYInt2fg2aAj5n71gz1o1WNxyABBOjAlWgo8/iUeuyL2WjbAyZ6OkiLmoEu3GoICScHPj8ExvxA8tNpDb2c+ikSY1qtSohMQm9AVHr+o6teKxhi9VOsHYf6JMIQRi6Yju1U7zPM6HQyXK9/vM9lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCejvsq6TaO1hWg/sI8WCCAvubtrapNoTeCBQFJ1Nv4=;
 b=EMm24QNmKCkOlcIQraTvfGvsYVhm3DoSFDqvC5ovwjtO/xSk0FQ2S6XuoBngEI+9ClbjNDXV9oKpmnsN3WBAEKx0+9w9M+BaZ6h54BeHR7io98wUdapxyqaszGo4/KIc9J0C9ZEOtY6dGYkKP6o8T+NMYHWRE5YMXJxBtgAftiQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:55:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:55:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 07/10] btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
Date: Fri, 15 Nov 2024 22:54:07 +0800
Message-ID: <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: ab24e9f9-1379-4b8d-e6a4-08dd05857d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXU4xCJ5rb8YpuwMFDfM0brXTjl6ZovCC5N5MQrk9DCQz1EQqgtvOyJqpAQU?=
 =?us-ascii?Q?FbKJeX3GQmiGTRaKXi/VsRq2Q+d129vAhbJ6735uEeuX4Dj1FEZ/sEJgCDP5?=
 =?us-ascii?Q?N78dZQPybApIZrZsIpD/S+S51rT9ATVzv0xuCFcHca1OfvOIW05YRZ4kChXX?=
 =?us-ascii?Q?rF7ImOdYcYEfOQKLkiMOGUbaR+mFdZF7xIyf2wJnh9BHiPBu+MGHeth5z8Su?=
 =?us-ascii?Q?3O0UrnGZUaMfkRStjTRAHo4w/ToYSS4vNrGBMoBL7VYQ1dLobCJOelyj3QFf?=
 =?us-ascii?Q?sHM4JSvGmMpOVvRYVzFx3eUllCBh9HJ5dx25gkz7ffL4iEhfC4zP+uzLwbR3?=
 =?us-ascii?Q?wmf2n4A3WU+pas3D21V3v9YrdULzOjBzDZXEEZlvy5n2Qbt1SMt0PFT/jGO+?=
 =?us-ascii?Q?O+lfYoTr+BnxyfRaaet9hY8nkVsYmPHHqpEIIcwRXWeufRujLOAOreomQJGB?=
 =?us-ascii?Q?9K98zG0aGZxjmzXlooowYXPOWZhHaNME4lR8k98OEGtj143y2gWDymLsqUU5?=
 =?us-ascii?Q?O8qo2UFDSLe5+QBmsN5bIqprJd+0jip93sVRScFgR4kUpPL3Mkq+LtsDOs3Z?=
 =?us-ascii?Q?QCCwVAnDLEzjmH3lwutjhp2dWrLun2CHfEtyMfjyz8uxxopFPrZGxCzZgf79?=
 =?us-ascii?Q?H7IG5dSvi/ZjXcOdEMp8sJykOu+OtHxcJg8mmmUyrdipROdAMd1R9kXyfTC9?=
 =?us-ascii?Q?fPhoVTTUqV21iJ1QH67dLAWSm+N/scY13VRxpTaigGbFocLrWyNgcqrUwegN?=
 =?us-ascii?Q?wacrM6hWgSLYjU7Jb/XvLEZc0QPQMiOTdtE2n2nkzCUyu781eJAbhWKPCMTL?=
 =?us-ascii?Q?wdrXFxsEw0qU2XY2k/P6JGiqaaIAYp40CXIy2xtYW981ea3YTN7ofNJ9vHkp?=
 =?us-ascii?Q?4bv4LT/gIvgZ1abnGcJq6eUH12cuk97BvVWsTc+8sC5wTgpDBOZfvbYDFTRV?=
 =?us-ascii?Q?KvNDsKAIZZZ6hTlW8kLEzjqDNmKqLOconzfoaXP5BmMAGTsOLbF0XZHdwYvr?=
 =?us-ascii?Q?XGTWNzhAiRGDm/MEyLvnc73HeV81dGZLSNVoBRaqF4nbsg/E5ZvuAkztahFl?=
 =?us-ascii?Q?rCzeYDMVjKON4R5slevW7UpS5Q8zg//2ni5RdBedL2DP29BdmcBtBafN44Y6?=
 =?us-ascii?Q?Q65kt23za3awzWYRTMj49CcVpG3eBq2MPoAh+MioCGWK04YBKs1hUJ9HmYUW?=
 =?us-ascii?Q?WF2AiTadHl9v33hZFhkFVcEdaAh1c9E/yHoP75Qhta8sgCQtnJftS7nb225M?=
 =?us-ascii?Q?CspSEMIQ9F6QF403JkoYHL+Kad2DSkfk6/fGOR017rYuZbyHpQzbNufHwM4/?=
 =?us-ascii?Q?Cac8HfdvF/eFphoRqL4BHDmE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yg41ZwAvvkozsL+gwoJ3h55QYFQbsL7yMraLp8LsSQ4cSGFScpK3OnpEUifU?=
 =?us-ascii?Q?PIqSlSZ2wJMoY/v2c11RzzlAwfzPNDZVvYUKEZYLXsXzRUWgRYClEAA6jzO8?=
 =?us-ascii?Q?/onDJrtw7JX7hgkwqMuLmpt2CzK9iEF/VLMZhBON1aXVDg9VNGs0ovZZl25i?=
 =?us-ascii?Q?U6jivwdM3hv7FwJCdxzo5WJk51pTh4v57NStRQ+HcvsOun1at22Gru9phXFL?=
 =?us-ascii?Q?KNNlpfAt5+uN9q01huMzxLl2oQwMYPNDjGwBZAGAGP676sffcI/ZSEiRSMrU?=
 =?us-ascii?Q?Atg86pQXZhGX+iAk/u5SplAfLwROR42VvLGm2yYtQ9Plrt9BgHUKd5IJUu5D?=
 =?us-ascii?Q?vSCEeVnnD7ktxdIHD7DWrf1IkK7qC81c+5f+I5KVkjdqNUMc/SkI3AbNkTCA?=
 =?us-ascii?Q?Tp4Tkepxb2R9HfNv/8LOTb9nDoiHAaDmMFah7jmxtn2+1gbUanIM9AuWjrH1?=
 =?us-ascii?Q?Z2/tSgoX/+Na1HHQnrDo1y028ABjD4KefCbl8lE31/atIKAZdfvQRyut8zLv?=
 =?us-ascii?Q?CllbBXnyyMyLi57ZqXgQanvmKtTu5kmJO0lhf6Z1tnynjW9LO/WhkJXGFQGw?=
 =?us-ascii?Q?a6rX91jjfi5RxZD+RsxFVPWmCC+F3vbAp7Tl1hfhB6eVi4ntMe7eT0Juy5l9?=
 =?us-ascii?Q?R/5oKEDw+usp5Z8xbWRAzmqprWXYFPeKJnmI8kSgOrLPZ7vpqtztAUbEhdCJ?=
 =?us-ascii?Q?74gOfHDYOjxrYhPswzGJg6gWVrnhQ6qzliWfPwnfJ2rdZegf92nLyrdKHekh?=
 =?us-ascii?Q?Lsfk6dOcT7xE6SLNr8A2bH8cMOTY5/30N5TUkTkZO/PIjdyWpjeNNP9IbnkD?=
 =?us-ascii?Q?BAhhUrP8ROKe0hNWy/tBJPNGHdyRLjcsH0AF9v2AdRC5Ir3i6mfmLtTD7gpd?=
 =?us-ascii?Q?dy98vUxSDtdFFslJcTiBKhHqbMPq9vBP4/Qjq4q5rSAvZhwBerrOUPuAE0Fk?=
 =?us-ascii?Q?KsFyowkyVbI1PQa+y3auLVrGdG4gMqPigHagSC4H+Hdr8WsokvMup+t2c2YA?=
 =?us-ascii?Q?rpulc3bJJE+yOHPxgeeAH5MCXCd9CoqBdEr2vAUDYRl0vEgiRp64hVNwiE3K?=
 =?us-ascii?Q?dnb3gCAPoa8O5nIQ27n4lXcVTAAYDG9evBgN3JolZuazTUzeuM5hHkYqnyrJ?=
 =?us-ascii?Q?V4jt8kGSyZumiqfpgdCdvCbJGeH/+lRuk5G1OEQXqP1X9L1b1t9ZoZOmrHVO?=
 =?us-ascii?Q?OscXwFoyg5iaQTiRslVxJK28rA24rxvZd5Unvasj8JNkUI4uABXOaeM7c6x5?=
 =?us-ascii?Q?Mc1qcFX+k4TPkHUBdlFt+h8FGdvu+tq/FVbk3SNLgn9eqB7Q6z8jITe/vq+2?=
 =?us-ascii?Q?aGl7BedXM7l+AOfvPGHFJn+x67fzs/EOoJd4LtGRST9NmdYpmnYrogX0yYsd?=
 =?us-ascii?Q?HzF5XPfA78N0va6dPHipdDF1IkyF4U/NVhUg8dUywrE4j2PudrzfdCugSnmG?=
 =?us-ascii?Q?tFbftlDrx1K/5rmoeCwERRL1vK2nwZEL+DAI6OSUFZ2gel0Rcgl1+90RClg6?=
 =?us-ascii?Q?OsAvhzAXUvI2UTT3JLbw8DZfqZMBm8lqivo6Jxmuz9MfAUMVXYIaDDRJBIrm?=
 =?us-ascii?Q?tMt1pgDY4jFfEC5PJo9hrunX7DEVoAvOl19L43nf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YszpM3knYIGDYigWKolzW6A7kMWRxKn2ptThoHg83RfqmzLIJOirVxFMwwDTyF+oCXMz1vwX+WqN3IDLHqRqKbh/QU9nOiiCt4/bQ7VDvVG1lq9b78j7sXDHXunNQO1oHUVFfATnp5fvJvrQxHn1ylhN997tqOEpiRHh+WFeqAPmNUGvJ8gEaeewu/yy1ScGp9q6bzLr/YMFDWk+Z7YDVoPp7/wEIzOY1OIYDnnLOHLysOuKkqfdo+M8ZNP+4GFkCImQk5k/GVyT3LsC6stg7GfKhxMW6lgrSQl5WXsPMIhsmeaLZCfs6cSUgNUI1WxDa3bwYWm3snlxeYoMEtllWi/3A+kyK+i7cCACvHCyvkj6tyepkxfckAqxVb36EY+E1LTN1LGMlekoBU4KD62HNhe5jhXXdG+y5MiawqXDXQQpLgnRpWLltPXq7svCw6UVoPnjf3ZXEOuE0WbXPV+ujb7z90qN6IkEdSVeDfJF0AoAqnHAIgy58bLHTg8ObHpz51oUpG8vOR6H3lkPUJr+3bO7Xb1ltudUs+wKbyPW66pEevjHedrh0o/j1yXholmlWYir+CABbq9A68Yidcn6t8FCtgsMBl+JsovBI0E5SQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab24e9f9-1379-4b8d-e6a4-08dd05857d63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:55:05.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnl0hjXS5YNq3BYPI5qUdtZx2y4Y8tQ1bINJcnq6KSxH/kqTq4/gAQOgXUs+5b3EaVAAIVUkxbpnrpsuDfRqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: vz9EIs6bxeYE6VHjJ6zV2E0N4WwptO2H
X-Proofpoint-GUID: vz9EIs6bxeYE6VHjJ6zV2E0N4WwptO2H

Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
features, print its status during module load, like so:

Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6cc9291c4552..d52f7f6e2de7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2487,6 +2487,11 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=yes"
 #else
 			", fsverity=no"
+#endif
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+			", experimental=yes"
+#else
+			", experimental=no"
 #endif
 			;
 	pr_info("Btrfs loaded%s\n", options);
-- 
2.46.1


