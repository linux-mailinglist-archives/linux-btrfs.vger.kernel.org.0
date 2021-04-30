Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1772936FBD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhD3OCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3OCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 10:02:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1191C06174A;
        Fri, 30 Apr 2021 07:01:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q9so16564247wrs.6;
        Fri, 30 Apr 2021 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vc51MIOvLctgKvPzN3X1mUUyH1WiwVtt6VoY2lKmIg=;
        b=VbA61w2htAGnFT9KN73WgAFCB0NLUfzr7aBiY3RofMEiKmASSUrz05sMXrgGDJFq8L
         OuS1EmiR71yp2X68S/udpJIND6QFEVC32oxVQLMh9x+IAQmCKqitTCY+zX5yKLNOeN8/
         STJ7IvvIRMdIbV7Bo9q6Uxc4YEF4NfSfwBd05pfini65Q3lb7Pt0tcNMfWbGRykh2cJ0
         XnmNog+iMSOjAT4Bw7i1yqfHyk4ZQg+rYaV6uhcSlNlyW/W4mvhRWNwEBj4cRD7nlkzk
         xElItMyaRz8/ncdZemYyjG0zhGswcQcdLYzGmIQxTaSGi3XV53cLyW4BNtGEGmNGmal6
         F6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vc51MIOvLctgKvPzN3X1mUUyH1WiwVtt6VoY2lKmIg=;
        b=A3xgVFUSacnkhaDeTbs/1Yf5o6jpMVfeLX7aoR1vKveU1MSPqZM6/rATi1V3biMJ44
         fDSjWU5iEHh/T/tYTkRK35ndnEMZN+yFST+P/NgeNqcmh9zypXc0++Fl0YfHByzpGaBX
         2VhLCOaNZJiYajd0ZZqbQWj0WQwugqJIBNcuJj4JiyEqO1iSA2PQtHh3YYr7vrcrvbtB
         u7zCGPIGtMFFBecYnwPzDxOOlTs8NBcbX7TNxRQe+wVRN7HQEC4BJn+2fL4Y0jJL+S9t
         cX/p6XEh7YxwQSRJNEOpSkJfc2f5nx/aZIDOCZaPb2i5AAmET/tpmN3zYrqCVq1fR5fy
         v0+g==
X-Gm-Message-State: AOAM531/1+FbhNybFSMjAmO1NdEDo2Um+g8N5lkVZCIMglXqpELFBP1B
        vwxKXNRa52cTO7I9yPfdafs=
X-Google-Smtp-Source: ABdhPJxBiL3VYmy7rnfOH+YPTPdCtgKm4MhTLXKy6bRxkgdetksAYcS3sMJPFtiBvKwjsq4htmddPA==
X-Received: by 2002:adf:fd0b:: with SMTP id e11mr7067713wrr.402.1619791292411;
        Fri, 30 Apr 2021 07:01:32 -0700 (PDT)
Received: from ard0534 ([41.62.193.191])
        by smtp.gmail.com with ESMTPSA id j13sm2318262wrw.93.2021.04.30.07.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Apr 2021 07:01:31 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:01:28 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-V2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210430140128.GA2565@ard0534>
References: <20210427171627.32356-1-khaledromdhani216@gmail.com>
 <20210429141200.GB1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429141200.GB1981@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 05:12:00PM +0300, Dan Carpenter wrote:
> On Tue, Apr 27, 2021 at 06:16:27PM +0100, Khaled ROMDHANI wrote:
> > The variable 'zone' is uninitialized which
> > introduce some build warning.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> > v2: catch the init as an assertion
> > ---
> >  fs/btrfs/zoned.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 432509f4b3ac..70c0b1b2ff04 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -144,7 +144,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
> >  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
> >  	default:
> > -		ASSERT(zone);
> > +		ASSERT(zone = 0);
> 
> I'm sorry but this doesn't make any kind of sense.
> 
> >  		break;
> >  	}
> 
> regards,
> dan carpenter
>

The idea behind this is to force the assertion failure 
in default when no valid 'mirror' value was entered.
But as all caller pass valid mirror values, this case 
will not happen. So, I just fix the warning of the uninitialized 
variable 'zone' as reported by the kernel test robot. 
Thus I guarantee the failure when 'mirror' was invalid.

If I am wrong, please clarify.

Thanks.
