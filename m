Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5B6C3172
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCUMUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjCUMUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:20:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F193B3F7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679401189; x=1710937189;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Lgc9Fvixf3ojpy3JMMszGI03o2dgKabu1w0hBOHbXql/teVTXFST3XOX
   HRXCFvdX7OcV52rNvLnBe7kKfRa0wVYzAs6f3njLeGGaL06LGJ91Kk4O0
   SFGaeqfD3D81lme2XEHiQqx5XOSOekhMMYNK2cNR8KRezhQ553hWC2U6r
   GPYrHXuNqixzPnBEk5XOv6aEScA6Cl+FZv5pBSqs3/6nkDuYVYW4ARbCf
   F5d34tWDvXlr7IYo0xsvqlCGOGGfutjSkFEhEqLNiAd3OjfHntQJXz/Ky
   Zu9SU99YgBNAQIqtQBYlMrlJ6U12KDYGy40u/Eh+ayVIQGvqEjmgydFLu
   w==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="330546474"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:19:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SORd5tCD5f4gg7+jFGUNEFUPAnxds2A1nRIp5kD+alOQSoaciqK84Tgy10wiPLqKl0cDArQF+qf2d+M//UKvxbFpAVhOnIjkb63coHCmOu46F6x2WzgV5zv11o9HYrVc2UUg6b8qjgEsy4Ui9HT/sGGUtH9K3AfiiXhHOYJOLEVmArq7vvFmYH6BBL/AyEFIe5k4N3vwbG9GOdlqxMXyYBD6uZoNP50Pg6YR36PBRceTY2pZhMKb3GrWLUG713tKP20MKmnQ8LKq7xPF+tkhJJaZ5FOPqAMBkf0y4gtx2NAWKKYrthG9plJzVhFN6HQYpwyRHfAu747ZKERMSBcu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IT7n7H6S2lQPcY763vNsFCbrjALjvrB0t598yHUUzm8xUST84ZzaI4+ltZavMjkAlH9NymTMpuD2JiFaXtHspOi8CHZHuOACc+QeBSkFrv/SmkF9uQzbOCHjG/Q+SWb9zF0oGzw6DhIQfPvMDADXZY6Mx+VIqnN0Dfh18d4/km/sZIA36CLUIXkm3UYFYZGtXmIAuEtcB+uKUI1I5IUK/JqFUvtrrG/MZZSCDIvxc/w47LcMg4ITqmCuGt1xBbYtkDXfs11hhpKCo2Jqpv+YI/T38ZQkUNeLdOgqGOIrYQDUg5e8yZp0jrBpy1UwhCldFphBOs9zGxhMBL6JwCe7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wMbFDvfAAsnt6SnilCC42Q3KOTtlhMOYzGJVDl0SWNDUR1TwtJmSOsLwQaF8KenjeGaQjOtJAjAbKgKukLBFDLdMg/ACw7tQuEo6hYsumG3+nOInqTOhGyMOBthZ13IUTF2gLXdJp2QlSi2DwKEaEsIa7tPQqrOfx/h7NooQ5AE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7882.namprd04.prod.outlook.com (2603:10b6:510:ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:19:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:19:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/24] btrfs: update documentation for
 BTRFS_RESERVE_FLUSH_EVICT flush method
Thread-Topic: [PATCH 04/24] btrfs: update documentation for
 BTRFS_RESERVE_FLUSH_EVICT flush method
Thread-Index: AQHZW+ZV8Sm+PhilY0mkM+MY8dz1xK8FJwwA
Date:   Tue, 21 Mar 2023 12:19:47 +0000
Message-ID: <7ba8e91f-3461-41d7-15f2-046f76bfac05@wdc.com>
References: <cover.1679326426.git.fdmanana@suse.com>
 <5b9ed9c2e2de13fc10236824bdc333e318e47786.1679326430.git.fdmanana@suse.com>
