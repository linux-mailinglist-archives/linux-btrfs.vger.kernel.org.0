Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338786587DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiL1XYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 18:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL1XYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 18:24:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B9113EB6;
        Wed, 28 Dec 2022 15:24:49 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mf07E-1oe57U0EDy-00gZL7; Thu, 29
 Dec 2022 00:24:46 +0100
Message-ID: <dc63f5ac-44f4-f5eb-f1b0-c14291595e3d@gmx.com>
Date:   Thu, 29 Dec 2022 07:24:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
 <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
 <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
 <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com>
 <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
 <fd0a0bfe-5c67-fd95-b17c-78a14c63bea6@gmx.com>
 <CABXGCsMev+96zixic3=5cLgzMfZKcJE-zOLPrc3-vTrrDZQDig@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CABXGCsMev+96zixic3=5cLgzMfZKcJE-zOLPrc3-vTrrDZQDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:neldxSVHzqdPSmKu6I1rcpno0/Lyc+fY5XZktk+GLuJwddrwBdl
 EPpXYYNKAljyWiDF+aOEh1yCgNzTJY0C9pfqyoZUsHLyOQDccPKwp4KkU053wlOFZKJh63X
 ueXinrxF6ANCkZwiPWzUB5ChxFnvC+SVE61/Pu1wqRO4mz13VvKde7CDUVeND6ELpZZ7wza
 9/uFIY5ZwSr7PdCvim/+w==
UI-OutboundReport: notjunk:1;M01:P0:/YnS67cQOek=;zny1oo62VvrEBz+71vMnFVcTcbp
 GjcqMqUVwMZQDDcYPW5mcDQQdQgZOI4jTqIjot78sjPI+pqBHpTI/cCV7HgpwBdh9pPj+Lpvy
 6hKp0Lk1NFTv9ZACe4Jw9Y2yK3YdtB4fILUXqA6gPb2YZ4xxrfUhEXmWKCwzvy1euvIuzB7pD
 YRUKgBCkznL1CP0AodEgra5h9APnYkyFBRj8Q6bMlA18aC+/MApnsaptd/WNBR4zu90npYvlj
 UYMKtNlem4azhRVcfSZijtmjjX97nmdEF1/x2ygrVku8KU3NK9ASnnc3yrJfgDamVK8S+NCuj
 zcL1MlElLtLotorP3OhdYKryQtAvCEEWK+25dCZWe3MKGEdgJY0Vjgxvvx4PLoAH40u54RJiW
 HMqeHb7fOOjPwjklmO6oeXhFMDM+VO4TLJJU86rSyhON2vH/bj0bNS4BeRyJsJ3BYZa1zqgTV
 WvnCRKhLf8LjJUcCDyM5DmJBTrKRlFroVNZv9KKN75gVzDKgXknTn/N+ARk3DrXslgkP36lgo
 WsJuQL0g0zKFD47cAbJdroNbS6i628+2HywJnBj6WbFkOXT080QOZ1YvrIl5ATQ5e0MpELxI9
 Ruk1v9HbSzRAsIeO9aHpMM24C6VpE/4sC9Asl7e71spAkvcKhfXTFP3Z16BC+lCbEUIO66Lhh
 uSVg8JUBE0ZanKEqPMEIttVEba9cU9Xm/j4ysgMX5wO0UFWepv8BxpJ0O146QlccSkNtIHKWy
 OGgXctDp1l3xDj+Y0eZQAIgpe/E8Wf+PT6VzhjB9RvJi3tjpjUXOOfDU4G0aJUmwIg7pN9+Wz
 FNB7/YRz1aADGLL9t482a/RBjZIlDSJSqh1Y2m3GF8+fpPmBh8kL/zTht4w6R6GA2owy26fha
 cpJzzWB3ysv6fmMP6fppVRHtfcWllam4Fz85nxXWTDtypT8yJzr/xJTCaoSUYLkEOqyuNbJhL
 doYyPT+V0VTfc0BkydAVY6Hc6HA=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/28 22:12, Mikhail Gavrilov wrote:
> On Wed, Dec 28, 2022 at 6:08 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>   From the very first dmesg with calltrack, it already shows the
>> submit_one_bio() is called from submit_extent_page(), which means cases
>> cross stripe boundary, and has no parent_check populated at all.
>>
>> And since you're using RAID0 on two NVMEs, it matches the symptom, while
>> most tests done here are using single device (DUP and SINGLE), thus no
>> stripe boundary cases at all.
>> (In fact it should still be possible to trigger on SINGLE, but way too
>> hard to trigger)
>>
>> With proper root cause found, this version should mostly handle the
>> regression correctly.
>>
>> This version should mostly be the formal one I'd later send to the
>> mailing list.
>>
>> I can not thank you more for all the testing you have provided, it not
>> only pinned down the bug, but also proves I'm a total idiot...
> 
> I have already written over 1.6Tb of data to disk and there are no
> hints of errors.
> For me, this is a sign that the problem has been fixed.
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Just one last thing to confirm, mind to provide the following dump?

  # btrfs ins dump-tree -t chunk <device>

If the fix works, it means you have some tree block crossing stripe 
boundary, which is not the ideal situation.

But on the other hand, you have provided "btrfs check" output, which 
shows no such sign.
I'm not sure if it's a bug in newer check.

