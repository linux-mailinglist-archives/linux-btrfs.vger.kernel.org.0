Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA24E0407
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfJVMky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731405AbfJVMky (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:40:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF13FB293;
        Tue, 22 Oct 2019 12:40:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A492FDA733; Tue, 22 Oct 2019 14:41:05 +0200 (CEST)
Date:   Tue, 22 Oct 2019 14:41:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/2] btrfs-progs: Setting implicit-fallthrough by default
Message-ID: <20191022124105.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022020228.14117-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 11:02:26PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> While compiling btrfs-progs using clang I found an issue using
> __attribute__(fallthrough), which does not seems to work in clang.
> 
> To solve this issue, the code was changed to use /* fallthrough */, which is the
> same notation adopted by linux kernel.

I'd suggest to follow what kernel does, IIRC there's some whole-tree
cleanup of all the fall through statements with a unified conversion to
the right(tm) annotation.

> Once these places were changed, -Wimplicit-fallthrough was set in Makefile, to
> avoid further implicit-fallthrough cases being added in the future.

That would be good to add by default, but I'm a bit worried about the
differences between compilers and that we'd have to switch the
annotations again once the attribute support lands. Maybe that's not a
big deal.
