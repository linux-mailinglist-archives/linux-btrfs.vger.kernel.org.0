Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32918159917
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgBKSrs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:47:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42552 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgBKSrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581446867; x=1612982867;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PA6W+Fo1h9OmCS77Gh9V5WWDmu6EBP24SQkmi/mWF14=;
  b=M0jU+BtQyRzx62N/lo4ugIWedgGIR3XlQ5BhVamB2GysIZoJSYWVyg6d
   77Y/2lrErhDkgUbRBViCpFP6j98jGOqdzurUxlgyCftd5WwXdmwG5mCDz
   pziZL7EhbYHPbG5oepp2JGwFcshA71S4W00C5NgpF/FUrUhFjRFOoFmEt
   +6XDoQ6k8+egOGsTauXJvH7N7y6SzU/jvOuQRIxONcApWCY+RYwxGyncA
   6xuKlTbqYGpejunQ2yB4bP03MK7fpNsXLEbWWFSQmqDjrsUY6oGtcpyhB
   RZvzbTrHCCc8r3Gk/sunrnMw4jaT3h/XZA3H+RQA0oZYA0RQj1iFolbGX
   g==;
IronPort-SDR: HRE6u/od0BMzbJC/3jwHuajc8H5LRd8cV0HFIwUusl50RjVgodRcO0C4LxFrgYfL1X8B6HUSc8
 WhdApc6/ZBmOk7tvp2XrayQYPCDta8No2t9T86fGqIt72e+P5TiZX8xYCbE7x+v6SH5dh1zPgu
 KuV2a7Y+TAWrp3Nc1xCMwfjHuGrA55AYuI5tvvl/Dc+CYXDXLLrcVNlasUonWBRsVo0sBrfS8v
 WeTtpppBtzz5IupO6E10UKeGLS6kaikd4AQRaLWBCmlU/eTaK2dj+sshOXiLq8xT8euZpUWmgP
 Cjc=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="129605926"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 02:47:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWt7vk+zVtJC9oeB4Y+zg98FB76W+XEKAhfPmezCkbR9DKfo0C0Z8I5tufyuem7GTxezBodXECvSt9XzlaPOJjqtjCTC8cQHCb34i0Lj/60XKGj/uDXtS1G95UMOEB42Iv1tBd/D9VC1+CjD/tcYQQXTt2oArcYWELHfzL2YB/ZtwkM1JCzzqRNbVr7X5joc+Nn0ILaL4t2ntAyXYsG7i1nkYuYDETBhLEJY4awGyMKOVRnefbv/5X0mhvED3umm9IFxZUc9Qx8aWythlthoxMxIBtel8S/Rt1L4tGeKiQM68VSnDnV7QCqL4socDJ5b6+kuITuVAS1UaGD8kEthjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA6W+Fo1h9OmCS77Gh9V5WWDmu6EBP24SQkmi/mWF14=;
 b=UbCCHyINSMMJbZta+drXVGnvD61AnMvehSBdUBv3xjYT3vemoKE4Ch7X5AdpUtlfkq2sUPIitRuXpF5FxJfs87wxjLRF3yA0Vxna5CCpBW9OBcM9u45WAr1G3EOvOUirTSgrbJQXDZS4+4F0xDtqMtbUeEgA+eJ/ps6F0meMPWkHQsij0xCwXEnpidanY7/mL+VpAKBAnKISRvZHvkImiL8Ts81s7bZnHHOmasJQ5rFT09tlU0D585YuXbvSkqBQeEJjSttKMULeRTkJIF6N/slxerDkuvMUd63/IQvopKQpjIzuWbfJ9+TkSFw8R1X3o/OnLa6slKtqeyEtjMMRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA6W+Fo1h9OmCS77Gh9V5WWDmu6EBP24SQkmi/mWF14=;
 b=SAH0DTQqs+0eCdID7g/RfIvPZDNdYX2Hwp6dXbM1JToaoQZOA+rUhT3bUGokcNk16br8YNpBjjLYASKuCwvrs9sQvqsORXbh0d/HeKeUItCq8fWrDU6dp4NdeyjeZdBuF03QdSLH0rOoIx3IoxBunE+0e/WnsLVvhSchNdv5LZs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3712.namprd04.prod.outlook.com (10.167.140.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Tue, 11 Feb 2020 18:47:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 18:47:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] Fix memory leak on failed cache-writes
