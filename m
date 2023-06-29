Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3AB74221D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF2I13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 04:27:29 -0400
Received: from mail-vi1eur04on2077.outbound.protection.outlook.com ([40.107.8.77]:52974
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231848AbjF2I1C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 04:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAOFfjp6+c8Cn3Wc/Yr0lKimM7bRXf4CMqhHrFIYzCsFKJyV3hYvRwa7J9VaIT8dAIO0WWRQ6FS4zi/Z97NUSODe25v9Tv7JFucGsdz+8V/jzp2OLoEIYe+auP7SsS9eld49KnLOyTVaumFGXq8r7dV4jQg/4809bE5cYo6z2jFutHeIlfywzrq4e0bVZe1G+c0FS5eC+AiWjsoPsJD+OJfHNCo/54AB4TqV8vBtdRmWi30AY0bk39xs8prAfonJILqYMMg+ROGnn5sxlJQ3EdUg9EFm/WzMOqOa7HCCBDl/AsvRTCFsh77kXJ8aJAiGucYus6RbfdoIVCJmK5B0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGk4NLLXrNlpUj/0GHZW2waxfgljYQuzKW14+pgRodA=;
 b=RTxkARTMfmkB5Uz0ejJ5Jz4eDMt0MCc/Zw6chEIiMYAJBd1jdaCvH903+cHWfyAfnH4z88QxHn9B6E9+aL6l0BC15rknpGHh3lWRYEoP4BZHeLmtxBQZdtN6S8azw69vuAP1II2w/kQEE9TdqJ2ZVcBcfv5TUDClzx8Sz0quS4D6oivpGXsXpDiglZt6Xf7ILFXejxnMLFfA4C+BEwX26u+F5x2lc/+sun3vccwZeobYn9Ytd3Q16tCurvYsxSCMS6RrUYRz4AO20dq9MzG6Z76/8qLaBnxeZ/cord4VLVlbgWra9UcIBmHjhqLYITeGW9ypfcFXAmvFP/r/GRvs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGk4NLLXrNlpUj/0GHZW2waxfgljYQuzKW14+pgRodA=;
 b=wnvf2L8KzBDFbXPO+PSW7UeUR239Xxig22O1Yo856z7kGy2cxUw1gYnzAJF0iKyKa5NHKkd6/yu2nSkQObR5G2GJODPGS5ZBVvF3PdM9BdCXaxyho22uI3h6sw0BNKSFuKYmTOeUfLr9zunS62BspmYAZV1y4ZvAAJhKIZavneg=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AM9PR04MB7491.eurprd04.prod.outlook.com (2603:10a6:20b:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 08:26:59 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6544.019; Thu, 29 Jun 2023
 08:26:59 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2Bg==
Date:   Thu, 29 Jun 2023 08:26:59 +0000
Message-ID: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AM9PR04MB7491:EE_
x-ms-office365-filtering-correlation-id: 4a5765ab-06e6-4dfc-7e1a-08db787a9b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDQd3parf3aOcdUEC5IyH6csfWbLO3fH4tf15dULRhdmWVP8Ox1OrJnmZZZDFI3os5xYxYQ7mZrD2sGiHj/Y/PtB/ztr7FGAaqRToAurWTXpzJyYAWkC7IbImYtkifB7DKaWcY7Y253HiUVPA7pa+uVOsgNRy9SdqsZ0Jo8EwU7rZTuASuL30A9OJ4eWCdEm++yXTG3yS3CEkFSVcV6Omr1EPadPgpAVTYN2lk+/BttRtWt3BX5JyOi+Gju6F/gmYsE1vNRVpg/R0ycJwQaJsWf2p0Yot7KifhpvjEQ1GJiZI7MixjU5BxBOGLiAT2HGUaEKGeXiumY4WsPKMe4D5M/LvKX+xQr12eORloBFrIJLO4fEi5esF0DHXnhU5Uxfa2n7gR+e8NLup7C4bu0dBo6xoPhuEpD+WMlrm3EzxrEEdcYXXg0T5trHwFhg1HtE+kNzuL8M4eRgonttxQzTRslVRN84y+H6XlLd9O4kQeYygxwovOXNCm2qjQ4bpnnV3CN5j/X1DUL6jBdiDRp+PXrtLI8SJjdt1s+tJBNiBijP6gEKAH/MYsIqSaBdh2LtA4N+dZeQuo3LpDYkUcsqv+6Y24QRM2K/KW7NdEJkBLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(396003)(136003)(366004)(451199021)(83380400001)(2906002)(71200400001)(26005)(186003)(6506007)(9686003)(38100700002)(122000001)(3480700007)(44832011)(52536014)(5660300002)(66946007)(33656002)(64756008)(66446008)(66476007)(66556008)(41300700001)(76116006)(316002)(6916009)(8936002)(8676002)(55016003)(38070700005)(7696005)(86362001)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUFzWGlaNy9WOVJLUU0wSVdQMDIxdTNJaXVFREFqUXVwY2RMdm94ZU81Qks1?=
 =?utf-8?B?R1IwSCszRFg4WDU4V0M2WmQzeVYvbmFhbmhEeUlrTnNyN2ZUZGVOeC9majlu?=
 =?utf-8?B?L0I2T0lGSUxNNEIzS0lZT2o1cXFWOTdzdHIxb1hGOUI1enNhV1Q3b3NscDVo?=
 =?utf-8?B?RzB3LzZhU0FKNllSVmsraE9hRlhMSWZ6cWExZk80aWhxUkN0eWdzQ0xFck4z?=
 =?utf-8?B?ZDlVM0xvbTIrWjNDOTNyWmpaNUR1Z3NiRkU5cWx4aXNjZUZyQitxeW9zbTYx?=
 =?utf-8?B?OFRSMmNqbWcrQWQ5OUJDak5UcE1SYU5lNVVCbFVSZ1U0L3NhZUxSS1o5Sm9z?=
 =?utf-8?B?cnFhb1dqQk5OdVN2M1NuMW4vUXJGcFgwVXRSMGFmcWUvSlZsaExodmFpZVlj?=
 =?utf-8?B?YjJCdnBXN3pXZmxYSG1FY0FQVmZ3RWNzRlNKWnhiaHkxSmNWUHVYMGhZdmh2?=
 =?utf-8?B?eWhTTG9JWGp2NlRIL0R1WEhqMVNKdExXSGtCRFlZUmltVmFZSHJaSmtSSmhC?=
 =?utf-8?B?VHpiUW5NVExGajJJaTV5eU8wNzM2SHU0MnM2ZVVsOHQvNFZrMEsvY3lYU2tJ?=
 =?utf-8?B?eWUvRzlMMnZrdWZXL0VVNk9oVkFKV2ZpMGV4S3lXRVdjWmEydWg0c2RneHpQ?=
 =?utf-8?B?MTVpc3N5QkIrRnBQMTZzL0QyRVM2WnA3Y3dvYzM3RFNSVVVVZFVZLzdqWGpY?=
 =?utf-8?B?R1d5WVRPNXprdm1KamJ3RDBFYnVXZ1Bwelp4eEdrYXdhKzFlWlI3NTh1alo0?=
 =?utf-8?B?RENMa0h5U2ZQSVdva2IyRTVBZG5yRjVWSW9BdE5BNVJyT1EvT3JuNmxnNXoz?=
 =?utf-8?B?SHp6ZVVJSkc1cEhTcmRpS29CUEdEamk4K0dWbHRYeEIyOFROc3hua0pZTW5i?=
 =?utf-8?B?cTJ4UVFYSTI5N1J4VTFqWE5TaitsMDZiWUs1YlJrMGF2VkJnUFhLYXloTGtI?=
 =?utf-8?B?WXcvQXk1bjJOeDdPUDdrS2ZWeThpL1YwZm5SZTJES3BVM3FuYTdZU1dRdXRr?=
 =?utf-8?B?T0VXa0wvZnJtb0tQZndXTUlyVXkvNUJZNVJZTkVENDhyK3dNRm1ZbFZnQ2li?=
 =?utf-8?B?RW1mbmFVZHdvR1VKU2N1MWxIY29lNjdEeUozNzBSMDFBRU4rWlhSN2FuT0JZ?=
 =?utf-8?B?WVM5bWVhNzNNVlJwUXk0UkZ3NFd3bjdUeVdrMUYzWlRzVXJDeWxLZTRFWU9M?=
 =?utf-8?B?blo4OG91SjE2SkJaNVpJWjM2MWxUbURvVXRkcldSY0RMWWtxL3hHZ3hqd1hn?=
 =?utf-8?B?aGpPOXFqU3k3Z29QbnErdXB4dTlPaXhZNmxEMW5wV0RKcy9WUXk2b1B3QkJx?=
 =?utf-8?B?NTJsRTBCdHRZYlEyNjdYbEZPaU1uamJsbitYdG5nYTN1TmhtTlJjcU9PODVa?=
 =?utf-8?B?Q214RTFNbDFjK1pPUUZIdGx4eDlqNFMwM0lIdmFCeHV6Q1BNYlNuUTF3YS9y?=
 =?utf-8?B?SExFRVlnK0N3bUhXaSs0TFFUZzNiUTZIaVZnYjlTR3kzc1NENW0xN1Y2b0My?=
 =?utf-8?B?bXZvbGF2eHViOStUUjVhWTFsbDlzZDd3UGlLcjR1QTdEUVZBWG51V3dvTHcx?=
 =?utf-8?B?OC9jaEZxeXJ0SFF5S0t5RnM1aEpRbzNjc3poSFBDZjRhbjF3dytLZkorSUJ1?=
 =?utf-8?B?OXJUQmpLY2puR0c0Tm5wcXhCRHhNNzdKejRyc2EzdXJncnljZUtLRlFoNE8w?=
 =?utf-8?B?QXBWbGFXMjVKSHl0cVRYVCtQbWtBWE9pY2Vvb3FpenlPbGl0bEk4VGhOYkhF?=
 =?utf-8?B?bVZ4Q2hGNjBDRGtScVVKUk5IWjdJVWJSNDRUK1IwMjUzTk9STVdSVzJkeGFo?=
 =?utf-8?B?VFhXSjMyVTRwMzh3UDJGS2pNbjBhaXlQU0F2MDYwOWtralAvWkVtREVyWG83?=
 =?utf-8?B?cTkvZ3JZL1A4UHl4Y1lOU2syZDBTZnk5aTVkcjFWZlorRDlIWFhSbG8xVHFF?=
 =?utf-8?B?L2hjdFROSE1IK1F6bW9oL01adnZITkl0ZmhuVDNhTUtDaXQzekJjMVdWRmJ5?=
 =?utf-8?B?cDA1L1RGbkFlT3dVbm12Q0hPTXlYSjB6MzBoSDRpZWlhRk5mOEY3VDJ5V0d4?=
 =?utf-8?B?bnZCcE1mQ09JcCtLK2ZPdUNHUW1TUlVEQmZDQXJCRHRTV3NRS3NvaWxRa3RG?=
 =?utf-8?B?eWhvMGZvcEVVMXQ3bHhpbEREeC9iUXJmT3hOR05oODdQUk9icDdzcDRUQ0hu?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5765ab-06e6-4dfc-7e1a-08db787a9b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 08:26:59.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9MCHKk3OsCE8LCc1+lGEYYsMIH4jobk39PtRoLEhhyaFD7F/2Q5gKA0yQI87WLw588ZClwsz+15XjMEEuBbR0yfUknmCBeKwjti+HMI+Kq9AhxBI1+lF3dSYSIDq7Hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7491
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkgZ3V5cywNCg0KaSBoYXZlIGEgQlRSRlMgdm9sdW1lIHdoaWNoIHByb2R1Y2VzIGEgbG90IG9m
IGVycm9ycyBpbiB0aGUgc3lzbG9nLg0KSGVyZSBJIGdvdCB0aGUgcmVjb21tZW5kYXRpb24gdG8g
c3RhcnQgYSDigJxidHJmcyBzY3J1YuKAnSBvbiB0aGF0IHZvbHVtZS4NCkkgbWFkZSBhbiBpbWFn
ZSBvZiB0aGF0IHZvbHVtZSAod2l0aCBkZCkgYW5kIHN0YXJ0ZWQgdGhlIHNjcnViIG9uIHRoYXQu
DQpUaGF04oCZcyB0aGUgcmVzdWx0Og0KDQpoYS1pZGctMTovbW50L3NkYzEvaGEtaWRnLTEvaW1h
Z2UgIyBidHJmcyBzY3J1YiBzdGFydCAtQiAvbW50L2ltYWdlLw0KDQpzY3J1YiBkb25lIGZvciBi
YmNmYTAwNy1mYjJiLTQzMmEtYjUxMy0yMDdkNWRmMzVhMmENClNjcnViIHN0YXJ0ZWQ6ICAgIFR1
ZSBKdW4gMjcgMjA6NDc6MjYgMjAyMw0KU3RhdHVzOiAgICAgICAgICAgZmluaXNoZWQNCkR1cmF0
aW9uOiAgICAgICAgIDM1OjM5OjQ4DQpUb3RhbCB0byBzY3J1YjogICA1LjA3VGlCDQpSYXRlOiAg
ICAgICAgICAgICA0MC4xNk1pQi9zDQpFcnJvciBzdW1tYXJ5OiAgICBjc3VtPTEwNTINCiAgQ29y
cmVjdGVkOiAgICAgIDANCiAgVW5jb3JyZWN0YWJsZTogIDEwNTINCiAgVW52ZXJpZmllZDogICAg
IDANCkVSUk9SOiB0aGVyZSBhcmUgdW5jb3JyZWN0YWJsZSBlcnJvcnMNCg0KMTA1MiBjaGVja3N1
bSBlcnJvcnMgb24gYSA1VEIgdm9sdW1lLiBJcyB0aGF0IG11Y2gsIG9yIGlzIHRoYXQgbm9ybWFs
ID8NCldoYXQgY2FuIEkgZG8gPw0KU3RhcnQgYSBidHJmcyBjaGVjayA/IEZpcnN0IG9uIHRoZSBp
bWFnZSBiZWZvcmUgb24gdGhlIG9yaWdpbmFsID8NCg0KVGhhbmtzLg0KDQoNCkJlcm5kIExlbnRl
cw0KDQotLQ0KQmVybmQgTGVudGVzDQpTeXN0ZW0gQWRtaW5pc3RyYXRvcg0KTUNEDQpIZWxtaG9s
dHp6ZW50cnVtIE3DvG5jaGVuDQorNDkgODkgMzE4NyAxMjQxDQptYWlsdG86YmVybmQubGVudGVz
QGhlbG1ob2x0ei1tdW5pY2guZGUNCmh0dHBzOi8vd3d3LmhlbG1ob2x0ei1tdW5pY2guZGUvZW4v
bWNkDQoNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1
bmdzemVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TDpGR0
ZXIgTGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxtaG9s
dHotbXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBoLmMu
IE1hdHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNyYXRz
dm9yc2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xpbmcN
ClJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWRO
ci4gREUgMTI5NTIxNjcxDQo=
