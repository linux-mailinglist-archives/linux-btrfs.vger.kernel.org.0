Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE6EC858
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfKASQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 14:16:11 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46688 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfKASQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Nov 2019 14:16:11 -0400
Received: by mail-qt1-f177.google.com with SMTP id u22so14006261qtq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2019 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QAcPaL9Hgjgrai2/d8jzljfaWINFNkIwkMchevANo2Q=;
        b=0RodsQ523AjqjTU0Rf6NmwD5/FeOuQ/YluRvSbsY2TZ/+8lgPaC6xZhvP5ViSri1O4
         npG7vDfrHv1MK/zBx4rVC6jmuGE/l5RxMGRJByUNQrzoO95ntb42TRKI0VsJNlrQEfzs
         hAywi92uGG0rc9cCyEu0bqhP1+2q8y0A9giSvQLWsU21Q1CxrB8X4j98t0k/s/E5XQXx
         YRhK1ZB6rOlyu5MyuARsAiJWQG1khuPDv7JqIzh60TV27aB7iY17u86/ldbR5SA4RAme
         DSWEgJVJ5IGUm5oPdUvDpJVK3YxG5a+GGpyJ+NfVjkhiPwXPc0mGRYd+/qFqhRs7Z0kj
         9bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QAcPaL9Hgjgrai2/d8jzljfaWINFNkIwkMchevANo2Q=;
        b=ZSCnZVJLVeXWuuqHE0iFckvgE0diZqtx0ktajJNW9pfoWnGNV0l1wkUaVNChpcYRGM
         hXyl/7xO1yuozm823u1Jhpaf+PzqHuMKvvQCPgosoYxddctW8G7EvsxP8/bEyqiCVLjo
         UvmvBHz75DnRH29iEK9Vy93XOEji5uiksfa0jP8q8lcrycCpOaNblXq5/NQcRBYeX2sy
         v5K49yIXuSR04PWS3EznncGF/LJyCMqltKiVe0kmfzI7nlOH+lpx2ND8boUWpTpTOhLx
         +CyIScn7EcgPTx/1FMqN3SMr5WHpKipjF49cLbn5YEsb2OWeEUi9Wo3nEcJUbJnPPS6f
         16NA==
X-Gm-Message-State: APjAAAXyQTTMpZCUHjTq516OXQ0YJhXnrmbtK/wQTMwFQjX2EGtaal5b
        i6NsOFfcy1TVSMz4wUKMNd9A3Q==
X-Google-Smtp-Source: APXvYqxSMl+eKedvAGOE6AkciRY3OpAd78kDrTMZLqQ6NnyRd0mUKlMs13/meuLNiItp5bRtXHfuSg==
X-Received: by 2002:a0c:c392:: with SMTP id o18mr11217483qvi.75.1572632170028;
        Fri, 01 Nov 2019 11:16:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::f6ba])
        by smtp.gmail.com with ESMTPSA id l186sm3734355qkc.58.2019.11.01.11.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 11:16:09 -0700 (PDT)
Date:   Fri, 1 Nov 2019 14:16:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Meng Xu <mengxu.gatech@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: potential data race on `delayed_rsv->full`
Message-ID: <20191101181606.7dlamcd3x3vf4x2q@macbook-pro-91.dhcp.thefacebook.com>
References: <CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com>
 <20191101154536.GW3001@twin.jikos.cz>
 <c8aaa244-f0f3-0611-0b2d-13a78a57f9bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8aaa244-f0f3-0611-0b2d-13a78a57f9bd@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 01, 2019 at 01:09:30PM -0400, Meng Xu wrote:
> Hi David,
> 
> Thank you for the confirmation and the additional information.
> 
> I feel the same that this race may not lead to serious issues, but would
> rather prefer a confirmation from the developers. Thank you again for your
> time!
> 

Sorry I saw this while I was on vacation, I read through and determined that
there were no cases where this would bite us.  This is just used as a lock free
way to see if we should refill the delayed refs rsv.  Worst case we don't and
the next guy does it, it doesn't affect us in an practical way.

However given our recent fun with inode->i_size it may be worth it to wrap
access to ->full with WRITE_ONCE/READ_ONCE to make sure nothing squirrely
happens in the future.  Thanks,

Josef
