Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADF151EE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 18:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBDRFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 12:05:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3440 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBDRFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835943; x=1612371943;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bkdo1gaVqumaC3m+Z/fhDyMjmPHJVWHps6lp+MkCchUp47z6fLgp9Zbu
   S0xmZk0crPHh3KzrF+aGjQF3NawZmArJAGT0dWtg9TBDW3E4fVT0OdpkY
   yQ2EgDdT7giOL9q1TRHywDlFz7yc7uhGCqFr/6j0kWdK9wDy8V3C7Ac//
   NiZ0uzRuWGdsbYS575ECXrTAx0eNwXKcXE0g9vh+NpQZBb1aRiR+NX0ng
   vxpuDrG6ErcNu7oouGYezqAO1uX07xXuK0SPi6qqy2pBe6mloF/Qlc8t9
   9qMk0Pq4Z9HyGAHLzwoDf28HUXXKt/kF0hFeORdLnFuaRn0fIP3rXBnQG
   w==;
IronPort-SDR: DPA7/iFAf/7JKGxdIwq7jxeiOL+wXAQyr/c33zqIJn5nNgAr69HIujQGJXdlNHc6rnSaBWYMak
 GTC3HGAtV2vHooo8IMi4JEiMRrxcSIgSPAZb17H+Uaf7u1lI+67w7ZDGTN8wFIlZFPFDxAbwOz
 e1iM7bYrTJ5ilEEK+F/sfeZwG+zzASi3kHN5g1qvWivhleKxJHRenr+vKlch9bI1VAV3uG0NVx
 HnUeAvtq+HljTNzpS+yaFEkBRq/KJ3TWWOwLxEJ6z396q0NH1ypmKk3zD3S6HvWzYD74yfwStp
 aYo=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="133433295"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 01:05:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVvLZCsirQrxaZVcOAo4E8IyNlOYK/teORsDokZ8ocKZYbfMmdjb0dbMBFc5IxLsImv6JHwRcz003f57PimPadVfDbJqf6orPi4dgNdrM+xqnQ+Kgkk2+wbLngbhyK+its1GD/W8wPyb6bkWWPqBDouYDCbiIjnnyAA08yBhjnoIJqUR3iVsXx7Vl7BeBj/ssqum+GkvdrbsCXgFl4HeGTSXAeB+jggRJUyaMebMMZhfMpu/A/BXH/G16RBAgLWj2A3hKTgOdvY7w8GddFA6c8nx6JCQu9Oe16ZK/QB9DndESoTrDAjGMIbgwnaS0KjmIxChZAFU7tLM9xK1ENf27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OGogD0mSrQQxejxpRpy9T/Q8qunk/Kaf2p1XrxJ/ImEDZMY5TurX6ZrZoJ3Q5OVzAQUTOENnHRXMAHJGPJ8V1ixYBXBBWiV9JJ+5MXIQA+jfiPMb+iLUUuPIno61Qy3Zktx6c3hNpb15rNAEcgGaFD7ygkekZVz4B1oGs8UJMXUlKyjK73ZWtRxPXfuxC1cEw30cbMxTYmfHeyMSCphFfUbNQdPGbMZdIN5Nt4axbJIUB4kuPxn/kPC93zrLwJ2iwi5QCifmfFJsDAzcVgVoG9ZxdnDSq8QzfeO3+UjWPVuuj0hmGiSku5CqXKjMffq9991n1l41in5ME4/98Ql8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oMds59N6KeZk+z5+1cMGFeb3kGPLja/6li3/P1HPVoySJe261iWwLo5ds3PrDtr4rQZDnBxiys1ez9IfgKwAgbEKsFt3Tbo+K6fbL/eVRi5Fm1vcp4grmUg0tF10K1CM8oChYnE3ngHqoaunXePw+TrvNVBVxMmQ6uUQvGFBp6s=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3677.namprd04.prod.outlook.com (10.167.129.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 17:05:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 17:05:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 16/23] btrfs: serialize data reservations if we are
 flushing
Thread-Topic: [PATCH 16/23] btrfs: serialize data reservations if we are
 flushing
Thread-Index: AQHV23cKDHlKsghjQk64Do9Y9z70hA==
Date:   Tue, 4 Feb 2020 17:05:40 +0000
Message-ID: <SN4PR0401MB359838B4C88A409B10AC09989B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-17-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcf4b363-f4a2-4544-6f28-08d7a994766e
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB36777A6D7A9B4842FCEDE8429B030@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(66446008)(66556008)(64756008)(66946007)(66476007)(558084003)(52536014)(91956017)(76116006)(478600001)(8936002)(5660300002)(86362001)(4270600006)(7696005)(110136005)(26005)(8676002)(81156014)(4326008)(186003)(2906002)(81166006)(33656002)(6506007)(316002)(19618925003)(9686003)(55016002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3677;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTTPC4SnZ41F/Bgh3zf/iZHES0a+XcDV6CRdk+abFvxYf/tcf3zqEbmzIWoSfC9Pilmnw0YsYbTaFhXwfKwbl78snB2Vity/SLfhG9Xv1zhSQMC7XbJrFhxgiODz9qgqFnmhvAPGvzQue+Ky2v6Jw598Qwn/nxcKHDid4rLQkZW+PzG3mkyH1yp9GAglc/MFrZGAANuQafQvFC1VEGfK4wKKyQI5ia8JXK7uzw/avxObxNoFVzatKBW4irLGDb6grRTsQEjgf9mCvpWZySvBk/VrHjP02CHWF8gFSumJuJrhKBMQhGTS3WQK99QKMeykEkKbp3x2BmZoBC1tRWasXDSOkOqHvd1tdl2/UReFZwADPlfC64Lw0HPUbWW1DIF8+KN7UPmrmJeh5NmlM3rsc8ocoNVaOE5Aff4fROt/3wWXGbElm7/iTmou3+zuWB3C
x-ms-exchange-antispam-messagedata: zqAtypUKljJhq3BgQpCnSFhvxs3KmHsyffqkSGoknZoDRJzlXIr9DfyatrJRLO6sfj4bjIie/IpD1ftsnZGBwxjZ1bsEm024GFDwN126eKIi5LMhKzzC+t9a1AcYdfp4RfIj7wCaU5OlKo5G7TtBJw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf4b363-f4a2-4544-6f28-08d7a994766e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:05:40.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHlfyXbbcghTvdrEiZi9IGXhhJs+mGrT9uOIGnUZRxh7MllmK88Depm0H0KavxYzCJHIe9bFuFPF30TW0qZ3B0plXM5lqO7VXcLORDrD5Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
