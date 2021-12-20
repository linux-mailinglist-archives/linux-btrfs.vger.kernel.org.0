Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC447A93C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhLTMKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 07:10:09 -0500
Received: from mail-cpzbra01on2045.outbound.protection.outlook.com ([40.107.112.45]:12001
        "EHLO BRA01-CPZ-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231173AbhLTMKJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 07:10:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6mEnxxOftYu/0Q1H+wDALwLwL5/b6znoNRe+3zhWMTuCrMs5C9O9i5C0gy47nIFGadDqme0SR5l9kkxmLHnU7Zk+pmmUTNTTI/NXlpSjoFwCQzI9ZZnfPFrSZEKY17qCSh0ld3sA7ypbO9OscK9QFcj1cMU6ZdtSNa47W3Bmnsc85LhhA5g2slR5I1x5L4rmHLyxjdep9G5+S/fhQKmJa+/YGo2OJlku9J6yiZSmgyaTB5JihzOJiiCuSN2ZhAp7NKgp0dA2y3nw0GG6o09V7WtQwsDRdwm6rNUUzljreB1q8JqTn5EnA+c6h5md6pqYtH0Ph36isgjA4SKnPbRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIc/0UN4W+TmPysQYXIFn6V7CNhc/WdxDP7L+ua74f0=;
 b=G2D34dg6aNpIu/jLHTcWcEOmp6XPChu7WZKtDKSManuOi+tkzNwtVWZgD+/F60x4nhaqjNyqcKsxXRy2G7nY2ztw8BMa5EyacCy4J1ufWXGIkFXkPAMZoakkAjfYqAbKQYTBWVBMGRQN542fzvlOoDfmSXgx6iiSizIinlFPVaFP5lyjgEKzYDdy4r3m6ZWWHpqsAwng37rN6fFT7qC5jvV16MoovZHKMCIRDbxUDbrLpIt7iq9w7miIvKGgRi5yX6gKmGQZ67oNpOoL+nNVVdkIkQhgU6I69gUiQUAFE8VQW4Tv4uTt/SFk+k2bt0xT0MZFnl6oROMvuYZ+BXqNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stj.jus.br; dmarc=pass action=none header.from=stj.jus.br;
 dkim=pass header.d=stj.jus.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stjjus.onmicrosoft.com; s=selector2-stjjus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIc/0UN4W+TmPysQYXIFn6V7CNhc/WdxDP7L+ua74f0=;
 b=bTtDJ8/wYXbz8uRGJI3CVRRxjH4hBWNWYRfnYNvvODwbysHy/1GmqSeuA0LwfWqto59h2/Oo5b46Z2CmJpzbQ/c8YmirYSAgMpi/c1d1zVog+B2VHbJAbo+Lv8XCTPjafRE/KfPwl1wqQTfouIh+ZF1vb2lKQ6J8l0xDeOpSj/Y=
Received: from FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM (2603:10d6:203:1a::6) by
 FRBP284MB0300.BRAP284.PROD.OUTLOOK.COM (2603:10d6:203:30::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Mon, 20 Dec 2021 12:10:04 +0000
Received: from FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
 ([fe80::fdbc:7b9d:f5ea:eea7]) by FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
 ([fe80::fdbc:7b9d:f5ea:eea7%7]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 12:10:04 +0000
From:   Jorge Peixoto de Morais Neto <jpeixoto@stj.jus.br>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Recommendation: laptop with SATA HDD, NVMe SSD; compression;
 fragmentation
Thread-Topic: Recommendation: laptop with SATA HDD, NVMe SSD; compression;
 fragmentation
Thread-Index: AQHX9PeMAIFWwWTUJUSLIALJHEyg06w7LvsAgAAcH4A=
Date:   Mon, 20 Dec 2021 12:10:04 +0000
Message-ID: <68123ebff72088e42ae1840210161ffee6622087.camel@stj.jus.br>
References: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
         <CAMnT83t1WXvX210_UEfNy7Q4dfKkgJn2j=AMNB9zbVAPU3MEfg@mail.gmail.com>
In-Reply-To: <CAMnT83t1WXvX210_UEfNy7Q4dfKkgJn2j=AMNB9zbVAPU3MEfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stj.jus.br;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6cd65b1-c7e8-45fb-40f9-08d9c3b1a7fc
x-ms-traffictypediagnostic: FRBP284MB0300:EE_
x-microsoft-antispam-prvs: <FRBP284MB03006503AB9DA33629845FAAF17B9@FRBP284MB0300.BRAP284.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCskMIOiovYZHi15b9HSNWt+JftOoLjMDAQlQzV5sMDo5tPGtpWjCLSB73iq/14ojf+ZC4KMiU9ARlTg/O19MaMF34KD3/dMXJJGRo8a8gJwDlGiiW9eJ44io/Jc0ZhHjHSfHHuvBjeV8UPKE4gTGM1mj3EIKFieKtoSYwP03luZhX3D0miJ7hjCtXNjyCfbdj9nEDxNfup/TTRTTk3sg9zYgfFbFDR4V5GfEevDQFzOfzKhbFscVhGSEE3VsSL0RjK/sGC2O8CA5Lg05gCyUUsrIpgyw0emRfQmK9wKev4pvsWHdjLec/oJ3xOuY7iB6GLwu+r9dXm6dPRD+vxZ/j6OAdYZSnt3q/9RIQoJmaCAkWjDXCjRIwvohjMv4tGjwWg3aFz2swmvI7n6lrY6hYw1RIImOVBDFK8JIXZVNMXOCv3hgjp4/zAjRfYIJBCwsJovqxSDhSIpDmMB4ExMJqD1wS54LooDSrYqy1xULZJ8axMMq+Byl6ynIFide+kcFxuT6xftg8m/nXL79O7cEGjK3XxDAQTgOLoedHPmO89B+vjxFnKOslDPETXZHyM9OBVM9js873nXnwkh5CTkefY+Rj+lEVZjz703Ogws3bAI1NeS6FpbJrUozbtnEPXnA+U3CEZUNSPNCMxFTMkyFMOF3pFJpm11j0pVJRVmLOHTSkwU5l+dogwrKf71jgJbBwZEL7LG+xoe3+5EZ1EMxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(71200400001)(38070700005)(8676002)(2906002)(508600001)(2616005)(86362001)(83380400001)(66446008)(4001150100001)(316002)(186003)(26005)(6506007)(36756003)(122000001)(38100700002)(6512007)(6916009)(5660300002)(66476007)(91956017)(76116006)(66946007)(66556008)(64756008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THcySHNYZWdVMTNhaDFTYndEbURXcUtJMVZxcGd5U1BoRXJ1M1hmeDI5eTds?=
 =?utf-8?B?Q2R1Wnp3bWpzanR4TzJHdVVxSUNxYXRLMGJZUTJYQlBIa3hhWjhpM2g3V296?=
 =?utf-8?B?N0U4NkhWUGJ3d3gzaGs1bG1jVithdUpyNmtqcXNibmUzMWpCL3QvSEwyQS84?=
 =?utf-8?B?bGxBR25HOGgvZFEzQUkvS25saVFGczcraW0rbTR4U3dycXhObnQraldMSmxl?=
 =?utf-8?B?c2Y3ZDR3dnV4QTU2NHdSMlhaZ0RCMWdYY2hwa09pVjQ4a1VVSUN2dXc5Qm1p?=
 =?utf-8?B?dzJRN1ZIRE5nMHJYM0N2bzNDSExOTVBsdVZFdUxmSHE0RjdpZGhqeFlkYkhh?=
 =?utf-8?B?SGloZW9LdzRuaFJTUmt2UHl5aUVkSVkrZ3B6TWJQSmlzZ2QxbWthSnZnaFc5?=
 =?utf-8?B?eDZpajVhTmdxSXc5QmljdXZkbmREM1Q4aXZuQzZaN21KeVJkSUs3VFB4UjVv?=
 =?utf-8?B?SE0waWVJZkk5T3ZwUkdnNkc2Mk55ZmxhMk11eFFGOHZFY21xYzZPRDNEV0ZF?=
 =?utf-8?B?emV4aEpOSVZzeFptWjZqbU00RlUyMGx4aGxjWXkycjc1TGRRd1VoMUNJZnRV?=
 =?utf-8?B?Qi85YmpoOEZmTnBHcmhSZGpwZVY2VnZLMU9XaEVpZk1PTDRhWWNuV0hRS1lv?=
 =?utf-8?B?VlFMbkdmcUNOWnVoTVNMUEh5LzVDL3U0M0RZaGk2MDlyWXl2c01KMEpNU2xn?=
 =?utf-8?B?VmNWK3VUUGY1ZmNzY3Yrb1k3MjA0Zi81bGxDdHlid0k3TkNRUFFxNHZIT21Z?=
 =?utf-8?B?OXdwWXlZK1k5bTQ0czJjeVplQ25kZzhscDNLaGd2VzNqZlRMMW9UWmt4M1pQ?=
 =?utf-8?B?ZEE0ZE5KWmhNZkhkYVBQeVRlZFE1WHhhQTNnbjBpeFJReEo3ZytyUmc1RGVV?=
 =?utf-8?B?UkpKVlFtblNiRWlIT285djZLSXZLc3ZpbnNpbzJCOE5ONFZIVzZIbzFPR1VU?=
 =?utf-8?B?cDQyZmdxc01sV3JCRjZ5K0FCdGRhbi93R2t5cXhadGZVb01jYVFMcmNUUTFW?=
 =?utf-8?B?b1dnMmdiQkpaSWltTWN2VTA2eTdUU2pHTHVYZnBjNkVIMndDanR6aUpZMkhG?=
 =?utf-8?B?ZkkyZ3FoNFk0WU5KbG93QUZKVGFQTllicmg5dS9nL3FYWVJ4dXFpZkNFL1JC?=
 =?utf-8?B?eVI0SXUzUTVhRWpLNXI3OVVKNHBsdFdhQ3ZVN0dhNVVZVUZURW5abkVlaFJE?=
 =?utf-8?B?RlNGckk2WHhvckZITjBnYjEyVk9zRGpxTUtaWWVETWJiTnE5Vkd0anRUM2Np?=
 =?utf-8?B?Nzh5NGhiNDVwdzhUSjUwblovTUNJWktBdVZZK1huWHVaZjJPR0xrVGFDR2F4?=
 =?utf-8?B?WHZ6WkNJeVN2cE9pN2ZKOWVnclZsUXRjRWFqTnpndnB1dVVua2NIR1JiN2hQ?=
 =?utf-8?B?L05NNWdJS0pSQ3lTT2J2dTFESHZteUNydVNxN05JVGZYSXFmYXlYaklTaCth?=
 =?utf-8?B?TUpxRVdWZlRWSnB0K21sYlcxM1FUZ1JYTDJyckpNMXh3WEdwWUcxQ0RhSktW?=
 =?utf-8?B?RTVYNm9uZnVhZWpUbU14V2pmenJIanVMSzJYaEtsU2pCSmUrTDBacnRidStO?=
 =?utf-8?B?RFpwbVBDSFR0WUVoL3B3UmFEUjZNQWErekxVOVJEVWFqcWtHZnh5WEJhS25K?=
 =?utf-8?B?azZvSXgxMVB5YllNeHRVUmgxNmJUR3MrRENIQndXalRtcENBRDhyQTBHd0ZS?=
 =?utf-8?B?VFkyWWg1K1JzbXlLUTdkbzFiMVpVdXlWV05PWXhscDczMkEzS1JRZFdQbW5K?=
 =?utf-8?B?M0lXcEc3Ym5hSURCQ1hPRUhVQnNkQ0FaM0hxUkNRZVlKNDdVTW40MW10Vm1M?=
 =?utf-8?B?QTBWT0syTnBtUzRZOEdtMXhLbG1HRVVRYVN5WVpUUWFndE5pRUhmY2dkdEZK?=
 =?utf-8?B?cWRsZU8zdjh5ZUJtZ211OFhZSnhVdFcwQVBZUGMvckdxOERVRytUZjk3dTJV?=
 =?utf-8?B?b0p2RW9BMnk3d0hXM0FiS01NWlJWRHRscWVkVmVCVlQwZUI1Q1FJdTllYmpN?=
 =?utf-8?B?dGx5a0dEQ2tnbmhzVEwxYlVOZ3UxTVVVNzA1UGhGTXp1djJXYTdGek40Myta?=
 =?utf-8?B?QmRlaHBLWjltVEMyNkJiSU9lZkpSTjlVSzU0aWVCK0JWR3ZtNkw0M1NJVGFW?=
 =?utf-8?B?ZGNCTnN2QUNjRVlmQ2Yvd08yYW5QSVF5aW5qVTJWNkVsYVVDbTdhQ1ZyczVE?=
 =?utf-8?Q?OUx58QC4BFar4k/vH+MsqLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2364D5DDAF68D44EA534BE7BA7EAE44D@BRAP284.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stj.jus.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRBP284MB0699.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cd65b1-c7e8-45fb-40f9-08d9c3b1a7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 12:10:04.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de23d5f0-ccac-4c84-81d6-2892a8c055aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yf13Z59VNh4Zeyjm7eYZCloT4D7rW16L5f5ivrzoL1MFUjNRnqyy1oFd0v4PVRqJxpQP3678fID4vcWl5PG6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRBP284MB0300
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGVsbG8sDQpPbiBNb24sIDIwMjEtMTItMjAgYXQgMTM6MjkgKzAzMDAsIFZhZGltIEFraW1vdiB3
cm90ZToNCj4gRnJvbSBteSBsaW1pdGVkIGV4cGVyaWVuY2UsIGl0IHdvdWxkIGJlIGJldHRlciBp
bnN0YWxsaW5nIGF0IHNvbWUNCj4gKGV4dHJhKSBIREQgaW4gIm5vcm1hbCIgbW9kZSBhbmQgdGhl
biBjb3B5aW5nIGV2ZXJ5dGhpbmcgdG8gbmV3bHkNCj4gZm9ybWF0dGVkIGJ0cmZzIHZvbHVtZSB3
aXRoIGFsbCBvcHRpb25zIGFzIHlvdSBsaWtlLiBBZnRlciB0aGF0LCB5b3UNCj4gZG8gdXN1YWwg
J2Nocm9vdCwgZ3J1Yi1pbnN0YWxsJyB0aGluZyBldCB2b2lsYS4NCg0KSXMgdGhhdCBleHBlcmll
bmNlIGZyb20gYmVmb3JlIEJ1bGxzZXllPyAgSSBoZWFyZCB0aGF0IHRoZSBCdWxsc2V5ZQ0KaW5z
dGFsbGVyIGhhcyBiZXR0ZXIgQnRyZnMgc3VwcG9ydC4NCg0KPiBBbHNvIGZyb20gbXkgZXhwZXJp
ZW5jZSwgaXQncyBiZXR0ZXIgbm90IHRvIHVzZSBidHJmcyBmb3IgcWVtdcKgDQo+IGltYWdlcyBh
dCBhbGwuDQo+IFsuLi5dDQo+IEV2ZW4gd2l0aCBzdWNoIGZpbGUgeW91J2xsIGdldCBzeW5jaHJv
bm91cyB3cml0ZXMgaW4gdGhlIFZNIDMtNCB0aW1lcw0KPiBzbG93ZXIgdGhhbiB5b3UnZCBoYXZl
IHdpdGggaW1hZ2Ugb24gZXh0NC4NCg0KRG9lcyBCdHJmcyB1bnN1aXRhYmlsaXR5IHRvIFFFTVUg
Vk0gaW1hZ2VzIHJlbGF0ZSBleGNsdXNpdmVseSB0bw0Kc3luY2hyb25vdXMgd3JpdGUgKnBlcmZv
cm1hbmNlKiwgb3IgZG9lcyBpdCBhbHNvIGhhcm0gU1NEIGxpZmV0aW1lDQooYXNzdW1pbmcgbm9k
YXRhY293IGFuZCByYXcgZm9ybWF0KT8gIEkgaW50ZW5kIHRvIGdpdmUgbXkgVk0gYSBzZWNvbmQN
CmRpc2sgaW1hZ2UuICBPbmUgaW1hZ2Ugd2lsbCBiZSBvbiB0aGUgU1NEIChob2xkaW5nIHN5c3Rl
bSBmaWxlcykgYW5kIHRoZQ0Kb3RoZXIgb24gdGhlIFNBVEEgSEREIChob2xkaW5nIHVzZXIgZmls
ZXMpLiAgVGhlIE5WTWUgU1NEIGlzIHByb2JhYmx5DQpmYXN0IGVub3VnaCB0aGF0IHRoZSBWTSB3
aWxsIGhhdmUgb3ZlcmFsbCBnb29kIHBlcmZvcm1hbmNlIGV2ZW4gd2l0aCB0aGUNCnN5bmNocm9u
b3VzIHdyaXRlIHNsb3duZXNzIHlvdSBtZW50aW9uZWQ7IGJ1dCB3b3VsZCBpdCBleGNlc3NpdmVs
eSB3ZWFyDQp0aGUgU1NEPyAgRG8gSSBoYXZlIHRvIGNyZWF0ZSBhbiBleHQ0IHBhcnRpdGlvbiBv
biB0aGUgU1NEIGp1c3QgZm9yIHRoZQ0KUUVNVSBWTSBkaXNrIGltYWdlPw0KDQo+IHlvdSBzdGls
bCBjYW4gaGF2ZSBzd2FwIGluIGEgZmlsZSBvdmVywqBidHJmcywgbm8gbmVlZCBmb3Igc2VwYXJh
dGUNCj4gcGFydGl0aW9uLg0KDQpJIGFtIGF3YXJlIEJ0cmZzIGhhcyBvZmZpY2lhbCBzdXBwb3J0
IGZvciBzd2FwIGZpbGVzICh3aXRoIHNvbWUNCnJlc3RyaWN0aW9ucyksIGJ1dCBpcyBpdCByZWxp
YWJsZSwgZWZmaWNpZW50IGFuZCBsaWdodCBvbiB0aGUgU1NEDQpsaWZldGltZT8gIFRoZSBEZWJp
YW4gd2lraSByZWNvbW1lbmRzIGFnYWluc3Qgc3dhcCBmaWxlIG9uIEJ0cmZzDQooYWx0aG91Z2gg
c29tZSBwYXJ0cyBvZiBEZWJpYW4gd2lraSBhcmUgdmlzaWJseSBvdXRkYXRlZCkuDQoNClRoYW5r
IHlvdSBmb3IgeW91ciBoZWxwIQ0KDQpLaW5kZXN0IHJlZ2FyZHMsDQogIEpvcmdlDQoNCg==
