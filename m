Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5646B60F4D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiJ0KVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiJ0KVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:21:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37721162CE
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666866089; x=1698402089;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IPuC6cmyMDb12MioygWPwtoYMbOQhCzTQgAs6JM+NvhX7VP1VL5LQfoo
   pxE9Ombn9Iekbn50kjoxhRKeAfL971V/8GPFs9IrUgGzQJngFwE9IKij1
   sKmlYTlZKcUy9WN/X/r+2ojKwK1QTnl55ByDQuuDcR25hXVaXk1u4GBEf
   s2ymsN4mZrFrkNyZS4VGrU/wX9aWF3/3h9y0tlibU8HgoNmYblbHHVA78
   kTN8nmTqOA/r3cES0Uv1uEP8C4lU26jIHV0pqplcf6iWfmhfQGzhSFPpi
   B1ZSChDoQfDzFzlDZw9wIPLGFYYIIDmRNLAcUzNoXkaX+vK7gITRRbPMe
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319191872"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:21:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNwWw1nXbEIDBYJOyx2qvTdXoVmswGqqtmRR7xEZgww6ovTrfUwp3gWjKMHazLiMkqvszJgZ2ZGcwqgelNZEDgdrQukI3TrHC7VXMiSU5AC6vmYZDs/kWWw86+9J/BME1vpqNN/Fd0YIx+GbpHn0lX2M0G/n2aEyvPbrDGJv6ln0rraYnmj/ssaMsRHc3RBA/Rt17CI0vH6RoL1J+/qm4WVFu4sB2kOZI7SywYLIjEpi/vW0dbB1TzzfSLrvnRAMmoRZiBFHEhGc3xQxMeal24nKZztO//F8Pu17dSFU7FGBWiVfgeDAz/HAnJFQmIst8DhQRu7DFDapEb1AM6Vfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CiRpkeEO4YjfawxVBlEJTKtlewLb3W5Of6ix037Edpv8bSt6TFN4Ro43BAayq2OWmIBA1T5jtpJn8UjkHQlsCFYDSIzJOBHlSmZqSGNcqlzEvol7MBDjXICHD5iIHDVI7HH6Iet+nhRJnxYPR8Rc2N92fsZRK/kZaiiTLzSayNHkl4z9u0Itb5wLv298RUfXVE/ndUhvXehmvEnq5gvTfTgQxW6kw2tvtU3Pc7GI4EujsqVBrJcNanOUd0a6/3zwK9Hr0iqxQbOojp34X6OmUxlcGFYsezs0v9sxNgVJ79hgk6NMZlVMCeotyA5DGsT78eeulrx8uYP0p6KyiJ4cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Q2E5vfyw0kmfHatxE06a6i54MCYVgMUXmc+Y5goNR9ftL6aGOEE7dP2n2Mk8DitTU9t3yt8nL6eQhjAFFllZBx0lY7QXXHzDpgSiKhw323vTFt3IkDokxIpPvWYaMbERThs9DrO5kJwDCmOJZhFgUAmjydD61HO/IDm5NocZZ4M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5524.namprd04.prod.outlook.com (2603:10b6:408:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 10:21:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:21:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 25/26] btrfs: move super_block specific helpers into
 super.h
Thread-Topic: [PATCH 25/26] btrfs: move super_block specific helpers into
 super.h
