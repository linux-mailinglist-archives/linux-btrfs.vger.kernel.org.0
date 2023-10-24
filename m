Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD997D5BB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjJXTk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 15:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjJXTky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 15:40:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3310E9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 12:40:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c75ceea588so693004966b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698176447; x=1698781247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQAl0rC44IDpm4wzCCiFnwdE9x2WCYlyNzW0Sdf0Q28=;
        b=JMfidq6EgMaFyyDQKdWBkNW5O5IXK/RwKfZjZaLbgAGaF8LoDV1WIQbcplr4wCBJun
         NH7wHqSHxmoDmo9/XoQgUrOQ6skmklRePpSPdzmgJysshchS4FoE+noAZGLhd0VaOEIc
         peLSrEJoImRqd+55FZ4V0T3Gcho7mdAlbOkHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176447; x=1698781247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQAl0rC44IDpm4wzCCiFnwdE9x2WCYlyNzW0Sdf0Q28=;
        b=ba3byUiZ7vq7T1Pempa90rwqJRhCL17b6qIFmrulsyry6lc2tJ1cs7kraIe1ylXyZk
         MJfTZgB8rfcrZuwBDSxPzqtZEmX/xkEKlB273v7CCEiko5XDQvteeKIstRCrGwo5c3Y4
         OJu/Mq7tet04B35+riAT/vwR9RGUQ8RKt+q20t6UE1XeFI9cu39z6vUPJExVEYgCcYjn
         Wkr5AQBJtvcu1pl73D/dFpi49IMgBofJOV2YeXWPLZV1n138wwbF29B+VtpgrxNYMjZF
         RHPb+6BA4FBGBgfD5PJF6261zIxIBQjxI7J3dpRXytwjbNXSHCpjSWUQchJo5oSkih6M
         UStg==
X-Gm-Message-State: AOJu0YxQIMIp5O3ABAWFFJ4PqP0KJvz8VthN5Sa8m4tj7gxxXbJj2TkI
        H9CeydFCCVJmomN5KJrYgrwuX2KBESf9s23+wjtxiCmL
X-Google-Smtp-Source: AGHT+IHqUMwhm1y2Th3B5k2/8Iz8hcwkJZ6cJI88mqpBGjYQMyiX6gOqhoMsJ9XwqACKH5Gy+fcqzg==
X-Received: by 2002:a17:906:eecd:b0:9bd:9bfe:e410 with SMTP id wu13-20020a170906eecd00b009bd9bfee410mr9263338ejb.72.1698176447364;
        Tue, 24 Oct 2023 12:40:47 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id qh12-20020a170906ecac00b009aa292a2df2sm8720590ejb.217.2023.10.24.12.40.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:40:47 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso7599169a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 12:40:46 -0700 (PDT)
X-Received: by 2002:a17:906:eecd:b0:9bd:9bfe:e410 with SMTP id
 wu13-20020a170906eecd00b009bd9bfee410mr9262779ejb.72.1698176425825; Tue, 24
 Oct 2023 12:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
In-Reply-To: <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Oct 2023 09:40:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
Message-ID: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 24 Oct 2023 at 09:07, Jeff Layton <jlayton@kernel.org> wrote:
>
> The new flag idea is a good one. The catch though is that there are no
> readers of i_version in-kernel other than NFSD and IMA, so there would
> be no in-kernel users of I_VERSION_QUERIED_STRICT.

I actually see that as an absolute positive.

I think we should *conceptually* do those two flags, but then realize
that there are no users of the STRICT version, and just skip it.

So practically speaking, we'd end up with just a weaker version of
I_VERSION_QUERIED that is that "I don't care about atime" case.

I really can't find any use that would *want* to see i_version updates
for any atime updates. Ever.

We may have had historical user interfaces for i_version, but I can't
find any currently.

But to be very very clear: I've only done some random grepping, and I
may have missed something. I'm not dismissing Dave's worries, and he
may well be entirely correct.

Somebody would need to do a much more careful check than my "I can't
find anything".

             Linus
