Return-Path: <linux-btrfs+bounces-10933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D282AA0B3CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 10:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BA71885072
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7181FDA89;
	Mon, 13 Jan 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Sos6AI4u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD214B950;
	Mon, 13 Jan 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762380; cv=fail; b=D5xdmzGYyJKuOKt9RYnBCIXqrvXUjJYdshfuNvJSes3lE+HVa5SaI7z6xOllXsMtjTqCryZjfGEzB3ozvM2ByLTBJcIyIC8CdFapizWffOIfDL7zsQqVM7h0BkLcqkUD46UzcSlZ64BmapnDNlSFkoR3lFdCVkU5IiTcvJhR/ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762380; c=relaxed/simple;
	bh=amJxrZsPjV3tr5dwjgSnfsLIzrH7eVrsjo6cxjFbbio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dfI6wsvYGyWEyfAHvqNn+o1hbUpRDFgwCqZznpZPs0rdO+On12coWjW2tAbyeyE0wGnVyM3jf5DnFnEYq7DvAFl/boDk9KPcCXrd0Ku6S7cOp2gUXSqbF8SF5axHyHA10ylo++6YZYYI47HLBfN+xsIT9GL+1HHvI1BzkL1valg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Sos6AI4u; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D7tAfY032064;
	Mon, 13 Jan 2025 01:59:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mhU12Sw2E4z6ywXtcLjeSa9qAP52bW3GYvqGPUTjRVo=; b=
	Sos6AI4uZHUjJngiZUkdtCitRZFibCeXxdTZIDHTx8X7QUmaajDWg9SaKT7mgavD
	XpjxG5dOQ1/QEJ7gVhUEJyM1rQfEU1kAd1vZL0mFKXrNg5TL/f+gTzsL35/7V89A
	hBc19JroOnn/vtzVW/paGIi47+8PSOQNlslNuIjy7DJStyRb3mjls6vlCcWtIvbV
	JGTCwLudDmGAaFOb/tyQcOIdwDIdX3FVUFzLFm7SPZPmJMwu0hwPpBvwh8tdCvRQ
	WLnk9yDjrmUfRqsiXF8R/8S0mScsbKE/ulSGvTBfhE9K31d+6jp8zCruLO/sMf2Y
	iclj3L8+lgQIb5Sc7hufsA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 444xv0rhrj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 01:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkne0zMZLVay8wGX+/mwYLFf6MCO70qIndQtYiMnQxcHpePKXuENAqkzrfPhP+S134BlzchG3lv+DPArZSmB4kSb1GEy5xoSQubIYLKxurOKNHUwudKPRzkqBdIqhu2ZP+WHRmjgCEjk8PihRgHXvaIZMi5SDvcsLPnUskukOwxR358qKb3It3PVbFh/Dvf5ndUC7URy2jIDh2yGdTVgKtCxXHMcxc7J/dL1rHAFt4yHAuentKu4i+WoEQxJjIZvMynhLZVYsF6LZRXJXObtZGGPvYbBmHblVR18G6E5mdk6sWT66XpCkmnU2Ps2bXPnzBpD6thEl/aH2bIwYHMveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C40qhwNTnIA1iDoU6WTpyW1zt/nflY5+JXbHtdi8hc=;
 b=rtaoglEe6zs6hmH7cUN3x1NMyAHX1FDnEIsC2L0s8JtQ79VBX8+GcWKoIWThwY+/ugj+S9irOkNMY3rc09SzVTIK5LRFmI4NuPeCY1Gb+gtKRxLvRcTOLZeFjVbc5+KNtboWxbSgSpGvAfzKXkkPoYe0+kQdmpg4/6ptXIQpdfge6ZISv8iGluVKM4tQ7UbJFMFkr2NIXARQDT+KYT6Q2RnS2XflDD7GqrJiiZjZ9yZP/GXbnecB56Z1qpo4oH30agTLlLlPKhMg/4bid4oIPsILJMyN48dXCmTBEvtqkqaEzPbnSW6Qny6RQWUAtv94ohvvbQYo8kgPQZgq4beF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5659.namprd15.prod.outlook.com (2603:10b6:510:282::21)
 by DM4PR15MB6298.namprd15.prod.outlook.com (2603:10b6:8:18c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 09:59:33 +0000
Received: from PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d]) by PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d%7]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 09:59:33 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Zorro Lang <zlang@redhat.com>
CC: Anand Jain <anand.jain@oracle.com>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>,
        "neelx@suse.com" <neelx@suse.com>,
        "Johannes.Thumschirn@wdc.com"
	<Johannes.Thumschirn@wdc.com>
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
Thread-Topic: [PATCH v4 2/2] btrfs: add test for encoded reads
Thread-Index: AQHbYEOL8yANOfbvsUamymoXj1OS+7MMbgwAgAPN2wCAACoegIAEHSMA
Date: Mon, 13 Jan 2025 09:59:33 +0000
Message-ID: <8d27b336-7d45-4375-8dcc-9b5818e3a0ff@meta.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
 <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
 <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
 <20250110191013.o2jieeflghev2bej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20250110191013.o2jieeflghev2bej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5659:EE_|DM4PR15MB6298:EE_
