Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37738938A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 18:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbhESQXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 12:23:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32919 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbhESQXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 12:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621441345; x=1652977345;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cg8fbAmiAdODs3NIxvmkpihGwXlwEWaU0TugeKndZjc=;
  b=dKEw1FS1v5t4G3nxbd2qfUduvczruui8XFB+gpmk3iwbCYR5RLh7hpmX
   Jn6UL1Ou+Pxgc+PKJERE6dqrFYuPbkoVfG5+exlRK+6tWg5P6+wp9w9B7
   YSo4oSOThwdzS1CpOmEgMMbohyr55nPFiVhx91/NKSToMdQoF9EaiL0i0
   jddn908aQHC/U+BQVUcyhmuY7TOSHm3xRl5K5LBMjtp60OAruP+Ya5AHR
   GuXKp4hCjlXsd2HrBSefbPy/QGwq3wsbYWYKgkosFESbc2s6LQqYHXOsR
   f2dZiYg9oM0fep/+U1AuhEMpCABFIwJ3OTtiLX6iDIwcOwRqtuQhhhMGQ
   A==;
IronPort-SDR: rQ5RldcG8O2ikIo2Ok26geHlEh0oKBeNcwHsTVu5aP7RFoQarr3b3Uw7tFCjlQSlaV1ZxeEnYX
 oblNzWeLQqWMLzOIoq7LLCpu4TuumrWszLr3o8Bcz6eP3TYRrtVI2UJmt6U57Jb5bWIioPVkGh
 /nN5Y8nUs+dz9EkBDG7jD6xi9mHyag9BzBaOgkkLS+uuIzJME95ceJHgQMsZGz1+ztSf6EWuy2
 d/JIwFusfBCaPcB6QGoxWbYKBiVlko5q1RAIb6zeFSnoyZD8YvnRfP41z4tyMTgX+DMXiWqRYr
 Lcs=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168030346"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 00:22:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpTu0apE0KmA6YTdleYjyRu61VX5mBXQW+WYe9JYBvqzgD/CAZzHdz8nlNvwRpWYgXlWynx6iWxcVRQKSc6MLdLT+X+gaPIFvra17KFvSW90G+q/1e6SCf6zlPnzZyLZEGuASCw9mdTQyLfRC2Eku3MphkPIH/OTbEDOxyZ8WSi7+mI9p5jyYPIzSFsAT9oZm6XMBBttiv3TQ+IiwmcWEPtpDnKS9GpS8Qi0wRUXePvM25WdwHj+XF60IYHtptccg7RqHAaEFlRmfLo5G+ZBD9tte/9dY9P8YhCrbOcDaQ0jUhSBlwnA3l349RLS5mu2KfEZVmCMG0SDL0Sf2nQJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah1Igr1ra8NHm73xLgybWg0Tn+F00TMI14AFro6CoL4=;
 b=MbIRulVLex+u/Y7I4sB1vooNoU0x7X/2qtljEqQIOFNcmHRI0lLSN2xJjq+ade4Hts6t8PuwsLfLhvT+wk9+iy0KK/2kv1ta8CEL3w7Pg7Il9mimDanXEOSsDP5EYjLOSyS9YTD6/DIuphT89vuYmX/19HENk7xhEbS24XD/IDFaa9x9fCXBiWP52LUSDnoroosbhgGysMc9rwx41ShIb2kZ+E8SegvqMxTcq69VfcGrJk5wcBH65KXFcPbTVJJkaObdDITqCyBIIhTh5vRZA/vrbDJcHkN8bSDez3Os8G3yTybqbRVDTg5/DDlskF+lgtE4rb/j/3cq+v/XEZXWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah1Igr1ra8NHm73xLgybWg0Tn+F00TMI14AFro6CoL4=;
 b=F3dr9ks4VGeBQ3e3QwOn+SjWhiTsuZAp6iPseij1o8dPU4P5wBBLw2QqzizRUc1/lrtWQY2+0xAN+nxUqp5Fi/H7b+cHWfzd72BsrW8Telnvgd/lu9AwhTPiadOvwW37W/h6+QChRWUogm952s5hNjXdKyS5rTAre/D5gLy+IDg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.31; Wed, 19 May
 2021 16:22:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:22:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
