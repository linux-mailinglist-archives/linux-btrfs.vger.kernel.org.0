Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698976B25BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCINql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCINqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 08:46:38 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F276DABB9
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678369576; x=1709905576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=k6LJRsNZ9A6YPLExm8FRoQlN6uQyQ9SM3yRiXAUfjB/t1vGt68Ch/w8g
   W14/mBoyUEBD9T9z0D/vNqcweTRQHlaYE7W54BbKGxem2YpvKBtcdajtK
   UVvMA8jUy+/1z98Yo1IG4PqtQbf2mXOeS7kqsQKejrGcm/YpUYlygZLSd
   7KitHNIRon7Hvcq2MjmSumi7hBbMnfZe2rCc0C5cWvLEFyvgb1tS5dYb5
   1ezeHZW3nFtS7ZbqddW2zubKTJwbwADyhSyv8Mijp6SMx3E155EK094gY
   wsKYsnWBQ/xFD0/azX0yNDAgC6ITH4MwHgo+aLEMNzfCFfC/4vSmU3ssp
   g==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="230180081"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 21:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTkhivto9XY4S+9Q8iSawISFgc+TROJpk6WqzHyOGBBnuhXUav4KSOir75BaTvj6apq6RbWq6Xsc+XJW5I2hyfPnTexbbe15REyD+mn/EBvSx+Hj2ThHR10ILbphCC5jsh4oRmHFleft1gJkYVgtAD4U2zdQV2DSwrOLRyffltnJeEH1Ddjn3IEx2sEKjkhJbhOSXwCB2TwCHk9eEEG+YU57wzJGpj3whgcXMlqk/SOd51D9adxDtJuFB6qZDxvYhVUBt3LM41tA8ZGb76WSuyLlES2tmY65U7hxBkyTSKk6Gqp+mdENM9CFMyxOr+PD1kXAn+ceW6s9PRjenA09vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BKz6vlaEr9RkzI8hROVQ3vNSKys2OK6EwtJhZETADlH5I40zwuccJZMOfVo1anha6OVDhUI8ey/OHOnnlSBzleHzuQ4LY8WAjb5m7M6ocx/EOX9au3PJGGVw5xl48tLyeuxBaeDgTt6O7Mr5N8TpSZdr697a3IY78PmfayuCH0qWpTQpH6RC+tTZoYr10JkU+Kx8vE1xE1A6LDUarzoOlXqpKHwjHNkkU4xf3cQPWrBPiA2lDUvGxSmDejHfgAwcjQSvp1lK/1/u3843+d2fLdH03macYl/735q9m+/hcVZtjPTAtRHXZQIDOyP51weoQr30+rakL2KLcgA++9g2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JhhsCEOehhokcy9r+T//TupGl/dZgiOz7NaSoA8RZzBZZfcgQQGVLPYwYNuCHl8QY2NLZAVu8jQ2Gtr+3b4w9/SrYC59XANwSfDNIaK/jXDfX4Ph1agCCjnvwFE7vVKeo4yOP9LzaVrGDlnqsgTPBcHoseyBKMcawjkeEeZQoC0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY1PR04MB2172.namprd04.prod.outlook.com (2a01:111:e400:c616::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 13:46:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 13:46:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/20] btrfs: move page locking from
 lock_extent_buffer_for_io to write_one_eb
Thread-Topic: [PATCH 11/20] btrfs: move page locking from
 lock_extent_buffer_for_io to write_one_eb
