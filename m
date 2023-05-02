Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D676F4270
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjEBLQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjEBLQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:16:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ECFE0
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683026167; x=1714562167;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=EacuMNDQ4pMLVzPE5S9gngDZ5D/UXPTNNUGp1xngFv4IlV8cNfx8jEQ0
   5MX+tfbBzV6FEtHASTEZTkKXCuJzaO4hxUdDtCX7omLjWHsf2LJ0SIRhc
   e4xa/XVgVwxa5fkolTmAI4Wgl4whsFyDSmiZbrvOjN02Locx3W2Dgt4hX
   ywfYz8hoiX12lXH0ORmQkqn9a04BXhaaiqAxYJ3jBDJZ8Ft2zgbrNd5Ed
   TftZHvltOXQbo0tECx5whXbcciZFmXvxQBDcvGzQIL3LVdgOXPsjwu0+8
   JR/WQtBQXA0CG+T2RFPAuBFzanvC1504C7Dvj1vs3kfjJZGNFGfjbhOn/
   w==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229601399"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 19:16:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNpsAmTdjQGM9NnmGi8V9qFNKW3LWyExZTxWnv0igbxfx/NeBtqgsURWXeJhCXy+ZlGkHC2veNTC75ragR6fTYn+Vpf8UUIGxplBiObsH4uSR8bYuunLPJFh2ljKcwLNPaP6roK78p3TSEi8BF10gIQJwn6ORq0K9hQXj2A5LMjsjZ4Mq5hnvEZts/Y7BiIEMu4eyNb6xRTE4wKXC1g4S59UVYVghLXjMyxNGTZhIuwzpAkN2WMbym6hsIwJ81Pq08yrA7f7Tgbkb0T6KX2e9KHHVEanj9X0i4vRjffxqNlEWROmrYw6AdcLIw5EyebhLsNWLNX/U3CfBcWrDmKK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=an1wrVRBJmys8oWyjtnau/s5UA/u8scBZrJ0FfglCB5KSR1R6gNbLPBWWHdTtD3ejKyjBPxpLC0S0BtZNWXQ0sqdVFLJIFrAaHbz2ss3lKuC/pq4j7QGKWVJ/F8UZEcSqvVNn6Awk7s+JCk6lJXmGhNLNKk63dD2NmfomqM1hLH/iOa1yQcJEILESuwtQMY7HAyUDFlsSKIqLkwM8TgCpUGlUVRD5Lz97c5vLojKOv5icTMky28c9l5v5sVK/ihSlVAaWx2a3YCWpZkkoqIpllqKbFrdQS5RTIp8WIsRSB2xlZq8VmdcIuTq4gQkX5gsIdg+Q843eGkKDsstEizsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fiDgHNuVc00XZEGx4g7kz8ybi0tA9+daClV4gyHAuRbsDfruIB0i56dRV+fvPc1s9x9hcE3neGfdc1AgvAJcwQX99GT8K2L5KO9VgZXVnY2egKNjpdlqhqjWWUzDYIRclzGf1STwU0LR0nfzDQparEGwIPmjDNS/O8lMA7IHeO8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8661.namprd04.prod.outlook.com (2603:10b6:510:248::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Tue, 2 May
 2023 11:16:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:16:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/12] btrfs: move btrfs_check_trunc_cache_free_space into
 block-rsv.c
Thread-Topic: [PATCH 01/12] btrfs: move btrfs_check_trunc_cache_free_space
 into block-rsv.c
