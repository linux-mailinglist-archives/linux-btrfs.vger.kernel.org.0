Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA393F0E97
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 01:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHRXXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 19:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhHRXXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 19:23:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B4C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 16:22:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u1so2860634plr.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+znUywaHilSFMMJv1Y4x6bPgrIgLTXv2SL6EryarGL4=;
        b=oN8xGTXErQBtLx4G6V7cFe5OoJZukmO3qn9co/wHlN18fel6V43GUhk/uKYe2JXM6l
         1ikF9Hk2xMgX0gOAe5u0IFUdVLJp8xR3rPuUWU837C52vjZv5pfx+9WTmgzXXguKBS1X
         azaXFrfNtEqvY5CJsh+O3d7rPPBOBxDFNivPK7Coi5L2YS0zMcDvFovNJeGw0/YtbKHa
         VxNA+IxysDfZvYfPAHfXRnBhCn1ZKbfKYmB14OLSSRwjdJ+VdRmZzw6eRoyL2m032Hg7
         epJQcFDvrvBf4uJUNfWeeKSwDIUHHGdGDzG4NjEX7sjpTNSdZVDdsOyPl14mTUEBYidl
         tJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+znUywaHilSFMMJv1Y4x6bPgrIgLTXv2SL6EryarGL4=;
        b=tLLBAKzTlwOrNCm+vzAOmeJM+iZd1w0vmIJ4qgdYBWoDDJYmV/gSh6ZfUrCyGcr5i5
         5JOJSMKtkMZtEB6HWFN69uiJ47vwmOFGj3EeOPvPkV9+Mtv1Q7XBcHpf5jpC2IKnTD+o
         374sjfo1Pj4fGFudjlbwQDabOYhXiiAQ1Gx8ObuBOxfoqlTMiKk5dpAn94PWdC4ho+6f
         rHQuumm8N8o2Bn17hW7PniIddCP5talUKQ53iVHrWoO9/UH9fz3ToKxmAnjlIiEB2Rn9
         2CoBBhu0uBy4dI3jsua7NkN97DgNVSt9NjIysScl9ziuPQlWnVXrGLCfKvaxSv2Vey25
         Xg4g==
X-Gm-Message-State: AOAM533B7qTQ2mX27imIt6P4vjsolmBPJA7AyX69ELtIIbZ5Faf6+jyU
        wl0hYSsqHGguvGHD9apF/mE=
X-Google-Smtp-Source: ABdhPJwarObRRCLuec++WEYMOMWDJqBwgrK5fbeWTNXcqyaMKxU4R2amg0VUWAGG/NMEAMoD8YmLuQ==
X-Received: by 2002:a17:90b:1c92:: with SMTP id oo18mr11865908pjb.56.1629328961377;
        Wed, 18 Aug 2021 16:22:41 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t20sm994870pgb.16.2021.08.18.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:22:41 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:22:32 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Message-ID: <20210818232232.GA1987@realwakka>
References: <20210818160815.1820-1-realwakka@gmail.com>
 <20210818222447.GX5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818222447.GX5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 12:24:47AM +0200, David Sterba wrote:
> On Wed, Aug 18, 2021 at 04:08:15PM +0000, Sidong Yang wrote:
> > btrfs_extent_same() cannot be called with zero length. Because when
> > length is zero, it would be filtered by condition in
> > btrfs_remap_file_range(). But if this function is used in other case in
> > future, it can make ret as uninitialized.
> 
> Do you have a specific future in mind? Adding the assert won't hurt so
> ok.

No, sorry, I just want to make it safe. is there any way to better than
adding assert? Would it better to initialize ret?
