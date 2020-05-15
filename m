Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94941D49C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgEOJgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 05:36:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61810 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEOJgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 05:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589535411; x=1621071411;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lmtxRfdh60/DWkdUzkhoTJ/pEe3WQzc3YvYNNoqWf8I=;
  b=M7OT3KsD+vuXgB9h8+ewMul5aI9VaqoZz0jTOiepyD+dZYC/Yz6jUKXD
   fLu4DspzrVNI5H/mKDlTAfTclnYYWGnhlhUuw47MAb34/EYoLcK7kuogt
   PZowF4sWyixbGTIKECutieHTXUbMR+tXdD381y34QLAK7mW6zI4vpNGwl
   sTNhI2PKQEbauaZOJ9/XNlhjIX5P+tfRgRk6GhtIuSI+Ghv/4A+0gC3Fl
   6JutGL0EdFhleW7VQo/JPYOITU2CJ5ariafsb+BWvJnPRxIxn+Umh+9aN
   sybIDw5H+6g9oXBWToAhb6LoYXAN+y0ScMttuCygOOiGcC7dF7eE+hk+i
   Q==;
IronPort-SDR: JmhUZxUexb+kDP8QNLAvCaCTel6sZvt91vBGx4C+NlSYwB0xnGr6KDvapmV45q7inIzCMq7j7F
 BDaW/qnVtqMnHmowB1tievXgMVi4HIStNZOpzWM3aSpAVLk1PIBvUWfq4e1SRDAbeQV0IqVAQ2
 VkzyLak7dbaFIB/6HC8a/nps24LKvKdg8IjW3OQWyD5UNUA3E4uy9dj3l6V1s87u9J5MU8I6xa
 B+p6z9GtvrMkReLyrMfeHPhNVRcw//E5AWH/llXCtL4MjgCbA6U4xhxtsqfvNFXErCYulifuRE
 O10=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="137764729"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 17:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGSVgibCuWn1tWHe90A4agWW5Xi0CK/LvfN9jxi5W1maP/qNJM4XRcReaVvW7yxhXw6vma6v0420ANZfZwxscTgLltSieDzkyLaJVdiDdqSTgXXXNvRZPN/7MkWtL4ytZJzTw+RnUnw5mUapFOtCUqaID6GfSh0u5zDRhYId/bcf1pInl7LvTMXn+FZAN3hBMoRx/LfqShDFbAsksbK6gkXqNxIH/AxgD3fd9wxqB4J267cbiIgAGA9227fu+Um6nloqA6QEsQQ6luY5ievbN1Pq8XlP883SnbCx1qFVbO0EpuGVm0G0tpnLbspgxB7XNl2+PrE7Hs//WJa+bOSsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJnsuIEdqbMGZhhlK1/gZkAbrsLiezzH/5/ekdMz9pw=;
 b=gNNk47o3Nl7kZZJZs0uu47wU0V30M+8rT9RxDFvYATg56n+vO5iCgO/Ill+48gWuN4XWW6gj46AKkX1f5v/bcquQkrfsZL/ZCNBjECcszW/VyIlHW0CELcJu8ZLuHi3R2bIMjMZ0nODSjSi0Q1+QO64dGRM2djIIjz4WerOISAFFntPYkQHnUsvqON4g0xxEuTZM5WVYz7/t0SCLBtS27IPiWUJgBR1fISKGz5xGOJiQMQj2asBq1s4ereu6G2YkhQ+8oLi6Qr8Cyg1IjtFyfc/niOuqTZ+Il8PTzQa0cYoj0N5K72dz5v+YwdgrrSrzhDb0C1JdIgj4BME+QACUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJnsuIEdqbMGZhhlK1/gZkAbrsLiezzH/5/ekdMz9pw=;
 b=LJFHaAblqkNmpts+qpjPYZ3UiyKD5C+020Cwzm/gKCeH5TvTFFExizz+yMMIW0a7S5tB5KbAkjm3iR9vds4swhqHle/MD6hQJyGYxyEzP6k5DU+z8JlV/hSwp9Pf+5sZOpAFyRld9AgET5Z6JaRJ5gecYHkJSZWtnG3b6QqS+w0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 09:36:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 09:36:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bo YU <tsu.yubo@gmail.com>
