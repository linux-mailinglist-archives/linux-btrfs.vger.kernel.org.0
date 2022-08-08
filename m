Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC88A58CE54
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiHHTJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHHTJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 15:09:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB615FE1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 12:09:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m7so7178557qkk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DzzUNsdWVwFrqHXep4GxMye3QWRhH2Sr6ANI0kjR9ho=;
        b=PWP7fIqKVwd2QcjZg+SEwsspXY0CYph01ofRaTjheAiV4kOeVYlv5JPKzjVA1BT2Vl
         eH8oo3rnLgHm+4IHixvFws2Fg2GSlJFN128dRbSBBZkRYomz8oKTdYGQ812GAMHa6pLn
         sQC277+EqNa8e3TgVcw74PuQJN3Nc0yKob4myzzfoy8G4S8tpONgZx0DfWt/Sr9H8zFh
         18Td8sBQxeAkfTFqozSYQaD6GyFlbJPSoV8u5d23oBgMUOgf5TP3gMwxKk07PTn9Twmq
         8TsQKe42dbhwcit0+KDBcoklMM1o11I3aYxIID+oMq/FquZw0K91Q/haZPbKTok8sWfN
         1Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzzUNsdWVwFrqHXep4GxMye3QWRhH2Sr6ANI0kjR9ho=;
        b=tEY0bX+K5+oLqFdJEVtGEh5bF8bSdDPs+CvOGHccxjkr3TzszFoSQwxGzdmlTIKJSr
         vvcX03OsIpQDCd3+INvkt9o2ljIW2jLI/54rnMG43/usEY0jvyBrdjYbYkJCjmhkymDu
         ANWINHYILf20W0Z/+XfH38W1v9irED9WVOdIfm+PhtE/Um7sVCteBMXrMx1ydhfmyVdu
         mMlHHlG9nxJ3NRYnlja85InHlKPhS3HCgF8wjtHn5iiJzBhBjGDcieZDWgMDtaH0tqqe
         zXyCm2vM5KVpqoJujXGlbp9eZKNmX9mLoPZ5Gd4zNKVQnmx70/+ACIdNKcp80gwHrOo0
         ek6A==
X-Gm-Message-State: ACgBeo0j5gZ+ajG1DvDk1HCwtzsVczYbGNaIf7sbRNdXkjwgSjQobT+9
        UtLhQt/XIGj0YcGWpDH94q1mu4nXYmxdSw==
X-Google-Smtp-Source: AA6agR4aITQTADwiVUXxyp6BUlgb/rZ2u5TFZhNwXKPIPA5u5HQHHScwPgeS/ydmNebwI541PdLQsw==
X-Received: by 2002:a05:620a:4154:b0:6b9:6563:daa1 with SMTP id k20-20020a05620a415400b006b96563daa1mr2408811qko.563.1659985752643;
        Mon, 08 Aug 2022 12:09:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b00342f8984348sm2780163qtb.87.2022.08.08.12.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:09:11 -0700 (PDT)
Date:   Mon, 8 Aug 2022 15:09:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update generation of hole file extent item when
 merging holes
Message-ID: <YvFfVbEMitFzBHiC@localhost.localdomain>
References: <98d51d2ad8fca034c9605605394c15b516f13e5d.1659956764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d51d2ad8fca034c9605605394c15b516f13e5d.1659956764.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 12:18:37PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When punching a hole into a file range that is adjacent with a hole and we
> are not using the no-holes feature, we expand the range of the adjacent
> file extent item that represents a hole, to save metadata space.
> 
> However we don't update the generation of hole file extent item, which
> means a full fsync will not log that file extent item if the fsync happens
> in a later transaction (since commit 7f30c07288bb9e ("btrfs: stop copying
> old file extents when doing a full fsync")).
> 
> For example, if we do this:
> 
>     $ mkfs.btrfs -f -O ^no-holes /dev/sdb
>     $ mount /dev/sdb /mnt
>     $ xfs_io -f -c "pwrite -S 0xab 2M 2M" /mnt/foobar
>     $ sync
> 
> We end up with 2 file extent items in our file:
> 
> 1) One that represents the hole for the file range [0, 2M), with a
>    generation of 7;
> 
> 2) Another one that represents an extent covering the range [2M, 4M).
> 
> After that if we do the following:
> 
>     $ xfs_io -c "fpunch 2M 2M" /mnt/foobar
> 
> We end up with a single file extent item in the file, which represents a
> hole for the range [0, 4M) and with a generation of 7 - because we end
> dropping the data extent for range [2M, 4M) and then update the file
> extent item that represented the hole at [0, 2M), by increasing
> length from 2M to 4M.
> 
> Then doing a full fsync and power failing:
> 
>     $ xfs_io -c "fsync" /mnt/foobar
>     <power failure>
> 
> will result in the full fsync not logging the file extent item that
> represents the hole for the range [0, 4M), because its generation is 7,
> which is lower than the generation of the current transaction (8).
> As a consequence, after mounting again the filesystem (after log replay),
> the region [2M, 4M) does not have a hole, it still points to the
> previous data extent.
> 
> So fix this by always updating the generation of existing file extent
> items representing holes when we merge/expand them. This solves the
> problem and it's the same approach as when we merge prealloc extents that
> got written (at btrfs_mark_extent_written()). Setting the generation to
> the current transaction's generation is also what we do when merging
> the new hole extent map with the previous one or the next one.
> 
> A test case for fstests, covering both cases of hole file extent item
> merging (to the left and to the right), will be sent soon.
> 
> Fixes: 7f30c07288bb9e ("btrfs: stop copying old file extents when doing a full fsync")
> CC: stable@vger.kernel.org # 5.18+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
