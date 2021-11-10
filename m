Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9F44CAB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhKJUhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhKJUhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:37:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C7C061767
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:34:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t11so3359130qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pLMo7yji4oTRxu0asWqEVTwXX803tqx41OgUyq4EXU=;
        b=lxPv6rW1PqMzBhAzITif8LRyGNRr2rch8gSEPDAw/zg78VVvDrPt9E/E2uPaPoM/aK
         KQZoh/BbUmWxoiSYjHllurBcaBsdrD/x12AMvtUEdfjaNq4nKuS6y4x9b8LCMshjus0z
         jnhu/KZi1x26xyNO2P6+lTrBOdacA7/kH+jvMC0EozkPRkjXQSu1taj3r8eeKWoGEKlA
         gIjmV9Y9BsekIG6GJdXa+LUiX/0xBl5uhXovNmfZbO0dJzB4FbCmVAgQu41DsPqolV0b
         UvPz5jH0HGnGbnpEj9AAYn/IbVC3uxwoB9mOmtWjx/chZGQkfnx2c+PL2QiXPqVrA5wW
         s8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pLMo7yji4oTRxu0asWqEVTwXX803tqx41OgUyq4EXU=;
        b=YOLiWbbfX//+MLq1pi+GIugIihKfymz1Ig3aIRGdU6ehBgpnBThwF8xDivxC88DZzz
         z2n0vvTkz6n0PTMRX9AQWDHTunRyw0hvoi/DtDOkqX+fvKVk1gVeYf2MWaa/fGghiZa5
         8DGi12BVfZbHNpIVdLj5KhAiTKIa67evB04hUSBtoy2j/r7kz0bOXJlKzlxOwnM1IIY9
         dgBoTMTLHhLTN+gOPxlmKj/EdbIY8XEiPae2FnNHCyUnmie+ZV9wvFjmaJVYjjiP8UOg
         R59GaAaoPZbunvx82a6mAkXGN/1lE0IwkSrhX08KzK0HtcKG6QgvCvBkCUjDQN19n3Zn
         c2zw==
X-Gm-Message-State: AOAM530LIO+5HvIsQddJFFM2tj+rSaFrxUgVvHTqtZNV/ojAv8zVxgbh
        D3ZhRBDBTLVwfX3jG0H+UfgmpA==
X-Google-Smtp-Source: ABdhPJw28ba0kyPFwpYXq5FsysZIz91rbsDRgNMw/eM3LOf18dXMnho+w2vzKfF3u6KPAITbUXCLXA==
X-Received: by 2002:ac8:5812:: with SMTP id g18mr1977474qtg.392.1636576473463;
        Wed, 10 Nov 2021 12:34:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u8sm506287qkp.21.2021.11.10.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:34:32 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:34:32 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make 1-bit bit-fields unsigned int
Message-ID: <YYws2G9kgER/zeeg@localhost.localdomain>
References: <20211110192008.311901-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110192008.311901-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 07:20:08PM +0000, Colin Ian King wrote:
> The bitfields have_csum and io_error are currently signed which is
> not recommended as the representation is an implementation defined
> behaviour. Fix this by making the bit-fields unsigned ints.
> 
> Fixes: 2c36395430b0 ("btrfs: scrub: remove the anonymous structure from scrub_page")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
