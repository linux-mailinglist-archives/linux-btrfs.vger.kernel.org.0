Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFF386CE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbhEQW3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbhEQW3J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 18:29:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D2C06175F
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 15:27:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x188so5955840pfd.7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 15:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rp32pfq2apMKFD0ftnAk36tGqKQeEKqsfO9eY//kHYc=;
        b=xns74opwRYa0qABV6xUZeE1bv2ry92IPk5pmjoweWSy+Mv14Ck6iWu2C3LxzOpI4F4
         P8UzQnEK9lvjXYKntbotLorv7NgYMAa3KWvkbE88jCeRL5Ja/xUnttYkozCfVtKm12U9
         9f7fMz+WCB29dtnmv59r9fcRaq52W5c41oPScFY1QL9JUlu7VRM/AxJ68k3gWCXhOhkN
         mr5ElxOnEkwrsIX0hvtKdak0KfEpc3wZg0ZZFCGYiZh7nvIMhHDWWW6QXdWulEQGiFiK
         L/ePwWBt4gHSlTMzhoJmx0m3Qe/PdAIWSrgB0tI62w9ak23bU4EwuvOItL3rfZTFErda
         fOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rp32pfq2apMKFD0ftnAk36tGqKQeEKqsfO9eY//kHYc=;
        b=GWd/aaj7GvUjDzNJUECAj5Lla/KfAFd8Vk4+fsPIJxn3Raon7pZ60fTFACNgyf0TCj
         wbvkB8S9hJxw4I71q9AGHt7bQNJMoEltBDtJtm5G1te/RSFXsJ1HmnV3VHOGRo0BLO57
         6usop0u3HtBc70uubMtnwZL88MXgfIHjVClymJba2UGny8p0r+VQFvLb5f9Kkm6vP+p3
         L5vbxVYup+QsBsoIo7i2uTACj0yy6jISOaZr3zIoNmAK/nSSVPKF5loEZSKWy/1t33oh
         /PfrQrWQJWWV6KcECC2w8RxzrxS+ur6BYAU0s4NzQpzDA4JQDtkSB8nYHH6+zuENtm8C
         P+qQ==
X-Gm-Message-State: AOAM532r+ZwJH5f9JuamVFIIzr/OFDYRoC6MlkmHQVXS9r9MUR5AABnZ
        Q04HHiCr5CzPNmDgmOCia0dSzg==
X-Google-Smtp-Source: ABdhPJwOZsAr2depBcBQRACkwV3/LDqsgKuuVe+GhYd6PJVSRn7rMWArZoOkvFJopxNLE04qjlmIGw==
X-Received: by 2002:a63:7158:: with SMTP id b24mr1708763pgn.310.1621290470509;
        Mon, 17 May 2021 15:27:50 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id q18sm10915649pfj.131.2021.05.17.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:27:49 -0700 (PDT)
Date:   Mon, 17 May 2021 15:27:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YKLt5GyznttizBjd@relinquished.localdomain>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 17, 2021 at 02:32:47PM -0700, Linus Torvalds wrote:
> On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> > are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> > patch 9 adds Btrfs encoded write support.
> 
> I don't love the RWF_ENCODED flag, but if that's the way people think
> this should be done, as a model this looks reasonable to me.
> 
> I'm not sure what the deal with the encryption metadata is. I realize
> there is currently only one encryption type ("none") in this series,
> but it's not clear how any other encryption type would actually ever
> be described. It's not like you can pass in the key (well, I guess
> passing in the key would be fine, but passing it back out certainly
> would not be).  A key ID from a keyring?
> 
> So there's presumably some future plan for it, but it would be good to
> verify that that plan makes sense..

What I'm imagining for fscrypt is:

1. Add ENCODED_IOV_ENCRYPTION_* types for fscrypt. Consumers at least
   need to be able to distinguish between encryption policy versions,
   DIRECT_KEY policies, and IV_INO_LBLK_{64,32} policies, and maybe
   other details.
2. Use RWF_ENCODED only for the data itself.
3. Add new fscrypt ioctls to get and set the encryption key.

The interesting part is (3). If I'm reading the fscrypt documentation
correctly, in the default mode, each file is encrypted with a per-file
key that is a function of the master key for the directory tree and a
per-file nonce.

Userspace manages the master key, we have a FS_IOC_GET_ENCRYPTION_NONCE
ioctl, and the key derivation function is documented. So, userspace
already has all of the pieces it needs to get the encryption key, and
all of the information it needs to decrypt the data it gets from
RWF_ENCODED if it so desires.

On the set/write side, the user can set the same master key and policy
with FS_IOC_SET_ENCRYPTION_POLICY, and we'd need something like an
FS_IOC_SET_ENCRYPTION_NONCE ioctl (possibly with a requirement that it
be set when the file is empty). I think that's it.

The details will vary for the other fscrypt policies, but that's the
gist of it. I added the fscrypt maintainers to correct me if I missed
something.

Thanks,
Omar
