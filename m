Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32F90626
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfHPQvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34948 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfHPQvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34so6801989qte.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsEAjX2MgGMHEyGOQbaJNFFPAZYOZgwDIKQ3vQb9J90=;
        b=sVBUJMo+5mmU3TXIUjc51VfVsK0OxZajdyHsssKnknjCZPVHQASe1ZHvA7xJKZ7f5j
         NQ6bGmfST09/jVxDAN2zoNLAX+Bqlz3kJabNzjVmHuO6hgK/Mw+VsIjnsKsnvYuXUgQq
         ip6TBFCyQelGTKIHi36+WOl2s/+S/A+cdoQxvLuYhGypzOpY9Agnhr1g+WRU/da2X9SD
         MYpfL26bnMeICLhQp+UiJPZSMJaqFOByaETTesABVKJ30O1xZZToTa4YA0W+yyK6haH+
         6Oq6B1bUxy81aE3Vv/rvnwljoH0gfelSavlxrQmZP+UdHsI+jnQ/LVdOmp2R/C+fCapQ
         iXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsEAjX2MgGMHEyGOQbaJNFFPAZYOZgwDIKQ3vQb9J90=;
        b=pP7CqCJ7d0HLU2SfX+uez8rWcMHoYzMsiM/THZ3NNmqtHye386G9F2wAQAo+8R4eiC
         yiEQy/uEM+m/a6bDN5j0ZmHNzP4q5rH5guGGfXZKajdMJRc6nBE5cgSEC424T+YiU1fj
         yZEP8NzNOWp1usEa4biaG4UHOWuMfIdfBkrAouQZu9/NdE8fUuvNhZlKz4sVtelpHCHv
         gGVry6aHPg9iJQYLfHjHZgAbxGmFSjxQC/A5r7S1X33smLrFGoNYfgZebFw8LJVqgTtX
         BiVRHLmw7WLMi6E3fFKT3QWfl0/soZ6zPftsrFVLZk9Bfl4aVyad+hICHKBWPPlDg0U3
         qyCQ==
X-Gm-Message-State: APjAAAWfDZ8B8LfZN6ffVRqPZJjbRiRBjBccCwvXP41JC/xMLT221j12
        SvHv+CYncC7S65PtxslpB4HxpQ==
X-Google-Smtp-Source: APXvYqxaNOmUw4oaN4XwZKJANViakAbcOPMmnetX62CcUJubOX2tkEaKwKI+4HfGxvZNdJiG7L17nA==
X-Received: by 2002:ac8:2af2:: with SMTP id c47mr3177519qta.387.1565974280306;
        Fri, 16 Aug 2019 09:51:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r40sm3529130qtk.2.2019.08.16.09.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:51:19 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:51:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: global reserve fallback should use
 metadata_size
Message-ID: <20190816165117.h5vgc3hbgtagxhmv@MacBook-Pro-91.local>
References: <20190816150600.9188-1-josef@toxicpanda.com>
 <20190816150600.9188-4-josef@toxicpanda.com>
 <CAL3q7H54WZOceHpcFQmADiuHFqWNAQOqbxN9o5J22qfHbx68HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H54WZOceHpcFQmADiuHFqWNAQOqbxN9o5J22qfHbx68HQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 16, 2019 at 04:35:42PM +0100, Filipe Manana wrote:
> On Fri, Aug 16, 2019 at 4:08 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > We only use the global reserve fallback for truncates, so use
> 
> For truncates?
> I would say only for unlinks, rmdir and removing empty block groups.
> Or did some of your previous patches changed that, and I missed it,
> and now only truncates use it?
> 

Sorry I misspoke, but same basic idea, we only use it when we're removing shit,
not adding shit.

> > calc_metadata_size instead of calc_insert_metadata_size.
> 
> I wouldn't hurt to be less vague and mention why we do this change (if
> this is still used for unlinks/bg removal, we still need to insertion
> orphan item, not just remove items).
> 

Argh I misread the orphan stuff, I thought it was earlier/separate from this
usage.  You're right, let me see if I can just axe this altogether.  Thanks,

Josef