Thanks for your comprehensive testing and detailed report!
Qu

> 
> ❯ dmesg | grep -i btrfs
> [    0.000000] Linux version
> 6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> (mikhail@mikhail-laptop) (gcc (GCC) 12.2.1 20221121 (Red Hat
> 12.2.1-4), GNU ld version 2.39-6.fc38) #7 SMP PREEMPT_DYNAMIC Wed Dec
> 28 10:00:39 +05 2022
> [    0.000000] Command line:
> BOOT_IMAGE=(hd0,gpt1)/@root/boot/vmlinuz-6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> root=UUID=40e0b5d2-df54-46e0-b6f4-2f868296271d ro
> rootflags=subvol=@root
> resume=UUID=db79988f-6b70-4b52-84f5-3e505471c85e log_buf_len=16M
> sysrq_always_enabled=1 nmi_watchdog=1
> amdgpu.lockup_timeout=-1,-1,-1,-1
> [    0.154567] Kernel command line:
> BOOT_IMAGE=(hd0,gpt1)/@root/boot/vmlinuz-6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> root=UUID=40e0b5d2-df54-46e0-b6f4-2f868296271d ro
> rootflags=subvol=@root
> resume=UUID=db79988f-6b70-4b52-84f5-3e505471c85e log_buf_len=16M
> sysrq_always_enabled=1 nmi_watchdog=1
> amdgpu.lockup_timeout=-1,-1,-1,-1
> [    0.154654] Unknown kernel command line parameters
> "BOOT_IMAGE=(hd0,gpt1)/@root/boot/vmlinuz-6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+",
> will be passed to user space.
> [    4.496766] usb usb2: Manufacturer: Linux
> 6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+ xhci-hcd
> [    4.498963] usb usb1: Manufacturer: Linux
> 6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+ xhci-hcd
> [    4.500665] usb usb3: Manufacturer: Linux
> 6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+ xhci-hcd
> [    4.501851] usb usb4: Manufacturer: Linux
> 6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+ xhci-hcd
> [    4.735212] Btrfs loaded, crc32c=crc32c-generic, assert=on,
> zoned=yes, fsverity=yes
> [    5.223368]
> BOOT_IMAGE=(hd0,gpt1)/@root/boot/vmlinuz-6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> [    6.923453] BTRFS: device label fedora_localhost-live devid 2
> transid 652981 /dev/nvme1n1p1 scanned by systemd-udevd (448)
> [    6.974412] BTRFS: device label fedora_localhost-live devid 1
> transid 652981 /dev/nvme0n1p3 scanned by systemd-udevd (484)
> [   11.113437] CPU: 15 PID: 478 Comm: systemd-udevd Tainted: G
>      L     6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> #7
> [   11.221359] CPU: 15 PID: 478 Comm: systemd-udevd Tainted: G
> W    L     6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> #7
> [   13.731015] BTRFS info (device nvme0n1p3): using crc32c
> (crc32c-intel) checksum algorithm
> [   13.731147] BTRFS info (device nvme0n1p3): using free space tree
> [   14.328439] BTRFS info (device nvme0n1p3): enabling ssd optimizations
> [   14.328469] BTRFS info (device nvme0n1p3): auto enabling async discard
> [   16.592713] BTRFS info (device nvme0n1p3: state M): use zstd
> compression, level 1
> [11691.071176] CPU: 11 PID: 2068 Comm: gnome-shell Tainted: G        W
>     L     6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-fix+
> #7
> 
> 
> <OFFTOPIC>
> As I mentioned at the first message I also have a computer where the
> btrfs partition is located on a slow HDD.
> When I update the container (podman pull), the system becomes
> unresposible for half an hour, which is how long it takes to update
> the container.
> I do not expect any super-speed from the HDD, I just would like to do
> something else with this computer. Yes, at least watching videos on
> youtube. Is there anything that can be done here or is there nothing
> that we can do?
> [46944.301588] INFO: task btrfs-transacti:1184 blocked for more than
> 122 seconds.
> [46944.301825]       Tainted: G        W    L    -------  ---
> 6.2.0-0.rc1.14.fc38.x86_64+debug #1
> [46944.301829] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [46944.301832] task:btrfs-transacti state:D stack:12000 pid:1184
> ppid:2      flags:0x00004000
> [46944.301840] Call Trace:
> [46944.301843]  <TASK>
> [46944.301851]  __schedule+0x50c/0x1780
> [46944.301863]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [46944.301876]  schedule+0x5d/0xe0
> [46944.301881]  wait_current_trans+0x110/0x170
> [46944.301888]  ? __pfx_autoremove_wake_function+0x10/0x10
> [46944.301895]  start_transaction+0x36c/0x680
> [46944.301904]  transaction_kthread+0xb6/0x1b0
> [46944.301912]  ? __pfx_transaction_kthread+0x10/0x10
> [46944.301916]  kthread+0xf5/0x120
> [46944.301920]  ? __pfx_kthread+0x10/0x10
> [46944.301926]  ret_from_fork+0x2c/0x50
> [46944.301941]  </TASK>
> 
> 
> I attached a full kernel log from this machine.
> I can start a separate thread if it makes sense.
> Sorry for oftop.
> </OFFTOPIC>
> 
> --
> Best Regards,
> Mike Gavrilov.
