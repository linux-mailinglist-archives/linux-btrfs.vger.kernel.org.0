Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADC63F0D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 13:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLAMsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 07:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiLAMs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 07:48:27 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F991C3A
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 04:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669898906; x=1701434906;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KgLZJwGAdZHGDbLBqhbMwiQTyq/p2/WZEF9nYtIImbk=;
  b=oeOxuxPRmXAE1cCg6eCXNSHEdsDVjVlDiWaNvolO++wUbg1nN6uIdt0W
   f8+I9i9WnYBj+vpoBpe2mFWXFOvZzHEjwPdw/lP8Ud1s/5esTa4lqe/zO
   VYWgUmpiwAYbHEw27J4mLtt8a8Tm1K+OQCLiMDKC83prmr+ouptVKqFCK
   0N+Jay6jHla92cUYHaF6mEV3bLmHt9pTnmYSZdC2pcVwK/7Z97ksuXKPD
   3TlE+DmznL1E1ENQmtSD1cbPy7smWRZwTGoUsoM3kg6H7/qQCRiJhdNMS
   JutFE7kEWh5l6a56111BEtXFss2qS4qQODVuJHrkkk+qmhI7QqmtDMYDs
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665417600"; 
   d="scan'208";a="329755079"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2022 20:48:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofgyby/qAnRK+Uu3488EMcX1yBiVkUjLOpEa0p4dPF1MwCz0hRrLZZtUWebZ1odMSEjtnICURHDrrR5uUqYbf6aMimBFZNT8XK8mVRIHffIeqKCIJZuyGWcnORVPDiV5YmXXFWbAjvjU45lC3WU2ESFN/6P5VYxdvLePom/pWvwVUe6jXesZWHf/iu8Fj30p/7oWlZRW5+tpzo5ussPQe51SxA0pvkhS4NLgDiyrfzogkzCibEqKWNHwgl/L2N0nwCt53rUNNAyOyCZTEGUouKG+dtXATgDVn61h0puORYPGtFTZ4szKmJ9o04U8jGaSzoqFdQZqSaNRAML6YuIixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgLZJwGAdZHGDbLBqhbMwiQTyq/p2/WZEF9nYtIImbk=;
 b=bu4o4yAlBiMnflyyrqP0ZYs3qWo5UYD0KrkhsfU9p9z0kaMh/6RfQgJZM0ZLaCgZ56q9a+X70zsH8QrrtzbEYZTrwWLFllymgugZGczfvgGrYEn8/YC1rVN//NfQoMuAliFto/nxlPaeoEGBMNyIoUzMcg77mWs7KKG/q1voS9I3QsS6xNp4QZvc11Y3peHaK87HfkHwVIHVrgshIDZXSrJl+6OQ9QVc135zI+yD7Tazdbvd/U9smxesg0UO26fypNUVbySrm2Rc7zW62S1ciO7y4wXP2rNLeHzmGpQZAMJl3lkuYsMKMOTB0dNZ73vZmKhxlxOL+0pG91YS12y2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgLZJwGAdZHGDbLBqhbMwiQTyq/p2/WZEF9nYtIImbk=;
 b=XykTaqTQqSHqxBsoMeDXbtEW3a3zjaUKbR+6ch1XRoUhfrYai5MyoU8FCHcdBUWSpQT2bVZbgKRR3GYDvwh2AwJxTwTktl6wV0IDTglIUWq8RPiZ87gX+40lDW6sr10Y4mE+35yp5+Jys+TQ/fEWHTo1g2JXRPBHZ/dycywdR54=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8244.namprd04.prod.outlook.com (2603:10b6:510:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Thu, 1 Dec
 2022 12:48:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%4]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 12:48:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: print transaction aborted messages with an error
 level
Thread-Topic: [PATCH] btrfs: print transaction aborted messages with an error
 level
Thread-Index: AQHZBNOiiVsazkxxv0eA+EilcNiNka5Y/LwA
Date:   Thu, 1 Dec 2022 12:48:22 +0000
Message-ID: <20e75a60-f53e-a9c3-8ed3-de74a1144d48@wdc.com>
References: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
In-Reply-To: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8244:EE_
x-ms-office365-filtering-correlation-id: 5fa91a9f-0c66-4844-6aca-08dad39a54ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B10TvdoeccRDJ3SWW4+Mp/pfewRuogF/qV+bgnl5plQvi1pZoXJb6R4NM2mOcd5O7hY/J7bGQ4AINONWrk9biH0Zfox9fKRAJ5oHP8LV0dMXwEMNJT5+807LunPM5CDi/KuQrw2ynzTSU4CV7aubfAXulnC8xBGqgXhAB4VR3UlwaOP5O6FiYfWVxGQ8VLY0hHt6xdQs8InkdSjIGVOXkkRO24V+4ZgbQrsNgoT4pRLoN5k5QlJxVwfn2vC2LQ9omSwE854cEaXTqrxUpWAlti+ixk+7GMqC+TXw9NlbtdKh58fY15YbWlAKZkr7Xs7vJyHyCd4E4l7VA4KBKMLn/X2gTkX72qale8HYyGaKpUpgup/W01Q8QkPTvymGc/6jrjAtcsAdyKouehenq+dyMREVaMp2KfrdUMgaU+mJwzpPhfboEEf607w9nGBqVJAMgYfepTmUK6q0A152S1PHYVe4tIeE+BH+8xIEjqV5mMhSac3gqaqXeuDJ9kfir8+O4CfuYXaoMT8zLH1VkAz+SSlSCRkKK1Uq00RyM6JiRa5iBPIY06G+TBPeXULoo1hbTu6SvZX02p2k+BTeiYpitY9JN7xJLIdAkoESX/xEHf+4NGVM29TZ4BTtAvmfrlDDcJDhC/KPNdwbrYcfuXXaREU7KCqN/6elXKtbMA24uO11KdqlonZ3EJ96j6bUrGIIxo1Ub9tATHXpkFRe1dXooUiY1FYklsMFLWwAAxak63X4a+EYVPH9/nfLCZpEyIkxmfknGBEoY0E4YoXWtjJkqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(38100700002)(38070700005)(2906002)(82960400001)(110136005)(122000001)(5660300002)(41300700001)(8936002)(316002)(91956017)(6512007)(8676002)(4270600006)(66946007)(64756008)(71200400001)(66476007)(186003)(76116006)(6506007)(26005)(2616005)(66556008)(66446008)(19618925003)(6486002)(478600001)(31686004)(36756003)(558084003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a08rcU9UNllYVG1kWk1MNG5vWjZIb3gwQ0RsR29DTXpDQS9wbG5kMTNuTXgy?=
 =?utf-8?B?NlJheWd6VDRwK29QNzB2Q3FXaCs1TW5IYjJqT25RcjR3MEdKMHJYV3JOTkdG?=
 =?utf-8?B?SjFNeU9QYjlFTmZjK3pjRjlwZUZaOTRMSjVaRE53TDBXSTh2M0ZZb0xtdCs2?=
 =?utf-8?B?TUE4V2N6TnVJRGVacGVkcytRcTlPUXhBNTNuaG42eHdFeERmTlhUKzJub2JJ?=
 =?utf-8?B?QkVrVmROVUxTcHdyQmhlMVg2NzhHZkQ3TGpkV2NjTTdoNnhSWjdNdmtPaGgw?=
 =?utf-8?B?amRNckp5TmF2cmNWaStCM3pacWlHZHhvY0VZMEFjejJRMGIrcSt0eXErVVUw?=
 =?utf-8?B?TVdZdzdneGZlK2VYbE1KWStJc2hjSzk3Nm95a29vVnh6Mk45VkkrMG1xWVJs?=
 =?utf-8?B?OHlwMUcveWRCbmErZi9nU2RpbXBrNTNWdXNBSWVkeFJtblUrMzh6ZXl2dUlh?=
 =?utf-8?B?SzkwYUVuUUVtVFhocFpYLzRqM2NYcitpODZNV0c0YURZNE9aWU5UY0l3TFBC?=
 =?utf-8?B?N1U5em5wdEh2VXVLUVlzL3JtZ3BRdkFlK1hmREkzWjJYZFd3SlFrNHNwS2d0?=
 =?utf-8?B?WTViMHcwNXJXcDZVcGZWTG05dm5UTHMrckhiTHV4TE55VmdBR3hEU3pETmtl?=
 =?utf-8?B?OWR1VUhEMUhaQTJ2WXA0czdYUktBaUhqRGRSOFdidDBVZXZra05oVUZtV24x?=
 =?utf-8?B?ZWRPbi9PZVJMOUJlUC92WGYyUVRvOG8wM0x1cW9kb2xoNE8vUXErbjd0aEU1?=
 =?utf-8?B?L3F6NEgvMGRSWXBwYVU5cDNOSFptM3JTTVNHN25GZVdNdmo4MjlLL2pEUzF2?=
 =?utf-8?B?Q3ZVVFQzOHN3cHRFMG11c2J3ZnV4UXpvd2tZTVhEeXlOempaZDd4SFdsZ1FJ?=
 =?utf-8?B?K2g5NFlLdVI5eko4bHRKalpqRUJYS0dXMmxVSHJPTXlRL0N5ZDNFbVZZVEEv?=
 =?utf-8?B?WFpmQnhxRk52UTZVSzJmNktEQmR5enJlTHJSaWtwYjJKZGhheXMrK25JektS?=
 =?utf-8?B?YVc1UnpxZGc0NS91UGJMcDQ2dTFVMFJwY1R0cXltdE5rU3hCMGJzQ1JYSUVD?=
 =?utf-8?B?bGlHc3hNVFdUQVBnU2xpWlJuc0EyT2NleDM2elV0Z3ozZ2NrakJPWmgxV2JX?=
 =?utf-8?B?ZVplTW1rb2RWQTFUTFcxL1phbUREcEVITlMvbW1TL0pSTnhIbWxUQ3hjTnZo?=
 =?utf-8?B?RWNES2cvU0JjUnVOVVUzT09yaHpoa2lkSnNVOXJsLy9EVHJMYldOR25VMC9x?=
 =?utf-8?B?eWk1eEtzcm9HS2s4Y2Y2RkdlTVh2Z2ZLT3dCc3A5MzZFM21PVlZkVHNLQmZp?=
 =?utf-8?B?Q0lEbEFvci9SM1pEUmkzaWpiVU5hQ2dhS09rbmRzRTVwQWFLTnFaSlJrR0ZU?=
 =?utf-8?B?K0lobHNVdG15K1o2VHdIZGM5R0ZjWnpxbkNLZWF3MysyeVdjQTBGbHFCYnR0?=
 =?utf-8?B?LzhnU1lHZHFrcGxkQXIxckJqaUpINlVVRGpaNGpDeWErUm1JRlBjRzRMQUNH?=
 =?utf-8?B?djg5dGk1L0RVU0JCWXlLc2ZMT3dncGZxUEQ5VmVtRVY2TndSS2lldGF6Y1R0?=
 =?utf-8?B?UVdTVmdGSjlRYkR1WXZibll5dithNDZ2TDBtUnVnNjNRTnRHdDhVYUtsNDN6?=
 =?utf-8?B?aDQ2R1lpL1BGOU13c21WVzRlN1JMQmpwejBxbm03aHE5UTJTZmIxcW0wcDB6?=
 =?utf-8?B?QTdabmhnMHVGVjA5OStXMUN2WWMyNEFnNzFjcHM5MUtsN3FXOWgzOTNOUFZ3?=
 =?utf-8?B?aGlNR3pxb29HZGRyWFVxNVp1QjFkM1Vyb2JKWmdQWGU2SDF5VFJ6S1JQajlY?=
 =?utf-8?B?TjdFUSs4WmY1Yk16N0RNWllWeSs0ak40ai9yUURLWERvUUdTR2VZbW5zZE9G?=
 =?utf-8?B?WlU3VmRFaWVBN1dLSTBUZ2JEZmZjNGptQmZUTHVrK29IWHFDNW5VeWRzNjJi?=
 =?utf-8?B?STc1eGp0WVdWMzRueE53ZEhPUEJmOGVtcGZCMUZCVEJFbzVMMWlIaEpkVU1q?=
 =?utf-8?B?TG9FVWZvRXdob0FCMGFvVmsvQ2NZbnpDbVEvTk9iVVhBOXljdHVyT0VTNDZ4?=
 =?utf-8?B?cW9sWlI3L3A4a3RKcmNQT1F1QXNJWjZFd0FKQURYbXppNjFJenlRaGNFNE80?=
 =?utf-8?B?WXltQ2lERFZVWmZjMHhDTHkvbTQrbnRNd0FvRXM5ZzFWRngvNEZjOGMxZHds?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF5345678C864040BD63E0CFF8031BC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y1v7ElQD4LQISUuG8nc23JqDJ6C4cb5ebpZtcczkh/bnqu4dpEiFiEs05agXa0e7BkwhgJpLzzaJLGx0cjxlyQKUtPcOmeu/7Dkzw6FDvgG0sHTNRk40wY+BlsOnQ+mHlw0r4Yl9/aCXHcgAhF5R4PTZp7rAxEeyrCOIQ2mAWqBu6UHCLNvNy+UX8q7tG4wYvIObRcK+9JduTI69ZhjJX4xh60f96Gx4J3bidYdPtmC0AxcefUJPaav4jQp4GAW2QTx+MyJsqibDkvg2LmHBZODTfflc8akdhIVVfyx4zpC8VuqKZLA9Ykn6CqccEklUOtZLjVdYQbnPeNTSzNNH5oG+zL3Q7ySZ8crpQ0NxYTsI3/GB429sWSizI8l1U8flAUcDtoKMD1Wmi2e1AeN0uVUQZ5Q+f2Xt8lS2j/JmCZ8kHF2iUQCPX6OtpQJpTaZlDPvGwZAIIc+KOyoUsy7Pc7jCI3LLc28Ct32Tykf/gXfmtEeNu2A5cAVavU1NcTwLcOo+SGTaUL3OC4Q3ViCY3nSkgihv+ZGyMXd8yzR+KVvNAYOi+kXBdnh2RwiMkTKjaQjuqnGiMd1mpH9NwOgN9PifRkv7x69f0D5L5csZgRpzXlGf+Ya/qO1BQ8rWJtCpVJukP6o2kqUOr7AueDPrJcYykswiiSDYfE3G2b4rceD99PlWAiL6uf2hY9p9lUqaUW5eUKniTlHtMjBPU0yplAVBFs5e+9uIIN2XoF4FUE9x9bG7rzXLJ4iPkNZ8QxSIXAlo2woc6+7GQOJPlr4BpB3VYiWMU/YRMPanJQuPulz/osGK43go4dc0hnBoUsum
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa91a9f-0c66-4844-6aca-08dad39a54ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 12:48:22.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79U3P1cfPafT71N4yQB5PmvhE0xjsDYvJPouR4zkIZEXoIIkYzESiZLYh0cnuzNqnhcBKdiANZHaQXjHpmpjdSSyEwRs65LVyctCuJ2TQhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8244
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

R29vZCBpZGVhIQ0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=
