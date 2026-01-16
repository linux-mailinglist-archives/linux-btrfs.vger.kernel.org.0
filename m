Return-Path: <linux-btrfs+bounces-20613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69745D2E267
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCCA030963CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862EB3064B2;
	Fri, 16 Jan 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WKFuo8bS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ExVTKgzU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A1305E01
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552717; cv=fail; b=H7sXROcGYdcoGPEl0Cu9AKRV4t+nwKuM6XbuHiQv7rS3qt2ezdD4KRo1qPMQy107ZLe7Fn5UjDDmxv/gZJKtJVvyU3d28UwDuSYaPzlTuoQXL63Aojb825Xf+/zraGtJtBWRal3/yq8bbLg8kduTX02vzDcLjFqMIo1FiDKr92c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552717; c=relaxed/simple;
	bh=yWFdy6ttc0tGYJeaig7jipagI2CDiAm/2vazOsKtknU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEguy4OvbrXYVe0b+zjXX9yEII9cXCBFtNThEXCZytAO7DV9fsoMipprISEMZdZDfeNR3vmP/CFkN9NiP+Y3BdhfQ5mhBEvJ+ImJhs8B0QeJ0UXn1Ch4jkGpcBFd18063FzIMb5XCXbDAeQhGYSqEBBNKxn1vs0rkvMRJMsZnus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WKFuo8bS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ExVTKgzU; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768552714; x=1800088714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yWFdy6ttc0tGYJeaig7jipagI2CDiAm/2vazOsKtknU=;
  b=WKFuo8bSmML2axhJwFL0Ug0CmHwzpRqbi9/ACg+570t7gfE+WwxExR44
   KdK5cdflWzJNd8nStiKDIkHiiF1tGUFJqxSmcuLugdNNfHSHf4/9t8r2v
   vzJk9OH3RwHcg/991fEE0U4GOkPUVVzvU5oqZJjisKrBO9NONaczroiVb
   TdnejY+35jIBZBaOoA28ibbLqSxCKNUHZfi8YyvVVEwCVxcswp/oVW4Y8
   /l4+WSz7epf/EFEgEGRnD2+aXgyKUNWL9hGfrFbyKf13bdzwAZU7AIoNo
   p4zzN0o37/KENPup76Uv+Y/wrcmhJy7Z9vRHz0Ib+w2SwwHAHdE2qVUV2
   g==;
