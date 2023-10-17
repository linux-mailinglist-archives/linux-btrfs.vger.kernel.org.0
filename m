Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146137CBE00
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjJQIoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 04:44:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416A48E
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697532241; x=1729068241;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=h4PXqPkjpt9yy2rqVc7kAv9VnvMhrUSUTkIDdsftoip0assTOT+wAMqf
   WAar0XcyB58dNzom7kL+h98oTv3rh7EMvz2SeIFahh4y6NC+dLFCxGycB
   W0AFEroC/MvXhRfRvzNGwf7V93hPUrmNXl4obCrr4Dkzybc45c3nQMWQQ
   MpTW4sotyucEJwSgrw/QWsZJkiA8k/FV53jZ8Fg4nEGsBHim6mC4Aica+
   u04QQep8bOyW6Km4/JPM4G3gwkHjNG+1XC6qvTNBbLTeJZNJOt2ICVd8N
   jC0PeneKzyhFQRcyrjMuoZHXAyzqWvCghMqtoIneMeFROa+nuONlizBU+
   A==;
X-CSE-ConnectionGUID: zprzmF7HSMqxMgEJ8N+N/Q==
X-CSE-MsgGUID: vNEcHVzFRUGq1OPDZLaT8w==
X-IronPort-AV: E=Sophos;i="6.03,231,1694707200"; 
   d="scan'208";a="244815144"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2023 16:44:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+HwkGmrCbNGkYk9fxZS54KmAijQkV+FeDGdDWlhoP0u4VpXXJKner0tSDlw/AFF5X4ybhUS7ZUx3Yiym/m7Swx2qA/bc6iQy6wxI+aZyzM3DTqgHcyojNV7e962plYUYCoGlGefcch0zUdy3Mt6vRoZ0XsJ2dG9/vUCYZ46zMKhQLpSLF6gfFXytLg5bO5VC+Ut+n40IxKiIZXqCZYi+sjBRGyPGZ48I+8yLxfmeCI58NUl7OkZ45HbTzZK0gsEBSwjRUw1n3TIxzl/JSDRo5hzAaPriGICiifP5E+ekFiFVmfkMRIniAWESH/LDht2Ne9KQZcVIRgPugBMLR+ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=IXpJMiZ848BkmOJOWWkpAP80PU/2IA7UJVFW/DT9tUSsSHm95suQ8R7P9eI7hgjOfrXKNkvZrYIr54KyOaCUmotFm1mxsrLEdajdlEfUbeGnT33Vn0eFv1s7YXI3yu9Fj3FJQsIj+E3PeAydtKSX9dxXE2/t9UI9y1A8BPmY3Dy+bh46Irh+HRigrpnVPhFTeqY4zZMpnhM0nDLFruAW/pUvBDvn36zP43SV1QznZFtJx/QmvNBml3WFUKN13DvCV/oESLoIZgmq9qK9R45Cuzbww/d3pMcUKlhIuXWvXZPwoYbEmFH2JSWaoI2irXhzeTit/fgJ4XZKaGb4ko0lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=TDVKaleWrHOns4sGfcJpcbSuLBZ62HxWgpA6Dy9jVoRzYYMyqPr6PB6PF+ZeXbcvUVG0s21TO0TuUcdVL//4GU6kz9pZ0sKNwL1vPtFvX//4uVLfTd3JZ3RL+4WJzik7xh4I8+x8Be1V06nCu6jjMOCEhUIWyaePY12VGU4GGxs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6965.namprd04.prod.outlook.com (2603:10b6:610:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33; Tue, 17 Oct
 2023 08:43:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6%5]) with mapi id 15.20.6907.018; Tue, 17 Oct 2023
 08:43:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: drop no longer valid write pointer check
