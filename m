Return-Path: <linux-btrfs+bounces-18068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F3BF20CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 306F834D9ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F9224B15;
	Mon, 20 Oct 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="M0X0WcPi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553817260B;
	Mon, 20 Oct 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973439; cv=fail; b=WSnvI0D39AtroSV5QTxpw+qzbXT8xyMkIQl9eZ0SYD7iD/UDQOfEkUJY0m0FpWmDaQfLJ2MBg4bOvRBjAo6/aJb47FR+6F6IbvbDn1YVWbpM3NiN2qDrYq4iXeBqcaBu4Ib/BCozSZEdf2vMAhscZdeBNVUzQ/B88UqCyIkVZfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973439; c=relaxed/simple;
	bh=UmLyDyEHSJ1ZBuf0J0zDmVMK6QJAjyKL18pL2n95ys4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXdLMl2v0y2C8N9ru0AEY2x4WSuix3gXCvqeGYHrMDxrtq9fPovxkzHpnksQLLtu/+e7hVWP80hWvDZ9I6QLlEZUKpNZrzYXoZcuN/6lFg6j5RkKGIFZGoj7Hl7UW28A7m/jaUNRcSqvR2YObuImDEW+NtN3Hb1N/tnbH4jbqgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=M0X0WcPi; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 59KEbSFB3904752;
	Mon, 20 Oct 2025 08:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jxobzh/FC4oXKC7xc84CtuPTujwYV+iDfuMrGlxTDfw=; b=M0X0WcPibFlg
	O98x5/M+MrjgNVqLCMdK4vwTKwgCPUREDYdCi4V4FMdWrhX9NsQAGVLMmXPuUEHx
	m03yUdBB73bYguZjIOqJ2nmihOpaPoK6ay/dsannwQCqw+Tiedly3LaspbANDuph
	8oYfmOcLkaB+w6DdQDqmSpZtMx7LIXf+A999QQQ+ww6nW+wfGcVf5ULdjHGkOWJ5
	v5N7OR18v1bYKlXu7ogXhP+dC66u7IThYaNXXFm9kf06h+6Jj5XIO2pRbu1fAWvX
	HMjwga67Au5l2pYfWGvMhxJiwcPzFsteUgQsTZlZjeRG2q7FEWSOUTw63XC+etb7
	6AHrhEj6bQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by m0089730.ppops.net (PPS) with ESMTPS id 49wq0sr9y4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 08:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj5jspK/K66aIZaL4jrALDgKWrDpd8qmnVFUp7DvhrpOs17Gr4rSr1otWexEYRFbelNVjFLbLzzUxST9SxjTeaFA+uV0MZ4Vpm4ZTxUL3X/MPsJ6SUli+wvpjd5gw6hsDfJZhGae7tNChG9+unMwKB2YvSunfjpRTwUE/J1yvUpa9g00pc6FHn7Zvagz1K51D0Iv8XlKOj74MaqMA2f5+QLjdflBi7RFI+vg9JQuipEbexGSwmTOnQR9jNOpGG0CxlGh5cctH8Ch/PcI5h3vXAdKKnsC1UEy7SabalEH/9aZu/roFK6GtkNFSBTmlAxlZBcuqMXm0LyW12HKJoKFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxobzh/FC4oXKC7xc84CtuPTujwYV+iDfuMrGlxTDfw=;
 b=hA6yh+Beizo2FyffmrmFX7KC01HtX/xYd6TnajnLPPcfXbYRB5XYAFiFH0Z/Ie9x+8+38MY0hVlcM5dcwhV+h7LdZavsxlqErlmIWOmVSIirhSX6izkFdzCutWPaQ39TR2XzxiOlUnE/b0fLCJ4d5oTI0dt+A8WZS3I4FUKKTR/ysrkLkoJ9cNSjUY/rVbMynZ/5PX9KaQ54mSbVxoz4XfHVQYxVy/rv4uy3FxWeU/fHL2SHoikp0qcX7DaCnq7Qlmb8KmDc5kDVB3J2cAgMXl14pTP5uEav3hio1Nu4xvCdxHn/+KqAm9jU3TffKIgv27jTpBnufse3VUmJuLZB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CO1PR15MB5099.namprd15.prod.outlook.com (2603:10b6:303:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 15:17:06 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:17:06 +0000
Message-ID: <7e4dcafb-80ce-458c-a7d1-520222275cd9@meta.com>
Date: Mon, 20 Oct 2025 11:16:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, dsterba@suse.com, cem@kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Chris Mason <clm@fb.com>
References: <20251020144356.693288-1-kbusch@meta.com>
 <20251020144522.GB30487@lst.de> <aPZNNkSOYr88-8VF@kbusch-mbp>
 <20251020145707.GA31743@lst.de>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20251020145707.GA31743@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CO1PR15MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 311db145-cb53-4740-9dc9-08de0febbacd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGNSMVYySjByN1dRTktTbnZGU21uS290dUJKZWtxdlIrZEZXQ3R6cE5TYWdr?=
 =?utf-8?B?QlVJTGRvZUYyZXp2eENwNGQvMEtoZHdUdWNvOWJkMFd0RWZ6SUFiT3NrV2RJ?=
 =?utf-8?B?dlgxNW9BeE5od1BXY2tGWkhLMnZZRVNoRVFmZktueEtqWlN6TGhUWEFOTFRm?=
 =?utf-8?B?dllGSjY4SkpzcGZnaXY3RVRlSjRzNE1VVlR1VzJBTWtPZ0hVTjVkeXY3OHdL?=
 =?utf-8?B?UlFyRnFuM1ZMV1J1eC9yQlBzRTZrR2tyZ1dURGZIc3AvQWFGYUFtODVGRGI0?=
 =?utf-8?B?NTF1NlgyN00wR0NOakJNZXNLbFJOOHlZN3JSUktJbnBOaCtKVHBJNXBnMzhM?=
 =?utf-8?B?NmFqV3dsOTBNUDF6NTdyeldBb0I0WElPVzVOZ0NTMUVFaExQS0dZVDF2cmVp?=
 =?utf-8?B?YWFVU1ZjclA5RGx4eGVSM01XRjZweUtFWG1CcEpLUGZQZEl6aTVhUUtwekdN?=
 =?utf-8?B?b1JlWk8xUXgrTGkvTXQ5aGVuSkhUMkVvWXpPdy9ySGdqSFdYV2JxUFN3V25T?=
 =?utf-8?B?b0IxTnFHT3BqaklTZHVSd0Z1aFd1RzAxcFg1WHUyQzlmc0V1WDIzTkZBMDdY?=
 =?utf-8?B?TGh0bGNWZzZuOTlkS0UrWUFwa0Nsd0thUjVSY2JLaXcrdStHemt2WjBieU85?=
 =?utf-8?B?SkFBTmJjK3RBUjlZMkp0MlNiV1lpS0hNa2dYWW85aSsydmc3azRvQUdtQjhP?=
 =?utf-8?B?cmlWKy9LVGUvNWNnVEwyckM3RDhKY1hpekF2aW5VNDVaN0d5TzlHVG1JYnB4?=
 =?utf-8?B?Y0hVZDdGSklLcVRGRUVsMXZRRVNjSmkwRVN4K2JjbzdGRUZIbm9vSlh1bzFD?=
 =?utf-8?B?N2R5ZlhlWGU5NWlPRktJQ3d1TG1xczJ0SW9KNmJSRkpBUmJFNkVTVCs1VFpC?=
 =?utf-8?B?WFNrbmJFRkRHQjZvcnc4VUY1UW5iNXY1aW9BM2NOUEFxVW92QkdsL0czTFBV?=
 =?utf-8?B?TmZJd3BuZ2FEZUJHNjExQWNZbW1HRDVSMlRxc1l2TUFLYnRKcHBhUVRZdWg0?=
 =?utf-8?B?d3RzZzJLbkVYZHVsaGt1bWU2ajk3SlMyek5QS3pMTWMvQWRkYVdyalBURHJ4?=
 =?utf-8?B?YTRIOVVmWWI3bVFCUktKZWNFdXYyTXJPenZRUjZyWi9EVXFtZzk3MUlBTysz?=
 =?utf-8?B?b3Y2UDk4K3BESElNdDNZNGN3VlBlNFMyOG1oRVJ6cktvbjAxU3g1ZGNzNlQz?=
 =?utf-8?B?T0dSQ0hib0U2Z21nMXcySkE0TTQyenNGNFVSVzVZNWpzSlhqbVRzc1FHVml2?=
 =?utf-8?B?WFNDa0RlQlNndTRuS2RMV2FWME9KbmpTUURra1VNcE14WVZxOGhSNzNKTWhu?=
 =?utf-8?B?cmFLemZReit4ZGxtRDFWVVpITmExOWxOQ3Q5dmJTVERwN3ZoYkFDam1qWjE0?=
 =?utf-8?B?YmRIc091b3ltcDMxWEVPdmM0NitQeVgzeDN2SmRJZnlCVjQ2QnpEaG53eFA4?=
 =?utf-8?B?Rk0vTEZ4K3hZVVk1WlNpV0FXalhoNEduMWFjUmxvRUxIRmwwNzJJZDJZcm1m?=
 =?utf-8?B?WXZoaVpxNE5yQ1BTRlJnaHZRY3BEdGlrcXpsVFBtZm1wUUNVdGFGSjd6NzJw?=
 =?utf-8?B?blZnRlJaZjFyV1VqRXFFK3dxdmxndHZ3b3ZwbGZJa3ZFdytENEJlMnArU3Ju?=
 =?utf-8?B?bHpuNytGc1NtSHpTQXY3Q0tZeUlUR3Y5ZUduU3g0TXAwT2dxdHVmaHdZWnc3?=
 =?utf-8?B?S254OHJVdEZyNlk0eStaUXN6Ymd2czltazNjbnYwQ3loZjdNSzRmclhJc2V4?=
 =?utf-8?B?eEJ1RS9rVTNXTHJjeVZyMFRUWFV4WFhiWXdVVHBTekpjME9uM1ZWWUtuOG9R?=
 =?utf-8?B?Um1QOURmcEx5bFl6SldseVowMXh2Z2tuWnQvV1ZvNVJZdXlBVlR4TnRqRWl2?=
 =?utf-8?B?YlZJc2pSYjdQSUVla3A4SjNYWGg4dm1QRml2em9RVjREZXVuWWNzVi81ZHha?=
 =?utf-8?Q?OqunfT+AiVSxhwVDwlsH0p5jwsjIsPx8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUg2bGFUM0wvVnh3MmxLajFnalFtSklmNm1MM3FlNkMycFJEUk5QNFZhM1VP?=
 =?utf-8?B?eXloRFRrNzVDUCsrRnF2K2ltRTBzdENCdUphSmt3eGdUQlZzZk4zdjQ2Ukkx?=
 =?utf-8?B?WUhlcG1VbnJHdnFiMVdzT2pKYlhIK3FCN0NteVJMcUd2OVc2M0JFSUU1em1n?=
 =?utf-8?B?UExNUHZpL1psSEZtanBkemRjL2t1QndReGViYmo0NWtYajlYT0htQ09QV1Ji?=
 =?utf-8?B?cnhURmdNT240SklNQ3JPTVRlQU1ZbkFNSzV0a2lqRWhyN3A5R2pRMkJzQU9C?=
 =?utf-8?B?RlA0cU1UclViVFJrbEs4VDFtNnpJdnRWeDBaWWMrVURtZStoTTNFWTUvcHh4?=
 =?utf-8?B?L3JCZGVlbWF0bXBhOGRZbVhIWldrU1BLeXVpQW83c3l4eHVQR3k0dS90aUV0?=
 =?utf-8?B?RldnZDVjUWh1SG40eGJCUmZ2MWI1dnd3OTdsMkwvclQyR0lyUkZ6UFhVNDhY?=
 =?utf-8?B?SkUzaVRzakVUUTJHVXBRL0pLQm1hejJiNTRSMmRUTit3bVBrVUxFVytKZjFC?=
 =?utf-8?B?dklyOUhHenpkdEZoaDV1cEIzc1BkQ2tQeVhlUkNvZTFJUE92SXozT3FwODAx?=
 =?utf-8?B?azFqSEtHL0FMZG9ySWE5MG1NQ2JJMDFQWmdJY3FpVGt1Q3lRdmR6bHpKa3c5?=
 =?utf-8?B?MUcyTFhsNkJUUnYrN1d2dEd4blZwN201ekg0ZzhmenlSZlhnQlhBUmVjbDJl?=
 =?utf-8?B?dk55Ymg0b3RTbDNOYTduMlBLMlZjQm55K0pJY2RTcFhra1RVSDhMckc0MURj?=
 =?utf-8?B?TExXY3hyT2RScCt5U05peTFpY1VNdkd0WHFKN3hLTm55M01PMGhzZ0EwUXo0?=
 =?utf-8?B?b0RIWmdSMzhueXJrRXFKdUtKek5Xa3JrSXJLSTkyZ2R3UFNodGJ5KzRIUUdE?=
 =?utf-8?B?dmJqMG9xU2phYWlMbDkzWFhFOWV5MkxtQk15eGd2eEh0OGsxQk9wTE4xQi9X?=
 =?utf-8?B?bnFRemEveVczZlNPZEdTWC9uRnFKaW1LQWxUeGZuM25QTTJyeVpCVG1ranQz?=
 =?utf-8?B?NGNNeGl3ZXZXdkk0VStMbE93WTUyUUlnOTZjSFVwbVp6WHJkYkYvNGZ2M0pa?=
 =?utf-8?B?RG81OGtCbzhZcWxsbjA4UEpVdE1tL2c4VFFscXBZc1lxVkNZNmxBbkNzQkVx?=
 =?utf-8?B?MFhUS05hMXJCQTlMdFJFMURUcFA4VmYxRXZ4Z3hJczE4Mjl6a2grSEM3cW9s?=
 =?utf-8?B?V3NadFVNTlBGWWRlNGV6cE03RExZT0c1OXJqamlOdVJjcFJaL0toQTdyMnJM?=
 =?utf-8?B?eGVESUZxL2pEcXd5QlBPL2N5aGdUS1UvN3lHMTBVZDBjbHQ0eHFxQTZWWHBv?=
 =?utf-8?B?REdrTnFZQytDV2M5emVuTW1xaktMdVJlT1NOTW51M1JUV0tRZldMWEFsSm9C?=
 =?utf-8?B?MzFkK1pBNUttOEI0T2E3eldXcmU4ZCtYRStOa3llZTBUTFlGaEd0S2ZzdnND?=
 =?utf-8?B?cFkxcnVLUnZ0d2wxNjNwRWNYVmx1b2J6V1JXeG1ZZUs0QVlYWXY2YXkySDha?=
 =?utf-8?B?clRIdXBIVDlOeWtNV3NROUZUbnZhS1NvdG5UeElvNXRlWWNBTWRobDNHSVJ6?=
 =?utf-8?B?OWRhQzFyUWYyOWRHNEtReUtUTzlReUpwbUptQlhYZnhIc1h3M3lGUEo1L2Vu?=
 =?utf-8?B?R2ErWC9xUlhobzdhTHR2TTN2VmJ5NWRKV0JwQ3pIWFkvUHIvL3cxdVpxVDdU?=
 =?utf-8?B?c2ZFdGtxc0ppVlJrc1NtWVhCWVhUMXg5UFA3K3dTT3NnNDY2Y04yclFpc29B?=
 =?utf-8?B?aC9zblVxRndVUEFUMkQ0QWo3QlcybUFFNEppMTRVUnUvUDFnVmJxbTB0emt6?=
 =?utf-8?B?MjJ2S0hGM0lDM2V0Z00zRmptQWQ1eFlKWmhaemdYZ1dET1dZdy8yNkZTWGlY?=
 =?utf-8?B?d0tVQVgwUENNRHdiRVFHTDhRZFlHSGZ1Y1pyR1NCazBZUURuRWdndmdFMGJo?=
 =?utf-8?B?VExlN0o0VWx1NlhWSGFObTkxTTdJbXNvcmVJYXVVVzdOTFZaMEgxY29tVE9m?=
 =?utf-8?B?Wi9HdGdvTFVQdDhRRm5XYVZSSXJ1U1Y3YkwxcllyVUF1bXN2b3BiTVFFWDdn?=
 =?utf-8?B?Q29XRWFFUkFLZU1yTUdNaVlrK3oxUW9JVzAyRXVlZFo5WXFrVTR6VFZLY2RG?=
 =?utf-8?Q?CwTk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311db145-cb53-4740-9dc9-08de0febbacd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:17:06.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14kp8F0zUa2Led+8vISPlKDPHFFdb2EN+hVJeaV3EXfrH4giLT+z8U0uH1Hga15W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5099
X-Authority-Analysis: v=2.4 cv=RKm+3oi+ c=1 sm=1 tr=0 ts=68f65274 cx=c_pps
 a=CdU078GllgbuWnh+Y24ybw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mlnMvNjSMSvXOvvEQdgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Ni6xTtUeKYKcSiVTQ2yApY9XmhnUjIA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEyNyBTYWx0ZWRfX0F3N9Pjwpllj
 P+pj1xw39kjDV9C7Uvc+0ZAotNpFmApJ8tfBMLoawMBCTjp1/rG0yg2kukI/ShueRx8gI+S6LAJ
 qutYzoQG+sjpbyWlEn4u9kHfzw0iTnuxWk1OaSJ7oIeeFs1/nTA45r3A6lxTtLRxJdAOBI4SUgB
 Et3IZFzfRms8xs0Vsl8xQRvGqvuAyYN2B0HdAMt556g5QrN/GqmDRx1f0p6kHtSQNu+6LILdK4e
 2o0wyiFO9GJoPIevb1lhX7dVm/b5qnMwmX976DHhSODCwz3LgaoDwW8ig5o5PpjFZAY9h1fWpJu
 NJrPvtYcOJeYQ9f6lq/5FhdonfGUwrud0Rb0bGWw0/yQfaaKtlwOT0IRuPkXnlJ+GNZfoyHpMTT
 5Wzs9t2eWqgrZE+gQiIBFZSysRSXIg==
X-Proofpoint-ORIG-GUID: Ni6xTtUeKYKcSiVTQ2yApY9XmhnUjIA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01

On 10/20/25 10:57 AM, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 08:54:46AM -0600, Keith Busch wrote:
>>> Ugg, how?  If that actually happens we're toast, so we should find a
>>> way to ensure it does not happen.
>>
>> You'd have to attempt sending an invalid bvec, like something that can't
>> DMA map because you have a byte aligned offset, or the total size is
>> smaller than the block device's.
>>
>> Not that you're doing anything like that here. This condition should
>> never occur in this path because the bio vectors are all nicely aligned.
>> It's just for completeness to ensure it doesn't go uncaught for every
>> bio split caller.
> 
> So this is just from code inspection and you did not actually hit
> such a case?

This is from me testing out AI reviews on linux-next, and they do love
suggesting defensive programming a little too much.  I'd be happier
with EIOs in this case but agree it's probably never going to happen.

Just for completeness, the actual AI output was:

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 7709d55adc23..9efacabaa2f7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1870,6 +1870,13 @@ bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
>  	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
>  }
>
> +static inline int bio_split_rw_at(struct bio *bio,
> +		const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes)
> +{
> +	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
> +}
> +
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>
>  #endif /* _LINUX_BLKDEV_H */

