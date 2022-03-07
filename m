Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798004CFCCF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiCGL3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiCGL2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:28:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA58B4CD64
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646651325;
        bh=loyVMWbUyFD8g4lIdGo4MOr6eYoY/BZP0tYIDnbqaZI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WxFR1TbDbDeB+6ZWuubrVcFeZIop9eDF6bve9Yd2SqEkHf/Re4fyhOsXKbIUrIUb0
         dVFY2mBAk0ubg/RxQBrP3vnc7HM4DlGiJBtjXmvsS4L9I5WjMTsCf6tjj4pSz/Es4G
         TUjWGGL7uu0nKq2z4GrNwKISFBNQUzBsMZ018+8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mirng-1o3YJV0KPs-00eqaY; Mon, 07
 Mar 2022 12:08:45 +0100
Message-ID: <d1b153bc-7d76-805b-e666-6527e6250d03@gmx.com>
Date:   Mon, 7 Mar 2022 19:08:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: fix qgroup reserve overflow break the qgroup limit
Content-Language: en-US
To:     ethanlien <ethanlien@synology.com>, linux-btrfs@vger.kernel.org
References: <20220307100004.24759-1-ethanlien@synology.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220307100004.24759-1-ethanlien@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aGh6ZWo/ZbaUjv+YAjbIBwXgzcFiyGW0Zi2hX8fYTbjn3WeJi4H
 jCRVNklqLoSTw18fWfs8cx/aog54grY1318PjRFOtKZG1g272oDmZs+gJNuCn8CPQWTEuCA
 8H57WsOdMtdpP+aeN+Y04VLfIVTXSEW7va4KC+6PX06jfnEa7cANBU5hJfUfKETz96RISJI
 ssPvb9wExZzrCGzN+5xMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vjBxZ6hPJxw=:FZb3hklALB/JhRB7tbjZIY
 xSGnWlx3D6rZZF3vCNz7PIUS+A1lLkTJ4EowTbEX27vhntCSiPdsA2JdQjCngR4l0MtALbz2k
 1BP2diTGZXnWvmLaNsVobf6yu7exPVHkXcKgdylyllRfre5m7aTvAJVJ1X4Z+pNWMr8Ew3wFt
 pLRhdLqOnLz9YMJSjgwa3Di+L1RhMrw+/oCEKQ6WWJ2Y/QHtLGcSFZh1Q6i4jeU9aIgRKqluq
 RyfdPpmrcMOU664ZsG80BA6Utn4/qk+pIThyhHzyk2m1tJ+/UshtZVDdMv9XLvYsCvlpXw2UJ
 GrxFR3VnSCgUYDXljvkY4v0hN2wFrTi7NOqtrHje3kXaFweLO70O2kPMgI2tgNDihjBQHnvKf
 Ij18OOi13qJseMWwz4BgCNzwqBOxT7XW5I1Tqy3OLmzG88rBmk/PBduNNhsGxFKMP0Bc4o0q4
 2XmP2SxaZD6IF1k1zzEavGE4/U7EtUGHMqfQAC3Ul1B8SZlPngMfqwof7BWuSIUyDrkFsZqbT
 p8k/AGo4TOhkoBBN2mnWM8TzK0IUWiDw9cI5QSZ3JjCi5Caoi1TWHRc269nH/CUtKUsas3JvR
 NuP1AOF8KL3F5tZSCELfxdrg+FOkUe248OslfYDPlhXQZ5rOu3YvGnowfKDymTU+c1CEVF0tX
 9Oyv/Z7ViXyWYdbOD/mnwjtIGxF+hXi5HQXhQauTNicp14Ryv/+TsIqpI6vCsBrB6TGDCmNip
 jfMRfJm3Oi0/ItbtmaKvRySBMggvzp66FsDs07vRN26+4c1lNQgiXg6szrCH4R05i7VQXAXnD
 yX6IeePek2+E31s/EPsq9co4B0/dci4FwFn09ESG0Vl0AzeV/i+uopzaBcsZhYFWe++7ZMh75
 rcoFGR4mrAq3WOftMZ8/CxyYHmuuWvMYWwJp4YdM84YBko8CJBnFYKL/nqZ3V9GrMnIH8syXU
 +d64IgZn3Y8T59WAoA4CZlwIl+LvEgXch/7kcgFGUL3OhqZnUhyu/p4PnOuZj2a6XLzbqSV2n
 yG8DGeygH5mDC4WgPjjE44dVh71xoo7qaX6nKSYLKvV4TrBydKJGy7lzqCmxOA553cxua9J6m
 a0PBw2t4Z1KbLs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 18:00, ethanlien wrote:
> We use extent_changeset->bytes_changed in qgroup_reserve_data() to recor=
d
> how many bytes we set for EXTENT_QGROUP_RESERVED state. Currently the
> bytes_changed is set as "unsigned int", and it will overflow if we try t=
o
> fallocate a range larger than 4GiB. The result is we reserve less bytes
> and eventually break the qgroup limit.
>
> The following example test script reproduces the problem:
>
>    $ cat qgroup-overflow.sh
>    #!/bin/bash
>
>    DEV=3D/dev/sdj
>    MNT=3D/mnt/sdj
>
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    # Set qgroup limit to 2GiB.
>    btrfs quota enable $MNT
>    btrfs qgroup limit 2G $MNT
>
>    # Try to fallocate a 3GiB file. This should fail.
>    echo
>    echo "Try to fallocate a 3GiB file..."
>    fallocate -l 3G $MNT/3G.file
>
>    # Try to fallocate a 5GiB file.
>    echo
>    echo "Try to fallocate a 5GiB file..."
>    fallocate -l 5G $MNT/5G.file
>
>    # See we break the qgroup limit.
>    echo
>    sync
>    btrfs qgroup show -r $MNT
>
>    umount $MNT
>
> When running the test:
>
>    $ ./qgroup-overflow.sh
>    (...)
>
>    Try to fallocate a 3GiB file...
>    fallocate: fallocate failed: Disk quota exceeded
>
>    Try to fallocate a 5GiB file...
>
>    qgroupid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rfer=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excl=C2=A0=C2=A0=C2=A0=C2=A0 ma=
x_rfer
>    --------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=C2=A0=C2=A0=C2=A0 --=
------
>    0/5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.00G=
iB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.00GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0=
0GiB
>
> Since we have no control of how bytes_changed is used, it's better to
> set it to u64.
>
> Signed-off-by: ethanlien <ethanlien@synology.com>
> ---
>   fs/btrfs/extent_io.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 0399cf8e3c32..151e9da5da2d 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -118,7 +118,7 @@ struct btrfs_bio_ctrl {
>    */
>   struct extent_changeset {
>   	/* How many bytes are set/cleared in this operation */
> -	unsigned int bytes_changed;
> +	u64 bytes_changed;

Oh, falloc...

Unlike regular buffered/direct write, which we use one changeset for
each ordered extent, which can never be larger than 256M.

For fallocate, we use one changeset for the whole range, thus it no
longer respects the 256M per extent limit, and caused the problem.

Nice fix and reproducer.

Feel free to submit the reproducer as a test case in xfstests.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>   	/* Changed ranges */
>   	struct ulist range_changed;
