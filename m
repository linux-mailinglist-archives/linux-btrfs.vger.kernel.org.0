Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935417A4D9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIRPzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjIRPzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:55:08 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31BE43;
        Mon, 18 Sep 2023 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695052303; x=1726588303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7D1UlOfTWllHn3KnHGXe0NQAmXC4D2Jdl+ZYY61liDQ=;
  b=kYOm/YyEiV2uEaSWkqVRt0FV/AgIiXLpXcKIAVkYkX2pEd35uuFrHQL4
   5z+3UmGR7PlGioM4Xe9npYBbeVHbq5WYV2vT5nhU0VfcjUKjZ5PSwuKMt
   16du/a/3QAlNEZTK8iYi7KM8RmDUpJsY4RyCwFKpP/xLu+GqTfrK+j2Y2
   raICnNewt9nPDMe5bZRBMd83meAm/+22d8l2xduz8YKJ/cXTzlPbV2RRY
   MHQ++EVttsCn1VPSvIGK3yViQPRK+NtdK52T8MM4f/+Et/9PLqhoPxj7Q
   lgpaOzQYU4+AmKyXofQmA/7beb/DSbCIbpXfzQ2XtpgnseStQV6u7m9sD
   g==;
X-CSE-ConnectionGUID: XeiwRnWXRCqkZl/LB8yG4Q==
X-CSE-MsgGUID: 0zaV6HzESVCAuHeqzCMgUQ==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242450258"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 23:03:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHvam16vYneqZP8AVc0X5YVSm5yS4XmTqWmjA1YNrZI77V0FVo3RUImLGO2pSmyOu2YGczGY30gT9V2PgZLXqYRG2lPqm7CNKNWV+9DE3sfgUUGzqVaDb5t+dkI0fFR+MKYCjNpokfwRRJY3tXX/u4lzXdlqkhqWdM6W3wRQZ7ad0MgWzz8/pyxwThgnG4knfSvVebyfLqFXPYHxEt3fpAb0KcK2+xMbQhIoAUqeC0qwvC0fgcxifbQC8gGcj5p5Lgm/sUnuKs5fTDBwW1MBi9EfRdC6tHp/4NxGW9REsK/3KTJ3Jgrj3a16uUfvJkfrZs1f22fhh4mIR1lP7zXbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D1UlOfTWllHn3KnHGXe0NQAmXC4D2Jdl+ZYY61liDQ=;
 b=Ujwv5duLMbWGUS1gzgKpe6uNR+5lrgGKmJzzX2XlLxmc4mLj1ooS0OJbEzKYzEKNdI0Z7PCb9ZirkWo1/j2GpTEVC941rC6WmDRhvGc6XIEKeC+Dn4CcsKm45Mr191//yl39fL13v50AoFpe+O/Vz/riKvH0Iny6dUO3gD1b7qDnmlgCCUgXj8L0zPnsC9+7CN6soT49gwfjB25TTaTJ9VH68Hl5qydaJ4H9J9P9Se/O5YNOqCkB+5h+o7nu85lXews6hL5tD45FiUPJ4+xDoYH44TElmUoRvEAySPlJ15HU3b6PUBxiro8yEsNlqKv/f/q6RTjrFV53zBsVHWf7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D1UlOfTWllHn3KnHGXe0NQAmXC4D2Jdl+ZYY61liDQ=;
 b=nS17rqMuIEq2R3QhDOmTU1QGPW5V0gWbza1d2fZV6vrN8crOxcyFsYaJNdMZfjGtuvhNhlHnwxB3CMYlQX3c6+/GdRWUj1mVU3Rbn8O2pRV0CKTTbz98afk8lB4uS4DHTXPUMOUNTcFTKW+ZE5l1Fh79FzawCZj51DQzA0MHQew=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Mon, 18 Sep
 2023 15:03:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.014; Mon, 18 Sep 2023
 15:03:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Thread-Topic: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Thread-Index: AQHZ6jp6ZCmYtHvvn0mlcm6wvPE8oLAgoaWAgAAMXoA=