CC:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "sterba@suse.com" <sterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
Thread-Topic: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
Thread-Index: AQHWKl8K6GclIOarbkSiVL0aew+onA==
Date:   Fri, 15 May 2020 09:36:49 +0000
Message-ID: <SN4PR0401MB35989B816CB1DA4BCB75B1FC9BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200515021731.cb5y557wsxf66fo3@debian.debian-2>
 <SN4PR0401MB35985CFC199D20362EBFD8E09BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAKq8=3KyewqQLdo-GjERuOfKe5ZrmQ+bRPfFRWiyZkjdEVvSeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddcb7ed0-637d-4043-5011-08d7f8b37e07
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB36950510245354CE94CCAA9D9BBD0@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nywyFGmPkf5NE1tj/SOskp2xDUXdrji9v9fOxQinoH9FCdfYWico+ZwFPHJKHnPK4N4o86KrnvM9mpsYeerjyR53hXTuiDhsVZHMagTFXdaPgvUYGBa+r4jZdPLNQubCke3Jsv7fOSn99E2fnzYuivHo1JeudAVE1gUa/jJXkGRasv1JQLlBfBJeiPv5CJ2y/95q0qo4nIlUUwwuxkWtYcoxW9EgIY51dy/3u1GxYH/69zG0FqgoAbvLXAcRyi6nWIIQCp6wQluf1P1Cr4fl/ZQGTINk27xJ+wKjkuM6lmBay/SdAhYQXSIv6cEUAOT4h/UchFi9XU2fdlqiAy2js5u1ru3anLLeJiScUcO+3kPDITH9IUEFFhUdNkurFxG6kxS0avGwGp0K4EYftlxQnXt+B+JztxrXUJHlAlAwtbEIpxOwLud3VlR6pUJoCee7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(55016002)(5660300002)(4326008)(66946007)(478600001)(66476007)(66556008)(33656002)(91956017)(64756008)(9686003)(66446008)(71200400001)(76116006)(53546011)(8676002)(7696005)(8936002)(2906002)(6506007)(316002)(52536014)(54906003)(26005)(86362001)(6916009)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IeDT+NULh6+7VUrnyOnYe4l55BMA7w+U1URZysTfEYgD3UNjU4FnnlW7fgJ1N++nBhy3lTPHP+B2pH3dB11TzbZDzwlvzL+I+8vQhE50lwumnqihkEsUxRuVRAIOcZgYzhk0HIHc44ZfOCR54cfYr3lJ1lFlz6aobhUM3fb0X2jLYnbpqnn3juLyjtN0xCZoRhzXDwF6irDWZhwFM6Oa7OBvapT8WvcbPe2Auntvhj58WX7wgrutyRlVC4KQpNvcbK3YAnB556aW5Z/3QWvPXuW2aOh7dWMyGPzgyQ/uhMuyUbRVPQODD4EHI8CyYD5/mK04Fv/s1oLlkBh2YVkfm/O61I+JzTq52A8spg+e0rJwHErFk5tyu2AIHYT2hU8LPI7ec6O24wy5l8lkgq2skMlosFbRECsLJli9ucJwfpjam0QZdaIe+cZstqvm+aD5JTHPr1iS7NaalyPnHzJS2resFfN6R3H6i0LjVyvpiYOMzwwkZ8X3DCNHL5MQqzYq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcb7ed0-637d-4043-5011-08d7f8b37e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 09:36:49.2597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pl98wqoCwqYWCsWJSi7Nwbm5/EWyCX1Ygew+eczcFmE2GGppL3lrm8F89CPdVogAtc+0Lmp01kdLiTFEzMvaCkUY4qPzSOnZhoubXikeo4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/05/2020 11:24, Bo YU wrote:=0A=
> Hi,=0A=
> On Fri, May 15, 2020 at 5:03 PM Johannes Thumshirn=0A=
> <Johannes.Thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> On 15/05/2020 04:17, Bo YU wrote:=0A=
>>> It adds spin_lock() in add_block_entry() but out path does not unlock=
=0A=
>>> it.=0A=
>>=0A=
>> Which call path doesn't unlock it? There is an out_unlock label with a=
=0A=
>> spin_unlock() right above your insert. So either coverity messed somethi=
ng=0A=
>> up or the call path that needs the unlock has to jump to out_unlock inst=
ead=0A=
>> of out.=0A=
> This is out label without unlocking it. It will be offered spin_lock=0A=
> in add_block_entry()=0A=
> for be. But here I was worried about that unlock it in if() whether it=0A=
> is right or not.=0A=
> =0A=
=0A=
No add_block_entry() returns with the ref_verify_lock held on success only:=
=0A=
static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,=
=0A=
                                           u64 bytenr, u64 len,            =
                                                                           =
                               =0A=
                                           u64 root_objectid)=0A=
{               =0A=
        struct block_entry *be =3D NULL, *exist;                           =
                                                                           =
                                 =0A=
        struct root_entry *re =3D NULL;                                    =
                                                                           =
                                 =0A=
                        =0A=
        re =3D kzalloc(sizeof(struct root_entry), GFP_KERNEL);             =
                                                                           =
                                 =0A=
        be =3D kzalloc(sizeof(struct block_entry), GFP_KERNEL);            =
                                                                           =
                                 =0A=
        if (!be || !re) {=0A=
                kfree(re);=0A=
                kfree(be);=0A=
                return ERR_PTR(-ENOMEM);                                   =
                                                                           =
                          =0A=
        }       =0A=
        be->bytenr =3D bytenr;=0A=
        be->len =3D len;  =0A=
                        =0A=
        re->root_objectid =3D root_objectid;=0A=
        re->num_refs =3D 0;=0A=
                        =0A=
        spin_lock(&fs_info->ref_verify_lock);                          =0A=
[...]=0A=
=0A=
=0A=
While the code caller checks for an error:=0A=
=0A=
if (action =3D=3D BTRFS_ADD_DELAYED_EXTENT) {=0A=
                /*=0A=
                 * For subvol_create we'll just pass in whatever the parent=
 root=0A=
                 * is and the new root objectid, so let's not treat the pas=
sed=0A=
                 * in root as if it really has a ref for this bytenr.=0A=
                 */=0A=
                be =3D add_block_entry(fs_info, bytenr, num_bytes, ref_root=
);=0A=
                if (IS_ERR(be)) {=0A=
                        kfree(ref);=0A=
                        kfree(ra);=0A=
                        ret =3D PTR_ERR(be);=0A=
                        goto out;=0A=
                }=0A=
=0A=
So if add_block_entry returns -ENOMEM it didn't take the lock and thus no u=
nlock=0A=
is needed.=0A=
=0A=
Or did I miss something?=0A=
