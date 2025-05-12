Return-Path: <linux-btrfs+bounces-13918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6916AB427E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C581735CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8CA298253;
	Mon, 12 May 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bb6L6///";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0fZYZ+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228D296FA8
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073260; cv=fail; b=ms5L/6OPHt4cdplv4oWvH2g8Pb301YhbkrGn+JGEb+M0TpaLg2zKIc9NAyXpXUg9gSe7oR2IiAxEh+H645OVNo93ASwaOaoQQNWacMpF/XjAZnEzA2L1flXweMjRhRAL8I8Kfgqw4ay6W/UTWwkre58SE4SotLKQgCUOco+NV08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073260; c=relaxed/simple;
	bh=YMrjH3wRwxdR8EzZEmOm/1SN/jIPUKwU5PPTGNnb3RA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLmZHpB4hbLkKszXieKyphTw7/0YpSfWBFNAqy600S7GngmwS7cFGG3pmV+ATnhvYKv1dUC7CYRJvrS7h7+w9bZ4LhuY3lB2NezlvKXL8cNiZdSsuY9ZXZXcAV+t2Ay322vXa3RZlEZC3qD4a1SC2jJmaLg0x5kgeflzgKhhvNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bb6L6///; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0fZYZ+D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0wfi026938
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4i/+IVfVUqmH0PcMT5wabCEMV8GsHDPgi9KD8Ww55kY=; b=
	Bb6L6///T7c8+aWOJrzXBTN0gENelUoqAPMe5jM+mdA7opZfbtzeNk52xpwx4W5y
	KRWgH4n5xp0/3fQo0nSE9ePJcFtHMXrRcjnU9wrYkv9631rMmV1/DRUOZYbPEl1X
	gpo8ntaoixdKPPbDIsKWwyAG3W5if1ZQPS5rrROqkTtufGz1eRIR1hgQwkYN4yYW
	Ib53siANahI3wjDrAenVHhpQI1+tCh9ugSa8QHI4sZtSeEOw/ZRO7RRCoiVes9Hl
	4NTb+3Pj/47e40fnYPGtam43A99BYyxRcX9ij1+6+XaB9e7s7gkKp3bsP32Lqco6
	VtT5MkZgLCXYT1gssQ1Epw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH148l022343
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88q6pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw2KXcq/2i/y/daWoa/oS0aTB7EvM3ZcdgqS45OPnvqx2V77z7HKlvRM8NbjamwuR3rHYTbnth4lwPpTozziGHRmNaj/xbSzwBr9kfS9zT8hyeI9V7t6tnctM9Bw/OcZBEioB8XJ+fX+g89G3BPMYHWT9G+GQ+gqww/xFvbgv5ZnutgiWPsmhZ93PmhQlzwmBlGQ+ZGl04bcuamKSd8fF1UpVIWo/GBn70ga9m5uGDeH4ymJg9tG5H45Q+ZrZAEb9ocMhIACqVqGuSAstDfKuYYAURv1PXifFIz74KbWHDuvs6mf+BjW/BP2V0XZr3alc/OuRY72a93zQ89+0ghFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i/+IVfVUqmH0PcMT5wabCEMV8GsHDPgi9KD8Ww55kY=;
 b=lWsBFhYfg8672kOvdw/EPC5aWQ7C/C1j0nVaSvb2rLceLLKCbXVDfLKjhNyrMYU/ru1eAJlRzKrep31DUGmDbl3EEyKI99ITzqs9qIyHzQFN2FJAn1i/xnWGaNxptKK9tNVDAx3/pMTPLhAcjDPRsXWXbblbKuFDwAquFGN3JlTdX7Txj55nIRp9Ap/HKr/4G4QbT9u1M3ajFczJ7g+mj6aFguet9ionuGHfctjmOnb1NRt6yaMIn/JnYrMMF/kBzOO16SqaPLmcmZ/E6tnqqjccVg+NV5BJSUrTCgT7OwTVPx+G52qeWyn6KCOtta/T9m6ufDVcgIuPWwAdzpcLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i/+IVfVUqmH0PcMT5wabCEMV8GsHDPgi9KD8Ww55kY=;
 b=H0fZYZ+DqUeaIpQZ/VnVPD3+LyQg6JEUrfIeWSM6xsBUK0Nf00QqXXQ4qYv0Zy6nHdTME0rHP37kylF1gqv2qtMqhTT5cFsmYjiC4L83pvvcqwX9c+vPa2t2O5xm3V9LWhMQwSLCwgpI2BET6zOl85tA2+Bs8sguqjH5+WBRgu8=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA3PR10MB8188.namprd10.prod.outlook.com (2603:10b6:208:502::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Mon, 12 May
 2025 18:07:34 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: fix thresh scope in should_alloc_chunk()
Date: Tue, 13 May 2025 02:07:07 +0800
Message-ID: <4a8219d045af7d4f806594fa8a9adca4726d3349.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA3PR10MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 24909879-90a3-4c32-36ba-08dd917fdf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVQ4Wz2EYyFkW2rX+PF/I0ykxHthPmgdO6850UtBCTFz/BfITm2xc9Bs2EPo?=
 =?us-ascii?Q?7BG1zA2TAWrS8WRLsIu3mSjB4k4fGdGIQdHbLThvjHIue170/6Jo0Cra8c/1?=
 =?us-ascii?Q?Gko7HkNuPJAYh1l5NgCQVLsumzcYETawvmyozonvyCbC6NXrtfjha8bAtYWU?=
 =?us-ascii?Q?4lAeuL9aQf0T8UzU9tGbF6CsaV2rNGmHPQYL21XRuclYNmO7JFAbs2UbHILO?=
 =?us-ascii?Q?rktzLGHNTQgtcNkLTOk7o4uICbbjHA5H9g/46m7lK4GT6cmK+c+gAYW/8mDL?=
 =?us-ascii?Q?smpPi+Z1sOmMyqo+UqNjuEPvC91MasTulX8IJkekCAM1j/vgMRsFyckKlt2j?=
 =?us-ascii?Q?DVlamg5pbbyjqBU/RJdxigVoYEgWzeAJ/YiHMa/v2KptkSGpk2LcOnp/dLS0?=
 =?us-ascii?Q?frTHO/gBpIZ8JluVatzY/luAyw4qVvhgVXYHQMFrSIHOZFg4VnT+SyFWylUU?=
 =?us-ascii?Q?tAXJOh9eGiPGEty6XukvXGZmeyM+5W3FcBUIuzTZH79FeJQiyEJhraJs1Icl?=
 =?us-ascii?Q?HFm90TRFImR2PNZR/k2cHpMHl0TjqBMf3fjs3ulfwk9sg87uP4SoZI4VX1Fu?=
 =?us-ascii?Q?lkPQZLYCo3IzLIoXCO/0u5uQRCmFgyRjBbtczvkBGoS2kln3UGJGBtIFUtmw?=
 =?us-ascii?Q?VEQ2wgv5dMyPykdMs+spxdtxsjaH5WmyroJAWW/QuGcc1h7mcDDYzdVRoAdq?=
 =?us-ascii?Q?gywqJ5DQkw4BKEM1sECppLOC5oCRLT9aDL19YpsGM/qjrI7qc4GnMxDc8d8J?=
 =?us-ascii?Q?FVC5aCMPBWfbtKZPo2naShGz/Q80l49WOc4Ya+fVmoOtuZ2I01aX90jQuUOL?=
 =?us-ascii?Q?mT72eVZViwCR36s/3ZvyrdcUnNvrQdocjIybpTqp39frk8ZFXn5TtyiVecYS?=
 =?us-ascii?Q?QA0GqDFRvf/7KnN4m5zMx1lJ5fA/XqxjW9b9hRqY51sDpWLyWV9JbYPbiVJm?=
 =?us-ascii?Q?bCObqSlzSI7qbko+U6vAK7qRhhcQNbu4jlFruFBInzMc/3cboBpLFfO8cY/V?=
 =?us-ascii?Q?H9YwCEIi+EJJ7/wCba5w/opC19q1rGxjhg5/qPrQlkQSDkjSh7YSvCjiMm1Q?=
 =?us-ascii?Q?+xCCtNnNinIvwtwyRvIxeup4Xf0/PEBpKAlq77QqJO7z19125N8w7vVo3Q8x?=
 =?us-ascii?Q?jf4IrLxIHasIdT8l1Jjq8XQJ99Bzgv7x/0gxMKbsN0DCWBCMvsIv05JKoLiL?=
 =?us-ascii?Q?mVJEEfHMqAG0CtWt+jk/4364d73JjbpxDOS9RKIxCUZxUs1H4MzEZE0AHVzb?=
 =?us-ascii?Q?mUeutzG4V73T5lyvtmreU9ksNbxW6yAZh74LMaxRgkTzlHC/mkMKZzp29hnc?=
 =?us-ascii?Q?TpoIs9OHtB5/ipfUANKNNWRsyZQI4c6bve16VYRojatGl4psxPzopWVc8FsM?=
 =?us-ascii?Q?hSErtIBew4mcgPrkfCU9vtNZV1WSk+LjIMeiaFtyK5/GmOFcKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23cwZk0UgB4Xu1g2dGKvASePrj7AwUDK4hGL15QgF6GU1368LOR/CKpJXbeG?=
 =?us-ascii?Q?9wJIQQVXNvvxX2WONv6ioJcaPZSGYsHG8dHwdveZVf5+jiLY+DnO/CqGpw83?=
 =?us-ascii?Q?FfCPGzjkD1b8rqC4xSjMTWbbov94RCDIDH1hWt5z/UfzVIX5iSl5G1Q30uEf?=
 =?us-ascii?Q?2yisz3U/NAUfUTm/ehgNJSVSEZgUlbjN82cCFWJee7LVXxodzj9kYjZUPHQt?=
 =?us-ascii?Q?4zqx34qwQys3u6C7FTa0b2V33vOrJP/v9WacKv6a/9AH+HISZg/Ykyg78lhs?=
 =?us-ascii?Q?+orn0MeR9gDokCxkrDCHbKsSkAQ8TBVi7XSVck63mh+EUJCtU0u/6ARrgU6m?=
 =?us-ascii?Q?eMp1hzktVX1chMAIzHbRnl0NeXs1e+z2e38XYDwrhlByU1VF6nBtJjmCdLae?=
 =?us-ascii?Q?RjSVKpC34hSt6TAgtifnENPwD9XJ0G9Tb0fbHfaoosyExQVfTUA1zbGyqt7j?=
 =?us-ascii?Q?F8dqYxRa4Iz0gMLasUTSd3PXAP3RBnt+dJiH2SOxHrymSq6ALif8FD4yJQAA?=
 =?us-ascii?Q?o0YJVef8KoPPrBPePy4Y/74j1YWGTrcchjQAWzqfarmMCriYf6M2IDlV812c?=
 =?us-ascii?Q?ByOl1oBgtmrN/Z3Xx/MY2Wl6j8gKzxUDt9h6PVGe+70eczkiseZTtdyeo/BG?=
 =?us-ascii?Q?1a15NhQxSrb1oz/sdgd6yeggw/kIi1JffwOUGJ9i5L//PmaQi29nklNnxPpF?=
 =?us-ascii?Q?srQxDI/5qpZVlpfpvsdgYYEdmakX5ou/ZWyBSJTUE1aIH8vrh8Ggn3FBAvMD?=
 =?us-ascii?Q?ZTHeI3mb9++hU4A7KPCLCBBlBMm+QL08JacmCDbvjR3agPCf40fwQDeUiPlf?=
 =?us-ascii?Q?xl9xFSS10UGAjVoqZXwxmKayJAjreQZZ/J2QhRQIgGtg0jBGO+A/U/h9UVNe?=
 =?us-ascii?Q?7/LSpIE8cgnNRO/F+pu8oXMo11vTuc5MIrjIQ05ujtdmDs1FM/ATfyA2lS8C?=
 =?us-ascii?Q?XlI/UQpMnU7W+9rkPBsj/B2oUL4bBfq9I23iO1eXP1ZVClk5Go41OFRfMvgL?=
 =?us-ascii?Q?86+Mvc9zGEpQe1sRcq2IBatKZJzu53MF8THm7cwQj+cO3JnqFInuVpvs7koZ?=
 =?us-ascii?Q?yskhqSeQk8mSEASL022lA6WYS63C9yJPFX2A4esBgb++ko/nkhhSsTAyAUbj?=
 =?us-ascii?Q?xc77DMLLQdPX1MzHu1zNZGl3/pXracmsGwDv6Km+1EjzEKzLYml0B1MJQNDr?=
 =?us-ascii?Q?pXJogmB4qPGLDTOuZjNUg8DiDJmToU6SjSUaV9P8Mj3r5Y2IBYxdYm4cBLrS?=
 =?us-ascii?Q?cX85hLl/ewKlFfAk3rFNC+jFaqB2WOsbJB/nEqutjR0pQ+pCubX4GnDCXJAd?=
 =?us-ascii?Q?HpOb+lRZj/xhrCZFX2STpcE/oYSLwYs2S5ogKV/QHYqvDZzz6Lf8QxgLM1u1?=
 =?us-ascii?Q?VOojhk5FV2EuTCeuzFbrzxaPblerXihNTb+GigEt6ZHV9rqh40EMJnfrR0WO?=
 =?us-ascii?Q?TlPx129BLJolYufKRn/zcaakhU/5/LQcz4RVZ1y5/WJYl87KBH7ZB5H6Czqs?=
 =?us-ascii?Q?jMTNKNiPHNh5aMotBnmUaeX4qH7gQaXMitLK02natDAiAkaP0idU0/v7eQ6x?=
 =?us-ascii?Q?I7nfH4Yi4Bm4TVUlJP36dfbR6dbUlf0E+hPG5OCg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xx4e/AraNVRNB96vfTKDbimjDcSGYMHggipi/9CRI7yvhHfEpEab6fEyap0smY6o7HbYdpDQCd6hSIynawxm+Wi9SuRYpXBJDOM2AgfjoWuXzK5lsA7toX7h57aXfX30WG2H+V2/RxYgNQSA6dySo+jwEMwl71Co52Sm7goRV5hj6CQQ0cdhIMJnlWTFlvC472sy+M0WJ7ES5E+J9k+x/fmjXle8Ux0vZb94lH0jR2kP5NEkxvY7Z8RAfva2CfjewuCT2JnHrtvWT29TU/7MmRTsEL8K15Y1pho2ImZ2e3xd9YhlsBHVaKGv6P6ChEdZ3fh/dsAyMks1IMZkwu/S0TAYd+6HHQ5ldxF3X4k2TWMUqSINVEweY7nwS8Ozz8QmsyuDEf+2M/97tfThIVwNqBGZUm8skaEsXbSkPii4ulklzyeQzD2Oa/BUZLWtt4miFtcQpTi+HAo+5FqnQ1vm0+whkkXK4AzWG0SLQDFNWtEGUFnR/u4hjw5BhHwa6s/2sJjjxgKn7DF1sKcKeaRrczXyIol9saMBbOUKwUoCgGKTNVXgOv9h+LQTHIL4Bq69HtIyYqBxjtP9y4mn7iXPOysnkiKh2ZM7CpoUsfuUl3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24909879-90a3-4c32-36ba-08dd917fdf05
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:34.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2PbA0dLExq9GTgZyZ684B/lpIhcWfuQfHXM32bib3tiz384yog2T+PjUBE1JtL8vzcMY0B3BkHugm3DaP6D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX7JVmoASxw5up IdR7LcjpD8Py00c9icHn7LQ89b0QlTh7x7kzxnVppm5T9DJAvig6p+ysyaTxwjzFrttbj9S/JBJ hGdUOkJxtwUs9q/BFQTuCJrbsOXP6CNj0f46ooqmvACx/tfXZslsCZTWmWRXG/ab8d5qeuA6nIr
 fNRr/Pd76yEzSUWFcpSHPFoVb8UZloZESuBfezn/7RXO2NHQMP2Lsr+1iDwkK5JmyRyaNnOPsNB Oxwu9oM3RdciiVIap9XbMktSBWgICXpyKfvTAbuOicSmJstqs1QGCQsdcbOW0//YNheyPzJopIm avWZaOvL6aoC1/uZj3WNQXAZS8RnYCdBzUpDynwkD7dHjPjbebatJXcq1YKLOSoWMzo1C3KjYWW
 +MvDu84qKNf1pm+RfeZSyy5VBLCkG07R+N6gBdBgCj19kCB3xuuI1I9X2k1cpzSRHyiWbihX
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682238e9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Bb6Qg1N4ytod7xNQDuQA:9
X-Proofpoint-ORIG-GUID: SlfiYJIKdRRXrsyxzkim3jp0jv_0X4m0
X-Proofpoint-GUID: SlfiYJIKdRRXrsyxzkim3jp0jv_0X4m0

Moved thresh variable declaration from function scope to local block scope
where it's used. Minor comment formatting improvement. No functional changes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 20f238dd8d96..f8317410724a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3876,17 +3876,17 @@ static bool should_alloc_chunk(const struct btrfs_fs_info *fs_info,
 			       const struct btrfs_space_info *sinfo, int force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
-	u64 thresh;
 
 	if (force == CHUNK_ALLOC_FORCE)
 		return true;
 
 	/*
-	 * in limited mode, we want to have some free space up to
-	 * about 1% of the FS size.
+	 * In limited mode, we want to have some free space up to about 1% of
+	 * the FS size.
 	 */
 	if (force == CHUNK_ALLOC_LIMITED) {
-		thresh = btrfs_super_total_bytes(fs_info->super_copy);
+		u64 thresh = btrfs_super_total_bytes(fs_info->super_copy);
+
 		thresh = max_t(u64, SZ_64M, mult_perc(thresh, 1));
 
 		if (sinfo->total_bytes - bytes_used < thresh)
-- 
2.49.0


