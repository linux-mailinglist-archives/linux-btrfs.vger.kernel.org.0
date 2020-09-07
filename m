Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72F25F974
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgIGLbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 07:31:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3233 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgIGLaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 07:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599478221; x=1631014221;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dznkHGchDDfa9tbF6CsKfoj8vtnbowu0NTTMlY/meZo=;
  b=hmaeadrQ1GNCqBfababVKCuB782bVavV7Y44BnBTbTpQk6v0+Jq/sugQ
   DYHXOIstD/sg8uHSNdhvAFE0rDYf8dmS7L1CZQBB5DKf7XqJmWOrGFLTr
   nRELvDVQdrt/c6bcL6kaKNEp7YQbmjc/9TOPMV+xkuJaamXar7DCeY9vj
   wmeS0/JdT3Z2lpg+T0hObOk+mRliJqgqPct3lYsSgdA6I+jIWIjhkpkUS
   gSbnNZdOhu3ZBGxAv/FmdaqkSMejLhP0VWp6U9znLSnGJi9HcFhrfnnT4
   S+Hv9svKBgQYtbhVMCb4VYC+481HtPX6XHji//0SViwJ6H45wuO7wClN6
   w==;
IronPort-SDR: urTK7p7aieBLiAABetcxY4GTPWfiAQv9gCdGK0hOvtT4J0mjLzfw/IVauYHz0B9MRABDRUAO3z
 1YycjsJSjtQAI2D3bM8JzRaPmiCyoQLPbTCCL5s176IkkL2ZlXOazvclBHpgl5U69lx1TyKv44
 qU1rm2jBpLKuWDNLwUrTasEEIGCpgDKEgj7DQdEvmUbBW5F95mtMiVCPYaimylReke+OfApyF4
 ia4/WOcj06gIyIf8ZfDyKSQflrU+aJRkwxFZ0w2sZHEDnbul3Z6YOj52tDN+1vCF4EzRzTSoov
 mc4=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="151089559"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 19:30:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlOmjC7c/9fdcAGltA54WI/ict986yJervl+AAepIKYS88S38n3CO7p7JGo5H2q8J65u4Wtg7baIQf+LKFuQpSagxnz4amxtjk6CvKab2Sl/HV2+7XdiJKQNLGFWOLoDrGhzh6d61LGEF/SnDKWLi6+UMak4W4N2xsstvZuXQ1JveCfsHaEdn+o28Hv+jo9Vncx2q52Glta5v5tJRPoixpFnnljwB1OHFZnatxxoPxnRO2Fg+vUpYsMWVXnQvueHJCv5wz7eAlZDrK0a+59BwmEG/TBJ68OTHTZuzEJyx8HyP2mqruKIQKlCAM6sC7xssVVnkPSEzuuq7xwLqfd9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8OKj6rSoiCJagYyJgdzMG8OoDPeK671bpQ6xetFYo=;
 b=nKVOOXtcscoaIeJoyc6mOT4XrGvKX2TM1yTvSpVT0+iz47ytaUY5mCeSlAtBfFsfFY8SxCPjn/+PG5KNAu1kOJg2SmOk7axuSbCUrW4PmT3y/nU36Dh+MAzE0SnVUBcmFoaU1EVlOQfE7ESsM2Mw3y8eJD3MlmTUjHr26Klk0wDyNzza336GFkHEUg6RrjhWoWJrILdntMbFwIHPYoGwlilHH3huSYIBWPlbuh6tWCBXZZCpuJxHCOfMNLvt12zZj1EPrr1G6DM6RIBX0hoNBbo5+eTxDcMjKno+gmOHJvIFPkJrxsO+UExRAs64Olz1u3E8OE5RA4XGNYWoABr3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8OKj6rSoiCJagYyJgdzMG8OoDPeK671bpQ6xetFYo=;
 b=YmVqNDfj/arHSyl9x8h7NNa+Kje3l0l2AlJq+7bxrvPM/Hm6akinMjwkzMLJIk4DEtcnmNPbmCRsuhFWTfKj8gkXytSzM3917roJKY0HU/Hz68kj5cngoeguJigBD4bSDG/BBGqX/aTzq9vMVvfVoXHXMWokGc0WmJtLi7uQThU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3888.namprd04.prod.outlook.com
 (2603:10b6:805:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 11:30:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:30:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Topic: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Index: AQHWguIIkDqfUfIXSUOxSTuVxfYe9g==
Date:   Mon, 7 Sep 2020 11:30:06 +0000
Message-ID: <SN4PR0401MB3598B2EC32C25D601E59BF879B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
 <SN4PR0401MB35988315D6DF0068151AE2359B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96b4c31b-6347-4e25-e487-08d853215ef5
x-ms-traffictypediagnostic: SN6PR04MB3888:
x-microsoft-antispam-prvs: <SN6PR04MB38883053DA84EA23B7DA95729B280@SN6PR04MB3888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4h4chDTTUmMA2+t6q07AmlOOqBahPRdIsa0VN7gH8alYANVkt3d3fmmng0JizEiEFCW/tRNwgF5i75+76Jpx8RWq6XqEEQeeoW4QUpHW1Arn9XzNqxf2KMShaiDtAin4Eg2MM+p31c/sV82rRiHCDON7thoNi3RC3xD+ueUe8vDUIb/UsGgb9r29NsUjKam+WTYXXr6BWKwn2I/oLpJVG+IQuiKWFgiqR7LQskBf2kmUchBv3vXeOGZukUbY9KilhYHjw6Ni3hrCA+pKksNMf6CZE4lqf/EvP0nrPJuiVNSNx2QGwsfMAkEfTQ19OXYApkDBxJ+28lowLyoenStkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66946007)(83380400001)(66446008)(66476007)(66556008)(186003)(76116006)(316002)(91956017)(478600001)(8676002)(71200400001)(86362001)(5660300002)(8936002)(52536014)(64756008)(53546011)(6506007)(33656002)(110136005)(7696005)(26005)(55016002)(4326008)(9686003)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XXha0RQY+zWWeDLEPNyGCzPPwWqqvIuVGaw2qu9tIkVonvVFz3AYFf+81woLJOWcvJOgQ1+HZwiUNCUMmHCG7WLxw8mYPklcY0ShU/naqVfvGAyDqD/WLmeBCWTo2JbbDKsaZin1qWcd3MQaBw533lPPeP1dZbqPB4ojHpTxumEbNbi3AfrlTkoxeHzKtPwi1xFMIpYmS7CVVKjMidyyFn6dsSMxKPNRX6x7i5NN6e5gB1tzHBe39zRltHzAz70Q+S8MldschmCYgXXENDZicqZ4fD+xfj1PTl1jhWIkedIYrKFzlcuPehnt+u1cjm/TCGGyIERpqOVWi9SzPiMDgh4+AHwGcjwQN8465sDsQlmlD8yuKejfmIb4Dj7CAsDLXLb2z8tPzc5SEyRyTl1wYNVrKP5aBwVjI7kOSMoMg0gfxIIki/RtaAkqlk8KobEIItVimfnlTjSW0OwVUwNU3KtZgTtYSUc7SyebxzKLhK3Tfbk72CEJPk5TsqeRma2MfOgIPIsqVyujwg2+iAP4RmEWh5dLBgbNGxBMe396uG2dlj+rKS+AH2qMWX2QXE1ibfPueGJ+2Dgf0WX1TqCudchmVJPhYOR6u9JZEnwvu5B/WPwCJ3gdGsDUXHX3Teg0vI8d6SJq+v4T6cBBa+jBfQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b4c31b-6347-4e25-e487-08d853215ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 11:30:06.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXZuXGfOTYB4SjL0apGrvvoL78N8KxNCiJGYyrIDOiMpp6X7vn687e2AEGY6eySl/ebEWvEOfLuzYsgP7aTHUKUsPCLHyB1ZK9Tmzyn7ASw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3888
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/09/2020 13:29, Johannes Thumshirn wrote:=0A=
> On 04/09/2020 19:37, Anand Jain wrote:=0A=
>> The following test case leads to null kobject-being-freed error.=0A=
>>=0A=
>>  mount seed /mnt=0A=
>>  add sprout to /mnt=0A=
>>  umount /mnt=0A=
>>  mount sprout to /mnt=0A=
>>  delete seed=0A=
>>=0A=
>>  kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_p=
ut() is being called.=0A=
>>  WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350=
=0A=
>>  RIP: 0010:kobject_put+0x80/0x350=0A=
>>  ::=0A=
>>  Call Trace:=0A=
>>  btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]=0A=
>>  btrfs_rm_device.cold+0xa8/0x298 [btrfs]=0A=
>>  btrfs_ioctl+0x206c/0x22a0 [btrfs]=0A=
>>  ksys_ioctl+0xe2/0x140=0A=
>>  __x64_sys_ioctl+0x1e/0x29=0A=
>>  do_syscall_64+0x96/0x150=0A=
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>>  RIP: 0033:0x7f4047c6288b=0A=
>>  ::=0A=
>>=0A=
>> This is because, at the end of the seed device-delete, we try to remove=
=0A=
>> the seed's devid sysfs entry. But for the seed devices under the sprout=
=0A=
>> fs, we don't initialize the devid kobject yet. So add a kobject state=0A=
>> check, which takes care of the Warning.=0A=
>>=0A=
>> Fixes: 668e48af btrfs: sysfs, add devid/dev_state kobject and device att=
ributes=0A=
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>=0A=
>> ---=0A=
>>  fs/btrfs/sysfs.c | 16 ++++++++++------=0A=
>>  1 file changed, 10 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
>> index 190e59152be5..438a367371c4 100644=0A=
>> --- a/fs/btrfs/sysfs.c=0A=
>> +++ b/fs/btrfs/sysfs.c=0A=
>> @@ -1168,10 +1168,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_=
fs_devices *fs_devices,=0A=
>>  					  disk_kobj->name);=0A=
>>  		}=0A=
>>  =0A=
>> -		kobject_del(&one_device->devid_kobj);=0A=
>> -		kobject_put(&one_device->devid_kobj);=0A=
>> +		if (one_device->devid_kobj.state_initialized) {=0A=
>> +			kobject_del(&one_device->devid_kobj);=0A=
>> +			kobject_put(&one_device->devid_kobj);=0A=
>>  =0A=
>> -		wait_for_completion(&one_device->kobj_unregister);=0A=
>> +			wait_for_completion(&one_device->kobj_unregister);=0A=
>> +		}=0A=
>>  =0A=
>>  		return 0;=0A=
>>  	}=0A=
>> @@ -1184,10 +1186,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_=
fs_devices *fs_devices,=0A=
>>  			sysfs_remove_link(fs_devices->devices_kobj,=0A=
>>  					  disk_kobj->name);=0A=
>>  		}=0A=
>> -		kobject_del(&one_device->devid_kobj);=0A=
>> -		kobject_put(&one_device->devid_kobj);=0A=
>> +		if (one_device->devid_kobj.state_initialized) {=0A=
>> +			kobject_del(&one_device->devid_kobj);=0A=
>> +			kobject_put(&one_device->devid_kobj);=0A=
>>  =0A=
>> -		wait_for_completion(&one_device->kobj_unregister);=0A=
>> +			wait_for_completion(&one_device->kobj_unregister);=0A=
>> +		}=0A=
>>  	}=0A=
>>  =0A=
>>  	return 0;=0A=
>>=0A=
> =0A=
> Hmm this is a lot of duplicated code. It was before as well, this patch o=
nly adds=0A=
> to the code duplication.=0A=
> =0A=
> Can't we do sth like this:=0A=
> =0A=
=0A=
=0A=
Hit sent too early I'm sorry. I meant add this (untested) as a prep patch:=
=0A=
=0A=
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
index 190e59152be5..84114a1ec502 100644=0A=
--- a/fs/btrfs/sysfs.c=0A=
+++ b/fs/btrfs/sysfs.c=0A=
@@ -1151,44 +1151,40 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs=
_info *fs_info,=0A=
 =0A=
 /* when one_device is NULL, it removes all device links */=0A=
 =0A=
