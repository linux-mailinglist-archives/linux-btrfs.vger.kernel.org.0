Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84C6B2632
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCIODa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 09:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCIODH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 09:03:07 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC35F187D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678370436; x=1709906436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6GwieprkkOwSXfehpYE8LzUFC3loB5wuIWLkLDwqHlA=;
  b=NpWMu4b4rR43CZ5eNKiLpozIhTfLmCXV7hbqlUZ+bcI+nIwfg1MpGH2a
   1vSwx/ioXFqkDRjPzap3i0BVYt3gX4d9a4AxzRSQgG0FTZZKeY7AH/PBz
   nlMA76SUd+BC3v1DAPKOuW7+JxFRAU7JIXNn3EqfS17wt7nCdE9Q1ZH00
   O3WeTHW29oX79WGAfaDnz1n7VH+U4C/pHAw6szo1tJfZPr0lP9wgCmQuI
   CH5SE/w2ommoZh772v21ydOrMT+uagX2ILZ3SnAdyH5TTZ2dKcWo5Ynw7
   ySQ6jmAIusdDqUz5WkNgjYVA4FwVsuzUyWEXgFnLWhpwBUnPuPe4Iv8va
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="225006040"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 22:00:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbyRY5IsH58ZJits3hDIObqWr99CgaI4sQrnyggxAlwUxP15Euitqtvul6vj7g9TFTm0skATPcYfRpzfUzfkLgIDbgrfgzOOyBBAv5BJ81JINH/CNGV2YffYjsIgt+UwP39QSTXxghH3As+trzfigx9qU5imELhnKADioT/+Vn0k8ZxAxFiRhHRsPCDXGdfolAnT13bL2YDTACJ0ZrTul7Hzn+NOsuJDmeA1Ji8zVJ1qb5Sk6DY7Telo6nHJeJRZ3UOisuy1aHrNhfpSvdX5Y8xQFYfBCsMcIEejkRqkQt7WJ15IrgbYcWJ77Eqhkd3NEp1OFi6cu6nEMuSfPss/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GwieprkkOwSXfehpYE8LzUFC3loB5wuIWLkLDwqHlA=;
 b=Ps9m5ERjtLp5mjzCPy6INIOMenFPUfqU3nA65PX9aE/24G7v6Vr8K2lbgHtSxqTCZEHC0uN+Cptth9qxV4iVN65T18W2b4xajQwPaTnFgQ2DYYfHVuTsigA0Y86QXFO8/+//f5W3cf78mYzrpMKSeBXuAoHUvvanyV1aUPyLcXhlPyvSAfsRazEJGDgZDcNuPdnLP3aOIR8Bq+1430cxmtXpbY10k4+gOYrxVxHmHIqTOunDB0wTNOt3r01c+izEruBboLaMYjS0Xavvmx8onVodvnM2TlNMRyPCnEt4XDECtwW0LwYDlfDzeI65zzCI3WW3ZUMzW1ouiDVBNAPC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GwieprkkOwSXfehpYE8LzUFC3loB5wuIWLkLDwqHlA=;
 b=ewgITU0D9xwMY/oVUGGNuda/HlsZR6QFTmE9YvB5+JQ5ja8vSX2gbkhTzfwy+J8n/PWfI6ahDBwbv9pfYXqDb88jtxPBlfBcJ71Ib3cxJTqND3YnoTupIGG7PC4sR6dXAmq23lADTIur2WH0ekvSsHNyG0pHhkB8nR7VihHqqGY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6829.namprd04.prod.outlook.com (2603:10b6:208:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 14:00:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 14:00:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/20] btrfs: simplify extent buffer writing
