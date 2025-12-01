Return-Path: <linux-btrfs+bounces-19430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2525C95D6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 07:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2ABB343687
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC472848B2;
	Mon,  1 Dec 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PsprEDR2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VhOK/N8l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0561279DCA
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Dec 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570625; cv=fail; b=cGZlehgoqk0To414P0viWE2mjrg+K/YX1T2I15hUTaOr9borgQH6eKHt4Eho/BH29lKTJKu/6UrPQFQMLfZs1DbN6+y79Rl6/ABYX1reexXxysWhkwhVFYPOTq58/QhIsUu8DOJpXQnuEHaW5VZFU7n4UStdTA7ENIjgtXzStA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570625; c=relaxed/simple;
	bh=wZ6EddDA5AwLCron/4OkMwEbwNljnFa6rhXaffm6Lvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNSHO+FPBeeovhtvtbLWilDP7w0UGddIuC2WQQtioVRLfxjb/HoUaGAn07Y1j4I/unW4AOujb38nHP30rESCb4dzUi1+LncVFUGAZ55jH0ueP5nckAXMiIebULNBOelw2Tm58YeW2eAfvgIVswAR2YQcHomCAWI7nT9zrVidcrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PsprEDR2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VhOK/N8l; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764570623; x=1796106623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wZ6EddDA5AwLCron/4OkMwEbwNljnFa6rhXaffm6Lvc=;
  b=PsprEDR2eFsNH3lzAYB1MnDAkkyNPh/wfN/bc8qTm2PSgMip2iRBDwRs
   bw10Y8cMLaaMrlBubMl9MNLIF+eU0GQLKqWpmq32v03RiwEvVbF49tXRG
   4DvbjWVB1TlcY8oQIVlxC1igqYqcWezp+qXRI7fCtmIylZrnHzO7vLtpM
   5l6lG0VLENohluja9d2rfoWuUV8rhiN4diMDz+Px15Ppvoeh3fI371Vrs
   CFhjJSQQb53IgPJXouXxoRA5meyGsmnWoAZIkgHiExW/Ibm9S+xKWyHAt
   noSz9kJXxzN6p8RSVYVXkH8Dp6ENjQa7NDr5r6LKrbsgXLkB8XNi3uoF1
   w==;
X-CSE-ConnectionGUID: 1J73yDhcRFa2oMj1cAuD+w==
X-CSE-MsgGUID: Ie4x5ToVTeWoE01KWkSPBw==
X-IronPort-AV: E=Sophos;i="6.20,240,1758556800"; 
   d="scan'208";a="135660684"