Thread-Topic: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
Thread-Index: AQHXTMO4i1O6vs2NGEealdnOK2V0Pg==
Date:   Wed, 19 May 2021 16:22:20 +0000
Message-ID: <PH0PR04MB7416EC2004FF7AB6B2F4D5339B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44555605-2a7a-4046-22c6-08d91ae2471f
x-ms-traffictypediagnostic: PH0PR04MB7176:
x-microsoft-antispam-prvs: <PH0PR04MB717612311F27928C9FDA7EB79B2B9@PH0PR04MB7176.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11XUUNMqX9RshSkuRbYgaj1ZfW6JTrBH2EUJ996T6xBqOjad+/uRX6biZc2yU4wUd3LscGpoAPUQXUgpSk+jRNt9q50Wk0CPlXwgjQQZwkT89x4Ivki4y1s/n2aXWlgPQ+GVaWPyZT0mA4nNsBdZaADcenXlS7ZkHdiHzkY718Jrr4U6wIqD7UmqH4vPI352b8mwB8e/AzMYKlRfJMZfmm3V1JsGNvlQCqkgFXQCHUr5wMLQo52HAV8hY1xoaul8rrJn+AklEYzQkB6PCLI/6n8lbzLmUB1htTBhk/MeIO7UidiTO0OE1OwuqmqH4Vc9g9RBxB396NMCX4b6MCgX+2Pi8tfA/YegLL5y2UUs60GilRv2aH1UvtzkXKhNeLH9EtuAQGzNMnSF6zgRuquffu4M6Uwm3wdchg/lLq1wr7o4ZEdDIgujTeyVMtozbbftNl+Hzew4hMXA4IWSVp2Eb/453jpOiFc1NAHP6kGrECbCQv+HjeH3d/pXwL7erpg9B2/geB7a0azZqYXR8UguASLy2N0KBgH654XI2Cwx7f8Hkzg/Yv5Y08lebX4FrvmlrEns0+5/s89Lwkzl+OXs6x4MNGxJnNQbX9o94R2kmrU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(91956017)(86362001)(38100700002)(2906002)(64756008)(66476007)(66556008)(66446008)(8936002)(66946007)(76116006)(9686003)(55016002)(8676002)(110136005)(71200400001)(186003)(53546011)(52536014)(6506007)(478600001)(83380400001)(122000001)(7696005)(316002)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FWM9gYSXOfOVzSCjBxXicShx+wAb/wsHHEx5OWaAQHLnwsHmGNtyfNNLQhX2?=
 =?us-ascii?Q?XtP6krAy3NtyYFNe2IqvBAY1MJMInItrbaRNJ8M6P6yHZhtSVMBhi772RIl8?=
 =?us-ascii?Q?b7lETR5oTLSRpeSPgTxwk+Twatwzcnkt0Qu1UYjBrygiFsrh/P5a7kXUKJWE?=
 =?us-ascii?Q?2XO+riCE4/2sIPrO6vwO63T++aHlrTLfOzyhw7P49N22+bazUJwr1WrptHjY?=
 =?us-ascii?Q?Xu73zhej+EBTrMMj9wWcZVzgw5RYIbTYD3uTujDLZ0P287Fm4SQMfUV8vzy+?=
 =?us-ascii?Q?2i7QUc8k8wNT4AalxgCUGkG+ahf8pbcD2IqHJtoDbzCxZhQEAXz8ImFbFIsT?=
 =?us-ascii?Q?jPuGDVqQRasfzarSRl5kekVjhHqpwqll006DuPLB6PgKKhYu1xLjSOO51ICT?=
 =?us-ascii?Q?UXRwQd07uPvsb65WwqNzGL0/N6bnngaJlkRubkbMEkNXUR+YPxV7BRFx+m+p?=
 =?us-ascii?Q?zQh2a3mOR/g2gBLsOembNngPWd11iSevpeouYDLdLwC214tfpBc4E1rqilRC?=
 =?us-ascii?Q?H29gFpsZHkEMtX+voVHbz6SjbVb/iZeM5FOx4OuktTsHSGhc2SPtEvBoLpTD?=
 =?us-ascii?Q?XFXAHrwRz/0v3IRaTFSpi6HcGTlbqSWzt6QRtbXXJBVf//PkwjtNm/T+vEJJ?=
 =?us-ascii?Q?ln7B34XWb6Zso0PlIM8bn4skBNrl8KKOEz74KhnFCPW9K5gCB6c09nqZ/4jn?=
 =?us-ascii?Q?dgfd86RIYTrIkBX+5sJ3zHpnsBuKZpJnB0Iu6z/hdOggbtRZysy7e/fBUuR1?=
 =?us-ascii?Q?K+d4VPaqKF3ZRC+6geW8h0V7487jOFJvSU1m6PUai1EZ1++b86OHxwkaUxGx?=
 =?us-ascii?Q?YDcz5Vr7BVNTbMbJi3Rf+LR67HjafWpDk7E27q/2dGcGi9fIcu5ZLcr2nTXX?=
 =?us-ascii?Q?q470sHug/q36ogNafOc87WqdbpU3dPFly4B/5pCfTNtwOSLMfKLpAAXk6q4r?=
 =?us-ascii?Q?JeHgwlNYoPK074wVOUGIpV/a0FVtF3REWFOvpYlr63O5KGAS94a49yhl0+j2?=
 =?us-ascii?Q?S2ALTpsQwDiwaMW1pnQOFthajXZ7rmQoPRpMnz+Cyy9gviEzeU1XwdAnhspP?=
 =?us-ascii?Q?eI2EPD+/099e3HoItGIrSEiA9e4VYTBBJtg+de8gwZ/rV1mm0cOa9V8Hdzou?=
 =?us-ascii?Q?rs5uge+rpjKPPV3tB+BmBn4Z8AuptqtErsC/lQv+4/hbXuTarLb4eQpoQp7s?=
 =?us-ascii?Q?Ji+noe74+Bl6aeegIl/Y1bnyrd9oAcFXHULRi75VTfKco3zHVIo2/nT2fapF?=
 =?us-ascii?Q?UsD4ayASnm7GzlCvewH5l2GHke8eEPwzjTBrWZKja4+z2iFMLHQHo1TkrTWJ?=
 =?us-ascii?Q?9hRMOYyve5Wj4l8zfERq5EVGnmZN1nOe9uOlgycwa2Vz8ow7xA7E9fVRcEoV?=
 =?us-ascii?Q?AIauGMrLUBb2yEIQF3G2UalOZD2mlXzvE1ZYU4wtgfGeEJYiTQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44555605-2a7a-4046-22c6-08d91ae2471f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:22:20.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tGMfEygHzzEQN73JC60XFPVqfSAMzlO9z7M1x1MIJ/Cd4qSMM4cVNR7rUD6JaiOzdPMPZUozyVNSsmh2n076g+q5WpZ1OW6iOJNVx6AtaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2021 17:29, Josef Bacik wrote:=0A=
