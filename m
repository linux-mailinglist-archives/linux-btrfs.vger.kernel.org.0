Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1B1CB153
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEHOFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:05:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6501 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHOE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588946698; x=1620482698;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hfuYpFg3ivdaQWpfvpBXnTni2jx/VoQi5NpV49p8Ja8=;
  b=R445osWYXOnb33zh/WIbHx467pWvlL0v7c5AGPC7uuYuIgvV59rwN9si
   c+aD63ICZxOpULxRgrLjES5pJXO9eZFecacW6BmlXcQOgcyTI/Dr3LOW/
   B49GjN7lLEQiv+K39cu8kD3/ak6S3aEkyyFauD0IRAvJn1TiJboLzlxJr
   IJc/WtfbXrSCiJItIDuSdkNCUDcJZLhVx3OU/7NzT1nnQ9pyBL8nQUZb8
   idwuXqmTi1JqUTPHHY5Gn27U1tg/7EeGaBP96wK6D+8zvquxuc2l63T2b
   RluK1TB048QDlDA3dSYUPZn8vV8pfT5JeCpJJv8rNrflFgwNDTIpMkut9
   Q==;
IronPort-SDR: JnwCO2nbnVKj+d9OFq7pQUFpkLrrP6Vp0E2Yco51E6qDRiEdwqME57wZXnly2o7IBxifo4Mufm
 onixYb5LbueQ8iom6RO/I82rUV97pSJeBKdckNvgx3WhKrGKT5ujanZmqMkwQH9wR1hmaV+ys+
 9mAC+aOtxd6gjH9LabETxqBvyue5Aq4mXuQg9JSTmdZCOWWr/cjGe7iEKtwp83mAQlI2dBnyJE
 hriitxsh8lQrSA25WtrItO1mL/Sh0kfzpSUr4Jmbo0svi0Wu670DfXCNrRSysqmRWj6QNpyVCJ
 giI=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="246118785"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:04:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXhHWKZ0s9S7nqqYs/RwnluhwQbPwv4IraThWbNexphqMWPyN1Pni5E5YohdrT2MCZlSOROC268K4rrmoSyszqP0wwaB9QlZIb1yOSq+v8IhnNT80GX46H7FAJK6FcOBfX/I5vt497DyWRWlYSbDRYU3fZmPZFnFz6OZ4sS9bvGQjR9+YMnReVxwLo54yNkZqwlyG8yJ37VsioO/m71hw8jUWO3BbvO4gW9ybFvK4rkgAn/VTO5V3vEHncfBjFwa/6vjJorqMPErRRaPBhdQMi13QCWRb+79rqZJeLbVWBTi5iehQeThKnjnhJ4If+UKlmew4JVX5mNS+XK4lkuJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfuYpFg3ivdaQWpfvpBXnTni2jx/VoQi5NpV49p8Ja8=;
 b=DiJnpIRi/WuFuZAp9E9NiDpjgZX94D71HdmUOdsU1qcSCbfCy3wsRr1oC3ShI6vm3t1Rp+1xjPoKyJv0lMWBJvO7RTNAT5rwdl724Z2kO5qubfXzDd6UviMyhf9rsFWXwQINP4tQzNYFyLNebi/T5WvXpepdpzKiBMzmqOfnzXVDjMj4NFudYIBCbRuGRRPIFpnnjJaIUxbb+NMdS4wFk6OD8UqaNSBu76fxeOF4e5tVRg5aLa6bKZnNXsyIsPeozcKRxBSctPdwXu9S7Hcf2kPguM17pnozKJNUF88ctMbMy50/wjHP+3M736/RoiDHS4+r7YphmHDF2S3J0hMRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfuYpFg3ivdaQWpfvpBXnTni2jx/VoQi5NpV49p8Ja8=;
 b=E7TEt5/um58LTX78xeROBYSH7cUVTPpitC1k5/LX9Tw4UzqGgK+x0LCl+33mN8xyswBE5Ke6+CWLDVNyle6IWYICYMyD4Zq+xJBZnZfglrE5FTso2oca/YPYdyjn43MEMdPpuRvAHcnxdqgBnF0EIJKjvs2PaTTNjO3WduvaL6k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Fri, 8 May
 2020 14:04:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:04:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/19] btrfs: speed up and simplify generic_bin_search
