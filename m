Return-Path: <linux-btrfs+bounces-10800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338FA066C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466253A19F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D252036F3;
	Wed,  8 Jan 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihZnCAJG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rQAF4w/w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE21AA1EE
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370132; cv=fail; b=PGoHdL6TyoGduC9SL67TlFStQosJThP5M8nFZHgpmOLN1Fe+dcAx8YUnQzan6qgWRqQtK8VeSCdRbPKxIYKbNqhcrnotUw7AJ/r7CzpajMu0n8ovJIWgYzFPPqKHOkZb7NdZcgwbqSY3mpg2K6QRzv5+uLo3+soEIoJW7tqCcVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370132; c=relaxed/simple;
	bh=ete0NtSChlwiqyjBqk8ohxJZrcvF7tk39ksdSaq1RGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2yYCAbsqd7FYmnQvh5waW4L9N0d3cFR9KAmcp0fxPc1/jbpzASV/LM2XvMU34cVJZxbDGGihVrpwo/5jhLzrCcXPiI1OaUYDVKIKew+vjVjh4KDBhxBC4Leym5fsmKevk+lzmd6raca11GN5nGnbFCSA836iJbdStBrH4mCc9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihZnCAJG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rQAF4w/w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMrZO029521;
	Wed, 8 Jan 2025 21:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N8d3CzRXGNpBlymLfP09c4jGUhNtS8eb4vbJZrg9/Ho=; b=
	ihZnCAJG7J0lZz1bNwaSfWu39g3lAXQHiBk472uQgyYCC4WRdktxKlcFxMg0/ws/
	txLjt6E0mdpy9Kr85rtY7BY78Rw0MEJz1Ti1LCqPaaBDdFR8l5LWJqurr8oi4Urp
	Fh29RvEyA4RpjRhtyPn3viCUKF7nqg4lfjfAvV4H1NZMqT6fGxi4bJ/0E0YDm5U9
	urzvG2aSwhYiArr1tOZ/KEJ1zfnZhXvbUhwmNLGFL/HdstLkjvRedhSuVvEw24AC
	PzbitKi0eqwML2aIJce6bRUSyflD76fRrkKaim70A338WpFTj77ojAryPTrZYxiu
	jjDzQO+gFPsGEnmLmFY/Gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk080pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:02:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508JtVgZ002803;
	Wed, 8 Jan 2025 21:02:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea96c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRicNN1IHRPsod4cndW5olKeknw6VguundfXb+gfnNIEAYFQUC+Qz9Tq5SIC2SNI3fM0nILkbJ2TEZ7KFleeNakwNuCKwivpJuZ0G+gV62z3ys+E+ajR98Og+Z5tuA99oZufP9Hu9dFBn1cxV6+d76ohjnR1usTqqDCL80Ddz9Ab0lcREAiRSg+n2MJVtd58E+WFjPQHPSTY9gbDzrQgiUrEndXccposMh1z77IPb16uSvKGZF0YAg3+BOM71U6DiYnhBnfW4ftHD0tdy2uHkA5K6eKOin2czZZav3DHNcKYZeM7pGp4PC3pXdodfWCDuBSn1KlKflFxLuuPGVijWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8d3CzRXGNpBlymLfP09c4jGUhNtS8eb4vbJZrg9/Ho=;
 b=hGt8AgaS2D6wJXl4e1Mo0ho46sJxXQ/ERQFkzF1qMJFSaCzwA0iCjBoy1gRMpQPJNfIc47H/1WHzrgH4/mGBxp5jji0EYYh2wGRCct6BbRc26cx50xBuvUtBl+pHt4crAWnEKnOv90jwp5Iij/3r44793X3+7fVqfumaTatEYriHuVB209vhge9lkFAtJbk1VN0zMWbvcT9iUtbbgPqSY3haadAhck53ZTd5gkluzjgCOQ8O+9J5jXteu+mqmqSpuYIF5sphQ7j4iTE3axVj2fCINVcQLOqczS7357Vh4Q+i0d8HzpCfUlZXXLqeHLOx7VShatK5cFudshWzm8HILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8d3CzRXGNpBlymLfP09c4jGUhNtS8eb4vbJZrg9/Ho=;
 b=rQAF4w/wpojAkcRzEtRHiGFMwmnsipdL4u3IMCHYonsYHVFbypszVA7Hp+pTP2SogScwznGBGmsGM6t66BwJWTwfO92pmNYYTsHqeLk+x3pGgZksEIrjvd01W7OMvrxEjQUUZRuq6rqM3zXnix/Hk/SMLdegB2IawOLf9PSdko8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 21:02:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 21:02:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 2/2] fixup: btrfs: introduce RAID1 round-robin read balancing
