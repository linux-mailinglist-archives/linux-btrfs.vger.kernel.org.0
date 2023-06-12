Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFF72C381
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjFLLxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjFLLxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 07:53:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B964A4C3C
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686570601; x=1718106601;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=qvN6yJ3MywoomaSxx65A2AVczHM3/sy3hrwOj7m0Oi0=;
  b=AVdWUNf+Aqf+5tr0INI8K9pXtmo8sPuNZIO6TLhJ+mLmGWqTm/FU0Dqc
   i50lOnoBQ8PeBtAfqgpnLib9JygfJP/J8UyTIfVGl3hnrOZqfdxhCA2qu
   dlnR0dsP3f2YEXabzhqLioqCf19TCzc86dpbF2qbRjzGqtEZ+M0ifxsmt
   nKmMfDG4SFzAAuOG+uF02cGuUnZMqKQbq2I5nW5TtrizRgehvOMk8eb7b
   MZlLRKT0g/l6V+1VHo/BbxWluyTph7MienXWUwzNQfyoAUkg01gxwvObR
   aOovQzE3albd3TcuEN4kVjX9to6HNKWR0Dm9wO/DsOF6Tlm+mXe4M1egQ
   g==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681142400"; 
   d="scan'208";a="235433238"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2023 19:50:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePZdDsYRtr7Cb67VXYb7fuGlWRBXM0sU8LjfycNuS58tBD5PackoxeKLRs8YFhw1xHEHzzgapRucH4zhvlTeAEA+lRPjJkQDXRhq6Q3XjA3z0ww9dpfEmk1a02Ksjb43gxMGr6sAWAaaKhfBwJqpE+B//asOl4U9nPZgpx77GfrU5X188nbFXmR1uUV+nqzBvB22AOgl6XloO3IvMJkh47OcmDvDfEJTOt0GNUbHHulWaFbCSYwEPCBFjp0cYooLIe4vI5h19D/0thPkvr5St9skAnyh9fgViFYS8GURIqi1+BepUtE23uGpWqmNoyYrkk85vOLDRitrnLVvrPPrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvN6yJ3MywoomaSxx65A2AVczHM3/sy3hrwOj7m0Oi0=;
 b=UzISfqI/kthbzdaG9XYB2xchFyti7hEpEIyTKMWmbdQFA48BjIn3iVYAd0X6AposfgQ6xtHoq10QDVL7URe9731NttA3xwJs9gnzWePuy9RI0lJhqNj52NtqqSuDA4TTCrF09oNqZXuy/nW+Oc3VApxMqIKQmoV612c+g92a3jTqVHM01ipMqqJzq91yAccdN6P+JWNcds4cwVGg8WdpNtRqJ4rQQJEPNp8zdYD3vKCmfbnBBE7ZCpso0yAV/bg4bfGxPg62Wqn0CwJxhBSEdWH+d+BWNyUu6wrrR1WLizebpp1H7C5U/gW0GZGuDxUmY48vWlzPXN9e0LOrVlYg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvN6yJ3MywoomaSxx65A2AVczHM3/sy3hrwOj7m0Oi0=;
 b=PiIUR7OtXHGqEhHOny+tXnmNly1DVWMfEKX5W7DAZ/VY+hsqi5wAs2hw9ueI8ehi5txAsjz/voBkazE263l7XDS24yNH+gGaTdaqq39xsBIAqG7tSXOzT9cu5XyN71rQfN7AviWTog+uhkcq76w6sh+AB8gxS5kdfp4fnYuVoU0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB9026.namprd04.prod.outlook.com (2603:10b6:303:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Mon, 12 Jun
 2023 11:49:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 11:49:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: do not BUG_ON() when dropping inode items from log
 root
Thread-Topic: [PATCH] btrfs: do not BUG_ON() when dropping inode items from
 log root
Thread-Index: AQHZnRxs0U478i5bNEelhMJFvZ0kma+HDc0A
Date:   Mon, 12 Jun 2023 11:49:58 +0000
Message-ID: <30de1598-f1ab-fbc1-1992-106c4bf6e03b@wdc.com>
References: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
In-Reply-To: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB9026:EE_
x-ms-office365-filtering-correlation-id: 2e70a123-b992-4e70-32e5-08db6b3b25d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auaHUcGOwLT6DuAvBAppmK3NfiY3rGdphHHpF1OY7rgc2VlbzK6TUuhVcPQ20t5+YTeIE+TMQyVL30tx81IKAR91YUxLPUNsmDaM89Q0Flvw4S6sTtd3ftMB3wTpY1YfzIKdGbTruESLF8h6i9RpYTeurF6H3wnVnUG46txqFLw7hz1cfbj0OGVUdutGNj+OLYktx0ialhDP4bx6Y6TDG7zUAGYcaKoFySW1gBLjs7/q/fpXTToxNtSfdvdpl1TFbRYcZo0dA5QUb99aGFLa7orTUEMLDgBSO6/mla4/Y9t9WabG3VNSIUH/5dlwQZW0uF3xVnouZ2/W6+DfbX1GL4A8IGor5TKis/D3ot2P17knDgIaplkznhJQVhwH7ZnLlBldlefPcznXAb7a+ItUGB2sZQEppRT9IJZAkK1GH40HMnGHYN3tFtdeMZUkaEpEUKbgy5HzE6IHaXuZWCDRq44/m+/5FUip72j6GmOo+tCsJBW3DinLxqzPNxpuux5v0OtEhVgdK2rsnU7WR+3ZFFBVYgLPeIBh96F+2AcPITTUP6xPaQMwKHoUYmnw1kvpW4e6mQHW7+KOKgE9p0zP/AWRwrs7tHo6qodphCwq6yJBshevY7HwqCHs9jC1Yg9czWYB2Muol0LOo+U8hvJH0Es8A58/r2dG87fbl5DVL2b0XvDU1CaJ6PYEr/P9dhUQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(110136005)(31686004)(478600001)(2616005)(41300700001)(5660300002)(8936002)(8676002)(316002)(76116006)(71200400001)(91956017)(6486002)(66556008)(66946007)(64756008)(66446008)(66476007)(6512007)(53546011)(6506007)(186003)(2906002)(82960400001)(558084003)(122000001)(36756003)(31696002)(86362001)(38100700002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzcvT3pCMTRiTVhUL2UrNzBKMG9RWnN1Y1dnOU1zN0E2Z21TdjlsRmRUa2lw?=
 =?utf-8?B?clJBcWNPK2hrTWNCQXFqUG5TZkNQTXdON1NzbGdqUHM1KzM1N0RDMjNxbmJq?=
 =?utf-8?B?YnFuRFREaFZzemdCbjZXNXhzVWhLZHFvZVNoUFZ0TzlWK3FBZkFSK21HVlNF?=
 =?utf-8?B?N1FMcDluUExTOFRGSk83clo4eDJPRHpYSE9lWi8xRVlnS3FIVGVFR0c2S1c2?=
 =?utf-8?B?SmhmNGpBUmROalh5cjZ6VHRFZ1VXeHlRczJ2RTl5ZG5oZlQ1aWtIN0tOWnZY?=
 =?utf-8?B?bkZLZ2lmcVYrNDVVSlFzWEhWd0hodUxURm5CdVVScnFzUWpqb2pGUWZtamVw?=
 =?utf-8?B?N1hPbmJVa3h1TG53ME5UQVM0UUFTWDFqeGJYTm1zRStic2podWlIYUNFN2RI?=
 =?utf-8?B?RUozdG9BRjRxcEUrZGs2Nms4dm1MRGljQ0lSY3BUL0N5aU42K2R1Wk1tSlZZ?=
 =?utf-8?B?ZFFScUEvejVJUmVRVGRjcmxXQTZMZXk0ZFFUVUdDMjMvTWdlS3UrRFJHemJs?=
 =?utf-8?B?dVZYYS80NC9WQWFtZ2FRSjVuVkZndlZQeVMrTWFNS01CRk5udEp2S1NDbXJN?=
 =?utf-8?B?dXd4ZHBUYzNERkhBanVuZ1cwdktLUk9xc213a1RMVG5xQ1R6V2VnUlpSK2hH?=
 =?utf-8?B?a0FrMUNnS2xLSC8vVmJiUm5TZ2RhdU5zWEpCc2V5SDN0WHEyaG9aSjlrcm1I?=
 =?utf-8?B?SmF3akgwVWV0cHlwM1MzMGtMVzFxcndCRkV5V3ZDZnFoMThDSDQ3c3MrVU9V?=
 =?utf-8?B?S0RnOGhrY01WaGJrVTIzOFExa1czdlk2SzZkZk8wTlgyUk1HNEdkNXhUMFdL?=
 =?utf-8?B?dXhkZVBrSVBMWGdHWkdmWWdIRjdSWDBQY1ptY2M5MVJJQ0JDbFVEOUJKRGds?=
 =?utf-8?B?VWVWZUVDVTVob2dnVlU3ZXV6USsvVXNZYWxHbmVDNDFCMmU0Q2NBZmc4Z2xu?=
 =?utf-8?B?UVo0TEJGZ1NabVpLYk44d1FHa2x6bGpxTDRrMFpiYjZaaTRvMlR2YllrSzZ1?=
 =?utf-8?B?NWVzUkdjaUhuMWNvLzM5Ti9FRFA3aTF3QzRTVUd2Q3NsVU1EMTltU3JUR0dM?=
 =?utf-8?B?aDc2VWdJbk9HR3Y0VWhwazhCNEJ4U25DNkRVNUdWN0N1VmRwUVMrYkZOTVRK?=
 =?utf-8?B?K0ZNcEhkaTVnNUMyQmRHTk96MmYvSDlnakMvV05hUENKK1QzVVdnWlNhbzVi?=
 =?utf-8?B?UVVGM3pOS081dUlFbjNudnM4b2c2SWNYZkR4QkhzeFp4b0cyVE12M3ZUL2Yr?=
 =?utf-8?B?L3VqSkdpTGEvOTEwMlNPRlAwZGloZnNPWTRKT1NHajZjbmdqVHVhNzJ3Mi84?=
 =?utf-8?B?Mk1HdllmcUlFMVpqOWVwcGFjQlN6blNzTWVGMmY5SFRDT3doOTZrYndXc0ht?=
 =?utf-8?B?NGdUT043OVpxOEhjT09pT2tZWUZ2ZnBBSW1pNzNiTXdITzd3QjI2djBHMFBG?=
 =?utf-8?B?RnVZSGVrTTFsbkFKZDlyZjAwOUFWNUw3ZldCSjA4RHhvYmJBeXBUdlhsb3lV?=
 =?utf-8?B?M3NKYlhXTVVvSUNxQU1VRjVHSjdvSXBuSXlZMDlCdUsxZUhYemRPODQ5R2RD?=
 =?utf-8?B?OWNvb3hQa0ZmMEo2ejhkVGRkdHVDM0NDSm1HaXJ3K2FZY0hybnNjZElZaDV3?=
 =?utf-8?B?OURyM2UwUllvZGI5MGFmNzVIcW1Nakl6dVlwVGZpeSt5K0Q5OVhJa0gyTitt?=
 =?utf-8?B?V3c1RlBQZW1scVh5SjRvR2lJbkhHV2dCZ0hvazE1L01KZDNzb2RwT0dJbjNq?=
 =?utf-8?B?UEtXNmNZZ080L0tLUWFqbGpPOHNoMDU3RzRkS3VoVkVDN2ZRKzNyZzV6aHZl?=
 =?utf-8?B?V3hIWHpEOHhOVUZIZEtRMlgzMDI0Wm0vQnp6SUFmNThSZy9SVExuS2lZVlBN?=
 =?utf-8?B?NEFuWDdsa01FYjVxakJLT0NvcHNUeGl3N3JFQTJNWDhiaTBSV0V2eTVPelR5?=
 =?utf-8?B?eFpCUFVvV2psRjFXUzc1ckpoRFNPSTg0MUJRdVJRbGRDRi9mRE1wY2FNS3p1?=
 =?utf-8?B?dmN3ZitkQjZPNWJ4K3JYa2FKbkRNVDIvMmsvM1lGYjVaYTg4ZVRmR29McXBl?=
 =?utf-8?B?WlJIMy9USWhwc28wMFZTNmpMZmtEc3dsRXN1VG5OQ05lNGwrejE5b2dSejZH?=
 =?utf-8?B?a2l6ZTVzY3pvOTYxUkVjMEtNQytlTUFzUGVSVURTUGMyV1Y1V1pia0oxUGpR?=
 =?utf-8?B?aE1aQk5GaTF5M3pxSEpEOFZESCtyN1YraXFxN1MvcjFXQmpYTEJDV2gzK0I5?=
 =?utf-8?B?RUtvalZEUEltT3pQZzU4RVdqbTh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A9FD5F43AABD4BB45C64040BB0B292@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fbu/ooBZtq4S+pn7r0AeSjttW8wVHE1xfA9hYj4xdyJDn7vBbHJtg0y7ASjZ+qfI7+NcmJ8hJAp6WOJWZqST4Io594MhFajQ3cOXkZouwZ2/GlyKsUDVx/AMPboTv3xVeNjWI9a+7CPfZn99dXoFe1c2CvMGQsVre5ifYSdo4jF0GwBr+MqjWvAZ1HOVdIRW2deuKrufBD5ZZg3d8LBbPNSX4mcFriXGmzRuZ7MTzmbDSG/QTpGJGLa99WvWM1UHJxtp/Tmq5c2EWPqbBH0pi6gyCaTDJJz0E9E1DC8mJklYVWmUI/PXsTyIMJDyWKtzFUrMm8XAA4Zkopw9+2iUzQE/CPXag3ppmeAt9mu9HPDmkWnrOHXKpYeK+LYAlzcf4k38wglGWEtfiE/q6R6dDsORLmw9owSuYojjr6RvDc0DeM5dLEXM/m/cqNLlTNsJ0+vh2DrqXpC17u75XyRnA47EIVDp8uIOBUZ+m3dP3XQSHHnINfvAITXMhmIOopUsZJTsLezytfUMP4PTapPZsGUPzCtPc3rdYrIKBppPCP483DdN1U6PlqNt5+VJdpwhUkRIjqUgo+XtzMsDVjbRBq4j/dfbj61V9X7Fc8Czp372gWzqKkWyFg1JULUVCz4H+FketgZgOgNMx0/+7DpVs6BwJGeYrr77SMobgBWE6/8/T1uTSah574QCDMd5c2HWLOmGsFGdTC5jzAu7TfnW5mtkdb2BzEmgC7NA8oY+1+O87fIoW0HgOQGnePLjXQNI7uQJJcZwqtAsyNqXywfobCZFfHElAqnwoDiBv4VB3HVe9rBDWk8GMTsI0NDziVeQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e70a123-b992-4e70-32e5-08db6b3b25d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 11:49:58.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PllllAxE+MOo07Dky7slLAv1oRRyAwyeATQHaCDmp4TJtJzKD7cFwcP86JECKimx0S5lOE7KVvccvBRKzMNTOlkLidOdBQ0Qy78qsEu5yl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB9026
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTIuMDYuMjMgMTI6NTUsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQoNCj4gLQ0KPiAt
CQlpZiAocGF0aC0+c2xvdHNbMF0gPT0gMCkNCj4gKwkJaWYgKHJldCA8IDApIHsNCj4gIAkJCWJy
ZWFrOw0KDQpTdHlsZSBuaXQsIHRoZSBlbHNlIGFmdGVyIGEgYnJlYWsgaXNuJ3QgbmVlZGVkLg0K
DQo+ICsJCX0gZWxzZSBpZiAocmV0ID4gMCkgew0KDQpBbnl3YXlzLA0KUmV2aWV3ZWQtYnk6IEpv
aGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
