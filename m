Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453CE75454F
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 01:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGNXO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 19:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGNXOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 19:14:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9D35BC
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689376481; x=1689981281; i=quwenruo.btrfs@gmx.com;
 bh=WR6tGVSniaC6AbpviFOgPAjI6XfQuplL86SEG+tPLCc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=dNWkOzBpIdMDxgkfmT4lQveWevllm5XbrMd3S9Q3P2JF0hnx3OzH6ioaPfG0/74ueEDyIUO
 lDV7WkoCCv4k6s6mxdswO/+c5fHhzoEHhto/O6lbmKntR+mTNUi2zIdvtHyx5655Qkb3nKJZO
 NWjsZZ+newkTeGsgVpEhHJxqD+k5KBRqXynJMrdhfi7rI0nuEarv76veYJTlvxAPZscdHzER5
 74NmCCvrkAftTxTZ2ZXl2Gwy+ewsr/WWD1u4Z213MIXtV4JmBll3QdtpFSQzXBotGdPLaDQBs
 ejbW9EWbCJePDDbI+svlR9kPjcPeQIAZ0yl0KBhHkIjFizU/9Amw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1pa8oj0W9A-00opjC; Sat, 15
 Jul 2023 01:14:41 +0200
Message-ID: <cb0cd925-7a48-2867-f612-6061b708d484@gmx.com>
Date:   Sat, 15 Jul 2023 07:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] btrfs: fix warning when putting transaction with
 qgroups enabled after abort
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
 <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fWVNuvm40m770OQF5rswadjRqNeksy7NWRTPgYjagEhgtOoJRTv
 Cn/WTcDfQ/uwF4VRZwmOJ+uqxspQh4yq2ut7WYP7WEopWwtWzg7+quttAB5afdO8okfSYbz
 2bMk7zzYxTNsmMcFKzqe2OC46TfcYJHI+q3KyTcjxsm70ydGwQQujGmkbJEU0MFmBgO52Bb
 b+2y1UUXC7PBLPYsir6fw==
UI-OutboundReport: notjunk:1;M01:P0:6FLpXnEBGnE=;OgzG8nrJU0i7ICYUlugt1cJjs3G
 xh3OxCh01ZY3gA6HMFTySntR18Kp04jiMIgNplW5eyshdnZ5Bs0fNoI8VDixAHgfzQpd9S9BP
 6jn8nu3JbzYunUw61MOp3JBqzgGzuTWaGlUaUJ6zmB/eY01h0UaCDJsvFGdD+EiyANNmlkSjY
 5SSdi4dVcUdPvV/Yhj0d0SvVF3lYGHGhgkOErxd8s/Rze5SCC15hrj/Nyp7/5AlkHHCiUpHA2
 Jj8myJBXjT83x1MYGh96JwE3YNZVt7yiY3h4pZ8pmkICLut8eatkX6wQLz3ph7aOzfG+wkNRt
 r5IK5TtTSF4ggo6JgILkFz9FA8HtjPcEt6KLTqgHdiv4qKGjDgwJpTUoGSbvv9jrpMLqf5J9J
 iVlD6YdXc1cavo/WkfVUeuxscoH9P9gHWXOxuJK6qB4YWB47oiEDZ5lJtoPmOeSyruo1fK2PK
 V7KHCo5X4SSP4aIUpLy/GAygMyOPFNnlW+HeaM3ncPeVbtT2mZzgVpsb7z8AHwrkzKScX8khj
 71+SYQbLdvaH/rQ+Nk2DBFzeD/VjBUfYq3GMS8go4cOT6uLugz9HqvgbsdiPZQHZY3GubHADB
 VlYafz0MKCQquZVephiZ/ZMxrfjdk8HGiCBRVLKKRElu1YHHffMZRscXtBKdkur5e7c3kJ+Ng
 u0OvPUIDgRYCt9JQmprH8pYqQEufW9vDL/PCS/MkbKoV208PEnG5hmCdAqQR/FzAEprqwMUrT
 sbmM4DhcpgOnOtZS/0bpKG+CIJ2KFXKcCH998LMUhqeQ75WFtiQLQArDqw44xus4kPH5Xw7z6
 vMHes34eyxX+Vx1b49cD8nkujmUYEogjWfDiGfpL9vpVJd+cTvb7Fl4itiSKkW6TKoV9fRzqD
 QzDOO+KBSE8g6EdAIo3u3kctkiC3FIPJK1vaFAwkhZuDnFO26iEw2cMo69spZ2biVRuppWD3B
 dBKUW7qQfaYbJdB/VtlaPVy84Vk=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 20:42, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> If we have a transaction abort with qgroups enabled we get a warning
