Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520517414BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjF1PS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 11:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbjF1PSZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 11:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687965447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjh9nIWe06Ci+GHIqPuiwxWvdXgsHTVUcWD8U2D9bUo=;
        b=IejBBdRHqb1Ml2GTLhHZLHQHLkXd9aGWn5ILf8TrotxkKd90BnQsOECtjzNrvInUbGR4Ak
        S/DuE1NFBMaO5DOTeeqtgW6ZX58hrPuAWZ4/auPg7+WG/+id1GUb5EJcAvR6CXCWzu99Lu
        V7nb3GLVslIZVUywH9ZqUxZZ9ui7S/Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rzAnYARyNSeDNx5I_VH-0w-1; Wed, 28 Jun 2023 11:16:42 -0400
X-MC-Unique: rzAnYARyNSeDNx5I_VH-0w-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-528ab71c95cso2703140a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 08:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965388; x=1690557388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjh9nIWe06Ci+GHIqPuiwxWvdXgsHTVUcWD8U2D9bUo=;
        b=UbfYvQLuF1uce/jLjyTBoXzYKMdU+uJLZB33dQ5YJFes+uVvIYEGWN38617i7l98S8
         dXZjgqTRtGZklrodfDERlEvZN1Z6CZ3Pt86POG+sdZzenBqDOHZZjzvuuQRIooEy9Yqi
         AIBXDl7he3u78ya+WAqc5Jf3lSIBNefs4chGjOu61x5xMDUJAaevrKlTmnFM0zCU7uj9
         SzBEFCBEIB9Y2ekonTB+2gnXElQNlZKaLlI5eh/3uAy3LC2dAvVBk6vuSxeSll9rzXLm
         7A5iIXb10Jw8RUBoF0c0bU6SHNPs57TQZI3mRsDHLWdkLvqqyQTjjnAEeuL8c0G2vHXl
         oJOg==
X-Gm-Message-State: AC+VfDzSdelr4zNwVUEHPrbMcKfGsNLOYyTgaP2aZb57ajjzFj5leICA
        EP3J4Dkp9aalZRM9FiDowayZnhKCaPt35vWTaitvcaTzeZaA1VdrwYEPqu4M1UxEgtgbkLzm/Dr
        NbBEkXs3v7JpHU+gHikgP+P4=
X-Received: by 2002:a05:6a20:190:b0:12b:68f6:411d with SMTP id 16-20020a056a20019000b0012b68f6411dmr3737325pzy.49.1687965388005;
        Wed, 28 Jun 2023 08:16:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GYlY7G1Olfr+du55Urjs0fWHPmW+XOBHyuwtr0DgTE7NL5R9ddDL1j35xoWNEaLwJkQspDg==
X-Received: by 2002:a05:6a20:190:b0:12b:68f6:411d with SMTP id 16-20020a056a20019000b0012b68f6411dmr3737296pzy.49.1687965387562;
        Wed, 28 Jun 2023 08:16:27 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b0065dd1e7c3c2sm2812511pfa.184.2023.06.28.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:16:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 23:16:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Message-ID: <20230628151622.nhsr5mevja5h372y@zlang-mailbox>
References: <20230626060052.8913-1-wqu@suse.com>
 <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
 <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
 <20230628113403.yymofvkvzrix7uev@zlang-mailbox>
 <98f33b4e-7cb9-4819-fe0a-4decb555ca23@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f33b4e-7cb9-4819-fe0a-4decb555ca23@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:40:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/28 19:34, Zorro Lang wrote:
> > On Tue, Jun 27, 2023 at 05:23:31AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/6/27 01:32, Zorro Lang wrote:
> > > > On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
> > > > > [BUG]
> > > > > After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> > > > > ensure all page caches are dropped"), the test case btrfs/143 can fail
> > > > > like below:
> > > > > 
> > > > >    btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
> > > > >       --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
> > > > >       +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
> > > > >       @@ -1,37 +1,6 @@
> > > > >        QA output created by 143
> > > > >        wrote 131072/131072 bytes
> > > > >        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > > 
> > > > > [CAUSE]
> > > > > Test case btrfs/143 uses dm-dust device to emulate read errors, this
> > > > > means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
> > > > > 
> > > > > As it would go mount $SCRATCH_DEV, not the dm-dust device to
> > > > > $SCRATCH_MNT.
> > > > > This prevents us to trigger read-repair (since no error would be hit)
> > > > > thus fail the test.
> > > > > 
> > > > > [FIX]
> > > > > Since we can mount whatever device at $SCRATCH_MNT, we can not use
> > > > > _scratch_cycle_mount in this case.
> > > > > 
> > > > > Instead implement a small helper to grab the mounted device and its
> > > > > mount options, and use the same device and mount options to cycle
> > > > > $SCRATCH_MNT mount.
> > > > > 
> > > > > This would fix btrfs/143 and hopefully future test cases which use dm
> > > > > devices.
> > > > > 
> > > > > Reported-by: Filipe Manana <fdmanana@suse.com>
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > >    common/btrfs | 14 ++++++++++++--
> > > > >    1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/common/btrfs b/common/btrfs
> > > > > index 175b33ae..4a02b2cc 100644
> > > > > --- a/common/btrfs
> > > > > +++ b/common/btrfs
> > > > > @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
> > > > >    	# The drop_caches doesn't seem to drop every pages on aarch64 with
> > > > >    	# 64K page size.
> > > > >    	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
> > > > > -	# the cache are dropped.
> > > > > -	_scratch_cycle_mount
> > > > > +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
> > > > > +	# we may mount whatever dm device at SCRATCH_MNT.
> > > > > +	# So here we grab the mounted block device and its mount options, then
> > > > > +	# unmount and re-mount with the same device and options.
> > > > > +	local mount_info=$(_mount | grep "$SCRATCH_MNT")
> > > > > +	if [ -z "$mount_info" ]; then
> > > > > +		_fail "failed to grab mount info of $SCRATCH_MNT"
> > > > > +	fi
> > > > > +	local dev=$(echo $mount_info | $AWK_PROG '{print $1}')
> > > > > +	local opts=$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[()]//g')
> > > > 
> > > > The `findmnt` can help to get $dev and $opts:
> > > > 
> > > >     local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
> > > >     local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
> > > > 
> > > > If you hope to check you can keep:
> > > > 
> > > >     if [ -z "$dev" -o -z "$opts" ];then
> > > >             _fail "failed to grab mount info of $SCRATCH_MNT"
> > > >     fi
> > > 
> > > That's really helpful!
> > > 
> > > > 
> > > > > +	_scratch_unmount
> > > > > +	_mount $dev -o $opts $SCRATCH_MNT
> > > > 
> > > > I'm wondering can this help that, after you get the "real" device name:
> > > > 
> > > >     SCRATCH_DEV=$dev _scratch_cycle_mount
> > > 
> > > AFAIK we still need to specify the mount option.
> > > 
> > > As it's possible previous mount is specifying certain mount option
> > > that's not in MOUNT_OPTIONS environment variables.
> > > 
> > > E.g. mounting a specific subvolume or a temporary mount option.
> > > 
> > > Thus I believe we may still need to specific the mount options.
> > 
> > Hmm... if the _scratch_cycle_mount doesn't support dmdust, others dmxxxx
> > (e.g. dmdelay, dmthin, dmerror, dmflaky) have similar problem, right?
> 
> Yes, but my point here is, although "SCRATCH_DEV=$dev
> _scratch_cycle_mount" can work for most cases, it can still miss the
> specific mount option of the current mount.
> 
> Thus we still need to go "_mount $dev -o $opts $SCRATCH_MNT", just for
> the extra mount options.

OK, let's merge this patch to fix this small regression issue at first. Then
I'll think about how to make _scratch_cycle_mount work with dmXXXX in another
patch.

Please send a V2 to use findmnt, I'll merge it in next fstests release.

Thanks,
Zorro

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > >    	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> > > > >    		exec $XFS_IO_PROG \
> > > > >    			-c "pread -b $size $offset $size" $file) ]]; do
> > > > > --
> > > > > 2.39.0
> > > > > 
> > > > 
> > > 
> > 
> 

