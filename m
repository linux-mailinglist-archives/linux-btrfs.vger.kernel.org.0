Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002CC3EA3EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhHLLlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 07:41:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:59349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236700AbhHLLlp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 07:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628768478;
        bh=U1qX3TpxeG0a3Ol38YslG1Zdv0NsImNb99pcKayvIC0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RNo7+2/RCbNLoQyqYgjHlfGX8qmeLbDToV1xjNPkk3QmLhiZsQRP299Cks/DmT7wE
         ivWnZ9qeQqtvmE1e5AH4rXL9Z8ngbGgPcrYb5Sk/6b1ryv6h2HCVpQRK06XO7W6MEG
         /0R2a57iyNtxO3M9qaPhmDPMuCRJHS6WvCJDkVv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1mGKwP1Rm4-002EUk; Thu, 12
 Aug 2021 13:41:18 +0200
Subject: Re: [PATCH v4] btrfs/177: Handle the different fi resize output
 formats
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com, wqu@suse.com
References: <20210812113048.12720-1-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <55ce7671-c4c4-64e8-58ad-eac8e4fa5061@gmx.com>
Date:   Thu, 12 Aug 2021 19:41:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812113048.12720-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pp57yRFfXYasl2EZPH0xSW3ltbQGnCcZM1PnFf83M6y1XYwSsD4
 vRYM3MWISPoXmtPOyn8UhnjKgGdYLtk8kekXdNOH8v6tZK8k6L42sPdEJ38/8Z65gMh8HCG
 bGCtNCG7sDSJiQlHD7rQ2ufoeDmSFU0T62LRmd5K/WyU1EWSvXZZyi/M5Usr58BgoLeZaaY
 tvVEHIHuoUvq0u4OF24cQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FWTiarHW1ck=:we+qdo2G1oXWi4F7trkcio
 igpYDlVkbiE8JV/VsCSBuA0vFeTU/s4Qe5CS4cfcGj6ZLML+cx5ARnaYdZw2WWU7x8xAqwcw0
 aD4H0rivzcGuYuL2cu8gQRMqnNvCk062vvOkmde4AZPR+1L2T40cw+W/M7hrwA7TjZIJW4bTe
 YNA6IW9zIAVmclxry/aaayywPBVRfO34VbpM33amnDfP7aeoy/A6YmmzcV4dmCGB4hQXs7RsX
 xK7Fg2zp45JwiH3LpeTze5Z3EDjGpl5f3ZMNglxB6CHjqKP6zIjEst3MZXFnlx2Xhkqav9vbg
 lZ7bsfo6M5SjFZSJ2dGL5Mbz5R+pSHauKD+uTsOxCKuBpeHPkO3wWrGC9eA69bhsh/tFXvdnK
 R6EFtrhzoQ5F0f/5GanDCSiX6wWvEnp8lorYiQYm6H13AxTMghE4ki/XH7JpGFf+NmROsDafP
 BcTOPCqnurywpTcw6c3oBSgoX/bxXjZFvbhnxSka9T4nQUXzRAWiromE6700vzJu2VXk9WyI8
 uPbAun6223rEglo9P5ZJ1IqUATW3DMT0LPvMIuCmaRbbvxHy3PcLVdok9AdfP2QRdE4+zrkPf
 6ps+ZRBeXwzoBmfsAzDYzKfCNFb/JpRepds/fXI88HoEZkAERjXSgDYMmLPXemAy//JSE1lT+
 acnS8i9QhP+jgFw3RMjul91pH08mblx3eBqM2FclQUxSRL0XvPZwVqVc0nIdJgIHQIRtFbXUL
 awtaDSGth7FAa+OgsflQtnzJ7aD4CkjTrGrs6LWhCuo5XkiydM+4zkyr6Igmul8WPZJMBX88m
 r4ZhHf9XgKgZRSqAha/yIViTZjWul+1rgri6SGtsXFWELiKMq1N1W2SQP+rI3AU4IIXXSNNAt
 wmwAePbqKw9WN3D7ncnrh0SC553HWWIlfZAOsAVjqiTz5N8di79hDSq3LtPDBoBcPosM74Dfs
 fJMI1YO8pJq/wt9PvIitXGUpirObcZBYphDXgZVRm40LnlYdRyxiZY/o56NW2i5Xp4evqBK+J
 OGbYuCL99x8RrKh5i9XBfFX+UgejctWGVjWtk5l5FT7X92OeyNbnOfbcS1QgGHGdcmoGHbpjT
 XEJe929EwUc+U6w0Z3RyBW5KhJY5WxaqU9JSf4X+UqJhPNhp4XqXjpTAA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8B=E5=8D=887:30, Marcos Paulo de Souza wrote:
> Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
> readable") added the device id of the resized fs along with a pretty
> printed size. Create a new function to simplify the output message using
> size in bytes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Now with the filter limited to this test case, and we have full control
on the resized size, it addressed my biggest concern about the loss of
accuracy during convert.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
>   Changes since v3:
>   * Move the new function outside of the btrfs.filter, since it's meant =
to fix
>     only this problem now. (Qu)
>
>   Changes since v2:
>   * Check the output to verify if the resize really happened (Qu)
>
>   Changes since v1:
>   * Do not adapt the output message to the newer format (Qu)
>
>   tests/btrfs/177     | 33 ++++++++++++++++++++++++++++++---
>   tests/btrfs/177.out |  4 ++--
>   2 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> index 966d29d7..3c206140 100755
> --- a/tests/btrfs/177
> +++ b/tests/btrfs/177
> @@ -16,6 +16,32 @@ _begin_fstest auto quick swap balance
>   _supported_fs btrfs
>   _require_scratch_swapfile
>
> +# Eliminate the differences between the old and new output formats
> +# Old format:
> +# 	Resize 'SCRATCH_MNT' of '1073741824'
> +# New format:
> +# 	Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 1.00GiB
> +# Convert both outputs to:
> +# 	Resized to 1073741824
> +_convert_resize_output()
> +{
> +        local _field
> +        local _val
> +        local _suffix
> +        _field=3D`$AWK_PROG '{print $NF}' | tr -d "'"`
> +        # remove trailing zeroes
> +        _val=3D`echo $_field | $AWK_PROG '{print $1 * 1}'`
> +        # get the first unit char, for example return G in case we have=
 GiB
> +        _suffix=3D`echo $_field | grep -o "[GMB]"`
> +        if [ -z "$_suffix" ]; then
> +                _suffix=3D"B"
> +        fi
> +        _val=3D`echo "$_val$_suffix" | _filter_size_to_bytes`
> +	echo "Resized to $_val"
> +}
> +
> +
> +
>   swapfile=3D"$SCRATCH_MNT/swap"
>
>   _require_scratch_size $((3 * 1024 * 1024)) #kB
> @@ -36,8 +62,8 @@ dd if=3D/dev/zero of=3D"$SCRATCH_MNT/refill" bs=3D4096=
 >> $seqres.full 2>&1
>   # Now add more space and create a swap file. We know that the first $f=
ssize
>   # of the filesystem was used, so the swap file must be in the new part=
 of the
>   # filesystem.
> -$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
> -							_filter_scratch
> +$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" |
> +						_convert_resize_output
>   _format_swapfile "$swapfile" $((32 * 1024 * 1024))
>   swapon "$swapfile"
>
> @@ -55,7 +81,8 @@ $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2=
>&1 | grep -o "Text file b
>   swapoff "$swapfile"
>
>   # It should work again after swapoff.
> -$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scr=
atch
> +$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" |
> +						_convert_resize_output
>
>   status=3D0
>   exit
> diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
> index 63aca0e5..eb374d34 100644
> --- a/tests/btrfs/177.out
> +++ b/tests/btrfs/177.out
> @@ -1,4 +1,4 @@
>   QA output created by 177
> -Resize 'SCRATCH_MNT' of '3221225472'
> +Resized to 3221225472
>   Text file busy
> -Resize 'SCRATCH_MNT' of '1073741824'
> +Resized to 1073741824
>
