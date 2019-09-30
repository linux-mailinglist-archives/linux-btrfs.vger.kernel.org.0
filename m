Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50BDC276F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfI3U4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 16:56:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55377 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbfI3U4I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 16:56:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5815920F60
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 15:57:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Sep 2019 15:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=0ow5gPSu36aBnmNwISyYIecsnX
        Xnhr3BV7zSh4mkbAs=; b=qFgzOMTceSdLtmnqS0tDUQ11SW81he0YF6JsscQvRX
        Dq7L93c4GIheY+RukB6Egv4iuPtuqJrWlsf3gQgLW93HvTq6lKHlxWs5qv1ZstB2
        eLQ3ZH+Z15uF1f5To/CUdwsK5JIaZMVai0v8j4OfCFMr9uPZekbwr+qfeQJhG5KU
        tlbHofDBdmxdDiDYtva1YWcFQyasIAg9hqCwnTDwFOIOM+SH2SBJQ7YFpNAGzwwL
        rei/aaK56R4ptqI10mk/efUkgW2nwA6D9UnCKHWI+a1HKN4NgyZ10EpQw0VaQxnj
        PqPp+TCDJNomkz3Iprigf0qYfF7wNjgnDxTfEm1KE4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0ow5gP
        Su36aBnmNwISyYIecsnXXnhr3BV7zSh4mkbAs=; b=drrz/8a4/vIi4r5w2vDZpO
        Bsrej3aoz45RXVsGiKDROHPfnXZ/yru8ynb/YlelRUqfBuOfmnUmkvEsXZd9P3Kf
        ItIXNmhNT/CXrVzg2N48xTIOcXQ+yUBq22noWFGJE/Rt/ITFaq6PVhiIkP1jHPys
        FHRuIUjuwC6QS6+YE8XUx8TPvKVAXzAAUF1f1G3lgMXzO9I7V9nBDzIoykrbBnjk
        DNvqa72SmDrAk8OLdWMvr+3NbcskafysTxwC6UbP85QYvrqzglBgxOp4bFXQPJ03
        oMd+0B80z/hvBDTChUhLeOLq7MJ63WObWL5sU/I/wozthQM/vWnee7C51q+11RMQ
        ==
X-ME-Sender: <xms:Kl6SXcyiPwA7WMQfwfO-ZM2DIUpJGITIh96IkEODl9SeuwmHF5EkXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:Kl6SXZ2QOaDq0GwNqYriCNuXslev9VJ3S1HgvmpPt2C8sezz4qr2uQ>
    <xmx:Kl6SXZyDuETYvLxEW5PoUcJfLZV5NJUKev8ty_2wa1FgZAuzGm9zWw>
    <xmx:Kl6SXZNy_6NNGHGB_PmP_XglcBifa30mQbeV2UKMkMvspNZQOK-k_g>
    <xmx:Kl6SXQNfu91foVMTcGbBbn4GGlOpN92y_uLYKak34T3Xk7vhd2fDjg>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id E15B7D6005E
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 15:57:29 -0400 (EDT)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Subject: BTRFS corruption, mounts but comes read-only
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
Date:   Mon, 30 Sep 2019 15:57:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Quick history, the system was rejecting ssh connections, and was not
responding to ACPI shutdown, so I had to force power off.

On restart, everything looked ok, but when I did a scrub, the system
quickly reached a point of forced read-only., (kernel Ubuntu 4.15.0-52)

I installed a current Arch for recovery, (kernel 5.3.1 and btrfs-progs
5.2.2)

Here is the result of btrfs check

