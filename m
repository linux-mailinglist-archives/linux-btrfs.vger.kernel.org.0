Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAF3464A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhCWQN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 12:13:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhCWQNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 12:13:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6EE5ACBF;
        Tue, 23 Mar 2021 16:13:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFE6DDA7AE; Tue, 23 Mar 2021 17:11:33 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:11:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     pierre.labastie@neuf.fr
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/1] btrfs-progs: build system - do not use AC_DEFINE
 twice
Message-ID: <20210323161133.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, pierre.labastie@neuf.fr,
        linux-btrfs@vger.kernel.org
References: <20210320092728.24673-1-pierre.labastie@neuf.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320092728.24673-1-pierre.labastie@neuf.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 20, 2021 at 10:27:27AM +0100, pierre.labastie@neuf.fr wrote:
> Note that I doubt this check is needed in configure:
> HAVE_OWN_FIEMAP_EXTENT_DEFINE is used only once in cmds/filesystem-du.c
> in:
> #if !defined(FIEMAP_EXTENT_SHARED) && (HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE == 1)
> but HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE is set to 1 by configure only if
> FIEMAP_EXTENT_SHARED is not defined in the kernel headers.
> 
> If you agree, I'll send a patch to completely remove this check.

The explanation why we want the configure-time check is in
https://github.com/kdave/btrfs-progs/commit/cf8fd1a70884db0b31e312d07806
ie. to support old distros. There's a runtime check for version in case
the fiemap flag is not supported in cmd_filesystem_du.
