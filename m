Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60D2E9A4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbhADQIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 11:08:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:56494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbhADQBy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 11:01:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51815ACAF;
        Mon,  4 Jan 2021 16:01:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E501FDA882; Mon,  4 Jan 2021 16:59:23 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:59:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: tree-checker: check if chunk item end
 oveflows
Message-ID: <20210104155923.GI6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210103092804.756-1-l@damenly.su>
 <20210103092804.756-3-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103092804.756-3-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 03, 2021 at 05:28:04PM +0800, Su Yue wrote:
> while mounting the poc image user-provided, kernel panics due to the
> invalid chunk item whose end is less than start.
> ========================================================================
> [   66.387422] loop: module loaded
> [   66.389773] loop0: detected capacity change from 262144 to 0
> [   66.427708] BTRFS: device fsid a62e00e8-e94e-4200-8217-12444de93c2e devid 1 transid 12 /dev/loop0 scanned by mount (613)
> [   66.431061] BTRFS info (device loop0): disk space caching is enabled
> [   66.431078] BTRFS info (device loop0): has skinny extents
> [   66.437101] BTRFS error: insert state: end < start 29360127 37748736
> [   66.437136] ------------[ cut here ]------------
> [   66.437140] WARNING: CPU: 16 PID: 613 at fs/btrfs/extent_io.c:557 insert_state.cold+0x1a/0x46 [btrfs]
> [   66.437193] Modules linked in: loop btrfs(O) blake2b_generic xor zstd_compress nls_iso8859_1 nls_cp437 vfat fat raid6_pq joydev mousedev crct10dif_pclmul psmouse crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel glue_helper crypto_simd cryptd pcspkr rtc_cmos evdev intel_agp intel_gtt qemu_fw_cfg drm agpgart ip_tables x_tables xfs virtio_balloon virtio_console virtio_net net_failover failover dm_mod sd_mod hid_generic usbhid hid uhci_hcd serio_raw atkbd libps2 ahci libahci ehci_pci ehci_hcd libata usbcore scsi_mod virtio_pci virtio_ring usb_common virtio i8042 serio

The Modules line

> [   66.437369] CPU: 16 PID: 613 Comm: mount Tainted: G           O      5.11.0-rc1-custom #45
> [   66.437374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.14.0-1 04/01/2014
> [   66.437378] RIP: 0010:insert_state.cold+0x1a/0x46 [btrfs]
> [   66.437416] Code: 39 01 00 00 48 c7 c7 85 38 9e c0 e8 3c fd ff ff 48 8b 7f 08 48 89 d1 48 89 da 4c 89 45 d0 48 c7 c6 20 b0 9e c0 e8 49 97 ff ff <0f> 0b 4c 8b 45 d0 e9 ff 28 f7 ff 49 8b 7d 08 49 89 d9 4d 89 f8 41

and Code: are usually quite long and not necessary for understanding the
report, so please leave them out in future reports. Thanks.
