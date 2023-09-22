Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483247AB267
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIVMqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIVMqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:46:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21008F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695386803; x=1726922803;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=ppE0FqkbHOrslYyfy5tOMMDQuXRV18QPPjCVf8KB6PHRcWbEYwi0tBPa
   6kGHZSxTJPqRtC1XOvdypp16ZJTCNjW2Z4PLKUMkpm/voko8/yBYwf8uV
   WkIKNpg2FkPJ5uVaXzBsfLZYRGtFDtwF23GYd66x7cBDclimZQUHIBVso
   vJ9enlwvF199iqaWIp/KbGC9QCaLUoaKJSbKyyGWDRsyWbuV6YG8KraF9
   0sIJ1wEUACULpx/Y6WQv+P4IPbYsU+Q+GjR2/D+XSgrIYnl+YtY8khjWY
   wykuT3LUt7HpIywGyQnwM/sHXTQkdqfwBUD4miYXHF0cwkXl6MaX7+sMD
   A==;
X-CSE-ConnectionGUID: 3I92n6NqRAeTvKGWrmQoHw==
X-CSE-MsgGUID: JmmbbHksRNCgUI1jOZnzzg==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="349942170"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:46:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcRl+TbX2q6VGOS+q4AKYaGOY5brH3ILU9DWg5BvYt8VzanI9JvvxorUuxBWBpggAtI8w2yqHwUp2nVbqII41xOUUkrMReEKxaJmUN0lIl2XMzZrkf9VTMXHC4HKhUO9k/EKT482kKm2bcJypfoamnEDx+HwMKhdU2FOeVDYHEnWc6GBqeLDtDyLObhA8H2jSkkWWoTuo6Ai3CvJr1rOglgsXtqA7p1RgsU/AUm51glgu8vs6xTlVm1gfbBTxN7s8ETUOd4c5d7lG61pk3JRK44Fef1l1yuMrCAZ+W7whh0m1/ZV0VU+WAEuFC/INGI9wxHHwrAtTjTNv3Vnsf7saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=BzKvGyZh30//iwKsSZ8GaFyobFr7glruvu1ETmPucUewIJpYbQtPFp9NMi8PuDw8InVc8W33Y69LqXiUjHowaGgaNan41ZguMqkFnlUMTq7yXr6kWuBSuQjy6PJP4N0cHh/vBKbDwbHn2SKV8rhWxsuDEfKHoKV7vpMhj70WhPjKZcgSfV3QhmbxLBG9xQLMrN+fS8nlCFqXVMYHdCb1HTBPYZ4qxV9gYknEIyV77BJwkNtnpoWdDDiuFoov/W1Z1dItTYFF8GKHsAlVuj5lR2HjV1nZahUqLAQvfyH9wtqZSFUajfup4/pH2sKkq6yvTwpkTFdWw10+cJPSg4/VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=mvMQm/T7A0a/CA4IyalfHpD/LvlmjO+H75uyz0iD2j5sAxtPBsYZISnmpxUWWtgRV6WD30BUvLMhlFZo8eDmnk2TrW56rUyEKm3HcpVCVNt6ZfvRI3JUZLP3JJ2OThEsy3yby1bT5jmMRkgMbXSCV+1Yb+LZ6qL8GXBLFOrprIs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV8PR04MB8934.namprd04.prod.outlook.com (2603:10b6:408:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.10; Fri, 22 Sep
 2023 12:46:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:46:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/8] btrfs: relocation: use on-stack iterator in
 build_backref_tree
Thread-Topic: [PATCH 7/8] btrfs: relocation: use on-stack iterator in
 build_backref_tree
Thread-Index: AQHZ7UXq3fn4wW9pPE2rYGFS4AQxS7Amyx4A
Date:   Fri, 22 Sep 2023 12:46:40 +0000
Message-ID: <bfc9f1ee-60c6-46cd-8f56-dbd1149ab6fd@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
In-Reply-To: <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV8PR04MB8934:EE_
x-ms-office365-filtering-correlation-id: bc5af85f-75e9-43e4-3bcc-08dbbb69f7f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kayl5SY+JMQUoB7dsLAbuczo+UldpN63H4j73Uko3KPZjF4IbKGgsFc4huZazgDP42PPUhlhiq2Gc4TfTGRpYgT8Lcys3tjDYYzz0//gUBxh66JVt9SQbWWOnr7x30J9y+iOtdsATX2Rm7zMKXLkfneUYk65OdAsU5zUu7IXZbXywqLfx2ouNwoUKsD+DjTIyjkMbuc2CcU+pJqcarjTm9FYVY4H9o3X45TvwixzdJrIbukoLm0+0v0yknC+xA/7zE7fHv1NIJlkqYFTMkxvAGv6J6ayF7y4C8001aTfdz/wxJeKR92yWxDmf/aS5spczV1eec2XjzM2RdSPjQqcKA32oErpd1ZIJ7ri4I7lxw7Jw9bJVPODYr8iTyL52DJLGAe/GGbIZvCjMnkaYAItXdT37nlkXferVFV1pid3+kiNkzorbdqGNl+fKvAQeN4QMcSGYQ4DbhPRPK7nPOiHpNzQ33PKF/rDp706ejv1FFL4jBQBrbDmAlsVuG+ogWoHUX02MVpWmaVQ9Y+823A4/87dJFVRlEJYKwcAVrldePP1fN2aAUW2+4DtbzDs7uJ3UurTURmmrAjcxMY12X5TMiZTbI3+eZ2tQgKtjJgfeSp4FujUAzHhJkBhFpJk9MUMoZ6SEoYqasYXzqG0ZzvWXLfsPrN5NzJDWpe9eRFcCkOFMJtLGiMiyfGOx06DTdoM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(1800799009)(186009)(451199024)(36756003)(38070700005)(38100700002)(71200400001)(4270600006)(66476007)(2616005)(110136005)(66556008)(26005)(66946007)(76116006)(64756008)(6486002)(478600001)(82960400001)(316002)(6512007)(6506007)(91956017)(122000001)(66446008)(558084003)(86362001)(2906002)(5660300002)(19618925003)(31696002)(41300700001)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllNMFhVYWVZT1ZWS1BIL1hUeHc3d1RSdkc4RXlPR2xEN3pFbjFuQXh6WTFO?=
 =?utf-8?B?d1l3T1FpcXhXV1NtWTVIYlc1ZUZiTkNHOGVKTDdFNVY5VXBnNkhBZTdsV0ty?=
 =?utf-8?B?ZlJ4dzc5eDk0RGZuT2hPYVRvUnJOZE81c2JrZTZIUlhET2xHU0lUSXBCZjV0?=
 =?utf-8?B?T0REK1FGT09tVm0xWm9iS1h2VkN0emViU2pNa1RybWhOZStBMFBtcUdUaXR5?=
 =?utf-8?B?L0pCdGlXVlZKZW5Xd2dZcXIyb0tQR1oyN1BwV29JdVdwMys1bWkxSW96T09S?=
 =?utf-8?B?TCs5aEhQUEV6ZHl2SHdXclRvSjZyZTljbFhvejVBVXN2czQzSS9RUk5wdVJu?=
 =?utf-8?B?bTdnTURlMFBJVmFBZktVWVJJbUlGbHkrSlFJcTlyVnlUMU0rb2pTaTljTGNS?=
 =?utf-8?B?ZzIzNmxNWmxtdHkwL2xwVEpSSVBmZ1lGZVhCcmdQQVRsYjRBSmdNN3U1ZVox?=
 =?utf-8?B?VnZjYTlNbENlVFRHeXNISmFtQ1lIbUhTVGl2WHBUZjU1SVBPK2tnK2xqTzJ6?=
 =?utf-8?B?STdqeVc2QTg3Z01mR0ZpdHRuOENkeFFDRjcyZ1lKSjVaU2c4T3ZHWFJJV3Z5?=
 =?utf-8?B?NzFVWWl3RlBkL1pQRjM2aHpJUWRQT2dQb3FWSXIvM3FJUG4vV0ZpQlNpa1lJ?=
 =?utf-8?B?SXdXV1hjNGhiRWNnUlV2YVhBeW9vVEFqdkc3ZWdQRERaUjBGb2MrakR1Z0VT?=
 =?utf-8?B?andrYWU4MGYvQm1Sd29YcklHY0lvQ0tUZVRmaDNJbU1WQ1kwblQyOUcrdlRQ?=
 =?utf-8?B?ajlTSysvWnlVdnlEU0E0ZEZvT0dYNmNlVFRkVVJpTGhZakdnZS9BMW1KbmU4?=
 =?utf-8?B?T2ZxbEpPNlJlQ24ySXladExXcE5qaUJvUGptSmo2YU9NZEM5aWNUUzlsa0VT?=
 =?utf-8?B?ZDBaVFFKb0FOZzJ3L1pid0duYTVnWEVWQ2ltTVUxMnBJa3NpaGFjMXVyS012?=
 =?utf-8?B?Qy85SFVkWFlRUmVNY0lWV2NIR1lBWU50cy82UllLNXVPWnlBY0xuTG0xRjZi?=
 =?utf-8?B?K1orM09Md3lZaHZEQWZNTDdpNTUwdkJrYnBNUkpPVHpvSkszNzU1VTRudGZl?=
 =?utf-8?B?M0xIZjNJMjlnMytwZkNSVDhmRk1qcExZUzBkT1NQWnFxbHJSdWFJYjFNUGxJ?=
 =?utf-8?B?cTBvQ3ZrOWdzcCs5UDNPZXUwUGlzekhvSzd0WUorTExwV0dPa0RkMEdlS3lU?=
 =?utf-8?B?c3ovTTVpRXdHV3FaYTkySy9KVDBHSUZ5YkNCTS9lR1ZJTGxSdHdLOVExM2Rz?=
 =?utf-8?B?UUU2TTM1V1ppZVI4bHhOcFFsUEpaVm1RZi9yMWdOVGpWZU16OWowUEM5NmU3?=
 =?utf-8?B?TkYrQzlKZUF6Y3NRVkcxOEhoK2pDOWtxemFBRlhRWU12NG9qYXZJekJFdkxT?=
 =?utf-8?B?Qk5QK21jKzU3Nk1rOFVlSWRwRzJEZXB4WkplY2dITDZCNUNRelQzTld0NGdo?=
 =?utf-8?B?Z2g3VXplN014VHNjcUgvWENpSGhjTTFoOGkxc2VidVFsNDBoa0ExVjdKa3dJ?=
 =?utf-8?B?R1o0OXo2TkxmbmZxZWtBNHE1dUYwMFFwSUZUdzNwbkJMYXJ3UEZKV2lzVUN2?=
 =?utf-8?B?bkJ1czMzUU50Qi9XcWFuRXFjWEFVck1zTHFITDFzZ1J1NjBqa2RLS2NCRFI0?=
 =?utf-8?B?Y1dCQkwrQVZIME5uSWlmaDMzckUvYWNhTGs4cFljaUFRT0Y2Mi9BUmYwYXhC?=
 =?utf-8?B?anpoUWZGK3QwZ3BSdHJSeHFVZGl4TndHL0wvWThwMkkyemw5RUFvbEdoR1dV?=
 =?utf-8?B?THhlWXl5L3hOOHpZc2p5eUdpMDUyVTlIaUxyVnVxWEtCQUNGQkx0RW9XMVpr?=
 =?utf-8?B?UEJvbkRkekhnU3lyYm5jelZMWTRoc2tlZmFvcGdFNUw2WkxOVVA3ejJ0KzJR?=
 =?utf-8?B?VmdTeDdhM25tTlZlM0VrZHhPT2pydnlYZ2FQMGcwS2RRY3ZGL1VNTnZzckVa?=
 =?utf-8?B?dFl3Y0c5UHZMK2puT3dtU2pQSVFacmZSOWhJUzNpL1VaOXFDa2hCUXBhZ3li?=
 =?utf-8?B?a1JsS1Nha3JjOWlHMm01Z1g5Tk5MZlhtcVN1U2s2R1F4aFdkRENhTnd2bVJP?=
 =?utf-8?B?S2ZsdHZibklxcDh2ZWNQSUNaV0wzZHBFYUxlTk9NREQ0VU4xU0wwd0dBaEFy?=
 =?utf-8?B?OFpzNGtZeXpYUkZmWGlCaDhPQWV2d2p6Y3l3d29lWTkwZlNDSHI2dFRQM1FC?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <826677F361BE014B9836E066E0BD2414@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gd4RkjBnXEP9SBoqlzk5c7j6f88i5yUVfNSVTEQ9wHhlm3G62/7WlXIbPzGFaQSg71KdScVCLr6sIm2kF/1XewUQ0uWqL2vMDLbTASEFSwGE2oYNg1I+vdP5kp7bDAj7t7k6ydEeAxANtxuPdZGon7C2Jml1e/8574MuA0UTJTIOcvV6WWFlgFJKhNKixa32h6wS5Q5tzKpFkwfb3XKmI5A34NMlLIOwzoWE4xY7ZXtxGZjJXxL0atCYGMJs61xYTir8ixW7bWDEMqOoFp7p4Y6Hyj4fA7m2uTglu1y2eWYCFfQ5hLd1C0jfN05G4TKbSTcjiQ/hqU37lOdhkC+leJmQCQyoyTizXDQrQQI1NEzMrOOwjzjdk04UEo6QhjXtnzK/WSA/lyy9OpkWsVe6z3XeMbyhLM23n1VLC+XuVGYTYeuBTT2h2MVounz48VrW7m0Gu1lqO4VT+l2ZKp3vNFhGfYPSDhWMWrcSF/vpNIEk1STb0BVCxrHtYhE/AngDLYYPad2bOnH2fgLsr5kzaPb3t24Dy0waZQ0jfat5X1t+qBcYrl/QYBZqNvR4S8XAh4hbCLnknH6Sqvgio5DZVNfMh3fzXdMJ4MzkhKE54a/wNW7KMLnrwiTJAU8mn3XakN9VqUsSBr6Oj6801ajT3B3pgiomy1DJApsdp161IRD8vxMJbTBZlcji0SSFKJhkMhr7Fymvfek60eUz5TJTo+jjvhx3iuhzPhBU5kng1fATabbzpr1xWFzdKSDFlk2bYyxlmQYcntc+VQk5fhE4OauuXkmrSrE7w5h7ERSC3GAaqw9er0e9DF+N9frmhgs3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5af85f-75e9-43e4-3bcc-08dbbb69f7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:46:40.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHUGtQAAMU4/M/OVoSm2chBemiiGSHmu32j90+87lABJ7TwzToc1Ix3ZmtJZMMZwDyxpJGGWovcMmceFdV/DsiSVjN7JVo+jlRlVS8Jm+kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8934
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
