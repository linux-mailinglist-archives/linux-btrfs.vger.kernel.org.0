Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8E1813E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 10:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgCKJDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 05:03:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35069 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKJDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 05:03:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so940399pfb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+vCWkA03FyvDhW0dsoB0FwgC4ehCIC3p7R09pv1oUNc=;
        b=hXS1mbWUE/wbvazEe6lie7fHSo368SijO3XwMpz9NXjlcvKzlZXMcDvPpUqDMXCEs0
         7i/5uMmc0g9O6XuVMJeX02rtcI8pktToE8m3sFZt6t54H2pYjLZFvrYsMgIdQotRuZ7h
         cL/nyx845hIE38A2gEAMVgsC8rUDhBRVapPaogybcvsJMwK+Ss23k2i8As6dfuwfCqDY
         7LM5eLCtaIUucS2T8fUuh8/en1J8lyVAG7L8voan9x06xSgWONYiNdTsqJyMA1WCvVVb
         LTmXtFeYLjYgCjBhquhXakyAGj5OGBqyLFtctvBapobY2ntz2wKxM9vHmVdqJkmCDsV/
         OkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+vCWkA03FyvDhW0dsoB0FwgC4ehCIC3p7R09pv1oUNc=;
        b=WlnNVeeYfOc3/GrzY1x1rCWcLxDNY6kj1hLYiHo4wND37QJgPMOuN5RbxZn4rk38bD
         PCh0P3cI5crN9FWwqowbI93VMn2uD7+htczQgpkENPU49fpqhIeChQG2N3h9n9IvPEnP
         VVvr+2I29kXnlRo1E4/iDdmYviBaFbYQB5WGFno2pcibLGQ0jzECim5agbCOGfB+2A/J
         scZfPjkdxPnyRMlXIFw8wWQz/Kcbo8DH1+fW5zU44khEAt1dQV3z85ErhkmdCtG+pX2Z
         QsoTlZ2iWN/IzLytxgD5ZsGn3ZaEmKin6/0Yf0GXBF8r97CICJgaZfvk4tLlfv9ly2eW
         eQkA==
X-Gm-Message-State: ANhLgQ0myj5TiKi1s/sR+EM62zJ59deYEn5VPT3kyHNJ51fJS/ZZrcyB
        PWgHUGor49qtTXDGiRRwEyV4kA==
X-Google-Smtp-Source: ADFU+vuvu3VoyuQVknWQTtJ5Ukd52NL0KgMf2qghCk6O/Mcf1XojfXU1JI0FiKK2Jx7yRmU+ur3dPg==
X-Received: by 2002:a62:2e86:: with SMTP id u128mr1837396pfu.68.1583917409908;
        Wed, 11 Mar 2020 02:03:29 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id 70sm5056339pjz.45.2020.03.11.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:03:29 -0700 (PDT)
Date:   Wed, 11 Mar 2020 02:03:28 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 02/15] btrfs: fix double __endio_write_update_ordered in
 direct I/O
Message-ID: <20200311090328.GD252106@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <b4b45179cc951dde98feea48723572683daf7fb3.1583789410.git.osandov@fb.com>
 <20200310163024.GB6361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310163024.GB6361@lst.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 05:30:24PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 09, 2020 at 02:32:28PM -0700, Omar Sandoval wrote:
> > +static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
> 
> Just curious: why is this routine called btrfs_submit_direct_hook?

No idea. The name goes back to commit e65e15355429 ("btrfs: fix panic
caused by direct IO"), and it didn't make any sense then, either.

> it doesn't seem to hook up anything, but just contains the guts of
> btrfs_submit_direct.  Any reason to keep the two functions separate?

The only reason I didn't combine them is that it would make for a pretty
big, unwieldy function. Maybe folding btrfs_submit_direct_hook() into
btrfs_submit_direct() and splitting the dip setup into something like
btrfs_create_dio_private() would be more natural.

> Also instead of the separate bip allocation and the bio clone, why
> not clone into a private bio_set that contains the private data
> as part of the allocation?

Mainly because dip is not tied to any one bio, as we might need to split
up or retry bios. We also already clone the bios from a btrfs bioset,
although that doesn't have everything we need for direct I/O.

Thanks!
