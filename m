Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09A738251C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 09:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhEQHMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 03:12:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9477 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhEQHMr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 03:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621235505; x=1652771505;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AkGtnO5KEbzdNEWKS7NNc8UakuhF4kBVwfHPic8LEjQ=;
  b=MbHbPUyHY0x69ML915VHrC76uz5lT/IfFH/dUeUfzYKI0ocQxSZmfxcK
   LcBg8NdtAaBPjxNeUxCzDNtZqMOIP+SOBDsPrq0f5HGiWpVfZl6kuluxy
   e8DWjBEARukawRjluaaSoxjS7RC3sa1oL2131GiCzVX5D+oYgDvIJbFVz
   FCRCh7N/asVHiuGg2rSHjD2QFsgfRvvf4RKWOxlXBV1bsPEFZxMp635LU
   wqvC9mUk7udyvBosP6sLruT1YxowHOMkdp8poy725GlG72bkGX4ZIlzE8
   8qX4GIiFOBMLy66ok5TcKcweJJaP6hXBR4vkG4/eHoEGbLGv4Z6Rb8yQp
   A==;
IronPort-SDR: KtIxVXwwUaU72N7ICgVa1mF4DxNDQJ0HaWX0T9jzBX6g76yoD2k+oCEYMUtukhmT/vty0Mu+1j
 UOc8LT4vLpyVXIAhcSaRRgnUzxUkOD//twTmoW7hbSoAZMGCMPeg6yzG2ElrefnD7LrBhA7T2q
 YFiBY5i0jLQwR8SHhFODjb4RSv5tlN3KP6x+ZEbHYn6W/vavIL8eHpAdWY4mBJ4o0rBEzX+Dq2
 DUKFupaB5x9udJP6xP2t2xiJvRBKLK40nfF31cTl3oJrgoANY/wVfiFhwNye9ika9jPLnnpCnU
 Z14=
