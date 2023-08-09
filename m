Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74908776937
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjHITwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHITwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 15:52:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C810DC
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 12:52:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40e268fe7ddso669601cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691610733; x=1692215533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cchV/w9Yz0rr8INUr8CsTYgOUjuaJxljRUUvjHbpA4=;
        b=1R7hffHSrpP5B1/WSFzU+2GfIaNVUBlEMkh4zXvTp4Zi34ILoB50Aw3TYNC/J/WQhn
         HhlBFSs5gkeQ8yJwtyWeKEVW4h5BZp4+niTtLjhYbQiodF8wGPP4Yxo24t2BJi+A01/R
         Jk1e5PQtrmJnrYug6qJ6Uos/fgPJGil6r96XsK462snyZs/zPGtGcH2tqvH009sd6RqB
         Ia/2wfcUHw34G9WkgKkvTnZ0AgV2z3PdjYla7USQrtjl0XtKYugUOJHl9nMcLSwvpnJV
         NumpcBjqLeKUMUOkL6Z/GWgyYDpjetLPd6fMkrDYc58WA8x8qzkOs0l2Uq/AoKAYl7M1
         wIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691610733; x=1692215533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cchV/w9Yz0rr8INUr8CsTYgOUjuaJxljRUUvjHbpA4=;
        b=Q5r+76sEE/ly+/LWvF1r3UWJVAPVTQNUcF8icUjBqqAQbkMfcDBgX1KIBsN34jWt3M
         pibLmT9KVZ5BL8jMyXgn4GnI0zKqaDPYsCyUPZoz8sKxhrP3MA2O02ysjAKW8Hqexl9s
         F4Dxm7r2Ex6S0GZjC4DaUIGh/RAIRtThoeL6GdhxRWl26nbRInm7Nb4V4vwGN7aRiTRy
         c1APf0MDHSSATt0RCDevZQ8TuZNt2WD4FB8nFT2tHmzMXnr0wNKDeOYYB9urGlpwLfCk
         RpfHgoOm1QMv6l+WMjEtbnCHoi03yCaCsG6LVxfeg/ZXsk8YEAE5P6FN6aCeTh2dd5Y1
         u7Uw==
X-Gm-Message-State: AOJu0Yxhx84E8RUbbxSMAaqJ9REYEptGabDgUn8Bt8IRRAdlmeRbf5oU
        ZlLkNYRD8u98f+sCiWcD08Jbeg==
X-Google-Smtp-Source: AGHT+IGundbJn7xsz+U+FTQgWzM6pgy2ibHhdr+fV6le1IX3jWoPYr3WE1rSwGjBbaMfqLLRVXeYQw==
X-Received: by 2002:ac8:7f49:0:b0:40f:da00:f075 with SMTP id g9-20020ac87f49000000b0040fda00f075mr402624qtk.66.1691610733504;
        Wed, 09 Aug 2023 12:52:13 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p19-20020ac84613000000b004055d45e420sm4306277qtn.56.2023.08.09.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:52:13 -0700 (PDT)
Date:   Wed, 9 Aug 2023 15:52:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3 00/16] fscrypt: add extent encryption
Message-ID: <20230809195212.GA2561679@perftesting>
References: <cover.1691505882.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691505882.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:08:17PM -0400, Sweet Tea Dorminy wrote:
> This changeset adds extent-based data encryption to fscrypt.
> Some filesystems need to encrypt data based on extents, rather than on
> inodes, due to features incompatible with inode-based encryption. For
> instance, btrfs can have multiple inodes referencing a single block of
> data, and moves logical data blocks to different physical locations on
> disk in the background. 
> 
> As per discussion last year in [1] and later in [2], we would like to
> allow the use of fscrypt with btrfs, with authenticated encryption. This
> is the first step of that work, adding extent-based encryption to
> fscrypt; authenticated encryption is the next step. Extent-based
> encryption should be usable by other filesystems which wish to support
> snapshotting or background data rearrangement also, but btrfs is the
> first user. 
> 
> This changeset requires extent encryption to use inlinecrypt, as
> discussed previously. 
> 
> This applies atop [3], which itself is based on kdave/misc-next. It
> passes encryption fstests with suitable changes to btrfs-progs.
> 
> Changelog:
> v3:
>  - Added four additional changes:
>    - soft-deleting keys that extent infos might later need to use, so
>      the behavior of an open file after key removal matches inode-based
>      fscrypt.
>    - a set of changes to allow asynchronous info freeing for extents,
>      necessary due to locking constraints in btrfs.
> 
> v2: 
>  - https://lore.kernel.org/linux-fscrypt/cover.1688927487.git.sweettea-kernel@dorminy.me/T/#t
> 
> 
> [1] https://docs.google.com/document/d/1janjxewlewtVPqctkWOjSa7OhCgB8Gdx7iDaCDQQNZA/edit?usp=sharing
> [2] https://lore.kernel.org/linux-fscrypt/80496cfe-161d-fb0d-8230-93818b966b1b@dorminy.me/T/#t
> [3] https://lore.kernel.org/linux-fscrypt/cover.1691505830.git.sweettea-kernel@dorminy.me/
> 

Other than the patches I had comments about this series looks good to me.  You
can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series once you've cleaned up my other comments.

Eric I did my best to try and review these in the context of all the code, I've
gone and looked at how it ties into the btrfs stuff and I've looked at the final
state of the code, it looks good to me, but clearly I don't have the experience
in this code that Sweet Tea or you have.  Thanks,

Josef
