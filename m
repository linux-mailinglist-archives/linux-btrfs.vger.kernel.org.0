Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48B6FCA9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjEIP6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbjEIP6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:58:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569346A1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683647922; x=1715183922;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Fx9omQCad7QNMCV9qD1RXbG24xbqjQSLXS+EsqjyI14Yl+Vd9mfmOoEx
   LIbL7G7Vh+/wjTst5JrLRkof/Iu+MzxGtnRF4L3PShHp7B9qC/uOTR+Dn
   WgeQjUUMhQIgR1zSQW3wLg/ybJXv6CXAKm2GtydA67HY4yZ05CRACNWvE
   bsDhYr0vQMIBdbu4EknVCWo3mG/C/l9o9zoL2LWXk/8tVMB7RGFIshJQn
   33niZEUUkTIkoFpIKkIyyRiDqSpAcjirP15/YcdaTfRktBniAy4PsXRza
   T3Uvf0PxO5iQUzGKlKA0ooVdA8ZcJjlkF5wifZrfDDGmhd6CMXX0mFn5S
   w==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="342297898"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 23:58:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4LecoOjieTo3DR5hpU4MA/7qHGTgF+hH+YizIvuHVZCbsQGWSITTKX/faHugD3hREpX0BUwj0vsz4yp+ED0yee422jPjw1pla/FTJmHmVq6b1W7zqCMXZAU0pWp+FVs7/ynEbOyouq5kJn0kZpSgjCSLz2NHcaqtsGKlP+N1Y9jwNGtIkvBFKLplfFjaICGxFX/Y2AQSjJ46F8uHWSybCKE1PVTh1mKkfRkGz7aPAgMXxFCzv4iV76rOr4qGfSIPjgsNQfrIf5tiCzJYzd+YkDSUZ56G2eb6jKJd6WddrO0gmKri2lNR+9+LvEg6ur1wBvLzpB8THhzaPFXvvy6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RuOGKBT2Bm/g6CXBuH/XA+oG4T2xNZTPnnFbUFBpu2Ly91YLuOh+oNdc0ywKmyOAZl481P5kLejVo8JO/NzOSmqyqz9SWf1gIy42fPiqmycydpY4E8hN5JCRFngMlDkYvlzs6N+JB2nQUf02TlWHEeF/xvmWXt3K6qR6a1k25uSVQ8amylBF71e3jS08XnVqhzDNLOE9MCodcnrNlukgEy36DbrXTvEmiieS0WddCkKBI450nqJvWjgnrIB6eID89EvumwBavEJaXzPKqIxylfiy0VXmogZ6tfEYAy9qsnr7XA5Xf937g5SWPHB/XxUL8MtfXGPhgkHM+FWYOvhF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=R9ZWme5Th4SLvIjNYUDCs3zaj4gWIchC5JBAzid1xjmXtoT0unCvRB+wbDIqIPnB+cNzMc+nwy4mdogfmvM7eOLMuXgYrxUpHevwWeG0o3j/THSRTjeN4FBJjiWUVQ1LvG4Shyv1ySqOkHXxEGh77pey6svrfSNye9UBOW0H5UE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7024.namprd04.prod.outlook.com (2603:10b6:208:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 15:58:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 15:58:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: zone finish data relocation BG with last IO
Thread-Topic: [PATCH] btrfs: zoned: zone finish data relocation BG with last
 IO
Thread-Index: AQHZgfpwW8eOxf6qUkmx9bzUdKykjK9SGkaA
Date:   Tue, 9 May 2023 15:58:38 +0000
Message-ID: <405dcc16-c19d-0039-decb-569e75026c57@wdc.com>
References: <1ccb7d4e3f582369edc1fb067bdd39d867049a0b.1683582405.git.naohiro.aota@wdc.com>
In-Reply-To: <1ccb7d4e3f582369edc1fb067bdd39d867049a0b.1683582405.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7024:EE_
x-ms-office365-filtering-correlation-id: b4f35da4-eff6-4142-252b-08db50a6409c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZ0creK3m72msd/KqUDuzOJ+AJsgvSFzNl69Fcp87ZsLM5JXYMWIeyt6Tu0Qo3e7FJrMuQWde34vkZ6el0q6qIbCgVpmRF060gqax39rG8ZnQ4nifrz5Tz5JU02QoO0a5b4K8uckMDA+lQtbkP3kvxB4kAzkcKvLgkpA8BJjEllxpHMys+PpdTp0tEO35pc5juvCTMmuOub/wucHipSObavN5WLRpYwYGbtKBTaG9qEzcIR3FJMlaWWt4SLEGD22y+K2FNK2ug92WNqmTuIlJnUyWuFdscLsIAL0qapShjKaV7952mZx8vPELPGEmayTy+F6x9OcDI/eCzV6+4D5ZRfZkPZan7pcdLM1KLU6j5fOO9aO48fLRxbvIzkmHa9WYrUmaA4cxyQbNjDOvwBYmfuz4KQIH6500kw65i2wE87ZttmucZzBElGVwhIc8opjt9LRzvIWLolU2jfaMXV/hxj7vKa/loipaa43U1s8LQBBijCuGZ/kCnI3HwyImYPik4Mayezd0RMd6zcs5I2Kwlpp6J/8cMalNSXEwX89vJc0srYXqugZI/9tysqd0jz97quKFTzZ765eA22yx1OTpreXnkzL7VF99bZr6s15Bq7NQ3kMlE3aLabpoG4S0E+t5CloQ4r7ZKwI51YD5Ud8Ug09f2OT3ZXVOF9a0Zyzn9vyF6d4Doa9NE+K+8ko+nQF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(31686004)(558084003)(36756003)(122000001)(66556008)(38100700002)(2906002)(316002)(86362001)(8676002)(64756008)(76116006)(82960400001)(66946007)(8936002)(5660300002)(66476007)(38070700005)(31696002)(66446008)(41300700001)(91956017)(19618925003)(6506007)(4270600006)(6512007)(26005)(186003)(478600001)(110136005)(2616005)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3paS29EQ05HZTV4amlyTzVXSEo3eFRKdy93WnNKK3JLcVYya1Q5U2dLcUsz?=
 =?utf-8?B?QXFIbm14K2lGR3FObmZrdkpGc0VJaCtNMkdLVnlCQWg1SmsrcHd1NVBidFFh?=
 =?utf-8?B?NlM3QjZQZVpDSnIxQ05tUGE4V0ZLY2JFbUZpV1lwK2t2RkN2cE5PaDd3U3Js?=
 =?utf-8?B?WklHTGNScVlMQjQrWnppNU16eW5IOVNKMWNZUE5OWWI0ZnBReGQ3UG4vQTV2?=
 =?utf-8?B?M3ZaVGxONkl5dCtWVGVvbjFCY1Q1QlFlK0dhdlkzNm5aa2ttOWpNaVZ0MllR?=
 =?utf-8?B?b3FUV0lEdlU0d0dYQ1E4Z0JXTGsxUDd3OGlIdnNpVXNqeGpxREFvcEwvRXNW?=
 =?utf-8?B?RThRT0pmeUdudlVhUk4yTG5pOG9QMk5yTW4vcmM2UmgzM0RvdG4rVVhUT0JD?=
 =?utf-8?B?R0VZSHdacFcyZVZ1TFhDUmxZeGE0Y3RtNGlySkxjb2xFYzVTR1RhY3E2ZGRE?=
 =?utf-8?B?ZElBaS92WWxIbnhPa2E1VWVyNVpZdkdHSjNlSlFDeTFUdjNMcFQxdExFTlBo?=
 =?utf-8?B?TUZNbkdnbFYwdlhhYjdta2FvbVI4amNJRW1uMVpnc1ljWWtRSHRaWVV3c1Y5?=
 =?utf-8?B?V0RMQ2xsVTlpMCtDK3hYOWpRS0ZpWGdXYVJOVDJydjc5Wk55S0g5dDl6Zisr?=
 =?utf-8?B?c3NwNU5FanlBTW1OOXpqYWN1RHl6b1JSc2VSYVJwcUptdEpsMlh4V3VuTDNx?=
 =?utf-8?B?ak1Tc3JGbER3dW56Q2lTdklJdUt0b3dqWEJiaXhDNUVJWWVDakpFTXFPMmZj?=
 =?utf-8?B?bTYvSVZvL2FWK1pmdEcrMURFalQ5ZURvaVpwVWszYVZYL05rdTNLd0R5b0pT?=
 =?utf-8?B?YTlBVDFudE1GYmtLZ25xL3BtczlOSElxZmJhcGx5QWJhMm1tMzFmWVZSb1Q0?=
 =?utf-8?B?M0k2Vm1JNk5GaFBJNkZ1aTNYS3JHdGd1dDFxUUU4Z1lrQWhpUzZ6WmF4VlhZ?=
 =?utf-8?B?MkVUWTlLUkxRN0NkSGRZMy9jVGZ6RG5LSGdXTjNjdmsveHNuZ0YrSk9ZVVFZ?=
 =?utf-8?B?TGtXUzB6T1BiN1ErWWI3T2x6dlF2V2JuclB5bzVSVC9ubmpISzFjaG55U1ZD?=
 =?utf-8?B?Unhqc3V5V2ZobUQ3allVendFOU90OWgrV3V5L0RlK25hZTAzZXJlenFxYWcr?=
 =?utf-8?B?dTNCRGp6enB5eUdoUWxvRXNITDBzb0wwY3lBeEdidDI0YjNsL1VsV3dVdGE4?=
 =?utf-8?B?bVdzdVlpTU5DV204clVZbW56WmxQMm9ZN3hoNkZGZWlHZDllWEltMDR0MzNR?=
 =?utf-8?B?ZlZpOGUzUmdnaUl6dEFncVBSbUhjNk01L2xINFVEYkxReXJFaGVCT3k5QUsy?=
 =?utf-8?B?b3dUMG9QQjRoN3laZFJpL3lMdWJtajg0WGJzT0VMNjF3NjM0VVR6b1pPcHRV?=
 =?utf-8?B?aEVjazZKRkZINzFTMlJjZlhoWElMQzBzaXNGRUNWQ2pkakZEZzdXWjNnZ3dD?=
 =?utf-8?B?TVFrSHhhVi9ZNmUrOGpQN05idUJNR0pQUTgzS1cxQ1h2NnN2TkdFVkZ2WUx6?=
 =?utf-8?B?a2NHQ2czdEVET0doa09qMVl1cjZsaG9BNUlrcm5WK3ZTNzk3aERXSkk3OWwr?=
 =?utf-8?B?VFhBaERPMTcwKzJXRG54R2w3aUlpc1ZvZS9vajBiTWIxd0cwR0Z3a0NwYk5w?=
 =?utf-8?B?UzNRTktabTdBN1JuMXNoSEdUalY2SlQwdEFMVGUxT3dkQzhvVmNzemthdHJi?=
 =?utf-8?B?czloOVRNNE5yaFNBZHJvLzlWR2lJZVNIMTQ2N240VDBoY0F2dzhpUlZubkVu?=
 =?utf-8?B?ZXc0YlJrUEtjRGIxTTRoUDB6WjZKZDdpY2swSStPWTMzTHJ5UTk1NnVCckda?=
 =?utf-8?B?RGxMaVFxOWFEV2lYZWlOM3pwUzBhYXV1MkhLWDhPMlZXSzJXLzB2Q2VuOVNW?=
 =?utf-8?B?a2lJVEpDbzNkbUNVbmlNRDhvWWg0dnc2WTUyQTFvTm5DRldxK1NUOVoxK0Zz?=
 =?utf-8?B?L3NncjBKR1piQW01WUU0Q2Z2WjVBc1AyVzNmcHJMTXV2VERteXBGZnZnaTNT?=
 =?utf-8?B?TEMwTS83TGRzVXdvZU5IVHpkeHNyVUhWRkdRVG9YY1NDekZKQnNMdE1Wc2l2?=
 =?utf-8?B?Vmd2ckJDZjArWUx5cHFzMGYzaElhQlJiV0JwbEE3ZklVWFJQU1RraVVSSU1F?=
 =?utf-8?B?SVdoRThVSjRjelViZXZUemdYaHhjL3orNG1uL255YzhtbFNSK3dSWjV3UnZO?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A8E2792CAFF334C9C5F73F65494B75B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzZufixsM66tnPquZkpvegooh+OdOGC9QEbAXZcrCNJG0BKww7/x2aHfZ6pC+GtE3MH6Uq0bBG7s4EDt6k0ba9wQZ2vCnZ9K9cCXlCB2ddHZFPVUzLu9luVK1aBmi9EE5jNxNR5YRDNgLbOBZlM8101iEkH2vfGEAfNyNcCVn+j4zhHefOx7wzuz+T+x4eS7zO3bp/kxjHR90QY1NOjXPgU3boX6tJ12Z9NJQb+AEJENsMuNV6PTxhBIDfqUJYFgFLzMR11RgK2eLH0fhCc7nY/qozR19Ki8xdvUwXa4Hx3soh70N0PyDqRSsHlR0ZW9IgsrP8zpHzY5uuor+wy4iCiGYi8TD7yP+Ygtr56XP67l1zd0boKKuejvcV8TtB3Dm3a1Yow04nYkpwZLD50QrD5VZuqEIvNldlNUdwV32dWZokiCCQBsw760Yuqm1Dg4mrIrFm7xcmOKJ9ijk1lu/JZmc/aKQxn6cRp26kCxLMgl8IO4lmN1pDd74HtxdXu0pPnrbO7Dhfr6jf09+mYKGLCMKx3groc8e2btpH1nkzUhZGL2w2J8GW+q0dbaGlgEYeDdvv/ivobs6LBIu6ZE/e/2zePBrLW4ydPuI1+oHrlo6Rq+ooeQmL4xa57IQoJnGHkt/Jcm5wd+57h6hnH7UydNB0uIxIy7pdfFUtv8P2W/1KWmpuLaucAOB7F8xBw8ctSk7RKCbD801w5Fx6x+WhseIK+rKW5ZZhpQEotb+FaC6a2WlkcqLxjnePLOzDf75LbBgW3zIAifq3W7EHzMkQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f35da4-eff6-4142-252b-08db50a6409c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 15:58:38.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbfb0uhZUl9NwtBedRV4e7j4ADaCb3i2us9SxWa3EprEYSFFA8YXPxhAbKqeYEN+Bd4PsM8ijdTACqjuh7yLKQwzmPAcZtO8Rtb0zjFgYtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7024
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
