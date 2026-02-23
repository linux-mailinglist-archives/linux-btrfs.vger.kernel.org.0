Return-Path: <linux-btrfs+bounces-21835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDSCBGhBnGk7CgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21835-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:00:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D4175CD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 13:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15581302759F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63230365A0C;
	Mon, 23 Feb 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkCxE4Wq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Io8rou66"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31695365A01;
	Mon, 23 Feb 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848011; cv=fail; b=fGoMeehCMEC1eds6tWOmaqXob3rhMR/5kfYiKA3kuFC+hosl+WroJU3UMgDC+5idtgh5v2k5BA72I9/J6k12YPd9h0JyYsr143mDkIn/cQ5RfLPZXrMy/FpNJv+xZKP38cMmhIrk2yabB6JNScnOqKqXdvyHLGphsRoU3uXE1eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848011; c=relaxed/simple;
	bh=2vaRcmUe4OODcTzEi28q9TrX8SPyvJ7vfQdq1JPRwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOO3S+BaH4j8aGzH2u3KmrHBrop2gLdEtetC6SaLMPQY0jscXEBwQcChUquObruLw+6GqGUZocGzO730IiAu7mQS85Pb2MFmHpd45b/uYKWarEOXOu3VhDTcsliiOeXANIKKSE7ykU8waX4YlEwJyVqtLa6Z66k04317S20Rg1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkCxE4Wq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Io8rou66; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4xogG758121;
	Mon, 23 Feb 2026 11:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HdMYo0FhWGJPaMLvFA
	6DcVZ++4WFZzO7h2XSDJDmJyw=; b=LkCxE4WqENdQKVMbuKm8k8q45+SL5YM4Cx
	TMMmd03k2A9qA7/8u5+3t6O5V9ZlQ0b1POMQGV/kSgKv33yQFjHhduUxX9rACqdd
	G2x2fWGn4q97f3jqvw59E4LsMDjFOeXszcy2wUGlySIjNXCgppTciCS9Aoii4Fet
	14uYlzKZD7YMf9HtHgiGKypM4kHFdY8zExcuuug9K9PQm/BQaIti7gGMfPOKLW3n
	fGy+bxkR9vq2JcVNPwmVeMktuNXT+vMyKs+jpzbZtXxFMQ8WB/YT6z3ZFZK7Pgai
	IkKIBJEycm+eRGvl4S3AqOc7zQXj25g46mNt73vNGwQLTMmv1kQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5sxu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:59:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61NBj4YL028678;
	Mon, 23 Feb 2026 11:59:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf358911n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnNEtEJiTZsfH1J2peDMbH/5fGKtfqB8Iya4QB525n45+xQ3fWeAqaxLasL4rxK0W9+KKB1yJwvR3O1A2exkKapKm2bCoAJ7Dgr55KxQDDeCZljEf5o3rG9zK/sOd7EbJhVod4kyIFopsszDyBU4VJ7DjNBTL2lbBVKu78lnVmRi9zDwBq5sTEPXxsq+a7J61hC8fHNTL5r61GVRHLG/zz3/FDdmYnbmeur1BZfiSOipYIg0+9wAdVtYkiLH/BObcy6BgH/s1qW41+Pgbi5h6/qnfbw+BG+5RWq29cjS3fykpr8s+cAUbgNW3YDO9FmS+ipdQ0DVngdA/a1L34xKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdMYo0FhWGJPaMLvFA6DcVZ++4WFZzO7h2XSDJDmJyw=;
 b=rHK6qpLOWSK0g6rCYbb4lIvnSaAjFmsr22W7iHJLqRafb6r1gUVmwV87G/jVJfhUdaCkyRCbddrn9UOu1cvryWrC5Pknnhw7Uf4tneFWBOH7KIzYdNeYsSrrmLRUmlu1feryGd8QMmdrluK/keTjGe5Vv/Xsd1pGIiKmBBxPeD2HraByp/kEEXlcExQfvyFZvgh4PDJ/Z3VqlXktb+JQBHr5XR+6MTEglls5p5DFc5biwy251vCR2OzUs4kvxgprEq2do3r3R/yTr2UMtzmTJxz/PRQxvz51om8ApE2yFsswOhoAIhxISeWxgMHXZJIpTS9rdnyvnQ7WUr2mXugdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdMYo0FhWGJPaMLvFA6DcVZ++4WFZzO7h2XSDJDmJyw=;
 b=Io8rou66C9HrH0evNY7JCf0SDstWRkoR7DDIkk254c6HuqXiPOT09I07aNgMF0ioPzM86MSNbGI93lMthgBSXLkkIhji8diLpNxhEL5Xj2aYTlKl+jFnAFr3QDOE1d5b5ex1P7UeGhafVktcikWXTYGvO5/71mJMsvi4buV3NUM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 11:59:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 11:59:38 +0000
