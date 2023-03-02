Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4C6A8177
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCBLpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 06:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCBLpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 06:45:53 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9725596
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677757552; x=1709293552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9/Qoh6ektDHWgw4rOz7QrL2XhaEVGdWI5L+Xuzn/q9c=;
  b=MMX92vbzuYMdalGcI660KbOcrFbbY5bCc4fp0aW/495nxF6MBCgIh8FA
   FFxaysbeZ0xoZEhmVZfsWUcaAvvXDJB1FA1sRPNU0QBLRnnk7xIN1Q1uP
   Z0K5oLQS+fa47xH2Z30omUjnHONoJcrnxyV6g+EwfpuJrtV3VUfepx9iq
   Pt2S0NvXDgw3NtoMa4rnSH6yuXw0YuGH8OVZrEujv2Ue72a/5wTqUES5w
   tkgkcqvFBlx9X8Up3x0AeQZku8vS8SijZ3R3uWvyV4kSbA6QbLcvJF/dx
   JJ7jEZhghqxor82+nfQzIgh8GPQbrkFTWf9S2/B2qMp8vUVDohJSIUS3O
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224623920"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 19:45:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvTVbS7pEgFWAaA+pmBNAjnBwzno8PXKW64C0z2VuQ9VohZS/v4CW5mgnsx9mtScJZIshrWTYEMup6MIX3Vf5cuD5WtxgGzF3zfsHfcvncaza2UqeYhQre2MjJCcQqry4gno/eAzYVA2ycmB5TKxsU+0Mid5MGEJPr4MBW3DsrY/I0IOagA4RjJ+NZX/oP3dr5xRT8HfepsY1binylra+0YFQw2hWJ/pKU9YjthdJpQ02J1fDX5el/RPSuQ2uhT5NYqtNAws5TGWToJaEvETHkFmzhE8y6wquRrYM/Nd5Wt+Vu5zkV9/DFeU71zHHupjcv4KXdOT1AFl3UeiCglRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Qoh6ektDHWgw4rOz7QrL2XhaEVGdWI5L+Xuzn/q9c=;
 b=bQzIZfour1SBtfRtUwKCv+O0ZYnBQEk2fWea2iC9Go4IdLADedMpw0htXVhJUF6HLn3Z/mbbmmwQtoJ7NAS/SECXogTwV9/GB1XmRsBLaLmmyTmRtCWZf2iysXLaP0KOaRBsGG7mUBsT5gW7W+po1zH27T5VIe1zmU9sXw6erJjUlX2PiqE4boMhwAWCsciTmiaJPPVLUZ/Jvh0kGnJ5NeanfyIWtKnEo7z9X/pakzdERfmpBqetZkESUobaFNT4syy6b3Q/B/Ej8eyeGErN8TDC/NoNjWolTbClYx9Kku52Eyunc+jMdE8VCgc1oYxTHashFyPhZjVBs+IxvmDxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Qoh6ektDHWgw4rOz7QrL2XhaEVGdWI5L+Xuzn/q9c=;
 b=w8QTI8MRIKzVeBeAVSpe1cqQw9OuZSm7LZIjI03RaxuhKvdMVHWXWmVKdtWP6WLD/ZtkbB5Epg3KpGpo6mmMtibwHOIVIRNNn4J97480h6Vbmk6B7m0jlRdsFIWhGgIJ1bQeB6H3LgcxyIoXlsmRdjhahXGKd7WZ2HqJMGYjL7g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5365.namprd04.prod.outlook.com (2603:10b6:a03:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 11:45:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 11:45:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWyAA==
Date:   Thu, 2 Mar 2023 11:45:44 +0000
Message-ID: <2648e7a4-271d-b49e-5ea6-6d3826f42f59@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
In-Reply-To: <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB5365:EE_
x-ms-office365-filtering-correlation-id: 29e11da5-29f8-4a97-de1b-08db1b13a89e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbJLLp0bGsREvJB8+tPKCdYnzWPqmTDvlkqgII04IZKh3+JFpZ/Sjf2qe/1s5QS8vU/ghHGq18dz8/1MVcmxyIYz3PbxoPF68Djr9BHCAXbY4LN13JtvMJU/mMSDZjoUsRJJ0XUFAxOk8CTnZypve9yQeD1CF4dyIa2hu/XcCJMnO+KlY05Hx5th9Fwn0O0q1y1XYokt+/05BQniXOXsdW9d/iGe4Gbx5Tku2Kt6w9YImfwNDt6o+Hn24RO4AKPIpEBha82860v4i7HwMLZ0QQgq5DXDdSibwkJpolbifiRw6jKj3zlI1eVsqZWLsTTcePv3CFMCopzf5IhqdQtRkmM2gC3VMBG2ToV59vCTHTqjafC38/awg37naDuVZm7OBz7odXx4whevVnbaIeiaqfIUArxsbSvMruvRV/Md9RHGPjkKyPEk5mow5zF9z9y+ZxYkC/KuKEkar3TUZivJLJsIWAd5fWCFxP6fILq4TqABsfcKRW0vogu7KsOtMD60bMX1Haq7r5Fa9ceiv0yo/e5m06m+GWtCJelASOFNYrDhlkBQrWWK+4iGm88pEejnGaqRXIu1EEwujjbvQehU3QIk7/CzeNElqv4dGF9YEldFnyyc3Nt0vR9VUfJGETBpaMTWhmUGnYGTDMe1blxnDvOIWdle7b2VUospbv41O75CBhb0b8x0oQJmc+A4wQEofwZAC3cZ2EPFOw1mNx5CrmZnmjrCg7JAAn4G+/JH/ZIsFYQJ51tTyrWyDAlJPdX8DdLrEPul7hTHkTWUY3GK2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(83380400001)(31686004)(36756003)(38100700002)(122000001)(5660300002)(71200400001)(82960400001)(478600001)(8936002)(86362001)(31696002)(38070700005)(186003)(6512007)(2616005)(6486002)(53546011)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(8676002)(76116006)(316002)(41300700001)(91956017)(4326008)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q250MVAwcDFmK3c1QURYN3BGSVg0NzBiSys2SUFadExHOFg1eVpSSkJ0dlYv?=
 =?utf-8?B?ZkZUcTdXaXZsZGJtaVdETlhndmxRcmhVdnRkaGEvM1RZalRNaktFUWVJbU1j?=
 =?utf-8?B?RTZYL045SlBBUGtMcDBEYlhVSVlsWW1yVW9TSDdsS3Z3N3JZdGNQZnNWdlR3?=
 =?utf-8?B?ZkozNlVGMFhHY0NpejZnQld5L0FXTHZEeHhFTEdKNjIyb2NGZ3R3bFlvdlFU?=
 =?utf-8?B?LzJaYnRuK0F3QUlDN1ZYQ25LWGNKTWVTeE42a1pQYVRER2IrN0hHMkZGOFlR?=
 =?utf-8?B?eFJHSUNhZmdveWdhNkFzYXRWeXVtcXJZS241MkVTempoV0ZxeDAyNGJVd0Jx?=
 =?utf-8?B?dHdvR2lUZ0hpR0NmeENFbllpaDVuWngyUU1BaGxUZ0YwVExUdElQbytob2ts?=
 =?utf-8?B?cU1KQXFwVGNXSE0va2Y1S1FZaDRMMUtYa0xjODUvRVBPWXZhN3NZNnJNYU96?=
 =?utf-8?B?b1hJcUdNZkxNTjhZbTZxZnltOTFvTWl2NzVEOXR4eDQ0ZWo0c2dhaGN6aVVq?=
 =?utf-8?B?OVU4TmdqaFhWVURWR3pUVDU3L1EzYXlTcVR2WThYMTQwMkc2Ujg3b0Q1dXhw?=
 =?utf-8?B?YVFhS2RjMDlBSEdncTVFQXRyMUExaFUySXVyQkFLS0IwRC9NSzVLM25rWEFR?=
 =?utf-8?B?SEgzYWtqY3FIbVB6ZDVJT05pem5KV3dTcHp4eFlkYURsSlF6SVYzaFNGazhV?=
 =?utf-8?B?TG42N2RDcUx4WE5vSkwzbXVSYmdISk1Bc2x3WHp3cm1iR0RzOEs3WmM1M01m?=
 =?utf-8?B?RjAwVTVtS3ZsbEZYTVdtSE5veWFlRG9oSUt1ZHQ1U2tlbnBXN3RzN3F2Mndj?=
 =?utf-8?B?b1VKemVHenF5cVVOR0g4QU1vQ2FHcmVVNFdVS2RaT21mazUzUStKM0p5R0cx?=
 =?utf-8?B?NG5TZUZKVzd5Yjc4d1g2UjQvMzVqT3B2SllVODkxS1B5Wlg4aVVlVFRVVkxn?=
 =?utf-8?B?amkvWnIra3M2M3dTUmZmbTc5Y09BSUlwdEhRempzSHQ3TWMyMERVUDdQbTkr?=
 =?utf-8?B?WDVERTdmZTE3OURMTmg5Z0lNc1IzVXl5Zzc2Uk1jaWxBUHJpZnN4TGlVNmdh?=
 =?utf-8?B?THFVS0VpTUxmU3l5K1VPME01UEd2NFlYM1gyVU13ZzVlTHhvS3AvR0RYUS9M?=
 =?utf-8?B?Vndvc3h4SlFlMG5ZalcxeFF0cnJrMWpEVHllbDVOeXV6b2RuQmxNK0NDS2hx?=
 =?utf-8?B?M0hBdCtKMUpMV0ltcEpVSTNyL1A5RWFFVDc2VGNRMHdZTGx2Yzc2THUyeFgw?=
 =?utf-8?B?Q01makhBU2VKU20vcUE1ZjM4SUV2MGlDR05lbDV1aE1PcVRYdWVDQ0RLOSsy?=
 =?utf-8?B?R1JtaTZLaVBrdWtONjArSjNVTzVzRkpGbVVIN3J5WDZ6UEp3NElsTlYxTEE2?=
 =?utf-8?B?WFExdmlSa21yYmlQTFUzcC9xaXFPNkdnMTlyNnRYTEdVVzJhY2l3aXV1Wkxx?=
 =?utf-8?B?N1ZYVDdVcTdwaEF6TU9lWUoyRUxtL25ybWpWRmtFM0J5bW1MUnpvREVCeWky?=
 =?utf-8?B?MXRPMHdoK3VlM1p0L2c5MmVPU1BMdDF5bU1vNWRIdnRHVlBJWDBVYzI4U0NR?=
 =?utf-8?B?em43V2R1U2dXamsyQStKMW5JQ1A0Q0U2aFE1THc0UDVCL210MWd2cEx6TGYz?=
 =?utf-8?B?d1VTdytoU1gxWEhDRGtpbVFqTy8rZFRPcjFjeFlpbkFZdW94R1RwQmg4eStu?=
 =?utf-8?B?cmkzVWhIZHNBeTBVNWhyR2NlSUExT29WMkhDNDc4b0d3NGNPZlB2aDd5c0pr?=
 =?utf-8?B?UjdkUFduTEFWSlBvTkV0dkFkZUFYeWhJd3c5c2M1YjFYY1BQazBDSGhQUjlR?=
 =?utf-8?B?UDdVcDdmQXkwSkZQWmdmRUJUaHJPcHJFWXk2WiszelpQa2pNL25Dd3dvM2lR?=
 =?utf-8?B?c3dZVEZzSmV5aGRKUjAwaFdwOHU0SGZNRU5wMFBXY2NOdVBQTGxpbnRpVFR6?=
 =?utf-8?B?UC9RRzR2a2lhRmZUYnVMK0c1ejAyelphNEpWdVd5cjJXaVFYejN2Y21PRm9R?=
 =?utf-8?B?VTE5cEo3V3pKZWRoN1N5Mnl5dW4xNzJVTm41ekZTT1l4bjdVRy95Z2J2R2NN?=
 =?utf-8?B?R3FqTklFeGQrc2lmQVVLNWhwOUd4MFl1cVBnYURHNlRCNlh6TDVTNldaTlpD?=
 =?utf-8?B?dThyTjFyZ3NZcTFwem9iOXk1UGlBMHFRMURjWU9vaUdIbFViUFlBNFllWXFr?=
 =?utf-8?B?TUd2YWRBN1d5WWh3RExRa0dqMzJSOVRYUzU4K3dGR2M5clViQVgvYmtpYWFa?=
 =?utf-8?B?TFJTM1VNcS93VHZyK0wrdHdLa3F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29327464C12EA49B1F1AF656B29336D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: URxc0dw0ZqmGG4w4n/+0B3StgBn4pPRHosIh5B4kF+bJYrMd3Mpd1kGkQ7e1nxTReGf58q66FsRgd2iuVb1s8tOPU1xbb+zaenzQQ8frtyXgy4X1ACdFm8/a4OWqUE2KD0xVZIDaw1PbugIbZ1MOpfdkNy+41ZLFyGyG5f1XECtc/Utv7jZ4o7e9YZbm3h5OTby/21Hxdtd95vNgr7JddlJtGWNMSyVJ+L5lQg1oCHPnCzVHKfipSM31XlmD1wZIrgzDwtJkIaPVtqaOg52gW3TQ8TIlPvJTM+Y+sZdLWTCP+8f4Ib6BDplLKmhxYYk0ki/nrMO/5VEVA8a17jmsRHo0cYVMfiiPlvOOFimCnyd0Uhl7134/nLFCSz9f/k2dNyAMr9uQNy3p9BUgQj0m91W8fc3RTR8LOorj2KORclgEROzLWPdCZ1fzsTDy77mdY3HzBVkQ/pqY39UxHHiDRB/iHZUg8w34GN6oNCM7HX1AvIslRRYaHm8HRIncmRvYrAmXD02UBD4jYC3+SELsrLN0ZI76sS/XsH1G+Rx9VyXIyw3I77JScanFolh8AqNROEH43JKID/mJooqn5v6DuCwJnAPO0kuW6CdglYBmgqbccJ6lm/NDUz74MF9YtI7HdGzHBPkUI4ysTioC0qrFfVxacS3LIZy3VdVR1SB1aXevXyUKU/EhUqOMA/Q/cHhn1m25i4N2QZaGGk1sh5iZ5DPds85gBdqJbY3jvQwu6GRECO0ftzyKjTRtry4fuOgtGG0947yM1/+elF0KG9aTELjgjJTIR2xsG78ttj+wVJwOS9v1xjBQ9IvjQbPAvSG8hWiglj+6PIApkSF8FG5ohd2n1zKtrgwNBbmlP5ZyZXWfgqN5VuInTyTqXefFLIgk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e11da5-29f8-4a97-de1b-08db1b13a89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 11:45:45.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOmKqiZCYDcu6UY68yEER56+zMCemv7hY8zt4ZyR0+SeiyZUnjLxnkIQWWqtSGOxvMfohr0wZZR8viHjy/l2+E3INVXFvq6AAhTA/kGx/Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5365
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMTI6MjUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEknbSBzdGls
bCBoYXZpbmcgdGhlIG9sZCBxdWVzdGlvbiwgd2hhdCB3b3VsZCBoYXBwZW4gaWYgdGhlIGRlbGF5
ZWQgDQo+PiB3b3JrbG9hZCBoYXBwZW4gYWZ0ZXIgdGhlIG9yZGVyZWQgZXh0ZW50IGZpbmlzaGVk
Pw0KPj4NCj4+IFNpbmNlIHdlIGNhbiBub3QgZW5zdXJlIHRoZSBvcmRlciBiZXR3ZWVuIHRoaXMg
UlNUIHVwZGF0ZSB3b3JrbG9hZCBhbmQgDQo+PiBmaW5pc2hfb3JkZXJlZF9pbygpLCB0aGVyZSBj
YW4gYmUgYW4gd2luZG93IHdoZXJlIHdlIGZpbmlzaCBvcmRlcmVkIGlvLCANCj4+IGFuZCB0aGVu
IHRoZSBwYWdlcyBnZXQgcmVsZWFzZWQgKGJ5IG1lbW9yeSBwcmVzc3VyZSksIHRoZW4gYSBuZXcg
cmVhZCANCj4+IGhhcHBlbiB0byB0aGUgcmFuZ2UsIHRoZW4gb3VyIFJTVCB3b3JrbG9hZCBoYXBw
ZW5lZC4NCj4+DQo+PiBJbiB0aGF0IGNhc2UsIHdlIHdvdWxkIGhhdmUgcmVhZCBmYWlsdXJlLg0K
Pj4NCj4+DQo+PiBUaHVzIEkgc3Ryb25nbHkgcmVjb21tZW5lZCB0byBkbyB0aGUgUlNUIHRyZWUg
dXBkYXRlIGluc2lkZSANCj4+IGZpbmlzaF9vcmRlcmVkX2lvKCkuDQo+Pg0KPj4gVGhpcyBoYXMg
c2V2ZXJhbCBhZHZhbnRhZ2VzOg0KPj4NCj4+IC0gV2UgZG9uJ3QgbmVlZCBpbi1tZW1vcnkgc3Ry
dWN0dXJlIGFzIGEgZ2FwIHN0b3BwZXINCj4+ICAgIFNpbmNlIHJlYWQgd291bGQgYmUgYmxvY2tl
ZCBpZiB0aGVyZSBpcyBhIHJ1bm5pbmcgb3JkZXJlZCBleHRlbnQsDQo+PiAgICB3ZSBkb24ndCBu
ZWVkIGFuIGluLW1lbW9yeSBSU1QgbWFwcGluZy4NCj4+DQo+PiAtIGZpbmlzaF9vcmRlcmVkX2lv
KCkgaXRzZWxmIGhhcyBhbGwgdGhlIHByb3BlciBjb250ZXh0IGZvciB0cmVlDQo+PiAgICB1cGRh
dGVzLg0KPj4gICAgQXMgdGhhdCdzIHRoZSBtYWluIGxvY2F0aW9uIHdlIHVwZGF0ZSB0aGUgc3Vi
dm9sdW1lIHRyZWUuDQo+IA0KPiBUaGUgZmlyc3QgdmVyc2lvbnMgb2YgdGhpcyBwYXRjaHNldCBk
aWQgZG8gdGhhdCBhbmQgdGhlbiB5b3UgYXNrZWQgbWUNCj4gdG8gY3JlYXRlIGFuIGluLW1lbW9y
eSBzdHJ1Y3R1cmUgYW5kIGRvIHRoZSB1cGRhdGUgYXQgZGVsYXllZCByZWYgdGltZS4NCj4gDQo+
IEhvdyBhYm91dCBhZGRpbmcgYSBjb21wbGV0aW9uLCBvciBzb21ldGhpbmcgbGlrZSBhIGF0b21p
Y190IA0KPiBvcmRlcmVkX3N0cmlwZXNfcGVuZGluZyBmb3IgdGhlIFJTVCB1cGRhdGVzIGFuZCBo
YXZlIA0KPiBmaW5pc2hfb3JkZXJlZF9pbygpIHdhaXRpbmcgZm9yIGl0Pw0KDQoNClNvbWV0aGlu
ZyBsaWtlIHRoZSBmb2xsb3dpbmcgKGNvbXBsZXRlbHkgdW50ZXN0ZWQpOg0KZGlmZiAtLWdpdCBh
L2ZzL2J0cmZzL2Jpby5jIGIvZnMvYnRyZnMvYmlvLmMNCmluZGV4IDJiMTc0ODY1ZDM0Ny4uZjk2
MTc3YTUwMWU0IDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvYmlvLmMNCisrKyBiL2ZzL2J0cmZzL2Jp
by5jDQpAQCAtMzkxLDYgKzM5MSw3IEBAIHN0YXRpYyB2b2lkIGJ0cmZzX29yaWdfd3JpdGVfZW5k
X2lvKHN0cnVjdCBiaW8gKmJpbykNCiANCiAJaWYgKGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBk
YXRlKGJpb2MtPmZzX2luZm8sIGJpb2MtPm1hcF90eXBlKSkgew0KIAkJSU5JVF9XT1JLKCZiYmlv
LT5lbmRfaW9fd29yaywgYnRyZnNfcmFpZF9zdHJpcGVfdXBkYXRlKTsNCisJCWJ0cmZzX2FkZF9v
cmRlcmVkX3N0cmlwZV9wZW5kaW5nKGJpb2MtPmZzX2luZm8pOw0KIAkJcXVldWVfd29yayhidHJm
c19lbmRfaW9fd3EoYmlvYy0+ZnNfaW5mbywgYmlvKSwNCiAJCQkmYmJpby0+ZW5kX2lvX3dvcmsp
Ow0KIAkJcmV0dXJuOw0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZz
L2Rpc2staW8uYw0KaW5kZXggYWJiZmQ3MWYyY2I2Li5mODhhNGM5MmMyNDggMTAwNjQ0DQotLS0g
YS9mcy9idHJmcy9kaXNrLWlvLmMNCisrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYw0KQEAgLTMwNDQs
NiArMzA0NCw4IEBAIHZvaWQgYnRyZnNfaW5pdF9mc19pbmZvKHN0cnVjdCBidHJmc19mc19pbmZv
ICpmc19pbmZvKQ0KIA0KIAlyd2xvY2tfaW5pdCgmZnNfaW5mby0+c3RyaXBlX3VwZGF0ZV9sb2Nr
KTsNCiAJZnNfaW5mby0+c3RyaXBlX3VwZGF0ZV90cmVlID0gUkJfUk9PVDsNCisJYXRvbWljX3Nl
dCgmZnNfaW5mby0+b3JkZXJlZF9zdHJpcGVzX3BlbmRpbmcsIDApOw0KKwlpbml0X3dhaXRxdWV1
ZV9oZWFkKCZmc19pbmZvLT5vcmRlcmVkX3N0cmlwZV93YWl0KTsNCiB9DQogDQogc3RhdGljIGlu
dCBpbml0X21vdW50X2ZzX2luZm8oc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZnMuaCBiL2ZzL2J0cmZz
L2ZzLmgNCmluZGV4IGRkMTUxNTM4ZDJiMS4uYWIyNTg3MzI2N2VhIDEwMDY0NA0KLS0tIGEvZnMv
YnRyZnMvZnMuaA0KKysrIGIvZnMvYnRyZnMvZnMuaA0KQEAgLTc5NCw2ICs3OTQsOCBAQCBzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyB7DQogDQogCXJ3bG9ja190IHN0cmlwZV91cGRhdGVfbG9jazsNCiAJ
c3RydWN0IHJiX3Jvb3Qgc3RyaXBlX3VwZGF0ZV90cmVlOw0KKwlhdG9taWNfdCBvcmRlcmVkX3N0
cmlwZXNfcGVuZGluZzsNCisJd2FpdF9xdWV1ZV9oZWFkX3Qgb3JkZXJlZF9zdHJpcGVfd2FpdDsN
CiANCiAjaWZkZWYgQ09ORklHX0JUUkZTX0ZTX1JFRl9WRVJJRlkNCiAJc3BpbmxvY2tfdCByZWZf
dmVyaWZ5X2xvY2s7DQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW5vZGUuYyBiL2ZzL2J0cmZzL2lu
b2RlLmMNCmluZGV4IGFhYTFkYjkwZTU4Yi4uYTg0ZTc5YWQ4NDBlIDEwMDY0NA0KLS0tIGEvZnMv
YnRyZnMvaW5vZGUuYw0KKysrIGIvZnMvYnRyZnMvaW5vZGUuYw0KQEAgLTMyMzAsNiArMzIzMCw5
IEBAIGludCBidHJmc19maW5pc2hfb3JkZXJlZF9pbyhzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9leHRl
bnQgKm9yZGVyZWRfZXh0ZW50KQ0KIAkJZ290byBvdXQ7DQogCX0NCiANCisJd2FpdF9ldmVudChm
c19pbmZvLT5vcmRlcmVkX3N0cmlwZV93YWl0LA0KKwkJICAgIWJ0cmZzX29yZGVyZWRfc3RyaXBl
c19wZW5kaW5nKGZzX2luZm8pKTsNCisNCiAJcmV0ID0gYWRkX3BlbmRpbmdfY3N1bXModHJhbnMs
ICZvcmRlcmVkX2V4dGVudC0+bGlzdCk7DQogCWlmIChyZXQpIHsNCiAJCWJ0cmZzX2Fib3J0X3Ry
YW5zYWN0aW9uKHRyYW5zLCByZXQpOw0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3JhaWQtc3RyaXBl
LXRyZWUuYyBiL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KaW5kZXggODc5OWE3YWJhZjM4
Li5lMDY0NTc3NzE5NzYgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMN
CisrKyBiL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KQEAgLTExMCw2ICsxMTAsNyBAQCBp
bnQgYnRyZnNfYWRkX29yZGVyZWRfc3RyaXBlKHN0cnVjdCBidHJmc19pb19jb250ZXh0ICpiaW9j
KQ0KIAkJcmJfcmVwbGFjZV9ub2RlKG5vZGUsICZzdHJpcGUtPnJiX25vZGUsDQogCQkJCSZmc19p
bmZvLT5zdHJpcGVfdXBkYXRlX3RyZWUpOw0KIAl9DQorCWF0b21pY19kZWMoJmZzX2luZm8tPm9y
ZGVyZWRfc3RyaXBlc19wZW5kaW5nKTsNCiAJd3JpdGVfdW5sb2NrKCZmc19pbmZvLT5zdHJpcGVf
dXBkYXRlX2xvY2spOw0KIA0KIAl0cmFjZV9idHJmc19vcmRlcmVkX3N0cmlwZV9hZGQoZnNfaW5m
bywgc3RyaXBlKTsNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmggYi9m
cy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmgNCmluZGV4IDM3MTQwOTM1MWQ2MC4uZWNjNjcxMjZl
ZDYyIDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5oDQorKysgYi9mcy9i
dHJmcy9yYWlkLXN0cmlwZS10cmVlLmgNCkBAIC04NCw0ICs4NCwxNSBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgYnRyZnNfZHJvcF9vcmRlcmVkX3N0cmlwZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbywNCiAJLyogb25jZSBmb3IgdGhlIHRyZWUgKi8NCiAJYnRyZnNfcHV0X29yZGVyZWRfc3Ry
aXBlKGZzX2luZm8sIHN0cmlwZSk7DQogfQ0KKw0KK3N0YXRpYyBpbmxpbmUgdm9pZCBidHJmc19h
ZGRfb3JkZXJlZF9zdHJpcGVfcGVuZGluZyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykN
Cit7DQorCWF0b21pY19pbmMoJmZzX2luZm8tPm9yZGVyZWRfc3RyaXBlc19wZW5kaW5nKTsNCit9
DQorDQorc3RhdGljIGlubGluZSBib29sIGJ0cmZzX29yZGVyZWRfc3RyaXBlc19wZW5kaW5nKHN0
cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0KK3sNCisJcmV0dXJuIGF0b21pY19yZWFkKCZm
c19pbmZvLT5vcmRlcmVkX3N0cmlwZXNfcGVuZGluZykgIT0gMDsNCit9DQorDQogI2VuZGlmDQoN
Cg0K
