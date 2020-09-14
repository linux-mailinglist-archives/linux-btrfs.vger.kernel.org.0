Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC80269889
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINWEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgINWEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 18:04:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E67C061788
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 15:04:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so705221pfc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=122QFFwJe2x4F1qdD/MZmQmfxCbAtjAlMJ3u7EEjhaM=;
        b=Gv+hmym6P3T1YF0qrBPQKtKvs69VswlTODUYCBGaiSTmPffI5qi4UW2/CtgXerQ9vy
         HCaVI15E9rpFXh3WpVSvK53llmSz7TV3sIcO7WhhTeicFMM25M9NYdIEuZjROj1PCJDG
         rMecicMm1VCOmIQAKhV2tjZTVUjdZNqj+FIxh8A++01EpGV2co9Rj6XAKNuEwfS1xE92
         i/GQCt5HOCyNxw+c7gMJ2O3LfOmWX2UHBgwoPEM7PWn8DJks/y7U10yMGxoolzcmbp2y
         Vpc5aVFQpWhMoKToop1G7z9Fm9hpsUkq5/4AP0hhA54W1HdvQhvLRA20iRr7WzifsOCx
         eEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=122QFFwJe2x4F1qdD/MZmQmfxCbAtjAlMJ3u7EEjhaM=;
        b=JbX6QHv8cCxbls/BSMkdP/28pQi8Gs0Bdfutxhl9ZcPOrJajiIjEbmGcKUDM4yEt9s
         VoZ7Nu0HrhkteToPgvNdR1TMUVw7avk4ZjBamGpvmU866TTFwbSpy1oNjx3Te2pT2k0b
         j6EaIo05nLnw9kHLNTB1D0o8N7M7cgUtAJNvDlKwKxvxVTOMtOJuIWaVd+VnBkna6enB
         y4kn471qkVynzqEJIQi4gCw4MNB61slMV/npMN31Bm8uFWDpJlzFJI0eMTLkkANMg1MC
         PmafWsJgkBLAbvCmRz5tz0zHmJssUlXzUeEoX4t2CsISwPbzTdDEaKz/IjUO/9ehOh0N
         Jbiw==
X-Gm-Message-State: AOAM532keR/rveVIBQXPOaBs0JNL9O3jGH0LRft4A1gKElORmBWt6Q5y
        rJ7/GeAwLBsbrF4CtXMdcWs8fw==
X-Google-Smtp-Source: ABdhPJyAqKKwW7SA2J8rdHjjuMBlV6SJaI3waTYkClyJDUa61weH0xhDtSbPAb94PzCKTkFN8ogZww==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr12293650pgv.338.1600121089925;
        Mon, 14 Sep 2020 15:04:49 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
        by smtp.gmail.com with ESMTPSA id s8sm5111982pjm.7.2020.09.14.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:04:49 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:04:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: send: avoid copying file data
Message-ID: <20200914220448.GC148663@relinquished.localdomain>
References: <cover.1597994106.git.osandov@osandov.com>
 <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
 <20200911141339.GR18399@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911141339.GR18399@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 11, 2020 at 04:13:39PM +0200, David Sterba wrote:
> On Fri, Aug 21, 2020 at 12:39:52AM -0700, Omar Sandoval wrote:
> > +static int put_data_header(struct send_ctx *sctx, u32 len)
> > +{
> > +	struct btrfs_tlv_header *hdr;
> > +
> > +	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> > +		return -EOVERFLOW;
> > +	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
> > +	hdr->tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
> > +	hdr->tlv_len = cpu_to_le16(len);
> 
> I think we need put_unaligned_le16 here, it's mapping a random buffer to
> a pointer, this is not alignment safe in general.

I think you're right, although tlv_put() seems to have this same
problem.
