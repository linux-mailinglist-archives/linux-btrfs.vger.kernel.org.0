Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066963F776
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 19:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLAS1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 13:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLAS1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 13:27:45 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D51BF51
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 10:27:40 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 443FC320010B
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 13:27:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Thu, 01 Dec 2022 13:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8henrie.com; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669919255; x=1670005655; bh=3KL8N+ub/g
        1qHXQx+VyVudTkXwWFps1IE6Kzm28I1Bc=; b=UVY+xjME9PnilDEvuvv+E91z3k
        DcP2YVqUnxBjFTzfKbvrAwM4JlC+xumPH9YYHOaLmoxY67oKNCsgbX/wC22bJF2J
        Dou37g72SxfXrFe308gWi7A1O80pZ6IBSkd3MYavzcv44s7ZkXpELHQC/Mlcqo4X
        8m3uMvgG/772coHeG/srdy48+3F6uUDHp7JSv6I4BmTp9JMS7Jmv8zmBj80m9Q/Z
        hcvnKY/Gc6Rh3TzElFMlmUUgKu/rI7BkyOu/KqtTUIMud07iUqqeoFZ5M1qBEPkQ
        2BHb8mRnQOno0V5PUxaaMtren4xckGtBu7qa+DcYVZ64FasJHNdSwu7oaZxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669919255; x=1670005655; bh=3KL8N+ub/g1qHXQx+VyVudTkXwWF
        ps1IE6Kzm28I1Bc=; b=QaAmCmCcCDy7ENAlvkOsM6xqBVkngIs7KmzddYLX/qdy
        MbTtYkfFaUgNm2+4uj/eDf8AutMGB0QIWCFdxmIcSL9d++TeIQf0ttnNbOu5Sw4n
        G2FziHx2eCSLF86eW/h3kRO8DcP8C1XT8XeDIY7wqqXw2ygyssp3Y4naT2gsHeBr
        q33HWsk4Qz37QoNFp3GXTkZtfgwy7y8dkw3OtUa/lk/7QmUvwjZDF3Ojuvc4jFPc
        cHodgP8n+aLblPPYX9Q0cUOTeagduXaQNr21XCtlHMmmeMiKdsh6B4q43Y3PfC91
        rsE36jG8s/v44XWtCDOAgpubcPaS/zQRTWKkvi0ppQ==
X-ME-Sender: <xms:F_KIY-AY5E4hfyx0doy3YnUblHSj1SthdwGJUt83wTCxzNiEYPPLMw>
    <xme:F_KIY4jz7fu9C2zQLDyyqOlAX1cGEmPRIV1cvJdOCKi1x9WJcxkB6zaTOYnFDe0vx
    MPnhIqMThODEps_utg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreertdenucfhrhhomhepfdfprghthhgrnhcujfgvnhhrihgvfdcuoehnrghtvgesnhek
    hhgvnhhrihgvrdgtohhmqeenucggtffrrghtthgvrhhnpedvheekfffghfettdfffedtle
    egveeltdejkedtleetteeitdejhfffuddvieejvdenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epnhgrthgvsehnkehhvghnrhhivgdrtghomh
X-ME-Proxy: <xmx:F_KIYxk53XUpRnqGHpfvtncF7GAAEXwQVaCT-Kd5Iql_5pT-__FyXA>
    <xmx:F_KIY8wxbYavjJYt_n95s8s9FxulWVgrDjvtM3W3Vi6GneUFDPCyuA>
    <xmx:F_KIYzRAj2PeD_dmZmkd5bnoRzXL4ZH-RpgeT_soPHBgbe0JmYkC-Q>
    <xmx:F_KIY6e_ihve8yKnBX_hZ5RW2xCk0zdzFQpg4eUxdXDkFMcMS9P5Xw>
Feedback-ID: iffd94604:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 85220B60086; Thu,  1 Dec 2022 13:27:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
Date:   Thu, 01 Dec 2022 11:27:13 -0700
From:   "Nathan Henrie" <nate@n8henrie.com>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS RAID1 root corrupt and read-only
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I've been happily running a BTRFS RAID1 root across 3 x 1TB NVME drives =
on my Arch Linux machine for a few years with minimal (mostly quota-rela=
ted) issues.

I ran balance a few days ago that failed, and then my root went read-onl=
y. I found some smartd errors in one drive, so I expected to be able to =
use a recovery USB and recover by dropping the bad drive and rebalancing=
, but unfortunately the array goes read-only almost immediately after mo=
unting, so I'm unable to modify anything. I've tried various mount optio=
ns from btrfs.wiki.kernel.org and suse.com with no luck. A `btrfs check`=
 fails; I have *not* run a `--repair`. Most / all of the data is backed =
up elsewhere, and thankfully I can mount read-only so I am currently rsy=
ncing everything as an additional measure.

I've been using `space_cache=3Dv2` for the last several months, mostly t=
o see if it would fix my "freezing with quotas enabled" issue (https://l=
ore.kernel.org/linux-btrfs/CAOMt5FCSFC8d-cioM39wZ3jME9+5=3DC4P8omZOfmQz3=
4P9a8MdA@mail.gmail.com/).

