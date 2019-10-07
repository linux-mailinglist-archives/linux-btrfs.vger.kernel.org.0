Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9868CEF08
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 00:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJGWYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 18:24:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35213 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 18:24:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so14348307qkf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 15:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NZEO2b8BrA6lXxvfMQJhBVlTdC44DtGr2OIDvzHVGWM=;
        b=eken7uw1ajfD5CGkQA2erphLMIz6qSEJPM9JH7rUbQi5ZvyRx4tZPcwBVGTUdleBZx
         1SsbbU+1mQwQHu/q0tR5qQJ/wb2TqLgQz3iUVzYjrOpoO5jI29iVq2TKXKNoW8BA2IdB
         WVKQTV8zSMt9//fzpmJoBnCSM3ZdvYKhSQUF24+pUUAeACJMBh9SEPpuy2QJAlTWfInC
         3hcG9V/erWp+pBZQ7hP/haBszr2I5mzkWfGdx7B5pP9ukVewbMEtbV0xkHtc/UXZZty9
         wgIRF6uzQnuQ/ML8iv1HciXfxnZe3isX0nEIit7B2zwYz/rxUu7zWax2fIYWaYfL4ve3
         zTgA==
X-Gm-Message-State: APjAAAW+Hfuttsus+6UgU/ctw/PNPLuB7fnwdfs1mp/yVW9NYqC+vsfZ
        pnYMDHMnAee03MPvSayEkac=
X-Google-Smtp-Source: APXvYqw1VpzYzBRq1bDxbea/f5xVJbKxztmDNTaxrSOqngx0gBlGl2PmakftKRp/L7bf54PjGKe4lg==
X-Received: by 2002:a37:9dcf:: with SMTP id g198mr25904776qke.269.1570487062788;
        Mon, 07 Oct 2019 15:24:22 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::d9e1])
        by smtp.gmail.com with ESMTPSA id 54sm11714339qts.75.2019.10.07.15.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 15:24:21 -0700 (PDT)
Date:   Mon, 7 Oct 2019 18:24:19 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/19] bitmap: genericize percpu bitmap region iterators
Message-ID: <20191007222419.GA26876@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <d2efb06e5e5400007a709bb1269b25e16b435169.1570479299.git.dennis@kernel.org>
 <20191007202612.mer74bok5ymyxae6@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007202612.mer74bok5ymyxae6@MacBook-Pro-91.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:26:13PM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:32PM -0400, Dennis Zhou wrote:
> > Bitmaps are fairly popular for their space efficiency, but we don't have
> > generic iterators available. Make percpu's bitmap region iterators
> > available to everyone.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  include/linux/bitmap.h | 35 ++++++++++++++++++++++++
> >  mm/percpu.c            | 61 +++++++++++-------------------------------
> >  2 files changed, 51 insertions(+), 45 deletions(-)
> > 
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 90528f12bdfa..9b0664f36808 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -437,6 +437,41 @@ static inline int bitmap_parse(const char *buf, unsigned int buflen,
> >  	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
> >  }
> >  
> > +static inline void bitmap_next_clear_region(unsigned long *bitmap,
> > +					    unsigned int *rs, unsigned int *re,
> > +					    unsigned int end)
> > +{
> > +	*rs = find_next_zero_bit(bitmap, end, *rs);
> > +	*re = find_next_bit(bitmap, end, *rs + 1);
> > +}
> > +
> > +static inline void bitmap_next_set_region(unsigned long *bitmap,
> > +					  unsigned int *rs, unsigned int *re,
> > +					  unsigned int end)
> > +{
> > +	*rs = find_next_bit(bitmap, end, *rs);
> > +	*re = find_next_zero_bit(bitmap, end, *rs + 1);
> > +}
> > +
> > +/*
> > + * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
> 
> Gonna be that guy here, should be '[@start, @end]'
> 

I disagree here. I'm pretty happy with [@start, @end). If btrfs wants to
carry their own iterators I'm happy to copy and paste them, but as far
as percpu goes I like [@start, @end).

> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 

Thanks,
Dennis
