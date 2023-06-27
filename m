Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BF73F60A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 09:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjF0Htm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjF0Htl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 03:49:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE3F7
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687852179; x=1719388179;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=njoWw0R4HwT6Bw6pRDoYaf9+QsEYtFNypvNxaONicDmMALvfhOq61p9l
   dpJAfd8qifnjrS8VeT8PmAW2wOsR4Hfp0XdvVmaciqmElci0Z2atonOSk
   LZJEJAlptmhzPvhRoD2FdGp5hP0MGa8OaEtq0IlZagyRL4ogdO+49979v
   jNSuUSDX06uQngVzCixVy9iMyQo4dg14aDIEDlGtjP7hPwjcZT98KYE4b
   HY7Ln7tq0yvwoQUpzf91KLksyrcvjPF0/mYZkG/4P4BnMpP98Qy3AubwU
   1knzXtb+o42qjo8km6XrIPmdHKzbeMyfKdSsvxsDjRRff0EkqRNVrFB+l
   g==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684771200"; 
   d="scan'208";a="241297039"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 15:49:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THjcw0ZZKO0laiI1NFwmd/o5ii6QKFK1FNlpmZICWjiSBWKN/eQLSfrkUkDm8aa1ildpTKHUmotb7ZMyes5GgXcckvbp1hJRM7pq0tz+lHUJS53G592UTUZN8UAbD6v3dTPxx7WE4UxQWJ9cv5R9XW7b4h50Lz9T2vZ+DvAlhUHGt4KaPFh/f2zyz9SPv74JTcxTZDkRnkyTANthg6vxk047A5K7nkpVTYT3Ftz1vDxjo1Lch18KliiGlsvxK1HZFqu2ZkgM5QS/sDj1i/L0lXRrw/N369GC546AiqmCZPqaE/fP1b4m9EYJMRk10YXw712NtWuxZp6a4/uBFCqfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CgCcEBdAx+RZ2OZgqKQvcVHi06uw4CFhDbvecvhiCAfiVzS34E/VLPvTnoXFOa0leREZ7z1cXiug+ChVVkYGB5ixo0upDySh/lsGUXKtmvuKBnh6Xo8uTOpAt8BokYuAiIqxnN6uPV+qYLPSQLshbGh8d4SJwHKjulYN/LQ5mRhWUshnHmBV/Hlpce1YPOa4P2ALeGLYjE5B0RgOuoffCs868Wef/KmVh3OIimPuSaOkRzXyPx7uEraOxtIOpv1x879xkjdgW0dUSakGp/mTMaDPHCG9UsxhAkYnXitSEPS92skWY5Z9xT0e+R0rbU0Rt2qSVa1INNmi8qF1+4KbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=d1gOfC0b1rPashlpj9j1v/kuyrHXNrzOpiJm06q7jkz3DXrhIbCtz7mLw7bZBnmr1n192SduccyNPvgPxtw9ZwSzmfLi+AW1QhqpoonRU1f+DKlwXeCyCbjyTT7M1IYvZp7MTMB5TPJPP/BwG6WfCCquipMEG+iTpf4podA/RqA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:49:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:49:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid duplicated chunk lookup during
 btrfs_map_block()
Thread-Topic: [PATCH] btrfs: avoid duplicated chunk lookup during
 btrfs_map_block()
