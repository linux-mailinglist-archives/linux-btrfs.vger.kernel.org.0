Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03412B04DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKLMR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 07:17:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12941 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 07:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605183447; x=1636719447;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+GFkOa5HakK7drq7p2FGfsbg7iLGu3NJG++0Z4gXeMw=;
  b=VtjYsMJZbepFC8BdBoLI9Z1aXKEyXpf5wqHcT0e38u20vNBm/ZzyVdDy
   tEmaiCoJb7CX2kl88Zz2ct8OfqZrnO69ZWYpFjV9H/pY9VCPKXPomQNZW
   /uqLnHw3Woe6N1fKO+ZXFgCYzU7rNPT5JWe2w9Y0l/xezZMw9L2cLC1mC
   E9oaIr3Bv5jWEqAr1tEWncFAlvSsKOCwkgfk2OslW1gEY6NxdgRdp5aQJ
   6c7hQyV+oiXGAv2Sp0n/tJG09uL4Ke6YuB4onUZcS0WKtWcO7qdOKDFS/
   8JNTCJLPhr9663KTDtqtB1aaCoLsi7bqUcTCezLghuF2RQcYzHXtn+SZB
   w==;
IronPort-SDR: rn7YwYijod9V8sZPfXpPpseumkOF1rgr/8C+SurQb6tezBjr67VI7z9u3XWN61FWzXk0a4zKfa
 sGnps9/YOVJbWTtdlduTq+RWyDctjxAjpEct3Z1jl73/8tWrE0XB+w8udpmMdk8ay1e/19Ar7M
 h0qLc7QosSH2JMVdEPRHoVbmjhC/iFY+FgoZsseNxPFH2c4zwT/kYA47hst+/q44wOvJlF/UHc
 QtsEmvgKxMjyDUJFt+UHG+2BNjGABrJjmuTZ54irBOcyguc92GHrMeg97OUxqb2ShNRqjfDL3Z
 f28=
