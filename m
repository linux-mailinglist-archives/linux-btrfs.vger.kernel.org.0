Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E448E602C6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJRNGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJRNGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:06:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDBCC513A
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098405; x=1697634405;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aa7O1jhrmNtrOEbX/KMWdX5fZBR5DsDp3aynlikfV4G+uPU0tUeZ+X64
   c1wBXEI86nO+l7NV5R3V1P27c38qx8GWfoiyBykKVQLYQp3IymXaP2eu4
   KGALsYfIcg1oVPEPjzk3uOBweI+2MHH22WN6Q40wtzpZBoQa4ohmMCREm
   UWCAiAlKmK8YLIXPtare0Mw/tj0rf1KhkNoXJWzd6PMmd79kZDtU42RRl
   XSugVsBH3rrMbHlggC8GK4SXY4u0pFJfRMv39n1PWL3OFXGNrIRY19ULp
   rJ06QPzmNkaLGoqTTcPeTkPNYYM7IFWlrFguh9Lo4/COwlHQMm72OJir/
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="219278130"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:06:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD8hvIS8Kon2PF2MZxHHuLVcJJoEyPOXzovltdhJpHdHX3OaxKSJKs8Due975uV2ziBZ6Dr0pgR6z8akyKfbULyfILua+SA2hSCHWsaGaXGUHklAv9NL9/BlzwD+S9Q5WterXjzgBcza6v9Zf2yzMEZm15vRfV/6mQkKP7WcKoyW+J0WmFTaKeYdn407P34lVEc3mnr2A00aycwaqpj+AgbTuKke9lrq/N4a2TbgdqR+goi9Zao5u1SEsmTuF1D+JRcjM9wu+wVVpOuluLi9e6CPGvdBqQf6Q1Zxn48D9N11kRtJUzbIWzjc5e9BUi0H5PgDsg2gm83XHUDDLNBoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FGws8F2XKlEa5y6YWMu6HKwS398xWffGPk/ERfOB/1Bg6STagCL08Hmk4PO8HXNBRfEklpTABQBTbLXwHkPNPftOyKaI71kNpXnrWrZGiOuCTSz2gtt511U6mjqILgzhoLtwA+VuSk9q2PxR72+Ywxo99Zj+TvKnVD9KcZ3posVWtRNZmQYFwWwwYIfmB5rmdGoOeiKsyaUaagHtr+uhkWNlTSLK2lNN3evnAOBln1Z424TuOaxwNKxgyHU+h25k0Mc0FuxoURFGbQQKXUNl18R64+YNmsrf2DM6bjyqDYToGfzOFcgbss4LfaXKmM4eB/GOYw1+EN7ptpQL19gEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=yfpo5S0wtf2pDUynD6IH59GJF4Ex/H3kHnNPzZ7tpyry47KwSC56/ba3iYGmDTLuHrlgWktWCE2hjnq1Ff3VE9F10/maF2bLq6mp7Ism2zFVMuKT7f7wq99oZdw7UVA46cUyOIr5XXyTFLRIBUnuBgnE4fWolmVay7leq/udf/s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5635.namprd04.prod.outlook.com (2603:10b6:408:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 18 Oct
 2022 13:06:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:06:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: sysfs: convert remaining scnprintf to sysfs_emit
Thread-Topic: [PATCH] btrfs: sysfs: convert remaining scnprintf to sysfs_emit
Thread-Index: AQHY4vC5eVyyfAZacEWisjKBVzzGwq4UHvuA
Date:   Tue, 18 Oct 2022 13:06:27 +0000
Message-ID: <67bc7407-afb8-f5f1-9c90-ba281d223d8b@wdc.com>
References: <20221018125349.31879-1-dsterba@suse.com>
In-Reply-To: <20221018125349.31879-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5635:EE_
x-ms-office365-filtering-correlation-id: cec86150-86a1-4147-71ce-08dab1099142
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tu3tkpgMYzvHy8605uzfOez/Munu1+1l9Qhkg8kKiQ3H0NYD6VpQ6YkX06NAlgnm3Hnpgo6UONupFuReog9Pmg5Mw5XvXVpeOt6v3RcvR0oSWNIveQskXVL4QBujAvcnWAxnW96CJ6F4mv1SODhHL+QUvdunK7/EoFosW+HrS+ooWuYhQEJz/X5ddffSbvyIKAkeqcTWwtmaRvMaxWjhFGO3BnAihHN7WHDkY+9z0E0pgmImeUFStfWwcFuJzU9x55vhYhQQtVhWitm2dk5F398eZBzg+J6M+qh+zXfHq5hHlYZB6TRNR6Z1cO75Kl9LA82HmqzLYBsBTJdTV9HjoFISQeRMJtW1JbU+za4wG8LGuoUwzaTHCq4e7vDHaCwwcZZYJo0Tj5u3SJ4pewAskaZQyqLkmF1PbjTkUDx5pfcprm7zPqCLmm+9rUDmmZ0xN6cFH164SUIydv4lJNvW1Dginxm5dXBKLqdaaRJiiO3rutIWAjvhKnRMdzFZG35Zli4qQwZvyFjQQReHiIiLZKLAf9jISONsedv3OP6t9KqS0a0vuktfmhp8kzab3KecMOqLTuvXzJ9X/YpxOu0+zi6nhgii21pHahEu3Crc9JYUTbu2GEshmUyp+eE9qcQQG5t7f9hE+8AaAffFv2wqVdS+Qk0Wwxiwbq95i1sJA7R+LjAUwP4bTzMiwJsiFdpH3gX6E7DeemuC3eeui7NtnHetbqTmqIWZYumvublYlglqoaWLMIxAM4CpUdm+fFYRa99D/qniQL51bV5HLSdD0nMP2HU9jb+dLHZ30+6LLGyhLbf9fhWrD3gPl6VpQYpjUYbbkJtnVvHBzfbie+PWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(8936002)(26005)(38070700005)(8676002)(6512007)(2906002)(6506007)(38100700002)(5660300002)(4270600006)(2616005)(19618925003)(36756003)(122000001)(71200400001)(316002)(6486002)(478600001)(76116006)(41300700001)(64756008)(66476007)(86362001)(110136005)(31686004)(186003)(31696002)(82960400001)(558084003)(91956017)(66946007)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enNUZkxiNlQzMDBwSllES0dyaHJTTFpERGcrT3A5aW05MFQ5a3ZOM3pNTXRN?=
 =?utf-8?B?c3J2UndrM2hSd1ZkaHNnNzhWWDRTc1AzVGFqOEhqdXRYSThVaEcxMDBEb1Rk?=
 =?utf-8?B?UnltMTVTZjB1TUozUCtsUkhkbDZZL1JqaWhPcUUvSVNLcWlrZnoxK2FzV1Ev?=
 =?utf-8?B?aEhSeFFXMWZYUHBEWlFDMmFicnJEOHYxSElvTkU0OEp5dU5ZaHo1ampReUFX?=
 =?utf-8?B?Yjg1QlBrcHdXd2c1aEZjSDd0MHo2UnBzUUU4eXV5NDY3WFdzMDlBbURqS2li?=
 =?utf-8?B?ZWg0aTc3eGlIcCtDQkZiV1RlS3BRVFgrZnFaS1V3TjdIUzhPNUpmTEdzYmcz?=
 =?utf-8?B?NDd4SlhZRHQ0YytlSk5hVG92aUI2bWlxQUtnc3VCb3ZVZmJnbkRJQllBWEJp?=
 =?utf-8?B?NjFLVFMwRFlCZ0pVTnY2SFFQKzl0dnNPOGk5S05WTE1wYkZETC9MUU5JU0tl?=
 =?utf-8?B?Vkp4NnFwUnd4dy9MMzdSeVUwOCtXd21PYnVweERvdE5aSHRDR0RMRjA2emZ2?=
 =?utf-8?B?N0lxM201Mmx5WU40VlRwdC81MmVnc2s1cVJpWVFzbWdVYndrRzJNYWhHdU5x?=
 =?utf-8?B?Z3JNV0pEUExYbUhRNGdLZktmOTd0MExUMk5PV0szc0JMcTdSR0syZ3lOdjB1?=
 =?utf-8?B?ZGNwMTNpMHl0bHlDQVJLc080alFjZkwyRVh6bzN4cEZOV2NNZkZLcGlVaVRv?=
 =?utf-8?B?ZGViY0xPWmNBd1dieGhXTG1LNmpVSUExWHBGNVpxY1R4MENTQWlKRUtIcUhE?=
 =?utf-8?B?Y2FVVXpvbjZRVFp0L3BZaGgrcXJsV2FWamJWVnJhM3BMVXFQVWV3WGpCaVRK?=
 =?utf-8?B?OGh4Wm1JSUZQVWVkZ3RZTHJiZWpSNlZFUGFnOUtnRUNQZFVwR2w0MEdyOEQ1?=
 =?utf-8?B?NFZhWkdrcVdUeUFxWWZuMjczUHBLV1BiN0NjV2I2c2dRWG5WRHI2dTZtbElL?=
 =?utf-8?B?a0EwcGptbE9hL1lndHhUL2VITC9aTHNhZmVxRUVjREFpblZNaktpTFFObzRB?=
 =?utf-8?B?SHgzOGFzVCtPUXg4dkhJVm5XZ2VkWCtmVVhDTmxNajhBSU1jdGdJWk5jZHVj?=
 =?utf-8?B?Sjh6R1M4SDZhUzQvbzVwQlhmTHV4R1kyZUNnVmRSN2k0NlNXOXJsK0RsVWta?=
 =?utf-8?B?SmZ6Nng2SjJhczEvTXFjeWJpZXc3UTIvRFY4WFE4MjFoVjRhSkF0UUNGb2NX?=
 =?utf-8?B?TEtubEVwUWduMUZBZWhnOFBNbytqWmV4LzVnL3RQbDdoK3NuMnBiSXFzZEU3?=
 =?utf-8?B?dzJuVHUzS0gxWlM3Qy9FRUU4QkZkaEljUDJtNUE1VGdrY001QTM0TUQzTk1p?=
 =?utf-8?B?VldBOHFLNU9TVHVBZm9qc3FwbEFFS0RLOXcyUzBQdzlQc1NKQVYvalJvNFEw?=
 =?utf-8?B?MmUvWlVwdXVvSmR1RkRzb2lOZHVXU0xKOWVaVGx2Lytzc2pXMExSNWRxTHp0?=
 =?utf-8?B?RkdxZngzbkh4U3BpTlR4aXhvNGltcTBZaTdYQ2pRUjEvYjduemdmNnkzK1VJ?=
 =?utf-8?B?cnRFbTNqdnNqK0gzQ01VWFFyS3BXTGZMNHRnekRhay90SHo2bnFHdktSTnRl?=
 =?utf-8?B?aXk3STM5UndjMzI2Z05aNVhqR0ZHWGd6dFJVYlZCcHYrWU1KNkF5ZnBRd2I2?=
 =?utf-8?B?cjd0ZnpkUzdiUWlLWGM1bGtVNXRlMkRQNEdjdXdidG5KMHhUNy9mdGFmOVF1?=
 =?utf-8?B?dmNWY0dIVHI5OVpWM0tWaGFWbVBDdW5xL21ZdjFab2NYSW9ORkN2Umk2MHJt?=
 =?utf-8?B?SzhBdnJDdzFCRUVDSldVeDRJVjNvUnZOMTRRSjdLcjNSdEZPZldPVU1Oclhp?=
 =?utf-8?B?WGpydktPRXRrZU5LY2MwSTlZZG12REhOejhJdFRMbEpURFVBOHRKRUtiSGxx?=
 =?utf-8?B?eXI1clVqUEJPQVNvckV2V1RJTUFEQVArT0s0VW02TllkWURiZ1dzaXRWaU9y?=
 =?utf-8?B?WjZLMmo5UXZtWWk1WVNYZ3g0RFN2VHBhT0NZN0ZlQnhZdW52QWtXa1h1M0Ey?=
 =?utf-8?B?V1RQaHY2YjJxdlNFK05zc3J6RUNLK0FrWVlvOS9zT0p5dkRoTjAxTWJaeUZL?=
 =?utf-8?B?OGo0cGdUTUdBd2JjSExZSWtqK0Vmd0kyWVY3MVN4Znltd3BQTnNxa0t2U0VY?=
 =?utf-8?B?WFFTcHN5SE01aUR5YW52d0pON2tHZEJQWHA4dlBrbVFYcFJ5MkVkNnUxMFIr?=
 =?utf-8?Q?6pZ/xJKPHtpOwnCmyJKuB9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A5576014040874194C501309FB495AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec86150-86a1-4147-71ce-08dab1099142
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:06:27.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn34cCLDpVVJeipJIxbYSG+JcmPiVxvvVoeMADdbZXahgmoXWudpEpFtNHZhojXuN/iuH34r6lx+wJuUqN1ojB4rZkCkj32yoZnbh4tUReQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5635
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
