Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A287889E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbjHYOBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbjHYOBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F026B6
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692972019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjxak9bo89OebQVshAcR8xV4lyZfu4tcklNih1ULQqY=;
        b=a/T2rsqLEqfP9R5oAjR5tj/MrQwptGyftVxYlN2K6zDeee+KR/KGSRnTH0jaCINcsQ2UqF
        fKYCYB7TErfVkJiW8ffNGNKYQ6pKm/2grUtQDnhdzf/0KxRCyxvOgLKWvHs/fXlQf1dpx0
        fFvEUfzNQ6tYhcdypOH08DwIXVjR8FY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-rrQddHiJPqSRwo73JJ3TpA-1; Fri, 25 Aug 2023 10:00:16 -0400
X-MC-Unique: rrQddHiJPqSRwo73JJ3TpA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68bf123af64so1099738b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972016; x=1693576816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjxak9bo89OebQVshAcR8xV4lyZfu4tcklNih1ULQqY=;
        b=It/GPeE7LEA0nxgQe0thRyaBCK+N367DC8bFknnR3lvAYQrV4AqlwnBK7IuHbN7eqq
         aqLuJbUh7VB6SlufLoIh9t64oJWa9xr+OsT4ee18gWR4xY5120Q1/jYTbUC2GaaRb9hv
         FCkmlp5mUjiXqe6Ay+yxP+G7m2ZDuXcoaGeDBxmNZaY34B/jXtgBkOl0dvnVAfXHSPcV
         qI9KlUsV/dL1ujvqBw+DigLz2Iq150DdR8cWn3K9cA4cCKfN9qWq5bywD/8JJM+S9tmd
         0mh4ONkGw+RZFQd2nT0yfxKJDDlVfD8S1Xy5x8znwcg7iJGBly2rjJmnvOXM0maADjBp
         1I3Q==
X-Gm-Message-State: AOJu0Ywi6eHqMWafmk8FPNAz6welxsWJoB1TitYwOg7/+wu1wMsD91Va
        TksTjToLO9yrOJqBbwHoplZUpd076c0E7IbiCKWV2+YU1Zg9WCvUwcD9i8Sis4WLyLQ2YZpxjdx
        mncGfNvOgwMZZMLehXN69rrE=
X-Received: by 2002:a05:6a00:2354:b0:68a:6e79:d23b with SMTP id j20-20020a056a00235400b0068a6e79d23bmr11702248pfj.23.1692972015386;
        Fri, 25 Aug 2023 07:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLebA4sWSvMf5za4+Qucu3UOW/hpn/TicURPd7Beo5zSzX+vfX2PvKu1KYi02yGz+VTymeA==
X-Received: by 2002:a05:6a00:2354:b0:68a:6e79:d23b with SMTP id j20-20020a056a00235400b0068a6e79d23bmr11702035pfj.23.1692972013250;
        Fri, 25 Aug 2023 07:00:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00686a80f431dsm1561864pfa.126.2023.08.25.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:00:12 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:00:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Message-ID: <20230825140009.4pg43yyprmunrxkn@zlang-mailbox>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
 <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 09:39:48PM +0800, Zorro Lang wrote:
> On Mon, Aug 21, 2023 at 04:12:11PM +0900, Naohiro Aota wrote:
> > Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
> > random file in a directory.It sorts the files with "ls", sort it randomly
> > and pick the first line, which wastes the "ls" sort.
> > 
> > Also, using "sort -R | head -n1" is inefficient. For example, in a
> > directory with 1000000 files, it takes more than 15 seconds to pick a file.
> > 
> >   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
> >   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total
> > 
> >   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
> >   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total
> > 
> > So, we should just use "ls -U" and "shuf -n 1" to choose a random file.
> > Introduce _random_file() helper to do it properly.
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/rc | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 5c4429ed0425..4d414955f6d9 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5224,6 +5224,13 @@ _soak_loop_running() {
> >  	return 0
> >  }
> >  
> > +# Return a random file in a directory. A directory is *not* followed
> > +# recursively.
> > +_random_file() {
> > +	local basedir=$1
> > +	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
> 
> I think the "1" can be the second argument, for we might want to get a random
> file list sometimes. For example:
> 
>   local basedir=$1
>   local num=$2
>   local opt
> 
>   if [ -n "$num" ];then
> 	  opt="-n $num"
>   fi
>   echo "$basedir/$(ls -U $basedir | shuf $opt)"
> 
> What do you think?

Hmm... nack my review point. Looks like this makes a simple change to be
complicated, especially multiple output lines. I'll merge this patchset
at first, then we can support that second argument If we need that
feature in one day. Or if you're interested in it.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > +}
> > +
> >  init_rc
> >  
> >  ################################################################################
> > -- 
> > 2.41.0
> > 

