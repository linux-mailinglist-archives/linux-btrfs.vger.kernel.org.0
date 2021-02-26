Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4E3267D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 21:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBZUHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 15:07:42 -0500
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:40794
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230273AbhBZUHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 15:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614369947; bh=lOIZoItOnwxjp5eOdCf77QM5B59RrMmv+R13Uc4RmQA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=KZt0fDZYfYuXYf7+l3keu5lJrAB/qyWYclYIVHPohTklAAxmDw0ACaKM2gArAaUJ8yFl9VCPQcWw/D5aCYkrjVpmpHcHpxhbwL6RmwsZTjoIwnnqkE28NMnQ45C5rIXWl9GwuXKMZqyHysdBh081DZplL0VTgbzIhNUZDbbP/BFI1ile5fXxWJuNqt+LPWBK5SJlBYCeBJe6XHfJe3PqUAp2uynGthecBWa41sfcfGEpbLkMm3xjvEI+iS9DYhx7DfRHSySqmv+hH3JhdZS1OYDpl0gf3+L9bsNsXuRYbVbiHX7jD7WFnmDjeIQcEDKl22oOpARGSTAWcg+9l6KLbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614369947; bh=nqSr0GXTp1SOTmC+3CJ0uDAreeWMQQoQ2eSDodiIykX=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Umoa3XdDRDjMVVe1I1a9kuHpcSnenVs/YtKhqIej131mSBH9hgEfqrUxzexUarhvLh7P5/BG4cC0VcgGo/Tv6C94Rk/uwArAPLWgZJGMYV8Gui7v8Hhur07zmgSauhxMLYZCnENmWEPlXqEWrdQaz1T6zv7FM6h7Nv9w6zj+iZ6iEO2dD7bnmTDQEcJcHzZutxvU17Dn2holrz8dG/bo0NlHVyaWQtNv6Twruv4rq5+QaP+IRMlbTLDq7FmIhAtxZ4sNEZa6x3NuyaY6CCrFHApg8odqcWk8RjuaXoBDdYyrv6PhbGv2nUWL1bjoqybOAJuowQuAxOJKJAGEf27cvA==
X-YMail-OSG: M_ScAB4VM1mn3KiCM.IkBMnl5j5buAS__Bk..mT_nbGam4dICJmXr0HhgPKTKRO
 IQ6R_TirlPNJEhmk902u8276t3wxBDp5DUj13hIPfwWERr1_cAcf_.Hz9xySsPCATEKA4h2116gN
 PHhkqGw62KZ7iXa0st89j4BmiMmwxSQ00s_nHZyV1XRyCnDRM9zBn467KNQsqUTn5Z1nm84FK0Wl
 d680UK49bKHfpczzXm6Bk7wOP_uyrLHVtgzccdIsLE17nfSLpesp7i3GUQi1GQO5sL4JLMOnW.dP
 v2vA0wLLHXi_nMnBpth.I7kzV7Y3k9QqS0zEGg3iQPbMfl0XOTnbedMJDhoLo5GD07m49vpeWyIq
 yQ4zFY_3o8Plp3aotmM2aw75wyG03oxwQylDPpoBtXGj19lnEIT39xCaJc5AbcW0X.KT5VhmSS8a
 FNnktxy5l0gcBapRNKeqT8d7rCHPQWi35oVcWy3M2QsN4_3SokdFTtCwVJlaWXM7osKlB6yzpit6
 NX0StyrC2sDZR5AiH4WkNiq44nBptfUm8zmrHRmlhJjhQ7Ms8NnEUcBfFrfTlFKTSUf9pfR.ndSe
 Ju6_brgxsr2yrRrZ_Wh1OgRv2O2TK.5DLFGq6gIiiZ0XROle2uaBTotbZXqLGwdRmvjnm2Fu4a72
 VP.sDojDGRlIj0RG08UWH_tOaMQG7Z6VNi.vhZr1QnNpYTd4yeMK70VcMXHVtuatfslWOqXx7XTt
 7nr4ewm.nUz.zCJnarOF2h.9MYX3DlOdG92EgCT_h.CIcnFhX4ebZK7bcPscdIcYo5tro5e_E7AR
 O9SbvTUbbwomXMM5mZNkHHQ8xJ38c3cr02RghgsnhkIfI94qihcjLtBVifGdCBGFr7gSbdYAA.N0
 oC6WpiM.xxLuEvPws.HovbrkNtGSmyC4vhyXalzp8_NIVNhpSa7vqRrtBOqKXoFt6Ewx.Khn7bhY
 45_jqiyqmpOLsZ_DmhmSZoe4vCoOjmjeCYnF3DHYYQAuKqpppOtu66mpHeA5kGVT0tQXB23hymOC
 SWC0ZdWBhgU9dETYhrwcPjyY2oxtwNCJL0QTfGaqzKnrQwtJFikIbzD_XB0eQF_p40sdXBRpxgwv
 A.VnWpO1fyZGM6S5wLaujfg..QYDG_8Oxv.rTXUjPqPqiyGNGduB4Yq.THPpOZsNRhcIefQg2xSx
 M3rPxxyA5d_vCnPegkcrMf_yhjpqkqgIlRA14l_GUytGX4H_paaOcYHuYM_XrfZSKo1Ct8uaGXQF
 oA14uSU09bTkiR2e9UYcng605EQJHIx5_J6_My0f4LPS0HX6ZYGhPS5mYr5LxCsZKQldvWXNs026
 p7rZqLoXzg86LXNC_8u4EHG._t50GaxsO1CHz41e59pudjdmZ1N1I_cBjAGkbXh_5AO59Kfsc.xF
 cLeL79U84vcL.HytBGdtU2PTQDpgh5lwAyPfIR7iLD52d0ykVTrCG6XA_jAqWOh7Jg6L4NLcbSXr
 fkRnfab7TMWxRjv4tHw5Dghs6nNs955BCw.gB_6MkwWzV9uKvQ.3PRK8r6tdVuvc1iU.DwByYovO
 4OezvRs6gF1FUgwIQ222q5AT009i6SbfYV2griJpmML66eoWS2Jy5wNkF3Hc_xJjx3wpsW87trNR
 vUbROvwackRSCalbdgefamhb5jWSPwPuqNnyCjFFzrJQO2dO2hX.QwFbfNDWPmC0Q22WIB50umxF
 g0rMksPdveaBc2s5qkaRb3KFoAuDeu1MudyD98LTt.XeMV5NjS1g4eAJRfzrNpnEMQw7Ph1kaU.N
 eJg4JqIYv1v6TnIyc5s0TnihF0tAmu8jmsa5MVfz85bL5EpIk1U4rotjCLBQC5E1z.nGnl5HMd_m
 2piVMfLuVNpmD.1AXq2bAYDZb.vgAu_7Ff1ZdiitB_mFtzqmcrAB8Umlf.gFRjcHCfIVCSZ42BCM
 mqDNSVasbkXQitPNAKfnEVoUHwOj3bas0FH5nqdoWz5I0gcaBER4y7_rHgFF06kfLCNu2OMHen28
 CteW4GG4c6VJWoJHN_oda7H4xrHDVY06j5mGqfS6AitCNVsX1M41r6WsmMgVGR2ynCHY3CEWHxr0
 nDfhtDG3vfE_ukpnM4VTW7oq12eBpB7EgdNhDKQ2.epksgSNHvGYuYL8nvV6wtrGz6gmPKlH0muU
 Ffws7_qOOi1VQd_WGVxkoFBrMRlP_trYkHj59xoXMJ1KC2gorr6JlImEvzRsGdA6QSoJFuyK6Ri1
 ibf.WaK_xxjSy8OKSxkfa4JKWdjhbkRXHzYqEJDVs_HE5TgE2fr4gfzSKMCs9di7yfuOzDcCGUju
 8T8R7f5._mOB2yn3.EgfvzSReKf547xd53Mr1MpZiIOq76Rq7culkSHY.j_vcAgB_0xqOJgErb5k
 9HqcEf3_AkwYmu2XApya8G4FORg_Y7CNb59st7qCd18zmAnQ300QvSRA9.5_5GYOB1AIeBOGGhwU
 atZZC07evTl7JSKhvNlJeKzjiPgKyyb_s6zt3STCLK8wESAV5t8SZhGlPzNSKDP1LY47rPhNLuEF
 5tMOxU3.cXLfytQVuWjLoq6095JJNiYvZCojMqteYRzT3x4SMEtExTJtAEAJvFOIjm1jnmFF4YOK
 0TG8d2w5kcENBGgS.jMWSUU7A5qWoL760jF8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Feb 2021 20:05:47 +0000
