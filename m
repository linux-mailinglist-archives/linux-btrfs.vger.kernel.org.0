Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97B2468BAA
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Dec 2021 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhLEPR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhLEPR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 10:17:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F06C061714
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Dec 2021 07:13:59 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 137so8060299pgg.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Dec 2021 07:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=boDKMdAeCyxxZM99fKq0bQHNAp1h846DLeDZStX6Wps=;
        b=hq5ys/tHTa8h4To/VSDFiBTfUJluau8aGb7QpgWodX9VFasPtMBUEUB/Lk6WKxMzdi
         Ylm+yCUZnUNzzSmpOhcWxiPDrzbCuEZUEfyzucrN+LKVKIW2aKSfNN/mb/ivwKbLtXs4
         4SZBFFklzgfdy6mQmE2yCxsFVw/y1+CMasImyZR9q+8U01JD+nXlCX+e3yNgaLk0YdD3
         i8vara1ugT+OS9llN+0QjPHPCXuC9LmxYAUA2gcNsU4YWMrWm/Rb79BJAC3+dezYOh0C
         SVAjRVdaj978rvPNCf0mlh8VOwH15D4KQ8KbY0wLlgy5ZdV+7d7tqKHylgcvktX7hqaT
         pzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boDKMdAeCyxxZM99fKq0bQHNAp1h846DLeDZStX6Wps=;
        b=XoV/DDmfXmrHIyy5zC0RcrkWQjnELcy6VvIWOnNUykD+ogQbD6Daph537obyE/PWMU
         4B9gOrqZPuW3a+DJgUGjjbKzd+mFyZhh6QTuk/QoTY8GKUeHcWGYYX1LcJqIiWMYE6dr
         Pag8iWTXzcemuDIrvfpsr2SGxlj5L1eq+bSqLNjx6hwWMuGhYE3PlTHffW/wEcEQC4yo
         /3857vCflQ/NKwQ5FDksTZyHoNdG0Jqo9UUPinIKQEGjVNAsvkeoK3NvdJR5f3kUwSWC
         PCVtLa/N+D7P3oUONZaxNHZTlr6eZmiQf2i8JOAnZJ4Qtj+M4HuCoY5/Qrk17gF4MZG1
         kkGA==
X-Gm-Message-State: AOAM533/U/bMc16ic6omEKWhvQLDc0WwioE24PZOUNf9+06WetI/AITS
        TdIcETdGrAJAfy3H5mdW3uCFtRGJJ16xbw==
X-Google-Smtp-Source: ABdhPJy+iUZ/cVBtp2B1vq/CX7daN+fnrQHG0Uorcgf1z65RTx7blxcnnN6wx5ahX6lpkpiZuZ4brg==
X-Received: by 2002:a63:f252:: with SMTP id d18mr13440940pgk.191.1638717239540;
        Sun, 05 Dec 2021 07:13:59 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id g18sm9387493pfb.103.2021.12.05.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:13:59 -0800 (PST)
Date:   Sun, 5 Dec 2021 15:13:51 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211205151351.GA1160@realwakka>
References: <20211122155411.10626-1-realwakka@gmail.com>
 <20211130174340.GJ28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130174340.GJ28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 30, 2021 at 06:43:40PM +0100, David Sterba wrote:
> On Mon, Nov 22, 2021 at 03:54:11PM +0000, Sidong Yang wrote:
> > This patch handles issue #421.
> 
> The issue is about descending to mount points, while you add handling of
> permissions. Is it referring to the right issue?

I understood it as a permission issue. Because the issue describe that
it can not descend into a folder because of permission. So, I patched
about permission. It could be solved with skipping all decending mount
points. But I think it's little awkward because "/bin/du" doesn't work
like it.
