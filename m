Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457E07366B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjFTIvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFTIu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E010C1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687251058; x=1718787058;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aCdTkALM1wslinfUkSWFVAYjjqHiBLYsxZhz8MEOZJkWZ9j1TFwMLuQD
   NVFZeQLUWQlt+s3YttGjwnC2Jz2P0qxB5CS2K9kJl3uf1am+k4+vKJ7V2
   hkgwz5tDPxzErd7+0nesVRAZhOJAY1hCrYvWKrb6OfvlVJJOyD2UuYB7P
   8fvMq/VMHDUIWFdLrELZSQNxz0ZcQUXN5+4SPxLMDeMZ+Ghaqb4xCxRU5
   CnJQ3stnErbvXq92YexXV4lrMGes6zK+kx6fHnuVQQTqcsS8srBm7RH4x
   O2xHJOTs572rjKKr0xg182GaaoGxTW3FefK8Wzdfp0KSRMUP9rHmd9464
   g==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; 
   d="scan'208";a="234440015"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 16:50:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs5CeOOjFBXkFVLB0g8q6rzgjB6Wv3pimx4TYKfN9zo8IDtbsCQv7B84bOXX7oDMG0NT8vdc/5oRiePUzDGT+x1ROJRghJH7SHxUWCLNF+sASwKDY9WQI+uqjqRvVO2Lve4gG5D94sdD11JtLmPZAfSirXgoKRRVrct14ORZgQmMev5s57X+IHXuzzdv3v4zTfxdngMe/I/pQIc7whPiyS+AKs1qOxeAWkrPQEhCoY9CPK7aRDDA4vaP06C7+2j0eMka2/x4j3pKEhyfLAAtXwTRTSOWjgF6dgsqNsvoYupjrs6g0Pa5yWZFdHFsN+Io3CzzhZ5wUqkRIy7Jx2K+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dXUGdCdlK/JlN2odgB6LVFdMd87UK3xG1CbpArZ+RKEGzgATH4Gk086Z4J53YEP3/BzP/n7M10xU1uMVWfr/FtrwWYJbLkvzfURtnsXN0kIqwnaxtpaKfJHYJ4M2RHLWeVtUjxG/yH8j6vaH5lhJeyQM/A4fZwODlcKFknK7U4mfKHQvdIRUaJsGIVyoxV9rrpAHpqUAlGN4owlJ6v24QaWe6RYgkYfWeEFtl4SBU7kKkKsItboK5EYDpqj5NTqTdbygOrCJoFERZqyCVFHnHKD+16+mGqOI0k1uF7gftyVE5FBGdSS4nba+zMOjYssqezgArXR1h/Tmlirp17Cvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ts/9ibPVZQfh4PE2zzF2TfFiObhfLQ5eW2xa8L4KwfViuYksvNqMg1uZA9XazUKyHCz4ROveMCRNLGPVLH/EQxoaCGtoyCHJtSYebUmzCAL49ZC0sYRog0SctrThtq884cm36AV4FF0rQhWqmTO5J90rc/xOUaXo5qVHo8f8UGk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7973.namprd04.prod.outlook.com (2603:10b6:8:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 08:50:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 2/5] btrfs: scrub: introduce the skeleton for
 logical-scrub
Thread-Topic: [PATCH RFC 2/5] btrfs: scrub: introduce the skeleton for
 logical-scrub
Thread-Index: AQHZoNm006Rnsj8Tv0C/6SXLfPGZr6+TZvCA
Date:   Tue, 20 Jun 2023 08:50:52 +0000
Message-ID: <8d117a8d-3678-42b4-dbb4-625f63d26dfc@wdc.com>
References: <cover.1686977659.git.wqu@suse.com>
 <16be0b6c52962fd3657c7bc09c00020ae72cd771.1686977659.git.wqu@suse.com>
