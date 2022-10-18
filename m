Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEECF602B80
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJRMRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRMRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 08:17:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC4A2A9D
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666095431; x=1697631431;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nAgSFbSV9I22IrlJzj3djnSU2GRT1Fg7fqfFQNRjsqzBjlXp7sGbSls+
   kcHqH8xn9luV7mKqwXZJsdlgmrFs0NRuNxOwW0EGo9MG5clkSsapd7NB3
   Ql7dprmCY7gPewkDnYsfh9zrrWweBPTb+zFOQ+AMRaAB+YWOVFHZTqdmW
   YSvAWate4q2R1HnMtr8GgI6rrLWy1FdByVDYgDpbEtTa7t/HzqSnXPFps
   j0VULQHYqomkIU+I+5l3njh9xXafEukRB15rBeQ8IuNIRf6dFavir6B9Q
   qLZlIOHlpvMxKAm9LSeOFZowqLZL7jaJL6O+P2t3Y+oPJpJdR8a3Nbqss
   g==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="214500541"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 20:17:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtmXlvmDKniYzQHxGAMdbFk5Bbq5Vqx2uVprMGUpymnfts5mRl+YdJ8kD0vrl4mO6tZktf/hUEASyDpHAed7n3Uh9yXDvzn2deD4ZUGvl5IJP8i19mtRl/lUTnb30GhlDD8g4EUKHt58hPqI65PLQTRAV/yDzzVbZsipz3IA5oKoXDmMIHVHciAUFUVOg9JKks9SzmoJ789Zlkz55Tgt5mXlDc5a5yDoU4rqVvVHMEve/BWqVrepRpWtO6kXvCQT4dn/o26Ec8NOL/RPM/cpMmpiP7fXzJjAGkvdBcVdPQazsUHQYHB3/BqzTZqRhJjqpXU31odflq07A3Vm0syczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=l7c/5l8YLrNk1eoOTAVdzviJBz9KxzhzjnKkW89tyQgqlImhtOysR/xmJKXCdVgf6vT9OeFNhoEzIKFhA4m+1MxhsuDeKZYeIpHh90GrmjJ4nOnowtgcnhJme2drdHwxmoN1F6F4rP72mES8MU+0Hpl9Cy5nHOxRt/uAd0WbPrgu4v2QwXL+PiuqH646RjVwVCKWSlK+K2h8YyT10eTgMXPq39XkcGb3Pufg0qH//OxBXYgbVYN+BGsEHefigRlCS4rnX9Uh/Nc9KRZQbj04SrS/JnNio6htsSBdLnbUKEJ2/fSmwB46D5Yjer4JmxApzNNqPKN+0UTY1BIehhFTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=l+YSFVT58CL7IB0MfN0JQnFjs9/GzsJWSs7olv2F5BGk6X/I51e2lI81QGeAdw+i5mWxWGRk9Y5JTateZb/cOHzHMl6vczOPSHeNahv3Gt8IwCSVJYdaLjPYW2lKS6N/Y1eYI/51Xqpe05agL/tI/KrmfyW9te/DSNlWfc0O4yU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6821.namprd04.prod.outlook.com (2603:10b6:610:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 12:17:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 12:17:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make thawn time super block check to also verify
 checksum
Thread-Topic: [PATCH] btrfs: make thawn time super block check to also verify
 checksum
