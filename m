Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68E6B90D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 11:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCNK7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCNK7J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 06:59:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65D82D42
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678791528; x=1710327528;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IfVW+As31KIYGvTn67uMTFDwuj83vn4w5VAZcMtsppc=;
  b=VXwyvNa3cQaz53AJe2etkIZVmYqI0cJ4yaUT3dgSbRinI83J4CQyvTrX
   66xcHxG/cTpnmd91NPZdLOEUuBrVWiO0+JlsiwOw7+KiY0oB3E0jWqFgA
   u6nzRhXJ8QlFiy7sU9M0831y1sjh2qJQoTINmWtmbp0JICiqk1FEwmU7t
   5zc6Yq5mMpXbJw4wE3QG1RMDF4I24yu5kGy83iWs4KvX5+PPZoEZCXpTO
   Ep//Uk1mlqo3+i7ToO8aZkdIUtYVSzuagrehyeFtMAMSTx4QChxmLqd0p
   buZZD3wzIWewv8B/BYJGSjoPa7kq7jRxcoyqNfIrXlQe+oivTWdtNgvBc
   g==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="225377434"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 18:58:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3OoLeMEOLzMnv+sTsVOuHBkNmX6+IzHEEFVtCO2L5ZlAdMJ/gZOHMzWhXk/7VPSn5PzQqT69OAaR9YWjquCcyCsGG3pEozYErk8OAsPOshtS7mWJnpBX6nddxulDDYkOV1iojURlPh9+iEAvCFGyACAeSjVsl5HV26BW+CSxsfYn33LGJNr7vxZAvL4JS2oJ5jKTxhwBwTwmv1ocysRkjpR9nljx2YqHSGmo3GdKwfXUCyfBO4JSkOPVf6N3YoEVaZd0/nFYgaDVLuA03YVLxZIYGAQWK0PTQaplqFW+WNZxJ2Hc2FRz7Rv8sdefANKi6ldopsSvX3GTHGJVu39Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfVW+As31KIYGvTn67uMTFDwuj83vn4w5VAZcMtsppc=;
 b=OZoGCwZOurwPpsaTAGD9Hwp1SVmPpmtBU48v4AmwuM0kt245JIKHfPOwUhJkvobJOEqN9fAhgwtg5P9hZSA1r5RnLrzhhPCHJACz9hOibxc9FPO+5Uzb5AsgEENFXqcG8y7jrub3A75qYfSBgnpcnl+rSTAEx7/t17Yj5z627Xd3pRE2G7HAWd7XDfD2NFFF6QwnQCwqpqeI1pJfAVsF50vcuQUGAHfbn4ABihv69O0syFnD+SUd5ZR62EnQgBA8Xr7MEPxoQuSm03OfrbkenTht2Dmzzag4wMo3hQlhq1RN//5NkIGtoCFRFP5wc+emed/Raa5iH5NrcxrwGzyOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfVW+As31KIYGvTn67uMTFDwuj83vn4w5VAZcMtsppc=;
 b=a1XGupUHsQzGETdNKM/uPpc42dz/2M45QEvL23jx8TXgzfrIXC72ZhFc4CQS4rHFWAd/2pAgFw6u3Vi8jZoIx0BEbaFNa3t3j66NAGEyDrMRdxBELaMvREa/zJ4Bc+hvake8UYwqBWBJ37iQzHuD4NLqJVf7YShg8v9uMUr3WQE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB5005.namprd04.prod.outlook.com (2603:10b6:805:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:58:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 10:58:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Thread-Topic: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Thread-Index: AQHZVkehVVfNMyVVOUSuGwpyDx5FV676G1WA
Date:   Tue, 14 Mar 2023 10:58:45 +0000
Message-ID: <25f5bf6b-7c90-b114-b903-1fb9a78ec971@wdc.com>
References: <cover.1678777941.git.wqu@suse.com>
In-Reply-To: <cover.1678777941.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB5005:EE_
x-ms-office365-filtering-correlation-id: 67e1e732-3656-49dc-2662-08db247b151b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3zEUNFJLK9M5fgYYSSc97RjYxh7XXHjnLtev8geJMNAnNU2c6U7gyb/VgsoVgXmobynAi1q3IlVGmF5NkisXZWKd2WcRe97yDbbzhl13KutUvyQeiCxM3aS510rGY3/fzj4SLGrr2YSLdRLVnse3mwkPA+qd5EMCGDix9x8NZQBP9/gCvCNK0geP5YnhzZyeLleylMyDMX6sqGS44sdsroJtNQwCDTGFS6J8PcEqiwbfpBIGDEcZGC7SCsLiM1wu8oBMGUrH682LpLurPAAPPX1iAEiZ/v7ngz/EeW9UQ82EotapXa7WSpngh5CSBlz8HBsoCux297byiRVgYK9HeOQnZfhC2qj8xIQdX12571vacDrVxlYfcU9/pOsmFHAAqnHmkdYdc2h8qF9igafzt1pNut1+Y5TIypx0vWzPOv7jPURef/RpQCV62YsHXJgcw/AqYbCChrKTwprM0lgVz8pebLwXdBHDolkLXfFKXUWlie0TnJWfI8EYVG68BUUCjf68VrOVTcZTj69/3rrQAhHH8q4vSYpisI+FUJ6xJdcIfwJg36tmMIa/+Yywgo9eNLsJm+SU0BdEolwgxeZ8nfgozV8SisaBB2J1Z5ClpIN1IBsK3ngsoNZYOvPyVpAXrpD92jrOoy6NQnkYPjYk1eiA76ZfooG6JHe/rfRkzEB3jQoMfhH0NA7TQW7cNVJXUNxcYQeqwoXp04raRlkyXyaRRFfapd3voLr5EhoISv80loVfoN5GKWCGeNJ89xRQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(31686004)(316002)(110136005)(36756003)(38070700005)(86362001)(38100700002)(31696002)(122000001)(82960400001)(53546011)(6506007)(186003)(6512007)(2616005)(5660300002)(6486002)(966005)(478600001)(41300700001)(8676002)(4744005)(8936002)(2906002)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(91956017)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm9XZllyVE1JSUJIUzV4V3pmRXc2eXFEQ2cxc2JIWDYzSm1xaXY1MzBiMWNj?=
 =?utf-8?B?NEV6b2xIc2tOa0U2UTF1Wjc4UFZrZFNzMUVWV0R5OXNWdTVoU3o1R0hGTjJZ?=
 =?utf-8?B?Z0dCU2FndExEYWFocmlBMUdYOER5RUtOd3Qyb3kxdnZYVlFpRUNHazlCMGlE?=
 =?utf-8?B?RWpKeURaSHJDYm5NQXFuTjhjeGs2eTVWaW9vb1RvdTVVWlhZK21DbkdYd3B3?=
 =?utf-8?B?R0JsQU1rUmdOOFlwTjZNK0w4dFlCNENJNG8xUnRwYkg2V1oyNVEycFFNNkF6?=
 =?utf-8?B?RFowNFAzbkxCT1B6cmpDTWRYcEltbGFoT2hiVEVPOEJYNHhPZmJJQ2NQSml4?=
 =?utf-8?B?em5hNnlxbDdtNytqdC9idUVReURiRWxOVzhGMUFqOUxzdFBtWnNqaFhOK3Jz?=
 =?utf-8?B?K1JrZ1NuMVRzSWIyclhyM2VqZEFTRjU1RE02dDVVZTVtblh1K2E5cU52cFpP?=
 =?utf-8?B?WndvYkExRTZOVEdmZGNmZWRSY3JYTzJIYnpLSXVXMENRL3Z4VThCc3hoaFh6?=
 =?utf-8?B?SUphZjZXY1UwWnUzemFnSGx2cDZkN0NzWVNlMlQzbnoyeHBLaXFQdmZzajY2?=
 =?utf-8?B?MUJwOHlBd1UySm90NG1PVVR6dUNNSU5RcVAzNFc2Ujd5MmF4K2E3ZVowaVJi?=
 =?utf-8?B?M1UvcVdSM1ZuZThvblFLM2NEYkdIR1NXYUhaZkYwMnVDVjRzMWN0TytkUGtx?=
 =?utf-8?B?eTRPMmVwRktSS2Z5VDArdi9NYVF0RHJNZzlpODQyNmlGdHFGTFdHK21sTnph?=
 =?utf-8?B?M0poL3p5S1VscHVFeHhOSi91eHNSTERJRkJZVUllQ0JWNXlobFY2T2Q4RXZ0?=
 =?utf-8?B?R0gwZnJzU3ZIMWFqT2hhWUJVOWZ6VXpzdm14THg3RnNFajF2cnNsUG0vWVlr?=
 =?utf-8?B?YUtwZGtoZlhhaldZTEFBcElFbS9iU1hyWHE1OHh6bWZ5Nkl4Y3hJdGljeG9H?=
 =?utf-8?B?bUFJOUhCcFBjdDJPbmdlTjB6RE84QkpoSi8xQ2JucWZzOFQ5bzZaOXVPamdx?=
 =?utf-8?B?RzlGanlOdk9uays2T2o2a3hNcldqdHJNUEFwTGZDUVJaYjhZc1BPUmZxVW9W?=
 =?utf-8?B?MUF2NDJrajRhT0ZDS25mQ2liMFNEa1c5V3NvcWNYOUlQWE9UenMvOFB0VnQz?=
 =?utf-8?B?cVUzMjN1S1ZYNTNMd0RmTG52RTUyaDFOU3JvMGZFRTNiWjZaZml5anlUWmpQ?=
 =?utf-8?B?cGZNeDdvQ1R5a0dVaW1PWlI5VmE3REVpblVZVDBQM3NJSUlGYjZOMk9XSG4y?=
 =?utf-8?B?MkxrRCtMOTFaZ2szZEFPamhqdEc4cnUyUldUTHRTYmVsZWdzTnhVdmJTb0dS?=
 =?utf-8?B?U1RNdGpLVTBNa2cwWVptUHFJd0ZWWDBpbjZZMjBCdTVTbjZIN2pjWWxzWjVP?=
 =?utf-8?B?T3lJa2FlSmp4SkRuZkhrcTRNRUhCbnU4S0hxTzFIVEZWdmtxc1J1elRKL3hU?=
 =?utf-8?B?WmNsWkY3c0kwL0h5VGR1eDlzSWRwTDduVGY2VW8vVmxNY0RRZkNycVNvMGIw?=
 =?utf-8?B?VE5GbXRLNjB3TldVNmVINTFpRGJ2VWU0TDhYR0VRMnUxbHhRTFdndXh5Q1RJ?=
 =?utf-8?B?VUdxbEVRMlJ2c3JuYmo0YUk2cDgrREJkekt5YmsyenBvcmtQT29oM1d3ejBR?=
 =?utf-8?B?am5RYmwrb1NnRERSNVJaT1JNTWNwTGZ1eEpJQS9GUGJuWEc0QW54eXk3VTBk?=
 =?utf-8?B?M3Jpa0tCci9Cc090OVNLeng2YWF0emdYUFVsa0RWRTBubkduMHRKV3pVYnhv?=
 =?utf-8?B?akRPL2hFdTlDRS80KzJxSFdLMXdRaEp1UEZTaFV3TEF1THVBS3d0bUhiWWlK?=
 =?utf-8?B?ZUgxb3dYdnZGWUUzM0hXdzl1azhIZmxYdGk3K1E5a3NKRlhQOE1rNTNxNDN3?=
 =?utf-8?B?RnY4MDk3dWtsUGl4ZXY2YnRab3ZzNzYxUVNlRnhzb0RRajA5eTc0bm80OGlw?=
 =?utf-8?B?dkNPSUhudE0yQTJUeXBvc05aVkhCVkVzUzlKays2cnhYb2xML2RSdlFrR0VT?=
 =?utf-8?B?UTRnTG9wMEdjenpWRjIzTmsxV2lkTURkc2RKanYxY3Qxb3pYZTBDSWZHV01w?=
 =?utf-8?B?LzlUaTJCbkxRRXZkZkxGOTd6RTg0M3RPc1E2L1Y2TmluRTEyUjRlL2Zwb2F1?=
 =?utf-8?B?M2YvNFZHdXpvUlUzQ0J0amJRbGpVc2lmTVZkRW5Od0lZNkVCTEIxcHl1eDAv?=
 =?utf-8?B?a1RBcmxRNy92TExWb1ZiZHVuZUdQZmd0bWlPalRmT3hnNVl6RVlyTElpUzZm?=
 =?utf-8?B?Ujk2eVY2Szl2S1N6VXBGdXdVaStRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7699C9192607449ADC38563581B9035@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6a9p/AW/KE94oWkpPpBCqxoPebxbIruVSjH/rdxw1JrWC37YBxh83SFt6jF6h0IwuqxbYWu68IFn1mGSuhJU7Cgc5TdHFbcf7ZTJf/QL7z/V+JY4XxVYENM18DezhCZ1EVaYUbWoxxNZB2YBP8w2vvkYZiljh0u04j+2MrXYt4QkKSyQKkc7g/+2Raz5eDatVjIpZeXsPKMSZuBBAr2Q8n5i/S3u8mrno1OFYZ9zodz4WLI7RTDthSTSwdRx4KU2tHseiRW6vdI3eZlh0vK/Vuv2qjKWDeYiR5eRoIA9OxuZjDid9l6s+jZhypEm8Wv4dsMTAnbgbCHY55oacBVNg92oPmadMZTcKmnsB82Uq9V/i3xQOolOhq8/u/xlU103ufp5F7u7r6QEgbmEITyEBjkvkqNezmQzRPIMOKlrzLjJCmWNZg2MRSNiyFMhjbsxGn+uwXe7sHkIfozzxE340VuG3Ye5aZAg37P0A0ur8kFet1Qe8czNAaJXDpogx42Siyi/cfiw9pmX9HzBnHCPZ4DMrE+11I+9+QiDuBZ5AfMq+bbu3ASmP0RNcDLjyb3h2jIdzbp9Ty4XZXx8tbXRG/Q8h/Ba4oBiMkdc/oGzTV8CMDhYIRhULrMKHP/g14J40wx0i4jG9Aao9Vb/GKcSnIDkJ5FC3OmDQhNiUzYYF1Ciw9mP9bcT1n/gU/IAu8MS5Xh5dOtlCEnjGeUY0eDJg4j4jcKGcktMzh5WDBbBQe666PEokjMw1ehRZeIQc0X71igINHhRES2Mo1bMkpxrVj3lLYNZP3MyYHAbDZTn0NNPJz8ZnFIC1DSjW/wM+GiP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e1e732-3656-49dc-2662-08db247b151b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:58:45.6422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLS+UaZWuIwcOkokwfLosCutNQOq+UVzu3H+R2go3MNkTsdz9q/oAvOc2JfGf0MtLr5xhIIc0cI+ylGx7W6I54X5Ad3BVHDMVt4J4hvF/AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDMuMjMgMDg6MzYsIFF1IFdlbnJ1byB3cm90ZToNCj4gLSBNb3JlIHRlc3Rpbmcgb24g
em9uZWQgZGV2aWNlcw0KPiAgIE5vdyB0aGUgcGF0Y2hzZXQgY2FuIGFscmVhZHkgcGFzcyBhbGwg
c2NydWIvcmVwbGFjZSBncm91cHMgd2l0aA0KPiAgIHJlZ3VsYXIgZGV2aWNlcy4NCg0KV2hpbGUg
cHJvYmFibHkgbm90IGJlaW5nIHRoZSB1bHRpbWF0ZSBzb2x1dGlvbiBmb3IgeW91IGhlcmUsIGJ1
dCANCnlvdSBjYW4gdXNlIHFlbXUgdG8gZW11bGF0ZSBaTlMgZHJpdmVzIFsxXS4NCg0KVGhlIFRM
O0RSIGlzOg0KDQpxZW11LXN5c3RlbS14ODZfNjQgLWRldmljZSBudm1lLGlkPW52bWUwLHNlcmlh
bD0wMTIzNCAgICAgICAgXA0KCS1kcml2ZSBmaWxlPSR7em5zaW1nfSxpZD1udm1lem5zMCxmb3Jt
YXQ9cmF3LGlmPW5vbmUgXA0KCS1kZXZpY2UgbnZtZS1ucyxkcml2ZT1udm1lem5zMCxidXM9bnZt
ZTAsbnNpZD0xLHpvbmVkPXRydWUNCg0KWzFdIGh0dHBzOi8vem9uZWRzdG9yYWdlLmlvL2RvY3Mv
Z2V0dGluZy1zdGFydGVkL3piZC1lbXVsYXRpb24jbnZtZS16b25lZC1uYW1lc3BhY2UtZGV2aWNl
LWVtdWxhdGlvbi13aXRoLXFlbXUNCg0K
