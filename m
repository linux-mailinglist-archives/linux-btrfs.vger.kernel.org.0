Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927B749541A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiATSVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 13:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiATSVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 13:21:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC975C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 10:21:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so6582227pjp.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlfCSgochAjWVYabHDJc6Grx+KIR6kKq0QbpYssbC2M=;
        b=V8C7wLT4miJ+sKjagHFaTrzAUMOBCS+mLtux3aUkvBexPkBrd/V0W63oYD8NaADHN2
         8z2dTOcBno//MFqet/L3iYkk5qqmcqAD9T4aUXDRla6DXJUe/WE1J7btKMzrCN4efwcT
         uSxxU/98GUmBMJqk9ludJpoItvecijEY/9UX+aSAw266dbdqbDriDfMO05Mb7giepG1s
         7EAZP7tn9hks1dTINaot93GQjEhRkoMDPTt8F1zO/f+z9z8csnt7XOH0KLEddOhO+3Om
         YZyWdobj8mpa5qb3sXh4HHTlheO1rJcO7bffPypiKRVzgKtLyz/JReWQptuuzDqMSwcp
         0wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlfCSgochAjWVYabHDJc6Grx+KIR6kKq0QbpYssbC2M=;
        b=lHCFDSkLh3jJpT2IsZcNn7DLfYWu4FjcbxcQWfVP3//7D9QVwQLUjcm71zRiLnwWem
         5CVH5XkCfP/wZ0Z1Z1hhMzvzVjTgGh3imI8YgXXH84s9mEGQb/wrxm5jHkG0Qo+pa2IP
         mhNs6I/2C5xPZ9KMRk4kx3yUn7G4lk+fMxNdjkDzKPdT/h10ZMkS290f9k4V+LLo1h4A
         GnMUoxIlwlHbVmHOVfBWZOtgmBCNhXvvTE796fYufeghvmTRTSVX3dmgX34rDYo0W0P0
         ac0SZ/V5Uq53UhKcxHYLQkkoOuPz0YQs0Xrd8SSiKSyJqBLp1OiWT4v8tx/+VnIGf2Va
         bPJw==
X-Gm-Message-State: AOAM5332iBFvx7jekJ/A5xqlUE+Z9wNmZTvkRAXJXks/suijxot370bR
        qvUejwPSW5j4ZHGvXVf/3rXjwt7jfUUiJE1djLI=
X-Google-Smtp-Source: ABdhPJylb7cM7JEkcDO7KtT7wF1RCNmLdNi7HR4yVjruhrEw5/dfrohEXXmSdnc27IovRBtRJd0olHoZekf57WLMaf4=
X-Received: by 2002:a17:90b:4b41:: with SMTP id mi1mr12367720pjb.1.1642702896361;
 Thu, 20 Jan 2022 10:21:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com> <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Thu, 20 Jan 2022 19:21:24 +0100
Message-ID: <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Ok, so new patches to try

Nice, thanks, I'll let you know how that goes tomorrow!
