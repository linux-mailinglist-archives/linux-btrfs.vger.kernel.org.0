Return-Path: <linux-btrfs+bounces-7553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A8960877
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAE1C224A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AE19F49D;
	Tue, 27 Aug 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LFo5DGVB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GZcsgyDz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C719DF5E;
	Tue, 27 Aug 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757814; cv=fail; b=LS+9IJMtKjdi/hnklJbwzsBouy6MIbWWtf50scNDg6An3CskT1bFVhNwl0AcNIZxHt3CCOvz+v6fWAeJr+LmTdchYKrMQPrEte7Mh2lejoGorhpZRsVW3I7LvGLNXRKjFHBe9LJRQVAmqoMadDD+XwlHynbxSUZYFGXpkuH5g5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757814; c=relaxed/simple;
	bh=E3bWEMVFGQKrjtaZerALwDPp90RvF/Rbc6kagAnhNCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/gM3PaQTX4CSZ0NasRSwWgwRi2+Unk3Y5ChGJRxVDdHDylrefRWySIuQfdqD2tZiA8sH0I5f/IZPrdci82zXYuY5J5aX+XB43MI69qI2pt6MKR31bgHS3EJ27wFGvJkXhtVxWjuzBMHFYgWhN+Cr89mI3Y+4tF+bLxz0OHrxTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LFo5DGVB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GZcsgyDz; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724757812; x=1756293812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E3bWEMVFGQKrjtaZerALwDPp90RvF/Rbc6kagAnhNCo=;
  b=LFo5DGVBnxlOvGcGEzGA6bA5loZ+Ez/VCZ9D3qLcYtQ8qB6VDrLJJTOU
   ekYmXxJgyGS3318dhAchuApXkbfqx6MVtiwuNRvss4hNTRtmgca5V/wWJ
   3Gi7N1jBm801Hmw5xKJ93iXwhVMqLjt2ITutTR8q1AkCrbO3C9FIy7+/d
   6DTutql7VJFDo9taDQcgOR7VnkQNYU2ujEVdLEwxAKkKEpxT1L29O69ga
   8EbbDI9plPe81+OiUskgM0yevjJAdzZPYpUr/a1GbjRwGOzm7SsyfoboP
   cvSlwICpiUe8a265+kRC3erATy8fHr1htP1qMA5LhSCUHuU8+nO65O+PD
   w==;
X-CSE-ConnectionGUID: Rbg/966/RB2enjnUW1vM3Q==
X-CSE-MsgGUID: rq65F4dEQm+ATrpLkhbtbg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="24657249"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 19:23:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZrbBp9WAB6kcC+kaounqNh5LdifmJccC6OIcEjNfEip6YDBMtcDLKd3DmbdLvndXnODVo0Z8uJB8ClraA8F9xA4SzLp66KBhgX2Rrsu6Cu2llwtvxcjqF/yUJEbgrFa9Tcful7e1zraWQdndlhEDw5R6rt3ECOthZuTESZWN+IT+7g7VKhE7GNP33Eh8TDxkgNxLFxuCXVX3M5CqlgYlRZ6MZ+xZwHHkiiXTZc4Kj0p/F26n1/dj/XgMj1KgIKQeEmumOm7e265Dw4307KG9sVm2oDSqYeXTbDmd2eT4sVh60/FIjtRk8X14UzZPU48pyEbP/kUwy8mZ6hU1EI/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3bWEMVFGQKrjtaZerALwDPp90RvF/Rbc6kagAnhNCo=;
 b=JADFwlBI7IUxa9dM061oD2SomFjO2nq7js3kZaszsRDuI+KnC/QHUYdNIXAsUErhKYTCwLk+tqsfMDJHO57HO9HdnMFfxhh+G4ccY3dl/o4YthHlU54gim2TY5N2bFwxuoZyoG/S4Z20ImMaQdqBNs2iZewZpBC5uxxOn8nv24DwndFTKcJw4UtQ3rrRoSsQGcQhuI/bqzH4O72re1i0SgWiVmt3l7ywIDVddraU/qXUQGfntCkfeRBCBBszDWPwLOVw2P27ClH8+fCmY6VDVeYF9TF1gNQ7bFj8DvE0U8XOVvtwYw3TWCen2mni3BtSM4Px6hxR5qvz0Bf//xnYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3bWEMVFGQKrjtaZerALwDPp90RvF/Rbc6kagAnhNCo=;
 b=GZcsgyDzu14Q7lNt/xjfkkw4ihed2gx0kLFz5LpZIzp3fhIhpbuWldi054tj8FW1KcaeG4m5C8sUMKwy1wOVsoWE8U8J/8skEkX1YrJqs0Hz3jTnOAidSwUEHHETsG1bR16xxEEtFQg1WhuA9owiAi2iT+NR11O1gHAN9g7dU7s=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS1PR04MB9539.namprd04.prod.outlook.com (2603:10b6:8:220::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 11:23:27 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%2]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:23:27 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Damien Le Moal <dlemoal@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: fix unintentional splitting of zone append bios
