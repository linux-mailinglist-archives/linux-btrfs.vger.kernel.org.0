Return-Path: <linux-btrfs+bounces-9432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8B9C44DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 19:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99701F21E8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA21BC07D;
	Mon, 11 Nov 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hRZz9xs9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F321AA79E
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349053; cv=fail; b=CpTEqR9y99lrxiqEe1jjZT2R4ddBhM4j++kkRGI0DlWjXL4rx9GJMNvOCFoN/cXCsLBK/mcBan98VwKn8gs071GsboT/olQDZgRDd2qzR7LfkMQB4kX7YHaLFL8iKlht3cR2wT2gKjcEtc/KMJiOvJWrn9iQOp/IcltTjVXq748=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349053; c=relaxed/simple;
	bh=27xjzDr3NqapfTtVADLStYsSdtVG+6kgi/c21cldoBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=uMS44Ft+wHHlKdnqItIqyFA1va/qwums3gWAOpMIVN6M93ZMbLriFH11C0OAQfaoZb/tyElTcocQ0mbdcMNrVFGNTifLurSpyngvaCvLW1B7pzXivarTXrdT82SUEl+BShC1ba9g1kRCgyZeCgMd+MO87wQ3np3fto98cCAjxMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hRZz9xs9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4ABHLKS0000995
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 10:17:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=1AVsAdI2jqRna1M5+hqQwKijljUq1gb1j6jobID0fHY=; b=
	hRZz9xs9aQ1ANfYcPheWlkoS492tb7YZbrUm8dGMpr2SPQSPGMeXWRf0Kmdu0y6k
	Gw0uKsbGSNfT+Sdi/3p3Y86JUQLuQWSRCc1Sz7/GkscGUvxP2hnN8MsKiARW91NX
	dfvb79atpP3pLBaRbF6JViEtpQDTTQXV40n3UHrj4f0o8m0CVH1ygLIOwCzrgwyi
	EUM+Edmt+uj7E5RDAAPQiiJijbd5yKMP4XZQXyKX+pn92VT5nMo7vSfDRfSOsC0E
	7GvHr2Q8aCFiF1X+1NcqZc9ydI5tdw8CZeR5OTWE7j3negi3hp5hpIn0cO3a//CL
	PT1HFuPfRYPwBtBKq+f34g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by m0001303.ppops.net (PPS) with ESMTPS id 42up8gre83-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 10:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=defSzgEQSHKF7+etjUZn0uFyTnVYTDIkAG+Bhe4iR/gdnTm/RdLeN93M7h7x9+qFaTlZlxfzwr3QBtH2URXP/r8AEAaN0zzf4Pw0/brS/UrsjoLOP69Ur2ndGQjLaK9fYb6UUoc9zDSVYejKgmGy4sixrDjbE+JQGJSc0mRn8m3wJzFHXahShFNNu14WkI0QDiFLO/RavlhfLNDzJUkuUOyASmG9u23OfW13+1AO9LudKKyLTD9qHOJST/Zb/ZvKlYNcfFg0KzsPmx1rhyhIUcV3+E15A8JG7reom5GjgWPxh+yp3ED5rLYbUtAiIRGzkNNJt1bzbFmx8dspw01APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlozxAdI/qkCT4uHnW5xXz/9Un5dtZUDRaHPq5ckG9k=;
 b=OgKhJ/jCMoQvoCZHGM4GvZ8t30d5yuGD260uSsuh8xV9h3NvmtH9YAqurdXtTzxX5+BJB6P973R8SQ3cg650o+j9CwkZf7V1lf3U70jXh6htQiZ38IxzwlgCbxAvCEfR5bXVEU+nDuvk8d8873ly3ZH8HN0EKIZjWoRO8/+2LzDOrqzCZU+FNKhniFtFKbnkZWpCFXqtaoeCImd81CXKKjjMeVXRk1M+aSYIDrdCNgOC7LA4Yw18RkOZofBZ1B7p3w9nRuO0gW/UBxNda0CPUgmCEvLSaNbZoaU2LVIl58zqyLSD9jhG2CLCQ6xt4PrN+9kfIqfvRssKLnM7jFow/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ0PR15MB4743.namprd15.prod.outlook.com (2603:10b6:a03:37c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 18:17:25 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 18:17:25 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>,
        Mark Harmstone <maharmstone@meta.com>,
        Omar
 Sandoval <osandov@osandov.com>,
        Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Thread-Topic: [PATCH 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Thread-Index: AQHbNBwhR1ceI7xzW0ONgQGuMqalzbKyY7CA
Date: Mon, 11 Nov 2024 18:17:25 +0000
Message-ID: <29f0413a-a485-4113-a3c5-f5d8f20778a9@meta.com>
References: <cover.1731316882.git.jth@kernel.org>
 <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
In-Reply-To:
 <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ0PR15MB4743:EE_
x-ms-office365-filtering-correlation-id: 8b556f07-b319-4586-6087-08dd027d1804
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGxjcDRpQ1J1bkNOQkpiM011YWhqUFdvQTBBMmRtVEpVdnIvdTd3dDhQRlFz?=
 =?utf-8?B?UUNSRUZMMllUMkhVY2pTbGJ3V1UrOTZyN3g2WkRRRWJiUGVJc0h5RDNETWEz?=
 =?utf-8?B?K2RqdlltU1dra2JFTFdNVHRDa3dCV0l1STJOeFplUEl1bHNGZ0ZZNFA4MHd5?=
 =?utf-8?B?eXJ0WlEzbGRmUUFLL3Vhd05DM2RkL2Z1WUFDZWliVjA4Vm51Nmc4VVNxaFhM?=
 =?utf-8?B?VWhpQk4yUkVSQ3MyZ0RkUEMvNXNxSFFnWElRUHBISkNDaHZYWkFMekc2cHAv?=
 =?utf-8?B?SGRMR0dIVWJobXcrVmJpR256L3J5bzlYZDlhaGVrTUlOQkgxWWh4NkFqTXdr?=
 =?utf-8?B?cWRqMndDYjVtWnRCNGVua1BXSHRlWTNGU0l2TndqYm9lM2pBeVAzZzBFd0h2?=
 =?utf-8?B?cEM5OWhXamc1Um1RSkdUamNLRVozYnJTeUp2Ky9IaXdYNm5hS1UvM1VETm1u?=
 =?utf-8?B?M0FDaTJOdks4bjlwaWYybDcrR295aWdsUXVha0ZJNGVFZ2JINXBHVlhOb3F4?=
 =?utf-8?B?YVBDOW9hakh4L2xIMHdYQS93VytoZ1NLTFdIWGdBUUwrZmNSdEtIa3JWNi9U?=
 =?utf-8?B?WFpCTjl4S0o4TnpJV2NqSEdUWTdSSEtxWjBJcXVCTTQ3RXNHUVZRK01pdHFP?=
 =?utf-8?B?MFhqRU80eHJlVi9ha1ZGaTE3N1hBSEdHakNzWkNjVTlFdmZNSGpOWTQ2Rnda?=
 =?utf-8?B?bWRnOUhFLzd5d3I5bE9QdXhPZ0NQK1VBZWQzdVV3TFpKYmczSE5FZjR4Ny9p?=
 =?utf-8?B?Rms1RGo5NUFkelVna1pTYXZGdS9tMEs5akhKSjU0RTI3VjBvenBCMXJ1NW56?=
 =?utf-8?B?T0w4YjFubGRMTm8rVjlkc0RHNks5UHpFTHV4VkFZTXllNlBrYU1QNHJrTVlB?=
 =?utf-8?B?K3pudHZ3UmpzOXBVaXNQYzlhazlBY2Mzd0VRMHlYODQvYWFyUlJ2cHNOSXJU?=
 =?utf-8?B?b2lFMjM1U0NlNlkreUttQ0prUkdJcEFNdjQxRFJsb0JqcTlnaTl2dXZsSGVZ?=
 =?utf-8?B?ZU92V2hiRExuaXBhSDdDZ1dpaVZRSC9XNGJaTkZDU056aFBjSk1KNE9lbkZj?=
 =?utf-8?B?RW1OYU9NUUJydnJjWWZoK205QmVZbkc1NXgwNStGbmwvNW45dGZxUDcwSERl?=
 =?utf-8?B?akxjMW45M09GOEVJVThzNWczMlV1MVRrS2cycHFEUmdxRjZ2NlZaY2gxTW9L?=
 =?utf-8?B?NGhWT3F2cmx3SUVSR2M0dkJwQkJBY0FDWXVKNGVEUkVkVkhSQStBeGtlRW13?=
 =?utf-8?B?cGJ4cCt0QUQyOXYvQXNxeGFLdjdOOWtSMEdlR2hQalZRMVpMcjhVUlVRZXdp?=
 =?utf-8?B?S05sMTVoVUUwelprYVZHeVVtdmlEcWxZRHhMdncwakdnL05NMXArbjBHRDEy?=
 =?utf-8?B?ZjM4cE01bmU0UlVZd0Z0Tksvdmo3d0U1R0RZbWdxTm41WDZaSXNQYTRUZktG?=
 =?utf-8?B?SlB6VzRyUnpNSWNNczNmUDVxVEg5U1N6cWZXM1BpaWF1YmdxUmoyaXRZVURx?=
 =?utf-8?B?d3lJeE05OHphcjZOWU9hMmc2UWxqdkNKNlNUNnRHTXgxcUltTUx2OE9uUWlD?=
 =?utf-8?B?OUZQQTJtL08zckpNclJDbkVwVjJrRzNLTUMwbFRKTHlnaytqd0FHOVp3Mytm?=
 =?utf-8?B?UmJSanptOXYxZkpxOXJNa2ZmQkQrVVZVbVk5aUdObGJqY2JvRWtNbDhZNkhM?=
 =?utf-8?B?UjQ3dklWQzhSenZQOG52bWJZUExXbUJaU2QzME04TlV2cjRXMGVrbWgwTHhL?=
 =?utf-8?B?WDZFUFA0dHBBbUQzazRxdzdoZzZYV2tUbmNtS2dNNmo4aVdZTy9iU0FBRnZH?=
 =?utf-8?Q?XspPcP03OBGAxURAZ0PRKcI5vdw95m8ho6GFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGl6UzRoUHVIK3NqZGZwb01nWi82cDlJMjBINTEwaHFtaWFveGhjRHoxbWNa?=
 =?utf-8?B?czhkVWVTSjVtcTlOTVB1M3VtaTVIcHZFNkRzMUphT2E0U0hxcFNEOUJBb3VV?=
 =?utf-8?B?RW9MTlNRcVl5aHdKZ01OaTdtKzkrNWd2UEw3QjJtc0lsSEhGTEp5VlNjdkFi?=
 =?utf-8?B?L25VbCtvR1FSM3F4SXJEM1pZNDdXS2xMRTlBbmNFL0laUEhiU3NxZEREeTZO?=
 =?utf-8?B?bHYxcTMvZWtQQS8yMllqSTNkaEtRMkFqbkozMTRNcVF5UVRnYUxQR0JiU0p6?=
 =?utf-8?B?cWVnK2IvTHd2dDZjUkU0RUZJdzhTVDZQNjk4SFdTeGUzVGh6RkpOSVZIWHdP?=
 =?utf-8?B?Y3FsTmNqRllvbDRHQ1BOeFdhWTRoTmJSYnBGRk1ReHZqSG9mYS9lTnUzcU5O?=
 =?utf-8?B?SjNNWGFabmp0RytPTU9jcHBLNnl1YzFpek5MSmxEdGN3UTYwWFVlZGdaNk01?=
 =?utf-8?B?N1lBaU5ycWRNRU0rdVdCS2NSNk9jYnAwdzFHcDd5cHc5eU1sVUk1d2tyWjFr?=
 =?utf-8?B?UGI0YzEwV1BvKzZQS2lTVUlSL3FQQUdsVkZ3VXByN2s4Q0RkSnhBTG82S1I5?=
 =?utf-8?B?WVVrUHArM2tNajZ4eWl4Tyt6NjlLeDZTQitpSTlaRVVTZHl0bXB2dUNSTFl3?=
 =?utf-8?B?MEk0WjRUcWg5ZHo1ZFFjRm5ZQUV5aHdYVms4eWx6OW10TU1JK0ZWYngrVXNS?=
 =?utf-8?B?L1FxcUxsajYvTUlLaHlCNVViNUg1UFVFZFRLUXpmNkV6T2xEQUpDbC9tOTZu?=
 =?utf-8?B?SkRtZzRlRlJMcEoxcHFRSm5hSUlGbk8wYjdZOWplOHZFMHNvZkxTRk9WUjUr?=
 =?utf-8?B?WW5WaWZrYnphKzFhbHdiRFp0cFBOMDJ1b2ZiWVNRYkpjVUpYa1BGTW9PTG5O?=
 =?utf-8?B?ajBDbXdnU2JIM1NTUmR5YVNEMUNncHI1ak5qaDZiU05OWlBBSHNlc09rVXNL?=
 =?utf-8?B?cmUvbmFXb0pMQjVxaTk5U01GK1lWdjhlVjJ3Z241ZENUc3crcHRQanRhTTZC?=
 =?utf-8?B?ekxyQWRPbGV2Sk9NbUZMczM0UkNUMm1xY3FqQ085TGZxeUxRc1ZKeldyRURm?=
 =?utf-8?B?RitlbndmT0IraTZ3YXdLb1JoN3RGSDk1K2lHSElLUzA4b0dXVEpHYWJSS1M5?=
 =?utf-8?B?ZDU4aVBiZ1ozQ3FlTkRXLzZlcGRDdHk5RWxpUUhpRFcwc3lEa1cxZlNVQVcy?=
 =?utf-8?B?cGhhd2N2bzE4Z3FpUE03RDZVcWt0SHVuQ0Z0cHZhWHQrY2d6R0diVnc0MFBo?=
 =?utf-8?B?b0dEaU04S0ljYWI5VjBCdmsvNmxNTmZZTElJd1czNlZLV3hPQ1FGWTVuYzdq?=
 =?utf-8?B?UmYvb3QyRktJM2xpa24yZDkxMXQwR2hTUFNOVU9Vc1N6UDZ5bEQzMUFlMDRX?=
 =?utf-8?B?cGxEbUJncFozUWhKUEpXMDJ4UXFCWHZ6SjhjcWE3ZUYyamE5clRwYURNVzcr?=
 =?utf-8?B?T2JRR1d0SmhXdE82QVB1eEF4OW9STTVncE92REdpWUtmaHZOWkh3eUp3TDdO?=
 =?utf-8?B?YjFoWVJYVU9sRDhlNHpLbmI0VFV5Ukw2ekFoWTZ6VCtDVG1yTjI3cExtRmJD?=
 =?utf-8?B?aTU1cE9XMnBLNHNzSk9hN0pydGY4UTlOVXBoMmxuR3NEbzluaDdDL3JGRFpx?=
 =?utf-8?B?R3ZjdlpOZUdjWEhvY1NWd2dYa3RjT3llaGNLdFJzWTJmQU1GWWMreGZITVZn?=
 =?utf-8?B?WCtvVkhvYjgzWDcvNnZUM3NEdXQxYlZZM3JOa3VFaHdTY0NhSHl4WldYc2xq?=
 =?utf-8?B?UXZDQW0yQ3NHWklubFZ1NFdwSUFYanhWaHhWdVRhNU4vbzlCQThkUnRrQkNX?=
 =?utf-8?B?L1dBV3FyTlI3SWVhdzVVQzg3MkplWXdBUkxnNU9mak9seWZrTlBIdXg4R1k2?=
 =?utf-8?B?ZnBIc3YzUVdxS1RtOU1kQVVsUGcrb0VyelhWSEJscTJNa0ZBWEtWR1N4ZVdw?=
 =?utf-8?B?SGgzME8wTGRxUERLeWlyMitKRm1XaVhseGVVclYySFdDQU5WeXpYd1lQN3hF?=
 =?utf-8?B?dXhJY0JCTFV5VDFrZlZBUTl3aWx1WG1URXpnTU9LZHNjWG5MbTl6ZERFM2tj?=
 =?utf-8?B?MjJhVDNLb2pSV0NXQ2VjdGJPSkhZRnlDYXlGVEZOVkhaeFY3aGVrYWpEWko5?=
 =?utf-8?B?Uit3ajNIWTgrRCs1bmF5V25IaklpcFIra2FzaEdZYzJSRmZPQTZQMWZZbGhE?=
 =?utf-8?Q?xponcDe9xkuYo/vyzudWmtM=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b556f07-b319-4586-6087-08dd027d1804
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 18:17:25.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57lkvu8xzkHLi1857Kwd3+ePkg9u6J8n5/Rl++Up2B5w9IbTIQxHf3wwyIrPJoy+t+TZxLDLpvg+iuCT1hDDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4743
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <30738260EC3BED468E7315D191A77825@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: fSLAEFJwBJOiGAR0ih6XUbqaa_aujWGc
X-Proofpoint-GUID: fSLAEFJwBJOiGAR0ih6XUbqaa_aujWGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 11/11/24 09:28, Johannes Thumshirn wrote:
> >=20
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Shinichiro reported the following use-after free that sometimes is
> happening in our CI system when running fstests' btrfs/284 on a TCMU
> runner device:
>=20
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
>     Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219
>=20
>     CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kts=
+ #15
>     Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>     Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x6e/0xa0
>      ? lock_release+0x708/0x780
>      print_report+0x174/0x505
>      ? lock_release+0x708/0x780
>      ? __virt_addr_valid+0x224/0x410
>      ? lock_release+0x708/0x780
>      kasan_report+0xda/0x1b0
>      ? lock_release+0x708/0x780
>      ? __wake_up+0x44/0x60
>      lock_release+0x708/0x780
>      ? __pfx_lock_release+0x10/0x10
>      ? __pfx_do_raw_spin_lock+0x10/0x10
>      ? lock_is_held_type+0x9a/0x110
>      _raw_spin_unlock_irqrestore+0x1f/0x60
>      __wake_up+0x44/0x60
>      btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
>      btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
>      ? lock_release+0x1b0/0x780
>      ? trace_lock_acquire+0x12f/0x1a0
>      ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
>      ? process_one_work+0x7e3/0x1460
>      ? lock_acquire+0x31/0xc0
>      ? process_one_work+0x7e3/0x1460
>      process_one_work+0x85c/0x1460
>      ? __pfx_process_one_work+0x10/0x10
>      ? assign_work+0x16c/0x240
>      worker_thread+0x5e6/0xfc0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x2c3/0x3a0
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x31/0x70
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>=20
>     Allocated by task 3661:
>      kasan_save_stack+0x30/0x50
>      kasan_save_track+0x14/0x30
>      __kasan_kmalloc+0xaa/0xb0
>      btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
>      send_extent_data+0xf0f/0x24a0 [btrfs]
>      process_extent+0x48a/0x1830 [btrfs]
>      changed_cb+0x178b/0x2ea0 [btrfs]
>      btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>      _btrfs_ioctl_send+0x117/0x330 [btrfs]
>      btrfs_ioctl+0x184a/0x60a0 [btrfs]
>      __x64_sys_ioctl+0x12e/0x1a0
>      do_syscall_64+0x95/0x180
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
>     Freed by task 3661:
>      kasan_save_stack+0x30/0x50
>      kasan_save_track+0x14/0x30
>      kasan_save_free_info+0x3b/0x70
>      __kasan_slab_free+0x4f/0x70
>      kfree+0x143/0x490
>      btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
>      send_extent_data+0xf0f/0x24a0 [btrfs]
>      process_extent+0x48a/0x1830 [btrfs]
>      changed_cb+0x178b/0x2ea0 [btrfs]
>      btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>      _btrfs_ioctl_send+0x117/0x330 [btrfs]
>      btrfs_ioctl+0x184a/0x60a0 [btrfs]
>      __x64_sys_ioctl+0x12e/0x1a0
>      do_syscall_64+0x95/0x180
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
>     The buggy address belongs to the object at ffff888106a83f00
>      which belongs to the cache kmalloc-rnd-07-96 of size 96
>     The buggy address is located 24 bytes inside of
>      freed 96-byte region [ffff888106a83f00, ffff888106a83f60)
>=20
>     The buggy address belongs to the physical page:
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881=
06a83800 pfn:0x106a83
>     flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
>     page_type: f5(slab)
>     raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 0000000000000=
004
>     raw: ffff888106a83800 0000000080200019 00000001f5000000 0000000000000=
000
>     page dumped because: kasan: bad access detected
>=20
>     Memory state around the buggy address:
>      ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>      ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>     >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                 ^
>      ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>      ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Further analyzing the trace and the crash dump's vmcore file shows that
> the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
> the wait_queue that is in the private data passed to the end_io handler.
>=20
> Commit 4ff47df40447 ("btrfs: move priv off stack in
> btrfs_encoded_read_regular_fill_pages()") moved 'struct
> btrfs_encoded_read_private' off the stack.
>=20
> Before that commit one can see a corruption of the private data when
> analyzing the vmcore after a crash:
>=20
> *(struct btrfs_encoded_read_private *)0xffff88815626eec8 =3D {
> 	.wait =3D (wait_queue_head_t){
> 		.lock =3D (spinlock_t){
> 			.rlock =3D (struct raw_spinlock){
> 				.raw_lock =3D (arch_spinlock_t){
> 					.val =3D (atomic_t){
> 						.counter =3D (int)-2005885696,
> 					},
> 					.locked =3D (u8)0,
> 					.pending =3D (u8)157,
> 					.locked_pending =3D (u16)40192,
> 					.tail =3D (u16)34928,
> 				},
> 				.magic =3D (unsigned int)536325682,
> 				.owner_cpu =3D (unsigned int)29,
> 				.owner =3D (void *)__SCT__tp_func_btrfs_transaction_commit+0x0 =3D 0x=
0,
> 				.dep_map =3D (struct lockdep_map){
> 					.key =3D (struct lock_class_key *)0xffff8881575a3b6c,
> 					.class_cache =3D (struct lock_class *[2]){ 0xffff8882a71985c0, 0xfff=
fea00066f5d40 },
> 					.name =3D (const char *)0xffff88815626f100 =3D "",
> 					.wait_type_outer =3D (u8)37,
> 					.wait_type_inner =3D (u8)178,
> 					.lock_type =3D (u8)154,
> 				},
> 			},
> 			.__padding =3D (u8 [24]){ 0, 157, 112, 136, 50, 174, 247, 31, 29 },
> 			.dep_map =3D (struct lockdep_map){
> 				.key =3D (struct lock_class_key *)0xffff8881575a3b6c,
> 				.class_cache =3D (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffff=
ea00066f5d40 },
> 				.name =3D (const char *)0xffff88815626f100 =3D "",
> 				.wait_type_outer =3D (u8)37,
> 				.wait_type_inner =3D (u8)178,
> 				.lock_type =3D (u8)154,
> 			},
> 		},
> 		.head =3D (struct list_head){
> 			.next =3D (struct list_head *)0x112cca,
> 			.prev =3D (struct list_head *)0x47,
> 		},
> 	},
> 	.pending =3D (atomic_t){
> 		.counter =3D (int)-1491499288,
> 	},
> 	.status =3D (blk_status_t)130,
> }
>=20
> Move the call to bio_put() before the atomic_test operation and
> also change atomic_dec_return() to atomic_dec_and_test() to fix the
> corruption, as atomic_dec_return() is defined as two instructions on
> x86_64, whereas atomic_dec_and_test() is defineda s a single atomic
> operation.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 22b8e2764619..cb8b23a3e56b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9089,7 +9089,8 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>   		 */
>   		WRITE_ONCE(priv->status, bbio->bio.bi_status);
>   	}
> -	if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +	bio_put(&bbio->bio);
> +	if (atomic_dec_and_test(&priv->pending)) {
>   		int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>  =20
>   		if (priv->uring_ctx) {
> @@ -9099,7 +9100,6 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>   			wake_up(&priv->wait);
>   		}
>   	}
> -	bio_put(&bbio->bio);
>   }
>  =20
>   int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,

Thanks Johannes, this patch looks good to me. Thank you for fixing.

It looks like atomic_dec_return is a bit of a footgun... does this imply=20
that all instances of atomic_dec_return(&foo) =3D=3D 0 should actually be=20
atomic_dec_and_test(&foo)?

Mark

Reviewed-by: Mark Harmstone <maharmstone@fb.com>


