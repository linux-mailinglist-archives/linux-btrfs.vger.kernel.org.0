Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7588D793E11
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjIFNwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjIFNwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 09:52:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55316CF1
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 06:52:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4122129390eso22217921cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694008326; x=1694613126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXokjUwpRZNKDG1JncYqo4vjTqC9WtkhdErynV+bZfU=;
        b=Zlstutm+oRy0vISQqC3JwmkZSaSoGwlFy6NvAePe877OJp2yBXW+1oHKTQh8jSutkU
         TjDyKWrGXDdQWv/GAkdP2BVz3XJjk0dHP7b6ZVPXYgiROgoS0Qr6OY6uW+2f1xglihMU
         F051nQ452kg1ia/muRk6zAHj/LUb2681/b3fPJ7+w0NJAsh9tF/P/oYodUjG3xxMw/ve
         vmMgUwijqH2KgA9b1hs5HpM0GWehAr3fC7PqpNl8yL0mJ0GNzn9YVn6NNRVV35fHFq/b
         +7atJY8QzL/7XVN1QsdfwHEWK+aC4pmgxZ8rVaO3LXodeytG0abKogkwbuPNCUdjYovH
         faLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694008326; x=1694613126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXokjUwpRZNKDG1JncYqo4vjTqC9WtkhdErynV+bZfU=;
        b=RYCNgVISTQWagHFC0a+fIy5oU127num79lAVkXUhLZsFH3wFNuCsoQfdQ6xfurIqYN
         oLO7EhVr3X3eCdpdmSAP1amBnWvLfLPuZ+3w+z4C0Y4vC4/ZW3CiFrHuqspmWF8dj5LP
         MOPsUAGL71UZE04MkWi4ISFNsMYXIbjDqeDkUHh5QbmLrr/h5v6ANIPFb0SZ+Z9t/90e
         Bnn0pY4m3cvZJq/sfwaGWQ25dsM+thf5/nGFi3Xs0AAPnPhsuRMZp4qUbE7iOcEj4a6O
         /W/n00/xUfTPoPnoqpwna+TuY4+pyyCzrl/Hx1RMcDGXD6JH7TbZ/x5fORRd+hQtA41C
         rFzA==
X-Gm-Message-State: AOJu0YyVdMKe5yM1vroMuM4QnX+oJpUEUU6ibrkLOrYDyps0SPVC/olV
        3/qqj9Lg/A0RJH3t+Iz+UTPuDA==
X-Google-Smtp-Source: AGHT+IHvybyMvAGl18B1R6FXC6iCLkO/S49vfAqrww3PdKqHAYhunrjTp1ILcS+irkFLcMiJ9JAKAQ==
X-Received: by 2002:ac8:5701:0:b0:412:2f98:2b97 with SMTP id 1-20020ac85701000000b004122f982b97mr16608494qtw.68.1694008326380;
        Wed, 06 Sep 2023 06:52:06 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b2-20020ac84f02000000b0041020e8e261sm5324342qte.1.2023.09.06.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:52:05 -0700 (PDT)
Date:   Wed, 6 Sep 2023 09:52:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs-progs: add extent buffer leak detection to
 make test
Message-ID: <20230906135204.GB1877831@perftesting>
References: <cover.1693945163.git.josef@toxicpanda.com>
 <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
 <20230905204956.GJ14420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905204956.GJ14420@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 05, 2023 at 10:49:56PM +0200, David Sterba wrote:
> On Tue, Sep 05, 2023 at 04:21:53PM -0400, Josef Bacik wrote:
> > I introduced a regression where we were leaking extent buffers, and this
> > resulted in the CI failing because we were spewing these errors.
> > 
> > Instead of waiting for fstests to catch my mistakes, check every command
> > output for leak messages, and fail the test if we detect any of these
> > messages.  I've made this generic enough that we could check for other
> > debug messages in the future.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> There already is a script to verify more than just the error leaks, I've
> added it to all the test type running scripts so it would fail.
> > ---
> >  tests/common | 108 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 61 insertions(+), 47 deletions(-)
> > 
> > diff --git a/tests/common b/tests/common
> > index 602a4122..607ad747 100644
> > --- a/tests/common
> > +++ b/tests/common
> > @@ -160,6 +160,18 @@ _is_target_command()
> >  	return 1
> >  }
> >  
> > +# Check to see if there's any debug messages that may mean we have a problem.
> > +_check_output()
> > +{
> > +	local results="$1"
> > +
> > +	if grep -q "extent buffer leak" "$results"; then
> > +		_fail "extent buffer leak reported"
> 
> There's more than that we'd like to catch, see tests/scan-results.sh.

Yup I prefer your solution, you can ignore this patch.  Thanks,

Josef
