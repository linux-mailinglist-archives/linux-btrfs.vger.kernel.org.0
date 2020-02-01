Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C3E14F70E
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 08:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgBAHm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 02:42:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36854 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgBAHmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 02:42:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so3731372plm.3;
        Fri, 31 Jan 2020 23:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hr65DEj41DWnlCV9ROP2Bxj/cpyFuFVXSbpK/JoP5Ks=;
        b=scFICfIeqsznNWlYojrYxlFdmr9NAVt0jyrv1AV8GR0AgPZEL+YTU9+uty/h6l63bc
         BG2vCiwbEDJTLfRjcz8jYb/6KwXmWlMmF9VEU66yWG29dw77ZIgKcsGeVnbHSljngqEz
         fnrVc00HX2JfNyrhCzPctS/RlI+DVuZ29ZUR66w84f9pS6JEDa7pVv/Ru0EQNNvdLNrf
         rw2sUgsL6rTHMb1kXexAq/G1RWFdWQ7jIvxTDkv6E+V0Ewuo4OJe1FaW8R9zgHxJrrmE
         f7TGLyP8kzS1UCs/6t3itjvdtttYVmMWawXVzPLe4z1MNaBKcH21Oujh6Ojjmx6Tv6g6
         P2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hr65DEj41DWnlCV9ROP2Bxj/cpyFuFVXSbpK/JoP5Ks=;
        b=QjQyQdTOR+EsI06REooVzrjev0n37Bm98aUyuwtCAyWfeONgo40MtKPzSMdkDS9YN8
         NdGouvJK9ZqSuUn/bADDuwqmIiwZc0l2dkwlwrOrcAgGdP4S1BTJ5Nh/cemruPL7IySz
         VB7jQLmkD7YWE16HxNpsUj/MqFiug9JOZaeYa6G12n5qNSR6STSPg0sdfw4/xTlmCf/X
         ZkqsHhhl/Dz/5XtC266vCPnbkrVloEp0kpM5NKHlda4rQ6voiB0iEhoziWSsnRvT8bpZ
         ViRjbqKqM/819MB0SebfClCVj+RSG2KqGL1f5cIbL7ZLiQs6lGhw7BFkuoi+FWkyeg3U
         ffjA==
X-Gm-Message-State: APjAAAU5hqr7pxyMBDfJwFKLJMT+xhz74krA2MHzQN+39nAr1rEr+sLX
        QykQl/uugwBkaQUBU9F8VuM=
X-Google-Smtp-Source: APXvYqx8xpIOB0embT3dZ38ae4xiNLBPWM5XlX72ZWy115sMK1imQv7M5gtuz+/jWC7K0ulCVAdEAA==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr16785893pju.66.1580542945173;
        Fri, 31 Jan 2020 23:42:25 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id n2sm12450287pgn.71.2020.01.31.23.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 23:42:23 -0800 (PST)
Date:   Sat, 1 Feb 2020 15:42:18 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] ltp/fsx: do size check after closeopen operation
Message-ID: <20200201074218.GB2697@desktop>
References: <20200107165542.70108-1-josef@toxicpanda.com>
 <20200107165542.70108-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107165542.70108-2-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 11:55:40AM -0500, Josef Bacik wrote:
> I was running down a i_size problem and was missing the failure until
> the next iteration of fsx operations because we do the file size check
> _after_ the closeopen operation.  Move it after the closeopen operation

I think you mean "_before_" here? And that's why we move it _after_
closeopen?

Thanks,
Eryu

> so we can catch problems where the file gets messed up on disk.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  ltp/fsx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 00001117..c74b13c2 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2211,10 +2211,10 @@ have_op:
>  		check_contents();
>  
>  out:
> -	if (sizechecks && testcalls > simulatedopcount)
> -		check_size();
>  	if (closeopen)
>  		docloseopen();
> +	if (sizechecks && testcalls > simulatedopcount)
> +		check_size();
>  	return 1;
>  }
>  
> -- 
> 2.23.0
> 
