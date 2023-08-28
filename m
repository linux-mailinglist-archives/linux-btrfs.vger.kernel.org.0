Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81778AE4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjH1K7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjH1K7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 06:59:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AFFC
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220358; x=1724756358;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=I5cqSdCvDKjjKllK8KGWEa2KMxSHcL8/sQkj1FCyIYU+/S2rtjnpgusG
   zmMH75+ta69qMgCEH4eSy1nabVDwCdnIBBTiYojk7fdaZWYBAWLPHBnvL
   zgr5yV5cBvPl7tbt93C2Hdhm+1uuungaMsLfA3J7Tl1q9+ZuOoWxSM6Mo
   /ssDT7ovbtwEjxmlC0lnIZViX3/X4tXo5DcYfdc+WQnEzahN29kYFP8yV
   AIQaAWpSWyNj7jOMb9hoQ2Zuhf/gn91285EprvQX6qxsbWMhJAZS7GUrx
   acRXzyj9ljo2B74PJct6BufHFgi5yQiNCzeQJ1k8rVoVvZQtLszxhl3dk
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="347561424"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 18:59:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng87KuhWyfOyybZUwhXvTyG6tphCdcqZcjKCixLWDPYiWyIAmT2AYvKn3EZgMLzumrBTsRzGLYsGkOe+uF2Hf2m5nA2XCKoLHXKbXnYRLS6oZTRWq8Xs2bYNhWdUZ//4LsyVBX5B8mwBC+1dgxyWvyu6oxH3s4izMr0Ko+fusg6h1bhX/qxVvsXdcAM48v+7WRVqyWQN/Aq+FefoFE5bgW4FqYfp+U/uRvJsGhbxOtk35ocYF7BvvYkzfZIT4ix2YG8LdmNNaTdlAdYqs8wRBDi6oZOQAjiqm/05KBAN0bWVBHiGNBKDZkJR6BBmHCe+vsUkvZ2okkiteYF7yErgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Mhm1zxSjt16iqs+crb2R5etmCwm3Pwksxp6zWImobvCdds0NW4eL5MVA+qcbZ7ijs3lLymTzr5ubxqI0gGqjudLE/IRBkLsedVyiKBp1D4QccU+AjPqu3EhMThGkqUvs9aOj0LPt5hQfGvY+f0DrQKuizGgronPooOk/xWJR4IXNhJo0N1hAbEtL/oaDQOz8Q/rOgLt4nRbD3o2n6/7ljyWufonHgwrAzikdWXROUbKZDPef2K/FFKcantzAyvUV6ujF0kj21DCScPYX3Zcbo7wGyLLIikCGHJXRanfBjfKuY9TqXHEkazgmYpv4rp8FikXE6BrCCb2mW8qySJ6MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=p+NW6MzXYP2HfJn+g/XFNNMlaBfxf1/yHstKOlmFJ74VWcu4D82tUxxW/JsP6GQEd99UaBwyXC7QDeyjA6EJsDsRirDH7DzPvdYVOAt/pzrfS0PZzA11J0D3/kedXstfmkcc9Bx51UyGFs0ZSlnweSEtOkZDXQlUa741s4DHnuI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6649.namprd04.prod.outlook.com (2603:10b6:5:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Mon, 28 Aug
 2023 10:59:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 10:59:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/11] btrfs: move btrfs_extref_hash into inode-item.h
