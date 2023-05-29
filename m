Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5F7147CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjE2KP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjE2KP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 06:15:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5EC9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685355343; x=1685960143; i=quwenruo.btrfs@gmx.com;
 bh=yYi4zlmTnmRFn0UoE2TaoG9RoWlPF0Ac9MLBR9s3vdw=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=sWTEknniC2CrUCuYbpaTjDCWyIieXj/JzHmdp+zfxApL36mm5AV/2DZsBuTOMd5YpVGw4//
 KhMI8SM2+jcMGeGUTpvywxCrZb/zEcvFAjFtLF39V1gsvv/6xpy8H00hlCig2elbNyCi29drC
 zhqn3B9dmYEHMPkSh1n+0ClAmgQY+aoLQr0UouBimAkD49RsE8veRh8eCe23I05SiM3GH2ynY
 JRFH3rxc1CLyj7+Gan0HGL45B/wHXRRZAFP9YJrildRGbpyQQKxeTcUHs2fSpqyGrtKCXz4i0
 1DKncBjeHDAglfRVRuRbkRAx/wL5sg+qCB+QeCzQrGrBRI/15Hbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTNF-1pgfiF3WrN-00NTvk; Mon, 29
 May 2023 12:15:43 +0200
Message-ID: <b22bbb5f-9004-6643-09ea-ee11337a93f0@gmx.com>
Date:   Mon, 29 May 2023 18:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
 <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
 <6330a912-8ef5-cc60-7766-ea73cb0d84af@gmx.com>
 <b21cc601-ecde-a65e-4c4e-2f280522ca53@bluematt.me>
 <e82467d6-2305-da7c-7726-ec0525952c36@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 6.1 Replacement warnings and papercuts
In-Reply-To: <e82467d6-2305-da7c-7726-ec0525952c36@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:egNVFDfFy6GfBxLa5Cd9aSwPASrfwmobpRzDJRh25HP648ZR0Ci
 zWOjc/ZkWLHBlUpLII+Xe7b749vP7i0Zg9yAH2SoI8VCzuMdbYSkDbQ7orDIWObxTdw1xEl
 kFy3E5e7nYfvevAIsS1B02JDO8piomCaLFS/9Dg5InvF2+9PhVHo9N1Y0m02olCzyD9vYDl
 Sn9nLOOfuf/V11KJxcrDQ==
UI-OutboundReport: notjunk:1;M01:P0:tMdvY4/7klI=;iqunDerja9uR6zh3KCJTd913Ul2
 p85ptxuNoTPBUNCd1MFGFT+eHpgxzfII0jnHN8qovwvJk4O1xiub4IWoRIkkmM3jp8YYA8Gxk
 Lnintko8AvBtT9gislHAMpMWX2z8pqHtpVmpbtAloqHXa1gleD/lVC3XGVipgjUh5Fb1rK0Wr
 ErpQ5740FD/wqz4DHeoPx3XHg1DO6rNh9wetsUe/QcC0EMdny9Sqzp/E+bBAsuzWLukf+H8Kg
 VW6naQho/CEeGif+B0xlzVZR9EgT3ewxRLZSdRINPn87kyzoa1xpqjSghySw09oZPvFymWW3N
 wkst0lQ1DSyOC1R4mN7BeBZOwdLuizc1xuYddb/zJZrAKepoiRzXqHF71lPm+SOcyLJgYhxkW
 RgyITEVein1a9aS2AVvpvoKFjYDmgVPZY/qCnStLNwiJAn1zTaWdaCW8+XHQOUAmCBHgodJ5o
 duv9xP+/ovtoqOMzw6OVib07wRneMtlGRg1goJ4cOJy56OBU0k9w9m5qTnBPU3enPyUTAeBF/
 8gCHxm7GKYhEm6BVSmByu8UZ4cEYJJ7YsAO0RxV7dCT0a3aGBezFEasR9hXrVv/ALOs/SudFq
 VOjyh4Rjoqm7mXSHup5QjatfcJjFH7QuEYuAI3YNCTxVj5jHv6Hxw3iL+l5vVnaBGZluq+hzl
 9MYO3oG2c+LJikVmVawX2ynTnAo/NNuQl0h2pBlaIFEmm1coZmMs8/jeO8M9fqRfD+m/rJmjf
 4VxK74sgcACT8Z0H/49S/S88qQT8OoPZtqRk4DHd6inOb7IhzbGSbebpAijbmWYYHznP5ke0z
 yLEsdrZ3qsMzWpcn8LdxCI3ijpgRZT4YU+h1jqLQKjc+CN6LSnu9XDQI+pCbWcOpJXdUtvf3Z
 QJPZd3o9/Lh1K1/+eAr7flZI1BwAqF1ZZ1ef6BweMFjVHE3HlmQ7oQWMLpmOEYBsFkl1gYSrz
 8NBFlT/DmZzEFcTb3wyozA+UPno=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/16 01:50, Matt Corallo wrote:
