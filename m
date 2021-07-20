Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA83D05EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhGTXQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 19:16:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:43925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232327AbhGTXQs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 19:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626825439;
        bh=w8AoaP4F8sZuscioB4RSw5Qd1MjkvK15dNs1r2fxIho=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FTKVuEWVrgcp9YDtNAFrBQ9DmjX2YhuBsTa529QUlrAFzrrp2tid8iCaXjhIeQrVw
         noT6VTbMu4j6JKjuiG+XoEnV6O2G0EAEXZCl3EgyBcRjS0rQ3idQJsThcq9Rx4iIUG
         /kE4S+z0QOkaP+ZIVuzEAGwL1VjCFBJnsY0FcW+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNh7-1lSptp1EpL-00hsmH; Wed, 21
 Jul 2021 01:57:18 +0200
Subject: Re: [PATCH] btrfs: continue readahead of siblings even if target node
 is in memory
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <1589fffc3a30631b2268b4f64e55fcf9ce664fb6.1626792325.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8fa1476b-e8fb-d4b2-d841-7add2abe2f4d@gmx.com>
Date:   Wed, 21 Jul 2021 07:57:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1589fffc3a30631b2268b4f64e55fcf9ce664fb6.1626792325.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GJ9AHlNLbZ0Z70PFCzyQGrhqMURDe3WmqWWD6vBkuJZ48wIlKVr
 THYQgj8ECtdWrV3G9rK9H8FWlaAS+u5avf1THLrFy3I2y7hl0SdHFZ1jsjn/xATxYxSTyPc
 p2lmCGIZ0NUlQzfHSy7Ws6yL66Rtgg3Mck7+wxnOgqeaySh0dNuTuae84zNyaed9kr15Xi9
 MeMLTfmU32XQbKySDs68w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kKnpu3DV0Ow=:ovoqAlzpY3sfH+4+0gCIKr
 1uTFhISXIL5vavY/Dnhpk5LEzXQMUgi1a3B0ECPTca/h/hGw2CP7fY2TkpAa7xYEXXB6Ea29B
 2AwvpDsEiRF9eGAACEfNe0Vawaf4OdVPLaEW6JG8AbfWhSNC4mq7v7w5pacBYaqV/Dj0SZmZ5
 JHguANLJuZEbytTNYttgX41jLIUv1x/M+hHcSgkcAWIZzetN2brLMWKwuMp/87hlb+FzlNxwG
 x4AkTw2g0KqPyzslR+GGWv17dLcQqBp6EtjKkjj1eiEzKl2kBF45wRHKYRwBUO1IYTybArIOj
 1x+JnToa7onyYgY79qzuryi5hbnW22yV9A7a2TGSrhL15oqnz6AwcpMta0vtmoFBdCVKzHQ6R
 E5w0Lwsz/6AqRwXpr4ILi/X7ZqBPROIa7yDmOk+rbj+EffToqAh7QM37sWFCFbaiNHrVy9qcp
 kJYrLXsmDB3kcwH0OHbnS2c6gr4FCjr+6NJgPLY4gWrloDImCAgJ5mKLymvLS9v1dRMXJyJqz
 v0dSuSQ+yWlDu22d9iBzI3CetUkUDFBN8dVMh75rzAvdCQYuUhlQ7FUxrh731r43JRp8kZnD6
 D650DMrFBHaK5YQfWIaYmJs5O8dRJguvQgjEOjIGbXO8kHAeuEPwPECWsEDVEzGDJiwDwmmhN
 BpxXYtgM1DV0SZVQSPOuzPga13/afJo8uK6jwv98t3WVMN9n7Tgbv6ailVn7qgNcIJNpTbWFj
 C3Maw1OBYYeoHOpkglnJLH2DjmLRL4nCojWhXfR1cwbEQ8k6XDZW9C36Yt3yOix+1CGvUp782
 nCb22pYHYrtHBd8RngYQ2IpkbQQfvfsTc0/IRyDEgFB/boNQXV3a6/SJzjUSZmIr7JPYatgrV
 iALSSUb+wfTCCfJr0wtVzKM54gZoGmvPMkA/spWQLFWhbHModyrOffsBksgLApxeqHhD6/PnF
 EKdSabPgI9KZZwvvjViCyfUwzRHwpI+Q2fEccZQsubdQ+shW9zeINsWdIn7ecEXlurI8dwvSK
 DhdYfLxqj2GjMDnAjvmWun16607HuB6tYGI801K+9McVKkmp6IlJLPJ2WDpj/JVl3Ib9FR5tX
 7UhgSseO3z7a5zhXW+j9sLqvVuz8/XLF1oyTS6UyZ5ajtyTsBABw6iWrA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=8811:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At reada_for_search(), when attempting to readahead a node or leaf's
