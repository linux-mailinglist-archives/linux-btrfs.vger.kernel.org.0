Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E9CEB01
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGRwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 13:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:42526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGRwW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 13:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4958BAF16;
        Mon,  7 Oct 2019 17:52:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B626DA7FB; Mon,  7 Oct 2019 19:52:36 +0200 (CEST)
Date:   Mon, 7 Oct 2019 19:52:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        thecybershadow@gmail.com, wqu@suse.com, lakshmipathi.g@giis.co.in
Subject: Re: [PATCH] Setup GitLab-CI for btrfs-progs
Message-ID: <20191007175235.GL2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        thecybershadow@gmail.com, wqu@suse.com, lakshmipathi.g@giis.co.in
References: <20190930165622.GA25114@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930165622.GA25114@giis.co.in>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 10:26:54PM +0530, Lakshmipathi.G wrote:
> Make use of GitLab-CI nested virutal environment to start QEMU instance inside containers
> and perform btrfs-progs build, execute unit test cases and save the logs.

This looks good, thanks!

> More details can be found at https://github.com/kdave/btrfs-progs/issues/171
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.com>
> ---
>  .gitlab-ci.yml                        | 181 ++++++++++++++++++++++++++++++++++
>  gitlab-ci/Dockerfile                  |   3 +
>  gitlab-ci/btrfs-progs-tests.service   |  13 +++
>  gitlab-ci/build_or_run_btrfs-progs.sh |  37 +++++++
>  gitlab-ci/kernel_build.sh             |  30 ++++++
>  gitlab-ci/run_tests.sh                |   9 ++
>  gitlab-ci/setup_image.sh              |  42 ++++++++

Is it possible to move the files to ci/gitlab? .gitlab-ci.yml must be
probably in the top-level dir but that's acceptable.

>  7 files changed, 315 insertions(+)
>  create mode 100644 .gitlab-ci.yml
>  create mode 100644 gitlab-ci/Dockerfile
>  create mode 100644 gitlab-ci/btrfs-progs-tests.service
>  create mode 100755 gitlab-ci/build_or_run_btrfs-progs.sh
>  create mode 100755 gitlab-ci/kernel_build.sh
>  create mode 100755 gitlab-ci/run_tests.sh
>  create mode 100755 gitlab-ci/setup_image.sh

The scripts look good to me but I have limited knowledge of the CI
environment so I don't have objections against merging the patch. I'll
spend some time experimenting but overall this seems in a good shape and
we'll get further coverage (due to the new kernel) than what travis
provides. Thanks.
