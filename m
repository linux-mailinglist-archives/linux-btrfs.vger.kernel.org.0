Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84960E5219
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505860AbfJYRMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 13:12:43 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:43664 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505797AbfJYRMm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 13:12:42 -0400
Received: by mail-yw1-f41.google.com with SMTP id g77so1025043ywb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sUxwt0W5cq0UI2NW6gfkATXf4rkLxftk3dYGN3/tD88=;
        b=Yoj2E2JRX/rIHUvGjWtBIYeGWd0ClWzr2FcrO/DS2nj8KcDfr2rbx5VifoqGF8udR5
         ZUr6ksVT4vOBGkupLQHs1n/Bapwr+kPmrtEufGYhC53Fl3Y0hQpQi/v4oMaqIIfOVJOS
         i9VllMkQZymzMB5C050S2MT1fxAfqB5MZhNNCnkZXeqoaEq8qLe1btle7cOgLIZXXasL
         DD1lD9vig2tcgRRFRJ6ZldxVDGRpsTT1jCjWqSr6moxLVHMKJ5aIs14Rc30mMKL0Y8dc
         0+GpwDG4rADGIWXVGlPlC3ILbfj/8Sah4375MH6owZVQQdZ3+0eWErJ25O8nxwJMDT+2
         s1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sUxwt0W5cq0UI2NW6gfkATXf4rkLxftk3dYGN3/tD88=;
        b=D6Aj2PIg04lFIY9OMIY6rIsA/L+vFHbW2ArIH2PLqmhNodLVyb5BWfNHYxPLo77M8+
         VjqrkdYqP7K6seFc7Pve3h7HFEO544xezcteebN4DhqyXoDdrkNyQ8ilSqifrkj8f0bJ
         +PdnBxOTDbsVn8JN9IIn4ETH2IgA/Du9W5VpzwCmp4KzkTCXIycZBYKYsm61vGb7a+a4
         SdB2ECXn8weAR7OfQ+WxDOIGQ4+DiPSkItHTAyIHsui4VGCFlX9VomrUaa2b8brwY0Np
         fXI0zqIXJlG7Q7/1ipJVu4DX5gJcXxXrcOVCPThhU4zknS9NZRSri6h057yOAzHZVP0W
         hunw==
X-Gm-Message-State: APjAAAXvvAAQEnQ9rs/sdXAdkjlJ/iGRguy0Ww0S0U0xUfQTGs087P21
        zqpdmIjcxrsz/hhH3RkilI57xE5vfps=
X-Google-Smtp-Source: APXvYqxnAHPOWNen7MeAOTsa+4YVrx/etR7SzEjJeLBIiE5z898q6nLVE6NHpUREQmqafeN3MSDA5w==
X-Received: by 2002:a0d:d0c1:: with SMTP id s184mr2975479ywd.339.1572023558863;
        Fri, 25 Oct 2019 10:12:38 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id j3sm1946255ywb.10.2019.10.25.10.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 10:12:38 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
 <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <516c1f07-30ba-298d-975a-4acd33767261@gmail.com>
