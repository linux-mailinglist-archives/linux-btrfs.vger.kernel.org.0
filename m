Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B131680672
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 08:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjA3H1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 02:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3H1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 02:27:46 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5547111EA4
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 23:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675063665; x=1706599665;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=d4v8eSjrnC+c3HM0gU4zVXMfWKpW16rC9aqUjMono78=;
  b=bu7cpH/PZVFn/9Kq/qRw5Yf7VzHImFuzddEglfCZdFYWQ5aRCxdqxtmp
   DzZ0pnZODgwFoietKiab6cZ6/OZXhL3NXT1+oX1lQ9ix53+6sCAQjcZDw
   c4EPKkRXKLpDIr6Tjfsj1kO/7rbIMPT8I9gzKCbWERNOh7mDbQixIZEnP
   9MLZw7Q1/hDoorY1Jkt/66tLPVQSTbPkbFVAlURt4gOsVTqMXtMttBTtD
   5iXFw+9SdxJpqfqdux+m7LIOAaPZLlrBTLSQ7S5AibKLFevJnLKaMiuRv
   UmvoCAbQr+C8MbvF9u8huc7NrnH0aJ+VatqBL7LREDP8Vs0xonTqOq8Ej
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="334023646"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 15:27:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVzOpcv0XNQ/+K2s8spLy4LSmLbPb6pI7FYYhVN8QIsJmwwGR1MkbUDz/7HoU5pxrktLfOx6SqYzW61xPYgGMzs/2E4qcmBl3lp56yn0l/TluDHUYoY95KzPDsL29KZGRtIGpQnrIcihI5zqAtPpQAgYMspThDLaCRGoTO6LIEmuTv5JVLxNBShFmHqHmtfO7u3WU5YgPqqHXX10WTy5l5dM7eDkcMatutvY8AZC4M5JaC6jqYgIHTk6OWZNz60H2D6QoZtW+QKai7gFb5xVxlbKjBEzzBHMdE9TpIjg/Sx166AOFh7q6EFo2RKZthNNNek/sK2hy+q6Z3lyCxgU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4v8eSjrnC+c3HM0gU4zVXMfWKpW16rC9aqUjMono78=;
 b=R3afM4IjO3NURvRkcxLILpPmIovUuG7xwfFZCdsSb05gyp+CFVZstGPE3wxBzoJsoXutVmdorTWdEwH6tXqiVaVDeSde/FWs4pzXdrMBzLNki98/ySjPEGfMvt0GoaQ5wR4WS5BPLrgdrY1fCf52nTclyjV58B0iBdcV7KL4ho2OqWEEYlCuzj0jrhRCHSzC4Apo9Tg0qPQ8jLL9gdVQHWUMRA5IHkYhCZORAuf6RSNyXvbAv9NYjv4FSOV1EDufr9H9Tns0ZPuMNBuU0gPsDQOXqVvQn7RKvIQzwMOAMGM1YiaC7FlHYSUD4KUFVQ8gm7NXAMh+bG9szAzCLQgc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4v8eSjrnC+c3HM0gU4zVXMfWKpW16rC9aqUjMono78=;
 b=L3IlKgnKRlIuxkf+XN2oOU+/widjq/Lu+XNDSKBTjiQ6YTWeh+kj6eu2kiy3KyhUh/HngqkebkVJg2ZTsz9CtHC1hHg41JmDFLZ68kgbDPLm9O9asjCBi5udsTSuSVClwzhIAeUcT/n75Kmd2beZakx6LBg+w0iZlnLN9++pbLM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5193.namprd04.prod.outlook.com (2603:10b6:5:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 07:27:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 07:27:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Thread-Topic: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Thread-Index: AQHZMvHYu17JpynIQUaO8+vhkavEf662kskA
Date:   Mon, 30 Jan 2023 07:27:42 +0000
Message-ID: <e776fcff-3c57-1b77-9c83-bacc0e473f5c@wdc.com>
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
In-Reply-To: <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5193:EE_
x-ms-office365-filtering-correlation-id: 08ddd4fb-299a-42ca-04a9-08db029379ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xawW/Rgl3lhz/42GlfAWcmss35Ueys4bkJg/Q/MEI3rkIOZL1VGBeh8MBVBP/HxuDK+0KsjKa3+HWxyXVfZagUir91ZsO4FaCaOb9Ym6fh/0Amhp7jsJK33dD+iSoFMnHXY2dATUIyLcKpAEswYmq0eWBvVZ/P5trmlVLW28fc4OmzAq8cCbEUAyDacIrNY7xBHQqkxz+tBV2rWQvJSOUfWTI6RamyS36JjoWetfivJzqjUc5u8yRhUeyhxjAm/zHQ0xkQpSJCZsqgHsQw2wWljWAV+IEaCCHeogLocujNXjBXAt0FMjzZ4I0FCXESzGpNJ76ScqiTwiLl8cHzv598219nngIDGB0SpGzqV64egkrjrkhmBGbeo1Mp3eG0lvGUz55IRHG1/54ubAWv1kqpUj3m3KoAzFKIl7Zzwch/8rdv2wZsaHehX93zZkMUIk+Z4Uem6Z1RooigIsjCmFWvWe1QKXcglmviAZumJQaAzF+rvmDIlyHD7+fbTOsBetnNH0w9+VT7Qc8TXa5XcmnPgV6Lb7l2izHeVodAJess52AGZbr+pQnnFdWkifOhYzOcNZIm1fGFqIZ1JFDELkJwJqkmOkdWx7ct5r1K8cROEu2LAUAdvQR0lBegD6aVmIGsUQ3JRkbamIlvbKQs3xgJK85m4lRBsv2oZJsd2tuFt/+j09FfZZVRkT8oVv0veFkKXXMsDJctM+Bl0FUWCZ3YvN2zF9aJfx9MHMZi+iLXZK0Eg63OPFbJsURL9NfeZZySSwTrTu/b+Xhecf+7Iqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199018)(91956017)(76116006)(31686004)(41300700001)(8676002)(66556008)(66476007)(66446008)(64756008)(66946007)(8936002)(110136005)(316002)(6486002)(5660300002)(4744005)(71200400001)(36756003)(2906002)(6512007)(26005)(186003)(478600001)(53546011)(6506007)(86362001)(31696002)(2616005)(38070700005)(82960400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkRHenF2dWJFWWV5TkNLR0dnM0J1dmhFYTVHM251UzZTNVhFUEtTK21uOTRr?=
 =?utf-8?B?aC81RllTUmM3UGVIYzNwRXl3L2tBZjlwUmZVVWJQRG9uR3JJY0R5MjVMMmds?=
 =?utf-8?B?NnEvWTJwMXgrMkMvU1JLNjFyY3h1M1pRWi9GMWtxMEhIZklTZng5czRrUGdW?=
 =?utf-8?B?UjdwVGljaDQ5ZGUwNFZqZndOR0tzNkMwNk50SGcwMVcwTWdzdWtKRXhsMlVw?=
 =?utf-8?B?NzhSZit4b3lVN0pnVnBVSVp5ckVOeDI5V2lmUUxuL1QrTzNoRjJNMEFZMnRH?=
 =?utf-8?B?cWdveDFzeDNWZ3VSc1dENE5xbEVxbStsYlllNTVOVUY5TXlzODN6YjM3ZlZD?=
 =?utf-8?B?QTY1YWUwdlFiVHpaRW96NUlNSmlsZyt2WnNtR1d1cUc5T1V5YSt6ZlJQQUV4?=
 =?utf-8?B?SlB6U2I0VktkZUhiWWdTL09pQ2VCam9aYlQrRWZJZkdoWkdRNXlqVVFCeEtr?=
 =?utf-8?B?SlQwbmUrU2l2WExIeHdPdHRtTzNyTTZGcFpTUDV6eFpwVzJkcVBHWmY4TDF1?=
 =?utf-8?B?OG41aTlhOEpXN2ZaNUovL2N1T0VoYnNlR1NkTnJYNWlyTFpRdjFMb0RQVjBH?=
 =?utf-8?B?K05pbC8ySzdEQWRCT0VJSHZLTUhOd3pEK01acUFjbmMybGFqY0JnZG02NHJv?=
 =?utf-8?B?VG9HaW8yUjV6YkZycG5jTWJGSW56QTEwVURqS1BzMThMTVFEc25RVGdSemdW?=
 =?utf-8?B?Q3hCaFZyaWhMcUppbW5qdGZkbHNlL2xWOE53WnNWL2xFV1lDRUVRNTduUFdX?=
 =?utf-8?B?UjNEUUlsWUJSUjdKdk8wV28vUmowM1hySUkzaFNhclVaMExBRmExUjFYSUJl?=
 =?utf-8?B?WUg3M0hld2p5R1BzMS82dGk1UXJENjFpcks2eHp6ODJFcG1kSk5GS0MxWFFn?=
 =?utf-8?B?TjhUWWVZYWxXeXF2ZzRXN1IzdlIxZytNc0tOeTM4LzRsQmdvSXBLazd6R1FQ?=
 =?utf-8?B?RzZyOVlNS0lrUURkSjVNQWh4ZFRJU0h4Y0JuV2Jia2FqTGNwWk9tK3l2di9B?=
 =?utf-8?B?SHhzcmtaN0NXRVU5N3lFdzh3ZnRQRTdwbDhCbnEvZXkrVS8rc3lOeHRtMHlY?=
 =?utf-8?B?K3RwbkszZTVEcFZOZGpBR0dDQVlaRTA3T3ZrUEsrdEYrZXNzbmpKK2g5Y2FR?=
 =?utf-8?B?c1NsSE1ibzN1VXc0QUMvc0UySk45dHdaT2l2aU9VL1pjcmo5MmVKSDJ6WitE?=
 =?utf-8?B?NVVtUExQYkVIZllZVS9xTUcwZjdrV25Xc1duYitsY3I3L29iR1Qwa1B2UDhw?=
 =?utf-8?B?NEFtRFFwNUlxVTdleER6QmVJWjYzTmIvV2h4d1NOWGpsVnV5THhiMEV5MzFJ?=
 =?utf-8?B?R1UxSC92bjhlRFErZ0JaVGlqWTQyZUlRQy9zbERqd09oOWtoMXcwU1VzaUpJ?=
 =?utf-8?B?RmdzSU1Mc0NzK3A1eVFVUXRBaW1Fejg2ZXBva3FzSGJscjJUbHpxS05IOEIw?=
 =?utf-8?B?UWtYVmNnUmRBRHlLaUZXUWl3L1hYR2IxNnlMRmNhQ2pwVlY0NkNnVjVhcVNi?=
 =?utf-8?B?SUJpN1d5S3VPQXNmc2lvSXRveXo3N2VXSmMwMSswUFpRZzBYdTV4VnM1UGYy?=
 =?utf-8?B?ZGZiTW1PU3ZiMlBrS0hmWVFXMFpnS1lFcHNyZE8yKy93T3FXeGZzZDFzbGR2?=
 =?utf-8?B?SjBHMWducG5MMDVIU0QwMlcyVXNuNmxPNG0wcE12QnZNbGNSUUxYbXNldXpK?=
 =?utf-8?B?K0hFOUh0MGpwNnhqaGhuRTJCZFVuVEpMSWxRWHlISVMxZlovbnpSaFZyWHF2?=
 =?utf-8?B?UStrSU55eGk5eG9tUlhvRUR3dUtsZXg1b2FrSlhJWllhU3NLb2VTUWdqUFpa?=
 =?utf-8?B?NnE1eXIycllvZk1NWkdGaE9vRHpzUVp3NlBFbEl4dTFvSjRJK25RaERGN0k2?=
 =?utf-8?B?WEMzZE90ZG9NdE4zeGRvNmQ0V29uWE1aZXR4d0p4czM5Q0RpeUorWVFUbkR0?=
 =?utf-8?B?Z0QzL2h2dGRTZXpPaHBCZEJMUm9CYnZQOHpXOTUzQXM3VGpzNHpIR0syeldl?=
 =?utf-8?B?RXJLbkc5VUdiOU92ME9rYWFTb1VUTjFVVjhORXpiVDhOOE45REoxQ0JZN3lI?=
 =?utf-8?B?a3IyUGdacDNQSEZLc1dRTzRZNHR1MVlEbHk0ZGtWeEljUWNFZnBQbDN5RHYx?=
 =?utf-8?B?SUtoUlBwL2xLL0NGd2VyWng3TXFEcGZvVWhveGFscWQ3Z3RmbU5Fb21lSjlS?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <906E9ADC1AFB864DA359CD820D7B69A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKfz3ny05AGJqmIeQdVnRkNHs8bMWmBoN3AfZGxejUChsviIb+1NWCCZxFbYlsvzvkN1838K+GpgyPXbokycBMkUv7G74JIbV/GpuUHGgsJSnXvrj2SPJR+ClwHdI0PWeD5Fb5CMRngsRCG8wYEGKjVjXigGq/uxp4hkfFl8NezM3B9Cpl6l653y6tcGMR17vEJHxucvJVpLqzNGzR8Ly9LeQnfcLaE7pfqBK0W7TLXo9ou3YLqwwDgMC145XWN0NlbaGvBIsxVVlGf76j8HOegVhq7Z26oObtdkaRTy2wt5ghAlBdYvlFUiEVc1dWpirr9aJRo55V20P8UX/413ZX2k87Ah0LIUYBtes7NLPbvfBfJlrMSoAYbpmL4ZwsVi/AzcuaGRyhBcKzyZPSOxGqmTnXLzA1tVysngfmTyEV3VK8rE99N2ucbdA4OOS9TRzlbkRvZgybXxvQiYdXEwArXnOrv/PPcStBTYjFGf9TVzJy+4Vqy8/8AXp2UKzu550Yeoj5NGATACJEdFDvAT4oHUZq1qzM+rAtX9ZoS/cAKGlx5ljZyuz5XD05k09d2Pe+kdMuF3KmLDKSVBWpm3dl+s/WHNBmlOW1WIRX0BatThA9GxM2Wgkh+qKgWoJZhvMaIOm4qmJ7ZxvZKSUTvtc9Gk136xYKOHTGzuQbMt+dwQblj/JIpgJGBXKKggnO3cZf2AZ8cIxboXY5OGZEH9mnK9UnKofZUHpkx1FRrR/hKmToW/IbbF6rhxLepZrXhFHnSvOQKM2k/cpUoLVF333GPjFV6s+z/GxpfVadPAc3B8YqGgB/kj0lBJWUUYID1N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ddd4fb-299a-42ca-04a9-08db029379ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 07:27:42.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYFzCK65wlIe7eZnQivO39ZwSD9xFqXDK50wVxbQamcjgKt+7PN6vIEgcYVwfNWjW1FfzuVbK2xZrQZmUVMwM9/gp/wdc2u7o2f0o+X/M7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5193
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjguMDEuMjMgMDk6MjMsIFF1IFdlbnJ1byB3cm90ZToNCj4gQEAgLTU4ODgsMTMgKzU4ODgs
MjIgQEAgc3RhdGljIHN0cnVjdCBidHJmc19pb19jb250ZXh0ICphbGxvY19idHJmc19pb19jb250
ZXh0KHN0cnVjdCBidHJmc19mc19pbmZvICpmc18NCj4gIAkJCQkJCSAgICAgICBpbnQgdG90YWxf
c3RyaXBlcywNCj4gIAkJCQkJCSAgICAgICBpbnQgcmVhbF9zdHJpcGVzKQ0KPiAgew0KPiAtCXN0
cnVjdCBidHJmc19pb19jb250ZXh0ICpiaW9jID0ga3phbGxvYygNCj4gKwlzdHJ1Y3QgYnRyZnNf
aW9fY29udGV4dCAqYmlvYzsNCj4gKw0KPiArCS8qDQo+ICsJICogV2Ugc2hvdWxkIGhhdmUgdmFs
aWQgbnVtYmVyIG9mIHN0cmlwZXMsIGxhcmdlciB0aGFuIFUxNl9NQVgoNjU1MzUpDQo+ICsJICog
aW5kaWNhdGVzIHNvbWV0aGluZyB0b3RhbGx5IHdyb25nLCBhcyBvdXIgb24tZGlzayBmb3JtYXQg
aXMgb25seQ0KPiArCSAqIGF0IHUxNi4NCj4gKwkgKi8NCj4gKwlBU1NFUlQodG90YWxfc3RyaXBl
cyA8IFUxNl9NQVggJiYgdG90YWxfc3RyaXBlcyA+IDApOw0KDQpTaG91bGRuJ3Qgd2UgYmV0dGVy
IGNoYW5nZSAnaW50IHRvdGFsX3N0cmlwZXMnIGFuZCAnaW50IHJlYWxfc3RyaXBlcycgdG8gdTE2
Pw0KVGhhdCdsbCBpbXBseSBhYm92ZSBBU1NFUlQoKQ0K
