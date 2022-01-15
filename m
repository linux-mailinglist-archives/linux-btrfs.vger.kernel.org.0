Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9048F52C
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 06:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiAOFgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 00:36:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21520 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiAOFgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 00:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642225000; x=1673761000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U+7yeyOwL3RN8ASiChXhjdx2KMOKevLCnYlXPNmfdHQ=;
  b=Cwuz4w4qLHNrxpZwU0oVGMcCGzg0xbIj/bV6t5a2r38Gc4f87HO6whyG
   zaTAo193kag3T6XDvGvKkc/qfay/kBvtMtUuSctAKYiDJjq/uJ4ccmTsJ
   ogVQwzftE/s6u0HJnYbwvCaAmruhfuPdSypRvHJD18iaEUd2paLR+Cwm+
   0dZ/fLc/G2qtBzf+Zrm6v4BGDhtb5Uzsqgc/OngkZuAEFud796YhjLLIx
   EHP/b9SL5JMGRFNP3AZxacmFTkP/6YPf5KQDcWVFJDOYDFImi24OftoIx
   TGjlGwlv272dfgMlKqOvMz/mAbSnlqZ78mIPfEp5OkQDavZniz+n0/0Gz
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,290,1635177600"; 
   d="scan'208";a="190519441"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2022 13:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf8XeMjHiNFq/tUOAVQmULXKxclufIKuXy8t3p7dLZi3uFNk8LH1pmDj+gogb/iKKXAYQY/nonbc27Dm79A2FzDzXw5/tNfpqMfKsaWWnjHFg+EasdjD6sghiUARFeq/lhQUufpi+xV1WDCCEAE99jqtrrgKbjT8qXh8uLJCHIi4tNw8PEKCHUfrDxqxEOA1x0m09dLsEL6fungOA93/t8Q7DW68hx/s+GA2LHXzOWtAl1FacppMbNDy6NqAVkYTDRMt2h2LoixoA/8zxIQNWdNGXX2499NZRjLh8biAGJLhdzwzYgRkvhmr499an7o+M5YxDJnxcJ4Tbz9fZ6djIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+7yeyOwL3RN8ASiChXhjdx2KMOKevLCnYlXPNmfdHQ=;
 b=Jbn2CgRrbzKkq2f9EKselOPqoQDLacThT7wfMHxOvHlCGNwgX4cmD8whtPI/GN8wdxCrwup+4OX2YYs7TE7O6Y1j9J1R2VGn1L7GGpBzj8VEXIOhPSDTC3Daes++bnQmXdrrwB956XcBk5+dHIm7J4GVvA85mpZHIdqxVGgzJvpy4WwcRW79xQzYZOdV1GeHaZduPzBFuRG6Plkm+mjsT00+7KwXabewfsOi6m/2wmOYwITiJOjLu00gDeBdduX4H9qXW7lMr55zcFOztOXGX5imN99RmvKQOYKYGrlPRkhff8wesrEtAqSDke3UtXyUAvZ8LkSrmPp9FDT6xEXQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+7yeyOwL3RN8ASiChXhjdx2KMOKevLCnYlXPNmfdHQ=;
 b=tMyjsbg8Ozw8G0m62cR2fk/JQMtmR3Xn6Xbdse7SWEVMyioxVBeCKrmnGi5y4kZtiUa/orpOhD0dccO5ZXPpFKGoItREN2s2F/6eoD/96OS4gBH19Ekj70UgZ6TUzQVlgRikAdVHyjQglEaVkmdbYeQkw4sqKBTZ1pQcNUI/pZM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6938.namprd04.prod.outlook.com (2603:10b6:5:248::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Sat, 15 Jan 2022 05:36:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd%7]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 05:36:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Topic: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Index: AQHYCGn+Q1quPPNsLk6Wk9uNZEhSIqxg6DiAgADI/gCAADVEAIABrG0A
Date:   Sat, 15 Jan 2022 05:36:39 +0000
Message-ID: <20220115053638.bh2gp2t337io47dh@shindev>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
 <fa15b470-c2ad-152a-9398-17bf65be4eba@suse.com>
 <20220114005236.yrvqqzpegik4xhm3@shindev>
 <20220114040314.q46pvlcyyno2ze3d@shindev>
