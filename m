Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC30724844
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbjFFPyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjFFPyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 11:54:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5DFC
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686066842; x=1717602842;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=WDVr8vcJxm6yjgJzjuvpydSVHe885y4jFttqvBVHuBD5ng+NOCn2RNX2
   +i74hvOmnaxTtZ0Y7Pa7FNDTcWatza1MtfTV1F2p8dSch92DZ8dEqqKCt
   oDvTHLWclfIV57XhoS+q0ESdct0EDzA8QzRI9amjIsdtgWOyeizBIrmy4
   ij+nLk8uClgfuPx8xsfYRa1Dru91Pw+Plj+gK3VbkQKuCncQMl0iO15+J
   9XfXMipiUP7VW3NUyniO//i7JHVwuOu361JHNyRO4sGP8XIZ6J/e25Oon
   tu7Mf44LRYM46WY4tKQM6vV1VEEKr7/h0GX0sEBI/iitA6oOvAly0kvXH
   g==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681142400"; 
   d="scan'208";a="230929290"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO outbound.mail.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 23:54:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkycUbKeMtXBQ+mXEizhI/QufaP5tFv70AXBXgXJyQXe61ba8666YujCT6q5WmuRpbm62vm4Af1MGln8FO3MzYy/ibIGweXZzbYhlh5tpg0t3PkLR2uBWAont5WfpxQClSAl6puyXmyD9LZCSxQwC5W4QOVZ3ozXZSqwm7/eOVw9tGMOyWWVQL3L/iFTYxqNwhZuouxiTM5k45xHDQXtX8a1q9mXa8LysDw28q6FFF9kb+ab855kv/fU9P6+eQV1fjd5t86qVjh8iCz57xKtAc7MzEG0df+0NnSXPkVd0iyEo5jJw/6Jsm0+08tHJ05qDtZgK0e0dcTmEl/tQqPHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=n7n8E+wQB/WIcUBMPY8Twt6RWntRQzhXqUrB94KJzfv0/JlU0OYqaoIfVtvkfTBfckbGwKinwibV+7KNTIiLMHN4DGMghgPOkCbqH0qpM1GUqXv1uI8xxXuqeSaz3HzLcEg3WGMXzsmF5QTmJXS5Aqj0+yqIgu24x+xCv15x9QLORgr3mXH9/eYUbJqXutYna/rbhYasrVVFPiJI6rjgarrderw8qlrFy0am8mgKzgQQQU8HemKhsQ0QRSNJEjvXevJ6SXjLR/q+81meePyHp6OvIeuLhO9EtG4yHRJpdi9m/vsRdd+9KH2tPAjKjtSZJDc3JGEab0xuF3BhJQKQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oHZf+7XxVfL4RiykryxVbLJAcxgCtrxbLh41ibR/SJoLAKa/BclHBCKsVyqVpwpmnnOEunTTLpqHlhOE3qJ7E9KlL/FPgraH8csIzSqyvkseGgBFETuiFSCg2XrATs2abUgU4A9fkmoTUiqifde4fL0AIlDsh5q6oUT8FhTwDi8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6348.namprd04.prod.outlook.com (2603:10b6:5:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 15:53:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:53:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: update documentation for a block group's bg_list
 member
Thread-Topic: [PATCH] btrfs: update documentation for a block group's bg_list
 member
Thread-Index: AQHZmILmkkGJy9ZfQkGxNbWJK/+soa997S6A
Date:   Tue, 6 Jun 2023 15:53:58 +0000
Message-ID: <559385cb-4639-8639-7103-9712f760ec13@wdc.com>
References: <148d635697bfb4ac3f9010526a6d79b8ee34316d.1686061295.git.fdmanana@suse.com>
In-Reply-To: <148d635697bfb4ac3f9010526a6d79b8ee34316d.1686061295.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6348:EE_
x-ms-office365-filtering-correlation-id: 239e1b46-59c7-48cf-5ac4-08db66a63d3d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WW1/6OJX+FoCZ0oDWkr9dVDdLxyNp/R4Kowl3aOTc9GGeNyfCM1jH0KUCCRrXD9CefIvGKefuXRgU+m39PVOLsTZPrD5aUUrW6LmR4nmD/1OPGHLYsEUHKdJ1oksEF5kBKkLtSEQeJ0Hgj3zW6goxlCXMOOAjthX68oZttNfVthXw4vrA/aW3n3tWTJ5q7dVThxuoyfY6cPwjPRK9NIyahu9B9+eZdPbDykvU5riOSxKGG5G7LDJD/h6ZGrlRwkjmMmXIYvulXnInUtztr30TxFuSs2GS8+Z45VkLBn052IkGqxp6kVYuusxwTvK44OSXaaiFedvgwJ0g9bZBFDX6iEVCCaKxNjSESJdPgo+uOVeZ7Gqs/lzFVx4jdAmyr7N3x+c9D1J6PT7HM4nMm4+FWe4SXwqEfgzFieXn6oGHGwr3KLbTzvgPo9dqm/wvzPt+kMC9jMls9CJVEnVti41+lEYe4shRTbKsCYBS1pnbvSuT9Q5x1VUm9SreLN+7KN8SDXqeiUJ9ZP5kLAaK7vvUcJQfBw6zY4t17+SK18m99yMK9phO1x3af1OW4gVFbjKI3m5nru95RcPMNc/pCwg/rYiC721Fyi8QV/6qcQE7T7E54Fh2/W3JVWNhXZ7IrlL09S7Tc3ADvadnTBDumrbKuFK3gWueXN6RVxQpoPrqn2Xx/jKXrjSS9AQrmY1kd49
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(8936002)(91956017)(5660300002)(316002)(31686004)(41300700001)(110136005)(2906002)(478600001)(4270600006)(38100700002)(6512007)(31696002)(6506007)(26005)(86362001)(122000001)(186003)(71200400001)(36756003)(6486002)(19618925003)(2616005)(38070700005)(82960400001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjQzdytMWUlOV0hXOU1jbmpGdFhacnM4NE5BaE5UZm5vQ3lXYWwzZ3BmZDZO?=
 =?utf-8?B?UFdCZmlCb3c0WnoreUUxalhGVHZnbTRuN1ZyQi9mWVhYeGFOWjk5cmdxVk12?=
 =?utf-8?B?blpFSEZaeVB3WXQzNFI1Ky8wSTN3bDV5cHZ5Z0hsRmJla0xzL2lwdmJkZ1I4?=
 =?utf-8?B?dU4xcDh3UXpoa1UxNTdYUVhiKzZjZFhjNzV2eVdjbWRiZEVqWXZvVGk1a0NO?=
 =?utf-8?B?eTNCVTFJVDhFV0RvY0UrRzBMVVFEVkFPVXpiNGs4Mm5MUG5vZ1crRGhSUmNa?=
 =?utf-8?B?WE5BOUtGUG9lT2xMRHc2TGRNUjdRZWQ2VEtnMEFpOVNXcmdQYlZsTW9EK2kw?=
 =?utf-8?B?U2YwU0FoaXp6U21SSm9IWUZCZ1ZpU0tCeit0bHgydUR5N0VDMXFEd2ZRRVZZ?=
 =?utf-8?B?WlZrNEU5Ni95VUVqbHFSZk5nZ1N4S0x4TnE2NE5nbE9lNFBuckxaSWxzWkNp?=
 =?utf-8?B?QTJMaWtMM21yMm5zZjJ0OHVGclpOblhLTDBJbnpzRFpDenZaSGRTTHpIREtm?=
 =?utf-8?B?N0ZDankrNjlpdTVieFFqNDB1c0VJTFI5TkNvUGdiV0p1YnhWV0I3bGFsOFA1?=
 =?utf-8?B?TTI3N2hOWkwyY3h0MVRNUjJrN1QwNnd1S004NnVUbkdYNzlzZk9jdmNYdjZO?=
 =?utf-8?B?ZWV0c0NSN0Jsb3c2bWVvbWlvcGdmbFFTZGU0d21RMG0rY0ppKzVhNDhteWdh?=
 =?utf-8?B?d2pDMjBKRnZESEdhYzJTOVNiSUp4SDVoR05ESzVHNkFFdWEzUytyRzFCSXpI?=
 =?utf-8?B?dnV6T3MrdjAvSUJYbTBaVHJMQ3NKcEtwOStSOVhXUGJkcXRycElGZVhWVWtZ?=
 =?utf-8?B?THRBOWxEUGNaeHpYYUFna1lrdDlOWFpCTzFXWDhuK0xvSFdhV25CQXFUOWxj?=
 =?utf-8?B?dFFyb3B1dUJ0N0w1RUtxVlFNOElxRkpSa0lEYmJuaG53cGpKUUFtRndpbHpM?=
 =?utf-8?B?eDJ5TkJsYUJpcEpzQmRJRkNsZ3BwWGVYM2Z1NzhQbld6REN5MEVhdkpaV0xY?=
 =?utf-8?B?b2F4NkpmaXZKbVRNZE5qUHlQRXd3Q1lOdm5iZzBub2xoNm9QWlpWcTJhd3Fp?=
 =?utf-8?B?MFRmZHJ3WjJUTGJURU8xeGVtbmY5dEN3dXZMb2JoMjhZelBTdkd6VzlHbUQ2?=
 =?utf-8?B?bXkrcTFlR0xoQzlzQm1OWTVxdExXVFJJSVVGTS9iNExhWHVWRDFxMTVkNlRx?=
 =?utf-8?B?aE5aSC8rQ1A0bSswSERzSk9BSmFRaG9sSFBHSXU0OTVjQWJJV3ZkdVhaODBi?=
 =?utf-8?B?Zk1ucTltdXRoUUNWbDFzMlVHMEp0Q3Y0d0plWmJ3S0FUUXZlVm5kSWs5VnZj?=
 =?utf-8?B?ZTFiTjNiRXd6LzhMc2huaEplRHVORlhsMERoK2pqRTRJUzJQQzZYTWpPakZs?=
 =?utf-8?B?WlNYZS9UWkVncEVzYWVTaXhsZ21WQjFlOEhsWVpZRTJzTXp1UGtiaUdyRURj?=
 =?utf-8?B?QWxxYmROVW93UkhVWUoxaDJydUlwMGtLdVJlS3FILy83YTViVm1NTUg4eGxx?=
 =?utf-8?B?UXBIR0hsUng3SFNremZCQWdySlgxMDM2cERjTWpYbjdzcklEVExzRERCOWMy?=
 =?utf-8?B?QmJDZUJJZWhEa3hBNnlWNDk2SHdZcTFkOWNaa2s4RmMxRnozYld1N2pXeTZn?=
 =?utf-8?B?ZmtFSzdGRmxJalJodWs2bzIrMFgrc1lxVnV3R0pRMHdRNCt2cXpFNlBJRW5N?=
 =?utf-8?B?aC9GcVlrdkN0cDlKeUJ4RExjSGNVTU1HblV3UWFXdmZOaUovNS9vTGlCcWNr?=
 =?utf-8?B?cGlQdzlQbmZjeTR1cGZwdEtGNWVOREVIMTFyUWIvUGVxVDBaK00yVlhTRU50?=
 =?utf-8?B?TCsrb09TWnNQbm13OThoRi9neWM5bmVNb3F4d3E0RkZGTHhZWTdPRUxQK1A4?=
 =?utf-8?B?djlMazZjOFZDYzNWT3NhbGJOdlRrWjdmb1BTSEpqVDd2empPRERMUkVMN0tY?=
 =?utf-8?B?ZkpvZzUrMFUrOXhGUmcwcXo2bDdIWHNsREM5c0x5cW44dFM3YnZZMVZ1UTE1?=
 =?utf-8?B?R2hPRWtpaHUzT1pMRkQ3MitvSlJhZ1dQMStZajJwQVlpNXRZQW1WOVVqbVFF?=
 =?utf-8?B?UEY2TGw4ZmxCZ3lNY1hUVHE5K3lyYTNIK25wa1piQmRkNnEvSlFWWlVnUDdX?=
 =?utf-8?B?T2FxeWVxaGxxcDVoeGt1UUJheHBYU0lMQ1RqS1lxZU1sZUNLU1JJY1hxS2cw?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEC93F6CD8B629419A6F9D95A0202457@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fjGo40k8Dw2mgjeKOprTDsneMudVDvk5H0+8YARYGRq0cJRwASumcQ4UFHOEZNT0mGEKv57e1JsEK4l0y8braZlRlFdR4ftn1jMXyIu6P94Y8xa2p0rLdSdTz0psJYYQhZUAu7ElQGGCrS4F84OlQEQY40vhc8CTwS41Okype9/48MXFZdke//Z6uueRz5YMR28M8KUWEv0BPy1lrs8Q04YptjQ3DWiJxYYjnTIpMPyrtPrGNPkTH0sUFWD8XpWFEAhVzVoXwxQ4cGY2JH2ecrB4fI/eDoZj13b8fmU0b4JksG0HcrW0u1ply3dHciSRi+4NMb4lokjA50SVJOXlSaj9jz6MsPLbCMsHgdPKobDDDu6knyDv3Tn6lFqz3BYHCGUT/DsWnVULxBAkQgf79Yhm/BdPJKI3oK/jM+DalhLUXpPK2ILRE10+UXQo4XGbQHaGe/dqrnA/zgnQ3n7vH/aj1WTP4M70HbjK9hEy/j4ZaOeI5U28Ou5+3h2IKqWBEG3CS3HUNYo1/r/nNEQLPHL2xJYnppCJPBmlJltsgwcmpLMPaQrCcpvgYinOztMrJxM+yE2CTPLAuwEUE69VO9g8I2rVGGD2Px+o32GVmp5YkrmM6kJIwA50BgrdhEU1F5WcbKTGQa3uSGEN+yCc+bNOthM3qEWRhA9NmDukzJDdbUHrQlrtlBzSIM4L/la7o+KSftHLsZmiEAwm2pda8+T+U7C34ulOPp1CFktS9LWmHt9hTLjVCJcBo/FsfkQlEEXEqGbSngykTKsyku14ESsn/8maNF+d9K7+/VgCVCUlPV+drvMzeQVxebVwrmpL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239e1b46-59c7-48cf-5ac4-08db66a63d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 15:53:58.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YoFF16dLnGiFITjxvd/oL9MWmhVaGikL3kLCX6ZW4Ro/yJZZNQ1wdfbhXjF3jnibvQ8HlYJLLIf0msWyRkyCyA0O7N0NxgKScVsSUZACFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6348
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
