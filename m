Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15B01508B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBCOq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 09:46:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9173 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBCOq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 09:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580741188; x=1612277188;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
  b=AZrPg0xBGeR1SJRpU5NMY4/81hCq0RQYw1hHKP4ThHRQE/P5tmzR2Let
   CsDwRj0rAOhpZcB5BzLGF6OznhouvqkTO6OurChLw8hyO1CighEaW1xlt
   9fJOlN6BFbhg9IuXcMb0ttHfIksxBeynAPLCm+ls0dYG5UKTUJerNQdnp
   CtMfuuNyv1us305d00FKFF+BGMHz/rA04S7NLWwA4gy4M4e1dnlRWkXiq
   D9Rzwm9FLq5r7Kuqde6fEX0UDdFQWX8Ax8MxK10a5+4iWNwAQsuk50y09
   NyDoZCc8SsYMxlqNL2Ko9VRlP9d3fzQ5OpaM1dAGmLCbQ7qD4GdrmAQm8
   g==;
IronPort-SDR: ZqsEc7Rtn7cdXA/kOW4KwekBgLUxm8XaO1hLBD07Z7gU8dKBPeu0D3Nz+lzzNxVZtK4XKPtBji
 +b3RRgssC/AGoVUDbmLKkXYlmVAKrSo5Z4tDwCW6JvLgbXB79izCavQ10WDgC1BQU/Am+izoKQ
 4yY//TLNz6DTAe66VQH2DcodkIDGgP8PqIex0Y2CnoXVYEJT4rSWAM+UOsVjVQP3/5DFdbD1MN
 XuZGz2rxxgXM8mKLbvPlHaCo87cfYSqcLDJhOsGNNeuKixlXqdBhDzKiLsN1AuWA0rsFSlIL8I
 wI8=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="230715480"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 22:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqkgeXLZ0hVEoEezKDmSwBb9Jcy+liYBvvzpUsOGSSvdLAXpP9pCNXwtzQ9MeQMlZF6AImlvgmxOsKYp04YgzYJRJ+uNDZEcBaiuwTLBsNcEWdSMQRMREMELaPWigSgZK+64R4gD+4VDHFQF3djjnnndnnlZUSrKMXBmd1/v45rZQoPZR1KuR2nhkaVNwapxlE+Di8axHx28UC6C4Ydz/i0VdThtAvLinT7IcXXt2EppN6uHoemhv7GZB3V3Osrt/9Kx7HpFzOOImIz7u259N53tU5mebZNe6j0B6jLLo2vFb1heBhne+rvKyFFJWNFetciDvyZ1983VsI3QKtMj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=MUp51wFho2eXJnPzFTIgdylUb1PivNq3zl5oQnXmz4JpZjiXLCcnrco28JKPs0jwYHZMF22xMUnjQMmPXHib4/rksE/ijlqiNU+yD0+xV/ytwvqeF39Rt2aZ2TJoU25jLfRaqzbM6MVbSVXQxVuG0f04DDEnr6Wed6jhwHslPhRugkNW9xkHXSz/buAsp0t7eQbaMmRN5HSDjErTWGEGVS0o5MLCQ5IDEwrc4C9jw0J60F0Zam5SS7hqn1lB5cfT7C+gg9uXtfeaDeeVjjW0mnIyQmKj8aywNQVZHvdAhOjjXpIewE5pqXLG4UGC8koj7gkvmI3p4h3QAhRbSbkXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=eN8uaIrD9Y5/80YvvYj0X063d8N+S7ymNS8Qvw/1tAfXHpfVEMfR0zuaXpJJAAOLb4Z5WPJ4dzpSLeP2oI/8y1MvUfyB+nF5hu2vY09l7MYPbELUl87bfleDpmljfA4ce9DPANSja0rGiMbLyoONsSjNZ6gBPzicGb0/DRfy4dE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3616.namprd04.prod.outlook.com (10.167.140.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 14:46:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 14:46:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use
 helper for delalloc
Thread-Topic: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use
 helper for delalloc
Thread-Index: AQHV2Ib1/T8+8tzdHUmDNEeC4WTR5A==
Date:   Mon, 3 Feb 2020 14:46:22 +0000
Message-ID: <SN4PR0401MB359833C930F47EA4E96328329B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-10-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67000a21-9435-45aa-f5ea-08d7a8b7d62c
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB3616767F6027894DDC652E409B000@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(4270600006)(9686003)(316002)(110136005)(55016002)(478600001)(5660300002)(66476007)(33656002)(64756008)(558084003)(52536014)(66446008)(8676002)(8936002)(66946007)(2906002)(81156014)(81166006)(76116006)(186003)(71200400001)(91956017)(66556008)(19618925003)(7696005)(6506007)(4326008)(86362001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3616;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJE0KVzuJC/cqEaZ2KM9t+BbsR2W14MxFhbeOOMMJj5PNB4VPK9gs6mV/nfgzMqKhZxc/hSECZOR0qY9e3IpMhdtsvSX2BVNoRyaITUvtkqUek2A7RknXp68sFZmekG81+WiFrT7rPADeouXrIov+OdBsiAT03o3fkQyaiwyOJlKYq8I3haflZ3X1bTjis/WCYWZzbPMfmDhLpoMBBFSMWX0+XFigBZjrYaI61b7kfOkQP1XiyDc7bmcNrxRtvBKIzKPTr+nSzsiWhNS3g+69CaG7EKvKI9sxRCwuqiRvtePb+DqoLcyPVc5rIjYIUWR6CPASUD2JkailJ+fHNBSBxhUefIpFwy+j9Qd1d8RcKmOvTy/fb48brrip0D7C85vMrRRFNlka33nwzvw4lyUxOhJ5t8FPkofCD3oefw93h5BZ0jFNCVi1oSwk/8deEoG
x-ms-exchange-antispam-messagedata: BPNzjmyjtJQEwnq+QFwpi4N8xHxjUcYwRntwr+g3edXvh+FIFSMhzeGkOYmxB4cSShVwgWXbM03Ifz66wdU1JZH6qfzHKf96TXfIqDi0BHGJ0NA/b9kB9wL0TdnwP8E4AJIst/E3rwoEsq5XseYUhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67000a21-9435-45aa-f5ea-08d7a8b7d62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 14:46:22.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y35v2QChgwOAcfpII95ht9gkeHC0zDwB7vYI0AJ3uLAHcBvrx8rNFphW9aARmgmuExveVkeaK4XRy/Vw1Q3JXH9PXuJzcFxlKPnd1WJFdxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
