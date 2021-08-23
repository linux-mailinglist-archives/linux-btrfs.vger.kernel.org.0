Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39493F46C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 10:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhHWIoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 04:44:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:33319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhHWIoL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629708205;
        bh=Qm/nvh6R002WgiFNnGCt8Dx2lKieptOV/OsIwFr8u14=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NnPYV0lqNFk3aAxG4L/E3LnPNsIslOOT8bjMGIxcMT7pXulwh/tUB6BBYh+g5TCRM
         Nv5G9y+GkNSdCq3JFs1JbzjZOXhBoNM4g237y7tgVEgBMf6zMbDaYSr1tzhOxG86h3
         ExbSNPaXk3n+vUrUxwpMgwApj9PkQgkvJgzkFe0c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1n41Ec1kws-014lHh; Mon, 23
 Aug 2021 10:43:25 +0200
Subject: Re: [PATCH 2/9] btrfs-progs: use blocks_nr to determine the super
 used bytes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <1d73b314e14e03f4fe7a70475822f534fd5914e4.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2c871503-2787-e0ec-0a55-8fb9c44e32cd@gmx.com>
Date:   Mon, 23 Aug 2021 16:43:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1d73b314e14e03f4fe7a70475822f534fd5914e4.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sFPRpSxLWJudsBRtfB8RpnP0osKj0+nv9CLtYttMSZkQre9wrTy
 vZuTf9L3psijXk/1dVmXwayrVQbQpIZhuVlCohP1uvC8oIKTn3JaE8baaYeBx4mz/A+Egbw
 NZhy4DZOqcL7xStbpmVkbqXbK9QS8OwmsGGwG0ezEbDqVQbV5jZ4Uq9lpXh5GtxnuNmTAwH
 YgiQfEtNc1A7o7MIOHBtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oWue2n0sMJ4=:VCYzS0QmQApoRQRwYRd6zL
 5K/dYFV9f5Tv/bybsANPNnO4P0F0IxDPISzBSZ8G//qEvioT204X73JQVKuDuSAI7UR0yBctu
 YJ5q8ZL2R15RdZvvVWXicI8MLD93QfspQ1D6qDEV7Frzl2PJuu9Qt9x/4wvCpF9qQptVmhcpw
 He865a5oUVJEV2at48jLTSlh9uZxRfaPTxrg8M6TkBHFadmHAALhlhu7ZDEtnal/PAzkHKdRP
 6HWEMOJobp1MTrWHLCuOV/zN+8HO6mpLfMtx5eZjsAgHvDLxmgTxu/uPejHcRRX4UICGiEHFw
 93ELD+e6wkl6KWBRxe3lu5mAhZqdhWQOJBGgcuyIOf/7izJTAfMqUF0X3XZCvEfg9/WjH6csA
 MkoDtU9sT/ykiyJ+C6vWs6dqTB5S8GekMA7w/gm22lX6DyuXkvpBazUkW6kTUjH7Zi3Mt1+yK
 TNOvtmdM20UixpvMPF1dI4vGKRJYJpstP8N8VN4MCiRItwbqi0o7NuMK5QLIrtnhpKEEcHLnk
 BVNKN7jr/DXCyPsvAux/bK88LOcZWM5uNOat+LusMlsOmwW4NzH83TAzYMejeGXhGT6QqV51e
 fLeD40Arna71yuH3/E075IRy9P1wvC3oDtnDyhzDPxBtizg8IEkqEKsRLJEpP9AeZ2YY6B28E
 e4f/UcT2Av4FhJMF/NKUEm0Fjrfc0WFBxQTUiRMdaJN0oiVwA1wwUOnARYt0T3jFEjrprtfo1
 wtvyCZnnYJahkAfESb2FhCnt7CO4vGg74xOUw/oEb74+AFHdA9xeAJSUoNQEJdyWoJK/gIcJU
 vWvcjUKbuoFlii7scjIkibF5F2jEKXXSx6mVUgLhRnPP45nscrmfDMyatQ/x2G2Xvt2Ltl7A7
 RpbIE7guBYnxJaNLhH1pE4pGdzVKwr1qqzfK3uWDl9VrLIK76v6OjLdV5wJ+0LEH8CBv5vxUD
 E24hOdNIk8s/0CJvYEkWWOPi7255ioudRY65aBbC+wOMUU+dX+o0c4tumM2osaS7RwCgq5W/6
 PoShWLxWXPyWW11lqg9lghwSd14IqPBNFSOU7l1C5XgE2C94NEyIUiddSg2IHBg4R56FRsrYA
 RRyXteNpTj/o77g5Qe2Hrk3kvFpIyjgG9LCLZKz4P/glGWNUD8AlXDaag==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> We were setting the superblock's used bytes to a static number.  However
> the number of blocks we have to write has the correct used size, so just
> add up the total number of blocks we're allocating as we determine their
> offsets.  This value will be used later which is why I'm calculating it
> this way instead of doing the math to set the bytes_super specifically.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Getting rid of an hardcoded immediate number is always a good thing.

Thanks,
Qu
> ---
>   mkfs/common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index e9ff529a..8902d39e 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -162,6 +162,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   	u64 ref_root;
>   	u32 array_size;
>   	u32 item_size;
> +	u64 total_used =3D 0;
>   	int skinny_metadata =3D !!(cfg->features &
>   				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
>   	u64 num_bytes;
> @@ -207,6 +208,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   		if (blk =3D=3D MKFS_SUPER_BLOCK)
>   			continue;
>   		cfg->blocks[blk] =3D system_group_offset + cfg->nodesize * i;
> +		total_used +=3D cfg->nodesize;
>   	}
>
>   	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
> @@ -216,7 +218,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   	btrfs_set_super_root(&super, cfg->blocks[MKFS_ROOT_TREE]);
>   	btrfs_set_super_chunk_root(&super, cfg->blocks[MKFS_CHUNK_TREE]);
>   	btrfs_set_super_total_bytes(&super, num_bytes);
> -	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
> +	btrfs_set_super_bytes_used(&super, total_used);
>   	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
>   	super.__unused_leafsize =3D cpu_to_le32(cfg->nodesize);
>   	btrfs_set_super_nodesize(&super, cfg->nodesize);
>
