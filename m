Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70002447D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfFMRCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 13:02:20 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48]:29189 "EHLO
        dog.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729513AbfFLXLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 19:11:25 -0400
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6F7881A1D9A;
        Wed, 12 Jun 2019 23:11:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a7.g.dreamhost.com (100-96-4-95.trex.outbound.svc.cluster.local [100.96.4.95])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ABA981A1F0C;
        Wed, 12 Jun 2019 23:11:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a7.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Wed, 12 Jun 2019 23:11:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Ski: 15308a2a23b1ae2b_1560381082122_3597129851
X-MC-Loop-Signature: 1560381082122:430797551
X-MC-Ingress-Time: 1560381082121
Received: from pdx1-sub0-mail-a7.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a7.g.dreamhost.com (Postfix) with ESMTP id 6157F8095A;
        Wed, 12 Jun 2019 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type; s=ericmesa.com; bh=tmRm5DXvigXxAUyDxY1c7O51Agk=; b=
        CHQtJOITJu/xokyECKqnCFxKic819ymavuC5Zbq6Dm9PqQ3dg0AsTzR0o6kDRVM3
        LKBwUqA/JhGAryhTImDyrSzW6+/pUsviWS/OH4qinr5gnpEVdnWNpTtuHXdTifT1
        Qpxh3M9Ce3HM8A35l9XC2KL5vdSQFlU8a9pSA2CYfs4=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 55FE88159B;
        Wed, 12 Jun 2019 16:11:15 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a7