X-IronPort-AV: E=Sophos;i="5.82,306,1613404800"; 
   d="scan'208";a="272371817"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 15:11:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWieHj7Yal+IFHXajoBXk2crrINCQPI3dfgENa0YxFPZPhMrSvofn90e6vLXYvMNcFa5n7s/6fjmmpHuuLwg4r4hYqQ/0uIPvRcjYcIQqm3M1fZ9gxWglabXy7sfyiNeLcJZEe24Z1hMtvH6ihtkkMqVMMLM50dCOxIA/F8GbdULF/E8wzEvKH+Bi65352hvlEmvIxmZTXD75VInkI/Wsw8uTNP9NQ+e0byniqq+z6qNZLN/Z2ooS7SvNtod5MCXkLmhczSHZyyPUcF+V9T386YRNJ7kKUp2ws1COhD7k4DSjADLuxZ9XjKIhjbWBXsuz9GCRcYgXpiaN4eSNuwztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02TONxE4xk/77Db/csPlLVdnGH8jnAxebouqUzuF2Qo=;
 b=EaZLDkQZFgKD1rkgjWvmMD8PJ1iDWPX2W/BB05zgjYuqklAoo0080QJHw4/Tvbp/j+lZ2thBLH2JLPb2WWzkCIF83PIGshy9FHK5fKSS4QQ4guJ0VKIDm/ElnsY7aZjK+YgYVq+Hva0Zv+noUs8sRw2JaGucIUeWyk9klQTh61qFmcJvYhbkf+yR2ifAVIngxRKVMWH9rDluejHGCuAzwMyCbD77WyeFyVbJJLYEfmDStAPvswT1mz4Q6r3O0RLSumzOQ/m41M1Fvtk8BSRkkhJQiNGf+HZzo+RWAZptrCIg5fM8vTA9fv/rhy8OXNoB2HtJUdmAPsNC4/Re67VyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02TONxE4xk/77Db/csPlLVdnGH8jnAxebouqUzuF2Qo=;
 b=a8+T1tDKi7xHN8ygqBZZ1EeJbgmxS9To5sn0v5x9Ws3aIJebJMGHXHLvbRNvLFBojtaNIREMPzI+m0W9fyF2K2IPWznTsIiC0yNnxYIeMTVFVNCjglODMjL3p/iZwwfF7dO5GyasG8FT0O4ClHFF9gob5DE8bEO58/zI+VyILWw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7255.namprd04.prod.outlook.com (2603:10b6:510:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:11:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:11:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: sanity check zone type
Thread-Topic: [PATCH v2 1/2] btrfs: zoned: sanity check zone type
Thread-Index: AQHXQL/nXNOGJ3/i8ECpEofqnXsVDA==
Date:   Mon, 17 May 2021 07:11:29 +0000
Message-ID: <PH0PR04MB7416215A9481D4CB0F9A5C749B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210504083024.28072-1-johannes.thumshirn@wdc.com>
 <20210504083024.28072-2-johannes.thumshirn@wdc.com>
 <20210512223028.GC7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:9ba:2a4d:8d47:65d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9abd505-82e5-48f5-d807-08d91902fe0e
x-ms-traffictypediagnostic: PH0PR04MB7255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7255DE34D868966AF293CF839B2D9@PH0PR04MB7255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:98;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53ZRwlaIAfOomjbqTqnCyHEUSJhVzbCHivTOeQ8UPBL0EJ425djLK0GrQm/f8AL3OssLdEInEkrwjijQ4oYFJg0W4wIC7jLcQFdowcAE2aoJDZO33177FpJGvBnnHt4JwEc7PDekbFbfOaKs5RKgVWaUZ9ZCmY1ID+QiFp9QIWpFze8UmE7Nneq3Zi097F5aYuL7iZEvO0HikGpWnqKlUk9togWlDvxYUS+TQ2xfaFzdnksWhDj4WZHMOeU5qqf8dehUdav+CyEpI9WWunGvujT+9OVevDplHU++WeJ43IFDv8P+JR65Swcg5Ct3aYJaKx1Bn+szDJ249ID8sBgAZlN8AXrMzmzComif/1X/bGpAEOoZImtcrtzXj3uf/nwEM3316aY1D3de0X8UN1BtS1lwn7vf1Ae3mz1KKwZYEkV0amVvFWrgtA9Giihesv3gZlD4blcI2jPIMX0iXzIqulcvYBCY8ikQZO82Xx8j5XzQbc4sORaX92ol132glX0rmxuKnLPnF0Apu3+TymQwSOl3Qb3YM1bCwQD5WtwIdR/Y2iHqkBEKzDpDUDxUmnMJT0+iqgcFEcTpPiFYVxznBMBom/bSMbGKZ67Rhghu+Ec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(8676002)(54906003)(55016002)(38100700002)(5660300002)(71200400001)(2906002)(9686003)(6916009)(52536014)(122000001)(33656002)(66946007)(478600001)(316002)(91956017)(76116006)(7696005)(4326008)(64756008)(66556008)(66446008)(86362001)(83380400001)(66476007)(186003)(53546011)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RqXDbVoPBsXlQGEFZICHWqitC20BgH/LBBeKQL6mLgV8gobGdinpV23ptvxT?=
 =?us-ascii?Q?umg1urFTMl9jIm129RdgjtI8CCDVJhK1A+T7CtciGimPq1VA1DBVi9lff2qH?=
 =?us-ascii?Q?/VmfgE63vWRhfvwb4p9Je6bF9DpYrpDWa+NTJBjk2ihFiBM6Ngphyl2HtJxU?=
 =?us-ascii?Q?8Lk3CGWhYm5nG0s1z5H2VqZquvMYoRWewVGt0tud1Otd/2F0N4IcRyyhJsOQ?=
 =?us-ascii?Q?51D7KaGK+ODRx+BJ+J4bLed1O0IG0HcV6WiFaU7yjIJ0PMbnp23y2tzlmMKB?=
 =?us-ascii?Q?4vJWDpd17Ftz5T+LgpZj8T4jVmvdYpQmgVb7SJyCy1jGwFCkbglO2lTs5LJu?=
 =?us-ascii?Q?HdAalseTdg/m5VW2Itv9TpSylyl+z7PltwDsatxkqusCWmdkoNXvytxlLLDo?=
 =?us-ascii?Q?fRHXy3RZtyp4NG/IDsvnt3RTD9F6eoxqnDjEKpMPKeRF0p3auDNCp1xa3KGK?=
 =?us-ascii?Q?NRy8nNJIhiv7c2XQMC0kxXhP87ASBiA6Ad/3HeYmEm+enl/BJ52n6Abbthxi?=
 =?us-ascii?Q?JijkXTL3tDGzaT6uNaaeGUlC/zT/1KYUhu91r7+Ad6tN4Ph2MKgDEXtvJmBa?=
 =?us-ascii?Q?V1ZAc5WChMufirTKh3AXh6y7vqMxlM+NDU+kIMjH6yhE2/yVQV6o0j0ImFXJ?=
 =?us-ascii?Q?P5n1cG7mQmD4WoRcOXyh0Ify+brOVIl2Nt1GWgbyXH8S44FIWRJr18/nmUdm?=
 =?us-ascii?Q?NpMcLn6nmwHSa9HcUEydsEi/BY6kxjpqF3sPpaxDr2PyGqMxuVPJ22R6Vphg?=
 =?us-ascii?Q?2ai3w5Uf6BzUkapdXb0fSTSSJ3720n17ImqYEodWYLmBYuKY6ZIFXnr31bDn?=
 =?us-ascii?Q?qoQNGRM/0PCtFjTbWuCoOYe0trIf9WImDxblwkDzn3QxdATNXS9l4ZYOPxel?=
 =?us-ascii?Q?MNlGuQj0NssrErrZgGM88VcOmosrAwoQdQ2ucZSDTqdjMEncPIGpjfQ3V+Pe?=
 =?us-ascii?Q?mvSP4fPCae4tilg6weP07C99DI0VwjBAcEq7Ax3lCsGzl8QXBQZzAcGeH+E0?=
 =?us-ascii?Q?foGMmZcCs1FjPmW9cac80tyLe8tKrO5GKPeQtPf9XgmiC5mSVhdKf0GC6vSt?=
 =?us-ascii?Q?FbcLPNGQx0X6DSHxnkWKQRm5tCSay7L+6/JZzBflb4vullbuoPxy+mXBb448?=
 =?us-ascii?Q?ItCn4up9zqjVfJSHzhCIHNQurt+mHMxyRSPmMTrEXsw8ucwm9tOySWnD0Trv?=
 =?us-ascii?Q?+MzNMfwyZbG22h/I0FFgAYj0lT81d3uY1e21DyKq7bbMYaaGfUcXKdmh6OHC?=
 =?us-ascii?Q?Vq5CGiUXXpg9yfRWNSCrYJUtwDGcZIqlrwLq3BAEUUclWrW/RWRDpdyqqQOu?=
 =?us-ascii?Q?aWcLHV7csaIX2klC0WfUKAZCiWarbCifrEzEMVGXC9OqcBnPKkJVrwEd2MG4?=
 =?us-ascii?Q?Ibpn7LgEwSG+Uw5ruJSuzEEUKWOp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9abd505-82e5-48f5-d807-08d91902fe0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 07:11:29.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YITc+Bc/JOR+w8Da/JkMAOKa+tqwZ3sLu7x2zo7Z1xsf+yVEISDo63R+EP4OVV2gRJ8lhuSEuP88BUuDk8btRPp1nvoqksnBQntEx2GqZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7255
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2021 00:33, David Sterba wrote:=0A=
> On Tue, May 04, 2021 at 10:30:23AM +0200, Johannes Thumshirn wrote:=0A=
>> From: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>=0A=
>> The xfstests test case generic/475 creates a dm-linear device that gets=
=0A=
>> changed to a dm-error device. This leads to errors in loading the block=
=0A=
>> group's zone information when running on a zoned file system, ultimately=
=0A=
>> resulting in a list corruption. When running on a kernel with list=0A=
>> debugging enabled this leads to the following crash.=0A=
>>=0A=
>>  BTRFS: error (device dm-2) in cleanup_transaction:1953: errno=3D-5 IO f=
ailure=0A=
>>  kernel BUG at lib/list_debug.c:54!=0A=
>>  invalid opcode: 0000 [#1] SMP PTI=0A=
>>  CPU: 1 PID: 2433 Comm: umount Tainted: G        W         5.12.0+ #1018=
=0A=
>>  RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47=0A=
>>  RSP: 0018:ffffc90001473df0 EFLAGS: 00010296=0A=
>>  RAX: 0000000000000054 RBX: ffff8881038fd000 RCX: ffffc90001473c90=0A=
>>  RDX: 0000000100001a31 RSI: 0000000000000003 RDI: 0000000000000003=0A=
>>  RBP: ffff888308871108 R08: 0000000000000003 R09: 0000000000000001=0A=
>>  R10: 3961373532383838 R11: 6666666620736177 R12: ffff888308871000=0A=
>>  R13: ffff8881038fd088 R14: ffff8881038fdc78 R15: dead000000000100=0A=
>>  FS:  00007f353c9b1540(0000) GS:ffff888627d00000(0000) knlGS:00000000000=
00000=0A=
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
>>  CR2: 00007f353cc2c710 CR3: 000000018e13c000 CR4: 00000000000006a0=0A=
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
>>  Call Trace:=0A=
>>   btrfs_free_block_groups+0xc9/0x310 [btrfs]=0A=
>>   close_ctree+0x2ee/0x31a [btrfs]=0A=
>>   ? call_rcu+0x8f/0x270=0A=
>>   ? mutex_lock+0x1c/0x40=0A=
>>   generic_shutdown_super+0x67/0x100=0A=
>>   kill_anon_super+0x14/0x30=0A=
>>   btrfs_kill_super+0x12/0x20 [btrfs]=0A=
>>   deactivate_locked_super+0x31/0x90=0A=
>>   cleanup_mnt+0x13e/0x1b0=0A=
>>   task_work_run+0x63/0xb0=0A=
>>   exit_to_user_mode_loop+0xd9/0xe0=0A=
>>   exit_to_user_mode_prepare+0x3e/0x60=0A=
>>   syscall_exit_to_user_mode+0x1d/0x50=0A=
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
>>=0A=
>> As dm-error has no support for zones, btrfs will run it's zone emulation=
=0A=
>> mode on this device. The zone emulation mode emulates conventional zones=
,=0A=
>> so bail out if the zone bitmap that gets populated on mount sees the zon=
e=0A=
>> as sequential while we're thinking it's a conventional zone when creatin=
g=0A=
>> a block group.=0A=
>>=0A=
>> Note: this scenario is unlikely in a real wold application and can only=
=0A=
>> happen by this (ab)use of device-mapper targets.=0A=
>>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> [ jth: commit message and error messages ]=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/zoned.c | 9 +++++++++=0A=
>>  1 file changed, 9 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index 70b23a0d03b1..6edf88580f47 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -1126,6 +1126,15 @@ int btrfs_load_block_group_zone_info(struct btrfs=
_block_group *cache, bool new)=0A=
>>  			goto out;=0A=
>>  		}=0A=
>>  =0A=
>> +		if (zone.type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
>> +			btrfs_err(fs_info,=0A=
>> +				  "zoned: unexpected conventional zone: %llu on device %s (devid %l=
lu)",=0A=
>> +				  zone.start << SECTOR_SHIFT,=0A=
>> +				  rcu_str_deref(device->name), device->devid);=0A=
>> +			ret =3D -EIO;=0A=
> =0A=
> I messed up the patch queues when sending the pull request and the V1=0A=
> got merged, without the message. I got this diff after rebase of=0A=
> misc-next=0A=
> =0A=
> --- a/fs/btrfs/zoned.c=0A=
> +++ b/fs/btrfs/zoned.c=0A=
> @@ -1127,6 +1127,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)=0A=
>                 }=0A=
> =0A=
>                 if (zone.type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {=0A=
> +                       btrfs_err_in_rcu(fs_info,=0A=
> +       "zoned: unexpected conventional zone %llu on device %s (devid %ll=
u)",=0A=
> +                               zone.start << SECTOR_SHIFT,=0A=
> +                               rcu_str_deref(device->name), device->devi=
d);=0A=
>                         ret =3D -EIO;=0A=
>                         goto out;=0A=
> ---=0A=
> =0A=
> I can update the changelog to describe what happened and that we want=0A=
> this message and you don't need to resend anything, or you can send it=0A=
> but because that it's my fault I'd rather do that but wanted to let you=
=0A=
> know.=0A=
> =0A=
=0A=
Looks good thanks :)=0A=
