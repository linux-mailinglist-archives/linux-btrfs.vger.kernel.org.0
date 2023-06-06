Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE71724D22
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 21:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbjFFTer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 15:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjFFTeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 15:34:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618E10FF
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 12:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Amey4EGQ/xYajf770XSd6KCI1STPDFCxnaUr6BeRkWfY8ej06rZTW37iCwrBgkkYrYzH6M8LA9t/W6AYYOLytjnkkMxVniVUxkz4pqocjA7W3TslUbTjJb9oWvVRWusdGq6JixnKe/DHLndjwXPQc35V9BlN/zdL+oO5dpE6TZxfFkMg0qcwua9U4dFsEvo7ssiK5+nBdpSCaAmxX8olSj5Z7q+VADa/5iFZupT5mwNpEI6R1WoELnfN7KN88MT95WcpyB1UkOw9gmVI6IRw9+djYK/78fTk8RKyjijDw8DSA7ph//vTZlNXvNUWb7lS87ieQKL52p81Jl8wJ6v4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6xdOYBgvTSV8pC2XcqOmhhfisXZGmFiGmv1z3XIBlw=;
 b=PCVRNI0wxhLQ1G4eY20VOXkcMAi+nU0Fh4gfBJuCTyAB1R2rgQMOf5Gn+m3wwpSWKFtzkUVOm0ldA9/Xs5tsKh6JxUZ1TLa2oX+yOd18q4BSwp7Nc7uivtGqxlk2BatPD2wo895YbIUyU1Ox0Wkj/27Enq3jW7SqA/4xXrCcKHmei0Bp9BDqCe22hnmnS0tMa310kxIulpStFzdC2GwRVG9QWQKzR28TLUWkeQUB/cCWBdnrZqg68gHUA+/eY+oiw4yH8IWgYvDdB9l7+YwG33cUZMLog7Hngcj9sBsNWi9nnyDqv2yeAUr4pnlUDqWey9HDMrTaVF7HgsvcWDwTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6xdOYBgvTSV8pC2XcqOmhhfisXZGmFiGmv1z3XIBlw=;
 b=lC+2AIv9kdwLhBTrDooeMzfdEMBjp93dUK9KkqzqM4AIk6vAr0YJL7AUlwLJIi8eJeBZBd35UlXNv61r10b7EfHKqMOF9G3VojLBJC57eSSuXHJDKxYnkbtfgfds1asbAVca/RdNIHjxJv87DgrOvir+lMtA6R579a7AyY3rR8U=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AM9PR04MB7571.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:34:41 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:34:36 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: can i delete a snapshot with rm -rf ?
