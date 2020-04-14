Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8D1A7709
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437434AbgDNJLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 05:11:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15989 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437407AbgDNJK6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 05:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586855458; x=1618391458;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c2e2oFDDpgqBikKJVn0WIS0PvmaUeTAU56Umwo7Nfjc=;
  b=kn9e+nAZZSD8bDasFRJ9ag968AfNEqhOn9v6hKXLw90F3rcXkhue13aZ
   IN3HlFgKcTa6fWFdeKLhg0MRMoV3ID9RKZ5Ub+O7EhJnKZfioPHnadxvr
   k7v+SqX15Yg3UPfUCL/2QMlRnLCSe/HT3LqgyNQyYGK9hV/jPz/iQ9Zt0
   oCHXQK3JueONzBzdshRiFeeSpF11pfI1zYaAKY6Sa2nU4zUcfZ/TiLsQN
   uJyxA+aPTG34alhBos964InsFWfF3dTkgVsg1NXb4aUYtoQpL2e6idtEX
   3W03QizLFlJ262hLPnknyRcdWA5jATX1/BSzvZoR3FT7Y5B10ImvuRJv4
   Q==;
IronPort-SDR: 4cS4xV50/sHNnOk5Iol+4m9cZFeFae9ejNxL5DEBiJo6WdZLzOnpTfrpoplUSPaNzR3HvQ6Djc
 kwe+PjInqqEgCs4VsSfGwE01kacK5Pvat+IFX0Hrq+kyHupcoItn6P0mDAvXteID2n1F96e5bQ
 x8r0Tk/5jIMzb7phtmkFJb5s2yI17ZM3fjNBjDLpeGisjlw1feLr3QLCGqwbiHmgMHIgMsUdB0
 JDV7OqQB2nz2QB5jbyKGRQuckMe6UeyM2IFhoBbY1UaBgi6lGlzoI5VqxlbSsedUSQiIg36yWM
 jmA=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="135598495"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 17:10:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjkviFiK0VTQzIAxSaQocJsPyVjXmlZmQuUce8WorgjVNx+vUz6TRJQBI1l5j9N4E7Y0VK/DVC8It0JQFGp7Xv7Vj572ZwgFK5dZlXXy3RgDhSkxdV7N+frDbKxbuTHbM3X5RZc2Wb+nKBszdd2bUqsd00XxptPXI3sCMW1Db5us1c4sD/LaVNCMVe1jHuoox6N4T8622yBx1SxDPfQc+xBjOasUYiCtlrqjqwd41MOKRn2tGbzk53Z0N2n3ZAhefG0SRIMrwarMrLakL2TgVnlVb1b9pl8nKRhugF5MMb1QDjJnr6xbXpUhRYwlfEbHV30JpokAjbNss1xKsfNlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCYge1jKE2qi/DIHAvlPAGoYVVFo7DNtv6EpFcqaHIQ=;
 b=TJ+Tf6/q+oAoUahim72GM3q2MyhadvxSyIXete1mhwUcU9T6mobixs8Fip0fDtnrQyLJIxboak7pjJX+Jp7EwgFUr2BCgnddKxS6BvfTBiI4HnkGJ48GRnODMF6vnkZXkEaUvLUqYEphgMKed2Pk1zqvFbokHCROQuotwXzih/hMlkB8DcQr15e9pIpYd1TSzvayBt4vh5KQmd04noD/ZcBTRM1jGen9fov4tw5FD5Wnk2o4PFVVMRUv1HvzCXzMJWk1M9Mn5fVmiX8x+S7YMia/jx6UUUu/LLksAvtoUGY24YVVYpa/kO4Ufd626axEQK3//mFYC6iTnphDMtE9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCYge1jKE2qi/DIHAvlPAGoYVVFo7DNtv6EpFcqaHIQ=;
 b=WYP251+ikT9w1mtGxq908Mdq5k9/aNLJH04I22W3JEa1U7uc6jTNbkv84ODbwwqMyxN0zSSTWNdGxGOclQyf6J6s7LgG3CN/APsPcswNsM9VtuO+GQ3WxJAZF1PnMy9TASxueFuYWH8ds30o6xS1xn88KDyTnLKQdBM4omQEEKI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3534.namprd04.prod.outlook.com
 (2603:10b6:803:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 09:10:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:10:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Tue, 14 Apr 2020 09:10:54 +0000
Message-ID: <SN4PR0401MB3598C956CF4247472D1409019BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
 <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <732225b51548301c700868165ae644df608e7b9a.camel@scientia.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d5d8efc-6f1e-4c68-2d61-08d7e053bc65
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-microsoft-antispam-prvs: <SN4PR0401MB3534249BF9CAC0D6AD3313089BDA0@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6506007)(55016002)(478600001)(52536014)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(91956017)(76116006)(110136005)(81156014)(7696005)(8936002)(316002)(9686003)(33656002)(5660300002)(8676002)(2906002)(53546011)(26005)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZZ6+/TQqGu6g1lxt5EhYwqM5eoO3x1crC0U/bts/4iotTPv98Asz81NtJzZyoKnA+IYoMxsLyT4KDeblssN1s87FQfDdTW5wDvBVqEj/dauZjJC4u59QB2xHX8XfFByyzs0PZhfPbH8Nnn1Y0bJt1Sm/L2xFefQpETYeoorFwGo7bvEZOGYEQqRFhJXRqGvNmpaQUMc/oQXZ8CEfTy0j9k5nB1OFFi09AKmX7KtUaB58W3Cll6zW7Xgt6Dzz19lCgl64G6rAaBvtFLWBM2b/7C9SeVBS6koCWL5wfan97ifFFbEHPt6gUGy4n4NJJy4+0bYsJQHSSqcLYxrig7uRhJ3YfLNxKepiOx0KSzQKAmJLRAv1lWsrLP4mjpIMvykucvNnQKU7ucnZprdw56qbRkXsSvi2RqFCPs8bQ0+rSpYI/vXRUwnWDLFitYPIcek
x-ms-exchange-antispam-messagedata: croLQnr+oZ+C16fyREOYZUQNoclXFhv6vHW6EMNAjiX+GgIMD+ROl0tBijmQMUGfWNkqMwUy7NZwdKUy3KK9QYIx965guH5gbHb9bkvBWqxRylelMWlTgvdJustaCi21FDdjEcfmng3qr5nQm9WyhQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5d8efc-6f1e-4c68-2d61-08d7e053bc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 09:10:54.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+kh5Cu5mSEIlySOQBNX91GppOFdI/9PR1f4vgoz6LXAekOFs5T0skT7xHJHg1WEO/kEAzuE0LF435Y5PHjU5Ge4fgZkkZET1rssME8MnQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/04/2020 06:06, Christoph Anton Mitterer wrote:=0A=
> On Thu, 2020-04-09 at 08:50 +0000, Johannes Thumshirn wrote:=0A=
>> Maybe having someone in the community being interested in this work=0A=
>> can=0A=
>> accelerate it's upstream acceptance.=0A=
> =0A=
> I think it would be great having something like this in btrfs.=0A=
> =0A=
> =0A=
> If this was to be merged, it would perhaps make sense to have it=0A=
> audited by a number of crypto experts.=0A=
=0A=
Sure.=0A=
=0A=
> And also, to clearly specify what it can to and what not:=0A=
> - like how it behaves with other features of btrfs (compression, raid,=0A=
>    repair, etc.)=0A=
> - limitations (e.g. fs-verity was just read-only, wasn't it?!)=0A=
=0A=
Yes fs-verify is read-only, this btrfs version of it is read-write if =0A=
you have the key as it (ab)uses btrfs' internal checksums for the =0A=
protection information and does not relay on merkle trees in extended =0A=
attributes or other additional on-disk data.=0A=
=0A=
> - what exactly does it protect?=0A=
>    - "just" the content of files (i.e. a file with invalid HMAC will be=
=0A=
>      detected)=0A=
>    - file metadata (dates, names, permissions, owners, xattrs, etc)=0A=
>    - the file hirarchy (location of the files in the tree)=0A=
>    - would files removed/added (by an attacker) be detected=0A=
=0A=
It protects the file's contents as well as the metadata. Btrfs uses =0A=
'struct btrfs_header' as a start of every tree block. This header starts =
=0A=
with a checksum, so the contents of every tree block are verified. The =0A=
super-block also has a checksum, which is generated by the same scheme. =0A=
Furthermore every data block (file content) is added to the checksum =0A=
tree which also uses this checksum scheme. By exchanging the checksum to =
=0A=
a keyed hash, one would need the key to make any modification to the =0A=
file-system and as checksums are a first class citizen in btrfs no =0A=
changes are needed to other features. If you mount your file system with =
=0A=
nodatasum, you loose data verification though, but that's kind of obvious.=
=0A=
=0A=
Byte,=0A=
	Johannes=0A=
