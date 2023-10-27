Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426067D9A59
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJ0NsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 09:48:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD789D
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 06:48:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e235d1so337453566b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698414481; x=1699019281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XE51H4eKhgCVlGJOwgRMY69+bD+zVcX+hrD/xqNek=;
        b=c6H+fb8lb2C+dj4OL0egeziow8073Rtb/w49STNgoYLwe266Euk3eLbAZHrSW/c300
         GXkUtOpA1KtkaZ5N6xNTz8/NEzQhCAA+h77LrYKP9kXK4WQq/arQhX2RvwmuRvRkY/+Z
         X65AhfDMFSP54EG8PR2gQd0CL2x71naPa2ptk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414481; x=1699019281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1XE51H4eKhgCVlGJOwgRMY69+bD+zVcX+hrD/xqNek=;
        b=pE6u8MrLICan2cd473GwEez1J7gOdvFu3epo7Y12zoNOPagZFN9rKA7smMOS6zndP9
         s1nm7dkbAal7OATvKhcQWP02mHo7zhccdzASYD2eCn2zdfD+GNJP8Vl+GTzhZOXXk1bi
         87KbvL1b7U44J7/KO099IfTlsCixr0D4ywyTVasMd4/2X/7ripPocuI7dRnw3so3iu62
         v6doacWBPJYKCpe8NPvoP44AaHCbNIBn/Wxe7Q453n9SPDqhR9Domlg/tj7YH01XnkWP
         nvo8xFLWuDXrmEy9EKKYgIkusCBATj7SMssHCObMw0Q6bpDTiYYlLCKBgbHNZKpsfr+o
         6cQA==
X-Gm-Message-State: AOJu0Yy5U/3sYY5aT6Sl6vCZkXTZM4Z+KjVnUkPEpOJ+I79iM+JpsHkU
        q4A6J9CfBCefnB2lBtaLpOogjeZn1zcfI0xhGuYjRQ==
X-Google-Smtp-Source: AGHT+IHil2gjjEGrUQKPqSQUgORWJ8HAg7LUAIgtyl2UliZKmVyaYIe5jhhmk8vP47QdenJyVUIHyJ3V+NZ0swDedg8=
X-Received: by 2002:a17:907:2686:b0:9b2:955a:e375 with SMTP id
 bn6-20020a170907268600b009b2955ae375mr2248619ejc.23.1698414481262; Fri, 27
 Oct 2023 06:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting> <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
In-Reply-To: <20231027131726.GA2915471@perftesting>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 27 Oct 2023 15:47:49 +0200
Message-ID: <CAJfpeguvpp-a3p1FdYyRsVUUzueqGFVqqAB3yoYO7HsQdyqdLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 27 Oct 2023 at 15:17, Josef Bacik <josef@toxicpanda.com> wrote:

> I have to support this file system in the real world, with real world stupidity
> happening that I can't control.  I wholeheartedly agree that the statx fields
> are not a direct fix, it's a comprimise.  It's a way forward to let the users
> who care about the distinction be able to get the information they need to make
> better decisions about what to do when they run into btrfs's weirdness.  It
> doesn't solve the st_dev problem today, or even for a couple of years, but it
> gives us a way to eventually change the st_dev thing.  Thanks,

This is very similar to the problem that overlayfs is trying hard to
work around: unifying more than one st_ino namespace into a single
st_ino namespace.    Btrfs used st_dev, overlayfs is using the high
bits of st_ino.  Both of these are hacks.

Adding one more 64bit field doesn't look like a proper solution: now
overlayfs will have to fit multiple 128bit namespace into a single
128bit namespace.

Not sure what's the right answer, but file handles come to mind, since
they have some nice properties:

 - not reused after unlink
 - variable length

Thanks,
Miklos
