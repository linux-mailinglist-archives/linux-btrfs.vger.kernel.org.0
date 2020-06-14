Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824661F89AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgFNQuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNQui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 12:50:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC56C03E969
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jun 2020 09:50:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q19so16369945lji.2
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jun 2020 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNTbu2Bx7XRrmCnutxciM8zN4YdqKVJvKPFK7H3YQGg=;
        b=NF91Lq6jqiu3UTIblaZW89jQJu97X+NJpMZiCPOoS7jkyPk4uajF4J2cU/f9tEhBn0
         fLCM7fZMUTmXdz9Pj9yYR1TrHVa7OwMFD1XM6fElnwvlLWRFhMEeD0qDMqkKaOSjlDHG
         Wzdc/fHywJ5oUxwF36rm9fuK4Zpm6taSzZsb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNTbu2Bx7XRrmCnutxciM8zN4YdqKVJvKPFK7H3YQGg=;
        b=ae+Bp2167bz21fsCQ7UjiEDwcN1/rvwECR+f0tNQicsnBdtZtQDlgfaUzpqezJZApH
         oVxClv75LJv5fLVPi/TsFLC4Y4rpeI+IetxeQLD8eawD70UCMaNqJN4wWNM3A/Ls39kr
         dnyXCFjUJ0YwTTR2DDEyOHQD317zvmIg1tBqv/TedFH4ncuQYW61RcToBTAmdBAwkv8h
         FuxofvMn8M84XsHyotpeoCsL3XW5zOzlnjuzkrhcP7vmTV+k6z14Jb4fBO9ET/jD0Frq
         WIKONzKsNh+GpLsC0PBgbU+FJ1Wgg/QCZE04SkNYfGx7MJInJxHaSMUCRHu0cyKkTzSr
         kmhA==
X-Gm-Message-State: AOAM530/9vgp+WVb7uX6w0bF3dGT79Nz+/hdghhfJf2XwtTI7peDGQF8
        aDqqXaTF9Vu9xXkrUQcJpEDtLR+Z5Jc=
X-Google-Smtp-Source: ABdhPJzcf0tJMr2KCwXGXw07AfLl1hycqiz69v8x+SsV6JRdAd/zcyVmDjbBPE6F7+OEBakuClQLyQ==
X-Received: by 2002:a05:651c:2cc:: with SMTP id f12mr10651812ljo.329.1592153434488;
        Sun, 14 Jun 2020 09:50:34 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a12sm3368438ljb.92.2020.06.14.09.50.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s1so16375435ljo.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr10825078ljk.314.1592153433099;
 Sun, 14 Jun 2020 09:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592135316.git.dsterba@suse.com>
In-Reply-To: <cover.1592135316.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 09:50:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
Message-ID: <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 14, 2020 at 4:56 AM David Sterba <dsterba@suse.com> wrote:
>
> Reverts are not great, but under current circumstances I don't see
> better options.

Pulled. Are people discussing how to make iomap work for everybody?
It's a bit sad if we can't have the major filesystems move away from
the old buffer head interfaces to a common more modern one..

             Linus
