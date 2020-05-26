Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD1E24EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgEZPD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 11:03:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33826 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgEZPDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 11:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590505427; x=1622041427;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c/S0KmlL/NuWufrRLIXbVmf8tgPAl3cl5313/XfCp/8=;
  b=i14vs3R/dkfrcZvpo4eQwFWdbQFXRS+TNFqgtCb4xvFncQUWUskbFrlX
   nSNJ5ZfcD1ntWLq0vCksq5Hr3FZKGYRCTsGlLu5/gXvUajqlLqBrrzRP1
   4RQle6yootz111jh/DKu0PnDpXx3xeHWvpLM0okrCd9GoDyDQczrbOHvf
   tSaRvXxsuaqpGVxWuUt4kxQSjMW/fhikYJLYRvf67Zu1vE7pgp/uHiJp+
   SwK1SWe9HICFDrGqkHjcewPtfXKGwzjoIuj/X1TZPtcSypLIV8Wr2U6i/
   8OczSsiMu4za6c0wpa7MLtIqy2A3T269cvSfht38m4E795t7689hobvY8
   A==;
IronPort-SDR: C9vbVVGc1rA9TGNqYCfrbrxTqYrJHUGir0Ndvhe1HamBY/o+2RH6U+jMt3D9VvephZqqjzFHrr
 7h3R8ykasUX54QFndKufAHNil6uqk1TKL29PuXQRY2istOQmHWQ+sF3iIfDWyG9YerIOHROHrc
 XLvj86pmDv7XjYYv3AjxbDdLeZA1QJ++US56G+Lrj+l13+BBBcwb0AkJFDrNl983KYUluOzPMJ
 dnXVY3A0v0P3Z3/S2rEX1fk+RijVUC89bHRmrxwwt837Qy2pTppuLTlt3ox/scf4dkSMsKaKtj
 ucY=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="241331790"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 23:03:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV5zgU+Z142dta8DIyt1kILOA1LvV2a0eDorzc0/cnFqecd2uRCDAZl+JBBm3S84zJDodsp4HNvnnx6gDicOAvojczI7f8Zw3zGTWAN1h1se1zHxPa4lE1zQs2BzbXk2P2WKrKEUW2nsgM/RWAK2LUfHUfH/dVTC1juJRfBooMgIllJYHGJhHld24Pkn3FG+heSyagtHJFJmTzZItlKQFF+RnuvGcRKLffwSLnTG57xDPrUZXrJ2GQtADshXBNuCSYnqQveSuvQOwnqWK4CC36pp+mOJePpBO3v5Qvo6Jpla8L1BR/fywEboXm4m9Z6jfZWeeOZSN/ivM3UtaF6f6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhLPuBdNFgJU6GyiJqoRhaUw5b+jzPPKs1my0ZWV/ow=;
 b=QD1lKoRs1fcWi3SSBCmdZXLhmRQDlfcMoWShImXhyvW7fzfhuEO7IAWMcwefpm0cipKTczuyh8gV45F2fs5zgQJh4OOQZ620HXwKZCGlH1iaw4DF2Mcjg84o5H27X7Brg1DULPfpQTAPeW+tlwjO+9zN+gcrc1SXj+r9L5Ds+Qa8AfHsSnjRfs8wX3N0htB1EM3NYcP/dlgHPFtunGQv368pDoNDl23I4GB+3EETF9IGtapnb7RhiNgPBjYt/9R7UbErkS+SGKV7yTzXgSap5y6v0Mgjs8XerOn+R0vA8kqJnG/6SUB9ing3+r0Ua4tow52VC6KY1VqdxHu9n0Ybog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhLPuBdNFgJU6GyiJqoRhaUw5b+jzPPKs1my0ZWV/ow=;
 b=kgzXB2c8oUnuf5qs9fl7LEdY1Bk+Al8JCO6oqhrHpGsYJRngaIGkR2SN+uLdjds7On9klC5l4jt4b2VVmx6DWHlAllF0US88hpKaP/KIN0H1qpEKjANhjsH0g68ejuW2AMvGWGPnEr1wLPz66kSodIFYcWdyYbLkerdWHMQSpDk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3614.namprd04.prod.outlook.com
 (2603:10b6:803:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 15:03:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 15:03:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Thread-Topic: [PATCH 4/7] btrfs: Switch to iomap_dio_rw() for dio
Thread-Index: AQHWMDX/eMsyjdaGjEG/aVl6rTY++A==
Date:   Tue, 26 May 2020 15:03:18 +0000
Message-ID: <SN4PR0401MB35981C3BAEDA15CC85D13AE79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-5-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c70929a-3bbf-4e59-b25b-08d80185ece1
x-ms-traffictypediagnostic: SN4PR0401MB3614:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB361485F14A2BA4D71352173C9BB00@SN4PR0401MB3614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tyy073MsfnOFvkzr39+A5kAZBwyp4P9CnTWmkRX5kVY47aZHdL4hQG9LK2seDrMu0zDja6jLZvpzliwgzN22auF3scI6tJgT4MRbOHv+U67d8O+W8r4ZMV96uCUA6NJUKSnZsGHVC29ij+NZqi5EwlDKfGFPYpr3uy0RDQWAZnb4PDQ/RVT4DDNMCim3ZwkIi5/0a7jBBvtXtic6Ch9a1qS+YXJWBbpcMJzkC9cfQUc6E9Djew4IzmjybQGX1C8uCUx8Sf5aBP3Jn4GFAxqdvTv4Ngrn7w5ef28iSJptxu6OE5ifvx8pI9KThxoqD/qcyFkbHVnXqvwaUyLlLRZWkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(346002)(396003)(376002)(136003)(366004)(86362001)(8676002)(4326008)(478600001)(316002)(6506007)(8936002)(54906003)(9686003)(7696005)(2906002)(110136005)(55016002)(52536014)(71200400001)(26005)(33656002)(186003)(66946007)(76116006)(66476007)(91956017)(5660300002)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9RIA9E/b4QJhOK4Q7eB7y9ioBmO4Ugfaz1MjqrbWj3ToLBc052zSfqybhfygXoqdZXEukCOLFd4gbblZuOepDFq/Zig/Hnip3o+u7KD3hHVm0L5qtaNWn9EkNftXr4w7gsDTit+NcurgjCIk4lYidaiLQT4l8JM7DD+UrW1zFioQJ49OlNkVU7LkuOjp9ZvhTXvxfl5vqzkZii6YeSv9sYJtCTVtUhtuAVBrR6rBejT+rE+vYgZYq4UzFWv0aBWcLFM0ebPuCAqPsG/u2QuspqVRIjWjbjySuXMF50BhARoQwXviwJBYij/MY1ZmaODqxsT/zL9i/dz1DlSE7NkQBDExcKksAn3k22jrN2lJI3rIqLJvhpFlfDj+/tumzpSPSHpW79L/zY3WseiR/Yfa1mz191jYp0BR2/AD0UuVbZruANoK+LcayueIJjxVYmw9zFKV5g0iecR2No8Wq6lqP3krSopItyyQ/n50ua5p2z3i1AsPSEG0YE/vLx0K6kEe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70929a-3bbf-4e59-b25b-08d80185ece1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 15:03:18.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39qCSKHm1y8Ust7UpQsInX8UkYCEKOwcRVpOtMj79S5pLlmwuIxkxk5VDbwj5qFL07cdVJJ4IcDVjkfLS9a3I2JMzGsFEZiJE30gPcMpXAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3614
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just as a heads up, this one gives me lot's of Page cache invalidation=0A=
failure prints from dio_warn_stale_pagecache() on btrfs/004 with =0A=
current misc-next:=0A=
=0A=
[   16.607545] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   16.609328] File: /mnt/scratch/next/p0/d0/d77/de2/d5c/dc9/fee PID: 766 C=
omm: fsstress=0A=
[   16.743572] BTRFS info (device zram1): disk space caching is enabled=0A=
[   16.744620] BTRFS info (device zram1): has skinny extents=0A=
[   16.747458] BTRFS info (device zram1): enabling ssd optimizations=0A=
[   18.303877] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   18.305476] File: /mnt/scratch/bgnoise/p0/d5/d53/d21/f27 PID: 2064 Comm:=
 fsstress=0A=