From:   Eric Mesa <eric@ericmesa.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Issues with btrfs send/receive with parents
Date:   Wed, 12 Jun 2019 19:11:13 -0400
Message-ID: <5014147.MKuq1TLFdm@supermario.mushroomkingdom>
In-Reply-To: <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom> <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com> <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2280921.j9pHq33knr"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehkedgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgesghdtreertddtvdenucfhrhhomhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqeenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2280921.j9pHq33knr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, June 12, 2019 7:03:04 PM EDT Eric Mesa wrote:
> 
> On the source disk:
> 
> # btrfs subvolume list -qRu /home
> ID 822 gen 3042780 top level 5 parent_uuid c6101e57-acd3-e54c-a957-
> b2b6a033bc42 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> 7247f4a0-6ea2-0d49-b5c5-1ea2ecb8980a path home
> ID 823 gen 3042727 top level 822 parent_uuid -
> received_uuid -                                    uuid f83e53b6-dc88-1a44-
> a5e8-f220d5d21083 path .snapshots
> ID 2515 gen 3008316 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> 8ef83478-86be-8a47-a425-1dc6957a0fbe path .snapshots/2019-06-05-postdefrag
> ID 2516 gen 3021663 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> cbb67aec-02ed-8247-afee-38ae94555471 path .snapshots/2019-06-08-1437
> ID 2518 gen 3027353 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> ca361150-1050-5844-bff7-de5c89b5cc05 path .snapshots/2019-06-09-1550
> ID 2519 gen 3028168 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> 5fa82b5e-59e1-2549-a939-5dabc99c0f2a path .snapshots/2019-06-09-1944
> ID 2520 gen 3032614 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> df437aaf-0f40-344e-8302-932ea8e5f197 path .snapshots/2019-06-10-1718
> ID 2521 gen 3034140 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid
> 2b985685-d88b-784a-b870-8f5f8fcdd08c path .snapshots/2019-06-10-2353
> 
> 
> On the destination disk: (I deleted 2019-06-2353 since it wasn't a valid
> backup and I didn't want to get confused when determining which backups I
> could delete)
> 
> btrfs subvolume list -qRu /media/backups/backups1/supermario-home
> ID 257 gen 15047 top level 5 parent_uuid -
> received_uuid -                                    uuid 5d93ca75-
> f423-9840-893e-6324f7e79e02 path backups
> ID 258 gen 15049 top level 257 parent_uuid -
> received_uuid -                                    uuid 8b60359a-9525-4044-
> ac04-4982f1f1fe3a path backups/supermario-home
> ID 826 gen 14290 top level 257 parent_uuid -
> received_uuid -                                    uuid c7dc0373-7e2a-bb44-
> b32c-172aac73b8a7 path backups/VG_ROMs
> ID 827 gen 4313 top level 826 parent_uuid -
> received_uuid a85853e1-848f-ac46-93c6-da5035cc8042 uuid 0ef9b4f9-
> f8b6-8943-8714-38e9376019bf path backups/VG_ROMs/2017-01-21-original
> ID 1021 gen 4334 top level 826 parent_uuid 0ef9b4f9-
> f8b6-8943-8714-38e9376019bf received_uuid
> c7356dd2-9fa3-1141-8433-4ba96e4cdcd6 uuid
> 8c46bc72-9738-d24e-bb9a-c1edcf7a4755 path backups/VG_ROMs/2019-05-30 ID
> 1024 gen 15048 top level 257 parent_uuid -
> received_uuid -                                    uuid bc92cd25-cf4b-
> d24c-8cf5-ddb0df654e05 path backups/Comics
> ID 1025 gen 9890 top level 1024 parent_uuid -
> received_uuid fd3e9edb-854a-4143-993e-e2a8bbd4cedb uuid
> 7a5bd7be-43aa-7f44-9443-ff96cf575175 path backups/Comics/2019-05-30
> ID 1027 gen 4336 top level 826 parent_uuid 8c46bc72-9738-d24e-bb9a-
> c1edcf7a4755 received_uuid -                                    uuid
> 85b5572b- edc3-6d48-8b4d-3c956cae2da5 path backups/VG_ROMs/ROMs_NFS-orig
> ID 1602 gen 15047 top level 257 parent_uuid -
> received_uuid -                                    uuid 13ab4679-
> eccb-6544-8176-6f494236f1c9 path backups/Archive
> ID 1603 gen 9964 top level 1602 parent_uuid -
> received_uuid 3c48ee45-4454-2f4a-86b7-5c498ffb784d uuid ab3efbd4-e78f-f745-
> b401-b653e0ad6667 path backups/Archive/2019-06-01
> ID 2726 gen 10165 top level 1024 parent_uuid 7a5bd7be-43aa-7f44-9443-
> ff96cf575175 received_uuid 0df42045-b04a-5f43-924e-69b39e1b3ce6 uuid
> f46a045c-41c4-c543-ba5f-948b97e43746 path backups/Comics/2019-06-03
> ID 2728 gen 12315 top level 1602 parent_uuid ab3efbd4-e78f-f745-b401-
> b653e0ad6667 received_uuid 649d6bec-9f54-2a44-8fed-8e6e9c054f8c uuid
> 255c8dc8-8d61-9342-9f3c-af06fe82daf6 path backups/Archive/2019-06-03
> ID 2732 gen 10171 top level 1024 parent_uuid f46a045c-41c4-c543-
> ba5f-948b97e43746 received_uuid a3a6b2d9-0b30-a342-bafb-6a3a70258994 uuid
> 0cb98f03-0152-494c-935f-d6af45cf23dd path backups/Comics/2019-06-03p2
> ID 2977 gen 12337 top level 1602 parent_uuid 255c8dc8-8d61-9342-9f3c-
> af06fe82daf6 received_uuid 1404041e-6456-2641-a35a-f30f08baf250 uuid
> 42eb5475-1b2f-8948-8333-b8a1267455e0 path backups/Archive/2019-06-05
> ID 2983 gen 15033 top level 258 parent_uuid -
> received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 path 2019-06-05-postdefrag
> ID 3545 gen 14310 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14
> uuid 26791559-bd47-e44f-9e2f-0ea258615429 path 2019-06-08-1437
> ID 3550 gen 14878 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14
> uuid 7c9787bc-fbc4-c146-b88b-e5dd10918eaa path 2019-06-09-1944
> ID 3582 gen 15012 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14
> uuid 44963c1e-7bc7-f34a-9370-ce180ce05b69 path 2019-06-10-1718
> 
> --
> Eric Mesa


