Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A869CA84
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjBTMMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 07:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBTMMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 07:12:13 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144E1A645
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 04:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676895131; x=1708431131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NVExSWAErXc3tb3hFepV9ORPScG4TVo2gbI+QFxQY+Q=;
  b=mellzv7QT9WuxG/qctyDB8u5NZWK3WNMu9SooC5TVxhl/Mkke/XwiYI6
   a6RoEjU4OIrhuIiMM+Ce4jgWF54Q8hS0cYrm/TGRq8UeOnbueVsluwqa9
   at0E8p7e+ySlWsiN1BWkYuQDu+y7YiDwu+3xLTxlXx7Fqyt1iZBmi5EQP
   FKp1fFYEkurU69AYHsC8+m3zFj+XBpeVIAcLy1CK1bbxExoQGkZTK6FfF
   WtpvDIgLavgNXGk7tftaYNdRUsN6VuCcAkOWyxSzEX4Crgkq1Nc6bF4nW
   xCSZo85J+eIc5Pd1EyOobFGNfYIBa8lZkO45+7ZC2/Pl1+tAJylGonHBY
   A==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="335699481"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 20:12:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUqQFCawCJA+BIB4XJMs+Ck0HoIEKKzc3XMWxB76iiS8DPXAuw5QEDr9I7R6vIK02AOFxctOvhRKoVjR8TzsU5zKUsCKRtjWxtXJROrZus5WiA7gzpvWchFLlFQLOqwCNJQ8/0M2EiTyE2frDb93Fe54ROKXP3P4OXXwfREdu6cuBfpQTOHvi225dsqczZBfZvDAaWGxfSLAW1ZeKuQ4+2tOk1zUnoARdE/5TST8VfMcEOcbZM188nkkpORB95dzNMySXO6fZgjmUgDMAkg2nusOJlYixZcM1QA6zx1S8vCk5RxpvlPOw8QUMTXzwA9+MQiPmWzwB/Ed0q0LTDnCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVExSWAErXc3tb3hFepV9ORPScG4TVo2gbI+QFxQY+Q=;
 b=jrHDLVbuQtFIvPfsecyeH2EH/M7PXWzCuYDK/Mm8jLJHHYhIKcgbc9LEwUsqebgDsVgPZ+LlXCtSz0xfoPUdbEOlb6mdI5DEOLtbE7totDPMpTKjCUFQe40Gzt+Vtq1+0KuicfT0j/hBTMEptUJyKeasY5R8Y5o2z82VeDKPgEAw2rGjh+Vs0wz286Jt6bnNhU22l6rJvEowNvVDclx8U7MdYC6T5z0KiJ/7jIJpObk1Hgy+v5voRogbdOYKuGy2qt7u2Zd+Gz2wH4mfxQ5lsFgxnxO5bskuGSvtcARAplM5e7WjuyhjVFu9Mcy9zmPwKLys+gwXTDEIhdndwCkyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVExSWAErXc3tb3hFepV9ORPScG4TVo2gbI+QFxQY+Q=;
 b=AZtspx1upzTjstlzKY2C9zoGlwjBKJuIk25GeqAfWh/IH5jgDprdmBPa9P3bZ//sxaRumAPOtP9N9oFIaXXgxYlFTjKgd6Ry6pbgt9kzMFO2QRXMch5YayMou8EoNZLLsfN/Y8WdWGzwWLA/10bs2EjgVKACLurr8CNXAYk5MLE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6224.namprd04.prod.outlook.com (2603:10b6:208:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 12:12:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 12:12:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/12] btrfs: remove the submit_extent_page return value
