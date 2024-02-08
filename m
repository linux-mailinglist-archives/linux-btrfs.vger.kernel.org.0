Return-Path: <linux-btrfs+bounces-2248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4884E0DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E0C1F23684
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCD71B30;
	Thu,  8 Feb 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="etWwxyLp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bl2tfZRP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108D6F079
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396176; cv=fail; b=N1wVRaS8nSy+pOw3PSE2s3Wz62xypuyd8Aszvj7JhEOFMjOqEQDMilq9SmtjMjJ04vaHGjmp0vdSPXZ0ghDb/bKnIiBh0S4cbGl1EmPJcwi0FTihTFnxgVajyQxtEzi8jmjBcjvoTg/EfMWp/cgkknkXYPM7GBfWyYaw/uG+sUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396176; c=relaxed/simple;
	bh=ogGQx4mUoWy43A3q8d0RDI+Tbrc2QEwi/6HdnWzXhNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qwft5QKaO/4Bl2Xb7lNu3gLvkge/4RvUecbp6GcrYRRrx/dMFwYUuEUSBrI0FLEKan0MJt37rDif0+c9CfLzUVCLFvOIMoyodVExlJRwYKcMoSrwv4jH+WqFFhqYfe9ItZ3GkUPyJuCKlEHFHylKn0dj4jP37V2fxfiPYtvgm9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=etWwxyLp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bl2tfZRP; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707396174; x=1738932174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ogGQx4mUoWy43A3q8d0RDI+Tbrc2QEwi/6HdnWzXhNs=;
  b=etWwxyLplFf72R5GX6TPvLYhTedz420kUl4dX1MRiKjFXEYBsA15YW28
   Z7rI40+iTm7G7lEYKcG2HNokFSLd9hfUG6uzqPRRX33HL8vszNXF93Ipn
   O4M/7c1yPKckc4Rt45WshZnvgeIzz+8b2rGB/aOJ+tsU61buBVv2/Z4Mi
   ha1hPFcrmcwlnWveqnZQeeO8K9eTaeJ8xlPtmc30LcG155l0Ng0nEotf4
   K0uEO+D3uvHECFa2k4RGfa3Jn9uKX1LAh+LruW/Adi6j/0y6XU1GY5xcb
   Xb47nfkJbQGUh3HrkEUADRGFf9GevQ+bpzm63+AaLeZkVQlflkbDUUNFV
   g==;
