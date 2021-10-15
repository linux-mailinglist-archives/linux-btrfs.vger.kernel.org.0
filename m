Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E142FAC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhJOSM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJOSM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 14:12:29 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ACAC061570
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 11:10:22 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HWDp253QFzQjb8
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 20:10:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ltri.eu; s=MBO0001;
        t=1634321414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkrUiG06nv9Nmae35uOIdSYrMJxhW/rkh9aU12utUqs=;
        b=b/JIDFPNg9V+uzOIiFmKiL0NKi3w0zwQAOsm9cixcuiAPQQVT3wb7g52Sn+lC5GOaVdkSq
        mOMuThan6rMIOmawdY70ae+spUB5egokA3iRy9wNVMgCVYowgKNjnRHRyzPBicHVdu1iTR
        SzhF/61YaDhDVkUwbcGtK1kDasWhdL93H+w9y5aaP6lE08IgR+8MN2MHMsqSL4PTrPy+lc
        SNdl48VSvh8Yhi7PSQluNqp0R2/ynso60+/OENqmFoFHgHNl3XyiItclfaxAMwRZxoFmNO
        2k8DwtEvgp3p2+AKQJ54IDRSUN/u+krPXQUKRuy37one5FYF0abOoeYckja2mw==
X-Gm-Message-State: AOAM532VAe8B/4a1YRY2lS09I8zs9UiWgylE2HogMutpFwdttcX+l0mh
        1Kh3Vg3WV5LH3zBsEta2NY3zLLh8huRlJuLtf10=
X-Google-Smtp-Source: ABdhPJxZyY77uiVshFce0L35/jvBV2s9Wq2sCY6772o50wXpgDfjYQUwYDCPtJRDLxg5HbW+3DkGrCBLhHDWRYvN2+0=
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr4719386iow.87.1634321407728;
 Fri, 15 Oct 2021 11:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
In-Reply-To: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
From:   Lukas Tribus <lukas@ltri.eu>
Date:   Fri, 15 Oct 2021 20:09:57 +0200
X-Gmail-Original-Message-ID: <CACC_My-Nbu0Got+40x7hntN69-kek24YsmsDCT0wy7io_MCxdg@mail.gmail.com>
Message-ID: <CACC_My-Nbu0Got+40x7hntN69-kek24YsmsDCT0wy7io_MCxdg@mail.gmail.com>
Subject: Re: Ubuntu 21.10, raid1c3, and grub
To:     Jim Davis <jim.epost@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 97BE21813
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 15 Oct 2021 at 19:09, Jim Davis <jim.epost@gmail.com> wrote:
> Adding another new virtual disk to btrfs root file system and running
> btrfs balance again, with -mconvert=raid1c3 and -dconvert=raid1c3 and
> then rebooting doesn't work: the vm drops into grub rescue with a
> cryptic
>
> error: unsupported RAID flags 202

Grub needs new code for new raid levels in btrfs. Btrfs raid1c3/4
support was introduced in 2019:
https://git.savannah.gnu.org/cgit/grub.git/commit/?id=495781f5ed1b48bf27f16c53940d6700c181c74c

which is released as grub 2.06, but Ubuntu 21.10 ships grub 2.04.


Lukas
