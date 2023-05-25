Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9607107AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbjEYIf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbjEYIfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:35:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D81B5
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685003697; x=1716539697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=on3wm78bxkMNK0PxmyAAVgwD91O2O2W4+J0N3/2ji8ZLcRmB6toXkEk3
   N3XZ/6z694Kzy2xmrbpjxZ3T2TduREC6akBwBWpfVlFQkZlYBYcQZGoJE
   iAntGZPB5SYVXWhBOMhvlbeCage24RCZj7kUjDiuH4s/e+8kKd1CdF6NX
   mr4hKsIF2JgI/sBmqdiRtqmQbb/NqSUB3z18yx9ysU6IxDTRKbtCJhy3y
   Kw1amvo7WV892gX/86WCkL5SObHSJaf/lu0Me1PVZejLzB2UO6uzjs62l
   POxk419OWlrH9HXkyMcZ9p3vDRb6RDphK9ScWp7KinO2XPp+9RlAq8ojH
   g==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="336082550"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 16:33:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQsLyqsG21zSZSAD/sYPixIKP61eFL9yPgEXPo1c9JhzCaagWkAQfGpre+9bdFncWphfYt/V/EhvBof2yD5b91Ye/HUpgJ4+OQI3Rlr04d1klaTfG+ozJTZPKDlZHHZNLfVBZAuJsQdhvGuKhg6qqfriyuM2FDqAFG7rwTubHZ9k70JMMvSicL2EuHVk1+u2y7eKQgGoUXKtOBchm6ZsqMQ7c9wfux5rhp9nCcf5xx8LsdgwxpG2+Hxf/xrJ0yJ0Qode+yw3QGQ18cwaB1FgCXB8WASPxjhz7N6KmrMEeuHHvN/7g3EbdU98W2OK3sa0A3ZH2g4nSuftiX3wvsdJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eli4ufT+fcHWc6Kww7Oc8JDN0qPBukYXwJS0qQcgvjUvlIbT0aPLjsi5xIYFUauCQKHaJ6FHhJWxHQtcH4xsm/yJDvCe8zEPbXp/mrpBFIDGs8w6quywu7DTpxR6acBHv7POSm4rnaO2RnyeMF81cImVwjUt9UstY6Zr7Y6sFTicJhm0kDtcQWe+Oe9Yn5R10o1eEIWQrOKPu8P3Kv927qsk5hdia2kdQ+eQaDq6XGFf3cF2WwjpPdYoMtKQVoiYmJC72dVOR7Ouk63imkDp+jRHcg22Sgc6ID2/encOLfJUGhvXkQ1b2aL+liAvQJDd7bISNAsdiHBUlq+HCZUMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=geqtdtUfILkl6EsuoJ5VoP5RCubDOzvEZz5F+66jmhzlksWbhi16VOTAbskxzBgO8RJw+Y8HIimmXZmuslZWcaATZ3GzsbcYXKv2xnJl9isHRjDwNSxRH9ZI0fkFC+k/lkLZyfPQUvfaoS5cr2yIDXVyhNf851MOv/GGeAMmtUw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:33:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:33:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/14] btrfs: rename the bytenr field in struct
 btrfs_ordered_sum to logical
Thread-Topic: [PATCH 04/14] btrfs: rename the bytenr field in struct
 btrfs_ordered_sum to logical
