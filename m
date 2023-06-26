Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2873E679
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 19:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFZRdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZRdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 13:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8610C9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687800739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orLt4yP89X2UdvBr1TDvHLwF1RmryaYTro/txmG6+gc=;
        b=i4AT99wQsiXfYBgvvMw/ihqgayrj+uRMSUODx8nbleN+ADis0qr4ScWpoIVJ7FvGhQy+Jb
        DygMNKU0R/gtgf2qmBxyWpNyO0gZX2xVyf0n3IOZIAxKCX3ZCAeXWMh6nUD6sxmAz/vmcD
        V9dj3rlx/L4ghI+DfKP7EIYnH1ZgVDM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-rRuiXP2gMtq06I-TMHFRyg-1; Mon, 26 Jun 2023 13:32:18 -0400
X-MC-Unique: rRuiXP2gMtq06I-TMHFRyg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-345a459b55bso10556355ab.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 10:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800737; x=1690392737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orLt4yP89X2UdvBr1TDvHLwF1RmryaYTro/txmG6+gc=;
        b=BwEr7qv1H+S5YxjaJgYNsOhSnB8/ewp+ILJCFUOVSSjJVaHTwKbD2H8B3js8P3z37p
         QA+wO5ZySkBouutloV0LLRYCcXLZkddUtXyM05KCj01bLsUJsFG+5uvgfYiOdXXvVlWF
         eYtbOMvmYSnKLs4bCVgGSdUMltmRQzMDHoESaRcMyJHdYNJdDTtT9s7Cr32R5rh8KoEH
         cViJ32+XGoOkoe02mIUC8Dm1AOaAKVNeskZSO7G9kfnkyFfLnqqIpcD6nfHAg+3evyYA
         SrsIEmBVCzpoyfQE5I229G8WrqolOgdbeBGGw3XZVQfDZRp4HSbOvjRdQoaJjvm6ELA2
         0/Yw==
X-Gm-Message-State: AC+VfDyIKH781MMAH/CmvQHgStCnkqLnTj+wyCY9lh1KeR/KBEClQsJ0
        WGt9BMv7qZApDInChn509mSp2EI26LUC1AJKna4xOMwGx88fSdOOpUrpvS6CFotejXNMatIXXVN
        b88dySBbzLSUwt6bZDodGbJQ=
X-Received: by 2002:a92:cf08:0:b0:345:b096:7eed with SMTP id c8-20020a92cf08000000b00345b0967eedmr1897155ilo.29.1687800737205;
        Mon, 26 Jun 2023 10:32:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iyGLahAd0AGIxF/uq63MSuaiipTmfrTYeWInBqx1njqaUluQ0bG38G/aCaJBu0jibWw/8Zw==
X-Received: by 2002:a92:cf08:0:b0:345:b096:7eed with SMTP id c8-20020a92cf08000000b00345b0967eedmr1897136ilo.29.1687800736932;
        Mon, 26 Jun 2023 10:32:16 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b0066355064acbsm4049393pfh.104.2023.06.26.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:32:16 -0700 (PDT)
Date:   Tue, 27 Jun 2023 01:32:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Message-ID: <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
References: <20230626060052.8913-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626060052.8913-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
> [BUG]
> After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> ensure all page caches are dropped"), the test case btrfs/143 can fail
> like below:
> 
>  btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
>     --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>     +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
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
> ---
>  common/btrfs | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 175b33ae..4a02b2cc 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
>  	# The drop_caches doesn't seem to drop every pages on aarch64 with
>  	# 64K page size.
>  	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
> -	# the cache are dropped.
> -	_scratch_cycle_mount
> +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
> +	# we may mount whatever dm device at SCRATCH_MNT.
> +	# So here we grab the mounted block device and its mount options, then
> +	# unmount and re-mount with the same device and options.
> +	local mount_info=$(_mount | grep "$SCRATCH_MNT")
> +	if [ -z "$mount_info" ]; then
> +		_fail "failed to grab mount info of $SCRATCH_MNT"
> +	fi
> +	local dev=$(echo $mount_info | $AWK_PROG '{print $1}')
> +	local opts=$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[()]//g')

The `findmnt` can help to get $dev and $opts:

  local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
  local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)

If you hope to check you can keep:

  if [ -z "$dev" -o -z "$opts" ];then
          _fail "failed to grab mount info of $SCRATCH_MNT"
  fi

> +	_scratch_unmount
> +	_mount $dev -o $opts $SCRATCH_MNT

I'm wondering can this help that, after you get the "real" device name:

  SCRATCH_DEV=$dev _scratch_cycle_mount

Thanks,
Zorro

>  	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
>  		exec $XFS_IO_PROG \
>  			-c "pread -b $size $offset $size" $file) ]]; do
> -- 
> 2.39.0
> 