+=0A=
+static void btrfs_sysfs_remove_one_devices_dir(struct btrfs_device *dev)=
=0A=
+{=0A=
+       if (one_device->bdev) {=0A=
+               struct hd_struct *disk;=0A=
+               struct kobject *disk_kobj;=0A=
+=0A=
+               disk =3D one_device->bdev->bd_part;=0A=
+               disk_kobj =3D &part_to_dev(disk)->kobj;=0A=
+               sysfs_remove_link(fs_devices->devices_kobj,=0A=
+                                 disk_kobj->name);=0A=
+       }=0A=
+=0A=
+       kobject_del(&one_device->devid_kobj);=0A=
+       kobject_put(&one_device->devid_kobj);=0A=
+=0A=
+       wait_for_completion(&one_device->kobj_unregister);=0A=
+=0A=
+       return;=0A=
+}=0A=
+=0A=
 int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,=0A=
                struct btrfs_device *one_device)=0A=
 {=0A=
-       struct hd_struct *disk;=0A=
-       struct kobject *disk_kobj;=0A=
-=0A=
        if (!fs_devices->devices_kobj)=0A=
                return -EINVAL;=0A=
 =0A=
        if (one_device) {=0A=
-               if (one_device->bdev) {=0A=
-                       disk =3D one_device->bdev->bd_part;=0A=
-                       disk_kobj =3D &part_to_dev(disk)->kobj;=0A=
-                       sysfs_remove_link(fs_devices->devices_kobj,=0A=
-                                         disk_kobj->name);=0A=
-               }=0A=
-=0A=
-               kobject_del(&one_device->devid_kobj);=0A=
-               kobject_put(&one_device->devid_kobj);=0A=
-=0A=
-               wait_for_completion(&one_device->kobj_unregister);=0A=
-=0A=
+               btrfs_sysfs_remove_one_devices_dir(one_device);=0A=
                return 0;=0A=
        }=0A=
 =0A=
-       list_for_each_entry(one_device, &fs_devices->devices, dev_list) {=
=0A=
-=0A=
-               if (one_device->bdev) {=0A=
-                       disk =3D one_device->bdev->bd_part;=0A=
-                       disk_kobj =3D &part_to_dev(disk)->kobj;=0A=
-                       sysfs_remove_link(fs_devices->devices_kobj,=0A=
-                                         disk_kobj->name);=0A=
-               }=0A=
-               kobject_del(&one_device->devid_kobj);=0A=
-               kobject_put(&one_device->devid_kobj);=0A=
-=0A=
-               wait_for_completion(&one_device->kobj_unregister);=0A=
-       }=0A=
+       list_for_each_entry(one_device, &fs_devices->devices, dev_list)=0A=
+               btrfs_sysfs_remove_one_devices_dir(one_device);=0A=
 =0A=
        return 0;=0A=
 }=0A=
=0A=
