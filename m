Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367322403F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJJW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgHJJW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 05:22:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA407C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 02:22:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so5834512edv.13
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=aigCFYnSgCAZrf7KZHlm8zkCUBGsUZ2LkQhntM3g3pQ=;
        b=bpDUKXn5djEdcUKe4SJviwCXpRPzcmVJUfd6T0mqYO9k0Rk7d/IGCunGCl5AjZmUg/
         rNIgTn33IVCjkMoEBuhbTYuUK4d8zH8siX/nHtk4ZyrT4MGajAWZA55+BRLyvO6Vr+s+
         MibmRrWfj++pcdOvJamGgb5NTuPOUQDeYC+H63AkHANO6lGoxxe1LxmHC/b+xtkPUJir
         pAMPC+aPGMKOWpJud9QooLqLP1ArSDhNHSUYp7WWpX2emi73bkE3Z7jJVOEgzXHoJJ4m
         1h2/LKLF1L/Y54Hf0GYl2xCx7oHjwTqNbHmAoTHPP/wRKi3ithV156xN2yW31pQ2YU7D
         q+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=aigCFYnSgCAZrf7KZHlm8zkCUBGsUZ2LkQhntM3g3pQ=;
        b=P0m2V08oIJBGfAEMVEEvZDsUkYm9C2yHYPWo4KYcDR+GSqp9OMV/i7O0JyyeLAgbR1
         txeAKWcLWzYAAPVsXK0CZacn9og/+3uYJtSizGjw1oPO3uzyohDeIOJmicrnS+ngFCrY
         yaYWhAA4knJEWYWym6gjeunepUn4zI5L4jQ56oygG7FnC6u50M+Oind7xm3cYujnG3Md
         gGqrPPy6Zv33LPVlKZEwctGub559QslXkqtaIaxHA9FhYdlwcsk7/D78xKLWzQp7a+sA
         fl0RCpSah77hvFJYs7g3VVVaOl6/80Iy7c3HG5agcm29xLKKvlXk/jMkUcQQP1P38VIH
         mYwQ==
X-Gm-Message-State: AOAM530icrCyOm3DildhHHuBhcVo16DAA970OK9tkesz5kbvGXUj86CM
        yAFO9Xm3sR5Dq7x9ha3NUqvyEMQX
X-Google-Smtp-Source: ABdhPJxofpZkIic429C8/rXTQ6obiLQvUeuARkszoGowaeWF887iaDvOep3VXq8SIy02rdf3xTISGQ==
X-Received: by 2002:a50:e70e:: with SMTP id a14mr5063203edn.93.1597051374904;
        Mon, 10 Aug 2020 02:22:54 -0700 (PDT)
Received: from [10.20.30.23] (p5de03ce6.dip0.t-ipconnect.de. [93.224.60.230])
        by smtp.gmail.com with ESMTPSA id zg6sm3518636ejb.106.2020.08.10.02.22.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 02:22:54 -0700 (PDT)