Thread-Topic: [PATCH 12/20] btrfs: simplify extent buffer writing
Thread-Index: AQHZUmammW1arUNdCE+s+dpoSQuDG67yejkA
Date:   Thu, 9 Mar 2023 14:00:32 +0000
Message-ID: <e3f3a52f-8656-24f9-f8ed-a13c2dcffeb0@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-13-hch@lst.de>
In-Reply-To: <20230309090526.332550-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6829:EE_
x-ms-office365-filtering-correlation-id: 26a9d1c1-6017-4309-f401-08db20a6a639
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JrdcREAihvqMktJfbvRa3Vc4UPaHcIVLd3payorhs9G+r/uu5FXg5EBF8dnAfYcZKQ7TUHVOn11lKyBovQscLfKpcHNSn9M+PZdSqC1F+h2isul5WWWqhUMkXeLa1rQJkTyqpQR25D+w9JOj7URPzinIgjt4DhMs8q5n/vrgdw5yamznzLU2KQ00oBK4sKwuPc3a5kj3ppblfknkzv4QVXNlMmN+bfAt6le++xIUGYCseKbRl419EqE8DH1KKhbuSJEelFlpZT9311be8WjmnDgKu7hmgt+8wCIKnx25ykhLvkDU1Ig7/JoG9/TVImT+wIjiozljbEpsZWmX5I80cOwSRCUpb0LbbzXtjt1K5G5pkHFa/1nDlJHAK8b8WJ98bPzqry+m5Xth3jlruEyK09ivDJ1NX2HhHO5U7I1Vn7uJ94LSp+gyXhfOat9c4hnh+uFv8Ve6JGkknjInGCpmv1ndz41UzRpxnqP3/S9KhsripbwEuVSNxAkomsPUBIoCSYxhku/cs21RWFZHHtBb1mimBP65zqIpePNqCX6lApFNyK0d80bZKtvKg4PSvScjpsmoGWI+D1jKIDKKjbPJoBiIHOnDny4XPINAd3DSnXllmTZIFEQPufkxoNsPoYmr9XuqYE+XT9fuhjLtjiITkVxUAjnFOZWzibbK18SmG5TgmdpOPMb2H3bNb8Jflf9F23jPXw7aYIAu2SJrH7cUzguNrDSWYGrGAFp7Wwha2n5l3uU3s2qhUY5eokFLd0xpCeX27OWJyQTeDIWrLT1Tww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(91956017)(66946007)(76116006)(8676002)(4326008)(41300700001)(31686004)(66446008)(64756008)(66476007)(66556008)(316002)(71200400001)(5660300002)(110136005)(2906002)(6506007)(6512007)(2616005)(6486002)(186003)(26005)(478600001)(8936002)(36756003)(31696002)(86362001)(38070700005)(558084003)(82960400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0k5bnppSS94RmtzYUxWeGg3bzNraGJtSjlwQitycVByZTBoNDlnSHUvazN6?=
 =?utf-8?B?RUhTL3dDaWN2eG5KVUhpbis5Z2dPTVh4RmhITmt2WkRzenRwUmFHTXpIMnQr?=
 =?utf-8?B?NHZHZHBUdW5QZ28vSGhEajNKK2tMSmFKZEIyWllxcWUvTXp6SzRWL1NkVGNE?=
 =?utf-8?B?STJ5dzFzY1dUaVl1cVEwcENlM2ppc21BelBVV2dRNGZ6UDlOWmkxamVOM1VI?=
 =?utf-8?B?dCtLbmpwT2tPVllBbGhmT1pvaGpaTFZmNHp4N3ZRd05McytWaG1aaDZ5RGU1?=
 =?utf-8?B?ayt3YTFmVGtBelVwS2hMcEtZRzlnMkNTdUpVcm5CZjBKVzg0Rmk3bUZLK2pD?=
 =?utf-8?B?WGplZ21Ka2wwdVZocXdTejNhOUJOWWtlYlhoUXRrdTZVblh1MXdlZXorWmpa?=
 =?utf-8?B?UjA1V2ltdEc4OHBHTzdsdUt0N3hEYlMzaGt6THBCZDZib0hOcUthOWdQTVp0?=
 =?utf-8?B?ZXdrdktGYUhSaWVobU43K0VOYjNTc1BVdmRDS0tOQVRQbVFYK3k0aWZsc29a?=
 =?utf-8?B?azlmZTlNNG5yK0JFQnQ4VStEcDBVajVOb0hnTUtibUVjb2ZCV1czZ1phNmVM?=
 =?utf-8?B?c3FxUWhFbFdGMERobkQ2VTlNSTFOYmt2YU93Vzd6dHNWYXBTeFFyZTNWelJs?=
 =?utf-8?B?bGFlYkE3bWhXZEE4UDdpM0o2U2syYnc3TWIwTGs1KzBqKzY3bTdGWGllUEhR?=
 =?utf-8?B?SXdYWDhQS3ZRTzdoZ0FtcFVZT2cxNHNaTGZVaENnTW1iNktRM2pNTVJsNDU2?=
 =?utf-8?B?S0RSWGpmWDlVNzliL3VGRmw4dHY4NGhPR2wyWXhRa0NhdzNjdTFSNDlORHlv?=
 =?utf-8?B?a0FJSDcvSVhYTUJoSGsxRTM0TVMyQjNtY2Vkd25BY3oxQ1h0cGxpQU0zV3I1?=
 =?utf-8?B?V2ZnMWhkN0FxQTVVS21yY0VCcEg4ODFyQWN5VW43Z2trY1BmL0lacGk4QmVJ?=
 =?utf-8?B?dVdZRVVYRG5tR0NleFllaVJvL3FwenFQdnhja3hrc1owbFp6OGpzMXBNa1Bt?=
 =?utf-8?B?VEdoQjZRbytsRWhhWkR2TlpNQnQvWTVXZ1cwSUZkL2RHUmxGMEZVd0xDb2Fi?=
 =?utf-8?B?eXBrQzJOWHdnOFJEWXY5TTBLRWYremFldDNjMWdQbndhZ3hDN25Bamk5VEpE?=
 =?utf-8?B?cm9LQy9hbFFSYmJvL3d5TUt3WEJtQVpwUkhrU0pHWlVlVCthZk1FcHU4RjhY?=
 =?utf-8?B?TVZraWR2RFBFUGw3WENlekNiNFJRQ1l0Y05XR0FycjRWT2duNm52U3VTcFZi?=
 =?utf-8?B?MEdRd2xEZjdsQVRPMi95c0REcFBiZ3lzNDZXa3VaL28wZmJuTXhXNEhIR3FM?=
 =?utf-8?B?dldZbE1lYXEwSXdIelFHbERoN1lING8xMVdlODJ5OXBVYzVyTFM4Ykp1Yy9v?=
 =?utf-8?B?WVZ6NjhkdjNqbmFuUFN1R2xvMDFEWFFLT1p2TkdvSDRVeC8yWmlFWVQ1RzRC?=
 =?utf-8?B?aXJkTDQyd3l4RjJpakpkRkUyclhHMXY5MnRxSTZZaE1RZnpPWHdFSmo2VjRq?=
 =?utf-8?B?dHJ0WG5uTFVHelNZRkxCdE1adUJtZ29ESDlnRGtETEo3K2tjdlZLRzBOV3dI?=
 =?utf-8?B?cXpJVVBtNUNieE9DOVo2eVMvM3VBdHZnb0Q2UUd4V2xYOXNpOUl0elI1b2lM?=
 =?utf-8?B?SWhMSmM0ZzVnTDVQQktDZG5zU2xaREs1eitCYjdjQVFDUlZ3MHlqQVdpbnRo?=
 =?utf-8?B?L0U3QnM1cWl6d0R0Z2wwWEFYeGgyQXhNT0ZLUktQTjd2MGFDRDBXTU54RUxS?=
 =?utf-8?B?MWxwYkJPVlVWVUVvdzV4c0JEc3dOcEU5VmlnM0MvdXNvU0J0Tm92V0lPQk94?=
 =?utf-8?B?ZHVZQlZQc1JsK0c5cW1ueXdpc25kVGJiNmVCTy9zREk4VFM0bkdZLytnUlhv?=
 =?utf-8?B?aU1KRlZGVndOTVRxNjNOQUZSTlV6S0IxNnlPTjcvVDJkdGllWkQzbnZZbTA4?=
 =?utf-8?B?cWp1YWszV0laVVJRb0daazh3SzRPdXE1Tkg1RXFxNFF1eHZ6dlI4Sk1XYUxR?=
 =?utf-8?B?c2doTHk0RWswYzhvWkV2OThRb1oweGlmeGQ4RlJha05GaFZPUlkvNkFPbmhX?=
 =?utf-8?B?REdnL1FIeHhUSWNtTEpnTVJSYXNvN3lHMGE3V2owZkc2OTZ4Z1FEbXpicEJS?=
 =?utf-8?B?cHJMSm9Wei9Sb1JVT1VFWnNjM0JHU1dwYUJ2Q1hXdE81anAzY0ZCbnJiNnBy?=
 =?utf-8?Q?5jID4EBCq1DiNji8idqHG4Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EEEF2CA451D144B97B420E012E25182@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I8IElC0sladxBu59PB3zEjz1t5mtuIplxj4EOBrE/ELZcMimqZ1F147wlbPzJkhTGweEwhkYW206Us5rS1F7vAfpKOvb6OyhetqUlhRcodT64FQ0OmdCexQfc8ytG75R70shiZ31KGAcvho5JmBQlDK/fQOctbezxIXCnPhEvsYhFeVgE8UshyKvBGeuXzVCLD+HhLGujGS8gYGdCwpch4I0v8mTMwVu9H09KA3Jo8XSWzm1s0VTuwTVvDAqSm5nkiFWUoXw/pE/XlCV9mGCSulR9Y9B8tDCNkJq0NeHHatMHmv2ChJkIEm8AkC8ukrjff4fpajI0Bmsj4UB+wVAgIzbi1mlvg8IhzKBEift4c3yxnYiZpah3piksGe6ItNtqyn0nxwW63bvgSY2pnLVo9KTajlewdjFk4WOblLE+IJKxThDbayIK2+dz4Lq3NiLkisNG+OcSQYjxCf3zljkgScQw6XrnK6sUz9+nT7LW/XFlLJM3PYxBs+EfQqBAUrpQe8zszm9BIf7LBYR/9VRUOSfHsSmKHpDMZQ2mEhA2TZF10LQGphnsVWkxywZVXN1bD/XhtYIb+mCs+b1a21/dDgmHMNk4pRH6HxlYQ2Vtsr8nYE680X8Sg2Hiu3r0gEKfloh8P2k8VKeC/6ACsSQiHs9YCPD7DgkleWADycBXPzTMb4K7aQ0BQgtUM3dnEj2QLrkTOHYPEIbkWqVNXhXCdGrq6qG8nr59ifXEql2QqiJ8E1ScgySnHlc0YAbdF0h0rxJ5eDRW3YUZUyUyldkLG1B5FYlyVliD81gEOhBFrOKQDQulTbN8eE0ToMHq5IXyMWgHTmxkct6A3nx4PUoh8xZAkj23PBB2inzLlMonQvN7Wa23yaK4MTYPK/utWs6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9d1c1-6017-4309-f401-08db20a6a639
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:00:32.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmeodLed7AlH4+mtsPrVuYvbUhFmspsr0ym97EOc5ipfDIN9MQ+4AmW+9eJ9exqfD8h67+V7cwcp7+IYoX5BQAxQTWDbwQrXR2SyCfbugAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6829
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQpMb29raW5nIGF0IHRoZSByZXN1bHRpbmcgY29kZSwgSSBob3Bl
IG9uZSBvZiB0aGUgc3Vic2VxdWVudA0KcGF0Y2hlcyBpcyBtZXJnaW5nIHdyaXRlX29uZV9zdWJw
YWdlX2ViKCkgYW5kIHdyaXRlX29uZV9lYigpDQphcyB0aGV5J3JlIGdldHRpbmcgcXVpdGUgc2lt
aWxhci4NCg==
