Return-Path: <linux-btrfs+bounces-22242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFPVGWBEqWlV3gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22242-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 09:52:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29E20DC3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 09:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCC2306E3C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3F374E60;
	Thu,  5 Mar 2026 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QFC43qYn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SUcE16Wy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DB2EB87E;
	Thu,  5 Mar 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700671; cv=fail; b=CS1xhq2z/NcraQyh9ThR9oAq9PMP9NltoSSw0tf+D7n92DjRNSBksncwnVQs3kd60VYWj8JloTnN3nDX0/WGfC/zNDI7Rrib4TlVOaBkBJN6F3UcukXPfVbxC3S8sI8fR2iN/ej+4OL6HgpEVc8TgaAEoYE9vHTnVme5d44oZtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700671; c=relaxed/simple;
	bh=sC+nbDH48eNbQb76sNaiLogKPOItpfEYuny0ven0NW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vAtNKkOifpERg63InpOsOkciAkwgG+CIlOzL8Y9/Lqwlb33Iv2h1fjG/bogwrxi0pyaaKXtJuCbNrLshbGPY2XiziBp4GrNjD/o5lj5C0ZBX6MTEvpxEeuA6wAz13vovpX/tjX1iCwZ+v+NQ3c22h4l2klkw9Tlgaixj1svQoF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QFC43qYn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SUcE16Wy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772700669; x=1804236669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sC+nbDH48eNbQb76sNaiLogKPOItpfEYuny0ven0NW0=;
  b=QFC43qYn0x4fALrGB+1SG230XQzMiahGAldXux7YuVOLd4aYZu84j3PW
   qG03gwm+ubhP3Mn5D9B6xXtFif/mp0DslTfeg5vDSuZmAkha88yMCibJO
   SQfj8wxnaHq2eV8eu59l6cF8iQjyPNgkZfFPfz4OyAYQxEeUnRGOQH7Kp
   sY0rjUy4OnucZmfPxYv9+d/EPTxUYxFuEwpgg1D3VyfowGD5k/HHYjKnl
   9U0AHW2muFX1ziUWNXPTWLyZU1Qp99UwcMp2GW1Cpb9aO6lKVHGWqTbPc
   LGmUMYLDImyTJjdcSmfhJnrOeiuIJ8djcjOL3owNgigcLecEDXLvROsjv
   w==;
X-CSE-ConnectionGUID: DujCCRK5TkCuTodwKd3pUQ==
X-CSE-MsgGUID: xiJmYPA6SQKEnE9SSx+atw==
X-IronPort-AV: E=Sophos;i="6.21,325,1763395200"; 
   d="scan'208";a="143081647"
