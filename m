Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51E1E9A08
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 May 2020 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEaTIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 May 2020 15:08:19 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.175]:36040 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbgEaTIS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 May 2020 15:08:18 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id DA892400CBFB5
        for <linux-btrfs@vger.kernel.org>; Sun, 31 May 2020 14:08:15 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id fTJfjlS1fAGTXfTJfjxCqk; Sun, 31 May 2020 14:08:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6jhSDteDhglDICeIfISWQj/P+OPCcc5dAHYY+wv1KeE=; b=MkNGUcJMpDeLrUqRnXLhpJrvA6
        kQGHZHlJNitcjvYIkK+E0J7tNwTtEr3AXw/AmGf+l+TvV+aTT/qcQde43WqLWoLweErXtAsJ4cjtD
        g+h/Dmlf1ykIqjdE/qemqNV0rC7aLO3P69eWnHgiNmVd399cqHGWOgo2llY2FqZht/PI2caBiPeSH
        beohsGPdbQyRPFdZD949V1yQEZUtmiTNo38IquWLBGzU7uIWJuAZ6hpQA4SJn/cf+B5wahXu6x6j5
        A1sq/kMgnloz/0u9azWnegrSFsJcSnNXHICl+yGw3Wd3zErrHfvwB2rd/SMgYMTF/sO6oufON8Sum
        v8qQevWg==;
Received: from [179.185.220.196] (port=48190 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jfTJf-002ENi-Ak; Sun, 31 May 2020 16:08:15 -0300
Message-ID: <2ba1eb8434c13dd0c2a421ee12b824ad9e90fe4e.camel@mpdesouza.com>
Subject: Re: [PATCHv3 0/3] btrfs-progs: Auto resize fs after device replace
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Sun, 31 May 2020 16:11:45 -0300
In-Reply-To: <20200416004642.9941-1-marcos@mpdesouza.com>
References: <20200416004642.9941-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.220.196
X-Source-L: No
X-Exim-ID: 1jfTJf-002ENi-Ak
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.172]) [179.185.220.196]:48190
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Humble ping :)

On Wed, 2020-04-15 at 21:46 -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Changes from v2:
> * Fixed the code format after moving function resize_filesystem in
> patch 0001
>   (suggested by David)
> * Sorted the resize_filesystem function prototype in patch 0001
> (suggested by
>   David)
> * Changed the -a into long argument --autoresize in patch 0002
> (suggested by
>   David)
> * Translate srcdev if the argument is not a devid (suggested by
> David)
> * This also changes the way we use the ioctl, now only passing devid
> to the
>   kernel, instead of passing the path and letting the kernel to
> translate
> * Add tests to check the autoresize functionality
> 
> Changes from v1:
> * Reworded the help message and the docs telling the user that the fs
> will be
>   resized to it's max size (suggested by Qu)
> * Added a warning message saying that the resize failed, asking the
> user to
>   resize manually. (suggested by Qu)
> 
> Both changes were done only in patch 0002.
> 
> Anand suggested this job to be done in kernel side, atomically, but
> as I
> received a good review from Qu I decided to send a v3 of this
> patchset.
> 
> Please review, thanks!
> 
> Original cover-letter[1]:
> These two patches make possible to resize the fs after a successful
> replace
> finishes. The flag -a is responsible for doing it (-r is already use,
> so -a in
> this context means "automatically").
> 
> The first patch just moves the resize rationale to utils.c and the
> second patch
> adds the flag an calls resize if -a is informed replace finishes
> successfully.
> 
> Please review!
> 
> Marcos Paulo de Souza (3):
>   btrfs-progs: Move resize into functionaly into utils.c
>   btrfs-progs: replace: New argument to resize the fs after replace
>   btrfs-progs: tests: misc: Add some replace tests
> 
>  Documentation/btrfs-replace.asciidoc        |   5 +-
>  cmds/filesystem.c                           |  58 +----------
>  cmds/replace.c                              | 105 +++++++++++++-----
> --
>  common/utils.c                              |  60 +++++++++++
>  common/utils.h                              |   2 +
>  tests/misc-tests/039-replace-device/test.sh |  56 +++++++++++
>  6 files changed, 192 insertions(+), 94 deletions(-)
>  create mode 100755 tests/misc-tests/039-replace-device/test.sh
> 

