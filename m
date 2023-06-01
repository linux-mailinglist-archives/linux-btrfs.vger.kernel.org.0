Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D231719BCB
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjFAMR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFAMR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 08:17:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E23197
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685621835; x=1717157835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KFP/Vex6N2oSdlHIbt1yzOKi4RZf1b4XUnth+/7P+YMvCmOenE1HMyMg
   Cvb+TU5IKpytHyW288q1PMUC9mGziF3qFx6WxYUoNQrlEXTpjBKpn/sWx
   pc9AEJcR45oJYoR9UY8klvmXe+9kYlu876SY5eltZC1y063LOGqiuN1qF
   uW9kOxP0dJFCMzjg4klFDVnxMhj3gCN/GyY8fk2ywXnsqK8z6OGJ2tyS4
   48OY/CAF7xVB+99dLW2tUrOyEFWhA7v0ubvJxSPlQs6tMhIqi7P5wzJO+
   twg9os7RaDcP/bYFQFC0/6Vr+FNFQAel7T0Gm47+IpuGnTxMHBro+o1BF
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; 
   d="scan'208";a="232160497"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 20:17:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew1ovUKNX0nKSmAChmSZqExDCocNveSZ5Lg2QK8kGXgai4Ir0EF42q81MjqoxER/bOVxi+MVInniWxvwP1k3QbekGUOyfYckWd1TcnPDsNkvT0h4gzDkd9UGFuaK7Gttu7NPOi5B7hjwDnt/GviwD5HA09AQfwxbMPk03tRQaJFPdZazcuPj6v0v5d3rgzLxh0lBckzDd7Wyd8bgi5WTktVrWyoNRkD18Cj4fmwcGDJ/NoYTZPieYELKJJjaM3+sxlUU5StlrgYjkPqZDw+a3qDJBbVYQOuBvVMWdIZzFY0zQgKYGbTBqm1BalZp5/XWCcgjBYLRCzYOGSwLZsG9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=U/Xf4kCBvHHyMLBEFKfWKf8PuJXywegyMDfV4+L/T0PEzG+FEw2EPSDIjy7H55NAwZ64CagNuJPbHmgH9MsIrM0bVjDIpJq5Xot7vR4lVzlQj823SCiuiVO6em5UfhyGHf5KcVbycxij/5SVx7Cyr/IBwZE7UpymNQGR1svUyk3uJmlhaabZP8pHSNdOznz6TDLB2YJ7y3qi4TEHIIt5lEUznmlMuUADstAJw8/UWVUN+LS+ETkiM5Z+fjdoKFIt2S0blV0IZz7/N4lWAxWcippfuBGwCdNSEzvMlWN0jbSahhZJwYVRR3DCYhL9OvZY2YfU2+AaFPicNiXDPJ4cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mfrGZe+DCdmM4J//gBo8nFBL7m71L26JYgylsYWp83bls4mXSqLGyAxrT9u7DLiHkis4hmcHEjt9O09Agc1uAMXb2y/20H+pLdic7CePCbo3q96JkLtFuIItleBIjx63+YGjfYSONPIK1vsLRuw1h0H4+n4IKWgQsnPLfvkW20g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7043.namprd04.prod.outlook.com (2603:10b6:a03:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 12:17:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 12:17:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/17] btrfs: merge the two calls to
 btrfs_add_ordered_extent in run_delalloc_nocow
Thread-Topic: [PATCH 03/17] btrfs: merge the two calls to
 btrfs_add_ordered_extent in run_delalloc_nocow
Thread-Index: AQHZk5Vs9MRY0izIp02gnXCkkZfun6913s0A
Date:   Thu, 1 Jun 2023 12:17:09 +0000
Message-ID: <87aebbfd-07c3-a874-1275-1e6d59bc63fd@wdc.com>
References: <20230531075410.480499-1-hch@lst.de>
 <20230531075410.480499-4-hch@lst.de>
