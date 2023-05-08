Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4A6FBB7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEHXpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEHXpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:45:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3603AB2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683589537; x=1715125537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HM328RO1IzCsSkRE5usUAlnwzqsp09nGjK8uIBEjA5bSfjj9x6oG4NlD
   PgxWL1TVXV9btBkhX/R9iqcmbnybEp4KqqXAhM4vxBQQBdlfrHOGw0D7r
   6joO4sCFdzUkc1aajAaNvVqx3Fz/Fhb7oIqT4C3v4yb7GsyPwAhDjpBi+
   vIjdx3jYD93GRuOMbff9QAAEKK2sGMLhlm0X2ZPoWXN2ZOQsC89Bpx1A6
   DM9XrOJuabrX2k/HvHBbPiqsS/rHiLTJz787WfcL499DlrKhlOM+BH/Ks
   unXbbIB/f9nUVdGyPrZLGnmniggc0oevKtzND9Wci61d1VXKC7RpA3d8e
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="334636416"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 07:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciLHR2CdrRFbxCVXaWtY+7tUYl1tmCOKWGIpG805QRkiCKTdFB0jjv25MNSCZRfnNLWMgW+K611BA4KyE4kZ3Hbx+4r5Nol8R3qsNDX7b9NZsp73lLezZ7bU/ntPaFHIQVaT6f2o+XxsPZTj5dOSWIAw/c11loH4/FkFe24/av2yonsr8Amsjz18mHQr4A6h5LzTmblHKYCTfHhIDnvSPgmygDIqtcEni4DWZE4Q82/OGNBD3NywRGGlZWYhkoOXnnL8p6AJGV1esbBjdjEs47jTyuKkxeoNEzUH65FppIfDOFxessR2u94H2hwTa+4ThhU+3lj0vsRPhulA0XGGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oJJTGOYGTVnRkCykot6GZM+IjVXpO4yl+0fczmOKmcSrma895IUf7qSGB7bs1/QnXksHZ18j3HCx1cB4hQAtqWLZ48ELqGpwzHNECy3ZfRc3yST6sfCxB1vZThpu5l1UixKeNwei1GUXemDAEZ/TD7POTZ+1XVAZQMnOzQOkOnHqRaXJkrFmLrm5DhwyLKOyd7TKUOfsaINR3mU5pMPM1z18YrNFZNCyTYKhKcgNSbBvxSuM17Xk8HSJtH9WQKa4GVhkDKiQAa/tRNNv36rXJi3uuaViE+PydO2iNxsDIZlRKAmPSF2pU5uA45GHuop27bJX5uizv+5COcN+dV0Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=drKuflDH+hwU6TQKxI1FMSgGh2UihtR7yDzqKV+YdyUtzWdJbzx6g2Nehtw5bZNkyTtvyHqYrCT2FngHdk/wdeOYi4JgWI7IrnaUDE+jtRn5NZJ+FXibqEIavQoP206hgbJYDWyARtQ9JrkNWGqmyn4AMFHAwk6//dOZM/7Lgk8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8770.namprd04.prod.outlook.com (2603:10b6:806:2f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Mon, 8 May
 2023 23:45:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 23:45:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/21] btrfs: reorder btrfs_extract_ordered_extent