Thread-Index: AQHY4pTtDOPd2D7n4U6vlA3D1YzjV64UEesA
Date:   Tue, 18 Oct 2022 12:17:08 +0000
Message-ID: <d8a05060-4054-d23e-7472-4dd8c4499afb@wdc.com>
References: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
In-Reply-To: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6821:EE_
x-ms-office365-filtering-correlation-id: 4c36bef7-1824-4e6c-8a91-08dab102adcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: riBnzBOaVBylcUzA3rRAG1gZYn1A8vBdquE/0ymcO+GQUyZb7guJP3Vpw38UDlUqgCfquONxu8X1OCLkXVlMFqs0G10D1QTo2jvb0kdzAiLI2RayzpgkRf4OwegR72W/8l2SLcuz4pHGUHT03UIFr5/oTebqoeypPh3an++tmGc8yn7rjHruWR7MqbrNVDmvOTt7F1RUV2yoh/c9Q4b3dO03OgeWsItpLWU1LK0YmbvEG6dZqIKjRU2tB+5YY6pQejdfVSSJSlOSGDLNWKc2XgLvCnhrgtjl6KHnPyYY8SSW0aPhFFj6sP8IEMCJCFs7ZcgeWg0acp9KPTeeKQAF6tVrPGHugCtt2WecMCGaH/hZwpeVDs39SfEIFaW63AZLXk3u1YFr9xWSCcIoKCJB7EkJZJRa/GfURTjpoR80AW60o9lofRl6wb5uXiKtgodaKGLMaXrAXu6whKY2253JqbBFGiV6laWdNUmZBoN5T28jL6ObZeNcCGMu1YYG/mwZfLV7lOLm+NJkrOMpp6wzMeKvX6Is9MWSXIrqsV06s4RlV6hf4njX7jyYPFIbZoNz889AadNbDkM15Fr06LuC3HBJO9bmEjZdpj48vWnzN2gRScoqoPPf1K5g+X5BmuwtAIgyplH1sEpONSGKsnaIRCqA0i/qSfmQ2ioDg6kfl5NtVS3piol/vNTKzcdP6H0PD47Ye7eZhb3ZMxHknjV83c8+2976PF1uIzxB9TnMzOa4ctzM1X482gDsWb9PiZhJ10LVkOq+eWp29O2DmOTKB0wvDfhdlMbIGXV0o+hN6rX5krWiDrrJQjV6+qfQ2veQ7G3hnWoN1hBNbYhjOEUYtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(31686004)(36756003)(19618925003)(558084003)(122000001)(38070700005)(6512007)(6506007)(110136005)(4270600006)(26005)(31696002)(82960400001)(86362001)(2906002)(8676002)(66476007)(66446008)(8936002)(5660300002)(64756008)(66556008)(38100700002)(41300700001)(91956017)(76116006)(66946007)(316002)(186003)(6486002)(2616005)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anNEZXFCcm4rOHFoS2hRZzE0cjcwdXRtZ2pBVUdPanJ5cVFWUmVYWVM5anJa?=
 =?utf-8?B?eWpkS2FRbE1nNk5BODRsSmIzOEZUTnljTldBaXlaUG0ycUVISFVKM3RPQUl0?=
 =?utf-8?B?L3JUeXJWSlZxalVmSUk4UjlnRWJPZHNTcXdUS0Ezd01HMFlESFN1NW5ZSWZ2?=
 =?utf-8?B?Yk9IMlZZdlRmTVJOd0YzZndtQlZiNUhvMGxpVVU4dmlKT3BnUnB3Wkluc2cw?=
 =?utf-8?B?R01udFVicml5bHZUVzA2b0l0UGFJR2FYenhYQStjelN5QzlaUWVjM1RST0RT?=
 =?utf-8?B?SGpPTXZOZWQzRkI0NjV2L0pYcGt1TGRyVzFBamJSYVNoUE9saUd1YmhWdGhZ?=
 =?utf-8?B?M1dTV0dFVldNSnNZVk1wMEp4c0xKWGtrdzlQQjdDNHFWT3h5NXN2WFNOK1NZ?=
 =?utf-8?B?QUpwSlhkYnZXQmNGRDZ0QTNXNDhMR1RhTytsRmVlYjY5Mmxicm1VekpEZ293?=
 =?utf-8?B?UCtVeFBHRWFvSDZmeEtqQk04SUhSMEpSS0o0bzI0WmtZc2RBdW0wdDRPWDZx?=
 =?utf-8?B?V0dDYmQ2YU82WGlkVDlNZTF5VTRlQkd5MU1FWFBuTW9SY01hdE5aY05mU2Iw?=
 =?utf-8?B?bGU5aWsxNjBWL0tPRHlXUHh2Znh2S3BOdzEybWs2Y3pUUE41UWlsandUTklN?=
 =?utf-8?B?V2JtQUZkd3FxdGU1OE5aZklUeUVFeXpUejVMREtJTmRoSmt2a3JCSE1vM1Ro?=
 =?utf-8?B?NTB2NW5DVHVsYXdWMCtHbHFZUU8wTXl2MGxMWk5xT282T0xJUXRvdWxjUGMr?=
 =?utf-8?B?bWUxaXRVbnNkd0x1V0EwOGpBdmpUVUYydkZpczFwbXdMdjNicjV2dW5WcmJK?=
 =?utf-8?B?SWhBMXlCWUoxek1nOXlFR2RqVUQvZGFBdVJpekFrVXhFREF2NFFSai9TSmlV?=
 =?utf-8?B?K0x4VjZjOXFTWktKdFpKRDRrN2VpcDV5bzJkTWZRVllPcUhNQUFTekg4eXQ1?=
 =?utf-8?B?eWxNYVJaV2FNS0wybTg0QzNweHJpQm5Xb2J6am00VlFMS3dvbFZydU95VGs3?=
 =?utf-8?B?SXcvUmZ1RW9idDZnRWVHa3BDNmRlS2JtdmdCRWs5RE44eVRUTTZFOFZqTzJG?=
 =?utf-8?B?K2J4ZndhY2IzMFFCbmVkc2U5UERpNEVTTUw3amd4ZGI5NzFLRlpEVzZheGZX?=
 =?utf-8?B?UG9LNDdsRFFuejRSektVU2RnZkF4cFRJSUxSL1BQei9aN2UxNURETnUzbVdj?=
 =?utf-8?B?WFdYTExaRklEOW1XYWE2aklsK0FhM1dHcDlqUzkxZ0JqamJqOUV3TzlrMHNW?=
 =?utf-8?B?Y1BPWjgxOFY2WGFraTFhcW11YXNUVGhJWnZFdTFUUjE2bzAxZG1qWUNoOUFh?=
 =?utf-8?B?QmpORVkyd0d3ckxTQ3dSbHBaNGNCaGxWbmVSNjVBdnZZbWpYRExwUWRiVmEv?=
 =?utf-8?B?RGNjT1BwWlNTdXo1Z1BMcHlDOVFxUWc1TUlLRkVnbVdybk1pZWwrOWoyQS9y?=
 =?utf-8?B?VkZpWjBwa0oxU3dKdjJSNVI2aHJWQktWN0VGZTg0elc5TVk2cU5rT3BKUHpK?=
 =?utf-8?B?M0ozaFFBRm9KWUM4cFNyOGVCOGJNU1RNbUVIUnVNUWFVd2JCVVhROEtITU9D?=
 =?utf-8?B?azJwUVdtZzRvZ2J4TWU0WnVDbmNvRmw5UGZvUmc2ajZEWmpzM1AyUnJEQi82?=
 =?utf-8?B?YWZtMVB6aURId3IvVzc5ZkhqQTBrcmhuL2JUaEdCajV0ZmpuSVJFaThCVDZL?=
 =?utf-8?B?allURk00eTJlK0pOUWE1Q3ZVb0xqREM3ajFaekNTdFpwZ0xZbFE3amVGQmk2?=
 =?utf-8?B?cjBUQzRURXNseHRPS3lmMTdTeUUzajNrTEtIZ2NPQ2V2aGRzZ0tac1d6RVZS?=
 =?utf-8?B?bG44cmVlRTRYZ1ByZVFScDBlRGowOFBSQXp3L24yNTE4NW5sSUdjZHRENU1j?=
 =?utf-8?B?MGJaSTJ2ZjhUell2UnRLUCsyWXh6NVZGRUVpTUVuN3JEQWVDdUhUOElmRU1D?=
 =?utf-8?B?K1lBc2s1S0gxUllHc2xJRHZHYSthS2R3NnJ5d0w0VDF1VjBzeHJnVFZnOE1a?=
 =?utf-8?B?a3h6aTNtU25vZUxQSklBUElXajU3NTNRZ1M2RjA3SVZoRTZOaGI3c3NBbVdM?=
 =?utf-8?B?d25HVkZVTURET0dER1RKSDEyL0VZdVdCUmFaSW9HRXkvUzJwZEhTMXhpamJ5?=
 =?utf-8?B?emVvdHB1TUROUHJBMlZmSWR4TldTanFiTG1UbHVPMkoxckwvSlM2c1dxM2FY?=
 =?utf-8?Q?Jgg8kS5HT+4ZqnKvE/OQ5tI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC0CF4677A811F40A0DC6246FA283581@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c36bef7-1824-4e6c-8a91-08dab102adcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:17:08.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epad5r1pVGR3sCPNUgmRrtSrGEoc6yUPlMSWWQTXcdPdK9wys3XLDiOGFiSF1sJIUIYSjd7nToc36btpPL45dKcMZvkr6bZzm6b2UKCHIMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6821
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