>
>
> On 5/14/23 7:02=E2=80=AFPM, Matt Corallo wrote:
>>
>>
>> On 5/14/23 5:44=E2=80=AFPM, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/5/15 06:21, Matt Corallo wrote:
>>>>
>>>>
>>>> On 5/14/23 3:15=E2=80=AFPM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2023/5/15 05:40, Matt Corallo wrote:
>>>>> [...]
>>>>>>
>>>>>> After a further powerfailure and reboot this issue appeared again,
>>>>>> with
>>>>>> similar flood of dmesg of the same WARN_ON over and over and over
>>>>>> again.
>>>>>
>>>>> Sorry for the late reply.
>>>>>
>>>>> The full 300+MiB dmesg proved its usefulness, the sdd is hitting
>>>>> something wrong:
>>>>>
>>>>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 FAILED
>>>>> Result:
>>>>> hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D7s
>>>>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Sense Key =
:
>>>>> Medium Error [current]
>>>>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Add. Sense=
:
>>>>> Unrecovered read error
>>>>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 CDB:
>>>>> Read(16)
>>>>> 88 00 00 00 00 00 1a 20 44 00 00 00 04 00 00 00
>>>>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
>>>>> abort!scmd(0x000000007277df8f), outstanding for 30248 ms & timeout
>>>>> 30000 ms
>>>>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#307 CDB:
>>>>> Write(16)
>>>>> 8a 08 00 00 00 00 00 00 00 80 00 00 00 08 00 00
>>>>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: task abort: SUCCESS
>>>>> scmd(0x000000007277df8f)
>>>>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
>>>>> abort!scmd(0x000000007d5b5b6f), outstanding for 37624 ms & timeout
>>>>> 30000 ms
>>>>>
>>>>> Then it explained why the warning flooding, as it meets the
>>>>> condition to
>>>>> trigger the warning, a subpage bug where PageError and PageUpdate
>>>>> is not
>>>>> properly updated.
>>>>>
>>>>> I'll double check if Christoph's patch is the only thing left.
>>>>
>>>> Oops, that's a red herring, sorry. That is the drive that was failing
>>>> during the replace, so presumably it continuing to fail shouldn't be
>>>> cause for an error?
>>>>
>>>> More importantly, today's similar WARN_ON flood did not include any
>>>> such
>>>> line, and the full dmesg from the array being mounted until the WARN_=
ON
>>>> flood is literally:
>>>>
>>>> May 14 21:25:05 BEASTv3 kernel: BTRFS warning (device dm-2): read-wri=
te
>>>> for sector size 4096 with page size 65536 is experimental
>>>> May 14 21:25:09 BEASTv3 kernel: BTRFS info (device dm-2): bdev
>>>> /dev/mapper/bigraid49_crypt errs: wr 0, rd 0, flush 0, corrupt 0, gen=
 2
