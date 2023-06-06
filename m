Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E19724E5E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbjFFU6K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 16:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjFFU6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 16:58:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BC1707
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 13:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8OMVQ7+xLvMOL0ODcn7Go3ImbB1wCSOWzlPeYr5xdUS+4DIUCQ3fVWoA/ma5EpcgDCwHs7Y1aPSDmN8ohOasj7FNuPoFlN3HEOTXdSKlhF559yvKAlUJ8x9ezbJFyjgfKJZLpkwVGwux0rzmBZCQX1ZN/k8ncckhaDYQpet6B2dlFfkkbw0BFpGBGGNWIZ2czi6QVOahwJWdQvlNBken7u2dgaTFlafVONLW8qySScfPKF2SOQ2QEjYPGlf9D2etTWgkvBLYLa4a2XF5qgco4SGPFUPdteXXiIE+KF64nZAKGAGVtTrucDzyNxYvJFqlvxjiZlUOrXqEqLOwHopFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5+FWLIQRG2b3aqiGJQ4gSUONlvMzq1lVTyXaGtejB0=;
 b=OOAVwLTS5X+dquz/EUMCJx2X/UMCtjUGjFrCUq3YjqKUZzeYCEukympjR07ZjwEN8/9waHIToqV1EbYqKwUldjHKs2oE1q5GD0BksvgWmQu4VnuPD9AfqHTTAjSbLe4RlGrkVRcP+gwea8RH/Mq1KLxN64ULIuzDR/+fNEuO6NFsXWeYMKZnQf+QXiZ4qAKBwSZK3SCwAMssobrDNgqTrwNWnKArMR/Cs+DisDBwxWVS4wcq5IUFa6lue5rLWGd1sTNz++CnjGX2OM3/SvEu3EsNziYbNNKbSUdLftjH163khiQKWCxRcHNWGRn7WWIe7b9ZzKrPVVN3vMob6vsU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5+FWLIQRG2b3aqiGJQ4gSUONlvMzq1lVTyXaGtejB0=;
 b=iNA/Gk56C16QzAwlHFhEimsW/q1aX+yFq80vUS5GFZ16L8DbYWKEMx2/7R0gTsfv3LZfdAZ17KuLjRLNGc3Jyxve8wEJYU9FUR3xgZ0k64Qek5N5nvZe0iFWcCZekVGjEagKqfgZqWngHgYi5o+VJXP6P0za5UX1CV6MPo3LF3A=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 20:58:03 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:58:03 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8A==