> During inspection of the return path for replay I noticed that we don't=
=0A=
> actually abort the transaction if we get a failure during replay.  This=
=0A=
> isn't a problem necessarily, as we properly return the error and will=0A=
> fail to mount.  However we still leave this dangling transaction that=0A=
> could conceivably be committed without thinking there was an error.=0A=
> Handle this by making sure we abort the transaction on error to=0A=
> safeguard us from any problems in the future.=0A=
> =0A=
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
> ---=0A=
>  fs/btrfs/tree-log.c | 4 +++-=0A=
>  1 file changed, 3 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
> index 4dc74949040d..18009095908b 100644=0A=
> --- a/fs/btrfs/tree-log.c=0A=
> +++ b/fs/btrfs/tree-log.c=0A=
> @@ -6352,8 +6352,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log=
_root_tree)=0A=
>  =0A=
>  	return 0;=0A=
>  error:=0A=
> -	if (wc.trans)=0A=
> +	if (wc.trans) {=0A=
> +		btrfs_abort_transaction(wc.trans, ret);=0A=
>  		btrfs_end_transaction(wc.trans);=0A=
> +	}=0A=
>  	btrfs_free_path(path);=0A=
>  	return ret;=0A=
>  }=0A=
> =0A=
=0A=
Hmm our Wiki's Development notes page says:=0A=
=0A=
Please keep all transaction abort exactly at the place where they happen an=
d do not=0A=
merge them to one. This pattern should be used everwhere and is important w=
hen =0A=
debugging because we can pinpoint the line in the code from the syslog mess=
age and do=0A=
not have to guess which way it got to the merged call.=0A=
=0A=
But there are 6 'goto error;' lines in btrfs_recover_log_trees() and changi=
ng all of =0A=
them might be a bit too much.=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
