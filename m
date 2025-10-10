Return-Path: <linux-btrfs+bounces-17609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D2BCBD42
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 08:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1279A3B423E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4D26CE2B;
	Fri, 10 Oct 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UbZHsRVc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HCocvNZw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE353211499
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079252; cv=fail; b=l0SKJzuRI3zTw1Z4y5vJoQIcccNGqXdWoD3p9/gSoCObZDsn+nrWOZu0LzID6GTERUEa46SS4cFEIP3oSVEZcf9sCXh1cXpmcHicyRjg2ZFr/Fg5Kc1bjoviMhiwPhtKUWMoejsvS0+5wNeqT/SodmSCkkZeFGQ5zK3vMVIcChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079252; c=relaxed/simple;
	bh=FT9iBE2SfjMtyY9bsj6rdtND/6qmdyG66a5DF62jgjY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvCU0YuieoR/0J6XP+EQxZElK3+4imlx93JBBgwGeI8f+kpCmIQ6wi0FgGKSBu2UWKEj8Y8m+U1EzlI28xkykRak7FNCcl9xhVrUyu90nACab8fuFGOONfO7fV/aAahVPAZSxpceeA5piqBbDTZfCCjr/ARRfIbVG8q8U3z/F+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UbZHsRVc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HCocvNZw; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760079251; x=1791615251;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FT9iBE2SfjMtyY9bsj6rdtND/6qmdyG66a5DF62jgjY=;
  b=UbZHsRVc1fMpYP/ZgLayyH8QppTynotf2p75fndl7IHTygBzQueBV4a0
   M+hVZOqF2e58S+NjnUmKLpddpFAns612Y2dVOjO2/ZBnnI+p+61aCodmh
   1uXecd3UQHyjm6sgZiE8JvqWWPffIRaFD0x416hxra2aj29fxwkKpdVoi
   jkFWVtSBmOOgaHoR2S3W/JhV2ERREYbN58nUwrqC5t1A+lwadjU53t0sW
   kqdXChodn8TbIip2mbq9aP2x9weJ49ePNNiOnhLZM6g3cqCQCuj+Nuzin
   mR2ePHqCNFIhNNskIyLzUFbA7MsRwOB4wgA0NLtj7H6je0ANDlZI/Bv1S
   w==;
