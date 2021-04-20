Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76DD365A58
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhDTNj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhDTNj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 09:39:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C4C06174A;
        Tue, 20 Apr 2021 06:39:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j5so36689918wrn.4;
        Tue, 20 Apr 2021 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cz/GOpaJvoOGO7WnzoMrMyjou+pDiBvr8VXW+xJYUMQ=;
        b=mjpOW1aupBAvxnwb3M+g0xZ0S7X3rHPTCLpZYQ06tU4qDYyr4hnCxjdz/lGWmRUGrI
         1Mx3OmIosZti9cq5AUDrXQWcyyXzF6XD/4paZ6IvUDspMmuN0SoVr7/aTxuLT7HRL0fX
         SBtInp6BzbRERCBzzSrr1mujnACI1op9RvjOtUN+3b+WfN7DS+l3/F+tJxxhsoUPl6JE
         AqnMIj44/rqmxFhbV9dbUPqXK+irNLh1cndo1acVFwTMhzqumIlPbVDAMlMApTOU57rX
         d+geiGMxZJZwdxy+Czdt8iZvhX3uwp2/r+juuGUSPuQ668g27tz27crtTSW8fYMUkjgI
         TVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cz/GOpaJvoOGO7WnzoMrMyjou+pDiBvr8VXW+xJYUMQ=;
        b=c1WeYj85hHMI0YgLurBEPyekq8qK+O0Dfgv6I2ya4+fBUl94+oeY0wzA5I/kxoHZ1k
         ooAozXxX/oKGG36T1ptMvYSKOLjsPAUGFoj1JdIep1ycdEQ1W82fMIdLrrTrw3clMc59
         FjZI/BHAE8s6B9axeAF23Q8ENEg844nawIR1r2k5S7ii8V6lAK8n1mpNSqR/tSxoSSfm
         xZVEpOqp0N6XTM4GOcv6TrcAAZgnC7SpOxgYTpqi5DbTghZ0aMNbr4JKkyYibIdwhCke
         0Bg9O3Bsas2d8Vo+2FlBGj/5QFpXAEEnSe09u98uCjYagv5R9nXzLamxj78GbFkoG06v
         j2tg==
X-Gm-Message-State: AOAM533LVBAkTeTTFZM5FuWnvbiZ30uO69qGOND+83xaZfPKHKb8IpKa
        RN1K2E56dDjt6KwtgJ36erY=
X-Google-Smtp-Source: ABdhPJwCf1u+I/VEWDIP4hJT5ELIXuKYNI34lNH1EbOD+2IFzQuYgCvtzNwH3YdS/1HRpkTGLc6tjg==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr15334857wrj.90.1618925964849;
        Tue, 20 Apr 2021 06:39:24 -0700 (PDT)
Received: from ard0534 ([197.240.34.190])
        by smtp.gmail.com with ESMTPSA id q5sm3523570wmj.20.2021.04.20.06.39.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Apr 2021 06:39:24 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:39:21 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, khaledromdhani216@gmail.com
Subject: Re: [PATCH v2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210420133921.GB3433@ard0534>
References: <20210417153616.25056-1-khaledromdhani216@gmail.com>
 <20210420102214.GA1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420102214.GA1981@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 01:22:14PM +0300, Dan Carpenter wrote:
> On Sat, Apr 17, 2021 at 04:36:16PM +0100, Khaled ROMDHANI wrote:
> > As reported by the Coverity static analysis.
> > The variable zone is not initialized which
> > may causes a failed assertion.
> > 
> > Addresses-Coverity: ("Uninitialized variables")
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> > v2: add a default case as proposed by David Sterba
> > ---
> >  fs/btrfs/zoned.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index eeb3ebe11d7a..82527308d165 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >  	case 0: zone = 0; break;
> >  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> >  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> 
> It took me a while to spot these break statements.
> 
> > +	default:
> > +		zone = 0;
> > +	break;
> 
> This break needs to be indented one more tab.
> 
> >  	}
> >  
> >  	ASSERT(zone <= U32_MAX);
> 
> regards,
> dan carpenter

Sorry, but I checked the patch using checkpatch.pl
before sending it. Is that blocks some smatch parsing process?

In any cases, I will send a V3.

Thanks.
