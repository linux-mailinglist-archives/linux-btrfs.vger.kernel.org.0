Return-Path: <linux-btrfs+bounces-11602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C107A3D10B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 06:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605D27A80E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55519AD8D;
	Thu, 20 Feb 2025 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bZBzpo9w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z2LdGx6l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B52A930;
	Thu, 20 Feb 2025 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030920; cv=fail; b=tLHYNCxGRa+DYqPpDA1iGl6L6CScae67R831052zs6hUNBseDzWNO/df7FtWQDXk0rMAoAck6UNY5BT5wgzmg/eDHxN+9FGeDt7on4X7k1OnL6bXqUYNSIzHyMDisA7Dj97e5ggLpjlf1Z+JXcNqktxPbzE74HyY27biGLZWY+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030920; c=relaxed/simple;
	bh=4XWezNLG9wl0cFJRFWbeYx3QI2WmZwNpKXBFiOk2f90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2/Q6kQFc69plell91YUskthy/t3jIonAmmf/2adIfj2dU8esRjHSHEBo3GJIfFcA7FN46BgmL/S9A8YOU8NMUmM+xgxJTTCrbLMH1EQa+wY2h4fyhOAafBxy53z1yNVi/GjkyhhW0UvpWLIxvmqmeX78d9bYOXosrVIAngR268=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bZBzpo9w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=z2LdGx6l; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740030918; x=1771566918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4XWezNLG9wl0cFJRFWbeYx3QI2WmZwNpKXBFiOk2f90=;
  b=bZBzpo9w7HWf8CwQ2PZf0tkuTcaOCI8trxDz9tZWmB5yR/7FXXccVkON
   aYORQ/lDCYEuvo8QGT6W+M4LJv+U/65ebFTam9+pKNYybAHsLqm4Yoglz
   DiwlNyO6MbVzCfOXmO0mOX4yEX6yDQHq6y/+EQGDnG+3KQr4jBjTGg/20
   zX7c0TV7XD5uKk0UQR8PX/Teeqti2O+M02RD6hZ9tfJukoQklgvcgg+vr
   YJtByW+EZCw7Fu++IGoFiPqTlTzo08mZv/eW+ENeICu8Lykzltk5EShmh
   8E2YVuwru4hrD7U8rZLj1JpdmGP/dTW5+h1iC9BWdZaA6Ptp/y5IFWzB/
   Q==;
