Return-Path: <linux-btrfs+bounces-18577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67ACC2CE53
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C12565140
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CE0322A24;
	Mon,  3 Nov 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kPaKkq3m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Urn/QCY7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A85320CD1;
	Mon,  3 Nov 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182756; cv=fail; b=ZpXueaHvjyUaLxK9xxy0x8Sevtt8mmFUtWGyMxitI7BOi4m3yCRw8A5ZoZY95ThIU5vtymxvtj+SlTNjOp0dDeE8zWwKAOpkIX8qRC2lCRxWN/X6A/uOO8rRePhmF81EJTXpHPKLyjchquatyx47AZnrzkc4IFkbhVue5RdEtmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182756; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLzbh5Esr1JBi+BGUI6EzIHlizuajH+OpvEKkP71I8VUrFEBX9jTeX8SlTap7C3f5OgRhzmFdeK0nVS2QH2p3HFVnYu2dwn1NF20DT+KDaNlw2brupLehBw0FYQ3LhovrGkzWMHv9Xpa7Fd5xefEqPYU7uHFe77jbAFofF4adfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kPaKkq3m; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Urn/QCY7; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762182755; x=1793718755;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=kPaKkq3mHnjiZfBLpaBFSb9OpyNqaIKhwIAE8mrDpeEuj0MIh9JEJE3W
   VTyfhnRogIs6bZZbk35S2NnN8L9ibN5BL9tIDbwNFSy3YwvutSPppdRSf
   I5mT7UFLWn0bXH9d195keGfhYEAfsoJETupxGXMMoRmrOxg67SipAeBja
   Yrdb8P57oSwv7rSAUWkfQJxBHW0AmmdJ+QTSohRzJqLKoJ+OjiLWbBsdF
   258aatjA+I3Fq2wkqlm0kvhPOTwPORjLX7rCJwQ3SaQFZhOr7RasCAsqk
   CsYRP+eePfBRte1c8AeGVgnMLg95l/UM/blIXRhagY54B72g71Az60LTJ
   w==;
