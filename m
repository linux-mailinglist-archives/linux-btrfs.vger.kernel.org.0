Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAF710BBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbjEYMJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjEYMJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 08:09:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68ABE6
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685016560; x=1716552560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nu/u/SDrqwxupDHnPJJZW4Ea7SLAUiV/kyuhzngUm7mSM6iHDbE9KVDd
   2ABVTymkIJ10GkkIT+LCIRI1FVb8LopAGqGCnr3Zu4u8/xF2ItisNf8Pq
   uGk6hQJ/iDrS0pq7hlZ7XvDfWg2SvSDP8aKt1eFygLqDH0h2fcYSsJ7uR
   1NUqv7hhuZWoTnhmY6m0PuPisGD65VBTWqBs9ouyhCx38tgRNBneQMezo
   /hTGj3lMqBJOnTbWAV1q5j4VtuP2Amhex/M7dnTcC53sXynX0eTbtiTTN
   FXQ4akwArgWuPtiqo8rLsBvjSCWaNqfb5ML/heLkDPHV+MEBj5n+f3Wa+
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="231639336"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 20:09:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eje0O3AodZRIkOQTg5aTM/+j2/HzaKSoTyuZdQoktzoIhrXXrJTlZEpPQ/ak9hiGKGWAdbkpldueKbmcGSeBsKeWnAxcWoUTDpn3Icb1QePzz6P1yOrUJ8nobhv3BS4yOnJKErKe3fakt0tEfEtZ7vZz7JnRSy7T0h1Xv2chTQ6JeqV5RpO8Sn0F2Dy9UQiVy16a7Vbj8ybjq46JyU/XwhOp8+d2bWU4kfv4zBYIqBX9Ot9PVplQJ44MjAB//HQm2WwYjzkbbA8VIrzdewZKlEHpD4FkMVg7VqlYFYwhD+lMWe5ld3ApRmzb7UUDo9xFls8czjY/AKGyivvQiCQuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mftmzU6INwnjUcSA3mdZBRVVMgH7tqzLJ+c+ZTxSm3MqqUmlzUBJcvXVlQOs4tWHIOXXNL1qtMbkLn6+YuSef2f7NfnLYj7rdfSSNxH9tZX2mQwHNe1wuc5pLvjXhqcg6ePubhTkM0PmmqpN6T9VPTkae0WhKlb1m5GpYC4cPKuwDekF+BSIoKoyN538eYAS9s+hU942AiEat4DBWmnkobfaGBL4nB/uerQe0bhvfD7jGf7ccsKjugN86lPQSNlQKhMO6gBZI/3wjb5wQM5J+t+fv644zqrkW85xFocXX6pxvH+lTNZ3g2R50i9cib0oE5Ci3F9c8JwygzLSowFduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RwI7LB6U3KwKhEj34nK1FqmJ/y4YPKAiVetOlxhjKrBQdGbDd7w6VNGZCx6U2jfrhFwkt5BdAoVnNmXbh0xcuR1YJACE7tyLOuIw6NbFjh1mzLyQfwrqKkkdWXe8empsuqJO5x3fmyH+Ku7rO9BmemWWAfNb5eAFp2ZsWA0BdNM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7487.namprd04.prod.outlook.com (2603:10b6:a03:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 12:09:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 12:09:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] btrfs: split btrfs_alloc_ordered_extent
Thread-Topic: [PATCH 10/14] btrfs: split btrfs_alloc_ordered_extent
Thread-Index: AQHZjlD34GvWUvV3M0yd707z56sp6q9q5tEA
Date:   Thu, 25 May 2023 12:09:17 +0000
Message-ID: <6e518139-5156-6599-f548-0f63390a2b32@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-11-hch@lst.de>
In-Reply-To: <20230524150317.1767981-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7487:EE_
x-ms-office365-filtering-correlation-id: eeeaa41c-1b7f-48b3-6a9d-08db5d18dd03
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jec7u9IrAN84yAnW/mGbSCBhIBSxqbkfIGiUa45fSnnLTOrfzuUhV+Ae+ystlJh0vkgoMF1zJGDEpGR2it24kNcnXdaO4DfWL3HYeXYgNchJQPoJoTAN9d2oxqN5v6lnDqFkvN3ClkGo+N+TN7jMGi8U4i35D2P8EeTo76tamOUomJnNkzuIqBu4WO7uOslQsGFEKmAmWcU7XzMaxT6C92iCO5ruQIEHPXDd7BG9EvZcAFOL0Jz86T1pOXlm+kBOX9KMj0QFFAAKQyWaCN4rs4DdI6aYem899VhXSrmntRH6sDNlVxmUYYwtf9zMLHwgw0xkNrNhMUYsuS+OJRJJGIadVLa5mmh+K26ticLdTnBQQRk55KOzYnSpQdMbDqgYdGOWNz/G5QIC4dPq2PVPTDYn/UhRBuS4ioMf5VOo3I15nc+mX3PBYOuQkPzA+NYxpB+u1QGwnzoeuj24rMO3nb4mXmSJzpskLp4rZS8sCF1FYpReEUeoilK9f5e/Px7LLv30UKYtIGrBbt7tLVOwsdIWlVFdHim3qzAOLktPdY8a+ok1nYsIQtFf8XzXDih+CQpWgFrLS41Mu+10fKatch8Zruc+WLxmk5mjCg7Km4//VTytWcVaR2XBLaW2/iu0oqjC/wwOJ/tOPzLj0VwnyAbtqOT7nHD7mvECPiDiQ+DKuhT4kEtuLhDbAF4OUeIU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(71200400001)(6486002)(41300700001)(26005)(6506007)(6512007)(8676002)(8936002)(36756003)(38100700002)(5660300002)(2616005)(31696002)(2906002)(38070700005)(558084003)(4270600006)(186003)(86362001)(19618925003)(122000001)(82960400001)(66476007)(4326008)(91956017)(64756008)(66946007)(76116006)(66446008)(66556008)(31686004)(54906003)(478600001)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzZiR2pDMUlCZ1BRaXJkZEpkYmNneVNaZnZQMldvUm1ZNzIvZ2R3QzJLT2Z4?=
 =?utf-8?B?dUFqK2N2STQxQ2FlaWs4VDdrZU5tTm5wOG9VMlZWZHRqdFVBQXBPT0gzM0ZB?=
 =?utf-8?B?RHVjRU1DMXI0bXRZWVRSYVlZa2FmZVpKeTFBNWMrall1Z3ArUXZkdmk0VGxD?=
 =?utf-8?B?RE5ZTUQyWkM3ZCtHSmh1UHBRTzlOSkJKa0pRWGpwK2tNMGVoVE1qMm05RkZP?=
 =?utf-8?B?REdWYWEzWWloNFh6TVpVU2tZQjBCT1VwTjk2WFVHN1ROYkZsWTdJcVMrWUQw?=
 =?utf-8?B?Y0ZuUkNDb1FneVBHbmpJaHFqR3lHZFNIc1RuYjg1ZVJLVStLQ0I1dTg3VnR4?=
 =?utf-8?B?UlRvN0dlOTkrQ09qWFpmbng2NEJ0dk9CLy90OVR2Z0VNeUdPSmh5aTNYUjE5?=
 =?utf-8?B?MlBLZmF6SXNaV3B5YjZOZmQ3elM0N0xST29nQk5uWURBT2ozMTNLdDBpSjdR?=
 =?utf-8?B?MEZFZGp4aFJRM0h4MGhkRlgwVnFXRjYranlodFh3b255TXp4dkpJaUgweGpF?=
 =?utf-8?B?WThCMnp1bTBER0JEV2dWVnVtRkFPY3RVSWtwNTQrVElWZ1JpektWRE5TTG93?=
 =?utf-8?B?L1NuaXgrVWV0WWtvbjlrVjh5NHdrd2U3QnZRT2lVU1FDODFhU3NxRW5lQXc4?=
 =?utf-8?B?dmp2bXhzK0xoR05XYXF5TEprZ1JGZXA3cmhjU0U4L3lCMmhmSXlZTUVzUDNH?=
 =?utf-8?B?bFZ1c1BwZHpsQ0I4OFl4cVlJZU5GQ1Rhd0twUzFnZmMvbVJyZG5NQTh0clQ5?=
 =?utf-8?B?bFA5R3BqNU9pUEdZOVo3bC9wV2Q0S0h3cHIvYjJUeVhBQThoR3hreUVrbTU1?=
 =?utf-8?B?L2d5bi9aMXp5SmJsckZBVHBkN2l2YWI1dzljcmpnbk5TSE5yeFdiTHRXa3hy?=
 =?utf-8?B?TDFYc1IrdHc3YnhlYnYxV21yUG9DNk5lM2tyUXZ0emk5T2I4LzZBRm5IV2Vp?=
 =?utf-8?B?UUp3bDFVNlJscDdTVGJxRFRjY2pIWjM1aHJCZnU3bVhYWE9mUWx1ekI3SEVx?=
 =?utf-8?B?dHVuYlBXUkpOalVMdC9NakhRek11aE5GdnFsMVZrZFVsU2l1RGtUSXdnVG5o?=
 =?utf-8?B?YWdHYWs4MlJ0SWJPdTM4cFBDQUwwNGFlT1NYV2NDVVhJWlFkVlFiTnQ1NUtM?=
 =?utf-8?B?QXloU0F2UWVrRWplZndzZlBDb2tQcG9yYWZZZXd1N2lDV1dYNGNCRzBXMTVK?=
 =?utf-8?B?N3BGRTd0R2xCUDQybU1TZ1QyTU1BMnRKR0Y2RmxjQ0xEY2lkZHMxQzdybTQy?=
 =?utf-8?B?UFlJZVpTTWtuV2xsZ1ljWmlqWk1sQUhWVXFhSWpnVWIzclNsbEgwUnc1QnM4?=
 =?utf-8?B?UW9ubVNnZ2NTTis5Sk9jRUk5SmVENnpaUVZVTm81RmZiS01VY2YvWkF1d2hn?=
 =?utf-8?B?cUZabkVzakg5UUdBaFkzdmt3MWM5bEZJWVo1SlppdCtRVGV1WVRDcDBaM2hz?=
 =?utf-8?B?cStCSGp2djdpczMzdEw0cXl5akM2ZlVmNmhMZWNnYkFyUFVjS3BQTjZkcTlC?=
 =?utf-8?B?RDlQWjFvV29qcmk0LzdVTzJLekRoL0U5dXBaS1h6clhnQkFyVjc1ZmcycVQr?=
 =?utf-8?B?aVNIK2taRDdSRXVYY3QyY1h4MTgrd0RNR3RTcjY0UWNUckV6UmR4ckZ6MlVm?=
 =?utf-8?B?TnZ2MmpBdmpGM0RrK2ZMaE5nWGxhWFRzMi9uVU56UXlTWi9EZ29jOE1FTEs2?=
 =?utf-8?B?dmwrYkhSTFhCWk5jbDNrd3hmdmY2K2twRUxtd2hqSXp3WTljVnVMc0xzbEI0?=
 =?utf-8?B?TzRibXo3dVZXOTZkdWlVYTlVSUtSa3NWNkYrb3ZOU2hsOEVsbnFwd3V1cnR3?=
 =?utf-8?B?RC9GMkRpM1EzL3VXa0I5MC9uQ2JrUVVUNDl4REt2WFhmc2tuVHlZVzlFSXoy?=
 =?utf-8?B?ZmhYbnNiVE9TWHBUUHhnTHp1YWsvVVFzTnlhMCtmRkZLWHJ5YmJxT2dZQjJ0?=
 =?utf-8?B?SDZ0Um9oWlcvRmRNc0JmZG04aWxRSzZJbzI3SHRTM1QyaFVIRjJLVmxwQXIz?=
 =?utf-8?B?VWdBZ2t5c0pTZ3FUWERSNVZ3OWtaMXY4TWVmMFIrN0hPUVFKajcwTHgybndp?=
 =?utf-8?B?MHM3M3l2TGVaSWVLSkFzVE04NFpCaXpCUzlzaVBVb0R3Z08yY0xPblpabld6?=
 =?utf-8?B?TkE0UFdaU1RSbVBxWEhrZjNtWkc3c3d2VTRDUjJBcTgvM2JWVHpTS1YzYkhH?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B90B3575B01900409C13E72C90E6F118@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B8brkpBDeY9tFtternBjaArgMuo2+e1XW4KvFb8iSeldy8wgh+Iwx1CeEaS9s9heXPZxnazFr8HtgdQhoh1PyF4A31n1ZBO0rfDZRR/ZbXImxindGvZhi5D7BD37eIs4jh6qcaiCtBAf6xHmSdKBgAqdXC1BbGxmaIdqRoUM8v0nLrXKA62RDP4EMBODvd2N2dEHEkw2SVqc6sDH4x8s3MxDg8i/WQPI/GaOvpxaZ07s0d6sNv61u2CB1+PuwPJS7pjMki4+Mz146olpmLvVEq18alHpaqcypGXPZWOIN162rskYsDqwtgLbWAUznh0iaH9twCY4CPt588ApCEgAuHipY6sY5Jjr/8VIF4Lks164fZabnlDEqXEJy9nEtAs8F65r95gBtRUByWhVAWqlxIg83laYeD+Orf8rVhwNaUYB8fET1B9HFUbUg/bvHTGYUyzQuN8QFagZ9hWjf/8nOUcVt2wTdJoQnQuU+R3evUEs8dfdO3ks//fIghplf7E3JoRXzDL9GxW9gIYqm6YQtjjLZpd6raLb0qkdPj4eDrNvd/eupeTBfgeWtwsL5uiSCbkDsWHzvehElNz8EnGc1fF486731ei5omc1/lNAAkuw6rWmu0CMrEbOesSuCWuUjkmwoQcPdUt2VQ6yJy5FNyz3fgpHJ76EIXRX9lRPVgAhiwm8jvGjYlslfQkymGeB2rNNSZ3BG9iZP0yIM6AZ4+lmIxapsMzBDyPXYiFmGURoBUlDh/aW+RXfheFH4wv3AB/+15scpvFN6/ZbY/+iXPGC/N4kQgAZ8GSW1V2yDNukPeQ8dhr+AyFrbsDfWE0LzsSbnZKzxDaQoXGdBbSWailUbfUPRIuEyAmYnv9w6AxjshHxQmbhWY/3jNu2KqRX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeaa41c-1b7f-48b3-6a9d-08db5d18dd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 12:09:17.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWDp49bsOs3hVvg5ckZGXhr48kc7MwDiHwwfdqeookqsRHX4rWFz3/jl/wUHs4VrfJ7KOBt0BlaT7YCjhAlTLxPVHd5nhF/QxaoQAqHQYSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7487
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
