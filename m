Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2487C283F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfI3VIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:08:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33587 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732270AbfI3VIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:08:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BE16422116
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 17:08:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Sep 2019 17:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:from:to:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=F
        XRrsB9IvI2CSod+lhoBoJtXI1Wl+lqs31MUP3IDX24=; b=zgbUshF4EkK+BzMxD
        MgP3XQpvD/58HUo5Ml/KQvcOhaHS+89joKD8Jl8rhsR4K7+B/uIRLt0JC2AYxtoe
        PDDJDv8ELRheICKIhluF4gbsM+e4j9iJ07XksayejT6agPGrNUlJZ1B6wpRv9kbC
        xOe9nHpFJdNLKyR4o5BTZKGW7zEGGol1JZsFwkl+aa+m1kvbhrqdBjO/+ywXqfQs
        2xa/HphO/DqY1nVqOcBfXf7aDoEGbzaMnSxkuoUUI+fI0rDlI2/5jG2be2pPg3C0
        j4uvWLw67Low4wjR56Y5LxIbKMxx0TNt4jaYlfcsDkeKJWDKmrbXwcSoqp4D+Cjn
        L3eAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FXRrsB9IvI2CSod+lhoBoJtXI1Wl+lqs31MUP3IDX
        24=; b=l+4Z+VL0BcEVCBiujh4bIbeim2FWoFJ+k3rcF2zAGtmjTkbNwPqQfsobg
        XL14GT68K6JJwe7MVou+jFRzfEkCowrzmDoHxJCO1At8B+D8zgpZ3sxVJZSoYUk8
        /mXWRAi/DeVUNe971o0+VovzaGUSEn/bAlbsEAaapTF3CPbGKcMgsPDPMmTpH1fA
        SMLjZzJJmaaoBd8CVOUTzUoG5SyWCEvPakTDI4QflRvp4C/TKEmEJJwuzNa+oJro
        2gBx4UsDm4DAkQluppIj2eXlQUEzptdhrS2iqs5mhHv16p8puYNY6da23stxdJIj
        aSJlfW3aofeU0UzctzaXZcIfXwOxw==
X-ME-Sender: <xms:uW6SXV90CjLRs9UKms-BpDPSB4IaPzzVHMy2G3t-rTCTxuQ6nDdR8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrgedvgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuhffvfhfkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:uW6SXe7omDjNJYh_jXqjdlnC8QALHdi2DOpAkNpWDiZ2WoyuInkWKQ>
    <xmx:uW6SXTaMkNyPRddzDTJ9yStE6eDy5uQL7_-Hw80NOa4QjcoCn8C2LA>
    <xmx:uW6SXSiGbkA8rzJ87Sou8mAm0Md1GqD_0E9bNbO444bOANIotfjx6g>
    <xmx:uW6SXYwBmlHkcKjc9TgNysb_LHnhvJ_a81XFwUBu6uOacSEX1Z7wHw>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30A07D6005E
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 17:08:09 -0400 (EDT)
Subject: Re: BTRFS corruption, mounts but comes read-only
From:   Remi Gauvin <remi@georgianit.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
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
Message-ID: <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
Date:   Mon, 30 Sep 2019 17:08:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mounting the FS after that btrfs check, kernel 5.3.1, here is the dmesg log:

