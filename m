Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62AA33912
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 21:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFCT1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 15:27:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43072 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCT1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jun 2019 15:27:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so3706670qtj.10
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2019 12:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hCg+oFftIOG5yObOosljHRtxYldDe7zEcIf2usxJrgk=;
        b=U2hAv7PhdoXOgdf0k4vPdKreDR82dXOmhgQwTMtrMOi6GTIPT/bMFYKSkKU8fKuuvh
         QOuQ3Ix1IUJ4+ZnzmkZPfZNaM4WcBa6X+C21doSP10EmKdROEwSo8sDoYawdrICoAH8Q
         n+x1a5ZcT9NEdx7yBQoWR1/4BVh02x4A34VqqZ8FzLNqda9ZwMLx2sXMc28yQfxAHh5O
         kyhOd7YegCA+hNPKBcHnSQjJ5/ljxlqfwbWoUpz+31w23flCnUjKrXnP/xBtHRxMSWQn
         P5kNNmmcI00ObWY8oh806n2xD6pQFs+JChrhefAIvPQvHEB4VzYScb/V41kby9ZCqK8f
         WiKA==
X-Gm-Message-State: APjAAAU8XAe8t55yCU2tGX8Sk06J+rlhfQiVYGVw5IBEFPM7FvJqT0RN
        jiOxoHozYh7ohZeYSBDVxc+4ZuD1F3/YIRdZCFn9rg==
X-Google-Smtp-Source: APXvYqzA3zhGNdKnqU7U5lYs3hRPaeA4sEuLMXbevzbHp8HtlvZq7Qfi3hLSl2t/Drx7ETA0e3Gcc0ongU2I3iRA9vY=
X-Received: by 2002:ac8:2e84:: with SMTP id h4mr24366097qta.267.1559590071329;
 Mon, 03 Jun 2019 12:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190603145859.7176-1-jthumshirn@suse.de> <20190603183022.GS15290@twin.jikos.cz>
In-Reply-To: <20190603183022.GS15290@twin.jikos.cz>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Mon, 3 Jun 2019 15:27:39 -0400
Message-ID: <CAMeeMh_i-Bsv4PvdxAnPGp-bOt_FnUqPJSmhbdQG+mT6FiQeKA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Bryan Gurney <bgurney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If I'm not mistaken, murmur3 has no implementation in the kernel and
also is little-endian in the official public domain code...

There is an endian-independent implementation for the kernel living
out-of-tree at https://github.com/dm-vdo/kvdo/tree/master/uds/murmur,
but there's more work to make that code use more kernel functions,
strip out the userspace parts, and submit it upstream. I've been
trying to poke at that in free time, but haven't made much progress.


On Mon, Jun 3, 2019 at 2:30 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jun 03, 2019 at 04:58:46PM +0200, Johannes Thumshirn wrote:
> > This patchset add support for adding new checksum types in BTRFS.
>
> V4 looks good to me, with a few minor fixups added to topic branch,
> including the sha256 patch.  As noted this may not be merged and now
> servers for the testing purposes.
>
> > Currently BTRFS only supports CRC32C as data and metadata checksum, which is
> > good if you only want to detect errors due to data corruption in hardware.
> >
> > But CRC32C isn't able cover other use-cases like de-duplication or
> > cryptographically save data integrity guarantees.
> >
> > The following properties made SHA-256 interesting for these use-cases:
> > - Still considered cryptographically sound
> > - Reasonably well understood by the security industry
> > - Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
> >   format
> > - Small enough collision space to make it feasible for data de-duplication
> > - Fast enough to calculate and offloadable to crypto hardware via the kernel's
> >   crypto_shash framework.
>
> Regarding hw offload, David pointed out that the ahash API would need to
> be used and that turned out to be infeasible with current btrfs code. I
> think the only hw-based improvements left are based on CPU instructions
> (crc32c, SSE, AVX) but that's sufficient.
>
> I also think software implementations of the checksum(s) are going to be
> used in most cases, which kind of makes SHA-3 less appealing to us as
> it's main point was 'excellent efficiency in hardware implementations'
> (quoting NIST announcement [1]).
>
> As has been suggested, BLAKE2 is for consideration, we only need the
> kernel module which I'll provide for testing purposes. And the more I
> know about it, the more I like it so we might have a winner, but the
> selection is still open.
>
> > The patchset also provides mechanisms for plumbing in different hash
> > algorithms relatively easy.
> >
> > This is an intermediate submission, as a) mkfs.btrfs support is still missing
> > and
>
> We'll need that one, briefly checking the progs souces, the same
> cleanups will be needed there too.
>
> > b) David requested to have three hash algorithms, where 1 is crc32c, one
> > cryptographically secure and one in between.
>
> Let me summarize the current satus:
>
> for strong hash we have SHA256 and BLAKE2. For the fast hash xxhash and
> murmur3 have been suggested. Let me add XXH3 and xxh128 for now (they're
> not finalized yet).
