Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6753C7D16C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 22:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJTUG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTUG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 16:06:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA38D66
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:06:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507c78d258fso1683732e87.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697832413; x=1698437213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJwcfh7XT4p/d8xdEQd3o4yb8QA8P7Clkcjdf6k/CEg=;
        b=Kf3wonhvX2PwskG5BuS/VMwWUl7KM2wQCQX+FRa7eUlDg+AB1dTaoRsE/vdu7j0dUs
         NviZhW6s0eUJEteSaSSjEXj36sLCUUjxUKVee4Ag4ivdpY9pFyiiD67+Q5+QLePvaAyr
         V+ZIB9kUvoNEADDAqGUCcK4t0mJxNorVKr5Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832413; x=1698437213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJwcfh7XT4p/d8xdEQd3o4yb8QA8P7Clkcjdf6k/CEg=;
        b=wTB9MzdRD+Rvp/ohOVHlkbCzJNqp6zP9Fs1f0Qd2aFta55ky0nEs4MVcZwlJp8b8aZ
         srjQtYjHSlNnflaMalH9MkYQb59+fF2xhjpNebKosHH7WmWhv9sDPeW1k6yb2/kTHVkx
         jcJDMBPQC4E/oADDxMYk0ehiY3qIw2rqD7hpyPxxVYAfQluWu4bqmapbxt+cOZnv4Q3l
         IVounKeVP5lp3IOwfeP3B/pEZoQTu7J/6CMF7VbAUM1vXXSYObQGWFNG+7JtWIf24S4v
         +uK9W1aa4x5t9/TyURrpV+hoeXiv+f9OW/9MwdQhZZZKAiMMSt1RYBwac+AddhffSSBE
         0G+w==
X-Gm-Message-State: AOJu0YyZnzfJ2TohdqRScIdR3ipJrsOy7bsfRhLt/l/1tEA/YnKnLA3A
        YHs+hDFdikkQssP2NXehM7IkQ/QRJlfcbQdZCahSMPGo
X-Google-Smtp-Source: AGHT+IFbCSkE8vuxsQnRRj+CaRXaZZdpPvU+4BSShISNgY5wLQ6ecgt4A81F+aDfF28x/QbI8ALBKQ==
X-Received: by 2002:a05:6512:baa:b0:500:acf1:b432 with SMTP id b42-20020a0565120baa00b00500acf1b432mr2354254lfv.63.1697832412810;
        Fri, 20 Oct 2023 13:06:52 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id g11-20020a19ac0b000000b0050796194d2bsm500410lfc.153.2023.10.20.13.06.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:06:52 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso1689676e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:06:51 -0700 (PDT)
X-Received: by 2002:a17:907:c1f:b0:9ba:65e:752b with SMTP id
 ga31-20020a1709070c1f00b009ba065e752bmr2061794ejc.39.1697832390868; Fri, 20
 Oct 2023 13:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
In-Reply-To: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 13:06:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
Message-ID: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 20 Oct 2023 at 05:12, Jeff Layton <jlayton@kernel.org> wrote:.
>
> I'd _really_ like to see a proper change counter added before it's
> merged, or at least space in the on-disk inode reserved for one until we
> can get it plumbed in.

Hmm. Can we not perhaps just do an in-memory change counter, and try
to initialize it to a random value when instantiating an inode? Do we
even *require* on-disk format changes?

So on reboot, the inode would count as "changed" as far any remote
user is concerned. It would flush client caches, but isn't that what
you'd want anyway? I'd hate to waste lots of memory, but maybe people
would be ok with just a 32-bit random value. And if not...

But I actually came into this whole discussion purely through the
inode timestamp side, so I may *entirely* miss what the change counter
requirements for NFSd actually are. If it needs to be stable across
reboots, my idea is clearly complete garbage.

You can now all jump on me and point out my severe intellectual
limitations. Please use small words when you do ;)

              Linus
