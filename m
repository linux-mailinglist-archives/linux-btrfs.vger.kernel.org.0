Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141D62BAD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 12:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiKPLFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 06:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKPLE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 06:04:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A611A29
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 02:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D92A5B81CCB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 10:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BD1C433C1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668595860;
        bh=u2BvrhnhQWVyqHGMng/HI3XVVDI9vZoMt74kaeLsEsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S9SbHo+r94JkfCCAqk4yZXQEliNwEXtlsOrOj+uCaREEehh6MgtEMYpo3OlXBVWTB
         vyiBxwdd7KkdC50LRoXVjdUSmwljjVi5RTiedPgFOMxwn+bY4JGUKaOwPI79xHvyBP
         /cWLAIB6M4sSUXdhvwIAn3u52BBTv3qRf+QoH2jVuz99lPMUlpxISZtxrWvmvAs5o3
         UW/ffD+KZF4XntRLumRiy5UDUzZn1Y3MXkBu6IuYN7VKjNgZvgIzEH18vPT5XC5U+B
         d7OF6jJ2p97GmhPAYE4p1xveDQqnWxcC1YxhPAYP8lC+b8pNEhuPh7PWe2++5tlfvz
         jBlUZsM0R//WQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13bd2aea61bso19642918fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 02:51:00 -0800 (PST)
X-Gm-Message-State: ANoB5pkS/1Mzs+gyByKOZ5SknDJf5N6YFo7pp6r6lwi2aa/sBD1gR7G6
        pmYQkTULMvumUr6nIUwpMsYZZ8YAmRjNXhQ2NBA=
X-Google-Smtp-Source: AA0mqf7DerYkxv+Dsa40m9eTlXC6BvcKi0nxt++vz027wOYancsHu0a7IX9iDCW6eDVqVJM4x2u25dVzIjqcFjrii1c=
X-Received: by 2002:a05:6870:9a94:b0:131:ec37:2451 with SMTP id
 hp20-20020a0568709a9400b00131ec372451mr1347866oab.98.1668595859705; Wed, 16
 Nov 2022 02:50:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668529099.git.fdmanana@suse.com> <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
 <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com> <f2ccd7455a18b17b72846c61581db0fda5347829.camel@scientia.org>
In-Reply-To: <f2ccd7455a18b17b72846c61581db0fda5347829.camel@scientia.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 16 Nov 2022 10:50:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5iqfqPFwkLA+t3vFikVoZNMU-5h_F7iHmEJKqvVSp05w@mail.gmail.com>
Message-ID: <CAL3q7H5iqfqPFwkLA+t3vFikVoZNMU-5h_F7iHmEJKqvVSp05w@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug with
 encoded writes
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 4:53 PM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> On Tue, 2022-11-15 at 16:47 +0000, Filipe Manana wrote:
> > > Is one *only* affected when ones
> > > used compression - respectively if one DID NOT do any filesystem
> > > compression (i.e. compress mount option)... can one be sure to be
> > > safe?
> >
> > If you haven't used 'btrfs send' with the --compressed-data option or
> > you are sure you don't have any compressed files, then you're fine.
>
> Thanks a lot... so all good for me. :-)
>
> But still, as I wrote in the other mail,... other people might be
> affected... and it would be reeeeally nice if there was some good way
> for them to get alerted about such cases.

There will always be users who'll miss such alerts, many don't read
all the emails in this list, many are not even subscribed to the
mailing list, etc.
Do you have examples of other projects that have an effective alert system?

>
>
> Thanks,
> Chris.
