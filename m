Return-Path: <linux-btrfs+bounces-9575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF89C6A44
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D43281766
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B070812;
	Wed, 13 Nov 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nhh0vIE4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="awwh0tLg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD0189F5F
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485032; cv=fail; b=ZTQE2K7EH7DFqIKvMvtN4CVMVwXFS33VxClwVGlKA3HqZIk9XvS5RZNqPdL+foXIb9Lr/NXcZbRzDdG7QRH/AHXx6QVtd78ei0+fsnLTylhOeDIYA5hFQlwxO2TCLvHIuCIGaBbIRrtbCj3S89SyKFD98uSjn8v7pSEM2xb0hL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485032; c=relaxed/simple;
	bh=Ix7+eMEkqoK9kt987eXgDRDGcvfmEmnvtLPJhqOmdsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EorG1tHCRcsGZ/ar1t351vqyWWV0BdOFknYXhzKMzII7YN9iWmYw8ueTqRCz67d+CtU8KdvuGPWdPCQgP3XO+eIOsGehJICRqH198h6UJ7e6UoPB9/9xzzCpoXG3JKfOMuxhmuzKzGh3l/czLzTmOShNAmRCabfxbFEYdvyDtNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nhh0vIE4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=awwh0tLg; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731485030; x=1763021030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ix7+eMEkqoK9kt987eXgDRDGcvfmEmnvtLPJhqOmdsM=;
  b=nhh0vIE4kROg30RaPp8dDKPe+Un2MY0y30TAiPeuN5UEy20wKJseUy4a
   H5TUdXmBqIHBLXzgaCgqNxlWX1Xbl30kCiXMMkqa88FNWKoxdhkMualh4
   umGRhk9jsbc9Je3gmNmpqE7wrDnZPM1RxVtZLJBO79n9CMIAHlgoe+954
   biVks0Cj5qDTBaGAV4+j0pKr/CPE8/JkzWFvS59dkLrI/Z1ZnMWnMKqeo
   iu3nBQz3pD24uXvOgCCLiaGW00eM71KuhkO+jj6XjstqQ2+trhTdJrSG9
   r/2jmY4e/yjRrciIZLQ3SLfvNdoTRJyznj9vWfXF/AFWuCPqnyGSoKJiH
   Q==;
