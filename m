Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F72B024A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKLJyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 04:54:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64173 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 04:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605174855; x=1636710855;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5a2D8Han60ayKkJSn4IcpINDzfJ+N7mnAIpE3mr8z/I=;
  b=eaN5XtXi9/hCruqime9YgbcNy159RQlmZvqVcFSxfGpuvcuUdmkjpeb8
   SLrtk5GcRrDEflKkW2yHAIhDYwrZHfWTHUTvmFv6qTDm/lxU/vGdrOMCO
   tsKKm4TCpcVLnKNvPdMWkXyqdFrt1f9ouoH3CfRk0fexYNGsRx+GpSny9
   HlitoD8LIl04EjIv+3Cqhk9nWrbIgOSfxUmda5+442gnfn0nFiL+c+Mhk
   5/A1w4qHGl4aS3bo2Jf30Rnn9Oy9JT9pfj2aWJZGxcEdxAlB7qTUGgsWA
   NiviRRC8+20suXnqyxrwEAFsBqotNMa+Y0RNVSr9vfEMyNYZLmMTNKXz/
   Q==;
IronPort-SDR: E5/ZwdnmI2ql1S7mDjjpVw7WD8FScnwG7qXuiOVxd+uTSd476HtvWM3BerQMA0Vbi6ZLkjbPwq
 hs1xfIeOi+fB+/jlgwBYamWRQZ+zeeLpd57kRrWWzB6xR72xKacayFx+3LR9q3J2kpNdrHRmFK
 ERrf3ptdi1MU/aW8a040kcd3/uMuFnjIECXHZUJ1tszQB0Q3g9UX4VXQWsReANMEuZtOh1Fj9s
 QI3aktTnrsgRRS1MteOxmWbF2TaKAK4klGLiDkz9SjSHkdSHss7F+m+FayyHJfjFkHVkc6I4+9
 EPs=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="156954640"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 17:54:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2XRlx9H88FMUE2xpc8t4csKlPOd+7vCoRQSG84R+/vt4VSSymhK7ggxXtGO1PYibEmQ17UZdeUcRb0qdW42gqdRisb6+laSW6IYxG0qyWh4Lx8kvocGAhVB/X3uOlR5p4wI9X52dikdD9a2PUjo0nVD0VAkVwTRSf7E9zkBsnuxDiGlJ0RqJ+hPdrP1iE2jSnBPokphU5j0nWwRNlDuKRYdBfd16Herduj1umIScZoeKjZGUNWSkpmH4j/VQYSDx7vMu3/wG4EsNuZcPL63K0dqelkWeVxe51Bd4EtoTWo29K7p3Gpz/XOzKtt7v+FkxGG4wfqUu4LcQmeeCZDGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylN96lWwgGmakBwY3khid7DXLp6MD56tAGeSxoHTk2Y=;
 b=PXFevMmr/Fsq8gOgKt13gK2JeSqdcjn0RRd8tbM6e8FxoVxZDtRcZxyDRDmFUeHTWifBXQNLaiKy8vAIXyto/vSOnOS2ByZerhlQK7BiuwxtCOGUxOQncndxOrFlBPlwShGwVE6PT2oInbCW3CeRdIfntsyWX2DYj1Cdt1Tglg6K0ZO6IM4xm2qsdCIGmKni0foxXJuIsXW14gHxd4H99n+okEA+kQJ1UpT86J5X3r80o9mJLItpzEJKa1/3JTb2Sq5QLY4RynZBw9maVKKauLrkhh4mkuj4pljHLxghUYU5o2ZZ560VccvlaXOBfTHbLj5Z4UyCpgDYrA7NDLnEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylN96lWwgGmakBwY3khid7DXLp6MD56tAGeSxoHTk2Y=;
 b=hzJJegJ/yRdw8YZxoAlbmVsoTm2AHifDvBUHEqqeLHXxnU+XJw4KyGeWDq1atw7FZsJW0ruXl34u3zHfv70I379wCn9K1sadLQZgY4jqkGpI9Et6m6LCzVp0gnKh2agojTGZ2V05sg3a3upAHMlnK34uCYd5e8dPZ6DkPS/4eA4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 12 Nov
 2020 09:54:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:54:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Topic: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
