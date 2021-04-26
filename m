Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2C36AC09
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhDZGJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:09:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44392 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDZGJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619417329; x=1650953329;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lXWsAqEXdOez7w9wiFFiT4pmXQi9hE5WhTe5IoqXwU4=;
  b=n89OTB2Jd5mXN78xgrafQukFNAizTjkntOuj68B2I4P8J9odaCRWSpED
   0zJ17g0ePropGHXNZ/ib0um22s5E1Ag5JJvu439VQX+oL7Hyg0be2axiP
   VGQtDJXaB3YMadv0jm5+5nNNxVvOJaeXEw/bFrZToZPxvbtztzZQBdkJu
   e/GiO+bzar+3xkYDXDgVdvnR0WP8nBZLoSEx5wb3YbXaT5VdR77ifWppC
   eiPkBC+2jhSAkIbLHpbzgYgLRxdIwm//W+vpBuaV1VYiOm4vgGVfJnTBe
   4l7ZPDs+K+mv729RdULgn2UuIbOZwWj2tSNLUBFuvUegrmYpBn6DvzSzb
   w==;
IronPort-SDR: 72NbsI2JACpQLadYuGAi7VQKh/vDTeuYhi6uDM4Ghl0TAOm29VDGEbQ3u0rB/Cz9wA45c/+/Fh
 ZkHhpyGhtD0VxV5cFOiI2wWYxyb3eMCT7ypAmMy6QBbZTuB4/D3GMPWXmrSYhMFOukQwQexSGg
 T6dqHl3QhnIRQcAmC7TZbH/o6FAjRB6Fb+qrk2SjygNXgHI9aB+wdx2RB/HVD7ODCvmltbIOfO
 gHUcOEFzNNvOHAF9eYmzzRj9JyL3zFWzi6f2V1nVPVmVKWCvSeMfkpdlMCE2TKKwq8PJEc1SG1
 rA8=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="166792542"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:08:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH8+t5B9C0t+oxrWRQryKVbOwcNx4fOErxuHOuRF6WAVe2IDAU7Znn3bzKVbynV9vaRgNklSlLTQXK0zVzg0Ws4E9O/dEM2opqSf7Gkg5OSDcGgZ0M5GhvL8UQHmJs2SFG9G/ExDUnBI2qjdfPZ7tSVfS3TJoPQ0XMD+gJMDullUC08qflv15V/AkiaRsoHAIlWT9MNFv186DdmgUib86rei8rv/kOXvZ+Lmpu0Ne3c+SmBMnGBpOzZ5aysF2oQywaieih3wDpPsTxxKJYv7ShnOJYEUyHq6RqyD0uqBbJPXS5+c8UWnM34Qk4yKXgvZ1OJVBS0CBUOfyPeC3bq80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXWsAqEXdOez7w9wiFFiT4pmXQi9hE5WhTe5IoqXwU4=;
 b=XQ3jOFA6Aa+Fhr0/QHLjgyUWnP7bk28tsHi4FeRK5dNDyRHeRiacXo6q1p6ApfOg0qqbvNrcc/jiuGKzrv/mI6KOYw+U1No85hwV2wzXF5/gO/pCIUl4heYGn6JHhQ+1SsNsN2ndmWeGGLEwVSDaB6YAfb+A/FSGifDnXWHFiSIn5W9hunyJHH2OYYvf66NXxGOVj5mWQ2jtuAPbTj3ZYpKR6VUcXCa8Y14yysLYTSXdD7pNYBA6HqDiGyRAhFwJrZ8soA2LbcbEIgXci378jbeBV+6zOwDRXQMHUKKjo5mCpL4QQsUFewqFwECuP2/ozA8NQ6CeFhvVIxQDd4V+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXWsAqEXdOez7w9wiFFiT4pmXQi9hE5WhTe5IoqXwU4=;
 b=tVSSKI6vvcUjzgSu54AMAcSAdPIO9DWEvseKwSpZGTYCW83ZRXwLnGQXSYjrItyQxJl+W7aYpcDiMUT9ISkE75lyPO430nk0n3GXLdwo8M5snh1kKV84qCAHIo3YfQG5pMUyLnA90GihWOiACxQq2SUpG5V/HeLETbE+l+4CPkQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7255.namprd04.prod.outlook.com (2603:10b6:510:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 06:08:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 06:08:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: add test for zone auto reclaim
Thread-Topic: [PATCH 4/4] btrfs: add test for zone auto reclaim
Thread-Index: AQHXODOLY8BwfbqaO0KN/RgWYIYWJg==
Date:   Mon, 26 Apr 2021 06:08:46 +0000
Message-ID: <PH0PR04MB74161E4E757B64035F576FF99B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
 <20210423112634.6067-5-johannes.thumshirn@wdc.com> <YIUpW1x9TxfZtY+G@desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:214d:c62c:3858:57fd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c524570-e41b-475b-2822-08d90879c088
x-ms-traffictypediagnostic: PH0PR04MB7255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72555654D4BA7288ABF092279B429@PH0PR04MB7255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mz0C4OEfhlq4Zu/i++gHZhxhHoYeR9xFl3wSqZig4qGdaaHCelLyEdXmWszwkT8xlepYMvNo9SMlxyqAXeeVAi72fn/79UDInjHR4MRybzG/fCcNYvxj5MTsZMVKJAtfKV1Xt+zMG0o3xg4zajMFNcLzqfQM2ei5KO63XHNTLNrHA0m3DNPPzh6RySgzI8L4q8vz4uU3EsXvS395W4vchPN//YE1gxvrrZ982UcRoaBSxq7mz1cqKj6Myu3gAMfbyZkn2AEhhiCHdWiEVGDxRY6V/xKc1qa/dd5PdSTadl831VPgen0vXgQHwojYldtIlmfVlNmmiVgv5vB+H2lQMdy7RpQ8Kn4u0lwnmqDqP6BRje9eHuN4i/hazKhgG5ydLLN/B33ySljbQidYhYfqwc8Aqp7DBNl7bdVZjZM9owax/aoq7rZpYdntsjvw9eiOvxfHIIwaOk9U40YM3GgPxYCPSSkfQfNmjqKO+pZwZwSVi2r7XvfjeDGPNyKKlHmrpWkv6z/Ckg2c6YW4AmkICr26YmUd495gZcHpNazij1C+0EOpufRF0xEQhi+cIVTrOBliXpUGJRItJ+87A8Gw3RX7iCM17JnO/n9QQTR/mno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(76116006)(9686003)(66946007)(54906003)(91956017)(478600001)(122000001)(5660300002)(186003)(8936002)(6506007)(53546011)(66446008)(7696005)(6916009)(4326008)(8676002)(66476007)(64756008)(55016002)(66556008)(83380400001)(52536014)(71200400001)(86362001)(316002)(2906002)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XIEWg75Fh6OQ949GwZjoN1KDXuO7HqT72SnrB2ObbBDxwHtWnflfs/fn9ITU?=
 =?us-ascii?Q?WW80B8PeqQ9G+geijX1qavuIVa3zxB71sRKfX9HMRmy5C3ZMakGehx5oZ/Um?=
 =?us-ascii?Q?Y/7tiajyNFltfmXceCFI6JYfMMzNwe7zlmCjWKNd/qZo0E89d7Sfbuj9xUdG?=
 =?us-ascii?Q?76lA1FCIO0h7SBPUeX1Xt6lHSjNac85A+jwHChO24tV2Eo90MtvVHYYv/dxU?=
 =?us-ascii?Q?G6shylU69tpiAW2XH95M2kEkFQI+8jpjmmVz6KmIV2mxrJL8FtlAni4xhD++?=
 =?us-ascii?Q?RDqAD3slKQWNE1ty5uok1SGnHr4tCIReH6hCZirDSqppdXc7VNvP5ucip15F?=
 =?us-ascii?Q?vW4SZUpwUPFRW97lTWLHsaGfuRlL0EgM0gubjDbrluGbdeYUuTRaQO4C8Bvn?=
 =?us-ascii?Q?MU76XoO/FKYemEbvJzXLHWE/EF2XMYz/yrjG5IsZX9I1XTjV82R4cjy6YKMc?=
 =?us-ascii?Q?dttkZzyIoy/ot12VlXNedDvNv4Sum6k8D2zmejCntC4krwqAyEVHdCCW2WJ+?=
 =?us-ascii?Q?JO3d3FdyBOBjxV395IVgwGChbMVWyKHKsVBXvfUNA6kOOkRg64cvTuJglJnM?=
 =?us-ascii?Q?gK6vvevVWk0yvg3Cmjqdw/bv63lkhSqDxEQnIxI+9Us0mCEubTCcKK7B3Ce7?=
 =?us-ascii?Q?Fap+gCnD6ra7LmWQS+YaS5F2/sp4fYRhItP2t8uWrYA6tp2YvJMn+/as40Iw?=
 =?us-ascii?Q?1iu9GVmWipyA/WGpyYw+CsauxUgOVZoGXR+t9gy4l/eb9bwuqMaAk6+9udVe?=
 =?us-ascii?Q?1QiT1wGl6AkwHDXEJmWG+x39dE9VjZ3oUrNxALbBtvA0c4cuGswQ1DPZ7CGi?=
 =?us-ascii?Q?wlkDduh++maHjNEr7m3PJLr5v8H/u/EqM6jlACFRJGiOHEF1cF8WrNOrrEBy?=
 =?us-ascii?Q?8lfmzn0ED9kqwhmjzAGU0PVtbUfGa89zWTmZzluUxT3YcZbinYte4hFUQUfS?=
 =?us-ascii?Q?gEiaHVuDdD7NLb1TJkz7rjL0VHoITtvQnhF1seetTOvwHa+59OeJceJJfG2M?=
 =?us-ascii?Q?jdAQufA6AdPDPMnT2Um4lmyJ9ZDxQE1/i7mp5L8jSgFlMsLYdSpQWOI20ulU?=
 =?us-ascii?Q?UZqywKl7lt4sTQYhlO1IChGOylRYaZ1ts3+P9kTm79miCBIuclfJjJ9JuqCj?=
 =?us-ascii?Q?PlmI/5dUgtnqjLiOgsXNzojR+f2rp7obQfFGUc5cuA8xz68KbYazu5C2auL8?=
 =?us-ascii?Q?qsSl7HfozLpc7fA5y88GU7KnvOQsAJFfkZkI2KjURe50M5F6N+Z6zg638DR0?=
 =?us-ascii?Q?0iMW8MH56c+uY3iPKExa82bosn+Yde+eJUqqK9PvDPDrBA5zEq93R2UO1KdY?=
 =?us-ascii?Q?AOtlBoW3wHW+hzHXun41HTWMQ0BOJDUx06l58i6Avi084N8hQEWRfdVvymXr?=
 =?us-ascii?Q?CpsOi0FV3qvO0dZw67KxfK2Wkln9wl6d4xM7PMvyc79qTqpzog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c524570-e41b-475b-2822-08d90879c088
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 06:08:46.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fd1jarZ9MvV+fSyrognDrtdjYRKarAxrCeEJda1jjK7P3+aCGU4LoD7t/go5wwUfavP+nw/Ui0X4uAwm+tzXDihLp1a9sL/1ZJVGRsq1gZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7255
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/04/2021 10:33, Eryu Guan wrote:=0A=
[...]=0A=
>> +_scratch_mkfs >/dev/null 2>&1=0A=
>> +_scratch_mount -o commit=3D5=0A=
> =0A=
> Any reason to use "-o commit=3D5" mount option? A comment would be good.=
=0A=
>=0A=
This is to increase the transaction frequency.=0A=
=0A=
[...]=0A=
> =0A=
> Why are above two sleeps needed? They make test time longer. Remove them=
=0A=
> if they're not required, otherwise adding some comments would be good.=0A=
=0A=
We need the sleeps to ensure, that the data really has reached the disks, =
=0A=
i.e. a transaction has happened. Otherwise we won't see a) that the zone=0A=
states have changed on disk and b) zoned btrfs won't transfer deleted=0A=
bytes to zone unusable bytes, which trigger the reclaim. I'll add comments=
=0A=
for both.=0A=
=0A=
[...]=0A=
>> +236 auto quick balance=0A=
> =0A=
> I don't see a balance operation, does it fit into balance group?=0A=
=0A=
Autoreclaim internally triggers a balance of one block group, so I thought=
=0A=
it would be a good fit.=0A=
=0A=
=0A=
Hope I could clarify some things.=0A=
=0A=
> Thanks,=0A=
> Eryu=0A=
> =0A=
> P.S. I've applied the first patch in this patchset.=0A=
=0A=
Thanks :)=0A=
