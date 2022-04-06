Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9E4F5437
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiDFEpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444276AbiDFEOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 00:14:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116822A963D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 17:23:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9so784724ilu.9
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 17:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9lHAPzR860uqR9gEm09FQDKG1l6N/WbZo2E7adU8Fk=;
        b=wZeUoOFkyEQX3BbgdEoAXX/aML62k6EOX1bwfvoKo21gfZl0NDgsTHQZfLnA7m0DcA
         uOivHZfZrsvbsSn9UxXHiYayC3jN4rHYrrY/7Yk1yeqhrUqzd8WrYlEWg4F05d9f1w6b
         pwzLvfce2VkbejdXw8vcQuYYIEeAxjMaKhGx9SkDXWKpYN5na8o3SArkEYH32X1rHXvb
         zZq0bQ7AgqqTUcjdZr6wqPGCsI7+eN4AnzFv7NsNIdfWu+cbfqzxY7Hyvhw7amYU5gCV
         daL8/53yC/C0IIBqpdg8nMzzuNjhSC5SyXs6KCmc8efSLSJ/xdyn/pFbPsaO+pqGolvx
         BIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9lHAPzR860uqR9gEm09FQDKG1l6N/WbZo2E7adU8Fk=;
        b=vm4nm+LhxGdsx2kVOtqRWIAzFEjqc2NOlVkxxOpFwubGT+RdYWypVH4UDZLgwSBqGj
         znQw6otamLlzk36xfsmRe0M5ey5GeyeWGMY9/yLJ/MTTkn+w/+VT6uBmgVHZknceyDuI
         vlQPIBRrCCSoKZjggUpO5Ve9pV5Vxn2sMTEZw1ukvYKlrshiS2nV/3yYq/RZntxRuoyX
         gYSchb9T1jpLa8wUIG9rJGQdHY7G41q7kArJcz/xxup/Ea7+ulryQhFcN5pJWihJ8YNc
         DVM4v1w3fiVxwTTACDHlhjQ6Whx6ErD6Ki9lWacy/CMAkJXqOIgGu8XEE7MaRK0ydkLt
         ojrw==
X-Gm-Message-State: AOAM532/0IpxOOAltDBx8nau8QknUZJbAu5BPsJimj94O8TOIPfb35Sh
        B68PWffdHhS8VV03qTOPExu2k91rUPKW8MLlsirvBEqk3QU=
X-Google-Smtp-Source: ABdhPJypD+lxPndLNEQHoV/Lz4vykQfBCFItrj345Y1mAOFkNVQNCOGZ78EocXY05fur8KLIirNWODg0KpJLnSqOx9M=
X-Received: by 2002:a05:6e02:b4d:b0:2c8:45ac:66b1 with SMTP id
 f13-20020a056e020b4d00b002c845ac66b1mr3165549ilu.153.1649204634104; Tue, 05
 Apr 2022 17:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org> <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org> <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org> <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org>
In-Reply-To: <20220405225808.GJ28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 20:23:42 -0400
Message-ID: <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 6:58 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 06:41:02PM -0400, Josef Bacik wrote:
> > I'm wandering down this rabbit hole because if I'm able to read the
> > blocks fine, wtf is the device root not being found.  I've pushed more
> > printfs, lets see what that says.  Thanks,
>
> Sure thing. Output is kind of big, summary here, full output bzipped and
> attached
> But isn't the tree found at the end?
> Found tree root at 13577814573056 gen 1602089 level 1
>

Alright it's time for the crazy.  Go ahead and pull and start running.
This is going to take a while to run, we're basically going to walk
and check all the node pointers in the tree root, if it doesn't look
right we're going to search the metadata for the best copy to use, and
then update the block to point at the new block.  It has to do the
full search every time, because we don't have time for me to properly
implement a cache, so don't be worried if it takes a while.

It may print out stuff, if it looks like it's looping stop it and let
me know, but I don't think I fucked it up.  You're going to see a lot
"fixed root <id>", "fixed slot <whatever>", if you see it repeating
the same slot or root then we know we have a problem.

Once it's done can you do the print-tree ROOT thing again so I can see
if it did the right thing.  Thanks,

Josef
