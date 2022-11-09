Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31253623059
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKIQoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 11:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIQoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 11:44:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82F1FCF6;
        Wed,  9 Nov 2022 08:44:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7FDDB81CF9;
        Wed,  9 Nov 2022 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984DBC433C1;
        Wed,  9 Nov 2022 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668012274;
        bh=Y+CJ4xlsxC/7sA2C8EJFMpiWLfGvb7zIoWSGfbpgD4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SThQIjXrGKN2V5xgUgWq9G+PaszJ7JROkwJsKpTjKNQqcTeHGhAx6nqDZcbmGONPh
         yO1VasLCzjeKr2EbNK4Da0xwcL7QkcgR7aHrwHNn4JfeAPYWXKF0Uwoe9qlaXRZS+g
         OD3EJspOAoncf1JWm+rvujuGVX6wOKzKv4PIcNiQo1u1/54ue3Fjra/swy4x9MEFWA
         J26BdnUz2AQqNKdJwL2vuYYgEilJ3+eJktI1MMrhfN6IWqWb4G+Uf4nMkxc/s/jBPU
         SecqYuAOCmBho8V6blfegCrAYjnnoTeyXDhGn7ItP+be92idmMz4CPzgmyBpAxFuPK
         8D1C50j2+T4Iw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13bd2aea61bso20288374fac.0;
        Wed, 09 Nov 2022 08:44:34 -0800 (PST)
X-Gm-Message-State: ACrzQf0G1ieuk8n2wERTy5kBfGha69gnYXzgpQ8F4iptT4z9jm4unbAN
        LQOFC8zmn94TXeewxplYrzreZjIQN76n01WVjBk=
X-Google-Smtp-Source: AMsMyM44tviuUBlG9DVwjTC7V11gODtC4vBWLQi3DLSYGyz3FkeGKJTRS05wgZBgk4IrdFL55+GQBi7u4YnWiqR3ifs=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr36624484oad.98.1668012273735; Wed, 09
 Nov 2022 08:44:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1667993961.git.fdmanana@suse.com> <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
 <20221109155505.yki6xwqk4p4mhky6@zlang-mailbox>
In-Reply-To: <20221109155505.yki6xwqk4p4mhky6@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 9 Nov 2022 16:43:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6W_TFq+9PUd62+EUVJortdpAL8VuEtLEfhM91pRcb41Q@mail.gmail.com>
Message-ID: <CAL3q7H6W_TFq+9PUd62+EUVJortdpAL8VuEtLEfhM91pRcb41Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs/053: fix test failure when running with
 btrfs-progs v6.0+
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 9, 2022 at 3:55 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Nov 09, 2022 at 11:43:35AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > In btrfs-progs v6.0 the --leafsize (-l) command line option was removed,
> > so btrfs/053 always fails with v6.0+.
> >
> > The change was introduced by the following btrfs-progs commit:
> >
> >   f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")
> >
> > Change the test to use --nodesize (-n) instead, since it exists in both
> > old and new btrfs-progs versions.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/053 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/btrfs/053 b/tests/btrfs/053
> > index fbd2e7d9..c0446257 100755
> > --- a/tests/btrfs/053
> > +++ b/tests/btrfs/053
> > @@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
> >  rm -fr $send_files_dir
> >  mkdir $send_files_dir
> >
> > -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> > +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
>
> We you said this case starts to fail on btrfs-progs v6.0, I'm wondering how it
> fail (I don't doubt it fails), at least not fails at here right?

It fails during mount in case no previous mkfs on the scratch device happened.
First time after booting a vm and without running any other test case.

>
> Actually I recommend mkfs output to .full file at here, especially when you use
> specified mkfs options to _scratch_mkfs helper. That really might fail, and
> the case might keep running (with old fs on SCRATCH_DEV), and we hard to notice
> that if no message output and no return value checking.
>
> The _scratch_mkfs doesn't _fail if it fails, it just return nonzero and output
> error message. So generally I recommend writting likes this (or other proper way
> which can detect mkfs failure):
>
>   _scratch_mkfs "--nodesize $leaf_size" >>$seqres.full 2>&1 || _fail "mkfs failed"

Yes, I remember some years ago a thread discussing silent mkfs failures being
ignored and getting unexpected results or tests passing when they shouldn't.

I'll add that, thanks.

>
> especially if there's specified mkfs options.
>
> Thanks,
> Zorro
>
> >  _scratch_mount
> >
> >  echo "hello world" > $SCRATCH_MNT/foobar
> > @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
> >  _scratch_unmount
> >  _check_scratch_fs
> >
> > -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> > +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
> >  _scratch_mount
> >
> >  _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> > --
> > 2.35.1
> >
>
