Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410BF3C1C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 05:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfFKDzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 23:55:18 -0400
Received: from bisque.elm.relay.mailchannels.net ([23.83.212.18]:36121 "EHLO
        bisque.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391020AbfFKDzR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 23:55:17 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 23:55:15 EDT
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 937042C19E4;
        Tue, 11 Jun 2019 03:47:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (100-96-88-48.trex.outbound.svc.cluster.local [100.96.88.48])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EC9D82C1ACF;
        Tue, 11 Jun 2019 03:47:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a21.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Tue, 11 Jun 2019 03:47:23 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Stretch: 4e60e78842a922ee_1560224843495_428989382
X-MC-Loop-Signature: 1560224843495:2746705045
X-MC-Ingress-Time: 1560224843494
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTP id 95AAC824F2;
        Mon, 10 Jun 2019 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=HKSp7cPRSJC3RPNVvFA/VmEHEPU=; b=
        WfiJU1h/xOwJbGgoDwRWcdS4WC8cWx15zG7v82x5HqARR85V/eSpwlNv2dg+8WOD
        OcYuJwa8XAdBE+ZKX3c4uTSOaKUnuci5QGeO8NMLpDeNOlpEdI6TXsmPcdxSJaWW
        54/KkxJnpZQwuoG5h0XjLDeuKm1B6W3fVy2xpthHGHI=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTPSA id EB9F881CA4;
        Mon, 10 Jun 2019 20:47:16 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a21
From:   Eric Mesa <eric@ericmesa.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Mon, 10 Jun 2019 23:47:11 -0400
Message-ID: <2339083.MuzE7HVQJs@supermario.mushroomkingdom>
In-Reply-To: <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3062682.GcRMS7UVSK"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgesghdtreertddtvdenucfhrhhomhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqeenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart3062682.GcRMS7UVSK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 10, 2019 9:10:17 PM EDT Chris Murphy wrote:
> On Mon, Jun 10, 2019 at 6:03 PM Eric Mesa <eric@ericmesa.com> wrote:
> > When I did the btrfs send / receive for SSDHome it took 2.5 days to send
> > ~500GiB over a 1GBps cable to the 3GBps drive in the server. It also had
> > the error:
> > ERROR: failed to clone extents to ermesa/.cache/krunner/
> > bookmarkrunnerfirefoxfavdbfile.sqlite: Invalid argument
> 
> While there are distinct send and receive errors possible, I'm not
> familiar with recognizing them. You can get a better idea what the
> problem is with -vv or -vvv to get a more verbose error on the side
> that's having the problem. My guess is this is a send error message.
> 
> > Let's say that snapshot A is a snapshot sent to the server without -p. It
> > sends the entire 500GB for 18 hours.
> > 
> > Then I do snapshot B. I send it with -p - takes 15 minutes or so depending
> > on how much data I've added.
> > 
> > Then I do snapshot C - and here I always get an error.
> 
> It's most useful if you show exact commands because actually it's not
> always obvious to everyone what the logic should be and the error
> handling doesn't always stop a user from doing something that doesn't
> make a lot of sense. We need to know the name of the rw subvolume; the
> command to snapshot it; the full send/receive command for that first
> snapshot; the command for a subsequent snapshot; and the command to
> incrementally send/receive it.
> 

OK, here's an example from when it failed, although I didn't save the error - 
I'm just looking at my history for a time it failed:

#btrfs sub snap -r /home/ /home/.snapshots/2019-06-08-1437
#cd /home/.snapshots/
#btrfs send -p /home/.snapshots/2019-06-05-postdefrag/ 2019-06-08-1437/ | ssh 
#root@tanukimario btrfs receive /media/backups/backups1/supermario-home
#btrfs sub snap -r /home/ /home/.snapshots/2019-06-09-1415
#btrfs send -p 2019-06-08-1437/ 2019-06-09-1415/ | ssh root@tanukimario btrfs 
receive /media/backups/backups1/supermario-home



> > And it always is something like:
> > 
> > ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
> > bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 ->
> > ermesa/.mozilla/ firefox/n35gu0fb.default/bookmarkbackups/
> > bookmarks-2019-06-08_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 failed: No such
> > file or directory
> > 
> > 
> > 
> > It always involves either .cache or .mozilla - the types of files that are
> > constantly changing.
> > 
> > It doesn't matter if I do a defrag before snapshot C followed by the sync
> > command. It seems that for SSDHome I can only do one full snap send and
> > then one parent send.
> 
> I don't actually know the status of snapshot aware defragmentation. It
> wasn't there, then it was there, then there were problems, and I think
> it was pulled rather than fixed. But I don't remember really. I also
> don't know if there's a difference between manual defragging and
> autodefrag, because I don't use either one. I do use reflinks. And I
> have done deduplication. And I don't have any send/receive failures. I
> do sometimes see slow sections of send/receive.
> 
> > Again, so far it seems to be working fine with the other drives which
> > seems to suggest to me that it's maybe not the version of my kernel or
> > btrfs progs or anything else.
> 
> Do you remember the mkfs command for this file system? Or also helpful would
> be:
> 
> # btrfs insp dump-s -f /dev/X  ## for both send and receive side file
> system (only one device from each Btrfs volume is needed), this will
> give us an idea what the mkfs options were including feature flags.
> 

for the sender:
btrfs insp dump-s -f /dev/sdb1 
superblock: bytenr=65536, device=/dev/sdb1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xa7282fe2 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    1080b060-4f1d-4b72-8544-ada43ec3cb54
metadata_uuid           1080b060-4f1d-4b72-8544-ada43ec3cb54
label                   SSDHome
generation              3034047
root                    373805891584
sys_array_size          194
chunk_root_generation   3008316
root_level              1
chunk_root              1010940559360
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             1000203091968
bytes_used              648933253120
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        3034047
uuid_tree_generation    3034047
dev_item.uuid           61b1e688-5aad-4dff-95b7-2500c08aefb4
dev_item.fsid           1080b060-4f1d-4b72-8544-ada43ec3cb54 [match]
dev_item.type           0
dev_item.total_bytes    1000203091968
dev_item.bytes_used     864416694272
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576)
                length 4194304 owner 2 stripe_len 65536 type SYSTEM
                io_align 4096 io_width 4096 sector_size 4096
                num_stripes 1 sub_stripes 0
                        stripe 0 devid 1 offset 1048576
                        dev_uuid 61b1e688-5aad-4dff-95b7-2500c08aefb4
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 1010940510208)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 1 sub_stripes 1
                        stripe 0 devid 1 offset 710839107584
                        dev_uuid 61b1e688-5aad-4dff-95b7-2500c08aefb4
