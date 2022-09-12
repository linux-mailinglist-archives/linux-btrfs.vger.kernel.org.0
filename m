Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DA5B5FC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiILSC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiILSC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 14:02:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D51FCF0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:02:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 3so6232143qka.5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SgNgBeFmKyyBZUV8+J0bNcWZtz1TrzwuByb03z3sKm8=;
        b=QCFUoARJz6TDvG/uEYYyJG345J5N3+iLyulSyJtWBW8AphUfTLvd6w5KwQJCvLdhiP
         1nh2ipShuH3TT3MPC3N6fYVzAapmgPgXAkAVn+VhdjhEJ2xO+0W5jrB+/kNmDydBMuxp
         5bHdVbIqmPU7Wvxdl5EvAzbruocayjdBfxexk7m9nvJD8H+BX1X4nnma5NG0UlMVT+LM
         lUhSeWKgCuSwuu/xS0rQCUNyu6oYrYlTwxjQB7ZxS0vdRMJdp6sHSW1SJHaxin5FowkJ
         dvzJ72WYLqg0jyI778sYF8WxQIzjTki/k0I2ahv0oMfplfY4NhK84pephF47SfkfOjWP
         jX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SgNgBeFmKyyBZUV8+J0bNcWZtz1TrzwuByb03z3sKm8=;
        b=IcrkSoiRIQuUv6hrVUaPFS+pR2Y5eKY1NsZZUgFbubbvFNom8y/tBQy2XZ97LzapsZ
         RR0ehKqWbnlkgOYiBtW1S2LKrL/NO2Tw6CQ0lCKMuvRSJj4Yn6Lf0euQWQT1TzaiGIJb
         zkqAKmAuxyUnj3giGMC/Wn79ioNYSSpiLuzigGAayM53hlqiK2U+jx0U/C8oq+r8Yrfy
         F2SCSMKjQ9P2djf2iRQAmPauwY9d6lKO6tdrI47xKXX4oZ9XPhejdFRrFqYbqCgAqR54
         a2Qiywj3+vifaCb6+oecskhSTVxOfySs1AHaP2pYdx1ujpmLKrr3YlYii3ywxjLUC6Gk
         Uv0A==
X-Gm-Message-State: ACgBeo1e5SLZQ49ssbLDvwO0rpVZ56lZMaNQ7LufDxiHr4e9icr7BVyG
        YIiRtkidaWeButxLozKCgeW1rw==
X-Google-Smtp-Source: AA6agR5DTTNiCwdo4LpkEQilllu4DgnHLaukaN6q+maE+Kop0rxNU0p7QKcrbB/t0rA3v/hD9zeASg==
X-Received: by 2002:a37:bf81:0:b0:6cd:dbcc:1592 with SMTP id p123-20020a37bf81000000b006cddbcc1592mr10906928qkf.290.1663005777007;
        Mon, 12 Sep 2022 11:02:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b006bb9381aee4sm8315017qkp.30.2022.09.12.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:02:56 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:02:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: move the low-level btrfs_bio code into a separate file (resent)
Message-ID: <Yx90T39LITBQPrZs@localhost.localdomain>
References: <20220912141121.3744931-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912141121.3744931-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 04:11:19PM +0200, Christoph Hellwig wrote:
> [resending because I forgot to Cc the btrfs list, sorry]
> 
> Hi all,
> 
> this small series creates a new bio.c file (and a bio.h header for it)
> to contain all the "storage" layer code below btrfs_submit_bio.  The
> amount of code sitting below btrfs_submit_bio will grow a lot with
> the "consolidate btrfs checksumming, repair and bio splitting" series,
> so this pure code move series triest to prepare for that by making
> sure we have a neat file to add it to.

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
