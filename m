Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4015B6BDD9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 01:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCQA3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 20:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCQA3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 20:29:22 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2047.outbound.protection.outlook.com [40.107.107.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5EBDEE
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 17:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8TSbxFvpaGA5ffJxpRYuuLRe9bq/nHh5XF/EaUDRn026cjvMtC7ypcman0lRzGVuu/yU7aeWxC03CYoUi+wz03mg/yM99OCzHZnogXVJTBZImc0mQYJejCfZIPqdEtlh5CiDi+Q5eNE7hEWRdLNBbdK+5Cy8Rn68zmwMHhhn168azN29RajRfWYhN9+RHvn3Gjt65z75oCpL4E1BMRCtG7bLWZvi6m9/wMtyVXcFXbz/PhhqYN7QeEVuCUJhRvpULxrp9jbPsC/wbv98LyDAUx2gR8TnH+lzlo7tit0WCDn0VtlMM7kcySvUx9qx+xMVmVsZCqre37CHo4WwOlnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awzuQHNQcCHQCdiAV6UTz5aCB2xpyG1IMLGIuqMmQ/k=;
 b=TUa5at/eUGw8JYvuNYZnmJvywrHH8owiXCn/tNW4D1GtNZlu3qmx+cEwSZzNf5Uz98/M5t4f3S5Ca021rHniKDffanKdBT52MS/2CQo64FUEHszLdAh7fS7jxmIunUtldiazpdDuyht5XoM5bWS2DmpK5XU8w147d/uyGvJeyAcSEJ3EMjNKhPOBG40td3Jfag+fH4nH4egVZ7grtP+4x8CyWxxt2XnLg9qehTLngmlMCout5BvEGTgBkkFB/yoF1kzRwHywulb3C3bpLhEBNSqIR/HS4lNeqjHUMn2Sl4DwrslehjZSapzYZqXSLSNDzq12tO2tsr5Cp+tOf1j3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awzuQHNQcCHQCdiAV6UTz5aCB2xpyG1IMLGIuqMmQ/k=;
 b=Iy44JMXi8GYnH88/9BtkjFw3TLUuWVpp0suFiSEBKY/S5tROK9QRjfrO6aYvqKFjookncodlyMWb7YKxQvayYHeIxYy24P8k9LAblfuVY76HwmtI9RMzwFxTBSH5S7nnXHlyb6tVUrI8i+DObgDaMZfDYo+EuxMz39+MjIb/oLE=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY4PR01MB6074.ausprd01.prod.outlook.com (2603:10c6:10:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 00:29:11 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::a227:e4e8:b45c:cb8c]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::a227:e4e8:b45c:cb8c%3]) with mapi id 15.20.6178.030; Fri, 17 Mar 2023
 00:29:11 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Robert Krig <robert.krig@render-wahnsinn.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Btrfs Raid10 eating all Ram on Mount
Thread-Topic: Btrfs Raid10 eating all Ram on Mount
Thread-Index: AQHZVxEl4xkB4KtzTUeQm5M2fhwL/q78LzqAgADNOQCAAA9QAIAAuzyAgABX22A=
Date:   Fri, 17 Mar 2023 00:29:11 +0000
Message-ID: <SYCPR01MB468513BF02ED64D2ABB6CC0E9EBD9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
 <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
 <2a0c8279-9521-2661-056f-bc5560094356@render-wahnsinn.de>
 <00abe228-fe4c-cb9c-9617-77a6b0944c06@render-wahnsinn.de>
 <3fd217a8-8694-a3dc-06b6-c5f8a1dca57e@libero.it>
