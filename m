Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701A649E6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiLLMHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 07:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiLLMHj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 07:07:39 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7362A1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670846858; x=1702382858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=BqWTqndKobokLtDstRA68ZtVow87GSpwv+gBENmIQ2AneaS6gJpdyo6q
   tfNQgODuMakcQxJhge/nbYcPmsM1DC7m96tsh7dQmWEcHZBQwYbJYd2rT
   pDt1xOuXNORTD/Tjc/eLMch0k2/BBaRhymIDhgduxbzaKxxff4DZMM+BB
   Tp972toWmHt+umIlB3oSbVhv/xo3iNgCUPRH/umAF1zYoPjPKPAqHoiok
   XQyVTlpI971celAFC81SeyqILi6vpPBAj9L73YePthNivvh7uh8tY/pjc
   4MM1bPQUs4W1BHkcyUvi76vHpkXQ5+GQCNrlrTLactASPougq7gAwrxcw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665417600"; 
   d="scan'208";a="218438486"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 20:07:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg39gBcpVhA2MAA9aV0LOq2Ygbk95xM1bmlIFemEadmeVSSz/vVV7lbuxB4H/BQiOVmY9YHSCqLTk2puK9BRqHrhHOff8mrT5mHNefNutZ+LtQPSz72AbqU1H0/Zyt0xBBYxcaVBhtNqFvvNy6Xnry3VuvGc9sRV/Rz1kna9BmVoVVX3Q8OSmlh0p2mjQpqS+mJ2RFjQCiMwm7qA0n5iHvP1Lh3yO+ALx2pxakOC0aoXtGi7ldBLoI0z4c2TraUFUp6zUAP+aCZ9DUjiaRFejygunDfPVSP9Vg4wDq6FnT5TiT3KEHQkwhnc3P0loXUepdJkpdnNvE/vgCYT8dV+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CIjQg4AX/87U3OaiBLEIVuapKH8vmH8CtLaO2XOWwwlI9vzP2WewovztaiJqQuVITizJThTwUac/b95D/a5PnQvoUUXRN8ZjyOd7OA7wftw0NjkxRT1CQ3HA/BI08iY6keTz30CoLXn5vsYauM3ouIttA4ksG9g/B7pQxKbtln5d4xsgBh3I8CoTylkEMmECW0xi21bX7fDGdQFvwxw0tZiKXO3sL4H2lCmYKk6a5JJA/d2FGX0wm8XwXNEIS8LKJoj5O0TTRE0CgqedmiNo7FW5zxDCuMHNedyjibwuD1etbRrEI+m1eIcw0UrQsU1rPUzVHIdA6ssXYBbeNmK4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AsYwNYkcsYzqkXRylJMYdDSJIMs3xarUmV7HaEJjzQQXq3jTsfhY+gdVkFTe0DYJvCCqxBCtQNAfwL4SWRaAuajsauHh0EIHQucUYtdWqrPtZtPgLaTElyzVYD3ZZNmx+mHVoa4T6mzO7vwkOU3trk0XtxgLTQsT6+l9sUDLgMM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0819.namprd04.prod.outlook.com (2603:10b6:404:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:07:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 12:07:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove the wait argument to
 btrfs_start_ordered_extent
Thread-Topic: [PATCH] btrfs: remove the wait argument to
 btrfs_start_ordered_extent
Thread-Index: AQHZDfkstVPa7C5NR0ijgJ00Qz+J8q5qKLGA
Date:   Mon, 12 Dec 2022 12:07:35 +0000
Message-ID: <4b3882dc-abac-e314-95ac-32d07a7a25e1@wdc.com>
References: <20221212071243.7418-1-hch@lst.de>
In-Reply-To: <20221212071243.7418-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0819:EE_
x-ms-office365-filtering-correlation-id: d5c9eaa0-e502-49d0-4e30-08dadc3974df
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MSlu+iz1ObZTpwzjCFPlvsSAHn60TlBZahDhmMnpQe2r+hcg3GBT/2QZ4X+35qt1L+0NBixUviPp6UQVn5pJMNAAox+/L+yAxf16DRXSk86BXVKDZ7CbnaDKpjQrQlzCFiNtPIasy6Eu5FjY95sJ4LIGqo5qjmveg1fndBKWcWSdDmetuVoufN4Z9rCjIItcBDgGRzvUjW6pN6afavlOdJTF+wUweIVFCsu5EU5L6w8lC3S6I0Ypog3vZZEHCoBdZvqN8xkB/TlnfYXpFBmLy8eIAeFPy2s15l5ohdn9Pth8pBx9U/b9Rvt23j/NtJ68yjP/+q5BsdR65KxKTkE3lAhxAHYcKnaXWicpn+RS9hW4weBLIDM91j2DgdY586pfJjgUGci7tXzqwE15yZ5FhW8vulNQBgyQLODX1+EWpnQsNOhz0r4go0HnBYUlzoHL34hojqZyH5rMI7xXjvG5eNfbRCqbw8Aa3iOa29bjAyVnV0vNuhozotQTMYLRBTUm82cxLc+EVmv+SNgxMq8OgkUeixqYTJu399Z8TzudY2QTh9CBcOhSwgeqKRAUnwXhlKn4NoYqDEhpRhlND4vQEX8IJQX6GOR1ZT6YBjIt6sH8/L3gVkAlsWiQrb4ToisscaOMeQi/FZbJthUjCF1FLBEwXt5GW7UXDb2o6MjUfKl0b6YEw9xDHv0PUTKCktg/WNH3u1ALIJVe+ICnQm4jCJLQKtlESEhGRqEzhhJQsnkwHkBFYPbNoWMq1Iib6dbiuKoYgz5Xsepl+Wjm73DZ3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(31686004)(71200400001)(478600001)(6486002)(558084003)(38070700005)(86362001)(31696002)(36756003)(122000001)(186003)(38100700002)(2616005)(66556008)(82960400001)(4326008)(8676002)(66946007)(64756008)(66446008)(66476007)(4270600006)(6506007)(6512007)(91956017)(41300700001)(316002)(76116006)(8936002)(2906002)(19618925003)(110136005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGs5ek5OYkRtcmhKK1NwTnBjcm9WZWdiZ1FnckU1TTlaNGtaT3ZudTMwalNn?=
 =?utf-8?B?SU45NVlIM1l0dEtzaUZsd2wrOTNjTUNQTWJ3U01aa0l2MjhKWWQyblRuL1c2?=
 =?utf-8?B?eThoQTloMmd3aGtRQWdpUktUanQ1bGI1N3hzNkZlYW4rTGRvYUp6anJQLzc1?=
 =?utf-8?B?THBud2NjM0dzL3FSQ0prNXc0bm9Tb0V2VXFqTXB3aThjY0htM2dsT2ViRXZa?=
 =?utf-8?B?dW9mUURQd010K0xiaGhlQ1dZTm5JdktNWXpzVGo0Vm1SbU9BZXFOTEh2YzVt?=
 =?utf-8?B?ZkN1VmVPeDJjdS9SN3dEczkrNEVHN2g0eTdZM21yQ1cyeHdaREhVbXpITUND?=
 =?utf-8?B?TW8zUC8xMUlzWGdTSmVNKzNaL2dNMGVyQzRxazVuSXFaTm5CSDVIZXVvRkhB?=
 =?utf-8?B?a2lnK0N3dG9aWGlzdmlqMjZNbHZkQUhxcjJHWGNOZDNTRUlFSGJyVkxkUHph?=
 =?utf-8?B?NFJJL3JodDFwUkU2bFJpbzZ3K0N4TklVZFZheGYwMkdrUlpuTkVvckdUZ1lN?=
 =?utf-8?B?Qk9pbk5iUS9ucm10OTFRVEtoM0J4ZHpxbWhUczBaOHlyUDkxWjhkakdrcjlG?=
 =?utf-8?B?RHFScGlhK1BWQXJwVTVOQ2h6MkxoVnVTdkJUOFdFK2RQcnJ3NExHMjZ6dDdx?=
 =?utf-8?B?cExrVTlVUUxieDRndVNiU0YzOVgzOE5TQkFjN2ZOTkJKd1h1bFJIUDNrbU1M?=
 =?utf-8?B?WWw5eTJOSUV6V0xLbzZhbGZLUlNDLzlCSXN3aEhhbWMxblJ6YUkvYXNQTmwr?=
 =?utf-8?B?RWRQOW5ZaVJiSTVzMy9jb3BzbHhNa2hubnI2NVdUT0MwVExFTnFreFdqY3Vm?=
 =?utf-8?B?eUZFWVVuQlM4OFhEaUVGdlJKc0hkeUxYY0JmVHVEQmZtdGZnTk1ydVp5R0xZ?=
 =?utf-8?B?aHBlc3ZPaDJ6WGJnQUtXWVJWT0lnclZ0Uy80NWRhV2tXYnJRaWZ5L1VPbWlt?=
 =?utf-8?B?WWx3RWlEcmtqcVJMQjk1ZG0rYUxpcTVUV3lIVUd3SkhjdlZES1FnY0w5LzZo?=
 =?utf-8?B?REE3WTkyL25uOWcyc2xoQ1VhbFczV3JBOC9qRXd5VXllalhnQ2QrMlpMcXRx?=
 =?utf-8?B?MzZmdExPUFNCUlpGNnJVYXhtQStvbzh1QlRmSkFneHJzbkNueWxTMVFFQmFW?=
 =?utf-8?B?YjFNMUlyZGFTcmFHUGxxdmF4WE5XdGFtS3ltUUxOcnEyNjlMdng1ZkM4TVBs?=
 =?utf-8?B?dUdGRGFjWjgyc1dFZEFsd2ptV3JiMjJ5b3VCc2lPeVd2bXJYbmJwbGtndWlz?=
 =?utf-8?B?SzZLU2p2Mm42TEZhMDF5S2RXWXViN0sxaG96aWNXTVcySXlJekI1QTNFK2Mz?=
 =?utf-8?B?K2xRWG0vU2dJYWFWdE0vSm1aZElHRkVIVEVHTndCUXZQMVZNc2t1cGZocnZT?=
 =?utf-8?B?bVdjUXZ2eFdab1Z4WkN6YjAvSUJaL1U5TW1ucHVyUk5OZ1Q2U0Z1bFVwMHNJ?=
 =?utf-8?B?RVhCUEdwMXYyRzZ6NGMvNWNIbitTRGhsZEk3M2dHR3cwMnhoQ2drOU5vdWNP?=
 =?utf-8?B?aFJGYmR2NnZjcnN4QkVoZXR5V1lKOElhZUJNODZETnZEOVRnamhjNWR6R240?=
 =?utf-8?B?aXhTdU44aUlQWEJsdHVJQm1zWHp4aFFzOFlNdnRmVVpCRWgrV3FFc2wyQ2k3?=
 =?utf-8?B?QnIzVm1ZdnBDOWFzRVBSRzlValVyREJ1S1hGYnh1OUtkclYyczFiRDJTVFA3?=
 =?utf-8?B?UUpyc05jOUdmS0Jyc3NDbXFHZjlvQzBFcUVlWVpoOWRydW5zWG9OSVJ5Yzdq?=
 =?utf-8?B?MHU1QTdjcmJTaUdSREZsbUtDMFZNVlB1VnBhc1gwSXQ2dk9lajFVUG9xK05P?=
 =?utf-8?B?YUxjNnMyM0xLZm1BeUdZU1MvT3JHdnVhNTdWNzJmeUpwQ2R2N1BjQkpmY1Iy?=
 =?utf-8?B?eU9IakFxSFNEdUtLcW43V1FnTlJDeDFrRVlsSktQaWVaVVVVeVhpY3lPTVdQ?=
 =?utf-8?B?eGZnT2MvOWxuV1kyTVZ3dVlaK0gyemUrUzdlQ2gxa29UbG9iaExLZk5HbFVB?=
 =?utf-8?B?ZXQ4QWh6THh4WmttWHkvRU51RVVaZXRUTUhBZ2Z4eVMrelZhNnpvS0NneGRB?=
 =?utf-8?B?K3c4L3JVejNLbkxWRVZ0ZHV4MVBTbnZQTCt2VStQWUlMZ05XcDNMd2t0djZC?=
 =?utf-8?B?R08vWmcycHRRRlpibXpsUWtGTHFaYWlsb3NJbHAwZ2t3bTJ6dEpnWXZLQ0hr?=
 =?utf-8?B?cTFQMzJkWU1rMnZYTEZXcGFkK0o2clduSTRXL3NLZFlpV3k0bWc0Umd3VmM3?=
 =?utf-8?Q?q0CZxkDf0A/IljVHdKWgNz+ni+RVNK4vfWG2V9hYbY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DED3FDF0F8F6D43A486A10B89BCCAD3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c9eaa0-e502-49d0-4e30-08dadc3974df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 12:07:35.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u9eH8P1YsJU4dQ2gPjWcrQ+vonA183GgAEfEluti2VUm3/krc5IaUurWGkd5MNj6h1QplFTvA1zSRXy7Rvg/0xy0AmEQIlXfIq63LB8XKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0819
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
