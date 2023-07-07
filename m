Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFD74B86B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGGVCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjGGVCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 17:02:21 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BC1BD2
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 14:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkHv7vsMkZ7Ig+Ac4H5+sv8Gb8p2qth+GDniVqRAI5KU6JbEZRTN1szyRDd/ib+/hlSB3hUiVrp9CijgfVoIq2j2rBuN0QN1Vff6e1nxERZ9W0gUYekefIJfDd2TmFmOgb/01tgOirKVFFxJ6G2Icwm3RIsqSjN15OeVLwnPTRz+w7uTHoY/k6g9S9ZEjqIdWV1PwtAMFQ8i7i8sE0DoOT+/wb1Jb7tZD+dLtrpqzGE39B0/laMNmLGQSzo1tE0iuz9yUW0nooeEzmzIbydAUJx6a7MJ3XcSSUdVBcEr/9OCeiDlZ8TL+8RPrMvUlYtSP86xX3hqDiEo5C0WlXyoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCfBc0kMQadOVX/C/ItaUtuS8WAUuSOKXmnmFv+Nwuw=;
 b=VbUZXiFhHWeeVracUMax/PqACAZCD1UyUwN9Mx+j4NOO7YA2Ykz9GlUbpFUThOfSzE/R0cSGCCa9OGk0h/KCTXZ2c3pAaiSKB+wuWUoc6LdCYOGaOfGA8Wzbo67mEWVJy/9C48EAnNdkmd0uWQgDqXBl/PBC2eoCChjyYnoYYKtEI+bbB36U6dfYMfgZoX8xRb8NVBPp7+jjHdW9n2XkB/aCGI2/l7Xgg36FLarevqoLtEAn2y6DPBgqqjmFu1H2GtgUxFjwdIHvIFvTxxLeiMEM0b2L1+wOSlWs3DFUz8w86l9YAOsBnuUsuoWnsdgRTode7DbMKXu2RI2xzKcJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfBc0kMQadOVX/C/ItaUtuS8WAUuSOKXmnmFv+Nwuw=;
 b=KRmyXLOGJZxR2hsO1+7mfqfYnSWG3Q6IeQKnDbzajHhfxgAVNQrj0JHvYKCXgzNhFVtkILQd+sWU9J2USS1AGozACYg+lEa9BWN6yCABsoa/wbzO46C1W7yxOiobXwRrqMDtr8NzcOHiEy0HyRlnMSLRoFltGHHTNqbFR0V+0bI=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 21:02:12 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203%6]) with mapi id 15.20.6565.026; Fri, 7 Jul 2023
 21:02:12 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAA4hmwAAFVwYIAAAiSAAAAyYELAABoslAAAaKeyAAA59pQAAQlgh0A==
Date:   Fri, 7 Jul 2023 21:02:12 +0000
Message-ID: <PR3PR04MB734040254D53131CD56C389FD62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
 <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
 <103cec84-6d26-0fa5-6229-6db5eea6a56e@georgianit.com>