Thread-Topic: can i delete a snapshot with rm -rf ?
Thread-Index: AdmYrZYLmqsHmL+bTAWq0GutNwWLqQ==
Date:   Tue, 6 Jun 2023 19:34:36 +0000
Message-ID: <PR3PR04MB73408FC92E78BEFF8E85C395D652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AM9PR04MB7571:EE_
x-ms-office365-filtering-correlation-id: 876df6ce-b874-4bae-9f34-08db66c50fb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syzLAtm11lLJuRZxy5hRjkc10vuW2aw1zvieIR2Ip0Tyo2erhCwcSQag6OqZRwihr+457cFc9Vf1KTs7r0K5mNPpVfUX9a7NltUwXTJXGQDaA5QwONk3VhZ2tykAb3LLHe4pnt1Yg3G+GZIdbXxp2HPSBvcAzpqv2O7VZCdHcFWii/W9tylk6zgF6Tew4DW4olrqqwRMC7BTZp9ZRhy8KftLID3LjbtkGb9FaYNFx4C4HP1qB97D8dw/kRWAM1JbLg6HwpFeZiOmjn3D49UNoCGpuyyaEKYqG6ZE/FhvjfblnNrPla3N0GISDumxlgvwdAQn6I+RX2/e1wgbH8v6VKkrpEv7McVY+8TCUOmFg0XBOA9j0c9x8UNJ0H+PwXLGy4+lRsiGu+kuLjI/kwvR0WBstbSTzYn5dwL+M+CnniHj6gEXXf5hAJJXU1l908Fv1ASdbUdKVbRoVLLkPjNX7p8xhfTVI4mWudXKxEs0oiSDNemqb77cGI/cpgSx5PwCa3MlLmEdyCoH66sd6VIzaGdT/TlhjCKyPwPtX6imfrqS5OFYJo4RNZDJ3TLzCBpuKYCIF/vAIByTAVtqyWKNzGcqkbldPg00C0zK4GQsM3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(451199021)(76116006)(66556008)(66446008)(66476007)(64756008)(6916009)(66946007)(8936002)(8676002)(55016003)(316002)(41300700001)(4744005)(2906002)(478600001)(52536014)(5660300002)(44832011)(7696005)(71200400001)(966005)(6506007)(9686003)(26005)(186003)(83380400001)(66574015)(33656002)(38070700005)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c20rcnM5d0Q0OGFsYU50ajNnbnV0SGV3bTJsM0Z4YTVKQ1lKbWhSYldjU2pM?=
 =?utf-8?B?MWw3VVNxdUlCNDl5OXlRbkZLL0lGcUdyM0RRRHlVb0JaMXp3UzAySWsyMmlx?=
 =?utf-8?B?M3lOdy9ZdjhhUjZDM2RCK2Y3MXVZU21NZlF4ejF6bEw3Tzgrcjg3RndaY2VK?=
 =?utf-8?B?Mm1kTzRicEtHdG8rM3pWNFpyZ01KaDF3YkczUTFJNERpNWZCNGIyb2U3Zlp5?=
 =?utf-8?B?U2puVzZua1EwR2dXZ0JtNlJMTytZYnlwVUE3UktLQSthQUxoWE90dEVFY3Jt?=
 =?utf-8?B?OEovU3JnTTRTeEYzVjc0d1ZwTkcvaFcvblJSWFR1Vnd5QWZkM3lIRW9OcFlR?=
 =?utf-8?B?TU4yNFBJRG95NjloaVEwZXFNVHdzdnlaNUxBbHVnRThqOGFqT3dubkpCV2tF?=
 =?utf-8?B?Rk0yOVZoNzZ4dXB2YWhTcjlreDkyc1Z1dlV5R2JOLzVHWGs2VEFBMllmYjJm?=
 =?utf-8?B?OWRNb1BQa29VZGhKNk5Ic1pBL2c2V1puNDdmWGM2Wkg5dmdHWUdvQlRwNk1m?=
 =?utf-8?B?S0EzUDJVSG1EaXdqNDk3NEN1bklVckVHUHpuYk84akUrczdkREVUNDZTM0lh?=
 =?utf-8?B?UnpRZm8xdFlpWlhZRGMvVGxZQ05ZV3MzNlE2bExCdCtsdE9MT3M4U3JOSDY3?=
 =?utf-8?B?VzkrMkhPdEFGUFNKRkc0RVZFbjVUemtFNUd2cmh4NnFYbTZieTVuSUdaUXJh?=
 =?utf-8?B?WGJZWDVqZXZEdjBQdHgvUE9tcmlSdysxYTVmZHh0azRGMTdSUytvUXVmc2xX?=
 =?utf-8?B?TGVOZnBKS1BvY0FtTm1rWmhQZ214SHFsUk0wTHVNQUREaXo3VGtyRzhseTVG?=
 =?utf-8?B?SHg1M2dBU1hpaDc2amo4YXd3R29NODI2KzBZN3VwbEdOd3dwY3hnbGtRWUda?=
 =?utf-8?B?ZlBUK3Q1cnVhcWNOY3dwQ1JWQjcrUGxtQTJlNHpxY0orc3NEWEc0TVpyMldy?=
 =?utf-8?B?UWRvb3V5R0Rha0tQdmlqT2pHV3NZamZhNW1PT1FZM0pncW5ycXNjZlhmZXB4?=
 =?utf-8?B?eUNvNU9OTzgyZjVWR2FGbEdhRUR2bWtiQS9GakRBUHZweEZiVXFnVWlZOVht?=
 =?utf-8?B?Wjd4MHJ5TkxLbi9UV3h1MDBRQTRZMHMvU3RuWFdleEJud0ZhTVlEQmwwa3Nr?=
 =?utf-8?B?NmNVRi9mcExYTmYwNTE5ZEZLRHJPMC82WXpTYm9hdnVmMHNWZlRtSU5qR1B1?=
 =?utf-8?B?ek5mc1lEYlh1UDBwV2poeUI3TS9rS2xkN1psM3F6Ty80eHlkNXNvMVFGQlNj?=
 =?utf-8?B?TUEwSTY3Q3Y5SXZGVmFBcXNlazdUaUFqTnhpay9HUEZRdjJpazczOGZVVEJX?=
 =?utf-8?B?WFlaanhJZ0FvcUNDUlNnRzAvTnI0NEVVSzZoRnk4OWprZW1QeWhQMUd0cEZ0?=
 =?utf-8?B?M0hYaExRK0lFVDE4d250eXU1b2VLZUd4RDU2VEtmUk5tbFd4S1JMb255ZWJj?=
 =?utf-8?B?c2pOVzhqcklTRjhtYUVoZ3k2NXhSdFpvZWwzVkpLRDU2VWxEdUhlZGsvVGpz?=
 =?utf-8?B?ZnkvRGQ5QTI0OEVXRlpzZmNNNDhBOU5hanFUSkt3L0E0NzNNd2pyQ2ZFalln?=
 =?utf-8?B?NExSZlhZUGllRGJTakFwSFk2dEg1UUdxK3FPQVVDSXg5Y2wyd2ZhanRReXl0?=
 =?utf-8?B?TW14OThWRXFvRGVlbGlLcHdMcCs1THgzVGpKNmVTNnYvTGR0cFp6bUNkZGts?=
 =?utf-8?B?dlpvQzIyaXE2MnhiK2FHWFRkdlVaUWlUYUhHZTFHMHhaeUFydUZRZ2dtNVcr?=
 =?utf-8?B?cnlDQ3QxbjBFTkIrM1YrOGp6U2dkMXlOVm8yMjkyTGlNS08ydy9Mb2tSWXQz?=
 =?utf-8?B?T2k2YkVSUGdISnNTek5Ud2UzYmlwbnJDcDZrRGNFdVovN1lYdjF0NVlxTEJZ?=
 =?utf-8?B?TjF5aXNvSVRlUStZb3dTZW9FYmxNeUdtZkVudVRUOTJLazJucWF0bGh1Z2ov?=
 =?utf-8?B?alZDWVZ3aGZSOEZqN2VsQ2ZTMTA1VWVXeTdYMTZtZkd5TEJFRkpzRUwxR2dH?=
 =?utf-8?B?eEU4eEJYYkRYK2Yza2VuV3ZBSzh1RjlSaTMwVWorY1AvcnpnT0ljZ1hzZWdr?=
 =?utf-8?B?OXA5a0E1RUNLQmR0R29nbkF4bnJyVU1yN3U0bHFGVE9QTnd6WDNKd3Q5aVRH?=
 =?utf-8?B?ck45WEJTSi9URml1SE5kZWJJWlFNVWJtNWxFWXlicERxYTVyQ2hnMHRtSDFm?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876df6ce-b874-4bae-9f34-08db66c50fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 19:34:36.1088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kTsI+uU836VtorPPtATXBu5kQQAOJ2vWCdlACZoSgYLQXThx4+vRGsrTzLvPHtUhzGfbvoE0b/ujVEO1hFM3By1uZDq4KjIjF1va650vM7dnyYyCi+bB5d8IVW7gBAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7571
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQoNCmknbSBwcmV0dHkgc3VyZSBoYXZpbmcgcmVhZCB0aGF0IHRoaXMgaXMgcG9zc2libGUu
IEFuZCBpbiBzb21lIHNjcmlwdHMgaSBkbyBpdCB0aGlzIHdheS4NCkJ1dCBub3cgaSBmb3VuZCBv
biB0aGUgbmV0IHRvIG5vdCBkZWxldGUgYSBzbmFwc2hvdCB3aXRoIHJtLg0KDQpDYWIgeW91IGhl
bHAgbWUgdG8gY2xhcmlmeSB0aGF0ID8NCg0KVGhhbmtzLg0KDQpCZXJuZA0KDQoNCi0tDQpCZXJu
ZCBMZW50ZXMNClN5c3RlbSBBZG1pbmlzdHJhdG9yDQpJbnN0aXR1dGUgZm9yIE1ldGFib2xpc20g
YW5kIENlbGwgRGVhdGggKE1DRCkNCkJ1aWxkaW5nIDI1IC0gb2ZmaWNlIDEyMg0KSGVsbWhvbHR6
WmVudHJ1bSBNw7xuY2hlbg0KYmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5kZQ0KcGhv
bmU6ICs0OSA4OSAzMTg3IDEyNDENCiAgICAgICArNDkgODkgMzE4NyA0OTEyMw0KZmF4OiAgICs0
OSA4OSAzMTg3IDIyOTQNCmh0dHBzOi8vd3d3LmhlbG1ob2x0ei1tdW5pY2guZGUvZW4vbWNkDQoN
Cg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1bmdzemVu
dHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TDpGR0ZXIgTGFu
ZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxtaG9sdHotbXVu
aWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBoLmMuIE1hdHRo
aWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNyYXRzdm9yc2l0
emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xpbmcNClJlZ2lz
dGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWROci4gREUg
MTI5NTIxNjcxDQo=
