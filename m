Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55174600F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGCPsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCPsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 11:48:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA261C2
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688399289; x=1719935289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+DxwklDS3gbexo18Y15eMkse6O4zIx5Mzi8BRMDkeTs=;
  b=o75ve94ura6OaygSOydafq+723rlNu3E84ojWTUOJQIxUFICfGMAndBh
   Sy0R1b62hjiA3e6FciPd1oN2dJukQKlqCEtC3bEtx0LaMlsMmTaxDx5jE
   Mp99n13TvK7RJXCQbYGszFZMO+X+ufH6VVvteSYg4X0PtadKjw7zzTrJr
   wKXTevUhAFCt+7kjOJE8fs2axxGbqWrBaChnje6VwvOfynRQK15RO8sKu
   AOGXvmQ6Ms8dYza2tdo4pB6OmlhffDLY1ijlG1MhT6YbChsH6QJNSOLrE
   CCfycCFJ7+1xv+KqMO7Ny4Qrcz6m2N9085tO7u5q8oKsAVHKtFJ9RlTqQ
   A==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684771200"; 
   d="scan'208";a="241778913"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 23:48:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI6PwmCyIogHXhLr6QqD9n4Xa41WwV3cssyMiv4IacEXBNx67c5dorRpAsowtlIq2UOouccPs7tp/UQF9YFspJjW0U6yY1vrnltJc/mtmJfC3beNxHDnLhfZe9qiXzsIamlFrRNyvdQ4MC/ZflYchpckbOQ4XQTJRBkmBC0SH/BEp/TZWL6xPsOmpA5jyCapDYxFN+DWahsfRUy7LVoOQ7UIf0yxOXmYRarszLPp3fDmefhePGm2u+ciYouyQ8hffqfzScl7NbJel5eryEXudS1l0rK4nBT1NAU3y995ewbWbMgKMFK8v48gZP5qpD2b1rCsaXn4adWFAOYg5i0YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DxwklDS3gbexo18Y15eMkse6O4zIx5Mzi8BRMDkeTs=;
 b=TgQf233EWqm5JN0mo9zVmOP5FtGbKCJEm6EjKFwlO0qS795jo7iLDhc0iTa6sT5bX3gJ88MuhYAHPGUg5qYI6lI0hvV3iMwbT1Sic76Vrjz3ph3rQ8IkX/w6LEVPN/EBLpxKBSko/8pIwuJWUEFwHTKb5EaaeWSo0cQj+0q3XGyvPBUNC+su9e4UbC2hPc2aR43/vckw31H+M10aJ3D1S1UFhf9WZ8qTSTY/OM8KJ1pavV0Z7pkMA3O/DutJupgsI115utqY2UI4W8B2w3YsUCRMtcsrDehLKsdYigSJLYcFHUbCljgbwSsO3i+Mf8x3nf027YvxAC/Dj7DwlLyejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DxwklDS3gbexo18Y15eMkse6O4zIx5Mzi8BRMDkeTs=;
 b=UCqiaAb7YcFA187kkC85R3E4/db4xvf51v/vTHNVroMss7syhQo+cjZ38g6OL8e7xe4DIYvbcy+2aPYv6utX3khh9fumq2a84l3wbLegss2ogNSYivAt28/YzwL3C4Thek52m0Ih82Z0BWoVEqv48MSs/wJx6jBgZ6NMLgHHB2U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV3PR04MB8967.namprd04.prod.outlook.com (2603:10b6:408:198::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:48:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:48:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Topic: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Thread-Index: AQHZraRBpvICTBNaLkeIplXc4oA8cK+n8YCAgAA+uoA=
Date:   Mon, 3 Jul 2023 15:48:05 +0000
Message-ID: <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
 <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
In-Reply-To: <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV3PR04MB8967:EE_
x-ms-office365-filtering-correlation-id: fcf6a1e5-6b4d-4571-0ac3-08db7bdce459
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6N1jEgXv14kQfoSY4fgGccm0N8BdYjGCJifEjJJFbFNEFXFLgTU4utyPeEUDG+tYoCmhmuCLgTxnwrzVaIkOV/vjkO0SpPRqxW1BwYD9UGG6lMtILHciSkV9sPCAx7jKIUMPbjfjSX7gjveef2QQ9PfPtDVpXMke/177UOpTHFjTs3iBGmEa7cV/GPdXlu+d5vK1YityDtmLPeCOWB0YbmBQAO0glebs/e4S2j0OmL1CHqpaxf+FdP4SKZknaAzULquuzZnrP1mAZQlBNm4GjZob6WkmeEgep+NL+9pcGih3AcNbafcdSA3rTmT9twWlhQqP9L2l5Jqb8isGtzvtnA+wDZSljN1MWTO/9h9oZyY/ZACRyoA4Y49kiadPyJd12rWTTTBBJGHlEUzkEx3wS33NX8xr07P1jkoiXL+UkAakkHJwnzzYBqeZ9fb5bpPlCjLLrsSIfWEjaB2TIIuw6OdfN+yoCIa7L0sAPzH06+1gis3zmSqjKkSXGK0UxNuN30nlXyQCdznNGWFpaYCVQnU5QfsV50Hn1AWPdWKTEAPzIjrA532ZkQ4WDSz48sJXI2WMUYPfDBp0746qHuEVyWUtxmFEU/7sl4Pvh5XRYVuEFs6F6BspWPs4RD7/RgHbjfxII+hwFyrErMjrlq6Gzsax5lL19VjANX87wORFegy9C18VYJruEvVufxAhDNhB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(186003)(2616005)(31686004)(82960400001)(478600001)(6512007)(6506007)(71200400001)(53546011)(6486002)(91956017)(122000001)(76116006)(316002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(38100700002)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1ya1ZHK2FEL0hIT1BkTFFxUVo1bkpQZkdvTVcvRkF2L3ppMDkvK3B4V3NN?=
 =?utf-8?B?REg4VVAvR2JodUhnQ00vWm51Q3MxcHBoZytVTkFTWjlaRWowY3hGbkxPZWVJ?=
 =?utf-8?B?NWVYUU5qeHR4TDJ5bHZ5eENncnFVZzZwQkFicTd4T0FKalIzdEczbVlKUnZ3?=
 =?utf-8?B?RnNKSU0yVXhKeDlJTlh5NDE1WTUrZFU3UGtLVVR6dVdTbU9QVFRYdHExQ24z?=
 =?utf-8?B?NkxQdHl3NnFPaDJEdDBLeTI3SkVaVHpOcTdrQUdRM0JCN1FPMDFGY3VPWGdB?=
 =?utf-8?B?NmFQRldKdnJKcVRZTjNobzVBemRiWVBSbnVYbzlwQ3R6SnNpQWpXRGlwQ0RZ?=
 =?utf-8?B?bW5nUWxkQnZtTzlxT2t6VkxrcnZ6S1RYd0lTNlJCTzRiRVBtdGVoV1g1eGlP?=
 =?utf-8?B?RFJKanFNK3RYSk1QQ2lyVjFQQjhDMHdZczN2WkphM28xQzNBc0ZJTGsxT0tl?=
 =?utf-8?B?MXVuelMwK1NtZUhNZWZ1bURZS284bVoxSEt5ZWpjY0llZmNpdG85RTd5clJp?=
 =?utf-8?B?bmNCbkowb0w4VkwvdkYwRjNnUDNhODRVUXNXc0l6ZDVCYklxdjdHbm5mdlpU?=
 =?utf-8?B?NXFJS01BY041K0UrOWtzOHJwU2pLNGFDcE1qQ3A0djFLTkVmWmYvWkRsM0ow?=
 =?utf-8?B?YUR2bXVOMDY3d3VUWGx1cTY3VzdQOEUzUkorYi9tT0Z3RDRCS05zSDFpWlRs?=
 =?utf-8?B?Z2pmaWNKSWhjcjFaSW9sd3Q5elZYY0UyaWNFeEFzemVHRUFEOVFPM3M4SzFo?=
 =?utf-8?B?a3d0RkFNeVFDSjQ3aFBmZENVdklHajVoYUEvSXNQd2FIK3JzdXpRYk9URm1w?=
 =?utf-8?B?NFc5N1g0dnNBdFE0TytTVzRkaGxzRmFNN2Rnc1VQT25ScFY3TzM0WHpCNDFu?=
 =?utf-8?B?NnZCKy9aNjh2NkE2NFpqcjBnTTJZVTVHc3B3SmVsWnJ1ZWhlcERhMkJiWXU5?=
 =?utf-8?B?a3luOXd3UzBvNjNFQnc2TjRvYUpOcDhiMWgyVGt5TjlZT2hsTmpZby9IOHZr?=
 =?utf-8?B?RFAzSjIzUk1kc2xRcGpISEl4MUhKb0JZaG5TM3NyRTFoTVo1amJXNWFwWWhs?=
 =?utf-8?B?VFo2aytkcjVVQURuQm4rSCtwbFArQWNXWTg1WGlqcWh4c1BrVXNUWlR6QWc0?=
 =?utf-8?B?N3ZrTE5yKzY0RDJTUTVKMytrVm9lUVVLNmpxZlUrUHI2bkgxSjh3anJuRklh?=
 =?utf-8?B?eEZBQTEwZExQVk9rQlZhUU1Vend4NmdNa1NoZmhScnhmNSt1WFBYZmJvUFhR?=
 =?utf-8?B?WS8yazJIcjJRaGtnM1htTzdvZXpmc3RITEZvTTFmM21YVHRsV1NPMUZmVXRr?=
 =?utf-8?B?cGJtQllvY2Ziak8yZkJSRFpnOWRIczA3MGJJdnNCS2hpdHdQcmFQMkorUnV0?=
 =?utf-8?B?K0N2MzdNaWUyZVorNy9MUUdsUG53WnMrb0JnTmx3YjAvdUNPWklhY2JDNmtL?=
 =?utf-8?B?azF4ZXVXWDJLSlJVMUt3a2cwUnd5d3o4YWZHZTFlcWc4bjROQ3ZYWnkza20z?=
 =?utf-8?B?c0pCNFlHeE1tRDN3Y1ZBNytrWWNtVzdUWW5uUHVKM0krSnZqZEhLM0d5VkNz?=
 =?utf-8?B?OGsvZkJPL3Y1TUhVdllsVXNvUlpJU0c1UVhycDR4NzhqcDE5ems1ejJMcWIy?=
 =?utf-8?B?T0Q3ZzBCcUZKZ3VydTVMdTF3cjBtaVVkZTlrTHMwTVB3bWR3YTM5UWpJYjhm?=
 =?utf-8?B?eFd2WTF4Z1Zna1lZaE45dXNabERpQk9ORjRBckFYWUVFek5kMFp1OHQwWjlG?=
 =?utf-8?B?R2JDMTVDbVlITlo0andVN0VuSElxNVFQYXI3YXlFUXlCVlhGRklpYi9wb2ZY?=
 =?utf-8?B?ZnY4c05vMFlJWmRxZHVYazh0MFVNSjIwbUVic2dvektuc3Eyd3dGdUV0ZWFS?=
 =?utf-8?B?K25sWjNOWXZVejVzaVNEMXIreEVOL2xzdFBRcWtDejd2aUVZSDdmVEFxWDNU?=
 =?utf-8?B?WmVNOTBwaHJld3RtR3JBbWU2SzZiOTZqaGoyRkZhVE1WZFp2cWtLUldneUlO?=
 =?utf-8?B?QjNwLzVZWVhNem5rR1FlWnpoT2hFNWZFdXdNRWFuY2NaZnlubnMzZnJ1cUZ0?=
 =?utf-8?B?eEs4Yjg3ZGZBMEFLdlU4anA5OWsrUXlOTmZ1WkVsQnRWTTVqd1NmN3dNaGFi?=
 =?utf-8?B?WW0wUHFGOEU3MTJBTU1yanduSVJCMmhvZXRCOXZkam52UUtvUEZWeWx5VmQ4?=
 =?utf-8?B?a3laeEg2VjVmZWk5ZWJrbFM0dUNScHIxdUpUZVZ3SWNDT29oUEtNZVQzQ09j?=
 =?utf-8?B?SC9IWmVTWm85U3JpN3pUeXZDMGFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB09FD4176326B45B29F508661F396DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nuAjCbUBnu/iFyPdNw8qmOSbcI3D2gIyC4wXrImBbBZ0NO4iMlxC7KVWAFQBb9oAXYVyULAJpe13PEwbSWJRmc7Q6AQR1wGm72h+SntwKNz0AYrYyGpLUsYNqJ7uzVMxjy/ptGKusV60nNUNw8td9kJEzePd5HjtzSG/+MvOTB6VnGg+rGtV65gxiJdpRUQjMsytbkNTht1Zmup5WKYDV6M0qekp8aaKQyAk/P/exm12Vuuxnf27Jq4wIT9YN87Rntg58KECsvwKqEdOHXvHEhq1RJxVOqswEecQwWIuVUc0hTTUBJz4ipwF7jKearszljd7LmxR4Xl6kG7OEBWHgCSwXlbg6RGJ67vSmkEhxgnrGCkOvwqZmZZzaXFlIki2AnTtf5587cQqqjWgEfAKW6IsgOym7MyL4OSHHom+OXgq7/GLmqC92LXyvu/0sOjX00fC1DnqMuIdMmAq2DESPTSXQKTI7nQghlqWkhyqcdoFFI+yym29O9OmaIEeM1RkzA8dLwpNSpOkJMrwkCvtKSrzzaXdzvCV+sKNdIpKjjHfvAJ31OY4fyNP4xkJy9sqYJk27ORtPiHX04rLDCa9sepp+L1kAcM0HWelonunf0UaAQw3pOUjedZlrxxpH8kmyuZ9ZLiWy1S3wGdT0aP6KKI+jx3BOD5mhV2rB4I8KbQnITlVniD2XUcgkuzGbCFdV4JxJJ/6BW4d3ut9XS0ZJwY2uv17aLIi85To/wHfvhHMGn0gR+6dNIDXdoih5F9/1NrIiJLKZRXrhWbDe2nBO8sjAubCDvgSQ/Dq0Z+XjZ1laOmwHzC4upKDKB46tfWJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf6a1e5-6b4d-4571-0ac3-08db7bdce459
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 15:48:05.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcH/7CYcbzksR7mOg8IvrHejzWHzEMzHyD0ffOXlqw874fG3JbVKcbHXN/tfkw3OTEJz8N1dDmXASSYyzRw/9oYeSXZZwBycp5+KN8HOKGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB8967
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDMuMDcuMjMgMTQ6MDMsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzcv
MyAxOTo0NywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gQXMgYW4gb3B0aW1pemF0aW9u
IHNjcnViX3NpbXBsZV9taXJyb3IoKSBwZXJmb3JtcyByZWFkcyBpbiA2NGsgY2h1bmtzLCBpZg0K
Pj4gYXQgbGVhc3Qgb25lIGJsb2NrIG9mIHRoaXMgY2h1bmsgaXMgaGFzIGFuIGV4dGVudCBhbGxv
Y2F0ZWQgdG8gaXQuDQo+Pg0KPj4gRm9yIHpvbmVkIGRldmljZXMsIHRoaXMgY2FuIGxlYWQgdG8g
YSByZWFkIGJleW9uZCB0aGUgem9uZSdzIHdyaXRlDQo+PiBwb2ludGVyLiBCdXQgYXMgdGhlcmUg
Y2FuJ3QgYmUgYW55IGRhdGEgYmV5b25kIHRoZSB3cml0ZSBwb2ludGVyLCB0aGVyZSdzDQo+PiBu
byBwb2ludCBpbiByZWFkaW5nIGZyb20gaXQuDQo+Pg0KPj4gQ2M6IFF1IFdlbnJ1byA8d3F1QHN1
c2UuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiAtLS0NCj4+IFdoaWxlIHRoaXMgaXMgb25seSBhIG1h
cmdpbmFsIG9wdGltaXphdGlvbiBmb3IgdGhlIGN1cnJlbnQgY29kZSwgaXQgd2lsbA0KPj4gYmVj
b21lIG5lY2Vzc2FyeSBmb3IgUkFJRCBvbiB6b25lZCBkcml2ZXMgdXNpbmcgdGhlIFJBSUQgc3Ry
aXAgdHJlZS4NCj4+IC0tLQ0KPiANCj4gUGVyc29uYWxseSBzcGVha2luZywgSSdkIHByZWZlciBS
U1QgY29kZSB0byBjaGFuZ2UNCj4gc2NydWJfc3VibWl0X2luaXRpYWxfcmVhZCgpIHRvIG9ubHkg
c3VibWl0IHRoZSByZWFkIHdpdGggc2V0IGJpdHMgb2YNCj4gZXh0ZW50X3NlY3Rvcl9iaXRtYXAu
DQo+IChDaGFuZ2UgaXQgdG8gc29tZXRoaW5nIGxpa2Ugc2NydWJfc3RyaXBlX3N1Ym1pdF9yZXBh
aXJfcmVhZCgpKS4NCg0KSSdsbCBsb29rIGludG8gaXQuDQogDQo+IFRoZSBjdXJyZW50IGNoYW5n
ZSBpcyBhIGxpdHRsZSB0b28gYWQtaG9jLCBhbmQgbm90IHRoYXQgd29ydGh5IGJ5IGl0c2VsZi4N
Cj4gRXNwZWNpYWxseSBjb25zaWRlcmluZyB0aGF0IHJlYWRpbmcgZ2FyYmFnZSAodG8gcmVkdWNl
IElPUFMpIGlzIGENCj4gZmVhdHVyZSAoaWYgbm90IGEgc2VsbGluZyBwb2ludCBvZiBsb3dlciBJ
T1BTKSBvZiB0aGUgbmV3IHNjcnViIGNvZGUuDQo+IA0KPiBJIHRvdGFsbHkgdW5kZXJzdGFuZCBS
U1Qgd291bGQgaGF0ZSB0byByZWFkIGFueSBnYXJiYWdlLCBhcyB0aGF0IHdvdWxkDQo+IG1ha2Ug
YnRyZnNfbWFwX2Jsb2NrKCkgY29tcGxhaW4gaGVhdmlseS4NCg0KWWVhaCBJJ3ZlIHN0YXJ0ZWQg
dG8gc2tpcCByYW5nZXMgdGhhdCByZXR1cm4gRU5PRU5UIGZyb20gYnRyZnNfbWFwX2Jsb2NrKCkN
CmluIGJ0cmZzX3N1Ym1pdF9iaW8oKS4gSSAvdGhpbmsvIHRoYXQncyBhbHNvIG5lZWRlZCBmb3Ig
aG9sZXMuDQoNCj4gDQo+IFRodXMgaW4gdGhhdCBjYXNlLCBJJ2QgcHJlZmVyIHRoZSBpbml0aWFs
IHJlYWQgZm9yIFJTVCAocmVndWxhciB6b25lZA0KPiBhcmUgc3RpbGwgZnJlZSB0byByZWFkIHRo
ZSBnYXJiYWdlKSB0byBvbmx5IHN1Ym1pdCB0aGUgc2VjdG9ycyBjb3ZlcmVkDQo+IGJ5IGV4dGVu
dHMuDQoNCg==
