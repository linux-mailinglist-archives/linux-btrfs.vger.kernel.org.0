Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E46325867
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhBYVIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 16:08:30 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35717
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234952AbhBYVGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 16:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614287159; bh=bckUdSJQvLjlSwTRqHXaCT1OVXilujwfvdeuSRHJJjE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=eWVl2MmJIeTGK8K3FxKK9XGCp9iZOYGgswYcwR45ml46tbJG9IsvXGMHJWfb20jR2LVI2A7ldIb6fM+HkB2C9MFplqKSNvbAgHRIdHqiu5EBIegVDRLr288oSCog+UCUAL/EUxVlG3Z1s6O6wM12EYAClqPqNoJzswj991qtNfWpWSnJaXaB467RGGnoaoMIdgDyjgNDOo70+HUKzmYUWvqPl/+gmHvd6LEPEdJIpyV8bkEeyknshJ1cQ1b/L/2istJeD5N/kYofj+HMW9pC3bCiC/Q/u8pLbQUAR3rJI8swKA9PdhhdZdlRPtrsGVZpkCq6/bPpiiSImbfB/amBPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614287159; bh=zyHd/onij4OKalsP6yay/9XWAfdD/8F0ia97YfY3GDv=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=LxUo1Ppbi6GzP+wJuKP+K6nc9ZkotW7BX6CFXjsbPWVIG7f3wf8chzKIyljI0GSCJIBKjnNBaXIZfy4lTwyQigCzV+6EZC9lW6hyH+4/VZo2CXAndcAhEEJW4wBhU5GywsauxOgRt1MBWjerS7ng7mpY6ZCyT7PKQPbl++x52m6mVJVgvCK292TslQWz/RFepoUfDRdCiWY+2lg4g8VXwCXPx5ZtoK8a16VZ1ZIEGiYYebAFc8gavw2jbHa8T2SFUCz8LavzHFATJ4gjyytVuYCXumIuTxy+3cK5kupHuDtGUdPtkLvMG/fKqzblQTMdSdAI+RhE2VNSyzTm+AELKw==
X-YMail-OSG: ZraPvu0VM1lBxw9mT2fGyabcFjoA2T1bLqFWFDQCTyZjlK7wu5v1Ff960OMJD9w
 jgmULzglBHJIO2oR7oIl2AFEc2ecbJujsr41YRdAdsqLUw.QH2XcucaRb8WBeZMlbgv77K.owSPS
 PGWl6EI.JJ9H.43bNGb1WZMSejJJ.wJ2FuVVHvQ6arOIhoXNd.kVa3dDaDEAi9Dzy3V.qkMMA_vK
 n.G2.opSfcRa5DPiTrTFgeOO5Rd4MtsEINVt3D1vqFdD_68sL_AbiAiy6zoxwaCYqq7GkiBhjo55
 dtYudv.tfDxMqcsjxW7TkGwUWpXvuA8.OZAnOr8_uo1wEN.NPlgYyuoVA5jbFRW_4l_CCl6Gh6CW
 YJALBVLTETxaTe3Q3gSIWbAzPFlgQ622IFtweF.rFmUcHCPAEnYF5uj4EZU_LmVUvlHmhos0NuNb
 BJf3IOn18DMeGS9CmtOG40otTO6r5MGW7pIXWMzWiGjbNEEmsar7tQgoBI1M8hwL4oFLO.Nl6W5j
 gNxzmVswmyDW4_0i6IgqidiufwzsTanSfXQaFudIz2MYVsvuhS_BZFNRTdFonst4SDF6EVh6iAFY
 yEd.UC7dzPHCCfEzFeA9uczQg8ZCo7i2NqAXFvAqnOJ5lfReiC558325ZFBVymsXg7ThZV039G1R
 oIG1ZJqR0SjJwP.yVqIKCYfOWIySjQ261VZlkNQShLzsCOEwwzDyE0TMRBw2FCxTG1a_HizfpYU4
 hAjFOmt0hW58CIbQvCmyF0HTbeWV4rss2Wli0CWRSZsl6hAunP6ND9V0p1AjwsgvI6hOitPB66fR
 WczgHD.Nlay18uuBIPeLNDbR0pKDDVe2N2qJS0f9fMN_yPt1VPfMtaQ4nx1LXdsmx9eCqgzCtFBf
 WMOWTx5VD77K0XrBsRhbflsHwe9GH71yBpG_NeuTQpPNJBVVZYXSyffFReDm43G2yZekBZXDXTm0
 KuTieIlxu9HBIuvldCADoMRN1BXaY.8f2GT5T9AcWxHKXVGB3_ibZ77Oupbdg4YYdrZL7VxSaMO0
 _V7FHpJHG9FvF7UBVTB6pIFeZMDRLdkUVCgPN9gaZlS3tK9Mt4uAKvILFN5ssdwfuy5zVYdysYu6
 y7U7uDKBvZWf1gnNtNloLJgbkWwI44g7StOP_Y5QOc_8I.lmhXAsP7MVhxFGIRqf9z2.nafrlkCk
 TOXz8IjA3pPEbjwITXQp_u2nx7yMZLuL3Rt_fpvU0WnUvE6rO6m6cAg3w3G7jMqeNB0G5.WlaY2a
 vN5QcwAa0ktFhAxFuk0jz7IE25m6V8jKwmpj.SiQPRU8d4bRVM2dKd84ru0RFLL8Ak.MIIQy_HAr
 QP3qo_WadkTmjw2B3B47XmeQpBnqpG4._XzXq0OCyYB6MFYJ0TX.ihoiNT58gLQF91Owm208OrOY
 kuJZCorAWd69ovL0YaXfb5Aev.gv5_IlyVC0mEsYtYL97ADMfIlnT.rP7.qC9P_wPfEzeXiD4ueW
 O8R5FFrw5qMyqtYza_KWslWY7.MY4Dk_Qg.zB74mkk_GxfR2b..faW4EBmkg6RH8Xz_mnOQys5_.
 _v7KMGCNiqvuKFAgnRbqb0kvUIxTXrgwR2whzpq1ctK.oiYwsVarH2FO1UT9t7jCr3n6sWjPF3TH
 goN8r2GUXD5Xfz7zp0QQmCaDK0sR8LHlJCNqI3M770lpAtHamPyQF6HlRSTul.yks742Y3GO6UcV
 zEWKqYLOhtWMW5Nc_rLNZuyZquTw05BroAj79phavq0rIyieDvDdkwjyBw4Z8lYbwammrYdn7vN9
 3z1tVGG13QyUOLGWU14x7rwYuKvW72gWc7ftHELxrnOxdO2CH_RaeNmMw5fTy8Z.ZSZY53u7UiiF
 XqcM4buqRRalSHQvsHtPrr4m5yLIXrtZQdWEEPcFrfOBQUid3JUhJ5WjfWyrROOV4zjuUFZw9qh1
 EZ9zR_bz4RS.Sny.RrfHpFfBYjHrDB3MMCsK9VpcbU66vjVqFFPg_kNCUANiV63PDO4fKbBcG0Bb
 SwTAF0WV.aHSURBYR8A56eOC1JP9premv2bS.eGZmM7IztNU46vfXEXqhKCeR3v4WBlByrJzSGFr
 9_6VzxyV2_QgeQ_de.B7NLgB3NZ4ovMSUTZnCUrLRxjZudLdnSImKjEy0S.zX8XaDjPZVwcS9T8q
 s2b8rSCoGDE79OrDmWKuTaC4tKNAGUnHyDg_kPlSf.i_dAs9mt_dGzBwhuECvazK32.2YimQ9Xrk
 Tz..Rv9reAorqnFg09e2upI3BXh1CEHSfP4KWdsWPP4UNsIAdNcaIH3SWkL_hfchhtw8.9hsvGq9
 YweXZT3oHsKvj0VkmFp8S4L_YKsKGvJrwZo15uMtb3LtedbpWTWN3H0XO2eGqzT3F7YtMWjHycgD
 6GwsiOKCNdzK7mkbEb4YL52zIT5mrrwyF23XbfGT4zkVHPwjneEJZ8YYeV.z_BTMUabU4A.c.vLI
 o1Pad0b4Ao9E9bGM6meQqxQKzRvLPlfZvvwBInIuwoX5xniBDLMyiOeqBhLhhCGeWTKRUvAsQeNv
 jxU_EhD.69mRnVCXLBsVb48TMIJRjMfbcVkaSrtaToQKDTmUelGRaVytwbVvnMXJQvf8TlF6YdlO
 EEKK6z1NOawrtL3YBfwDQfGT2jknEfxZMuMVbK3eS8v4dASPpANpCxgsdLfv_EmCXCMizrPkAvFu
 vsFNk4FAtAcMeh.1lD28YpCfRf6p5a8ekDUQDiFN9ZaDW.2O_RjcbmbgNvHHOUeoaaHEmOr0mXtm
 YfW1JUkv6yycV8mCwBFU_DFahh9d6YQETjccNIC.Q9cfEU61uftHqxRKz3dK5iKdvKl3GD9dOnA-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Feb 2021 21:05:59 +0000
