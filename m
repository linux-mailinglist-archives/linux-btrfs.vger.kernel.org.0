Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34060260B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJRHnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJRHnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 03:43:05 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183E647D6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666078984; x=1697614984;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=F1VZatiOrDqncmQNWZwWnIEE1/4Qv9TZYoRhaRhQ8dE=;
  b=EHKcbSJtmfxwuVQjIAhWxxLUMN6PoMZ9VhHceAbZouoQ8aiag7RpDXNm
   1TLSqP2oqTQ/PqNAwnBIsoVJemTfbxQ8OA0Yy+rGKvknQbRhPGqktFGGy
   zUQvUS6VrLwnQKvgTAayB532wIBHP5hpl7iZwCKdOPH+nm/3yBhT8lgZ5
   X4xa/k9/mDJZ2D/PEcYnOBbrPNO8QY9BeMx3qTMbxayp8zjoavD9lZFQQ
   vczCEsfQg7lCxabfOvRs1Rt9hKzUUi+ptS/b076KopO4GXvQW9hrxwr4p
   hjCFEzQjfYhUFh75+voOf2JrKHG3gfRDlEI8sy5ghpksCpnvNsCdczf6T
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="212422471"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 15:42:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV5TZA47zyYqW42vTfjGk85J3haP0qnJrPW4hb43Lnv2OoP2Mr1+/5zPRdebKYPN9rGIPkgAjDT5ys3CRq6AfG8qsaMitbvzD/0pJPmneMPdt7aYV9rRlFux2wx/O+nBfgfvtSXX9MberXc42zWD/g4ORb1KJ5+1MtKVnVgZvTL52DJmkdBUozNqh3aSZmevjjk71p1JRpNB3OOe13pgdliVWD5KzEOqHrK2bq7S3v6jf36jEe9wGi3up+kVeqR6kP4QDn9d9KziVgVBsO5JnUs5X1v2jzxOeqXwGHtjvJJ+1dQ0p+gSgsyS2LYWngVlOXfQoVqHwputFwHgHEC37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1VZatiOrDqncmQNWZwWnIEE1/4Qv9TZYoRhaRhQ8dE=;
 b=T88KHKe0yV5JISZ9MmRtgrDE8digEqXmv+Cagc45HLGpuYjPTNde1Oo79sqv3dOTf22WxsoMzFCEmvFP33ZGiC69FW4AOppPYnGNG95B/IImTM1ya8WOF1jWS1euPPfZF9h9GLonSkwpoUaGXfTstjW41Yi4c0A/FNnklFJ0jBQgH0lC9n05jEi5Ueds1nZkAQ1c5wH9eNWoDYjG/0qqKltkTNLDONum6wTE+0s0zkuoNruGxG9jI9O64FmMYo5SlXRIpeUuLCY8jm7k+3pPjIgKMsuNpzkpCy+5B8dJJqqa49Jd9J7tdvlam8Fsru4KSbidsAG6RtyaZDtCsz9z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1VZatiOrDqncmQNWZwWnIEE1/4Qv9TZYoRhaRhQ8dE=;
 b=QqXIQ+ReMrsdG0p7WcfuiRndfDmk8x3jJy8TSKnk2WCC77SOB9dXnQ6znayoCHuWTDCkANLznYGMlBEevZPM/HcZ6OPrKXYWWVFGKOksgo9Y5PbSUEr2mBv8lcY6WNXRBwXHX+veuCoa0BKQyuDoiSBlZwFiyg4yOLPamGFC9uM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0880.namprd04.prod.outlook.com (2603:10b6:301:40::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 07:42:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:42:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 02/16] btrfs: move larger compat flag helpers to their
 own c file
Thread-Topic: [PATCH v2 02/16] btrfs: move larger compat flag helpers to their
 own c file
