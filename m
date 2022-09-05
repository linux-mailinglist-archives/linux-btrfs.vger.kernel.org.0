Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963755ACEB7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiIEJVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiIEJVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 05:21:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A213E77A;
        Mon,  5 Sep 2022 02:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A31B80FA7;
        Mon,  5 Sep 2022 09:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59CC433D7;
        Mon,  5 Sep 2022 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662369668;
        bh=k7uGcDjpFJrQL5ZYOESLNfJtaWG202Pynt2OzdEYOiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yc8zsRUJR/DCdJxGPbBnJ76mnGGCGi9aOrCVcRhfXngtKjSXKw4jAjufrrm3jZvMq
         Bz6rm5yiVqq9zIFDPcDAFIoqfftHYa62D7KmY1oqA0PW+iN6RBU96WdMaO/1dFxxi3
         iAWJ+U2sYBOy8htzGAnFe7yt5x69Fn/txsFhMwyMOn09Qv2gIAaNPYhFItMqjvuLns
         E6XukvFSwaZjdNfJdcK4A98ehmjlg5T8Ng5DvSvmbiH/fQlaiNWjk+WWUMpIsJDtpH
         175llhVzyHqDIbCPzFcI3pUk5i4pVPxrAkb4QwtJnQeNIrEQPf+w02oS2cWCcv9eM+
         Z55Rv7X6GdwDQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1278624b7c4so1869176fac.5;
        Mon, 05 Sep 2022 02:21:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ing0EfuVH4JJqlyShxkACdu8heMEfYqwTlt71fgYwTf6CW4cn
        DRWV93YfBTc2b2twPMsifRUBcE6+WvxgO8ZLqMk=
X-Google-Smtp-Source: AA6agR4k+H8LRD+T27sZvVG66mNkftK+IBDSYkT4iT21yD9TjSLWx92P2B5yyJrfvUHtxShwxKs+7TZwp6hsl9HjtNc=
X-Received: by 2002:a05:6870:ea83:b0:fe:365f:cb9d with SMTP id
 s3-20020a056870ea8300b000fe365fcb9dmr8678524oap.98.1662369667190; Mon, 05 Sep
 2022 02:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
 <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox> <20220902094424.GQ13489@twin.jikos.cz>
 <20220905063539.GA2092@lst.de> <20220905090809.54feouoalvrzmaao@zlang-mailbox>
In-Reply-To: <20220905090809.54feouoalvrzmaao@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Sep 2022 10:20:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H57RikRRf2qj_GBSKkZ8fKOKrmS4Tv533M69txkosBNnQ@mail.gmail.com>
Message-ID: <CAL3q7H57RikRRf2qj_GBSKkZ8fKOKrmS4Tv533M69txkosBNnQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
To:     Zorro Lang <zlang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 5, 2022 at 10:08 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Sep 05, 2022 at 08:35:39AM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 02, 2022 at 11:44:24AM +0200, David Sterba wrote:
> > > >   commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
> > > >   Author: Christoph Hellwig <hch@lst.de>
> > > >   Date:   Mon Feb 18 10:05:03 2019 +0100
> > > >
> > > >       fstests: add a seek group
> > > >
> > > > So I'd like to let Christoph help to double check it.
> > >
> > > It's quite obvious from the test itself that it tests only send/receive,
> > > which is mentioned in the changelog. The commit adding the seek group
> > > does not provide any rationale so it's hard to argue but as it stands
> > > now the 'seek' group should not be there.
> >
> > Probably.  Unless it somehow exercised seeks through the userspace
> > seek code I can't see any good rationale for this addition, and the
> > patch was far too long ago for me to remember.
>
> Hi,
>
> I just tried to learn about the history of this *problem*:
>
> At first, Jan Schmidt added src/fssum.c into fstests by df0fd18101b6 ("xfstests:
> add fssum tool"). In this original version, fssum does SEEK_DATA in both
> sum_file_data_permissive() and sum_file_data_strict(), that means it always
> does SEEK_DATA. So all cases run fssum, need SEEK_DATA/HOLE support.
>
> Then 5 years later, Filipe removed SEEK_DATA operations from the
> sum_file_data_permissive(), by 1deed13f69b2 ("fstests: fix fssum to actually
> ignore file holes when supposed to"). And fssum run sum_file_data_permissive()
> by default. So that cause fssum don't need SEEK_DATA support by default (except
> you use "-s" option).
>
> Then 1 year later, Christoph added btrfs/007 into seek group, I think that might
> because btrfs/007 still keeps the *_require_seek_data_hole*, which runs the
> src/seek_sanity_test.
>
> So, now, if we all agree that btrfs/007 isn't a seek related test, we can remove
> the seek group and the *_require_seek_data_hole*.

fssum exercises lseek (SEEK_DATA) only if we pass the -s option to it,
which is not
the case for btrfs/007 (as well as for all other btrfs tests that
exercise send/receive and use fssum).
And that is because send/receive does not always preserve holes and
prealloc (specially on incremental send/receive).

That's a short version of the changelog from 1deed13f69b2, hopefully
clear enough.
And yes, the _require_seek_data_hole can go away from btrfs/007 too.

Thanks.

>
> Thanks,
> Zorro
>
> >
>
