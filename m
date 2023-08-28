Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7878AE73
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjH1LHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjH1LGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:06:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB20AB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220789; x=1724756789;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=Tzyi1UEUAi7me6TWROcwJg/5pTcg/75eeTs17q6A9adoZpmKoXEWUwVg
   8IFu3iH1QGnMBg63ugf6qpd1nxD47HJJr1l9KXFWy11L/z99PPv+FDiWA
   HLlFmf8s6oNZTa+3LEZzbD7CLD3A/sFsthD7e1pjSWwtu5qF58u0rEB4w
   gYsqOX9wAgx4aPxe3KrQdZ97WTT7V+rFSZdc0ZkiMUNxdrnB2URviTOP5
   TPrLt0Q0+78quCdhTk4ZciNB7igej2i3kKjveH+X15uyooBUn82Q34Wiv
   nHgrzNlngC7VIeV6WE1eRyes+k09aS6w90X1kGaCZVFhGE/DlR28+SSx8
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="354348435"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:06:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxcnTYjKgbLv62UjumHk0yPoBTpzM/cpTtu4hrYOIU7pWvaIq7xIq35ph6Sr8p0DaRE2DgcvDAnQVEdpla7SjcGSRjiTvLPRwtjmDwWVHKw7A6Sx+AMCdwoKjDxizWkO9PMmGEqV4BfeEikjV1x+Co/8Kz0SzPWfNAU53fk3rQUWcWAHgXcVJtmEu9gH4PvcpCiiecX4OIDOJhQSgat7YbLlqUzbw5YqTVeHpvUjbxK+oz/bu1QfeYD82PKzp5rPk7lC3z67lCicuQNhGezClTloBjk/OARpj7zeBS1MeJi8+1WD2ZAlFTPx2FbnaW4zrmnoCaPrl7BVBpfRLyjq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=Eguw0o8J4IZTdVL4Id/uBQYtmML5mPZlYaktQk47UguEc94jhuMO2yMInBH1mc9/zCzGFASvPUB68reIvd8rSAI8JrELcrsX8YVAdWApBHiDO3InpPLumhWReox3dIGezDYZzUi9jcBZTRH0ASJA87AGYdsuybbEGBdxjQuhae8E2hNSN1/Eeq0ALUGaMY8dw7ZpFIj0Q9oP5DtyMk9cCUvbGAVAYczb8cDU8s0crrf/gdbYxKVYF8JWxP2AFhU0L8MRJrMkTfS6IOFPcaaznxXGme3HtZgOZuVACF8XZyB2vRYhtq+eGbbu2I+374zd1B9xEPwlRs0B/YU3Wz0qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=rTJbRk0F4g5/lDSFcXhs0cnPhUQXHRSp0feZ61lJ7/SBo3FXGv6EbxlwGYEYK/uCbIhmcsZOKJ0BFsxYa5wqQPfEGWxjRPYb2JfZMfQVr/clKwQWdo0n3LTPQDuqpZKZbqrJGaNM7WBbkyT8NMkWVnTIu8pdv0mn7fq1RlQtC/k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 11:06:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:06:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 09/11] btrfs: add btrfs_delayed_ref_head declaration to
 extent-tree.h
Thread-Topic: [PATCH 09/11] btrfs: add btrfs_delayed_ref_head declaration to
 extent-tree.h
