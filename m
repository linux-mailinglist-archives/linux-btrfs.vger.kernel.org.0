Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52008445469
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhKDOCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhKDOCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 10:02:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F16C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 06:59:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 75so5493694pga.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=98MyJo9mg4QqHjmZeMr+eLaMKTNdCutofSjC5WZQ2XA=;
        b=Qiajfo1pJPZKAI4nAIkHTVyXxghK/pxLG2wxq46nhHfAFTs17U/EozEKJIij9Vxlfl
         EYLtUpnjj8N7hKPuUjFIvAXZrPdDnV4EwD+bR5UU56aw/8QhzdtuttIr8BAf/j0kaCPb
         oa+svjlekKFP3naKqjTUddWUiHjlDja9PBeV0FeLA7iMWGKiLztZYTB0x4QEihzDEJss
         kdIbOC7R5cUN+y9bD9bkbY2f7k+9qh4pX2dZZR3NU4QOYSDee4Tk14IFRcXpLmPU7B/w
         DUVn4NoL/vsFgjQ8zNEkJ9T3wQgVgIxY0Fr4GXA8agkBzSndGhjyMdG2bUrMTvqDO1px
         v5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=98MyJo9mg4QqHjmZeMr+eLaMKTNdCutofSjC5WZQ2XA=;
        b=RV0B30PoO31Z30lO6AXvodw9v0qQIiQSUoZlUgz2txwWphFZSw47SxTzPL6eAdWTB+
         DHqInlDkbreKBRBEKLweksu8XXl4UeCbuMX6MSmkw1XCdWtRRYCvyJIMv74xf+ldNXav
         BX2SSp32HlQ1UQFHcZ8Z/YwlcZrfPdtB5+qmXZnEfKOaTW9wFZBNQbWIi93A8OjQoi53
         AVGgGzmrFT94c4e8aND7ctjdUoYvftgkxP6PiwTyfyVyS/C9blApIn+YrkCr7rU5zSwF
         TOrz4ObRyeZhzisRFDVMttXVnIJmG6HPAlhm9RKc/1MoMJ1mubVYumqN1LyDOFpScwkv
         LX/A==
X-Gm-Message-State: AOAM5306blRE+3pnvLlxcx9IZd3CDHSgAAjEm5efLPmKDR5uE3/FGF3+
        ILRvovt21hwFGzRzvSd7HIo=
X-Google-Smtp-Source: ABdhPJxhmlfdW3wKvukC86y/iVFL5pKEcuRPIkxKkzDubSt56+5eNyzm8PAMWvqanVemRhhUooydKQ==
X-Received: by 2002:a05:6a00:248c:b0:494:73de:45a7 with SMTP id c12-20020a056a00248c00b0049473de45a7mr279352pfv.50.1636034379830;
        Thu, 04 Nov 2021 06:59:39 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id v22sm5091634pff.93.2021.11.04.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:59:39 -0700 (PDT)
Date:   Thu, 4 Nov 2021 13:59:35 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
Message-ID: <20211104135935.GB47276@realwakka>
References: <20211103151554.46991-1-realwakka@gmail.com>
 <665f8532-e176-3dc6-ccf0-395672cb3383@suse.com>
 <20211103235259.GA47276@realwakka>
 <dd777050-db1e-d6f0-d41b-2b1f7226cb20@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd777050-db1e-d6f0-d41b-2b1f7226cb20@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 09:50:33AM +0200, Nikolay Borisov wrote:
> 
> 
> On 4.11.21 г. 1:52, Sidong Yang wrote:
> > On Wed, Nov 03, 2021 at 05:25:38PM +0200, Nikolay Borisov wrote:
> >>
> >>
> >> On 3.11.21 г. 17:15, Sidong Yang wrote:
> >>> This patch fixes potential bugs in fixup_extent_refs(). If
> >>> btrfs_start_transaction() fails in some way and returns error ptr, It
> >>> goes to out logic. But old code checkes whether it is null and it calls
> >>> commit. This patch solves the problem with change the condition to
> >>> checks if it is error by IS_ERR().
> >>>
> >>> Issue: #409
> >>>
> >>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> >>> ---
> >>>  check/main.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/check/main.c b/check/main.c
> >>> index 235a9bab..ca858e07 100644
> >>> --- a/check/main.c
> >>> +++ b/check/main.c
> >>> @@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
> >>>  			goto out;
> >>>  	}
> >>>  out:
> >>> -	if (trans) {
> >>> +	if (!IS_ERR(trans)) {
> >>
> >> Actually I think we want to commit the transaction only if ret is not
> >> error, otherwise we run the risk of committing partial changes to the fs.
> > 
> > I agree. If ret is error, committing should not be happen. But I 
> > think it needs to check trans. 
> > 
> > I wonder that if ret is error but trans is okay, trans needs to be
> > aborted by calling btrfs_abort_transaction()?
> 
> This is the general way errors are handled in kernel. Currently abort
> trans in progs simply sets transaction_aborted = error and
> commit_transaction checks if this is set and returns an EROFS. Every
> failure site in this function should ideally have a
> btrfs_abort_transaction, because in the future we probably want to add
> code which would yield the exact call site where a transaction abort
> occurred.

Okay, Thanks for detailed description. I understood that we don't need
to call btrfs_abort_transaction() in the function.
I would write new version for this patch.

Thanks again for helping me.

Thanks,
Sidong

> 
> 
> 
> >>
> >>>  		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
> >>>  
> >>>  		if (!ret)
> >>>
> > 
