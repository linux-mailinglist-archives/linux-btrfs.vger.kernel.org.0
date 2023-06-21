Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E5738424
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFUMzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 08:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFUMzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 08:55:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38302198E
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 05:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj8zTsExFSeSmzoHluiSkczddRyE34G4g5FjgqDxkqXUG/ABUegE7V5X4woTt5o6lNfbdUA3uSREBGZI30e81sPorE1CKFi+XZKcgof/bLi9gdYh9wrDUp7VEFLOcyhl0nsFiYdU+988W4Gfo8agdGP+tcNbVzAv5Y/SM8+bfj/za43AsZag0MlY/fpBySkGY9JU9moonYD6c2fpTWEW+TUflL3hnSI0/IGN0NnqYBdLwOQxBn5L7RHf+Ho8E+UfUDbsYdATNOdsB1IQb1rWTpM8BlEnSypklGxEzJkUUKqEycYRXz69+MEQKylO7HaMXtIR/mMisRp1jN6nfEyLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqEMEu9MVle+0GhcIfLUJfhJZboG31FDiToP4qPeN40=;
 b=BVF3nUqr8XgnVDJHj/bU+TS1fWvFt8K19oDsWMZJu6oReFVQ13xbwlZAR/CmL4MYXlvoNDWYSA6kGcQOGYkSziI3Fmjv5s4gJGLP8tafsGrjSNMWggoTSebGfnD7RFZWkvNgFCWHaXIH/6nEQdeRP8Dkd/pt6QO1fG4/y+3mR4kfnrZndk4ZL9wHPPLCTc4k3H5OYEOqOl4xposmhPAYisRN/4igiEvCQrqqdCjEuD2Eo6qGIONyRr3CNiPd5gY1K6rMZ6Hk+cfo+UzpbrQyV7hHAhxmsTBV/EZsFHK+bODr8eB26otzB1PkOArupuQuo6I4WhJKaWJgjH/Hs3UXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqEMEu9MVle+0GhcIfLUJfhJZboG31FDiToP4qPeN40=;
 b=bsVEOg2JmhoNVK9Bg2Jx900TP2b7LgDghSIwx1WBkI7iy88GpFWbbvIhd0Dr9KcdoP4lROy6S5tIncmGgrQU94f/1vvgHVdUIJPdVO8rmnKneTmZp6SDBtH5hPR4AqFX8i0sd7vyCW62zPIgrrU/CVvEFePe7vsgjEIEEUEKALg=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:55:37 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 12:55:36 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: filesystem inconsistent ?
Thread-Topic: filesystem inconsistent ?
Thread-Index: AdmjuJhXVuNvs5PMTNaKuyG/PlYyowARdJKAAAgDj4AABZMeAAACrZyA
Date:   Wed, 21 Jun 2023 12:55:36 +0000
Message-ID: <PR3PR04MB734051BB06FCA6D3FAF6667ED65DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73408AC6484D506DCFEE4D6DD65CA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <f8a9ea7b-076d-fe63-7a9f-4441663f765e@gmail.com>
 <PR3PR04MB73401431EB21CCCC1A6A959CD65DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <0204a3a0-0d8e-0545-3eaa-e9324ab6cec7@gmail.com>