From:   Johannes Rohr <jorohr@gmail.com>
Subject: system hangs when running btrfs balance
To:     linux-btrfs@vger.kernel.org
Autocrypt: addr=jorohr@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFT1gLABCADcwcj45ysOenaLb8+pkjeb+6oC5IZQ5rgf42l8tCfU6mwwTyaHI/OE9f1f
 pClmX+dkEFp9HjFK6e33St+HgcXsmarEpVkGVB1oLwhnECuBngqJLbopXL8QfgVkjaNq2aF9
 QfR0W2F8BlNDllnJ8q3MToY3RQ2BSkYvsekCS9zJ+8cFrZohpTa9hvtD2tDdHk48A8GaxA7Q
 CZm3FSbzXEFuGH4TZ4P407b6prXfU8LidTCrkluuM44LhqTGRXmtuVg6jU9vOrkcz8fflGtq
 Orziu8O32iiL9HU1Oo2wX/vXq9wANj9PAp+cOknXVAH/MeYSIPqo+0pc6ObZxufYyUehABEB
 AAG0IEpvaGFubmVzIFJvaHIgPGpvcm9ockBnbWFpbC5jb20+iQFOBBMBCAA4FiEEQGpo2KXp
 zZlAiCX9BQuNsh71kW8FAliYN80CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQBQuN
 sh71kW8GRgf9GKnsiEasxb/0/ngspsDBFCT2GROrA+Qqz7cp14hZVtOkm6nJ7wshAYy+UGfl
 ovPRi3D3JG/RJvBQHi+rYIBrROOOVbj704AC5oFCUwsFs6pKcnwlRaodIo9u4ZgiYOkNln12
 UJxuPL1v7J1ccgypP3ufFZaH9gJGssZtajyQkeCRCKNbBPIbXMSnsTWBqyB4AulnyAwVFJAc
 4yga8FaJtiDV334tt2TBNw80yqtDczjbjq/tJkcR5VlzVLpPXpbJ8FCL7K945MmN2fpWgWvj
 WtqEfnsSW/y1x7OfDWQ8CG1szKc6HVsqkRNQwksJapIdresC2dNe7oT+m9bn0+RWIrkBDQRU
 9YCwAQgAu86uORuwnEMOhc1poBRsvWns7G0eMd0vdSaiSAPaP8pQrgTC16wBXJXPxPIhIzfs
 PnGvHgv21BhGcBRcQ7Ybh56dXnWBuKMNnIz2PcMEdHfjd/NG0SDRZdEl/Eztk143kXxsjMTo
 10sGHPVJOFIVG1L9K2XcZ/M4SvvR5rSYW2obRbCtT3EkNAcyynA/xKtOhsAFkCVjO4twytQv
 Og9rpn02bBrjZqaTCHPzVl7ZpjVD6oykY8uJrgKc4EGMouH3WitZppkWSqaB1hgJp78CjwkB
 12mT+YcIoM6xzAIklBzKK4qaV1elHhd5clhbDuSpGor/KJcyolx5hbMFwrT+jQARAQABiQEf
 BBgBAgAJBQJU9YCwAhsMAAoJEAULjbIe9ZFvhS8H/3hMmBhanQeDumAndrJI14228G9QUSW2
 SO92Uzlek/mQwRbIg/+nkLn2aC4RkEYqox+AuQA7TqX+OS7JjFVS9vtsn2ZM+kgvMpzUaKO5
 aCjqiyXB4Q3pvg2t46SeuiV1Y3cbyhAH6gzCOei/IMguhYIqNAsf7bf2drN5e1uMHpzJHrBK
 KugcR5bTfAVQzwnOMPQtPH4mRe7cALp04t4rxSZUiC9Xw9s38oK+Ewk/TtjBEFg4VTDMHdcE
 B65jlCq15bGxaOSwZbDzx/exLNq41HM3xygY7XFgAdyE6FJLvUc5ehqTjiwsIx3BioRMOTzd
 5n0x4xeJ5v4w63j4mSxbZu4=
Message-ID: <c684e9ac-f28b-7056-0a46-6c6450ac4c1f@gmail.com>
Date:   Mon, 10 Aug 2020 11:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear devs,

since I upgraded our system from Ubuntu 18.04 LTS to 20.04 LTS, the file
system completely freezes when I run a btrfs balance on it. The only way
to get a usable system for the time being is with the mount option
"skip_balance".

The server has a raid1 with 4 SSDs with 500 GB each.

Here is a backtrace of what I am seeing:

[Sun Aug  9 12:21:35 2020] ------------[ cut here ]------------

[Sun Aug  9 12:21:35 2020] kernel BUG at fs/btrfs/

relocation.c:2626!