In-Reply-To: <20220114040314.q46pvlcyyno2ze3d@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 709f41fb-cb10-49d4-ea4f-08d9d7e900eb
x-ms-traffictypediagnostic: DM6PR04MB6938:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6938519D088FB5CBC681D560ED559@DM6PR04MB6938.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8I7NUCT1zUQnix9ZlxK/ylicnBc1Z+s3nn+WIpYp6fmhJS9BxAp17vPtTds2WYG4GaOjnsf7ahNNBkPygafzNRF4mILOPSlb90QqcrIGN/2TUvli0jkqroIHYEp0dgSymuHf+EiWJcnC3+9P94R7OPiOx8/tefPlnb1SsZ2Y/zCUU3jAfNHmYE8znumR2/RvFS5ETXFLif9tIEUlhbixptbHgFWKBE3mLHodLqgAatKMcT974hLzMM5VcgeF3RWLMzB+KTt1Hhlt9XrAzpB+lqyrkzf05ydLKgiMCHBaL5JqA2jxlBkeatmg3e0t9MavX1sdPgUFgrRmMTJrRfLdsv6tS8LmJhz6wzwH2093dZ4CyDY2MzUHuofpQ9ZEDizuI4Fx0/7gGAyl4PRTbvGs8BMpR2nud8N5K8URDGQ+g+i0T4YzPZgBxPXoHrnny5Z1Bj/ucttzyIrHIDQrqlYK7+66IF2d8zEEnThJm0R8PvDk/Zl0kV5NfQIS/kxe1UpUrno6kgMap31MhNQBuugwYMySLOgV34CQuNj4Rf6nrAbu0fNcuqSLUMdDmLKdwrZ/PCiz2u6aEqxgcpg2jcxoSD0X3Kprxs2Vj6F4CJ/tP3EjcR5VAuHfqA5HGv3u+N4matbYuafhYZ/FZErdBdTqtXdDS6NVx6MqSBTbYukUp3uX44i7ypiUy8WtKb0U7MXRuhN4+C0R3X3+BKEE2kMhOgpJG0rQXEQgwInUR+pUP8E3MSYMFaZw+D71JLmH27Q5TerQIVeWtXKSJkoTDcq9/JoYCD5i6xBcttntV9DaNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(122000001)(82960400001)(6486002)(5660300002)(2906002)(6512007)(9686003)(8936002)(33716001)(1076003)(86362001)(6506007)(38070700005)(508600001)(38100700002)(186003)(54906003)(66556008)(8676002)(316002)(966005)(66946007)(66446008)(71200400001)(15650500001)(66476007)(76116006)(83380400001)(6916009)(26005)(91956017)(64756008)(4326008)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1dRdGtSTDlUU3dqT2tlVWNiMjQyd0tjeHRyWkFzdE9oWnNlU216SFZvbXBr?=
 =?utf-8?B?WTBwTDEwcWhadzRUUTZtaHlIY0wvSCtrWlA1bW1uNS8xTVNZRGVVTzhZZ2lr?=
 =?utf-8?B?ZVJjd2lKeEFselVDYUZqeHd1T1RvVUlIMk1SWW42b1dNekoxd2ZudEc4L0VR?=
 =?utf-8?B?UFE1SXRQWURqOTJKVWNVc2pZYWYxSWhhelVaQVJxRzBjcXU2MXNLemNSczhn?=
 =?utf-8?B?Q0J0eEUxODJRMFZIYU9yRlRnYkFRMFRDOWQvZUN0b20ybWVWTnRmNjhEMk5s?=
 =?utf-8?B?R2JEeklXMkE0dXRBUjFiaTBMT2E3QnNRSHh2ZXpsd0JOOWFVc0RIVTZmd2pU?=
 =?utf-8?B?SzlFTkdrVVhDSUpzZS9MZ0Z3cWZKMkZML1hURlZIZ2RDZlRCZDZhdlZKRFh4?=
 =?utf-8?B?TUpVb0l6ZnhwVWt2bThGOE0rd2JDdzA1bjMxa0VBbCt1Vm9kRW4rYXBWcE1W?=
 =?utf-8?B?SGViYzFYenFSUEN0Q3NuRlNHNlZPb2pjQ2VvVFprMCtLV2RsTWNhNFFFd05y?=
 =?utf-8?B?bFZZZHJYVDNoMTdSazhqSUNSWWRRd3YxUWhlWEJmekcxQjNiQURSeTdMMHB0?=
 =?utf-8?B?YS9HMWpYbXY0RGxXM1RiN2ZkU3E0c3BhejdZd1ZJMk9DMkxvYVlLdGZwY3M3?=
 =?utf-8?B?VFNTZzVrSGdWS05GTDd4NjMvSStnMDVUWEtzTGVqbHNuU040RXpRL09pbWtt?=
 =?utf-8?B?czF2cVprai9ibThYdERHeUpCdlRyZmFDYmM3N1dCNlp2YzRIV0hWdHhCZEQ2?=
 =?utf-8?B?dW5hYy9JVjRKZjRQSlZQU1JCeFRLYWxxT0hxSnVKQUdZNGVBbHVFK2V5RGky?=
 =?utf-8?B?dXZ5VFV0dmpVNjZGcmtSWWt2OXFLcXp4YXBleTZ4QnpDaDlxQkNkek9JWXla?=
 =?utf-8?B?eXlBQ1BXTlkzalN2YmZpNjlQSFkwaExVejBXQmM2RGdPL0p2Rk1iWXR4bnY3?=
 =?utf-8?B?dysrU2p4TEI0RlRlN3draXZqNW42VitQRHB2ZExLK3lVWEM2NVRycG9iR04z?=
 =?utf-8?B?Skt1T1l5VzF2L1hJRnFURkJzTzEzeUlUeDFsOE8zZExHTi9ybmVCTkFDTkti?=
 =?utf-8?B?RFpiaHhyRlVQeWE0Y1pXaHdRbzFuTm9rcEZUTmorRHU5aVNrUFNXUzBzQzFD?=
 =?utf-8?B?bGM1N2RtVXVYeW4vYVVtcUplMlpnek05V3dNcXc2RGJLTlpDbTc3RVVMMVZo?=
 =?utf-8?B?M3ZNWjNsb0p3dG5aSmJYMWRCNnVYNFhoMXNma3hKS29SNml3Z2VEQVluVTMz?=
 =?utf-8?B?SlpmRXZnMnlydVcydXQzaTkybFNWNjE0aFhYSlBzaStIVkZoZWdWdVNhR0FY?=
 =?utf-8?B?dVZaS01rTkdMRHIweU51VzlZVVFsaDNwcWd5MGRiR21MNDBJVEZJY0FQa3lC?=
 =?utf-8?B?MHRwL1grVTgxS0JaVnpUaXRuOGF2d0VOcGg2MnNWOTBBN0Q4V3lXdjJDeVdC?=
 =?utf-8?B?OC9MelZqNCt4UlFCQ1lESFQxbE10aU1hOTNuMmxhQTlJaUk3K0t0cmd2Q3FL?=
 =?utf-8?B?cWJYTEZZZmt3bkhFaTJvQ2hhZDZxYlYxOThqRVBidUNXYndzajRFVFdmZ214?=
 =?utf-8?B?MDhmT2tubDVQQlc0TE01Vm9pcjhBdnlsZTE3Y3h1Y1QydjZNeDlGQlZ3bzA4?=
 =?utf-8?B?MFdlRHRxMXdoekNNbDJ0SVNna3NGOTJCSmtGSHAzNUhRcUUwUWI3clhmanhI?=
 =?utf-8?B?S0hmbDJnMW80YmE5YTBMNy9sdUx3M1lTQW0rVFRJQ09JZWkrTTlDRUVpQ1Ix?=
 =?utf-8?B?cUhRRzI2Y0grSFNRYVd1VjNJMWN4aXQrNUdEdi9PSUdlUFVva1A3SEs3REEx?=
 =?utf-8?B?bEV3YTV1c2FMSHBNM1FpTU9ocFNreGZBZ04rdlVHdmZMQlhmZklhQ3FYbzkv?=
 =?utf-8?B?RzZVYmtucklXbzREdzM2UFI0aEdINFpHdkdid2E0SmQvdzJ1MkNjdmNPeUFx?=
 =?utf-8?B?SmJ1U014cHBjV1NYdTBXYS96Y1NUdDhTTkEydjZzS01ycnBkNWV6ZEJMWUUr?=
 =?utf-8?B?YnFLZDh4RWlVTHBzeEx4a1RPMDZtOGMxL3M3SG13TDRjRmcvd1ZjZGNoYnJN?=
 =?utf-8?B?WUpGQVVqWlk4RGh2cnNwT2tMelp4UDZjeEVtQll2emMwRWxDejhoY3I1ajZl?=
 =?utf-8?B?ZXY2MUJvMHJHejJDQW84RG1Tb05KM3hvQkJERkNsWE5sUCswRFp5ak5nSkRJ?=
 =?utf-8?B?LzBaaCtuc2V0Ykk0NS9Wc3E5VHBDNkdZNE9CNGZPQWcyamp6LytWMGRkTnZv?=
 =?utf-8?Q?IyJZxvrUbm/jFmyOjR8ifi4XpRQAuyKMx3+W8t/hqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35ECCE45D4A7F44B8828D37740194CC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f41fb-cb10-49d4-ea4f-08d9d7e900eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 05:36:39.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UtLbsutMpwo40l9teCilEtO917E2pkSfYoc6CecQ6MPtELNDwlOKVCk8qrKrKAr99fT6qB81KsCbJX1Z0mc14OvT1mvXhZdMd2F0oqEHzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6938
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gSmFuIDE0LCAyMDIyIC8gMDQ6MDMsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IEphbiAxNCwgMjAyMiAvIDAwOjUyLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA+IE9u
IEphbiAxMywgMjAyMiAvIDE0OjUzLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gT24gMTMuMDEuMjIg0LMuIDEyOjQwLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3
cm90ZToNCj4gPiA+ID4gUXVvdGEgZGlzYWJsZSBpb2N0bCBzdGFydHMgYSB0cmFuc2FjdGlvbiBi
ZWZvcmUgd2FpdGluZyBmb3IgdGhlIHFncm91cA0KPiA+ID4gPiByZXNjYW4gd29ya2VyIGNvbXBs
ZXRlcy4gSG93ZXZlciwgdGhpcyB3YWl0IGNhbiBiZSBpbmZpbml0ZSBhbmQgcmVzdWx0cw0KPiA+
ID4gPiBpbiBkZWFkbG9jayBiZWNhdXNlIG9mIGNpcmN1bGFyIGRlcGVuZGVuY3kgYW1vbmcgdGhl
IHF1b3RhIGRpc2FibGUNCj4gPiA+ID4gaW9jdGwsIHRoZSBxZ3JvdXAgcmVzY2FuIHdvcmtlciBh
bmQgdGhlIG90aGVyIHRhc2sgd2l0aCB0cmFuc2FjdGlvbiBzdWNoDQo+ID4gPiA+IGFzIGJsb2Nr
IGdyb3VwIHJlbG9jYXRpb24gdGFzay4NCj4gPiA+IA0KPiA+ID4gPHNuaXA+DQo+ID4gPiANCj4g
PiA+ID4gU3VnZ2VzdGVkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGZzL2J0cmZzL2N0cmVlLmgg
IHwgIDIgKysNCj4gPiA+ID4gIGZzL2J0cmZzL3Fncm91cC5jIHwgMjAgKysrKysrKysrKysrKysr
KysrLS0NCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9jdHJlZS5o
IGIvZnMvYnRyZnMvY3RyZWUuaA0KPiA+ID4gPiBpbmRleCBiNGE5YjFjNThkMjIuLmZlMjc1Njk3
ZTNlYiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvYnRyZnMvY3RyZWUuaA0KPiA+ID4gPiArKysg
Yi9mcy9idHJmcy9jdHJlZS5oDQo+ID4gPiA+IEBAIC0xNDUsNiArMTQ1LDggQEAgZW51bSB7DQo+
ID4gPiA+ICAJQlRSRlNfRlNfU1RBVEVfRFVNTVlfRlNfSU5GTywNCj4gPiA+ID4gIA0KPiA+ID4g
PiAgCUJUUkZTX0ZTX1NUQVRFX05PX0NTVU1TLA0KPiA+ID4gPiArCS8qIFF1b3RhIGlzIGluIGRp
c2FibGluZyBwcm9jZXNzICovDQo+ID4gPiA+ICsJQlRSRlNfRlNfU1RBVEVfUVVPVEFfRElTQUJM
SU5HLA0KPiA+ID4gPiAgfTsNCj4gPiA+ID4gIA0KPiA+ID4gPiAgI2RlZmluZSBCVFJGU19CQUNL
UkVGX1JFVl9NQVgJCTI1Ng0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvcWdyb3VwLmMg
Yi9mcy9idHJmcy9xZ3JvdXAuYw0KPiA+ID4gPiBpbmRleCA4OTI4Mjc1ODIzYTEuLjZmOTRkYTQ4
OTZiYyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvYnRyZnMvcWdyb3VwLmMNCj4gPiA+ID4gKysr
IGIvZnMvYnRyZnMvcWdyb3VwLmMNCj4gPiA+ID4gQEAgLTExODgsNiArMTE4OCwxNyBAQCBpbnQg
YnRyZnNfcXVvdGFfZGlzYWJsZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4gPiA+
ID4gIAltdXRleF9sb2NrKCZmc19pbmZvLT5xZ3JvdXBfaW9jdGxfbG9jayk7DQo+ID4gPiA+ICAJ
aWYgKCFmc19pbmZvLT5xdW90YV9yb290KQ0KPiA+ID4gPiAgCQlnb3RvIG91dDsNCj4gPiA+ID4g
KwkvKg0KPiA+ID4gPiArCSAqIFJlcXVlc3QgcWdyb3VwIHJlc2NhbiB3b3JrZXIgdG8gY29tcGxl
dGUgYW5kIHdhaXQgZm9yIGl0LiBUaGlzIHdhaXQNCj4gPiA+ID4gKwkgKiBtdXN0IGJlIGRvbmUg
YmVmb3JlIHRyYW5zYWN0aW9uIHN0YXJ0IGZvciBxdW90YSBkaXNhYmxlIHNpbmNlIGl0IG1heQ0K
PiA+ID4gPiArCSAqIGRlYWRsb2NrIHdpdGggdHJhbnNhY3Rpb24gYnkgdGhlIHFncm91cCByZXNj
YW4gd29ya2VyLg0KPiA+ID4gPiArCSAqLw0KPiA+ID4gPiArCWlmICh0ZXN0X2FuZF9zZXRfYml0
KEJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJU0FCTElORywNCj4gPiA+ID4gKwkJCSAgICAgJmZzX2lu
Zm8tPmZzX3N0YXRlKSkgew0KPiA+ID4gPiArCQlyZXQgPSAtRUJVU1k7DQo+ID4gPiA+ICsJCWdv
dG8gYnVzeTsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsJYnRyZnNfcWdyb3VwX3dhaXRfZm9yX2Nv
bXBsZXRpb24oZnNfaW5mbywgZmFsc2UpOw0KPiA+ID4gDQo+ID4gPiBBY3R1YWxseSB5b3UgZG9u
J3QgbmVlZCB0byBpbnRyb2R1Y2UgYSBzZXBhcmF0ZSBmbGFnIHRvIGhhdmUgdGhpcyBsb2dpYywN
Cj4gPiA+IHNpbXBseSBjbGVhciBRVU9UQV9FTkFCTEVELCBkbyB0aGUgd2FpdCwgc3RhcnQgdGhl
IHRyYW5zYWN0aW9uIC0gaW4gY2FzZQ0KPiA+ID4gb2YgZmFpbHVyZSBpLmUgbm90IGFibGUgdG8g
Z2V0IGEgdHJhbnMgaGFuZGxlIGp1c3Qgc2V0IFFVT1RBX0VOQUJMRUQNCg0KSSBoYXZlIGp1c3Qg
cG9zdGVkIHYyIHBhdGNoIGJhc2VkIG9uIHRoaXMgYXBwcm9hY2guIFJldmlldyBjb21tZW50cyB3
aWxsIGJlDQphcHByZWNpYXRlZC4NCg0KPiA+ID4gYWdhaW4uIFN0aWxsLCBtb3ZpbmcgUVVPVEFf
RU5BQkxFRCBjaGVjayBpbiByZXNjYW5fc2hvdWxkX3N0b3Agd291bGQgYmUNCj4gPiA+IHVzZWZ1
bCBhcyB3ZWxsLg0KDQpJIHNhdyBOaWtvbGF5IHBvc3RlZCB0aGlzIHBhcnQgYXMgYSBzZXBhcmF0
ZWQgcGF0Y2gsIHNvIGl0IGlzIG5vdCBpbmNsdWRlZCBpbg0KdGhlIHYyIHBhdGNoLg0KDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy8yMDIyMDExMzE1MTYxOC4yMTQ5NzM2LTEt
bmJvcmlzb3ZAc3VzZS5jb20vVC8jdQ0KDQotLSANCkJlc3QgUmVnYXJkcywNClNoaW4naWNoaXJv
IEthd2FzYWtp
