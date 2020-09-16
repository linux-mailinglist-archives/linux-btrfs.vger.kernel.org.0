Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A526BFE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgIPIzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:55:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14938 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIPIy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600246501; x=1631782501;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GavLm9WMte2OzMPPuQGdfuMwRWOXg64ZfGMX/8R/qh6fYqb0s2raFjRA
   WE2R2HzD3BlDErSyvEGhseQrcDta+YtagAU0uD0YqaoggxJQSKDplE9zF
   7i5LfkLTZWM2XpRzBaUpoqFrUdW/X6wd79oykQKcSkeFtZypBXxsANTMY
   7+4bqpLzK9wqcn+6DyWnCodBTysgDTmq5S332r5vsnKD4qEW+saBeS4IG
   Y2Uk2U/RX7jnAl2+CeWGVT4V05Bk+icVQm+b3sOJC2jKyitsulSlzloBw
   PmmZYrht9FWo80H102aWQmwu1btlUTDOHSl52f9SmL/dcVBoVpET3X6Sh
   g==;
IronPort-SDR: C1h0hvy/lVFbkQCAc/tCZoe9y6mEt3GSncf3McQr2FE372hjPlQN3HRcvOPzEtaXHyd7TBPgf+
 td3R4xCbVAO6MT6itJnGbZkOiF6AFXoOXMA38eKtHoaWpPkgITRHPrCsB5q32rZ+mqhF6l7Dw7
 mTMPOXFRXiXYehPqk5DhB04bIPjNBL3F4SHskPrlm9YVbdyhXiOfno5BjIW8n1KT6qOLIhvCPQ
 67eP/TFVdcJ7A2LG6IymYsvm+vZwitgbejsNL5lcplBdMW4fJKliqw16nrH7NkrDv9zzYvCJ0X
 fWc=
X-IronPort-AV: E=Sophos;i="5.76,432,1592841600"; 
   d="scan'208";a="250838358"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 16:54:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWRvn/roQaZP9YxRTcL/ZPkrC74KwjzxoWyUfpSZmu721tQOoeqFmPw4pfWSKiMTKIy3nozNGcerawHo4NkpydSGHy8kHpmZ9vMETpoJK+kPSbPpx34nNrcTMHNybJUghVBorlSWVr2r9SCHNaJ209E1pLOywzFc1riI7vznzwDpyL1a6xPB+rMxgvwl/kF5zJ5qG8MngNbM/UD1PHboJJaF74E32+iII82hUYs8KHoqarqPAg+iW+7XLAhSXKViZ+dnwnWSctoG40hOR4NrcpPylWwmEmWrCqcDaljmmIaocsB2I9+v3fpmfWsBOjwOsFTnr7iSFfv1/4ZFo0Snzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b6B95PiibnyoXLEeSsm+1blHta/PX6xMriR5afzew34sdmNFF5Vk0j2ITnLPKJBRT102YvFBc8/2UnLiezRLDpHAHgYWsO9bnQFSLui+GA9mIJveFE6q6Dxqjh0MUCy29lxdoQUi5ZEnT5PAb62t6WU7ggga6VRXqxEqaGZoZ1zCyDtfiu8CW8e9rsXA+e2gJBZmgoMkUtXG5vqoBAZ3evvQxfFtbX+po/XIEsVh9/MmKbWx1jDCxmLMmWZZPc8NQzWZ4r6pIBR2uOb54P/2lpgrlc/qGuiEy4Udn+LoKLAYNiz3Lp9mjIaEUvWcGNUZjLFdHvUUAbCreh7+Ox3D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ltDjQGN4CTL1ty1geKCWANcYtT6dXJJrBAbFadbWrdr8frxJbj8HW18YsaDUPfydKyZPu/jH3iMC+X99IL6eP9qZohrfwrUIpzizCt4f37cuaFkdTXyRGWp/YXa1pfO5fJ4ZHEy/yx94ddfMUy8lqA9kp5FnXYEQ+HJkYQN+EWs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 08:54:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 08:54:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Move btrfs_lock_and_flush_ordered_range call in
 btrfs_do_readpage