Date:   Tue, 6 Jun 2023 20:58:03 +0000
Message-ID: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|PA4PR04MB7839:EE_
x-ms-office365-filtering-correlation-id: f552e0b3-e9dc-49f2-6093-08db66d0b842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmqrSpRKHkfF15W16dw/tekgJ4HYKi44yp/hj7kcjZX6t1T8ffHSolAQ0dtcKxAVO/Wv+uykyh2i+U8qfIcA25jEbtyzhWbVD+5SzTSpze9744f+rcEgIZWxUkhueMblMgBTfTvRjGcOuXgpOfpY+8d0FZFl7gb4aLr6Gzjri2o6BX2kfklQLTU9yDlOH98U+vOkyY4FS1jVdzNkXGBPMYsQZ4eqDdrBszccooEfyR/ynLQoNuie+1rcDuZGDJ+OTwdmBTMyiPVXzYm2XflY4hUevYmjFhGb3wCqbwuXyT0qRvKsmZNhJ5T4/19SE53+PkGic/3vRdKqkLLqrjx/Sw6qr11dCh/M8thl5Ma0nKC5cFq2BxoZmnKxPUFDXXZ9/5L41Z+Ezl9ZVKKmnu37iPf+nsQ1ZuNovvyPxk7AK7QGb2TK8el3yFAByT2XpWUZa3VfC26wwyezRn5VOwGshfbiLKrtFLGDjUh09FyKWfi8t3TKt7CXstcWb5vNdenhC0s6zXOvlcXOi67E0l64f/lG85sXxv6kPJd5RfoXzPkqBKpTOLPB590lkKJr/tVTakPaQxY0czyZmKdnJAyMtwDzJ1VDsJn7A+YDz9bU094=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(376002)(136003)(396003)(84040400005)(451199021)(76116006)(55016003)(478600001)(41300700001)(8676002)(8936002)(38100700002)(66476007)(122000001)(66556008)(66446008)(66946007)(316002)(6916009)(64756008)(186003)(9686003)(3480700007)(66574015)(83380400001)(966005)(71200400001)(7696005)(6506007)(26005)(86362001)(52536014)(33656002)(5660300002)(44832011)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWMvcGg4WnZOTXNwVytsMlZxSWZoaTJNVFU0Z0RBczYrcklGMjc0WDluZHlY?=
 =?utf-8?B?QU9NVDlFVlpVeWNZS2xZWGhhK1JpOUVCTmZqYURMb0VYcS9LNkdKRmxOWWxG?=
 =?utf-8?B?VUo0NnRrWW95VDJxZGhVaHRjL0ZTK245dVdBY042TGoyZjVzd09yZTBteGph?=
 =?utf-8?B?aVpJSnhLWnpNN3JtbHRLeW1qdGZvODBvS09ZT3VEWDRiSHVnWHcwTHJsMWlK?=
 =?utf-8?B?RktvYVdZWHc4c25MRFJJblN0TjJFVE1idGZweXJuak1iaW1MR1RYYktzTXJN?=
 =?utf-8?B?Z2xqWm8rUUE0THIzaFlMNFBObmVVUlB0VURXaFV5QThQN2NiTWZkRHYyRU1x?=
 =?utf-8?B?WFdZcm4yS2ZOSm1RYVhGVWhkTXpPWkV0RmVTZHBDNGsvN2E0cmRRcWpKYlky?=
 =?utf-8?B?eHVtdUxFQzFBaWIwTjFFNzludHNzaW1Bakppc0FlVDUxV1QvSkhLRWJEQ0JL?=
 =?utf-8?B?U1RzdnJEcE0zUGkvdUw0SXlRQzJIa2t2TXJJRk4vRklGMGR6NVlldjZsTEIy?=
 =?utf-8?B?U25QZVpqeTk4d0hnemsrSjQ2azBMWVhGZUlYWG5QbHFVWUJFczNaR005NHE1?=
 =?utf-8?B?Q2FjeFNnbXNpMWl0TFRNallEM1dpRlpMUmJGT1J5S3dVSXlnYkIycHdxbXYy?=
 =?utf-8?B?bW9yb3B2eUV3V3FyNk9ldHRPVHFBYjBZdW43Y1RLZzdUWFVsQ1dJcUd3OHdy?=
 =?utf-8?B?ZzN3R0EwblV1d3VxMk5pU1U4RVpVMnRYWXhkRjFaOVdLZllhdXU5Mkt1WnND?=
 =?utf-8?B?RExtbXFIL04veUNidElKcDY4NkFuSGg4TFpqc2hBbEZSYTQvVE9QZDJCUlNV?=
 =?utf-8?B?NTF6VXlldHYyVVVHWWVTOUJuejNXcjVQanJRazBlekJ6SFdFQk0rSHgzdVVw?=
 =?utf-8?B?NFUranJzN25RSzFOL0MxaldsSmM0OXRTRFhZZEFEZlQzanI5eVZXemM0b0Fk?=
 =?utf-8?B?enE4QXp1YmNlVURlb0ZZMXArdEZVM3pRQ0kyTi90dWhqV3RvY21WRDYwNzkz?=
 =?utf-8?B?aXA3WjF4K1pqNVVoNXN5c01YdmhzbWpUZVpyUjBoTytUclhQc2Q4UDAzNjFT?=
 =?utf-8?B?REVqUURTR1lLMnVUUUhnbGRpR2IraU1BVTJhd1hzb1plOWZOaVBHdkZwRmhP?=
 =?utf-8?B?OXdidFgyV1plczR6eDhCUkRYL2tOTWg5eG90L0tUeEFHTFMwUmIxVUIwMnhN?=
 =?utf-8?B?R2Rnemk1RW5YVm5aeExESS9FazU3VjdBSnRSWFVtVHd1VHVtdnJ5dGxjbkd6?=
 =?utf-8?B?OFM3Z25qWDd0K1EyY0lkRnNXS0RmVDJwNEN5Q0cwKy9OREUvMGVPdlhvTXFW?=
 =?utf-8?B?dUJjeXAvc2ZNNmRSTkZ2enZDT21Za0Q5enl2VXBFZi8vQmxMaWczdW11WHhR?=
 =?utf-8?B?TGlMcmpKZU5wVU5SYytQZ0p3SkxPQTRXK0hhMkJ4ZllRRUJ4OTZybWd5QVFS?=
 =?utf-8?B?RWR4QXhqL0R1Q29Qb0lHMWlHK25hcmtEZlZBVUtQdFduTWl1RDBJdFdpc2ZG?=
 =?utf-8?B?N3E2ZUMrQ0w1VjRINkMzK0w2bGdOblZCOXNtdlk3MERFZGJaejNWaFprdnhO?=
 =?utf-8?B?aGRzUE4zaUJ2YjV1WFpJTFY3KzQvSzhZcDJrTm4zVnh4cnp4VzB4aHlXQlFZ?=
 =?utf-8?B?VzZ3VzZaRCtFbXd1V2tFd3RpRU1MLzJGM1FITWpiTU0wVzkvdVpjd0VjUWxE?=
 =?utf-8?B?U1c3dVY5c1QwL01aeXFKMWNoOXZMRmZLc2JzdEpVZDVXUS9IekI4bEFyWDNP?=
 =?utf-8?B?OW1HMmd2REptZTZkZW1nYnZpKzhvTHE2ZVVuemVMajgzYkdpdWQ4Vk1yWDNQ?=
 =?utf-8?B?VkRjNk9XekMyRXNnMUhnQjRvNURlcG8vUmd1S0xWREROQm9MT3NETFI1dEwv?=
 =?utf-8?B?NkNjTEMyZCtZcGxBV3BncnlwQlNpWGkwVVoxRDRORkQ1cEt5QXIySnFRWncx?=
 =?utf-8?B?L2RGZ1ZPVlJBcklyMFozODNhdUtWVG1JVkJyTVhwTWVlazY4K1dlZHJZdXYr?=
 =?utf-8?B?bHlQSjdvNjJ6UDhTOFZXYlZHa1FoZ29yQVZxZ09RcDFvQmtXVFRZenl1c1R1?=
 =?utf-8?B?ZkhrS0pzRks1MXVDdDJJaWQvNlVzMzJZRDM3NEtMOTBVOFV0TzVuYUloSURy?=
 =?utf-8?B?dlQ5YUdreThpeWhjOVlXeGlQVlhjbFltUW1ub0t1NFlYYWFTM3lxTzZQdVJP?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f552e0b3-e9dc-49f2-6093-08db66d0b842
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 20:58:03.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idvUPFirs+GMvi4y4YjMElS0lwhl50W9n+Xw6KjXqIs9nnpYBQD/DuGToyMJbFynvoi/hPG2wLhGkuTKMFWlMd0CzCFObT7LjhNc51bnlAACaTZ51n4mTBjUNAjCeT4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkgZ3V5cywNCg0KdGhhbmtzIGZvciB5b3VyIGhlbHAuDQoNCkkgaGF2ZSBhbiBVYnVudHUgYm94
IHdoaWNoIEkgd2FudGVkIHRvIHVwZ3JhZGUuIEZvcnR1bmF0ZWx5IEkgbWFkZSBhIHNuYXBzaG90
IGJlZm9yZS4NClRoZSB1cGdyYWRlIHJhbiBvbmx5IHBhcnRpYWxseSBhbmQgbm93IEkgd2FudCB0
byBnbyBiYWNrIHRvIG15IHNuYXBzaG90Lg0KSSBib290ZWQgdGhlIHN5c3RlbSBub3cgd2l0aCBh
IHJlY3VzZSBjZC4NClRoaXMgaXMgbXkgc2V0dXA6DQoNCnJvb3RATWljcm9rbm9wcGl4Oi9ob21l
L2tub3BwaXgjIG1vdW50fGdyZXAgYnRyZnMNCi9kZXYvbWFwcGVyL3VidW50dS0tdmctdWJ1bnR1
LS1sdiBvbiAvbW50L2J0cmZzIHR5cGUgYnRyZnMgKHJ3LHJlbGF0aW1lLHNwYWNlX2NhY2hlLHN1
YnZvbGlkPTUsc3Vidm9sPS8pDQoNCnJvb3RATWljcm9rbm9wcGl4Oi9ob21lL2tub3BwaXgjIGJ0
cmZzIHN1YiBsaXN0IC9tbnQvYnRyZnMNCklEIDQzMCBnZW4gMTIxNTg2NCB0b3AgbGV2ZWwgNSBw
YXRoIC5zbmFwc2hvdHMNCklEIDQzNCBnZW4gMTIxMzU2OCB0b3AgbGV2ZWwgNDMwIHBhdGggLnNu
YXBzaG90cy8wNi0wNi0yMDIzLS0xNToxNl9QUkVfVVBHUkFERQ0KSUQgNDM1IGdlbiAxMjE2MDg2
IHRvcCBsZXZlbCA0MzAgcGF0aCAuc25hcHNob3RzLzA2LTA2LTIwMjMNCkkgd2FudCB0byBnbyBi
YWNrIHRvIElEIDQzNCBvciA0MzUuDQoNCkkgZm91bmQgYSBsb3Qgb2YgZGlmZmVyZW50IGFwcHJv
YWNoZXMgaW4gdGhlIG5ldCwgc28gSeKAmW0gYSBiaXQgY29uZnVzZWQuDQpDaGFuZ2luZyB0aGUg
ZGVmYXVsdCBzdWJ2b2x1bWUsIG1vdmluZyBvciByZW5hbWluZyBzdWJ2b2x1bWVzIOKApiBBIGxv
dCBvZiBleGFtcGxlcyBoYXZlIGEgc3Vidm9sdW1lIEAgd2hpY2ggSSBkb27igJl0IGhhdmUuDQoN
CkNhbiB5b3UgaGVscCBtZSBwbGVhc2UgPw0KDQpCZXJuZA0KDQpCZXJuZCBMZW50ZXMNCg0KLS0N
CkJlcm5kIExlbnRlcw0KU3lzdGVtIEFkbWluaXN0cmF0b3INCk1DRA0KSGVsbWhvbHR6emVudHJ1
bSBNw7xuY2hlbg0KKzQ5IDg5IDMxODcgMTI0MQ0KbWFpbHRvOmJlcm5kLmxlbnRlc0BoZWxtaG9s
dHotbXVuaWNoLmRlDQpodHRwczovL3d3dy5oZWxtaG9sdHotbXVuaWNoLmRlL2VuL21jZA0KDQoN
CkhlbG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRy
dW0gZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRz
dHJhw59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmlj
aC5kZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlh
cyBUc2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29tbS4pIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHpl
bmRlOiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3Rl
cmdlcmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEy
OTUyMTY3MQ0K