Thread-Index: AQHZjlDsChHSQAoUuU6I0sw3w64/WK9qqqAA
Date:   Thu, 25 May 2023 08:33:50 +0000
Message-ID: <e634f8e4-fd0a-1d2b-ecc3-cf14fcf03e9f@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-5-hch@lst.de>
In-Reply-To: <20230524150317.1767981-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7436:EE_
x-ms-office365-filtering-correlation-id: 20d024d9-7bf5-45ab-33c0-08db5cfac467
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X26sieYuPvd38iGXpI/OWMeEkPBBB4OUP7ARtGOFAQtuD9TasXeLAeycU0/KVsp+K1pl4VkFt3z6+6dW7WsRdGYeJSrHgi+VKaqatRUxPXxv00h4XIjvCP5C5fqu9VwyTdt3wDjjmK1Eojk9IZ4OFAHfz8fPnumfAq3SE0p90XgPwqGofbAmucG3CAsAQWnsD1ktPvYxlyPqxQ2ftFhSdWpejCxZ7cWllUA+0rLaCBT/x0uRr4MBNsa960IdKoGPx1pBt4vHTIzyEu1hUkanaMH/HNm6pRPkeBUK5p3Oi7A8nboMvMQkN9IqH8xOy4ZDt76e2TdDh4VhuejwO2oTxLfNBbnpf/ocdQzThUbcW3axKvmfC7JI2AC1KOCoTDFsTgZxcqWPzkThc+59fw7Ma5xqDruufHSO4s012dkh3JfifDI68Y+tdsAEvDwyAlkmiMhCTgzggjCEMLhs3ID1f+CRXcjqedA29TXiNXxeddUp/nuP1vutHhZHtQ3I3jUXI/bg+Ajpo0EEH4IVWhZzjEpiYcGTGGBKsO07XLoqyGwXmd43wCfhwqO8H4m2jqW0FUaaCYf9GqULYlhvnRJDRFjWayuNkDRZj27ua1+Aj0fI2AJi8tJWTYnQZQ04R7vMMkdf81Rd6XKYiH2RKfP030vCQpjA/ay+tuu6H11on1Bm6Cnqrr7GU//ZXGTt8TAP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(558084003)(38070700005)(86362001)(31696002)(38100700002)(122000001)(82960400001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(4326008)(71200400001)(64756008)(91956017)(66446008)(76116006)(66946007)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNLaW54RmxYSU0xc09qaTJ4OVg5eDNzWU1oK0twcU5HcDMvT2FIdFl5a0RW?=
 =?utf-8?B?QUFvR3VTVG1aaVFJZ0h3YUJFUzRMcGRlb0xnbmJ4ZThWeUVXZ3dwbGNqcjZU?=
 =?utf-8?B?elIrNmFxa3AwU0ZCazFmWEp6dTkwbkR2Yll0aitZclZPRURDMHoxaFFxaFdv?=
 =?utf-8?B?V1JrdlhVa0k0Qzl5dUZtcFpSbVNwbXBzYnZxQVN5WnlmakdjU2JuQ21aMWlk?=
 =?utf-8?B?WlZOY1RJYnIzVmFySk1RTTltelpBWXQ2c1FQRlRkS1B0RElETEE1SzIrR3Nl?=
 =?utf-8?B?UFBCT1pLaUxVcUZEYkp5Q28wNStCWFNleWpWUnN1VHlMemdEVm93UWpKVVVl?=
 =?utf-8?B?RmtFRzQweWhkY25MWEQwb05pUmhxenNkVlRlWXl0N2txa0dzRmlwMzNzWjY1?=
 =?utf-8?B?akRNMk91ejlEREtzQWtNcWJEQnhMcHZuaXVmajhMdlRKQThFdEpUdW1oOC93?=
 =?utf-8?B?M251azRrL0hJK2FZYWpvTEZXQW51Z0gyc3htUDJjUFZDa0drankyMFNrRHBP?=
 =?utf-8?B?M2RrWmZESEdkK3NVSzhrNVJyUTJuV0FSZ1lVak1vM1F6NjFnbVJTNVB5NEQ4?=
 =?utf-8?B?TFp1RlVhU3ovTW00QXZlc3duKzZ4T2lXTUNVRklzZ21vNG9CVTNoODlPOTc0?=
 =?utf-8?B?RW5iVXd5MkV0b05weno3NnJqUW1zb0M0SEVNWUlVenpsRmRZZ1ZxTm1RMEJQ?=
 =?utf-8?B?dEZvbE0yaUMwbVRadXYrY3NTOENDSnNIM2tYRnFhUFJMZFJMTHEzRHd5eTVR?=
 =?utf-8?B?WVUxY0MwbkhDQncvdTgzS2xJM28wVUxIcG43c1RMVXdLV3Y2akpQLzluSk01?=
 =?utf-8?B?WWVOWjNwUlhZL0N1RjhFVjRLME8rVG43dUdlUU5IZVZVaGhNNG83WFVPZmJJ?=
 =?utf-8?B?ZDRGRjBQZllVOVVGamJFaUdERXRYaDVwYkpkcE0rRU4zWno5UkRNQ0ExNXJ1?=
 =?utf-8?B?YzZDSFliVzg0OUFRTnpTdkVERndUYWdQbnRmTzhEZUttdVRiWjBTVEVOditv?=
 =?utf-8?B?Vzc5eDVac3VtaEFKWnBhdEtKWkFGbEszem5hU3FtRVJvc1N5Y2hvbDRQblF5?=
 =?utf-8?B?YXlmUjg1RnBRV3hpZ2R5RUpaRmhPMkJ5QUgrWWlQZ1JiMzUrRFRlVkdjaW04?=
 =?utf-8?B?dkpWYk5YRmRiMUZ1U1EzbUxSTVRLa1VCVHVWVTBqUHZNRDEzZW1SQ2JCaUNH?=
 =?utf-8?B?Mk83cWI3VlhSSUQvandlSEF5Z1I3VDRWdGdIZ2lFKzIwTGU2Q3B6MHhEd0I2?=
 =?utf-8?B?VHJnN0xqNlNrQkdab1Erbk1EQXhLOEhRK1loajR5L2tJMmFyWU9VbjhIL2hP?=
 =?utf-8?B?TDR2SDljVUlvMi9udVdIUDlWTjNzYlJCSmRUQzFTZXJTaGtqand6WGtHcFRX?=
 =?utf-8?B?OGpDRFJmNkdlT1NlRGtWbzJSU0drV0g2MlBiMkhLcnVaWExzVHNOT3pGMkZI?=
 =?utf-8?B?bkhhN1hqbGZWV1dYc25tOVJRQnpxcFdjSVNwUlN3MVpNSVZTS05EUDNlaS9m?=
 =?utf-8?B?bzdwSEZ4TzFiVStGUVZ0c0hiemx0T3BDR2k2dlNtU05hUldNdERqNkhhbGdJ?=
 =?utf-8?B?NEVzZWo2eStsYVBoV2NZeUw1RWVIdzFwUnJwNy9rNG5qcjhpQkovQ1dmd3VL?=
 =?utf-8?B?QWw1SFQ2czQyUXpyQXp4enpxSTB0Wm1VVTdKekJmOC9CeGt0b3IybWpFb3BC?=
 =?utf-8?B?Mm82L1ZRNVhXL2hZdFpDNSsrUmFobHByc2RhTlF1aGpVVitFSWJlS1dZY2hX?=
 =?utf-8?B?OXNKaUV2MmZlOEpNVmRSaGh5R05Vb3hEYklmK045UGZiTzhEZFd1bXBubmRz?=
 =?utf-8?B?OXQyeGY3M2tHdFBtVWlQS2pyWml6OCtITm9uZ2daNkFibEdYNmoxNWxDbVBO?=
 =?utf-8?B?Zk0xZ1ZrczlKYVVZQ2wyNHBWL3RJcytvaVRlNWpPZlBnQTViSHlPa3FKUlp2?=
 =?utf-8?B?L3RWZzdka0h0RTd1WUdZQmZ5dkkxWkkvZDVnWVJTUGJpMk9nSzdBM3BKTkMz?=
 =?utf-8?B?SEtZUXUrOFZZRnNpbW51Y24yTDQwRDBjdDd2R1ppUVpGTVMzSkVsdGtYS2Z1?=
 =?utf-8?B?eG53T1dlaWtRbkxqdEZtZEtVZ3FGS2tiTXQrN0ZEajVoa0F6YkRDbGR1VHdq?=
 =?utf-8?B?WkdiVm1PTCttY3RHbXl2SGdQM0Z2MkE0aXhBUm9hVVJ4bW1wd1lwdzlaZUdX?=
 =?utf-8?Q?M/AJi+STKheWpAhz4dnKmMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F68E74A7BB3984F8F7B88EF855666DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WnzqstefzetEjZCqYNAPRSXr/xZ/BCMosZgWPmmXSP6GzFLVpbrfo6IkOE2Ctha4V64L6v2WlYCBcNLT1FIoFO6cOlP5QwIaXbXFMaquVOf9PS4g/16Nd00mo0irZD0cyBobMyv8HHJW3fvUXwNSSUT0IukJ93maiZkln0YCANaF6MwghtoCkpxGNiRLhhYDuEjN+EJe22kudUNUzbIQMSzEBhPKqEocse+zmtHzJ0Lcpmur+sKEOlFW7FNmA4XaWDgaQ9UCxWtd9U+e/FcAXrJ2X/GrqfKh+kZb51SOuuvP6CQfVDzLq/vjQg06HH2BZx112s699kgMGZ4ujkEdQ1/1se9nRjSnFJXPXDtlMDwTj9KY8sbWoJWJAmgbKEwJN3vTM3Xp71l8n0fVXA3bt24hFC2zUjijW6ylM3KlUBg/Jfkeag7fs6sLoVCvLNg6+lCAcnUHQICX2bfc2aqjdO9LsTuVZYj5Ijl3NwghxTnQD8kpLFUCpbg1ugr8BsCqfiX+RomsZiTwNdkB/kQYofFuky0/2uv9HAGOBU6nlsKEMJJBlvhkcEXG4THfzAHRDFfEdQINX0I6eAWv/Mr80g/bQ3ezQuaPW8pE/6/AzK4ib1eQcwXuWF7+rYKEEO7JKG+7Glb4rz5CAWIGmoLTvjLiNKqyqPyp0H+fIM8sqLZslhRn42t4oyGUfFiEuhSQqDQhd9mjulXeDZa8AZFrEIRibgDkr+s4j9iGZWGn5kamDYMboPiznNE5UC6cjZBEsWJ5WrH38Xsh2vqpE6e1MxgbtlTHvrOjpkyjr9Pc4TF5dBpvkHOsCtMjCmddYnC3L4VwtZ2DfE+e75jnuQXT3V2fX8/4X+1/OGRqssMJKbBnZBhvthyAXKkrq2OfRONz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d024d9-7bf5-45ab-33c0-08db5cfac467
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:33:50.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tT2jLy0nASckdgMjOORJlOOJp/w3S7dHjgLfKUAqDsJc/nShfuY/UHdHxKFiMc08Gf+ZZF+9CMUTydL7MomHeROP8HLJXP/5SqtQRzINpC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
