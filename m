Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFCF3BEA5E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhGGPJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:09:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38664 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhGGPJx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625670432; x=1657206432;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BdqG7G7lUihmF6hXWogyL36bvqIFGNNV+9zztnpdXPs=;
  b=CLlGed7YrTa6kECm7UpH4UCg5Ln9YmjoVaYx+M3B1PSrV5/RtLQO3gNK
   Fb+ehOZ1Dl3JGStmgjuCZath7vV+cIiGALmNX3glSy1hJ1txurNTNjPnx
   mEczu7IodTXgezwgxLjNmjosr1wgfWyvml7hZArQfBzrx73XaotXNJ9/j
   DSrIxfNBOEsqQgYe6VmcT1fXjAh/w9pMs+Sy4I+6iz39uOIHhdfm37LIQ
   cjxEo6YFB+o9b4Y/Ml1ctgJffZlzw2fSH8RUaYKdnuJomtHSlIKGkp5UD
   a3VkWsbUWfmCX/uy9+vXt6Lbd0c5IcOv595DtWML10NXdE269HzwfKPVd
   A==;
IronPort-SDR: /KXSEJfx7lZcrw17c1j/GdMudHrTJMe+xr7zIpv44EAWAycg+fGsglnvA+JzxUNvEAP+zalgRJ
 5qqBCS+9Mv3rlDqzh3N1eE+gm8SMgJvae7r4aGJ1lN9OWMj4ZYvy64Lyay5S1jWHwi+78ZnxD2
 T2kyQfRFe9KB4YDXEPjCQGuDoY3bpI/jWkuies4PUAwrLEhm6yJLHHgBHmuDnF9rUWb7f9v2GC
 Vo0+L8ZR7Gerz4tZcU6oxpfK1Nef7j7tenkGAom4fRb3c0gGLrDYRuyxWan1+zI9yVrGHQX7rg
 tCc=
