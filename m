Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88BD719B25
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFALuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 07:50:49 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CA129
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685620248; x=1717156248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=l146t2lu/+vTOVx0ctCPcMGmroHocmtsxoCb/GEXag5wl5vom1lgcPJs
   f6WcwNKEgE11f4hmJp/lebf/ywA4i2QjZNpJkn94Vc2JHouGI7BHoMHzr
   6bYF+LvZGze+H+T0iuMhZUoPTeIMj+JVtQNdYBhBfTNmXhMskS4WdbSO6
   gC9sMX8xIF+t/FVFBa5uGVO8A6/Hl4Y/vS7VFZ2gPGo+in6BxXeC4BmgO
   MAVMBRlKr1gw1QrcXqvaV3NAfKFe4gxNDXxPUrdkYYxSb2QoLbLNHpv54
   aHGmTX3dVhRU0X8R//9y4IH6a7ubo6aHEEsqxxNhlvaNiBM+QblnjZpDK
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; 
   d="scan'208";a="232158778"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 19:50:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/syecL163l8crB6HEgnN/aDCdEr/rMqWHPaj2e4ecKyXkYtVELRnrl9NR8NLyOH1Kr2vNJmXKFXf6lLEVBDecMU2rbz6l64jHbnZ5WutI+SpDeTO91BLvOxJ+stCJJfz85uIGBSJGzVcQqg+JVA4IL7TucVs6zjzb58hNh7zrL7ZpUDLAE9a2ROFIi9z1yqpuQUInrowITTDXsAzah92rJOizhnivbyMPqSLOubtP9pVXszhavQY0IM4kupVgKIh2w95CEn3f6JHtZ94gNfNXTsG1KDdJXt/PT2vqNQc8CKD3VkcrC7xls4cW3PakFMACsDTxIBpFUM/ybAABMhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=N62xWrJ3FfjqqKL7JGTm4JIJFXqKK1xmEmKEa5THfcgfi+eE/khTparYyIin/nEzRhvmHw/7PkjeYsu9p7NnuhEjEo3DEU4R2V0Jh7qn0G0JB37V7q1P0MNSAPxs2RbXEiCcaIhpGW+ih5IogxbtbmsT3UzEmrLzmvWNcHIvpS/renmi7Y5NH8H5rqn3kKDvtQPZJCnChC8NeYXsWwz9Ek6s9Ix3na8Xxga8aFNNdhSWQzvrvBVbqw+mhKd0YsEmHSMXdhgN0AiH4gmHRs4PWz+CFlXXllGtdED4SiRtr9kc/WklWK7bklc0XxJfh+/Fi6ZH//uy52Ljuhb5FzGlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Yu4uXi02XmZ3Cn309Qc8+pwkrX38k2TQsbHa7pqwNhanUL2V2/8dqJ79zZFaT2jGnjH58uqn1+k+6O5FklDSb5pYVo0b/RcZ2qBuV4tb7Jg2bUAA+GGjwntD+XxyFV8a6DLTQwNc9abngerJouKEYulkbmAWOslfH41d3ZJ6gA4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7931.namprd04.prod.outlook.com (2603:10b6:208:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 11:50:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 11:50:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/17] btrfs: add a btrfs_finish_ordered_extent helper
Thread-Topic: [PATCH 13/17] btrfs: add a btrfs_finish_ordered_extent helper
Thread-Index: AQHZk5Vy92F67auhv06EiaoOcY9j/a9112wA
Date:   Thu, 1 Jun 2023 11:50:45 +0000
Message-ID: <287ca3dc-044d-6811-688a-478de9874760@wdc.com>
References: <20230531075410.480499-1-hch@lst.de>
 <20230531075410.480499-14-hch@lst.de>