Received: from mail-southcentralusazon11011049.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 16:51:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdNpQCtQpvPg2OHyqz1tEIvo7GInwJMZBbDjkTUqm15+VdpOV1+zme2c0X+hGbVNBio9fvBcY86T2vMVYf20y1oDlC/LZtoWme8UaL0zbdqRPjyffQTOLcf+nmpnd2uJlDxoyGT1TIDjOivg3/NCX0cPfJDb5+FaJ0ci+v0IvQTcIEQZ9RNvNKM08cZVlD6mqsN2eQG0gEjFRYIRqPT5VgI6eWXEVsUHi5v59mhWEi7VdPzrOsBEn6ilxSQ6fbUhxqS9E6Zmk9kYhKMONcwLN6CminsvcssvSRE4lB1yBw5nkZO9Fz9igAANM/1xiEFUipD2K3nfuRl/leqgN5voEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC+nbDH48eNbQb76sNaiLogKPOItpfEYuny0ven0NW0=;
 b=FBJKu4jJkCiVtaXxcGiTGmdVI6Fm8yDCc0Hm9WCKOqF5wJ1037jnR3+OSQYWJJq7oN7H3DnrgpQFlpBRIcCkmWE9DzHx+DjuLv7aRA+UxydW6zxq3dQijjSUmKqusz3VU6Q4lv1DoHibyX4urrC4awtWrj78moXrYGbRXEqdw1Nc6DoU/d7m0ex2h4iYl8BGmo1WfHZsBkw/Q24WyFvIQscD7lMVL1K0VMXoqL8dHRE9zyECMT3sic1NzdIYptthk4srwo+z0onToiN8bJ6QUnmtxAVcl0WOoQwkoup906uzKJmuT+zhtsfZO5x0e+tukcign4OIBmF8PQ8zcBXuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC+nbDH48eNbQb76sNaiLogKPOItpfEYuny0ven0NW0=;
 b=SUcE16WyCzRaR5O49Dt/Xywghhw7PQiHH1zuxpOxxuK8PRS+N35Bdvi/XOEVKkEwcdpaguJrRFEaKz+RkdohrVrPeekQxsLJ/aqZNRmGHIX+hAXmZKugJg5VwkDI5mHozFG9Hqx2b0GXOgLzLSB/NfEl1ZcBUE1KFJdYtaIL8Mc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS4PR04MB9721.namprd04.prod.outlook.com (2603:10b6:8:280::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.16; Thu, 5 Mar
 2026 08:51:00 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 08:51:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Topic: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Index: AQHcmn380SEWYFJwgEKjj1PHhcZCxbWfxWOA
Date: Thu, 5 Mar 2026 08:50:59 +0000
Message-ID: <f5b82b17-f11d-435b-9bc9-893f049900ed@wdc.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS4PR04MB9721:EE_
x-ms-office365-filtering-correlation-id: e401f9c0-0d92-4e77-704b-08de7a94532e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 HJ7KxDyJphJLG1wfv2/3f5bLgSduUQclD66f8dJKXYsWSh7mca++5pODX1inJ9xCB3CHZF3bNIr0g/WSb10ByJdxXrS2tcJnqJCDBHSvUpUIl7CP2jnexh3bB/fNaniRfQuSSW6SDUCRp7NmXasQyL61Z+CZ7pLpDrN2ntLOw+jq5qGl2BTiMH84pitBm0L7hEXa68uwbdieFskfxDy24iin2LxidUzPG/o61Ga/nJ8Pol9qTf60iA5Wdjf0yZXj7uCMbGnr2UdF7FOFltF45Zi2bo7+gjf8fiJLVGbLXm5ui6GLU8KqGcUFUtiLbbeFNxTQBaWOr4b8x3vj63e4npfiEF/jwkM9Vj00m9o7NyB1+C4eGQBqO6ZEpXjJothcNR7iroYZMyr1q4BFRzd8uE4lMreGaZo8e1kXHc3CoWeVTtsnX7IPcaYS2UrfryfjeTMtkvJxIXoq+mZbWZM++QRlzjswDt2kvYQPSuONDfxUQKXYe4yUmjHgUejQOAzdW3dEFW80qURvm8/XbSuzVJ3K0WMsH5UkkGp9lEheFZCEwJPz7on3SkImbDgXkDn+OifzRkjHNCuecTxY/r7IvW8K0mgt94B+fXQwtGiEKxeM3qZPoLTzBDXKsalXIfU4SEDfaqhh7SMcUWzTMbNv5RcqcgJ9yGg/pVW6h/i4GQjlLOGU7F/+gvGO7asLAD/kHBINGk6cSpLjeMFjiAb2nQ6UCoKl87JwmO7/Ai9v7H2cUdBA7t3qw7C0A9m9kQWygJ0iGI2XdQEUTzoqv9LjDmenhjQRDjeDBOTaGyTvmWU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TytSbkR3WWxMSmwvUW9LaHdKY2ZPeTgvS1ovelQwRVRSSjFXNGl4TmpMK3h2?=
 =?utf-8?B?S1l3K2hDNDE1QnI1RXRJOU9uaTJiRXBwSG1Ta21HZTJJN3IyZzMyT1JVNWww?=
 =?utf-8?B?VmlIdGxHVFlBTCt6Y1I1ZUFYT1p3aVRDTnpzdDJDbG5uMVBSc21jRTlWVWR0?=
 =?utf-8?B?d3FVdmxlQnNCSC91dkg5VStucy9UU2I4TEF6WjhuemJZYnA0MlRESFFpeW9T?=
 =?utf-8?B?ZUpESXJlUmZ5QWloWTRtSWtpb215NGNWTzg0TlYvTXI5ZmY2YjVUVjBERXR5?=
 =?utf-8?B?WGt5Rkoyd3BVVElHamMvUE4yRW5Ib095RVArVDl2bHR6YzFPUVhzQjRCTUVB?=
 =?utf-8?B?RGVPY2NIRjN4bkZwY0RIc012eDZlbTE2b2JEQndvajQ4ZUd2UGZuNDhQWStG?=
 =?utf-8?B?M2hmek04RUJEc29SSVhQbXBzcTRjTHBmRTQvTkVNdXJjOVIrOVdydzZCYWov?=
 =?utf-8?B?OU94THBvZytITnpjbjlsbFM5RDc2dzV2WDR6ZlZ6aCtkU0tmWTNWekwwVGp0?=
 =?utf-8?B?QlF5dkNxYW9hbUc0Q3JOUittd0xlOHRTaEM3aGkxYnBzdUxvNzg1TGlKNy9K?=
 =?utf-8?B?SitLMFBZUE4xNlRSVVptcWlQTEFYR3V3aXdEMjM3ZE5wQ3N3NTcveVRUaDlt?=
 =?utf-8?B?L0NybFBLLzNjK3dQUHUvSFRTN0hBZlo2N1lWaVZOTUk2UW4xMVlLbzFHbmRp?=
 =?utf-8?B?c2lpNTJ5Ym1kZDlFQXg4aHk4MDIwM092WS84SDA2NW5jNU1VUmNpZmY3US9N?=
 =?utf-8?B?VlZXYkJGSDI5NzBWcXJlenY5MGxhWklhTS92UWM4cXU2TXVaeW0vZGZPcUsw?=
 =?utf-8?B?SmtCb09ZNnZ1VmdQY1NpZFpLblJHeFpQYkpnM2ZNMUszOFRsNmxoa1NYWXNY?=
 =?utf-8?B?TFZMZjBGY2V2TzIwVHkrTU9kVGpuMmhhN0ZrbEd2YXpKci82SGM3S0hXRVlo?=
 =?utf-8?B?VGlxSk5OcUJuTXprTmJJVEQ4VWVwaER3aDl0aXNscUZrMWk4ZDBhalZ1aXY5?=
 =?utf-8?B?TDdiYjMvdjBkN2QxWW43QllmRUh5dE52VkF0QldYQklWK2VDY3R5Rm8xMlVL?=
 =?utf-8?B?UE42a0RBLzZsbTdiTWgyOFBPd1k2K3JjZ3BEY3ArT3grZ3RwKzVISTZEcElO?=
 =?utf-8?B?bkNBUHBUaFRTZHhiSEpoc28rWDVveTRmd2xoM0hpUWMvVHRmc0sydzVGWjlU?=
 =?utf-8?B?VU1zVVpESmR1R3VQdUV6NDdaNXZqbW16UVRlZ3diOE5Ec1Z1MFR4djI3K0xl?=
 =?utf-8?B?dkxkNEc3QjZNdWxmSStIUWY0K2Rxc1pyN2FhdEllZnduYlpiRW1iMk9JMWdt?=
 =?utf-8?B?U3N0UjV5YU0vSnZvc0I5anFkK281bmVCa2ZlNDMwc2Nja1VhRWl5RGVVQzl6?=
 =?utf-8?B?VEROem1rWDZrMnQ2M3BHMXQwSTRWK2o0NUN5dC9wMUtaWEYrTVBMNVg4Vk51?=
 =?utf-8?B?SEIvdjlzNmU1OTZKUDN5VG42V3lGRHNWelM5WWV6YzZORU96SDAxQXdSN3BH?=
 =?utf-8?B?dEs4SnFVQkc0VFBNMG55aENRLzd3Ly95MWRpWE8wdW5qUDlubHg0RmdSMUZR?=
 =?utf-8?B?ZlhpMlB4RVQ2YklxTTVwSVFyL3dhSE1GcWszcHFuMHBwZHlEUmtBdXF4d1M3?=
 =?utf-8?B?SXZlMVdMMm9rRUFHTGFTRkRMcE9Uclk1MTJhM0ZIenZJOUpmcmk1SngrZ1dw?=
 =?utf-8?B?cjZWa1g4K1BYd3dqSnBTRkw2alRBeWhxRFBHaHQvZDA5bm14WTlJcjc1OHhp?=
 =?utf-8?B?WUlTZnZmQkxmcm5qZTJaeStid0MzSnpMZ1VrclZMSEdpN3FITjNNWkNqbm9w?=
 =?utf-8?B?ajhHNWlYd0M1SEhBaVQ1MWZUS3UzMDdXenBCWVZScXkzRE5hVVBjTHMwQmt1?=
 =?utf-8?B?aDZLYXp3YzVpK0pzSFdPN05OZlpXTzluaWRqSHVJeFA1K2U0dzYwUnVzbTBt?=
 =?utf-8?B?TWVJbEcwNGxIcFQ1WW1NWUtkMkljZHkxV1FxelFGMStKaWlWQ01GKzRvWGVZ?=
 =?utf-8?B?WFZFRGlSQ3RNTlllanhUZndyaE1ESnhqOFp0bmNHcmlZS0NHVmhiYnZnSkk5?=
 =?utf-8?B?U1FHS1RWeXRTTVhFelduMnZFSUJQckhvY3BLbHZkbTkzcWpIeEU3SG9zdTFI?=
 =?utf-8?B?NXdrek4vQy9abnpOQWVDVk9mY29UN0JrVjlLZTVwQzBiYjJOcVMwNTdLS2Zx?=
 =?utf-8?B?ekJ6MVh4TmxUV2lqOHpFRXN4OXpiYWlpc3R4Qy9ZdTh5KzdLekJocEJjdFpH?=
 =?utf-8?B?amhhU0hIN3NQS1M2V1pVamo5a0tPMkpZREFwaHczUnAzUVpZczFxTjRzQWRz?=
 =?utf-8?B?d0lJNUN4dHNLUXF6aFBtMi9ETGd4OC9ENGdML3hxYUdQVCs0aGl6bFgxaFBC?=
 =?utf-8?Q?O1LgZf9vEHXG20bZkAn6CQFPk2QF3atSTPJF/qjIDI3RQ?=
x-ms-exchange-antispam-messagedata-1: kRtUNdMyXlR3oVZQ0j1efXTXnhJ5XvwH+/Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4ACB8F2EAD6B647BBB869E1DAD75E8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBvLS6D5hs+jLg5hn/VbRdZrBOnBC6Us9n3nLr0cW0dduIHH8cXLzmHdW/s8yXxepn/90l265FtNyibLm0Jm0T78Zs61b08P/3hizLz0IrMQTc9aliSUl1RdvwWFbSliV3PlEATUWVKcEbmBe1J47l+iymZlOkCeCOi9n5vGCAvtAeZdLp6i97/Gs5UV7fm/REeVLd4LE7nmfAIwuy9adGzXBvzA3Mx5D2MfyzoMRx1p7STYdFFyz1k5omr9xiNDpPzB1EiSFfQgeJKCJPIOXaIMoH3ySKxSBdffDdTWfOXv/SYXdpiJgfIXH9CffyJ+0lnBywg/vVfZ73ZE+uS4Ub/b0tooPZ/Xc6V1zfueE2HgfTrXGeEiyxsrFH8QQL2izsO5oxmemDG1XUTE5YwhZQYW+I4NpnUoc/5v4W0R9WVQFFsl7Mrd1LQyN4AIIy3MZ9WytXM96bEjh2JMfGrgr6sao/ewQxZGncyFW/ZiSFU1iF1wW/KrCUmRSwDy+WhE09GhaVJ3nmrRv7OuPKjNjxlAsJNZIs94OsgoZwWj1aa9XBg1HHr/OPOQYBI2lOI5C2NeEUvX+MAWmYBiiUapGSba2haTtEkFOOatCas8ZT3wYD1NUD9AWYek5ujoQuv/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e401f9c0-0d92-4e77-704b-08de7a94532e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 08:51:00.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C6U7pGxH9b4XDDGIXNvAh3/nzLHqrUly1Ra1Q1BRtv2qSebRayHlO7u5AfjqQE4a+4GmunKdLPD/aRNteXter5+d1c/YuAIKXJ3DaKzTbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR04MB9721
X-Rspamd-Queue-Id: DB29E20DC3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22242-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sharedspace.onmicrosoft.com:dkim,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Action: no action

T24gMi8xMC8yNiAxMjoxMSBQTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBUaGlzIHRl
c3Qgc3RyZXNzZXMgZ2FyYmFnZSBjb2xsZWN0aW9uIGluIHpvbmVkIGZpbGUgc3lzdGVtcyBieQ0K
PiBjb25zdGFudGx5IG92ZXJ3cml0aW5nIHRoZSBzYW1lIGZpbGUuIEl0IGlzIGluc3BpcmVkIGJ5
IGEgcmVwcm9kdWNlciBmb3INCj4gYSBidHJmcyBidWdpZnguDQpab3JybyBwaW5nPyBTaG91bGQg
SSByZWJhc2UgdGhpcz8NCg==