Received: by smtp401.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8391eb5841c4a403e2246c91eb94db22;
          Thu, 25 Feb 2021 20:52:50 +0000 (UTC)
Subject: Re: WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537
 start_transaction+0x489/0x4f0
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <434d856f-bd7b-4889-a6ec-e81aaebfa735.ref@schaufler-ca.com>
 <434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com>
 <CAL3q7H4kxtm8HQ-VtNj42KhQmX3ehDnoKbV8Xn4YqEjMXLP_4g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9ba197d9-b8f1-9f59-430d-dcc52973444c@schaufler-ca.com>
Date:   Thu, 25 Feb 2021 12:52:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4kxtm8HQ-VtNj42KhQmX3ehDnoKbV8Xn4YqEjMXLP_4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/25/2021 12:39 PM, Filipe Manana wrote:
> On Thu, Feb 25, 2021 at 7:52 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> I recently upgraded a Smack based system to Fedora33. I now get
>> this stack trace on a regular basis. The system appears to be
>> functioning correctly, but I find the warning worrisome.
> You have SELinux enabled I suppose.

No, I have Smack enabled, per the stack trace.

>
> Try the following patch:
>
> https://pastebin.com/HXYCxyTD
>
> And yes, the warning in this context, should cause no harm.

OK, thanks. I shan't worry about it any further.

