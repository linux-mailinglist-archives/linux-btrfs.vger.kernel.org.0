Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977C59CC74
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 01:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiHVXr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiHVXr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 19:47:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F44D4C0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661212040;
        bh=eFsMbbU5d4XwVpbLS0/kdNwm1aQdkh+hbQeTY8Nle0g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fxgKPrSrps5RD8i6u9obClWLqrNV4mnDygi0Yh0rP1QfSX2GjlDrQuckVZJtBJpTu
         8tMGPWijgMWGPtRHs4HNuDDm6eFXfovlZq5J0hsbsxaBQgLy9h9mYWofEY17wdOAae
         u7nHL6pIrT/XPyQn+JuLT2qBIbqSTJGpQse++WmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0JM-1pAeWF1UoS-00kNFd; Tue, 23
 Aug 2022 01:47:20 +0200
Message-ID: <54b0975b-dd84-7ce1-07bd-4e2839735cbd@gmx.com>
Date:   Tue, 23 Aug 2022 07:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] btrfs: fix silent failure when deleting root
 reference
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1661179270.git.fdmanana@suse.com>
 <f070919ec910b3682dd22742151a60f9e4c95cbf.1661179270.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f070919ec910b3682dd22742151a60f9e4c95cbf.1661179270.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TvvSaWWAcNSGsvxH/zxYgjJ/ZQnMNzUXql1N8TP49L2U+USM5lV
 9IZucn9VuaeVXif7nJKUGWiQ0ay+/4smKkk8cZjHSr0LXECgrIH1Nb7Mp1Dl/7aeKB5eIRL
 kDWQPJHKmbwZvsBJIGsmJFTQPmz+DKh1Wbkw6sm9HpnvTW7LE/0QZ/CZGI2njqX0YRBSUfO
 xgVAre3tHR6UAsCr3XC1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5dzxf4XRFhU=:F48HttkJpgYjh9daFPENvE
 UjsI8rIqPnUzmkgT+nJDHmuoBT6uwZ3CqJgpmAi19vi2dO3NMOUo4iUwdpdFhdKvsvc6pStKy
 NIWVzqR8HZuK2Xtp5WtlTpH0OAPDR3JqUhu+ofQOBVYump5+ChiwHTcymnq+5O1GEuZ7EI6Q9
 u9AZloHotMVK1RaXwJmW1z+dlI94JYaTAtSyV9oke2Cm/RTMiokwSyKqvpjYR9HDLlJmtdtWI
 nI8FaYXXSFggqn5gR4qNrB7P1IJVMz1kRrDx7d/K/WycHXknf4e3WmbXhZue3+mYlhbcvKDxz
 iCeLwoflAsSU93XnDllF+qFiRGS/bfYJLuCWo4ZPy/kFTPDWUKIkdu4Sj1U4ppt3GuUSO/gjI
 HGznuFjg6ITMURqgNkmcXq2ptPjtz+qhOoBM8Y5xcXZH/peWCfznfOqfJU3JqHmzW06VtddO6
 /u7PZfpQlr2lMUPmsdy6dJvAehDfofZx68yQoojfwpGPFb8yk8HUr5VlzZm4dSLlsgekpjEBV
 sUt6B3moYgjw/OJE/zuuODR+n+/TNR+y4d/dfF3HFYGFdh45qITFlC0y25/4XrJLUQ0r3Iq3V
 K+LxOlV/pKRDR8VCOdB7WZmdvHoVc64vMUJF4StfgjvrLchD3vJsBu5QNGFrN+R1OcQ7mrfER
 Ah/5MzsuUayoEr7oJwReEojkZBnQ+tDsUiObqiCWdxMWfMmUjo9HxvV6ettcpXUN0+yOVUpDA
 MhNoXS49YxBwQ3bl6CaWZa34F2s2CYLEA1n0V+tNxYzromCrcWFI8m6DmQFefHUQ1DcLFMmvP
 aix/S+MsIAy8al0McwoL2Dp+5+Ep0x0cBycny/hZeGB40p/y02ZB2m3A0Dwx+idZGomDJnDN5
 Ry4MBFKgqLlDmLypL+NFMpq8REg+mP/yCAPJgjgKweS9QDvqW2ULmPbQJ6E2BfB3cNOElx101
 VyvHican+P8+5N6hSZr8RIk5bupCmY3Iyft7qWh3ESkohHuFeAkxqQ2JjS+1rwcDDYi8vtk6K
 j5d9PX21qsgm314gN1EmcR1rr3F0PlTJ/ZUalEcgvpHg3hL+x52gxUFVpIh2yoHz23KQYz+ly
 stygLuMiHU8gxP1ljyE4Ltn9Q/sqjcCY720YS9hnFtVkT63VeSv1Gz8Fg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/22 22:47, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_del_root_ref(), if btrfs_search_slot() returns an error, we end
> up returning from the function with a value of 0 (success). This happens
> because the function returns the value stored in the variable 'err', whi=
ch
> is 0, while the error value we got from btrfs_search_slot() is stored in
> the 'ret' variable.
>
> So fix it by setting 'err' with the error value.
>
> Fixes: 8289ed9f93bef2 ("btrfs: replace the BUG_ON in btrfs_del_root_ref =
with proper error handling")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for catching this,
Qu
> ---
>   fs/btrfs/root-tree.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index a64b26b16904..d647cb2938c0 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -349,9 +349,10 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *t=
rans, u64 root_id,
>   	key.offset =3D ref_id;
>   again:
>   	ret =3D btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		err =3D ret;
>   		goto out;
> -	if (ret =3D=3D 0) {

Just a small nitpick here, since above if (ret < 0) branch will call
"goto out", we don't need the "else" branch.
The old "if (ret =3D=3D 0) {" should be good enough.

Thanks,
Qu

> +	} else if (ret =3D=3D 0) {
>   		leaf =3D path->nodes[0];
>   		ref =3D btrfs_item_ptr(leaf, path->slots[0],
>   				     struct btrfs_root_ref);
