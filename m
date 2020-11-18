Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531D2B7B24
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 11:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKRKWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 05:22:49 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8009 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKRKWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 05:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605694968; x=1637230968;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zbZkUnJqWWHyhwdULTH6R6SAN0xuJZDoThVdhseQI5s=;
  b=A+c5KoYDLxqOb0MPRBD/Z8kH9g3chgUm3XmtQNv2mt5A01AB5DicEB5n
   U6GMTmF43/qcqxlUndOti8P5ebDVMnpwwpUN6i+TiNr5jVtAhehVCne4t
   Byxya+Kf1Ow/TxNhV09Y4YiKOeSMONAFycSM1wQEc1G2EhP1TAUNpI8Fv
   s+vDKi1ZEYNS2hfFaT/B7aDmNYQDb2/xyTUR0zNAWJZdBd2qgtZ3DVZBy
   kMkboBGXpDIXUFSNG9/dXQi00g1j7V47j0w2HKfVc7XmIpqM3rMVtmm/5
   zK5/OutyQ+T+bpOsjH67NPcalHra9GxfjvlTXq3HuGBfCPgerkNvg+fL9
   w==;
IronPort-SDR: 7wI4tCRzlklj5XV5URv+XI2GvCcpmvQKnOkqcRthK5axUQS8OPuOug8w2NLWmSSovM9Hii/vBI
 xv4dILCxsDiSZ6eJloRdrbENf/4wc5x+2jfBIQQnedfijF5EgUKpkh2bkJDQ35bRkNTbAd1je0
 U6Lsf5yA9Fp8YVAeDQdLkCI1h0ptDOGxezKGeoMJ/UVHTabLmlcOehMhtx72uJg74ZWvZj+EkN
 R3BQzG3AHQSE+qgW090X858BIhUb4XoBQNP+rNjIZAdSwjmaI6Pxu1PjrNaNKEyuAfjXFXc2vO
 F0o=
X-IronPort-AV: E=Sophos;i="5.77,486,1596470400"; 
   d="scan'208";a="152782655"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2020 18:22:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxoOrjUMXz92pLFZhJvAW9D1yhkoHU7ZCEncQhdSbDVqRz9fAEbvnZLVue2ahrEXxssuvtgf3I90Pq3aztNq+gE8GQN0go4iAFKlrw2iSGo155YGeh6EtP8GZR6m42mubal58l52y+EXr25fZsuC/s10mL2LaWsEr8cHLWJMPNhd50dqu9D+YRzqTN1cd++443fBBpwKzCQmJoitmi+fXoSpOvW+HLgaahVUbZ0ISxiy0UqUhBjk1i/owMZyyfA36Jq+UNRpyvtEM42FqQeVh/vLERmjbjyNiGqwoVnFrwDlMVHkjH1qPLqn4DXj47PR0Aiup/74Ck3XJtFAa/ZXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2fe9oj+yuvlXk29I6nPNxnWLQt5eexlo9CsA1+Xis=;
 b=hNfYQje3BfUR/NTN/FqgQLvaeEVgYQgLtmyRSj7V4rgejIcmCelFFpIv6jT5FqnVYsz46z3xc6MVfruKvbXczO+foWy/hZxaeYChMeEeuYgOq0jGcbOVhMOyyWOP8qXjzgsNuSMPvMnvhaoSk/ovpsH4vSVVi1av08GXA/WZaKcj0RfwiFAJ+6JrrC5I1RQth7Eccvv7S16ngGR1ef6BXo65xwnKAp8R+39BnaF8iayg7/moAFFY20ws/rNRFyZRVY95UqrGJyVdua5aq3iNnlsLSFNzHGoWSEYpziTM8eBBkCMv6mMbABaxuf21TFBo2rKnxTK4n6QOmBhPb5mNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh2fe9oj+yuvlXk29I6nPNxnWLQt5eexlo9CsA1+Xis=;
 b=GjdCz6LwJ+s4wwtJx5DrK8jYgdAfovT8kHBTdvppMxM+w5coNuKB7u40K8kDHJ2r+xmTiWPHs2QtSuhc1j5ElQxc4VLpestXDhtPgyBJ+jUH+Pm4PX4DOxM4Sdi+Tk8L5SrA5/gyBObc/bqpneYBRLMIBgtE1EqyGTzqLnUHNO8=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5770.namprd04.prod.outlook.com (2603:10b6:5:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 10:22:45 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 10:22:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/14] btrfs: extent_io: Use detach_page_private() for
 alloc_extent_buffer()
