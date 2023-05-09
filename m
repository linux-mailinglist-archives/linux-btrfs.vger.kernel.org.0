Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF06FCA90
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEIPza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjEIPz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:55:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B42D58
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683647727; x=1715183727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZjIIqOyXYul28u1ozLTAhWn19njG1ySvsJ2Tg8ClzeQP4QolSOZUhvpY
   84F5zjcp8GZ8OpT6lqZ9YIp1CdFz5sHBBtbQGHQkfXbrwnegO0sBYtLeS
   keFmlVuuoENv6eHDPck6i+whlNm+3TC18Y774klRoL08LEpXkx/Lw8/Re
   eebGi7MfTHLuXHPLPLqtZ2GQGzlyBtHAKJKVcNIkqsUbDghJU5+XRQ6MC
   HNMGe2WkrXfAx3z1HtTvH1M9vVL5fGbiWSulT75yo7L7H3po4S/kPtDhi
   ax3+wi89XYHvESCVPH+bwVbL21w+fzfEHeR+8nOlkt2velC5KSvjp+lyn
   g==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="342297764"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 23:55:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1nO4ZR+vCG8BxlwavF+wXY97xSujeasaLukm/coAP984GH707J+OZ/X59XdiPwDwTFNA/SSbcMFd7iXng5LeTtNSIVc+YrsNvUbC/ju9lUfgcykM4XUPqT3rfHPoHh+qwKGuaaET9zybuRfxtU4EVZ9pHdMWzUA++EMAHhH02ZWfrT1cmd7FiFWmy4UCCZ+ASIYDjkDFJ6Q31HljRjxLIeURKQFwnbke7jiILm8UQXaGDlVGcY/mlI5V8GWnxqQ/QbS5quxfY+GyaC8rD0/6zIjCuDMVwS9pj4wID8CzMFatpnH5psu3DIMrRysS6vXcz9r7gJr8xiOWMRfuNbSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O4sq9n1gqL+S8JBvFF+c3J6cERFWjsUckLGzuGOBs/FnHm1AgP9REw1Eb3MduWisjOPe1jp1SNPpoaK6nWnAaY3MmmrnIl7e8//4XcKfcx4sOCdycqw7zzDGF+O8Ts/YiMvOWktRjnf7xh7z/cz56uumC0q1jYwB6nbbhChwPThXuevp0ypdp9B6Udw2SzVkGBn6VZffktCj81cW7j/TNHIFNNsh1q/1e2k8B/XJ+XtR8026r4I5Z7ghnRviUpT0bKsYbk18iAsKUYNhc2oMUW75vbyZSCpk3gXhaDsFP/8R8SqVQfs8ihf90/7OSsOatHdDLaDpBBjaVn//Es+9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SDujKnAo4ylUsZJ4e4YdRSsG5gNstmM776+lY2QhoZv7u3iP/FXx+hRtcjB3OzHuw5Rt3DJDf8WAbU0qZSLXlmo7G409klYkjexafZvRWu5hgfIat8qgblBvtz+dn11D9oQSNpMtwW98/wwdczvcQXC/JEu7uQOkW2Zg0o3sVnA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7643.namprd04.prod.outlook.com (2603:10b6:806:143::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 15:55:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 15:55:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 20/21] btrfs: open code end_extent_writepage in
 end_bio_extent_writepage
Thread-Topic: [PATCH 20/21] btrfs: open code end_extent_writepage in
 end_bio_extent_writepage
