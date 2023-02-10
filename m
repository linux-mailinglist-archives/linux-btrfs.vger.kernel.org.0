Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1A691CC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjBJKdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjBJKdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 05:33:54 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A46D60F
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676025233; x=1707561233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fwHb169cpKktegrfvs3hkw1Fc+msSmw0HoxYK5CVHOY=;
  b=K+lHcXWY7/a6YQCtPlhP2WARO/CaEzaWjDlAv2leP1laQZ+WfPmd0Kwv
   44grn1vySWFsV8G9wM1UJJ/GRSKpw8kf2TWSIY+OdOG6tcJXGC+neZHHI
   2ukY5UjSqlGqfbuzeAgWDbvXkOP1XRWF3uVnaKBmM8+2w9SAGIQx6f1kW
   QmsOtG8dEhbUxTRfxa2m4fi3vz9UUYjC5VlKmZnxs3N9mp1V0QZKMN2ZY
   HZhRrnd9XA2WlO/iN8D5lgBMAxzweL1uI1jngUMFsWjFXNOD+OUWg3xP4
   qlj0dnDZzs8FmT3Bz6kQcFX6At49Ms9jji3v5H+jIdoHVX/WwLQbdBdUD
   A==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="227965509"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 18:33:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvbPe/lRYVeHblah8HGw62RYXjYynxSx5jX7UN8e2bq8tQ3B/OKRRcS94gsJz+INs0DsaBPfL2IoZHKb/Funx4TIVTaLoc2ZvuW/StZ30OYv9AzXIWN3xOaLqRe/c3qHs0H96piMmdXj9myZv/++YqabqDPN0t4azdFEsikM68aHTFlT9RGNZBrcMCu599qlx5FobHCL6Z1rlchw+eE42AF242CIDnxbE6aKcma27DnTdqJqCW0yLogJ2PSQYXqxL9PcYxIlRaydk6o1xMeaRZU1X2D0dY5OuGzu1KgD/20G5EaaEAzaeYyzY7IVNe8uN3f8L9NeWDjZHORtWRsQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwHb169cpKktegrfvs3hkw1Fc+msSmw0HoxYK5CVHOY=;
 b=ZLUmBSAW1sMQksxP9ENNX0Z+C8xARfYEGhAVWuAQiGPjDcAdlNVXqR6C0gNNYnndhTs2N6pN2yhyR5v+JFuY+5jdFuD3DkyHk8ZkqcP9msfX3fVMBvefywRTjfHrJZcGhHhHfm6/vsdcvBgbE4l1qQGb4RK/gK8mRZg6ejM91Kpf2rZqW/dduIQSIesbKRu6eAUnH69UL/GdDgLveBMHLnzU2D53PAaME5o3Rplr9DPNsTlEOQltrqrfn1w8rSvf73TSUW/QyrluVnOBcf6pkdMjCZF8eCNej8jMU4k13gzdatQIKCHf0uKm35z52FFr7WS5PV4ZhDCOGD02FggrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwHb169cpKktegrfvs3hkw1Fc+msSmw0HoxYK5CVHOY=;
 b=tdly2S6D6hUNmwQ9xiL0ow4kF057JR4MRaWhHF3dRYXgBJm8sT/aARfGJdIeVqyhuS36T89H7tT7JnDeQu1i/Gttel1jS14W8mqlgqovnVMq1i+FEXiZcqlqb/h9fq5Gd/sV5ADvkYYFY4Cwww3RN0E8fDX50KZjG6KXDMc1crk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7023.namprd04.prod.outlook.com (2603:10b6:208:1e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 10:33:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 10:33:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Phillip Susi <phill@thesusis.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Topic: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Index: AQHZO6w01UFWKaz32kSJ4ybjKHGu4q7GxvEAgAEZcYCAAB6RgA==
Date:   Fri, 10 Feb 2023 10:33:45 +0000
Message-ID: <b981b26b-ec0e-8f0f-f929-880742a5937b@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
In-Reply-To: <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7023:EE_
x-ms-office365-filtering-correlation-id: f65fc0a3-4b46-4fa4-f553-08db0b524971
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIsgm04mi9rdCwOwICkLj7+F7z/iCbd8Q6kS1B+wvYqB4rd7SJRs36wZRharqGuu5gGeVTeE8wOB+mRi90Xe1OSoNqRujJDyRm39mAOCIrsoYM2QC9i8fbuqO1Ief8LEP1K6xIrrOkN5NLkdsWEI0g9ZtvupEgGZ+je6CuHW827nPQqz6aFHrdICCpCY8IDn4j7g59S7ZrSukI3kzX62mLtSEWDlw1TQVl7LL8yi0f7BXfCALLQhL0GkHqfOb1+yFVWd5CsM0aHDUNXyYooNdTIwZHSlkd+DbuJWBMaoctY2Lhe68jfzGsN8oov+GRsU6vyr6Gzkoc79FXjELMIRQ4p23s2pVIz+v6y5wjSAioyDgsdLx24LWWYVt2/xU1qvIa4tCTnmU0GRPp1K9JeaFTvWhokCpelgZZ6ONh6m/Ehm/K9ezbhbgV7vByvwMPDN64nWO83ZZRtMB9SvvtH90IJB1xH3QkeQhQ9my+GcZNxej0aqceC8zsY1mQ1Fyu3sjLQeyfk5Q0ozw8uVJMl304C/5l8M6NgmgGeNdX3tHvwM4x8or7P8W+r7NFcQJckR35u2Zv8W95y6WiaSgYEWU2W86+kj4HcwMPHWjodzhC5wBB5dbZvWmDizYTWTxiiU+MNP6NTHzni0EnlXei/BZy8kXJi6ftd8ouGmjqeho00pEF9wGuGjgFVl6Qd77iYjwZ2koKjToLXkDfE6Rxj0UDOuAlS0LUl1iZoX2l78K7JJDy/lUDDrxeeKfd0sofE8/bbo36O6JsrWlCLhGzhMnqi6XY8O4Lr+WWe0sZAOzsWoDjwpAndBik35+7S2e6FxCqF/Rb4voCBs0f0KhSuclB23RmqMfUEDFDt9enzHvzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(2616005)(5930299012)(2906002)(38070700005)(966005)(82960400001)(478600001)(6486002)(53546011)(186003)(6512007)(6506007)(31686004)(71200400001)(38100700002)(86362001)(31696002)(122000001)(91956017)(5660300002)(83380400001)(316002)(41300700001)(36756003)(76116006)(8676002)(6916009)(66446008)(4326008)(66476007)(66556008)(64756008)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm9ZUFV6RHE1ekcvdEwrYzRteFExNWtBdS8wZlIxSWNWeGVkUThXZVVBaStv?=
 =?utf-8?B?N1lpTG5VRTB4TDZtbjJNOXZJVFIyTkFqeE1XYVN1aVpHYW9iOTYrclhWNVRT?=
 =?utf-8?B?VU83ZG1pZ081YisvdVdUTFFuM3RVaW40Z0F5K1o1WWtZSlZROWkxdUVRbDBl?=
 =?utf-8?B?Q3g1WGUzRE52cUhLbnVaRFdBVDUvWUdNZURJUmJ1SWd3em1CR296OXdmcE1i?=
 =?utf-8?B?dE1iZUtLc3RpVUpNZzBKdkwxOHZ1WnJ6OVpSSDJMQlQzNzhRTmxoUFhFdmFQ?=
 =?utf-8?B?Nmd3OHZiODBqZTgyUEMvSzNBSFRKVFBIZTcyMlVGbWd0c2J1bVRwcjBZeFhF?=
 =?utf-8?B?SDUzaWh6ekZNT1o3WnZOQjBGOEFVOHA0OWwzRUExbGNwaUEvL1Q3V012Zm54?=
 =?utf-8?B?L1UreTZQcVltaVp2SWQyYnNjQ0ViNGxRRmp1b3YvZUVyU0pMZ2w0M0VFUkRx?=
 =?utf-8?B?RlBnMEwyK3JZM3BrQ1NHeVNHbkVsK0J0TXhGQVZENW52cXUvMGhQOStmcHlH?=
 =?utf-8?B?OVRFZUdzeERpVzJnVU5OMUdnRW5YTG1IM3hTSGx3QktKd3FZTlVxbE9zUGJj?=
 =?utf-8?B?RG5vQWsxL3BYSEJ0MlM5NndXUzhaRDZ2UHI3eGZJSVlxcTlpdWt3QUVVTytH?=
 =?utf-8?B?UmVoSHNsUFExNWdObEUwdjg0VzNGaTdNVnZzQWhmNkE1WnFFUFNwUzIxMWJH?=
 =?utf-8?B?ZTBlSUdYZ2c3RjQ2amN0bjIyOGthVkF0c1BFc3M0cWZiU2l5cHA2RVNnK0Iy?=
 =?utf-8?B?RWQyK1BIWFVQTmxxVndVblBmc1J1a01wOC9udGxvcUJzYmRkS0dNUTRVRGkz?=
 =?utf-8?B?czc0ZzQ1MDVmYzlHSEpvWG1pbWZtdFNMZ1Fsb0RXci9ST0JpYWxtRndsMmd5?=
 =?utf-8?B?Nnp3WEc1eTAxc1djQ0dLYlR2a3FsRzh0TDN0emo3R0ZnNlNvL3Z0Z1Y1UVhv?=
 =?utf-8?B?OGVsMWh6Y1pLaDB0aWE0Nmx4Ull0THBKck1tenRRb1UyL21YLzZqeTJ6cWRM?=
 =?utf-8?B?dFFQaEJhZXFWMUFxd08rYTZKQVBkeXpqTnAzZWwrNU8weHpQZTdCQi9HN0NI?=
 =?utf-8?B?a2ZlVm5GR0M4a2pXMzNkcXl6NkFndTZMUkVCTHhOck5BM3hGZGJjbkMzWGxK?=
 =?utf-8?B?WjJDNG1wbGwyMnFrVEN2V2h6WVIxUnZzdnZ0bzVyV0FTZEFmRXNnZkpqR2Mw?=
 =?utf-8?B?RThHOU0vSmEvM0tTaEswdFFDWVcvTGUwUjZGR1dBUkM3TThHN0I1QzlIa2lW?=
 =?utf-8?B?WjlzV2ZlZVRkU1o3RG1pZExueTZ2QlJsUElTaThDSDNjNWtxMThTcEkrOEdV?=
 =?utf-8?B?dmpNd3YvOU5idDh0cVBLRGRPellxcmxRQ3NZcDFHUHV3M1NqUHNRMlE4ZXFi?=
 =?utf-8?B?cmtJWWxKdjJhTllleUY0ZWJnMW50VllCbzJ5c1FnZW9LTnFvdExDOEY5cWRX?=
 =?utf-8?B?dENIYTdhajZFVzUxdHpqejJ1R0V0a3dWZlBrc0Y1UHJydk05RHlPUmg1a1BV?=
 =?utf-8?B?a3d6NmxVK29DeWNtT3VkSmwrdVZZNXZ2Z3VLS045Q2RibnNGRHo0YTFYdnBj?=
 =?utf-8?B?MVBlbWErVVRHMXQ0cVRJeFZNc0JCR0diemJlQmdITFNTejR0NndtTzN6aVF0?=
 =?utf-8?B?bjJSY01hVjdEcWtDRzNSeFN5RC8xR004a1IrWDBJSG5NUmlGN0NnYUxla2NJ?=
 =?utf-8?B?RWtxZmx6TG5Xc01qZGpoS2wrSGVyL1JmaFl0R0NyZGlwTVArNWViMFdvZWEv?=
 =?utf-8?B?TDFjSWJzdGJKRU90OExEWUdiNlY3TzFvUE5mK0ROTGV4TVFxQnhUamZ5RjhE?=
 =?utf-8?B?NGpYQ1dnOGlQcUcrYWxuZy9jYzhmWm93eTFpS0sySFpwWmRpWmJNa0tuRXpG?=
 =?utf-8?B?ZHRQWUpsT25QSjhYbTVDd09tWEVDSk9uVXBHQ0Z0MitkNitmaTZ4VEFhOG4z?=
 =?utf-8?B?MU1iazd5QUZOZzgyQTY3Y0RvS2N6Tjg0UTF2ZWd6czNpVngyenJlMHcycHJS?=
 =?utf-8?B?RVBsb1FOQUtFdml3UFc3RzV3MWJCcUNNcGZDbzg0UW01TGw3dGQ1bmFqOVpF?=
 =?utf-8?B?SDRMUS9QNGtpTnJHbUMwa20weGZjeEhIMk05UDRVT0d5NldaOEFrMm15QzRB?=
 =?utf-8?B?WHgrOFlTYkRMajZpNjE4amticndWZjQxYTRkY1NPcC8veDBTMlRzVzduOFdN?=
 =?utf-8?B?UXg0YytQNmtrZ2N2OVBvb1BkaXJQTnFsbzdpTlZ1SDhtdC9vaTBvMU5memxU?=
 =?utf-8?Q?2UQokSZZSTpiatuRl53IYszn5Iorlg8v4IpMlLDHEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3AD805EFEE3A6499672D5C17E331F67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mocDKgJ0SEEcFJP4GOeaipEzTEBefSotR2SnCYbJPzhOgmkCT552j7UNala3rvqmw39PWNMHnSF8TTxM6giIdWSf/ZhXkdEmpcRWrqrJppOXcwqyeHDEC/T9gguUBOnNh2bqkl4OltQiB5afXykoWtmDJ2y/lBFZMQOe8rR6VgRsg6JMDeBNUNaTPZyuqpzaHifRDwpBvCBaq6f8xqW+4/8ntS8GBIX0P+z509UN3vw7IqNZMGXxBYpSn757rMy/aZvW7RnDMcnrXrnUoF7GebUQFB+5ERWcwefKb2OQlj39vUTSxT1ZvPrq4Lm6eRebMKHvOgRPRjpGF0lQeRLwtljrlY865vfZzbM74x+2QBiTbOcCEKHod5Em01MCelRXRPXePvNTY7zVPyLjdwVEYw17oEcwCjs+K1IqdRI1ss0+1J35CWv7F8MF6atqkaIKh3nFL8Ev14zaXQIus+EjDquxNGjjOO+BWHLrER8haPYfO2IYYXK/m6St5Jj16DmRy3BSt8h/PBnAUKwfkKG83BXcocLY9wRW78vq0gsAfmlFSn2dhLZjWf2bCTXjSdhhL7vJrLMWOqzco3Obt6hZ5dAq+q4UU8b+VzKozmmgCb5UiyJxNia/ggZNvLgjvFShq1edA1gslL3lreW4nEGR4HtTSzM802281N879F92LT7J2A1SgbgPABYTXpqP4SJvxx4v59jjpt29sUh+pHHjN9y2lqLdDFO2dkp1E6vxmz0czddtSLNrfuUKOCpVWxvUrA3avcu6wTtrIqixBht8nU7s5aWXoFdCbDYjlO3sdF5KElT6F1b3TPWYoF7KgIoG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65fc0a3-4b46-4fa4-f553-08db0b524971
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:33:45.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbRA86SjKLALXUBZPSX3FLDCn90aQtlvVVGzLk5LzvUQ71mWlkc91t7YXmdt9+xFsCrgFXDZfKobWrhGOnT3osYNdYLpZmQyHpl+QgYqnsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7023
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTAuMDIuMjMgMDk6NDQsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMDkuMDIu
MjMgMTc6MDEsIFBoaWxsaXAgU3VzaSB3cm90ZToNCj4+DQo+PiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPiB3cml0ZXM6DQo+Pg0KPj4+IEEgZGVzaWduIGRv
Y3VtZW50IGNhbiBiZSBmb3VuZCBoZXJlOg0KPj4+IGh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2Rv
Y3VtZW50L2QvMUl1aV9qTWlkQ2Q0TVZCTlNTTFhSZk83cDVLbXZub1FML2VkaXQ/dXNwPXNoYXJp
bmcmb3VpZD0xMDM2MDk5NDc1ODAxODU0NTgyNjYmcnRwb2Y9dHJ1ZSZzZD10cnVlDQo+Pg0KPj4g
TmljZSBkb2N1bWVudCwgYnV0IEknbSBzdGlsbCBub3QgcXVpdGUgc3VyZSBJIHVuZGVyc3RhbmQg
dGhlIHByb2JsZW0uDQo+PiBBcyBsb25nIGFzIGJvdGggZGlza3MgaGF2ZSB0aGUgc2FtZSB6b25l
IGxheW91dCwgYW5kIHRoZSByYWlkIGNodW5rIGlzDQo+PiBhbGlnbmVkIHRvIHRoZSBzdGFydCBv
ZiBhIHpvbmUsIHRoZW4gc2hvdWxkbid0IHRoZXkgYmUgYXBwZW5kZWQgdG9nZXRoZXINCj4+IGFu
ZCBoYXZlIGEgZGV0ZXJtaW5pc3RpYyBsYXlvdXQ/DQo+Pg0KPj4gSWYgc28sIHRoZW4gaXMgdGhp
cyBhZGRpdGlvbmFsIG1ldGFkYXRhIGp1c3QgbmVlZGVkIGluIHRoZSBjYXNlIHdoZXJlDQo+PiB0
aGUgZGlza3MgKmRvbid0KiBoYXZlIHRoZSBzYW1lIHpvbmUgbGF5b3V0Pw0KPj4NCj4+IElmIHNv
LCB0aGVuIGlzIHRoaXMgYW4gb3B0aW9uYWwgZmVhdHVyZSB0aGF0IHdvdWxkIG9ubHkgYmUgZW5h
YmxlZCB3aGVuDQo+PiB0aGUgZGlza3MgZG9uJ3QgaGF2ZSB0aGUgc2FtZSB6b25lIGxheW91dD8N
Cj4+DQo+Pg0KPiANCj4gTm8uIFdpdGggem9uZWQgZHJpdmVzIHdlJ3JlIHdyaXRpbmcgdXNpbmcg
dGhlIFpvbmUgQXBwZW5kIGNvbW1hbmQgWzFdLg0KPiBUaGlzIGhhcyBzZXZlcmFsIGFkdmFudGFn
ZXMsIG9uZSBiZWluZyB0aGF0IHlvdSBjYW4gaXNzdWUgSU8gYXQgYSBoaWdoDQo+IHF1ZXVlIGRl
cHRoIGFuZCBkb24ndCBuZWVkIGFueSBsb2NraW5nIHRvLiBCdXQgaXQgaGFzIG9uZSBkb3duc2lk
ZSBmb3INCj4gdGhlIFJBSUQgYXBwbGljYXRpb24sIHRoYXQgaXMsIHRoYXQgeW91IGRvbid0IGhh
dmUgYW55IGNvbnRyb2wgb2YgdGhlIA0KPiBMQkEgd2hlcmUgdGhlIGRhdGEgbGFuZHMsIG9ubHkg
dGhlIHpvbmUuDQo+IA0KPiBUaGVyZWZvciB3ZSBuZWVkIGFub3RoZXIgbG9naWNhbCB0byBwaHlz
aWNhbCBtYXBwaW5nIGxheWVyLCB3aGljaCBpcw0KPiB0aGUgUkFJRCBzdHJpcGUgdHJlZS4gQ29p
bmNpZGVudGFsbHkgd2UgY2FuIGFsc28gdXNlIHRoaXMgdHJlZSB0byBkbw0KPiBsMnAgbWFwcGlu
ZyBmb3IgUkFJRDUvNiBhbmQgZWxpbWluYXRlIHRoZSB3cml0ZSBob2xlIHRoaXMgd2F5Lg0KPiAN
Cj4gDQo+IFsxXSBodHRwczovL3pvbmVkc3RvcmFnZS5pby9kb2NzL2ludHJvZHVjdGlvbi96bnMj
em9uZS1hcHBlbmQNCj4gDQoNCkFjdHVhbGx5IHRoYXQncyB0aGUgb25lIEkgd2FzIGxvb2tpbmcg
Zm9yOg0KaHR0cHM6Ly96b25lZHN0b3JhZ2UuaW8vZG9jcy9pbnRyb2R1Y3Rpb24vem9uZWQtc3Rv
cmFnZSN6b25lLWFwcGVuZA0K