backup_roots[4]:
        backup 0:
                backup_tree_root:       373802975232    gen: 3034046    level: 
1
                backup_chunk_root:      1010940559360   gen: 3008316    level: 
1
                backup_extent_root:     373801369600    gen: 3034046    level: 
2
                backup_fs_root:         982774349824    gen: 2278090    level: 
0
                backup_dev_root:        38486016        gen: 3033103    level: 
1
                backup_csum_root:       373801058304    gen: 3034046    level: 
2
                backup_total_bytes:     1000203091968
                backup_bytes_used:      648933277696
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       373805891584    gen: 3034047    level: 
1
                backup_chunk_root:      1010940559360   gen: 3008316    level: 
1
                backup_extent_root:     373805121536    gen: 3034047    level: 
2
                backup_fs_root:         982774349824    gen: 2278090    level: 
0
                backup_dev_root:        38486016        gen: 3033103    level: 
1
                backup_csum_root:       373804859392    gen: 3034047    level: 
2
                backup_total_bytes:     1000203091968
                backup_bytes_used:      648933253120
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       373804662784    gen: 3034044    level: 
1
                backup_chunk_root:      1010940559360   gen: 3008316    level: 
1
                backup_extent_root:     373803008000    gen: 3034044    level: 
2
                backup_fs_root:         982774349824    gen: 2278090    level: 
0
                backup_dev_root:        38486016        gen: 3033103    level: 
1
                backup_csum_root:       373796159488    gen: 3034044    level: 
2
                backup_total_bytes:     1000203091968
                backup_bytes_used:      648933285888
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       373800550400    gen: 3034045    level: 
1
                backup_chunk_root:      1010940559360   gen: 3008316    level: 
1
                backup_extent_root:     373800271872    gen: 3034045    level: 
2
                backup_fs_root:         982774349824    gen: 2278090    level: 
0
                backup_dev_root:        38486016        gen: 3033103    level: 
1
                backup_csum_root:       373799960576    gen: 3034045    level: 
2
                backup_total_bytes:     1000203091968
                backup_bytes_used:      648933298176
                backup_num_devices:     1


