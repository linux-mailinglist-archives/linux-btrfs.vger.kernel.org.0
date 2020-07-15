Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0D2206CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 10:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgGOILr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgGOILq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 04:11:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5045FC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 01:11:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so573267lfi.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r58zgr+dFUtMHO8bMdDys5iOfYMIt5NXXpWBTmydEcE=;
        b=d2Q3jVi1joXvon+jSxrPSrpeL8n7zUBeVPObZ0usiT22dNLY7KRKXMYrMQTQaMsUqw
         ZML3ybd2ItswlymaGlTDLlpnYxEMup0Mv+XXSz1d44DByUHbI4svxA+64rv6rYq6N3Fw
         LZTI7q8p4mL4DpNvCzSzC5n3Sqy69xU+oIXEW66TyX6o5F0XSBzz5andR0PwL5RI8ijW
         wnJsJc14v3tagRrqqIxAADZxbQY0q2Rn9SC9mPTAKdZAqoVr/9m3Bk5IyezrHok+O3TD
         LZNp3Thb/18HnD9sYfuK0byDNBjmsEcSa5nU2ZFL26/aRwO7fit59T6lSILFFd1BlMVt
         UItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r58zgr+dFUtMHO8bMdDys5iOfYMIt5NXXpWBTmydEcE=;
        b=BCcQM4168UdJr0scb1a215J7HJWO4XvhfYkxjO354oINd2c6QGd+r6Wkk1PdJw1qug
         TMet4F8/vJMvRpk9tHmsN3oDgbOynY41ZE7yFRhcDuh0PRfAgZkgQJWOfdkL0i4KuOmT
         X6IJ8Fe/uCN0xvaNBLvaCQc7bKcOd7riBVdf9YOjNR2c+I2dgK1iQdoW3Jn6e3WQq//O
         fy0juUnfDQohaK5YuqS3/8LTdVvWDxEVroTe6DNYzrBC3xwLdt/Z6beyQDwuyoD1AIT0
         aEK86IztpZMIOe0dpmyjpxUJsewx6lycF55v+qompxoQHlKZL5Uzbmr3HhUtvH9V6lI8
         REqQ==
X-Gm-Message-State: AOAM530NT0pVcTKMW1g0ceVyV4Qy5Tt4M3g75mox0scV8dCb3XBgU96k
        6WvEXTOigE0L2yF9gb3aXQhmqQ==
X-Google-Smtp-Source: ABdhPJygnAIMcjY9IH7L7lww2iefyofOwl+m8Oz8PP+g5xfoCJJUzKGYICWaioD43IU4WV7dO+fw6Q==
X-Received: by 2002:a19:e61a:: with SMTP id d26mr4180514lfh.96.1594800704746;
        Wed, 15 Jul 2020 01:11:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y69sm330239lfa.86.2020.07.15.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:11:43 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 43B8510209F; Wed, 15 Jul 2020 11:11:48 +0300 (+03)
Date:   Wed, 15 Jul 2020 11:11:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Robbie Ko <robbieko@synology.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
Message-ID: <20200715081148.ufmy6rlrdqn52c4v@box>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
 <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
 <20200714101951.6osakxdgbhrnfrbd@box>
 <a7bb68ef-9b33-3ed7-8eff-91feb2223d80@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7bb68ef-9b33-3ed7-8eff-91feb2223d80@synology.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 10:45:39AM +0800, Robbie Ko wrote:
> 
> Kirill A. Shutemov 於 2020/7/14 下午6:19 寫道:
> > On Tue, Jul 14, 2020 at 11:46:12AM +0200, Vlastimil Babka wrote:
> > > On 7/13/20 3:57 AM, Robbie Ko wrote:
> > > > Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
> > > > > On 7/9/20 4:48 AM, robbieko wrote:
> > > > > > From: Robbie Ko <robbieko@synology.com>
> > > > > > 
> > > > > > When a migrate page occurs, we first create a migration entry
> > > > > > to replace the original pte, and then go to fallback_migrate_page
> > > > > > to execute a writeout if the migratepage is not supported.
> > > > > > 
> > > > > > In the writeout, we will clear the dirty bit of the page and use
> > > > > > page_mkclean to clear the dirty bit along with the corresponding pte,
> > > > > > but page_mkclean does not support migration entry.
> > I don't follow the scenario.
> > 
> > When we establish migration entries with try_to_unmap(), it transfers
> > dirty bit from PTE to the page.
> 
> Sorry, I mean is _PAGE_RW with pte_write
> 
> When we establish migration entries with try_to_unmap(),
> we create a migration entry, and if pte_write we set it to SWP_MIGRATION_WRITE,
> which will replace the migration entry with the original pte.
> 
> When migratepage,  we go to fallback_migrate_page to execute a writeout
> if the migratepage is not supported.
> 
> In the writeout, we call clear_page_dirty_for_io to  clear the dirty bit of the page
> and use page_mkclean to clear pte _PAGE_RW with pte_wrprotect in page_mkclean_one.
> 
> However, page_mkclean_one does not support migration entries, so the
> migration entry is still SWP_MIGRATION_WRITE.
> 
> In writeout, then we call remove_migration_ptes to remove the migration entry,
> because it is still SWP_MIGRATION_WRITE so set _PAGE_RW to pte via pte_mkwrite.
> 
> Therefore, subsequent mmap wirte will not trigger page_mkwrite to cause data loss.

Hm, okay.

Folks, is there any good reason why try_to_unmap(TTU_MIGRATION) should not
clear PTE (make the PTE none) for file page?

-- 
 Kirill A. Shutemov