[   18.768426] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   18.770074] File: /mnt/scratch/bgnoise/p0/d9/de/f15 PID: 2490 Comm: fsst=
ress=0A=
[   18.916118] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   18.917843] File: /mnt/scratch/bgnoise/p0/f0 PID: 2694 Comm: fsstress=0A=
[   21.170384] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   21.172375] File: /mnt/scratch/bgnoise/p0/f3 PID: 4325 Comm: fsstress=0A=
[   21.812452] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   21.814232] File: /mnt/scratch/bgnoise/p0/fb PID: 5000 Comm: fsstress=0A=
[   21.826027] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   21.827741] File: /mnt/scratch/bgnoise/p0/fb PID: 5000 Comm: fsstress=0A=
[   22.127966] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   22.129413] File: /mnt/scratch/bgnoise/p0/df/d28/d26/f3b PID: 5196 Comm:=
 fsstress=0A=
[   22.160542] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   22.161972] File: /mnt/scratch/bgnoise/p0/df/d10/d5f/f64 PID: 5196 Comm:=
 fsstress=0A=
[   23.696400] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!=0A=
[   23.698115] File: /mnt/scratch/bgnoise/p0/f0 PID: 6562 Comm: fsstress=0A=
=0A=
I have no idea yet why but I'm investigating.=0A=
