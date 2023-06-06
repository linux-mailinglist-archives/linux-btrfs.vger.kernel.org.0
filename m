Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5407250F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjFFX4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjFFXz5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 19:55:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC81982
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 16:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686095752; x=1717631752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iqa9Dw5qTB266Gi57oOhheQelFBamqYRQfbQ+CKccYI=;
  b=iHZAxGX7Nq6jpv0wJ3frvDVqBZ+pdc8tGtd5iqJravs5Ph0Ez+Q5e6Gj
   DBrFRjcB5+cz4wqmmAbjSKThpTb59/n8NRNBStQhm70CHaCUN4X8jrKGg
   MlUI8UDrA5SHXJaKhMMAh0aNTFrQueSVCS2AS3Cb+pHiyDIbHHBFm0LSK
   m7xXaazARbZE/SUoz7cPOnqqx3jO6anwoiXum1YRnJddSWz9jumIKYWM8
   eqvZJuFsLvRCL8B7H7TvwtktXQFlphdV3kugDtsxXgOTEUDNClYuP/cY7
   YMGmcGpGt4dIu8GEELkjRIEGIS+ZHiGW1xlD/NHGF8UC9gQ3Fd5KY/mO5
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,222,1681142400"; 
   d="scan'208";a="231064589"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2023 07:55:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjkKgxTJUk4pAPCpvst4MbCnPwPMCSeVSmr+BH7EG58hDWQ7F6gYJTJcGgzImkcm0XXKorsPxvkji4PbUS3btukQLnTvfF81n7UNRPwS/3Llv7cqJ3g4aGN+/epXUHTeDQKPsdmetLP3KkHniMMl2eQ2IWdXilicUAEaqtxIuDfs3GY1h4EbnPKIrSrjHAdS7iGCxUC8v6MoQUXVG+xR4rL+cfQxS3WylBfOUDiGqpcPmpM6HPO04fuQ4oBKW8T3UXoUQ9+Vy4LP0FGUTw8RjjKEopqfcyKV02JweMiaqR6Eqr0ps3fIs06QPdvepkmailNADG9G1ic14Gj34H/ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqa9Dw5qTB266Gi57oOhheQelFBamqYRQfbQ+CKccYI=;
 b=hapAPE7iirExjmD9MRRXVYPMkLv5zG4jzqkODYDsYmHwXTuZ7XBXeG9nQARmcENQx1K+I/bw0kEATS/UKpIDaPfef9dp6I8PXvcOJyxbpFyYzaExz9oWW9aUKo+MqyKHV8XXV2rLGHmHlLryybFfdO3W9AvjgWNEYBAm2ZXmgrCe3eiVBqwmoh7HUe59Uh0poa0X4S8Pox9IByUhNenjA8nZORw3bdoJEnHtLoVBO0fnbftXeJ1mXxLf+tgWABMk48CgcqOjTtsUH6CRAWxDgCP1hYv8x6yiKNqrYOBrbLhsQEiUR0kjawHOjMrTTiSVJLsmG2/gj5DnDg4hz6aFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqa9Dw5qTB266Gi57oOhheQelFBamqYRQfbQ+CKccYI=;
 b=mM7tBoRwl9H6t5VYqqrX0Q2MDsDR5ZKC29GIWn/zlKH2EVRmtxhgD1CUtvUkn1YwVlj43zm6SB/HCM4IBWzZaJinDi0wG3lyARpv+JpZy88C5lzqrJ4xU8g/msJhhscGqUxTM6QRrwQvW/tTsewWrLuy2QnltoE13W6BXPN/A6M=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW6PR04MB8916.namprd04.prod.outlook.com (2603:10b6:303:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 23:55:48 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 23:55:48 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     Filipe Manana <fdmanana@kernel.org>,
        Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
Thread-Topic: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
Thread-Index: AQHZmDjxaqSswtDqpEG4ZOsatzslv699kfWAgABkBoCAAH5mgA==
Date:   Tue, 6 Jun 2023 23:55:48 +0000
Message-ID: <j3bvyy4t3shzvfgylu6hc4affajij7orrh6fhqhstny3kushnx@nek7y5p7odqg>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
 <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
 <20230606162323.GJ25292@twin.jikos.cz>
In-Reply-To: <20230606162323.GJ25292@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW6PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: ccc3b2ab-2eeb-4f2b-bf1e-08db66e98d16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JqHHOJ4W+ppVKg5L+AX4owEqfd1zcmmixElKBQwBHUzDjk4OA1BFPZ7TdmaWIgpFQVV6IdWUVI8MjmH+GnEuM0PJS7xXhJiqrLrCRTqe8A27v9Lc0f/JftLISSZmTFr/b8uT/M6NzxD0/NEwABk0xgQLrUUgM2jZeEXRnqHIgMIf/b2pPoUxwUSqMzERCB7QXMjTIZfSFEZbIG27sLM/71bFSs6PHdgyXCJtMO4fCP+yDn4kafWX5luKcFVKIVfgTVQF6BShf5gxYwjNYiK307gNvOOp0Vv09q5Ix1cvPzGUUJvYN2fIDXLAH38z6aj4go+Vv2jYlbe9DnBHs6fis4SVuZx1Z8faiQJqbMp8x0W2DbmLR4lXHp3zaaOqFHvNUXCUPxQCFfIYHNlPQVkSBxRE1D3JUh9cD02QbdcFW/uK0ZsA5ahBMvnFwNxa3rpNzrzVDdqPuQiq4AQHLZ4E22ZmAFYalsgbcS36DT2xWcYZ3WWw0rCT1f9U1e0Y/Gj3fppg637wsaMNGVe5W/MMjaqr7/vM7bwjMnd75u60nbqIKtye5nu1REukcwd66/MqS0jctZAJt13crMrTK7hfpYWGNuAztnHr8qciFCrob+EdfZgSCAIpBuS8FR2qKga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(6486002)(6916009)(91956017)(64756008)(66476007)(66946007)(122000001)(76116006)(66446008)(66556008)(82960400001)(54906003)(4326008)(2906002)(5660300002)(38070700005)(86362001)(38100700002)(41300700001)(316002)(33716001)(8936002)(8676002)(71200400001)(478600001)(186003)(83380400001)(53546011)(9686003)(6506007)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBRQjJUVnpNclptZkwvVFJBK0F1TFpaU1Z5cEFrSDAzMjI4ZkdQa0k2R0t2?=
 =?utf-8?B?a21kRzBESVNWNTFiNlNEREV3R3RYUG1USDBpRTJZMVp2Mjk0UjVQUmtKbENo?=
 =?utf-8?B?Sk9PaTFXaVJCa1pqVmZnbk5sbWY5MWNkQlB2OFZhd25PWEJ5bTRZQ0VaU3c1?=
 =?utf-8?B?SWs2UUJGSGtROEJ0THlQUHV6TjVlamptblZoY1A1TnpXS3FHVGplVDJuRGph?=
 =?utf-8?B?TWQvYXB0WXdJNmRYMWVrM3VrempTQmJVbU5haFRBU0F3L2hSTU82azB6UE5T?=
 =?utf-8?B?QTh5Q1JYcGc4WWtNUVpZUUlKRy9HM3RoSzFzRjQrUnZ0eW9WaGltUnZpQWJi?=
 =?utf-8?B?MXpKWGxVTXlJNmNsTGk3Q3BrY2tsVXlVTmNhbWFEdkdTckZ4VmNDUjVUa2ZX?=
 =?utf-8?B?blJXays4TmJxeVFON0s5dTY3NjZFRGlVaWxvT3JRdy9oc1lWMytSY1JFSktW?=
 =?utf-8?B?bmdTemZ3UWJ6dUQ5ZDVxQnJpcDdFUEczYXlxa2REN2ozLy9pclYyUkNmSmZo?=
 =?utf-8?B?Qi9QT3g2dkd0aURmYW81OWQ2dXZITFRoM1QrL3k2YXFRclpUeFBETXhCdTJE?=
 =?utf-8?B?OXZOaXB0L1ZXM2FVVW01eTVQeUpucGhqejMzQWxEODVCNUdqK2ZoS2ZMNjhR?=
 =?utf-8?B?aGh4dWtOdCtSemRHZENWVi9pQTd2VWRLUmRFNFNNZjJacll3N21vUG83VXlq?=
 =?utf-8?B?SUwzTkZCUy9tR2RFckg4cXdjYmZ1L1paSmRjMklPVlByYTVaUThpWGpZQjhK?=
 =?utf-8?B?Uzc5OEhtRmRhUFRFajg1Tk5zOVVYcjF5bUcxbU1rT0N2Z2JveGRVWVBIWW5U?=
 =?utf-8?B?SnhRTnh6N2JXRUNIOXhZbmo3SUU5amtXNkRZR01zQzdoRE5FZVJMYk00MlFM?=
 =?utf-8?B?OGhDZGMxOHpHUnRSSjdubkoxNkJVQ0tIWlg5ZEVOb256R1MwN3E2WXdUWGVJ?=
 =?utf-8?B?aUxKTlhwMm1XcjN2RXVpT29TR00ra1N5dGxUREY0Mk9pVmJCTHRJNk1zM0Jy?=
 =?utf-8?B?blFOMEZSV2lxVm1FdG1vQkVNVWRGWnZzTTBvOE5pLzRnYm1YS0hGajUxaVBN?=
 =?utf-8?B?aFkzL1lCOGxPcmhvd1BsOXdiZWVEMTFGYlJTa0VMM3Yvd2lINFQ2RjBXL1U5?=
 =?utf-8?B?amNNZDVtVUxvcjhxWW5PS3hDc0JoWGFBVk02R3laTFQzMHZtS0ZIdjB5WXJa?=
 =?utf-8?B?WEdTSmpXcDM3T2xJS0dXZzBNZ1BRTnRlY1lTM0drY0s3OFhBNWd4UVdaQ2ww?=
 =?utf-8?B?WEJYZk5xL05oelFaZHRJR1B6U0FrY1JTc2xTalROZHo5ZmdqbHBYS0RidEpw?=
 =?utf-8?B?bGJEU3AydS9VRUpkODdwVTArNnMzZzhzVlVBb01HTjN5bHYxL2F0MzdqL3hJ?=
 =?utf-8?B?bFBHSFNYbzliak82YUpaSWhrelZOclVpOHZRMUNKSWx6M002Um9jMWxGam5s?=
 =?utf-8?B?Ym1MRkw1NWdnam85bmRWdkI1YjFENDZXbHhOSzBQaGozZ1BWTW51am5WQXlk?=
 =?utf-8?B?VFNzS05KODhaakpPeG44Z1NXTFdnZXN3M0hZVGFZR0V3SzZFTDRnQ00wOTg5?=
 =?utf-8?B?SzVaQytXT3JnODRBRWRpK0drWXpWYXVHc0hNYVZZQUw1U2Y1Y2JRcGpyaXRo?=
 =?utf-8?B?MzRFTk85V0hoaGpkR05naUdRVWY3ZFk2MXdsakFNNXJvbExsU1BSWnlQcFdY?=
 =?utf-8?B?QVd5ZGxQVTFsV0hLZ2Zkcmhmc0phR1kyZUNNSVZFbE1UVytWNFo1M0dvSEZV?=
 =?utf-8?B?N04xY0JFSUJvTDRKTFgvWXkzYS92OFY0SXVuR3VwdGx0Zitrcm9qZHg4UUo5?=
 =?utf-8?B?M0JDUmJjWTBNRnpSUVhhN1NranhLT042aXpSejZQUkJUVlFPa1hHTjBVRWQ5?=
 =?utf-8?B?ZUJUWGc0N0xsSkhDMlFzWGxDZmJBQ1JoTnB3ZTYzRmQwTEVxdmdYMkhnaGdo?=
 =?utf-8?B?eWsvMWFpbE53NEkwOFpBdFNGa2pFZkNQcWk4cStOclJ1YUtJb0JxN3R0NUdZ?=
 =?utf-8?B?UzhPKzU3bHUzeWE0VWMwZjVKVVhNK1RWdm5QL0oxVXJZZmwvOFVPMXZGYWhF?=
 =?utf-8?B?anAxNWgyd3ZpWklXeVJwTlpzRnphMm1HUmR5TkYxazlwMWs3UFJSd2NqNko3?=
 =?utf-8?B?WlJTbGRYbDQwSXpLYitYY0NIc1RJL0V3T0R4TGUrR0NPZFZDZ3NDWVhGc2V6?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C9F116FAFDF3D409866E768DCA986A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I8KPrYqH3hfQNkzoxaH0SR0PpxCkdzX1JalboLRpN7iP1MGvCh8ahezpgKOHma3OFaCnauxu0EcgcKYlhtro8hB/Ulny8oQhS7FGWL7svg5ND5MLFqwvF8OmksWOlQUMV2uvMLcBesWOOkOap5W82YSu21w0BItAjmzXAnMvzBjN9OgzePORZe2WK2Rx3EGSxi0j8UtMkPGAxguS4pG1QIspl1abQrRmVzqOMrkVmYOrO1yNHWZ9fnZX23xl/rUFPd3z0B5og2iq+KmlI/+O4prOtI1rINlkdWk+SgDiY0NbFNhgPb4ACfX+8TXk96EPwI8je2Vf42B8seU6hD6avAw5FE/bnwDd+5POHWqaVCnyi1Oi6E4shHTwpSzhWI5PGcX2wJcKWxQgfrfmUBermeQjmC8BLBmN1kgyux5uFKrRBQYGuP5cCgKh9Tzz1+bMyZMQPHM/+6W4jhYLC7AOcOiURlhQ110GUnus4OPAsZbUbbuinjIGLMUMnjBYegX42ULHVuj+eTKQFWWrsexJdzRjQ+FrSTYShnveQTcIkwOEvf/RAqi6162+CqIsE1WhfjPuF5vCJcBkyHapOBVvbNMT4q5cgYGCnWoWqbwfvwT92M8e2P/J8MibNgcDXtwbqgab2CllRrDhtf1KTaSQ5e15eOgcccayI9bPbkt8hvS5XsKWq8r81wdkcgBDuDH1huao8LY81K4Hzg+UbcCUcJPzzimwukS0uct8e4C6BywqKV9I6PyHgl0QW/MpnYEPlxzUz7msfuxfckf3/9EZ71lhzUvnfIesjMpNm+Og8zl2f0WvHB8bCAiBVhbQCctqzqZj3bLsa7v0cBePG4zu4CbPvOAdN7OOcKuBUXrP5mU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc3b2ab-2eeb-4f2b-bf1e-08db66e98d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 23:55:48.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9DjSo4aV06oj5HhhE9pla+2tQIDZgrBzXgw10J70Pe6zc/oGGYdzRa2GsA5xHLZAn+mm09FhEld5hsMNTwqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8916
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDY6MjM6MjNQTSArMDIwMCwgRGF2aWQgU3RlcmJhIHdy
b3RlOg0KPiBPbiBUdWUsIEp1biAwNiwgMjAyMyBhdCAxMToyNToyM0FNICswMTAwLCBGaWxpcGUg
TWFuYW5hIHdyb3RlOg0KPiA+IE9uIFR1ZSwgSnVuIDYsIDIwMjMgYXQgNzowNOKAr0FNIE5hb2hp
cm8gQW90YSA8bmFvdGFAZWxpc3AubmV0PiB3cm90ZToNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHNwaW5fbG9jaygmZnNfaW5mby0+dW51c2VkX2Jnc19sb2NrKTsNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGlmIChsaXN0X2VtcHR5KCZiZy0+YmdfbGlzdCkpDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJmJnLT5iZ19saXN0
LCAmZnNfaW5mby0+cmVjbGFpbV9iZ3MpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZWxzZQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19wdXRfYmxv
Y2tfZ3JvdXAoYmcpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2so
JmZzX2luZm8tPnVudXNlZF9iZ3NfbG9jayk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBzcGluX3VubG9jaygmYmctPmxvY2spOw0KPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAN
Cj4gPiBBbHNvLCB0aGlzIGlzIHZlcnkgc2ltaWxhciB0byBidHJmc19tYXJrX2JnX3RvX3JlY2xh
aW0oKSwgc28gd2Ugc2hvdWxkDQo+ID4gdXNlIHRoYXQsIGFuZCBzaW1wbHkgaGF2ZToNCj4gPiAN
Cj4gPiBidHJmc19tYXJrX2JnX3RvX3JlY2xhaW0oKTsNCj4gPiBidHJmc19wdXRfYmxvY2tfZ3Jv
dXAoYmcpOw0KDQpZZWFoLCB0aGlzIGxvb2tzIG5pY2UuIFRoYW5rIHlvdS4NCg0KPiANCj4gSSBj
YW4gZm9sZCB0aGUgZGlmZiBiZWxvdyBpZiB5b3UgYWdyZWUNCj4gDQo+IC0tLSBhL2ZzL2J0cmZz
L2Jsb2NrLWdyb3VwLmMNCj4gKysrIGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYw0KPiBAQCAtMTgz
MywxOCArMTgzMyw5IEBAIHZvaWQgYnRyZnNfcmVjbGFpbV9iZ3Nfd29yayhzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspDQo+ICAgICAgICAgICAgICAgICB9DQo+ICANCj4gIG5leHQ6DQo+IC0gICAg
ICAgICAgICAgICBpZiAoIXJldCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBidHJmc19w
dXRfYmxvY2tfZ3JvdXAoYmcpOw0KPiAtICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZiZy0+bG9jayk7DQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHNwaW5fbG9jaygmZnNfaW5mby0+dW51c2VkX2Jnc19sb2NrKTsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKGxpc3RfZW1wdHkoJmJnLT5iZ19saXN0KSkNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZiZy0+YmdfbGlzdCwgJmZz
X2luZm8tPnJlY2xhaW1fYmdzKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX3B1dF9ibG9ja19ncm91cChiZyk7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZmc19pbmZvLT51bnVzZWRf
YmdzX2xvY2spOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmYmctPmxv
Y2spOw0KPiAtICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgaWYgKCFyZXQpDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX21hcmtfYmdfdG9fcmVjbGFpbShiZyk7DQoN
ClRoYW5rIHlvdSBmb3IgZm9sZGluZyB0aGlzLCBidXQgdGhlIGNvbmRpdGlvbiBpcyBmbGlwcGVk
LiAgV2Ugc2hvdWxkIGFkZCBpdA0KYmFjayB0byB0aGUgbGlzdCBpbiBhIGZhaWx1cmUgY2FzZS4N
Cg0KPiArICAgICAgICAgICAgICAgYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKGJnKTsNCj4gIA0KPiAg
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZmc19pbmZvLT5yZWNsYWltX2Jnc19sb2NrKTsN
Cj4gICAgICAgICAgICAgICAgIC8qDQo+IC0tLQ==
