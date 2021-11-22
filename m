Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80434591A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhKVPyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 10:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhKVPyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 10:54:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F999C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:51:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso17248538pji.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6+RrtX/RqIJP9MdrzcI2o2KCOQtGt5iHYtstZKO1Xjc=;
        b=WbO5Ojx4GL89XY0Y7ckwiUkjlDJiPLUuTP73bAcEz06GTAnL7EtGXQTFtrBFrXmHJy
         jLYn1pJlA21uyajZK1MI+XAGdxXHc+rE1HaOOrJ0Kv5CxBJ/kq820sRJKdHhRdhShkKj
         gyP2B4PHKlZHRu+nDcMwrytllDsp0haYDyaZibzlYqDgj/5qsos9/C3okRAFfHs+0ML+
         d9aetsBZBGsAsBRPwCYEP9gYqeGIyeXjsllecMvIJZhwUnjD59+EWx8B9HVB4xU0URKB
         rm+fVU5wl3w9Xw0DKElgX51be6oT0WDzJ7RZZqEb2AORbgb/yB89N2CJTDPESjNMT7WM
         MvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6+RrtX/RqIJP9MdrzcI2o2KCOQtGt5iHYtstZKO1Xjc=;
        b=PjxyqAQ9x6j+mIWHx1hwlFWpXSkhhfNO/bYU7rYIxHoWHCucjWA9rg8rB3Hbmmc/3Q
         NGkpu+l2yxIJrT6ZnD8FgGKzlGbhsMlJW3vegtMak8FswwDJPPujt1srxzqIo8e9sEIg
         rilYRcCYBllGchEL/fpQTplo3KEUwcB5PwnCVcavMtlAlPW5S8st6Tt7Yg5uKd4vVR7u
         JaT207PoQeQMrXthKCLmJLQ5+jwnKRzRBNkvHEdCnBNdB3eOKs69sTMbifC0LHR0ZT31
         ovbEfxsIKWQ/foQoLrBRjRe/V3EIKBVTh1oiP9V/he4hp8MbhZ2lH+nCFJNfTVyvLqSe
         n43A==
X-Gm-Message-State: AOAM5322fgTLbVdzUohVNpT++kHJXkhen2E3ey/vd6td5Rf5unszwPGK
        DlHUKYkBy+sMjmlDRoGaWkmOLyXr64r6Lw==
X-Google-Smtp-Source: ABdhPJySl7aKw6SyAsUX0BlLcq+Iunh1Jd8aLAfhe1+DIbIzsH9SyptqXi5mP2K6s/38dcxuCvgjWg==
X-Received: by 2002:a17:902:9303:b0:143:d6c7:babc with SMTP id bc3-20020a170902930300b00143d6c7babcmr63906116plb.58.1637596288038;
        Mon, 22 Nov 2021 07:51:28 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k91sm8064429pja.19.2021.11.22.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:51:27 -0800 (PST)
Date:   Mon, 22 Nov 2021 15:51:20 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211122155120.GA10576@realwakka>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
 <20211122083240.GB8836@realwakka>
 <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
 <a5cd8f64-066e-8791-5de8-a2263d50f597@cobb.uk.net>
 <0a7ce0b1-300c-233b-d844-012dfc771efe@suse.com>
 <20211122151027.GA10523@realwakka>
 <b07b5fb0-a545-264a-9e6c-0ccdd1bb728c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07b5fb0-a545-264a-9e6c-0ccdd1bb728c@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:20:30PM +0200, Nikolay Borisov wrote:
> 
> 
> On 22.11.21 г. 17:10, Sidong Yang wrote:
> > On Mon, Nov 22, 2021 at 12:57:18PM +0200, Nikolay Borisov wrote:
> >>
> >>
> >> On 22.11.21 г. 11:53, Graham Cobb wrote:
> >>>
> >>> On 22/11/2021 09:32, Nikolay Borisov wrote:
> >>>>
> >>>>
> >>>> On 22.11.21 г. 10:32, Sidong Yang wrote:
> >>>>> On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 21.11.21 г. 17:15, Sidong Yang wrote:
> >>>>>>> This patch handles issue #421. Filesystem du command fails and exit
> >>>>>>> when it access file that has permission denied. But it can continue the
> >>>>>>> command except the files. This patch recovers ret value when permission
> >>>>>>> denied.
> >>>>>>>
> >>>>>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> >>>>>>
> >>>>>>
> >>>>>> The code itself is fine so :
> >>>>>>
> >>>>>>
> >>>>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> >>>>>>
> >>>>>>
> >>>>>> OTOH when I looked at the code rather than just the patch I can't help
> >>>>>> but wonder shouldn't we actually structure this the way you initially
> >>>>>> proposed but also add a debug output along the lines of "skipping
> >>>>>> file/dir XXXX due to permission denied", otherwise users might not be
> >>>>>> able to account for some space and they can possibly wonder that
> >>>>>> something is wrong with btrfs fi du command.
> >>>>>
> >>>>> You mean that it would be better that print some debug message than
> >>>>> skipping silently. I agree. So I would add this code in condition.
> >>>>>
> >>>>> fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);
> >>>>>
> >>>>> I think it's okay that it prints when ENOTTY occurs. Is this code what
> >>>>> you meant?
> >>>>
> >>>>
> >>>> I meant to print only if we have EACCESS, but now that I think about it,
> >>>> printing something when we have a non-fatal error and simply skipping
> >>>> some dirs/files makes sense. OTOH printing it by default might be too
> >>>> verbose so perhaps usuing a pr_verbose call would be more appropriate.
> >>>>
> >>>> This is one of those things which don't have a clear-cut answers so it's
> >>>> useful to get as many perspective as possible to arrive at some workable
> >>>> solution to a wider number of people.
> >>>
> >>> I must admit I just assumed it worked the same way as /bin/du. I have
> >>> just created an inaccessible directory and got:
> >>>
> >>> $ du -sh ~
> >>> du: cannot read directory '/home/cobb/permtest': Permission denied
> >>> 61G	/home/cobb
> >>>
> >>> And when the directory was accessible but the file in it was not, I got:
> >>>
> >>> $ du -sh ~
> >>> du: cannot access '/home/cobb/permtest/file': Permission denied
> >>> 61G	/home/cobb
> >>>
> >>> In other words, I think any error should be printed but the error is
> >>> then skipped and the du continues. No need to tell people the file is
> >>> being skipped - that is obvious. But the error must be printed by
> >>> default (if there are really cases where the error should not be printed
> >>> but reasons not to redirect stderr to /dev/null then add an option to
> >>> suppress printing it).
> >>>
> >>> Just my opinion.
> >>
> >>
> >> That actually works for me, I'd rather btrfs be as consistent as
> >> possible and not give surprises to users. So just mimicking what an
> >> omnipresent tool does is as good as it gets :)
> > 
> > Yeah, I understood that any error should be printed but no need to print
> > that it is skipped. I agree. If so, I think the code that print error
> > message should like below.
> > 
> > fprintf(stderr, "failed to walk dir/file: %s: %m\n", entry->d_name);
> > 
> > I agreed that btrfs command should be like "du" command that familiar
> > with users. I wonder if I understood it well.
> > 
> > If so, I think it would be better that use switch-case than if-else.
> 
> let's be inline with du:
> 
> fprintf(stderr, "cannot access: '%s:' %m\n", entry->d_name);
> 
> Also %m works with the error in errno and in this case the error is in
> ret, so you'd need to set errno to ret.

Thanks for a tip. I'll write next version of this patch.
> 
> >>
> >>
> >>>
> >>> Graham
> >>>
> > 