> siblings, we skip the readahead of the siblings if the node/leaf is
> already in memory. That is probably fine for the READA_FORWARD and
> READA_BACK readahead types, as they are used on contextes where we
> end up reading some consecutive leaves, but usually not the whole btree.
>
> However for a READA_FORWARD_ALWAYS mode, currently only used for full
> send operations, it does not make sense to skip the readahead if the
> target node or leaf is already loaded in memory, since we know the calle=
r
> is visiting every node and leaf of the btree in ascending order.
>
> So change the behaviour to not skip the readahead when the target node i=
s
> already in memory and the readahead mode is READA_FORWARD_ALWAYS.
>
> The following test script was used to measure the improvement on a box
> using an average, consumer grade, spinning disk, with 32GiB of RAM and
> using a non-debug kernel config (Debian's default config).
>
>    $ cat test.sh
>    #!/bin/bash
>
>    DEV=3D/dev/sdj
>    MNT=3D/mnt/sdj
>    MKFS_OPTIONS=3D"--nodesize 16384"     # default, just to be explicit
>    MOUNT_OPTIONS=3D"-o max_inline=3D2048"  # default, just to be explici=
t
>
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
>    mount $MOUNT_OPTIONS $DEV $MNT
>
>    # Create files with inline data to make it easier and faster to creat=
e
>    # large btrees.
>    add_files()
>    {
>        local total=3D$1
>        local start_offset=3D$2
>        local number_jobs=3D$3
>        local total_per_job=3D$(($total / $number_jobs))
>
>        echo "Creating $total new files using $number_jobs jobs"
>        for ((n =3D 0; n < $number_jobs; n++)); do
>            (
>                local start_num=3D$(($start_offset + $n * $total_per_job)=
)
>                for ((i =3D 1; i <=3D $total_per_job; i++)); do
>                    local file_num=3D$((start_num + $i))
>                    local file_path=3D"$MNT/file_${file_num}"
>                    xfs_io -f -c "pwrite -S 0xab 0 2000" $file_path > /de=
v/null
>                    if [ $? -ne 0 ]; then
>                        echo "Failed creating file $file_path"
>                        break
>                    fi
>                done
>            ) &
>            worker_pids[$n]=3D$!
>        done
>
>        wait ${worker_pids[@]}
>
>        sync
>        echo
>        echo "btree node/leaf count: $(btrfs inspect-internal dump-tree -=
t 5 $DEV | egrep '^(node|leaf) ' | wc -l)"
>    }
>
>    file_count=3D2000000
>    add_files $file_count 0 4
>
>    echo
>    echo "Creating snapshot..."
>    btrfs subvolume snapshot -r $MNT $MNT/snap1
>
>    umount $MNT
>
>    echo 3 > /proc/sys/vm/drop_caches
>    blockdev --flushbufs $DEV &> /dev/null
>    hdparm -F $DEV &> /dev/null
>
>    mount $MOUNT_OPTIONS $DEV $MNT
>
>    echo
>    echo "Testing full send..."
>    start=3D$(date +%s)
>    btrfs send $MNT/snap1 > /dev/null
>    end=3D$(date +%s)
>    echo
>    echo "Full send took $((end - start)) seconds"
>
>    umount $MNT
>
> The duration of the full send operations, in seconds, were the following=
:
>
> Before this change:  85 seconds
> After this change:   76 seconds (-11.2%)
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one off-topic idea inlined below:

> ---
>   fs/btrfs/ctree.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index c212f1218fdd..63c026495193 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1233,7 +1233,6 @@ static void reada_for_search(struct btrfs_fs_info =
*fs_info,
>   	u64 target;
>   	u64 nread =3D 0;
>   	u64 nread_max;
> -	struct extent_buffer *eb;
>   	u32 nr;
>   	u32 blocksize;
>   	u32 nscan =3D 0;
> @@ -1262,10 +1261,14 @@ static void reada_for_search(struct btrfs_fs_inf=
o *fs_info,
>
>   	search =3D btrfs_node_blockptr(node, slot);
>   	blocksize =3D fs_info->nodesize;
> -	eb =3D find_extent_buffer(fs_info, search);
> -	if (eb) {
> -		free_extent_buffer(eb);
> -		return;
> +	if (path->reada !=3D READA_FORWARD_ALWAYS) {

Currently only send uses this flag, but could it be applied to more call
sites like full device scrub?

Thanks,
Qu
> +		struct extent_buffer *eb;
> +
> +		eb =3D find_extent_buffer(fs_info, search);
> +		if (eb) {
> +			free_extent_buffer(eb);
> +			return;
> +		}
>   	}
>
>   	target =3D search;
>
