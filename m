Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13816C8AEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 05:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCYEhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 00:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCYEhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 00:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B21715
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679718993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5qPKGmeJLRq4H/sWaugxhIkihelx6JO1ZWIpbGqYDI=;
        b=Xm3hMnXw8LxbCNjtUy6yGF8LB755w9mAle/5+odrImQFOyzIRGoZIR2vkw5uhGkddeF3cO
        8Fi84BOevF7NCGlCNV+G01Qqz7TmffDE2mhunnTgiU6HB1q9WXF9m0AeZl2yfWZZMwrUbw
        gBjPFful2k9DjdBUGCK1hKnrxBo20Fk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-aP30mxv8NEWQCAxhaVcOow-1; Sat, 25 Mar 2023 00:36:30 -0400
X-MC-Unique: aP30mxv8NEWQCAxhaVcOow-1
Received: by mail-pf1-f200.google.com with SMTP id a6-20020aa795a6000000b006262c174d64so1892487pfk.7
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 21:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5qPKGmeJLRq4H/sWaugxhIkihelx6JO1ZWIpbGqYDI=;
        b=bFAk+csbiTlHU4WDN1bvHltAdVDgIXxnWiwUnYXZjkIhW76l9AbmXCTZQxk611PVpX
         jJKvP4eqV8/giW2LdA/yuPPpJaX5DsCDz2PUk6Jg+nTtSu9nR1xRw2njsNOhqrNkA4Tr
         Ze/aXqhGFuYcdw6H0QDyGNb6eGtViSqpRGyljqVRJQ7R2jyFrmh8SUKJXrbJCvzWhYEL
         4QZGMa+UVrYZXfnuJ4vy62ndNN2++SphKUjk+u3qYKlwygCkTkOfBLAavUZZUGME/h/N
         oHmZQZ++Zq2UYM8nGSrDJ7ppn9cXiBRwGzinn109nO4ajtO8Zp3FyojIn9pFJRxImNHe
         BTDA==
X-Gm-Message-State: AO0yUKVNQ5AkRFvPZFBPPe4vjQ+oWtzD/ydi8YOJEq/Zhp3W/xdFgH4D
        i7WEmiNwVhpjlwW1Mj92iCQs63cWly2OAmxjLi20g3f+7tLTGORmZwJ+4VyeWIOaw4f40uIZLDY
        KU0MCAeaWiU7NW5rNBK98ss0G+qorB9nMMw==
X-Received: by 2002:a05:6a20:4a13:b0:d8:afd4:4ac7 with SMTP id fr19-20020a056a204a1300b000d8afd44ac7mr4738797pzb.4.1679718989645;
        Fri, 24 Mar 2023 21:36:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set/lE7nftz3cP9O6orQxf6eDARJPZQN/NwzQpZUv1HpXjtY5GIUa8oyHfI94j/Zhg7lojxtP4Q==
X-Received: by 2002:a05:6a20:4a13:b0:d8:afd4:4ac7 with SMTP id fr19-20020a056a204a1300b000d8afd44ac7mr4738781pzb.4.1679718989199;
        Fri, 24 Mar 2023 21:36:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b00627fafe49f9sm10410603pfo.106.2023.03.24.21.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 21:36:28 -0700 (PDT)
Date:   Sat, 25 Mar 2023 12:36:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/012 don't follow symlinks for populating
 $SCRATCH_MNT
Message-ID: <20230325043624.6mtmz4tjkyfors7u@zlang-mailbox>
References: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
 <20230325014628.0b18621b@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325014628.0b18621b@nvm>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 25, 2023 at 01:46:28AM +0500, Roman Mamedov wrote:
> On Fri, 24 Mar 2023 16:13:19 -0400
> Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> > kernel was built from, which can have all sorts of stuff, which will
> > make the runtime for this test exceedingly long.  We're just trying to
> > copy some data into our tree to test with, we don't need the entire
> > devel tree of whatever we're doing, so use -P to not follow symlinks
> > when copying.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/btrfs/012 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > index d9faf81c..1b6e8a6b 100755
> > --- a/tests/btrfs/012
> > +++ b/tests/btrfs/012
> > @@ -43,7 +43,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> >  
> >  _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
> >  
> > -cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
> > +cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT
> 
> But did you face the described problem in actual operation?

Same question, due to from what I tested[1], current options "-aR" don't
follow the symbolic. Is there any different on your system, or your fs?
Can you show more details about the issue you hit?

Thanks,
Zorro

[1]
$ mkdir testdir
$ cd testdir
$ ln -s ../xfstests link-dir
$ ln -s ../img link-file
$ cd ..
$ cp -aR testdir/ copydir
$ ls -l copydir/
total 0
lrwxrwxrwx. 1 zorro zorro 11 Mar 25 12:29 link-dir -> ../xfstests
lrwxrwxrwx. 1 zorro zorro  6 Mar 25 12:29 link-file -> ../img




> 
> "man cp" says 
> 
>        -a, --archive
>               same as -dR --preserve=all
> ...
>        -d     same as --no-dereference --preserve=links
> ...
>        -P, --no-dereference
>               never follow symbolic links in SOURCE
> 
> So -a includes -d, which already includes -P that is now being added.
> 
> Moreover, even -R is redundant in the original line and could be removed.
> 
> -- 
> With respect,
> Roman
> 

