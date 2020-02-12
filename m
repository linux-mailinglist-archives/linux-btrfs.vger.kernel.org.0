Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEF15A251
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgBLHnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:43:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60959 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581493426; x=1613029426;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a8OZHuIxOoKON15dMh6jyj5i5QurKqo+2Va8LJAl8L8=;
  b=X5AQ1aE/PjLLsZ0wBsL4aa0kPqw7X+lN+gKHrfE6rgxS/d4p33Hfceay
   n/Q6vo1hY2CCZl55qrW+vvYIA+yn7jSs7aPG+5zFnVCr2u3bD7rLrgZjg
   6VFhjh3SO72nlaW1ciiYMx71Q0vC5grn5cpBolhciAFA8pX+kF/xLGO9h
   upsyXXktvN/tQfMVJyOF91EbHAaWegAGxi3jfZSI/VwPL2JhFwxMlBzZR
   Mn4/J5lE9LS8hFDL230TRpSR00ojBAwfgo7eRGJqUtzMX5EyDZKBLBhuX
   ijVXfKOa8S9yJzs3A+scSI0DdaQhqg8fVAeBGa/2/VIZ9FmcfsR9Bh1OW
   g==;
IronPort-SDR: gBUPMlVzGbuscnIkEXRLfuJsoefqmsoRdK6PxcMiAZQ+F//WzgbkS0xOLL11lPoEYD7Q4gdEX0
 EkBVZ9FUtfWaFOqc+Xc0hXpFWYN4M5PPXzApHgIKcpmicXfTD1PBnwnY7jf3dnj4S1mvcMqHEp
 PFxgNQud9N0PB3YjJ3bt1LEd9moWzRq8JEIX3TPlPR6EF3nlALQgim0OSH6DmKEr/27vBtKdWy
 URMOs24OQ7vUqJ+pFWnJenL5G6pceZJLO3uhYq6wJIO3eZ6AsktE1OKky/01rx21vhdU6uBKCM
 5lE=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="129652756"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:43:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYYReUZwoPKWROgS26oWab7iON6s3Edd9GMRD7fbbcZ96gIxutb3zWODSgn5Ih8DgGS2pdmL70UFuC4qSfY5fQhtbLHdCBbVD4iI2WtnQ2O6RCNEsIv46iqEoQTETsm32Zlmc/qQH0KswqLCzdhFyyxdf8A9SMFRz3E+0Y/N2/SVH+gZgN1vN1BJ1/zK9e732jpS5az9OfteMQCNNsJrbj/UFATyX+iQsyrcJRZTRjEDJmbwemaDP3T/VyuZKb2IUo6uRkpiPSp3QXw97sqvY0GNQ7fjQY6HJkUCm8xHwtKluFB5XO0F+GKsTdssuuD3jSX7UHIK8CmOmZoqoFPUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJkGKUtR5jp+D5z+r2HoVjoK1kv9j2jR8RYik4ImZvw=;
 b=Of+J17l/3Z6i96jStEqwMnq+WOcZOB3p9C717rmLQ32ERFHDtGDV+T5Tt8+OjMZzIQMwD6MSzkk+iHc7BFMkj30zFWQHKEGzq8MdqoXqfsrerod4sKmR3BO1RfMnMbdhWw1DS/XDqQpi4DZb/7YRqnAEHPt0k+12M17it+HBsI3HA0YfJ4/6IID3xMPhL+7tUM7/CcV4YdWOCAHwW0wypxijGy2GQWRmJQTDsCy+C9C0h4Dnwst718Buy5kVJX9aTdfPs8ub2ehf1WuZ30fuugOU6ZwltEfnX6UsyryteCwkPimGREAwUzIdMam9i/NhoS2Nj2La6UqFpW4DWNfb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJkGKUtR5jp+D5z+r2HoVjoK1kv9j2jR8RYik4ImZvw=;
 b=N5BQwTVMaVooA34yRizDSe+Liu7VGHEluGD2Uh4wvPHD/6iDZf6Byq7zdx9spqJ0CWDLhvdpJqkEEYrPKZDz6O4wyKlb6QYbGJnz5JIUqi+Gpq7tCBNv0hvPgcwv3EI84Ew4zy8z+8KB684/uNcHBgSZhB49xMpG20HCU2eWrAc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3664.namprd04.prod.outlook.com (10.167.141.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Wed, 12 Feb 2020 07:43:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:43:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 4/8] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v7 4/8] btrfs: use the page-cache for super block reading
