Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B569C7D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjBTJn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTJn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:43:26 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0265BF
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676886205; x=1708422205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QB9LYYhAVNUBQO98NCIoHiCAdk/Qzyoxvtfxvma1zaSlxENry+tYxHXJ
   ekSlxrfnvso9cLuaunFFgPhEiNfAwZ/qJU06B77VgPt6juMsI7RYfZWnj
   IdGaleeTlrSSGlkQrGjY8MTQIIAY6myEN6RBhMHkJplzYlO+KWmOuc8vo
   PXj95p/wbDirTKQDlCs453xPYIXOj4xZuzJsO8rRcON00NGpTyfzfd2t6
   l1diY+gwiaWt+PIY6DFVLbSQWTO055cEAZeqxv3+GAZUVsh9ym/EV+r7c
   CyW7NT53L7768kBgtqdxHghbKb3Rx+1UlOf8aSG0P+bu8ZojfIECy9CFm
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="223730699"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 17:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4qVsPIeMYQFYj0P8JeS3ApbOO4kbgLVz0isAv13/bmAyBgG0kNTFH+ueVtrR9m1hNXas4QBbr8ZhZb4GOeP7Ug3QA/O5X6S6RbW25hfveTqyT4bkhnT4P8qswmKc9DhAimhIV90W9CjpYxFVUDJGfDsutT5CXpZyr0CP9+Gy7a+z95WauXVjErNj4bGmmbqvjvZWUkIbdVgTLIHp95D7bqfuF+WaQglAguDL5z0w96dg3ADApH9ZObkghfhBbkKfrb2qoHr7SsneCQ/+mvIZ7f9Jn+WRmEDD3deVJeMOsS6c2d7S0yTJV3WA+BbgXjHbupnHlUzD7NbCZpXF+wy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YYz4E4574H/S97D7CFrN4uQ1j5D4czv1Rp83KglUScK8ZvKpO79tEjg3Cg9gbGoyjns3a3fAQgnbZyusxKa1vNnkSxZyaruupUSVQrkmupJNrY3LuXLjzVL/XpCwJza16pHi+iZYPg7vJ6fPrlB7KOnWKI2cFhBXw7uH8nMA6p8zME5ZCUaF7Tn8PoAA33MFG+TeM9UhJmCjW/a2IS7ZdTOnMGgB06p5M/9gnitqU7yv8xGX6WpRebCi/SUqVm4zqh55aKMA8slOeOOx7+C0mbBCX56whDCL4e3Q56yvSxY3rdwVMVAb53HX0ri5OYUE6Qqy70sq77SnE8kiGjSlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fXaExMWpBHb5GOfTHg9ooR/eXiZTNQZFX8sb3MKV4xlPvDP2f/skETci3HtwJaiLz6bSOmUSRvc8ZflxaWqJ9N/q84uQPKZjtHWTV3xaRaBuvnQwqYvrxPHtUob9YV0J/fQANWC4UqqkIXtK4UmbmtM7c+UGj47hdhmp7Abw4Cs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4140.namprd04.prod.outlook.com (2603:10b6:5:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 09:43:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:43:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/12] btrfs: remove the force_bio_submit to
 submit_extent_page
Thread-Topic: [PATCH 01/12] btrfs: remove the force_bio_submit to
 submit_extent_page
