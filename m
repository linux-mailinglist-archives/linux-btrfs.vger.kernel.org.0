Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025474B864
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 22:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGGUyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGGUyj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 16:54:39 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778E2127
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 13:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQCDu+EhCQaptUwGJWkQZzKpIPxfFZCYkgKFLk5K/RM36cYwo+HWYZ5CEZu1Swze7e75L4r+rwISAIiysKJso2RBsaIZnzKLLAZvfhzG4WiO0wUH2LnXxECJeKfIVwsfv6ine74cC7bWHJ4ZRXOx9joA4rsEl49XRrvn3psxdSrXaUj8C6EqIIcuINV+s7gfjQ7/ZwkvxoPTKgbu3kY5pTE0giPsgA1vYHO0lS1uh5oorCQvzoZr6Zin6//MZMse2ZeWAdlEitBhKNFOPBxKW9vlZcS5Bb1Gx7YXV8dnmbKLjTHJS2Ht0/+0xcGJLvyfpPR5GwoYowFeT7mmaMoGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH0UsgheDibDYkzkMZQuyZrU2ZgNZitPU/8MkFk6Jnc=;
 b=P0w+5FQKi8jCQWa8DAWMRL8Y0bPS/9o+Q6GwTd73ECj4viI9kHADD2kkCs0Xl0AnOfVLtE6LeAQEyqJgBBT3XALmeo49GdOmqqgCuNJmIvoRdg3ABS1dXHuNz/hVWvGD3tV1TTue46YjXbrzZ3Y/1eu1B8IN/3m9TEXEu5gzCEUzCqWI6Cj+HnUwxR3BD7so3RR+638wWkCDWf1KYfVWh5+FwmTpv7eTUQJGqhS6hD3He+dOter/T1zpi7vbI+4irJv1LhcyrLN5XckDVPIYvktKrJPr5RVapnbA2WWP7VBtsWru4bYxvpiFOy3rXxlCKBbIx7H5ayyd9gAT8hJB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH0UsgheDibDYkzkMZQuyZrU2ZgNZitPU/8MkFk6Jnc=;
 b=hqMmaoDahJY6oOosRj7aiV5pfHnay2mu7bJ0hjS3Woiy/6BIoDXlsLywFRv4mXhfcR6pUOmFCyhvUK+11/GI/+oafoB75458/V2LpEzhN925vf6Sjw4KUALsBzym3yH8KQRlmVwpoPT3+OJWvV+nDBuKdprXTVVmfYXS9/SwtQ0=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by PA4PR04MB7838.eurprd04.prod.outlook.com (2603:10a6:102:cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 20:54:34 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203%6]) with mapi id 15.20.6565.026; Fri, 7 Jul 2023
 20:54:34 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Remi Gauvin <remi@georgianit.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAA4hmwAAFVwYIAAAiSAAAAyYELAABoslAAAaKeyAAFCejJA=