Thread-Index: AQHZgceH0aHUwvoU0USJUfGoh3wJC69SGbcA
Date:   Tue, 9 May 2023 15:55:14 +0000
Message-ID: <8fa5e805-f2ce-8b3e-70ef-f4cec4a34667@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-21-hch@lst.de>
In-Reply-To: <20230508160843.133013-21-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7643:EE_
x-ms-office365-filtering-correlation-id: 9f55a526-780c-4a8d-201a-08db50a5c71b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5A+fVOfvQlzl6WZ+3qopxnuMLAfUEuZCIxSdRdBvk5//pqRs6g7v+qcVoObyP1o7zuv7u/mWd37swe0S+watFyM0GbYqYnfNbT0/8XhDargv5G0K23dCGHKNdWMnN7TcFLIH3xE5tvgduYnnLEqd9asX5Dstm9czoWDQSGwUA7B3SBd21gT5vUTxVF2MvQcVp28wksYoliWo+uitGrH/E2YJSV5xIVtA2ijHfwA9rzqQQbxwCIn6Ce+GUyrvI7L04VF8/FDl739Sy3AC1VImu6cHx7PxEM4k8MAlz3gc+ApAV7GA9DZwT3KnqI0dVPNZ5i5D05Ph9MGY4re/tq1lA/urpiAj9GP2XOJbRPbUF4h1xs/0x+XvuX8va9ofpZ+Q2Fn/2ftBYUyf/FBoS2lnGi8bMSA4/GRDDpOvR2fcpLUWCFxKd25xB/p7Z27KAfMp6Eoj0LxKjK3+O0m/oG66fgrOzi54zxh7EfgVbd7D49JBn5T+B5okpVCW5BjmH7GDtdaJDBjp7Zd4vF7DCxHtXaLPgefonMpMaX5+mHF3Q4mgWzDNj0eiHdLSedEzspy71g0lOrKarp0telMyxnWUIshV7MQ4KOBfHDuz1CTm25wwceKO1yVtMABvtBI0WFr0ExqOF3mDlwcbBwCo2JnFF8X0HfC01XvbRqUkxkOxP+8WD3PwuIBSVxgpAwJo98d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(2616005)(2906002)(478600001)(186003)(4270600006)(36756003)(6486002)(71200400001)(38070700005)(19618925003)(6512007)(6506007)(41300700001)(26005)(316002)(82960400001)(122000001)(38100700002)(110136005)(31686004)(4326008)(558084003)(91956017)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(86362001)(8936002)(5660300002)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk1PVURpbmttblgzNU42QVRRZ295TkUyUlh1eEgzcXBVRE5CeTNjTFc0YmJD?=
 =?utf-8?B?YU1kMFYrbUJMWHJaamZKRWVSWllrUHZwU0tjU0EvdEZQeEVJKzUyZFJoNito?=
 =?utf-8?B?ajJROU00Wk11TU5STFIydVQ3aktEV2dSOVVmRkVKQWd1cFFpcmtqMVdxWW16?=
 =?utf-8?B?V2JaaHdTbCtQVityUHUrdysrQ3hoSmN5d0NOVWhTbVhsSUZ5TGZpV0t3R3BL?=
 =?utf-8?B?NnBvM0FKUW9ORWxEa1BuMUpNQkN0WHlpS2RMNUJnVWdOV25LUTFNTU10MXdI?=
 =?utf-8?B?b0pPSitIYWV3RVFKVEhjZmVQSUtrOWFpaFN2MGUzdm5haDgrbHVtS21vRkFC?=
 =?utf-8?B?R2dwUXR4eTlpeERuWDhPYWhaSlpNRE52ZTZrOUd5c0tiU09IcmQxWUI2TkFo?=
 =?utf-8?B?WFFMT1NNMndmbjA5UUZaalFMdmErZEdoTHVtK2cyeEpiYTdlWE8xMWRjSC82?=
 =?utf-8?B?dGNsaEFzamxxSEsvZVJGdmoxc3BvVVZobndMZFlvVExKNnNUTjRLeTRnbkxG?=
 =?utf-8?B?ODFwT3hrZGRNYjhpbjRDcFdoMFllZ08vemw4REwyUkVJVWlUc1dCMGlDbkJJ?=
 =?utf-8?B?RW9CWE9uS0FvaGI2dWx1NUJoRnFrMitLMS9LUldmTitBdnd3d1BoT0w0ZHBG?=
 =?utf-8?B?VjZkemxEaEdwZjBLaFF5bmVoa3BySmxWMFZ1VmxSTklabVo2VVZwekhXMnRX?=
 =?utf-8?B?Y2hSTXR3ZVE2cFRyV2FHZG4ybkJVdWRwNkR2MXN3USt5QWRWR1BxVzhGN0Vw?=
 =?utf-8?B?aXdZYzdRMDVaM0o2WHhYUE9LWDhCT3JhcldSSEdwYy9kcG9VRFlhUUM2bVRn?=
 =?utf-8?B?MlJ2NWpGZXVqc1BsK0VlRUZJVEtzTy9CVjhCeGl4RlRoSWZVQmFrZndQNjdn?=
 =?utf-8?B?QVVzbjRLVktjTVZSNXBaOFFGL21XV0JsdDJsVDlhNklwQzB0RCtVbkV1Rms0?=
 =?utf-8?B?dUpxQ0hGWHRtODViU3J3ZjNxVTZnbU14clJXdUYzV0pzVmFNVUhmRTJFRDZT?=
 =?utf-8?B?emZvZHFJSGQwK2JNQno0V21lRDJWdVJNY1M0ZUpPZXRkRW9JdURiN215OGVl?=
 =?utf-8?B?clZGWTNycEVhK3pxeWNkOVdaLzY4QXkvekxBeFVwNmZ3YUNqK2VIVVZuaGhE?=
 =?utf-8?B?R2p1cVFTazFKZ09BclBYNjN4ano1WmZCclB2cFpYTlBDSkEza2g3NkZZeGVB?=
 =?utf-8?B?NHRhNHhncGJreGs3YThqOVV6VU1taXlUaWY0SkFGQ1pRN0lGaFBRNW5SM3g3?=
 =?utf-8?B?eWo4U3RGOEtnM3M3a3RodEpPanNaOE5TRGlZdXZxckFYOURkSSt4NFkvRXJO?=
 =?utf-8?B?S1J4TVV3KzQ4UXpqcE0vTDlGVUlrZCtCd2hBbkFRdXpzTnYxTWI0TURxRktI?=
 =?utf-8?B?R2RlWjU2RFB5L3JQSVlwb28vZjRlRkk3bUtiVGlJa0RPMU9oLzY3VEFrRStG?=
 =?utf-8?B?WkdheDRIcm4ySEZ1UHpTZnprL3hmVGt2VWM2WDFYeCt1NVpRa3g5RHptZmFu?=
 =?utf-8?B?RHorMmRiRjhMeG9iOVNXN3QwUWl0OERCTC94K081a3F2TGV0elpVVDVsY1pa?=
 =?utf-8?B?K09tK1NGNjlsMk5NR3RyREZNQ1pTdVlEVU94M084YmlWUUVXRUxIYWtqMUFu?=
 =?utf-8?B?c3ZBcHkzTWJ1dEhLcHdTVnVTdjU0YXBybTBkVVZlWVQrMTJ1RzFRcFYyQ3Vp?=
 =?utf-8?B?Zk84V0xnMkxta291aGQyNG1kYVdaMHFqQ0owd1VLRC9hdDlqNjF3Slhwdk9o?=
 =?utf-8?B?OGRNc1RRenoySGFVRXlaUVd6L3ZmZjIwZzZRSWk2YitUWjJKOFV6NTNuYnd4?=
 =?utf-8?B?c1BRcXYxOCsyQnNFb0Vrdm5NWUxCMVZ0YTNMUVBFek50M0ZmN3FyZC81Wit0?=
 =?utf-8?B?RGpydE1HU0IvTHIzWkgybjNUVFpoSjB4bnoySlBpRE1ZTWVyMUNEcytXWmFj?=
 =?utf-8?B?NmJrQUVVekxZTldsajN2ckl4bXZlUTlqZnJQMzdnOStjeitOYmdqZGUzOHpi?=
 =?utf-8?B?eHJMMFgveldoV2NuSGxsZk1TWjVESDU5Mnd2a1lhZDdmUm4rVTV5WklaOVRx?=
 =?utf-8?B?QkFMeVJxZHRLNVJmMTNQR1JRc29FM3NjcENwNG9wZFExZXNkNjZaeEFUdnVk?=
 =?utf-8?B?QURBQm0xSjNNZ2xWS0xqQUVvVVQ3dHBWVk1CMXIxNi9vWkJLdTN4YThGZk5N?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC24F275F7EC14D9E0686614C99F7E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t5u6GUL7WDzQFWL44jayI/MdprBY6GXxbF3q+y7dEADe5oW5yxBjU/knj0W8BNsUXqVyMRb3ThzJQmwP8njQkBp8cw3U4DztjQOwvcjiARHFGuAMrHpsZ3Udwg+CINEv2+WIPftnRVNr1uXoLx/GC3Fceckr+QoSF/PEmxcL/2liycFydLfC7BVTndpbQdUO1YdogN9FaQv12DdCMmHDNkVvA3XfB8jDvpgftiaD0vOdjFEeecF7XyooKqxJBJew+x3OxzNm3PnJKBMsgjh4PraoEKApEBF26Ho1mmKWuiVbhtgR0xIn59PrLjxpyIbMfp4/gCv0yv46eL1NKpJD6o/tcVLd0LX2Xgg+egFpwBhLhz17ra+twl6qf0w40dxeQxGAbW6Vo9xCgTnVJJifT/arD3tii8NyLzQdcrhtwMKEoJOoZki+ksGUHi+BSKVCpDei5/O7Nzp3H63eqPrXb8r04HZUko6Acv2Q22R9yXP8cW/fuf8M9Ds4l8sU8R5r4csSpJp0bJ1bi8lOd7Ry0RmPxg70y90bek36gy8usm72X+1SAWLagD0r8bVbw5LilUAvV7idW9TniTgi//d1ezEmLnfAd3oFQpqjLoB/MsT3smYlKX/+F2kd1XO4O00FfO3UKDeQPHi15Wkh5Nuah6wXI4uo7h0DTFsWrvgalSEOc6hc6Ruk7FC8RWbwmo/yQEPRvO/f43O7v6WdWqPjTssHxjrE5R3CXm2zYOHCIWvzaHlisslXurC1ckygIyDUfDSqCBai2p4Eq6qrTqJ1yPGq/OUIa4Z1IZ7zlSfY+4t9g6RUkex6vCSTJLxS3/HA6JgFkerPUrRZTvTN1mHMKjbPjzFpAJAlrUKe+1ANlQUOIjCiYHFGJNrSqeMLDC/s
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55a526-780c-4a8d-201a-08db50a5c71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 15:55:14.2755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jg0oYA+u/v3i7QZmk1rabUWcxFX0S0z4bSgah7rVCaBEhSnFOouYXq6ctx1hrCsnYa1hPMgTinmg8MZrw+p6byRztt6iSO/Uctp1sCQ1QJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7643
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
