Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCEB5E870D
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 03:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiIXBx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiIXBxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 21:53:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CD106528
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 18:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663984397;
        bh=yD63zfCfXc52l30jzNcmlH6SGZAFT1+8f32bakU96yA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=XJYqs/evIs93qIh+CmOjHZlpTTZ5QHPJRuvl5JfYyx6aWNMfpBWzMx3WaLP2nwTGe
         6aS/RigV5mFqQbyCcH981pJVcrNmTQ57F9n8uwa/WgpLEwKQfYAYJzT2i4jM1xaYlg
         s3JxFGsnrh33k0Im20zfW09bIfAVt0mw757HbsBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKZ3-1opsCR0oAR-00LjlC; Sat, 24
 Sep 2022 03:53:16 +0200
Message-ID: <038bc452-4270-ed04-0461-cdf6469953eb@gmx.com>
Date:   Sat, 24 Sep 2022 09:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: fstests btrfs/042 triggle 'qgroup reserved space leaked'
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220924074257.A1D6.409509F4@e16-tech.com>
 <ade04177-80ad-b5a2-b2eb-ce409a1b8e30@gmx.com>
In-Reply-To: <ade04177-80ad-b5a2-b2eb-ce409a1b8e30@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rXClck/64mx+z6TEWf1YUvc1pn1voUO3KDct1u1rPRp2A+8v+7L
 rTXh8TmIs8R1wK4ZC/ZWQ6x4CupnOc/Rmy1P0PVClgK1/9k6NguIf1ynlRWzQnlrXhqcVV9
 l8ZhT7zvYJSbUUflw5tV+ei09jm4OcUAN9jlUz6nkKhZ8cqXUU4cpIPrpuJ+QfVJ0PKv/m/
 TB2fL0rUsaBbwmFHoCvTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UK8B9sXpwJA=:y1NH2Tk+Z10qG9B/LDcT1h
 nLZsZncDfx8DoP4nfEVvu12k8viVVc1jiZGvjoGDXRQUUJKXxHLcNXbRqvJTfFZLYziNqanVP
 DaykIiSVVTybInVsueJxmgzfhK0QFL98MvLvEB97RrfG4kkgNpxx3vYVNNOEnEnS9MlmrMUkP
 IqyFZGhhc7DtgW9Z8v7++kfWV+twv8JtjXCuAn4pPdOAj0nyFVYb7rM75qkb/QhmebhGEzMPj
 PXncOVTaSCb++fVQ2NUQD0P1exWg9cQR1WgBoalUk34vG3UHl0aOcDwgaxyRD0W+idZU9PL0N
 nn195uZdXKafM5WZaybWH3wAP5dB/9BFlZci5KGYGPadK3v5otb8ayNigYdra6cCO1HzncbgA
 dq9nhDlR9JceMdAkaLY0249A3WQZP7xcc2TLH8Tfvz4oFM/lsZqxFR/q0jHZ53zhj+SaZN1ZT
 Ren03HSR/qqQ2rLS/n3PurNGEYT+ia+R5TM7prYHboQYjWaRAIbBVhUVpvNlVuJQaVfFadJr0
 5Q/+KQtrwA2ObiWks9Hty7pss1o2d0ASIA6fCPMEexD6nBY75f/LbjIZTEUDe46PT6OgXJ9g4
 jKTGNW/VzU6Fu2R42lUASQCsVpc4AFwjQdl2qwOlD0CQqRoK8KK5igvmMTVIyDIrt80p5QNOj
 ufh17YETIQTwzRpqfopU2c7pCc/Bb+79vJtiKVNnRQ5xKJy8k7i0dzD4/v4hO1pDJiShCS1Y5
 T/4Xp3oYr4dfq5zOKp/g0+TIksxKetoRIgBlJX7qLvywiiNCnZmORh8oR/hpEhb6k76ZQGgtm
 13SuaqLkW07NM/VotwahmuX2/M5bQGy5W4Vju+tfyj8+9kzXwcwcRtpBGvG2c4owPUzr450Ff
 bvi8S4b6un9oa4jkC+q3TPzuWTkPT0CCqz4TSN5UECt9pr0vfLh6tja5GkdYNcxmrUjlGX92M
 o7pT7eFWUIlurNn76dVT8TtPFuQc3qbvH1KV6mCYLlKD3nonswE3Mb6BBN33W+URuzjJfJq9b
 vQKQzJuatBvZt4jMWjatN1zhlmJ6Qqd/TIaLxn/FypsJ70oKEp4e9A4pw4QPkchY/uIpAWS+M
 YXr/PaBE7xiFJKar0E/Gu7cENojMyv1xqIqXyfn66mpzbcWa2QJF4s7B8ozBjNJGXcjG4uLlX
 F4UuqvBXgzxf9ge4ARycC02DaZ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/24 09:06, Qu Wenruo wrote:
