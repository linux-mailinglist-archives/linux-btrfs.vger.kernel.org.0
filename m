Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409EB73E541
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFZQhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjFZQhL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 12:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B083;
        Mon, 26 Jun 2023 09:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DDEC60EEE;
        Mon, 26 Jun 2023 16:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D7AC433C0;
        Mon, 26 Jun 2023 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687797429;
        bh=iUhLYnwAgOtawOtZnFE8Gg+f2lgq/IwDTGdkc1JO69c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLsEqFASo3P+Yn6JtQRQV9Nxy7zo+AzT39LOmxockrLru8M0RZQSTieAwmnKCsFAG
         8j+dZM3t+FqY77GGuHktpf3+rPsB+n3FoV2vPsaPunMM4H8xrku0F2Zj0kVYVq718k
         XBUF1IbaPa4RwaQ8RrEYE08OqYybXbXwfIhcSVUKgdxtXUanIo3vGOh0iudJkNU79E
         AuHB32DDOvOdgBLXVbVKDnD3OgPytpn3xzMD6KlN9+MgYM8g6+z93N7mJt+Dwkbpew
         HYZ6Z5IOUHfoFsRJNKuFVwxjaQjle2QrKbx+t7+FlIBWi/WJOCxGtCNXPn5yDQybbp
         +h92lvOIc5ZrQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-39ca120c103so2745798b6e.2;
        Mon, 26 Jun 2023 09:37:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDyrL6JSQD2dJ8aPJan5l1Jrf6JriUEZ2IfgejxBI7KBQk4MXKFn
        bMbekNqP3+NWtRIMf3b5f5yEg/rm0eEQWe1lqM8=
X-Google-Smtp-Source: ACHHUZ4GmYHe4MRynq5YsUefS8fIamApgUquisjRSg4EJbaY7mbbWyrSC0tJuxYcg5wqGVCdgyyDA3Zy9RqnPN34Dnk=
X-Received: by 2002:a05:6808:178b:b0:3a1:efe6:13c5 with SMTP id
 bg11-20020a056808178b00b003a1efe613c5mr399650oib.44.1687797428154; Mon, 26
 Jun 2023 09:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230626060052.8913-1-wqu@suse.com>
In-Reply-To: <20230626060052.8913-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 26 Jun 2023 17:36:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5t0TW9Z2ymfh2ytR9YGvG-TtjqxivWYNVY9kDcXp+PNw@mail.gmail.com>
Message-ID: <CAL3q7H5t0TW9Z2ymfh2ytR9YGvG-TtjqxivWYNVY9kDcXp+PNw@mail.gmail.com>
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in _btrfs_buffered_read_on_mirror()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 26, 2023 at 7:05=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> ensure all page caches are dropped"), the test case btrfs/143 can fail
> like below:
>
>  btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstest=
s/results//btrfs/143.out.bad)
>     --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>     +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.5750338=
99 +0100
>     @@ -1,37 +1,6 @@
>      QA output created by 143
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>
> [CAUSE]
> Test case btrfs/143 uses dm-dust device to emulate read errors, this
> means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
>
> As it would go mount $SCRATCH_DEV, not the dm-dust device to
> $SCRATCH_MNT.
> This prevents us to trigger read-repair (since no error would be hit)
> thus fail the test.
>
> [FIX]
> Since we can mount whatever device at $SCRATCH_MNT, we can not use
> _scratch_cycle_mount in this case.
>
> Instead implement a small helper to grab the mounted device and its
> mount options, and use the same device and mount options to cycle
> $SCRATCH_MNT mount.
>
> This would fix btrfs/143 and hopefully future test cases which use dm
> devices.
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks fine to me, and it works, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  common/btrfs | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index 175b33ae..4a02b2cc 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
>         # The drop_caches doesn't seem to drop every pages on aarch64 wit=
h
>         # 64K page size.
>         # So here as another workaround, cycle mount the SCRATCH_MNT to e=
nsure
> -       # the cache are dropped.
> -       _scratch_cycle_mount
> +       # the cache are dropped, but we can not use _scratch_cycle_mount,=
 as
> +       # we may mount whatever dm device at SCRATCH_MNT.
> +       # So here we grab the mounted block device and its mount options,=
 then
> +       # unmount and re-mount with the same device and options.
> +       local mount_info=3D$(_mount | grep "$SCRATCH_MNT")
> +       if [ -z "$mount_info" ]; then
> +               _fail "failed to grab mount info of $SCRATCH_MNT"
> +       fi
> +       local dev=3D$(echo $mount_info | $AWK_PROG '{print $1}')
> +       local opts=3D$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's=
/[()]//g')
> +       _scratch_unmount
> +       _mount $dev -o $opts $SCRATCH_MNT
>         while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
>                 exec $XFS_IO_PROG \
>                         -c "pread -b $size $offset $size" $file) ]]; do
> --
> 2.39.0
>
