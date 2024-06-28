Return-Path: <linux-btrfs+bounces-6037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57991BBD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BB1B217D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41178153561;
	Fri, 28 Jun 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HxHyvnWq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB12139A8
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568082; cv=fail; b=O07itP2vrf9yqS7UL0qjspIYhX5PdCueh3sSBzCn3OhuAfFrPUrVjcx5kVGC6qmItJCpAOUvV8HYPBamozXMa07bWAxAN5cPEVFPgdED+7aSarWd0A4ilVp4nC2v2hnIS+nqb6uILTlGumR4x8vSwmxYl5V7llhvKCNgeyuCOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568082; c=relaxed/simple;
	bh=8i61wxT9NUQq4YfwQ8uDMiwaLr85332G0xB7gSHb3ys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tp3hhz62zt9Vf7/Y/XOZguXHBs2kW3sLUX0wSjmlYfdbufERmM2uNW3P8+5VfqsU/3YOnaXluAtASeImFFoupEQTgTPfb9UvuwouasnJ84X6xwECxYGT4RuDPBlsH6Shu5OCEOMdUMmHpvD3NugciREFzmQvKI/+OeCAZNgyyzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HxHyvnWq; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S9kvSZ032176
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 02:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=s2048-2021-q4; bh=8i6
	1wxT9NUQq4YfwQ8uDMiwaLr85332G0xB7gSHb3ys=; b=HxHyvnWqoxhG/ym9AIl
	3zdPGaycBFMY5tZ2oIcbMqG6ISAl+R9Cy4i6w3vnEUdzITl8yPI15A7OxeQviTqB
	Ue3VJAaHnfN+QoZXIrXtONXFsr3Zu1l7PobCjs/2sFqkuYfBO+MLzLxS9c6xl31Z
	y+g0p2Z8yucCkhLTs0WNMUewmQI5nADKocXljr6p3fHX/sqNMuctP28F1dK+Dxpa
	ieZzEOri8sV1JmMj9NWjnZcfySD1AS+7FTo7FD1YFZC9r8/CnR3Ku/h1HiFVK02B
	Mqu84WEqU9z6APPVAeCRCEprJ4khfQuxVqAFN5KFlho0ZWFQ/5zakQzG8M8IuA/9
	c/g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4015w978r1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 02:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS/oyEkpV8jK/ohgY8RQkhr0u5ferLmEQ47RYa6UOueSVBQwm1467LCIaK8eWfR00BFxSo4ckV6TqBsKeN3Dq1EtZyCnEDLUNX82fsgxUlHNNfTCHl+CnTJAH7Qw98XoAtG8CUpHX1H/PInddPA8OWa4uaSNFrLWOkq5YjLmJEruAmExps9QtWaCvP1aS/hgjdLfKRwRpTrCDd+y/UIl3/mPTtPZKA3oAwPibrx/kJwEvd0hST3Imc5GMn0EP8bdyC2AjDR9IWpYT7IZsFQcrQMQya1U76tRz6x0pJrRlTwQUp1dwGD6gEX8Hbr+tfy8lW+eQHRwdlIUbqG9ZFO+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i61wxT9NUQq4YfwQ8uDMiwaLr85332G0xB7gSHb3ys=;
 b=m46fgwWAO4u8TuITEAP/joFuiUVyLXZtOP117oijKgeiDG6fgM/AHLI7w0ow57fOfwd3bIjssT7aGo6mLU78qasvzoszME4jfjbQg7f8aFaXZ9SqbtTHJRJrdAw2LKBoVqTXx/6N0TOE6qnjXpo/sz99zPpqfr8zyx1l/9gSyNkBAiesmjc+D0OhDvb1k4nUh8W5qMvh+VLb7uYpPPpjfhDWxuZ5+LXD4aGWP8J/RhTCDgE8ecLztqGJ0BkpkbZfMmnfKpwb0fW7SLYof9dModEPtf6RiAP5IUYSFBdwZungXA9JFwQudlE913DIboEIZz6Qm8YCPaHGvwp7mbfd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MN6PR15MB6049.namprd15.prod.outlook.com (2603:10b6:208:47e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 09:47:55 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 09:47:55 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHayHgUH+kou+8ibE2JS8l3fzZlt7HckdeAgABTIVA=
Date: Fri, 28 Jun 2024 09:47:55 +0000
Message-ID: 
 <SJ2PR15MB5669263312ED115369A4E6BFD1D02@SJ2PR15MB5669.namprd15.prod.outlook.com>
References: <20240627095455.315620-1-maharmstone@fb.com>
 <847fb295-1a0e-429d-8d04-67948240fa5c@gmx.com>
In-Reply-To: <847fb295-1a0e-429d-8d04-67948240fa5c@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MN6PR15MB6049:EE_
x-ms-office365-filtering-correlation-id: ad9bb6e1-b745-4a58-98e0-08dc975762be
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MjJWTHR4SXdLZExWVllVeDExaTV2K01EakV5UlZGUzI3dENSODZpMFk1VnpV?=
 =?utf-8?B?MGJ1Z0JQQ2o5RjhIWmkzbStHeHlHemhQazZ3UHBlNVVHZ3NuUWU3U2ZvMS84?=
 =?utf-8?B?UDc5ek96VFRTZzd4cUhxYWdxVUpnVXVUTFhhc1duQmJDWnNyOU11NkUvSmZB?=
 =?utf-8?B?S3RSS3hGWGcvVWZtVVRxSkxhQW5TYXllWXM5M2JNak81dWt1cWFPYTBJc2Np?=
 =?utf-8?B?MnJWQktZakNqcEEvRDVmV2M1RVNQL0xJTVhrQVdGVzdTaUFnT09KejVaZ3FJ?=
 =?utf-8?B?OUhSVTNZWEl6SmNRMHU1cE91dzhleFB1Q1lCZWZoVXRyZ3hDN3JnZElVclBK?=
 =?utf-8?B?ZHAwL0JwZk1wek5YUXV6aUdrTUVBdnpsYWlFbThsR3lvS1NPVDRJQWVHK3lW?=
 =?utf-8?B?bGRST3pxcEpXUmpTNVBOcTNNUFZMSzhBckFKRDJqYmliN0g4UURNdXk1SlpG?=
 =?utf-8?B?OGIwekVjQ0lNM2c4SU1hMnhuS1d5QjFVRDlaZ1A4WTlDVHIzU3IrckZQaG1x?=
 =?utf-8?B?aGcrVC9JWGd0NmZISXZqSk5FMjZGNlpBSFdsZlhGQkdUcVN2K2tsUm1KemYw?=
 =?utf-8?B?WkR2U3Y5WDZlNUNrdnFFcWxZTHloT3VXRTk5bkF4b2FDODN0R3B4YUtQK1dS?=
 =?utf-8?B?dG1Oc3JnUk1jY1EvQWRZS2ZaeTBDOTRETFpNVjVYeHVMVUl5ODBZWGhuYlgz?=
 =?utf-8?B?VDNGdDFYWlBDSVBkQVYvUlhtZDFzR2Eranc5YmZoUGJkYW5DK0M5L0dXZnlr?=
 =?utf-8?B?SnpXT2FhZmZZdHdMSmpTY0d1NERlQk51VlJvb0NoMEdmNENmZHBRV1JVNE0x?=
 =?utf-8?B?NGcvR1hpc0JXbC9sQjczblJrTUNSaXRJdExISWdJTTQ0N0FOOWpQOEtJSTds?=
 =?utf-8?B?eElZVTlGaG1xTlkvTjN0V1hUSU5yL0tUWmlVT1FCaForTTNyaWUvdUZLMk5B?=
 =?utf-8?B?aW9zWGFpSTNPNXk1eXVMcDk2Q0tPaVBoQlpWeXVLMmhaYkVMSGlLNFJ1Wm9U?=
 =?utf-8?B?bnA1K0RTVjdRcW1lSjV0VzJzMHFTQmV4SG1zS3AzcnBySncvUEExYU9ybzJa?=
 =?utf-8?B?TlFJZTVoUlJVQVFubHl1d2xLUnFXNUQ1OUdBbWxRcVhEYUVlR1YrajRheWVQ?=
 =?utf-8?B?Q1dqdEtmUXlWYk9GL21WNmdzV2xBbi9CSEpEQkxZbnQ3NjE4MmRoVnNFc09l?=
 =?utf-8?B?dGdZREdlcEZCbmpoV2ZhRHdLMnlPZWoyV2RrM2NYd2xQbkh4L21VNXBCcFNN?=
 =?utf-8?B?ZmxKWE9SSzUyR05INm1xNzc4L1ZVSUFVTzAxNjdQOXlTZXdpUVN0VkZhUno1?=
 =?utf-8?B?YlNobGtqSzBHOS9vTU10UU83MTAzRnBjNHFlY3N4dk9kS1BmYnRpWElxODBi?=
 =?utf-8?B?SFhVaTBKK2pWOEZpZUlmWVBjTVBYNDJnU3AyY20rWThHYU00MG1XU09vYXo5?=
 =?utf-8?B?MmdUb0VpcER4WS9QalRWNEt1bmVFaVJUeVFVWVdSVDZXZk1rR1F1UEYxN09p?=
 =?utf-8?B?d0lpN0RZeEx2c2MrM0sxZU4vV2NwdldhcnFqSHN2Kzl3cTZrRW9GWXlxYjlE?=
 =?utf-8?B?YlNSK3U2cHZONHMxS052N1FyZnpZUUxwMjRkbFJ2T3N6TkRRaUpldkc2c1RL?=
 =?utf-8?B?ejZxMklid2IzWmlRSzhyTGNXMUhmOFh5TFFwTXhwYUtvSDFZWkhZZlhtOUVo?=
 =?utf-8?B?SytlcDd3ZGJVYUk2eHJ5eEdYbHFEY28wMndRQzNLVGFRM2ltZGx0Tmw1TlNh?=
 =?utf-8?B?djlLMjMwblE2eGgrU0JzQml6OUo1azIxRkt2dTc0Z3JyQ0pkT1NuNmh2My93?=
 =?utf-8?B?a1pleXpwYTJka2RCeXVEcDdFK3NWYnFob1dhWW1rT0pnK3FkSVZEQTVZeFhZ?=
 =?utf-8?B?UWhQMnFBWmQ3NDA2Ylp0S3VqaGpsc3h3YjhHQ01EVlRwT3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TXFoU1BGVTVpUUlyMDY5SEtSejdOYUNNUWpLN0wwV1diRWZTK3ZUV0hQTHlE?=
 =?utf-8?B?dXlGb3E4VE8zenBQU243NXd5WGRKYWY5elN1REcvVktGTDdOUVl2dkEzclRo?=
 =?utf-8?B?ckdmZUtLKzNEaFNNS3VJcHcvbTVhQnNQdzFBVmFTaTlkQzZIMGhqYkdWdHJ5?=
 =?utf-8?B?WmVZeENZYWowdnVYeVlyU01HUmE2cjdacDFlMUdPTkV1TUNMUXJkLzJhTnJv?=
 =?utf-8?B?bVUxUks2ekZIYVVTb3IvSjllU0NuNzZmNlhHQ3JHZzhPaWRmRm5ibWMrbW5i?=
 =?utf-8?B?SnZad3dxMVM0NHpiWlhZenlQeEdNRmNLS09zelRDL3dST3JHU1p0SEFQZ1Bz?=
 =?utf-8?B?SWFDMU9NQi9PNHFMTG1RUEpFYmZqeXpuelVtTHQvTkxiSW9vaTZYa3ljdXgw?=
 =?utf-8?B?VDB4ZGZEdVZvTjh4dXhIYmd4dXZHaEpPK09QSjM2bHFLeW9za2RTVlNKZXBm?=
 =?utf-8?B?VUJKQVcwZVg4S0pMMG9tWWNhc211dG80c0I3UzRFMm8zRFBoc1dvYXFXWC9r?=
 =?utf-8?B?cFM4djV5Y0VtbGIveXJFb0hzWlA1SS9uU1UrM2swMU8xd3N4cE5QRVJPZnF1?=
 =?utf-8?B?Tit6OEpyTFdrTGkrV1QwTDdYbS9LOHRoVUNLQ3lEejIxTWpxVjUwZU4rbE1D?=
 =?utf-8?B?T0VhSUlMc21vYU5FUGdZWS9UVmdJaGZncGpsRENkYkxUZnJaUUl2VTFHUUxm?=
 =?utf-8?B?eUprZHVrcWJNdzlrS2VtVGxyZGI4SnhKTzlyeTZDSnZVc0xrUzNIYU9yN2pQ?=
 =?utf-8?B?UElQWFI3REpHYXBhMVF5VXlNaUdvZDVDeXBTeU8wVDRRMXZZQWxINTB1TFpS?=
 =?utf-8?B?Uk9qcHFEQ3BVYTJ0VEdnbGpOaFBrejgwSjYvMUpRMCs4TkdCa1k5Z2h5V0hL?=
 =?utf-8?B?UkVYREkxZ1B5RUhkbDY3Q0pNbDhXMHdhMGVPSDZYM2ZRUERzRExuc0hCWGl5?=
 =?utf-8?B?WnRkbW1LdG4vOGJnbFQyTkhIbUJSNTh3OVdlWXYrMVllbUZyWFdGQlMzUlph?=
 =?utf-8?B?NnpFNG5PZnUyZjdtazd6RVZjckZnVUhxQ2dFTTg0NWgvREZRNHVIVnpUTTFQ?=
 =?utf-8?B?Q2xtWUdlVEFEWUMzOC9VbVZqaEorbjBZcElyZktGOGlnN0F6NEZpVXNqVXdC?=
 =?utf-8?B?WU9uY2ZYVElIKzNVZ0NNOTZMRGc4aG9MRktORTY0cnJQVnBybThZUkJnM0xX?=
 =?utf-8?B?d25Sendrbm5ZbVFnQ3dCNVN2T3FUUG9hdk96YTN4ZzhvTzd5amhxM1k2WGJn?=
 =?utf-8?B?aDc5bktGaDhQRVg0NllPaHJhaHdpbXF6OFJzNlBnM3hsaW1wa1dLanZkYytk?=
 =?utf-8?B?c091WGJTc0FiRjhiQjQ4aHhmaWZseXBwUlB6TkNYK2IrcUVPVmdOc28xRVhJ?=
 =?utf-8?B?Vjdla1RQWmdjTnRhb2ZVZzV3SVY1TnQ4alMrVGtCVCtzRm9WNlpoQTZReWwv?=
 =?utf-8?B?Qzd0SDFYTEFMNjMvdGtuQTkzbW4wWHYxdmpqU0ZvVHNtTENIcjh3d213bG8y?=
 =?utf-8?B?RFdpOGNVQkl3eEE0bTI0cm14SUNBUG8yemFLOVhlbmVBTzl6dGpMbFVuYS9k?=
 =?utf-8?B?WlQ4NWdHL2JqWWlhb29GaTdLWDM3WW1vYlUvRjRhQ21TclF1OERWcnBZaHJs?=
 =?utf-8?B?cDUzeE9qdWdvNzhmSGgrNjd5N0wxWHhZOGdYQVVROWR0WTZ5YUtDcmM5ODBY?=
 =?utf-8?B?anhHMXpOa1BoVERXSkZnYWcwMk45YlY1NlBQTnZ4aDZnSHJDZFRGTUxWanBE?=
 =?utf-8?B?NVpwdWNlYUN0RDIvZnNaTHZEWEhSYmVjdmlDU0hhcXpTN0VGamphVEUwVzN0?=
 =?utf-8?B?cTN5c3VjQm90RjlaRElvNDBuM2RDcDdIbjJBRzk5S2tBa2QzUkl0cFo4Zzl3?=
 =?utf-8?B?ZXR1eGhCNFpFdFc4MWErT01nUko0dy9USlRJZEo4QmJ5Z1ozcEdENDdjdHJG?=
 =?utf-8?B?UW54Q3hoblQzTSs1Q0dUdW12S3lmZ1JWRGZsSS9hb0xscXpZelhKcjU0c2pm?=
 =?utf-8?B?NHdieWdVaHFNR3NleUJqVnhVU3Yxd3NpZ1RXTytnbDJqdDdURHBJTTEyRjhU?=
 =?utf-8?B?SDhud3ZpVGhqQ1hPOFVzTCtOM0pRYWRxU3JNNWNvQkVON0ZvQjQ1MEY0dDUy?=
 =?utf-8?B?RUU3TlR0am1tR0pmeGx6VnhVQ2hPaHhndXJYTUtQTmRqc0VrZjhUOVl0ck9Z?=
 =?utf-8?Q?u9hYyaoa4l6kAuLfg0McO54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9bb6e1-b745-4a58-98e0-08dc975762be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:47:55.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdIi/pjeXxmsoa+G4UFy/A4HPGVm3oPH0Ny+gPRCwmtPmQwjAI3Fv9YqrPmdq+gGRTT8t6LIy+Uprw97RYNoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6049
X-Proofpoint-GUID: bU5OvD6t0AOr5g58_4yB2e9lgd5k59BO
X-Proofpoint-ORIG-GUID: bU5OvD6t0AOr5g58_4yB2e9lgd5k59BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01

VGhhbmtzIFF1Lg0KDQo+ID4gICBzdHJ1Y3QgYnRyZnNfcm9vdCAqYnRyZnNfbWtzdWJ2b2woc3Ry
dWN0IGJ0cmZzX3Jvb3QgKnJvb3QsDQo+ID4gICAJCQkJICBjb25zdCBjaGFyICpiYXNlLCB1NjQg
cm9vdF9vYmplY3RpZCwNCj4gPiAtCQkJCSAgYm9vbCBjb252ZXJ0KQ0KPiA+ICsJCQkJICBib29s
IGNvbnZlcnQsIHU2NCBkaXJpZCwNCj4gPiArCQkJCSAgYm9vbCBkb250X2NoYW5nZV9zaXplKQ0K
PiANCj4gQW55IHJlYXNvbiB3aHkgYWRkaW5nIHRoaXMgbmV3IHBhcmFtZXRlcj8NCj4gDQo+IE5v
cm1hbGx5IGl0J3MgcHJldHR5IG5hdHVyZSB0aGF0IHdlIGluY3JlYXNlIHRoZSBkaXJlY3Rvcnkg
aW5vZGUncyBzaXplIHdpdGggbmV3DQo+IGVudHJpZXMuDQo+IEp1c3QgbGlrZSBidHJmc19hZGRf
bGluaygpLg0KDQpCZWNhdXNlIGJ0cmZzX21rZnNfZmlsbF9kaXIgY2FsY3VsYXRlcyB0aGUgaW5v
ZGUgc2l6ZSBhcyBub3JtYWwsIGJ1dCBza2lwcyBhbnkNCmRpcmVjdG9yaWVzIHRoYXQgYXJlIGdv
aW5nIHRvIGJlIHN1YnZvbHMgLSBzbyB3ZSdkIGJlIGRvdWJsZS1jb3VudGluZyBvdGhlcndpc2Uu
DQoNCkFub3RoZXIgd2F5IHRvIGRvIGl0IHdvdWxkIGhhdmUgYmVlbiB0byBwYXNzIHRoZSBzdWJ2
b2wgbGlzdCB0bw0KY2FsY3VsYXRlX2Rpcl9pbm9kZV9zaXplLCBidXQgdGhpcyB3b3VsZCBoYXZl
IG1lYW50IGEgbG90IG1vcmUgcmVjdXJzaW5nLA0KYW5kIHdyaXRpbmcgdGhlIHBhcmVudCBkaXIg
aW5vZGUgaXRlbSBtb3JlIHRoYW4gb25jZS4NCg0KPiA+ICsJcmV0ID0gYnRyZnNfY29weV9yb290
KHRyYW5zLCByb290LCByb290LT5ub2RlLCAmdG1wLA0KPiA+ICsJCQkgICAgICByb290X29iamVj
dGlkKTsNCj4gDQo+IEknbSBub3QgYSBzdXBlciBiaWcgZmFuIG9mIGNvcHlpbmcgcm9vdCBqdXN0
IHRvIHNraXAgdGhlIGluaXRpYWxpemF0aW9uIG9mIHNvbWUNCj4gbWVtYmVycy4NCj4gDQo+IENh
bid0IHdlIGp1c3QgdXNlIGJ0cmZzX2NyZWF0ZV9yb290KCkgaW5zdGVhZD8NCg0KSSB3YXMgY29w
eWluZyB3aGF0IHdlIGRvIGluIGNvbnZlcnQuYyBoZXJlLiBJdCdzIHNvbWV0aGluZyBJIGNhbiBs
b29rIGludG8gaW4NCmEgbGF0ZXIgcGF0Y2gsIGlmIG5lY2Vzc2FyeS4NCiANCj4gV291bGQgaXQg
YmUgcG9zc2libGUgdG8gZG8gdGhlIHN1YnZvbHVtZSBjcmVhdGlvbiBkdXJpbmcgcmVndWxhciBk
aXJlY3RvcnkNCj4gdHJhdmVyc2FsPw0KPiANCj4gQnkgdGhhdCB3ZSBjYW4ganVzdCB0cmVhdCBh
IHRhcmdldCBzdWJ2b2x1bWUgYXMgYSBzbGlnaHRseSBkaWZmZXJlbnQgZGlyZWN0b3J5DQo+IGNy
ZWF0aW9uLg0KPiBUaGUgYmlnZ2VzdCBwcm9ibGVtIGhlcmUgaXMsIHdlIG9ubHkgaW5zZXJ0IHRo
ZSByb290IGl0ZW1zIHdpdGhvdXQgYW55IGJhY2tyZWYsDQo+IGFuZCBpbW1lZGlhdGVseSBjb21t
aXRzIHRoZSB0cmFuc2FjdGlvbiwgYW5kIHdvdWxkIG5lZWQgc3BlY2lhbCBoYW5kbGluZyBmb3IN
Cj4gdGFyZ2V0IHN1YnZvbHVtZXMgYW55d2F5Lg0KDQpJIHRoaW5rIHRoZSBpc3N1ZSB3YXMgdGhh
dCBidHJmc19ta3N1YnZvbCBkb2VzIGl0cyBvd24gdHJhbnNhY3Rpb24sIHNvIGNhbid0DQpiZSBj
YWxsZWQgZnJvbSB3aXRoaW4gYnRyZnNfbWtmc19maWxsX2Rpci4gUXVpdGUgcG9zc2libHkgaXQg
Y291bGQgYmUgZG9uZSB3aXRoDQpzb21lIHJlZmFjdG9yaW5nLCBidXQgSSd2ZSB0cmllZCB0byBr
ZWVwIHRoZSBjb2RlIGNoYW5nZXMgdG8gYSBtaW5pbXVtLi4uDQoNCj4gSWYgYnkgc29tZWhvdyB0
aGUgbWtmcyBpcyBpbnRlcnJ1cHRlZCwgd2hhdCB3ZSBnb3QgaXMgYSBjb3JydXB0ZWQgZnMgd2l0
aCBhIGxvdA0KPiBvZiBzdWJ2b2x1bWUgd2hpY2ggY2FuIG5vdCBiZSBhY2Nlc3NlZC4NCj4gKFdl
bGwsIG5vdCBhIGh1Z2UgcHJvYmxlbSBzaW5jZSB0aGUgbWtmcyBpcyBub3QgZG9uZSwgaXRzIHN1
cGVyIG1hZ2ljIGlzIG5vdCBhDQo+IHZhbGlkIG9uZSwga2VybmVsIHdvbid0IGJlIGFibGUgdG8g
bW91bnQgdGhlbSBhbnl3YXkpDQoNClllcywgSSBkb24ndCB0aGluayB0cmFuc2FjdGlvbnMgYXJl
IGFsbCB0aGF0IGltcG9ydGFudCB3aGVuIGl0IGNvbWVzIHRvIG1rZnMsDQphcyB5b3UgZWl0aGVy
IGhhdmUgYSB2YWxpZCBmaWxlc3lzdGVtIG9yIHVubW91bnRhYmxlIG5vbnNlbnNlLg0KDQpUaGFu
a3MNCg0KTWFyaw0K

