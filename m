Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6036E400F8C
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Sep 2021 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhIEMP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhIEMP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Sep 2021 08:15:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE36C061575
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Sep 2021 05:14:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c17so3860101pgc.0
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Sep 2021 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=e908GPDHUJFAFBG18NLZHAXSRpwWQYW9FozSerkDzFc=;
        b=cllpbNOyDdDHhpLgVk+RUJqt1Wm/+dad2j4wQDrF8mFS6+e4rksK95q0E1mOa+ScmL
         gXGAHAzPHFTzKzcCj/qMhfbW4UyaZdBjWBTWK85pMg3fPKI2uwvVCeQp6PRRlxyPCtFZ
         qBboGhJlTHDgfXLRzbupOAIQuglHMxi3cS+OMYe4Ol8yWTYFCxAlnd0sh93AYCyAafA7
         eGjpe2JoZ09tFHWU1ycgAP7PjZxzEQEEo1dKqbmFSixjEB8u9ffYk6z3kKzNy7owxiYh
         F7kFOX25Plxr3lmvNd4Nt9gq6ZwygaN5R7nDlTIwjD4gK2t5VJmB8pgrsZ4O+lSNKpK7
         yp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=e908GPDHUJFAFBG18NLZHAXSRpwWQYW9FozSerkDzFc=;
        b=r0YWuPNUcOvGhgDpVgq1YsUPCaIFU18Ft6K7jEWvGzRq3FnSMRiUcDcW8/FPSzllMB
         j8c/DH388BYuOzrl2WJNL8d0rZW68sZxqg43uLged0Be1d6VpGv/5L6VZ236mmaGzw8S
         LJk3+mllaXuXpVUjmredPlGFqIO1N7K0c9jT3dP7LdX1R2vB2Bw5XD7DlLf5iLQu+Ckq
         ut33VfH7InQI5LUzEzn9zC1qYTphN48WIx0z8Pu2PrCkOiGbZvP20hDk5XrXKuuK6YZv
         98bROmtfLfm4x4F1z/WzNqdXkkhMCUwptLVp240CFiwu8ryQB8g0foWtR811zNPM4Z3e
         1nrQ==
X-Gm-Message-State: AOAM532astZf9bke2JBplIHIxI4FBd0ux08TIzAtGl34C42CTDDIrST0
        lawrljeJdz0VQixRQEe5WcNcay33by8=
X-Google-Smtp-Source: ABdhPJxoVSe9MSGlP45U+1h5mOQZzdqVvfOANxvSdy/ZWhP9MpPYbFAEMLzA4XqB5wBcioJjDg7VLg==
X-Received: by 2002:a62:2cc8:0:b0:412:65da:cb with SMTP id s191-20020a622cc8000000b0041265da00cbmr7216255pfs.36.1630844064625;
        Sun, 05 Sep 2021 05:14:24 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id v26sm4695855pfi.207.2021.09.05.05.14.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 05:14:24 -0700 (PDT)
Date:   Sun, 5 Sep 2021 12:14:17 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: An question for FICLONERANGE ioctl
Message-ID: <20210905121417.GA1774@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, All.
I've tried to handle btrfs-progs issue.
(https://github.com/kdave/btrfs-progs/issues/396)

And I tested some code like below.

src_fd = open(src_path, O_RDONLY);
if (src_fd < 0) {
	error("cannot open src path %s", src_path);
	return 1;
}

dest_fd = open(dest_path, O_WRONLY|O_CREAT, 0666);
if (dest_fd < 0) {
    close(src_fd);
    error("cannot open dest path %s", dest_path);
    return 1;
}

range.src_fd = src_fd;
range.src_offset = src_offset;
range.src_length = length;
range.dest_offset = dest_offset;

ret = ioctl(dest_fd, FICLONERANGE, &range);

And this ioctl call failed with error code invalid arguments when length!=0.
I tried to understand FICLONERANGE man page but I think there is no clue
about this. I traced kernel code and found out it goes fail in
generic_remap_checks(). There is an condition checks if req_count is
correct size and it makes test code fails. 

I don't know about this condition but it seems that it can be passed for
setting REMAP_FILE_CAN_SHORTEN. Is there any way to setting remap_flags
in FICLONERANGE ioctl call?

Also it would be pleased that if you provide some documentation about
this.

Sorry for writing without thinking deeply.

Thanks,
Sidong
