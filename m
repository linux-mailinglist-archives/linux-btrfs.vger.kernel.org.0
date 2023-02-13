Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97569434B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBMKnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 05:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBMKna (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:30 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5817145
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676285007; x=1707821007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cjOsCINnKsuQHY5YJ1LrZAcHfc+Sz1zieHSstrpEJyU=;
  b=Rl3oH6AnzVvNXvRz1nWDJWKkbwTf1YWROyqnyolAmRcnI6G32gVJ84dr
   +JAhJO5x93/wfmHc0cWTQ/T1IiLqTwyCCTgwqxifonQKRl5Dk7mPQ9cqF
   1FKHRKIyYGONJ9wY2op1BPWZHa63EXznvwW/SNuIfg+3Eb7JYmoTYKg0Z
   DRukOzGTzzX4JqK+6muknRvN+kply0ppAKaAlH1+IUQ3BVhU+zl6dNJI0
   SIlBab3gEhsQYa6lop6l0FBZsvVYsviic6Yp1CHc8YkOruY1KvRCpTgk6
   xMQKvS0re1pCvAKTAHKsaOoOG39q1YUicKXqsYp9Og0mLNGqt2ENPyD1W
   w==;
X-IronPort-AV: E=Sophos;i="5.97,293,1669046400"; 
   d="scan'208";a="327470498"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 18:43:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWQP5rw0kAHtxFY3ir47IblPFF8dETU8prVl7FB6viXdvquqFfmGgmW8EgDh2jK0bjKkJNsJLsJQxyb/tAo2qt+EvoDPlmIFno2kBBBTNzq5lGMY+nKg10vkuZE2XJC/LRfWdJwwWW8T0RXY16Bue2yV7HsAdMMnCNg/M2/h1VhJJgBph7RWMTnvY0geeurApr49hPMA8J8ttR+TBG63dhvKGyQ9nYBGEwZEwonqLSLlay670s1ztOwui99TCXxaA/pfFsafsjUUmLSF96WtRAO7lR1R+y77SATwJZZry8RPCpNWTklWN372b+o0+8GWchfa/qUS9/e7eI93EH0S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjOsCINnKsuQHY5YJ1LrZAcHfc+Sz1zieHSstrpEJyU=;
 b=hpjjEK+hSl28SKiRaxNgsBrBkXaH7UxSpcsuxGCYRpyLub1MiNa0hEZtzo3SYxc+dfbMzYehJStbPp6MFuiqb8obXM+KE4WgEK8I5QRenesAaO8n92dILDMoCg4oqoD7QBREd3r7MhPjXwiAg6C3hMkkEhehoOoRUKot4PoO4hzo8939QZ4FQuXiJwUZIRw5VcelNFb/RqRbk+P6DXcWhQYbr0Sp+Cs35HmmhUbas27++Fjhk42PhSZ8ih6H666AvfIdZQc3vJL5OH6KRKyU8U7A+i6lDfOUU4iOoUxvqcFVLP+Tpl43eKHK1fmrCBqSqDqcNEaF2QIYCoyc3tmBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjOsCINnKsuQHY5YJ1LrZAcHfc+Sz1zieHSstrpEJyU=;
 b=OEqJUKB/V2PjmgvEnxfmqSXO1l00kS2IOYv2CbzpBVaeLHaci5vx6WDYKSmrUG3NX9RR3A4r0tF4yLEFG+9tQeKsLXypEY1Nl4SraQsk8MxGoUMEJh8LzhkePHd/cw04ABYHmdOLT7TOzfYVdhcrzzlswA+cBTu34f4X8YwC4tU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3603.namprd04.prod.outlook.com (2603:10b6:910:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 10:43:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 10:43:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZO6w3+DMLZggJn0KZylohlYh4hq7MeXSAgAA/LwA=
Date:   Mon, 13 Feb 2023 10:43:23 +0000
Message-ID: <7a0bba23-3f01-764b-a1b4-b88640b02b3c@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
 <Y+nfSQ6fxhDooglb@infradead.org>
In-Reply-To: <Y+nfSQ6fxhDooglb@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3603:EE_
x-ms-office365-filtering-correlation-id: 2b4735b2-8d3c-48a4-ba1a-08db0daf215d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48TG4swUmmKLLx0ea2ErWzYXVGsPcVSSdE0NwiMSON/Usv8IPBelwkfTcto6Q3LCP2LLz+o91V4UaBM80pjvY/0lWV/o7lAMGT19n4BoL3sNuzDetj2oqhKZLz7e34ze6cc1BNNzbHbEkV9Ne7BoHshketFK6+1Fsn3IzOP7c/lXbgpJMFOLccFDFF2pcjYuU8WpXgLe82h/mcBoydw6EnAhP6+f0bCw2g5cnrtqK6atbDjdN0gY6PDtVmCrA5uBBkc4TFn9k7WLQ3jGZ7Fv7Gs1lNJQ+Wg+QJYNUHlCoVUyMpHHVYz9WJeOCnieBeAx3VEJioIwYKHco/qB5Mto2hAkO1E42fUXH7+0hH1PFnhpJrjIo9q+QyHYgMcjpsCREsDPsOe9qgG6sqr3nyr3hwQHySu3MqB0Ghk9+mldnJWgwS9ino0pqht7/3B/p/3bwIqtLjBZ+jz1L5a9npVB6KkwKb1YakH0Acztrz4MQtsMzom7fbMjzfIq2KzovXPhlQzWpj2xT+Qj5TfJghvh75QlADNXEtspB65X9lybvW4fDOUuSUeaV5eG3wWQ5cY6pWhVu8xacZkEaTQYHvZhhFt0n5zCOfoDkK9f0JY95YhG99G7+GUpmy/GbF7mjqQ3sLr70g4g+mLW7PIbacU3RHknXsqG6ftr6jRyvE8aevV/pvuH8cPyxgLNZbZtrytDhYqQW4OhmWMQxONFMkZLyaHTKjbVe68UKe9HiJXtFIA/VCzkCkUtZqFPF8JcDG4sAP7TjNRf3Ey9/NTCmzbPXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(5660300002)(71200400001)(186003)(6512007)(6486002)(478600001)(38070700005)(2616005)(38100700002)(53546011)(82960400001)(86362001)(31686004)(31696002)(6506007)(122000001)(83380400001)(66946007)(2906002)(8936002)(36756003)(64756008)(4326008)(66556008)(6916009)(41300700001)(66446008)(66476007)(8676002)(91956017)(76116006)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q24vM1hBWTkvRXlyYXVZUkVUWFZPbzNrTzF2Zlk4dndrVmhEYm1CVC9zYlBl?=
 =?utf-8?B?R05WVUNOMUhwaC9Nb1ZzMmM2dTUydllTTVJaTUxUSHR6Vk5VY2FMR2FQcjEw?=
 =?utf-8?B?ZWRqOUI0R2JyQmhacERhNjZwNnYwbHpudzJFelZ0RTNkSXBUUkk3SlJjbW9W?=
 =?utf-8?B?R1YzeGxOSTlmRmJ4YUhEcFgrcUduZ0lyQzVrZklMQ3lnL0FYMFRiRjdCZS9k?=
 =?utf-8?B?ZTJYc2FFWDdRNkVTTUFSWEJTVVVxVWdIQmI1aDZOR05ROHBVRkx1MDFqSzBu?=
 =?utf-8?B?TGhQRG16SDB0dzY4QjB3R1VsczRONW12cXc1Y05SM01qc1AyRzRIbVBiU25h?=
 =?utf-8?B?clFPMXBQNG1vRlN1aDZiNWJrbW40NW92Qk9xV1VzVEJCK0MrVldUMWpkcXox?=
 =?utf-8?B?ajVic3A3VjY5Tmx1d3BjWHErUGcyd254RldEK2RkNVZRWWkxZnAwSGdNZXo2?=
 =?utf-8?B?QXVEcGZpNWpiaXdGK3dmZXRWT1YyVGR6bHRGNlQ2L0ZWcGUwVERrdVlLWXhJ?=
 =?utf-8?B?NThGaTl3cUNzb2l5UCtEYW1KMVpHQzJnRWJtM1FOc2svdnBVV1hvVmIySHVH?=
 =?utf-8?B?d0tXQ3EzaG5haDRUUGhSUUVLemtOYzVuYTFURjdKd3lmMUgrMWo4ZFZxT1Fl?=
 =?utf-8?B?UGdVa2NWejUwajlLYjByMzFOakNma093Z1d4bmpKejVRWVZwaXNuMm84M3dJ?=
 =?utf-8?B?SVRBbTEwTjlFaG1SNzNERlR5b0pVQVZERVNMZXJIaWE5N0hSNWU5a1BvTkkv?=
 =?utf-8?B?R3FCRG9vSVRVeWhRdTR3TUg3Y0IwV1RLTS9wWmpySEtEZFp2Z2tPcTNxYmhv?=
 =?utf-8?B?Tkd4RS8wL0NwN2RHdC9kYk4vSHBRR0RVR3ZlVjlQUGdTWjJHMEZ4UU9HV0hK?=
 =?utf-8?B?Z2FLWlBHbkJoWGpOT2NPUlBNNG9UcDhqeE9Vd0tDTnpUYnNrS3cwZ0VSTlls?=
 =?utf-8?B?T240eXViS2F4ZE16ejgvSVd4cWptMGJJVFhsWFRzWFE2SzRrYVNFcGFKM2ti?=
 =?utf-8?B?N2E5SFJ1VzdLdUJwSWJTU2tHZS9xSkhINTYzZlRQdnNHRWNQNHB0SjNLRmk0?=
 =?utf-8?B?TXJZWGRvaUlxRjFmRS9FSzE4Y0tFZmgrQ2F5UkRKbWF3ZTU1Rk5RK29mWk9K?=
 =?utf-8?B?R2RYSU91MEcwckJuRVg0QmFSSDJHVUV6MTZSTHpvTjFhQU9qR0NjMFRaYlpP?=
 =?utf-8?B?aExCdHY5VnJza0tHak5WQlc3MTBFU1dGQTBmanI5MTZQR0RYSDFDWUx1dnlj?=
 =?utf-8?B?NzVablNaaXU4ZmF1dXRKRWttWVdWOVVPVkw5TzQvektMT3JObFl6MGpCYmFT?=
 =?utf-8?B?bjgwbGVRYmFmRFNjdllMajE1ejFJTDlZRmc3OXV4SjJkck45dG1Nb2pQdmJp?=
 =?utf-8?B?a2RVZ25kaWhPVyttQUtwekd2aFBwK1pOdktsRU5RREVpK082ejFOVnBPZjE5?=
 =?utf-8?B?VGNYRWFLU2d4aW56MVRrYVc4QkM5QUk2ZExBQ1RmUm1Mc1VRUHdLREpPdytY?=
 =?utf-8?B?R2ppL3hFQnIzOGcvdGVQaVJ5d0FGRmMvYlFpYVo4bTl1RTdTLy9QRnVmZGtR?=
 =?utf-8?B?bXhEYmc3eDJRUXlmTStzM2NjME9FS0VTSGVZNUdYWEIrVHhESE9qbGlBcnBr?=
 =?utf-8?B?bWFYOENPcUdhN3JEbUZIQmpyb3lTSXlxcWZxbERteTFPenpFYkNzOHN5MGR0?=
 =?utf-8?B?cWU2YUVaQ2pyTGdSbUI4V3NhNkNKaVNBRGlCU2pUNzJLRnppTjRhWDhGSURU?=
 =?utf-8?B?Wmc3OGJEY2tabWpJTGswVWxrVnpsUXFuN0dhTlZYUFFCaElueVE1TERmOTNn?=
 =?utf-8?B?Tmt0Y2h5NmxQS0hGSXg4a0pkei8vT2oyYUlXTnZaZHVsbVZWa1E5RGhnUFVu?=
 =?utf-8?B?RXlrUE5xWkZaWWRXSjlvaVJIcThKZkJwcEwwZk9oU2wybnIzMWtESGlSSzF1?=
 =?utf-8?B?U244aXpXV1FKZGlZT2VLOVBJNEVvYVgxQm5uU2hJTlVacVlRZWpyT1h5Wk9M?=
 =?utf-8?B?WFRBVFlmakR6Q3M2S0FuQUd1ZG5ObzEyam1MOWQ2YTIxUTVQdVRTWDNvNGNz?=
 =?utf-8?B?R2VrR0ZoOFhzUWhwdEFNSUhlWG1nT00rRStjYjR0SEZTcmhTUjFjc1UyVGNP?=
 =?utf-8?B?SS90cElIWmc1Y09IeWlxcExub2pxZTY4dndoQWVFbnNBSDNPU2lpUHQyTXV0?=
 =?utf-8?B?bUp2NmhrZ2FsbklPcEkvTUI1bUJYSUdDcWxockcvdDhXVVFTZmNjcWxVVEhX?=
 =?utf-8?Q?42S85nGW6U6bj6mm/Ck3yJCfrGkWWYQnK7slp13En0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A8D23ACD4A3D54E90358E2CA5DAED36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v+B1Qzud2CbBwTbY2hoFHOGpzc/joxbeSRmi0TLSRLqYC8q+LS8s/zigSL41JH6Cf2vbLhOjtaQINVq27Fpo1Fkcwud0SDlRgRAegwzi0OqieR/BdpMP8I0YAJTWwoBXWUVIUbTtoEK3ogyGszfFn6NS/RC6yiU3sUWAV3mivZRxv+vULOGiq8M36xwD7CKUSTXuWwclrOVlP7aTzFLcqX+tZ65ol8e7o1L4LIFP0jQOxAEmFeZVnArjiGK8SMA53VAC39ODgb7DVlQ36XDQo1TZ8S57gSNaLsgMcKM0yR8YP0t9iUaf24IVp3WYeNBbs0ReMYHoro4cpXxoRX8aO7eQr9po058S2jGamFOD+DUJGYlXVyd0XKRSqvQsX8hq1OuvhfVBZDabxoe+XQtRPYO7tMDjo9Y5B1IVLHa+8w6vGtpiToO58FmBd4IJxTIXuB8s7i6exKsfM+qAZ+/N/5WTC1p+ke93OM++YrkMB32hVzM5xVyjtWz5CIzAtDjdgySlPY8CgcjP0vOln7z79eAqYbMpu7BGSFcIQmvL7TZEgQUGHAb88YZcM+599UjqjqlX7rplCL1WKuV6cBAF16kTBm++KZE95i9cem3Y/JzKFc9cUGB8gzyHR8WqBH3W+z9eKWsGDY5w7kMfxWKwE1pChHBV//rUBiH8IM9GeqVMvbZlnryKlRudvDpM43pj0BV+8y5QzpS2vgQfQnmXAiulc0Bwh5nMrBEpiNmUV3jSNcgvbBxoEuXnCZLvKt7bEZPSfbvzoTNlfpRAksD6B3+/QmYJbLwF6AaKAPfHA5yyD5KY/IiM/2cNm2uIsjwX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4735b2-8d3c-48a4-ba1a-08db0daf215d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 10:43:23.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMVLt7KOwthncHmzlF9M/egAph2IPVIVYhDnE0Yk/EzLd/MKQz5owMZ7VN+xcubaEmVm4HKHwQFoPFyjP1YpbXhNtvieutjzook0aE4gxLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3603
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMDc6NTcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gLS0tIGEvZnMv
YnRyZnMvYmlvLmgNCj4+ICsrKyBiL2ZzL2J0cmZzL2Jpby5oDQo+PiBAQCAtNTgsNiArNTgsOCBA
QCBzdHJ1Y3QgYnRyZnNfYmlvIHsNCj4+ICAJYXRvbWljX3QgcGVuZGluZ19pb3M7DQo+PiAgCXN0
cnVjdCB3b3JrX3N0cnVjdCBlbmRfaW9fd29yazsNCj4+ICANCj4+ICsJc3RydWN0IHdvcmtfc3Ry
dWN0IHJhaWRfc3RyaXBlX3dvcms7DQo+IA0KPiBZb3Ugc2hvdWxkIGJlIGFibGUgdG8gcmV1c2Vk
IGVuZF9pb193b3JrIGhlcmUsIGFzIGl0IGlzIG9ubHkgdXNlZA0KPiBmb3IgcmVhZHMgY3VycmVu
dGx5Lg0KDQpPSywgdGhlbiBsZXRzIGRvIHRoYXQuDQoNCj4+ICANCj4+ICtzdGF0aWMgYm9vbCBk
ZWxheWVkX3JlZl9uZWVkc19yc3RfdXBkYXRlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
LA0KPj4gKwkJCQkJIHN0cnVjdCBidHJmc19kZWxheWVkX3JlZl9oZWFkICpoZWFkKQ0KPj4gK3sN
Cj4+ICsJc3RydWN0IGV4dGVudF9tYXAgKmVtOw0KPj4gKwlzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFw
Ow0KPj4gKwlib29sIHJldCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlpZiAoIWJ0cmZzX3N0cmlwZV90
cmVlX3Jvb3QoZnNfaW5mbykpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwllbSA9IGJ0
cmZzX2dldF9jaHVua19tYXAoZnNfaW5mbywgaGVhZC0+Ynl0ZW5yLCBoZWFkLT5udW1fYnl0ZXMp
Ow0KPj4gKwlpZiAoIWVtKQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsJbWFwID0gZW0t
Pm1hcF9sb29rdXA7DQo+PiArDQo+PiArCWlmIChidHJmc19uZWVkX3N0cmlwZV90cmVlX3VwZGF0
ZShmc19pbmZvLCBtYXAtPnR5cGUpKQ0KPiANCj4gVGhpcyBqdXN0IHNlZW1zIHZlcnkgZXhwZW5z
aXZlLiAgSXMgdGhlcmUgbm8gd2F5IHRvIHByb3BhZmF0ZQ0KPiB0aGlzIGluZm9ybWF0aW9uIHdp
dGhvdXQgZG9pZ24gYSBjaHVuayBtYXAgbG9va3VwIGV2ZXJ5IHRpbWU/DQoNCg0KWWVzIEkgdGhv
dWdodCBJIGRpZCBhbHJlYWR5IGJ5IHVzaW5nIGJ0cmZzX2RlbGF5ZWRfcmVmX25vZGU6Om11c3Rf
aW5zZXJ0X3N0cmlwZSwNCmJ1dCBvYnZpb3VzbHkgZm9yZ290IHRvIGRlbGV0ZSB0aGUgbG9va3Vw
IGhlcmUuDQoNCj4gDQo+PiAtLS0gYS9mcy9idHJmcy96b25lZC5jDQo+PiArKysgYi9mcy9idHJm
cy96b25lZC5jDQo+PiBAQCAtMTY4Nyw2ICsxNjg3LDEwIEBAIHZvaWQgYnRyZnNfcmV3cml0ZV9s
b2dpY2FsX3pvbmVkKHN0cnVjdCBidHJmc19vcmRlcmVkX2V4dGVudCAqb3JkZXJlZCkNCj4+ICAJ
dTY0ICpsb2dpY2FsID0gTlVMTDsNCj4+ICAJaW50IG5yLCBzdHJpcGVfbGVuOw0KPj4gIA0KPj4g
KwkvKiBGaWxlc3lzdGVtcyB3aXRoIGEgc3RyaXBlIHRyZWUgaGF2ZSB0aGVpciBvd24gbDJwIG1h
cHBpbmcgKi8NCj4+ICsJaWYgKGJ0cmZzX3N0cmlwZV90cmVlX3Jvb3QoZnNfaW5mbykpDQo+PiAr
CQlyZXR1cm47DQo+IA0KPiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBldmVuIGJlIGFibGUgdG8g
cmVhZGNoIHRoaXMsIGFzIHRoZSBjYWxsIHRvDQo+IGJ0cmZzX3Jld3JpdGVfbG9naWNhbF96b25l
ZCBpcyBndWFyZGVkIGJ5IGhhdmluZyBhIHZhbGlkDQo+IG9yZGVyZWQtPnBoeXNpY2Fs4oCmIGFu
ZCB0aGF0IGlzIG9ubHkgc2V0IGluIGJ0cmZzX3NpbXBsZV9lbmRfaW8uDQo+IFNvIHRoaXMgY291
bGQganVzdCBiZSBhbiBhc3NlcnQuDQo+IA0KPiANCg0KTGV0IG1lIGNoZWNrLCBidXQgeWVhaCBv
bmx5IGhhdmluZyBhbiBBU1NFUlQoKSBoZXJlIHdvdWxkIGJlIGV2ZW4gYmV0dGVyLg0K
