Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78396162B1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 17:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBRQyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 11:54:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47089 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQyW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 11:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582044862; x=1613580862;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Im0pXJflXd3HEWymGTCoKWzdrfcvRHG+yK8zmZVngDc=;
  b=qlgKKFuwvZPtc6cvclu6yGIKHdF8fPszXt/FQaHkJP/ZY5slaQuPLJJE
   oUAPwYcZ9RQIS0r9SRafr+Gy0DOLi45BN537aXwYT8SYB9QshfYBdgIQ/
   V/wq6jA1gwNQOrEY8xzskoBVJ/iQ7MHBwAlukO/JNwNakYuYqm4R85ACb
   yle+MIafbHX1aEC0sdNhcW5X+MYTV79PPXyCZcH27ghxYskb/Qkw9Qgcm
   vESbbmo1VADH5B2TAK7YyRgRLm1ELw9ZsQ9yZVRXimLAG6PcQu+uTWmWQ
   AOlF7YLA9lzn3MZVEG/ONYtu1LM1Ga0dJ+24qPTkz24zgfl/b6hkG9M8R
   A==;
IronPort-SDR: VPDIRtD0ljlJ+lFHQj5NRAXGvXLtpA7wL8AyPd2O0UVJi0IWj/P2WZcM8f1Dv1xUu2lb5eci2m
 1dpwRBsGxE9TgB0KgjLWdHFPMpwsyENO9U0KP/YtCgPml6nCxqys5/Ea/7Y5mzdr8dCBqOwXfj
 T+DpfdXLWBiHnNagYnazQuTof76SohU2jBeUd6wA2otqdr9gD9pnATPG//DBJkZmnetJ+8xFVG
 Cxp4eApQe9pclRw+6hS9V4Tyd9jYqRgyjZrnv6hmlss5NViySRjI5G8hXRs5GJw3ovF/wqfluP
 HFA=
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="scan'208";a="131550114"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 00:54:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQwT2TapN5ANZEXIzVqYm/fZ5+ZVKtoRrkDKhhkzQ9L5T0aq9OuMcRl51Up/5x3kx0UU74B6b6lAA1ZAIFIvp3QcTgx9IfozLGwOQD7rQiNK4X1YRAda4ki8wMav95hiSo4vM6B+1evCpmz0mKK1gKgmCBZAvvzAI62Fbtwfg2JYOgrDeohdQPkaDd93dSLZDv19nEz7QCa7BXYLGpIKsGBPv2BW8bBt5Du04JVDFIryWxUrfM0/t2++LkPJuyniorUdU4qOpmpxlsd14XnUMyJ2FWMOLqj9AleFe7LsfkNt+fR2prZiKR7VObXhucc+OH8ITdiBVVq+l/GbfH9mRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpcmbgSGiV638mfgcPQ2xfSGjzIOEC9Yi83VlkTSEt8=;
 b=eQIOBmDNwVzqdPSYNL5KYWsQx1kVn+Ae52Y6Xtl6qbrGKn1FqYHQE5NHh9i26GtHJTnGDXuo+VXU8F+PqJSnbwxWyDeNI5XSilFfNXFzokNZaGn3YBG/DpPI5ZKQf9fHjT4GmwbA/GOxkGjd2H7/8it2wF3X9N/Dy6UlzEv27gXIsh2KHTQTN/49tHkZmqdzyxDdizPPmzV1X5JhEYPgLAyvuX1UxwOpsbbJMl4D3wx077l2k6B9wwyvEVOw9fntZZl3oby85XG9rYOBQgOOYyWX9leH2RYBlD0UQOqcZSa+PDD8IZlleODlE1kXVNK7O3Q+vLqolJDgWv+Q3TodSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpcmbgSGiV638mfgcPQ2xfSGjzIOEC9Yi83VlkTSEt8=;
 b=layLuazRLbS9ddI7q8TrjkBaNFOtwjH2nHK8wTWF4mA7k+S4vl8baZ3hdq5WWdMg2+mj3UHoD3AFe3iwoo//GakMD4vpdz/hXkkgRnEcCf6acsxNPcFmXGLdzWehTjQkDmhX1hPR/4juz9PxOi/mNpFv7gv1EnQTgallHaHN8c4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3599.namprd04.prod.outlook.com (10.167.150.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Tue, 18 Feb 2020 16:54:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:54:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Topic: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Index: AQHV4oZpxF/89/7YtUyR/3LulYl7tQ==