X-CSE-ConnectionGUID: oJf5u4FlTxyBaIg8DSxWlw==
X-CSE-MsgGUID: A33I4XJoSg+ed8UE9YqfwQ==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="133906409"
Received: from mail-westcentralusazon11013011.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.11])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 14:54:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKbiIVQTpKYTYk+wPoeP6kZZFNZnqInCZsW2rch9T4C7dr26yDnWs4LTAjPZquQcn8lbgVNSa/Ocl2RS0/rnrqXlL5lmCV0Mbbmv5uCwLSCwRR9jnfn10woMrvnu9Rpak8NMLRGoVCeq/6x4QWLBNhiyE3YRw9eU3UVM9RTRKX5Z70rLL/FbBRXnXIue2d/KdOi4Elkk5MNVIlJgsMPTuvXme37OYrKSH4iLyvc4khBDhOm1aMldlLlXWernKL+4BBbs1vRQzDxqjdQhHXmuWZJVuwik56H8X8V8PlLMdS1tOFKZUvtsSs1rxrpaNpV74eqNu+zfjrburf/rE4PE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT9iBE2SfjMtyY9bsj6rdtND/6qmdyG66a5DF62jgjY=;
 b=RNWSslHZ36ol/eFniS99o3bH7iOc9ZztBj0sW30wPBe+KhjHMZOkONC4vfBE7mtt71uoo57jIeOgYrJBe2MjWFeZmz1IYbrxNbCDN79YKzn6Fve6Bil/3AiXAp0MvCqSnVzPzeuoNFB6eanYeYF/Me/hgh9SPiuTeQI6LHivaeYHjUP7WgTVp5fhEcbtyxOKr5duTtSyiZ2Ct8uOIwF5QwUWycC4Lcqg1pR0ow0EPPzBt9bEUz70d4Ywkef6VxRSx3/8XQuft2vrHnFPjph9YSBav0FSBhXFyXhSo7Zu/aGq8E+jZBLPzGptEj5McgmugaNgnII7zT7SDgv3uBjKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT9iBE2SfjMtyY9bsj6rdtND/6qmdyG66a5DF62jgjY=;
 b=HCocvNZwEBMO6AWsGGg4s1xlI/UI5MQuuu3mXUtWHQUpzcJJIjeFOZOb6V386oeRGoXaRpH9ufSssndPXQkzgw/b84XNu9Ib5JcS9mt9WM6XuKY0/imw6vMtlULsEnIjxbfrYIi3GuE2izy4jiA2iASxa+d3Io7T77daexpbKis=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7606.namprd04.prod.outlook.com (2603:10b6:510:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:54:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:54:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown state
Thread-Topic: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown
 state
Thread-Index: AQHcOaLmJ9bu/9pWwEey6AP9xgmet7S68hCA
Date: Fri, 10 Oct 2025 06:54:06 +0000
Message-ID: <56575026-9cc0-4ca9-866b-06ec115197cb@wdc.com>
References: <cover.1760069261.git.wqu@suse.com>
 <4c244c7f13e63941f3c366867264c50d4392a8ed.1760069261.git.wqu@suse.com>
In-Reply-To:
 <4c244c7f13e63941f3c366867264c50d4392a8ed.1760069261.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7606:EE_
x-ms-office365-filtering-correlation-id: 1fc80d52-7ec1-4985-b933-08de07c9ce21
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0RaYVlhUTNRMzV2eGp5elkwSFFuaTdjS2dHUVlCdnhQeElZeEx6TzFHQlVm?=
 =?utf-8?B?OUNUMFhvYktqelBkOFJsdjVCK09RQzlIcnJtUWJJaWtKQlZnem5HcFlONDFs?=
 =?utf-8?B?VTVPYnFsZDJIUUZCckM0ZVdXb1RwaVZjMmNHK2s5bGhWVDJhcWpCZlZKN0Ny?=
 =?utf-8?B?UUhQaFhZalI2MEpuOHdIUG1ySVRBYjZJVStJT200TjMyN0ZLT2ZGNXVqL3Jh?=
 =?utf-8?B?QzJKeEdmVGcxdXNnYmhjTzFINzNlY2tMMDk3ODdIaDdySVRweG11bkFaVkNM?=
 =?utf-8?B?YnpzYnhqY3RrRTd4Rmk5WkZlaDBhRXhUSXpXM3dCZzlWUVJ2R1hQNTBNWWpF?=
 =?utf-8?B?WXMxOEtlMVVpWnREYzlsZnpIY25BcjhIWUtHRkNqME05YjhxeTFkeEk4dEsv?=
 =?utf-8?B?RkpxSEZySTMzdGQxd3BRYVdFTDdBdHcwLyt0Zjg2dzlxNlFnVWNuN2l4QXp2?=
 =?utf-8?B?TVU5K0drVEJUeDNncUNvZGpscUVrZUNING5nVkd6aXJGbFFpa1R1K3ZHbkZJ?=
 =?utf-8?B?dHVaVDhqM0hPeHR6TENwWFVocHZ6NExIR2lVVzZMZkQyL2lBbmJVb1hyY3F5?=
 =?utf-8?B?RUwxbFlKbzVUTmEzbnI5ZE9iS0p5UCt3ejFkQVFzSlU2aTE5aEk3dEdLMjF0?=
 =?utf-8?B?b1czWDcxVVBtWmJsVnpxcTVML0NZWTUrRlhZU1NWZmpRRjh2L1JSWC9ROC9R?=
 =?utf-8?B?Q0d0YVRlL09wVzBZbGlDRFpGeWVMWDdQLzlSQTJOSU9NVytXTFpWWnNQRm5T?=
 =?utf-8?B?YnFISUFxMkNBbkZBVE0yYkpnV2ZBNG1KTkFqVXlEeHZ2c3BUUDAvanl5TFdV?=
 =?utf-8?B?ZWg1aW5Ia3RPb09yMnc4bnF2RmxsQXNMOERFMjlCNXVvVG1hSGlvaVpQSGNO?=
 =?utf-8?B?VUJPdTBkOUYrcFYzYXVXQXc0ZFNmSGlkakpseE4wakk4TG5lNjlzQjJubzhr?=
 =?utf-8?B?Ujk0OG5NWHR2QnZjVEFKWUxVZ21tRXYwd2RhUDErenpoKzlNSHg5U3pFSUNm?=
 =?utf-8?B?dTQzaUd4KzZwN1hBeXZ1ZnhCUCs1eGUyV0o5bzN1Rm4vMUM1Sm81Y2FITlJC?=
 =?utf-8?B?VUZ4a3prblJTanN5UE1MYml5OTExVEF3SzlnUVNNSjNybEFHektYTDJHMXN1?=
 =?utf-8?B?cUhlMGN6ejF4TWlxakpXYXE4RVB3YU01VTdOS21CQ2ZaQzB1MkppY3ZFbHZH?=
 =?utf-8?B?WmlRWW1lRlROekpKTmVwdkhMM29MZGhoQnB1MndvMUJEK0RMc0F2R0NsNnNs?=
 =?utf-8?B?dHdGNy9JN0xodFdiRU42SGRIV2VXWHZnL01zamlTR3hpVVZKZjhXMVJuQzFh?=
 =?utf-8?B?c3AyWkFmRFJrYlc1R3BiMFN2UTNoc1FVQTlYYmxjaTBxVjNZaFlCUXIrRDA2?=
 =?utf-8?B?N3kxMUx4YmVlallMRWZwTkcwd2szTFhoL1BtNVJvakI5WWVBZEVUeWJLcDZY?=
 =?utf-8?B?TDAwdVdNN2dHK09KNHhGSWxBaGVFbys2SFd1V1JEYm9UbDFtY1VXSXJjTXpC?=
 =?utf-8?B?Q2FkbGR0Tk13S3FXMW1lZ1VxU2dCS0FBU0t5OG1pejFDQUFIU2VVcy9MSWR4?=
 =?utf-8?B?QXNjbkVOM1lET3poQ0diUktiMTE5bFZSbGExZFF0M0hUWjFSQTQwdE9CN1k1?=
 =?utf-8?B?WjloL3NHRzNkL1Q1NlZCUHBHZWNZTWc2aEt4aWhkRlBlb0Z0U0RFck9nOWJH?=
 =?utf-8?B?WEhlME03cHNSZlZ6cVQybW41bFNncSttNFZ5UkxMTSs1UnpTb2liRDl0QWZW?=
 =?utf-8?B?RjZjYTZ3cjFFNGJGUEV4ditDTnNwclZBV1BHL1pVRnZ5QXZnQ3h2clh0NHJw?=
 =?utf-8?B?M2R3M3F0S2lydVNFSE5VTTUzSVVZNGlDQVlMeXdkSXNlMmk4dWdhNC9TWjUr?=
 =?utf-8?B?MWxIcUhvQ2JRdEZDaGZZSkphMWkzQUNmb1kxbG9TeEhmQ3g1TzloM0QvWW00?=
 =?utf-8?B?alJJckltazI3V3MrS00vWDBEaDdUNFNOMlI1a3FHL0wzQlFpeDNSS1g4QmRz?=
 =?utf-8?B?ZEVzeFFBRnhtTnBQTWU5QU0vcWtmZFBsNXpPMzRuS1BmcVVFTmdBZ003Wjc3?=
 =?utf-8?Q?nkwtao?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW9OL2tTb1VJcFdXL0hUVzdCdXJ1NFBaNVZYcFBhNG5xaWlSaFBlbEhqSkFG?=
 =?utf-8?B?RWNDSWh4TXNMRWQwN3FCSTlOUmdTU3BKSmltQkV6UmhFK1BQNzRwME1Wbi95?=
 =?utf-8?B?eFU5RU9PL29EZlVvLy9TbHNXekk2SVJKVEhGa3pFNjgxNHgxZ0tJZGVKM3Fm?=
 =?utf-8?B?c2N2L1dhTmJ4d2lKN0FCSVlxeXBaak5nc3MyODRNcDdYdjRUaVNMOTFESEha?=
 =?utf-8?B?RWw0dCtqRk5wU2NvRzdKclBYNlVjbStheWRSMDR3THJuYXI0azZ3a1VSeGNN?=
 =?utf-8?B?RUZCUDNkS1hCL0tKWmttR2k0VC9BMWtxSHl3eEdyUHhUOXZRa29mUjFnSS9q?=
 =?utf-8?B?SXBDZUVXV2FPdkUyYnFsK0pYb1p4QzEzRkl5Z1ZTTGpNZDJXMlRMUnVVY2Fx?=
 =?utf-8?B?ZEhabGVDNTR2TGFUb2ppQmU1a0hrSUNjaElReG1XU3NwU2E1aTdzQkhJcThB?=
 =?utf-8?B?K1FpaG9RcWk4amtmVVA1OVNsWFNzZDBQK0FpUXExYmxHMjM3cStIYmwzb2Na?=
 =?utf-8?B?NDVQcHVvT3FlL0kybmdQOFFldlZwdm1SRThZY29lUnpHK0N4cndRSk8wQ3Bm?=
 =?utf-8?B?VHNDc1NaM2RZTjVCT25TdlRVUTd6QytReE1RSFR3VDJlOTIxZTdUM0tmWVFl?=
 =?utf-8?B?NWZmU3FKNGJISWlFS2xxc1hMY2lrbkxjS1Z5UFZsMVBydEhjSjdIenJHVGQ0?=
 =?utf-8?B?NkVSTUNSVmpkZER0a3FHWkZJUXFiUlJDZTlVRjRZNjhXYUxDbnNwRS9NbUJ6?=
 =?utf-8?B?WVhJVWJOL28zRllVY3JoK0Q1bTZPR05rK1RQdDZjK1JDTTFWeXRobCtjWUpp?=
 =?utf-8?B?alZEK1JjRHhZa2hSM0NjcDdoK2p6ZlhFcUJoeDIrb3c5OWtiMXVkMERKNWtz?=
 =?utf-8?B?aHNzWWpRaDhrN1k4MkFXSmEzc3JvM0xzaFVkOWp0Mi9mUkQwdERkN2JRKzVB?=
 =?utf-8?B?dVNYTHplZHljNGtYOFZYV0ZsRnNHU1VJMTI1NWJ3bXVnK2dScUdTMkk0UGhM?=
 =?utf-8?B?UUppRm4zV24yai8zT0ZYNVF2TVIzZ1lTMTZiVys1K2NkWDN4RDRZWmR1N0hq?=
 =?utf-8?B?WGJCanVRSTAwRHNMY2NoUGxiYVptZmdUVUliZ2lIWEhNU1lrcGNVYS9KQ01v?=
 =?utf-8?B?TW1jZjhlby9hTHZ5MWYzRjRUV0xuaU00bkx6VFhwNURTMEdRR0E5R3grdktM?=
 =?utf-8?B?MHlHdm5teHYvZHRuWjVWa3E3dWkraVRGZFV6R3JLUVhPSzNFbUxkMFV6TmRp?=
 =?utf-8?B?Z00zZE41aXlWZ1hqZ2Z4dXZrK2JhWVRmS1pPMVQ3eEJOYmMxblNGZVIxQW55?=
 =?utf-8?B?QmJ4d0NwNWNvOTVRbVBaTExta1hpRWFkRGxCZTJKSTVKQ0dtNFJJK2pNQzZr?=
 =?utf-8?B?ZE9VcVI1RGZiN3lkMzlPMi9qZXRDcGp5QU94VEdBS2RZVStrbG5sdXBYYms4?=
 =?utf-8?B?aDV4V1RUSUlrQm5Gb1NUS2JJYjg2ci80L3RyQmtBaTlLTUNIZVJ2SHVkb3Fu?=
 =?utf-8?B?RnMwb09kVkI0VmpmNVRaS1B2b0w4bGNVNnpYVmJkRzVWMzBaVTVXSi9YZmJ3?=
 =?utf-8?B?bDBTeitpaENpb21GdytZNVNyNDI5elFjQ1FkSTB6K2FYOG01bmREKzRFZ2po?=
 =?utf-8?B?UHVGZ0dTazFZZlZpaW9hTzJ4aksrd3U5TnFXa0EvYnpha0xHWVNibE0zOWNm?=
 =?utf-8?B?QXI3bm11a01RMkxxTDdaS24yUmsrMmVFT0hzeFAxdy9FOGJyUUUxYVNsQlRJ?=
 =?utf-8?B?OHdWL2hHTnBodXdEdUVqTlpPQndlV3RwVG5IN0NDTjQwdkFySXp2UFVLVU96?=
 =?utf-8?B?cWllMi9NclpaOXNrWUgvK3ZXOVNOY3h5TmZpeXduMmVzUGRxa0JFd1hLNDlO?=
 =?utf-8?B?WnZpdmRvQlVRbTdaV2N0YjNhUjFNWkRTVE8zdkdqMjkzZlVYM2JSSTh5NENk?=
 =?utf-8?B?am1pNWxXcHRiS1ZtS25uVTlPblQrVERiUkQ4KzJzMlBHb0FBcVBhWTRjSUtn?=
 =?utf-8?B?ZWRpV3R4SHFNRFB5eTE3ZFYzWnhxWTR5ZzdJUzFwSHJRS3p1K3Z4YVZ3Y2RI?=
 =?utf-8?B?WUlERDhLdE1mWkNBWHU4RGpIZGtZeG4ySGpERFU1Zk8vUGllSmIxc1NtZS9j?=
 =?utf-8?B?TjVra2tkTDdrTDR6UnRPQVRvL01POGxsYnZvQmYzdkhuMnNPUTZWVG5VM2Ez?=
 =?utf-8?B?WUlwL1owa3JHeXc3dE9QOTg4N0pjYW1JR29BNjdRNVpqUHJDQmFGR2VvdzNa?=
 =?utf-8?B?cTcwWTV5a0tFRE9QazNzMldvQWpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BD4F4A52134834AB3DACF786C0630CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AYRpIPuD6aQhn5Q7U9fUVfICn1M6CwXEA6WgTicz4bGMiE7SwaRwnnbhHXivfy4fOH+EVbNLqqto6hSr3gWkF+WnzkmHQNW67+J7EuAa9yrpqdx1T1xgdLqOJDk5MuZ46kz9MfsOVFkWDPbVf15kmAUcDfaS+EFKJdWUE6qgfoaNPHJpCPEp/VaCkNt4bnZ48O27YWbm1Vb1UtroDEDp8sEbe1qh6Be5iwTV84YgSDJLnG2j/3HoDMMOmzI3OpFjADgp58ahRIcULyiNf7YA4qKIDC93nqNt4by9unUk/M7AdgEI99BoDlNQX3BoQNzs81jVoxzlq6dZxwMtesqcGShxHlfkNk9SdGg7XjxWIgTqmwVUADnn0mumMHe/njLtylExmfvcn/N4UZYdCq/rILFI2bm6lydu7DuRns57D3slRDXKqUEK+v6j8maqHLkQiI6V+9ratLzfS21ccYuzfwNN/mMnRvOPGicsHH08JZnrtJFZQlZEZ4YJ1u6Y9dnX13fTQN2hw+NxKyPB3KY2lidAQBCtmc6pyacaQNkPu0iXSJ9FwtzvVECvCCQVjqjHRT4nDPy8vFsTmzZ6dTqPnk/nUy9nPFRiT20lMfbJ/Wvt5nxs4GpX0aUopMY986pz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc80d52-7ec1-4985-b933-08de07c9ce21
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 06:54:06.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwx3TWbOK4sZDcZidAOm3iUDd3El+K8wW9JA7cfGskxdIpLwyQTCNme2jSbf15657dvP6LPcZ5ujCc8KqtlJkiaXDhX3q7lzLOihxqAajMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7606

T24gMTAvMTAvMjUgNzowMSBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiBAQCAtMTI4Niw2ICsxMjg5
LDExIEBAIHN0YXRpYyBub2lubGluZSBpbnQgY293X2ZpbGVfcmFuZ2Uoc3RydWN0IGJ0cmZzX2lu
b2RlICppbm9kZSwNCj4gICAJdW5zaWduZWQgbG9uZyBwYWdlX29wczsNCj4gICAJaW50IHJldCA9
IDA7DQo+ICAgDQo+ICsJaWYgKHVubGlrZWx5KGJ0cmZzX2lzX3NodXRkb3duKGZzX2luZm8pKSkg
ew0KPiArCQlyZXQgPSAtRUlPOw0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICsJfQ0KPiArDQoN
ClNlZSBiZWxvdy4NCg0KDQo+ICAgCWlmIChidHJmc19pc19mcmVlX3NwYWNlX2lub2RlKGlub2Rl
KSkgew0KPiAgIAkJcmV0ID0gLUVJTlZBTDsNCj4gICAJCWdvdG8gb3V0X3VubG9jazsNCj4gQEAg
LTIwMDQsNyArMjAxMiw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQgcnVuX2RlbGFsbG9jX25vY293
KHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQo+ICAgew0KPiAgIAlzdHJ1Y3QgYnRyZnNfZnNf
aW5mbyAqZnNfaW5mbyA9IGlub2RlLT5yb290LT5mc19pbmZvOw0KPiAgIAlzdHJ1Y3QgYnRyZnNf
cm9vdCAqcm9vdCA9IGlub2RlLT5yb290Ow0KPiAtCXN0cnVjdCBidHJmc19wYXRoICpwYXRoOw0K
PiArCXN0cnVjdCBidHJmc19wYXRoICpwYXRoID0gTlVMTDsNCj4gICAJdTY0IGNvd19zdGFydCA9
ICh1NjQpLTE7DQo+ICAgCS8qDQo+ICAgCSAqIElmIG5vdCAwLCByZXByZXNlbnRzIHRoZSBpbmNs
dXNpdmUgZW5kIG9mIHRoZSBsYXN0IGZhbGxiYWNrX3RvX2NvdygpDQo+IEBAIC0yMDM0LDYgKzIw
NDIsMTAgQEAgc3RhdGljIG5vaW5saW5lIGludCBydW5fZGVsYWxsb2Nfbm9jb3coc3RydWN0IGJ0
cmZzX2lub2RlICppbm9kZSwNCj4gICAJICovDQo+ICAgCUFTU0VSVCghYnRyZnNfaXNfem9uZWQo
ZnNfaW5mbykgfHwgYnRyZnNfaXNfZGF0YV9yZWxvY19yb290KHJvb3QpKTsNCj4gICANCj4gKwlp
ZiAodW5saWtlbHkoYnRyZnNfaXNfc2h1dGRvd24oZnNfaW5mbykpKSB7DQo+ICsJCXJldCA9IC1F
SU87DQo+ICsJCWdvdG8gZXJyb3I7DQo+ICsJfQ0KPiAgIAlwYXRoID0gYnRyZnNfYWxsb2NfcGF0
aCgpOw0KPiAgIAlpZiAoIXBhdGgpIHsNCj4gICAJCXJldCA9IC1FTk9NRU07DQoNClN0dXBpZCBx
dWVzdGlvbiwgZ29pbmcgdG8gZXJyb3IgaGVyZSB3aWxsIGdpdmUgdXMgYSBlcnJvciBwcmludCAN
CihydW5fZGVsYWxsb2Nfbm93Y293IGZhaWxlZCwgcm9vdD0gLi4uICkuIElzIHRoaXMgaW50ZW50
aW9uYWwgb3Igd291bGQgDQpiYWlsaW5nIG91dCBiZWZvcmUgYWxsb2NhdGluZyBhIHBhdGggYW5k
IGVycm9yaW5nIG1ha2UgbW9yZSBzZW5zZT8NCg0KVGhhdCBvbiB0aGUgb3RoZXIgaGFuZCB3b3Vs
ZCBza2lwIHRoZSBjbGVhbnVwLCBidXQgaWYgbmVlZGVkIHdlIGNhbiANCnN0aWxsIGV4dHJhY3Qg
dGhlbSBpbnRvIGEgY2xlYW51cCBmdW5jdGlvbiBhbmQgY2FsbCB0aGVtIGJlZm9yZSByZXR1cm4u
DQoNCg==

