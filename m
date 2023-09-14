Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC907A009A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjINJpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjINJpK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:45:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30C1FC6;
        Thu, 14 Sep 2023 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694684706; x=1726220706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZBxe2kUO4mdbi0oNMesk67beiCMXeYLl7ItI12OtosM=;
  b=T39j2rTtrC1XSRBi8Z29DJ6+Wq+XZB/53IcxVPAGyA3r7mKSZidTsMiA
   pWubSQsnhbOdLdgvKA06Hx4sznkCM17Ad3wSUwyBbywU8oy27BFx1iLV9
   NFN1YWW/wsL0Jx24YCUmCmgZ4l6Eh30R2IinsF6hARnTlCcuSmSxXpDCz
   garILR9BzF2mb6dLsAcjnc6QAg7w4VwbOaX/U2KyjGcEoGj6cM+YZ90nB
   ah25UPQ5egotrOihBpcdJp7onoR+CNxmvOfjR6Hacrc/ghkWRD8KjRkHf
   7Sidpk5E5WI2GuGNdpO1qwvZ/rM+PmT8rW/TXPOBf86PXAA6+3siEYtQL
   A==;
X-CSE-ConnectionGUID: VQnDNuEQRS6fe/aMEFNVIQ==
X-CSE-MsgGUID: 2nXMz9oCT/S0nuG5qQRWGQ==
X-IronPort-AV: E=Sophos;i="6.02,145,1688400000"; 
   d="scan'208";a="349249028"
Received: from mail-bn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 17:45:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd2ukXx0hmP4ahFjx/Nz5OIpf3L1iaE7fRpSzqzOpz0dRh4VxIVdbj10FavjVJKfMURvvB2IwY7GN/OCDfyl8E4QzyatUiF34+jYMc0a7GUepRHxXlcggf14rzNiTjFxPznnbzEjRsbTH5qZM4X1sL5DLkdpeZE34HI1eOu21IaR3vUF6tGi7c9p09GqI26HElmA7N9xAwZqWZKXpfVDZQXI1HOtXmeThlUZ1BIt4Yqv2zt3GA/UY/SfLcW8CiKKa73Y+LlKD5o0qMD027kC3lM4sUBDffqfT/Ykyb3kJW/kLOOWa6zzoKxI5uUq/ade65kr/zVsE3D1gmCAewIkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBxe2kUO4mdbi0oNMesk67beiCMXeYLl7ItI12OtosM=;
 b=fwtNnlZFprIRsqM2KXeU7km1qIChH3mF/RrWbU1EK7zmb9dEcGnQ/6rG4ZnOOkHp3jjAMVvM33urj739lmvrBZDTGQJlEnrGEjdC6bc3bZ08kz+8aZOhmCx7Rrm5c99XNqZj+AjAm7i7yYR6aZuLMeDx5Yff/cuDgoSdtHs47s2MWQM+oIvazkWVgMX0d35ItFrW1aQcJQYvSIvW2Oit+Xs9sN40TWbvB4AfslVeDpDwvdQGDa9MyaUaK9PmP9FCXEK1WVRnvIZPwgnTSkIUBahvbQaTnHGjIKck+gFQVb9gAOag/HLO8qGwvsdMbdouNIB0BUnfDy+3fcUdkrfZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBxe2kUO4mdbi0oNMesk67beiCMXeYLl7ItI12OtosM=;
 b=AK4mCxLn0crTudDccOXQAXaoWXBzVvh+AVePBu/jau7gQLpgq5LLgFumvmV9rAXUMbbOA5iDyna/S2IbU9UgHev1TJXDKQclExHnLmzRMJXHDBLqpV9VHLJ2fhplkVdxZwToiDtBQW5jHEe8ydfzEn6pVZNeeX2KOEnfw3zm5XQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB8950.namprd04.prod.outlook.com (2603:10b6:610:1a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.24; Thu, 14 Sep
 2023 09:45:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 09:45:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 05/11] btrfs: lookup physical address from stripe
 extent
Thread-Topic: [PATCH v8 05/11] btrfs: lookup physical address from stripe
 extent
