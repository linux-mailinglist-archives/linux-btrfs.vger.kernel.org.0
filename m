Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB3B47A56C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 08:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhLTHcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 02:32:53 -0500
Received: from mail-sy4aus01on2078.outbound.protection.outlook.com ([40.107.107.78]:5248
        "EHLO AUS01-SY4-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237723AbhLTHcw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 02:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaOvRc60rnmVFGlqSdISd0kP08zZBhg5k+SOPOiEwQlKZ7nzmIyQN494llONqmzx+WISHHnIeWGMGYFskNQxD7HxHOdEEI7r0HXUnF5sw7n4WE617260OLUIRMbbd/fC211o2+fX0IBlJ9b5E2O0C0gOnnHqkqlpvlTMRNMAZLb5Y1jX8zR28kckxJGQYGgNQ9FTeFLbwOj/xdyJD66ck2I2lpZpPeSh5cM/xy/t8MavyNAOhKl5170F71aWfpUNfcDDqDQKE0EfgMExhKZantMWwcDemo47YY1E1ysTwfxfqu631LRA5PQtacE3tKX6GZsI3cwXkaV52NbtSoy1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD3+vOgy/5WHFu+D2RE1cHNvSwGoDNfAJyJqFKBtm50=;
 b=Ae20XePH4PYDRlhYwwS6+4qpKNVRHCXU+1H9WIKmqh2plHKILOJdajfnzvwACjdf8u2MbetfzyBMhJJtW5/5OY2xfJEQVBn9/u7gjwEax///vHiSUo3KjFFNaos1CRqZnCTfiZfTpDRxSpLHQMuuxPzFR4tcGv3xbMDrGXCtEkpHBxzeLYVyz6lx7SpI7u54fae9v8AVfqHvDnKEsPxtqW0DV5zTl4lQ7sxpBiJVS0YC/y7BqPZww9Tdc8Wq3Nr5+AyAZL6E6PMJfYXZQLPQbO4He3SghhC7Xr2ERjZv9a8GtljmGF/Z/oGi/iEC/gVOVHog1NL4TZyKWNgSyXEf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD3+vOgy/5WHFu+D2RE1cHNvSwGoDNfAJyJqFKBtm50=;
 b=NluIkIJag4sltdKSPQDH8u9YJ6f70tuwa+Vosz+zD129nWUj5e6XPqnGhc+D+7ewy7+GeI2oDhM4RKOSpgFM+T3wJZqGYFmU3w0geQ+PmPfPDY6m+AUvHN7qB7wQrjrZ0KHC+7vT5ZGnpodWE6s1H5hOB6QJ2+nY8u5i3oDAZAg=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYBPR01MB6240.ausprd01.prod.outlook.com (2603:10c6:10:106::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Mon, 20 Dec 2021 07:32:50 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:32:50 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Unexpected behaviour(s) when moving a filesystem
Thread-Topic: Unexpected behaviour(s) when moving a filesystem
Thread-Index: Adf1ceX7GW+PKTnDT+6go3Dwaa8qOAAAcYGA
Date:   Mon, 20 Dec 2021 07:32:50 +0000
Message-ID: <SYXPR01MB19189B0E2C3881961FBA9DD79E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <SYXPR01MB191829975D48C8CE863888A19E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
In-Reply-To: <SYXPR01MB191829975D48C8CE863888A19E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8139aec-d8a9-4f1e-f3bb-08d9c38aed50
x-ms-traffictypediagnostic: SYBPR01MB6240:EE_
x-microsoft-antispam-prvs: <SYBPR01MB6240FD57D63E027FD6C4FCBF9E7B9@SYBPR01MB6240.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKnj+/yvZ+zG6rsCGyt5HBmC5vDWhl+SFSlD/4a1ne1kqXycR6mLJTIb+nid7SSbNURlRdfda0uBL6t0hcuc0lFMB2/6MPvXUNQGU74Atx8kx2AJ7QpEWam8BjQbjc1XbxAaqnP4YKyxLdsKd7tNDnz3sQAC6lOae1X1uTkdiTy23+PNHy67hRAPllpJx6qbo+6XlGBRXXeBhydPktQ/k13PJXxPBv5ZPrajPoolxxb3tW+8vIMvFUhA8JjjnNPFVLnt/hmFKsMVxKdq1qjPqlZZc8vOxXcqYDVwd+aNdOi4NBHE5z8nbu7hj03CctO2CyWayo8x7RB0ZUE8L/jRGW0RQkZmquykEE2AMRYh4oTm1cE0pftHYN2MSDHZUE2rOnn1kOECoKb1wOhZQcHPcF1s8UmJneuLBSAvG+zyE7Bs7T7iOCsfBvw1TN1fuT12qHo+/SkS2M+8GINFLmBlCt0dE0RCFP/vQ1n7a8v2D3NeuMAZ92M7glSki9vHPhKFXfM/WpbuiqX9dQUeXPq2pHE/IV7DzhyWtzb76omMfUC5ntYp9j49Mrq69tRRHi+vlw/nYP2oerdcknfov/DR4SLIgyNB1h3IPJxXgLfWgwsy7A+ujElhQPz85jh2iUojX17W4/aN3p9bZ6d6UaPLalGkfrvfhwZhEpdgy8VumfC+vTqlN0HeMdkpqPVR2GV76WTpebqJp4sEzxMd5exHiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(8676002)(64756008)(66446008)(66556008)(38070700005)(53546011)(8936002)(66946007)(38100700002)(66476007)(76116006)(52536014)(5660300002)(86362001)(110136005)(122000001)(9686003)(6506007)(316002)(33656002)(71200400001)(2940100002)(83380400001)(508600001)(55016003)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wnaL//09K8MDyHkhHgh/BP0r25uA5A8tSNffyFsiu8ous1C5JBToF/TW5VYB?=
 =?us-ascii?Q?d9Tq/SNUiFptt2rtGQQzYSVqGCmg9CkFCzFT8qObEZfzxgbG30TjFYNVeAGh?=
 =?us-ascii?Q?EHtsOJH+6ROVuVPmvOwAZkm4sVlAtXZIacaaH3hwWSLl/jWkKzU6wtGDUUN1?=
 =?us-ascii?Q?F/eAUOA/evxMSpqLI52QgrxLjZnwwjl2N0Gqa/t2RQcpNGIErQ6f2zzQenNd?=
 =?us-ascii?Q?2oQRS+2c2ukp7D5UcOKBi4ebwvC+ldOpa4He9TBbNtJTPK9h3vXxatLNjAM/?=
 =?us-ascii?Q?IqPe1uEfQM1iFR6Nv9W9nVo5qwrNbxi44fyJigl4OWZHMhMY4+6WJ9ct1mXL?=
 =?us-ascii?Q?ensk2WgB4eA4xRh+Racw6/POQcOaT/MDig7y4Bce+zuZOShYZnEx0+ZHeOPy?=
 =?us-ascii?Q?SL3tSHVFUDEIFduQxZms1Gmtns4uvjqVmroZVZWJEFwp1nlUpLV983HsqDeX?=
 =?us-ascii?Q?4RXHo+gO8Ox2OtLRKLPQCynQe1tZD1HlR9Nu5f30KfMc3tlgXih6rB5Xmi2Q?=
 =?us-ascii?Q?3E9NdgBOF96bzPXwj0dT4BOzxzTygz3vo2GRnfLS091kyDur6KZ8QgDY2/YM?=
 =?us-ascii?Q?hkwz1df5Q+9Q76T5088BqFnWrWmfvhduRepiW2pPh8GXIrzL8E4Ag2LTjYsU?=
 =?us-ascii?Q?Ij5KqPBfujiQ5T3kTyBA3R66lc3HoBZUoPztzLvDgMG+/tJsofCQ/x6gXI/s?=
 =?us-ascii?Q?XhHpTTC348V2C42QlYMqKi047u/pAaOctoYFhLHOSYifT+r1YNSzbOWbTSSR?=
 =?us-ascii?Q?WqB4NpITXSor4JEQI7z7+WOGm+xVLqBIHzpsu/E1tDeVpsBkDYWxHnbRMyls?=
 =?us-ascii?Q?rSSVVRMS7KiINaQIxQpPbpE434sa4fbVbO984AJRgecwwRcTEsmbFhdkPRof?=
 =?us-ascii?Q?9bE9MOptII1KVh2pr1hDzNh1eRv2aSOuS2NX2/2m2XpugoNIN1otSU3M11hw?=
 =?us-ascii?Q?wgE2g1NF3okI9gGAvu3vxVRl98danyaSkMiHIoHJ5pLEpkPKNNCEZBTR0NLq?=
 =?us-ascii?Q?Dsx083+E+G/2j7ubIT6xrZPm/UrJ3Saq15Yeb68+kpdXkDcTYbDos0vJNVX/?=
 =?us-ascii?Q?clqQrI5he2PpiFOW8S2ApghuUskR/0qiLcW9RuMZcreop1JRTrfnK5BzEQnj?=
 =?us-ascii?Q?FkPgGEEnXhygeUJA2nfIwXGzpe5peB0q1cdBxfiwt/ooM7NrEPY6Iadt5G4V?=
 =?us-ascii?Q?1HKKQAJxh36yQbMpTzVumVJTLwPW9gQvIY0168IK+5JMjWeSteq4mSXIDXAy?=
 =?us-ascii?Q?wit1XQQqr6CdyWLrRM40c4ZHeCZD3/nA7JTi+p21pEZuGpalqN5IQBOCltgk?=
 =?us-ascii?Q?I3gRPNV96FaHKwFkBmJQfSoZaGNfq2oEL9nSq1YFbRoxqMvxXQneYDN+luu+?=
 =?us-ascii?Q?QlUpTmU3pgGNDAp8ISgS4KborALXOGXH4IdtXKz/S5U/r+NotR9Ip2sDADv7?=
 =?us-ascii?Q?9bOJnEAq9ICGds3iNJDxVXxBWwtQPAWM8vHdJmAngtSFLMRGM5iySqG4txQc?=
 =?us-ascii?Q?b6avI1z+1yla/go1Y+l+pU/2XTnQBhTISgj4c2DCI6BnwtKRKZ6Qs+sYj17n?=
 =?us-ascii?Q?4hanNIbV4vW15QRfClxsod7pa0YdxAOwMOsA+B/eGPIUO1ZZQ9dE2tYNvc9a?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8139aec-d8a9-4f1e-f3bb-08d9c38aed50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 07:32:50.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZG247UHiX5QRSu6qyw21+QpopRAO8zuPMCzepGcM2C9RgF3Pcvhhmwi/Jm4MoK8kXGlMYsrKQA2+YAk8MYqlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6240
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Paul Jones <paul@pauljones.id.au>
> Sent: Monday, 20 December 2021 6:21 PM
> To: linux-btrfs@vger.kernel.org
> Subject: Unexpected behaviour(s) when moving a filesystem
>=20
> Hi,
>=20
> I have a RAID1 filesystem which I am trying to resize (only one raid copy=
 on a
> particular disk). Original size is 180G, on the same sized partition. To =
do this
> online my plan was to move it to a temp disk, repartition the original, t=
hen
> move it back.
>=20
> Label: 'Root'  uuid: 58d27dbd-7c1e-4ef7-8d43-e93df1537b08
>         Total devices 2 FS bytes used 29.86GiB
>         devid   17 size 40.00GiB used 34.03GiB path /dev/sda1
>         devid   19 size 180.00GiB used 34.03GiB path /dev/sdc1
>=20
> 1st problem:
> The temp disk has 40G available, so I tried to resize to fit that. Even t=
hough
> only 31G was used, my first "btrfs fi res 17:40G /" resulted in a RO remo=
unt
> due to out of space. I doubt that is supposed to happen right?
> After a reboot I did "btrfs bal start -dusage=3D40 /" followed by resize =
which
> worked the second time (without deleting anything).
>=20
> 2nd problem:
> server ~ # fdisk -l /dev/sdh
>=20
> Device         Start       End  Sectors Size Type
> /dev/sdh1       2048  94373887 94371840  45G Linux filesystem
> /dev/sdh2   94373888 115345407 20971520  10G Linux filesystem
> /dev/sdh3  115345408 199231487 83886080  40G Linux filesystem
>=20
> server ~ # btrfs rep start /dev/sda1 /dev/sdh1 /
> ERROR: target device smaller than source device (required 195292208640
> bytes)
>=20
> I've now resized the devid to 40G which I'm quite sure will fit on a 45G
> partition right? I think the source size check should be against the file=
system
> size, not the partition size. I'm sure I've done this before without resi=
zing the
> partition, or is my memory wrong? Too bad if it's just a raw disk which c=
an't
> be resized.
>=20
> Anyway, I'll just use the much slower add/del method to get the job done.
> Thought the devs might like to know about these slight issues.

Just found another weird issue: trying to replace devices that don't exist =
on the filesystem gives no output and returns success:

server ~ # btrfs rep start /dev/sda3 /dev/sdh3 /=20
server ~ # echo $?
0

