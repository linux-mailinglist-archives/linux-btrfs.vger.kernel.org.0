Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCA28CAF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbgJMJZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:25:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15906 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgJMJZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602581140; x=1634117140;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RWsRTU9tGGQ79gtIpuA2d1fXuALAzia1jz0TkDx2Hgo=;
  b=gbelTqwrE8ZxBs1Nxx0bftsS0YPOjfAdFPhylZGNucDXoiexi5XBjd53
   ajgkBtQJ4E5+FxnTIkPN8m14VcUVIsyUlgl3FFF7JZ65JTEO0TNma91rx
   +yMrSHtvK7Ets2NqNA8kIO32uHr7c8WBO7KDBz5vdF+EAnan3JR0P0Tgq
   6eGXrG37Mq2A9CjLHfZxTOz4YztMvHuzVxcPUozTLUYzDK1A4IbdD7g2L
   djiXvqd9RVtvbmy591EZd7hqqf4AUtXSr+IRwXXr8vvitSYIaU7IKf3pR
   W+GfJS7sOweg1mAita4H2CEy8gwVAdeRkUvFuMgas/pTutmJ27pJ2D4Q5
   w==;
IronPort-SDR: A+mwRtcaW0Pr+ri6LEJG3UHy5GcAbjedG875LqfjsvbdW/Mw5DhugZG3ckhYVig6YQ0dh5sPr6
 pzgBlQkcQ/W83F0NQkUlvJd4nZnXg1Q7oqUd88G2flB+GI94WcwwDt2dgo66M+kmLAedG/IGWZ
 bJ9Yb4vYHyZcqYNUEu1TsNSYtyxkPxNSxKTd/Z5U7nK2cPX4zCYLe3VV0O5KbF573G3D7CIiLP
 Ttl3pntgK5dFr5e9czGc6hiKM8+JF342ORlpPz6yur+7UzQQ3EtcdQhTBVMp6R5aj6WHguX6Be
 hKA=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="154131472"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:25:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvBSlOv0q9kIDQ93W9pawI5JPzwvh0GSD2pC80BAJilkAX6n/aQttPxUCVpnA/BxgUD8FprWM3ydtxslWYRzecSp7OWLDQ0O6uhfWFrLOFWo41od8BkxKQJb3XgRMZP18ZCccEYjEZq9vrl89RiBFdUtQHzZKRy4WtmDEy0kqE0DKmgGVNTcUvFQvM45cG8GYJXVVp2pkOPA8BwDkTiAvlFTvBN9jRi/F2lwiU1320Xu4p5VEccWP9FL9IEkTaTFHDDRudtpqpv64eJCEs6/iK0PNjZontitb8diycOekue+rQDdbWT9r4J0ohNyH9pJ2Vz8VZn2tkZplxG3NzOuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxRtSz22ddXSn1//NwTcCnaXqrnwjhNoFrGCVYnUytk=;
 b=JbELjkfx50YWlNywiosM5FxpHDU+OWrSyYZDJsX+rcw1Tj5904XQH6oKeXOwgyFBPrEl+74s3D+SXLTIcz7IxRjFdKShVqqUepFccoStPpRcWc7Bj7rQpwbE1SlXB2mQ48b+8XJQzNfcc6Ns6+uGZbEG8elzi9zAm/g/NWVgsDr3U6H6WYnKRL7sxtGq8y23Iyz+2jrowR7fqsuqKR6AQ26vBuB1bpICyYdy0ahZLfCA871HtMP+Ppl+f2ext161BEIfRZtrROO19lABWOVWL7LRcOX2LD8uNZm7/JyjJZeRbrIKApNPhbtAJSgj1wBWSUQOD/6QSkBdjs2Hlk77kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxRtSz22ddXSn1//NwTcCnaXqrnwjhNoFrGCVYnUytk=;
 b=WrBvDSqUMUzuB853oflLyPSPcssQSo/hsGLAmnqZDIEgYw/Evd89yNDh1u5KM1UKC4veoWb67X5xx0cCyEpk/ZoTiH7xsnCuiaP5joijwTPzE1IuaEB1qxbwjLY6bNMfgLqRBtv+VdXbJslk7vbFI40uYxvWN49yQm9EXhjTog0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3519.namprd04.prod.outlook.com (10.167.133.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Tue, 13 Oct 2020 09:25:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:25:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Topic: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
Thread-Index: AQHWoIY3ciNzxOWRGECrI9HL++8YqQ==
Date:   Tue, 13 Oct 2020 09:25:38 +0000
Message-ID: <SN4PR0401MB3598A89E63144A52463CDCE39B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
 <SN4PR0401MB3598176352537EB6551AC3CF9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAL3q7H4MPN-NLomCZjM7oQFxA+kE=7hWRSUcvp7E6B9hx3h46Q@mail.gmail.com>
 <SN4PR0401MB3598657ADD78C6C0B6ED17FA9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c91f7bb7-fdc7-4414-2b31-08d86f59f2b6
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB35199E7FC48BD53EAA757D829B040@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0Famr6QGQeqXjAJDZU2NN/C+ixvtrQOZkOcCF2k1rD4HObA6oVDMAhWb32zi6r5/x1fZ1sSfstuCVBIOrdxs9IPnSOayEV56q4j6arMXAInhBeIBCE9+dZheA4hVwtgv/+htu9AdgjSrXRQ3e3iD7BgXoWqXR/QXG1opCbdjeFlhtkM36R6JYfDnQHUX6iut64bEf10EB5faWrmeRqX04skKSi9O4v+elneEwrb6oCNeJnC8W1wZRZ343oyF5Mc41zcnwvI477kXhAHNnV5xhKxVbSRY6gWqkMfM6GZr3Wo9OR5OioJla7+Rjnvx3s8NQeSefm68Rl2GEL6Vj51BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(7696005)(4326008)(5660300002)(558084003)(86362001)(478600001)(2906002)(83380400001)(316002)(186003)(6506007)(6916009)(9686003)(8676002)(76116006)(71200400001)(66556008)(66946007)(66476007)(91956017)(66446008)(64756008)(33656002)(26005)(8936002)(52536014)(55016002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xuQTSNXrahO4sTmcIv0FSNmjRLpgV/h+Px5OhUWslsmlpmj55GubCMd7dDO1p1ELaIN3PQjNNn8A8YD0r4jrxEt910RBwLzkS8P17pgluDLLPZ69Hm2OIFR8GBBpliz7hHrE8Zp5wIQYpBO2xs0ffoBJCMH90Sf4ngivl4HHEyFWJEZjU6o7WFIPTW757Bpn55nNUdPRqkRd9kfasQSjgdyNUXOQ3e7tPXnSrv+1yo198hlfDfdT8f/zGw/NHpMTn5iigiTrU+p1D875E/K+bDyqsmcdWsI6VW4n7f78kN7zl35fccyCVsd7ln8HrLUk6jupsjsmKyFoEyRktNa9n8rvuLwrJPh/gfKlahickfAhJymV83r4ya5Z7pXx5eavkJTngFwZLSXKJcdWeysEsnQd9Jogqqj/L8q/S6nHLB8vfkyOQuv6FFlwgMEpxVQySQ0cAQoUxauoz1Rf7TzHteEH6xAoSx+6gIooIjC+/Jvib8IpkvIfDL+bm8tqCPvizG9n/zRXGvHFVRjV9krhRRCMCwaH952mOvHaFlfd2GH/0wEH2B/zVuVWdWURoyvS8iY9V24/YcfsDO8Zd3LwEf/sEZYEFB3yU+GIx047NP/owJ5AHCyP3b47HsLfOwgrHbCridV+gXuGPlnFPQ5tng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f7bb7-fdc7-4414-2b31-08d86f59f2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:25:38.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLACVhrV13bnd9Zpl/jtZcr4JKj7gg31XlYpWNTGtyyaWWB/n/Lk8RSh9cIHWY6uaj7pIV3vfGAGEeD3sbwYHUMqMOLsC1ayDzw1XapFRLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/10/2020 11:22, Johannes Thumshirn wrote:=0A=
> fs/btrfs/reada.c-                       /* no fs_info->reada_lock needed,=
 as this can't be=0A=
> fs/btrfs/reada.c-                        * the last ref */=0A=
> fs/btrfs/reada.c:                       kref_put(&zone->refcnt, reada_zon=
e_release);=0A=
> fs/btrfs/reada.c-               }=0A=
=0A=
I'm sorry, I'm stupid=0A=
