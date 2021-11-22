Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842C2459105
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVPNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 10:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhKVPNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 10:13:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8DC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:10:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so112301pjb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IAiSH9UDTZaaX9UIqcW4Q/Xrwx1iSq0vcfxIg0DMYgo=;
        b=Ji7XbP5iABrUZUbypVtAGUFX8mvB0ZGcoOefIiNeuLiXLGJ/8ZVitOHQchf352voPi
         d3PMu+PtRUc8QRfdliFMrFiqckvvtIegZnKaTKJYqtBBz9lFyCUPnt48qNKSQpjygrgr
         lVfQ6eWiznoqQGkaw+JoiIMS96J82KU7/QhMK29ogXFPhEbwr1AGbE18xNSMWC1Ia/+r
         /z7h0rEKFwE2/0D5TpqZnycFmK6MH139c6LNs/tVCXP1bpORT+MrHiU930JdEEXBqtDe
         giu5XtzKEqO8w8XypPwjGXCAluxiguHwiykBnijYOK2haob5PSi4hJLwkxvmFcNwzwId
         oWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IAiSH9UDTZaaX9UIqcW4Q/Xrwx1iSq0vcfxIg0DMYgo=;
        b=KvMeHiA2i/slVkfRKWsaUy1Owjruy9w2jZPiTgxIt3tB/GxLsQDtAVBB0SuoMSHI8R
         xWLEwHcYfA3GzFAJ8TdB5/nXot+ScfWiAPRLYI87/UoQwpim098dCL/p2dQldVVUYm1+
         lajL/XQkqSeL3IgKssAfxUBBF9EhGAPDLyNlPA6FAiMxrB1BNcrOIQ51xzxnKClUTlo9
         8rsKvcrVunHDeaFgLr7sqzeLIEFQgv1bhgnwlGPbVX9QHceMPLt6jx6TRVjnSLh2EQ7G
         R6ZAHegV1xs+rfCmhdHkyFbkSJuq1r3wih3wywNiUXrtgGmGToFCLTaD/nBzNetQ9/nN
         agCQ==
X-Gm-Message-State: AOAM532gB46yciaL53s+JOYXM4k1l43+OzzJK9uefo4K9dEiiJkggnYK
        NnNMHx1N+ep/2HDydQUtSxM=
X-Google-Smtp-Source: ABdhPJzNMkzX2q4bo2J3wE3/TYbey/TpeSRX6Lk9BUKJSehg/rRYvHkcSzZ+zqsqL669m6LgqsCcOw==
X-Received: by 2002:a17:902:9888:b0:142:8731:4b55 with SMTP id s8-20020a170902988800b0014287314b55mr109240209plp.51.1637593835442;
        Mon, 22 Nov 2021 07:10:35 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 4sm6450543pgj.63.2021.11.22.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:10:35 -0800 (PST)
Date:   Mon, 22 Nov 2021 15:10:27 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211122151027.GA10523@realwakka>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
 <20211122083240.GB8836@realwakka>
 <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
 <a5cd8f64-066e-8791-5de8-a2263d50f597@cobb.uk.net>
 <0a7ce0b1-300c-233b-d844-012dfc771efe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a7ce0b1-300c-233b-d844-012dfc771efe@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 12:57:18PM +0200, Nikolay Borisov wrote:
> 
> 
> On 22.11.21 г. 11:53, Graham Cobb wrote:
> > 
> > On 22/11/2021 09:32, Nikolay Borisov wrote:
> >>
> >>
> >> On 22.11.21 г. 10:32, Sidong Yang wrote:
> >>> On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
> >>>>
> >>>>
> >>>> On 21.11.21 г. 17:15, Sidong Yang wrote:
> >>>>> This patch handles issue #421. Filesystem du command fails and exit
> >>>>> when it access file that has permission denied. But it can continue the
> >>>>> command except the files. This patch recovers ret value when permission
> >>>>> denied.
> >>>>>
> >>>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> >>>>
> >>>>
> >>>> The code itself is fine so :
> >>>>
> >>>>
> >>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> >>>>
> >>>>
> >>>> OTOH when I looked at the code rather than just the patch I can't help
> >>>> but wonder shouldn't we actually structure this the way you initially
> >>>> proposed but also add a debug output along the lines of "skipping
> >>>> file/dir XXXX due to permission denied", otherwise users might not be
> >>>> able to account for some space and they can possibly wonder that
> >>>> something is wrong with btrfs fi du command.
> >>>
> >>> You mean that it would be better that print some debug message than
> >>> skipping silently. I agree. So I would add this code in condition.
> >>>
> >>> fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);
> >>>
> >>> I think it's okay that it prints when ENOTTY occurs. Is this code what
> >>> you meant?
> >>
> >>
> >> I meant to print only if we have EACCESS, but now that I think about it,
> >> printing something when we have a non-fatal error and simply skipping
> >> some dirs/files makes sense. OTOH printing it by default might be too
> >> verbose so perhaps usuing a pr_verbose call would be more appropriate.
> >>
> >> This is one of those things which don't have a clear-cut answers so it's
> >> useful to get as many perspective as possible to arrive at some workable
> >> solution to a wider number of people.
> > 
> > I must admit I just assumed it worked the same way as /bin/du. I have
> > just created an inaccessible directory and got:
> > 
> > $ du -sh ~
> > du: cannot read directory '/home/cobb/permtest': Permission denied
> > 61G	/home/cobb
> > 
> > And when the directory was accessible but the file in it was not, I got:
> > 
> > $ du -sh ~
> > du: cannot access '/home/cobb/permtest/file': Permission denied
> > 61G	/home/cobb
> > 
> > In other words, I think any error should be printed but the error is
> > then skipped and the du continues. No need to tell people the file is
> > being skipped - that is obvious. But the error must be printed by
> > default (if there are really cases where the error should not be printed
> > but reasons not to redirect stderr to /dev/null then add an option to
> > suppress printing it).
> > 
> > Just my opinion.
> 
> 
> That actually works for me, I'd rather btrfs be as consistent as
> possible and not give surprises to users. So just mimicking what an
> omnipresent tool does is as good as it gets :)

Yeah, I understood that any error should be printed but no need to print
that it is skipped. I agree. If so, I think the code that print error
message should like below.

fprintf(stderr, "failed to walk dir/file: %s: %m\n", entry->d_name);

I agreed that btrfs command should be like "du" command that familiar
with users. I wonder if I understood it well.

If so, I think it would be better that use switch-case than if-else.
> 
> 
> > 
> > Graham
> > 