Date:   Tue, 18 Feb 2020 16:54:18 +0000
Message-ID: <SN4PR0401MB3598373E76D2D63694F8DB3C9B110@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
 <20200218165026.GS2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55d7631b-5027-4d47-6018-08d7b4933216
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-microsoft-antispam-prvs: <SN4PR0401MB3599D0A5D6B830809A0810369B110@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(8676002)(66446008)(2906002)(64756008)(66946007)(81156014)(66476007)(5660300002)(81166006)(76116006)(52536014)(66556008)(8936002)(91956017)(186003)(55016002)(9686003)(316002)(6916009)(478600001)(4326008)(26005)(6506007)(53546011)(71200400001)(33656002)(7696005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3599;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvU6ka/zFOyZ3brUy8R01knAjaUHN+jCWKMLCdBvIgfXq3GrAWkkz8guUrstJS5FeezFSvMZL9dghjKA8bM39UOmjJdEKPegdobYroK4wh3io9ZhmKv5JTZ9WTO6ODmjeVi2S4SxQsSVs8hX169khaGdbwVUD0Q7X+I4aJKor/NzBrW/iPRGh7I85+gVwfgZDfIEx+zhtXWApackEDISlG/d9WMcKsbzJ+cFSUESe2+nnJKYYDNLGz6Io3ivMo71W+3uo8yZb6zzYJ/JrIWOzpsCE+6u3qNcuFlw8j0QEAKf032gbbLotcFVfv0PsP1lT+f91va9kZRHzxbrf5YJV9kI/jmtfCgLsmB18pwINxw2QIA9LetME5MsoXrq34j0i36LhJzoz9SDRbPp3DTSvf8hh7QI22eOi1HQAcHUZyazUiuqK7n5hXSDIlZHtucQ
x-ms-exchange-antispam-messagedata: a/ETpp5kI9I3/nz1JTi1iUHcOPXfIjtLy60scucqLDUaK9MWo0hnY4QLBgFW1XveySuTLWDSNT2nSXZNkpnZbanOQleEmjh8tW28I8SDS1IR8ffSZx8Cq2EF5E5iL0Dyo3zIV4o8ezCeKnMSd44jGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d7631b-5027-4d47-6018-08d7b4933216
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:54:18.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt4PV6QPJsWFy33ezqRisfgE5Io+5JGgbdtD3gWigSRM2YQXJfgbAyVrMqQtKeRtdAhxplVh9siZY+zdJJMNPh6pFA47g3IxPJoFMmJhTFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/02/2020 17:50, David Sterba wrote:=0A=
> On Fri, Feb 14, 2020 at 12:57:58AM +0900, Johannes Thumshirn wrote:=0A=
>> Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages=0A=
>> allocated in __btrfs_write_out_cache().=0A=
>>=0A=
>> The first patch in this series is freeing the pages when we throw away a=
 dirty=0A=
>> block group. The other patches are small things I noticed while hunting =
down the=0A=
>> problem and are independant of fix.=0A=
>>=0A=
>> Changes to v1:=0A=
>> - Move fix to the first position (David)=0A=
>>=0A=
>> Johannes Thumshirn (5):=0A=
>>    btrfs: free allocated pages on failed cache write-out=0A=
>>    btrfs: use inode from io_ctl in io_ctl_prepare_pages=0A=
>>    btrfs: make the uptodate argument of io_ctl_add_pages() boolean.=0A=
>>    btrfs: use standard debug config option to enable free-space-cache=0A=
>>      debug prints=0A=
>>    btrfs: simplify error handling in __btrfs_write_out_cache()=0A=
> =0A=
> I've seen some weird test failures and this patchset was in the tested=0A=
> branch (either for-next or standalone). I need to retest misc-next again=
=0A=
> to have a clean baseline so I can see the diff.=0A=
> =0A=
=0A=
Interesting, can you forward me the failures?=0A=
=0A=