x-ms-office365-filtering-correlation-id: 70e00f72-0070-425e-1fff-08dd33b8fadd
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QURUdlEwb1J0MWlSd3czaGtwSkhodXBHZ0dGMHFyQ3laT003ajRwMWJCZTlE?=
 =?utf-8?B?ai94SzNEQmZLM2V1dzRYSGYvU0l1bktJVVEzN1FRRjBNdjdhb0NzYmZ3bTkr?=
 =?utf-8?B?dDVSVGw1OW5iVGZKVEdIeFQ3b1o0Z2UydUpvelRDdnRLMnFXejRxTVdiZ1VW?=
 =?utf-8?B?cHN6a1ZZZ1RYLzhFeFdRMEp6V2QyNEhPNDVzNmtmN2I4dzZQQjh3eWZmc1RJ?=
 =?utf-8?B?L1ZWbU1NdnNKbXhIMUwvazYwNm5naE4rU1pBNVh6Smg5aUQxQVJ0VVF3bDRC?=
 =?utf-8?B?ZXZMalJkQnlmOWFhaFNmQmxrM2dXOVh5TTBEdTlqVW00ejlmVkhLeEhmZ3c1?=
 =?utf-8?B?MC94eTZzQ1VsUTFpY3dTZlBCUzlIaVprZFFOWndTYnNWZ2J1Nm5UMzZiUFNT?=
 =?utf-8?B?OUtjaUgrUTlBR3RzYmM4L3ZwMTVjRmcydEtQSjcyazdxalhmNktMejlnN0hE?=
 =?utf-8?B?cnVJcllrYU91SEVnbGVPMUZucHVBQ3R5YjcvbjdIenh2SEpKM2JhSlJ3WDNC?=
 =?utf-8?B?ZlN0aEJNMU1ZaklGTnhaT0FRQzRoWW0rU3c5OHhqT0o2S3NnQXFDaXlXd1N0?=
 =?utf-8?B?QjlHNklhbktGc09ZRlNLczlkZld3VVVIc1VIdjZpTGRuWTNpeGQxRkdFSTd0?=
 =?utf-8?B?cGJueWNPVjlQYi9KbGxZeGdwV3JwaGRaVDBtSVZKcU92M0pTTmJia0thbXlM?=
 =?utf-8?B?dzluWmxTR1d2UXg5bTZVem1HY2VQQU42bGhUK0MyYWpBODFWcEpLaEhISmp2?=
 =?utf-8?B?am1aaHRoYStCaERGUExySFVpaEovVGUzRzFObFZxaGw3OUoxUWlwTVpZRVRD?=
 =?utf-8?B?QkVhMHlaVUVVZmhHc2U0UFJ5UnVvWVY0bmxQM0FqNzZNNkJmTGIyaWR5aklt?=
 =?utf-8?B?aTFRVkFhd05xeTJ6VUk5TlNqSzQyWE15WnNPSm5zN0VxNWpIRVNLeUwvdG1q?=
 =?utf-8?B?bnRCOTIvUGoydmxLVGJ2amQwVDVKeENKeUZVSEF5elJsYmhFTkV5RlJDQmV5?=
 =?utf-8?B?Z3FTVEdMYjlDOHdjSGo2STVZOWVxbTU4TDM3dWNIS0dLL2dXL0haUVFCcVlB?=
 =?utf-8?B?cSsxaWtTN1B2RW4wVllPWFQ5SHR3VExhWTBUQjlpZ0Z3Q3FCMktVbHN4a2FE?=
 =?utf-8?B?WEZnZE9pUk5SVW82QkFjUkFBeXhuTWRvTEc1VU82VUcrWjI3VkZYK1daYnpP?=
 =?utf-8?B?Y1hKZjQyMGEyRTI4N2xmNENwSlQvNjlOWTF3T1B3MzcvWVR4N2NnYjVOQWtm?=
 =?utf-8?B?R0d0NlRPQ3RTaGw3SVNqdlhPUjRPajQvZDNrRElpZUNUVkEwcEVCY0tHUGd2?=
 =?utf-8?B?aWlxMVJzWDRrV1FvMHZuQVJHL0NJTnZOQ1V6UGxEc3B2bm85aExjMDJIZ0th?=
 =?utf-8?B?RkFHeVE4WWdiUm1mMFRLMzRQWlhJSldGbHgxNHRSRW9BMkpCTWpCcmVsaXFJ?=
 =?utf-8?B?MlFKSVZsNnREMmJwYmlML0QxZHZuWDBPQ2xOV25FMkFZZ2xOZFAxejB3WGJw?=
 =?utf-8?B?K2ZlZFoyTzhYR2xQZzlVK0JiSWROVHJSTUptV0ZidmR5V2hQemhjNDR4QTJM?=
 =?utf-8?B?NmY1em14QndGcDB5ajNKTE8xMU5JK2NtQTgxaXhnR3pHaUlMeHRKOGczd3BQ?=
 =?utf-8?B?Uno1MFZzN1ZSWDMzdVkwdzFRcEFRUFAyRDRQZFdXV2VDUnUwbTBJQmF3ZS9k?=
 =?utf-8?B?OXR2OTRHOXdpMHFPTkVrNnhHUDV6ai9oSWRxWFdoWW53RStnalpHT2g2MTN5?=
 =?utf-8?B?QWVMMUZYNXRib2NJbk91ZW9tNWJubEEwY0ppYTZMdjJUamMzTHoyc2pDclVL?=
 =?utf-8?B?RG1sT2JqbEc2QzdEaVF3TmpvalVDc1ZSalV1UmgxaDhaMitQT2hUc3JCUkFE?=
 =?utf-8?B?SFJnQ0RiZWU5SFlRQWJnOFdDblhzWWtUZHlsa1k4dU5rak5pMmF0OW1jeFlO?=
 =?utf-8?Q?AWqJ1tU/ERc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5659.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cSt0QnhOemlYQXhuQUZoZ2tqQ0p0RmlEZVByWWwrL1JhdGQxdW11ZmVKSTFB?=
 =?utf-8?B?WVBLSlU5ZjU2eE5iMmpJd0FEdm11aDFDUWgxcXFsd05xdXdIVjVXNWFnMUcv?=
 =?utf-8?B?M2ozeTBQUkcrczltTTF3UTV0MDZzS3BKdDQ3VS83ZlFPOWt5SXBzYS92ZWEr?=
 =?utf-8?B?L3VDM3FDMmFOMUN2TGtVTVdLWUFIN29JZUlaRVdiL3FMSi9aQ0NwU1RxdmJl?=
 =?utf-8?B?Ym1jSGkxT0dGU1ZPdzhXZGw4ZkpwYlVCVThLdXVobUNkeVlUdmNkZzZnblBh?=
 =?utf-8?B?RExpaHFUM1hNZEhGbEpJUk80OEoxbUZaa0xSVWNxQ2FrWU5rS0YwaHcvaVdT?=
 =?utf-8?B?VzRmVHlGbExTVXFXNXBPVDhkUi84ZUhHd1hvSExEcWREMUZnTVRMaEdvdmFl?=
 =?utf-8?B?cEhSRE5HVSsyZ0tTR0FxMkQ4a0pGYUJSVUtVOURVNDVDWGt0YStLTXBOUjIr?=
 =?utf-8?B?dENtQlo4VDNsaVFIRzRHT2ltYkRuU2daa3NwMlJOMXZPbmhjaTZZYkJlakZU?=
 =?utf-8?B?RlZPYmxGbWdmOEVIQXlnMEh2elE4ZGMyc0xUa3A3d0w5bk9sWDZqdjEvY09j?=
 =?utf-8?B?UnlEL0w4Q2J0WmVpeTREelRBUHN3ZTRUcmo3RTNTT3phRC90V0R0SDdYNm1B?=
 =?utf-8?B?K3BGbTZQejBPRFJxM0dGVW9yZ1daN0U1NFpqeS9CTjlJcndqbXVxVnNJbDhK?=
 =?utf-8?B?YVVXcHh1VitzRTRoS0NoZHV2V05OaEwrZGc5ZlFRYTFjQmFOaUs1TGxYQmJH?=
 =?utf-8?B?VlJDc2RoVEdIeC9hSDhJeStuTEZwSVJiTVRMWTRsWFZGajd0WWtFbGtmM2Er?=
 =?utf-8?B?eUJXelVHVzVrNWI2MXZIVE1ZWDM4cGRkVEw0R1cxQ3FkN0ZqaHpsaUl2SE1W?=
 =?utf-8?B?U3FzZ1NtOWxtbUdiUk1rUm4yd3BhSy9WL3dVUVBaK1EzM0JFR0J6eHFyVlNo?=
 =?utf-8?B?U21UMEhZeGQ5bW5pMm9Ob0pWQlVySFQxbDFVdHNDaWphbm8xSWd5US9HYWJs?=
 =?utf-8?B?MTZYZFNKbGtWS3ZoZXJ6eXpsdkUwbmV3ODVyQzdRVzZuMW05ZHF3YkFMK1pm?=
 =?utf-8?B?d3dpTzQ2UWxETkc4ZlhNZ2JYQTYvcVdaMWExaUtlK05vWEQrVjhjRS8vSUx5?=
 =?utf-8?B?d1EydFFZSURCUUhWWDMvc2JidGJQSDd1dnlrL0wrYzhZcXVJN2t1SXNySi9E?=
 =?utf-8?B?U1liQTdUWjkyaFlPR2NldlY3VHZkOE9Zd0RRZ080L3k2Z01IekUyaWY0TUZ3?=
 =?utf-8?B?NGhueHRXKzNZMHdFTWthL3hKSituMncvUmpqNWhvcUQ1ZUJIamJnZ2plWTRM?=
 =?utf-8?B?RGdXbXVPdFBSM3hlNnFOZ2tlYVoxL05XSVRVeFVUUGNqY0xiV2l1Q09iOTJs?=
 =?utf-8?B?WWVjSVp6Yi9yR29Oc3RnM3dqNUttSEtIeEVxQzhKbnkxQ1pqK0ROQmxEUXFZ?=
 =?utf-8?B?WnpmYnJEQ1lvQWFjNlF1RjlkaU1kak1oMXRVellsdHo1VkQzZ3dXNGZ5VUhh?=
 =?utf-8?B?L2RoSGxOc2lWamUvVXhIR1dIbkNXSWN0b0tIbXpoQWQvT0NGS0xoa3hOa3pM?=
 =?utf-8?B?UGpKOEJybElZcXRTTlVSN2tWSG1qZEo1Tmh3KzVpOVg2dGdGemFTRmtOK2ky?=
 =?utf-8?B?TWNhUXZJN3hRalBacjlsZFpSSnY0TTlvT2JXcERWbkJVOUtZU2h3cGxJeDYz?=
 =?utf-8?B?NjBNMmdDa1dweFFTSWxNOSsyRHZycytPbmZuWk9wQnAycFk2dzdkL2VMY3pl?=
 =?utf-8?B?Vmw2b0c1amVreFpjZi9hOGdIeEVxeXVDNFVrYnp0S3dLalpLU2tNNmVzZ1Z4?=
 =?utf-8?B?MTNKUnpJU2NBdEZZQW5VUk9ZZ1hpVzZDdGtub3U3M3BnVmxHZWVac0lPZnRJ?=
 =?utf-8?B?b3BCTjFQbDYrd2JnMW9mNkdiYWgrUW9CVlFIMTcxUmtoUHVHcGdnUW9YV0ZG?=
 =?utf-8?B?cDUxYm54S1dObFVSWW42WFdyNFJFWWFpS0VpaTRPZVRPaEtieHp2SUw4Vkth?=
 =?utf-8?B?blA4VlAvdnBPcGxCcXFDRFFiWmlZR3dJYm1zczJYTnpqOGo0Q2UzeGhqRjJu?=
 =?utf-8?B?YmhZTXFkc3JERnNYN3JFNkdzWGViLy8yYmNQVEp2cXdlSFRQam5EelBuVjZU?=
 =?utf-8?B?alJQNjlWNnIxcStHVklyQVJBSkt1d25ZMURRc0h0b0NjbmF1b2NtRlBiNnZa?=
 =?utf-8?Q?i6CgyNSNAD/qXO9EP9cZzxc=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5659.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e00f72-0070-425e-1fff-08dd33b8fadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 09:59:33.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkYUbHhv10dW7oxwQ1xavICqfN32rzCkzQAIx5lv5BX9fe94VFoSpednEaTAG7KJFZqZcy49p8b4NzXzXJaSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6298
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1B9C0DC2DACCC046BE6D34FAF15330E9@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: 8k6RPGEflg5PJ6swpLBIiXOFOZ_t9aJC
X-Proofpoint-GUID: 8k6RPGEflg5PJ6swpLBIiXOFOZ_t9aJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 10/1/25 19:10, Zorro Lang wrote:
> >=20
> On Fri, Jan 10, 2025 at 04:39:29PM +0000, Mark Harmstone wrote:
>> On 8/1/25 06:33, Anand Jain wrote:
>>>>
>>> On 6/1/25 19:31, Mark Harmstone wrote:
>>>> Add btrfs/333 and its helper programs btrfs_encoded_read and
>>>> btrfs_encoded_write, in order to test encoded reads.
>>>>
>>>> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
>>>> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
>>>> that it matches what we've written. If the new io_uring interface for
>>>> encoded reads is supported, we also check that that matches the ioctl.
>>>>
>>>> Note that what we write isn't valid compressed data, so any non-encoded
>>>> reads on these files will fail.
>>>>
>>>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>>>> ---
>>>
>>>
>>> Looks good. Add to the group io_uring and ioctl.
>>>
>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Thx.
>>
>> Thanks Anand.
>>
>> Zorro, can you please add io_uring and ioctl to the _begin_fstest line?
>> Or do you want me to resubmit?
>=20
> It's been added by Anand, I've merged it. Also I'd like to remove below l=
ines:
>=20
>    . ./common/filter
>    . ./common/btrfs
>=20
>    _supported_fs btrfs
>=20

Thanks Zorro. If it still works with them removed, sure.

Mark

> Thanks,
> Zorro
>=20
>>
>> Thanks
>>
>> Mark
>>
>=20


