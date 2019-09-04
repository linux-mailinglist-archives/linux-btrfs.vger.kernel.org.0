Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1EA93C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfIDUfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:35:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfIDUfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:35:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id t1so59707plq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8D8XsKLExa+oAXXNHD7yk7Q5aNTg99foxjb/576FXkU=;
        b=SvHIEswQv6I5QfqgtxTAHeLmFZzoub0TysWfAHEj7ZwOdrX4lma6CVhkpUbMHh1Nem
         plU6Y59gFsRg97aTAEOIxOSVIgts4v4OvFNiMBd2VG5Jgku0GrY4Sm8KjJJS6ojc5HPB
         xiY/Mq5Ma9RMbJYt1FJmZ+m0ntCgs9PkSLfA9M0ykXXfo9GnCBVrV5f9gkTW03vT5H9q
         dF6aSyjSGdFQNQk5Zn+n3wT6LLNS6Y1fG9UYQDMdhJ7xrf6Tbb6HSLJehe/kk4RyPK3q
         1upEqNrOA5zSBM1wNXPijDbL4H3WMxZ7d/we9hhyVIWM8UN/bFHrHtot49+JPJfoRsGv
         Z/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8D8XsKLExa+oAXXNHD7yk7Q5aNTg99foxjb/576FXkU=;
        b=m+HxhJSkezVFZpzyTYiPQGFxG4H9uFCAdLG/kQHQoDQ5qYrelwtvC5ySB1gGnTsQaN
         JAwnsykkddRV/Y7B4AQlplhePSem14ve7+JFw1/iE4G/3P9Kn2laJcmhbmUSXsaYasXh
         7hsdzIaA+vnHwjLUpFLwzItu7hXlaWmrwtRRRxeA0Pyr44PaMuiqmtBReqrtvjVCq7ku
         0FjUI+oo7StLGFzzsYwBayWIoz4Zz/l2BA8w6K3pGvZDu0iQhCzIvO0l1DBcAqlffamr
         7MN1Oee4p1zkDtnk8Sq58NagiFiYSOirnOLxkU0cX4r1t9zMkOhWYO5J7Fh3XOgFrJdS
         T7vw==
X-Gm-Message-State: APjAAAUQm4V14Ixi7HNpId14ITBNuOYctpSx3D/A7yKjruOEP9x0Bkrw
        Wyx+yMjRv2UqLks5ZoIRJuqMKd7DTMo=
X-Google-Smtp-Source: APXvYqwy2BqT1mkDaWxn7r+yJLpEvqyZj3eBLPq+jxwn/DWLoMt8nk6ATbV0QVSCeB93QB6pCvJLTw==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr10028461pls.94.1567629341407;
        Wed, 04 Sep 2019 13:35:41 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3502])
        by smtp.gmail.com with ESMTPSA id z12sm14484234pfj.41.2019.09.04.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:35:40 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:35:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] btrfs-progs: fix clone from wrong subvolume
Message-ID: <20190904203539.GF7452@vader>
References: <cover.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1563822638.git.osandov@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 22, 2019 at 12:15:01PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is v2 of [1]. Changes from v1:
> 
> - Split out removing commented-out code to new patch 1 and removed a
>   related comment block.
> - Made subvol_path const char * in patch 2.
> - Added test case as patch 4.
> - Fixed wrong signed-off-by.
> 
> Thanks,
> Omar
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1563600688.git.osandov@fb.com/T/#u
> 
> Omar Sandoval (4):
>   btrfs-progs: receive: remove commented out transid checks
>   btrfs-progs: receive: get rid of unnecessary strdup()
>   btrfs-progs: receive: don't lookup clone root for received subvolume
>   btrfs-progs: tests: add test for receiving clone from duplicate
>     subvolume
> 
>  cmds/receive.c                                | 50 ++++---------------
>  .../test.sh                                   | 34 +++++++++++++
>  2 files changed, 45 insertions(+), 39 deletions(-)
>  create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh

Ping. Looks like only patch 2 is in the devel branch.