>>>> May 14 21:27:15 BEASTv3 kernel: BTRFS info (device dm-2): start
>>>> tree-log
>>>> replay
>>>> May 14 21:27:20 BEASTv3 kernel: BTRFS info (device dm-2): checking UU=
ID
>>>> tree
>>>> -- Some stuff talking about NICs appearing for containers --
>>>> May 14 21:34:52 BEASTv3 kernel: ------------[ cut here ]------------
>>>> May 14 21:34:52 BEASTv3 kernel: WARNING: CPU: 36 PID: 1018 at
>>>> fs/btrfs/extent_io.c:5301 assert_eb_page_uptodate+0x80/0x140 [btrfs]
>>>>
>>>> Note that the `gen 2` there is from at least a year ago and long
>>>> predates any issues here.
>>>
>>> Full debug mode kicked in.
>>>
>>> Would you mind to apply the attached patch and let it trigger?
>>>
>>> After the regular paper cut, there would be extra warning lines (no
>>> btrfs prefix yet), so please attach the warning and the following two
>>> lines for debug.
>>>
>>> Thanks,
>>> Qu
>>
>> Will build and see if I can reproduce. May be reproducible on your
>> end, basic scenario is:
>>
>> (a) mount -o commit=3D300,noatime (may or may not matter) on a subpage
>> (ppc64el) system
>> (b) have too much RAID1C3 metadata from a million files in some
>> maildir on spinning rust
>> (c) rm -r said maildir
>> (d) lose power before we finish rm'ing

Sorry, I still failed to reproduce the bug, at least with my 64K page
sized aarch64 machines.

I updated the debugging patch and submitted to upstream, with better
output for all the different bitmaps.

But never really triggered that assert_eb_page_uptodate() here even
once, and also failed to see any location where metadata can be read
without going through the regular btrfs metadata read path.

Unless there is some other mechanism which can read the pages and mark
it uptodate, without the involvement of the fs, then I failed to see how
this bug can happen.

Sorry for the inconvenience, but mind to do more debugging especially
with ftrace?
I can craft a patch which would record every metadata page read from
btrfs, and save them into ftrace buffer.
Then setup the system to crash when that assert_eb_page_uptodate() get
triggered, with all the ftrace buffer dumped at that timing.

This would greatly slow your system down, and you need a very reliable
way to dump the dying message (serial console preferred), which can also
be very large.