X-CSE-ConnectionGUID: oCweSAnVR2OTdXSH5RVotw==
X-CSE-MsgGUID: 9VFOZyBXQkWKiFJNPnfOgg==
X-IronPort-AV: E=Sophos;i="6.13,300,1732550400"; 
   d="scan'208";a="39964601"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 13:55:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fhj57esY+opAxr8yT2G6hDOXiDeDWllNT9z52F4i26yzNp8ePv25ytoUwWa8OLpOFJbyGR6SIZnWuF9ygYnpQI1KGO8kS2kqjRL79uNhbvOOzz9yYrHGpgYSMH6PkQD9+THpkfIE8iqsQpM52textJibk6aLa363edA0hUQ7CCl0m5q4IHsJ2htP9EoWPMnmwhLaaHEIObIqYnKmXbgbNP76IRhOMPC3vRYg+UxXWFuYAeMYT6cEAAfG4r+1Gfg6Fk7nEqSuRZr123oBmVuXOnYsl8lC0NQNmOSKydPxp0DmWn+FMa484X8YAVBeUBSpKvtKfSgCK2+UlhV/c8Ki+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XWezNLG9wl0cFJRFWbeYx3QI2WmZwNpKXBFiOk2f90=;
 b=paNdNR0JazpEs6OuK619APpI0NfopbaZ4ILfvPdcPqWCFES5ASYAyn8f1IEjHpT0gnICb37fdpIT7qv+QuweOSbg64IPSxx4CB7b1q+XQwGTuEEK47l0YDFBE1TRg6tsb49YJEPxUGLHccC9nkeGA+4Zcs+WKq42bC/w8LhCcT9lCiuYAz/TiIpIGlliRbk3Eij5/LIk7La436Chd9q7gj30pIczbhNcWGNYw3dVDVpO6ZZ5C/OpsUYYDTpp+/I0myAZq8f9amX/wn9Va6+7QHXQVV+VnVN6r8Ng656ZoZTvesvrQKN7f5+6dMXofzOluvDQodrAPaUxEZWeiVAiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XWezNLG9wl0cFJRFWbeYx3QI2WmZwNpKXBFiOk2f90=;
 b=z2LdGx6lnxTEuYQ0742aYLW9H5laCM2EFwpsrJPiO1vK1WxCV/EyQ5Yrg+6S0Zeqgms7ezXNmPrvzk+F5x0VgvOgwQje/FE492Kth1axQiOthxNLdgFiIB3toAYGUB0ifoKwrAJeX9F0IZOU0QmIVQKcucbDQFEynFxWfsOYY2s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6678.namprd04.prod.outlook.com (2603:10b6:610:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 05:55:14 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 05:55:14 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Chris Mason
	<clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: Remove some code duplication
Thread-Topic: [PATCH] btrfs: zoned: Remove some code duplication
Thread-Index: AQHbgtm6ZtcET3pLqEi3wHVM0EtebLNPslCA
Date: Thu, 20 Feb 2025 05:55:14 +0000
Message-ID: <D7X1HAEVN3TO.Z7JG9SRUODCE@wdc.com>
References:
 <74072f83285f96aba98add7d24c9f944d22a721b.1739974151.git.christophe.jaillet@wanadoo.fr>
In-Reply-To:
 <74072f83285f96aba98add7d24c9f944d22a721b.1739974151.git.christophe.jaillet@wanadoo.fr>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6678:EE_
x-ms-office365-filtering-correlation-id: 22854d14-b1aa-47f9-154a-08dd5173250a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjBCYW5rQVJXaUFPT3BSQmU1YVlHU3FBTys3aGlaY2lGOGtCRUNsV2VMY1pJ?=
 =?utf-8?B?Q3BoV0MreUdxNStINWpkL3B3bllVMUpQZ1k3YlhGbFNqWC9qR2tZUkZRMzNm?=
 =?utf-8?B?M2N0Ly9ubGJNeUVyNzdkdTcwNTU5SUg5ZUNwZTBVUG1NaHNWYy9NNHZ2TWt1?=
 =?utf-8?B?TDJuMmVDcmk2KzJmamg0R2UrR3A0bDA4Z2FQT3BKR2lLMUJYR1hxSVZlcTEr?=
 =?utf-8?B?VTMwckdOZ1pkaU5RY2ZCVTZmaU54OVZoK0FCeU9EV2xBVUhJV1VqMktaK3RM?=
 =?utf-8?B?LzZsR3RUVjc1SkdrQk44WHoyazNRUktDakxNKzNuTkxuSGtNM3pIRFJRcUFZ?=
 =?utf-8?B?VWI2OXFEVGR4eHh0SnNZMSt6MURUVGdvNFpuT3VNYW15OFB4eXE3QlNhWnBL?=
 =?utf-8?B?ZktRTG55VE5HUHEzdHZyNmZucjVCZXFxdUdNRDNuS3hYcmdISHIvWnB5cWFk?=
 =?utf-8?B?QVBsQUhFTkw0Tk5iNFNlVWY4Z1lyOTUrZmFHUldNR3FORzMwRVE4RmNQUjhT?=
 =?utf-8?B?OWhCSWhpZnA4alA5ZFVOM0pUSTk1RHBzMzhZeHpLeEtJaElmZFJ2MGdxN3pt?=
 =?utf-8?B?L0xnSnRySVFURG5pQk9taHlnaW8xdXdpWlVTQnR5cE94YkpXQU9SaVBJdGgz?=
 =?utf-8?B?NWM2QmtZTyt5TnJlTVVZekM2WlU3aEErcVU5eDNMRk9zZGEvd0NSbWdTV2Fo?=
 =?utf-8?B?OGdaMmwxbVV2U0Y2QmpIV1B6ZXlmeHpINFVRWDhhZ3IrekFlc2NqM2YyeHRZ?=
 =?utf-8?B?OS9rZGpQTWlHK2dndE0yYzVTZVVNK3JsS041Z0k0cm16SW15bTJJb0Zmcm1I?=
 =?utf-8?B?dVdteElieEdNbVpsNW9vSkNoOUZ4ZVZmTmp6S0tvUzhJWmo2MGFZSm5ZYU45?=
 =?utf-8?B?VFpWaFgxYi9lbzBvREl3YTUreU92UGx4Rk5kdzU2K3NGRUVydE8wRlJwSTZ2?=
 =?utf-8?B?Y3cxZTluZUtxU0xpRGN4MmxWZERKZ2xWdzE0cUQwcmNEbjRhODdORFRLVERO?=
 =?utf-8?B?SnNQTDRYZ0Z4TWVsb3JQd3JobDZUOHdSUkNndTRwbjNSK201UzFuNXFpK2Jk?=
 =?utf-8?B?bmxvbWo5ZEh0eTdsMTl6RFRCeHllUUdsYUgzdnF6NTBxODg4NFJXNDVQem9r?=
 =?utf-8?B?NVNLUXhPbkRLYUgzaGF3L3cwMmVTb2V1SVVKdTdxMDZVcjJyUmEzMkVCTUF2?=
 =?utf-8?B?OUVyNDFWMnRPMVpTMUYzOTlUUWdRekgvWEM1MWx5THF1QzVzdEhaMmFYU0ZQ?=
 =?utf-8?B?akY3SjBzT1ZKNVFlNHczUVJwYkRuWm0rU05ZZDhPa1c4QUZSaDFLQXcrak9N?=
 =?utf-8?B?c1V4QWkvTkFPZUtQVGp3SDR1dG1VQlZYeG5pVjlJOU1UY0tjWUpOdjc2cGQy?=
 =?utf-8?B?Sk4vUUNBa3lQTHZDM3JibkRZSUxwMHJQU3BEY0l4MlpXM2NBTlliT0tHVU0r?=
 =?utf-8?B?dnBDYVB4RU5KNDdRM1FBayt3QmZ1ek1LRnZDdG5zUnVPckpWa0VZUTB1WW1m?=
 =?utf-8?B?bjR0RFREYlE4dmtKY3poaVlxNVhZUnVCOVM2Tis4cTNNTUE0bUYvVC94aURD?=
 =?utf-8?B?ZVdvV3p0Z0Nvay84SW1icFQ2WHhGQ2VsOHk2bGhnRzRWeVNzQnFBK3cxMUhp?=
 =?utf-8?B?ZHExVWRtWmtORW5BUFJRSkZoRDdFcXFlVWxwU3NpOXNmTkdFa1NMTHdWOXFP?=
 =?utf-8?B?UzJubGp5T1l2L3hscm1uQ3lDOTBPUnU5YXkra1EvVGhTdzFLWDlsc1lGZXRY?=
 =?utf-8?B?c2psWGk2OGpaL3M0eXVBY2pMZmJ1dkJ3dFY4a3dOcnJaTkpaajFCWHJnbC9W?=
 =?utf-8?B?OEVaRjFaMkorWDBTT092SkFEVjJGRFNrU0RrTWNTdXJIaGxKeHV1eUVMUW54?=
 =?utf-8?B?cEJZSy9oc2JFanhlaUZIeHRIcmtjUHB0NTgwTnFETmp3bG5qd0FYcktWb0lz?=
 =?utf-8?Q?+gR7SWVgjvvrnB0qUZVl+nj4Xn5SYjWS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG04bzNPa3ZvRkVaRXBIV25vQjkvK2NiQWxpL1d2elJSYkVZamdNdmMzTWo5?=
 =?utf-8?B?R3MySzBEQ2tFLzViZXFWZnFQekdXM2U0emJnTC81SU03WUs5SXBYcm9lWUV3?=
 =?utf-8?B?VUs0Q0pTVVlpVjNZcHlTT250OUVnM1dKOElDSmFGelBSSVFldEhkQ1dObkh0?=
 =?utf-8?B?WHAvR2RwaDRBeC9PODJ4bkw5cS83N2RqVXpwZU4rUHptYnVqZUIvVmh0VUVR?=
 =?utf-8?B?Qnh3akxJRkQ2VVAvMmlxeTRtT2d4NUtsVkVNNy9OZlo4U2RrT3JZakgxYXlG?=
 =?utf-8?B?ZnhkekdZT2oxZk4ra05HMHBaY1pTV0x0TExVQWllTmhIYVZSb0kxSTJXY2Y0?=
 =?utf-8?B?L29VTEtRM3NUZmJ5RVFHOGREd1FHYUh2cHF2QnE4MmNwWjdEeUdsSDlsRjZ0?=
 =?utf-8?B?MDBWTHZUZ0VOSVlVZU5LMGdHdU96Vm5kWE0zMWtCbFJNejRFSnNnbHFqdGRM?=
 =?utf-8?B?L2l2cXp4bkdnenN1N1A3MmJsWENubEVsQWlEWUtZME1vVUl5QzdUWGxRRkVr?=
 =?utf-8?B?aHZYd3hhYjh6YVRVRnRtcjdzbmtVQndpbk5oNE10UzRvc3pIeVBkTVo2S1NU?=
 =?utf-8?B?eko3bTNlVTBXSEtobDN1L2VCZkEyNTFkSnF0NXhvU0xDMGZlcFpZS29QeWZJ?=
 =?utf-8?B?VnI1QWxqcGZVV2pUUzIxMU56bkF4Z2tSNDZmM1d3dU9Sd1lBa2k4UEpaVWtB?=
 =?utf-8?B?VHR0RGNKN2lpcU5oUm8zM2Y5alFmZXk5dkEwOVpnMGs5UWozTGg3ajBvcGZr?=
 =?utf-8?B?dExDU3JwTFQ5OCtRR1BzMXhKdnp4MHE1K3NSQXNua0dHT09NOCtIRUl3dFV1?=
 =?utf-8?B?aUZCRHpWZzJ3amZjYzF5QjRLRnlzVXpQSzhCaVlvbVUycFgyUzB0YUVCMElv?=
 =?utf-8?B?VTRaZmVzQVhjOVdieTZuaCt2Y003WUY3V0psdGpKUzRqaytxYzBxcG9kTE5H?=
 =?utf-8?B?Y0U0K2Vua1M5MEdtQkZORFhUOWR2NnI5QmFtUEJTa3JFNWFmWmx1bEh5WlpM?=
 =?utf-8?B?TVBTc2RrZFBzVVJiNndJK1U4Nk41VU5Va0hsUTVHRWtvam1leTNZdFVMejRE?=
 =?utf-8?B?UVppWCtOL2paME9adWlmN0h6VzE1ZWdNTVp5OXlCYnV4a1VSN09QZXE4UVZp?=
 =?utf-8?B?c05wOHpNRG1JMjFkWWU5TThvci9UMjdYOU4yQTNkSU5qNzVVOUo0TDJ0T0Zq?=
 =?utf-8?B?VFNsRmo1VnZQckErODB5bVgrcythM0xJdHExbGQ5elFiUHhwdC9JbWQrenpW?=
 =?utf-8?B?Y0J6WmNLdEJsRk8zazcxZVhMVjBPM0NkbXZGM0trbGs5b1FqY2VtbXFJYlFh?=
 =?utf-8?B?ZzZrdW5OUFVKM21MNFRxTGpUSjcwRUN1UlJkVW9vdUh6WXdBaDBLZUo3dXdK?=
 =?utf-8?B?RWdYRlI5bmtGS0xrMTFLTzJqbVYxOE1TaFc2L0VRU0pGa29UTE5LcnBVdmhE?=
 =?utf-8?B?dkkvUkVpellTTDVNWXRqS0pXeVZwcjZFMTRsYlFKQm1mMW5XZGxDdTJKc2ZK?=
 =?utf-8?B?OU84Uy9GQ3N5SzhyeVV6b0hyUmg3SG1YakxRZVVadGRLSjZCbXY2aS8ydllW?=
 =?utf-8?B?eVJhT3c1WHVBOE8xVEhhRjZlb3hkd1J5VTBjMy9LaUlPNUtrMC90eXJPNmRo?=
 =?utf-8?B?Z3owN0gxZy9GWC8zTXdsMm54SnVzd0QxSGh2Z2ZXSmk1bzBPckp4cGZ3eTAw?=
 =?utf-8?B?SzBxSWI2ZEx4UjZCNmROUFc3ZE1leGtmdHRoeThocE4rUDYyL1YwS3BBaWRD?=
 =?utf-8?B?ZUh4elhZU3Q4UVdzU2p2Mk1DclpaRmxjeVl6UlBSYmRDdlJGQ3BxTFRBSDM0?=
 =?utf-8?B?L3FqVzhWYlYyc0dNRTFMNTdCZ3FTYjV0MDNqVHNsek5DK1B2MGluTURmZmdq?=
 =?utf-8?B?TG5EMWVnWVAzTEZFQ0RJcUg4eFRuUWFYY2RsRW55RzJxb3VaMmM2TlZKV0JD?=
 =?utf-8?B?V1JkUVdxb1duYjY0SW1Td0tFR2tYTXJWU3NWSXFjbWdnMGRVN2hCMFVxaUlt?=
 =?utf-8?B?RjVnV2d4ZENVc3NuMmRNbEw1NWZyY255YlpCZ1BqKzd6UHlnTjZoREdoNWtH?=
 =?utf-8?B?dldOUEZnd2hJcFlUL1ZzWmlja1M0U24vdHJ1QnAyWGE4TFgvaTRyTEVUV0Yw?=
 =?utf-8?B?TUM0VFRwWkJNdXNNQkxDWUdnMWdPdmpvNm5JK256OWpqYzV3S1RDWkhneEg2?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <519F749B4F1ED641873F2099645CED30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iureygja3g4M6/V4GxdH4MSnxV8hvJxI6GbvCgjrqJn8G7HLQFUNJlYbutrpOXLJbk5LRXhRjD59zZCF1yw1iqfVLhxtaTTMIhsj7IcPq6I5pyi4KYzYlsWqkhRDI0nlsqOAhKabczXlowB+JZkwlmYbePLyiZ8IwPvqc8Dq/INwIJerEzU4hkSL9ETdJ7Y3OqWzCxm3g0btROmAMbuCxOQZf9dqsj60OrVE1RglkG5C2OEcisLHrrwGpuife6EdTB9ZmviLJcob1d5gBxmfTl6Tpc8dROqubtUu5xkEddCo4dEEPhayPk8acr5ssoeDyKYHqjsbpI5Qay0QZ7LfbWYqfXVnDvXQL4u1NrNAKsW8RcorybeUgreT4Oz6vnSCSOaLydjGP33NeajWAeNhp+wLkWWU28ktJf1OYLYDzKcAx5XiXzYRnrlo61znl8WhMcsxYykbr2chcGLZ/3CJDlMFvSiE+IuEhmNFzkajIW1zFhzgwWuCOpnpUJGxoF1PZhFSmOlcErrOJ2IH9OHC43X+LsC+DI+hh5EyvZYP8Q27r06haQTJWwgtDlc9uDAPfwNBpxwkWnlgaCgc/XOV3SRO4sdRkeqqftJT7MNr5MhMezoCvOadtMDLBnbWS1yp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22854d14-b1aa-47f9-154a-08dd5173250a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:55:14.0866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBS+T2OZTeYAN9HdUdW2+MscnHqQ9mmEgW6+mSb7mTpk67Uh1qftyCGwkuVX+AsC/8C95XIOSJiCreQCKNBsHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6678

T24gV2VkIEZlYiAxOSwgMjAyNSBhdCAxMToxMCBQTSBKU1QsIENocmlzdG9waGUgSkFJTExFVCB3
cm90ZToNCj4gVGhpcyBjb2RlIHNuaXBwZXQgaXMgd3JpdHRlbiB0d2ljZSBpbiByb3csIHNvIHJl
bW92ZSBvbmUgb2YgdGhlbS4NCj4NCj4gVGhpcyB3YXMgYXBwYXJlbnRseSBhZGRlZCBieSBhY2Np
ZGVudCBpbiBjb21taXQgZWZlMjhmY2YyZTQ3ICgiYnRyZnM6DQo+IGhhbmRsZSB1bmV4cGVjdGVk
IHBhcmVudCBibG9jayBvZmZzZXQgaW4gYnRyZnNfYWxsb2NfdHJlZV9ibG9jaygpIikNCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2Fu
YWRvby5mcj4NCj4gLS0tDQo+ICBmcy9idHJmcy96b25lZC5jIHwgOSAtLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMv
em9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXggYjViOWQxNjY2NGE4Li42YzQ1MzQz
MTZhYWQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4gKysrIGIvZnMvYnRyZnMv
em9uZWQuYw0KPiBAQCAtMTY2MywxNSArMTY2Myw2IEBAIGludCBidHJmc19sb2FkX2Jsb2NrX2dy
b3VwX3pvbmVfaW5mbyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmNhY2hlLCBib29sIG5ldykN
Cj4gIAl9DQo+ICANCj4gIG91dDoNCj4gLQkvKiBSZWplY3Qgbm9uIFNJTkdMRSBkYXRhIHByb2Zp
bGVzIHdpdGhvdXQgUlNUICovDQo+IC0JaWYgKChtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9V
UF9EQVRBKSAmJg0KPiAtCSAgICAobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUFJPRklM
RV9NQVNLKSAmJg0KPiAtCSAgICAhZnNfaW5mby0+c3RyaXBlX3Jvb3QpIHsNCj4gLQkJYnRyZnNf
ZXJyKGZzX2luZm8sICJ6b25lZDogZGF0YSAlcyBuZWVkcyByYWlkLXN0cmlwZS10cmVlIiwNCj4g
LQkJCSAgYnRyZnNfYmdfdHlwZV90b19yYWlkX25hbWUobWFwLT50eXBlKSk7DQo+IC0JCXJldHVy
biAtRUlOVkFMOw0KPiAtCX0NCj4gLQ0KPiAgCS8qIFJlamVjdCBub24gU0lOR0xFIGRhdGEgcHJv
ZmlsZXMgd2l0aG91dCBSU1QuICovDQo+ICAJaWYgKChtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19H
Uk9VUF9EQVRBKSAmJg0KPiAgCSAgICAobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUFJP
RklMRV9NQVNLKSAmJg0KDQpUaGFua3MsIGJ1dCB3aGljaCByZXBvc2l0b3J5L2JyYW5jaCBhcmUg
eW91IHdvcmtpbmcgd2l0aD8gSSBjYW5ub3QNCmZpbmQgdGhlIGR1cGxpY2F0ZWQgbGluZXMgaW4g
YnRyZnMvZm9yLW5leHQsIGxpbnVzL21hc3Rlciwgbm9yDQpsaW51eC1zdGFibGUuIEFsc28sIHRo
ZSBwb2ludGVkIGNvbW1pdCBzZWVtcyB3cm9uZyB0b28u

