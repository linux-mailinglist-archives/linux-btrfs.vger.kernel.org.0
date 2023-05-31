Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C86718121
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjEaNLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjEaNLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:11:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE18126
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685538659; x=1717074659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zGTjGZ9oXucHTMgLlAua+YyUM2Mla0OmSXZYqLeNdCw=;
  b=exxcJbKVroQl+0AcZcDP7mYJmZxDZNd/2gzYVbTYFxfalR4XC4kWUTzv
   w1FJ9ZLcunD+Y5AHL4TsHY6n3HUnM6d23FjBFx3dE+gHEMlocZQoFMMyk
   JtwQiBof0DLemsbuJ6hVRQwOAHe4HkK7xZDsZHY0YCk+T/x/HOWs/NqWl
   rqeOoc0JUgYK6l6Fx3fJCgYWlN3F2okOzrj6zGGz8qGhVNrGeZzZ3R92f
   V5S5VIryxkoZ5Fumav+dm1ByAOsfSs/FMunOOTS+J4n7kpHISSaJKxnH6
   Qa30QnoNjjMXD8Ojx/dg2w8rg+CDDRZ8akgdpxPVB5DKvlBYXMF+ocnV3
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336555602"
Received: from mail-sn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 21:10:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1DAOBR+jEhgYwpmQJIN4GWOOAaU4BytCoBNMoQ3jxAPTBh6QRtU5qlkB5RSX1FfnXmfwxqiHCI/tjSp7V79TRZwml5TA7cEJZj3q9enNWREGQqO4MZww75onHOGS5jKK+3XAKvK6SCRw2Vh3ShptaBnBFxPzsfmt0ltsDJ9ZTcAJ9NHqD9H4zXnM8mCte/lhMdtM+uj52gOK57rXi1REitXRwtCe8bIz1H05Y4SSpqMJXV7G3wqlOeTva5KxDzgVSbpSyxPbwWGMv2IuKKzPFmYa7j9vmarBSJpdM/8HE9zQFHGkYwvc99miKHZf+mOe23FiPfcfXlK2P5PboO3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGTjGZ9oXucHTMgLlAua+YyUM2Mla0OmSXZYqLeNdCw=;
 b=kawP/4/oibT3HbUrEPpjkO9dF6We9nFuzcOhKZPOmZlfnAtLfZ5ca7juiNtRpgQpQCCFl762DybNiBIlEeSPXECM1Ix6mcGKW0urWe1vd0/DoZ6MvFu1pTwUfBs27+qm8LcriMqFz1ytdrhAVd7IuevZuqrYYNkVPynQ679iRZzUljkCLuK0JB47pyDZkIEDd/XURKL3TaJrPEkGNsOQCuWcqXNaGr8AODa6hOR6Hrc3ijid+5UP3eeWBQkWH0Fbksdh0jdyHv3QFuHyzhfJjsVBE9Xy+tS1uz2oqCzgC5SoBTDHh1RoSQLiJXZIvGzdqJNuEzGqwMFRoUBGuR+xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGTjGZ9oXucHTMgLlAua+YyUM2Mla0OmSXZYqLeNdCw=;
 b=uyAAct9nrZsAZ/ASVplU/wzEFITq3rnF0fZ9k9mtR7hCZg3FVmlm8PxN+6F9eiBV7pys/9RraZNcCiYcXoFJvZfr8rcU9RPcgeQO5JoKPndHxz/tQJYNqJVO4LV5tie1VDoqH1wBZlqd4/w8LC66euz29RYk5bRh4ejb8SQ5hpM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8685.namprd04.prod.outlook.com (2603:10b6:510:252::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 13:10:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 13:10:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Thread-Topic: new scrub code vs zoned file systems
Thread-Index: AQHZk77F6OZSPckrzkClECKtofmqo690WysA
Date:   Wed, 31 May 2023 13:10:55 +0000
Message-ID: <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
References: <20230531125224.GB27468@lst.de>
In-Reply-To: <20230531125224.GB27468@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8685:EE_
x-ms-office365-filtering-correlation-id: a11ca23e-90db-4981-8500-08db61d87811
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2F9JfNqOmtKHu8wYOTJkGLT5U1kVjR32sJVdztIbyzoygMihEESG/rRFJcdGfdpgy6DT3s0/XJvdDrFhI/zJcoOongr05PohLiMOa+4qVD5EyH/OPL0yRQe5Sskm0aMZ1EBRVGsEHdXQlOjH082zdDH3LZiQUDGM2ikPO8Vjccre0X2BE8eplqp0njbfy2yTz909ag8eLZhNhCgxUnajq9mMB1go6PBr5z/CvbwbZ2L9Tj+zcT52qo7J4viox5B5ntpKmGT81fd+CUyq3YMdd6ltBWq6ZDYwWsmZsgMPh+l4Iu6qD1xYYP5u2iHsFJA1u/3zjUG0a/tuS/mkSjsX6TbQ5uuUS726/0AXjBJ/Li4jR2sEqzAIgPO9DKNnHtNrAQVuGWkIAY/GGggFCzplMWpljpvobP8CB3afCE+/QqpklQokNwx5rcrt3e/fEVSfqzfQYTP5J8fM06QYreWaHjeQU6dC+HPm8+us4nJYXCf+A7umfdW8P5ELGS4zFWY2WGswm0O7cwsz2+GBOOMuLQD8UJrttxOCdq+SZNd8/B6g4CbKuaGk7xpYMYHF9fJaInmF4iidi3XmqjyClLFVLwBz0yYs5yMmmMBKRVSGY4W8kMhOUQSfc8yMmvZ6PGFpP1TksQ1TvorligfIzcmF+o9QlMWD0LEK6fi9Krd7qC6C0yGTkhq1KpQkDo2V61u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(66446008)(66476007)(76116006)(66946007)(64756008)(66556008)(122000001)(110136005)(6506007)(53546011)(54906003)(6512007)(8936002)(8676002)(38070700005)(2616005)(82960400001)(91956017)(83380400001)(31686004)(86362001)(31696002)(2906002)(4326008)(6486002)(186003)(41300700001)(38100700002)(478600001)(36756003)(71200400001)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVmd2ZmNlRCVGw5VnU3cHJjMzlHSktCVllSc0FTQjZVR0pwVkxSWEV1bk54?=
 =?utf-8?B?NTJ3UDN0K1NaUmUwdk4zZndKZEIyZXZ0Mm5TWmpIQkJiV1JPd1VyNGVyTlRC?=
 =?utf-8?B?cHJXazJ6VDNWMlhiT3ptVnArUzVZWDhtZGtrVkxHclpHTEZVSkNYd200YVBI?=
 =?utf-8?B?Ui9DdmMxTDRna0tCd3FWUTU2SlEvQktIdlhLQUZKZjhUWkNFblNtaGg4eXBr?=
 =?utf-8?B?TVRqcnhiaUJtc05ML01CaWppNE80clZENXdhR2E5TXByTExhYnJ4Z3ljZlI2?=
 =?utf-8?B?TWdDeFlYNG43N09TblRYOEdSaUFIUXF5ZzdnL1RuWDRDakQ1RHZOQ3Y1a2xk?=
 =?utf-8?B?RU82SFN5ZGFGRGdJdUNIcS9POUptNFkzanJQQ3Q0MllsUzMzOVNkWVVkdTZl?=
 =?utf-8?B?YmlxWDd6eVNQWm02T1dBOVFNSHlsSEM2RTBLWVdPUnFpeG92Y2RGNE5Qc1ll?=
 =?utf-8?B?aFV3aEp3ME1xT2l0cEw4ZG9oaXpZT0NuOGtXL3l2bjVkWWI0YUNMMThhalFa?=
 =?utf-8?B?RnJqV3NZa015ekl4c29RZi92YWZ1RDlROWxHTXlsZVM0MXIyWCtTRlFjZnoy?=
 =?utf-8?B?VFFuZlFrdWxPM3lvYVpTVDV2b1FJa2dQQjBONCtxUkgraWhWeUhkeXF0aXFS?=
 =?utf-8?B?Q0Mydlp5cFBQdkZDelYyOVpYL1lJeGZqNCtkeDU4NWszVXkrb3Bib0lDSEhq?=
 =?utf-8?B?M0MydmVHdEgwbndkRTBYZzlGTHl5aTFPa1FOd294M252cTFFaXFDMm81b25X?=
 =?utf-8?B?cWdYUU1rbjZKdDRocGNVMmlyS01FT0s2YmdQdlNoWXJvTnBtQ1U4OFMxY0ZV?=
 =?utf-8?B?em5la1F6TDhZUHNYcnljVkg2MS9YYzZaZ3dGZHAvSTg0YmtSNnFrQjI0N01j?=
 =?utf-8?B?NkhnUWhqNWFyQmlqZGtUdnFicE1JZnM5LzYxQnhvYkc3OWF2RVRXdkxkNzZB?=
 =?utf-8?B?RCtHS1ZPRUJBbEdtM2FIUHUxMnlocllnUDF5dlJ6VTZzU3RjdTMxVmlyNFAw?=
 =?utf-8?B?ZmFvb2JsSkVyb0xwODJhdDE5UHVFckZPMWdKclhYZDU4ZUUzMi95c3hZamJi?=
 =?utf-8?B?MjRtNG9HNFYwV1lkVldOK2NOclBzRHJza00vMktCV2FrSkFHOVVKZVh1Uysz?=
 =?utf-8?B?dEEzV2kvYWNOV1ltdGNXdVJIN2JYVFFDcGVTRWRjbVdQMDRkQWFXNis0Vnd4?=
 =?utf-8?B?MDJLb0lURitjblppSlU4b1hDUnhIdVFRS1pwVldZUjhzS1RmQ29JMm1OdThY?=
 =?utf-8?B?ZnRJTzQxWVhzZVhRVi9TMklFYnhFZWhiUjFnZzBscWRkQlFqWi9oQU1ZNmZI?=
 =?utf-8?B?bG1JTDBiaUVxU1huK3Y1dzJ1emJET3BmMmpjUFpzNTZ6ZmRWTDZtTXRUZ21p?=
 =?utf-8?B?ZUhLYVpQQUZNZEVuZy9XYlEySHNpbE1kY3BmMFc3NnE2SXpBdisvSkVIWXNB?=
 =?utf-8?B?ZkNlcjd4Tk9PQnVSL3VieTRSNURxVGFLU3pTTldvYXZrZmZhQmZJYzlzZ2dr?=
 =?utf-8?B?U1dCRFRnenVOMUZHQXhNTzlkQnpJeFhQMG9Sb3JTb2pndzBBNWhrekwvVTlB?=
 =?utf-8?B?anpRVXhaa3loRmVuSUZRbUZxU05EMTl5Z2hLenAyeUlhN003UDZOZ2VLb2ph?=
 =?utf-8?B?UkJxZUZUQjA5VjRvdytydGwzL040VVNtaGlwSFJQOEV6VXYxT1BBakg0WXMr?=
 =?utf-8?B?OWFTcDFCU3hvc1JVWVdjTnhSMUg2MWp2QXh1TEtEZTFDTWx0TXJ3VVRvc1ZI?=
 =?utf-8?B?K1ZmbUN2MlJsaHlCbjhxbEJUUzd4VStLeHpiemliR2YyY2VoRUt1V3Rkc1kx?=
 =?utf-8?B?OG02enpOYnBLdVY0bTExdHNIUnR0cXhHbUprdll1MEQ2SUYvTU5NVFVtSXZ0?=
 =?utf-8?B?RDFCTXZoY3F6OEVieTBVZUFjaEx2SUlZdW05QlBjTnBsVS9HZFdMTkFlUUJj?=
 =?utf-8?B?SlJZMlU5a2FDWE9PL2dnMzIrQzhaS2ZPRHkxT3lSck9uTVMvRVVORzNtY0p5?=
 =?utf-8?B?bGFQUEN2ZVMxNkNrK3ZGeTF6a2JqRCtPZ2x5VER4UXhVSWNseUlBQ2ZmRmZU?=
 =?utf-8?B?NjZ1Mk9Xbm0wbExZY3p4cU1nYjBxZE5WV3phanRhelE2ajhwWE5VTlY3Wm1v?=
 =?utf-8?B?aGdJZEpZK0NjeC9tM1FOdFpaQk1oejBQVlBQREFRcW9FdlRXbzcvQkE3a3pk?=
 =?utf-8?B?YWhqOTZkOWZNVWpaRlpnY3ZjVWUzd29nSEM4ZEZBeEpMSktweE55MEhzZ1Nu?=
 =?utf-8?B?VDZMY1VXcms3OGZGMjlDcTR5b0JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D509B85F98047D4B92D58208ABB15C42@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R97FJotjT6oRs7menklrfwIcYgJDsh6I8M5IkjdyTSBz5JuNbWYuBGJ/l9HdohNZjxmgVN1kxdKKphTnG9DHhJLy0icJ3/PCf9tx8o2laSER+hiN3b+RVo6U+ubFbiZrwx3fKlTjIZD86GUSXdxnZp3dzdtMhxTY2MQi9a3ZYzmcJWCLN12LLqvlUkIpWGydsH/p/HjwFxqQWFPpE7hFQx6D2v2ppAY4mkqRcdRv9EN6OdQb+zp0q3TmpBKMIKtEgMWuhf0W3ANJIRy5+BkzWHWNPUcHR3rziAhbfe7ymr683GauZtcEz4j5puRhK4pwHbQ8JrCcQFUm0T26UWohm6BPNkk6TCzbHp78XREyzEQQ8FVyKhprgQTkS4aTzutJrtlsyzONtmoxfUxM+/5hTtz/ZT/qET2XjFFpYAsec+EVEQGoLLdUMqKcICd7xNOUAoTEZ+dk+gfJTNoNLjsRNUr6YXPgzQBFEX28rRG7G3lJcGXIv7Y/YdZVknJ4tKVSQBGJ1ehiLuiRUZm/Pjpvfy8A4Aq44PYCjY12vGeFTmpPaIG49S8WY+mCZMdWiXRBBaSPnfJjMjn4qi3ioRW2H+tcQzum5SvBnNf+a/yP5H9+vIUoDb3eZv5zfSJDoltGuKcRtav7lg8qf4k6dc0dqH5il7rH4VfHPPZazLhfuOC7oo/ox1hVrnMspJmmver1NGmHdh9p3/1BeLgU9V8A27lrxq5smJxo+mQ7YDRXuNJT2JEeLsrXBhigrsc2QN1KegPYnoHbWieZSM0+odhGWubF8ysjEvqdInObtNaeGD1WF1qG4GrB8I3JJ3q60+r/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11ca23e-90db-4981-8500-08db61d87811
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 13:10:55.8086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTe81uLqUkHIZFj3djre6B1zGSYMrTYCgZBHgTRCWmEOSI6sVLYRl4W67wCrRLpTmdZaPiJOa31THMYGu2WlZzyVeyVNUnbqomMq11o73D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8685
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMzEuMDUuMjMgMTQ6NTIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBRdSwNCj4g
DQo+IGJ0cmZzLzE2MyBnb3QgcmVhbGx5IHVuaGFwcHkgb24gem9uZWQgZGV2aWNlcyB3aXRoIHRo
ZSBuZXcgc2NydWIgY29kZSwNCj4gYXMgaXQgdHJpZXMgdG8gcmV3cml0ZSBkYXRhIGluIHBsYWNl
IHVzaW5nIGJ0cmZzX3N1Ym1pdF9yZXBhaXJfd3JpdGUsDQo+IHdoaWNoIGlzIGEgcmVncmVzc2lv
biBjb21wYXJlZCB0byBzYXkgTGludXggNi4zLg0KPiANCj4gVGhpcyBsb2cgaXMgd2hlbiBydW5u
aW5nIG9uIGEgU0NSQVRDSF9QT09MIHVzaW5nIHFlbXUgZW11bGF0ZWQgWk5TDQo+IGRyaXZlczoN
Cj4gDQoNCkkndmUganVzdCBoaXQgdGhpcyBhcyB3ZWxsIGFuZCB3YW50ZWQgdG8gZGlnIGludG8g
aXQgYXMgSSB0aG91Z2h0IGl0J3MgDQpzb21ldGhpbmcgSSBzY3Jld2VkIHVwIG9uIG15IHByaXZh
dGUgYnJhbmNoLg0KDQpTbyBpdCBsb29rcyBsaWtlIHdlJ3JlIGNhbGxpbmcgYnRyZnNfbG9va3Vw
X29yZGVyZWRfZXh0ZW50KCkgd2l0aCBhIE5VTEwNCmlub2RlLg0KDQpUaGlzIGFjdHVhbGx5IG1h
a2VzIHNlbnNlIGFzIHRoZSBjdXJyZW50IHNjcnViIGNvZGUgZG9lcyBub3QgaGF2ZSBhbiBpbm9k
ZQ0KaW4gdGhlIGJiaW8gc286DQoNCmJ0cmZzX3NpbXBsZV9lbmRfaW8oYmlvKQ0KYC0+IGJ0cmZz
X3JlY29yZF9waHlzaWNhbF96b25lZChidHJmc19iaW8oYmlvKSkNCiAgICBgLT4gYnRyZnNfbG9v
a3VwX29yZGVyZWRfZXh0ZW50KGJiaW8tPmlub2RlLCAuLi4pDQogICAgICAgIGAtPiB0cmVlID0g
Jmlub2RlLT5vcmRlcmVkX3RyZWU7DQogICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdHJl
ZS0+bG9jaywgZmxhZ3MpOyA8LS0tIEJPT00NCg0KV2UgZG9uJ3QgcmVhbGx5IG5lZWQgdGhlIGlu
b2RlIGluIHRoZSB6b25lZCBjb2RlLCBidXQgdGhlIG9yZGVyZWRfZXh0ZW50Lg0KDQpJJ3ZlIGp1
c3QgcXVpY2tseSBza2ltbWVkIG92ZXIgImFkZCBhbiBvcmRlcmVkX2V4dGVudCBwb2ludGVyIHRv
IHN0cnVjdCANCmJ0cmZzX2JpbyB2MiIgYnV0IGRpZG4ndCBmaW5kIGFueXRoaW5nIHRoYXQgYWRk
cyBpdCBmb3Igc2NydWIgd3JpdGVzIGFzIHdlbGwuDQoNCg0K
