Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA285F51
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgJGMi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgJGMi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 08:38:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9FC061755
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Oct 2020 05:38:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h12so57294qtu.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Oct 2020 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=RlupcIKUnugicCcvnf7Fz6tnQNmFhuWAnu29Kl6KHpo=;
        b=Wu+6KHSdnGry2fsWe6vhvOkTbve7vxGA1+aG+XiLifnacJ5GXvJBy7Xf3EVOzRjdDC
         wwqShIl8jQCQ/8SDARm0iRODQKAnaWtdjGfN9bEOcKB8C1cQ7y08mC8seZeXIbSeN9fW
         1HKjEw7gBguCVSu8DB+5hs7KSub/fFJ2CIUSXMR6kmndNhRrUtJxfP57SMWUiCNIZc/9
         EjfmeSDJUJWtFYqVsa55cD4hCDX6gHXJRxm5sGhS8FFv9njoalNzi/ibYyPwnOA47yS6
         frfgJngBAPUK0Ymw6wMsStN1dPJlCuD2dbmYX3UQERexpBKZmeAxY0YriU662qpNOaCu
         D/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RlupcIKUnugicCcvnf7Fz6tnQNmFhuWAnu29Kl6KHpo=;
        b=Bex5G9UftEIOjg1htUhbvUtkBGGkTmYrSBsfus9GRW9R74jPO8Bij5Xl3URh6mc2L1
         0KG8qVBK7fLNV0VyOMNjndmZ83fv2dWEP9NceJK1Qg+AAntQbEUnJFOrM0Rr8mqYcKSi
         7rAWPVc1T6Awyy57xhd4V7fla0t3j5Y5Nwcmi/ZiYqtwG3wRCrG060z6aaEMV78o6z5J
         lT55J/jUMjhsky/BlEHTFuN2mfsJagBBC77IjP6KYhrpUfPyLEodv+h06bIJaB1qD9Dq
         T0Hwiy7Wi61tt+xUoThfIKBBVGRb4j7hwVq9cGl2xZs6oZiBlLU2K/uOTrHNqq4m5kKY
         8EYQ==
X-Gm-Message-State: AOAM531AKqML4F0gHtPBJiMvneIbe8Bn68uNEZfkdDyq0ug84NPdtb2e
        9qG6Xy1Pup8aGURvI+L2jINAILJbGs6Ljg==
X-Google-Smtp-Source: ABdhPJwNGygIvIRvu6XCx73eXvrOnHdoaCq+Pkh0wCov6Sf1G7+UP80Go510KaDd0IDv5Nsz34F1Zg==
X-Received: by 2002:ac8:1005:: with SMTP id z5mr2966278qti.130.1602074337884;
        Wed, 07 Oct 2020 05:38:57 -0700 (PDT)
Received: from [192.168.1.249] (user-69-1-51-100.knology.net. [69.1.51.100])
        by smtp.gmail.com with ESMTPSA id m15sm269586qtc.90.2020.10.07.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 05:38:56 -0700 (PDT)
Subject: Re: Counts for qgroup id are different
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        BTRFS Kernel <linux-btrfs@vger.kernel.org>
References: <8547cc42-6768-d6f0-6336-fac1fc42b85d@gmail.com>
 <9ded0048-a480-8873-899d-576210490606@gmx.com>
 <91df37d7-d173-f264-6a2b-22649b0f7e68@gmail.com>
 <c7e12280-0a86-6677-2cf9-de32bf68b07d@gmx.com>
From:   JMinson <minsonj2016@gmail.com>
Message-ID: <de10f971-54f0-c3de-f7fe-41d7df33c4f6@gmail.com>
Date:   Wed, 7 Oct 2020 08:38:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c7e12280-0a86-6677-2cf9-de32bf68b07d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

rsync'ing to external usb drive daily as described below