In-Reply-To: <16be0b6c52962fd3657c7bc09c00020ae72cd771.1686977659.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7973:EE_
x-ms-office365-filtering-correlation-id: 84fb1dba-bdbf-486c-fac4-08db716b73f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KpSX9UeyL9dm4fpOK8KwvY0GTJ86xikELLgs0mwn6hlaH/yMFSeklTApABunEb6p0+Nyotc8LD4LTW5poTMm/PSow1CTqr2m1JSfFwnTAEqWIYMM47PnZhQoBXg2DamzK30Q6Gh0vSI3mcI9g85j2yYOML4iRTudms+QETqgusSzNZmcDOCl8+EwrC+LsmYDu2/Kdwco/flD6Ln1pHml9ORAYM22aMFW/s7ddaAb5TyQUvNRgo7nIwf/B7mtzrPWwgZ8g2B3maM9DHzurTx2kfQtlXMcJLb5bH0nhbQdKEFLVh3aAISNxhcfv8V/hDRjLSMfySkfJFQAzQPrpzgT/EAgLMriVo1fHPb4BWCckGC5sXYhWbutIo1W37hdJnceIrgRbCmQpyLdTmPhbWj9vCH/ayQW3740G+iY/akFGEA2fVGn+XAWl3CJLdBFLPJXq96Tv6BCemmpsMZilyd9xKt5cInALGeinoKkO0IspYUvQJw1OoempHWiMS5tuvafyYYRgbnfaRpvQ1alexUgupj0D4DS1U+CUCsBuHSQRALf74TJbaXSA8QpEJsYM4ajny+Vob8kiTaIPTOBTXbiydaGLd0y3/un9TiDi5mSxW8fOW3dkkW/VikPbx0QALnBNd1+uNyTNtxqGqirVe2XD6zhyfIBC9i0lj7qG8nhNXuTb0dn8tQf8KcFJvydqFJv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(110136005)(6512007)(6506007)(186003)(6486002)(41300700001)(31686004)(478600001)(76116006)(91956017)(66946007)(66476007)(66446008)(64756008)(66556008)(316002)(38100700002)(82960400001)(71200400001)(36756003)(4270600006)(5660300002)(8676002)(8936002)(2616005)(31696002)(86362001)(2906002)(38070700005)(19618925003)(122000001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0pNUlcvVXprbk4reUt6ZmJZU3h5OHc5Qk1QOURibWhyZjRSNGcvT0VScXRC?=
 =?utf-8?B?TzZjQjc4RmhIU0NjMHFBQXE1NThQQnNjVjIweDdoSkNYeXovYnhIVGFETEF4?=
 =?utf-8?B?SGhEVjArTVdXUVVUdzR0emozdTdmSDhIalI1ei90cERMa1ByRnRQTUJTdDg3?=
 =?utf-8?B?NTdrMUNrWDF5KzJaUzNlTGRyL0dJVGRrWmxpeVVHd1QwRG90eHFuaUxlWURJ?=
 =?utf-8?B?Z0dhUXBZMllWZFd1bnl2T1NNbk5ZNmlSNW93OVpJd2lqdi9ZQkwvbk5wUDVx?=
 =?utf-8?B?dzVKUlhmL3BtNW53OXgwYXVvVXhKOEp3cVVDYmtmVVFwM3B4djZKWk1Ba0hm?=
 =?utf-8?B?ZFhlVzNTZ0hKT3g5ZHJVVHpCRFBmZWpPQmZTRUNlU290U0NpTUFsL0x4djNu?=
 =?utf-8?B?SUZZTXBVQzZWcXFiNlU0OGVKREFScGpFSXRvbDNwTFpKeWVZcmx6ZnFHTzB4?=
 =?utf-8?B?WGVvQ1d6cGIxQ2VDRVVBOEg1cEhGa3ZuTEdHdGZGTHd1Z0E5cGR5Z3Njb2pX?=
 =?utf-8?B?RVZWeGc3U3RiVlNKb2Q2RDVCSFpDdnkyakt6c2NJN2s4Mi8rRjVWK0wwbFFn?=
 =?utf-8?B?cDJVSFc4ditxVkdhUHR6Zy9jOHROc3EvekhIVmJiUHZHUkhZeDZ3QzVnMWMx?=
 =?utf-8?B?bWJ0QnNsYSt1WExtRkRCbmVTT2NVcjY5dEs1V1ZSSUdZR29rNVoySUV6ZWxI?=
 =?utf-8?B?SE93ZjF0Unh3bTQvdFc2NXVMTWxWOW5hYVlXcWczaVdPTkowS2xnTEFEYjZR?=
 =?utf-8?B?NlVOWGszOWpIVVNiR3pFWW5mQmhlSmM4K2loUWJvOFFxM2tGOWxoUUpBd0JX?=
 =?utf-8?B?aERLQzBpa1ZUWkJxa1pWYUxqbmZ6MmdJeXZIdDJiYXBZbHpHRjhDcldxUXQy?=
 =?utf-8?B?eUphc1JrV1BjMGU5Q3MvR1k1Vi96YVlKZ3lnczh1dmxTcFp2UDRudnFaaE45?=
 =?utf-8?B?V2JkZmxSV0J3MDFtajRtUzcrNll0bkg4blFKbGs0ZHhHRUFmYUpORXZYemdt?=
 =?utf-8?B?OTJQQld0UGlMV1c3T3l2S1FlWXMxV3J5NS9aalJtN2t5ak1OZjcvYlE2MmRu?=
 =?utf-8?B?a0pzQUVDd3VRZ2ErLzVhb1NFTGE3cFhQNnZreHI1ZDFOUzRaK0VEYitQbXMy?=
 =?utf-8?B?R0RuYjdOelNsanNSQ0NDS1czcDdlc3JwdVZNYm5XN2NxY3lUU2dPQlN5elRu?=
 =?utf-8?B?cVBTYVBXRWwwc2tQZlJqMXZ3azh6eGh0c0pQdUtZQjFyUW5TYm1FeGtob1Vv?=
 =?utf-8?B?cjdQYW1mSnZhZGZvajlzWFlxY3pyRnEzc2ZDWHNlbXdkYUFwditaWEdWUFlF?=
 =?utf-8?B?NTNFWDhuMkJkYklKeVo0a1IzZnZkTWRLK2EyRXlMcGJkZkdPRzNDRWVZN250?=
 =?utf-8?B?WmVQQ1pNSnREM1V4eTd2RytZUDJwYlk5ZHJDQStSSUdHNzNkTjNMZHJsdVVW?=
 =?utf-8?B?MXU2SDk2NCtJQWY1RE1iaWJ1b0o0SEZiSzRwRWtkSVNpYXBTcndlcVlILzJr?=
 =?utf-8?B?SlNzNDdOL1JNUzdQZCtJby96cDlwbi90MWtISDhZTTVQRU9xdFJ4cHRnN2Vu?=
 =?utf-8?B?YjAvejZDa1VJZnRwam9PUUdsdjVEcGMvcTFtRitsb3czSE1uNlB4OXl5a1VZ?=
 =?utf-8?B?MVFVNE9zM1diYVRzV29ub1lQakZHZC9aS3lvK0lhOFhiY1B1bFpBak5EakdQ?=
 =?utf-8?B?aHB1RHM3aU8ybHBaWUxadXJGazBBQXNpT3IxZTlUZGNKdDdwSWJicjZSMkFk?=
 =?utf-8?B?M2NTNTRQOGp6ZDRCai9yQmhmNFB3RkNScU1hSjdLemVxcTFpQlE5SGhkZWJU?=
 =?utf-8?B?dWZnWi8vM0xtMGh6SS9tR3MvS3IrNEpINlROc3RjUE10TE5OUnVpVVRqcnlk?=
 =?utf-8?B?bWwwQzFVd1VJVHAwUFFoaVhud05odERrUVJTRnc2b3UvV1FyTzRVU1lMT0FS?=
 =?utf-8?B?ZFhKV2wyeW5GSkJQOUlIOU5XMDZOSEdub3ViNS9OQllEOTVYZk9PR1Vpbldl?=
 =?utf-8?B?ajdvb2FSb2d0Q0dpVVV6V3dSb1NFNk1OS3ljNEpFTTdHSi9mWm1yMEo4YUtE?=
 =?utf-8?B?WUlZdmRVbVMyak42Ui9NckpQTVY0VFFFa2R1MkI3LzlJalBuV0paVzBWenhH?=
 =?utf-8?B?d0VPV3ljYldTS09OL0tWc1VUWU05aGIxMWlMK1M3WWovRG5VK2xRWFhMcndY?=
 =?utf-8?B?UDYxd1EvS2g3OEZYQnlyOFJFazNjWUZlTHVvT0tvenl0MGNzb0svUXIrK1J4?=
 =?utf-8?B?SklzQnBJY3MzZzJTdVJ0eWxTa0VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AC15CDF6301214582F56D6F542CC73E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /S60oXisBwPmViKIyQRF+kn4pCf1BCtskf0JUbkmyYZYnJmDtmkATwTuo+eTdJeI3udCXcvBskGnTp5h8nbD5myW/7nowRaBb9E8jDAqU2BQl6eFDtKIGP95jbzYNJ0n5DgxORkCGuQpi0GK/4CH6xValuIJkSgdDzlRmCEyKToKpD+7uS/kXJEGf3QoAPWVA2UzPP9cY4AkcbiO1aIZHiNRAZ2xmNloC5UurAhIwFO7F7JFZwksFkJDViR8FTqCt22vPtvJc+V1c6hn/IrEwIwne8rNRwif7zdmlrj3bJCvnkPPPgQzf2jwGCOExtIW9N8QGSU6gp7IuIqmjDqWT00LQ+FFR7iyndSncK8vDiiZw/CoFyfi9PW8+zpAtYX0OLME3poAgLXvXZQ3H0nDzQ+SHWqo4j7m6uv30O+cVS6ufWfs6nW44Km+WvoTGKFOxyc3gvoAav5TIrGoSWcTpJCLxbeo5eUc2aRO1BlHkBiz5ahqoCi/Tj1lgFM0OS0V5EZc7vkxKLytxlK7ouVWTj67C4BqDNgpde3nqeGRzXPIWqFFXyIS08Gy7TMxGsnx+PW+axLTTSeHOSebWed//0Z7n4XbzYQ4ubbpfR7ojFR0L5bL1TplupzsjZg57H82d0TIWqlE/vsxiQXRZQNiXw6ThKDoQ5p3Ql+x08EIrSM5900vIoak7pY7ANB39jL6+lPV+T5jsE8ObwHteb+4nL9qnTZ2jm2V1LINKf9TERfUPa/vZdQQxRN8VYFYubHScxl4joLL7h3hBfbbhnV8mzgQdDu0rfjfmieyBxv2xcZcmqCapKIxVB+0Xr64x26F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb1dba-bdbf-486c-fac4-08db716b73f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 08:50:52.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrQgobJGBiCe3D5SH2K2119SLOhYllXsIZYBiQ1jarvxv7PW+OkdrjOAr1H2Tn2YRET0FpGpoEMQViQ42QN4dggGFFEp3C3WCsHyoeHKMgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7973
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
