Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62774101F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjF1LfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbjF1LfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687952051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xu+yGr8f2EuHDn3UfBVj6oDwRxKSyL/xpS9WUtJIIsE=;
        b=hp/qoF8UBv+FQGKW/IsMwRw7LnPvyONXgic8cnCDANwveWXm4Z2dhi30q4gqSIk4jU365Q
        5GRwTHh984hj4vLE2Nlqd0Q5P39IO75y7JcpzqqPtDzq8BvNEDr5vRZrVVC9qSFeNXT68Q
        4GNovJy471hdx/MVLYzlIedAX1IJrUU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-j0oKIslbN929vUH-ieIn8Q-1; Wed, 28 Jun 2023 07:34:10 -0400
X-MC-Unique: j0oKIslbN929vUH-ieIn8Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5343c1d114cso4798707a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 04:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687952049; x=1690544049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu+yGr8f2EuHDn3UfBVj6oDwRxKSyL/xpS9WUtJIIsE=;
        b=Ngk6rGe3CZzPVuitlLWuhADqgLYGF3TMgRh8ibhf9YoNjMhPjxphRISzxzpe8wTQtN
         t1Whu+ByxdQFjqs9ZHbAh6u2vS9bENVlJSA87DF1gOlKZVPjFEMI35Qt3uwzZD96WnLF
         /ikj1PTRX95MVaxDXxzamAYu1sQNHOGWNHjQeTqW0dvFOE3bwGX28lIoiOEtxGDwfHsK
         xJ6KDOt484/S1zBqzhAvj/wnBwlq7yzovIHBt5S6iehA4CD55zKyL+i5b5nKgxnJ/fWX
         7iWumhUwsV1YmcljdNncjr6gBSUD1DGhSh9fLmBfS5LVVRSXwSMynSL0QwddITNKn+Vk
         DCLA==
X-Gm-Message-State: AC+VfDzwNpDhna6h12wgwEMKBLPFSxKA+/SYj7yJkU2InWL3UZFm0f56
        e5KoP6kI9lSLTh4LjABVSOOKoVrVQZE7ytwpkYajJ60Ziy+ZXlWD5hPtimUadBxi8KCezUOtYx7
        f0heSC2WQRgiFKOFrzQCq6s0=
X-Received: by 2002:a05:6a20:6a15:b0:11d:bc14:85ad with SMTP id p21-20020a056a206a1500b0011dbc1485admr40514225pzk.53.1687952048955;
        Wed, 28 Jun 2023 04:34:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ONLMx+qAxRuTp2QmhLKHkb8bGcNlJ0eGfU/zofXqLO07DhJjlPs8dEMOKfaB82sK7dqP0nA==
X-Received: by 2002:a05:6a20:6a15:b0:11d:bc14:85ad with SMTP id p21-20020a056a206a1500b0011dbc1485admr40514204pzk.53.1687952048633;
        Wed, 28 Jun 2023 04:34:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b0066a4e561beesm7082144pfi.173.2023.06.28.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:34:08 -0700 (PDT)
Date:   Wed, 28 Jun 2023 19:34:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Message-ID: <20230628113403.yymofvkvzrix7uev@zlang-mailbox>
References: <20230626060052.8913-1-wqu@suse.com>
 <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
 <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 05:23:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/27 01:32, Zorro Lang wrote:
> > On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
> > > [BUG]
> > > After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> > > ensure all page caches are dropped"), the test case btrfs/143 can fail
> > > like below:
> > > 
> > >   btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
> > >      --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
> > >      +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
> > >      @@ -1,37 +1,6 @@
> > >       QA output created by 143
> > >       wrote 131072/131072 bytes
> > >       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > ................
> > >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > ................
> > >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > ................
> > >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > ................
> > > 
> > > [CAUSE]
> > > Test case btrfs/143 uses dm-dust device to emulate read errors, this
> > > means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
> > > 
> > > As it would go mount $SCRATCH_DEV, not the dm-dust device to
> > > $SCRATCH_MNT.
> > > This prevents us to trigger read-repair (since no error would be hit)
> > > thus fail the test.
> > > 
> > > [FIX]
> > > Since we can mount whatever device at $SCRATCH_MNT, we can not use
> > > _scratch_cycle_mount in this case.
> > > 
> > > Instead implement a small helper to grab the mounted device and its
> > > mount options, and use the same device and mount options to cycle
> > > $SCRATCH_MNT mount.
> > > 
> > > This would fix btrfs/143 and hopefully future test cases which use dm
> > > devices.
> > > 
> > > Reported-by: Filipe Manana <fdmanana@suse.com>
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   common/btrfs | 14 ++++++++++++--
> > >   1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/btrfs b/common/btrfs
> > > index 175b33ae..4a02b2cc 100644
> > > --- a/common/btrfs
> > > +++ b/common/btrfs
> > > @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
> > >   	# The drop_caches doesn't seem to drop every pages on aarch64 with
> > >   	# 64K page size.
> > >   	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
> > > -	# the cache are dropped.
> > > -	_scratch_cycle_mount
> > > +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
> > > +	# we may mount whatever dm device at SCRATCH_MNT.
> > > +	# So here we grab the mounted block device and its mount options, then
> > > +	# unmount and re-mount with the same device and options.
> > > +	local mount_info=$(_mount | grep "$SCRATCH_MNT")
> > > +	if [ -z "$mount_info" ]; then
> > > +		_fail "failed to grab mount info of $SCRATCH_MNT"
> > > +	fi
> > > +	local dev=$(echo $mount_info | $AWK_PROG '{print $1}')
> > > +	local opts=$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[()]//g')
> > 
> > The `findmnt` can help to get $dev and $opts:
> > 
> >    local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
> >    local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
> > 
> > If you hope to check you can keep:
> > 
> >    if [ -z "$dev" -o -z "$opts" ];then
> >            _fail "failed to grab mount info of $SCRATCH_MNT"
> >    fi
> 
> That's really helpful!
> 
> > 
> > > +	_scratch_unmount
> > > +	_mount $dev -o $opts $SCRATCH_MNT
> > 
> > I'm wondering can this help that, after you get the "real" device name:
> > 
> >    SCRATCH_DEV=$dev _scratch_cycle_mount
> 
> AFAIK we still need to specify the mount option.
> 
> As it's possible previous mount is specifying certain mount option
> that's not in MOUNT_OPTIONS environment variables.
> 
> E.g. mounting a specific subvolume or a temporary mount option.
> 
> Thus I believe we may still need to specific the mount options.

Hmm... if the _scratch_cycle_mount doesn't support dmdust, others dmxxxx
(e.g. dmdelay, dmthin, dmerror, dmflaky) have similar problem, right?

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >   	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> > >   		exec $XFS_IO_PROG \
> > >   			-c "pread -b $size $offset $size" $file) ]]; do
> > > --
> > > 2.39.0
> > > 
> > 
> 

