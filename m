Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CC69877B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBOVmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBOVmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:42:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA02B098
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 13:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D782B823AF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 21:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB39EC433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 21:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676497349;
        bh=xVjt2H1nJVoiuID+mlZ2CWBWpbDhRFZhWd4uwZhc9Bw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ehQt73TrDrELsX5beVBJH39At9W1b3OV/js9PNB1zeqi4Z8cthRPIj7aim8L/dn8A
         q0GwHrRAcxujzVBYAnPhGTF04eanpE6b3PpRLb/u0XruyMScObMd2PCVe4GzTbqni2
         sscbf2iAr3zCQ/vgNyKv7jBP3aRhjLGc/hepYY6pYsSq5/OMODuYU0WV4Qplg2Ppy0
         /MuFwECGQlPgqjk2n5y75T5X5Gl1ttn76EyrGitj44g/ZpsdUJ6EZSA9/WEJiObOV9
         bEQtfFEE/z57n5I0e88S3nSQW/ViwJdc0X4CNiKu9R+M6n6364NrOCCzq36QfXCFu6
         rgnFiDneLJ4kA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16e55be7c76so393706fac.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 13:42:28 -0800 (PST)
X-Gm-Message-State: AO0yUKUrk5e9DrLuurS9sqs7eDXYdR8kbEhgE2xaAHPUkr8yBXP7OIAG
        etYjgsaODlDzFMCHejDHb2SgBFFW+fx9UFz9/5E=
X-Google-Smtp-Source: AK7set/9GqHQ4xqR1qAckA+sZfqyRb7b2PDyN3Xq2Xk5v6hfH7a1UC4VNjY9zFqTbUZX9EePXdVt4VvF8x9Ky2RLBT8=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr4045oac.98.1676497348049; Wed, 15 Feb
 2023 13:42:28 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com> <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
In-Reply-To: <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 15 Feb 2023 21:41:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4irSH7EG2DMmbmX29g_8H=L7kL_DKz-p=QJ9m8d8fvsA@mail.gmail.com>
Message-ID: <CAL3q7H4irSH7EG2DMmbmX29g_8H=L7kL_DKz-p=QJ9m8d8fvsA@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 8:30 PM Chris Murphy <chris@colorremedies.com> wrote:
>
>
>
> On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > Downstream bug report, reproducer test file, and gdb session transcript
> > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >
> > I speculated that maybe it's similar to the issue we have with VM's
> > when O_DIRECT is used, but it seems that's not the case here.
>
> I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
>
> kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.

I'm able to reproduce it too.

I'll have a look at it, thanks.

>
>
> --
> Chris Murphy