Thread-Index: AQHZ1ckDgwaiCctxkkW6NoQOgG+GV6//k8+A
Date:   Mon, 28 Aug 2023 11:06:27 +0000
Message-ID: <5836620c-f4c9-4705-8c9d-8587239510bd@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <a1a8c85cf3ee5c7664bff1922fec323e37850607.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <a1a8c85cf3ee5c7664bff1922fec323e37850607.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: eb23f746-6be3-4eb2-8589-08dba7b6d375
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSXMI9R8y4+oT3q7d2gBPSrkzefNj1TiJDoPhjEvcfpnKiidUfXiNH5rwUyzwFXauMhjFIUFgd5J4Fnavq5TeKm6c3TexBXnbphNkxQmr2bfhrXgaQuLsAeDER+TpW1mhlPtoiOw8gXRQHa92SpdaxUf76bgDPi+xuIOju1ltXb8WKo1TkUP74onfhXuKyzK/Q5CzaYO47nTXpBJCdYZTrTeOW3BCVgDZPmj/WqOVfavWMtTEZkun6u1M/5rsp2VSGwCwxFahYAHedCZS1coWBf3YY0JVyvi2/sUg5ABiFuVpFQ9zqQzLDy9nQOWao1DetRdR8CHRkOA2yUsROyqAcgPBrj/xDJxI+EYSxiDcFw8qJP1Az7BeCbx9SxiHyzqPYCAVj2qP8rRmkJzGaAz0wcSQmuzc+4CwHCLkPtHvdbpB0VRrqIceUQ6CP6Hf7gb7iZ45yGik9WzqOuc5yXMJ/BQyBj39ySgePxJQH5VIKxfkPp9yWTg8t/AQeA/kB+hpnPpSE+j/AaifuXl9UeMw8VeFogXd1pauj/f8PUiQ0VcfLb4l9NH7qfHJ8kg19Iwbir0MZ3CCtvVudDDwc4K28z07pCG262z6zkNvFr9fYYb2mTnv5tP26qkuYB4u/4FNfogwMS8CJqcBAevpXM1wzhfWJekdefy2MuGCqj6ExscvP4FsX8x6Wdp3bdU2b91
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(5660300002)(31686004)(41300700001)(26005)(6486002)(6506007)(2616005)(6512007)(4270600006)(38070700005)(122000001)(38100700002)(82960400001)(478600001)(19618925003)(71200400001)(558084003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDFoakszZzdZVmROM1Z3ZHJZbDh4c2psTjFaeEhkRnNuTUJLcHJmS0JtNS92?=
 =?utf-8?B?MEJWblZQdUZBelhHWHgrc0Z4OVZyY3lDTmNidlZ0Z29nRkFyZWkvTlg5WjVm?=
 =?utf-8?B?SFNPUEJjNWJYVnc0WnBBV2JuU0lIdkE0ZnlrcFBiRjkzcUlITHhvTnkvSkpy?=
 =?utf-8?B?L2NMRG9NdVRWMjdRU1hXakx2MmlOZkJ5cEdFM01EOFJqWXRxbG5mZkVMQTlP?=
 =?utf-8?B?R1V2c3EyYVFpKzArbmlXYk9kRDBEVTYzR3hiV3U2aEp3c3dUU2R1M0VUY2p3?=
 =?utf-8?B?dHBaQ0VjdFhienFYWld1bHhvZXgwZlZGanFaQklMTmJONFYrV2hDdURKWFdM?=
 =?utf-8?B?aUxDTkw5eXlXTGFEb3hYSnpmY3BpNk1xekpDYm9jZ2IxOGFmZzdwdzdsS2NI?=
 =?utf-8?B?dUhvbDgrY3REbGJ2dDdpL0F0WG1qTzZEYk00RUxlMmhteDNBOTFFRUVkd0xh?=
 =?utf-8?B?OFZ2UDFxakRINFFtL1pwR0c5elVrMVpFcFNESHA4amNibVZtdTlkZ0lnNEh1?=
 =?utf-8?B?VWZoaDlkSjN2Ry9CRk84UzhLWjRMbVBLWFpQUGk2d3UyU09XcGwzYk1zWE0x?=
 =?utf-8?B?ZS9KalIrYmhFRng2ZjVYNmVMWmhjdFlBczVzYm1SK21rTHBWd2xiZzdMMC9S?=
 =?utf-8?B?eU1EVndmU05yaHZNOTkyVUNDcS9zK2lnblNsbkJtK2t3dzlUc2tvWjBjRDYw?=
 =?utf-8?B?VHUrVVd6S2I1Z1JOTTBZV0ptNGlOakplaG9IRkVnMmgraFIrTC9OUDdaRmp2?=
 =?utf-8?B?aTBPZUhkOGxuYVlqaityUjJVUnpMTmZBZGxaWmM5cnFjS0pIcXQyalJmak0x?=
 =?utf-8?B?WTVpam5VZTM1d0U2Q2E2WjVkTmFsR2IwaTZhb3VPQUgxbW5tdlVqWmFUY3Zi?=
 =?utf-8?B?Y1p1Z0hEcDREWjBpQ3NkUWZaUFpOelFvTFlmSUM4WWNEVXMxUTFSaTQwc0Jn?=
 =?utf-8?B?b2IyNGFvMmpBL1pGZVF6WDE3RTk5UmFQRjk4UTUvUTlaM1lZMUZDUC91bnRl?=
 =?utf-8?B?N0FYbnZ5Vnlwc3ptNWdyaHZ1ejkxajY4SzM3N1Z4VGIzM004N1c0WFBoWkVx?=
 =?utf-8?B?NGkrQ2hiVXBkelRINFFXYkM2QW5VcXhmSFNSd0VrZTNYUzB6c3VBNkg3V0ox?=
 =?utf-8?B?dDNyNEY1WDNnYjBveWwrajZSemtkSC8zU2dRZUw5c0ZJSVlxcVhnU2Q0dm5E?=
 =?utf-8?B?dWxCYjdJUk82VkpMTDNBTkcraHF4N2JVWWYveG5HaHpsb1k0QUVSM3VzRW5y?=
 =?utf-8?B?azRRMUM4M3l4OGZzSmRlREh2ckJsSS9VZ29mZW9rMVE1eXBEQ0VWRk9udVNs?=
 =?utf-8?B?aGpEWGo5clo0YXExblllMGEwTWZlRTVSQjc2R1AwTjRYMzc5WnhkelF1RXZl?=
 =?utf-8?B?eVc1K0liSVl4clRLTG5BUDY5U3UyQUxKdzdxaXdxbk1rbkhuMDZSNUJPQkVU?=
 =?utf-8?B?VXFQSzVybkhxTHYzSTNyVkdnRjBOVWV0OVRrNFdJUE04T2xqaE5RYXBzdUxH?=
 =?utf-8?B?TXhZSWRxV3k4WHZsNDFjNWNpK090NGRwQ1huSG0ySGdTcDVqS00rMnhWQS9u?=
 =?utf-8?B?enRiUTR0VFBQeEtuUjFHZzRsK29nb2FHcWFDSjFkQ0d0THhsSkdvVkdyNkVZ?=
 =?utf-8?B?K3JIRU9iUGxNNmU0NFk2aHQ0TUJ1MlcvOVdRbFJjRkFvcWVPeG9UbTN3dnB3?=
 =?utf-8?B?cTJLd0pmRk1XVUdCSGlsZFk5U3ZwS3ZSeGkzb0tPZ0plR0diR2JzaUg2TUNZ?=
 =?utf-8?B?S0Q0NExTUFJqYkluK2tZc0NPUzl4RUhLRHl2TER3M2hGRDZJWEVHejBXVFcx?=
 =?utf-8?B?RHl4NENLa2tXSUx0dFNqdTV1bnFNRmtETGUxUXYxMDBQS2phTHdyZElpSnhB?=
 =?utf-8?B?UWxJL29zczhScDNCUGZMQnpRMzV0cEt6ZFFldlE1QjV3Y1BObjMrZ2lGN3Nn?=
 =?utf-8?B?aW85ZjJPbnJWbTBVTlFxSHZ1dHJsOTJ4WVJQVmpiRW54ZE4wM3NkYjBCSDQ0?=
 =?utf-8?B?UDF4bjlXeDlickphSDE0elcrazJOSGs0ajNJQ0o3RXFFTVUyV0ppUWxubGtM?=
 =?utf-8?B?RE5sV2t1NUhkejVJR0Z4OEV1cVNhZGRETUo1OEUvNXFtK3RJVUhZbVBYWGF0?=
 =?utf-8?B?ZW1saVFZR0l4VHlLVjFTMXdMZUVVdDdyM0FwZ3FPOW5Ub1hOZW43anlHV1FD?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B05511B13AC17047BE51E526FEF7D8A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fgpbxvCS/I4oEPbFl56akUbmSQvOdx3Xn/zyeEyaWfJEKwsr+YJcWw6hehWCb9oeDLw9mwbfFcHrcpKeGttyB5LYLtAZ/2ydUpKh8rPYEX4EJEB9xDPkoI76/QWdFwVGs98AnPz2rT78mQ/kgf6EN7dSK3TOmDg5KGpBK98sQzNUSVCZaXZK6ER7rgi4iKb0nke5CuSqY5bLHYGNfH7EANH3VGvOIp9THTOCLDd5MkSjz1VpDZwW8UXXKFZ3oeMExL3Vc8dpYq3TfQ4akCriLswWBwo4igSFQJHn+GTAIANCN5g5KkAt9++q0lL+kVHxe3ykQxT5TN1cthcp4l5gSY8K4ThFXf1wHzqiKkS07maW+WBw0s6yA5UaEX2PxXgnZ8S7MUJS5DCUzcy+X2RacP9L8/3gz0vwR08VLQZo4bStphM35zhk82IBFHyg/Hq6+Puc8o43sMd1FKLaCokK+eLYyqbdvnjjFN60Q2OOcgmZhJf3dAzQpR8I/Apzd2t1hjmMaRg9I68bPeiwOPqBWgjjcGkE2PvsRolRCpYtTthoC+0Eeyei10TLHSXdryF2QfxDfegY5XTa9TTF4ujL7sVzaBFkY+kEo5webPmruwicKYt6q76danJTWfsag/3OcqA98L7Ti6vLXyjgHNtHJw1kiVqaI8TCARhbKOgd86HrNXbz8mL1TAvZhdoTFBTqZGr+eZfaHVBMxby6MpCz5I8vYmjqxq4AV7Hmk+/Ht8tzrvz0rQQrYBX3DS+eIcwiAu+RpLGPiwEO+2smZjdgkAlbVAXNLZyFwlCNJRQYieTwqVZvsi5gwom1UyE/et9XKy7ym6DW4XIIUVdtAwOX8Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb23f746-6be3-4eb2-8589-08dba7b6d375
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:06:27.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDxM6/UPFuXm3dnEtjcyBI0Qowh8NK1pbQKuDd/LfimUotfYKTp1SmRq5ocTsO1T+5jVqaLhsacM8Wfq1rBrPyOYQm3HJcfq9KzLFbc/gYA=
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
