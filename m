Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22A7DE813
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbjKAWYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKAWYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 18:24:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30488124
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 15:24:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d224dca585so45894566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Nov 2023 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698877465; x=1699482265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mox8X1H7M1pwsHX7MvCw8LITDXcjbr+sDfYdWZtZU/s=;
        b=cQSSiSW05nsA6PVR7AAGmXyzdorOly13R6rS468bgo3zJ/Vu+LZSARpDx6i1BcU7In
         DbmCvZdkju+epZ3zwd57UIUF7yxzeQDklMXkZAkfFe6W613dv7Jx56R3YYikuDYYlfwq
         x/qeAaddGwgaURVzp0A+C+0eRaNy6WhiAfPQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877465; x=1699482265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mox8X1H7M1pwsHX7MvCw8LITDXcjbr+sDfYdWZtZU/s=;
        b=ewFDBpDBN0T9lKzY+Zxaytj9GoizOtvGXLWV6m+2DbjduAu16etnwR7fN81fwWmB2S
         InL7Sq3gXRS9rr71YozfwiZHe2HIi0s90OdonRA6et9pYpxE5iGICx6IZ+TR3R9kRtaZ
         8RwKdwUWYpbM3jeOQj/y4PIa7GI02aOdmKdG0BHr8FuiptKDYzokDXf2xnN/4479Vz1u
         wELQl00bTJJfug4TUq4iCC3+rDCxTdInWpHAY7Ej/OrYMoXyD+zqxYgQoXdPx5YZmQcO
         oqTbc1EwVE+laHpwsivpaxGTHI2ClHIJ3sJZls57vFUxAuZelv5EpboDDJTciwLWodt0
         wVjA==
X-Gm-Message-State: AOJu0YxuW7NFU94AUKRkioAwwqUrQ6ETzW22HDiOGBtYinM833OV+0hp
        TZY3NJ7PNoPp98gEHZNgbDO6UV2loP9MCWOKV7zbqpq9
X-Google-Smtp-Source: AGHT+IEy2vUp2sRHd0mQeSXcSBWHfP+Wqns/Bty0WF/qArM+7YJmJjeEZbtCKR7noGNdoTTtNSAQeA==
X-Received: by 2002:a17:906:7310:b0:9d2:44e9:7670 with SMTP id di16-20020a170906731000b009d244e97670mr3413149ejc.19.1698877465434;
        Wed, 01 Nov 2023 15:24:25 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709064c4800b00988dbbd1f7esm409214ejw.213.2023.11.01.15.24.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 15:24:24 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-32f7db21967so154428f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Nov 2023 15:24:24 -0700 (PDT)
X-Received: by 2002:a17:906:ee8b:b0:9be:263b:e31e with SMTP id
 wt11-20020a170906ee8b00b009be263be31emr2561024ejb.33.1698877442973; Wed, 01
 Nov 2023 15:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area> <20231101101648.zjloqo5su6bbxzff@quack3>
 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com> <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
In-Reply-To: <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 12:23:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
Message-ID: <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        John Stultz <jstultz@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>, dsterba@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 1, 2023, 11:35 Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> My client writes to the file and immediately reads the ctime. A 3rd
> party client then writes immediately after my ctime read.
> A reboot occurs (maybe minutes later), then I re-read the ctime, and
> get the same value as before the 3rd party write.
>
> Yes, most of the time that is better than the naked ctime, but not
> across a reboot.

Ahh, I knew I was missing something.

But I think it's fixable, with an additional rule:

 - when generating STATX_CHANGE_COOKIE, if the ctime matches the
current time and the ctime counter is zero, set the ctime counter to
1.

That means that you will have *spurious* cache invalidations of such
cached data after a reboot, but only for reads that happened right
after the file was written.

Now, it's obviously not unheard of to finish writing a file, and then
immediately reading the results again.

But at least those caches should be somewhat limited (and the problem
then only happens when the nfs server is rebooted).

I *assume* that the whole thundering herd issue with lots of clients
tends to be for stable files, not files that were just written and
then immediately cached?

I dunno. I'm sure there's still some thinko here.

             Linus
