Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050A2285DB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgJGK6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 06:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgJGK6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 06:58:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97764C061755
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Oct 2020 03:58:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so2152214qkf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Oct 2020 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=l5T4nazXopg+wW0kIuXkopcRpg/NGm7Jm76YI5d2jxk=;
        b=PJIyEoqr8u7ihHvLmoC+nwikVRgOUhThxdbtbNBEDB+O5qGErv0cQKPde5KIOoD5pi
         59xWm5ZQlSJiW9aajxOmXRY6OrO3j5He+XsvYW2jLqpE8v61fc9/gCwEi5FZpvTpKy7A
         qviMsX4s3hUSJclvEImVy7JpMm3wm7tp0e6KmQKfhBroV7+RtphHevMwYim0DpFdAcHu
         rNWrLs08HK7tew+KL+KWjKB5rIOxkezuO6qgieVlfbEwGaGy3+rb1u9IY0e8TuQeTA9H
         frwQDjRSA4lrCCxQajfl3Kac0jCc2L+zRllfTEDouCrYC/YTmFHmxChW1Je9zGPHHZAq
         +W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l5T4nazXopg+wW0kIuXkopcRpg/NGm7Jm76YI5d2jxk=;
        b=V0kp3soGfITwGLWd2QE9uK4VcPzVI3uJ+wOyKGABG4UeO3X2H4grnWQGt47K6Rx9N3
         UqKl9H3FoJ2OB/2cYEB5hIowUl83+8QBDZ65YN3YLa5cOz8iUVxqZ38mGYoM+PPpDpWx
         5gO2+uNpktcWSButl0E7sUI29vIz3cC1BzJCqeKI3c6JwHo4eaFlfVvdW+6hfdt8WLvp
         GYZalagg0DGtZdrrM4/ilaES9SlWbvaAO8tcSrA08WHbPxmWwrqZBMpoRKlNi6xZ4kfd
         GLfwN1XyFtKL/MgWOdQPD5x27vEtXk+nfXoId9rwwJxqP2lpK04/iPInRFArNCuzTjXd
         iH8w==
X-Gm-Message-State: AOAM530tUS7drhfjwaqebwLGKb8nXH4gQgJnBtLw7pcDWbl28uczAKMy
        XavYHgaU206jMfbAh9BAGWtBky/bg3qb8w==
X-Google-Smtp-Source: ABdhPJwWskIQnSE303DpvWxVhJiryw0JAkfnsWrRu9RQucUNzeSHihAJFsonXLy5R3kePeMxhp9K3A==
X-Received: by 2002:ae9:dcc7:: with SMTP id q190mr2097627qkf.448.1602068331226;
        Wed, 07 Oct 2020 03:58:51 -0700 (PDT)
Received: from [192.168.1.249] (user-69-1-51-100.knology.net. [69.1.51.100])
        by smtp.gmail.com with ESMTPSA id r190sm1086649qkf.101.2020.10.07.03.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:58:50 -0700 (PDT)
Subject: Re: Counts for qgroup id are different
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        BTRFS Kernel <linux-btrfs@vger.kernel.org>
References: <8547cc42-6768-d6f0-6336-fac1fc42b85d@gmail.com>
 <9ded0048-a480-8873-899d-576210490606@gmx.com>
From:   JMinson <minsonj2016@gmail.com>
Message-ID: <91df37d7-d173-f264-6a2b-22649b0f7e68@gmail.com>
Date:   Wed, 7 Oct 2020 06:58:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9ded0048-a480-8873-899d-576210490606@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good News / Bad News

The good news is that btrfs quota rescan /Daily cleared the Counts for 
qgroup id are different error .

The bad news is that during the rescan these errors are being generated:


Oct  7 06:25:27 linux-desktop kernel: [ 4001.145760] ------------[ cut 
here ]------------
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145766] WARNING: CPU: 4 
PID: 4850 at fs/fs-writeback.c:2466 __writeback_inodes_sb_nr+0xbf/0xd0
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145766] Modules linked in: 
ccm rfcomm cmac algif_hash algif_skcipher af_alg bnep 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec 
snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event 
nls_iso8859_1 snd_rawmidi snd_seq iwlmvm snd_seq_device edac_mce_amd 
mac80211 kvm_amd ccp snd_timer libarc4 kvm eeepc_wmi iwlwifi asus_wmi 
sparse_keymap wmi_bmof btusb snd k10temp cfg80211 btrtl btbcm btintel 
joydev soundcore input_leds bluetooth ecdh_generic ecc mac_hid 
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 
btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy 
async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath 
linear hid_logitech_hidpp uas usb_storage hid_logitech_dj hid_generic 
usbhid hid amdgpu crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
amd_iommu_v2 gpu_sched aesni_intel i2c_algo_bit ttm crypto_simd 
drm_kms_helper cryptd glue_helper syscopyarea
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145791]  sysfillrect 
sysimgblt nvme fb_sys_fops i2c_piix4 drm nvme_core ahci libahci wmi 
video gpio_amdpt gpio_generic
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145796] CPU: 4 PID: 4850 
Comm: btrfs-transacti Tainted: G        W 5.4.0-48-generic #52-Ubuntu
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145797] Hardware name: 
System manufacturer System Product Name/PRIME B450M-A, BIOS 2202 07/14/2020
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145799] RIP: 
0010:__writeback_inodes_sb_nr+0xbf/0xd0
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145800] Code: b6 d1 48 8d 
75 b0 e8 80 fc ff ff 4c 89 e7 e8 e8 fb ff ff 48 8b 45 f0 65 48 33 04 25 
28 00 00 00 75 0c 48 83 c4 58 41 5c 5d c3 <0f> 0b eb ce e8 48 c4 d8 ff 
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145800] RSP: 
0018:ffffb9ac82a5fdb0 EFLAGS: 00010246
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145801] RAX: 
0000000000000000 RBX: 0000000000000125 RCX: 0000000000000000
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145802] RDX: 
0000000000000002 RSI: 00000000000122ba RDI: ffff9a07f0396800
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145802] RBP: 
ffffb9ac82a5fe10 R08: ffff9a07f0395800 R09: ffffb9ac82a5fdd0
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145803] R10: 
0000000000000000 R11: 0000000000000000 R12: ffffb9ac82a5fdb0
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145803] R13: 
0000000000000002 R14: ffff9a0842aba800 R15: 0000000000000000
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145804] FS: 
0000000000000000(0000) GS:ffff9a0850900000(0000) knlGS:0000000000000000
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145804] CS:  0010 DS: 0000 
ES: 0000 CR0: 0000000080050033
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145805] CR2: 
00007fe990379000 CR3: 00000003fff9e000 CR4: 00000000003406e0
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145805] Call Trace:
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145808] 
writeback_inodes_sb+0x4b/0x60
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145820] 
btrfs_commit_transaction+0x2f6/0x960 [btrfs]
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145828]  ? 
start_transaction+0xb7/0x510 [btrfs]
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145830]  ? 
del_timer_sync+0x30/0x40
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145838] 
transaction_kthread+0x146/0x190 [btrfs]
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145840] kthread+0x104/0x140
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145847]  ? 
btrfs_cleanup_transaction+0x530/0x530 [btrfs]
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145848]  ? 
kthread_park+0x90/0x90
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145850] ret_from_fork+0x22/0x40
Oct  7 06:25:27 linux-desktop kernel: [ 4001.145851] ---[ end trace 
21d9e8c753568b19 ]---

On 10/6/20 8:13 PM, Qu Wenruo wrote:
>
> On 2020/10/6 下午10:27, JMinson wrote:
>> Linux linux-desktop 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49
>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>
>> btrfs-progs v5.4.1
>>
>> Label: 'Daily'  uuid: 1426edb8-4fed-419a-b0f1-d131b97224fd
>>          Total devices 1 FS bytes used 1.13TiB
>>          devid    1 size 1.82TiB used 1.14TiB path /dev/sdb
>>
>>
>> I use rsync to backup to an external btrfs formatted usb drive . The
>> process is :
>>
>>
>> mount btrfs volume "/Daily"
>>
>> take a snapshot of subvolume "BackupRoot" and give the snapshot a name
>> like "snap@BackupRoot-2020-10-05-Oct-1601938835"
>>
>> run rsync with the destination being "/Daily/BackupRoot"
>>
>> unmount the btrfs volume "/Daily"
>>
>> I've been using this procedure for about 6 months and is far as I know
>> all the data is good . However I discovered yesterday that when I run
>> btrfsck I get 1 or more of these
>>
>> Counts for qgroup id: 0/1561 are different
>> our:            referenced 1051233288192 referenced compressed
>> 1051233288192
>> disk:           referenced 1046914453504 referenced compressed
>> 1046914453504
>> diff:           referenced 4318834688 referenced compressed 4318834688
> This means btrfs qgroup on-disk is smaller than what btrfs check think is.
>
> Is there any subvolume deletion involved in this case?
> IIRC btrfs kernel and btrfs-check has different opinion on half-dropped
> subvolumes. But when the subvolume is fully dropped, then everything
> goes back into sync again.
>
>> our:            exclusive 1206681600 exclusive compressed 1206681600
>> disk:           exclusive 1206681600 exclusive compressed 1206681600
> But exclusive is correct, thus it doesn't look like regular qgroup error.
>
>>
>> Is this something to be concerned about ?
> Normally you don't need to be concerned.
>
> If you really don't like this, you can just trigger a qgroup rescan and
> it will be handled well.
>
> Another thing is, if you're running btrfs check with --force, on running
> fs, it could give false alert.
>
> Thanks,
> Qu
>
