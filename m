Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B7798923
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 16:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbjIHOqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjIHOqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 10:46:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD61BF1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 07:46:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64a70194fbeso13555556d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694184373; x=1694789173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMqlwyt9kCOVlT4uGsL19LP0jD3q7w2MOX65ZKrDdWQ=;
        b=cFi48BJXyiXg7bTi849gXpqKiQIAZWwqbG2KA1TuqbP6Vxx857ZTP6TEg+PYy5OHSx
         ZYSqtbOOOqR1+jWIZ09tAYgciPSVaD/V4PUVJJhWca1LKA3Xi8906A1OnkpthwG6/jWv
         yV8NRIDU2gNuEoHhZj/HJPxD6zIDBpF0+IROG7QW00VHjDKq2nqIDY0TxLIbwPqgFC3B
         fKo0i+UHFPCqpsjJhWOl/TbWHcU5kZiQASyCNjVqGRR0kNYDPU+/1UDfeD7Go38oAfZ+
         DaV9N9yBfKm+u1YrgPPZYJjQ/O4+wMtFbzgTvrrOpjkdliHh0b7Ny1b1cZjpe6irGctD
         Qn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184373; x=1694789173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMqlwyt9kCOVlT4uGsL19LP0jD3q7w2MOX65ZKrDdWQ=;
        b=ve7gS1C51KOYKfn+596e2QoLXsWLi4/uz+5RMUjTe9JVDn246OHd3wca9bXrm966ej
         f1urlSRZITuCLIREqJgUwQIQ97R/0OUUrXsYjuG/iqp4aWnLkUexQLPTU51MZL0tAVpn
         AEz+Ki8pxWY0Azpr9SvelxlE7KLhufBDGrNQyAGvW11DJKaUj+2tgOKBMez5uHWJpE18
         AJfHw8BMFGw4u4BT2IAY5Ni0u2u1H1to9gOKifGBDpwSld5WnSiMJ8ECkUdG2OSE8gfA
         8Hn+7uZVgg5Vts5pKKfqNobq5wy4EbBR3qTTRH9MDYaNL2Phg2iPpzevPK5RBmv2O4zZ
         dx+w==
X-Gm-Message-State: AOJu0YyySiENBb1OmMhwJfp7kvnb9v3efkdUNeGeEz+AtG2kIdoiaC9r
        rO9Ef/cV9UWJPZbIj9USgKogSA==
X-Google-Smtp-Source: AGHT+IHvZdn7D7xe0QMfzIHo0V4ce/927Cu2GqKnAcbeH0nGp8wgCqXDcC66fx859sn3byQGsoADQw==
X-Received: by 2002:a0c:fbcc:0:b0:651:6545:c74d with SMTP id n12-20020a0cfbcc000000b006516545c74dmr2688200qvp.52.1694184372984;
        Fri, 08 Sep 2023 07:46:12 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r1-20020a0cb281000000b0063cf4d0d558sm750328qve.25.2023.09.08.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:46:12 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:46:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/21] btrfs: fix race when refilling delayed refs block
 reserve
Message-ID: <20230908144611.GB1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <ad77c4035370a5db4e0b813da9eff73e52fd30c0.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad77c4035370a5db4e0b813da9eff73e52fd30c0.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have two (or more) tasks attempting to refill the delayed refs block
> reserve we can end up with the delayed block reserve being over reserved,
> that is, with a reserved space greater than its size. If this happens, we
> are holding to more reserved space than necessary, however it may or may
> not be harmless. In case the delayed refs block reserve size later
> increases to match or go beyond the reserved space, then nothing bad
> happens, we end up simply avoiding doing a space reservation later at the
> expense of doing it now. However if the delayed refs block reserve size
> never increases to match its reserved size, then at unmount time we will
> trigger the following warning from btrfs_release_global_block_rsv():
> 
>    WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
> 
> The race happens like this:
> 
> 1) The delayed refs block reserve has a size of 8M and a reserved space of
>    6M for example;
> 
> 2) Task A calls btrfs_delayed_refs_rsv_refill();
> 
> 3) Task B also calls btrfs_delayed_refs_rsv_refill();
> 
> 4) Task A sees there's a 2M difference between the size and the reserved
>    space of the delayed refs rsv, so it will reserve 2M of space by
>    calling btrfs_reserve_metadata_bytes();
> 
> 5) Task B also sees that 2M difference, and like task A, it reserves
>    another 2M of metadata space;
> 
> 6) Both task A and task B increase the reserved space of block reserve
>    by 2M, by calling btrfs_block_rsv_add_bytes(), so the block reserve
>    ends up with a size of 8M and a reserved space of 10M;
> 
> 7) As delayed refs are run and their space released, the delayed refs
>    block reserve ends up with a size of 0 and a reserved space of 2M;
> 

This part shouldn't happen, delayed refs space only manipulates
delayed_refs_rsv->size, so when we drop their space, we do

btrfs_delayed_refs_rsv_release
 -> btrfs_block_rsv_release
  -> block_rsv_release_bytes

which does

        spin_lock(&block_rsv->lock);
        if (num_bytes == (u64)-1) {
                num_bytes = block_rsv->size;
                qgroup_to_release = block_rsv->qgroup_rsv_size;
        }
        block_rsv->size -= num_bytes;
        if (block_rsv->reserved >= block_rsv->size) {
                num_bytes = block_rsv->reserved - block_rsv->size;
                block_rsv->reserved = block_rsv->size;
                block_rsv->full = true;
        }

so if A and B race and the reservation is now much larger than size, the extra
will be cut off at the end when we call btrfs_delayed_refs_rsv_release.

Now I'm all for not holding the over-reserve for that long, but this analysis is
incorrect, we would have to somehow do the btrfs_delayed_refs_rsv_refill() and
then not call btrfs_delayed_refs_rsv_release() at some point.

This *could* happen I suppose by starting a trans handle and not modifying
anything while the delayed refs are run and finish before we do our reserve, and
in that case we didn't generate a delayed ref that could later on call
btrfs_delayed_refs_rsv_release() to clear the excess reservation, but that's a
decidedly different problem with a different solution.  Thanks,

Josef
