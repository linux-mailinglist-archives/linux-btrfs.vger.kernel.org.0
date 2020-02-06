Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6B154126
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 10:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgBFJ3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 04:29:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17404 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBFJ3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 04:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580981352; x=1612517352;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JPqF9Sud3ML7FTr2grQURo4ujxeVD9thROtucSOWOew=;
  b=F9U+TtRPFolQrrUaBuseTIiA0Q3fwuFBv5YgV4PX3yYDxZ95Ai/k8cvX
   IZeJZJSrXkt6ZuOD86qNO1LSG/gOQHSJrhG9GSJhoZzjWQcscd9HuVsO+
   Pj32QWPZIAjeNVewrKXworc+dPzCgfpeJZZgb72HoNYw1SMY27tVt07Uo
   wE3SpMoW3BjBy8ypDmKWiM34DRXHjACaG3/sKKZVd6TBQTQPtb76uTuDK
   1j0SfN/u3iIZAL3NMuu7YMpAMIZSJ5xhEsWY+BQWoBsUDnkABvLuid11F
   O1MVwqZwOaTWD4tsU/ePzu+71dz3Kn2nXDamSmZLDwPyCk3RKgoNmVXAi
   w==;
IronPort-SDR: Ksuq7hYe4MzmLQGrfZEWytPUsd9TBQoCMBH8JfaU2it6dM/Gr2mXIVVuthAfQLqVn2xzy8drM4
 fXdpYxdn60c4DGpL11TVD6QAtxq5V1Krg5TVCbC9Wi6f7NRqXuurPOhdVdrn8O9R5ilLqDTTYl
 Fsfr5hqDvnbYi0lYveID1ddsdLE0hJJyng8tw2JTUKL2uXuQxeKmAYlO+dc0EIPdIsR4Gy8y6y
 CfwqfXd9/U0OwaKxo28+R2DrQruy2AKJ22SzSrV/FMGcoRCVtdoTzDDgdN44bbNTbZBULs8/3W
 gqc=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="133586721"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 17:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwShnKuCtBb8KLjo2NkeUlRhUmu6Y+HOwIbvCTOfOXHd08Ass57fLYCPy6kYUb8uhMXxFFx7YQObVhkmGjMmsPkkRRZTXmkDPbSqyaBh2Hq+rtABw7pufLj7r9ZmMOszTlpwmbuh77GniltBUhYJZ4DRqx/YzQVN4ZlgugimyNaGTuwK2Uh0z5hz0zE0f3mS+gln6733T01FKMK0IUyCrMHsbG0aG1TUolUvg0AVacNatilY+uUTzb4fUo8fO4LbjYl/KeGL2pKrG+4kGxHvtIL8RKrYSPfxFthM5KkHCGCunUp6BzygMV6swvdxIwWdMNtMt8EyVe3Uu4Fo3dYRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwGtpBkfFPVbSqOidkY1ZyAP84mSHmS74Up6XvSebRg=;
 b=LotE9Gyq0fva2AOhMgQBqQJsOp/BtcM+sZp1rqvyyDuZNAPVwGwxgn29ESRcj9jGFP0JQKRbG0n4m85ngsrXSzV9hVTrRO6DCH6c81OlICFxcdtcbHkv/5yaC8llmmmZBXkniy5l78Mf3zTGWV/5k1KuOk3c1ETsoUqL/8ATI8ICoheRKlcKdUUVm/ihLCEyS5wlpSWMMwPSjMl1io9sC/LDhm/go2lQxrz2yC2VnWf5pcnPTcUzG8488jORX3rdoIEOyi604VeyCyKHOhgjMGEijSbBbh23G2n79zwNBJuR8wr20xDOtmTDt5X1sHPs6hdScWa+GHIakG9gxMQD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwGtpBkfFPVbSqOidkY1ZyAP84mSHmS74Up6XvSebRg=;
 b=FZ/lwZwC5w++YB6FdRk/TDLXJycRitwC+T50pO1BpJcq12EjJzKlkdwOLqoMuXqJXFLuBx40mMk2K7gkhevnqHwekKVeqtzLbsqOpqhQHruyAHpihwRwFnfwMJx3SiVJNGUPgrpkPxkDafqn6+G8tsbZd6jkH6Ky+U415OTOJ2k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3696.namprd04.prod.outlook.com (10.167.140.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 09:29:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 09:29:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Index: AQHV3DH3mC4sQyE5G0ifuyrJtqLY6Q==
Date:   Thu, 6 Feb 2020 09:29:09 +0000
Message-ID: <SN4PR0401MB3598B1070BF19F6C838A60C59B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
 <20200205165319.GA6326@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62c2fe91-8b72-4907-711b-08d7aae70555
x-ms-traffictypediagnostic: SN4PR0401MB3696:
x-microsoft-antispam-prvs: <SN4PR0401MB3696CE2199B39997A2BC3ECD9B1D0@SN4PR0401MB3696.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(6506007)(53546011)(558084003)(186003)(26005)(2906002)(71200400001)(7696005)(8676002)(66476007)(64756008)(66446008)(86362001)(66556008)(91956017)(76116006)(478600001)(66946007)(316002)(81166006)(81156014)(55016002)(9686003)(33656002)(4326008)(6916009)(52536014)(5660300002)(54906003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3696;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ni1fYnBQ4a2jK4WdGmlzkYIGFa2tPCdNFI9NhgSt50YaZHtSm6HEBEv5EaYDkXV8ej7qKisDQkxmZdM7lz4sDsXN80P+MMa+++HF1d7YFIeF5Xj0opCpdOwHU5gU6ew6z5a92pR9lXoMyOg4zpnCipLevjgvjCRjhjoDquDUwmf8q8hHIb+IDoI5pBrRLA+q6AFy9ZJpHNpjDOPaWnbjOFzr0ubWnQ1I8UIEVwHEhK4bzxGwkF8cuuNV+AyojKMquJ2k/YVZcycc+Eqw96Ad/RjnqemcS1wRLakYDRUWn+/swQS0ImJeN6370VLhkKpOn8SRBh4E3DumqdLupmgNKgYjAkCV48Pd8bQG14OTX5w90xy2NzdffdM/KdjKk+jSL9tYOvWxG27JljwqXUwaw+OLmiL/UckTVh3sIipcK0wDZWuvhtqt6LjBYS7cc6R6
x-ms-exchange-antispam-messagedata: QSke//bZKEpa5CioiRw/SdzRjvTJea/nKrZWFd7bH0yeY54i234b3KNl/O65Ta5s1cKc1+NWHxB92E0idvBFc0AjWxsNkES6kXPILweviA98KCwat61Awpjnml5k9QuMCWb+vKwHK+296FZCAFvViQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c2fe91-8b72-4907-711b-08d7aae70555
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 09:29:09.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scDWHzGDDkpqCTASbsGsl6qQHSrx0n7uqVcsfCk9MQfRKIpclb466VFXgE84l4j4gZ9qvWgfzZSDV7lGoFhC0KU7lygKICKON6SKGFZQi4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3696
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2020 17:53, Christoph Hellwig wrote:=0A=
[...]=0A=
>> +	struct page *super_page;=0A=
>> +	u8 *superblock;=0A=
> =0A=
> I thought you agree to turn this into a struct btrfs_super_block=0A=
> pointer?=0A=
> =0A=
=0A=
I'll do this in an add-on patch, otherwise the diff will get messy with =0A=
lots of unrelated changes.=0A=
