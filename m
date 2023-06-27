Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901973EFA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 02:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjF0ATy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjF0ATx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 20:19:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E31106;
        Mon, 26 Jun 2023 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687825183; x=1688429983; i=quwenruo.btrfs@gmx.com;
 bh=wtOTX3wxKZ5IRl5+HmuDFdjF3flXwUlM22cpXKay44k=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fFIkiQ49eR1rveQEHNPc8mymCmv/3qWY5BxY89uRwTRhHRNlMrV8mMIisyXnJSp7HwDMgz3
 ptSulWmRA7NcvIgKXxExXeLAxSvJqw17nkdzdWfX3ILrjaYdsmkGqnjwR3RxsL5UW/kQUj3TH
 D433Dk+QUuKRCTS5Y2h2Y+QIhgr8gqtEgR1tgNDkU5Nje2GSeml4ST2yWnfaiK+nmnogQHKrK
 cBnBJzEep/Lpl7kwJlfRv0N3hJFY9YjDUshvB+iLB4qdYzYBn7GWXpiKj+NIWC/3zhYaSh/9I
 wYeH/v7qpQHdjLDht/RLUt2IcmxvHo/3e9zuR/7FTdN4MnU0BULA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1qIsNk1o1u-00EwG2; Tue, 27
 Jun 2023 02:19:43 +0200
Message-ID: <ffa970c3-6907-023b-c8fb-7438694b24ef@gmx.com>
Date:   Tue, 27 Jun 2023 08:19:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] btrfs: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <5ce1e20e-019b-373f-f412-31fdb2c2379d@alu.unizg.hr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5ce1e20e-019b-373f-f412-31fdb2c2379d@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WCZUrE6VCrFKqXVXSypNkj77op60zqhnqjBUpLg+DW9+JkkmJx/
 H9Ny8YRo3C4acpE5p8il/ci+yqHHweIixpPG+16lfhP/1CaBWMyURDBNr1s2IiE2CQmN6x2
 WvswT+it9aKINn6K3xZrsH6bBqbT+LiTTFT25duOdduT8GEO5EUkth+KuCNt45tOmCrZxht
 xjI6IuMz6Rec/xO/qP32w==
UI-OutboundReport: notjunk:1;M01:P0:/0vvuqJ5kpA=;u+9ojA03zOU2z15Tdyglv/6Tp3A
 r0EFwPQPTB+5BZ02BeTkIyPfB2IuLyjUrT+V2wTAKWYVVf0qIiozJ2aSusKJ0VCOmPI7grJjm
 0UF7Ncl6LMlJxG1PYt1jHiEBbs8HuXYPbZdcm9pws9WmXnE28KK0MWJlnt0tgWEMCMt0ElHUN
 yF99Bz7KwTBVe16oFhlq5W0VWOU3jZow+hmStz4NSUeufyKhYgPnRNuz/8Enz2rKN4p0d/TG3
 /MVmEc9vzszaBMwIATs95hJrW0UjeJFd64SBW3uLB/qvBFO+tTyP8jbkKLazQNetRSMzbVlU8
 lY71FLZDRRzZNXVoKnG4b0EvZ9Ekp2zAEmJMogzB1McbJI1QSZh9uQTR+UGliZbQ98VkAiTbO
 iBFXW6U6GuU2FWBIy3mc0ZlgzQe+rz4W9HtnnfrHW48EHVmUdOnpauR+uMBjemkRNeE2wpcG3
 zzT3yUJlSzddtmRPxijqtbFnuBAyJ9U7I9mssMqpwOhIWxymdY8fAh0f80N6+v7JY3BJAQvWx
 keihPrkTAW91UgKusqy2EvW0JP7+sCLOHMMiJmMYRRSen4PriLcgIyHcgkr0cT4GVz//xRS9g
 ZKp45l0/5Qssf46Xy+2hxX/7elLU04zirZlVvZdgdjwEP+AlN9yca+vnL/hn3Wzvrunf8196b
 0HNyTOj29Htac/FlX4gaLyE8SN6rOpVGi2XTNq0oU6PGimU8XGgPP70o0IIkaVQ1saJISN1et
 WNgcS04TPwOJowqcrwH+hnRm89B+b1JaiB4Ix36cgKhfUdP5/FL9ck7IeDCyklNbUy4VJIvWO
 4Iw4f2tkzCaHoOZwQQsGZvzRIOzlJaQUkUbCO6nSnGvjDmONWw4QDZcEZYjFGT18RgBXXbPpW
 WYQXkNyjV3d4wgsK87Efg/r6olXbwwN5/G+UHjo4kepIPF+jXiXklWBT229KZcE2IQsfSnJcd
 LtM9gVIdMfEpKI086TfShfx29Vs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 07:40, Mirsad Goran Todorovac wrote:
> Hi,
>
> There is a bug apparently in btrfs file system.
>
> The platform is an assembled box with Ryzen 9 processor and ASRock X670E=
 PG
> Lightning motherboard.
>
> I do not have a reproducer, just kernel log:
>
> Jun 26 20:41:58 defiant kernel: [ 2273.786736] BUG:
> MAX_LOCKDEP_CHAIN_HLOCKS too low!

This is really what it said.

The setting is too low for certain workload.

In fact Fedora is already increasing this value.
If you want lockdep, I guess that's the only way to go.

Thanks,
Qu
> Jun 26 20:41:58 defiant kernel: [ 2273.786742] turning off the locking
> correctness validator.
> Jun 26 20:41:58 defiant kernel: [ 2273.786743] CPU: 20 PID: 6316 Comm:
> URL Classifier Not tainted 6.4.0-kmlk-netdbg-iwlwifi #3
> Jun 26 20:41:58 defiant kernel: [ 2273.786746] Hardware name: ASRock
> X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> Jun 26 20:41:58 defiant kernel: [ 2273.786748] Call Trace:
> Jun 26 20:41:58 defiant kernel: [ 2273.786749]=C2=A0 <TASK>
> Jun 26 20:41:58 defiant kernel: [ 2273.786751]=C2=A0 dump_stack_lvl+0x60=
/0xc0
> Jun 26 20:41:58 defiant kernel: [ 2273.786757]=C2=A0 dump_stack+0x10/0x2=
0
> Jun 26 20:41:58 defiant kernel: [ 2273.786759]
> __lock_acquire+0x1dae/0x2340
> Jun 26 20:41:58 defiant kernel: [ 2273.786764]=C2=A0 lock_acquire+0xca/0=
x2c0
> Jun 26 20:41:58 defiant kernel: [ 2273.786767]=C2=A0 ? kmemleak_free+0x3=
6/0xc0
> Jun 26 20:41:58 defiant kernel: [ 2273.786772]
> _raw_spin_lock_irqsave+0x4e/0x80
> Jun 26 20:41:58 defiant kernel: [ 2273.786775]=C2=A0 ? kmemleak_free+0x3=
6/0xc0
> Jun 26 20:41:58 defiant kernel: [ 2273.786778]=C2=A0 kmemleak_free+0x36/=
0xc0
> Jun 26 20:41:58 defiant kernel: [ 2273.786781]
> slab_free_freelist_hook.constprop.0+0xe7/0x210
> Jun 26 20:41:58 defiant kernel: [ 2273.786784]=C2=A0 ?
> add_delayed_ref_head+0x24e/0x280 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.786843]=C2=A0 kmem_cache_free+0x1=
a4/0x320
> Jun 26 20:41:58 defiant kernel: [ 2273.786847]
> add_delayed_ref_head+0x24e/0x280 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.786881]
> btrfs_add_delayed_tree_ref+0x284/0x450 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.786912]
> btrfs_free_tree_block+0xc0/0x2d0 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.786946]=C2=A0 btrfs_del_leaf+0xb8=
/0xf0
> [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.786975]
> btrfs_del_items+0x46b/0x4e0 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.787004]
> btrfs_delete_one_dir_name+0xf9/0x120 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.787034]
> __btrfs_unlink_inode+0xb5/0x4e0 [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.787067]=C2=A0 btrfs_unlink+0xdb/0=
x150
> [btrfs]
> Jun 26 20:41:58 defiant kernel: [ 2273.787094]=C2=A0 vfs_unlink+0x131/0x=
2a0
> Jun 26 20:41:58 defiant kernel: [ 2273.787098]=C2=A0 do_unlinkat+0x1b1/0=
x2d0
> Jun 26 20:41:58 defiant kernel: [ 2273.787102]=C2=A0 __x64_sys_unlink+0x=
42/0x70
> Jun 26 20:41:58 defiant kernel: [ 2273.787104]=C2=A0 do_syscall_64+0x59/=
0x90
> Jun 26 20:41:58 defiant kernel: [ 2273.787107]=C2=A0 ?
> syscall_exit_to_user_mode+0x39/0x60
> Jun 26 20:41:58 defiant kernel: [ 2273.787110]=C2=A0 ? do_syscall_64+0x6=
9/0x90
> Jun 26 20:41:58 defiant kernel: [ 2273.787113]=C2=A0 ?
> syscall_exit_to_user_mode+0x39/0x60
> Jun 26 20:41:58 defiant kernel: [ 2273.787116]=C2=A0 ? do_syscall_64+0x6=
9/0x90
> Jun 26 20:41:58 defiant kernel: [ 2273.787118]=C2=A0 ? do_syscall_64+0x6=
9/0x90
> Jun 26 20:41:58 defiant kernel: [ 2273.787120]=C2=A0 ? do_syscall_64+0x6=
9/0x90
> Jun 26 20:41:58 defiant kernel: [ 2273.787122]
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> Jun 26 20:41:58 defiant kernel: [ 2273.787124] RIP: 0033:0x7fe80911625b
> Jun 26 20:41:58 defiant kernel: [ 2273.787127] Code: f0 ff ff 73 01 c3
> 48 8b 0d d2 2b 10 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00
> 00 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
> 0d a5 2b 10 00 f7 d8 64 89 01 48
> Jun 26 20:41:58 defiant kernel: [ 2273.787129] RSP:
> 002b:00007fe7da0895f8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
> Jun 26 20:41:58 defiant kernel: [ 2273.787131] RAX: ffffffffffffffda
> RBX: 00007fe77e9c29d0 RCX: 00007fe80911625b
> Jun 26 20:41:58 defiant kernel: [ 2273.787133] RDX: 00007fe7da089620
> RSI: 00007fe77e705608 RDI: 00007fe77e705608
> Jun 26 20:41:58 defiant kernel: [ 2273.787134] RBP: 0000000080520015
> R08: 0000000000000000 R09: 0000000000000053
> Jun 26 20:41:58 defiant kernel: [ 2273.787135] R10: 0000000000000100
> R11: 0000000000000206 R12: 00007fe77e9c2a70
> Jun 26 20:41:58 defiant kernel: [ 2273.787137] R13: 00007fe77e9c29d0
> R14: 0000000000000000 R15: 0000000000000001
> Jun 26 20:41:58 defiant kernel: [ 2273.787140]=C2=A0 </TASK>
>
> Later the machine crashed completely, with the broken record sound
> during the
> "make kselftest", which I will try to reproduce later.
>
> The config and lshw are in attachment.
>
> The kernel is the recent 6.4.0 from torvalds tree, with Ubuntu generic
> config
> merged with per kselftest configs.
>
> I understand that the bugs with locking are extremely hard to reproduce,=
 so
> I add this bug report for documentation sake. >
> Best regards,
> Mirsad Todorovac
