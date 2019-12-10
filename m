Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A9118FD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLJSdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:33:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37965 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLJSdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:33:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so202157pls.5
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SWtesY2/RpLOr0mu8EFTXSPAhy6m8xNx9PpNak1K6cc=;
        b=n8CHcSEbNjCUmS9QB9/EH8RRGAE5Hl1sGdGRkHPeaE9MxdZB3wvCwJ/IgGTlN+41sH
         /9qWrp7eFhbPnKmCNWXEb7DvSsdX5bBynF3RVQmBkSwTRtYodO8yyeqDnx26RGb8e2g8
         pR/tqCxhR3d/VJJekO2LXraPMZf0XOSfUBfoPOwzSggdgi+X5GodWdg0ByNgTIijqx/f
         f2q3enmaPUMuyJoiqwrwC93hQ71j/7QzcfsxbunHm958HkLMl+hPR54Xj32fRNCI6PHw
         sj+2SW0jmSfcd/IXPf8jM3PIVUB7Lb/MW48enbnFUMFdsiQ/nMs31Ldc50StbnAxp/8e
         LeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SWtesY2/RpLOr0mu8EFTXSPAhy6m8xNx9PpNak1K6cc=;
        b=O2MlnTwoNzEIiw8n+UNsT9OzIeJ2TBY68VRpFuVj3Ciqmh6FJUuyiAHoQFpJb7kda8
         aefMG1aVecGxf53ZNX3BJ9/cTxvUWrppvmq7XqHahTMrHntLCGcUD8bQsFC4MpPQBaBk
         KW3/SDO/jL6HECBQo94y4aNuaSiRJb7owLvGO/p3ahlRK6e7dmZJUa2/IR3JxnLz39uV
         k7qQFBkaDf3HzFUJIFn9/3QT68VWLXobIw5jjF+QW5wQ9g2R+E/lkZAHNK9rnahpJPB0
         0o6lyAMRM/+6GfYm6lBT5GrFHDT5Cb5FTLIB0oKdrI5w4Vj6D7EjJeDkEBUBd5Dcwnxa
         BS5Q==
X-Gm-Message-State: APjAAAVWasWWf+tvmEfspT7OyOVg5JWcRcK02TQkkm652OzP3e/GalBy
        mH3HxE1etmitrM1s3hvKd5VVIqNZJ7LFig==
X-Google-Smtp-Source: APXvYqxGu5UF9l6ywl8ZE36k2o9/Y1RajAfMYCgWXoQH2ZjyYlIFcxdKGyCzQhiwYRF8BGQdAV922A==
X-Received: by 2002:a17:902:d203:: with SMTP id t3mr36955779ply.122.1576002779082;
        Tue, 10 Dec 2019 10:32:59 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:c519])
        by smtp.gmail.com with ESMTPSA id u23sm4312201pfm.29.2019.12.10.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:32:58 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:32:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: make btrfs_ordered_extent naming consistent
 with btrfs_file_extent_item
Message-ID: <20191210183257.GB204474@vader>
References: <cover.1575336815.git.osandov@fb.com>
 <1a8119f808ba10f315b4b6a37ce27896f1b113a4.1575336815.git.osandov@fb.com>
 <20191210182252.GF3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210182252.GF3929@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 07:22:52PM +0100, David Sterba wrote:
> On Mon, Dec 02, 2019 at 05:34:19PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > ordered->start, ordered->len, and ordered->disk_len correspond to
> > fi->disk_bytenr, fi->num_bytes, and fi->disk_num_bytes, respectively.
> > It's confusing to translate between the two naming schemes. Since a
> > btrfs_ordered_extent is basically a pending btrfs_file_extent_item,
> > let's make the former use the naming from the latter.
> > 
> > Note that I didn't touch the names in tracepoints just in case there are
> > scripts depending on the current naming.
> 
> Ok, though we've changed tracepoint strings as needed, it's sort of ABI
> but also not. In this case the change would affect 4 tracepoints.

What would you prefer in this case?
