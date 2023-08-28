Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C578B1BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjH1NZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjH1NZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 09:25:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9D11D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:25:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so3060768276.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1693229100; x=1693833900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMKR/ZqVXJ/7ttGZ+EBnuAXtVFPEJHlFRcOmriGmHlY=;
        b=xXSfJM6D5C0Wm8pYuMr2uvJ3JOmmunnN8Sosja/1KKkECfxpQsP5qwJGbBpgh/eWGY
         r+5Lb0MPhHsd6y7cUGf6KSKuk/DlVJDYegW2uqu/OZpuO8X31ZVDTkiU79TeLviKjmcn
         OSSQYQ/2oLErGQ9Ab8h1LgvXN66judXzjhPXs06+xSav+92DwWCKoFgNqGMJWfDKd31K
         tOfoORt7nSEF+Ool24n27cKO96JU1A1/ynHXh5NhfSXYSa8af/4+fCIixyRiQ+/l8xWl
         Fsx2qvcNbeXVKl1Z6DeqBnPgfNccU+kQkBqIPPRdw2F7yR8T3rknd0mKUuHrodBSOZ/P
         SzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229100; x=1693833900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMKR/ZqVXJ/7ttGZ+EBnuAXtVFPEJHlFRcOmriGmHlY=;
        b=hIoFk7mY1eljN5ZsXPg1QdBCXsKxzenciPmqDn4vIO6D0Sz7L/lenVg6gcQ7RdKN6t
         B/IKLh0u/Clz7IX8ZcA65Mi7yK9u/hR3fOkPV83FvAPIUdCRooJ3ucRt2cYhiTl9E5aw
         EtZaZA7gGw9vCfgjMVk74sAnVhLtmiLRFOZj9wVUXVy8h5ZFGHPSmaruOOaNYYFBLrU8
         Uix0Z0iXuKWchOdzilH6n4mKhd7GFttcLmBsfS35p7g6AKJcfeJ8PAoYJkGqi+A1m1uf
         lpZh1eaWP0zPmODOamZ9BQfbT1buxwzVy+yXLTCjXE1C7DRMwj2qDnsZkUFcC7DhL+AS
         OXiQ==
X-Gm-Message-State: AOJu0YwHo3IMG8dYDXdrmEiBC1GJ3rohJfSHdbTaqJQ1GdEIIp2jMezt
        Hyaw4FU69adQYVyAxmalDgrSVw==
X-Google-Smtp-Source: AGHT+IFuOS/bxy2dZIFLn+46KZ/OCwYtqVhqy9bI/u90fQCPvMxmGv2qeDgTyqxFwoV1xMEHDOtZuQ==
X-Received: by 2002:a25:ef4c:0:b0:d5c:4a6a:f5a4 with SMTP id w12-20020a25ef4c000000b00d5c4a6af5a4mr26966722ybm.24.1693229099836;
        Mon, 28 Aug 2023 06:24:59 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b5-20020a252e45000000b00d0bad22d652sm1576398ybn.36.2023.08.28.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:24:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 09:24:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Arsenii Skvortsov <ettavolt@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: receive: cannot find clone source subvol
 when receiving in reverse direction
Message-ID: <20230828132458.GB875235@perftesting>
References: <2fcd8ea94edb2a1d623525db80c67fcbca46aec8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fcd8ea94edb2a1d623525db80c67fcbca46aec8.camel@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 26, 2023 at 10:33:22AM -0400, Arsenii Skvortsov wrote:
> process_clone, unlike process_snapshot, only searched a subvolume
> matching by received uuid. However, when earlier "receiver" side
> sends, it mentions received uuid, which is for earlier "send" side
> (now "receiver" side) is just uuid.
> 

The changelog is too terse for what you're describing, it took me a while to
figure out what exactly the problem was and what you were trying to accomplish.

Something more like

process_clone only searches the received_uuid, but could exist in an earlier
uuid that isn't the received_uuid.  Mirror what process_snapshot does and search
both the received_uuid and if that fails look up by normal uuid.

Or something like that.

> Fixes: https://github.com/kdave/btrfs-progs/issues/606
> 
> Signed-off-by: Arsenii Skvortsov <ettavolt@gmail.com>
> ---
>  cmds/receive.c                               | 28 +++---
>  tests/misc-tests/058-reverse-receive/test.sh | 98 ++++++++++++++++++++
>  2 files changed, 115 insertions(+), 11 deletions(-)
>  create mode 100755 tests/misc-tests/058-reverse-receive/test.sh
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index d16dc0a..bdd4dee 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -222,6 +222,19 @@ out:
>         return ret;
>  }
>  
> +static struct subvol_info *search_source_subvol(struct subvol_uuid_search *s,
> +                                                                               const u8 *subvol_uuid, u64 transid)

The formatting is off right here, and in the whole patch, you need to use tabs
not spaces for indention.  The code and the test are great, just fixup your
editor to use tabs.  If you're using VIM let me know and I can give you a .vimrc
that will do the right thing.  Thanks,

Josef
