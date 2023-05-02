Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198A56F43CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjEBMZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjEBMZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:25:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92755B2
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030322; x=1714566322;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aMcSGKqNvFzeL+DgAW7+PTcc7AIVV71H8w2rYDQiswtmK8QIyn8NcQVj
   3ra7VS/Px9N6Vweku2mA6c2yzXuxbS3a/l2Y31Bri7O0xzfwsYFj3xEC9
   FKN6lekFtPbI1+UaW451jr11Fb/h8lCe/EuVQ7nXzPYLh+I8GXj4cGjS8
   mykTw6SHESoaLVgFgg3VV534CEmi8fYpcGRnJyxKo5dbBU+1BpTMAuVof
   RPa1aGRye+wADtwwk/lPeYx13ZiC1Id/7la+I9h2g4AAwxIA8Kq9JxIUt
   CzbPv3AMieTxcfCd91Z7hNjPJt/xolMhiS9AKxZA3luvhACHnCp7fAp/r
   A==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="227923256"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:25:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDli+SB5F7wO+3Im9Y6AHqt3rlpQ81qYu3lxODUX8UXhKxdLjDzBGyK/2mgeks8sskxxs2RYXiNmiO8XmPU3+pxjlW4KfEBTo8OLa5Em9uOLEPme+cf0/UWesUMmSMPI6rkI22GtEKmwfwlWW88zt9kT3W3WeoXmglrJer9wxIVtQHMlAWJN2Txb3z/kg5VdvKr1BQUF+iLxANhltljksXcpB/UKOpiPjqf4JqiTZtCdtnQvVKmtenVX8dT2eYieB2nno44Tl8D4LK1XpDNHcsk2bWLfxsbZV6Ysjc1WXZVsbZg/NUMtkzMYxiguGSLqF5Ox3BtCATyvoCeT46zOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Bjh0/rAD7knXB7/UXjEN2ON1PRPg4eEzyC6iqaneaKKr7Lcr0LIveMuh45GDxLkD4LG9W2QqqMn0Yo79Q6VsmkpRucsvlPQJ1noyNkUR5ez6O866je7e7bF8wjpNwzxQitRoHPY4SkzOgPYm+zAMkHRJo+K/uff7ZRa22CKkqwJL5+y9Aq+DtegKJA4LwYHczbAav7VqOLe1zpgpX+gnPJyVwlbnywDXr8huAeO0GzWsDeI6vh70MX4RAHHil9Br3/5AyLyNabBeuZmNaCVsQBpxfTBfg6X55wICaxsXqG9idTXwfC0vyPwWeZNBgFv33Il2MPC1cPE/QVQMSzNhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=xQ47n8mCcnlpcJ7VdEu/LpuO23wEkejDdkGjtCN8IyS20QrfQc0j6zpeLCqIhmosQof40qB6lDJ+EjrFurnI5F+GIuM7YvZTk0epwTIfDSn1ISOOdCy/AKzV0sgjP8LoDOLycjNP7G5bYh2Mmsrz0DB3I3Zv09a+pto/1UMnSqQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7848.namprd04.prod.outlook.com (2603:10b6:8:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 12:25:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:25:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/12] btrfs: move btrfs_verify_level_key into
 tree-checker.c
Thread-Topic: [PATCH 08/12] btrfs: move btrfs_verify_level_key into
 tree-checker.c
