Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03263605722
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJTGIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJTGIT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:08:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E11AC1F6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666246097; x=1697782097;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=B2ZCK1m4mSABbaOYlw4TpPZiRAF+Vxy4osSLhFqOSBSQn3uWjLUX2g2g
   8L4UPzz9hXaX8auKpShhYSwMGOPpQmqcvZJ6Sqi6KR9SPARf/ME1iBv3/
   xGbPhngCbY+M5F4+8Qbqty89WvOEtGopg3v1l6KlXLs/caCuUZoGdps7o
   Wf7zaScb8oa7w/hbfp+KvPG/fW9gySAQJPD5BQxIuGoncgQW3I8to+Ncy
   xIvnz2YhKxDgbkMs5D2ks63ayMA2N3a1texMqHd0+5rc1i2xrDJKalQNt
   1ZNemt0BEXfxvZvXyN3/w1FXEwmPrQreF6s5+UEa1wxB563Hw5IU/Rsy4
   A==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="212613880"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 14:08:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqjIveJE+vgp7EG16xuKajNvEt951/s9QzkjpvmX88+iRDX7VUCIkKoGnx0hNV4h+5KLe8BdaqW7mXyW9HOaYd0FZJYzWIcG5oEYlh4WpGirpJRl8ruSkU7RGWlx9JLwGUFbGShUMWlH4fiAK0dQkBOa8jRBCctJ982wGTr2wrleIK3+RxFiOVmGKvEzapNEdAS4vfksXtHA8XkwUdUOUDW2m2vhq+yLLR0Sotdug+4G1ncIl7SEi51R5djMgPSZ7Eav2qIkAsXcd5BukKWSZ6I6areOTTf21rSmDlXpGn33k9x+98RZg/py41eKa3rSAve8Efbe14wJjwfRLsJ6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gh9fY/xWUodUj8MtnrpuSQzEtMHRaS/b8OsA591aASYbQBo2tUZKKismFfPdWULONH8DgmMs/1L+hFIM1ssYYwi5sOVzmLKD+L2trdJtgpdOnHfgAt6OWKk+/yAu7m/CrzvampiNKsTw8VEPdK0kJrJ8JLsQq4iKaZ3anUjBYWMZ8R7NVHl6KKhsz021HbNikchv7LXG07KhU3Z7bbfVg39d3DmybP+d30PRS9k3U9Dv+qyuoO+yUmbeGiSAco6xiopmZmwayAGHNGymhWMQ0JRpxQHbP237YNuANKJIYaN1HtNebFupHBENpTorCZmk8HxsVBLeW2KPU8yeMVfbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ff8+XgHqITsLCtySuBuNh6WZqqDxEFr4x8+a23hY5eZNc1yrNl0Vvn/icd8Fd3oJS3LrmHkhwh2G0C0TLppA5LLekwf8/iR0bDN1zjEuzmz8ExaUHgdNWl1W9gLaQuHdz/51zO8qCoNkDT+Iknl+VEVBCd2+OPtzp3EUeSHYehU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3702.namprd04.prod.outlook.com (2603:10b6:4:80::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 06:08:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 06:08:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 01/15] btrfs: move fs wide helpers out of ctree.h
