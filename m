Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31F57D46DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 07:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjJXFWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 01:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08AA118
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698124896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMiHPCeju+k1ed/Rv8ioAxDETw0X0WK9WfcuW+Vc8i8=;
        b=PX5Bt4cRHFDbBMReBb9orYwPxV1s7vAYbdzCrFaJxHPvE0jVAO7duLCpGwWIYpclJnc+cW
        GgwRxvH+y4wbvy5GpLw2q6WB1WEyAuK8rIWvQjVojeSueNUHyx1VSCJ2AVnIDRZyqGJAeK
        wC+7WSMTd8x4pRWk1Zw5d3tsFrahv+E=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-5bBP-D-POs2uQzKo-Ae7Cw-1; Tue, 24 Oct 2023 01:21:35 -0400
X-MC-Unique: 5bBP-D-POs2uQzKo-Ae7Cw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so2540950a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 22:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698124894; x=1698729694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMiHPCeju+k1ed/Rv8ioAxDETw0X0WK9WfcuW+Vc8i8=;
        b=DYqJZioC5Iuj75NqDDRG1r9vhacSoHUsHKN8bJ6HEUEtEsTYBuFD+lcok4W2/NtBrM
         GMLTSHHs/qXKioKreJPidkoUtG8la9HATHTcRRlEgngUTyV19/eo5qNbKUrCLFitQfKE
         dot+speVDLVTxqWEGxJVtVC5mJ/ljEJHZFhP5cDiRYuXeuzX6G1BmIw5tgrxQZdXFjVd
         9xaZftSfUq3RPaWhVhv6H3GYIdqOms8CGW9iiDYMh+IW4vOzrbPI/ZmTXLPD/iSEI0g6
         AXSlGIhO2AUayu10JriN8J37p17svfqoD9QPpX2k9zR580j6duu9sygljf9esqB+89uz
         dZvg==
X-Gm-Message-State: AOJu0YxIZ0AcUhw60nkWYTzy65LFY50w5AjVCUt9Z2UUxmHGmsl6ME8C
        3usjllF8uQ1gMQdkY69bb00olQ0q+j6ZGoDu9MqU7exECt+CpeXGd0HsEPOq7zU9CgUIG2Hg1lz
        EurFSiH3/k4Cu2le+HHmwAL4=
X-Received: by 2002:a05:6a20:2443:b0:17b:cfee:9b9 with SMTP id t3-20020a056a20244300b0017bcfee09b9mr1693301pzc.41.1698124894148;
        Mon, 23 Oct 2023 22:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcORGa16DirHy1OXxAerQnRKqAIiI7YDlCaw384tAZC3UXjujMP6b83OMRRAj4TB8WkRB7fw==
X-Received: by 2002:a05:6a20:2443:b0:17b:cfee:9b9 with SMTP id t3-20020a056a20244300b0017bcfee09b9mr1693289pzc.41.1698124893738;
        Mon, 23 Oct 2023 22:21:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001c72f4334afsm6757404plt.20.2023.10.23.22.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:21:33 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org, quwenruo.btrfs@gmx.com,
        esandeen@redhat.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/353 should accomodate other pwrite
 behaviors
Message-ID: <20231024052129.5ze2o3wmdolaro5w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230901161816.148854-1-bodonnel@redhat.com>
 <20230929050651.7rlyclnxlmzrot3z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZRbUQveXYWjhlvAN@redhat.com>
 <ZTb2Xy4vTi6/RGQo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTb2Xy4vTi6/RGQo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 23, 2023 at 05:40:31PM -0500, Bill O'Donnell wrote:
> ping?

Hi Bill,

