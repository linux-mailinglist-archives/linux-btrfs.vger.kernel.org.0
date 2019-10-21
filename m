Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E64DF4C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfJUSF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 14:05:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfJUSFZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 14:05:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8922863pfl.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qMv7Aq/EKWcqrxVLodIHRmz/ZNgPTOxblOtF0zmUyA=;
        b=mIsrtuZI2pu1seVtPlHpFnpNq+53C91o7GSE9m8ZZybgJznhZYmp7QTkGlNqwNeFSS
         2uhxou+IVzBM5+QFoaY8QhGw4uUKqPHrCzXZz1p7VXVUk/KvNqucynnGFl+YWiQVnA7s
         n92vAF01jaMsePBRl2+TS53rKcJSilmCX+gDbBTE+YFiAh1ylXDHQ0ldqmO5Iadul4DE
         lhinrgTVgse144a3Y1Fo4tILDk+oEe4XKklmBPdSEX+M79ZZ7R6rM5u+Mbv6ikXBoE9j
         M3BhuQ/NSOOEdbgxDNWtbRH8eJGymYBxle2X6yFH3E027XXR/U0SmN79UgFroryXLN/8
         pX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qMv7Aq/EKWcqrxVLodIHRmz/ZNgPTOxblOtF0zmUyA=;
        b=LT0ey96NpTAx3V12nfTBgVhGKm1dajsTfVq10DNt4wP8itOIUffvi4KpM+EI747DtO
         ndRBMFCB/Qvlo6b40HiLYhkG+Mr/wVoCPQ4aCC2GoVVfR9CixacrjFSTBzzY7y8vDb7J
         yGrJm+qs58Q5dF8XhYIuywEi2LIlQoI+JRjs9Ld7QsXn37G+k37xm7ofecVBCn0yK6mF
         erQPebYYVfzXjeD70o5nFw18H2FIky/DPHns68UB1ae1A0crVKshnNKF7GSx0nwIEnjW
         djM87ExTnC7XOy2eY+RbLrcmaWK43+DXqyh+kptLSSy1ZrBwNULjKiAiWNZA2cqJ1ttQ
         lhRg==
X-Gm-Message-State: APjAAAWIgnpCzeNjp0o319AwGm6wiAGvYIACzYl72KoY19st1NzfEEWP
        lUd4FqMTgmoIO75PCFXPZ/WAcQ==
X-Google-Smtp-Source: APXvYqzxVOSpakbgchAj/0P4pwxdp36727zPto9TUN70iw399TJ9wp8rkaQTKKWIbUxovXt9MA4Lrg==
X-Received: by 2002:a65:638a:: with SMTP id h10mr26701649pgv.388.1571681123766;
        Mon, 21 Oct 2019 11:05:23 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4637])
        by smtp.gmail.com with ESMTPSA id k31sm17586704pjb.14.2019.10.21.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:05:22 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:05:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/5] btrfs: implement RWF_ENCODED writes
Message-ID: <20191021180522.GA81648@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <904de93d9bbe630aff7f725fd587810c6eb48344.1571164762.git.osandov@fb.com>
 <0da91628-7f54-7d24-bf58-6807eb9535a5@suse.com>
 <20191018225513.GD59713@vader>
 <20191021131452.GH3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021131452.GH3001@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 03:14:52PM +0200, David Sterba wrote:
> On Fri, Oct 18, 2019 at 03:55:13PM -0700, Omar Sandoval wrote:
> > > > +	nr_pages = (disk_num_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > 
> > > nit: nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE)
> > 
> > disk_num_bytes is a u64, so that would expand to a 64-bit division. The
> > compiler is probably smart enough to optimize it to a shift, but I
> > didn't want to rely on that, because that would cause build failures on
> > 32-bit.
> 
> There are several DIV_ROUND_UP(u64, PAGE_SIZE) in btrfs code, no build
> brekages have been reported so far, you can use it.

Good to know, I'll fix both places I'm doing this, then.
