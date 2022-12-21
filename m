Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD9652B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 02:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiLUBeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 20:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUBeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 20:34:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D28FC0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 17:34:02 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1ot2GP2p0I-00urYx; Wed, 21
 Dec 2022 02:34:00 +0100
Message-ID: <57310cd8-16b8-9918-42f5-efda114a944d@gmx.com>
Date:   Wed, 21 Dec 2022 09:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BTRFS volume unmountable: open_ctree failed
Content-Language: en-US
To:     Colin Stark <stark.colin@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACyAFTK61Ncek=WwYwvWKvN6_fECnALTzFcwqQHZKSDP3u_D0g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CACyAFTK61Ncek=WwYwvWKvN6_fECnALTzFcwqQHZKSDP3u_D0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zEHjifkf/cwnk5YaPU6xOMXtgz7fbbcOUdoX17ZZQ2XQf0j5uf6
 j05JNC696LlprBCsg3bfxnobl/yYGp/WauqMHafPs0Jm5jBdBirWASgSSgcuoQAE6b84h9m
 AHjdGykv+CMiq4y3iIByU1ixc1HbtlxgVTbepXLxo4akXMDoQTlKTdgGhNrgc+P5ahCzWHk
 kmmtNmjonA+KqQVFX+JIw==
UI-OutboundReport: notjunk:1;M01:P0:v2pK95/H7Zo=;PPVkc26y/sgpYPyoUMdKBKmUnV1
 s5BXsGdg1lhBnEUeF2cxy6W4SWaUucIu/JuzOQ7dknXsD6Ak+8aYd5YaORvPuem1r617Ktv8E
 6JzhWMbLNvdqg/0frjlT4EjanNgdL8pwz0BlRHBoyEjRyveDIkbAnFFeQN9Mh5wqdsWW8sFXt
 5g2unQlj7KUSCZCmO8b1zbL72/JL2SL4JIMB58DhZRfFA0d2c1edu8y5o4KXZdHXEFZrTGAKb
 8zeNYZrKW5zaODnuYbYfvkDmk9Ch4uC6V8zF5FhYlRuPe2s38ab062LfQuz8qb9t4irRCbCpm
 sA1lE6WbSJrCGP4/oNdieM/PmGHh7GCm3AC3mdsXC0RJP4KziaZp5wdWyAP7mqMPclmjpv3/q
 a6hWTL7ru67qF9010A7X6utkcUjxLBUOksVme6YMqJHo3XSs+SK2ufSFP+SSbaVtDU0++5/rL
 ljIuSuQnRrcHNl6WP8VchRJgDSB0R306QkUSopJ5UVY5vawnOhOaOwMO3ybqxhDW8825ACWER
 xjVuEp/k/hIE8X/Rv6Cyjf4slL7nCu2nqMlyuNesublT+EXpFHdMphoqdJlEcJKNQecWSnsiu
 RHbALPwJEaatwp5dTU1vsmL40q9uym52njFhL5MtN5rHgkMBDbaO8ZbKIVmeCCUiS1mUSRABT
 ygPTlxvXHXyH3dxDpfWNBYjIdfd6AJt7n46ewiWQCUlf1+0Utu3+3Ak5/i0FwhgW5WTs07fEe
 LJsVCVpQ2cpqbf9cF81HqqAjzer/p/CV7lJA3cnZOWQG344lOXKUD3UBeaMlerNSDX7MG4GJr
 eeQF4b1FlaIWec76B8GQROBXhr+aq60RazMIGW4iDY3N4GTt9N5WaH993kKP6nIEZDU3bkqCi
 eVPtqqk5euadHorqbYmoVtA6p7n0a73SMDvqM2UrvURiyXVj2mU3JGGBHeuuCZB6gI72tsiji
 rT5AeqH5hehDZ3sEVQun2AA6Cis=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 01:35, Colin Stark wrote:
