Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09ED8099
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfJOT6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 15:58:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35368 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfJOT6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 15:58:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so20437432qkf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 12:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCv1UOzLSTu1HT4q9SEF+bfJfB07l1mNDubm8NtQsKs=;
        b=nwcrBNLBtc5VWflzv+jYg9lsjFMHE8RcoEbJMooUJRMK5HCmYWrSlIab0c82SzdJAT
         fRVQpUXqqBo3oNmknK1DWXwl0SJTkkHbeoWpd7MY3D/3YsRCk7NJPkI1s0Px9Lwk0S2H
         HL4NJ/bGk62pQww8dr0cHRPbsJuJbNh38aZbDAdvHoKodPN1ahP+vWwkv4BrzIvqlPZc
         euUAy/EQWaQRNDyPc9LCkMfK7TT83JbnkP/ZmsXPP6LMxGsM6JOWs8bVmeRCk6VEX079
         NMkaXNPrWUWLx5qex1KbcNYtBdRJvN9VJKAABgpakUdY9q6DTUNS1UszvL/m8g+uiAyJ
         ocMQ==
X-Gm-Message-State: APjAAAVa+kJaqycjiMfDWNGVfWMPNFyJLJEtBhCImgVCAgAy8Yh6sp5s
        fHkDkEnla1LQ4JGVapFyFZ4=
X-Google-Smtp-Source: APXvYqyaT6kj+9MQop1olFJy1itlYZmn9r5ARPB706jHDFzEa2tkPmBE0A00WtXOYg0OVtvM/uA38w==
X-Received: by 2002:a05:620a:13d9:: with SMTP id g25mr37353903qkl.230.1571169522468;
        Tue, 15 Oct 2019 12:58:42 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::c97c])
        by smtp.gmail.com with ESMTPSA id t17sm15398178qtt.57.2019.10.15.12.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:58:41 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:58:40 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191015195840.GD82683@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
 <20191015121755.GU2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015121755.GU2751@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 02:17:55PM +0200, David Sterba wrote:
> On Mon, Oct 07, 2019 at 04:17:34PM -0400, Dennis Zhou wrote:
> > @@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> >  	bool merged = false;
> >  	u64 offset = info->offset;
> >  	u64 bytes = info->bytes;
> > +	bool is_trimmed = btrfs_free_space_trimmed(info);
> 
> Please add a const in such cases. I've been doing that in other patches
> but as more iterations are expected, let's have it there from the
> beginning.
> 

Done.

> > --- a/fs/btrfs/free-space-cache.h
> > +++ b/fs/btrfs/free-space-cache.h
> > @@ -6,6 +6,8 @@
> >  #ifndef BTRFS_FREE_SPACE_CACHE_H
> >  #define BTRFS_FREE_SPACE_CACHE_H
> >  
> > +#define BTRFS_FSC_TRIMMED		(1UL << 0)
> 
> Please add a comment

I've switched this to an enum and added a comment above it.

Thanks,
Dennis
