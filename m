Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873D6419F1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhI0T3Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 15:29:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhI0T3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 15:29:24 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD3F6222A3;
        Mon, 27 Sep 2021 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632770865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiUq2Q11UZwNMHRjlO+JOCv7hO1CU16og8Qb620Hr0E=;
        b=B1kZ6LuWOBQ2WtDTQQQNzGguKIjIIQUYqPejG7CevQvedEDVjehUOuMt1OU5dZivDTFSkO
        r0QwRjTqdJuGauzN4X+lEEw5Y0gvhpiIch93IAaGw41GOSx/ke6bPePnd0chNsAFib1meq
        +GBGipxpdeOghBUV5IFPP1bKuPSzC7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632770865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiUq2Q11UZwNMHRjlO+JOCv7hO1CU16og8Qb620Hr0E=;
        b=J4yYzOUrcU7Z3ZiO2xv+5Ne6G5ImrnT2ivLSAqMsx+eH1ScTpPecJ9eBc2p/B4lTqg+hoQ
        gjHFO7fM40gMQbBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id C791A25D42;
        Mon, 27 Sep 2021 19:27:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BFBEDA799; Mon, 27 Sep 2021 21:27:30 +0200 (CEST)
Date:   Mon, 27 Sep 2021 21:27:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: speedup bulk item insertions
Message-ID: <20210927192730.GG9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1632482680.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1632482680.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 24, 2021 at 12:28:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset does some minor improvements to speedup bulk insertion of
> items into a btree, which is used when logging directories, when running
> delayed items for directories (fsync and transaction commits) and when
> running the slow path (full sync) of an fsync. The last patch in the
> series contains test results in its changelog.
> 
> Filipe Manana (3):
>   btrfs: loop only once over data sizes array when inserting an item batch
>   btrfs: unexport setup_items_for_insert()
>   btrfs: use single bulk copy operations when logging directories

Added to misc-next, thanks.