Thread-Topic: [PATCH 01/14] btrfs: extent_io: Use detach_page_private() for
 alloc_extent_buffer()
Thread-Index: AQHWvYihpWnszWLKdEmCeoKLFHHMGw==
Date:   Wed, 18 Nov 2020 10:22:44 +0000
Message-ID: <DM5PR0401MB3591012A2714CDA4BCEDB5C09BE10@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20201118085319.56668-1-wqu@suse.com>
 <20201118085319.56668-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1528:b801:c926:e87b:b5da:7b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f223a77b-6024-4bd6-102b-08d88babe3d4
x-ms-traffictypediagnostic: DM6PR04MB5770:
x-microsoft-antispam-prvs: <DM6PR04MB5770EF842C934A44BA6E0D7E9BE10@DM6PR04MB5770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noNGlSOTffEFFA+Yd0M1yl19GemyjXf50gu3rYBMatGdnpGhiMFVcZzaM9JP1j/WsAoD93AAWXtNgt7Zeg2BfB99r9woGVMUFFa+IgYPH+K5tCrOM7l6xsttVeAVh5FhOyUJpgJk19AXMKflP6EXLFzXWL1+i+s43zLX9Q2Q5s1kRBFYyuHpvGUZu/tl5OtloEkGgVaYWGDjhvQqAOStbL9o9Lne345p5VM2ZQKW7DTfvNNNiRNchLwtLSrhzfHVty0LVCSJxHxrZdTQpNKkP5XxduQ+C7tHyANzrufZ6h11gsVVClqYkZTsyJA1EJVHrEy8PVuvrqPj8ZhllVDcPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(316002)(8676002)(110136005)(9686003)(66946007)(186003)(83380400001)(8936002)(55016002)(478600001)(76116006)(91956017)(71200400001)(5660300002)(52536014)(33656002)(66446008)(66556008)(2906002)(7696005)(64756008)(66476007)(86362001)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nNJKJijFysb6ps1ZMQP9sFc2rwWjJzWfdF3eWv/8+qtYLXhOGtdK54ZElZYA?=
 =?us-ascii?Q?0iUB3nlWd+tOGWly0/2c2wUnJ2HkwsH//UWbcSMFAKc2fCtbjF34f8VMwlf5?=
 =?us-ascii?Q?M52klmyyN9tedqo8fSMWdnJfxkGZhNPxcRpo6nbLVrW1pmZ4OyDO1Q1yqvNm?=
 =?us-ascii?Q?CsTygH2uAuBDB/qYv3IkGMI0Pz1jA01N5jbfBE1OFUy3YhQgSA+mUf2FoSTO?=
 =?us-ascii?Q?aWOxSyQGDG5P6QKHxMGkOU08JPCcim2Yz1DkO0c2isGcgl+lv3K3Sjbo82ZI?=
 =?us-ascii?Q?6kd/LMSXOWdfWccc+zYwiSmDb7UxZSr5WSR7isehDDsGsdRIqvIBW2qg/cVG?=
 =?us-ascii?Q?EChMX4keyZ9KiDzxXMk904c1jhodytN7gV2dx8bTslLGiUHczygqVx7bAEd6?=
 =?us-ascii?Q?D/vPfVGHZ/R+vdAO9kAp05ih24ic3c2k/7UqCefwh8k2dh2zDlfpxW8KHRQp?=
 =?us-ascii?Q?jmJ4HDKcp3MSNA8sly0k4L1Soh6YWPY6bhyUzCq4ub3UgXLJ4j03JPCyvQUE?=
 =?us-ascii?Q?/Qg4encBquHxhjmNTtDQ8bogwryUcO2XFf0A1XUmX7vDpEZ5Z4mzzdFsOiZ3?=
 =?us-ascii?Q?5hMBL9xH+6i65Op1NTlTUp7bCd33jXHOlZ3iFW0y7mrLZUWPEKQ65tgeowsb?=
 =?us-ascii?Q?GgHRAeKHnuLDYn4AzwKMGkhQpkPUohkuVpDDVCZXcPl2Cs5v3JrquSyzMI1H?=
 =?us-ascii?Q?lK7OsbRAOv5JaTmnYkvktesBrI8qKHaxpJF63Ac7Fwt6TF641hnHZT6Hdf4Q?=
 =?us-ascii?Q?6k99bcoqklzFveLPbR1XWoweIKcmsYfoztjvZXrq3l4XxJjVouKpy/j5BbKh?=
 =?us-ascii?Q?kouHQ0UwzJEJAgOngipZnNExiOg9EcoCMFDW+wYacRXDBm8eQL0cf/tYCl2g?=
 =?us-ascii?Q?+ifqfnkK3YQhi5/bgMEag1Z5tt6XFjX4vIKKE8UYsy0o1ki5kEz7KzcXKxM4?=
 =?us-ascii?Q?1a6USubSNdXmlvXRnOBOWQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f223a77b-6024-4bd6-102b-08d88babe3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 10:22:44.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKqI6tdlwzrkxUNqettu5bPqkAd0D7uHX6OQfPPX7PhCtTl7tXD/esOfvmHIjE2iWqXqHa1QAs4NS2gMH/AdN/1Q/vyfsfz3XhuEyaBe+nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5770
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/2020 09:55, Qu Wenruo wrote:=0A=
> In alloc_extent_buffer(), after we got a page from btree inode, we check=
=0A=
> if that page has private pointer attached.=0A=
> =0A=
> If attached, we check if the existing extent buffer has a proper refs.=0A=
> If not (the eb is being freed), we will detach that private eb pointer.=
=0A=
> =0A=
> The point here is, we are detaching that eb pointer by calling:=0A=
> - ClearPagePrivate()=0A=
> - put_page()=0A=
> =0A=
> The put_page() here is especially confusing, as it's decreaing the ref=0A=
> caused by attach_page_private().=0A=
> Without knowing that, it looks like the put_page() is for the=0A=
> find_or_create_page() call, confusing the read.=0A=
> =0A=
> Since we're always modifing page private with attach_page_private() and=
=0A=
> detach_page_private(), the only open-coded detach_page_private() here is=
=0A=
> really confusing.=0A=
> =0A=
> Fix it by calling detach_page_private().=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
>  fs/btrfs/extent_io.c | 5 ++---=0A=
>  1 file changed, 2 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index f305777ee1a3..55115f485d09 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -5310,14 +5310,13 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,=0A=
>  				goto free_eb;=0A=
>  			}=0A=
>  			exists =3D NULL;=0A=
> +			WARN_ON(PageDirty(p));=0A=
>  =0A=
>  			/*=0A=
>  			 * Do this so attach doesn't complain and we need to=0A=
>  			 * drop the ref the old guy had.=0A=
>  			 */=0A=
> -			ClearPagePrivate(p);=0A=
> -			WARN_ON(PageDirty(p));=0A=
> -			put_page(p);=0A=
> +			detach_page_private(page);=0A=
>  		}=0A=
>  		attach_extent_buffer_page(eb, p);=0A=
>  		spin_unlock(&mapping->private_lock);=0A=
> =0A=
=0A=
There's one difference though, detach_page_private() does set a page's ->pr=
ivate to 0,=0A=
whereas in alloc_extent_buffer() we didn't do it.=0A=
=0A=
I think setting it to 0 is more correct though, so=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
