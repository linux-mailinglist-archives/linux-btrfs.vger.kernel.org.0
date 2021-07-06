Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3433BD140
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhGFLhT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 07:37:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24565 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhGFLZu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 07:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625570590; x=1657106590;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mZviTHn8gTSvSg0QERPi7wTgoeXTWYBgu4T8xMKLAu4=;
  b=fEjMK6uErDps9LvOsZDrK0HeJ8RffeZ/lr2RYA/FuP8O1mRQsl/fqiyV
   oEImdWZ0/I36xBmtSL65NDayzaLrwaHXeVEc/ngh+Hn9/GrFkeoiwNckF
   LxtcuqN1gEb3ghiNdeHbhI6pA28WWyaa0aUuo+ez0W3XV6qjcVa+EVp2n
   w22QM9bQQxFGQu03LhBOs30JlW87nLxJMpHzNmoaJ/vaAJpTOPFPt50pm
   EVvywQZZ6FGesiXMIbybvToshBnzYqVie2afczGBfAB0U9yajJwoF1FkE
   BGm4ZlSL+IDOmzoqiArNe8HeBmUJHZo+w4qex0+GCEL6sTYLSmnUYD61S
   g==;
IronPort-SDR: 8oEWZVGNikuvRtQm5ApMbxe3DwdM9cBi3JwKiew5NI19O3v6Q8PKobUknejiEs8oUu+OyL20Qk
 rfnC68VJ4tIwfoa2tNoe7+eWVXdpvoXmun01IR3PkOmAhNhq6s/5Ma1PkQl1iNVyMfuMeMh8oo
 mYPavEkVW1iNTfGKVvPPvDCCzblmEKiEqjQviBgWjPM9eqozABjtVt4xlMKClRSNCUSqUyfKtU
 Q7fGXypyfMmP1AfE/YnITm81pMHxhrEPeKWGJams42CFPcsG9LVi1I4px4yO3B9uFEOq+vLZJA
 yIw=
