Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C61325736
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 21:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhBYUBX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 15:01:23 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:39102
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232139AbhBYUBP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 15:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614283222; bh=LqbKotoAz8geQyImrWg1Y/f+D+ZvQZnPoRm3lqiOBKI=; h=From:Subject:To:Cc:Date:References:From:Subject:Reply-To; b=UJsBh0L2zo8VhGZiok+F17KC9O4TP+rpeZcbHXyNrU4x7RKn1uFesycjICQt6j+g8hxxZwSyRpwM8nhItte2dmyk7FXI0f0AA2I5mukX7fOc5/YVZVBRu/H9HT3kF30eVh/ugfHCr+slWIUlcosawriuILmvNqNt/hom/FBYNv/VsM22tbfCNzrYiSINSC3WTWmRTpwtwESpWZueVUftQqSKdRBhmA2mtVlluStPKPpymU60/+xbK+AR85Alh68QFYuD0vTg14uvylxdwjb5qFELNlel8B1Bm+AaszG+kUcf3LzTHkPg3hs8d2UDPWzBCIvIBtM+haVK7FGy7wwY/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614283222; bh=RQrflA3RAVAbueOvPcOigFX5DJNGVYKTPYc8wWnnfr8=; h=X-Sonic-MF:From:Subject:To:Date:From:Subject; b=fheH5FUl70qHvMEqyRWCk/2npOA4UYnIf/6v2WeW86DAge1RxKGeVfku53tegl5knFnMEutXEMsvCH3SwqFKgLuqhluWbNIFRdiath6sO6PSUMp1rem0z787EK+3RrFZ9RSvW4C4x0E3NI8o0N9Kvpfs+ujnMUngRoonKsmMCg7eeYm88ZEWoL3SmenQbYn/juMKwcpDcjZWFz8TEYcUU6GVjTg57+Eo/5SEz1mFnIj2R0UYmwcPyCTFufuzm3C3SXMyYRA2RqGKxRm2xv6Epz3Yj/f2p0hh0OYdimDOLXKQSMt5ceUKAYZ4LDbvOLJGEuhlKXeuZILqjl1xZ3TMmg==
X-YMail-OSG: G19axzoVM1njJw8s5LCklQ5Tk3Vqt6zNSSm.0Tk6DLthPQuTwWw8hBDsF8G5r.L
 pAQ.xFIadBDgFAiCZCTfD0EfXjx4.Tdf.8EYHRYlAELCfAAYTsrB9b71X4fkOTaWZC2.4ZrrPDGe
 HFx_1KvmG6GcFIIpZjV03rQy8o_N5rc7cf3RA0m0tp4spRArg0V.e0uYFOW4_WXI2pjsA0AR3mqf
 vCKR9pP9.JJUck8Eui5SvGZN6Q_asOVUwI0KJbhqQxreAG0VDtPTDUH3wB6J7Beb.j7flP_Ev3vS
 jTY7K43KyNkufb27_HJnWy_UErDhuza7mDJNnlxE2WpBKBQjar4zZ_0wz5Vg.9i.bn6kJX6NjJ5b
 h65Zc1Xad3eziikIwSriwGW439PJhbYjtkLn7W9bLkwOAjxPGEmKzW5rcVWQmFe7oWQ9feEM0ZIL
 LkuPnLKziuLO_pw5AAN6mvuZ3xOv3RYFd_bOX0lSSOVQvzHZ1MhjN3W6MEMBEeb1d0YL0oywD0Wq
 cZPSDP0J8fdCzjpMYiOVgnsQDt4o67tpJe8RqihHSTGy86XZyAXb9nwf4_mpdDL.G749TX90zEus
 tQ5X60mOXsMxo6AswenQFNcxntkG2IjCcJ4oQvWpTitaD.V0FZmyzC1kGdXbxMA0ZoGYrbCL5yy_
 pkBqgS3dKd9sTW2_l9sFh5pWOLGkXy1v7G2mujiZhx6A7PdnRy2x_kAkH3PC0Kf5OV7jC51WdWoy
 o6EuRY7hiJIbfWgSsVDQv.MDeLPoe_rzL5XJbsoJk.I4Jbmq59DWPeW2teOcrlYWwIsjE.aVTMWd
 wsQEk0e1PD90Z3TjAmHI5VKJrZCXnd7jaeYpBuwVBSncF6RnkwbqpRn5EEnyTb36roAC3.WcZAjt
 RUeVXYO5sTytSLp8lRwge6vCeu2E7RIWc6lXn2VDU5jnDoLx_jPf9.v0upGuNd.LXhJOkVARJrr3
 KOTb.NjWx1hWZMsXRVYRX_EjPLok4I_MCaaurtMwsXMJjOJRJ8KO3hNVh5XQXml6NNKKL3gFG4W9
 H89kIO3k9mxEvBslPD5j9Lu107kDF2ZufaRXguG6U.xnphv1CLZpdkzJ71L7IXoylKKT10HwwHKm
 aO7ZJo_yjxV5YTdl0t0E5u9SYesNp_J9FEcQPfNxD3vxeo6DUaqvSTUsuQwhntY4fHeXy6ZXdY_q
 D01p9qncIHTlz24Zc3S0sMXRB4ZUCIRfwUd2jVGAsesQ1UJPa49ZAJppU5T1A7QIXJTkr5GZlE9S
 C9iUGb5aVuR5_U0TfJ_CmkqT5zyb5gLTpw9cvIvQLQMX9LfeRiLTP8G7urnuLFB7T_qnLW7XFWEU
 m_VgoH8Vu6fsm2SxdT2ycq3yiTYjrIXt89MP2s2qRPV8tSn.HqaiA0r0OH.Hord3jaUR2HCwXyDZ
 cSly45TA.EnqsgCkyzDDbmnTLphvPH0EUaamBXtf_GogwS5S71Wwha5ORK9ZnJI.kZ8i102EP_vP
 RFw66SJ4_SQNIYJNbKBTCJ98WPX1n6Hsi5XCIvqV_iwnbVlacqJ4sCfb9wVeCBxK5rwnEGa1Gibc
 AZ9_BjTYQWVL5LS5IPoXNO2uye_BcvrJbggbNhWsOsuepekZBbtYlJWOjbAHgi75k9ftgmx3g6Wl
 O_7G5_S1nEFSruYMdPTH32d2tNSgmnpynsdB1wAYF7b.eJs7nmHvFyOs2Vz__TKCCKlbmmy2wNVQ
 vkSx2t5ExMpDegPGVuTEJzqh2RfhnsMjujl9W5xZUUSzcBnyioOmUy8CMVqw_pTa7TuyLvoFJ_to
 O_7npjZFuM40ddPLLNoyZnY_hhghmw66oAI6h_LHQX8vOcbb8drf.LosazhSqpC0dlgVzD56JQun
 RI2YBcR1Kp8Ot4GZq4HrGjKjJlSh8ebpLppHsFkzP7xxYjeJwuhzxrJWJTgKSeswq77rxLHpJcUJ
 mOVa8lu5VJJDSXS0kEsrgrDAyKDfypEHiNmWaQKNj8OB3nKkc815Ggl3b9WWnguMiDfKw60D_oBh
 F.J0iJDQL32N6upCPVQjYFmoxRbuKilJWf1V41r1hHfvgrN8FZnoLCC_Z_zsOWwOyXWKXfO1r_Ky
 3plfr3DB.ahwBQA2zOZDmw43sOpMr8VZ2qQW2tto2gDEe71OxYhEhU97inyWhf6qK3DepEFDa9zl
 _UORFxMHfgIsJgPE5BqW9KsdizTJwOqyF7qjQk3cEjV17OmG2Z6Edc3HbQ8ZSD7U8C3lo8wT8Rtx
 4g3qt45Q.6t6hEvOFN.EJviLSqgT2oynNtVkPr1WEGrQYvr8Ut4d2zytQCwQajU7CnHqqEVxzmr.
 NMzAfaZ.PRvgHeh0XdkUkn_vEJRYmPWWt4hsnnrTfna3bAYHoRPaKuK7uIvJDgZj6C9E.7BEG3Id
 WKX6MgZmUOi9h07eGAYG1AXbElvKdF3E3TKKZ0TAG9WfGL8MU7bsBAEB0aZDgoqcYPlKtxuVLMav
 dkDA.tqcfzNWOq5fRmKd.ronEIw.zMAswFRlfRChm9k.1Oe6yP_L2eKY4RU0sN1vvFYPQZqnXfDT
 Zivv71ZyZhy4swwHWMKPOwRMdYP9ILPQLdhYjd.O.R2kvriHtblvpHjwSc_zcl_1wz9jFotxto_Z
 ZEOsZnLOnRbAEV.Qzrn.Bv6A-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Feb 2021 20:00:22 +0000