Thread-Topic: [PATCH 03/11] btrfs: move btrfs_extref_hash into inode-item.h
Thread-Index: AQHZ1cj99CfFmyXYbUidAqks6zFkm6//kcsA
Date:   Mon, 28 Aug 2023 10:59:15 +0000
Message-ID: <6fdb06d5-a9eb-4d5d-ab57-17af55f22e35@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6649:EE_
x-ms-office365-filtering-correlation-id: 453926e9-4336-43d0-c5c4-08dba7b5d1cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/8u8YSZ6zaz592OXYCUAJFrxCgr2ZRRfXfe2s1tYfAoyP/hT2VAtvnTq06Zx236gSUOJ5KIujOuzANzm+d2oF54kf+770MjkH1LJ+saMgolCvjG5OOrjchb6OuQCcF0fm7eo/YEEt5xpWQEQMOKFJONFd4rXsqChywcEAwlT3/0Tq8pPA8YgMTWnwhqgvF/UoMsBKaAJodaFBviRA54oUeGmI1z+GvgkcH+M/AwKuXwFpaedCnmrSadWHKw1y1hXhVHm0HWV7T+9j+Iz5hXyeqy1nA0I3/gEPRMkgaqWlWOpYpG3m98Iz+yCthIZ6QcWROuX6lWTX/D4Mbxqzm/jZSJvnfRg94uo/b9GFBrf0e8XFPaVtXmqetwRs5wo+A17Ufk0Xs+EyRFUKX7xNn//T5djkKg1OSWuqxgW+ARwpWQP0J+k71/mRnTq6rFBZNDW+CBXEgnSvfr7Q/b8J0nBKUKsTy0W1gGUFmLq3KCH5931oiCcQwqqt0EKDAJrzVOihpQJLNLR6AvGNiDCvImYG7YpPnDj48oyhBAY5DRDGLhHpo/spx3nW5rIDPz3/JizctoXivEs0XXtJi9Y7WAcvPKPzhu02xYviPE+5hz/nRir3L5mtZq9UrD6jza4Y60GpRbrEld7FUvlSSKr5gEJxugWxCUYtySlx3+Qfw67ex++tX55MeN2T7Na2SpM/U0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(6486002)(86362001)(19618925003)(31696002)(26005)(36756003)(2616005)(4270600006)(6512007)(558084003)(38070700005)(316002)(5660300002)(110136005)(76116006)(91956017)(66946007)(66556008)(38100700002)(64756008)(66446008)(66476007)(41300700001)(31686004)(2906002)(122000001)(82960400001)(478600001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3U0YTgxT2FpZzR1WER1UVozY21TRklMVWVUTkZzU2RvZnErVkNFYzZUcFhC?=
 =?utf-8?B?cDZrdFVyK3FoZ2FsZmdCNGhBekhWQzRoTTgveCtDeEhzSmpmMk5vWG1JemE0?=
 =?utf-8?B?MXFFSzMrcU55ajE4ZUkvR3grRGlpUzdZSnFBMFFta1MzeVVlb3hTSlBmNTVR?=
 =?utf-8?B?SGRrL3doS2EyVEh6RUk4cmVXWTVpUHhpNjJOOXF6aXIwUHpUOWNzR1FwR0N4?=
 =?utf-8?B?VTNIOFcrUVZha2FxVnlubGlMYTJlUmFTUXBKL1k3NTBydVVUWTNZMWFWWFRB?=
 =?utf-8?B?R2FTK0ZmM2tyV1Ruc1hZUllPTDVTdzlZVVFvWUc4aEU2bVdnc1RsTWdOYzdl?=
 =?utf-8?B?cDJlWjFvVmlERGc3eUwrczdDd2lDTEQ5UEJ0aWZwYTFNbkZHUmZUM2dyanM2?=
 =?utf-8?B?d0lnWnhGa3VTTFZjV2hDWFo5YWFjSWtFR1RrV25EM0JKZVdnWUNGZnM0YmZ5?=
 =?utf-8?B?N1pWeGFtTC94Z1UzZE9uWDFSd3I2cjBLc2FqQS9tSWVvRUJFQ0ROc29RTUlS?=
 =?utf-8?B?WDQxUzM4Q1drK050VXc0b0lVTzh4YlpYVHEzVmkvanpZZlBBNEhCVUFjM3lk?=
 =?utf-8?B?YkFQcWpTTmpaSEZlaHM4eVhtV2JSVmg0SjBNcmpzSXNWQm5SQXhYWmgrK1Nv?=
 =?utf-8?B?YUtrNFFZaUNpNmhERzRSWjh3Z1M4aXNFVldydk1LL21EaWRBOVcrZm5kQ3ZO?=
 =?utf-8?B?SkxvS2xuVE1KaXVIQkNTK1VtMUtmTW55andTbjZpNkRxQzVKQllGelFOVDlm?=
 =?utf-8?B?YzJDZ1A1aTRFcjBLSkxmNm5oU29DbmpnNjJSZ0hIMENmNFQ4K1hVT3BvZHRJ?=
 =?utf-8?B?bnREalFSb3hYSjhkWFhNOVhYUlAvWlRiOTZ3TlhEZG1GSnFMSWM2Qy9JalJ4?=
 =?utf-8?B?eGk4OVBNQnF1VUt3dFdXMnNQVjREb3d3NGs1S1dHWVJOanpoTktHR2ZhdzIv?=
 =?utf-8?B?bEpTVFEycFhPb1ZIcmZ3aDh6blU1REU1TFZhbm9mYlRZRW95MjRCbk1INVh5?=
 =?utf-8?B?MnFDcmRHSUNEZ1JIaUxiNDBlK3hwZFFnVkh6Z2Jkc1Rkbld3OHBOTmZuKzU1?=
 =?utf-8?B?Y3RFVm5rdjBtZ1A1ZjRYOWxsUUdDSjFXM3RETXFhb1FFVFJBVGVMRDFIMFlR?=
 =?utf-8?B?Vi9yQ3c4TEVacVJ2bHgwUmZCQTN5WUdFaVJwTG15cVlYMkxoWlc1Z3hqTzlV?=
 =?utf-8?B?b2xNbXYxcjRyak82Q3hhV2NnSzdPTi9rbnBLS0l6UW5nbzg1Y1p2ZjUyazA2?=
 =?utf-8?B?Q3lEbnVsY09LZWpuUHdjbWZXT2RwNkJOYUl4eGJVVUpiNkRqT0dzbTNlOEpK?=
 =?utf-8?B?enNOM0ZqcXdrTE1ZVFR6U0ZVcmtnanA4d2NXSlM3WGhsOW5FVnA4OWpMdEVo?=
 =?utf-8?B?L0Mzc21hTGNDZzlKVkpwQTduYi93aUkvTUIwVVBBZ0NoYjRSQkorK1NqbGI3?=
 =?utf-8?B?SDFFRE0zczdheUFGZUVaWGJHeHdtNEhLak05RFBwLzlOa0JJdVVSWEZNUTBs?=
 =?utf-8?B?dDE3QStnRkJuMmRQYklWRzl1Q0JYUktDeVFvQXI5bVlacWx4WEJPeHVTa20y?=
 =?utf-8?B?WVhiWFd1Y2dHcVowTmZYbTJuZEtZOHMvRTZtSUYvTGVJM2lwUjhWTWRjMmJt?=
 =?utf-8?B?a1JqRmU2LzZDVVd2MXJTcFJ5bmh3MkdFZXJsQ2ZTTXcrbXlTd1lNTkZwNmMw?=
 =?utf-8?B?YWVGVzdEdDJzaTJheHBhNEI2MmZ6ZWhHYS9TejZ3UWZFYUlKZ3lYU251dFZK?=
 =?utf-8?B?VW9NVVdxQ1Z4ekt0a3V2ekJQeXkwS0FhZkE3KzBPNEZXU0haS1ovVVU2RFZW?=
 =?utf-8?B?YjB6NzRZaStKZE00VGpaWVo3dEsvSlhMSHpyS0wxWGNpMDdEMDdncXJic1lG?=
 =?utf-8?B?Zks3aHFqaGpwNkFGMjJMQWFKZEhFRHZ6YWthOEZFOWU4Q2Zjand2TFc2NFNl?=
 =?utf-8?B?K2R0MnVqdmd3bE4wN2JsZmc3MVlSRThVQ3gyZTllYk5BNkxqMHg2SkFIK1Vw?=
 =?utf-8?B?ZGZubWM4QitvQ3dLYmJJa285dEZ2ZVZhbTgyUVoyV1p4K1UydG1WYllTRjZW?=
 =?utf-8?B?VWVaUFVhSFZCQzN2SjdvVDlyQldHS1NRc1RtTGxiWGFTbEt4OWRQUSt1Rkxk?=
 =?utf-8?B?SEd4dmUxbTc1RTIwczRWUzZIa0lNaERmc1JMbE1KRitzNGZMakZxcUx5YmRN?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7B0329B55B1E41B6F721E0DC14D5F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TLOwV3W+HdzOwWZt3je6um+yeai3WsjSGpi9yFjQRP4SPVMgGh62OT0LgdNq5vRFgzob+cybaixiOSvUNOGS35slMUKxFO1C0P4reJS5M6jkyOzVrep0yw1AEIhQMvX48YHB+2NGFsaF2Itf8a+lX783tQFrGUfhjOxOJRPXgYYgJnhm2BWVEWWj/2+tXsz/uERxX+0txSey3sdkOx1bjnon46fDcp9ZINn1dVab98kgkz5aAXqxMgbILC3PEp7Rbo4D7S+W757yr8JGshat83UjJaeLj4wgVtBJ/SBspbAv3gQwM0DLsicrQpY/jXrRVASRj3UIjyQDSeTJ+NPbuES3bKMSbJ28IlVWVkADS3v92TRPvkyfejfG6ynF+hUB4PnBevH6OvdHnvyONx213vWIDcr/rqbOvxgQUJ8Q1Vy2djjuYo56dv5K2ujwrsuCkKK+jM0d5hsYf0gUffRCrGAbNn881f+bqCET1s6701Jt6Estj34kz5iTHEd3rmmp2YMT7oxFspPFyvlQUtAE01RybkxpecowZ9gRdc70zSLaqbL3H2X8Zd7OotTowV9nKccASzAYS2ruXBVbTT+wYaZ79cNsSM7yWTBPuzhfJsHNcu0LZPYSxMtMG/7A1nFrNWsCr1NXJ+AD4k6csqtEgBDtwHW6dC840pP4UE7SM6uWrii3fS1IwUNSajRLMiDuotWvdvufMe3enzZG5+I75ePNGavd4/jAM8JeN7BpZ4k9NklO7XTNXN04w2k9BVCGL0uTgg6Czbzf/xSb1ShkCpVcKqWWanM8G1m1K7vX6ZGlBeLkbIKaxHCIRWLWm4vyPIbPwBkiGnytwrG1QnTQ/w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453926e9-4336-43d0-c5c4-08dba7b5d1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 10:59:15.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPF5t5bl8+uTiv9UbUvo83HUBbzfCpgAk0RpfGC+l/1HzswF+fTThNIBKuZ8SL2Jyyfkhe5yzwvnlmu40VsGlBxz1o/cYLDIOJOw1mwdGwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6649
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