>
>
> On 2022/9/24 07:43, Wang Yugui wrote:
>> Hi,
>>
>> fstests btrfs/042 triggle 'qgroup reserved space leaked'
>>
>> kernel source: btrfs misc-next
>
> Which commit HEAD?
>
> As I can not reproduce using a somewhat older misc-next.
>
> The HEAD I'm on is 2d1aef6504bf8bdd7b6ca9fa4c0c5ab32f4da2a8 ("btrfs:
> stop tracking failed reads in the I/O tree").
>
> If it's a regression it can be much easier to pin down.
>
>> kernel config:
>> =C2=A0=C2=A0=C2=A0=C2=A0memory debug: CONFIG_KASAN/CONFIG_DEBUG_KMEMLEA=
K/...
>> =C2=A0=C2=A0=C2=A0=C2=A0lock debug: CONFIG_PROVE_LOCKING/...
>
> And any reproducibility? 16 runs no reproduce.

Furthermore, I checked the result from Josef's nightly testing farm:

http://toxicpanda.com/

No such report on btrfs/042.

Any reproducibility or extra patches on your branch?

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> dmesg output:
>>
>> [15788.980873] run fstests btrfs/042 at 2022-09-24 00:40:24
>> [15803.880347] BTRFS info (device sdb1): using crc32c (crc32c-intel)
>> checksum algorithm
>> [15803.897721] BTRFS info (device sdb1): using free space tree
>> [15803.932525] BTRFS info (device sdb1): enabling ssd optimizations
>> [15818.525145] BTRFS: device fsid b255009c-2a39-49ed-b230-b4e26befd321
>> devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (310493)
>> [15818.791882] BTRFS info (device sdb2): using crc32c (crc32c-intel)
>> checksum algorithm
>> [15818.808805] BTRFS info (device sdb2): using free space tree
>> [15818.837770] BTRFS info (device sdb2): enabling ssd optimizations
>> [15818.847176] BTRFS info (device sdb2): checking UUID tree
>> [15818.911997] BTRFS info (device sdb2): qgroup scan completed
>> (inconsistency flag cleared)
>> [15838.397073] BTRFS warning (device sdb2): qgroup 1/1 has unreleased
>> space, type 0 rsv 12288
>> [15838.406954] BTRFS warning (device sdb2): qgroup 0/260 has
>> unreleased space, type 0 rsv 4096
>> [15838.416728] BTRFS warning (device sdb2): qgroup 0/259 has
>> unreleased space, type 0 rsv 4096
>> [15838.426511] BTRFS warning (device sdb2): qgroup 0/257 has
>> unreleased space, type 0 rsv 4096
>> [15838.436351] ------------[ cut here ]------------
>> [15838.442380] WARNING: CPU: 0 PID: 310592 at fs/btrfs/disk-io.c:4668
>> close_ctree
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include=
/trace/events/btrfs.h:749 (discriminator 14)) btrfs
>>
>> fs/btrfs/disk-io.c:4668
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_check_quota_leak(fs_info)) {
>> L4668=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(IS_ENABLED(CONF=
IG_BTRFS_DEBUG));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "qg=
roup reserved space leaked");
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> [15838.452948] Modules linked in: ext4 mbcache jbd2 loop
>> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
>> netfs rfkill ib_core sunrpc dm_multipath amdgpu iommu_v2 gpu_sched
>> drm_buddy intel_rapl_msr intel_rapl_common btrfs sb_edac
>> snd_hda_codec_realtek x86_pkg_temp_thermal snd_hda_codec_generic
>> radeon intel_powerclamp snd_hda_codec_hdmi ledtrig_audio coretemp
>> blake2b_generic snd_hda_intel xor dcdbas kvm_intel mei_wdt raid6_pq
>> snd_intel_dspcfg i2c_algo_bit iTCO_wdt iTCO_vendor_support
>> zstd_compress dell_smm_hwmon snd_intel_sdw_acpi drm_display_helper kvm
>> snd_hda_codec cec snd_hda_core drm_ttm_helper irqbypass snd_hwdep rapl
>> ttm intel_cstate snd_seq dm_mod snd_seq_device drm_kms_helper
>> intel_uncore snd_pcm pcspkr syscopyarea mei_me snd_timer sysfillrect
>> i2c_i801 snd sysimgblt i2c_smbus lpc_ich mei fb_sys_fops soundcore
>> fuse drm xfs sd_mod t10_pi sr_mod cdrom sg crct10dif_pclmul
>> crc32_pclmul bnx2x crc32c_intel ahci libahci ghash_clmulni_intel mdio
>> libata mpt3sas e10
>> =C2=A0 00e
>> [15838.453270]=C2=A0 raid_class scsi_transport_sas wmi i2c_dev ipmi_dev=
intf
>> ipmi_msghandler
>> [15838.551107] Unloaded tainted modules: acpi_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1
>> pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> [15838.560649]=C2=A0 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>> pcc_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1
>> pcc_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1
>> acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 pcc_cpufreq():1
>> acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1
>> acpi_cpufreq():1
>> [15838.659255]=C2=A0 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1
>> pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
>> acpi_cpufreq():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
>> [15838.779406] CPU: 0 PID: 310592 Comm: umount Not tainted
>> 6.0.0-7.0.debug.el7.x86_64 #1
>> [15838.789287] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS
>> A18 09/11/2019
>> [15838.798748] RIP: 0010:close_ctree
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include=
/trace/events/btrfs.h:749 (discriminator 14)) btrfs
>> [15838.805988] Code: c7 00 9b 2f c3 e8 1c e7 ff ff 48 8b 3c 24 be 08
>> 00 00 00 e8 2f 78 70 db f0 41 80 4f 10 02 4c 89 ff e8 31 46 f4 ff 84
>> c0 74 11 <0f> 0b 48 c7 c6 60 9b 2f c3 4c 89 ff e8 b0 8c ff ff 4c 89 ff
>> 49 8d
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 c7 00 9b 2f c3 e8=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movl=C2=A0=C2=A0 $0xe8c32f9b,(%rax)
>> =C2=A0=C2=A0=C2=A0 6:=C2=A0=C2=A0=C2=A0 1c e7=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sbb=C2=A0=C2=A0=C2=A0 $0xe7,%al
>> =C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=A0=C2=A0 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (bad)
>> =C2=A0=C2=A0=C2=A0 9:=C2=A0=C2=A0=C2=A0 ff 48 8b=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 decl=C2=A0=C2=A0 -0x75(%rax)
>> =C2=A0=C2=A0=C2=A0 c:=C2=A0=C2=A0=C2=A0 3c 24=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cmp=C2=A0=C2=A0=C2=A0 $0x24,%al
>> =C2=A0=C2=A0=C2=A0 e:=C2=A0=C2=A0=C2=A0 be 08 00 00 00=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 $0x8,%=
esi
>> =C2=A0=C2=A0 13:=C2=A0=C2=A0=C2=A0 e8 2f 78 70 db=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callq=C2=A0 0xffffffffdb707847
>> =C2=A0=C2=A0 18:=C2=A0=C2=A0=C2=A0 f0 41 80 4f 10 02=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 lock orb $0x2,0x10(%r15)
>> =C2=A0=C2=A0 1e:=C2=A0=C2=A0=C2=A0 4c 89 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %r15,%rdi
>> =C2=A0=C2=A0 21:=C2=A0=C2=A0=C2=A0 e8 31 46 f4 ff=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callq=C2=A0 0xfffffffffff44657
>> =C2=A0=C2=A0 26:=C2=A0=C2=A0=C2=A0 84 c0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 test=C2=A0=C2=A0 %al,%al
>> =C2=A0=C2=A0 28:=C2=A0=C2=A0=C2=A0 74 11=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 je=C2=A0=C2=A0=C2=A0=C2=A0 0x3b
>> =C2=A0=C2=A0 2a:*=C2=A0=C2=A0=C2=A0 0f 0b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ud2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <-- trapping
>> instruction
>> =C2=A0=C2=A0 2c:=C2=A0=C2=A0=C2=A0 48 c7 c6 60 9b 2f c3=C2=A0=C2=A0=C2=
=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 $0xffffffffc32f9b60,%rsi
>> =C2=A0=C2=A0 33:=C2=A0=C2=A0=C2=A0 4c 89 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %r15,%rdi
>> =C2=A0=C2=A0 36:=C2=A0=C2=A0=C2=A0 e8 b0 8c ff ff=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callq=C2=A0 0xffffffffffff8ceb
>> =C2=A0=C2=A0 3b:=C2=A0=C2=A0=C2=A0 4c 89 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %r15,%rdi
>> =C2=A0=C2=A0 3e:=C2=A0=C2=A0=C2=A0 49=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 rex.WB
>> =C2=A0=C2=A0 3f:=C2=A0=C2=A0=C2=A0 8d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .byte 0x8d
>>
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 0f 0b=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ud2
>> =C2=A0=C2=A0=C2=A0 2:=C2=A0=C2=A0=C2=A0 48 c7 c6 60 9b 2f c3=C2=A0=C2=
=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 $0xffffffffc32f9b60,%rsi
>> =C2=A0=C2=A0=C2=A0 9:=C2=A0=C2=A0=C2=A0 4c 89 ff=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mov=C2=A0=C2=A0=C2=A0 %r15,%rdi
>> =C2=A0=C2=A0=C2=A0 c:=C2=A0=C2=A0=C2=A0 e8 b0 8c ff ff=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callq=C2=A0 0xffffffffffff8c=
c1
>> =C2=A0=C2=A0 11:=C2=A0=C2=A0=C2=A0 4c 89 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %r15,%rdi
>> =C2=A0=C2=A0 14:=C2=A0=C2=A0=C2=A0 49=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 rex.WB
>> =C2=A0=C2=A0 15:=C2=A0=C2=A0=C2=A0 8d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .byte 0x8d
>> [15838.829023] RSP: 0018:ffff88810b7bfb98 EFLAGS: 00010202
>> [15838.836422] RAX: 0000000000000001 RBX: ffff88828ee54d58 RCX:
>> 0000000000000000
>> [15838.845734] RDX: 1ffff11064bd1ad3 RSI: 0000000000000008 RDI:
>> ffff888325e8d6a0
>> [15838.855015] RBP: ffff88828ee54fd0 R08: ffffed13f39c7a21 R09:
>> 0000000000000000
>> [15838.864347] R10: ffffed1418ee9840 R11: ffff88a0c774c200 R12:
>> ffff88824b4487b0
>> [15838.873690] R13: ffff88828ee55130 R14: ffff88819ea76ec0 R15:
>> ffff88828ee54000
>> [15838.883005] FS:=C2=A0 00007f41e8aaa500(0000) GS:ffff889f9ce00000(000=
0)
>> knlGS:0000000000000000
>> [15838.893294] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [15838.901224] CR2: 00007fa141b622d8 CR3: 00000001e2a34003 CR4:
>> 00000000001706f0
>> [15838.910553] Call Trace:
>> [15838.915219]=C2=A0 <TASK>
>> [15838.919527] ? fsnotify_destroy_marks
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/noti=
fy/mark.c:839)
>> [15838.926367] ? btrfs_cleanup_one_transaction.cold.75
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include=
/linux/perf_event.h:1189 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.deb=
ug.el7.x86_64/include/trace/events/btrfs.h:720) btrfs
>> [15838.935255] ? fsnotify_sb_delete
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/include/asm/atomic64_64.h:22 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7=
.0.debug.el7.x86_64/include/linux/atomic/atomic-long.h:29 /usr/src/debug/k=
ernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include/linux/atomic/atomic=
-instrumented.h:1266 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.e=
l7.x86_64/fs/notify/fsnotify.c:95)
>> [15838.941822] ? __fsnotify_vfsmount_delete
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/noti=
fy/fsnotify.c:91)
>> [15838.948905] ? evict_inodes
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/inod=
e.c:713)
>> [15838.954918] ? dispose_list
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/inod=
e.c:713)
>> [15838.960947] ? btrfs_sync_fs
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/btrf=
s/super.c:1570) btrfs
>> [15838.967745] generic_shutdown_super
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/supe=
r.c:491)
>> [15838.974445] kill_anon_super
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/supe=
r.c:1072 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs=
/super.c:1086)
>> [15838.980345] btrfs_kill_super
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/btrf=
s/super.c:2551) btrfs
>> [15838.987130] deactivate_locked_super
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/supe=
r.c:332)
>> [15838.993736] cleanup_mnt
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/fs/name=
space.c:1187)
>> [15838.999417] task_work_run
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
task_work.c:177 (discriminator 1))
>> [15839.005185] exit_to_user_mode_prepare
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/include=
/linux/resume_user_mode.h:49 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0=
.debug.el7.x86_64/kernel/entry/common.c:169 /usr/src/debug/kernel-6.0-rc6/=
linux-6.0.0-7.0.debug.el7.x86_64/kernel/entry/common.c:201)
>> [15839.012112] syscall_exit_to_user_mode
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
entry/common.c:128 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7=
.x86_64/kernel/entry/common.c:296)
>> [15839.018875] do_syscall_64
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/entry/common.c:87)
>> [15839.024600] ? lockdep_hardirqs_on_prepare
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
locking/lockdep.c:4260 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug=
.el7.x86_64/kernel/locking/lockdep.c:4319 /usr/src/debug/kernel-6.0-rc6/li=
nux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4271)
>> [15839.031881] ? do_syscall_64
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/entry/common.c:87)
>> [15839.037753] ? lockdep_hardirqs_on_prepare
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
locking/lockdep.c:4260 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug=
.el7.x86_64/kernel/locking/lockdep.c:4319 /usr/src/debug/kernel-6.0-rc6/li=
nux-6.0.0-7.0.debug.el7.x86_64/kernel/locking/lockdep.c:4271)
>> [15839.045010] entry_SYSCALL_64_after_hwframe
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/entry/entry_64.S:120)
>> [15839.052194] RIP: 0033:0x7f41e8953a6b
>> [15839.057913] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3
>> 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 63 0a 00
>> f7 d8
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 0f 1e fa=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 nop=C2=A0=C2=A0=C2=A0 %edx
>> =C2=A0=C2=A0=C2=A0 3:=C2=A0=C2=A0=C2=A0 48 89 fe=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mov=C2=A0=C2=A0=C2=A0 %rdi,%rsi
>> =C2=A0=C2=A0=C2=A0 6:=C2=A0=C2=A0=C2=A0 31 ff=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %edi,%edi
>> =C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=A0=C2=A0 e9 72 08 00 00=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 0x87f
>> =C2=A0=C2=A0=C2=A0 d:=C2=A0=C2=A0=C2=A0 66 90=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 xchg=C2=A0=C2=A0 %ax,%ax
>> =C2=A0=C2=A0=C2=A0 f:=C2=A0=C2=A0=C2=A0 f3 0f 1e fa=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 endbr64
>> =C2=A0=C2=A0 13:=C2=A0=C2=A0=C2=A0 31 f6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %esi,%esi
>> =C2=A0=C2=A0 15:=C2=A0=C2=A0=C2=A0 e9 05 00 00 00=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 0x1f
>> =C2=A0=C2=A0 1a:=C2=A0=C2=A0=C2=A0 0f 1f 44 00 00=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nopl=C2=A0=C2=A0 0x0(%rax,%rax,1)
>> =C2=A0=C2=A0 1f:=C2=A0=C2=A0=C2=A0 f3 0f 1e fa=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 endbr64
>> =C2=A0=C2=A0 23:=C2=A0=C2=A0=C2=A0 b8 a6 00 00 00=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 $0xa6,%eax
>> =C2=A0=C2=A0 28:=C2=A0=C2=A0=C2=A0 0f 05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 syscall
>> =C2=A0=C2=A0 2a:*=C2=A0=C2=A0=C2=A0 48 3d 00 f0 ff ff=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cmp
>> $0xfffffffffffff000,%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-- =
trapping instruction
>> =C2=A0=C2=A0 30:=C2=A0=C2=A0=C2=A0 77 05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ja=C2=A0=C2=A0=C2=A0=C2=A0 0x37
>> =C2=A0=C2=A0 32:=C2=A0=C2=A0=C2=A0 c3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 retq
>> =C2=A0=C2=A0 33:=C2=A0=C2=A0=C2=A0 0f 1f 40 00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nopl=C2=A0=C2=A0 0x=
0(%rax)
>> =C2=A0=C2=A0 37:=C2=A0=C2=A0=C2=A0 48 8b 15 89 63 0a 00=C2=A0=C2=A0=C2=
=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0xa6389(%rip),%rdx=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 #
>> 0xa63c7
>> =C2=A0=C2=A0 3e:=C2=A0=C2=A0=C2=A0 f7 d8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 neg=C2=A0=C2=A0=C2=A0 %eax
>>
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 48 3d 00 f0 ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmp=C2=A0=C2=A0=C2=A0 $0xfffffffffffff000,%=
rax
>> =C2=A0=C2=A0=C2=A0 6:=C2=A0=C2=A0=C2=A0 77 05=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ja=C2=A0=C2=A0=C2=A0=C2=A0 0xd
>> =C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=A0=C2=A0 c3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retq
>> =C2=A0=C2=A0=C2=A0 9:=C2=A0=C2=A0=C2=A0 0f 1f 40 00=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nopl=C2=A0=C2=
=A0 0x0(%rax)
>> =C2=A0=C2=A0=C2=A0 d:=C2=A0=C2=A0=C2=A0 48 8b 15 89 63 0a 00=C2=A0=C2=
=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0xa6389(%rip),%rdx=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 #
>> 0xa639d
>> =C2=A0=C2=A0 14:=C2=A0=C2=A0=C2=A0 f7 d8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 neg=C2=A0=C2=A0=C2=A0 %eax
>> [15839.081093] RSP: 002b:00007fff313c23d8 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000a6
>> [15839.090894] RAX: 0000000000000000 RBX: 000055d74a755540 RCX:
>> 00007f41e8953a6b
>> [15839.100242] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> 000055d74a75a550
>> [15839.109546] RBP: 000055d74a755310 R08: 0000000000000000 R09:
>> 000055d74a754010
>> [15839.118783] R10: 00007f41e89faaa0 R11: 0000000000000246 R12:
>> 0000000000000000
>> [15839.128016] R13: 000055d74a75a550 R14: 000055d74a755420 R15:
>> 000055d74a755310
>> [15839.137246]=C2=A0 </TASK>
>> [15839.141444] irq event stamp: 36915
>> [15839.146842] hardirqs last enabled at (36929): __up_console_sem
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/include/asm/irqflags.h:45 (discriminator 1) /usr/src/debug/kernel-6.0-rc=
6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x86/include/asm/irqflags.h:80 (dis=
criminator 1) /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_=
64/arch/x86/include/asm/irqflags.h:138 (discriminator 1) /usr/src/debug/ke=
rnel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/printk/printk.c:264 (=
discriminator 1))
>> [15839.157472] hardirqs last disabled at (36942): __up_console_sem
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
printk/printk.c:262 (discriminator 1))
>> [15839.168059] softirqs last enabled at (34740): __do_softirq
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/arch/x8=
6/include/asm/preempt.h:27 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.d=
ebug.el7.x86_64/kernel/softirq.c:415 /usr/src/debug/kernel-6.0-rc6/linux-6=
.0.0-7.0.debug.el7.x86_64/kernel/softirq.c:600)
>> [15839.178441] softirqs last disabled at (34701): irq_exit_rcu
>> (/usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_64/kernel/=
softirq.c:445 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debug.el7.x86_=
64/kernel/softirq.c:650 /usr/src/debug/kernel-6.0-rc6/linux-6.0.0-7.0.debu=
g.el7.x86_64/kernel/softirq.c:662)
>> [15839.188788] ---[ end trace 0000000000000000 ]---
>> [15839.195355] BTRFS error (device sdb2): qgroup reserved space leaked
>> [15839.544913] BTRFS info (device sdb2): using crc32c (crc32c-intel)
>> checksum algorithm
>> [15839.563333] BTRFS info (device sdb2): using free space tree
>> [15839.597640] BTRFS info (device sdb2): enabling ssd optimizations
>>
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2022/09/24
>>
>>
