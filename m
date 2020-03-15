Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14C185DA6
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCOOwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 15 Mar 2020 10:52:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOOwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 10:52:18 -0400
Received: from [192.168.177.20] ([91.56.77.2]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MTikV-1ik30s3aaz-00Tyrn for <linux-btrfs@vger.kernel.org>; Sun, 15 Mar 2020
 15:52:16 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: the free space cache file is invalid, skip it
Date:   Sun, 15 Mar 2020 14:52:11 +0000
Message-Id: <emfc09a7c5-74d2-4f64-92cc-9a8cffa964e1@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Jg/2+pjFIzUsUz8Azuhp2FkkTTjmRCYviZ6Olhf0thHGw3NAU59
 oX1kWJNOO6gYFuleF7Y6xsLoi+bVco5YCwU3WwghTM04b5XCU2yRczsHKhV4UAAoL3kbXB7
 H/GGxujb3KZFxzu2F5VKNX5ggr5jCUzswx3E4hkESceiThU8J2PyZxUxqo/JhxeOjRClMk1
 uKFSqvuARBDkki4H6Fp+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pg5wCiWcDI0=:jry/+BQM5TjhESsC3D35SF
 PUoD1wZRbqHKrac/Ukdqtz7j/IbO7QJOksk7ZL5wwQttX/k4RyHiHY0trHTvT429a/nNC3oWj
 ZNmFG5VkKN9CXL0eK+oES1Ll+xIKbjxBuVN14QrJ6e3rCc9Ao5XZaL+/8IuonHJmyfKH0zCmd
 uxYX8GuMtBVT5MOgC9Im5OW2SdevzKCyhZWp8degPN3gz7uvSK2A1eIvmRnNivJe6SXHL0eE5
 mi9+POmeVh4QBx/XuC9RzM+LPlp17z8w7tW4NemcaT1oh1AfSi/0pzfS0kHePPTKj40AOTZA7
 e8KlhnI7CR6Tf69zIdIu//8Oe4U1yBZkwreltZcb2Jf6i4WVJDIxN9BaWUlCmIQkEJ2+bR6DY
 3rVpu6vui772OEpL2Ppt1CoL+aSbDc7C420pnS0tu4jebTjN2+CxXSmMu5wY2UBlsc0oebnyo
 bzqvxRA92PzqZglV3G50d8kLxlcnXSHdDBmM9T9HW714eJuJoMJAfcFVm1SRZyJsym1mJasNT
 1wYvRmhtOhouQPB8HHxrS+4E1/TAGRu1TI72qAB9Xu/DiCinUK7vh3B3KTVz0hTxDq83bFsnK
 LqEcyYAlV99D/8/vf2dUT82NBohAICUDH8rdQB9yNliamhG+9+b55yRMMld/OQnFuyriBmWfY
 w7d15vLpTTFDux5JCSAlOEMv5cylGQZXtJpY+awJVYkP0Y3o0b2Djh1H8WwDqHEdSrJF47g53
 9jlDbb5enddGbK+0ofkGJCgVdAuzPZrDTjh9FrVA0aPTcTD5fQy+SnOUfuirI/vJvXjlzc1kq
 LP4nHCQWKhaTaEdLTIJG5/t5JacB6jFwcbVY2Sx81I7nU2cNWhSSjmzcjLVoPaO42OwrNaa
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I see these errors in my syslog:

Mar 15 00:16:31 homeserver kernel: [524589.677551] BTRFS info (device 
sdf1): the free space cache file (12785106812928) is invalid, skip it
Mar 15 00:16:32 homeserver kernel: [524590.494705] BTRFS info (device 
sdf1): the free space cache file (12787254296576) is invalid, skip it
Mar 15 00:16:53 homeserver kernel: [524611.371823] BTRFS info (device 
sdf1): the free space cache file (14405383225344) is invalid, skip it
Mar 15 00:18:18 homeserver kernel: [524696.803108] BTRFS info (device 
sdf1): the free space cache file (15598377500672) is invalid, skip it
Mar 15 00:18:18 homeserver kernel: [524696.935340] BTRFS info (device 
sdf1): the free space cache file (15613409886208) is invalid, skip it
Mar 15 00:18:19 homeserver kernel: [524698.074946] BTRFS info (device 
sdf1): the free space cache file (15643474657280) is invalid, skip it
Mar 15 00:18:19 homeserver kernel: [524698.074952] BTRFS info (device 
sdf1): the free space cache file (15643474657280) is invalid, skip it
Mar 15 00:18:21 homeserver kernel: [524699.353843] BTRFS info (device 
sdf1): the free space cache file (15663875751936) is invalid, skip it
Mar 15 00:19:37 homeserver kernel: [524776.142963] BTRFS info (device 
sdf1): the free space cache file (15062513221632) is invalid, skip it
Mar 15 00:19:38 homeserver kernel: [524776.307788] BTRFS info (device 
sdf1): the free space cache file (15065734447104) is invalid, skip it
Mar 15 00:19:38 homeserver kernel: [524776.549028] BTRFS info (device 
sdf1): the free space cache file (15070029414400) is invalid, skip it
Mar 15 00:19:38 homeserver kernel: [524776.675084] BTRFS info (device 
sdf1): the free space cache file (15071103156224) is invalid, skip it
Mar 15 00:19:38 homeserver kernel: [524777.004195] BTRFS info (device 
sdf1): the free space cache file (15076471865344) is invalid, skip it
Mar 15 00:19:50 homeserver kernel: [524788.446974] BTRFS info (device 
sdf1): the free space cache file (15559722795008) is invalid, skip it
Mar 15 00:19:51 homeserver kernel: [524789.965874] BTRFS info (device 
sdf1): the free space cache file (15570460213248) is invalid, skip it
Mar 15 00:21:59 homeserver kernel: [524918.102725] BTRFS info (device 
sdf1): the free space cache file (15064660705280) is invalid, skip it
Mar 15 00:25:49 homeserver kernel: [525147.576735] BTRFS info (device 
sdf1): the free space cache file (15564017762304) is invalid, skip it
Mar 15 00:27:33 homeserver kernel: [525251.725178] BTRFS info (device 
sdf1): the free space cache file (16411300724736) is invalid, skip it

a scrub of that drive was finde.
Also, the stats look good:
btrfs dev stats /srv/dev-disk-by-label-DataPool1
[/dev/sdf1].write_io_errs    0
[/dev/sdf1].read_io_errs     0
[/dev/sdf1].flush_io_errs    0
[/dev/sdf1].corruption_errs  0
[/dev/sdf1].generation_errs  0
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0

Is this concerning?
What should I do?

Regards,
Hendrik

