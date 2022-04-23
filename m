Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2732950CDEF
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiDWW3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWW26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 18:28:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C6B878
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 15:26:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 09D555C0110;
        Sat, 23 Apr 2022 18:26:00 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Sat, 23 Apr 2022 18:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1650752760; x=1650839160; bh=ybZkkdSZl+
        +N2gv6oJYw2+armFAA3Ods6WnS23SoItk=; b=N4QBU0GdakWmuzLWTpRilJt39u
        8UeB+nNqfrW94O0V4py73f+jv7fna1yaLPQWoABxAjN1B+8Yu5gvsTH1nDJM9KIy
        95athCrXSYf1rhDFMRr4/CNjPf7qfI4HtB2lLn1PcWZcNrg+7s8BpKNhv/QmBPWj
        nkt9tk2LTjADIjK3eKAO9fVLS3VwpOOT+Yvk7zjmwB+Tmsu8LS/viAqpDo7YnV1i
        EWGZSrsVhr4pJUbtH0S1Mb6diRjrCk/rt2/NI91urrlgkZ0yZwR0VbVsxDSAD3oS
        smc2e51XFcf3UFyrzDTG1eNi8E3Yf1di5cC01KkmiEFn9kfnEIfcyEaS05mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650752760; x=
        1650839160; bh=ybZkkdSZl++N2gv6oJYw2+armFAA3Ods6WnS23SoItk=; b=X
        kmmNF78gQ8Tw5Gg8tb6bgFmINiF0PsZmcOC6aNGJLfAkQ+kMryQfnCkAvw4G+tlt
        /1bk+KjuSlbsG8RcC14qIye8MH1S3zsst428bxrubhAMSg6mKnXHCwaaREvvh0qi
        lP+RcFDKHeRvEwxSOb+4ZAmeVHsICAial4xTNkubphl8F8F/dTo7lO/a6OfIzL1c
        kwElHY951si5JrkjWo+fUJ293yhkHY0Q/y7oxEJ1sm4tpdPZXaVr8Oml5z879r3h
        zZi9arvLSGk+e2syUsfIxJuL5xbFjvA1bzj5ZCF12gWOVVEHcl8p7GWsz+gNi34c
        DeDtHk0DyhfwCznY8Mrsw==
X-ME-Sender: <xms:93xkYlBUS_KQs1GJkTokc8r6yIKpjCHHG0koFeat8aBMK-JgLVPR3w>
    <xme:93xkYjjiiDnf-WgmtEdaNPCu7fA-DB-3QhDmeu9Ow7EQf4V4f3WrYJb1jOEPH9K4L
    3kuowDQxSjxYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomheplfgrthcuoegsthhrfhhssehjrghtrdhfrghsthhmrghilhdr
    tghomheqnecuggftrfgrthhtvghrnhepuedtieekhefgudelgfekieelheffieeikeelud
    dvueekteefveffgffggffgvedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghtrhhfshesjhgrthdrfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:93xkYgn6ho3UMKxPE6OTClKzNN6xAmyy1qMeih-iIYJkAUMjwhVW_w>
    <xmx:93xkYvz3SxpQOCTJMYeIx04tjuYwJZIY0w7OF5WETeoRFCbMfVqvsw>
    <xmx:93xkYqTCuNOlc0fFa8YHqcCpYF9gU7biALd0R022kDx8Cn9qEETcGQ>
    <xmx:-HxkYhMkAlk1_FEIQEy8vB5VTBdS_OrBb7eRpoE2ZOzSBLC7U2lKig>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA8DCAC0E98; Sat, 23 Apr 2022 18:25:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <e6e90f1f-4e6c-496f-8f0b-69ec93a1513a@beta.fastmail.com>
In-Reply-To: <a03acb5f-02dc-491b-b44d-62a59246c4f7@beta.fastmail.com>
References: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
 <fe391705-79d2-a365-27ca-fc52b260fcbf@gmx.com>
 <a03acb5f-02dc-491b-b44d-62a59246c4f7@beta.fastmail.com>
