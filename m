Return-Path: <linux-btrfs+bounces-2319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A87850FF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6621C21C81
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027017BAB;
	Mon, 12 Feb 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NiCsFewv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IL1/qUDS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687D179AA
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731314; cv=fail; b=NUBWgeSPwtMA+FuVbwCmtZMbhgU4QS+ZutEcmyOLd7ENjqd1W3rqYGIzrIafoKPIJQSSBa5E1gHI0b04Rp9kwML6uuWgeCv7UO/HT4s3zIPLPaDGBlw/pJMrh9X1YcM887wtl8t0GmBa8dOr8fI7NifNQMG1B/nCjNj/1cEye/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731314; c=relaxed/simple;
	bh=Rd/0UzALyKXHL7gq2jf7FM8886sx03qfqmGejWU6msY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+9IHnx7kQeGgVQJ0D090af3ixKBb8I5HpLdpNCDqzdoqkz0BIUJJhgOpTMRj9eBX7W7Cd4r/dfRhKBosNKnc5l1G3bGexoZPshLV6vV0v7dzH81bwLZxkHgPYsgML8Got7fGVyWtIxnWqeosecEexyg6jn6USlbM7NxUMN2Pmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NiCsFewv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IL1/qUDS; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707731312; x=1739267312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rd/0UzALyKXHL7gq2jf7FM8886sx03qfqmGejWU6msY=;
  b=NiCsFewvBvy7FuT3w5SiHXbKYlPNe9AcLM1Yp+Yfl4RLCXHCqjP6dRU6
   WbOxgf9W7AiVi+GwWMLYQ/DVZeGHWsjUJ7ROUVwhAJaIUpFvejZvCeiCb
   P3RFMUi8AdDUEu4512DTPtli1gAblSEIp4NXEtuBZ/z8WrTWkiQGY3uzi
   nMh9p+PKWff+kppcp7zLieRsOJDnusAGd7onjyDqHDDlSEabTRB8eSOfz
   PoVXPgzdCydfonyWLk4XDrZs5dLlop6van4e4VRxF1WBJXGqWJ/6gXFvu
   rkCGWwc40rns1GFtwuWMdKrGvdOkkzzcyLbDjFjHePgg0CFsaJQazbxqt
   w==;
