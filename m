Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2554068F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhIJJRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 05:17:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55116 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhIJJQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 05:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631265350; x=1662801350;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lvPjcBVuO1e9CuJgikUEZqUK1j3XGn+Nb/cQN01GKBQ=;
  b=LgC/Fc4PZfNcWP8MjC5ck0ia2BVOhqXcZA/IGYrMo9SPRhbyrp8GBUt+
   xfHZZa3scIekuqD+r/AtVtO5OLrhUV3hmaBq+3yo1oxEOKD0Q/mrN+xTF
   RB+VZt/a7vL4PN31owXYkaVfL3YPI4gNPMrbumvB/0pKv5DwC4zA3Hznt
   Nd79p4pi9ezjpdZmLXL8o8Yr/PUWCQLS9TzLFpwz9Dcxdo7rnxIP5Dd1c
   mKSsR02K8I3MOE45SWN0CPfDXUBlM/I/xFR6KR0XXjuHhzAAs0FjLqevA
   w0UZ/S1GLs2OSY24QfQQkSmo81byXWuownUk3e1NVXzr+7HJ3L3eWs1s4
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="180199306"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 17:15:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsGMPNke3ObzeYhzcvKp6VSh/jOFeCWQIyrXwExI+pRQ9mrn3oTPT4IIvakaxNqx8+ecDnUHffKKgNXg7NA15C9s4BmtXSttQ/3/K7rqBsEjW3ntqHOqp8aku6l7ggagIWdJJLtYpcP6lvqMMZ1L1SzzRblf8Qta03e+b1UAOR1QfZ1mytFeZWYyGL/552McPYlkddnzX69moWKo4yxPkPdUaxgPJ9cq+ntRDhMA0R4vyoK9/z7oosShHV8Vp2nRC1PzdEaf8sHw2XsoDdTFH/kNyJvpQKv3OJktVgaU2N0nXeM7reI+s3ITsrZb3Dp2bnzdqYpxACEDWQ5qifF4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=As31PuqhUFG4aXIwwKDYBSY61H3TvyQNTuBucPm87tM=;
 b=kWzNMj3mtlMsqDy4BwWo+AAZXws55X3TgHO73NjYa/PdgKMbCGTHWzEq74AlCoL1Ed6mB8knozho4GA/tqNdJRvCUHaul1x9HnTnvXyE5Es38tt2Qt5HFtZ94bhqsnXmzIUSHv2nhnYwGke4tTq9V0W1H2umsNkWkvnFbl3ANH9pbai/RHc41gn726ZFbNUCXy/8SgPvmQshsZtqKHZaZE5Qn8Wb+LphHInxYin4MQQiRnZhWDXIxM7WC+nhNU7jwrvW59ZNOUHeiC6W5Daf/sRUXO1+L0O153vRZU4QsdrKYohrGX1u8d539XH1z3T7+YHkWD0iUgvrOEvC8vAD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As31PuqhUFG4aXIwwKDYBSY61H3TvyQNTuBucPm87tM=;
 b=Jgl9ji3z3trHv0eHKCuXcGWGcjlqBhQvrTapw8rJYCFhN+h10230gyENGYn7NRwJP10/VxJl24Vyq2ByAV5zyyw/3pNket8rCcYabgNa86NKUPG+O2rjWWD1WblH+1v6o2Mcb07etJJ9Eu1cpQ4B+/EKt6bwV3SsNBjHD8iGT9A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 09:15:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 09:15:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Thread-Topic: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Thread-Index: AQHXph6VmWg181c0C0+gAD1K65Rx0Q==
