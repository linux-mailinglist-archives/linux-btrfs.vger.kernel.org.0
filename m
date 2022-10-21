Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB146071E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJUIQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJUIQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:16:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AE31A403E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666340196; x=1697876196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ksCTTXScsMo8gMg+E8LoyZhKNh1pw/TYUPL7HzhX8XQ=;
  b=hoTm6WPEWQQRMTDdkEba9glHCLRNl3V/vreYaM424yBDQfazIMYKLxZ4
   n0s/4VjPLKvKKaobBwcb8CMfguIDTYwj4iyTehBr3PdBRiL+S7pSoQNs+
   +IPo2/tiK1miZIBA6wWxyA1HaTqLzZC85mjA7trZfGOQ4NWpBvc3yJUtT
   3MKhcMdPB+FpieSXVd/+eBO+XKgM3PuzkCFaFoQndF0I0A2GY0xaC2Skx
   tGbxL82OOzJZa8WBvN0T2yiF/2Rl/6lhMH/lFD3h6yG51skCIGZhNyoFM
   TJ2gdy/8UzAw4g8BFYLovLaetRxSMoEPFFWnHG5vNJVlp5Y09IQNYyRux
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214793794"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:16:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwoyS8A0s5DcVsgPLcvfIGOQFz1gv1zrSH4YRfIkcKYYNHGJEOb1CcY9VKJvYcXGalR6ndsiu2cDpw3tqd+m7sGK6zccE3FutSVUgbflldZmnCkosBChU+9UJGe4AtL9Oc7cPbxu4A3Qcfmt8wzTN2DRRyUYUcIBMoFllyuPR4Ur4T+bfEMjw9ahCt6XIlPlDGvE3dcZT74+tLkmxfqikDdxvAV4tX0aHVUVT+1UNr/M5qFEtIL8v4R9ao2WJputDzdqGeInqDbPTTtc3kZmmjL/BMaZ/iJFtYCWv2kqMUy4LjFn4iQiSVZWdl6WaA7lRulRE9V+ZWaErBGtk6dzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksCTTXScsMo8gMg+E8LoyZhKNh1pw/TYUPL7HzhX8XQ=;
 b=Po5Mb5EDtHSc74lqySyJAUAz0by7CbQMAhPUVBX5qgfyesDNRzSWr61RAsdTD5deweUtMJFiILSJ91UKcAncMWLmyQikuekMpVDaqRb4BmSk4WLjxKQp4xWEw9nZT3QNWRPTL1Hvuu7U4gaqjmaUdB7tFqyhNonxp4tyZXnz6fkhYgn1vC7gLgZRkKfBmmV7FgzML2Vsi9Cj5tqxI5Vl6toaFN3axrwjQRAn3jiHxnjzu3DU0PQp5pLDapvnjGtGyyIec+twtUTvLNMdfoi/SAYKLMuIwS+Xxd9ZU8y2QnoOjJAjhRAAlR1ySXw5qUPe7Hp1TVpErOXzIFQtW36uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksCTTXScsMo8gMg+E8LoyZhKNh1pw/TYUPL7HzhX8XQ=;
 b=G/v/qk9VVIi7tBMykWHVobywDUd04sVQN9fJHE9uwPox//dsE6pNuf0df+hfDb/TPcW06RqqXUxa8vG7vv09h7YZh58zw3D6YElpVmCJGzpKdYexSRxs6q8dshZeYduDh452+FYwsdrN5gE3RCJyvogPANsPlBFo1UOjM0lam4M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3685.namprd04.prod.outlook.com (2603:10b6:4:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 08:16:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:16:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC v3 05/11] btrfs: lookup physical address from stripe extent
Thread-Topic: [RFC v3 05/11] btrfs: lookup physical address from stripe extent
Thread-Index: AQHY4h9hu4Dv+ji+FkurE9dDbkIDtK4XbpIAgAEYCIA=
Date:   Fri, 21 Oct 2022 08:16:32 +0000
Message-ID: <a5501b18-a05a-5430-3051-b7556910f03d@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <85853887c5f50188e32f879be823c690c33af9d3.1666007330.git.johannes.thumshirn@wdc.com>
 <Y1FqdvFiC2V3FwCa@localhost.localdomain>