X-CSE-ConnectionGUID: UbQ6XhoDRTaKQL7fIUBbLA==
X-CSE-MsgGUID: NrVmVs7qRR2gdPTEev+3bQ==
X-IronPort-AV: E=Sophos;i="6.05,262,1701100800"; 
   d="scan'208";a="8952510"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2024 17:48:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQB4WmBJqXDSBIR72JjjGCIOfxGBpgJelc1RbFsu/HJc0C8hy340j2VGJPUgur3VLSeHnw6DA/oG7MjPACYbzjT0MJOm+KuaprFZJ+t5JGd5S4o0borWM6od6cKDGraxl9EUPgv1HS9v7HKMmL1LmVn5ksmJMGxDS8PP0El31zHfz6WSpF24oSPLhcf1C5SbeS6Q/FPapYYKdeiNh9riakGwalt7Pz4X62ZOy4dtaTMA0fO9l3REI9tgCF0hZIDuu8hLwWNh9wz/28gpu8Jk0gdlg2aecBgN0ZusAir0ChbRd8v4cfeMfHtkGaSoBeXhwFldZE5YX2giiyK5a4AUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd/0UzALyKXHL7gq2jf7FM8886sx03qfqmGejWU6msY=;
 b=LO0MB3vXpDbB7jSGLIoFRgskv2GNYSlReLuSsv8ZiAOrnQ3yV5euNJffCiQ/DUQl058ikhhmcaAlmTYR00XfWUUntRYA2evPDsEKoMHRcGnAejF4kht8be24aUj9L3YEreYOZKvJHv3TMSr0UPt5p6YZWEaVwulu4L1fBBOq57Ztr6IMUHUUFevmtbijybzh/mwFQ2tDsW8+AJsCO4xQERP8GDnOBhePLmqhhaX1LZ9zEtLXEyjZ3KuWeXdOcTHwjmus239V+mz6r+JiHjlJHRxKH76IyiPnbbMZpgTRK871mVonAB1x7vGEq3Vh7tRPh9RFgkWc7v3znPSziVT0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd/0UzALyKXHL7gq2jf7FM8886sx03qfqmGejWU6msY=;
 b=IL1/qUDSF73oUOJiJemihScOU7regcNBwsv+R4e/+QXgWbfnhfF4JhIyzv/PhXcATXvrhDF2s0vkVYirbMVIsBZU+Um0xU4cnknlaTyeFCxHOlcGpQu4BI3l9JXo/pfRJLoKuaN/n3t9t/lwqr/Ka5vJKXLvB2nGvTw7NFTSqzk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6494.namprd04.prod.outlook.com (2603:10b6:5:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 09:48:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 09:48:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	=?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Topic: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Index: AQHaW0VFh6p9467jSEWU6KOVYtsNZ7ECElSAgARoYoA=
Date: Mon, 12 Feb 2024 09:48:28 +0000
Message-ID: <d3e429e1-b2ac-4108-8238-b1d8c4a146b9@wdc.com>
References:
 <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
 <qrqgwshivydiujwwfvso2tq65d3m5vfeide2ethoxv4ptzxt5e@fxpaznl2p3w6>
In-Reply-To: <qrqgwshivydiujwwfvso2tq65d3m5vfeide2ethoxv4ptzxt5e@fxpaznl2p3w6>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6494:EE_
x-ms-office365-filtering-correlation-id: e35987ee-b9dd-46e9-b9c7-08dc2bafc3ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ewxIzmF1wOYqkX9Z4IuoG1PuSnvPUXAw43tiIy1ryNmtwlPiFUUvTJfBR1udH1d8h6gJhAp49rzyugJBalv1e31YtXxtLYlwb7v32E/qP0hFuN6St8xcsUDpIftUZqU7+logEteFgILYsW/k4G7YSMRDHpSH6ZMgymsJL3EmxUGK0F8LalJRMFDRAm/+6S3yb4qhYoJxDnpmW/t6gfTFryopxK77qRKgISUWyWwFeYfedNjGdHP90ewa4FptLdW1HR5vcCh7I9CNSl1xnL2EeeDI7r60qV/44EIChWw36LN+EpLQHg4mwvB9t77281WwsO608KjfatCUWzmeIyU6wNs9JHO25bAc4V4ayVoDDYuP2Xl61CYRs/s3iY4qCsDmxccXvnY65lujy5XUehshHE+aBRWtWuacNUT/xCI11zDqArnTokbJXikNQgn6lHl/1ml7Y/io/9jAkG/A1Ejo//QEY6dYHot9NqK6CkqrqKQk9utLpbkSpgwluE9SYyztcLLnm5YNGZ0t92fU8W8Hs0EnIv4XjNj4Kj1/5RzcittJEOBWQo1OTqftTAr1wjiyEBsdB4M/q6tSoXRMyuOrQQi9eoZtpng7BmUSquiLAeg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(41300700001)(2616005)(26005)(478600001)(8676002)(76116006)(83380400001)(66946007)(66556008)(66476007)(66446008)(8936002)(64756008)(6862004)(5660300002)(4326008)(6636002)(37006003)(54906003)(71200400001)(53546011)(6506007)(6512007)(316002)(31696002)(86362001)(6486002)(122000001)(82960400001)(38100700002)(31686004)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1o1Q0ZqQ2p2WVR2RlpidlhLK21HTlBnb1hBZDU3VzNId0hEaHRrai9Pc1FH?=
 =?utf-8?B?ZDlPMlJQbUphVHl4Y2oxMXhEMjRxZlVxRXp5MTJYU25jbFBveVA0RFBPMDBp?=
 =?utf-8?B?K2hGRG9SaEpvVmtMdW9lcVlSWm9uRlcwcXg2UWFsNHBLMVM4NHdkb0IzdTlh?=
 =?utf-8?B?MFJhR0dJM0ZkSDNOaTc1VWdueFNEU2FPcE1zR0JtclhBMFY1RDU5UGthYWhm?=
 =?utf-8?B?TjM2cXBrSU9aYWNYSUFWY3BnVlk0RWZUR3ZxMVVKN1B0anNFMEgxL0hvV0RJ?=
 =?utf-8?B?QUtnSHRKa2xucEI5eHlXM2xUSldMeU9JYzNNMk5qeURsQjRuQnJ6VUNBcU4v?=
 =?utf-8?B?elZxMzM0RmdEQzFSWU5hZC81enZOdDFpRUxtZjZBcVBCZU1EVXlVT1RldnBq?=
 =?utf-8?B?YW5HRmRDcVA5U0VTNEN0SXFvUENwSFFSNmxrQXRBeGJJZGRYQlNYb3Vma0x3?=
 =?utf-8?B?dHY3bGxnMDJPZ0psNUxlS2ZxY1FMb1N6cXpjcGRTVGprRUIrNGF0eEcrMDdL?=
 =?utf-8?B?TmxLRHVGTlM4bTNwZ0JuSmNDeTJkbmRaU1loT2cwU0NuL0tVYkhFTjdmRjFl?=
 =?utf-8?B?bG9tRS9JQ2wyeElKWlQ2SkNGNm41Q3ZEbkcvbXlNK0pkTTNJcCtyc3V6OGdj?=
 =?utf-8?B?ZVcrMWtxMDRhbFd6TE9VMHRtekk4azZ5Q2hMbFJNV0l0eVBBS2RLTmVjdEhw?=
 =?utf-8?B?eWpyR09US3BUVFFkUzRMRFh1QUVCaG00MGZMV2VRSGwzQ3hzeUxKQVREVWpR?=
 =?utf-8?B?VXhnTk5iVW8yUHo1N3YyRW1rekZHS2txeEZEWUR1bnVHdHhXVkxvODU4amdt?=
 =?utf-8?B?Tzh5RkMydVJtV3EzTTUxZzdyQ1lkZzBvV3FNWSt0eno5UWFVUmJDWVRuOGM5?=
 =?utf-8?B?QXNYdkpqZzZqc25aVXZ5OW5vakIwQ1g2VjREVHk2UHhRdTV3dUN4YzZKTDhi?=
 =?utf-8?B?SHpnUEdYbzBkYTM0ZklJY0ZEM01VVmRCTERjTkFMM1d3UzFHeWJQNTdFd3hr?=
 =?utf-8?B?Q0xGMXoybllKeVZaU0ovU2RJeTBFMVBnbThzT3RqUFdBa0FuTXRmSTEyWWs4?=
 =?utf-8?B?amxlTWYzcWhOSUFXSnhDOFNJYkxEWC92bnNCUTE3QVhtS2M2WGRjTktZMUcv?=
 =?utf-8?B?WCtOVVhZSm03alJLNldIKzlKdi9CUmdGVEpUWDF0VGhpeTRoSnJBdnUySXRr?=
 =?utf-8?B?OXBrLytOTElaNnBKS00rWjhQakVRR3lURW8xeWE2RHJwQ3ZubjRqVTY1STBh?=
 =?utf-8?B?Rm1ZTXZGUDBQeEJiWE9Wc2Zsb1VPK3p2QTAwTkpnT3lqWFluSXVodEJLZzlG?=
 =?utf-8?B?UXUxVlhSMVBiRmJ0NUZ4cTNmWjlBN0tZdWluZFE0RjVpTUN6TnF1Q3JLS1VS?=
 =?utf-8?B?UGJwYm9Dc3BUOXZUN0VQTmFVc1pIZlhSNDZIaVpBb0hiSUQwd3BicTg4bXds?=
 =?utf-8?B?TFhvZmR6am82elAxcy9QV1FqYnRuUlRUSEgzV2xNZGlJQlpYV3ZONG9ETExX?=
 =?utf-8?B?VVljN0dvTThrQ242UEhGRjg5UUdRMEkyaHJuMWZhZjdPV0xKYmlHNFZTSVlj?=
 =?utf-8?B?VXgvNERHcHhkLzhpcHJkeEtQQjZ3WGxZVHZZNzZUaWxIWHhqMlR4VFNITmZG?=
 =?utf-8?B?RGJmMXhDWUxJSkdaOXJKbGNsL0RnemsxVU1Lc2dUQ3B5Q25SeWlzbEx0RGdu?=
 =?utf-8?B?TENnUTI3bXdVZWVwWXVuMXM2c2FoK2ttVDJaL09XMGxpWmVnQnN3eGRkVVlT?=
 =?utf-8?B?alpxWnVjMUJHVVZad096Rks0Zlp2Q1ZSakR3OHAwMUp2b0FydlQxSzRhMEIw?=
 =?utf-8?B?NzZXTGJaRVBxMXF4STg3YVQwUkFmWDQ2bkUrVVY1VGJIVVYrc1BRK3A0TXY1?=
 =?utf-8?B?M3dSc1pmdXJwZ05YOUVwdWQ4aTdWaEdRRHYzRmptVlhlVEZQY1Flayt5SkhT?=
 =?utf-8?B?by82c3ZKYVg1cVlPaWNnay9BdFFldXQwNThmbzUrbThKeFdFTlhFZWIvU2Na?=
 =?utf-8?B?NFlXdjBrR0N4L1lEZnFSLzdFL05RZmJoT25uaXhIVXBpUEdWbDdVc2ZKbWNV?=
 =?utf-8?B?cG9jM29vRjBhZzkrQzF0TENJSWU3SVFwUk9RMkkya045c0dJZm1ybndtTktt?=
 =?utf-8?B?TFNSMmRtUmhEWHpib01JUGg4ZEc3VE1OdWhLc3YrQkhyd3EwYVlBL25XaVN5?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0004DEB36F20DD47A35E1F14B0A99EEB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sDUiK7xwOZ4Jd456eqWHjbYrpLL+V6VOiEaRv5+3jLaVuu1uOcpEtuqA1Ipnl+FDCAKF/hB0rTMrjyfQeNdclfXfwySjrzJKb7tTYol/apw7QRkHZZkHEN4ZEJKcsy3WDYhcvVDYSTSyyahnPPQGrVi8N3CnEkQ5zfF/dOpm640JyhZ3kew5+A1COwbFKkQc7MRk5SCF/T64EE/2Eo8IGeQH5iRq8FQtO0ock2Ei41CpdRXdKIFC+K5gKbB4Z089ScXWtGZrOGYhHFpOnuzxMNCQszbkXNMNmY95Yvp/qwnuROUq0wO07wwLCV+JiNHFTF6uP+FueWecDnbyZWiIfKXA+Ba6MgbK3kvkUVrL2+dF4cRA4i1+zjtYXVa36s15oXUoMvImhNc1hBqp0uGQ0T/hKkDm/pAv2xlawi0gXgspEYIHuUSWKhP8wk24tQShHJ65qqQWTx2O6TIKsAVt1l5brGxKlqkmTtkI8UQPX1yzJB63JRq2luGawFLRRTjWK4GWSfklgsGZdvsTUrxRrDn/YhuXHVfMu/psZenjKMsblWij+HgQn3NQ3hHAAjXQ/YYSTgrzJ5IpZ7heDkSixKHg43oZUPX6cakblo2Qua0qjhWzDzycCXhrCI5h4HBA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35987ee-b9dd-46e9-b9c7-08dc2bafc3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 09:48:28.1898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UasBKfwFdGOQcEGp/FvKFACNpc0bAovmkA5QB+8MeFm4Sn0tjrltLOWD/j7Vh4fcQHOgYpQX8DvfSA1S7eXSurXaj7AH+xOFtcNrIfBIRAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6494

T24gMDkuMDIuMjQgMTU6MjksIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gT24gRnJpLCBGZWIgMDks
IDIwMjQgYXQgMDI6NDY6MjZBTSAtMDgwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gYSB6b25lZCBmaWxlc3lzdGVtIHdpdGggY29udmVudGlvbmFsIHpvbmVzLCB3ZSdyZSBza2lw
cGluZyB0aGUgYmxvY2sNCj4+IGdyb3VwIHByb2ZpbGUgY2hlY2tzIGZvciB0aGUgY29udmVudGlv
bmFsIHpvbmVzLg0KPj4NCj4+IFRoaXMgYWxsb3dzIGNvbnZlcnRpbmcgYSB6b25lZCBmaWxlc3lz
dGVtJ3MgZGF0YSBibG9jayBncm91cHMgdG8gUkFJRCB3aGVuDQo+PiBhbGwgb2YgdGhlIHpvbmVz
IGJhY2tpbmcgdGhlIGNodW5rIGFyZSBvbiBjb252ZW50aW9uYWwgem9uZXMuICBCdXQgdGhpcw0K
Pj4gd2lsbCBsZWFkIHRvIHByb2JsZW1zLCBvbmNlIHdlJ3JlIHRyeWluZyB0byBhbGxvY2F0ZSBj
aHVua3MgYmFja2VkIGJ5DQo+PiBzZXF1ZW50aWFsIHpvbmVzLg0KPj4NCj4+IFNvIGFsc28gY2hl
Y2sgZm9yIGNvbnZlbnRpb25hbCB6b25lcyB3aGVuIGxvYWRpbmcgYSBibG9jayBncm91cCdzIHBy
b2ZpbGUNCj4+IG9uIHRoZW0uDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IOmfqeS6juaDnyA8aHJ4QGJ1
cHQubW9lPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9idHJmcy96b25lZC5jIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gVGhpcyBzZWVtcyBjb21wbGV4IHRoYW4g
bmVjZXNzYXJ5LiBJdCBpcyBkdXBsaWNhdGluZw0KPiBjYWxjdWxhdGVfYWxsb2NfcG9pbnRlcigp
IGNvZGUgaW50byB0aGUgcGVyLXByb2ZpbGUgbG9hZGluZyBmdW5jdGlvbnMuIEhvdw0KPiBhYm91
dCBhZGRpbmcgYSBjaGVjayBlcXVpdmFsZW50IGJlbG93IGFmdGVyIHRoZSBvdXQgbGFiZWw/DQo+
IA0KPiAJaWYgKChtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSAmJiAhZnNfaW5m
by0+c3RyaXBlX3Jvb3QpIHsNCj4gCQlidHJmc19lcnIoZnNfaW5mbywgInpvbmVkOiBkYXRhICVz
IG5lZWRzIHJhaWQtc3RyaXBlLXRyZWUiLA0KPiAJCQkgIGJ0cmZzX2JnX3R5cGVfdG9fcmFpZF9u
YW1lKG1hcC0+dHlwZSkpOw0KPiAJCXJldHVybiAtRUlOVkFMOw0KPiAJfQ0KDQpPSyB3aWxsIGRv
DQoNCg==

