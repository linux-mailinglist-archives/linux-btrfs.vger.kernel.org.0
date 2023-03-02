Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1C6A8346
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCBNKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCBNKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:10:13 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDA14235
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677762612; x=1709298612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lc8pJqLaV6x/dQj4sN7tKKuE35rb1SKbRmW4bCz3t3O3BoAf/lqWNhoX
   7LQVzXCY1bTh4Fu8FGljTLRfQsXyMwu5NCejdDEYYVPSJ4H2bjZilaocl
   6ltbehpnuM4sfh1LgeupQS95IEgQlM26+H6D0gEllhmRtfU6NAiuNhQO4
   Bx+QaqY9GJtQP/BqlXiQM1PqFJOXm7lEohuB8/0BXZ8OOy7Hsg3UU3Zfi
   eAJcMWitHSNMnWhNMSEM/2HEyrqMa6NWB4SG2i2nML0xowfLaI73evJEt
   cWhbZ1UzATKVvRHZjVAeGlTOADTuBWC4nrJOE4PpKyWLJofi7m0boUbWv
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="336607729"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 21:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUVYWhSnQYLm3HKRXFf7v2EkcwWiCgyV2Am665yUZgQSD6P79I0uaYXMQNKtdFE+cqNlI+X5Tn68FTr1SFz3b1Ay7fP43dkdbFmOVcKFvEe8WxIcQuF8gkr1aJylHzfZ0zGRVEtFPChYZa6K4jJd5pS72JK4/cI/nznmzzJ+yEoFsQzvlAfhI6HFqccQLktYIlHguf3Fg9AR0SiTnoWulx5KcZ0zpluTFTquyyiBcUcPQzd02v8fZZbZPCh805QgeV0KL2AYf1azneCqG95y/Fem/Z7x6+v5lTEneU2T++cOZebNwcNUsOZUaPtPuLfPOqD18xCsj3vyoj5ZPToEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FXjFJSKbIFMigV1A1GuIsAWwU7KEO5KtkyiT4ss10sqgszZA7OSnt1MEXlFpOsZLJqqUyvfLmNCWGZibmz/JCi2v3OuL0tLWRTCg6r6MAO19IMN5p0Be0O4iU0rUq39nUJVnm4J6q/TfLinqvP4cC8EqHFvdWPazwJ0MlFTojtZ2BLc4OAf958ctQJcRorqZ36d/I4afoMn3mq9jLDLbfhNYMRVx4qmJEZGpsRhhqY9FaoIw3rylxHkbDRaRi2Z7zHI/4DJgEkoorBkgXCE4Jeh8va7nlx+aoioYIB6sLsXzVplYv+7g5xFE5UJC6cVn40CZ6pF+ezGVhbDkg2AdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bs0V0VoWCRfYcS5FwgqDr/V8TeVCQWMpP9rXXT+KDgwpHLIKtMA4z9UWgiax8w0g0B9EoAkwysKYa267kQS0VU+6lMApARgEl4eu2xR5/a0IPvjzjgp2mBTftDMPMvB9Zb5EYh7m4WrR0oDhvoPZu/miGMRdC8B7AUvz1G1pCB8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6044.namprd04.prod.outlook.com (2603:10b6:5:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 13:10:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 13:10:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/10] btrfs: simplify finding the inode in submit_one_bio
Thread-Topic: [PATCH 07/10] btrfs: simplify finding the inode in
 submit_one_bio