Thread-Topic: [PATCH 0/5] Fix memory leak on failed cache-writes
Thread-Index: AQHV4O1p2su1ugy5Eke3jUh3nVMr4Q==
Date:   Tue, 11 Feb 2020 18:47:45 +0000
Message-ID: <SN4PR0401MB359863B2525334AF4B51E9939B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
 <20200211175903.GC2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93b422a1-b3f1-4801-e2a6-08d7af22e264
x-ms-traffictypediagnostic: SN4PR0401MB3712:
x-microsoft-antispam-prvs: <SN4PR0401MB3712D53FC174EF9D5D1DE1D99B180@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(8676002)(26005)(81166006)(316002)(81156014)(4326008)(478600001)(5660300002)(4744005)(33656002)(55016002)(186003)(71200400001)(52536014)(9686003)(86362001)(8936002)(7696005)(2906002)(91956017)(6506007)(53546011)(66556008)(66476007)(66946007)(66446008)(76116006)(64756008)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3712;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OqN/ezFKnZOyk0A7oDJyW+JbX4YEYa0LtKdFXbzpdF0RJVpyJIUCRj+5j/FuwQBndgLR3CNdxfI65H7fPP+7MbaykkXDhFmEkhpQ3g6ihzCnVTdAcPZaWnobqtXA+CNLVeGY5aJHXaqZ4P0IBjow9fyoBoeJDBM8tLuP3R2h6Cc+9LdqI7JKo9TUW4NQ5VKg+zqAFuvyZiIcLAKFcWz+qEbZl/uVwe5M6PYUAxE9zGT7N8DWb2ofebO11fJPGe4r0cOi5JbLthJCb/UV9ulGq1k1jANOGYE5YXrwtnWE1/d1RLxdlGv1fdqNR5d5FX1s/ABVnJLTciclfGCHjJ3hHOJvsZHczSCqs94vX2rlBz0OANQcjgn3SrC35SJlPZUyeuSVnjIdL7Hco3vJVKlGP+CSNM7OrJ4jTAmJ6+/JD2PF6ElmpY6G7Kjx3olihF1
x-ms-exchange-antispam-messagedata: Hjqxf9TVrNinc6EhFEO2TYxX4rPf242N8nsSP4vuqCCW6VDag/jyt3RmxaWvCiQPkfdfY6n0mBJsjcqLDkAtF/y+ny12pHIefkGFd/8mpRNQpXN8XDDNCAXuq60Gj2VIyQI/kIV9bT8tjHylKJvaHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b422a1-b3f1-4801-e2a6-08d7af22e264
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 18:47:45.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8IK8GOQwhkAHnWC1oLzDQQb+Zr58ZvvtF+MmTRCObHjZmbBsBuNmI0Ow0a16V1DuzyvKv78pl3tqyLfI+Y3kDjDen0iscPn/L0T7hSKKF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/02/2020 19:45, David Sterba wrote:=0A=
> On Wed, Feb 12, 2020 at 12:10:18AM +0900, Johannes Thumshirn wrote:=0A=
>> Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages=0A=
>> allocated in __btrfs_write_out_cache().=0A=
>>=0A=
>> The first four patches are small things I noticed while hunting down the=
=0A=
>> problem and are independant of the last patch in this series freeing the=
 pages=0A=
>> when we throw away a dirty block group.=0A=
> =0A=
> Thanks, just a note about the patch ordering: the fix 5/5 should go=0A=
> first so it applies cleanly without the unrelated cleanups. As it's a=0A=
> leak fix it'll go to some rc and then to stable.=0A=
> =0A=
=0A=
=0A=
OK I can reorder if I need to resend.=0A=