Date: Mon, 23 Feb 2026 20:59:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: vbabka@suse.cz, surenb@google.com, hao.li@linux.dev, leitao@debian.org,
        Liam.Howlett@oracle.com, zhao1.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to
 "slab: add sheaves to most caches")
Message-ID: <aZxBIpE8R8DxO4eJ@hyeyoo>
References: <aZt2-oS9lkmwT7Ch@debian.local>
 <aZwSreGj9-HHdD-j@hyeyoo>
 <aZw2LyOjxMc-c3dl@debian.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZw2LyOjxMc-c3dl@debian.local>
X-ClientProxiedBy: SL2P216CA0172.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8ced50-eae0-445e-d6f6-08de72d3053a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qt3ZguG+HfuFFhX0uxKIFyxrCSjS3H4Gr1+uqU8hBuB5fSrAsufcxMdI82GK?=
 =?us-ascii?Q?p6alkQdM7W3XscsDxw4qUaNJ8nfBbWB93NFTGq+ToH33nyPDbbsk8gkQGxBB?=
 =?us-ascii?Q?U2hKj3H8IYZ6Ljp8daXWONt00lTl+l0XvM9/xGy8Eym/14FPLKGqnjdr+NSr?=
 =?us-ascii?Q?dsMdsjk72wc30vxo76RRy59lcB/P/4zGuLk6sZ+Vc6jysbpxxgCz0ZNMv60q?=
 =?us-ascii?Q?YmVZUh8qIen71ES1fVrVoVD1L3M9ETO7e3EyZ3WmG868NNGi6Tx7GVIMAgf+?=
 =?us-ascii?Q?BeZDXE9KddtuDBKQMFx6J161MvyqCYX9idsVs3mp4ApoqT2S3obnAaHWewt6?=
 =?us-ascii?Q?GZjT4U8mME+xUgTvHGFdzB+6RRKvmGAigqJ9bR+3yn5QvyCZ9Z5dVsL5ywpt?=
 =?us-ascii?Q?uqLROdX61i6hpY6QpwSSuas6Xojp8woFTrcgkGu1PC4ru4OzIGeDhDoFhjfK?=
 =?us-ascii?Q?1lI5rRGLSPHmH3bELvHl8dpxFVKW5oNKx4eaupPeAljcUWaoOLxLHIs814vE?=
 =?us-ascii?Q?2ohpeisy7rQMNqu7gup9ku30hlQuWMdVYJjdTur70nHJlWlXvanodxzUmzuK?=
 =?us-ascii?Q?UVgCQVUjSP+sFqW8hKSXWUR/+puBL9l1ItsI4uvpU6B9/sz2D6O5yTjOsF8c?=
 =?us-ascii?Q?nwj+UQQlrchmkaayTZEMjH12UEAVITxScwH1CRK6eGhQMERgHmQYFpqWh/53?=
 =?us-ascii?Q?VjoSTC8gwj2IQkfyArQm2ZZWGF3RWbLC5B1/GVCvMfQF8QXSbMeFLX3c4nPj?=
 =?us-ascii?Q?ykDqt/S+AldSmIuBYCJHGX78AVnAd5QlUFMuS3hIejDCZ3q3I5kpjjXDzI84?=
 =?us-ascii?Q?61lnhSiUZjqSu4WY2E37chiwfgtTdmVyEZJ7ybkBhsY1m8uEUawWxQvCDL+e?=
 =?us-ascii?Q?Rx4a1C5Thww/kma7oYE5rnTZIQHFyX6Ij3ImgwUL4INfOebVgWyDBtw3xpMZ?=
 =?us-ascii?Q?39/9XtiByJdu8LnpxwufDtF6oV6QXx3uw/H01w5UVIe/vqikUH2CluO2dYhL?=
 =?us-ascii?Q?d4qyi3xQR2kMCYElNOXlLGwXliSlLpLMCmhYNR9sRsYT+i+Yrx6l+1qMlcNz?=
 =?us-ascii?Q?ovjYo+QZGwJMYwihbhiIiUIlE1tc+JIMZAVI/MTA1uaHnO2zO1WcP2hZj6pL?=
 =?us-ascii?Q?IVmgOf2p00hFYadqSmMFEmu7HW0i1nPQjVVmiGXjJlVeKaMSyUmcUJyQE9lO?=
 =?us-ascii?Q?hIL78iWtPRRI9RYAGT/3PLsOYz1xEJ3jMU3WQR95RYrTq3cmimqvy8w1ZuhJ?=
 =?us-ascii?Q?rMlvdBtrTu2/2th+xrAm8PHbZIUby/1ytPv/x1gRmtZ8GAq0g1ljRYOAVcnQ?=
 =?us-ascii?Q?jYsrS9btjlvvND6uuDu4fvv/87bnD3EHtnf/N9PQ7IAHVpH+WogDx+PUIBVj?=
 =?us-ascii?Q?MCJ/7Uk7FsstV5Cz1k2BFoZPuHs8wjDrNnt5Jz5YC/xqfIJnQd8HJcKuuW0L?=
 =?us-ascii?Q?TiypTobK7iOrcdtvGUkYSZUmI6z8G5Rv2hzIajSYm211d/cXq7Lm//yXs2tJ?=
 =?us-ascii?Q?vHB9GL23n00hR1GRQBGgWmlv0a3PdA0iPKRCtROPMw1Eta9X7I12gNyok/iX?=
 =?us-ascii?Q?iYvWH0f5hF/RL/qLN+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8PquKFVZ9EwxoVyw13YT2Aa7eZDLsW/7mGtKC93+PB/VZxqQpk83YwFvK6B?=
 =?us-ascii?Q?Hf7JbCJN3Zrpt4jBTfJ0rbcXGMKmY1/MtOE3bzZYjdxNRcbpwDDSjNQUr8AP?=
 =?us-ascii?Q?vXHmrkBV73DqenqAREMegyqSnUUZHu4N6poAFfacgb3K7AHaADdwhlShsbFB?=
 =?us-ascii?Q?jIyvoPkGMAihmEa6DkYo2yZjG4d+nlJmc2WYo3DG3bOLH3IZeZIVCck3lHz+?=
 =?us-ascii?Q?k+IUljYupr8yi5uuWS4Iapx037Ayt6WmEW6YgwWGHuwAWkPy0P0xA6J2unZB?=
 =?us-ascii?Q?w6aKRBsBeM1rgTi5M1nmnaVJ0tmZBUkPUOAE13cpblSGpEjEICBVVJW6Rda1?=
 =?us-ascii?Q?MTk2823Mu4mDkBYgBfpR6Y3IpPI5P2w2Kfq5rGrKaM/VrKJQI9DUfeW7Qaht?=
 =?us-ascii?Q?K1q/v2kcmf+nB/NXQ41zFrCxsgsAjn6TPv+RYZgCPWDyPap3Tdv9joVEVWCH?=
 =?us-ascii?Q?+U2aXS22WosQCbREbLOGpevZCqdOm/nIzWF3BgIgT39juTOPvnHu/SBAx8+9?=
 =?us-ascii?Q?GR95NBHd2XeahLcRdjnvL2DrUqmMAm4i2Blq4fFPDfjUVtHsbPqKOt2YSPCF?=
 =?us-ascii?Q?yAB3Sfc+HZe2Wj1tBaRAUK/sMGYuQJv0DkuoP7iMTjq3I+7EDGU0qnzgtHt3?=
 =?us-ascii?Q?ozpAsC7DKrFz7lixuEAk/PDIqkpvAcglNqkH01zdtcalLg/ncJqWCxxc7tNt?=
 =?us-ascii?Q?/6iQ6PPsNYyPQxH09SsEEiXPfyIQO18TzNwE/zi60SFa4bZM07LdkY3MO09v?=
 =?us-ascii?Q?JzF8nILeIbDOeetnl0ksqVkiamLWxVDKOeCFZUj0MQyCxiQ4oYETuNacwt6N?=
 =?us-ascii?Q?ut9Tpt934xV8jDGS3peNy9lvatH5JN3jJJxTNcQN0pz8SreV42WR3jTShzsl?=
 =?us-ascii?Q?5f58bFpeaLjhGKmakQTyVVDWOXbx5Z60Bv6vrP9onYR9DOzIJcLi2M8Sv5yO?=
 =?us-ascii?Q?eSQSvzbNwZRglWi6H7dMoU8sma3bbph2YyIMjvVswz48H1P51kACZH01Rp38?=
 =?us-ascii?Q?aeJyvwq7x8GBShP9AjNiboMyam4T0td7UhHk2AulkvlAU0xSIfDxGohQmBKb?=
 =?us-ascii?Q?9g/+PLYKUe3LlCffIotA/SUbh+kCi3eneXtfBxlEM8Ja/UDfkP2LP+mEzSwM?=
 =?us-ascii?Q?RrHNnH1skSYdM6ZTf9kJRRQ3jxTzmicnkonwtFIJCXT7f4+vlmGSSuvbuvbr?=
 =?us-ascii?Q?1gQ83owWo/UpUBI4O2TzVhSR9yFayVcJBkqZYqMtM34XgokeuYAP65UlVV8Z?=
 =?us-ascii?Q?xdwPpwJM7+NSfIdCRMD+wch1cwmUpaSAtPgVtmVGdd1R/KnQcokz9uGByB8y?=
 =?us-ascii?Q?BbdMWCFb36LSwpy4ctK7H4vwUKr2OMjw/N1gstna9N7oewljs6ZzEREvTT3X?=
 =?us-ascii?Q?b7qAE3F7x9FWM/o6ziVLLt1j0/ljdVM4xto9GGHZzKk/QRgC+kDORpyRSidV?=
 =?us-ascii?Q?x4zpndP4x8h504RulAIjzOQ1Iu60WExxBGQtcEu6bP81Ht3smRJSvZP0bXJW?=
 =?us-ascii?Q?fAZrv3ZyBLIkHqFE2iguiiaBMLsAm905/wZPO5Q+I4TW6YlUaPAR/V+I+IAT?=
 =?us-ascii?Q?jjQ4yTdAAYAYyNR3i0ptCKDlelXMW3mpU/yhKpA28U6hjyH+m8eFu5r06pAE?=
 =?us-ascii?Q?fnHKSfJATc/EkdVv8PKMiJEdjepyt07pB8jFLoisJlcqxv6JoMMGtYKH9H98?=
 =?us-ascii?Q?dmshMRp/cSq8hOQxgXRSXBvgOEb36uw2SK6u244odHiwYJdM/asHpe7iaQJ9?=
 =?us-ascii?Q?K4PHZhXsCA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8EdZSQTHa4aj9BxJkONwNKiTbCUtbqToqzPQrbc4ay72CK5345t1+Vl69CX5N1K32YcF1JY/I+Ql3ixzSYc/KlhEwL46vx9kE4oZfRFoB4mO5dUs1TB5+NyPOGFRO8kJfjLIhmrOWlenY/O6UcBSyZGEVxyGoohNsk8HUP11Jnkv9qeQjxRdOLMZUWw1S8Es34zMGCoNCgFaTdY/vE/ZgGxCJwKjWqmv9B4n9fA0cVgqMtAl8e9ai3XsPTVRsNKSOnpDE4iLZxItLQ3b77aKDC0pCbYH+oGHuT5bCGlj0ASk1d78UOxLDqLf3J4xLw64/ya8xXxjStQe9MpjvXN7Fjt9CsQaY7YhC3FXMzByG/auMWR1KSJrQ/jA1TkvgMDGywZmk9mF3CJIP+xzmvPV6clgFf+YRzm2NgX0+7alYD6HKRg4ObIarFZchpSnasy5gVGFe5unqjWS8nYo82uuCIWbLhzil9X9JxuEJQWEK/l73Jdaqq/OgVq1HRAgvzP0VDLK9pTNJVwFUWZbCVSwKXs1jdqr6O7k6e6HLJq1e0BCpOzajieImlZzRnFnpCA3xDP9jsmywJ7Hp/gK0+UYwGDg6z63udyXESbtI4s5pKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ced50-eae0-445e-d6f6-08de72d3053a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 11:59:38.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jJGcPwCpyfc1L0lTyJzzy9KYPPrjBQZI6+c7+bGdzBrCHrI0Kwo/XshBevFnX4y7nBnHBo+PEhWOofJL87nIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfX7Kqhlu3yQZfV
 El4WC4Ze3BhDtzFVL0+a+Y1xUbcADG/Yyk+UsLtRM+TYhl5vcVs4Ijbey3GUeW4lX35wXsyClzX
 ALWeHwLkt0VPzIquDI1Vbkuq09bM3LcI6sn+JLwd4fCAeAP2PCMSflk0/P6vLsb/H6y8LHVqB84
 8UkFXQ8eD4doY9lGf3iPUBi66TuNUFJIx2O3PTCU5pcLszCtw4A2/jYQ+VENZp6pp44JbI2ubVL
 OPD4j/r2GFrn8Y/6B5vYmjf90SOmw6TEEPsXUFiWD0P1O3ctXaV2Or51UqbwAQEJe57Og5dte/3
 Rc2PRiANfcYO4CM5l32cDl2VAKMQtR+PPDtZd9C1PGLjtmVZ0GWaq4AwLUEYmrKp/2HxHw89JNy
 bhX6Z4CDQNCHNY1I9xg7bUUbEKvHzXXmLitphaTame6Kb6mZ7U26/VIFWc3QC/xQR9SCdDRwkp3
 Fe7m5ZRRvTVC1Uv+8Og==
