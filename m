Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31039E77B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 21:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFGT3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGT3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 15:29:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F57C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Jun 2021 12:27:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s14so12969725pfd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jun 2021 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zeH4yya8Ov0XNzvCZS7NtOG1PVDjiVam/k7S0CY0xuQ=;
        b=DmqkaxcE7zU7zcky0JuI4pNmEdX+7cebd2/eWDHmDZ8Cm5DsXNt7ekoVzffpe+hrs8
         Zy//wL10OwQRNNAinAR3oTuvy85GLhXcpNiwx0nXDxhMfkFYXdwQuoafSKF0vvR9VuQQ
         R189XtCfOlsJGOzs0+o3kzu3LI0FZglDmI/6EGc/ovKdaVQBCfmO379Ngs29JrMwMbF8
         +KS4/08FmDpIeagDvnoRkurquBpfNfOl7eV1alo4WxatYewjWpblL5VVRh3SDETC7Cng
         +xbPqnSDHm+TVLt9gL9aazUzy4583bRW8+BuXmvbpFDZsQyEniwFmi8KgjfHMvbXTGrv
         Q+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zeH4yya8Ov0XNzvCZS7NtOG1PVDjiVam/k7S0CY0xuQ=;
        b=Pif938xOafT0QWFi8uteb7CfN5aUxcjrQtKF7V0/pAyQElSNZkUZw7zFjYHKkGMoYx
         PXfkU+KVnTFnubgYEkTNtxfhlT53VPStuwNenmURWqB4b4PB8q3VV5luuFIbHxcnOklP
         fSoCCBl1+VDEdKuIjDQ8xmmpqffVWRsJn16PhxE+emL8dwE4MvBZQcRhjrjZ4gkygWRD
         S5OtHaupH2DrCUJXZJ7DkrN+zWuQT1ks1z1DJR/wDnggzpP7f1/zJsrDgo+bAbdHzxIi
         8o/ZLhJkUqNoW60QatuRAaJv9M9PYrX7CftbDOMD0DVdIR51lTruoIP9nGh6nRYXthOQ
         8X5A==
X-Gm-Message-State: AOAM530ooJDM7PrmBnCWh9aAcbpMgCl1uFNDIf9WLZHE+NyLlScuMBrC
        2NSy5A/2Uicjvtc/aKW35k6iVA==
X-Google-Smtp-Source: ABdhPJz1Z3LXQzm5cAAz83b2SU/IXLOt0dJC1KUkJtXXZcvcu7iCLEhu9pSXhX8Tp7l3PsW5G6jR7w==
X-Received: by 2002:a05:6a00:234e:b029:2ea:311e:ea9c with SMTP id j14-20020a056a00234eb02902ea311eea9cmr18111072pfj.36.1623094030577;
        Mon, 07 Jun 2021 12:27:10 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7f52])
        by smtp.gmail.com with ESMTPSA id 23sm8139908pjw.28.2021.06.07.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:27:09 -0700 (PDT)
Date:   Mon, 7 Jun 2021 12:27:07 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YL5zCxGx/J1WxSCq@relinquished.localdomain>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 17, 2021 at 02:32:47PM -0700, Linus Torvalds wrote:
> On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> > are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> > patch 9 adds Btrfs encoded write support.
> 
> I don't love the RWF_ENCODED flag, but if that's the way people think
> this should be done, as a model this looks reasonable to me.
> 
> I'm not sure what the deal with the encryption metadata is. I realize
> there is currently only one encryption type ("none") in this series,
> but it's not clear how any other encryption type would actually ever
> be described. It's not like you can pass in the key (well, I guess
> passing in the key would be fine, but passing it back out certainly
> would not be).  A key ID from a keyring?
> 
> So there's presumably some future plan for it, but it would be good to
> verify that that plan makes sense..

To summarize the discussion and answer your original question, using
RWF_ENCODED for encryption will require additional support for getting
encryption metadata, but that support is best suited for a separate
interface, with RWF_ENCODED purely for the encrypted data itself. The
harder part of encrypted backups is restoring filenames, and that would
also be best as a separate interface.

My use case is only for compression, so none of that is a blocker for
RWF_ENCODED.

What else can I do to move this along?

Thanks,
Omar
