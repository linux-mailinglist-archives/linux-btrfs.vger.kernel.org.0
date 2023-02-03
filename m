Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23823688BAC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 01:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjBCAVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 19:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBCAVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 19:21:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D46F751
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 16:21:35 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1oUGrW0wrG-00usKM; Fri, 03
 Feb 2023 01:21:28 +0100
Message-ID: <82bbadba-e57a-912a-fca8-73fd65bca2f4@gmx.com>
Date:   Fri, 3 Feb 2023 08:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] btrfs-progs: receive: fix a corruption when decompressing
 zstd extents
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <556529ebcca0b5404ef0ce284d5ecccd2e2ae660.1675353238.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <556529ebcca0b5404ef0ce284d5ecccd2e2ae660.1675353238.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WSZY0vRT/vgaI1txqQ3hyCtlG0yPfit7NnDXj0CbM/PdXcmHwrl
 bN4NTC1kRu05PC9tzufXHR9r3yT/fMxsBKyIMnwCCDg/PyvJrs/jhCGI9GIuq/eQKD9nCZl
 Ug4hQzntTY2LP4aU/JmFqtCKweApl4ty4zYB10Scs4aqEbtY6H6YaVpWUtpsY0PD3AK4cqu
 Nq4O21o+GVw01Zek73xqw==
UI-OutboundReport: notjunk:1;M01:P0:TfgvCjkY8nk=;TTH8+8Rx0bvC0bJl4a34yYqONZe
 5ixN/j+rANWZuFZTs5EmFZ9XNUe+6Atw7QLcbyGBr3hpc19mrEArfWNbCa8MgD92YGHqG3rwP
 WHvtAWKeee8ilTdp9pT7VUkQTV+DXB4ih3+cR+hkBVEgyfw+cFo+Vl4dEkciTnsHGF8Q5TOCy
 G/7Frh7MwEiL3ILPhwJwjcqt1bQXNI9Yivl8uJICxf/nD+p0zm9T2vyl+akHaZnX4DsBi2aVP
 xBY4mwIbBKTygAim7KFdqn6lFzqf0msy5nLdaWvywQw9BdtZvcI4MqF9w4GrhsP59DwGFbzdb
 fvJYL4w1ebhwR1ho9AIqym7l6g+T6n4gFsJZJlRz4bD+qQzjtxmh+2XOREh9g6FptGDcQp71v
 0pjD1ghfiWcHOpT7ingoxTAXDXRIzyepnAPKnAdZUyMzHj3Xs4vyrfmPAwd38zYh8trH+vOQ9
 RlxTjohgL6fzcP6PmVNEhRz67Au+EFfJCSfGu/UDa+Sg1PPe7ERWNH/FzEWFUUtrdiaDSfORw
 8AhYPR87BZrwQY+exeLJHONI/ECWtktrzZzhv4BgrgDeqUhJJ9yCtUOHwRUM6ViWub3I97ZGX
 3TenoZ7EjRHIuzCn8zXUG5YceGDUxtKsHE5xr5/3LexVgPEUcAYCkbWQj88Oei8TgKr/B0ZrF
 /lPqCgcWnyhaQm+54KoDc5/6J/jW9aSenHsiGE8IjfmiHbFsKcPVbilxH3srabDAaZt8hDKoy
 N3d77ZO44eX7uhvvxoQw8pijlPvJBafGEF2dAzAbflr8AajHMuKgd4rBvv5OFjAXZyDbEMv1J
 FUf9REwfxSOVuPW7+KdVOI+LSlOAGOc5QSawGnaC55uw4hOb2xLA5oc1L2ifQR8VvtZUuLC4X
 kYEJfpRoInfMhHWHhSiW9CiO46OOgfCE0bb6Tr09LTdcOsQ4pkxKGl4Kn6FHG7D0x3bSxrYHg
 1TXEQENZtuTamRn7/ceQRkh5Nyo=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/2 23:59, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Before decompressing, we zero out the content of the entire output buffer,
> so that we don't get any garbage after the last byte of data. We do this
> for all compression algorithms. However zstd, at least with libzstd 1.5.2
> on Debian (version 1.5.2+dfsg-1), the decompression routine can end up
> touching the content of the output buffer beyond the last valid byte of
> decompressed data, resulting in a corruption.

I'm wondering if this is a bug in the zstd implementation, or it's a 
documented behavior?

As to me, the behavior of touching things beyond the decompressed size 
is very anti-instinct.

Thus if it's the former case, we need to report this to zstd guys.

Otherwise this looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Example reproducer:
> 
>     $ cat test.sh
>     #!/bin/bash
> 
>     DEV=/dev/sdj
>     MNT=/mnt/sdj
> 
>     rm -f /tmp/send.stream
> 
>     umount $DEV &> /dev/null
>     mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
>     mount -o compress=zstd $DEV $MNT
> 
>     # File foo is not sector size aligned, 127K.
>     xfs_io -f -c "pwrite -S 0xab 0 3" \
>               -c "pwrite -S 0xcd 3 130042" \
>               -c "pwrite -S 0xef 130045 3" $MNT/foo
> 
>     # Now do an fallocate that increases the size of foo from 127K to 128K.
>     xfs_io -c "falloc 0 128K " $MNT/foo
> 
>     btrfs subvolume snapshot -r $MNT $MNT/snap
> 
>     btrfs send --compressed-data -f /tmp/send.stream $MNT/snap
> 
>     echo -e "\nFile data in the original filesystem:\n"
>     od -A d -t x1 $MNT/snap/foo
> 
>     umount $MNT
>     mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
>     mount $DEV $MNT
> 
>     btrfs receive --force-decompress -f /tmp/send.stream $MNT
> 
>     echo -e "\nFile data in the new filesystem:\n"
>     od -A d -t x1 $MNT/snap/foo
> 
>     umount $MNT
> 
> Running the reproducer gives:
> 
>     $ ./test.sh
>     (...)
>     File data in the original filesystem:
> 
>     0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
>     0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>     *
>     0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
>     0130048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     *
>     0131072
>     At subvol snap
> 
>     File data in the new filesystem:
> 
>     0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
>     0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>     *
>     0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
>     0130048 cd cd cd cd 00 00 00 00 00 00 00 00 00 00 00 00
>     0130064 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     *
>     0131072
> 
> The are 4 bytes with a value of 0xcd instead of 0x00, at file offset
> 127K (130048).
> 
> Fix this by explicitly zeroing out the part of the output buffer that was
> not used after decompressing with zstd.
> 
> The decompression of compressed extents, sent when using the send v2
> stream, happens in the following cases:
> 
> 1) By explicitly passing --force-decompress to the receive command, as in
>     the reproducer above;
> 
> 2) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOTTY, meaning
>     the kernel on the receiving side is old and does not implement that
>     ioctl;
> 
> 3) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOSPC;
> 
> 4) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -EINVAL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   cmds/receive.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index a016fe4e..1d623ae3 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1080,6 +1080,15 @@ static int decompress_zstd(struct btrfs_receive *rctx, const char *encoded_buf,
>   			return -EIO;
>   		}
>   	}
> +
> +	/*
> +	 * Zero out the unused part of the output buffer.
> +	 * At least with zstd 1.5.2, the decompression can leave some garbage
> +	 * at/beyond the offset out_buf.pos.
> +	 */
> +	if (out_buf.pos < out_buf.size)
> +		memset(unencoded_buf + out_buf.pos, 0, out_buf.size - out_buf.pos);
> +
>   	return 0;
>   }
>   #endif
