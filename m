Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF878AC1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 12:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjH1KhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjH1KhA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 06:37:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0E115
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693219016; x=1724755016;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ypbzghAUex81d+aU8eNRHfFHZts6VHCN/VbGthwe4lQ=;
  b=Nl1Z4bYd2jtvDBFw5xjR1ZPQ+KOkk09bLEXY6MrembLoFjsYRkAAghxy
   6WF698begyXwjtxeEeAfZJ4lmKVg41Y4SqzzMq7EItWMYo59ktOnFTKiN
   SwhOfnzVPhKwRRVWHfzlTLB6emB9d9aNRkt1dUAvZDg1GsiZiWvuQ3fwR
   ybji4vsNEF5ttGsngd4DXib9U0vPzkgZx4DS54tJ+S2IGzEkeH0n8jnt4
   F1D/ltuRNNrszKZP27OptOU2A1yks1FH/zF/J2SpKvGX2kVHILloLYde8
   k2W59WhGekX7gFnNNSFpsp5uAk2OWb0AAfNlFu/wUyQC4+SOB4DK1l943
   w==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="246899860"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 18:36:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxvDg2MpHxj1CrldyPcQJ1QdIEeDX7TRE5ueETb/XAOgLE64GLAA7HoqijhekodMHJQcd7e1vHvHxcefnlFpb+y8g4n3xtKiadbZhYyAYpIiDayRGamhgH8izEvWL4wysBqOcSI7zYHed5ydjhTIIzSwedJuwm5G2m5ZbtldU6rlpTXZXPArCJCwDOY/JzbI/Bj7SofbgoD5du4tjzGH9Q9fw4KnRc81yvWU2gAqtxc26KNgksJhb5BDgtlVmtoKg8X5MZB0x8B7l9pcgTtWNzIFJaIApNtl0L9M3A4oStmINUS+prkD6RacIWYEy4ySRS0qX5yKGV08PtfnRIzzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypbzghAUex81d+aU8eNRHfFHZts6VHCN/VbGthwe4lQ=;
 b=dm/0sMBKFE27OwNFLLVxhoXve0bs+O9rRYvW0GCj8+F4miM46Kghf01MppK8wYDJC4DWJ5Hl5WwUGmSvSfiI+PPVSCGbaPBzmCIRgtAp3De38zCeMfKc2hrGMp1T136NaDAH7JbqExFTM1UvmMCHjt9XNPvPsWAUQ+ccXBDdGMBFrom04z2DOsT8UKA/snXVrzel0Pecu0vGHsQvst4H3RjRXc9BTGkb3HqUm9vdgyh+gwDDJQAGOdz5abrpj/jBQQQU6osSnXmssUBSAeZUisXz6QhOlJjwqgZswgyqwtAKIQHSlP03ABzLbgcoKsqnBDVcjzE1SokmmLOTDOzfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypbzghAUex81d+aU8eNRHfFHZts6VHCN/VbGthwe4lQ=;
 b=sCoCvUVKBGiFBHYDzwiImb9xe75jv94oAqAdO5QkK0eqfGPPCgpOhw4SC6MdO3dpD9Y+FTULuAKOdZncKAUWFhwpQgTxQIc/A37TIZMhhDiBPf7n3736tmgTWBDrG4YmBUA5HaXqNwcEFz7pe9FVxnMAZf+DpidxXaq31Ce3cAw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8002.namprd04.prod.outlook.com (2603:10b6:610:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Mon, 28 Aug
 2023 10:36:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 10:36:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: map uncontinuous extent buffer pages into
 virtual address space
Thread-Topic: [PATCH 2/3] btrfs: map uncontinuous extent buffer pages into
 virtual address space
Thread-Index: AQHZ1lUQ+unF67DT/0iGrsiD2Obwi6//inGA
Date:   Mon, 28 Aug 2023 10:36:53 +0000
Message-ID: <a0b5e525-77f6-4017-8e1c-5ca968d8a60d@wdc.com>
References: <cover.1692858397.git.wqu@suse.com>
 <d68af5f6ddd6472ccef76db6f704d900945a53c0.1692858397.git.wqu@suse.com>
In-Reply-To: <d68af5f6ddd6472ccef76db6f704d900945a53c0.1692858397.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8002:EE_
x-ms-office365-filtering-correlation-id: cf0bf552-b2a7-4c01-4271-08dba7b2b242
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9mXkuXHh9KeIcfWgvg+UWM+tNP6M8c3B+9IXdtorxybg0qyyA5xOLtr1vqzhRfll32sc8xFLM39/+W5fYIAGLmkgBbkT1le1pHVaVXwe0lYhUgG2ltsD1vuWjf6BVNcIxHAggZwJwZ7TTU529YjhkVqcBHjyl/OSgfN0AS7hHorUx+jEg+hoi6HQqvnZQUUqT5Sm9CDVSI0BslO14e3o6hUG3KJpfYjVxPUW/pta2BnTbxBM6QKtx7kYjmuc4XMfk2jsY4ZnON9rk78ASYPtmWgTfoPtD6bT+0dRsT/3Jm9SWDrnXsA8kSj8B2AdY3q+iMWPXr4jsiuLGcfrQBi/70Pl5MPsv2/xkQCS4byR9vOnSCg0qjZCnh5w0PC219Ekaa5b0WcYe7ewa1tCH4o5qoOnL0tygmAiDnaehy+DFp90TsgYC/3g1xZOxHmJNEbYSJgNfikS1QaEHqK0rQBRSjjzA0mD47qeso2VF8jwTnGPM+1bR8FJDV1vYW+4PY0U5eAp9CTDmzQ8Ak9yUQARMLcT3f48UySXCjwbJupjf0AJ1DwUpauI5C0FIDYJ0VJzzN2YcfuhO6/zlZMuGKBM08jyvDDJXb0l4jr+vAqWxJWw8hTwsrhv4X+d1aAyakicF3YMbhFJyy9ZLs9XV0lzrUl/6RoPaPPbOCSSbPzLQKiEBE5QAQObuxy0BEtbt53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(1800799009)(186009)(451199024)(6512007)(6506007)(6486002)(71200400001)(53546011)(478600001)(2616005)(2906002)(26005)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(110136005)(8936002)(5660300002)(41300700001)(8676002)(36756003)(82960400001)(38070700005)(38100700002)(86362001)(31696002)(558084003)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnQ5ODJlM0ZaWUpEenI1dzcxM1hsT0Nkd2JGbVlvVUhSZ0QxcjVtbkhIKzBN?=
 =?utf-8?B?MFo3dElaMWczTmxQNUN5VEw2cUp4VEdocURjMHJDTktwQnFpbTFrall3K2kr?=
 =?utf-8?B?UnpIelcyZmRtK3FpZ1NVdUt3ZHVYYmxGSFh2a1dZOWlMQlgwVWRxaXVhU05z?=
 =?utf-8?B?VUMzd1pURkNGSFNmVHh4VXJEWWNuUjAvUDZpbXJUeTYxTnlYazVnV0VRR3pP?=
 =?utf-8?B?UlE4MGZ5VEJ1Ull0TkRsY2Q2aVhlSG9Ha1lQZU44aW9oRkhmMVBaT3JMcVpu?=
 =?utf-8?B?OWFQeXpQenZtMitQT0txSldEcmdiZU1KRzE5TzkzT2dQYjNOWFVQUlNTNVF6?=
 =?utf-8?B?NW94eUVJZG5Ha3pubUFhODhvWDRZTGJzcm9Mc2VjbUpoTFZlemR4N25aTDNW?=
 =?utf-8?B?SzMxMko0cFVuZTJRaDkwbXkxTCtwdWxFcVU2M09nOEUwVWp2eWRNRlZUMUlm?=
 =?utf-8?B?MW90clEvSDdEN2lXOTBYQy9hYjFSYmdoMDBpeVNrNGlVM1laNWJVVVVreUJP?=
 =?utf-8?B?eDlOK0hZQi9Kc0VFMjB1eW5LeVY4c2s5QkZUUFJHWDhickxBMnhLeTFYY2Mw?=
 =?utf-8?B?c2x5cTlMRmZMcWFJa0FqdWh1VXQrOWRaa2NoU1FidW9MY3ovUkJQRTladENP?=
 =?utf-8?B?L1NpbnVKTGYxUEYxZHJUc21hakdhQTU1RkpyNU4xM0R6WVc0Q0hpV1hRb2dF?=
 =?utf-8?B?aGRrOGFmNXpxRFo0eE1ZZng2VUVjUUpIUlJTa3V3dFRrc3RNVHowOWRxM0dJ?=
 =?utf-8?B?emVFQ3VEaCtNM3VWTDl0WnhtZnQybmd0aVpUM1ZHNGExKzluNmdQN0dtNWxG?=
 =?utf-8?B?MHdmU2hobW5YZFhZVHpncUl3WEI0NVNEem54RHdLTUtNdEQ1dGMvRmcxVWlZ?=
 =?utf-8?B?Qk1DTTc1ZVFDRXBDWUIzYVMwb2d2cVB0QlM2cHYvVHd0UVEwU1YyYWFra25C?=
 =?utf-8?B?TU9ESnQxcHJQWWRlZ05Mck5pV3M4VkZraUtxNXhxRWVPMHYxYUZyQTUrM21p?=
 =?utf-8?B?M256ZHVwMldVYVZjbzlEUVdJR3l0dWNZVFkvMzlrTldWdDFWUTBvWk5jNk5N?=
 =?utf-8?B?MHdoNzBEVjJVM0pWQllBTXV0R2xYZ0hSK3ByelYvbjJjWWUzcW1XUmxhTFUr?=
 =?utf-8?B?RWdTc0V2TXdwYUdwTVMzdXlzcnY1TmpPcndLaDg0YkhJdmxSQ3lMTm5sNS9s?=
 =?utf-8?B?WE1Zd3JqUDBicVlabmFpdDNYeFI0Z1dCcW5lQVJCczM0YWVSb1Yzajd4VGZz?=
 =?utf-8?B?M2Nkcmc5NDYrN21yeXhRSUZqZXhhVnR2d0ZURnUzaHR2cWEwRXluNHY1Z05I?=
 =?utf-8?B?TzZ0RHovTmp3bEhHNzBqMkM4WUpwcWxaVzlPODc2aUkyV1Ivb1pRR0FOOE90?=
 =?utf-8?B?ZUE1TEVPUDZYdk9GYk94SXhMdHZ1K0Q3cEJ1VkdhSnZtcngzd1d3YkhZaVRx?=
 =?utf-8?B?cVllbVVSbkNjWERJOWRxb2R4UHJBNnJ6Q0ROa1JlWXprWnBPb3pzVHF0b0du?=
 =?utf-8?B?V2tjMEFIK0lFMDc4NVpQYXo3dDFqdWFNSjZIeG1CUXpWcDRDdkhJVmg1NVdB?=
 =?utf-8?B?QURVN2hvQ0d2bGNSSGl1UytWVzZUaVh1VjlNVzZiWklCcVBnK2FxbmRLT09p?=
 =?utf-8?B?MUd3bzNvZCtjcFdodEdUWnp2N05nUERZT1V4THZRN1A5TmFrWTdrTVdtY0Nq?=
 =?utf-8?B?cXRtM2Q1cVRML2l0U2VXamx1T3RRTmZZMUwva1JYZkdFY0ZUUnZ3ayt5Rnd0?=
 =?utf-8?B?U1AwOHU0VCtWT05wSTZ5b3FJRzFDbEdCa1dJNnhSekc5SCtqV2FLNGttWk5Z?=
 =?utf-8?B?UHFkMmlGb1ZmUSt0ZUw3c25FcmZMMUFOcGtBMit0alBuMHJxd09HbGpBcUFJ?=
 =?utf-8?B?djVnNnVjTE1Eb2grN2EyVThhTC9kOUhsdml3N2daRlBHeWorWlJkWEZkRmt0?=
 =?utf-8?B?Z0JVbGptaW0xVk56MW5Fb01jWTRUem9RMEtmU1FpT0FIU01aR0tWVG53dDM1?=
 =?utf-8?B?clIvVlh5VU4rYVJEN0tFTkgxOTBkQWxVNHZyMUdjdCtzalYrWUtXTUdpNm5z?=
 =?utf-8?B?L3ljelJwM1VTRVN3MmFOYTNKUy9SMVJWNGVaL2RLZ28vUXlob1MwUnZpVlZl?=
 =?utf-8?B?ellzWHFUSnFiUHIvd3c5aEFtU2pxRnBMc3FoVnZoSU5vd2dKbXIrbEdBTlcr?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65868039020BB74AB188317E4E99C900@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E/k4NPB+8kwASFTTty0wGuMm1bUcdiFtLoPL3wsLCy1DqpRNqH03jCpdG7sfSwE3dONeil14q2WcoxIxSyHdapI+LuQEfzQTFw2M3MBMLpSV/+msQVlgQ/yNDANG7jjSznC82BMfY4+TPFfOEqlOXbE1bAnO2Od/gy7J0c3R/fu/Fii5of7Lqk9eMAdLY9sYhsixv6zzyLNwK82S59j8U49c08FOMxYJnjdLzncf2NMObz1lnFUVuFEaLJWVQHaYgNEEIECqZYqhfs7vquP9WDaVS0EdmSUiZx8jC4GQaMKc/9Ewiaz49rL4xyAlPBZ5QmCzzI8nDhlshJm3kj2a5RPa871EB9hAMcJTSnEyEZzpQtw10JEBAbjj3jYpTQBCrfeUCjzpCLl7ve15PiSLpMTXUUfU2cFzUHr/v1aNw5/pyk+JazQoLFZCAfI4jXPTvgsm8gFI/WYA3fQnEGiMukQygrIZ2ryAAIofAwYOpH2b/JSvzUrcguzfyIEa76riDjCA7O/p/SxuieKG2kn2DK06c+AoTrmWTIVYoe4jCTueb6AU59t5JmdfdAEUkOPzYuh1qZf3uGfk5vjwb2V0ftCmy8xBCerxOz47e6dzO59f+pGMyM50bqAFiVWwf/3ow+flaZmfWOBM1/bVH98MkThfd6dIRMJLH9C/ihkufMGdqdHMNgQX0rcPmNT+PrZiCadYi1TVUefEAJIiZ5Ulj2v4iXhgEd17hXUj8R1eJhZDlnBHVw94MBk0sOUQIXI+01FMWImKjJ5tcDKDwQhc42Xsa0QSoHHLvcpyUV8E+DcJsjfaPdrHGQWXlZRH4FNr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0bf552-b2a7-4c01-4271-08dba7b2b242
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 10:36:53.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpcIINRAEdglujv1VJAqc0VZMs9hm2ofVZsOpEI+i42FClqQKkj3izxzpm6UApwfUAeIYFoAqZKD+nrwMAh1opDdHvJ95r+BiCWRWwsEERY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8002
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDguMjMgMDg6MzQsIFF1IFdlbnJ1byB3cm90ZToNCj4gKwkJZG8gew0KPiArCQkJbmV3
LT52YWRkciA9IHZtX21hcF9yYW0obmV3LT5wYWdlcywgbnVtX3BhZ2VzLCAtMSk7DQoNCg0KUGxl
YXNlIHVzZSBOVU1BX05PX05PREUgaW5zdGVhZCBvZiAtMS4gVGhpcyBtYWtlcyBpdCBlYXNpZXIg
dG8gcmVhZC4NCg==
