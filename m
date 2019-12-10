Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96216119006
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLJSul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:50:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33060 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:50:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so229753pls.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=85RQ9KfJ30s8ThwUy++S6Z2MwgPqd21iyEz8DMTHbuE=;
        b=GwWsisvjTW/g8hGt+0LxegVBfG6YoePvJtCxvpaZdHVOyaO87wDdT2ct/2vwWbds5t
         nHOn3Ym8mmDHpAJhWTkaGvncqWLF17UK2QBtsHyiO+yt8uaaPBbUKqn60jToCTvwig4m
         fhXKNNs+4MoE831msJyQfGoYKgHoJc1DRqFsMutm67zU52HGorUINnVQwnLmS8hmYJdd
         /nVAWnzzJvZhVVE2LZBRUVHB6w2mrPlz6cdzGtFdeAPV9cJ9qp5s20fUlRuUTVnOTKuQ
         WjgU1wSeUPGyLkEoDNI1wBdWQ+UT4wr78pKSmW6yaz8iUNCQbJTpxVDxr7Fka6LKTi1t
         TimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85RQ9KfJ30s8ThwUy++S6Z2MwgPqd21iyEz8DMTHbuE=;
        b=qiJkAdfLUuArgmz/2Gqwo7pZ8+FuTfs/RXa2UI5Te/fQ9lhSfT3Sx8WMxthKnYUrTN
         +OWQZl1batoSt4GjyVvaDQh6RsL437Zijl9ENtz8dqK2jFAv3CSHkyLBCmCY0X94wgm9
         I7bnRQncTFUeTVxSNvtzDneA80c6PdO+EjVEro2bsiLUZZ++USm6p5ICeYBnkBRo5AFn
         WFcN/IHHZOZ0mDXZkBc2jNCXywG6aLL2UQqxlplxHmPiH2igcs+skr3iA/ZWWyekQbNu
         xemMVrM2MuRPKDT1okNmHc+Zz3qnB2PSrTHRe/dIMa0q2oywuHu5yEHygV2qwY6gWHns
         Kfog==
X-Gm-Message-State: APjAAAUY+eA5PzfBWgM55eufzKcjroKoIDceg3QeSrNYU124DhuvtuQU
        p7fS4VkDbp8IBipZC4ITNwGPHUZpcmASsg==
X-Google-Smtp-Source: APXvYqxpV7txqAAG722ELQPliZRdhogO2wja9zhxqqE7Bury8Sjzoq3zytSY6K20Ihcni1TimbqsXw==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr6950672pjb.93.1576003840079;
        Tue, 10 Dec 2019 10:50:40 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:c519])
        by smtp.gmail.com with ESMTPSA id s18sm4151423pfh.47.2019.12.10.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:50:39 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:50:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9] btrfs: miscellaneous cleanups
Message-ID: <20191210185038.GD204474@vader>
References: <cover.1575336815.git.osandov@fb.com>
 <20191210184744.GH3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210184744.GH3929@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 07:47:44PM +0100, David Sterba wrote:
> On Mon, Dec 02, 2019 at 05:34:16PM -0800, Omar Sandoval wrote:
> > This series includes several cleanups. Patches 1-3 are the standalone
> > cleanups from my RWF_ENCODED series [1] (as requested by Dave). Patches
> > 4-8 clean up code rot in the writepage codepath. Patch 9 is a trivial
> > cleanup in find_free_extent.
> > 
> > Based on misc-next.
> > 
> > Thanks!
> > 
> > 1: https://lore.kernel.org/linux-btrfs/cover.1574273658.git.osandov@fb.com/
> > 
> > Omar Sandoval (9):
> >   btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
> >   btrfs: remove dead snapshot-aware defrag code
> >   btrfs: make btrfs_ordered_extent naming consistent with
> >     btrfs_file_extent_item
> >   btrfs: remove unnecessary pg_offset assignments in
> >     __extent_writepage()
> >   btrfs: remove trivial goto label in __extent_writepage()
> >   btrfs: remove redundant i_size check in __extent_writepage_io()
> >   btrfs: drop create parameter to btrfs_get_extent()
> >   btrfs: simplify compressed/inline check in __extent_writepage_io()
> >   btrfs: remove struct find_free_extent.ram_bytes
> 
> Added to misc-next with minor fixups, thanks.

Thank you!