Received: by smtp418.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a4750092f0c6fe9273587b3544640919;
          Thu, 25 Feb 2021 19:47:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537
 start_transaction+0x489/0x4f0
To:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com>
Date:   Thu, 25 Feb 2021 11:47:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <434d856f-bd7b-4889-a6ec-e81aaebfa735.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently upgraded a Smack based system to Fedora33. I now get
this stack trace on a regular basis. The system appears to be
functioning correctly, but I find the warning worrisome.


[  220.732359] ------------[ cut here ]------------
[  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 st=
art_transaction+0x489/0x4f0
[  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns nf_c=
onntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_rej=
ect_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip=
6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_=
nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw=
 iptable_security ip_set nf_tables nfnetlink ip6table_filter rfkill ip6_t=
ables iptable_filter bpfilter sunrpc snd_hda_codec_generic ledtrig_audio =
snd_hda_intel snd_intel_dspcfg snd_hda_codec intel_rapl_msr intel_rapl_co=
mmon snd_hda_core kvm_intel snd_hwdep snd_seq snd_seq_device snd_pcm snd_=
timer i2c_i801 i2c_smbus snd kvm virtio_balloon soundcore iTCO_wdt intel_=
pmc_bxt iTCO_vendor_support lpc_ich irqbypass zram ip_tables crct10dif_pc=
lmul crc32_pclmul qxl crc32c_intel drm_ttm_helper ttm drm_kms_helper cec =
drm ghash_clmulni_intel serio_raw virtio_console virtio_net net_failover =
virtio_blk failover qemu_fw_cfg fuse
[  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ #=
81
[  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
=2E13.0-2.fc32 04/01/2014
[  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
[  220.732447] Code: e9 be fc ff ff be 03 00 00 00 4c 89 ff e8 3f b6 05 0=
0 85 c0 0f 84 8a fc ff ff c7 44 24 0c 00 00 00 00 4c 63 e0 e9 34 ff ff ff=
 <0f> 0b e9 c7 fb ff ff be 02 00 00 00 e8 86 72 17 00 e9 f0 fb ff ff
[  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
[  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 000000000=
0000003
[  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff88817=
7849000
[  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 000000000=
0000004
[  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: fffffffff=
fffffe2
[  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff88816=
80d8000
[  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knlG=
S:0000000000000000
[  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 000000000=
0370ee0
[  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[  220.732475] Call Trace:
[  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
[  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
[  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
[  220.732496]  __vfs_setxattr+0x63/0x80
[  220.732502]  smack_d_instantiate+0x2d3/0x360
[  220.732507]  security_d_instantiate+0x29/0x40
[  220.732511]  d_instantiate_new+0x38/0x90
[  220.732515]  btrfs_mkdir+0x1cf/0x1e0
[  220.732521]  vfs_mkdir+0x14f/0x200
[  220.732525]  do_mkdirat+0x6d/0x110
[  220.732531]  do_syscall_64+0x2d/0x40
[  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  220.732537] RIP: 0033:0x7f673196ae6b
[  220.732540] Code: 8b 05 11 20 0d 00 41 bc ff ff ff ff 64 c7 00 16 00 0=
0 00 e9 37 ff ff ff e8 d2 f3 01 00 66 90 f3 0f 1e fa b8 53 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 1f 0d 00 f7 d8 64 89 01 48
[  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000053
[  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f673=
196ae6b
[  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3=
c67a30d
[  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 000000000=
0000000
[  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 000000000=
0000000
[  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc3=
c679ce0
[  220.732563] irq event stamp: 11029
[  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] co=
nsole_unlock+0x486/0x670
[  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] co=
nsole_unlock+0xa1/0x670
[  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] asm=
_call_on_stack+0xf/0x20
[  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] asm=
_call_on_stack+0xf/0x20
[  220.732577] ---[ end trace 8f958916039daced ]---


