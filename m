Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185E422FCD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 01:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgG0XQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 19:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgG0XQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 19:16:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D4C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 16:16:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so9399790wmi.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 16:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjBBa6k7owo3j0jTBL4LEk7/6EIdKXldU5So+jKvskw=;
        b=ttDWz0UYolWhw7p+wcQv+wRUQgT0MjwqCkb1KH0tV2tOmcBFvzwJHFubZaki7QYLAP
         eoBtCryvbGmNgABXcvEwIfYMPvsCS+O5ck/T+ZGymQVUP1+2ZXytyWNGEh51hbiSIMpK
         8Mw4OUhyoZ+hQwtPFaUi/MtOZQpUstUd+EWDHgYbPff9rHnUdydQJZkN0idUP6jCrdI3
         SxW1MwsXwGjR1MAOcn47wZI77m/5P1atFEUwS6UqbXXsLfcMGkjtriz6yF3OvcfvRcTf
         0g32Wb7fwnoD9TK2E5r+KbtD+fHcVVwpfRKkLFPtGlf10mkV2zMr+iuqZs5RaARbpwy7
         rE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjBBa6k7owo3j0jTBL4LEk7/6EIdKXldU5So+jKvskw=;
        b=FcnjyrIyaGH8vNp9jhxfMXIO+pxtz/GSnnVdp/PAN0pu8cYiyvEZAKNDCAiVSm+xri
         1Ykryx5Q/j5aRn1/LPADp1LJSh4v55AeLsUCQmpLPIqPTOHTFFL4DuBBXUJDS1J3f98z
         xKSX+6HpE69izgUnbbpyOSpOUqG3xtKOvFH2/XRLWQpOzv8UJ4HsgxjN9DLwVvoSIMDe
         fOj35ixkYfXEHXRS8+woYhnQYSby7VO+7DcQZehyYWpKDlhjPpB137l/RpYl04xkVi9S
         EbZuUlXo8UXq4u/ebtKDVOjMX7JNFGvtE10H0LC9xQF8ubXg+pdPP9Oj55TJCA7ky/f+
         B0yQ==
X-Gm-Message-State: AOAM5322nZ1W3P6f+gR3Pqr+VyRBIFhPDOK0+64WuOjyyqoxYkt9w3o7
        TRus5BzJvPP/VMgqoU2m4U/3PytdUb36FKq6naH3hQ==
X-Google-Smtp-Source: ABdhPJycpHM6Bk1e39ujyGwFLeln5JqBct9QfdEnzLEEdVTurRl2jMznUXLH0ZfmLZy5LQZUIqnxhQVMj66B6ayGEws=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr1294774wmh.11.1595891789999;
 Mon, 27 Jul 2020 16:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <f3cba5f0-8cc4-a521-3bba-2c02ff6c93a2@gmx.com> <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
In-Reply-To: <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 27 Jul 2020 17:16:13 -0600
Message-ID: <CAJCQCtTEjy2AV8k-eR6z5BjaegdeUMDqWMrfzO4f5BpfWhQO=Q@mail.gmail.com>
Subject: Re: Debugging abysmal write performance with 100% cpu kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 11:17 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>
> Hi!
>
> On 7/27/20 1:09 PM, Qu Wenruo wrote:
>
> > As you can see, there is no one named like "flush-btrfs".
>
> Well, I do have a kernel thread named kworker/u16:7-flush-btrfs-2 here,
> currently. ;]

On a send/receive doing well over 200M/s I see brief moments of

      0      0      0 D  10.5   0.0   0:06.15 kworker/u16:15+flush-btrfs-4

But it seems to coincide with 30s intervals, consistent with default commit=30.

Are you using flushoncommit? Or a commit time other than 30? Maybe see
if the problem gets better if this is 10s? I wonder if it just has to
long of a commit window for this particular workload?


-- 
Chris Murphy
