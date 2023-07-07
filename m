Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0274AD9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGGJKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGJKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 05:10:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F881FEE
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688721030; x=1720257030;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=A0EQ7BXAA/Mtc7yBE3o1C1S0SXpGC8ANFdTzU+NhbEujJ0WH0AcmNw+8
   g9UTP8B4ZQAg4g7CoWJdT/XCDDdiadneYcWPZKoWMTf94xnpy+7kv5tRh
   xbpjClAGMdYGVTIYq6rAPgwaAqn0zXb1K+TUYxp0GWhhDUyHs0onpWq2T
   Z7JfbyVijiu5M8Jn/zPaM6P5C6Wxqcl+vKnFZifCcBB3qjJZvFT7OTdFj
   j6nIrnw8yiF2rFdds5eJb3ULxdp771zr6yfBZoQNbNNytqZE6djrxAlCc
   duXI4Q3Qcytfbc4dEDcqftQpia9S9Eo0YT+05TmoKvSos90DoADFts32y
   g==;
X-IronPort-AV: E=Sophos;i="6.01,187,1684771200"; 
   d="scan'208";a="242093366"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2023 17:10:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnhFdU/nBiGP0FLkTnDjQjJJha5lbNXkXd77l4deA2sJrgTg2+gEYJTh+QJxtcdo8NA7kd+Zo0M9t/MEdi4O1TzZnQSqAs80lQB12QztSRxstlXXEvxKQ8xd2XiiNvuyavhRfK1aXoHjrE78Sxo5iC0xrYGoF/YB5aCEoon4Am8t3I+0f/cTc8GVI4BR8nLz03i7NUbs7QhHKlZUPzMSuJ0UrvQPCOJjO7lhfKgGnCH4oSpSl+yfEpp10c1CSaSxaGEd8zvtLWMAaJXJg5zoIHX+/bwzx7h3El9TIH/H5b7TBPEHrX0h6Kp4Y9ViutBVYX9Edx5Q9KwcpyGCG1+lKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=A7YBt2KfeT2jD3plB0tTdoN62dyV68R/Dc8HuL27bzp+99UkNZda2nT87rVzPGHCKbpINhNk+G3IXKygybKBUk1sMp/2+K9Yxu/Lc1mKXmMOOFJVu6xLysD2yObQuFMXDKmsk34AR6HNrnYeo5rzp0x58djv6HVh3Ucy8v0KTp52pMXAwGqRaV9pg9nslqgFJTSuB4IJp32+avKZtqJgbbozmZaDexD2K9aps1o9J6n5AaDjy5ztdur0q5YdtW1EDixeDZC4nZekHMNlaqmi3eDU+KG/GRY9SvZs8w2cvj+zSeZHgDBLpenEcka0zIn4exVK4AoegJV/W9g6grkj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IxYLutim4FOzjbf8L5trJ4bfCuC6sJClbJvvMzCsuSSGnR/tqLuwUIUyyfaCkqebxMAwq/ZLvfL1b5zXquHJvdv8b4X3K6/vvKIhP+a7FfU1FyYW5y74Zt/2BzYgrOI3wpok/zGV85knVzFe5kgSMLLftW9Q0Qpd1JSd+jdjvh4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8669.namprd04.prod.outlook.com (2603:10b6:806:2fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 09:10:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::fc3f:4892:d2f7:bbbb%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 09:10:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 0/2] btrfs-progs: some zoned mkfs fixups