Date:   Mon, 18 Sep 2023 15:03:10 +0000
Message-ID: <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
In-Reply-To: <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7436:EE_
x-ms-office365-filtering-correlation-id: 36e8e29f-c27b-4d42-6652-08dbb8585f8d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUWQuZHJULCK75OEQkQs3YF1u6gnNUpeJCKCE4CKZh9T+9ZslzPDvdggBdkQ6+nQKW2XXdvyq31lniP/WOkzvMnFobb7wBvjs/SGeSkT9eeYcHEqw1iSqW8rCmvmK8xsj59+8sD2MQWwmxpvEGSwdFVa6FBXOr7vVEgRqD1pY3NxomJh+Yy+3vv9haq2TFtXQU3FCqNHGnAH8M9wcTWl3ZcLx3iIwCNvHXG5o4BJ5ggEUU6inkWyF3WsbEhszM8pogaGHLH9WZaImo0gov0vGZBIHFdI/406I9mV7JWWTwjdx50Z/ST8P5KydRy04tq5UVvjV8Xm36LSbAkfEYZJNE2FZ2i8hv5IO1gW4Vkm5lrznrOq+GuU6QxcLsyfQQ/vZ/9Py0lSJhMB2s7U1gA/uMYVTCgxGKwEgSMluHQ64gECRGOuJegNnpjcFXLPMPucO0j7ayCVwyjXN39kRbZ14V2NRmJ1MHndNt22MB8znDtEURRAO2ggA1/UwUEPVaq4ya3dvwfMwtU1mFD4F2s1trVMO1Sx8p3sA0pUbMZ6Uy7HvsE6679GIaOHkZWnfjpBmCum+nNRJDNRmiU8dgNKEHRzGFluaQdmDitaDWW6PeAPwttUqbxZzDYvHsxfJUA/zRatFQcLF7v3P8i8tbja9O6GI46/0z7eMT51eegffp7d2XobTXOISkIIKcqQ4it3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199024)(186009)(1800799009)(76116006)(91956017)(66946007)(53546011)(6486002)(6506007)(66556008)(66446008)(64756008)(54906003)(66476007)(6512007)(6916009)(316002)(41300700001)(31686004)(478600001)(71200400001)(4326008)(8936002)(8676002)(26005)(5660300002)(36756003)(38100700002)(38070700005)(122000001)(82960400001)(83380400001)(2906002)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFqTWZyQW5rTXY5cXdOa3ppZnRqS3hkbThzdlNqczFtajlLQ3V5K0QxeFRi?=
 =?utf-8?B?TGtvYjBTUjQ2YWJ3M3R4S0NvUTBZcWZMSXcvWkhpemFEOGl1VHZZQjBRRFhD?=
 =?utf-8?B?VXc2cDdEQUF6czZ5akJ0dFpPcENFeXhMc2l0U1huWTFSeHpZVDFac0dIZE1V?=
 =?utf-8?B?bzhWaGhrM3MwWlVLTW9MVFh5MExkOEhKeG14cE1sQ0FSMGo5cmdhcGZWcWM5?=
 =?utf-8?B?TlhpZ3J6cmpvQ1lhSUR3KzJwVXZHQXZpQmxPbVF3Qm9ld0x3bUZVR3lEa0wz?=
 =?utf-8?B?VjljeFUrYVV5cjE4VnpaWUFGV091czQ0bjBibkVRZFgxYW0wZ0ZtbTZVMWVm?=
 =?utf-8?B?a1VZUjAvOW5OZWRrblpER09JZXdLN2d5Yk1TL204RDFRaGRIQlVuVXFTVW1R?=
 =?utf-8?B?Z3lnQWZ3TmJ6cG01dEJlaTdFR294SjhVQzM1Z3gwY3VjUG5TVk5McXBkcHJ3?=
 =?utf-8?B?MlRkYisrSnJaV0pMNmtTSjlscE5tNVlLaDBOWmdERFhvbUhCMXA3emFFemdS?=
 =?utf-8?B?OVFvbTltVWhnbGRtSDhkc2ErT0ZzQmFXWEMrYmNrK3Yxa3FZcCtObDUwVjVj?=
 =?utf-8?B?RDFrdTduM3pOVDZBalFPSHFLV0tHSW1zWGZQK3pvVkxMZGdySUpnMUpQd0Rv?=
 =?utf-8?B?V09ZU2F0ZWlza3p5SFppQjhOSUNORi9OTUJxRkhrSjJiM2xYNGVNbjczNHV4?=
 =?utf-8?B?cUd3N2twS1YxSHl2VW9aajZLNnpxa1F5dXlmNTBwSTFRdG5FdkVnUHRZLy96?=
 =?utf-8?B?M2tvM2NzZ0VuK0xNSmFWejZsS015MkVEZTVIbDZwOFc5OHEvbElFN3QvMm85?=
 =?utf-8?B?M3dsRWV3VU9VVnUxSjIzajErMEM2TWsvLzZLcHMyclUwUHNMVUdybjZ3cjhM?=
 =?utf-8?B?OTBXNXdLaTEyYTZ3R2dZMjJkYWRoNk8rQ0I1S2M3RXRjOEpKRWIzdDZMZlFh?=
 =?utf-8?B?cXZ1QlJxa0lTdy9wdkdxakJSaStQRU9mb3lJejJnaUpGZ2VhWGhEeC9sczE4?=
 =?utf-8?B?bXJIci90UmtCU0hTK2g2STc3UldobUlYMDJDbUh2Uk1IdmdybDVVU0hOaXV2?=
 =?utf-8?B?Wi9ZOXZVNHRwc2xVR2E5cUk1aUsrWGlyMmloWFl3ZS84bG9yZGpzbmVJVm5K?=
 =?utf-8?B?MVNzR2dKOUxsTWdDVTJSM3dlQ2hQdUhoKzRicXUxSXRFenpsajZkN1Mrc0l6?=
 =?utf-8?B?SWtqalpjN05WbEVxU0oxTGJnbjQ4LzJzRjBCbGxMZUIzVVNNMFBsRWl2WEpn?=
 =?utf-8?B?STRyYlFRS3JFSDBvTUJtWFgyTFNFL3FUdmtEMW9ha055NVlNWHVqMkl4TXFx?=
 =?utf-8?B?MFM5VmR5TEFkMkF4WG41WmRSN2NTOFFtaFU2S2YwVndWUXhhalJlL0l6WFJl?=
 =?utf-8?B?MzJWY0VBaWF0SXBBTmV0WC9uNFJlN0tJYzUyZkJvMkI2OEZydDFZNHQxemZK?=
 =?utf-8?B?SEllWitGOG9uVklOTXRINk5GRFd5WDBXekR0SGY0Q01yWVZnLzVZSGZZNGND?=
 =?utf-8?B?bG1JZmdqWWEwTzhKcUdSdWMxSGRjN2xZMlhNeVdUZ1diNXlVT3hkTTVJN3lv?=
 =?utf-8?B?bk5zWDl6cnVkRkREdklSVGdDemJadDFLd0NMZ0ZxQ1lnSE1ZS2JuQ0E2VkJ0?=
 =?utf-8?B?MWgvVEM0M01vT2RGQjhsN01FQVhIelhoN21lMWdZdmhxQ1dnV3AwZml6YVBw?=
 =?utf-8?B?M281bE9UMGljNmR1MVlyMjVhTVBDZkNMYmNEd0xQTDhVekFlRTZUSThwRStm?=
 =?utf-8?B?VW5HNlMxQS9oUCtLbEdCWjkxR1hKR1hldWxCdkdFRkRuZGw3VUpEckZaNm5t?=
 =?utf-8?B?ZzZ4SEgxL3JaeU1ORnA0ejB5Y2NEa0pWVE1GUnBlWTBqZUo5Mi8xRTZGaTFU?=
 =?utf-8?B?WVNZUzdkUWtZa0pUYWppWjNsbDZqZ2crd1JUZVAyVWZNTk1qbXpzNk1JK2Vt?=
 =?utf-8?B?K2RlSWxSaUFORjkvQkpBNHVnMXhVODkzZzBadjZwaStZaVc4RUpaTVQwS1Vt?=
 =?utf-8?B?ZFBmTnJFaHVWVXRGYS9iQWRjb0VOeThrNnFSRDF2VXhUSjE0OExESlZoRjFr?=
 =?utf-8?B?S2c3Rjlvd0VjVEtoc0hNaW5NOUVjWnBWVXRBeFA5KzVIWUd1VTlHWno2MG82?=
 =?utf-8?B?bmRWM2IvVnZyZjR5dzNEV3c1M0pidTlUUldjWnNRTnpaUXFHU1g3MTN3MzZD?=
 =?utf-8?Q?1UlhQRFXqGcGlEGyo+Ef5nE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1EFC5A3B6F7440B3E53127E5A65AE2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /beFB+jZNMnmgzLakrUl8QnaoW5HBNGH8jv0taSxGhSXTQpef4bGc1Bo+edH+hS7/WNG7hgM5LipTVj2AT4eSV4fuRor7QScAz5gEZl5ZltEBO8Ak7Y500O9RO2+kHmzydFhUVsxK6tHKQSuIYLiRdzS4tEHKP9aqCNwQw/mzIbg2aOgmiwLWlSrbmaeROoFCF51qKP2wHr+j2OeqhpdedK5Wccf14vPieyoxy08uKkmMGzpDUAAaGiplaYSzQpKgjAI8jh6JZNv2mJ/lI/zDGQheVXC3Hb1BJa4t9Xj6K5agDATxQjpGFMB8Ysd0kc8hwVXVJeNXutjuM83qdAUku6is6LndJoTot68nfsa73JLSiNl7Q7Ry768IsJQo+DdgH0GXwlOdcw0PzX4zXoDP62iJ2Q5gGD6cHXvV0xjpQtaZLSyMPdbD8GYZPjHiFvlZs55/ta4XbE4D3hI+IccOkNtKXM5CGdmpw21ue7ETeAJK5PmKeAwy0ox37jlwbquPhCrbOTDLFtUArsSo3JWkyyWjIVzR8qIcARjCFZobce2N/h6YH6nZicYh3XKvHyZ3UaUQuN8QNTRhjMUbfQOtfV7hJRc/NwpCe+8plWkLYcCCX8HAkAKGq1hSz3R5pytcjzIic3egWgy0QCwi81+F8vqkdznL6udSpY5mVPm7ndWspsI/lugyWHu2P9UpHXNfWAKMcWzqZE53sFhzn4oGfCuOQmN9NnRl9o88qCg+QdmetoCWar98om05RXfhZdjUluIJuyTDMPmiEworcj09bNRutKjK2iPLlQe3MJPKECRhi8JS/yFYzggme1DVJzsVvQBm+3OmKVfo+D4xvsMfiY5FwB+p8DSx6myiLOVlmkMFC0BGCjN6Y+1MEtI5Oxakym1bGDxYX3ehsdQDSUOoQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8e29f-c27b-4d42-6652-08dbb8585f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 15:03:10.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2l/eioiP8oVq/03A1I4cgodq8zi6+I0YxjVOnxh+FHiPTPk4Z+TJy3sdkBAFGsQEK9ucVhLVgoAQRZVBBcfjNIxD9mm6Ue2pMkd3KmaelA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTguMDkuMjMgMTY6MTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gSGkgSm9oYW5u
