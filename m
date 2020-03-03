Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88169177ABE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 16:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgCCPmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 10:42:47 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36502 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgCCPmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 10:42:47 -0500
Received: by mail-wr1-f42.google.com with SMTP id j16so4964352wrt.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IG+YmHrJPcyOyHqglHprZn3y6XRvEcQSEcpWB5o/+E4=;
        b=Uc2iexDfobDybO2qUYW4R/2CgfiZLtZyU2dhVf/5FLPRnXfvQlrp57Hp21wkddEbks
         RoSbSGPDC3NkZjbarZRy/c8fR6GV5GUh03VwsG2RAehyIuldvLfGf9i9A8HWgSkza1y+
         vEqe7kHHcDS4d81tbgditssephisDHjzp/yfGfjVG7jmlWOGBogszMsBNxk+Hu7ukAxo
         5ajuqITYwguk/GTPThyPlP1yIPxNVmI1ytzePocMw64zQt0uGWCVI957CmrGsTdbErJG
         +K9baD0j7rO35mYrUqdbFKvVc2L/m46R8BLuNMI9Y5Vh5XCtclzLAqm6cjv2KvkLcmUo
         5ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IG+YmHrJPcyOyHqglHprZn3y6XRvEcQSEcpWB5o/+E4=;
        b=DJ8SwPlzcKcyN012NtFpmQKY0C2oAmur1rjKStGM/mhCR9DxHPIRu/dt/jIyi3bF3D
         LngWRsHO+bRqRSUOyLLDAOjWV80QTy9e1qOhs9SQXgeX3vyoI4riG+gVO6m1rQeMOjj0
         BLhFVaOVUmBZISteXMO0JayqB3JLMQe8zBUq1Rj+gvtDOIOShxf6gNf1SpLbGOKzf8h2
         XNMUwVl/gsyNSHPEyJhdRDSy3CNI4k9I7xztkFS2UAsOuSUrYO11zqwn4tCiqjjkmIvg
         Q4+bDezWq5btQI7T8khhzKnCdjmhdTio6QrfBNrgtiKdlEZ1Q1UwqUMoGfrkgyjdQK6p
         HUYw==
X-Gm-Message-State: ANhLgQ2wgHWmh5vcAea/HiGYFO+kfg/kxs2MIt06epOnMr+BFY5KrZd8
        /7egAAEKUSPiIkBOcnq2ISQFdIEgVbd03K/sUpFU
X-Google-Smtp-Source: ADFU+vtHLm7n3DwObk4mTTayOgFmk7vcbwvWubfjuKllVWCJVdw8Q4BppJWaT7QFaxkA9IVI/4aBi1T7Nx4J4cYm1xs=
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr5797123wrs.231.1583250164816;
 Tue, 03 Mar 2020 07:42:44 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
In-Reply-To: <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
From:   Jonathan H <pythonnut@gmail.com>
Date:   Tue, 3 Mar 2020 07:42:17 -0800
Message-ID: <CAAW2-Zd4jGOBK6jxpqbOfwACTYkDg6Ep-EZ9Ejy7RuJEQn9F7Q@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update:

My most recent scrub just finished. It found a few hundred errors, but
many files that were not mentioned by the scrub at all are still
unreadable. I started another scrub and it is finding new errors and
correcting them, but I aborted it since I do feel like constantly
scrubbing is making progress.

Much more interestingly, I ran `btrfs rescue chunk-recover` and it
reported that the majority (2847/3514) of my chunks were
unrecoverable. The output from the `chunk-recover` is too long to
include in a pastebin. Is there anything in particular that might be
of interest?

Also, I take the existence of unrecoverable chunks to mean that the
filesystem is not salvageable, is that true?