Received: by smtp417.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 444527ccbe915c822559c4d5fffb56f2;
          Fri, 26 Feb 2021 20:05:41 +0000 (UTC)
Subject: Re: [PATCH] btrfs: fix warning when creating a directory with smack
 enabled
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b31f38f9-21fa-9659-a123-ca20b3e7f782@schaufler-ca.com>
Date:   Fri, 26 Feb 2021 12:05:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/26/2021 9:51 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When we have smack enabled, during the creation of a directory smack may
> attempt to add a "smack transmute" xattr on the inode, which results in
> the following warning and trace:
>
> [  220.732359] ------------[ cut here ]------------
> [  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 start_transaction+0x489/0x4f0
> [  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns (...)
> [  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ #81
> [  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> [  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
> [  220.732447] Code: e9 be fc ff ff (...)
> [  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
> [  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 0000000000000003
> [  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff888177849000
> [  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 0000000000000004
> [  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: ffffffffffffffe2
> [  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff8881680d8000
> [  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knlGS:0000000000000000
> [  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 0000000000370ee0
> [  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  220.732475] Call Trace:
> [  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
> [  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
> [  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
> [  220.732496]  __vfs_setxattr+0x63/0x80
> [  220.732502]  smack_d_instantiate+0x2d3/0x360
> [  220.732507]  security_d_instantiate+0x29/0x40
> [  220.732511]  d_instantiate_new+0x38/0x90
> [  220.732515]  btrfs_mkdir+0x1cf/0x1e0
> [  220.732521]  vfs_mkdir+0x14f/0x200
> [  220.732525]  do_mkdirat+0x6d/0x110
> [  220.732531]  do_syscall_64+0x2d/0x40
> [  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  220.732537] RIP: 0033:0x7f673196ae6b
> [  220.732540] Code: 8b 05 11 (...)
> [  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> [  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f673196ae6b
> [  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3c67a30d
> [  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 0000000000000000
> [  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 0000000000000000
> [  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc3c679ce0
> [  220.732563] irq event stamp: 11029
> [  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] console_unlock+0x486/0x670
> [  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] console_unlock+0xa1/0x670
> [  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
> [  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
> [  220.732577] ---[ end trace 8f958916039daced ]---
>
> This happens because at btrfs_mkdir() we call d_instantiate_new() while
> holding a transaction handle, which results in the following call chain:
>
>   btrfs_mkdir()
>      trans = btrfs_start_transaction(root, 5);
>
>      d_instantiate_new()
>         smack_d_instantiate()
>             __vfs_setxattr()
>                 btrfs_setxattr_trans()
>                    btrfs_start_transaction()
>                       start_transaction()
>                          WARN_ON()
>                            --> a tansaction start has TRANS_EXTWRITERS
>                                set in its type
>                          h->orig_rsv = h->block_rsv
>                          h->block_rsv = NULL
>
>      btrfs_end_transaction(trans)
>
> Besides the warning triggered at start_transaction.c, we set the handle's
> block_rsv to NULL which may cause some surprises later on.
>
> So fix this by making btrfs_setxattr_trans() not start a transaction when
> we already have a handle on one, stored in current->journal_info, and use
> that handle. We are good to use the handle because at btrfs_mkdir() we did
> reserve space for the xattr and the inode item.
>
> Reported-by: Casey Schaufler <casey@schaufler-ca.com>
> Link: https://lore.kernel.org/linux-btrfs/434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This passes the Smack tests.
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Tested-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/btrfs/xattr.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index af6246f36a9e..03135dbb318a 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -229,11 +229,33 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
>  {
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct btrfs_trans_handle *trans;
> +	const bool start_trans = (current->journal_info == NULL);
>  	int ret;
>  
> -	trans = btrfs_start_transaction(root, 2);
> -	if (IS_ERR(trans))
> -		return PTR_ERR(trans);
> +	if (start_trans) {
> +		/*
> +		 * 1 unit for inserting/updating/deleting the xattr
> +		 * 1 unit for the inode item update
> +		 */
> +		trans = btrfs_start_transaction(root, 2);
> +		if (IS_ERR(trans))
> +			return PTR_ERR(trans);
> +	} else {
> +		/*
> +		 * This can happen when smack is enabled and a directory is being
> +		 * created. It happens through d_instantiate_new(), which calls
> +		 * smack_d_instantiate(), which in turn calls __vfs_setxattr() to
> +		 * set the transmute xattr (XATTR_NAME_SMACKTRANSMUTE) on the
> +		 * inode. We have already reserved space for the xattr and inode
> +		 * update at btrfs_mkdir(), so just use the transaction handle.
> +		 * We don't join or start a transaction, as that will reset the
> +		 * block_rsv of the handle and trigger a warning for the start
> +		 * case.
> +		 */
> +		ASSERT(strncmp(name, XATTR_SECURITY_PREFIX,
> +			       XATTR_SECURITY_PREFIX_LEN) == 0);
> +		trans = current->journal_info;
> +	}
>  
>  	ret = btrfs_setxattr(trans, inode, name, value, size, flags);
>  	if (ret)
> @@ -244,7 +266,8 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
>  	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
>  	BUG_ON(ret);
>  out:
> -	btrfs_end_transaction(trans);
> +	if (start_trans)
> +		btrfs_end_transaction(trans);
>  	return ret;
>  }
>  
