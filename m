Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C614AA6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 20:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0TZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 14:25:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35235 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 14:25:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so5650815pgk.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2020 11:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4P3DdTN+wrR6fQcK40tntA+dq7h5m1yL1kMliv8mYHg=;
        b=0Nhj2GfaHtYne8j8eOfjSMV0G/OH06n093yS3u3+qD9AviXD+DyBK8zvjJPEmAAvhj
         IWgdHDNwXvKQBmLXKSDURmNpyoOR24kaMEimLbfYY6biYvl6uFP0bxic2UCSKZKlOpr7
         jEZrgEuv0h4VhQEq5Si1kFhNXyBJmE9RqKlYGrpIuqKr6yoo4BcD/Mp4gC6nRwqZRDch
         2sstvc40zOUpdGo8brnjs6kxyfPqx9sTrCwk66lav67be2CZbBOhAGcoj8S/UrIT2hJ9
         bWdduGVGx59lgmjFw8rpgUOcYPPQfpGqaElI3FXz0df2YyATNlXlcuJURWLYBdYDmb7g
         vRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4P3DdTN+wrR6fQcK40tntA+dq7h5m1yL1kMliv8mYHg=;
        b=eX5Rj9iy2Cmp9HKmhvuz1gYOyM0TLG0ABkg9/keBYjsOHznNNvAvUyd1nvS6ejcy6a
         BKSD3Hh07L147Gr1pMMDJjO6NmX44j9lZ73Q27Xz8BxmVTXFNetJ3CuFswJHrPnK5erd
         F2ehPLsrWO7/5tt9o1HlmtTeD96SSXDasZEBH1s/bmXEfV3cIhfVPo1BdQxtAOjvfJqT
         abGlPJgTayUZRZLNAxAIjfxodQ9w7KhpZpYGD3MGoGSrkKXwRlatxFXS6BALocOhk9Rc
         1iIX2e2up6jch5d2TJ9SvVQsldifV4hCmKFpuOGkQ85V0VK7tQ/M9a4ip1NqNV7nN4lU
         ucFw==
X-Gm-Message-State: APjAAAXNcNHgrTXJvjfavPwpqh6+yW4wduzWLptkK/nY0bXvnYeRkgiP
        MItdP9K07mTdUucFUfTmMZmbMQ==
X-Google-Smtp-Source: APXvYqyBkgKei2aoLrW2Hza9+6fwFIJfPQGvR8OXSn9fKf4ieeOSkh91Vy5lEOu3qo1rzSM6EuNcfQ==
X-Received: by 2002:aa7:9aeb:: with SMTP id y11mr156193pfp.63.1580153150304;
        Mon, 27 Jan 2020 11:25:50 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2:b017])
        by smtp.gmail.com with ESMTPSA id o17sm16387062pjq.1.2020.01.27.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 11:25:49 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:25:48 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>, Omar Sandoval <osandov@fb.com>
Subject: Re: Hibernation into swap file
Message-ID: <20200127192548.GA683123@vader>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <20190506113226.GL20156@twin.jikos.cz>
 <CAJCQCtSLYY-AY8b1WZ1D4neTrwMsm_A61-G-8e6-H3Dmfue_vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSLYY-AY8b1WZ1D4neTrwMsm_A61-G-8e6-H3Dmfue_vQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 10:20:40AM -0700, Chris Murphy wrote:
> On Mon, May 6, 2019 at 5:31 AM David Sterba <dsterba@suse.cz> wrote:
> > for the reference https://bugzilla.kernel.org/show_bug.cgi?id=202803
> > and https://github.com/systemd/systemd/issues/11939
> 
> I've read these, but can't tell if it's still necessary to manually
> use 'btrfs-map-physical' to find the correct offset, and use it on the
> kernel command line manually?

Yes, it's still necessary, and it's unlikely that systemd will ever go
through the trouble of doing the btrfs-map-physical itself. What we
really want is the interface I described in [1], but I won't be able to
work on that any time soon. It'd be great if someone interested in the
feature would take a stab at it.

1: https://github.com/systemd/systemd/issues/11939#issuecomment-471684411
