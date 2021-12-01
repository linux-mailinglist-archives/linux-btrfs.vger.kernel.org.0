Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B74655B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbhLASpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhLASpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:45:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31015C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:42:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so54242350wrs.12
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yGWwv7AGMWbnLT0KEM2Ov8+ZkvKR9+p9vjqCOZPf52U=;
        b=iE8kjVkAJUUJ3S10z2k07v1bYsD2VkgeqasCr+guv3Ij0FevZYLP0FSQFMgMD2Uq7J
         OjiJceRl42z2Rzb9lNvKY3asFrw12H3QRUJcVGvx42SPTo/XATaQ0caQn/f5ZdO2bamz
         d9X55SZyOdfVfi3IhO92yCtRFFe23jjPCywIbWXnF2+/3FzfFFqgxH6FuzGy3pqw5KNI
         8UQ7rW3kg92vDU+b/Om42uTCN8tZcO/dheY7RJu5u8MgKInYqZwfH03+dz3ss8hRF9Dy
         IvPpJf7vrag5QAHxuEER2eoAD9VT3XPPtCp2lgKTXWt4ODDiZJDEAug8rbUvtdC+OrQr
         /jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yGWwv7AGMWbnLT0KEM2Ov8+ZkvKR9+p9vjqCOZPf52U=;
        b=QJOM6r0h8bIvwN1kDICrkXBM1cns9RAcS6PB/FC4IZd0vu2GSr01OIEwPdlRTJ6g5R
         VS2qdgRMlJXohF6OoDvkDuA5A+mZ9I8qksRxH3fDiRJsNLFtrC+CmVGoEZwQemN8BfCL
         raFpcVRN9VjnlTkxJHlbvC4Av9sebp5Yz/WlI7AhZxZuLoidiyKdZGKhJwH8j0Ye38Mi
         Whk+jcK+3xWzk6CkF4cbU2CRkRmgyMh7nDHSpIy25HJQrhf/z8q6jFGfJrEtcIHptWH9
         /kIstlzQGWL/QeGm3NzXNfhlA1shRc03hhKPfr2PdEg+FFShn/MXtF9J2jeVJ2b46U9V
         6Z3Q==
X-Gm-Message-State: AOAM531q5dzKFlOL1jLANuAOm/vLR2RXMdSYxGqVHSab2S7dwJ9YfW8F
        O7Xl5D4MmXsbrPz5fbO4cX+NEkyHDqZ1N9tkbeE=
X-Google-Smtp-Source: ABdhPJzuTaa+ZBOlNoW5sNBfddGf8TncrdDu/4Oywj05cZni4YFVRqLuMDbHtqasjDAhxkm6rvfSHiyHJe/6/7tP3J4=
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr8700884wrs.222.1638384150805;
 Wed, 01 Dec 2021 10:42:30 -0800 (PST)
MIME-Version: 1.0
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net>
 <MpgNwtq--3-2@tutanota.com> <75c33ef6-af1a-43cc-6732-ce4b298a7337@cobb.uk.net>
In-Reply-To: <75c33ef6-af1a-43cc-6732-ce4b298a7337@cobb.uk.net>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Wed, 1 Dec 2021 12:42:20 -0600
Message-ID: <CA+H1V9yCM3vSOC+-dhWJ9d62GdpKr7suzFNAQwYNYt71MG3Gig@mail.gmail.com>
Subject: Re: Connection lost during BTRFS move + resize
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Borden <borden_c@tutanota.com>, Phillip Susi <phill@thesusis.net>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even if it wrote more than 1 TB and started overwriting the file
system, it SHOULD be possible to find what data still needs to be
written by searching backwards from the old partition's end point and
the new partition's end point until you start finding identical data.

Matthew Warren

On Mon, Nov 29, 2021 at 5:07 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 29/11/2021 15:50, Borden wrote:
> > 29 Nov 2021, 10:26 by phill@thesusis.net:
> >> The only tool I know of that can do this is gparted, so I assume you a=
re
> >> using that.  In this case, it has to umount the filesystem and manuall=
y
> >> copy data from the old start of the partition to the new start.  Being
> >> interrupted in the middle leaves part of the filesystem in the wrong
> >> place ( and which parts is unknowable ), and so it is toast.  This is
> >> one area where LVM has a significant advantage as its moves are
> >> interruption safe and automatically resumed on the next activation of
> >> the volume.
> >>
> > This is the answer that I anticipated, and it's good to know now so I d=
on't destroy data that I _cannot_ afford to lose later. So thank you.
> >
> > For my own education/curiosity/intellectual banter: ddrescue, badblocks=
, rsync and other utilities have log files that track progress and allow it=
 to resume if it's interrupted. Since resize operations work in the linear =
process you described, how hard would it be, theoretically, to implement a =
"needle position" in a move operation to allow a move to pick up where it l=
eft off?
> >
> > Obviously, it wouldn't be 100% perfect, but if a recovery utility could=
 look at the disk and say "partition starts here, skip a bit somewhere in t=
he middle, continue here, stop there," surely that would be more efficient =
than trying to recover files with a low-level utility?
> >
>
> I can't comment on that, and I don't know how the utility you were using
> works, but if it was copying blocks from higher disk addresses to lower
> ones, starting at the bottom, it is *possible* that it hadn't got beyond
> the first 1TB before it failed and the original filesystem is still
> untouched.
>
> Did you try just resetting the original partition parameters manually
> (forcing them using something like GNU parted's mkpart - not a resize
> operation) to see whether the original filesystem could be mounted? It's
> just a long shot, of course.
>
> Graham
