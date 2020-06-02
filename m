Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D191EB7BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFBI4Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 04:56:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19305 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgFBI4Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 04:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591088183; x=1622624183;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=etZmqJU+FKRzpmJkDgHTbFgGqE45V9S2Z9vgqYVzXs22w4SNBxU8gaAB
   9Q6POBeXx4QhAUiGftk2zGTpVSGtg6O+2nZjN1voBA6qhX6nq3sWOLSKG
   nHXoLWcLFGL8pZ6ncFsQb2U2NfyVpqCES/kiWFwZ/CIPVey6g78ZlJ5as
   WbUlJ/0y8I+3jM7AwwKyqNI4cJ5WFKUSYBPyxNHot88fs1tdLCbjY915N
   /wzX8GtE2ptO6ruXbniEzPHhu62s5iilFocqFCOwPq6VGLhszJ727PnBd
   wTeD0yCqq0ZSW3p9Vvh72MLkZyaLY3uAjS0KjFeBRlJKj5/fGJC8zZdIp
   A==;
IronPort-SDR: 47xvLEvlPSf0FBJhZ/GYloOUDL5r9Ec+9YeciCN7a/3sm2BETA0qSpUiXE5juc3BlM2WlhfoF8
 vxZfbjQvyOuW2CE5s6mgwYisyVyVoyJCeBqwREeOaus5e50pd8DrtoN4Gx+0RWXhlOpYUJZiZS
 soHBba3sgwRARx7uuQw5jLZ/PY8ReDCcBZE4LyBS3M7Iv8n+DJ5mAm3PucN290i46gim8efvbY
 OSn8FeH5AE9zggTzOZrO9YisNtGVBzGZN5Zu/xCwoyOB3fSLNI7H2xW1kr7W3rvbt4w87nmbNh
 VA8=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="140435905"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 16:56:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfcElhzNIllyDVRvcFCGRJWVBjCNXLEMXDTcSClvmY7yZH8VWBFd3hjoU/2R33Zb4peEBGzxZC8JipNAuOntRWOsSTGnzDM/Q9ljCFisNhrbHPdjwbYGVflc12G3XZ0xLUGSLyVtocWVINVx0Ky/guYcDycvd0DPcn9dc2bmaj1W9vB8ltqzqhqPYa15hD1c0mNGi6EQsdp/l0hGqlK6BnIQHx71lwzRWbtAr16+7dN5JpFboUpDG0ASNJNNiHB1w83UOR0WJVWaCuEFdzrZHrN16mcmNFpPmI4KE+BwMnYOxPeGMikB5AK+DUkBjez41qE+7ciR74kMCWXYvOVlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OhN9Z3kMRHq/Md0uJddIqlNtsTMQDI13LRiG5sObcTLh1fh4YWTY/11aDmMwAJqOzyk8DyMWf1S99Pk/fnHR9i7HKVV9oFYEzPDK0jbNXred+BCBe5x4gBiKvAEDWT0aJ+beyEPbv7BwcBSujkQS+JOeKG3AN7U9HmjeH6+TmRc1dms1ys8yzivTYQ1TPN0ADuiHhsiy98K4KOLdMeMjadyZBNzZbVKnTyjzLrzlY61RHDcz2Fe0hndaCc00T5P6nTCxLSuUqHfEmFyVKFahZ9rdf6NgCpHMc3XVzZHcfTFCKcxvh7S+9S6uCR+j/hGXPekuN2sT3ge6DGRhbQJAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=yWz4sfEPFVs6v4R08hKQD4HfN0nwb0mEhMsvcb7OEv92LSRmcKkHTEadfPoiPvgrZOSRYaXfwmvD8tTQrgaSoB8hICmlEiKnfJGdjaJIaUYq4eg4Db6o0aCasMpQaCnBQgRp8bgyMFOmh23pCcMd1qV06L1CgbHz/G5GQIyZ1C0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 08:56:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 08:56:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/46] btrfs: Make btrfs_lookup_ordered_extent take
 btrfs_inode
Thread-Topic: [PATCH 03/46] btrfs: Make btrfs_lookup_ordered_extent take
 btrfs_inode
Thread-Index: AQHWOCq6NbJLVrc7S061ECH5xqsNKQ==
Date:   Tue, 2 Jun 2020 08:56:20 +0000
Message-ID: <SN4PR0401MB359879CA4C564C09418F0C689B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 852aee73-b8f6-41aa-50f8-08d806d2d1cb
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB3695D9F2CBD9BCFACF2EAC299B8B0@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnkQWHAHd8ab+pHcJQ+o5NidUDiyhyXOBFyfCRPQLfffLCJO99ihCH0pfP++Qa2Qfh+g40867OTURXlJZ88uwzPP5QaZ1r0CGw94jTtbYPPUQ9MXxLtm+N2LbsamITlSY5rnBs4QYyzUvIaqllzWI47dkXkJMaefuQzcOd0T1UpkQHjR1xMHTu9vVLIlGsYM6hy06x6lUELk4rvMzAtlz3tlhFd8yEjyBZL/XDfUv4H0dgJr65g0ZxbIahax+zHxy85xLc2S0esufqvt4/BSImRndWT2uVJYUjrQvBlvszNPSmiJZQUJGCrTT7aSXpM91HQWDyRqla7WjP7uBAyV+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(8676002)(76116006)(8936002)(91956017)(5660300002)(66476007)(6506007)(64756008)(110136005)(9686003)(26005)(66946007)(55016002)(558084003)(2906002)(66556008)(66446008)(19618925003)(316002)(52536014)(186003)(71200400001)(33656002)(478600001)(4270600006)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N6HZ9phM+cjQqrbbHfYPqnnP/OCeoe9aEDfEMyShYFKky4gnsEyRFpCas1Wh2MV38Ysh4XlOLlG8aSDL2ncde/Et6qhowwqRjTJf9Ry+yqqX2mq4+CS0L7Ob44NSv8C/TK2FX/egFrnYz2ZJNcPjDUNfu0jhWfPgfiPf4sqwkVEiNejWmwpK4n/1uOdaBDThipr5KKzYUUWSBl/ss7GEkjpmxGtZ1XmrNErL0Lvck16gD6l+fbPpkiVWQfek2PRXk+kA3yjcXVG5/wEC6Q0ejV3ZIDbhwhPi5P2eT4rkFRzniuMX6IWLSSeoc0aZJ89Ow5sTz2+ZkB0hDvd0C2UL5OXPSXfyuZhoz1sKkwkKz13lx7SkpPdenPaqnMHG+HSvXR/tB7VhadZelZyPlsYtx4fDPRp7JW9UauQUgeYKKinJIDJbBO7NxsnISkv1ReRJ2lQ/oxJaVDkkZOfugZGxMYjAONtVPmdhpllNu+75PbBueJNkL4EFJ71UUK4DsU8L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852aee73-b8f6-41aa-50f8-08d806d2d1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:56:20.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0dYfdU9XmY2F1/EotjRKFJH7xw5LDCVUx34Sy+tmH+zP9bOcfCN70sOsPQEuafiRm6I0oeFzqM7/z2T09po4JXgB2bLA/nQ1/liNnh60vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
