Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4C17EC16
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 23:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCIWaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 18:30:35 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60863 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 18:30:34 -0400
Received: from [192.168.1.167] (unknown [82.67.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 470A6240005;
        Mon,  9 Mar 2020 22:30:25 +0000 (UTC)
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
 <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org>
 <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 mQGiBEP8C/QRBADPiYmcQstlx+HdyR2FGH+bDgRZ0ZJBAx6F0OPW+CmIa6tlwdhSFtCTJGcw
 eqCgSKqzLS+WBd6qknpGP3D2GOmASt+Juqnl+qmX8F/XrkxSNOVGGD0vkKGX4H5uDwufWkuV
 7kD/0VFJg2areJXx5tIK4+IR0E0O4Yv6DmBPwPgNUwCg0OdUy9lbCxMmshwJDGUX2Y/hiDsD
 /3YTjHYH2OMTg/5xXlkQgR4aWn8SaVTG1vJPcm2j2BMq1LUNklgsKw7qJToRjFndHCYjSeqF
 /Yk2Cbeez9qIk3lX2M59CTwbHPZAk7fCEVg1Wf7RvR2i4zEDBWKd3nChALaXLE3mTWOE1pf8
 mUNPLALisxKDUkgyrwM4rZ28kKxyA/960xC5VVMkHWYYiisQQy2OQk+ElxSfPz5AWB5ijdJy
 SJXOT/xvgswhurPRcJc+l8Ld1GWKyey0o+EBlbkAcaZJ8RCGX77IJGG3NKDBoBN7fGXv3xQZ
 mFLbDyZWjQHl33wSUcskw2IP0D/vjRk/J7rHajIk+OxgbuTkeXF1qwX2ybQoU3fDom1pIFBl
 dGFyYW1lc2ggPHN3YW1pQHBldGFyYW1lc2gub3JnPoh+BBMRAgA+AhsDAh4BAheABQsJCAcC
 BhUKCQgLAgQWAgMBFiEEzB/joG05+rK5HJguL8JcHZB24y4FAl0Cdr0FCSJsbEkACgkQL8Jc
 HZB24y7PrwCeIj82AsMnwgOebV274cWEyR/yaDsAn25VN/Hw+yzkeXWAn5uIWJ+ZsoZkuQQN
 BEP8DFwQEAC77CwwyVuzngvfFTx2UzFwFOZ25osxSYE1Hpw249kbeK09EYbvMYzcWR34vbS0
 DhxqwJYH9uSuMZf/Jp4Qa/oYN4x4ZMeOGc5+BdigcetQQnZkIpMaCdFm6HK/A4aqCjqbPpvF
 3Mtd4CXcl1v94pIWq/n9JrLNclUA7rWnVKkPDqJ8WaxzDWm2YH9l1H+K+JbU/ow+Rk+y5xqp
 jL3XpOsVqf34RQhFUyCoysvvxH8RdHAeKfWTf5x6P8jOvxB6XwOnKkX91kC2N7PzoDxY7llY
 Uvy+ehrVVpaKLJ1a1R2eaVIHTFGO//2ARn6g4vVPMB93FLNR0BOGzEXCnnJKO5suw9Njv/aL
 bdnVdDPt9nc1yn3o8Bx/nZq1asX3zo/PnMz4Up24l6GrakJFMBZybX/KxA0CXDK6Rq4HSphI
 y/+v0I27FiQm7oT4ykiKnfFuh16NWM8rPV0UQgBLxSBoz327bUpsRuSrYh/oYBbE6p5KYHlB
 Acpix7wQ61OdUihBX73/AAx0Gd53fc0d4AYeKy4JXMl2uP2aiIvBeBaOKY5tzIq9gnL5K6rr
 xt4PSeONoLdVo8m8OyYeao1zvpgeNZ6FJ+VCYGBtsZEYIi80Ez5V0PpgAh7kSY1xbimDqKQx
 A/Jq2Q7sXBCdUeHN5cDgOZLKoJRvat/rhNaCSgUNfhUc2wADBRAAskb9Eolxs20NCfs424b3
 /NRI7SVn9W2hXvI61UYfs19lfScnn9YfmiN7IdB2cLCE6OiAbSsK3Aw8HDnEc0AdylVNOiIK
 su7C4+CW6HKMyIUm1q2qv8RwW3K8eE8+S4+4/5k+38T39BlC3HcLSxS9vfgqmF6mF6VeD5Mn
 DDbrm7G06UFm1Eh5PKFSzYKZ4i9rD9R4ivDCxRBT9Cibw36iigdp14z87/Qq/NoFe8j9zrbs
 3/3XZ22NxS0G8aNi0ejgDeYVRUUudBXK7zjV/pJDS4luB9iOiblysJmdKI3EegHlAcapTASn
 qsJ42O/Uv9jdSPPruZrMbeRKILqOl/YtI0orHGW/UzMYf/vbYWZ82azkPQqKDZF3Tb3h6ZHt
 csifD/J9IN7xh71aPf8ayIAus1AtPFtPUTjIJXqXIvAlNcDpaEpxn8xxcbVdcRBU/odASwsX
 IPdz8/HV5esod/QhR6/16kkKyOJNF5M/qC3PLur8Zu4iRu8EPiPr6vTAjhLrfXbQycuVc4CV
 c+hGlyYSW0xFaT+XF/4d+KZirsu07P5w/OCu+oRhH4StCOz58KrtuaX1dK5nLk6XkM4nKZhC
 7kmpnPqS6BkdJngkozuKQZMJahIvFglag90xgLrOl5MtO55yr/0j4S4a8GxTkVs70GttcMKN
 TYaSBqmVw+0A3IKIZgQYEQIAJgIbDBYhBMwf46BtOfqyuRyYLi/CXB2QduMuBQJdAnbyBQki
 bGwWAAoJEC/CXB2QduMur1wAn1X3FcsmMdhMfiYwXw7LVw4FAIeWAJ9kLGer22WFWR2z2iU7
 BtUAN08OPA==
Message-ID: <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org>
Date:   Mon, 9 Mar 2020 23:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again Chris, and thanks for your kind help,

Le 06/03/2020 à 19:57, Chris Murphy a écrit :
>> btrfs-progs v4.15.1

> That's too old to really be helpful these days. It's not something
> most anyone on an upstream list is keeping track of anymore, what it
> can and can't do, what bugs are fixed, etc.

Yep but that's the kernel that comes with latest Linux Mint... You can't
expect users to always use latest dev kernels but rather stable ones
that comes with distros.

OK let's do it again connecting said disk to an up-to-date Arch Linux :

[root@zafu ~]# btrfs insp dump-t -b 8176123904 /dev/sdb1
btrfs-progs v5.4
parent transid verify failed on 8176123904 wanted 183574 found 183573
parent transid verify failed on 8176123904 wanted 183574 found 183573
Ignoring transid failure
leaf 8176123904 items 1 free space 15819 generation 183573 owner TREE_LOG
leaf 8176123904 flags 0x1(WRITTEN) backref revision 1
fs uuid e1d96867-43d3-474e-bca0-665d2c9e0ff2
chunk uuid 63743d00-1594-4ec9-acc8-4ad86b4231e0
	item 0 key (TREE_LOG ROOT_ITEM 258) itemoff 15844 itemsize 439
		generation 183573 root_dirid 0 bytenr 8176107520 level 0 refs 0
		lastsnap 0 byte_limit 0 bytes_used 0 flags 0x0(none)
		uuid 00000000-0000-0000-0000-000000000000
		drop key (0 UNKNOWN.0 0) level 0


[root@zafu ~]# LC_MESSAGES=C mount -t btrfs -o usebackuproot /dev/sdb1
/mnt/hd
mount: /mnt/hd: wrong fs type, bad option, bad superblock on /dev/sdb1,
missing codepage or helper program, or other error.

(Syslog says :
mars 09 23:13:01 zafu kernel: BTRFS info (device sdb1): trying to use
backup root at mount time
mars 09 23:13:01 zafu kernel: BTRFS info (device sdb1): disk space
caching is enabled
mars 09 23:13:01 zafu kernel: BTRFS info (device sdb1): has skinny extents
mars 09 23:13:01 zafu kernel: BTRFS error (device sdb1): parent transid
verify failed on 8176123904 wanted 183574 found 183573
mars 09 23:13:01 zafu kernel: BTRFS warning (device sdb1): failed to
read root (objectid=7): -5
mars 09 23:13:01 zafu kernel: BTRFS error (device sdb1): open_ctree failed )


[root@zafu ~]# btrfs insp dump-t -b 8176123904 /dev/sdb1
btrfs-progs v5.4
parent transid verify failed on 8176123904 wanted 183574 found 183573
parent transid verify failed on 8176123904 wanted 183574 found 183573
Ignoring transid failure
leaf 8176123904 items 1 free space 15819 generation 183573 owner TREE_LOG
leaf 8176123904 flags 0x1(WRITTEN) backref revision 1
fs uuid e1d96867-43d3-474e-bca0-665d2c9e0ff2
chunk uuid 63743d00-1594-4ec9-acc8-4ad86b4231e0
	item 0 key (TREE_LOG ROOT_ITEM 258) itemoff 15844 itemsize 439
		generation 183573 root_dirid 0 bytenr 8176107520 level 0 refs 0
		lastsnap 0 byte_limit 0 bytes_used 0 flags 0x0(none)
		uuid 00000000-0000-0000-0000-000000000000
		drop key (0 UNKNOWN.0 0) level 0


[root@zafu ~]# btrfs-find-root /dev/sdb1
parent transid verify failed on 8176123904 wanted 183574 found 183573
parent transid verify failed on 8176123904 wanted 183574 found 183573
Ignoring transid failure
Superblock thinks the generation is 183574
Superblock thinks the level is 1
Found tree root at 8179122176 gen 183574 level 1
Well block 8176975872(gen: 183573 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8175075328(gen: 183572 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8172306432(gen: 183571 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8170242048(gen: 183570 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8168849408(gen: 183568 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8166326272(gen: 183567 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8163770368(gen: 183566 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8162246656(gen: 183565 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8160411648(gen: 183564 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8154660864(gen: 183562 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8152940544(gen: 183561 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8150122496(gen: 183560 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8146894848(gen: 183559 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8145141760(gen: 183558 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8142585856(gen: 183557 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8140324864(gen: 183556 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8139325440(gen: 183555 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8137408512(gen: 183554 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8135606272(gen: 183553 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8133656576(gen: 183552 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8131526656(gen: 183551 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8129888256(gen: 183550 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8127791104(gen: 183549 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8124776448(gen: 183548 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8122138624(gen: 183547 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8119631872(gen: 183546 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8119074816(gen: 183545 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8117698560(gen: 183544 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8116305920(gen: 183543 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8114176000(gen: 183542 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8112308224(gen: 183541 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8110309376(gen: 183540 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8108113920(gen: 183539 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8106098688(gen: 183538 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8104165376(gen: 183537 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8102412288(gen: 183536 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8101281792(gen: 183535 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8096071680(gen: 183533 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8092565504(gen: 183532 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8090353664(gen: 183531 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8079130624(gen: 183525 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8075378688(gen: 183524 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8071495680(gen: 183523 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8068120576(gen: 183522 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8066220032(gen: 183521 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8064073728(gen: 183520 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8062205952(gen: 183519 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8060338176(gen: 183518 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8058077184(gen: 183517 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8055554048(gen: 183516 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8053653504(gen: 183515 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8051523584(gen: 183514 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8049639424(gen: 183513 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8047443968(gen: 183512 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8045395968(gen: 183511 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8043839488(gen: 183510 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8041791488(gen: 183509 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8039219200(gen: 183508 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8038023168(gen: 183507 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8035778560(gen: 183506 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8033812480(gen: 183505 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8030814208(gen: 183504 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8027897856(gen: 183503 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8025669632(gen: 183502 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8023621632(gen: 183501 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8021606400(gen: 183500 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8019017728(gen: 183499 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8015757312(gen: 183498 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8013807616(gen: 183497 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8010956800(gen: 183496 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8008876032(gen: 183495 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8006860800(gen: 183494 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8005042176(gen: 183493 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8002650112(gen: 183492 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 8000749568(gen: 183491 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7998783488(gen: 183490 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7996588032(gen: 183489 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7994490880(gen: 183488 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7992082432(gen: 183487 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7989968896(gen: 183486 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7987871744(gen: 183485 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7985971200(gen: 183484 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7984250880(gen: 183483 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7981924352(gen: 183482 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7979270144(gen: 183481 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7978172416(gen: 183480 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7976910848(gen: 183479 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7974404096(gen: 183478 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7971586048(gen: 183477 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7970111488(gen: 183476 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7967948800(gen: 183475 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7965556736(gen: 183474 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7963639808(gen: 183473 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7961280512(gen: 183472 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7958691840(gen: 183471 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7957168128(gen: 183470 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7949320192(gen: 183466 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7943831552(gen: 183465 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7940440064(gen: 183464 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7938293760(gen: 183463 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7898988544(gen: 183447 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7888044032(gen: 183446 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7887175680(gen: 183444 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7882719232(gen: 183442 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7881146368(gen: 183441 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7880212480(gen: 183440 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7878705152(gen: 183437 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7878017024(gen: 183436 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7877246976(gen: 183435 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7876673536(gen: 183434 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7876001792(gen: 183433 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7875215360(gen: 183432 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7874543616(gen: 183430 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7873413120(gen: 183429 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7872774144(gen: 183428 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7872118784(gen: 183426 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7868055552(gen: 183421 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7866974208(gen: 183419 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7864991744(gen: 183416 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7861911552(gen: 183415 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7861501952(gen: 183414 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7860961280(gen: 183413 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7860453376(gen: 183412 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7859617792(gen: 183411 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7858978816(gen: 183410 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7858257920(gen: 183409 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7855374336(gen: 183405 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7854227456(gen: 183404 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7852703744(gen: 183403 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7852310528(gen: 183402 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7851507712(gen: 183401 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7847362560(gen: 183400 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7846281216(gen: 183399 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7845724160(gen: 183398 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7845183488(gen: 183397 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7844560896(gen: 183396 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7843758080(gen: 183395 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7843299328(gen: 183394 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7842988032(gen: 183393 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7842512896(gen: 183392 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7842086912(gen: 183391 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7841366016(gen: 183390 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7840432128(gen: 183389 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7839793152(gen: 183388 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7838711808(gen: 183387 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7838351360(gen: 183386 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7837908992(gen: 183385 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7837548544(gen: 183384 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7836696576(gen: 183383 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7836123136(gen: 183382 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7835484160(gen: 183381 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7834255360(gen: 183380 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7833845760(gen: 183379 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7833550848(gen: 183378 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7832682496(gen: 183376 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7829454848(gen: 183375 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7826800640(gen: 183374 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7824293888(gen: 183373 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7822573568(gen: 183372 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7820361728(gen: 183371 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7818280960(gen: 183370 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7816183808(gen: 183369 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7814201344(gen: 183368 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7813447680(gen: 183367 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7811284992(gen: 183366 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7809089536(gen: 183365 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7807303680(gen: 183364 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7805927424(gen: 183363 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7804125184(gen: 183362 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7802159104(gen: 183361 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7800700928(gen: 183360 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7797047296(gen: 183359 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7794458624(gen: 183358 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7793639424(gen: 183356 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7791591424(gen: 183355 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7773634560(gen: 183346 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7768719360(gen: 183345 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7759904768(gen: 183341 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7758053376(gen: 183340 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7756120064(gen: 183339 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7754252288(gen: 183338 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7752073216(gen: 183337 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7749861376(gen: 183336 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7747534848(gen: 183335 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7745863680(gen: 183334 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7744389120(gen: 183333 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7742996480(gen: 183332 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7738163200(gen: 183330 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7734525952(gen: 183327 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7730036736(gen: 183325 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7728480256(gen: 183324 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7723712512(gen: 183322 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7720976384(gen: 183321 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7717994496(gen: 183320 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7717273600(gen: 183319 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7715962880(gen: 183318 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7714193408(gen: 183317 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7711834112(gen: 183316 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7709818880(gen: 183315 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7707656192(gen: 183314 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7704739840(gen: 183313 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7700152320(gen: 183312 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7698235392(gen: 183311 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7696056320(gen: 183310 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7693910016(gen: 183309 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7691911168(gen: 183308 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7689977856(gen: 183307 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7687864320(gen: 183306 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7685505024(gen: 183305 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7683276800(gen: 183304 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7680868352(gen: 183303 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7678492672(gen: 183302 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7676428288(gen: 183301 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7674216448(gen: 183300 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7672446976(gen: 183299 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7670595584(gen: 183298 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7668301824(gen: 183297 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7664697344(gen: 183295 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7662387200(gen: 183294 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7660388352(gen: 183293 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7657570304(gen: 183292 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7654391808(gen: 183291 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7651721216(gen: 183290 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7649460224(gen: 183289 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7647543296(gen: 183288 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7645446144(gen: 183287 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7641858048(gen: 183286 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7640547328(gen: 183285 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7638466560(gen: 183284 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7636271104(gen: 183283 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7632781312(gen: 183282 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7630749696(gen: 183281 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7628685312(gen: 183280 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7627603968(gen: 183279 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7625080832(gen: 183278 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7602913280(gen: 183267 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7600799744(gen: 183266 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7598227456(gen: 183265 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7596163072(gen: 183264 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7593590784(gen: 183263 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7591559168(gen: 183262 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7589298176(gen: 183261 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7587184640(gen: 183260 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7585529856(gen: 183259 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7582842880(gen: 183258 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7580319744(gen: 183257 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7577763840(gen: 183256 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7575240704(gen: 183255 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7572340736(gen: 183254 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7568326656(gen: 183253 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7566114816(gen: 183252 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7564148736(gen: 183251 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7562035200(gen: 183250 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7559970816(gen: 183249 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7558004736(gen: 183248 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7555743744(gen: 183247 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7553138688(gen: 183246 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7552647168(gen: 183245 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7550386176(gen: 183244 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7548370944(gen: 183243 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7545880576(gen: 183242 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7543586816(gen: 183241 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7541604352(gen: 183240 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 7539458048(gen: 183239 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1095270400(gen: 183238 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1092435968(gen: 183237 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1090748416(gen: 183236 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1089044480(gen: 183235 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1087455232(gen: 183234 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1086308352(gen: 183233 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1076903936(gen: 183228 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1072562176(gen: 183226 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1066827776(gen: 183225 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1061896192(gen: 183224 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1055440896(gen: 183222 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1054048256(gen: 183221 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1051312128(gen: 183220 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1046790144(gen: 183219 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1045315584(gen: 183218 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1039695872(gen: 183216 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1037811712(gen: 183215 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1035698176(gen: 183214 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1034223616(gen: 183213 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1031258112(gen: 183212 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1029455872(gen: 183211 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1027342336(gen: 183210 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1025114112(gen: 183209 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1023098880(gen: 183208 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1022328832(gen: 183207 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1019854848(gen: 183206 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1018068992(gen: 183205 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1015824384(gen: 183204 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1013465088(gen: 183203 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1011515392(gen: 183202 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1009582080(gen: 183201 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1007714304(gen: 183200 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1005191168(gen: 183199 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1002258432(gen: 183198 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 1000341504(gen: 183197 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 998359040(gen: 183196 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 995803136(gen: 183195 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 992919552(gen: 183194 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 989986816(gen: 183193 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 987283456(gen: 183192 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 983416832(gen: 183191 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 980926464(gen: 183190 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 978747392(gen: 183189 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 976502784(gen: 183188 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 974061568(gen: 183187 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 971997184(gen: 183186 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 970227712(gen: 183185 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 967819264(gen: 183184 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 965165056(gen: 183183 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 963182592(gen: 183182 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 961101824(gen: 183181 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 959086592(gen: 183180 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 957005824(gen: 183179 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 954941440(gen: 183178 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 952991744(gen: 183177 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 951107584(gen: 183176 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 944193536(gen: 183174 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 941424640(gen: 183173 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 910983168(gen: 183167 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 907509760(gen: 183166 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 905904128(gen: 183165 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 906428416(gen: 183164 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 899825664(gen: 183161 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 896286720(gen: 183160 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 894156800(gen: 183159 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 891944960(gen: 183158 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 889864192(gen: 183157 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 887619584(gen: 183155 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 885948416(gen: 183154 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 883900416(gen: 183153 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 882573312(gen: 183152 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 878542848(gen: 183150 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 874577920(gen: 183149 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 872267776(gen: 183148 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 868761600(gen: 183147 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 867041280(gen: 183146 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 865157120(gen: 183145 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 862699520(gen: 183144 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 860209152(gen: 183143 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 858865664(gen: 183142 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 856981504(gen: 183141 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 854736896(gen: 183140 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 851247104(gen: 183138 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 847675392(gen: 183137 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 845398016(gen: 183136 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 843759616(gen: 183135 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 841973760(gen: 183134 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 838991872(gen: 183133 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 835796992(gen: 183132 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 832634880(gen: 183131 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 830521344(gen: 183130 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 827703296(gen: 183129 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 825589760(gen: 183128 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 822591488(gen: 183127 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 820117504(gen: 183126 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 817889280(gen: 183125 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 816988160(gen: 183124 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 814858240(gen: 183123 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 813121536(gen: 183122 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 810467328(gen: 183121 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 807895040(gen: 183120 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 806191104(gen: 183119 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 804093952(gen: 183118 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 802193408(gen: 183117 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 800096256(gen: 183116 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 797982720(gen: 183115 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 794804224(gen: 183114 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 792231936(gen: 183113 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 789839872(gen: 183112 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 789053440(gen: 183111 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 787120128(gen: 183110 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 785514496(gen: 183109 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 782909440(gen: 183108 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 778567680(gen: 183107 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 772980736(gen: 183106 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 769867776(gen: 183105 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 767836160(gen: 183104 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 765411328(gen: 183103 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 763330560(gen: 183102 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 760545280(gen: 183100 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 758022144(gen: 183099 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 756023296(gen: 183098 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 754057216(gen: 183097 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 747323392(gen: 183094 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 745013248(gen: 183093 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 741408768(gen: 183092 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 739131392(gen: 183091 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 737771520(gen: 183090 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 735199232(gen: 183089 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 733036544(gen: 183088 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 731250688(gen: 183087 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 729464832(gen: 183086 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 727334912(gen: 183085 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 725647360(gen: 183084 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 723730432(gen: 183083 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 722386944(gen: 183082 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 720011264(gen: 183081 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 715505664(gen: 183080 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 713621504(gen: 183079 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 711770112(gen: 183078 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 709492736(gen: 183077 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 707444736(gen: 183076 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 705150976(gen: 183075 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 701562880(gen: 183074 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 698023936(gen: 183073 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 695795712(gen: 183072 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 693420032(gen: 183071 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 685801472(gen: 183070 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 678330368(gen: 183069 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 676757504(gen: 183068 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 674316288(gen: 183067 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 672399360(gen: 183066 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 670334976(gen: 183065 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 648036352(gen: 183056 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 643940352(gen: 183055 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 642105344(gen: 183054 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 640499712(gen: 183053 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 638337024(gen: 183052 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 635158528(gen: 183051 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 632471552(gen: 183050 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 630161408(gen: 183049 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 628850688(gen: 183048 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 627261440(gen: 183047 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 623001600(gen: 183046 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 621150208(gen: 183045 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 618823680(gen: 183044 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 616628224(gen: 183043 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 614924288(gen: 183042 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 613040128(gen: 183041 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 609091584(gen: 183039 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 607076352(gen: 183038 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 604880896(gen: 183037 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 602161152(gen: 183036 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 599654400(gen: 183035 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 597819392(gen: 183034 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 595148800(gen: 183033 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 592314368(gen: 183032 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 588300288(gen: 183031 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 587120640(gen: 183030 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 585023488(gen: 183029 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 582991872(gen: 183028 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 580616192(gen: 183027 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 578338816(gen: 183026 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 575275008(gen: 183025 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 573227008(gen: 183024 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 570933248(gen: 183023 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 568868864(gen: 183022 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 566853632(gen: 183021 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 564183040(gen: 183020 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 561922048(gen: 183019 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 559677440(gen: 183018 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 558104576(gen: 183017 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 554450944(gen: 183016 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 549306368(gen: 183015 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 546357248(gen: 183014 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 544292864(gen: 183013 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 542588928(gen: 183012 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 540753920(gen: 183011 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 538804224(gen: 183010 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 536150016(gen: 183009 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 534020096(gen: 183008 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 531202048(gen: 183007 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 523042816(gen: 183004 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 521764864(gen: 183002 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 518553600(gen: 183001 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 516521984(gen: 183000 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 514703360(gen: 182999 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 511442944(gen: 182998 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 508248064(gen: 182997 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 506167296(gen: 182996 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 504315904(gen: 182995 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 501923840(gen: 182994 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 500105216(gen: 182993 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 497844224(gen: 182992 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 496156672(gen: 182991 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 493977600(gen: 182990 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 491782144(gen: 182989 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 487735296(gen: 182987 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 478052352(gen: 182983 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 474972160(gen: 182982 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 472236032(gen: 182981 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 469647360(gen: 182980 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 467451904(gen: 182979 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 465780736(gen: 182978 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 463831040(gen: 182977 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 461701120(gen: 182976 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 458735616(gen: 182975 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 454688768(gen: 182974 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 452116480(gen: 182973 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 450625536(gen: 182972 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 446791680(gen: 182971 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 444825600(gen: 182969 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 441974784(gen: 182968 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 438550528(gen: 182967 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 435929088(gen: 182966 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 433930240(gen: 182965 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 431489024(gen: 182964 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 429129728(gen: 182963 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 426278912(gen: 182962 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 423821312(gen: 182961 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 418856960(gen: 182960 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 415137792(gen: 182959 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 404832256(gen: 182955 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 402718720(gen: 182954 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 401866752(gen: 182953 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 399720448(gen: 182952 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 397475840(gen: 182951 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 383139840(gen: 182945 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 380108800(gen: 182943 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 359071744(gen: 182936 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 327729152(gen: 182925 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 313819136(gen: 182919 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 311803904(gen: 182918 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 309592064(gen: 182917 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 307396608(gen: 182916 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 302678016(gen: 182914 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 299155456(gen: 182913 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 296419328(gen: 182912 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 294174720(gen: 182911 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 292782080(gen: 182910 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 290209792(gen: 182909 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 288292864(gen: 182908 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 286244864(gen: 182907 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 284459008(gen: 182906 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 278839296(gen: 182903 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 275759104(gen: 182902 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 273350656(gen: 182901 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 269811712(gen: 182899 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 268517376(gen: 182898 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 227262464(gen: 182880 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 223051776(gen: 182879 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 206995456(gen: 182870 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 202014720(gen: 182869 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 175833088(gen: 182860 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 168411136(gen: 182859 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 160972800(gen: 182856 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 157679616(gen: 182855 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 153796608(gen: 182854 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 28835840(gen: 182805 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 25477120(gen: 182803 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 13500416(gen: 182802 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 5881856(gen: 182801 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1
Well block 6635520(gen: 182800 level: 1) seems good, but
generation/level doesn't match, want gen: 183574 level: 1


“btrfs check” are really too verbose for a mailing list, they spit a
zillion lines...

>> drop key (0 UNKNOWN.0 0) level 0
> That's it? Is this trimmed? This block is for an empty tree log leaf,
> and it's not failing csum but transid match. Was there a crash or
> power failure? What do you get for:

I dunno, that's a kid's laptop... She only complained it wouldn't boot
no more. I have no clue about previous context.


> btrfs insp dump-s /dev/

[root@zafu ~]# btrfs insp dump-s /dev/sdb1
superblock: bytenr=65536, device=/dev/sdb1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x90577c62 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			e1d96867-43d3-474e-bca0-665d2c9e0ff2
metadata_uuid		e1d96867-43d3-474e-bca0-665d2c9e0ff2
label			LINUX
generation		183574
root			8179122176
sys_array_size		97
chunk_root_generation	96193
root_level		1
chunk_root		64513654784
chunk_root_level	0
log_root		8179646464
log_root_transid	0
log_root_level		0
total_bytes		117884059648
bytes_used		30276132864
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	183574
uuid_tree_generation	35365
dev_item.uuid		79af4e40-94b4-433a-884c-78220025ac1a
dev_item.fsid		e1d96867-43d3-474e-bca0-665d2c9e0ff2 [match]
dev_item.type		0
dev_item.total_bytes	117884059648
dev_item.bytes_used	52663681024
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

> No there really isn't enough information, there's too much trimmed
> away. The best bet is to always provide too much information and let
> devs filter it themselves. Otherwise they have to spend time asking
> for more information, and then context switch. And also the
> btrfs-progs is too old I think for this list. I mean, maybe someone
> could make heads or tails out of it, but the upstream list tends to be
> pretty much active development. And older versions are the
> responsibility of the downstream distribution.

Okay so I gave what I could using

[root@zafu ~]# uname -r
5.5.8-arch1-1

[root@zafu ~]# btrfs version
btrfs-progs v5.4

That's all, untrimmed, except for the btrfs check outputs that I can
provide upoin resquest, but maybe outside the ML...

As the FS didn't mount since th issue appeared, it's state has remained
the same, at least I expect so...

Kind regards.

ॐ
-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