bio_split_rw_at() now returns negative errors in three new cases:
  1. bv.bv_offset alignment violation
  2. bv.bv_len alignment violation
  3. Zero bytes after ALIGN_DOWN

However, two callers don't handle these new negative returns correctly:

In fs/btrfs/bio.c, btrfs_append_map_length() does this:

    sector_offset = bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
                                    &nr_segs, map_length);
    if (sector_offset) {
        return ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
                          bbio->fs_info->sectorsize);
    }

Can this mishandle the negative returns? When bio_split_rw_at() returns
-EINVAL (-22), the condition 'if (sector_offset)' is true. Then
'sector_offset << SECTOR_SHIFT' becomes -11264, and ALIGN_DOWN operates
on a negative value. The function returns this as if it's a valid
length (u64). The caller btrfs_submit_chunk() then uses this value in
'if (map_length < length)' and may attempt to split the bio at an
invalid position.

Similarly, in fs/xfs/xfs_zone_gc.c, xfs_zone_gc_split_write() does:

    split_sectors = bio_split_rw_at(&chunk->bio, lim, &nsegs,
                    lim->max_zone_append_sectors << SECTOR_SHIFT);
    if (!split_sectors)
        return NULL;

    split_sectors = ALIGN_DOWN(split_sectors << SECTOR_SHIFT,
                    data->mp->m_sb.sb_blocksize) >> SECTOR_SHIFT;
    split = bio_split(&chunk->bio, split_sectors, GFP_NOFS, &data->bio_set);

Can this pass negative values to bio_split()? The check only handles
zero, so when bio_split_rw_at() returns -EINVAL, the negative value
continues through ALIGN_DOWN operations and eventually reaches
bio_split(). While bio_split() has a WARN_ON_ONCE(sectors <= 0) check
and returns ERR_PTR(-EINVAL), xfs_zone_gc_split_write() doesn't check
for ERR_PTR. It does container_of() and returns the error pointer to
the caller xfs_zone_gc_write_chunk(), which treats it as a valid
pointer in the while loop.