X-CSE-ConnectionGUID: HwnfR5mdSrSJYIbk/QXTQw==
X-CSE-MsgGUID: MuvFZ+fsTFePbrjovtFYpw==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="31299666"
Received: from mail-southcentralusazlp17012014.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 16:01:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g59Q+AvxZQSHJyiwnQc1po4LkkBPmvCnrFJr6LZSHNFUSrp6KagEtac9xzL02RxcY2E2W8hOAWN1kwyN9SGFoNVsVEFrqUHrMt0wqn+RtSUPg0ERZPU2L1FHQLIgO9q8xsOHZPlrqE6rxbNLbXARUFDiEeyokJstg/PGXcDQpmwhiA+fgPrEule8s7cIsH9pfOtOLWn6hKTExyrtOAfAMj2qXHKXYVFQrdkNQMpp80t9S5NFeyRk5JNK99o35Ozjhh1abqGCa9jqwxNqTtTxiQkJGrWUlatUcLQTUYpV/2ziYEN4PaKAiKH8t//7izWQZISJ/RQIQaIbuDUkOAow5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix7+eMEkqoK9kt987eXgDRDGcvfmEmnvtLPJhqOmdsM=;
 b=sY0OOb0WbOstLzqeMxpN1RQqGKKC49OSbAy7A6VpfuwHTUsUEPz5nnjmZRQIwsUYWBdHNCsWGM853GLEvf/4QJGCBJUCJhxrQI7ux7vM0PYYV7AZsuLS8GgD5CdOqqAOnyKct8YsHrglMhhJ46DPG/A1TbtpF5xauDypSHbgPxlqSzXOfgf2B21CMjL7pTCTm4FzvNErblvrUpkA1qFQCWKaVrLVAd6QDC6bnU+qSjK89ihasCOvOPwoTO26I77EG5Ad9UchbqAYeaw/1xBRnKoa0Knf4pfI+6Fkv9V1mm9VKkj3BFk9+yggB61bNZpfpfj4OIFc47SyQNKlg5q8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix7+eMEkqoK9kt987eXgDRDGcvfmEmnvtLPJhqOmdsM=;
 b=awwh0tLgXnR7CwsCTnUrKINEu9n0VvvFmWPlvyLhPU6SAYZ3BO56nGWFCtz8ahSe+e9gZ7R+4dIWrDo5aFAnk5mQkiSg9qumYXvCzAZHIzOFV4U+ZjMJbVj9PSzWVOvvjCTtZc/BP6R0MCLHlu8gpAT7x7V/uoZtBfK4ClbGiPk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7594.namprd04.prod.outlook.com (2603:10b6:806:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Wed, 13 Nov
 2024 08:01:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:01:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Thread-Topic: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Thread-Index: AQHbNQpRAp1W4o1sVk6E4ozx+dAZ6bK0Hw8AgAC7WYA=
Date: Wed, 13 Nov 2024 08:01:29 +0000
Message-ID: <6527d44b-c046-496b-8a6a-3bfa104d3770@wdc.com>
References: <cover.1731407982.git.jth@kernel.org>
 <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
 <5616e932-fbeb-4c97-8966-6b8b99ec145c@gmx.com>
In-Reply-To: <5616e932-fbeb-4c97-8966-6b8b99ec145c@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7594:EE_
x-ms-office365-filtering-correlation-id: 142108ab-8662-4a82-7aef-08dd03b96184
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3RnZi9Vdng5Nm1ybnN4UHlrODlONG04S0R0dXB2T1pWaW5uYXdPWTRvV1Bj?=
 =?utf-8?B?cUpDRUo1ZEY1aWFURW9oT3JJdlNvTUNWWkRiOE4rQzRpa1EvSlhGYkRndEIy?=
 =?utf-8?B?blVqVW1mejdLWGFueHFWcE85UTQ2R1RaQ1FqMUY4VHVmNWlLeTZmbUsxblNv?=
 =?utf-8?B?ODNhSnlaMWdseENrcXFwVkwwTG1keDRDejlLOEl2bWhtbGNDY21NNEhmWVFN?=
 =?utf-8?B?WGRJUDRiRkt1VzdVSThNNVJpeTdnZHFISzFBQ1pLb0JXL09QcjRaU2phZnpZ?=
 =?utf-8?B?UE5IdnJ4d1M1OWpvb3JkL29Sd1VFSitaZngySXZjREdJeXVzRG9sSDNPL09M?=
 =?utf-8?B?UGVqVjFQT055UUcybTc3cU9nNzNodCt0RjIzN2QrZmhjZVlBUE5yQzdlaGRo?=
 =?utf-8?B?aDJBRXgrMFNmWGoxc1dPMXlXQS80TlRlTHkrZHVRRkQ3WjVpWXJaeDk1SUs0?=
 =?utf-8?B?OU1MYlE4bm9ITzhNam9DQVAzcndTTjJqcE5Gb20rVFhIWGprYU0yUmQvYldG?=
 =?utf-8?B?dlo2WkYxSnFzYUU3TWMwQ040RHZqSkxtdk9nL08vRk5tc3FWRkE3dDcvYVRO?=
 =?utf-8?B?bi9PY3FyZVloUEcyZUNiR2hZbGJHWTFjbFJndlhnQjNkczJoYzJVdk4vYzJ1?=
 =?utf-8?B?elI0SnhCK3NhMWFwZkZ3bERWakFzZ21hcVRJUTg0dkVkeXVreG92dmhzVE1J?=
 =?utf-8?B?THlyQXRHcjZacDhrWEFBdjBlVUNBR1ZyL1J5UXNUM3BxSlYrT29zR0w5bUZh?=
 =?utf-8?B?NmhHc1BKeFFudUVGN1RwV0ZZMFhOYm1tbmk1K2tpemRobU1qY3EvSmovTW9W?=
 =?utf-8?B?VjN2ei8xOE15VFNKQ3Q5bnp2Q0h3Y2pwU21ZMHBlQXd2UDJ0MS9EWnYzd3Yw?=
 =?utf-8?B?TUE5Ti84cCtHelk3dnNMQ3o4VmhjQUs5bzhDL05nN3F3NzRDSWp3SjMraThx?=
 =?utf-8?B?S1pvVyswd09RdzJYRWxORVNNTTdtdk81by9qRHUvdVNOcTVYN25xSi9lQkk5?=
 =?utf-8?B?L0Q0aFFIMlVIMUE3c3c1OVZSOGNjSGREeGlXMStnS0ZrZW9SYUJraVl2amVv?=
 =?utf-8?B?dG43c0hBWTcyK2ZOVVJYTHNWSlJPWUZGZzRNaS9sUnFmQklnakFmNWxXZGU1?=
 =?utf-8?B?eDZRdGhYcEFZZGZEcmNBRTZGNkhlenBYSlpsSnFVM1BJMFpsVWVNZWloVWow?=
 =?utf-8?B?NU9rUDM4MFBIc0lkdFBJSEo1SkNFWUN4TExUMm5UcHZtbnpjNE01YVY3TUt0?=
 =?utf-8?B?bm1Ea0JEV2RzcndVT1F3NFd1cExsaHcwMXh0S1pjcjNRaXQvMU1oTXN0a2Vu?=
 =?utf-8?B?MTdUSGg4bENGMlJOeWxVaVVGakdEM2gyS2ZFdWdydFFLWEhNSXlxcTJRWmIx?=
 =?utf-8?B?OE5JSUZQWjVBRlBGTzJzeTJjeUk0TzlpaFFBWWkxWU5HM3M5Qjd0cGxWdzk5?=
 =?utf-8?B?dkFZeFI4c056T1QwNkQrNCtiS3B1ajg1Y1FYWSs1d29NWWJFV1BXYVdCMXAy?=
 =?utf-8?B?ckRJSEdwc0MwbUxLajd2Q3AzWXdmVnQ4UkZmZi9GYjIxcWw3MEJjNGszVUVS?=
 =?utf-8?B?MVJBVXdoQVVvNjlwQXZ1OW1sRGlSSW8xY09pT3RqaEI3eGp4aG9ocFZxZUc3?=
 =?utf-8?B?YlBKaTV5TG00VXFFRTE2RnFmdXpkaVlYTWtBblYzM2xaQ29VbUpTejFpU2p6?=
 =?utf-8?B?MEliRlEydDJyT3F1d1kvU04yQnNaSzZxenhyclRrQll4NTZIZDBMUjNha0Z2?=
 =?utf-8?B?dmd0djVIVFhOTUY5YnlPeVZwSUp3SE9vL0duVTJPZXZmWWl0d2pkMkh3a3ZW?=
 =?utf-8?Q?n49zk9I10/A7Wl6RAcWq78u5bH6+KP5Ap3NVs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFJJclgxWjNYdDZHUjg2bnl5Wm0zSlcxN1FSRHMwTmNvYzU5NXV3Y09naWpD?=
 =?utf-8?B?Y0loY0tlei9JNFZpbzg4SzhkRi9GckhWY2NJdEN3Y2VydFY3OTdNNkVPTGQ2?=
 =?utf-8?B?Z3grRDRQUGoxcFF4aGJVUVRpYVVTd1RreENkaTVpOGFaSU5RRmJaREMzVkRL?=
 =?utf-8?B?bGNocjFIRDlJR3JmeExxNDhNVmV6Y2xDY0xPelB1aDhQb051OWlVQUZ2aGha?=
 =?utf-8?B?a3hlS0FBdmYvdVlybXB5S1hNd25PS2lrN25KazRRM3U4eEtVM3d3RHpUL2U4?=
 =?utf-8?B?NURvQ1hTSWc5ZnZuS2NaMXlSWTNiS3h3Q1Mra3hoUFg0Z3BUYmlDK3dnVlIw?=
 =?utf-8?B?SDFzbm5FT05HanNjYUtDMWRSWDlhU3grS2R6M1J0cWZlRVlyam9iWmUrMzNU?=
 =?utf-8?B?anpKSnFqV3RCSXNzQkpUVlRRYjZ3dnBQL0VMRFg1d3lyN1lvV2x3NWgxVk9z?=
 =?utf-8?B?WTQ4QUxOeUVNY1UvUjRZMlA4dk05RVpxcVlpZWx4by9nYm5aVzNOUHd1T1J0?=
 =?utf-8?B?T2F3NWd2bUd4YmVVWlkyditvV1d1dUJob3BuUjJ6NktQZTR1c0FESGNVSmp5?=
 =?utf-8?B?ZmxHaG9YQzZyaGNIY1hCRGJ4SHJxNHJyTkpSMjNiSEZwVnR2Q2Jlb1E0enhm?=
 =?utf-8?B?K0x1MTZINGg4WlJSNHZ6Vmxvcm5CSEFNTXB0cGgyUTBieGcwTHhoRURpdk9N?=
 =?utf-8?B?QXZxeWt2dzN0bDQ0OHorY0lFR3dQdWNTTkRxZWZyK3YxSWFJUFAzQW9talF2?=
 =?utf-8?B?dGhDbWJYSzBHUXZyUjhBZUNNMG16WXhtRkVXaU9YR0RiQU5BOVZPMDhVTUZq?=
 =?utf-8?B?R1Ezb1EzNldXSzBqa3RXeGxWdEwyMTRGdHNyNXJiMzVlWUxvMnI3NmpOSWk3?=
 =?utf-8?B?NDVWN0M4ajQzMHBha1ZjMlgwTkZTa3NTU3AzbGNSWlNkQnd1SUJUQi82Nkdu?=
 =?utf-8?B?WWZ1UW9lb2xZVGFEWld1ZmNEdFI4Q1IyN0kxNHRsVHB4VUVZcTJTM0tBMktQ?=
 =?utf-8?B?QmF5RHFncjRCVytLTjByMzJaTjhyOHpXOUJLeUJXdkxjTGtWVjJhNjBsSndo?=
 =?utf-8?B?cXpZR3dTUjNDSTd5TWlQaERsNk9FanBpOWtXbXZVVWt0eXJQQ25rc2hSb3kx?=
 =?utf-8?B?dnRqd3hidFRST0lZaUVHNGlYYUZKUzVuRkFGY3NiK1Uxb2VLUWVwZmluMFZR?=
 =?utf-8?B?NEVKVlZhZFVrOXVYN0hRNStzOWg1c2Nzd1laVjNoaXI0SDlNT3Z3cmZaRDJZ?=
 =?utf-8?B?U2lyWXMwb1NHRnZVcVRaOG1SellNVG1FUitIajVUT25OOFdSVzd0Ky8rK21W?=
 =?utf-8?B?SlUyNFkrdjFzak44L3MxTlVQOW9KUFRlUElGU0tQRVRCdmZvSTB5UkQ3VzZi?=
 =?utf-8?B?YVpvclFvVHB2WDZEcStvL1U0bGlyWjUvK253WjdxbEcydWgrSWpxUFdEcHVR?=
 =?utf-8?B?SE5FMEpXcHhPZ2V1STZrRHJ2Qkh0SmlCanNBR1B5RUt6cTF0Zk5mSFVtUisr?=
 =?utf-8?B?RzJLdEE1WWVzR3pBTGtuOFplWUF0YnNtU1ZiWE1iY2xBdjNCcEJwQndWSDJo?=
 =?utf-8?B?RlBsU3Y2TXpINE4rZ1lCNzNqVGlZeFlKdkp0MmVCbUtxY0dsYTRxOXdOWEdG?=
 =?utf-8?B?UExoTGQvVDNaa0tHdC85QXV6MkJFZVhqb1lLMnU4U3JkT0ViQUlCNjlzR3Ro?=
 =?utf-8?B?UGpERWdhS3p5SHBWWGJJZmIwa1JZTUZSWTVPY0tlQzBvSSs4c1grYmowWFl2?=
 =?utf-8?B?SWRmd1N4U292YU9IQUo5MS9tQzFUZDg5T2xFZFhtd0M4OU10bktKT0VQV1pG?=
 =?utf-8?B?bERhcHBPSWU3VFZadXhZS0hnVEF3V1k0cEY2UlJLTTVTVTUwcFgwbkc3dnk0?=
 =?utf-8?B?S1FwVmxxdzNteWhRWWVZMUN4REl0d1N4cXBMNlNQZDk2VFR1Wk5mTUI1VXov?=
 =?utf-8?B?OUN2K2cxc1N2ckhwWFZTYldDbnlKeFM0Mk5kK1hJTjFmaW9VMkNzSkxYMFVD?=
 =?utf-8?B?elFhYXJmSWM3MU5Nc3E1ZXNINHpNQTZJNzFPNk5lZERqL1ZZTCtZa0NFL0ZC?=
 =?utf-8?B?ams0b09DY2lTVFV5ZTZMQVpwYkxJYzVDS3BNMVBGMHlUSXpVWCtuQVhyMkly?=
 =?utf-8?B?WlRXNFBlTzdIWGVsQmsrN2NGRFZXNGUwUE5JUm1GMXQ4djVLOU5IcXIyQ1o5?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61BDB2F443F91D499395B9F2832D825B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UIDMqZ/Le5SaLnT9vLeZCkkmdbnGQZJm+eGh8xZXgg1tz74PuvCZv1UPccxgEUY+y712n5sis+3YifBVF+refPlt5mKsGz2vIhGX+yb/YVAMg9ndyd9r9lJuBm8ICuz7ekUP3qv2zfw0LYbEzA+yOCh4cQF8UkfZqJ07ULuetipfV8oTkosN93GRcwkaMpL+mxTHU3zr783FvpcFPeRQn9B1nBONtj4oVz1AOpLN+TUP6KSQeCG1AP6ne2UP2YEs0QjgnpNbvBgXcLfdOmSzsYcmH+JAR9HIXwcM9E/jd3mC9xFS5HIkAQ10xrQDDRKqETNUzDVt2A2p63fFNvXIb456Q+hl3iTxhCYZObamQ5w6z3dtPhQsH9zGodf7M03LwTecA8xQpw+kCtsSMIIwjjgkJLQD4rvLZwNfZQ36xvZ7rvtJdpcwLgKpP5sXM0g3cFWUkWNA2Aro4FT7hHXapWkbDAT2jKO4FCubNCf/KQNwuvW+6uD8qzegTQo5kS/tvyf6sKUjLlIk0HFneObqiEsBdNkw7BXgRVJJJIZX7DDJfWJQSdg5SMTw5HhXRMfg4OlAJXA42vw20LmIMA3NEu+hLj2fZYEuhnrze/OPAaSR7vnQ2gyHM7M3sWpbLL7j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142108ab-8662-4a82-7aef-08dd03b96184
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:01:29.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P45xtuO5Zq+9ZVkZozpjT2dLID9zgTrdDXMF7dvCIUWddYGRzJAWYrZ0YUrYaSDpHdrK76RQ8dq0uAE4BH7A/u4XEJpmDr7+sliM7X3okyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594

T24gMTIuMTEuMjQgMjE6NTEsIFF1IFdlbnJ1byB3cm90ZToNCj4+IFRvIGZpeCB0aGlzLCBtb3Zl
IHRoZSBjYWxsIHRvIGJpb19wdXQoKSBiZWZvcmUgdGhlIGF0b21pY190ZXN0IG9wZXJhdGlvbg0K
Pj4gc28gdGhlIHN1Ym1pdHRlciBzaWRlIGluIGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2Zp
bGxfcGFnZXMoKSBpcyBub3QNCj4+IHdva2VuIHVwIGJlZm9yZSB0aGUgYmlvIGlzIGNsZWFuZWQg
dXAuDQo+Pg0KPj4gQWxzbyBjaGFuZ2UgYXRvbWljX2RlY19yZXR1cm4oKSB0byBhdG9taWNfZGVj
X2FuZF90ZXN0KCkgdG8gZml4IHRoZQ0KPj4gY29ycnVwdGlvbiwgYXMgYXRvbWljX2RlY19yZXR1
cm4oKSBpcyBkZWZpbmVkIGFzIHR3byBpbnN0cnVjdGlvbnMgb24NCj4+IHg4Nl82NCwgd2hlcmVh
cyBhdG9taWNfZGVjX2FuZF90ZXN0KCkgaXMgZGVmaW5lZCBhcyBhIHNpbmdsZSBhdG9taWMNCj4+
IG9wZXJhdGlvbi4NCj4gDQo+IFRoaXMgbWVhbnMgd2Ugc2hvdWxkIG5vdCB1dGlsaXplICJhdG9t
aWNfZGVjX3JldHVybigpID09IDAiIGFzIGEgd2F5IHRvDQo+IGRvIHN5bmNocm9uaXphdGlvbi4N
Cg0KQXQgbGVhc3Qgbm90IGZvciByZWZlcmVuY2UgY291bnRpbmcsIGhlbmNlIHJlY291bnRfdCBk
b2Vzbid0IGV2ZW4gaGF2ZSANCmFuIGVxdWl2YWxlbnQuDQoNCj4gQW5kIHVuZm9ydHVuYXRlbHkg
SSdtIGFsc28gc2VlaW5nIG90aGVyIGxvY2F0aW9ucyBzdGlsbCB1dGlsaXppbmcgdGhlDQo+IHNh
bWUgcGF0dGVyIGluc2lkZSBidHJmc19lbmNvZGVkX3JlYWRfcmVndWxhcl9maWxsX3BhZ2VzKCkN
Cj4gDQo+IFNob3VsZG4ndCB3ZSBhbHNvIGZpeCB0aGF0IGNhbGwgc2l0ZSBldmVuIGp1c3QgZm9y
IHRoZSBzYWtlIG9mIGNvbnNpc3RlbmN5Pw0KDQpJIGhhdmUgbm8gaWRlYSwgVEJILiBUaGUgb3Ro
ZXIgdXNlciBvZiBhdG9taWNfZGVjX3JldHVybigpIGluIGJ0cmZzIGlzIA0KaW4gZGVsYXllZC1p
bm9kZS5jOmZpbmlzaF9vbmVfaXRlbSgpOg0KDQogICAgICAgLyogYXRvbWljX2RlY19yZXR1cm4g
aW1wbGllcyBhIGJhcnJpZXIgKi8NCiAgICAgICBpZiAoKGF0b21pY19kZWNfcmV0dXJuKCZkZWxh
eWVkX3Jvb3QtPml0ZW1zKSA8DQogICAgICAgICAgICBCVFJGU19ERUxBWUVEX0JBQ0tHUk9VTkQg
fHwgc2VxICUgQlRSRlNfREVMQVlFRF9CQVRDSCA9PSAwKSkNCiAgICAgICAgICAgICAgIGNvbmRf
d2FrZV91cF9ub21iKCZkZWxheWVkX3Jvb3QtPndhaXQpOw0KDQpBbmQgdGhhdCBvbmUgbG9va3Mg
c2FmZSBpbiBteSBleWVzLg0K

