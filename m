Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA453741C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 06:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiE3Egr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 00:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiE3Ego (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 00:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396A72E69B
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653885401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSjwpCwC7E1Tb9YNniopwwkIggIzMi5wPNnz1KKE1hE=;
        b=P+ygrBOv13ioKEA968Bb3nNvzSItp8b1+RC+/zP4xmh9Qwr7ESttNP/uFW0HD0NLWhxMAU
        /ikQoMnU1gQe+fjLLoYYXR+zu4vBDRTitEcg2qOtJRvOmLSlwYdSnt2nmrSTVak1Gu0oah
        PUpR18mdz4mwao33RIFO2xiTNtNpZ1I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-_nlFrNvGNUa5iyvOyAmk0w-1; Mon, 30 May 2022 00:36:40 -0400
X-MC-Unique: _nlFrNvGNUa5iyvOyAmk0w-1
Received: by mail-qt1-f200.google.com with SMTP id f40-20020a05622a1a2800b002fcc151deebso8461100qtb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 21:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VSjwpCwC7E1Tb9YNniopwwkIggIzMi5wPNnz1KKE1hE=;
        b=EU2vefofePuTwpReAQIDt+Glm6nYVL04N3XFY4whzkoGX1Gqxmfzj6QQxvz08r2KXJ
         uP/XBJMbS/KgNQfKBW8OKTZqa7tmj017Oz3lYDLpmgGDJF9xuNlZ+ytazXXAR1mrmFd8
         aalJ2AemylHvlJE6Q3k0rPYMh6CO7Cmj72ERayqF/Z9RrUq7nFJDzrFy5/cM6nawPHk0
         YxjHdVeV1mgtkwDhWebicjQz/gBMuMRvcMi/fdCh3hVaO8RsGi3swotx2t1mGd/dvOyQ
         Gp2tL5L5NkPdECvrT8T7yOcjoh3jwJA3cCkQ1mgbDR82vVQhH2WVdVLS4aqB5qO2aXAo
         HLFw==
X-Gm-Message-State: AOAM532VrI2OUp5clezUmD2jEKvhC6TmOj0jREbJb+ZOZZscf8XI2TLm
        o81HEsnCt6BNYAMMYhlwTxaoknQY0JJQ8B6ZV9HcgaW/f+AXHsMx5NTCyEdSIiSbqx6EXgVhE2K
        D2jc2kW5rh8o+EGdQ4Ts8vi4=
X-Received: by 2002:a05:6214:2a88:b0:464:463a:7a84 with SMTP id jr8-20020a0562142a8800b00464463a7a84mr5826030qvb.53.1653885399788;
        Sun, 29 May 2022 21:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/cMsy1HbhMjUWS/VerARBe/BcrIA92aF3HSwExjeO0ywYOg/u4z+6Zluc7sz0as9NAgdrzA==
X-Received: by 2002:a05:6214:2a88:b0:464:463a:7a84 with SMTP id jr8-20020a0562142a8800b00464463a7a84mr5826016qvb.53.1653885399468;
        Sun, 29 May 2022 21:36:39 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 62-20020a370b41000000b006a32c4a2cb8sm7156224qkl.52.2022.05.29.21.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 21:36:38 -0700 (PDT)
Date:   Mon, 30 May 2022 12:36:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220530043632.talbzod4sohbdpxv@zlang-mailbox>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-2-hch@lst.de>
 <8bdaa753-ae46-88ec-09ce-0a5f86ea5b9d@oracle.com>
 <289c77f4-a2b6-d7e1-0114-dcb111d57f91@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <289c77f4-a2b6-d7e1-0114-dcb111d57f91@gmx.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 30, 2022 at 09:20:27AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/5/30 08:23, Anand Jain wrote:
> > On 5/27/22 13:49, Christoph Hellwig wrote:
> > > Add a few helpers to consolidate code for btrfs read repair testing:
> > > 
> > >   - _btrfs_get_first_logical() gets the btrfs logical address for the
> > >     first extent in a file
> > >   - _btrfs_get_device_path and _btrfs_get_physical use the
> > >     btrfs-map-logical tool to find the device path and physical address
> > >     for btrfs logical address for a specific mirror
> > >   - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
> > >     read the data from a specific mirror
> > > 
> > > These will be used to consolidate the read repair tests and avoid
> > > duplication for new tests.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   common/config |  1 +
> > >   2 files changed, 76 insertions(+)
> > > 
> > > diff --git a/common/btrfs b/common/btrfs
> > > index ac597ca4..b69feeee 100644
> > > --- a/common/btrfs
> > > +++ b/common/btrfs
> > > @@ -505,3 +505,78 @@ _btrfs_metadump()
> > >       $BTRFS_IMAGE_PROG "$device" "$dumpfile"
> > >       [ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &>
> > > /dev/null
> > >   }
> > > +
> > > +# Return the btrfs logical address for the first block in a file
> > > +_btrfs_get_first_logical()
> > > +{
> > > +    local file=$1
> > > +    _require_command "$FILEFRAG_PROG" filefrag
> > > +
> > > +    ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> > > +    ${FILEFRAG_PROG} -v $file | _filter_filefrag | cut -d '#' -f 1
> > > +}
> > > +
> > > +# Find the device path for a btrfs logical offset
> > > +_btrfs_get_device_path()
> > > +{
> > > +    local logical=$1
> > > +    local stripe=$2
> > > +
> > > +    _require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> > > +
> > > +    $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> > > +        $AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> > > +}
> > > +
> > > +
> > > +# Find the device physical sector for a btrfs logical offset
> > > +_btrfs_get_physical()
> > > +{
> > > +    local logical=$1
> > > +    local stripe=$2
> > > +
> > > +    _require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> > > +
> > > +    $BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV >>
> > > $seqres.full 2>&1
> > > +    $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> > > +        $AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> > > +}
> > > +
> > > +# Read from a specific stripe to test read recovery that corrupted a
> > > specific
> > > +# stripe.  Btrfs uses the PID to select the mirror, so keep reading
> > > until the
> > > +# xfs_io process that performed the read was executed with a PID that
> > > ends up
> > > +# on the intended mirror.
> > > +_btrfs_direct_read_on_mirror()
> > > +{
> > > +    local mirror=$1
> > > +    local nr_mirrors=$2
> > > +    local file=$3
> > > +    local offset=$4
> > > +    local size=$5
> > > +
> > > +    while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> > > +        exec $XFS_IO_PROG -d \
> > > +            -c "pread -b $size $offset $size" $file) ]]; do
> > > +        :
> > > +    done
> > > +}
> > > +
> > > +# Read from a specific stripe to test read recovery that corrupted a
> > > specific
> > > +# stripe.  Btrfs uses the PID to select the mirror, so keep reading
> > > until the
> > > +# xfs_io process that performed the read was executed with a PID that
> > > ends up
> > > +# on the intended mirror.
> > > +_btrfs_buffered_read_on_mirror()
> > > +{
> > > +    local mirror=$1
> > > +    local nr_mirrors=$2
> > > +    local file=$3
> > > +    local offset=$4
> > > +    local size=$5
> > > +
> > > +    echo 3 > /proc/sys/vm/drop_caches
> > 
> > 
> > > +    while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> > > +        exec $XFS_IO_PROG \
> > > +            -c "pread -b $size $offset $size" $file) ]]; do
> > 
> > I am confused if it should be BASHPID or PID?
> > 
> > Next, it is ok if the xfs_io_prog fails and returns != 0.
> > (Part of the test).
> > But then we will continue in the while loop. No?
> 
> The loop goes like this:
> 
> If "BASHPID % nr_mirrors" isn't mirror, then the whole condition inside
> the $() part is already 0, no need to exec the xfs_io command.
> 
> Then -z 0 return true, we continue the while loop (aka, doing nothing).
> 
> Only when (BASHPID % nr_mirrors == mirror) is true, we will try to exec
> c XFS_IO_PROGS in the same PID, and normally we will exit.
> 
> 
> Some of your concern are valid.
> Like if some code bug makes the pread failed, then we will continue the
> loop, possibly lead to an infinite loop.
> 
> The pid-check-then-exec idea is pretty good, it allows us to only
> initiate the read, without doing some unnecessary read then check the pid.
> 
> But putting the whole exec into the pid check is indeed hacky and can
> lead to problems.
> 
> Can we make it less hacky?

Hi Anand and Wenruo,

This patchset has been merged into fstests release v2022.05.29 last weekend.
If you feel something isn't good enough, feel free to send new patches to
fix/improve it.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> Thanks,
> Qu
> 
> > 
> > Sorry, I am sceptical about this. Could you please clarify
> > how this works?
> > 
> > 
> > Thanks, Anand
> > 
> > 
> > 
> > > +        :
> > > +    done
> > 
> > 
> > 
> > 
> > > +}
> > > diff --git a/common/config b/common/config
> > > index c6428f90..df20afc1 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -228,6 +228,7 @@ export E2IMAGE_PROG="$(type -P e2image)"
> > >   export BLKZONE_PROG="$(type -P blkzone)"
> > >   export GZIP_PROG="$(type -P gzip)"
> > >   export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
> > > +export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> > >   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> > >   # newer systems have udevadm command but older systems like RHEL5
> > > don't.
> > 
> 