X-Proofpoint-GUID: wP-ApFOCHaRo3ebOnP2qXzUvHfw4wo6Y
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699c412f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=O6FJd7GuMo-m2MAkU-sA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wP-ApFOCHaRo3ebOnP2qXzUvHfw4wo6Y
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21835-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[oracle.onmicrosoft.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 716D4175CD0
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 11:12:47AM +0000, Chris Bainbridge wrote:
> On Mon, Feb 23, 2026 at 05:41:17PM +0900, Harry Yoo wrote:
> > On Sun, Feb 22, 2026 at 09:36:58PM +0000, Chris Bainbridge wrote:
> > > Hi,
> > > 
> > > The latest mainline kernel (v6.19-11831-ga95f71ad3e2e) has page
> > > allocation failures when doing things like compiling a kernel. I can
> > > also reproduce this with a stress test like
> > > `stress-ng --vm 2 --vm-bytes 110% --verify -v`
> > 
> > Hi, thanks for the report!
> > 
> > > [  104.032925] kswapd0: page allocation failure: order:0, mode:0xc0c40(GFP_NOFS|__GFP_COMP|__GFP_NOMEMALLOC), nodemask=(null),cpuset=/,mems_allowed=0
> > > [  104.033307] CPU: 4 UID: 0 PID: 156 Comm: kswapd0 Not tainted 6.19.0-rc5-00027-g40fd0acc45d0 #435 PREEMPT(voluntary) 
> > > [  104.033312] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
> > > [  104.033314] Call Trace:
> > > [  104.033316]  <TASK>
> > > [  104.033319]  dump_stack_lvl+0x6a/0x90
> > > [  104.033328]  warn_alloc.cold+0x95/0x1af
> > > [  104.033334]  ? zone_watermark_ok+0x80/0x80
> > > [  104.033350]  __alloc_frozen_pages_noprof+0xec3/0x2470
> > > [  104.033353]  ? __lock_acquire+0x489/0x2600
> > > [  104.033359]  ? stack_access_ok+0x1c0/0x1c0
> > > [  104.033367]  ? warn_alloc+0x1d0/0x1d0
> > > [  104.033371]  ? __lock_acquire+0x489/0x2600
> > > [  104.033375]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > > [  104.033379]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > > [  104.033382]  ? lockdep_hardirqs_on+0x78/0x100
> > > [  104.033394]  allocate_slab+0x2b7/0x510
> > > [  104.033399]  refill_objects+0x25d/0x380
> > > [  104.033407]  __pcs_replace_empty_main+0x193/0x5f0
> > > [  104.033412]  kmem_cache_alloc_noprof+0x5b6/0x6f0
> > > [  104.033415]  ? alloc_extent_state+0x1b/0x210 [btrfs]
> > > [  104.033479]  alloc_extent_state+0x1b/0x210 [btrfs]
> > > [  104.033527]  btrfs_clear_extent_bit_changeset+0x2be/0x9c0 [btrfs]
> > 
> > Hmm while bisect points out the first bad commit is
> > commit e47c897a2949 ("slab: add sheaves to most caches"),
> > 
> > I think the caller is supposed to specify __GFP_NOWARN if it doesn't
> > care about allocation failure?
> > 
> > btrfs_clear_extent_bit_changeset() says:
> > >         if (!prealloc) {
> > >                 /*
> > >                  * Don't care for allocation failure here because we might end
> > >                  * up not needing the pre-allocated extent state at all, which
> > >                  * is the case if we only have in the tree extent states that 
> > >                  * cover our input range and don't cover too any other range.
> > >                  * If we end up needing a new extent state we allocate it later.
> > >                  */
> > >                 prealloc = alloc_extent_state(mask);
> > >         }
> > 
> > Oh wait, I see what's going on. bisection pointed out the commit
> > because slab tries to refill sheaves with __GFP_NOMEMALLOC (and then
> > falls back to slowpath if it fails).
> > 
> > Since failing to refill sheaves doesn't mean the allocation will fail,
> > it should specify __GFP_NOWARN with __GFP_NOMEMALLOC as long as there's
> > fallback method.
> > 
> > But for __prefill_sheaf_pfmemalloc(), it should specify __GPF_NOWARN on
> > the first attempt only when gfp_pfmemalloc_allowed() returns true.
> 
> Is this fix sufficient to do the right thing? I tested it, and it does
> appear to prevent logging of the allocation failures for my test case.

I think we should do both both 1) setting __GFP_NOWARN from btrfs side
and 2) making slab try to refill sheaves with __GFP_NOWARN when
there's a fallback path.

I'm writing a fix for 2) and I'll send it soon.

> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index d0dd50f7d279..d2e1083848e8 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -641,7 +641,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
>  		 * cover our input range and don't cover too any other range.
>  		 * If we end up needing a new extent state we allocate it later.
>  		 */
> -		prealloc = alloc_extent_state(mask);
> +		prealloc = alloc_extent_state(mask | __GFP_NOWARN);

This seems to be a right thing to do to me, but as I'm not familiar
with btrfs, I'll let btrfs folks leave comment on it :)

>  	}
>  
>  	spin_lock(&tree->lock);

-- 
Cheers,
Harry / Hyeonggon

