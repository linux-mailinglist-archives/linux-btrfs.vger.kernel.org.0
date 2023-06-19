Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B5734CBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjFSHx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFSHxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 03:53:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496710C1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687161223; x=1718697223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5cJRMxEZ3MdlDPeyGKgEtNemJkPGJ8PtA04/yI9ItEA=;
  b=ICIqlbcL0LwWv7Z3qe0RK1gL4Yp4Rz+R40B9j4QABD7i15POVxfw5U7T
   q3bfpBnXY7h6ysjYQcT4Le9nI6EFZSvQ9oV6gTgMRPVkSUarcpadP5apE
   lrSOqAdb7WPMETNkT6ACW+IeBVXzQhQIQp/gwvHj/43O4H3I+AKP70AV9
   IO7f7JwvHHNGixhfdYNu9JdVGNJqZYWCf8zA9HfANd2+j9WWU8jrViouW
   7g2ZBF8gKvmQxeLLrF8+W6KtKvTGsrfKR6rNRWWQsawKDXxOwvLQSB7JA
   9kxxWk4aepPafZCPbg1x4FqdxG9uqEhvqBVJCN7rxmbnSdW4Ylgr8gfba
   g==;
X-IronPort-AV: E=Sophos;i="6.00,254,1681142400"; 
   d="scan'208";a="340963630"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2023 15:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glHGkbcgXTKNzu3KmAS3VwKJ+UCg0P/+2NCX2Y5Ba6aRlUvih1zUNfLt7GrFhLKVqlwPcEBBhu5I9oW/KDFGVCtRgLTvX0Lxr4nPYMQQyNeu6EBATtv3sDGmpb+q3HGnJnNcMWAADJeTfkgo+ZsoH8vUnWdULuB3vYDANRzuemZa9lBt/i1ZkNkUX7yRWj1menIMWQE8QjqI0VcsPH9ZDhdClRXLxYP/tarVKpnqK37F0aOq5fBQUsTAkjmmMEmxUMrg3GZSTX1x6QSMtaT73q1b/4oNNmYSKvFWtbCOCxaWibqloMYhsv44aaPB8kGn3IhJKsmsniKOVqjCD2k/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cJRMxEZ3MdlDPeyGKgEtNemJkPGJ8PtA04/yI9ItEA=;
 b=nwTuRm7W3CTFDWfM/aPplFbNlKCRzHsnS/+ssLhz3r0FISwUDwL7bGzUGZ/6Ide4WZJ5AR0iTEdpQ5GE4H0W0hkBHNKvRqub3EqnCbro6cIGrSUHNqkvPA2LcUZAA49wKBvRis6OZV60DFp6yO5ugY9f0N2qxtKe/6Do1PQsfRglRiqETfRyz4OkrbfS/LEjYbKM2ooIu9eJJjFT98Uo4aMXqgFdqmdfzwwXEcmYBC1CoesJAcQUpbFs4JgqwrvtZf0fRsbVljaOjjeuqNlAVhKH94ZR0rr+99COOWMtq4vtHVmSXMMnymO/OOIO6pVuhHzWGDe15towyfxwGGigNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cJRMxEZ3MdlDPeyGKgEtNemJkPGJ8PtA04/yI9ItEA=;
 b=S5vUUTDKrsq7WFFitERWDONYnmgIcfsvJYSC5II4kDd/R3mV9RjjXxu53pfh1o8MoK6yuTRC4t8zP6jMWOHMixLINTbcNg4ItYG0OVMkWGxhyvnLzzaEiNY+4IctuBwlBZemfXOpUeygf+1B4DADejZD5DE/lGf8gQQTquIuzVY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7572.namprd04.prod.outlook.com (2603:10b6:303:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 07:53:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 07:53:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: add trace events for bio split at storage layer
Thread-Topic: [PATCH v2] btrfs: add trace events for bio split at storage
 layer
Thread-Index: AQHZom+sJ2IgoRBTwUCN+ncaYJgVT6+RwXAA
Date:   Mon, 19 Jun 2023 07:53:39 +0000
Message-ID: <fa9ac4aa-8dbc-db3f-000e-dc8bde426c49@wdc.com>
References: <ea5134ee9965fbfe870b4fb62054de92adb94ced.1687152779.git.wqu@suse.com>
In-Reply-To: <ea5134ee9965fbfe870b4fb62054de92adb94ced.1687152779.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7572:EE_
x-ms-office365-filtering-correlation-id: 7449476d-db84-46f3-4706-08db709a4b51
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJRDk21HG0oWM+B6NF6z6kZpwvGwvzy452589nqEa2vOaY+E7Vbu3SBCp9Fuxc/vBC8VfxnS+2AgzpsSNoEy7kk6HFYeWoxfzR6Xqm0HCkohhI3i+DI9tSltpZ+q5m2nC5UJgDDMHmPoZSAEJulWQwwVdwEnED0SdGC4bnsOADSzsVOTl4MjVFTTuV5ydY/oxQ43268AZBcyJDz231V/7r97HRXQk3U2DoYAJcRSd6hHIOiC16BizrmZD+mZGPItB+wx7nqAtaVLbFIsqJXGIl3rfVBpZCXkywPx2mYHcpCPL2OZ5c8mw+qwD0PTzrQD5hrDslbXaHSPddcFHu/g/qO72V2zlLaCdbap0annEBHLn4zoYrq4VmHFXaZ7QoLT8HQwySMtANsG6hXP8TwUOTt3dNaYOVCx34qQ/hrwgsPA/WXpb5gTggwHWad2YWjreOZ88SA71FJJRpVF2SCQtpI8B0h18JJ8zG+ZA+YLHoFx2W5InIgVtvNmjReORFkYls7rTu7bCkJuwCGQkTE6KGgZajRonBlN+Vdv5r2LWuG352Ifxr2LzxWmAivUlB8YnODBRhgp5x5gLJd4TVnYHU01tshcHx0O/z46euJf0UAMk6/4hZJhqUqP2U0SlZ/uDIGah7J6ovAIp565P6aNsbXFp2xYOcc3kF1pzyc2+/Q1/Hs4gSYi9nLL/RV1jyhY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(122000001)(82960400001)(478600001)(2906002)(38070700005)(71200400001)(110136005)(6486002)(54906003)(38100700002)(316002)(4270600006)(31696002)(31686004)(5660300002)(41300700001)(66946007)(66556008)(91956017)(66476007)(66446008)(76116006)(64756008)(2616005)(6512007)(6506007)(558084003)(36756003)(86362001)(8676002)(8936002)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXRxd0xqMjNIcXhTMUR3SWl5TmN5eWZseUdVanRkK0lMRXIrNHFHR0NGUGww?=
 =?utf-8?B?SEtrRHJTMTducXJPY291MEFySG1SbnJiRU1COFRWY2tjbnRDQjlxVWxlQ3hO?=
 =?utf-8?B?MzRiZGQwa0k3YXgxK0g0RTZYbXVhOGlrWkZNTmtUWDh5dFk4ZDk0NS9Gbm85?=
 =?utf-8?B?SGtrMHp4SURXRyswMjF6ek0yaVNUZXdWQjBwOGxCM3N4cUZ6UDFZT2VzNzN3?=
 =?utf-8?B?K2VWRU1PK2Fnb002YmpGT1U4Ylk5amdDcnpzaHZSRlJ6eEszZXFCc1FJSmdL?=
 =?utf-8?B?ZjV5U3JBdzlmdE8vQjl0cW1YQ2lMbk9DVythSU9jWmZhSTJQcXNnTWxraUUz?=
 =?utf-8?B?WFZoaE9JWkx3cmZWQ1VhMlZTUHBDSUxOelh6Y2VYMytCaDNjdnF2WWUwQXcw?=
 =?utf-8?B?MjJWOU02SHJwTEcwU0NUY1FXTkhMZ3J6WFJyQnp2Q1hxRU1zNTdPaHpIeC9q?=
 =?utf-8?B?Yi9XZXFGcm5BQ0lTRmQ4enUrbytuUEw4MGpqejZvYWNMb3llWE9POVNrUGZK?=
 =?utf-8?B?VEZYOTVwMjJjZ25xalowQTRlMGFmK3J4ZnFxNGplQk5qNG4xNEEzSWZ6anJy?=
 =?utf-8?B?OFhPUVBQTU41dGVjdFlUMWE2OW96cFlscUgwaWd3RHRmandFVFF3WXExaE5T?=
 =?utf-8?B?VURFNVBtbTNHNW5pS3ZjZ2tDUlpLbnJ1ekpnTE9haG41QWQvTlVvQjVUdkRo?=
 =?utf-8?B?RUNBNHpWTjd4YjZiSURDbDBWTllURUw4MnhkN3VPTjR3TDg1N0hLbGVEaWxa?=
 =?utf-8?B?eEJiaTBGZVJ3cVBSZVlmTURiSU02S1VxZDg3b2lCMWczY0prZTgvcXEzWHZX?=
 =?utf-8?B?QzZod1d5WlNvbEYwWWt1Ykc0b0tvaWFaMUpTRFYzamxTQ0xtU0I4b1A1YlR4?=
 =?utf-8?B?ajVqc1ZOUjNvNmI4Y3phdjJOeW16RkMvd0hxUmRiNTFKY3h6eSsyeHQwWnhT?=
 =?utf-8?B?NDYybm8zVnl2ZHpUajlxa0VQTEU5Zjk0KzRDbDBjYkVpUUhXZTR2bUFRTGFH?=
 =?utf-8?B?Y0lscElUMC9Da0I1REZUTE9zWGxWZ1cwTnhUd3JibldRSGxiY29OVmJ2eHEy?=
 =?utf-8?B?aW5XaVkyMTl3Y2pOSWpJQmY1bWpBZzJCMkFnZXVJai92VUpUQnRaclNqZFhl?=
 =?utf-8?B?NW1rclZoUFdXaVcxOEFUOENDQWFxYjhUY0ZkRUJCV1VBeHFyTTZjQzZtSDVL?=
 =?utf-8?B?MXBYeUZyYU9sUU5LUFZLOE5pUjlnakh0cFNNbEJlUktzMDV2ZzNRaFlmdi9j?=
 =?utf-8?B?YnpEaC9rMWVQRm90bFpyV1lmVlhYa3FXemRTK25remtBN0kwMVp4Q21kZUpj?=
 =?utf-8?B?b3M2V0twS0ZkYUg3TGMxNWc1OGZnNmlmbU5kOU00aGVNOFNsTUVueGhldEE5?=
 =?utf-8?B?SlZ4ZUFSK3h6TEZXeGhKaWJkYndpS3pUMzVLc2tJMkVnYXpiQnNkTFZZWVpB?=
 =?utf-8?B?Njh3dVIyL3NySWlpeTZVT0ZNYUoySVZRWEwxY1JYWGVBdmVEQkJBMnVHQ2xz?=
 =?utf-8?B?SjA0VHI3dy8yVkh5Q3JDR0NUZ0JlSGthTXUyd0lSK0Vsc1h5Y3dUSk5LcFZ6?=
 =?utf-8?B?QW9PdmtrbFBjQ3c4VkJOWWxoWHJuTHFNSEJCUkwydmM0RnRkRy9VNVpUR1hJ?=
 =?utf-8?B?TXkxWDA3MmJIRzhWMWxvWUZwc0xxY3hqMHNMbDBieFBjRkVYK244WjFvNVZk?=
 =?utf-8?B?MDF0czdrQnZXdkVUNWo3dEdZRTB0OVQ5NDZBTzkxaWYvTjNBTXJUSkdYUnR2?=
 =?utf-8?B?NHJhN1ZDSGd3ZEdPMHF6NE56VHBrQ0ZTSGd6TTlQcUkzYVhYMk0ycHBzK1Rw?=
 =?utf-8?B?cWJJR3RtWG5XY1hSNGlzUE5PWFprblFXaHoyS0UvdW16TXR5VDhsbWRXRkVD?=
 =?utf-8?B?ZG9yc2NwR3RrN2V5eVdCcCtxRlFOdFdFcERSYkJKVWVvZVRndU5lVDRGaVlv?=
 =?utf-8?B?Z1BveFlYL25sNWtJaFpnbGVpdUhqMUFxdEQyOU5neUV0VjdtT3dpQnZ3KzFQ?=
 =?utf-8?B?WW1rNHdqWnJhR0lzZ1hja0pMRTU3dVcvamthem5YalAyRkRNZ3hyVlJEV2Jo?=
 =?utf-8?B?YXpmdzBCQnBkN2kvTElvRS9nTzR1a3Job25VRkxZdjRCTW9tOG1SK3VWd0FH?=
 =?utf-8?B?KzdTblBDMDZnN0FDNGMzRUd3TjlkSlZOMlVmVTkvRVpFOTRXVDdDclJOK3Jr?=
 =?utf-8?B?bXBjRlRnY1JmU1hmZEFiWjhpVWpqUnBDQm9nRDlqNXdrejR2TktxdVdFS1U1?=
 =?utf-8?B?Uzd0ZFFSMU5zOWdqdmhaaFhHYk1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48CB6BCFA53D7F47B97DDAA92B2B18CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gmpiMFLxNFIcQqLB82ZLGsGNec+3b/B9TA5+F7715V445i/ZEqIdwkWPlis60WDRjXE0fNrZsGPWydDXIUIz7SkKYC7cvAoGIa2vCRTjsRzPBqpuYCjOMk3oigUqk3kwnIqoxjjLFWzWrZCQ7QPO7vQRo5XDV/wczNBn7fhvKsUgPaY3YTGAenkrE+Y1UEaCcwyKEntJAbhMYa5hUXr5ds/f/hLsD/eGQd7A4qGCiqm26hSzAEoFq6Nd5zPb8ilBsEsjGHbf0ITsNUOcVg9Bh39SSLh/61uG5YWvtqdlqgTuXDk1nnHPmitvGOtyTHXPcuECecNClT8RxPj3LnuSOnEX6v3Gz7hHAMcSduz3Lp+Bv2RDxFeGchfj7hdwIdZANiVGapG7KswoF23J1fJxJaPdLiJ/c2mYp3lTs3C1YKMjzkdmaDYb51rJAHNgwquq2Vr+ECNzWTnh3NzSAdNjj5WvU5tyhb16oHCUyurUI8iB1sXjadF16QOit5l9LvwND53aQZDn6ANE18j2yCm24uNh3ffNv6UttJwpTIEXlWIj9NB8Hda5zDsLco7vbKNc5tWPmTUD+XPSquRPLx5qc5CzBVorAdbEC1jRvu6H6NDd3QEM6CndcPAXmk+qC01DE1NxvknYcp8EJuXBV4OYDTV+WJOBhqJCXKMZ4Y9ETgEE3PVxqon8Gv7c+xwBLDNx/JoPD1RFdZoha44i3phL37cyMuKNEyodv8811G36+/NrIzIRU2Zb/JdqGqdhCNHDhCqzOTbZ0c5rJouDSQFtiu4xASyt8Jkm0WwJ9VZ5aMW822MLnMV6aFnxap0Svk4m
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7449476d-db84-46f3-4706-08db709a4b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 07:53:39.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUT3hTrWsS9k8CXqQsg8o9WcZWDjzemkwkt3adYGdPLSuHmdZYS5crN+pXBsRekty9ZmYO4BCD0Qrd2Ht8CzZH6i8FgDVKkIG/lfwFIRBuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7572
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T2ggdGhpcyBvbmUgaXMgcmVhbGx5IGhhbmR5LCBUaGFua3MhDQoNCkxvb2tzIGdvb2QsDQpSZXZp
ZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4N
Cg==
