Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3FE23B2FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgHDC6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 22:58:00 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.60]:41574 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbgHDC6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 22:58:00 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id D79B03028
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 21:57:58 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 2n9KkK7bnXp2A2n9KknKnx; Mon, 03 Aug 2020 21:57:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v8bkDHWsWUkzsLJdCF/Ai1snROgYnQGEGPecRa4K60U=; b=e+vZ5WL2l3JkHqScf+3Yg9e8zV
        isJdfaIudsA0kAhQ4WkQKMR8AXs4gRbZQqFRUol5GoD7r8x9LEaj/amLQZpPKZqNIacPA11PnM7yV
        173r0NGekZfCKHvoCCztCfVOjSALG07JsI5eVbhABeJaBSWne2vzD+Mkt2GlwYh+c/UY2wcrgD2rt
        76A1mn1WY4rTNpNkdw3+jhW6CfHGbqtWwk5HKrHjWAghVWhzXUwYiG4afOL2XIoxqdBsYieLXDbq4
        5Z4fygN4P5VM5gPu811bwIrIMFVfmr78j9PuRZktqtwQxAj4ctFwji70Ko7qYbxtLnQxopVznkQkY
        A3oy7cAw==;
Received: from [179.185.209.90] (port=50454 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k2n9K-0018bL-Ba; Mon, 03 Aug 2020 23:57:58 -0300
Message-ID: <5470b51ec2da3bda36c6390f5de939dc6c43dc89.camel@mpdesouza.com>
Subject: Re: [PATCH btrfs-progs] Documentation: btrfs-man5: Remove
 nonexistent nousebackuproot option
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Mon, 03 Aug 2020 23:57:54 -0300
In-Reply-To: <CAEg-Je8VCXVC=9z-cCtszKxKeVbRMUojEQzHAuYkgdv4jXm-oQ@mail.gmail.com>
References: <20200803042944.26465-1-marcos@mpdesouza.com>
         <CAEg-Je8VCXVC=9z-cCtszKxKeVbRMUojEQzHAuYkgdv4jXm-oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.209.90
X-Source-L: No
X-Exim-ID: 1k2n9K-0018bL-Ba
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.172]) [179.185.209.90]:50454
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-08-03 at 21:24 -0400, Neal Gompa wrote:
> On Mon, Aug 3, 2020 at 1:05 AM Marcos Paulo de Souza
> <marcos@mpdesouza.com> wrote:
> >
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >
> > Since it's inclusion in b3751c131 ("btrfs-progs: docs: update
> > btrfs-man5"), this option was never available in kernel, we can
> only
> > enable this option using usebackuproot.
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  Documentation/btrfs-man5.asciidoc | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/Documentation/btrfs-man5.asciidoc
> b/Documentation/btrfs-man5.asciidoc
> > index 064312ed..2edf721c 100644
> > --- a/Documentation/btrfs-man5.asciidoc
> > +++ b/Documentation/btrfs-man5.asciidoc
> > @@ -471,7 +471,6 @@ The tree log could contain new
> files/directories, these would not exist on
> >  a mounted filesystem if the log is not replayed.
> >
> >  *usebackuproot*::
> > -*nousebackuproot*::
> >  (since: 4.6, default: off)
> >  +
> >  Enable autorecovery attempts if a bad tree root is found at mount
> time.
> > --
> > 2.27.0
> >
> 
> Shouldn't this option be plumbed through instead?

As this option is only used at mount time, I don't see why we should be
able to disable using remount for example. Am I missing something?

Thanks,
  Marcos

