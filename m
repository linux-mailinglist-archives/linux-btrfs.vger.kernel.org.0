Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334704046F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhIIIYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhIIIYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 04:24:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FDC061575
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 01:23:24 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id ay33so919398qkb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XlOZpSNNfY0Eu1TnaPigpkafTNgdaxIhmv/lhQg4b4I=;
        b=LBPSn+Hz/ikmCV8B1I/K4IpKxpZYadOOIn0cjp4Xv/wdkrjFOCFMsubgFIM4SJSoAu
         QpyExtqkyIbAAawWFVjIW1atid5n0b8a3v05Qrqdb1xEDHbllwvcdch2KOB1GKFLariD
         Et4AzbcN21qB5Kw8hVaXw+p3UqmJ1IMrPCfPDlaBLFPsBAFY0VPpuoxjYcp+Z/to4TXI
         jSArvjQjtLpHLb4cUq0oyqkNgy2oUz0j3bUkFxF/m5nBM5vxL9UXPoS6CskxGs5CVV/R
         Nnj0BNObU1CURo8C4mxxYkJf0Y4TKpPC1nh54FtT3zD1xXqMHFA2nES6MlYMPMFZsLA9
         rRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=XlOZpSNNfY0Eu1TnaPigpkafTNgdaxIhmv/lhQg4b4I=;
        b=aZB8gllXR+P46hqDGsJkJn4M7+YGnZxKCkM+t+wT01dp/yhdu2Wy1aPqLMCMTD2rqZ
         Cdexm8UKCajqGYYZLQjiTauDKZRL70b4zm/UH+17KYAJvodUf39R3bT6CrBYd45AMpbi
         EokQj9h7tIKznJITljIuQKK8EOO1B9gU2XIkmBEOAaZYobVUhYqcUf7mi4kfTYURZJax
         Uc2sQ9bXc1omqjEQdGDazMXEcrI4L3YgQU28EHdOYVZx3oYJMIXlqhQtlwizb2eLtccX
         H9WVnQLtrYqrf07sOiz1LLnrUxn5FZZ+NP2GQkivFjEZ8AAKm7jZ9EODR2ZxcJJGxYOZ
         LcBA==
X-Gm-Message-State: AOAM531vFfvFNq5EBGEGFoXka/g3U125ng+JWXky3gyL+GAtm1Hq4a1O
        H5bWF9AGxPkl6kFl1QVvkM1XV52eISlhMOH9bO4hjjo/
X-Google-Smtp-Source: ABdhPJwiu23ungtlHvoARHwRBvwx6mPaqI19E+xFfPoIHY9YO53GeMDODnttxjasiJvF5V+zrYz/Bno9CwaSjQByzIE=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr1699027qkp.388.1631175803214;
 Thu, 09 Sep 2021 01:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210908135135.1474055-1-nborisov@suse.com> <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
In-Reply-To: <20210908183312.GU3379@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 9 Sep 2021 09:22:47 +0100
Message-ID: <CAL3q7H6kH=XpQtSQvT9ZsAY0bhJnLvjEkdNiN3=60k1q8TarQg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     David Sterba <dsterba@suse.cz>,
        Martin Raiber <martin@urbackup.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 8, 2021 at 7:35 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
> > On 08.09.2021 15:51 Nikolay Borisov wrote:
> > > Currently when a read-only snapshot is received and subsequently its
> > > ro property is set to false i.e. switched to rw-mode the
> > > received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> > > intact. However, once the received volume is switched to RW mode we
> > > cannot guaranteee that it contains the same data, so it makes sense
> > > to remove those fields which indicate this volume was ever
> > > send/received. Additionally, sending such volume can cause conflicts
> > > due to the presence of received_uuid.
> > >
> > > Preserving the received_uuid (and related fields) after transitioning=
 the
> > > snapshot from RO to RW and then changing the snapshot has a potential=
 for
> > > causing send to fail in many unexpected ways if we later turn it back=
 to
> > > RO and use it for an incremental send operation.
> > >
> > > A recent example, in the thread to which the Link tag below points to=
, we
> > > had a user with a filesystem that had multiple snapshots with the sam=
e
> > > received_uuid but with different content due to a transition from RO =
to RW
> > > and then back to RO. When an incremental send was attempted using two=
 of
> > > those snapshots, it resulted in send emitting a clone operation that =
was
> > > intended to clone from the parent root to the send root - however bec=
ause
> > > both roots had the same received_uuid, the receiver ended up picking =
the
> > > send root as the source root for the clone operation, which happened =
to
> > > result in the clone operation to fail with -EINVAL, due to the source=
 and
> > > destination offsets being the same (and on the same root and file). I=
n this
> > > particular case there was no harm, but we could end up in a case wher=
e the
> > > clone operation succeeds but clones wrong data due to picking up an
> > > incorrect root - as in the case of multiple snapshots with the same
> > > received_uuid, it has no way to know which one is the correct one if =
they
> > > have different content.
> > Not to overly discourage this change but I think this will cause some
> > issues in user space.
>
> That this change can cause issues for users is the reason why it hasn't
> been merged. The change on the kernel side is simple, but I've been
> missing the progs part and the "what-if"s that happen in practice.
>
> This hasn't been communicated properly so we've got resends without
> changes. I had a chat with Nikolay about what's missing so hopefully we
> can move forward this time.

Any reason why that wasn't shared in the past?

>
> > For example I had the problem of partial subvols after a sudden
> > restart during receive. No problem, just receive to a directory that
> > gets deleted on startup then move the subvol to the final location
> > after completion. To move the subvol it needs to be temporarily set rw
> > for some reason. I'm sure there is some better solution but patterns
> > like this might be out there.
>
> Thanks, that's a case we should take into account. And there are
> probably more, but I'm not using send/receive much so that's another
> reason why I've been hesitant to merge the patch due to lack of
> understanding of the use case.

So this has been going on for years, and it's well known that changing
a snapshot to RW, do changes on it, then back to RO and then use it
for incremental sends, often causes problems.

Most of the time, when there is a problem, the receive operation
simply fails somewhere, and it's not obvious what went wrong.
In last week's case I spent quite a considerable amount of time
looking at why a clone operation was failing, convinced the problem
was due to a bug in the algorithm of the sending side.

But looking at that what scares the most is not those cases that
result in an error - it's the cases where the incremental send
succeeds but results in a silent corruption, like cloning from the
wrong root, because there are multiple snapshots with the same
received_uuid but different content. For the cloning case, we can work
around and disable cloning completely for incremental sends - not
ideal, but at least no silent corruptions due to cloning. For all the
other cases not related to cloning, I have no idea how to prevent
them.

Yes, cases like Martin's are unfortunate and there's no easy way
around. But having such failures, and especially silent corruption, is
even worse IMO.
Do you have suggestions on how to proceed? How would you solve the problem?

Thanks.





--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
