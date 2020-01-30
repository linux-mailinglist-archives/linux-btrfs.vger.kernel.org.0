Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5414DE39
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgA3Pxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 10:53:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53186 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Pxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 10:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580399619; x=1611935619;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8RgaKeBdFnz2kpQOUrNEfadh0agn03DEh3P/DHDVNeQ=;
  b=RSEeKIePt1cAdVt0lyuG64Ebpfw8cp0a4a59pdgWbJq/oxY8HAHtZFsR
   j9WGXb13UV56Jn+14euksu7PoSbauD6OxcUpSs5VRQtWnv++iuJ5/VAwm
   AJEPCdWCtfRH5y2LqDOp2pQHTGkMWK5+X97w2QsVBICByn8WvtxPZbw3e
   EEr6LR+ZVy4FFHYbh7VvNfNo5bOC0xUL2ilb23zrX6++t9DxvH39RFTzd
   H7iT1X/13/15zICNag0+oHzdofT03BgTnoRua8wvUmlLhlyKX9cUs4juD
   dhsaERa2klLKAdJ3pNR85R2CiU9kqrMjmim2X0168HgUEV+ocHqk2pFSY
   g==;
IronPort-SDR: n9yDoXL8x7L+Jt4gReh69Y6aim8cWg7UFlfuiO7Q9glztg5/6N/z2r/HVu/HyIvYF2PxFZFCjn
 +fTB9V3bRL1f7yh8QkY3rbcVse8LuXdC9R8rhm7VIqskPZlUE4e0BorXwka9RN9a09oY+V7Zty
 YOq/CKKGEnl7XCp4FltAieDKYK6+FOAvcrWxgTHbZGza13/EmctrC6S+UAQcWcpTRPUCB+23aR
 3OLJ34ypUFOD+4sPyScFjJxuFK0bsuWUZifRy+1WjMHc7o89FnK9LnE+uNHi4gZt7MXP7/xWrB
 eYU=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; 
   d="scan'208";a="236687069"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 23:53:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyfLiQqhGgwLRbyN8M2amEsztwA98nyQUfZ6wWiOB749i+3g5gVIy7U7+tFJXWrCJBkt70ig3TDsBjg/J5/Q0max4pZhfJGCqPXZpptnZZnw2y/GICEmXeHBOI+avIC5VQ1ZyblajAxi0VS82vlQWoyWAYFItYNPDDCsQvBlnPc/K9+UTd846ClKbOqnPj/oDOj4c9KTBFDq6T0u5QFcOgQuA+w3LMk3iUCjOpF0D/iuRWR4kURNDhNzey7AwA05zCTgbysBeNXPvK90AGkTvisOFYBXhmzK0AMc3VOmPj/M4OePxjgg4X87q+8WQ6k+DWhsoXfUCLB2xQ7SLm9YxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMKXJj/UpQezylprHmylG4zULyndFoS09G2lcgKArII=;
 b=GTz/NUJ6YJNrgcRi543dsHDARutzJXzlBEIT7QOxfw16eZEIVuoy6g6GdKQWy6xxkhpgcsMSBF/IIQPJq1gJqw6rM+WAs+2Pw8k7OwKITGg6UrBT+P7AJ8Nv5rUdUjAim8eEqxqrPr46JD5JZwTpc/bdXINymdzonbnW53lpC+hQyWWGRuMEOK1os6OcQN15/xG8vyYCR385ptgGy+gpqeJkDy4fOtVtRCdXY8jOYUGbK+eVEmJUlPNvFhbQOhGe3B3OPec5zUFZ9O2xQF8NipFOYiyM3MWv2NY6/7Yh4tsWkAxqIKt5MDQpqh60DhLw4YLfmYw+CyDGw8ew3fmkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMKXJj/UpQezylprHmylG4zULyndFoS09G2lcgKArII=;
 b=uRmShJCBQWuuVi6P0p5/fLKlDycRl966b8QLUCuPm4pMKUeFVIQ5ZJMNRA3453qFPsICQyf4xP4RuAVJUWX1Vg2yOm9ujBKikP6dA6SuEnGGPtAcswmwkJYk0mNwA4PYfV39ON2Q87S2etUtyWWG69MsvE6L9q5EfhAHDLgfLtI=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (10.167.109.143) by
 DM5PR0401MB3688.namprd04.prod.outlook.com (10.167.109.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.26; Thu, 30 Jan 2020 15:53:37 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 15:53:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Topic: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Index: AQHV1SrKCplaciq1OEKao1x65qqI1g==
Date:   Thu, 30 Jan 2020 15:53:37 +0000
Message-ID: <DM5PR0401MB35915F7AE2B1A679213ED4AD9B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz> <20200130133921.GA21841@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd910caa-058c-498b-baa8-08d7a59c91d8
x-ms-traffictypediagnostic: DM5PR0401MB3688:
x-microsoft-antispam-prvs: <DM5PR0401MB368870BD74C1ADF82D6395B99B040@DM5PR0401MB3688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(186003)(110136005)(316002)(71200400001)(8676002)(86362001)(33656002)(81156014)(8936002)(81166006)(53546011)(76116006)(66946007)(66476007)(66446008)(64756008)(6506007)(55016002)(91956017)(7696005)(9686003)(478600001)(4744005)(66556008)(966005)(5660300002)(2906002)(26005)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0401MB3688;H:DM5PR0401MB3591.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rp1ILp81NoamyZev49WNbq/4/Ow/63cJusoWPQvmPJTcG8WWDj4Stbox6jzsbaSYPQ97WFp8LTfzl2a5jFAwSfHAMpoRvJNDDsbmCalKWcip3R+LOLSTgzKmhfB2LuHYlV69yFoOl9jfhQKutfX2j9xxnhd9VwST3SkCP5C8C0Eb3wkEqRXzFxET7eu4PKrlHiac597JC5GaeujVId0Cf1ATL0wXjN2BshNynNVzXAnVoihAhvUagSjQ0CVl34PLppe+ifT9pnmaMcumSmCdqEUhHp+FruofxYBjxA3CEx+Mxq9xOqUPwhyTuCIk9eDsDUkPgzWmrjn7ujc6Hp88A3KIDx1toIkInuOulD7lbBFOHE2DaoAMIJbe7l82EV3+hcYIlAk6693Fhc1pekiClGHxaIhCRLcdkEBvOprBrFW619tYnksAuMX8UCova92zgluZZGzvOLztsgQ93igl2spBmK/BIQZlWPEePUZBXKePH9UA71T8bQbf1JKibQcYB+kLkWaHmKftHp1A96M3TQ==
x-ms-exchange-antispam-messagedata: tFp+L+trGmeyxcUeiRsx0YlJK3b9p2r0vlcJtLP8kNGZ26vZgblwwzdcjDZzU9sTgno6mnvNfppsW56q5CjYF2tAp9wYnaaG2pCoDNAiA2Ytmf4qjTifMmWeXZ4NMje/t4z+kpNnqDmEvNT/cu5FPQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd910caa-058c-498b-baa8-08d7a59c91d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 15:53:37.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qfc6rMLqOnx7xCQ2OVKQ4z3/+jswwi+D7rGK6pjbuAZ9iAkX39Irr1u5MrU088jZgOFZPP9X10SWbNIddEYBzD/aEybAnXxHdwy2qDawUfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3688
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/01/2020 14:39, Christoph Hellwig wrote:=0A=
> On Thu, Jan 30, 2020 at 01:15:30PM +0100, David Sterba wrote:=0A=
>>> Sure but with hch's proposed change to using read_cache_page_gfp() this=
=0A=
>>> doesn't make too much sense anymore at least for the read path.=0A=
>>>=0A=
>>> Maybe "use page cache for superblock reading"?=0A=
>>=0A=
>> That works too. We might need a new iteration that summarizes up all the=
=0A=
>> feedback so far, so we have same code to refer to.=0A=
> =0A=
> Per my question on the second patch:  why even use the page cache at=0A=
> all.  btrfs already caches the value outside the pagecache, so why=0A=
> even bother with the page cache overhead?=0A=
> =0A=
This is what my first version did, alloc_page() and submit_bio() =0A=
directly [1]. But reviewers told me to go the route via page cache.=0A=
=0A=
[1] =0A=
https://lore.kernel.org/linux-btrfs/20200117125105.20989-1-johannes.thumshi=
rn@wdc.com/=0A=