In-Reply-To: <0204a3a0-0d8e-0545-3eaa-e9324ab6cec7@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DB9PR04MB9628:EE_
x-ms-office365-filtering-correlation-id: 93506325-d636-4b28-5f18-08db7256cee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQC9NI9roajUc75YudPTwhQm5q03s607iVrGe7s1NWhOzx7WZa8BGqTo1eNLIqzRwinDNUaPjHgDAT4/V1QZzDsUGdImpZJFModJPYSf+X6f9punu8AmKer230PfbMVkl4CgqDSvHf0pqWOvkUWHtcK+9u1zp/7r4YBIpL8+kWKa7HZ589NHdpCxZFSbATc78BcNHi6CoQaLEnfYYVlsjGER7gE5ZGvmELP5/qSA9gyDc0tkwTtqCCm3I1Y+uf4Bi4+VotnjndtAT3JjXKEKbCNa3aWeiw4kuwMRzBl67AqmY3sQ8fW9TF0A/j+vTFFRsd3AE3TBqz6RszEO5pIo+DtY0/YO7GY8WwX0X7NelXLkOwJIVwTVZtJ80el7/3SgwtcXjv7igDl8O1mEdZK4uWLTnvpi97CbIxEImeG5OJBcOjR1aar0ETOBPL68fyiqwqELHtYC+m5gQ1zZPgjgXOUBu/5jKM61+ZXkuLwecQehWgnPHljdYxPw+F2ifcZ9PNxeLkHIysE6b0ABVarIhw8FvqNFMdV/A2LagbnGYiWMV+mNb1uxQB93vMueIH5Yrajo2OUb5xZUlPeWudl50yAilAt9rqI+g1BQNLPF3RCpXETmqGeqUlBmVf4D59tA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39850400004)(136003)(346002)(451199021)(33656002)(55016003)(71200400001)(478600001)(966005)(7696005)(316002)(110136005)(38100700002)(64756008)(66446008)(66476007)(66556008)(41300700001)(66946007)(76116006)(122000001)(3480700007)(6506007)(26005)(9686003)(186003)(4744005)(2906002)(8936002)(5660300002)(52536014)(7116003)(8676002)(86362001)(38070700005)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFYrby80UEFRTW5nV2ZUSkdxNXpBUVlmTzBXQnRhekNZRHgxYURQR2JzM2tr?=
 =?utf-8?B?b0h5bWZSTVl1QWsrR0tjOTRkMGx2Z1hpT0IzTUlLdjRad2hLZ0ZLMEdjLzgr?=
 =?utf-8?B?T0hHRjZpN0oycWZJQWdieUIvcUJVajFaa0p1eVliZFl1L2o0T0wzL0srcWF0?=
 =?utf-8?B?L2NqQytKclIxdWJ6T2hhSWRGYm9qYm5Gdk8xR2lTWit6bS9UdXdrdU5Ia0gx?=
 =?utf-8?B?K1BjUHZldTRIdDRZOEVDYitqbDZCTy9jVFViL21tTXRzMkxGeDBidDZFV0JI?=
 =?utf-8?B?NUtqdGpnT21MalBiYWJDOUkrNWxINEl1ZWVkdUJOY25mczZZSXRkLzg5enE3?=
 =?utf-8?B?SU90dDdsMEVhWG95VTF2NFZneHpySDYvTE9vL1FRLzRac2xzZzNRR3hBY3Fl?=
 =?utf-8?B?VU1rVHo0SGM0RjhNRlBzU3BpZXYvMXNhTEdQalhlK2xUa3ZoRzQ4QjNnRGlK?=
 =?utf-8?B?VEVWWWdZQkhaRmlYbWtXSXY4cHBDSTN2V3RHY1MyU0pHN2ZoZTU1UTB6Y2lz?=
 =?utf-8?B?S2dOYStGZGV5ejBwYjFOWW5iS0pvNURqTkdydDAza0hvVTlMblhTc2s1Qk9u?=
 =?utf-8?B?bXFLMFoycHc5QnM5TUQ1VndCTHIzZVdybDR5NjZBa0NLZFYrK0JBbUkxamlB?=
 =?utf-8?B?NlQ2aHNxMFB4MTFTT3J4Zk5vT09tN20xaWRLZmF4cEZ1bFlOUS9GSFFIb1B5?=
 =?utf-8?B?ZzVnbU5vWmE5ZHlkWVhtcUtYSmM1UitVVEg2WmdOU1I4K2lVVjhjcEpScm9Q?=
 =?utf-8?B?ZjdPSXFXRjdlQk9NWmRaUmNVWDFkRlhZcFQ5UGsrMDNDUHVQei9EL1FBNjZV?=
 =?utf-8?B?S0U3UDBMR3Q1aDlzcUZjYjM4MGpQaUFMNUNNd0Rsa0F1N2lXTDNrdWJNWFNO?=
 =?utf-8?B?b0l2MTBqSld5RHJpNVNFTytobDNJcUMxVnpJaGpmSzdSZTluNjN0OXFzQ09w?=
 =?utf-8?B?MW9OUzZSamtkaTFEaHU1VWNJb1J4cG9QWnNYZXNiMkp1RXlhNml3LzhGa2V2?=
 =?utf-8?B?L3NEQUxTSFNYMWV2YzNyaTJ3WjkyeTdIVnJheGZaSUNhRkN3bUJOZ0UxOTN1?=
 =?utf-8?B?ZzdWUlRGMXZGdUhCcExoYnpZeWNVcTdjU2s4UnJmTGw0QWRhVzdKdGhnSVR2?=
 =?utf-8?B?RjY2YllmZGZ2WjBvTHZaWDYrT2tLd3UzNGpuT2VwZnlPZ0I3ZmtmNnNlalpK?=
 =?utf-8?B?Wkh6YU9GemwvdXYyVTlZY0Q3L3Exbk5BRW9PZ3lUdEZSVlp5Y3VQUlNaSE4z?=
 =?utf-8?B?UXBmWFV5dysxb1Jod3RYZ3FVZjRUNDRGcXZpYzd6YjczRUxpRVJ5RWcyNXBu?=
 =?utf-8?B?ek4zUTVEVXBsSG1mU2ZVYlkveFFKQmZneWE0ZTRKQWZCMXI1cnlKcGdyODk2?=
 =?utf-8?B?UDNoQmhvUCt0VllMckxkbm5rWmgvVWhTYXFEMjVSTmVPRHBPdWI4RG90S2kr?=
 =?utf-8?B?Mlovd2tZbEtIVFNBT05aWVdwd2d6YnRDWWU3aUwzTmVDeHFNOTl4ZmRqbW1G?=
 =?utf-8?B?ZkgrYTBwaVIxeitlRTNRKy9UeHhTcldCUlI2K3JrYkI5R1I2aDVRblhrK1Yz?=
 =?utf-8?B?VklJM0JuemRLNlpJb1RIM0lBVkJwcForSThRNk0vaXU5Z1RJdDdrb09WRjdr?=
 =?utf-8?B?VXdCMTFUMytweHMzaXFnNndTSDVmN1R6NURsSGs0U1piNTVYaGhNMWs4RldE?=
 =?utf-8?B?eXBCeHc1c2lmbVU0NjlmK3UwRDVMNUMxcXdqMnVlQ3NSSzFUSHBJbm12TGxI?=
 =?utf-8?B?N0txNnNRZVlTTzUveEFYeFF5dDFEQ04yTVphdXloSHNxS1JlM0syelA5VFhZ?=
 =?utf-8?B?TVFQQW5SdjcxVktYZjVPMFZwck1OMmNSaU5weVpHN3M3MTR2Y2p5UVRzcDRB?=
 =?utf-8?B?R0xaV1dtNTFBM3oxMXFGNDhkOHRiSGhwRVVNQjBiRWNsNXI1T2RqeHNXSU9s?=
 =?utf-8?B?Y0hvL0RuWVdtS0FvMmtyWXQ2SllmRmlXSFN0YmdrUXlYSlJwZ1ZNVFU5SDFo?=
 =?utf-8?B?Z3c5VkxIUisrM0hXWVF3cloxT3pQcGtmNFlIVm5mMi9nclR3L1c1Z0l2dGNJ?=
 =?utf-8?B?T3BGYU94TjNWRS8xVDZhM1lDR0lFWnZsZXB4MXdIQkhVSkFpaC9kRXh4MkZF?=
 =?utf-8?B?TFkvRkFrallGR3VDS1lvK2xwNDRMREkvZW5jVWdhT2RyNGZoR3NkaHdTajN2?=
 =?utf-8?Q?PXZfu9T9weZrPKe8vZWNhPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93506325-d636-4b28-5f18-08db7256cee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 12:55:36.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlJdbYU5kjQ4uNvwWopeC9zdL/kwfD4L+HyW6d51eEknKa+try7BOZsH9aIyJ6q93o+Br5Mc1PfkOwwu+gwtnLen+uWuYGPKl71TbS2XUhlfK3lFqTiJtDSx7LfwXJc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9628
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pj4gSGkgQW5kcmVpLA0KPj4NCj4+IHRoYW5rcyBmb3IgeW91ciBhbnN3ZXIuIFRoZSBCVFJGUyBp
cyBvbiBhIEhhcmR3YXJlIFJBSUQgNS4NCj4+IEJ1dCB3aGF0IGNvdWxkIGJlIHRoZSByZWFzb24g
Zm9yIHRoZSBpbmNvbnNpc3RlbnNlID8NCj4NCj5JdCBsb29rcyBtb3JlIGxpa2Ugc29mdHdhcmUg
YnVnLCBidXQgaXQgaXMgYmV0dGVyIHNvbWUgYnRyZnMgZGV2ZWxvcGVyIGNoaW1lcyBpbi4NCj4N
Cj4+ICBGcm9tIHdoZXJlIGRvIGkga25vdyB3aGljaCBmaWxlcyBhcmUgYWZmZWN0ZWQgPw0KPj4N
Cj4NCj5Zb3UgY291bGQgdHJ5DQo+DQo+YnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBpbm9kZS1yZXNv
bHZlDQo+DQoNCkRvZXMgaXQgbWFrZSBzZW5zZSB0byBtYWtlIGEgMToxIGltYWdlIGFuZCB0cnkg
dG8gcmVwYWlyIHRoZSBpbWFnZSBiZWZvcmUgdHJ5aW5nIHdpdGggdGhlIG9yaWdpbmFsIFZvbHVt
ZT8NCg0KQmVybmQNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBG
b3JzY2h1bmdzemVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29s
c3TDpGR0ZXIgTGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5o
ZWxtaG9sdHotbXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERy
LiBoLmMuIE1hdHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNo
dHNyYXRzdm9yc2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVz
c2xpbmcNClJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBV
U3QtSWROci4gREUgMTI5NTIxNjcxDQo=
