Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D89AD7F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbfIILcn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 9 Sep 2019 07:32:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35686 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391070AbfIILcn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Sep 2019 07:32:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id q22so7782022ljj.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 04:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8FsgMun2KShGa6ac76Dh5jCeuEqaKnCVziaJEG5KzVs=;
        b=J9gkwXWF0azonnmdNKwPMDdTVezc4y4MP86fsHlsPHJ1dRR43PqkDRegNwmL+jXBfd
         ynkcgB20cjvvH297WUvqdByw9kqfIFzNr7q69jrSF0W3LggGlbcYbbBDjQA0M4majMS/
         uKLDJeo3T8h7Hvv4zgRZ/HQA/QRWYmPmgegEH/bgR+rgB3WU0UN9+7w8F0W/b8F04XQG
         ifdaJ2WDMP1zPM3mMpZJtTaVPdxlw8oPu/6L9BxUyYzqVSu+NJw/B1NHU1EG853yhfBD
         dN0YLFHr4+0pPdH6YTWOGsS8WodMX3BuiwK773xom4/atJsh/Umu3vnaSPddObPt/4le
         8Zdg==
X-Gm-Message-State: APjAAAW2HhiuEBGfGU3voeCPTDGeYHj2VvoMP26NlLGZZXmnZ7aiOzpi
        XXjWwx/gKi3IOCehpcrc0lJdtaV/tIY=
X-Google-Smtp-Source: APXvYqyXl58YinQRpskn2W/FjE4StnvEnvGNaoZY+n48M4e2VC2CzDn+vBDABjEczPs2Oyw+7cqhJQ==
X-Received: by 2002:a2e:7410:: with SMTP id p16mr15869345ljc.186.1568028759634;
        Mon, 09 Sep 2019 04:32:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 3sm2894159ljs.20.2019.09.09.04.32.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 04:32:39 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w6so10212211lfl.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 04:32:39 -0700 (PDT)
X-Received: by 2002:ac2:520d:: with SMTP id a13mr16887581lfl.101.1568028759172;
 Mon, 09 Sep 2019 04:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190906095846.30592-1-git@vladimir.panteleev.md> <d8d7aef1-0d28-127e-ea5d-9ad1623afde7@suse.com>
In-Reply-To: <d8d7aef1-0d28-127e-ea5d-9ad1623afde7@suse.com>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Mon, 9 Sep 2019 11:32:22 +0000
X-Gmail-Original-Message-ID: <CAHhfkvyj6=aK2Jv8nXBFKnLhH7fgGfjhG-DVi6_Dmt2K6F1pDg@mail.gmail.com>
Message-ID: <CAHhfkvyj6=aK2Jv8nXBFKnLhH7fgGfjhG-DVi6_Dmt2K6F1pDg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: mkfs: fix xattr enumeration
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

Unfortunately, as I mentioned in the issue, I have also been unable to
reproduce this issue locally.

Please see here:
https://github.com/kdave/btrfs-progs/issues/194

The reporter tested the patch and confirmed that it worked.
Additionally, they have provided strace output which appears to
confirm that the bug description in the patch commit message indeed
corresponds to the behavior they are observing on their machine.

Perhaps the issue might be reproducible in an environment closer to
the reporter's (looks like some Fedora distro judging by the uname).

On Mon, 9 Sep 2019 at 11:22, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 6.09.19 г. 12:58 ч., Vladimir Panteleev wrote:
> > Use the return value of listxattr instead of tokenizing.
> >
> > The end of the extended attribute list is indicated by the return
> > value, not an empty list item (two consecutive NULs). Using strtok
> > in this way thus sometimes caused add_xattr_item to reuse stack data
> > in xattr_list from the previous invocation, thus querying attributes
> > that are not actually in the file's xattr list.
> >
> > Issue: #194
> > Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
>
> Can you elaborate how to trigger this? I tried by creating a folder with
> 2 files and set 5 xattr to the first file and 1 to the second. Then I
> run mkfs.btrfs -r /path/to/dir /dev/vdc and stepped through the code
> with gdb and didn't see any issues. Ideally I'd like to see a regression
> test for this issue.
>
> Your code looks correct.
>
> > ---
> >  mkfs/rootdir.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> > index 51411e02..c86159e7 100644
> > --- a/mkfs/rootdir.c
> > +++ b/mkfs/rootdir.c
> > @@ -228,10 +228,9 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
> >       int ret;
> >       int cur_name_len;
> >       char xattr_list[XATTR_LIST_MAX];
> > +     char *xattr_list_end;
> >       char *cur_name;
> >       char cur_value[XATTR_SIZE_MAX];
> > -     char delimiter = '\0';
> > -     char *next_location = xattr_list;
> >
> >       ret = llistxattr(file_name, xattr_list, XATTR_LIST_MAX);
> >       if (ret < 0) {
> > @@ -243,10 +242,10 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
> >       if (ret == 0)
> >               return ret;
> >
> > -     cur_name = strtok(xattr_list, &delimiter);
> > -     while (cur_name != NULL) {
> > +     xattr_list_end = xattr_list + ret;
> > +     cur_name = xattr_list;
> > +     while (cur_name < xattr_list_end) {
> >               cur_name_len = strlen(cur_name);
> > -             next_location += cur_name_len + 1;
> >
> >               ret = lgetxattr(file_name, cur_name, cur_value, XATTR_SIZE_MAX);
> >               if (ret < 0) {
> > @@ -266,7 +265,7 @@ static int add_xattr_item(struct btrfs_trans_handle *trans,
> >                                       file_name);
> >               }
> >
> > -             cur_name = strtok(next_location, &delimiter);
> > +             cur_name += cur_name_len + 1;
> >       }
> >
> >       return ret;
> >
