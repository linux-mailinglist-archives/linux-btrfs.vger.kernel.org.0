Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3024F100
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 04:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHXCKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 22:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHXCKo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 22:10:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A4C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:10:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a15so7085891wrh.10
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kj3FwcfCwKWRURAO70qPnGh/wpJlYX5krvB12gFxsZM=;
        b=BQa+FCGf74P+rejFcgEVGWlLzePmTPvJ8rqhF9061+9m6wnk9+YW2QHEwjNzZTPkwA
         QRV4KLVb9euskYWgALM7GLbj/uK1d7fyFTLQbrKk1yhT/lcin5CuaOUkbQ1CEIX7+7Ad
         lfKf92jVfZ0Yc2sbJdPi0lX229eIefzbRw6jZldWJaawIaeZGuiXxBESWF8bz1ugn6Vq
         6k8ljskcamzQ+5FHdQoOb701UqfOV84x2oyIpB4uowR/PAQCqF/qs5rrPUNfQrnC6k0G
         jXhRA7lDn2OqmeJaXpEA/HVMBImo+eRh7VWLtrvzZPRFivQoYwLhfhnfg6+8nJ8JBQDZ
         Z/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kj3FwcfCwKWRURAO70qPnGh/wpJlYX5krvB12gFxsZM=;
        b=CNGmnvYqswgE3O+aoXK06/UsvCWnfxUefGcOLU/DLN+B8GHWCze6Gwugd9Qkv0huxT
         akKcrOo/gFPcZEH1Cp5viUU5JgWKnjHaMYRjKkyAP/eIU9rL/0j0q4mFX02EXZsEhmVk
         6cm3a0womt78iB6SuR0CnwFSe8p65NPVunRgXpyoidwFd9ReGCTKr38eCFOSP2CnCJ92
         5OJ59WCMJkBHXPIMY9LTN/PnuG63SSXoa3swb/zHrmOlZFQfBjIBNJyzN8UPuxcR7F3N
         N8ZSWSSrZZ1WdO7yW83m4GfNU4XjGMqX0jjtDIx4TBoL4CvwGh/MSWwosA6Fy6+xzga1
         50iQ==
X-Gm-Message-State: AOAM532St04sBnv1GBQGNpdwXovRIpBfBFLMbTwGn4LsFhiFf3PC26vo
        CCsUSEnLXa9+tKsVhnFfSowzkpoE3ADSdo48jKwJfQE+o0t7Kcp0
X-Google-Smtp-Source: ABdhPJxf6WWNffvmN3Ucbdx8Zt+V/YZRJ2nVAjfR7NX8RBjt4p5OUvBAdYGNJm5TQhJ2YkPn5/MOP2u3VjMtS6IKz8A=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr3580913wrv.42.1598235042773;
 Sun, 23 Aug 2020 19:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
In-Reply-To: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 23 Aug 2020 20:10:01 -0600
Message-ID: <CAJCQCtTt9-1TiA34huWM7pQJ62EdRT5iDLBTWFcLy1zCNFFOQg@mail.gmail.com>
Subject: Re: Minimum size of Btrfs volume ?
To:     Bill Dietrich <bill@billdietrich.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 23, 2020 at 7:26 AM Bill Dietrich <bill@billdietrich.me> wrote:
>
> [Noob here, sorry if I'm doing anything wrong.]
>
> What is the minimum size of a simple single-disk Btrfs volume,
> and where is it documented ?  I can't find that info.
>
> I'm told the minimum size is about 109 MB (114294784 bytes).
> True ?  Is there any way to get around that, at mkfs-time ?
> I'd like to use Btrfs inside a VeraCrypt container, and that's
> a fairly big minimum size for that use.
>

If this is backed by a loop mounted file on a file system supporting
sparse files:

1. make the backing file a bit bigger than you need, e.g. truncate -s
1g filename
2. cryptsetup open --allow-discards so that trim commands passthrough
dm-crypt to the backing file
3. fstrim /mountpoint - this "shrinks" the backing file by making it a
sparse file, file system size is unchanged
4. If the backing file needs to go on a file system that doesn't
support sparse files, use 'tar --sparse'

-- 
Chris Murphy