Thread-Index: AQHWuEK2+yAEqm4DMEeMh9rJtDxbRA==
Date:   Thu, 12 Nov 2020 09:54:11 +0000
Message-ID: <SN4PR0401MB35988CCA4F7CB9E929D22FD19BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
 <29aebf1e-4684-4003-44b4-c5e8846b69eb@oracle.com>
 <SN4PR0401MB359852C46EE68127C7959CD29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d389866a-4d25-6d8a-aaa8-3403bc7b7c0c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 285db33f-dcd0-4cd1-1a94-08d886f0e7e5
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-microsoft-antispam-prvs: <SN6PR04MB38857CE3BFC7A1077952E9D29BE70@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWBB2dt3OYdghCx503j+mlVYWyaLlH8xEThCbqgLnDwVOgXgr4KS/TOK8qbpcUxLCILrFSpvw9kFVhWid+IQ7gHUZ2lmyH5aFR7iJoQ9RufxzOGgToe9/pC8aQ14JYoAtiXVnFsdRQxIprswkhZGVCIVE9aTCfWiS0Splma7brbW5fZLLdBZv90ygNLt1/MA5OUJbKMX9F1A2mzJQeSLB1EOq8OV2vwoT0n1Q49pHbY7HZKum1+wlGnzCnDOdqGzIwXTcV80UvzAStMi3cHn2SpAZUyNy1b1M3960rUtX7OmHcIPfvNIzabvzMokxo61gL1uqhHn4l96QsxMANfeJANNcZYrNUlV0wYj125nwBQm7VhsXG7REorbpi+5XPIXpIG+cB1/qKs/sG9WIaCP6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(8936002)(66946007)(55016002)(478600001)(71200400001)(2906002)(53546011)(6506007)(91956017)(33656002)(83380400001)(966005)(52536014)(76116006)(64756008)(186003)(9686003)(7696005)(5660300002)(316002)(110136005)(66556008)(8676002)(4326008)(86362001)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +JPFtILixOPpwk6ZQDTWFky1Awi8AtNHU94BBVOFI+jrTwDTqo5H7/RigGTHwGAusHZyCeDnSjJnotjjnc3+g2xvwrzNv4Tu4QgcG+MoB9kNzJHqQipk0p9wHzI7+2MIWofMCo8oYU1CxhykqAfT+Jh7zDsQ3eUyMC/dOdDV1gSM6o5BJaUFC7HGgr6irFXGJXimPqO1G4fUO+pUpjW3Y9LuF3ipGLNnOBd03An8YJPfI5BLKQqVvpMbT8iauEUa8VMA7Vf50rQLv8Nn8JfoqJ+1bXv/BKRAmT93nucpUEML1qatlUGEDeCTQImLp2cpuTDmCDNw+Sq9kC3b3oeppWOi6aTMIX4BTsSsimQlddmIJNICGh3Ntx7enFkFjMmCJaOvSU1TZu16BWbvcoBfKAZaGGiYCsG9nWJi1JtVWRuKRY1zo8LqgI8sfBlYdZ5n2V+HaGHirua91gv02RULe/0jOCVmpUmqFHB/T7cZutateB8WY/uLSG/GYpzVT9VqFax7vKXXsoFy1kxcHZt8zG8Kdeg/vWxsU363o5QOpF3zNHbKNUq+T7+t1QCEDpAg4JYy829roY7vPQQzC16G4972tx8sde2SNw4oVOuXHg6nUWyqnuq2Wwvh1CORK/KpmdIBxLhtHlySPgk9wMdbCJ9WX7WhoCDnsAl2YDbLv/YbXf8eMp9LMc7bCo7lL7p0z3KfeC5uTj6URBD7dscb9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285db33f-dcd0-4cd1-1a94-08d886f0e7e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 09:54:11.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVsnadkUVd1T+dOF/HJlgDiAyhp+fApvWUGLvOUSchwIwLcM+2RNsdnKbLtfwHH3HR3tH1OkGmAG9vdKCF2h1ZmzEiw9b0iqnnuLK6Qn4l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2020 10:40, Anand Jain wrote:=0A=
> =0A=
> =0A=
> On 12/11/20 3:24 pm, Johannes Thumshirn wrote:=0A=
>> On 12/11/2020 04:09, Anand Jain wrote:=0A=
>>> On 11/11/20 11:52 pm, Johannes Thumshirn wrote:=0A=
>>>> A struct btrfs_device's lifetime in device_list_add() is protected by =
the=0A=
>>>> device_list_mutex. So don't drop the device_list_mutex when printing a=
=0A=
>>>> duplicate device warning in device_list_add.=0A=
>>>>=0A=
>>>=0A=
>>> The only other thread which can free the %device is the userland=0A=
>>> initiated forget command. But both this (scan) and the forget threads=
=0A=
>>> are under %uuid_mutex. So %device is protected from freeing.=0A=
>>>=0A=
>>> Did we see any bug reproduced due to this?=0A=
>>>=0A=
>>> Thanks.=0A=
>>>=0A=
>>=0A=
>> Yes and no, I've stumbled across this while trying to fix this syzbot=0A=
> =0A=
> =0A=
>> report: https://github.com/btrfs/fstests/issues/29=0A=
> =0A=
> =0A=
> Fix in the ML [1] can fix the above issue grossly.=0A=
> =0A=
> [1]=0A=
>  =0A=
> https://lore.kernel.org/linux-btrfs/20200114060920.4527-2-anand.jain@orac=
le.com/T/=0A=
> =0A=
>   There is a scenario where the device->fs_info shall be NULL.=0A=
> =0A=
>   Consider Thread-A writes device->bdev at 1w and device->fs_info at 2w.=
=0A=
>   Thread-B reads device->bdev and device->fs_info at 3r, 4r, and 5r.=0A=
> =0A=
>   There is a possible rw order as below when the uuid mutex is released.=
=0A=
> =0A=
>     1w, 3r, 4r, 5r, 2w=0A=
> =0A=
>   And this shall lead to the scenario device->bdev !=3D NULL and=0A=
>   device->fs_info =3D=3D NULL for the thread-B leading to the Warning.=0A=
=0A=
device->fs_info is not necessarily NULL here unfortunately.=0A=
=0A=
Why aren't we simply doing this instead of the NO_FS_INFO dance:=0A=
=0A=
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
index bb1aa96e1233..4327c089183a 100644=0A=
--- a/fs/btrfs/volumes.c=0A=
+++ b/fs/btrfs/volumes.c=0A=
@@ -940,16 +940,16 @@ static noinline struct btrfs_device *device_list_add(=
const char *path,=0A=
                        if (device->bdev !=3D path_bdev) {=0A=
                                bdput(path_bdev);=0A=
                                mutex_unlock(&fs_devices->device_list_mutex=
);=0A=
-                               btrfs_warn_in_rcu(device->fs_info,=0A=
-       "duplicate device %s devid %llu generation %llu scanned by %s (%d)"=
,=0A=
+                               pr_info(=0A=
+       "BTRFS: duplicate device %s devid %llu generation %llu scanned by %=
s (%d)",=0A=
                                                  path, devid, found_transi=
d,=0A=
                                                  current->comm,=0A=
                                                  task_pid_nr(current));=0A=
                                return ERR_PTR(-EEXIST);=0A=
                        }=0A=
                        bdput(path_bdev);=0A=
-                       btrfs_info_in_rcu(device->fs_info,=0A=
-       "devid %llu device path %s changed to %s scanned by %s (%d)",=0A=
+                       pr_info(=0A=
+       "BTRFS: devid %llu device path %s changed to %s scanned by %s (%d)"=
,=0A=
                                          devid, rcu_str_deref(device->name=
),=0A=
                                          path, current->comm,=0A=
                                          task_pid_nr(current));=0A=
