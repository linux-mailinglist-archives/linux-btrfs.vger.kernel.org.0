Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985CA1547A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBFPSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:18:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2841 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgBFPSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581002314; x=1612538314;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rq3HqZgew9Itmx7arg+7I4Yu69ZYxy+BEQVz33U26zs=;
  b=jLh4mzMaPUNu/TfdQnwZRykOJkg8UBccE0Nx+BJ6h6D/sFhb+WsPwVDc
   gKq6ctzxz80MZ05bIYuX/+u7lL4DC3axjm2/worrlwPwXyTJKCPKueyq1
   F/jtqn6ZOyIAy3FLsl4PN1zHTxdATZ3DQ6aJ7Hu2ZfXmw0PAMFmEcOJv1
   +qAF6ePabSfzFFvZ0MtrgtRT5zfOohZGUy1ZRj2JLC3mu5VXHWYAOJlne
   I7GDXTbFj7QpYsGC0tBGMRPDb1MNd2Qx4BAiPHP7I5prSea4FnNe7pn1j
   VSp8mPHoDYiFMhbkapAQKJa/krPlH9GA3lhaqAmsrwnj3FB/3+HfXlR0O
   g==;
IronPort-SDR: cfCLN5VKqGaMraEjDxr9DcKS33fqbpbD+clJc0Desc/W+Sy4yy8PhkH8Q8wrxC3EFCYNkb245C
 syHaD839GvS5UbFCHVkiLAecd3akUGHjVBkqtytdA4Z4+KUxLTTGxLsz5Dsn6BGiAYihhNfNgq
 Zsk8LEMs8JV1FxTJQcP92qy4/lAoS7j1Hcvv1JWjyYrxWDCHLJ6vTyO0Jblk/HJpEf9ZVxV+cT
 ZhMKdlTsxrDyxzGrOhBacEWEtKQruJOZUNGWx4kDpWJew8WTPCEUSo2Uaz6LMTTOAm3ZV1oZdE
 nVk=