I'm sure you guys already noticed this if you saw the email I sent about 5 
minutes ago, but I did a comparison between my /home directory (which is 
giving me issues) and /media/Photos and /media/NotHome which are not giving me 
issues with that command you ahd me type - btrfs subvolume list -qRu. Turns 
out that my snapshots in home all have a parent listed, but those other 
directories don't. 

For example:

# btrfs subvolume list -qRu /media/Photos/
ID 257 gen 328447 top level 5 parent_uuid -                                    
received_uuid -                                    uuid e638e583-eaf5-6a47-
a6e2-1e34d65146df path photos
ID 2666 gen 326598 top level 257 parent_uuid -                                    
received_uuid -                                    uuid 
15da54cb-0183-8648-9662-f500e9c82c23 path .Snapshots
ID 2667 gen 159288 top level 2666 parent_uuid e638e583-eaf5-6a47-
a6e2-1e34d65146df received_uuid -                                    uuid 
31e34d12-3dc1-794b-aa05-58990085069b path .Snapshots/2017-02-04
ID 5663 gen 322711 top level 2666 parent_uuid e638e583-eaf5-6a47-
a6e2-1e34d65146df received_uuid -                                    uuid 
786e2521-1877-9a46-b16b-aa4944d2cac6 path .Snapshots/2019-06-06
ID 5666 gen 326550 top level 2666 parent_uuid e638e583-eaf5-6a47-
a6e2-1e34d65146df received_uuid -                                    uuid 
97282c24-9cf0-c34e-91ba-b49a876e139c path .Snapshots/2019-06-09
ID 5667 gen 326582 top level 2666 parent_uuid e638e583-eaf5-6a47-
a6e2-1e34d65146df received_uuid -                                    uuid 
9cd6222a-cc77-9649-a9de-3c3e26514bf7 path .Snapshots/2019-06-10-1953

or 

