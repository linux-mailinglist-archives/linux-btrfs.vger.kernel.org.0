Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D86428D08
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhJKMcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 08:32:55 -0400
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:22721
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234689AbhJKMcy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 08:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+R7OIo3fitDCDH18cqeuj/Ym5luuVB4zYKJqLJe6jYyDH1wmJ5sQdDvl5hqKER+018k08QLszJPjXfpWa9qj8UDzgudbtYyZXe5/P1bVJRKDT98gfzyRAWDRq+musbf0IauBiKTv1uf29R5RsEpn1h96kwC2+nkBhwHXFWNosEIomF630Rml3Lh/9sHfi1rjRsH6S1ZwdLg3zl6+ygoeL15fb3tFmB+ZQuvaJ7dUrfB1mGgwE2nvhM3gvjyKJxNSXykCEBn9yL8ohNApktd9lyMr4UIdiJ9qX094JiKRTFeV/2Sk8oBwCQXzgtrD2gl3/n26HZd+4fSryQTGv4yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGLXi6+sCh+BawWloWynZKHJqNat3AjmtLPdjpBCVU8=;
 b=Gs6RYgqp/s40TIeCr4I5iifP0gJm4z4jZsg446ENk8wgRNH68InFAay+rAffvdK04gVvmSUDxUTVY+90QFvulTyV5MswdLKn86wljDa2ljWtmuTACQ68DL+KwxO9Om4f4ercGpG6X5y/PWjHlQ/0wmFXKo5Tf9PsPCvEyb7FNPdamqhswQdxu+e4fxePMEDQ9/P+IdTM6aeX6QiIl0H4dqJdARw+9CkdRCvu+6a+DTeWxEkK1cS3JDd5Fe831qyEUWIdJ+vIUze2uG+xGjvv4VH2iWTJm/ZPYIZMsFvqkO89/xWnkoQ1vBFXRwDetINIqMaieOQNkHJrpUrOosyeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibt.cas.cz; dmarc=pass action=none header.from=ibt.cas.cz;
 dkim=pass header.d=ibt.cas.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avcr.onmicrosoft.com;
 s=selector2-avcr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGLXi6+sCh+BawWloWynZKHJqNat3AjmtLPdjpBCVU8=;
 b=KJdX4yFZ1ZPe0drsukJICNffglMkYIVSNAL08OoYD337mXmXYZoQ6Rb+djcS8GOqZFsAm51IzzLX29B1Q/ipW9jS7yLM/iv+BZa0TaIZTOpS3gOZsvKuJa8tkEW4hyVmJUhKbqxgCCbMHWanK2q45hyyT+rPGSOJfzmHQcxN+Nw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ibt.cas.cz;
Received: from DB6P190MB0453.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:32::33) by
 DB9P190MB1339.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Mon, 11 Oct 2021 12:30:52 +0000
Received: from DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 ([fe80::f8be:1160:d1cf:c9b7]) by DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 ([fe80::f8be:1160:d1cf:c9b7%6]) with mapi id 15.20.4587.025; Mon, 11 Oct 2021
 12:30:52 +0000
