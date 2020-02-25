Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6E16BD5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgBYJhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 04:37:04 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36853 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBYJhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 04:37:03 -0500
Received: by mail-vs1-f66.google.com with SMTP id a2so7586208vso.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2020 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HQSvyZrho8qfIzLFxWK02wQlEaIAB/WSm2swJ+ej/ww=;
        b=MtGLgMqG3o2lErCazbcC6p5PQny0IGvUOnF3xiPLZIyUQzEk2cqHcoMVVTQPYg18qQ
         atMimRhkkgAm5pW+REBSm4fiXNbX1q5upihyg8t197uw7R28WGou880lL/acWIWpw5vK
         +VC93OiCC5Gn9CvDqKTOJ/cVX3JOpa7kfL7U00WCnTO+Dx9AlymAdAVj2zqXHG4Lj/ak
         uZiaXHfwqLessiCIXywBOR3ljR3ZyCZt979HlJSu5IZU2S0CZ1Sg/Ndh8nZs1gMfrp+u
         dLHAL//QJJZR8ApoWB5tWdt5AcflAGMML2r9RUIw69X0IIVkl3JsJC9oY0pjlvikMH6a
         cSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HQSvyZrho8qfIzLFxWK02wQlEaIAB/WSm2swJ+ej/ww=;
        b=NRlRicJKaD2HYzB6/2iMVeh+giC2T7KoI1c5u/SpxoFepKvHkYX8AajPXYZXyfM89f
         AreeceMcZVdAF8sib2NKGZPstEJ6WHwNrUQX/hxxFUot/vagDLlf80kD72uhIeqA08Xo
         8NOrcHHl1i6VqlYvTONLR9MhEcpyWDw7I13TMhlXJQKSP/Y+bkeRfUdsEY7U6HYIlbGN
         X645dAUMG7Rb16QxzQUUrWL/DygqKcdf1LevidYE7xq7jIIAiG8MNm9qFkIrqgInXdXc
         y7ajFxb70Ur4U6l6nTEKDWFBPsBMOXQLR0Rq1yn09QDlyKk/CzsI8HEcDWor5d9fo/gp
         99yg==
X-Gm-Message-State: APjAAAU5RtFVejaE8QpSnNa8w3W/K2FieVDOriN2zsIz/3izOwtkX2IN
        VnBfN7o4o7aRIeO6Ke6TtwPDUvSK4BalaRnC65uwanN6
X-Google-Smtp-Source: APXvYqyWVStw9QgV+lF7/NzY9w8QE7RthfhuPLXOOw3tc+Zt1Ou+T6Tega2PQeNvvNd0SICmC2itv1SYjMnxxxs8Sjo=
X-Received: by 2002:a67:8010:: with SMTP id b16mr28247420vsd.90.1582623422528;
 Tue, 25 Feb 2020 01:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20200223234246.GA1208467@mit.edu> <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
 <20200224064605.GA1258811@mit.edu> <CAL3q7H4-edAwsSc0Z+dYVzphm6-D1BjvToywL0A2v6unsCCtyg@mail.gmail.com>
 <20200224215600.GB6688@mit.edu>
In-Reply-To: <20200224215600.GB6688@mit.edu>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 25 Feb 2020 09:36:51 +0000
Message-ID: <CAL3q7H5QDqQzj5a12O=saddTnE+UzhrteBk0kysxC9Vr8cEZMA@mail.gmail.com>
Subject: Re: btrfs: sleeping function called from invalid context
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 9:56 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 24, 2020 at 10:14:06AM +0000, Filipe Manana wrote:
> > We do have some tests that fail in any kernel release so far. Some
> > because the corresponding fixes are not yet merged or some fail often
> > due to known problems.
> > Looking at your list of failure, I see some that shouldn't be failing
> > like btrfs/053.
>
> I've sent you the compressed tarfile with the test artifacts under
> separate cover.  The files that you'll probably want to look at first
> are ./runtests.log and ./syslog.  The xfstests results artifacts will
> be in ./btrfs/results-default/.
>
> If you have a wiki page or some other pointer of what tests that you
> expect to fail, I can put them into a btrfs-specific or file system
> configuration specific exclude file.  For example, see [1] and [2].

I don't think we do. Usually people keep their own list.
It's also very frequent to have tests fail because the corresponding
patches that fix them were not yet merged, specially for recently
added tests.

>
> [1] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-a=
ppliance/files/root/fs/ext4/exclude
> [2] https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-a=
ppliance/files/root/fs/ext4/cfg/bigalloc.exclude
>
> I'm planning on running btrfs and xfs tests more frequently to support
> some $WORK initiatives.  So if there are tests which are known
> failures that would be good for me to suppress, and if there are some
> file system configurations that would be useful for me to run, please
> let me know and I'm happy to set them so that gce-xfstests and
> kvm-xfstests can better test btrfs.
>
> Also, I assume you do have some btrfs developers who are regularly
> running xfstests,

I run them daily. And I suppose other developers run them frequently as wel=
l.

> so I don't know how helpful this would be to you,
> but given that I'm going to be running the tests *anyway*, if it would
> be helpful for me to forward test results to you, or to only send you
> a note when test regressions show up, I'm happy to do that.

Regarding the failures you got:

btrfs/056 - failure to setup dmflakey, this happens sporadically to me
and others as well, for any test that uses dmflakey and it seems to
happen more often when running dmflakey tests in sequence

btrfs/153 - has been failing for a long time, known issue, just ignore
it for now

btrfs/204 - expected to fail, there's a fix in the mailing list but it
wasn't merged yet (https://patchwork.kernel.org/patch/11357415/)

generic/065 - another failure to create the dmflakey device

generic/260 - expected to fail on btrfs, due to the way space is
allocated and managed in btrfs

generic/475 - this one can fail often for several different reasons.
Some reasons why it can fail are fixed by patches sent to rc3 for
example, other problems like the one you hit (missing file extent
holes) are addressed by a patchset that is in the integration branch
and will likely go into the next merge window

generic/562 - fails with ENOSPC. Doesn't fail for me here, needs to be
investigated.

shared/298 - The test fails with error trying to open a file that
doesn't exists apparently (/root/xfstests/src/parse-extent-tree.awk).
Never seen this failure in my vms, the test always passes for me.
Needs investigation.

Thanks for the report and logs.


>
> Cheers,
>
>                                         - Ted



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