> Hi all,
> 
> After upgrading my server from Ubuntu 22.04 to 22.10 (kernel 5.15 to
> 5.19), I am no longer able to mount my BTRFS volume.  I tried booting
> from an Ubuntu 22.04 live USB but the results are the same - something
> seems to have damaged the volume during the upgrade, although it could
> just be coincidental.
> 
> This seems to be quite a serious error as btrfs check barely even
> runs.  The volume is RAID6 spread across 10 devices.  AFAIK, all of
> the drives are in good working condition.
> 
> I'm hoping someone here is able to assist with repairing the filesystem.
> 
> dmesg shows the following errors:
> [  279.889337] BTRFS info (device sdb): using free space tree
> [  279.889341] BTRFS info (device sdb): has skinny extents
> [  279.896776] BTRFS critical (device sdb): unable to find logical
> 365541452218368 length 4096
> [  279.897009] BTRFS critical (device sdb): unable to find logical
> 365541452201984 length 4096
> [  279.897037] BTRFS critical (device sdb): unable to find logical
> 365541452185600 length 4096
> [  279.897072] BTRFS critical (device sdb): unable to find logical
> 365541452251136 length 4096
> [  279.897097] BTRFS critical (device sdb): unable to find logical
> 365541452316672 length 4096
> [  279.897113] BTRFS critical (device sdb): unable to find logical
> 365541452349440 length 4096
> [  279.897128] BTRFS critical (device sdb): unable to find logical
> 365541452300288 length 4096
> [  279.897144] BTRFS critical (device sdb): unable to find logical
> 365541452267520 length 4096
> [  279.897159] BTRFS critical (device sdb): unable to find logical
> 365541452283904 length 4096
> [  279.897175] BTRFS critical (device sdb): unable to find logical
> 365541452365824 length 4096
> [  279.897190] BTRFS critical (device sdb): unable to find logical
> 365541452333056 length 4096
> [  279.897207] BTRFS critical (device sdb): unable to find logical
> 365541452431360 length 4096
> [  279.897224] BTRFS critical (device sdb): unable to find logical
> 365555539099648 length 4096
> [  279.897239] BTRFS critical (device sdb): unable to find logical
> 365541452447744 length 4096
> [  279.897254] BTRFS critical (device sdb): unable to find logical
> 365541452382208 length 4096
> [  279.897415] BTRFS critical (device sdb): unable to find logical
> 365541452152832 length 4096
> [  279.897719] BTRFS critical (device sdb): unable to find logical
> 365541452234752 length 4096
> [  279.897938] BTRFS critical (device sdb): unable to find logical
> 365541452398592 length 4096
> [  279.897957] BTRFS critical (device sdb): unable to find logical
> 365541452169216 length 4096
> [  279.897973] BTRFS critical (device sdb): unable to find logical
> 365541452414976 length 4096
> [  279.897988] BTRFS critical (device sdb): unable to find logical
> 365541452464128 length 4096
> [  279.898004] BTRFS critical (device sdb): unable to find logical
> 365541452496896 length 4096
> [  279.898020] BTRFS critical (device sdb): unable to find logical
> 365541452480512 length 4096
> [  279.898035] BTRFS critical (device sdb): unable to find logical
> 365541452513280 length 4096
> [  279.898050] BTRFS critical (device sdb): unable to find logical
> 365541452546048 length 4096
> [  279.898065] BTRFS critical (device sdb): unable to find logical
> 365541452562432 length 4096
> [  279.898081] BTRFS critical (device sdb): unable to find logical
> 365541452578816 length 4096
> [  279.898096] BTRFS critical (device sdb): unable to find logical
> 365541452595200 length 4096
> [  279.898112] BTRFS critical (device sdb): unable to find logical
> 365541452611584 length 4096
> [  279.898127] BTRFS critical (device sdb): unable to find logical
> 365541452529664 length 4096
> [  279.898144] BTRFS critical (device sdb): unable to find logical
> 365541452627968 length 4096
> [  279.898159] BTRFS critical (device sdb): unable to find logical
> 365541452644352 length 4096
> [  279.898175] BTRFS critical (device sdb): unable to find logical
> 365541452660736 length 4096
> [  279.898192] BTRFS critical (device sdb): unable to find logical
> 365541452677120 length 4096
> [  279.898208] BTRFS critical (device sdb): unable to find logical
> 365541452693504 length 4096
> [  279.898223] BTRFS critical (device sdb): unable to find logical
> 365541452709888 length 4096
> [  279.898239] BTRFS critical (device sdb): unable to find logical
> 365541452726272 length 4096
> [  279.898257] BTRFS critical (device sdb): unable to find logical
> 365541452759040 length 4096
> [  279.898273] BTRFS critical (device sdb): unable to find logical
> 365541452742656 length 4096
> [  279.898296] BTRFS critical (device sdb): unable to find logical
> 365541452775424 length 4096
> [  279.898322] BTRFS critical (device sdb): unable to find logical
> 365541452857344 length 4096
> [  279.898339] BTRFS critical (device sdb): unable to find logical
> 365541452890112 length 4096
> [  279.898354] BTRFS critical (device sdb): unable to find logical
> 365541452824576 length 4096
> [  279.898370] BTRFS critical (device sdb): unable to find logical
> 365541452808192 length 4096
> [  279.898385] BTRFS critical (device sdb): unable to find logical
> 365541452922880 length 4096
> [  279.898400] BTRFS critical (device sdb): unable to find logical
> 365541452840960 length 4096
> [  279.898432] BTRFS critical (device sdb): unable to find logical
> 365541452906496 length 4096
> [  279.898449] BTRFS critical (device sdb): unable to find logical
> 365541452791808 length 4096
> [  279.898481] BTRFS critical (device sdb): unable to find logical
> 365541452873728 length 4096
> [  279.898515] BTRFS critical (device sdb): unable to find logical
> 365555539132416 length 4096
> [  279.898532] BTRFS critical (device sdb): unable to find logical
> 365555539197952 length 4096
> [  279.898548] BTRFS critical (device sdb): unable to find logical
> 365555539181568 length 4096
> [  279.906703] BTRFS critical (device sdb): unable to find logical
> 365541452218368 length 4096
> [  279.906722] BTRFS critical (device sdb): unable to find logical
> 365541452218368 length 16384
> [  279.906737] BTRFS error (device sdb): failed to read chunk tree: -22
> [  279.938495] BTRFS error (device sdb): open_ctree failed
> 
> btrfs check output:
> root@server:~# btrfs check /dev/sdb
> Opening filesystem to check...
> No mapping for 365541452218368-365541452234752
> Couldn't map the block 365541452218368
> Couldn't map the block 365541452218368
> bad tree block 365541452218368, bytenr mismatch, want=365541452218368, have=0
> Couldn't read chunk tree
> ERROR: cannot open file system

This means your system chunk array in your super block is not containing 
the correct system chunk mapping.

Thus btrfs is unable to read chunk tree at bootstrap.

Since you have nothing to lose, you may want to try "btrfs rescue 
chunk-recover".

Thanks,
Qu

> 
> 
> 
> uname -a: Linux server 5.19.0-26-generic #27-Ubuntu SMP
> PREEMPT_DYNAMIC Wed Nov 23 20:44:15 UTC 2022 x86_64 x86_64 x86_64
> GNU/Linux
> 
> btrfs --version: btrfs-progs v5.19
> 
> Full dmesg log is attached (gzipped).
> 
> Thanks for your help!
