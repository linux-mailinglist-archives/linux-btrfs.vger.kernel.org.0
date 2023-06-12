Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1C72B73F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 07:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjFLFUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 01:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFLFUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 01:20:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B1113
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686547235; x=1687152035; i=quwenruo.btrfs@gmx.com;
 bh=pQgbk95aPWH8Ir1/MQ6GH8ci6OtVTrSwzgYqX7V0O50=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=FzSxbkP/4rqY/wM4Ni19euwrMgY/oEUe5sGjtBNyjnZdN/RGPipzAItThIlKuL2bvDOP5fg
 himoF6MCvtIwnHyF31OQCOQC1i+iQPjDm08nGw8HNB8onsZdNV2HVhucgyYYC8hAiP0oHP2kZ
 5VAfPu9ePC7m9HZWmmVxFv4XhkMaiJwkPo+ggYx5PFUYKQaI7G1voFoYoFzC58MZnY0pnzkgX
 hEGsvIhe20UR2BYvq1DPe7nPVSYeLy8BgrQa8sTfomy3N8bowTTP8qkbWssgtVc6uKjPxQ2Ur
 XDdxQE2jwsXP/JM3i0+QQ1h+xZC7DsQ1k4QHtOMEFUBzMNcoivDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Ra-1q6Hm62Jqa-016NRm; Mon, 12
 Jun 2023 07:20:35 +0200
Message-ID: <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
Date:   Mon, 12 Jun 2023 13:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Out of space loop: skip_balance not working
In-Reply-To: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HCW6aM9On/DcwZ2r1ZWbYDKlA7PSpiIQLvFVcg3MRcQuY68Ga7V
 3JUIeCZghuhgmSCENJw8HHEOPtQsq0wWNwaO/EffhI73U6FSXijfwRLQV/IztwrdzARsqZo
 uLwnmdbV+9DnIoBt7BSYVNiZhkIyolKIxlFT8XZPhemSLbq8vtcQPsAgYGroUvjXwVYcniy
 NBYkyxco6Pk6uH8dDAAlQ==
UI-OutboundReport: notjunk:1;M01:P0:biH58iGDMos=;r8hFuDWHMm20F3KAKD2yCIpmQ+n
 frzO7bLCu6BhuYEHhqgzkMghmv5ofEr9g2dg1fMM+eVmi/01HEzu5QlyG9AfUh10us4puDecY
 +r8KRg6git+1NqW7f9dD2tKwhP+bVUOlWou+1vcXI/BxT9YxH2kj+bclZdQKGHTwFCr85lUzC
 70bZLp46XA32RlVO0qtSdUz/M7GK3HUCKdWBqs0Y/v4Mdt3FOJcBe2jGMH80ZOUsjYEIJjfGi
 Wvqz8/enpfW1nkChNmSJkSMml+nekPr0u1r9OgMyVRStYuivNAJ5NZ3nNsWaQi9nMaN92NZLI
 ZixW95TjIhbDTGOfBZC+OWUEu5ELWYatc9pN73eFNqoE20aRcmGFJVD4MUs76MQuAqHALwaWG
 HceE3+L24m783EX5s+iEzSIAN4vYvchA619Fr4mRssrSi9cTQHoRDqhItpW+ja6gFMj7bRc7K
 EOj88cHW/ZMVUnuK0++e9rBt0M8p1spM4I7c/76Lb/YOGQ2nWTzjOCqBcPh174XZVvNEdI0DX
 UYJ6LeEnBwFELgRiDv2iv8OK1PeynmaOmIwK5gu2xPEQzz/YCmxmq1E+12cbJhMT1VmkAk+Rd
 lcMXUbdNqugQJd7FNikSH0Z8tpZuYAmia/mKBubbLKpgPw9N5a4fk79CHmwbAmG2AO6ed0ba/
 a8dFFw3JF2bfm/W8AaWZx7eqVC9lughgmC+pHpa4OnU6X/ylpqfrzjNNsCvbHOiLqAx/g7CIB
 yiUaUsCVVZl9oAST5rJKWkTg286ExyfMMy3WF/jGE2yH3CFt75M9OK/TswJUvO0ObiVS+Vqqs
 Mih0uwm0H3eE+Z0KEPhZExb/pax6HI1jFhg03AdPaHJe/8W7Vb3Ghqgmz84AE+dNEoSFTrTFk
 DzwTVAQ8n0ERgsHKvsqT6oNVYQDhJsdb7zC4nQS90enkHSK9PX7ye0YZLA3Mfr2BP0u4iz2ZR
 fElvLkOVUnaK8bf/GMwkq9o6Jmk=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/12 12:47, Stefan N wrote:
> Hi,
>
> I'm having trouble trying to break my array out of an out of space loop.
>
> On reboot I'm able to mount the filesystem and read files fine but as
> soon as I try to delete/write it hangs until the mount is made read
> only when it then fails.
>
> The following command (immediately after boot, no fstab) suggests
> perhaps the skip_balance is not working as expected:
> $ mount -o skip_balance -t btrfs /dev/sde /mnt/point && btrfs device
> add /dev/loop12 /mnt/point/
> ERROR: unable to start device add, another exclusive operation
> 'balance' in progress

skip_balance makes the balance into the paused status.
You still need to cancel it first.

> and ps shows a [btrfs-balance] process.

Furthermore, balance won't help for your case.

Both metadata and data are almost full.

>
> If I perform a rm or truncate during this window it fails to perform
> any action before being marked read only. The same applies if I
> attempt to cancel the balance.
>
> How can I get out of this cycle? I've previously run out of space and
> been able to recover by deleting a few files etc without needing to
> invoke skip_balance, but that was likely on older versions.
>
> Any help would be greatly appreciated.
>
> - Stefan
>
> $ uname -a
> Linux my.host 5.15.0-73-generic #80-Ubuntu SMP Mon May 15 15:18:26 UTC
> 2023 x86_64 x86_64 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v5.16.2
> $ btrfs fi show
> Label: none  uuid: ---
>          Total devices 8 FS bytes used 64.67TiB
>          devid    1 size 10.91TiB used 10.91TiB path /dev/sdk
>          devid    2 size 10.91TiB used 10.91TiB path /dev/sdh
>          devid    3 size 10.91TiB used 10.91TiB path /dev/sdj
>          devid    4 size 10.91TiB used 10.91TiB path /dev/sdi
>          devid    5 size 10.91TiB used 10.91TiB path /dev/sdf
>          devid    6 size 10.91TiB used 10.91TiB path /dev/sdg
>          devid    7 size 10.91TiB used 10.91TiB path /dev/sdd
>          devid    8 size 10.91TiB used 10.91TiB path /dev/sde
> $ btrfs fi df /mnt/point/
> Data, RAID6: total=3D64.76TiB, used=3D64.59TiB
> System, RAID1C4: total=3D37.00MiB, used=3D5.11MiB
> Metadata, RAID1C4: total=3D77.79GiB, used=3D77.10GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D387.11MiB
> $
>

My recommendation is, try some newer kernel (easier with a rolling
distro liveCD).

Still with skip_balance, cancel the balance, and delete a small file
first, then sync, and check if the fs is still fine.

Then start with larger and larger files/subvolumes.

Thanks,
Qu

> BTRFS: Transaction aborted (error -28)
> BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=3D-28 No sp=
ace left
> BTRFS info (device sdk): forced readonly
> BTRFS error (device sdk): failed to run delayed ref for logical
> 101911627694080 num_bytes 126976 type 184 action 2 ref_mod 1: -28
> WARNING: CPU: 2 PID: 7851 at fs/btrfs/extent-tree.c:3180
> __btrfs_free_extent+0x7e4/0x950 [btrfs]
> BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=3D-28 No
> space left
> BTRFS warning (device sdk): btrfs_uuid_scan_kthread failed -28
> Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
> xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat
> nf_tables nfnetlink br_netfilter bridge stp llc ipmi_devintf
> ipmi_msghandler overlay binfmt_misc intel_rapl_msr intel_rapl_common
> edac_mce_amd snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi kvm_amd nls_iso8859_1 kvm snd_hda_intel rapl
> snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core
> wmi_bmof input_leds snd_hwdep snd_pcm k10temp snd_timer snd ccp
> soundcore mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua bonding tls ramoops pstore_blk msr reed_solomon
> pstore_zone efi_pstore nfsd auth_rpcgss nfs_acl lockd grace sunrpc
> ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 multipath linear
> hid_generic usbhid hid uas usb_storage amdgpu iommu_v2 gpu_sched
> drm_ttm_helper crct10dif_pclmul ttm drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops crc32_pclmul cec ghash_clmulni_intel
> aesni_intel mpt3sas rc_core raid_class crypto_simd drm nvme i2c_piix4
> cryptd scsi_transport_sas igb dca ahci libahci xhci_pci qlcnic
> i2c_algo_bit nvme_core xhci_pci_renesas wmi video
> CPU: 2 PID: 7851 Comm: btrfs-transacti Not tainted 5.15.0-73-generic #80=
-Ubuntu
> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> P3.70 02/23/2022
> RIP: 0010:__btrfs_free_extent+0x7e4/0x950 [btrfs]
> Code: a0 48 05 50 0a 00 00 f0 48 0f ba 28 03 72 1d 8b 45 84 83 f8 fb
> 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 f6 34 c1 e8 ed 42 a9 e6 <0f> 0b
> 8b 4d 84 48 8b 7d 90 ba 6c 0c 00 00 48 c7 c6 60 39 34 c1 e8
> RSP: 0018:ffffb63581c9fb68 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 00000000000000d1 RCX: 0000000000000027
> RDX: ffff8ceda0aa0588 RSI: 0000000000000001 RDI: ffff8ceda0aa0580
> RBP: ffffb63581c9fc10 R08: 0000000000000003 R09: fffffffffffe2710
> R10: 000000002938322d R11: 00000000322d2072 R12: 00005cb02659c000
> R13: 00000000000014ce R14: ffff8ce8ab3fb7e0 R15: ffff8ce8de433800
> FS:  0000000000000000(0000) GS:ffff8ceda0a80000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055f2f46bb4c8 CR3: 000000010814c000 CR4: 00000000003506e0
> Call Trace:
> <TASK>
> run_delayed_data_ref+0x93/0x160 [btrfs]
> btrfs_run_delayed_refs_for_head+0x193/0x520 [btrfs]
> __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
> btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> btrfs_start_dirty_block_groups+0x296/0x4f0 [btrfs]
> btrfs_commit_transaction+0x716/0xaa0 [btrfs]
> ? start_transaction+0xd1/0x5b0 [btrfs]
> ? __bpf_trace_hrtimer_init+0x20/0x20
> transaction_kthread+0x13c/0x1b0 [btrfs]
> ? btrfs_cleanup_transaction.isra.0+0x3c0/0x3c0 [btrfs]
> kthread+0x12a/0x150
> ? set_kthread_struct+0x50/0x50
> ret_from_fork+0x22/0x30
> </TASK>
> ---[ end trace 8a20922ac453f776 ]---
> BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=3D-28 No sp=
ace left
> BTRFS error (device sdk): failed to run delayed ref for logical
> 101911627415552 num_bytes 126976 type 184 action 2 ref_mod 1: -28
> BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=3D-28 No
> space left