ZXMsDQo+IA0KPiBPbiBNb24sIFNlcCAxOCwgMjAyMyBhdCA0OjE04oCvUE0gSm9oYW5uZXMgVGh1
bXNoaXJuDQo+IDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+PiBGaXggbW9k
cG9zdCBlcnJvciBkdWUgdG8gNjRiaXQgZGl2aXNpb24gb24gMzJiaXQgc3lzdGVtcyBpbg0KPj4g
YnRyZnNfaW5zZXJ0X3N0cmlwZWRfbWlycm9yZWRfcmFpZF9leHRlbnRzLg0KPj4NCj4+IENjOiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPj4gU2lnbmVkLW9mZi1i
eTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+
IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+PiAtLS0gYS9mcy9idHJmcy9yYWlkLXN0cmlw
ZS10cmVlLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KPj4gQEAgLTE0
OCwxMCArMTQ4LDEwIEBAIHN0YXRpYyBpbnQgYnRyZnNfaW5zZXJ0X3N0cmlwZWRfbWlycm9yZWRf
cmFpZF9leHRlbnRzKA0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgYnRyZnNfaW9fY29udGV4
dCAqYmlvYzsNCj4+ICAgICAgICAgIHN0cnVjdCBidHJmc19pb19jb250ZXh0ICpyYmlvYzsNCj4+
IC0gICAgICAgY29uc3QgaW50IG5zdHJpcGVzID0gbGlzdF9jb3VudF9ub2Rlcygmb3JkZXJlZC0+
YmlvY19saXN0KTsNCj4+IC0gICAgICAgY29uc3QgaW50IGluZGV4ID0gYnRyZnNfYmdfZmxhZ3Nf
dG9fcmFpZF9pbmRleChtYXBfdHlwZSk7DQo+PiAtICAgICAgIGNvbnN0IGludCBzdWJzdHJpcGVz
ID0gYnRyZnNfcmFpZF9hcnJheVtpbmRleF0uc3ViX3N0cmlwZXM7DQo+PiAtICAgICAgIGNvbnN0
IGludCBtYXhfc3RyaXBlcyA9IHRyYW5zLT5mc19pbmZvLT5mc19kZXZpY2VzLT5yd19kZXZpY2Vz
IC8gc3Vic3RyaXBlczsNCj4+ICsgICAgICAgY29uc3Qgc2l6ZV90IG5zdHJpcGVzID0gbGlzdF9j
b3VudF9ub2Rlcygmb3JkZXJlZC0+YmlvY19saXN0KTsNCj4+ICsgICAgICAgY29uc3QgZW51bSBi
dHJmc19yYWlkX3R5cGVzIGluZGV4ID0gYnRyZnNfYmdfZmxhZ3NfdG9fcmFpZF9pbmRleChtYXBf
dHlwZSk7DQo+PiArICAgICAgIGNvbnN0IHU4IHN1YnN0cmlwZXMgPSBidHJmc19yYWlkX2FycmF5
W2luZGV4XS5zdWJfc3RyaXBlczsNCj4+ICsgICAgICAgY29uc3QgaW50IG1heF9zdHJpcGVzID0g
ZGl2X3U2NCh0cmFucy0+ZnNfaW5mby0+ZnNfZGV2aWNlcy0+cndfZGV2aWNlcywgc3Vic3RyaXBl
cyk7DQo+IA0KPiBXaGF0IGlmIHRoZSBxdW90aWVudCBkb2VzIG5vdCBmaXQgaW4gYSBzaWduZWQg
MzItYml0IHZhbHVlPw0KDQpUaGVuIHlvdSd2ZSBib3VnaHQgYSBsb3Qgb2YgSEREcyA7LSkNCg0K
Sm9rZXMgYXNpZGUsIHllcyB0aGlzIGlzIHRoZW9yZXRpY2FsbHkgY29ycmVjdC4gRGF2ZSBjYW4g
eW91IGZpeCANCm1heF9zdHJpcGVzIHVwIHRvIGJlIHU2NCB3aGVuIGFwcGx5aW5nPw0KDQo=