X-CSE-ConnectionGUID: T1XnLnqcR8uYe1+k4Re2uA==
X-CSE-MsgGUID: 4ShOkRuNSgKWgZ9wGAhLbQ==
X-IronPort-AV: E=Sophos;i="6.05,253,1701100800"; 
   d="scan'208";a="9359192"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2024 20:42:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRaiOi/9c04A7VfeuweFAwzDe/tdDmjVWzTPkjXVSeTN7CG0kemgTbTddIXQOgtoDkNwpa/gTJCGbsF/y38UzzPi2k1y2tgu9Be4J2IzTyVZHUidRieMGQ99CP/epe6Wf3IFVGyY6WSYynTGX84agMzOf8XAG4LubOxeOztLegzf8GKzIuWSJs5BfVjLXNLAbcE2Thzih/Pu7kv72MCd4sw8KUE5MgQ2AZEns8DukADkNd5A4GSmD7lC1K2FroqZKhe2K9VI9FeBGGmBqZzlYpHyOqqZByXXsBfV76ogGj25AHTibP7huFfTTCa9wl6hvTMciCR8zFS0d5QkRAZizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogGQx4mUoWy43A3q8d0RDI+Tbrc2QEwi/6HdnWzXhNs=;
 b=ji5beCF+eNNHv/XaOIEF9Kj84tR1aQuo8TJNPfJHQpowY/D7wO/1xh9xGkliRnAdihVxxbDUewDU4931XGgxctSi6bUa1R9KunELXAj9pmKrQNhk5ZpjxQYRkOOxse2wxpZlaxBKrEGV0EnNindZ7uj1ff2ECWhZUXWvTY7Z0Dh2B/iZ435RDWyELS/YunA8q09PeyUkeelVl4Dky4ubp00uDISO+QJ3ymzXq1P41yKBCJYGESAcDTP/gCu/+ZsMI3Heffvw6uHPgFHPsLGlvoYK0s3BHvTPj77a8uIWZ97D7wtzNR0uQWYpzllG56yZpPGDNbvUI08oFIkq6NYGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogGQx4mUoWy43A3q8d0RDI+Tbrc2QEwi/6HdnWzXhNs=;
 b=Bl2tfZRPbHFZRw2I+5ULF2fj/y2oxP/WrhLueT4A9ikv61jd7Nz2zxR3mFepkiQQZR5BJogRdLMy5pUij1zvwHuKMsy22M58lDvACZJ3eobf2+QGi7Un42LmlcSaiIIqBwtzLfLbuNypUl5SvxmQ7wnX8QXFk2dVrEH5ZJRg3Oc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7125.namprd04.prod.outlook.com (2603:10b6:610:a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 12:42:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 12:42:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, =?utf-8?B?6Z+p5LqO5oOf?=
	<hrx@bupt.moe>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Topic: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Index:
 AQHaVbCKj/f1FqvKZ0SR7X1wPPWj1bD2+NkAgAFwV4CAAMh/gIAAvbwAgAFL4wCAABdUAIAAE6IAgAUG+gA=
Date: Thu, 8 Feb 2024 12:42:45 +0000
Message-ID: <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
In-Reply-To: <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7125:EE_
x-ms-office365-filtering-correlation-id: e88200db-732b-4dcb-d127-08dc28a372d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LPx8ZRrg+jtbeN9/LkKYnlvd+Y3pk3lTKagiIU227NFGloHEI9OiM5AhFLstM2GVBG+Oif14wXM++DgjV0MjGyIqiIS59HvBOMniYKclb9Mq7VkHSfJ91WrfcC0R6DrAAgzwX0yYEko7Q0tpbbUuYUR75DG53RdCGf0z5Fe0DySUdlTLhn+vQEXjv88ZUcGZ0ZmMKxRYJ6lPJyczMtUqcusyNT96SgXE21fFCsFUQTBnozdxfnI187X4dj3vWrQBDmayH0NMucfu6bjvevVUe3tcH0M9hny/RrGVQBOiebGMpNGx6GzrfSYF26qdWl5IIJLk+CJwf/17eK5UfShMozdZcMa5KB1TpQ8Pl/76VgETb/nLQcackRobChd0Zq1F9UqN4IG7cmKK3jyKUUhKSZLqka1ephO4FqWZO1EpFsjgeZsBWDt6jzMCbPFU8D86mnZpDlOBpqwYmLWh7/q45IojSBVudOPNGbEPP8Nf9IcY1hM1szibcCi1Xi/pBXkLrQrL1/Pn/EWZnct79t7eSg2Mwk46ClwPBT3urE8dganZyEJDGQrtPwlaYPeBHZzjuo7jvtSqfzmJYCto3yuiTTECKYPfUmhJUZ3869aIruTcq7K9VuBWMddcxDTRwEAH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(2906002)(5660300002)(31686004)(31696002)(83380400001)(2616005)(38100700002)(86362001)(6506007)(6512007)(66556008)(110136005)(53546011)(71200400001)(316002)(478600001)(66946007)(66476007)(41300700001)(76116006)(122000001)(6486002)(66446008)(64756008)(36756003)(82960400001)(8936002)(8676002)(38070700009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDhDcTR1QzV0T01ZZHFhVVdyQWxJTjVvL3lkQ2RqRFdzZnhRVTNpSmNMbVJi?=
 =?utf-8?B?RjhwNkRjeThSbHFMS3lKc2lIR0M5dWN4Y01tSnd0OUNHRVN6UXhNdHp2cUZS?=
 =?utf-8?B?MkJCUmpuTTg2eGpvVjFyMHZ3T2t2UU9VdFYxYWZRTUxITEplc05tQ05pK2pS?=
 =?utf-8?B?U1VxV3FTL2RJbDFiUDR5b29sL2lzK1BTc0pnT0R1azVJTHY5T2xHYWVtWk9B?=
 =?utf-8?B?blR6TEFoY0FYbmIzQ2NRU01PS0hiVmlmbWJCSHFCQ25KM3hrRjh0b3VVd1Uv?=
 =?utf-8?B?aldmMlFoM1Rpczd1YnprcHpTOVArRmQ5NHJoS3djQURFT0ZhS2dwdXVsUVlK?=
 =?utf-8?B?OE5JcTl3ZmRDZzlVYVVTVlFPVEFER3QwVUlnQVB1TzBzWFJnYStGWDRYaW45?=
 =?utf-8?B?WGs4bWJwdVFTS1NFTWVtTmx5VENUREZsaXJlbFF4c2ZodnpaTXUzZ2IwR2pK?=
 =?utf-8?B?TmxmNmUwL0dHZzZ1U2Uwc3NPWlJEekVyVUJ5aEpmcGVUWkx5MFljWjhpSmF0?=
 =?utf-8?B?SWxxTHhTam44UDMzeDhhcjdWK01QVXByVnAzQ0liR215akJuampkMkJ6Yi9D?=
 =?utf-8?B?NjFnUjh1clhmY21Qelh6SEFRQytYRWpDeWNrcS9vZnZTb3RvOG5ZYU1Uc2dI?=
 =?utf-8?B?MFh1WFlRenZ3cm84b04rcTlGZ3ZjT2puR3hCZUZIVzFhU2xVOHNZSmEwMno3?=
 =?utf-8?B?ZGVHbVNLVlpwNFBLZUwzRlJKS3BQZktpQk41WWZNdVh1VUVpMTRzeHpFN1Ba?=
 =?utf-8?B?cWovS1U0bWFBSGVUd3RrVGEvSTdrYy9KOWxSaHM3ZjNDQUZxQnBIVzUvYTZN?=
 =?utf-8?B?RDA5M1dRdFkycTgwWUprZjcwS09QSzdlVFhFQWVvZTQ5dkFPVWIybGNOcmg4?=
 =?utf-8?B?N3Vib1JEcEJRM0FNY1lxU09nTGwxMG0yOEdET2V4MW5RMVJlc2NqbUtCV1dX?=
 =?utf-8?B?TDF0ZDhjYnA5VmYvTFpwSll6ZWhIcm9tbzhZWmZOdFp2ZzlaRTllNlRqZjVF?=
 =?utf-8?B?b2pQOWxISXhUUWtaSEQrY0xmS20rR0lqREdBM2svNzZlK1Y1T0YyN3ZPZlcv?=
 =?utf-8?B?bSszWHV2dUVkckVsRWFpUzdUc2NRS2RwL29wQ280dUU4T0J3bnNheU00azBT?=
 =?utf-8?B?VUlpYllkOExFRTFZWUY1SEs5MjllQXl1Q0ljcmFGR3VXWm5SUy9zVXdrQnF4?=
 =?utf-8?B?MzdqeUI0S1JFVlNMbzRENjFiUGlEYUhrRzU1ZXB6U0IzL3NWY21DMVlOdkxK?=
 =?utf-8?B?b2F1amZ4eFFrKy9ITkM3MktsUFdRa3loSTlWQWhrczZVY2dSbWFVUm5OYUpK?=
 =?utf-8?B?a0dPY0h4SU1rRGpXcDJXKzZWYlNXVU5ORGFldEdkbGYzZVBkMG9mZ3htUVpk?=
 =?utf-8?B?b0JZSWJORUNMNE9DMFBWODkxVlU5TlJBUU5Oa0xDd015TkplMmFYYW5wNGtv?=
 =?utf-8?B?WVpVSThzdDR6RXRnRGF4T2VlZFlUNmFSOExyOUJDcEZ1QUhlSkFUR2w2ZlE0?=
 =?utf-8?B?TnUxdDlGNDRtcDNDeHpFaVMydUNWK2JLZnlaRFp1dGhGNUh5R2Z3T0l0bE9Y?=
 =?utf-8?B?b3ZldkJjc1JkaDZLSkxFcXBIMmxpS1JIS2dtWnFuWW9OZ0Nvb2hiMkxKYlVo?=
 =?utf-8?B?dVFDOHlDMk5MYStkcWJxVHQzRFpwS1ZlbFBTRUhZcG52dHdGdVVRNmsyWU0v?=
 =?utf-8?B?RDliYTVtay9RVVQxd3hxcmNybHdocXBVZWdRZHh5MVdEN1J3dThOR1JIYkRp?=
 =?utf-8?B?cE5MN29lZjByUzVKRmJRZVdGTTZVOWZZenRqWXc0RXR5aVNPdUFKRlk5dXYy?=
 =?utf-8?B?MmwwSDJsemRSWmh2N25ZM2ZRNGVFaGJ6eDg1SnB1NDAwcFEzcTgzUkh0OVRh?=
 =?utf-8?B?MWp4cXhTNjdYY1JhcVAyaHhoYXlvb3FiNmgwSFQ0NlZ4eDd6bzFIZlFvVFhB?=
 =?utf-8?B?MWd3Q0VhSmJDaHIwTktsTHlWLzZhRytwc1VIcWhVUlYzTCtOUE15N0kvdEtp?=
 =?utf-8?B?eVNKTUNKblJUTzJlV1BMV0kzbmVIeVpzUWNYNElVLzJiYXhSZUwrOHFDclVy?=
 =?utf-8?B?dGpwcEExczdPUjBrVG0rdjhjSGNrQllkdXBPSzNVWDkxVzQ2SFc1azlQVVp3?=
 =?utf-8?B?U0hhVHhtWXo2OEZpT0VJNjRRUlVEVE83YjdUZjFwVlBOUXcvMGhSaVVnWFVu?=
 =?utf-8?B?L3c5OUJkd1pvMUhZVnlGKzcrUUF4YnhhbENrSEFyVGh1OFRDMUh0R3JaN0VH?=
 =?utf-8?B?NlIwQks5M2JXVGVwbzFKZnhyaDlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8322ADEDAAD2840AD31AB6CAEA38D18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GT/FsiDVza/Oy1tNuV5WDSKZvd9kRPWbZ9zke+HlT+AJR9G7eCG/NlhpYUARp25FJoMxfSK9zwSaHmRhrZgA+kkF1LUXm4Y82jDZYA66jAafFSakNfYL7IH8Uqq+y3+3Cnr4J/i8IotcD6LnJdANktOQAvGVO4GzfW0MNSqur89kAszvq9BJLqal9cKTd6k2bC/hfuPnkvBK27Q+yVFCTDNwc/5h+swxoR+hJ6bawF79tWIGsC/Eq9qIrqU6y1pwccVjWF26CvZN2DxUQ6WGL9fSGYHCBhVbwa1LoNzB0+z4b2ILrL4dilZZl/mhNP3IHr5YX0YpdJqQS7SxNL765lm9IN1D+1PIq/g0KqefJ29NVp36WFY4FRKhCyJN6OibwY6RlYNw5tuVdmVgdzal8c3vmWOqkeSWuQQn8W10obQh87kVAIJYDAkz9VqhKOr+JZBxcUlrbumRGw6gOaLBceVSlhufs6EHk/YB6kg18G2/IPSd6WQcx8d8Wbp/28C1m+GhP5jYUfadACxBeCBly+zsFgXzKQfM1Ta5Wz4k5nksCbVLjzk0JWNNq3w7phVYkAUNLlLHFyptSKprgKlUi5XHnOJRhd3jugC+m98l7k0QrC9oW1L+5B0iPkB/sX8e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88200db-732b-4dcb-d127-08dc28a372d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 12:42:45.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0u3a1FntSbBwc0dt3piZbE6FqKc1VBuOvG0PCzCdcOMLkmUD+uNybL7jxgyLc3H218SCTApSepm6PWMq3sNO3yPPtNWB6g8m+SNxlxT28Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7125

T24gMDUuMDIuMjQgMDg6NTYsIFF1IFdlbnJ1byB3cm90ZToNCj4+DQo+PiAgID4gLi9udWxsYiBz
ZXR1cA0KPj4gICA+IC4vbnVsbGIgY3JlYXRlIC1zIDQwOTYgLXogMjU2DQo+PiAgID4gLi9udWxs
YiBjcmVhdGUgLXMgNDA5NiAteiAyNTYNCj4+ICAgPiAuL251bGxiIGxzDQo+PiAgID4gbWtmcy5i
dHJmcyAtcyAxNmsgL2Rldi9udWxsYjANCj4+ICAgPiBtb3VudCAvZGV2L251bGxiMCAvbW50L3Rt
cA0KPj4gICA+IGJ0cmZzIGRldmljZSBhZGQgL2Rldi9udWxsYjEgL21udC90bXANCj4+ICAgPiBi
dHJmcyBiYWxhbmNlIHN0YXJ0IC1kY29udmVydD1yYWlkMSAtbWNvbnZlcnQ9cmFpZDEgL21udC90
bXANCj4gDQo+IEp1c3Qgd2FudCB0byBiZSBzdXJlLCBmb3IgeW91ciBjYXNlLCB5b3UncmUgZG9p
bmcgdGhlIHNhbWUgbWtmcyAoNEsNCj4gc2VjdG9yc2l6ZSkgb24gdGhlIHBoeXNpY2FsIGRpc2ss
IHRoZW4gYWRkIGEgbmV3IGRpc2ssIGFuZCBmaW5hbGx5DQo+IGJhbGFuY2VkIHRoZSBmcz8NCj4g
DQo+IElJUkMgdGhlIGJhbGFuY2UgaXRzZWxmIHNob3VsZCBub3Qgc3VjY2VlZCwgbm8gbWF0dGVy
IGlmIGl0J3MgZW11bGF0ZWQNCj4gb3IgcmVhbCBkaXNrcywgYXMgZGF0YSBSQUlEMSByZXF1aXJl
cyB6b25lZCBSU1Qgc3VwcG9ydC4NCg0KRm9yIG1lLCBiYWxhbmNlIGRvZXNuJ3QgYWNjZXB0IFJB
SUQgb24gem9uZWQgZGV2aWNlcywgYXMgaXQncyBzdXBwb3NlZCANCnRvIGRvOg0KDQpbICAyMTIu
NzIxODcyXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGhvc3QtbWFuYWdlZCB6b25lZCBi
bG9jayANCmRldmljZSAvZGV2L252bWUybjEsIDE2MCB6b25lcyBvZiAxMzQyMTc3MjggYnl0ZXMN
ClsgIDIxMi43MjU2OTRdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogZGlzayBhZGRlZCAv
ZGV2L252bWUybjENClsgIDIxMi43NDQ4MDddIEJUUkZTIHdhcm5pbmcgKGRldmljZSBudm1lMW4x
KTogYmFsYW5jZTogbWV0YWRhdGEgcHJvZmlsZSANCmR1cCBoYXMgbG93ZXIgcmVkdW5kYW5jeSB0
aGFuIGRhdGEgcHJvZmlsZSByYWlkMQ0KWyAgMjEyLjc0ODcwNl0gQlRSRlMgaW5mbyAoZGV2aWNl
IG52bWUxbjEpOiBiYWxhbmNlOiBzdGFydCAtZGNvbnZlcnQ9cmFpZDENClsgIDIxMi43NTAwMDZd
IEJUUkZTIGVycm9yIChkZXZpY2UgbnZtZTFuMSk6IHpvbmVkOiBkYXRhIHJhaWQxIG5lZWRzIA0K
cmFpZC1zdHJpcGUtdHJlZQ0KWyAgMjEyLjc1MTI2N10gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUx
bjEpOiBiYWxhbmNlOiBlbmRlZCB3aXRoIHN0YXR1czogLTIyDQoNClNvIEknbSBub3QgZXhhY3Rs
eSBzdXJlIHdoYXQncyBoYXBwZW5pbmcgaGVyZS4NCg==