Thread-Index: AQHV4XR7qF5iaqZ3cUi+Vbr7JQPOpQ==
Date:   Wed, 12 Feb 2020 07:43:44 +0000
Message-ID: <SN4PR0401MB35989F1664786AF9B825494C9B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-5-johannes.thumshirn@wdc.com>
 <20200212072846.GC30977@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d130015d-82d1-42d6-ae19-08d7af8f49b0
x-ms-traffictypediagnostic: SN4PR0401MB3664:
x-microsoft-antispam-prvs: <SN4PR0401MB3664A12446A42094AE7216669B1B0@SN4PR0401MB3664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(66476007)(64756008)(66556008)(66946007)(54906003)(33656002)(86362001)(91956017)(76116006)(52536014)(4744005)(5660300002)(478600001)(6916009)(55016002)(9686003)(66446008)(4326008)(26005)(6506007)(53546011)(8936002)(8676002)(186003)(316002)(71200400001)(2906002)(7696005)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3664;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhlgQOmIHQEF2UOU0FmSJ3aYH9OkgayeFQk3OLNXgvnLSCP8JtE5dziKuq+dvaxTPP6aNaoawRaYc9p3SUsDPOkNIWzgj8bdHD1inYyKhDynGoCPdI6x1KEziPY1QWos09YPSVcPCnAPNYwuNTUHrjyPRQL73SzTx6hRQzv5VdApNb2VJ94fltT7CpJ/WguJICGJ4rpbu+wus5zE/4kkpcYailLsO7W03999OMGiOSE1GAmlhhFdUGWPoX2CIVovsHtRIcyZ0G4lsRzMBlMzMcvSKZhZY0Y+mvr0bqKkmKcnOiUc2Ro5DtkzW+bF35iLojnfDwrNqLP52I8lDONBltd/lMZNC/2XhgZENcwd6d28JwW3YsYNzC8b8HfILZczN8j7SxJhi8ApnzVimQvLJmdrqQRswCQWprFrOQ0AwZ31KmqEsYrfls3vErTTdZlG
x-ms-exchange-antispam-messagedata: bF6zUKTXJkjagxPz3Xw4In3r69v21Os12I8jIEJpiknpu19updOldFsGAYG5uy9c1Nr8ZanDA6+m5gM5JXUz4GXvAQ1CKpfrb46ofywWTJw4a2aYezpjqdIFJAoBcvIuCZEtZFyhsGJFnlTG3xFJfQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d130015d-82d1-42d6-ae19-08d7af8f49b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:43:44.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0hG9gizq5B7F9+UHuwAmd5x16NliA87wqVHezu36P4r7XcWvMU9UPAQ1OiytA7gr4cnzBQck6C1xDmPIXieSICrjRErKDrWSKJhnqENnh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3664
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/02/2020 08:28, Christoph Hellwig wrote:=0A=
>> - Warn if we can't write out a page for a superblock (David)=0A=
> =0A=
> Shouldn't there be some real error handling instead of just a warning?=0A=
> At least shut down the file system?=0A=
=0A=
Looking at the callers of btrfs_scratch_superblock() I don't think so. =0A=
btrfs_scratch_superblock() is called by btrfs_rm_device(), =0A=
btrfs_rm_dev_replace_free_srcdev() and =0A=
btrfs_destroy_dev_replace_tgtdev(). So it's all functions related to =0A=
removing a device from a multi device file-system. Do you really want to =
=0A=
shut down the file-system if clearing the magic in one of the =0A=
super-blocks of a disk that is to be removed from the file-system =0A=
doesn't work?=0A=
=0A=
I think it's better to warn the administrator that something didn't work =
=0A=
all to well and to be cautious with that disk if he/she ever want's to =0A=
put it back than shut down the whole FS.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
