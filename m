Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7451945E078
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhKYSUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 13:20:50 -0500
Received: from vs2.lukas-pirl.de ([5.45.100.90]:43872 "EHLO pim.lukas-pirl.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233741AbhKYSSt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 13:18:49 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2021 13:18:49 EST
Received: from [192.168.178.54] (dslb-002-207-042-160.002.207.pools.vodafone-ip.de [2.207.42.160])
        by pim.lukas-pirl.de (Postfix) with ESMTPSA id C2945A0A5745
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 19:06:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lukas-pirl.de;
        s=201701; t=1637863615;
        bh=3dJRyEKsSqPunYKckFkrEesyQdNtRRYeOL+var47dmc=;
        h=Message-ID:Subject:From:To:Date:MIME-Version:From;
        b=RFGGLS4M+0sYm2RQ4LFngxUa4nEikRINnEpy/ILyJO97aNgJWKCB5SwNWruLCjeTn
         yArT+CRLK0MeJWMzitMyxJNC/eiCSBfd2O4k8srfEX9dmUkjuBRVS1H3AyWTgtjj2q
         OaXcJxj/rJbpSBSzRWMnWsLX9/L/6zoT/fEcdPIc9+OTy/YxSxLr/Ipk/Dkw856mid
         gFYHocKHQ3mKc+J+HZk7SOr2EoCF/FTPKoNwkj4djckN8S3WxzU2x/jikv3Yling4w
         69yqU4Fze/6bWx3noCqqKM3IZV44ZFJDwKlPHdZk8UfPhx8oMrTfIeGx+4JHBZFVAl
         SGji7/HaRihzJEaH2GkMuwcqJ6g6zhVtRHm/rUXdMFw+mHNH9IE7J3xoXabIenimk4
         7rGf7+izaTHjjZHtdRNuG35HqpsSxO7c16HZLiWj/QDD0npV+xKemxtHZ3sAq1YaC3
         +VP0K2o1ria/zn7j5zyIC2/FnPK3lfJsXHvzWtd5cXS16FwSowt/bxsEjSLX64ZqrC
         nWQn0BBI2oqdRQH1jNGwJjY0q35w9Oo2clSa9ldAw23WXbvSXtRAhUnIN0m1vDd+31
         xSuIUVzech8tfcwvmqrEzd+f/L70FygQQ+0Tk1DUXuvh5rb3Mi18NzBFHLhkKYcDE1
         w7SWWGYYcAcNOmQ6alcjgg9w=
Message-ID: <5a73c349971ff005640af3854667f492e0697724.camel@lukas-pirl.de>
Subject: Balance loop on "device delete missing"? (RAID 1, Linux 5.15,
 "found 1 extents, stage: update data pointers")
From:   Lukas Pirl <btrfs@lukas-pirl.de>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-BFngcPb19acrckOOXSnj"
Date:   Thu, 25 Nov 2021 19:06:55 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.42.0-2 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--=-BFngcPb19acrckOOXSnj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear btrfs community,

this is another report of a probably endless balance which loops on
"found 1 extents, stage: update data pointers".

I observe it on a btrfs RAID 1 on around 7 luks-encrypted spinning
disks (more fs details below) used for storing cold data. One disk
failed physically. Now, I try to "btrfs device delete missing". The
operation runs forever (probably, waited more than 30 days, another
time more than 50 days).

dmesg says:
[      22:26] BTRFS info (device dm-1): relocating block group 110920466432=
0 flags data|raid1
[      22:27] BTRFS info (device dm-1): found 4164 extents, stage: move dat=
a extents
[  +5.476247] BTRFS info (device dm-1): found 4164 extents, stage: update d=
ata pointers
[  +2.545299] BTRFS info (device dm-1): found 1 extents, stage: update data=
 pointers

and then the last message repeats every ~ .25 seconds ("forever").
Memory and CPU usage are not excessive (most is IO wait, I assume).

What I have tried:
* Linux 4 (multiple minor versions, don't remember which exactly)
* Linux 5.10
* Linux 5.15
* btrfs-progs v5.15
* remove subvolues (before: ~ 200, after: ~ 90)
* free space cache v1, v2, none
* reboot, restart removal/balance (multiple times)

How can we find the problem here to make btrfs an even more stable
file system in the future?
(The particular fs has been created 2016, I am otherwise happy with
btrfs and advocating; BTW I have backups and are ready to use them)

Another question I was asking myself: can btrfs be forced to forget
about a device (as in "delete from meta data) to then just run a
regular balance?

Thanks in advance; I hope we can debug this.

Lukas

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

filesystem show
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Label: 'pool_16-03'  uuid: 59301fea-434a-xxxx-bb45-08fcfe8ce113
	Total devices 8 FS bytes used 3.84TiB
	devid    1 size 931.51GiB used 592.00GiB path /dev/mapper/WD-
WCAU45xxxx03
	devid    3 size 1.82TiB used 1.37TiB path /dev/mapper/WD-WCAZAFxxxx78
	devid    4 size 931.51GiB used 593.00GiB path /dev/mapper/WD-
WCC4J7xxxxSZ
	devid    5 size 1.82TiB used 1.46TiB path /dev/mapper/WD-WCC4M2xxxxXH
	devid    7 size 931.51GiB used 584.00GiB path /dev/mapper/S1xxxxJ3
	devid    9 size 2.73TiB used 2.28TiB path /dev/mapper/WD-WCC4N3xxxx17
	devid   10 size 3.64TiB used 1.03TiB path /dev/mapper/WD-WCC7K2xxxxNS
	*** Some devices missing

subvolumes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

~ 90, of which ~ 60 are read-only snapshots of the other ~ 30

filesystem usage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Overall:
    Device size:		  12.74TiB
    Device allocated:		   8.36TiB
    Device unallocated:		   4.38TiB
    Device missing:		     0.00B
    Used:			   7.69TiB
    Free (estimated):		   2.50TiB	(min: 2.50TiB)
    Free (statfs, df):		   1.46TiB
    Data ratio:			      2.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 48.00KiB)
    Multiple profiles:		        no

Data,RAID1: Size:4.14TiB, Used:3.82TiB (92.33%)
   /dev/mapper/WD-WCAU45xxxx03	 584.00GiB
   /dev/mapper/WD-WCAZAFxxxx78	   1.35TiB
   /dev/mapper/WD-WCC4J7xxxxSZ	 588.00GiB
   /dev/mapper/WD-WCC4M2xxxxXH	   1.44TiB
   missing	 510.00GiB
   /dev/mapper/S1xxxxJ3	 579.00GiB
   /dev/mapper/WD-WCC4N3xxxx17	   2.26TiB
   /dev/mapper/WD-WCC7K2xxxxNS	   1.01TiB

Metadata,RAID1: Size:41.00GiB, Used:23.14GiB (56.44%)
   /dev/mapper/WD-WCAU45xxxx03	   8.00GiB
   /dev/mapper/WD-WCAZAFxxxx78	  17.00GiB
   /dev/mapper/WD-WCC4J7xxxxSZ	   5.00GiB
   /dev/mapper/WD-WCC4M2xxxxXH	  13.00GiB
   missing	   3.00GiB
   /dev/mapper/S1xxxxJ3	   5.00GiB
   /dev/mapper/WD-WCC4N3xxxx17	  16.00GiB
   /dev/mapper/WD-WCC7K2xxxxNS	  15.00GiB

System,RAID1: Size:32.00MiB, Used:848.00KiB (2.59%)
   missing	  32.00MiB
   /dev/mapper/WD-WCC4N3xxxx17	  32.00MiB

Unallocated:
   /dev/mapper/WD-WCAU45xxxx03	 339.51GiB
   /dev/mapper/WD-WCAZAFxxxx78	 461.01GiB
   /dev/mapper/WD-WCC4J7xxxxSZ	 338.51GiB
   /dev/mapper/WD-WCC4M2xxxxXH	 373.01GiB
   missing	-513.03GiB
   /dev/mapper/S1xxxxJ3	 347.51GiB
   /dev/mapper/WD-WCC4N3xxxx17	 460.47GiB
   /dev/mapper/WD-WCC7K2xxxxNS	   2.61TiB

dump-super
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

superblock: bytenr=3D65536, device=3D/dev/mapper/WD-WCAU45xxxx03
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x51beb068 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			59301fea-434a-xxxx-bb45-08fcfe8ce113
metadata_uuid		59301fea-434a-xxxx-bb45-08fcfe8ce113
label			pool_16-03
generation		113519755
root			15602414796800
sys_array_size		129
chunk_root_generation	63394299
root_level		1
chunk_root		19216820502528
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		16003136864256
bytes_used		4227124142080
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		8
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x371
			( MIXED_BACKREF |
			  COMPRESS_ZSTD |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	2975866
uuid_tree_generation	113519755
dev_item.uuid		a9b2e4ea-404c-xxxx-a450-dc84b0956ce1
dev_item.fsid		59301fea-434a-xxxx-bb45-08fcfe8ce113 [match]
dev_item.type		0
dev_item.total_bytes	1000201740288
dev_item.bytes_used	635655159808
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

device stats
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[/dev/mapper/WD-WCAU45xxxx03].write_io_errs    0
[/dev/mapper/WD-WCAU45xxxx03].read_io_errs     0
[/dev/mapper/WD-WCAU45xxxx03].flush_io_errs    0
[/dev/mapper/WD-WCAU45xxxx03].corruption_errs  0
[/dev/mapper/WD-WCAU45xxxx03].generation_errs  0
[/dev/mapper/WD-WCAZAFxxxx78].write_io_errs    0
[/dev/mapper/WD-WCAZAFxxxx78].read_io_errs     0
[/dev/mapper/WD-WCAZAFxxxx78].flush_io_errs    0
[/dev/mapper/WD-WCAZAFxxxx78].corruption_errs  0
[/dev/mapper/WD-WCAZAFxxxx78].generation_errs  0
[/dev/mapper/WD-WCC4J7xxxxSZ].write_io_errs    0
[/dev/mapper/WD-WCC4J7xxxxSZ].read_io_errs     1
[/dev/mapper/WD-WCC4J7xxxxSZ].flush_io_errs    0
[/dev/mapper/WD-WCC4J7xxxxSZ].corruption_errs  0
[/dev/mapper/WD-WCC4J7xxxxSZ].generation_errs  0
[/dev/mapper/WD-WCC4M2xxxxXH].write_io_errs    0
[/dev/mapper/WD-WCC4M2xxxxXH].read_io_errs     0
[/dev/mapper/WD-WCC4M2xxxxXH].flush_io_errs    0
[/dev/mapper/WD-WCC4M2xxxxXH].corruption_errs  0
[/dev/mapper/WD-WCC4M2xxxxXH].generation_errs  0
[devid:6].write_io_errs    0
[devid:6].read_io_errs     0
[devid:6].flush_io_errs    0
[devid:6].corruption_errs  72016
[devid:6].generation_errs  100
[/dev/mapper/S1xxxxJ3].write_io_errs    0
[/dev/mapper/S1xxxxJ3].read_io_errs     0
[/dev/mapper/S1xxxxJ3].flush_io_errs    0
[/dev/mapper/S1xxxxJ3].corruption_errs  2
[/dev/mapper/S1xxxxJ3].generation_errs  0
[/dev/mapper/WD-WCC4N3xxxx17].write_io_errs    0
[/dev/mapper/WD-WCC4N3xxxx17].read_io_errs     0
[/dev/mapper/WD-WCC4N3xxxx17].flush_io_errs    0
[/dev/mapper/WD-WCC4N3xxxx17].corruption_errs  0
[/dev/mapper/WD-WCC4N3xxxx17].generation_errs  0
[/dev/mapper/WD-WCC7K2xxxxNS].write_io_errs    0
[/dev/mapper/WD-WCC7K2xxxxNS].read_io_errs     0
[/dev/mapper/WD-WCC7K2xxxxNS].flush_io_errs    0
[/dev/mapper/WD-WCC7K2xxxxNS].corruption_errs  0
[/dev/mapper/WD-WCC7K2xxxxNS].generation_errs  0

--=-BFngcPb19acrckOOXSnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIfDl2cvwrHf6TgsUf2MCUJXpoBgFAmGf0L4ACgkQf2MCUJXp
oBhxRA//VuJg2sujrjvDvzNKmxj+bXp6TSuc3rzqqEDftjVh75k045bYg8dehn+O
tFRFCx1SXKNXSclRJI9OcEZo5OrwWKeA1/keivHyYOH3pjJmVh9XZaGqC1n2kJ+H
staor/vb5efJjn29WdeKnLRCK565RcTAzixVmb2cQAjzuEpjX007hahSgK20pJaH
C9tBjmmcso1yEzoPXiQEcyqtDbv6FddrarjMPlTILPxiHf3KmcwqNaRHQ+dDfBTr
JuHLC03AG9pxZb2T8PV5RZ0TLROf/SQfXG/F1SnCRFSt2s/hMkF4cyLsJfU0ZsbC
Uqorixssx6H9kv6yB6cminjje851TDX9L4TKr3LVgPKQ37P34lUtN+l5ToLY0+T9
SRJ8jHKQx/5SB9T9IUr0eSCErdt2RrnByQQy27xkAIzxc2Z5/BBIPFYK8OIBUT9a
Ssn4Pgn4c/trS/WE53pIrMIHEa8MTP9wS3a62RhJlkdmq8SRIeB/J2m20TMv/qC4
M8NlGXU0HOFhjSUJKsOJI+9kHkTXHdFJ6PzqExahvS6RxFWXqo5oxAJBWeB6gp9l
oqTfJC5Ssfc8LlPavxNfmkvfB9g5qZLNvaG6UnA0SA43R3+2Eu86bYy0ZHOAwhke
emAfnySP6yji01VE+ORlyyk5fxPHXpXWAI07+wQKqm6JDf/j2BU=
=5oFF
-----END PGP SIGNATURE-----

--=-BFngcPb19acrckOOXSnj--
