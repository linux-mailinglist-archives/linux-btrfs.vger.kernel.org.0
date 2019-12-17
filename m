Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC3E122526
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 08:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLQHEg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 02:04:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:48241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfLQHEg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 02:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576566271;
        bh=uqUzQwJUBXh26452ShERIZTp4UxpkKQquaiO0WkC6P4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ksbDTv37XQXJRn1ZBbJ8Ip5QxiLkh2gqRt6Hv/5pFVlcQQ8ZxAf2a26M6rAle798k
         NaSkm4eLuJpNTimwsNoyvYghl2a8Vp0VRHYa4D04ilnOers88sJipy+A4a46oYW4lm
         sKYtb76CV3OBRBym0SfRJdyT7aIvyyzjx/+I1zAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.178] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY68d-1iBLvM3afN-00YQJh; Tue, 17
 Dec 2019 08:04:30 +0100
Subject: Re: [PATCH] btrfs: Fix bad comment on disk_bytenr of
 btrfs_file_extent_item
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191217064839.5724-1-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <f41c0df1-3c64-4666-6fb5-9fb0501ada87@gmx.com>
Date:   Tue, 17 Dec 2019 15:04:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217064839.5724-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0aYwdMs5csD2aLBYbyO0tagIAHGcdboe7P0FPwZJfKtPdHAmFnB
 zBiiYaGLow/L4kMw7uD/EjGuYvzKj1H8VJdf/xmF+/H+ZyZneY36ZnHHG7DQfwZLnHUeFo0
 FKpIv7opYxzz7wF4PUCcCzBzbr8vbJLfmkOIzB+2cS+jcWBNsgWRQlPSBBltEdnl8AOYA+X
 /ixzbWucIfWhd6j/4jWWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kI781/yjcZo=:oxY2WsZTfM6NcpHJMYVxw5
 eq3G/ehd4CdfKneaIq3d6KCZ3gyS+76nMmTxNTDx56rh4Fv+sBF9WrsLgnzQ+ZcURn7qTVmlr
 geeI4K6VVenKDrGPpbRAtbtKOepCt0RwMGyZMNMwAMgGs/dkWk/gppyzOm5t3qiMrkgx1gUoH
 nxIl4Oxg7eg5s9wCBbNS+rEfS2LBo45ic7fiMCEhtsxIVJ1gJCNtCCxOXow4c798wHHPWUJTC
 9dhP5LHf4x3OdsGVUBTWRU8/7U0KCklCln6fuxDf4R7PClNMMZJp+Kw72oAiQs2WYUPzhGRO5
 A7FMzXzJP5rypEvyIIc2Wtonn/7aZHPD9QV9RkpwQkohnx5OMNh4ay0hEvIRC+a9A/x+k4eq7
 UhQRkUMUfLZDv2FVIRnAxg0lRkRVxKt4Kik6kwKE34KQBrxKMlsGM+GOPzcpNE0MTbj/TVXFv
 9Pks7J9Kd3JP031GvLbhtYpXo94Z5RiH7WhlCQTWJJEk0eTEAUOGt2Dr6doPHmEYSb51JiZWP
 qIyQAmkfX8D7Ubn6AJl6jMPSirvPZXDR65odAXgbS+S0WIFafjPxtKv8rloI829g5amH1sFea
 AxGpJnaLVtx6dJ9OvHqiOAuzo14CYYYU0U/LOQiFvyRm992EmOThD5/Ft1xf5IDHVDlioWpxE
 68jA/2Jombq8SzGi/A0Pd0+0iaSzgT52pTYSyzf7RLfuO4moqoa6JjPiouODx/MfTK6i5XqqS
 /Ao7ID1WL90Uhc1VFUyyhXtAXkch266E9kg7SHNX9qsojO22yvZHfbd5Ym2hD4i0dCY1YD8n0
 KKBeaHtyyudTBNguttvVh0kcni06EIsO9gfgpRY+jyDubNPIpDW5Zx59Kl2P7AyRIB10gQXIf
 TlkQg2zQKlosifVXHb7wmWXy6ljKTKgmcqhP4ZPmQaIGaPvr4sC2r5IHuA/NT0Jj4STTzE45Q
 h1HRIJ6mGbHkGPY1h7C1Zqz6YV+J6ukeym/SXxgPzqsmobl4Dro0NSBCJkydcIrf/jZLKz/K+
 0QhVO+RP6mVX8Qi+3EFA49lKxPPqkpaGymYheRQJ6iWppj9cBBjrzwX/OVubTq6TgfcvuGjqX
 FFNubId4Hhx8/AsYuRmkFHyIXsytVk79SIbfx4RSuQ1Redq2D/qZCIvyukVt2nHbX6bi0TmA/
 4pCpu3E4V+xenK8vgSVuVUTHoVoMMQB2ahPueZbqFV6h5BgXRUwXRl3G7uXT8lreBIP25U99A
 hQv2+PLXC7RCMc7CgPGfTmbCLWXtNo4fVRswOd0M/q+scTdwurFrRcYOppsM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/17 2:48 PM, Qu Wenruo wrote:
> All btrfs_file_extent_item members don't take checksum size into
> consideration.
>
> This bad comment looks like from early days where inlined data checksum
> (checksum is stored along with data) is being considered.
> But the reality is, we never support inlined data checksum since btrfs
> is mainlined.
>
> Remove this dead comment, add a new comment explaining how data checksum=
 is
> stored, and remove the unnecessary data csum reference.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Su Yue <Damenly_Su@gmx.com>
> ---
>   include/uapi/linux/btrfs_tree.h | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index 8e322e2c7e78..bfe6f38031a3 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -776,15 +776,16 @@ struct btrfs_file_extent_item {
>   	__u8 type;
>
>   	/*
> -	 * disk space consumed by the extent, checksum blocks are included
> -	 * in these numbers
> +	 * disk space consumed by the data extent.
> +	 * Checksum is stored in csum tree, thus no bytenr/length takes
> +	 * csum into consideration.
>   	 *
>   	 * At this offset in the structure, the inline extent data start.
>   	 */
>   	__le64 disk_bytenr;
>   	__le64 disk_num_bytes;
>   	/*
> -	 * the logical offset in file blocks (no csums)
> +	 * the logical offset in file blocks
>   	 * this extent record is for.  This allows a file extent to point
>   	 * into the middle of an existing extent on disk, sharing it
>   	 * between two snapshots (useful if some bytes in the middle of the
> @@ -792,8 +793,8 @@ struct btrfs_file_extent_item {
>   	 */
>   	__le64 offset;
>   	/*
> -	 * the logical number of file blocks (no csums included).  This
> -	 * always reflects the size uncompressed and without encoding.
> +	 * the logical number of file blocks.  This always reflects the size
> +	 * uncompressed and without encoding.
>   	 */
>   	__le64 num_bytes;
>
>

