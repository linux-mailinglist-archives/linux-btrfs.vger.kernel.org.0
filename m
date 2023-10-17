Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1B7CBE06
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjJQIpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 04:45:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34F100
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697532329; x=1729068329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tplycmu6EhNk3Fxgc4SmLZLQvUYAHUW0Pkp2TBdtRoA=;
  b=e/9uYeNmOH+EMIY16aclxo5EDAKTH734zcrA1ZzG7o8YmP21IcEmfCZO
   nJKxycJ/ZWrB7YWKe1sxlTpYy/+KSX5S31JTPqmTyMyO/zMbqI3PnL0G2
   lwVA23gTQlKCt69KzjHyqo3aMdBiMAujUH+SqjlP+k7FGrsmx/5g33Qp4
   PoiSkb/6KLKVlRxkry8PE16+F7vSybBdIj+KswoIcqOnT9OGqrjUlYJjq
   QRFrINaC4N9oi9KOrUBTXxv28JA8/pqg+xo4a9sik8EmUCi8DbXCBN/8T
   sYt3juy7pVBFCBfvApO80xqtMD62Tc5ewVrrww2i86n5X5CBJ2loFA2KX
   g==;
X-CSE-ConnectionGUID: onkPSm3ZQy+C0dDeCHqU4g==
X-CSE-MsgGUID: 3jFsBFwJS22f847fGS36aQ==
X-IronPort-AV: E=Sophos;i="6.03,231,1694707200"; 
   d="scan'208";a="246755655"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2023 16:45:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2cBcijez15NvZnFTPNLXnM0vfknHgmRcpDWJwJoNfum4v3ezymML2/FS+P5GawaMBhCQMvfdazgn2oi+0wlFzA0aFLBLqVItVXk33Ejc50kBaXAylwgcKjRBjbuR1eFlBmyu6smafi/TmynnBF4RRp498ejNtgxyvkW7RZ/247FcQcYz7mpRnMS+MhG6zAM/xAr5vPgzHBppkd/QM2FnYUnzABtYZBoskTJXoMR+hbaAqMxIO1lZRzB4F3XB1eYqjgENIH9//96InN5/reKxBxxeh0zhakhfR+P5Xa0AQ3QcfxrL68RGLbVp5oxppypIiDFfwoNXwjpZxbVLjKmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tplycmu6EhNk3Fxgc4SmLZLQvUYAHUW0Pkp2TBdtRoA=;
 b=fzos5bf0RJzXJFORnU98V48UDPMy/V0J4HokjjJZZ8CaNquigSma6HuYKZjlHtrMJquHR+nREEYI6fIQh7pMl8FvDaeqsGp4fPIceWdMmeY3jk32zkThVwoH73Wc0KbRzbK3hkQTqtssdhmldyQmcP1Ou9GUt2iW+IhMqUzgLmv3bxG/rW1ePS5yAqCVPiiQV3iIONb2AqTNLO0Kk1zcfYrHkuc8AB7s81p9zkWFILznKf85e7IoTJYMbYr1V5RBpxXdeO/CWqCTZ/6bLDH25NdN67lACTTB/tYcOipp+V23oWGmXdM3ZyGMw4F+9l6Gi/1JLkuVYG6Xw8s7wR4/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tplycmu6EhNk3Fxgc4SmLZLQvUYAHUW0Pkp2TBdtRoA=;
 b=Y5sEFZcnxoLfDia0KUJcyGc2KWxQxUVlRAgQOovoldtCtE1lw0Rik9kqGLQfyP6Lucs4CYw2xuX18/HXQgShFNTFSwLp2t8HNyQ7dCu+OD09kzAz7pBOQKexMpBT111QHSHu+BBnBXkpEAk9HFtQnm0IUIXywZ6YpfBBI01yz/0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6965.namprd04.prod.outlook.com (2603:10b6:610:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33; Tue, 17 Oct
 2023 08:45:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6%5]) with mapi id 15.20.6907.018; Tue, 17 Oct 2023
 08:45:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: wait for data BG to be finished on direct
 IO allocation
