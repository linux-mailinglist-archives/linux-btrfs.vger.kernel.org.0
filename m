Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7B114008
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfLELXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbfLELXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 06:23:09 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECFA20707
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2019 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575544989;
        bh=lnRMJmOQllpHCCnYwuQKIZ1iL12+JMAJwo+/67siUp4=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=0pUrLBi3aqSBVIhPUrEISuZ0QcydxX9621ZYZZG1kbR8RJoPs5Buwb8KHi3qqaeeS
         bUVHI6+6NspIVoKMQ0pQce9yM455UeQ1rzs7jR/Q9vLHfK4XBgaAlnFuATPXnsLrjH
         YWpfns3njGa6mewy09RVH6F4g5ovZsDTwrQDIO04=
Received: by mail-vk1-f172.google.com with SMTP id l5so975078vkb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 03:23:09 -0800 (PST)
X-Gm-Message-State: APjAAAVXw7Kv0avG0Y4o/IWC2m5hO7rmxTrEYREEyrbW4F+pBJXFtYn2
        xEiZSpzmXcrSxdIp6AD+HPZqGKGPLXcLAW1WFik=
X-Google-Smtp-Source: APXvYqyL5zHQHGfNNjGIvBKeux/hcC8XSkgfYLI+lnGtHXPKP7fJYGS7vx+iE5a8+5SFZ7fSdALL/5hEWGodu3nB5tU=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr6111876vkh.69.1575544988137;
 Thu, 05 Dec 2019 03:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20191119120732.24729-1-fdmanana@kernel.org> <20191125134621.GC2734@twin.jikos.cz>
In-Reply-To: <20191125134621.GC2734@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Dec 2019 11:22:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4OK9nXTi9B5MOo59+AD0e_=OdiiV-YRZU2fV6ZO8p48Q@mail.gmail.com>
Message-ID: <CAL3q7H4OK9nXTi9B5MOo59+AD0e_=OdiiV-YRZU2fV6ZO8p48Q@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix cloning range with a hole when using the
 NO_HOLES feature
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 1:46 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Nov 19, 2019 at 12:07:32PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> [...]
>
> Added to misc-next, thanks.

I have an updated version for this. Do you prefer me to send a new
patch version, an incremental full patch or just the diff and then
fold it?

Thanks.