Thread-Topic: [PATCH v3 01/15] btrfs: move fs wide helpers out of ctree.h
Thread-Index: AQHY48swdZGHEsFbwkeJvpYL6T/deq4WzRWA
Date:   Thu, 20 Oct 2022 06:08:14 +0000
Message-ID: <d475d2f4-1245-efc4-eee1-f2395933909e@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <c733b7eb1cb68c7c8b6f08c4454d39bf7bb974de.1666190849.git.josef@toxicpanda.com>
In-Reply-To: <c733b7eb1cb68c7c8b6f08c4454d39bf7bb974de.1666190849.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3702:EE_
x-ms-office365-filtering-correlation-id: ba5aa4f8-ea04-4584-f37f-08dab2617960
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+/Y0231OKExOwIf/IiozK1hW8sjHSY7Z9njvPvotDJ+CWkKj3tNMP7ZdzknofhZZtf2tTPDr+BidHojuwgk40w/5wHQB22koYhRJ1uubwwjzlzz0CUBDO913eZbuo+Y8f7U2mEtTzfk66fSicEJNfYLbX+4mX6f3VQbHnn4WyzxwVJnLBzT6ZWN1N/ndzjrMTfstCLvZONLdZAkkAiJK2/NEkjPruBuMR70fHWCPGou2z1NXjAuULHUH85cYCj6/XskW2y519GQLZ61MjvP/ZEsXuNWM2T4Y0qrq0KzjWoPa8jlJESldJtmmHIZvKukiAqnHFU5G4siGW1yxvodWVUoxlCkIKUb/fcIpbtMPM7CEvkNWvC+3kFODMnQBCYcV4GDO8lrjOn8FEYCNztlgoQQIbX89XtGXs1jKanWzYEavuEBndZXC08N1y+699KmPfQVMkwDVvLM8XxySMPbWn27/dUz/VpJOiGswyrEKlypSvXF1tMg70NmeTZUeQLY1I8No2Yyi05zTNzJKWWE/GIJrA4+bRydQ25iWbQ6wkyrfWvI9rJPnnFT8Rcy3nwxApbsOdswjDuqtqVx+NKY/zA+GwfMMw0Ddq8/yI8gMqrSDTRIdJdQzRGKzJ+CH34AT9o3pcbjVYWSL0SSC/4r/bTtu/ouZv3prQU49e5+nGAvA5JU3BXpYmmXfv/kazPejyCSVyrQGjGf9uSj3UmcVb7SYn5MOdAg/GP3TGpPqcrwyq7oWdiYyN74S+svHOZrV4+mDtAF8itf2e1B5IK6INQc0JSrc5tM0Q5yGVUrugQQ5Gx/Zoi2FYEsxyQ+kfJnNWBk8A/9/jhNAsOhwS9qqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(6512007)(6506007)(478600001)(82960400001)(91956017)(71200400001)(8676002)(76116006)(36756003)(86362001)(316002)(110136005)(5660300002)(6486002)(38070700005)(38100700002)(122000001)(4270600006)(2616005)(31696002)(558084003)(186003)(66946007)(41300700001)(8936002)(66476007)(64756008)(66446008)(19618925003)(66556008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2dCYTAxMTNMa2lET3M1ZDQ3VXJvLzhkZ0UzWU9mRUxrc0RlVXE5RG9CaVBk?=
 =?utf-8?B?NEJVMSt4RUdVc1FHenRhYTVZbVVLeGdGSFMwbGQ5U3BpYTZYSW1INUF6MGNR?=
 =?utf-8?B?cmtScFozZWNtc01UaUFzYS9BRTRSa2xxRmhZbDlkUjZDT3QwMHVMSEhCWHlD?=
 =?utf-8?B?cFlrNTBGZVNQT2pmNit1cnZuMEh0R0FzWXNJL3JvdkM4WmJVVzZMTjJsZHA4?=
 =?utf-8?B?djNLcnRTVFF6TDB6bHA0UG5sRXZjNWEzd0xLODRvemVabXhoQ2xwWG5BZVFD?=
 =?utf-8?B?VDc3Nzc1enFTOW1PUCsxRllhQVpqSlFXWGlqYVAxL0k1ZndZVjFKWndRU1lx?=
 =?utf-8?B?WFREVlI3UllzVEhTZEtPRmw1WjZXdW9IMGthcE9OcjVvcU93OUNvY1grVEM1?=
 =?utf-8?B?RjFOelR4eEY5SzNJeW1OTXhYSFk3cTFFS2d6bUozdVpCb1IzTUdmSnRLcG9T?=
 =?utf-8?B?cGNIczNyZFQ5Q2RvZm9VdFFnM2pxa3cxK3RLNHl0QUpjbVFaK09HY3FnaTY3?=
 =?utf-8?B?VmU3b2tSanlqenh2dlJ6dEFJZWtzSGllNW1TcVU4NnUvNXBLS1JmcGZxMG5I?=
 =?utf-8?B?TVNrU2ZHbzFmOUlzQWpkMmJDYnNhZGxYNXhzcmFhWjd0RU5nZ1dUWWJha3Vu?=
 =?utf-8?B?ZGVNem9WczF0VEErS2pFeWRVYkhwZGpURVV2T1Rtam4ybEtTeXR5L1BLTFdk?=
 =?utf-8?B?Z3BEV3Q0aUVndU8zVXVsR0w4WEtnUnN2ankzZzhpNWRLMkVWTHJ1TnNiSTls?=
 =?utf-8?B?R2J3cnFYT1dYeFZ4S3cwa0lrZHR0MzFHMGNJbHFBMnRjQnk3dFpITFNHUmlF?=
 =?utf-8?B?c1IzeVpFTE1xVEZrUlpzZEs5eTY4T3B5N3FxS3dNYjJJeTFBbXNVNmdrNUIv?=
 =?utf-8?B?cy9saUJ3MU82dlNsZnF1M1JLSjBHUWJKNTBld3NCbUVnVHYyeTB3YkM0TCtv?=
 =?utf-8?B?NEF4VkxDSjlNbHZNYVZ0WTdic1NScno1cGVFY0ZVOXpSalNKVXVsQ2RJaTRv?=
 =?utf-8?B?Qm4yd0ZpZncvcEhGU01kenRIRFh3NTUyeGtYcDd2dHMzbUVzUkZnMmRBUHFu?=
 =?utf-8?B?U3I3QlpucUw4aTJxcElnWWZOanRKNW9QbkJ0VFlSazFwdUlCaDBiVlQ0aXVx?=
 =?utf-8?B?WURzUGRkNEh3aWtsL1NKVGRPM3dZQXpUL0RFNHk0OHdhWlFOL3UzdVE0STZn?=
 =?utf-8?B?RnZtdGR3T2hHTVlNYXVYQXV5eXJlSnF3V3dXallPYkJ1Wm83d1pFWU1qWUd4?=
 =?utf-8?B?MXl1NkJZc1FKSkFNRXNpelJMQkZCRWVOWjlzeDFDR2VJSEsvaTlHYUt5N2Fs?=
 =?utf-8?B?WnlYaW9KbERENEszUGhCQ2JzT292VVpJOGdoQzRYMmhMdGhSNmFmejJIZnAx?=
 =?utf-8?B?RVBEY2ZZazgvUXNFRXgrbmQwdVhHU1hsZU4xdHVkZWxVQ0FUODQvQnhoeDdH?=
 =?utf-8?B?YUZyempSMWI5RGFkejBzTzVjRDduMk41bGV0Z1E1UlNuSURiVFJtMW9iaWs4?=
 =?utf-8?B?WlhIdW91dGRpVVpJakRyYzlNb3hoRHVBWjF5R2M4Wmo2eGEyUng2TTllalBI?=
 =?utf-8?B?dDRhN1c4WVFsUDRyaFgrZDlkdEhPMHVOYWcwYkI4cFBUYzBYSno5V2hHZm5i?=
 =?utf-8?B?K2ljbi9uUmlLYlNCQktVRUhlNmUvaDF5SnBWUlNzRDBmdFhaR2prRkpSSVB4?=
 =?utf-8?B?RXBYQVgxWDhRKzZwSjRHNEluRCtqN2JUcnR5ZDZxaUdoNXlLS1BOVndSN1ZL?=
 =?utf-8?B?SHdBMXBSaWFrakZ3SXhpdVNqNSs5ZDh4dWlwN2xBWWxNTUhWczJIb3FtVmxn?=
 =?utf-8?B?ekFTcUZVUGJ3YU1EUFlVUXhWNHp0WmRxUnRHT1h2bThFSkdjUEdpYS9iZHdC?=
 =?utf-8?B?eVJWVHZpUVRMdjNwQWdhbDFCUVFNbWwwZjNRT1BlQlJYSnRjSGlsZ2QwLytN?=
 =?utf-8?B?YmI5R2pZRXF0YWhQZSsxSGc5clAzclcrVWVnU1d2Q2RUK3ozRXg3SE9wVHlI?=
 =?utf-8?B?TUNhSmtLMi9xV0VZSTFNOGZJaXhibkNxdTBwRlR5NFVCWjlzUDVhK1RvbzhS?=
 =?utf-8?B?TnBsUjdMZ3k4K3gvbjNzRWVHWDdITnp0Q0sxRi9EUTZvaXg3NEtsL3ZCN29B?=
 =?utf-8?B?MUl0RzlwMHZsS1p2MjZtbXJlU0o2aGRzL0ZOMHBTTHJDWUk5TTdrdGoyeGc4?=
 =?utf-8?B?bGtRVVNwSHlwM1JNaHNCVmNNcXVQWkYxMGRMUDBlMmE1N3RnRlJVYlZ0RCs5?=
 =?utf-8?Q?PcnXLnolSKRmfWI2zUQDEvcFAnvvxyyXCHmMgGzyzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A3337B1EE58B44928C8BAE30752BA5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5aa4f8-ea04-4584-f37f-08dab2617960
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:08:14.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBAyq7QggjgGRCKoSmhXp/EarhKEAriHI7fqgXPpnEWFskzqIGjnWcqL54wKCvBuYlJjmMNk96IpzrEpbV1XKxpImRVmXLyvuefAgcYmRYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3702
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
