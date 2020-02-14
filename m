Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0615DA6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgBNPPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 10:15:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38675 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNPPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 10:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581693322; x=1613229322;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uZTm/aoKm9WMTaAX30/dmZcwhR0umJlWBck22TKf3qg=;
  b=TBQ4t2GIdg0cdo5OS8uVknsyhCoZc0rFRou6cfJ4gWTi1dSdK1FP5ECU
   a3oWZ8MxOs9OMGpNW6n9eDl01pMXF9PC89pyfXygyt73Zxq0l/+bCzCgX
   WFM//plq0mLLXl/Q/wkcDCBbZNCAabEd/2nUFPz8dnPoVNelta/VqjaqM
   ktcoQIAyQoYNRJ/ifzN3N5quItZ9GnIt/rUIMBY7a7m+s4ysI2A7aWokU
   yNMc6tbteI9EBbIBTNFs5EEEcESeSJUGYcLH82KRa4LlNv4UQ1jxVnNEv
   jSjY1ONjrLNy+FAOkMtWjLbRSyraWXzhS9EgXFd7fmJNS7POVDxI/QXFV
   Q==;
IronPort-SDR: 5xIUuuiDVd/mZgGkUTL0KEhAAnlY6WnpJUHHqRJC/2UEJvszAvTp1tbL9jVDsx4yl4aDZLJlvK
 9gW2gjQlNzj30v7LRgVA2giUFClsgJYTOVqZ/tlGW6Z6j6wl8BfFNqVlA8zVMjBkzmYQlU4t1Y
 xFtS20vF2oiamPczDA0NZbthUMjcNsgx34l6CMP1PVnzQ0FdrbP0BzAeZ2G8tWtnA/zgJv46W8
 IDpJl5etO4+gIboygVAiPCCK/45qwiNF3/DLsfmTkt8FnGV8aux/yzb0q9FEUduMrF/objIKfI
 FJw=
X-IronPort-AV: E=Sophos;i="5.70,440,1574092800"; 
   d="scan'208";a="130400072"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 23:15:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2usUef5TB7KTo6axgVlnSOJbL/gFv9vfX4XcYBXFFMHPaBfqBqUiseUy5a2hRDlu6Y1YMO6MUlzwM7Ytqz9k1bLJeHaXHvHL3prLZVboBeOMF4JxWYRYf8aqPrBm2UEz63FYXYTERgcV5fYw0wipD8ybhSOfEoY/JHN4txKSt7ytvEzkWcvjouvhkTkepoxULoA7BL/Pl8gW7TF17XckWCT6jrc1gWb9nrS0AqNmiIXjLEN0yH6nIR02OYYyUndfF465uEjVeQnAh/IocbS819lhXJSWB06a2RW2FUdsFRHsDcC+RBHTVZz61JN4hWlhm71V2VLYtx9zeYtiFdZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZTm/aoKm9WMTaAX30/dmZcwhR0umJlWBck22TKf3qg=;
 b=nk4ForLote+vGmiE+FeNrPC6IoMeUhwWhxdcO30MPPBa8zGsHzXofMuykOmfeqz6qExq/9JAU1YVABc+arLo4VEisMJ4rUwrZrN5XN9vsjYvNgDud0803u/8i9gYFet3a7i4FDRRTtgDpWi3nJwp6+3sabh3BrnN09i9KSMarQsDctrLX18+psgRa21/yvLgO5kQqMRhopw7ctlE/7tXbWCzppo7j6ZxXiKdYo2lKG/DMSStG5I4lfgOErDT6o/cSZ8mKU5H+EbLlZI8+6p03Ftg4Q5wkAItFfuWxguEBr7d0GovAvZd8eYIYb/BMNEzLP4hZIUmgNv7Zf3sGn2VQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZTm/aoKm9WMTaAX30/dmZcwhR0umJlWBck22TKf3qg=;
 b=VuodlkIKyKGHn7nq08m2yfKf5eqoWPVyLxlkSrjkdXke2lGtoIM0NdZAfrRnth6H4oRU+1V+Ye452TXKu46IP/nYx8MOaPtvY+F3fkFsVA7VokrmYIESEJ9/F9nAC4x+Dr//xXEUYwZTPgEPKWyXqzba22ZNVCt+Af0or/mU5fg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3616.namprd04.prod.outlook.com (10.167.140.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Fri, 14 Feb 2020 15:15:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 15:15:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Topic: [PATCH v8 5/8] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Index: AQHV4oHAneIeVOb1YE+/jL8PiE6cOA==
Date:   Fri, 14 Feb 2020 15:15:13 +0000
Message-ID: <SN4PR0401MB35983802EDE0E5094B86109D9B150@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
 <20200213152436.13276-6-johannes.thumshirn@wdc.com>
 <20200214150850.GY2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb7dc4de-979c-46c3-2c40-08d7b160b0f9
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB3616C594C2DF69D50D8395199B150@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(66946007)(6916009)(478600001)(316002)(9686003)(4326008)(55016002)(7696005)(86362001)(2906002)(81156014)(53546011)(81166006)(91956017)(6506007)(8676002)(54906003)(66556008)(186003)(8936002)(66476007)(64756008)(26005)(66446008)(33656002)(52536014)(5660300002)(558084003)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3616;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fa/Dk+jN/rEIf0Bn4Si2fq0y2OYbLZMetoWn2FE7hyGNEI0J6WGoXG0UHTsN1K6FGVIhy81E97mIjOycE2AZiMUPT58xoEzmj7H97QxXOa23H7E/shVfMtrgZ14Ewo8qlH6dAKF0uno4n0HXxSY2HH7cB1uj5ymLo5lSKWyfXAI+lw5+R8V8QPH9j/OVUL+xAtYs+zAd4sy1fQ8UcC/nmTAFhKOkrn7v0dMiSHDLDK0S3J3SkidnOwQSD+OgaZj2qlA3sMPYFR7G5IouvV4qgdO0qWmubNbNvmL1kwSPBReaDZE3AGNXGEOdwHuJn7j8UCfy0Ze2r7GgsSeJvAIBfzrCHrAevctMunSWoTLYbtS5GhIENrgHtEukfzZcJWdXFdGLDFL8TAbCr5ZSDry+FjrPPZCqrVTGDf87veJNFzrChKexqs5G7tfBUUfJ2b67
x-ms-exchange-antispam-messagedata: YnGRDlZ4yRO+EE8rjoXvPVpy9Jc++Z5AewhKiDOvOj0PDR92/IuYAGeHT3oHiPqBk+IZhocyQIvAeAs3Hjaw75TxWSl1OMFQar9MtdgSlCO0JlAcX21ocv6fJ71+Ryb9wiiBLwtp4vJB76GZlReu0A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7dc4de-979c-46c3-2c40-08d7b160b0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 15:15:13.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1Ia03+IrtiYbWxAMeIh+oKcnYgh3Eygn4llNYMb6mPENCqX3KCtvjfY3L4QydKJNPKQvyGR3o6Vlb43zHDQ2CJjckMYjxY9SB2l4zPH52c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/02/2020 16:09, David Sterba wrote:=0A=
> As a potential future cleanup and simplification, the per-device flush=0A=
> bio can be used here and not a new one allocated. The flush bios are=0A=
> sent synchronously and are free for later use by the async submit=0A=
> writes.=0A=
=0A=
OK I'll add it on my TODO list.=0A=
