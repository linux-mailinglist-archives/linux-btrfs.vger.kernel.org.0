Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2236917175C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 13:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgB0Mf2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 07:35:28 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:36919 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0Mf2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 07:35:28 -0500
Received: by mail-yw1-f47.google.com with SMTP id l5so2843397ywd.4
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4ppvld5d9koez3bBkrhPN4iqalvPrHJS3SsVmaA9zU=;
        b=UCSuvCulH8rBVoVWFMgZiq5XuL+6YG4Pq/OxSJOeHg8tVg/hfbHsXgdyAgJqsJ8zkY
         o8mk87lkoOawSRlqnSBYGjq/3M7K/Z6IzXnzLIGGNlMqodmfbIH6uG4g1kgFdCt8hgrq
         kKUije3l3MHQIKmIy4oYIQUNLbJ3SgmbRtxXi+tUDSPspoYcaQBlgrRajHt/7+R6TMQ0
         XgHWYpTEYfg77JtRuBsyHfMAMU1ZkKid10XeJpux6TitvTRqmgHVoEQ7ssALrKQeGU+u
         vtAe94CVCdo9tM5NzOKxlUbVJKEEvW6fchuX1cM3qMVCGxggGscoQQ/JRtO8FcgxbpWD
         Tx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4ppvld5d9koez3bBkrhPN4iqalvPrHJS3SsVmaA9zU=;
        b=qw7R8qEvWliB1D9jYEAHpibi5Nv1T4WTRTym1kV2u8DD2degeZNje6+McmfDVB/mnF
         rp5Yr3K8OdB63xDypCQVAAuMc4jsipJumh2Sb5ZQr/LM7kVcTMg4bS19prk9pAjf5C1i
         cfV0PZ06gQOuLsyfz6KZxDZjYVdZY9qp/cdV1CLlEiXgeGgyJ+V//HMzd2RxyEhSPLhM
         m0a8fDpa04qMKn1uwphSUJDS/arAcqR9Dn4KC9HaaZM38e6TM6UY7SweQ/8DtiMg6hRu
         Rd2glTUWlL/FaMd6qGwtxnKCXRPZXz2z2RvaJPu4JXtoFbXZWomf7235PCnNlPlqE6uq
         7gLQ==
X-Gm-Message-State: APjAAAVg8wNcT5WSbASLCeyuJJ8wg3ufQ78Tv5q0za5xpNCZTt+YThKl
        HfAcpavHWaAi5eHvtJBAwflfIvNwZiza9sN9G6ba6Nwd
X-Google-Smtp-Source: APXvYqyr1CLU7h2ODvw6L8T4nFKRZc6gmT8TgyjgFFw1KrXeivy3Z7br4j7g/r+nn3dm3OkwmrGSPVNmFhv7g6lPv5I=
X-Received: by 2002:a0d:f685:: with SMTP id g127mr3856983ywf.412.1582806926829;
 Thu, 27 Feb 2020 04:35:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com> <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
In-Reply-To: <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Thu, 27 Feb 2020 12:35:15 +0000
Message-ID: <CAG_8rEfy11fU+uTLz_KtYrkE6rrfHpdECR_HXQGVbBz-Efp7xw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris,

Apologies, I was half way through replying and managed to send the
e-mail by mistake so here is second half.

These are NAS-specific hard discs and the SCT ERC timeout is set to 70:
SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

On Thu, 27 Feb 2020 at 00:39, Chris Murphy <lists@colorremedies.com> wrote:
> > and at that point the device remove aborted with an I/O error.
>
> OK well you didn't include that so we have no idea if this I/O error
> is about the same failed device or another device. If it's another
> device it's more complicated what can happen to the array. Hence why
> timeout mismatches are important. And why it's important to have
> monitoring so you aren't running a degraded array for three days.

When I first tried this there was nothing in the log except the
checksum errors.  Nothing from btrfs and nothing from the block device
driver either to indicate that there have been any hardware errors.

I did work out what code was being run within the kernel, added some
extra messages and got as far working out that I found the error is
being detected here, in relocate_file_extent_cluster, relocation.c
starting around line 3336:

        if (!PageUptodate(page)) {
            btrfs_readpage(NULL, page);
            lock_page(page);
            if (!PageUptodate(page)) {
                unlock_page(page);
                put_page(page);
                btrfs_delalloc_release_metadata(BTRFS_I(inode),
                            PAGE_SIZE, true);
                btrfs_delalloc_release_extents(BTRFS_I(inode),
                                   PAGE_SIZE);
                btrfs_err(fs_info, "relocate_file_extent_cluster:
err#%d from btrfs_readpage/PageUptodate", ret);
                ret = -EIO;
                goto out;
            }
        }

> This sounds like a bug. The default space cache is stored in the data
> block group which for you should be raid6, with a missing device it's
> effectively raid5. But there's some kind of conversion happening
> during the balance/missing device removal, hence the clearing of the
> raid56 flag per block group, and maybe this corruption is happening
> related to that removal.

Presumably it is still a bug with RAID5 - given that there are now no
hardware errors being logged btrfs presumably should not corrupt the
space cache.  I can work around it, of course, by clearing the cache
but there is still about 65Gb of data I cannot balance away from the
failed device so that it properly resilient on the working devices.

Is there anything I can do here to narrow down this bug?  I probably
can't send you 14Tb of data but I could run tools on this filesystem
or apply patches and post the output.
