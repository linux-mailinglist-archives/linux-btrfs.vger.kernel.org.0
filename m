Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E13626FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbhDPRix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 13:38:53 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51659 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235805AbhDPRiu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 13:38:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 714F1165C;
        Fri, 16 Apr 2021 13:38:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Apr 2021 13:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5I2tupER/2x44dNC7V86qfvQbgt
        ktgTV2eGdPEMP4Y8=; b=Drf4dP61W0BCffo9DHhV5mZE5wGsDi5Ayiw+URnt9LT
        Woe0TZUiJMCNzUKBws+/zSF6lW3Gz1k07sojR1x3i0N/YZ8wJ15sjprUfOSaEtEg
        joIT0eDqOhaoTeE0h9mvvF6P7erXav434OBOEGuATPGXkxMe6Ix4I7RYcKGuFJz9
        2jydzCgzqElimtdeWKtSGmNH2Dwv+6nn/ATxpunWlL20l2qMVZCZoEjD0kDtGIWz
        s8jPucJw/8RB1Jwvu8Ai0dq2Lxb7772YbyvrESFpXa4tb1dN0iSeEuSDvURUg9VS
        8XtmmzQXwM7IwV14ytxJFoHp4S5gm08tfWA6Myn3x6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5I2tup
        ER/2x44dNC7V86qfvQbgtktgTV2eGdPEMP4Y8=; b=olhq63KPEczsNdpM4dunTL
        Ff1MGtvFigAFUzJuBoOexAjxkWDJfKwbaRKL7q/OglBnUB408XU6ZIay4BWGsaO0
        QJ1+HpuuG7QO8SPTh/Db7VUrGJWzQJHJSLwpntPAK6x1PCLvNYF+96tFUfPY5+7f
        fCbNH53RMFDdrbZLCwY8E/S2WMdXK5WZmfW+tS9uLmoLdm1pLkH+TuYZR8svoFSi
        9yh6ormoasXXQYXbvru/1xsZV7V1paMZlxHQ7mxlyEooZkpio3igH30cl5zJSG5s
        m156n2xHpIGy8lbX0dr+OEAreAqjsIH4R8Ftt1FYyi3QSNmccIbmrzENt5BWL6dA
        ==
X-ME-Sender: <xms:kMt5YC_15S2DFQvP4o6JhuBdJ8AwnSs_RkDD9vvfLAta-mNRFG9yDQ>
    <xme:kMt5YCu7eza79q-YMMbWvNupWS51-S9-eo9_Hsdy9weHuCSb9iIsGRtN_3b8ohY5G
    ekCOe_bNWRl2fWI0zY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:kMt5YICr2ynWw8cGxBN2IXqG-O1mpu9b545jUrz01wwN5ESR5fXF8A>
    <xmx:kMt5YKdxgI3nOpYjEF5Lfp_mmasu88YNUsI9fZ_srMwoNJjKioJEoA>
    <xmx:kMt5YHMyBHrRZ64foYbORdr0XDXFVR21XMBv-hEap6GwbF4SbpNjnw>
    <xmx:kct5YGYILhHR0lrmh-FArhVXh-rD46Ni0NLWPaA1WdbOR4VQcrBQXA>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF2251080067;
        Fri, 16 Apr 2021 13:38:24 -0400 (EDT)
Date:   Fri, 16 Apr 2021 10:38:23 -0700
From:   Boris Burkov <boris@bur.io>
To:     An Long <lan@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: add misc test for enqueue parameter
Message-ID: <YHnLj7vHuXSH9Pt+@zen>
References: <20210414074906.17715-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414074906.17715-1-lan@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 03:49:06PM +0800, An Long wrote:
> The exclusive ops will not start if there's one already running. The
> enqueue parameter allows operations to be queued.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  .../misc-tests/048-enqueue-parameter/test.sh  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100755 tests/misc-tests/048-enqueue-parameter/test.sh
> 
> diff --git a/tests/misc-tests/048-enqueue-parameter/test.sh b/tests/misc-tests/048-enqueue-parameter/test.sh
> new file mode 100755
> index 00000000..4be7d466
> --- /dev/null
> +++ b/tests/misc-tests/048-enqueue-parameter/test.sh
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# Check if --enqueue can enqueueing of the operations correctly
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +check_global_prereq fallocate
> +
> +setup_loopdevs 3
> +prepare_loopdevs
> +dev1=${loopdevs[1]}
> +dev2=${loopdevs[2]}
> +dev3=${loopdevs[3]}
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev1"
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev2"
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev3"
> +run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
> +run_check $SUDO_HELPER "$TOP/btrfs" device add -f "$dev2" "$TEST_MNT"
> +
> +test_run_commands() {
> +        run_check $SUDO_HELPER "$TOP/btrfs" balance start --enqueue --full-balance "$TEST_MNT" &
> +        run_check $SUDO_HELPER "$TOP/btrfs" filesystem resize --enqueue -100M "$TEST_MNT" &
> +        run_check $SUDO_HELPER "$TOP/btrfs" device add --enqueue -f "$dev3" "$TEST_MNT" &
> +        run_check $SUDO_HELPER "$TOP/btrfs" device delete --enqueue "$dev2" "$TEST_MNT" &
> +}
> +
> +get_fs_uuid() {
> +        run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$1" | \
> +                grep '^fsid' | awk '{print $2}'
> +}
> +
> +fsid=$(get_fs_uuid "$dev1")
> +if ! [ -f "/sys/fs/btrfs/$fsid/exclusive_operation" ]; then
> +        run_check_umount_test_dev "$TEST_MNT"
> +        cleanup_loopdevs
> +        _not_run "kernel does not support exclusive_operation"
> +        exit
> +fi
> +
> +# Generate 1G data, for enough balance time for exclusive_operation
> +for i in $(seq 1 5); do
> +        run_check $SUDO_HELPER fallocate -l 200M "$TEST_MNT/file$i"
> +done
> +
> +# Do btrfs balance in background, then try commands with enqueue parameter
> +run_check $SUDO_HELPER "$TOP/btrfs" balance start --full-balance "$TEST_MNT" &
> +test_run_commands
> +wait
> +
> +run_check_umount_test_dev "$TEST_MNT"
> +cleanup_loopdevs
> -- 
> 2.26.2
> 

I applied this patch to progs v5.11.1 and ran it on a vm running a
kernel built from e5ff2239e143 (kdave/misc-next rebased today) and each
of the enqueued commands fails without any useful diagnostic
information, nor anything interesting in dmesg as far as I can tell.
e.g.:
"failed: /home/vmuser/btrfs-progs/btrfs filesystem resize --enqueue
-100M /home/vmuser/btrfs-progs/tests/mnt"

I am able to pass other misc tests on this setup.

Is there anything else I need to do to be able to run this test?

Thanks,
Boris