[10524.830640] BTRFS info (device sdf4): using free space tree
[10524.830644] BTRFS info (device sdf4): has skinny extents
[10549.561143] BTRFS info (device sdf4): checking UUID tree
[10606.900264] BTRFS info (device sdf4): leaf 3873928691712 gen 935882
total ptrs 147 free space 6236 owner 2
[10606.900268] 	item 0 key (5126703497216 169 0) itemoff 15845 itemsize 438
[10606.900270] 		extent refs 46 gen 885323 flags 2
[10606.900272] 		ref#0: tree block backref root 10262
[10606.900274] 		ref#1: shared block backref parent 6300271443968
[10606.900276] 		ref#2: shared block backref parent 6300177645568
[10606.900278] 		ref#3: shared block backref parent 6300087877632
[10606.900279] 		ref#4: shared block backref parent 6299851292672
[10606.900281] 		ref#5: shared block backref parent 6299576254464
[10606.900283] 		ref#6: shared block backref parent 6299308621824
[10606.900284] 		ref#7: shared block backref parent 6240101318656
[10606.900286] 		ref#8: shared block backref parent 6239972589568
[10606.900288] 		ref#9: shared block backref parent 5891141632000
[10606.900289] 		ref#10: shared block backref parent 5891082911744
[10606.900291] 		ref#11: shared block backref parent 5891042951168
[10606.900293] 		ref#12: shared block backref parent 5890615246848
[10606.900294] 		ref#13: shared block backref parent 5890463039488
[10606.900296] 		ref#14: shared block backref parent 5890436890624
[10606.900298] 		ref#15: shared block backref parent 5126231179264
[10606.900299] 		ref#16: shared block backref parent 5125855133696
[10606.900301] 		ref#17: shared block backref parent 5125777653760
[10606.900302] 		ref#18: shared block backref parent 4717386399744
[10606.900304] 		ref#19: shared block backref parent 4716953616384
[10606.900306] 		ref#20: shared block backref parent 4716869992448
[10606.900307] 		ref#21: shared block backref parent 4716604555264
[10606.900309] 		ref#22: shared block backref parent 4716575670272
[10606.900311] 		ref#23: shared block backref parent 4716547129344
[10606.900312] 		ref#24: shared block backref parent 4418653339648
[10606.900314] 		ref#25: shared block backref parent 4418457927680
[10606.900316] 		ref#26: shared block backref parent 4418052734976
[10606.900317] 		ref#27: shared block backref parent 4134522355712
[10606.900319] 		ref#28: shared block backref parent 4133585420288
[10606.900320] 		ref#29: shared block backref parent 4034188083200
[10606.900322] 		ref#30: shared block backref parent 4034125447168
[10606.900324] 		ref#31: shared block backref parent 4034077949952
[10606.900325] 		ref#32: shared block backref parent 4034073935872
[10606.900327] 		ref#33: shared block backref parent 4033156546560
[10606.900329] 		ref#34: shared block backref parent 4032730021888
[10606.900330] 		ref#35: shared block backref parent 4032197132288
[10606.900332] 		ref#36: shared block backref parent 4032101384192
[10606.900333] 		ref#37: shared block backref parent 4031949127680
[10606.900335] 		ref#38: shared block backref parent 4031297765376
[10606.900337] 		ref#39: shared block backref parent 4031202394112
[10606.900338] 		ref#40: shared block backref parent 4030981292032
[10606.900340] 		ref#41: shared block backref parent 4030556012544
[10606.900342] 		ref#42: shared block backref parent 3874566619136
[10606.900343] 		ref#43: shared block backref parent 3874460270592
[10606.900345] 		ref#44: shared block backref parent 3874229714944
[10606.900347] 		ref#45: shared block backref parent 3873657765888
[10606.900350] 	item 1 key (5126703529984 169 0) itemoff 15812 itemsize 33
[10606.900351] 		extent refs 1 gen 571786 flags 258
[10606.900352] 		ref#0: tree block backref root 46426
[10606.900355] 	item 2 key (5126703546368 169 0) itemoff 15779 itemsize 33
[10606.900357] 		extent refs 1 gen 626172 flags 2
[10606.900390] 		ref#0: tree block backref root 7
[10606.900393] 	item 3 key (5126703562752 169 0) itemoff 15746 itemsize 33
[10606.900395] 		extent refs 1 gen 626172 flags 2
[10606.900396] 		ref#0: tree block backref root 7
[10606.900399] 	item 4 key (5126703579136 169 0) itemoff 15713 itemsize 33
[10606.900401] 		extent refs 1 gen 626172 flags 2
[10606.900402] 		ref#0: tree block backref root 7
[10606.900404] 	item 5 key (5126703661056 169 0) itemoff 15680 itemsize 33
[10606.900406] 		extent refs 1 gen 573020 flags 258
[10606.900407] 		ref#0: shared block backref parent 5891148972032
[10606.900410] 	item 6 key (5126703677440 169 0) itemoff 15647 itemsize 33
[10606.900412] 		extent refs 1 gen 626172 flags 2
[10606.900413] 		ref#0: tree block backref root 7
[10606.900416] 	item 7 key (5126703693824 169 0) itemoff 15614 itemsize 33
[10606.900417] 		extent refs 1 gen 626172 flags 2
[10606.900419] 		ref#0: tree block backref root 7
[10606.900421] 	item 8 key (5126703710208 169 0) itemoff 15581 itemsize 33
[10606.900423] 		extent refs 1 gen 626172 flags 2
[10606.900424] 		ref#0: tree block backref root 7
[10606.900430] 	item 9 key (5126703726592 169 0) itemoff 15548 itemsize 33
[10606.900431] 		extent refs 1 gen 626172 flags 2
[10606.900432] 		ref#0: tree block backref root 7
[10606.900435] 	item 10 key (5126703742976 169 0) itemoff 15515 itemsize 33
[10606.900437] 		extent refs 1 gen 626172 flags 2
[10606.900438] 		ref#0: tree block backref root 7
[10606.900441] 	item 11 key (5126703759360 169 0) itemoff 15482 itemsize 33
[10606.900442] 		extent refs 1 gen 626172 flags 2
[10606.900443] 		ref#0: tree block backref root 7
[10606.900446] 	item 12 key (5126703775744 169 0) itemoff 15449 itemsize 33
[10606.900448] 		extent refs 1 gen 573140 flags 258
[10606.900449] 		ref#0: shared block backref parent 5126301810688
[10606.900452] 	item 13 key (5126703792128 169 0) itemoff 15416 itemsize 33
[10606.900454] 		extent refs 1 gen 626172 flags 2
[10606.900455] 		ref#0: tree block backref root 7
[10606.900457] 	item 14 key (5126703824896 169 0) itemoff 15383 itemsize 33
[10606.900459] 		extent refs 1 gen 626172 flags 2
[10606.900460] 		ref#0: tree block backref root 7
[10606.900463] 	item 15 key (5126703857664 169 0) itemoff 15350 itemsize 33
[10606.900465] 		extent refs 1 gen 626172 flags 2
[10606.900466] 		ref#0: tree block backref root 7
[10606.900469] 	item 16 key (5126703874048 169 0) itemoff 15317 itemsize 33
[10606.900470] 		extent refs 1 gen 626172 flags 2
[10606.900472] 		ref#0: tree block backref root 7
[10606.900474] 	item 17 key (5126703890432 169 0) itemoff 15275 itemsize 42
[10606.900476] 		extent refs 2 gen 573020 flags 258
[10606.900477] 		ref#0: tree block backref root 46426
[10606.900479] 		ref#1: shared block backref parent 4031041306624
[10606.900482] 	item 18 key (5126703906816 169 0) itemoff 15242 itemsize 33
[10606.900484] 		extent refs 1 gen 626172 flags 2
[10606.900485] 		ref#0: tree block backref root 7
[10606.900488] 	item 19 key (5126703923200 169 0) itemoff 15209 itemsize 33
[10606.900490] 		extent refs 1 gen 573020 flags 258
[10606.900491] 		ref#0: shared block backref parent 5891148972032
[10606.900494] 	item 20 key (5126703939584 169 0) itemoff 15176 itemsize 33
[10606.900495] 		extent refs 1 gen 573938 flags 258
[10606.900496] 		ref#0: tree block backref root 36610
[10606.900499] 	item 21 key (5126703955968 169 0) itemoff 15143 itemsize 33
[10606.900501] 		extent refs 1 gen 626172 flags 2
[10606.900502] 		ref#0: tree block backref root 7
[10606.900505] 	item 22 key (5126703972352 169 0) itemoff 15110 itemsize 33
[10606.900507] 		extent refs 1 gen 626172 flags 2
[10606.900508] 		ref#0: tree block backref root 7
[10606.900511] 	item 23 key (5126703988736 169 0) itemoff 15077 itemsize 33
[10606.900512] 		extent refs 1 gen 626172 flags 2
[10606.900513] 		ref#0: tree block backref root 7
[10606.900516] 	item 24 key (5126704021504 169 0) itemoff 15044 itemsize 33
[10606.900518] 		extent refs 1 gen 573020 flags 258
[10606.900519] 		ref#0: shared block backref parent 4033915666432
[10606.900522] 	item 25 key (5126704070656 169 0) itemoff 15011 itemsize 33
[10606.900524] 		extent refs 1 gen 895691 flags 2
[10606.900525] 		ref#0: tree block backref root 533
[10606.900528] 	item 26 key (5126704103424 169 0) itemoff 14978 itemsize 33
[10606.900530] 		extent refs 1 gen 822492 flags 2
[10606.900531] 		ref#0: tree block backref root 7
[10606.900534] 	item 27 key (5126704119808 169 0) itemoff 14945 itemsize 33
[10606.900535] 		extent refs 1 gen 607875 flags 2
[10606.900536] 		ref#0: tree block backref root 7
[10606.900539] 	item 28 key (5126704136192 169 0) itemoff 14912 itemsize 33
[10606.900541] 		extent refs 1 gen 607875 flags 2
[10606.900542] 		ref#0: tree block backref root 7
[10606.900545] 	item 29 key (5126704152576 169 0) itemoff 14879 itemsize 33
[10606.900547] 		extent refs 1 gen 804138 flags 258
[10606.900548] 		ref#0: shared block backref parent 5126678069248
[10606.900551] 	item 30 key (5126704185344 169 0) itemoff 14846 itemsize 33
[10606.900552] 		extent refs 1 gen 895691 flags 2
[10606.900553] 		ref#0: tree block backref root 533
[10606.900556] 	item 31 key (5126704201728 169 0) itemoff 14813 itemsize 33
[10606.900558] 		extent refs 1 gen 569360 flags 258
[10606.900559] 		ref#0: tree block backref root 36611
[10606.900562] 	item 32 key (5126704234496 169 0) itemoff 14771 itemsize 42
[10606.900564] 		extent refs 2 gen 804138 flags 258
[10606.900565] 		ref#0: shared block backref parent 5126678069248
[10606.900567] 		ref#1: shared block backref parent 3873634877440
[10606.900570] 	item 33 key (5126704250880 169 0) itemoff 14738 itemsize 33
[10606.900571] 		extent refs 1 gen 892179 flags 2
[10606.900573] 		ref#0: tree block backref root 7
[10606.900575] 	item 34 key (5126704283648 169 0) itemoff 14300 itemsize 438
[10606.900577] 		extent refs 46 gen 885323 flags 2
[10606.900578] 		ref#0: tree block backref root 10262
[10606.900580] 		ref#1: shared block backref parent 6300271443968
[10606.900582] 		ref#2: shared block backref parent 6300177645568
[10606.900583] 		ref#3: shared block backref parent 6300087877632
[10606.900585] 		ref#4: shared block backref parent 6299851292672
[10606.900587] 		ref#5: shared block backref parent 6299576254464
[10606.900589] 		ref#6: shared block backref parent 6299308621824
[10606.900590] 		ref#7: shared block backref parent 6240101318656
[10606.900592] 		ref#8: shared block backref parent 6239972589568
[10606.900594] 		ref#9: shared block backref parent 5891141632000
[10606.900595] 		ref#10: shared block backref parent 5891082911744
[10606.900597] 		ref#11: shared block backref parent 5891042951168
[10606.900599] 		ref#12: shared block backref parent 5890615246848
[10606.900601] 		ref#13: shared block backref parent 5890463039488
[10606.900602] 		ref#14: shared block backref parent 5890436890624
[10606.900604] 		ref#15: shared block backref parent 5126231179264
[10606.900605] 		ref#16: shared block backref parent 5125855133696
[10606.900607] 		ref#17: shared block backref parent 5125777653760
[10606.900609] 		ref#18: shared block backref parent 4717386399744
[10606.900610] 		ref#19: shared block backref parent 4716953616384
[10606.900612] 		ref#20: shared block backref parent 4716869992448
[10606.900614] 		ref#21: shared block backref parent 4716604555264
[10606.900615] 		ref#22: shared block backref parent 4716575670272
[10606.900617] 		ref#23: shared block backref parent 4716547129344
[10606.900618] 		ref#24: shared block backref parent 4418653339648
[10606.900620] 		ref#25: shared block backref parent 4418457927680
[10606.900622] 		ref#26: shared block backref parent 4418052734976
[10606.900623] 		ref#27: shared block backref parent 4134522355712
[10606.900625] 		ref#28: shared block backref parent 4133585420288
[10606.900627] 		ref#29: shared block backref parent 4034188083200
[10606.900629] 		ref#30: shared block backref parent 4034125447168
[10606.900630] 		ref#31: shared block backref parent 4034077949952
[10606.900632] 		ref#32: shared block backref parent 4034073935872
[10606.900634] 		ref#33: shared block backref parent 4033156546560
[10606.900635] 		ref#34: shared block backref parent 4032730021888
[10606.900637] 		ref#35: shared block backref parent 4032197132288
[10606.900641] 		ref#36: shared block backref parent 4032101384192
[10606.900643] 		ref#37: shared block backref parent 4031949127680
[10606.900645] 		ref#38: shared block backref parent 4031297765376
[10606.900646] 		ref#39: shared block backref parent 4031202394112
[10606.900648] 		ref#40: shared block backref parent 4030981292032
[10606.900650] 		ref#41: shared block backref parent 4030556012544
[10606.900651] 		ref#42: shared block backref parent 3874566619136
[10606.900653] 		ref#43: shared block backref parent 3874460270592
[10606.900655] 		ref#44: shared block backref parent 3874229714944
[10606.900656] 		ref#45: shared block backref parent 3873657765888
[10606.900659] 	item 35 key (5126704349184 169 0) itemoff 14258 itemsize 42
[10606.900661] 		extent refs 2 gen 573938 flags 258
[10606.900662] 		ref#0: tree block backref root 281
[10606.900664] 		ref#1: shared block backref parent 4031488409600
[10606.900667] 	item 36 key (5126704365568 169 0) itemoff 13937 itemsize 321
[10606.900669] 		extent refs 33 gen 798413 flags 2
[10606.900670] 		ref#0: tree block backref root 281
[10606.900671] 		ref#1: shared block backref parent 6300251619328
[10606.900673] 		ref#2: shared block backref parent 6300114485248
[10606.900675] 		ref#3: shared block backref parent 6299905949696
[10606.900676] 		ref#4: shared block backref parent 6299664252928
[10606.900678] 		ref#5: shared block backref parent 6299588788224
[10606.900680] 		ref#6: shared block backref parent 6240128745472
[10606.900681] 		ref#7: shared block backref parent 6239522193408
[10606.900683] 		ref#8: shared block backref parent 6239392333824
[10606.900685] 		ref#9: shared block backref parent 5890538242048
[10606.900687] 		ref#10: shared block backref parent 5126408634368
[10606.900688] 		ref#11: shared block backref parent 5125832900608
[10606.900690] 		ref#12: shared block backref parent 5125791629312
[10606.900692] 		ref#13: shared block backref parent 5125763891200
[10606.900693] 		ref#14: shared block backref parent 4717584973824
[10606.900695] 		ref#15: shared block backref parent 4717085753344
[10606.900697] 		ref#16: shared block backref parent 4418848030720
[10606.900698] 		ref#17: shared block backref parent 4418599485440
[10606.900700] 		ref#18: shared block backref parent 4418511667200
[10606.900702] 		ref#19: shared block backref parent 4418464645120
[10606.900703] 		ref#20: shared block backref parent 4418246524928
[10606.900705] 		ref#21: shared block backref parent 4034620768256
[10606.900706] 		ref#22: shared block backref parent 4034070249472
[10606.900708] 		ref#23: shared block backref parent 4033253998592
[10606.900710] 		ref#24: shared block backref parent 4032699777024
[10606.900712] 		ref#25: shared block backref parent 4032367345664
[10606.900713] 		ref#26: shared block backref parent 4031668764672
[10606.900715] 		ref#27: shared block backref parent 4031182979072
[10606.900719] 		ref#28: shared block backref parent 4030886608896
[10606.900721] 		ref#29: shared block backref parent 3874677374976
[10606.900722] 		ref#30: shared block backref parent 3874388082688
[10606.900724] 		ref#31: shared block backref parent 3873938718720
[10606.900726] 		ref#32: shared block backref parent 3873815592960
[10606.900729] 	item 37 key (5126704447488 169 0) itemoff 13904 itemsize 33
[10606.900730] 		extent refs 1 gen 895691 flags 2
[10606.900731] 		ref#0: tree block backref root 533
[10606.900735] 	item 38 key (5126704463872 169 0) itemoff 13871 itemsize 33
[10606.900736] 		extent refs 1 gen 822492 flags 2
[10606.900737] 		ref#0: tree block backref root 7
[10606.900740] 	item 39 key (5126704496640 169 0) itemoff 13838 itemsize 33
[10606.900742] 		extent refs 1 gen 895691 flags 2
[10606.900743] 		ref#0: tree block backref root 533
[10606.900746] 	item 40 key (5126704513024 169 0) itemoff 13805 itemsize 33
[10606.900748] 		extent refs 1 gen 804138 flags 2
[10606.900749] 		ref#0: tree block backref root 7
[10606.900752] 	item 41 key (5126704562176 169 0) itemoff 13772 itemsize 33
[10606.900753] 		extent refs 1 gen 895691 flags 2
[10606.900754] 		ref#0: tree block backref root 533
[10606.900757] 	item 42 key (5126704578560 169 0) itemoff 13739 itemsize 33
[10606.900759] 		extent refs 1 gen 700417 flags 2
[10606.900760] 		ref#0: tree block backref root 7
[10606.900763] 	item 43 key (5126704594944 169 0) itemoff 13706 itemsize 33
[10606.900764] 		extent refs 1 gen 895691 flags 2
[10606.900765] 		ref#0: tree block backref root 533
[10606.900768] 	item 44 key (5126704611328 169 0) itemoff 13673 itemsize 33
[10606.900770] 		extent refs 1 gen 895691 flags 2
[10606.900771] 		ref#0: tree block backref root 533
[10606.900774] 	item 45 key (5126704627712 169 0) itemoff 13622 itemsize 51
[10606.900776] 		extent refs 3 gen 895691 flags 2
[10606.900777] 		ref#0: tree block backref root 533
[10606.900779] 		ref#1: shared block backref parent 4418261401600
[10606.900780] 		ref#2: shared block backref parent 3874480766976
[10606.900783] 	item 46 key (5126704644096 169 0) itemoff 13589 itemsize 33
[10606.900785] 		extent refs 1 gen 895691 flags 2
[10606.900786] 		ref#0: tree block backref root 533
[10606.900789] 	item 47 key (5126704676864 169 0) itemoff 13556 itemsize 33
[10606.900791] 		extent refs 1 gen 877843 flags 258
[10606.900792] 		ref#0: shared block backref parent 5890331213824
[10606.900795] 	item 48 key (5126704726016 169 0) itemoff 13505 itemsize 51
[10606.900797] 		extent refs 3 gen 895691 flags 2
[10606.900798] 		ref#0: tree block backref root 533
[10606.900799] 		ref#1: shared block backref parent 4418261401600
[10606.900801] 		ref#2: shared block backref parent 3874480766976
[10606.900804] 	item 49 key (5126704742400 169 0) itemoff 13454 itemsize 51
[10606.900806] 		extent refs 3 gen 895691 flags 2
[10606.900807] 		ref#0: tree block backref root 533
[10606.900809] 		ref#1: shared block backref parent 4418261401600
[10606.900813] 		ref#2: shared block backref parent 3874480766976
[10606.900816] 	item 50 key (5126704807936 169 0) itemoff 13421 itemsize 33
[10606.900818] 		extent refs 1 gen 895691 flags 2
[10606.900819] 		ref#0: tree block backref root 533
[10606.900822] 	item 51 key (5126704840704 169 0) itemoff 13388 itemsize 33
[10606.900824] 		extent refs 1 gen 572276 flags 258
[10606.900825] 		ref#0: tree block backref root 36610
[10606.900828] 	item 52 key (5126704857088 169 0) itemoff 13355 itemsize 33
[10606.900829] 		extent refs 1 gen 572276 flags 258
[10606.900830] 		ref#0: tree block backref root 36611
[10606.900833] 	item 53 key (5126704873472 169 0) itemoff 13322 itemsize 33
[10606.900835] 		extent refs 1 gen 804138 flags 258
[10606.900836] 		ref#0: shared block backref parent 5126678069248
[10606.900839] 	item 54 key (5126704939008 169 0) itemoff 13289 itemsize 33
[10606.900841] 		extent refs 1 gen 846237 flags 2
[10606.900842] 		ref#0: tree block backref root 7
[10606.900845] 	item 55 key (5126704988160 169 0) itemoff 13247 itemsize 42
[10606.900847] 		extent refs 2 gen 573020 flags 258
[10606.900848] 		ref#0: shared block backref parent 6239684837376
[10606.900849] 		ref#1: shared block backref parent 6239665651712
[10606.900852] 	item 56 key (5126705004544 169 0) itemoff 13214 itemsize 33
[10606.900854] 		extent refs 1 gen 573020 flags 258
[10606.900855] 		ref#0: shared block backref parent 4033915666432
[10606.900858] 	item 57 key (5126705020928 169 0) itemoff 13190 itemsize 24
[10606.900860] 		extent refs 21 gen 573020 flags 258
[10606.900862] 	item 58 key (5126705020928 176 532) itemoff 13190 itemsize 0
[10606.900863] 		tree block backref
[10606.900866] 	item 59 key (5126705020928 182 3873628733440) itemoff
13190 itemsize 0
[10606.900867] 		shared block backref
[10606.900869] 	item 60 key (5126705020928 182 3874100428800) itemoff
13190 itemsize 0
[10606.900870] 		shared block backref
[10606.900873] 	item 61 key (5126705020928 182 3874135769088) itemoff
13190 itemsize 0
[10606.900874] 		shared block backref
[10606.900876] 	item 62 key (5126705020928 182 3874277539840) itemoff
13190 itemsize 0
[10606.900877] 		shared block backref
[10606.900879] 	item 63 key (5126705020928 182 3874338521088) itemoff
13190 itemsize 0
[10606.900880] 		shared block backref
[10606.900882] 	item 64 key (5126705020928 182 4032430833664) itemoff
13190 itemsize 0
[10606.900883] 		shared block backref
[10606.900886] 	item 65 key (5126705020928 182 4134224527360) itemoff
13190 itemsize 0
[10606.900887] 		shared block backref
[10606.900889] 	item 66 key (5126705020928 182 4134425313280) itemoff
13190 itemsize 0
[10606.900890] 		shared block backref
[10606.900892] 	item 67 key (5126705020928 182 4418115616768) itemoff
13190 itemsize 0
[10606.900893] 		shared block backref
[10606.900895] 	item 68 key (5126705020928 182 4418150318080) itemoff
13190 itemsize 0
[10606.900897] 		shared block backref
[10606.900899] 	item 69 key (5126705020928 182 4418758901760) itemoff
13190 itemsize 0
[10606.900900] 		shared block backref
[10606.900904] 	item 70 key (5126705020928 182 4419095756800) itemoff
13190 itemsize 0
[10606.900905] 		shared block backref
[10606.900908] 	item 71 key (5126705020928 182 5126063407104) itemoff
13190 itemsize 0
[10606.900909] 		shared block backref
[10606.900911] 	item 72 key (5126705020928 182 5126606422016) itemoff
13190 itemsize 0
[10606.900912] 		shared block backref
[10606.900914] 	item 73 key (5126705020928 182 5890397913088) itemoff
13190 itemsize 0
[10606.900915] 		shared block backref
[10606.900917] 	item 74 key (5126705020928 182 6239665651712) itemoff
13190 itemsize 0
[10606.900918] 		shared block backref
[10606.900921] 	item 75 key (5126705020928 182 6239684837376) itemoff
13190 itemsize 0
[10606.900922] 		shared block backref
[10606.900924] 	item 76 key (5126705020928 182 6239763693568) itemoff
13190 itemsize 0
[10606.900925] 		shared block backref
[10606.900927] 	item 77 key (5126705020928 182 6299583938560) itemoff
13190 itemsize 0
[10606.900928] 		shared block backref
[10606.900930] 	item 78 key (5126705020928 182 6299787411456) itemoff
13190 itemsize 0
[10606.900931] 		shared block backref
[10606.900934] 	item 79 key (5126705037312 169 0) itemoff 13157 itemsize 33
[10606.900936] 		extent refs 1 gen 778780 flags 2
[10606.900937] 		ref#0: tree block backref root 7
[10606.900939] 	item 80 key (5126705053696 169 0) itemoff 13124 itemsize 33
[10606.900941] 		extent refs 1 gen 877843 flags 258
[10606.900942] 		ref#0: shared block backref parent 5890331213824
[10606.900945] 	item 81 key (5126705070080 169 0) itemoff 13091 itemsize 33
[10606.900947] 		extent refs 1 gen 717886 flags 2
[10606.900948] 		ref#0: tree block backref root 36611
[10606.900951] 	item 82 key (5126705086464 169 0) itemoff 13049 itemsize 42
[10606.900953] 		extent refs 2 gen 573938 flags 258
[10606.900954] 		ref#0: tree block backref root 36611
[10606.900956] 		ref#1: shared block backref parent 3874585083904
[10606.900959] 	item 83 key (5126705102848 169 0) itemoff 12980 itemsize 69
[10606.900961] 		extent refs 5 gen 575420 flags 258
[10606.900962] 		ref#0: tree block backref root 36610
[10606.900963] 		ref#1: shared block backref parent 6299900706816
[10606.900965] 		ref#2: shared block backref parent 4717197983744
[10606.900967] 		ref#3: shared block backref parent 4033704787968
[10606.900969] 		ref#4: shared block backref parent 4031815630848
[10606.900972] 	item 84 key (5126705266688 169 0) itemoff 12947 itemsize 33
[10606.900976] 		extent refs 1 gen 892179 flags 2
[10606.900977] 		ref#0: tree block backref root 7
[10606.900980] 	item 85 key (5126705315840 169 0) itemoff 12914 itemsize 33
[10606.900981] 		extent refs 1 gen 895691 flags 2
[10606.900982] 		ref#0: tree block backref root 533
[10606.900985] 	item 86 key (5126705430528 169 0) itemoff 12881 itemsize 33
[10606.900987] 		extent refs 1 gen 564092 flags 2
[10606.900988] 		ref#0: tree block backref root 7
[10606.900991] 	item 87 key (5126705446912 169 0) itemoff 12848 itemsize 33
[10606.900993] 		extent refs 1 gen 564092 flags 2
[10606.900994] 		ref#0: tree block backref root 7
[10606.900997] 	item 88 key (5126705463296 169 0) itemoff 12815 itemsize 33
[10606.900998] 		extent refs 1 gen 564092 flags 2
[10606.900999] 		ref#0: tree block backref root 7
[10606.901002] 	item 89 key (5126705479680 169 0) itemoff 12782 itemsize 33
[10606.901004] 		extent refs 1 gen 564092 flags 2
[10606.901005] 		ref#0: tree block backref root 7
[10606.901008] 	item 90 key (5126705496064 169 0) itemoff 12749 itemsize 33
[10606.901010] 		extent refs 1 gen 564092 flags 2
[10606.901011] 		ref#0: tree block backref root 7
[10606.901013] 	item 91 key (5126705512448 169 0) itemoff 12716 itemsize 33
[10606.901015] 		extent refs 1 gen 564092 flags 2
[10606.901016] 		ref#0: tree block backref root 7
[10606.901019] 	item 92 key (5126705528832 169 0) itemoff 12683 itemsize 33
[10606.901021] 		extent refs 1 gen 564092 flags 2
[10606.901022] 		ref#0: tree block backref root 7
[10606.901025] 	item 93 key (5126705545216 169 0) itemoff 12650 itemsize 33
[10606.901026] 		extent refs 1 gen 564092 flags 2
[10606.901027] 		ref#0: tree block backref root 7
[10606.901030] 	item 94 key (5126705561600 169 0) itemoff 12617 itemsize 33
[10606.901032] 		extent refs 1 gen 564092 flags 2
[10606.901033] 		ref#0: tree block backref root 7
[10606.901036] 	item 95 key (5126705577984 169 0) itemoff 12584 itemsize 33
[10606.901037] 		extent refs 1 gen 564092 flags 2
[10606.901038] 		ref#0: tree block backref root 7
[10606.901041] 	item 96 key (5126705594368 169 0) itemoff 12551 itemsize 33
[10606.901045] 		extent refs 1 gen 564092 flags 2
[10606.901046] 		ref#0: tree block backref root 7
[10606.901049] 	item 97 key (5126705610752 169 0) itemoff 12518 itemsize 33
[10606.901051] 		extent refs 1 gen 564092 flags 2
[10606.901052] 		ref#0: tree block backref root 7
[10606.901055] 	item 98 key (5126705627136 169 0) itemoff 12485 itemsize 33
[10606.901056] 		extent refs 1 gen 564092 flags 2
[10606.901057] 		ref#0: tree block backref root 7
[10606.901060] 	item 99 key (5126705643520 169 0) itemoff 12452 itemsize 33
[10606.901062] 		extent refs 1 gen 564092 flags 2
[10606.901063] 		ref#0: tree block backref root 7
[10606.901066] 	item 100 key (5126705659904 169 0) itemoff 12419 itemsize 33
[10606.901068] 		extent refs 1 gen 564092 flags 2
[10606.901069] 		ref#0: tree block backref root 7
[10606.901071] 	item 101 key (5126705676288 169 0) itemoff 12386 itemsize 33
[10606.901073] 		extent refs 1 gen 564092 flags 2
[10606.901074] 		ref#0: tree block backref root 7
[10606.901077] 	item 102 key (5126705692672 169 0) itemoff 12353 itemsize 33
[10606.901079] 		extent refs 1 gen 564092 flags 2
[10606.901080] 		ref#0: tree block backref root 7
[10606.901083] 	item 103 key (5126705709056 169 0) itemoff 12320 itemsize 33
[10606.901084] 		extent refs 1 gen 564092 flags 2
[10606.901085] 		ref#0: tree block backref root 7
[10606.901088] 	item 104 key (5126705725440 169 0) itemoff 12287 itemsize 33
[10606.901090] 		extent refs 1 gen 564092 flags 2
[10606.901091] 		ref#0: tree block backref root 7
[10606.901094] 	item 105 key (5126705741824 169 0) itemoff 12200 itemsize 87
[10606.901095] 		extent refs 7 gen 682198 flags 258
[10606.901096] 		ref#0: shared block backref parent 6239857868800
[10606.901098] 		ref#1: shared block backref parent 5126678396928
[10606.901100] 		ref#2: shared block backref parent 4717112098816
[10606.901101] 		ref#3: shared block backref parent 4418511962112
[10606.901103] 		ref#4: shared block backref parent 4418366947328
[10606.901105] 		ref#5: shared block backref parent 4030842454016
[10606.901106] 		ref#6: shared block backref parent 3873889943552
[10606.901110] 	item 106 key (5126705758208 169 0) itemoff 12167 itemsize 33
[10606.901112] 		extent refs 1 gen 895691 flags 2
[10606.901115] 		ref#0: tree block backref root 533
[10606.901118] 	item 107 key (5126705774592 169 0) itemoff 12134 itemsize 33
[10606.901120] 		extent refs 1 gen 892179 flags 2
[10606.901121] 		ref#0: tree block backref root 7
[10606.901124] 	item 108 key (5126705790976 169 0) itemoff 12101 itemsize 33
[10606.901125] 		extent refs 1 gen 563669 flags 2
[10606.901126] 		ref#0: tree block backref root 7
[10606.901129] 	item 109 key (5126705807360 169 0) itemoff 12068 itemsize 33
[10606.901131] 		extent refs 1 gen 892179 flags 2
[10606.901132] 		ref#0: tree block backref root 7
[10606.901135] 	item 110 key (5126705856512 169 0) itemoff 11954
itemsize 114
[10606.901136] 		extent refs 10 gen 895691 flags 2
[10606.901138] 		ref#0: tree block backref root 533
[10606.901139] 		ref#1: shared block backref parent 6299845394432
[10606.901141] 		ref#2: shared block backref parent 5890961948672
[10606.901143] 		ref#3: shared block backref parent 5890680995840
[10606.901145] 		ref#4: shared block backref parent 4716737904640
[10606.901146] 		ref#5: shared block backref parent 4419087400960
[10606.901148] 		ref#6: shared block backref parent 4418875703296
[10606.901150] 		ref#7: shared block backref parent 3874598715392
[10606.901151] 		ref#8: shared block backref parent 3874340356096
[10606.901153] 		ref#9: shared block backref parent 3874309570560
[10606.901156] 	item 111 key (5126705905664 169 0) itemoff 11921 itemsize 33
[10606.901158] 		extent refs 1 gen 563669 flags 2
[10606.901159] 		ref#0: tree block backref root 7
[10606.901162] 	item 112 key (5126705922048 169 0) itemoff 11888 itemsize 33
[10606.901164] 		extent refs 1 gen 563669 flags 2
[10606.901165] 		ref#0: tree block backref root 7
[10606.901168] 	item 113 key (5126706053120 169 0) itemoff 11855 itemsize 33
[10606.901169] 		extent refs 1 gen 846237 flags 2
[10606.901170] 		ref#0: tree block backref root 7
[10606.901173] 	item 114 key (5126706135040 169 0) itemoff 11822 itemsize 33
[10606.901175] 		extent refs 1 gen 895691 flags 2
[10606.901176] 		ref#0: tree block backref root 533
[10606.901179] 	item 115 key (5126706184192 169 0) itemoff 11789 itemsize 33
[10606.901181] 		extent refs 1 gen 895691 flags 2
[10606.901184] 		ref#0: tree block backref root 533
[10606.901187] 	item 116 key (5126706216960 169 0) itemoff 11756 itemsize 33
[10606.901189] 		extent refs 1 gen 563669 flags 2
[10606.901190] 		ref#0: tree block backref root 7
[10606.901193] 	item 117 key (5126706233344 169 0) itemoff 11723 itemsize 33
[10606.901194] 		extent refs 1 gen 563669 flags 2
[10606.901195] 		ref#0: tree block backref root 7
[10606.901198] 	item 118 key (5126706249728 169 0) itemoff 11690 itemsize 33
[10606.901200] 		extent refs 1 gen 877843 flags 258
[10606.901201] 		ref#0: shared block backref parent 5890331213824
[10606.901204] 	item 119 key (5126706266112 169 0) itemoff 11657 itemsize 33
[10606.901206] 		extent refs 1 gen 892179 flags 2
[10606.901207] 		ref#0: tree block backref root 7
[10606.901210] 	item 120 key (5126706298880 169 0) itemoff 11624 itemsize 33
[10606.901211] 		extent refs 1 gen 895691 flags 2
[10606.901212] 		ref#0: tree block backref root 533
[10606.901215] 	item 121 key (5126706397184 169 0) itemoff 11591 itemsize 33
[10606.901217] 		extent refs 1 gen 804138 flags 258
[10606.901218] 		ref#0: shared block backref parent 5126679347200
[10606.901221] 	item 122 key (5126706561024 169 0) itemoff 11558 itemsize 33
[10606.901223] 		extent refs 1 gen 895691 flags 2
[10606.901224] 		ref#0: tree block backref root 533
[10606.901227] 	item 123 key (5126706692096 169 0) itemoff 11525 itemsize 33
[10606.901229] 		extent refs 1 gen 895691 flags 2
[10606.901230] 		ref#0: tree block backref root 533
[10606.901233] 	item 124 key (5126706724864 169 0) itemoff 11087
itemsize 438
[10606.901234] 		extent refs 46 gen 885323 flags 2
[10606.901235] 		ref#0: tree block backref root 10262
[10606.901237] 		ref#1: shared block backref parent 6300271443968
[10606.901239] 		ref#2: shared block backref parent 6300177645568
[10606.901240] 		ref#3: shared block backref parent 6300087877632
[10606.901242] 		ref#4: shared block backref parent 6299851292672
[10606.901244] 		ref#5: shared block backref parent 6299576254464
[10606.901246] 		ref#6: shared block backref parent 6299308621824
[10606.901248] 		ref#7: shared block backref parent 6240101318656
[10606.901249] 		ref#8: shared block backref parent 6239972589568
[10606.901253] 		ref#9: shared block backref parent 5891141632000
[10606.901255] 		ref#10: shared block backref parent 5891082911744
[10606.901257] 		ref#11: shared block backref parent 5891042951168
[10606.901258] 		ref#12: shared block backref parent 5890615246848
[10606.901260] 		ref#13: shared block backref parent 5890463039488
[10606.901262] 		ref#14: shared block backref parent 5890436890624
[10606.901263] 		ref#15: shared block backref parent 5126231179264
[10606.901265] 		ref#16: shared block backref parent 5125855133696
[10606.901267] 		ref#17: shared block backref parent 5125777653760
[10606.901268] 		ref#18: shared block backref parent 4717386399744
[10606.901270] 		ref#19: shared block backref parent 4716953616384
[10606.901272] 		ref#20: shared block backref parent 4716869992448
[10606.901273] 		ref#21: shared block backref parent 4716604555264
[10606.901275] 		ref#22: shared block backref parent 4716575670272
[10606.901277] 		ref#23: shared block backref parent 4716547129344
[10606.901278] 		ref#24: shared block backref parent 4418653339648
[10606.901280] 		ref#25: shared block backref parent 4418457927680
[10606.901282] 		ref#26: shared block backref parent 4418052734976
[10606.901283] 		ref#27: shared block backref parent 4134522355712
[10606.901285] 		ref#28: shared block backref parent 4133585420288
[10606.901287] 		ref#29: shared block backref parent 4034188083200
[10606.901288] 		ref#30: shared block backref parent 4034125447168
[10606.901290] 		ref#31: shared block backref parent 4034077949952
[10606.901292] 		ref#32: shared block backref parent 4034073935872
[10606.901294] 		ref#33: shared block backref parent 4033156546560
[10606.901295] 		ref#34: shared block backref parent 4032730021888
[10606.901297] 		ref#35: shared block backref parent 4032197132288
[10606.901298] 		ref#36: shared block backref parent 4032101384192
[10606.901300] 		ref#37: shared block backref parent 4031949127680
[10606.901302] 		ref#38: shared block backref parent 4031297765376
[10606.901303] 		ref#39: shared block backref parent 4031202394112
[10606.901305] 		ref#40: shared block backref parent 4030981292032
[10606.901307] 		ref#41: shared block backref parent 4030556012544
[10606.901309] 		ref#42: shared block backref parent 3874566619136
[10606.901310] 		ref#43: shared block backref parent 3874460270592
[10606.901312] 		ref#44: shared block backref parent 3874229714944
[10606.901314] 		ref#45: shared block backref parent 3873657765888
[10606.901317] 	item 125 key (5126706741248 169 0) itemoff 11036 itemsize 51
[10606.901318] 		extent refs 3 gen 895691 flags 2
[10606.901319] 		ref#0: tree block backref root 533
[10606.901321] 		ref#1: shared block backref parent 4418261401600
[10606.901323] 		ref#2: shared block backref parent 3874480766976
[10606.901326] 	item 126 key (5126706806784 169 0) itemoff 11003 itemsize 33
[10606.901328] 		extent refs 1 gen 892179 flags 2
[10606.901329] 		ref#0: tree block backref root 7
[10606.901332] 	item 127 key (5126706823168 169 0) itemoff 10970 itemsize 33
[10606.901336] 		extent refs 1 gen 626173 flags 2
[10606.901337] 		ref#0: tree block backref root 277
[10606.901340] 	item 128 key (5126706872320 169 0) itemoff 10937 itemsize 33
[10606.901341] 		extent refs 1 gen 895691 flags 2
[10606.901342] 		ref#0: tree block backref root 533
[10606.901345] 	item 129 key (5126706888704 169 0) itemoff 10904 itemsize 33
[10606.901347] 		extent refs 1 gen 895691 flags 2
[10606.901348] 		ref#0: tree block backref root 533
[10606.901351] 	item 130 key (5126706970624 169 0) itemoff 10871 itemsize 33
[10606.901353] 		extent refs 1 gen 895691 flags 2
[10606.901354] 		ref#0: tree block backref root 7
[10606.901357] 	item 131 key (5126706987008 169 0) itemoff 10838 itemsize 33
[10606.901358] 		extent refs 1 gen 626173 flags 2
[10606.901359] 		ref#0: tree block backref root 7
[10606.901362] 	item 132 key (5126707003392 169 0) itemoff 10805 itemsize 33
[10606.901364] 		extent refs 1 gen 626173 flags 2
[10606.901365] 		ref#0: tree block backref root 7
[10606.901368] 	item 133 key (5126707019776 169 0) itemoff 10772 itemsize 33
[10606.901369] 		extent refs 1 gen 626173 flags 2
[10606.901370] 		ref#0: tree block backref root 7
[10606.901373] 	item 134 key (5126707036160 169 0) itemoff 10739 itemsize 33
[10606.901375] 		extent refs 1 gen 574483 flags 2
[10606.901376] 		ref#0: tree block backref root 2
[10606.901379] 	item 135 key (5126707052544 169 0) itemoff 10706 itemsize 33
[10606.901381] 		extent refs 1 gen 626173 flags 2
[10606.901382] 		ref#0: tree block backref root 7
[10606.901385] 	item 136 key (5126707068928 169 0) itemoff 10673 itemsize 33
[10606.901386] 		extent refs 1 gen 626173 flags 2
[10606.901387] 		ref#0: tree block backref root 7
[10606.901390] 	item 137 key (5126707085312 169 0) itemoff 10640 itemsize 33
[10606.901392] 		extent refs 1 gen 626173 flags 2
[10606.901393] 		ref#0: tree block backref root 7
[10606.901396] 	item 138 key (5126707101696 169 0) itemoff 10607 itemsize 33
[10606.901397] 		extent refs 1 gen 626173 flags 2
[10606.901398] 		ref#0: tree block backref root 7
[10606.901401] 	item 139 key (5126707134464 169 0) itemoff 10565 itemsize 42
[10606.901403] 		extent refs 2 gen 804138 flags 258
[10606.901404] 		ref#0: shared block backref parent 5126679347200
[10606.901406] 		ref#1: shared block backref parent 3873639481344
[10606.901409] 	item 140 key (5126707150848 169 0) itemoff 10532 itemsize 33
[10606.901411] 		extent refs 1 gen 626173 flags 2
[10606.901414] 		ref#0: tree block backref root 7
[10606.901417] 	item 141 key (5126707183616 169 0) itemoff 10499 itemsize 33
[10606.901419] 		extent refs 1 gen 626173 flags 2
[10606.901420] 		ref#0: tree block backref root 7
[10606.901423] 	item 142 key (5126707200000 169 0) itemoff 10466 itemsize 33
[10606.901424] 		extent refs 1 gen 895691 flags 2
[10606.901425] 		ref#0: tree block backref root 533
[10606.901428] 	item 143 key (5126707216384 169 0) itemoff 10433 itemsize 33
[10606.901430] 		extent refs 1 gen 895691 flags 2
[10606.901431] 		ref#0: tree block backref root 533
[10606.901434] 	item 144 key (5126707232768 169 0) itemoff 10400 itemsize 33
[10606.901436] 		extent refs 1 gen 895691 flags 2
[10606.901437] 		ref#0: tree block backref root 533
[10606.901440] 	item 145 key (5126707265536 169 0) itemoff 10358 itemsize 42
[10606.901441] 		extent refs 2 gen 804138 flags 258
[10606.901442] 		ref#0: shared block backref parent 5126679347200
[10606.901444] 		ref#1: shared block backref parent 3873639481344
[10606.901447] 	item 146 key (5126707298304 169 0) itemoff 9911 itemsize 447
[10606.901449] 		extent refs 47 gen 885323 flags 2
[10606.901450] 		ref#0: tree block backref root 10262
[10606.901452] 		ref#1: shared block backref parent 6300271443968
[10606.901454] 		ref#2: shared block backref parent 6300177645568
[10606.901455] 		ref#3: shared block backref parent 6300087877632
[10606.901457] 		ref#4: shared block backref parent 6299851292672
[10606.901459] 		ref#5: shared block backref parent 6299576254464
[10606.901460] 		ref#6: shared block backref parent 6299308621824
[10606.901462] 		ref#7: shared block backref parent 6240101318656
[10606.901464] 		ref#8: shared block backref parent 6239972589568
[10606.901466] 		ref#9: shared block backref parent 5891141632000
[10606.901467] 		ref#10: shared block backref parent 5891082911744
[10606.901469] 		ref#11: shared block backref parent 5891042951168
[10606.901471] 		ref#12: extent data backref root 5890615246848 objectid
1507958538109110 offset 386035672063981056 count 11927552
[10606.901473] 		ref#13: (extent 3873928691712 has INVALID ref type 64)
[10606.901478] BTRFS error (device sdf4): eb 3873928691712 invalid
extent inline ref type 178
[10606.901479] ------------[ cut here ]------------
[10606.901592] WARNING: CPU: 1 PID: 4143 at fs/btrfs/extent-tree.c:1043
btrfs_get_extent_inline_ref_type+0xf5/0x100 [btrfs]
[10606.901593] Modules linked in: uas usb_storage cfg80211 rfkill 8021q
garp mrp stp llc nls_iso8859_1 nls_cp437 vfat fat fuse radeon coretemp
kvm_intel kvm i2c_algo_bit ttm snd_hda_codec_hdmi iTCO_wdt gpio_ich
iTCO_vendor_support raid1 drm_kms_helper snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_intel raid456 snd_hda_codec
async_raid6_recov async_memcpy async_pq async_xor async_tx snd_hda_core
drm md_mod snd_hwdep irqbypass snd_pcm pcspkr i2c_i801 joydev sky2
snd_timer evdev syscopyarea input_leds mousedev intel_agp sysfillrect
snd sysimgblt mac_hid acpi_cpufreq intel_gtt fb_sys_fops lpc_ich agpgart
soundcore ip_tables x_tables btrfs libcrc32c crc32c_generic xor raid6_pq
sr_mod cdrom sd_mod hid_generic ata_generic usbhid pata_acpi hid ahci
pata_jmicron libahci ata_piix uhci_hcd libata scsi_mod ehci_pci ehci_hcd
[10606.901652] CPU: 1 PID: 4143 Comm: btrfs-transacti Not tainted
5.3.1-arch1-1-ARCH #1
[10606.901653] Hardware name:  /965G-DS3, BIOS F2 08/15/2006
[10606.901687] RIP: 0010:btrfs_get_extent_inline_ref_type+0xf5/0x100 [btrfs]
[10606.901691] Code: 89 ef e8 fe b6 00 00 49 8b 7d 18 49 8b 55 00 44 89
e1 48 c7 c6 f0 af 75 c0 e8 24 b9 0a 00 48 c7 c7 38 ae 75 c0 e8 79 57 c6
ed <0f> 0b 45 31 e4 eb 8e 0f 1f 40 00 66 66 66 66 90 41 57 41 56 41 55
[10606.901693] RSP: 0018:ffff969380bcbb10 EFLAGS: 00010246
[10606.901697] RAX: 0000000000000024 RBX: 0000000000000001 RCX:
0000000000000000
[10606.901699] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
00000000ffffffff
[10606.901700] RBP: 00000000000027a0 R08: 0000000000000658 R09:
0000000000000001
[10606.901702] R10: 0000000000000000 R11: 0000000000000001 R12:
00000000000000b2
[10606.901704] R13: ffff917b025fed68 R14: 00000000000000b6 R15:
00000000000111ff
[10606.901707] FS:  0000000000000000(0000) GS:ffff917b3c880000(0000)
knlGS:0000000000000000
[10606.901709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10606.901710] CR2: 00007f71b1e5c000 CR3: 00000000b07f0000 CR4:
00000000000006e0
[10606.901712] Call Trace:
[10606.901751]  lookup_inline_extent_backref+0x3fd/0x680 [btrfs]
[10606.901788]  __btrfs_free_extent.isra.0+0x14a/0x9c0 [btrfs]
[10606.901826]  __btrfs_run_delayed_refs+0x7c7/0x1080 [btrfs]
[10606.901837]  ? __switch_to_asm+0x34/0x70
[10606.901871]  btrfs_run_delayed_refs.part.0+0x4e/0x160 [btrfs]
[10606.901909]  btrfs_commit_transaction+0xaa/0x9a0 [btrfs]
[10606.901913]  ? _raw_spin_unlock+0x16/0x30
[10606.901948]  ? join_transaction+0x108/0x3a0 [btrfs]
[10606.901988]  transaction_kthread+0x13a/0x180 [btrfs]
[10606.901992]  kthread+0xfb/0x130
[10606.902029]  ? btrfs_cleanup_transaction+0x560/0x560 [btrfs]
[10606.902031]  ? kthread_park+0x80/0x80
[10606.902034]  ret_from_fork+0x35/0x40
[10606.902041] ---[ end trace b97c661ed5f4295a ]---
[10606.902043] ------------[ cut here ]------------
[10606.902044] BTRFS: Transaction aborted (error -117)
[10606.902099] WARNING: CPU: 1 PID: 4143 at fs/btrfs/extent-tree.c:4860
__btrfs_free_extent.isra.0+0x6db/0x9c0 [btrfs]
[10606.902100] Modules linked in: uas usb_storage cfg80211 rfkill 8021q
garp mrp stp llc nls_iso8859_1 nls_cp437 vfat fat fuse radeon coretemp
kvm_intel kvm i2c_algo_bit ttm snd_hda_codec_hdmi iTCO_wdt gpio_ich
iTCO_vendor_support raid1 drm_kms_helper snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_intel raid456 snd_hda_codec
async_raid6_recov async_memcpy async_pq async_xor async_tx snd_hda_core
drm md_mod snd_hwdep irqbypass snd_pcm pcspkr i2c_i801 joydev sky2
snd_timer evdev syscopyarea input_leds mousedev intel_agp sysfillrect
snd sysimgblt mac_hid acpi_cpufreq intel_gtt fb_sys_fops lpc_ich agpgart
soundcore ip_tables x_tables btrfs libcrc32c crc32c_generic xor raid6_pq
sr_mod cdrom sd_mod hid_generic ata_generic usbhid pata_acpi hid ahci
pata_jmicron libahci ata_piix uhci_hcd libata scsi_mod ehci_pci ehci_hcd
[10606.902148] CPU: 1 PID: 4143 Comm: btrfs-transacti Tainted: G
W         5.3.1-arch1-1-ARCH #1
[10606.902150] Hardware name:  /965G-DS3, BIOS F2 08/15/2006
[10606.902184] RIP: 0010:__btrfs_free_extent.isra.0+0x6db/0x9c0 [btrfs]
[10606.902187] Code: e8 1a c6 00 00 8b 4c 24 38 85 c9 0f 84 36 fe ff ff
48 8b 54 24 48 e9 01 fe ff ff 44 89 fe 48 c7 c7 d0 ae 75 c0 e8 b4 dc be
ed <0f> 0b 48 8b 3c 24 44 89 f9 ba fc 12 00 00 48 c7 c6 30 01 75 c0 e8
[10606.902189] RSP: 0018:ffff969380bcbc10 EFLAGS: 00010282
[10606.902193] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[10606.902195] RDX: 0000000000000003 RSI: 0000000000000092 RDI:
00000000ffffffff
[10606.902196] RBP: 000004a9a7914000 R08: 0000000000000678 R09:
0000000000000001
[10606.902198] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff917a9c9ee000
[10606.902200] R13: 00000404ba740000 R14: 00000000000111ff R15:
00000000ffffff8b
[10606.902202] FS:  0000000000000000(0000) GS:ffff917b3c880000(0000)
knlGS:0000000000000000
[10606.902204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10606.902206] CR2: 00007f71b1e5c000 CR3: 00000000b07f0000 CR4:
00000000000006e0
[10606.902208] Call Trace:
[10606.902245]  __btrfs_run_delayed_refs+0x7c7/0x1080 [btrfs]
[10606.902251]  ? __switch_to_asm+0x34/0x70
[10606.902285]  btrfs_run_delayed_refs.part.0+0x4e/0x160 [btrfs]
[10606.902322]  btrfs_commit_transaction+0xaa/0x9a0 [btrfs]
[10606.902328]  ? _raw_spin_unlock+0x16/0x30
[10606.902363]  ? join_transaction+0x108/0x3a0 [btrfs]
[10606.902401]  transaction_kthread+0x13a/0x180 [btrfs]
[10606.902404]  kthread+0xfb/0x130
[10606.902440]  ? btrfs_cleanup_transaction+0x560/0x560 [btrfs]
[10606.902444]  ? kthread_park+0x80/0x80
[10606.902447]  ret_from_fork+0x35/0x40
[10606.902451] ---[ end trace b97c661ed5f4295b ]---
[10606.902455] BTRFS: error (device sdf4) in __btrfs_free_extent:4860:
errno=-117 unknown
[10606.902457] BTRFS info (device sdf4): forced readonly
[10606.902462] BTRFS: error (device sdf4) in
btrfs_run_delayed_refs:2795: errno=-117 unknown