Thread-Topic: [PATCH] btrfs: zoned: wait for data BG to be finished on direct
 IO allocation
Thread-Index: AQHaANAmIFdevBiIj0iK/3bmV/9WS7BNqusA
Date:   Tue, 17 Oct 2023 08:45:26 +0000
Message-ID: <da25d031-1c40-4b25-9b61-a6689fb1e082@wdc.com>
References: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
In-Reply-To: <36d4b7502a8654882718421a18472d41dbc1c83c.1697529529.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6965:EE_
x-ms-office365-filtering-correlation-id: 25bae2a8-5e51-4ea7-fc8c-08dbceed6924
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b31d9cEDH+AOJv5LrMHCwe3zwxC7DDz8H2DUof+9yZ7Az0dOo4o8eOy7eJqF58zuEBfB7McrQ+AwfDeuZjRdStR5dhvSFO+HFqvR37VMSuNNq3nXPr7xiWcxu1WStBSbFGN1S60DshN+KB4skN3z/Ybc8ljQ1fun1ERcJC4xQSDXkb0splbCYHIOBua7idhMPprUvWzwYmdTH6QIh04sjC+xP56grB0CFN4gTfQEfP0HdULo16o+w3QzDU0pMBUOIsH01DVrD168qcX7Q2Iw7Kz9LXqo/7qKy1C4dmPbhzjkRovuTWX6u7OnUZFdZCHNO3ZrinaccoTvVeDe3ocu8sLwFuUVbsGsOQ5oLud7iqytaRNAyUs9xVXk2g31O6qTK5xf51X5eGxHgarQGcNG3tjLvhb0+WzC9wzF10t8yCg8sUzyLCtoX0GmD2AQu45EYzbnmzUWyPfIvkHMBq8pOxtPzdZ+X8NzE4hG3XMM4Ih/KrnqclnJ9nqYk8gzHr7FGz0SI6Xskw2nJ+NjEd01/6baWGj1kGkPt32PItrpdDpBoEfE7QljAhkwLvQznx37wKBE1Ch2rSBQoVgF2Nb5fvBr0s0ONwmxWcp5NUqRsWq6IQ0AOcII5FdleOJdoyk+7MQver6cayaDl258bcNcCvJj7MGPJRaBpPMcflmsb3MLyPMtzIO8hRZ7SJh9s5Pl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(66556008)(6512007)(2616005)(31686004)(53546011)(478600001)(2906002)(6486002)(71200400001)(6506007)(558084003)(86362001)(122000001)(31696002)(82960400001)(38100700002)(26005)(36756003)(110136005)(8676002)(66446008)(41300700001)(5660300002)(316002)(38070700005)(66476007)(66946007)(76116006)(4326008)(64756008)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1FrQ0JkMjVMYVRjMHU4SFZmZ2lUNmlVeGFUclZZSU1OdG55cExYNVVRaFEz?=
 =?utf-8?B?QkwrODFoQnF5ekM1eDluYmJCRHdpejNKa042eEJLUEVSMnhuU1lYbzdyOXBD?=
 =?utf-8?B?d0h1WGFLTU1POEhqbzVIRDdQbVNCZDJwQ1FWQzBBaWFpUVI3MmJiWis0TWc1?=
 =?utf-8?B?MFA4alpyQkpGN3EwZDl1ODN3eTBBcjhpcGZBNTlRWmlYZGU0dm1QQzNWSUU3?=
 =?utf-8?B?eEdkbU9rMzBHZzdSeS8xc3FvVm9IVEpINTB0dmV1VDVUQ0tXYXRWUkQ1K1d2?=
 =?utf-8?B?NG9vbEhtVFJ0UjhVdzNROVZZNmVDc0xGZERkdUdVZmVYY1hUUEhIQW9lMjhI?=
 =?utf-8?B?cGxicXRpSFVlRmZPaEFpNXl3WjJJOVltYWhhTk56SGlacW9hd1ZHSmIzYmVJ?=
 =?utf-8?B?cjFtL1FuclFYTmlwV0hUNjFqcVRucjhKd042OHlaTEh3Nk1ockZMdzFBTlRz?=
 =?utf-8?B?dy9aYld6WHFHWTd6RTQxT3FiNmFnYk5mbnFoSDRJNklHSXI5TXNKcXJ6RmU1?=
 =?utf-8?B?dUtldHpyekpiWkhUdlJDaU1seGZtd3V1SHRYelVrVm1lb3R4TWxvbVh3R3J4?=
 =?utf-8?B?d3ZNdGcxajJYSUdaNHQrOU5vdGs5emdqWml0RmpVNXBmV0V1cVQwcHI5SWcy?=
 =?utf-8?B?dVpvM0J2ZDFnZzZsQXVEMGRHUi9ZSmNCcVdJako3bGdTVUZDZFNlSnMvbysz?=
 =?utf-8?B?bkNQRHAzYnVQTGtvYi9qOENUd1QydmRrQXFOUXVJaG95UVh4NFVSR3lydEhj?=
 =?utf-8?B?ZnBwNjBwUFkyUm1yZkFJdGNjNmhKQmdPaEJmYWZaWDQwR2Y0QllHNGt5Vnlj?=
 =?utf-8?B?TEpYdGE2cWdTV200b1N3M0VRQ2ZRblRteFh3cU1RaEoxYUl6V3NpWnQvWGlr?=
 =?utf-8?B?Y3VsMDVHQ3VFNFdFd0xvQWt3dC82S2M5cDZmcmE4VXg1SE1FZ3dqcTMrcGYw?=
 =?utf-8?B?eHNLL0tPL2c4akNHaGxBaExNWnp2cFAyQXhaVWtlYzJ2bTRLcUQ4WkpGeW00?=
 =?utf-8?B?a1NTMThIcTJ1dEJZcjR5MXFMbHBQODRjNGdHdmpPblZQMFZxMlV6dGxYeE1T?=
 =?utf-8?B?aCttd3NNZG5NN3lJZ0RiMzJWakVPQkxvZkVyZExlZ1NDa1dpTWZWd0xNa3ov?=
 =?utf-8?B?SzlGQTRUMXM3eVplZ1djUkpienFvWmRyUmozMkNNem5kZXg0Z0xBRlc5NmFB?=
 =?utf-8?B?a2F4MXN0MTVKendtUk5aOVNqNTBRaHFCWUpDYnRqYXR3Q2JWMkJMalI2cU5T?=
 =?utf-8?B?cDh5ZW93S1Z4bmRBekRWVHRwRGJUdTl4MWI1MFdLbXJIaHZHdDBxYkRRUTVS?=
 =?utf-8?B?bXBFYlg1MDBRdURTcnBWSjEwMFdsN1ZrOVFtYzJKK05qekpxaWtSRTRDK29i?=
 =?utf-8?B?TWowYjFESGpka2sydGRDVXNhRWVueWRJdHhTRjlZV21qRDFkYnlDNVNLeFc5?=
 =?utf-8?B?VTIycVZ2Z25GMnFjTDcvSzg2SjdLcjd2VFI3aWoxenRzbytZODRxSHJJamkw?=
 =?utf-8?B?VW51UmIzbm5hVWFrRk1ROWJWOUVOWktMV01nR2s3Y1lwM2F1M3hHb3BWaitG?=
 =?utf-8?B?L2dWd2hLOTZGaVFWT1MxYUFlaVZZS01CeDBzNzFOQWdhamVhQlRLbUhWT09I?=
 =?utf-8?B?UHV5ZFVaYzBLaENIanhxeUthTk1DcUtqczFKUlNLVkJsRkJ6dzhYNUM0WGRq?=
 =?utf-8?B?TTRIWGVyMFBxRmt0OGxkTTRGL3ZmTmQ1NEVMNDY0MDFtcUJ0WXVGbStSZ0VY?=
 =?utf-8?B?UmZzUmZUcEtIcytLeWYxdXBXeFVseE1ZN2NkQkxIcWM2dW15UHFoVWdDSFJw?=
 =?utf-8?B?VkFyUFh2NDIvVDVueU9YbGtjVlowRDNta0V5cHQ5ejU0SHAySlJabE1kMS9o?=
 =?utf-8?B?WHRiQ3ZzK2o2VkpHalpuaElDZFhSNVIrbjFrNHk2RzdHZytLL21ObHplVHI4?=
 =?utf-8?B?UGQvVkMxVm9ta3ZZcm5HV0ZQc2ZKblpTODM1OVFEUVcyb2VaNzByYkRGWS9I?=
 =?utf-8?B?dVh1dUhCVDRyWG43dE8vMnI0c2JVOGs2Y3RDOWYwaytHb3h6a0pjb21nRXor?=
 =?utf-8?B?YlZ2QndNdnpRNjlSL2dlQUVDNHdiM0JiVjJCOUE2Yytxa2ZtSHNmS2pWNHVs?=
 =?utf-8?B?UHk1VFo1bVkxanFRN2o2TmFnOExsNm9OTEkwQ2FLYWtQY2dmOVJCalNvSURx?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4219D974447E89478AB23D389D5153A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HrAVwzzBLjPU3j1z1lj7GVTIsp4vFGPEWIT7k1opLLmQKS41jYlCZ/JqHVdq52w07mcX7Ztyb8RStKrdxczKCJx06d08ACIvD9PZr99Yq09MeyZGJpewybgZnSw/Igo8cuFjzZ5/VmacujXznos96uAaUF//kbwmXsmKAyMl+HJWcWShtzvo6/kINUr+GT5PCJ+LkwxCpnzNv6jcwiu7Fq7uHHhmgCg7mY57AqTbRxtk+lp6uiMosRKtbn7XORhJri7sScrQLl6uPcxRNqdCNdJTfQmYKZIJu1SokVlJsW4EpzO+G2wPKIppQAYBV7chqy3VsS4yrIKqXEFImoL6oYXXk0/jGr0OV4YpuCG0K970tm12zIkmALahBQRPfcdLVgs711xHQmZ2ck6JbgorYdKbS2Ojn9EMUqzuYKJ9KHHx1sPxIrNj+isHoD1sX1UujNshXVfpsKC6nNF53/+tMAGj4ojNx+YfSCbR7bkcxIocdzFbWJ7BIgzGDqduYjd5Yg1KVszy/2ge+Q8lSaGHjVozNSuHtKprjMEgKIa6TvrTBFcpJvzJrTOkt2OxggC+eaj5vAPcoP8u+Ph2lp7AWaULZHQauWzkebRCvFaS/xARSL2pvEyhq22P3fJRZzjmGIFT7O0Kxq7Ynx4UDKaiNUa16y4+rxL49s+AWdUe/0sdCuu++QJC5i/fS/aQ0M6JjyIEtpejatG16kloi2besevll4ALmln8Oqs63uVq7NEQyOkt/ecvhWuagPKCnQwGA+khylyJ/XpbFwlmOti7VKlbigiFlPaafONiWczTuQE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bae2a8-5e51-4ea7-fc8c-08dbceed6924
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:45:26.9189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2WhAhjQVSf7VM/7NKGv39tsblCFjcgU/6MmVdsotEFHaZXTwwX7x7VUm2+hwbSd9JtvP/2K58T1WsPI1gc3YAMAqzq60nMPhfZ7iHGvJ4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6965
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTcuMTAuMjMgMTA6MDEsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gVGhpcyBoYXBwZW5zIGJl
Y2F1c2UgLUVBR0FJTiBlcnJvciByZXR1cm5lZCBmcm9tIGJ0cmZzX3Jlc2VydmVfZXh0ZW50KCkN
Cj4gY2FsbGVkIGZyb20gYnRyZnNfbmV3X2V4dGVudF9kaXJlY3QoKSBpcyBzcGxsaW5nIG92ZXIg
dG8gdGhlIHVzZXJsYW5kLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGls
bGluZyB+Xg0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCg==
