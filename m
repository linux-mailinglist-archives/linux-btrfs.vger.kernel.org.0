Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2C148AD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgAXO7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:59:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64121 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgAXO7J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579877949; x=1611413949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4YIxN+GVevCT1F/befAksTrevU3O2iQfat+tE8XyZ0M=;
  b=jzDMB1hF9GhTD7bQV2Eu95b1XCRKEYC663f9Ql0yDrHcIP5V+3lJO3Bt
   9nHMDo7rVVSeg2dL2XnEy/VMIXnxRdWTOGqszThr7lP8T2AmwWY/HamUa
   V+KyBWXSc58hzMSR6750rkeUXWQxaWpKq3K9vAeiW2OC/yGAmyZUA90Ed
   Is92wz2WaQMtQOWtsa+4ArwA7TljyYX2HXEbI8oWQXXADc1EO82jpZnL4
   n9nOM7vwNSApV9/34VVXHxnseGlkso69+0RhqSNDAYIs0d+yRKVsJz8Gj
   PpiDdfzOB1F2WvQYs4pRymHs8bnFH+tZRXH6j+fOSp6KEGLvfClSaPca+
   w==;
IronPort-SDR: sfZHrb3FH98q1T7xw1/Nk/9avZPNUUQ+drpp/Iea+M8n7FJ3qp8B2qUCq3LqB4VKcjEsgv/r0j
 EwhxW4t7NDt8tyM/ro81fgkQueiAHSHwzkikeZedxhYMQpIX9xmZ1pZnSpNNXhkli7gF80WQLc
 Dae/MxZ1PQeSDecgeWXpMcUN1LXDVbPWq54WRvVFcaIx/0D/acxBl/LYF41SLeUIjMk4hBgFxd
 IEzzJ0hEOuHgF4m+NwxV1oSL2pW6VyQI0aDw7UjG3+kmRKy6sNMTSpUg8Ane2rDY+BjrRlqlm4
 0cI=
X-IronPort-AV: E=Sophos;i="5.70,358,1574092800"; 
   d="scan'208";a="128922571"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2020 22:59:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RatqkNgIPTlSd7CgYt6F+GTvHnvPKBY1w4vl1Z2LWClcuYBZNRJItTg9bqfUi3VFmdbYY84IfndOCmmbVPc1ZumRr+33sl6J2hTWns3vHuf8wRMbLwHUmh891iT/aeyQ8ZQxhWV0nfAyOSpwsn6IdkuSe+7Rza9eDo8sR/dynsHcG72Fpse7+6RRPCP9pfdjxT7bOJA2H7X5icBddugS4lfpnPwavbdQCCMfS6eTK4wRvkOPuHBAxwYOmY24IpNI+k8wyBSQVSkIxL2oYqT4E3B3Bdc5ousDFaP2FM5gsamNbEu4xpI48EK83GFdrPt3y2yYroPCx5fasC5ZCmRmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGbR4CyVBg2uZWUJ99niwDSN5C75lgAH0JqutLr7oyU=;
 b=iY56jdlC+Obbd49y4Ogr69tPNiR4tUb5r1t33E0p34WxjelY603ResUhtc0or3cnm+thVV8ifvsUfBzBY0o5Rksx+AJRi/pGu8yos0QPpfte9csuz5rTv70hNTGyqhoqCkyABoAF2BflDqqYcBnMz7JLEheC/vFqHiMmFwSNw+v3Vroo9p1pdRrKXpS8ejK50VJr7uBl/SGpnO3sfLaXHAPd/3TQppv7LmZsvS5EObfrrxsDYuMwu67JU0fQAodFQLsyllTkBJWoro+n1CjbOddOXhOMrDZKT2dz7F3dqIVS5uW3HvBo7tb1T8C25HTNLM5iM1xk3yui/T/cHA8qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGbR4CyVBg2uZWUJ99niwDSN5C75lgAH0JqutLr7oyU=;
 b=H5LuqlU5AUC3aE61NVJNow9yp/M7FdJlQyEtIAjX9fcDukxNQB994nZTEC+0nA3fQSZRxBdH/vvUyhdM3NGQgX6e3J6tPa0B85iWcFgc9q+OswOQwIHbnTjnmWrkHQmhgB4rBAJZsTz8IdB9t/dDPHi6dxBKPNL50rbahwJTXJg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3567.namprd04.prod.outlook.com (10.167.141.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 24 Jan 2020 14:59:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 14:59:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Thread-Topic: [PATCH v2 6/6] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Thread-Index: AQHV0cXLR1/Gj6EJokKcNPbW7FjoLw==
Date:   Fri, 24 Jan 2020 14:59:06 +0000
Message-ID: <SN4PR0401MB3598FE1DF8863E611D4C183F9B0E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-7-johannes.thumshirn@wdc.com>
 <20200124142211.GL3929@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1952c990-8532-4bff-2328-08d7a0ddf5ad
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB356771C54DFD3E7410A121679B0E0@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(53546011)(81156014)(6506007)(81166006)(478600001)(54906003)(186003)(8676002)(26005)(33656002)(7696005)(2906002)(316002)(66946007)(8936002)(64756008)(4326008)(66446008)(55016002)(71200400001)(5660300002)(91956017)(66556008)(52536014)(76116006)(4744005)(66476007)(9686003)(86362001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPxsZqFygf7iElFzMkdj0TtRKIcS23FeROSEVvjRgmOzhY7Zo8j5e+nbSQAlHcrDzteP8p19o6igrJR0MpuWAdfw6KSypDIFaCO2XNA/c4Mafxlsy8t7pc/ElbgLIeG9MKRzFKOwms2hMWj6jY84F3o9UqXihyW/dgIY7lH0LCaGAxw6V1OKQIY7j+o9TeeJFiPQ7o2tfsoL5nJggNHHtpGw4M4fAA3ck5K+1vUjabfDDxuP6wbIn/JOhjr4DPq0h7NyYPZkC+ycrArHJ85Xa8k2Oc16uKVcY7WqxSgi5urG2+lmMkb/bAg4D9EM9KG9JxAYssMCMaqPHQlbOGCHJYL6KOKpkBG9OC9IpoCmC2qT2aD8WAqnAhDAaOAK5d/4zUtXMrXCahNlnw776Gj/huogjDeTBosT63Cxcb2IxBENyCihoNyI0Vp4dLOd3Xb+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1952c990-8532-4bff-2328-08d7a0ddf5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 14:59:06.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lg5aBBzaRna3mARlwyWJOwuv9zQsQSl2TNv4T8yAB/jxIbxOIHXP247Lhr8/FKOOnjQGJZ9zyRlYOTVQCPnbt1yBtbEYlV24q689eiO5p+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/01/2020 15:22, David Sterba wrote:=0A=
[...]=0A=
>>   =0A=
>> -	brelse(bh);=0A=
>> +	btrfs_release_disk_super(page);=0A=
> =0A=
> This could be the cleaned up to merge all error exits to jump to this=0A=
> common block. Integrity checker is an old code so nobody cared enough to=
=0A=
> clean it up, but it would be good to do it now when there are pople=0A=
> looking at the code.=0A=
> =0A=
> As mentioned before, btrfs_release_disk_super should be opencoded so=0A=
> this would make it more straightfowrard to have only one place instad of=
=0A=
> each error exit brelse replaced by put_page/kunmap.=0A=
=0A=
Sure no problem. I already have a internal branch with =0A=
put_page()/kunmap(), but before sending it out I want to address =0A=
Nikolay's comments regarding the page locking and this still causes =0A=
deadlocks here.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
