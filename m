Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C82444BCC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 00:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhKCXzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 19:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKCXzq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 19:55:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870DC061714
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Nov 2021 16:53:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so4252121plf.4
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Nov 2021 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y524zfaTNpao9uOc6VFD8PUDOQ9BCZXzmeBSXRUHnWI=;
        b=HK/Gh1v9hTSaOJYAZuSga9RuLSTVZg1RuQoB5S+tfyA/C5eDoLMrEzHGibLWQNnjAF
         qWLlaat5T4BtTsXietTYTL7bpEnAAlCvlN9fT1xgy/bqIS40A2WcmWCVVmPz3dydC6uo
         5/OMrwOvmoPF01RsMKkIS61Rg8GM8beOQ+wWFFa+wfefZBpXwcA3bg73x7nfm97sixHK
         9awdsl+0upl4+H3LEb6yKdGVZ2mR6BCcuWAbq2+wLhP4jl3pvoiroWokwJa4m1yMj9dy
         g4Y3evUgKrJWItnHUdUlzniyBst5ujI6zzsWeUxG6S9TlUKAvhd4RC41qI3HpIBkRE0U
         /8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y524zfaTNpao9uOc6VFD8PUDOQ9BCZXzmeBSXRUHnWI=;
        b=ucJPLoqgyY5UXTYqhbEZhYQOEQp0pZJzGF2FyKSfSNBrZDgpCiW86xWVnH6rwiio4h
         pzt24HznTJX7ii37Cu+j/AiBI1H4nq5M0P2dVW+oWY9w6aOfxihOgJqvmD0hElEO6d0B
         zFpmMnH3F+TQLgbn7IVvwT089RT+ItBQu/qiRvSJrfR39ZzlVcRFjAMHMI+gC9WiHO9F
         ePEzwkYMloxOlJzxyG7+VAMCVltcSCoomuFbN14/H14KHCQs3uwRxA602ym7kqQPxuV6
         It2XNKDcjeNDoUm19MUN/R5JEMOheHNmK2uO14OV80KsXkj7qsdSC1ep6vARtrPxyjeg
         s+2g==
X-Gm-Message-State: AOAM530BMSRbI346sbZSykKi/Xv1FI9k4rZFiBawpISVn8OiFiMZ8Z8H
        /eUWKvvd4ynhVfg+VvFsXHESAneqMHgdjQ==
X-Google-Smtp-Source: ABdhPJzJYb74fIKrIGRTThMpvS50ZrN1stBqfEgxA08XsXAjNEBBZWReBEEO5BWjLqnXb4F5lWyDAg==
X-Received: by 2002:a17:902:c947:b0:142:13f9:3444 with SMTP id i7-20020a170902c94700b0014213f93444mr10988851pla.82.1635983588504;
        Wed, 03 Nov 2021 16:53:08 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k5sm3652989pfc.111.2021.11.03.16.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 16:53:08 -0700 (PDT)
Date:   Wed, 3 Nov 2021 23:52:59 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
Message-ID: <20211103235259.GA47276@realwakka>
References: <20211103151554.46991-1-realwakka@gmail.com>
 <665f8532-e176-3dc6-ccf0-395672cb3383@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <665f8532-e176-3dc6-ccf0-395672cb3383@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 03, 2021 at 05:25:38PM +0200, Nikolay Borisov wrote:
> 
> 
> On 3.11.21 г. 17:15, Sidong Yang wrote:
> > This patch fixes potential bugs in fixup_extent_refs(). If
> > btrfs_start_transaction() fails in some way and returns error ptr, It
> > goes to out logic. But old code checkes whether it is null and it calls
> > commit. This patch solves the problem with change the condition to
> > checks if it is error by IS_ERR().
> > 
> > Issue: #409
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  check/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/check/main.c b/check/main.c
> > index 235a9bab..ca858e07 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
> >  			goto out;
> >  	}
> >  out:
> > -	if (trans) {
> > +	if (!IS_ERR(trans)) {
> 
> Actually I think we want to commit the transaction only if ret is not
> error, otherwise we run the risk of committing partial changes to the fs.

I agree. If ret is error, committing should not be happen. But I 
think it needs to check trans. 

I wonder that if ret is error but trans is okay, trans needs to be
aborted by calling btrfs_abort_transaction()?
> 
> >  		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
> >  
> >  		if (!ret)
> > 