X-CSE-ConnectionGUID: 352t1DlAQJ2xRnbKp0vSNQ==
X-CSE-MsgGUID: peJ72WJLRz6MzaFZ5bDdvg==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135347054"
Received: from mail-northcentralusazon11010025.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.25])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:12:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSKb9WnksPSX6XWMzVNz/KXnlmd8Hndlv24EpOiaWn0LGxZYwtNjjm+yN53OdtIF713RB/BbMQGWdzeLkTvStU7lRZ75K66tNni+VYzZjCx6TPCnxXzRUSmc9QORX/m0GEfSiPIO9iiiQne2jbGcssYr0Gpdt2yihmWsy6JrFLF7AQ9rMVIxvuuetNSvThNIAbynlaLHzXFkHPojRZrwdKgKTxeDiM7DWRJdwY1Ea2t4TVowp/X0KTAv1nQ8HJ429XXcLXjF60UfUsqLUmamQx73N12x899eV91wS7u1FBkfmgzop4XbenKK8LsPm2G53/zTAg/BtUueocIlmVSLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=o7OnZXEEO5vHzNdQYa1yRSzBDAnuoTn2VgkkWP3A9uTSQnvPQfqIPbP5HufQnEKmgrsSxygu6TM0CP5Dgfw1smqxgcR7n5c9JHTZzU/T2PYi7HSDSv02Tija1m1dWe/F4Y1wK1ewau4jWJNB4GGQx3RvRmqZBG5Nx3Rst7o08HB91Qn4se6wPAzLpnb1osOOksu+vFN/xQKTW7RMXei2GwJ7tboK0IfNIs9dh6Yco54OrsJ2I9lEShP3gITVMhnaBTVLf1mx+8YBgRHvyu21PVmVTquYOWSH+w8UZX+FW1s3iiEahugVrUFZicCmKd+UFXImoEw6EMrV6Mzx6hK5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Urn/QCY7syy9UndLUjjuYA6dkS0qkl5t2ouUgnzyNkfYdTlc8bgFpM67MgX/By/q/0xwS2xDWFPZdgzbFuaRaHJhwnyIRFMKsxRE95TV61fogB8KT5f68uDAqyL6bu52bFCE4qQ8jklIPR+jlC+SDg1PYKYMeuxiMqIRIaOKu3A=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DM6PR04MB6842.namprd04.prod.outlook.com (2603:10b6:5:243::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:12:29 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:12:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 09/15] block: introduce blkdev_get_zone_info()
Thread-Topic: [PATCH v2 09/15] block: introduce blkdev_get_zone_info()
Thread-Index: AQHcTMclz1oMGyS4BkGvJY3o5KXhhrThDvoA
Date: Mon, 3 Nov 2025 15:12:29 +0000
Message-ID: <706b7511-dbe0-4df8-b45c-a376ee1437e4@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-10-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-10-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DM6PR04MB6842:EE_
x-ms-office365-filtering-correlation-id: 4218c8de-a5bb-424d-4bb8-08de1aeb679f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1JZSnpoZzRjR2lVKzhPbVhvL212U0hTOHZLN2E3RG4xUWhvZVNmNGdpcTFH?=
 =?utf-8?B?YmZFM2MxbzBkSTV5VkU4TitURFRrRmRmR3ZBQXNZUzhLQnM3eUtmVEYycWls?=
 =?utf-8?B?azZVeklaK2ptSERwL25vc0ZWVUF1VkNqa25zOXFGT1N5MlJ3S01wNXY3NHBh?=
 =?utf-8?B?NEw5ZVVYNlBZbUt2R29ZT3BXNE1iY0hZdTBLUnBBQkZoZ3dmeDRuWnJzdFpx?=
 =?utf-8?B?TGplOXQ1M2o1dEg1UUpyckNkUFY1aFRBWXpSakQyTTZZcDNtZUl1Y0dlVTZE?=
 =?utf-8?B?Njl5MHQ0Y2trMUxGZ1p1L1R5T3FDZWpDZlVwbFhuY29KYXg5TlMxSUpGVE5D?=
 =?utf-8?B?M2JOa1dBRGdiSmc5TTdRc20rMFczZmJOcWp6d2I2eWQ5ZHJmZWNrRlVkL2Nr?=
 =?utf-8?B?MFJjYTJiclY3NCtlYzFyTjg2V3hBTDdMOU1FZnp6emN4WG1jMlRLSjBkMkVp?=
 =?utf-8?B?WFdmSzBkb0dzc2duNjV3MVlhUXZKVTBkclBYYTBFc0hmV3Fwb1pMMjJZa3Zj?=
 =?utf-8?B?d1NNZXE0QkhkU0FKMU5oM01saFIzeDJQV2JQWUZlMkFlN3hIQWRWdEdEU01X?=
 =?utf-8?B?WFRxUUpOVC8wU01qZGpFTzJKbDBwZ3ExQjhKQjVhNHFpQkVTa1EvWm9YaERV?=
 =?utf-8?B?UVlLM3N0NHl0Q1lLL3ROMWFPNVEzQzNTdkNWdTJJeU5NM24xWE0zenZnaEdj?=
 =?utf-8?B?YmRQeGFJZWpPN3kzcnBMQmN3Z1NnaUx5b2tXaU92L3lNbmd4blZ6WElJSk4r?=
 =?utf-8?B?VTdQd3Q1RjJySVdlYm1aeHFIZnFOZWpaQnNxUmNQaFp0K2RvL0p5N0QvdnM5?=
 =?utf-8?B?N1IrUmFLUVl6WWxLVUNLcG5sazhQS0pGc1NmakEyMVc4MXc4dFRYcnE4V1M0?=
 =?utf-8?B?N25DRDlEMlRPeFBRRDQzeForeUtRQWVMM2E1dFhINzVIWnBtMm04cE93MFp1?=
 =?utf-8?B?UnMwcnZGbTdzWHBZUFpZbm5OejdJekdQNnp0ZDRYNVlublVUWTdScHpwNmpv?=
 =?utf-8?B?Smh4S014eXBtcStSV3NmSnhEYVJFRlYySW5vQ0pKcE16NUo0aHhsODNEa2cv?=
 =?utf-8?B?ZGFqb1hrSzVoMldJVEF5MFBQL0JzdUI0TXJQUGZCUWpEL2orTnBXQ2VETlRC?=
 =?utf-8?B?eGVNSXZFMjFGUkxSckVzeWllYmRWZWJMdVErN0lNdTFTL3plWVdFb00zRFJx?=
 =?utf-8?B?R2VTZHZTUU9vMENUckM0NHhuWmRERGplQkllV2c5VGxWd3UvWGRNaVhOZldS?=
 =?utf-8?B?OTlrdnYzQlczZXUrZEZZRTZWNkpwd3NQZ2FHUjYveUNBa1pNYlh1dlFGMGg2?=
 =?utf-8?B?djhiWlVHcHRWUk8rV1hiM3kxVG9DV3h2R3NkQ3dDcVJjQkk2QWdBczA1SnNq?=
 =?utf-8?B?ZTFsZFFZYmQ5VVRiWVlqNjIvNnZmTVIyNy9DOFVhd2JxRTVEM0Jqa2Z2aHlk?=
 =?utf-8?B?eEdCcXdmT1Q1bC9NNmRXMHlnS1d0SEtuejhBZmVmdVFiRzdEdmNRQ1dvSlV4?=
 =?utf-8?B?TVhNa0pmWFl4aER4aG1kQTdKVER4eTlsUjJYdjIyZHppQkUyNUlWQVRRekRI?=
 =?utf-8?B?aGZFSkx0RHZhVnlNOGpWY2lRQmhJWWdMYlRJNzVONFpZWG9JbDdVczNqTTdU?=
 =?utf-8?B?VzVGbEZGSTA2V2ovRVFqTGd1Sk8zdW9kUExxOEYyQ2dGMTQvQ3NqTm5kRnZx?=
 =?utf-8?B?d2E0ZkgvZTU0Um5lRGdjTWpPV1FqN1RlamJEK2U0QWlGTFpvUy9WajVrcmN0?=
 =?utf-8?B?dXg5UnlTR1B3RGRpRGQ1U0h3M215N1hRZENaZG9saGVUWlhtMkZwVVM2a0gr?=
 =?utf-8?B?Z2FLclVOekNjUzIwRTZSSVRBTjRnTjU0UlpFbmVtMG1zbnZJSE41YmR6dWR4?=
 =?utf-8?B?OEgvMUczSldiWVRvMk4xTTYwejN2NUpzMlU2MXhIR1RzZU1IcGNOMVI5ckhS?=
 =?utf-8?B?N0tob2haWXJCRVgrWklTaytSWXg1L29CWGRLSGlCMW03VUc3UHJCZzAvWWlD?=
 =?utf-8?B?Z0puMnZPMUZkbjZyOWtFMjlxam5jTjBwcHYwbmlRUmgrVFB1NDMvclRIdGMx?=
 =?utf-8?B?Z3RPZUJLbnpzSDltQ29LVHRXelo4ZkJ3Vi9vdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFVMWE44enlnR0VzajdnWlduTllXRDlza2UyUi9tRUFMbS9OanZUcGpWSlVy?=
 =?utf-8?B?WFFWVlBTWC9XVFc3WEd2Lyt2Zkk5MkRSNm9GQTVqRFpTMVpwaTJkT3FsSGpr?=
 =?utf-8?B?elV4Y2VmS2NGeVFrTUs5UXhBYmpTVnorTXlzaDRVVXZybmRpdy9FQ3BwQlJW?=
 =?utf-8?B?OEFOYzdMcERyMjViTkZBcm5ZaHRZMDA3NC9hV2dFdnJNS3ZFNUY4ZDIxbnZU?=
 =?utf-8?B?Unp6c2lIekppbjErbFcvalMvbHMyUS95aUxSNHdTZG5IMGRIczhNeEhvMjNR?=
 =?utf-8?B?WFJuM2FkV2xFaGl2bm40dThqQjBTOG1ZTWhZdklVNTFuOXIrKzJjNlNhOTBC?=
 =?utf-8?B?SzdjR1FjblNNOC96djRTL25nN0huOFp0TVNCSnVBdE5hNnRQa2lkVW1TTlFp?=
 =?utf-8?B?MEs5Qy8zd1Nrc29KVXFiNkJMN01TazlzUEs0OU1uK0pvbDNYeFYwR2NDLzcx?=
 =?utf-8?B?cU1tZDd2d2RLR3pUZHlKZ2Y5S3Y1NmMvQk0wRWRmRzYzV3UxMHJZS1lwS0dS?=
 =?utf-8?B?WGNPVzBZbWxUQVVGNHdTNjQrN28wc3lxQjNFSEJuUGxvOGthVGZYN0UrUEow?=
 =?utf-8?B?T0VSSlY2U2QxYjFRS2xSZFpXa1dOUS9KMVBZcUNDUklBT0xOQ1dua2lQc0J0?=
 =?utf-8?B?a3loZnVqUFdyTGM1YXRXYkM4RTQ4TktkdEtpUmJJeFhWYU5hRXI2MDB1ZGZ6?=
 =?utf-8?B?aWxPY3BNRGpJOGxVRHhQVTAvQVlzZENRUC9WU2NxckE3QlNPNzBuQVdnTEFN?=
 =?utf-8?B?RmJMdGg4UFFSTDRnRVRkajA1MHRyZkowNnUzUjVLWUd2ZTdLRVJZb09SQ3Fu?=
 =?utf-8?B?K25DTVVJNzVneDBkTi9CYmZ0M3Y2S0RQK1pVYWxTaW54Z3Bnc3BvT2htb3NM?=
 =?utf-8?B?Wng4bEtKMTk1K050cEpqc1JBTTdxd0I2d1pXR3k4Nmo5cnlHZjNOeURMS3VV?=
 =?utf-8?B?TlphK1ZmRHlvcGRMQ1djVTdvUktyZ3hWNUthakdidUpmWXhacFl3RjdxZ2xx?=
 =?utf-8?B?aWNSSUMyb2h2S05zM2ZyZnIraFR1VHpyV1FwTFBZK1oydUptM1EwSHVreURi?=
 =?utf-8?B?Z3lHcGlSckJpcmQ5RStUOE93Q0dEOTNVaFpoZWlJUlRBL3EvWG9LeDNzRDEy?=
 =?utf-8?B?MVF0R3Y4U3lWUkU0aHR4em5vMHZ3eVludWFqU2dqZWFtMk9XMURtUnE1eFAw?=
 =?utf-8?B?Q1FmY2kvdlA2QlcrM1ZCRW5JMGhZc0tIN0t2NDZHa0psWHVVZVVERXBxbENx?=
 =?utf-8?B?Vkx6dEFnSnh5QWFnZUJrekczNnpRckNIaVgyOFNFdVlibjZjS1l5U2ZIY1lT?=
 =?utf-8?B?UXJQMnkzZFI0QmE0ZS9IYjlBOGF6TEFxeVMxck15Wm9zMEVJSUE4ME11UC96?=
 =?utf-8?B?anNPY0dScFNJNVNrcVJSR1FwaW1VczlKVW15MW1SMUZYOXI4eGNvdUtjeVlQ?=
 =?utf-8?B?WFoyZkkwa0RDM3ZreDBvNmlyVlNacHNGY2ZIeEJSYnYreVU5eklDU0ttTFZC?=
 =?utf-8?B?a3ZPTDZyNUwyZkJNaWR2S0FDcXd3cmtWOWJjcVBlR1dES0trUDRrZ0kzaG5l?=
 =?utf-8?B?UHN5cFlvRnVZam4xQ2lJUjNOS2J4d25MeUdFQnJSRkp5K0sra21VVyt3VitL?=
 =?utf-8?B?TUgxMFd6VGJlSzhJdVhycHhtUTRXVkgxSnk4WXFpOTRiWEd0MGE0ZUxNbkkr?=
 =?utf-8?B?VkFHWTRzekMvQlJ1NG5FSFI5ckNkRFJSSk50dGs2MC9nSk1Lbi9yV3M1aUdq?=
 =?utf-8?B?N3JudUdJUUlWeFhFajdLeVBKQ3VuaVNhU2xwRnRnL1Q2TTNSSzFHVG9YU0Vt?=
 =?utf-8?B?MjRJcWgza3dlRzlGZnFnZGxySHJxR3F1Vy9aWlBQNm81U1RxYk1wK3RDMnZO?=
 =?utf-8?B?cGs3OGlFemcwQ0F4Sk1KWkVGcnpXVkdERGM1aGY2NGV5Sy9YNFY0QW5QWndI?=
 =?utf-8?B?S3pVeDZYbXl6dDQ0cDJTV0d6VmRtaHREcEV3eHBQc3lqNEpTTWdrREQzK09V?=
 =?utf-8?B?bm42c2dBakxHK1JueDBTK0FYZ2xpc3pMK0dtOUxkM2Z2NTd6aG9sTnBXZ0Y0?=
 =?utf-8?B?WUMvT3ZQRGNCK2RhT01YbUpkWjFRL05laVlrYSt2aERVWjZtc2xKTFFHa2Nt?=
 =?utf-8?B?dGJDblhsOHB1S3BmcENhblB0cmRZK2NMWmVKdHU4NnAvTHJZQXlQYVF6bG13?=
 =?utf-8?B?ZlB6RmVlcnBybDAvSnF5SlFSSGpXMlRUUVB3VlF5T2Yrcis4K2xjTXZBWm5i?=
 =?utf-8?B?czFMeGlJMEd4cW1jVTJlMVR1dndnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABD41572BE29A45BF160141E8B6225F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pfgOK0rmeAZWHaOvOzK/Dbr4hlm0yzek9tHgttco8K+rQTZosR000FIDpU03HDp/lny7saELs1HvIwqMhbBW/fooJhwDyinbmnCMZmxHsT6ldjYj/XcGYWGF6zOw72bPFvXk29viAUl4ANdH6hOLW+CvBNfqO4diKvD2+h1PT16GLRim8ZgPVA83d99z7xxzr2EitcjWQFsI8/DJVM4NGpbZ8sdA7sz9YvGjbTjlBoapaVbuOiF8x7yzxOfz7E7cgAMnYPdHi6NqN/K0aqE3bqZK0MZfDbjtjSdpce/n4QwcvtW8vHYFYE/jL9L3XDdyIy8D5XScq/Yaw7y6nxBLkxpC2M2bNLrEvhyE4mdTsKyxWfEWSEOV2R2krgu3C9VyBgr5umBoriV12MK1tOdoixHNo6RtI1zz6GC3Cby1qWoJzF3SaKuPAakmBkNmmCMpk06+RjZ3TcfFRgQWWMQ/X0C++2rqFxwAgNiXK5ZSURrPij+Bl9koA22rFgz5qxABOrCuRSS34D6cyRhtgTyFaZAPjPVfqRCrgxpOtFZmSEcY4l1Jk9YXarNTUcQ0h+vu6Bnd83Bwedg0vFuYq6MuF0NASy+5esVYv88QlKFazM+wQcSW6X7C0Qo6+siYhwBi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4218c8de-a5bb-424d-4bb8-08de1aeb679f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:12:29.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAKwnYcWI8tuE2oqy1NtzGkMcJWgNtx9ipt06gdxquWMPSlmDnzA6d22qQ+CubtMAv0A7lP13CPhwQQM2bC5LKTnk7FEqgG3soieSqB/0jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6842

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

