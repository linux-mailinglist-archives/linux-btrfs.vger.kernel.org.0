Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EB1ADDA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgDQM4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 08:56:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40510 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgDQM4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 08:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587128174; x=1618664174;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VfIV0do3qccpfNQ1D9PZZA6rAxFcDGgpIU90upR30fI=;
  b=eG9nb8MlM2fhDiOqb6Zr4rRPJbcA/DAEfyl9DbQ+BR056wdh/t7garWj
   VRalq8QlZriQDiyyKPMzASHXH6xrHv+fbjZ/C60Iwqm0dCh1G5g03n5ws
   Sruw9YLIcRgxK+LSTPEJOhJIvGPD11E92uBBo9h+/BM0qp7GrfpMceGt8
   2n1CcnuWI6nUzjud3PpZQor3lFHfOnJm0UdbaP7tF6F8Joi6f2mW4bVyL
   oISZZ9eyz5hac8W5ri/Cqj5SB0u/K4PhCkn2b36UOufuN/gS2Zx0pbZdb
   WetQj9QfbJRIJPfHYzi6o8ySauW69SUkALtDG/J7YjtLrKGCTgTr7K8oF
   Q==;
IronPort-SDR: Pq6R8U66R5dy4hZmHb/A0VCe+KPgrwElXcUIQiDHVxQ3Gi9EUrYsbcJSlUngNOV8QYR0zxwSzH
 tLX7WOIbZqQtiubU+6r/JK1wxutHFBi7cdlx+DoXgK6rGOn3t7H27N+VxVLHsSlnmNXImIsfH9
 gkgwQ+jOnzZrv4arcVEXBgX83vP9WEDcn2oWKAvNrOI2dxn6YNMdRPz7tlywpjQbx3h/P3Cf/e
 20g5YFWABo4pVj+CL4v8/uV4QdNGcq+Yxz7N0hWDCtOlFzl/nXjiy6jh8ZTL8zcGO+VTrvMeML
 Mb4=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="135564236"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:56:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeNAbp/nmi/0quBR66PuJ7Oht/lzsuydKqaqzk2Q/L6QjeWsFFAyuNelMjDVVB09QvG+OkdJQdMHv68TCPkmnh4bvME/lNi3+GyFp21lOlhw/QvFzaqO4EwhslWxPN3JoBY9r4WNsNLoR9T8xKxNybnTS9DTYTSgM03TSPYR+YsBQlvJhrkBm9GqUVzUw06LTTxZFESFVXnFcbKgezSJCA6wzNpMFTpAywu6v0Zy2MKTQc6z+OeOOaD1dgxH+SpYr21KoaPEaGtX0vBLiaPkkAUZ0IEYZM1Es/9ZXfsVXPCe/Hi+9+agquPvaBj9m5MokCkVU1nt3938LYHjO0SJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfIV0do3qccpfNQ1D9PZZA6rAxFcDGgpIU90upR30fI=;
 b=QNOgkl8mUUE3/VN2kHZTiI939rEnSwld5kGFm/pbKc/jh871KJZh4dPVMYtH5KxMgDh9UQ4KRpm2n/VYZ19lKLivO4fV9TdNe12eeqRjPI7d4m9ONg2+VkUFC9BpyB/pmMWs3Sz8L3n7oVt9eveJPDmz6mJDYEbLv+1OLxGdTWq+d3va/xnZ6UfvPHfDCPU3ldtkfd3VoEbHvPzkyYEhicTMpRXw7AJkqnO1Cu06nOQANj+02fg0YGuy7Jh2JEqSKxPr4H2Pn1j4j22irR8rzvw2PBAyau7RVd8qb4IlHQApMhYwSEMo1d9f6YaavrYwEBi+rh1YIdKVixG9OLZewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfIV0do3qccpfNQ1D9PZZA6rAxFcDGgpIU90upR30fI=;
 b=rJLjB6Cdr+StvOYc8Y7+MId6kgTXYAzPgy0QFSI6B15Y9XZfq0NgtPANIH3mgQfCevOn70lGOfl45K0oPW8WAwy5VyKXRAFupIqA95O4640PERnSwzkE6qH3KtwBvJ3RxtPvX/kbwY2oJaXWqB3jEs2UEjgvbHgdKqONd/U4oVg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3616.namprd04.prod.outlook.com
 (2603:10b6:803:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 12:56:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 12:56:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/15] block: add bio_for_each_bvec_all()
Thread-Topic: [PATCH v2 01/15] block: add bio_for_each_bvec_all()
Thread-Index: AQHWFDinymqxcH4R2EOKMxGa5Sqjiw==
Date:   Fri, 17 Apr 2020 12:56:11 +0000
Message-ID: <SN4PR0401MB35989EAC1050D4E151D417AB9BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <b00f5fb71cfa1655f0e5ccdda8a53dcab81a44fe.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ca51ebc-a436-4d90-13a2-08d7e2ceb45d
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB361685B1D476BE0D5A2167A99BD90@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(316002)(186003)(86362001)(110136005)(54906003)(81156014)(6506007)(8676002)(26005)(8936002)(7696005)(64756008)(66946007)(478600001)(91956017)(558084003)(5660300002)(52536014)(4326008)(4270600006)(2906002)(9686003)(71200400001)(55016002)(76116006)(66476007)(66556008)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fj1jH2b/2wIsDkVH+Vb1aaG0INus2ZmK4nVl42MJlcVqBvWcr5eGEBxTzh6jnwR0J+hKLFky6k7nJVwRgEyZmJZEn5UEsFOAGxObgdSiXxyoQt8z4HarSYwDfEHTQCZJvSxkmVQ6XuI73QRVXQsGSrZwdtXZBzpzBLuQnnuJ9ZZvYOuLuUfGZljo7BkHbyBrVw+b3JyjyHomxpMWUxMCs+0gGjWsYox5p8Mol3DBFJOTlA9JxeD0gdYNWrxpRy4g7GQf/iBeVIok8oiD5CusYbyRQvy4DMHlkMSPpvmhoMtbVYiRr5oTfCHntppvaj9G65t94eBblLNKnSGvi3wv2lxaFrDKqiI2ybzqygqbFL1bhH6Rb/8geVNpyuERi7vLE4pqZcr9CGd99DYhe41OzxW4TOv6YprY/Bibq/P1aYC7yLR0KLx694Cd71e/P9Cy
x-ms-exchange-antispam-messagedata: weHY6CwUGvsmwWaH6nmY1bolTwjNVCd5wn5XCdnfKjuySLZhpn6P/ppVZ04+9znMu+STo0n+WJpJdhYBwS9KG4RM/HvecHtAyKG8lzvE6TBj8ByHpQeK/3Dx0S52MxW3R05TtWGgdYfOSEVLhiWq5A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca51ebc-a436-4d90-13a2-08d7e2ceb45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 12:56:11.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvccTCmrh5hixtfKWSaki6NjJ5SBvS46ssUyatoPswtA629v+qj8xnDeZDAtlBqZTM1nIo5hDARID2c7Tn3I3ZMzsxneLbz8TG948IRuDsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good from my PoV=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