btrfs check /dev/sdd4
Opening filesystem to check...
Checking filesystem on /dev/sdd4
UUID: cd54199e-753f-4bac-862d-c9d353d3e155
[1/7] checking root items
[2/7] checking extents
corrupt extent record: key [5126707298304,169,16384]
incorrect local backref count on 5126707298304 root 5890615246848 owner
1507958538109110 offset 386035672063981056 found 0 wanted 11927552 back
0x55737707d980
backref disk bytenr does not match extent record, bytenr=5126707298304,
ref bytenr=0
tree backref 5126707298304 parent 5890436890624 root 5890436890624 not
found in extent tree
tree backref 5126707298304 parent 5890463039488 root 5890463039488 not
found in extent tree
tree backref 5126707298304 parent 5125855133696 root 5125855133696 not
found in extent tree
tree backref 5126707298304 parent 4717386399744 root 4717386399744 not
found in extent tree
tree backref 5126707298304 parent 5125777653760 root 5125777653760 not
found in extent tree
tree backref 5126707298304 parent 5126231179264 root 5126231179264 not
found in extent tree
tree backref 5126707298304 parent 4716869992448 root 4716869992448 not
found in extent tree
tree backref 5126707298304 parent 4716547129344 root 4716547129344 not
found in extent tree
tree backref 5126707298304 parent 4716575670272 root 4716575670272 not
found in extent tree
tree backref 5126707298304 parent 4418457927680 root 4418457927680 not
found in extent tree
tree backref 5126707298304 parent 4418653339648 root 4418653339648 not
found in extent tree
tree backref 5126707298304 parent 4716604555264 root 4716604555264 not
found in extent tree
tree backref 5126707298304 parent 4716953616384 root 4716953616384 not
found in extent tree
tree backref 5126707298304 parent 5890615246848 root 5890615246848 not
found in extent tree
tree backref 5126707298304 parent 4134522355712 root 4134522355712 not
found in extent tree
tree backref 5126707298304 parent 4418052734976 root 4418052734976 not
found in extent tree
tree backref 5126707298304 parent 4034125447168 root 4034125447168 not
found in extent tree
tree backref 5126707298304 parent 4034188083200 root 4034188083200 not
found in extent tree
tree backref 5126707298304 parent 4133585420288 root 4133585420288 not
found in extent tree
tree backref 5126707298304 parent 4034073935872 root 4034073935872 not
found in extent tree
tree backref 5126707298304 parent 4032730021888 root 4032730021888 not
found in extent tree
tree backref 5126707298304 parent 4033156546560 root 4033156546560 not
found in extent tree
tree backref 5126707298304 parent 4031949127680 root 4031949127680 not
found in extent tree
tree backref 5126707298304 parent 4032101384192 root 4032101384192 not
found in extent tree
tree backref 5126707298304 parent 4032197132288 root 4032197132288 not
found in extent tree
tree backref 5126707298304 parent 4034077949952 root 4034077949952 not
found in extent tree
tree backref 5126707298304 parent 4031202394112 root 4031202394112 not
found in extent tree
tree backref 5126707298304 parent 4030981292032 root 4030981292032 not
found in extent tree
tree backref 5126707298304 parent 3874566619136 root 3874566619136 not
found in extent tree
tree backref 5126707298304 parent 3874229714944 root 3874229714944 not
found in extent tree
tree backref 5126707298304 parent 3873657765888 root 3873657765888 not
found in extent tree
tree backref 5126707298304 parent 3874460270592 root 3874460270592 not
found in extent tree
tree backref 5126707298304 parent 4030556012544 root 4030556012544 not
found in extent tree
tree backref 5126707298304 parent 4031297765376 root 4031297765376 not
found in extent tree
tree backref 5126707298304 parent 4418354544640 root 4418354544640 not
found in extent tree
backpointer mismatch on [5126707298304 16384]
bad extent [5126707298304, 5126707314688), type mismatch with chunk
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 4501017206864 bytes used, error(s) found
total csum bytes: 4386928432
total tree bytes: 9074900992
total fs tree bytes: 3698982912
total extent tree bytes: 377012224
btree space waste bytes: 1430502412
file data blocks allocated: 16729280847872
 referenced 8948709453824



Thank you.
