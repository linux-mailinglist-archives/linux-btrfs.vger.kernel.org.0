Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1643623D264
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHEUMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 16:12:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgHEQZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=ZLdpXk/HNS+AUi3ROo21rtg5Qv/XEfMrWtwgHBP6n1uUNof4vHLTDb87x3rxT0koc07SI1
        KTy/QnlzYkehHheLsKET1MfkI4cCZ3DuAAVbypP255ovHcsjVT2UagoKVgj5mgELRtEPhL
        jo0xtTQdhi26UO7nuMhsfxoSWEsvsFk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-U7rTSfFnOe6Y7U4dhk3dZA-1; Wed, 05 Aug 2020 11:54:43 -0400
X-MC-Unique: U7rTSfFnOe6Y7U4dhk3dZA-1
Received: by mail-oi1-f199.google.com with SMTP id s82so18208087oih.5
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Aug 2020 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=RaYQzK3UUGhEZ7PdvIGFnG4W2QNnYO9NdhYkjH1r799XU1/yphmfGEvknX2D6lbut6
         SRp7OaNBHdtXSn+r9Jw1u2CIAMW5GjTIsOgpxh7FUBGNJozWLh04TYcxaapokiUSkdYF
         hnhCgJo0W5bCUr23FxpCG2sPYguUzgAfAKEMWAMm9NEilaOEVfhezBYcRaF/RWde+M9T
         D2OETKu1A7RzRxrqc28vaXhgwTc4w7zM0ajGBRxYaQKn1GQhii4ad0mSI2sfpnPLRUfH
         F/QGCAvHNEJkEtb2S8D6DC5JIS8IPIi/dFLE+oS/tj4PGxxJ/lMGhMJOR8MySnKwxZih
         nTog==
X-Gm-Message-State: AOAM532Bo9rYu3ooWIg9pjtoCW0u8jtJCny2ZnrPNlZWwto0gPWExJp3
        YSz8F5QFRAdzqnM1GwouPawklDK3G0cGv5scgUvhY6aoppUUc/JEfxg4mvkNUW2GkjZANUCQlw4
        13UgUBrqdGlR7uyX1JuniPmdbUAhq/0z3/QiIe5g=
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040069otb.95.1596642882745;
        Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFNuf696slwlPSZJynKjLvYPlN0RCiKIOzOVmS4vUbpxiRMAJuurwOtGRZDzCz52Sm2DXwT3decGCiphYpc3o=
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040047otb.95.1596642882501;
 Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153214.GA6090@magnolia>
In-Reply-To: <20200805153214.GA6090@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Aug 2020 17:54:31 +0200
Message-ID: <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Darrick,

On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       iomap: Make sure iomap_end is called after iomap_begin

that commit (d1b4f507d71de) contains the following garbage in the
commit message:

    The message from this sender included one or more files
    which could not be scanned for virus detection; do not
    open these files unless you are certain of the sender's intent.

    ----------------------------------------------------------------------

How did it come to that?

Thanks,
Andreas

