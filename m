Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C9727E4E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgI3JRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3JRB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 05:17:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F849C061755;
        Wed, 30 Sep 2020 02:17:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so599572qtj.11;
        Wed, 30 Sep 2020 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Mml1BIpLHXxQZjvF6KnG/D7MyJp0Mrl7xgRY3q/FOhI=;
        b=bAW/lCnzQICiT2pv/N5oq7LH0VUEz4TCKG/JQMJpmk5UMaIcRSf100vFdcW0klmitx
         AmPSmTIUv+nvLyUF8glb7ugPGXlTS5RAP81xaVrfp98V/oqshHIPW8l8DphWYcNPZ7QZ
         usRBRdMyClWM7TlYREKf38CQqCufn/Om1eRvWO3xn+olyavJob9vbNbwzXEQLvF3IJk4
         ZAJxR6HyIrq+f6uDr9fEHOPg0aXk8MhU7bqxQ/RMQq2w8GAF44Iv2Cm0XYbCJMgFCBYj
         jw2FYu7A4Ek3N7f1GcfL/mYAXXinvrEAQd3xhc1LMhT3GoU7p6W5OqxZUHORrXwrL4/d
         EvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Mml1BIpLHXxQZjvF6KnG/D7MyJp0Mrl7xgRY3q/FOhI=;
        b=E1d9vJ6M2FQ361dlu2dXjNJ1wuFoFaujb4EfpNu9oMAjsa2Lp2o5KEJWbfGLOwnofn
         YpJATv2+vjqqgrQLJl9sp+omF88/fvTMB1k6XESk8V9At6AVFx6AaV1F46ovL/PaRaIY
         Q9NHujsq8btDJVbgRquWLvtBuLMBVOWP1LxuFPnsXg6BUOkAJxadOCL5ShG01M3I4Gfj
         +Dlu2wE+Jxg81LiEizh5uVBGmLdWPJ9idHAsmWWBfLXqKhkHSbDasIZRpj+R4d5gZHWI
         by5xtztT5Djd3ByKlNot3vDPUUKsRlvEJ6WeiLf4rQdXOu96zEfK7BRE8w43sG/h0FA7
         mrBw==
X-Gm-Message-State: AOAM531Df1AycdFsTJYT/69WZOpat3cH5B9ksm8k8RLa9w0HMsfwfegC
        mHpNQbH7Pt3XbPTP6iAkthnvyy89WVZZDCLjeKw=
X-Google-Smtp-Source: ABdhPJxZldcNSr9KJMTIkxFBjc/6yVh85NGeNzwozGVLL8NDJXjSSDX7WVeGre62WsWxMQB5iHYJpEKhdAyqbYe7DeI=
X-Received: by 2002:ac8:cc4:: with SMTP id o4mr1181589qti.21.1601457420429;
 Wed, 30 Sep 2020 02:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
 <CAL3q7H7QLe6EpK_g1S6MVhOPKaEsaYY9MeAHexdsEO=nz_qubQ@mail.gmail.com>
 <eba12792-b4b0-ca2e-3b78-7648ae60571c@toxicpanda.com> <CAL3q7H6qkVXMrJXeDnQWzVa95KS2QTEniKEEQbepEugPKMDrHQ@mail.gmail.com>
 <9dff9883-6275-d92c-e8d1-d5f0ef771613@toxicpanda.com> <a6c80503-df28-f25d-6437-657640bf8ade@oracle.com>
