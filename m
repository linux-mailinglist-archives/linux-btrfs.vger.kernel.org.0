Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32827179993
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgCDUKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 15:10:36 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35284 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDUKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 15:10:36 -0500
Received: by mail-wm1-f45.google.com with SMTP id m3so3213463wmi.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 12:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fpwa47Cv90yVr8kxSMxKL+tqA6sV31oIw3TQILqSgj4=;
        b=zKB6r7d/PKPC8s5xOhr1jJk/IroYVYdHAMvCA1IZPUvXtzjnhI6m1JTHzhgqBQ9PHL
         twJ8V4SHwpRyOjmNP9RDG6iHyAcvOmfGZYQ5i8zib03uNnL/LWPYvAa7skTzwQDDtgJY
         ocGH3Kxu0qDUXpA36/JQVtN93/qQTQlDEXgxTcjbPv3YHikWpTdY015Y4Cwo6Sif4Oqr
         UEDqZJm+lIhxmXLOoBSP2haD4uFwoc07fms8xljvqOZ495jK9qCCXdIGkzfYyKT8rbM1
         hWAYC462FFijZRI2Pk4KPA0NZTAJ6zU5wwTntIkv86j9oK4k9/BKZW21EtQ2wfDHpl9r
         VSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fpwa47Cv90yVr8kxSMxKL+tqA6sV31oIw3TQILqSgj4=;
        b=iWaSzjyFFwQOpRNFAW6NHhmrYwRwDlo47y0AOtvZnt9XJ/eQ5lbt9e/r54SjZWAuZT
         Hmx3Q35ALZ5R/lI6Y4pWhCBXO1KksnNzd6q/Qr78i6g1Gm7bUA5p62ozX1Xg+HDnZANE
         29vaFGVqwwCK1UjXyZYbXkEXh0h/U1wrUFZutjEcXkKPapQJeEO2zJU0qjdvDOMFR2NB
         KFrnkfuBDE03Q8zaFpDBCJlceNaJy1JXM1xkrq+MFlDB+mkYgstph2WC+Dk4P1szBe+J
         fHoP3jaqPttPJwdGnhKSwvMIM+Av4IXyqMtdg950Yufr6IR9yh59uwltF7b7oC5X7fNU
         1u9g==
X-Gm-Message-State: ANhLgQ274nQgAsH6dbRpV1TB0Hntun4NFBAE3qhjgS0lAIu3StIPeZOg
        ucca+Qblx7yXNTE5iigS9kY2/vx8+1dFnqEJDwxXkw==
X-Google-Smtp-Source: ADFU+vuWt8jxNhmPYg3SXoc+07TzPTZ6o+DB9qhQpNVAwCHuALT/UCp7VlmIBo4/34pepWkAIViZ7AqKprucbTo0fwI=
X-Received: by 2002:a1c:a50d:: with SMTP id o13mr2025780wme.128.1583352634309;
 Wed, 04 Mar 2020 12:10:34 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
 <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
 <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com>
 <CAG_8rEf-kdju-OPhVUVWF8qNMM=xiUnWuBgODiwzGnRMzJYNpg@mail.gmail.com>
 <CAJCQCtTz-KW4WLJtcX9NGSPiCmCZ81_bXE+YBhn2_DocvnefZw@mail.gmail.com> <CAG_8rEey=ZNbrJYKNiyvt0_g068_Bu=XikCs=gQwd=ROQ2y50w@mail.gmail.com>
In-Reply-To: <CAG_8rEey=ZNbrJYKNiyvt0_g068_Bu=XikCs=gQwd=ROQ2y50w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Mar 2020 13:10:18 -0700
Message-ID: <CAJCQCtS=uxN0ONokx8v1M24ibJ0vxKpxKajsdpB5dCsy3Ccsaw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 4, 2020 at 5:45 AM Steven Fosdick <stevenfosdick@gmail.com> wrote:
>
> > The most obvious case of corruption is a checksum mismatch (the
> > onthefly checksum for a node/leaf/block compared to the recorded
> > checksum). Btrfs always reports this.
>
> And it did, but only for the relocation tree that was being built as
> part of the balance.  I am sure you or Qu said in a previous e-mail
> that this is a temporary structure only built during that operation so
> should not have been corrupted by previous problems.  As no media
> errors were logged either that must surely mean that either there is a
> bug in constructing the tree or corrupted data was being copied from
> elsewhere into the tree and only detected after that copy rather than
> before.

I'm not familiar enough with data relocation tree, all I can do is
wild speculation: It could be the reported corruption, which might
just be reporting noise, is a consequence of the stalled/failed device
removal, and that the actual problem remains obscured.


>
> > So that leaves the less obvious cases of corruption where some
> > metadata or data is corrupt in memory, and a valid checksum is
> > computed on already corrupt data/metadata, and then written to disk.
>
> But if the relocation tree is constructed during the balance operation
> rather than being a permanent structure then the chance of flipped
> bits in memory corrupting it on successive attempts is surely very
> small indeed.

Probably true.

> > I don't understand the question. The device replace command includes
> > 'device add' and 'device remove' in one step, it just lacks the
> > implied resize that happens with add and remove.
>
> When i did the add and remove separately, the add succeeded and the
> remove failed (initially) having moved very little data.  If that were
> to happen with those same steps within a replace would it simply stop
> where it found the problem, leaving the new device added and the old
> one not yet removed, or would it try to back out the whole operation?

Yeah the replace code has its own ioctl in the kernel. So it's not
entirely fair to refer to it as a mere shortcut of the add then remove
method.

First data is copied from source to new target, the copy reuses scrub
code, and the new target isn't actually "added" until the very end of
the process. During the copy, new blocks are written to both source
and destination devices. Only once replication is definitely
successful is the new device really added, and the old device removed.
Up to the point where the two are swapped out, the source device is
not in a "being removed" state like the add then remove method.

The device add then remove method takes a while, involves resize and
balance code, and is migrating chunks on the source to other devices.
In the case of raid5 it means restriping all devices. Every device is
reading and writing. It's a lot more expensive than just replacing.


-- 
Chris Murphy
