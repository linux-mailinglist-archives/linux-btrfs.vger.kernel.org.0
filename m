Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575381A434F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJIFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 04:05:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58219 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJIFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 04:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586505912; x=1618041912;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SnrNVJD3lwQUzN9BYmiNwWLv0uze0AQZfYe/pBM3kM4=;
  b=MCb95xK+W6NkWZmorR3AaACqrmMZWFtX0JpqViaoEFl1gb/oLE9IvepR
   gSS2sZ6AMhbzbvB0hUzEumk8Tq1FRZTvTsyqZsUAyY4dp7WS4vpjD/v03
   eYpoEPVZMny2d6/T3GrcD04n1A9I5lakSe7sIb8WqHGw1pUjDEWjhMt5V
   7cytls3WFaeu24qI6dn8q0MOaF2x92BTAqrYo5plJzmegMezZzPDCSHCA
   aMuqPHm7TLF8tc4Gw461+S/es8tmJTQf8M8uTl998r4HmCGqXFm8Hn/OB
   hPHzuM7C6sDX2IirMOX4ni2jcb9Y7iXn7/QGSkx6yHfwSJcbACemyprFf
   A==;
IronPort-SDR: bvhvn+mrGEUsTRdtfRcc7/BnbVjgDMTFp9LC69JSiI3Bv4C8luUvrfjvLCgd35L2KMQyEu/yby
 6N+JPqxvtz6c6pYhKszAoBGwxDv+SbRv4eC/QzAwZYQdtN1Hj74MYKSioqECU/+rMTjGmEkP90
 J5g6usATkqqNUk5dHi2hAlcfsPAgNxt5wVyvIlDA5TOzSobE+4aPkiQQw1VTOjlsZmfMdULwlW
 RVsrcBRUMY5UoGZPohnPxcOL1QJvBacTp/bBGYpnJHRVck2NNLLE5IXgFuCB082VavyLKJPOsq
 2yE=