Date:   Fri, 7 Jul 2023 20:54:34 +0000
Message-ID: <PR3PR04MB7340C4687924686D4C7ABD8AD62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
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
In-Reply-To: <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|PA4PR04MB7838:EE_
x-ms-office365-filtering-correlation-id: 07760373-c934-4b5e-57a1-08db7f2c5ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHaPMPHQQJ2EZwBMGDqMxnJaOujRjNP401SpKXCmGko6417pMMYsh2kdCiwI75uCAty0FO9Wt4q2BEMnypQNe2OTnxhu6lGK1YCDruOP8cGPvDOrjLfvgQBoKxpQKHlLbJ5pcNEtbv8VpW4kMvbg5YtMXx9Z6rQeS3UwbzJMU+Kbr9iHsgxTqPj1DV0gEt4KSFPEcCbtVj/VhMtj3AmDXftbJwI4G/XeVcFY4u7F3EZCI2GHOug/1VZ8vME7A3dqR4yDgt55deJ3mds7/AW3OIlKBRpUY0C0INWRQzB4fBmTgNE8sehZj7NaSNaRRfx9KYoHYESPYTP62zDXq8ftBA9B98S8tMwbDvNVutixqJ6Lx/sIQqJolSOL+kdh50BKxHL9xOVYuQ+9B+mpV59dXKzkqb6rt62n0nWAzCIRTt0YqpUcBCb7YuQnm4Ven7G9246ip07Jtbz4tj8g6gMtc8QzqboNvMTxTdrmw9f7gKUf+07yA0CHG/B98ls6zV+L5d4dhTYP8q1QawGTP71eU/s27t4DC6rPgh2UMtZPTrPmwW1e6FYwzJMwp3TdSIqM6mITj34cB4l8++PrnsIbgnejZXgpvUBKRjHMMSOivXQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39850400004)(396003)(376002)(136003)(451199021)(33656002)(122000001)(38100700002)(55016003)(38070700005)(86362001)(966005)(71200400001)(7696005)(478600001)(186003)(26005)(9686003)(6506007)(8936002)(8676002)(44832011)(5660300002)(52536014)(76116006)(66946007)(110136005)(66556008)(64756008)(41300700001)(2906002)(66446008)(66476007)(316002)(3480700007)(66574015)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akN6UmRMdGNUNHNOdjNHQ3l2TnJBK3dvaUJway81My9LbjM1NzRXVUY4S3Fp?=
 =?utf-8?B?K1FNU1BXM0FBcVNwTVBZM3B0aWNrRUxja0RWSXlhOG9YWkt6Wlp3WFVTT3Zr?=
 =?utf-8?B?dGlUa3RVSCtKdEI2TUx3clpIWmp2YWEzWDk4dUVsaVJXdlRmeHVXU3ZsT0xa?=
 =?utf-8?B?NjZ2TTJ3QTdSTnVRai8reXlVZnY3WUgyQnUyRVlRc2RBdUl2WnRUSHYrTHJx?=
 =?utf-8?B?U25aeENoN1BCam11VnorRi90NzI5bFpBODlrVWthSUY1K3BFMHNibXl6SnZL?=
 =?utf-8?B?OXk3djJmQzBYTk5peCsvVXY5NU42SjFvcVl4WlBvdksvS0Z2ZjI1SW02K2lU?=
 =?utf-8?B?bWpMNmhQc2g2ODdKRXQ0ME9pNGM2SGtUbStPd0hqRWxhakxIbmViVDB4amtp?=
 =?utf-8?B?TmJ2UzhpM21BdlBLZnIzNWlIeWhaeWlhVStJbnJiSDlrR0V2YXVFRkRtRnp0?=
 =?utf-8?B?bmp0YkVDb1d4RGZranFnV1pBVHNaNXh1U2VNRmNNbnJWOU8zMEdlUmEvL2ZG?=
 =?utf-8?B?SFFjZzBoaEFJcGlRbUlHMkJHWkFaTjhsTVljK0IxV2hMTTVtb1ZUMDBsU2d6?=
 =?utf-8?B?aDBqdW5mdE5DZllaZlFQbkxIcENTcG53c2JGRnVKVFdiNVdDWG9qK0F1TkR0?=
 =?utf-8?B?bVA2YXJCVWRhVzFhZngxUkhPTXN1Nm03Y01RU0JpTlZkbzZibGQyY1o2U1NB?=
 =?utf-8?B?SmhiRkdHTHhZTlJ2MFA5QlRjVXZlbm5TVHl1V2hsUWZjZzZHdHVockNKOXpU?=
 =?utf-8?B?TG4zY2MvV3JXWEpNdHFWZ1FPdjFVb29ZYUpzMmMzQ0xhS08ydEc3WjZqZmRE?=
 =?utf-8?B?QzZTNjJzUnBtcEdPSEJqTi9pVGdOSnhHbk1QSW5IdnJ5WDZGWGpJN1owWU9p?=
 =?utf-8?B?QU9UWjNIY3ZTTXQ1K250NXFRcitvNTdobjlhWFZXdzhBMkIrZ1l5Y21yd2Nv?=
 =?utf-8?B?RTY2NGxRT0twTzIzVC9PU0x1SExCNnFsTzFpMlZDY3NMV2RLVlFTOVJwR1Nv?=
 =?utf-8?B?Mjh4KzhScTFOdlZ3MUpKMXRncUIxSEtVZUtHejFwWEtxbzVuV0JVQzFpL2ha?=
 =?utf-8?B?V1VJZ2VuMUlMY3dFMHVmTnJWV2VWOWJIZDY2TmxiUVUxbU05U2FxaFZTYjBu?=
 =?utf-8?B?ZFFLMDZwa3ZwdUN2QnBZaW5kVkdSeSs0Rm0ycDgzczcxVnhVMHQzYnFDbmZ1?=
 =?utf-8?B?dXRUZlRWakdmNmFUQk8zOWhDUFcvSjZtN2QwTXpWaXoyWk1ZdWhuNWRjNS82?=
 =?utf-8?B?ckovU2J2UEdoWjI4NXppMjBUaFYzUUc3NGZxZ0pTZytDdmRJRnF0U3VPSXpG?=
 =?utf-8?B?akZiZHRXTXp2NEtaTlZwQWFNYzRoWjBXUUxSTXEyQlYzakxyMGUrU3d3L0di?=
 =?utf-8?B?VlFXb1ZMUUtTK3RVRlAxMTAxR2JwYlR4N1JhN1VtZWxJbFVsNklrVWt4NDV6?=
 =?utf-8?B?VCtSck9Yaml5STFJUDlqRUpXWHUxb3ZvVk96TDYrYU8rSDlxREdIUVFxSEVa?=
 =?utf-8?B?V3NvczU0eDFVZFZRVXhsVDVaWUw4MkRNNERIMzhEU2JETlQwOTRML3RPUmZr?=
 =?utf-8?B?REZEZFUwRE05clZ0M1BPNXNHcU5OcEMxMW9BRnJLQklBa0xPQkZYT3QzbXJM?=
 =?utf-8?B?ZHVaYThjQWVodlJrWWpKSy9TVElXUmJwanBpWmxpTWRDU25hcWVPL3hjVlBO?=
 =?utf-8?B?SE9sOUpSOVRjeEdiUTBqTlQ4RDhKUDNDa0d0YjNQUm0yZnJ3dHlIQ0c0Y3RU?=
 =?utf-8?B?NHUvb3l6MGVidzFGYkxiSWx1RlZIV0tJVE1DUXRac3UrQ08rRkdxMDR0ZlZr?=
 =?utf-8?B?M1lScldjVWExQ29OVjdRYjRpeHVJYng0eTJZMkdGcTBTM0VPNW1EWFk5Yk5G?=
 =?utf-8?B?OEI3cUFCb0JvWjZGL25udmpxclNXdU9MdE1qQWplb1lIMCsvMVR2eExTVEd0?=
 =?utf-8?B?TjBMcWtUWHNQQUxJVmNyRkpWVDBaWVZQd3BZaUtSYWdhSE4vR3RsSGIzSEQz?=
 =?utf-8?B?UDR5U3F6YTJhcXFLdzFrOWkyZ21QOWlqbUhrTXdiaWFNdUlQUG5ZNEo4T2kw?=
 =?utf-8?B?QU1TQ2VIU0xCV1c5UjhsMzUzTXR2Rnp2dWdUNXNteHY2L21tblVnNS9PRHVY?=
 =?utf-8?B?RlZRVmVMNjd3Z3BmbUYyZVVvZnREWHNzRUdORTliZmdsZmJ3T3hxSk10L0Fz?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07760373-c934-4b5e-57a1-08db7f2c5ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 20:54:34.5702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IB1Y1HuCc9JwsVgoE6wlKGXCacZ6GDTAbhvdVv86dPD5bM0sBOrHpi+PMdAK6mEaR8IiHaEhHZQc7KEEOUVAzOCcVIdHAOueDO4X1CEsSVR8+ucRJ21Lp6PDS8l8wvk9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7838
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUXUgV2VucnVvIDxxdXdlbnJ1by5i
dHJmc0BnbXguY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBKdWx5IDYsIDIwMjMgODoyMyBBTQ0KPlRv
OiBSZW1pIEdhdXZpbiA8cmVtaUBnZW9yZ2lhbml0LmNvbT47IEJlcm5kIExlbnRlcw0KPjxiZXJu
ZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5jaGVuLmRlPjsgUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+
Ow0KPmxpbnV4LWJ0cmZzIDxsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmc+DQo+U3ViamVjdDog
UmU6IHF1ZXN0aW9uIHRvIGJ0cmZzIHNjcnViDQoNCg0KPkkgaGF0ZSB0byBwb2ludCBteSBmaW5n
ZXIgdG8gYnRyZnMgaXRzZWxmLCBidXQgSSBzdGlsbCByZW1lbWJlciBpbiB0aGUgb2xkIGRheXMN
Cj5zb21lIHdvcmtsb2FkIGNhbiBsZWFkIHRvIHN1Y2ggZmFsc2UgYWxlcnRzLg0KPkJ1dCBJIGNh
biBub3QgcmVjYWxsIHdoaWNoIGNvbW1pdCBpcyBjYXVzaW5nIGFuZCB3aGljaCBvbmUgaXMgZml4
aW5nIHRoZQ0KPnByb2JsZW0uDQo+DQo+QW5vdGhlciBjb25jZXJuIGlzLCB0aGUgcmVwb3J0IGlz
IHVzaW5nIFNJTkdMRSBmb3IgZGF0YSwgd2hpY2ggaXMgY29tcGxldGVseQ0KPmZpbmUsIGJ1dCBp
dCBkb2Vzbid0IGhlbHAgdXMgdG8gZGV0ZXJtaW5lIGlmIGl0J3MgcmVhbGx5IGEgaGFyZHdhcmUg
ZGF0YQ0KPmNvcnJ1cHRpb24gb3IgYnRyZnMgYnVncy4NCj4NCj5JZiB0aGUgcmVwb3J0IGlzIHVz
aW5nIFJBSUQxLCBhbmQgdGhvc2UgY29ycnVwdGlvbiBhcmUgYWxsIHJlcGFpcmFibGUsIHRoZW4g
d2UncmUNCj5wcmV0dHkgc3VyZSBpdCdzIGRhdGEgY29ycnVwdGlvbiBvbiBkaXNrLg0KPk9yIGlm
IGFsbCBtaXJyb3JzIGFyZSBjb3JydXB0ZWQgaW4gYSBSQUlEMSogY29uZmlnLCB0aGVuIHdlIGtu
b3cgaXQncyBkZWZpbml0ZWx5DQo+YnRyZnMgY2F1c2luZyB0aGUgcHJvYmxlbS4NCj4NCj5CdXQg
d2l0aCBTSU5HTEUgcHJvZmlsZSwgaXQncyByZWFsbHkgaGFyZCB0byBzYXkuDQoNClRoZSBzZXJ2
ZXIgd2UgYXJlIHRhbGtpbmcgYWJvdXQgaXMgc3RpbGwgaW4gdGVzdGluZywgbm90IGluIHByb2R1
Y3Rpb24uDQpUaGF0IG1lYW5zIHdlIGNhbiBjaGFuZ2UgdGhlIGNvbmZpZy4NClNob3VsZCB3ZSB0
YWtlIFJBSUQxIGludG8gYWNjb3VudCA/DQpXZSBoYXZlIGVub3VnaCBkaXNrIHNwYWNlLg0KDQpC
ZXJuZA0KDQpIZWxtaG9sdHogWmVudHJ1bSBNw7xuY2hlbiDigJMgRGV1dHNjaGVzIEZvcnNjaHVu
Z3N6ZW50cnVtIGbDvHIgR2VzdW5kaGVpdCB1bmQgVW13ZWx0IChHbWJIKQ0KSW5nb2xzdMOkZHRl
ciBMYW5kc3RyYcOfZSAxLCBELTg1NzY0IE5ldWhlcmJlcmcsIGh0dHBzOi8vd3d3LmhlbG1ob2x0
ei1tdW5pY2guZGUNCkdlc2Now6RmdHNmw7xocnVuZzogUHJvZi4gRHIuIG1lZC4gRHIuIGguYy4g
TWF0dGhpYXMgVHNjaMO2cCwgRGFuaWVsYSBTb21tZXIgKGtvbW0uKSB8IEF1ZnNpY2h0c3JhdHN2
b3JzaXR6ZW5kZTogTWluRGly4oCZaW4gUHJvZi4gRHIuIFZlcm9uaWthIHZvbiBNZXNzbGluZw0K
UmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBNw7xuY2hlbiBIUkIgNjQ2NiB8IFVTdC1JZE5y
LiBERSAxMjk1MjE2NzENCg==