Thread-Topic: [PATCH] btrfs: zoned: drop no longer valid write pointer check
Thread-Index: AQHaAMrcNCi+nU4v8kiwOeLbRcS3V7BNqosA
Date:   Tue, 17 Oct 2023 08:43:56 +0000
Message-ID: <fda4a125-481b-417d-94ec-c1e402b94a09@wdc.com>
References: <c3b77b1b1b0c33ad8e51d055b97dde3d1874669e.1697527349.git.naohiro.aota@wdc.com>
In-Reply-To: <c3b77b1b1b0c33ad8e51d055b97dde3d1874669e.1697527349.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6965:EE_
x-ms-office365-filtering-correlation-id: 1f924b72-9364-4f8b-2164-08dbceed338d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJ1uZZsexrpqoMG0MaYBP5L1ztOljxldGeD8JwWYQheUm188TJYtXJxT2I7/61Did/n5IRlcAFDFbNjl38Is8uuWY+IIEqXq6coosICrga+4ef7JiN2Omhw0kisqIEjYY0aA6bGu4BZHG39TAu0Sj4KeEq84ag62RwDow0J+9EbRJDJ+IAy0QWI0Cq+brbJswfJF7PMPNM5qEEqo0Jp0mT5R1ILc4epTmbg7a9HrScWCdtaaHWtjd1FgCaDwpIn7o6AUe7DjNHC4a+P6QYi+z+kMhh+xf7uJ5dTWnV8NlSPToQ4lJ7wP9gGS1IsybKNvyy+Ewc7NL3YYyvplyksOkYzyN6TMNXa/pvjFoSA2glB7LbkFrt+L2OtvzuKXXFnEdB/hdqY3908DH3p+9wymmUiF+VmVSXm7Y4Jd+qxa58/djzllbqp7QFFZyYbGGsRrwz8jXZNqDXfqvPmjOmn6dbfwy0pKMCCXelC3GkZ+42jMM9W584dTzcZImKEq+N/bb3JRcin7sbxmaqiZWq7j+xksOHkT/jRN/faE0G/N1ggATp1fZyUc3XDDqJGQhquWMvGtK/XWgrEVjupIgaYAQF7m0UVBuzi4vgATrXa2wM/zxz+2FaULx+VRwhNJ/+i/lmvuHd6Yfc7iJRQhKHlbP3ZD+9KXIX+kx32fiJNa7uQWduCDQY9ik/bjR/Uf5AjT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(66556008)(6512007)(4270600006)(2616005)(31686004)(478600001)(2906002)(6486002)(71200400001)(6506007)(558084003)(86362001)(122000001)(31696002)(82960400001)(38100700002)(26005)(36756003)(110136005)(8676002)(66446008)(41300700001)(5660300002)(316002)(38070700005)(66476007)(66946007)(76116006)(64756008)(91956017)(19618925003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDhkelE1TTZwcU1IRGxmcS81MXhuSXhoWEZJa2RpaVBzQ0dHbndPYkx5VEtT?=
 =?utf-8?B?L2lEUnJndXU3MStrOWQ4blNvTVh2WVRPQW1FcE1lUmtDcW5GUStCa3E0NjNa?=
 =?utf-8?B?eFQyc3lHQnQyczhZdGQxSzRnQnQyMENuR2FnUFpZODBjcmlRTVFiL0VsaUxF?=
 =?utf-8?B?aHhXOGcreks2MkYyMlhhRUJscE9CVzZ0TDE2eXkybHBnUEpoN2d4MXhGL3ZB?=
 =?utf-8?B?dEE2ZEJSL2d4V1FTRittb0hkU0tIY2pjY2VZU1hXN0pVL2VwY3l0cmVZb2k4?=
 =?utf-8?B?K3EzdnU2UTVJN1d3NFFyZjJwYjViS0xPY09WcFViaHZCV3ljSUNtWStwK1dm?=
 =?utf-8?B?Yk4rQXB6Z1JlQ0RyaTQ2dVdDRDBaa0U3dUJ5TXJGWGxjbThsUUNKL0xPOGwv?=
 =?utf-8?B?bEM4OUFPVUh2VS9tcjRlR2RRQUhESHE2cjVsd2dub1JZQnNwSVBxT0x6VVJY?=
 =?utf-8?B?TUpWeDZVd2Z1RlFUWjJvdjczQVd1ZlNPeGN3SVhTRzNBT0NDT0ViTVErSW9U?=
 =?utf-8?B?OWdTemNyelpGSld2T1lQR3FrOXc4M2pQTStWcWFQTjYrQzFJT2IyUzVaY2lO?=
 =?utf-8?B?TzJSWlBCTExucnRxVUE2WldkYlNZeFBwNmFXQ1hLOVBqL1FSRWZkZmFWMlEr?=
 =?utf-8?B?SGJSZXRrNWswc0swZU1seFZJU3kyQjhYbVIxa2RtVWUwS3YzNmNHTFdOeTRw?=
 =?utf-8?B?blR1NXJiQ3I4SzUvOWMyNGIzU1RrRWFMMHlSdjRvaUl4MitFU0FQZGhzREFY?=
 =?utf-8?B?aVplVVNUMnJjamdOU0VNdGY4ejFjdE01OE9CRlgyeERmVHNZeE9KSHpLZlFW?=
 =?utf-8?B?UGQvOXlEN0lLZzFtVThDSkFWaDJEcTZhcEd1TjNqZExoOGlwZHhUaDhXTUVS?=
 =?utf-8?B?WkkwMGJ4cStoSlU1L3pGVERSSHJ2cVlXUFFpZEVUc0JYM251MVlGMjhKRFJ3?=
 =?utf-8?B?eVhyQ2M2MVZiOHdYbHlPNWdIZUoyTGpvTWpsTzhwK2JsNGNtTFp3V09EUE80?=
 =?utf-8?B?aTd0RCs4V3UzM1R5MVQ3cGpyYnlIbzhyalljZzlRV2REb0FhOWdrTUZ5elVm?=
 =?utf-8?B?ZkNaTmViR1FWSjJIMlFnMFY1WWh1QlZHZWVhYjFHT21JQjVWKzVId2tLei9u?=
 =?utf-8?B?UkkzK0R4dUFNMG5DUlIycGpFQ2UydHZhTmtXV2VXSk5GeFNsU2xXN1EwSFBY?=
 =?utf-8?B?OTVTQWMrOWQ5NEZBdGRZeHdxZGdhTkxtL0NkSG9DUUJZSEtxbEFteDlPS0dO?=
 =?utf-8?B?NkFWQXVOY3hzYUUreEhnR0svMFZ1NmxWbXNLT1U5Z0JwU0tka1RIMVZTSDdL?=
 =?utf-8?B?RFIyOWtrL3Z6VTJ3MFYybkZUcE5DbzFSNlZSTWRCaEhKcnRCdHIvM2xodFo5?=
 =?utf-8?B?b3VGaG1idzV4KzkvS1o4TW1DeXlvOXlpcjUzMWYzUEd3ckt1SlRsV2EvYTRw?=
 =?utf-8?B?aGR4RjRiUUhTUm93THk1K3JvTzRCWDZJL0FQTjRtdU44WFFLbG1oRjZ1WXlF?=
 =?utf-8?B?akhJRVF3MllJQytEYmtSelpvNFQ4ZGt5R0Y0M3dRM2l4VVJGZlJRdnZzQXpB?=
 =?utf-8?B?eW4yK0Z0cnhGZE9tcVExMmx5QjVDRFN0T29oOXE5SVNaRkJGdmp6RkxMdXo2?=
 =?utf-8?B?L2haWUlqOHNkNERuamhkNEg3VVNWcFZyUnJraHkwaXNYZDh5cEl0Q3ZwdTVz?=
 =?utf-8?B?UmZzVWJzUFZScFpFUlc2eDhURmxLUnJ2TEJOK3l4VjRTUXdqOW4xaW5HaW01?=
 =?utf-8?B?dWpQblRvZ2RFVjg1R3Izdzk2a09lRGZGdllHaUJCRjk5T0JjZ0N4RTRzcGVa?=
 =?utf-8?B?YmdGZkJqUFdVbmhGWm9zSWxHZ2ZLNkNqRVdsdWdSZmJlMDRtQ09FbXFmTjJH?=
 =?utf-8?B?Y0p2ZmJEZitvMmMyS1VhUGd5bmU3WWY2NFhFWDYyUFQrMisvT0JDcDVNSzVm?=
 =?utf-8?B?ZWlxOVpTMVJaRlFDZkNyaUpWMEJxaEQ4NS9hYWRqUjB6TExqNERITVNtM0g1?=
 =?utf-8?B?V1JtbkdPQlpLaVlZZWMzOWpJWFdYTSsvUlQ0c1RpQnNUL1BPN01mSDRDWFlw?=
 =?utf-8?B?azBvNnRTcEZDaXBpYitwZG9Rd2tSVGNNOGQyWTY0ejhSZzlTUy82eVJ4Qm1q?=
 =?utf-8?B?b2QxTllGRHlZSmk5U2kyUVcyWXdmbW5RRjBGVlh2OVNPZGJCKzI1emY3RmNq?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D77F618077A36E44839DDAE21C57AB1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yZpyEM03v1avjwghBX9pjaGWZPgG7cnwNFNSD+nu//Fwum0x4rUYfuEnf0QU4hu1JkeZj9eYYLSjceNUJjGERCd9COFk6KrIaF2YMuUIVuTpLbLvG9r5I7MkrW/xoz1mG6dCLVr8mXIn/wqgVmHpq/jCK1WAr90difU9+iufbQi5WdSlsRa2r/Sd5mNJCSR2seaEpL/34cjPKztALGgFlsqvCo/Q9iafPO09X0zUx+BoWG5S1KYcGgS3aEKz+Ws9et2L5NHLjB4oHo30XJYCDcLIymcPJMHnY0My7HkirmvqHKOEXl1klV6YQIuucVJ7KQ+unZvXwP4jlxvvw0PZKTZ1cpiXY0tlczgzuqODIrJmggt/0OuDnFqY6QCpP6VvFbI0oxPkvFkb90f7a6a62/6QdZavLaSXnnXpndUmzlXLxnwfAEdMwxXPn4jPws6oJh5oLuAUz5d189zDbLBLv2dGyJV5bPjAXGRdAWzOwrLLAZAD9VYwA0mlAgOAVmj1ymTPks/QzM1P+5pd+JJhcGXe526s471viLnm2Nj5291hyurr5vaDwXanAAAQxRt/pZu4vj7FigxPc9tjAdgvVQTrdo6Qa8B1lM8+9q4N0GiUtcmQbIlbOFUU49WUvryKtBCRU/34YQucXWOhVQE/iGOt2bqbCwk8/kssePOgOdIBiDHRGXLfkDtZ2+wZhjIAbV15IhiONf7MPEOQGv3W0nr1GbzdjZMXP2dkSNz+AVDznJsxOvx1Te3tBMtTi/WR4QLaeavb+dh39TMZ22ohD78reKFhJnI+13eUQrL13ww=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f924b72-9364-4f8b-2164-08dbceed338d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:43:56.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2zy9xI7GeTf/LQFCWIkhFbZU1Cxtn4rN/NwE31oDzGkRQzAYtGR668J8nJouO8RBYXtNPGgPlMbpVCMDkVglbUUP6f2TJUTO17eFOu7aI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6965
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