X-IronPort-AV: E=Sophos;i="5.83,328,1616428800"; 
   d="scan'208";a="178612603"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2021 19:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvy19uyqYJXVQKHnpAe1sAweLtqlFDUUhaf6wBpFMyJoNurkb7QUi/4Tur3ppR3WGLd0KKwovkA14r5mSesFA/xooCZFVGH3jytKh0/HCl3uURKnn4N24NpWSPRjXvAD1HYMISG4LHInxkgquNXY6jDE73ThXEc2sfHDLqNne1EXZ4nM12XmqFI7Wfo2y0ocSLmdY0DcAvXA+mbWxU3rm9FIFspSQsYGO+YZF/H1OnUuJ1yAznvKcTJKj6wuztgbQh+hWvU1C5jwgU/o1mPyQ12I2v3CeJf6sTTAun2zDDXq9POzc56pKkVoFD/LTPocklBfYvfl1MunwbyYD3yfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZviTHn8gTSvSg0QERPi7wTgoeXTWYBgu4T8xMKLAu4=;
 b=ZCtDj7yRBqQj8visPYGWQCySUPy494xKap0miEmV3gidK+EHAAoW22ixBMHUZR3fiB1IB7wnCuKYiqbjUsGTNcLpJuOMzZx6OspPUEppRAHE0FkdyApBs6/bN6rFnIHZo6llVwDqCAfV+h80PQnd96GLlB0KmG8zxK3EemKnub2iIhpa7qDIxPLwCs5bjI948A/u7V1a6xzlIxvTlQUgzbOmfgABpXQWQbmW6CnPz5CXR+gSDa1MxHGHDbfq0MnA3+/Z9JQL1TgRo2TuO6xJBFSnDFLT85EvThXhihR3JwCMe8+w12kVidHtxCx5Ox/TwkWKHHjYQHTvTemerW7ZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZviTHn8gTSvSg0QERPi7wTgoeXTWYBgu4T8xMKLAu4=;
 b=bEaPhIddm84KZZ/0sSnPdQS8JM6dIYmVBpj12WsR1KwGflxQXw64n6of6Y5AKKLVp2cuLhvDZTpn7fibmWg3TRB10foPAbs9KoR8s8f8jToDp9Qwy54VFKIOO+MXkGmiltAkjToLPzBqMbSuhKC0CKaYGo2cg7pWggVT/wV9nHk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7398.namprd04.prod.outlook.com (2603:10b6:510:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 11:23:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 11:23:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't block if we can't acquire the reclaim lock
Thread-Topic: [PATCH] btrfs: don't block if we can't acquire the reclaim lock
Thread-Index: AQHXcbtm0xwIftoguEi03AuZEAgnQA==
Date:   Tue, 6 Jul 2021 11:23:07 +0000
Message-ID: <PH0PR04MB7416EFD996F6CEA7F49A692F9B1B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
 <d4665043-9d56-3616-1294-58a288936723@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11cd939-3798-4c9a-6847-08d940706dfb
x-ms-traffictypediagnostic: PH0PR04MB7398:
x-microsoft-antispam-prvs: <PH0PR04MB73983F4372FC13A0D277DDC89B1B9@PH0PR04MB7398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLDFbXFAbp/Y1OnkT/RIbzlS+mbIfPgdks+UqYMIHk8/vFgghLPzxq3Ml1kEKteErD3k9DMAulioFZoXlxA70cA5AQiwhSW/jnZFFedytjKizYbXMC8MkeLs5tjJMKIhkh/wdEL1uDCD4AGbwAru6A9umEiACQodzcEth77Hn0UDfj9uR4iXD6KPg0KHG2CwtabMAfUl2eMUjVhxpo6FpuCITFjjH41+YfeTZNeGiZ2YfT50QPl3j6UrTGfPTiWvP8zpwjFnEuJVc3NHLf0fq6j02QR2WO1C0hMUu2Z/0c88yojxJbMz5t0hWVx1BQ/aMcjWYaZBq/0q0lpmO3QIe6/Merqy1Dr9VKok5pGgg40AC8LiJnzg2pTDCNMNBxYPQnelkgomSyVgD+2ZClUB2Ca14lMrOsWC3w3/TnHMYqjxHnFgvoC0WpS6qJY4OZL4hsi5s7lPXWRrlfuP5E2t8trZ7pHUECqPWpGziAva/gGKnucESXO0ZvKAPzxJRaxi0s+GqnDgjTi4wRXYnqdbAdiIwfv0SZT5bVaPZ5FQxK6oMVXukgv6nX0SRSVrDGhB5Qc8x4IaKKHoEf2va1bXFtXxahZLlzPzjK5zGbQMWnShXFDNW6H3XQj23sSpXsbUOz8VdzQNLODhnqnqXLXLNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(66476007)(26005)(558084003)(186003)(122000001)(8936002)(6506007)(478600001)(64756008)(55016002)(38100700002)(66946007)(53546011)(9686003)(66446008)(71200400001)(33656002)(76116006)(83380400001)(110136005)(5660300002)(86362001)(66556008)(8676002)(7696005)(316002)(4326008)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?DF9Sr/R90+ZO8L3HS3x5il72WEeG8rwIkGt0DcSbKHtHS7gdKjFG9GTKUdqT+t?=
 =?koi8-r?Q?Epyvq/YLQ/YHmZlqXCbH56iIV4MNTdCLuzi0dbeyVd+8vJpr+JvPdqEBffiuff?=
 =?koi8-r?Q?csjE0v2vMLMMaXBFuInURzWw01dW9uFr834DYs6BO9wA+w3ZpDvaOoc82sfB/g?=
 =?koi8-r?Q?g7CAsXza+WzuNaZ2pGK7P4TTxDKs1A2/m35Gr4I8gqn9EB90BMjkrNuif832rv?=
 =?koi8-r?Q?UE1CxfHy1N9hdq/H7dNcaOKV0MvdgMNCNwNIDGLF7ey/NcKglZEQ1TS3rrQ3qk?=
 =?koi8-r?Q?RoVD4SDJ4Fpn3bov3as73hS/IUjl8spIABiTSIwE3itIEXfKMRhfqknTvLpOFp?=
 =?koi8-r?Q?Qge4VIldUcCFwgsl6rOPWNByDrrSMyZ2sKYku94OtMQ5f2OCKUoQWLW1EuOzS4?=
 =?koi8-r?Q?P/GPXmHih1v7Tj9zmj/wlNrhPcO+ykcrw2y0EnICge2V/UbaAwjLqxF7SOe2pt?=
 =?koi8-r?Q?IID9qOSWK7CfGlh72iTHlT+yBnKgDuId0k/PY6lE6tXYBuqtUPGpDqD5oQfxKC?=
 =?koi8-r?Q?9h+6G1FrKXcACBlGaCXKa7dD97rsEJu4duhvcjSW3W1OD/A6r0hXhgshz3NTkX?=
 =?koi8-r?Q?Q/PLJl5LeKsjRYFfpoZqBVlkPBVjheuJRcJcaQBo3g9JALLCKpJVG4RVvJV/bC?=
 =?koi8-r?Q?6VHuFq+Ed4n1RLLMC9kNeoS2bezlWCWz0toRZSwxSF6ZcG+zGxRLdnAn6rEr6p?=
 =?koi8-r?Q?2Oj4aUQ2wg3qoqxNSdpI9+wQlJIO2Buq7EGeEsCBHI61JGx7aqtSXqW0r52UTH?=
 =?koi8-r?Q?A7fHMTytxB35DGZQnkHFy4WOdrOIm0c+DgfRSUMfqn82M8WHuXNlrLoxfch0sL?=
 =?koi8-r?Q?6jglGu8MZouM9rCGSVEv+aZ6sfRjyQ85qawo+Sw2nJ8YjbYpvV8MKBmgfrQNdr?=
 =?koi8-r?Q?FLNm/M96TnAYluQF/cjL9W4lyf8jbNYQOl6oAwbXIWDw2aMvx+SpU2gFQ/OMXS?=
 =?koi8-r?Q?rT6vXZEu7hjziCT0ziLSGMv6SfWZx/wKeHwPueb+JkqcCk2Tp5Mqz68EIX7SzC?=
 =?koi8-r?Q?FwkuzAFGh+eB5rs+wqeYuIE9bjIxl99V3wpgdt3ky6xR1LA4YWf5uMR7GYUsPn?=
 =?koi8-r?Q?EySHM23yuCW41q1ep4Yr2cj8WX/2hsfA2jhcPt2pnqsJqbqmsVq2qYyD3pMzT7?=
 =?koi8-r?Q?yc3eoAaOUS6ZxBOrCeCGd3aZp5/qSgPhQcz2yX1nZamju3utY0GhmgVCVIR63D?=
 =?koi8-r?Q?+5pICnL/eiEj690pphdiMOjuU9Cg/1hBtUNBwHJA6HFJxJoZKUbdShytwURG6z?=
 =?koi8-r?Q?Y8KbYt7AEbfDa5ZL4/YvII9ctBZw1TlGW0HLWNhc12I5qzPH6X/RUYA/G7A+wg?=
 =?koi8-r?Q?tA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11cd939-3798-4c9a-6847-08d940706dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 11:23:07.3959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2a7HY7TlUGm14AEErksCnztYZZmCAzCViCvIWU2rv2EzlC7sVP5Rvj4BIuJrdK986b9/bVXepTmH+f2LFKUKoFzc0x5EEHs7LRBj50XVxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7398
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/07/2021 13:21, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 5.07.21 =C7. 19:32, Johannes Thumshirn wrote:=0A=
>> If we can acquire the reclaim_bgs_lock in on block group reclaim, we blo=
ck=0A=
> nit: s/can/can't/ , also remove 'in' ?=0A=
=0A=
Oops, you're right. David can you fix this up on apply?=0A=
=0A=
=0A=