Thanks,
Qu
>
>
> Seems to reproduce reliably, did the above, rebooted with a new kernel,
> continued the rm of the same directory and hit a flood. dmesg from that
> boot through the flood, through stopping the rm, and unmount is at
> https://mattcorallo.com/dmesg-with-debug-patch-btrfs-list-may-2023.txt
> (170MB, probably download dont open in your browser), the first failure
> is pasted below.
>
> Note that the issue seems to go away after remounting the array and
> continuing the rm.
>
> Matt
>
> May 15 17:33:25 BEASTv3 kernel: ------------[ cut here ]------------
> May 15 17:33:25 BEASTv3 kernel: WARNING: CPU: 1 PID: 9 at
> fs/btrfs/extent_io.c:5301 assert_eb_page_uptodate+0x88/0x160 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: Modules linked in: xt_tcpudp wireguard
> libchacha20poly1305 libcurve25519_generic libchacha libpoly1305
> ip6_udp_tunnel udp_tunnel ipt_REJECT nf_reject_ipv4 veth nft_chain_nat
> xt_nat nf_nat xt_set xt_state xt_conntrack nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 nft_compat nf_tables crc32c_generic ip_set_hash_net
> ip_set_hash_ip ip_set nfnetlink bridge stp llc essiv authenc ast
> drm_vram_helper drm_ttm_helper ttm ofpart ipmi_powernv powernv_flash
> ipmi_devintf drm_kms_helper ipmi_msghandler mtd opal_prd syscopyarea
> sysfillrect sysimgblt fb_sys_fops i2c_algo_bit sg at24 regmap_i2c
> binfmt_misc drm fuse sunrpc drm_panel_orientation_quirks configfs
> ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> hid_generic usbhid hid raid6_pq libcrc32c raid1 raid0 multipath linear
> md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod xhci_pci
> xhci_hcd xts ecb ctr nvme vmx_crypto gf128mul
> May 15 17:33:25 BEASTv3 kernel:=C2=A0 crc32c_vpmsum tg3 mpt3sas nvme_cor=
e
> t10_pi usbcore libphy crc64_rocksoft_generic crc64_rocksoft crc_t10dif
> crct10dif_generic raid_class crc64 crct10dif_common ptp pps_core
> usb_common scsi_transport_sas
> May 15 17:33:25 BEASTv3 kernel: CPU: 1 PID: 9 Comm: kworker/u128:0 Not
> tainted 6.1.0-0.deb11.7-powerpc64le #1=C2=A0 Debian 6.1.20-2~bpo11+1a~te=
st
> May 15 17:33:25 BEASTv3 kernel: Hardware name: T2P9D01 REV 1.00 POWER9
> 0x4e1202 opal:skiboot-bc106a0 PowerNV
> May 15 17:33:25 BEASTv3 kernel: Workqueue: btrfs-cache btrfs_work_helper
> [btrfs]
> May 15 17:33:25 BEASTv3 kernel: NIP:=C2=A0 c00800000f6d0160 LR:
> c00800000f6d0148 CTR: c000000000d871c0
> May 15 17:33:25 BEASTv3 kernel: REGS: c0000000074c36c0 TRAP: 0700=C2=A0=
=C2=A0 Not
> tainted (6.1.0-0.deb11.7-powerpc64le Debian 6.1.20-2~bpo11+1a~test)
> May 15 17:33:25 BEASTv3 kernel: MSR:=C2=A0 9000000000029033
> <SF,HV,EE,ME,IR,DR,RI,LE>=C2=A0 CR: 2800228e=C2=A0 XER: 20040000
> May 15 17:33:25 BEASTv3 kernel: CFAR: c00800000f7805c8 IRQMASK: 0
> May 15 17:33:25 BEASTv3 kernel: NIP [c00800000f6d0160]
> assert_eb_page_uptodate+0x88/0x160 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: LR [c00800000f6d0148]
> assert_eb_page_uptodate+0x70/0x160 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: Call Trace:
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3960] [c00800000f6d0148]
> assert_eb_page_uptodate+0x70/0x160 [btrfs] (unreliable)
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c39a0] [c00800000f6d8d84]
> extent_buffer_test_bit+0x5c/0xb0 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c39e0] [c00800000f7632c4]
> free_space_test_bit+0xac/0x100 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3a40] [c00800000f7668e4]
> load_free_space_tree+0x1fc/0x570 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3b50] [c00800000f773214]
> caching_thread+0x41c/0x690 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3c20] [c00800000f6ec24c]
> btrfs_work_helper+0x154/0x518 [btrfs]
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3ca0] [c000000000162d68]
> process_one_work+0x2a8/0x580
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3d40] [c0000000001630d8]
> worker_thread+0x98/0x5e0
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3dc0] [c0000000001706c0]
> kthread+0x120/0x130
> May 15 17:33:25 BEASTv3 kernel: [c0000000074c3e10] [c00000000000cedc]
> ret_from_kernel_thread+0x5c/0x64
> May 15 17:33:25 BEASTv3 kernel: Instruction dump:
> May 15 17:33:25 BEASTv3 kernel: 80df0008 e8bf0000 7fc4f378 7c7c1b78
> 7fa3eb78 480b03bd 60000000 2c3c0000
> May 15 17:33:25 BEASTv3 kernel: 39200000 4082000c 68630001 5469063e
> <0b090000> e8010050 eb810020 ebe10038
> May 15 17:33:25 BEASTv3 kernel: ---[ end trace 0000000000000000 ]---
> May 15 17:33:25 BEASTv3 kernel: page=3D42783202934784 uptodate=3D1 error=
=3D0
> dirty=3D0 start=3D42783202967552 len=3D16384 bitmaps=3D
> May 15 17:33:25 BEASTv3 kernel: subpage offsets: uptodate=3D0 error=3D16
> dirty=3D32 writeback=3D48