Thread-Index: AQHZetZP3Fn+JTK4PEeAOCE2dCxaw69G7KUA
Date:   Tue, 2 May 2023 12:25:20 +0000
Message-ID: <87afb10f-3031-2c55-1c8d-5b127e19a357@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <dfd15f7bebb3c35f9c3632b51d823f103e9e7213.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <dfd15f7bebb3c35f9c3632b51d823f103e9e7213.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7848:EE_
x-ms-office365-filtering-correlation-id: 612b032b-aeb2-41fa-a22a-08db4b084bac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxmMZjlbHvt75MScFsQygFMnPrWJ8aZ4SzYJsjjLPdHsjwUQdTikZsVYY/tDJsZpfmpxaBmhLaj48W2OVxaG4Vj93ZnhbG7yBe0ahXpnirRb61nu8Lt/DMHRJx7F/tTmzHoYQNtvJo7jkpxXBZqYEKgFqkACBpWRkWgXTDXRAPUvAxGfucc2EfrthyPWmFnP6mJXqpZfk/I8Jt6AIIvtXvwmNSI+YqYbNwk9KQnyRIAwIqBFoWn20GlTV6aUO/npE2r+eOS4CZUpap5omw+04P4pGmOvpdbgwRFDcxA75GOiriSliDhgZRa/FvhyV+XfHBcgoFpnhDYsLTX38B2w1RE8dveTI0TRZny3aHVS9l6v0/e8pV19ZMxffrtOuc4Oa3oNvZc90d08tsY/uu5PJcGDGw10CnpLQu+DRYOhgCEvjBd2CKupVmPQeOgQcTdHXsc4i+9slykFYIqrWFK2kFrXxC8g3SjHTnGKVae/jgVpRqA2jOZNBNdRq+0H5XUJ/WlkNFF7ZLaQWlEEH74O9OqEkSlvfri6pLrN+bh6e8E4feZZayitYVvKI400T7Kkr3FFXBrTwJa18kjPEMC1/jr/mCoq0xsZZJvv/+eUs9NZKwgUuFMlsx/9fWxRKDKaW+kU4EY+W73p810TC9juLHMLwdnTbMkPz9qWf/yk0H2uDzun6x3IHiyZDCnhVg2w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(82960400001)(186003)(4270600006)(38070700005)(38100700002)(122000001)(2616005)(8676002)(8936002)(5660300002)(558084003)(41300700001)(36756003)(2906002)(19618925003)(110136005)(31696002)(316002)(71200400001)(6486002)(478600001)(86362001)(6512007)(76116006)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWV3OE5wamlzMWcrOWdMVDVVS2xoNFVEQ3ZHNXM5bHRROEpyOFB6YVFUOGlF?=
 =?utf-8?B?dU1lcjI0VXhGVzNmUGVrVEJWbGwxWGxMWUZEbWdzcjNSYTBISFFrcUx3Vms1?=
 =?utf-8?B?WlBRbzFrUzRyTVo5QXFjeEowWG9Vb3BsaVNOUlhvTlVIaW5JUHozK3FoNjcv?=
 =?utf-8?B?V3k3eFF0N0Q1VDh2Njkzdnd6YTVyeWRVYmVMb0FKNTRSTW9PUDdXZ0Nodisr?=
 =?utf-8?B?WTBtL1BSQnlmNlhuckZFWUhlc2U5TUo2dXQ1Um9OdERKWVVaVHduTzJMcGxS?=
 =?utf-8?B?T1VCTmRWOUhEU0dnRXRaTUFxMmZIZ1pmWmRZUnNQanpydEVZc3NSZVEydXRv?=
 =?utf-8?B?akNZY0UrQlZ5Z0prMXBVV2x0U3pWWHZmQ0tEUEEyTG4rNnVIU0xTaFlCNE9Z?=
 =?utf-8?B?YTBCTjhNVE5CbWUrZ1lNbDl0eXl4dzRWMWIzaGh2WUMrZzRkZUtIdzgrQmN1?=
 =?utf-8?B?WHgrMEZkQldCMHk0ZGxqc2tOLzdDR09FaGZRZnd0eEZsS3N0b0laS1o4OVBO?=
 =?utf-8?B?U3ZkS0FtR1VNelA1RkhIVExjVVpYSjZJeHFxU1hWdkhsamFHdTl3cjZTSFhn?=
 =?utf-8?B?YlNrczQzblQveXczcmFIcU5Ub0toUlF0VW95anFUNEpOS0txS0ozd0MwWnNy?=
 =?utf-8?B?eDB3RXZ5azBxa2F2NGlBL3B5WXU0TzJZS3hlWm9vUDNhbTN2TGYzaks4dDl3?=
 =?utf-8?B?Qys5TWJyMHo4MzUxdm1PZjNjWDE2dVd2OCtENEtUSlBjb3NLM3ZTbi9iNmtB?=
 =?utf-8?B?TFVObzBENXRXL2FKZHRvRVdxeDJUQ3BMUXg5a09DZmMwYW41WnFyRHhVRFNX?=
 =?utf-8?B?YkM5QnV3cUc0UlRTL1hKMXlrUGZ0UTJ5YnBNdW1GRjkyaXlwQ0ZTOHF2QkVP?=
 =?utf-8?B?MjFqTXRFVm5lUnVidGZib1MvQ3NjTVplUzBXOHRDMUhlRWZKVzZ6WEkrb0d1?=
 =?utf-8?B?dGxRd3lyYkovbS8wZ0FiYU9UU0xhSFFMV0dyRE10QU9jL2ZvQlR5NVk3TTQ4?=
 =?utf-8?B?Zk05SHJCKzUwdEVGSnBrUG5IUDRCZENueHFWSzBPdkxQQkx1NzhaZlY2THk2?=
 =?utf-8?B?azhUbkxsWG1UVVZiQ3dQSjJJRWV5TmJrZVFMQno2aVJwYVdjTmxkZ3FhUmxI?=
 =?utf-8?B?YmVwTXhaQ0JrQmJRZitaY3RXTVJIem9sTFladnB2NG5pNy9vSjNGdGpFbUFE?=
 =?utf-8?B?WmM5SVZaVmxmRDArYW9HNTMxTTlVQkJTWDVpOG5ZMXJFd0NoMWtod2tmM0lM?=
 =?utf-8?B?MzhCeGJEa1RaWDJTTkVtc1RsZ2VsYmExY2lmZnpkRm41RWtDNnloK3JaRitU?=
 =?utf-8?B?RFBPWkZwWXhpYzN5TTFIVmRaeGdnM1ErZVZsTXVqNWZxUjlJZjAyVisrMXRx?=
 =?utf-8?B?V3hLMmRKVDJ5REUyUHd2Y2xyUHZnWWpuN0xSM3ZOWWo0RVF6U1V4NHZhV0hh?=
 =?utf-8?B?SUtvRlhhVWRIeGRreGw3MHJLYzlXb1I5dmhSdmtHWE8rMDlsOXgrZUFBbFdS?=
 =?utf-8?B?NUE1SHlMMXN2WU1qOTM2aWJsS04xNTJOakNNb2J4QmdtZWRXZVJaR0x4Vytk?=
 =?utf-8?B?NFdpWm1rc2RoZWI1Wks5by9NdzJkSXJGMFUwcTFZWU85dGl3TFJaUlFWbURI?=
 =?utf-8?B?ZUdzcVRzUFExc3k4aFJCYm5BQXhiSEZRQVVwK0dEaVRFeGlRb3prb25WZlcx?=
 =?utf-8?B?TmhGbnFydXNlVjVCaEE3WVhLV3JNZlAzNTFmV3JiMzhJbjViVWhRdmtZZHZo?=
 =?utf-8?B?Z0NNQmFwb1BJbkcvdm1GNXA1MUJnZ213TmNsZ20xamZNbWRlME1leDN4REhD?=
 =?utf-8?B?ay9JWjBuSllmMDEwOVcrbUdUQ1c3cXJzdXJKdm8yajN6UlQzVDMyeGs1RzVm?=
 =?utf-8?B?NFRPTlQrNzZhaGhiL0FMYjlwZ3ZTRTZKWkZaekxDOGhsbmNnYVpuUWwybk90?=
 =?utf-8?B?TFc1bTR6L1hjQ0lMTFFkaEpvWWlPMW5lZmxDVXB3TFN5eXVGK3pnSzZhQzJt?=
 =?utf-8?B?TXJLWURpOE1WaEwvUXRLTUQ2cUJTNW8ybGNucFRVMm1DclJGK3l4SlhvY2ty?=
 =?utf-8?B?U2RXdmZ1TjlYRU9vVTZ4dk9ZdkNzRWpibjVydHdINFkxRExZM3ZJU203bXJS?=
 =?utf-8?B?cThnNzVVVzc4ZWF1YnhlWHVoNEgwL1lYcmMzTmtVVVZKMnUxbVVydnlzMlI2?=
 =?utf-8?B?VW8xZ3RYdFRCZnNQWmsyN01uWDlLdGNGU0NCVDM3bEV6QlM4M3J4Q1FPcHUv?=
 =?utf-8?Q?Zr7QxwvURNWkt7D++4GMWVmi2La+du8LKivEwcW7iE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8D4BE619405C42983F2916EF8D8A95@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6jsgiE30DvcwkCeunxlrKr60utMy7mTd3pYrDd9umPw6cR3MobD8zxXN+vb660wBetHXWVzgKdOb6raVDw4xoV9i3tJopwcpiFcMX/RCTDyzWkptsISfNBWEUJA4ArhyIa65Ed2s7FWLQpv7fLb0Bp7hAn67oy/7ThFWtU1iaP7FlzkJdhiNa3nlCPwmg/W5To5CPxdBcEVnQhRiNHk+kvtLGpJF6bLUd24gICKlfpiu6clCfSlxREZTVeMRGXLRdOLoU0meuUYsnoi2f0AQSbdioOMjj8i19Pz2LqouVZ+pqeVVNu9nsBJ7MtMDYN88hO1OqNWvdWhcTOhJVp2kCrHlyOVKtQeQdGOJ8wbXdYiN0ZhGUw6HGGQ4Fh4dW6oISfuxejZPggZJTSFjhpR7+93ztRmhOPa0tON6IfvEFXxEvdXAPKDuQ5vo02vE0nUYnrKUzu1cEN19RS0EwJ2vWwrQpiaJWXihWuw0GP6IRsO844OI9jshPxZuI0DfDu3hH1qc7chbyX4Txpu3RuCJxSnnyd0dmZx6qAuZSckD7d0FWaQfwGa222GHHeO5XVyadDGpcxm4nB/aSBWo+wdOVTFi/viRcKe8q4fDpjgu2aBWK5RDPRVaMUNWuageyNbkbRGT1i5qa74wmbb3HoLC+YWr0JISfXuu12ji2wWJEj3wz+Hfvjn3O7o6HaKpN83RHz/NHlxhPBJcWm17P6fIsa/PjvDiF/QtguV7RB4RJKvD9a8KFOBLCcJcguDvQ4gNjr8q8S/0uLnc+lK4+fJPYjXI7fN7Qzi+h9gws+rISN7qmUGAUvMCbIM3x/JbdQcqgs3bHi3c67knQjvHdPx0OQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612b032b-aeb2-41fa-a22a-08db4b084bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:25:20.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDmbbUbkk0Hvzheg1EkmXQxZtkTgvf3aoNIvDNi6sOjTC2RGclqMJCX3i8s23qKCOPOTj4lBkIBdEhyVg4UgLrLyH0j3xX1Cpiepwo6yj7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7848
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
