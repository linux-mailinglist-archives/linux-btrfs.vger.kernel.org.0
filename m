Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C247199B4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgCaQV0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 12:21:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:46420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgCaQV0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 12:21:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 41900ACC2;
        Tue, 31 Mar 2020 16:21:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C030DA72D; Tue, 31 Mar 2020 18:20:51 +0200 (CEST)
Date:   Tue, 31 Mar 2020 18:20:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: lots of typo fixes (codespell)
Message-ID: <20200331162051.GR5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200327203652.36238-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327203652.36238-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 27, 2020 at 09:36:52PM +0100, Adam Borowski wrote:
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  CHANGES                                           | 2 +-
>  Documentation/btrfs-man5.asciidoc                 | 6 +++---
>  check/mode-lowmem.c                               | 6 +++---
>  ci/gitlab/kernel_build.sh                         | 2 +-
>  ci/gitlab/setup_image.sh                          | 2 +-
>  cmds/filesystem-du.c                              | 2 +-
>  common/format-output.h                            | 2 +-
>  common/utils.c                                    | 2 +-
>  configure.ac                                      | 2 +-
>  convert/common.h                                  | 2 +-
>  convert/main.c                                    | 2 +-
>  convert/source-reiserfs.c                         | 4 ++--
>  crypto/xxhash.c                                   | 2 +-
>  crypto/xxhash.h                                   | 2 +-
>  ctree.h                                           | 2 +-
>  extent-tree.c                                     | 2 +-
>  image/main.c                                      | 2 +-
>  tests/fsck-tests/042-half-dropped-inode/test.sh   | 2 +-
>  tests/fuzz-tests/images/bko-96971-btrfs-image.txt | 2 +-
>  tests/misc-tests/034-metadata-uuid/test.sh        | 2 +-
>  20 files changed, 25 insertions(+), 25 deletions(-)

Thank you, it's amazing that so many typos have snuk in since the last
spelling fixes round.