In-Reply-To: <3fd217a8-8694-a3dc-06b6-c5f8a1dca57e@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY4PR01MB6074:EE_
x-ms-office365-filtering-correlation-id: a43452c7-2f92-497b-d3b4-08db267ea13c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghWSzZV+KjzeLkiK55pX7lLVfK0ntVfMe3iSBaffiBfCTTo67tXpzELeNSzy63mqYdD8Fq5uWbJA3nDB4wFA4AriHfN/4U6T+ZgPkmW+5XOC3/U7AnpjFHV4MmLnWkgvB0xp1zpvT0PDXQ9XrpJ7cvyqGxDOtybhrrEca9HtvivzKnEcWIxPmcqte5cTqNk5NY4kCNvTSFLyj+xXFxvhMZ2xEcriB9YZG19Ll5lfuqZnNuy7nGGX4MVZE7dsKaZO/sMBxzfZMqkNgat4BP7tfA+a+k5hOn9A4zeGoXWFy/i9wZHSGBBZhwCznfcuPs9NLo3EOM6POMKk/lQRy71vUvQbUEOPvw79h3sr+N1+kKYJL5pQmwf7Xf5rzm48QOrCszIi0+FaTwO6SFQnK91XAZMPMCIwcPjVMIob9JeNeNq5voxdAPACWzFpTorfmE8QPYD9D2n1j+Dfr9Lyl/M0WMqKbZn9R4EOnE4Ogn4uadQ2GWtImWCNYdzOYH8EYCrMcZ5lgIuCwJ7n08yfOEGm/f5YCnLx+ljLrE/il8c/8/6sEUcnI12uCHlo3imA8Zc4pzCQLNvda1Pu1fQfCu9ZZgic+75P323YTZ3TSgVwtJ+PSggumUmsfzL1Mrn2WsYf9LyxCKaErzVWELAwd1MsCl3t1Q+2litH+7qrifZlDfSCKeir1galcWsJ9qRo6TFQygejt0keowhvlz0Q/ukU2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(346002)(136003)(366004)(376002)(396003)(451199018)(71200400001)(38100700002)(5660300002)(7696005)(41300700001)(66446008)(66476007)(66556008)(8676002)(76116006)(66946007)(64756008)(83380400001)(52536014)(8936002)(478600001)(55016003)(38070700005)(86362001)(110136005)(316002)(186003)(122000001)(26005)(33656002)(53546011)(6506007)(9686003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUttbHFWcEtjL0s5T2doU05uTm43NURhY3g4L2hkdFBjQWp4Q3lhelNUVFhx?=
 =?utf-8?B?T20xSHFseFlqSmpWTEdnd3FMclo2bzR5MStvbXVVVzRGaHQxWU41eFNEQnNL?=
 =?utf-8?B?TSthSjVyZS9GYWpINTJmRzF3UnJUckNuVHFsb1FoNXhPdm5uNnpaZVVtQ0d0?=
 =?utf-8?B?MDREa00zdXpUSzhlUXVLMXNqWTFEYjhwbnRDWVcxd2pyUk9kd0pmOUZBQUpC?=
 =?utf-8?B?SVhHbjZIbGpwenltTkxOTDZFVzBwSFhYc21ZYU9JRm1udVhZMEpzMVQ5Rkgw?=
 =?utf-8?B?UmdsUVZpTDNDZjRYcWlBMUsxS2tmNExqUTNEL2tDMUtjUElxc2x0QnhPQWFk?=
 =?utf-8?B?dGpNcGRBVmp0NUI2SUJ1alhBTFliUWtNcHRoSnpJMWtUN0lQMlFuTy8wYnRE?=
 =?utf-8?B?cXFSdW5hY2NKWmIzSkFIVjFLUENTRklkZlBZU0w5bi9SMjltQmpBTXZaRU5H?=
 =?utf-8?B?TlBZeHNoWkxPZjJqOVAwS0RORWpvVmMxR2pRYzNYTDl0TWZXb1ZYdll2Q1hO?=
 =?utf-8?B?Ujd6MlpneTlNaTI2L1BISEtqcW9DQzJ0Q1F6Y2FzM0lCY0gxRldMK2JQeVBY?=
 =?utf-8?B?aDYvWTdXQTNBNTUvS2haWHVtNEZzd2JkaTBuU1AxSXNJQ3h1Q0FuOGVocVlz?=
 =?utf-8?B?TjgvdVYvK1Q1czd5bi94VUlzVTRRRjVISzJUU1NBRE5YYUJzVlEwV2tyYTgv?=
 =?utf-8?B?U3hmeG9QTjJwNUNhYmsrV2tZbzd0OVUvU0pmWCt0UjBiNXhvMVN1eENkR1hD?=
 =?utf-8?B?bm1GYUh3bHlzVWFUSTBrRFZiWml0c1phV08zcm5NenNzakRuUFNTNFhCMHUy?=
 =?utf-8?B?ZHlGNjdPdXVtdjZ3K0tWZ0FzblVxZ2V0ckxoNFFNaDVXRTcxSjNIWWViSlJO?=
 =?utf-8?B?ZmdSTWNOcmxPbjhQTVVCSFc3cjVhYU9mWkxTTUV6OHYwTFVON0Vtbkh2Rkgz?=
 =?utf-8?B?U2hqNEc2YTlJSEJuaW92WEV1N1dnNzF2QjI1M3NZVG1QODhCWlgwQjE4WWFt?=
 =?utf-8?B?b3lkek5JNmhTbEVoL2pwT3BLRmxnWHNaWSthSXRGVDJzc1NJVDIvTlR6YkI0?=
 =?utf-8?B?MFpvc2txUEFoWkx1Vm1vMkdrNFVkT1dFWlFVd3pYT1o5OUI1NXhaa0NRRzJR?=
 =?utf-8?B?MGVWektOa3I1RnVBdk9oNXpySllMd2hpNmM0cWIyRVBsY00vTUZaWjM2d0ZZ?=
 =?utf-8?B?V2V2L3FWdzJLcGRjOGtKNG1CNjloVXdNcXYvZ0NsckRYekloM2RSa0N4c2dQ?=
 =?utf-8?B?VVZUV3NOejBJdzVRREVXc3I0N2g5QTkzLzJUZEF1QjZ1TEZhaTlDc0hRUVB6?=
 =?utf-8?B?M09kR3RReWY5dFZIbEdpWi8vMXBTZDBQa2hubjIyMVRrRG1SdUh1RUkzSmdw?=
 =?utf-8?B?b0Z5RHRVc2g5T0t6NkFJTkJvTlBxSXVPeGJWalMvREQ5T3BQZVY2ckdJVWYr?=
 =?utf-8?B?N2pIYW5HcXRVVGM1bUJvT1ppSEVBcXlIdlI0UjhRY0dVbmpGcmgwLzZPZUV6?=
 =?utf-8?B?NVNYandhWmZkMVJSQk9UU1pQWUlNOFRNdnB6QmN2LzNxZVdENDJjS292L1lK?=
 =?utf-8?B?R0F1QklzQjJBeUZhN1ppVGNBY3hXcE1kRm9KeGlDR2Iza1VuRDc3eUJCNjZK?=
 =?utf-8?B?Mml4Mk1kRmw2REg1Q3VhclpCeElLQ0hJY1QyZjBvcVJLZk9lQ056bzhYaE8y?=
 =?utf-8?B?SWEyZkVWWk1oM1QxRStFVkVjNzZIZktVZ2NWTU9JQTNGb2dCUXEyWTcxejNX?=
 =?utf-8?B?ZzlnWHNsU0lzSUt6MlNaRzlkbkxDN2xGOXdFNGxGVDg3OTdOWDMvNWNIMk1n?=
 =?utf-8?B?UWh5YkZGdjRTZ00zODZhZmxsVTA1WDRPVDVtQ3VvRU93UWVvY2hIZ082VzF3?=
 =?utf-8?B?emV2UE5BOEluTndjMnRNdDdJYU5QeFhJSUN4NUJrVTZNb0FTWko4VHQ4TGlk?=
 =?utf-8?B?d0NLQ2ZyTXdWZUpMMllObzZ0WnB2Rnp6OHJTYkdVb3p3VWE5TnhOQ2MrcklJ?=
 =?utf-8?B?M1ExUFZiMEdqUi9PTUFmQ1VXWnJmZjFqbFlNRmtOT0RBZ1kzRkpFUGFZT2Fq?=
 =?utf-8?B?TVFub2l6cnN1aHNvRi9iUmdpN2RDSUJNcjZ6OHhVaHYwOGRlRGFMZHR1em9G?=
 =?utf-8?Q?ME7ThcAM6ilR/lUyieZIFt7og?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43452c7-2f92-497b-d3b4-08db267ea13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 00:29:11.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YBfvHemBZ/MhDWSfr+6RG3DegB7Gox+Di5iTH7QGaKVBXnPzpCu02K7wjeSnz83H1SOrV4qtjX6e/yaA67+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6074
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHb2ZmcmVkbyBCYXJvbmNlbGxp
IDxrcmVpamFja0BsaWJlcm8uaXQ+DQo+IFNlbnQ6IEZyaWRheSwgMTcgTWFyY2ggMjAyMyA2OjA4
IEFNDQo+IFRvOiBSb2JlcnQgS3JpZyA8cm9iZXJ0LmtyaWdAcmVuZGVyLXdhaG5zaW5uLmRlPjsg
bGludXgtDQo+IGJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogQnRyZnMgUmFp
ZDEwIGVhdGluZyBhbGwgUmFtIG9uIE1vdW50DQo+IA0KPiBPbiAxNi8wMy8yMDIzIDA4LjU3LCBS
b2JlcnQgS3JpZyB3cm90ZToNCj4gPiBVcGRhdGU6DQo+ID4NCj4gPiBPaywgbW91bnRpbmcgYXMg
cmVhZC1vbmx5IHNlZW1zIHRvIGhhdmUgZG9uZSB0aGUgdHJpY2sgKGZvciBub3cpLiBBdCBsZWFz
dCBpdA0KPiBsb29rcyBsaWtlIEknbSBhYmxlIHRvIGJ0cmZzIHNlbmQgc25hcHNob3RzIHRvIG15
IG5ldyBzZXJ2ZXIgd2l0aG91dCB0aGUgUkFNDQo+IGluY3JlYXNpbmcuDQo+ID4NCj4gPiBIb3cg
Y2FuIEkgYXZvaWQgdGhpcyBzb3J0IG9mIHRoaW5nIGluIHRoZSBmdXR1cmU/IE5vdCB1c2luZyBk
ZWR1cGxpY2F0aW9uDQo+IHRvb2xzIG9uIHNuYXBzaG90cz8gT25seSBkZWxldGluZyBvbmUgc25h
cHNob3QgYXQgYSB0aW1lIGFuZCB3YWl0IHVudGlsIEkgbm8NCj4gbG9uZ2VyIHNlZSBhIGJ0cmZz
LWNsZWFuZXIgcHJvY2Vzcz8NCj4gDQo+IEkgYW0gbm90IHN1cmUgaG93IGEgZGVkdXBsaWNhdGlv
biB0b29sIGlzIGNvbXBhdGlibGUgd2l0aCBtdWx0aXBsZSBzbmFwc2hvdC4NCj4gSW4gdGhlb3J5
IGJvdGggdGhlIHNuYXBzaG90IGFuZCB0aGUgZGVkdXBsaWNhdGlvbiBjcmVhdGUgbXVsdGlwbGUg
cmVmZXJlbmNlIHRvDQo+IHRoZSBzYW1lIHBpZWNlcyBvZiBkYXRhLg0KPiBIb3dldmVyIHNuYXBz
aG90IGRvZXMgdGhlIHNhbWUgZm9yIG1ldGFkYXRhIChhbmQgdGhpcyBpcyBnb29kKTsgaW5zdGVh
ZA0KPiBkZWR1cCBkb2VzIHRoZSBvcHBvc2l0ZTogdW5zaGFyZSB0aGUgbWV0YWRhdGEgdG8gaW1w
cm92ZSB0aGUgc2hhcmluZw0KPiBiZXR3ZWVuIHRoZSBmaWxlcyBvZiB0aGUgc2FtZSBwaWVjZXMg
b2YgZGF0YSAoYmFkKTsgdGhpcyBtZWFucyB0aGF0IHlvdSBoYXZlDQo+IHNtYWwgcmVkdWN0aW9u
IG9mIHRoZSBkYXRhLCBhdCB0aGUgY29zdCBvZiBpbmNyZWFzaW5nIHRoZSBtZXRhZGF0YS4NCg0K
VGhlcmUgY2FuIGJlIG11bHRpcGxlIHNuYXBzaG90cyBvZiBtdWx0aXBsZSBzeXN0ZW1zIHRoYXQg
c2hhcmUgdGhlIHNhbWUvc2ltaWxhciBkYXRhLCBvciB0aGVyZSBjYW4gYmUgYSBsYXJnZSBmaWxl
KHMpIHRoYXQgaGFzIGJlZW4gbW92ZWQuDQoNCkJ1dCB5b3UgYXJlIHJpZ2h0IGluIGdlbmVyYWws
IEkgdXNlZCB0byB1c2UgZGVkdXBlIHdpdGggc25hcHNob3RzIGJ1dCBmb3VuZCB0aGF0IGl0IGRp
ZG4ndCBoZWxwIGluIGFueSBzaWduaWZpY2FudCB3YXkuIE92ZXJhbGwgYnl0ZXMgdXNlZCB3YXMg
YSBiaXQgbGVzcyAodG90YWwgZGlzayB1c2FnZSksIGJ1dCBub3QgZW5vdWdoIHRvIGp1c3RpZnkg
dGhlIGNvc3QgZm9yIG15IHBhcnRpY3VsYXIgZGF0YXNldC4gDQoNCg0KUGF1bC4NCg==
