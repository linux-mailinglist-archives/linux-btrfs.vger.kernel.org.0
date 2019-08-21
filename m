Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498F297E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfHUPQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:16:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33912 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfHUPQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:16:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so2107030lfq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 08:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z1Sfz9Md7ZyzmIiUqlf9/ypjVqwnLYwlgb6j2EIFCd4=;
        b=l6BVKbfxQhiEphc5JjllzwVCpUVsZX0W6NHBrESlhqr9ycLJqoSxJKIc0J21p1VJA4
         G+AmuixOxy2dkgmDKTzH5HKhNTxfkLJdAa8A5hAqgxA3BQTj9137E4wgaLclrK+qb68t
         Ifpj0NRBId3l7Bzn1ZDA0g84l022KfqPa48S4vSvMwU4Du6631nqx9oCz/nDWgIrqTgf
         qPZWemha3YEGP/5dhdzcQ31iPLtOkoFxQ2gTrK1+yJloXPTr2sRQMbx6iZm2jVcsBgoP
         Yoa5eB4/qSDuDbAcBu9S/IJEjF6KLfylo0GKyvjR0esZ1uoWIIsPnyhwkGlXgPvL5xRU
         A/yg==
X-Gm-Message-State: APjAAAXIeRcReim7/dYacyPoT8Y12XctcrE6McxSNrypXvLtgxcD7K1T
        Vx2IMJVJog3AvYYwsU8648hEaeWiDtGWfw==
X-Google-Smtp-Source: APXvYqzmTRlfMBMeB7y3QJ8BtyMqgaJbMKqtSSp71i8s1kwHpCS757d5zaDKEhzA7oygExL49ds7kg==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr18959828lfm.143.1566400588362;
        Wed, 21 Aug 2019 08:16:28 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c89sm3363033ljf.83.2019.08.21.08.16.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:16:27 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c19so2070419lfm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 08:16:27 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr19503318lfp.61.1566400587851;
 Wed, 21 Aug 2019 08:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190815020453.25150-1-git@thecybershadow.net>
 <20190815020453.25150-2-git@thecybershadow.net> <20190821143526.GJ18575@twin.jikos.cz>
In-Reply-To: <20190821143526.GJ18575@twin.jikos.cz>
From:   Vladimir Panteleev <git@thecybershadow.net>
Date:   Wed, 21 Aug 2019 15:16:11 +0000
X-Gmail-Original-Message-ID: <CAHhfkvw47KtGgFRbqRQriPe6C-qaFDVZPDZhZNafdA8QdKGKjA@mail.gmail.com>
Message-ID: <CAHhfkvw47KtGgFRbqRQriPe6C-qaFDVZPDZhZNafdA8QdKGKjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: Simplify parsing max_inline mount option
To:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 21 Aug 2019 at 14:35, David Sterba <dsterba@suse.cz> wrote:
> match_strdup takes an opaque type
> substring_t that is used by the parser.

Sorry, how would one determine that the type is opaque?

> I've checked some other
> usages in the tree and the match_strdup/memparse/kstrtoull is quite
> common.

Sorry, I also see there are places where substring_t's .from / .to are
still accessed directly (including in btrfs code). Do you think they
ought to use match_strdup instead?
