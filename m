Return-Path: <linux-btrfs+bounces-20500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFAD1E551
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3D63021FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31D38E5F1;
	Wed, 14 Jan 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IkYHErLu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wl7CQmX+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F091E98E6
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389179; cv=fail; b=Wz/CrHZRTkNJj/xA6dNmeBQDOa/tQ7z9lvJnKpGmoWCbKLANodPa+LaCujkYfY3L4q/j3LGnKy2AkEgv7zBPZedJTErWJcIvdj8jPY5uqTnnm1bpQwpdwRmLMBTgNyVVog8bc1HbNhSXCu1Rog64N+iN162TCCrNcChHB5TbKaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389179; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1lWFR80rouFFiRjODWFwENc4An9a8fq4KsRj+TZaK0SLcO1j1HpmWO7pReQQ8yn5PvZTHqkeuqKAESQVb27tEbQqCGGaNgaHxfjsgIkhccG8g8T6rdBdAaXAmEj4MKzujwhciQQ0DVa/4bstQF1CUqfkgWuHQm9x/tlp80wk7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IkYHErLu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wl7CQmX+; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768389178; x=1799925178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=IkYHErLu4uZlBQWn5230dIIAIRq/65+S9hWp+yz1hlErvo6LxIcat39V
   V1D6PW8cxSZlDp/QJoi+PB7Vig0TzYFBkIat75mZrHQykPvT3So1AFfAn
   0GLYZITEphA+pxR7saZH8M/AflfSB+F+hrZS1o+2ZY+jboThlNXfc/hxY
   0wdzM86uIeMQMYwiGzH5za2o4IHpJTXHLSQEyMBzMPvr2R3V47KW4qx7O
   YkNjb4OYQvOLnNy/NZANrjzChpnmccuUqZj2rq2fz1EmaIjBfXKxskMIZ
   F+Qq3c2yomEmTdEjud9MbWXd/Z4kWLflObdXeeEtDygjTSKWkasU6ahcM
   A==;
