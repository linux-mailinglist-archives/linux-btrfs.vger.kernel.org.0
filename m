Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB226F5231
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 09:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjECHtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECHtV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 03:49:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B13198E
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683100159; x=1714636159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jKm+eStG1/jbIYfbbypFHmuxIRtv55GTwSGyFzQzuqR1ntS29Ltdzeqj
   6RKzky1RglzPFTLcOEc6BFDy647T9EX4lrrobaxI1519rnxSCMcbLqpTN
   XtIeRHK/SadLxRpMflOIOuMkr7/9ar94R8I2r29jkcs9CfrRcsVgUpwxR
   m+Pl+b+hemaRZ5hZxfzbYIAeHd/DxZEwvhpf63KdNpYjQC8pITQ33KBAn
   B731c1rItfpGPf/+PqtEHeDWw5QA1uT3kbm1p+bbJSEI+IoFPM3stoJbK
   yFQFa77H1Y+HJ88fX/QmidwYds161Me0ROaxkN/1AVx2s4Uw0SAkw2jzj
   A==;
X-IronPort-AV: E=Sophos;i="5.99,246,1677513600"; 
   d="scan'208";a="229671775"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 15:49:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYduxsLz0Onk7Xx+cSWfhBP0Akhv8At1+FuQrFZjyXCkrRjVpEbxa2gqfCgp+agwAZ26aHPDggsQGPF7Vgkrho7cbV44r7gnm2gLy5BBAHPNWEsOLHR0yYtPx3LvZMTUVH86KxLfypN3eFd3Zk5UY3fXKl3ngAxJnGsbjp2Bnu5KUD+F9MhXiNOTmZy6c4qgL7J4eiwJ2Ka72la+RBKE8YDqLTOTOGQhYH2qkdiQdi2t0vCxAD4D1WoFOzbdEhNLy9G4mGV983RkPVKtzZOtJQwJHrI74QslnPp61vctLdwMx7aJHO3lGh3E9c2bst3c6ntuLLyqIxhjKk8XYOhLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eJX7g0qWPdH7tOF/0gDjliiB/kW1xt3YcAqU19fXfeJsbr59G9grC6mxt3SLWE9fSEIZX/klDff03BIErGaTnoZRQDzmU7UGG4lA+FRB+bnDJU6btRi5vnAfR6SzG0cdIf3sxvxQ4zVxEHya5raXZh/e4MRJ6nuOF4Ccnquyg/g+m74Ic+enKkDf5j+Yxl3nj13Aadfkbo8dJIb8VLIhjOGDTgaZFapM9/h99jBnfO5aP+maSZv2P6R7uYRD5opC8BAGnwPYbAxOBBDcTc11lRXp2ks0g8gtx0NdYZcAoiq8fKMbRJzqLrHI0/eRXsmww98uYrIM1Lvwi8IUcB8GYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NWvuG6QZX85+FF6OAa7U37DMpDovCaQp8UAjCAEKPmyhdw1s15JsKrXdhnPwJxQMO3Kam9bV9AnX5yrbZam/GLJvk1aKdSObAQgcsE+ZkTSp+I6OAPO3ZVXEUFhqeOqMVyXjMPcKBGNZbxrMBXqHBYsGSGrAUOfDzyXZBi47fwA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8114.namprd04.prod.outlook.com (2603:10b6:610:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 07:49:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 07:49:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: remove hipri_workers workqueue
Thread-Topic: [PATCH 3/3] btrfs: remove hipri_workers workqueue
Thread-Index: AQHZfY3OwFNqsH6NcEC/N3quUsb6tK9ILGYA
Date:   Wed, 3 May 2023 07:49:14 +0000
Message-ID: <ad8bcf62-ab1e-4799-b7b0-5e0b682abad6@wdc.com>
References: <20230503070615.1029820-1-hch@lst.de>
 <20230503070615.1029820-4-hch@lst.de>
In-Reply-To: <20230503070615.1029820-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8114:EE_
x-ms-office365-filtering-correlation-id: ce6154d2-d787-4f3b-3c6e-08db4baae446
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwdFAjIIq8ZSG7rXv5nl9CBMQxD+9tV2oJ74DRcZDtDPB3g0mHzWaR0UHzt1LFWeAt7Z2qwxvg3ELsLjKw7JtrTkaMRRRltuMGhCN2OOl/8QMK5DuAqFng5YXNn6var5Q5AWhWApSMXG41ou3Z/y4CCZSmlFz08quE0Q6aDFE06iwkSaLefzquAFBnXz7Q+EZx2Xwqs4coIFoin4GMcEY00jYYUHfZXYJQXOQU5DhbBYApNIAW+QyHOvc5mm9+w4tuzOy2wsZ6sTP2EB3se9HH0tO3aLrhmXyl8TPJ1WmbUvZMr6hrbFdi8wk+TpgJrds/huwAOcIxYqjPzXmMoswQyUlhPtNONnA+K/Tuz1QaOfXKzjnADBy3RAy6cDHWHW9nIEb+qd3hyq4/pKqaCO/dOCWPuBMwJuTzVJvbTGHXwvjZCeBNIUoUFM2BtLxzGYxT9ch731krt06JajC1YFfpKbqr4vfdjjuawsMrXsNFfXzHzqraoxQ+AadBZk1czPeesUuYNhbsAwobNVmCgIeTzo7dBUZSfDKvuZ1DmVBjFAwZnPKfpcK5ps/5YD5yt6g5oTsft/O5SN1+LmpQxnRHem1zk4mhKOQXm1lJR/SU5Fa8bAi8IuA9VS79aJShFhVIuO1v3R/PokCDRwAAtmuEFCPbEYbZO0cG5bATL8qOa8cR/Yx60xTdmWbFATWmX7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(186003)(6486002)(71200400001)(31696002)(26005)(6512007)(6506007)(558084003)(4270600006)(110136005)(36756003)(2616005)(31686004)(478600001)(4326008)(64756008)(66476007)(66446008)(76116006)(66556008)(91956017)(66946007)(82960400001)(316002)(122000001)(38100700002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(2906002)(38070700005)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk1DZ1hhWFA5YlBUOVExOGQ3V1RheFNlb2ZTOWx0RVdxNTVHT1hTZ0FlV2hR?=
 =?utf-8?B?WlZxbWhMc1p1T0FBOGtrVEdreHZLbUEzYnh4Nk1YZFllOHNXc3c3MmYvZVYz?=
 =?utf-8?B?ZUd4SmppVERPS1VtUmd6eGFkUmEzT0c2TTY4elhWeE5BYkoxYlVRQVFvMUJS?=
 =?utf-8?B?MkJORXdTSUtzTWthbjI2TTMrRDdGOCtaM09vYzA0K0xRQXBPTzlrM0RCOWcv?=
 =?utf-8?B?MzZROG5vZ0JPQmtoMUpqY3FqME1pcHk1aTM3QTRXU1BKcVdJZTlESytjWEFm?=
 =?utf-8?B?YXZlUEtrSmNnNUtEZ0hKMUJGQUF4ZENOaEN6d1phd2FlbzZackhFRXI3S0Ur?=
 =?utf-8?B?QW5RL3NiSnVsK2VIMERYZnJGdU9aaE50b2FwNWVpbk5IMFlpckVCL2luOE5B?=
 =?utf-8?B?NEJ4U0FkazZybFZBeXYzclRSTkNqNEZTSU1TM1hmQi9RaGMwQXNDSkJITUtB?=
 =?utf-8?B?dGJRNUtmZVdCa3RwcWpheW9VSWF3bU85THpocTUvT0RRZVZBb25YTHdMRGJr?=
 =?utf-8?B?L3l4SmxDbjlQOWNESUsvOE4rMzMyaXdhYXlxaWZINGpNVkt6U1h3Y1NGUUc0?=
 =?utf-8?B?N2tnclhUL21FZ2U0dUVnT1FuL1g1M3ErUnUwM1VtQ0M4aXBibW5HcXZNWTNS?=
 =?utf-8?B?TGd0SVRrSUFCcWRud1pxNU5ENW5JU0Nuc3RqTzZIeDNYMW8zcUJ5NHUxZFE0?=
 =?utf-8?B?K0wzb1ZQWjRpS1NVMVdLWnN6TWZmeitJN2tKZ2N1UUZ0NjZkd3lySlNESlZV?=
 =?utf-8?B?QUx2RnR3MGhUWE83TzZmbktrVmcwd0FmUWNvRUsyQVVxam9zSEhlNUhCbnVL?=
 =?utf-8?B?eEZQSDE0cTZaeWh4emRFTExuNE1KTGJncHZMYXYvMGNqZmtkV0VpcEZhdmE1?=
 =?utf-8?B?VllMYTl6NFJlYXV3RzNzYlVkZDJmdEFPRER5U1Zsc09NeXppU0k3UVlaRGdl?=
 =?utf-8?B?VTZsQkgxS0l2czhZWHFZaXRNWmN1TzkyQ2tkK3NJNmp6QjNtbG5jR3lXY3hG?=
 =?utf-8?B?VnI1cUhJSXhSQThaVktPYk1jK1BmOVVaT1ZqRUNUL0V3dkxuLzgzeTlxbC9F?=
 =?utf-8?B?T3ZhVzNHNFNtM2Q0Zy9xSjRzRVF2eURlMklJZ3BUTUF3Ym5tQmNTaW1ZdWpy?=
 =?utf-8?B?VE0yZ0l6R3RvbUtuWWx4UzZZOFBmUG9xSDVUQ0pSbHpncWRXSTVtUTlaaFZD?=
 =?utf-8?B?VmtlQnYvOEg4OVhyZE5pVlkwWlVaWmNJRm0wKzQ2R2VuSG4veWtlU3orcWQx?=
 =?utf-8?B?TVB0dTd5UloxenRaeEhDVlhOZGVDRllrU0w4OTYxNDN5Q1dGUG5FMGora1Mv?=
 =?utf-8?B?U2JmYVNBY2F0Z1FJQy9IQWRBUm0xMHhWbXZsMHcycWZhR2pmcVV6NDN0dWdt?=
 =?utf-8?B?MGpSMXNVK1VzczQ5dWxFNWNoY1M5OC9sQTMzbE8wYlpNekQzNzQzOTNMbTJO?=
 =?utf-8?B?SmdyMXN6ZFJTMkM5M1RXcFI5R2FqaVhlc1RIandVam1iRkg1Vk5NMlRzbFBN?=
 =?utf-8?B?RUtmKzhTeVVLcFVMWGIyYmZGVWV4S1pwZUg2Y0JUbWJ4WFdJM1Ywa0JoNzVU?=
 =?utf-8?B?RVlaakZHU1A4bFB2Nnh0NVNvWFptTVVnNWhkREJSeDRPblluOVVYTERtY2FI?=
 =?utf-8?B?K2pGR2pNYjNqUThQeEFMOXI3NXNlc1NZc1VYZWJOVTF3ei9BRlFXSWJzRnoy?=
 =?utf-8?B?UXI5OXdpWFU5WGRlQmpoY0hjeUtFTllTSzhtZSt3bVRHc3FZZ1RDTlpEOC9S?=
 =?utf-8?B?WFFLUEFGZ1JuRzZ4NnRkWFhHaS9FV0JXV0FCYVUyR3I3dzlIYW9iR1l3aGlW?=
 =?utf-8?B?dTZRUVo3MUttL09GdUpHaWNpcDV1WUsydTg0bDJPZUgxeGZndlNJa0JhVTl4?=
 =?utf-8?B?OW54cnA0Ynh4K0ZCNWZNc25jUmRMSDJwYUNVU0UyYmxLaVcvTVlRTk9VbFNR?=
 =?utf-8?B?dXJwTUJtd1FqU0ZKUXFLUk1sYWJPZk4yV2FaTjNNVHFpeU0ybjdwTlNtZ0J0?=
 =?utf-8?B?OCt2ZFlwdURCM3loQkxMYTBCaVR2eGRMeDVyeHBoUTQzU25iSDlFMVVwQjVQ?=
 =?utf-8?B?dUk5SzZhQ05nNXFtb05FMUlCS3VXWit3ZEphYnc4SjgzWXRaTnY3UXRSZkRk?=
 =?utf-8?B?Szg5ZjZ6ZVVmemxLbStZYzg5Y2V2bzdJMll2S0JEc3dYR2JIV3BOTEdxb1FP?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49F07475C7A054C882DBA0E6781A397@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yMxdxOlDb6R99L2ic4e+Z81T1dzJvCq5KXC3NzZAHFGUtUjeMhILi1zXwb9WmSojUW7m/IFQp+HvFI9FjGfGhqG3NHCy5lenK5Glby/qU+f0fd9ZwLBhwamDpm01Lg5KQRukBa7thdYmqysdyrZO3D4SUdnaaZQrJRFZlp2Px3M/04FSA0HKy1l8Ab/PMwHwqYwRwoxZo6RlWiy/2m59zrcYZocVrV2Jz56UqCVUobrKyO2mTpm+xuPn2wF6cABsS1BumSyPPSSZG0JnuHh0k3j5rjc8MHPR8wtNWYinBGDT4eiAFSif9Ug5fuq4V2i103V2WQyJatH/7kr4aBY+8GtN+8Fk2qZzWCEcuoYOpo2XEMDGJU+laggmfeWUgDd3wATaL+noKlFf/Ov0V2aT2iRXbfQAa0j2Uz9fsixKs20xPZzKpA1N6uh9247kG95Ji/q1buTQBJZffDfjTVPYSsPFXjtNUM7iFaOlSLxYwLDArl6z1ePPzCigpahNvcg71TpEQcW7G/Q4Y/5w4pbrerygoDW/ISHp4UOuCxLQ30rHdS19cnBbv6webGxnurPSN7OFrl7VNZ+mr2xQPwLX8mTEik/3NygLgYcTr/PZ/ADnsl69SFSkjxr+9gfz5Vu4GNvHOAoA89Tz0eK/VK18XtwHrX4GbIq4bFLk8reu3Z6GkurPeYZAzXgMOFaWAgIasijGMFCmkDmQxSnvrJVlLRRZk8OUI2O7lq4vNcAEaye7XLpMzMcQIgxAr1GwseNADiUzjMV8mNs0/aqrVYrRrxnTVikqGbvnGwhWs2//70LfUwlArliaf7uarjAOByoyBBxAycgKGW9B64l3gjbaBjxxZOCjvpEOzOOEEdPH5YJANfXPJkiUnftBqiuVDQXq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6154d2-d787-4f3b-3c6e-08db4baae446
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 07:49:14.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIDTXhWvASxIlHlqwd3Nogc8CcvormqvgygtywiDUeKuJwY+TUB/2OexpEqC55fZ83gfMk2Nrg6gxw0/uZ1/5yeQIb7+JMOk0XCRasr2tkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8114
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
