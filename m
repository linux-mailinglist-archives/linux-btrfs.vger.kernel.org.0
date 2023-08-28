Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09078AE6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjH1LE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjH1LEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:04:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDBEAB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220678; x=1724756678;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=dUXMylP6FVdQStecgzVCveYHq15qorXAIdC31WW81bBNs33R361RIGzt
   lv4xeh9qzoHqozRY4uCP/n2KnOeijQtt+sWscVnhrDUef6QzNcC2O1iQ5
   plll1bOTztFIt7kmQ6DbWvtc2iz4IntwTyhUxgRx2t2gRH3ZIzQUHfmR8
   OEiT2bD2a1AowY7miuM3b6dU46eDFcf5M71131YUsVy1tSe0fP9NF2BHb
   4eaRbcGfgMd/bbsbtzM27wrkOe3Zwez7XPbBHcN4UrpJIpV8vzzTFCnIp
   jc2QK7Mf+QK5dqwyKmVo03XieDEejAgG+IzoulgIcHXE3I09TGjrZjlcz
   w==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="354348317"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hscxsCjHQB9ao63O8QxsLbZ8MB0VVmD0BErtM03tl5oACXqQuH8wgse2IGeYNPfaxX1MI6fGFaRUT5H7vgmIeLGqhlv5UgucHuHBTdIIO9dleKMP4TnEof5r3xPvS6YzCIKsajZLNU3r55kCD7Yl7Khz+gA5P/Nj0GOwEZFNu0w+IZVZkuub6RGoEcDrJ+kABp5ugw+pq3z4zDRMxuF+5iJbMnRNSU8qGOMEMkRJOowvcEY9Q6vosN3dWiPNxLWWCSnmk5LN0adkyAwZScqCi1NrbtnCg7m+kEAENPw3qoeOLw6DbuHLqFAYPU7rVebtEMUB+kSXmYzK5DO+MYtknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=ek87fb1Sn3kRnl4Wad0pj4zE8CL/zhiLewX1ahqskGN8oKZDx9TQVo8NvyGd8Kifkuv7Y9VpuHjvHxRvPr2jXAQ4eiRloqg1595BoBju2rK/JLdNAONBU7GHrql0cGOLrgcXOExH7JKeK2MP40Pw1IihBg8B1oFTirOSNueUNyztIG5FNFtiCzAeb18hgOtToJMFm4Qmr+wpRsI1p7SS/PahZO+PU/SwcFXv5j4/T+jADsmC60EvkIcvPMNGFAmsaiZ0dVjeOMdNt3PgOdio19/AwHLMp9MoZtaUfNAD8RykWoRkjy9g1NNNaCYp6hXdYARWKlJotlIpStNa6TtB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=RhNsNZUzIg4ob9K256FUCXa119apbD2Q6/vThEfn1fXsUMdjyUS/AGaxzv4HRu1DTKxS1uZ08AxUwoLFDTFmmC5zsGKzchMaUa1UP/wfRGSdTpMtqfzzx8tfHTjL+SLHPNKUc52N3TxYO2Jm8EXa59EUDvpEWh0jgvv2ivZ7YKA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 11:04:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:04:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/11] btrfs: include asm/unaligned.h in accessors.h
