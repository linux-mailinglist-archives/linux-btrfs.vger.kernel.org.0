Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED06FBB89
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjEHXuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEHXux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:50:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F172B6;
        Mon,  8 May 2023 16:50:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643aad3bc41so3977155b3a.0;
        Mon, 08 May 2023 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683589852; x=1686181852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/sVBMIi3LyN+gBOgZbUdsz1PScQ2i7SAG3MJlwaqE8=;
        b=hxv6ke0dkQBYpgjSk/aWazczUaftm+EgIVZvHzmOSnpkhglwDMnxeY7Rhe7k+HbrBA
         ia9wQQBwhXUAHFSj/ZINVGhbaH73oangsio2oGjGFPCQoEFPs9rQVoKabDrc8+S7Wrla
         /0JUh2eLXJj/lQ8Opg1J/BK77lf4mNq7pyMACZbwVnMHmjnz0nvuNvRl84usT3vgTRXm
         TcO88lEHhC2XuAalmsHOG9CZ3avzOHN4LFWxaFTsEhrW1wWF5BR33dOpwzymSbPbJnf+
         fdcBgnWqPOi4LcshCx6AmPFZ3kdr5Q3qPznMI++MP8iTYL4p3RTskcuXpo8m6qtw1F9D
         8MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683589852; x=1686181852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/sVBMIi3LyN+gBOgZbUdsz1PScQ2i7SAG3MJlwaqE8=;
        b=e7FxmHBlEjXMGJoYIw8OGIJ+nDnAaI2j5ql73OIrFzz3e8/n1w/K6qwOX5kDaHswha
         66aouBJuQ0lNWa2CqgdQ8KpOZuQSeYCQfHZFMbzFh3fa9c0VQu80wO5aJHZkWSRoWAZV
         2EQgI+z/xeu4shB54giq/BDuhO/WgnqPM+wE//DsJUkVJUyCsG5W5FlFapg/yw9ZKkgL
         7V27QbhWrodHJ/rgZh6GDDdV2t6oN4YXepkRblM+rjldfov7aAcqVprOyBfhnNJ59N0t
         dI3cALS85HhqNDN8pVHsQ1nnU315FSCzuUpBsUljh3jeYpqJRBPG4lLZQbkPg4IEIw7E
         97eQ==
X-Gm-Message-State: AC+VfDznNBOdDXfEQLXTTnrwhJaMMsUnerIk21Qgg5/WiLXgs/g3Siif
        YdfvThBWjNasDddrXVxxeBY=
X-Google-Smtp-Source: ACHHUZ5/P3WgrHY/BX9CiJGD8C5O1j/iMLzen9wjPbEON3UiMUwkA8YpqK9n9iTIxJ8xx037/EBd5g==
X-Received: by 2002:a05:6a20:1048:b0:ff:1df3:51dd with SMTP id gt8-20020a056a20104800b000ff1df351ddmr13037298pzc.37.1683589852051;
        Mon, 08 May 2023 16:50:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t17-20020a639551000000b00519c3475f21sm46867pgn.46.2023.05.08.16.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:50:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:50:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 16/22] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmK2uV6n8cJ1ec0@slm.duckdns.org>
References: <20230430124006.49D2.409509F4@e16-tech.com>
 <ZFWKHRCDsaNDNXIj@slm.duckdns.org>
 <20230506094013.29A6.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506094013.29A6.409509F4@e16-tech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 06, 2023 at 09:40:14AM +0800, Wang Yugui wrote:
> by test, I noticed some warning caused by
> void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
> 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
> 		return;
> 
> so I tested again  with the flowing fix
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 43c8995..e4b68e9 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -99,8 +99,11 @@ struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
>  		ret->thresh = thresh;
>  	}
>  
> -	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
> -					 name);
> +	if(limit_active == 1)
> +		ret->normal_wq = alloc_ordered_workqueue("btrfs-%s", flags, name);
> +	else
> +		ret->normal_wq = alloc_workqueue("btrfs-%s", flags,
> +					 ret->current_active, name);
>  	if (!ret->normal_wq) {
>  		kfree(ret);
>  		return NULL;
> @@ -139,7 +139,7 @@ static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
>  	long pending;
>  	int need_change = 0;
>  
> -	if (wq->thresh == NO_THRESHOLD)
> +	if (wq->thresh == NO_THRESHOLD || wq->limit_active == 1)
>  		return;
>  
>  	atomic_dec(&wq->pending);
> 
> we need 'limit_active' at 2nd postition, so I used 'limit_active' and 1st
> postition too.

Oh, that most likely means that these workqueues don't need to and shouldn't
be ordered. Will update the patch.

Thanks.

-- 
tejun