So far, I've tried mounting variously with `-o rw,skip-balance,clear_cac=
he,degraded`, together and in various combinations; it mounts RW for a f=
ew seconds at most (meanwhile I see `checking UUID tree` in dmesg), then=
 goes ro.

Obviously while it's ro I can't scrub. When I try to remove the dead dri=
ve I see an error about balance, even though I've mounted with `skip_bal=
ance`:

# btrfs dev remove missing /mnt
ERROR: unable to start device remove, another exclusive operation 'balan=
ce' in progress
# mount | grep btrfs
/dev/nvme0n1p1 on /mnt type btrfs (ro,relatime,degraded,ssd,space_cache,=
skip_balance,subvolid=3D5,subvol=3D/)

I'm about out of ideas, but before I try a `--repair` or `zero-log` thou=
ght I'd touch base. The below dmesg output was prior to mounting with `s=
kip_balance`, but hopefully should be relevant (I see simliar errors). C=
urrently my rsync is running; once that job is finished I can `dmesg --c=
lear` and try to mount again with any option that may provide useful out=
put.

Thanks for any ideas or help.

uname -a
Linux nixos 5.15.79 #1-NixOS SMP Wed Nov 16 08:58:31 UTC 2022 x86_64 GNU=
/Linux

btrfs --version
btrfs-progs v5.17=20

btrfs fi show
Label: 'Arch Linux'  uuid: 0507d652-8d7a-4897-a843-2fb170634055
        Total devices 3 FS bytes used 665.35GiB
        devid    1 size 931.01GiB used 619.03GiB path /dev/nvme0n1p1
        devid    3 size 418.00GiB used 105.03GiB path /dev/nvme1n1p1
        *** Some devices missing

btrfs fi df /mnt
Data, RAID1: total=3D621.00GiB, used=3D620.06GiB
System, RAID1: total=3D32.00MiB, used=3D128.00KiB
Metadata, RAID1: total=3D50.00GiB, used=3D45.29GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

dmesg
[   15.797066] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dno, fsverity=
=3Dno
[   15.798634] BTRFS: device label Arch Linux devid 1 transid 7325235 /d=
ev/nvme0n1p1 scanned by systemd-udevd (1196)
[   15.798783] BTRFS: device label Arch Linux devid 3 transid 7325235 /d=
ev/nvme2n1p1 scanned by systemd-udevd (1203)
[   15.802950] BTRFS: device label Arch Linux devid 4 transid 7325235 /d=
ev/nvme1n1p1 scanned by systemd-udevd (1265)
[  493.287981] BTRFS info (device nvme0n1p1): force zstd compression, le=
vel 3
[  493.287987] BTRFS info (device nvme0n1p1): using free space tree
[  493.287988] BTRFS info (device nvme0n1p1): has skinny extents
[  493.293622] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[  493.293626] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[  493.479401] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[  507.414570] BTRFS info (device nvme0n1p1): checking UUID tree
[  509.230417] WARNING: CPU: 12 PID: 70885 at fs/btrfs/extent-tree.c:304=
9 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[  509.230453] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[  509.230552] CPU: 12 PID: 70885 Comm: btrfs-balance Tainted: P        =
   O      5.15.79 #1-NixOS
[  509.230557] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[  509.230605]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[  509.230635]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[  509.230657]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[  509.230679]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[  509.230703]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[  509.230734]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[  509.230767]  btrfs_balance+0x32d/0xea0 [btrfs]
[  509.230810]  balance_kthread+0x57/0xd0 [btrfs]
[  509.230837]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[  509.230877] BTRFS info (device nvme0n1p1): leaf 14486444539904 gen 73=
25238 total ptrs 198 free space 4502 owner 2
[  509.231393] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[  509.231397] BTRFS: Transaction aborted (error -2)
[  509.231403] WARNING: CPU: 12 PID: 70885 at fs/btrfs/extent-tree.c:305=
5 __btrfs_free_extent+0x730/0x920 [btrfs]
[  509.231426] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[  509.231487] CPU: 12 PID: 70885 Comm: btrfs-balance Tainted: P        =
W  O      5.15.79 #1-NixOS
[  509.231489] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[  509.231528]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[  509.231557]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[  509.231580]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[  509.231601]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[  509.231625]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[  509.231654]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[  509.231690]  btrfs_balance+0x32d/0xea0 [btrfs]
[  509.231724]  balance_kthread+0x57/0xd0 [btrfs]
[  509.231752]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[  509.231788] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[  509.231790] BTRFS info (device nvme0n1p1): forced readonly
[  509.231792] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[  509.231799] BTRFS info (device nvme0n1p1): balance: resume -dusage=3D=
90 -musage=3D90 -susage=3D90
[  509.232332] BTRFS info (device nvme0n1p1): balance: ended with status=
: -30
[  585.561606] BTRFS info (device nvme0n1p1): force zstd compression, le=
vel 3
[  585.561612] BTRFS info (device nvme0n1p1): using free space tree
[  585.561614] BTRFS info (device nvme0n1p1): has skinny extents
[  585.565376] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[  585.565382] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[  585.735848] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[  599.561326] BTRFS info (device nvme0n1p1): checking UUID tree
[  601.401009] WARNING: CPU: 15 PID: 70976 at fs/btrfs/extent-tree.c:304=
9 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[  601.401046] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[  601.401148] CPU: 15 PID: 70976 Comm: btrfs-balance Tainted: P        =
W  O      5.15.79 #1-NixOS
[  601.401153] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[  601.401199]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[  601.401232]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[  601.401256]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[  601.401280]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[  601.401306]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[  601.401340]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[  601.401376]  btrfs_balance+0x32d/0xea0 [btrfs]
[  601.401417]  balance_kthread+0x57/0xd0 [btrfs]
[  601.401446]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[  601.401490] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25240 total ptrs 198 free space 4502 owner 2
[  601.402017] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[  601.402022] BTRFS: Transaction aborted (error -2)
[  601.402028] WARNING: CPU: 15 PID: 70976 at fs/btrfs/extent-tree.c:305=
5 __btrfs_free_extent+0x730/0x920 [btrfs]
[  601.402052] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[  601.402116] CPU: 15 PID: 70976 Comm: btrfs-balance Tainted: P        =
W  O      5.15.79 #1-NixOS
[  601.402118] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[  601.402154]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[  601.402187]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[  601.402211]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[  601.402234]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[  601.402260]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[  601.402292]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[  601.402326]  btrfs_balance+0x32d/0xea0 [btrfs]
[  601.402363]  balance_kthread+0x57/0xd0 [btrfs]
[  601.402393]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[  601.402432] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[  601.402435] BTRFS info (device nvme0n1p1): forced readonly
[  601.402437] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[  601.402445] BTRFS info (device nvme0n1p1): balance: resume -dusage=3D=
90 -musage=3D90 -susage=3D90
[  601.402881] BTRFS info (device nvme0n1p1): balance: ended with status=
: -30
[ 1269.189801] BTRFS info (device nvme0n1p1): force zstd compression, le=
vel 3
[ 1269.189807] BTRFS info (device nvme0n1p1): using free space tree
[ 1269.189808] BTRFS info (device nvme0n1p1): has skinny extents
[ 1269.194029] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 1269.194034] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 1269.367881] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 1283.249197] BTRFS info (device nvme0n1p1): checking UUID tree
[ 1285.161738] WARNING: CPU: 8 PID: 72755 at fs/btrfs/extent-tree.c:3049=
 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 1285.161770] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 1285.161863] CPU: 8 PID: 72755 Comm: btrfs-balance Tainted: P        W=
  O      5.15.79 #1-NixOS
[ 1285.161867] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 1285.161910]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 1285.161942]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 1285.161965]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 1285.161986]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 1285.162010]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 1285.162041]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 1285.162073]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 1285.162110]  balance_kthread+0x57/0xd0 [btrfs]
[ 1285.162137]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 1285.162176] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25242 total ptrs 198 free space 4502 owner 2
[ 1285.162681] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[ 1285.162686] BTRFS: Transaction aborted (error -2)
[ 1285.162691] WARNING: CPU: 8 PID: 72755 at fs/btrfs/extent-tree.c:3055=
 __btrfs_free_extent+0x730/0x920 [btrfs]
[ 1285.162714] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 1285.162774] CPU: 8 PID: 72755 Comm: btrfs-balance Tainted: P        W=
  O      5.15.79 #1-NixOS
[ 1285.162777] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[ 1285.162810]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 1285.162840]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 1285.162862]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 1285.162884]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 1285.162908]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 1285.162937]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 1285.162968]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 1285.163003]  balance_kthread+0x57/0xd0 [btrfs]
[ 1285.163030]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 1285.163066] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[ 1285.163069] BTRFS info (device nvme0n1p1): forced readonly
[ 1285.163070] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[ 1285.163078] BTRFS info (device nvme0n1p1): balance: resume -dusage=3D=
90 -musage=3D90 -susage=3D90
[ 1285.163723] BTRFS info (device nvme0n1p1): balance: ended with status=
: -30
[ 1401.283280] BTRFS info (device nvme0n1p1): scrub: started on devid 3
[ 1401.283285] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 3 with status: -30
[ 1401.283288] BTRFS info (device nvme0n1p1): scrub: started on devid 1
[ 1401.283297] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 1 with status: -30
[ 1401.283297] BTRFS info (device nvme0n1p1): scrub: started on devid 4
[ 1401.283302] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 4 with status: -30
[ 1407.867930] BTRFS info (device nvme0n1p1): scrub: started on devid 3
[ 1407.867934] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 3 with status: -30
[ 1407.867940] BTRFS info (device nvme0n1p1): scrub: started on devid 1
[ 1407.867947] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 1 with status: -30
[ 1407.867947] BTRFS info (device nvme0n1p1): scrub: started on devid 4
[ 1407.867953] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 4 with status: -30
[ 1411.796332] BTRFS info (device nvme0n1p1): scrub: started on devid 1
[ 1411.796336] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 1 with status: -30
[ 1411.796480] BTRFS info (device nvme0n1p1): scrub: started on devid 4
[ 1411.796483] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 4 with status: -30
[ 1411.796486] BTRFS info (device nvme0n1p1): scrub: started on devid 3
[ 1411.796489] BTRFS info (device nvme0n1p1): scrub: not finished on dev=
id 3 with status: -30
[ 2012.445628] BTRFS info (device nvme0n1p1): force zstd compression, le=
vel 3
[ 2012.445634] BTRFS warning (device nvme0n1p1): 'recovery' is deprecate=
d, use 'rescue=3Dusebackuproot' instead
[ 2012.445636] BTRFS info (device nvme0n1p1): trying to use backup root =
at mount time
[ 2012.445637] BTRFS info (device nvme0n1p1): using free space tree
[ 2012.445639] BTRFS info (device nvme0n1p1): has skinny extents
[ 2012.451509] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 2012.451514] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 2012.642987] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 2028.463270] WARNING: CPU: 14 PID: 73178 at fs/btrfs/extent-tree.c:304=
9 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 2028.463306] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 2028.463410] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 2028.463453]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 2028.463483]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 2028.463505]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 2028.463527]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 2028.463550]  ? start_transaction+0xce/0x5a0 [btrfs]
[ 2028.463573]  close_ctree+0x15d/0x316 [btrfs]
[ 2028.463603]  ? btrfs_resume_balance_async+0x7c/0xb0 [btrfs]
[ 2028.463630]  ? btrfs_start_pre_rw_mount+0x12b/0x190 [btrfs]
[ 2028.463652]  open_ctree+0x1643/0x17b0 [btrfs]
[ 2028.463682]  btrfs_mount_root.cold+0x13/0xfa [btrfs]
[ 2028.463722]  btrfs_mount+0x137/0x440 [btrfs]
[ 2028.463776] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25244 total ptrs 198 free space 4502 owner 2
[ 2028.464260] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[ 2028.464265] BTRFS: Transaction aborted (error -2)
[ 2028.464271] WARNING: CPU: 14 PID: 73178 at fs/btrfs/extent-tree.c:305=
5 __btrfs_free_extent+0x730/0x920 [btrfs]
[ 2028.464293] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 2028.464353] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[ 2028.464386]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 2028.464415]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 2028.464437]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 2028.464459]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 2028.464482]  ? start_transaction+0xce/0x5a0 [btrfs]
[ 2028.464506]  close_ctree+0x15d/0x316 [btrfs]
[ 2028.464534]  ? btrfs_resume_balance_async+0x7c/0xb0 [btrfs]
[ 2028.464561]  ? btrfs_start_pre_rw_mount+0x12b/0x190 [btrfs]
[ 2028.464584]  open_ctree+0x1643/0x17b0 [btrfs]
[ 2028.464612]  btrfs_mount_root.cold+0x13/0xfa [btrfs]
[ 2028.464645]  btrfs_mount+0x137/0x440 [btrfs]
[ 2028.464690] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[ 2028.464693] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[ 2028.464699] BTRFS error (device nvme0n1p1): commit super ret -2
[ 2031.626445] BTRFS error (device nvme0n1p1): open_ctree failed
[ 2036.768229] BTRFS info (device nvme0n1p1): force zstd compression, le=
vel 3
[ 2036.768235] BTRFS warning (device nvme0n1p1): 'recovery' is deprecate=
d, use 'rescue=3Dusebackuproot' instead
[ 2036.768236] BTRFS info (device nvme0n1p1): trying to use backup root =
at mount time
[ 2036.768238] BTRFS info (device nvme0n1p1): using free space tree
[ 2036.768239] BTRFS info (device nvme0n1p1): has skinny extents
[ 2036.772250] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 2036.772255] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 2036.943102] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 6812.445541] BTRFS info (device nvme0n1p1): using free space tree
[ 6812.445546] BTRFS info (device nvme0n1p1): has skinny extents
[ 6812.449699] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 6812.449707] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 6812.624462] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 6846.929545] BTRFS info (device nvme0n1p1): using free space tree
[ 6846.929550] BTRFS info (device nvme0n1p1): has skinny extents
[ 6846.933810] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 6846.933816] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 6847.106767] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 7368.530374] BTRFS info (device nvme0n1p1): allowing degraded mounts
[ 7368.530378] BTRFS info (device nvme0n1p1): using free space tree
[ 7368.530379] BTRFS info (device nvme0n1p1): has skinny extents
[ 7368.534531] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7368.534536] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7368.705270] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 7382.831899] BTRFS info (device nvme0n1p1): checking UUID tree
[ 7384.658865] WARNING: CPU: 4 PID: 77119 at fs/btrfs/extent-tree.c:3049=
 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 7384.658901] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 7384.658999] CPU: 4 PID: 77119 Comm: btrfs-balance Tainted: P        W=
  O      5.15.79 #1-NixOS
[ 7384.659004] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 7384.659045]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 7384.659076]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 7384.659098]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 7384.659120]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 7384.659144]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 7384.659176]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 7384.659209]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 7384.659247]  balance_kthread+0x57/0xd0 [btrfs]
[ 7384.659275]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 7384.659315] BTRFS info (device nvme0n1p1): leaf 14486443556864 gen 73=
25246 total ptrs 198 free space 4502 owner 2
[ 7384.659809] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[ 7384.659815] BTRFS: Transaction aborted (error -2)
[ 7384.659821] WARNING: CPU: 4 PID: 77119 at fs/btrfs/extent-tree.c:3055=
 __btrfs_free_extent+0x730/0x920 [btrfs]
[ 7384.659843] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 7384.659903] CPU: 4 PID: 77119 Comm: btrfs-balance Tainted: P        W=
  O      5.15.79 #1-NixOS
[ 7384.659905] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[ 7384.659940]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 7384.659969]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 7384.659992]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 7384.660014]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 7384.660037]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 7384.660067]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 7384.660098]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 7384.660133]  balance_kthread+0x57/0xd0 [btrfs]
[ 7384.660160]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 7384.660195] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[ 7384.660198] BTRFS info (device nvme0n1p1): forced readonly
[ 7384.660199] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[ 7384.660208] BTRFS info (device nvme0n1p1): balance: resume -dusage=3D=
90 -musage=3D90 -susage=3D90
[ 7384.660607] BTRFS info (device nvme0n1p1): balance: ended with status=
: -30
[ 7432.758086] BTRFS error (device nvme0n1p1): Remounting read-write aft=
er error is not allowed
[ 7448.669519] BTRFS error (device nvme0n1p1): Remounting read-write aft=
er error is not allowed
[ 7469.156263] BTRFS info (device nvme0n1p1): allowing degraded mounts
[ 7469.156267] BTRFS info (device nvme0n1p1): using free space tree
[ 7469.156269] BTRFS info (device nvme0n1p1): has skinny extents
[ 7469.160103] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7469.160109] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7469.331166] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[ 7483.432409] BTRFS info (device nvme0n1p1): checking UUID tree
[ 7485.366186] WARNING: CPU: 18 PID: 77272 at fs/btrfs/extent-tree.c:304=
9 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 7485.366216] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 7485.366306] CPU: 18 PID: 77272 Comm: btrfs-balance Tainted: P        =
W  O      5.15.79 #1-NixOS
[ 7485.366310] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[ 7485.366348]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 7485.366378]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 7485.366400]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 7485.366421]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 7485.366451]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 7485.366482]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 7485.366513]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 7485.366553]  balance_kthread+0x57/0xd0 [btrfs]
[ 7485.366582]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 7485.366623] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25248 total ptrs 198 free space 4502 owner 2
[ 7485.367158] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[ 7485.367162] BTRFS: Transaction aborted (error -2)
[ 7485.367168] WARNING: CPU: 18 PID: 77272 at fs/btrfs/extent-tree.c:305=
5 __btrfs_free_extent+0x730/0x920 [btrfs]
[ 7485.367190] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[ 7485.367248] CPU: 18 PID: 77272 Comm: btrfs-balance Tainted: P        =
W  O      5.15.79 #1-NixOS
[ 7485.367250] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[ 7485.367283]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[ 7485.367312]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[ 7485.367334]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 7485.367355]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[ 7485.367379]  ? insert_balance_item.isra.0+0xa5/0x350 [btrfs]
[ 7485.367407]  insert_balance_item.isra.0+0xad/0x350 [btrfs]
[ 7485.367441]  btrfs_balance+0x32d/0xea0 [btrfs]
[ 7485.367475]  balance_kthread+0x57/0xd0 [btrfs]
[ 7485.367502]  ? btrfs_balance+0xea0/0xea0 [btrfs]
[ 7485.367536] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[ 7485.367538] BTRFS info (device nvme0n1p1): forced readonly
[ 7485.367540] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[ 7485.367548] BTRFS info (device nvme0n1p1): balance: resume -dusage=3D=
90 -musage=3D90 -susage=3D90
[ 7485.367868] BTRFS info (device nvme0n1p1): balance: ended with status=
: -30
[ 7837.132665] BTRFS info (device nvme0n1p1): using free space tree
[ 7837.132668] BTRFS info (device nvme0n1p1): has skinny extents
[ 7837.136505] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7837.136510] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[ 7837.308294] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99188.612011] BTRFS info (device nvme0n1p1): using free space tree
[99188.612015] BTRFS info (device nvme0n1p1): has skinny extents
[99188.615964] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99188.615968] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99188.789761] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99203.570863] BTRFS info (device nvme0n1p1): balance: resume skipped
[99203.570869] BTRFS info (device nvme0n1p1): checking UUID tree
[99221.170407] WARNING: CPU: 17 PID: 4104773 at fs/btrfs/extent-tree.c:3=
049 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99221.170444] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99221.170540] CPU: 17 PID: 4104773 Comm: btrfs-transacti Tainted: P    =
    W  O      5.15.79 #1-NixOS
[99221.170545] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99221.170587]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99221.170617]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99221.170640]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99221.170662]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99221.170686]  ? start_transaction+0xce/0x5a0 [btrfs]
[99221.170713]  transaction_kthread+0x12f/0x1a0 [btrfs]
[99221.170736]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
[99221.170773] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25250 total ptrs 198 free space 4502 owner 2
[99221.171270] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99221.171275] BTRFS: Transaction aborted (error -2)
[99221.171281] WARNING: CPU: 17 PID: 4104773 at fs/btrfs/extent-tree.c:3=
055 __btrfs_free_extent+0x730/0x920 [btrfs]
[99221.171303] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99221.171363] CPU: 17 PID: 4104773 Comm: btrfs-transacti Tainted: P    =
    W  O      5.15.79 #1-NixOS
[99221.171365] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99221.171399]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99221.171429]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99221.171451]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99221.171473]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99221.171497]  ? start_transaction+0xce/0x5a0 [btrfs]
[99221.171521]  transaction_kthread+0x12f/0x1a0 [btrfs]
[99221.171544]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
[99221.171576] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99221.171578] BTRFS info (device nvme0n1p1): forced readonly
[99221.171580] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99310.873180] BTRFS info (device nvme0n1p1): using free space tree
[99310.873186] BTRFS info (device nvme0n1p1): has skinny extents
[99310.876848] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99310.876853] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99311.041770] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99326.163422] BTRFS info (device nvme0n1p1): balance: resume skipped
[99326.163431] BTRFS info (device nvme0n1p1): checking UUID tree
[99330.789087] WARNING: CPU: 22 PID: 4104901 at fs/btrfs/extent-tree.c:3=
049 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99330.789117] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99330.789206] CPU: 22 PID: 4104901 Comm: btrfs Tainted: P        W  O  =
    5.15.79 #1-NixOS
[99330.789209] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99330.789248]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99330.789278]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99330.789300]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99330.789321]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99330.789348]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99330.789371]  ? reset_balance_state+0x125/0x180 [btrfs]
[99330.789401]  reset_balance_state+0x12d/0x180 [btrfs]
[99330.789428]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99330.789461]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99330.789519] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25252 total ptrs 198 free space 4502 owner 2
[99330.790023] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99330.790026] BTRFS: Transaction aborted (error -2)
[99330.790032] WARNING: CPU: 22 PID: 4104901 at fs/btrfs/extent-tree.c:3=
055 __btrfs_free_extent+0x730/0x920 [btrfs]
[99330.790054] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99330.790114] CPU: 22 PID: 4104901 Comm: btrfs Tainted: P        W  O  =
    5.15.79 #1-NixOS
[99330.790117] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99330.790150]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99330.790179]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99330.790201]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99330.790222]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99330.790249]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99330.790272]  ? reset_balance_state+0x125/0x180 [btrfs]
[99330.790301]  reset_balance_state+0x12d/0x180 [btrfs]
[99330.790328]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99330.790359]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99330.790410] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99330.790412] BTRFS info (device nvme0n1p1): forced readonly
[99330.790414] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99330.790418] BTRFS: error (device nvme0n1p1) in reset_balance_state:35=
65: errno=3D-2 No such entry
[99330.790425] BTRFS info (device nvme0n1p1): balance: canceled
[99375.776359] BTRFS info (device nvme0n1p1): using free space tree
[99375.776363] BTRFS info (device nvme0n1p1): has skinny extents
[99375.780229] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99375.780235] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99375.950189] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99390.446542] BTRFS info (device nvme0n1p1): balance: resume skipped
[99390.446548] BTRFS info (device nvme0n1p1): checking UUID tree
[99392.275022] WARNING: CPU: 9 PID: 4104963 at fs/btrfs/extent-tree.c:30=
49 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99392.275055] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99392.275144] CPU: 9 PID: 4104963 Comm: btrfs Tainted: P        W  O   =
   5.15.79 #1-NixOS
[99392.275148] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99392.275188]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99392.275218]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99392.275240]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99392.275262]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99392.275289]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99392.275313]  ? reset_balance_state+0x125/0x180 [btrfs]
[99392.275343]  reset_balance_state+0x12d/0x180 [btrfs]
[99392.275370]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99392.275403]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99392.275461] BTRFS info (device nvme0n1p1): leaf 14486438248448 gen 73=
25254 total ptrs 198 free space 4502 owner 2
[99392.275956] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99392.275961] BTRFS: Transaction aborted (error -2)
[99392.275966] WARNING: CPU: 9 PID: 4104963 at fs/btrfs/extent-tree.c:30=
55 __btrfs_free_extent+0x730/0x920 [btrfs]
[99392.275988] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99392.276049] CPU: 9 PID: 4104963 Comm: btrfs Tainted: P        W  O   =
   5.15.79 #1-NixOS
[99392.276051] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99392.276084]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99392.276114]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99392.276136]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99392.276157]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99392.276184]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99392.276207]  ? reset_balance_state+0x125/0x180 [btrfs]
[99392.276237]  reset_balance_state+0x12d/0x180 [btrfs]
[99392.276264]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99392.276294]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99392.276346] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99392.276348] BTRFS info (device nvme0n1p1): forced readonly
[99392.276350] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99392.276354] BTRFS: error (device nvme0n1p1) in reset_balance_state:35=
65: errno=3D-2 No such entry
[99392.276361] BTRFS info (device nvme0n1p1): balance: canceled
[99424.693575] BTRFS info (device nvme0n1p1): allowing degraded mounts
[99424.693580] BTRFS info (device nvme0n1p1): using free space tree
[99424.693582] BTRFS info (device nvme0n1p1): has skinny extents
[99424.697261] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99424.697266] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99424.859872] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99439.915409] BTRFS info (device nvme0n1p1): balance: resume skipped
[99439.915418] BTRFS info (device nvme0n1p1): checking UUID tree
[99457.041944] WARNING: CPU: 0 PID: 4105017 at fs/btrfs/extent-tree.c:30=
49 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99457.041986] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99457.042084] CPU: 0 PID: 4105017 Comm: btrfs-transacti Tainted: P     =
   W  O      5.15.79 #1-NixOS
[99457.042088] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99457.042131]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99457.042161]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99457.042183]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99457.042204]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99457.042228]  ? start_transaction+0xce/0x5a0 [btrfs]
[99457.042255]  transaction_kthread+0x12f/0x1a0 [btrfs]
[99457.042277]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
[99457.042314] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25256 total ptrs 198 free space 4502 owner 2
[99457.042801] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99457.042805] BTRFS: Transaction aborted (error -2)
[99457.042811] WARNING: CPU: 0 PID: 4105017 at fs/btrfs/extent-tree.c:30=
55 __btrfs_free_extent+0x730/0x920 [btrfs]
[99457.042832] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99457.042890] CPU: 0 PID: 4105017 Comm: btrfs-transacti Tainted: P     =
   W  O      5.15.79 #1-NixOS
[99457.042892] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99457.042924]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99457.042953]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99457.042977]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99457.042998]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99457.043021]  ? start_transaction+0xce/0x5a0 [btrfs]
[99457.043047]  transaction_kthread+0x12f/0x1a0 [btrfs]
[99457.043072]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
[99457.043106] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99457.043108] BTRFS info (device nvme0n1p1): forced readonly
[99457.043110] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99496.189165] BTRFS info (device nvme0n1p1): allowing degraded mounts
[99496.189169] BTRFS info (device nvme0n1p1): using free space tree
[99496.189170] BTRFS info (device nvme0n1p1): has skinny extents
[99496.193449] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99496.193455] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99496.356802] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99510.821187] BTRFS info (device nvme0n1p1): balance: resume skipped
[99510.821193] BTRFS info (device nvme0n1p1): checking UUID tree
[99512.652632] WARNING: CPU: 9 PID: 4105090 at fs/btrfs/extent-tree.c:30=
49 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99512.652664] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99512.652755] CPU: 9 PID: 4105090 Comm: btrfs Tainted: P        W  O   =
   5.15.79 #1-NixOS
[99512.652759] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99512.652799]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99512.652828]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99512.652851]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99512.652872]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99512.652898]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99512.652922]  ? reset_balance_state+0x125/0x180 [btrfs]
[99512.652952]  reset_balance_state+0x12d/0x180 [btrfs]
[99512.652979]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99512.653012]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99512.653070] BTRFS info (device nvme0n1p1): leaf 14486438248448 gen 73=
25258 total ptrs 198 free space 4502 owner 2
[99512.653559] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99512.653562] BTRFS: Transaction aborted (error -2)
[99512.653568] WARNING: CPU: 9 PID: 4105090 at fs/btrfs/extent-tree.c:30=
55 __btrfs_free_extent+0x730/0x920 [btrfs]
[99512.653590] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99512.653650] CPU: 9 PID: 4105090 Comm: btrfs Tainted: P        W  O   =
   5.15.79 #1-NixOS
[99512.653652] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99512.653685]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99512.653714]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99512.653737]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99512.653758]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99512.653784]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99512.653808]  ? reset_balance_state+0x125/0x180 [btrfs]
[99512.653836]  reset_balance_state+0x12d/0x180 [btrfs]
[99512.653864]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99512.653894]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99512.653945] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99512.653947] BTRFS info (device nvme0n1p1): forced readonly
[99512.653949] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99512.653953] BTRFS: error (device nvme0n1p1) in reset_balance_state:35=
65: errno=3D-2 No such entry
[99512.653959] BTRFS info (device nvme0n1p1): balance: canceled
[99537.328530] BTRFS info (device nvme0n1p1): allowing degraded mounts
[99537.328534] BTRFS info (device nvme0n1p1): using free space tree
[99537.328535] BTRFS info (device nvme0n1p1): has skinny extents
[99537.333018] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99537.333023] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: =
wr 0, rd 0, flush 0, corrupt 12, gen 0
[99537.496474] BTRFS info (device nvme0n1p1): enabling ssd optimizations
[99552.082294] BTRFS info (device nvme0n1p1): balance: resume skipped
[99552.082300] BTRFS info (device nvme0n1p1): checking UUID tree
[99553.920087] WARNING: CPU: 23 PID: 4105149 at fs/btrfs/extent-tree.c:3=
049 __btrfs_free_extent+0x6d5/0x920 [btrfs]
[99553.920120] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99553.920210] CPU: 23 PID: 4105149 Comm: btrfs Tainted: P        W  O  =
    5.15.79 #1-NixOS
[99553.920214] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
[99553.920253]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99553.920282]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99553.920305]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99553.920326]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99553.920352]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99553.920376]  ? reset_balance_state+0x125/0x180 [btrfs]
[99553.920406]  reset_balance_state+0x12d/0x180 [btrfs]
[99553.920433]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99553.920466]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99553.920524] BTRFS info (device nvme0n1p1): leaf 14486441181184 gen 73=
25260 total ptrs 198 free space 4502 owner 2
[99553.921003] BTRFS error (device nvme0n1p1): unable to find ref byte n=
r 15353727729664 parent 14660022714368 root 18446744073709551608  owner =
0 offset 0
[99553.921007] BTRFS: Transaction aborted (error -2)
[99553.921012] WARNING: CPU: 23 PID: 4105149 at fs/btrfs/extent-tree.c:3=
055 __btrfs_free_extent+0x730/0x920 [btrfs]
[99553.921034] Modules linked in: qrtr ns af_packet intel_rapl_msr rt280=
0usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb i=
ntel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 b=
trfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda_=
codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc b=
lake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu =
irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspcf=
g drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_inte=
l tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyare=
a snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_p=
q cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class =
rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog t=
pm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i2=
c_designware_platform gpio_generic i2c_designware_core wmi button
[99553.921089] CPU: 23 PID: 4105149 Comm: btrfs Tainted: P        W  O  =
    5.15.79 #1-NixOS
[99553.921092] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
[99553.921124]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
[99553.921153]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
[99553.921175]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[99553.921196]  ? set_extent_buffer_dirty+0x15/0x110 [btrfs]
[99553.921222]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
[99553.921245]  ? reset_balance_state+0x125/0x180 [btrfs]
[99553.921274]  reset_balance_state+0x12d/0x180 [btrfs]
[99553.921301]  btrfs_cancel_balance+0x14d/0x170 [btrfs]
[99553.921331]  btrfs_ioctl+0x1240/0x2e20 [btrfs]
[99553.921383] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:30=
55: errno=3D-2 No such entry
[99553.921385] BTRFS info (device nvme0n1p1): forced readonly
[99553.921386] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs=
:2149: errno=3D-2 No such entry
[99553.921390] BTRFS: error (device nvme0n1p1) in reset_balance_state:35=
65: errno=3D-2 No such entry
[99553.921397] BTRFS info (device nvme0n1p1): balance: canceled
[102233.972542] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102233.972664] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102234.956259] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102234.956389] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102235.777749] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102235.777873] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102236.577173] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102236.577293] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102237.390509] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[102237.390631] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[150281.382467] WARNING: CPU: 12 PID: 171 at fs/btrfs/inode.c:9270 btrfs=
_destroy_inode+0x1d1/0x240 [btrfs]
[150281.382525] Modules linked in: qrtr ns af_packet intel_rapl_msr rt28=
00usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb =
intel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 =
btrfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda=
_codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc =
blake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu=
 irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspc=
fg drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_int=
el tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyar=
ea snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_=
pq cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class=
 rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog =
tpm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i=
2c_designware_platform gpio_generic i2c_designware_core wmi button
[150281.382667] RIP: 0010:btrfs_destroy_inode+0x1d1/0x240 [btrfs]
[150281.382851] WARNING: CPU: 12 PID: 171 at fs/btrfs/inode.c:9271 btrfs=
_destroy_inode+0x1e1/0x240 [btrfs]
[150281.382898] Modules linked in: qrtr ns af_packet intel_rapl_msr rt28=
00usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb =
intel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 =
btrfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda=
_codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc =
blake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu=
 irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspc=
fg drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_int=
el tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyar=
ea snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_=
pq cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class=
 rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog =
tpm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i=
2c_designware_platform gpio_generic i2c_designware_core wmi button
[150281.382994] RIP: 0010:btrfs_destroy_inode+0x1e1/0x240 [btrfs]
[151785.007074] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.007750] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.083823] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.083957] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.100995] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.101127] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.101279] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.101382] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.101480] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151785.101584] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.152583] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.152715] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.182147] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.182276] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.182563] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.182666] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.279374] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.279511] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.279659] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151795.279762] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.119113] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.119236] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.188279] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.188419] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.204928] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.205068] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.205229] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.205334] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.205430] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151805.205535] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151809.019631] Modules linked in: qrtr ns af_packet intel_rapl_msr rt28=
00usb rt2x00usb edac_mce_amd rt2800lib edac_core iwlmvm rt2x00lib btusb =
intel_rapl_common wmi_bmof btrtl mac80211 btbcm btintel nouveau libarc4 =
btrfs bluetooth kvm_amd mousedev joydev evdev mxm_wmi input_leds snd_hda=
_codec_realtek ecdh_generic iwlwifi video kvm snd_hda_codec_generic ecc =
blake2b_generic mac_hid ledtrig_audio snd_hda_codec_hdmi xor corsair_psu=
 irqbypass snd_hda_intel crc32_pclmul crc16 zstd_compress snd_intel_dspc=
fg drm_ttm_helper ttm snd_intel_sdw_acpi snd_hda_codec ghash_clmulni_int=
el tpm_crb tpm_tis drm_kms_helper igb snd_hda_core fb_sys_fops syscopyar=
ea snd_hwdep aesni_intel snd_pcm crypto_simd sysfillrect cfg80211 raid6_=
pq cryptd snd_timer ptp libaes tpm_tis_core sysimgblt pps_core led_class=
 rapl sp5100_tco snd deflate rfkill dca soundcore i2c_algo_bit watchdog =
tpm efi_pstore tiny_power_button k10temp gpio_amdpt rng_core i2c_piix4 i=
2c_designware_platform gpio_generic i2c_designware_core wmi button
[151816.019150] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.019289] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.054511] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.054655] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.054973] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.055085] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.201283] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.201430] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.201560] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151816.201671] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.529856] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.529975] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.597990] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.598122] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.617403] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.617563] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.617776] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.617885] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.617988] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151825.618090] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.831664] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.831803] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.863279] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.863426] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.863756] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.863861] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.969833] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.969962] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.970139] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151835.970269] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.315044] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.315195] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.386292] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.386434] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403063] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403222] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403386] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403501] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403603] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151846.403716] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.093527] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.093669] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.126010] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.126158] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.126476] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.126595] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.236921] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.237070] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.237288] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151857.237448] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.753431] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.753559] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.827232] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.827378] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.845442] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.845585] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.845784] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.845901] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.846015] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151867.846128] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.484454] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.484595] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.518942] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.519077] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.519401] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.519508] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.622506] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.622651] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.622784] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151878.622888] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.481658] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.481805] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.559034] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.559167] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.576580] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.576704] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.576856] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.576961] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.577057] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151888.577161] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.303621] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.303759] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.333722] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.333847] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.334195] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.334303] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.448793] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268672 wanted 7325260 found 7325246
[151899.448938] BTRFS error (device nvme0n1p1): parent transid verify fa=
iled on 14484042268
