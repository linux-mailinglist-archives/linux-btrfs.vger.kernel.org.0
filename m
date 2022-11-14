Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD1627711
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 09:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiKNIGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 03:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiKNIGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 03:06:47 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E45766F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668413206; x=1699949206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=opMC07nAYjO90wLCcSEie5jzE2KZwZYwQT/K3ZjqAuC3oR0eXuE0wyUC
   cXRmfRrP1LFD03X3U14p1ZGigfCEsqLJJfoJvEh5WXRaWAEzHShkfRO+h
   4E2BYYqxqSzxupVMCO/SKKpwNpJFg0EZokOHgZBe75x3wK+efI0tt84r4
   OxarHKGoAiXw4E3ax8aMtKTtDDKiWPeRzCt6arIzIC1TW4jWspAy8DeZA
   qeaH8cQGJ4x1xGs1SneWgag+Tihqrj09sbelvv06gSLSHDNmtvsrxStpg
   4K5Ypd5fDiu9AnkEJtdRMg0yQtRUgNRtdO5tR8iYnDL1qK0Mj6RDRZ6dZ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="328302011"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 16:06:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCp1LAzdb1y+xiDBFmeAaXJfI9TXHS5b3MfDuQ2+mqt3Ch7HirVp6nTbxtPT1XStc0Zs4mpcw7ROaNalc+6kqsS9zOV2k5ExOLaBGjYSfmNg7cCd0FihMRZjy5PCtVSwO/4xT7FwX5VsUQr14nRUfhPm5CpmTupHDUGtnJjCl9+6NhW8Xo7IQfRU6k3OcehjytiElQ6kEFfvZpU1V1o1N05veYaeYw91tI2QLDDZJip71Sk+KYGQ7Ps/EGEC7rxyrY6LxaaCT1SKQH/ZIa5oOnnl4rtr2abKZH8GOVzFJ6gfFRAh9NlaJT1/TJSPKw2mIUDSWnxZL9uMjv2egdbG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HuRIGZMuv5XcNfPHGOiUVDmDl5BchcyDFIoHE/Tjc0Aq11J4dfGqQs7lhBjp+Vz0RtUrJc69jk/N78/Qgqx7WAqFuHo/kF0vHhZP1pmBWF2gv3+n6LrvBVSpgqfOAu9he7EstaUrdZkc9Vq1NbWb0LEE0sHVXogjv5aZmAp3aFWJu1DBABHBZv0+gQLBN61RjE6Qu84b2wiitHc5F6GXNqEFp/Tau9RlVmksk5GnNjUGKGAMBkgIScnBr07f3sClirFyEciunKcq23pAi1t0xnA7nPWdqqi7kNgs5Ls1FNaQhA9RDFpc4aKZgkq2umT0ZHGMDv8rlB7U8bSky+zvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iEnIZWmZx3CJ4PZHxNcjPxfCVMev96Unb/YaUnM+8IIIlEOlC2Jsk4uhLDSRlxGCQDyAzcDX7BgBz07zrHFVMBLtRtIXOYrZqJNTQK0GB9dLAyqmnR8E7Cn4GedLV8YplUaXTh3FiIEYNP7r1rIh9dHiaE2BtSrFgm54oPAvJpU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4690.namprd04.prod.outlook.com (2603:10b6:208:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Mon, 14 Nov
 2022 08:06:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:06:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Thread-Topic: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Thread-Index: AQHY93xp6EWmY+cshUmArA8seaVrja4+EReA
Date:   Mon, 14 Nov 2022 08:06:43 +0000
Message-ID: <9df40904-8c42-4bc7-d02e-8f408130bc1e@wdc.com>
References: <20221113162416.883652-1-hch@lst.de>
 <20221113162416.883652-2-hch@lst.de>
In-Reply-To: <20221113162416.883652-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4690:EE_
x-ms-office365-filtering-correlation-id: f35ad90d-d3fe-4064-2ea1-08dac6172b47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/i8VmDJxDQ8D+rYYK2XK3gY62aoJvgUvPLnTW7X3jf6k1FJ4o3+zLZfVfU2vygc2/imIOEGa6NeYY9wYCNwJcYbAhWCHxznDwk6d/8v5uLyDdc0SHTFfN50UWRFExqxxZFDYjzeSFLqK02Nzt8f34UYt5gbMBSnP0eY0AUPBiYASszl0t4sqUWq/VPBm1A5WJEdZA8khF2eGEUE/voGtzHT8gcRZaiy35IUGv7xV5DSAH23WU/fm2SFq4md0OAoedmkRd20kZOD3AYm07EX2vb6JcEcJElVVsIidHRvA0hPte9+37fqHCk9lUjl21blyPPp8egZm9OM8O2qW9ofg8YNB1v3cJ+VTdltuZZhR/ZNG9H2mryNbvni4jp2TnIykwTI18V8es/T1yQY+Zjk4xxyjxfOBrjHb1MnrMC2AsWb1/M/THLjLYQuwf7e8Xo6ohLxqfOe+6vRX+ZpmxLedru7UZzxEC0/kvf2VHZSrsCTaVM2/jNptUGR63cP69ZdJAI2C88LSYc8uQO+p0W3RSjpscQ0bUKCAlbZDln5t1HU4lQglP2fAsfa2iVP/ETG4M6e7o7uAArgQZtJW7z1/KFkIAYSv6DxSe+aClnFAQuwkzZt4AFoGfvCaHPiHAtP7ehybNFHnSUKPMK21GBQbdqcGkf2xspS9vpXl2KAcg4gBbAv4C92kFhhBAEMaeVkVsVK3cgQ+vlKVXD+E243+djZ9OWC8lvO4v47gunQEfsITioMvB5mkY7amSoGJ6K9mekFvCGeA2XPkQ8D3aPyPfGMdnKI4r50rMI36a8GdcdCBnVeQpbRjJECTknQK59+2WtEU+L5L18Y6r8rCEE2zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(6486002)(5660300002)(19618925003)(6512007)(478600001)(2906002)(2616005)(558084003)(8936002)(86362001)(71200400001)(66946007)(36756003)(38070700005)(6506007)(31696002)(31686004)(186003)(4326008)(82960400001)(4270600006)(54906003)(66476007)(8676002)(66446008)(122000001)(66556008)(38100700002)(41300700001)(64756008)(110136005)(76116006)(316002)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGFEOSs5c0JIUjY0K25mMnJROGJFd1VMdTNFa1BpOVFkVk5KZzI0UkNqL2pL?=
 =?utf-8?B?Nnl0cEV2WUF2dDdpaWdmK2ZtamtkV1J2VDVHd0FxVTNuc09wU05hZ2wwYXg0?=
 =?utf-8?B?b0dsOXNBMFNwYno3bVRWR2llRFoxWjBXYVQyUzY5Z0tieUpFQkg4U0w3TnI3?=
 =?utf-8?B?NzhORHRSQ3EzS2RCaFBRaEtvTElveklML0xYUGcza1Q4NHJSaE9kV05vMzUw?=
 =?utf-8?B?QjFlNXBmUkhGcHJWRStNM3NobDkzdDFpMUdscVZ3RU04dkdNNjFsNFJ1eVBo?=
 =?utf-8?B?Ujdoblh6SGs0VkY2ZWF3QmFyODEwd282OGFsUWJZaTZkQjhFdTFuT1crU3h3?=
 =?utf-8?B?cU1aakprMFdYQmJ3amorMGgwVm1qZTdmNUdtTE15ZjhteTBkNHdwZ1Zxd3Vt?=
 =?utf-8?B?OUhwcXN2bHMwSnVESStTNjNVQUV1RG5NdVRlUE5DcW96V0huaG1hakZTL1Rq?=
 =?utf-8?B?by8rNjVlSDlYcm9PQjRTeExwQXRQb2hKTEhsVm9xc2RtajJOajB0L3VqNnpR?=
 =?utf-8?B?Uk9BMGtzQk5nNnVLZXRiK29zeDlEaXVQUHNZSXpxemVSNExyd1BFZVM5MDNE?=
 =?utf-8?B?MnJUQ2xnU3ZheFpkb3Joc0Y1cTJLQVR0SWR5cW9aU1BOcGZPY1lJajZqQmZZ?=
 =?utf-8?B?d2VhRWVBT2RjQ3J6TEhiZWo0RlR6ZlNxL3pFT2t1T1NCRi9lWG5YMEV6RVE3?=
 =?utf-8?B?a3EzNGlVOFlYVW1rMlYrcDE4azh5U2FZK0hyb3MvVTJweFNZOGw5bHhuRlAr?=
 =?utf-8?B?RkhldWs3WUZhckRwVXEyTzRiSEUyR2s4ZXV5dUtSYVp0WndnTjdxMlEvVXBv?=
 =?utf-8?B?c3l3Y2oxb21wWmg1UUNqSG5FRXNtWW8yWDZGM0xqU2pKN3ZiWnlTYWJpNmxR?=
 =?utf-8?B?cjFXLzBjbHBSaG55M3hYdDZCRVBwTFhuUG5CZS85ZTV2NzFCWDNuaE9kZ04y?=
 =?utf-8?B?dWpkRHF6QnNUc0p4bGJBZHovc3QyU0pnclNXZHdSeS9LNWFpMjM0T1NKcFVs?=
 =?utf-8?B?TUJxOUtTOHJFYnp3cFcvZVVuMG1zaUoyN1J5eHpjaGRRNDFXeGZscHFKLzVT?=
 =?utf-8?B?dWhJYjJGajVJemZ3QkNpQ3RSSFZPVE1zQWZ2Nko1OFU3bE1GK3lNdzdyN2do?=
 =?utf-8?B?bkFYOFpKbnJicGE4MkthbDR2cnZtZ0ZlS3ZwRFFDQWk0dHE4VEFSTTVJeXdL?=
 =?utf-8?B?R2FmdkwzMjNGN0RZOTBMbm1LSERzdi9iSXRHUDJzU1pNY2FxK1Q1cng1UHVY?=
 =?utf-8?B?ZWFjakVXVWZYbHhBTzMxb1IxbDhaVFRETXR3ZUl4aVk0eUJSbjZuZEEwRWxR?=
 =?utf-8?B?SE1DdjFlcEIxUWNrUW5ENXZRUnh5VlU3YkhMY28vZ1MyTXB1bGJheE5Ud3Nj?=
 =?utf-8?B?ZnorZmtpampYY0o2L1lJb05xVVZsZGNUV1pmZUhMTFJoVGN2dUZBdkRuTXR5?=
 =?utf-8?B?QkpiWXErQm9Tc2Frbmh6SThpeVhaSURQT2wzSndaK0FsSjRMQjhjQnF2UDhZ?=
 =?utf-8?B?dHk5Z1NSa0Y5emJ2WnRQYURNTXFqODBocVdndExJZC9uYnNLamlYOHFrampK?=
 =?utf-8?B?STBGUmRJS29ocmxPcnE0bDY4YnI2eVl0RjAvenpjSmllYSs5MTllTHpacU5u?=
 =?utf-8?B?V1EwTHIrL0JIcDlWWmdBMXQzdmVkZlFuZlZObmFKbDJENmozeGNuNlJXSlQ0?=
 =?utf-8?B?dHNqMWQvdzMxRmVSVE51YXFjYXVxc3dWbUFaZlFaaFJiWFQ5WGFBdTAzeVgz?=
 =?utf-8?B?aUJPa2dERTF0N3dmZG5zTzFQbHUxRlFwQ3Nwd1J0QjNJYTF0V0l4VllFRmNw?=
 =?utf-8?B?NFdZRndHUDZiVlFSQkpSbmNJd0Z4Qy81MFhHcjVQYklZL0piY3ZJcEhNdVRJ?=
 =?utf-8?B?V3p2RFVlNGlWemg4dHp4REUwTFBtcUxBcXFPeWRCa0xWdHRJdnd2aTNsOW4z?=
 =?utf-8?B?Q3VFR1RrMER4c1V6bVk4UG1XYTMyVXk3TzVhb2hHV25DT2NCdi93UnZ6bFFN?=
 =?utf-8?B?cExMZ01uTkx1dFI3RmQxeFdSeExXUk5FUUgzbXRkQWY2NzdlQkhxSTlqMFZZ?=
 =?utf-8?B?OW1sNmwwdTBhSm9VeVM3VnBsMnBxVFcwSjBtb21lWlp4T1pFdWxaRThkVzdv?=
 =?utf-8?B?TVdHa1VVeTV1K3lpYVpUYSswVU1Mak1YZkdqMnhQK2NaQlhKT3VvbXNCZ2x3?=
 =?utf-8?B?bWVnL3g3NHdyNVVadVcrSFpoSlIvcGtPU2dwTE5FdlllL3JwdXVBZUJveDhm?=
 =?utf-8?Q?Qyl5cP8wP51uHE/xDBvHaJFI5mnRtEWFQQPxdUzEuM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C80CB2EE5E76054AB058F502AC924083@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rx/wzajX56Wqli/sG4cL+bPQCLyEWR4vL66OpHbd+6G2BF8MLitDE1lyj0djnIBTO+Z2qJpdWtvHlAG2HD+ExpUJXgJGLXc5XEYLZl/2H9Dz0QqqGnC4kTdmraf1KxInhHDnrXsy3/mw07R3KZygh09TTfYwx1eWOQul5gpFuuIxvqNfwf+kBNQS+UI9eaKBUR32zpOs6DMMDRKNWuvPoE2Ocl7puEF4AgDEKgC+Jo1Bix/SmhYW37VYiikxPPnkGPdfPrti9emHfVKVe2tGP7vrNplVSbvMbvX4FlL2uBkzbSzyx6RlrlVbLyWpz+4A3ol0i7ri0vWoIDqYRVaQSHM8X2QblBAvReGkHsDkjciCQncX9XgZfiu/YHYUgVkZGLm+qyOLRAOAPC+coMiE37JC7eI3qlmNIxl4X9sBojz5XHc4ir4VL76/u9fk7B1QXevS2K/w9uszZvL23yPFV9YiG66NrIsL+1LnMHN6HnflI55Tg7Kd6A4NO517YfhmSPB4tUoBv6VZBJ53v0SgYpCfOddxmqHRQxid3Ck/3StZTRGwQYKfTGbmWQ+W2bwmfN9bFIHaMPz4O/bj9KiMcEKiGvNgMiM5SIufzufv7Bxlqq4juWKxZBwj5ffI1xjnnP+H8DAg9MOs8Kys/QzVQTrnk9+6kDwzJ4QFEQQQaiZr5afVU5KVzUwpUfOARtmMjYWCTCuI+HCTpna9L/UEBXeBHwhn2U/+ysqF3UBgwNeavmFm21eG8tlBZUmfPyImnG7xxeVt6GdfSi2todxhOVDhKCRsuw3IncVrIy0nDgl2iHbey4O51xrjIr4ZVkKMXIPLqefHo0eEZyryDWzrWr83A75MVYnywti3l8di4E/kQ1ymZXgruPr5OgK03S4qzuVwHMDeyE722+n81Ksfmw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35ad90d-d3fe-4064-2ea1-08dac6172b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:06:43.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CgxuFSRo6WZQiA5ZMjeX5uEIo04bZrRQ9iUO3UrRKhYDeYz/d4NS7rnRmmfkgvGNXiTG7km335FRa8JVL9/gTlIomKHbeJ7qLkwcj66EuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4690
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