In-Reply-To: <a6c80503-df28-f25d-6437-657640bf8ade@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 30 Sep 2020 10:16:49 +0100
Message-ID: <CAL3q7H6k4c9om0+of6yjib=OnNecnLvQMEi1n1NJWXK8L0MY5w@mail.gmail.com>
Subject: Re: [PATCH] fstests: delete btrfs/064 it makes no sense
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 5:14 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 30/9/20 1:26 am, Josef Bacik wrote:
> > On 9/29/20 12:13 PM, Filipe Manana wrote:
> >> On Tue, Sep 29, 2020 at 5:02 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>>
> >>> On 9/29/20 11:55 AM, Filipe Manana wrote:
> >>>> On Tue, Sep 29, 2020 at 4:50 PM Anand Jain <anand.jain@oracle.com>
> >>>> wrote:
> >>>>>
> >>>>> btrfs/064 aimed to test balance and replace concurrency while the
> >>>>> stress
> >>>>> test is running in the background.
> >>>>>
> >>>>> However, as the balance and the replace operation are mutually
> >>>>> exclusive, so they can never run concurrently.
> >>>>
> >>>> And it's good to have a test that verifies that attempting to run th=
em
> >>>> concurrently doesn't cause any problems, like crashes, memory leaks =
or
> >>>> some sort of filesystem corruption.
> >>>>
> >>>> For example btrfs/187, which I wrote sometime ago, tests that runnin=
g
> >>>> send, balance and deduplication in parallel doesn't result in crashe=
s,
> >>>> since in the past they were allowed to run concurrently.
> >>>>
> >>>> I see no point in removing the test, it's useful.
> >>>
> >>> My confusion was around whether this test was actually testing what w=
e
> >>> think it should be testing.  If this test was meant to make sure that
> >>> replace works while we've got load on the fs, then clearly it's not
> >>> doing what we think it's doing.
> >>
> >> Given that neither the test's description nor the changelog mention
> >> that it expects device replace and balance to be able to run
> >> concurrently,
> >> that errors are explicitly ignored and redirected to $seqres.full, and
> >> we don't do any sort of validation after device replace operations, it
> >> makes it clear to me it's a stress test.
> >>
> >
> > Sure but I spent a while looking at it when it was failing being very
> > confused.  In my mind my snapshot-stress.sh is a stress test, because
> > its meant to run without errors.  The changelog and description are
> > sufficiently vague enough that it appeared that Eryu meant to write a
> > test that actually did a replace and balance at the same time.  The tes=
t
> > clearly isn't doing that, so we need to update the description so it's
> > clear that's what's going on.  And then I wanted to make sure that we d=
o
> > in fact have a test that stresses replace in these scenarios, because I
> > want to make sure we actually test replace as well.
> >
> > Not ripping it out is fine, but updating the description so I'm not
> > confused in a couple years when I trip over this again would be nice.
> > Thanks,
> >
>
> As of now, we have the following balance concurrency tests.
> -----
> 028 balance and unlink fsstress concurrency [1]
> 060 balance and subvol ops concurrency with fsstress [2]
> 061 balance and scrub concurrency with fsstress [2]
> 062 balance and defrag concurrency with fsstress [2]
> 063 balance and remount concurrency with fsstress [2]
> 064 balance and replace concurrency with fsstress  [2]
> 177 balance and resize concurrency

No, 177 does not test balance and resize concurrency.
It tests balance when a swap file exists. And the resize happens
(starts and ends) before setting the swap file and before doing the
balance.

Thanks.


> 187 balance, send and dedupe concurrency
> 190 balance with qgroup
>
> [1]
> args=3D`_scale_fsstress_args -z \
>          -f write=3D10 -f unlink=3D10 \
>          -f creat=3D10 -f fsync=3D10 \
>          -f fsync=3D10 -n 100000 -p 2 \
>          -d $SCRATCH_MNT/stress_dir`
>
> [2]
> args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d
> $SCRATCH_MNT/stressdir`
> -----
>
> 064 shall test balance with fsstress in the background. The replace
> thread is kept out with the early check of BTRFS_FS_EXCL_OP in the kernel=
.
> I am ok with the 064 headers updated, will send v2.
>
>
> Also, it turns out that this test case helped to find a btrfs-progs bug.
> Its patch [1] is sent to the ML.
>    [1] btrfs-progs: fix return code for failed replace start
>
> Thanks, Anand
>
>
> > Josef
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