Thread-Topic: [PATCH] btrfs: Move btrfs_lock_and_flush_ordered_range call in
 btrfs_do_readpage
Thread-Index: AQHWjAFawEFaaPs8dEaul5K1rEYa3g==
Date:   Wed, 16 Sep 2020 08:54:56 +0000
Message-ID: <SN4PR0401MB3598DDDC1775BC43743D09FC9B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200916081401.31668-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0da1caad-8fc4-4847-cf8e-08d85a1e2fd7
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-microsoft-antispam-prvs: <SN6PR04MB51190F8871E4646F5CF8692C9B210@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgQe95YOE1xHBFG6QGGjL5r2wNZOZpthqvefITWoBaQuYkeXUUdoi5q6hJmhbBVMswEXX7FeoPiGjH0jBqpHGl2q3vL7s4pwVdgOmqik2VqpZ/uZYknMGPjHhVVCNSH93pmdrOr0f/Vvt1D5kiNIl74nneR66RY6y4+Tbup4su2xfR0EAnjGboAb35Eg+k8iWLNyeWhVA6LFXq+gSGtu+elfD28nSDmGymq76z/f2On/ObpWDJSox/ulDNWLzCXd9FQP+25tZVW0QKkPpEfEzWqzSI0cnUak08wjYlpr0jFT8fV9akNeaRlGSgWvlCRaHlnMAk5G7Yw9LaYKenRa2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(6506007)(86362001)(8936002)(498600001)(76116006)(66946007)(64756008)(91956017)(19618925003)(66556008)(4270600006)(110136005)(66446008)(186003)(71200400001)(8676002)(2906002)(558084003)(9686003)(55016002)(5660300002)(33656002)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +VXktWS44xGKSyaXD8QEENWyiyzi7kRCzpO7FsHGoX/H6HctSDrMT1w7nW4O0Z/py+XJuLM8krvzagI+zbpTmmeEjmv9ORTxqs1WzTDOWr/uYJETxkk/NTbC1/YgkvdS1LZIzPEztjcNj6HGvU6s4d9P5oLsY2+jfR/tlGEeZNVWtElJJcBD6FTreqO60VleoaEhsHuhjIWohp1pHJYUVAwoNu9J8vnUEdiB7defCN1/Jdj0mYuxQ97h7BKooFEaWV95/pP4BT7xBeDz0ro+FN4lzgxNcFG+MojjojY6X4fR/qmdEvFm4MtbJRf/c/wp/Q0PVGr2v6X+McmeB0na4fET6w+JrqRaMhb08+eEUZPlBRV791KYQeyHEAwvCXqTHz3CRXNOr1LqeKGsB+87JndINacnprKLxcXjzUACAe2YWlWnjmlanIyBqccfTT5LqAVEK/OFilFX4XdJcH3//9w9LVXuc2DwUyXohalqaJeSfi4SdWibAN5JeTbJFF/znWaog7AxMzg+gey0P1hSzLBYUyBJRiDzsq0RfjZ+avnkMGDsWaYphpFNpvXOLNwKHax0Xn7meQxqm5riblsopYilprfhp6F/Ury1X5DxZx1CxxMC2ttzjYNvHE2YCdssJYOvKC1yK05CDCWFYEeAYpJXmI4+nXnbTNmVbK5eSsd9hvZ8ivzE4dLCjYTMn6hU/iHuzw8ITrFCuYB/Qv52Ag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da1caad-8fc4-4847-cf8e-08d85a1e2fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 08:54:56.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3xihOCBRRdZpuLaRyo3HfUnIWEzAeYlJPsHWea2WFgKHclj/5EKQNtqFDnonZjUi9p7DqouQCLE68JUWtTmVU3QsCDriQ04w0gIiy+mgyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
