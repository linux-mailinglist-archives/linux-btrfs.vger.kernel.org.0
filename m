Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB33D71BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbhG0JNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:13:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51280 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhG0JNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:13:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3E2A200E4;
        Tue, 27 Jul 2021 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627377221;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmAxRU6LA69N2qu4Mg81nbdn8nbUQXLq40vk05xE6nM=;
        b=lyneUU54rEMU56qj+wkJ4LVDU1FRjJ06YDufSc4RZAfov7//0K3kpdM5Ig1QuIyY+sDOWc
        u3MGDnpLORWVbJo0M13rBVMe5337WQAKyo1WuQbHQEy+8uAIQ6UZWFfULAxd4+/5QTN7DI
        79x7xDm7PwTE9m2TEP2d6YM/cjPlVIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627377221;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmAxRU6LA69N2qu4Mg81nbdn8nbUQXLq40vk05xE6nM=;
        b=u+dObB2bTHUX0hNKozTBSZK9jzZ8DxGVwuWTBopdpWPvaruhEJj/6b134AnscCkxtX3KiB
        CutAqXEbg4qw0PDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CCE54A3B81;
        Tue, 27 Jul 2021 09:13:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75B88DA8CC; Tue, 27 Jul 2021 11:10:57 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:10:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 00/18] btrfs: add data write support for subpage
Message-ID: <20210727091057.GM5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210726063507.160396-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 02:34:49PM +0800, Qu Wenruo wrote:
> This much smaller patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> 
> These patchset is targeted at v5.15 merge window.
> There are 11 subpage enablment patches pending for a while, and not
> touched, thus they should be pretty stable and safe.
> 
> While there are 7 new patches, 4 of them are straightforward small
> fixes, the remaining 2 are a little scary as they reworked the core code
> of compression.
> The final new patch is a special write path hotfix, aiming to make btrfs
> subpage writeback more robust against tests like dm-dust.
> 
> The rework should improve the readabilty thus make reviewing a
> little easier (as least I hope so).

The series is in a topic branch and I'll move it to misc-next after one
more round of fstests, yesterday's testing was ok. Some of the changes
are scary but I haven't seen anything obvious and once it's in misc-next
it'll get more exposure so we'll be able to fix the remaining bugs.

Please send any fixups either as separate patches or let me know where
to do some simple tweaks. Thanks.
