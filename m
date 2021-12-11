Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1B4712EA
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Dec 2021 09:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhLKIjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Dec 2021 03:39:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:35347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhLKIjV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Dec 2021 03:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639211948;
        bh=JmQ0oCCrUKJ2a2vYnZdwTXf7ARLnDA12S+1fV3Pmj2c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=P65DqWTBZ/GM6pDmAnkKfrl9NwwD0RGe3gp65qWVySmPVD4S8/StwZ9Aduk9TkME3
         tzLMPNRAQY70H7BpNr4eBZ03mGCCa5eaeU9bw/hVbq1Pzf+5KpHQtEm6Lk+zFMODzh
         3tzj6vaY+eM9/XFuyX+MjWKeAphNewtx3CNApFSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhhX-1mmrDo1PFf-00AqHi; Sat, 11
 Dec 2021 09:39:08 +0100
Message-ID: <29fcb603-506f-d721-5214-2870ce2f8773@gmx.com>
Date:   Sat, 11 Dec 2021 16:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>,
        Patrik Lundquist <patrik.lundquist@gmail.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@rx2.rx-server.de>
 <emb611c0ff-705d-4c01-b50f-320f962f39fb@frystation>
 <embddc7343-8fdf-4be8-87d8-644e20ea86c0@frystation>
 <em686698e8-bf89-4064-a66f-3298bb32ea05@rx2.rx-server.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em686698e8-bf89-4064-a66f-3298bb32ea05@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/N4Q9etOtX+ChQ7hDdoPU+zqvZc+EmswIkVNdcWSmHbdlM6OgCU
 hlzNH37pjbbhE0WZ9dO/8zBhEBVWoVrt2jY+rAKG6B2XsDSRdmH6oB7MoLQJZWGXQyGerHu
 cBBgbXMldoXe7lQKb3yPyBu2DwXHKr6fYXUiIXO78yRsgR8biudE0SAaj3NH2aFdhK0k8os
 3nMCxNL5Polat8l/KHjNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IgMBXP0gjCc=:mKXW6yFHRXf+tBokiTVlUU
 1QrbTUGzymCGjwWHABN9pWkM41i/WNkzjeJOF9mNIJJ9NEiZQcK2wf790h15KBIY5n/J9rhIp
 Sec5tnW4WMi0btSkXHgDqmYgU/QqJVZbQMjKV3ydw9IpmklVOqgPeq6qhdFORKehuxZv2pcHQ
 HRAXWfVDv27uA8P8wQKBWB6vEs5Zjtghw9RDQsXNTtUOGTk8Zrg1+sghbrgRDKSNBKruayFJE
 ZKGUqKkjMj8jG0jovt/E8MTzeO0bFLasCCttpaU+zszheSLNYn2DYqPN0Q++teucjVzBldqQc
 fCsIFdUmfJEQzUTTtfs2iCJDfU2YnTTmx3546H1yWfRShQx23rgqNj0kmNPaZHVhvPVPaK6Qz
 NchF0kxcq6wizfNQsw5dhfJ0PSS45JGp3lzbkAM/+XU3YWER2jGSHqwsoDQaPUPv+sYyu9jfT
 O4BmaVi6FGlJOMoBj6T8n3njJB2hdxO0ph0CSf4mQeZknpWLWH22gr82iuR4TG8cxeLFHIyGL
 1kLOYVKrhvuIuuFaW72okGZVmyyWvVnRP4oQxnpN7bLWHhxrWwU2LVwnEr05XDutJbcbFpipL
 0nH6bi/gzLRqVyFVXNhDCWetNT3WPq6zJrEFas/8hxG5lrD7NYesVK019qM0wl1culyBAmrJA
 heJUDLhEYlekt2YRd5XNeUnfMX3lETumSgCxVjwjHzte4E8cSDJm1OTZf7x2K/1bTqHT2kaLr
 NCS7nh4RHXU7EfYVmXDMwcN2N5ATBLfOMFCEFbSvafAOakQMLX62aDQNnb5wAyWkBbPZo4qSQ
 BOl4tPZEShq3eWQo1sWb3hnPUZrVAUrxY67YgF6P1wAOLHwIwUX4nsjLal8R7j7wdb4rJYD1f
 wr6qaUaP5ZFaA5WuYtyG7KxR1uyh57BqMzueF6/HsiA0cwdl0H0je88pO7Xdnr7QBF9ae00ob
 h2bdfyq/Wohpy4qCXELv+Ml6VKN80h8+tEjBlJaqbKXRUNdKLXejbAT7+q9eaqS1Y3CYQTNM1
 fvMENb0W/UuRSECoxtZwlR4FcfGkeG5V57hglk/WrmScklN+PMc+r7ZtBcDuctulvcPcDM1So
 ZHtONxB2pFQZo9nAYRFO05oHhfMcIOTHeXsojKRFTEUte56n4Wx1MuS98zPUqiQkTR9pdqKSg
 QlqaPKqz4dJKGm6bSuG4BhrMSb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/11 16:28, Mia wrote:
> Hi,
>
> just an addition, I'm now unable to mount and boot the server.
>
> https://drive.google.com/file/d/1QfqCR7oqKbaTxokCGWVmqNCR5vMul7Xy/view?u=
sp=3Dsharing

This is just log tree, thus btrfs-rescue zero-log can easily repair that.

This bug looks like something fixed by Filipe, but I'm not familiar
enough with log tree code.

Add Filipe to this thread.

Thanks,
Qu

>
>
> Regards
> Mia
>
> ------ Originalnachricht ------
> Von: "Mia" <9speysdx24@kr33.de>
> An: "Patrik Lundquist" <patrik.lundquist@gmail.com>; "Qu Wenruo"
> <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
> Gesendet: 11.12.2021 09:20:39
> Betreff: Re: filesystem corrupt - error -117
>
>> Hello,
>>
>> after the switching to the newer kernel I had no further problems
>> until now.
>> It happened again.
>>
>> [1653860.040458] BTRFS error (device sda3): tree first key mismatch
>> detected, bytenr=3D543379832832 parent_transid=3D1349283 key
>> expected=3D(468977471488,168,16384) has=3D(468983328768,168,61440)
>> [1653860.041095] ------------[ cut here ]------------
>> [1653860.041098] BTRFS: Transaction aborted (error -117)
>> [1653860.041289] WARNING: CPU: 2 PID: 219 at
>> fs/btrfs/extent-tree.c:2148 btrfs_run_delayed_refs+0x1a6/0x1f0 [btrfs]
>> [1653860.041291] Modules linked in: dm_mod veth ip6t_REJECT
>> nf_reject_ipv6 ip6_tables nf_log_ipv6 xfrm_user xfrm_algo br_netfilter
>> xt_recent ipt_REJECT nf_reject_ipv4 xt_multiport xt_comment
>> xt_hashlimit xt_conntrack xt_addrtype xt_mark xt_nat xt_CT
>> nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp
>> nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc
>> nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda
>> nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
>> nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_broadcast
>> nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nft_counter
>> nft_chain_nat xt_CHECKSUM xt_MASQUERADE nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp nft_compat wireguard
>> libchacha20poly1305 chacha_x86_64 nf_tables poly1305_x86_64
>> ip6_udp_tunnel udp_tunnel libblake2s nfnetlink blake2s_x86_64
>> curve25519_x86_64 libcurve25519_generic libchacha libblake2s_generic
>> overlay bridge stp llc fuse ext4
>> [1653860.041392]=C2=A0 amd_energy crc32_pclmul crc16 mbcache
>> ghash_clmulni_intel jbd2 aesni_intel libaes crypto_simd cryptd
>> glue_helper joydev sg virtio_console virtio_balloon evdev serio_raw
>> pcspkr qemu_fw_cfg sunrpc ip_tables x_tables autofs4 btrfs
>> blake2b_generic xor raid6_pq libcrc32c crc32c_generic hid_generic
>> usbhid hid sd_mod sr_mod cdrom t10_pi crc_t10dif crct10dif_generic
>> ata_generic virtio_net net_failover virtio_scsi failover bochs_drm
>> drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec ata_piix
>> uhci_hcd drm libata ehci_hcd usbcore crct10dif_pclmul crct10dif_common
>> virtio_pci crc32c_intel virtio_ring psmouse virtio usb_common scsi_mod
>> i2c_piix4 floppy button
>> [1653860.041483] CPU: 2 PID: 219 Comm: btrfs-transacti Tainted:
>> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 L=C2=A0=C2=A0=C2=A0 5.10.0-0.bpo.9-amd64 #1 Debian 5.10.70-1~bpo10+1
>> [1653860.041484] Hardware name: netcup KVM Server, BIOS RS 2000 G9
>> 06/01/2021
>> [1653860.041530] RIP: 0010:btrfs_run_delayed_refs+0x1a6/0x1f0 [btrfs]
>> [1653860.041535] Code: 8b 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 20 83
>> f8 fb 74 39 83 f8 e2 74 34 89 c6 48 c7 c7 68 0d 86 c0 89 04 24 e8 ac
>> 12 4b e7 <0f> 0b 8b 04 24 89 c1 ba 64 08 00 00 48 89 ef 89 04 24 48 c7
>> c6 a0
>> [1653860.041538] RSP: 0018:ffffa9ea8040fe10 EFLAGS: 00010282
>> [1653860.041541] RAX: 0000000000000000 RBX: ffff9d51c5fb9f70 RCX:
>> 0000000000000027
>> [1653860.041543] RDX: 0000000000000027 RSI: ffff9d54efd18a00 RDI:
>> ffff9d54efd18a08
>> [1653860.041546] RBP: ffff9d51c5fb9f70 R08: 0000000000000000 R09:
>> c0000000ffffefff
>> [1653860.041548] R10: 0000000000000001 R11: ffffa9ea8040fc18 R12:
>> ffff9d51f0cda800
>> [1653860.041550] R13: ffff9d51e183b460 R14: ffff9d51e183b340 R15:
>> 0000000000000cca
>> [1653860.041556] FS:=C2=A0 0000000000000000(0000) GS:ffff9d54efd00000(0=
000)
>> knlGS:0000000000000000
>> [1653860.041558] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [1653860.041561] CR2: 00007fd3ecdd1000 CR3: 0000000102288000 CR4:
>> 0000000000350ee0
>> [1653860.041583] Call Trace:
>> [1653860.041675]=C2=A0 btrfs_commit_transaction+0x57/0xb70 [btrfs]
>> [1653860.041722]=C2=A0 ? start_transaction+0xd3/0x580 [btrfs]
>> [1653860.041767]=C2=A0 transaction_kthread+0x15d/0x180 [btrfs]
>> [1653860.041810]=C2=A0 ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [1653860.041817]=C2=A0 kthread+0x116/0x130
>> [1653860.041821]=C2=A0 ? __kthread_cancel_work+0x40/0x40
>> [1653860.041826]=C2=A0 ret_from_fork+0x22/0x30
>> [1653860.041831] ---[ end trace af79c203a5452514 ]---
>> [1653860.041835] BTRFS: error (device sda3) in
>> btrfs_run_delayed_refs:2148: errno=3D-117 Filesystem corrupted
>> [1653860.042111] BTRFS info (device sda3): forced readonly
>>
>> root@rx1 ~ # btrfs fi show
>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>> =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 186.78GiB
>> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB used 199.08=
GiB path /dev/sda3
>>
>> root@rx1 ~ # btrfs fi df
>> /
>> :(
>> Data, single: total=3D194.89GiB, used=3D185.16GiB
>> System, single: total=3D32.00MiB, used=3D48.00KiB
>> Metadata, single: total=3D4.16GiB, used=3D1.62GiB
>> GlobalReserve, single: total=3D385.84MiB, used=3D0.00B
>>
>> root@rx1 ~ # btrfs --version
>> btrfs-progs v5.10.1
>>
>> root@rx1 ~ # uname -a
>> Linux rx1 5.10.0-0.bpo.9-amd64 #1 SMP Debian 5.10.70-1~bpo10+1
>> (2021-10-10) x86_64 GNU/Linux
>>
>> Regards
>> Mia
>>
>> ------ Originalnachricht ------
>> Von: "Mia" <9speysdx24@kr33.de>
>> An: "Patrik Lundquist" <patrik.lundquist@gmail.com>; "Qu Wenruo"
>> <quwenruo.btrfs@gmx.com>
>> Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
>> Gesendet: 26.10.2021 19:28:14
>> Betreff: Re: filesystem corrupt - error -117
>>
>>> Hi Patrik,
>>>
>>> good suggestion, I'm on 5.10.0-0.bpo.8-amd64 #1 SMP Debian
>>> 5.10.46-4~bpo10+1 (2021-08-07) now.
>>>
>>> Hi Qu,
>>> regarding the memtest. This is a virtual machine, I have no access to
>>> the host system.
>>> I don't know if a memtest inside the vm would bring legit results?
>>>
>>> Regards
>>> Mia
>>>
>>> ------ Originalnachricht ------
>>> Von: "Patrik Lundquist" <patrik.lundquist@gmail.com>
>>> An: "Mia" <9speysdx24@kr33.de>
>>> Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
>>> Gesendet: 26.10.2021 16:12:45
>>> Betreff: Re: filesystem corrupt - error -117
>>>
>>>> On Tue, 26 Oct 2021 at 09:15, Mia <9speysdx24@kr33.de> wrote:
>>>>>
>>>>> =C2=A0Problem with updating is that this is currently still Debian 1=
0 and a
>>>>> =C2=A0production environment and I don't know when it is possible to
>>>>> upgrade
>>>>> =C2=A0because of dependencies.
>>>>
>>>> Maybe you can install the buster-backports kernel which currently is
>>>> 5.10.70?
>>>>
>>>> https://backports.debian.org/Instructions/
>
