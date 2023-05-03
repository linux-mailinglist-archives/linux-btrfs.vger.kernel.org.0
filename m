Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56F6F5211
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjECHoI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjECHoH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:44:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9B31981
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683099846; x=1714635846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=k4wF0uiA0PiNyYgCA8qWaVLQqO3I/rNsMdY9NkkR7tcnqYHtLTCfpblE
   l+8Y8nrVp6gYVxteqjWED0XKfatTcsMlTL4d3QaK/hsibfcz2CKQwAZ9g
   +EbstVbCWzUdWGnmNF8P+xX0x5SDSvES/m69ukRJvqOgo8Pg4x6I8XpIr
   x8XdKvhMj6Uk/4EkPuxo0trdpTgaADrk6dp31WGDpUx6mQn9Dou9LzKKo
   xIphL5laJNRNLZUdixoF7WFOL0vi0vHnRMXRiw1Qts4rLVT+e8zFTbfoI
   +cRRa22bB51Jtq+oO/HeBbqt/myqzZQ7TwR7BDZC3OvAlr9ivR/l4g196
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,246,1677513600"; 
   d="scan'208";a="229671470"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 15:44:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX6dTUcUbsU5yW7bHeJu62BBn/y/oqHYzMK9t9msxpnhc4oqldURgyyFI4BhEsFYTkZfPrqj9olQgWCNFs7qy3JBcNWVJ0mEjNB+UIhhYa4kaAMsA93ZKx4ST3spJhFArcPsCi6+nOjb8YQDk/TNwDSFfWXe4wrwbYfhsW0w5lRSOD1DGZMN/DKPaZhY8UuPeEejyBxSkst0mbSpQ074n2DNrKQViPgKf3k8hzR2+khwvMy21PJqwEqn9zeNzp145y14sRNECN0Pk2PJZMqseONJ2a/iUv6nOWBMvkKrBABV9gGUB1uV6oDNZ65X3VFw0t83tBZdKn/VWsopRwaRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O8yWy1jp/WRp6+grSV1oaS5fWuqF19LRdhE1mjjUIBJZ6PowpFLuyhHFa1GOtk3GgVLF7O1MyYzInuBMvVQfck7bjhPUP/5zP0VNgBm/YiwNPRx0xPlm3lyK8geXBpEUO572yajW1+30DBSwYEsRvE262KHdrVqh6obc1qhnV0vkPkrRrj/C8KXZ9XSJHiGQCuAE7tfPsyOkyYJ+LaCRrGnDEqLgTds6hkG9sO+ef/e3PLzO/PcQuKkQjRi8uqup0WWh9REFOeVJZGwgPHcSG2qNzGuvVKSf7NkFMc4zAcBPieaAbSN3ufwv46YIA/+qUsF6Lnc/13gPpbrqf/VQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tYm/TKoZ5Oa+RJdw/YLuqYHFzmBP8L2RsHcl+fOS+JNCr6Dbq5uNVxkW7S6tV5kV8FguMohrXei1onMxDPFUShp4dEo4Spi7TuUDSuyTXl5WWbltX8DSUxXtc3+l5onj/hXCM2Dec9JRxN1ZAoSqgbnPz9UvTHMurjDE8RSqBwE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8163.namprd04.prod.outlook.com (2603:10b6:610:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 07:44:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 07:44:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: never defer I/O submission for fast CRC
 implementations
Thread-Topic: [PATCH 1/3] btrfs: never defer I/O submission for fast CRC
 implementations
Thread-Index: AQHZfY3MNqu/IISRCkmR1jSXA7hW1a9IKvIA
Date:   Wed, 3 May 2023 07:44:03 +0000
Message-ID: <11f78862-dd6f-1218-b7bc-862c5f7c4b93@wdc.com>
References: <20230503070615.1029820-1-hch@lst.de>
 <20230503070615.1029820-2-hch@lst.de>
In-Reply-To: <20230503070615.1029820-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8163:EE_
x-ms-office365-filtering-correlation-id: c23376c0-1603-43e0-8862-08db4baa2a90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiXJfuKrMTjcurpdWKUN+5zWjzWa3IFXt8nWYpei+Dzc2+PoeZKdG7Meow1Q02P9I+KxIR7IR0R5wxAK//GIO68xjNjSqL8Lh1IsIlLIM6PVhMh1/WX+yoOhSNUPJyJM6X8MS3JkPfXiDtvbi6AcH1/n1U3DNSE/o5jGpBhMgMLFQFyK9bvf1qxf/RrAhKtOz3FAwdzznCWpG3QqPR0Pf0UJaZ20opJTQaRxOpEJQl92sU9DDlFHKtRN3RriXnB1EC7hQ+QqBY+MXW9zZbQIcsCo/CU+KTWhKgEh2ACFGXEMAtNj+NndZmJUKf+JVoDxzoboN+AIg68kDxPsdSOFYLNAWfqBHgRjxvROjo3uj9Ie3l1vmGxtQKaSCPZIMN+8jFPAf7oYK2sOYJorg3RejHhovqeBcWsY0dnFr9koBi74i1tBJt0u3AoiYDjE2leT4pSWcN6fDKJm0RCDxmo/cK6UZhMtimkJCjuPypKPOsYbZ1RbFg+hJHlrDfQD6MHtFrZqGjFcVB4f4+LJ21RSF9lr8pUMT7pgNMoCbO0Dc27feO++tyMO/lEioNViBk3cBHPPyb3S8jZCA1iChWLf8TGB8LM2Ek8cV95IaaUNZhmiSecSIiaXQeLkFlRHoTbmImrp//Eir8mbjTl+caqsZHOlNmP8cw8kF46vvy0M+E3/0RmWdS4vVyVdo2QdjQqb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2616005)(26005)(6512007)(6506007)(41300700001)(38100700002)(122000001)(31686004)(71200400001)(6486002)(186003)(4270600006)(76116006)(478600001)(110136005)(66556008)(91956017)(66446008)(316002)(64756008)(4326008)(82960400001)(66476007)(5660300002)(19618925003)(558084003)(2906002)(8676002)(36756003)(66946007)(31696002)(38070700005)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktvNTlHWldwYXpodFFCTkcya3E3eG9kWGdlWEJyblRsbHY4RllUcEdKTHUr?=
 =?utf-8?B?TVIxUUY2TXQ1blNCeWZKdyt5WklDRHJTVHo2akNoWFNWaUJOaE1uZlhwODNF?=
 =?utf-8?B?aENLNmFjUHJEeHYwYkh3cGUyZm9uS01CTVRydlQ3eEhLck53N1hjUm0xK0Nj?=
 =?utf-8?B?OFlNbTFqckpLTjFHY2huemxDOTdpZU9jZzBhdzQwTWk5ZFJXczhZMEQ1UUc0?=
 =?utf-8?B?dEVIelFReXltSjBYQnV0Y2FQRGtoNXF4Mmd0R000VmJ2ZXhQS2tVMWRNTzU5?=
 =?utf-8?B?Z29pRmhHdjhEeE81aE42aS9uOVlMQlpZeTJzbTJVNjNXNkcyNER2U1lRQUJj?=
 =?utf-8?B?aVJwZWVOZUxZZjhpaGpiZWZWNzJUM2JzZkc5RTIzNzljbU96alRsdTFmd01n?=
 =?utf-8?B?SUdHaFh2WHZhbUdzRlE1UFB3Y2hPWlV6NFlWajl4U29GN2VjWkxXQ3ozaXJq?=
 =?utf-8?B?ek96b1VyUitCNHRjNStOTVFzTy9Oa1FQT3BaS0lYaVNpZ1c5aTNoWDVoNFhV?=
 =?utf-8?B?dWsvYlFCQUhkejh1QlR0bHhaUSttNnU1TjBIOUptOWIwUElRWEg0SnBxdjdm?=
 =?utf-8?B?Y3Q0anhVTTlucFVMT3NTemZINmlqd0RvVzUvbWVhMEkyeWhOSzFXNmQ2OHV3?=
 =?utf-8?B?NmNENktUWFlFc05YdWkxZ2o2YzVGS3o2ZXI0NjQyVytjcGFlQmJFS1lSbUJm?=
 =?utf-8?B?cFV2dmFPYld0a25Kb3BrMkpmRklFeld2d0xuR3NHRmdVUldiSU5iaFlnT2ov?=
 =?utf-8?B?WFkxN3cvWkJnL01DSzlmeTlGVkxiZjVSdGdmMUZqZEJTSjhxekJvRWg5Rk10?=
 =?utf-8?B?b1psV0VjTHJoSGFYNER4SXhKTkVvM1VMOWlKdG9WQ2UzREE1VkN0V3FSOWgz?=
 =?utf-8?B?aElRaXRUOFFUaXEzaGpFaTZzelZVcmxneFIzVFlWdTVIYXJoZUdOTkE5YTM4?=
 =?utf-8?B?NVF2MTZGZTd1TTNObXUwcEZkVk1Xekx0SHJDSzFzZjMwSWQ1UmpyZTFQSjA1?=
 =?utf-8?B?Z3lweEZITlkwTXNJWlpZKzA1RktBZnNyejMycmJKUHo5Qi9pTWVsNXlwZ1Ju?=
 =?utf-8?B?R0hSMUQyOU5UNUxpdVhsNEJ1aEdveEpkY3NXTUJMaWRKUVJacVlzZmViOTJ0?=
 =?utf-8?B?alhibDhzWFJkd3NLUldoSVFKUXg4VkdlenlFK2g3VDd2cUdqTVR2aEltR3ky?=
 =?utf-8?B?dzhFRjJscCsvQVpMR3g1b1NyT1IwQ09mUUNPOTZzSEl0dXZtdU0yenZzaEVz?=
 =?utf-8?B?eXUvaGdMc0E3czRjTWw3dEJ4UUVoaWtTV1ZCc3B4cVRBZkhiWVdiU0d6L0ta?=
 =?utf-8?B?N1luQ0g0K1RFajFNZkNTWnlwd05qaXM1YkFwWjNxTTI4ZkwzTHdleitHay9r?=
 =?utf-8?B?eFduOFphWldZYm9mWVd3NnNrRnhLcWlmcXdtbUdxQ1ZaSHUvRUY1Sml3ci9i?=
 =?utf-8?B?M0hLN2tRWFRsejlzS0owa0lYeXZmdUFvVG5GS3JIK0l3aC9zNlhIdVB6STVF?=
 =?utf-8?B?OXlYOC90M3EzcE13eHF4RnpZaFpBeVhXSGtOUUM4MHZxV1ZqRy9HYVp3Z2Vw?=
 =?utf-8?B?UTFaSXBacG91SDFMdmtMVGRpZ1dBMnBCRERlVXJ4QWhEb05OTVFMVXJweSt5?=
 =?utf-8?B?c2xlM1dEV1B2OFFaZ3NVQXdyVTgxaVQ3UStNekdMM3VkQWJkQU15Z0pDWHZq?=
 =?utf-8?B?K2ZhYUJqNGptT1ZlaFMzVGd5VkNPQjFtbXVnZ2pqRWNIcWorNGVXR0NrWm9Z?=
 =?utf-8?B?T09mTG1heU9uME4xRmtuUFM0LzErRHd2MDVGNENMT2lra3BDWjN4d3cxYjdY?=
 =?utf-8?B?ZUY1K2RQVC9mdGxHczg0eEllN3BEMUtFNnhuSHBHU2oxQTF4NmcwbTBUVnVR?=
 =?utf-8?B?blNRNWgzcnFXeThYU0VMTEJiWTBPcVMyY3A2TkNuY0FHUThqcVVrME1RenJU?=
 =?utf-8?B?SFBZSTZudWVRN2s0dnhPbDl1eHBuVzBBR1RDNnlJdXptOVdMcTNSTGJpS2Mw?=
 =?utf-8?B?VC9TZTJ1TVMxU0p0dEdJVFhaUkt2NWNaL0V5ZldwU3RkQ3BnV3lwVkd3bVFG?=
 =?utf-8?B?WURJa2xkMFl2V0VTS1c1MElKSVlXVDVaWFN4QS9xUFBCZHlJUHd6SzZadXE1?=
 =?utf-8?B?ZFNxakc3ajdrNEFWbVJ5MlBaVnoxUEtmYUVoM2NSU3oxQWRMWCsySGR1WGFm?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38AE607EAC6F5D4481D9355AC81C33C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eivAxagjKmUG5LK3S3PF2Oz7XrtadckJtvQwGMOjbhs8tXS4O57pGvEiV0yHt+/9d/MHvL46SArsyCCqpMdrAjKEzjj2q8Lcj8ZCJiF5iDnVdcmjb9PY+1u11LsYBtJPM2qpoF17hXfdo03WVAYUVt2y8c+qyo/eagQRDG7qWiRljn6UnfTzV8wMxDhTpiRwnviqhwAA7VRWU/kIoC8a9Cwhoqb4XmKjxbSQ9YRfUhMJikcJrz+E5Ah3Uh3H1fkM0yH+NpFh9rLfszM12UbAk4KHzTUc7daiyM1n1nJXBDr8xj1CLQnPtd3XvBySd12f206Wgq99slW6NceWPG6Em0XjnX3SbrpDm+lXo5VT+Qyy7Eb/rBiT/zdPH74r+ur9a6yxmlk3kNFt9vbhFiTPS4SCc+qgreD6hIg1TxheIk1pqJ/D6KvI95QwfNRP2/dplGGBTO0DqU/eiB4Vs92u71oScRQu5aacqkNIM6MB6GBz6I30zGgnDqrNP11cFtJi3otNm6QZ54X66DzjNe724Q2M7HjRF1FaUVHiiMJfo9g6QjkzbYCdT0bMqF2S/4qMjs9iRmPgvNfxnD225OnV3ru7NjamLHAsHiOj8fEhdktC8W8CCW877Z70Zue59uBRaNUkAS1IAR/jKpfU0BOC2VxIAWU1H58MPXui9WakJjxAFmtOIkXQMPtK82NK3uVzOx7isKYisdO9fCJ9LBEakld3dkSna4d5OxEi32cm9FRK5TLCknIfqTnNLtsI6cGgaw1S2RAVHjdYzv3cEFtgaJSOd1m9BLEZVwh2D7tanR9xFbiJTIZ9vM3EvCIf/tg8E8wMcYFOPbFjG2LHMeApOQDeYEudETgYwkrmAqRcDNZy3XO7LeU61BkdRxbvECJ4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23376c0-1603-43e0-8862-08db4baa2a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 07:44:03.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cO87Up5CevuJ50PKcS8XtM+9rZ7tPD8Xy1YB9vnwTcWU1EwHaMKBtzEjydf625xQrfvE1tzXcRt9gAOpAJYvp7hsERz8fDMphN025g3G08A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8163
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
