Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD6725BCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjFGKqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbjFGKqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:46:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE71BE2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4z2nXvwpbRaVEhSwVx1kvA/Ii98/uwwGc8TJukVbgqGbs/9SD15lPjqU37ns6feciMkbBIG2IILMlPCAmu4CHUhLpcxMiZOKjZYeyFIEqOLGZIhelF0NChrzf5/Y+cHuFv/co3PUZ5WBmPgfaebxJWsA4J7kV2hTo1VEkk+ZcSH6jm+kJYOviXPjbfRusSS0TIdycgOGhhyiR7oqUI2y26Q9YkLwo7zwsfMFFD86eR/xsLsEjglce/Ls+fjJHYHrXTRXsZ3ONKSwCCvJmxtlLyRH0eWtD02lhwuZzKxeuFI5wViycaXk+PFSW+/FvRLGjjnBXPLeIE77LCbDNu0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr6jRKKf5tmwFKjx+GajlKTJMKOgPeriWBf1fTf/hlU=;
 b=GFLIPsY9BavF+C/cPNt4hgWMHistkjDhDm+xkQae0x2f75szn7PrczKw/9ER1olt+pqwgvsP2/ms/0MpF15NL19ANCCJULzWNWLHr5xpAfd0ttVj3jQyUzZW97FKtypo2kQR2+KL0Do/cgsnoXpmR2KoMNd5+opLgolJG+QgbGDm5KFzNoKtF+ofLhdphVTDXX958KG8KNZc2/GPDTLGL2KZB/+ZWAWJJ2KTeovUSihSrpwaiPmjFdvg18On/LqcJoqmV/Y91zfaJIPHiOS7/x/xtF1yV8xWKmWl/PCBZGdPGDQePS9JueJNjBF2YaQniM3SBSGwNJ45omMGcWiecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr6jRKKf5tmwFKjx+GajlKTJMKOgPeriWBf1fTf/hlU=;
 b=k7gwyCPYpCPuVbFdH3b/a2GL/XEgFjMDlGir1LHWeEmZ+qWoJz1XLx/2JYL7N59FR1tlvHQcHhDWhzzobzO8sQcULLXyvwb0X427gncHL9se2Uu6ms1hSpjhtRcTSIwCJ4qrZ2vXcEWOSjTSJS5TYv022iKMlyn8f9eTkHFX0O8=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 10:45:59 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:45:59 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAzLYRA=
