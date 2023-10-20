Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574767D16D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjJTUVn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjJTUVm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 16:21:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26483D66
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso189596166b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697833298; x=1698438098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=hqc7ea0COAmFv5MZPwSBclL6NfgTYs+tcpUPSzzToCUZ/TwOo0hu4g8a7FGMseXNsd
         NyABRTQUYO3pBlR8m58SHKKix/tS2Kbetb/DHV2SUb1E2yfgMlnbb6fsD4tQ6kvq4agG
         rYfEk8Cp6+fRvYnrlk4hLH6JfDTVzKAvswqRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833298; x=1698438098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=gube3PpLlXQgta/mkEbFbjpOsx9cpbbij6G1qJWRHBRPrv8d3k69MLtE+LsHLXF6FH
         NiLHrE+jTg5c+QuB87S+6wnyyzONT0uVyPmd2SIWWd/j4e+19Z9NlXGwr133+f7oM+vM
         hGqHyCjQLH7EFH7wM8UBbGSQIptyTPRxL8bYLVCUlF5NaUwV8lEiqkkWG7FI9kPUSt3K
         EO8BYPlbB6q+eI3hVlZRYyLUOq8a2Yq0zFsZTbZ1ZVpeodvamtTGon+Bf8fd/SPEiZ69
         D3QULLgL9b1oJ+1cl/xzZ3pDsGiSjgcyebAue1zKwEXQ4FLSB6hrj5rZWZaAk/y57ILn
         Pz7Q==
X-Gm-Message-State: AOJu0YzrIt7G1KaoK2JsmE533PYuJd/pmHnWcMeAP/dJ3yj0B3CYw3Uv
        PX00CXakqNPr3LC9sizGFTm6JDaHtftiQo4CkgROlSNg
X-Google-Smtp-Source: AGHT+IEa0MLbRiEjqDR7WMCf9sn9Z96b7z7G5t+pkNbtfCd7DfNUJhusIC7pMf3ylo5iyZBhGKacOg==
X-Received: by 2002:a17:907:a03:b0:9c4:344e:b48c with SMTP id bb3-20020a1709070a0300b009c4344eb48cmr2275441ejc.36.1697833298554;
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709062c5100b009c5c5c2c5a4sm2094559ejh.219.2023.10.20.13.21.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4083f61312eso9712545e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
X-Received: by 2002:a17:907:7e9e:b0:9ae:50e3:7e40 with SMTP id
 qb30-20020a1709077e9e00b009ae50e37e40mr2195962ejc.52.1697833276793; Fri, 20
 Oct 2023 13:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
In-Reply-To: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 13:20:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
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

On Fri, 20 Oct 2023 at 13:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So on reboot, the inode would count as "changed" as far any remote
> user is concerned. [..]

Obviously, not just reboot would do that. Any kind of "it's no longer
cached on the server and gets read back from disk" would do the same
thing.

Again, that may not work for the intended purpose, but if the use-case
is a "same version number means no changes", it might be acceptable?
Even if you then could get spurious version changes when the file
hasn't been accessed in a long time?

Maybe all this together with with some ctime filtering ("old ctime
clealy means that the version number is irrelevant"). After all, the
whole point of fine-grained timestamps was to distinguish *frequent*
changes. An in-memory counter certainly does that even without any
on-disk representation..

               Linus
