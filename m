Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48B945942F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhKVRsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 12:48:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbhKVRsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 12:48:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C082D1FD58;
        Mon, 22 Nov 2021 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637603123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2Dx1l3MK09Vt5cOuWs55qum9t/a3ALzWbYSVuLI6GA=;
        b=nSr+BGA9ZSVV/uJ/6QPNVXixcZ1VZLYiyjZuaCDzoQYWCMTSOXFa1B1eAIZd5G0rYfuDq9
        INGGACb97OFgKJhS/xoVnBFeTO6SnIhCTfINVqa8BcQ0h8y20VmL1bYxbnqbAJSNGhNCn6
        RzJcI6rDCd7VkmWWSiJSZ+dRdrYU1TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637603123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2Dx1l3MK09Vt5cOuWs55qum9t/a3ALzWbYSVuLI6GA=;
        b=chJQmm8zUskVThlNkXOhADMc5npVfq4hrv192z3zgl+DcvCgDhu36/j1Mk3imoFXoNsyZo
        1LoiiyTXJu03OeCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B9725A3B81;
        Mon, 22 Nov 2021 17:45:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16D6EDA735; Mon, 22 Nov 2021 18:45:16 +0100 (CET)
Date:   Mon, 22 Nov 2021 18:45:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 0/3] Index free space entries on size
Message-ID: <20211122174516.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637271014.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637271014.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 04:33:13PM -0500, Josef Bacik wrote:
> v4->v5:
> - Broke out the self tests into their own patch.
> - Use the rb_add_cached() helper instead of yet again duplicating the rb tree
>   insertion code.
> 
> --- Original email ---
> 
> Hello,
> 
> I noticed while digging into an xfstests hang that the bytes index stuff was a
> little wonky when it came to bitmap entries.  If we change the ->bytes at all we
> weren't re-arranging the bytes indexed tree for bitmaps, because we don't do the
> unlink/link thing that we do with extent entries.
> 
> I fixed this particular shortcoming and added a new set of selftests to validate
> that everything was working as expected.  This uncovered a weirdness with how we
> handle ->max_extent_size, so I've added that as a separate patch to make it
> clear why the change is necessary.
> 
> Additionally I've updated my original patch to include the fixes necessary to
> make bitmaps re-index when they change.  I've added self tests to validate the
> changes to make sure everything is acting as we expect.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: only use ->max_extent_size if it is set in the bitmap
>   btrfs: index free space entries on size
>   btrfs: add self test for bytes_index free space cache

Added to misc-next, thanks.
