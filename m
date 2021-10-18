Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9B432907
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJRV3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRV3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 17:29:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1DC06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:26:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y7so15762360pfg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bEVDBjsttDSy6PZTOPkCDS58Kx/Vm0Mh8v/Ct94axtw=;
        b=ZHn+mrHwxpTK8GKUZUEtH7U+4A6KPC0+JbZ81ekD+ophxzx9GqVGYrAF0xt1F8KNu7
         WrXS0rp0JTUgcukAQsI7Hrl/7hWt1J1CNZ7/Lghn9A+XCi8iwTwvGYeUdpHAPJutZfgB
         9eX4igOv+kRfkBejiOieN/eww57NRFCkX/y7ms0Cu/xQ67TuBWr0LyDXDKtdXK+QJwGm
         LunkRzt0now5/dzm0FsU6HqRC0ZS1iE8s8HZIMlAuzQ0KX8aKjmWrVoc0g/sGdGNz22w
         fq+wSQYx/ALjFD5NcMlZ61weU1hdyaEbFqJDSV6lMwdwSiHSLiXH08G0mW/Kxa+gfMw/
         I3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bEVDBjsttDSy6PZTOPkCDS58Kx/Vm0Mh8v/Ct94axtw=;
        b=g/2dWWpSXyFI4Hok/4w8/J0xJcHhCGNc7iF6ZbatXLgt/UaWASctX+36ummBCMcBS6
         B0TBFiW3C9LRyD/PT5VP+J31WsnWH7S4LYoZ2mGuyP5CMZGbqDD4eKbX3WxwhdJ5x2PY
         ev7W9s96ixsYkl/szh6fHiEKy4t1B0dVXCpIPs2K0wOrEhIVcPrtyGL4upeEjA6vpdy9
         KsxTVkoOBE0P2qSS/im+uygRrN9IfzYYL/KwBkX9GiehxbvwjtQjgNedAKjxppQsgWo7
         E24BRt4xAwdPbS4EA9vw2D+GNfL0aWaiLCGj/0M9gbHANOQf4MFQFa9Lo6hPJwJMYcM5
         sTeg==
X-Gm-Message-State: AOAM531hnTEQLI2gWJ6N93dW9iqW5khKtaHhJ0vNajrZNGbXrvXvZ+Ch
        8pe00O2iqDtTMyJVJ4/FMtsZm2etwHscKA==
X-Google-Smtp-Source: ABdhPJx+4vB+lEzpD3a4KnVgV2gZJr2epCvoNS3jaqHGD4YFviU4onO+oJz3Ae4xoaHTvVT3eKuIYw==
X-Received: by 2002:a63:df06:: with SMTP id u6mr25788824pgg.148.1634592418866;
        Mon, 18 Oct 2021 14:26:58 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id 184sm14238061pfw.49.2021.10.18.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:26:58 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:26:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: send: v2 protocol and example OTIME changes
Message-ID: <YW3moPgbBMQhN7XY@relinquished.localdomain>
References: <20211018144109.18442-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018144109.18442-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 04:41:09PM +0200, David Sterba wrote:
> This is send protocol update to version 2 with example new commands.
> 
> We have many pending protocol update requests but still don't have the
> basic protocol rev in place, the first thing that must happen is to do
> the actual versioning support. In order to have something to test,
> there's an extended and a new command, that should be otherwise harmless
> and nobody should depend on it. This should be enough to validate the
> non-protocol changes and backward compatibility before we do the big
> protocol update.
> 
> The protocol version is u32 and is a new member in the send ioctl
> struct. Validity of the version field is backed by a new flag bit. Old
> kernels would fail when a higher version is requested. Version protocol
> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
> that's also exported in sysfs.
> 
> Protocol changes:
> 
> - new command BTRFS_SEND_C_UTIMES2
> - appends OTIME after the output of BTRFS_SEND_C_UTIMES
> - this is an example how to extend an existing command based on protocol
>   version
> 
> - new command BTRFS_SEND_C_OTIME
> - path BTRFS_SEND_A_PATH
> - timespec attribute BTRFS_SEND_A_OTIME
> - it's a separate command so it does not bloat any UTIMES2 commands,
>   and is emitted only after inode creation (file, dir, special files).
> 
> The patch should be a template for further protocol extensions
> 
> RFC:
> 
> - set __BTRFS_SEND_C_MAX_V1 to the last command of the version or one
>   beyond?
> - drop UTIMES2 before release?
> - naming?

If I'm understanding correctly, the main difference between this send
stream v2 and mine is the BTRFS_SEND_FLAG_VERSION flag and
btrfs_ioctl_send_args::version rather than my BTRFS_SEND_FLAG_STREAM_V2?
That's definitely a better way to do it.

What's your plan for merging this? Did you want to do this as a "trial
run" before merging the compressed send/receive stuff as protocol v3, or
did you want me to integrate these changes?