Date:   Fri, 10 Sep 2021 09:15:47 +0000
Message-ID: <PH0PR04MB7416EA5BCA3624D86F2701A29BD69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210910083344.1876661-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e40c041-8f2c-4fba-8ca7-08d9743b938d
x-ms-traffictypediagnostic: PH0PR04MB7191:
x-microsoft-antispam-prvs: <PH0PR04MB71910BC89B9753B2F83129AE9BD69@PH0PR04MB7191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUdJzY+7oLz3hodxDYeUzF6SGGBhIcAjm+O0qS/Z6w5q8ciGgskwCWYUB85je5J+i0QzwBMbPoqEpSfFJDFvpI3UlFM2UDmO9azwtb88C/7gRx4XBGiL0/oIBPDDZ/B2eQfxQUAcLACO6EFQkh3Z0sv7wCx1Lbxt0QqeaNzlgj7fR9E7gyAa65i64bh+mwRuqvNyNgQY6TIpp8iUcr/oL18pl5AJr6QiLjjFzOcl1l51fGKRu22sLlBRJ7fGaXcXNALv+BETc8wuWQTyzF/xCtHIiaf1MoxU9wJ5x935RMhwt2L92odTCIWMdG7RgY4l047el3Z3IJ3PfiRJdzmJxX+HLPqLboCfaJVLi7rn0GbB79GqFm/FCuizSW3iIDXEtqzuWAwvwLeMFy7czEhKeVWZaRhIVO5vfXJkElySXBOelq5dPMWl1E8HA8TPINF6opgIBC7dGkoUjvtE1d89b34uGpJYhzcJYby6t60yWRM+WoNXyAbVejkgZS2qAyM36sDaubFXoBjD/SNn6PUKqEKxvTBEwxZK7Hxv7lwvQ6XQCFo7xLJK+S8dTEBYenSeINcjUgylCEMMSnlPgy4lpDM9QfkeM99mGB0dwRSa/wASykd4cX4HENDt1wShVUDaT6Xt7eMJYPZL5i1H7DY+XL9VG7wyrWI3gwk83jpYk9rZ3prkQIBITzV6hLmolnech6qMaQxGioy+yYJtJP7+JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(8936002)(478600001)(186003)(86362001)(5660300002)(76116006)(9686003)(53546011)(4744005)(33656002)(7696005)(6506007)(55016002)(2906002)(110136005)(316002)(8676002)(71200400001)(66476007)(52536014)(38100700002)(122000001)(64756008)(66946007)(66446008)(38070700005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2dF4ufKmknX6jyhhujBXbSUaK/NMt7OzYUbbuSjghA/IXDULWgATLniTN4F?=
 =?us-ascii?Q?SdmO33Bun816GDOik7ErxP+CZta0GqnwGSM7ATP9XV8AI7AgFgITBW1vCHYc?=
 =?us-ascii?Q?e85Tjb9yaLdjDzBEcZkimISQIj7G8ZUsFvx5gUczdRu8RLYe+eX6GEpa3NAV?=
 =?us-ascii?Q?ICA2utCStW2KjFjLXw7f79SnZupImsGRS2rnXaHYCOhP7vbXRgfBGu4wB7HK?=
 =?us-ascii?Q?IbCJtJJt4suSX0h3xbWZ1eR012AJecLUrWd0Az/Lc4oKuow/1e7oMe6cdRQ7?=
 =?us-ascii?Q?Pygsl9AjG0tgGR+s4hkg/zaVBk0kmEwqyJTWxZ3N9PrLscocelNMWlwjzWcN?=
 =?us-ascii?Q?WA0DnJlpop4MVQ3Xhi/Y/Oz456bzTOj4pgkicReXD4u3vsHJdOw0ayTfXYpm?=
 =?us-ascii?Q?K2p1ioip0/kEVkZ6PVxifkDzxsG3BOC2clDYCzE6lrrmSKvQiL/phxMWALLI?=
 =?us-ascii?Q?hlxlO/rSoQHu0/AC25GJGdCxfNosJl6/yDahX4eu6F/9857pOQaDpKkt8z1z?=
 =?us-ascii?Q?eqfLysp2lAvbnbXIFQefGXer0A63jo96fWkcmdxyUu3FvBxlBQGr/VzgfnY4?=
 =?us-ascii?Q?fKNxNnlfdin8HQENLooiDHot+02P0dLvcjT7G3bYF4U7aVvPxLykq6mCxUXv?=
 =?us-ascii?Q?5uzGC/efIEFz4IkFyq6GO1WkMWaZZzZTzJkZfdr8ef8oDWwoEwCAWUVV4WbT?=
 =?us-ascii?Q?m3OkvD5P1x6tArqVvJomCv237wT0U9m0nFgVY/fNT+tXtDH4PPx48hJw+nwr?=
 =?us-ascii?Q?rBs2P1MlBIiZhDx1ypsWtOlKz5yFMxHRvdPGn6EDlmaJIkw7Pgz1zgFYoOta?=
 =?us-ascii?Q?MIk3yJL/kmAuE8YtgLFh4VN2jxVIUnaDBcoS2xEKsXxheXkob4YC4NwNrThJ?=
 =?us-ascii?Q?jcfW8vDJzojmA1KPAyn7RYPJYwMfuOpeuFNxmJw/dIrTKQ9lBnRD2Ybtvniq?=
 =?us-ascii?Q?Kvs4WqSVgaiFKtF50TWjclnWhHsFhbJcUeHE+yg4s5v+rXk4MNCJdkZPXJQc?=
 =?us-ascii?Q?hNYdIIHLr6kKDJdTtu65xuPHC27gbQ4U/xsYkjDfbT2agZY/Wg8zId/039Ml?=
 =?us-ascii?Q?7J1vEWysRZR4QAefKu5M7EdsXRiNMjzhA3GDVGJvy/YSYQWHrpYHI8FREvGN?=
 =?us-ascii?Q?3Yy5B3SwTNj3yuWJGLr1ClAqCvSsagApVrayNRNLV4G9sO4zpnJeohGi0aRg?=
 =?us-ascii?Q?4qgxTVF56QkxQENOchS967Yq5AZnDyDCb4cQRVfTPS6Yo7s0nGnga6bNYaaF?=
 =?us-ascii?Q?DlgaMg4Lcmqoohj24D+oSMIZphe2SZHsmcsW32uuZsMFrZVu2Y1icWwlF8Vf?=
 =?us-ascii?Q?neMZ+WSAnYO5GlspBuVKfM0OCYFDjk6KRgPZSlQ4yOizj29QmWVwC7v6aS47?=
 =?us-ascii?Q?pOjy7soAga2BdnI/xGclY9TYidU8LsoXX5FF9W7JUqcoEJxBgw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e40c041-8f2c-4fba-8ca7-08d9743b938d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 09:15:47.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktbjcgFJy/n49F3BEYZXvnu5PDl5UvHCpJAZzQeKpIOA/7C+HEjtgo46mfnZAk3nS+TZfzDJ73vlybgvHE+HC98IB+gaBRUM0yPx5a6xy/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/09/2021 10:33, Nikolay Borisov wrote:=0A=
> Currently when a device is missing for a mounted filesystem the output=0A=
> that is produced is unhelpful:=0A=
> =0A=
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2=0A=
> 	Total devices 2 FS bytes used 128.00KiB=0A=
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0=0A=
> 	*** Some devices missing=0A=
> =0A=
> While the context which prints this is perfectly capable of showing=0A=
> which device exactly is missing, like so:=0A=
> =0A=
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b=0A=
> 	Total devices 2 FS bytes used 128.00KiB=0A=
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0=0A=
> 	devid    2 size 0 used 0 path /dev/loop1 MISSING=0A=
> =0A=
> This is a lot more usable output as it presents the user with the id=0A=
> of the missing device and its path.=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
but I think this also needs a patch for xfstests adjusting the filters.=0A=
