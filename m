Return-Path: <linux-btrfs+bounces-17687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52926BD21FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66614EE768
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7E2FA0F5;
	Mon, 13 Oct 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RurDfHHK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PubIFKKY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F62F9D94;
	Mon, 13 Oct 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344996; cv=fail; b=WpVLzrbROhok3Okp7uKTPb1dFFrh5OeaURQkhdPV+z6pmcIOhwWfTxzS57WY3e4J4fPu+LLKJbkyCuoMtn1ZT44O8hoacfapri8xu2gQ/4ntttluZbpSyq+Shu1WVPuXMBEKJflutWEfJbUefsZJ4iAdjGN/oNnWJvrZ7nOSvek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344996; c=relaxed/simple;
	bh=Cy40CaeoRVTt3+Ijx0p1RmbzdVsjAtJli4yBP902GE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8lGECDeqjLN4P35JeAheEQgP2Y1hlfmZ3iN84Yima9v65w7tXnZ9BD+O3V/0LJJlWoqhQQdL5wck4F+GqtlmwBBykFCZXhixMLEnjlfjkbrUnuAC5o571ceZvPQFkIlFLdAIlvOJAQpiMJviSUEEe07xG53FK08AyRis1qVw2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RurDfHHK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PubIFKKY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760344994; x=1791880994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cy40CaeoRVTt3+Ijx0p1RmbzdVsjAtJli4yBP902GE0=;
  b=RurDfHHKVYFwok4yhrHVjQKxpd6PFpMN+BeHsn+bMTHCTVihs4GR7P8L
   I0yMDB5aSWiO9n2iywSbL5+1ftEExDZodOb33W2MBS3xGfiPnadHWk1ra
   HVSuuzKVCZqz7vi7LU3sEduSaqmYSDWYrH601X9riNhBduoX18jG3alES
   PiUeSNDw3KoVaEPKWbElSC7nxhgOIo8QuixNN48/H7nBW51gzgrHK3MZU
   GWEMSRvwvcpdBmRFFe6BbS5bmhIbDQL1SF0QyLwxGqwjaOQIhWdNMeAqL
   msfEr/MOgxPEGv92yptSv9OAxC+sN4PjF/3+92y96XYxQYty21ohTmb+C
   g==;
X-CSE-ConnectionGUID: 2OXcV9QHS5eg9YJaTXQAAg==
X-CSE-MsgGUID: fTwxxpSPThmMMcXAI9bkhg==
X-IronPort-AV: E=Sophos;i="6.19,225,1754928000"; 
   d="scan'208";a="134328730"
Received: from mail-northcentralusazon11010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.2])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:43:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7IKq9Ny2ZektRIhuc/mrkAwyApWMelEdiPskTDm3SS6pFRwRosv4mfSUyuZojb8X+QSy1yE3X8p3IsInDep8lRsWLIVHs//5B+g8tYevM98QKSCfE69zyRrMEaL+ecsvrmwjqgoTzLmOeELoFWern8GRWFMYXJb7Vcb8vZJul4znff3D9FchE0lXa9vy6/ezYxby8ryrbArvpjePR+Ug9SGv9xUoqzWuMpg0e7lbhFvxpvf191ZErafi/FW/YNK4PvWF3SxCsWyfn9U4yme2X2aOvEClaHwWyJGGcLkuoa/+UTNvVul3WECucT4vnHScPepzRZM8hp40goPl6kCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy40CaeoRVTt3+Ijx0p1RmbzdVsjAtJli4yBP902GE0=;
 b=GI4w8OEdusmSJqlEkmVI+AKPogsQRPoR70eEqprO3ujyhJ18nPcpyeoBcKzPsvQMREODDczb6hnYhpHkY3ePMtBhLLi3ap4/PHMNscPT+OkXYWlRdYQTqWufn0RVBnp+aUaixiBwqWpvc5DpfLfSVJGmKaQZ913DJKLcQ2GqA1EebWqCKHO1FKbsDtLx0/PmS81H/ZQguEm7ka+xv5KRsGHhoKl/MSL8Yht9r3vg9qJ8QTNeq3oFJCd1T6Bee145me9uUFAZycu/Ep1tunVhudKtZZ/5bZRo/AbLw2qixNm6EHbtbOozkoEsVQ9cMAvIIYiABs0aR1MbMzezm6fS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy40CaeoRVTt3+Ijx0p1RmbzdVsjAtJli4yBP902GE0=;
 b=PubIFKKYuKxEFUgnSBNs3X1zSt+1F4wFk0h2ri8l3C4sjFAnWhYsz4G7dPNUFvnTnx21U4fG03kJB3MriBMkTNQ2e7brYIIpFQizceF+3mXWl4jvUwxO6MGIwXU1UzExiIK5QAVeO+xwBnrPWBpMyDCluFSgCyA3Eg4b4rfKOAg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7612.namprd04.prod.outlook.com (2603:10b6:806:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 08:43:05 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:43:05 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Zorro Lang
	<zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v3 1/3] common/zoned: add _require_zloop