In-Reply-To: <5b9ed9c2e2de13fc10236824bdc333e318e47786.1679326430.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7882:EE_
x-ms-office365-filtering-correlation-id: f1dcef9c-727a-4fa2-2452-08db2a068fb2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zY/Sw2dUegQi3V26c9yyZa56dV71Td/iTbL6QJvtlKzazK3r5N96vZ5aibgMFAxL0OYDduuu416APHAk+TqfYdK4I/7Woy2ZxiNhAYc/zGxW4gl4Zh/46VfNO3PUFHkm3hlg4I152PwK1lWkHtF6ZGy20H3LtoJoVnz9xJxDsaP4rHB78qh/1tIQlYT+A3DdxZjQyIWkfWJzbIvOmE2oqC8Y8ifWOH3YvSE8WYZGOp2cnDCAG9bJqyJhayIx78dun+cIihcwtI8x2n3ql1H/8efgE7mSt9lfZ98P3PAlAWgdSzMxLDHQ1QvJyrg7UsakJymBfCt7R7nqTeSepfsWyt+kUq1mPxz5AOt002sDEFTM5yMTqaznXcxsa6uEPrjCwBxK64MQeM0fdsAiuO1kL92bcYL67jLNb9oBj8BcHs45ghOdDgIScBmVMXYIMzLXpR8h81YS755DXdRZ9n6xYPwO7lSejbPKK1gEe+17fx/S3Gl7IIkmc6ASvb6J52Khd6dJObGi4qwM+/BlcrlG+iv8wNms8DcmxiNquHYr8etlRlGT8hIEvEljUZK4mONZveEDWSh4kCSO5e9B6t0iZNoYhXETOnefeNK5ua8H34RQi1gb5JXZd5q44OgRfG3oXDMkNSi0kWb+4F8cFkJBZD47JEpSkh2iyOake3vJtdfI0hJKLuxsVIVzyfAlrzkU7lAB1jsdTOSKGmqz97v4cA6L1PfY1E1BwVfAlcsJ58LfiDr+XBqe3Y1imvC4Ev8HWe/CEZmnNvu575GLBa45PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(86362001)(38100700002)(19618925003)(31696002)(71200400001)(122000001)(558084003)(8936002)(66556008)(110136005)(316002)(76116006)(36756003)(66946007)(91956017)(66446008)(8676002)(41300700001)(66476007)(64756008)(5660300002)(478600001)(2906002)(82960400001)(31686004)(186003)(2616005)(38070700005)(6512007)(6506007)(4270600006)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVNWbWVNNm8zaHVzV0c0OVltNlpqb29pQWlyVS94Zk5JdUU1TlNtay9rLzM2?=
 =?utf-8?B?KzNFN2FWODZNVEhMOXM2N0RxS04wYkdocE1DSlJHQTlud2ZSWWlMTE8wRm5P?=
 =?utf-8?B?NVpmYjZoVGU5c3VFbzVSek00UUJKb3c4V0ZUSkcvVXpic1hkL3I4Smhsdjd5?=
 =?utf-8?B?TzdZN1AyRGpUK2pOUHlGK0laNzY1Vy9hTi9zU3ZuOWNiQU5pYnpTR1J2d2sv?=
 =?utf-8?B?UXkwdjZNUTZoWGtaQ3J2V3Z2eUtONUN6ZjBPVXV5NHA2aU9UMW9hSzZFVXRy?=
 =?utf-8?B?ZTBMY3ZTM2ZNb0ZITzZacFRTVDBiWU1QaE1ZbnpyWklNUkQxWkJVZ3kvMnNz?=
 =?utf-8?B?THZ2dTV6L3NZTFVyeEZoZmxMcjljNFVWOHRENGlaZmwwcDBmZ0MxZGFGYUNI?=
 =?utf-8?B?N3AwdktWVEgzeUU0L3dWUzZJTjI4SkZBRXRoNVQwZGI1YUZmb1NzTlo2c3BV?=
 =?utf-8?B?SVRsNW5YSk1qb25uR1dsMUJ2MTFRanJjaTBNbzdhcnVrcncyVTRIWjJPTEJk?=
 =?utf-8?B?U1ZjdDMvS3JFdkxLU2UyNmJORjNFQjBYcGdlanZMemJKNUtrNGxGL2h0TklX?=
 =?utf-8?B?cE80Vk1kNVNoS1hjb2w1dnRVQThDamY0N2RYdVUwTVBPMy9nSkZwcUl0WC9Z?=
 =?utf-8?B?TU45WHpPaWhDcFI3U2kybU1rcWFDVnM1bDh4ODArUDNlK0drenpPT0Q3R1VH?=
 =?utf-8?B?R2Y3Zk9yTVNhU3ZDMW5rcHdnYmxWaW1SaTFYMUhmMkNOUW82bEVKdmg1a3VC?=
 =?utf-8?B?N3YyZFZBWDFrSDR5NDhUdzZZdFNrQ2YwM29oVGlJcG44aUdSc2p6NnBxRWN1?=
 =?utf-8?B?dHptbVdnd3QzcWxNVDRTbitQOHRvTHo2ektRb09aNndnUW8xZmRWYkpCRTZj?=
 =?utf-8?B?dk02bWxFbGMzMXV1UTBTL1h5SHk3ZmRSUHc0b3BobWVPbkEvQVd0em9IQ1Nj?=
 =?utf-8?B?a2drUDNHQ1U0NkVqbWFqWVRNZEhvdWdaZVFPVE5IOCs3QkFHRHhjYy9yb2Nn?=
 =?utf-8?B?UlMzb0pWeVBGUlFIa1lUc2tMZC9mS2JJUVg4TzkzSUZMcUNNNnJidDdzMElQ?=
 =?utf-8?B?eGNScXdpZzdWQit3ZGdsZlRSMkwwc1FLL2plZ200cnJZcURGV2ZQbFp6a2Jz?=
 =?utf-8?B?SllqbUdmOVNUS1BaaHA1NmdIVWl2U3ZzYVo2T2Y1aVNSQ1NNc3dnSHFJTndB?=
 =?utf-8?B?NEMwQjJQZTY5My8rWnpRekRkbGZYWjM4bHVFV1d6V2FjSlEzcGwxZUZXVEVD?=
 =?utf-8?B?Z0VmbkFKdit5eHpMbzdjRUNONW5wUmJvRm8xQTBJekJaYXhWaEZmYTNFNDEy?=
 =?utf-8?B?SVNOODAyVmhNM2s5d3h4NFA5UUdqNlNRcndUSjI4Z2RBcVNla3VuUng4ZE5y?=
 =?utf-8?B?MHdNeGxZSENtdEpiaDl0a1NEamVneDAvd1J4cXJMbWVOT0RDZHN1NHFuakZz?=
 =?utf-8?B?Tll0UHo4YjFkTXorWU5IY2E1S2VXeFhlSTAxTzFEZ1M2RWpGaEs2MW8yOGxX?=
 =?utf-8?B?NjRkbGNmUmhQcjhXN0pibEl4NURPeXV2K2crYVZ6Rno4ZEw2UFh2SmcwOEE2?=
 =?utf-8?B?am5rU2t1MklESTJsSHpLS2lrSjI2aDJUK0k1Y2JKTWtSanFUb2JWbWhtZ0hR?=
 =?utf-8?B?THU3SEF2emgvLy9VbE1KUEZRbFBUM0h5U05jOEVtd1FsbGdDZ0RZZE9aNlN2?=
 =?utf-8?B?VEYwOUlPNERjOU8vUkhiZEZYb3NtNzdJclIrRytFdncvVmlITW5HcW1lb2tR?=
 =?utf-8?B?Qm56dFdRZ0lRTERZRlp2TVJaTEtDK1pFK3NFSnlPY1h5RjVyTDYybzNKOWc0?=
 =?utf-8?B?a1NjQk1EOGE5SHVmWFVSbm1EaDZyQktFcWxXTUZQUmN3cnNJQVlHL20zS0xk?=
 =?utf-8?B?bEh3REZsK1NyakNNczVDOXNkNXBJa3ZCaVF5TUVQNDBmMU1HQTZFOVZSd1lS?=
 =?utf-8?B?RzczSTBYajd0Q2RqNjY2dm95VmpRTjloUk1oNnVUMVFxSWpJNlJGTFp5d0Uv?=
 =?utf-8?B?aWtvLzZrSHNjRHg1R1dVNzIwYXV2NTlnYUI1ZEFpR2ozbExKd0RGRHFiMzB3?=
 =?utf-8?B?V0I2blk1UW84azlrQ0p4UWVmY0sySEI0WlZCdWFmZndIcUNwMHpxaEdFTTZR?=
 =?utf-8?B?Syt5RmtLWi93YytnT3hsdUxEWUE3ZUZYVHVaSi9WUWdpcDNQQlVoRUpPem9Q?=
 =?utf-8?B?a0tpSExTbnF3UTZ0ZHdlKzd0dVVVT2RrN3ViWjBlM3d3RXBkRksySlZPYTVt?=
 =?utf-8?B?NXFCbm5GeXMycTF1dnpVc1FNbHBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF08E43E80A29740B9E8795F6D003CF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gVuYXQyJqt/fWGGGPjA1HF1R1sy34E7w8AaeuA7mje45Q5CuycqU6CYBEzOZZHOt635jEGzxe0BVgQoqfRGTzlibcqQMGFRL3RADbxWot9hPH6JN0ICs51mp1ZzWFao8htMFNunvoPp1pU7dxeXAEFgwpi4+wM9HXXxV8iefH5jwRD9lfvHQ+PQGLd2vvYlTHj52yIhmauD6poFM6TfF0lwMFo+8KQ497B8lkg6jS/ZTTrh0XgwvvrtZzj8dnshVLXYM+tRvYNp82dSDaR6Jj18EGADLfHsFhM9RqUnZJbR9kYcY91/GS4usfhbPI/CECnnhcOhAMgOP3g3Rn8MbTKj+by4sgJGANqu5L7TZCkznRPv82gTKz7q06qlSGLH+mOYFoJQuMQtx9bE1UDTBdJGuGgAzPLx8aH+/6yH2/4Fm0/wrLJRk89oAmo5NwNTzhKZQXJqEpR+r0hKCep0+hS5vGhvbShqXiB2LUw84nlXH6Qbvdm6FN7/wu07qUSyOKJQObvqys0TyFCzHEsw2H7UL8+veiJYn8UiUc7xuJZUQCWGjtEPRRVXhlcqNtTkh/GrsKCJgXK3Gt48ZEYBlcs9gExzBTyhrzucqNrFhSHH2Ummut7JBvXyX1Q/bBCtA7iWuiIaeToft3i7nO4YeaRJ5tm0Kh0sOnD+6aCzecLfYTS/sIeqfOR9bdDAr7md/0KZcIwYV/zfTVN2XRCHoyyAWyyWWRB4nz5BVWlf41Kc4dCM/glv+fzMLtLDhg8Qtr6YEOWPvbEXxZXL3SG3EGTDryXk2PCMivr0d9G8w+Ull25mhUDOeOp5FDVl+/T2n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dcef9c-727a-4fa2-2452-08db2a068fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:19:47.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /s+vYDjgm2CRz/qTwT16rDaUvjmZbAczAtWP8LTQXb0hbf9ZC16crYSmQmbO9osIoKNeymUMm7OYMRFOyF6kVmNX/djD6egHA5gNZplhWvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7882
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