X-IronPort-AV: E=Sophos;i="5.83,331,1616428800"; 
   d="scan'208";a="173187336"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 23:07:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9TDedHcg0WR0HKIc0l3vorRVxvu3kdQ/4FdICHauzdhijdvt4UyqJLDy3yE4v7M7hU9uJjKYaPEGf3YQUdp7nslcVUC1PTte1S5MXy3sORD/haRmZLWPy9lsR+6V6XiCJxx5e7qoPeFEoGaiTrv1fwS+FDqn939nEMKcJ+k2K34oeD2c5r1QoEgxtwpF8aM3eVyssskdwOTIcYV7eKTKEfH3VMz2Xcw5qfDwufgPDLoDifsPF3Rjqa/n7DMotN2CU13VRhf2/88XlnyrJEUthKalBitAIcqx8cpOU/bRbtJRZxxjQ0dMSR3P/Z7hfI7Ax8KxSvLDDF9cahrNaQsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8hi+Fh65QWs9CKo6j1dN8er3hlAAnifitCrJ7Kf4N0=;
 b=gVONnZPaQ8g0fCcvh4GIkZzHtnIEYk+JL6UtfahzD/T1yQu2bu70nbeJzuz6bYfMeXoOsML7c2Jouvrh0y3wrLOAlz5Bqh1TyKZvbkdTmleTs1c2HkWxltHU8f6OdHe7G9NaKfK9OfSbA3TG/aFrpc/9hWW1US2JeHYm8rg40+2EcNtCS53/Y23nbsTfMiYyY/OnUC/fLeuHFxQsw3+6NLGkRs9BpL0xCUGHuBrRLcNn1trqZ3d6aEOVqgEp/KCUjms4RswlB9qlQ9RSGR6+zpR4RYYvaPl+Oqvu9QnkHjPqIKN0dsSkOFKFZgnBzy8vHNPRfpW/dLbXI67roZkdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8hi+Fh65QWs9CKo6j1dN8er3hlAAnifitCrJ7Kf4N0=;
 b=bQAc5VksNI8pcSDKvWhbu78J3DiogCocYEWsraE0WtMcH9CoJCZvTwJJUtaLIEdwZAk7oXCC9QfFG/ydxYphXcELCKitWWjpbvDtZPPsKOUSjKFHfIczDA7Th4qfPoQ4JDZZ4rdFSlBEUw7hLvOWpLpbcxw6rsW5KEwGur0qaMw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7672.namprd04.prod.outlook.com (2603:10b6:510:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 15:07:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 15:07:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix wrong mutex unlock on failure to
 allocate log root tree
Thread-Topic: [PATCH] btrfs: zoned: fix wrong mutex unlock on failure to
 allocate log root tree
Thread-Index: AQHXcyKSrCYrw3kgRkmP88ePeJLvEQ==
Date:   Wed, 7 Jul 2021 15:07:11 +0000
Message-ID: <PH0PR04MB74161D79160D1E8463F05D899B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69ad2d0-3f28-4e45-7523-08d94158e5a3
x-ms-traffictypediagnostic: PH0PR04MB7672:
x-microsoft-antispam-prvs: <PH0PR04MB76727F83F1C43A9AE7439BDA9B1A9@PH0PR04MB7672.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLZQfgp8kjpNGV/qztGnpsqWosU8GK5kvf3u2V/DO+hwpgW0eKP3tJKE14saXob+bYJQ0kgT9ebaXaNN7kFMrAANRh3pbWKgXXdxGm+y/9U8JV+zs2a41c9LnjMudo6WzJSjLpphQXg4Fzz145BYopbloLY6VCciWVwemn5QA3IFA7OBll76+DlDrk+kLVuQwNXwUknMqH4xkomGZIrZomCHHEJesPGyEm/H+5Opy3PFCdHDVcQZSU7bHBbcw0rEx3rHEZG56EdDdq+pBE6gfKMqjgtp53wL8kL/MDxSm4VB3ckBlCvmGQMtYuv77Qdu2CrN9Kl2SnXTgBtePWiHzLg/xcRTd+quKGGyCcUJt5fQrDzbrhr6j4wZc/DYWBzEaF32NxZfMw0UinowHKJU93RjnN9/cDTwl9/i1A2RQ/5bl9qvRoXzDpg70m6rE/IF/jb0To5TdGC9m1k9H9fLKT25ApFl1lcqX47GVpYOZObpabXJuev+XKHJBzzjBG2i/C+OwI8GQoIDS2VkB5oBEDjb9PX+OblzGMtOPcTqbc66yeNo7KVDCYXNz4TutyOPuBQ5zMNTQvcKjHTxY2WQWxQ3uCGY7Aj/G1sLSsGpUMNChiNbX2LfkjsmZ0FGuLg+gQduLkTkh+wY+WNKw925rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(122000001)(38100700002)(6506007)(8676002)(9686003)(316002)(76116006)(86362001)(7696005)(55016002)(2906002)(71200400001)(52536014)(186003)(64756008)(91956017)(110136005)(83380400001)(8936002)(66446008)(66556008)(478600001)(66946007)(4744005)(26005)(53546011)(66476007)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pQyVhwDqRQcViLGdpyN5dP6sdzIbhy0s68cFmbbNqfYflf0gbhcMu1mcvwR8?=
 =?us-ascii?Q?oQNrOPiDmEPDHM+M/vfMbwu1LvvnqLPEornDU65F47J+8bHuzPpwJV/zncxF?=
 =?us-ascii?Q?IgC4kSrigeK3R1zMKH+xYw/3bIOXzrOP8JSwefSXeF6H8C1S1Yq4ijvYhCf0?=
 =?us-ascii?Q?midisa3YcI2iJlarNVeMoSfAJZx6ml68DWzvs3q+aVBRe3+4UOTV7Q0Uxb08?=
 =?us-ascii?Q?pETThT8Xi8kJPwizbRd1w1OjrtVXB6Nrdy4FnNd20utSDTsw0WhvQH5LEsU5?=
 =?us-ascii?Q?W16KyLMS8JZOgSw+zFeu1plQvgOiDnrLKmhZ3jJkCCUO+KHy56AIGg5dbPxN?=
 =?us-ascii?Q?6Qv2g7Ia+ovIFrUWlGg7lES3Z10XPQWLesYITEasO5bXErs4eIHPBLETCss9?=
 =?us-ascii?Q?CxOYIn6Witcvyqe2Cq+Pr79Yh108tX2J86znAXOH6T+BKDEogYIxjjB46KNa?=
 =?us-ascii?Q?s64hhqZkUWjshFHP3IhClbORSeShNk3wXKNPm5W5KpbByHT+F9DS3jPogVZB?=
 =?us-ascii?Q?9pmEeKBZKlk7S6C90hbygrIrk9cyNfTpfaOtSQgxFjbrGkPbL4ptmSfE1eGb?=
 =?us-ascii?Q?DMXLvMqbarhfl9lzAXRB3BhGp9v9g12pV54QKMem9fysL6UZhOc+wPK7Zt5y?=
 =?us-ascii?Q?LPPDcuzsEafcdarj6ddwXH0zZbnHdT9+q9wGzT1QrBGp0kcKhyvZNlweyUNS?=
 =?us-ascii?Q?CdPBzaXyk3KpG6ZNMi+xuJARhBRxLVOWe7hVnBmSrMPjKDg+tkl6k8KZMpPg?=
 =?us-ascii?Q?V4DgDHmrd2wmJ0TfxK9iCiSkTHbm4V36kIejlzUx7MTJ+pYE3rqpPiRmqkY+?=
 =?us-ascii?Q?T+GU5X4vs8yxMgfmq2kRZ/N1TDpwo1cCudgdguoWaEvx2WAhVreccjYD3fLQ?=
 =?us-ascii?Q?zOkr6OgWqPVyhj2D8rGfgOttNa+qboqcfjFC9uc2oMquLncNeFxfwXK1b3i3?=
 =?us-ascii?Q?xETcS3Fmk6ZBhGzZyF2j31JAvVnYwUKHYdxvOVZ+INOljeAb8mwB/2PLIe3d?=
 =?us-ascii?Q?1Tfcy8wI/dh6eTezsjVqPLTIERdX+FqQJDzYtFi7s4uADQzUzvDntWYt5c7K?=
 =?us-ascii?Q?nu/kJdEXwvUb9eqEpRhVl9fJfgMgXRp95IbpxqmjW5cebq5mLUlulpSog6f9?=
 =?us-ascii?Q?c9xB3sGuhB/mgtfvHpdXte2xE+7pG1ypT+A0kLtXNjjUXrkHIColRDwpNxHy?=
 =?us-ascii?Q?74y2nW6xcxDPbsi1HiL/ikD3r6jGjj0cs3woYGYTtKeto/dp8jVJbBwMl1uq?=
 =?us-ascii?Q?4xm54dYvRFnbASiORw9rLtePKQHtbTxTXI5wfEKVww2f6zxVgyEJqa+q8bKV?=
 =?us-ascii?Q?JCXJvhZcoKVdN/6UB/K70h6Z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69ad2d0-3f28-4e45-7523-08d94158e5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 15:07:11.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYQU/gFouKkKTze3TBDKhDthb+VOiO9hT/0+EfxoVdZv08vcst4uIqsbsjAVOuyn0QxHHydC9TC3Q6d/bmbM+k5Cxxa5GQTeMs50WTLMR8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7672
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/07/2021 13:23, fdmanana@kernel.org wrote:=0A=
> From: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
> When syncing the log, if we fail to allocate the root node for the log=0A=
> root tree:=0A=
> =0A=
> 1) We are unlocking fs_info->tree_log_mutex, but at this point we have=0A=
>    not yet locked this mutex;=0A=
> =0A=
> 2) We have locked fs_info->tree_root->log_mutex, but we end up not=0A=
>    unlocking it;=0A=
> =0A=
> So fix this by unlocking fs_info->tree_root->log_mutex instead of=0A=
> fs_info->tree_log_mutex.=0A=
> =0A=
> Fixes: e75f9fd194090e ("btrfs: zoned: move log tree node allocation out o=
f log_root_tree->log_mutex")=0A=
> CC: stable@vger.kernel.org # 5.13+=0A=
> Signed-off-by: Filipe Manana <fdmanana@suse.com>=0A=
=0A=
Good catch!=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