# btrfs subvolume list -qRu /media/NotHome/
ID 1213 gen 122104 top level 1528 parent_uuid -                                    
received_uuid -                                    uuid 5cc42609-193a-
d341-9d76-b220093d572e path Snapshots/Torrents_RO
ID 1528 gen 183718 top level 5 parent_uuid -                                    
received_uuid -                                    uuid bb843dbe-ba8c-2045-
b548-7c799ea5646f path Snapshots
ID 1529 gen 184443 top level 5 parent_uuid 1331b71c-
ac2e-6d4d-91d6-55565534e87c received_uuid -                                    
uuid b4f18ee4-636a-3744-8869-8002c70ae707 path Archive
ID 1530 gen 184023 top level 5 parent_uuid 
17a1a4c0-76e2-7345-8123-6b5852f96a3a received_uuid -                                    
uuid 11d61ab5-ec8f-f741-a7f8-fa7d2d270431 path Handbrake
ID 1531 gen 184027 top level 5 parent_uuid 1b9dae89-ad97-
ad4f-8e36-446b56ca30d4 received_uuid -                                    uuid 
f16979e8-5144-a649-8dc3-af160e481ac8 path OBS
ID 1532 gen 184016 top level 5 parent_uuid 5cc42609-193a-d341-9d76-
b220093d572e received_uuid -                                    uuid 
923b6b54-0cd9-5c45-a481-fa3d88397fb8 path Torrents
ID 1533 gen 184350 top level 5 parent_uuid c649190a-78e0-b34c-
a0ad-68b4e0da9d45 received_uuid -                                    uuid 
cc0dfd12-1422-da48-a942-864f121b0d2f path VMs
ID 1646 gen 184275 top level 5 parent_uuid -                                    
received_uuid -                                    uuid b3d567f8-
e1f7-7545-9fa1-5e6b8f6b0b34 path VG_ROMs
ID 1666 gen 2075 top level 1528 parent_uuid 
b4f18ee4-636a-3744-8869-8002c70ae707 received_uuid -                                    
uuid 16ad77a4-c02a-0b47-9fcb-2e772cc82cd4 path Snapshots/Archive/2017-01-20
ID 1800 gen 2129 top level 1528 parent_uuid b3d567f8-
e1f7-7545-9fa1-5e6b8f6b0b34 received_uuid -                                    
uuid a85853e1-848f-ac46-93c6-da5035cc8042 path Snapshots/VG_ROMs/2017-01-21-
original
ID 2170 gen 2397 top level 1528 parent_uuid 23189154-b88e-e841-
a580-5f6cba88178f received_uuid -                                    uuid 
5bdf9ea9-337e-164b-b8e9-6e096f6ed749 path Snapshots/Comics/2017-01-21
ID 3165 gen 183107 top level 1528 parent_uuid b3d567f8-
e1f7-7545-9fa1-5e6b8f6b0b34 received_uuid -                                    
uuid c7356dd2-9fa3-1141-8433-4ba96e4cdcd6 path Snapshots/VG_ROMs/2019-05-30
ID 3166 gen 183173 top level 1528 parent_uuid 23189154-b88e-e841-
a580-5f6cba88178f received_uuid -                                    uuid 
fd3e9edb-854a-4143-993e-e2a8bbd4cedb path Snapshots/Comics/2019-05-30
ID 3169 gen 184446 top level 5 parent_uuid fd3e9edb-854a-4143-993e-
e2a8bbd4cedb received_uuid -                                    uuid 42c5b7f9-
e185-994f-9882-556fab3143de path Comics
ID 3170 gen 183182 top level 1528 parent_uuid 
b4f18ee4-636a-3744-8869-8002c70ae707 received_uuid -                                    
uuid 3c48ee45-4454-2f4a-86b7-5c498ffb784d path Snapshots/Archive/2019-06-01
ID 3195 gen 183575 top level 1528 parent_uuid 42c5b7f9-
e185-994f-9882-556fab3143de received_uuid -                                    
uuid 0df42045-b04a-5f43-924e-69b39e1b3ce6 path Snapshots/Comics/2019-06-03
ID 3200 gen 183592 top level 1528 parent_uuid 
b4f18ee4-636a-3744-8869-8002c70ae707 received_uuid -                                    
uuid 649d6bec-9f54-2a44-8fed-8e6e9c054f8c path Snapshots/Archive/2019-06-03
ID 3201 gen 183594 top level 1528 parent_uuid 42c5b7f9-
e185-994f-9882-556fab3143de received_uuid -                                    
uuid a3a6b2d9-0b30-a342-bafb-6a3a70258994 path Snapshots/Comics/2019-06-03p2
ID 3209 gen 183717 top level 1528 parent_uuid 
b4f18ee4-636a-3744-8869-8002c70ae707 received_uuid -                                    
uuid 1404041e-6456-2641-a35a-f30f08baf250 path Snapshots/Archive/2019-06-05


Gentlemen (and possibly ladies), I think we've potentially found the culprit! 
But how to fix without losing my data??
-- 
--
Eric Mesa
--nextPart2280921.j9pHq33knr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAl0BhpEACgkQ2bE1K6FA
nEX3Swf6AkLiKo68vp8kwbHDzEp75B9/wv1AiWTIkpa2aQ/0rozRCPckaeD0YTf0
Hdr722mXxQaqtAnITvy0nptP1+TY7PmX3hEgfe9RvKUz8XZLIzHpV7wJUjRLGWS/
pPFQalc1dKbc3aqnueBYZJOmFjjo5yp9e4vkDJk/vLtqXgym6Ja9hIkx9sTdxN2D
GTpns/+OIixogcVfO8J1MqmmCWU4fHyCYhLn4aP17WtL/3MVpCcEsE3wPUFtOHZR
U0MWUNmD+NmqwQ1lZCH7m8oE5CYF90iNvXoGDuhtrfdcdbsdG7sH2rvv4ynRnZnh
E3DiNi+1bo1LuhwzaJ6ldXqvWK0hiw==
=bcIn
-----END PGP SIGNATURE-----

--nextPart2280921.j9pHq33knr--



