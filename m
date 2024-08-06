Return-Path: <linux-btrfs+bounces-7009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF79495BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5F31F259B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EEE40862;
	Tue,  6 Aug 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HOYz44fR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22002AE99
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962525; cv=fail; b=o7xsc67uYU0qFRkssDacmc4fzO8EyYq2XHP+nw7RSOxXQmshfnTT1vwZK7CoKkI5gJFHK0vS3kwhqIxYSfsaCAMrrsk6Wz7jaHYWOzX73u2XsOkzR5k8o8qUOh5ETfjKC4Y83ZnCpeEr2rhZXSIKUR8ayIqWpeXN8ZtT60mQvhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962525; c=relaxed/simple;
	bh=dhTqexPQtM1CSks7RwycKpPC82HLC00OO9qGR1KP3RU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SlcbVaER46i+t0mvZoaoKO4ccWDaxKZd/MTpY2q59FosB0BB5Qh+8GwYMMzGcAmEsucvmHZYZGqRL5PhD2yViUIyvuU4TjNtD/J1TJe1p5cDdxaWuCDYJY5YCC8T+rrMlO/ns3iOtLprMFIAHpLQcV+5hD7n4HwAkMr4tDZcoS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HOYz44fR; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 476CsYir029313
	for <linux-btrfs@vger.kernel.org>; Tue, 6 Aug 2024 09:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=dhTqexPQtM1CSks7RwycKpPC82HLC00OO9qGR1KP3RU=; b=
	HOYz44fRS1cBvQNipPRgsb8oXUIAgrHM07xfpPTJRolWw1udes31zROQwP5aeY+D
	vOO6yToDz4P7snqyzc/pJofho1PLagDM8Wu57raG9ANNu1JSoCLJ1SVeydC6CYNh
	ZxTSVPkhjarf+0aqarSmrXwm7YnTNiQf9yAKj+TCK3XB0Nhkg2/9R5P5IJRqGxxT
	Q1YJwdEg+obv6KEFV6pZsGj4ekXW/7PRZmgvZcvopzghYajbXFpS7MeZPrYzAdQ9
	oT40/Kzsi/AkEOJOtRZSgwRZZCaSZlP1uIkmfrLudoxFJiNYidpb+y8+/0o459wc
	3zJPAkKsZtHgPfRq/+AiEg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by m0001303.ppops.net (PPS) with ESMTPS id 40u3yw71cs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 09:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezKf1Mq/USlBqjPiwk2+Jf/LKl9nQmk0B4wKAMcBl+NAJ0JBfQWt4fWnkeu/EsleFWxOODMWAcmDVUw1bIaFalQEyJnIELlwApZtbVLGJp3ZUVh4jRCr/VVhoKmr8jBDdUmHONX2xr0TJUcLT3EXOasIAxiqJ89VkgvUVnLZ+oGPBWO/8Dt4r3e9hYQ5QL3szdsCCXaSJCTaDfJ9QLrFu4hn+zRfltg3Hdx1u/yhxI08xfIy1aCLfmyl64HTWGyj2v+Fe0dTRrChFSV75Iw2hP/bqgxU1G313pcc2k23SbX3OMVRZpbEQIkJziTqlG7kyfzKMGcRLf4ubf+VVxfocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhTqexPQtM1CSks7RwycKpPC82HLC00OO9qGR1KP3RU=;
 b=Wh6m55L+ygMKel8NG+PLqJIokp246EUUzxgWOskMt4G7iO9dNSH8CWHX4IsGvBZStMw0oK1am5CReub1sSLEMZKSArVj8xZ/WV253hyrW2Ml0AQKeSbQ6mzfwWmBrI98dJRnUSpJ9eTCjwh+8w2XuPieOLY9za5opTORmeO78BO7vglhFIDaLtz7B7Z00GVmsx000vy8HQMf6ep4Y3O75GO3aSzkEMj8My4vSzyE8x9dqluQwQ15TfbromexVzlenBTweCijgEHAEtwvhmUx7/HdEXsyI24aEPNIoriZNe54dbVeVMUW9M9ehyd8Ntk23fk3nCLJIPNiyrZwx3GsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by DS0PR15MB6260.namprd15.prod.outlook.com (2603:10b6:8:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 16:41:59 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 16:41:59 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] btrfs-progs: use libbtrfsutil for subvolume
 creation
Thread-Topic: [PATCH v2 0/3] btrfs-progs: use libbtrfsutil for subvolume
 creation
Thread-Index: AQHa5M779dE7fn2YyEaHapvl44LMErIX2CYAgAKdWIA=
Date: Tue, 6 Aug 2024 16:41:59 +0000
Message-ID: <412217e5-1f8f-4788-a628-7b0106ef98a5@meta.com>
References: <20240802112730.3575159-1-maharmstone@fb.com>
 <e2d4cc82-bf94-4251-be9a-c98e6e0f6a1a@gmx.com>
In-Reply-To: <e2d4cc82-bf94-4251-be9a-c98e6e0f6a1a@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|DS0PR15MB6260:EE_
x-ms-office365-filtering-correlation-id: 1bb3d323-ef61-4813-0b13-08dcb636b129
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzRNaEpiY1dFU3ArT0V1RklVOTlqNVRYdzRlQ2dyYWY4dzk3WUtuR0R6ZlVp?=
 =?utf-8?B?T2lSdGZMU2hBU1JMdDlKN2V4SE96aUlOejhxcUpLR2ZnUEF6THp4Z1FNb3VQ?=
 =?utf-8?B?dWV6VWk2SkJlNXduS0ZFQk8rTlJ2K01TV3NCQ3Q3VXZicDBYb3NqTng3Unpk?=
 =?utf-8?B?dmprcnFORVh6M1QzaE1RNFdVTnk3OHJ4bkY4QTZLbmlaQlYwQzZJVTFZZFZM?=
 =?utf-8?B?Q0FHS3NNbGpLWHpBWHNjNm5USTBlSUw4aVlOT2hQcFAyVk1Tam5DSjExTEdm?=
 =?utf-8?B?aS9Wc0VKY1VrZWcxbGpBK2JIUGFpN3RkSGZhdHJ5ZFVQdXhvak81SjBIMW5i?=
 =?utf-8?B?ZU0xM25QNW5SanZES1lTODdFWEgvZzl2R0V5eFhrc1JvK1lFUVdZQlNMdmZz?=
 =?utf-8?B?SlU3V3N3VnBhMDZDWEdsWEVGY1NZZERCSTA1dFZRRVg3aUlYRHNGM1E5RzFM?=
 =?utf-8?B?OWxRcVhlb0hTUk1nTEZTdkJ6M1ptUG8ydXU0Szh2L2IyVnFzMThlY0FQbnpl?=
 =?utf-8?B?YTMzTlRLMlNFQmc4bTdSeUZDblRxdWRmT1I3clRkOEtaelYwUG44WnhiQ3pD?=
 =?utf-8?B?QVNSaWJzVDN1dlJiZ3g1Q29jYWF4eVdLNTJUOFhlcHN0Ull2SThBZlgxTUZ3?=
 =?utf-8?B?SXVNYmNkOTJVN3EwbXJiKzEyanFPRUNVZTZRQUM2TU9HZDI0TG9La1NtQ2lq?=
 =?utf-8?B?Y01SY2Juc0twckRtSmhzbmZFdlhhOG1KeDhMS3kyUVk3NGxEQ2xmMkZrOFhJ?=
 =?utf-8?B?RzlpcHFJamxoWkZmZllpSTNTTEdvSGlkVHRjNXJFdDhQOU9GWUVBd05HaVl4?=
 =?utf-8?B?aU5VVVBmRXpjTmd3UE9WMHMzMDJvZ1ErNG5KMGtXWHd1bnZBS1VpZ0IzUTF1?=
 =?utf-8?B?c054ZFAvM2lsRVpPN1RWMVBQK2gzNHV5enYzTGFFVy8zTXdzMkZMRTRIckYr?=
 =?utf-8?B?OUxubmlhKythUzZRakxWWHRaSlJHSXpNQlNIQWZvaEsxWWI0QU0ycGxxU0tw?=
 =?utf-8?B?Z0g1WFVjREIzSDdncmV6ZW1Qd3RRRHFqRFhadmFQck8zOGZocksyVEJaenky?=
 =?utf-8?B?MkJmdkVoaDFRVXRIWEhuejJOc2lCREptNUhrZUtiS0w2dHAxZ3RhejZDTStC?=
 =?utf-8?B?dXc4c3FzY2FoNnUzS05WM3lpODVJRG1aaDdXc1AxSEJWQ0VzckhieGt4QU1Z?=
 =?utf-8?B?UTd2R01QOGdHNHFtUktieTJhWFl6UXBlT0wydFpCcnk5RFh6WmVzREs3OEYy?=
 =?utf-8?B?K1NUSkJmRms1TWIrS1dDOWgvZlhlL0JoZkhhekZ1VlZwQ2RvR0pQZXM4cXoy?=
 =?utf-8?B?TnV3R2Z2S1BjVUR1dU85NlNMQ3dROFRzQTJ0VDMvbkNoSkQ1bDdYR3V2K0hv?=
 =?utf-8?B?SGVCNGViTHJzdWJESEtKUE1MTHpEeW5TeGZUdmIzTWp4YS9YeTRkYXlScmM4?=
 =?utf-8?B?WTNXTVZKNWlHVmRZK2JlaHRkWE5OMnhCY1hFYUdMZms3bitERXNjUWhhMkY3?=
 =?utf-8?B?Q3NTbHZuOFVoUWU4dU5iQTR4enRuSXFjRlo5N1lYay9ZeDlmVXVSdlBuTkJy?=
 =?utf-8?B?Nnp1NmtpL3hlNHhkWEhTZ3BENWFBYi9mMi9JTTEzT0xYSHc3Rk56YTMvb08w?=
 =?utf-8?B?VDdsbEV2bVpwSm0wLzFWbW54YmdmVy9WUkpZRlJsc2Nyd1dZQUZOa2hrUTVP?=
 =?utf-8?B?L1BxU1BlQnVTL2pSaWFud2c0TFcyVWpjd2lsSW1aekR3MEJtRzY0QzV6SVl3?=
 =?utf-8?B?WWZRNFNRTmZqTjJIeUw1Um5vWGduQktCcW1lN0lGWG1qTGZsTEQ1bDBZN2w2?=
 =?utf-8?B?NFk5cVY4TUU0cU94SDFmdFlNUUJyTUFKcTYvQjFSc0VsOFJmUFMwa05HeXV0?=
 =?utf-8?B?Q0RRQVhWOWRTWnl2QS9IdFdVTTUyNEROcmg3cU04cVhWWWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXZLNmJ4d0p0WjR5M0xlVllFVmdtdU84QjRLUjArK1hOU25nMm1tR0g3Mi8r?=
 =?utf-8?B?ZlFub2d0VXNJZVBncG93TmdXQnpuRXRVSklhVFJac0FqZ0RGcjdyQ3JibmZ5?=
 =?utf-8?B?TDRFanBOYnB4eTVkQ2Qza2NHOTlKbm9PRnNRYjhHa243SGpESVhtZU0zQlJC?=
 =?utf-8?B?aHJaY2JLc09zWmNRZDdaa2tRYmlySXZpOTFWYVZLR3VHYVVNdi81WUNPa0Vw?=
 =?utf-8?B?Qm5ZeG84dkhXaHAxdTRTemNjU0R4VVZhc3RaejJWS0ovOU5nWjd1T2k0ME04?=
 =?utf-8?B?c3c2MVhWQjRaNTFKMHBzR2xNdytra0Q1S1pNOWEvN1Y2clZPcWlVaTk1R1JN?=
 =?utf-8?B?U2hqd0Yxdlg2R3ROMFpUTHlFWVFueTBPV3YzU2dVbGs1VDZGaXVHcDlGdnBS?=
 =?utf-8?B?VTlzcGFUdjVaRG96UmxCSDhPNzVVS0JydlUvZEJWeWRGQmwrck1pOHRweVNX?=
 =?utf-8?B?c0JySUR0VUhMSUkwTjIvMHExY1FoMld6aThtQVZ6SzFzSzk4WnJVcXdPNTNE?=
 =?utf-8?B?b1gzY1FOZDRza291R215Ky9OVmZGTGV4SzFjeVM1VTdkS3p4T1hWL1hPamxU?=
 =?utf-8?B?cVkvb1Y5c1RKMW52S1Y4bklOVnE4a0FxZTFNMTRldCtZZFZZc05vdzFRVVBI?=
 =?utf-8?B?cUt1QW5ZaCtkblV2cGd6NnpGYmhNcHdvZUdaWjl0VURoWlRuem0wUjJFblJy?=
 =?utf-8?B?L0NTcDM0RXVyQjJaKzFOMFBjZGk0d3BBQUgvWUtXUzRvMkwvQmFRdTFUenkw?=
 =?utf-8?B?RGRTSkgwbHNIVGY1eVZuSUtUc3hOengrV3hHcVFlT2pGclUwK2F2ZE56MVdz?=
 =?utf-8?B?S3NNc3hOaGFiOExTaVp0T1FQcVBpQWZIWVd6R2J6VXR2aDF0Z0J0ZFh5eTk5?=
 =?utf-8?B?MGZ4c0JjRk9GWkJnNGdhalRDaUpUZXdsRlFhbWphM1VlVm5NTzFGamVLeENz?=
 =?utf-8?B?VHcyUzBaNG1XeUtaVTE4TDd2SG56SVI5S3pZdkhldmgrUWtqTGVOZGdIVGdU?=
 =?utf-8?B?UFBkRHdpWFVadmhOTjdhSE9NQTYyVXBESEFwdWVmY2VNcDFncEZvalJiUXN2?=
 =?utf-8?B?enV6c1ROQTg3VDViak11RXBjZTV1N2RzUVExenlRYkZxc2pLRXVseFhROGFh?=
 =?utf-8?B?R1owdXFsZDlkSWJVZ0N6YXFPRUJIZ3IwQzNlcXoyUnBHYVI3a250RFIwd1BU?=
 =?utf-8?B?dWFFdDAyTmdseUovNmlQcUJaTkx2bVUzaHJpekdrVFpwTE1UU2J3bW5nTmVt?=
 =?utf-8?B?WmlzdmVIVG9MQkh6UHFPOEYvbVQyMmh0QVQwTENqbUJyUWVpZmErNGJ4Nmlv?=
 =?utf-8?B?WjZjUkl6Y256bTlUTzE2bnJJSVE2OUg3Ukd0aFljUmlmVURnY1B4S3lCTDRv?=
 =?utf-8?B?aHlLSjF6NUJaRzRIckhzS2pzZTl2cCs5a21QaDIyaUpGRkhqNnNkTk1mcFk5?=
 =?utf-8?B?WU5rVVBBNWxqc0VBcjB3UVpNVGhsZVQreFFwZTh0eG1lUXlCVEYrdVRwNk8w?=
 =?utf-8?B?cFE4eU01aVV5VGlGeVcyM3Q5dFk1Rk5qcnZsa0JIUmFEaFBwYkJRaFIzUElM?=
 =?utf-8?B?K3o0dHN5REV4Nm5ZR2RNd1dEY3BWS3hDU0hta2VMQjdES1I0L2JObk1yWUg4?=
 =?utf-8?B?ZkUwZkNHa20weFdPT1RXOEVLSHJjbFFCMkpXMGZrWERhN3loM1VGeDZZYTRt?=
 =?utf-8?B?N0p2TVlOaGF1Y3ZHWXVad0NOeE5kQmZTTU5JYjdKR0ozSXA4YWYzL1Z3Rmg5?=
 =?utf-8?B?V1BxY1hHUGw2eElPRmlpU0UySk1Vc20rd3VNWkQ3VnhheUZ0OUR0Ui9oV3BS?=
 =?utf-8?B?czJDU0dRU05VeUVrekZDUUliWE8veHpEcUVkRlFCZURKYlo5VjNUdDNjQ044?=
 =?utf-8?B?dC8rS2l2c1pVblIyRG5DUlExbURkcUpHRFhaa2RNN2FGc2dFdGVaV25SZkYv?=
 =?utf-8?B?WkIvZDV4SzViMWhFb2Z3eFZuM0ltSDhDZmd1cGFiYnVEY1A4YVJPQ0xIbGZ0?=
 =?utf-8?B?WnI2SFZScTJsMThDZUlKd2NuWnozc2lUeW9PZ3VibnZhTzZ6RUtYM25tNzM3?=
 =?utf-8?B?YzlVYVN0cWdkNjY1K3NPUXkyZThBSXdremNWL3Via0dpeHI0VjQrSUVTdkZX?=
 =?utf-8?Q?SePuva6gPSwxLn5u51a39yJKE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2145AE6549DAAA4984C0ECF3D8E7AC9B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb3d323-ef61-4813-0b13-08dcb636b129
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 16:41:59.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yNNH42Kg5C7DsNmoHBh3FOIxztPpMtCAnYnSZEeeqg2a9Y7XecVPQ3JDF8XWSORSXtU+OJ1gq6a1IDCqE/FPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6260
X-Proofpoint-ORIG-GUID: AUDZXlLFNRH1NkFS7A4xLCj4rn-KMdW5
X-Proofpoint-GUID: AUDZXlLFNRH1NkFS7A4xLCj4rn-KMdW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_13,2024-08-06_01,2024-05-17_01