Date:   Fri, 25 Oct 2019 13:12:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-25 12:43, Christian Pernegger wrote:
> Am Do., 24. Okt. 2019 um 13:26 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>> Since you're using v5.0 kernel, it's pretty hard to just compile the btrfs module.
> 
> Oh, I'm not married to 5.0, it's just that I'd prefer building a
> kernel package, so it integrates properly with the system. For
> posterity, on Linux Mint 19.2:
> 
> # clone repo
> $ git clone https://github.com/adam900710/linux.git
> 
> # check commit history
> (https://github.com/adam900710/linux/commits/rescue_options) for the
> release the rescue_options branch is based on =>  5.3-rc7
> # download the Ubuntu patches matching that version (=>
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc7/) and apply
> them to the rescue_options branch
> $ wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc7/0001-base-packaging.patch
> [... repeat for the rest ...]
> $ cd linux
> $ git checkout rescue_options
> $ patch -p1 <../0001-*.patch
> [... repeat for the rest ...]
> 
> # set number of threads to use for compilation, optional & to taste
> export DEB_BUILD_OPTIONS='parallel=16'
> 
> # build; could probably trim these targets down more
> $ fakeroot debian/rules clean
> $ fakeroot debian/rules do_mainline_build=true binary-headers
> binary-generic binary-perarch
> cd ..
> 
> # install
> dpkg -i linux-image-*_amd64.deb linux-modules-*_amd64.deb linux-headers-*.deb
> 
> 
> Ok then, let's do this:
>> Then you can boot into the new kernel, then try mount it with -o
>> "resuce=skip_bg,ro".
> 
> [  565.097058]  nbd0: p1 p2
> [  565.192002] BTRFS: device fsid c2bd83d6-2261-47bb-8d18-5aba949651d7
> devid 1 transid 58603 /dev/nbd0p2
> [  568.490654]  nbd0: p1 p2
> [  869.871598] BTRFS info (device dm-1): unrecognized rescue option 'skip_bg'
> [  869.884644] BTRFS error (device dm-1): open_ctree failed
> 
> Hmm, glancing at the source I think it's "skipbg", no underscore(?)
> 
> [ 1350.402586] BTRFS info (device dm-1): skip mount time block group searching
> [ 1350.402588] BTRFS info (device dm-1): disk space caching is enabled
> [ 1350.402589] BTRFS info (device dm-1): has skinny extents
> [ 1350.402590] BTRFS error (device dm-1): skip_bg must be used with
> notreelog mount option for dirty log
> [ 1350.419849] BTRFS error (device dm-1): open_ctree failed
> 
> Fine by me, let's add "notreelog" as well. Note that "skip_bg" is
> actually written with an underscore above.
> 
> [ 1399.169484] BTRFS info (device dm-1): disabling tree log
> [ 1399.169487] BTRFS info (device dm-1): skip mount time block group searching
> [ 1399.169488] BTRFS info (device dm-1): disk space caching is enabled
> [ 1399.169488] BTRFS info (device dm-1): has skinny extents
> [ 1399.319294] BTRFS info (device dm-1): enabling ssd optimizations
> [ 1399.376181] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1399.376185] #PF: supervisor write access in kernel mode
> [ 1399.376186] #PF: error_code(0x0002) - not-present page
> [ 1399.376187] PGD 0 P4D 0
> [ 1399.376190] Oops: 0002 [#1] SMP NOPTI
> [ 1399.376193] CPU: 10 PID: 3730 Comm: mount Not tainted
> 5.3.0-050300rc7-generic #201909021831
> [ 1399.376194] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
> MASTER/X570 AORUS MASTER, BIOS F7a 09/09/2019
> [ 1399.376199] RIP: 0010:_raw_spin_lock+0x10/0x30
> [ 1399.376201] Code: 01 00 00 75 06 48 89 d8 5b 5d c3 e8 4a 75 66 ff
> 48 89 d8 5b 5d c3 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 75 02 5d c3 89 c6 e8 01 5d 66 ff 66 90 5d c3 0f
> 1f 00
> [ 1399.376202] RSP: 0018:ffffaec3c2d33370 EFLAGS: 00010246
> [ 1399.376204] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [ 1399.376205] RDX: 0000000000000001 RSI: ffffa0487f540248 RDI: 0000000000000000
> [ 1399.376206] RBP: ffffaec3c2d33370 R08: ffffaec3c2d335a7 R09: 0000000000000002
> [ 1399.376207] R10: 00000000ffffffff R11: ffffaec3c2d338a5 R12: 0000000000004000
> [ 1399.376208] R13: ffffa0487f540000 R14: 0000000000000000 R15: ffffa04d0e6d5800
> [ 1399.376210] FS:  00007fafdb068080(0000) GS:ffffa04d7ea80000(0000)
> knlGS:0000000000000000
> [ 1399.376211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1399.376212] CR2: 0000000000000000 CR3: 0000000494ea0000 CR4: 0000000000340ee0
> [ 1399.376213] Call Trace:
> [ 1399.376239]  btrfs_reserve_metadata_bytes+0x51/0x9c0 [btrfs]
> [ 1399.376241]  ? __switch_to_asm+0x40/0x70
> [ 1399.376242]  ? __switch_to_asm+0x34/0x70
> [ 1399.376243]  ? __switch_to_asm+0x40/0x70
> [ 1399.376245]  ? __switch_to_asm+0x34/0x70
> [ 1399.376246]  ? __switch_to_asm+0x40/0x70
> [ 1399.376247]  ? __switch_to_asm+0x34/0x70
> [ 1399.376248]  ? __switch_to_asm+0x40/0x70
> [ 1399.376249]  ? __switch_to_asm+0x34/0x70
> [ 1399.376250]  ? __switch_to_asm+0x40/0x70
> [ 1399.376251]  ? __switch_to_asm+0x34/0x70
> [ 1399.376252]  ? __switch_to_asm+0x40/0x70
> [ 1399.376271]  btrfs_use_block_rsv+0xd0/0x180 [btrfs]
> [ 1399.376286]  btrfs_alloc_tree_block+0x83/0x550 [btrfs]
> [ 1399.376288]  ? __schedule+0x2b0/0x670
> [ 1399.376302]  alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
> [ 1399.376315]  __btrfs_cow_block+0x12f/0x590 [btrfs]
> [ 1399.376329]  btrfs_cow_block+0xf0/0x1b0 [btrfs]
> [ 1399.376342]  btrfs_search_slot+0x531/0xad0 [btrfs]
> [ 1399.376356]  btrfs_insert_empty_items+0x71/0xc0 [btrfs]
> [ 1399.376374]  overwrite_item+0xef/0x5e0 [btrfs]
> [ 1399.376390]  replay_one_buffer+0x584/0x890 [btrfs]
> [ 1399.376404]  walk_down_log_tree+0x192/0x420 [btrfs]
> [ 1399.376419]  walk_log_tree+0xce/0x1f0 [btrfs]
> [ 1399.376433]  btrfs_recover_log_trees+0x1ef/0x4a0 [btrfs]
> [ 1399.376446]  ? replay_one_extent+0x7e0/0x7e0 [btrfs]
> [ 1399.376462]  open_ctree+0x1a23/0x2100 [btrfs]
> [ 1399.376476]  btrfs_mount_root+0x612/0x760 [btrfs]
> [ 1399.376489]  ? btrfs_mount_root+0x612/0x760 [btrfs]
> [ 1399.376492]  ? __lookup_constant+0x4d/0x70
> [ 1399.376494]  legacy_get_tree+0x2b/0x50
> [ 1399.376495]  ? legacy_get_tree+0x2b/0x50
> [ 1399.376497]  vfs_get_tree+0x2a/0x100
> [ 1399.376499]  fc_mount+0x12/0x40
> [ 1399.376501]  vfs_kern_mount.part.30+0x76/0x90
> [ 1399.376502]  vfs_kern_mount+0x13/0x20
> [ 1399.376515]  btrfs_mount+0x179/0x920 [btrfs]
> [ 1399.376518]  ? __check_object_size+0xdb/0x1b0
> [ 1399.376520]  legacy_get_tree+0x2b/0x50
> [ 1399.376521]  ? legacy_get_tree+0x2b/0x50
> [ 1399.376523]  vfs_get_tree+0x2a/0x100
> [ 1399.376526]  ? capable+0x19/0x20
> [ 1399.376528]  do_mount+0x6dc/0xa10
> [ 1399.376529]  ksys_mount+0x98/0xe0
> [ 1399.376531]  __x64_sys_mount+0x25/0x30
> [ 1399.376534]  do_syscall_64+0x5a/0x130
> [ 1399.376536]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1399.376537] RIP: 0033:0x7fafda93e3ca
> [ 1399.376539] Code: 48 8b 0d c1 8a 2c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8e 8a 2c 00 f7 d8 64 89
> 01 48
> [ 1399.376540] RSP: 002b:00007ffd17cb9798 EFLAGS: 00000202 ORIG_RAX:
> 00000000000000a5
> [ 1399.376542] RAX: ffffffffffffffda RBX: 000056262be79a40 RCX: 00007fafda93e3ca
> [ 1399.376543] RDX: 000056262be867c0 RSI: 000056262be7b970 RDI: 000056262be7a940
> [ 1399.376544] RBP: 0000000000000000 R08: 000056262be79c80 R09: 00007fafda98a1b0
> [ 1399.376545] R10: 00000000c0ed0001 R11: 0000000000000202 R12: 000056262be7a940
> [ 1399.376546] R13: 000056262be867c0 R14: 0000000000000000 R15: 00007fafdae5f8a4
> [ 1399.376547] Modules linked in: nbd k10temp rfcomm edac_mce_amd
> kvm_amd cmac bnep kvm irqbypass snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi
> crct10dif_pclmul snd_hda_intel crc32_pclmul snd_hda_codec
> ghash_clmulni_intel snd_hda_core snd_hwdep snd_pcm input_leds
> snd_seq_midi snd_seq_midi_event snd_rawmidi btusb btrtl btbcm
> aesni_intel btintel bluetooth snd_seq aes_x86_64 nls_iso8859_1
> crypto_simd cryptd ecdh_generic snd_seq_device glue_helper ecc
> snd_timer iwlmvm mac80211 wmi_bmof snd libarc4 soundcore iwlwifi ccp
> cfg80211 mac_hid sch_fq_codel it87 hwmon_vid parport_pc ppdev lp
> parport ip_tables x_tables autofs4 btrfs xor zstd_compress raid6_pq
> libcrc32c dm_mirror dm_region_hash dm_log hid_generic usbhid hid
> amdgpu mxm_wmi amd_iommu_v2 gpu_sched ttm drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops drm i2c_piix4 igb ahci nvme libahci
> dca nvme_core i2c_algo_bit wmi
> [ 1399.376583] CR2: 0000000000000000
> [ 1399.376585] ---[ end trace 651b3238b53fecb1 ]---
> [ 1399.376587] RIP: 0010:_raw_spin_lock+0x10/0x30
> [ 1399.376588] Code: 01 00 00 75 06 48 89 d8 5b 5d c3 e8 4a 75 66 ff
> 48 89 d8 5b 5d c3 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 75 02 5d c3 89 c6 e8 01 5d 66 ff 66 90 5d c3 0f
> 1f 00
> [ 1399.376589] RSP: 0018:ffffaec3c2d33370 EFLAGS: 00010246
> [ 1399.376590] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [ 1399.376591] RDX: 0000000000000001 RSI: ffffa0487f540248 RDI: 0000000000000000
> [ 1399.376592] RBP: ffffaec3c2d33370 R08: ffffaec3c2d335a7 R09: 0000000000000002
> [ 1399.376593] R10: 00000000ffffffff R11: ffffaec3c2d338a5 R12: 0000000000004000
> [ 1399.376594] R13: ffffa0487f540000 R14: 0000000000000000 R15: ffffa04d0e6d5800
> [ 1399.376596] FS:  00007fafdb068080(0000) GS:ffffa04d7ea80000(0000)
> knlGS:0000000000000000
> [ 1399.376597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1399.376598] CR2: 0000000000000000 CR3: 0000000494ea0000 CR4: 0000000000340ee0
> 
> Well, that didn't work ...
> 
> At least this unclean shutdown didn't eat the btrfs of the machine I
> just spent two days installing from scratch, so, yay.
> 
> In other news. Both Linux Mint 19.2 and Ubuntu 18.04.3 do run "fstrim
> -av" once a week via systemd.
> 
> In the meantime, I maybe got @home off via btrfs restore v5.3:
> $ egrep -v '^(Restoring|Done searching|SYMLINK:|offset is) ' restore.typescript
> Script started on 2019-10-25 10:20:43+0200
> [$ fakeroot ~/local/btrfs-progs/btrfs-progs/btrf]s restore -ivmS -r
> 258 /dev/mapper/nbd0p2 test/
> We seem to be looping a lot on
> test/hana/.mozilla/firefox/ffjpjbix.windows-move/places.sqlite, do you
> want to keep going on ? (y/N/a): a
> ERROR: cannot map block logical 131018522624 length 1073741824: -2
> Error copying data for
> test/hana/.mozilla/firefox/ffjpjbix.windows-move/favicons.sqlite
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_cell_1.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_gamelogic.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_highres.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_highres_aux_1.datx, do you want to keep going on ?
> (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_mesh.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_sound.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_surface.dat, do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Lord of the Rings
> Online/client_surface_aux_1.datx, do you want to keep going on ?
> (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Prey/Whiplash/GameSDK/Precache/Campaign_textures-part2.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/hana/.steam/steam/steamapps/common/Path of Exile/Content.ggpk, do
> you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/The Talos
> Principle/Content/Talos/00_All.gro, do you want to keep going on ?
> (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part1.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part2.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part3.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part4.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part5.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/GameSDK/Objects-part6.pak,
> do you want to keep going on ? (y/N/a): a
> We seem to be looping a lot on
> test/chris/.steam/steam/steamapps/common/Prey/Whiplash/GameSDK/Precache/Campaign_textures-part2.pak,
> do you want to keep going on ? (y/N/a): a
> chris@chibi:~/local/chibi-rescue$ exit
> exit
> 
> Script done on 2019-10-25 14:25:08+0200
> 
> How does that look to you?
> So "favicons.sqlite" is shot, don't care, but how about the other files?
> Is the looping message harmless as long as it finishes eventually or
> are these likely to be corrupted?
> Can & does restore verify the data checksums? In other words, can I
> expect the files that were restored without comment to be ...
> consistent? up-to-date? full of random data?
> Would it silently drop damaged files/directories or would it at least complain?
I think it will try to restore the data without looking at checksums, 
but I'm not 100% certain.

ON a side note, I've had some success on occasion getting data off of 
damaged BTRFS volumes using GRUB's BTRFS driver (the package you want 
for that is probably called 'grub-mount', it's essentially a FUSE module 
that uses GRUB's filesystem drivers to provide read-only access to any 
filesystem type supported by GRUB) in cases where `btrfs restore` 
couldn't do it.
> 
> Am Do., 24. Okt. 2019 um 13:40 Uhr schrieb Austin S. Hemmelgarn
> <ahferroin7@gmail.com>:
>> Backups, flavor of your choice. [...] I store enough extra info in the backup to
>> be able to rebuild the storage stack by hand from a rescue environment
>> (I usually use SystemRescueCD, but any live environment where you can
>> get your backup software working and rebuild your storage stack will work).
> 
> Oh, I have backups. Well, usually :-p. But files do not a running
> system make. For my servers, rebuilding the "storage stack" isn't a
> problem, since I built it manually in the first place and have notes.
> This is a family member's personal desktop, with a GUI install of
> Linux Mint on it. I opted for manual partitioning and btrfs but beyond
> that I don't even know the specifics of the setup. I mean, I can boot
> from a live USB, create partitions and filesystems, restore from
> backup and install grub, but I'm not confident that it would boot, let
> alone survive the next system update, because distro-specific some
> special sauce is missing. And even so, empasis is on I -- try telling
> that to a non-technical person.
Actually, it should boot and survive the next upgrade just fine.  Just 
make sure that:

* You used the correct version of GRUB.
* The GRUB config is correct.
* The storage configuration is the same.

The last one is the tricky one, as most systems require even the UUID's 
to be the same in a lot of cases (since most Linux distros mount by UUID 
these days).
> 
> What I'm looking for is something you can boot off of and restore the
> system automatically. ReaR has the right idea, but uses either tar
> (really?) or Enterprise-scale backup backends. By the time I've all
> the bugs ironed out of a custom backup-restore script for it, it'll be
> too late. Timeshift covers the user error and userspace bug use-cases
> brilliantly, something as idiot-proof for actual backups would be
> nice.
I have yet to see such a tool for Linux in general unfortunately.

BTW, don't underestimate tar, it's rock-solid reliable if you use it 
right, and works _everywhere_.  Yeah, it doesn't do deduplication or 
encryption or checksumming or compression, but all of that is easy to 
layer in.  The only major issue is that it requries the state of the 
volume to not change while it's running (which can be mitigated by 
splitting backups into logical subsets instead of running for the whole 
system all at once).
> 
> Cheers,
> C.
> 
> P.S.: Having to stay near the computer during a btrfs restore just to
> enter "a" at the loop prompts isn't ideal. How about "A", always
> continue looping, for all files?
Or, alternatively:

yes a | btrfs restore