Thread-Topic: [PATCH 05/11] btrfs: include asm/unaligned.h in accessors.h
Thread-Index: AQHZ1cj+lh442Roh50Gl2oQaPR2nI6//kzGA
Date:   Mon, 28 Aug 2023 11:04:15 +0000
Message-ID: <43aba072-5c02-463b-8c20-779ece7cea8f@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <d579bc35b31a0be928af6c358057c8aaa814ea79.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <d579bc35b31a0be928af6c358057c8aaa814ea79.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 512d172c-41af-441c-df4a-08dba7b684e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /VC/NGG+gTnuwz0WRVzsnh6T+4VlqcU5nyVRbcLS5MfRe+cLF4MTltoB5aP/zsIhbPu7hXpOKIHn0hmtsJc2ud1ZKWnhxoa35EffQ7XNcNQdaqYWiNrjp7l9yGHCGdtHJK6hE3teNTOVl15Tx59DkTsNvNa1HGr7UVUzSovEShgG3t4KVJcirdcSutQG6Lz/knqqkZ58aWu0iyXMUQ7FtuKe2JDpqFpO2IDIP4AazjpBqGFAHR/w4yiti/zRYKayqwPbJ7hKMvKAmbB/YZgLCYeTXNgUE4KIz6lVzR/BZ+65h5B7zUey6/bH9hHWsNYMTySOrtsqIeFZhRAyG8dgAvP8K9Wg3w3nSc1ioKXB96XEPq60aZn6qoOT10qpRkWvQtH6V9mVA7j0kdknjHnOC+YoOFPmH5mjf5lzRvM5RDmP74O0VaxKLLUruf3sJiWE06OMcHpxiqJx3wMP8N1lGhYA2vB1LErFMuQQ1ifcr3NLzmygRTNYdRVnQyg9bsdtDPbFZDL+PtdmGO8UyRZff3Cx+HYMcHnq/ex9mY6OlgXXQiJHHW9vz/AnOZHmA93+6HzCGJbkMNUswFDkBE7Q/JPLSjOtF4Mj3Wh3Qgm2z6bFy6mc+QaM8vy0BVrI2uRPnw6w3q7jDK1792WIO0pWyaOhrQdbcdVQQn/8HSTyvle/JjFMMnkK+hPu6XUFfmZF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(5660300002)(31686004)(41300700001)(26005)(6486002)(6506007)(2616005)(6512007)(4270600006)(38070700005)(122000001)(38100700002)(82960400001)(478600001)(19618925003)(71200400001)(558084003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2Z2QnVCZzhHK1JSdFBjQnNya3FDejhPalVadUJOeXY5ZjNEeXROK2RhKzl5?=
 =?utf-8?B?TGZoaWFlTzBMRjJML2lBQ2FzNHRyRlkyd3dwSWVlYWZGWjExNWYxd0Nra3RT?=
 =?utf-8?B?djByaTlITzFFVHRDV0FCVUR6ZHpQRTdQSXRiQkM0RTUxVmptVmNycE42UlRJ?=
 =?utf-8?B?ejJMTDVQaVU4RmVSWm1Zb00yZmx5NWlHYmExNDhnUHBZMklTZFNDeVYwODNS?=
 =?utf-8?B?Q082T2s3cGx1c1JWTVRHOVNqejBLcG9yb0RISkxVdWJHRlkrTVVJTTUyNUxv?=
 =?utf-8?B?cHgxSGhrS2xaY1RuK2p0OXBGWVY3aTRueXlBcEd2eGJzWWd1MkE2MEl6aXd2?=
 =?utf-8?B?YVE2bmJMWGQrSzYzQ3JnVDlKTXlMUTJvNlIyU2FFcU9VY2dsbWlOMXJmNzU5?=
 =?utf-8?B?c0tuTTQxSmFrbVlNaUpodTZ1QUtNQ0ZoVFE2cG14Q25kbGFCeHorYWlSV2tH?=
 =?utf-8?B?aXFGUjFHaDRZNGRZR0NaeWhQU2J4QnF6S1IvMFpvKy83eU5YUUJ6eENtTkpi?=
 =?utf-8?B?dXE3N3JKL3RXSDl6TlM1Umo2M2laLzdMUmV4ek8wWms3RXJXRFFUdThFeDF3?=
 =?utf-8?B?czBUSThoT1BqN0xra2p0dC9ZaFJiR01zQTcxZ0FTQ3BESi9TSWRVVG1jNTRW?=
 =?utf-8?B?TzEvcDQ2RlFBelE5RUo1MTBjekVCVFl1U1RTbkhWdFByUzUwcXJ6THBMRm5L?=
 =?utf-8?B?K2p2SGVVV3ZxZ3hQUmFVL3p6N1NmalZPRVVpSUdFdEhRWk1hOTB4T1dMTmtR?=
 =?utf-8?B?eGFhelRHbmwvNDR6aTE0RjFwUm1RL1hmcytQNzF4SFFSTzV4d0tFSnZGR0dX?=
 =?utf-8?B?VlRPSjBmWllYYUh6blEybFg1T3JBU3FCMVhsQ3Z6dk1YUUo3ZDVKcURDNFRK?=
 =?utf-8?B?c2dWRlkvekMyc1E1Wi8weSt2aUpLOXBEb2Q1WTBhejJjM0ZuaTA4bmNmWU10?=
 =?utf-8?B?cmxyalptOXJibldrRnRDcWFiUWpvZFU5WVN2T2s3ckxmZUxkWmhSd1lHbm1l?=
 =?utf-8?B?SXYybjBwWFNtajd6bDZIMlUreVp4YmZWeGVPU0NpMC9SOGlKS3R5SXpYL2ZB?=
 =?utf-8?B?UUlKTjJJV2VFUWpNY213Y1I3WkxRTEZCZWtVTmY1VWR1Y2JmTkhKbW05Mk1H?=
 =?utf-8?B?eHhpaGpubXRpVUVvV0p2TFZjVnlNN0xBV0pOdlpETFp5N0N6SHB0VFl4elcw?=
 =?utf-8?B?aFhmSHZISWZyejFEY0JENXczWXo4ZThncXJSMGh4ZzhoR016dVpiYjRWL2FF?=
 =?utf-8?B?NTRpcGRUR1F6ZGVPSE9ITWVNV0JGaDdiMEMrQUJVeVVHN3VReFpkZHpVOTBl?=
 =?utf-8?B?VElMWTMrY25HRUJmbjlOVk9vZVE2UlVSSEVBQTVpS0dmV1dMaXZNblczbS9i?=
 =?utf-8?B?QjZPeFArdTV5S0NBV0E1NllrWVJEbHdTSE12NUViNU15MTZ1Tk1pVzMxZ3JE?=
 =?utf-8?B?aG1qSzJxSWRvUmdqemV4NWZJcVFrY2ZWOWlGeFdOSkgxU21SNUNBWVRsaU12?=
 =?utf-8?B?aEtLdFZ1ZGJxZi9VQkR5S3Q2M3ZlNTR6SG9hMG5UMHFoUWh4S2Y3UVhRQ2ZD?=
 =?utf-8?B?UXpPUEJ5Wnl4Y0NRS0tBeUJnRkJpc1BubkRZWEs3a3YyMUR5U2UvOGNrb3ZI?=
 =?utf-8?B?YmU5cFRPeG9tSndzQXBldGdJdjZVcjZwcHR5VGtKaU41UUVQbnhTbUlseTRu?=
 =?utf-8?B?TXdvRUF4a3A2NUtlWnhpaEhNeE5sL1FmZm1PeGl2ZXkzMlE4Q1pmVXlOMDZk?=
 =?utf-8?B?RDJQYVZ6ZFFWSk5ZUmhqbjJCVXdCeGYycEZWT29lTGJxemxITTBxK2JsYUpE?=
 =?utf-8?B?dDhPaHc2dEFyUGRiVmlDK2xxc3lVT01xdUpCWStPQVZvM1c4LzVhaVJaUGl5?=
 =?utf-8?B?WXEzNFBuUmdjU3dKNkNybHY5eHIzNkpXeFVtdi9NZlV4a3ZFNXk1VXhyMWQv?=
 =?utf-8?B?LzY3c2VRWXpvSTJQdGVLUXBPMmpVTzNFbGMxY2ZqamsxTnJ6cm53OUZQR3FK?=
 =?utf-8?B?QnVYY0dJZ2JTTENiRkF3NGJOTVhOeTJOYnpzQWVhTlhTd2JiU2xiSWlmaDhK?=
 =?utf-8?B?RjFwRkpRUkhjSG5PSHR0UHF4bFFiV0NrYU9DVWRLMDhOQWYxeDVnZVFZTHRJ?=
 =?utf-8?B?L0grMzUrSkMyTCtVUll6dkc1eWlKdVBFbE9XSXBuT1lPTWh3aVJwaWlhK0Vz?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52160C865B9B3443B6C2949401FAD4FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2dMoBokSAul/1cAD3nm2GxcEGonzJZAy3+5dUvGhK1t1ZYTH3zyoVjcAXJpBgCnWwz4FrQPhBaXDS7eadElYRJ+IzTE/KkV687xS+2U8M/XEYsOh5MaTQQ2SXM49Gh2/0HYRh03W3+t7sjuEBfGRzSZL/Gr3X/HiXggdvivtysLndtv+S21BPkQowp8mXMxEgOskWhGSyaZWYxkIlXgWTPR9Zr3oh9RMFbJNul+RTcS0Jz9YsIB6sc27wf7Rq8oJSjzADq8mUGunrMcvZiIiNxtzalhYE2onvkaJDgngUvLmMuseWknkoDNB4Gszs1p3DLcnO/bkj8/T/LmTUOqCUTfKuK8xWk4a/YMKNuFT+bxzEIx54QBUkmwc2bBNjGK4yYMRffgoB0hSaHMfD7mG5MxHKWZ0kIIoL1XeAjcgDu/uW1Fjnm2B5SocXjCGFllmPwIjVTQFLT4HGT90I2g3JBpfnDWvizXz9qz2tuV1txiwGGNcCx0P/8cwrF0tA/7AoVM0Y1WfITpzUZJFYlT2rKTb3/NTAm0Ta6+co0XrlMbkIZBnyTbbZtgBPnDenvopxEcGrzHNiL6NlPwFpA/O6/ihHU0PNsBm8zECR1p1pIvan4K/l2cNsxdNR2k/y+L8VyapTPxK8InQOotTjEYpyKOewi9Wk+2i9JJvxtF5pfzOPTojQcxPKCfEQvGDWRN/1q5vC0Irl1HA74y+H3ypejcDpho40LBCRkOeb0r0I4TwJpTc5ksUpTA6+8SlO5Nl5MFQdEsWKbGJkem0DE0G1hhf6A/O8xDXUxOgvhQXydgGPURvqwAgudUyA7Q0peAxr5J4ETYPOSAuMUDhebTWKg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d172c-41af-441c-df4a-08dba7b684e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:04:15.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQM4cbRIpIU3pDmQVphpPng/D67c1fC012wU5EoI+oO6EN2x8vK8NNekUXPIKza2oboCi2XYRVCmc5UUKSTb3NyJNvNARlANtJwU2emAncU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
