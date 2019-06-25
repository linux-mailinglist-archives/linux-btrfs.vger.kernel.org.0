Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9592054F60
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfFYMyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 08:54:33 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37141 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYMyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 08:54:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id 189so7397300ybh.4
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhMyPfWEbYzbw1d2b75RmfdWDQxz9XqQ2M851qfSKd8=;
        b=CSSDixAc3Y5qtYjjAGEIS0LgXZcUIDQn1F1t4cZYcFRN7Ncehyd9t+mssvT1f9gaVi
         YJqmG0R3c7jhkdDh1LCvunLamzjHBmt0A4RpE8nsU5Ebgfby/DN6MjSsjuwLoBc4mWeg
         7tozASyf39ij92VanwyTUxdLnpfYNwPAyz36G1TWmXbuN4Pd2OLT+jKnJxu8fqfzQAUy
         WoQ6Zv5qAjWVxnTyIt97NxpxnlZliGa9gl2IYsxQuSh46J34qGSRCUhgUQ/wGPifWVXg
         DBYhoLY8Qm1kEgGQq/WRHjA9L0IneuUjjtFlGgfoAywYmrC7T/d3pfZ5CAQW3tZTqpqC
         MAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhMyPfWEbYzbw1d2b75RmfdWDQxz9XqQ2M851qfSKd8=;
        b=ka6EJr9f+o1LKX8ZXK0WMqjtsuNEBxKy5nWukpv2LpBu1EWsSZa02FfzUqWAKuAeOk
         KM+sDM+XA/sKlnP28bP3kqb5U5KWX4Y6+FiTq8tJfLsJ6wYsQr352lutd1MG/ndYUTpm
         8zUDMhYpE6nt9U5yIkHAUVJajG4UnPCALIHA0KVJPcl4S0wgfhewTNuqNANUzLvRFN6S
         bsQ8wXDHearKvMQ/mQdvzyvYLm8UscHr3yhHYz6NKx1Fqot4B4+LCQnALUFWfV+WbvqX
         pfzoIIMtEtX6j4caDjCkZA1Qp5AYc9YV+X0EDTFO4hCZrwfXENX6AxpXmRzAYQo1FoAR
         oWgg==
X-Gm-Message-State: APjAAAXPO0CV7aVUBXlFVTca63h3jl/CZimq5i1V8XUpqajyHY1LhJ58
        hU37c1+mD+vmv2fgQjn/OhgWyV5tUK3aig==
X-Google-Smtp-Source: APXvYqy8lNM6rMUs9MvrYMc06fKRJIjJGgZZg/nKL42YGM4FfNMJFNuvM4hvMGBHzf5PFB4csyTtaw==
X-Received: by 2002:a25:b9cd:: with SMTP id y13mr14148067ybj.15.1561467272412;
        Tue, 25 Jun 2019 05:54:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 73sm1632288ywd.88.2019.06.25.05.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:54:31 -0700 (PDT)
Date:   Tue, 25 Jun 2019 08:54:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/11] btrfs: move the space_info handling code to
 space-info.c
Message-ID: <20190625125429.zuwdgfpt7ddoikhs@MacBook-Pro-91.local>
References: <20190618200926.3352-1-josef@toxicpanda.com>
 <20190618200926.3352-5-josef@toxicpanda.com>
 <20190625115843.GO8917@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625115843.GO8917@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 01:58:43PM +0200, David Sterba wrote:
> On Tue, Jun 18, 2019 at 04:09:19PM -0400, Josef Bacik wrote:
> > --- /dev/null
> > +++ b/fs/btrfs/space-info.c
> > @@ -0,0 +1,177 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2019 Facebook.  All rights reserved.
> > + */
> 
> How does the copyright claim work here? You're just moving code from a
> file (extent-tree.c) that has
> 
>   "Copyright (C) 2007 Oracle.  All rights reserved."
> 
> Adding company copyright to new files that implement something
> completely new seems to be fine and I don't object against adding it,
> though personally I think it's pointless to add the copyrights when
> there's the Signed-off-by mechanism and full and immutable history of
> changes tracked in git and newly the SPDX tag to disperse any confusion
> about licensing of individual files.
> 

Yeah I agree, fix it however you like, the signed-off chain seems to be what's
important.  Thanks,

Josef
