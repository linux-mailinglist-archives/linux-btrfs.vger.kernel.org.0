Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FB737E90
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjFUJAh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 05:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjFUI7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 04:59:45 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BA8DC
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 01:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivLK8qSie2D6XCtfRNJXRc+WLobZXcXm577ZqO6RY72firtK2te3iW5icis2R+32NzeynalX0AbXXdievLLe8IFwRHpVvoG73VPWdX7nNR/8nXl7Wk6tEjX0wqQBC1n+f813RuKhD1R9G6ncBXIHa2+Shlb2fhF3d1roc7kZPp8fH72lDxSm2SZ2o3Q+oQRYB5SdlrvkqOljVrecVLCRSA5NMu525NeYi2dLd9VS6tHNxNV30uiOI/Cyu5hMN1xfKoqUkN3EhQ+/I/BiyAUUkPBKva/sNi5aQwxIzx7Gz9/gD29+ovbncuV+UVkIiqMpizFVXEmJa5f/u3fkJkLa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/8fYTuxc5Y44Z78BQB4humuCAE2akilsMVFHFnVn90=;
 b=QUhQiH6YLhGK6WGfvX7tv/A03YjdflPSuywKDy1d1cfzMIfgch/bVT7xkIqB59LDgIZjitpSfvoLY9FfjcYkLSegDmqfys0FFnUudtfUzZFLrRNxhQKcksx+U+9Kcb7ptrQM56iVrv9Jhcy85YP8ktxmKkBmjj80GuorKkzsXGLPJdlgftdaox+sjKH006XXHFHMEwlJ6ACZL07/Mfnx+cydBYBVuNwfGjxBIBwoF2pPtaEKl/NcdQMBRhqfQ5WCafK5dGt6OoNuka9wG1w3sad3F5LJ1Gv81f7FGc7zXPSaw0/R3X79EKJm4GMWI3Q66Tiq81IbU7WB8MsDXXbrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/8fYTuxc5Y44Z78BQB4humuCAE2akilsMVFHFnVn90=;
 b=h7dxsVdv06yrQbcxInKOm2YWF4XPp2XHhxUE4gAxPLNNsa1ICaP3sxr9A54abBqlWLjM0FbTgVhAr3pgMiPzcZAs73QC/X04oi1ok2FQc+qchp1j6V1VYv4E+0j01fDinp/xgC0xh+RFZNWBM4BbqdQ2QvceYg9K2H9T7ZaIqTQ=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 08:59:39 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 08:59:39 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: filesystem inconsistent ?
