Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697CB1D1241
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgEMMGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:06:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30994 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbgEMMGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589371570; x=1620907570;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hSFGAVVFbdCkbmTtHYPP23wQsxmg2teEi+bm0Obp/5I=;
  b=HV9TKvgGDcBq5snaBBde/+49El94CVd+rx0TyfaZ9g9/R2QDMILdGScI
   HA5YPXBZAuvRsNhSJa3SQAs3yfMUF62R3bR9VLPngJmxAAC21K5qxXM8C
   mfmpVKCrF+XGCHLZkiBP1cn53S/Ee9a5odxde4V25EPFGGLs30L6cv7on
   cOZshr4LdA9JiMh3jr99YHZTPsyFVB+Qv+ABg/Z5UnQkJHJMcHsBfgZ1Z
   E8dBfl9+FlLyIeJpu08SAuW4OHtldPy4AqDWecBx5Xpj10rXhyEDB340w
   9A/ZXXZaxatRAiVW7uEjCg8MQyTZkHkLhkWzefO3a8WDeQTSRoYBPvKAa
   A==;
IronPort-SDR: QkCSYM12JiQ73wqD/acS47o4jeWBZ4OpXIFHaIkx1lpGZGVwz7KzYKlsa4X3sPVQ5JIFWjYI6z
 zsMQpxvPcI8GNe1ZTf2tKveTRtqFqJdQ6XUJL3jxvU0jOJHxoQdUR7C8xtn+qZZyrAQF75EeHG
 0j1i4tQE063UeSNxtfv9LZ9U3k4qtqF8rLjVY9noGX8Zn2Ngphb7O6Jse0jJgKEPIzftVTAQEx
 Sj0sueAfGpFstjg+squ/dtlyYww+C38pP7zzyLWIg83G/jQfkSnFAl37We8/hM12JvN739zpHe
 CJ8=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="139009309"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 20:06:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzngUj7o/As58Nh9EYXS1LL7nlD52Px6t6CLRFdLvCVAcX71RNOIefeJd6yp7bXxLiIWMosefax+rX/IXeZbvnTHaXQ1ag/JVDgWUmpgv5j2R714uQgQnsBo0eKulwBcSO7k0rXn06tbmzkJfQvw/fAJuXEj8JdKAPEE6HSqmoN91aOrLTZse4cJGCpEguIMuc9Uz/irXcoLVI9KUxk8jWYi/2FUeQFXeIuUnqXAepbI/Q6D+HpwCH2seAt6hHO7mAMlnMincfuh+IRKOGbgujUS6GJQkvXWk0ZnYArZRNx3A0R7k8WctUkoTe0nIKfwV6LZJ/EsWVLzzaHCawL16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jID2J+82r/1567Gl7nmIB3pcvfC91qXuYe7Okcb4cs=;
 b=MMFS89SNHBHRCBN8Li2Y0k8Vq1RUQyFS1OyCXlNpKyFqf+8K/Eg87fCNmNi8i0jy+/L8UsOqUOiCL4eQI1YCTEkGL76jhpC1ygQUQdL2Iw1JK9hcDW3Gs43JbO3nW6ZWRthySV5iJahlmG+FJQaY1EheqTmi7/6YeH40kLXULWPFVJA9F2SLCWL1LUGvQq38dzejefgbCk4PIcVlg99mqJ/ubdpPmID3vxZMpZJw5OE22LEVYwUg0EAl9enTPLv8PNfqXqYpIHkeGlHYtzBSTls9ZUhU5UjuPEtRKubaBMbMNlG5FD9LVRikE/W6fbQ0dwtqcQmLd+Jlv77Q2jd/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jID2J+82r/1567Gl7nmIB3pcvfC91qXuYe7Okcb4cs=;
 b=OGMFu12tnbhYoeTzFiCyxBrGS2H8T934bnUmadvwfuvJO941bu3LXznOr3s1DOFUwfSFsh4smwqBo0RGf170ECA+WlbU3CxWTmmLQ88dBAnV3Fg/+QZdR49mCZRXM+Q9HEueuuBSCl3RhzQA/mGJU5XPeTv2aL9jqeFQij8aeJ4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 12:06:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 12:06:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Bug 5.7-rc: root leak, eb leak
Thread-Topic: Bug 5.7-rc: root leak, eb leak
Thread-Index: AQHWKGfW6Ky5qVZQwUmLt+jF5CrP/Q==
Date:   Wed, 13 May 2020 12:06:07 +0000
Message-ID: <SN4PR0401MB3598875C33493DDC0D8BA60D9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
 <20200512230333.GH18421@twin.jikos.cz>
 <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <fa11e7ec-d785-455e-02f9-c45d607c0b52@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b894d744-fecb-4c13-c94a-08d7f7360501
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-microsoft-antispam-prvs: <SN4PR0401MB3584E28200953B79EAFABF899BBF0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HaLT63qFh5mv55VCdnUErEiiE1iIJ1XPoV16qtvuFnixC4nA9jG/q1Ch9MSw5wugcguCE0+BsidI+uBwmMurzfeVVukQAOi6kH/0VKl+ozYPiP4dHjzXfoDHAbaRrm0tFfcISX14LgXP3759W1dNQY2UjrLe+ThaDwiLAWBscREm1f2OtcUVRK5wRPwDV47cJtsNo2yDUhXwqBDFNuET8q9IZfXdDnn5LCSp9Rx3c/PLfJkHY/qHRsZm+pX9YxyR0jbb1TU+ZPq0hG0VO12oxvAyNviyX2JFn/yDbN6U8U0P4qBkPlmc0EpykuirPqE9xaLDSRQz1KB3EJOZ3ibBkzLJqCcrxmvsl0S1TQmd2n2BAfe3/mzII/pdsmwsW6/mWFxqNej6E/Z+8CdRF+BTlBsKd45rPcglOsCg90s3YG6xhoau79wvg/rfgh525V/c78VbxJUjNTM6VQpt8bH55QJFozpjkaIUzo27xf5JMWZNYE1orJPKmIvIIZGXX3nUvfyDJCv4zL2uvXDLywHeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(33430700001)(66446008)(33656002)(55016002)(91956017)(316002)(9686003)(478600001)(86362001)(110136005)(33440700001)(2906002)(71200400001)(8936002)(7696005)(26005)(64756008)(4744005)(6506007)(52536014)(53546011)(66556008)(66946007)(186003)(5660300002)(4326008)(66476007)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZOPVl12nXQwEuoCTk9npxl40Gb4BdB8ZRFMLsVemmS/oPo40nmnKMSI/fi+lNokcSwA5s8inyw2vTZKvV4JuETJTj3X+WJtUGIzOpm0DiOXfZMPlUs1XA0iBHN+IWQTKZEYXSgqXSwCfO0CdkfYN8W+b0HoG8PbdPPn4+eoUYxU0+EjO/2a7XwrNCQlD0ceG6JDOqEuZ6Oux3N5oU1FahO52AZx3mdsOx1jA2WNnoNDNiEkBHEX4fQ6X0hLHywjbcjrG5jeP0HmKZTV7tXYnqUqJ2arcPrRgP0dGvovDonNfW99BbQXxHO4oX6o03MHF6+tJmkFNvXDFZAV/md7G4Gst17S+mSKGKPO38M4s9IgtdtiLy5Wp9ECUD2g46ORUFAuU5j1YIMhKgiZq9UvLkVodtTvMHi9k06pl9h1VJT7TQa6egsJmraU63+lCgZcBFRl9OXCKSoYPLPh60JxwSkjuw794vNIkAy63SkfvpQgRjiL9PNTtk24vSYTz+L2w
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b894d744-fecb-4c13-c94a-08d7f7360501
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 12:06:07.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtpquQTItFElOBzvpdsA/xpTShgjQ2k598HKxejNPyYLlFSGuUE2svfrTdEQqUHnZDUExKKUkMGT/ZpqEoASdqGIzO4CGkGXcqRC4M1uHY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2020 13:57, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/5/13 =1B$B2<8a=1B(B7:54, Johannes Thumshirn wrote:=0A=
>> On 13/05/2020 01:04, David Sterba wrote:=0A=
>> [...]=0A=
>>>=0A=
>>> Johannes, do you have logs from the test?=0A=
>>=0A=
>>=0A=
>>=0A=
>> I recreated the logs for btrfs/028 (dmesg, kmemleak and fstests log). Pl=
ease find them attached.=0A=
>>=0A=
> =0A=
> BTW, what's the line of open_ctree+0x137c/0x277a?=0A=
=0A=
=0A=
Here we go:=0A=
(gdb) l *(open_ctree+0x137c/0x277a)=0A=
0x122acd is in open_ctree (fs/btrfs/disk-io.c:2826).=0A=
2821            u64 generation;=0A=
2822            u64 features;=0A=
2823            u16 csum_type;=0A=
2824            struct btrfs_key location;=0A=
2825            struct btrfs_super_block *disk_super;=0A=
2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
2827            struct btrfs_root *tree_root;=0A=
2828            struct btrfs_root *chunk_root;=0A=
2829            int ret;=0A=
2830            int err =3D -EINVAL;=0A=
=0A=
So its:=0A=
2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
