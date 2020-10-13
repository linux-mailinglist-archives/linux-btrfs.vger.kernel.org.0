Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306EB28CAE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391289AbgJMJWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:22:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17473 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390781AbgJMJWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602580931; x=1634116931;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+dGkZ6xK3+WS8Z/x9+vGJ7cOg3wBskm/eqi134liAcA=;
  b=VJXGh9Q9u9CHx0Q2l4f/2zRk5fQU0S/a7XK47YTzQFtGigMPDsUZijj9
   4CmnrTngNiHU2NTUEWrTCD201HuRtGsvYTFv2HQWR3RFpzAx1d+sQYHkw
   055sfgramGRKYyD+gSIOor7ZJQJm6ZJxQqin8VjvXu9K1Zrxd0OL+nAvW
   ovEe6mnUkTd/VlnS6hY6V7awJxqBLVsUnca2xF8cpnr3I3a4fY4SxySOZ
   evt304LfWQmmFO2ceQ42VeGV33B+Fk2yIpFCLICmfygCes2sUau18xrQD
   rcIUFh5bwUjd/3jDIcx2J7pJfcpNvZvpcnJIy6pXoqPicFEszM2g+wBlX
   g==;
IronPort-SDR: yut35Z39If/IXaS2qXkgTjpLY5ywA7e3foq7JpsSESyN2NnS9GuD0XEeLhO8CUCBNaMBbXBTd4
 A1MglcEhlep1CnS+RmhWaXUC6fgfUvzklmlwAYHxPeihEBu6XnnLoLWPV/4t7rrTQLbe1/DAgw
 ZJrNTVH55W9asxOn0Y2tEdXYUtYFflg/jgbqyiLXys1DWtABxmD8uD/7s0Aehb4smU5uAtZP0R
 hO6Dqkfu4cTsIo2LcJs+MSFn//Podn9kkPgPXrjTOotnrTKCfvEhlpKY+hbp2f8iXFvl9M5oL4
 wUE=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="149772825"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:22:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqDsmsHIMLn5b3J7Lf+BFhozEQGMA3tvAZ1U2uruO41v2xhkH1mUPH9zHNJyt3iwSue4dKlDXckBJoHIPFMsZRB9QL1Ul2r6nhAU6O/1JPaHFG0ab0LJkTjTYkLP6pvcB4GmlWfgaVYtSAV/8RJ3BcNgVLOOTsrlvFYamFzGeGMaKLJ8kpx0f7nVZgmcuC2YS1fBFXyWizesjRisYL8s8zR4mPBa3TIbiWLatfmkfNZS6zscjRqKnW/1X08+zm9iCcWByqqrDj5MFU2Xt+uloJ7DCF0IXe7dWwwk4SLfylshoj5FfpJL878xsmE3Eld7inUtIfQsjkc+CPhn+SkarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjoCHXOZEHdVmmkrycbpeatANSIbycejbyU28HQcD70=;
 b=DcHwbMdD2XP8dQuwW7sNFFkhzQ4JZ57eYXgDhCWA1iAmciFHQpiWDmIowKYX2ig70OYORA1FA4sqD+WpvclyKBDK/I7tEk24YxgNGSRBptsiODBkIlFcspN+CDC2LiPBA+xlR968Q49bY/UuprK/BgZVaxVMWqdIyzHTlHanRvplSWEWSYCROoF0k9HwnfcMwgE6efps5VOxBwQd5i6bLEdb1BtT3gaqFZdWIYQ/rQeqjIWoJKXBsl/y7j+M7htB0ucZ9gkGnDmSarm5uypbwivBm145F4JMXPHqLAWfLgy/AqldxFQ6C8J+3H/KBN+fNTVGZodysDGjsQqBu7n+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjoCHXOZEHdVmmkrycbpeatANSIbycejbyU28HQcD70=;
 b=OUpa/8o/NzVSACLjD8/L3VMzHF4mjYP+DHvGcBO6XfRYXmxTVKVjaW322kZvVrJslH8YBg89sBSg2zdyq7GDhRKAbJQmcepfsOFgWXVPpn57VRhHdNh+LRSvbMuQrpRZN4paFEjPHMFG/y+1e6zasapRiKl9bRLjF0G7kreH7pU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3519.namprd04.prod.outlook.com (10.167.133.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Tue, 13 Oct 2020 09:22:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:22:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Topic: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Index: AQHWoIY3ciNzxOWRGECrI9HL++8YqQ==
Date:   Tue, 13 Oct 2020 09:22:09 +0000
Message-ID: <SN4PR0401MB3598657ADD78C6C0B6ED17FA9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
 <SN4PR0401MB3598176352537EB6551AC3CF9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAL3q7H4MPN-NLomCZjM7oQFxA+kE=7hWRSUcvp7E6B9hx3h46Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c96f9ab0-427e-464a-f825-08d86f597609
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB3519A003CE32DBC599BE76ED9B040@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T01mvlCHuR6PvNUSPWwBdoqPgAnOtyZDM21lZVwnhrkzLdGBXAaFx+C24wvtIYwy+qcyHBvokE3lJvZXI0sbjG66N+jIcI6aW56KwF2A1GCvM3L2MJ0znTuVjp9B/hNvfgT3HqICoKZTyE2wP5LPr22on7687MNyDoLNV9TYIyqCRgLNx2O5yDw3ssOFVvvb9p2b+LDqMpUQSSdobhyGR2NTJ03VDAKTGiVH8hxkwCjYjrFFMo9+oleD/qorh9WaMzi6R4CRnWx4XdLOm0j/wNJlgkga3yceP8Pq9HS1OtJehTp9O6ZxRhqcG1PFNc6UB6oR2dnkhdDUiUmbmCd2Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(7696005)(4326008)(5660300002)(86362001)(478600001)(2906002)(83380400001)(316002)(186003)(6506007)(6916009)(9686003)(8676002)(76116006)(71200400001)(66556008)(66946007)(66476007)(91956017)(66446008)(64756008)(33656002)(26005)(8936002)(52536014)(55016002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0GUDSlCLSQ+idR4+WLu/DQEG/FNvqm6g7+X5tKvcUMCycnijtFoLUulzbOdwODVxx/y0l5XYp5NUXI1F8cOVm+OBIRwNhaTTYcxjHN6rLDAOG1lrDwmE6E7TIx38My4gvJqrYXQbkWHz2jkT2vA6TYgDoWr6VeIhSJR8FCbdxk00AxWWR/3aPI72gPo5/ZSuS+3KiRchHknnCzrXNRngWoww33CKKKxf8UW2ogwm0jZ/A2YI44A/5yJtKA+GZPzrIOzHLeoMVnnX659mEB5x+99zY4KOhDcKbkXWCMCPEOpR6S7aqfg4OjADlaQmPFvFGdHrznfflRmTX5nhDyHv+uNMigbK/cppowK/+rbrqW7EbRyLCfafzn0Fd9Zdz6yT2Vl2R9WmA9dn1i/eKT5Fg4XDS3Vr9pgrGr2pYOrZco34O1lMf+NwIpVDGdu+g+6Q2mYRVYJxT7Y889H7G3e/fXngLeVzcwXKriaKirYqj73NkDKqM4gMnpBnO/UM7Mk9qbR3ANPKYK/LupRVG+OBTnsySXQ3nAlzB3hXWWLnKfM4cgO0rYnsxnKAeyeHEoG+eDjCZbbhWD70J3b6Q6NIFNRy9UhIykW8udeSmns5kW8d9qeTqOOCHIVgKIF/g4H7zmDVIn6hyfHaH+76sY7+gw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96f9ab0-427e-464a-f825-08d86f597609
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:22:09.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+hFh+lsLMgaWaWdnLOS+y7plKvm2MKyqha/4NG3MZMgfny5FJ57tmIBw/A3lm+expvFzTAK2OpzKkfytOe3VismO8nsBVjvyT2hNUOsfG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/10/2020 11:15, Filipe Manana wrote:=0A=
> On Tue, Oct 13, 2020 at 10:08 AM Johannes Thumshirn=0A=
> <Johannes.Thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> On 12/10/2020 12:55, fdmanana@kernel.org wrote:=0A=
>>> critical section delimited by this lock, while all other places that ar=
e=0A=
>>> sure they are not dropping the last reference, do not bother calling=0A=
>>> kref_put() while holding that lock.=0A=
>>=0A=
>> Quick question for me to understand this change, is 'reada_pick_zone' th=
e place=0A=
>> that's certain it doesn't put the last reference?=0A=
> =0A=
> All places that don't take the lock before calling kref_put() are the=0A=
> places that don't drop the last reference, and there are several -=0A=
> reada_find_extent(), reada_extent_put() and reada_pick_zone() at=0A=
> least.=0A=
> As far as I could see, all are correct. The change is motivated=0A=
> because I had an earlier fix that did the final kref_put() without=0A=
> holding the lock.=0A=
> =0A=
=0A=
Am I looking at the wrong tree?=0A=
=0A=
reada_find_extent() takes the lock:=0A=
fs/btrfs/reada.c-               spin_lock(&fs_info->reada_lock);=0A=
fs/btrfs/reada.c:               kref_put(&zone->refcnt, reada_zone_release)=
;=0A=
fs/btrfs/reada.c-               spin_unlock(&fs_info->reada_lock);=0A=
=0A=
and so does reada_extent_put:=0A=
fs/btrfs/reada.c-       for (i =3D 0; i < re->nzones; ++i) {=0A=
fs/btrfs/reada.c-               struct reada_zone *zone =3D re->zones[i];=
=0A=
fs/btrfs/reada.c-=0A=
fs/btrfs/reada.c-               kref_get(&zone->refcnt);=0A=
fs/btrfs/reada.c-               spin_lock(&zone->lock);=0A=
fs/btrfs/reada.c-               --zone->elems;=0A=
fs/btrfs/reada.c-               if (zone->elems =3D=3D 0) {=0A=
fs/btrfs/reada.c-                       /* no fs_info->reada_lock needed, a=
s this can't be=0A=
fs/btrfs/reada.c-                        * the last ref */=0A=
fs/btrfs/reada.c:                       kref_put(&zone->refcnt, reada_zone_=
release);=0A=
fs/btrfs/reada.c-               }=0A=
fs/btrfs/reada.c-               spin_unlock(&zone->lock);=0A=
fs/btrfs/reada.c-=0A=
fs/btrfs/reada.c-               spin_lock(&fs_info->reada_lock);=0A=
fs/btrfs/reada.c:               kref_put(&zone->refcnt, reada_zone_release)=
;=0A=
fs/btrfs/reada.c-               spin_unlock(&fs_info->reada_lock);=0A=
=0A=
=0A=
