Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3859B9D897
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfHZVgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 17:36:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40782 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHZVgW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 17:36:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so9578932qtq.7
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0eax+WogD7hVPZreR7OtFQrpZLYB7kqkGW+RjtqOEY=;
        b=C+Wrb1KQchUhNrx0+PuniI0NB0DD3m+eRgVaHV96V7mfxkkNU+rHMVcD72kF7PfDI/
         hJQcD7DyGZCUuH6h7PinGh78c8iD0x4yGZgzeDzoTNUwmHSiWl62HC7S/xYbTyMEm9Mq
         sdqBFFQXpyzdpUM4WH454WDtejMCXx5PXiffOFy+aNC7Z0VsgAna1rK+iTpKxgUOL4Bk
         BMGguMK+bJCdy/3acWD+XkGLFjuMTGXfzEDiPhX99tw2wPh50ebmsb5PrxrLyuJeKsqy
         GBLqv3R64TCErKd6xcb+z1Qwwtg7YUcX/phuEx/cCDyM2tlZMyR+fAne0gsYxT2mo7WL
         oCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0eax+WogD7hVPZreR7OtFQrpZLYB7kqkGW+RjtqOEY=;
        b=G5VDFelkDiVmrvvBonowd6Z5qmbuWqPwnQ6Ckox5fAuX6YAVfYLuwzVC/XXZMlpvBn
         erfLhqdbuI2VJi74o3mCcFahgmQbIus/I4PvP65Z8wQr9PuvfO3eky2M66rl8alFjykb
         pSgj9xydyZa+FaGr6Zh9TZfIj4M6OtBc/laqavykOI+EEFYi0mcGY1DIbGLo8EXzLZ0S
         3kfUHweZoHh0oqAgitl8Qebq9tJhaT7D96ThdEM9bR9rJbARYsLFxVeGq6ZH/EZAHNtr
         whn4sGvzVyVgsACiWpFv3i6UKnykGqcTZqWAubA4/C/Uz6f4TJTyYrfArsX6uF+6RPg3
         A8+A==
X-Gm-Message-State: APjAAAXMr9wXiOhiwYt7MTVQgW2iLDKyTPy6chgSnaf8E5Y6Do9dNHFI
        f+u/osFgss4UjuLXwvdM95NX8RdYt4ZMuA==
X-Google-Smtp-Source: APXvYqy4OUl0mooF9SKX5wom/u4CDPDFpcV55QzHF84O1k98joBZURi61OVdeUhdlVkxkYLQw4XkKw==
X-Received: by 2002:ac8:74d5:: with SMTP id j21mr16477585qtr.60.1566855381552;
        Mon, 26 Aug 2019 14:36:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ef77])
        by smtp.gmail.com with ESMTPSA id m92sm8142180qte.50.2019.08.26.14.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 14:36:20 -0700 (PDT)
Date:   Mon, 26 Aug 2019 17:36:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190826213618.qdsivmmwwlxkqtxc@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds an API for writing compressed data directly to the filesystem.
> The use case that I have in mind is send/receive: currently, when
> sending data from one compressed filesystem to another, the sending side
> decompresses the data and the receiving side recompresses it before
> writing it out. This is wasteful and can be avoided if we can just send
> and write compressed extents. The send part will be implemented in a
> separate series, as this ioctl can stand alone.
> 
> The interface is essentially pwrite(2) with some extra information:
> 
> - The input buffer contains the compressed data.
> - Both the compressed and decompressed sizes of the data are given.
> - The compression type (zlib, lzo, or zstd) is given.
> 
> A more detailed description of the interface, including restrictions and
> edge cases, is included in include/uapi/linux/btrfs.h.
> 
> The implementation is similar to direct I/O: we have to flush any
> ordered extents, invalidate the page cache, and do the io
> tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> the compression code with a minor modification to distinguish the new
> ioctl from writeback.
>

I've looked at this a few times, the locking and space reservation stuff look
right.  What about encrypted send/recieve?  Are we going to want to use this to
just blind copy encrypted data without having to decrypt/re-encrypt?  Should
this be taken into consideration for this interface?  I'll think more about it,
but I can't really see any better option than this.  Thanks,

Josef 