On 10/7/20 7:14 AM, Qu Wenruo wrote:
>
> On 2020/10/7 下午6:58, JMinson wrote:
>> Good News / Bad News
>>
>> The good news is that btrfs quota rescan /Daily cleared the Counts for
>> qgroup id are different error .
>>
>> The bad news is that during the rescan these errors are being generated:
>>
>>
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145760] ------------[ cut
>> here ]------------
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145766] WARNING: CPU: 4
>> PID: 4850 at fs/fs-writeback.c:2466 __writeback_inodes_sb_nr+0xbf/0xd0
> This is completely unrelated to qgroup then.
>
> According to the code, it looks like some lock schema problem.
> At least for the qgroup part it should be fine now.
>
> For the new part, unless you're a developer, you can just ignore it.
> Or could you provide the workload for us to reproduce?
> Just your regular backup workload?
>
> Thanks,
> Qu
>
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145766] Modules linked in:
>> ccm rfcomm cmac algif_hash algif_skcipher af_alg bnep
>> snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
>> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec
>> snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event
>> nls_iso8859_1 snd_rawmidi snd_seq iwlmvm snd_seq_device edac_mce_amd
>> mac80211 kvm_amd ccp snd_timer libarc4 kvm eeepc_wmi iwlwifi asus_wmi
>> sparse_keymap wmi_bmof btusb snd k10temp cfg80211 btrtl btbcm btintel
>> joydev soundcore input_leds bluetooth ecdh_generic ecc mac_hid
>> sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4
>> btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy
>> async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath
>> linear hid_logitech_hidpp uas usb_storage hid_logitech_dj hid_generic
>> usbhid hid amdgpu crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
>> amd_iommu_v2 gpu_sched aesni_intel i2c_algo_bit ttm crypto_simd
>> drm_kms_helper cryptd glue_helper syscopyarea
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145791]  sysfillrect
>> sysimgblt nvme fb_sys_fops i2c_piix4 drm nvme_core ahci libahci wmi
>> video gpio_amdpt gpio_generic
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145796] CPU: 4 PID: 4850
>> Comm: btrfs-transacti Tainted: G        W 5.4.0-48-generic #52-Ubuntu
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145797] Hardware name:
>> System manufacturer System Product Name/PRIME B450M-A, BIOS 2202 07/14/2020
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145799] RIP:
>> 0010:__writeback_inodes_sb_nr+0xbf/0xd0
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145800] Code: b6 d1 48 8d
>> 75 b0 e8 80 fc ff ff 4c 89 e7 e8 e8 fb ff ff 48 8b 45 f0 65 48 33 04 25
>> 28 00 00 00 75 0c 48 83 c4 58 41 5c 5d c3 <0f> 0b eb ce e8 48 c4 d8 ff
>> 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145800] RSP:
>> 0018:ffffb9ac82a5fdb0 EFLAGS: 00010246
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145801] RAX:
>> 0000000000000000 RBX: 0000000000000125 RCX: 0000000000000000
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145802] RDX:
>> 0000000000000002 RSI: 00000000000122ba RDI: ffff9a07f0396800
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145802] RBP:
>> ffffb9ac82a5fe10 R08: ffff9a07f0395800 R09: ffffb9ac82a5fdd0
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145803] R10:
>> 0000000000000000 R11: 0000000000000000 R12: ffffb9ac82a5fdb0
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145803] R13:
>> 0000000000000002 R14: ffff9a0842aba800 R15: 0000000000000000
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145804] FS:
>> 0000000000000000(0000) GS:ffff9a0850900000(0000) knlGS:0000000000000000
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145804] CS:  0010 DS: 0000
>> ES: 0000 CR0: 0000000080050033
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145805] CR2:
>> 00007fe990379000 CR3: 00000003fff9e000 CR4: 00000000003406e0
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145805] Call Trace:
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145808]
>> writeback_inodes_sb+0x4b/0x60
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145820]
>> btrfs_commit_transaction+0x2f6/0x960 [btrfs]
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145828]  ?
>> start_transaction+0xb7/0x510 [btrfs]
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145830]  ?
>> del_timer_sync+0x30/0x40
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145838]
>> transaction_kthread+0x146/0x190 [btrfs]
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145840] kthread+0x104/0x140
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145847]  ?
>> btrfs_cleanup_transaction+0x530/0x530 [btrfs]
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145848]  ?
>> kthread_park+0x90/0x90
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145850]
>> ret_from_fork+0x22/0x40
>> Oct  7 06:25:27 linux-desktop kernel: [ 4001.145851] ---[ end trace
>> 21d9e8c753568b19 ]---
>>
>> On 10/6/20 8:13 PM, Qu Wenruo wrote:
>>> On 2020/10/6 下午10:27, JMinson wrote:
>>>> Linux linux-desktop 5.4.0-48-generic #52-Ubuntu SMP Thu Sep 10 10:58:49
>>>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> btrfs-progs v5.4.1
>>>>
>>>> Label: 'Daily'  uuid: 1426edb8-4fed-419a-b0f1-d131b97224fd
>>>>           Total devices 1 FS bytes used 1.13TiB
>>>>           devid    1 size 1.82TiB used 1.14TiB path /dev/sdb
>>>>
>>>>
>>>> I use rsync to backup to an external btrfs formatted usb drive . The
>>>> process is :
>>>>
>>>>
>>>> mount btrfs volume "/Daily"
>>>>
>>>> take a snapshot of subvolume "BackupRoot" and give the snapshot a name
>>>> like "snap@BackupRoot-2020-10-05-Oct-1601938835"
>>>>
>>>> run rsync with the destination being "/Daily/BackupRoot"
>>>>
>>>> unmount the btrfs volume "/Daily"
>>>>
>>>> I've been using this procedure for about 6 months and is far as I know
>>>> all the data is good . However I discovered yesterday that when I run
>>>> btrfsck I get 1 or more of these
>>>>
>>>> Counts for qgroup id: 0/1561 are different
>>>> our:            referenced 1051233288192 referenced compressed
>>>> 1051233288192
>>>> disk:           referenced 1046914453504 referenced compressed
>>>> 1046914453504
>>>> diff:           referenced 4318834688 referenced compressed 4318834688
>>> This means btrfs qgroup on-disk is smaller than what btrfs check think
>>> is.
>>>
>>> Is there any subvolume deletion involved in this case?
>>> IIRC btrfs kernel and btrfs-check has different opinion on half-dropped
>>> subvolumes. But when the subvolume is fully dropped, then everything
>>> goes back into sync again.
>>>
>>>> our:            exclusive 1206681600 exclusive compressed 1206681600
>>>> disk:           exclusive 1206681600 exclusive compressed 1206681600
>>> But exclusive is correct, thus it doesn't look like regular qgroup error.
>>>
>>>> Is this something to be concerned about ?
>>> Normally you don't need to be concerned.
>>>
>>> If you really don't like this, you can just trigger a qgroup rescan and
>>> it will be handled well.
>>>
>>> Another thing is, if you're running btrfs check with --force, on running
>>> fs, it could give false alert.
>>>
>>> Thanks,
>>> Qu
>>>