Date: Thu,  9 Jan 2025 05:01:36 +0800
Message-ID: <bfd1e231b875ad2b3a7d9b1749b9a02428dd7426.1736369474.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1736369474.git.anand.jain@oracle.com>
References: <cover.1736369474.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 291a71bd-4271-419a-45b6-08dd3027b507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwmCxdmQnOEF3kGZxHEGGXWpcwbgOKRxIMTogaofFiSAQMojsDqY9JOnryKB?=
 =?us-ascii?Q?BV3QL15x00hbZnqhSqrU/9aMH7TMZ3zsKuryE4PDS7qEz+fP/7BQvrGaHxFZ?=
 =?us-ascii?Q?HDC+F8oRr2rnrf4ID4Cufowueoe2XRfslb0h+6GNlis0MxRRxgt7TUFufija?=
 =?us-ascii?Q?T7N6fBzHYlKMbxCOqrWXTm5CStA8WisQLuWZHKFNT7NfabSMZW4CfrLoWUm1?=
 =?us-ascii?Q?SDfKyxSpc5SmK+RCx3ZPfteQ60zYhcXDtb2SRLLMbkFoM5D20xeRKCwcjIcj?=
 =?us-ascii?Q?tpfyCmfLM/6rSLMN/0nu7HpWBUWePlvAX1P1kI+X+QJBj2UCPkzMEn961LgQ?=
 =?us-ascii?Q?EqiP+FAgbGsH+Z2L6/Tb6u9sPjAQvtU9wBz7SRIeaMPHwoVafITUeLLaDJ5F?=
 =?us-ascii?Q?TZIiJdWnHR7M7BETm90VXiswn/fSM/ogWwlVrH/Q+IOKu6F1WhhJycaUMdyh?=
 =?us-ascii?Q?JcJqE5cllrxK3DrIi6y4mviy8eYOSP3WcI+6rfNTn9Q/UeRl7aVAt2f8YM2Y?=
 =?us-ascii?Q?FvrVZk3iEYRPKK907XnLBO/CvGtXf0oKHsnCT0kKTKlo7HXCerLGMEFoKtxE?=
 =?us-ascii?Q?Lv4Qw0ahGxrL05+et+ppnCi3XogVm+i5p5LyCfdu1ihz+BRf3vqGUqTedadP?=
 =?us-ascii?Q?+9mRRL39s9+bkYDRxX182BIEKK6/jcEOqgIidA/yOhEiKQXAujBHA51Lpkwv?=
 =?us-ascii?Q?93wxSJ/z176MTR2E+5B5P0tScYAD63Zc3B0gGGk9YnRWo7+PmKvE/kkmZeSJ?=
 =?us-ascii?Q?i+JMmlwlXlCoEOxZHppXU5eK30cfbQojZyLAk22HTASFcxTOX5freXQUh+i1?=
 =?us-ascii?Q?ej2QCTO4bYPy1gUe26sBj1tKCapbJFzZIlWdKVC3OYoJY8pMtMklbo5l/nnd?=
 =?us-ascii?Q?m852xqxlfpcgG2SDrYgsAop3vy3pWm4jepMp2sq+8h6AG4Ia2oi3GrJqUGID?=
 =?us-ascii?Q?TiHW+T4FROITDLhS1ZGtEItWieJ4me58K/DEDis5Q099Jt1cafC2US9iYbYX?=
 =?us-ascii?Q?Dd5hPuonONaNXcR9ibP7AOsgvRrnEEHYraW9Ota/jUCdf6oTUxtQZ3XERssf?=
 =?us-ascii?Q?ahenNIZ8goMRKreux6FuoiSzvzC/11X/uQx11lCP72RMNvqUFdUdFdkEbkyl?=
 =?us-ascii?Q?oCBt7KR/OCkz3xzbH5aKIq8QK42oHt1MvN3/a0ZEPvP+NHyOvKPTKzsCv8ZJ?=
 =?us-ascii?Q?j2biG3x7c/P85DFraT2S6qF8nAAE9w1eu4Cmc5Q18G0mOyJQyhysFEYM1bsN?=
 =?us-ascii?Q?LZlkQhqS8YelF+voaJSIL+on47DkeqiFIRZNcWJg9WdEDQvNPDNiD3lnVY/y?=
 =?us-ascii?Q?cVAPHjQGzJWh60tmntO3n+noGitbI17bHOW6dabfnsKJ7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ox/gPNSBf35k/7HwlCJ4tx1D/sSE7+2XiwjERSmFhkbWrZygGjSqyIkur3XT?=
 =?us-ascii?Q?pDXRcQnVf+56irsrr0U9o9kWp9YXSUjmJq3mJQU7jaS8lbvDTt/FSxGvxyEw?=
 =?us-ascii?Q?iL3BUn6/rWtfhlihQsUyDWWuVYnQUQ8YxPF6briqzAomdk0Vco2IzLFNnxkk?=
 =?us-ascii?Q?+XimjOyG3j7ks+mbK+N6c8gT8FlK8t/ftAKQxXYbyTpXwM6QyO4vjWfyTuhi?=
 =?us-ascii?Q?aQZSxWZvO/9KXQVfwhjaGl1ltZbg6NFkWm8oPh1hfv+M/7i9eay6VmrnqFwL?=
 =?us-ascii?Q?HI/X/+aDbUPP4gh4D5OMASqAe3L/1cqEVsvCl34xdeTkDrh1muLrZ4Fu/zso?=
 =?us-ascii?Q?tdNdG+JVJo11zmQM/1Am7czraDOHGpTvoUlvFuEy/tEyBTY0U1sjSfjlHydQ?=
 =?us-ascii?Q?lDeCneWgAIQG4YfGDTlLw9Nl0yQh4sAE6x6B+71N0pKmiBYjfcw3FoFELUkq?=
 =?us-ascii?Q?Wwu3zB3HU2xLCU+PsvJLTacCprlb2+kDCLEtmo2BlMmZYwYhMvHCXrdKZQf1?=
 =?us-ascii?Q?i7HrmHjmzalYpWUZ1z5HgTlLFgzGuzY+Hq2E2aUFoF6mu29HMVeNS+jcrSz+?=
 =?us-ascii?Q?3Vdh1mKR9qANhejAe28mvhwMb89rt6KOI6EjMVCurEHHYEuJTd4QN9/5xplA?=
 =?us-ascii?Q?+hHnCw81RXXf2ysRVmuJ42TVmuTU2w3LLZ2tr1SHodpAz/KUBZs1VVqSbdTI?=
 =?us-ascii?Q?AR4Vb7KWpkA5MIvStXPaIzoBpvfLA6mB/dkxHgnQVP+UeV6GzoNUj/U/TZr2?=
 =?us-ascii?Q?dFSymExwaCh3tUXDREG37gJNnu+F9155VBR1UhWQ24uADpVhMfEHNWWYvg/5?=
 =?us-ascii?Q?rp6Yu5f+IHMXCc4LK75Mh0B2S/UABvUCmBcboCx07Ie/TOmhlhLobi7WRuVr?=
 =?us-ascii?Q?G1kt3oyVHz0TOaoPAb54i/iUL+BAok9X2VXUTrt6R5yAyHE84T4NJQZkrowW?=
 =?us-ascii?Q?nhIPh6dvFJEhF7ysusk+7vEwqyvb7LYMPWAfGQiNe4m3M82mRyXoMcTdnSWL?=
 =?us-ascii?Q?3Gd2vULZwlIdCJJTNK5A3sLPPgk6PSn79bFHnSrVHChd37HVkPInTFRnwCPP?=
 =?us-ascii?Q?bsG6pTRaLJfyx1cDwymRlXJqBMRm4jpWas0ZccLoTusAoIVXHWNQf0jN5LQc?=
 =?us-ascii?Q?NE+HRkYDOyjkUNIrhokS37Y5d7Bh8giGKT3UMVYFopyBv4wsgbYN2YXpDfqI?=
 =?us-ascii?Q?YgXaNG3+0oPEM5HZ1AH2uG42IdSzHxUm2rt6dfjcGybJXliV+aD/Tvd+XZq9?=
 =?us-ascii?Q?9L2MWkNkdLOo4lUI0TXvTbmc81PiNEpTVg4aV6sB1BBMddmFOilzTxE2EW4f?=
 =?us-ascii?Q?I8lxV/gvHTC2BciDvuDyJfM3TjpJuW/cIRUmrqvF29c+Y8QADii9shBwdIaN?=
 =?us-ascii?Q?V96ekkfMGfw0JePJFzX2UZ+lkJ54xhgmzYriWp2cLEqIj116z0EAhDVPiBSR?=
 =?us-ascii?Q?QGclbSPkub9xlkb6MwqrnBkIetobRw/zQYV0VFdZmzCNX3C5NgASva+mxCus?=
 =?us-ascii?Q?8ZJReytLP7jfzs3W+vvJg8RqGW2ViNqknWAuxHCs5WPmobd1/GCScVhU+Orc?=
 =?us-ascii?Q?hMP/SWUKICSZiYXgKYB0NPNPvP1wVHUyqfv583Gq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dpE80ow3r/Ig0b+0VCUVQw54L8Urt4+kUqSs7oBaId13r0i8kY6p+KlPOzs7mdS4rhk6S+bYvymFlEOFUsRubW+0tr+CvZiODR5GaPOvKOPPO/eUL1pF43B8Uxz4ZvUDZ0MKU6F0u5HvtykzWuMWYZDMZG8UCeDG03fFJDnrdakLmjftEMmctSMD7WDJmu6sQlmplp19rQsYMtzCbB6wVLu2UAYFfXtKBdZ1Mci3SC8NOxXc/XGvUeCrskXbJAGq29knwWtEQXDGxrV+9q+7ex+miV0dMf9r/8MaoSir1sKAWN8wzZqq5+LCWgZCADtaVeIXfKxQGYdgv8Jhop8fi1SSYxQ/w3kEtr00mH9trtpHnPJvEius5tVLWDBR8MDxRle8ujtjUfd44TT1GEOlJ29JuKFHN9yvH2V59mvsfjQfdegreVO8JXQfufQwiQgj1Qva9SS5ofLOUSOjyniAqUczFOk9IMWHBZQnTh4RYVKhCvIDOr9o3Vn3GXc2GJjwuYsNII1hROi+pW1ja5X5YqTaJ5mWMoH1lTltfDjjPaX2omoyJRjpamWImMl4bBbRwdVHI+JHJLy4mgz0/O0QdvchsjHYsWf1FWppQianCJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291a71bd-4271-419a-45b6-08dd3027b507
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:02:05.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ETU1CefzxJiPHBdcvk//XCDPFw7JhXREVxi94caiKdyLaK67DxgV4hMXrpKil1onFXHl0bocyvaApZT/d/hGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080171
X-Proofpoint-ORIG-GUID: 9FAjIKZN_vOavIJ--CmkpD-mODhrAPJi
X-Proofpoint-GUID: 9FAjIKZN_vOavIJ--CmkpD-mODhrAPJi

