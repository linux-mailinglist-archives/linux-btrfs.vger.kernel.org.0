Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67377DB960
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjJ3L5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3L5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 07:57:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC21C9
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 04:57:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71771C433C7;
        Mon, 30 Oct 2023 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698667024;
        bh=hd1qgtuV26DeBu9h2IiAdZfvDF9qBJkNbcP4WI3eRRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AieiyQC6F33TXtohrQIk7u460Z4Av4P85xYb5ZX7HEp5xrQ4eimgTP8JQyYBE7GXg
         7zrnzrj38pqjG9yWVK92yyfRhbQBXSob4DwKU2msTieRc5OX/mEw84+xik2JEDdqsx
         Mj03Eo6F340KUtBZuE8zSDOKPizaFCV9ArS4pYvSMt6gzWaOeMeQ1BKwadi/DHA382
         GrV6hD5mgq7QTzCWub56OOl/GCC9d0mhp8jOUm7ANKOBtS99XpF//LMmhOnb9CRABb
         CXqfDlhwjaQobCKiul+i3q373cUMbFI2GZOp//YWjY/55u1/e0540gKkShWKz8LwwQ
         +NOdi1WAGsLRQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so7016689a12.0;
        Mon, 30 Oct 2023 04:57:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxawHxGYn67ufr7EMPyyUqgOHAiUN3RxGQLM3WH/3MO3Wa7c/1I
        DmfVsSMXs5OnJfbNqVP3l2pL+3b75UwZLViy1y4=
X-Google-Smtp-Source: AGHT+IHeMXjcdPaZxrxehvdHY/F6V0qE5WfGJy0PHI3PTP6WLhm1zGuyxKZ04NDbbWnyPguSYf2AMKet/ntjIrfK948=
X-Received: by 2002:a17:907:621c:b0:9b2:bb02:a543 with SMTP id
 ms28-20020a170907621c00b009b2bb02a543mr6320414ejc.74.1698667022899; Mon, 30
 Oct 2023 04:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698418886.git.anand.jain@oracle.com> <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
 <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
 <4b206721-5bbf-4ed0-9604-fd1adb0f2729@oracle.com> <CAL3q7H5SPo2k1kqLgpPpRUuXCvr-7W5YcKEzHQ7WmBjJAn-kpA@mail.gmail.com>
 <691b6ed8-1316-4a57-9789-99718041eea2@oracle.com>
In-Reply-To: <691b6ed8-1316-4a57-9789-99718041eea2@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 11:56:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4bZ0F_wU3xAQ92QzS9oc9DNPD1n7F04oLu3e0p8phdFA@mail.gmail.com>
Message-ID: <CAL3q7H4bZ0F_wU3xAQ92QzS9oc9DNPD1n7F04oLu3e0p8phdFA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability update
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 11:52=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
>
> > Is it really worth doing this type of change?
> > I mean it doesn't change the correctness of the test, doesn't make it
> > more readable or
> > maintainable, or even shorter... It seems pointless to me, no clear
> > benefit of any sort.
> >
>
>   It fixes the cleanup bug that, when a test case failed, it failed to
>   remove the 2nd loop device.

Then that's a very strong reason to make it a separate patch and
explain the bug, instead
of sneaking it in with other different changes without being explicit about=
 it.

Thanks.

>
> > I'm not suggesting a new test case.
> >
> > Remember the code you removed in v1?
> > My suggestion was to instead of removing it, just surround it in the bo=
dy of an
> > if statement:
> >
> > if temp-fsid-feature-not-abailable; then
> >     run that code you tried to remove in v1
> > fi
> >
> > Isn't that a lot simpler and clear?
>
> Alright, I'll maintain the simplicity as mentioned above. Nevertheless,
> implementing a thorough check for temp-fsid doesn't add much complexity
> either.
>
>
>