Thread-Topic: filesystem inconsistent ?
Thread-Index: AdmjuJhXVuNvs5PMTNaKuyG/PlYyowARdJKAAAgDj4A=
Date:   Wed, 21 Jun 2023 08:59:39 +0000
Message-ID: <PR3PR04MB73401431EB21CCCC1A6A959CD65DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73408AC6484D506DCFEE4D6DD65CA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <f8a9ea7b-076d-fe63-7a9f-4441663f765e@gmail.com>
In-Reply-To: <f8a9ea7b-076d-fe63-7a9f-4441663f765e@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AS8PR04MB8021:EE_
x-ms-office365-filtering-correlation-id: 45a5f802-befd-4c5e-7669-08db7235d86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyUz81VeSNSgtbgt+xcl0AFmaa0T3u9fhgu0mXNipJ1SlLweAOWiUVYNhguzrpjXdDI8MppV1Qq6P1cgGKSZ+1vjC/IhTAXG5qdGApjeEm/OHLEiakDCoBSUuI73LL16Q9QSWYHcF4cLrEEB07A/oW7s5a2xkannXayJHEZVR2tQ0dYU3xbs53+J1calkD5ajx4naqIg3BVIIopL3zReWLM8g/NRr6CrbPOczAX7HHMwQRAurh4r763LqhYH8avHaU0LN1mzxOs5BXW2j+VMw73LoLw3TecVbSOWXNOJ/ErhRBZohXL3pSPBkHBGhshyyJQ6hr6+UTo2odXahZ4E6u0POqVjDyVm06BPzjDPKovyNDxLo4XwxKm7YtleFcyu3YXvJLS5MzMeTc3NpV0f56Ibs9QsynsUh2ktwdcNHd+lEv3RLkq/VteopTmXsq+sdBajMahtjLoPgic+u7MCHm8HPbZqkyV8jf5m1ZtBSeiaAnY9+4lKU2Sds5clc9Oi8OQ2h5ObvRC5Piwl6xhCYNzf3yWRr4OxHllZYtHuwn25jMD0aVDxqpRqiZINkSQ6WQQeTYDX3gzPFG0AhxYmHzUzp2xNci8ywzX5n1jLbJQc4M0x5/XXwNye1b0ex/pt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(136003)(396003)(346002)(376002)(451199021)(71200400001)(76116006)(110136005)(478600001)(6506007)(26005)(7696005)(186003)(9686003)(966005)(2906002)(8676002)(41300700001)(5660300002)(8936002)(316002)(66946007)(66476007)(64756008)(66556008)(66446008)(44832011)(52536014)(7116003)(38100700002)(122000001)(86362001)(33656002)(38070700005)(66574015)(83380400001)(3480700007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzZiVTY4S2JLMFl1R2prRmd1NjhLbUxIZGpqRllSQmFxSzV2b3BzaUFielJq?=
 =?utf-8?B?RmpCQjJsYnV6R2cxMHQwQ2hJTk44V2hzejVVVmpvSFF5ajlpbC9oa2xDYTA3?=
 =?utf-8?B?VisxbmNHZk1RWUdLWXJEOFp3YlhjeGJlVzYwZit6MklCdkFCMUhWUm5Tb0E2?=
 =?utf-8?B?aFJObGEvN0l4YmUyanN0anRscXFVV2ZqbzhCWkpDdUkydFNzZFY5bVdqdDZ2?=
 =?utf-8?B?c0w0UzdLZXFjMXN6Y0hpZFM4d2hkUGZmOTlReHIzWEdNS2xtaVM3MUFVeFRN?=
 =?utf-8?B?YjBUTzJJdGtBbFhkakxYZUdPdVN2MjBzVnV3RjE1a0dGK2JBTW1yUm8xQnVK?=
 =?utf-8?B?V0x2VE1UYVRhTEVkNGdwMlplVUp4a2ZtSDhCcG5NVGlIUHJ4RzVqWlI3Q3lY?=
 =?utf-8?B?bnlzVmhlcTgycE5XRm9VK042YUpuK2tUcjdERGFiVWNzUi9DVzVIWkl1bm5a?=
 =?utf-8?B?MnVlS3dhTUFQSVQ0U01TakJHK2ZCbHlubmpvZndCWFg0YWx2U2hmLzg0L1NG?=
 =?utf-8?B?MFZXOUhVRWxtazY3UE93TklwYys0NW1vT1ZMVytEV1R1VlZJdVVPTE41NEww?=
 =?utf-8?B?cXFjTlROVWlhVVNVbDIyZ1FWOWpiU0VlalRMaG9zVWVrOGtST0JoVWpycjNx?=
 =?utf-8?B?RzBvZ1ZaRHZhWkZtVFJKVmtLWkIwZ0dMc0JjN1c0bDRQZDhUbzJUZmJZbTZG?=
 =?utf-8?B?STdBVzZLcHZvWDlCSkY2dU4xeXhFV09kbXBBcURDa2Njbm5JNGFGMmJHTStv?=
 =?utf-8?B?YXcrV0ljZE0vd2Z1bTVyREJ0ZFFuSTdQcFJLMmg0RHNmcjJtZWI4VWVBSitG?=
 =?utf-8?B?ZDZzY2ovMmU2cjI4eEVWeGk3YUFtN1hJM2dJZTNWZGtIcG53REV2Q1dCMTVV?=
 =?utf-8?B?NnJwUFlmNDlLWGcvbklOR3RvbU91eVlCN0ZZdVk2ckdUM0xRWHp6NnF0TkJ1?=
 =?utf-8?B?bU56cmN0ZE9OMU9vVnc3M0NiWXlUYWlqR2VDY3dlUzdINy90SlNPQnR1ejZN?=
 =?utf-8?B?RGZRZ2xNbGtLcHdURzNRcVZEQVA1a1RIMTNsL1B3ODFDY1R0aGpIZFF0a0Jz?=
 =?utf-8?B?MjZYUEcvdXBqUFIwWmhPSDBhOHMxckRHMG41NzFMdFlGUHl4SjhYbERxQjBh?=
 =?utf-8?B?OEJFZmxpeTZQSjFOakcvNVNzQk4xZHlRY0lPbVF0T0FoZkliSXkyVjY3TWVu?=
 =?utf-8?B?S1VNVmxFVHg0T2MrS1luSlZTTlIycnF2SlZCYWlpSDVvTDBUZnpxd1FLbVZy?=
 =?utf-8?B?S2s2QVFFTEpMYTBDQ0FwdjJFUlJRUkdUWjBDNEd1VUZWd2N0bjZBdzYraVBr?=
 =?utf-8?B?Z0hBcXFwSVdlaElTblVTMEszejNwMU41bjE2TlMrc1kvdE0zckVpbXFxWFcw?=
 =?utf-8?B?RDlSaHI2RFFzZUlrVWN2QXNxdUpJczZOaHNxUnhuNVN5bHU0ZnBwdWhpeTdn?=
 =?utf-8?B?NFhHajVVUUpVWDMrTS84amtSMHBESUZkNEpnQVFsWVJEYkN0bkN2YVprY3hJ?=
 =?utf-8?B?WTFXdStCZmx6SDd5MnF1MmNmMTRvMnkwVTZUdURnb0d3RXBvNWh4Y0pGUU1M?=
 =?utf-8?B?V2syc0VSaWYrTHJkc3U5R1kxaFY1Tk1rNEgxUmVtaWFSWkt2bmhzN3lRYklK?=
 =?utf-8?B?N0taTFdYOEVHeGdndTRlL3dYZUxKWXJja2RXWVJtblFqUkp0dEI0Z1dvL3BK?=
 =?utf-8?B?ZUhpU2JCWjNncEY5SE9VcndZY1IwaXl2aUpxbkhJczBoVXU1Y0dVb1BzbExY?=
 =?utf-8?B?b0I1WlVXZjMwT2VzUnFFQ3F4aXU1UVJvbkRjRzJBVnRXMDdmTG5BU2dGTThO?=
 =?utf-8?B?ektBSUhJVzhjSEpUM2NBV282MnliWmp3dHIyQ281ZlFuSTRyVTR5ZThEVnoy?=
 =?utf-8?B?MzY3SEUrQ3NmcCtTdDgvOU9xNG10MHdHSWl6M0NqNHZyK1ZhM2R6YmJqRU5p?=
 =?utf-8?B?UkxhZDFMd0k2Z3NPd0dOck5oMzhhTVdTcUVGOUNPSSthdnVJWmZvVWlucjRa?=
 =?utf-8?B?UTBRRDltTVVuejIyY2kzeHlFOUl4U29ZWDdpUEVBMGpQNGNBNkhSY1Arbjky?=
 =?utf-8?B?OWgvNTd3U1NhcUIrQmFqMDFpNGl4QnZ5bXF0bEhkQnR4d0tid2xzazBWOWlx?=
 =?utf-8?B?Q3luWEM3N05WQnNBYXFjMnVBbjZOSXVDb2xyVG5HbDVvRlhxdWV6UzdNb25r?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5f802-befd-4c5e-7669-08db7235d86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:59:39.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6CNohEf9A5wX0Op8pS7TYYlVnUr3urO/quA07volt+Fv33H9SrUdmcxRth/vXb1J7gfRrsV2M7XqeGdrn2zNfwtbPuKJub/xTfHc4o23bnC/bqRadGJhudnjb+sQ2y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBBbmRyZWkgQm9yemVua292IDxh
cnZpZGphYXJAZ21haWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyMSwgMjAyMyA3OjA4
IEFNDQo+VG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5k
ZT47IGxpbnV4LWJ0cmZzIDxsaW51eC0NCj5idHJmc0B2Z2VyLmtlcm5lbC5vcmc+DQo+U3ViamVj
dDogUmU6IGZpbGVzeXN0ZW0gaW5jb25zaXN0ZW50ID8NCj4NCj5PbiAyMS4wNi4yMDIzIDAwOjQw
LCBCZXJuZCBMZW50ZXMgd3JvdGU6DQo+DQo+SXQgbWVhbnMgZXhhY3RseSB3aGF0IGl0IHNheXMg
LSB0aGF0IHNvbWUgZGF0YSBvbiBvbmUgb2YgZGlza3MgZmFpbGVkDQo+dmVyaWZpY2F0aW9uLiBZ
b3UgZGlkIG5vdCBwcm92aWRlIGFueSBpbmZvcm1hdGlvbiBhYm91dCB5b3VyIGZpbGVzeXN0ZW0u
DQo+SWYgaXQgaGFzIHJlZHVuZGFudCBwcm9maWxlIChsaWtlIFJBSUQxKSwgdGhlbiBidHJmcyBn
b3QgdGhlIGNvcnJlY3QgZGF0YSBmcm9tDQo+b3RoZXIgY29waWVzLiBPdGhlcndpc2UgeW91IGNh
biBvbmx5IGRlbGV0ZSBhZmZlY3RlZCBmaWxlcyB0byBmcmVlIGNvcnJ1cHRlZA0KPmFyZWFzLg0K
Pg0KPj4gV2hhdCBjYW4gaSBkbyA/DQo+Pg0KPg0KPlN0YXJ0aW5nIHNjcnViIGZvciB0aGlzIGRl
dmljZSBjZXJ0YWlubHkgbWFrZXMgc2Vuc2UuDQoNCkhpIEFuZHJlaSwNCg0KdGhhbmtzIGZvciB5
b3VyIGFuc3dlci4gVGhlIEJUUkZTIGlzIG9uIGEgSGFyZHdhcmUgUkFJRCA1Lg0KQnV0IHdoYXQg
Y291bGQgYmUgdGhlIHJlYXNvbiBmb3IgdGhlIGluY29uc2lzdGVuc2UgPw0KRnJvbSB3aGVyZSBk
byBpIGtub3cgd2hpY2ggZmlsZXMgYXJlIGFmZmVjdGVkID8NCg0KQmVybmQNCg0KSGVsbWhvbHR6
IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1bmdzemVudHJ1bSBmw7xyIEdl
c3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TDpGR0ZXIgTGFuZHN0cmHDn2UgMSwg
RC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxtaG9sdHotbXVuaWNoLmRlDQpHZXNj
aMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBoLmMuIE1hdHRoaWFzIFRzY2jDtnAs
IERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNyYXRzdm9yc2l0emVuZGU6IE1pbkRp
cuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xpbmcNClJlZ2lzdGVyZ2VyaWNodDog
QW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWROci4gREUgMTI5NTIxNjcxDQo=
