Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310760F46C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiJ0KEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiJ0KEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:04:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37264F3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865068; x=1698401068;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Xmo0CgR6kJ9SbN5TqGYC+H7fnTyMUQ/jX2KPOyYiBSQZLdznW5GiWBXO
   RLm2L9DvlC0w7LCSnD9vO2AnaQvmu2R+tA6OD1mn7agwO1ztyODfTshrU
   62YZ+seiXREpZg7IRr7tAV4c9BeUDE6uHeKBBtaDpv0Sw2E+JuwBlbPRq
   KK6sp3k9RYtCaCisfTkYPKt0lqxTpt63tnULC7/DnvoZNJ6Vy13H3tL2z
   DH6Vq7NTsCTy3lOgJB4+cI1VKlQN0sey4DRDAR30h6Cyy9FSN5WuLuAUp
   mwKk2zRii1qdh2oBGTAGMg1h2Te5jvB0LE+HYIYUFvzStI9VwXf3oRJoW
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="213161076"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:04:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGkV5xfmrxRUFR3+btpDINqsx7K29NMw2GGV+dOppaEQINY9kbknh81bcZkgiBWACGTgscoECSNivuc1dy/y11M4oEXXfLLgA19gmNMwX/kRW0GSIfmuTrtbhPz8p/4spbCyar90rsqbYDPTNbgW+M5ENebhzjHPgpm8aZl5FacGcg8AFMeQYti64otrZ5GRFDzUkjPECgSSgIF0obLofrF5Ut51dxAx5/3iE9ZLmUioPcDsZY8A2XNHzXT3VoQsjpVH2NpoNVPeuQPms+tGjaHG5kLgceYWPegdC6kRTsjq55QOVv3EmpjJsPJVCq9bavAsU4ei7AB7AJvTJ7fy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G4H3ny56Nusx2P+p/blyU06fKDH9wm4qyp9ypY90CAhZPiRxlwVE4wS17IAL8tzwuThUp0TjMMrM6fsGgep2AZOZMsRGaYQGQbIX3XarLe8gIXT2IGG4f1kHK/vn5ZnQMwaJzoR8lxGqZGWxqlDuB2L4mXG5CLFqVUxCLldRD7gxYogCe9m6mFL0AEacOIJONM5Ru1xZ930+A7w7Wtr7y8NVOSOH90eTq+MjXjGgPsdApufIV2DQOW0WcDlSk9rNfFAOkeT2UNVGL9Rq0+Q8N1wjfCTl9d8991MMt3McpjlYL6BGu8HHBnbJSYQznpVdrHHIGusZK47ObzGBwu0L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DGwdNQQ25QWg5XWEQML8KeVuBatP0aa62zudSRFCKO2U8Hi6m1mrvu/GlezokYvXWI4crnemA8511qdW+1Z5Kzz6ZiIy2ku4UroHFksqNcjsk7lszsjtowmlesScLeR0DIxHE2/aLk3QEurr0Tmk7Hx5V+b1UtQIU64aX0h+NQ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6749.namprd04.prod.outlook.com (2603:10b6:208:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:04:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:04:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 15/26] btrfs: move file prototypes to file.h
Thread-Topic: [PATCH 15/26] btrfs: move file prototypes to file.h
Thread-Index: AQHY6W7bv2YszTrRgE2qotuLw1uNza4iBByA
Date:   Thu, 27 Oct 2022 10:04:23 +0000
Message-ID: <579b71ca-fad8-d89d-c3a6-8c8f0ff6e955@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <c8a2baee43e9dfeb85c5c028b1b1d7b6f369d5d7.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <c8a2baee43e9dfeb85c5c028b1b1d7b6f369d5d7.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6749:EE_
x-ms-office365-filtering-correlation-id: 2a5480a4-7415-47a2-9461-08dab8029fcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmBNuAUa4aWEj2uqaD8xE1FK+MZQZJcSsrk0ZiHsf+yZdhVYl5cWU1pkUS+j6U0fHAG42QbvLohf4sanVijohhvKqHTOLLtbpsyCRiNaLQyYX5Bb+oqwEDkG0haRicoavYeeuNrWHlujkKME+rwKTOfAn3plowIXS/adCLFKE2GJ5dFGVfyPTj35NbgUQNMfg39rCbVoJ9QNW+KkdC1jMg4Xcgkvl75ToQiR105VGtUbI3MapTcJ2LChpGMRjkf27bfg89uKTdkNnZ8hkzSeLgRfFD35j/xydIoydt56JzSQkZ8xzAH9n15r6cOG1RwRHXRV6ht+nUEnuuKV94XR7iZalz8os1TQlLNx+y1RmJJJa3ctubeK4Lre3gUTuunF78aA04Toi5WnEWbu20anAJN/b7/fHsBYkhu9teYYQhhiShuaybxNgrmzaFbYkreqNj8EgDn5gNOOOkGZyEadkpHpc5vFP0jB703EUMWIOKrhkzsZoDS0Fa+RuurUx/s460OGooK2yAWIqDzPMun/71M9e+WF0IKtoItof4QTMfF35Fxi8yv/iTO+PL29upGSWE1C+2m++VuXragDtHYXisnIfeNxdN9JMvFPYLEOyB6sq8CCDTaNbB5Zfyi8iEtDBRQ3rrrmHdUvTopQr3Qi9z/9gkMTL9JIiEaSUZinm19PCV59CtZrmhMAGPP6JfvdoRgUE3ZliTPG+xdTMc1uF9bVh53d1EqwOCjVmn7i/Rtpj+8nZ18UzNHh0xjGOWewccQH2gKBCN5kBx8fRn+wg3KEaOKx7TBKd98Ux2S0l6UWtoL4RpOiUbhVzBVSSZxWE9cGKukHoVxCbftgsK0gsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(38100700002)(36756003)(558084003)(86362001)(31696002)(82960400001)(31686004)(122000001)(38070700005)(6506007)(19618925003)(2906002)(2616005)(4270600006)(186003)(6512007)(26005)(91956017)(110136005)(66946007)(71200400001)(8676002)(6486002)(316002)(76116006)(478600001)(66476007)(66556008)(64756008)(66446008)(41300700001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVWL1UrR3JYeWNnSytETzljT0ZhQmREOXNzbk9xdUV1cXhEenFmMVJRdGJT?=
 =?utf-8?B?S2xhODZndklyTVlPUm52dzg1clVCd2piaWRMOXNwcnV1QUhpT2trSmhZaDZ4?=
 =?utf-8?B?bzZuWGFmd2U4a21sM0IxY0xQWVB5MFpiZFhEMVFwOUhaa0JSd3BJY3FlaThZ?=
 =?utf-8?B?a1V1N1F5Z3ZqQUNvYkg4NXc2Wm9MVWhPTVltemR2QWdSNUNQbjhXcEt2NEhT?=
 =?utf-8?B?QVhDNlZURloxby9DZno2L0c2eTBxVzkrYktFWlZ4MlZuRThqL3Q3bTlHRUVD?=
 =?utf-8?B?eDFHdzhkaFgxb1RuVUcySTNYSUZpdEEzM3ZlZnZBb0w3SHFkOWlacnpKOGRh?=
 =?utf-8?B?RDNxOWU5T0U0YWZzRThTREgzZXNMY0lPbENYc05tZDZGWjgwU3ZBMFFCeXY0?=
 =?utf-8?B?ZHB3NHQ5UkVRZkxmVTFWVEJFUEtDclRzNEVrdzIrL3BUQnU2dnFUNzNHcFpI?=
 =?utf-8?B?aXFCaFdGb20vUmk5QURDbDRSbDZpOW1KbW9LZFN3Mkd3NFI5Z1d2SWdjNHFJ?=
 =?utf-8?B?bE5LVGpLYUpPNEtTL3NjWGZCMnZlc1ZKZzU0NHNxUVp3VVBvNDBUTStkVVdH?=
 =?utf-8?B?aVBuNzVPUkZMbU4yKzk0eWFQVzBRZktZWnNRcSsyd2RXSnJDNWlSYjFkMFBQ?=
 =?utf-8?B?R3RNMW5DTHF0UUc0Y2ZINy9XdXU1UDFkUlFIcmtyMytaU2ZvMHM0RzJIYzNs?=
 =?utf-8?B?YUw3a1N5WXB0YmNhbk1hOUtWdzJjaTRZcUFHMHl3TGFwRXZCcElIU1R6VnJO?=
 =?utf-8?B?eWlBaVQraWVCb2xzV3RGZ2hpSVdDbGN4Q01aM1lkd3hDTU90SitMa2s1QU9n?=
 =?utf-8?B?TThZZGljSU5zcE1lQ1JZNUxMNlFRZDlYRi9HWTJmdFdJVmtHMHRGcWtRMmFo?=
 =?utf-8?B?ZXQ2L1phMmZQYy9kWGtkSDRONFNvSXI4NmE4dHBCbEpXaytZYWt4R2M5azN6?=
 =?utf-8?B?UWU2TEkwb3Nkdkw5cW9mS2xucXBVYnJLc1ZPT1Q5SUJ0MnZiSDhXWnczVzQr?=
 =?utf-8?B?T0dMOVJUTCtyTW1HU3lHanU1UER6UkRjb213OVVDVUtKMDlma2JHWktmcWl2?=
 =?utf-8?B?ZEdBakRNd1F0WGtOTittWXl1c3daOGJhc2hrSW9wTlc2L05VQXBQNWJHTmt3?=
 =?utf-8?B?VXlvQ3k1cWw5SjhwNUltNGdLeGt6U25razhPSDF4WUo4dC85Y1l3T3VwQWRv?=
 =?utf-8?B?cld5UEZDOGlWN3VtOWphQWltR2xnYjVUVk9aSVB5bWQrNWNRUnduWXFJdnU0?=
 =?utf-8?B?VjIzdGhHUzFtbEZVUmU0VHQ1dWphT3liYmNEeld2cXowNTRMbmlJaWRXbmE2?=
 =?utf-8?B?Q0J6QktCZ3VkN0hpSXYydjlxcCt5WWxvQjZHZUdPcTJGaGQ2RFhqYVVoUnBT?=
 =?utf-8?B?Ull6b1ovY1FlcTgwdksvZktTdk9TcUFWM3ZSOUlXTngyZXZOdkVJM0xxYzlq?=
 =?utf-8?B?Mmthd0JzY2NkcWhzUi8wRlJOaDM3OXE5SWUyTmdDdUpFREgyTGJ2WlBxMXlS?=
 =?utf-8?B?cHR5angyV2xBbGhEUUJLMHhRbm53SUZqQm5qSlJqOWhHSm5NZlZEeUcrTkVQ?=
 =?utf-8?B?eVc2REZKY1BRaWNnV1hDTldncUZIbzVKSUJ6MjR1TlF0WG94SVgxOU54UXp0?=
 =?utf-8?B?QWRRL2JtWitFd1JHMHBNa01tRExSMWs4M3g1L2ExNUpremdDTkhYdTZsbGN2?=
 =?utf-8?B?Q0RPaHN5cGhpWjBRRnZEV3pib1BFYndEY2NjT0VDcUdacENhU2p4TmlnQWRh?=
 =?utf-8?B?V2RqOXU2UW9jNWFPd3doQURhdzZuMUFRNjFIZnB4bmQzTzNzTU4vMm56elFC?=
 =?utf-8?B?MGw1ajk4b1doa282TlpZdnpsdDIvQjc3OXZGQW5COGxZQjJ6VjgvSVBuMTMw?=
 =?utf-8?B?UU1hYUhMbGxtY1hWMkJPcGxYdUJodkNkUkFWSEM4QkJyWnJVN2NDUm9OQzBr?=
 =?utf-8?B?dzRXam81VGMrN2R0YzZsZ2doQlZiRjk5Ny82dmE2bzhJTWlMTW0wc1BGTExE?=
 =?utf-8?B?amlOcGlra2plelJkLzc0dkZSRGtPaVZycUdkT1NLdkhvTDkwcnhQLzFhaEkz?=
 =?utf-8?B?cHV3bENTcm1qSWp4aWcvN1JBQ3lZZk5BbDZQVVRDbTFPOG51MWV3dFBqNEgz?=
 =?utf-8?B?dWpRaHA2dXJpbUV6SHlQWmFsSEI0MmIzNVI5WktnN3A1c0ZUVGNnOEg1TXgy?=
 =?utf-8?Q?kHdXnag/8eydMtGlV9YDSrc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D4476DD5B4934B9EFC1E1F84A79508@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5480a4-7415-47a2-9461-08dab8029fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:04:23.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nmt67S9LOm2y3e6yHIROzJ9kvpFKVo7mefak1He6picpAJk5kGNknMR9JX0cNY28DI5gmE8YTr0rQ8Ukm98fi84+XcltB7yEDQdCDOO03Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6749
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
