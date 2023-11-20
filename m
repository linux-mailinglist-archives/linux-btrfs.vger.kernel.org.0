Return-Path: <linux-btrfs+bounces-192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73867F0CF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656041F21650
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E4847A;
	Mon, 20 Nov 2023 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LDDDWpqS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wSLCZpWR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E38FB7
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 23:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700466311; x=1732002311;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LDDDWpqS+4PB7b8W/QQ6nxO0dgkNRt3OQMEp+2ui75RYsheK0JqvFfqX
   WwvvNoQJvuqxRr1S6zBkoRe98mywAVRrGlJzuQoKVA1kamy4GZ0oIY73D
   A/9xHRcavPFMedIu0dNcVJY2dCvQX2JKm0yH/4lTKa3utfzBVbabthyLE
   Cuwo+mgT9lieWWQn5rhTXIBup5CFZEw85YYKTzY2gar+UQHPLy+phUpjQ
   Ygo50QVLrU+uCyVqXrAI1qkeKXJ0vAMgCn+ymH27P5avJsYirIzR7RYrK
   4RXgFE+7VqoW5KmrG8B7Zw26S5v5oPwtWTfJqpTrxLUOTts2bqVjpGz2U
   A==;
X-CSE-ConnectionGUID: KwWrabftQL+kMO89Etkbyg==
X-CSE-MsgGUID: k0bJ7S7FR5+4kPdmVrYh2Q==
X-IronPort-AV: E=Sophos;i="6.04,213,1695657600"; 
   d="scan'208";a="2819527"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 15:45:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApshIMpbhdGOUbpz0tJ2M0RVoTFsL9EFhHq8Bkk+bf/jESMX8SDFBtBx73dq6a+D985A7TILDXxiWNCAVqdK+bySM4BIKP5ooRc6MEtXxBPcdTAPT/PDZ7P0VMlMDb4oviecnJfFcd2q92QR0YtoCK++ixLsNCsIBln+C9rs8zf+9a6gMQILA6JGQv+mHz2Xij2nCYF982oNAPn38Y5Yptmm9n8YlMWiKkIYPXUFuhpQP1uvxF3YV6c3Sgr3Eb3PqpcfTe3RMTSToHDyGeTOITdROyK5Flqv8ZFrVusNV0y/5ov7qtH9i3iYr+U9K7Kfy8FZXovoQOuC7HxcVbw8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BCtPSovbWcoFFfeKgJT7Jh1F7YI3C5te/7EL4jv7jz3aEy6HDuhw18aWMJqj+uw/lKDOaoBBGAfq2XWnk1uJFKnVotG7q5IQYxR6R4HqAZGibXgaHUwLWrd9RtmfDnx4BC2i/SOUAS8A2xHeeYQHR0ZfdbLLOnbuL2oTQNkp5mCo0kxJN89cJythsI6f5VBWZqsekmbgtbbYqoSJWxpC2k0BHJxRE+NECbf8kp1s+F/vKbQCloIreDiD2vxpfWx3o9N8XV+M1FAc1XVhFjQlL0QOJb1EaZo7A2JYwU3zNVviVEdN8dZVGMpDuQSHrXz6S9Aiiyj4OvKwTA43XEAyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wSLCZpWRMeRelHtJNV1vCANGNvy/3bG4L0hUvgs5IXFG4Oxb0erkw+sL9otvuS1O7mACOEiidainT8c+wsVye4FicumJr/BZ2vjmU5mVSPZ4nF1sM/pDSgupBio0WPzrJKpWpCH23tziTyWZEyU8ZkK492TIhjFk4FcMq28Qvyg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6444.namprd04.prod.outlook.com (2603:10b6:5:1e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 07:45:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 07:45:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: migrate to use folio private instead of page
 private
Thread-Topic: [PATCH] btrfs: migrate to use folio private instead of page
 private
Thread-Index: AQHaGQnTIp/y6edhw0C5HlLnHkG4b7CC2OKA
Date: Mon, 20 Nov 2023 07:45:08 +0000
Message-ID: <d2dcab78-1a98-4d07-a18a-5b3b2b5842da@wdc.com>
References:
 <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
In-Reply-To:
 <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6444:EE_
x-ms-office365-filtering-correlation-id: ef5c679f-3aca-4152-54cc-08dbe99c9e57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jAO8QAyxRJzyXqTMc92Xrbmp9yUOyYcPs+6hNrMc53XRjUJs0rYoS1tRXjzaGSlMUu8EIUAkWmc7Tcc7hJ6aQTuGL5ZCPXRimGq1QmHiVuGLtbrz2XUSyGcW2nZDXbcSRJvAWMFqQ3UgjsX5CQfejHISiK3HYfYf/dn7eZfEjzk5W4xn+rZaGeO5jHfNdY/lWfCEkY5ZcgtF0qPyZwmgLvhP2mADMpJ6ReymdD/g6104UIiDpM/r3WJf6c+7CHaOvYoUm5iGDUIMNUB0GYuZTszW/yBdkCBq2zpAL07v4jIuNKeBp3B87VUSkk/hcxwjE7EL72Bt0vBbeFF4TAfQTjdQyL255GeGV+TktU0NBUbUVjSi8EjI6FDVB2C2w6eoLRH8erU6yuwP7cMD2a7d6KH3sqRh9Drnw8daUeYXSMPJMTkXHUSrX+5E1ljik52lbA2pRpaLcDwShysDgZHSSwitgukyubttZJBPDmewcmG/kJvstLMW+tq0fwMKrpPckq74Xgu/xXFb71HoSLMvRnnH3pfV4BWIfiGNUrijP/B1XvvAvFmj2G1LMONVYEPc6JGAlXFe+n6rQ/kDK/aKZUb5UFFKemt4HEJq7E+Y2w+EtiMQlRp48Z2tUlihWEEqmGSIcKCKRkDE3ZAzSW3XjvkYPZ3t5QFNfALjSBsMp5vBsKEDh44S0hgDRiZiW0EJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(26005)(4270600006)(6512007)(38100700002)(76116006)(66556008)(64756008)(66946007)(66476007)(66446008)(8676002)(91956017)(110136005)(316002)(8936002)(6486002)(122000001)(6506007)(82960400001)(2616005)(478600001)(71200400001)(31696002)(5660300002)(19618925003)(558084003)(41300700001)(86362001)(36756003)(2906002)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N05WSXBsVGFKK3pObXMyRml0bUpvZFNoZWJwS3g5VWlVcmRhWUEzRENuNHNS?=
 =?utf-8?B?OXBxOHl2MTQ2M2Q5SUIwWThkdjM1Wk5nNDRyQ2dHdHc0d042SXdZUGprQTJ5?=
 =?utf-8?B?dHFWeUZpbmRjQkNrQ2FydStjeXJEdjJ0dUdCa1Y4eWNIN0QvODk0MnhWcXkx?=
 =?utf-8?B?cmpYdjA5SWx6SE5XbnR1QkRLRWdSTU13d1QwQkZIT0dkLzFVZ08vNFY2Z1Vk?=
 =?utf-8?B?REpMYW0welhBVU9Wci90SmhXWVVDdGFzZ0xvMG1SbHBCcGkvL3dyRElRTE5n?=
 =?utf-8?B?Rm8wb2t3dkRVWFJ2N2xHV240YUJVQnV0TncyMHF3eFcyckFXYU9vTjhZSDZF?=
 =?utf-8?B?NnZ6OTFUUG1tNGpTc3JXK2VTOElGeDc4Rm13NUM3MzFGSGxkV2dyNjBIY1pi?=
 =?utf-8?B?eXRSbzkydTBvMUFHVklaakQzdGpLQmxTOWlZWGp3U3FqWEcwKytEY3FCR0dN?=
 =?utf-8?B?WmVMMGZrcmtaVERTM2dnQ28yZGowN0hYUVRxVXYyMWduTjJLVGphMFR5eXpq?=
 =?utf-8?B?NDk4VnptY3VwZDM1aVlmYmpyc1ozdlM4RG4zNEtOKzNFRDdNK05VWGV1bTB2?=
 =?utf-8?B?NVUxL3dZamJiVTJ2TVE5NnZVQU53ZW9tTDVHY1VERW5yd1pZdU9KNkVueC90?=
 =?utf-8?B?djcwWktSYmc0K3JnZmQza3FQelhPUW9tSjV5Q2RjWTdrL09yWkpNUjZ3bUsr?=
 =?utf-8?B?dU5ZWmN2aGFBZkVEQ1k4Skt0K3NmdjFVdy93V2M0MVoxcXJHamtLV1FOSGNX?=
 =?utf-8?B?eHg2eU9YQVB2dTFqaGVUY25WNEdYend0OWVjVVIxaFJoRjF0M1NBUDY2ZU5n?=
 =?utf-8?B?R0hOaVFuVWNBdnNGdTBrTXpBT0kraTBFZWJLNno5Sm5ZVGtsRzlvTjVxYmpI?=
 =?utf-8?B?QVRNMUVjVnE3YmE5TSsycW9tNHcwN2lBcXg0d2tSelpuNUoxaXVkeTVYejh5?=
 =?utf-8?B?L09BZDc3cTZLT1YwZUJmZmI0VWk3YlppbHBJMzQ3WnZTc0RPU2Z0QmtqUm1a?=
 =?utf-8?B?QXNrbGZvL1UzaU5DdUp4c3pIY2N3aXh5ZnFtLzllQ3VMdWhUT3RFSDFVM2o1?=
 =?utf-8?B?ZGJIdTVhc015ZlROQ2dQR0dXT1gvTTdxcVphdGQySDBQck1scFJleGF0N1E1?=
 =?utf-8?B?dDBHSDdSUmhzMFh1WTd5YUptVnBiSHBJTGovMGhNczN6Z1RuSjFJTDJtN20r?=
 =?utf-8?B?STdkaEZJU0FvQVlCTlZXN2ZoazFwRmIwZDJYWkZSOFlKRlJIOEgrL1dOYzgy?=
 =?utf-8?B?YW1GckY3VEY2YVFVazkzNFkvc2laalQwekNiQ2ZuRzZoOE84WUZ1Z0p4VTRj?=
 =?utf-8?B?SjZNOHJoWUJNcjd2dGU4NEJVR3dlL3RNSUV2aW5rR1EzclJZOHhBMTUrRVBn?=
 =?utf-8?B?bC9kNUtWTmplSzJmbDVrOTkvMnkzWFQ0OGprcEU5V3FCbW9mMTRBdVZZZUhp?=
 =?utf-8?B?Tk9kUFNkRGtiZUhGbEMvVEliYmUyV0syTTFmYU1nUzdIWXFyUlpyUGVZclRQ?=
 =?utf-8?B?WFpKRlBPMVBTbWhBbU5nYkZvWXJFMDVGalN0aUZEN2x3TkNjMTBLd2d5cU9B?=
 =?utf-8?B?TFY0TGZXU2xOQUNvR0lzQmVMR0RSc2xGRno1NVJTRHRaR0tFU2tNVWRybnZS?=
 =?utf-8?B?bVpoV3J6UFVvUjl4akhIYnBsdjlpYkk2emo1VGxLM2NQRWJBaGdpTStyVjV2?=
 =?utf-8?B?eHRNdjdzQW5ibUpETzNoTXFERmN2SG41aDBtTXFYWEkwdjZQTkNBVXlxczR5?=
 =?utf-8?B?TGhtQnUyUUMyOFZPNUxQOUZtZUUwOEdqV2NWdmp4MXVMKzVVK2w5eUh2RHA2?=
 =?utf-8?B?T3VZZzhFcmZ2QzIyN0czemF2RzMzVTF3M3hJZ1hvdEM2T0RuSVpQU1JURjhq?=
 =?utf-8?B?TEJuMENkZE9SNVNoM2NlM0NRTlZ3cnR5STdKV0VxcEQwMmR5aEdmTUFraDJX?=
 =?utf-8?B?VjFuL1dHeTVneGNZRDdZdCsvak9rTit3ekFzTGNKNUtTT0dmVlhyQ2R5elMx?=
 =?utf-8?B?QTJXckVGZEFYVXNIeEZjRjYyeXJBbTRzdDZOMUJMalU5QlFMekNWTVR3QXdD?=
 =?utf-8?B?RmcwWDVuK0EwLzFrMDJJa3E0d0tMRmUvMU13NHIvNzkxNHFqRVp2TVMzT2g0?=
 =?utf-8?B?UEo2Y3JRajNoUzRrTEgyVHJzMHZ2UmhaM1hnYTF5V0I3aXZBbUdaWWsyQytj?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B4165512658F43BE2D191808BEB6B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfO5Fx4kt7BnX7Jr/ArxNvBKssMpNVeV503o9kzrkT34cppWInCm+JbDUqQ5wPGa687EhVNwlAIduzpEmkRiJjGxrvuZ+2Gnu+jVVV0MXTwl4iQLHqH7RVsHgGwqjgwi9dzfvR0UAwmxshPKD/apy4IyWlXbFetEXnObbMods9/XJj8a4CgfwoBYMcLdnTIfp4wR0DoyN8NGTtp9tVomuHuI1qF7q69TtyavBCYsoxcaUfwkNMuOWM5eRcrpT6qZExwKZeLL2bSkshynnStMKk6ego0iWhDc7NapPuL0ZbsWq8ct0IQ3QFD6VAAvhxEminJWh1wJ6ImmNOMu7Thbspqta1Dr/My0Oxt0ZP4g/DuLc86qXUR0VovNeqJg7BUEYJcUs2vy9kj9F5WS21toQHKFTybMggRecoPhPrvcIfKsjJKksE/Mf4JRgth+MQezO8rZB8FWvrhfBsXBizlSxosL7Mh9kEev++Vx0g+b/hmpPRrO7lebMiRrCaDhp6ckeCTRlCzmNyD+AwVKE8fYC4Y7ERpO0BK1XmlSzZEJQ2NYdfNHrTgNQ3z670EAc4vwpOdOXo28fDtFlWJLMYLozScP3/XR1OcklRKK/4dpahJ/ALCeITMnlI/ant5rgyZ3VzC66iLxPnNHxIfgHzRW0k6K/duM3KDjLVj9dVu/sfCFgZ0WC2TgdiIOU0dURnws4S5YzFYsq9GzeYjxQyL7dP5sevS/J5pqyZ0h8dT6aDfH9dH2OHgYxKQx/fcymdSK0KXLDcAKBmyJrnDHr5vQW9+sdwsrvJa93MH8M7sFIbRqWHjvilXIimL564ZS/cB1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5c679f-3aca-4152-54cc-08dbe99c9e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 07:45:08.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqOsZP4yQAhyuYSzLHpr6M5NXhoE9bZ11bdML3ivgbgytcGGQ1xSmjhWugjgfwXTpGPYNhjkKRe+RUFMDkrsPQyXxmUWdHAi7voB6XQ/6Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6444

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