In-Reply-To: <103cec84-6d26-0fa5-6229-6db5eea6a56e@georgianit.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DB9PR04MB8496:EE_
x-ms-office365-filtering-correlation-id: fb4476ec-7f6b-4080-fd6a-08db7f2d6f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMyuzGSoYCF2vtN8svIq+Oxmmf93Tloglwv4LSxbiemJIsG5RLAMcCyqRKTpWVM2XSUe6FIny83m8hi7i+DUAetQ2kPpbam0itcN6GEWQDtD8OGf8qNUoA9XPqPS+NSgB11/900lN8bM/Pw0zYHf0Hyzrgru0AbxlKNjbIh4uYCJ036yRblbqB0+1CmQEvU8arXRuRx3J0drNthwP4RWqnE9fPPLv2flKpIsZGMc+sPiSPhDQScq1wg+xZiGyteG3vi6169oSDqEm1484wEUORKh8rA8/EL3RHYJ4xj4V3ndXvQheDvKtI17/wBe7hleXYl+QX3r0a0x5qpjZeP0FXBw8TWlisJGCKr73QlKo6MRQzZdhOG/rm1Q8imN5AwkKy60TrCqHynmJkKE75yy4u3flxmDlsfTekbxtdjqDYanjV1pd++dpqUwdeiDbZyuNrms8Io6uaQWWgP2TEwBdb5loE0SF04N54Za7j4YMQYCXgRMigmvXcR1iSogIy4rXNR4y9bJXln2Pt+fznRs0sFHL91OtZcgyecYzRwWKau39cUHrhSkGWrlucy7b/BBiWDdqNeRtH9/XMYQtVGHpTIXDAJZ9k70xMGexFZBwkiDWLHn9O7iIodNjmIYDALS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199021)(76116006)(110136005)(7696005)(71200400001)(478600001)(26005)(6506007)(38100700002)(966005)(66946007)(122000001)(5660300002)(8676002)(52536014)(8936002)(66476007)(66556008)(44832011)(41300700001)(9686003)(316002)(66446008)(64756008)(2906002)(83380400001)(33656002)(86362001)(66574015)(55016003)(3480700007)(186003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm9KUWNKYitwRytvNVV0Wm41WS9xSlJxUVhJcXQ5WDg2MUNaVGFrUjBuRHo0?=
 =?utf-8?B?bC82N056VjJsRE5PZXNiZDdwalJyS3RNeHVBTkFjY24xQmRWMDBmNUZWek54?=
 =?utf-8?B?S2ZXRFlsTTdNYm5HeitWcS9ibXdFS3RjTkVTZGNKNFRSekZtMXJCSEJ1QUw5?=
 =?utf-8?B?VE42MW9hamJiR3NqTWZPU2l3LzFhZUJyUll6U2JmNkVLU1dBYmFHVGlQcDhS?=
 =?utf-8?B?RWpzMW0yK1dYMFpWdUxYclZGY0RML1RJMkhhQkg5Y0hRL2dEMWU0MXloUmp1?=
 =?utf-8?B?UTYyd004UHcrRFcwaVhrd0xGcitmZXNwOXdOYjJ1K01XRUNIcmk1dXRLd3Yw?=
 =?utf-8?B?d0VJcTE3aUovM0VNS2FJY3QyVFc4NG5VT0tvRDRkUHhQRTJsN3pocDVDdEtG?=
 =?utf-8?B?UnJrQUgvTEFubHZEOGp0TjNGejByWmRTa3R2ZDh2QTBremFBY2drd2kvUUta?=
 =?utf-8?B?bHJEVlF3MXRjVDJaU2VrVFpvTXNHVXpLYWNJVTlBTjNLNGdkMXNGUUlQTTRR?=
 =?utf-8?B?REZkZ1AwWjJxMmVLNGJMWm1IU01LdTczcEZwRENxbDR1Z1ZKRFZrN0F5ZTRy?=
 =?utf-8?B?ZGo4T09lcnA4RXNNYVdtczRudWdXcTh1a3Bnc1pHbUNPTlQwc3cyb1cxME1E?=
 =?utf-8?B?U3lPaHVUbDFkM2dxUm1VNzVYL2dadHJQVzZIdFl1dVgxcnhiVUpXOWI4R1RM?=
 =?utf-8?B?NDk0VXhsSVh6bmJwUVY3THpsRENpK1hiaFJpL1hCclpkYUlFSldXc3MvK24w?=
 =?utf-8?B?TkV4ZUljbnJlUGRkZ0gxdGRVMktJL0hjZmxQeGFRN290WFkvZWtHVTJINFVC?=
 =?utf-8?B?QzFOeVBmSWJNV2o2UjZhaVBvS0VNdkIvbTZjMFN0Q3dnNDhtc255SXp2Z0xr?=
 =?utf-8?B?UG5BMmZxemxrbWYwd2dZc1hsbjNTV2xtYStBRVhwbC9zMG9OZmdPWkJOeXlZ?=
 =?utf-8?B?dHR5Y2NSOXM2YWZ4U2RJc2ppYk1kaDhsNzBSeFNMUzdZQ3ZFNDBnR2FnbjlL?=
 =?utf-8?B?d1hQcGdJMytPK3QveVU4Znl5cVJYZmRpVXhQTDBtTjRnRFF3L3kxOThCNTlG?=
 =?utf-8?B?Tm5YTEorc09SNXpTNkI4R0tYTDl6bjFqWm56OWk5NG9Sc29JY2UveHR6bVNO?=
 =?utf-8?B?alZnQXhzVklLamptcm5jN2N5eE5nYncwVW13em0zdi9zUStCZVV6akZrNDNZ?=
 =?utf-8?B?dTlRcVlGVDNJUGc3V2NpaytIZUZJalczMXlhMHhrV3R5UllYb0hhT29GSDh2?=
 =?utf-8?B?Ly90bVFvSWtEbWtzblZHSG82aW5iRWd5eHFRMHRPUTZLK0dmaHYwTDVvTjVL?=
 =?utf-8?B?Znpub29OZUYzbzNIeXB3K0NIbzJ4emY4Y0hBRWpxcFN6SEVONWJvL3RNZnd4?=
 =?utf-8?B?VjlvQWlaN0JBTFAvdS9EU0xOWmFCc3o5YzlLQ2NYR0piL1gwV1FiRlQ2ckpt?=
 =?utf-8?B?aGw1bnQ4K2x0bmJRdkF2ajRuS2NGVGZRT0NKNEIyODM1R09oazdZN05OZHJt?=
 =?utf-8?B?U3ErN2Q4azJWbW15akhOWlZlZmdNdEZaQkRWSmgvNlZSRUpGeGdCMDByR0pL?=
 =?utf-8?B?UVFhTThGeVA3S2Q2TWZaUGdybTFMNTRXSElETkRuOE5KeGFsb0hWZVNUMENs?=
 =?utf-8?B?akNINlZ6ckNCZmw3K2ZBY1BvL211RWRzM3JxWG1yYU8rVFBERFE3UHJ3YnZQ?=
 =?utf-8?B?bmhDVFY1UXJzR1NGdzN0bmJQeVV6YzBXVUdWazF2dUppYWdFY3o1MW56eFpo?=
 =?utf-8?B?Tzg1clJSaGt5YTlQb3E3M3l1ZjhERkNxNTh0amh5RzlCcGc0cVJiQVovWHUy?=
 =?utf-8?B?T1Rkc0xRdDF3VFg2T2FPbWw1dlJMWVYzS1RMWmM1YXFPcTl5aXRQaHA2N3Ft?=
 =?utf-8?B?VWU2RDVLWExRRDhPRGtLK2VMOGRuc05zcUJSRGNORHdjTTE5MXdZc01JQXVS?=
 =?utf-8?B?YU9CWDJJVzRjenhPN1Q0OW53R1I3NHlOS09pWGNTVExYV1RFL3Jkay9Kc1Nx?=
 =?utf-8?B?NW1GVWJMRXk4QU5hUlIxZUNnUjg3UXNwMjVuZzc0RlFzdlNNdXVXYm5LUjlY?=
 =?utf-8?B?c0tiRk1ZUm4rN3E5ME5TdW1wS1hQVTI1aEVHa0ZCQ3NWcll6bG55SmF6TjZC?=
 =?utf-8?B?ZXcwb3c0Z0VDQnZVUTJ3c3o4SVBSNnNvSVhPdkRwRHZpaWVXWVpQUGd5R0U4?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4476ec-7f6b-4080-fd6a-08db7f2d6f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 21:02:12.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr4qPLvvAZU51ujpAvaJV0FGB/bJbrbsmjaZhmooph87MrKp/cuoT8SWFy1iNtuvnXU3/TtvbjHgBpuV3uzmk22sQDCcMOhWJmQ0BwaWMc2vTBGVXV2v2BUPVehovgYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBSZW1pIEdhdXZpbiA8cmVtaUBn
ZW9yZ2lhbml0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVseSA2LCAyMDIzIDM6MTggUE0NCj5U
bzogUXUgV2VucnVvIDxxdXdlbnJ1by5idHJmc0BnbXguY29tPjsgQmVybmQgTGVudGVzDQo+PGJl
cm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGU+OyBsaW51eC1idHJmcyA8bGludXgtDQo+
YnRyZnNAdmdlci5rZXJuZWwub3JnPg0KPlN1YmplY3Q6IFJlOiBxdWVzdGlvbiB0byBidHJmcyBz
Y3J1Yg0KDQo+T2ssIGJ1dCBJIHRoaW5rIHlvdSBtaXNzZWQgbXkgcG9pbnQgaGVyZS4NCj4NCj5H
aXZlbiB3aGF0IHdlICpkbyoga25vdyBhYm91dCAqdGhpcyogcGFydGljdWxhciBzaXR1YXRpb24s
IChyZWNlbnQga2VybmVsLA0KPmNvcGllcyBvZiBWTSBzbmFwc2hvdHMgdGhhdCB3ZXJlIG5vdCB1
c2VkIGFzIGxpdmUgaW1hZ2VzLCB1c2IgZGV2aWNlKS4NCj5Db3JyZWN0IG1lIGlmIEknbSB3cm9u
ZywgYnV0IHdpdGggdGhlIGNhdmVhdCB0aGVyZSBpcyBubyB3YXkgdG8ga25vdywgaXQgaXMNCj5t
b3JlIGxpa2VseSB0aGF0IGNzdW0gZXJyb3JzIGFyZSB0aGUgcmVzdWx0IG9mIGRhdGEgY29ycnVw
dGlvbiBvbiB0aGUgZGlzay4NCg0KQnV0IGkgcmFuIGJhZGJsb2NrcyB3aXRob3V0IGFueSBlcnJv
ci4gV291bGQgbWFsZnVuY3Rpb24gaGFyZHdhcmUgbm90IGNyZWF0ZSBtYW55IGVycm9ycyB3aXRo
IGJhZGJsb2NrcyA/DQoNCj5UaGUgcmVhc29uIEkgYnJpbmcgdGhpcyB1cCwgaXMgYmVjYXVzZSB0
aGUgdXNlciBpcyBiZWluZyBsZWQgYnkgdGhyZWFkIGludG8NCj5kaXNhYmxpbmcgZXJyb3IgZGV0
ZWN0aW9uLCB3aGljaCBpcyB0aGUgZXhhY3Qgb3Bwb3NpdGUgb2Ygd2hhdCBzaG91bGQgYmUgZG9u
ZQ0KPmluIHRoZSBjYXNlIG9mIHByb2JsZW1zIGNhdXNlZCBieSBtYWxmdW5jdGlvbmluZyBzdG9y
YWdlIGRldmljZS4NCg0KQW5kIHRoZSB1c2VyIChtZSkgaXMgYSBiaXQgY29uZnVzZWQgOi0pLg0K
DQpCZXJuZA0KDQpIZWxtaG9sdHogWmVudHJ1bSBNw7xuY2hlbiDigJMgRGV1dHNjaGVzIEZvcnNj
aHVuZ3N6ZW50cnVtIGbDvHIgR2VzdW5kaGVpdCB1bmQgVW13ZWx0IChHbWJIKQ0KSW5nb2xzdMOk
ZHRlciBMYW5kc3RyYcOfZSAxLCBELTg1NzY0IE5ldWhlcmJlcmcsIGh0dHBzOi8vd3d3LmhlbG1o
b2x0ei1tdW5pY2guZGUNCkdlc2Now6RmdHNmw7xocnVuZzogUHJvZi4gRHIuIG1lZC4gRHIuIGgu
Yy4gTWF0dGhpYXMgVHNjaMO2cCwgRGFuaWVsYSBTb21tZXIgKGtvbW0uKSB8IEF1ZnNpY2h0c3Jh
dHN2b3JzaXR6ZW5kZTogTWluRGly4oCZaW4gUHJvZi4gRHIuIFZlcm9uaWthIHZvbiBNZXNzbGlu
Zw0KUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBNw7xuY2hlbiBIUkIgNjQ2NiB8IFVTdC1J
ZE5yLiBERSAxMjk1MjE2NzENCg==