Thread-Index: AQHZ5K7X+NaiivOY50OfPFaw/W1JyLAaD2yAgAAHegA=
Date:   Thu, 14 Sep 2023 09:45:02 +0000
Message-ID: <4d77c2b4-c4f6-4f51-b578-9e38730b11fc@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-5-647676fa852c@wdc.com>
 <6de87230-f981-411c-b173-55871e4d4720@gmx.com>
In-Reply-To: <6de87230-f981-411c-b173-55871e4d4720@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB8950:EE_
x-ms-office365-filtering-correlation-id: bb7e7fb9-0149-419f-b683-08dbb50744d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkIgNLxidqI7ZHdtYTMB9cM4kuonFq2LuVP7b/QpAT9iEgwkvdMgcNllsNWn3Cxr0VQ79LbmWTY9BDhqOlb3MeQs30Ocm7HTB4ekMQ5p7FN8zNfHtr7q2pUpdRKLGgXzWM5EvBcIMXbaxheHcCiGKidA4miSi1vZkqhzkL1zr5uGcaKi+5PslHpiyk80mu8c6GhgVllYHIB2tquMY4CPPjMIRsI3utdq05W8+51xlFhG9AfTusVgifNPCQoIh1qg1jqCU5/uir66vl/y9xYCK0+OdJQ6kpbEOXjfVA4wjfgYABz0ub2R0Qs+/7shdeJ47yLViZAFQvtgDtjLqYiCYB0/y7jZKB0ePJaHGFZ4UMreTHxDPWL3aN4fNAeyBvNednl5/JuWobgTtKt2VmLRv+P/I5qLR+mLaX0dL93QwGe8gT1vPJyIr4K5lotQabkJ96/hppE8u2JgvMHd8EJBmMamtsIX/V3flgFdEkftmyavcnS+nnZw6E4oGJj4gsGHP2wFvi4wEtciqm8GGchhpaqUZR2Ou3fL5cA4Uf8/iq3IsTZjx/lOAvxIh7+JBMpDiE8f5hZjJcRL9jQy/+0Sspj+N3kp/HfbfSfXI1hu8xJV5W5PzOfbGviT1O7Vh48Iqhl6pOKSiAbDrnDDB/WqxRUggqHBEPinkd8t13Jo3cOEhyOHudIKW03N0IqIRDw4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199024)(186009)(1800799009)(41300700001)(316002)(66946007)(26005)(31686004)(8936002)(91956017)(4326008)(66556008)(76116006)(2906002)(8676002)(64756008)(110136005)(66476007)(66446008)(5660300002)(478600001)(54906003)(53546011)(6486002)(6506007)(6512007)(36756003)(2616005)(38100700002)(71200400001)(83380400001)(82960400001)(31696002)(122000001)(86362001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVpZSVdNOGN0dTFsL25uY01rU1c5M3hyRGtDSHYxTE0ySW1NZDhiQ3dVV2FW?=
 =?utf-8?B?T1RNNEQ5WEJ0RDk4SWVwekV6UWg1My9xM05EKy95blE5dmxrTU0vR2JLRHJZ?=
 =?utf-8?B?a3M0SUpEVXB2Y2ErYWZDTXo0RnYwZGVjR1h5b2EyaFlSZWxRV1UxZ2ppZG9p?=
 =?utf-8?B?eFdVKzJlYmNaMmVGTnRWVk40WXJtWjJCYWljbGZYeG90R1V3cE1uWWtQcXQz?=
 =?utf-8?B?S0tKbHpmUElCeGY5Yi9BZ2JhUW8zZVVYanJGaGNuR2Z3T09rR2lUV21FU2RV?=
 =?utf-8?B?Q1U1RGcycUhCN0V3cU9GeTVHM1Y5ZFRwOW4wZUI0ODNZMHhkOXVpaW1USlR0?=
 =?utf-8?B?UWJoT1VGTFFHaFViQzRvRWo1YTZiWTV3UnJ4T0w4V2l4MEhFT0dya01tR29V?=
 =?utf-8?B?M0RNUUszaXJxZzI5dU9yanc2dVlkT29jSENUTXI4dkFsd2tGQ3NjQWIxdG1P?=
 =?utf-8?B?cEtMVmQ2Q1Y1ckJScGM2S3QzOHU3cERaRjlxYzgzMUtuR216Z0NmVVd3T05P?=
 =?utf-8?B?bVhycFAvb1hZd2ZXWkVOMjBlMHdyTHFCTEVUT1RLWmc3Mm5wRGoxV01QbDkw?=
 =?utf-8?B?cW8veUVBdmEzNTRKOG1BK2tnYXZ6MDBvTmU3K3M2VzlrYVVKQWJqNWE2cGFQ?=
 =?utf-8?B?QzF0aXRtTEpMeG16SUgxSi92MW9sRmlNdVBqdDFlcUtGWi9xSksxN25JTGkr?=
 =?utf-8?B?Vk5rUW9xVC9LL096eWVqNWFnamxOdEoxTjNVbnJoaDYwS2pvY0lBanUxbTMv?=
 =?utf-8?B?d2FiaEFoM3VOTW8ySWMwdlVkeW96VElQRXhsZHJMMnVjMUVhQkkxajdDdVNR?=
 =?utf-8?B?WHI0c3ZuYlFwdHBuL2gwVlhxVldqOXJYcjhzYVBORXZQSjBMN0pEWXJsRFJi?=
 =?utf-8?B?WnNKUWJxQVpBWVhUMEZxSjk3a0JDN3lCUmxNTnJwVnBTV1lrdVpubjJMMFF0?=
 =?utf-8?B?WmN0SkdWMUtvM3lQRXZLMk13Y3dGVk1HTGp0UlEvWG9TVlhuejRVcDVqRGhP?=
 =?utf-8?B?elZPRWx4YW9UWFpVS2dJSnRvSi9VUTR0dzNJanFhcHEwdHRmSmR0b3h3ZWt0?=
 =?utf-8?B?cVoydkpYeXVvK1VRMzJYRDFJSkxENFl2eHQycnViOHFSZW05MFFxSExFY1VX?=
 =?utf-8?B?dmVTR2xEbU1FZ0NBMnU3ZFJHUmduNjVTcUN4V3VvUUJxWG53Z3NFUEhIQ2Nx?=
 =?utf-8?B?aGdsZkdtWERjY0N6SmJUS1h3dEJlMHBNblA0a25LQkJaajRvU2Q4RGFEaDl6?=
 =?utf-8?B?VHlrYXJpWDJoaFJoVnFuOUk0Z3ZJODRVMXNwNVVXM3VzYTEyVWxSM0ZOMyta?=
 =?utf-8?B?QUZ6NU9vamxwZHFvUnBpQ29ZeFVjczJ5N1RBM3dtUnRpelNURnRTbmlnSkFK?=
 =?utf-8?B?KzdGbzVXbHd4bXpPeHZkUVhBTE1kTjlVcytEMWRaYzVQSzk2ejVKVHpXWnc3?=
 =?utf-8?B?eXhIQ1Y5LzB1TzZDSUZTcGpsdFJBeGJ2MDFYeXI4VVM4VVJPZTFnc005U2tG?=
 =?utf-8?B?LzRKVzBkZ1JTZ0YvRWMrZGIzaTB1eEVtUU5GV3NWMWxlV2VxWGxDOWVsbjR0?=
 =?utf-8?B?VHA1V29OY1llWldlWUpGa09hRTRWSXJUeEwzeUxEMUhTdTZpb3NHVEVtTldN?=
 =?utf-8?B?bmpCQnJab0s1U0cwMzRSMUtheUg2SVdya3FPcUV3dTVUS1FNRTJZYnJQU0du?=
 =?utf-8?B?UDQrd2p3MVFDZHJwVHp5ZkZuNjl4dTk3OUFoNms3OWJSbzJWVXRHS0RzN3p5?=
 =?utf-8?B?Rk9WWHF1V0FLSTRQWDJwdEc2UVI3R25TSEhVZDZHQzdycTVGS0VIWmdXWnJM?=
 =?utf-8?B?czRja2hqd1U5ZTJ2QkFtaGx3R1pDQ3VqVWExWDdvZUJGWmVLdzBLdjk2TlhY?=
 =?utf-8?B?U1hJTFpnc3BXaUZkd016UWc4VXRyZUVjZDMzR0lqSS9GOTR6c0lxdVREQjRP?=
 =?utf-8?B?Yks0OUkwVDFjUGtLN2ppV2k3QmtpQlVuNXlFZXN4NzhMbXZzSFBqM0w2MTRB?=
 =?utf-8?B?V1hkOEQvWm43bnRYV090L3ZnOTlTaEkyellnenBwMU1MbmZEWVA0ZU1kQVE3?=
 =?utf-8?B?R3hxR3pPMmQxN0R0c21LQmpGbjEzSzA1T0NQeVRTbVREcU9walVzWUN0OElj?=
 =?utf-8?B?cDQ2d0cveE1qTHBmaDZYWW5ncHVKamdzaUp1Rnp3aTVYK0lETmFjd0tMSmJO?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23B01DA15F770C48B8AFA9943EA17492@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aXB0aHJMNW9meGpZUnVYcFlBbGZWMVI1alI1U1B6U0NSM2lwbzd1eGtkN0Ew?=
 =?utf-8?B?dzF0SWZMUnlCUDJCeUJhbS9zb1h6cFNsU2ZRbHBHSHp5WkRQbHlkbitWZXMz?=
 =?utf-8?B?VUR3M3Y3K1cvS0dSenk4TlYzYzYrY0JwOWduTHhJSHpwa2Z4d2tGamxDN3g0?=
 =?utf-8?B?TmhJVGxlVFlSWnNuMENwOUtrL2FTdVdIaGl4b0txSDNxSUw2WTFkMytHbTNj?=
 =?utf-8?B?NWNoSGpJRVpJL0hnYmxtaDVoc3NucDJ1N1NaL2RBeitLYmY5RXJ2NnMxUmJC?=
 =?utf-8?B?N3RpVTRQb3VlRUlEVi9RelBBK3ZFTEJXbmNUREo1YzlyWDRQWDJndUg5U2gz?=
 =?utf-8?B?bnJiZGw5NEFCOEhaVjdZU1dPcnlLdUVIMzVtZDJJbGY5VXpSQzB3WCtKVlN2?=
 =?utf-8?B?RGpaRjl3QnZaYzg2NFNiWmF2M3ZrLzRPTWhPcWZkRVJsZGlCcGxpWFc1Ym9O?=
 =?utf-8?B?aGtVTy9Ca0g1SXJOUDFBVzFrUS82T1pjUDJiWVM0ZFZPbk1XM2dwTno4a1Fk?=
 =?utf-8?B?c3hYbk0zSkZubG4zaS85eC8yK1IwOUowbFdyMVdhTllZenBpenpQMUFVdXBZ?=
 =?utf-8?B?N2p6VTZNVit1cElsTE5uMUI4ejNReUNEVnFhenpGeHJzVU9QRkpsUmEwYkVD?=
 =?utf-8?B?MXUvc1VTbGlIWEFlV2FXTGF5SmZmN2N5ZlBuMWF3S0U2aGNmT25SN1IrVzh4?=
 =?utf-8?B?TFcxOVdpZGNuQ2VKcDlqbDBpQ0ZrMk55V3FoM3VjYStHS0NQQjIwQ0Uxa0Iw?=
 =?utf-8?B?VXI5WXFNemcxTUZHZzc5VUYzcElFcWFUMHF5MERKbDhpa3VORDFSbzd6aUEz?=
 =?utf-8?B?QjdHVHJLNWtldmg4V1dmTG53TEZsdXZ4TUM3Z0pWK2xwKzI3MndZa09CdXVX?=
 =?utf-8?B?TFExeVV6S05ZOUFVUVoyL2c5aGJVaUVLbllxVy9LZVA4U2RmN0RJWXEyZlZH?=
 =?utf-8?B?UlJUc0QzaGFwM1hIUWRrYUN4MHJjdmllZzFEK2p1a1V1M25IcmYwejBCQm9Q?=
 =?utf-8?B?VmZQU2hIbDFvYkF0ellqdnZySXNxTHIwUzJTSk16QVJLU2M5aGVwMTJKZ3po?=
 =?utf-8?B?YlgxTGYzekNUcEtUTDNsbTlDRWFXWXN5U0hmMHJyaHFrNnJPS09NTUlUSXNB?=
 =?utf-8?B?eVRjZzBQbjZ3S3AvNDBwTUZOOWFoNlhweGJHYzVEL3g2WWhZbHBtR3p4dGlO?=
 =?utf-8?B?aWd1cTFwUnhOM1ZMdm1qK2tRL2ZGVGlsTm0rMS9KbEdubVlQNktaYmJnVVhZ?=
 =?utf-8?Q?W7ZO2oRbRYm1mZ3?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7e7fb9-0149-419f-b683-08dbb50744d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:45:02.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7gKHXDB/HYTKQiU0XRwTcz12NBsMBs881wzID/7pkcty2z7JiQ0kyIUvkFsoOguS8re2w/lYviiatDCWSv1jfifSWqO0mK3YpgnblE7zmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8950
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDkuMjMgMTE6MTgsIFF1IFdlbnJ1byB3cm90ZToNCj4+ICsJaWYgKHJldCkgew0KPj4g
KwkJaWYgKHBhdGgtPnNsb3RzWzBdICE9IDApDQo+PiArCQkJcGF0aC0+c2xvdHNbMF0tLTsNCj4g
DQo+IElJUkMgd2UgaGF2ZSBidHJmc19wcmV2aW91c19pdGVtKCkgdG8gZG8gdGhlIGZvcndhcmQg
c2VhcmNoLg0KPiANCj4+ICsJfQ0KPj4gKw0KPj4gKwllbmQgPSBsb2dpY2FsICsgKmxlbmd0aDsN
Cj4gDQo+IElNSE8gd2UgY2FuIG1ha2UgaXQgY29uc3QgYW5kIGluaXRpYWxpemUgaXQgYXQgdGhl
IGRlZmluaXRpb24gcGFydC4NCg0KUmlnaHQuDQoNCj4+ICsNCj4+ICsJd2hpbGUgKDEpIHsNCj4g
DQo+IEhlcmUgd2Ugb25seSBjYW4gaGl0IGF0IG1vc3Qgb25lIFJTVCBpdGVtLCB0aHVzIEknZCBy
ZWNvbW1lbmQgdG8gcmVtb3ZlDQo+IHRoZSB3aGlsZSgpLg0KPiANCj4gQWx0aG91Z2ggdGhpcyB3
b3VsZCBtZWFuIHdlIHdpbGwgbmVlZCBhIGlmICgpIHRvIGhhbmRsZSAocmV0ID4gMCkgY2FzZSwN
Cj4gYnV0IGl0IG1heSBzdGlsbCBiZSBhIGxpdHRsZSBlYXNpZXIgdG8gcmVhZCB0aGFuIGEgbG9v
cC4NCj4gDQo+IFlvdSBtYXkgd2FudCB0byByZWZlciB0byBidHJmc19sb29rdXBfY3N1bSgpIGZv
ciB0aGUgbm9uLWxvb3ANCj4gaW1wbGVtZW50YXRpb24uDQoNClN1cmUgSSdsbCBsb29rIGludG8g
aXQuDQoNCj4+ICsNCj4+ICsJaWYgKGVuY29kaW5nICE9IGJ0cmZzX2JnX3R5cGVfdG9fcmFpZF9l
bmNvZGluZyhtYXBfdHlwZSkpIHsNCj4+ICsJCXJldCA9IC1FTk9FTlQ7DQo+PiArCQlnb3RvIG91
dDsNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIHZlcnkgd2VpcmQgc2l0dWF0aW9uLCB3ZSBoYXZl
IGEgYmcgd2l0aCBhIGRpZmZlcmVudCB0eXBlLg0KPiBTaG91bGQgd2UgZG8gc29tZSB3YXJuaW5n
IG9yIGlzIHRoZXJlIHNvbWUgdmFsaWQgc2l0dWF0aW9uIGZvciB0aGlzPw0KPiANCg0KWWVwIGFu
ZCBwcm9iYWJseSByZXR1cm4gLUVVQ0xFQU4gYW5kIHNldCB0aGUgRlMgdG8gci9vLg0KDQo+PiAr
b3V0Og0KPj4gKwlpZiAocmV0ID4gMCkNCj4+ICsJCXJldCA9IC1FTk9FTlQ7DQo+PiArCWlmIChy
ZXQgJiYgcmV0ICE9IC1FSU8pIHsNCj4+ICsJCS8qDQo+PiArCQkgKiBDaGVjayBpZiB0aGUgcmFu
Z2Ugd2UncmUgbG9va2luZyBmb3IgaXMgYWN0dWFsbHkgYmFja2VkIGJ5DQo+PiArCQkgKiBhbiBl
eHRlbnQuIFRoaXMgY2FuIGhhcHBlbiwgZS5nLiB3aGVuIHNjcnViIGlzIHJ1bm5pbmcgb24gYQ0K
Pj4gKwkJICogYmxvY2stZ3JvdXAgYW5kIHRoZSBleHRlbnQgaXQgaXMgdHJ5aW5nIHRvIHNjcnVi
IGdldCdzDQo+PiArCQkgKiBkZWxldGVkIGluIHRoZSBtZWFudGltZS4gQWx0aG91Z2ggc2NydWIg
aXMgc2V0dGluZyB0aGUNCj4+ICsJCSAqIGJsb2NrLWdyb3VwIHRvIHJlYWQtb25seSwgZGVsZXRp
b24gb2YgZXh0ZW50cyBhcmUgc3RpbGwNCj4+ICsJCSAqIGFsbG93ZWQuIElmIHRoZSBleHRlbnQg
aXMgZ29uZSwgc2ltcGx5IHJldHVybiBFTk9FTlQgYW5kIGJlDQo+PiArCQkgKiBnb29kLg0KPj4g
KwkJICovDQo+IA0KPiBBcyBtZW50aW9uZWQgaW4gdGhlIG5leHQgcGF0Y2ggKHNvcnJ5IGZvciB0
aGUgcmV2ZXJzZWQgb3JkZXIpLCB0aGlzDQo+IHNob3VsZCBiZSBoYW5kbGVkIGluIGEgZGlmZmVy
ZW50IHdheSAoYnkgb25seSBzZWFyY2hpbmcgY29tbWl0IHJvb3QgZm9yDQo+IHNjcnViIHVzYWdl
KS4NCg0KWWVwIEkgYWxyZWFkeSBoYXZlIGEgcHJvdG90eXBlIGZvciB0aGF0LCBidXQgaXQgbmVl
ZHMgbW9yZSB0ZXN0aW5nLg0KDQo+Pg0KPj4gLXN0YXRpYyB2b2lkIHNldF9pb19zdHJpcGUoc3Ry
dWN0IGJ0cmZzX2lvX3N0cmlwZSAqZHN0LCBjb25zdCBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFwLA0K
Pj4gLQkJCSAgdTMyIHN0cmlwZV9pbmRleCwgdTY0IHN0cmlwZV9vZmZzZXQsIHUzMiBzdHJpcGVf
bnIpDQo+PiArc3RhdGljIGludCBzZXRfaW9fc3RyaXBlKHN0cnVjdCBidHJmc19mc19pbmZvICpm
c19pbmZvLCBlbnVtIGJ0cmZzX21hcF9vcCBvcCwNCj4+ICsJCSAgICAgIHU2NCBsb2dpY2FsLCB1
NjQgKmxlbmd0aCwgc3RydWN0IGJ0cmZzX2lvX3N0cmlwZSAqZHN0LA0KPj4gKwkJICAgICAgc3Ry
dWN0IG1hcF9sb29rdXAgKm1hcCwgdTMyIHN0cmlwZV9pbmRleCwNCj4+ICsJCSAgICAgIHU2NCBz
dHJpcGVfb2Zmc2V0LCB1NjQgc3RyaXBlX25yKQ0KPiBEbyB3ZSBuZWVkIEBsZW5ndGggdG8gYmUg
YSBwb2ludGVyPw0KPiBJSVJDIHdlIGNhbiByZXR1cm4gdGhlIG51bWJlciBvZiBieXRlcyB3ZSBt
YXBwZWQsIG9yIDwwIGZvciBlcnJvcnMuDQo+IFRodXMgYXQgbGVhc3QgQGxlbmd0aCBkb2Vzbid0
IG5lZWQgdG8gYmUgYSBwb2ludGVyLg0KDQpHb29kIHBvaW50LCBJJ2xsIHVwZGF0ZS4NCg0K
