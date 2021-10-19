Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB3433D9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhJSRks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSRkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 13:40:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35156C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:38:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 21so14158142plo.13
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lG0MsRECnRnMLUTwVHWG2flH2FoYByHn8uBAS5dFsgw=;
        b=w1f+iRc6FnmVnp62fq0dsnFTAGYvvRL2keRUrZHFFwJVkG7uiYALveiAZloH2zN+rl
         WCj/klPihdw3m6Se15AUsf3/kqbvMtbhUVY38u1XkTyK1vP9Nv122pFwaDfiFm3LRZRA
         E27OoftrCuWRNd8Na/9sgXswpiYFu9mqbdbfWXkbITgTBpKKHdW5THUVdTjmHqPiZRjU
         In5ZDLqP1tPp2ZEwWhLn/ynFZp0Z62XXnVnumOaNu2Y5kC0ckkT39FlyrUGi8NnMinal
         968IU3GBNT8yk+3BnJf1OYqirZtAT8OSih1AEffw46XIk0vJCyWdEs0UMSiA5N/RjhbA
         Ne1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lG0MsRECnRnMLUTwVHWG2flH2FoYByHn8uBAS5dFsgw=;
        b=CkTr1SYkJzdg4McEyk3IIXvZNU8uuJNmAB7fclvhmioINMK5zjNoi+g7BE84qx7sv4
         bU6W6JYK2iMym0+A79h/EcDbeUwkY4insL56Eul3j9MyAAs077Z64eeeQgxGC1DhyLkZ
         DmGVJWAldzwdLXW9KaDabFMKDiY2s2rOsmvIelyEBywHFiRWuo2gl8Y57/YV5V+LO9+U
         dztvEArjegQSXHR1Xxy4WniNtHm1LLaBc55l2BsNqWzmpqt/XZBDt+boACQnQuWmxwCQ
         HsJy3xj5r/zPCEptDfCFQUu3jS68/njxR/QBm5WTWkuiyPeS8rBIhB9xk2MGCaFdrBPr
         5lPA==
X-Gm-Message-State: AOAM533MN4Ikr3jKQMly7zvZE/hd0XxlzdvWwQJeggdU9ST5T8EdMPAS
        FNcuRlJqBLbrCHCKd934dPRuLw==
X-Google-Smtp-Source: ABdhPJzBQ4bP4dBCsyWaQa7pMQ9czR4+5YCNBzLQZhB3Q74LFYAJwUcHrTrVHk63hL3rZZDi+pRYvA==
X-Received: by 2002:a17:90a:17e1:: with SMTP id q88mr1267173pja.99.1634665111097;
        Tue, 19 Oct 2021 10:38:31 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id i12sm16280441pgd.56.2021.10.19.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:38:30 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:38:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
Message-ID: <YW8Ck9pk6JGvq8V1@relinquished.localdomain>
References: <20211018144109.18442-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018144109.18442-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 04:41:09PM +0200, David Sterba wrote:
> This is send protocol update to version 2 with example new commands.
> 
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support. In order to have something to test,
> there's an extended and a new command, that should be otherwise harmless
> and nobody should depend on it. This should be enough to validate the
> non-protocol changes and backward compatibility before we do the big
> protocol update.
> 
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
> 
> Protocol changes:
> 
> - new command BTRFS_SEND_C_UTIMES2
> - appends OTIME after the output of BTRFS_SEND_C_UTIMES
> - this is an example how to extend an existing command based on protocol
>   version
> 
> - new command BTRFS_SEND_C_OTIME
> - path BTRFS_SEND_A_PATH
> - timespec attribute BTRFS_SEND_A_OTIME
> - it's a separate command so it does not bloat any UTIMES2 commands,
>   and is emitted only after inode creation (file, dir, special files).

Why do we need new commands for otime? I think it would make the most
sense to include the BTRFS_SEND_A_OTIME attribute with an existing
command: either the BTRFS_SEND_C_MK{DIR,FILE,NOD,FIFO,SOCK} command, or
the first BTRFS_SEND_C_UTIME command after creation. We might as well
take advantage of the TLV protocol, which allows us to add or remove
attributes for commands as needed.
