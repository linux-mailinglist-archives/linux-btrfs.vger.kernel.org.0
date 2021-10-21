Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE698436A12
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhJUSJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhJUSJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 14:09:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A2CC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:07:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l201so1219467ybl.9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWe+xjD9fhYz682kevsoj7csKaCIfCfC8mA3tNGLnf4=;
        b=YPij2w1ppsPpKxPp7B4ZCux+zfpcSmRYi+Gu0sU4GS23fr6xFNQZ9RrFLt+/4hTQGa
         25KbD71o1Kctvmlt8aq8sapfiwyS5h0h432AEnqXkb3iEEKGakhbYx/TJV/cwniRiYuw
         U2oHfwOsVe3sdZeIcDKM+9hHKSLS37iXCGqkInAQEH/y627MVsHgmpQkjqduOOxN5kzR
         NtlFs1LJ+sLcT910gBNXnpfSTj/IiEAFgcuK7YwMrIfzv0b5YbRKgcX6yGu6TlmJUtA4
         oWEHRH2JBECmRlAKj1FxuxuUh5QMKB7yaOmpX9k5jsQ0/l7t0v4ro1AePWQKVsW8ie6x
         1eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWe+xjD9fhYz682kevsoj7csKaCIfCfC8mA3tNGLnf4=;
        b=Op5uLKxwFeRp7FEnpxHPwE5MhLDapykS2rxRxndVX9pJ5SYDJCnoPaj1dCI2ALIbb3
         hSME9Zq90vNxG0bvwusEBoHAoWImRFDbtjNluAZxal3PeD0UhYWz7HE4m3+vH6ykpV9t
         Fc4HV1nHJBXb9q8TEYZ5v+O2bwZyKp7UfdieuNn06xklM6HeMfspizgOKs+y+JUs+hg9
         UkyG5RUPIWahY5DogU+KxqmPkiDEUKDN1jH/3QnHPTxXNUfI5D16GoSRX23gbfxjH552
         o/lpX2/eeDqp9fivSD/94coxER18H33/BgUDB5YIkyi477wvclLxkQAYOFkI9VAMs/OM
         Ne8A==
X-Gm-Message-State: AOAM530kYrSQsefchtp7jLTogtulnJu+P6TXoRg+NLwPS/5ohi/toBOj
        v0TjxtwaxhSNRGITIK+lLoaCxZYJTT4R0nDeNxo11g==
X-Google-Smtp-Source: ABdhPJwcvB2n66VBRx5IuroYGdkFpFlWdTNpJSC5nLXp5yT8futyAYaEdR1yKx+POUpwunzBEvo74Gk8nJfZUrVyix8=
X-Received: by 2002:a25:db91:: with SMTP id g139mr7267812ybf.391.1634839641166;
 Thu, 21 Oct 2021 11:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su> <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
 <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com>
 <2e18d933-a56e-198d-20c8-ab3038d3f390@suse.com> <CAJCQCtQ+23cQCZQrwPO7Yq1G48yEoUT2CbLH9GdytP6zYXux3g@mail.gmail.com>
 <3c1ead76-e321-a3c1-755c-288ddd5fbeeb@suse.com>
In-Reply-To: <3c1ead76-e321-a3c1-755c-288ddd5fbeeb@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 14:07:05 -0400
Message-ID: <CAJCQCtTf8OV8RgPdyQ9yGRJhvszkVUYN5MTLwkRAGTV=FMmmiQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[fedora@dusty-353 ~]$ sudo sysctl -n kernel.panic_on_warn
1

I get the oops, but no kdump activity at all.