Thread-Index: AQHZQiSeOFK3sXYRcky0U81jdNDGLK7Xmz4A
Date:   Mon, 20 Feb 2023 09:43:20 +0000
Message-ID: <55ab4051-cc42-ebed-8e58-05a4aaeb3f49@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-2-hch@lst.de>
In-Reply-To: <20230216163437.2370948-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4140:EE_
x-ms-office365-filtering-correlation-id: c4f45b15-9ba3-44b9-2d26-08db1326e708
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AsohxUjPbW6yFNCatr3wsTpDjnIhGFh/091Y4PrmONDXTWJq1u5xQxKuJECatoTEIn9V51fdNPBymDYZOZ0iSup8nrE+5y27y2GIgHXEqKLfWNjOgsl4TFDXqEL/tz6zCLuGNz/T+y90GTn+YbI38bdvZgALCrXBZxcJoeptuK9qHX4w97XBMIF3I9Xw+dD1A6aj0OnWUQDjkshHC7cEmSwgsLybMTzFH3cb+tuzSzCJoe+1E2kZ3XSHlHXE1yEfNXVR0seJWmsHA6Uxbhj29gIy0GN7jzexmajeAkkEBCPVs8vdqNNpXoVS4oqLfuLZ4fregWYOSNmablCKe86hZj2NeUglkL36uYGRmvBBSCOOMLsmesbOdCTV5dxsbEyQMxD2ycRv3iX48J4VLDm1/Z1CZ9uVOzxBc7jgmCgyodpQo0sydULd5MxW9ehvWjCCW/pBEuKa0HQtGwa7D0zhXgvJDBjZdYvErSVvam5/eAgYEBeisA6uoktZSTQhvg59aBC6hytdRZvw542g369pKIxOIoZBpuJeb29F8edOF0RdDAUNbmaYcM//9Q1mTqbIs52AO+EZmNU0AEZBf814C8rc7HRx3LfRGio6bL60K5BW7KylXbejnQX/Yy9T2Y9U1RqmtxiVK8qpMUDZP0n5BSI59o2HCiDGkQWfdJ6aWTwWP1e3sO9+k6+3d3NOd4zu6tiAgOjLUGqz9TlHx0Epv7isRiIGLsyT/r5NLi1w1XupTYRUjcOym/Axmlg73EdU3VonyVhi/v5g95D/KVfV3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199018)(36756003)(31686004)(38070700005)(82960400001)(2906002)(38100700002)(122000001)(86362001)(19618925003)(41300700001)(2616005)(8936002)(5660300002)(4326008)(8676002)(66446008)(66476007)(66556008)(66946007)(91956017)(76116006)(478600001)(31696002)(4270600006)(6486002)(6512007)(6506007)(186003)(316002)(71200400001)(64756008)(558084003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STkxN0NuZi9uMStOMVJpRGF0cGFrV0JxcVFvTUN2b0swSUNmNXF6cUUxS1Bt?=
 =?utf-8?B?QWFhNWxCYmlkMEFpMDNOVitvTVQzMUhnaWdLRlduSGtVdE9GQVpJc2hzQzcw?=
 =?utf-8?B?YWlpUm5nYlpRZ3lWajA2RG9PeXJ1UlgvN2hHTC9kQjNTRjdCVGk0Q0UzSmQ1?=
 =?utf-8?B?VzBIRktEa3lTNXpyY0ZML3lsMWJJcGo4ZGlzZWJVd0xVODVreUd5OURuc0t3?=
 =?utf-8?B?Q3Rnd1hsVHZXRmptL256VU91Zm5FTWFXTE5TZTQzUzFTc0J6dnRMbEdTTWlU?=
 =?utf-8?B?a24xcm04cWxGdlcrY0F0cmRCQ0NIa0xOVzFBckNQdnArb0t2a2JRdTFBcGky?=
 =?utf-8?B?R3RSNFBHV2YzV2NPOFRGazM2RHhaU3NoeWJBTUhsVVBuOGlScit4K0UxOUs0?=
 =?utf-8?B?Mlh4cS9QZjhVR0ExWFhUdTlCYkhpRzZSazJJcGJqYkRCZWdVejRaMXYrWlhF?=
 =?utf-8?B?ekUwTVZBYzZiU2pkak95TEx3M3VuQUcrTFJnVFVEeTExdEs0UStXNFM2Uzl0?=
 =?utf-8?B?dnZ4eDNScnBiUlZuQzNqa0FXamYzQTJTNXNOQWlzOFN5aUsrVEp1WWdWcXBv?=
 =?utf-8?B?RHh0cjV0YjJXS0NnRGU3eGFORmRNUUZ1aXZSTHpaOGxJMTF0cTk3eVRoSis2?=
 =?utf-8?B?cXhlQXRNMU5qd0UrcVhMcFFaSXNBZFlBZmNVR0g5QUpZVW5NaXV5azRObThy?=
 =?utf-8?B?R29HMmlkaG9HQ2g5MGU3WDFWbk5panlFbHRacGNRdzYzeE9udDgwRjgwcnlk?=
 =?utf-8?B?dlNhbi92bEsxcUFLSXIveWJoMndGcDVXSDRVTWh6L2FoNmEvZnR2aHRqb3pR?=
 =?utf-8?B?anlPY2hCNUwzODlvNENtSmZZdW9SdkdXMWNnUnRzWFY2a2VVTXlmTGMrbkdM?=
 =?utf-8?B?YThsVXd3QlFwQytuWGZQTGNCejlwamRFRUZybHpPTUFFdDFDdzVUQmVmSlpM?=
 =?utf-8?B?b3pzMmJnRWN4cVB3b3JhMXExYTZaRjJZRHp2RXp3NENDTnRZM2F2R2FSeW5L?=
 =?utf-8?B?RGhjT2hxa1R3UDFQZWRGQWtFTW1NUWpGVkoyTVYrR3JmYjJ4L1Ywc0RjWDFP?=
 =?utf-8?B?am55UGYvUjhtM3NWWTAzZXNvYTk0bnEvSW43WWV5cDhUUXh2SmhtWTE4UUlW?=
 =?utf-8?B?dXExWUU0SWNodGFMR3FzRjBBOG8yY2hpRzVaV3ZIUFBBaUlIS0EvYnFoN1Js?=
 =?utf-8?B?b1I1N0RxS21PRUhGbkJmN0lCVk5jZzJzRUN6eVc0MW9VMmYrSjlCR3MyRFZC?=
 =?utf-8?B?L2RBZFU0QUU3UzQ1cElXR3d2Q3pxbUdJeDNDN2p2N2JXTVNCejJRUGNrZnpI?=
 =?utf-8?B?Z25VTmxBaDFMaUtRa2hhZFN1bCtVWkhSNUxCWHE4WElBYjArcE4xVzNjWVJO?=
 =?utf-8?B?NGU4clhOVmpVdHRiU0xDVTRKY0FwdUhDSFFMbEtLK2JjeWw1d01sOEErT0JE?=
 =?utf-8?B?QWh2cHQyUklZaHpqMWpERTR5Mm5QTzdRU2VkYWdRazZwVDZtNUhONTE4WS9z?=
 =?utf-8?B?SW9kaXBjOG9CYXVEU25UMTVJcjNWN1N0WFRHdFMyUUJJWmlyTlIvQUJwdDRQ?=
 =?utf-8?B?S1o5ZnNzN2RucXM3R1lJb1UrYjBZZGN3QkNRWVkzVk1uSW8wbyt2ZEZnVzI4?=
 =?utf-8?B?eUFxWndvN1pMS2czU0N3b1VsTC9CV1dhRjk2NmdrVnhLdFBDUTkyclFWOHdw?=
 =?utf-8?B?bDQxRkFZaThyNFB0MGlEdDM5VmFwaUdGWGxuRXNEQndtMTlwdHhONW16bXFW?=
 =?utf-8?B?c3pNL3RIQzBDNmQ4L0ROMXkxTkRQeFRyTVhhS0o1bHdxYURTWUJ5TmJpSzhN?=
 =?utf-8?B?eEd3UHRkRkIzbEJ0MlRBV3pJRTNncW9xb1oyRnBISnVoald2OCtXVENPZEVl?=
 =?utf-8?B?TXRuaVBXeDVUUGVzOXdsWVdoZFpEdVB3ZDFKZjBlYzFmTHhXS1pFM1ZVazFK?=
 =?utf-8?B?OHR2bDNJeFZYb1g4aFZSalBNakhXWFNOQU1XdVdIK1RsNXBkVWdTdTh3dXE3?=
 =?utf-8?B?VnNyc2UyQUd3VDhzMnJSejc1WXU5dThZUncrdEM0UW5WcnIyQ2M1MjRTaHBS?=
 =?utf-8?B?S0xwb0x3SnN1cklZZVN2VXZ2ZDR1UXpjeGc5N1AzblVWZ1pXaWg2bTBJNmlJ?=
 =?utf-8?B?cWZGckhpZ1Jnc0ZQVnFqUit3RmdKNnNkVnlSVVY5YktlQUpjaFdaLzZ6ODZY?=
 =?utf-8?B?eXd2cUgyU2lpRTc5MGhLSm9uVXdMN2ZocWdhRnNwM3JuWnJYVWxIZENXUGhq?=
 =?utf-8?Q?HAtO3vt2VlCHkzkSl84746XQa55ESln2WIqZdNWN78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A887E0BAD51D47B25E2D43A96667A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dAsb1CZClR+qKeJvfbFsKZJqQR1athyXYJaHgXFcdy43mEyj+BeN4YBm+dYP7kluzNEU1wihvAAwUUwgS2ZVozCa/O8WPG3INVgWAStiX9pHv8rSxFfvfCpF5OluqDp52GIBdCi6PwTcCdU33xK1/ichCPEsowd3GRJ5rR+/qBKN+BbphH43PBvzkpoYGY3D0CJnmtXo8QrgDG/TqcXSk8Kd7Ux2NyPkSaONWOj6ySwuJLOepRKbeu3Df+Wt/eE3gtN9L0X1T8/PdLgn3gIoIl8juVHLgdN1UUKqbSr+0EJLF8GvW42IQqWhd5n987tc9DgozPubYiMwQ3y6VQmWEsKDwdCkGL02DS+opzOwvmvZ3XruzGX4XazY3FnC8XucD2ndE5/mxjsEqzohkVwzHGHuRcqtBbUYwgA04vdl+yT30yh41zykVW72TKo0L9UP+zQpR5/neVUoN3SbxDAWwrmLIUiLi5UYOkl9OrD9EG2o+nL4cyUD1twOkl3AuzV4Jrt6csHYk24d5kC7EwoEMnDayEl4OF0PwEzby75DIYEYowqoOKsl+aiudO0mgmevugIuku7TpBlpBoTvMXCvoHN0t0Fni5wbC+zA6HliIkm2nAzCPE06JysaFpB107RGtY0WfseyKh9o9BzIvl7B/7M9oY3nMHe3giucxc+3oCVcqE0kTwOFON8FGp0qJ9aiy79J5mw0pSwwXgJ4gGKxVwVS1+BFD6YTFRGuaXgd2/Fihh6deGOTjk0ZL2Mhnle+nx4mKgrdBMcLghLrQTTCu6Ozq5nZS+OHSS/dFaxpG8G/870G5aHfCW2EdfDgw5Ps4Ip2Qs9y/xMZdH0lzn1gu1QkzGZzVeW0sAduoOKuy7nR1zZHz60RNm8BzDWItzKT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f45b15-9ba3-44b9-2d26-08db1326e708
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:43:20.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLpxUw4OdTdxiU7ijkx/4CMFUngIEwR16AAwxHYC0OVtbpQnv8PgWvIA3D2eo+LXgrK7vEe8jTuMtqFQd3dzYOlz7/1w6k+yamsVtC/K3qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4140
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