Thread-Topic: [PATCH 09/12] btrfs: remove the submit_extent_page return value
Thread-Index: AQHZQiS0/XWsFwmhVEazly26NeIfH67XxMmA
Date:   Mon, 20 Feb 2023 12:12:02 +0000
Message-ID: <94ee49b2-bb06-d394-9476-4d0cd6b696a2@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-10-hch@lst.de>
In-Reply-To: <20230216163437.2370948-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6224:EE_
x-ms-office365-filtering-correlation-id: 7d37bf41-bbfa-4cb9-b6a1-08db133bac7e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtutWSf5k86a/G92/7ADbQeDRcREJ+M91GpJHOUabeE47ldyhbNsvtO2JSabhP3WF+txzb3JqQ6UhEcnCOO4zJfVPXkggEvEBinj4C6VxR48jN6Dd3M1+pm5CcU0q5UhntSP7BqM/sAVsBgEGzBg0iPtjwepn7JjBGdloJmiZoC3080xBP2FNR0CI+C5HfQfVXmIbwuGurf47OfALyskStIJLmCfGtfoIHSs13SLgDEDkRr4ANEFir4H2R+WOwNsrp5D+K6kRsQCZdeh/6o5qogymFDUr0w0Q4srE4HB9ck+7lt+jXR/7RiiO9KGzDaf+p/jQPNYdLaPfixNdjNnV97kdtI3KBHGan6FekHENbkJZKdJgeg933lu3fANc4JfGpmLAN+JjWTM6oxqQmkpu8EQ+b8JqUSP056/f3RBSzJuzmaCk76JycZ9awEKxDusUrd83JQNl5pTmqEAfj3gp93TPdu5JXInHAgjmeB6MqqwgqxMzO8VPJNEpOqX/Ah0BBlh+LNXCXdheAI2THIvxP2B8r13hZ51RsU4+8zZc3UYu6MhJN15ATswKVb3OvYO6fjYrZsSmmerTWtSxYz2n81npBrFGXvUbr3SkkorDv1DFdtFKX9vU4OHxt8vSC+IuWi4rgkoo5klTdnOvdlGC/74e+JTWMgalKyCi/PpAyxUqUfOjnhgJst/wfxNMUFwjaldjOryEAYAGcPDkj43ax3quqlkLAsNcfW5TcpDb/6dzetF42h3camOEpwKLDDvAQqb4roxkKVQEz1XNGWECA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(31686004)(31696002)(86362001)(8676002)(36756003)(8936002)(4326008)(41300700001)(2906002)(64756008)(66556008)(66446008)(66476007)(4744005)(5660300002)(66946007)(76116006)(122000001)(38100700002)(82960400001)(71200400001)(6486002)(478600001)(316002)(38070700005)(91956017)(110136005)(6512007)(53546011)(26005)(2616005)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azR1S3JyREJUbjY3UmsyelQ4RUh5NmFFdUdZSlFlMWpuZ21DbmpxaEdsUEZm?=
 =?utf-8?B?cDBlbXBRcmFqZ3IyRCt5V1g0Uzl3TEJBKzU4ZGpjbFBiT1greFpxWllXM1VS?=
 =?utf-8?B?Z2U0UFNwVVg3RHI2STNZZVdhU25sczgrRzNLZXBuSzRnczcwSUp3S3dtM0hw?=
 =?utf-8?B?aVNuVmNtTkh2TXpGMFVVVlBMRG1XV250STFpNFBDVkoyaUhJU0NmYlh5YWwv?=
 =?utf-8?B?RVV1TGdTeno1M2RkdFhOclJTU2VpMStrUjlhVit1cVo4RWtTdzlZdFl3aVNl?=
 =?utf-8?B?d0xzc3Q1NS9vRXlZK3VmbkFRZERMMVN2VndQRjA0TjV2bDRCVFdicDZYeFNM?=
 =?utf-8?B?RXQrZmtuL010alF5bEVvVUxySkJmL2ltZ0dFRDRNYyt1VGQxRWwrOFU2OExG?=
 =?utf-8?B?MGF0akRRL09BR1dIejVqcTZnNWk0OWt5QlY4RE9RNm1FeklXbkl2S0N2NS9V?=
 =?utf-8?B?bGpSa3FTeDVsV005OE9DRFR2YmdwNEZNYkMxaXZHL2lNS3ZYQUxqNW9OU0p1?=
 =?utf-8?B?Sk0ySmVqSGJDOEkySFRMNDd5ZkZEV0s3MUJzK01GNkFoZWt4QlBGRTFOMW9U?=
 =?utf-8?B?R0FoeUxUeDVTMk56Wi9aZzIyZUNlbTRZc0pjMStVUXJuTmljOGV4UUpUTFhn?=
 =?utf-8?B?b3dZdEtFblVRNGZBRk9mUm1yOGZ3SzUya3pQSmZsQlQrOXpYdHFkM0hNQ1hq?=
 =?utf-8?B?b2xRZWpwa3dFMUN0dVY0bTdLcFhuekNLRjFzSERmNEZ3YlBGTTQvL2ZqMUt0?=
 =?utf-8?B?ZHNVTFVpUEVJWmRPb0JkTCtMNC9TVnJtcWwwbVVrZE9XWWdoWk5mcGVNUURn?=
 =?utf-8?B?RTV1UVFUb0RMeUdlY3QvMnhWajFncHUzRXBEOXV4YmFHdHRVZlYzT2FJT1p3?=
 =?utf-8?B?Yk5EbGR4cGlhakllcXI3OTlBSTkvSWx4eGM1ZFUxSDJMSUJFcTJ1MXpaVHRy?=
 =?utf-8?B?RGZxWStLeEY2SGpXbkVONDJvR2pNRmYvKzRDcERrV2JYVkk0bnYrNEVCaHlw?=
 =?utf-8?B?aUhBVUxUekJiYWVURTdXVVFEZmtNNWsxMzVDdmgwcmU3OCtZODAxUzdjYTBM?=
 =?utf-8?B?MHhSdFYrWUkrRDRCSk5RY0J3OUg4dkRPalpzZjg4Z29tbmUwakZoTFlZZDFO?=
 =?utf-8?B?c1BKTXdZTUYyeXd3QVJTQWZpcHU1c0E5YUdNdWdjdXJHdDVRam9IRUt5cHpS?=
 =?utf-8?B?bkFuVW9ZazBGR2NFM0lnMTd5MlVoNmVzV1h4UDk2eHRHemtZNXNtNmJRT3Mw?=
 =?utf-8?B?ZFkvaGsreWp3MlYxbnIyS3dRRk1aa0NDS05FVzJRSzFiVHF0SHp1WndGa1FD?=
 =?utf-8?B?a1NkaU5seExLWjdjS1MraTJWUzQycUt6WVViQm96ME41YUZJM0VHQlltUVUr?=
 =?utf-8?B?cHB5TVhCT1pFOElQTnlHdVYzakdPalVUUmYybkozNzNaRHdzd0VPZXBWOC9G?=
 =?utf-8?B?dFMvRGZDdVNjS0E2dStmQkc0NkExSXUwUkxuc1VhaWNBRm5rTWd1Ty9VMmx0?=
 =?utf-8?B?WXpDOTk4Y0crSjQ4NzltTU1rVHVRUWU1TTBSY2tYQVNxMnBVQmFkZURaQ3Ba?=
 =?utf-8?B?V1d2K0drS1hJeDBBN0toRFI3Y2prS0lYRjBEaGdVeW01bmtKYlJza0dubjBS?=
 =?utf-8?B?MkloYWIxdkRxYjRqUkxrZm5mYytwSXk2MkRUV1lqTzE1VXc2SFNNK0RORzFw?=
 =?utf-8?B?SERjRDRENHkxRHYvRllBbWpNUGQveVNCaXozK0lMVzNkWkp5ejFadW9UUUZz?=
 =?utf-8?B?amlydGRVcmFMWXl0MDJaMlZDN1ZnTjJuUUFuc25vZTBuNUVmWFlQM2NIcGZq?=
 =?utf-8?B?bUZBMkE5TGxYRjdxcHBJUGJtK3QyWFBwdjRmeFI0Zk1vQmJUWDFkbklCS0Na?=
 =?utf-8?B?OVpNcFN1dThERi9VdENrSlpDbW9iZWZBZ29BdmRQRlB2MzRLNlR0SUJjdXg2?=
 =?utf-8?B?V08zOHlQQ0VoY09GODJLT1FLMVkwZVhiWFlyVlhhYi9rek8wbDVZQ0trbW5Q?=
 =?utf-8?B?c28zSUtvWVBLRVkzcDJzTS9ISWZqL1NSeGtMUEg0WUN6ckxVT0pXSDZ2WE5r?=
 =?utf-8?B?SnFpY1JVOGZ4UVJ0dXkraXZXbitBU3FRN0I3OSszS2RnbnRJQlhKRVpWcjNk?=
 =?utf-8?B?WTMzVWsySVE3SWxTdElDREdBNmtxdmFuZFRBVlY3OGJTdWFKVHVoTlJGQTBD?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1A29E5AC2A5E140B19966C45FE87CED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q7zogEnmA65FlpeSTurby9G0wFNcpXDfoNMIzzelH1yVNuzgGm9hCVASxAuxxk8EBaddaJvIGA6JPPdnuLjy5TqxCB05rbUth39vR50ketn4ENC+p44LmolaeyIFRSN+ogkgAPoWyHY3236DO9YZS4qxMTDK1YbJSNXeImQGyU9FqctYvn6XdyEG6zxOC9GEo5yAMZviQILXdGmn92S754T+DIVyMkbzup+OkxL2tN8r90Z7G2W8+4iIcFZMyWBSWyqXeK0cxdlUgZ0Yzc/nj0fvPmBgyJzotLiztWv5FOBghaFY7usk+Fw1dj5P2p4Nj00VpwsQz5rn8wQxPmHdArO2wkCSxOp+AGpp2acuweNnDMdeXE1XnzNP1qbs7APP3i48Vaa0SzjeYoQPpMu7+21QHhnHeQT255I0dVE8jUcU7nz+6G201zesYlFD3mSEbVDhDs4TYieQmbkMNVACNJnE/myeLtDW//TFd6sZj8TE5DWqfaYdCDCLzQu77tGlGH3XsV9uFt/qT1TnSTOWzWis1t+/ZftWZw91WXYQ4+/zx1W+9Nu7yIdeEEEdGoshgf1Dg9t9ur5zLMJWUFP2jYdKgyFWAh8XOCodX5M993MQG3Ww2rUoHlUMI6j4SwKuxgGVpeKQPUhdW+jDWAI17B3dMdEviAyoHGJhugkI1e7kessYvxK1UFjXBfWb/+qG1Ye01lUpnZW0q3HFGjNdDfPvuF+Tw4qerwAUge5fkb360XSUBcXpCgofsGu9627rU+lXkuWHDiZnGepsX5ysyMxv7hXrhqTAoOJhp4/50VO21kHqeH8BM6fuEo+qkrKxFFgcTsB1EuHQ4EpC/ARudZ1+d+SqWRS34ZUNsfE9xVxX6nUGtnsyVG5ZdM02ZZyh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d37bf41-bbfa-4cb9-b6a1-08db133bac7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 12:12:02.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9pO7JO8Ozt0mk+gHCgwAr/PkYclDnZ/+ASsIpnNVavV9ySbmOINTNo6MOKFutj3cvlWDmgJqbXOO/fDqC81ztk9HMUaMEAegiJeOD9IfwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6224
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTYuMDIuMjMgMTc6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBzdWJtaXRfZXh0
ZW50X3BhZ2UgYWx3YXlzIHJldHVybnMgMC4gIENoYW5nZSBpdCB0byBhIHZvaWQgcmV0dXJuIHR5
cGUNCj4gYW5kIGFsbCB0aGUgdW5yZWFjaGFibGUgZXJyb3IgaGFuZGxpbmcgY29kZSBpbiB0aGUg
Y2FsbGVycy4NCg0KZm9yIHRoZSByZWNvcmQ6DQpkNWU0Mzc3ZDUwNTEgKCJidHJmczogc3BsaXQg
em9uZSBhcHBlbmQgYmlvcyBpbiBidHJmc19zdWJtaXRfYmlvIikNCnJlbW92ZWQgdGhlIGxhc3Qg
bm9uIDAgcmV0dXJuIG9mIHN1Ym1pdF9leHRlbnRfcGFnZSgpIHdoZW4gYWxsb2NfbmV3X2Jpbygp
DQp0dXJuZWQgaW50byBhIHZvaWQgZnVuY3Rpb24uDQoNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=