To:     linux-btrfs@vger.kernel.org
From:   Michal Strnad <michal.strnad@ibt.cas.cz>
Subject: No space left even there is a lot of space
Message-ID: <8d31b2f5-5474-6e12-fd9b-56aa378069f4@ibt.cas.cz>
Date:   Mon, 11 Oct 2021 14:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050006080306060501000609"
X-ClientProxiedBy: VI1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::17) To DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:32::33)
MIME-Version: 1.0
Received: from [192.168.11.101] (176.114.240.18) by VI1PR0802CA0007.eurprd08.prod.outlook.com (2603:10a6:800:aa::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 12:30:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8126d6-f29f-4471-c90f-08d98cb2f716
X-MS-TrafficTypeDiagnostic: DB9P190MB1339:
X-Microsoft-Antispam-PRVS: <DB9P190MB133900AB41B7AB3480F13653DFB59@DB9P190MB1339.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTTF7V2KUK/TB0XX+p0RbzH+JXP3sAztXxhJk4LLpeMgLw5yt3auAlxBmJEkf/Rk+v4ca5AOcGgHEyDSf+8hBV0HuBkkVyH6MfLeUCUz43Fl/xKfewKQnmJqrxl2WYMHZCs8cVDSM9xEnuM04Iw+jUeSQE+Fs3WYwmM1qUxR2Lfj7PlWEJBr3Fbs6EAKYTq/YTMqJbEmuAE9bY4/IMNQDpmIOkcu7Zsg6zfIzurEkCfyJe4hBsz9NJFueV7QNcwLrEgrxDRQoA0VyYKIP2VFgpkcgRC187rO1u6EVQ8i8CjWN7kWdTJHWdsH3PysQjh3uleoYb3zlkP53IvgnEFsuFFCMhriiT5R79ifxkBaHYvjFmn/g4KEfLlnrUQcyukSNjzsKFVLgWQmuJaTe3TNQ9WoP6v0crGvdVLeRhL/uMpy3OpJCnpoJDGYCcrd9iuP6AjKLC+dWd7M4wgcK4qQCposIBcC2JKbysluXvBVkHkWuYipbAiq0WbaZIpIlR9r1uH0zSuL9fdIVzqiTQc4FgyQXZc5VMRQ710BsHFYywkJ2QTYg1HdpqxmrgyeLQy8PQ8gja9xqWQSdm0OnUXSQ9GuUcIl1mgY0YcyDTyh04xReYQWZXKTh7Mm1GS2FgKJFugT/gJgsY3HtY227Lm/Ue1AmhciGQXi3AEMwdy8jInp59WnEe8K49cBWpACKa4dSd3/EOj3x9nCGTPqW14gvMo26JKYuPClEkZFDrfvYUufbImswRtx7bAwmy511awQuapmyJeW8NPkZ75yH+MgsnNlKv0HewLkNRjgUZQOnbi2yiybESLP6lfD7EgpGCpJboMVsJ9YThBzsJ72VvlUkee4AvxeMNWTcL51NXdGWR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0453.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(26005)(6916009)(38100700002)(38350700002)(8936002)(36756003)(44832011)(83380400001)(956004)(2616005)(33964004)(66946007)(52116002)(45080400002)(66556008)(66476007)(316002)(86362001)(508600001)(5660300002)(31696002)(16576012)(16799955002)(186003)(786003)(6486002)(235185007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhBQXFNZlNLZDFWR3hEbnBnUGFnRHVNRDArMUtsMTFDOW5BaFk4bnZxQVM2?=
 =?utf-8?B?Y1dvSG5kWnJSS3lFUEUxVkIrWnNjNnB0SFlyWW44RGdOSkIxWkVMd0RkQS9u?=
 =?utf-8?B?TDFZcFhiUHVzaUJBMkJVbXovVGV6WG9DRE5rKzZvVHpDTGo5VGo2QWg4S0pR?=
 =?utf-8?B?RTdqallJdXdhUWFyVEw2TmJiVFJpMFlHd1FlTUZxa1hFNVF1Q0hpeDBZc2dv?=
 =?utf-8?B?aC9pbGw3RjZIeUNTZFg1RkR4K3g3MVA4OWJ1ekVQNkJhR09TNFhXV09uRi9S?=
 =?utf-8?B?bnFGc3B4UlZYamYxd2l6V3d5ODhwMlhoNCtKTVhpaUZXSTIxdkFLVE9GSFlI?=
 =?utf-8?B?S3ZKbnBkczhVNy85MkQyM2U4d3RLekJuN2ZZdmtEUHI0VU4rT1I1YzJONHdQ?=
 =?utf-8?B?dUREVXVla2RjWDhnV0Q4b0JpRityRXdSaUxKNWREbVUzZ2RoTEJHaHIxbXJF?=
 =?utf-8?B?b2d1Zml2QThta1NhRks3ejF6K2FrM1h0dGM2eFkzWDM4L0tZck9NeXhTQTdW?=
 =?utf-8?B?RVU5RThESXhHNUc3OVdMNzY3bXppNytVMzBLbU1ia3RlNXgzRFZLMkxUU3Rx?=
 =?utf-8?B?MG94OEFqZXVhWktSK1Z0T21pSUZrWUhyT2dUdjRIYzRnWTlTSnVCb0ZIWTdx?=
 =?utf-8?B?V29uMmMyVS8rVjNZNVc4OFc0RFh2VVBhZDhnTXptUkZIWDJWTmNxN3kvbGls?=
 =?utf-8?B?akV1VzZ3cGRJMC9qZUtXbWNHdWVkdW95WHRESllZeEVuWENUN1Y3UmhrdW94?=
 =?utf-8?B?YUZqdndkVmo3dzZEQk1mZjAvV3dJOXdnK0o4NlluYTVZSUQ4YnEyL1hmRkdW?=
 =?utf-8?B?TUdGV1JxeVNmYkhpVlpJSGx3aVRBVzZ2UjQxUWRQRWlQSGY2YTgvUkduMWo0?=
 =?utf-8?B?UWZ1Znc2dWlyenBIOGpyc1lJejBzVUhCbmtMazN3bi9tMWU0TVoxRGVKWml3?=
 =?utf-8?B?VDF1SjFjYWRVQU9iSGJ5SWp6b2QrTTU5MGF2UXN0ZythckhQUXRtenorZGNk?=
 =?utf-8?B?czVrcVNWTXVmUDVheFBDSmd1RFFVbng1M25oY2NDbjFlL1UxWlFKV1ZneGhp?=
 =?utf-8?B?NHZ0WXZEa3BWeVdycEcrb0IzdCs2b3pzSy9XRjN2bDFqMG4rOWZ5SDErRnpE?=
 =?utf-8?B?Zmk5K21mZFRPa25rOUFZOU9VYnNLZ3luUEVHdEtNRnAwZU1ORUtyU2IrUzZ5?=
 =?utf-8?B?NnhEUjc0Um5EbTlEc1gvaFczV0dNSXBDVUlkeFN1ZW1HWjVJTGloNmlWUHdW?=
 =?utf-8?B?RGRTLzBLbHhEWE56T2Z2bFBUSmZ0eDBxaUZxYk82NFBBSlhtQU90N0E1M1Ny?=
 =?utf-8?B?YUZSdmgxa2dlTnFJYU0wVGVYbzNNa0s0ZGRTeUFWSjB4RXhtNnpiajBhYlRB?=
 =?utf-8?B?MC8rczE4dGRRMXdXV2g1QVQ5cHViZkM5NWZaZTNmdk40UVJUZUNQV2VKSFdy?=
 =?utf-8?B?WFJaR055T25oQmM1M3pOYS94bkU4VVpKNGN2N096aEJPUEZ1R3BDTUR1SjBT?=
 =?utf-8?B?ZS9kUnd3WnpGMFBqS1RvS0dMaTF6bjA2eEp0RXlYcXRIajB4bStsK01WR2p1?=
 =?utf-8?B?aWVqR0ZYQndCdXBvUy94Qzloc1BhR21yblk0T2IrUk1IRnM4cURVdFJkZGky?=
 =?utf-8?B?dDNLR3JiNWRISHZOeDladlBDTWwzRjUyVnh0SE82SXo4UklEbHloZjQ5b3E1?=
 =?utf-8?B?Tm9YWXV0UFJYVVprWSsrcE5kVWNYTDBYMkE0SkxvNWNmaFk0aVVBZUQwUWxK?=
 =?utf-8?Q?Gbbf81S1pFKlnfuVlMpxaxBX4bhzZb0+sKPkozg?=
X-OriginatorOrg: ibt.cas.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8126d6-f29f-4471-c90f-08d98cb2f716
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0453.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:30:52.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: afc43190-4380-4550-938f-a93ad5a5695c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7R7bGx3vl0827HS7TcWd6zbtQVHy7AmGdcQsiy0D5UhfySxQkmDT2wBe1KNRCNcUbSri7fpHLTixRLmavV8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1339
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------ms050006080306060501000609
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

I have problem on production server with Btrfs. I got call trace in=20
dmesg with "No space left" message which led to the filesystem being=20
switched to read-only, but both df (system df and btrfs df) say I've got =

lots of space.

I read=20
[https://btrfs.wiki.kernel.org/index.php/Problem_FAQ#I_get_.22No_space_le=
ft_on_device.22_errors.2C_but_df_says_I.27ve_got_lots_of_space]=20
and tried "btrfs fi balance start -dusage=3DX /storage", where X I=20
gradually increased from 0 to 30. I also tried full-balance (btrfs=20
filesystem balance /storage), but without success.

[root@kappa ~]#   btrfs fi show
Label: 'data'  uuid: 12ce73fe-dccd-4059-b8d3-cd119dd8ef34
	Total devices 1 FS bytes used 6.35TiB
	devid    1 size 21.83TiB used 6.44TiB path /dev/md0


[root@kappa ~]# btrfs fi df /storage/
Data, single: total=3D6.26TiB, used=3D6.26TiB
System, DUP: total=3D8.00MiB, used=3D736.00KiB
Metadata, DUP: total=3D91.00GiB, used=3D89.08GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B


[root@kappa ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        158G     0  158G   0% /dev
tmpfs           158G     0  158G   0% /dev/shm
tmpfs           158G  9,5M  158G   1% /run
tmpfs           158G     0  158G   0% /sys/fs/cgroup
/dev/sdc2       894G  507G  386G  57% /
/dev/sdc1      1014M  306M  709M  31% /boot
/dev/md0         22T  6,5T   16T  30% /storage
tmpfs            32G     0   32G   0% /run/user/0



Btrfs use one MD device (SW RAID). Configuration of SW RAID:

[root@kappa ~]# cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4]
md0 : active raid5 sdd[1] sdb[0] sde[3]
       23437506560 blocks super 1.2 level 5, 512k chunk, algorithm 2=20
[3/3] [UUU]
       bitmap: 1/88 pages [4KB], 65536KB chunk
unused devices: <none>



I have no snapshots on this subvolume:

[root@kappa ~]# btrfs subvolume show /storage
/storage
	Name: 			<FS_TREE>
	UUID: 			-
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		-
	Subvolume ID: 		5
	Generation: 		503404
	Gen at creation: 	0
	Parent ID: 		0
	Top level ID: 		0
	Flags: 			-
	Snapshot(s):




[root@kappa ~]# uname -a
Linux kappa.ibt.biocev.org 3.10.0-1160.42.2.el7.x86_64 #1 SMP Tue Sep 7=20
14:49:57 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

[root@kappa ~]# btrfs --version
btrfs-progs v4.9.1


The whole message from dmesg:

[Oct10 03:39] ------------[ cut here ]------------
[ +0,000065] WARNING: CPU: 12 PID: 849 at fs/btrfs/extent-tree.c:6973=20
__btrfs_free_extent.isra.71+0x845/0xda0 [btrfs]
[ +0,000005] BTRFS: Transaction aborted (error -28)
[ +0,000003] Modules linked in: rbd libceph dns_resolver dm_mod=20
vhost_net vhost macvtap macvlan ipt_REJECT nf_reject_ipv4 tun bridge stp =

llc devlink ebtable_filter ebtables team_mode_loadbalance team=20
ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6=20
ip6table_filter ip6_tables xt_comment xt_multiport xt_conntrack=20
iptable_filter ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat=20
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack=20
xt_CHECKSUM iptable_mangle xfs ipmi_ssif amd64_edac_mod edac_mce_amd=20
kvm_amd kvm raid456 async_raid6_recov async_memcpy async_pq libcrc32c=20
async_xor async_tx irqbypass crc32_pclmul ghash_clmulni_intel=20
aesni_intel lrw gf128mul glue_helper ablk_helper cryptd joydev pcspkr sg =

ipmi_si ipmi_devintf ipmi_msghandler i2c_designware_platform pinctrl_amd =

i2c_designware_core
[ +0,000067] ccp k10temp i2c_piix4 acpi_cpufreq nfsd auth_rpcgss nfs_acl =

lockd grace sunrpc ip_tables btrfs xor raid6_pq sd_mod crc_t10dif=20
crct10dif_generic sr_mod cdrom uas usb_storage ast drm_kms_helper=20
syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ahci drm i40e mpt3sas=20
libahci igb libata crct10dif_pclmul crct10dif_common crc32c_intel=20
raid_class scsi_transport_sas ptp pps_core dca i2c_algo_bit=20
drm_panel_orientation_quirks nfit libnvdimm
[ +0,000060] CPU: 12 PID: 849 Comm: btrfs-transacti Kdump: loaded Not=20
tainted 3.10.0-1160.25.1.el7.x86_64 #1
[ +0,000004] Hardware name: Supermicro Super Server/H11SSL-C, BIOS 2.1=20
02/21/2020
[ +0,000005] Call Trace:
[ +0,000015] [<ffffffff8798311a>] dump_stack+0x19/0x1b
[ +0,000009] [<ffffffff8729b1b8>] __warn+0xd8/0x100
[ +0,000023] [<ffffffff8729b23f>] warn_slowpath_fmt+0x5f/0x80
[ +0,000036] [<ffffffffc0659dc5>]=20
__btrfs_free_extent.isra.71+0x845/0xda0 [btrfs]
[ +0,000043] [<ffffffffc06ce5e3>] ? btrfs_merge_delayed_refs+0x73/0x5e0=20
[btrfs]
[ +0,000030] [<ffffffffc065e91b>]=20
__btrfs_run_delayed_refs.constprop.79+0x9db/0x1340 [btrfs]
[ +0,000009] [<ffffffff8746be4e>] ? igrab+0x1e/0x60
[ +0,000026] [<ffffffffc0662333>] btrfs_run_delayed_refs+0x93/0x2e0 [btrf=
s]
[ +0,000025] [<ffffffffc066337d>]=20
btrfs_write_dirty_block_groups+0x17d/0x3e0 [btrfs]
[ +0,000031] [<ffffffffc067781b>] commit_cowonly_roots+0x25b/0x2e0 [btrfs=
]
[ +0,000034] [<ffffffffc067a5a9>]=20
btrfs_commit_transaction.part.24+0x499/0xa90 [btrfs]
[ +0,000030] [<ffffffffc06624b8>] ? btrfs_run_delayed_refs+0x218/0x2e0=20
[btrfs]
[ +0,000035] [<ffffffffc067abdb>] btrfs_commit_transaction+0x3b/0x70 [btr=
fs]
[ +0,000034] [<ffffffffc0674775>] transaction_kthread+0x205/0x230 [btrfs]=

[ +0,000033] [<ffffffffc0674570>] ?=20
btrfs_cleanup_transaction+0x580/0x580 [btrfs]
[ +0,000008] [<ffffffff872c5da1>] kthread+0xd1/0xe0
[ +0,000007] [<ffffffff872c5cd0>] ? insert_kthread_work+0x40/0x40
[ +0,000008] [<ffffffff87995de4>] ret_from_fork_nospec_begin+0xe/0x21
[ +0,000006] [<ffffffff872c5cd0>] ? insert_kthread_work+0x40/0x40
[ +0,000005] ---[ end trace 254665e8ba3c0e64 ]---
[ +0,000006] BTRFS: error (device md0) in __btrfs_free_extent:6973:=20
errno=3D-28 No space left
[ +0,000101] BTRFS info (device md0): forced readonly
[ +0,000006] BTRFS: error (device md0) in btrfs_run_delayed_refs:2971:=20
errno=3D-28 No space left
[ +0,385781] BTRFS warning (device md0): Skipping commit of aborted=20
transaction.
[ +0,000011] BTRFS: error (device md0) in cleanup_transaction:1851:=20
errno=3D-28 No space left

I'm quite desperate. What am I missing/overlooking?

Thank you for response

Regards,
Michal Strnad



--------------ms050006080306060501000609
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DUQwggZWMIIEPqADAgECAhEA4UndIhoJ6GHY0AfIvqwhNzANBgkqhkiG9w0BAQwFADBGMQsw
CQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQg
UGVyc29uYWwgQ0EgNDAeFw0yMTAyMTcwMDAwMDBaFw0yNDAyMTcyMzU5NTlaMIHdMQ8wDQYD
VQQREwYyNTIgNTAxMjAwBgNVBAoMKUJpb3RlY2hub2xvZ2lja8O9IMO6c3RhdiBBViDEjFIs
IHYuIHYuIGkuMRkwFwYDVQQJDBBQcsWvbXlzbG92w6EgNTk1MRwwGgYDVQQIDBNTdMWZZWRv
xI1lc2vDvSBrcmFqMQ8wDQYDVQQHEwZWZXN0ZWMxCzAJBgNVBAYTAkNaMRYwFAYDVQQDEw1N
aWNoYWwgU3RybmFkMScwJQYJKoZIhvcNAQkBFhhtaWNoYWwuc3RybmFkQGlidC5jYXMuY3ow
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXANBYdjCR7GT0yjrn05v9Kk5WfbSK
TT/csAtHXtZRlRJ6MksDPMJWG/OEDIhxIQzgSSXJ8/dboH4B0b/mqGOouyL+h2Dzx2C3lIAm
wUQ1b9zi0Mk6dD8grEH3Su2g6/16Yg4Pf1W/9EhW9JK69uFNQtSon88/5CSVVlSKt3tP2fVE
QHqCzjjo3ZnIlgF/ddjonBZdPMZ2isd/0WKrqNHfhcS7oEQzz7AkD3F0Ifm/rg8Qz+Z74oqH
t/xPC0Zm/rFvbRu+nvjRsdHQfZx8WMMvKQdoj3hJPR3RlirGhoTEwE8ZtCAHI8rXP0HFgkAo
1NcqsJxRT6L/VGRt1IV8wqdhAgMBAAGjggGlMIIBoTAfBgNVHSMEGDAWgBRpAKHHIVj44MUb
ILAK3adRvxPZ5DAdBgNVHQ4EFgQUKmhXu3sHZTajVutJhNYFX0KWwUAwDgYDVR0PAQH/BAQD
AgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMD8GA1Ud
IAQ4MDYwNAYLKwYBBAGyMQECAk8wJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNv
bS9DUFMwQgYDVR0fBDswOTA3oDWgM4YxaHR0cDovL0dFQU5ULmNybC5zZWN0aWdvLmNvbS9H
RUFOVFBlcnNvbmFsQ0E0LmNybDB4BggrBgEFBQcBAQRsMGowPQYIKwYBBQUHMAKGMWh0dHA6
Ly9HRUFOVC5jcnQuc2VjdGlnby5jb20vR0VBTlRQZXJzb25hbENBNC5jcnQwKQYIKwYBBQUH
MAGGHWh0dHA6Ly9HRUFOVC5vY3NwLnNlY3RpZ28uY29tMCMGA1UdEQQcMBqBGG1pY2hhbC5z
dHJuYWRAaWJ0LmNhcy5jejANBgkqhkiG9w0BAQwFAAOCAgEAbaKrJxJYO4foc8uAm+71gZP8
P11BYCmZNWoxNAtbRMdD4KmBeeF69GNt7fP/WmC1me2OdVOh2kZzfqhNAowD+5DCFWoukAGJ
QqqcEUzaoIB5KHwxZ5DPzRqwJwHPQCQriMTdgCr9CY2yTpcKs+U1/qzQE3DMsubhUjib05uk
PE18Lk72QiDaj/oFBHHako+KjBp1AssZ9YiUbvRZbk/FrcBPlJUHWUyqUOBGMO+cty3ivqK/
gornGJ56AP/qE0eIN5kG3U07V0a5avtu81nYgARHaKoIg1e/iqvrPPn4uMk1duVxJmYViWXu
akOpOTAEiGWFhaFuE5VbSKC6BlDqOxJpPat69mEAukEkvHpJz5aDxA2x+epxTZWvyRVRitTu
uoTKNr4Kmkmf6KGriQDSX2Rcmze3eH6pldJOivgMutWC6uOLHJuHRLrJ8zwhA95dFqrJ1FFJ
5lU98tU1+WNX49N/5oC6PFT5szDwFt8r7r50oohDweDkGIewKerrBhErkfDriF3N6bPRdH37
YWGor5gbgOhfX0H9w5mH+9pBnTfYZE0pl2lvW/EuonrFmp374sYVjHa6Vl5BgJxiK9vm2OUw
zzyuWYSz3FI+OHXdF7x+Eu3EOYe9b2MAGmP9e4Q0zDy3I8r8tRO4AEx0Cdw9plXYxhvC+bQh
oL33EyUmeZEwggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUA
MIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5
IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRy
dXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1
MDEyMzU5NTlaMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRww
GgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAs0riIl4nW+kEWxQENTIgFK600jFAxs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8
/3AQPYBo7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpwXgfCvnKxmq97/kQkOFX706F9O7/h0yeh
HhDjUdyMyT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSqadM3p+d0vvH/YrRMtOhkvGpLuzL8
m+LTAQWvQJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZzVKTNORvPrGPRLnJ0EEVCHR8
2LL6oz915WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusChSsZEn7juIsGIiDyaIhhL
sd3amm8BS3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8v7bPZiJRaT7ZC2f5
0P4lTlnbLvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZzR4MbpjTWdEd
SLKvz8+0wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zFp2pyYUOi
uzP+as/AZnz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbdsGac+
diahjEwzyB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQY
MBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ
5DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBz
Oi8vc2VjdGlnby5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRy
dXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEF
BQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1
c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0
LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110
Q+BABABglkrPkES/VyMZsfuds8fcDGvGE3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0
tDUoL01ugDdqwlyXuYizeXyH2ICAQfXMtS+raz7mf741CZvO50OxMUMxqljeRfVPDJQJNHOY
i2pxuxgjKDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tffjRKn8I1D1BmrDdWR/IdbBOj6870abYv
qys1qYlPotv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8BGdpEqyFVa+I0rpJPhaZkeWW7cImD
QFerHW9bKzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4NJjaMxpk+g2puNSm4b9uVjBb
PO9V6sFSG+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi8SKNohAOKnUc7RIP6ss1
hqIFyv0xXZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT9uSI2Xvhz8p+4pCY
kiZqpahZlHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbUvDM9slzZXdI7
NjJokVBq3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4RzadUxggM7
MIIDNwIBATBbMEYxCzAJBgNVBAYTAk5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRww
GgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhEA4UndIhoJ6GHY0AfIvqwhNzANBglghkgB
ZQMEAgEFAKCCAbEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjExMDExMTIzMDUwWjAvBgkqhkiG9w0BCQQxIgQghRTZR9zYgmsOOBNc63k1QkUttOtcntof
5BXZbJWIufAwagYJKwYBBAGCNxAEMV0wWzBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VB
TlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNAIRAOFJ3SIaCehh
2NAHyL6sITcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoG
CCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDBsBgsqhkiG9w0BCRACCzFdoFswRjELMAkGA1UEBhMCTkwxGTAXBgNVBAoT
EEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5UIFBlcnNvbmFsIENBIDQCEQDhSd0i
GgnoYdjQB8i+rCE3MA0GCSqGSIb3DQEBAQUABIIBADd7/zhMNyx/d3SnOQlRea71rg9D91WJ
4tHlyLMk0gcE4THDbKc8/CnVbwNYv68eWWaXehElUK8ah/7I8UNPANoGwjMvL92Y6BC+0e+b
kIfk2bqzDZCgyq0GNEMdYeC/4ODo3JSIpKxNf2cCyJVGUWwZaAfQbe8+z5Vf8X9YTAcMGtWJ
s5RVOh0SUB9JvAZP3ytwWJW+EkuzHRv2sQrph+LDseUyhhcoW9sWrhvas/GJXdCeoRTFA+O1
ZjnjEFEbGQWJKefO0fnpnxQUDYSU1Gpzui4wTD9NXgf8bIZQFVKgF6LKOC9zjoMDwAg0jS2h
wljFQ6wEmyuxOTwzioduvZMAAAAAAAA=

--------------ms050006080306060501000609--
