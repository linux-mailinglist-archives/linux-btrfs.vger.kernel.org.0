Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD0602E64
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJRO01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRO00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:26:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C69AFB6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:26:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r19so9717188qtx.6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAtSjdlCEqTkQ5wbzlvLL8uwxJ3hH9ORwzYqZniWdH0=;
        b=NiH5nefpPmfPJv62q8jJBeKtsI31qZU54yrFlJHpU4UPF81NZvcyR/tom9plrVIxsT
         YjQuVF8wSCjurqI/N9xqGOMZagO+eni5jf9n7DwX1Vgf1Y1yPpmmjvtXKl+Cw08fsUJE
         8h+grTjiphbgNCW/j/zU+fAfUrVh+r2UgmuUlE4g3UxPI4QMtVFyUpmc2VQYrNVclq5C
         9G3e0sVyQDFInUmFU60uHz7hT8TxYbGFYNpdnZ50cq42YM7PeldLaIKSrk0/HVM09jwY
         7kzpPR/15CCDrg5/DZw3Ds5KVPeZAc7x/P0qdr3ZgcUqdvuawt3WmjRpOfOEcUtM6BoU
         E3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAtSjdlCEqTkQ5wbzlvLL8uwxJ3hH9ORwzYqZniWdH0=;
        b=ird92EMWXbkZXD6hxjJZO2fCorJCL594JbaCWcWmPmlWfFzE31FyEcPPJQg1URrViW
         jALQ288qaQpHrh4pkWx9xBd2erUiWD6ZijyC4Drb0M7WyCruz4hTrpB4Mr26BgYPCL2C
         c52rvMzzPKITfUse9kVZpXqoIxTxPBVoVIS6+m8kuE7hAPSKLpEHvaK8QZKkqDl2KsmY
         6bUOqJ8uX5Y546s5uZUdEVTkmqXuKmp5HX5/gIZjJ5iEczzO/CGf8k3mzkbvg5M2s+Dx
         fSynF4Ddd7qwEe/RraSaPVnLz+tDHfQPapPjr6TPCEhlHGgpmVkypYLgTImS8uXwfmjE
         foSw==
X-Gm-Message-State: ACrzQf1GgfYysZEN5RZsAoshxUzXRjaVsbnhV7fU+yCGLdGrqkdCVrzQ
        jHy3uLlh8g/hZsrTkTln59Rjxt7clU2QYA==
X-Google-Smtp-Source: AMsMyM5o1B3RwmuwH4VHOsS6yy6EgXIBK+KiDTd0R+mp0HDT8/bPOCtL8wos0lQD/zblLoXiQwa51A==
X-Received: by 2002:a05:622a:4c8:b0:39c:d6d2:32f7 with SMTP id q8-20020a05622a04c800b0039cd6d232f7mr2248239qtx.517.1666103184409;
        Tue, 18 Oct 2022 07:26:24 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id f4-20020ac84984000000b00398426e706fsm1955927qtq.65.2022.10.18.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:26:24 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:26:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: avoid GFP_ATOMIC allocation failures during
 endio
Message-ID: <Y063jxizj7FeZLy5@localhost.localdomain>
References: <cover.1665755095.git.josef@toxicpanda.com>
 <20221017142516.GQ13389@twin.jikos.cz>
 <Y02aAoQDtAoit8xL@localhost.localdomain>
 <20221018124229.GT13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018124229.GT13389@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 02:42:29PM +0200, David Sterba wrote:
> On Mon, Oct 17, 2022 at 02:08:02PM -0400, Josef Bacik wrote:
> > On Mon, Oct 17, 2022 at 04:25:16PM +0200, David Sterba wrote:
> > > > 
> > > > This is perfectly safe, we'll drop the tree lock and loop around any time we
> > > > have to re-search the tree after modifying part of our range, we don't need to
> > > > hold the lock for our entire operation.
> > > > 
> > > > The only drawback here is that we could infinite loop if we can't make our
> > > > allocation.  This is why a mempool would be the proper solution, as we can't
> > > > fail these allocations without brining the box down, which is what we currently
> > > > do anyway.
> > > 
> > > Aren't the mempools shifting the possibly infinite loop one layer down
> > > only? With some added bonus of creating indirect dependencies of the
> > > allocating and freeing threads.
> > 
> > bio's use mempools for the same reason, the emergency reserve exists so that we
> > always are able to make our allocations.  Clearly we could still end up in a bad
> > situation if we exhaust the emergency reserve, but the extent states in this
> > particular case don't get allocated a bunch.  Thanks,
> 
> I think that bios are the only thing that works with mempools reliably
> because it satisfies the guaranteed forward progress. Otherwise the
> indirect dependenices lead to lockups in the allocation, which is
> equivalent to the potentially infinite looping. The emergency reserve is
> another finite resource so it can get exhausted eventually, and it's
> not scaled to the number of potential requests that could hit the same
> code path and competing for the memory. It's true we'd be dealing with a
> system in a bad state and depending on another subsystems make it less
> predictable. The simplest options are wait or exit with error.
> 

Yup, this is why I didn't do the work now, becuase I don't want to use an
emergency reserve for every extent io tree operation, otherwise we're going to
run into trouble.

I only want to do it in the case of the endio handlers, since that is for
forward progress, and for EXTENT_LOCK, for the same reason.  However IDK how it
would look to have mempools where we allow failures in some cases but use the
emergency reserve for others.  It's an area for future investigation, for now
this is a step in the right direction.  Thanks,

Josef