Date:   Sat, 23 Apr 2022 15:25:39 -0700
From:   Jat <btrfs@jat.fastmail.com>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check fail
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Okay, I got it resolved, btrfs check passed and partition moved & resized successfully.
Solution was to move the files to a different filesystem and back.

Thanks again!
Jat

----- Original message -----
From: Jat <btrfs@jat.fastmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check fail
Date: Saturday, April 23, 2022 10:40 AM

Thanks very much, Qu!
I attempted your advise, but was only partially successful.

> Recommended to go v2 cache.
Done, no problem.

> just go copy the files to other locations and remove the old file
This is where I had trouble.
I tried on just one file to start:
/mnt/@_190127freshinstall/var/log/journal/b0eb202aa367415fb973e99ecd54889e/user-1000.journal

I made a copy, deleted the original, and then renamed back to original:
cp user-1000.journal user-1000.journal.temp2
rm user-1000.journal
mv user-1000.journal.temp2 user-1000.journal

But afterward I got the same error, just different inode:
Pre: root 267 inode 249749 errors 1040, bad file extent, some csum missing
Post: root 267 inode 249772 errors 1040, bad file extent, some csum missing

What have I done wrong?

Thanks again for your help!

Regards,
Jat


----- Original message -----
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jat <btrfs@jat.fastmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check fail
Date: Friday, April 22, 2022 9:53 PM



On 2022/4/23 11:56, Jat wrote:
> Hello,
> I am trying to resize a partition offline, but it fails the check.
> The output of running btrfs check manually is below, can you please advise me how to resolve the issues?
>
> Here is the output from btrfs check:
> sudo btrfs check /dev/sda7
> Opening filesystem to check...
> Checking filesystem on /dev/sda7
> UUID: 4599055f-785a-4843-9f59-5b04e84fea1a
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated

Recommended to go v2 cache.

You can just mount it with space_cache=v2.

> [4/7] checking fs roots
> root 267 inode 249749 errors 1040, bad file extent, some csum missing
> root 268 inode 466 errors 1040, bad file extent, some csum missing
> root 308 inode 249749 errors 1040, bad file extent, some csum missing
> root 313 inode 466 errors 1040, bad file extent, some csum missing

Please run "btrfs check --mode=lowmem" to provide a more readable output.

There are several different reasons to cause the "bad file extent".

 From inline extents for non-zero offset, to compressed file extents for
NODATASUM inodes.

The later case can explain all your problems in one go, and can be
caused by older kernels.

If that's the case, you can just go copy the files to other locations
and remove the old file, and call it a day.

Thanks,
Qu

> ERROR: errors found in fs roots
> found 103264391173 bytes used, error(s) found
> total csum bytes: 93365076
> total tree bytes: 2113994752
> total fs tree bytes: 1825112064
> total extent tree bytes: 144097280
> btree space waste bytes: 432782214
> file data blocks allocated: 352758886400
>   referenced 178094907392
>
>
> Here is the requested info from Live boot environment for offline partition sizing & btrfs check...
> uname -a
> Linux manjaro 5.15.32-1-MANJARO #1 SMP PREEMPT Mon Mar 28 09:16:36 UTC 2022 x86_64 GNU/Linux
>
> dmesg > dmesg.log
> [Sorry, didn't capture this after running the check in live boot environment. Will capture as needed next time along with recommendation]
>
>
> Here is the requested info from within mounted environment...
> uname -a
> Linux manjaro-desktop 5.17.1-3-MANJARO #1 SMP PREEMPT Thu Mar 31 12:27:24 UTC 2022 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.16.2
>
> sudo btrfs fi show
> Label: 'manjaro-kde'  uuid: 4599055f-785a-4843-9f59-5b04e84fea1a
>          Total devices 1 FS bytes used 96.19GiB
>          devid    1 size 226.34GiB used 226.34GiB path /dev/sda7
>
> btrfs fi df /
> Data, single: total=220.33GiB, used=94.92GiB
> System, single: total=4.00MiB, used=48.00KiB
> Metadata, single: total=6.01GiB, used=1.97GiB
> GlobalReserve, single: total=275.20MiB, used=0.00B
>
>
> Thank you,
> Jat