Thread-Topic: [PATCH v3 1/3] common/zoned: add _require_zloop
Thread-Index: AQHcPBiHAqwxoZUP60CfNsDRBQ3oW7S/wlKA
Date: Mon, 13 Oct 2025 08:43:05 +0000
Message-ID: <DDH273RHVKTZ.1FFRTX85IGP64@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251013080759.295348-2-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7612:EE_
x-ms-office365-filtering-correlation-id: bc60d27e-20d2-4d37-9eb3-08de0a348751
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTM1SkZPQ2FZaU14azBCV1ppRExtS2oyR0JTY2QralpuV3Z1VFFnYlJJMnps?=
 =?utf-8?B?SVdZWTZhUWh4MTFWaEZHUFZNSGxpRFBHSkRVMk13VGptdHIwVmk5L3hhYnVX?=
 =?utf-8?B?dVdQait6N0NXdWZ6UEI4MllmUjN3RGxhMkNJRzVCYjlGaFpROXVhZjVDMjRB?=
 =?utf-8?B?NGZjdjFWdngvUTYwYzFvNDBEZloya05EQytpaWpsTTk4WFFJMnlYSlh3d0Jt?=
 =?utf-8?B?SDlYN29NeHYrVEIrL2RIRW5zWWd2UE4zUTBDVVdFK3pyNHRrVGJRWGlZSE04?=
 =?utf-8?B?ZlIzeDVPRHpnNVVTT3JRRnFsRHlJem4xeXpwbjRYUkErUndnMkxxMlpsYXpv?=
 =?utf-8?B?ZnZXZmZMWkVYNHNqajBDcDZkNzVycVNST29ZS205bTRsR0Ywc05ER25paDJs?=
 =?utf-8?B?cnl3YkkyTVZJRVcweDJOeXNSN2JLeFhDY29UQzdqbkhKRDBXbWFvUUwvbjF4?=
 =?utf-8?B?MDhLUUIrcVh0S1hlZlc2bW5paEJiVDI0dUNma3FSL3JHVTJnK251L2l3dGNT?=
 =?utf-8?B?UGRucHpCY3ZjdEROUHM5SjVuQjBzaXp6ZUg1WlpuRGVSa2RsM3g4S2JCVW5R?=
 =?utf-8?B?b1psWkNIaUxHU3ErRnNsRGREaVJjckkwR2lsc2lRVGlZaHUyZFFWYjg2blY0?=
 =?utf-8?B?Z1JKWi8rRjhLMmtncy9IR3pUYVgzVUliL05vblF0TzRrcXl6K21jVDh4Q2xD?=
 =?utf-8?B?S1Y1dDU2YVJCWmJOZHpVRFQ4bVRGK3h3T3Flb2ZqWmVhM05YOHZadW9qbC8z?=
 =?utf-8?B?RDlpZEl4ZzNMWmE1dW1mYms5cUZnaVdsQVM1RGtvd25xUTE1L1lIdGoyOStU?=
 =?utf-8?B?aS85MDJ4dDRLNnFwSGhFTHhjemZmNEsraEc5V2tGVUhLcTNKUmhVMjd2dkR3?=
 =?utf-8?B?TDVrUGRVaXpUS2t5T29lSVgwRWE5RTBkVFF5S1FGZlhQTWw4VlN3QUZwS2Fy?=
 =?utf-8?B?L1I2ZFR1YncwYW44dlFRMUxCVnRRbUs3bjdtZTVkRGxuU1M1eEQ1cDNGVVVM?=
 =?utf-8?B?K29GQjhHOHlDWi9HcmdGNWJGb3piYTNpMkZ1SFhUTmVUT2tNRElpZUlxb0pm?=
 =?utf-8?B?ZzRhdjlCa3J5RDBpT1Y3V0MwdElGcWxLYi9LU0RhZHdwb0N4ZzRFUjdrNVo1?=
 =?utf-8?B?YnN3QW5seDk3dCsxS3JMS3phMUlxeTdsSEYyVzVXK0JCUUczNEFTdjI3b01m?=
 =?utf-8?B?aHVpQmdMbU1YZE85bDN2U1VKYmhCcGN0ZStpVWcvcUpUY0VUaXhMTkFuVjVv?=
 =?utf-8?B?THlyc3poVURmMWw5MzhaZGpJSTZKVnpLWFFncm91b0swdWJvTFJnWitYNVlq?=
 =?utf-8?B?TWNHYUF6bVhPS1hvMDNqTWFORmxsYnlQY2RCWGxNRFpxdjFMbGZjWERJaW00?=
 =?utf-8?B?UksyaFkzdXhpOURsT1NROW9Cd1BLcE5NSElhd281by9FMUQyRVR4TE55ZGQv?=
 =?utf-8?B?d3dBdmpvOHpWQVA0bjBTQUgrNWswQThFaVJxbDhkQTBFN0ZFU3FNQ0drbGV4?=
 =?utf-8?B?YmNOb0U5OWlkSHFJUk10TTR1cE05VmFQTTFrcWNHcGNQL0hJQTd5TklPYkpS?=
 =?utf-8?B?bjIxU3QxOE9abGJwU0ZKSVFQRVJ5dXVjSGF2SHhpKzhabVhzYlllQ21kdVJN?=
 =?utf-8?B?UExQakRGSzJ6cXR6REVDZG9sTmJadVN1K0ZGU3MraEpOQ1ZJRWNsakJKTmhU?=
 =?utf-8?B?ZjVTK09DVFJDSXFWN0dXUDdjdUYveDN1TE5DaXF0bm9VRnpiYTZWVDM5MFV3?=
 =?utf-8?B?cGg4K0dnRy84SVZZOUIrSUFGOEhUMXZPbTV5Vm0wakdONzZKdFVwK0o5dmNt?=
 =?utf-8?B?NmVwdzQ0djhUYkpYWXgvS0pBSERPM2UwZktsR216dm0zdmJaQW02Y0xpS2oz?=
 =?utf-8?B?emd5Mk15RXQzTEp5cDZjVE42ZE9uZmIyUTd5MDlWcDZzZVhiYUhBRnFqcjY4?=
 =?utf-8?B?cEV6UmxsVitRQ2d3OFp1ajlTZEYxbWYvYllYaDJhbEdIRm9XYm1oaXhuanhQ?=
 =?utf-8?B?Zkd1UVI1ZmxwRWptdlJoWXBWd0R4dElzYnQxNEFzUzF3OXhIN3JpTjJSTUo1?=
 =?utf-8?Q?d3qvCD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2NBbW92THAyQXg1MVovZDlvemFOQXY4TDZ0K2g5Tk5RL0V0clRaTElzMlZj?=
 =?utf-8?B?amV1R1hYRFdoSHl3Rk9OYUZaQk44L0EzUnZQWGlaWjAzVWg4Tk1XaDl6aFhH?=
 =?utf-8?B?U2xMUUhQc2hXanRvSVNhNFgxNWF0eFM0T0tmTjZ4KzR6WkdqYmpGd2pOKzlK?=
 =?utf-8?B?MW01YkJnZ2UyRXYzdHU5R2Z1enlqK0xrUXdJZU1FQ3ppOEgza0lZdXlYMUxL?=
 =?utf-8?B?VUpwTDMyMnh1TVlSNzlZNlB4Um1rb2lNVThiTWxFK3BISkI0dm1qZVhGbVgy?=
 =?utf-8?B?VTFBVk1NOEtTL1QzQWZlQ0ppemNEaURhcTlzRVRsYlNySmwrclhNTzAwR21O?=
 =?utf-8?B?QzViSjRtWGNwY2VIWlBTdEJvWktBKzM0dG04ckR6dFg3a3VqZWkxejNaY29Q?=
 =?utf-8?B?Tnc2SStWUS9NYlREWFM0d1M2NCt0M2lIRmE2VWhGUEhsdnZlelJPZURhR1FI?=
 =?utf-8?B?clFva1hXNHlIOFZHdlRUWlNUZkZRMUF4U1JGdVFYWkNma2MxN0N4SmgyckYw?=
 =?utf-8?B?ODFlOHZRNUNCRnFuUVdOVE5jUXNHYXdHajB2ek9iLytNaUJodVdzaHc1T2RU?=
 =?utf-8?B?dnZhL0VuTDVzbUIxdEI2aDY2NXJjbkJ5WnFaa1B5Ui80Mk5MSjI5bGk4TkZV?=
 =?utf-8?B?c3hmZFNyZVFSbzZJOStzelNtdDFSdzlHSGlmc0pOZ2RkZVY3alpkbXRsY0ZH?=
 =?utf-8?B?MVJFdktudHIyYm1GSGhxOVBSN1Jka084bllvNVNZS2FNVjV5MHl2VTBlRE1p?=
 =?utf-8?B?eDBWdlRscFh6LzNINnAya1Z0dEF6bU05M2h4RVNoNDZNNUZZcnJzbzFvYit5?=
 =?utf-8?B?dUtPSXBvV01heVVHK1lMMHJHUmR0WmdxbUpwT1ZKOEdnYUsyQ3QzOW5Mc3JB?=
 =?utf-8?B?amNqdnNVclFNTEdRNmZWTjRQbWFYaXZmc1phbnpCRllzNnpTUWgrTXNuam1j?=
 =?utf-8?B?cTVkL0V2RVA0WmVmY3YzZWZNZ09HQ01kVW1VT3ExSEJlQ3NwYUJBWEs4S0NZ?=
 =?utf-8?B?WnZhYmtaTWRNQVphUFc3aFR6UlNnUHlvRFcxVUR4NXZDN3VxbTNPa3Z2TGhC?=
 =?utf-8?B?MGRuc0dZU2l0dGRkL3hzaURHV1JZTjlVMnRlZDV0YWVxU1VOT0YyOGJ2MllZ?=
 =?utf-8?B?cEJmNHpZc3Q5R1JhdS9MYW9YenRPbmlsVmlxVHV5OGFHRVhHR3ByWTcyMnhD?=
 =?utf-8?B?K2J6ZmpHMSs3UURiSmhzTmJxeExUQmFKMHlXT1lVcHQrdHZ5eWF2UnZBSmpM?=
 =?utf-8?B?RDlEYittSkVZdk9wcyttb3AvTU4yUHdYODA3eXdUZXVQckxTMGpERTYwbmxB?=
 =?utf-8?B?azFrWjdGZlU5ZEpVWDdyYk41bWpLclpia0ZyNmtwbG4xdE9nQVovTXZpclIv?=
 =?utf-8?B?bTZYMUc2cSt4NTJzQWlqbDJ3akNHeGdhNFRhSUs4QnpQNTArQTAvRTJpWTQ1?=
 =?utf-8?B?SE13V1ZKcUZYMTRYdTUxVmhOUG5Qc216amFoVUpzbDNIZUcxZGdFcDFGVk93?=
 =?utf-8?B?QXNrTEN4NGFHUjYra0pXNFFTWkxhcWZJKzlwckNuSWhIUDV5dUNQS3NKN0hX?=
 =?utf-8?B?a2s2Z0FsL0lDcndKb0wyUlBycWx6WXc4UEVwTUhtN0M0NU5jaGUrT2k5UEhi?=
 =?utf-8?B?TXpLNjB1K0hRcitnNEFtSEJsS1BRbVdJRi9oVWJ2MGg5Ni96SncrUy9GZlFR?=
 =?utf-8?B?dEFWTGViaDkrQ3BTYWZPMjJkaW1NYlhrbUF1cE12cGdOeGNDREdaak04aUUy?=
 =?utf-8?B?cTlFb09qc2dCeGkzcXJiaGRMbmxWc0JIMTdob3hWUS83MkdvZXNWNmROb2M3?=
 =?utf-8?B?ZzVCNnp1TmlGZjF6aUhENGFEN21jdXJxeC8rM2NrNllpY0Vra1VQOThPRFVJ?=
 =?utf-8?B?Z3VrK09OYndxcFA2L0tHQTJIN1RFaUhRbVBqTEp4VXZnamdtUW9sQktnVUwv?=
 =?utf-8?B?ajVuVzhqYmpONmxIMUR0ZU5idGpqNVVKTk9UaHYzOEd0T09mdFQzZXZhZ1VF?=
 =?utf-8?B?N1gzN05WbHdZeU1sd1BqcTYzWmxOOW9jZ2paMmptaG9najRnYnl0andFSUpu?=
 =?utf-8?B?NUc3OVdob3plYTRDMXdIL0hOZ3BDTmw4M2UxekVJY2VqSUVMZjlRUEZ4UDBZ?=
 =?utf-8?Q?6ejsNAM15ufTlbOhtt/txPJVJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB62707089C1CF4E839CEDC89D889A98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KisxuIfbSDdOl1NZ4hdT3qHBaOPdOoxsQpQeWvQbwCPuMxz/zigVQkiGT6uh82fZP3+X/gMQo90esSl9sVjhTlLhaWgSNYNRRigDBZ5bG2W9iiLyU1ZrdzLoAc6J+awjSBTCI10gsk0pL8IcW2+E85NUNasaJt2/UdZIe8EEQBtL08nTYe/a5BATtFI5yGOCqHPfiftSzLo0gWYcvLYWBcNp9yupoxelLMOW7CUubqMPCWYp91CMgNjv1+lUT7Co11OmwJqvOqPMMJS28XmctHUfCuIRjcF2UCNUCj9xwBVt/xB3ETGXVKMU3xEEBWzyTvHFuEFw+LprfbhYLL1oztiuPgLZ9VHJU6CsXho478LJ6/hkX3PixwCUX8UN+63giql24Cd22XxV+iHvBI8k+Esa+/1fKjzyrBfknp5tuYhaYbHrteltrbqGCbRRmFn2XZWgFunPjhVSdbTByUCTWmysx+INgV3hoO2MRKj82BXz+YeHMg6OvWHBT8d+6O+Aa3fc9pbQCzIKrzly6z7X+4fcOoGerbn3wVQ1orYKfoRhKLyd50pEsGhfWijGkmVf/VrYILoJH7J10to1gVKW+dbdSYYCU+wiOPoePM5XmgDgfFUp08xlFvKSqEwfYe7i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc60d27e-20d2-4d37-9eb3-08de0a348751
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:43:05.7877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcZxLQumnjHr18t5uV93JDECvOsz0LClPKUNWOXnra+GsvEyEtsn1uaCmzbWkD/HhuFarNyH9w1asahPN3Ch0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7612