Thread-Index: AQHZTEO/U1Kr5pynDEeRcJDkEeU4sK7neBgA
Date:   Thu, 2 Mar 2023 13:10:09 +0000
Message-ID: <14829171-34e1-6ef3-7566-8b42914db39f@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-8-hch@lst.de>
In-Reply-To: <20230301134244.1378533-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6044:EE_
x-ms-office365-filtering-correlation-id: f0652e4a-9425-4a14-8241-08db1b1f7346
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2kyW4jOLiVc/UCzOeuQeVwf6EVzFwvga0t8JSCDhST7jMrxoCt+C0CdHnj3Mx4OXn438aMQ4DfZqUw82+siGtWUkAUHN1TuAmHR1+xYGap5Eu79c7RMNqJbGqDdGWCzjCxsO9EcaNpnHUj6YDKU+saFakPhAhlsPUqrrpJKDeaQaj9s4W7khtXf/DvYOEvUkBqqmysEjqCWhg7/8zi8DFrGyfh5zVa3vbG8/rOAuYdOugEjilVZXrmtemT3iZu+FGgxLlVEodFyXnuRQPF6edlH66AJgSxcB2mkyDbnCE+5LnwkWq5PlaGg83iKqW7Kc3mtTaSqRrR3YOUw5G9bPrCG4akjgOy2Ru7WW7JvFpX8NulHXGefcfNMAlR2x3L7zXtNOLDUEmuRyK5zitm67qzFGcvwSv0UDvsRyiFDwoffRJYwLZUgsMTy4bciY+G4soyel0hNDmTOvj5QHfyBUmOpZIV2y+M81K3l9jlhFUlb9gQMZN93723E62V2d5C0zuiuyB01U1KHEUtCX5iAd+37FF1UULgc5vSXVVfSUazS9nKLP5Wkk9C8CEvVKBa07ZQqIh8WwGJikzXqU25pZCuO2hu05/irNOFKQQM7g4EmzTxglnMWiM1ijuowYdLF80Ntv/nV6qzlg/D4fe1RIkEqeITNYlCZfhFR1jGpk7h+J6pX0L0W5D5D52L/hera7x11dv0HTZJBsYgxFjyeb/PWyM1QZ0C4EEdGoHr/VYmjj7PO/MEKzV4UKbcvHyoRJq7iHUyCYWw5Qrp9jHnD1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(31686004)(76116006)(36756003)(41300700001)(8936002)(6512007)(2616005)(8676002)(4270600006)(66446008)(66476007)(66556008)(66946007)(64756008)(186003)(4326008)(31696002)(558084003)(86362001)(2906002)(91956017)(26005)(5660300002)(6506007)(478600001)(122000001)(71200400001)(6486002)(316002)(110136005)(38100700002)(38070700005)(19618925003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1UzdytxSHBkRkVIa2VHRTJWSWxqNWdyakZvUEJNd0pkUnRvNFM2VGQwL0tT?=
 =?utf-8?B?cHVCbHVKRzVpc0hzVlA2SVpkc1NTajdqR0ZyV3hWVC8wblBYb0FSUXArd2V4?=
 =?utf-8?B?cEVXQlNIZGpkT3VJOGUyb0VkSW1SaFFVM3FhR21kSlR2MC90NHhCTjFUVXI4?=
 =?utf-8?B?WHlRMkFaYlZvazFnWG14ZzRaSXNZekIvdGNHMGYvZjlDbnpqZkhmRHhWRU42?=
 =?utf-8?B?UHBYcTNkUTBrVnRYdmRwUmNoV0R2N0FFbC9OdmwzankxUnlvQUxmNlpSMEhJ?=
 =?utf-8?B?LytORDZ6ZXZuTzMzM25XajMxbkJsb3BGeG9ncWtSRGk5eHVEWEllS3Q4Z3hL?=
 =?utf-8?B?V2RwQkRjR1N5TldKbkNpUEJTR0t2cjBKeUZPcWY4YmZmcENETXRRRmtudi80?=
 =?utf-8?B?TWlYNkt4Wm40b2MvSFJSSFNlRytkeDR6QzVzSTZFRllqdHRmYlIxcGFpaGxZ?=
 =?utf-8?B?R2F0UmM4dlZFSm5ySUFrekF1aVpSK0llRHFTRFkwZktoektPR00rRmVhK3Jo?=
 =?utf-8?B?WGRzZlJVM2Eycy9KVEh3R0dJQWNDQTZncXFva0hjcnBQbVZKbm1PWVNhYW9z?=
 =?utf-8?B?NkE1ZWovd2EyZzJTVFdabkcxOWhyR1VIVzRFL3FLQSt3cWxDcDNOdUs5aTMw?=
 =?utf-8?B?VnJ6K212cjczYVF5d3JFN05MWTBvY1dDc2NXT1AwT2ppNm1CeFF0V3FkbTNv?=
 =?utf-8?B?bnBkT1czS25PUkhVYWFERDlaOGpSdjlFWm5OcHZaS1BSdG11ZXd4aUU4T05S?=
 =?utf-8?B?SWNiTzFvTVJqNlNSYjZNVCtQUVh0NWhIODlaS2Fob2RaN0RWNG03R010YlQ1?=
 =?utf-8?B?MCttMzdSTzhUVVpTWVIwYjFXUVhObHVSUjZvQkJxQ2Q4Uk8vdzJNRVZOL1hH?=
 =?utf-8?B?Nk1lYXg0cDQxdjJ3V09ybThROTdBczVlZlN3MDRHNE5WeklRUDhBRFNXbitX?=
 =?utf-8?B?VWtPYXJPUFkzTCtENnZjcWk3Slk4ajJmSTVvUjVnN3BSMW1FNHVIQUxwOGJI?=
 =?utf-8?B?K0V0SDEzRWF6RXM5VkU1dE14dW0zbGdBRTdLbWxKWkMyenVqUW8xTGFtdjNn?=
 =?utf-8?B?WUZNQll3MEU1KzZzQVNZdzlFemRGdmlGZ2UzelZ1TU80RituY1MwNHdLVm9M?=
 =?utf-8?B?cmFkekZIZU9Cb20rZ2RYVUlyb1VBakZHNVJ0V0V3Z1VzTld1cnRabjBjSVhj?=
 =?utf-8?B?ZDRJTWQrbFA2UWk0K0VKNFFlUlFPQmlKRU1yeGNwRmVxbktJbnErNEU3d3dN?=
 =?utf-8?B?enExdG56WEtERGxlbnVaMnlBK1p1RStRb3RoRXNSV2N6MEx0SERuZ0lCb2wr?=
 =?utf-8?B?NkRPZGFZcXluSDZXODc4M3BaamcyTWUzSGxxZFVZL3pHL1IxdFlVOTNaUVVK?=
 =?utf-8?B?aFQvSTl5MVdTZU13dW5PNE9wSnFSc1VuSDZ4NUhzS3hYWitlK0FxK2lHOG51?=
 =?utf-8?B?OWhXVHRRZ2VocnBPMXoyZkxtWklSRWxBU3o2Q3JBalg5N2lrdXZoeHZQVmoz?=
 =?utf-8?B?OVlQQkJOdFNHbURZNWowV0F6ck1uaHM5ODB5ZFNQU0ZYVlcwWXdPbHl4TkJn?=
 =?utf-8?B?dFNXeHlndDVpRCtMU2ZGUitrYU9oelVoblVYMSsxQnN3Q1Y4bW1rSzM2a0lL?=
 =?utf-8?B?c2pZaWRNbkpvSCt1eEM3dS9NckhWUHhReVpSd1VlSW5BaTFjNHlxQWtHdSs1?=
 =?utf-8?B?bTF2UStIZVNYNnpPUlRNdkE3N3lRNURMZDZyVzY2c1BGcEhhbXNCVm1sR0NN?=
 =?utf-8?B?UWRiWlVqckR0Mks2R0xHZHdUaVFGMEhtbW53Ymc5TU9OMlgycUdNbFpPcTVs?=
 =?utf-8?B?emE0ZlBYZ1M2NkpweUpxbGF6bVNqYUI1SDlraDNPY3poeEdPN1pBWEIrTEJC?=
 =?utf-8?B?bVFCeWlYUFNJaWRiZjI1aENpaFVIUnM4VHRUM0tjQVNVY3VuNFVEYThsZ0Nt?=
 =?utf-8?B?a1dMcnJYTE1CRlpHeEtITm1lUU5MVENkZnZiTlhmOEIwN3RENTd1aTVNWEdj?=
 =?utf-8?B?YTRhVk94UzBkNlF6V1JTSGxHakkzM3R3VnMzOWNKamFBSWNXMlNwUkZKNkFC?=
 =?utf-8?B?TmFNeUZnSW9yVXpSRjU3VFJqcTZMWXl4SFJTcEh3eVk3emRicGpoTEtpdWNp?=
 =?utf-8?B?MDBJVEN1K2tRQ0IxMGc5T0p5ZzhuaW43dTl2UnNQWFhpTFpoMkxWeDFpUGlv?=
 =?utf-8?Q?XN8K5Y0greIl50SP2Di5v/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A3906208119274F8C9644DF4249BC1C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ppcH96UxyTW1MYwq4apjQpT3bOVC4crKdsQQYaZOPAVigBThSeLVTwW35iNoVcGxLsN2LnYpWac4joEtHdRNdok+h2BikewSyDO9LeWkqlZHe8IW1Zzi706IxJm91TUn1uZSlgULU7VnvQLUEGSFich5C2GqWKyMyXti2iaKWuKVIBfxgCVg4e+49WJ7T52cjCTrGpi2Ptw2M+IjYKSJblngCCsurzB5uqPMChqui2J5zxrwx8t03mjz+FE1EDGSx/wxgzjM3p0tkkFeVMeOCM05cHIVAtFKuhOelS9d6UUtAMHKH7YiulNkiBLSrNOwT8PUqfBjgrfu6nh+0Bu+5U6r2koQvhetuk9JuzXKOn+U3FdL73UWaJOc/soBHsQmoH1gMQ5N4d8MFf3uOMAMb1BoNIOiw3ZHfAsRhzLu5MasgaWldVthg6zZdsRQZTu2Kce8e30SChdJ3RMsNRo2pyX5aVgi4FkwhKYhAx6zTC7o99eB7D8czbdJAh9Uc/VkgT0rgl8XxDym+o4Yo0FQD77TTSfmws6QZCf5BV0GFnSlhsq5fnSOwOrTgmTsoxxPRTWApIW3wp3cHhW/Egf5AbWdLJKPRkBC+PMI0koItyq4DWcm2XdomP6BNi9lOaMBzLzcTlYOlPAJYYt6ENe1CC3dNGA5Z0lA/LbLVbXvvPId3hm//pfTyIFgOuuXvq0M9tafI8H4xl4y+uVMmO9G7PBdLD0S61eLQG1aG1jFiY4F4eE0b1l4YLdUsE19QXBKP7LcVQqTDcDdIr5o/kPIxUx+mOVv63p/5EbLHiZ1lpjbKygB20no1k4zSfGoxiuQp4WGX2lbXSk4PXTyKuI3oOWqr54Pt2TBWpfNnSoaStBYw2eghgsN5OTiakRUbjhN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0652e4a-9425-4a14-8241-08db1b1f7346
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:10:09.4525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4CFj7wBGUvuDpiVMep4G81ejhjJCT+M58C7kldPNuVxsCzvyZfTLrcPjOqAEQgHCthD/UMCSfSL0vIsgH3TKp36GyPNE/SmGVa5QKIrfi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6044
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