Received: from mail-westcentralusazon11010052.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2025 14:30:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9M++JqX+dTFAKeVhgD2nYxUTmNJ5YkC39DFIrRlo1E4+A0Md4W+7+GYt+vnQL5vmjRtWLF9yNBPlNI2HXgMdGR0M4084TRNpQsD2pukf21PdVKggnfXtWODe69+NKVpZKpN9zNzLq6LcsINTCD89cDKxiN2DWIfd/a8MGxFlrFQtS4QvFcmaULPruCM0+LX5hP/4b1F8xnzI7JU+12Ws9bKmDERyeUlsYTN+KT9jnNqujboig+W+w/bpmk5riUAyPT507nMhj4fgFd5n05zMVXpNUCOSK+hPtrb707E50PBu9pgc0I0FN/NX/XLtg77XTjJ3zf29AobzmqU3n2Lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ6EddDA5AwLCron/4OkMwEbwNljnFa6rhXaffm6Lvc=;
 b=JcfLT+MEX5UjXH5JmbLApTNbU65Iu/0c3pJWFFLjKkQiIh/3LDEJu3S2wATzyo2vntNZxp+8Y67mhupBgfUn61H004hs3qqaXkN1pgn9Xf+zGQXIbmgaHmvmXj/OHedYle0lWgofDkj18shQQq4RhxzvepQx0jlGGUR6ZqWLU8ePeFDcOVoak4rF6Gdwmh1jFouvZdE4T3ReotQIvfi48fPbJb5gfH3EtbkQjJ38rfojyLyL1n5n7XkZVUaTxTrZtXcdpuizoPym2UWyRugQYunWbbarZnp9dHWK8GQWexC5rb6H7XZUrDRV9g3iyffJxUWPvy+9TVmQ0At7GObZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ6EddDA5AwLCron/4OkMwEbwNljnFa6rhXaffm6Lvc=;
 b=VhOK/N8lmnQcEzyavbljA4/5NfckCJt1C0deuqoVzO0/Ze4ch1XhO+vu465kMvFKfGTJ9GD8r2pErc/4/GLoP84HYXFwulDGyhoru8sCXFKZ3tf/6wvEk9131COAy5RVaGMcOTmqjcuLaA2+tT20sX0rdslnvzYpZDsdd/ZtHTI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY5PR04MB6963.namprd04.prod.outlook.com (2603:10b6:a03:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 06:30:15 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 06:30:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index: AQHcYFs7ICy2wYW+6UypQP3O7Xqwx7UIL5GAgAAJswCABB3sAA==
Date: Mon, 1 Dec 2025 06:30:14 +0000
Message-ID: <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
In-Reply-To: <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY5PR04MB6963:EE_
x-ms-office365-filtering-correlation-id: 48cb2aa0-0584-4e13-bc98-08de30a31676
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW85VVNOc2NrL1laUXJlRmJRTGtQWUNuVE1Rc09GeXdiUGdHdERHSGIyaElX?=
 =?utf-8?B?ckR0RnM0NG9OVExjUG9JbTBCUkpUWVl6aTdod1hXandrNjRRZUdXdGV6ZXJL?=
 =?utf-8?B?M0FIOFU4UTYwdTBnS1pjeUFiR2FONG1lbXEvYjk1UDJHMzdPVndQRGppbFlk?=
 =?utf-8?B?MVJrbEhIK0E4QjhCdmtkOURTd1UxZHRDTnF3aUNvdnNVcFZjYjMxTXNBMUxl?=
 =?utf-8?B?WEZmOHlOemgwSkN5OWZZUmt1VkNwRmY2WDlKQjRnRTNiUEFJK2RPOGFWNC85?=
 =?utf-8?B?UVJja0FzZ2NsZ1hXbnN6b2hsVEN4SE1STkdvZzNzWHdPK2hjYXhLdnBPbDRH?=
 =?utf-8?B?SUlZU0lLWjRQaDh2cG9UMS9sWnlYZjkzWGc0bkNWRkNvR2RmSUZCRUc4bXVz?=
 =?utf-8?B?UnBhUVBjaVZWVEM0NkhsbFRtb0tvS1BXM2FacHFISGpaV2ErcENDN2h4c25H?=
 =?utf-8?B?QUs1Myt5L0VyVlp6cjF4dHRQTHNYZEpwc3pDMW8xVUkzS1VYZ2xvQWVUdHB2?=
 =?utf-8?B?am01VUh0dmxsMG5kdGg3NFk3QVpmeXF5cXBWSmoybnpCcmFoZnBCKzVrOHBs?=
 =?utf-8?B?dmhGdEEwSkF6VDlPUUJOK0Y0aGJjR2UwVzlLZHU0b2RDVHl1bkNpbFcwY3hW?=
 =?utf-8?B?MDRaT3poU2JPaitEUEVvcUVKODBpb2U1TythbTJ5ZUVBbTI2V0JUZDZiV0R3?=
 =?utf-8?B?WkQzR1o0UmhpUFREajFZMVpDcVJnWlgwRzFKa1U3dlNkaTVGdklNcEFOTXdt?=
 =?utf-8?B?eTNwb1FFNFNaSjR3Qy9PemlhTjI2czdUY1NocmJJMkJMb0U1SFZQVXhNUTZu?=
 =?utf-8?B?Y0pNbWgxMzJVQ3ovdC9wQmwrdDkxU00rRng1SGQ1dmM0T1dlVTVnWnZDRldD?=
 =?utf-8?B?aWxMb01IQ0k2K1JpdXhmRE1DSVVlMnFvdlg5dEc1cS9qcEhndFpheUk1NU0w?=
 =?utf-8?B?SThLQU43c1JVaEdXdGNlRkRjN2NWbEtETkU0QVFlNEhDTForN0RmS0N5cTAy?=
 =?utf-8?B?VXFFM1dXU3VCc3FCbUxxV1RXMXFkaHlkNTdWSjhYQ3dyVU93aHFRVkp4ZE5D?=
 =?utf-8?B?djJrWHRRbzF0NlhNV2drY2lxTWNRclN3MEFFVy90Z29tWTJiZjJnOWxKRklq?=
 =?utf-8?B?bS80R2t0WkNVZzJscDFEZnUrKzJRQmNlSjFDaS9kMjl1R0ZYcnBCVnAwQWdE?=
 =?utf-8?B?S21xM0pDc1QvbHloMHZHMmJVQWZiK3RidDJsQ0oxQXpaQnpSdzN6TFBST2ox?=
 =?utf-8?B?QUJoeGJRY3Z5dDJhVWZ3RFhZNGRhcHdnUFBnZmR2aWFoSFowRVlVWEs4Vk96?=
 =?utf-8?B?WFdFMFhaeFBaa1RLYzZEWHhzQTVmMUhJVVVCbEtQd0R0aHpPOEtYNHgrWlBq?=
 =?utf-8?B?VjU0aVd0b0ExYWFtaEFGWmZMK3NxWXNwSWszQkJzV0hKS3o2VEdweWpIdTFP?=
 =?utf-8?B?ejRNYnBpR0QydXI4YVFWTi8zQnlOendDSlNMZGZYRG5kWXFRYXJ1ZTZzN245?=
 =?utf-8?B?NVA4QkFzZndGTXJGRU5ESTcxVXIydGY5WUhHZTUvd20vRW1FUVliV3FNTW5h?=
 =?utf-8?B?L1lvMGY4dXZkSzNFRE9YVVhXVlZJSVNBMWs0b1ZMWm9JQkk1ZjA5RnBkZUM0?=
 =?utf-8?B?TDhXMGJ1Sjg1Ry9ibU5VSS9ra1VZRk1OeU5SVkxSMTRlQjdsMWlyZmJPL1pB?=
 =?utf-8?B?Zmh1OUtqdS9GSzhZSnphTG94eTZNRC85enNRQ3VSNHBxbDYzMlgvRlV1M2Zu?=
 =?utf-8?B?Y1lReUhrRy9ucjYrbXpKNnFBKzBuNWRLRjMydVFjdHFhRS93L1MyNTZSTFEv?=
 =?utf-8?B?RTBqdDkzeUxtM3hLMFFZTHlvRGE0dWZvV2JtQWx4V1VkYUlmOWFZMkErZTBE?=
 =?utf-8?B?dThZOHpHZWdEbmdlckxYajJHQ21Kbm85bmJIMXNJZjJ2MWdNbFJHS1hHUHRv?=
 =?utf-8?B?dk8xWFdyUTBWNVdaYnA5ODZ6ZEN3Nnl3M1pydndtVHlCcWZtcjN6RGpJRWpa?=
 =?utf-8?B?azRZNU9qYUhRekt3T05pVnhrT2Z3VnF1K241eXRKSlJEdkxFRStValFLWFRj?=
 =?utf-8?Q?q86js9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0hlUUY2U3ZhZVpQeDQ3RGdiRzBvcFR3WW8rOGtaV2JSaFlXL1c4cnRucWsv?=
 =?utf-8?B?azAyQzFIamxrVEVPOTUwM2o4bHRzU0tSOVRJeXlnc2FRRXJmL3VOeWVsamFU?=
 =?utf-8?B?Y0JyeE8vQkpGWjU0UHNHeVlVT3VlaUUwamhYMmhWVVB6TW84bjR3UjZ0M2d2?=
 =?utf-8?B?TUNyWTFwM3hKNlh5YmFkSFlONURoenowYi8vYk92VFNXSkoySHRtNUQ1MVFm?=
 =?utf-8?B?dE1OSUxmN05zUWJWYmEwZWRrMVNTRGlZQXRoOElFWC83OVVFSTdMbWF5eUF3?=
 =?utf-8?B?Ym1FQjEweFBNVkZvaTI2cEZsQkYrOUJpektGc05OL0hPeHNBcVRlNlRMVDly?=
 =?utf-8?B?RDVadmtyblFZcHo5bHBVTnFSOEFtMHE5Z3g3L2ZhbVlkTVpJcEx0ai9oMVJP?=
 =?utf-8?B?RGhac3BqdDJ6aW5XdVNwdVBzK1hMN0UyYWZWcXFwRS82ZDgrdFlCcnNyaGQy?=
 =?utf-8?B?VjJLeDFkaVFuL3dTRU9JNXM1K2x5cExYNFQxdUx4cU5mTGNUem9yN3BxZFRw?=
 =?utf-8?B?UzQ3cDJmMHkxbHlyVjFTckNDR3dPZTRQVFdubFRWdldRVXJSa3hrUXRHZHNi?=
 =?utf-8?B?S2JjZDhuOWV5MnpxNDB2WEk0d1VnNFNBbXU1ejVHYVIvMlFKdS9BUVlSbnps?=
 =?utf-8?B?eFFzMjZWWlBjSlY5N2JaZDU0Z3Y5MGpRRjNvSGZoQVFFbDByeVhLUHhtbWht?=
 =?utf-8?B?Rk1mdXNtS3FSOEdKcFc1QXlGQSt1QTdCMnNWZXRsMW83MDN6aDFxSVpyL3l5?=
 =?utf-8?B?cnRjUVNrOUFFM3dhNitGeXV0RFBJQ3lQQVJBTDEyMnNIVnpGbDhDRys2VFg5?=
 =?utf-8?B?c1NMK2FYWXRKY0VlckJDcUVuQjdHN3RuaFlYKzVKUHRBWVJHVGROS1FLV0Vi?=
 =?utf-8?B?Tm1heXZKUWRjZ0VPRzdmWjZlczMxUk13cHFId1BDS3hST0hMNU85cnp4YjBy?=
 =?utf-8?B?ZzY0bmpzYnlKNGFEK0w0K2NYdXl6UVNPeVZUSC8zSnlFcEtKdXZJL0R1WWhy?=
 =?utf-8?B?S2ZHbExGZWxEN20rUm80U0ZkNVBqbUg3TG9lQVVWT2JqSnQ4Z3FZQkxQUmJx?=
 =?utf-8?B?VHlIOTc2ZHlZVzRGcis2MzV4VGx4cnFWMHVGQllKc2RUdUJWNW1PODB0OEQv?=
 =?utf-8?B?MEJXSWVzbCt0Um9RY3E0L0pTNWk1OU9PMnMwVkJ5bVc0ZjU4bndHUFNMQ1kr?=
 =?utf-8?B?M2NHUG9oa3Ryc29uUFpmc21qRVZZZmpKVk82WTV2YkNkTTFUNDZZTWhXN3Uy?=
 =?utf-8?B?T0F3NXZ1U3dNYjBtVVQ1OGRMbGtSTXJmUU9abkhsYmNvSEpVYU5ncDR4c2VG?=
 =?utf-8?B?VytKZ2lvcTFVdkVvU1NpMXNmZldxQzBTRUk2VUhyWTlPWHp5MEp2cWVmMjFO?=
 =?utf-8?B?TnlWcHZpdW1SUFNKMVgwV29GMUFnRi9BTHQ4SWpURkZ2VXYxWVp3dDVQS0pr?=
 =?utf-8?B?SFZUcy9sek9KQWg3VzZVMWdmOG5GNlZrc1BUeGVUZjRmQUVsQUZoeCtqK2JN?=
 =?utf-8?B?ZEdFN1FQcU55Y3diSE41RXdRQisremVkdEhLK0UxRHI0Q0xBWUUwaG9VRUZW?=
 =?utf-8?B?dmNMVG45MS9LZVIrNGlkd05KcHA4UWpYTW1obFJVSTV4YkV6VWFnZDk5ZVd1?=
 =?utf-8?B?cDZjdE5lbHdJNkdCTlBFK3ZlRGx6aWp1V1JsSW1sSGc5N2VwWmg1dnp2OEtq?=
 =?utf-8?B?dG5zNkEvZWhzb2wzdEdEbnNSaWpzQnNzdEZzMEdPUjFRQnFmVU1SU0ZZOVJn?=
 =?utf-8?B?cmJBQTdWWTFRY0JkT2VpVnNReE1tY0FKWktyUXB5djlydFN3bzgrZkhqL1Vj?=
 =?utf-8?B?Wi9uQjFQVVA0ZW5nQTR6cTdvK1grdEx3SFdEbkxEdm9YeVBObWY0Q3hnamZt?=
 =?utf-8?B?Q1BaSWlOMXJCTXdtT29yYlcybXQ3aGlMdWkzbkNPTjZFLzBpY3o3dlMwYjJO?=
 =?utf-8?B?R2JUSGNtY3VSeXIxcHpJbzluejlkdGtoODB4ZnVKY1JNTmZ1L0E5ZzhuaXhD?=
 =?utf-8?B?VFk1NkJZNkFBOW83WCtodHFkcGp2aFNTdXluOWV4Y05aSHV4Z3BERG1lRzAx?=
 =?utf-8?B?KzFFWUdVTVhpYTFKa0V1VXZWTGJtZ3RiSXNRVkIxMkFKVktoMk1VWGE1WWdP?=
 =?utf-8?B?WW1pSjQzMnlqME0yMFVCTnJBSTZFNTNUQVAxWjh6Z2dHVUVGRE1DdHdCbXFP?=
 =?utf-8?B?YnlXeERXWUJ1ZUtDSVdMUzQvOGQ2SnBLNEhnT3NJdys0c2dWb2dVcWRhWERR?=
 =?utf-8?B?cjFzYUU2bnZra25pRG81ZEk1VW1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB47BBD5B36D34A83D9E14FEAB363F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GGNjqIzLjA0Nf3ZyM6Hp8AvBpJqFHuYyUuKnjEjd2zCDPe4dzNBYX+e42VgOdcNpzYeKsH+13FP1J3DxblTk7AZJO3uehJul6sdbTPFP5nM2Y42+01ypKHdPSaUiVzjbNtftfGkTy0yFXL+GiwuT2eXfcw9OHfY6OUxCblMIyUEUfzmipoz7kI9MmBGoWQn5l4Ht3oX6tiGCWK307FSp/kj6jdRn7wE7garCQycGfqkOexs9i9WT3CSwJQgbqZjBtVAFJwNOf638W0JgqhkD/Hl38Dz8x2k6hKn1atDV0lu6H813Sj0fSDTVZeqyWIWIHvzM10PelYthhz8E/Dw51UkERb2DKCojIbF44n3qgUhSn04kFxKKF2s8zVxc05vl+FZ78Fh8eBfrTpJNfQKsZZ72G15aVR55UIFIzqlyNdgk2cQvaBj8+CYY4g5HiS5pMTeIpFqXPXFXMG9LoF4yCtk4zdsR8oGpZO0g3YnYEONUYln0xuxpw9dhM1/YTxqTTGjbEs0cdLbVBYTwxSDVJ5RKyBfGV3RJpKJEU5vuVfWS3xaKATK0TMGNMoFstfUt6EMNU6/G9BTbFfPGTy8+BR6MVdKj7d4AdQt5k2yWUem8XoDLD7F2reSNtteL0uC3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cb2aa0-0584-4e13-bc98-08de30a31676
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 06:30:14.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECXocZguT1xzxzUzgOH9y1TLbPqd0x9Rbrp5yAJbjoGdPSF8oj6Dc1eBqcCJi5I6T9WNPURHuiQF/JrxN/JfhJVDWd0Ybjv8FKadINkHSUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6963

T24gMTEvMjgvMjUgNDozOCBQTSwgSEFOIFl1d2VpIHdyb3RlOg0KPiDlnKggMjAyNS8xMS8yOCAy
MzowMywgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+IE9uIDExLzI4LzI1IDEyOjM2IFBN
LCBIQU4gWXV3ZWkgd3JvdGU6DQo+Pj4gL2Rldi9zZGQsIDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1
NiBieXRlcw0KPj4+IFsgICAxOS43NTcyNDJdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiBob3N0
LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlDQo+Pj4gL2Rldi9zZGIsIDUyMTU2IHpvbmVzIG9m
IDI2ODQzNTQ1NiBieXRlcw0KPj4+IFsgICAxOS44Njg2MjNdIEJUUkZTIGluZm8gKGRldmljZSBz
ZGEpOiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+
PiBbICAgMjAuOTQwODk0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RkKTogem9uZWQgbW9kZSBlbmFi
bGVkIHdpdGggem9uZQ0KPj4+IHNpemUgMjY4NDM1NDU2DQo+Pj4gWyAgIDIxLjEwMTAxMF0gcjgx
NjkgMDAwMDowNzowMC4wIGV0aG9iOiBMaW5rIGlzIFVwIC0gMUdicHMvRnVsbCAtIGZsb3cNCj4+
PiBjb250cm9sIG9mZg0KPj4+IFsgICAyMS4xMjg1OTVdIEJUUkZTIGluZm8gKGRldmljZSBzZGMp
OiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+PiBb
ICAgMjEuNDM2OTcyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYSk6IHpvbmVkOiB3cml0ZSBwb2lu
dGVyIG9mZnNldA0KPj4+IG1pc21hdGNoIG9mIHpvbmVzIGluIHJhaWQxIHByb2ZpbGUNCj4+PiBb
ICAgMjEuNDM4Mzk2XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYSk6IHpvbmVkOiBmYWlsZWQgdG8g
bG9hZCB6b25lIGluZm8NCj4+PiBvZiBiZyAxNDk2Nzk2MTAyNjU2DQo+Pj4gWyAgIDIxLjQ0MDQw
NF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiBmYWlsZWQgdG8gcmVhZCBibG9jayBncm91cHM6
IC01DQo+Pj4gWyAgIDIxLjQ2MDU5MV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiBvcGVuX2N0
cmVlIGZhaWxlZDogLTUNCj4+IEhpIHRoaXMgbWVhbnMsIHRoZSB3cml0ZSBwb2ludGVycyBvZiBi
b3RoIHpvbmVzIGZvcm1pbmcgdGhlIGJsb2NrLWdyb3VwDQo+PiAxNDk2Nzk2MTAyNjU2IGFyZSBv
dXQgb2Ygc3luYy4NCj4+DQo+PiBGb3IgUkFJRDEgSSBjYW4ndCByZWFsbHkgc2VlIHdoeSB0aGVy
ZSBzaG91bGQgYmUgYSBkaWZmZXJlbmNlIHRvdWdoLA0KPj4gcmVjZW50bHkgb25seSBSQUlEMCBh
bmQgUkFJRDEwIGNvZGUgZ290IHRvdWNoZWQuDQo+Pg0KPj4gRGVidWdnaW5nIHRoaXMgbWlnaHQg
Z2V0IGEgYml0IHRyaWNreSwgYnV0IGFueXdheXMuIFlvdSBjYW4gZ3JhYiB0aGUNCj4+IHBoeXNp
Y2FsIGxvY2F0aW9ucyBvZiB0aGUgYmxvY2stZ3JvdXAgZm9ybSB0aGUgY2h1bmsgdHJlZSB2aWE6
DQo+Pg0KPj4gYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBkdW1wLXRyZWUgLXQgY2h1bmsgL2Rldi9z
ZGEgfFwNCj4+DQo+PiAgICDCoCDCoCDCoGdyZXAgLUEgNyAtRSAiQ0hVTktfSVRFTSAxNDk2Nzk2
MTAyNjU2IiB8XA0KPj4NCj4+ICAgIMKgIMKgIMKgZ3JlcCAiXGJzdHJpcGVcYiINCj4+DQo+Pg0K
Pj4gVGhlbiBhc3N1bWluZyBkZXYgMCBpcyBzZGEgYW5kIGRldiAxIGlzIHNkYg0KPj4NCj4+IGJs
a3pvbmUgcmVwb3J0IC1jIDEgLW8gIm9mZnNldF9mcm9tX2RldmlkIDAgLyA1MTIiIC9kZXYvc2Rh
DQo+Pg0KPj4gYmxrem9uZSByZXBvcnQgLWMgMSAtbyAib2Zmc2V0X2Zyb21fZGV2aWQgMSAvIDUx
MiIgL2Rldi9zZGINCj4+DQo+Pg0KPj4gRS5nLiAob24gbXkgc3lzdGVtKToNCj4+DQo+PiByb290
QHZpcnRtZS1uZzovIyBidHJmcyBpbnNwZWN0LWludGVybmFsIGR1bXAtdHJlZSAtdCBjaHVuayAv
ZGV2L3ZkYSB8XA0KPj4NCj4+ICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3JlcCAtQTcgLUUgIkNIVU5LX0lURU0NCj4+IDIxNDc0ODM2
NDgiIHwgXA0KPj4NCj4+ICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdyZXAgIlxic3RyaXBlXGIiDQo+PiAgICDCoCDCoCDCoCDCoCDCoCDC
oCBzdHJpcGUgMCBkZXZpZCAxIG9mZnNldCAyMTQ3NDgzNjQ4DQo+PiAgICDCoCDCoCDCoCDCoCDC
oCDCoCBzdHJpcGUgMSBkZXZpZCAyIG9mZnNldCAxMDczNzQxODI0DQo+Pg0KPj4gcm9vdEB2aXJ0
bWUtbmc6LyMgYmxrem9uZSByZXBvcnQgLWMgMSAtbyAkKCgyMTQ3NDgzNjQ4IC8gNTEyKSkgL2Rl
di92ZGENCj4+ICAgIMKgIHN0YXJ0OiAweDAwMDQwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgw
ODAwMDAsIHdwdHIgMHgwMDAwMDAgcmVzZXQ6MA0KPj4gbm9uLXNlcTowLCB6Y29uZDogMShlbSkg
W3R5cGU6IDIoU0VRX1dSSVRFX1JFUVVJUkVEKV0NCj4+DQo+PiByb290QHZpcnRtZS1uZzovIyBi
bGt6b25lIHJlcG9ydCAtYyAxIC1vICQoKDEwNzM3NDE4MjQgLyA1MTIpKSAvZGV2L3ZkYg0KPj4g
ICAgwqAgc3RhcnQ6IDB4MDAwMjAwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4MDAwMCwgd3B0
ciAweDAwMDAwMCByZXNldDowDQo+PiBub24tc2VxOjAsIHpjb25kOiAxKGVtKSBbdHlwZTogMihT
RVFfV1JJVEVfUkVRVUlSRUQpXQ0KPj4NCj4+IE5vdGUgdGhpcyBpcyBhbiBlbXB0eSBGUywgc28g
dGhlIHdyaXRlIHBvaW50ZXJzIGFyZSBhdCAwLg0KPj4NCj4gIyBidHJmcyBpbnNwZWN0LWludGVy
bmFsIGR1bXAtdHJlZSAtdCBjaHVuayAvZGV2L3NkYXxcDQo+IGdyZXAgLUEgNyAtRSAiQ0hVTktf
SVRFTSAxNDk2Nzk2MTAyNjU2InxcDQo+IGdyZXAgc3RyaXBlDQo+DQo+IGxlbmd0aCAyNjg0MzU0
NTYgb3duZXIgMiBzdHJpcGVfbGVuIDY1NTM2IHR5cGUgTUVUQURBVEF8UkFJRDENCj4gbnVtX3N0
cmlwZXMgMiBzdWJfc3RyaXBlcyAxDQo+ICAgICAgIHN0cmlwZSAwIGRldmlkIDIgb2Zmc2V0IDM3
NDQ2NzQ2MTEyMA0KPiAgICAgICBzdHJpcGUgMSBkZXZpZCAxIG9mZnNldCAxMzQyMTc3MjgwDQo+
ICMgYmxrem9uZSByZXBvcnQgLWMgMSAtbyAiNzMxMzgxNzYwIiAvZGV2L3NkYQ0KPiAgICAgc3Rh
cnQ6IDB4MDJiOTgwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4MDAwMCwgd3B0ciAweDA3ZmY4
MCByZXNldDowDQo+IG5vbi1zZXE6MCwgemNvbmQ6IDQoY2wpIFt0eXBlOiAyKFNFUV9XUklURV9S
RVFVSVJFRCldDQo+ICMgYmxrem9uZSByZXBvcnQgLWMgMSAtbyAiMjYyMTQ0MCIgL2Rldi9zZGIN
Cj4gICAgIHN0YXJ0OiAweDAwMDI4MDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdw
dHIgMHgwMDAwMDAgcmVzZXQ6MA0KPiBub24tc2VxOjAsIHpjb25kOiAwKG53KSBbdHlwZTogMShD
T05WRU5USU9OQUwpXQ0KPg0KQ29tbWl0IGMwZDkwYTc5ZThlNiAoImJ0cmZzOiB6b25lZDogZml4
IGFsbG9jX29mZnNldCBjYWxjdWxhdGlvbiBmb3IgDQpwYXJ0bHkgY29udmVudGlvbmFsIGJsb2Nr
IGdyb3VwcyIpIHNob3VsZCBmaXggdGhlIHByb2JsZW0gZGVzY3JpYmVkIA0KdGhlcmUuIE5vdCBz
dXJlICh5ZXQpIHdoeSBpdCBkb2Vzbid0Lg0KDQoNCg==

