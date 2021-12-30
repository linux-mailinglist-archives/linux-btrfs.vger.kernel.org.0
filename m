Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA0482073
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 22:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbhL3Vrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Dec 2021 16:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhL3Vrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Dec 2021 16:47:32 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E1C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 13:47:31 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id o185so48703526ybo.12
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfEH+HhuRqsJd1U/QHsZdb/h379hwSWf0QSe4bPMups=;
        b=KO4e0w9k7829q5x72mQGCEVUXZUtJ7Qk0EyZ3ve76k95GTmRtgZAICeX5wzL0KmTus
         lvM6JPgFsJtD9Kwqft9Q/HPguQiYjpPHlD9YeSzlzWsJIQiNCYvZmauvaHx7gHVf4wpZ
         MBlN2u9gPzv91DLLhSrVuPIgdHz/ML+ZJOsd7yguEGAHiqQf996RSOandzoWOIgWE3Gb
         ysgiEXtL/tlb+T56W+H32+nI1ANb/HIi5fFW48qTx9KhnAb1WAv3G7rezHAzFZnLvIWW
         HLMS1VsYpLPmEyvU6aSKZQiodkuExdLMPo+GxGJMjy2/EUsTl6sZ3rRd77JnXTjrlC8D
         PM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfEH+HhuRqsJd1U/QHsZdb/h379hwSWf0QSe4bPMups=;
        b=zvQFlBS9WZCJaevKwB2jZ9lRqGYsv6ft5M+6mNhpZ5Rki/9KVmJB+4oOswG655Zmhm
         6tmKLo8PKoCQ9/IrKqnHcpHhmmTsiJXB3kQEvYtNar10KS1EUW97xf8uf6GRhFAdg0vj
         7PsSG6EmYtcx3WBAbN2iuvzr9dvN6/qqUisc20uVtpa7gnsQCkGtni28liNyWkcmFw0B
         UjdjpniFSQ1vA/Q2IlViwAPbDUisuSkmXAiM6aQORU271PPxqfHFYRpUIITt5T96k+dE
         S+ZwvdH+gc0AUN+D74SmVkfCp/KtcBe3BDnFsPZ0xA6pEE2wLa8j0Tvo8Mu5PN3q4TR1
         MPpA==
X-Gm-Message-State: AOAM531r4+YBr7A7OMrihhqMMGlwG1cxjKC6jmJAlLqPJt1tgL1VuBsZ
        AbuoJA8qDjnP7g4NIk1ieiTzCArS9HWpg8K6GmV45E9GPzK4Mw==
X-Google-Smtp-Source: ABdhPJylPMt767tFY++1qB4AYZPSnzbtCpzPRCoNvNH+jf2ym9u0YKbOhxx4ZObyNmEzngVUmRThE1drceWcDt0mLzc=
X-Received: by 2002:a25:abd0:: with SMTP id v74mr28263555ybi.524.1640900850920;
 Thu, 30 Dec 2021 13:47:30 -0800 (PST)
MIME-Version: 1.0
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
In-Reply-To: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Dec 2021 14:47:15 -0700
Message-ID: <CAJCQCtQ1v4_-R=AHXJXUTkCBtYLW+x09_1_bk67fP7Kf=12OYA@mail.gmail.com>
Subject: Re: parent transid verify failed
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 30, 2021 at 2:10 PM Eric Levy <contact@ericlevy.name> wrote:
>
> Hello.
>
> I had a simple Btrfs partition, with only one subvolume, about 250 Gb
> in size. As it began to fill, I added a second volume, live. By the
> time the size of the file system reached the limit for the first
> volume, the file system reverted to read only.
>
> From journalctl, the following message has recurred, with the same
> numeric values:
>
> BTRFS error (device sdc1): parent transid verify failed on 867434496
> wanted 9212 found 8675
>
> Presently, the file system mounts only as read only. It will not mount
> in read-write, even with the usebackuproot option.
>
> It seems that balance and scrub are not available, either due to read-
> only mode, or some other reason. Both abort as soon as they begin to
> run.

Complete dmesg, at least since adding the 2nd device and subsequent read only.
`btrfs fi us $mountpoint` for the ro mounted file system so we can see
the space available and bg profiles
`btrfs insp dump-s $anydev` for either of the two devices
kernel version
btrfs-progs version
make/model of the two devices being used

>
> What is the best next step for recovery?

For now, take advantage of the fact it mounts read-only, backup
anything important and prepare to restore from backup. Transid errors
are unlikely to be repairable. What's weird in this case is there's no
crash or powerfailure. For transid problems to show up during normal
operation is unusual, as if one of the drives is dropping writes
occasionally without even needing a crash or powerfail to become
confused.


-- 
Chris Murphy
