Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E158A6A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHLSxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 14:53:23 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38193 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLSxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 14:53:23 -0400
Received: by mail-ua1-f68.google.com with SMTP id g13so3876218uap.5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yCJM930kjWAD4lhCmAWINhO7qH15RlEok+iJQT6nx0g=;
        b=hzBI/j4UGfDpPTh1NjiaxgDu3Hdc3Qmqs/VUWRqb2pTlm7WpEossr4XCMcyUuKZtNH
         S7GG87rTymdbE0pKbieIRV/TtUqk/C8pzDj7CIhLQkfVMkVfunZdc44m8obyIRCKdtc3
         NoeH1lh21WxEtnJkutBM6Io3eF3dH0Wpy92w9WzIITnSDSqR+bglnfvtJWJxR3CpTibS
         D+MAcetLWU5dq1Og5R7Xe6tZrwGlyDekix52l/ZYjWsacIvRLd8X3xtkxrNLxjzVmoMD
         au8CWBSKWc0TYIfIIrVra8f/IVPMkcHFVoMRObfNGgm91BHx9SlA/kOun5So5IGp9dqs
         f6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yCJM930kjWAD4lhCmAWINhO7qH15RlEok+iJQT6nx0g=;
        b=c7II4LySKdbWmRxYB33OeMUh6+WWv//F/06wDz9Jbc+94wdfUHjgh7sFOQrG3IkeII
         ElvPP6pNtKO35CuIPp7BSIFswYiM/xssdjzQC+FI2rM/zm6roBB2JLuzsJi+0sB2z+IF
         lDoB+dUiPw9muDK99dm6GCoY8/EuuEeuXPJtX/Ps/c5dFNtiDCBQGjPBBes3derKwfsB
         SThPySuiQeqjPlimZRV3UrcIlSi0aLJDpDchXzW/EZN9GBmFLr4TuOAq0FUSZ8/K13uW
         TixnQkIbJ/jteI4ELtpfZaOBD0/dMQaTMdTa8jhKS9HcWb08bnj7dWnIIEJzi80B5jKR
         QgXA==
X-Gm-Message-State: APjAAAWuYmRp1B4QsOETkokPWeR/jbj7SRRwXfL/XrsPayz7RubAdcVh
        DbXBoTsxKS2rgxW2vXmPMvQuSfmbLv7DygXxlWWU0Q==
X-Google-Smtp-Source: APXvYqxYArjFu76uiIYmGDdPNhAhocw8aF9qjl4wuQof+0Wd5ugSn3ISkCde2jyVZQaSj4RGEjGLc9+u57o6y8LM2Ks=
X-Received: by 2002:ab0:2784:: with SMTP id t4mr1370353uap.27.1565636001674;
 Mon, 12 Aug 2019 11:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
 <CAL3q7H4cSMNSKfQKtFk9Q5Shw3VxMFZQ0E7uusL0efHzyN3MXw@mail.gmail.com> <20190812184812.GA4142@vader>
In-Reply-To: <20190812184812.GA4142@vader>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 12 Aug 2019 19:53:10 +0100
Message-ID: <CAL3q7H4d6mGsiKRmsELw1o6XQBVTWOEQ-bYqwr5RS7i__jarzA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 7:48 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Mon, Aug 12, 2019 at 12:38:55PM +0100, Filipe Manana wrote:
> > On Tue, Aug 6, 2019 at 6:48 PM Omar Sandoval <osandov@osandov.com> wrot=
e:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > We hit a the following very strange deadlock on a system with Btrfs o=
n a
> > > loop device backed by another Btrfs filesystem:
> > >
> > > 1. The top (loop device) filesystem queues an async_cow work item fro=
m
> > >    cow_file_range_async(). We'll call this work X.
> > > 2. Worker thread A starts work X (normal_work_helper()).
> > > 3. Worker thread A executes the ordered work for the top filesystem
> > >    (run_ordered_work()).
> > > 4. Worker thread A finishes the ordered work for work X and frees X
> > >    (work->ordered_free()).
> > > 5. Worker thread A executes another ordered work and gets blocked on =
I/O
> > >    to the bottom filesystem (still in run_ordered_work()).
> > > 6. Meanwhile, the bottom filesystem allocates and queues an async_cow
> > >    work item which happens to be the recently-freed X.
> > > 7. The workqueue code sees that X is already being executed by worker
> > >    thread A, so it schedules X to be executed _after_ worker thread A
> > >    finishes (see the find_worker_executing_work() call in
> > >    process_one_work()).
> > >
> > > Now, the top filesystem is waiting for I/O on the bottom filesystem, =
but
> > > the bottom filesystem is waiting for the top filesystem to finish, so=
 we
> > > deadlock.
> > >
> > > This happens because we are breaking the workqueue assumption that a
> > > work item cannot be recycled while it still depends on other work. Fi=
x
> > > it by waiting to free the work item until we are done with all of the
> > > related ordered work.
> > >
> > > P.S.:
> > >
> > > One might ask why the workqueue code doesn't try to detect a recycled
> > > work item. It actually does try by checking whether the work item has
> > > the same work function (find_worker_executing_work()), but in our cas=
e
> > > the function is the same. This is the only key that the workqueue cod=
e
> > > has available to compare, short of adding an additional, layer-violat=
ing
> > > "custom key". Considering that we're the only ones that have ever hit
> > > this, we should just play by the rules.
> > >
> > > Unfortunately, we haven't been able to create a minimal reproducer ot=
her
> > > than our full container setup using a compress-force=3Dzstd filesyste=
m on
> > > top of another compress-force=3Dzstd filesystem.
> > >
> > > Suggested-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Looks good to me, thanks.
> > Another variant of the problem Liu fixed back in 2014 (commit
> > 9e0af23764344f7f1b68e4eefbe7dc865018b63d).
>
> Good point. I think we can actually get rid of those unique helpers with
> this fix. I'll send some followup cleanups.

Great! Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