Thread-Topic: fix unintentional splitting of zone append bios
Thread-Index: AQHa997FPPebjVjUdUaZjkFiWp2zQLI691MA
Date: Tue, 27 Aug 2024 11:23:26 +0000
Message-ID: <86fb4922-a3a5-47da-b41b-a55610f2aa6f@wdc.com>
References: <20240826173820.1690925-1-hch@lst.de>
In-Reply-To: <20240826173820.1690925-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS1PR04MB9539:EE_
x-ms-office365-filtering-correlation-id: 85aad88f-e73b-43d0-f150-08dcc68aabd1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW5vSmJVeHgxOWc3NlBFRnZHY1hhZ3c3RndsK3hTY0JEQkxDTEZ1NUZFY2My?=
 =?utf-8?B?L2NaQkZXMmFUUkRwUmFOQVpTSURUL1BhQTVXNlhod1h5UlplSnp0dHErb1k5?=
 =?utf-8?B?UGUvOFpUWEJveGhwSHJRcmtTT0lmL3lkY1psSUQrdXRad1Mxa0ZJNjdRU2FK?=
 =?utf-8?B?SmVnMW16RTF3bUI0UzBBclpWdGRsZktaczVzZnZXdzhGT3NUOWNaZkp4Wmoy?=
 =?utf-8?B?ckEyK0RIbEhKMW1tQ3h6VUpON3RzNW5FRCs5SnhWYXQ2a3JxN3cyL2ZXUlNJ?=
 =?utf-8?B?emJJRFB3YVozRzlCZ0txeTVMT2kyYWZsYmNlditSeFRIeUQxdUhGNmxxdTBa?=
 =?utf-8?B?YmxZRFBVMzlBK0Q3Q2JCR1JxQjlsam5sWFBKUTZRS0VsSTFEbTJLRlByWlcy?=
 =?utf-8?B?OHJHZmt2S3p4d0pjUFFVNWthVC9UQk02TU5MbXBaYjZWbVpRUDlKM3crWFBV?=
 =?utf-8?B?WGdLTktYMGVaUUcrQVl4b2wwaVFFdmdSL3hNdmc0NUZDTHVUazh3b1hObmsx?=
 =?utf-8?B?Z0I0RTlGY2J3b2g4Z1Q0OFFIemxQRFJwTGJISEtZU1dqbU0xOXdvVkFPSzV0?=
 =?utf-8?B?M2o0RTJzUkRGUUhIdEdsWk8rRFEwbWw5VStkRGlvVDBlVEE2ZFNPc3hQUmdl?=
 =?utf-8?B?cUR3QVVMbVUxWE1UVklWREtZa1RnTDdCd1gzcUJZWXlNSWlCdHlNUlN5ZjNs?=
 =?utf-8?B?bDZxM0szVkU5R0N6Ry95VitOamZjNVYybGdlTFpwMUl0ZFZManhKbklDQ0Nt?=
 =?utf-8?B?aUFycmVwZmhVRHdkWnkyQUlDbjJOSWdLR1E5c0d0dzJrVVNaODNVcG5wcmdQ?=
 =?utf-8?B?WTlPYkg5QVlZaVlRN2Vyc2NDaElMVnJUcXp1Ti9mck92Sm8vWWxzYlBlYWo4?=
 =?utf-8?B?Rk5RQllVYlFuM0MwSlJvYUR3b1U2bTZtWkFxK3NHOWYzNkxvNXVBRHNrYTdY?=
 =?utf-8?B?SHlCMDl3OGRrRENDU2FuaXlmR05xMmFYT245WWlQMTNxR3hjdkt2Q0Q2Vlg2?=
 =?utf-8?B?WHZGd0ZhTHRZVjc2WkRQcmRoNi91OUIrYVdRUXlaQThSZU5sdmpMY0JnRUV3?=
 =?utf-8?B?K3RFelhNcG1HQ2NWTm5NR2FRMWJwOXJhVjQzT2Z0cGM4ZXNSZDFyd3ZEeHFW?=
 =?utf-8?B?YmZSVXV5VVJvRHlvUzdsaEY2N3Z5SDF3aElpOFY5SGVJSFBjQURiRjhhUFQ1?=
 =?utf-8?B?WisxTUVNcFJJTHMxTEJxTDlUbUNIdzAyV250UEVnWnBwOG10V1IwWnoxYWxu?=
 =?utf-8?B?U0lCeUZ0bFFKQjUvdk5hczljZkMwekU2cEQveUpoRW9VWnIzeHk3SDJ0UXBB?=
 =?utf-8?B?NnVLK3B1ZExIb3NXM1RZdVhSM1VGMUNORlUwQmNZQkw1NmRiaVR3cUdyZjlo?=
 =?utf-8?B?YzZtMkhGVk44MXZkQVJ6ZUdWNHExL3VhdENIRHRLM0lzQjZlaGZlSnY1d1VQ?=
 =?utf-8?B?ZzlISzNwSjFndmpJUWZUb3llaHRHU3BIZkpJamIyZzZTY3JLNDlPSnRFOHkv?=
 =?utf-8?B?M1kzczgrK0QvZ2tKZlExK0FUdUt5UWRpV3FiWkhpY0hBa281TERvbmY1M3Qz?=
 =?utf-8?B?eDZKU2dYNHFqcFIvdFVLNWp2bWZHSkF2L3U0Tm12TlRNT3Jmb3NXSWhFNjZ4?=
 =?utf-8?B?b2NMS2d4OG9uVGJwSkVJeEVUSFNzRFdmN2xKcWFHL3ZyWS9ZZFdzb2htdzNY?=
 =?utf-8?B?UW9CMllSVHJvTENUTURLS0FtcWVCY2lUcTR1RWNmOGVaTkljYUxlRGhmOG5M?=
 =?utf-8?B?a2tYbHlZN1FmVWlzSlpKbndnODdtWTVidjIwQm84Wkt4R0orUXpxSHRVb1cx?=
 =?utf-8?B?WDdEZVE0d1IxMlg4SUoxNUUvY0hMNG0xSEFjcFYrKzRWbHhqQms4OWYzVG5W?=
 =?utf-8?B?ZVRGYS95Z3hPcnZ1WDNpY0hodm5nKzFMMERMR3VheUQwZWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czk5RXJxR1J4bzAxOG1pNTE4SjVCNlhwL3pnTzQreFRPdUhRQnlYWkZQcVov?=
 =?utf-8?B?bEtiQ0swaG8vN1hqdm9ybHl5U0JKTHJkY2dXUlZUOUNIQ1E1UDRqQUVvS1Ew?=
 =?utf-8?B?eDJIbkhLc2pvSkRCTCtkdXIxV1pCa2F3L1g3SE1MTTRTK3doR09HcGhYcXdU?=
 =?utf-8?B?cTBVTnZXQzQyQzc3b2RaUkxEVC8rMkc5L2cyYUF2K3hXRUM1K3RMUnkvblht?=
 =?utf-8?B?eUdsUUMvSGYvYmlRT3JWMk1QVGFWeDN2bTlVR0lRbGpobWhhUFNiaVhYUTZZ?=
 =?utf-8?B?L0NWeFE3bDRYNitxQnpyZHR4eWJvdW5wc05ETHkxcmZHOTRvYVZTaW54bklz?=
 =?utf-8?B?ZEl5cmtSa1d2UGxiM2xrMXpZNCtuQTVQT0JvY2VzWWorVy95YnRrSy9ZVkZz?=
 =?utf-8?B?c2Jsa2o4V1ZSU2JQS2F0T1cxK08rOG5zN1ExcnpHUE5HSCtpWng0a05hY1Rz?=
 =?utf-8?B?M0hqUnVaMGZVUEZlTWpLZW1wbHI3Qk1jNzdWNUIzcklJaFNxWGYyVElmZWY2?=
 =?utf-8?B?bXVhcWo4dDM2dEhuRzFyejEyanFtMlFDN25IOHN0MFlWSmhhbE9vSUpUbDVY?=
 =?utf-8?B?TVNmVzFhRUwzOHdnRmN0Z0pTQ3NlYjV6dCtKOWtOVU9QdlRzaTE5TkUxWEpL?=
 =?utf-8?B?alZrVng3N29HSWVsQ1ZXbnRXRm9NWWpsN0VpQnAyZTM2RUNYazZXQ0JjSFNK?=
 =?utf-8?B?aGVSd3RpcGtIekVybFZEM1FxT09IUkJCRHdrZzh0R0N5N2c0S2NMR3Bsb2p5?=
 =?utf-8?B?bDU4cTl4cGdlZVJoQXE0WDB4L3dCWFRZOTV6WTN5cm9qZHQxMkltYVZGT21w?=
 =?utf-8?B?bnpJYkg4UlhBNWhYdWdjVEJzRzZKM1Q4N3c1cUwwWTNBUzRXZGVNK1BZaFRS?=
 =?utf-8?B?aW9yMmRyT1NNeFJRZndwSFRHS29ncUozYjJVUjZpZFlMQTR6bXQ5bXd5eW12?=
 =?utf-8?B?NWhsV1dQc3FwL2QrVHNGY2dvTnMrTXZLLy9wVVY1V3JYc0JDVnlwY2c5RzNQ?=
 =?utf-8?B?ZEt5dkZueWJ2VWZ4OFhEVUFJekZtT1lsbXVuUFA3WFh2NUR0Nllndlh6cDRy?=
 =?utf-8?B?UVdraGVaenYxS2hobUlRUGhpNGFWWHpnOGlxWlVuT0tNSG5sMDRQV01zSVIv?=
 =?utf-8?B?QmZPTmRKZTE5VE5GNlh2TWxEdFlMdEFFRmkza0JmWHIxR2w2d2tXRW9tNWVW?=
 =?utf-8?B?SEllY3FjKzBoazFTdWJxVjJCTHhIM01Ldk91RlA2ckQzaDFjc1pqT1NpeXFj?=
 =?utf-8?B?eS93aXRJM2xDanpkam5aUFdrNmdtYlI2QnVmbVpPdjZLS2xUdUs3OUxWTXNN?=
 =?utf-8?B?NFlTc1VieU1EdkcrQXJQQlhZY2JKQmhSVUpzR1h6MVp1ejlPaTdHL2FvZmZZ?=
 =?utf-8?B?dnBVQVZHaXFCU0pUeVUwVDBNbkRwSzcrcG1SV1pWOUNQZUtoRU5sZGpjc3lB?=
 =?utf-8?B?YVVhM2VDRUpnVXR1MDdUaXNFWlNkbXVMWEIvajhFSDZXZCs0WlBoaWk4SDN5?=
 =?utf-8?B?NWJUUUFZcE1NN3ZHZmQ1VlZuVjludnJ3V3VrNnhWUUxpN3hFTytCQjFsMktu?=
 =?utf-8?B?OHdJckx2S3JkbEhnVys5TUE3eDdwOXVvTnNhZlA5T2c0VGhBVXBkYWRYcTVh?=
 =?utf-8?B?UmZtS2t0blhLRmN5UEw1ejJKNjZUcEtNUWlkT0U2RmJQZ3dudWhSMUpZRVZw?=
 =?utf-8?B?QlczeE5zdnYzRUhxSDdHY0doYzQ5eHhsUDNPR28vcUFPRHY1dWlVaDFqUGhx?=
 =?utf-8?B?Ty9mMHJKdTdUbVVFWWp0V3NYNFhheFpGMGxsUTVJdFkvc3R5aWZzczQ5RVJj?=
 =?utf-8?B?UDNqU1cvbUJmNEVaMVN4dWxjVWZ2VzZydUsyaTMzQkV2K0lrUWVWQ1NtcFZT?=
 =?utf-8?B?azF2MUlLd3MwVXBmSXQ4S3FUaHZJVTkrcVcrZXpYYVJOdVl4d0RJYUlxZ21W?=
 =?utf-8?B?SC9vYXhXZ2JTRmRJWlFHdzhoWFk0MXNTSTRCaENFNzFTQWtFRDlwWERsNjVO?=
 =?utf-8?B?U1J4U25NYm9USmluaXZZYWJqR3ZOVzJkb2tuSFpBZnhwSTZoUHd0ZjdMSzFE?=
 =?utf-8?B?bVBsd2ZFMEQ4Skp5Vi9iWGtXa0VUQnBYck5OTGhtaXYrdUxuQTB1SEh3THhz?=
 =?utf-8?B?ZTkwaUhpK3NTT2RYSkdPSk0rU1pmcS9mME9nVDVNRTNPRUN5MjlYNzVzenJn?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66225A713E42FB4D9472E02727F5112A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hO5KoXfJmNt74ie5JfscoMngzcjMKNt5HVnaz7hFf8B2I7/453mDQLAQ90kkuYTDLIWdfNtCRZCdbPM0IKWgkA8N8UuNXWH7ievXVZNuNiWj6MeJW2FVy7O7S8KeK4AOZ3deXerCf82YnGULwakXJxnnx/zAmyLk4Z8b3rq+1SS1lQVyGID9RSj/43tZoZ2TvrcQdJyc/fVb9bvTfUcMqu0WTpnyyK7oCpLfX6+Y+Th5IE//Ni4xYv6iQtQ+KGwu4HMH5hqaxi9k42PpjFQa6Zsds6nAKs0bjZhdtXb0DqSxlxHvp1fAWMSV3PGzcuar/TLzZQ1kICIYSZl/QoDwwWnTXzY86PCBh42Oe0rs+TGkVOvyduw9KsGROXlMoiJk2xLgTiIkAmlgI5YN7M/unihRxl7L3fqOGRo/xaNnU44xfeklGK1N7dIEWW1/KyNX+XWanR4t5W+jJ7pK9i/xBlb/fZ1ETV1PMpMNbO1YE78oH8NkIrDDtQAzQctDwNN4qsyeLaAWzjQnuGoLRZzo7dw1mHVZLhOkBIHhvahUQ3AXkqWZSpmKSGZc1HG9faurGl1x0dbmNdWkVgGfeHEF6eRg+WdXVfXGXbkfbsoCsg4aRBmBwQL+pg6it86nyth9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aad88f-e73b-43d0-f150-08dcc68aabd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:23:26.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pooJqh0QD4F2JxbWno/EiDgYenT5Om76GHZ4tDkZpK4YP0O0NfIv939FUAhCQsTzbnqgiulSON+lDmbysW/NfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9539

