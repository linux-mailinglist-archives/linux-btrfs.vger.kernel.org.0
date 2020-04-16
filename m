Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDC1ACE3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgDPRCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730264AbgDPRCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 13:02:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493FC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 10:02:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so1568560plo.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jM5h1KFj1L2GXPRZjBV7ijyxLB4BFuJ/vu3Z2ACwOH0=;
        b=upWStF2+6JIY7WIbqEKUk+gI5CQolvn8tp2lCpTiFpSeX1L+TPFq7VBfGYfr/PXbms
         /SQYrkACqUfYns0cjwtSFepEft+7s8M4jbd0T/kRWAttVqMMZTeiu2tsEPGtfm+wDcbH
         LbBB4elRVgQ8QIp3a3juih4HZQ+slHWHTNXyacHtbxZx8ciSGDx0ImYltQj3C8m0wGAk
         IpPgkdpA5pUJy09YKtzkSFGj6V9YDm6TI096DZ6AyzdOdR2+BJVpIEuyTXXkA8uTk71S
         NYQFj1eoQqvqBlNu8qs9Kk1wCFxX2DyP/0Tt7MbdSHeRwkmx5COOYiT17fRc+2QOGpFV
         qNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jM5h1KFj1L2GXPRZjBV7ijyxLB4BFuJ/vu3Z2ACwOH0=;
        b=aOi2F9R16B2/9MCDYhDlVyyFFNorCtZZ2RZauxjiFI2XOxnAKhUMYjw7DcyYNdMaDj
         Lh+655KfDVBWPoUHa7Up+RbWcKqWIIdhiczkz22mwbyDb4xvTqZuFrs2OzuyuRjLH+lp
         TZdZAWpzhlCcqz2R3h9245kNRrY4kPSP2AuqPPVc3wxXUD8NcXEAteGRa1ZZU7ECeHeV
         Az0HCUrDPyeYAuVdCK5PWQN3domnpqHqG3Ap/lJGCxBFJnan8cEqeqZivs8EzRU1AFiy
         NeFbzvCQh+0j7A3iBTyd0GkleCntiQub58Wqo3QWnTO6OKCnIe9G1Evup2CP+zXqT9yF
         PU2Q==
X-Gm-Message-State: AGi0PuZDHhHB6g2vjvrW8eqos2Q5QKeWOdyH+SMk92+iWB/IbIgFQa2/
        DiX7XLuGinFvO5pSGsY+M5swdA==
X-Google-Smtp-Source: APiQypJqg0pOISaJvxNLbk+rEYy/BAV/B+cdSZie5ezyzvBXT70vsoZhCw53vIeIUdY5Sj/wNtfkhA==
X-Received: by 2002:a17:90a:af8c:: with SMTP id w12mr6153045pjq.37.1587056525879;
        Thu, 16 Apr 2020 10:02:05 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::7584])
        by smtp.gmail.com with ESMTPSA id y186sm4958753pfy.208.2020.04.16.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:02:05 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:02:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux btrfs Developers List <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v4] Document encoded I/O
Message-ID: <20200416170203.GA696015@vader>
References: <cover.1582930832.git.osandov@fb.com>
 <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:26:01PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Omar,
> 
> (Unless you CC both me and mtk.manpages@gmail.com, it's easily
> possible that I will miss your man-pages patches.)

That's good to know, thanks. Do you mind being CCd on man-pages for
features that haven't been finalized yet?

> What's the status here? I presume the features documented here are not
> yet merged, right? Is the aim still to have them merged in the future?

They're not yet merged but I'm still working on having them merged. I'm
still waiting for VFS review.

Thanks!
