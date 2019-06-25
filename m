Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA552060
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 03:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfFYBdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 21:33:41 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34384 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfFYBdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 21:33:41 -0400
Received: by mail-wm1-f49.google.com with SMTP id w9so1127884wmd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 18:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=EuuzUnFtk+9or6i3VfEhLfwclg30G20bRtm78QpQzBA=;
        b=Y98hXcBOTMvB9/v89GaLWqEKZvuEAbvNuPWlgBxKOAF0GrgZhXvjxibIedPz/T/NK8
         64wtmz2z4vuBZalpBBTQIC8/7Hg/7O8e9VDuDrSziV7q6VYgVqN5eL5otWbNk+MecY8V
         Mi8ZuFv2OjX8mwMPG+4K8IJAboyYcuua6JLiPQO8ebxReEnlqAlaI5IDUcaCxSgkqFOG
         r1n1Tkh/zKygYZA1dP6T0BbTfSaC5Fqm2XoVgZv54/eMZCz4nxKFQYfY9OVMmZiS845i
         FYXJk4lWm7+dDvFOKSTDpaHkDv45/KBShigsKaHQhA60/k9bSKTDwHwNlAdvDdOh1XEb
         YTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=EuuzUnFtk+9or6i3VfEhLfwclg30G20bRtm78QpQzBA=;
        b=anvF+mmz7XbJb1h32P3bJqIhjfkXeISSoaFeTxyLjAviwPKpn57HcL/+WjIDjZ1jVK
         dUf/F4e8OwczWhGIuC8fnfsZ/87qmIQnLGt6zBCoVjqhbE1J72JlImqcDMSLGSSUXfSq
         2rqhX1+m138/mkOzF3ZfUwIyxoRTSh9DavpYbzDpsKu/hYOsQTUGBAAZkiIYjsGx/R6B
         FIkeFCiWH0KGPf6pe4YCkdmRphhZEbE+C62oh89GVp+YSbpRSTG9mOS9wGMBFhW6orZw
         9fMQKUxMY9RV72Z5tlfkYcHyqpCO885F7hD5dHy4atbh/EqsH6rsyp7KF2AXQBskj3Ce
         3xoA==
X-Gm-Message-State: APjAAAVSYferlShtShmVMEi5TIyEqKnFZVd8gGDrG9hEE1J6BUCRqnlc
        FBIzhlShSfH/Fo7LH61tQ83hBSO55Za3wcdMMi/j2wDTaQk=
X-Received: by 2002:a1c:a997:: with SMTP id s145mt15245230wme.106.1561426418778;
 Mon, 24 Jun 2019 18:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com> <CAJCQCtTdnZFjwsKaEV0Z6bPK+L2mHLv6=zjgrVt0G1ei2AXq5A@mail.gmail.com>
In-Reply-To: <CAJCQCtTdnZFjwsKaEV0Z6bPK+L2mHLv6=zjgrVt0G1ei2AXq5A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 19:33:27 -0600
Message-ID: <CAJCQCtSDWsq9hSm-SdNmOqCC4+AsNOzLT+y9n+cy+a8Nbp7V5g@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 24, 2019 at 7:01 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Anyway the problem looks minor, the file system itself is fine. But it
> does stop the startup process.

Ahhhha! I was on "autopilot" and made the root read-only. And that's
why the startup fails. It has nothing to do with the compressed nocow
journal files. Hilarious.


-- 
Chris Murphy