X-CSE-ConnectionGUID: HbSkLHEURd69CT7FWFkoFA==
X-CSE-MsgGUID: mkHX+bLRRxuNERM+mt0eEA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="135410695"
Received: from mail-westusazon11012064.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 19:11:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6y06ehJDXm1+glL8dZklX+wyRUbxQfRmujxqaD3a9pe5hgmTMGZVkn5Yy7/0QT82+bXV8cCsTp0r0xPlU4JF8onVgRxoP/xLqFsGhvedZ5wPBpV2/K4kN/l48Y+B4AmwKcWY2TqEBa44JMu/Mm0MLO9UPrLjy2Cy2sLB5T3qBiyURPfqGO/iWY1c1G2a0eJKOENOqh81XDI22uycV+IuNM9dH11nRP7dI73/8/zKNbvvoFLXedZt0IEQ4StodGSGsm3FskI/8NP7SpY/6cbh0EllC7qPdm9x/+rx0o3damruabfnpAQegLpS6wL/XHQijhk0nPs9QmiqVk/qtF3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=q9QrRWKGxWQMNMBjj1EAW7h5IKapFEVghIys8TFbQUt5Z8z/e0XlvCT7skhV0zllbhajrjWphd0KbZuS4gzfwJQdv7qZmF5EZw1o0qb7afgbmFeTBR631FBl+z/8x+pot9qrdDBV311VOcJDjXD9ISrsxSOGCd3TinC3UW3Xq02eFg0ovgO4Iq63s/hpCm8T9nyS6fSTpbn1p76DiFAdRBurzkQvAJm2Qz9nIZm5n2kUy1a/U96Sg2LJ1OHli8UXBJ9qafuOf4vIrBXz6XQN45s/hX5p1T0+nRomlwldoEvJAL2pCHIvZxlWOSRPQUYQcZECf4Sm3qks36OcPcGcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=wl7CQmX+h59L8YPwcma4QiC4z5qp5v/1D2oy6iFO3G9unK6WgVAVMgrSOyCEjNAQaWVVWgjtWGfIwsOZYHfE2UPVGgluY3nVK56FIM74+MxApLVDe7Ucdung46kcBbVYsN/1fwUQ0Saz/RQKf6wOc45OutdYXDCkiWq0k5tWOc4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9493.namprd04.prod.outlook.com (2603:10b6:806:444::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 11:11:47 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 11:11:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Jiaming Zhang <r772577952@gmail.com>
Subject: Re: [PATCH] btrfs: reject new transactions if the fs is fully
 read-only
Thread-Topic: [PATCH] btrfs: reject new transactions if the fs is fully
 read-only
Thread-Index: AQHchM9vglihMdC+c0KW9LhGJCbSxLVRg4aA
Date: Wed, 14 Jan 2026 11:11:47 +0000
Message-ID: <2a371589-f12e-4638-8ce0-c264bfab403b@wdc.com>
References:
 <f0a259857d106f82ea377b49a85bc422fff001fc.1768337256.git.wqu@suse.com>
In-Reply-To:
 <f0a259857d106f82ea377b49a85bc422fff001fc.1768337256.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9493:EE_
x-ms-office365-filtering-correlation-id: 147f2c9c-e2be-4621-3aa7-08de535db576
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWhoaExrbGlWbWZmVHVUS2VXMUF6aTdoemQwaG5YRTBvUDBLaVBTbWVUVGth?=
 =?utf-8?B?eldNUTYwMHQ0dm9lTks0QW9zQmVwYkt0enVzQ0JXRVlOZWVKSjgwdUppTklB?=
 =?utf-8?B?ZDIxWElPc1BESFlTSk5mZVM3RjEra3BMSXdvSDdET3BFZnNQSFdxSTJQeWda?=
 =?utf-8?B?VUpaM25IUyt1Qmk5ZTQzN01QM3U2Mm4zdzI3R0cwa3VreWxBTHhWNDg3NStq?=
 =?utf-8?B?UnZpL0QyUm1rWnIzZ2RPSnAzcEZuclpQdkxIYytJcGhuSHpiek5lRDNmU1E5?=
 =?utf-8?B?RS8wL1pmQzBKZEZncFlpUVJzaElpR1A4Z0hLZWpCNGFHaFRGS2hYMFdwNytD?=
 =?utf-8?B?MkczL0JreFRaalJqNVZ5STFHZ1RwWGlXTU1YaVJCMVJmK1V4ZXFVbFUxTmN3?=
 =?utf-8?B?TjdsbE9RbEtWZlR1WEx5ak9oVEJ5aDI3VDkvODhzU1FBTkl6NFgyTXA4WUdi?=
 =?utf-8?B?NUkwbWgxQzVCdEdwRnBxYTgySkdlcVZPZTN3d3Y4LzFCOUhtRGRod0FSN2RF?=
 =?utf-8?B?N3BwNEZBa3Y3cUZSYVZGNW4wdk9zeXhFdGhOZWhqU3lzeTZ0UWRhcDBUVkky?=
 =?utf-8?B?dGZhWi8wTUIrUlNPMEM1TFFZTnIyNE5uWE9tRlBqTEwzdU9wUHVvQ0J3R3d6?=
 =?utf-8?B?a0dXeUhHb1NYa2d1YTdtWllRenhxZUFlaXZxVTQ4Qk5uZTUrRmFXbWRaWlp5?=
 =?utf-8?B?ZUtoVUIyNURQZlBIQWxqeUw3a051dlhFNmlXNnZLT2pxSXY0SkdqU2FDUVpk?=
 =?utf-8?B?bzBONW1lVEpHV2lPdkpIdGg2ZytNd0RvMTZUSFNEeVVHNHV4OFlhdkRDdE5O?=
 =?utf-8?B?NEdmam43UlRJQUpGNmd2Rm85amo0OWVkODdkWjNBdTlvY2lENGNsSFVqdEJH?=
 =?utf-8?B?SUxTeE5PcUQycWwyVU9PVk8zc0RhZUVlczc3T3NkY2Z3RDJPT01nT1pGWUxF?=
 =?utf-8?B?dldHRWRkRWsvTXlyNVFHY25PYUR6c2NGSTNCaDgvemdxQ2hRTWZxc0hGTWNQ?=
 =?utf-8?B?WUIvb0tWdXFRSkY1TmVmaG1FbStKTGdyWU9HSzFCRm1jYy9kcmxXK3J0WUpu?=
 =?utf-8?B?dnQ0MWZDS0EzYmRXbHlnREJoUDNtOHE5K1VlSC9PUE83TXZGOXM3WkRpb2Ra?=
 =?utf-8?B?YXFnQnRmTURQaXlvSExXRTlKWFAycmdGSTIxS2RkNnpTVmVnSm0xR3RNNk9T?=
 =?utf-8?B?elBWb3p4YWw3Q0ZtT04wL2s2VnpVTFZXZnNISlBTK25hUm9YcDlNdVBHbktI?=
 =?utf-8?B?eG9GVHBYSHU3OXRQVDY2NENza2J2QUpNcmtaN2hFTkN2Wkpob3EzeTRvZnRu?=
 =?utf-8?B?ejBEeDNkMWNEVmVKSDZUZUtPVHpMSVc3NGhBRHpYckpLUWY3VWRJdVZlRHQw?=
 =?utf-8?B?bWhjRkdzTFl0R2dQQXJLdWRQZkN1Ym9ENzJDVUZkYWdNUUFCVWVpT1ljbjZF?=
 =?utf-8?B?MXBJK0pNbnRMRk1ORzZ1bE5VTVI4amp5V29sVWtkZkpJekpXQlBuY3dlbGg0?=
 =?utf-8?B?ZElaQ2lHTk84MTA0OHVRcW1rOUtXSjE1bmhxNVZYbGQvS0JoOHRCTnhtTExP?=
 =?utf-8?B?aUpraGdPTlVwMjdQMGxIVWlDUGFobkEwNzMxNmg4bXRXTmk5SnJqWDFqZ0N3?=
 =?utf-8?B?YzI2ektiMWllbUdDZnV2QXFEM1hXbnFzNlg2VUpLVURuUUY5Smx1RTQ1Y05N?=
 =?utf-8?B?cEt5R0Q2L0h2U1RGdXNFV0t2cEJ6dzE3QThyM1o4cVFXSjJyNEtNcUtJWmpt?=
 =?utf-8?B?SlY0L21wZ3BTczBWVGY0aEVZNG11SjJCUTVaK29pbHpYbUVyZlFVTy9sSGZj?=
 =?utf-8?B?bUN4WU5vME9XNi9RbXhwWDh3UWNyNERweCttVm12dnRhc2l4MGFsQTlBUlo1?=
 =?utf-8?B?TzFOb0MyZVYwY1lpcDBCYmFyQXJuQlVxSmFDMzdBYUNGYi9QVVdack9DK2Vn?=
 =?utf-8?B?V3JXaDB3aWRmQzVtdklSdUtPemJncW5mdVFPODltMnBEMUxwekJiZzVhczJw?=
 =?utf-8?B?M1JQNWdHdjJOcjZPVzI1L1RYeWM4RDJOSEFEcGZyaithOHVpdWdHcC81ckR0?=
 =?utf-8?B?V3hHWVNoNzlKWWFWNElyS1VnNEZ2TmtSY1B6WkpYekFNemlyNC8wallMMkRm?=
 =?utf-8?B?RDBPUTdSZHZXbXZwT3hIZWU2MmtaaHZVR0NySWF0WkRwRVlqMkZ6b3VOaWU0?=
 =?utf-8?Q?ifwFssQCtunMqW6VgjefstQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHlYWFR6bjMvczdJQTA1NUYxOVRTRlM3TTlwRzBPQmcxcFMwUmVmT0Y2bis0?=
 =?utf-8?B?TTZZZUFYaVJXSHNBd0hFbENSZTY2NEpZMEdyVlFrcjRrWkFpZ3ZBem5LUGRG?=
 =?utf-8?B?VlJ4aExHNDNaM1FuNlJrbDFRa21DREJWcjJMRXBZWE5QUjI5NzB6M3U0RTh3?=
 =?utf-8?B?SFRTWk5GcVhtSlI1bGZqTk1DaXViYVhQUDlUemFZeWowb0pvZlQ3TitOdTkw?=
 =?utf-8?B?TEh2c2hXOFNOVVB3SnorSmtPampFcEw3QUd5L3hwTWY5M0R4Mit1VitFbFNp?=
 =?utf-8?B?dlo0UEJHTjVSZWpyYThTdU5IRzJjTC8yK2UrcytpTmV2SktUdElEWHozQ3Q1?=
 =?utf-8?B?M2JtaG4yMEpza2xJNzZsTExVTVEvVEtzYmZTYUFrRGJmMmxtc0g1NGdlQ1Qw?=
 =?utf-8?B?YWVWNGZoYnAvU3ZqNCs3VDU3Rk5sV2RGR21sbVZ1TFNmcG54aFdSYm8vQmdq?=
 =?utf-8?B?VlZIYVhWbGdqaVd5N0I1azlCU1hDVnRoMGtZRmEvbHdOeHRQTHVpemNEcmtS?=
 =?utf-8?B?ckx5U0M3T1VUM1ZJdVNsamM0RFhNYXB2S1V2ZzJCdEJLZVY2eHRlcy9qSFlF?=
 =?utf-8?B?NzdhLzdIdCtNK0JpZG0rZVFocnBCc1RUWHdhWmJHTjJaZDk1REhVZlUvM0Vn?=
 =?utf-8?B?YWZOWFQxYXloaUJ2YUFWTktWb3E2ZjcwSXpuUHhPRTRNdTU3SmxGWXZMU2l4?=
 =?utf-8?B?S1J6N3VGR2cvTmZYbklvQmFlQzRWNlBMY0RQM1JocGluWnQ1VDhpZnlOMW05?=
 =?utf-8?B?dWhkd1hJaGtLYVNHM2cyWXkxR0xKak1wdjNBMWNGVWgrelFaS3AvaDlxS2Nj?=
 =?utf-8?B?cjBuVzZjNGlLR1RuckE0RUVqOUFjT0tzSDJWU3daS0pkM3NHTno1OGJQSnRL?=
 =?utf-8?B?TU4zT2h3S1pQM0VrclFLc1l5NTRhbTIvSmpyMncxMmduU29LTkRxSGlkSW1u?=
 =?utf-8?B?eG1qTEJQWlRjOHplSnpWS01mWEFtbnVYS3J4K3ZLRUZKTENLUmhMVzRSd3dq?=
 =?utf-8?B?anBXUUpMN3ZoTHprWXhLeC9qN2p1VFR1VkZYK0V5YVdGblRrcFp4RTNUdUE0?=
 =?utf-8?B?SHhiTm9HbTdLQkkvNk1Jem1MNHlvWm1YZ3FLNVQ4bytNNDdCSFJoemhTMlFS?=
 =?utf-8?B?VTZzckZ2d0IrbHRrV0dNUENFSXZ4UWphSStYL0J4WG1NVlRJTndqZms5aTdB?=
 =?utf-8?B?Tk56ZURkZzNyR0VrZ3JwRUxpWnlqYzZ2V0tIM3htNVI1ZHpnYUMrQktsSnNQ?=
 =?utf-8?B?Ulk4WEdMYUIzRllFU0QrQXcyMVIwNnQ3RmV0SkNjK2tWKzBqQkljQjdtZ0ts?=
 =?utf-8?B?NTM5VmtvY0RtZWYxTGEvOHhickdNSVBWZHA5dUY3Y1piZEU4dlR6bVRDVWtP?=
 =?utf-8?B?a0JwSVBSZzJTWGx5RmNJSTBjUnpYT1ZGY1J4Y3R1MDQvZ053a0REbUVIclJh?=
 =?utf-8?B?blFmNHhWQkZESHRmUVQrQUU5aTZSYVNyZ2VyZWJVWnhkSEVDWEl2RjEzS0dh?=
 =?utf-8?B?aFVXOWp1YTdrbk55UkxSQ0dQZ2pjRVJ6bWYxdE9jdFFwSGNOY2hoK0Y0d2Jn?=
 =?utf-8?B?bFlBeTQ3MXNWSzNuQWhkcUhZZlpHa21pUmJER0puRG9iU1lZRER3WGNjV3g5?=
 =?utf-8?B?S293UjMxSzhRWTFVY2hUS0M1bU9PbTdPQ2xYMnR3b1dYMFR0bk9BejEwZU9o?=
 =?utf-8?B?UkVhS1BvUWV6ZDhncUcyUy9tMm8zVVNseWpLaUs5L0ExUHNiZTJrWnd3U3dl?=
 =?utf-8?B?REtCM2NaenduSkFBT3pRaXhVM3Joa0J4cElER3RmQklIcFhNWjBrQ3oxMDRG?=
 =?utf-8?B?cnBDSUtuRkFmQnlkRUN3YU1qRjA0Ynl6d0ZjL21ra3JmRXdlTmpYUGEzK1Bp?=
 =?utf-8?B?a1UzeDc0a1oyOFNVN2s1ZElvclU1WTMwS3ViM015YTVwd1dFN3RFRU9UaUw3?=
 =?utf-8?B?M2J3S3MvNXFmaWVlNTk0YlZaQVJZQnB4UlBaeDJSOXZHbzZtMG92Vkh0aHV4?=
 =?utf-8?B?Y3ZMRnV2WXlRZkMvcDBRSEtKcmJ0WVJoeG9HSTQ3VURiWFVXTW9MRXcwdzhC?=
 =?utf-8?B?b0E3ZFFib3dDc0ZTN3VNVE92SDJsa2laZTNvd2RMT1NuTmJveFl4ekErRjlC?=
 =?utf-8?B?YnVNQk1OVUlPWjdqQnZhNkpncE9XTTJaQnZjKzFEVUw2OHZWT1FxaWptQWlw?=
 =?utf-8?B?aXZxZkRyUG5rbzl2Qi83ZmRhbUQwanNOMEkxK21WV2Q4enFWbXpYcFpVT0Fk?=
 =?utf-8?B?blB2VHFmV2NjSGdwR3hFVXc2RnZiRm0xazJPT0ZBQ0YweWhvZFJvOWZZaEFl?=
 =?utf-8?B?VEwxVWNyTTF4NWNEV08wUTk1NkVnOVBVU0JINDR1cnVRcmlOQ2lDS1VRbDB2?=
 =?utf-8?Q?Pe2ahxQNyQUxfPiGw5KKTRq8dYNI7wbSaAjzr1Aoc0amp?=
x-ms-exchange-antispam-messagedata-1: bQAbsWajSYFW8dIVsmks/3vMLZrWJG1/kHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <009547082CB4674C95FBE11056E49F4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nl4BTVRZaZtFcKxAJZeIlczpcwsGiz7/jXwDo54zCLT0K9WYkPaUL7rlpKoEM5X0FS4GZkrNugq87KpbYPwJGNy6hlZ46gmYw43bLOUlZysRcbmvWlCPHa27GYaZTLZySkA8gQpggTrai7csNj+fvSPlwlCBi6d7ucPIOePHdr5WCbUNiGaEf86sMbwWPh06UUheXrpQDPf+2YCIkthHxxk6laXtfZrKjHd61L7X6rO+0VjToS5E0SfjhUkt8W2tv8y2+addUbBnxD3XC4fUGPFlO1q8e8M0t7CEB8mFkMR0sPaDBblSivk3G7t5EtiNOPaaCILoeeKB7RA+/9Xt9PbpQA0UrGJFpn5msBQO6kGXtxgLMl4JliTU20eFNwRJ66gyk/bLKoWDwK6iDzYCy5RymXXQJTP93d+OSBF7eXDwUdiWzjVJ3BDCKIhVvMOJQApRa20XFdvsQ/H++kVx5ayItkBgNvLIiAK1ZR0eq+5wQxBxAc6Asf4takXxqO3+ACoYg7HEjAgVGCKmmhGB4vfIWgAKLdXwV3E9lKDVLln8kkT+/K7n9vVGtZ2FkEWqmJAQAZnb6rp84WgbRziEHaGbHDu9XdOCvlSBymdlEofi8KaIaKuTUy39P35TpKwu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147f2c9c-e2be-4621-3aa7-08de535db576
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 11:11:47.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjGHm6W5tteWE4N/chKZet126pVouxr+tghIw4EMHi3loU+dZqoi77XQtIxStVvZPb3yufb+wv7Uv8O1nl2jXukIiHRw2HNIyd1QpoktJS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9493

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

