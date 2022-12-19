Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20748650836
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 08:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiLSHxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 02:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSHx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 02:53:28 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361ACB4AA
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671436408; x=1702972408;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UK3fQYn3XrIqsof7aWQJaU7/qqg/T+XrnU7xu+Zv0OeP2kIz6HKgtQBz
   WUUD6NK7YDgWn1NDfwTgRqjoIouAroFP7Lr+FutCY6hZPDMbuICJsM3TX
   K99YbOm/G379l7f7r+8EVi9hu2gfnJtq1JJeDfePjExlCe437pk/pZd4p
   PJXAnSQhS+qG6PG4rNbXas9/9S7j3jvefA8qavvTnHQN4Rmeoy4T9OWhs
   aCBBwm2kNWpf4+tDhg/4+EG/DhjlTKsCEgHL/F9g4DJ12pBbDfqEpwBGu
   aZvrKRx+qpOKTYgCio8nQJY0pyRknT8LeJxu9TAmilZFR6CnXJHsexPvx
   A==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="224130379"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 15:53:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXpNQfcFgk6S0CPGsLXYLE/4Mx1GWPQ+61kg5CUaz4JYkUjXQPJyLQysQJtXpQVlO7JzGzByTth+YeqFdmAeFED1D8V+UwWDWeF6GzGVgNDe1nDc37aTBUTSj33RHE0Z/L0k1uIEq1+K+MzpyBdEL6i7CwOSpN1y8ipoICIe2Kvat2BCiupL7SWII0OKidWpNRsDLorIEJJJl9H7pFarmrokmWFBf49210epfOASm23gyBGj2IbpPs6chDcZFfZMPZTa78PXejlKreLHP07FgoQ6xguLigjUwJt/hi0j7BJR3tKfhlPWWxQe41hD3CaGz+wZ4TGMJh12BQebvsp3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DQujkr/+Gg0tvjCA9v7du2TFhocXGVCJfdhwN2uDSyvohxHP2+QY9PQk77VZi0/1O3iJ1Uo3nB72iQazgVMcowyJ44gtWuu5W7duCZ4KwMtNYb7j3r9qXffPIWU6nFyW1AxpEmtAnQu0/1iSOyaKF+N3xieU90BPwwio7MNqziMWrBzNnNPn4/i7vYyHRDT6AsRq6epd3J1OeIBVKFbZzKUS8CKjhFs7xIzB3hs6Uy7rpIqFtyljegtmwbrWyUauejWVRtkGMTi61VC1l3L3/vTD+zQyOAKDwk2AdG4Z+dTVrhWLyhRL65+2MBhG2aFC4gAWjxioAW60NBJU8zvUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uWJW2I2dWaO9LJqIOAcBvVrU0ym7/pZXPsBS+IU2uC/6rON17oGTQ7KB7QzDBMEFbVD93KIw2cw9j1Yz3rOh63gj/x+5PdjWFmgFUowTlnXU3wxTKXpvDH/3Z0Dop4wW5NeAhQpqEDF2biSuddXsHoO71yKipRfDA/C0NzAvx7k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7748.namprd04.prod.outlook.com (2603:10b6:5:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 07:53:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 07:53:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/8] btrfs: fix uninit warning in
 btrfs_cleanup_ordered_extents
Thread-Topic: [PATCH 2/8] btrfs: fix uninit warning in
 btrfs_cleanup_ordered_extents
