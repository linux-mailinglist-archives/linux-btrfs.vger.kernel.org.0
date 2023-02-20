Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B269C9FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBTLjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 06:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBTLjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 06:39:21 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904CD1027A
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 03:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676893160; x=1708429160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=emw5gzQMGV0eceJpMq5wDadAK/WtYgHx+Hck34/rUBmetRmfJn384Jny
   eyUkueydLTo2Z0d0OWDWz/0rHomMFi3P8zadC8yTCPayFHg2XXybLbckZ
   vV9JoJYYx6R/yBjcpoIWr9+R/r7wy7hxKW2nqOzMWXEdvAf3cLKs3n5NH
   WqA+dbgQrGEcFsfbck4UN9+KtlYR96pgln+9sn1ULF4FOLngUMFCJjSdx
   LcUHcv0Q791IHIFIp3KH8Pdc/0OQncnKuXydnnEB0Z50CPosTfKWsg4iC
   lD93FjUESDz3sInXMwOEjqg5WhfkAhdKm1bIEAHQW7zcgjPlgqQdrGhbT
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="222019122"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 19:39:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+K1q0svL5ilaoGID7LkPbR53mDAdwhXQgJedztM6XcT3QBNBveWSxb2aAEg8Wv7KBsyXxf5e+UnnqgXvxA+dhAy0RBWSgesKzDmCMF4c9Q9dyZKElrsQas3Ymef9qX5IZEkheoj4DRxorDeiDNrgzqa6oEuWFy3xshkrvDmhsiSBAnHIHz7GNBW2Uk7cCS8vfWxyvv+aO1heFCsmmLX7ZGKbUo89PD/DeVjdKe+ICBf6UlLEOB3OT2e7F7PC8JiYqUGyEdguz2F4Xga5GjcCz0vaLRusJKO8iuwZlPQEG0zj+xLv8COgOlz/bmVn+MHPhYQdl8V83Sr0GiaZt4ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=N3PBsAZvFBeWN/Dr9+IFHUgWbpkC9e1fKzc0s6DADPudIj8KS1dwI6jrbnDOwqeIWJkqEl8mLxB6TKJjPYMLL6h2l/OIKFEAyi/xTDPrK/AMJ7HolPaiecPqhQZxE4RkK5f3OETFvqxEsLCMoIKgVPmc11W1bBt242ravzEsR9Q/eV+CShvUJ15WPNhtcEgkuViTB4tw3mcJavEQKWnQlFidITCfwIdeX1vDSZcw58kUUz36148w3qDzX0Gc2d0SdQAdp/RC5Y3tultsDSco8cxujh3+HmiNmYeqSXtiabfFRbBIBWopkoDm+edZU9YV9hGq8Opjjsdzq64K0rUH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bKbYu0k+RxE18tJoxjrtisjKv++ud3ppbZATifEEYSCCUQ6+jODH1R7qNIJppT1DnTU9Vz78YV7afPgImR/Nykakhkk21b1fWqXxTJscVRKXmFdCYygb6N4Vp0arU7UjhXM4qJg0q1yvGhGhTl+VExEj8Q0UH9nz6rR4252KonM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB5341.namprd04.prod.outlook.com (2603:10b6:805:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 11:39:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 11:39:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs: rename the this_bio_flag variable in
 btrfs_do_readpage
Thread-Topic: [PATCH 07/12] btrfs: rename the this_bio_flag variable in
 btrfs_do_readpage
Thread-Index: AQHZQiSrHQBG4Ww8pk6MYaR+LjJrFa7Xu6IA
Date:   Mon, 20 Feb 2023 11:39:17 +0000
Message-ID: <b5031b8b-e064-6662-27c2-71d7863afef9@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-8-hch@lst.de>
In-Reply-To: <20230216163437.2370948-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB5341:EE_
x-ms-office365-filtering-correlation-id: 338d4d35-dbcd-4efd-99a1-08db1337194c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHZLVuS7g4hbq85+X0WIbF6e9BQ+uljUML34/vOagUtr/o7LCU0QukRiJ41Jdc86UBOc8LtUZDWOjhQ4OcTu8EfQc77gc3JiD/+NRoR54BvIbQiSZbQj+gBtYEiDHiny6UtI8KgnjfSfG7Cs8ISWonCuQ8DCCWo4DBS4yjFyJ12B9ZyrY3c8qL0zLTwMc1HrGPKJBHuNDkgN777Biu2e633rnWUOKTe31dPMC1TORHYoae6PW4aOJnTslo9754zNKQFRD6E16ne9hJAm/dNRFldaKakOGUf8DJUJI7hRFqzJgSbBWQ8rowO/dP6nnmZBzOmlVLoTyLO0wpdLJWJ2kz3kKVGNupipT/6llOZbJ8RpbvLl2kOL4tBKHdW8SKdH73s7TZrZudIVfqWCLqBHztTBu+5yji+ouojIIt8B6m1iPEtcxFXLV2LFsd/h0VaHxsVDMyVrdoqyy/1h4Sc7SK72lxeQGovH63IxInMvCFfOasv6wY7Wvvg/FXzSDIX71qnQK8OD4CFB5Sz9uSA5N38QQaFJ/WoZaijQlTGSVZF0NQhOIQcOVwD2XBd6o4mTPMlL09w7ZnZ8nxWqRXjizEnu0Dfb8d4GsANC/9sabSdwGKrGtP0K3tAHb2mx283pAFeu9xF9SMEX5V9MxJPHOhIHVtkmZnWTrzzxSa+j77YpPpb/4L9bZBue5q+B4oB9g64glJlyOAOhJSJhP5CfIiKBJxI9wT74Y+4O+DunUcURs2DEHc0clAX+1B+lkISc3bZ3gUzUTXPNKipN6GtlCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(31686004)(36756003)(38100700002)(31696002)(8936002)(5660300002)(122000001)(86362001)(558084003)(38070700005)(2906002)(82960400001)(6486002)(478600001)(2616005)(6506007)(19618925003)(8676002)(110136005)(4326008)(66476007)(91956017)(66446008)(71200400001)(76116006)(66556008)(6512007)(26005)(66946007)(64756008)(4270600006)(186003)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTgzU2hSblY3K3U1dXdybEFJby94Z1JNa3hrbGIwVStsT3ZwN1dNbXhERGR6?=
 =?utf-8?B?TzBGQWplaVdDSnMwcDlOTmdEQzJZTC90MnBPbjZzZ0tzaVpWUkNLa3IyUjZS?=
 =?utf-8?B?amo5dFF3WGo5Zy9mQnIvVEQ1K2NTckRkQ2lXL3dBQjM2ZVc1Uk5IUFZJS1ph?=
 =?utf-8?B?R0xoS0paK1RVYmdnVzdYVDRzSzcrSFhPa0VIeDFvRFRFd0JTU0xwR1hZVFBP?=
 =?utf-8?B?Qk1VakpEbWZqTjlidjQrYStaSUVxa2ZDdHloNFFzLzRnL01YVUJOOTFQeEZx?=
 =?utf-8?B?TlZPZzI5SVJDY1lEVS92QjNUSHFQYlJJVmxmYktwME90bWRQclQ4VG90YlhW?=
 =?utf-8?B?LzdaMUZ3NkJiaGxIOFdtSzJvbHdrTzBFeHhhMTF2LzZIcThlck9ZSVpLUHlQ?=
 =?utf-8?B?eXhLOGpUbm9BSFZueGF0eFFzZ3ZUTDhBd2xMdkhPMGxPaWRlNzlnSVU0b1lm?=
 =?utf-8?B?d3hGMGsrdUs2QkZOT0g2Uy9DY1FROThvM0lYYmZzTmlvYnRpWEVtYVVranpB?=
 =?utf-8?B?QXhhMElPOFR0MjdtY3ExNVN2WGVtNm9vUHRrMWxGbTBsZEJ5aCs1V1JhZFVl?=
 =?utf-8?B?cFkxR2FCL2xUcFhiRVJraU5ad0hRbitRQk16RVoxK3RZd1hkVEdPenFPQWw0?=
 =?utf-8?B?QkZON3hnbVFueVEzaStXUjk1YzRwa1V5RkF1Ti9CWUNoUG9OWWU0T3R4TWFu?=
 =?utf-8?B?V0hkVU4wamJrQ09ySWd0eXFpa0FFazNsd3BJVnRBR1lYemJPV1pHaEwxWGJV?=
 =?utf-8?B?c3h4V1dCZ0F4d0tEWVZKMFRKWDNRdW12ZzZFOHBwQTcvMWxGT3FLQ1kxZUxa?=
 =?utf-8?B?MW9zVmJqd042KzdBWHg5ekxmMndBMWdDd29RQjNKSXpiaVk0b0EvZFNZQmk2?=
 =?utf-8?B?TXBLRE4wTElrMG1CRjJ4SENaM3EraStxNlBmVWVFZEMvelJQUWxuTEhGTkQv?=
 =?utf-8?B?YmVjL3VEZTQrOEV3WXd0T3o3WnMxc2x4YjBkaEwwUm9udjdOYlluaWRzL2k5?=
 =?utf-8?B?endoY05uY1F3VGxmaGJHbVZMOHQ0SUx1UmNuNU5jek5Ga2VxWlhIL285alZa?=
 =?utf-8?B?Wm0wcDdjdElSVUVERzE5YjhsMVRpZW9LRHgyZTdmUlFJelpmRWJaSU02WFo1?=
 =?utf-8?B?NU53bDByakpPS0w3VDAvMGc2SHlodUhjVkdnVGMyV1lNbEc3TlZ1bWpWUThx?=
 =?utf-8?B?SmJCU0NOYWtnRU12Rmc3YmJMaGdXdDdqbFF4bU0xU0NmaW5lblN5NFhydnFC?=
 =?utf-8?B?RkhvSCtuZEdubkp1UHRQSlJTSHRPRjB2L29PaFhCMk1oRmtpWDVwbXlsTHRq?=
 =?utf-8?B?V1M3Zy9vRkZ4K1ZxbGVnNWlmZ1JuMjMwYmpUNER0VlBhbEJ1emJBMkE5V1NO?=
 =?utf-8?B?RWlQd2NpRmVNMUFSNm9tdFpWdVZJQmJEMGI1YUlUUHZ6b1ExK1R4OTc0SG9j?=
 =?utf-8?B?ZUVIMU5EYW80L0ZRcUtONW9rK0FVUHdTSEgvc0VtcCsrcVNzVk9SN3hoZkFv?=
 =?utf-8?B?RUl5UU1EeUYzcFFqdEJWKzNTZHZMcnRuaktYa1JOTk1IcVpaNU0zZHVwcDBv?=
 =?utf-8?B?V0MyaXh0QXhRY21URE5pQ2ZpZ3QzZDVkZmxvQlNoZ1BQU2hwOGVlMWJKVmJE?=
 =?utf-8?B?MGJjeURnRVRCcDY2R25mZWV3RzRrVTBuNkhRY2YrbXMzV094WFdoMzhrZW5h?=
 =?utf-8?B?MW95QXlZQWVvRFlQZVNwMTF2ZkpsbDJnZUlvc0RRZVdjbVE0eWFvODEyeVFv?=
 =?utf-8?B?Z3JrTWxPSW92Ry9BZ1BEbFUzZ2dxNU90YnhxYTVmRkt3Z3BvRlVnMnc2Z2t1?=
 =?utf-8?B?MUdWRzVMYUVKMjh6TXJ2aUVrczdJaVdYeFE2TWF0S1d2blh0MXg5eGVxT0JD?=
 =?utf-8?B?UkN2OFA2RFZobHRVbkxjOFRoM2hhZkppckZRVFJHeWFGZnM0dEpHbTVDaUN4?=
 =?utf-8?B?dWE5aGFJR3IyUDlobmlUZjJzNkZXNS90Qkl1QTIvUU5LRGZ4b2FydEs1Y1FF?=
 =?utf-8?B?bDR3aTJuR2srVG81dm9pZFpsTVcrNm50K0dxQk1EL0pkWkZhSjdqS3diSUFr?=
 =?utf-8?B?TDlSNkRVS29uVFBzMlVJREl6NVhRWlB1emVNSlVLM0I0NUJ2TXBSdGpKWi9P?=
 =?utf-8?B?TFNOM28vbW9vYmhBay9HSnNWMjRJczlTUldmZ3hHb1hYZGNoRWIxZ1BUSUFP?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21C75CBE4A155943B3ADB719B3C359A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kxb4wgx1cZi28Hft8kUwsntMXe2T2lxTlOIgPxFriTm77/xgQAUHJ8dOpC/yDlDi6MGkcPfrq9WDnizFoG2GaRiCNe6qTo3+DHhAHqYX1cC2aBmA7fXEgMEKdKQluB1TTuXzTWuPHfA0Fb5I5cbDbNy76bgDFfjPFwZN6+INaDPu0ZQs7qQeeG4shk07NWTGfuXxvc8gGUx2ZTNSZMgD8QAlyDHM+NLKkJ0mHM8sVhB21r2lA9LNFFCFwkldGuD8lEs90P8MoshCMqQkGk6Dm9vovduEqlnjW8l0O0pAggE2h97gltB+d/8V34Dm4R4UFy6UkJ/steewUt0vxRER8/JdgAnpJZoF9lgRHtasgERdR1rP/c7AVY4UG895gZrQheq0TgwF/NBo2ac3ZHFzM/SbjiBVWzhzICsube7BbOXPFhMXjL4CVytvKNpbflMwXXk+5hLFDGNNa2ym49usZ5mj9M38NeCC4QCDQqbXgMr05cWH/en8HcUX7vScZ9p+9IZSazt0zuZ0WGBbkrxrryCylT+l9R4AawrndM/4a2HBd2GQEEcl3CzI1J07X58oOZ+WRci98vZI30X2hVPwoFVXmSneabv9tog0XsxHHEpPFV8UvfevobA+vjI5R6MGy7ZlCpfsd/2vCUYAq6YENxA7FjwALYf2HyjSl4keD1yQir4JmL7trCWm2RO4iqu31bhSqcvmsquoYO6IidJQ72rc3j579Aue07iCLKphvb67m4IdO6TRQHgpmiMSrZMyFjgaMGpRs7ZvAjIUsfttnucY+g4NEYjIypepoa+Jq8Tvvg/gk9GUhYZPyQ9xKKrjrDYIaLxzcIJNZz7K8/08UO8mU+36ezKp9ZWS4YgLM4g0LTZCZCZrB6nufqdfeJ8O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338d4d35-dbcd-4efd-99a1-08db1337194c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 11:39:17.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcg9FfIccTvdTsTaWnVSSZHKaip2bcgS/9YPVhuhLNULs2GCK+oOmspqLLA4OpKvtQQLO+Zymhb0U58n1mY8JYpv1pcX+6F4ESjkPUepvfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5341
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