Thread-Topic: [PATCH v2 0/2] btrfs-progs: some zoned mkfs fixups
Thread-Index: AQHZsCIbaUYl23K/eUyytG9VN/pSVa+uBXmA
Date:   Fri, 7 Jul 2023 09:10:27 +0000
Message-ID: <f10454d2-e2cd-57df-4ad2-0adc6da24523@wdc.com>
References: <cover.1688658745.git.josef@toxicpanda.com>
In-Reply-To: <cover.1688658745.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8669:EE_
x-ms-office365-filtering-correlation-id: 848d1fb8-1cbf-4ca8-3818-08db7eca017f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jszaYA5WHme9AcEm3iY8FnhABrCWblAjENZVS2cNfgFFpHCzmU7+u5CE8OWl/Ep7v+j61ctbBHD5q7lu+qC4g61+7bpzo4qJvkv1DJatH+Cqi8S8Ql5GAYuezZHIuzKcbdSG4vEiaUlYITaaKIBuWFq0ZrbIJO7/ZoR5IPr+QXHz6f7XoyHiofnr0CyI/Jn75UXt3IL0O0we5L+NiKB/xZpk98h1gEaqLBT7O0l4CpCQ8bC/tk5qSUetXEDqjcYWzMlEKgtibo3ZkAXkc/yjX81ZKNQysJ7jWKGbSbqs3EiszUrWJzfJ/pyqX/B3oAHimOUA3dCJNABOuVKPGAiCdCFJOUvnUwWo/pxaNfFwPewYEem2PkWFj/B+5Toom2W5bhq10DrS+vynbq+wa+S0sf7YNThyBEpbiKyFFEMgTSueeSa7iwjHAG9jz6fRsYxrLc/OIZVvwDPObsCxiX1wTya+CQU4j2dx925UZIV4mb/PYgEh5BxI1lIBB9kJQ6SnxNbilO8HlnqW1j+h9i8pbdjojRG7rDc2iVAMXRaYh3qXnh6xUwOWtBzvqdrn70FfJ9hJx36QUtNb6GBq/ldp5+iu6rzhpANda3n4HwObyQwahM3GIKU0yjtvUAp4N4MUHKBeBF00dhL6JN/hH6blLFCBOmZKiPiJexnAWKt3n1rR1DV1zjZNQQVH6TkIloMD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(38100700002)(2906002)(71200400001)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(38070700005)(5660300002)(478600001)(76116006)(66946007)(66556008)(66446008)(64756008)(4270600006)(66476007)(91956017)(86362001)(6512007)(6506007)(186003)(82960400001)(31686004)(316002)(558084003)(31696002)(2616005)(122000001)(19618925003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhKejQwTS9BU25VSy9hSjRFNEZQb05teWRIQURyUmNWaXRYVGFEalVVQlZz?=
 =?utf-8?B?eTBQRmNFbUZKVzdiWWdSVW1URTJsck5KbnZpTjVsbnlDVlNCWE9vSnRHWlNL?=
 =?utf-8?B?SURlL3lBM2liV2RlYWNnMjdpR0V6c0RGYTNza3IvR2xYWStWbWhrVkJxeHJn?=
 =?utf-8?B?NlJnRUk0WThOZ3V1d1Y5NGNoTTBWbFNWUjFnbms3ZnpUUWpLelkvOHo2OEt3?=
 =?utf-8?B?a3p4RXBlQWJoQklESjBhNEhpNmdoeDZIOENlYWlmUi9Mci9WY29RMS9MMThu?=
 =?utf-8?B?ZEJLZVhSTWJpTlQvU1pxdnljQ3FITkpnWFNVd0pGU2J6ZHZjaitsMUQvSzZu?=
 =?utf-8?B?Rm0xaFZOOFFhZm5iblh3YVA0N2FMTlF4ek93LzRxNEVTWUt5QTlnUk5uVUQz?=
 =?utf-8?B?U09pVXhJK3JncEtSeHhkZHRsdHgybWcrNFFtZlBsd3pub0ZwZGd5dTlXWFFS?=
 =?utf-8?B?bDNnQjl6cE1nMXdiZ0ZlN0cvSnFCUmh6T3BCN001Rk5teFRBc1FlUDBWcG9X?=
 =?utf-8?B?c1VZMC9kUDBRSUl2RGtEampoQ0pkK2ZlWm41Uk4yMjhTcTZYMmtyTVdLL2VO?=
 =?utf-8?B?UUN1d1FzWU1lR0dxWWcxSU5FM2pRSkpyY2d0cEZXeVcwTDBESEN2ZkMyMWtq?=
 =?utf-8?B?Z3JYa210ajZYeURORXI1MnkzZ0t1MDdKTHZWKzNXa2pTUkdUNndUd2NwVWp5?=
 =?utf-8?B?S1VWRnRYN2hsbGE0dVlMbGlNek1vV0ZrMWNmVGlyYVdueUhIQW5YeXVFV2NE?=
 =?utf-8?B?ZmNUaVFmRk8xWHo4T0VZTHlmTUlEM25KczVuWmcraTdCcTI3WGRzNG5TczFn?=
 =?utf-8?B?dnplcWlFNE1TWGNVWVpaUlpWQW43Q0UrZlQrbGtKZytwOExLQTRRdlQ1SEFF?=
 =?utf-8?B?N2ZVSWJnNmtmbC9DMDM3UmpGVk01ZnBIcWhlQTJUZ0d6SmZNZFgwbnExTlZ1?=
 =?utf-8?B?c3JpUk15T1N6OExVWEF4QVhOL2pod2dYSDFqcXJ1Mk5DdkZTb3JHZzhVRzJE?=
 =?utf-8?B?OTVwK3RPbWwxQ3pjYTRVVU8zaHR4ZDlZSW1uTkRNWnpOd3lSYlh6RWNpUUxO?=
 =?utf-8?B?bVV6TWRHbUpoY2pNaklLbEhiWjRvYk91VDBrZkI2VlovOWVNRkMyZ3crOUJO?=
 =?utf-8?B?bnJUWEl6d2hrNlRKbmJ4SVQwWDhHQjdWQlFwY1RzRzRrU2o1OEhNbms3UFV3?=
 =?utf-8?B?WTNHN09ublRoQk9UK2QzWm5FeEVUMVZHNXNFL3B6QnVjRXN0MVN5b0JzdUlP?=
 =?utf-8?B?ZlozaGtoN1R4SC84ZUlhOFR0Rk9oN2hnV3drMVhqdUlpcCs3ZE4vQXgzWGdQ?=
 =?utf-8?B?NWsxVE9hRkRsQzE4dWp6THRDaUJCOENmWjNic3RHU3ZWVkZ2R2lpM0pGV2FQ?=
 =?utf-8?B?NXRpSlRVbER0a1J5UUJUOW1JRG56c3BheEVmcnEwN3gzeHIvMEI5Q3ZUZGdp?=
 =?utf-8?B?NUYzOHZhQ0d3bktYMlhTckN2aVpDbDFkckxNU1U5dXdybnJjaGJMVm9DNE10?=
 =?utf-8?B?L0FtVjMweFZpOG92bXZYcXdjZ1BGb3dKYUpxL085bXZWK0dNL2plRitRbVFl?=
 =?utf-8?B?OFEvMXlDS2dQb00zUDBLK0pYSFEwcXdTRjNId2RweHl3MEppSmsvY0t4VXk1?=
 =?utf-8?B?UERRbTdhRC9mQnE0am1RNmxSTDJrM1dicytTcTlnQ0FxUjdrdHFXbjROd1By?=
 =?utf-8?B?anVBVUNrQ2hzTFRFRmV0OVoxSnlkUmxma29ydHRaOVpNNUZSZzVseEk4bytr?=
 =?utf-8?B?bmplN3BBdklQeDBtNjJwWDV1eUZrWEc0VU9EUTBuWTBvYWhVK2Q0RUx1eGZ1?=
 =?utf-8?B?dmdjRU5GWW5wRHlPcjFwZ3Q1bWFxR2FaUzRGYS85cDFzR0M5U2NmZ3IraTZB?=
 =?utf-8?B?ZEFwVHFURzNCU3F1Mk5kOWh1RVVUcVBMNVpNUUtyenRJdkxsa3ozQXJTaHhm?=
 =?utf-8?B?SEJjOWx3a1A0QjEvVDN6dml0eFkwSTI3cFBqbjdlN0M4ZTRhZGs5aE1CbUFp?=
 =?utf-8?B?UGtKVWd3aWRVMmpsMUhuQ3I0dTlzMlNDZDh4dm5nQnJSajRLd2cxU1J4YmRi?=
 =?utf-8?B?TTZwYlYvdmlsNVpOWmtuZVBtR240OXNCQ0dFbStVcktHUkFZY0VPd25XdU1z?=
 =?utf-8?B?ZEpVTktHK1JDRnJ1cnExNGIxYXBlSE80YkFqbW5JaDNxLy8wdGNiZmM0OERS?=
 =?utf-8?B?SHp1YThBVDdWcHFYRUFOcGdBNVk2c3hBT2dnRFdFZ1NvYm12azQ1OE1UWEp2?=
 =?utf-8?B?RlhyaGRiaWtBYXdtdFA0Z1ZraCt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40003666DF377645ABD408F5AFCE5F25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fG22qJmYO1Nc4usPxsNyDCrvvXIbniBaqvmaDDUDVpanYM+vNKfKRNcYzBKGDI2XL8eT7sN7XGHDyyw86sU8CCrdBBc7vM0MLTU1PWk2NGUwLTtrCAO2qaFjhVEND1ZdwpHA41Ff/KA+GxLf3l2218LmSICyU0DVLKFGbF1C1C0ouUxeeWuPAFPKfdkTO4WC2sZ11lqjPA5UwNEKYAjnuIhYRLJ9PW4rJrRn1DZqY7x8oIIBCYJWEm6MW0HqlTJHFNLbfFe//8cC8xDDdVoSSBxmF5IvKhLORFHLV7dMy2lb7tuDqTsi4myXhztAXHiEjQRw0ThMk5cTtwVeBtPaA5jwLoUT+OqxYboytnBewdJr0QdPnL6D3/1gRQwP4+FeNrbTWjPGpX5FHwTZMRNYC6cAEGmnoFQIwHct3T9TEAjNKkxTmNvBMFLwkooZqsbToKjHx16/ky/SRTDVal1tXEAHKCJ2UxgKAvBFT13hztAY1hRJzZepyeG0BlxyjR35n+tCLVXV6Dp9WOQOSTpyWIUSgIw+LBCgKbf9JWmqI3P8MUKLQ81T6+koeqKS8RCujhVXGlv8Diujk6Fy/Cq8Al6eZA3A0R3aowG6Wb/o04dR76GHtS8GiKSuJ+D7+nG7YYe9z5FNqW/y6MNpLbak9i5IIhQEbxLJDtfCGkUCEYQZHgkvwkpBvL7u2XsiEhUVoIdQpeyx2KSzGsMzJ6Gg4+95Xqm4Zdi/+TvZje3C5AUaYPtca9aHoTJmq+4bdwOxmoeblq6zhlQrV8l0VhmCbGfSQoRD8MWb9g/ZoBJQjgMSaaysztSUpvP3klQ0lHr1Hyp28OD6of3nqNVLXIX3pg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848d1fb8-1cbf-4ca8-3818-08db7eca017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 09:10:27.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tevPbiomEJhNR4/oNst6OcEOyHxO7lTKU/ugVcVEp91zMl6+nndjuncrdENKKnp1OzyL1tSEDHfZlLwm0PUCl+uloMEh565XFBkEzQxnaeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8669
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
