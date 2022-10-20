Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB4606505
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJTPuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJTPuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:50:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F72201B8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666281000; x=1697817000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hcuEc7ZzPTfLyi+sAhGTeqP8d3Br1LTnNUe79tCOgQQ=;
  b=eor+SfvyvSDISFZy4slek6pl34RHSDHueuK/glkkCQblSdSW7z9nhQcG
   uyDUM8s9kU/9/hVTXWOmoBv+ThhyzUjh0XmnbU6JFy0gUQyeLVnN4Ty4i
   YA+ssZVSAoiwJ1OGfuIUyo7I2PkYPCndQF9C3GAgvm0+lfYyWmVpgRNUm
   Ye7Dpe12pXxnNy1JSHBCq19YIOmaZsJWfCqDQMz64n0n9qZiNgiPKGmPT
   lsUTl5Mj5QEDdIOZsxcJBRuH5n2T10tBwkpBVHBqw7XAdOF3/onGlUYNL
   4UwIHiGweiBCMrHZuTRTIswjzcUGzMJ2MHQuVLDU84jGF8nUcd9smpE6o
   w==;
X-IronPort-AV: E=Sophos;i="5.95,199,1661788800"; 
   d="scan'208";a="219501844"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 23:49:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewjagaPi5jrVi1op9CCf2wPDMvXTVl4wJRtyIEY3n4H4PY7SgszHi56NHW3i1daWikqIdYLu1N9JinAGITCLjmRx9NCVR+04lbUbsuH8UWY6LykQHbBYukqsAqpPRzNgWL61uud1okqtZ5zC2pc4o3H5sDCNbmzPNZ8OVshhbgkNIS1S8/YhaqzIApbixyJRxLuJx0sH2bfWhSyZajHGTkdwPsr3iFVb/qaT83ATdlXZn9DZptP0e88efpBSy0jZcKQm7UdInjjAZLrmCgu7Q5enS9YRxwoYWJKE5CBmiLH9cMGFftTECW7o6aVwWjhFFN69cGPdyXMvRrqIpjik1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcuEc7ZzPTfLyi+sAhGTeqP8d3Br1LTnNUe79tCOgQQ=;
 b=LfqrIwR5FAYgKG5xwu7fONij2vbsbctw8+ja4yn7dKgv9YHMXEvkI3gDvt9RsfzHQnqwNVwCVXp8/R3duzRLboncbf3T3Bec7n2ZHOZaSRz6pVqSfvi3HpA/n7J6ApS/lKEsXHaHvfp18+l8/le7yRtLOtwbTncnAJgxesUUZIoDhFErtNwzPhiYSj6q1R2PGZtR8QVJUTXsajpMKmDHjWTRabhJloNlqgQmQCjx21s56ubpV9DYmo4MdlzJqebLz62RKrz4QlIIbeuV+EZ8ff3QTh8QPkgBBEJseGekfV/3xbEgc4PajkZ0CsJkVrUfziCwJTQtdpR5gTQYA8n3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcuEc7ZzPTfLyi+sAhGTeqP8d3Br1LTnNUe79tCOgQQ=;
 b=iNfdmtwAbs95nT9mqukhxObt0swetgKfj3/Rwjh5DQzXdNZ5WUNUJNxV7scuIFZVDM3Uq1dip5YtgZcFiiuFb+HmrVB3N0KjZ05IBa75o8ydoazJyG2RAGHMTZvXVxRK51vLr9OPcY/vvPRn2rzfKgCc1eboqb3043YS0zyHx+0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4149.namprd04.prod.outlook.com (2603:10b6:a02:fc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 20 Oct
 2022 15:49:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 15:49:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC v3 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [RFC v3 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHY4h9gDYoij2zi40KD7JOXsGzTeK4XaueAgAAIDQA=
Date:   Thu, 20 Oct 2022 15:49:57 +0000
Message-ID: <90616fb4-1342-4a2d-b246-958623983574@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <6ca9b49af62a15f7a3482aca3f2566cc10ce8330.1666007330.git.johannes.thumshirn@wdc.com>
 <Y1FnY2PAe14ClUNm@localhost.localdomain>
In-Reply-To: <Y1FnY2PAe14ClUNm@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4149:EE_
x-ms-office365-filtering-correlation-id: a2f381c8-b6d0-4aab-8ff0-08dab2b2bcfa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9fySZQ4Q3l6eFkQGC0OudcXTXJerWiMObhrjhVWQnFVseoyaAXGkLiZMSEZp9N+r180POqybXx0QThBWiF3YtWIbZ3zu+Pgoywl1HDGFHuc/4ypnJJy1yAeXB2RXV2BPmzpGRAUfgmHUpKtJaYOR9vyRNXPUeRODAHcOxJ9QbpQjLoQ5v4e7bdvc7kgvCUKuF5uuBeoTl38WT72a1ul28J1lK46upxgcd8ljB0U/TxYX0dxR12bGBrYkYOH6eVOkDCagh1Nly72x93DkzrIR7rrP/EBR7zc6jdML9P/xVteZoKU0v2gDftwP39mWm3eKcPVIBGWTXxCxnQcapmNxbedtI2U3xhZ2TTyJ9tpUYV4FuKuSlhdXLcVGvUuCNXk2Gaps82RRs3kz38h3sPBcn4GpaPtrUWaLLUxnPXb/JpctHfrdjTeyFNrRUKH9kF8CImgoWXgVBjHzgfgWtlScp6wSGca5RMB725rvJKiJRmxrG5IrdCV1HBdYMZkvK+lGoxo6Hl8xhHRk+KHkmykNVgnh+XbbrUpcFvPVj++auvtgydvHj+FGPGi87grmg8REZF4/rIrU4UYm1VM3XSzulALi0/jksLrzadX//Lw2qdcJLp84eBJPZgky213KBlcX2/glrYERmoDctbS9ChGzts0nSX3C+as+nCL9wbbzUPUKnuGf4dxim1vvfe9nwUm1aFi3DUsB3SUgx1ROoDE0dU25HD2mUGbCBf1gtLJr72zLx9LMLlx4ISIUNOxLVRtaFqIxt1AZqdprSlVh7t5R3BqcEfV7hiwjUkSUwymCoIQ4irwuRxRYVwli42XBfxGfToqdrqQZRo5aqV8k+ntJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(53546011)(6506007)(4326008)(86362001)(5660300002)(38100700002)(82960400001)(478600001)(6486002)(71200400001)(38070700005)(76116006)(36756003)(66446008)(31696002)(2906002)(122000001)(66946007)(66476007)(66556008)(4744005)(91956017)(8676002)(8936002)(41300700001)(6916009)(6512007)(64756008)(316002)(31686004)(26005)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1EwVmEzOVFUUWxFWGRDYk5oWjJyeFVxRXlnUGVsSC9Kbm5iR3pTREVsZDA0?=
 =?utf-8?B?V1MzWWJDc3o2Q0hvL3N0WHYxVlpVeWZkOUc1MHZHdi9RUlZjK1hFb1ExUERJ?=
 =?utf-8?B?ZW1PY1ZjSzA1Nm10eFdBRU5nemNQQWJHV0ZRdmIzdkRRNVJVOVFhemdoK2pQ?=
 =?utf-8?B?QUJISm54Z201Rkl2TkFNZTBZNDUxRjVhQ2YzbXhHb0IrVFB2bXNLWEhPQXN2?=
 =?utf-8?B?RjcxbGhxNnBZY25NcXh6K0FjdzNZbS8xSmY3dmdrb3JBeXU3Z2NzYkJyZ1Y2?=
 =?utf-8?B?cWtSRFVvNmpGNm45WFkrM0oxMVRUUVgxSXpwUXpxUDFQbzlwQnpJaEtpRUl5?=
 =?utf-8?B?ZUlwV3RlVHltWGVCY0pjR3Zvc1NxRTI1RmF1alRrVXdvd0hDWHEzdkxuNDl5?=
 =?utf-8?B?d2U1U2JnR1RTUHJLRncyTXZwYTBHTHZYTTlERHdsNWNCWm5wTXl3ZElqTi9R?=
 =?utf-8?B?ZExVR0Frb0w5M2RITXBjMllPWlZpYTRrSE5kK3QyQzh5ZlAzYjBGMzltdzc5?=
 =?utf-8?B?TCtvQ1FOV0ptaXBEYUtaVkJqTEdndkJNUk1jMkZ0dHAwRW4raThva2lDL1lR?=
 =?utf-8?B?ZlEvcEozOHMxSStxRFExWGEzM094Q0JaWWxHckdreGxlbFBJS2J2L1QrQ0lh?=
 =?utf-8?B?Z2RaZVpURlB4alhrVVJza2JYR0JXb2JYS3VBY25mYm5oVnZGQ08zM3BRMHlZ?=
 =?utf-8?B?MklMQ2xGdks5aHdhTWRtK2tXZEV4YXJXT3h4NzdFVkVWbEg3RWJkS2hkYi84?=
 =?utf-8?B?Zmg0ZndlUXcwU0t0cmlhZExsb2JKY0EwandVWnpuVGs3dDdTWDFINmNOUmVQ?=
 =?utf-8?B?RXJJajQrOEdaaCtqQVBFdnpFYnlJd0MwdlE4Rms0RTZKeklibCtMWm1VS3hX?=
 =?utf-8?B?ZnRZOCtuWTg4TUd5TEUva2ZqdXhHcU0rVi9UMUZZeWN6MzJhMjBGYzNOVVJt?=
 =?utf-8?B?U0ZKZjZpV3JRRzVWTlpCOHVENXAwYVVKR2xRc0oxSm41RnYvUUpaV2ZYREZF?=
 =?utf-8?B?UUJCV2o4Uk1XalhXc3p3WDhBS3JxNkxsUFJBaCt5VVorMkxtVzVXTTlXY1NR?=
 =?utf-8?B?Qm5EOHFnVXhGWTY2ZXpqek5Yb1JhU2RjRjgrSTdOYTVaSEV4UDRlUnhtMkh0?=
 =?utf-8?B?azlSL0cra0NBNnUydWVHbHdWTi85VHp4ZmV5Q0JPWkZpUzdlZVlQNThKZXVK?=
 =?utf-8?B?alBrVkoweXJWb0JkVUlIM0UzenNjSWxTOVVyVWtvNmNVQW11QVBtY0RvbHZR?=
 =?utf-8?B?Z0l4alM2cEFiTUdzUFEvVjRhZWJJVzIzcVNFNUd3NUZyamUvelRrRkJHckVF?=
 =?utf-8?B?YzcwaVZPZFNYb3czM05wVk1aUUR5c25CUmJRRVA5eFNiWVBwYVlEWlR6NFBk?=
 =?utf-8?B?VjVJNWFpSnEvdXlvYXJVNVpXclI1Y3p1SHU4RWdLN3BQWjZIY1prcTBBblVU?=
 =?utf-8?B?enlzU1ZnWEtBWldEcUg3M0k5KzVyOWd3M1lubEdxdHRNMHB5M2lVMVppL3kw?=
 =?utf-8?B?QmNBamZZZUZSWVpkdCsvSmdZdmZCTW9wQTFQdDNqNTRWZVIvcm9FN3A2aG4r?=
 =?utf-8?B?V1AyN00rTFNJZzZIS2U1WUJEVWtuVnJjYTd0K3FyNm5DSW5PYVpSR00wbjA2?=
 =?utf-8?B?UEtnYTZ0R0JORS9kbmw3ak5taHZEYmxqdytiQzRqalVXN3Z1MFdMbjVUOGxi?=
 =?utf-8?B?aGp3OEhMdU9zcmVwT2ZITlN0YWU0UTRNbEk0a0k4ckpNeEtYb2R5Y21EeXIz?=
 =?utf-8?B?WDh5eFFBWTZMNFZ3eHBERk1XR1dSSTdmMGhvcDh3OU4vUTFhRWF0R0dsVWJ3?=
 =?utf-8?B?VXNYd3FvM3BDdldBVXlocmJpYkR3K24zTDVHbEdOUEdXaVNyVG4vejg5Z295?=
 =?utf-8?B?V1V2dndkU09meGl2Y1M2amF4ZCs4MGgxeGVwQVNhcnpMdW1wTGtUWEhkYVBY?=
 =?utf-8?B?bDM5aEZRMitOUisybDREbTcxSjM1ZmF5TWRwVlBudFRwQzFhS0lxdGt3ZEY3?=
 =?utf-8?B?eG5RQnh4bExxTkk0NXZmN2RpekF5NzBXQmdQNFJKNnFWN3dwdUx4WGw3ZGlu?=
 =?utf-8?B?NFE1MlM3ZFY4TWx6eTNyNjdDU2wwdzN5OWFwcWFmeGI4TmhxV2lvclpOR0xZ?=
 =?utf-8?B?N3h6TGJqQk5NRCtFSnI5bDFFTk1TOC93eXZPOVZsM3FHRmYrNDJjMEtUTktr?=
 =?utf-8?Q?2kwV/juMEh9dexdFZR8PuiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C45951C6A44F94AA3F7C77B974C39A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f381c8-b6d0-4aab-8ff0-08dab2b2bcfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 15:49:57.0650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRG0kMFHSCLwdfSbqrkOCq/zN6lIaSxnCC43iAPGS6ioqg/ddaOkgGnBEQ3zuxzc+Ch0IlX2yHNAAQ+k7VCS6pFNEJUNju6RCqztowG8yqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4149
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTAuMjIgMTc6MjEsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9idHJmc190cmVlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnRyZnNf
dHJlZS5oDQo+PiBpbmRleCA1ZjMyYTJhNDk1ZGMuLjA0N2UxZDBiMmZmNiAxMDA2NDQNCj4+IC0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC9idHJmc190cmVlLmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC9idHJmc190cmVlLmgNCj4+IEBAIC00LDkgKzQsOCBAQA0KPj4gIA0KPj4gICNpbmNs
dWRlIDxsaW51eC9idHJmcy5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPj4gLSNp
ZmRlZiBfX0tFUk5FTF9fDQo+PiAgI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5oPg0KPj4gLSNlbHNl
DQo+PiArI2lmbmRlZiBfX0tFUk5FTF9fDQo+PiAgI2luY2x1ZGUgPHN0ZGRlZi5oPg0KPj4gICNl
bmRpZg0KPj4NCj4gDQo+IEdvdHRhIGFjdCBsaWtlIEkgZGlkIHNvbWV0aGluZywgdGhpcyBpcyB1
bnJlbGF0ZWQgYW5kIHNob3VsZCBwcm9iYWJseSBiZSBpdCdzDQo+IG93biB0aGluZyBzZXBhcmF0
ZSBmcm9tIHRoZSByYWlkIHN0cmlwZSB0cmVlLiAgVGhhbmtzLA0KDQpObyBpdCdzIG5lZWRlZCBm
b3IgX19ERUNMQVJFX0ZMRVhfQVJSQVkoKSBvbmx5Lg0KDQo=
