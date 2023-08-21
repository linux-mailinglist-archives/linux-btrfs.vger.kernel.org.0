Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45A783019
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjHUSQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjHUSQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:16:12 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5B126
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:16:04 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c4f6115bdso39612647b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641763; x=1693246563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgsXhrCDkaokpEPekuVj6RNmeSfd5JmzX2t3Syrz/NQ=;
        b=4n5LbbPm6fYxNkBPmqOZsunn7JZ+UOAXf/GQ8GGIZKzMj/CvUJw5iQSsmIWVrjNt72
         m3Vg0XytVuCzT5BBEgARJ5/7zRQflEnS0hP5yU740+23ApS0fQbOdeoLuVBCraQ4vQwh
         WVB8hoPMODcqT4wRvj2LMx7D829yAe3+/fpc2qBYc6OtaK/O+SDh8scB1LtTEmFYRle6
         fITfPavoTI1KN5ULO+V/CA4dPMPx35dWeuAFJuiiShJ4fBJQjl9I+4pcIeMVN07JtOXb
         sqFyXtA66mYz0hFq0Rpk59pG6ZKf5ufV9ljXxZjPu6dGLHWX5RAPlQB6qqNpOWNQllXg
         bmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641763; x=1693246563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgsXhrCDkaokpEPekuVj6RNmeSfd5JmzX2t3Syrz/NQ=;
        b=R81AWtraWEPbEWib7gbTxlokR8EcCqkTmO2TKSRR0tbcnk5XLrmMtkwyYbrukYa8Y8
         NIFhVqKbyGT1pdJXjX+t1yxej5fBLXk+tyFVkxFyvV1qbXmbqrYnbF2iiz5baBJpc6xO
         UjAkNttSCZ6vY8MIvnQJ3bjhrlCNu1jo2ug0osNEpTPgLarq94T+LaApmY95YqaFNsWD
         mhTBbBnkMXlx9w1sLWorLa26fZ4JjDPb3PU+OPv/dgJOpD3MfHeR/KdqKMKs9qY3k3MM
         Y4i70GIXdtxsec9Ij0YKmZn7ayKgljXQ2KzVyOjO9bB/9Y25NcrL5ytWCAw3oVpj56XF
         q/Vg==
X-Gm-Message-State: AOJu0YzXLHGtBo+dVhYVZ+nQly7dEP7ywKTtsBPEb9wD35Y348al3YtA
        C7jm46SOzvNA7k9IMyJdVNE2sA==
X-Google-Smtp-Source: AGHT+IGALEY8koTC+FICXsceYxwPwQsqbHPijnHMvC9fL1EoxIOGZKfe9RNjqzLE8vwD8zAnFpfVtQ==
X-Received: by 2002:a0d:d8d0:0:b0:56d:4d34:20c with SMTP id a199-20020a0dd8d0000000b0056d4d34020cmr8052240ywe.37.1692641763421;
        Mon, 21 Aug 2023 11:16:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w124-20020a0ded82000000b0057a57a9a932sm2321492ywe.107.2023.08.21.11.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:16:03 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:16:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 17/18] btrfs: track data relocation with simple quota
Message-ID: <20230821181602.GL2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <86397d08757a9fc03a69cd027f415a5537c53f69.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86397d08757a9fc03a69cd027f415a5537c53f69.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:04PM -0700, Boris Burkov wrote:
> Relocation data allocations are quite tricky for simple quotas. The
> basic data relocation sequence is (ignoring details that aren't relevant
> to this fix):
> - create a fake relocation data fs root
> - create a fake relocation inode in that root
> - foreach data extent:
>   - preallocate a data extent on behalf of the fake inode
>   - copy over the data
> - foreach extent
>   - swap the refs so that the original file extent now refers to the new
>     extent item
> - drop the fake root, dropping its refs on the old extents, which lets
>   us delete them.
> 
> Done naively, this results in storing an extent item in the extent tree
> whose owner_ref points at the relocation data root and a no-op squota
> recording, since the reloc root is not a legit fstree. So far, that's
> OK. The problem comes when you do the swap, and leave an extent item
> owned by this bogus root as the real permanent extents of the file. If
> the file then drops that ref, we free it and no-op account that against
> the fake relocation root. Essentially, this means that relocation is
> simple quota "extent laundering", since we re-own the extents into a
> fake root.
> 
> Simple quotas very intentionally doesn't have a mechanism for
> transferring ownership of extents, as that is exactly the complicated
> thing we are trying to avoid with the new design. Further, it cannot be
> correctly done in this case, since at the time you create the new
> "real" refs, there is no way to know which was the original owner before
> relocation unless we track it.
> 
> Therefore, it makes more sense to trick the preallocation to handle
> relocation as a special case and note the proper owner ref from the
> beginning. That way, we never write out an extent item without the
> correct owner ref that it will eventually have.
> 
> This could be done by wiring a special root parameter all the way
> through the allocation code path, but to avoid that special case
> touching all the code, take advantage of the serial nature of relocation
> to store the src root on the relocation root object. Then when we finish
> the prealloc, if it happens to be this case, prepare the delayed ref
> appropriately.
> 
> We must also add logic to handle relocating adjacent extents with
> different owning roots. Those cannot be preallocated together in a
> cluster as it would lose the separate ownership information.
> 
> This is obviously a smelly bit of code, but I think it is the best
> solution to the problem, given the relocation implementation.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
