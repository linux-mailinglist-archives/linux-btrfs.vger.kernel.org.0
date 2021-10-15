Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA542F8E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbhJOQ4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbhJOQ4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 12:56:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D2C06176E
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 09:53:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so7690484pjb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/gIfzDIY8BHp2GAnTGqbUaWifgLmmgJaZHOEikCPNE=;
        b=ijCBeqwjSX44JYJYQXxoOlzCMaUqE2c/FshvcWt5AOJ7Pdw2meC8GD81XASC91VnuZ
         nItwuK+FFfu4fuFDPeSQcXw9Uz1W4h2xhJCY/Ev6pPXPQ0ELlFXiago1MNdfKztmZVkX
         OUFTCDErJi6w26qIfF+omjAVxqFsWClXKietM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/gIfzDIY8BHp2GAnTGqbUaWifgLmmgJaZHOEikCPNE=;
        b=j/BizxwPmdeOG/rcTBPpI5bnps2g5B2MzvlLuA9M/jk52szhM0nW8dbdUQsyW3gd6r
         vbDqOXP86OzMfsYy1rcp6C61eoUe5vThKJ43US/KsqY9t0dKc63snbjzUW+cwDQgoT/I
         cZEftZ62jvKA1tIF0ROsJxoGURyKXC8UE4xFr0gDyzRXrrIMpzMmjq9Z8yqiIoPMnqRN
         qpBhA7rKxmugJHz5zKAqlFDEVIEI5ChnhutE636o+cyk9YwZDJrVl182narpHLJAKHi0
         wKL6DNFj9F6DZKTMrt5IO5vxLI7uYaZ5BgyLrFOXwizApxFFcxQr6gF1t327tzpLj0Ts
         p33A==
X-Gm-Message-State: AOAM530D5Y/HRxTHm+aB3C+ZzFMzlaMZTstnAORQ7GLdkgcaS8YE/gWP
        7xpNW7uZbyEgA3Kjfc+VxVkz6g==
X-Google-Smtp-Source: ABdhPJwk57gXwSH1fuk9uQJ3MKRp8IS5de92E1niz0LUeVepi4gZ7xD6FT4x0ovJQOMjXdqoZrATMw==
X-Received: by 2002:a17:902:eccf:b0:13e:b002:d8bd with SMTP id a15-20020a170902eccf00b0013eb002d8bdmr11944496plh.48.1634316833234;
        Fri, 15 Oct 2021 09:53:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm5286487pfh.168.2021.10.15.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:53:52 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:53:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 17/30] jfs: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150953.4C55C8948@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-18-hch@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:30PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
