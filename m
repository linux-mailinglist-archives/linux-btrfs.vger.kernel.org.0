Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77B91611EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 13:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBQMUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 07:20:38 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42674 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgBQMUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 07:20:38 -0500
Received: by mail-vs1-f65.google.com with SMTP id b79so10174028vsd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRtfFtJodasSOZkJzfEhzp8q5YPwqoLlezlBGXzTHEs=;
        b=c+lRhEmARPuECub/lHGat+9qCBkxHxnK+MIgzfj47Mv2LUVrarimEWIP4qsBNX5zGH
         Awn8o/VdraJ3g+oGhi8uDi7dv/0TmaxDs+23kk0KVhevt/GDpnjJcNHT3o2zuEddkaDI
         ysdxj1Ss9qqMsCaZOdOv19zqYD4LO05UCP1iPhI5crsyoKYjNEzKWbMNRxsoNFxMG8B7
         cpOdTJVVM50FpeE0Hm3SX5qdRQzsr2n5Kw1+RlAYqEixUFIFoXuIAVn/k3M4TROjyCNw
         t/oe7DhZuN2uZht/dkFKezrQuNCTgT2wLTYrI9GWo15ig6D/5HpL9zi/y9Jb3JWvBVtr
         MlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRtfFtJodasSOZkJzfEhzp8q5YPwqoLlezlBGXzTHEs=;
        b=E8/sZOpMrR7kozLwrOPD/EASTDHO4FM+rTyP1viY5+VVDmIO3fpQUU5WiWtIkoG0nw
         MxmdkjsliwfPdT1g1OCJgcOo7v8ipKZ493sgxac35fwLMgIURYYrdsh76BHZ3CoBDYxb
         pXl1ksrxIJwN5zGxm5pSiZJbqkWBRTiCNhoGXyCLVyjROYRL4dO3sjwmSBICTgRBemLz
         7ISj5GxoQofFUN/ZzLTAMSpn4/am9nUG3SGaKAd9H0MH12VCKf8xwkTGiBcrJKNYuALf
         A71aNab5PE1ZMAXSt6o3d6ZquO0C2BIpSzz2jLfYC8SP51hi1j9tp00Z48IyFGuJaMHK
         mlog==
X-Gm-Message-State: APjAAAUy6Ts417N9kxPgqcyw5Y4fkRsjkzvlq5vDOXtB7gmqhPKnrRYl
        EurgoamsRoqZu0HPkLHDDFrMPozncuIbrautIPctrvXE
X-Google-Smtp-Source: APXvYqyqDIRUlu7GoMZ81YPgUn0cyLYA1iAIrekJBh1zdB3Ih0uPa6SUtNcOPrDPYNKfh1/j6JFbYTBUf4PzjTCzn88=
X-Received: by 2002:a67:ec41:: with SMTP id z1mr8242672vso.197.1581942037143;
 Mon, 17 Feb 2020 04:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20200216211221.31471-1-marcos@mpdesouza.com>
In-Reply-To: <20200216211221.31471-1-marcos@mpdesouza.com>
From:   Su Yue <damenly.su@gmail.com>
Date:   Mon, 17 Feb 2020 20:20:25 +0800
Message-ID: <CABnRu54Wub2+Oa58xK1ui3c+0XHyHBy5Y7oJMnAqyEwsc6p_8Q@mail.gmail.com>
Subject: Re: [PATCH] progs: misc-test: 034: Call "udevmadm settle" before mount
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 5:36 AM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> As seem in this issue[1], this test can fail from time to time. The
> issue happens when a mount is issued before the new device is processed
> by systemd-udevd, as we can see by the og bellow:
>
> [ 2346.028809] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 1 transid 6 /dev/loop10 scanned by systemd-udevd (3418)
> [ 2346.265401] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
> [ 2346.272474] BTRFS info (device loop10): disk space caching is enabled
> [ 2346.277472] BTRFS info (device loop10): has skinny extents
> [ 2346.281840] BTRFS info (device loop10): flagging fs with big metadata feature
> [ 2346.308428] BTRFS error (device loop10): devid 2 uuid cde07de6-db7e-4b34-909e-d3db6e7c0b06 is missing
> [ 2346.315363] BTRFS error (device loop10): failed to read the system array: -2
> [ 2346.329887] BTRFS error (device loop10): open_ctree failed
> failed: mount /dev/loop10 /home/marcos/git/suse/btrfs-progs/tests//mnt
> test failed for case 034-metadata-uuid
> make: *** [Makefile:401: test-misc] Error 1
> [ 2346.666865] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 2 transid 5 /dev/loop11 scanned by systemd-udevd (3422)
> [ 2346.853233] BTRFS: device fsid 1c2debeb-e829-4d6b-84df-aa7c5d246fd5 devid 1 transid 7 /dev/loop6 scanned by systemd-udevd (3418)
>
> A few moments after the test failed systemd-udevd processed the new
> device (registered the new device under btrfs). This can be
> tested by executing a mount after the test failed, resulting in a
> successful mount:
>
> mount /dev/loop10 /mnt
> [ 2398.955254] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
> [ 2398.959416] BTRFS info (device loop10): disk space caching is enabled
> [ 2398.962483] BTRFS info (device loop10): has skinny extents
> [ 2398.965070] BTRFS info (device loop10): flagging fs with big metadata feature
> [ 2399.012617] BTRFS info (device loop10): enabling ssd optimizations
> [ 2399.022375] BTRFS info (device loop10): checking UUID tree
>
> This problem can be avoided is we execute "udevadm settle" before the
> mount is executed.
>
> [1]: https://github.com/kdave/btrfs-progs/issues/192
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Yes, as Nikolay said, your fix in udevd way is more graceful than mine. So

Reviewed-by: Su Yue <Damenly_Su@gmx.com>

> ---
>  tests/misc-tests/034-metadata-uuid/test.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
> index 6ac55b1c..9791285b 100755
> --- a/tests/misc-tests/034-metadata-uuid/test.sh
> +++ b/tests/misc-tests/034-metadata-uuid/test.sh
> @@ -6,6 +6,7 @@ check_prereq mkfs.btrfs
>  check_prereq btrfs
>  check_prereq btrfstune
>  check_prereq btrfs-image
> +check_global_prereq udevadm
>
>  setup_root_helper
>  prepare_test_dev
> @@ -172,6 +173,8 @@ failure_recovery() {
>         loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
>         loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
>
> +       run_check $SUDO_HELPER udevadm settle
> +
>         # Mount and unmount, on trans commit all disks should be consistent
>         run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
>         run_check $SUDO_HELPER umount "$TEST_MNT"
> --
> 2.25.0
>
