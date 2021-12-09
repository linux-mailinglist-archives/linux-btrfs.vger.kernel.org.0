Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D061746E469
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 09:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhLIInb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 03:43:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:34163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhLIInb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 03:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639039183;
        bh=mZ2mNNFQARTfTu/wMe1jwivH6hysUDFWWSUMvPKc+Ac=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BaFY20+Lgs1PV1V/CVkw3lmbYnaWinYuwKGhGGytbgCiEQ9uqmHuuAr+CPsb8mohg
         lxxrHGE7jj/FOOyTew+zG5g85koTpMZvbE/iyK9mtQc8zuaHDS+nprItK7Ler0TatN
         6+nQmQYYdk7BJSIyZiKZHhY3lx0E0Dpgp6WTIvvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1mztvR1CHj-00Vg7f; Thu, 09
 Dec 2021 09:39:43 +0100
Message-ID: <9d299505-a334-b988-2fcd-bc2129207959@gmx.com>
Date:   Thu, 9 Dec 2021 16:39:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: Fix memory leak in __add_inode_ref()
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209065631.124586-1-niejianglei2021@163.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211209065631.124586-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g91V/UPbFzq0vSE8U10kexVzQJn3fLMcvmwIDX9V2qy93MKwt0g
 nZQGQRh8iCPCPqBsguRSs8qP1WVXl4pkRTTOWk+haI34xa7i34OyuLWzhJyFGSc9Nbi1MzP
 fiO/hCFTDdeJkJljfkO+uXv48B732UmZpS6wKwtezA6ZDqBSEAaHfx5PGDFIQJz46M9rytG
 obUbVs0qCCFhl8FTZiO6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:of9nEe/Zr04=:EuKLyzqSjMDASCiQnE2X9V
 a5KuOmBxa6JOPgpnyfcoxH1UOECrZYcXG/Ne+ZOdCAiVSixVUsJNOx1SQmI2/wPXZbKpf7ZF1
 u8IVD6zQ2nOlYojiKO791Pwe1g6ayVwUEake5a9GxUwW+l33DMMzFJkLaN23XAP4xw1xi7r4Y
 eOsXOusWKi+AS/hc9T+5wtZZb7tW0ZbkVQmEbls4loUbdDphB/n+tee8iFvcJsh+nHW0yL9Vy
 yUhCwJs+PkCkPut+Ui7tEEtG9WD/G9tkAaarNnJERI2nPX3y3s2jRVwey2Avd1HquRTB1QqFk
 saZ0uPGN6DhGVEFILnuadn0eIhycUN+peaFCTgjGhGjYWIEvcGoCOP8rjqrOCjOaCbsLfMEnl
 vi4HisfQZm9l3MFHbK27P5cexfLUYwRk4IKB4E0IGm2O42NIcPWJQhDjSxb7k0xR4a8pxPoXJ
 gRK9sM+NC6iKvLJT1PkFMG/7l4opSOEaHuuBSs7XNwn9Tc0/FSKRWjDtBKazPESOFtx565cV1
 5o8rfRI7KC/2UON0OkfxXeAk8t4aCq+cgc9Khzh+obVwRl7yVU/g6y9ashU2D3upmtykOIYzi
 CrMTcBHfGqh2kEQR9mj/CDsNnpFv7CiTyuXeR/l+hELBFChX8NBqXOfabC6XW318o0npjba1X
 eVank/Gn9U1e8kultGEdsLrXscvXVhLzWzzENR89vL3JZoGK55mVcU1kl5ZDcdZlAhFVoAfFU
 dUuvOxH/kZ9FeR2UqbNpas4q1RTH4IKBO8za+c1uwUaKAji+EJQ9FMBOaziGEINFdWOhWXHLp
 LLxe2KcpXwCYmgMZ/mQwenkDWbJMFncCALA1LpkGMCcjw4I973yt5o4F5o+xdBwdjTn83wp1P
 kHbHO5FDqRZU5MI/LfgMzfCH9fv/hehb42Pahi/fKU8oZYOJmCBg15LYse7JYhe6NhIzMguuQ
 rF0ytdpsgl3iIYY5QzGt+Ha1FV7l7vHudaGTSOq+Q+JBS2skVOVs34HzX34jGodDKK2vxc0+Z
 jI0seRT9L0sffyB/Te+WNsUzN7jYuV6FSIiCYHkV+lCR61qN++hqZWkQn37tZNjfv3gA0gYtB
 rHbwMMQ2rgdcRg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/9 14:56, Jianglei Nie wrote:
> Line 1169 (#3) allocates a memory chunk for victim_name by kmalloc(),
> but  when the function returns in line 1184 (#4) victim_name allcoated
> by line 1169 (#3) is not freed, which will lead to a memory leak.
> There is a similar snippet of code in this function as allocating a memo=
ry
> chunk for victim_name in line 1104 (#1) as well as releasing the memory
> in line 1116 (#2).
>
> We should kfree() victim_name when the return value of backref_in_log()
> is less than zero and before the function returns in line 1184 (#4).
>
> 1057 static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
> 1058 				  struct btrfs_root *root,
> 1059 				  struct btrfs_path *path,
> 1060 				  struct btrfs_root *log_root,
> 1061 				  struct btrfs_inode *dir,
> 1062 				  struct btrfs_inode *inode,
> 1063 				  u64 inode_objectid, u64 parent_objectid,
> 1064 				  u64 ref_index, char *name, int namelen,
> 1065 				  int *search_done)
> 1066 {
>
> 1104 	victim_name =3D kmalloc(victim_name_len, GFP_NOFS);
> 	// #1: kmalloc (victim_name-1)
> 1105 	if (!victim_name)
> 1106 		return -ENOMEM;
>
> 1112	ret =3D backref_in_log(log_root, &search_key,
> 1113			parent_objectid, victim_name,
> 1114			victim_name_len);
> 1115	if (ret < 0) {
> 1116		kfree(victim_name); // #2: kfree (victim_name-1)
> 1117		return ret;
> 1118	} else if (!ret) {
>
> 1169 	victim_name =3D kmalloc(victim_name_len, GFP_NOFS);
> 	// #3: kmalloc (victim_name-2)
> 1170 	if (!victim_name)
> 1171 		return -ENOMEM;
>
> 1180 	ret =3D backref_in_log(log_root, &search_key,
> 1181 			parent_objectid, victim_name,
> 1182 			victim_name_len);
> 1183 	if (ret < 0) {
> 1184 		return ret; // #4: missing kfree (victim_name-2)
> 1185 	} else if (!ret) {
>
> 1241 	return 0;
> 1242 }
>
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

BTW, mind to share the way how you exposed the missing kfree()?

Some awesome static analyse tool or just by eyeballing?

Thanks,
Qu
> ---
>   fs/btrfs/tree-log.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8ab33caf016f..d373fec55521 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1181,6 +1181,7 @@ static inline int __add_inode_ref(struct btrfs_tra=
ns_handle *trans,
>   					     parent_objectid, victim_name,
>   					     victim_name_len);
>   			if (ret < 0) {
> +				kfree(victim_name);
>   				return ret;
>   			} else if (!ret) {
>   				ret =3D -ENOENT;
>