Oct 21 17:35:54 dusty-353.novalocal kernel: Unable to handle kernel
paging request at virtual address fffffffffffffdd0
Oct 21 17:35:54 dusty-353.novalocal kernel: Mem abort info:
Oct 21 17:35:54 dusty-353.novalocal kernel:   ESR = 0x96000004
Oct 21 17:35:54 dusty-353.novalocal kernel:   EC = 0x25: DABT (current
EL), IL = 32 bits
Oct 21 17:35:54 dusty-353.novalocal kernel:   SET = 0, FnV = 0
Oct 21 17:35:54 dusty-353.novalocal kernel:   EA = 0, S1PTW = 0
Oct 21 17:35:54 dusty-353.novalocal kernel:   FSC = 0x04: level 0
translation fault
Oct 21 17:35:54 dusty-353.novalocal kernel: Data abort info:
Oct 21 17:35:54 dusty-353.novalocal kernel:   ISV = 0, ISS = 0x00000004
Oct 21 17:35:54 dusty-353.novalocal kernel:   CM = 0, WnR = 0
Oct 21 17:35:54 dusty-353.novalocal kernel: swapper pgtable: 4k pages,
48-bit VAs, pgdp=0000000125461000
Oct 21 17:35:54 dusty-353.novalocal kernel: [fffffffffffffdd0]
pgd=0000000000000000, p4d=0000000000000000
Oct 21 17:35:54 dusty-353.novalocal kernel: Internal error: Oops:
96000004 [#1] SMP
Oct 21 17:35:54 dusty-353.novalocal kernel: Modules linked in:
binfmt_misc virtio_gpu virtio_dma_buf drm_kms_helper joydev cec
fb_sys_fops syscopyarea virtio_net sysfillrect sysimgblt
virtio_balloon net_failover failover vfat fat xfs drm fuse zram
ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg virtio_mmio
aes_neon_bs
Oct 21 17:35:54 dusty-353.novalocal kernel: CPU: 1 PID: 4392 Comm:
kworker/u8:12 Kdump: loaded Not tainted 5.14.10-300.fc35.aarch64 #1
Oct 21 17:35:54 dusty-353.novalocal kernel: Hardware name: QEMU KVM
Virtual Machine, BIOS 0.0.0 02/06/2015
Oct 21 17:35:54 dusty-353.novalocal kernel: Workqueue: btrfs-delalloc
btrfs_work_helper
Oct 21 17:35:54 dusty-353.novalocal kernel: pstate: 80400005 (Nzcv
daif +PAN -UAO -TCO BTYPE=--)
Oct 21 17:35:54 dusty-353.novalocal kernel: pc :
submit_compressed_extents+0x38/0x3d0
Oct 21 17:35:54 dusty-353.novalocal kernel: lr : async_cow_submit+0x50/0xd0
Oct 21 17:35:54 dusty-353.novalocal kernel: sp : ffff800010d6bc20
Oct 21 17:35:54 dusty-353.novalocal kernel: x29: ffff800010d6bc30 x28:
0000000000000000 x27: ffffbb96c7421000
Oct 21 17:35:54 dusty-353.novalocal kernel: x26: fffffffffffffdd0 x25:
dead000000000100 x24: ffff00012f950408
Oct 21 17:35:54 dusty-353.novalocal kernel: x23: 0000000000000000 x22:
0000000000000001 x21: ffff0000c07e1f80
Oct 21 17:35:54 dusty-353.novalocal kernel: x20: ffff0000c5af0000 x19:
0000000000000001 x18: ffff0000c2500bd4
Oct 21 17:35:54 dusty-353.novalocal kernel: x17: ffff00012fa0eff8 x16:
0000000000000006 x15: bd47b4a638083142
Oct 21 17:35:54 dusty-353.novalocal kernel: x14: ab8f4df43188bcf5 x13:
0000000000000020 x12: ffff0001fefa78c0
Oct 21 17:35:54 dusty-353.novalocal kernel: x11: ffffbb96c743b500 x10:
0000000000000000 x9 : ffffbb96c5c11c40
Oct 21 17:35:54 dusty-353.novalocal kernel: x8 : ffff446b37afd000 x7 :
ffff800010d6bbe0 x6 : ffffbb96c6c11000
Oct 21 17:35:54 dusty-353.novalocal kernel: x5 : 0000000000000000 x4 :
0000000000000000 x3 : ffff0000c07e1fa0
Oct 21 17:35:54 dusty-353.novalocal kernel: x2 : 0000000000000000 x1 :
ffff00012f950430 x0 : ffff00012f950430
Oct 21 17:35:54 dusty-353.novalocal kernel: Call trace:
Oct 21 17:35:54 dusty-353.novalocal kernel:
submit_compressed_extents+0x38/0x3d0
Oct 21 17:35:54 dusty-353.novalocal kernel:  async_cow_submit+0x50/0xd0
Oct 21 17:35:54 dusty-353.novalocal kernel:  run_ordered_work+0xc8/0x280
Oct 21 17:35:54 dusty-353.novalocal kernel:  btrfs_work_helper+0x98/0x250
Oct 21 17:35:54 dusty-353.novalocal kernel:  process_one_work+0x1f0/0x4ac
Oct 21 17:35:54 dusty-353.novalocal kernel:  worker_thread+0x188/0x504
Oct 21 17:35:54 dusty-353.novalocal kernel:  kthread+0x110/0x114
Oct 21 17:35:54 dusty-353.novalocal kernel:  ret_from_fork+0x10/0x18
Oct 21 17:35:54 dusty-353.novalocal kernel: Code: a9056bf9 f8428437
f9401400 d108c2fa (f9400356)
Oct 21 17:35:54 dusty-353.novalocal kernel: ---[ end trace 718fed28301aa13b ]---


Whereas sysrq+c does create a kdump file...

--
Chris Murphy
