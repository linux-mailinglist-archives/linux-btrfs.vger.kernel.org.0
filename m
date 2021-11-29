Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA8460FAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 08:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbhK2IC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 03:02:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28893 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbhK2IA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 03:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638172660; x=1669708660;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fluInrk92cKm7bGp67C9KTuDsPXYKits6arAwkqZTmE=;
  b=bU9ahJRuSgaklsZlAnJflRq2PgsdvsHHISYabfQGQbEmt2JDTdUmoqzq
   46+dfjKgmcJjQXow/gM1QF3oNIQdrfvK6xgb1cJtLDLV9SRlBa5w+uMjX
   +LQICpOVjcYBOmrrNdZlFzBmcO4jAtwNNrIgKqafNz4xAmB0qqOYoHuYk
   lgaj0v2Rh9R5LhtlmFWnw80xQ60TY/JfRajaEafmFyzagBFpdWaFSSqid
   ZD5QClNWfUkmJpg5CwmK55E7nuS8abI8krHkD8+B7Z5By3LesMUpAgZop
   Px7BZQQOuFVBY74YIjFTYbmVwQkw67SqzunfcHBK2uCg2K/vHp1/VVzS3
   w==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="191725148"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 15:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+ingwh3TBIYcqBtRtA7EgVNSO+GdW1ROAgqL/eI0fhyxvpKvOAoKiG6ci6UeijZWIDISCyxqWD4jYar/N+cY7T11AkyQizcFnxxRZUmzUbzwo/i6zl8D6HxwhO3Wbo/PaTjnUp+CARhM+H/73KaPDWYdu5y0JNAPOmhUsqvpdEvVmRRoyx9Px3YZf/PtQwdq0SWRDKW1D95br676AGe78Bdg9vXpKroaCrLoXUxU9U/5QXnUXHCuB46zhKdTRCbZtydyObUkB8OQmfNxI3EfR5n5XkfRV4k0OfLmTl+jGZDCo6SVo0Mn2OmzOmlA3dT0aKtXjMN276WGoeABC5Ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fluInrk92cKm7bGp67C9KTuDsPXYKits6arAwkqZTmE=;
 b=RO4JDE69XLwcxZqg73n4rlmLbsNLMTmFAOnXGJEgLC/r+ufk3mN3LgsHEdIuqoi1X+A6zbzaEVo8j+0TwAxaPLwYj1KaZ+p1wE4m8GBJck0+r5VE5htlEoOM1oJwKRaWiln8MmKyEEPjeDxUTRcfx4FZw3owZyYjrGRQYwMNVhPPVcTgIDL/w/DXkxqhVXqM8V1E6teU1sap0UUiM84aQmoE4EBKla5MxcBvb1QHWxSihoQLfQJ8jXVf2LoQx6/7numut9ax9R5mJw2icvQnVsuf27xjWodXROOlytZfDKKDoYzFwP7iHeHclxnC/bJoBr10ufXN/k0ZtaExVBmR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fluInrk92cKm7bGp67C9KTuDsPXYKits6arAwkqZTmE=;
 b=oW8jyo1TlCm3WkXlaA/uc3kv3nWahiT93Jjhnxw1h44WYBt19ilkJMuoMnMTkwAQFdl7iv6S2I4I1cEKho5gqN7kfp7dNPX2XmLI26ui06Up/qR+dxu8Ot+2ag7DuaweaJa+nOcN/di86eGE7tPD3IDEdp7iG53z/E73nvUTc9M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7238.namprd04.prod.outlook.com (2603:10b6:510:8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 07:57:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:57:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Topic: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Index: AQHX5MwJtsNxR3RHg0uKLQ51zDwxNA==
Date:   Mon, 29 Nov 2021 07:57:39 +0000
Message-ID: <PH0PR04MB7416D41D2F6FC7863439BD8C9B669@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211129024930.1574325-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383063a6-319f-490b-ad52-08d9b30dea87
x-ms-traffictypediagnostic: PH0PR04MB7238:
x-microsoft-antispam-prvs: <PH0PR04MB7238C5E8F71EB9B18F1D60B79B669@PH0PR04MB7238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BK23y0NTxQGS7XyzhQXZW7aoHyEwBo6q5IL/G9KtFV3xzywUFAZmUCIJV+KgVxfd6Qqm9639AuzbaHi632UrxbenV6XiqGxkaMeHnUZZrVmkEiTTUiVV4l0UqNJ/PNCzDKmgdqPJIKAI7hcU0BktHZx1cUrbYSt0ivhSRiPKlA0+31T6r8ZGcu0yySbw5Vm4pPE+Mn6DrQcUdjLA3Dv2TE7RRR/X5N6FnrgErRkdLTNXvKdeDiIDm9nqg1ZSbFpAkQxRP+7wyYah3Rc86Fcuq5ThFFeaS25RDHwRPyAK/SzjOAgYy0p5eyfnvWl4K3l1v/rxapLDD7EjYzEnxK6pUk5ftD0mhMsdvXywf+zB4hU+v2jtHiaWEXtNU/ZrOR5BGem0mhYBW2HnR1DuXasyvInxmu/5uVROn7uwIkI5CsuteO8B5ZQpQEGF0q0kM8DZUrn7FqoFufdpWKPECIshRVhs887cOQfasPUTx7dfn+1MbSxaSmKd3eiWJL35Jjg6/xYIN9X/xkINQzb9FIkEgi6dH+0vumclwEgw2wBg0TWA5ZmdmGaQsnS1Emr4krVHcb6+f4TW/Y1QADgpFL144b6Itv3JeqGj+Xm5sBcZra88EIbLLQA6aWpaaE6rD/KNS1JobqCk8Ie2kdeeaqgkfWZs7Mwtmg6NjAGWrhpjNJhtYe+ED2QBc+zIS0Sg2Ovniaj2/Vj3WjL+0wA0i8FF3SVzug8+Ku7wAUHKGQfmK5wu3i4x9F4dhj1hLIm7mxJFUjhQiB1Yx2HJnq5HeZJdkt3J9Aj4QFn2mAq9pXENsWrANDOr/lHLCl/OgUlSrCp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(55016003)(53546011)(186003)(82960400001)(8676002)(86362001)(33656002)(2906002)(64756008)(66476007)(4744005)(508600001)(110136005)(7696005)(6506007)(316002)(9686003)(966005)(4326008)(38070700005)(66446008)(8936002)(76116006)(66946007)(91956017)(38100700002)(52536014)(122000001)(66556008)(5660300002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t6zYr4VnAVPa8LYyDUT/IkxJkV0J/2Lz7ccZe42fgJI3db1BD8vG2kMwwkvI?=
 =?us-ascii?Q?SeNmIsnJ7IomNuACMN47IP3xvXRZMjADw2Dr38pIhxu278B9vf6hgRkCsCb3?=
 =?us-ascii?Q?hmx1W0a93tnMrIFZZpNXjMP+xPJmgHipxc4y3FDG36QOBS+x+MhTWEsdx379?=
 =?us-ascii?Q?rS9lq2mjTH+KnUSiGh+D5cKO3Zs2zzI/JuAs7ZfhOlkt2iwvSrBrhRLbXb3C?=
 =?us-ascii?Q?gHJLpCWTgo22IpsGdJYMXJ+Lo7bSJnFSBq+FO0KUv7I+0umO8qdH/ePoRS3N?=
 =?us-ascii?Q?P0K3c7m0U2hJDeC0Vp9hYRroa01i25nibxNmA2labh4N7SPWiGA/rAMS2YYO?=
 =?us-ascii?Q?G3GyQ4fiJesoIkrkINBq5c2mgQfgi1MJsIes4MQMpZHsiCayRTZHnPr5+0GU?=
 =?us-ascii?Q?/cUDHnjpx5AlyLVVtGiAYo0DhwHVrkhBJrCNSBbEd6beyD5Y3OuCrugLXRxP?=
 =?us-ascii?Q?SpYOG1Qc8f6d0D0oXmIJYHcvS/bfKZ+DZRJ1hDpxR9Zm2WOuOvgtWzNlRTFY?=
 =?us-ascii?Q?uwyQd/QSn7gclr35xfXP1YyWcSMhSWKN+W/22n5SvN3ycMRO7WfTvW396jSq?=
 =?us-ascii?Q?cmaqKXLWBcmM9ZnT/JzwqRFcgVCIJ+Kc+MxPh5yRa4qqs8STGYy7uOg52o6n?=
 =?us-ascii?Q?SkSM4+kVfHNCcgtYCxFDNIj4ZveJcuxTeXcDXRASKUyURv5bz6nsVrmQmpTb?=
 =?us-ascii?Q?yrSV7ZU70dtEUZsJ0LogqP6xf9s2ZLkXZlG312YkwwQB4H0g0/xcba/RWoFu?=
 =?us-ascii?Q?XLMAWc/BVuQjTSY5NI/oE1PkScSUvmBoHk9MQb91ripXu2KFKY9Cndmx4cBe?=
 =?us-ascii?Q?pKnXC/tsfEmlNp365IHtpWS62TejyZ8KEz8GgXXRXjPVNGLOHlR9uw746fOH?=
 =?us-ascii?Q?4q1D1whtKW50H8PtovwS6jutPtKGJI3dW9N0t3jo8n+W9V1hdKu0TV9xhz30?=
 =?us-ascii?Q?NySNaRjnBcP7hGFq/1084riIUrnlP7OhXv0Iq1aCq/BY+lM5MM7lfCP2oD4l?=
 =?us-ascii?Q?8Rbi2vOXpJ88E3sBCNYPYgC9YzHl4334LtnZRraFCfK+8E4cWFwfL2qR6mdf?=
 =?us-ascii?Q?j5SjdLZE60Oqp+gWzAEctrI9NyP0Cbtaagn6NrPA4e1zQHbQ5JAsH41rDJ+j?=
 =?us-ascii?Q?o0LtFMS5kSm+EULCc8GQ17lx9YvV0m0ZOyM2cGzepw9NvdMdTLEbNk86Ek1Z?=
 =?us-ascii?Q?Cb1aGhXeuIddo/Qdy/L+H2yIg65Ov0H4Ibsmsr7ppBwaalekOf+fbeth+Nib?=
 =?us-ascii?Q?EFqW94b2SGA+YVkPg5TEQ4pA6OapXdsRjM0iX5z8kYDNEoTpWVvC5uo06+yP?=
 =?us-ascii?Q?q+TDsT0N6esiLCPfjWlzD//gso/3Edo4LOTfEK1zIcDQnqHg1XGVjKGEyyWV?=
 =?us-ascii?Q?bC+m1lJPkqSmtZQnXc5Dr8O/ExbHiNzNhr/JYoOeIXg0jyfd2L6Hw81chJPH?=
 =?us-ascii?Q?3TEGyPitmeY6BppHEkyTHwUOedAcvz4s5iOAbt20MXuuiA6eYUuj7anGJRr3?=
 =?us-ascii?Q?XgqglKZwpeuxK0n7Yhn1xA0vYacPCaU8D0bXraBZHSx9wgZ6oR4aVC2NV6mw?=
 =?us-ascii?Q?ZMyAhNwhTDJVAUBxwSw+91ELTJKZ56PAeVPS49o/xDF2mLIXGIufyO5m/xLh?=
 =?us-ascii?Q?RUXJOvQ7td7/nTO69YQhEaZ39FZEF3A5O+JKHaDwBawPL0Hc6m+OxMDFcH2h?=
 =?us-ascii?Q?IuFUgid/d9AtAxuQXeegZnBz+kbzhNWL9nrkznGdEMssRP/AeE1zrZtBkSnK?=
 =?us-ascii?Q?k/tU4+3QjHSkto0oZY9wmiwjVmqlmPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383063a6-319f-490b-ad52-08d9b30dea87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 07:57:39.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnJAwPIAn5IbDN1HiicfrmnJWwOuCkzzq9t4HaQT6juzeMM7LBT+uGm87NtIZkMEPIG3gHh1DIhu8JKokHFbWQoz8gtQ9Z8cBnWz+tdPtsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7238
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/11/2021 03:51, Naohiro Aota wrote:=0A=
> For zoned btrfs, we re-dirty a freeing tree node to ensure btrfs write=0A=
> the region and not to leave a write hole on a zoned device. Current=0A=
> code failed to re-dirty a node when the tree-log tree's depth >=3D=0A=
> 2. This leads to a transaction abort with -EAGAIN.=0A=
> =0A=
=0A=
I'd rephrase the above to:=0A=
=0A=
For zoned btrfs, we re-dirty a freed tree node to ensure btrfs =0A=
can write the region and does not leave a hole on write on a zoned=0A=
device. The current code fails to failed to re-dirty a node when the=0A=
tree-log tree's depth was greater or equal to 2. This lead to a =0A=
transaction abort with -EAGAIN.=0A=
=0A=
=0A=
> Fix the issue by properly re-dirty a node on walking up the tree.=0A=
> =0A=
> Link: https://github.com/kdave/btrfs-progs/issues/415=0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Shouldn't we mark this for stable (v5.15)? After all the reporter did=0A=
hit the problem on 5.15.=0A=
=0A=
