Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9521EDC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 12:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGNKTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 06:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgGNKTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 06:19:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FDC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 03:19:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g139so11028009lfd.10
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2mWXGb8qDwWepwC9GtvAtfuTcRSkTZNoUz/7tBuj5w4=;
        b=IY4UxVnzzRcsGwYrBKqt/5e25O/9f0c09XQ9ySHCczZy/i0f0gYx9QLwZtXoJ8X7ZM
         5MW8/0dDgLBTX6Q4TE87LTvdoHKvCj57HHbHI0HpjGL8h/cg6/kw5hx+04UxsaoDCNy+
         P4tPvwDURrTeOKfPv921zK42DMIAvxiJ7IIlqlJ3rkxhhK91YOcLC6HOEQ1aN6fJ03+Q
         Is/Mh1WHNi2qXNUoD8ejk83nG8RWH6H/eDqQWhGgwWMPujV0VJuPgtd0GpFSw0cBeR0q
         2EsxV4r06bH603rAdR8GS4qX8bMh9OWqM77a1EXmIccI7Tgba33H2zXPPfZ+bPQrU9Wl
         /k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2mWXGb8qDwWepwC9GtvAtfuTcRSkTZNoUz/7tBuj5w4=;
        b=gwnKfIN2d/GGCAUEZOvuL0n2YayNSa+uj4f6zmQgSZvovUNiQA0e9ioZh1rnjL5Ong
         wWnsyxjXU2sEwAr1j7XYZaZIOhLcKCqJGlqWsUVPUmsHmf4navHzh/+xtwcCxI6GEiaR
         DJGGPQPNhmu2a3UvoX5mvqhmOKRt4g+q9rQ2Ef61sJmS2moK7MzDbEnwhdgNv/GZ0/B3
         oAi0MObsKHiQZE8xa+3cMPQOrhCHHoLiufoOD7pG0P4AX1KZQFeTym1fu1mCWozMzcoN
         Y3h6pjSVfdjLgq4jyBmM0hNRvsWKaBlhwbEeF4cu9f3cKGWgEVVtXJys05C/UAsKD6ld
         +4xw==
X-Gm-Message-State: AOAM532x/CqvlfHOhw51QV2LaPlJjEJrFIpKksFBGEH8ImRTYbwlXIPA
        onW6u2IOnQzKoFSxWP2CyTmHrQ==
X-Google-Smtp-Source: ABdhPJw/OsMOz/4ZB1ZoSYenOQRRXbfc7EqRKqARM2W6By60PrLuXAdBdxPvMyyECZzfP/PMH7riHg==
X-Received: by 2002:ac2:5a4b:: with SMTP id r11mr1882755lfn.39.1594721988316;
        Tue, 14 Jul 2020 03:19:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 11sm4540766lju.102.2020.07.14.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:19:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2C21D1020F7; Tue, 14 Jul 2020 13:19:51 +0300 (+03)
Date:   Tue, 14 Jul 2020 13:19:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Robbie Ko <robbieko@synology.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
Message-ID: <20200714101951.6osakxdgbhrnfrbd@box>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
 <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 14, 2020 at 11:46:12AM +0200, Vlastimil Babka wrote:
> On 7/13/20 3:57 AM, Robbie Ko wrote:
> > 
> > Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
> >> On 7/9/20 4:48 AM, robbieko wrote:
> >>> From: Robbie Ko <robbieko@synology.com>
> >>>
> >>> When a migrate page occurs, we first create a migration entry
> >>> to replace the original pte, and then go to fallback_migrate_page
> >>> to execute a writeout if the migratepage is not supported.
> >>>
> >>> In the writeout, we will clear the dirty bit of the page and use
> >>> page_mkclean to clear the dirty bit along with the corresponding pte,
> >>> but page_mkclean does not support migration entry.

I don't follow the scenario.

When we establish migration entries with try_to_unmap(), it transfers
dirty bit from PTE to the page.

-- 
 Kirill A. Shutemov