Thread-Index: AQHY4lv7vdcC++LQmUKN8GXiUMkF9K4TxbwA
Date:   Tue, 18 Oct 2022 07:42:52 +0000
Message-ID: <761748f6-ae18-5467-548e-256d56ce5f92@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <bd00bf180e1f4437d887fb7b893bd37d5103c25c.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <bd00bf180e1f4437d887fb7b893bd37d5103c25c.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0880:EE_
x-ms-office365-filtering-correlation-id: 09f5b655-ea18-4a2b-dfe4-08dab0dc5d16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+0igdDUjspITcyVG5TRrdTvtigHg0DP75QuCn/NndFD7RW4snD7QBpLY2CwuLrIS/Qaj5yZ2iOxlixLZQBWRHSHPacOWWAIzf5KRd9p8mh9nkXkcBeK3DHcRxC0EYxwGLWnwgOkWUcH281goztWfvCrZxt4BogBE8jXMyUtKxtAHNpZ7eEv4WmXSm4pYU//HdVAsHkp/O02xaJtLnDlRlQ5yCjFGPlASyZW4MfQ6PRqqDZ8O5Fuu+fpSyUCFTnCRed4PU/mPELgMfgaNFDPl0wTRw3guTUpx5v0U9TYQda09D5ur2Y/tKscOQ6/J49rg37G+FtLKnNAKLR8jKibh6BwTxF4MwV3FCq2EFuGlRNNiJzcfO4fKj6CaN3CQgHhyXj3NvepP+8OEL+PwzRo75kQJUwDsr2f1CERCIhqC12CQoYhj3JIW1EMVvSGj6B5kcjUdeYYCxmrOt769ebhXqNGwsPs7QObGWyBnyrd/InPDD28BxisVrAUPHczD64+5W/w7tyhp6cypNRW0JTeDS74KPfK9a81MNV6HSI7i5m8ga/nqWhDsZTCnh8wWaN1Imk+qC9/hyCI8yQUqHhivRYv/1+bpK/PhrdFweaDUsQhh9UE5iBmMTKpeRlMv0IYMNg1E2Dq4Z2r4okkMXe73bDhWgoA46/MxJ3c0p+Uxn4z1hvfJRoz4nP/sNwUfhb4Ed7Wu2d42PQOwJMewd6f2yDWziCQk3nDadhf/LgwOy68I5D5cnmgoAc+yGVkdadYIS74XJwdHvO4BE4mLwqg4RTMEKoXWUCnPabSKEv/hpYmHcscPLsTt1y5ylGxsrSzMKXwo6X8QvFN7TMX7v803A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(122000001)(478600001)(38100700002)(31686004)(71200400001)(38070700005)(6486002)(82960400001)(316002)(110136005)(5660300002)(8936002)(41300700001)(31696002)(66946007)(76116006)(66556008)(91956017)(8676002)(6506007)(53546011)(66476007)(66446008)(86362001)(2906002)(64756008)(186003)(2616005)(6512007)(4744005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUo0MXZEQ3pyRzdGQXovTmcvS01OUTAwNmI0RlNucnVnTVFEVnZQMDJzemNS?=
 =?utf-8?B?bStUOXEvVGszVUhjbVR4b1pFeGdqTzdFVFE2bE10Z29yaHlRL1A1QW5iWFdV?=
 =?utf-8?B?RUg1NVYwd0VQYThVZm56bHBHTkt3dGQwN0p0TEpMbXYyYi9tNGpRanM0SFYr?=
 =?utf-8?B?blRzRUJEZTZHUUpqbXVydXIrNHN6SWtCSFpEMm92Q3pyWHNMVzNHM2prU3Ru?=
 =?utf-8?B?Z1BINkt0cUtIREVubEppR3BxdDBSZTRLSUkrY2VRQ2VMZUtEeDMvQnpHcytw?=
 =?utf-8?B?UDViMU0zeWlFUGF4UDhjL0hNUUhtV0lrZHFmeFJXQlRyNVRnQzVCbGR3VHVI?=
 =?utf-8?B?L01UU3hwaFFpK3dtTjM1RGlSM1NFc3JDK244K0tiZy9Md3RCQTJpVE5xeWJC?=
 =?utf-8?B?MWVrSkJCNzlKaWNGRlNBMGVuL3c3aTNYNC9rWE1sTkZlMWdsNnBRL0JOazZt?=
 =?utf-8?B?UzdUdFppa2xEaU00Vk41ZEI5K3pKSHdPWk1GYUg4OFFZajlTYmk4L0pzdW8y?=
 =?utf-8?B?aVNvZkhwcU9wL1Jkd2Q3K3d6SDBvMXRDOFVFZDQzcnF3VGtuQWJ6cGozbzNB?=
 =?utf-8?B?bWREQmtDWDdOWlZsNXJSbW5jYVpmUGtYOXVERTR3MURRRHJoNFZjM2RUM1ZH?=
 =?utf-8?B?V0VuMEZxc0srTzR3bG9nMVV0MU9uZjZMM1c5cHNUUSt4bEorbTBtM25saGhY?=
 =?utf-8?B?UzJDM0tscUpQYW5oMEFYaURZRXY5bWNUR3EvWlk2MkZDTHE4M1JoVG1sVjBY?=
 =?utf-8?B?ajNSL09SY3JDRklqc2VZaDh5dm1qSVBRK1J0UC8yUEpiTU5mQWRiRUxTbDBC?=
 =?utf-8?B?cGN5M1p4UTI2d3dGT29FUExtUmMwSWw0VVUwWmk3bC9FREIyL3Myc2h6QUpt?=
 =?utf-8?B?NVg4ZThMNWJoVENsQzJ5WDRtZk9ZRFV0ekM2UzJzOEtId1ZrNWxBdi9VYnh2?=
 =?utf-8?B?azZkOFFrNFNsV3lDZ3A4SnJtTDE4WFJVNHNSam1lUjBHaXpxb0hkN0FUZ1pK?=
 =?utf-8?B?ZGhPRC9hY2ZqcGFpVDZ3blZLK2pYMkh1NHJSbnltc1RpUnJUa2hrd2VIbDBQ?=
 =?utf-8?B?OU9aOE1Rd05yU28waTNmT09iNno3ZnIyQ2lRRFJGRjFlTTJQQk13RmNWdmpQ?=
 =?utf-8?B?ZTlHYjlGVk90dzcyQWtDOENQMm1TNmtJdk5EUHMwajdJWE1Id3IvK0JQV0R2?=
 =?utf-8?B?TFVkMHJLOHJNOVJCZE5zUllnbVgzOE9TNEdqbFZhcUtDOGdTVFFmUHpOaCtU?=
 =?utf-8?B?OHBlcTVOS3BZOHRKc2hzSVQvTTBiSElySEtFbFhTa1ZuSHBtbThkSEt5NjZJ?=
 =?utf-8?B?UE9jODBHcVJVYWFBVWRKSWNXa0RvOHNTckFXVXpYbDk1TkUwMjkwSUl3MVo4?=
 =?utf-8?B?cW5uaS9FYVFScWZzUXA4Z3FhNXd6VG80dFJ5TS9jNExkZ2IyYUR4c0tuejNX?=
 =?utf-8?B?aHI3aFdHazNCS3U5Sm1nbFplZExtZFQzVFRyK0lFWk5TcnR3Z3h6ZFBscG1E?=
 =?utf-8?B?d3BOQmw5UytySnZ1ZStyVEozRTNUczlzaitEOWVsUWZJUm81cDRyVkRBSWJt?=
 =?utf-8?B?bTlZcXhaZ2x4Rm96emJBN3VqUGcvL0Z2cjNFK3NLQ0RESzNhR3R1Q3RDRWlx?=
 =?utf-8?B?aXRrdVVxUmxhc0pEck1OdXhtejNHZWFiMmpkSnpiWnR4NDcrcXg4U0xvZzcw?=
 =?utf-8?B?RmhsR1kvcVlNZzZaRHNROXNoYXJMZy9nQzBUSFA4T202UlBvZmYvVGNCQnBq?=
 =?utf-8?B?S0o0WGFld0tPZmdXSUVNaWFibUhTWTVxazgwTVhMNDE3dzNkNXdFSm1nUmZz?=
 =?utf-8?B?RTRmbGtZZHZaN3FlaVhRSEtCN2htakFDTVdKa1hmQXlvSVFwRTJtSzcwOXFn?=
 =?utf-8?B?dit0M2VwV2tGL1dmNUM4aTYrVVRudWU2aWtQS1lFUnFEdEgrcG45OWk4Nkoy?=
 =?utf-8?B?MGZGY0pUUlI4bUxNdXh4MHY2QTIyQ1ZBempqS0ljSmZoSzdVS3pXTkdFYWJQ?=
 =?utf-8?B?R29PMzZuOHQyNlVwUC9TaFdieTFlVU96NzhuU01vQTJHTmEybFpBeUlDUFIv?=
 =?utf-8?B?YjZDeWlGcFNQUlB4K2xXeWpGRkxTeUwxQ0VwZ29YdmJ0R2JhWkZ1aHZldE5r?=
 =?utf-8?B?eWk4NXJsa1ZkR2haTjZVY3pMZjk1RXZrL0tsTDFwSzRXZkQwUEhhbE1BQ2tM?=
 =?utf-8?B?VzFCQnZlYlRjUUpvTWdTcVNVZ2hRQWEzU25rcjcvS2FYcUY1THdOaW5KaGxK?=
 =?utf-8?B?Tm9TUVVsNWZIUXBLdWp5QVBjcUhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <324EB9E300C4154993B8D9097D39ECEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f5b655-ea18-4a2b-dfe4-08dab0dc5d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:42:52.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +58FzOj9XRdtRyhKFf6yoq5o0InNrgEBSLpc7lIWtJpSw7V/WFO53S83yohWcnX9/RUQVLr/0snTKvWyvJxrrfJqp12goLN0/hhq5EOl0Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0880
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTcuMTAuMjIgMjE6MDksIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBUaGVzZSBoZWxwZXJzIHVz
ZSBhIGxvdCBvZiBkaWZmZXJlbnQgZnVuY3Rpb25zIHRoYXQgd291bGQgYmUgZGVmaW5lZA0KPiBl
bHNld2hlcmUuICBQdXNoIHRoZW0gaW50byBhIEMgZmlsZSBzbyB3ZSBkb24ndCBlbmQgdXAgd2l0
aCB3ZWlyZCBoZWFkZXINCj4gZmlsZSBkZXBlbmRlbmNpZXMuDQoNCkNhbid0IHRoaXMgYmUgbWVy
Z2VkIGludG8gcGF0Y2ggMT8gSSBmaW5kIGl0IGEgYml0IHdpcmVkLCB0aGF0IHRoZXNlIGZ1bmN0
aW9ucw0KYXJlIG1vdmVkIHR3aWNlLg0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg0K