Thread-Index: AQHZUmadw259D78JvUS52QmdEKWxwq7ydjgA
Date:   Thu, 9 Mar 2023 13:46:13 +0000
Message-ID: <0be4fb66-af79-2e18-31a4-ddb87b7fcb70@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-12-hch@lst.de>
In-Reply-To: <20230309090526.332550-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY1PR04MB2172:EE_
x-ms-office365-filtering-correlation-id: 915f8e0a-8086-471b-c192-08db20a4a5f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGjPz2vf9OUVDc4wXvhyDGvmRCcyz4Oh1B4w7SGNhC5EfQGhcQ8TGb+S3KS4O5wxPKAjnQGaYFdT0hg5QokFf6Bvzgth4jHOxlgnVVR7NfuBRLYP8PUkDA5UI2OoT5eSa5HgOlC8N1kEA79t/Iofea67KTijV/1Kdnl7yD9X5JNloi0MYTfLtjWqNkuyZKDpMdV5zaCLSWXkNCnp3v8liVNhAKQu7USb+xBfVokUzHiZqYmzhbglzj0iVn2dRequx/oTgZac8lncV2dZIs3hlLNEL1EooVol2y9zOlOcJ1McMgQ+ccYlRdlCpfkM/VsqdS/6ssa/pJJAFTvtGaIHERjNjsfE7Y15hh0kp86q2Xr8oXimUo7/8cZQD/ygQo5x6tPElHxveJENMSSZmwNdvAGR8vEdY4Jf/tq4N25VbYLU/5HCqF+NhcxmZoiDuKY9cT3ZQ9d+vPn3jtl5h8gaPE/D6Xpqln71XAzR0N2LUMCxfMVIvAxdYrCRjxu+S6Dbv/U68NGCDlVzAbruCUuvizpvcmktdsAxCkKLASjok7OgiXv+rdgE0L4AqCa7R4leU02A1wrLhH21csGLDo7f2JVZ/ueQhCAPMjIleh3dZVyXZzhjUqB4e5NoW1VW/yncAp1Labc/ADoA8uwbv3IT9PLcu8xqTThQkJ/3o163WKSzafh7AVLHGlsCMyY7WW/qccSVDnq0+T05e1G7XUrirmD59X5lylYTcI3YZPIyFxNL/6srQMwLffa1uazgInq2yQGSeQ5cgleLnOQ0vNu+AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(19618925003)(38070700005)(31686004)(2906002)(5660300002)(26005)(36756003)(8936002)(64756008)(41300700001)(76116006)(66476007)(4326008)(66556008)(558084003)(66446008)(8676002)(66946007)(110136005)(91956017)(31696002)(86362001)(316002)(71200400001)(478600001)(6486002)(82960400001)(122000001)(38100700002)(6512007)(6506007)(4270600006)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjBwekRGWjZObHVIcnZpQkJ6NCt4OEo2SkZnNTJiRi81NDlJWERUeTJQSGly?=
 =?utf-8?B?YjlkejhydGZ2NzJFTUlxOHhwZ1MweEdUaWFCY1gwZGk3anVOOHpNQm9nTE8r?=
 =?utf-8?B?OTViSm9xbitWeHVyd2tYMEFaZkhXczdKSzBtL0ZDZzZ1V01raXBPRlBrQ2ho?=
 =?utf-8?B?TnRURHJjeUFtRUlDZXcvVTFET092T3ZQK3ZDOXRLSDJySXRNZWRyQ2lXUTN1?=
 =?utf-8?B?bktWdE42UlZxZjg4SW13UTV2eUFoclU5eFpveHJRNmlKSXZRdjg5YVBvNGZ0?=
 =?utf-8?B?SlhrRzFCYVBNWVA1anR3T3lONVJoOXR0NTMxVzEwZkNsYXkwZ2pKS2JRYUoy?=
 =?utf-8?B?UzRjSWdSSmdzNnZ0TE8rY1R0QjdlalBXalJaYzJaQzk2NHpXK2l6cWlJN3kv?=
 =?utf-8?B?YktuY0ZWYWlwVmt6d2xNQmJoLzBkSnpIVG0yT3orNmhURnFnWG1IdWhRbFVT?=
 =?utf-8?B?cTFUb3hCRjU2ZDhHMzZ4c2kzeUdENzZOSUVyRy9QMzZjZDFOR0xmSytzNXhk?=
 =?utf-8?B?WDNVelBIWGI4WXNUTnVkOTFaOXM5dW84U2JnNm50WjN0eklKbXB1cEk3S0NG?=
 =?utf-8?B?VXFKNlpLenBrdmhIeGIxaWJDOWkxcllhRDVYQlpWNFBuVkZpVDBTYjIwVFdx?=
 =?utf-8?B?ZlpiTlAvSzMvVVNQUHZwcmhnMENkSVQ4WUtYcU9DQlVrYytqZTk5MnZINDRi?=
 =?utf-8?B?bzcrL0RTR0s1aHM2QndGSU9UUXFtSWxKa3NOanFacXVhcW5qQTJQTFlMck1R?=
 =?utf-8?B?QlV0alpDcWM3RUEvSE5lTXRWREU0US9Takk3YkNVOHJvaUtmMkZUODBuY2Ew?=
 =?utf-8?B?b3hIVzlqLytYaHIzVXRYa1crQmo1SzFYWlRPbGk2WUwyYzE2M3Q2MFgxY1JX?=
 =?utf-8?B?ZUVzeHJqTWk2dkk2T1lEdjJvbjVUSTBDYjhUTUJUNThqdGZGVy9ZVlArV2FC?=
 =?utf-8?B?WG1Wa3JlMDJiZWYzNHI0QmJPUVlQa25OaVh1OEZkRUdHVEl6QzdTZVB1ZWlN?=
 =?utf-8?B?ZFM5MDN5bGxlTFptejdnakdIUStXUnM0ZG5MS0w4c21lbTNxbFlRUm41SmdF?=
 =?utf-8?B?K3FRY3phT3JWTWc3UHRLYVN0QWw0cmhZdHVzQytxUEVnbmpHdk83SHFaVldr?=
 =?utf-8?B?bkpCUTVCVEJ3V2NaMzVrYk1JRndoa1RRS2tLQnJlVC9aQ1BPQlpybmhXNjl0?=
 =?utf-8?B?ZGx5elRnR0xXZ04va2lZNlMrTjVvWVdaNk92QTBEc3dOeGVPVjE1NDNBUWJx?=
 =?utf-8?B?ME83bGxweHhobSsyQVkydFgzUE9lQmRUMzI3cGlqRTNVU0JXWUliRlpBNS8z?=
 =?utf-8?B?NVY4RlI2OG9vV0NDNGswY3E4Vlg0OGpTTVVPdTNyUDh5bDUzZGYwQjZCQlQw?=
 =?utf-8?B?SFpwVCtucnBPTngyTkgvR05TcUhNUyticTBuZC9Dd2JpNTJQMEk2U2F4SlFa?=
 =?utf-8?B?S0kzM3ZoclgvVWxTOFFtTEVkOTBoQVFNNkVCeG5MK0NpQmwvSEFzYURpc3h5?=
 =?utf-8?B?d1I0NkF2ZGJFSDhmQnh4Rm9sY2hzUTdGNVY5cmpRWnpTRkNVUmtYMjd1aGdO?=
 =?utf-8?B?cjlZVGdKZGJPaVljMkg2aGl1eXBQcmJlTUdpclpXUndjN2Fmbmx2SUllUDFy?=
 =?utf-8?B?QkRiOWNPZ1hOazFPTzFnNXRHaGQ3d1JheHlnaGRqMUhaeFhCbThtVjBzYXlo?=
 =?utf-8?B?ZmFFNXNnY3pvTGdDWkxJclc4N1J6YUhMSmdrOUw0dlFUa0VKOVJRL3ArUzE0?=
 =?utf-8?B?VVFZQnl5UEZFTnRFRFZWT2NSTmI3aHZyQ29YVE84ZWZHRzI0SjhmTGJRYVRK?=
 =?utf-8?B?WUd1bndEZlQ3cXVFQmZVUVRsUjVOcE1Da3E1UUlGMkFsdG00OUU3b3ZvTDNV?=
 =?utf-8?B?Y1NwY2VqWVVESGZDUS9uWGx3Y1U2ZStFNzRQTmpLOVdTa0huM2lVNE9lZ1NV?=
 =?utf-8?B?QWZwTDdXZWROVzJUL1I3WitXdXRJSlpUd3BqSDUvMnlqQmVKd09nZFBDVG1B?=
 =?utf-8?B?Zkh4VG9IOXNKaWp2WXpmS1VKdjJ4eTQ3V0tBd0xiL04vaXZHdkxwSUxIMEx5?=
 =?utf-8?B?WlJvUWlraXNPcGc1NnJYV05zd2V5c0s5TzA3RmZxdkVpdXpSYzVXcGVTVnp3?=
 =?utf-8?B?TVBHOENEQURyaHQ2ekJsd0dkNXh2OU1sY3RzUEpDTmltTWRQQzljYnlLbGxj?=
 =?utf-8?Q?TWCigHZu7ceISjRVBgj2aAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B09B8E61C9FAC458CDF0F9F41E7A473@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u7eFtmaY3oco7SI8uxyva3pa72/BygRgOS+vrwggMJXU3FISqb1Vn+rk5+B/6G9nlC4kuuCsuV2JSWb6SfSA6ZexXHs5RE55J9EubDSRm0abpo36HVdzCdNSfjxnxkQlHStv+Dlt6Y++9BBODNfmDTR2N9nTnwL55ZoXPGTQq68i/D/+lBscAVro8SuOgqWtbEuTf1EA0ZoJEsdfPDBRCyfh+0h8v0VDE8Q8tE9bwE9AXWB7VekAyVh8G76WSu1nv4jRfIYU6YLlYhOWzyB4nM3h86/KuXZUHyccQoxSp6Si9aaBDoqNZzlyvPAbMCIOtiLDB1y3eIK5ySspBXZjgXbP6XsIc8XSone4WQljWsSlm9hdMnEKyA+xwFbtlcSroGxAxjqWgrIw3dmE9qMRR4AddbGTDRdxE3AS6fQ355HqeoSfkwR27OVqg3XF/bH9raXxvosvWZLEEqTQwxAklb0ndp/hv25T6k8id6IiPpbI3S21i7G33KRCiSkI0xsUrunl0i6IBkTLkxj3UMfdg+SNWQVhN+nbxik3zadLDq+Z2tRIHlkMVehe4e/P4h1skSAeHP2xTzMQV3hPJvH45ezRp2l+ApOfiRl8jHytDrQEgz6WazgoMf1dua/dQlYE5wcqYAqcDBlvCPukFY8JN1UjgnQA73S40t93qusr4m3/WLbt2U0J0KMIJ9FiaOuYETq2+ml15UMgFBz9u8+yzAdOyk2qn/31yf/WP+a6VjVGYT0Tzyoa0MffHK6APWcyDyrY8hJSkYyN3PBCvfD7mWF/Q1btSdC+Vr1upN85BgN4JdOSp0IFvOWMUmLoRW2LNtyWXjT1fFer25489R/iFpX8mipvbNcF8UAwFcI0E2IqbZe7fZ15GmzJutEvppZn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915f8e0a-8086-471b-c192-08db20a4a5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:46:13.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZP2E9p2/sdSiIr2s8LR36G2trQFWLU/rqilXxB2pk2T56Di24R80GBQ3XvdoKe4LFmNXyBYsIgi/94TrgINpVPc/8d3ddp5uRx1/jIp4VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2172
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
