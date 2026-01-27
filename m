Return-Path: <linux-btrfs+bounces-21119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jq6AzfneGmHtwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21119-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 17:26:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16497BCA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61CC9322240C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220234B676;
	Tue, 27 Jan 2026 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H3k/Q3x8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eGOh5K4t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE261334C27
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528082; cv=fail; b=IgeNDNktiH3HVd68WaeC3/Pv3LojYtZnFnkuEgTft8T2IPUWZJHGCsujWiR1B7+aKaXFELRN6tEGoGsgKrTU87V3VohqkksE+u8zFQSNm5Fm4MnN/bYpgFznzAuE4Z7VS7gI/pvKhi0xP2mGbYynMQymE+ENWh79W4odcNF37hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528082; c=relaxed/simple;
	bh=2RHUvoyxsWkz0yNLT+7Mirr3I4kM87zTjKogpVm6zNI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0rpwhvDylMM27EFJ7idIZ5SP8TTL0CU2oJ0WF+u4c5f30XraqgpGn23COoAGKlPBUjy8JQiVoYv3w3duWPSoeHnRDYjuxnv7BvAij10cd0ZYkT3PkdqEz6x8lSixnEkd9dahEVJxPispw9kpIbPzELhv1VwMEV7dfPjXLZ3cRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H3k/Q3x8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eGOh5K4t; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769528080; x=1801064080;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2RHUvoyxsWkz0yNLT+7Mirr3I4kM87zTjKogpVm6zNI=;
  b=H3k/Q3x82NEO5bxz0GJLRIZA+i7rXar2zyqxOynTbmIvh4hvFef1xoqW
   hy7BmT5dRIkdf9QqBzPmKOOiBTr8W64j4GnDgqBugdsyTV0zodey91Zin
   cg/hm405CXhVXNLMy7hg0qF2ibdEKXRy87/iAmotgYJWSK1wZj/rT36Je
   Z1GdXHDQ9lNukl86AwzqsPEp9fglgcIFkzlZseBCBEp3wdZNpdcny87i+
   zxYjWqU4BM3Ybb+H4u5+vN1cBtD094aHKK0NLivwqtRegPY0YRIYGJuT4
   MWfrZjNzvjXJaTjwsWCkXpLqNAyWmEHBva3lwU75w65JPhKgC7oIrceE4
   Q==;
X-CSE-ConnectionGUID: iQhvcnOeTYSNatsOS5ycnw==
X-CSE-MsgGUID: Rr+WgwYUQnWrnCXlrOc8yA==
X-IronPort-AV: E=Sophos;i="6.21,257,1763395200"; 
   d="scan'208";a="139568938"
