Return-Path: <linux-btrfs+bounces-19139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDDC6DED7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D85492DF97
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E20C34A794;
	Wed, 19 Nov 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FwI1pgze";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="umFL66a9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B822FB62A;
	Wed, 19 Nov 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547366; cv=fail; b=DZBXULqhCT0ScAGRXOnwuSW38ADCJ/yxr+g5gIZMyDNM535zR4WK4FzssaqXlhDcVklUxv2WY32Zve0tbtHoIUaN5jT9aUObAGDfelRc5Gynw+pQtYzmg/TK+x4iXLqaZIx66NtZipdeMh09VWXKS8EMphbEXwQQT1nK3HpD+f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547366; c=relaxed/simple;
	bh=9opdcnyuQXgD1xuYKH5G+8pSPtaArvwTSwFa3+q6pI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEhmyVAYACj3soVXix2q2iZ8X3xt27ggslQ8DbswLKg4IeyU6pxrqrH1GPJIU6HlksfHM+Hn0f0kXKboQ/lkNqMlS0g16LVXQfpJD8KkfE79mGkSh6HUlypNyYqmH1NcZc9BRQXS9gS2zVLTRYIz86r0yLM8dMkecN5lzaLstZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FwI1pgze; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=umFL66a9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763547365; x=1795083365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9opdcnyuQXgD1xuYKH5G+8pSPtaArvwTSwFa3+q6pI4=;
  b=FwI1pgze+6qyGbNVktXzZ5iQAHGIyBKmsZ6SMW4n0ZS7a/Ax7Qzr7PLk
   +VL/vNDwgZhILnvNKJ5cJmqxnSTFXE2DKLVk1T53tmRoJIzipi3hXs7Nu
   DNKz97mzLF4669yFmIJLR8lkbItgJ4UuiOpSQCwwflU2WfeBiq/aiphEA
   5av6D9HSrWIa+LvX2b+LzG/uaOMTD+tmivaWIs3rznAT/OoIVuTyD52O1
   HWXlzGUpbjOrrGxOtk348iLf4ZiCcm3JJIpVXOWbyCK9/EO/vuqAw8ySv
   hJ7x4nA6R3YBGsT2IdV3rCs72Nlm6jAhbzEWyjhOohcxK60nfEU+IiVXe
   Q==;
X-CSE-ConnectionGUID: 1XhX9eGvTSCSPBmYnk+Pug==
X-CSE-MsgGUID: oh/+DoyRQXGl2hkdk3nsmA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="132357820"
Received: from mail-northcentralusazon11012051.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 18:16:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXK5yAjzkBx/MHRF9yrpFHRRjYoUhtyzSj8A0LxkMJhabRBFz9Tx4PhLXh6yudL70cmzPbVZa4LNaxUTaW0ZZENpEcDYs7b8AHTFu3rPcxFIpLlANdr2XzBJ3eoSDHPGPdwvXvTF/cRinQmJCqNtZm43ly6XZeaUvn0/kw1UlyaaUN4mpwLICP/+lqDAacNQUCV4t3HLCVdvz+RObkuOiw+5B0s3w51GDspZqYYpjyxd6HzXfseBonM8Bk1MB9qeRPhRf9dNDhckM9OhwfyMM1UuFTIEbKeo7uNvqPqhDjUUmSWq6yiWMHhMPx177bBH8cxNpkLlocLVfoAOtFb0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9opdcnyuQXgD1xuYKH5G+8pSPtaArvwTSwFa3+q6pI4=;
 b=hLG4Q6nu2yJv+O7DOzoi9SB+hEM7W8lu8gGTKl0/0TLtvc/jvu3TlKtTFuAuiBfU50SKxPTspmRCNmj25erWLeQ6WOd7Ikoxo7Zr3ncmjmsQVU4GtNoo52J6iroA5Iu4RcyT57QihrgvP528Ak24sfz6WuP3z8CU+aSQdfmAxbJirb+hYBdC3EUpeNlOK3dUX0wHz79MrmjZukRqKSKS6Q3cnl9RBRFiFxkKUq6RkKZvBSmcdaawyh+Uvn/VgLF2Qqrb2EcF7jAQhkyvpf2TToOg8oN90v9ygbFn9k29sJ5JYd9iSoP2jvJ6L9c3ppPUICd0qLYbb9ijq8YLBYcIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9opdcnyuQXgD1xuYKH5G+8pSPtaArvwTSwFa3+q6pI4=;
 b=umFL66a9iumhBJF0kL3NXF47jEH/zEX1AKvFfie7V8Kh/YSXZpiRMXyc2fdKo+N/vQ0MUgCfjER2UTCZirw2BrQC7dEZ7MEj/U8w9BCMJUXqXquF7xaOSFXI4pPg9gUNUTDkP93cJwLCh8UmkAsCJfptXil7fluuYyQwvUTgTV8=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7802.namprd04.prod.outlook.com (2603:10b6:510:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:16:02 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 10:16:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] btrfs: don't search back for dir inode item in
 INO_LOOKUP_USER