> triggered when doing the final put on the transaction, like this:
>
>    [161552.678901] ------------[ cut here ]------------
>    [161552.681530] WARNING: CPU: 4 PID: 81745 at fs/btrfs/transaction.c:=
144 btrfs_put_transaction+0x123/0x130 [btrfs]
>    [161552.681759] Modules linked in: btrfs blake2b_generic xor (...)
>    [161552.681934] CPU: 4 PID: 81745 Comm: btrfs-transacti Tainted: G   =
     W          6.4.0-rc6-btrfs-next-134+ #1
>    [161552.681945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [161552.681951] RIP: 0010:btrfs_put_transaction+0x123/0x130 [btrfs]
>    [161552.682139] Code: bd a0 01 00 (...)
>    [161552.682146] RSP: 0018:ffffa168c0527e28 EFLAGS: 00010286
>    [161552.682155] RAX: ffff936042caed00 RBX: ffff93604a3eb448 RCX: 0000=
000000000000
>    [161552.682161] RDX: ffff93606421b028 RSI: ffffffff92ff0878 RDI: ffff=
93606421b010
>    [161552.682166] RBP: ffff93606421b000 R08: 0000000000000000 R09: ffff=
a168c0d07c20
>    [161552.682171] R10: 0000000000000000 R11: ffff93608dc52950 R12: ffff=
a168c0527e70
>    [161552.682175] R13: ffff93606421b000 R14: ffff93604a3eb420 R15: ffff=
93606421b028
>    [161552.682181] FS:  0000000000000000(0000) GS:ffff93675fb00000(0000)=
 knlGS:0000000000000000
>    [161552.682187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [161552.682193] CR2: 0000558ad262b000 CR3: 000000014feda005 CR4: 0000=
000000370ee0
>    [161552.682211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
>    [161552.682216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
>    [161552.682221] Call Trace:
>    [161552.682229]  <TASK>
>    [161552.682236]  ? __warn+0x80/0x130
>    [161552.682250]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
>    [161552.682430]  ? report_bug+0x1f4/0x200
>    [161552.682444]  ? handle_bug+0x42/0x70
>    [161552.682456]  ? exc_invalid_op+0x14/0x70
>    [161552.682467]  ? asm_exc_invalid_op+0x16/0x20
>    [161552.682483]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
>    [161552.682661]  btrfs_cleanup_transaction+0xe7/0x5e0 [btrfs]
>    [161552.682838]  ? _raw_spin_unlock_irqrestore+0x23/0x40
>    [161552.682847]  ? try_to_wake_up+0x94/0x5e0
>    [161552.682856]  ? __pfx_process_timeout+0x10/0x10
>    [161552.682872]  transaction_kthread+0x103/0x1d0 [btrfs]
>    [161552.683047]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
>    [161552.683217]  kthread+0xee/0x120
>    [161552.683227]  ? __pfx_kthread+0x10/0x10
>    [161552.683237]  ret_from_fork+0x29/0x50
>    [161552.683259]  </TASK>
>    [161552.683262] ---[ end trace 0000000000000000 ]---
>
> This corresponds to this line of code:
>
>    void btrfs_put_transaction(struct btrfs_transaction *transaction)
>    {
>        (...)
>            WARN_ON(!RB_EMPTY_ROOT(
>                            &transaction->delayed_refs.dirty_extent_root)=
);
>        (...)
>    }
>
> The warning happens because btrfs_qgroup_destroy_extent_records(), calle=
d
> in the transaction abort path, we free all entries from the rbtree
> "dirty_extent_root" with rbtree_postorder_for_each_entry_safe(), but we
> don't actually empty the rbtree - it's still pointing to nodes that were
> freed.
>
> So set the rbtree's root node to NULL to avoid this warning (assign
> RB_ROOT).
>
> Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transactio=
n abort")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V2: Use RB_ROOT macro instead of assigning NULL directly to the root's r=
b_node.
>
>   fs/btrfs/qgroup.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index da1f84a0eb29..2637d6b157ff 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4445,4 +4445,5 @@ void btrfs_qgroup_destroy_extent_records(struct bt=
rfs_transaction *trans)
>   		ulist_free(entry->old_roots);
>   		kfree(entry);
>   	}
> +	*root =3D RB_ROOT;
>   }