Thread-Topic: [PATCH 11/19] btrfs: speed up and simplify generic_bin_search
Thread-Index: AQHWJK0B7P56kLDcf0yTg9e2/onlUg==
Date:   Fri, 8 May 2020 14:04:55 +0000
Message-ID: <SN4PR0401MB3598CCF348579A2069DE45769BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <32ed422c5c1fa2830c58a472222d3d09c49b7f60.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff6e119d-ce5d-420b-f709-08d7f358c94b
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-microsoft-antispam-prvs: <SN4PR0401MB3584AF39E1F4F712444E29D19BA20@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsXG66E/5KnQIlSlVJIl44Zx2NNZ/McAZOcvPDZdX8+Edt4d7g11iM6RpA8hb3ZQU3/5nAgvkcOKhabEFQNmm+tSOEuaC3KKzXPjWM9Isi6X+0D8O6BGkLvX22ltCaFO6oLWdekBEOYuUg50sYuhn/6cYLdI+hk+W7Hdis6UNEKkEKY/MX9FrhIsfHtLD/+TzZZXZVigravpmAAqFmH8JXGfMqg2905TChuYLmF6zY5vkeiD1Rl6hdCfeli8Uq4r3kJMwyIkKQjFwSWquplaWfZVDN/UE30s/919tsnGCANmhHzAd0vlSkfdktdcIi4hRZ6yjCoFfi+tIgZbcnLLNtFAMD4dkvKpV4Ow9yhXpT2cHGfHrXsT8iDXTC8BaRxAm4ZqaE1G7s1e6OVqvzLdAhtlKScHaWD+QMaKqfk+pH50cBkwLylpwzUaUGWA8EnHmgjkjKEZYhG/Wqvrmg0k/jZV3klu5hxFK2hvzlXfpl4C5OaHbONFFhw8Y75xWRZ+FKfNX4TyYVytzmGdKLOTbX0guqVDaOiSQagwzjSiemp9sXusL3xPGYkz8Mn3iPWh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(33430700001)(8676002)(8936002)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(52536014)(33656002)(33440700001)(83280400001)(478600001)(83320400001)(558084003)(83290400001)(83300400001)(83310400001)(7696005)(26005)(186003)(6506007)(9686003)(316002)(55016002)(110136005)(2906002)(86362001)(5660300002)(71200400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mRpYxu1ICKpx6cnB+dGLNjYz5RucSXyVSFGgpRZqq7V59zf7AyV3LfcoV2J0kP870yYIWw+QFTOumq1suyeejzyeSA8Eg6xsC0yqieAMad4zlDXnJp5+aGigizo5CXnUAjz96VGmG/+DAkjjhK8goMxEIcGemOt9kHH4VphpvOtK3nUcrhss5duzQVT2eTJZ8Wfh8tbK5zjOlCJ60dLMk03kUvWXopc1YlwQZ7+SBh4HUsphrxiCHNuB69JWtUXpgIShpuy7ap+ta0l+m2NDX7igcxDyV2XeS2g3dwI9065EXhsYPQE4v/neXqxoGJVMbg1ZrKE7P8gicnTqxok5GBSOQ0W+u1LPBWDzV8UvZ5oMzpE/uVE2S1UBdHrNdKmjx5z1CnFpHSTofqyb8aGoHzQXY0wvxl3AG/WZwYgNXEN546XcgKseKXnNL9qGiLZ1tbC2QJe3JFQkT8k6s54makVaF6NXcUTAYU8RwLkzfUknpPV3lE/Rm91SvdO8wTTN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6e119d-ce5d-420b-f709-08d7f358c94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:04:55.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Z+lTRWpKIDtimNExZFIKXUa6EVJDbhGBYocpLKebWd7LqyoF9dC1muOl0dKRT+o4/vp9Ky4kAq+bzBeUeS6zphgPqfWpD/cqiEJfQoCbqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nice simplification,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
but one unrelated question, generic_bin_search() sounds so, well =0A=
generic. Maybe we should rename it to __btrfs_bin_search(), given it's =0A=
only called by btrfs_bin_search().=0A=
