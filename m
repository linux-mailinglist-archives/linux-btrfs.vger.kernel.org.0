Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F745730652
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjFNRul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 13:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFNRuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 13:50:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780791FCA
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686765038; x=1718301038;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=c6A1UdmqCX+jcN2WRomAO7DWONnAyau7wK/RNUseR+s=;
  b=fQEqlyzXEDOASaMw+eX8lhkDENgyz6On9XDyDr3ks8l0HFkECglQbQsg
   JQyxZ0IVIGeNdnH2vz/ylUcZoMOb5FFvUFwQp1Brr6MrVTB1/nIT9c79/
   Xu+xuY0Zf7x1KXvc/WXlXsY3D590JiqtshIXddvGUfglXDQkjwucPRQPj
   lZi0qNmrfHshjYVuZOMDt40NnbBHBmdX9qA/g9757aW8270KqTAIDNmXD
   hzoT9KAXK2yXvW9Pcr1yxZ/MvJ5vR1i3zMPcb2iBoJoYlnQg9M+mSsHR9
   CBcIpCJMk0+uEacYRff1XAqIDTp1iIJP38bIwIJZWsDvpLkRBUXN9jkB7
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,243,1681142400"; 
   d="scan'208";a="240101631"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2023 01:50:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpDcSzUBSdErSMX/YrGDRVLcI2N4H4v+WfzcDw3/fbNitH81uybQnvWdhrvntIXP47fVBjlmp1b26+9OazO0JH1Hw5SmvcvloC283Dns0CQLo2H+N5y4m5eDIYwSCXF/h+g9hDE3QaIgX3Qfjz3jI2/VfvIg221rzu8l6QaGjaQ99rWh7nXelREoQUdeCCEhTngOmmbMnXx1x/kvIxEdL6Dvv0Laf8AtWmKtMKiSd1IS9TsrLv8gpQl/fj4MM87juQQuQVa7gytAzBbfQ4sBdSx0Kala9v46l7sZ9KgL9p/cyNu/iFauUrdwCpFSMCSAlplCBfYrgbASyeaZShNKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6A1UdmqCX+jcN2WRomAO7DWONnAyau7wK/RNUseR+s=;
 b=LccSyHP/INhB5jaPRBaik78HOqkg/vPJVVZ5f7SJUsghsZ4mDirUOnmvqL1UifUX/40OYjSEWifg1oogGRilujiT8f2LU2IHxdGlKKiC0Fpi5qT1yqOkltZkTZwP8QvTKai1M9+ge0CPcOCCYZwKaT25PTiKRxv073TmEeLc1CDQc7ljpZdRtx6O80rKudBta5rUDonUSuZKE7ZV8ZppkG/Bvo/ar8roNV1IjFUkXmvDV57y5TYUUQ2Uv4BZCvPROlSkwbA5cHFUxGaDMK2geIpw5lgJ9lot7UpSrzNSyTm74CMDKxpLrZZ/z5ZqcJfgWC+wsaOEzN1aPN+40ThRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6A1UdmqCX+jcN2WRomAO7DWONnAyau7wK/RNUseR+s=;
 b=CC9NsuDD76B19aF4pN39bGYWBLOB+qjrX56sFkvR8qCWtzRmpcGoQbYzC5SSOovApI+yel1An7R9Z5JwrnxqdTBGhOB2pSqgMC0i1ssmqMacO7g1v46H2lcuIsAffMcSZ9yBGpR3mPe3dmmsP2eG2ocsRhEWZ1jGMI4XC/Dz2Yk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8181.namprd04.prod.outlook.com (2603:10b6:8:c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.42; Wed, 14 Jun 2023 17:50:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 17:50:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
Thread-Topic: [PATCH] btrfs-progs: fix accessors for big endian systems
Thread-Index: AQHZnqqzrdI5XXo+lkqn5Kn3nI5Lta+KlBaA
Date:   Wed, 14 Jun 2023 17:50:32 +0000
Message-ID: <c268fb1a-3c51-3609-920e-47a0c2286181@wdc.com>
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
In-Reply-To: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8181:EE_
x-ms-office365-filtering-correlation-id: 0fe4d88f-5f8e-4714-c02e-08db6cffd94c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1Ign4Cv99IeGXdxPSMF8p0Sl9fhHxtek266tyZqQuKjOTnZcXmT3P8T69luwx3b8K76yMTvIUYTOO1RhqdoEiObW27Hn8hrp4tpDpAmfB+dPx+Ym/+TJItKIoOpnp3FRnvsckbmYdCSb3WznSRdfHYWVA6qBroJwe5Ik/Q19Q/hARenjxoeIEioKBMYESbVeTizQsHrcfAxZxIoHDqfLYotJTaICnxOdc2sLMWdrwHj6CaKgw/y2qsaznMSyQJt5nunqVkSIXFDzZ5ZRUwGnQmGZwWigrHToeMLLwojhXrNYfwfJ+9zeL4aaL2B2xlzySPsIkmgxz89ToVCKzzqBXQn0v20BeVmR5ZSmnsFckIv/4fP7bCPgugSzRZyKRfG+8Jglm/QWdzYkjXjHcEzUudIxxrZqLwR4fO+KTZ7UBPAyBwbybzfkCErTM/gvLam2OnPyvBB8r8qZuRHjV8ajsQBIJJbrdFwRITIUUsGMLg/g3y67ZOtySPYmbS/vlzZ7RO75k2cuedyc78vifP2CVVxwQ2LxpBfnsEhhK+RIOirLDoE6w4K+v5BcUT1oSidyNF3qePA2DFXi81ohkqsC7ccCd0yg6lI9/QSFYL9NJLLY8FuYMN1e+roY25j3pWYIfxzceauBKlQa2egbjnvBEUWQGNLD4DOWirusU1zAdNG5v7kGw/r97kXDBr1PHZN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(110136005)(82960400001)(478600001)(66556008)(91956017)(122000001)(66446008)(66476007)(41300700001)(8676002)(38100700002)(8936002)(2616005)(316002)(64756008)(76116006)(66946007)(71200400001)(186003)(6486002)(26005)(6506007)(83380400001)(53546011)(6512007)(31696002)(86362001)(5660300002)(2906002)(38070700005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FTTE9XZXJwSFhDOXJGV1YwcUxPWW1OMmY4bXBzNEkxcFVubTk0N1AzSWQ4?=
 =?utf-8?B?MDdqbkR4QWN5Zk95MmM4dlc3VXBFRWl6TUdWbkM2ajB2aHFkN2VCVkEwWVdu?=
 =?utf-8?B?UHhnU0VudCtNV3gxeEp6SlhwTmhDdkhaSE5SWXQrcmV6UVBMT0ZLSVZMcXVU?=
 =?utf-8?B?Z0I5amVMRmVXdHRSSlljcHh6MXd2ZU9SOUZ2SGdCRlJqUTlwUU43YStSaXlC?=
 =?utf-8?B?WDJDUnQwRTJJS1ZGcEpwempzc2ZNRmNpbFFkSGkyYnVWTHJGaGtuZVdHUGpF?=
 =?utf-8?B?SFBzR0U5V1BYcnVyRmYrQWhwUlZHUTF0OFBGL0FXb1J3WVExNzVqa3lXRExu?=
 =?utf-8?B?cnVCN0dmd29mQWhNelRTbFlIRHFtNGlTaVAwRHdrT0tpUjY2cys5U0RxUVI0?=
 =?utf-8?B?VEtCTk5aTUU1VnRqM2VyUG41dGJhTVhndisrRU84WUsxc0ZXVGpjenRzN01O?=
 =?utf-8?B?Zk1sRkc5K3o4dWZzdzgvRWwrNUdMUG9ta1dZQ1VTOGgydU0rNVBJTzVJUXZq?=
 =?utf-8?B?RXNoNnZOL1F1cWNUYUhlU1I1SVR4SDBGengrY0JnVW5RMStxZ0ZBckp3cXlD?=
 =?utf-8?B?dm11V2xQWTEzam9seWVnem1hTENKQUpRaXBmdTZqMkthNnR0SEtXOUtpQ3FG?=
 =?utf-8?B?b0VWMmhyWEVHaERyU3FJak1MdVlna1hKZm90L09UTGlPcVA3NmxiZGFna0t3?=
 =?utf-8?B?dmxaQ3RPMy8xK3VXWVVRVXJkWFJ0VGExZm5vOTBHUFVRSWU0eHdwSk5rSmJ4?=
 =?utf-8?B?bkxDdUZrL1VKNHQwOVZFMlRPRHVXVlhYT2tPZ3liM3U3a2xPS0FZdHhFT1Zz?=
 =?utf-8?B?U0paRUFsaXBrbDJ1R3ZTaHlHVHJESEN2cjJnR2xoM2NVWmY0S0U2cE5ucU5w?=
 =?utf-8?B?S0NDdFZQOUVGbG9GUXBmZVFjTkZDWGFYcmNnYnpTRWZ0eDB1b0FyN2ZmbURL?=
 =?utf-8?B?UURiY2hZaDFNYVlwN3lDUytJRVlxQkMwcFFMQ0xOazJsdnNZWnkyQ2hQZkds?=
 =?utf-8?B?ZCtJLzA3Y0k0RllNUkZjZWVFMHVtWlJHK0NLU2ZkcExLcXAwL1N3UVh2cUpN?=
 =?utf-8?B?cTZTQmRmVmpsR1dUdFE1d0MzL2x4c1RWeWtqMmh5WVZZRWFYMlVUeHF6b2h3?=
 =?utf-8?B?dDdGK3Roa1lKVFV1WGtnVW5BUTg0VDFBRlZ3T25GU3NPZkh6VnREamhkdHpn?=
 =?utf-8?B?NHhQMzNad3plUC8zQk9yR2ZyTmRrQmdPdjdLSDRDNFgxL0NOS2xZTXZHNzl2?=
 =?utf-8?B?N3NpaDJXeGpWeEI4QUxubndyQjZtaEpYL0JnVy82dXhOOGdsUEJzd0p2QU9H?=
 =?utf-8?B?bW9xOE1vWHlJZ1gvMTVVdG5HRW5zbXNTbmUvVjF1eHhpOE0ybWdMb0Q3SVor?=
 =?utf-8?B?Vnd2UEE1amxVUDMwWG5IWjBGaDI0Qk5KMzZkQjhCZURJM2xzcEVwQk5RdGlN?=
 =?utf-8?B?d0pVTGRvQS84WWY5ZkZZRFFqeHlhSmJwbFJlRENFQXZFU3hiWnR4RmQvcm1h?=
 =?utf-8?B?ZDdkMDhwZHZQMWpuaWJ3SjRIeENKczNtZWxvRjR3MmR0NlZMRUpSQU5HVGJt?=
 =?utf-8?B?ZzZ0Nk5zWS9lVDdERks0S1QwMDBBUThHMjRPSjNLWmxuUG5Mc3hkc3Flak5q?=
 =?utf-8?B?RkJielpaUUlOTGxQWDJPQktLTEliUTdQT2ZQK0tzaFd2R0wxQ21ZdXIrSEsv?=
 =?utf-8?B?TVJ4V2VXVEZNbHJSN1c4TDFSYzNrZTBGejNMS1psUUlrN1FXSUpDMytpaDZu?=
 =?utf-8?B?OTUyQi9OY1lRZXNFTzlFdTVqSVlDSnFRQm5jQldkaFRSajBkTDJXYkRvMVAz?=
 =?utf-8?B?Vk9mQmpUQW0xY0V0dnRjNHJEWStZMVBQN3kvZlVlSnU1ZS84NmUrbDZBem5s?=
 =?utf-8?B?aFd4MUc5UytxVm9ONEpUSlBlOTdSTDc5ZFBZc0ZqUWc1L1dtWU1EK01Valp2?=
 =?utf-8?B?Zy9pMTM5amtEWjUra09idlgyT2ppWU9KcGR4QmhqbjRIdGZoWVhLV09HWDc0?=
 =?utf-8?B?Vzh3YjBQdnNVd2R4ZWZaQjBmbHl0bFQ2czlqY0dyMStBOEJDdkhNbHIrZmR1?=
 =?utf-8?B?dU1OVnRuMldzbDJZRHNjY3U5R2xrTDZDbGNQeURTUVdkZVM1Nnk1enZwYU1C?=
 =?utf-8?B?MXF1cFBScFpiOVJmWk9KRXBWYlNkR3BrNk1UeGdYRUFxTURJYjJ1dUUvYlFH?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3544F63CC696B84C818267F988EB255B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F6hGFAjlJ+FT2woxXEFOP3Zy7q97vFw1B+pV+zCDsOUvdFQNOvT9/DlUPvrAIVr8xt40bnkoVRQQ2oKjPcL/mtlzTL7pXEULQ4+5m1/T5cWIaWZsQ7ygmGjQA3zOIEO153TBh58Ngy8+Vj4SI7AcSLnqbOnNqubxafIBuYUdUO6TH1rpzGrt/kLcJLbaFM8vgszYnf9Zbnzr+iA9HinnC0BJ2rIM9Kg3TFLk3jh0oHmv7aXN9kXr7F+yFlvlgUJ8dfW4AxAOWFi+oOA7zxl936PJmcNlGk2/t40UyJfyaWFhpS9ZKVbZf12GgRXtBbQsFDwKIQ4oi/R4ZgIInQ13ZuKiTWOTGGqQ4zFf49QUl6Vshu6OnptyCmcOAi0GdwX7hAI6TPdQgqQPePtfcf9fuel977r1wxV7gPTTcfh9BhqFd8ad5jwg5rDFLeKvdwo1eFyOwTZGJ8YAlcsxfiLjHgM1uQNcmKr4YnrHOK3wF/PPxR9qxuqTXaOufwCJk5wV4tltBpdCIXeUWw9yG5oN2m+U10LGOf87nKxmLvtvRmH3kLXJJwhCqinL/6fPJhSeQ5R0jV6ofFG53AOgVxREmIF/DJW7mmWbbNUnuPyZMtWEdbN1pupEvyFHMA2wzFj+DwjtNJ5rROMzeH+CGphBP5EWu7PTa3K0xZY19PoiqC3H/SJfgo9MJUHDurkFms3CPLC9GZkvk67R4Y1V6lhermgONebB+6onHHY97La2ggTAEC+6UljTs4pOLvxeAJvs1AoCrGxlBxxnM/H5kXYCfxhYJVTei0M7ovai4X6wVhgYuyrCTJQ9p3y4UX55P4nM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe4d88f-5f8e-4714-c02e-08db6cffd94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 17:50:32.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdwraFgCsSqhR2kzw2ORBsB5hjVSMsV3L290FoMIEgvnO+fcK+P/NYQ1J2Qs4SjY7ev9u/SyPwhGYHh5SK4q9JmlkI0PS1jNjesxoKKxYaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8181
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDYuMjMgMTI6MjYsIFF1IFdlbnJ1byB3cm90ZToNCj4gLS0tDQo+ICBrZXJuZWwtc2hh
cmVkL2FjY2Vzc29ycy5oIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsLXNoYXJlZC9hY2Nl
c3NvcnMuaCBiL2tlcm5lbC1zaGFyZWQvYWNjZXNzb3JzLmgNCj4gaW5kZXggNjI1YWNmYmU4Y2E3
Li4wNmFiNmU3ZTlmMTIgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC1zaGFyZWQvYWNjZXNzb3JzLmgN
Cj4gKysrIGIva2VybmVsLXNoYXJlZC9hY2Nlc3NvcnMuaA0KPiBAQCAtNyw2ICs3LDggQEANCj4g
ICNkZWZpbmUgX3N0YXRpY19hc3NlcnQoZXhwcikgICBfU3RhdGljX2Fzc2VydChleHByLCAjZXhw
cikNCj4gICNlbmRpZg0KPiAgDQo+ICsjaW5jbHVkZSA8Yml0cy9lbmRpYW4uaD4NCj4gKw0KPiAg
c3RydWN0IGJ0cmZzX21hcF90b2tlbiB7DQo+ICAJc3RydWN0IGV4dGVudF9idWZmZXIgKmViOw0K
PiAgCWNoYXIgKmthZGRyOw0KPiBAQCAtNTc5LDcgKzU4MSw3IEBAIEJUUkZTX1NFVEdFVF9TVEFD
S19GVU5DUyhkaXNrX2tleV9vYmplY3RpZCwgc3RydWN0IGJ0cmZzX2Rpc2tfa2V5LCBvYmplY3Rp
ZCwgNjQpDQo+ICBCVFJGU19TRVRHRVRfU1RBQ0tfRlVOQ1MoZGlza19rZXlfb2Zmc2V0LCBzdHJ1
Y3QgYnRyZnNfZGlza19rZXksIG9mZnNldCwgNjQpOw0KPiAgQlRSRlNfU0VUR0VUX1NUQUNLX0ZV
TkNTKGRpc2tfa2V5X3R5cGUsIHN0cnVjdCBidHJmc19kaXNrX2tleSwgdHlwZSwgOCk7DQo+ICAN
Cj4gLSNpZmRlZiBfX0xJVFRMRV9FTkRJQU4NCj4gKyNpZiBfX0JZVEVfT1JERVIgPT0gX19MSVRU
TEVfRU5ESUFODQo+ICANCj4gIC8qDQo+ICAgKiBPcHRpbWl6ZWQgaGVscGVycyBmb3IgbGl0dGxl
LWVuZGlhbiBhcmNoaXRlY3R1cmVzIHdoZXJlIENQVSBhbmQgb24tZGlzaw0KDQpIbW0gYnV0IHdp
dGggYSBjaGFuZ2UgbGlrZSB0aGF0IHdlIGNhbid0IGp1c3QgY29weSBvdmVyIHRoZQ0Ka2VybmVs
IGZpbGVzIGludG8gdXNlci1zcGFjZS4NCg0KSnVzdCBzb21ldGhpbmcgd2UgbmVlZCB0byBrZWVw
IGluIG1pbmQuDQo=