X-IronPort-AV: E=Sophos;i="5.72,366,1580745600"; 
   d="scan'208";a="139359632"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 16:05:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V70Ovc8bl+G1o7tm3jHFyBx/ZSXwhqX2djPorM/QNSnn50Y0ZOuYTDtmR+0NHZ7X8ZlkMkLHqavMOTNbjC6ybOELerZ28DgA5Wsr7T1FqhSH9eD94IinLBOS/qxUShXE6v2IHJHFaQUKrbbdL4JR+fWyCnisy/T8EYTM3F//ZAjyEtkR+KREDMs9oEw4op8cqndbgYhjnZ4UWJ9K7FitKUCnUeAXgpR7/0GhYhg9Z9g/2yMrm/uqudMtP8L+IW/6gvnlQ5UvAhUQPXE8LKFQj2995+3jTo0CV7/gVZNg4YrjcypDXXVy9RVx8vEwgeymoQKxEwRbefDbBRtMyKWRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnrNVJD3lwQUzN9BYmiNwWLv0uze0AQZfYe/pBM3kM4=;
 b=PC/iZWNaLMqd90SeQbUdurM2R4rtCaDseBeEqiz7G4IoHYfPghoxaq2Q0rGHT65LFH0+kAmdHoS/tZk7QPa+3ooGzoilN38PQsm02kojdrq+L+pYntgzaQE2WP15ZFna98QAlu9ConlNjqRHXZGpwExqk+nduGp11N6kvmZrztnnMK4R+s4mgzj01i3P9z+FnokR8SVgby704h+pgZl82QcOinaLU6g1ix/cnzv9J74EnmV3UUgz4FBMwo8u2bjwKi+GJs1kH+wzPfo3etZmFLGCHktkAz9jE59ERiyON7zxyVDRtJQVeu/tKmn0yQeabbMTnj8fCk0skPT6+31U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnrNVJD3lwQUzN9BYmiNwWLv0uze0AQZfYe/pBM3kM4=;
 b=cn5XdvUobRF+G98hq+QvV2xc+Bkx9p5Q/kY7eqNtv9cxgrR3hZgpasNq8/doLv2iUgWiX1OwmOKbPvYyO/Tu7h0+T+mA6CK2xrVRJMpvEUDMifUZNTr0JJ8bK+oKyXxk0FDbtT3JjbokxPlcHfIOybDzwsczb0D1HBKgvAziKCs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3661.namprd04.prod.outlook.com
 (2603:10b6:803:45::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 08:05:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 08:05:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: authenticated file systems using HMAC(SHA256)
Thread-Topic: authenticated file systems using HMAC(SHA256)
Thread-Index: AQHWDQbERVNaVh/cw0i4WbDgZROyhA==
Date:   Fri, 10 Apr 2020 08:05:10 +0000
Message-ID: <SN4PR0401MB359804A437A7DA735061C5669BDE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
 <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtSiSBQfonL-zVacZAOT7_Z1vNC0NKSiDvib+MoLv27DWA@mail.gmail.com>
 <CAJCQCtSGCQ6j94XfN3CNCzq8AEzopqnd_YL4NaExe9W2-SY-sg@mail.gmail.com>
 <CAJCQCtQOTk_B=J2V85eqMioyec9zNLOD_jvq_9TKtAg_4K3ufQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d81d8533-fc56-4cbd-394e-08d7dd25e452
x-ms-traffictypediagnostic: SN4PR0401MB3661:
x-microsoft-antispam-prvs: <SN4PR0401MB366124CECE4C960807F0529C9BDE0@SN4PR0401MB3661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(71200400001)(53546011)(6506007)(186003)(6916009)(26005)(5660300002)(7696005)(54906003)(8676002)(4744005)(81156014)(33656002)(52536014)(8936002)(91956017)(66446008)(4326008)(66946007)(498600001)(86362001)(76116006)(66556008)(66476007)(64756008)(9686003)(55016002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNxGCqYFSiPoenzbNh/Q5TjyyJqeHbFt5lk3hJTHD9TNa4JPyTRVH+D5qNSp0Wdn4aBVA2mdQqG9D6aBzRVzla5y9EiNSSxHFLm872gcXEV+i3zPGND/4aoiyhSu0/HBbsQTJlAuqnKlyqBAs5UIIf5Wh4zL7Ol+7zdRgKa5IhM5UvMNnzQB5U6/o2tiHXgc0UV0SDE6/IPpx6Abq105XQsrtBhjGvnVMMuFTvQ0gMeQ9GlOU1cCREhu+Q9K/14Wa4BoQ6evFczGskIfAiSBSFreOcMxvL6M4CIjvIXWqcA21ujZ4YOS4iBROlRdkXt1emFVI4omupKaTFkOHG6RgY2aXEjxS4/z8x0gbRu+I+Cc1527NThRg8Xv5EJQPkB3PcXZICx+yzOV1FXLJkq6eI4igQDD0A6TtSrGZk9fFYX5mescek7y8W5yUJqteopv
x-ms-exchange-antispam-messagedata: PBntN9CzvexV2+UJfyebfh9P+31icPTVahOXAnTlqsmW54aWbGCoCptml41V1EUtU7R+dRNCBO2sxV74Nq4SPIKSXcUysCh2ltjIdWsWafHSPfUZeMj2fK36AR2eg+g9XmOzlmRI2HObUhqTtaPtEA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81d8533-fc56-4cbd-394e-08d7dd25e452
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 08:05:10.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQtAl+bJXQqI3ByOGK+lHVZPAgsb91y8IwBcUL9tdLgZGScOgPk4nNt9YiM7097feZaYJf7T95WQu/x1wfsjzNrDbn8x0/+GG19zPFS9rTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3661
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/04/2020 03:35, Chris Murphy wrote:=0A=
> Regarding the key being stored in the TPM. I know the Windows 10=0A=
> hardware requirements say a TPM 2.0 must be present and enabled. But I=0A=
> don't know to what degree such hardware is prevalent and supported by=0A=
> the kernel.=0A=
=0A=
In the end, btrfs doesn't care where the key is stored, it just needs to =
=0A=
be accessible from the kernel's keyring.=0A=
