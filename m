Return-Path: <linux-btrfs+bounces-7499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487495F354
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841591F22422
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8296C188583;
	Mon, 26 Aug 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fRVCD923";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPjQfr20"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164B18755F;
	Mon, 26 Aug 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680541; cv=fail; b=fbigudghfxRZsjtNqVUjaBYuo6EBHxrCBA9Vj5t5yxjRzH3+Fe0UvdwXTZ3xn4aSqzqhZ0PZRKxiURKael4mKAl6R4wdxtEex4mYI8Ps5vk1TVDeNJ9dIEcIu63srUecJwESUzxw7zuaEmC5zaagdUf8qrm0MTUvKPCJQiTzJD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680541; c=relaxed/simple;
	bh=fpytuio02LlbJtfVx8C4hq0JT0Pb+Ytz9Atj5CyT84A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEISzvHjTEZ29q8Gzx1P3if/drK6Tf9NkYBgzfLaYs0R8pMieSRbJjt63ySrDyn6ZrR/tRKIOwDUUdaygMc7G4iB+lZXgPaFxexDH99LQrzgXfU55q0xrnNJl117f1gUAYn4GuNEnXpDsrenZ8FGmt7NPgNqNVIdQu7a7WnokCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fRVCD923; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPjQfr20; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q7fTd1001761;
	Mon, 26 Aug 2024 13:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=N9YKA1cgly+Vk3s7VJTFNXQb5DKZdHiJyW0r1VWGCfc=; b=
	fRVCD9239bY9IyKDkkVJYpjPhLpz2hCr9LHdUqKk2JnZLK9HYu1JWUpBlGGvoxHz
	KI2EJawxBP5cHos1RnCxvNmRPwX+cVEBzdVQPbvTE22V1O0PT734EzvMTWoQBa1+
	s7CExTH7Ivsv2kY67i92Zqv8NZ3HDpaMPM2DtnmMweT4GbT67sDaS10uHqSF9dra
	ypBTEsX7GBNnZOX2hE43G6jwdQXg9Mzda51Ai3z/z+WnFgf/oaoPRQwVjJMwgI2O
	+QY97p3GHX7/IwqcUrfJ1mpvV9nU/bAMESKkfcw7RDMqewIfQa1Vp13zsKhMOhlr
	p1r5rE8DflxrjdKZ2ir7LQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwk5hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:55:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QD0QY6036587;
	Mon, 26 Aug 2024 13:55:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jh28nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmtP+dYlDbxfmM1alUrRW9P3+WDXzVI7irpHHqNr2e9BH9vdF6K0Jho/0v5Dc+/0OtDP56NGY1BXLPsHIP14lwzXG2J+SDnayXxCa9wku4aGbU6kWDKtufnKoR/tKHQe28tNOCMpSm4Ol2k2+i9AeHzsLbYxRPFVkE8CzkXlZOJVwDo7PZjN65mZ1+LViqQGmX4kHeQ2z7ktL0p+QfFr8b5s+ecw6iY9SnVyDbn4QAVmhjagg9uJ9peLaFHX9VYDzjX7IMS/cfUiWCcVdvZ3CuwaE8Xx6cZhgvYdmRm0VllcmP4/9+t7Qp3pv8pq3BK0b9fky7l7g6qaJ8Vwp0Uf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9YKA1cgly+Vk3s7VJTFNXQb5DKZdHiJyW0r1VWGCfc=;
 b=btfHGKilDiVEvgoqnfM/l3YUgjuc/Nx+b39r8pba3C6XK405TXQaw5ghwZWaLfaj57pt65mrVM4YoonMq2taJTPpyUfBRzITNeq63SteFoDPHbBc4kxnvsIjZSpiR4df9kEOvqTBu9CcxliCDOI86K+RFESqswlVR6fG9fWcKEuaV8zvx4H71C4GtZBwZMyuIz3qJMg3+OLfr8aJGDcM+qtbDa3Zl1Mc45BVIqtDSIpMSCgEYMaFWTdWbp2XB3LQnRONvqn2dTve9vAJiGPoLlFmsViB4NW0k1DAj9443KyDcwKbO72OZQ+80ZiihaOMpTPj8ONZhotYlb1nMxcEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9YKA1cgly+Vk3s7VJTFNXQb5DKZdHiJyW0r1VWGCfc=;
 b=NPjQfr206UqY2pzwKlkhjR1+TBgJim5Zei4Z9pVJ1p0gxe+5v9g8P3jnShCvz298pM+37AbYCJdfF1PISzVGzYgTEw4uDXMBClaQJ+Gp715TcZXXj5z3Pf5qGWmDY9cUyc93AGV2GNnV58Tc6rVW5AamFF29Zk0MM6QxdEs4gZA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7393.namprd10.prod.outlook.com (2603:10b6:610:146::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 13:55:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 13:55:33 +0000
Message-ID: <9feb3f6e-b682-4978-9d35-3f5176d96e38@oracle.com>
Date: Mon, 26 Aug 2024 21:55:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: a new test case to verify a
 use-after-free bug
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240824103021.264856-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240824103021.264856-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 877b1e7c-c5c2-4ba3-b181-08dcc5d6c12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmlOaXU0R3h1UzBFTkF3anJJaWI1R2RzSUlrZTVzL3MrU0J2b3RyclRsdXRQ?=
 =?utf-8?B?Wm4reUVSbGE2anZCczdJUmdxU2NFNW9XWnlieTNrY1l1eGFpVDlEejBZNExK?=
 =?utf-8?B?a3o4VlZOT1EvL25EUld4clIxRFZnQmp1TVpOdzFLZVVmdWVvd3FmbEJTc3RH?=
 =?utf-8?B?T1ZiUmdOV0g2Tm0zUVpqZzhpeG1lM0dWRG1PbDNvUWQyaVUwV1pxRExTV3Nt?=
 =?utf-8?B?TDhoMU9qNjB1Mjg0KzJ0WXZhMk1ra01YYmp2Qlpja2R0c2FxZ29XOWd6R3BQ?=
 =?utf-8?B?K1A2QzB0UnpJTXJFUnE0VmNIQ1BUa3lqcE0vV2JIOUEwcEhDRHQvaTVoZ2xC?=
 =?utf-8?B?RTBzakFTby9iVkZDV21kNHlGR2ErYkpiRVliUFNpVVZ5S05BUXp3eU9ya3dn?=
 =?utf-8?B?ME4yOS9zNjdYaTRieUpUZG1Qa2g0Zi8rdnlmMSt3a1dvMGRiM2pNT2E5bGdH?=
 =?utf-8?B?emRXbTY4Nk1xbVR2ZUJOYUNlZjlmWTkrT0k5UVMydi94TGgwSmExcytuYlQz?=
 =?utf-8?B?QnIxWkJ2RVZaaFdIaGIrZVJJSUd6TmtDUGRiR001OEVMYXJ0TXVkaE4xT1By?=
 =?utf-8?B?aWhwY2kxUTJjRlBUY3kyMi9RUWZtVWhHRXJEZWtLczcvTHpjdkFlb0ZtTUhM?=
 =?utf-8?B?UkMyMnJWK3VINS9DWm13ZW5CaTdqaDRRRHJneWNPeWxWeXR4ZWpBTVZrUGtw?=
 =?utf-8?B?Z1poalVNbmhwL0x1WllXMmI5b1NvQkFDdVJmM1lnbk5lS2hidk5KZTg2M25q?=
 =?utf-8?B?OERxazRTZTNqNXlodjN2UFJrMUIzUjJjZjhBR0gvMWFnTmdMbWptS2ZFTFRZ?=
 =?utf-8?B?dHRGWThMMERUeXZ5VHJPZ0JaQUhUbE9CbjV4b3U0MWd0eGQvQUJZUVNsUm56?=
 =?utf-8?B?MXV5ME5jTHN2OUFUaTBpMUNkeTJpR3JvaERYU2V4ZExGcU41QjkyZmJjM2VG?=
 =?utf-8?B?R3I0N3Y2c0pZRk5BR2JUUEpaTjhoNEd5SVdEMHdQMDcrTnZIMXFhZE05WUFE?=
 =?utf-8?B?MVJhMjFIa2k1NXFFS2dJT2JidlZRanpoVFlHSVE2WUtXNWxxR1ZzdFNTN3RT?=
 =?utf-8?B?SmsyLzNzY3dyN2NmNUc0dkV0M3ppVU5ZUGROY3RjZUhUV2N6WXo0cldJbExo?=
 =?utf-8?B?bWYzSEs5VEloNU1kN3JESmx2VkR1cEVudXVTU05NN2tJSG5mREJlU3V1SE5l?=
 =?utf-8?B?R1ZuQ3hxV3pCV3pycVhLTjBzbXhiSFZLNGJmdysvQUJSR2Y2MW9wYXBobXUx?=
 =?utf-8?B?RDYwQ3RKdmw5Q3VyU2xNZGM0cFh0NWVSdGxYZHpYWm83RWM4dVJTSktUZ21Q?=
 =?utf-8?B?QVY1bmpYSGswUXRHSmhCcHBrWmdDcnUyWkIrYVpkeEdFN0crcXN0M004bDlI?=
 =?utf-8?B?cmE3NTFQbDkrTmFFWFk4Q1Iwb0dkYjVDTWFxOTdzd3JOb3FSWHNrelhsT1NF?=
 =?utf-8?B?U2xFaExVZlBQb1dSaHdTdGF6WFpML0NUTmZoamtRblkzalhWYWd1UCtaWmZY?=
 =?utf-8?B?LzA0aTFjSXo3ZW4zMDFnMTZZbEt6VkZlbWErSXFLaTFnWk1NTVQ1VmhXZisy?=
 =?utf-8?B?bExPYUhOcTBNYXdNWExaTWozT1UxRkNvbjFvR3lOMHNKWjVjUU9lV0pEUE9q?=
 =?utf-8?B?eXY0Q2JLbEp6dUZiYnBsS2FUVis3cjR6NmpuaCtnT01HUmQ5cFpYendXcVNI?=
 =?utf-8?B?NnZkTG1nRWlaaU9IdmdZRHJHT1JvZzJ6QVdsUStuZjhZUWRlNmhNY3ZzNzFL?=
 =?utf-8?B?ZDNxTXU0UVZEY1RQdlFtbGVaMHVrb3NVSEVkQ3pjQ2w4bVQ1RnlvMTMyK0Jv?=
 =?utf-8?B?RDVsT3NpckhnRk1uUFgzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlLT3VmK3Q3b2k2SC8vYTd3L0k0RDdhVk81ZXlsTDZVUGJYN3RSckV2dW1v?=
 =?utf-8?B?b2h2TU5BdllIMU5IdGNaODZLTHhNTWQ3VjNHdHEyVGFDcmc3ZWtBNDdJWXRo?=
 =?utf-8?B?QS9CTEdaTzd3WCtGd0NiaG5TdWExNysyRjU4c1VZTFF1bjZscURQRnE3bVZq?=
 =?utf-8?B?TkxTTmRNeDdhQWJRVXhKV2dEUVpmcVk5NHVzN2ZjSUI4bUJISVg0Y3hOWW1U?=
 =?utf-8?B?VjlXRWtpNmdKK2N6akVaYVk1ODZ4RVJOb1ZjeGpheVNkb0VZVG43K0lGVE10?=
 =?utf-8?B?K0tFLzc1T3VnanYyUWxEWDhnMTVlQkFFUk5HdkN3d2RBdUlrRTFZQUhKdFo4?=
 =?utf-8?B?OGNlaFJGWVM3QXZkVFNMVk4yYXI1Rk9xZzM0eGtiS1drRGV0K2Z6OXdJb3pK?=
 =?utf-8?B?Z1ZaT3YwUjRtWks3UmM4TU53TUt5bTRGcnRqRXpmaFZ3VkxaSENjWkdEc040?=
 =?utf-8?B?RUJENEV0SkgyRk5JMER4NWYyVVphZ3psNHhSSjZMY3RGdmNrWnpacVgwSE1U?=
 =?utf-8?B?TFhkMW9KYkg0aFdBdE12NUlDMjcwTC9OZnVDVjVCWWdjVlhGZDN4b09mcWpt?=
 =?utf-8?B?RldNcUpROHVCdUpDcEtHa3R3UkFDZUJTcFJYZGJqWjdFZEdYWnJGL2Irb0Mv?=
 =?utf-8?B?MVVWOFgzVHJjTXE3YkpFQWJ4UmRuVWJkK0ZrbFNReWNHNlJ2OG12VFJ2R2ww?=
 =?utf-8?B?bHRmd3ZsSmNKOFpSTzdGNGpPMnZiSnczQlBPM3ZHRk9lTkNBN1d2UGVTSzJJ?=
 =?utf-8?B?RVFjWDlBYTFYSFpvTlc4bWZjQ1E5bkZUd2VLY3Z2cm1wV29KdjY3VnhYNm5v?=
 =?utf-8?B?Q0N3NFAyZDgyd0ZCMzFHUEVONkh0SzR4b3ZrMVlXdEZyZDduTlFkbjlGNm9G?=
 =?utf-8?B?TnVGbmNmUzcyencxVUh2NW9vZEtGbXQzNmI3MFJJQUJ6c3ZreW1OWU9WdnZG?=
 =?utf-8?B?MFhmWjQ1UDgwbWN2a0pHejVlQnNmNlEvekcwMmE1VEtUTmRDQy9VejhXbG9U?=
 =?utf-8?B?anZYOG1jTDExL3pPY3JmQnJ0Sm5nWFl6czN2QmhhYUtONUpZaVRLRVZyTmUr?=
 =?utf-8?B?cUhJZEl4M1hCb0YwQzZ4K1VmVk94SXRjeXJVRjdUZkZJc3dNUE9sOWRHSVBW?=
 =?utf-8?B?bkVJVGhwdlJkYW9kVnhlRFZiYkFwN0lxNndVeVpadVB5YzNpamJBcUU1WEZr?=
 =?utf-8?B?K2ZZVVYzOGhlbkN4YWJTdG9pZ3BNRVRSaThjUjBUbUMzalNXNGxhbjVqYmVM?=
 =?utf-8?B?elUyWlVrUGhIbnl4bmRIS21aNlVoazhSRHBlQWYvWXBKTnNGQnA3STh6T091?=
 =?utf-8?B?MDEvMkZHQk53ejNnYmI2MkRIK2V6aTlKZFN6ZGZxNXE2Wmt2STRHbUh2NUtz?=
 =?utf-8?B?djZmNnk5N3A3QjdBMW9KaTNGOGRLZ1FEMjJPdHZPU0o5REgvS010L09ad3Jq?=
 =?utf-8?B?cWhOV1VKNkNNZVEvM3VMeTlSa1NqZDlGSHcyOTdWM1owSnhWWE44TnBpMm0v?=
 =?utf-8?B?a29ZV2UzYzdJcHZ2Znpsb28rYVJZdTEwOVE5ZXk3cVFYVC9FeFVjWG1sRlpu?=
 =?utf-8?B?LzNXRjZtU2tZblNxVmpRQjUwOC9kK2FVNkoxSjdxYyswVUxRQU54Zk10dUpH?=
 =?utf-8?B?SThyY29WY0krYlJOK2c3bGkrZDltS2oxUm9CNmtodTRDTkpqSThNSzlsMmxz?=
 =?utf-8?B?Z0tzTVdnWkUwQ3NPYjcwc3N4WEVwa2xtYlBwbGFMci8zYjJqSUp5WGIzL3kr?=
 =?utf-8?B?dStFenZiRXoxVW5pQzdPV25heVVCcVNMSjQzc0dGTkhTQlp3Mnc2cmZoRHZG?=
 =?utf-8?B?UDYrR09pRWZ2bjFjRGl2aW15OHRZZlBWeEVsUDh2b2FDa0dnZkhWb1RrczZt?=
 =?utf-8?B?dHNRaVNvd3dvSVQ2WmJHcGVJWlVUYnlPdWYzQm52d3ZnZ3NJem5MQXFhcTFS?=
 =?utf-8?B?Y2xPYkwxbTNKMHE0ekNoRE53eXo3NFNYcUtrNTZoWEp6L013U21sOTdFODhy?=
 =?utf-8?B?TWowUHZpOTY3eWYrSG9JMGxIQVZHSnpyWVd4U01GNUlreXc1V0R1MkdoRXNS?=
 =?utf-8?B?L2NoOWV0dVFXVkV1UFcraUlmS0VoZnIyVkdwakZnREpMR3lIYTVNSEhGYmRK?=
 =?utf-8?Q?caT81qc8KsJVaX8SrXoRMFBe7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1N9xLOi7h0w/NgqZvRpwt1toCw3IOifImwXf28Xf45vljOJ3OpcvcPFOp4Zk0cA3mXpQjDx2rPbMAed0eVnyNoZL/95zy+J8uI1JVYcPnBcOFADPAAjHRil0wM1gBJKY9hf115lj8/CnbuFaeY4VaqL6C5pG0GUJPZGhs241POsPnl9QV10jBUhj4g0dOiITkXmUNrRFonjOhkAbG3tfFbRmu4v/9XoHM1jMUASX5qx/L+ClVayAzZYPvFyfGIfaNb1PSEju18F86SCJidCD/BLHFWIKZM9QyPw7GoauCwvknpieDfXzYsYvos5cLaB3NIVvmbEJmKgj3BigwIOQ31tTG1hnK1FWzXo33yzGQw2xgtyHAZA+6luSy0bxtQBW7MoBeg8XadUEifurPAIRWHNwuZnfRRp+pv1eMe9HtFxb4t06Mtm7t/IEXk25qsUWlLdf4ppYKKYIGgINwkDkwD8xYDWnd8X93C6PieZpXolIzP48hLdyQqUUMay7Ornyb/099SZNtejVlmvvT4jTVzoUf7aRi36XCvcywT2ErDyQ6FzO6515gdmGCH5WpdXcS2M3QNIx82VKrorfYQNpOYEMFQUQV/rL2Wh4GRv6xg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b1e7c-c5c2-4ba3-b181-08dcc5d6c12d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:55:33.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oJapecEsjUY07+jqQY8sdZExgV9dipnx0inLxVkhPZhjAPv/vLMF/+3zljEREwW55R4UrSOFYqThXvMJBBKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_10,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260107
X-Proofpoint-GUID: 1__nzuGIP-ue1syn5HB-x0Slzdjzrkp2
X-Proofpoint-ORIG-GUID: 1__nzuGIP-ue1syn5HB-x0Slzdjzrkp2

On 24/8/24 6:30 pm, Qu Wenruo wrote:
> [BUG]
> There is a use-after-free bug triggered very randomly by btrfs/125.
> 
> If KASAN is enabled it can be triggered on certain setup.
> Or it can lead to crash.
> 
> [CAUSE]
> The test case btrfs/125 is using RAID5 for metadata, which has a known
> RMW problem if the there is some corruption on-disk.
> 
> RMW will use the corrupted contents to generate a new parity, losing the
> final chance to rebuild the contents.
> 
> This is specific to metadata, as for data we have extra data checksum,
> but the metadata has extra problems like possible deadlock due to the
> extra metadata read/recovery needed to search the extent tree.
> 
> And we know this problem for a while but without a better solution other
> than avoid using RAID56 for metadata:
> 
>>    Metadata
>>        Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
>>        respectively.
> 
> Combined with the above csum tree corruption, since RAID5 is stripe
> based, btrfs needs to split its read bios according to stripe boundary.
> And after a split, do a csum tree lookup for the expected csum.
> 
> But if that csum lookup failed, in the error path btrfs doesn't handle
> the split bios properly and lead to double freeing of the original bio
> (the one containing the bio vectors).
> 
> [NEW TEST CASE]
> Unlike the original btrfs/125, which is very random and picky to
> reproduce, introduce a new test case to verify the specific behavior by:
> 
> - Create a btrfs with enough csum leaves
>    To bump the csum tree level, use the minimal nodesize possible (4K).
>    Writing 32M data which needs at least 8 leaves for data checksum
> 
> - Find the last csum tree leave and corrupt it
> 
> - Read the data many times until we trigger the bug or exit gracefully
>    With an x86_64 VM (which is never able to trigger btrfs/125 failure)
>    with KASAN enabled, it can trigger the KASAN report in just 4
>    iterations (the default iteration number is 32).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the wrong commit hash
>    The proper fix is not yet merged, the old hash is a place holder
>    copied from another test case but forgot to remove.
> 
> - Minor wording update
> 
> - Add to "dangerous" group
> ---
>   tests/btrfs/319     | 84 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/319.out |  2 ++
>   2 files changed, 86 insertions(+)
>   create mode 100755 tests/btrfs/319
>   create mode 100644 tests/btrfs/319.out
> 
> diff --git a/tests/btrfs/319 b/tests/btrfs/319
> new file mode 100755
> index 00000000..4be2b50b
> --- /dev/null
> +++ b/tests/btrfs/319
> @@ -0,0 +1,84 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 319
> +#
> +# Make sure data csum lookup failure will not lead to double bio freeing
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dangerous
> +
> +_require_scratch
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
> +
> +# The final fs will have a corrupted csum tree, which will never pass fsck
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 2
> +
> +# Use RAID0 for data to get bio splitted according to stripe boundary.
> +# This is required to trigger the bug.


> +_check_btrfs_raid_type raid0

Did you mean to use _require_btrfs_raid_type(raid0)? Otherwise,
the line has no effect since you're not checking
_check_btrfs_raid_type's return value.

The rest looks good.

Thx.
Anand

> +
> +# This test goes 4K sectorsize and 4K nodesize, so that we easily create
> +# higher level of csum tree.
> +_require_btrfs_support_sectorsize 4096
> +
> +# The bug itself has a race window, run this many times to ensure triggering.
> +# On an x86_64 VM with KASAN enabled, normally it is triggered before the 10th run.
> +runtime=32
> +
> +_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
> +# This test requires data checksum to trigger the bug.
> +_scratch_mount -o datasum,datacow
> +
> +# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M data
> +# will need 32K data checksum at minimal, which is at least 8 leaves.
> +_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> +sync
> +_scratch_unmount
> +
> +# Search for the last leaf of the csum tree, that will be the target to destroy.
> +$BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV >> $seqres.full
> +target_bytenr=$($BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
> +
> +if [ -z "$target_bytenr" ]; then
> +	_fail "unable to locate the last csum tree leave"
> +fi
> +
> +echo "bytenr of csum tree leave to corrupt: $target_bytenr" >> $seqres.full
> +
> +# Corrupt that csum tree block.
> +physical=$(_btrfs_get_physical "$target_bytenr" 1)
> +dev=$(_btrfs_get_device_path "$target_bytenr" 1)
> +
> +echo "physical bytenr: $physical" >> $seqres.full
> +echo "physical device: $dev" >> $seqres.full
> +
> +_pwrite_byte 0x00 "$physical" 4 "$dev" > /dev/null
> +
> +for (( i = 0; i < $runtime; i++ )); do
> +	echo "=== run $i/$runtime ===" >> $seqres.full
> +	_scratch_mount -o ro
> +	# Since the data is on RAID0, read bios will be split at the stripe
> +	# (64K sized) boundary. If csum lookup failed due to corrupted csum
> +	# tree, there is a race window that can lead to double bio freeing
> +	# (triggering KASAN at least).
> +	cat "$SCRATCH_MNT/foobar" &> /dev/null
> +	_scratch_unmount
> +
> +	# Manually check the dmesg for "BUG", and do not call _check_dmesg()
> +	# as it will clear 'check_dmesg' file and skips the final check after
> +	# the test.
> +	# For now just focus on the "BUG:" line from KASAN.
> +	if _check_dmesg_for "BUG" ; then
> +		_fail "Critical error(s) found in dmesg"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> new file mode 100644
> index 00000000..d40c929a
> --- /dev/null
> +++ b/tests/btrfs/319.out
> @@ -0,0 +1,2 @@
> +QA output created by 319
> +Silence is golden