T24gMjYvMDgvMjAyNCAxOTozOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIEplbnMs
DQo+IA0KPiB0aGlzIHNlcmllcyBmaXhlcyBjb2RlIHRoYXQgaW5jb3JyZWN0bHkgc3BsaXRzIG9m
IHpvbmVkIGFwcGVuZCBiaW9zIGR1ZQ0KPiB0byBjaGVja2luZyBmb3IgYSB3cm9uZyBtYXhfc2Vj
dG9ycyBsaW1pdC4gIEEgYmlnIHBhcnQgb2YgdGhlIGNhdXNlIGlzDQo+IHRoYXQgdGhlIGJpbyBz
cGxpdHRpbmcgY29kZSBpcyBhIGJpdCBvZiBhIG1lc3MgYW5kIGZ1bGwgb2YgbGFuZG1pbmVzLCBz
bw0KPiBJIGZpeGVkIHRoaXMgYXMgd2VsbC4NCj4gDQo+IFRvIGhpdCB0aGlzIGJ1ZyBhIHN1Ym1p
dHRlciBuZWVkcyB0byBzdWJtaXQgYSBiaW8gbGFyZ2VyIHRoYW4gbWF4X3NlY3RvcnMNCj4gb2Yg
ZGV2aWNlLCBidXQgc21hbGxlciB0aGFuIG1heF9od19zZWN0b3JzLiAgU28gZmFyIHRoZSBvbmx5
IHRoaW5nIHRoYXQNCj4gcmVwcm9kdWNlcyBpdCBpcyBteSBub3QgeWV0IHVwc3RyZWFtIHpvbmVk
IFhGUyBjb2RlLCBidXQgaW4gdGhlb3J5IHRoaXMNCj4gY291bGQgYWZmZWN0IGV2ZXJ5IHN1Ym1p
dHRlciBvZiB6b25lIGFwcGVuZCBiaW9zLg0KPiANCj4gRGlmZnN0YXQ6DQo+ICBibG9jay9ibGst
bWVyZ2UuYyAgICAgIHwgIDE2MiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICBibG9jay9ibGstbXEuYyAgICAgICAgIHwgICAxMSArLS0NCj4gIGJs
b2NrL2Jsay5oICAgICAgICAgICAgfCAgIDcwICsrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgZnMv
YnRyZnMvYmlvLmMgICAgICAgICB8ICAgMzAgKysrKystLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2Jp
by5oICAgIHwgICAgNCAtDQo+ICBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIHwgICAgMyANCj4gIDYg
ZmlsZXMgY2hhbmdlZCwgMTUzIGluc2VydGlvbnMoKyksIDEyNyBkZWxldGlvbnMoLSkNCj4gDQoN
Ckxvb2tzIGdvb2QgdG8gbWUsIGFuZCB3aXRoIHRoZXNlIHBhdGNoZXMgYXBwbGllZCB0aGUNCmlz
c3VlcyBtZW50aW9uZWQgYWJvdmUgZ29lcyBhd2F5IGluIG15IHpvbmVkIHhmc3Rlc3Qgc2V0dXAu
DQoNCkZvciB0aGlzIHNlcmllcywNCg0KVGVzdGVkLWJ5OiBIYW5zIEhvbG1iZXJnIDxoYW5zLmhv
bG1iZXJnQHdkYy5jb20+DQpSZXZpZXdlZC1ieTogSGFucyBIb2xtYmVyZyA8aGFucy5ob2xtYmVy
Z0B3ZGMuY29tPg0K

