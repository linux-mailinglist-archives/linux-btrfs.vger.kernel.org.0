Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792492F2F1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbhALMa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 07:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbhALMa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 07:30:59 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2DC061786
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 04:30:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so1402638qtn.4
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oaBhRyKqyoECN+C2077UTyM4N4uBujcmtIWH5nCtwdU=;
        b=SPOrlnDAnEwJgAkNQiZUP5Wi3YDy5bTlfIk9PdvbidJ6yNTMqWLfF0SprP3pBQBxFL
         y/+yu0gPwkSaUJWZ0piDvOlYbcz16kVzAzA49IoxHLneo2pYuUMowPzznJeBmmiU9EZt
         p04w98CYwnD1wJaq9cDfNoN5CrTLaofFYbSg7LFSayXSsYSt7lwUR9UVsZOcHP07Amrj
         uh7gVWtjCBZtEgf/DBoLXINGz8KEMx2wTAifuI3yY6zFet18B0yyXHovBrBU7yQcrMpS
         QD6JqtN8V1wO20+grShEG7dVZ5WCej+ZVSIaMrLBtzDxYuiC7jSsAreVobdOUt5P1XfR
         oomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oaBhRyKqyoECN+C2077UTyM4N4uBujcmtIWH5nCtwdU=;
        b=CDPxWEyZs5R8qLDvYRTV2+O98knl7/c/qJl141TKtvr8ZJNmb45h4Z1CdMhHD/qYJY
         l+YaF23FbpiOJphMo0IFWWfsnTj1TNKptvasGaRTM2Z57aPtLTEiU986FtQJZotUBfYk
         kb3e73x0J1fho1j1Uxpbkz4c4edxT2VxDlIr8kWKhyeOK+f+F1y+nFVT0a2S3TbiGtkA
         57WKCk0xmJ1l/8c17Qz4Ov5ovQYBStxg/3WlSFNBgtpFmopJpWEJZxX9uyZVZFRtWnMI
         pPpMOe/2rsNsZEV+kIspyshWTYRN1vOmlVKCo+jKDzV0CJDoLFlbn/DTRjsLpYAykZ5i
         XxVw==
X-Gm-Message-State: AOAM530DWorNyNsFYdu0zDB37t6fVuETUXQC+5fh4UNisXwHowBXo4Kd
        A1UGn6ekgLhgP8QQ4knGKh2kA9t4th+BBOzAB0w=
X-Google-Smtp-Source: ABdhPJw276GmM2mhLsrSrfXgMfXHRjkwWDdd/ScWYWPUueFDWy1iSL1cyoyDH9x3+57jHcYQET22msDEsCGiKekB4XI=
X-Received: by 2002:ac8:4c82:: with SMTP id j2mr4442187qtv.21.1610454616666;
 Tue, 12 Jan 2021 04:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20210111190243.4152-1-roman.anasal@bdsu.de> <20210111190243.4152-3-roman.anasal@bdsu.de>
 <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com> <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
 <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com> <021cb9f5-4dcc-6c5e-f911-12add5bb95c4@cobb.uk.net>
In-Reply-To: <021cb9f5-4dcc-6c5e-f911-12add5bb95c4@cobb.uk.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Jan 2021 12:30:05 +0000
Message-ID: <CAL3q7H5FhpCTkhNF_5RZQQDxB+b4ReFXbo_TySPNDre+P4f+8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "arvidjaar@gmail.com" <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 12:08 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 12/01/2021 11:27, Filipe Manana wrote:
> > ...
> > In other words, what I think we should have is a check that forbids
> > using two roots for an incremental send that are not snapshots of the
> > same subvolume (have different parent uuids).
>
> Are you suggesting that rule should also apply for clone sources (-c
> option)? Or are clone sources handled differently from the parent in the
> code?

No, I'm not. The clone sources are different, and are used only to
find extents for cloning and not for computing differences between
snapshots.

The exception is when -p is not passed to 'btrfs send' and one or more
roots are passed to it with -c, in which case btrfs-progs determines
the "best parent" - so it would check as well if the chosen parent is
a snapshot of the same subvolume. My suggestion was making this on the
kernel side, just in case there are other users of the ioctl other
than btrfs-progs.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
