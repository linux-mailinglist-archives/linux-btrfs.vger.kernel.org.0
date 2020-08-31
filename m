Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7525791A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaMVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:21:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44859 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaMVC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598876461; x=1630412461;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fHycyvE6GZkO1s27ccf12tHgSoAT0LsCH3NoADsly0DDzC/J5ZliByA1
   v/5YmkGLfR87JESZdCqPnALav3yUYein9D3XKA/8d63kALfqnu63YLBrQ
   kWKZPpFgAB01q1Z/jBRgggqitPYOVhA037/NslTjqMMXVIW0tGnWn2GSy
   tUYXjYPeC0FcksO4mD6anvZnEyp4aJYlJtL1v56ou1sMmLburMrdr6uAH
   +d0+xuyWTTLvvH6DZJ4OBS1p/dRb3vfe90oWEOKd3CHnjbnvAKmjGqzyz
   603ZcOe9bD7ybVuYFcEO9rXVnaCfSZELZ/6IhkdkRgHduYKPE3VYgcZKX
   g==;
IronPort-SDR: X9aQIYLZZj5maUt1xsX0Mmkp7jAPEzMWw6lYmN8k4makY0pt+52BZzK/PMzwUyn7Et7d3KoXk0
 eSxuliOv9Ntbz60SXstedPQzbZYjuVsTOXlvLUxwTPOvVijvlkgiULs9jp3iLGtwZ+jP16kWqz
 94y+Sxgiylgp+SmA0U+ZYmSfqCM6qGPS5qvhvn1V19oqcJ4ugPlgw5y3zVhtky9ZjQ56KRcnkN
 psrNkgPs+8zLH1p1ThjKBpEi57m6IR7u4vKxav0oxBFzRDdw50RtjxEj+IZ+01FGApzHH7J8yi
 nhs=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="255743037"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:21:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdIOhL+PBPlapOYRZuqxHMPsk7Q44nn93v//yNdp6tmKGYbEV2OS4Ke0fdZPZxcg7hNSouM4oQxbtkdAdAHLwqgnhqZg111ftTx0Ll0hHi2d8nfpYGno1T7rV7AkX+kjpdvnMF2ZIjtMu+/vKc2XbU5KqiQiFGCN7FPIRPymiC5REQMHaRiVuJHRJLyogkds4FZalvVRaNSlzeuvc7Adh/g0xA8328afD61m2u1b3Wwl65NtVE6OWcN8VDqJmPNz2Z3NeP+nZHO0H0z4xaCDcHfQuiiSOtH3bi41q/JztmjvPXr23nGV1yiQM/WF51x6EeBFgFSlyvLaQuCQSrcPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UeoNUb3blBVdDjVdBJKrKpeEHDKLbM8ETX8JpXcP2c5s+FWrxW+k6REsx3A5rziG1dOdud30Mmo9/6pyPa/r3/xEwxBKywlMA3K5VIRICSnfUHVF/Q/XaHQRoBH/7YSJJrM4wmBZn5AxGC5fpCR1YX1PH5rUuZmX7mmLYITR4x9kfaMLJJPvZtJ3V65tYQZP8mPvQxiHQNjKG2L0o8xc8a72zQr+Ebgb9O7XlBQzl/IDiZnK8HMmnmGN7BgO52RQm00+oXdx+91Kr2hnPHdTrM/3OgwVYrWtmvOMSRSuIrO/ywD+URV91B/x7dQj/2txZoBrZiw8SE//L9HZWuVAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Cw+xjUiO5GJdz7ynKuB+N8U/qUTqJJvBor+DRyMcjgnWm9gNRP4JXXY4pQFUp7dxKu6HZMn8qI7czKt5sGAAeA7Ljo2y3AfPzzTLxie2iFF/gvYb8DqDPIH8R0XvAeFoN7ePb9gesSNTcBRsrunPrZ5Cb5DzHFIIr4Nh47UFqhE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 31 Aug
 2020 12:21:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:21:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/12] btrfs: Convert btrfs_inode_sectorsize to take
 btrfs_inode
Thread-Topic: [PATCH 05/12] btrfs: Convert btrfs_inode_sectorsize to take
 btrfs_inode
Thread-Index: AQHWf417/WNvQKZg90eI6s4rsVS9zw==
Date:   Mon, 31 Aug 2020 12:20:59 +0000
Message-ID: <SN4PR0401MB359804FB0FB450D478B0078C9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-6-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6887d40-d203-4179-6073-08d84da8522c
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518FC597FA083E1DA7D1AD99B510@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXg17kZV2VKNdwZ7X5C7E/DJRExJbgCZ8j7NBLcx5OMjyDD5KWT3l3NRx+ql26qm2i4j4juPVYARz7nI8EjXluUDQ7W4J2Rbo9ZUx5uD6Ozx+Ggk4nqT2hJz40+OJX5Kg1LoY3AQfwbfs8kadiqHbSm7tEid0GyHHweftgpt6ectAH5uCNrgSOUYt4fCWEVFLLu1Ue85iUARPVIzAkNEiJuEsYGHy8dyViaMqFLxPomEql516eorqxb6hGFx2z0Ez6M7377ZRwmZkAqEHrNpwjG9rgrMhJ3p8hhQocHSxGq0WIXHFUrH9HikfqA7+Ou7DdSYvloPWNxKKZW4fBkkaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(5660300002)(316002)(33656002)(2906002)(55016002)(478600001)(110136005)(71200400001)(52536014)(6506007)(86362001)(19618925003)(7696005)(4270600006)(8676002)(66476007)(558084003)(186003)(8936002)(64756008)(66446008)(66946007)(9686003)(66556008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KvTEzGV+KUp0jDyrpIdnCMpqKitIS9XLnYVJCfARSs6BBapAZrmASy2R2b+Tq26looVU3XHKxzUVPCn+LonKSjwfQDR1+J1H68mNmdQnoVL2+yOW35M6baL+if7zHdfqdG3YpNj7xR2OeIXD6NbLd2R/WKjJ1A8I8M9zfptb/+8XFnAuGC3+ndFOakIXka8o0mOPjsBbjYqmOTJK5Wy4TXpba45PRhtKY6UFKhmYTGOXijv8xXvf0Z/+iTpbxecPSjDqIHOM9elhd7SRNS4CqrOR3vCjkj0kT5IeG2K5eflSjFhsVDKch3Win/DFbV/qjVie0CvqQtiI5m8s+K3y+QEeJLq+lweVBHenaqYzeNJPkvBjt4/coDJoSSTzZRcS7ACE6fOJlvOHYcyQ1kOEgMc81SW8P9otPtJmxA1Va4e6yW+RV8hRk9z+mgpDmCYdBaVF68O5zOkK+2OL+mXCKRSecA2ApWIPxIufjd7jW18XLcxNU2FiwTy4Cd+8iWErBKIhClHs+9OlZ+eIHd6GHJoCNT1N8zbshpQmgRcTQnFb7QYmqulyINiPtauT85Ty+hBWEMG7WNYS4t88kofGzjqjeh0UmNLwWnFmNy5yhH7BsxHW8dVsF7qYVyktnfY0P5hMMsqAB1JTAwqrgatv+6e+Tys9YSuz24gakejVmjloEazIc/XCdKoQeYUW3wmcW1mAqqbCY8jT9g1mdanuvA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6887d40-d203-4179-6073-08d84da8522c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:20:59.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 013G6+VBCpFg1mllFxc8B4cFHbMuSQeG1OTTTlN4VjxPZq0MHmhidXBdDclvVi3BQMLvyE0RNqELa3YBigoXJ6X6wNT+Dxrvj3D531vNOQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
