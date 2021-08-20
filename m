Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA23F241B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhHTAdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 20:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 20:33:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B69C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 17:33:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so7514312pgh.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Aug 2021 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1TQsRdx52d/De/ifR58duzZrTab4BDEmp+t/w2WHlTA=;
        b=sV6iCCAfRSs5GNUSCr2e8HOjYWLc8+qBQ+RXZ8U5xszFGnEu06O0ehmiHJpv45Thx7
         7fAXFRz7r4QsR5A2lbzDIQQmmcBbtgMQ2SNjIFmI2wp4NxKL0eHXot3j242x4KiX98X7
         PDf8IW5RB8lNVEavFrEns1ZXD7SvdJlakfFyEDrX7iTq3/M32t0aTx6e+uVR1lvs8U94
         fOvsWDlR6rSAboCNfoRibCzD9zatNHmCjRjIyVYRXjb8X0l8z2HT+gTdFAQjizIJe7MK
         xCBA2TNlVEzX2gh8k+tZp74FI9Ch/72ISik0jpcvNf5vq082WN0ZVIyKtfaficAEHpl9
         rTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1TQsRdx52d/De/ifR58duzZrTab4BDEmp+t/w2WHlTA=;
        b=fkAqsBmuWfMOtLSUCUWk0xkP/bUv0xJnCSo7BO9irFb937bezBD+ag3sfw39q0Cbad
         D2smDnfyzyiKB7wRj4LAjOhpLRAcfCZ+9OpgsxZ5tvxvwFue684+7hlCGjukCpygB44R
         zWbxEoOIv+sdJdLEym5IiUXookz5uaEu8+k2mphRZhNhT/JVQuLM5CqsA/WBvs/Ivaex
         aWKogyvUMJeuzZN+ZRZG1NKbOoaBvAI4x8RLNcb0yhXt9QUZdmEKAwI9UAyC8bvouVHP
         0KkuLopryi4CXfa7/P+YeP1ASw51d3f7ISQJpcJP5lFcC9zNkjFV9kI/bAApuyfChyML
         dbFg==
X-Gm-Message-State: AOAM532ldjpbWQVZSNL4JSOAP9m2KZMDEkKryRB8ESQxayMi0fPikvCX
        69LkjiGaf8zt2jomXayBkv0=
X-Google-Smtp-Source: ABdhPJyTjE3+zuVbBo0LsswxeA/oiU5H4fBig3RNpnswO+nWKIzwbyJ2P4Xv8SEA7OcQff9U67jtGg==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr17333562pfl.51.1629419585599;
        Thu, 19 Aug 2021 17:33:05 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id j12sm4620045pfj.54.2021.08.19.17.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:33:05 -0700 (PDT)
Date:   Fri, 20 Aug 2021 00:32:57 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Message-ID: <20210820003257.GA17604@realwakka>
References: <20210818160815.1820-1-realwakka@gmail.com>
 <e6423897-3886-73b1-42dc-5e24ca792682@suse.com>
 <20210819153216.GD1987@realwakka>
 <20210819181249.GJ5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819181249.GJ5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 08:12:49PM +0200, David Sterba wrote:
> On Thu, Aug 19, 2021 at 03:32:16PM +0000, Sidong Yang wrote:
> > On Thu, Aug 19, 2021 at 11:04:58AM +0300, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 18.08.21 г. 19:08, Sidong Yang wrote:
> > > > btrfs_extent_same() cannot be called with zero length. Because when
> > > > length is zero, it would be filtered by condition in
> > > > btrfs_remap_file_range(). But if this function is used in other case in
> > > > future, it can make ret as uninitialized.
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > 
> > > This is not sufficient, with the assert compiled out the error would
> > > still be in place. It seem that it is sufficient to initialize ret to
> > > some non-arbitrary value i.e -EINVAL ?
> > 
> > I agree. It's better way to assign intial value than adding assert. If
> > there is code that initialize ret, It seems that assert is no need for
> > this.
> 
> Patch with assert removed, please send the one initializing the return
> value, thanks.

Sure, I'll write it in v2.

Thanks,
Sidong
