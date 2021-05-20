Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92735389AB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 03:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhETBEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 21:04:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:52639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhETBEL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 21:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621472567;
        bh=/r362rrdWjZzEQzGXVrWhUT2zCpYXuI903pedLuh01Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aAHdVV36FeQ2SaYnYMhEeiPYLAUAorgUah7SfHpCv5+dt832MdN36c8lcpWSDVf3+
         SJS+ERn5/t80SK1dyUt9RTh2V3S4scy9azHx5pyk1xWodGoO6hK7V0KXZQFmWYGD0D
         3HbkpdWDmNMaXV/3PixzNsbb0DMaaYhYpayZWn7E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1l8ENp0GMd-00parO; Thu, 20
 May 2021 03:02:46 +0200
Subject: Re: [PATCH 2/2] btrfs: return errors from btrfs_del_csums in
 cleanup_ref_head
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1621435862.git.josef@toxicpanda.com>
 <73314ceb4a87c4a6fc559834235e63f7aae79570.1621435862.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <27ee833d-1430-b533-0aab-3f8f2c6f0bce@gmx.com>
Date:   Thu, 20 May 2021 09:02:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <73314ceb4a87c4a6fc559834235e63f7aae79570.1621435862.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZEopkRi7ap3CCct+W12QLt5ThLdA5QvVTqYEvvPALV4d8R46blV
 ZuERsCDfKxL9M2yBKok+l95gvwQ2bvNeAAoQVpumt7c42jOgaWGoXPnebsDyvoReyMMNVCg
 DzdNcm9NMbuSY63yBwmowqFbLDYpPjVhkNX2euojqU8I4oq/2T1j8oLnLEKZ3u4T31JXYbU
 XfpOF8PTUaLMXxJKUqetw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wgYbMB4lAfM=:HImuIC6P2DK2w1qOfr90hH
 C43XVbayQHNiXVl8h8ArsYYQrppXmLm5yze4VOKRUTw5P4KlrG9VJ3GlRhO47pInVfRWWdiGH
 a9XvkMI9xwm9FIEg2Q25QjjfvRKaBtk68HJkmmsWQQAEALEKPZdq/d8IQ7W9eT9YfjtXHGvOq
 2KuM9IuGUhAiyeU9atJQFlM1qiA7HTO5V4ZlvJ+b8Ev32vazMdVBVYXvSXKyI5UURbJLOSstx
 mztmXdyzCIma3UeIJNNtAxDugGJMQGzGmGkGudB0GnOoozIuvoEEL5flSoCGwxwWIX4Nic7/c
 W8u7a3ZAfjEUEgrI3EBYtCNsCMct5H2AeXEKAutGuuwLMSCtCwYGWA3i/xES3HwOegRL580RV
 VAL2NiZ8yi3Tdx3MynJuEl3GwCL+R67xcfxoTMhxf0QORIYz0490lYl2IpkBcoYfwdvuarpER
 LezwbBIWvEueujMucT5u2pD2a9SAjepiH730yZRhY6SAAhhWdn0Bm46pH74PudYcJ3eMdWN+B
 d21Nx1u2mmFZhLcB6Jm1vxY6pkuBJY4qBdUZCeuA5h/aoxmNMDjCXrp6ml2nhxdRLvU5MUWNl
 YMQ4igKkcYcveZ8dxLWQPuiIVK3AH2g+sPJof7cNmX2uo2ahj4ru/uiXlF2JvbkLGlL8PVzzX
 AV7M+YEsmdWVvgrFZ+WXm5NLdl1DF7ICjQr/oY4OGdMUxPJ3vR+V87ibWnDRjpWED9YTBN9WW
 DFzSP8HmzGe6V5AsfT4UNChYAvU55HZtUDzCVbxZV1nIF5hgKiUy1BzV15qBa6DMs2jvEyF6X
 kyseKR4pmK8+GXQ2jA+D/BhDDIFmT65KzpF7Fb8UqfIH3rI3lDYB0WQp+R9q8XcLdR2cTBUHJ
 HKoabgRVa1X658Qdyz3EWx0ceET0mR3kBphK7jCbMQ2OparbPuQ+AK0tulmLa5maSuzMgDJ7+
 jJHtBl17JbnaBq0NK1uUkuHAadHjEYYyEEby4Dci2iJBpmAPQFAVR8UU4PS4HduohjtKwaA+M
 1A5rkoCGNQzM9UCv7vQwxBT6yvEiHRLtvpHTS2AtKis0TGu9uvZdJJZTSc4p5DIKqDY03riBQ
 Uo+nmEOvwZmnW+wWPYGpS4z6mGKRe/ombtcdXedFr/PrEG35lqUeDIH+Y1l1urPuV8E1UFyo5
 FArlFvir6pSCKNnm+fi4nIyYjTZlOpCDsivI43ZxzY3ipKxlaPjDK9nUDhUxCZdBloVV1LSPn
 Qaow7RA9uucpmMebc
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=8810:52, Josef Bacik wrote:
> We are unconditionally returning 0 in cleanup_ref_head, despite the fact
> that btrfs_del_csums could fail.  We need to return the error so the
> transaction gets aborted properly, fix this by returning ret from
> btrfs_del_csums in cleanup_ref_head.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-tree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b84bbc24ff57..790de24576ac 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1826,7 +1826,7 @@ static int cleanup_ref_head(struct btrfs_trans_han=
dle *trans,
>
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_delayed_ref_root *delayed_refs;
> -	int ret;
> +	int ret =3D 0;
>
>   	delayed_refs =3D &trans->transaction->delayed_refs;
>
> @@ -1868,7 +1868,7 @@ static int cleanup_ref_head(struct btrfs_trans_han=
dle *trans,
>   	trace_run_delayed_ref_head(fs_info, head, 0);
>   	btrfs_delayed_ref_unlock(head);
>   	btrfs_put_delayed_ref_head(head);
> -	return 0;
> +	return ret;
>   }
>
>   static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
>