Thread-Index: AQHZEYt+l0BBHXvp6UqdrZpwGlghUa502twA
Date:   Mon, 19 Dec 2022 07:53:26 +0000
Message-ID: <f4600091-3acd-1712-b5de-bc184e5ba24c@wdc.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <8224d05027554e265bb92bd4a7862950e6c7d224.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <8224d05027554e265bb92bd4a7862950e6c7d224.1671221596.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7748:EE_
x-ms-office365-filtering-correlation-id: 72e09a76-84d7-4b15-e490-08dae1961c7f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVzaZw7jMACNZAuiUfbCDhuAX/f7YYDgzH6hVvMe1lUn/LIJfwD5WtG7MlhHZPmo+5OPdvNUH9cb0ioLKczCv0yCNWx7w5/MesTvShvizaMkhtp7HrwN9tkEOKQxjFFjMQjkXZ+S8FBzb2mrExsB9suUW2+iofZ58Tue4tMJR+NoeFEvNR102K4MD0QOxx9DKWPWBKbhXFiwzOUDtRiS2hokM4+a7fSZMeJ4tUaJ18PVRJhwPHTz4fxYQiIPsVj++2PZ3LivuRQk+pa2SD20MfYBn24NHd3xsTD4HdB/YuXRHxXSOnrmTC4KVS3Tza517aMgGYTEC2erW1WOwnw9B7s+4nHqxr3xZGpv2ToTOzsxXtGOrA9dPSR3TdKTlKKOMu8rYFgyJKYxS9bECUs0iFlS7Rx4OcoIJ7bWNqytqfbPuO9qnyiDXwVgfEP4SIe6Fv4hglukzGR3/DKrr8lJG5sTXJyFsEPqjCTu/DvN+fh0h9G1exByXYDl6EvzFBNF8Pu7BO/BoOvH80DvV9GK9cBXoPjfB7MPnOVSFlNrQh+0jUjWmM+9TOZG7aQl55nDZDdA/nu0eAIQ0t3H1AJfTqnaE2j8B0f/vmMHopRkPX1UDNtKbIcS4qxU65No3N+atHscAX4yPc2sP+JtbvC+9sIRkS/RqZqixC/pC18YQPSuJypVn3CEWH+s8uscmLyinJy+5liJf+M30IkQbaOiEVCBp7QIo4OpMaWS/Ces+LBZ/9yi2KLGpoIIepYUhyH1GrLJ9hyAgSQI0W9ltcrFNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(31696002)(2906002)(38100700002)(316002)(19618925003)(4270600006)(122000001)(66556008)(64756008)(8676002)(66476007)(91956017)(66946007)(66446008)(76116006)(71200400001)(110136005)(86362001)(6506007)(2616005)(36756003)(6486002)(478600001)(6512007)(5660300002)(8936002)(31686004)(558084003)(82960400001)(186003)(38070700005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG42SEZOTFpuUm5CcktNaDhVcGlaVWQ4ZDB5dGprdFlMSk9CL0xVYi9BVVdJ?=
 =?utf-8?B?V0lTZGtmcytNd2NLd21aMnhNcnpLU2hBREVVNFNoKzdZZ3JwWUJkUEZIZ1VT?=
 =?utf-8?B?dncvdGs5YzFER2c1TXFoemE5WmpKdDJQajlFZDJuOEo0dExNaGlKU1dEY05o?=
 =?utf-8?B?UEVKRG1qZzZ4amtDbmdEYnoyRGs0UkZBK1BIVWZYcUNXT0NWYmRHY1BsZUlP?=
 =?utf-8?B?alZpOGVEWkh2SzdvU0h6ZWptcU9Dd2FlRUxxT2lWWGNvZGh2SnN4bXR3dVF6?=
 =?utf-8?B?ZzAvemV2ZThzREhSQnpxM0w5OS81V0wvZVNwaUdSVTU4QVFyV0tJNnN2d2xS?=
 =?utf-8?B?L1JxZjZoTHg0M1lGaGViVE8ycW9ILy84RTZBeTJsOFB1MDBrSVlZK2NlQkF0?=
 =?utf-8?B?eTZGcVpwcE51NnVydi9SVVlubjNBTFEwTzM0Z2JRS2p0VmJVd0lTblBQbTZa?=
 =?utf-8?B?aWFvNG9BL2o0amh6aXhnNHMyMFZKaXRJNXloWVlzWHhOYkQyQTlCV1FEeUZ4?=
 =?utf-8?B?TkgwQ0pBSFc5SjBZbjY3UDdwWWJVMFo4bWZsTnA0NEljMmlUcllOZDlaYmVY?=
 =?utf-8?B?SitUbzJsVTNMKy9hOVhqT3ZHWXhCY3lDQXNDTDBmVWFDRUR6S0hTRTQweTFI?=
 =?utf-8?B?YUNHTldxZ0dGSm1uSGl1RUhzSUVacEx5OTVtcEFoRDRaM2JmQng0K3BOL3c5?=
 =?utf-8?B?UzIrZUtPaVRHUzBKc3RaM2ZYV3NwcWJRclhOMTQveW9EaTZ3aXJKSmNGVGRv?=
 =?utf-8?B?L3Jvb3pyRGp3L09RbkNIbEN0WmF5Y1Z6SkM5R25IVTRFenlBM01yRHo3ay8y?=
 =?utf-8?B?b242ajVLQk4rcWM2ZU9QUTQ4SFhvb1N5SDBJQVNPNmJ1L3cvNEhqS2x5Zk1B?=
 =?utf-8?B?dXZqZDI0dUNoMnZHNmZCMC9sTmR5anhTSkVPUkV0Y09sclE5SVBCTlRvSGhX?=
 =?utf-8?B?MGJ5QTczTEpieXFTNlNDZFZuVGErWW4vYW1PR0RUTEdHOVBsWUxOUW1VVElu?=
 =?utf-8?B?ZlBDbVE3RlBtYmZaUlplWkUxMlNsVGRuaDFuelpYc2lkMDdtZ01oL210RUZM?=
 =?utf-8?B?UUhVYSsyd0pqTDdCY1NOLzkwdWl0N1ozQy90ZkxPS2s5OEx5ZCtqZk5FU0hs?=
 =?utf-8?B?YnRZd1ZLNXZ1TCt6NFJtVlp4UFNnc1JVRHJkdmxWUUJHWWhZNm1aZlJBZURG?=
 =?utf-8?B?VlEvczVHKzVtdmpRbUhwRXJJVDFzcTVwNVJyYTExYURhWW9yaVU4aCtFUWlp?=
 =?utf-8?B?SUZSTEwwS2JVSUV2M09KRHNrU0FCa2tGZUVVeXk4UTZlazVFbUVpZ3M1ZUVK?=
 =?utf-8?B?RXQvNnFxVHpWVkhYRll0aUQ1TFdPejlRWGljay9DVTZDektpbEpMSXpnZEQz?=
 =?utf-8?B?Q25HYWt3TUZ1ZXJxRkRmRVYxdCsyREFraWZMM0xOd0VlM3J3TnBmSEl1Unkr?=
 =?utf-8?B?bGZkTGRja0lDT2RQTE5MVW5wSnBXTTQvaEdjeXJ3QjZUUmlDZWpkbU9saVdQ?=
 =?utf-8?B?WnlKUmtYL2VFamVlMFVFcHBkb01BU2V0ZURHeEhMeVlyenUybUl5ak5peU54?=
 =?utf-8?B?TDFwcUViUk5NWHdUWDloTVBDby9ZRDdyR2VhK3VUZldRWUltSnJZRVVqZ3RZ?=
 =?utf-8?B?bUIzM2VGczF5Qnd0bUxvNnpsV2Zpa1JQQ3BsdStqaUIvRlc5ajkzK3ZhUEJN?=
 =?utf-8?B?WGtWT1JsRU1BYU54NEk1VVpkZnA0QkhYRDR0SWVaSkY2QUUrMndCb2NTSEZM?=
 =?utf-8?B?ekp1TkFEQldhV3VTSGZ3RHRFWlR5ZXJvdFdSRHh5YmkzcnBBYVMwdXZiMkxK?=
 =?utf-8?B?V1JlVUEvcnZIdXEvZitpZTlOMjhiR3JBWWJuR1d2eStOakxKMmVkWW5Lc1dv?=
 =?utf-8?B?cmtPT3BTbzFBYy9tSHRxaWd2cXpLdFYrVDZJcndxbTZpM0p1R0l2U3lIMWc4?=
 =?utf-8?B?V2VOVnd5U1JlNFgxam1vZzM4dW0zeHJRTG93UTZ1V3MwQXJQYjFPVVczMHVq?=
 =?utf-8?B?ek5RQ0RndGlRVlJJeHUxZG1qY1FkUTdPT012YUhPa2RucGNZSjkwVUJkcGNS?=
 =?utf-8?B?UnZHN1VpRUpWbmIwR2VDMnZOaFExM0hDenpRbmFEK1NvT254Wm5rSTFIV09D?=
 =?utf-8?B?RTBSOVp4V1F6blJPMGVDSnBRaGRxMjF2a0Vlei9PUUZweG50cEoydFJWZ2pj?=
 =?utf-8?B?amhsWWVPQ3c3MWVHc2tPWGRQdXh5QzcyaEwyellqcUZvaVVhbCtNNjNYWnpw?=
 =?utf-8?Q?iU+CO4NSNvGOiDfvaIsfWrK9riUYv6Zht0FFMeixYM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <510743E44B1E8147AB24C6D58728ABC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e09a76-84d7-4b15-e490-08dae1961c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 07:53:26.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtBYeowUkpbqm0TWtW2XelpMX2n5Dmg71PKQ6O+yI658pW4UTTQ7c5EueSlPvaXQrIpFINOqGUP0qpVEJxNdycZVzmUxV3FeUg0W+lnR52c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7748
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