[Sun Aug  9 12:21:35 2020] invalid opcode: 0000 [#1] SMP PTI

[Sun Aug  9 12:21:35 2020] CPU: 1 PID: 4537 Comm: btrfs-balance Tainted: G           O      5.4.47 #1

[Sun Aug  9 12:21:35 2020] Hardware name: FUJITSU D3401-H1/D3401-H1, 
BIOS V5.0.0.11 R1.14.0 for D3401-H1x                    06/09/2016

[Sun Aug  9 12:21:35 2020] RIP: 0010:select_reloc_root+0x5b/0x19f [btrfs]

[Sun Aug  9 12:21:35 2020] Code: c0 c7 44 24 04 00 00 00 00 e8 8b 9d 17 
e1 48 89 df 4c 89 f6 48 8d 54 24 04 e8 9c e6 ff ff 48 8b 58 60 48 89 c5 
48 85 db 75 02 <0f> 0b 48 8b 43 20 a8 02 75 02 0f 0b 48 83 bb df 
01 00 00 f8 75 45

[Sun Aug  9 12:21:35 2020] RSP: 0018:ffff8887e0b0bb20 EFLAGS: 00010246

[Sun Aug  9 12:21:35 2020] RAX: ffff8887dfab5280 RBX: 0000000000000000 RCX: 0000000000000000

[Sun Aug  9 12:21:35 2020] RDX: ffff8887e0b0bb24 RSI: ffff8887e0b0bc10 RDI: ffff8887dfab52c0

[Sun Aug  9 12:21:35 2020] RBP: ffff8887dfab5280 R08: ffff8887dfab52c0 R09: ffffffffa0491e7e

[Sun Aug  9 12:21:35 2020] R10: ffff8887f4ba7e70 R11: ffff8888090ed158 R12: ffff8887dfab5280

[Sun Aug  9 12:21:35 2020] R13: ffff8887fd330800 R14: ffff8887e0b0bc10 R15: ffff8887e7fa66e8

[Sun Aug  9 12:21:35 2020] FS:  0000000000000000(0000) GS:ffff88880e240000(0000) knlGS:0000000000000000

[Sun Aug  9 12:21:35 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[Sun Aug  9 12:21:35 2020] CR2: 000055b4d5b7cfe0 CR3: 000000000200a004 CR4: 00000000003606e0

[Sun Aug  9 12:21:35 2020] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

[Sun Aug  9 12:21:35 2020] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

[Sun Aug  9 12:21:35 2020] Call Trace:

[Sun Aug  9 12:21:35 2020]  do_relocation+0xb6/0x4c2 [btrfs]

[Sun Aug  9 12:21:35 2020]  ? calcu_metadata_size.isra.36.constprop.42+0x9e/0xc4 [btrfs]

[Sun Aug  9 12:21:35 2020]  ? do_raw_spin_lock+0x2f/0x5a

[Sun Aug  9 12:21:35 2020]  ? btrfs_block_rsv_refill+0x4b/0x8b [btrfs]

[Sun Aug  9 12:21:35 2020]  relocate_tree_blocks+0x301/0x427 [btrfs]

[Sun Aug  9 12:21:35 2020]  ? tree_insert+0x49/0x4e [btrfs]

[Sun Aug  9 12:21:35 2020]  ? add_tree_block.isra.38+0x11e/0x144 [btrfs]

[Sun Aug  9 12:21:35 2020]  relocate_block_group+0x279/0x49e [btrfs]

[Sun Aug  9 12:21:35 2020]  btrfs_relocate_block_group+0x15e/0x23d [btrfs]

[Sun Aug  9 12:21:35 2020]  btrfs_relocate_chunk+0x25/0x8c [btrfs]

[Sun Aug  9 12:21:35 2020]  btrfs_balance+0xaf0/0xd45 [btrfs]

[Sun Aug  9 12:21:35 2020]  ? btrfs_balance+0xd45/0xd45 [btrfs]

[Sun Aug  9 12:21:35 2020]  balance_kthread+0x32/0x46 [btrfs]

[Sun Aug  9 12:21:35 2020]  kthread+0xf5/0xfa

[Sun Aug  9 12:21:35 2020]  ? kthread_associate_blkcg+0x86/0x86

[Sun Aug  9 12:21:35 2020]  ret_from_fork+0x3a/0x50

[Sun Aug  9 12:21:35 2020] Modules linked in: btrfs xor zstd_decompress 
zstd_compress lzo_compress lzo_decompress zlib_deflate raid6_pq 
libcrc32c sd_mod ipmi_devintf ipmi_msghandler sg x86_pkg_temp_thermal
 intel_powerclamp kvm_intel kvm irqbypass crc32_pclmul crc32c_intel 
iTCO_wdt ghash_clmulni_intel aesni_intel crypto_simd psmouse ahci cryptd
 libahci i2c_i801 serio_raw glue_helper intel_pch_thermal evdev video 
thermal acpi_pad button fan jc42 ftsteutates nct6775 hwmon_vid coretemp 
ip_tables x_tables autofs4 e1000e

[Sun Aug  9 12:21:36 2020] ---[ end trace 442b443de6cecc6e ]---

[Sun Aug  9 12:21:36 2020] RIP: 0010:select_reloc_root+0x5b/0x19f [btrfs]

[Sun Aug  9 12:21:36 2020] Code: c0 c7 44 24 04 00 00 00 00 e8 8b 9d 17 
e1 48 89 df 4c 89 f6 48 8d 54 24 04 e8 9c e6 ff ff 48 8b 58 60 48 89 c5 
48 85 db 75 02 <0f> 0b 48 8b 43 20 a8 02 75 02 0f 0b 48 83 bb df 
01 00 00 f8 75 45

There has been a related bug report at kernel.org for a year,
https://bugzilla.kernel.org/show_bug.cgi?id=203405 and I have found
similar reports here and there, some pertaining to quite old kernel
versions, but we have only been hit with kernel 5.4. After this first
occurred, I had no better luck though, with older kernels (4 something
from Debian buster, also 4 something from Ubuntu 18.04).

Apart from fixing the underlying issue, would there be any wordaround
for it? Currently the balance for the fs is in suspended status. Since
there is quite a few people who depend on this server, I can't just play
around with it at random. That's why I am asking for advice here...

Thanks so much for any suggestions you might have!

Johannes