In-Reply-To: <Y1FqdvFiC2V3FwCa@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3685:EE_
x-ms-office365-filtering-correlation-id: 42bca020-1c80-41ec-e7a0-08dab33c900c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UU4XqOnHh5jZn2dDu+eioety1gycA/vYjBcoCb6iMYxBADj+tcTATAXPd/tJkO1i9SVgwqWiCE1WDMEFk4ziOa2kIX9JCBlz1ZngQDLJg9uDyd7N3nFSjhhEdtv11hwTMSjAt5lxc0ggrIOI9ngnAiDOJYreTJep/itZ+gdHOKChniTaAohVZrrON0+aRXYlfM/A1x4drzigIIvEk1jrABoC0+DNG2yxtmhUfUtJuM+Zr96YuNIiV6ojQLV96X9njDssT/Vg223fzV6P29ezN54sHb3SHpbnKLCWRGoRb9FTqnL4q5ibTfcBg2EIfFTeT4KzPB+TfKo4aWDDlzQZeOL8tu/j9dr56vGnY7q7upcHFE9hqrYWKclmtvDV+utnKwaEueMA8tXuGKOIxsCAhJEPq0O8W1fgyPPOajyVoEmodMnprRmXAFyVBd4y/qqtUHfEfFL3mrhaEIQxTlqIyQLf7WpgqVHpMY1gUbid++7q98MnY0JuKKsXqLGdBI+WOthx2qyDi7jvt1zpzC1XXDLbxwo31VxAIbObZpQwF1v9UnsjC780fJ+0HVP7PXR0ba4LSaGV090nBG3hseTRg6tvj0z9jsk7fEI+vy5Ce6r7sSnM/kDV21Eeban4M680aPMZxK+DtgxIQMDuvCWr9+Xd5t/v0Uy1c+5kN/k8wcTzMoHgIZTr9nwxue7pyVks11+kyDmHiLISw8uu00lQfFo1H9y0W3f/G26I6WxOKA94C6lMMuoJfTH9TP4HSPK0tRob1VmEjMn7KO/hpyC/3b5Fy1+3rWtCW8vAsIPbSkjFb6KXPcJwQr43IO4VCNg6hqlJx31zR0RM4fjW/rt+qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(5660300002)(31686004)(38070700005)(2906002)(36756003)(4326008)(66476007)(64756008)(6506007)(8936002)(316002)(38100700002)(8676002)(41300700001)(66946007)(91956017)(83380400001)(6916009)(122000001)(53546011)(31696002)(66446008)(82960400001)(76116006)(66556008)(6512007)(186003)(86362001)(2616005)(478600001)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9BMHdORS9rS0EzbzV4RXpGMmMydlB0aHNrN2RCM3BleEFxWEoyQzRqZE9l?=
 =?utf-8?B?SGlLeExlQWxwMzU2VzFrNVI1REhRNVJ5cFdGK0N2TzhrSGNFa3ZqTExmTDQ5?=
 =?utf-8?B?Z3lhVVZhWUVLNU9lSDNIRGw1REd4T2ZMRUZoMkQzMXljMm9mSDFNVUxuT2lx?=
 =?utf-8?B?TlRBMFZvcXRtT3lWd2JJNSt1ZkFIWWlGSjdlQ1FVZVVwb1ltRTZTY0lkeEZo?=
 =?utf-8?B?YlZCRy9TQ2RFSGZsdUNWbTQvQjZJem9LVDZTSm4xUlcxSkVadHRMdDhYZEky?=
 =?utf-8?B?WVhsNWhySjJ2cGhWRlB1dU9YNHo0dHk5SWc2Z0VzcUpDalAyNmFHY2R1NjhH?=
 =?utf-8?B?UUxSKzI0VjViV3lrRDIrUGZJL01DdzRGci9PM0U5SHRwb2tMYXUxTlVNa2hW?=
 =?utf-8?B?MnJMTUYvN3JOd1A0bG43dmtFdlBFQkpVdHFDUUN3bDZ5aDlvS0RwNVExekw4?=
 =?utf-8?B?SGhWZEFyYUdxSFM2MmhxRk43NzNXM0dXWGZER0xWV3BaV2dJZ1ZaMmdUOXk1?=
 =?utf-8?B?UnF1WktHYmMxVWg2TFFrdTE4R0RlNTlGb3JJY1g3dHNCcldOYjFFUHZBU1pD?=
 =?utf-8?B?SWovUEJJL2hpaTRYMXkwLzY5UFBzWnF2SWZZU3F0MjZ4WFdBeENnLzNzcmVP?=
 =?utf-8?B?S0p6RzFDUDBJYzJEZURuU0w1UURVZjhIamkva1lJTGx2ZTFnbjF3UUg3NGZv?=
 =?utf-8?B?a1BFSTZrR1J2MmFxK0hROEJSY3UrUWdBaHdPeXY0UVZPamtYUGZ5ekZaSWtN?=
 =?utf-8?B?bUdyQ1BPVUJ4ZmdBek91QTdVVlliMkJQMzhYdlc3T3NjeDR6M05XQ2pid1B2?=
 =?utf-8?B?ZWFyb1hTZGVxdHdmSCt3TGlzNzJNWC9aMHZZb1JEVFlHSER6R0lxanB2ZU1j?=
 =?utf-8?B?Z3NyZGRYaUhCSXVuVGcxaitRMVMvdmhwQVhuUENBQ2d4bUpYQi9xVTA2VmU1?=
 =?utf-8?B?NFlabCs2Z1k3TVRDUFh4OWIxdEFhQ2tuV2VENGd5U2t3dXhWVWFGU0tIdHFm?=
 =?utf-8?B?UkxjcTk5d2oyMXduQlZmam9oNXByUkYrd0k3QlhXYU9hL0hoZHlROWhsRDFl?=
 =?utf-8?B?ODZtUnZKNWY2dTRORVBNY0pOSmsxSnNMQ25wQ0RrTU00Sk1SVTN0dDRFQ1g3?=
 =?utf-8?B?dCszZEVmZ1RVUm13RzU4TWdBckdoVm4rTVFoRXpMdEFCT1Q4MFFzdWtndnps?=
 =?utf-8?B?STlGMVJTWGNPUSt1OEdHVEduZ05PVjFvSm5YY1RQS0cwK28wWEJNVXFoVUlI?=
 =?utf-8?B?eksreFhhZm9xeHFocWNJZlFZNFpYQnlPZVZmRmZ2MGowd2FNZmxvTzN3Z2Z5?=
 =?utf-8?B?bVlIZzNGbWtQMk5vbUZnaWN2L1hyaGRGMGZLTjBMTDRPcmRPa2tVaVI2Rm53?=
 =?utf-8?B?R2twQWFuczIwNjRMd1lIWWVoK25zNksydmdhWG9JaGRXdFB3Rjk2UFZ1TUtm?=
 =?utf-8?B?Z0FLUzRZNjBaYWN3WU9pVzdnMWtrZWc0UDdZSlhhN3NpM2prS1M4ZXprdDFn?=
 =?utf-8?B?UkxkMDBIS1BVeHhzN3Jncnl1dXZPOHBpajQwQWhBNkMyTlZMUVF1NnBaTVBG?=
 =?utf-8?B?YmVOS0V6N2M1QTdjOUNrMXZleEx1NVVZTTNvaW1qNWY0ZlQ4SW0xRWNUTE9F?=
 =?utf-8?B?WE1LRmNtaElkZzVwa0FKejJ1NzZlTStTeWFkanU2djN3alFPYXBjZzlVZk5Y?=
 =?utf-8?B?TjcrREtmeFlLcTEyemNPVFp5TlJPUFlnbFdWN1dycU1WQ3FtUkJPQWdpUWpx?=
 =?utf-8?B?UGJRUVBxZEZ1WTVjWHpHOUN4T2pqZkpIU3NoVjY1bHAyRW1IQmc4cUU1YkFR?=
 =?utf-8?B?Tkl0UUZCaXdNeGQrMWlrR0R2YlB6KzF6dExuZlBaMFQvMllwVm5xbGtWOEhn?=
 =?utf-8?B?TmM2a21La3dyRnFaWWtlbkd3eU1GMlpHcjdIOStXVHNJUDdYWUtZVEltWU9X?=
 =?utf-8?B?eDB2ZHRnVnB4NEEwUHZMUnV0b3orTHo5eXM4ZnE0L1dwVFBjYjNUdStvOTZ1?=
 =?utf-8?B?QkZxM1VLQ2pDRUx3Y3pDSlZZT2dpeTZ5WTE1d21JTGtqTjRQZHREVGZGL0Uv?=
 =?utf-8?B?RnpnS3lvbzhDd250b2l6T3d6MVlUWDVFVlFIK0M4RHNwTWV0bmVjR3pxcXdK?=
 =?utf-8?B?QWY1cjd5a3dxSEVFZ1VvREUrQlk1c1JORzM1WmpxR0JxMnFRMUZaQ1dkLzAx?=
 =?utf-8?B?d0tJZllMODBFR3BZZ2RDWHFRSHdrSThBekh1OGJXbzRoVEZLVUpOekRuNE1K?=
 =?utf-8?Q?zMn9P/nZsM5z+jqFzQHM7kJ9U/I2ZiZ+OfEQpl1Ywc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C517583AFAEF5428D36EE676108AE61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bca020-1c80-41ec-e7a0-08dab33c900c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:16:32.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWy/DidLtlcCY0xmEKgtJm5v4qoEYqOmLQhcCt1eoZZX0j8HHL3xoKFYSjfpu//zUCl5NBQF+B4dfiWZca1tFLZzMfyrD86awKTXpiR9Gr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3685
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTAuMjIgMTc6MzQsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gKwlyZXQgPSBidHJmc19z
ZWFyY2hfc2xvdChOVUxMLCBzdHJpcGVfcm9vdCwgJnN0cmlwZV9rZXksIHBhdGgsIDAsIDApOw0K
Pj4gKwlpZiAocmV0IDwgMCkNCj4+ICsJCWdvdG8gb3V0Ow0KPj4gKwlpZiAocmV0KSB7DQo+PiAr
CQlpZiAocGF0aC0+c2xvdHNbMF0gIT0gMCkNCj4+ICsJCQlwYXRoLT5zbG90c1swXS0tOw0KPj4g
Kwl9DQo+PiArDQo+PiArCWVuZCA9IGxvZ2ljYWwgKyAqbGVuZ3RoOw0KPj4gKw0KPj4gKwl3aGls
ZSAoMSkgew0KPj4gKwkJbGVhZiA9IHBhdGgtPm5vZGVzWzBdOw0KPj4gKwkJc2xvdCA9IHBhdGgt
PnNsb3RzWzBdOw0KPj4gKw0KPj4gKwkJYnRyZnNfaXRlbV9rZXlfdG9fY3B1KGxlYWYsICZmb3Vu
ZF9rZXksIHNsb3QpOw0KPj4gKwkJZm91bmRfbG9naWNhbCA9IGZvdW5kX2tleS5vYmplY3RpZDsN
Cj4+ICsJCWZvdW5kX2xlbmd0aCA9IGZvdW5kX2tleS5vZmZzZXQ7DQo+PiArDQo+IA0KPiBEb24n
dCB3ZSBoYXZlIGZhbmN5IG5ldyBpdGVyYXRvcnMgZm9yIHdhbGtpbmcgdGhyb3VnaCB0aGUgYnRy
ZWU/ICBDYW4gdGhhdCBiZQ0KPiB1c2VkIGhlcmUgaW5zdGVhZCBvZiB0aGlzIG9sZCBzdHlsZSB3
YWxrIHRocm91Z2g/DQoNClBvc3NpYmx5LCBsZXQgbWUgZ2l2ZSBpdCBhIHRyeS4NCg0KWy4uLl0N
Cg0KPj4gKw0KPj4gK291dDoNCj4+ICsJaWYgKHJldCA+IDApDQo+PiArCQlyZXQgPSAtRU5PRU5U
Ow0KPj4gKwlpZiAocmV0KSB7DQo+IA0KPiBNYXliZSBpbnN0ZWFkDQo+IA0KPiBpZiAocmV0ICYm
IHJldCAhPSAtRUlPKQ0KPiANCj4gSSBoYXZlIGEgbG90IG9mIGJveGVzLCBhbmQgYSBnaXZlbiBw
ZXJjZW50YWdlIG9mIHRoZW0gaGF2ZSBiYWQgZGlza3MsIHdoaWNoIGVuZHMNCj4gdXAgd2l0aCBh
IGxvdCBvZiBidHJmc19wcmludF90cmVlKCkncyB0aGF0IEkgZG9uJ3QgbmVlZC4NCg0KU3VyZSwg
d2lsbCBkby4NCg0KWy4uLl0NCg0KPj4gIA0KPj4gLXN0YXRpYyB2b2lkIHNldF9pb19zdHJpcGUo
c3RydWN0IGJ0cmZzX2lvX3N0cmlwZSAqZHN0LCBjb25zdCBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFw
LA0KPj4gLQkJICAgICAgICAgIHUzMiBzdHJpcGVfaW5kZXgsIHU2NCBzdHJpcGVfb2Zmc2V0LCB1
NjQgc3RyaXBlX25yKQ0KPj4gK3N0YXRpYyBpbnQgc2V0X2lvX3N0cmlwZShzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbywgZW51bSBidHJmc19tYXBfb3Agb3AsDQo+PiArCQkgICAgICB1NjQg
bG9naWNhbCwgdTY0ICpsZW5ndGgsIHN0cnVjdCBidHJmc19pb19zdHJpcGUgKmRzdCwNCj4+ICsJ
CSAgICAgIHN0cnVjdCBtYXBfbG9va3VwICptYXAsIHUzMiBzdHJpcGVfaW5kZXgsDQo+PiArCQkg
ICAgICB1NjQgc3RyaXBlX29mZnNldCwgdTY0IHN0cmlwZV9ucikNCj4+ICB7DQo+PiAgCWRzdC0+
ZGV2ID0gbWFwLT5zdHJpcGVzW3N0cmlwZV9pbmRleF0uZGV2Ow0KPj4gKw0KPj4gKwlpZiAoZnNf
aW5mby0+c3RyaXBlX3Jvb3QgJiYgb3AgPT0gQlRSRlNfTUFQX1JFQUQgJiYNCj4+ICsJICAgIGJ0
cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKGZzX2luZm8sIG1hcC0+dHlwZSkpDQo+IA0KPiBX
ZSBhbHJlYWR5IGNoZWNrIGlmIChmc19pbmZvLT5zdHJpcGVfcm9vdCkgaW4gaGVyZSwgc28gdGhp
cyBjYW4gYmUgc2ltcGxpZmllZCB0bw0KPiANCj4gaWYgKG9wID09IEJUUkZTX01BUF9SRUFEICYm
IGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKCkpDQoNCkkgd2FudGVkIHRvIGF2b2lkIHRo
ZSBmdW5jdGlvbiBjYWxsIGZvciBhbGwgbm9uIHN0cmlwZSB0cmVlIHVzZXJzLCBidXQgSSBndWVz
cyB0aGF0J3MNCmEgcHJlbWF0dXJlIG1pY3JvIG9wdGltaXphdGlvbiB0aGF0IGNhbiBnbyBhd2F5
LCBpbmRlZWQuDQoNCg==
