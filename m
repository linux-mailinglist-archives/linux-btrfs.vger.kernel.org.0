Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2FB00FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfIKQJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:09:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36239 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfIKQJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:09:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so25963559qtf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xUpDISX+pSH2M1/bmpki3/wYNaaHU16l4M1yrtYTqU=;
        b=Eu0OYGEokpJPjm/Noi/c47mkPgU8D0nVBHXJ8kR/Ws4PPl3WbAlDglucSYxzjfCP6U
         5V382X4EO52EEbQOXRSlQ/m8gBKYNTpto8CzI+zg7j1CxMel/TH+LWBjmZW55H5J05IW
         za+FpsmakAqNj7ivZ45D01zA+uDDu4EJZrWlFuU7r5rX8OLJT1QAJWbTTWNgum958pqB
         vwwgz4rAn88sEm1/ss4V6Ef3gyARNgr1S0qmi9XNl9eD8A1GBxlHBDl+IwycBvCSRBhb
         SM7pOKf+PfK8RSnhlJHgVQYIEZxqriLxPchiW9icMM2NKFqSy/UgEkd0IKSO9Et93n7f
         ljvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xUpDISX+pSH2M1/bmpki3/wYNaaHU16l4M1yrtYTqU=;
        b=isyTvddETJhmltdZlN5NQfnqFl2/G8vowEDUWXf4COMlvLZXDHLVNqbhAfOgAJL42+
         LikQ0RTZs8wfCs5Xui5bEwKJwskTKqxzHcn36zK1RjNxooSIgwk94wXMJyzrfqN18Yh/
         TIxoqJBMbX6RBnPG2bG4/3WSuluy3gy5ZETn+U0g/ECAFQlMLdNYdXq6+ezEeolj/eCT
         lnHm1tZkPELs46OFW+TjxFVCRehbceTN8zpXpo1ZDxj9CWTaPQDCbjRLsPIGdRTPNBJk
         5q8fRItX0MgsMjU2XKRzUjZY4QEAfFvp0jkVA/xXnzeWsfH7LpCk+ZUN4NLQGM7RmiC5
         TeSw==
X-Gm-Message-State: APjAAAUy+GbZssd/Q6qjpolvKLiCSbCiMM5EILU97tjOm0ZiioENIvb3
        yjtNE24tnSoP/ErVJuaRulrCbQOu1OP87g==
X-Google-Smtp-Source: APXvYqzG9K9e19b/6RKcuVDbUSzywL2Bpumzf/GihvkPfMgO80f7JJUP4c5iAaDAxAg2/vciRVSCvQ==
X-Received: by 2002:ac8:75c1:: with SMTP id z1mr36347893qtq.301.1568218171710;
        Wed, 11 Sep 2019 09:09:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u28sm10008227qkj.52.2019.09.11.09.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:09:31 -0700 (PDT)
Date:   Wed, 11 Sep 2019 12:09:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mark Fasheh <mfasheh@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 2/3] btrfs: move ref finding machinery out of
 build_backref_tree()
Message-ID: <20190911160928.47qzqcj332k7bgw2@MacBook-Pro-91.local>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-3-mfasheh@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171533.618-3-mfasheh@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:15:32AM -0700, Mark Fasheh wrote:
> From: Mark Fasheh <mfasheh@suse.de>
> 
> build_backref_tree() is walking extent refs in what is an otherwise self
> contained chunk of code.  We can shrink the total number of lines in
> build_backref_tree() *and* make it more readable by moving that walk into
> its own subroutine.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---
>  fs/btrfs/backref-cache.c | 110 +++++++++++++++++++++++----------------
>  1 file changed, 65 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
> index d0f6530f23b8..ff0d49ca6e26 100644
> --- a/fs/btrfs/backref-cache.c
> +++ b/fs/btrfs/backref-cache.c
> @@ -336,6 +336,61 @@ int find_inline_backref(struct extent_buffer *leaf, int slot,
>  	return 0;
>  }
>  
> +#define SEARCH_COMPLETE	1
> +#define SEARCH_NEXT	2
> +static int find_next_ref(struct btrfs_root *extent_root, u64 cur_bytenr,
> +			 struct btrfs_path *path, unsigned long *ptr,
> +			 unsigned long *end, struct btrfs_key *key, bool exist)

I'd rather we do an enum here, so it's clear what we're expecting in the code
context.  Thanks,

Josef