X-IronPort-AV: E=Sophos;i="5.70,410,1574092800"; 
   d="scan'208";a="129807732"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 23:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6TwN5a/05qkN6othJ/wVkDbWXO+5bFyOJ//REFTw+EhbPYNpmhBe+Jc5EIoL1jexjIy39kpQKHY18YXSsntQj8c0+j/5l486GbSlyGcf2z3UPEtybkMSs8PeebrGskBc71JOlwOIKoGsqSlTXRbARoUwiqxyyVIXO45rCtvr9rO7l4Kzd/lNFtAxMtyDWw6XTE9suZOXRCBCq1kVgu31rqs42OazDA9DQ3QtRr+PLqrunPSe4vJQQ1SjF1rTRxyCnijYg5nlXeDOUw8k5qwGbdXOe8jlwK+N3eFPbXH+rbmcpiEHWwBTsoheAFehhXelBBoA4djUXemeYQdPfAf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=268et/pdm42own1rZxkDtteB2uOGnlPRy3o6t0rlO0Q=;
 b=P59eu8bk9AIOcqremF8MEnrFTIU1JgLZozWj5gHgjI/FnxN9k5XHyhANwKXjnd74hzlIWPOrj8g0PnN8k+7PqHYT94l4jW9SUHDRXxps6fBRAFYwXwsV53g33fGoLcXBbYcu8P/ZWOwra/cZB/uH6zmxHOe0WTMoCKLIQaVW4c3/EMRrStvXumpDx7XorHRBTI5Kff15OzCbHAm1SnIWW667D/H1zg+A7dbp8/xASa2tBVbUw/M2s4sZlwMssnTzEwD39J5sQ8xueMGD9imxU4W4h1TOqfHR/1FyNk2VNo1ArF4m2kd24XwjZig+R3Xu2KeUo+mz00WyttJWdQKXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=268et/pdm42own1rZxkDtteB2uOGnlPRy3o6t0rlO0Q=;
 b=SvkKYIq9QYijMlvJKPmhN9yZLkmxyqB2+IZk0hUf7Gd8EJvEk28AYiOr6uMGzSuUcZZmFn7+jzGA2+zg+k2k2Sz/+81VT6598CM4REigCLb57m4CdQ/pFXb24BChw6I8UQvA5GdNSgR/xkvMN7oFBCFhuVD8oCgAJeqoa+TirTk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3629.namprd04.prod.outlook.com (10.167.140.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 15:18:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 15:18:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Topic: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Index: AQHV3DH4TNBI3u/6K0C9PnMIQNMzdw==
Date:   Thu, 6 Feb 2020 15:18:29 +0000
Message-ID: <SN4PR0401MB3598EB126524271362B5176A9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-3-johannes.thumshirn@wdc.com>
 <20200205181605.GA11348@infradead.org>
 <SN4PR0401MB359893900DDE52857064A2CF9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200206145921.GB24780@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.193.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d652a74f-4b4c-49ea-2801-08d7ab17d1ff
x-ms-traffictypediagnostic: SN4PR0401MB3629:
x-microsoft-antispam-prvs: <SN4PR0401MB3629693230C2D0765077694D9B1D0@SN4PR0401MB3629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(478600001)(55016002)(9686003)(186003)(6506007)(53546011)(4326008)(26005)(81156014)(6916009)(81166006)(8676002)(76116006)(91956017)(66946007)(8936002)(316002)(86362001)(2906002)(71200400001)(54906003)(558084003)(7696005)(33656002)(5660300002)(52536014)(66446008)(64756008)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3629;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9UOMyPKIBmONK+JGoxKG8P7qJLq+4Y9UVY+CTevypNSRqXxIbDIirPVUdMUdm4jGFLp3CwSuhfYbdpIj5Ga676QmYjtUCfzIF+q0HXLR7Xb+7f4SnMlVcnW3SJyW1sxp3y92sR6fFaWGp72XW5Jk6tU/FQ+iP0XkDmgAbHg92DMhK6sz88bAJcJkXlK8KeyNRnSEqIqAJBkIiMWYQErRr31fQSEy2Uo4334IaQuELvo7vspXHmDW+bDQ/YV7GP4IP+HxCWAGJC9/9nxE26puRsUK84mNcCFJqdvYa9YzldjXfHr09xnKfk1y1qABnGFPYqhoNkXh3a9GcxX2g/9Gbn1+tKQ4nFtEfTmW75YGfVVhfv6eTpcxhqR2QjykOLqFoAPJUGoye3GNjF6nNyZ7mHUgm3ofbO87W6ZqeKTc1iagSbORJQ1Vvy+dmKSp0Sf
x-ms-exchange-antispam-messagedata: tdHBL79Yflq1PVI1kQMtkNDUiAcrKKUXI8VILsAR/YjvB4Fe86IN1BKps3mRJQH4tA0oB3iIHst48x3wEmkGQdBkskVwP8jJngcPwwmpnPtoddrvpHyaAcmhRSuUnomeohucL/mRDXX/7Q05g/e/9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d652a74f-4b4c-49ea-2801-08d7ab17d1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:18:29.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hkuh6c4LV66aIJJgBtn7OfTDXm29CqzuWoUgk/FUF+fjjXfdeRugNnOxP/40NfZW+U7+fErhhoB2flOF2VgscJsFnJIvuyAbRzTkRn5r2X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3629
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/02/2020 15:59, Christoph Hellwig wrote:=0A=
> I tend to disagree.  The simple version is:=0A=
> =0A=
> 		bio->bi_opf =3D REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO;=0A=
> 		if (i =3D=3D 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))=0A=
> 			bio->bi_opf |=3D REQ_FUA;=0A=
> =0A=
=0A=
Well let's use that one then.=0A=