Thread-Index: AQHY6W7oHqXVspn0B0SgaSfvheWE7q4iCOCA
Date:   Thu, 27 Oct 2022 10:21:27 +0000
Message-ID: <2d7edb52-b27f-3666-10b5-ca7c3d3b4089@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <8117066d4011676ed0ed58c23fdb0f1c93a468c9.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <8117066d4011676ed0ed58c23fdb0f1c93a468c9.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5524:EE_
x-ms-office365-filtering-correlation-id: 849094d0-9c7f-4770-fad7-08dab805020e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6ErfaBY3NKylfcdxXJ0hK41gIEx1CCZuuRFLr1JlUUR/J2S0YzdGUxNqL9B0wPfsKUSqdTAPLMyIfom+OfE+j/y+Lyc4M7/fVqOiCk4UjCz6FxRk/2F2HwY4u3/Fu8V7irVYwgbs0p4OL2v4PC4GKXL/ccc3slERTPDpwDVwFFkjjiMuQMTK5FiyoWOjLELdKQRYUEER3tBj3e4j+HIkUqb4fsBaSfz1XYgVXjUqy2pfa08zeV5QlEoWVEQqCG3vno6bm5u1r9LdyXEqv9CQspwxCThVnTP2sFiBB6R31E26O2YzTdBz0xxhckqaaNJx8g6blPc3JhYWjD42HvR0tMg7o//c2Idvnrg35pdmgX4yVPHDECHsmbYf3BDUkRdAGwFMpEg+OFCPED5WcQnJ2nU/ls30XsOk+Peq0XtquhjJk3guiQiG5aDYa8SaDExApXoeyGpa+NSa/dn1IHZlcMdfedxfldYPHiskuDd4tyMuaAS3WqWMS2MZWyo6/vQkcnwAwUYnoXjEzvGPClkNE401Xeampvm9HEpAyQqHdso73zXShxxMPdfoTvHxHvSxZC4rvds3TsqYrGD1WQNbLZrIBiz0XMfWgnhfd6vXzUo6x27q+Qze4NproT0dwnKFKB1buJcvsNyc28Eu4q8hZlGGolZK0F7ObI0ZwjI8q0cWCgdLTwT0i9O3q8L6Eao757hQx23w/De57fLIqC4Ex8zfdHW1ml8VZeOgMj5Wt3F6cQi8McUqKSR8TUIvYg9H0KvDtAnxgFQyaEJvAc38Lwg+7pYtO6FYQfszrH4i7ii3FFrK20CRaMfuKdF8hAmdtpvCtwsxsqZwbELDKhAAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(31686004)(38100700002)(2906002)(122000001)(5660300002)(82960400001)(558084003)(31696002)(86362001)(38070700005)(186003)(6512007)(4270600006)(26005)(2616005)(6486002)(71200400001)(478600001)(91956017)(110136005)(316002)(41300700001)(19618925003)(64756008)(76116006)(66446008)(66946007)(8676002)(66476007)(66556008)(6506007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUxGdDZtdGswU2lGZmZlY2U1SXFLOW1LUk8vMDdpUkNwcDhRaHMyNFA2UVJt?=
 =?utf-8?B?aG1JVGtnaHlaaFZBTkZTRlNZbzUxU0ExUnBDeW5FaEg2N1ZiWExycVJ6dEFj?=
 =?utf-8?B?bEdHVGVqVXViNzFWSUI2K1YyMDhaVHVzVW03ZGlEWkNZNzUwUFZiK0lEQUFY?=
 =?utf-8?B?Ulo4WlI3b2IwTXlDL3dDSzlNaXM0VnBma21zS2FhbkV3WEVGblR3OEtEMi9a?=
 =?utf-8?B?Tit2OStSdlBIYTZlZUV5aU1BeEpsdGNFdVNORTEyN3RLaG9hZDZsd2VJQTQ3?=
 =?utf-8?B?em9ybDU4M2FBNVFOSHBKNnFTS0k5SENpc2o5c2srcTlYTXFrdytmYVhLaTZI?=
 =?utf-8?B?TWw4d3JPalRqU3BmZUVtQmpjZG9jR0FOR0l6N3IwbGpmdjhtaU84ZGwvU0kr?=
 =?utf-8?B?WEU4dTNmR3duUEhHNzkxZWphcUtnQ0FBdnJKQzc1dmVNNE9zL0xDTG16NEhD?=
 =?utf-8?B?NmN4RG4wUkd4M0JEWU9HNEhFR1RXMWJOK1dYQytYdnd6bkFHTmM1b1dUZHpV?=
 =?utf-8?B?UVlDL2lOQm9vU08wVEs1VTFDUVdyQnVrUmtsTHhvbGs1YXA1WGltZ0Y4ZG5I?=
 =?utf-8?B?UGVEZXo0aGRjSGJpb2tWVUNLMit1b3RtT1dPMU05eVlOUXhEdWtkb1FvazJR?=
 =?utf-8?B?MUYxL3FaYnZlbllsSG1BM09OSlpyazZ5cVpmQ2hscWJFUWxNaFdKMEUvd2l5?=
 =?utf-8?B?SmJ1eGJFQkFpOGVVcVhMS1E2bzNqdVNyc3VTZUVsSXZKQ0ZDZU1ralExYmNz?=
 =?utf-8?B?ejhhOFRtKzJOcnkyQmxCb2tJR1Raa0ovN1RRNGwrOHhQUjRKTlZhYWNsTENJ?=
 =?utf-8?B?UU9HWUNLRWtveWlDQVVpaGlnYW9tdzNicEFYRXl0dXFGRUJxZFhGY2w1Wm1C?=
 =?utf-8?B?NHM5dGtJQVUzbjNVVXljREhOdmFwdm4vd1lKdlhnQWVWLzRLajMwMnY3NTFl?=
 =?utf-8?B?b1VOSUhYc3ZYV0xURlZCVmJ6OEMybnRtcUNPRmR5WXQreWlwY3RGMXYwMDBN?=
 =?utf-8?B?alJzMENQck9YS0x0cUV4UnpFd0RMbUdjZTZnd0xVUFRReE4xL3BXbjk5Z1RM?=
 =?utf-8?B?SzZIQnMzektGQlF5Wk9oWldHbmZqN2hTQlRpSFJFK3YrUVlod1c3dHpyS2tC?=
 =?utf-8?B?cW9jWGlRRlhUYjhTV0NKVE91VVhMNEIrQStPL05ZM0xFNGpDbHNjb0R6WkZr?=
 =?utf-8?B?Z2ZSaGdQV1ROMVJhZ2I3VUR4Q1daaWp2M21XK2RSMCtJbWtjYnNwQ29zOGdU?=
 =?utf-8?B?aDhmby80YU9hMTVvbTVnQXdBWGtFbEdPaHVray9tU1BOa1I2Z2FrUFlwMmt1?=
 =?utf-8?B?eUdQdUs1amE0ZFd3eTQ1RDVEQ1ErQkJ0dDZRN3NsR0x2b2h5Z2ZoUFJya3FB?=
 =?utf-8?B?Sk0vTHF1YzV6UW9CQjAvZDlqb0pkN2U4Mk92UTJQWk5pcm5TUFZzSSt5T0tZ?=
 =?utf-8?B?d24xMjdNa0NLeVh3ODlzd21EZVRnT0xrS09QVEZ0SkFSZENIUUp6U250ZHpv?=
 =?utf-8?B?aUxiQS9XSEJYMWQ0eDg4V0ZXTm1zSFNUSlJoMlRxZnZBczJGUEpWazdwQi9Z?=
 =?utf-8?B?eHE4VHNRRFV4eitFclBwZkNVY1pKTGt4RmJxdk9iTjdUV1NCem9zWW5nVDdP?=
 =?utf-8?B?STZUOWt2ellkN3pNZ2JSTEdNRTJKdEpFd0prNlp4RllDcnBuV0pkM3ZwbFVp?=
 =?utf-8?B?eGlPRll6YzdGSStpYlM1NE9OYWVxcHA2RWhtY0JxSm1mQXBwOWhhUUhGampW?=
 =?utf-8?B?SjZNc3hKejJpTmFEeUpWamRQU3cvMGJySHBFS2xJZkowWDJuNjJYR2Q1M3FM?=
 =?utf-8?B?U25ldG5iekNxZU02Q0xGZ2JBS3hLYjlJbDBJaWpVQmt1QnBNcCtkZnFKdlRK?=
 =?utf-8?B?MEtvaU9lem5ERTA2eS9IWHJIU25MQitZRmo2VHkrMVA4SGdQRjBBN2NnK0kx?=
 =?utf-8?B?TnFRMW0yTytmU2ZmM2orYmt5NFVxNVljbVIxLy9DYStuRSs3NTZzY0ZuYjVS?=
 =?utf-8?B?Zlc1aWNwSWxRZWpia2pMNG96NFZJaFV6c2YyS1lnZXFVQjBsbFc5eWk5Y2VK?=
 =?utf-8?B?dkd4azhQa2dQekdrSkVhV01HbzZIWVZ1Nmo1czhTckdqWWI3Q3Faa0ZxaWk3?=
 =?utf-8?B?YWZTZENmZ2g5VGo2NTNINUpsV09aOWVGRlZncVBPTVlqT2luL1p3bUkrbk9i?=
 =?utf-8?Q?FTUANDF6NIfUBO/qE8HUUXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4E56735DDF3DC42B0D31A8AD19F6CE2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849094d0-9c7f-4770-fad7-08dab805020e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:21:27.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtRblAocWJeOyqIF9XU2LqCjCt7FobEhfdXHZT4JHHwZScUouHD/6kTJj2vzLLyqx+TC82kCOGq2AV9AwUF/oBEhub1BPu5XzD/S0fZSXi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5524
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