Date:   Wed, 7 Jun 2023 10:45:59 +0000
Message-ID: <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
In-Reply-To: <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|GV1PR04MB9149:EE_
x-ms-office365-filtering-correlation-id: 2e9314db-5700-429b-6f36-08db6744616b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLSIocoMxum8O+T07EUsRGjpa0PIHEBl6HwVbDnIDbt/381mljL7/rAKh/PcC4mMEF4If5NjMWEuxFh5FaZp6kbplRjdnGzgHQRA3V/vIH6LWo0rNrfyPeQQLEA8MPZNdKb0ND3i+ryG7lp9MWUsA4TX61bSZAtw8TgPfYkyeEjI49OfZ/RgST1dJUN8QCVvEaMFZU1wMh9+nL7JuhrnRmv5JB7puIuPjJRUzhKhl/cE1naXG/SEU2OLi0QSmfJmc/gCzKeTVY1D0IAC4CTOeSYqj4ugyQu/H8FJK+FyoDqR++k0lPjPz5KjvQKsQqIuv7e4Jp/ojZa5lKRK/CEMLigCn3GSM/6rbNlxFnTM87AQAQ8ipahFyn7DD0ME0pdgPDnrcZOOG6CcV6NzdBfT0tyoy3YtE+fFkGunoKaINSjxAwM+z2DU/iJjsaqTDZ3IYEbAwpGHgY9xrwox3Ckv/PyRnqCOSBTOpLbSQBy66Fzpjms3a/FXdrVo2kZOoZ60D4PqValCtlKifSZH6LyQiTtDS/eQgYvZ5zm3CZinNJIsD9AAjecuJH8urOfVsAMeU3mQT/QcgbEYVudcQ9dqab6s7GB/xc1RPzShdnlQdNL7KUkKD5jUdmfWe2s6uo/T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(451199021)(66574015)(83380400001)(966005)(44832011)(110136005)(33656002)(55016003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(66946007)(76116006)(64756008)(66446008)(52536014)(66476007)(66556008)(122000001)(5660300002)(38100700002)(86362001)(7696005)(71200400001)(3480700007)(2906002)(186003)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU5zdU5oV3MrSXFXRGZIblZHYzNtVE1BZzg2NWR4SWdIblNxQWpBYVpzeDRC?=
 =?utf-8?B?RXduRk04S2h4Z1FGYzZCbjdDdjJUWlJFYllSV3p3VHo1RDFiY1JiK3lTSDZa?=
 =?utf-8?B?WE5wNUJGTDQ4cDBWb2hvKzZnQnMxVkZibXc4Ly84VWI2a3lQQW5SdHMyVmxu?=
 =?utf-8?B?K0VSVUNBcFBxeDc1M3NIUkJYWHV5ZmJSWGlnZ2M0VndNNXV6alFaWkFiMzJD?=
 =?utf-8?B?Wk82NHo4RlppQXRpYnliT1Z0aDVJZHRVVkZDVGpHNnp5MVJ1dStDVCtGOTc4?=
 =?utf-8?B?ZUkzSy92T0xvSDg1QnZhbVBYU3NzVEVhRmNnZ1MvYTMzb1VZamhXaVNJbWUv?=
 =?utf-8?B?SE1rdFI0MUE5TmZTVVJlN3hMd0ViY0wxSWp3TGFadDBhYWRmY2Y5YWMvVHgy?=
 =?utf-8?B?N2U5ZUIwZXVCTWYzd0c0bXhDckh5R3gyaGx2c1RoZC9pNUdCRDhlRXVvMXF1?=
 =?utf-8?B?bmJsN0s2N0dMSHM3US92Slhla214Qk5mWmZJQmpjZWlJQm0yNGpHNlVrdlp0?=
 =?utf-8?B?Y3JaY25JSm92M05GQ0dhSWhjWi9McHgxWGZZaGhxQXl3OFZkODRHaW8yZ003?=
 =?utf-8?B?SWxBYm9DeksyRHZPWWs0S1VMOU9ZZG1QT1VyZE9xRVJPSFZpR0pyOUgwalVw?=
 =?utf-8?B?emVWNGwvTmoxYUZITHB0cnd5WUJXNHFMdTd5TUVHS0pidUZvRG5RcytpaVMx?=
 =?utf-8?B?bDVGZVBEaFBpcGJKTkVDSVh6K1RZWmQrLy91OXg3dkd6MlVXMGIyUnBwVmts?=
 =?utf-8?B?ZExhbCt0dUpTUVBlM01KQk8xQkI4aW9DOXFJRVVQaGxVVHNJQm5IMnVwS1pp?=
 =?utf-8?B?OGpScUFUYmpZSnViSjBtZEw1bGZkY0RsNSt6UkRQS2htd3FaSzl0dU1IKzRz?=
 =?utf-8?B?UjdVQ1Fldms1VTFnUXRjUTF0OXpzK0pKOVBLRGtFZEMzengzVmV5L0VXZExC?=
 =?utf-8?B?V0luMEdjekJBYzVaWVB0MFlKYjBLMzFDZWVFQXdoWWlPYnpSYWlKWS90V0xt?=
 =?utf-8?B?UHdZYzE5ZnBaYm4vTmllREhkcVZLbndwVGxQVXkwWFVzNFZPNVVuK1lNWk52?=
 =?utf-8?B?aS9rckZSL2tSeUVYZDMrYkMwWGZQRlQ0bTl3cXdTVi9hSkR5TmZ2cWVDcEtU?=
 =?utf-8?B?YkNRMnlTdXNRd3dBMEtqdEpGcXhmOTR6SmtCaWVwK3JudjhaQjFUenhEb3Qw?=
 =?utf-8?B?aEFXQlBxdWNySjdKZS9CbkkreW9NRkVlM01DRFFYUEh2T1AvRzJpeXhUeFZm?=
 =?utf-8?B?WUFtTHRkYnRZNWhObzBuTjk5eHZiODNyRWpLR01EY25TUUZsdUNPeWQ5M09G?=
 =?utf-8?B?aktlUi9PcENBYzcvZFl5bTkxRVdLcVJCVkVRM0ZrbjBRdVdBQVNkWEJ4ZHVG?=
 =?utf-8?B?ZERFd1VpTGNQU0M3VCtoVndpN1V3VVNYVEh6d1k2eGNqWDRrWXRkdHNkUk9X?=
 =?utf-8?B?S2ptUXA5ZmFXRnVGZ3JhSHN1WXdtS3FaUURwcWZnZThKZHZlSHlKTkdwakpl?=
 =?utf-8?B?R0o2dGFVY2NaVnM3ZlRaWW54SzgvTXZiVUpZR1paV2Yxa0JmTVhabVBFSDlQ?=
 =?utf-8?B?VHJaU0dGM0tHN1BzVUlPZG5scTZnckx2ZncwOVRYR2lsNXVpS3JGV1gzZVc4?=
 =?utf-8?B?dzRaVGM4Z2cwd3N1MDE0Y0tUVmFSblQzM1FobGJXS0I5M2hTb1RyVXorcS9V?=
 =?utf-8?B?UXVudXExTmNBVXB5b2haTjA0ZldhV3FjVkpoRVlyOUFudDM1QkNSTjlaTTlR?=
 =?utf-8?B?WW9BdTA3dWp3dWdTVFY3Ny9XMlZNWDQxbVhiSzZYWmhaMWlaNHdsVjVGOXNi?=
 =?utf-8?B?M1RXY0RiT2c1aW50UDB5L0p6VjhoSjlVUjRCNWJwLzZ5ci82Nmo5QWlSYUxQ?=
 =?utf-8?B?RWRkUE5VeHlyU0pQZ01ySnBmYVdreGlkWFBxb1ZyUlUxR0JKZThIOWY3WEV1?=
 =?utf-8?B?MzEvaXlYbDJrYU5MNUxTMkxsclFUM0lJaC9FSjRrNWpCMmdrbWx4L1M0UURS?=
 =?utf-8?B?anVSbU5KN2pzbTBuVmZNbW9JRGlxMkNyN29OcGFDZ25VRW1EQkRmd2tHL3JS?=
 =?utf-8?B?R3pKK3dSMVk3ZXNyempRcnBucDYwWXBiVUdqb05aRENsNmN0SURYbFljaWJY?=
 =?utf-8?B?MCtFUCtIMVJjYXVqakd0OWZ2cnlTWEtzK1NBOUVsUTdKTVlIWHZaUGxxQ0F4?=
 =?utf-8?B?d0FqYjNUQTJsVUhhenRPd1IxOEhUam5KWGN1V2FzTDJ5bGhWUzhGODh3bk1S?=
 =?utf-8?Q?7pl64PLnFlAkSnVFG951cx0rDK5TDzJ63IfKqPv6Z8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9314db-5700-429b-6f36-08db6744616b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 10:45:59.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU04RjfUo4Ypd79h1CvRN6EykAq8ggHUKSjF8wEO/PzamRc+qbVKYzbkrXj1AJEUhJxfT+2csjRbVIcXaELTU+h9PbjM43JsikIO3X5zvXXmiXVAddeaMkrkEMgRJONP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RGVhciBBbmRyZWksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFuZHJl
aSBCb3J6ZW5rb3YgPGFydmlkamFhckBnbWFpbC5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBKdW5l
IDcsIDIwMjMgNjozNyBBTQ0KPlRvOiBCZXJuZCBMZW50ZXMgPGJlcm5kLmxlbnRlc0BoZWxtaG9s
dHotbXVlbmNoZW4uZGU+OyBsaW51eC0NCj5idHJmc0B2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0
OiBSZTogcm9sbGJhY2sgdG8gYSBzbmFwc2hvdA0KPg0KPg0KPllvdSBjYW5ub3QgcmVuYW1lIG9y
IG1vdmUgYmVjYXVzZSB5b3UgY2Fubm90ICJyZW5hbWUiIG9yICJtb3ZlIg0KPnN1YnZvbHVtZSB0
byBiZWNvbWUgZmlsZXN5c3RlbSB0b3AgbGV2ZWwuIFdoaWNoIGlzIG9uZSByZWFzb24gd2h5IHlv
dQ0KPnNob3VsZCBuZXZlciB1c2UgYnRyZnMgdG9wIGxldmVsIHN1YnZvbHVtZSBpZiB5b3UgcGxh
biB0byB1c2Ugc25hcHNob3RzIGFuZCBiZQ0KPmFibGUgdG8gcmV2ZXJ0LiBBY3R1YWxseSB5b3Ug
c2hvdWxkIHByb2JhYmx5IG5ldmVyIHVzZSBidHJmcyB0b3AgbGV2ZWwNCj5zdWJ2b2x1bWUgZXhj
ZXB0IGFzIGNvbnRhaW5lciBmb3Igb3RoZXIgc3Vidm9sdW1lcy4gUGVyaW9kLg0KPg0KPllvdSBj
b3VsZCBzaW1wbHkgcnN5bmMgZnJvbSBzbmFwc2hvdCB0byByZXZlcnQgdGhlIGNvbnRlbnQgb2Yg
eW91ciByb290Lg0KPkl0IHdvdWxkIGJlIHRoZSBtb3N0IHNpbXBsZSB3YXkgKGl0IHdpbGwgcHJv
YmFibHkgaW5jcmVhc2Ugc3BhY2UgY29uc3VtcHRpb24NCj5zbGlnaHRseSkuIE9yIHlvdSBjb3Vs
ZCBib290IGxpbnV4IHdpdGggc3Vidm9sPS4uLiByb290ZnMgb3B0aW9uIC0gdGhlcmUgaXMgbm8N
Cj5uZWVkIHRvIGFjdHVhbGx5IGNoYW5nZSBkZWZhdWx0IHN1YnZvbHVtZS4NCj4NCj5JZiB5b3Ug
Y2hvc2UgInVzZSBkaWZmZXJlbnQgc3Vidm9sdW1lIGFzIHJvb3QiIHJvdXRlLCBrZWVwIGluIG1p
bmQgdGhhdA0KPg0KPi0geW91IHdpbGwgbGlrZWx5IG5lZWQgdG8gcmVpbnN0YWxsIGJvb3Rsb2Fk
ZXIgYmVjYXVzZSBwYXRocyB3aWxsIGNoYW5nZS4NCj4NCj4tIGFueSBzdWJ2b2x1bWUgYmVsb3cg
LyBsaWtlIC8uc25hcHNob3RzIHdpbGwgYmUgaW52aXNpYmxlIGZyb20geW91ciBib290ZWQNCj5z
eXN0ZW0gYW5kIHlvdSB3aWxsIG5lZWQgdG8gZXhwbGljaXRseSBtb3VudCBpdCBpZiB5b3UgbmVl
ZCB0byBhY2Nlc3MgaXRzDQo+Y29udGVudC4NCj4NCj4tIGFzIG1lbnRpb25lZCBhbHJlYWR5LCBk
byBub3QgZmxpcCByZWFkLW9ubHkgc25hcHNob3QgdG8gcmVhZC13cml0ZSwgcmF0aGVyDQo+Y3Jl
YXRlIG5ldyB3cml0YWJsZSBjbG9uZS4gSSB3b3VsZCBhbHNvIGNob3NlIHNvbWUgZGlmZmVyZW50
IHBhdGggbGVhdmluZw0KPi8uc25hcHNob3RzIGZvciBzbmFwc2hvdHMuIEl0IGRvZXMgbm90IG1h
dHRlciBpbiB0aGlzIGNhc2UgKGF0IGxlYXN0LCB3aXRoIHRoZQ0KPmluZm9ybWF0aW9uIHByb3Zp
ZGVkIHNvIGZhcikgYnV0IGl0IGlzIGdvb2QgaGFiaXQgdG8gZGV2ZWxvcC4NCj4NCj4tIGFmdGVy
IHlvdSBib290ZWQgbmV3IHJvb3Qgc3Vidm9sdW1lIHlvdSB3aWxsIGhhdmUgdGhlIG9sZCByb290
IGNvbnRlbnQgaW4NCj50b3AgbGV2ZWwgd2hpY2ggY2Fubm90IGJlIGVhc2lseSBkZWxldGVkIGJl
Y2F1c2UgaXQgaXMgbm90IHN1YnZvbHVtZSAoYW5kIGl0DQo+d2lsbCBiZSBpbnZpc2libGUgYXMg
d2VsbCkuIFlvdSB3aWxsIGhhdmUgdG8gY2xlYW4gaXQgdXAgbWFudWFsbHksIGFuZCBiZSBjYXJl
ZnVsDQo+dG8gbm90IGRlbGV0ZSB5b3VyIHN1YnZvbHVtZXMgZG9pbmcgaXQgOikNCg0KQW5vdGhl
ciBzY2VuYXJpbzoNCkkgaGF2ZSBzb21lIHZpcnR1YWwgbWFjaGluZXMgZm9yIHdoaWNoIGkgY3Jl
YXRlIGEgc25hcHNob3QgZWFjaCBuaWdodCB3aXRoIEJUUkZTLg0KVGhlIHNuYXBzaG90cyByZXNp
ZGUgaW4gYW5vdGhlciBkaXJlY3RvcnkuIEhvdyBkbyBpIHJldmVydCB0byBhIHNuYXBzaG90PyBT
d2l0Y2ggdGhlIHZpcnR1YWwgbWFjaGluZSBvZmYgYW5kIGp1c3QgY29weQ0KdGhlIHNuYXBzaG90
IG92ZXIgdGhlIG9yaWdpbmFsID8NCg0KQmVybmQNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNo
ZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1bmdzemVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVt
d2VsdCAoR21iSCkNCkluZ29sc3TDpGR0ZXIgTGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJi
ZXJnLCBodHRwczovL3d3dy5oZWxtaG9sdHotbXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6
IFByb2YuIERyLiBtZWQuIERyLiBoLmMuIE1hdHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVy
IChrb21tLikgfCBBdWZzaWNodHNyYXRzdm9yc2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERy
LiBWZXJvbmlrYSB2b24gTWVzc2xpbmcNClJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8
bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWROci4gREUgMTI5NTIxNjcxDQo=