In-Reply-To: <20230531075410.480499-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7931:EE_
x-ms-office365-filtering-correlation-id: 29ee67c9-783f-437e-b5c3-08db62966f16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FMSL6eCgab+Us5IQoYumHGWdpYwqX0WNHiEA4czq5ysdHa07Rd2o99eUZj5+/lMdeZlz3bT5etAt7dLOhotTG+wkEQHXTto+qz+zVqmT54Y6KBt6A8m8+TmR2LLQbmeZrywjP9xxH71sIdKK9qKvDzZdfcXWPfY9PCG9iSpbmyYWZTEliNq2M/vp0Xkm0C4BFF+zlVbU4cXfJL4vFEK5EcrEf5Xfno8uRmRYyYjMURjxqKmDuNiRrNLV+j+jt4CFYsvXArCeJY7jrWEzC+kHAam9pV5NrAf6q0CIbmknZlYRVeGeKmKlbnJ7bbZzNMopVBY8dD+zsLe8Xktdg9PJZTX6oIw9qxD/bV7BS8H+objIJXztU6oIAxTQb5i0hCtLTajYJD3bkn7C2or0r2Z69rhH8Q9myktFcS9f/IWSCacvTNhhLN0DGhl7Ym7X4pZOlgXPRaYQlw4UhWHK7Fz1cPbvD35uGoD1DM+JwbCEjD/aOAxOZMZdxI7hPOKo3sTXqp7qBQh6iW154DtZZtBZjhYLSPp3OEB9VTM+NrF+IGL4rB5Xll2aAoRELUFV4ecinUvh95dKUtgv6bBWSr5ZWcoPi9o5xcaeDvm1A4XXf63vKwfX6mlLXAamusB+o3Bxn4ynd+mS3uAwa6o0/Z+ViFHDWPTiYWU4yGLV3dFUezgylC7z+r2TD9lGNKovK5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(110136005)(71200400001)(31686004)(5660300002)(66556008)(19618925003)(76116006)(316002)(64756008)(66446008)(4326008)(91956017)(66946007)(66476007)(478600001)(6506007)(6512007)(2616005)(4270600006)(2906002)(8936002)(41300700001)(8676002)(186003)(122000001)(82960400001)(38070700005)(38100700002)(36756003)(6486002)(31696002)(86362001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGlidk9YZVQvVjZrZkVCeEdxbWo1MkJ5cDdsSjFCTllrYnpteFZFN29qTit2?=
 =?utf-8?B?djg3Mk5oaWltV2lvNHVVTVpWZnJLcVZTUkRWVE5oR2xUdzlDWWJnRGorK3cr?=
 =?utf-8?B?M3d5OW12eUUybnRBamh4VTNXYnk0RDlTcTV2UnhwclhHMWlnTk10YXVocy9k?=
 =?utf-8?B?ZGxEUlltMkhsTHk1bnZOWTZoRDJoWlVmUHVrZnhrQ2VMVXp1TVUyNk9YWExq?=
 =?utf-8?B?NXlQbHlJdWswV01XQVlHU1RwT1RjeEFZWi85SGNMUFNTWWl3RzRVZjRwOExF?=
 =?utf-8?B?MkFiVUoxYkFaUEMrNk1jU05VaHlzMnJxaEg4RVZqRkdBbXEwR1JCLzBlenYv?=
 =?utf-8?B?T1JMSGVtWE5OQmg0VWlKQjZMSWwxcUhlcUtVRXN3cjdvRjVpM2Q4bzN3N0hm?=
 =?utf-8?B?aUhWVGttZ1NRcHpWZ0w2SzRTcWNJdFF4SkhQYnhKdS96bGNYdzIxQmN2WkNL?=
 =?utf-8?B?QnhXdkN5QjhtQ2piVU8vWDFHVW1jcUcyOGN0bXd3bnl3Y2I3S0tIVU4zc2gw?=
 =?utf-8?B?M0JOZDNUNEVSUUpRc0pENk1WZDB6dkd3bkYzUnBSbklwZFl0SXFGRWhVcXYy?=
 =?utf-8?B?ckxIVGVzRXJ0TUcwY2hDUSs0MWdPRzBzYmdmT00vaWRsUnFNUkNlWEVqYi84?=
 =?utf-8?B?bG5XU29WalZ3ZysxbWdlQWkySjA2UDRnRS9WSGlCQ0t5NzR1UUJXRXJyd0Rs?=
 =?utf-8?B?ME40cGx4N2hEcUc2K1JPWnQvNloybmVTcmxTc01mRWNIeVZ6YWJHL1VnSG8r?=
 =?utf-8?B?NFdsVWZmSDBVSVo1c01ubVdTRlhoR1B6a1UyTU9nWlAxcWR6SDBxSTBnQUw1?=
 =?utf-8?B?SnV0RVVyNTBTNmwrV3JWbDc5UzJsWlBPcXZLa3pMREp3MThFZm5ERU0zQjVk?=
 =?utf-8?B?eGR5dEY0d2hUeXk1bitsMUFPU2cyZ1M3dDNYd3k4cllBekxYbVZBZlI0RVM1?=
 =?utf-8?B?ckY0ZlU2dnUvM0VLTWJvQTZGaEEyMHhPb1FLbk9kclVCRVpSNk4yWlVTVGE0?=
 =?utf-8?B?Z3dCdkVBRHZjRHF6VURxMmN2UUNsd3A3cko4OFZ0aTVtU2ZRdGpwaUMvc05V?=
 =?utf-8?B?cVRWeEYrbGFQa3VvUlk4Z0RmSFZjeHNrWkxaS2tyU2ZuMm0yalEySVV4aFZa?=
 =?utf-8?B?QXRBdTg5dXVXckpCUEwvNGpmSzBYYXlVa1ozS0V0empaRDUvVzNubWFCWXd5?=
 =?utf-8?B?ZE82WWdDcGpGOFE0UklhK2lmZUI5WTV0cVpORWpCQ3dpNjU4ZU1sUWluZjB5?=
 =?utf-8?B?RlBrSktrU3ZWWU5GckVnV1A1R2wwNGI3RDExeGlVZXVDd21CcGk0cnlhSGVj?=
 =?utf-8?B?VzFwUEZOVEVtek5yVE9Xam40RXM5SUZjQjQyUDQzYnFTd2h4Y0dqRzlXVURI?=
 =?utf-8?B?Y0R6M3RKUFozSVlJdlU2eHJ2UXZMUGx3cUdsQjdldk1EWW54cGdqcnhtME9r?=
 =?utf-8?B?cDlmZ1h4WWVaQXVTd2FUWTVySXdNSGZnczR6UEZUalJ3Ly9vUVBXNUlpUUhV?=
 =?utf-8?B?Zy9qWndaWldzcGMrOFFENzl2emwwazVmcTJvVnp4Z0VxYVNub0VxSnJVOVp4?=
 =?utf-8?B?aU9sYjNBZzJGdW1NdFRvZE8yS1BwUktkTE51TTZxSWlMWkRKcEQrc3MyUTZ0?=
 =?utf-8?B?aGtiSVh2ZFN3TFFGb3hlQVpoSENMYjAwRTZ2d3RsVDViQ3Y0bDU4KzlRZEc1?=
 =?utf-8?B?bkdHZEplTFR1cjliUG0xdFJXeGQ1UWt6Q2d5VTJTK1hLRGFMWmRHWHlvdVYy?=
 =?utf-8?B?WDJhZzJ0akxveHgwS0NPNE1PTFZOT3Zzc1BFNmIvSTk5ZWhjZXZ1R29ySkJF?=
 =?utf-8?B?L2lDUytTT2N2MUh0M0NLM2kxV2xkeCtIVmsyd2pLcDVuTXUvRFRQOUJEVU0y?=
 =?utf-8?B?UUJhOU54bkl4cjBFL1hLaFhXcURobWNkd0V4d2I2NDlIY2hWVk52Mml3NTg0?=
 =?utf-8?B?QmJlQ0JQWDd5aWVBNkVWK2hkOW53SEVnZXRRK3BXNjdRKzdRNHdVYkM4RGkx?=
 =?utf-8?B?ZWl5bFMxemV2NWdHVjFzVGJNUmhLelRwdDJzaExNbnQvN3Z5YXFtL3Z3ZVBI?=
 =?utf-8?B?dGxaZnAyejNSaWR3eStyOU1GeEhhekd1VWdDWU91elNzejVvdElNcStCQXI2?=
 =?utf-8?B?M1NMNVM0cG5WeFAvWGNQTDU0ajM5Z09pUWhIdmRpS0lGU0piSGVVVktvRjdj?=
 =?utf-8?B?M21TQlRiQmlEaHRmZWw4NXVEU2xZVUU4cGlmZVR4UkNINUp6emZ6blFmT2V4?=
 =?utf-8?B?L095bUFETmduQVdCSi9QSVEyTDJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <985B4489A858BC4A940831A67E96ADB7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zis9qtN1XIdKW3/MU7Yn6whEJazrkGb5Mt3AaM9t+Bb7jkYLQ22Kq265N48NKGcO/jiTMeArbVELt52pTlQXA8T1eFfPjpiYuNaZeeYuzjgor27VGpdFTF+O8J6wG1bv8/u4EGPqeudtc1/SCt5O3wAllk5VmaxD2Fpj9G/bjCc3UIyCB761B1ZF62OISUlE4k7oSJhaVUwWFI/ezOx22h/mIl/tGuW/WlL7iWqh52YfvEMh3JYdeRytngCWBgosfRd7EjF12eK6wPFGN89VNYdwiDM8wOp8qSwi5DytDnmU8SsmdHp+y6PTUuM1uS77b+de4FqGNk1iDuIMLyRZVIVzc9KoWXn4JHXHDuDjCYRwR8DD+zRvf9oPRRlDN7NMXQOAkw+tOLK/fHWPgBhPFAE29LvesL7sl0PHdKOdvPAjffeuBIxNtgj/c1my9KAZizEt/6aTjDwmi859NskwePLa52Y0TXwAvZINLgttsNcs2lLIMFUjqyb8h14u31tQZ1OsKmugyCQuz3SiIYWVZDFYzYtPBzOQmODbUEQw3BvkibB9iS5ZDvjtPnWQiug2FH2Ive95R9c0lEftB8JQVpTrTV1oMD+6F0hvFUGrjdEEbkm3VRPwteIcHI2L4S4poo03Jy6/Fdbnu/gN5rHYiIsbGmV9kjoIZvgkHY06BVwz3sRJqE5mJTN4LUgPiIH54t2Cos0nvTpA7KZLTVvDlNf21htEME7viP1nuY7ZGQwPOXPW1W6Mfk2szHXaaKMeGnGEBw6z+XpHjVz4v1Mzbb/vTLo8ZsdZvStTcGr2LrQAK8WU1kyC9cDdkQKK97QIa1BwFXrRcgk5hvNbAHB9bN7txbLoFJmOZawk1fgCOYfxih4wFTpv+6CIt5XlcxUO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee67c9-783f-437e-b5c3-08db62966f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 11:50:45.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /i2OGFkrySW5o3Ay29/ehmPCg9q0pnLn8iXYLhWjXvFOmuOJK/LI0F4Lg4yKM6mHsxoKpx3vdZ5uL+SoFJxSzbnOpoK5n18sgN0/jFdhSkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7931
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