for receiver:
superblock: bytenr=65536, device=/dev/sdc1
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x47edc62b [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    e1bc05b0-6fad-4f1a-9586-26a461b65d57
metadata_uuid           e1bc05b0-6fad-4f1a-9586-26a461b65d57
label                   Backups1
generation              15013
root                    368023306240
sys_array_size          129
chunk_root_generation   14915
root_level              1
chunk_root              22020096
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             4000785104896
bytes_used              2350642929664
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        15013
uuid_tree_generation    15013
dev_item.uuid           6640d884-bcf6-4f0c-8d97-a31d72133a76
dev_item.fsid           e1bc05b0-6fad-4f1a-9586-26a461b65d57 [match]
dev_item.type           0
dev_item.total_bytes    4000785104896
dev_item.bytes_used     2509351419904
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
                length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 0
                        stripe 0 devid 1 offset 22020096
                        dev_uuid 6640d884-bcf6-4f0c-8d97-a31d72133a76
                        stripe 1 devid 1 offset 30408704
                        dev_uuid 6640d884-bcf6-4f0c-8d97-a31d72133a76
backup_roots[4]:
        backup 0:
                backup_tree_root:       368023109632    gen: 15010      level: 
1
                backup_chunk_root:      22020096        gen: 14915      level: 
1
                backup_extent_root:     368023158784    gen: 15010      level: 
2
                backup_fs_root:         30621696        gen: 7  level: 0
                backup_dev_root:        499089408       gen: 14915      level: 
1
                backup_csum_root:       368016621568    gen: 15010      level: 
3
                backup_total_bytes:     4000785104896
                backup_bytes_used:      2350286446592
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       368024518656    gen: 15011      level: 
1
                backup_chunk_root:      22020096        gen: 14915      level: 
1
                backup_extent_root:     368024551424    gen: 15011      level: 
2
                backup_fs_root:         30621696        gen: 7  level: 0
                backup_dev_root:        499089408       gen: 14915      level: 
1
                backup_csum_root:       368024682496    gen: 15011      level: 
3
                backup_total_bytes:     4000785104896

                backup_total_bytes:     4000785104896
                backup_bytes_used:      2350642929664
                backup_num_devices:     1



> > And dmesg.log is attached
> 
> [    6.949347] BTRFS info (device sdb1): enabling auto defrag
> 
> Could be related. And then also
> 
> [    9.906695] usb-storage 8-1.3:1.0: USB Mass Storage device detected
> [    9.907006] scsi host7: usb-storage 8-1.3:1.0
> [   10.950446] scsi 7:0:0:0: Direct-Access     B&N      NOOK
>   0322 PQ: 0 ANSI: 2
> [   10.951110] sd 7:0:0:0: Attached scsi generic sg7 type 0
> [   10.951161] sd 7:0:0:0: Power-on or device reset occurred
> [   10.952880] sd 7:0:0:0: [sdg] Attached SCSI removable disk
> snip
> [  267.794434] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
> using xhci_hcd
> [  272.838054] usb 9-1.1: device descriptor read/8, error -110
> [  272.941832] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
> using xhci_hcd
> [  277.958049] usb 9-1.1: device descriptor read/8, error -110
> [  278.236339] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
> using xhci_hcd
> 
> 
> USB enclosed drives can be troublesome with any file system, expressly
> because of these seemingly random reset that happen. I had the same
> thing in an early form of my setup, and it did cause me problems that
> Btrfs worked around. But I considered it untenable and fixed it with a
> good quality self-powered USB hub (don't rely on bus power), or
> perhaps more specifically one that comes with a high amp power
> adapter. It needs to be able to drive all the drives in their
> read/write usage, which for laptop drives is ~0.35A each.
> 
> You really shouldn't be getting link resets like the above, even
> though I suspect it's unrelated to the current problem report.

the drives in question aren't USB. That's for a USB3 hub that I use for my SD 
cards.
-- 
--
Eric Mesa
--nextPart3062682.GcRMS7UVSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAlz/JD8ACgkQ2bE1K6FA
nEXSVQf+JIws4OrncV8QYFUCQUTAm39X5Sa5r1H8Cjk4o0uyfww6Ya7NQj8OQ0G6
Q2chHoKOo150oSn4sWhiD9b/TG/p71pMKjaovqihKvZH4zLGPSScNY69mtkiqDdn
QFHJyKoH7hkEoj3+c25Z6emx3Sh6Tp1PYMAbdOZzcMM7YMOt0v6tlQWtWSLH2D7U
bYZvATed87N/Ig20u1JQ6qMLXn/Mn1TQDGh/fQG7lU+dbpdWQ/aTuu4Y+YT6qjqo
YY97o5DSuFSeuJPA7F//NsXZcszoK7Y4A2J6owiigOTgUAzLep37naYOoJVlj9cg
A3T80YwnKf+HJOs/KTCgw2ttzJhL5g==
=ORB8
-----END PGP SIGNATURE-----

--nextPart3062682.GcRMS7UVSK--