> 
> On Fri, Sep 29, 2023 at 08:42:26AM -0500, Bill O'Donnell wrote:
> > On Fri, Sep 29, 2023 at 01:06:51PM +0800, Zorro Lang wrote:
> > > On Fri, Sep 01, 2023 at 11:18:16AM -0500, Bill O'Donnell wrote:
> > > > xfs_io pwrite issues a series of block size writes, but there is no
> > > > guarantee that the resulting extent(s) will be singular or contiguous.
> > > > This behavior is acceptable, but the test is flawed in that it expects
> > > > a single extent for a pwrite.
> > > > 
> > > > Modify test to use actual blocksize for pwrite and reflink. Also
> > > > modify it to accommodate pwrite and reflink that produce different
> > > > mapping results.
> > > > 
> > > > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > > > ---
> > > 
> > > This patch makes sense to me, but this case looks like a regression test
> > > test for a known btrfs issue. But this test case doesn't point out which
> > > bug/fix does it test for. So I don't know if the 64k blocksize is a
> > > necessary condition to reproduce the bug.
> > > 
> > > If we can prove it still can reproduce that bug with this patch at least,
> > > then it's good to me to merge it.
> > 
> > I'd like Qu to weigh in on this from the btrfs standpoint.

If there's still not any review points from Qu or other btrfs devels, I'll
merge this patch in next release. Better to make sure if the 64k (multi-blocks)
is a necessary condition for this case. What's the bug fix this case trying to
cover?

Thanks,
Zorro

> > 
> > Thanks-
> > Bill
> > 
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > >  tests/generic/353     | 29 ++++++++++++++++-------------
> > > >  tests/generic/353.out | 15 +--------------
> > > >  2 files changed, 17 insertions(+), 27 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/353 b/tests/generic/353
> > > > index 9a1471bd..c5639725 100755
> > > > --- a/tests/generic/353
> > > > +++ b/tests/generic/353
> > > > @@ -29,31 +29,34 @@ _require_xfs_io_command "fiemap"
> > > >  _scratch_mkfs > /dev/null 2>&1
> > > >  _scratch_mount
> > > >  
> > > > -blocksize=64k
> > > > +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > > +
> > > >  file1="$SCRATCH_MNT/file1"
> > > >  file2="$SCRATCH_MNT/file2"
> > > > +extmap1="$SCRATCH_MNT/extmap1"
> > > > +extmap2="$SCRATCH_MNT/extmap2"
> > > >  
> > > >  # write the initial file
> > > > -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 | _filter_xfs_io
> > > > +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 > /dev/null
> > > >  
> > > >  # reflink initial file
> > > > -_reflink_range $file1 0 $file2 0 $blocksize | _filter_xfs_io
> > > > +_reflink_range $file1 0 $file2 0 $blocksize > /dev/null
> > > >  
> > > >  # check their fiemap to make sure it's correct
> > > > -echo "before sync:"
> > > > -echo "$file1" | _filter_scratch
> > > > -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> > > > -echo "$file2" | _filter_scratch
> > > > -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> > > > +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> > > > +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> > > > +
> > > > +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
> > > >  
> > > >  # sync and recheck, to make sure the fiemap doesn't change just
> > > >  # due to sync
> > > >  sync
> > > > -echo "after sync:"
> > > > -echo "$file1" | _filter_scratch
> > > > -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> > > > -echo "$file2" | _filter_scratch
> > > > -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> > > > +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> > > > +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> > > > +
> > > > +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps after sync"
> > > > +
> > > > +echo "Silence is golden"
> > > >  
> > > >  # success, all done
> > > >  status=0
> > > > diff --git a/tests/generic/353.out b/tests/generic/353.out
> > > > index 4f6e0b92..16ba4f1f 100644
> > > > --- a/tests/generic/353.out
> > > > +++ b/tests/generic/353.out
> > > > @@ -1,15 +1,2 @@
> > > >  QA output created by 353
> > > > -wrote 65536/65536 bytes at offset 0
> > > > -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > -linked 65536/65536 bytes at offset 0
> > > > -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > -before sync:
> > > > -SCRATCH_MNT/file1
> > > > -0: [0..127]: shared|last
> > > > -SCRATCH_MNT/file2
> > > > -0: [0..127]: shared|last
> > > > -after sync:
> > > > -SCRATCH_MNT/file1
> > > > -0: [0..127]: shared|last
> > > > -SCRATCH_MNT/file2
> > > > -0: [0..127]: shared|last
> > > > +Silence is golden
> > > > -- 
> > > > 2.41.0
> > > > 
> > > 
> > 
> 

