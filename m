Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F2413A65
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhIUS52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 14:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhIUS51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 14:57:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B80C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 11:55:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d207so1114319qkg.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hSTUcEZvrMf1EBtr66pZqqxwcpjqQczxwIpt7Vlxjow=;
        b=4sKv8SlVFHOJC0tCZe6FlJ8jZm3rPhKdoBrHNQe3mZC/da91V7qjZq5VRUAEFCX+RS
         8auRwOgz2Nf+0GZiDhg9gGTr2A9+Hrnq39ZT2ysuFojz5WDyKKxu65LQIS00kf+0PO/j
         YfCCphGPAH9i5Jji8PX9mZ0XbVVFj1gMBuo3IJJzeo4lP5VWH++YgXjFAFL9IPD5t0x/
         tJlPyxfoUOgRnzjzFCLNpAQPZg2SrKC2RnY3znRLJToPi99pcs0f7a7xMnyizUE2DgLa
         6qWh2NhwHJEAgYisn65q4zSZ9oqdo+YZ2/dd6rLgeA9u4Tu7SF1VqAsmRkyOun+glShk
         Qpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hSTUcEZvrMf1EBtr66pZqqxwcpjqQczxwIpt7Vlxjow=;
        b=gtK8sHyFOssZlye07iAW+iNu/zAHLMfaqTll/RrBIUeZNaSWW0DhNYCWm0Y4j2jEz9
         EFBRP5CRve6LVGrTLWXkf5gs42XZgC+shNehYAHJH5Gp8v0rmMRSLN6EduI79eV30zik
         /E9EWtCwqi0fjOHmnkHXriMT9IkXj3CGznenYjc9738czxY4Aztmei8hx1G1JX1mflUG
         94HIAMednIEYZifdYT+rMtnp7q1JVfhTYgPhS2rcrdnZBntVmZU0j9aorvu4qszUWqLX
         KMOs3xd34pmrLELKycauRNm2lDI9XsQG1z3HqLwGo9DzP9fa82N+xPfXPzmqbShEaZZ+
         JY1A==
X-Gm-Message-State: AOAM533vp3uUFySXtz/gq93ul+x74YvVz9tP8rsMUHWj1emRLZyfu7Lp
        uAYlWjJtYPq2Qk8jK9zDMjYMU2hTWy7Drt8EM+FToQ==
X-Google-Smtp-Source: ABdhPJzkj/MN5mQW03TNrtL85q/mq1MUub3sehyWWor5o1ND+Px044yCygQCLesM6mVhR+SXVa8ehi5vgACND4iqB6Y=
X-Received: by 2002:a25:d801:: with SMTP id p1mr27332021ybg.391.1632250558016;
 Tue, 21 Sep 2021 11:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQsqsDwzUegUgYAo2PccUP9q=DKKA7kUNtRcbttW-nQrw@mail.gmail.com>
 <20210921181705.GP9286@twin.jikos.cz>
In-Reply-To: <20210921181705.GP9286@twin.jikos.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Sep 2021 12:55:42 -0600
Message-ID: <CAJCQCtTCYFWRDicKc1t7ACzB=Khr0Km64Ps5EPuZ50TSPLj=LQ@mail.gmail.com>
Subject: Re: aarch64: Unsupported V0 extent filesystem detected.
To:     David Sterba <dsterba@suse.cz>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 21, 2021 at 12:17 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Sep 21, 2021 at 11:40:17AM -0600, Chris Murphy wrote:
> > Downstream bug report with a 5.13.12 kernel.
> > https://bugzilla.redhat.com/show_bug.cgi?id=2000482
>
> The report says it's a fresh filesystem so it's not like that it's an
> ancient filesystem. As it's on ARM64 machine first hint would be some
> endinanness issue but we've been testing on that architecture for a long
> time so it can't be a new issue.

I'll ask for more history in the bug.

-- 
Chris Murphy
