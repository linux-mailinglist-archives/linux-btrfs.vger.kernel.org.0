Return-Path: <linux-btrfs+bounces-16742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF2B4A0CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 06:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1EE1B27B0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 04:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE792DCF6D;
	Tue,  9 Sep 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cd0o2R79";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RNIQHMM6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4CEEA6
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392868; cv=fail; b=My2KEFHZ5ReP6ZqY/hicaYsWctOMXVgaZq1C4KZuD+H6pOkVDWMJcQ/FmSNI4a5jSWuHWrsZi7vAmePPBWTTnwkqKUG/j60s9Z0Ajh1LhI26/f9sfIFU2yi+2MlmehmTfaP5v0bO6JshuCvbSLzcyr5OGJ3DJPPW3TRM4r7l7GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392868; c=relaxed/simple;
	bh=Wk3E2ayhVusFAPrQpxg9f+BHKHlnSbYXswYiv7AQKTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQE4nBVG/XVX0C499BxCPLQCOlnwwqKP0AEpF6h0hIK6iOoxlRcFWzOgsmm1NB3g+kWO53tmAYHnbyA7+c6a+Sjo5ZdJ7t7ajprF+/0ZFO6/xZy406ptcGBbiEfJGsd7WFlqYONaIi2OexnBP7btNYjTZVybXmGcZn+lGdsnM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cd0o2R79; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RNIQHMM6; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757392863; x=1788928863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wk3E2ayhVusFAPrQpxg9f+BHKHlnSbYXswYiv7AQKTE=;
  b=cd0o2R79TMAo50lZyGiWPUrYrMYr25MMOrOAJ3HzXFhBApZBbrx3gQz3
   u1u/mPazqo65piok1p1IL0duBZxg2WqQ4w119VbobD1fMCiZY0+rSTquA
   pL+TPoUxpDGZYfUey+XQl7ckCuDioEndCg+Zgbilg0r6pWDo5k6w8ECWe
   rpbBVRmqV5ZWm/sCT0A7aHvGCVC/L/WnaHdgTrvjHP+f04GW9fgid3nz7
   gKgRpxkWKQ+/4MDA5tk+as5Pu88CRA/FyzAySuNPNL7AqSL1eg0e+LY9k
   WgsUcpl1/Mki0z0oVY+dK/80+DZrFzcDQ8d9a5ROsQL1yavFKu9ifK9I5
   g==;
X-CSE-ConnectionGUID: YhfGxtPVS8qMcKy8co5Cjg==
X-CSE-MsgGUID: ll4hoBKnQiOqXg6ehG6cuA==
X-IronPort-AV: E=Sophos;i="6.18,250,1751212800"; 
   d="scan'208";a="116724891"
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.84])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 12:40:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVLjKwUURvpTFWU8mvf/zFaqQSutvJ5mkgnvvsClaGqQgeS/yNwS5e5YuUrd84jbSwltXll6LN3mhhegClputX47Dx9an9bLrpwcaAV14Ae+wTky/5Gerg9vKXob0Gjn0+2Y36kr3/a1FZvTaEYHVB6WhEc6ApgKvDlF/GHMU7nZES4+y7iYY3mgZqTVCNc+li5+JU3tpM4LdAu7vhlnSKFKM+RDuLjcXZhIl2WOPCcjCl11cE+PfDQepW16lqYGP+wY5mfSfufHeZEe8CpzVNjnrOl+lmfTLiFS9r53v1UbfolPMmsmSynmFH8KlwcNyn8awoy9cgoxOpA4TLmIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk3E2ayhVusFAPrQpxg9f+BHKHlnSbYXswYiv7AQKTE=;
 b=RQnxEHKUeuuo52i4pXnwBvz8q8r6w1xIdbpVk9Qlv+8EAn3OuEjgUUUUc98YDiBndVOIETB9J27y78fQAPyB7jKdtkfAQL/9BYUML2v8HvM9PCAHCerp/6SIDKD83N4t3AG/kutW9L4MjO3UD6zXHt0lhnCWt1js+7tRUE3H9C9yVxqis7b26V3BA91fB6ytwSa47QnC1Q9srFBmL5p7jTK49FEyYJZNJzhOhOtGdpSwJliOAcor95ZKWn5HRrFksNUemvTkjAmbxq6WPghMB5mSNjPRJ9o5ReXRvTGb5iyqAtBfIGM+G6tttgHsMovqOzkp09RjrkMyfCtToGtlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk3E2ayhVusFAPrQpxg9f+BHKHlnSbYXswYiv7AQKTE=;
 b=RNIQHMM6A7/HQtp+tyyVi5PZ5DdeTFFdfbYKFbvpKm6kSsoMUNvmi0252OnJxCYzS6AtFBQ+psQLlhU1oyDtJ8TSA9V3QnbyJZ66mboJ6VEv5xG1j4+5Rr2xlID0MjjUdYpqk1+1fOIqfBv4+4GyMEaSx5sc7ucECFcWsmITYlA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6742.namprd04.prod.outlook.com (2603:10b6:610:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 04:40:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 04:40:54 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: David Sterba <dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] btrfs: zoned: fix incorrect ASSERT in
 btrfs_zoned_reserve_data_reloc_bg
Thread-Topic: [PATCH] btrfs: zoned: fix incorrect ASSERT in
 btrfs_zoned_reserve_data_reloc_bg
Thread-Index: AQHcHmyroA0PVDI+D06ZHOKnlaTeTbSKSu+A
Date: Tue, 9 Sep 2025 04:40:54 +0000
Message-ID: <DCNZROY8CV6U.2WZ7G51K4JTRN@wdc.com>
References: <20250905135443.188488-1-jth@kernel.org>
In-Reply-To: <20250905135443.188488-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6742:EE_
x-ms-office365-filtering-correlation-id: 7488bebe-15c2-4a8b-bd43-08ddef5b1034
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUNjV2lURjBva0JraXppUE0yMkJybVA2aUxDU3lpSWdPaGI1SjNIWjNOYUZx?=
 =?utf-8?B?U2IzTlZWUXRuTmtvREw1UDZXQTlMQm5PWFV5OTAvTi9BS1hQY3dnc0dJRHdK?=
 =?utf-8?B?WUNtNlZiOERYRGxwN21GNTB2MkhSbmN3SGFRZm1vbkN1Zmw1bUVWaW1KMm9U?=
 =?utf-8?B?cklqV0xET1pGRWNTZWpRQmFSRlUvMjZ2L1JySmF2NC9Kelk3UzFVNTJwUVM2?=
 =?utf-8?B?SzlxOVRpdW85bTRUT3FMZUJKbXJYY2hlNkZYSWZJOW5jcGhXL0ZTRVZYTGpE?=
 =?utf-8?B?K3Zwd1A3VFNGUyttSCtVSW03bXQxSlN1S0JDU05tYkgyQys0ajkrdEJqSnNy?=
 =?utf-8?B?MVA2T2s2a3RyWTREYnZoSHBFUERhamtDK2NmRVVlemd0MEtqeWpQN3pZSDQw?=
 =?utf-8?B?Slhmb1lIcHlJQjJoaFhoTmFDd2dQNWdMOGFXTElNWEgxQ0dramdkc2xJaEw3?=
 =?utf-8?B?UTZqbys4bE81U1VZbUU1aW9rQjVjMXgzVXBaNjdOb3RWL3NwK2MvYjZ5SDRQ?=
 =?utf-8?B?RG10cTJWcHl5OGlKOUZpRm9OSDZnT1NzOEJqaU8yZTh3YTNVcVJOYkU5MmlS?=
 =?utf-8?B?OXIvT2dsSzRNMEZYUE1LMi8rWVo1VnplZnVLMVlkd2JKNjl0dXdabjNyWWFV?=
 =?utf-8?B?S2pCdFdReTVMTy9RQTNEMlRKSDFaK3h2YzVvYTRnVUZ5M0pmbzFRcUorUWNj?=
 =?utf-8?B?Q2hINHFTNlNYSzNRYjRreW9YSWNpam1pWFlxMisxKzlkRll3ZUVRTDROU0ph?=
 =?utf-8?B?eUhraDhMZldtb1h5RHIyV3B1aldwVCtFNFdKckYzVDlHRVh5Z1FHU1QvQUhh?=
 =?utf-8?B?U1hxWFV4MlY0ZEdlUDJBMnRJblhSNk1GTFhudGtuSzhNVmdjdXhwZmdLUU1B?=
 =?utf-8?B?TlJQVjNOS1VPSVM1TE8xUjBFK2EzZFUzZjUzRHpERVl5cU5ENStaRytFZHdw?=
 =?utf-8?B?dVduaUhCcXlpcDJsTHMxMzVFTFJ1K21ic2kyZm8vL2lwT0NHLzBEMVJYVU9G?=
 =?utf-8?B?ZUZHVkg3VWhRSmx4ZXdpMzV1MVlRUXNqOUhOVzNiQ05TKzBmZG9hcnQvdVVn?=
 =?utf-8?B?WlVtb1RkSUt0MnJDL1FvMkFqMlVRUTRzemNsQldiSnBqNUZZQUlyYlB4YUln?=
 =?utf-8?B?L243N1NrWG16UFRxVXNjZmhKMVh2L3F4YTZiTXVHc1JuSXJPQmo4VlNITEpW?=
 =?utf-8?B?bFdjWGRuNjZOb0g2aUEwN29zQkJrSDQ0VXY3MnZDZEh4QjBIaGl1dWozYVVO?=
 =?utf-8?B?NVFjaUpNSTQ5bzE1UndTaVdSY0VSZ2x3T1pFVkFKQVlJYy9zUEpSTGs0WDVL?=
 =?utf-8?B?ZWxPaDB6NFBBT0FKMkxTOHdLMFJiOUF5RGFtYmw5Yy9sTHhZRC9NV0dqQkFX?=
 =?utf-8?B?SXZpYXZUQUVNUmVuNDBxT2ZpbThQbFl0QldTY2J3cVN5ZWxJUTlaSnpIcGYw?=
 =?utf-8?B?b3oxc1V1bk1TODFSbTU1YzJHbHJBOGtFNWt5TzNsNHphdVV6aFIzMW80TGR5?=
 =?utf-8?B?cW1NWFFhelA0bGNiRHpFdXhMYitNVzZVblRncTJ3ZzBkQUFobUg0TkxyNk8r?=
 =?utf-8?B?enR6b2pHQzFJUy9uT1lrRk5zRXFaQTBtS1A2NjMxWis2Y1RJZzZSNFdsN1la?=
 =?utf-8?B?enI4SW96UjVGTnhHK2kram9Cd1NRMFJUclF6dTVYSGJ4a1doMEljOFB5V0E4?=
 =?utf-8?B?U0NnU1Bac3FteVdCQlU5akJjVmI5UjRyemdkWUlkQmNCNmhKRFNjSDM2Nk5B?=
 =?utf-8?B?dzJFRm1GZk5oeVkvcWFrOElXYmZlL1FUSE0xNURQd1MrbXpZcFlDdkQ1Q0Qy?=
 =?utf-8?B?TVAyL0I3ZGtpZ1NraG5TV2hqS2s3ejVVbUVhUnNJZG45WVROQW9LWDBaT080?=
 =?utf-8?B?MW11M3JUc21VcmRtWVpJdXhSWXhDVjhUUXpSMFN1N3NvbytSUWJ1clc4dm1Z?=
 =?utf-8?B?MjZBNklXYWZVWVpCVXdvUFJIOHVPUUx4c3phNVBQWUJ5ak83WDZtSGhQbVVX?=
 =?utf-8?Q?7P3GkKdq0MkP/t0EDHcgei4O/LCU0Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NitOL3J6c3VmRE5mc3ZkcHpjMGxna1lIOHRKKzJyUGtmeDh5eE1Rb2x2RHdI?=
 =?utf-8?B?Q2tPd1BzZWFXdWdxSFVwMFBmNFZVdVIrY3p1TWU4M0p6cUIrMmJESHlvOFNH?=
 =?utf-8?B?dVNNSlJaUHFXK3d3OHdHOWVMU3EzZGRDdnFyQ25wNmFSZE43U09malM3RWFt?=
 =?utf-8?B?SmNyclUrMnVZYTBGb2RudDdqdUFyY09ZNk4zSjlubFBaZWNPdlVIaW5WNXhS?=
 =?utf-8?B?MDBmVmZoaG9jV3BUQy9XcFppT1lEZ0ViRVh3SVFIN2h3ODZTenhBSWdmVEcr?=
 =?utf-8?B?VGRwRkVvY3lvZ01hMWxueGdYWEFjOG1VUm92QW9sUlJsTVFsY29KM1B3QVBj?=
 =?utf-8?B?anFsT3Q0dGpURTd3RUk3UWNHdzhjV3NmTElIK2RhRzVyMVhLR3NhOUg3NUZQ?=
 =?utf-8?B?b1RneUVmZTdBcjYvcmN5NFphbmFVNnFQN2hzYWF5dnhKK01nNUI2dC9COTNi?=
 =?utf-8?B?c203cUdUSFJlMXlUNFpUTkU2V1hJdVh6cnJwbzhNVVNZY2FScUFlR09iMUJy?=
 =?utf-8?B?QkhhbVZyOUlFbnc5N2J0L1RKbmtra1VKZzU1Rkx6d1A3Zk5ZUDZ6VktHOUZC?=
 =?utf-8?B?RnkwWGZ4STVKd1ZMMWdBSFllY0J1RXRIVGt4NTdJK3JOUDlQNXFZWnV0MkRM?=
 =?utf-8?B?VDVNUktwM210ejlkdGloS2FUWVNUSExNa3A5Skh2SG5EWnN2SjNaMjZSeVVM?=
 =?utf-8?B?bXZJT3lnZENlNTByVVR4cUpaV1FWTzF0ZmtrSWxnMm53T3AzQ3Mwb0ptOWtz?=
 =?utf-8?B?aG1QZzNXNUxvc28wUGFwcFVCem1jNU9wTFMyZGxwL2FMQkhnOXBzdmZldi9L?=
 =?utf-8?B?QmQ1am9JelI0SmNKa2ZzbzFRNTh0R2wxR25aTFh6Skx1QjNpLzkzZGc1TXdz?=
 =?utf-8?B?T3pldE4zSWRvL1g5YWw4aXFlZ1JYYU5OckRNa3dXSkVUWG43WXp1UE5KeGtw?=
 =?utf-8?B?YjhTNkJyNzdQS2loVTArS3QyazJMMzhrdDM1WElJdmh0ckZEdENRcWlnMks0?=
 =?utf-8?B?dzBrWStrR1ErMlNNUy9WYlBMYlBwOC91dVd0aiswWDYxN2RzMWJ5K2lOeHEy?=
 =?utf-8?B?dXZtSTZTS244dXYwSEIxaC91MDlJZnAxOGU4N3p2Y0pQRU9RM0UwZ25vNUFL?=
 =?utf-8?B?Rm13a2RjQWtGUGlxMmx3N1luUGVDclFzV0w4ZHBDaGd0MlRpUEpuSWZnTkRs?=
 =?utf-8?B?a0NVdXMyOGJTSE1mQlBtZjNUVHRGZm5TajJCN2RDbE1xSlp4TWVsUWRxNm10?=
 =?utf-8?B?Um92ZjhyV2dDSkN6YW9NSFZ4UVhOWkg2VTIybmZlVG5PWnRJMlR1ejBmdVVC?=
 =?utf-8?B?MFlQcFlEbWQzTzF0MXlHK1ZGMVVJaVR4aHVmdWIwOE5GMEpYTmdLNEpKT2hK?=
 =?utf-8?B?a0RDVy9JUjJROXM3OU5EZ2NoeEltMDMrTlpoTDdMYkIvREhSOWpCRXZaZ24z?=
 =?utf-8?B?U1AvRzJaVFc0bjBSOVl1eU5TdVVkcU4wZkFLbmE2c041YXJRQWp5dXRFbWNr?=
 =?utf-8?B?ZmdLWWl6eUI5Y2UxZUZDeGtBQ0UvQkFndEJkTDJCdW93d2FIQUh6Y3RyeGpD?=
 =?utf-8?B?VVBNaEtnb2M2MGRWVTVrUUN0cHdFVnIrby9qbHZsMkhUZWRGbTV0dy9KeEZv?=
 =?utf-8?B?QmZTQmh2eHV3Tk5hc3RidSs2OGFNZjBmcjVGc1lwdDR6U0V4Ly9VLzU4VFFP?=
 =?utf-8?B?UWpRb3pDbUdRVHlQTEFCMC8xWGtYUnkyN3NXbU1YRklwZ3hGVXB0SW5hRUkr?=
 =?utf-8?B?MS9MQjFFT050TTJucklFOC9IQ2ZuZDlsc3B0RVZwaWtaOHZQdWFsWXczR0o5?=
 =?utf-8?B?NFJRbVdScm8zSWd6QlJTN1lRN2U1Y0RkYlhkYTQ3QjJxQ1pFazlua3VjRVN3?=
 =?utf-8?B?N3lFd05OK3NnY3kvbFI0M25RT3M3NEdFc2R0NFcvOTFXN2pUMSs2SEdJZUwy?=
 =?utf-8?B?WXY0dTJhajFvQnFKbFUrck94K2NVdnduVjlMT21NeG5NcERjYzBTRkFuNkFK?=
 =?utf-8?B?bWltVVBrZVlkK0tOOFpVc3ZaSG9kVGdXa1NORXp2OW41U1NhY25sTisrUXpX?=
 =?utf-8?B?ZmdDZkl1ZkpBOVU4WUp3d05BSGUzY1lDT0p2RlRKSUFxQW9mVDgwL2d3TzFI?=
 =?utf-8?B?TXdGT08xSkdnbTZhK2hsdGZocVZRd2JGRlpVM3BTN1Nna3E0SEQ0bnNCTUVs?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35E9E7198E9C23428F2BEAA05E408384@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8rTevGB3xe7GRy4LMid/92BSrro4EJ2fAZhtMVlHz8LMRy3zZL6PXWdVW4PC60h8Vz+jPknS90GdOgKzud7c/qmIMtqRi81IW1ETXzH6gHy+8rC7b0kiy0gfYS7tinDvZbnTsWKxjWtlP82PsFHoRwwqgsY0Oi4K6ahMrpz1AIQCgPXj9DhnMB9nf7W6tpziE7wVqgnnx33cJtdi0Pvup0Dx8QGyVI8KJdG4Nc54BXScoBA6PEkjfaeQxLljwUKfE0NIIjsnq7baO43UEcuBpJOlkugBtkJq4VehrwaSjx8OP36uN5kr5RQMYb3c1MLPnaXhXHq8YxloYiZJ4vNUj333BorImEtDWimoEE+DnBG8WoHblwGqMRjFzsHEPDvxa7gGgz/4X2Zqv+U1uxx1tWVBawBfJKeF62IrgRUHscsvdfIgQ1DcrNfqsMxa5WYPtQhyXYCWDDgP4wCKJzrj0uiULRnZ2PUWam0nOwKfcNsU/caiPPzzKP/jaiktpEc0KNFq3Fa73yiuN7EdRYUtvcI7r/rYYZUOme0+Lx37O46e2B0ReS0VfUNQGZGZIDiH2hG5FtRm5P8wmTmVnb6vj2WcAkE/WtKk3d4YW3veOBQgH5O6xBwoyuE/R5mWyh33
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7488bebe-15c2-4a8b-bd43-08ddef5b1034
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 04:40:54.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40Lt1KUQOsWWofPmGRaa3b5k0n8EsipkH36cl2qJ+5NeppyX5FjO+aEukY/Uer8wZcdQ2Sh3bm2g0fGv1nft1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6742

T24gRnJpIFNlcCA1LCAyMDI1IGF0IDEwOjU0IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KPg0KPiBXaGVuIG1vdmluZyBhIGJsb2NrLWdyb3VwIHRvIHRoZSBkZWRpY2F0ZWQgZGF0
YSByZWxvY2F0aW9uIHNwYWNlLWluZm8gaW4NCj4gYnRyZnNfem9uZWRfcmVzZXJ2ZV9kYXRhX3Jl
bG9jX2JnKCkgaXQgaXMgQVNTRVJUKCllZCB0aGF0IHRoZSBuZXdseQ0KPiBjcmVhdGVkIGJsb2Nr
LWdyb3VwIGZvciBkYXRhIHJlbG9jYXRpb24gZG9lcyBub3QgY29udGFpbiBhbnkgem9uZV91bnVz
YWJsZQ0KPiBieXRlcy4NCj4NCj4gQnV0IG9uIGRpc2tzIHdpdGggem9uZV9jYXBhY2l0eSA8IHpv
bmVfc2l6ZSwgdGhlIGRpZmZlcmVuY2UgYmV0d2Vlbg0KPiB6b25lX3NpemUgYW5kIHpvbmVfY2Fw
YWNpdHkgaXMgYWNjb3VudGVkIGFzIHpvbmVfdW51c2FibGUuDQo+DQo+IEluc3RlYWQgb2YgQVNT
RVJUKClpbmcgdGhhdCB0aGUgYmxvY2stZ3JvdXAgZG9lcyBub3QgY29udGFpbiBhbnkNCj4gem9u
ZV91bnVzYWJsZSBieXRlcywgcmVtb3ZlIHRoZW0gZnJvbSB0aGUgYmxvY2stZ3JvdXBzIHRvdGFs
IHNpemUuDQo+DQo+IFJlcG9ydGVkLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0LmNvbT4N
Cj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svQ0FIajRjczgtY1My
RSsteFEtZDJCajZ2TUpaK0N3VF9jYmRXQlRqdTRCVjM1THN2RVl3QG1haWwuZ21haWwuY29tLw0K
PiBGaXhlczogZGFhMGZkZTMyMjM1MCAoImJ0cmZzOiB6b25lZDogZml4IGRhdGEgcmVsb2NhdGlv
biBibG9jayBncm91cCByZXNlcnZhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNClJldmlld2VkLWJ5OiBOYW9o
aXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg==