T24gTW9uIE9jdCAxMywgMjAyNSBhdCA1OjA3IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBBZGQgX3JlcXVpcmVfemxvb3AoKSBmdW5jdGlvbiB1c2VkIGJ5IHRlc3RzIHRoYXQg
cmVxdWlyZSBzdXBwb3J0IGZvciB0aGUNCj4gem9uZWQgbG9vcGJhY2sgYmxvY2sgZGV2aWNlLg0K
Pg0KPiBSZXZpZXdlZC1ieTogQ2FybG9zIE1haW9saW5vIDxjbWFpb2xpbm9AcmVkaGF0LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5j
b20+DQoNCj4gLS0tDQo+ICBjb21tb24vem9uZWQgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9jb21tb24vem9uZWQgYi9j
b21tb24vem9uZWQNCj4gaW5kZXggZWVkMDA4MmEuLjQxNjk3YjA4IDEwMDY0NA0KPiAtLS0gYS9j
b21tb24vem9uZWQNCj4gKysrIGIvY29tbW9uL3pvbmVkDQo+IEBAIC0zNywzICszNywxMSBAQCBf
em9uZV9jYXBhY2l0eSgpIHsNCj4gIAkgICAgICAgZ3JlcCAtUG8gImNhcCAweFtbOnhkaWdpdDpd
XSsiIHwgY3V0IC1kICcgJyAtZiAyKQ0KPiAgICAgIGVjaG8gJCgoc2l6ZSA8PCA5KSkNCj4gIH0N
Cj4gKw0KPiArX3JlcXVpcmVfemxvb3AoKQ0KPiArew0KPiArICAgIG1vZHByb2JlIHpsb29wID4v
ZGV2L251bGwgMj4mMQ0KPiArICAgIGlmIFsgISAtYyAiL2Rldi96bG9vcC1jb250cm9sIiBdOyB0
aGVuDQo+ICsJICAgIF9ub3RydW4gIlRoaXMgdGVzdCByZXF1aXJlcyB6b25lZCBsb29wYmFjayBk
ZXZpY2Ugc3VwcG9ydCINCj4gKyAgICBmaQ0KPiArfQ0K

