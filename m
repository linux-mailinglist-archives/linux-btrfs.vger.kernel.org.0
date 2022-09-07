Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5B5B0DA2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIGUAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIGT75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 15:59:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E413135A
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 12:59:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso26979pjm.5
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Eb8WB/DJWxxPSuvWAK4Z4tebfxzVH+ZIa8KVMkM6K94=;
        b=SQ6zQsnTMT8PGNqc1MSsO27cpv8q35vsGt0DMRaliIafT4dxQy7shjUAl9YO8lPaGB
         QW5Ak4gX/dBig+P5rY7+F0AVa9Bqq9RmXDxc3gO0s8E4MGEWLMAp3aTz3Mn070wb01PY
         BI+/1TlnB5DGCNY3b1IAnU67Mk7p/tLsp0Oz386sig0M2XD/t2Dqc3FwT/HCP2LoPJtq
         WTcoMV/KCKCjaTYcZMDhpxCb0fIA1Lv3HUeIgXq8fLcQO7TX66Cw5B2Mmd/xgyxndTCM
         wgu7onKbf5G9uxCHClQVvuRVq/XTdGZGvZNdBCzWzaVuNzDvF9qfzjNktgzlfM9iiwZd
         u+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Eb8WB/DJWxxPSuvWAK4Z4tebfxzVH+ZIa8KVMkM6K94=;
        b=j7ZGBr3Q+3iSzqQDF1dkxkBbKeZ4Uu1PCo6lrBxx4/Jhy1UW6tAif+CoQD25zr5VoP
         2D+RbewnBn1NLPzQ5PmKNBPyHskGbOxT1SaSwVWPyMm7nOFSkXPUXgiT7yfT1nTngjWr
         65Sh1oTNOsBaWH7xFUDwCs9NYsyl+FSMZBOEa66OCLOK4OfkAV/0rfbKC9JO+CNxjwvg
         lvg12upUfFSe2F/PEFx5f/lNRWMaWPA4xEQyg84qvfFNh7ONdiftIer3DdOE/Kw4UdWF
         VqjK9bLluQtK/pmjF2PMCGVXL2zHsGC2kX5AukxlzXFgw88jwUGYPDU3YtYQ9rw2P4Fn
         06WA==
X-Gm-Message-State: ACgBeo0/5RequgY/i/A+WNjpsEqdyVMAfazorT9xQeIkpI/+aIvAckcz
        UzRYaub3qlQQTfj9gZHkk8578A==
X-Google-Smtp-Source: AA6agR6i9q4YW5TIa519fGuZSqLWjI2qqN8OdEVdJudbHUROM44nB/W3NeIgqooQZr+LMGmO4U1IJw==
X-Received: by 2002:a17:90b:1e47:b0:200:b9b4:ba1e with SMTP id pi7-20020a17090b1e4700b00200b9b4ba1emr168629pjb.172.1662580795302;
        Wed, 07 Sep 2022 12:59:55 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:52ee])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ab9200b001750792f20asm12693015plr.238.2022.09.07.12.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:59:54 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:59:52 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 05/20] fscrypt: add extent-based encryption
Message-ID: <Yxj4OAvgNj8bMN15@relinquished.localdomain>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
 <48d09d4905d0c6e5e72d37535eb852487f1bd9cb.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d09d4905d0c6e5e72d37535eb852487f1bd9cb.1662420176.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:20PM -0400, Sweet Tea Dorminy wrote:
> Some filesystems need to encrypt data based on extents, rather than on
> inodes, due to features incompatible with inode-based encryption. For
> instance, btrfs can have multiple inodes referencing a single block of
> data, and moves logical data blocks to different physical locations on
> disk in the background; these two features mean inode or
> physical-location-based policies will not work for btrfs.

I really like how this abstracts away the encryption details from the
filesystem.

> This change introduces fscrypt_extent_context objects, in analogy to
> existing context objects based on inodes. For a filesystem which uses
> extents,

This makes it sounds like all filesystems that store allocations as
extents should define these, but ext4 (for example) uses extents but is
fine with inode-based encryption policies. Perhaps this can say
something like "A filesytem can opt into the extent-based encryption
policy by defining new hooks that manage a new fscrypt_extent_context."

> a new hook provides a new fscrypt_extent_context. During file
> content encryption/decryption, the existing fscrypt_context object
> provides key information, while the new fscrypt_extent_context provides
> IV information. For filename encryption, the existing IV generation
> methods are still used, since filenames are not stored in extents.
> 
> As individually keyed inodes prevent sharing of extents, such policies
> are forbidden for filesystems with extent-based encryption.

This ends up forcing Btrfs to use Adiantum. However, I imagine that most
users would prefer to use AES if their CPU has AES instructions. From
what I understand, it should still be possible to use the AES encryption
modes with extent contexts, correct? We just need to decide how to make
that work with the encryption policy flags. I see a couple of options:

1. We add a specific FSCRYPT_POLICY_FLAG_EXTENT_BASED or something like
   that which the user must specify for filesystems requiring
   extent-based encryption.
2. The "default" mode (i.e., none of DIRECT_KEY, IV_INO_LBLK_64, nor
   IV_INO_LBLK_32 are specified) automatically opts into extent-based
   encryption for filesystems requiring it.

Either way, we should probably still disallow IV_INO_LBLK_64 and
IV_INO_LBLK_32 since neither of those make sense with per-extent IVs.

I'd love to hear what Eric would prefer here.

Thanks,
Omar