X-IronPort-AV: E=Sophos;i="5.77,472,1596470400"; 
   d="scan'208";a="262493163"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 20:17:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0jN45mpVK+v+mx6GUqeAGRuD+rDBgphpQIReqEWIEuEoNMbZTcSFq61PqxZ7zpNFhotk0H7KCt2LgpZ6uOyM+SYtY6uEQb3edtCAsWOayEAwa45VfkE9Snz10EdduZUlE6kwpJsHfkDUCBcO47nCfKXkt1DpTHhJmidBgqJs7sWmCOYo7giD64QMU95V7RcW/Gz+BQotEa/b3GSnrDH84d+8vcYmfYuzSuVNyKbmCcVDwMXzpnuECPGJWMZEiZeRNWFJ6yKEH648xtlX9N3Oca2rA6R9OoBXh9lKelrv51G0LY2cPhvinLBT33uDyjzexQH9HDJht7lf09BSGWRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GFkOa5HakK7drq7p2FGfsbg7iLGu3NJG++0Z4gXeMw=;
 b=CKwReEvM0z4aKzZT41i3pHMziRAPWbvk1VDRTSTGA4dyYVsqann/xTvqB1XTpPiuOGkVlQtK7x1LXtCf3AT/ZAKlb5NvY52hgMrt+o9dFaCHuOoptMXhqqqSx3ka00/igm95nq74gJA5LFX5BUDRbn29+Xum60Q/I9FvMqhjGlaT29vXXOTY2ZOKo/oumUkHxio3DQMkWdrWXR8tlKuGr/2Tqarbec0jz54ENG0CNl0L8hLiHwzeoidpdvuRna0apRQCLwaRMPPfMVm0tmQtFRR92SC4EcnYsSyPBu6ROj94lw9PlnxMrA2apT3ComTVKoyzIg/X+TsvIFMCJBHcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GFkOa5HakK7drq7p2FGfsbg7iLGu3NJG++0Z4gXeMw=;
 b=G2Hfj8Bn9WkbRL7srLrkG3JRnbz3EGd4ao0HTmzuvej4Hc05BB7ym5gef6ij3s1iE8SJ7/6zO+ORjqBPn9os7YxsujX2JKJaEsRdM85RA4mBWxdmFzXyWzAN+weWYq908DBRawLnoayb+ACArl38j/VyIsGKA4qBb+0jT6j7rQI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2144.namprd04.prod.outlook.com
 (2603:10b6:804:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:17:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 12:17:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Simplify setup_nodes_for_search
Thread-Topic: [PATCH] btrfs: Simplify setup_nodes_for_search
Thread-Index: AQHWuOVH0x+hCBSJcEejnbQiTuOL/Q==
Date:   Thu, 12 Nov 2020 12:17:25 +0000
Message-ID: <SN4PR0401MB359889E049FBB7C8D284EFF49BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201112111622.784178-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6a13e7f-eea8-449e-6f6c-08d88704eab3
x-ms-traffictypediagnostic: SN2PR04MB2144:
x-microsoft-antispam-prvs: <SN2PR04MB214411C44D6B14BA564FD7B79BE70@SN2PR04MB2144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Kr745Qgv3lJRcgdaLkossQBZcSDqe485nzRcmo0qnHIXj9ND5XX4RkkElm8bGubgE4yPhwI60y640aIswrm81iGM7U6AW5pzZf5q2rXrCMzk2NhezeyIGEcAwKnuwny9UwyXMRzbTZM+x59fFarTFTBtaeslJC+dTOYdRmsSRjW2L9bz9dY+GY8oQDPLxJSB6zveKXzBeCSSWLIE/unGErkVMEe8FnhNST1ATqcoJOoko3zMq8xe76i+xvjSNy48ZaK2IYUMXkb8Y2qaq5Wfz9T3x+3YPinXiGMrlxxTWD+BTYP6rDw5tK+MHtc1xyt1Nd7jeov4eKdx3AdgA2wDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(7696005)(71200400001)(6506007)(55016002)(316002)(8936002)(110136005)(86362001)(8676002)(91956017)(558084003)(186003)(5660300002)(4270600006)(478600001)(33656002)(66946007)(64756008)(76116006)(66446008)(2906002)(66476007)(66556008)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IvAnBGaVS99PlMyXvdFNrR8hT6uW5FmWppQwlEi/wudax/Cc9/CVrvz3HO8dLiEz9+AcNnvvRBgoR/xlPjtc6VhvL0/IYkISwJ+DERNOemxp4qH0tfHDIgoBnZvSeLV9crsxdzf6tMsq+7HXMN5SK2Ec2lrfcb43Ba1EbFGc6O4tdqbTPdRuEgBeftft4Qe8oL6mGjhz9vihDXqw5r0Dkqpd3Y9AifeFBu3+L3VMRAUS+OctIabxKdIMmjPKU/5ZBZnDB2/slhhN+BsdqCCDV99NXJvAudh+O0m/UdUUYn7VSjcyGQiz0Dvwdj91n3Y0cRtO/gDTzOhX5d/AnxniXAaj2T+4eypsxB4F0qXrgQi5UCVtDRG5IKtidDfoT2onhGNzLXF2SqAhiUoEfd3XZ8GcGMm+O6p0yY5E7A+vkpnmF9Xic9ajqs2AJDEJNELceMxKbh54PTHWjXRP7sE365xtsOv0MpnUFPrrIxvE2zq5bcbUwvdeRlGMVNuVecgXQBULMFh7x3O+qLha3C9dWa1PP8e0R/3+OycRWRK5aziqYCfvauH42W3YRdOiw5I+bRjidUkirU10hdxbOOFIHFfq5EGoG2we9UZQnpoWMjKObgNKMTcbvsiVLiwWHwIF0zrNVQfs9H5EwcDZre607H6OdT3XgwpZFUTFGCJ3g6iVBFBfYXsGWkLFx/65jeK7JdsiANV2Qu2XVv4pszKk6g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a13e7f-eea8-449e-6f6c-08d88704eab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 12:17:25.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFFxUqUSsvn6WPMnDfVIlXt3F254GA96KaQFdQCNVWXSGHHnCUzmBlyE3/HWDxdemxkNmD+/Wl2RmKw93wqjS9oYNGZa8bcQN+2VbWCm6d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2144
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Can't spot any errors,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
