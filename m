Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0212073E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbgFXNBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 09:01:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19189 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389933AbgFXNBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 09:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593003671; x=1624539671;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CV8BXmzVgMg1MJs5xtFnERegLEUzSlpySERHhtF4Le8=;
  b=GOVGfMrv7vBCEGAW/rhJoiFRfIExXLwz7c2uF0K3grBGFrOzR6NZlB/S
   nuNGE4ad8XZ798XtmApJnLcM3VQzUv3PHcK+StIiF/kmupDt0VWnjDe9a
   mkpzgYKsXqZowfPAaQtN0Yg2PwQK822XafZpat0Y4FPzRzP2rzA6TW8fW
   /HqVeuwXrpBNKLdaRrdjDG7GRnMxqhYhBgZ1k01Wdzhv5X0PJm6inPcOP
   m3H3QKDt04tL0sgOLTCvzjw6bBd9mFn0MM20Cp4zthRQWsHfhGwvTCXRs
   APRWPuXhuY8zcasYTknxbarvavWHuboHIh0H5G+RuWKdoIE5TyGRfLZV8
   g==;
IronPort-SDR: 4no3bj5rwx3f3WsXkksx3F/PsZqvwKIauEt+9FDFx7bGId/szJt+eJOP3O5dp7JIkpFQRs5rrk
 CKEIvT9b5Fx/6h1Wq4RCQhylTybyTJKaWrRKl6N4eKhiZSk5UF7i025CXWh5ohQl/CmEB8hhmA
 3IvMvDGPMqwEcMLG03eYj67Bet9Bpr2pD+Zpn/g1rv9Bj6AnziRtefXjS7Qckj13dQ4mRIYVls
 iP6aB84p4CNAPNMU+xVom7zOjKU6kmM1fPg5rKMNo6HAx5wUpPWRjv5vcInl6ZYoWhUpEEKHOF
 GnU=
X-IronPort-AV: E=Sophos;i="5.75,275,1589212800"; 
   d="scan'208";a="145124504"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 21:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwqgHRTxlLLL5y/raeCrLknXcVXeGUeywjXZpWiBj4y8S9y4baV8NDeAWl0H/BPFRqLukhpbP6rMAdkgYyfhTqah+huqlRUIApiipvmYdUA7Q/iBpxt6ZtWo9jobtQGAvSEEBqiK5NFmCRNxP5s32m2mPmlyB0ADVc34TnDRZh/oWNqJs+czPrQWr+7jVBdXNMINd2bDcqsPNaRDTUx4OQfhjhpZyTI7UMzyofKFCDm+Q6ItsJvrlCWOdQd5pjSOZDYMiIZF1GS7j3gKFOtqDYQF4rKbgH8mtlltdHoe8IbSP9akgZXxOrXXvO/JFSe3EqzzasB29FU4NCX1WmcvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV8BXmzVgMg1MJs5xtFnERegLEUzSlpySERHhtF4Le8=;
 b=YH+Om7exQ1XlNa9CRn0BLKC893Wz/JJpGvlIpX80TsJsB4AqWXWX01cHmaFK3ZcFoLKNwEn5EBxK7Agnr2YROjmEm1GiF2AZWFbzGiWh4mv3DcrznugUAydk0ix2GMV2z2dFQ2rw5SmjQ4JvUymRztiPRWFRotwdjI1Pzr0CQ/tM0IT7Gaunm3cbDPJ3ZS/K9+rjVedzG1ctX71Jv1YszlK7QWsf5l2atUCkMyTTdOLKQRSUnI63v/KiM1vxAtFp6kftuzGO5vyQYlD1fCwYkRzsTqhv5coy1FOoTJnhC1EAyQGdaMyrgO5ESgf5gYJ6TTmOay9QYSqu2PBOH2Nbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV8BXmzVgMg1MJs5xtFnERegLEUzSlpySERHhtF4Le8=;
 b=nIy4SD+vfxJGmz5bjNsdqgD0pdVXuS4KhdIkN+O6qgRqulUoG1nUWPTSV8T1DNWExu2jEEs6AOFZrwOtxpmfX7ET+IQk6mORYvjD2zLpCuYQH7xsJCV981Rh5S/sA9oHH858qiL7hQkhI9Wvr9zQBq+r/RtEpDs0xWUucnhB5z4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 13:01:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 13:01:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Hans van Kranenburg <hans@knorrie.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWShFCK43KMhBSekKBmLU/7X0PZA==
