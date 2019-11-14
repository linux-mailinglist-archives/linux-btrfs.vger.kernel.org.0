Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978B4FBDBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 02:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfKNByr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 20:54:47 -0500
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:41036 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfKNByr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 20:54:47 -0500
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 20:54:46 EST
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.190) BY m9a0001g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu, 14 Nov 2019 01:54:07 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 14 Nov 2019 01:37:32 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 14 Nov 2019 01:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWuxoOxPljmH3vTVkpsX5qyEobOXWMVZEzTRZ3Kmg2dne3KtVNaTeL9hu02kVXul7hpvziIX+9T+JcaKleEudJ2Oy1ZsRbzaOOU5Tm5VQc07ijqieqFpxgDQ86a8m0+pC7ZONdbW8BUolvz3gYYEt4+K3P3zb/jGGzBbmRgixm/5hlGlnIcTu7bCIXHQUM+OT5avm42/7+uTIwPjAzFqbYGqAo/Cp3NjTDO5J0EqLvngRysulnWkKsDBVTyK3tLdrl0kWgihJ1AOfYbju5FlNYOWjEc1VwGkYPwW3AOSBnC1vAuzEXaojIku5d/p/BMo0Q7X1b290pWnUwDhhZUgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wojp6WMup6+SYbI6+JZZYoIx/BWYWYX313GnN8lwe7Q=;
 b=KsUS8GZ+83SCZelu1hn66fnFjAR+QGCavkgkmX2qOKledIdytV1s3THnu/hp6xsY9jIQOoi+EQHTe2jLH8QsGfrEvo5k0nhBBtv99WLiJdFkhF33RvcrMVETWnQ8qbq2ryJqjjFTRcIFMNjdUAz3gidofyKgYsAzIG+/f88HiaQ+anQtrxVoo3SXg4uCXAxfSEE2LWeaEgCs4+4KFStx9Y/7ABDmMr4Hcloft+FG5J22xVsQ8dyAGoI5sruXmjWXZUBEl3LK+QWCiM8QhfGG3/mDr7PbEp98AvpAiujJsFtkvvpZMahBdB/GvhzCFVhLLepqbKkyhWGuxxfRK/ibkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3153.namprd18.prod.outlook.com (10.255.139.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 14 Nov 2019 01:37:31 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b%3]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 01:37:31 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where
 assignment for cache is missing
Thread-Topic: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where
 assignment for cache is missing
Thread-Index: AQHVmi8YTLPNilNnrUmeiKvE7EPeMqeJ2LWAgAALDIA=
Date:   Thu, 14 Nov 2019 01:37:31 +0000
Message-ID: <224a194f-0f6f-d768-03cd-c31e70fdeb14@suse.com>
References: <20191105013535.14239-1-wqu@suse.com>
 <20191105013535.14239-2-wqu@suse.com> <20191113143143.GA3001@twin.jikos.cz>
 <5804867d-d3dc-3fb5-f152-10b9e35b8278@gmx.com>
