Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFE6FBB1F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEHWk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWkz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 18:40:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056277ABC
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683585654; x=1715121654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=JcJ1QN0NKBXJBQRQFQf/OvS6JRx4oKxHpCcSL5BHyzGkVc4ooFVEYK3Q
   ZKR/1YlURChy1tWvOaVgFM8u77rANS+4zPsJM447JWXPwxwAojctCEeo2
   py2d2wxtLp9InyuQ/wX9s2kuPtKFJWly4/Ii4sMX7JRiss+5XiXogOMKQ
   qRVIQt6BjIsLo5ZrZ5SymHt4utbEZVnBq4ZcWRPnmFh96DK17n8dcaBNb
   5ZZ3NO8UnAUfzb1JnWLO1q4axSTTBuZsiJqBJsWeGUcgIbqLGvs4cKLUK
   dER5LORFy+R0yT56OMGF4EfTZ+oDd2Sk0ZoolmxKwl6vy/Y6D4JFvCgzT
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="228378879"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 06:40:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0rdB+CEap/b1vgQ9tzuybRRkCcAY9R2ab/FEkNhZ368BJo7CdMdosz01CdVWoBDuhaypjwr5sC7NpdlcucgiAUd8dSOYKwoDDXFuuhHru86AYIduG3ZHMXUg1YQnwYams6aP5Cj/qJXObPWsDonRWkoqPi2nNK6HkOJuxSMIpXQIcDXCewJy3T+BKJsKFpIN2c8+jsEpnuai5l+hyZAKiqw21DnAVNIVszwbiKtXLNXNXxBsPVPot6Bypp/lZwA3VFzlf9FbHcuxUXvRaF6R7XlqdOxp9RcJhYP0HgyRNcLefdGSbo8yvonjVzH024b6c/2ExVpmfpXkAsjx0qnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IG15wouGjUF2LEopP4mCafswfToTDPnFSRIOR+bZXBmD9idrgxdS1MelCCZR+LrRyGEW1ZeTR3Mp4//IEwwRWLod/3kuG+FJ30ce8+YzoomqGI7Wo4BErfs9PtHPJg6fC3fknibVHpTEGQVUIaM6glGXlhn0gr2SNdRM0p/U1wEUI4VmxgpzVW3lKDMVhNFdqTBVOZcnpBahmbso/bGRIZeqBlgaH4cI1YjWovh7jQoeEApfB43wRUqpLWtswsh/I5X3zMlSqrJUHmdpXIEHTkHIw7/lgj0pVBWO48TDWldQVMZyB6aBYwRlmVhljH/Tq/3n3H8O3T65ZO+T78Y56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CGgc0kNnL/k2Oq8uPEM5exJ0lvAonkq4SSNfk71ZFW70EieDVEFkyEnwr6cQ0LQfPMjjssFbvAMnxYkO0GRlmecJMChGS/6REujcEaFFrIcKv1JW5ylw5ae3nxInOzfWzRvkC+5H3dObysJKfM2VhhpQYZJvsban6bxfPmLsksY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8714.namprd04.prod.outlook.com (2603:10b6:806:2f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 22:40:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:40:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/21] btrfs: limit write bios to a single ordered extent
Thread-Topic: [PATCH 03/21] btrfs: limit write bios to a single ordered extent
Thread-Index: AQHZgcdl0EU19OCWU0isG/CQabyJmq9Q+LgA
Date:   Mon, 8 May 2023 22:40:51 +0000
Message-ID: <309f7ce0-27dc-c612-4012-a786623c4a71@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-4-hch@lst.de>
In-Reply-To: <20230508160843.133013-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8714:EE_
x-ms-office365-filtering-correlation-id: b54e70f3-9c49-4d1d-f472-08db501546a4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yL7KZ/Ie9riDTw4xkichCDJJMWKhAf3AnRVjgqYMD9cvFroz4fHl+71AbAQGOvhy0uoOt+P4abxHHeIxLnwI/mhxQtHlmDRaHqSlUrJGYmLRWmwVE5epQGgEaSnivYZR5u6DfDwajeH7MSb7Z57TIASUpGWXFibhly13QGpHNdL9rmVn4vH5js18HcB9xYRTuezU07sFWQb14bAxkKaHbaUTBxTKWVdhOe1xj1EcaI/qqh7l7+4ZV+Cgwpo5JlyRE8lS9QjuRIN6Y/Jz3eX7eWaUnPTJZuEg2ccHEyyV8hL1aqaXK1tjSRSEe9e8mMQwiZB3GM6E6y7jZKrdGCCXCFgEWbJ4tM6iW/Va36vtQ2uGovTcW0lBbUSdhCIxFShCUWy2+VsslYWBGe3ANRAbZovzXwbhJZ/vOlmVyXcW76QNPTlmrvMixUzk4S5puiLnN+IDKCHkDVZjzkuNxEsFFYf6UdumshTpNB0qNRNm9Mk3niNOBk1y3Zy5o6ZKO+tiTo6pil1Difr+7ojAd3g16+hU/0tNk35VIzcTfV+2mRqdZFCMdhygux/jLCdHs5XvKWm6d676w7IvDUjBjgtUm91d2Mh+RCF6LL7Yzyv0tCerPHEIIQJon4mcxWAONE2qWnT3/n5Kj0tkpqSJjXdwZtr5pltvmut9PlHtXq3ldtwQldzAJCeSUy1I6RCJwb1v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(6486002)(6506007)(26005)(6512007)(2616005)(36756003)(38100700002)(122000001)(86362001)(31696002)(558084003)(38070700005)(82960400001)(186003)(4270600006)(110136005)(2906002)(316002)(8676002)(8936002)(41300700001)(76116006)(91956017)(31686004)(66476007)(5660300002)(64756008)(66446008)(66556008)(4326008)(66946007)(478600001)(71200400001)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkgyQjE2amc5NklLcmpQdi9HRWRYWDN6NFZ5Y09wSERWdmxVaTJWcGtaaG1k?=
 =?utf-8?B?aVVNTkZUT0E5MzQ2NU9sNE8ycEsxODlhbC9sZ3NlVlQxWmVIZEhYR0xIK294?=
 =?utf-8?B?K3VHSUpJWnRocEVnUG5iTnp1ejRCZ2ZpSE1lejVKTmFKcHpGejB4YlJObUpl?=
 =?utf-8?B?L1BHYzZYRGJxUlhKaFRjR2IwNWpPT3orQU0yUUY1Q3JTRk5BWVM3MGpaK0t1?=
 =?utf-8?B?ZXVWcmVMR1ZkdXd6NXo3QUlQMHFvbEZMK0hKRW9jelo3dktvc1hpemRZbGFK?=
 =?utf-8?B?d2x4Q2d4Wjh0UWZkMExRb2xXRHFsRVNISGJRbEZ0R2hqNkUzUlVYekF2M2sz?=
 =?utf-8?B?eWJXTE5JM3pPcmhBc2ZROG9jMlc3RFJxUUJBUCt5VTlmSVlCTDB6MmM1S2tL?=
 =?utf-8?B?OHUxeHZxbW9CcjRxODhsb0U3SWJZdklhanlRd21KcEJ5Mk8xMUtsQ29wTCsw?=
 =?utf-8?B?MjNoZTQ2STVRMjZBZTZDenBrRkVWU2ZMcjJyWENLWFlpSnpLckdPWmczT0Fw?=
 =?utf-8?B?YWp6c1NqVGMwSm95UmNKQkhCenIwR0ZReWZRaGZUQjNiN01RcTNXL1dyZi9I?=
 =?utf-8?B?WHM3R3FqbUo0YjZnRXdKZUIxS21JSXNOcTd5TkgvNVpSYytjY1B4ZFJ4WFYx?=
 =?utf-8?B?akxqZE95enFyS0Y5QnNPT2lIdXBsUC9lNkorSU9qdkhWS2FXZVcyZTFldVNi?=
 =?utf-8?B?VkFsOUlVTGE0L1dIMlR1N0tRSWJIVW5nWGZnajN1WUlESHdraGV6V1pnTHpH?=
 =?utf-8?B?S2dRY2Q3bWNLOEZPcEozdGFNMjJLekFjQ3kxTjRUZlFUV2ZyTkI2R3JvQmI0?=
 =?utf-8?B?VEdFenh3aGVQSHhIb3l2eFdtL0hrNXZrSFU5dy8zVFQ4c1c0THovZnZuVVRn?=
 =?utf-8?B?bTdNbW1ydCt6aUNFRUtKc1docXZrZ3E5WVMzNG1Sb09hTnpMZWl5T1U3TlNs?=
 =?utf-8?B?T1FnWVY0N2dZL1NXaVFyREc1RHp2MDZ4cFhJa2tYcHJ3U2IzQTF2ZnZCU1d1?=
 =?utf-8?B?OXgyeFhWTU9rWDJJUWVSV2IvcmVBQnBNME9mc3dCNGR4V011ZUhCODl3WUg4?=
 =?utf-8?B?MFFUSXpCYmVqVkhvU0FyTUR1cmFKM0FTdzA4M0sreWV4LzZLVjMzbjRXQmsy?=
 =?utf-8?B?VzIxRm5DZ2RwTkU4YnA0U3JrVjV3ZDYyTUxlYzdZNnVHS3ZEbXg5ZzVNU3N0?=
 =?utf-8?B?M1Z0YXVaMkc1ZFVaNXIzTXNVTVRuZXM0enJDYUwraXlGT01YdVF3eDFkU0hP?=
 =?utf-8?B?Y3RIdTZpSy9OSUZWSlM2bmJBNGYwTHBoR0h5WmlJNXV0V0V2cFJXQmhDV0VG?=
 =?utf-8?B?S0JYWGNvNElVSkJET1RVVm0vYjBuV0wzWjl4ZGlCS1lqTzRjSmNDeS9Zald0?=
 =?utf-8?B?ckxudFJtSDY4ZmxMdGRGYUhlZDlhM2k4UXkrUUVROVBCS2QvYkJuN0xOeVF5?=
 =?utf-8?B?NExyYUEzSVBsd1BFSTJlaWcrQTFxdXJtRDRRenlsbWVpbkZRMW1JNVFrYnNZ?=
 =?utf-8?B?d0hwNnlLUjIzVXZXb3NUQjFhZlFYampZZlZ3a1hsOUt3NDJNRkdubSswLzNE?=
 =?utf-8?B?SzZGb040SHpYRTRLOXRMUzRTdWYrYjdwK3JnZjNucnhwOXl6Q0lsbFVubDF5?=
 =?utf-8?B?MzBiemFBQ0x3OUNJL0w3TW9vNmUrY1piUmdndnVMTFF2S1lSM0dtcWFETzlC?=
 =?utf-8?B?ZUtKUHVvanUzbVpLYllLRCtjdC84bklNZ2lsZEFuS2ppSVpMNWtoWmxjdXhu?=
 =?utf-8?B?V24wU3lUYldiR3ltbG1wS1ZOdTRpN3lLcUk5TkdkWUNDcW42UEZGRVg5RnBX?=
 =?utf-8?B?aTVQQWlOT3ZTSVpIUTMrUVJOSDJ1TXVSTnBDQzBQQ2RSRWN3Nms2TXdqTFZV?=
 =?utf-8?B?N0xkb2RVcFVHdU9valYzV1RBQ2V3b0tVQnFWWk9BT25LM0VMdlcxNDVaQXBm?=
 =?utf-8?B?Tk5sSW1ocVFjQW9JU3BmeG81WU43Wm9DSWxxTTlzbEgrRWFTWGpkM3BBVW82?=
 =?utf-8?B?b3VkUkFyNWdnVnNrUHNVSElaRW45eU5xQmtabGxTTDFpWStHdi9lMDZFajN0?=
 =?utf-8?B?ZiswNHFmSTcvV0RVa3pDODRjUWtPbm16UWxMd2FTR0VhbjRManRXU2J5SXA2?=
 =?utf-8?B?YTBvRHp6QXBMUmVlTFk2WFFvYUdObmY2NVBITFhaR2c4Y09KclRWT2hiaGVu?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D8C64A6F65A0443B30BDB68C6058B26@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VqdQPdeWdG5dixgTUROD3SFaAz8ka1WuiDQW7/5K02Y1q+HbbkxyEJogIaJpfWMl/3QqDlB0yAR0+GpyWqyRbcdGwbqORNeJYvbEu5IG8I4GbRMtEEUvJZmK2ej1SEZYj5l10QNd50Qw7fA8Sp6F/4ASR6GZ6iZgARnP0UMwZb/+gMfIA5TATorblo7kCtx4JpGCOg2l0Fu9ET4w3vxyKf40yv8CTO9viXeHqfyF75kbZhrjK3zD85mdUZdW4d4m/6buzFAIv3AI6SoQ8YmQ2PPLaQURbbqwZn2PF5hsh3XjMs/lSfGIOHCXvkXYGU8AVkTjP/uIUbL0l6KHGVXfK6rA6Wyjod7UEEQbsW1kPb0kmEvq0M6D+IP2rnkPgpMwwbRYUUjngFKlGAs7PgYS4rm17SseDkVk/OnGEI3l+0UB+74MKUdq5nZlxX+N36+Aw79w4LpF9e+wuG3TC/KaU1gy/+CYWTF82APRiZ0iSk16b7xP6uxKUqTSFpXGW3z+1DWLk6a5mqwO94zbmBQyLcOpYzLfA+MZkHnnNHNUieJCAfq4QUbUnY8DlAjP0EsFx3F3n+6yyRT+bhxBZ2clpCCM8SnU6efMBE0mgCjrghUQNPlce9ab3wSrEIef+4waw3CoLN+K5H/LV+BCJLJSYFgJEZbksXZAmYfuhCG/8jQKZdLTVsdkzt8p4+KoFfMQORmbTJqVvTNDzkJVtFDYNO/kH3zgzR2E365TCA5Zohb6LgdmjhPFdgOMDvXlfkMoP02pVrAUM9kvHEweQ8amhlfKhhFvXoQcRCOtbwNRCBabVqenvAdAT0np6p+a41p2AOmqZ7CQ9HlceJTF5P7ZU3Wn0bFLJGP5BS3hAMdxzp20NbcZTQHUco7dR9tr1IoO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e70f3-9c49-4d1d-f472-08db501546a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 22:40:51.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVHmuU7iLoCA6PagHNq3Pc75srbZN10Q/B8JovcIApEihy9rZZNtHf+eTwOksvCsBCroFtJES7m6vuKUHRKoA738Lq9jtarIR4mOxGPOWbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8714
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
