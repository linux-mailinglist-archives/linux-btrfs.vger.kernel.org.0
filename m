Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829D437B06
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhJVQit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhJVQis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 12:38:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212FC061764
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 09:36:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso232864wmd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RbU2zIaT/pppMmrpfdMqJ1C/9TMMeqhfXMgWUvrbCTQ=;
        b=EZXrFHRSdtqHc4pRBkWwWYkFK01nOWrnR2LZJK4bVwql/VY+DX97UHyJXZ5GYzqTKi
         4z7lPqBb8xDU5aOeeTMXn5BNClh75Ow1bAuD8VBuUE9UW5C94FS+m+qvfN1QOZ/oQxai
         lGdoOEQjS03PvYBYu5RmXWff4tQ9MepYf9KMd7+JrGbE61cmfWfO496VZhgUugOQG8wV
         9iTAWjHVKE3qEGhJzNWTiJpgsnDyDtcOXnKzqrj3b15GyK7onjpxjU1yY/kj/8OiSvsM
         eGRrUoAedjce95CEIwq1gXmaN6W9paWb3V5QQ38MAMvpCwxJLpkxLBwFg6bQHKH6iEhj
         fP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbU2zIaT/pppMmrpfdMqJ1C/9TMMeqhfXMgWUvrbCTQ=;
        b=GXS7dAxKDpRD+S2hPIqayyQaBgCYB5cQ+dRow/01zEPZEsBQCtIFnPysvSHZEhrhjq
         kkPURFXii9GgUPrur8H3NEpwiV9OMv7kvIgwryqwukkeE6cb6v63XZa35fteVg17EvWi
         VkQ1fSAbBYlteF7+/pXZ3RdXvnIc0CPvzHf6zWV1JAB3zBNBj5yT4JXcmxFkvT0i2yOs
         EUtNlIPxAQJLvWnCR9KD77M+efsGqf+jo9j8Wq77qMTkW/4eJxk253aEMfR7aGZzsbV7
         fPht5fCmrwGkLsekBYFXD9S8S4hCXo3GU1TFCil3SPnayzx2+FCeOF58fSGQZwGj4v2b
         0Rig==
X-Gm-Message-State: AOAM530+BnYCDB+qVMJT8rXvc/t+LOmK6jM7sd0W8DOIzInEfcOm+zMZ
        hIO431TjcraJ8KQ/D2riy2E=
X-Google-Smtp-Source: ABdhPJwx8ZDu0BkRxyJvDuLyhP9U8YLhnIIwPz5pqxeLocj8c5wLsB5bv7bPhlUpwGKydiS2X8vVfw==
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr833740wml.116.1634920589051;
        Fri, 22 Oct 2021 09:36:29 -0700 (PDT)
Received: from arch.localnet ([213.194.148.250])
        by smtp.gmail.com with ESMTPSA id g33sm7528124wmp.45.2021.10.22.09.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:36:28 -0700 (PDT)
From:   Diego Calleja <diegocg@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: btrfs.wiki.k.org and git-based update workflow
Date:   Fri, 22 Oct 2021 18:36:33 +0200
Message-ID: <12904812.uLZWGnKmhe@arch>
In-Reply-To: <20211022141200.GK20319@twin.jikos.cz>
References: <20211022141200.GK20319@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

El viernes, 22 de octubre de 2021 16:12:00 (CEST) David Sterba escribi=F3:
> Current status is quite unpleasant, the number of active editors is 1
> (me), with other occasional contributions. I somehow feel that the wiki
> concept as community editing does not work, specifically for our wiki,
> or maybe in general, anymore.

I would like to mention that I have tried to edit the wiki a couple of times
along the years, and somehow I was not able to get an account,  log in, or
recover my account (if I ever created one). Perhaps it's just me and others
can use it just fine.

In any case, it's worth noticing that the ext4 and xfs wikis are in worse=20
shape, but with the improvements to the kernel doc infrastructure,
at least ext4 maintains some great documentation there instead of at the
wiki (eg https://www.kernel.org/doc/html/latest/filesystems/ext4/index.html)

It is also worth noting that while the kernel wikis are not very active, lo=
ts=20
of semi-official content are generated in other places (eg the arch wiki).

Diego


