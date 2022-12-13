Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8964B1B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 10:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiLMJBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 04:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiLMJB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 04:01:26 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B2101F9
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670922080; x=1702458080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBoSyW/W9TXUki3IywNLPJbHcKyoBbn8tv8To2X81MU=;
  b=WCq6+VF00msBQooLRzrzghFM1zU0UZW7/hllrkMws+K6mtSO9z7uZFR7
   9hX7Zsa3AckA2STz0evgwVqwHYNXQ0RxysjBF006J+SR88Z6IuBDQuAiq
   QRZ/Qi/5WbnnTBHbBxeHVDaxivNQa4EkTUcnZD63B1LYF9KmlwWUD/VhV
   5lX1Xf36x5PRIiHaD8ji/LL9rs3tz6hXKnRTf+eOWiqOFZB9D8etNpPnL
   1J8DdW4hMHtxWmxcjHfaomsVp18PeqNRaY5a0V8409PLiM0vcIzEmwEXV
   PiIrh9Nb1Rpx+DhiQRm+YusDQbJPiYhmRi1bJE2hgRJiL6lUHNFhTlYeJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665417600"; 
   d="scan'208";a="223677708"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 17:01:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjqejU0kZBg6h1QvwGmGridqs/OowyBtDjLbCSPbXBZwP/zgDttyrVj+qPMjc90zkF4fmixhl5C1avPooc7WL+hvUqrY6V7jxOnSNIXJD8o5ShfbByZBZdO6xtDLQZ/1yWQQ7GP6IC/zfF/cmQjoAZFNLzEEuUrR0viA+L9LuHq2eUqtu8x4arOWoyufsDEAj5Q0V5HjRg/vP8wBx8+9J2mpTLKdERYG1upn475gItMsUWIrBAngCUvSQN0utDdC/6EZQlWpDOlDT0DUfj5qSykLu/dq7B1oRyTlNG2WfpIneOT+xx8y9Mr+0o7nEvQqa6QwWO/dHhWuDTWuLCRKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBoSyW/W9TXUki3IywNLPJbHcKyoBbn8tv8To2X81MU=;
 b=kDivm9FdsNJyizdaEGZjjWM747/kMnKCNDaIut53GtqpYXnj8jnQtnu3o8o5vFnO9c7kyd0ryzLOVkDs0FIvXbWmjVWslKsLfJAoJVop/cjk7y8zQRV96aiGMF0EcWdr9zn+ywtp0G5RIUbpLaJ9tS5U2w8wRyVcVpRmuBP5fJQhFGF/JzlQhuiHqJY/7VKn/z9nbg3HBbMtpM3RXmtbnAlkWaDwFkEGzuLvstHc18+BbhzbHobI23y8uA17BrwNAO9JV9VH4hTMjd/G6HJVzq7Uyi1jO4enpzxTqQYaT+aQBXf6n+Io6tN3gYgBB9rBT5coFOIKIfFlhqiJIB7iRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBoSyW/W9TXUki3IywNLPJbHcKyoBbn8tv8To2X81MU=;
 b=ZMG+bQ9scIwSdtPu7CUFtJg2w6GbKqr/hKI1xhQ4zG+ixfmtXY4yh+cDkvdPlLao8xeCFkrkOAgDRYoG1ZYm0o5WnZXha6bwcqPH0siDji8+skmMBUsQrY5pENCGGmXAzTVly3wPTjtqAZp3vmYevmwQ3eSnOknwOgqhcGnMGFY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4581.namprd04.prod.outlook.com (2603:10b6:a03:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:01:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:01:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZCkdbJyiBsduuyEOE+tpnuJRQAq5p4G+AgAGhMQCAAAXygIAAAwYAgAAB2ACAAAHrAA==
Date:   Tue, 13 Dec 2022 09:01:16 +0000
Message-ID: <72edecf7-22c3-b5dc-a247-4502a8176bf2@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5bWt7ENo2OkKK+v@infradead.org>
 <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
 <Y5g5q1O4dj9e04E4@infradead.org>
 <008a8c15-6ebf-d5f3-f64c-8e53d8bfa889@wdc.com>
 <Y5g9wL8CwGTkD8y7@infradead.org>
In-Reply-To: <Y5g9wL8CwGTkD8y7@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4581:EE_
x-ms-office365-filtering-correlation-id: dc786b48-8ce5-4ec4-f1e6-08dadce8981a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMWF8JGNU1yNNNBFY89hgSBO63D6KVANc11clRSCTL2VbYsoe7lZE8lKx9KCE1RGo9U4cwkYaeiKLP7qCyMXN94RAmb4COG2TM64iz+g4zkHIp52rhwSRAcAm5PdUUtSioca9+LbuSTpd96KpEvTZruVpTkQp73cyq/dm1Ylh5kmyFNWBN3Rg6T1UZftOUs4uJyxkrKW7kTkGmq6ZRP+JBemfrP6zbL1rvl0iVPb8Z/KYFrwmBGTyq7KeN6cSpIshDwhkrGpiJJqTKugRMXXyioleKNquuFZdf+vq+tINAwaUH777zkjTCE8zCy8KGM+MeklQawvMrHhF255gZ5ZvVBPR+0JOhHqfr45QW/MxUXZcoQ2i6gM2GIkzThbn0659rQzJB254mew+CZBBnNEk+baCeQp2ZJv1gm6glOoud+3Plh7EXBPIJlgiHuhZp8bFwVhR2JdOYi+I5qyzV1zH6gTmzFhS6Blt4VTtzUUoN/arGIlV7fHPG3XsSCOuwMUqL9Q0xjbkZ5AdUmE6zZIH8HCtqOiYbu4BskmvG7QzbHnmk52CWJLR9bxoDUOrmzZjQrJwMCmEv0mlW8VG5Qe4M3ub4NuHifiFdXm8d5rQOaKGeUnJXuNVDi6nJ0Rk1qWjJsZh5czzf+MxaREscBoGcvIThd9/Fipq1kCmjRYdYB+OMkBkt20hV0Lf7k96Y3VmU0uwzINhZCnL7455vuruFWV7qEHbi1iuPKI3Iy1LwU3m6pTj6xmBvurNeDPoMpjnIbhR6lzNf09pc3mTbRNKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(2906002)(4326008)(66476007)(66556008)(64756008)(66446008)(71200400001)(8676002)(66946007)(41300700001)(316002)(8936002)(54906003)(76116006)(6916009)(31686004)(91956017)(2616005)(6506007)(53546011)(6512007)(6486002)(186003)(38100700002)(83380400001)(478600001)(36756003)(38070700005)(122000001)(5660300002)(86362001)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2dXOVdzZzI3cjZPSWlRUzVTZW1HVi8zQTBPRzQrbmlFZmhaL1Q0bjMxaDR0?=
 =?utf-8?B?d08xSll1UFRiejErQzVxaWVoS0M2UFJWTU1rSHJFaEEyUkJUN2p2QWtJSWFZ?=
 =?utf-8?B?dGF1d1pNU1hQWHkrU3ZseUJJdEVGd3RuWHJxMk0wSENOQjdLdi9yY2ZhVEdE?=
 =?utf-8?B?M3dUbDY4aTkwWEJLdFNOUldzMHRjN1ZYOWtpNWo2RUxiN0V0VHdCaW1naVQz?=
 =?utf-8?B?RDdjeEU3WHo3QjJ1azI4L0ZBODU4NHlMc051WWl0S2pxeUFFWGY0VHJUVytk?=
 =?utf-8?B?a1VQd2xWNmxuR3EzMU5MQnJmcDUyeDd3ZURON0xkeVBURCtPOGE0bnIzeUNI?=
 =?utf-8?B?cS8xWXNhb205ZTRmWFJRZzNJT3RVTEtxMEN1bDBrL21XTnQvZ2FKb2NFMEQ4?=
 =?utf-8?B?aGpHcngxNUFrMERLTFZvSjZ0b1NVK1BsOVdHNGRJNjN6ZTdBRnkzK2ZkMEZi?=
 =?utf-8?B?Zzg4M1J4Y1poaG96cEdXZXJ4c2QwTUQ4Y2lvTFNmVEZ6cDFJQVIvOFpvV3dU?=
 =?utf-8?B?cG5NRDhGRExRMmhkUTlBRlp5OEprVm1YOWlDNjVhQVRwYjdBN1BYVmpwWDhi?=
 =?utf-8?B?TzZodzYwQlVWT1MyYit4aERnQ3BNSk91V2RXL1FLeTRyWHpIYytPek9GQWgv?=
 =?utf-8?B?NkdTUzFsckswQ1poSTZIcTlFM2hNUFBUMTFtazVPK3drV1BPR1BoS2l1SWxk?=
 =?utf-8?B?ZXRwalVPa05rYmszeUUwQXBzVW5nMTJGU1NSeGpSMzNNSjArVnp3b3A2U1Zn?=
 =?utf-8?B?Wm1KZlkrcnR0WUpYOUt0YitGMktZbUxNdGErNU1TaEdYMk4xSFduVUUxN0tV?=
 =?utf-8?B?MlBVQUVPY0dXOXNyandaYjR3YnlTMDNGVUNML0R3dlN5YVNiMHlsNWJyMEFL?=
 =?utf-8?B?NTVGMkpZeDRQVVhpYXdwVzI4UFdtaVAzZUtHK3d3MHZOM29qbnZHeHFIbHdS?=
 =?utf-8?B?WjNWRlJxekFBTGJwY2tidHR5cUs3anNwVXQrODlTbTJ4Wi9lQzdsMEJYWWpm?=
 =?utf-8?B?eFhkYndVMVd5NnVheHRPTGJ3R2RZVXpIMnpmdEQ5U01KWUhEdG1RdTNDUXNW?=
 =?utf-8?B?aHk2aFUyZmtMb0VVaEg0a0ZWQXA0R2lmc0EyZnh0K2E1Vm9tNjdZVnRGcjRQ?=
 =?utf-8?B?aWxhb0djWlBhWVBUUW93NVVmNEJyNlFmaUF2dmM5WFU4TEJnYWcvSnZKb0lx?=
 =?utf-8?B?VGFKOWkrQkY5dVhEcS9nSXlYc25kc0xZaXk5R2V1TG51ZTM5RmNNOTB6TjdI?=
 =?utf-8?B?dEEwak0wbEVwNVhMdEVoZXJzcmpMYlhWRzFoYzFldmNwYWxnQlNEYVBEdGtI?=
 =?utf-8?B?bTdGbXIzOXdhQlJwdklhM0hFZ3RnVWh3L2tCS0x3dkRvbDllaDlSMnBhVWtk?=
 =?utf-8?B?UVR0ZURWdDdoSmZlTW1zZndaSlZhZENEVUIzZnZJRzJXUGJPZ3RoWEI1VEts?=
 =?utf-8?B?d1lVMTJ5MjhVY3NnWDd2eENYMnBqOFB5YWtONWJjWmZHYTBmTzFzMVBYVjdB?=
 =?utf-8?B?K3pyZFNVbkQ3aU1sUGd2UWNmZ3VLVlR0OFptcDR2ZVBvM3lDOFlSMEYzSTNl?=
 =?utf-8?B?dzhyeDU0ZUc4QWlqOG9SK21tY3RtR3lkMHR4Wm5sVCt0NzRmaDJOSGl1ZFk1?=
 =?utf-8?B?TFdhSGxKYVpmWWluMUgzTkNKay9sVFBjcFZIUGdrRG5pZitvSFIxbmx5T3Iz?=
 =?utf-8?B?L2loMm9oNmRJdTlMeW5BSVo2cTdUbkNzL2R5VGhycW9UYWo5d003SVVReUVo?=
 =?utf-8?B?dE1Qcm1YUkdYald6RnRxWnh6bjNSRlFGWk1Xb3A0Szh6RWF1UzJkeHBEZXo1?=
 =?utf-8?B?Mk5nZ05VSmdua2VJMUhxelFFK0VwcjZnbUN6WklkS251ZW9reWZtWEowU1gw?=
 =?utf-8?B?MlJRWDJaSkV1ejVqbEhZcVVMZkN4eGlOV1FvNm9td0tBamVjUTJ0SUpjeHI2?=
 =?utf-8?B?K2lwNTJIc3BXT3F0eWlkNmlyeVhHbmtOVHNiZDhCV2xNLzhHclZzMlNjWWlE?=
 =?utf-8?B?aUlPbDYxMXpna3BtN2NpZlB3ODVmUXArS1RQTTV1N28za1o3N2RxTG5DQXQx?=
 =?utf-8?B?U2xxczNXdzRidWRHYkV6bGxZcC9ySzhrM2VJM2JIdnEvNXhHZWhXdHNrZ0ds?=
 =?utf-8?B?YUlmSjlUOEpmTUZuaHUraEtnd3pYMEZHRWUxSDJUUEozaU1yWUtRZHpXK3o2?=
 =?utf-8?B?L0k4SVYyQkJlZ3U0UWNhQXJBbkZNK1FJeW5DTEZna3FDY0owTFdDOWhZcG9P?=
 =?utf-8?Q?hBo/wZn71K4JfeM8baHTrXO4Kf5hEOKCWLmQqYbDBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9444B1CDA802D439A0DBD69D45AF45C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc786b48-8ce5-4ec4-f1e6-08dadce8981a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 09:01:16.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05+P6GQND8TYERzsULk7Hv6SDQdNDXuyCUboZLUftlmTkM3H6/T40W90/XRaQ43DVG5U1CQoYi7NqVvM2fJOwkx90Kn+L3kRoQ+NZ235FiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4581
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMTIuMjIgMDk6NTQsIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPiBPbiBUdWUsIERl
YyAxMywgMjAyMiBhdCAwODo0Nzo0OEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBUaGUgcmVhc29uaW5nIGJlaGluZCB0aGlzIGlzIHBvc3NpYmx5IGxvd2VyIHdyaXRlIGFt
cGxpZmljYXRpb24sIGFzDQo+PiB3ZSBjYW4gZXhwbG9pdCB0aGUgbWVyZ2luZyBvZiBkZWxheWVk
X3JlZnMuIFNlZSB0aGlzIGh1bmsgZm9yIGV4YW1wbGU6DQo+IA0KPiBJJ20gY3VyaW91cyBob3cg
bXVjaCBvZiB0aGF0IG1lcmdpbmcgaGFwcGVucywgYW5kIGhvdyBtdWNoIHdvdWxkIGFsc28NCj4g
YmUgaGFuZGxlZCBieSBub3Qgc3BsaXR0aW5nIHRoZSBvcmRlcmVkX2V4dGVudCB0byBzdGFydCB3
aXRoIGFzDQoNCldoYXQgSSd2ZSBkaXNjb3ZlcmVkIGlzLCBmb3IgYSAyIG1pbnV0ZSBmaW8gcmFu
ZHJ3IHJ1biwgaXQncyBpbiB0aGUgdXBwZXINCjIgZGlnaXQgdG8gMyBkaWdpdCBjbGFzcyAob2J2
aW91c2x5IGRlcGVuZHMgb24gdGhlIHBhdHRlcm4gZmlvIHNwaXRzIG91dCkuDQoNCkkndmUgZGlz
Y292ZXJlZCB0aGF0IHRoZSBoYXJkIHdheSB3aGVuIEkndmUgYWRkZWQgdGhlIGxlYWsgY2hlY2sg
b24gdW5tb3VudCBvdXQNCm9mIGN1cmlvc2l0eS4NCg0KPiBzdWdnZXN0ZWQgaW4gbXkgcHJldmlv
dXMgbWFpbC4gIEknbGwgaGF2ZSBkbyBkZWZlciB0byB0aGUgcGVvcGxlDQo+IG1vcmUgZmFtaWxp
YXIgd2l0aCBidHJmcyBhZ2FpbiwgYnV0IGlmIHlvdSBuZWVkIHRvIGRlbGF5IHRoZSB0cmVlDQo+
IHVwZGF0ZSB0byByZWR1Y2UgdGhlIHdyaXRlIGFtcCwgc2hvdWxkbid0IGl0IHVzZSBpdCdzIG93
biBzZXQgb2YNCj4gZGVsYXllZCByZWZzIGluc3RlYWQgb2YgcGlnZ3kgYmFja2luZyBvbiB0aGUg
cmF0aGVyIHVucmVsYXRlZCBmaWxlDQo+IHRvIGxvZ2ljYWwgbWFwcGluZyBvbmVzPw0KPiANCg0K
TGV0IG1lIHRoaW5rIGFib3V0IHRoYXQuIEkgbmVlZCB0byBjb250ZW1wbGF0ZSBvbiB0aGUgcHJv
cyBhbmQgY29ucw0Kb2YgdGhpcyBteXNlbGYgZmlyc3QuIEkgYWdyZWUgaXQncyBhYnVzaW5nIHRo
ZSBkYXRhIHJlZnMgYnV0IEkgaGF2ZW4ndA0KaGFkIGEgYmV0dGVyIHNvbHV0aW9uLg0K