In-Reply-To: <20230531075410.480499-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7043:EE_
x-ms-office365-filtering-correlation-id: 2ec87d5d-3496-4d1f-a690-08db629a1f65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTFxtsMGOlXClvRPT4QThihRUWje/sgp53O8TPA6r386VwbhgxgcEuGXQ9LeUIBzLkxjZXb1uQojfEgdrOtkGZPkeYPnLgZ011CaS54HV28PNf7EKX5Zbg1FZcF0bfINi8/aoPmVeRaLZEfMPcGuqM+vbeeFxELbU8HETsmHvVE6OgtuDwXsrIMMr5rwJTFhCNIJvU56KPdIp1JW/hw0ssEQ9puc0I5NwY2Ti53lMNHwsVfHX0IYRvK1P8FrVp9FQ5G5SWQnq6tb7Ubs2Cp6mLb+BuCulszrzMkDlhW8qaY+qqTLxYVkpRBXmwRBSwrSZMLo0F0VbyfURJNeRY5yGK9NiKy+6JuCa5mB+g5a9pSfS/rhQShCQPyAiywbacd1DI8rfMxrKeP7pILnz18W/lAeuGMNn6aEEC2KAiLnRtrvA3FOy56el2lyU6WJwBgm241LonNHEo3D5p4MQak9MsBH+X3iGCu9AdwKXiLGwzW6zhslYCfT2qoGAZi7WJeG3vdIFOMKfrWsso3F79eOoSqyME1n1Ac6NR60dmunt4suN0fWot17/urfnk0PZtfxvFfklUm+UUEJFkZ1iXUr3uh9KRsKmp0CgoSagGFKTrHdeZw90fOVdTYoJ6Pl3FzLvKpdL+du886YX0EcLMmvmW5j1spDYyL5isKUYZSj6LXlVkFiIY+tgMFVp89XfLeK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(478600001)(110136005)(66476007)(8936002)(8676002)(5660300002)(31696002)(36756003)(558084003)(19618925003)(2906002)(38070700005)(86362001)(76116006)(91956017)(66446008)(122000001)(64756008)(66946007)(66556008)(82960400001)(4326008)(316002)(41300700001)(38100700002)(71200400001)(6486002)(2616005)(4270600006)(31686004)(186003)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3lZY0J2Z1kvQkdLK3owNFpianZQOUprTC9mdDIzdDhiUG0rNW12YWRpUkNv?=
 =?utf-8?B?dEk5cGNEdmpvSFRITEM0SUR5cis3MitzbUpqbmZ5eHpxT2g2bG1rUUN4VU00?=
 =?utf-8?B?TDQzWGlvSFNZT3JVdkg2aDlHMUxqSi9UMSt0dkVxUStRWmU3ZElSbHQxTTZy?=
 =?utf-8?B?S3ZtZ0w1SDN2NXRhY1U5NzJxM3FkMWhpOVJVK0hBZm82eTJYb2FuTnpaTUNI?=
 =?utf-8?B?T25RZC9mRUQ3RXJtK3VjUzhVTE5ZYk5WSHNNR2hwa2xmTWdJaUpYK0pYUW9j?=
 =?utf-8?B?cklSUjBWYU1DSDdpbldsQkNzZkgzczViNjU0NWxJOE12alY2ZHllMWNtZ09u?=
 =?utf-8?B?ejBWMzkrcndKVTRsMkkxNkR4R2NraGx5L09KbzA4aHZPbTVla1hIcG9wR3lL?=
 =?utf-8?B?SHI0SnRKemMwU3pLMlRnSnFCZmJKNkZrV1pXcnpkNEprTUpPZG1MQUlsM21t?=
 =?utf-8?B?UHltZjdiWUlmem5BVC8wdzFaTTNhVExFN1pXQmhTM2hmanhreDBCR29LUmJE?=
 =?utf-8?B?aHkxdXJCN2xaTnZVVXNRZFlMTXJ3RFgrRVVjM0Y4SHpRU2I0S2tLU0IveUZu?=
 =?utf-8?B?SkJrc0Jhckw0R1VWS21YcWJPNDRYRFE4YkN3MVRhWjM5THJETW9rVDZjZ1JT?=
 =?utf-8?B?Vlg0bjBoSzhBS3dWME0yVWZrUUNOelBXU2NOWVhJYUZza05QckVLYlgzSnl2?=
 =?utf-8?B?K05YQTNlc21XTS93aGpEcnNQb25LY0hVT1FxYjB3NzhieSszVHE2YjcrOEZY?=
 =?utf-8?B?Q3pDelFYTkVlV3RJZmMwUTFkeHA5WnNEMVR5WkkvQmlyWlBoeDZkd3BRS3U1?=
 =?utf-8?B?dm5zK3hFVVhHZHFWR3NVY0UwckNsVVRqRUhlY1piaE5oTGg2aEFMN01yTzhM?=
 =?utf-8?B?b3BiUENSWm1hYk1kRVRhZTFGZU1MV0VXVE9LTUM3S1Ezd0lyVzIxWGtrcndm?=
 =?utf-8?B?UllGRHBLVFRreHZWUTJOQjJhNVVxOXRzanpvRUFBeTJ6VDcvRHhoZVNXWEFp?=
 =?utf-8?B?UE11SVhjZ2ZrRkorblNIbTROcjBGU1lDMmRqYlNUK1grYkpDSGk0QVlxNE56?=
 =?utf-8?B?OVNPWnZBRVpWRkJYcXBDS2w1T1JFM29TRjlkQk5Jakt3K2xVSGFIZ09tdlpj?=
 =?utf-8?B?YWdTaDVkVkVQelNtMVR6U29mcnFyQjdGMnd5YzU5V3VmZmc1aG1DOXZBbWhG?=
 =?utf-8?B?eHV1R21KNW1lQVIwRnNSVzVLTjEybzVEU3dneHJwUkJqaHJkUnZ0UUJOQ0dy?=
 =?utf-8?B?b2pmdXhxeGRmVHlqc0gvYW91NEpnTEpnbGVwNDRLRVUvbzdmTUNBa3cvWlNJ?=
 =?utf-8?B?RTZEOWJBL0h4cytVdmJtdWJxbXJmZ2dxVVZabnB0UXVUUVVxNVFYcjVHZzFM?=
 =?utf-8?B?cHVyNlc0V2ZDTmJSNWVNV21abXJBc0V0VlFXZldkS0xhSEczS0VSMzJpNFBE?=
 =?utf-8?B?RlN6SWViZG5iWWFNa0xvSTA1RlZ6clJ2cmtlOVdUbVRaT2ZucE9jS0ZTUzNr?=
 =?utf-8?B?RldBOGtnYUYwdEhzMUhFS3FPemlTRHlVdzl1a1FFUmdTR2x1bzlMbnZGSVFK?=
 =?utf-8?B?dGQ1Vy9odUVqR1VVT1F3ZE80Z0ovTTV0NGEva09WTGVTbG44TWFvZVpsQXc1?=
 =?utf-8?B?SGp3U21jbEp6TWxTa2hjam52d1Erd2laZmFNZmdGQmlxWWlOSnhrVjdHZ2My?=
 =?utf-8?B?SHMvSjJzeWowb3gyVFRnR01RTGxnTnowWHR1NXkyWXJaQlVBK05TRWduVkVa?=
 =?utf-8?B?Sk1OM3g2QmVNVmNEbmZ2cWxxaGFBMUpwM0VnWVBUUFEvaFlwdEw5eWV5Wndr?=
 =?utf-8?B?T3k4clFXeTlKSDN2a3JlbHJoNldDRnpETWt4dHVtUmxEYkdvaHR3aDhHWVFB?=
 =?utf-8?B?UEVRNnl1eVhEWFcvVlloMk96eVRZckUwWVBIZ0ozRy9QK2pscEtLYUtrajA2?=
 =?utf-8?B?cXpnNVJ3SEVkM0gvR0ErcWNjVXBrbVZKYzREWDVxUzNxM1poQklaU1lsb3dT?=
 =?utf-8?B?TGxob1p3NEZVWnp2Z0pXdmVITkdvWE14QnhlL2JveXpXUmF0L1JYMWp3UnhD?=
 =?utf-8?B?clpCQU5ybWdFcW1ITi9LSUVFNCsyaEZDVCtna3ovV254aU5WSHRDYW5qalR1?=
 =?utf-8?B?TUNvWmVndkhPa2FGODJYNEJXWEJncDJ2SzcyNkNyRU9jS1czRktoT0ZJemlz?=
 =?utf-8?B?MVEvalJuOXI5d2pmalp0L1dNclE0NE9TT1FnUTdteHhSbjBBNnI1emgzUTND?=
 =?utf-8?B?a1N0cE5VMXFsbjFnYVVWZ3hiWnF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE69AA7EF0E4640BBBDB7350C264D1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T5Vl2BwraWx40UGQfDAA77hD1Oc8WGnue2rspeiF0qij/IbdMivNXPBrgEn6b+zKPT72eSlmNN/OV5tD5Px5JS9lSUgIUnz5NFlL5+KTIL75NK9PNCd2cBu7cZ93gGqDlpBLQCrZm61/r4B6WtEA88+0sO+gu4s+uFiGXXhnHvMYNBK22nSPyFSo2MgzR4a3UKZDuNJwsWt3C1mFc5ypCwAe+KpzdWFGRX+GExuSi5FkTBAFbC/LjtP9SNNO/2Injgz8BpXVvKrTEX5t8W1TlseV6ad0rdkhahpbeucQfNlCA7h9ekOdMnK156ceSiVQryzmGhQe50edlPeWLVMM1a70mtd3W9mgLbIM7+SnndFZlr4T0JW+EbIdX52lxU4fsYaGfTmnJRQNCXWnhYc/aDCVJqlrFIiBT35Nmu3sGgxdxYtax2+7fG5iV+fq40zZEfAyfKbNlzMdie/I28AXX3PmUAmfsNvkhqeLAzOA7eNGneNhs79H9VS6cEm0TnVKlohDROHE3OQhOXML70g/i/kHp6xf9q2q0fH2X9r4HZIjhj2XSt+UfNBeVoyTJclXh72fcZKYgBUiOt7M+86LBDtA/Kgb8z6AHA6Je8EYml2WJfSlFYhodg1W2j53CMst71o/1bJ1baNlC7gBH8h+79qiEtWxwSkGorF48Vr5zJ/qbU2BjIgruiRiAE8YA23jHLKEB13aMmHzEwekOwBGVYsx5dvsTIuYl0aacWPQMqQGX1s8rvC+MAOB3pWVTZHzmZirLeaqH3NGMza5IY8gBrnQnS9wClZkcDDNcnCD6qLJaCZh3ZX4q5ELc7ZJVMqkil4YtvA+Z4coE0m48t+ss1IQxaoiwcfWTYkqcKsX1jNydl/umcJBg2d8Y4mkGfBE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec87d5d-3496-4d1f-a690-08db629a1f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 12:17:09.4237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CYvOCuszKxJ3XGaa9EpyT3U3PJKwcTugegba67KhVsQfBDJaE8pXFvZMQP4YVLos7HAdYB4xc0mno5nA7mag7aGIAhPaU9EhPMWyTwHf48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7043
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
