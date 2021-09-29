Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66141BEF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhI2GLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 02:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbhI2GLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 02:11:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56815C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 23:10:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x8so774644plv.8
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HeFALDmLRqLdf6DO7VE+A0PqbEa69EvicgzLCuW8C8U=;
        b=dQHbE+QUMVJzwEGSnxsUs++cydupOWOd1nXnEQMTRlmtFXLlMeoblHeryRFVdn12vP
         ++Oa7TQ3yjYkqLVZ4RgSvVqLhNnlMoQLr80DY5vjYK3JACRmbcC44YmKgelj6KJMu2iV
         A9pnNSY60/GI4nz7cANAlHD/FT8l6RZhNXR1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HeFALDmLRqLdf6DO7VE+A0PqbEa69EvicgzLCuW8C8U=;
        b=ocKgZatBvixEhSlgfu7GGRk3lPHcc8+0nrE/kyalkLsXIXcuNtqcSnuiF2jvteIZtR
         P977ODGiq2Sj7VwGSAob7YcH6lG2IytNNy9twcGknS9oxD/1ertQHPwHy89GeLyzwo5y
         mKGn29ob2d/tuQhgusf//y6krYemDkVBEdw6lAKKJaoT6CnAV/Wn8OfEEjrKMVmP4o4o
         nbkLqt8hwkn9ROEoCviJ5i/hCIXyLxR5qcblo187YsYDR9Yh/f8Pv0xDviaWY/71Q2VS
         +Ss3B26A4VmptZZfbPvLoEPurxXhwpsYIW14VvrrlWSdZhs9IdXTpVSq9o/UBXG/O9Zv
         yxdA==
X-Gm-Message-State: AOAM530T8PyGSCnqcPXIxADhXpX2DyXpLXQA7LgTJml+/PJi+g+9iV/8
        v1WeHVJSHo5KPOC+517nw4xvxw==
X-Google-Smtp-Source: ABdhPJxqWbSgSbiRRi+SzpPZDPeOrbBXcf7AtcR/GTej90LhOvOsPLIyBs6vpY6msNRy1GV/2i0dpA==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr4499829pjy.137.1632895807747;
        Tue, 28 Sep 2021 23:10:07 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:d5fe:1184:e72f:2c2a])
        by smtp.gmail.com with ESMTPSA id m20sm1271138pgc.25.2021.09.28.23.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 23:10:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     The development of GNU GRUB <grub-devel@gnu.org>,
        Grub-devel@gnu.org,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>
Subject: Re: About the code style requirement
In-Reply-To: <d7af6d9d-7178-f950-1934-3179e001e291@suse.com>
References: <d7af6d9d-7178-f950-1934-3179e001e291@suse.com>
Date:   Wed, 29 Sep 2021 16:10:04 +1000
Message-ID: <87ee976hfn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo via Grub-devel <grub-devel@gnu.org> writes:

> Hi,
>
> I'm recently considering to cross-port btrfs-progs/U-boot btrfs code to 
> GRUB, so that we can have more unified code base, with more features 
> (and of-course bug fixes)
>
> But the first blockage I'm hitting is the code style.
>
> It looks like GRUB is using its own code style which is not found in 
> kernel/btrfs-progs/U-boot.
>
> But I didn't find where the code style doc is, so is it a hard 
> requirement to follow the existing style even we're cross-porting most 
> code unmodified from other projects?

It's largely based on the GNU coding style. The `indent` program can do
most of the work for you.

Certain parts of grub that are imported more-or-less unmodified do
follow their own style, e.g. grub-core/lib/json/jsmn.h

I'm not a maintainer so I can't tell you how hard the style requirement
is.

Kind regards,
Daniel

> Thanks,
> Qu
>
>
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel
