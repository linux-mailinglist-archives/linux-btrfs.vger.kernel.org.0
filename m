Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B116FBB7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEHXj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjEHXjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:39:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7FE7
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683589192; x=1715125192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cNi/RdWS+s85vjQ044lCQhNFI7WCx8qrx9vVWHGA5UE3gkqwUg2Z8AzS
   nZY3nxAgn6LoVEVtOgSkjVLQ9YlUZhw6EGGyQ6lQMqWVygHoS51bIvpqr
   MqWRC6loUovXT7MFc+yFClP4M8/g3T4tbj/+1viaAO1VcyU9TrsYheGTo
   rU0g13LJs1eff2Bg1jusauUFiec5/jCFfn9eR5Y0jd/xFTEfO17JkfPhO
   kUbTDN68yLgkxrUR9vvc1eA9TwF74jcMUJ4JRFNFERa3asUW5MfGSx+A/
   EMxAiMYLSz2VqfFs5gl33k1eXs9FLQbFX6PKsOozWjD3DnEGVPUV6zJy4
   g==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230212718"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 07:39:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7B4dGmoyrc0Gx2Mq/M4iWzfZCowjXEUFuVOjVT+oHNmlTkm9oPP0SfA2WchhvmAVnFhSDknTWpJxCkNRu1HRllK4tBRAF+2hsylItAs1CL6UR94qx187IYzdlKh+WyoYVcYAqnArD0Zrj8kTW/v6LMQvGyuq8McSskINLioG3JrdV0CJPPxHfkckXC8GZIVnly0k9TglckQ2l/Ouk7Bz1WlPscqviMjAiDxPkbE3iHnCBKaXxQShlqkR1IlO/2NIRlVvXcKH61SdmGJL4oqV71lgVILCdnoY5S8P4gkFez0cJb5BQWxJDE+YVgNdikIqnDMrYi9dBdMvCe0gB9Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Oint4ha7y/rVU8YOS07FdnALKM69qpT6yufQUrav2O9uDmPu270ZZTE736GEoL5cg/GV3Z/iWO7cMZMiIwks6cyVQW81m9HAWR8L7tv9yCAv6YAzKqbZSGU5CdmXR5tWnExPuWX64OqI7JSrA/yTLZWAZ8SZu5uSJxCw6MuTsynRMA4TqThsoX21aVFgKgZ8PmHc2Dwe/7vtVnFTwSoXH/ZWtPS/G1RP66eKyZikpATXbyuhF+46FIXUDSatcLfowk6vqyaw4GAV3o/IJ37B6FZKD71G3sUOxBT65DL5huK33ZTtoimXSMMLw9KlvfcLlNLd0ceKoQAEVNwK/UWMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qjIn1U+qWyQgigNnx2uTCpnPAOHGqO8J8X2bIKfQ+J7PTnf9qgf580LuZZjT9rFAxQnRVLGq9+rATj8k9em2bG95voWFC2GjR5Viw/sVzUcCerl2k2UqobEfpgK4XWex/9Xmx7xCCcEegQ8lNIclN3i0ASYvsJcI+uZPBqcxhqI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6848.namprd04.prod.outlook.com (2603:10b6:208:1e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 23:39:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 23:39:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/21] btrfs: pass an ordered_extent to
 btrfs_submit_compressed_write
Thread-Topic: [PATCH 06/21] btrfs: pass an ordered_extent to
 btrfs_submit_compressed_write