In-Reply-To: <5804867d-d3dc-3fb5-f152-10b9e35b8278@gmx.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0191.jpnprd01.prod.outlook.com (2603:1096:403::21)
 To BY5PR18MB3266.namprd18.prod.outlook.com (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078d02b9-e1a5-4dd6-e877-08d768a33740
x-ms-traffictypediagnostic: BY5PR18MB3153:
x-microsoft-antispam-prvs: <BY5PR18MB31538B541EED2F9F962698C0D6710@BY5PR18MB3153.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(86362001)(66616009)(2201001)(64756008)(66446008)(66946007)(66476007)(66556008)(8676002)(81156014)(81166006)(8936002)(31686004)(5660300002)(76176011)(386003)(6506007)(45080400002)(102836004)(186003)(31696002)(6436002)(6512007)(478600001)(6246003)(14454004)(26005)(6486002)(2501003)(71200400001)(71190400001)(66066001)(256004)(14444005)(2906002)(3846002)(7736002)(2616005)(11346002)(446003)(305945005)(486006)(476003)(6116002)(25786009)(316002)(99286004)(110136005)(52116002)(36756003)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3153;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NX0b8Yis1Is3zVJzwv2XmHZRDJ3/jWWWIUs+Z548oELaImlSzhW5T87DEPqSR7gBL1qNXuTVWm30S4lKUy4XXatakkW9MtlEY4WfOmcMyjQK89qnpyQzsxJHAd/k/lBBlN/Ci+Q8b5I19OOge5Y3EBfi2DdCU86TDFqRVU+RrafO9uot2SMdY0TFojKMqwFFB3/A+y5HzduDLW7Ait0Xx/xVzOkntx1s1DiDbUpSnHgEMOgwVqJxcOp4FuhpHefa3BY82sot8ZEU8WAPRxYqFZa21pYNveXuw36PftZG5NNYnKVovgqsbYUm74plBSMo570MhaH6UAn2/pkXo5JIGyzfiqurzd7mG0I9T14EQj9LAxWmY7b+wScMNeF5CcD90NmP/aApI6SzG+FHDi3DVY4spt7Wcpl/ow/Gbq3rUpHsxU0uiILcjSjTOKVBhjVL
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="bkkFGy38MDrSOP4iXUHCgL4JhIATMKSks"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 078d02b9-e1a5-4dd6-e877-08d768a33740
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 01:37:31.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTWmbSWB/cgpY/a4n7bTIXlq0R4lNjsGGZF2VM0RVFpDDtaop6hj9cF5hSXiMW0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3153
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--bkkFGy38MDrSOP4iXUHCgL4JhIATMKSks
Content-Type: multipart/mixed; boundary="owKXUeNsk3g8KGQZqjiP8LRpkG1ai0T9e"

--owKXUeNsk3g8KGQZqjiP8LRpkG1ai0T9e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/14 =E4=B8=8A=E5=8D=888:57, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/13 =E4=B8=8B=E5=8D=8810:31, David Sterba wrote:
>> On Tue, Nov 05, 2019 at 09:35:34AM +0800, Qu Wenruo wrote:
>>> Without proper cache->flags, btrfs space info will be screwed up and
>>> report error at mount time.
>>>
>>> And without proper cache->used, commit transaction will report -EEXIS=
T
>>> when running delayed refs.
>>>
>>> Please fold this into the original patch "btrfs: block-group: Refacto=
r btrfs_read_block_groups()".
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/block-group.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index b5eededaa750..c2bd85d29070 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -1713,6 +1713,8 @@ static int read_one_block_group(struct btrfs_fs=
_info *info,
>>>  	}
>>>  	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
>>>  			   sizeof(bgi));
>>> +	cache->used =3D btrfs_stack_block_group_used(&bgi);
>>> +	cache->flags =3D btrfs_stack_block_group_flags(&bgi);
>>>  	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
>>>  	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
>>>  			btrfs_err(info,
>>
>> Is it possible that there's another missing bit that got lost during m=
y
>> rebase? VM testing is fine but I get a reproducible crash on a physica=
l
>> machine with the following stacktrace:
>>
>>  113 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flag=
s,
>>  114                              u64 total_bytes, u64 bytes_used,
>>  115                              u64 bytes_readonly,
>>  116                              struct btrfs_space_info **space_info=
)
>>  117 {
>>  118         struct btrfs_space_info *found;
>>  119         int factor;
>>  120
>>  121         factor =3D btrfs_bg_type_to_factor(flags);
>>  122
>>  123         found =3D btrfs_find_space_info(info, flags);
>>  124         ASSERT(found);
>=20
> It looks like space info is not properly initialized, I'll double check=

> to ensure no other location lacks the flags/used assignment.

After looking into the latest misc-next branch, I still can't find the
reason why it doesn't work.

We have several layers of verification:
- Tree checker
  This has ensured all BGI on-disk has correct type (DATA, SYS, META
  or DATA|META for mixed bg)

- DATA, META, SYS space info created in btrfs_init_space_info()
  3 or 2 (for mixed bg) space infos are created according to incompat
  flags.

- btrfs_update_space_info() in read_one_block_group()
  In it we call btrfs_find_space_info() to find the desired space info.
  btrfs_find_space_info() will return a space info as long as *ONE* type
  bit matches.
  That's to say, even for MIXED_BG case, it would still return the
  DATA|META space info if we pass DATA flag.

In theory, it's impossible to hit that ASSERT().
If it's a bgi without a valid type profile, it should be rejected by
tree-checker.

Even for MIXED_BG feature but without any mixed bgs, we should still
find a hit in btrfs_find_space_info().
If it's mixed bg without MIXED_BG feature, we should detect it early in
read_one_block_group().

So my current guess is, that physical machine is not using the correctly
rebased code?

Thanks,
Qu

>=20
> THanks,
> Qu
>=20
>> [ 1570.447326] assertion failed: found, in fs/btrfs/space-info.c:124
>> [ 1570.453862] ------------[ cut here ]------------
>> [ 1570.458629] kernel BUG at fs/btrfs/ctree.h:3117!
>> [ 1570.463445] invalid opcode: 0000 [#1] PREEMPT SMP
>> [ 1570.468310] CPU: 3 PID: 2189 Comm: mount Not tainted 5.4.0-rc7-1.ge=
195904-vanilla+ #509
>> [ 1570.468312] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2=
008
>> [ 1570.468388] RIP: 0010:assfail.constprop.14+0x18/0x26 [btrfs]
>> [ 1570.508150] RSP: 0018:ffff9f9c40f7fa20 EFLAGS: 00010282
>> [ 1570.508153] RAX: 0000000000000035 RBX: 0000000000000000 RCX: 000000=
0000000000
>> [ 1570.508157] RDX: 0000000000000000 RSI: ffff918ae73d9208 RDI: ffff91=
8ae73d9208
>> [ 1570.528092] RBP: 0000000000000001 R08: 0000000000000002 R09: 000000=
0000000000
>> [ 1570.528093] R10: ffff9f9c40f7f978 R11: 0000000000000000 R12: ffff91=
8ab37c0000
>> [ 1570.528095] R13: 0000000000000000 R14: 0000000000400000 R15: 000000=
0000000000
>> [ 1570.528097] FS:  00007f0d3f937840(0000) GS:ffff918ae7200000(0000) k=
nlGS:0000000000000000
>> [ 1570.528098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1570.528100] CR2: 00007f9559f4c000 CR3: 000000021bdb9000 CR4: 000000=
00000006e0
>> [ 1570.528101] Call Trace:
>> [ 1570.528149]  btrfs_update_space_info+0xb7/0xc0 [btrfs]
>> [ 1570.579229]  btrfs_read_block_groups+0x5b2/0x8e0 [btrfs]
>> [ 1570.579283]  open_ctree+0x1bd5/0x2323 [btrfs]
>> [ 1570.589311]  ? btrfs_mount_root+0x648/0x770 [btrfs]
>> [ 1570.589351]  btrfs_mount_root+0x648/0x770 [btrfs]
>> [ 1570.599226]  ? sched_clock+0x5/0x10
>> [ 1570.599233]  ? sched_clock_cpu+0x15/0x130
>> [ 1570.607049]  ? rcu_read_lock_sched_held+0x59/0xa0
>> [ 1570.607058]  ? legacy_get_tree+0x30/0x60
>> [ 1570.616042]  legacy_get_tree+0x30/0x60
>> [ 1570.616045]  vfs_get_tree+0x28/0xe0
>> [ 1570.616052]  fc_mount+0xe/0x40
>> [ 1570.626809]  vfs_kern_mount.part.5+0x6f/0x80
>> [ 1570.626842]  btrfs_mount+0x179/0x940 [btrfs]
>> [ 1570.626855]  ? sched_clock+0x5/0x10
>> [ 1570.639359]  ? sched_clock+0x5/0x10
>> [ 1570.639361]  ? sched_clock_cpu+0x15/0x130
>> [ 1570.639369]  ? rcu_read_lock_sched_held+0x59/0xa0
>> [ 1570.652054]  ? legacy_get_tree+0x30/0x60
>> [ 1570.652056]  legacy_get_tree+0x30/0x60
>> [ 1570.652058]  vfs_get_tree+0x28/0xe0
>> [ 1570.652062]  do_mount+0x828/0xa50
>> [ 1570.652068]  ? memdup_user+0x4b/0x70
>> [ 1570.670815]  ksys_mount+0x80/0xd0
>> [ 1570.670819]  __x64_sys_mount+0x21/0x30
>> [ 1570.670825]  do_syscall_64+0x56/0x220
>> [ 1570.682011]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [ 1570.682014] RIP: 0033:0x7f0d3f22b5ea
>> [ 1570.682018] RSP: 002b:00007ffd2cf30e38 EFLAGS: 00000246 ORIG_RAX: 0=
0000000000000a5
>> [ 1570.682020] RAX: ffffffffffffffda RBX: 000055d29414c060 RCX: 00007f=
0d3f22b5ea
>> [ 1570.682021] RDX: 000055d29414c2c0 RSI: 000055d29414c300 RDI: 000055=
d29414c2e0
>> [ 1570.682023] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f=
0d3f4dd698
>> [ 1570.682024] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 000055=
d29414c2e0
>> [ 1570.682025] R13: 000055d29414c2c0 R14: 000055d293a02160 R15: 000055=
d29414c060
>> [ 1570.682035] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dn=
s_resolver nfs lockd grace sunrpc fscache af_packet btrfs bridge stp llc =
iscsi_ibft iscsi_boot_sysfs xor kvm_amd zstd_decompress kvm zstd_compress=
 xxhash raid6_pq tpm_infineon tpm_tis tpm_tis_core libcrc32c tg3 tpm libp=
hy mptctl acpi_cpufreq serio_raw irqbypass pcspkr k10temp i2c_piix4 butto=
n ext4 mbcache jbd2 sr_mod cdrom ohci_pci i2c_algo_bit ehci_pci drm_kms_h=
elper ohci_hcd mptsas ata_generic scsi_transport_sas syscopyarea sysfillr=
ect ehci_hcd sysimgblt mptscsih fb_sys_fops ttm mptbase drm usbcore sata_=
svw pata_serverworks sg scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>> [ 1570.810782] ---[ end trace ceba6fe68d860cea ]---
>>
>=20


--owKXUeNsk3g8KGQZqjiP8LRpkG1ai0T9e--

--bkkFGy38MDrSOP4iXUHCgL4JhIATMKSks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Mr9MACgkQwj2R86El
/qirkAf41tNN55r89Rf/uSbEx/bs6PO5Y9UJ2pr+M385W4W4RlQgyFAr6v4k+yPr
S4xGRTl7vx3ZmHzKdueg0YohVDG5FoPWsWdmgju4t9G8ixhXvGqTl8cx3mKfcEwT
FVu+rGHgJ2vvQwPGWAjNYTXWjcigBW1smdcWRppn7iPX8n6SgAF7E/qwURICU9JE
9CZuRvKnpasjWG7QHAWEHCGEBUI9bdExAPKG0hXBPE+BTUu4fp7oS3ICuY+o4Vto
NfJxSKrSEIYvusF6tWkVqRMpj+zwgXYJmrCGUhMeOisIcf+JLq46stN9fp5ttbQI
4bixmtRLsUITkbxHTOUg4yI0A9DR
=kBNL
-----END PGP SIGNATURE-----

--bkkFGy38MDrSOP4iXUHCgL4JhIATMKSks--
