Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBF2C86AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 15:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgK3O2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 09:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgK3O2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 09:28:11 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55BC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 06:27:31 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id o25so14326720oie.5
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1fAdtTgmor0QHGLm6iS2IrjjfV0jfGdvmvEnU6/Za0=;
        b=RQf/QO3f+UkceyDi6cQ+g4eKSKUrEqn+d1v7+Xp2Pa/isZRRY07B5SfpLlZcQftaXE
         sIq3k9cP345192u4STJmfpuL+HC3dqow6X5Sa/4uOjWoi3qFyz8o03bKjqvbbynD/Vlq
         5sOPFrVQz/KHlfmoflVrta+7uOP4A8OYJPpGQuuuIPyor26N/twETgEXM77I0tnNr3iW
         646BR5475/KRXBYevIqmeNeaDXSKSwD2ZJ0g9uHfuscFWC5ADHy2A9BYwN7Cmw5/JbXn
         Rfjl18WoT5YV+2lv8emTMZUNWYKmjV+jAdCb7TGyOMtx3aLEg0Sdt2gUTRfaTtj7W8Op
         rMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1fAdtTgmor0QHGLm6iS2IrjjfV0jfGdvmvEnU6/Za0=;
        b=gBnn1xTpw9LrpRHMeIY7MftBPkb3fGL5/wCxUKOJT1wHQ2UFTFtKTI7PRBqJu7cQQl
         oRJ24MRzAb7oGQ4YscvPJHKrJDczbXqhNOWFSLcvk5e+fEidfPa+ICsHi9zrjq42viML
         DFxwnFStWCqUif4mKQfLCbsQGNGjSKSXbC8H86HCHsPKX18RQdBcWX9id0adUAK0LTSn
         +1pZdRZ74HlTHpJDKnmWCc/fO3x4LWZ3kNKVBn8JiW9ECEAaSJzUU+V/NUesCA4l7hJD
         Cv7IqLKJ86cfmLvyHYGK4wMlJCrEB8hwrP4rAzFzvfc0L+Z77lyMrEBTeicLeMnbHZmd
         pfHA==
X-Gm-Message-State: AOAM533BdCI1vVMvtoxD6Tqg5K7ZkzvjKPInaNFqCi5xCvyyn7886o+t
        KWIFCQn0EoJJ6KejQdF5R/3KXAtM7Xbgr9saa5M=
X-Google-Smtp-Source: ABdhPJws1bSeeSW23EWPEPHWtatMYV+nj1FxeFTnvf1g3QJWmQUYhM2VXzBidbz7xYzRd+YNkRQj1v7MMeWk6YaFc5E=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr14288487oig.161.1606746451112;
 Mon, 30 Nov 2020 06:27:31 -0800 (PST)
MIME-Version: 1.0
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
 <20201130190805.48779810@natsu>
In-Reply-To: <20201130190805.48779810@natsu>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 30 Nov 2020 06:27:20 -0800
Message-ID: <CAE1WUT5Vwu90tgJUJWJpOZx2uRdoRA7G7OyGSFVOh8pDrjMa-g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 30, 2020 at 6:12 AM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Mon, 30 Nov 2020 08:46:21 -0500
> Josef Bacik <josef@toxicpanda.com> wrote:
>
> > However some time later we got chattr -c, which is a user way of
> > indicating that the file shouldn't be compressed.  This is at odds with
> > -o compress-force.  We should be honoring what the user wants, which is
> > to disable compression.
>
> But chattr -c only removes the previously set chattr +c. There's no
> "negative-c" to be forced by user in attributes. And +c is already unset on all
> files by default. Unless I'm missing something? Thanks

Yeah, I must be missing something too. It isn't normally set + you can't go
negative...

Best regards,
Amy Parker
(she/her)