Thread-Topic: [PATCH 07/21] btrfs: reorder btrfs_extract_ordered_extent
Thread-Index: AQHZgcdwa5TzWVWiL0GA5knzIR3O2K9RCs4A
Date:   Mon, 8 May 2023 23:45:34 +0000
Message-ID: <2cb76f5e-d621-381c-e1df-94b335fa63c9@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-8-hch@lst.de>
In-Reply-To: <20230508160843.133013-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8770:EE_
x-ms-office365-filtering-correlation-id: 57e44921-b4d6-4bc3-1843-08db501e5150
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: frn2MfbVXSF4xOrzB/tPgKonP5eX8KslwVdhieLt4r+oWuH30pXv7YTJmiOCeW7BpU3aQs/fNlBw1e6yrv2q68YNxGzmyB/GNIhnbNuJUpr8s7YPV+1U/A5UcxCJlizHh39SZnNdk+fdN2PZXJMhK24ziXUdvBM9ablpSxlzTyDniF1u0YYGEDEiZNuygquQpSQap1uS9E4p6lQ0lBojbhSZO9glB51jZ8VoWXe0pf8QrF6hEMgliwewocz80Lvpk/4w4T4ouYJzZ7bih3cidKlDLTqHrW09WTBO0uXA8DCNUV0JSxyI5u4kdSKU4kuU680bzTIba9LfomF1f4QDl/+qs8Vv12JNfRZbz+9x2iac3YodURwOpZhuXgiWJQLhlIasmblEKITrOoRPMmV8PpRd1MSqfOQ8HYUFasrfkXqJfStZI/oGCvPY76mio2mVGHXDRSEWJ/y4gM7947mB/c01c/3VX+cnoWsc12QXVdjhTHyB737jNwx3w9M02q1M96WfZkU7fYVbyIlN6dpJjblmdzDJfQV06oWRyOksPHrsB8jBnxW3N3Y0Yy1HeDwGRTTMkkSv+M0+t8si+ucwiTWngrD5zCNG+qYlDvW7SD+WxyBXKJQTkmGE1kOPuNhFQw2xNZNJOcIdO6jJTa7sNjRDZIqQpVySuq8ltIQjYEUw9ZPFF41iguIgJGS1Xpey
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(478600001)(186003)(6486002)(4270600006)(558084003)(71200400001)(19618925003)(110136005)(38070700005)(122000001)(26005)(6512007)(6506007)(86362001)(82960400001)(31696002)(2906002)(36756003)(38100700002)(4326008)(31686004)(41300700001)(5660300002)(2616005)(8936002)(8676002)(316002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJvb3h2WWdyc1FEbERrcUU1M0U4UnNQSEpQRjZxdnl2akRFNFc0WkxyY0lh?=
 =?utf-8?B?TTVkcmZXdUhobDF0SlE1QmdwWkJ2ZFl5eEsvbkQ2ZkVicGJXc2ovcTFjU3dj?=
 =?utf-8?B?QWptd09HaDZaTDdnQk5iRWVNT2d5UmpVVjVkZGRuVmNuQ2JYRnUxTEcvTCtS?=
 =?utf-8?B?VHBLWHlKZmE5Q1lLcE5keHR3WklOZUNpT1MzTEROVS8zdzhLYkJ4NnJxTHVG?=
 =?utf-8?B?aUhTV2hTOE5tL2VwVloxYUFSUUJGSzZYQjVSVzArY2RoTkVNN0FhWWVhakVI?=
 =?utf-8?B?d3VuRW02WW9qL24vcXZEOC9SWnJvUFdwbXRIblI1YU5JaG4yYkppVkVtMmFN?=
 =?utf-8?B?OUZYWXhybytjb3FFYzBnTWZuUzViMXBwMXZuRUkxRmp3S00zM0Z5U28yZFZ4?=
 =?utf-8?B?SjI3a3B1Z3A2WnZUVVoyZkhJNitJWVNSVkQxZmgrbHRIMHBVdDh6Wmt2VVBm?=
 =?utf-8?B?R2Y4RG5wQ3RXTXk3M3dzK2ttUVh4U1U4WmxRaVFXOWF3dEt3RUtTMmFMdUhR?=
 =?utf-8?B?TmZmOXVaZE90NGgvUGtNWFFCdStQZ2E1TnMvVVc3emxmaVl0R3lYV29aZ3FH?=
 =?utf-8?B?TzN5NmNTL2xvbDgwdVMydmhYbmNBL0NnSHZoZ3lwR3JoVGdFdzN6b21iU3Bi?=
 =?utf-8?B?bkJMUUYrN2xuSDJPZFBQdE8xbm1JaVpSVFZLQnRjOTNPc1lHMHhXcHV5REpm?=
 =?utf-8?B?NHJlbDhoQ1hOV3NvZDl1bENraVJ2cGZQTW9TTElhMVFjTW1NdWJkZW9GNTVU?=
 =?utf-8?B?b2ZmVDdtZGNoNW9HWnQ0aGNVR3BMR082aTZJajlhZWZ4WFA3RGtpNTFIYk52?=
 =?utf-8?B?R2xzVEFwS2JFdTBZU1VBanF3RWJVUXZMZnR0V2hpbExOeWM0SWRVSUh4V0xN?=
 =?utf-8?B?RXVObTFOenhjalF5WWNXaCt4WGtNRFBSYXdwbVQ0SWNpcHduZTRSeU1ubStI?=
 =?utf-8?B?YmRhQS8xZzBXT3BoMTl6d2xJckZVSGJ2WjFIemJqMlZCWDgxbkRGdGpNNnk0?=
 =?utf-8?B?cHpUN2VIbS9KZnBmZlVNSGdhNnR5ZGZjNEFQNGJjR2Zma0VwTVpzb2NvWmcw?=
 =?utf-8?B?YXgwalZ2amg2Um9rSVpLNExOYzk5T053N0tlZVQveFJNbFBnMXUwQk05eE9t?=
 =?utf-8?B?Rm9TOWQwM2I3bjJzaTFKZHdvTitEZExDNDRVTGRpK1ZxZy9ORzRvQ3hjSE9a?=
 =?utf-8?B?YkUydlNnb2dZdTJKbDhxNFdtS2pRM0dJU0Q1RkJKSkNQQ2xDL0NqQXN2MmhL?=
 =?utf-8?B?OFE3a2FpeVFYMlY1MUFmZ1Z0M2FUSG5rTHF6dzRTelhjVVM4VHdJV1loRSti?=
 =?utf-8?B?eTU5aFhEWWk4dW5yWmt2VWxoZG4yWHVYRjEzUVJXTWFTYlZUR0JkS3pqU293?=
 =?utf-8?B?MWhZZ251OHQ2N3BDWUJraERRZXhuRVNlQkpZUXJlN3o3T0ltcFdyc0Fvckh4?=
 =?utf-8?B?K2gya3l5Kys1NU5KUS9FZk5HTm5ZMk80NXhmSkVGSklwWUU2YVd1S2UzMXRv?=
 =?utf-8?B?SmM1SG9oU21WbGVaL1Q3dzc5MFducytCbDJmbkg4dHExdEdSeDNiUG03c2pu?=
 =?utf-8?B?a2lQK2pqbFdldjFNTzBXa1NVRFBkV1l5c01QbVNYK3hvcDAxMWtETGkxS0o4?=
 =?utf-8?B?N29MdmttN1pPVG14bXVLdlRQczVTQmtqRFBkb1h4b2ZTS2gwVGpwam1vTG9B?=
 =?utf-8?B?TFlRT3R2ZzdLVnR4d0NsSnEwYkJQcDIxOFlTbHY2VkFoQStRUUpyUEdYOU8x?=
 =?utf-8?B?QW1GRE43K1pmWDNTRTNBUEM4b1V6Q3VHZ1JWd0ovUGtIemVwUlNGUnlWb09p?=
 =?utf-8?B?RmhvK3FBems3WG1pUXRuZHpGL2NGbGxGcWRXbEk2SXVSdm5SdThvTE4xUjRt?=
 =?utf-8?B?dXlzUGMycVdpbldOdUc0K0VSV3JxL1RGM2VkKzhpRkV1VXJqN2FGSkNaRmFz?=
 =?utf-8?B?L3UzOHhwQlpGa1BBU2EvYWQwLy85RVNzM1dWTmJ3cWFJWDhkRFA2eVdDMEQ3?=
 =?utf-8?B?N3FaME13NXhMK1dmTUhEMnpnSjdQY1c0cXhRekhGQW9pc2laWWFlQUE4Z0lk?=
 =?utf-8?B?Z0F3aDcxVTQzWDFNWGo5T3ZZeDlWc0FEY1BEemI4VjJ0RTVxbGZOcDN6eTRY?=
 =?utf-8?B?SmNGLy9yYUdKVmtLbi9ac05nR0RaOFNhWmZNVXh0SDVRZE9nSy9WYXdVY2dq?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAE53622B754914D98AE16EF1F0B1A5C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E0pzxGaiM0h8aBVttyTu3/KpuZzPJLFJRlr0T8ZBcUJDRTgJ+2A/ohsJfcFSCzSnRkvrnRsHiwdQnLwj+lj+CPkHEBvWdNXQDAs4/XJYnb/vmC+Fe3etGNgWQCCMK47wjiqtJwccqqDVoMM5D5M+uD7D4IA1nUVK1SxH8AIYyK+zo6kjVPvg34NDuHk7Ddo5nihPXqXkn8T/pc9jNmuwTk6Et3OuxL4lNu25nODudT5amSz7MF2zjeFzPflf2i2c+aUC+op7CiY2h/JvCuNTmQ/m/ZSnHLpfWlnKrfyP0joD70HuRw4V1vferR8deYGpy0h/sSc1dTjtyQoxeH55OOBRIcR+jlqLfMKw/LDeBUb1m46zu4bVGVB5APJywZ4vsU8gt7HZgPX1cBCqwpzrMSwMi0XK0TdOHZHfTANAQDPGeLBt2B5YgqfojnK/yXK/gLR5qKGyDDbn9vCzIFPC5PB4et2Oy2vCfu3PYJtSOR+LtVr/VxsGiZX7DbOGC+P0aRasn727YuYKD6jzyl9HSqP7Z1giTndseKn3TXwZJkSqPrjG5tfYSUQ+U4PYB17v80d3AdgCEaREQn4iN+fouYlHqa2nn7ldEWmrXHCA0jcIicsDSz/Wr85m04O8CJac2Nc5zLnQa6goFNJS3N5td6LgLh3q2osJQXE/O1lfpduF7Pa/T16G9lnN7H87AQJYROS5GNvz65fOA0TsWOssTtZdtZN7sBaFoQfpw+80mbCOE0GSzAEZesEW7n0dyO8rpqyDIGCnrsizbHi9+4R1Qj6XwjB4LLE2QUwM5Gsu4E6RAWXFsITqnRZOJsRBJTNpFsWE60gPGAG8VW7cTDEh+ZeLsXb8xkUnA6QIQ+MC4KJGkxWnjS7QDwJ4i4dwStV5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e44921-b4d6-4bc3-1843-08db501e5150
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 23:45:34.6201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG8g3kuJj15hu634aoKawGyPsWiVtvEpH/8MY3ty225UlsbLvGNhfz+rSXT8fhEKIa5IkJ3RzJqumy/9i0kl1Dr893l0wH4E9K4uqs9BQ8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8770
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