Thread-Topic: [PATCH v7 6/6] btrfs: don't search back for dir inode item in
 INO_LOOKUP_USER
Thread-Index: AQHcWKZLMIeJDl7uvkaRYqxiCkYqmrT5ybWA
Date: Wed, 19 Nov 2025 10:16:02 +0000
Message-ID: <b9162167-b9e0-410f-b6e5-466da6dbbaa4@wdc.com>
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-7-neelx@suse.com>
In-Reply-To: <20251118160845.3006733-7-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7802:EE_
x-ms-office365-filtering-correlation-id: 82790822-6ddd-490b-ead0-08de2754a45c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c21UUkZoSVd0em5pZVFTVGNhQ3FkakhrY2pDcnRvRVZiejJpVENHd1ZGMFZ4?=
 =?utf-8?B?WDloR1c1ckhGdHJxcE1VMkp0UnRPTDZNQ04wS2huUFEraHlhRWdPZWNuY0Jr?=
 =?utf-8?B?Rm1Xb1JGYzhpaWNITGJIUEQxbzZ3bDN6K0VOR3B2emErQ2ZlL08raHM4aVV0?=
 =?utf-8?B?TnZ5V1kyUDhTWVJLY1pZQUxmbEtKdlkzaEZTLzZlN1pna3RzSVRZd0ZvbEdL?=
 =?utf-8?B?dEh6UHk5YlBXaTBnNHRneTV3N3krYVN2cGFjWXNDMnVHa2tUU1MzQTZDSW1X?=
 =?utf-8?B?THVoK3NwcDkvV1Jna2dERVlCeUZTTXBnamJiU01iRjA1S28rbm9JQmFDcG5D?=
 =?utf-8?B?ZEprb1ZnVFhHZ3ZrSjFPK1A2OFd6dUcvN1A3NmNINy8wK1BsWkJ3NDM5UHFT?=
 =?utf-8?B?Z2pBZWR1OXJ4ZXhhRXdQSFFlaUg1TDZrQnk5cVRNeStFV0haTGsrY1N1WkVI?=
 =?utf-8?B?NUVvVUJuS0RpeW9rVlNTTmJJQTVWOHVVMzg1bEVqTVczaisxaUhiTXhFZC82?=
 =?utf-8?B?VllFS0NpdjJXOEM1ajhSOVpDVis5amlUeUdSYUJ1bHFYRmwxcmhTTmlpSFpo?=
 =?utf-8?B?MUJxUkY3UUsyZmRVMGF6SGFUbFdUTmVQRjdzVUtkZE9HL091MWZGREt4WmNH?=
 =?utf-8?B?ekR5ZjJvb1UydUZrc0JtYUpPbFFlWWpzcFNzVGJqek1td2JoTGhxclRpaDZs?=
 =?utf-8?B?SnNwTWJ3WFB0NGZEMWZ2d0RJOHgxMXFOTXlxOEpxMUgzallBTmVCMjlmck5X?=
 =?utf-8?B?Ym9SRU9QRUxPbVhvWkdrOFBuWGF1aVBSLzlFbEZIbkE5RHUvU2NQdW1LKzlL?=
 =?utf-8?B?T2k0djZBV2NBQzRWTkxjU0NwZldpVGl0VUFIczFJSlNyeCtwYUVLN2cwS0Rj?=
 =?utf-8?B?d25oY1BrM0RnTW52cmJBcEpBMWU0bXphRXNrRnZiR2RqNms3a0JWYnRKcTE3?=
 =?utf-8?B?blI4bEVtamhuZkZ5ZUVBR1IzbnB1NzNQWnNPeTNTMEtMZ21OTDcyU0FoNjU0?=
 =?utf-8?B?TDNQcFJPR0tnU0RwdFFyMk5ZWVVCL01wZDN4bkJVbEZDZ0RQalEzbkZMYVhD?=
 =?utf-8?B?UkszZUpaOVVibExaMEhmSjQvWjFBV25HSkY3ZGVuTG1XY0ttbVpNNXJ5Nkxh?=
 =?utf-8?B?aVcwTzV2YWpJUlJYeWs1SndNVEhackpmRnc5by9IV245N0dJNEdlZjNncHpX?=
 =?utf-8?B?TUhtSldwNE41VXFxTjNjYTd6cVFGZmVMN0t5Q3B0dFF3U2Z6cTlxQTlNVjNi?=
 =?utf-8?B?aXNZZXR4YU1aeE5JTHl6ZHpwZjlwTTRCK2FxTWpkeEpoQTNnS0lHQnRXV1Aw?=
 =?utf-8?B?d1N3UEtNbGlPVnRXT2ZuUTFUM3UyRmRTZ1hMK3Y1SWdQRUR6bFVCOW1Hd1RW?=
 =?utf-8?B?bmQrYUpReXpuQUhwbmJHZlhpL0N1ak5OSzVvVjRDa1NDNVE5MVovWEdKeHhC?=
 =?utf-8?B?S2Y1dUNOQmFLZ0hucjZMZU9YczBLcHdCa085cU9wb2FVM3IzQ1Nwb1p4V0lL?=
 =?utf-8?B?R3lQVG1MVkFBbE9HOUNEbThVdi90NlF2RTQ0b2trTE92ek8yUnlMblFyQnFY?=
 =?utf-8?B?LzliNnkyNVdIVGYzLzBCOURuU214ZTY1M2MzcE95dWF4Z1ZRRnlCWjBNNUx3?=
 =?utf-8?B?bVU0VW9BVlBEUU5IMUFXSUlvQzhMY2t5bXNyb3AxYVJEOFNrVEF2U0d6Q1hO?=
 =?utf-8?B?OENPM3FhNE9VNnVmMVpHWk1KZnMwclJaWnpsSkhIU2hIV015VUJHaEllNktk?=
 =?utf-8?B?Qk5NNlQ0U096Y0x3bTVMbHZYQ0I3NE5XRzFHY2w4elAwQ0J4OXZGaktaK1VY?=
 =?utf-8?B?T0Jib01GN2lrSmo4TzNzYWFVODVYS2JNajBXV3FlcXlXeStiM3ZhRHNKaEhQ?=
 =?utf-8?B?MFNGdDdBVCtoQkNudlJiRnVlckFkRXJlYlNJMWd3SlBIL0hIc3VnWlF5Qmoz?=
 =?utf-8?B?MU12Z3VFelI1Q0RVQlVLc09VZEt2TmVKTnJCVUwycjFTWnJmT2xLeGNjYm9u?=
 =?utf-8?B?NzRqWHRHN3JjSU1NdmVubTlHenBrckNFZ01vbEFVUVNSQ1J6WWkyNFN0NWZQ?=
 =?utf-8?Q?HRIbgw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVYvcktYNGpvaGhxcHFjMng3c3EzaTl4SzhzbEZ2TVlIeGNNcjlFeGcwTFBW?=
 =?utf-8?B?N0JyYVlWZkhZNGx3dWFsaWRhd1cySlN4WSsva0RzYVdMOU1SSVpQNzNtUlY4?=
 =?utf-8?B?WnVobjhKOGZGTjVaOXhUUkkxMmxkTTJJUXlZVFJoeXIzekNybGN4Z1dQMG5L?=
 =?utf-8?B?SElGa0cvcFpPTGFiK28xb0ZhbUZ0VGhUSTVYa0F0WU9lWlY2S1IxT290MEtk?=
 =?utf-8?B?N1doSk9rZXJNajJEVS9yeGRaa2VseXkyeE4xZ1hHV3JXTXBDM2p5ZnFjMnFC?=
 =?utf-8?B?NGVLVWYybmZtdFZlbnJkUnVEckZDMzV0U3pzK1ZieG1yNnhZUXo4MGJaVDkx?=
 =?utf-8?B?bHhuenpJdGptcnJRdlBMN1hud3ViMEFFY2hLZXFKY1dXNFpFRzlmM2JjWUZi?=
 =?utf-8?B?UG1MRlZDOUFMQWdPUzRtYWJGM1lISkRyaFRURWJPR256Q1V0NC9ncU11YzJZ?=
 =?utf-8?B?cm5qVlBSRHlpYW03cGRkRlJCRnI0aVdzNG1XU1MzVFdIMHl3YWhpZVBobUkx?=
 =?utf-8?B?cU12bVlKVlR1anRJUEFHUWRMUTZOTG16L3ZxWGR5S2Nvckk4OHJ3MkhyTHpw?=
 =?utf-8?B?djNEZWNDR2IweTEvenlqUTE2T2c1cm5kTGtWTE9HbWVwZnFsbllIdGtCR0xV?=
 =?utf-8?B?TVFGZ3Z5MWwzeVJ6MVB2d0xmelVleG5MQ281RW84UGl5K3EvRDJGajBlcEFM?=
 =?utf-8?B?ck90cndVZWJGdHVyOHZlY0xGTmdJdmIxTVZoYUxtVm5qSXcvdkhPbzZjSnpS?=
 =?utf-8?B?SEY5QlBJejhmK3RFYlJ2OWUvTS8yeDVUMEFpRWpCanovWHhMa09CVnFtbHA0?=
 =?utf-8?B?QkhJTUpKYUxFWFg4REY3NGVGa05MOFhOOE9SZGp1SUtPTWladnNDQWtrMWZz?=
 =?utf-8?B?Qk8reWQrSVNkUXhFemFhZ1ZiVGVSMVczbi9BeHlOQzVzMmxxcS9hRHlWdXFP?=
 =?utf-8?B?ZUc1Q2JBVlR2V21IMWNsbWEvZS9EMm9Bd0RqUUZFalJ2UmgyM1Z6SUJ1YTRW?=
 =?utf-8?B?S1R2VVJIdS9MZXk5TkRvTUJmdzBIRktpTW9EN2N2eHBKUWdKejZsbldGcE95?=
 =?utf-8?B?d0M1RU5IUzBQQkVSWFpXaFM4YkNybjFHU045bUR2SVlzendSaUJPMHJLZlFM?=
 =?utf-8?B?QXdJTENRbVdjMnlNQklNNTBIdmlBaXlCdzE2aU11cWhZVlpzR3lha0RKS0dX?=
 =?utf-8?B?MkcvNHNRUmpkakJ6dktBOTZ6T0h2dmJHOTRRTzBRVEt4QWdWb2F2QzV3T1Fq?=
 =?utf-8?B?aGFwaTcxZlVKbElJUThhTzBmRnFkTW50d2p4NHROU0FpekU5MnRQY29UWElJ?=
 =?utf-8?B?a1BLZXN1Nk1FdS9nbHUzYVJsLytVaDRIYzVkSWNxQm5ZNEkxa3YwR2pMZGRv?=
 =?utf-8?B?cHNiak9Rdk5oTzVRdXJweXFpS1FBdXg1TllzZUZ6eEFlajNTeWhIVGhsUzI1?=
 =?utf-8?B?bGl6MkRSajlmejV1d2ZHMkRKaFg0bW9sUGpWblJJL1FVdDN5RENoOWRhV08r?=
 =?utf-8?B?eitIWHBkQmVMZTNQdkJQNEZGeFQzK3RYVmZTQWhzQ0NpYVZCTXdKZGNIV2J2?=
 =?utf-8?B?L2pRS013Lyt0cnQwdTRKektxcWM3UENvWGtmYThQd2JzUHRqOWNyZG9Lc3No?=
 =?utf-8?B?dTJ5TFYrMFlWcWhpL3ArOEZtUCtQaEZYSkRoTk1sZm9XQkUxQ0xwNTFVSGZK?=
 =?utf-8?B?NXgxblRGMGJ6Q3BiNWlpYmJBZ3VTYzlXaE9od0R5YUVCTWU0Y2R0WWtYTUox?=
 =?utf-8?B?Y3BRTTJyYkF3bXZnRUxJMUlMMXRSeU9MQ0d6TkZVYWV3bEtaTmFqdmdyYWdh?=
 =?utf-8?B?NmF1NGtEQmNvbmVMejl3UXU2anRKamZEaDhVck5iN3VNMUsybjFMT21JTjlI?=
 =?utf-8?B?NzN4QnJ1a1VTSGNkZkRxNWd1Q0dzRURkdDhzUVZqU3RXUTdCdm1wUDZIRlBN?=
 =?utf-8?B?ZWRkaG94dysxZEpaZi9SMjJrQmlHQ0xXY1VRLy9xenFYcXJGSU9UeWMyVW1i?=
 =?utf-8?B?VzVGcXhxc3Z4QWxiczNEZEhsS3BHc3kxTXVsMFN6c3Q4aDY4TWZVdUh1eWh3?=
 =?utf-8?B?R2E1MFdBakFzRm1pclRtbXBMWHBQK2RnWC9iOS8vSWNWMGZvMXZqR3FsQStI?=
 =?utf-8?B?WjFabWhaSE5nN201dEJmMWJNRUYxUlgzMGZtVWxHTEZYY3owV0ZBdm5vODVh?=
 =?utf-8?B?UUhrZjFvMlAyWWRlUWNDcmxTQkNONjlHM2JkZG4wYngrckRrNlFFVUhGUFMx?=
 =?utf-8?B?ZmtEU3ZsUVh1UUpWUmI5RUl2dnZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13C9CAE1CDEC4945BD68F9A7ABD57C6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uhc4VRAUqcK7FGHeo/BqhLuyjjbmwmmFoACXzvuh0cP3Oxqw8BJip6Eri+ifid9Jrgx1MjFvlPyJ2luGgNbr/wqq2YGq03tQYbA9v3jqFZ9QNzV/yc/ulM6c115GMOYSiJOsUsmIsjZQbA6oTSd3D8vSEHeHBREt5cbhQ7nPJLNt2NPk9B6UyzKmUw57wG+ab/RY01gR86LpSwEDYDshrIrbS/BoMGJokNFwzqw0j/++KFZG5Ms3wrvSA3ilIaqa+Ubf+emUg7sSyGnuRICD4wZjjym4EGwsIXp9uGGZhuYCD+1KuWSex9I+S/jPtQn3fkBhfG72sIQk6kNI/Zbpp+O7WtDgTE9EGbha5AhtdfxlmE0qvNRz0NjIFCHra36+vXvzeHI0cclm1ViHOH4Ki9VAp6J6IPImTVbUGNBre604WfLAGc/WDno3hKokNERFW040iXd+Hv7txbPZf3jwJPdXz0fXbY2Uk62oZJVdP54taoXR7jY3AuRjI/p7LCb4jA4ngmrA6qe5sxP3qEtNcnU5ZID+Fm4pj8UZJJRHxKRak6f1Rin1ncIE2+OYmykQ5uJKIXZvvOBOyjGv0kt/57/zFZztwGCXMA1nsUfite5GziDz5kPTUrn0SDewALwV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82790822-6ddd-490b-ead0-08de2754a45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:16:02.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6f/ZOx5U8FGJ222ParkJJfNAjWjqT4TF6oOAAj28CBoGfh0vo/a8JHtr9M67SRKmnx4gzt3TeQ6LJCWWmlwnHOFegYGqGSLpeaSrjiffII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7802

T24gMTEvMTgvMjUgNToxMyBQTSwgRGFuaWVsIFZhY2VrIHdyb3RlOg0KPiArCQkJLyogQ2hlY2sg
dGhlIHJlYWQrZXhlYyBwZXJtaXNzaW9uIG9mIHRoaXMgZGlyZWN0b3J5ICovDQoNCkknZCBwdXQg
dGhpcyBodW5rIGludG8gNC82Lg0KDQphbmQgbmVlZHMgeW91ciBTb0IgYXMgd2VsbC4NCg0KT3Ro
ZXJ3aXNlLA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCg0K