The member stats_read_blocks has been moved to fs_info, so update its
usage accordingly in btrfs_read_rr().

This is based on the `for-next` branch in the repo github.com/btrfs/linux.git.

Fixes: ee37a901a9d2 btrfs: introduce RAID1 round-robin read balancing
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e0c64246f8f6..a594f66daedf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6018,21 +6018,22 @@ static int btrfs_read_rr(const struct btrfs_chunk_map *map, int first, int num_s
 {
 	struct stripe_mirror stripes[BTRFS_RAID1_MAX_MIRRORS] = { 0 };
 	struct btrfs_device *device  = map->stripes[first].dev;
-	struct btrfs_fs_devices *fs_devices = device->fs_devices;
+	struct btrfs_fs_info *fs_info = device->fs_devices->fs_info;
 	unsigned int read_cycle;
 	unsigned int total_reads;
 	unsigned int min_reads_per_dev;
 
-	total_reads = percpu_counter_sum(&fs_devices->stats_read_blocks);
-	min_reads_per_dev = READ_ONCE(fs_devices->rr_min_contig_read) >>
-			    fs_devices->fs_info->sectorsize_bits;
+	total_reads = percpu_counter_sum(&fs_info->stats_read_blocks);
+	min_reads_per_dev = READ_ONCE(fs_info->fs_devices->rr_min_contig_read) >>
+						       fs_info->sectorsize_bits;
 
 	for (int index = 0, i = first; i < first + num_stripes; i++) {
 		stripes[index].devid = map->stripes[i].dev->devid;
 		stripes[index].num = i;
 		index++;
 	}
-	sort(stripes, num_stripes, sizeof(struct stripe_mirror), btrfs_cmp_devid, NULL);
+	sort(stripes, num_stripes, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
 
 	read_cycle = total_reads / min_reads_per_dev;
 	return stripes[read_cycle % num_stripes].num;
-- 
2.47.0


