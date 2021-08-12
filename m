Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE98B3EA104
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhHLIvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:51:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:40693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235044AbhHLIvv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628758284;
        bh=ER1KAMny245+Q0byRbfUY3HfgLcAxx7UHoxo14qPzHQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b3zuLhdzyUh+yVhukgTsPhGfivt7mZhZVeWpDjRCZQqFuoSHDlVhmSntLIcjxbfKy
         WXy+762wtq+1VIIDuLG9IGkRii+Vk6viGrzGNdlJ3zudczotfA1e3L++xs8lt6YBIV
         8o5KyTxbZdAf9wuUiWFx5p4wNZDSyTeL5miA2HNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1mxrqm1vzD-00mJcR; Thu, 12
 Aug 2021 10:51:24 +0200
Subject: Re: [PATCH] btrfs-progs: Improve error handling while loading log
 root
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210812081617.20811-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <32ec4339-35cf-78cf-5f86-97a0f52c98c0@gmx.com>
Date:   Thu, 12 Aug 2021 16:51:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812081617.20811-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oAmG0/0GPfbvz3N6+anicZYQrHukZhRbjiaYTp7b2fjOoABCqQY
 wc3PBOpeyfghskDsgxEZl9HVcsCmHC1hiVqxIl9o6MR0xaS5YXJGj6VQiKtiDVJmARtTi/8
 t5FUa+NPzq6DdW0D/s6uNs0CMBxvd/5emxwV7CFFVrsrWALN61EVia/uk9GpkWPraawKOHn
 smDN/amY/ZXIJLySRhaeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BfrkzxmUd+8=:WVk84iiZkWHo2t9cbIylB4
 B/OA64I3zbD4Ms0LHxPUOWA0agVuuB8aWNb70jJMua6esuPPeWwv9Xo8VyRdMRz0ch7oWE9+A
 4azoLWvA3hX/HDzHfZVxjpIAdzYKb5z4TfgvYJuKJHWly+lLGfwBlZZT2CLI24DkYdG9M5dto
 DzJ8yyX+vsOJTz1+u4EuUzzf/WCfPJ95N8CMzGh7i/hmMykIJhs4m18FDjKU34FO5I3gfATNC
 xh02hV3BnEFSyENwAZinEC9o21T8Hv/bKsTWV9eYHfpxpQQX4aO2v0/fV6AFx3P3l8Uo4JJp8
 YDze6uRI6VKFYixsciOfme3WHRUA5nDNqgoEM7F52SQ4KF75ZJJvP1m4S9/gGgi05ek/mMrUq
 8gGBwOcGOeWFsaneYgaW9tsavb0kjtOeA1AW1FRHM3H8zsr2Mhk9JNNpHJV5UMhOYgEveGPiC
 HzDi3VfQ1IBXaNXsw2FH10pjRpXjfEtiBRPBQlT1lWa2trQJaT3hVonpW2wK0V/vP6LQlNYy9
 69buslV/PV+2gFQRqcxLdSfpNj36noAWEY0Tkeo8Zuu2pHZgV79quF/A/Gg43tBiUGrOdTjEm
 RIhvA9MqLlya184OF90NCjSow0tSK2r6eaGwZcjY+td0SW64g/jHx+6+AK1k7parypG8twmMi
 3Py5Lke2/ZwZwCT79oCUSQBh4w75MSDCVB0jKt5zLqAfi8e91d/Kcl/r1SpbWWBW81O0vv+DW
 V8tSomUpzyHGfY4ofGv1svFcpNy+Or1syxZts4zBr2u2FT90HwIn1BpEVQ8p6LmoqQyFsOYlR
 SteE8soKylPhO3aOuSnpUorf42w8uSyBg7tK9wlikNi9qKMCOvoSdpx4BUWqOhNIMeYthSNV6
 lmCab1PsEsxROjjmBGk/OWJyQHmu5Nd2Js2pFj7m1Ps220DqNj4c8PgiBBYnqn8OG1pTg6j9v
 cNCFUn52FVQ+sUR67JZ9/YSPZJglBXbG8kfxkn+bh0fri2aeaQ9jlGjvD0Ftow6cUZrwvaQvb
 Cz9APAS4kf2j/Hf7mor04zSCM4vQeCXaadHzyIRnSQnYVaYp6Z+tuQwFUw5WYUop4Mt4csCsi
 n9zgfCnNWIoDS2be4Ux7gvYSQJARWVlfura8gfSMcJEsghddfPmIOO0HQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8B=E5=8D=884:16, Nikolay Borisov wrote:
> read_tree_block can return an error due to a variety of reason,
> currently its return value is not being checked when loading the
> log root's node but is directly used in a call to
> extent_buffer_uptodate. This can lead to a crash if read_tree_block
> errored out, since the node won't be a pointer but an error value cast
> to a pointer.
>
> Fix this by properly checking the return value of read_tree_block before
> utilising the value for anything else.
> ---
>   kernel-shared/disk-io.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index cc635152c46d..4b5436254671 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -629,15 +629,14 @@ static int find_and_setup_log_root(struct btrfs_ro=
ot *tree_root,
>
>   	log_root->node =3D read_tree_block(fs_info, blocknr,
>   				     btrfs_super_generation(disk_super) + 1);
> -
> -	fs_info->log_root_tree =3D log_root;
> -
> -	if (!extent_buffer_uptodate(log_root->node)) {
> -		free_extent_buffer(log_root->node);
> +	if (IS_ERR(log_root->node) || !extent_buffer_uptodate(log_root->node))=
 {

extent_buffer_uptodate() already has check for IS_ERROR().

Thus the existing check is already good.

> +		if (!IS_ERR(log_root->node))
> +			free_extent_buffer(log_root->node);

The same for free_extent_buffer();

Thanks,
Qu
>   		free(log_root);
>   		fs_info->log_root_tree =3D NULL;
>   		return -EIO;
>   	}
> +	fs_info->log_root_tree =3D log_root;
>
>   	return 0;
>   }
>