Thread-Index: AQHZgcduc5SIjZjSkky7iAOJ6vS+VK9RCTEA
Date:   Mon, 8 May 2023 23:39:48 +0000
Message-ID: <8a25bfbc-d919-6ab9-fd6e-55571fdfa60d@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-7-hch@lst.de>
In-Reply-To: <20230508160843.133013-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6848:EE_
x-ms-office365-filtering-correlation-id: d623683f-d91e-4cc7-92f8-08db501d830b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rnm0f3hrKSxTlEfboGe6aXiKaE5I4gE63luivzlUvA4u90XUjcaeo/Cr9jVGURAAIFWntMX5Em1fkhP49c15udfMtxuVj+aQRTdv3ruBlE3GqQva7VuCsrltCxU/kEL6xtzfPx/e35kxPMLmKIn+P+Qj6gBNCZoUdoabRGpMGsJTLZyIPONyeaDzdDsChqulQ2Rzpea+0Pf4iFY3mFyl2hVrMyQqMaMoD3ZyioX8n+92pxGKVFtkx0Lww4SopbGRRRzxn+OLXcc/bAJhXFcEoKJRUqxKqmi1O0Cm8RSivaYFUaoPtrGj9v6b+VO8dJ9qc26eJXhFdhOhCVCnjtVBxlyUKu4dgunI36zUItxSu4PTBm4unuhYhW4qaLLjUpFTNA60tRORmJ6OUmlQLgxeSSCWK1aatY/9US6pFXZQ9qy51FymdJogntxqxH84+T+RNTX2EZWwRKBiB2ISAHBLaiybppFMmvW9C48ct9/2EvOZ7SzP4OyILZcPwQjy9OfBeQamw1Dmm8TMUUAOBsutjC2DzmEZVuUYzcAOwTZB0V5wLDKdNKI4JHNdRPXrE8Rhq9xUIbbBH1QbHcM+EYosWU3LPl5PysAbt2i/pLw9GmCCUuA7c+lqlwW1kyqpNZiHdA53Q1nTInWXEEs0ZVCQNVkH0EA7VwZjt+SIO99SlmYBeS5vJ1JVxOgjvRIF03W1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(31686004)(558084003)(36756003)(38100700002)(2906002)(31696002)(316002)(86362001)(8676002)(82960400001)(66946007)(66446008)(64756008)(76116006)(66476007)(38070700005)(122000001)(5660300002)(4326008)(8936002)(41300700001)(66556008)(19618925003)(186003)(6506007)(26005)(6512007)(4270600006)(478600001)(2616005)(110136005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjBxaU96RUVuYWJXQ2Z1dTNMeGJNTGw4Z3JPOWFJdDRyNFpCZ2tBTWYzNWxG?=
 =?utf-8?B?Q2x6Vk9iNXI4aDNxbmo4LzM4bnM3bWNsWTVVNkhEdnNwTC9oWC93SEpwQnlE?=
 =?utf-8?B?ZlZJY09VdzBQTEloRS9BRW5ZSjl3d0FNRElsZ1d0KzRiR0lTd3U0eEJ2Nysx?=
 =?utf-8?B?ekN2allvaVhvekJMVXRuenpPMStBNFdPZllKNEpUMi83UDZCbUFhbXNzYnBo?=
 =?utf-8?B?MlpKbEVsdDQwNlRWNGM4c2lpNElnR1lYbTFEUU5XelE5ODI2TVF3MEhOWTVR?=
 =?utf-8?B?bVB2Y3lobmkvUUgvenN3bTl0SHZQa1M5OWF4bU9ZcEdRaWVXQ2tTeDJ2VWIr?=
 =?utf-8?B?SXdyMWFXLzY2M1JPZWdhK01FYWdQNTFTTnA1NzdvQ2ZRNzUyMTRseWpRK0Ra?=
 =?utf-8?B?OFZvWm9FYzZCNndlRVJ2MnlXbVdIYlA3bkxTU1JIUWN4bktEQVN6TUZldHZI?=
 =?utf-8?B?MDE3UWVYQnFWZENsSmsrVUlwZUVsL0V0Um9vQ0FLM1hpSzFWUTVyUjdPeVRG?=
 =?utf-8?B?dERZNlIwUXlnS01Mbm1WbDN4eGxsMnRuWjZpQ0NPLzl4c0tHUEloMU8ycjE4?=
 =?utf-8?B?TnNoampibkhrbXdMQWkvZkFsS3pRR0VNUWhKVVVvQnByYmZZZk56QjRFRnRM?=
 =?utf-8?B?bUpPTmVyNjRuYU9CcnV5My9oSm5JemJPSU5wWm1uTGFxZnRUcko5b2tsZ0RG?=
 =?utf-8?B?UmJ6ZEE3YjJGZ0dWa0NFSnozWk9RSzdwc1hjdUNKRGI2Znl5cnREcldudk9Q?=
 =?utf-8?B?b2sydHJROGFOWkcxQlRnZnVGbWpNeWlZWmt1TmJlM0NTV3c2K3NPZlNHcFVK?=
 =?utf-8?B?WDhkMnpxQXdNb0E5YzBsNVlMN3VXUDJTQklzN1RsT1NVYmtKa05VUzdjSlBP?=
 =?utf-8?B?MWdmd2RkRVVuVFZ3am9OZGloQ2ltckpxbkhSbWpqcm1NSTU0bEZKWUJRTFZV?=
 =?utf-8?B?T2tFZWQ2K1V1ZzlqZFpFM3Zxb0NGUmZZajcyQ2t6MndoK3NabUFlbXlIQWl2?=
 =?utf-8?B?TGlibnBMdlJ2dERTMFcxYXBMTEphdzY0ZE1HOE9PKzNpMWRrYWFLTCtKRUMy?=
 =?utf-8?B?TzljMU1GQURWNXVlZVZlOUZkM3hsUkduVkl2dlRwcHJKVmJ2dXIvRjFsWmp6?=
 =?utf-8?B?K2hHdmZzQXFtZWZabVhHK042V2YrZWQ3bGpTSmhCZ0l2SlhwNERlQ1hFc2xu?=
 =?utf-8?B?WDVjSTc5d0dUTUNoZjJsNGFJV0htVlZreGVBT0REUUI2ZlpaVmxrTDA1S1pz?=
 =?utf-8?B?UTcvVWJkQjB5QStDaFc4MURlVmRSck9TZmRCdW9iNlZKaEszUUJrbmpRQ09V?=
 =?utf-8?B?OHZsZmsyRmFmVEtiZGNhSzF3U2Z4RUxMVXZ5UllwRU83dFJrRkQxU2VDS1Iw?=
 =?utf-8?B?eDd2eXpTTCt5UWlDSXd5cHEwTVI4Q0duMi83MEhCbUpsekt6Ykc5aWZJL1dX?=
 =?utf-8?B?NU1hM3NGRG43UERaLzk1QkFRT1pla3VnOE1qamxVUGFuNi9CQ2V6c1VjS0V3?=
 =?utf-8?B?UjFCTmI0c0g4d0QrbStxWlhieStYTDVuVXA0M0ZGZEl5SFZrVnRSa0RZWjdJ?=
 =?utf-8?B?UGNxTHhjbHFkeVg0YkxMaHdoWTJlZzJZV29nS0kwWXVFVWhoSTFCbk1FZkdw?=
 =?utf-8?B?WGZJVVdFakY4U2QxNTk1Vm1jT2JFd25ha1RFb0dWQjZkN2VJZHVXNVJOUStD?=
 =?utf-8?B?M1VkcE5LWllKR1Z1eGhPcUFUTWhmQ0pJZ0JiT3RES1dyckJSWEw4TDNrMERr?=
 =?utf-8?B?K3pXN3gycFJlWDM5M0RodDVoSXVNenpzLzY3SDNWY3pNYUxNQ0UwNU9pNGVn?=
 =?utf-8?B?SjE0ZXU5andBL2NDdlhtSmY3eFRqRzBkK01DbGYvZHhmYzlpQWYzMW1JUy9h?=
 =?utf-8?B?eGtSdWNoYnkzRERRN0JKcUVlajUvWHVpN0lRTWVJQnUvYjFCNHdQK0dhalVu?=
 =?utf-8?B?VU81UTZXemwyUy9zU05Nb0RybklvU0p6RVNpY2R6OHdsWnpCWWc2NHdRNUpr?=
 =?utf-8?B?QWhDVFU1QVlQUjF1ZVFiL1FHbmNkam9PcUNEdUs2bFRpZy9MYTZoVmg5cTZo?=
 =?utf-8?B?emZFczFGanRJN0VORXBnMlJmdFpxUmZpU29BQkVEYU5ETFl0U2VaOXN0NEdk?=
 =?utf-8?B?RGZGR29FbC9LZ1ZiQmZMb1BvT1MxeEorOW85TUlmWkg3QktzMC9YQWVnQTRD?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527C33CAE555D9469217F290DC01C10B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PkJWZ1xT/peXqwDPNgOibAslnM3CO9137VkGEWcPwbVZcVrFy0EDiF60tDy9PosBSsT5NssJbDO/xEY2UDqx/fjNvQDIj3NBLI3eJdKDPmyO+fQs4L7FTPVNkgdxKgF+9zP5Jp6K7s6bXQLyZngYAF7GDS+urWGWrSzTsHlHGgQgSg8Dow/DwYUhzPnShaLaPHyPgwT/kh2giZJ0/qFkM88gawqE3QwgAJcN57EY+A4Qlo/GRbkkvg8cDzaUnwbjoC64n4e5Hi1fuuNBQEGHofy7+ObN7M1C21a/bWpH9GgU+tkifjIkpP8/JKtSyYKYMh3OnpA+THSEtjZEV3ySPAbZvR0xfhfECYnduMxB9zlIzSoQ/Zi1I6Yh+OV+f7caAOzTuo9JiJyHGwxsbpGLDYr8DHFb+duQtWLZtLNAf5VxpTdec0zjwsppnuNzFqSeyjGAhhBz6dpJlOuhiOJ5Ea5aKkDd7mkldolq7vkcJVA+LLm0GudJLfadaN1TxFr0ea9pHDNAjjdc3wRDPmmGdvfnlrzpMKLKf09fAreZeuAQc8KIm8aqQhf4mCOlJJ03YL0c6Shv7ceeMB3lJg9IcWsOXYahEryMiaLzdodP6LzBistefKmcwuoxzJwYGW6BjF17xOouFBWyhse589U7GwPHJRX/QL8BeN7C3aFYVy8CkqBAsmJiXZp8ugVbwnbNaWIccOG3HiS59nzHrNfbY5vUB+FKx1HCvuwbZddqNPiaTzlFilPvDZsH8WcffEE6OO2Uv3IYmoiAM2wYOnaM31ZpYk5XV+zM/zHevyCh2OpFwzhVSj9ZXCHEoK5w7mAkWDAb9ibMWbJgyM97CxuLMqdvKLBf0VdqLoJmvvFwhfg7OrmylMBfjIR9sxjk1UWI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d623683f-d91e-4cc7-92f8-08db501d830b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 23:39:48.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0LVpgDl1cMp4FmsHtYAaNjsYn4wnbsp9eCyBMZ1zS0naByTxci0C/LWlIXrvA/SvcfYqtFu1ElBjEK3/YvqKw0z7zKaokdBtMxtmbUJ/OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6848
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