>
> Thanks.
>
>>
>> [  220.732359] ------------[ cut here ]------------
>> [  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537=
 start_transaction+0x489/0x4f0
>> [  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns n=
f_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_=
reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat=
 ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_=
raw iptable_security ip_set nf_tables nfnetlink ip6table_filter rfkill ip=
6_tables iptable_filter bpfilter sunrpc snd_hda_codec_generic ledtrig_aud=
io snd_hda_intel snd_intel_dspcfg snd_hda_codec intel_rapl_msr intel_rapl=
_common snd_hda_core kvm_intel snd_hwdep snd_seq snd_seq_device snd_pcm s=
nd_timer i2c_i801 i2c_smbus snd kvm virtio_balloon soundcore iTCO_wdt int=
el_pmc_bxt iTCO_vendor_support lpc_ich irqbypass zram ip_tables crct10dif=
_pclmul crc32_pclmul qxl crc32c_intel drm_ttm_helper ttm drm_kms_helper c=
ec drm ghash_clmulni_intel serio_raw virtio_console virtio_net net_failov=
er virtio_blk failover qemu_fw_cfg fuse
>> [  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack=
+ #81
>> [  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.13.0-2.fc32 04/01/2014
>> [  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
>> [  220.732447] Code: e9 be fc ff ff be 03 00 00 00 4c 89 ff e8 3f b6 0=
5 00 85 c0 0f 84 8a fc ff ff c7 44 24 0c 00 00 00 00 4c 63 e0 e9 34 ff ff=
 ff <0f> 0b e9 c7 fb ff ff be 02 00 00 00 e8 86 72 17 00 e9 f0 fb ff ff
>> [  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
>> [  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 000000=
0000000003
>> [  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff88=
8177849000
>> [  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 000000=
0000000004
>> [  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: ffffff=
ffffffffe2
>> [  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff88=
81680d8000
>> [  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) k=
nlGS:0000000000000000
>> [  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 000000=
0000370ee0
>> [  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
>> [  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
>> [  220.732475] Call Trace:
>> [  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
>> [  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
>> [  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
>> [  220.732496]  __vfs_setxattr+0x63/0x80
>> [  220.732502]  smack_d_instantiate+0x2d3/0x360
>> [  220.732507]  security_d_instantiate+0x29/0x40
>> [  220.732511]  d_instantiate_new+0x38/0x90
>> [  220.732515]  btrfs_mkdir+0x1cf/0x1e0
>> [  220.732521]  vfs_mkdir+0x14f/0x200
>> [  220.732525]  do_mkdirat+0x6d/0x110
>> [  220.732531]  do_syscall_64+0x2d/0x40
>> [  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  220.732537] RIP: 0033:0x7f673196ae6b
>> [  220.732540] Code: 8b 05 11 20 0d 00 41 bc ff ff ff ff 64 c7 00 16 0=
0 00 00 e9 37 ff ff ff e8 d2 f3 01 00 66 90 f3 0f 1e fa b8 53 00 00 00 0f=
 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 1f 0d 00 f7 d8 64 89 01 48
>> [  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000053
>> [  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f=
673196ae6b
>> [  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007f=
fc3c67a30d
>> [  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 000000=
0000000000
>> [  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 000000=
0000000000
>> [  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007f=
fc3c679ce0
>> [  220.732563] irq event stamp: 11029
>> [  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>]=
 console_unlock+0x486/0x670
>> [  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>]=
 console_unlock+0xa1/0x670
>> [  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] =
asm_call_on_stack+0xf/0x20
>> [  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] =
asm_call_on_stack+0xf/0x20
>> [  220.732577] ---[ end trace 8f958916039daced ]---
>>
>>
>

