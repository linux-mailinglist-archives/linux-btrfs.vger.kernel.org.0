Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEC6D1983
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCaIMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjCaIMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 04:12:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59B35A1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680250351; x=1711786351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qK6Ne9arH0eWXskoeQy2/H+Jf9bzBnJzJchr/tBzELBwpLDuBiKZ/BfP
   wtWjQo+8s9Siy/yYBF2Hs6Rb41QVXX1JpecEczoU96UOQ+W16U4V64RYl
   mb+YEC8eq4T532+kMC5cW3hMuS2VY2JKy8StxDE1QT/U34wJ2aOMbLYmL
   ewYZHpr211X3dEWlbIp6JLOT64TRUDKWvCTX5GxuYySCLYHyhl3TAjdJ2
   vKB3ZDpkTKJuXJiITc6ehe2HLWLHXn+3Naf9fgzRNboV1EzbtpfjCenOV
   9pMZxRzLrv2s9Xc7MkVBF9AuE7VwuiuHDA84F+ITDqG5nHuMzifZkvZkf
   g==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="226781442"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 16:12:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD46kTtfpfuD1ZYhwgY0kLLg1cL5sF8Vhl7T+2MPfoqOfxtsvgmeBa4vlBXhnzkz3Oxi7gQUKzlmFd+81qO8q0BdpZ/g7dlkAsQtsiwCpS1qPYrsoXClJNxKSG0G6MIePP5D0TXpMiQLCDbxnSmWf4IOjdIzN35C4lQ8Yiys2/FVIBzrPYhAOoGnPgLGh134eSuFX+qYr9jUFfBpV/79Y16Dqi8BNgVspbR55KMvTIr6jnNhjE/9+6OS37JuLkGTDy8ORdNy9uWCbM4Dj5pdzLDCdXq37VFT3A231OhmfNvccJt8dx5aKmov78Ga2sj1oJcd+mjhuEWDm3v7JhkwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fxo2HuiiMXF/RDgC3an0PguwLzn+ICGZHlzZaDcufG0YZt2THJ+R53xR5cZRaH2rg9IW9YW5OgEboAcKN7BgVfnOXM7h3fj1oyTZOg4GCCbcMDVSdQyyIcT4EK0bPtiYDGr3/N82ThyaM4pnFtvCqbe3M0yFohHA3iakQOJisUAx8QtFfQCl4umAagYIvhGe6JQTLRJr0aiku3wJO1oHmYs6MKg8G+M4sdKuw3ppVsjIPNH7F9Dloipt0729ZVZeSOJ8EzuCOdziP8BJVarQptmY/gc5YCdutOVYjciSnrovMyynUPTrFlzFN2h5sJRiJDBxRWPsNNyaDMehPzcgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CL59dGxUGz2SboOjQLSp+q8PLnLvpNM97isHdFrYAhOavm6Uk5Qu+wMlP3ZFVvYuUV4HAm1tKiO8INaLf4FXDJkwcNyGNcnu42+hy37SOXyzW8jtQUZTFQ7fB0+ZhtOr01Pe9m3QsdcAdbdR2TVIpIegMYUldA2xJ4AtEcy95LE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6475.namprd04.prod.outlook.com (2603:10b6:5:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 08:12:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%6]) with mapi id 15.20.6254.020; Fri, 31 Mar 2023
 08:12:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v8 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Topic: [PATCH v8 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Index: AQHZY28EI1+7WeP/AkSNYv+meCNWQ68UijGA
Date:   Fri, 31 Mar 2023 08:12:28 +0000
Message-ID: <75a39bb7-dc82-0a2e-1058-76394df3113e@wdc.com>
References: <cover.1680225140.git.wqu@suse.com>
 <3d1f229744c0d6edfa3e6f54599b207471913376.1680225140.git.wqu@suse.com>
In-Reply-To: <3d1f229744c0d6edfa3e6f54599b207471913376.1680225140.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6475:EE_
x-ms-office365-filtering-correlation-id: 00f26420-52b5-40da-53c4-08db31bfab4b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AOUxIrv16Tk7vSpJ/GpKGZlNj7uYHvWHaqWvXCVPzDuWr3nUU3yfISfIFx3VJWqU3c+8/RE7WwJMCMGreXr+iH4zYLeqBUzvht2rmgZwaF5GejQevxejrK2RC0NbmaDUExTULQaWqL1yXZziw+ctUhx6K/V/juhTTI5R66rhe26reY0nLjuIboF5psU7v74LY9NEqNoaODpxxqP+lwk38iEOQ/mwuHmyasjFrNrgQddxU0g3snHuT1UM59QqSGuGbD59C+pBZA57nooscepn0kibhDoAZ66Z9H9XVNZhJ1mw+dEQ7FaUodQ3DqKdsQ5PSM4JFK/zEUXcUbIOKtxPtAwvfGm1OAWuF6bmN35xVkc0muIkrHZLdpQzqzpD0vbmH/76VOiTE+kYibhclfkuUI90KJ502g2qMQIwp8eW1j/4nGWdWOWrFs0sucyrcQlhnaN0/eze2M9StKwXHOBxV/quwnxG8tQczKf6vLGjh0zOx13O+p+iH9QfqntnNeXGmu0Aeaf0N4s+cqpM1neAqEg0hM72/43Avb6BM/kHFS2rqCwDR2gSCSh8cl3+MavWGWd2cRleXg8STzNa+RyORJpWzHXsh5otq0N3pxKZfd77agmHHVhVkb20b4wjAoUzGaC3TLxr7FwYZ7cspg5flrtlc+uqRz7/3o9KqN6mkgvaEkSYxBYEtT7OhGG4vAW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(2906002)(5660300002)(31686004)(19618925003)(8936002)(82960400001)(41300700001)(6486002)(4326008)(558084003)(76116006)(66446008)(91956017)(66476007)(64756008)(66946007)(8676002)(66556008)(4270600006)(110136005)(36756003)(54906003)(86362001)(122000001)(2616005)(31696002)(478600001)(71200400001)(38100700002)(26005)(316002)(186003)(38070700005)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlZWDE0a2pIaVdyL0RFbkR4bjNrb1VJYmVhL0JwWmRNeUl5RzRPUVEyOXQ5?=
 =?utf-8?B?RTAxNXhqS2pzcHJsVUJ2YXg1K05qMGIzazE0aHo0a1B5V0hZcGtvbmFsM1dV?=
 =?utf-8?B?dC9DT1NVd3p2bWdsNG1wWHJqL0t5QUVPdXhlQlBQVnZZYlVWUDlVYWtVRUk4?=
 =?utf-8?B?SXBlaGtMNFcwcDQ5bzZpa21OMGJmN3V5endJaXIxaFd2OTdsZFVEWDhGNlgy?=
 =?utf-8?B?ckpmcVVsQ0VYMDNkNDNsdlY2eVNpbUlDenNyV0lXTFdSbnE0OHRxRkxvVStJ?=
 =?utf-8?B?UjlyN25XU1RNNjRxRmdmaXRRcjFRZWh5bFlCWEIyeGl1dUFFOEpIKzFIWFJh?=
 =?utf-8?B?a0pSelkzMlNhTHg5bEx6Q1BpSzFSaVY2T0Z0SlBJNC9WWlJ1SE42eVVGQ0hv?=
 =?utf-8?B?NlRJbXBsSGhjWDVYWTdGcTZPUERWb3VYVW1hTnZDN0UzSVJqb3Z0ME5vbEVO?=
 =?utf-8?B?Mitpcm9yS0ZOWGc0Y0MyNkZ1WkJCNGNadEFuci9vWXhOZzE0aS8xNmd1ZUNJ?=
 =?utf-8?B?R1BIWjdwL05hUjlJcFJzYVdYamFuQkpIN0lHMzFHZTdVUTFXQ1NaL3A0VVNu?=
 =?utf-8?B?K2crYmF1NG1hb0N2SDFFdHlGWFA5dm9aWWpZOHhaMnArYm9ia2VuSnRxalRL?=
 =?utf-8?B?QVdCMTBxOEdhZXBVWFBpNmVINWp5cUd1S0dpQ2ZnNU12d0RRVE5Nc20zU1lq?=
 =?utf-8?B?NWhOZzlQSWszYVEvVlJzNjVpM3Zib0lVQlQrVTBhdXVveVdIZW9YYjVpelU3?=
 =?utf-8?B?Z2V5Y05DLzRYOVZDU1RJd2cwZmEzZjRhc1NPT3lxTDBxclpJTFBmVitqcmQ5?=
 =?utf-8?B?dnJraFlTYjhvSDRRWUxSVllqcjZlak9lUTVNRm9OaW5vSFFKY0pyeXNSeE1Y?=
 =?utf-8?B?aUJUY0RDSWVkQnBuNlNxd3hxZUhaRWE4OHdjeHJRc3laalRmcXptZWFVYjBU?=
 =?utf-8?B?c29JY1YxSEw2Z2N5dnV0QWlXY01BQXJ1ZlpMNGhUQTRHcFh3dktRNjJQKzB6?=
 =?utf-8?B?dUs1UlMzb0hLNmd6blkrOU10U3dzc05ZNkppL2RCamVqR29EZWRjcXlteHNW?=
 =?utf-8?B?WFRheEw2S0Jja0ZOTHU2Y3RxS3lCNk5iNm5lQ1c4VW96b3Q2K0w3NEdsL0hr?=
 =?utf-8?B?SGowbjNKYUlVczExeTRVTURMMlhBTXlOLzBkSWY1bDRhUGtJMEJoRWtubEFS?=
 =?utf-8?B?dDFnR0dHTWJFRFNGTDdqNlpwNEJRbW9Vc2p5R3htbmFhZXpWMXQ2WU1iUWNG?=
 =?utf-8?B?MUl3NmxaUk9lYXhHeXdLTDhtN2lZQ3o1UDI3aUZMYmRqV2FFWVAvTUF0djBX?=
 =?utf-8?B?ekptdWFXQXl5YlBWTkh6MmxvRjNocVRQN3R1amFyS0dHaGFKdXZlcXg4RW95?=
 =?utf-8?B?RytWTjRrZE15NU5hMlozeDRMQUo3bzB1bjFNSjhNR1JzRDdXMEFESWhpZStS?=
 =?utf-8?B?YnMzWlByanlSQ2x2aEVkcFpSeW0ydDBTb0I0bm5YZlROSE9pRTFpQ3ZMb1Bp?=
 =?utf-8?B?Y3FIRWlRU0VMY0d0a2ZGQ200V2lLcXVPL2dyTlFGZE1xL3VQSld6UUxrb1c5?=
 =?utf-8?B?OE5ZcTcyaGJncWZSMmNEYkdVbWI3d2JObTl6dTEzb21mZlExY2JXRzNxVm9h?=
 =?utf-8?B?cjNpR2p4RWxDbWY1YmhVYWQvOGtTMDdHZ2VTRDU2TUYwM25mWFdZYzd1bVJp?=
 =?utf-8?B?Rk9oY3R1NTlvZU9TdTFaYXVQWFVDRDJpcmhpS3JZeUI0MUVhNGZQeUgwbURL?=
 =?utf-8?B?aWV3TkRLZERsQWJzTUxNR3NnMEV3cnU3VWc1SDVGUTI1WnFyQW0vamdNUHBN?=
 =?utf-8?B?SEJoU0pUOTJlczBEQlFMM0dLc1NONUZKYWNRcTlXdkZONytscEdTVlVJQmJq?=
 =?utf-8?B?QklPUUpUbkZUTG1lNTRpZjEyN2RhOTdla0k3eml4RnQ3aTY2Q2pQMGlhSUNk?=
 =?utf-8?B?RUt5SkNBcHp0RUxQb21PWmxDalVtYTFEQnVuYjNiOC9Hcm4wTklQYTlXSVd1?=
 =?utf-8?B?MDZFOXJaNy95WTVaa0pxM2NmRTB2VGx4V29BemdKVFAzOWdsS2M5TjY0dG45?=
 =?utf-8?B?bUh1OVZ1Y0dIUmZEN3hXU3Vob2c1aDgyQ3RiL0tFSWlnRjE2d0d4QXR0L1pX?=
 =?utf-8?B?YU1BUTNETnNFeGZNa2VETnV1WHZmVnEzTzVOL0U4UzQyVUN3UnBCbkVTVkZi?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2D4802417BA8648B423E50AC723D1A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o9V+uvEw4y9skgCv6Qk9UR8a0DQ63wIyC9zXLEFVfJpKSNbbOOTUR8P9mi6r1X9wC8d9nkhTBTsA5mlIW6OiqwAjfud8GKTM1NrxMoXC+E5RUfjXMuQf4muMKGv1fm6h5/Uw/YQnBiMuQWpN/1ohp873ay54TKhK/pKlL76P1xZTAEUXhgvZZGk31NuhqHQh+EP17RDO5ljibObvGm4sVqeinLOgF7fxGgKLs2VS5Bn3lel2SiPmiNtoeE33Wqhx6D6OXTWQOYkHhBpNhtw253DGghUlCE6A2tg3Dh5a/+Px1tEtJTg98J8VK0cKZC90zY13TCkCosBJmK5wuCVA2XwLnVDegBIdjnGvITPgnjxFoznEivMP9/JZaCv/9MMxjJZpePI8xcMyVy/sStq6pH+ohGktViA8pbScPoaXfP/ZkEJXSu+ErS7ETHTxot7NXF4KEwZwc31gLk7e96wLbsOAdQ4OcBQcxd5xfRGTFJLfRwUSrGQ63YUG27bEmB24o1zEKslYka3SB8ajO56Owmf4yXVNEmBuRDzYR4HFJxCGxUC3oQhEHlNcmROf+VZ8w3SjFTLgJy2vPGTkMeMt9sC/l6Vj/P86e2cFZEpKN26DlrpVzZ800QLQFDQFkYJQtQ/421yGX/c/4HRyrHJ0UU3qYAV2k5CvWITlyrOtUhf8BFr4aXgWjjSR59YpO4ijya+O1c1Ad/xBzrC1p5mAFrwZ6rvtLV5vJqdNjkht49YbEAmRU4CGIT935JvSAwgGWOhHMQyRhtJrt6S9o6WjqcgWIaHuogMGPYu3BmRAIwNQES7ayzKisGAwXRDsbDDiojcDu8nZTXZuYUgOQWKMGHfUcPYl7iH+RxucP57r80A=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f26420-52b5-40da-53c4-08db31bfab4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 08:12:28.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDTRHrpOXYiqdJ2u4nyJG/IrXiE6Co9UuyEowOWt2swWP8IkE8ntEl0b9KL88I2Q7j1MYlTRYo28JZD9XV36vs8iJAX3yN6D8pjnaK7GMeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6475
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