VGhhbmtzIFF1LCBJJ2xsIGhhdmUgYSBsb29rIGF0IHRoZW0uDQoNCk1hcmsNCg0KT24gNS84LzI0
IDAxOjQ2LCBRdSBXZW5ydW8gd3JvdGU6DQo+IFNpbmNlIHlvdSdyZSByZXZpdmluZyB0aGUgY2xl
YW51cHMsIHlvdSBtYXkgYWxzbyB3YW50IHRvIG1vdmUgc29tZQ0KPiBidHJmcy1wcm9ncycgaW9j
dGwgcmVsYXRlZCBmdW5jdGlvbnMgdG8gbGliYnRyZnN1dGlscy4NCj4gDQo+IE9uZSBleGFtcGxl
IGlzIGJ0cmZzX2xvb2t1cF91dWlkX3N1YnZvbF9pdGVtKCkgYW5kDQo+IGJ0cmZzX2xvb2t1cF91
dWlkX3JlY2VpdmVkX3N1YnZvbF9pdGVtKCkuDQo+IA0KPiBXaXRoIHRoZW0gbW92ZWQgdG8gbGli
YnRyZnN1dGlscywgd2UgY2FuIG1hcmsNCj4ga2VybmVsLXNoYXJlZC91dWlkLXRyZWUuW2NoXSBh
cyBmdWxseSBjcm9zcy1wb3J0ZWQgZnJvbSBrZXJuZWwuDQoNCg==