X-CSE-ConnectionGUID: RAOF5FXxTSS0YGJuqeP87A==
X-CSE-MsgGUID: qibJwz6CQTWG3R1zlD9Zow==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138190876"
Received: from mail-westusazon11010062.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 16:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6A5hGcXmF17aSDkD3gLhOCInJ4sj/LbS0gGmdtfYSY14saQ+z2t7H4L14ywE8PfupuJuigG+UwChN624fnRd2k6elFWxd+ERg5nQDRmzlQf6zmoaK+AlvwVFVrrKGNTyqY4vOnvmQgic2hVVjzPlENietF7UqDZrCFv1nsDYguvW6x+aAPWVaC5AhkmvmVXiUYnku9pibq5Nh4xCqDwayfN3m72GBnTwFg8wSEQTWg/0m2xVqZkVBkpGp2fXNCfRSiPWP0K58KFk/iaRPKuuEm7HdX5JMgTuUEovSAZLmXJtgzmy8hFDfuhSO0HLu/5npqmkMnTy5rOgerLr1I+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWFdy6ttc0tGYJeaig7jipagI2CDiAm/2vazOsKtknU=;
 b=dhtpiRm12kjugFdWSrxFXhKi0DbKXU7S03e9FuKm40K0gAkFmSPe18WyO7NTwi2qg6QuBmWFbL9s21At//olH3jR+8T8WHlR4wc3T+a+eSmQdfpZFWrSXXbS6+dB8YMW8JPNOwsZ5Fh1n5XuvmRtmEMyf18MC6Rd1723tdV1alqngH0IrLcFs8Dx44B2J8WbYXy0O8MhHSLU9pBCZSRjXwAZBXDciYqEp3DJ75TMQydaTAfAcozuLXCdQOdzQ5fIySldtF4j6AR0yZwZPXrVsBbi85bTymWaNOsHstsGxNw9ofhteZ87lhKCjk/+ejwX5WqZCVDXx+X69Oyxv7lZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFdy6ttc0tGYJeaig7jipagI2CDiAm/2vazOsKtknU=;
 b=ExVTKgzU6ugB/dShzUdz6GHLOSz1rVwBnZS0hQ0DLIFW/OgMx6oodUiNXl4J7rausRE9TWzEHL3TfTsjIvIz3cnD1eX1Nb6rd2oxrAktWVqN1aJqPnKe7aQsPYCWn0MAHdz7JtNZ4Zgvwzny915fEPmnX328WfUJwwwbGkvy0+s=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH2PR04MB6839.namprd04.prod.outlook.com (2603:10b6:610:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 08:38:27 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 08:38:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Boris Burkov <boris@bur.io>, "fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Topic: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Index: AQHchmlIPLDBGXEe4E6RvQEY0dRWdbVTzlQAgACTHwCAAAFjAIAAF0+A
Date: Fri, 16 Jan 2026 08:38:27 +0000
Message-ID: <7b9448de-a0a4-429e-ad24-2c95d3b21a06@wdc.com>
References:
 <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
 <20260115222309.GA2118372@zen.localdomain>
 <04469920-1dbb-46d4-ba8a-b4ac986ffff1@wdc.com>
 <aWnldkx-jTBlnIhv@infradead.org>
In-Reply-To: <aWnldkx-jTBlnIhv@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH2PR04MB6839:EE_
x-ms-office365-filtering-correlation-id: 488553ab-e340-42b9-9103-08de54da9eac
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cURpSzA0LzhEYmFyeTlVMW1ucHpIWXZtK0Z5YW9oK3FLdDBwYnR6SG1ibEdV?=
 =?utf-8?B?WWhCTC9QNUtFTnpta1JnZ3N1MDBlMzRPK3NPcWdaM3hxQzdZYXlxSWl0WWpO?=
 =?utf-8?B?NzhSOWdOY0FOUmdiekNsUkFnc2lnRHdvTHlFb0F1dTF2b2FqcDMxcm9nWDdM?=
 =?utf-8?B?bFFGMGtTRGtkV2pxRmJWWDVoMkZCTU92NGtGUDYvU04vZzJnay80RlFWODFC?=
 =?utf-8?B?UGd3bURRN0MvODc1NUhSTkI0dWU2UVAvQTJjTVpiWHpESGZHSkR1M2VkOXov?=
 =?utf-8?B?T2FQcGx1dlhmNUk1Wi8vbGdCd3RwbUlUcDRrVlFtbkNjYkVlSE82d0dZVkl2?=
 =?utf-8?B?Rlk2SCs2VnJUalEzeUxUSWg2NzhMMm9RSmRHcUh4ZXdFTjRVN2FzUXdrenIw?=
 =?utf-8?B?MHhLSlZzTHovdUR2RmN4K3B6bEJrWlZuaDRLOG8vMmRNZGNGcjk1TnBSQ3cz?=
 =?utf-8?B?bjVRU0tqSTlnOFJaTmdEV2Q2bU1OUTVjVGNTSlV4U1ZCZ1JaYUpSZjV0QkNl?=
 =?utf-8?B?OEJjd2ozWUpVcjV0ZlNkbGhRT0k5ejVDM1JMTDFSeldhTzFjS0JGMkYyZEF2?=
 =?utf-8?B?QjdMTjZOZzRScFVaRWFham5ZeUZlbXRXWHRJSXJxMzMwczFYNnhHRnZEOXY1?=
 =?utf-8?B?YzUzZXJNelo5WkRCYlF3OFFyUmdFcHh2Lzg1UXZtdHNUSlZ1aVZlOHU3NDBn?=
 =?utf-8?B?QWlxY1NQU1E4T091QXdpU0dJUTVWNEU4amV1S3dqbDVLTXcwa0R3RTk0aC9y?=
 =?utf-8?B?THVFdURwOWxacEhtNUErZ3BjaTV5K1NqM3VLYkxtQjhhUjNGNk1oZ01RTXo3?=
 =?utf-8?B?elJXZTlyWEdSYkMzV2tOMHMxUjNoQVVJQUpJSnpnUGFpb2VGVGdwS01vbmpH?=
 =?utf-8?B?OTg2b1RDREVUeE1JN2RKdzlGcHVsSmU2cGxwc29uOGZwRkJvOVlkQm8xZXk4?=
 =?utf-8?B?dytqMlFucng3TE9FU0paZnhwdk1uYVovNEZHMEhyOGN2ZVVoU1Zsa3V5T0dp?=
 =?utf-8?B?aWFGWXg3b3lNL2NmMjRvWFJuc3JmMExkMFhLVlo0WlRZWkRCb1dyS2VSOTAy?=
 =?utf-8?B?WjBUVy8yZFBUTGR3S1c5RGZuT0drQ2VIVUNnMXM1R2VpWUFKOEZyZUs2TSs0?=
 =?utf-8?B?QVFITFpkbjRyVk9SYjFreDFMZWFIc3NSMW1HSm1Eai82cVk3SDZ3R0tkM2xp?=
 =?utf-8?B?bDFGTytTejkwakZUQlJzTGtoQS8yVTg3Mm1CaWZZVFUxcFVzN2NRQkhna1VE?=
 =?utf-8?B?a0tpWFB5c1FhK0s5ZDRGdEFrL1I1b0JhUC9YWFFOVFcwU1Yxbm5CbHFXcHVM?=
 =?utf-8?B?MnRRb0FROWN2bW5xa2Z5MFVLckdMY1lkQnlMTkcyRWlhK2QrU09IbjQyaEpt?=
 =?utf-8?B?S2huMGNTcjEvUFUrL1BhTUxMMEdiM2I2SUl4LzRueXQ3bFVMcitqRHNHWnZo?=
 =?utf-8?B?NGFhdmlVWUc1WHRVTFRkbm9ZT2czblpJL3FyRGYvVFZSdnhjY0xkamxHUXFE?=
 =?utf-8?B?clY5alBBR2dZR3I4RTNkSjhUSWo3MUw0UXlyK0tkK0QwT3dxWFE3RDg2ZDJp?=
 =?utf-8?B?Nys3SWhsZEtXU1pxMWliWE5FVUdtNEZJQnpITzJsaFpvbWh4SWRBNk1TdHk5?=
 =?utf-8?B?UFRLb1RERUJiVzh0RWp4ZWZpSzcybXNvSTFHVHcyZXByMHpNczUxQTZRUUdv?=
 =?utf-8?B?aXZUTTJnQ1llQm5KSDJWSWFMUEVDOHVRYVpyT0RSRitaKzRDUldoOGN4WUlC?=
 =?utf-8?B?cU95Mk1oai8vc3l4akg4YXBxWWt5N2pkMk1LWGlFOVpCNUVpaVJUdEV3RjlY?=
 =?utf-8?B?NjgxTm93ZzIxK1h5b3RQdWFLRGNLZkc4M3RjZHBibUF5Z09UbUp4VXI4QzhD?=
 =?utf-8?B?VStTZ3dhaXJ6NmtabDEwMlFkNDJTZGJSc3JDQnNVdEVXa1BnakpOU1JCak9H?=
 =?utf-8?B?MUFvM2hDdWxkTkRDTkI0WHJXNkQrWCtldjQ2TDBKVzNra0IrRWdjRWxhRmJG?=
 =?utf-8?B?YjI5S29IVFZqeUZEODJVKytXT05iOVVkS2d5NEtJY0NSbzZBdlR3OFZnZ29J?=
 =?utf-8?B?SEhvQXlXWGNWL25TUkdxSkVMTGpKbndPQWhvL1YvUFRvQVhKSWNpcCtJay9O?=
 =?utf-8?B?Mk9lNXJkM0FXWHYwNndYdkFOOTRXS04wcFYwbHg1NWNFYklBcGNaYVpQY3ZB?=
 =?utf-8?Q?+Erj0jNojzvLT7ulWJPfw40=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3V0aUJXV25zNXkrZ3p0aXB5bUY5WW5HNkltb1NiZW9zTW1YM0x4Y2ZpSmVD?=
 =?utf-8?B?TDZpRWI4SlNZU3R2TlNVMmFVd25yc3dLTWZwOTYrME9VMHZSQXQrcUZkSGl5?=
 =?utf-8?B?cFdHL0ErdDd6RmRZeXFUTkk2dXZVc0IxWmZhMThPUVFMdk90Njc1N21CeElF?=
 =?utf-8?B?bTB3T1UvNXVrYjQ0TUR5VFE0Y2gvc0xwNGlLSmkyL3JsMUo5djBZaldrTkwy?=
 =?utf-8?B?dURMMTNkdWZvdXEvVytZSEtJY1pHa0xZdkNTdWV0NXJrS2E4UitqV1huYnFD?=
 =?utf-8?B?QzRGbXF1c3l0c3NnemlHUmRoby91S1hzVEk5bzMvWmFmT2RtSitMbW00Z2la?=
 =?utf-8?B?TC9jRjZjZ0ZveHBiZzV0OGxmMExlTFNIR0IyYVVKY01wbVZYYVM3eDlMUWF4?=
 =?utf-8?B?Um9CR2RwV2ZEMmFKOTlMVk9EdW5qVFdTL21TeGhXaWVFY28rU2dlTmd5dHJk?=
 =?utf-8?B?dlE2L1JlSEg5eEhFV3dRYmVtS3R4WjRjSzJ2VDZmekZBYytPcWZkZkRiVGFH?=
 =?utf-8?B?U2dFd1oxWWZZREY3aGJIVVpyMGVCaEJ5NE5BM3A2eWJLUkFsRFRRWXZDUEc5?=
 =?utf-8?B?REpnOExPL01uODRHNXNQdVJGQ3QvditleHpSWFpqKzJJdUtsWHFoQ0Fpa2FH?=
 =?utf-8?B?Si9LZk1zd0crQU9vbEV3bGlyanNLalZIOTVlS2lUYVR5S3oxZjBnKy8zeTZ4?=
 =?utf-8?B?ZWhXaERwcHNDaVVzMUFVTGN4eHp6dmkrVW16NGlxYmRoMXVZK2F2MU9HUXJ6?=
 =?utf-8?B?SElYWlpscElTc0FkamhVZ0FJcVpuN2dMb2YvN2J2TVZXWStoUUdiQkZkUVkz?=
 =?utf-8?B?YnRlc09pTHFyWjdiZFVoNXkzS0ZDNHIvTWhkc0JNclJwWW9QNFMyMEZxTU5N?=
 =?utf-8?B?N1dJVzNaRUxLdWJMMXhqZWxSR3ZjZnp1cm5PRnJ1Y2o5dGgwS3ZCWStxWlVp?=
 =?utf-8?B?ejA5WDBNTWRMaTlPaElZNG5yNzdsSzZWNXVvaU1LN1NiVU5GUFE1ZXR6b0Na?=
 =?utf-8?B?MG1rV2orOFA3NUhjTkRNQU0zNnA3RXJlUDhuYkJtKzBCREpxR3U4bXJsUkdr?=
 =?utf-8?B?akdwOHRNeTZycVhwMVJMUW5jYm9TdjVscjk5ZWF4bjVqVnVuT2ZRMEY3aElO?=
 =?utf-8?B?NUQ2MS9PeG5WMHdiekZvVitQTFFtMjR0YktBN0NkbDZaNzJYUmttZlIrNTg1?=
 =?utf-8?B?Mlg2TFE3NmNrK3A4QWtQN2g5Wlcra1ZwR01QaCt4VS9sWEN5S2VYaFpXZlla?=
 =?utf-8?B?WDJmWWNUanVXeFBrTTlxYkJNZHJtTVd0RC8vTUMzbm9QUzNFeU1BWC9NSDN1?=
 =?utf-8?B?YVFrL3FHV1hFaEltZjhKelplOWZkRXdNRWJQakRFQ2pVdXRITEZGTTU5Y3dW?=
 =?utf-8?B?NWZ5U0Z1NGl1STJQYlE1QVpHQm1WbExOKzFhdW5Ca01IQUZ5eVdZbk9LcTdK?=
 =?utf-8?B?UGJHeGplaG1DelhNQkxpWk5zelVqUU9pRjY3QnlqaDRuVWoxc29TK21HSElm?=
 =?utf-8?B?VTJ0LzB2MzRLeFlLR3dXOXZIMHJ3alpFbWlwYkY4RXZLTGtPR29YaFF2WGRH?=
 =?utf-8?B?eFV3TVRtcVBSSlF0cFBVTXkzMzUyT2hwc1YvQVVvc2F5RlVlQUU2d3AzUThx?=
 =?utf-8?B?MDJ3MTRvVmo3RTFQbG9wZFNOMTNsN3U5aGtmaE1vRk45emdacUQ3eU5Qb2sr?=
 =?utf-8?B?TGxRb205eWNCcFl0QnROcWlxLytQcUtRdDJaMUsxRk1NNitGMUNWTWdBejBr?=
 =?utf-8?B?ZkhpYzY0allOeUJSNjlLZjRHOHRmSVFYeGtxbTUzU2JyVkJEVUtjUXRVVmt6?=
 =?utf-8?B?dzVNTlM4N2krSGhCbTByejRPYVk3QVVxQnhTQjJmQUtYUDA5MlFhTmhBQnRu?=
 =?utf-8?B?Z0t3bmE3dTh1NXI0VUVMYmRCaFdoTy83ZCtua1JYNzlvbG0ybmFqaE9ST1pM?=
 =?utf-8?B?UmNmM04xOThqVEtrOXlUelFwNENIVVBxUjUxYjhJYk1XL05FbFV0dXlqV0sw?=
 =?utf-8?B?Mjh1VUY0bDBjUTdYVGRUcTc1cGsvem40Vk1YcXNTWVQ3ZWhBdkNxcGx0cEhF?=
 =?utf-8?B?ajJGZkZxUkUrdVhYZEdWQTJXbHRCTEhxalliVS9lK2ZGc29PemxVU09QUE51?=
 =?utf-8?B?SkVCeDU5Z0FMUWVKLy81Vk9WcFVsdVVMRkxaZU9kSzFWdHpvM09OQWlRclB4?=
 =?utf-8?B?eHgyRzVxY3dnaGN0amlhQkNFUStQQ1QrWXlaV0hweU9uQXRiUTdyWDdOd1BK?=
 =?utf-8?B?ckJUdnI1MFFIS09GOXgzNjdhUXFVbFZNN0I4NlN1dUw5TUdyaWtvS1dTTFpX?=
 =?utf-8?B?K003NmhiT3JUZEpJTjd0bFlMeTlEbmlnaDJXOVdsc3EybjhSbmsvOGRxcXNa?=
 =?utf-8?Q?yYvND1pfEBRNtQi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F596C1A5239DE40BCEF055EA5D1D71E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	woIJa2x66XpPdHStHYqoK/W96ugQTsGDxJEfXH91cSOw6WScEq8+vTPdt5CIw90iMuSrfHjmpaGsRqQzrg43AhZSLA+gAcBmAF9Oc3aQB/EFrrzfRbZdXSe0XxMMo25rdVx+L667YZldHqqcJ5g9/7n+FxfQ6L8cqlOHOGw6rKw3XKU9XWIRT5XLVOMC0+fTpT91vOG8s7FK98fq9ZGwjt42VreCaaw06EEdGnj8PNwfgM/7A6LKYi6Qo3un2Qcj3zcVMOm9OTL5ZXsYvzSP8YUXL55Ho2Vx+clOgmCH09R2zPju6ItFl6cR/EYdRlyyunU4XX6RxZMKMmO7gPAhEbPEchDoJBETv4MMwqlwSdjJFJz4hRM6bnHbHmdXlWPsru8VJ6ws7gfVqIxYT4irVzt2EdPggGfW4GVIA674cpIRAP1IA5txusy9KUL0duhmgk/VHgXVkL2ncY0Yh0hB9zjV+QABdIqf8H48gQTr6fRAmgLbkA6G+f/wjVMFGOaAFfpu9eEfvQMyCSC69pl3UJMRtd3rd5A6Fqqbu+EH5ruDdrb2gKur1e+FEAkW//uB4bihCJX+B7D6kcbV/itNPpNkbe0bNp3VXM5OJYu/RjX3z3OfAGRilQzOleOQGi7g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488553ab-e340-42b9-9103-08de54da9eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 08:38:27.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J89Jgr3Et+rbU6ZNejADD/g4zofqjZZoN9TS53gGR+QyYc9h2YURwv7rf/gqadyl0DPZ4w87DhJK2jLQio7E+sqGmAU+Qt5io8RdYJwzNYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6839

T24gMS8xNi8yNiA4OjE1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJpLCBK
YW4gMTYsIDIwMjYgYXQgMDc6MTA6MDRBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4+IEZXSVcsIEkgcGVyc29uYWxseSBraW5kIG9mIHByZWZlciBhIG5hbWUgaW52b2x2aW5n
ICJhdmFpbGFibGUiLCBhcyBJDQo+Pj4gdGhpbmsgImZyZWUiIGlzIGxlc3MgZGVzY3JpcHRpdmUg
b2YgdGhlIHpvbmVfdW51c2FibGUgYXNwZWN0LCBmb3INCj4+PiBleGFtcGxlLiBBbmQgZ2VuZXJh
bGx5IGV2b2tlcyBzb21lIGtpbmQgb2YgY29ycmVsYXRpb24gdG8gdGhlIHN0YXRlIG9mDQo+Pj4g
dGhlIGZyZWUgc3BhY2UgZW50cmllcy4NCj4+IFdlbGwgdGhpcyBkZXBlbmRzIG9uIGhvdyB5b3Ug
aW50ZXJwcmV0IGZyZWUgSSBndWVzcy4gSSdkIGludGVycHJldCBpcyBhcw0KPj4gYSBmcmVlIChv
ciBhdmFpbGFibGUpIHRvIGFsbG9jYXRlIGZyb20uDQo+Pg0KPj4gQW5kIGZvciB6b25lX3VudXNh
YmxlIHRoaXMgaXMgc3RhbGUvb2xkIGdlbmVyYXRpb25zIG9mIGRhdGEsIHdoaWNoIHdlDQo+PiBj
YW4ndCBvdmVyd3JpdGUgZHVlIHRvIGRldmljZSBjb25zdHJhaW50cy4gU28gaXQgZXNzZW50aWFs
bHkgaXMgbm90IGZyZWUNCj4+IHRvIGFsbG9jYXRlIGZyb20uDQo+IEZyZWUgZG9lc24ndCBpbXBs
eSBhdmFpbGFibGUgdG8gbWUuICBGb3IgdGhhdCByZWFzb24sIGluIHpvbmVkIFhGUyB3ZQ0KPiBl
bmRlZCB1cCB3aXRoDQo+DQo+ICAgIGZyZWU6IG5vdCB1c2VkIHRvIHN0b3JlIGRhdGEgYXQgdGhl
IG1vbWVudA0KPiAgICBhdmFpbGFibGU6IGFjdHVhbGx5IGF2YWlsYWJsZSBmb3IgbmV3IGFsbG9j
YXRpb25zDQo+DQo+IEknbSBub3QgZ29pbmcgdG8gdHJ5IHRvIGZvcmNlIHRoaXMgb24gYnRyZnMs
IGJ1dCB3ZSBlbmRlZCB1cCB3aXRoIHRoYXQNCj4gYWZ0ZXIgcXVpdGUgYSBmZXcgaXRlcmF0aW9u
cyBiZWNhdXNlIGl0IHNlZW1lZCBsZWFzdCBjb25mdXNpbmcuDQo+DQpUaGF0IHdvdWxkIHRoZW4g
YmUgbXkgZnJlZSB2cyB1c2FibGUgbmFtaW5nLiBCdXQgd2UgbmV2ZXIgZG9jdW1lbnRlZCBpdCwg
DQpzbyB0aGF0J3Mgd2hlcmUgSSB0aGluayB3ZS9JIHNob3VsZCBzdGFydC4NCg0KDQo=

