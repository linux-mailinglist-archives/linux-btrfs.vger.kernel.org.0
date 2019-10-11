Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F215DD4496
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJKPlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 11:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJKPlF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 11:41:05 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464DA206CD
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570808464;
        bh=SVT5HVeBw8nafWw9Z2MLEuuy/oTURi2+rlpsheBT4ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IhJKuZ8XaYO4ROaRrOCEIBcgAXCOWdKT6T5BPqgaERZB52S59ZQnfAO8HA6yH21mT
         szKqCU1l++0c4sEMTBhPmV/bigsxO2zN5BEOLDNDJByjeIqCeNPJdRKaU5Nps3Q7f8
         vzW9sft+REsl4A/RmebOPzJr+ZF4qP75lAwrlTZU=
Received: by mail-ua1-f46.google.com with SMTP id b14so3179178uap.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 08:41:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVcfiNVQPbhJUGS0+SsUQaAlPepgkzzjooQHumjJAlzllRaeQxO
        aQDk/pQ+OzW4+4Kn/J9SjemxQYCW2KOCTc128io=
X-Google-Smtp-Source: APXvYqwMG3Dpn445eUSZqxVR4R+6lN4e0z92pibilC15Tih1sFUKgKKbhoD37UL9t3u/he+VqdMyhzUX6NEkR1F50Us=
X-Received: by 2002:ab0:59ed:: with SMTP id k42mr4235289uad.27.1570808463322;
 Fri, 11 Oct 2019 08:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191009164422.7202-1-fdmanana@kernel.org> <20191011132741.6zrjhv22j4otl6jc@MacBook-Pro-91.local>
In-Reply-To: <20191011132741.6zrjhv22j4otl6jc@MacBook-Pro-91.local>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 11 Oct 2019 16:40:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H51nxJaMa8FEAs+3RMUBqOcGw7w=_EoaEtuATS=g5QQ4g@mail.gmail.com>
Message-ID: <CAL3q7H51nxJaMa8FEAs+3RMUBqOcGw7w=_EoaEtuATS=g5QQ4g@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix negative subv_writers counter and data space
 leak after buffered write
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 2:27 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Oct 09, 2019 at 05:44:22PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing a buffered write it's possible to leave the subv_writers
> > counter of the root, used for synchronization between buffered nocow
> > writers and snapshotting. This happens in an exceptional case like the
> > following:
> >
> > 1) We fail to allocate data space for the write, since there's not
> >    enough available data space nor enough unallocated space for allocating
> >    a new data block group;
> >
> > 2) Because of that failure, we try to go to NOCOW mode, which succeeds
> >    and therefore we set the local variable 'only_release_metadata' to true
> >    and set the root's sub_writers counter to 1 through the call to
> >    btrfs_start_write_no_snapshotting() made by check_can_nocow();
> >
> > 3) The call to btrfs_copy_from_user() returns zero, which is very unlikely
> >    to happen but not impossible;
> >
> > 4) No pages are copied because btrfs_copy_from_user() returned zero;
> >
> > 5) We call btrfs_end_write_no_snapshotting() which decrements the root's
> >    subv_writers counter to 0;
> >
> > 6) We don't set 'only_release_metadata' back to 'false' because we do
> >    it only if 'copied', the value returned by btrfs_copy_from_user(), is
> >    greater than zero;
> >
> > 7) On the next iteration of the while loop, which processes the same
> >    page range, we are now able to allocate data space for the write (we
> >    got enough data space released in the meanwhile);
> >
> > 8) After this if we fail at btrfs_delalloc_reserve_metadata(), because
> >    now there isn't enough free metadata space, or in some other place
> >    further below (prepare_pages(), lock_and_cleanup_extent_if_need(),
> >    btrfs_dirty_pages()), we break out of the while loop with
> >    'only_release_metadata' having a value of 'true';
> >
> > 9) Because 'only_release_metadata' is 'true' we end up decrementing the
> >    root's subv_writers counter to -1, and we also end up not releasing the
> >    data space previously reserved through btrfs_check_data_free_space().
> >    As a consequence the mechanism for synchronizing NOCOW buffered writes
> >    with snapshotting gets broken.
> >
> > Fix this by always setting 'only_release_metadata' to false whenever it
> > currently has a true value, independently of having been able to copy any
> > data to the pages.
>
> Can we accomplish the same thing by just doing
>
> only_release_metadata = false;
>
> at the start of the loop?  That way we only ever deal with it in its current
> scope?  Thanks,

Yeah, that's probably better. I just felt to leave it closer to the
last place where it's used.
Thanks.

>
> Josef
