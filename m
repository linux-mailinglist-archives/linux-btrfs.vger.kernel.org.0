Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2560F3E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiJ0JmT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiJ0JmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 05:42:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6A80E89
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666863730; x=1698399730;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KOy25J2uvu+JlStAvCqsm2ysmjbj0InWRabh9QBIwzgJLeI/MvT4bF6L
   /jLVUBCao/2vhN4mhN+pWcYtCIcBHXa6iXqBSYN3clHfItdb7UHCZdKj1
   dEaTOji7nOzYwBEvOopvBCjBmPJaQ0+84vXdwZIo5idZZox4HReT/6/v3
   c5hZgtrGXiPYu7usLVzZyqipJwXOdsI7REPVF5lNhuPxplIZp9qo2Dg1Q
   oAaKJVj8LGD4tMV6UFoBYU70xWA59xecqK2DaTYl2I1Gr3Hll+d02lmrI
   xpFvCLYbVBNLwCUTs7DHTwYs7ZDqzOJ8XFJbHiuFPTfi02mx+LqAmh/Xy
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="220030485"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 17:42:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAnh97d/S56j7Bsl/C+sbSa7k9FPEPNv3DWd6Xn2eoErUFdOEKMiVas4s/lvRQGIU9G+ZgUgMlSGV5TXL+myP8Ax57RxltaOmF5NMT80Is++3GBWsaupnCfHaCRFNwDaF8/BAqqjPCMvhV92PNsW3TwbMG/I2b5IXbRxR00OPYkwuKgXbq22PCXrxjg1Stb0xgs4Q4+DMksjRHkaEHfx+am1hmbjbLNnZlDqWU/s7w9WvqHlmLHjkm9q425mwFICU8hTKff0c/fYjdNDXHVLIfN9mt0VtCk7AVdFyVsUd1Z7mBK78q9hCEJELkHOY6AJ5C34Zv1BqjjurB8yTc5TgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HX+JQmjcARuBfFhzoZYFpHqctO/Fq/TxmK6q/3rkm78Fi7unGxebTqeABXbnO5r5b94uxtMUmNYJXRVEUmiYsK54+K5tcO0m+/vqGKZBh1B8qIyG29pQdZPHvhB8dUfvark7n9M51x4zirADD56fwe3En53DMtf8DKDcB0/FBIFztz9T8FG6diw9ONdTioFQwE0psmV5vBvVJEAm2au+ouWMlAU9F+IEPLzvOHqxEuO2yJAaLQzl45B3HGDfgkfgM8zmGQAKcxpYfMSjyqOsBLekgwDDVr+NqVsiu/cv78AxOTAFeri+NC8M6QoGRa9cX6NUzUyy74rjgWPioT3Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RdOQdIdzX2be+waibkkrIXIyPkqfM+a9BeJuCc2LHu8+7YBzWJhef+H2mBXvZ9lqbs2/iYScW7EWy2TPy6C3kESJmzFB57g5nzrwS1rHKU6EZPiF6xEuYXfn8KcD99eTVtgjVMx9MWYSfl+OYkqPd05YGcHopDv5886gnXIG/Qs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5673.namprd04.prod.outlook.com (2603:10b6:5:16a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 09:42:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 09:42:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 14/26] btrfs: move ioctl prototypes into ioctl.h
Thread-Topic: [PATCH 14/26] btrfs: move ioctl prototypes into ioctl.h
Thread-Index: AQHY6W7qFg1cP/PupU6Kyov7DOri7q4h/eOA
Date:   Thu, 27 Oct 2022 09:42:07 +0000
Message-ID: <317a500b-ad5f-d1bf-0d90-cdfa783ba164@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <779e5d48b8e1c54974e6d90d5825b6477f5750aa.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <779e5d48b8e1c54974e6d90d5825b6477f5750aa.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5673:EE_
x-ms-office365-filtering-correlation-id: fb5f5706-87c1-4cd5-a5ad-08dab7ff83b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdkZGlF62sIMT1FjK7uvACA+WAwasjNHKBIUOof7MrsJwE+Zk9Rx+a5HNyq/VpAFti6bVGSkKGKyKFh6lfsHOfg2IpnMOebHS+Lc8AXBiNo2w3u8fYmVFsqJg6oZWnALU263W/IJbXmYGkmAIeDFH40F3pt7cNCw7I2G46bqi+57l1svmJuK6GEBXEOC/doEQ6Y3mKt1bI2dm9EBvdVMGNn/FDMtOh5RkvXtsohR8JXVEvMa/qOGDQ+Qj5c8IF2Dljzq53Fhf7ghhCl+gaei5MPuLt0KEfUbB4HnlLG4H9bhI8rA1rGfZCZF7UPm85tEqeGfe1JKXP3g8KjC8lz8k5tMxQXsJ46I9JANWn2EJaolhZGVyOyU/HT3gLToBGmFC/CJEL2nKribB+B4pbbTyA75acHOZ4qVxnTMaRJ1GnBT0YOEz7gn27OhiLbW6+XWspfgmd5Li3K+50/mpY/aiwH7HU5R3wWs5T5r+RhgrYfTKsnkikKozFvaBSGfDE8Jthat2PdUMXa3IPmQjKSiFcKTbr++aS3QYsXrRK/CHfLOJrfLt6adjLBvJbugNzwPmoepkwrSByP+wB0yQ7wzFhrTymNKZOhU/PwdQuy0tqZh8dSxrWJA9pmNY4BzIkBm+8w7Cda/YkL6x4wuXex6OcEM5MK3dYRueFslGO9I0j1zK2scFhaAdZ/8CE0yk4TDquLdBfkSaO7J3U4tALHQouwQlYSouZ5OzqU/+0Ux0nIV6CBe1oXrESfqDXraMlmyqOE+Vtcnpr14s6HQH4rELiLTMaxSN0DbiCRGUApomU71du7tRJnKhOdhMdzrRXOImIBfEZV1vN0cVpFAq0lAdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(5660300002)(8936002)(26005)(4270600006)(36756003)(6512007)(38100700002)(41300700001)(186003)(38070700005)(2616005)(122000001)(82960400001)(2906002)(19618925003)(6486002)(71200400001)(478600001)(31686004)(110136005)(316002)(66476007)(66556008)(86362001)(6506007)(66446008)(64756008)(31696002)(558084003)(91956017)(66946007)(76116006)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZGdno2QWVxVXhBTHE2MmpqWkhCaEZyZzIxUnpFVW91dWJCcTdKVWkwQmhm?=
 =?utf-8?B?UnlYd3RGRUIzVHMvTXI4UGx6WitQWjNPRVVybFJ0Ui9FNlkxbTNLYldwOTh6?=
 =?utf-8?B?NE42OU9lRnI2aS9zZDlxQjhVVk5mTVlTTEUzRVVZeGwvWlcxOEtsVkJsM080?=
 =?utf-8?B?SU5UZ1FwNllVZkdRQjVWZDNHTGttN29HQkhZWkhGdjdPUEpYUXlXby9lTDlT?=
 =?utf-8?B?b2QrSjhrT0lpdTgxNDhSZ0Y0Nk44dzNkeTdWMWRCcU9CWXdhdDJSOWhMTDM1?=
 =?utf-8?B?RmE3d2djdVBrUkQ2ZWhpL2tMZGtFMWU5Z0Q5M09RbytjdjFoVUFXK3AxTUxR?=
 =?utf-8?B?OG9qWUs5ZDFRTGpCKzBhQkYyY2xuSGdRQXRWcEc1Q0xvdXpKNWlDNXIrc2wr?=
 =?utf-8?B?NEp0cVNDVHBQcUZ2WWxvMUxHbk1nSm5IWWFEWnF6VUtpZ2xuMHFKSmtvYkpD?=
 =?utf-8?B?YkY0QkxwQ0d3Q3FENW5HME5EOUpzcExEdlpTVFM4ODU3WWJXVU9kYnhuZ0xO?=
 =?utf-8?B?RFM2T1kxUEUxaXZ4MUdKUEwyUS9pRVM4czlRbjBSQ0dXcUF0Z3FhaHVYSXJC?=
 =?utf-8?B?ZlkvNHlaQ0NmUmdibDl5ZmJXeHV1UGFCbEdYK2U4b0dHb3o1NEV3MnRJdzdl?=
 =?utf-8?B?YjBuQ2ZXWllnQVZPZExrV0M2ZDlubkhSdXpicjBVVWpqcWl3V003dFpNTXVY?=
 =?utf-8?B?emplZWwydGdTenNaU3A1UmErMEoyZTVQT21wa3VpSHpLYnk5dXZNVUhiYkRn?=
 =?utf-8?B?SGVCUVNFdFN4UDM0Nzl2SkRrYTV1Q254RytDUUxJWlpVeUJ4aXNObVBtTHVr?=
 =?utf-8?B?WmVRam1pSTJOSHFtNGlId3dDcWNUZklJVElHMVI3bkZBaHQrQ25vbGJRbXVL?=
 =?utf-8?B?U21XcVdWZ0gwOC9IWWlyclpkcHhsNWZ4OUlXakVoeG1BemxEUHJSWmdlUXF4?=
 =?utf-8?B?bHcydVJlWmdUS25WMUpIdXNvY1NnczVHNGR4QmxsR0JXeUljQTdwNUVnYnhw?=
 =?utf-8?B?Y3NTNy9ZV1lad3RFZXRSOUVsWE9mMHlucHRBOGNKbnNnRml3UWFnZGFGc3py?=
 =?utf-8?B?bm1MMDlTVmNYUVBPQU1HdFFNTS9NZEVDZUhZamp5UCtCVElyK05pd3V6NnRI?=
 =?utf-8?B?NlVrYXZSTHBxQ0F2SHZ2VFZvV29UeVQzTVBWb3BkWmhFaE11ZG40aTJGUDBr?=
 =?utf-8?B?S3lHVGs0TUJSRytCZDgzMGFJcG5RTTMvU0hEVFpncVhUY2VUNzVnSVE1QUdp?=
 =?utf-8?B?cG8vUGs5SzRYQ2Vjam9USlB5ekZpVnhrQ1A5OWw3VFZhMVZ0TDZSSkxzMWlx?=
 =?utf-8?B?VnFsZjA1TmlCcW5jelkycWJUZXNQcGhVZXpnaFM5aUxSK0F2cVFCT20vOHhn?=
 =?utf-8?B?dC9uSUR5aVpkNHZWM2lvM2o2aWRiYVN3c28rdXdOS1k3S0cwb3dsTk13M3h6?=
 =?utf-8?B?Qlk2RTdES0hRUEVxQ3A5NnRQcENYSjR6eDkwNGJLTjBwbVJ2OHpYRk1qeHd1?=
 =?utf-8?B?RitRUlNpVENpQU1IVjRiSE5BajQ5MGxNTGp0bmx6T2RNTzJ0K2VIcU5IQjk0?=
 =?utf-8?B?VWhRcWRLcEp4ZWkyOGVmcm5VZkNjK0UvVFZWb0FGZnZkUnh5V1UzeFZtdTlF?=
 =?utf-8?B?L0E0OE12TW9SdER1R1FlUXBwWjNpRks1ZmNhR0l4eGt6QzFHV1M4aTF5Nkwy?=
 =?utf-8?B?dHhoTHFVaGZRd0RXbjY5S1FFZCs1c0J0UkhyeVNGT291ZnpGNjZGdUxpWUhs?=
 =?utf-8?B?b3VqeU1IOU1XU0tpVUhmTmIyY0htTU5xclVJTytFNnNIUm5Vd2NLbyttbHlM?=
 =?utf-8?B?S1A1RlBNUmNlRzFoZVJOMS9wT24zbGkraEhTRERFQVE0cTNnTEloTExKZml4?=
 =?utf-8?B?Z0ZvN1I4T3hCVXcwSGVwcUJPako0SWYzNzg1bjh6STUwc1NPNGc0UXhKQjVC?=
 =?utf-8?B?MC9DMDZYbjJkK2REcS9XV1FjNk03N3lYcVRlQW1EN1NHc1BKcmx0ZlFSSFBU?=
 =?utf-8?B?SXFDMkliZkJjZkpTRWZISE9lbHdkM0ZkMDZUZHZrOU4rM0wyUmMzaGlLMUw4?=
 =?utf-8?B?OFdMQ3JQRHhQYTNEaUNEcDNLSVIzS2xkWCs0dWtJeFhHbnVzK01ENkFvaTl5?=
 =?utf-8?B?Vm9rSTZpeWFjUDJuYlZCYU16Tk0xS0wxaVZSQ0hYZWZYS0g0WEx4TjRNU3dD?=
 =?utf-8?Q?eNbDKXS5eLKycvxJqA9qPew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D89C46C258BBE46A84364F397B4CCB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5f5706-87c1-4cd5-a5ad-08dab7ff83b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 09:42:07.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWfTvjDnBdN+kgra9Kz6om7wrkDor4B8uWaV6lI0cQkPJJexBhnVmmnI9QG7KSbGNsXZ75uFpIIJU9RXBycLwzUgjY2RqFRNiplu3VrfVxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5673
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