Received: from mail-westcentralusazon11010049.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 23:34:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahBMrdyK7eSs8A/LQgqCgoClladUTfPAnsVL3hWfqv68o/tPIxCUPLBgXee90+I3+uyW7ijv68gZ2RH+rmmel3/V+MsRKJ3SzKQx8BQSnzVxvxl91NObc3K/p1eRwLL8PmP7yEJJJOHP4XpwxE81Sa3YZ5hLbmGue1Sohkt34Op1RCKQZlb4JX50nhrV9cFmo/wYHwDieIZe6ngysDOnjQ8VVd1co5uqAiRSFo1o+4SgGVQ2GNQrlV0IBEkZVdl+LM0WHBjQ83d7Fn4h0G1sFfPrFY2MpZ4a7P6G4SH8Gx1Vct4cETeA4oAtlc9QYpa8brWtzt0fWr6h4eRk9FVNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RHUvoyxsWkz0yNLT+7Mirr3I4kM87zTjKogpVm6zNI=;
 b=jiCxPWjxr8uiVvN+kNLi1YjkpxmgLf9n5IEI7zpZ7GDGq6ETWtDCXzjRTKYi5pg310menSpTgbp6CAr+LgwZiZclq/GUmFvNHl0QR7Bf2ht7KE8UiiE3v8xeWhCi5kWuOyMwUHvaIRr5ffuyd2BDGDo7k0mvDs+UD3r5N07SK11gsRAFxBczYvqlxBpheeesgbwIs7SMDfaZKmrT4i6P/Eapt9KAFmQOkH+QXU6lAqB1aCNN6RHZHTpawhk5JcDthevL3ABMbp4c0C5arHmDKHglfSja7d79z/2xQRZgfqEOOikLqXrNzP0U3mk3LRGiJhH8dDzrd8hIoR5GTEm5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RHUvoyxsWkz0yNLT+7Mirr3I4kM87zTjKogpVm6zNI=;
 b=eGOh5K4tYnFrCJ7FdFEWFku1s+uGMGww9szi8MrASn/+aS3x2aSfDwPbVMklo48GshtKbpuwUHCsWwwllS/LzNKmGTV5icoDn14t9n+7tLpzAs0FrSAL+HBJPhblUZXCohdEkw7T/nW0Nvf/wcoTa0h7Mt9Wlc6axzIk/tXtvBM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB7861.namprd04.prod.outlook.com (2603:10b6:8:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.8; Tue, 27 Jan
 2026 15:34:36 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Tue, 27 Jan 2026
 15:34:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: unfold transaction aborts for bg delete and
 get rid of a BUG_ON()
Thread-Topic: [PATCH 0/2] btrfs: unfold transaction aborts for bg delete and
 get rid of a BUG_ON()
Thread-Index: AQHcjFG/pF1CoNOBck+t7kHrWK2IWbVmLD4A
Date: Tue, 27 Jan 2026 15:34:36 +0000
Message-ID: <bb472ca9-bd88-4f48-aa52-412f6442a060@wdc.com>
References: <cover.1769163248.git.fdmanana@suse.com>
In-Reply-To: <cover.1769163248.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB7861:EE_
x-ms-office365-filtering-correlation-id: 512a1288-a83f-4bbc-c697-08de5db993f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|10070799003|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3RDcUFZVHEzQmtDZnByZFJqU3FCWStQRExqbm5mV1IwRzBKMmJjbUlNbUN5?=
 =?utf-8?B?QW1YY0VNK0N5cGYrYnkyQjNHVlFjN0tKekhrbnk4MzkzWnhHeldwWDZaVlZG?=
 =?utf-8?B?dmdUZUZFeVA3QnpTaDVoSkNHZ2xDdEFrL3c2M1VFSVdmQnptTWExTlNFYnZo?=
 =?utf-8?B?YUxGVlVNZXdqV1hRa3FHTG9nY21vb2E2UUZyc29CTC9SbVFISUwrbjlhWTdQ?=
 =?utf-8?B?amVKSWdjZjdrblNVbTUzVDlkZERESXRLcWZTVlFqVDZYTkxROTBFMnZWaFov?=
 =?utf-8?B?aTA2U2o2Z2w4TFVPL0hKNkdsNXhLNTQzdDRFVVVUOFp5VENvZlpzcVU3d0U2?=
 =?utf-8?B?UXBEb09GY0lJZVhUSFdnUlAzOVJnRjduS3FsYXZZTk1Bd2h2MjZTelZUS2Rs?=
 =?utf-8?B?RTZka2V0VXkzY3F5aHBLaU9PNUtmY3l4TmZnelFhR1A2b3Y1bXp3MFIrZlMz?=
 =?utf-8?B?Yk0yUms1N2lNNlowdFYvY2lqWU9raXJnWlo3QU5sOGtkS1ZzdGF2OUp4allF?=
 =?utf-8?B?d08vQ21kOHFvd1RuQzFMeHMzaGhEQ3JTWDVaWWhVNTdhS25sVm1sYmw3bS9G?=
 =?utf-8?B?b0NMZ2xRclJVZktjbHZQTkZJMUlGMWRTOGEyMkRMeWloQzZZdG16ZmU1LzAy?=
 =?utf-8?B?VGdjdXpqMUZMS2FNUGw4dmxId1gxWC91RGEwWW5Jc0w5TEVVanJWVElDcFBj?=
 =?utf-8?B?REVsbnJnckxDVnRBbHp6WkM2RjRlMkF2aU9DLzlYeFg1a29POXJObGJKaGFr?=
 =?utf-8?B?N0REdUdVdkZvOE9SdFhWSTVRUEJZaTFoYWN2dktzN2JqM2tzektzczhBaUg5?=
 =?utf-8?B?S1BOZ2lSYVRwcDg2WmVwMDBJTG1Pb09CeTFtSmYwM2s3NlZOc1hzUmxVUXVV?=
 =?utf-8?B?VHZsaGVVYjBMUW9xdUltM3E3SS9ELzllQTQ0UkNkR1BDUm56ckZhRDVNNXlK?=
 =?utf-8?B?T0VhVFRZOHVYU0J4MUZUSUtjTC9zQWdqYmxHbDY1R2hXYmU4eTROaTRJUmdH?=
 =?utf-8?B?SlJwZXZBelRLMEZISlpwcDBLYWVWUEZnUWN6TFZ5ckI1dXp3dVNxckF1RTlo?=
 =?utf-8?B?cXhhSHRBcTVlemVETVNnV3p3SU5MZmV1UERnTXJja1VSNkxLS2lhVmtlL1pB?=
 =?utf-8?B?akpneS96aWd2Q0VGOXNFYjRlQS85OUUwcjNFa2EzU3JpZjUrUEtzVkdTOTNY?=
 =?utf-8?B?bWRZOFhyUFBEN210bzJ4TW1BbGNKdXU1aS9LVVBJNCtsUmIzNEJKUExpR2JI?=
 =?utf-8?B?MWF6ZitQdWlVd3BIU0FjVWZKU2FqcGRHWUVrb3U1MFY5WGhaY2NVamtyTG5Z?=
 =?utf-8?B?ellhVUluSXFKT1RwS3dxWEFRQmVOMm5hNnVQdmhFUGdwd1I3VGdlOERuc3RQ?=
 =?utf-8?B?My8wQnZ1Vy8xbUZHR2pONE5YeG5Db0xHZVRYTENISUkwRGNzTmVxOFdVTFh2?=
 =?utf-8?B?WmIvSXFKYTIrcUsrUGNYQ2U3ODRNc3FQQ3JYVEoyaFdKcVdOWkd1U1FvYzky?=
 =?utf-8?B?Sm9RSytSQ2lmTUt4K0ZTMExwL0FjNnlzcGRyeVdzamdJK0FpREVTd0FINnRY?=
 =?utf-8?B?N21HNm15V3ZPYWRVYW9hUHJjWUFSZFc4Q2V5OW5EOW9CbVpaS3hVVUxrS0Z5?=
 =?utf-8?B?VmVKeW5sUmFRVTFMU29LRGhzVGJsUFlSdTBLVk5UdVZsdmZlN1JIY3Y5dHJn?=
 =?utf-8?B?OVFPc1hwMk8ycktxQW5kaGR1d0k1dFNkbklCVnJENWV2UDIwK0IwY0Z2Q2pY?=
 =?utf-8?B?ZktxT2JrWHluZnFuQVdCd1N6WkZtSXh2ZEY3N3h1bXdEWUl0d3N6dkNveWV6?=
 =?utf-8?B?dmRxTmtzaU5OSHBKTG0rNTlKeTU3ME51bHlSZnhDdFBmeXYwcUtlRXdDaEo1?=
 =?utf-8?B?WStvelVQclhqc3VGYTJhaDRwU29TTUdVMFZIVXdZdjFnTGhGZ1JMZGFONUFC?=
 =?utf-8?B?QUpUQiswNXlVVEIxcW9LL2hsMXZ6TTlEQ0JJY3Jhd1hDeXBiMWRqYzJUSU81?=
 =?utf-8?B?WnI5dUk3RjM1S0ZtV3gyaFVnTXRNYzEzOEhISlh4Zkc0Q3h2aGlaL2JLS2ZF?=
 =?utf-8?B?V2FtbS9vR3crSkltbzYxQVBoZHhnYmE1OVlrQ0FaQUJyS21hTWM4M0U4bkVL?=
 =?utf-8?B?YkMxWW13RG0zQmx4eUI0YXRRUExjYndiR1I2RTBSdzcvbWdJRXo3T2dtODZk?=
 =?utf-8?Q?JVfTwwZTeWVvf1qaxZoPFzo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzFQSFlCYTRWL1Ixa3YwTWJCRFZld0QrTE1scnNuQWhtRnZrZjFMRjFsZW5R?=
 =?utf-8?B?VjRFV0xyZ3hWS3VTaWZJZWtBdmtkL05rTkNQbG94cXkwTHlZZ0RYTXJnQlZJ?=
 =?utf-8?B?MXRDakhkMDUyN1l3dDVTZmhEUXBMRzNVN2EvNGRvaUpTa1lQVFNDSU5yNEJN?=
 =?utf-8?B?aS9BeUdseUhTRFpJWVlMejJDRlRSUkZHdkVjYzJuYTFsUXBRUGNPNVNobFNO?=
 =?utf-8?B?SnkySTVjeURyMUFTTVFCNUZmZlNuZThSeit6ZlVIamtWRVQ3dEsyamRBSTVK?=
 =?utf-8?B?Rzh5UWxPemlMMWpleEpZRzg5ay9ETlo1Z0dRbjhmUzRWWU1WaXZ0YVpwLzhX?=
 =?utf-8?B?bSs5bDdNN0JpZWZmM29QaWtSaUtGNm9sbmhHYk0zRjRiNjgxbGszYytQME94?=
 =?utf-8?B?eDluSERSYnFPdGRsT3k4QzJMaXJmbTZOajMxNWlhOEk2VmhkVzJYNVBlVzlJ?=
 =?utf-8?B?aURsaFZXcGRkWjlqeG9abU9rUTBBUUF4Y0V5MU1hSGloTEZYSVhOb3RFQmdj?=
 =?utf-8?B?NzVneWwwNDg2emZEaGpWVnU5MjVIR29jNXNPcmYxUFRyK3ltYVZtcG1xOHdN?=
 =?utf-8?B?VkJYU1hCY3J4Yy9BemVDeUl5Q1htUkJERUQ3TVc4WDQ4WWxTN0pHSVV3UnRZ?=
 =?utf-8?B?NkMvc1JvcEtLYUMvbHJEVHZjWmpEZSs5bitDZVN5ZjA0a1BDUmU4dzdPZHVJ?=
 =?utf-8?B?R24xWHEzWk0xb1UzMEUxRUp5UkNKSjhlYUw0MVZOMnlxU2E5d3NJcmdQUlFN?=
 =?utf-8?B?ZzZ4bEplQkZyOERncDNpKzc4azNLWjI4MlJibnUzeUl5K2JMUHVROTJoRlFJ?=
 =?utf-8?B?TWpiY1NZbUsyVG0yTkJjQkJ5Mk8wSDdQblg4cUFOamxmMVlPQnp2ZCtON094?=
 =?utf-8?B?S1hmVE15cXVaVTdwNk0rZmRUTE9Dc0c5V2xJbFJuUEwxeHk4L3F5YWlqWDRX?=
 =?utf-8?B?R3dtMWExcDJkb1AxMmV2NzJjV2Q5dXp1TEJjZ2xRQlN2Wlg3eGJsZ0EyTktR?=
 =?utf-8?B?T0tTYVR1eE5LSGRGTGJnRm45SnR4Vm0rVXNtMmQzY2RtamdDem04bmtsbDdR?=
 =?utf-8?B?SWFLZEF0V05FVmdaM3F4U1RldnA0QXBUcC9wcVgweE51VjMzUkpuZS9LWXpo?=
 =?utf-8?B?Vk83Y2lySnpoZDdjdTA3YW4xVVJxSStid3dFbTgrdUNpcVg4Kzl3R1ZmNDhX?=
 =?utf-8?B?cHVrK3F4ZnJCdTc3UjRDM29VU3Jndi9laXZzRzgxSGtzL1RZWWhxRS9HUDJr?=
 =?utf-8?B?b0RWbnNiNXI3ZktkMVUrcGNXRTJ1SXpTWkFmZzhHT2dTbmU4S2I4T0plKzkv?=
 =?utf-8?B?a3FuU0pvWFhtcm1jRURSTjgzcnk2TXFHQlFLK2FMU2VEVnd5SWx0WEdHVGJS?=
 =?utf-8?B?MklSTVBSbUVBQzNWK2hHcmpROXE4T0R1eittKytsTkljTU5kaVk0a3p4UkFt?=
 =?utf-8?B?NWdSNjRBTVhWemxJRWdYSUxaWWVTWk1kTk5RcXhGWVBKTElnMnViRmVyK2NS?=
 =?utf-8?B?K2RXazJCVnFsYWJNSTlDQm04TG9FTHFaVXVaQkRhb1JFdVFnb05aUW9neVNV?=
 =?utf-8?B?UDFrN2dHblJ3bGQ4d2dIZ3ZucktyRFRaZ3RkYjQ0QklTK1VaQVIwdThMbEVZ?=
 =?utf-8?B?MUtGNEJUU1BFTXpCMkJ5Rk05Rmw4WmlvbzN2VDdoZ1cyMFo5dGZ2VmdYNHRn?=
 =?utf-8?B?OUJFSnhSV1I3bWwxb1I5bU1CUE56R3ViZDVUMmJOa3F5VTBBV3ZPMmw1QWx4?=
 =?utf-8?B?aGFuM1JQTmFsaGwveElYV0lXOVdZS0hOanp5d1laMmRCczdIUENQSEJ4eWM2?=
 =?utf-8?B?NG40OXA1SExjUktVTmRCcUJsdG5xaEx1a2RtSHpLS2d1L2VYSlFyOWZYQmti?=
 =?utf-8?B?WXZLa0w3dEVkMmhnL09rZUtTQjgxT1NUMHVnRmNEM1J5VFJCMG9WVzlCMTlk?=
 =?utf-8?B?Zlg4M1dRckt2dS9MV2RDam96K1E4aHQwR2NFbW16ZEw4NlMvTDBQR1ZRdkZE?=
 =?utf-8?B?eUNzU0ljSUVEWlkvdk9Nak1uZ2lmWlZPUlBiRk0yVlRJWUtqc3ZiampQY25i?=
 =?utf-8?B?WndDS0pIUUt5RVVQL1N3RVFZV3NIR1puMkRSMFk4MlFxK0g3YW1MU0xBbkM0?=
 =?utf-8?B?Vk01RktwTGxJVEZmUURZZ1JxRjhNYndXZnY3NXJJZVUzWEdzVC9adXVIZGxy?=
 =?utf-8?B?NHVvQU5JSFpiZklQWEhiUWdxLzhjZGtrdGJjQng1b29HdUlPY21MMDV1enFh?=
 =?utf-8?B?OTJ3WVNwWTNqYkorMktDbkgvWk5VcU5VcUYxMlBiU0liRTZEaGFMdnhSVjBT?=
 =?utf-8?B?ZFJ1NmhSay93WCtwbUplT0d2QzNQYXlOcVM3NWZZekZScGNISWFMenZ2eUVj?=
 =?utf-8?Q?Fc5VGt1q2lzDrv4GA40fTMe5j3FbQGfh/4vigc6hWTzDW?=
x-ms-exchange-antispam-messagedata-1: exQVDs3VeX403etjQx7Nn71wDOZKMhtdlig=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4756CB05FBB36A49A55C954AD39DCF34@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/IZZlSMh7jHEd8lxI+IIB1PfcytqjmpPy8Qh2qd4qw0mV8giDSwlaANwWwaGhOQTktoeQ9K9G32YXundW5OWXlz0Y12xjPm5+ZkeccGY7EDF+PtU+r6HBS8YJkfSEs/Sp3k7Mcb/2lRWCLVH+lEKibdZ5CLSHI9ffUDbC730nwAOdvTSJ48adZPhaSNNSGQdX6n1BWqNovsnRPgx8FN8L+7fS8Jdvn00jzHvcI6ECBBFDAdjhrOBfonno72luLzkiOGWz3XwXKldPZMekRTwEsj/dv3/i+4F/39/DTHP8eITxZxL6sKNAB37sZGSwiU8ldUkENsbAy+fOlAaePpt1l4aBSK0i2rf7KZyfzdtxHS4Pv6T28Rgf4EvK/jrKhwAw3qXbiUQBKXeClwk3O3xUsTwQR8jD5C5jShswgD1+v701o9h5wSzimVDrrrsDNH6a2C46wZMEtG6z2q2iQ4vJsSi8wTffMYPe2oNpsmZDYLfou2i1AQQnHK/jgabiuLIXwZw4zCb6joaWxQnGQJkLiQWD7gaIn7wp8U75zF8u9XpcMG/DIhAseHsnxaEApMxxnhYrLuw3Lj96ucuoBK8Tw8eqZYXfMPWvTN/5dTDcbVRqL5d19DYkSRUTEYt/pjv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a1288-a83f-4bbc-c697-08de5db993f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 15:34:36.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8WsL2l5HJDwrk4t5tvnCuG65zrzcemmBOzvBQ0qvAofk/vd7SUojcHbZHBFQ9iprJQKdZ5yeynWVxeQF5/UJr70KJIVAw+B0tpnHSP4zoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7861
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21119-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,sharedspace.onmicrosoft.com:dkim,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 2F16497BCA
X-Rspamd-Action: no action

T24gMS8yMy8yNiAxMToxOSBBTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IFNpbXBsZSBjaGFuZ2VzLCBk
ZXRhaWxzIGluIHRoZSBjaGFuZ2UgbG9ncy4NCj4NCj4gRmlsaXBlIE1hbmFuYSAoMik6DQo+ICAg
IGJ0cmZzOiBhYm9ydCB0cmFuc2FjdGlvbiBvbiBlcnJvciBpbiBidHJmc19yZW1vdmVfYmxvY2tf
Z3JvdXAoKQ0KPiAgICBidHJmczogZG8gbm90IEJVR19PTigpIGluIGJ0cmZzX3JlbW92ZV9ibG9j
a19ncm91cCgpDQo+DQo+ICAgZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyB8IDI2ICsrKysrKysrKysr
KysrKysrKysrLS0tLS0tDQo+ICAgZnMvYnRyZnMvdm9sdW1lcy5jICAgICB8ICA3ICsrKy0tLS0N
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
Pg0KDQorCWlmICh1bmxpa2VseShyZXQpKQ0KKwkJQVNTRVJUKEJUUkZTX0ZTX0VSUk9SKGZzX2lu
Zm8pICE9IDApOw0KDQpsb29rcyBzdHJhbmdlIGdpdmVuIEFTU0VSVCgpcyBhcmUgYSBjb25maWcg
b3B0aW9uLCBidXQgSSd2ZSBjb21waWxlZCBpdCANCndpdGggYW5kIHdpdGhvdXQgYW5kIEdDQyBk
aWRuJ3QgY29tcGxhaW4uDQoNCg0KQW55d2F5cyBsb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTog
Sm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQo=