Date:   Wed, 24 Jun 2020 13:01:08 +0000
Message-ID: <SN4PR0401MB35983CAFFB7912C03A45818B9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
 <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <18267791-0fb1-52be-9538-ad32940bc451@gmx.com>
 <ff3e46ef-b6c7-7dc9-0e95-9daf07ed9760@knorrie.org>
 <SN4PR0401MB3598B67E6E8DDC2AF970A2E69B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <b13f5a8c-cd0c-afd0-dc2c-25ef09907ce8@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bae97c49-2936-4cfd-842e-08d8183ea9a6
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-microsoft-antispam-prvs: <SN6PR04MB380710344500A5DC275044269B950@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMYu+M7T710/0xDQbPowMVnS+NsODQn2kUrEoTe43ULC5R5j5o64AKEs4EIQPwGrekKpW0vQZO0dKgZjJprVtLxlxbF9zTbb6BY8pk5mKXBHEN7f3c9Cv46s+7ybkXFsOMvU+q5XgM8JV84BBx+De/TOwyRWZSrr2khmCKIGDBO9ZNOG7z3vY0JHCcCrfi61Mj0SMR+vMp8eC4yQE6bnPOfxY3mGNiVCMSo4SMOxXuYlrYbb1Jdj7aINfIlhZ/VSwAsC/Kx8Wd0ExWJeaeCYjin07jXSnEaDbQp0k+ePOB+6p/ap6+KiX4SQ1/pJAJidOYIwcyqwvFrzOw42bsOI4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(53546011)(6506007)(186003)(86362001)(4744005)(76116006)(5660300002)(66946007)(91956017)(9686003)(33656002)(478600001)(66476007)(66446008)(66556008)(110136005)(2906002)(64756008)(4326008)(7696005)(71200400001)(8676002)(55016002)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +WY2QZ+FCfwBOc01kHKNvIjdEfCTIPE+BDWKTPrMlPWcoPDN9SrfOsqf9gskhH/Y58Lm+rkTvAUuD8I5Tyan83T676x6z4tALAuEVarExRJxaHvxVQEOvdZZbcPsyyYRUXq2ptpkL0dFg8rSiuhV/SARzRE9LjmBxQZgr5dr80tROXgGQ9TpaZ9s5eQxnPaqXA+MghkKeWBxZ5gfEQ0cb2H06Qc9+aqMKvOmf8heNhnF4d8SXzCSnvP/l4d751s/d+oUMPaCyfqYxqUvkAXtPWEBh67Umz198WZAMyT9Glffq9YoKeDmeJhbpwNJuNq5tzzyV86q0iaAdDW+uJByGax/Vd/voY8LHCDnH5wpozEMoiQgpMfQVPMNDZrD/V+rTJ58nXImnGnGgwDbD9lmaNsPPqlKbjZ9BnXOUsErWQb89xtuCEHAYwjJZ507lVd/2Y68YriMwQ7fg61uj0HfyMz8EgOw1E0cJAaTTQFB285/XuuQhvG/A8/g+MAe/f8WDh0SrrH8km1X5YVhnKmQ4RUP9+vhxm4Cgwi0Lu1VkeRpY1ZaFKUe+Ozc3UHd2enp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae97c49-2936-4cfd-842e-08d8183ea9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 13:01:08.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eo3Qfw52Ajr9w9k6gHMwgnZLsp7uGw8C6si3yrWYyNjahlOFGQrYpQ14FXTi0t70IP+lyuIoJizlY7PeqQdzwmyBKpIe2tOvy+HjeFgg3+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2020 14:21, Nikolay Borisov wrote:=0A=
> So the answer could go both ways, but this doesn't mean we shouldn't=0A=
> strive to build better/more robust interfaces.=0A=
=0A=
By changing the reserved16 field to a version, we could have both. I=0A=
just don't think there's much value add here.=0A=
 =0A=
After Hans spoke up, I favor the flags field, as it's more flexible and=0A=
puts less assumptions on user-space. If the flag is set, field X is valid.=
=0A=
