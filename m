Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A31D127F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgEMMRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:17:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32091 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMMRr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589372267; x=1620908267;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/GE49W2me4n9Z7xdLy8he+w/L2Li/4XgFyszMt0zyTA=;
  b=oJ2FJlLtr2POkgG3I09su7YBcKvKcro9JHvphl8Yx14jUlIcSQMlNbSR
   xFGA14Hk/ws+OyGXLiY5w/N1UYGFyhHZRVpjL1DN5KBPEUUdrU8vtln47
   ejpPwAEcC3qZXE+NUKB+sAxh2RbR0XEksnpEV42KZYZq2DXG+jAgj8V+K
   6BZZn7KZwXI6HquWhskVFFGrHwSucCv8uhjwh70x20JCYoiGLtdQyAhMC
   VxdRQ2T7KXfDzafqo7qBLaXPAM3nfAQx30klUGLZ7OXm8VlDmZsQrkMEW
   6CsR4f1WdWmhpwS6jT9S74gTBXnNB0yiiCqXVqcEdxO9eIY2smpZFMWrm
   Q==;
IronPort-SDR: 17THAN/v74nZD0OAwYwM4a6tTdHQtiWT6/syhpyR4pa0dp06T8ZbqJL5mkIO5NfRsnOpdFbZml
 Vhxbn0vFhPiOKrOQ6ZnxzOwNYh0Vl+Ti75lGCK78nX3udXdxLzjTipUdFt5jowf7vkX5SJwr8p
 yIo5bcCyrz7cfeB4+GEwpwHwIErx68aUBKgl1bcpcHBNW4M1gy1TipmLYusutJ/+t5Cx+6lIbo
 IBJPaYtCH0NA3q9QU1BzcQEq2jCiBVuQbzmlo3f+ynlWg6V0r1/1yEEiTZ97ZMSHZzvQZXNeUK
 YH8=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="139009782"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 20:17:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgFshB+9ZfX1tcsSGzgVJpjhotLe02/WZueaFW/xI2LlAGTSqd0byl2XLL6/RWQJJ6ejgnAHZobe6g5Ta51XIrQ8uugFqZc9suqP7im3HSnkMr6AvW+o145ACDHR2VMmPCl8EWTIpID6Mz9QNcAp6uv+Wcof1/v4vyEYa7pAIqNIZWR9sYI8IZ6QE/2pbZ+KeeOPgszqkW0EU+zqzkyVeLm7bDg133WuuFb5KFZKbPqUIU57OCC8P8MK29HSPXjodE5dfUASDt0N1b8948Mqjv170w0ZlT9dNLxGsL8e6Bo1x+Y8s5JnekdH6pq0fnJBM67j1VQt43cYtuZGbVWQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjZf7WPB4qrmgzD22I5/pZZMKh+YrCEahcU8hKR68Q0=;
 b=gM4b/zoVRfwVOn+l0yRNdGDNa649D99eRitYb8zk7NwG2apdqLjmveCA+GItoathG0IPz9Dixk1duBm7EKTb382GNkzdmx/w00h5YMzqfPIa+kzvlQz7zh5JHDv91xnEKqJ86ADzEe5azOguCepQIXBM7ConOraU4nFMSyKHbGIMat3WGU7VoFZViMA4N6/THmAK0s6rks/UnPxI0R438RCRCWpi48rq3t+MEWKNJIPLLo0JIqMNhLbLLOCDNoud5HHdtdEmtOUjxYT7XjkFhD3PGkUAqKeHrtwejMA5ZMe9YSOmkmnaXKUmj9ehND4wBZVnha8LER4ieTQBs7kPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjZf7WPB4qrmgzD22I5/pZZMKh+YrCEahcU8hKR68Q0=;
 b=gBsvs05Q2mtuwQrLJLrswAyugTI4/rH6KhFx+JBbGfOhpXhvTReU1QaGbHr7ybiHCVlCGYbc1kz5hfszGSTx+q4yohtmnwCNxp0+AE/8j7We+jn4havSdh7zjoOVhVSgXBjGIbjc9fexpecZt4mo3bizpXrMOygnWbbqzAeAsKg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3661.namprd04.prod.outlook.com
 (2603:10b6:803:45::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 13 May
 2020 12:17:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 12:17:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Bug 5.7-rc: root leak, eb leak
Thread-Topic: Bug 5.7-rc: root leak, eb leak
Thread-Index: AQHWKGfW6Ky5qVZQwUmLt+jF5CrP/Q==
Date:   Wed, 13 May 2020 12:17:30 +0000
Message-ID: <SN4PR0401MB3598771FD08E9C59B695A1689BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
 <20200512230333.GH18421@twin.jikos.cz>
 <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <fa11e7ec-d785-455e-02f9-c45d607c0b52@gmx.com>
 <SN4PR0401MB3598875C33493DDC0D8BA60D9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <2dd7f27b-e505-aee5-2ffa-7e72f4623479@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd4d71d7-d16b-4c72-d441-08d7f7379bd6
x-ms-traffictypediagnostic: SN4PR0401MB3661:
x-microsoft-antispam-prvs: <SN4PR0401MB3661122226D1478528F7A5839BBF0@SN4PR0401MB3661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+xL6eWSHiXT5SznJLSjUWI7GTIArrcLEr2Vp7S8YVfX3fECYweysRIOIAFfxm+fTJaaI1Dongk7WCS7weZ1nGRQb22rBGtAj1ypRoyJErnJ1ODOlQcrgI78Nx1mjrda8QHWo5IHgw6wwnkLwSN3zzHUmP3J/idf575LlUbthqdLJP80NgoBwSMhmF1B48V58Ng3ZVYKlRW3v9bdN5s8KYRwS6cSeBI6loBqMqmKxpuOwEZXEsPmVpaj5QgWCoKRRpktN4uph+Ia0olRwUlhWsQPWVyQL1Jxul9ojW/MJSyBfhixSxSQMJ59A6je590CiYjAWiegkzCrR9K+b4QQumFpPf46JOtY38x5VO4eur9Y0qK1SDrNmueriu1vZJ7U5m5D58adZkKIY++lZvV3wkEHblPQm7hYiRnhaULheFrDUr1zk7DeQetQBJ3cHYVH/yPXj8rej9+h7bWQMrUMhrMU29jtXenuURwGlFgk15p3yXV3962gRTo5X5QF2WyYGMl3gLJh8MA2faghlD/ccw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(33430700001)(316002)(4326008)(2906002)(26005)(186003)(478600001)(8676002)(86362001)(110136005)(8936002)(33656002)(76116006)(52536014)(9686003)(53546011)(6506007)(55016002)(91956017)(71200400001)(7696005)(66556008)(5660300002)(33440700001)(66946007)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: F2Y+jwcB/HpTksugLXOYjfYSgP6US8AcYqlDHzjaQZWrb8mrSSleFwGesC5zQ3OkqkLPB1zsUGKKQKmzJmecdFN3bt0IAIsB3ozFKid6AdteJH2g/A/YKpZfxwgZApg1a/H1Ak41yyL7/8kbY4ZFjn96TfxZ7jB9MX73X4rVRKaNNPZdvo64WDscLqxTeJjnmmll8/r9f0NpPdmpYbEvpxp/C4tN1kT1+fw0XxcNyj1L30koc8LMyUfPXCYadmHrHkhQ97US4bQaF/+4TODeyG6rd5Ai4O/C1FviAtpMmIxaLaznDw+6HY8h8Q4S/oYzomfUqK7d+eLGwEQ6ylw9EHiX6paPtXY7ZosAALQdns9vJi2pBuTxe8QMzfsSHr7V9jYPRLoor6nrf7P9cca6A0kcMOtnUM4j3LKgzkO8MoEo3G916/LcfW4VmUGRF7jthsN5KrNpvWY361kv/4+Zbor0mCUinnsxCEmoGy2klmQqDV9G1wvikSP6h4E+hGq3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4d71d7-d16b-4c72-d441-08d7f7379bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 12:17:30.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlyaTNCNgX6uHLV7Xxq/09XBs9R7c7HGlNcL2ZCT+z2Ww03xQsAhikmzkp8nN2kRGwge8KN1uojsBRy/hrHcSXIjqJy1D/asDXUYLn1Gisk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3661
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2020 14:11, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/5/13 =1B$B2<8a=1B(B8:06, Johannes Thumshirn wrote:=0A=
>> On 13/05/2020 13:57, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 2020/5/13 =1B$B2<8a=1B(B7:54, Johannes Thumshirn wrote:=0A=
>>>> On 13/05/2020 01:04, David Sterba wrote:=0A=
>>>> [...]=0A=
>>>>>=0A=
>>>>> Johannes, do you have logs from the test?=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>> I recreated the logs for btrfs/028 (dmesg, kmemleak and fstests log). =
Please find them attached.=0A=
>>>>=0A=
>>>=0A=
>>> BTW, what's the line of open_ctree+0x137c/0x277a?=0A=
>>=0A=
>>=0A=
>> Here we go:=0A=
>> (gdb) l *(open_ctree+0x137c/0x277a)=0A=
>> 0x122acd is in open_ctree (fs/btrfs/disk-io.c:2826).=0A=
>> 2821            u64 generation;=0A=
>> 2822            u64 features;=0A=
>> 2823            u16 csum_type;=0A=
>> 2824            struct btrfs_key location;=0A=
>> 2825            struct btrfs_super_block *disk_super;=0A=
>> 2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
>> 2827            struct btrfs_root *tree_root;=0A=
>> 2828            struct btrfs_root *chunk_root;=0A=
>> 2829            int ret;=0A=
>> 2830            int err =3D -EINVAL;=0A=
>>=0A=
>> So its:=0A=
>> 2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
>>=0A=
> This doesn't make sense.=0A=
> =0A=
> That line doesn't even call read_tree_block() nor even any function call.=
=0A=
> =0A=
> This looks really strange.=0A=
=0A=
Indeed, it does. I have no clue what's going on here.=0A=