Thread-Index: AQHZqMNV/T7niPeUikufZSgc/36k9a+eRk8A
Date:   Tue, 27 Jun 2023 07:49:36 +0000
Message-ID: <cd37320a-570c-6f59-6162-d3d8e96d6707@wdc.com>
References: <c063726e0bdcf99226ba474f93b56f9fd2f939f3.1687848314.git.wqu@suse.com>
In-Reply-To: <c063726e0bdcf99226ba474f93b56f9fd2f939f3.1687848314.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7081:EE_
x-ms-office365-filtering-correlation-id: 8bb4ba49-7a4a-4ec1-5c2f-08db76e30de4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lszbfILnmUweEdwqGtDkEa+KwGdX06pr4mRxZyYvrWfS0c9+4mAxPGuewgi4ef1oM0pIUleOlHHgoxRjXfwxPiWKaVzrjSDIsxRI7TibB4Ds93t8BdD0TwgDv58IbU+isS65BVN9FPj9WBnLLHQWS7aMIVQkeNip5UeqxI30HmC7LTq9sy3Z1axRviGYNrxDVSs/bGDRP0Ie/B/yUSHGw/PH9wlc7sJAlEVrCocP/HZwNV4lHfVCo5lZMHVxqsAY8zLPem12Kg7SXvu76U1lR0a2w+ZYPS6lSkkQpk1dbyv3h/lixSrmkh6Q77Sqd+aGzslK3kqrykZomk0XSNSCZgEX27aDNJPwwNAiGkA2LX38310f0qtF3uQduAkJyvSpz+kfYVAxpEPGsQxIldCiH6XccGr/re+FCY/zmlaxXZk7E+eb7qv919giEPJbbocvWjA8jrHb5R29kkLF5tM7ZbXmm4jq0gTE5wwrzwrW9fKyvCdQMFzlX1zzqc563R5n6unA/aNyMT8E7zf73HEXYlLftEQ2Bidnoqkv25YZ47Ef+1b5obF3DdRYrHa9dRWdiqWT5oRyI723AB4fdidsW33YZlDKjP9dlXx2u5h5bZFy/A9met1aLwuRe0Xpi3yOI5aPHBs5y7WiuLF/OeF7vNX1s6T56lx9WlDBmHRGZnPNTzDGrr04HL01JyZJt9Uv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(8676002)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(8936002)(66946007)(41300700001)(91956017)(6512007)(6506007)(186003)(2616005)(4270600006)(110136005)(478600001)(6486002)(71200400001)(2906002)(19618925003)(5660300002)(38070700005)(82960400001)(122000001)(38100700002)(36756003)(558084003)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZUSkNHSXJKWS9qUlF5aGtPSDZmaHBvdlpVOW5mWXBFTVNVT3NRNExXNkF6?=
 =?utf-8?B?Z0s4eTNyWDJycWhwOEdyaWNtQmxOY3lhbzVEa2FMV3JwUi9wUG1iejBQN2tM?=
 =?utf-8?B?WUtDcG5aVVBIOFZLblpPQnFQZ29adkdOb2pYUFpmY1RpL1VkQitLYVVGR2tm?=
 =?utf-8?B?S1ZjSTFuMCs5STA5cUMvRk01cExOMFc1SUgzdkx2emUzS0N0SndIZWo3bU1N?=
 =?utf-8?B?OXA1SnNhOVhDbkZkb2gvMDdFNkhVSHRFWlJJTUp6Y0h0UXFLY3liUGNrN0JY?=
 =?utf-8?B?dCtsMjZKQVh2QW51YlhVM3ZFakwzYXE2aUZnZk4vbGRPL1d2THp1OWM5TEp2?=
 =?utf-8?B?VGpEMnh5dDB3NUZzNmZRVlJ1OFU2aHNsbnpvR1h2VDh5NGxmMnUySklldzRU?=
 =?utf-8?B?QW5wZTkvc3c4ekRWbGtJdlhTZmpsOUFmeHNvUDBnSEhvL0xqUHpkN0hub3Fi?=
 =?utf-8?B?OHlaVngwL3hrbHd0MHVtaEhaUkhwKzNzN3AvZHhFTlAwQkxpSDBsY1h2S2pQ?=
 =?utf-8?B?aTNFM2Q1bG9lekpHcmhuUmVOSmcrUnVGNHhsMVBmL2k1YTBWMnJDQlNMd2VS?=
 =?utf-8?B?QWtGQjRleXVZMGpkcGFqQVJZY0dpQmRGOGViVjlTSkJ0NktSaFdMNnpOTlVQ?=
 =?utf-8?B?aUhaM05JbFBMR0wyemFzZFhnSzJNaHdRMXIzLzBwbERmMkdzMTlkK3cwcU5a?=
 =?utf-8?B?RENZaS8zM3BjVm5LS2ZHaHB5UStWZURNUG94dHhUWmoya3JPbmhTZ2VVNkt2?=
 =?utf-8?B?TzVITmcyS1BrMkcrNDk5UjZoYUFTRUQ1emVXRzZXekpMTHNvekVlOXZnS2Vu?=
 =?utf-8?B?L1JlbW1icjJLYUdJbkk5ZTg0YTFWMjRlUnBoRVNLaVB5QXRnNUh1eEZzL3RQ?=
 =?utf-8?B?TG5kcUJLN1hsYXNobzJGTmFXVFpTYXFwdVpyR3ZyekFwdzBXMytCU1lmZzlH?=
 =?utf-8?B?QWxOZnIxRnhEclNQVGU5dzd2R3ZYMzc0S2VjWXU4SkFXTjNEYW5CTUxZc2J2?=
 =?utf-8?B?WmtiMmhYRE5LVVBPTkJRa0ZCQVlQQi9aM3Vua0crTU9EL2VnUlJuTUtkQVRZ?=
 =?utf-8?B?MWNKUjNYVlpRa2t5RzFzbkpobG1Nb0VzWmkwM0xub1lZcm1CaDRDVEJodkNJ?=
 =?utf-8?B?cmw4c3lhaGJJeVpQWW1SUzFwaldCbXZCUzI2VVZvazkxSGtkN2lOdS9hVWV5?=
 =?utf-8?B?Zk9mNGcrNzdyaVNuQVIyWGRnNTVHbEp0Rk9FVW44UUgrM3NLQ2d4dWlUL0VO?=
 =?utf-8?B?N2xzdTJHRzFFcVlFc2tyMlA3V29wVnluSXdyUXU0YmhTdmdlT2NHOW12aGR4?=
 =?utf-8?B?MlFETHRGUmV5VGtFQXp3akJESEdlMWtkSXdSSnRwVDF2and3RUpVRExXUVJm?=
 =?utf-8?B?YkdzZHZuM29yWUV2SFJPLzMvbVYyQW9nbi9SZnl2SHVuNUpBdXZud2FCMW5q?=
 =?utf-8?B?UGxwdFlCQkdQOGJzMFV0eHlQZHphOGN4M0JPelJtaXRrbG1uKzVtajBiREpL?=
 =?utf-8?B?em51dS82bVVpaTI0VjVmOWp6U01yQzAwK3d1TC91RWpkdWRhU2k4Y2JlNWxZ?=
 =?utf-8?B?SzMyeGcwNGRIZk1ZVjlETjRBWFFWRU1WSm1UN21xMUN0Nm9FYXpTSUN0SCs2?=
 =?utf-8?B?Y0g0TnBkei96dzJ1MUVxcGVuT2ZWS0pXNXlPTEVNYmhOVkkybUxKd25WWmpi?=
 =?utf-8?B?c0tCWHA0ZzZjUnBOWGVUQU9uRUZKYVVnYUtQNElvS0tRK05JVVFXMExPa2po?=
 =?utf-8?B?ZWlrWGFwMjlsV3F6SG4wMEl1WldvWUljUXRyVXVzcmdUSkJDY1MxUFRCNTBF?=
 =?utf-8?B?bGhtcDE4WXlxYjJ3djVBWTBWY3FmZ3c3QXB4Rk0ydnVQa1lGWmtVNmxnc212?=
 =?utf-8?B?MVFBSnFQVExGZWVnd0d3eFFNNXYvby9PZVBSUUc0bGdXZ0ZnQkwvbE5MVXQz?=
 =?utf-8?B?ZDBlc2FzK2xPd3dMZFYyY29xdmd3ZDliWEZzS1ZSeFhyZGhVTzhpblRiKzNp?=
 =?utf-8?B?c0pzai81anM5U2lGTzl2VFNEa0NHS3hJbWhGWUtzVmp5Y256WVh2MGFMMG1w?=
 =?utf-8?B?TFNWWkU4Sk5JS1pMdXdUckdZekhxR2JLNHhvb0dlZ3lLaUxhMVhNNW9EM3Vw?=
 =?utf-8?B?WGRORmVEaDh1bmFUU1FGV1N2eGZDSHFrbGdXUnB4Y2Jjejh1ZklDNUZWQzZT?=
 =?utf-8?B?aHZXdkZ2dmE3dUg3K3NtQWl2eWxjaVZCTEczSkQxdG5vUjJIMzB2WXlGeUgy?=
 =?utf-8?B?QTcvd0FCYnlQR1M5KzFVdUM2anRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913F5F5200FBB44AB88252EA7F3624EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IGAaZ2zMom3IM4nJiP7EgL7V6tPW2i5OAPAuN43PPfwFfG3nXppyLIr6U341T68lSloZbQ1RwzBCN7PAfiFiE3CSYabVU6IUm8wUl0GKYetq5aUqC1T/UrECelU2If1LPEHZWhmQeTvDkpR/XN4wLJQT2r3DLBEpqh+QJrwQR+XYDwH9uwZJFYMWpbZPXWpKreKD28Kt29QCLzqrJ8Ffo2AVDDPyZZAo9rDS7EEmwli4Qn9cffeKPkZKImffiitzNCHfkihogoW86FnXrq4T6lEzLZNDvnmq09U5DRm50rv+eLtEEf6FgKW5/MYnpg2biCuVoM9YY0o4UYf3ebTD2CxcuRuOdcURGS3gpOjg3dUZQSYL4QQ9HZ69v37/b5mCILFUwuXBYtJSfZ01h2I0KArT0Mx8n9Fvti1+gmerTCSj1cMcuIVXzJu55xSE2CIE6KsANu5lHo7mVJDdgpGHYKOTBwqc0a82kW5qGsXnANQFrZLYLcSucMhdXNtuSolF/62Etp0OW/mysxQLOK+4f87Ec9MMM+9/+gLeZ1xT/mOGyJPGoccKL3ZdUam1gHqL9FMeF0iFJAJZZhiaRfMKmolJZ+r5Z8/fIrFn6unb2FvmvKwxWO8vldbuqReZVH6aSpgHb4PkoFxVQ0K2xwtTB0fztij0BIcrSqyMnWBovJcR8gbCz4mUXa0inzL6cyvX2T/xODFoSgIDtZu1zr4McTWwv+gmv792p8gNWGTwukQqM+Ww7g/GSZInaOpZwmPGWpXc3oB1gzG8ObOLq+reUY83ez2Upo3pvpJvki17aoVwzU7owJk/bFJcGaDOe8VB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb4ba49-7a4a-4ec1-5c2f-08db76e30de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 07:49:36.5165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S50PIW5GPeDfOPYTsdpos4PqUpRRgEOEmBEyJcM7fX39tBja53U+KeU7Yp3d/EI3l5/2lbzpUgr4JK1JxJFmfTjPDvkHpvvfoi/EzCCEVIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7081
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
