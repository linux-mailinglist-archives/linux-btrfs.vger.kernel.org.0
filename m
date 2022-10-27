Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2360F08C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiJ0Gpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJ0Gph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:45:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1BE7B1DE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853137; x=1698389137;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pha8/9ltRZXn64sDPj9Td6ATwlOVo5p7QOw9lHKMgExcDu5O/ED9jupB
   aKSbDzTZzXFDgSL0tjkMeMPrtv3Zc31YzX0efsJcZ4WFM7t+JUMp7vVpy
   LmFZONBi9DiNMYWjmyawc+NS5SZnjkdL0DhcyyaW5HPio8vJmZr8R7lZm
   k5kOnxpuHbjm+f2Qh9Hpcxu/mwJSro9b1OrB+acBCuwjoYVvs6giEfiGf
   7zSIlZ8Og91L+XRkp2gJfhC54B1zgix0GNJaCGhVD4duFOATzIOiydSlH
   Rw/71S685reQMBUTvjrl67Zg2eouspdY32J7OuzDYYlGY3rZfG+udkneV
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326957330"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbwkYuJJQZK7MKA96eOsC1Tqzlz6nOd9ltaPSZdWCZPLzaEfMGykFdGWm8yc37GHzjx7SSTkJq23JzwXHN3lKbe0EKPnvlmjSkieeIkgFabJdbQTwRDxipKDzSzdDqwkYuAoZykWKdfqNbBbDm3hSwv85FAQv4NAz724A/h86I1wE4l0cVQZ5nFUb9fgyZsRAiWaf9AFJoxhTuyFvW0DDo3LX/p+8lz5e9IGeYBOKrIuqZxC81neCcpfuPT6tEv32eZy6EdniDaBhgRcjLG+WiK7cZ7DZneW/Q0Ye4xjNadWBGbY1si4KWL4FSsccDWYyg8IgjwQ6fbskm0Rgdri5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MF8Feflcf793lt5SHTnPbwW5XuNY+efRt5ipvWqL3qVOg84neug1+xeMzPatwgSCi2+YHjQJ14e4C5BfAyZHn+I8eHpihsBVXv21rfmcKOlIy+6hje8ITKsMegauFJfXWvxBoi8brIbvxPSoN3CjbuQDC1WpTMo88Quw5xFFYZEHIJLVrz1CbECevJjE1klfrlPuha8kGlKpgHCdKKmZD+z799k92YLqqRIbB0dChOd53HzP05sgFNXbOyJGAghhzQkR/3rfRzcQyGd4uVgIF3tnxdq9CMvBD0B26V2FaMhtTmmzjX+OGxIbVNnENlPOGbjFZAH0V5cQpFeVatQQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dk1C+ARWMyWzVxYR0oxZksBW04wiGdiwxKVcTdcDZc51S0SG5lpDKjsLxBnkVPtnQzh9DSriS5mKJhOnSgrqMCEvrc1XiJzLJzHJBbb9740goU6QN2pWHhuBHHTC2mGKFDvRymfg+1lYo8s6FP8PiKuXfdhZsVIqJm0ipzQ7QbM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4034.namprd04.prod.outlook.com (2603:10b6:406:c2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 06:45:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:45:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/26] btrfs: add blk_types.h include to compression.h
Thread-Topic: [PATCH 04/26] btrfs: add blk_types.h include to compression.h
Thread-Index: AQHY6W7NgsYjCmpsP0CtkGzWALMNHK4hzI6A
Date:   Thu, 27 Oct 2022 06:45:33 +0000
Message-ID: <084bf12a-146b-0640-cf97-a58a9321e6ba@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <b773037548f28a6663988e20889f7f939f231a94.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <b773037548f28a6663988e20889f7f939f231a94.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4034:EE_
x-ms-office365-filtering-correlation-id: 11469c31-4441-4c62-0769-08dab7e6d8eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jz7yiOD+uvSPKt+TZZ0ndn5/N/B2zAlh60T3Wz/LKnGJHJ3ZUtgRRWv97IY5Eza34+R81/b4hZMfjJNQFot5diaiuCDSh7TS9822+wSFXR8FVa02x1K/pw2PZOsZK2QknQGqyenw0Lcw3jnSiv28v87+jECgCG9XBEKtJvsgi9NMT0bawbaWhdVoROsvc4k0voAzzgqQeF3uahPiZahO1tdWNh40l5Smi5ZVA8iz+59Eh7Y3bEuVAXMyy5f7/hM3Y4lcgDV5lsBMkk93g3E7pfYHZ1qn2GWV1+DGU8p46/IjO+sMqSNznhcIfnghbrff7peq5bN/8rjliEE93IZw91Kx+7T2skLHTtGdKCKOgOzc5yiUTkBfelvFpn0mYhiSq81jbOE6oPEd88M+pKEBhzXdyKRQsv0USTf0nhquUCqgX/NUpHiYVXpRyoD+FQ+LcLCUNpzAEun9nzVOR0nsO9TfEfyj+Dq/edp4HniCP/71J7/lHqyB3ee5oYEG6jHMm1vaB87qJaM7hjDiPZgswvC9q55chtbkTyg7FPCjzkZ5WuSNeJr/IWZF8lITmFMdjDr92hZcm1xZDFchkQkCKklHpGvmu5yW15qyLti6Sxyhu5e+3y6rXXCISmGybRAQvhkz9zSutUNkN7wt6QwhaJbyV60we3/iz23cqICb3oCdeVKyIckZvjhKY7iiCmJ23P+3Tm7HLvCg02vT5cg8rbpYEFUtDx8cRVDPmHAHDraUhMRsNNkwhJC97DiGb502MgVpJCfC3aDVaDTnycHUN/NwUP3keuIj0A3KmgHcAMiYXW5b1ub9K/4nHLzOnTwY8XybpJ5nriheX1R4A6+hxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(26005)(38070700005)(6512007)(186003)(66556008)(41300700001)(64756008)(66946007)(66446008)(91956017)(66476007)(8936002)(76116006)(19618925003)(6506007)(2616005)(122000001)(38100700002)(4270600006)(71200400001)(82960400001)(5660300002)(2906002)(36756003)(478600001)(6486002)(31696002)(558084003)(8676002)(110136005)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGV0VmxKbk4zSXFjR2FaeldUWVpGRDhEQXRYSFNWRnN1bzdUSFhubmlveTdR?=
 =?utf-8?B?VUVRY1Q2cU5RN2l0RTdvdzB6dkt4aUpFbTR0ZSs1amNxZ0NxTW5DUkxYT29y?=
 =?utf-8?B?SDFmZFE3R3lnNzRqOFdmVU81M3BiRHVycCtOQ3hOZ1ZUWUdmRmFLVEg0Q2Vl?=
 =?utf-8?B?QXJ0NnNLdDV0UG9oTW1ic0FHMGIzS2xhVTEzZytlTDRZakRFUGdsOGtFbVB6?=
 =?utf-8?B?c0FRalp1QUMvbHpraE10ZjJSb01NdDRvTm4zZzh5WlF5cVplczZFenA2QzFw?=
 =?utf-8?B?a0lUNlR3M2NPUTlKQVRXRHFJWjhucFZqaUUySkdjTGVXN0NwUFRxVzhNaUNH?=
 =?utf-8?B?d3hIeXllU2lRMUhHWE5yYUUrRURPMWNzMVI0OGJPMXdqYk50enVORWp5ZUMw?=
 =?utf-8?B?VFBQVTJSNUxnb0tnVVNjekZhcUZ6aUJBanVyWStrRk1YY3Mva2IzaTN2OXl0?=
 =?utf-8?B?aXBuRzBJRHA0cjJPZjJsYWE3Q2tCYVJiN0FjdzMvaDVhdVVUYzFRODRWZVA5?=
 =?utf-8?B?b25CVUZGbWZDL0ZwcUZYM0hOR1RDdzhLZzBkbThCaTBFRTZHdkVnT081WUVi?=
 =?utf-8?B?Z1k4Nk5jbDB0Z0ROdUs0VzdocFQrY0hnYm13dUdGQ2VOZEI2Uk1RN1lMTGwv?=
 =?utf-8?B?SzVrL1JsS3Q5bkpqRVArckZZS3N3R3JTSHJud3d4WnBQODZ0bzdrZFBkT3Ns?=
 =?utf-8?B?WW9zUEx2TkFJMGVPUWFET2RlNmpqK2MvWmVOWFloNlVxR2Q1Z2VZbW16d3p4?=
 =?utf-8?B?ZEhnQU1kdHZ2Mk1rL2NRaW9PT2FlSjdZNS9kTUpKNmJLWWF3U1JUU3h0eGpL?=
 =?utf-8?B?aFI1MmpkRDVTY2Y3WllLbFFUVHBhVFcvUStFd2Z0YmlUd3B3MlhjNEtHRFEy?=
 =?utf-8?B?M2FZYW1rclVHcnY2bUJoRDhuM1V6NFhUMmI4U1EyNXBob1JuQTRGQzVKZytX?=
 =?utf-8?B?NzNTM1JPU3h0K2pjMGF2RU5zL2NONlBBRGNISEZROGlrTHVMSE54aGlEeHhH?=
 =?utf-8?B?Q0R0OGtUblRkNU5PZ0d4VStRaFQzdTY3S0hpcHJDZlkwWW11bnZOMGpML1F0?=
 =?utf-8?B?S3ZBUkU5TlA0MkpQRkNPTUE0MCtJYWk4ZVVnMkRtUjhURXVNZXFjdU9lS2lO?=
 =?utf-8?B?SEVFelo5SjdMZERuUWQ2aksxSU1aTU5nak96WnVMaTNjTjUyRzJZN1lJeWlX?=
 =?utf-8?B?RUJ6YWYwc0RVOHpyVVhYUFlGTFBTSDZTTURFQS9mNWQyZ1BRMEhiVDl4MUFx?=
 =?utf-8?B?ZGpHT1JkR1FYNG5wTm5qaE9pYThCNnkwRjhsRlgvL0NWU21vN2ZnVGVsd2k3?=
 =?utf-8?B?Q3ZHMlNVQ1k1ck1zRFUrSHdsVjBPa2E1dHBFemVmQXhaQTRZMjMyRzlRVzZX?=
 =?utf-8?B?QVRPazJHeEQzdDRXcWZ4QWlOWXJ0bmdDYjFZd2Z1MUlRV0JJSnNBNGFudUhO?=
 =?utf-8?B?WEI5SE1YMFpMQW50R1dXNG5jbnNXQTY2T2k3OG1SUjY5ZXVjcU1xUFVtam9M?=
 =?utf-8?B?OTVkaFBLWjJXUThDMk9vU0tTMkRYZC8wWHlPcGdmTlZ4U3ZQUUwxMFNxa2I3?=
 =?utf-8?B?QTVadmE2UHhjc0VYSUJMTHpmWVFvQXdWLy9Fd3dNTGlpdzNDUTFzLzl5b0Ri?=
 =?utf-8?B?ZmpqYUhSR1hCVWx6S01IODdwcERXcCt0a28xNTNxY3hjc0JTRy9wV2lxM3BC?=
 =?utf-8?B?SmpwaElLa0JiQUdIb1lzRVlRZWxMV2JSaU5WcGNZSW1OMFplRUlXN2RselI0?=
 =?utf-8?B?OVNoUVBJTm4xZ0tMSHRyMUJ0Mjc2aVUycjN0WDhPNmtNQzlhWG9qS05OTG9Z?=
 =?utf-8?B?cE02d1daNDlWKzVJMWtoV0E3dDJnOTJoUzArbFY5RTZ4UE52VWRLYTNpZi9r?=
 =?utf-8?B?clBsTGdJbjlPZkhXTnFBS2thSnM0dTR2SlJEODVnVjBrUmd6Tm1IVkZxY2lZ?=
 =?utf-8?B?LzZnMUZ0TVl5U3g3ZVdCWDBRQ1NFWVdicmFFbm82dVcwQ0tyc2Nnb0RlcFZi?=
 =?utf-8?B?bDZiVTJFTVR4alBKbHBUdk5jdnk3L2xWMU1uMEx2cDN2ekdubDZFTk9ONXEy?=
 =?utf-8?B?YjVNOG9vS3VZK0lOc09CUExsUUlURDVnbTZaYkxiWjVIclZtY2xOeWw4UWs5?=
 =?utf-8?B?bVFsbnUrTEdReUFPUHZCQVRXZmtyS0tUNlBybUx2d3BFT0ZsYnd1YVFncmJ2?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53DCAECDFFF3C84CB6806B6BAA97943E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11469c31-4441-4c62-0769-08dab7e6d8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:45:33.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OvCIIO3J9yHN0ThFw1c1Kp9zfsgqwl4oHXjx+9zFL6H7ifn3QaOCiJjUEEPANjF+ctYeR8C9aHNZido2YB/Ho5ztGBnT/V+HDFXKhjlpXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4034
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