Thread-Index: AQHZetZGgI8QyCmEE02MYsglLTNXZ69G2UYA
Date:   Tue, 2 May 2023 11:16:00 +0000
Message-ID: <4364ff17-d0ef-274e-60f6-1a8b811afd6c@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <2b127b68d0e4faf2e0950c16dcaf4d0d4542a232.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <2b127b68d0e4faf2e0950c16dcaf4d0d4542a232.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8661:EE_
x-ms-office365-filtering-correlation-id: 397dedf6-8b8c-41a7-024f-08db4afe9c73
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t62a8Ng1o+AdFIGjOKsLFAw3hwNB8NmhSdh5qyQUSS3m0e0lxnRkbB5x2PYocmQYhuiZV19F2FiVaieeqLBK7S/bfX0NVaM6ID+NG/XYn5l+R0exA3NqMMO8F/gEeDucv64yW2vqI2Jl9KhK6HEDuF27obwnC6wXYQEBf4OoxyNdZBidFU30Qhju0VXELLB1/cnasifBGbx56DMWuH8Gz5kd+vdKfWCDiJdb47Dwo47ZPfrxNr1IgRSwfA82r8Vr0DjR3Bt9MPOmZOE1svP+PVQs6bg0AcLZO2hvvhD9jGpFX2mvJ3E5izweRRdKRLoA6276iQwNW7fe7vhTYAM9vY4Vfl8mphU19tFkoxKdhthIEb0R924E7PzaaIF2j//4TF878NInP7WyazsI6tz0qUxhaPDwobNj6TwcEREnRxPfZhdNwiZwSKLD1oMA8DzqcEuPFoQTjom+lWMyDz6c/+q4xftthLH+eJUJFbeejjvjbZ8ruMfq1Pv2SDybMnC5qkFW8MY/cwJxYpksEH+i5P0QZWKL4QGYV8vghtpxSdkgvKNtLfMosc5PqTBp/ZvOBXZ2ywZkRlZMBQuWJUBsCX4QBsVcoOryOVrtaD22lAUICr5PWORozG4l0/sAzwQjKwPkwL9gn9crZ+ZguiZOWulY2ksD1C8Rk0qxaJgwDSON7h4f3GU2GpzumkAd7EIU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(6506007)(91956017)(6486002)(478600001)(71200400001)(110136005)(2616005)(6512007)(186003)(19618925003)(38100700002)(5660300002)(2906002)(36756003)(38070700005)(8676002)(64756008)(122000001)(66446008)(76116006)(66946007)(41300700001)(82960400001)(66476007)(558084003)(86362001)(8936002)(66556008)(31696002)(316002)(31686004)(4270600006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUdsVTV5SlhLMEpTcFVLRFVrbGdqOXhXT3VnRm5VNXFpRlFpYU5wcVdRbTc0?=
 =?utf-8?B?S25ueGVPLzA4ZXI3ck83ZUhwbUJ1MHNZeHU4TEh5RVdFTDR1OVFncTd4OVpl?=
 =?utf-8?B?SXNSdUxtbU1SUkczUnZQUy9NN3p2QmJRbUROb0RTV2Y2cm1kc1BqZ3lSOHBv?=
 =?utf-8?B?QVM2K3Q4NzhDZU5RS0ZoQlhCanpEaHgvV1dJZ3k5RXpiVmwrbXBHcVRTSVdi?=
 =?utf-8?B?a3FqMjk1MklwMkVnT0YvM1ViQ1ZDTEd2SlJKNlNUWnJRWSs2bVZZZzdpVFVR?=
 =?utf-8?B?enlVd1BFUkhEdlk1RVFOcUdCbEZKcVBIZmI3aG9GVnZMcnp5Vnp2MWxDbGVz?=
 =?utf-8?B?dTY5YzBsZ1BQL21yNTZwbjJhVmVaWEV4dXdJRWRtWGVRQzdCbXV2RVpMemRK?=
 =?utf-8?B?Qkp3YzdGUDZtWnZvU2lCNE1MRGJiMktYRndxZVhtT0xRN0w0MXJuSHJJK2My?=
 =?utf-8?B?YVdlU2gwS1MzNkx5UDRuTU9ZaGFqNm5VVE9IM21TSjdOalIvU1JGWU81RlJB?=
 =?utf-8?B?ckhNSEJHczcyd2lzaHZGN0lFbnpab3M4WUpVWGphajk4ZGpwNjR3eUhYa200?=
 =?utf-8?B?N05LTlJrM3p1c2g0SnMreEM2ZzhhWVRqMGRzMnYyY1ZuNXFQMTd6TUFNNVpC?=
 =?utf-8?B?ZlppNXcrZ0pFTnFaUjZiUGZyakVVdVc5c1ZFcmJIVlFzd0ZiMmV1Ym5IVlpF?=
 =?utf-8?B?UTZXUXBvMXIzU0lqK2VZS3pnbXJRa1B5d0tyL3hGMnpZQWUzSFFuTFNuOCtT?=
 =?utf-8?B?ZnhIUitESzhET2I5TFU4TGVWcUYwYVlPY25Lem9zS0c1UzZ1RGRwUFl2MkFu?=
 =?utf-8?B?ZUt1cDZvbHhNNzdmVUVZc1dyMnRheDRWMitQTDB1RGV0T0N0NzkxeFlsUnBF?=
 =?utf-8?B?WnhCVDdHWFlaZG8wQ1F3MFJnWE14dUlXR1dtVWd1KzJObEVCSlRHWnVSc1ZR?=
 =?utf-8?B?QlpZZ1VzRUQ3VVlHY3hrUko0SkJpZFg5aDdITnltcm5zU0hUSVhaUzRCL294?=
 =?utf-8?B?K1A0L1FiVjJJdzgxWE1iNlJXemJ6dXJSMDQ2N3JIbUVWVm5OL2NQSHFEcFRM?=
 =?utf-8?B?SGxTVWdNL3A2U0l5TEZySllGcTVUMTl6djVBT3IzWWlzZzVwSHZLM1J0V0c1?=
 =?utf-8?B?bGlaREVMaVVDelBuRWI4eGJOcjNhbWE0eXdyeTdCRURKMzFsNVBDVGVxT0Jy?=
 =?utf-8?B?RDRRMU9qNHZFbkFJV1ZJNVBCZmJyTFIxWG1GSXJ3UDNoeDdZNUNGdTQ5QnI4?=
 =?utf-8?B?ZVJDSC9XcUYwWkhtbDdvT3V3TGRJT2JoZFZmaGxqRE00a1JiSldocGxodDkz?=
 =?utf-8?B?TTNzajVObmZudFRsdnpFRmEzM3VPeDI2T2R3SlRJbGRGTmpkeiszN0l5Qm1i?=
 =?utf-8?B?NEVlWitaYlNQWURES29Jdm9PYVdkaStaQW0reEpMcGRJWGxZOFp0K29RWlRy?=
 =?utf-8?B?Q3Y5bmIwbnJXWkFiVWYxZVJnN1EyRTlmbTAwNWxKWXBXOFdZd3NXclJEUXVR?=
 =?utf-8?B?NE8ycVBMNEMvdXFCRW1FQ3lQeEh6bDVuc09zSUNSaWhxQ05EK09SUUd3UzdO?=
 =?utf-8?B?QzZ6b0xwMG03UWV5d3FLQXBZbnZRSEI1aThodWFidjNieGd2OGlSaFZ5WmJo?=
 =?utf-8?B?THZoNCs3Wnh5b1hCekZoaW5QZWFyZWQ5TWNoVitXNm9QU01MMXZlSXBlZW1z?=
 =?utf-8?B?SmNUYSt0U1dpR3B4YThTV0hPVCs5UmJtL0J2YWRtOW82NHp6ejBCdFhoUEhv?=
 =?utf-8?B?cnVUcVVNM0h5SHFUaFQ4N1NJOGpUNDEwS2o0VkhtRmk1MkV0NHNRTlR3UUpL?=
 =?utf-8?B?Q1lReGw5enlDWHUyZWNCKzhrUWlKS0REYWdocjNGdG40VGF4SVkwZ0VaYysx?=
 =?utf-8?B?c045RDF5aWZrTWRNUndGOEVBWXZ0djhicTRXK0JadTZaY2Mzak1OMkZjK20z?=
 =?utf-8?B?TmV1eS92RytBMXJsaVRlSEFGckRDMEdyU1B6b0tXL1N6WEhSQzVBZ0ZGT3JM?=
 =?utf-8?B?VUZodms2TVUzSUlNM2JsT2R6cEpSbUgyZ1FXMmJvOTBOZWNxcTRXVFhyMXJL?=
 =?utf-8?B?MnRpQ1p6TFg3V3ZIaWZ3L0RsT1FwK3hCWGgzUmEyYUpzT0pYL2xLL2JuWXJU?=
 =?utf-8?B?SWlhRmFaa1BMVElSbUY0cW9JMENBWWNsTkgvdGVLV1dFR1MzV1FjSkNQc0I2?=
 =?utf-8?B?WnV2ek5ObmpDWXgzdE1HQnRJV3RUaHVBRS9mdmRlZ0VZOUJ4NFV6cVZEenJT?=
 =?utf-8?B?ZFRJeUpQZldVZDlEN0FBY012ZmlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8C3AF4AB94BBA4A9A5DE1D1887A9E8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 554S++FmUaqSSFOBSf05xZJkqNlgZ03/RaZctzE5vBhoz/lYYBY7BhP0+Xyd49IFZk44iYeg9WLbqEeLHDooetRsxyrlyExjuWyaayu5VAMR4zIODJt9A4UnvzfwpWicZRGNLYMExNIhaFGWHyJ3kmGLfbpYuWwBDksL4mVIJ8SVGdRrqUY0My9BP7bjKPhms4kEJXxhSt3bV/g8iA1kd/c2zKbZEEFBiVW20Q4b3k0Oyf8Buf3VZN+x0HkmbbPuvYfxY5VxjGtrm4rRj4WJcjg2BS3/8elcKwC4cDrBf36TO/LVRJcoPrhk3DkR1dUBi5OJYfYYSIiWHqJ4BvfEtfUrPmCH85hJb+nJoSC6CTl7o9j0TEHjxzm8u3hj5MVAewg9zmuPG5HlUDF9n78YCmFvJl6HJt/P7VDdFYtHli+/9mHQ7Fp01MBM2KlUrGfrhAt1oSKtNc5W3GvXEVyuRvQKc4nsUwOCuoxzvrdcBQIJWmU9L6S0u2c6+rS0IgvNbqaKM/FqSy655KxIQR8zMpPD9cXUT57G8iFjWOC6IcO54ZIxLPQaGty7nN3aGhNNr03/6SwoEV9fuKNgJR5F092U2Vgny06jC6MN9rXY4US06CulhTKnHEVCK9o4fotyTb7FzF0RTg9YBTjSxIYPaMYKy4RPjQ9E6Vs+cmlqKO80KK0e9dzOWcPJD+v8PXayfnSs8Xf35oARBzAFVN2G6uE3mAxjaszRnk22XjclBxyEFnxzv54GPt8BBnxjY6O/CqTn8Qf5uElIj32c/7Ja5fUeYUGrcAOhgBNvwTBderaCkV/GHOtQxquz4mQ1Vq5kOeOnIWpew/gBv2tS5SCo6w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397dedf6-8b8c-41a7-024f-08db4afe9c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:16:00.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIYslAcYdvPhcTIeBtu/bFeMR/kz5cpcQUkmZ3YAOSUrH7JAc9Xqo/K9q/Qjaru4ZJ6xYnbN8miygeD1OW6goeqnMAFqKFSUuMT7SL0Wvyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8661
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
