Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B484A5E9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiBAOxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 09:53:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48950 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiBAOxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 09:53:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 05A041F37C;
        Tue,  1 Feb 2022 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643727229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXy0UvdmZm/AvivZJAx8/vusBk5thXGkbu1nvFIelh8=;
        b=JpkQqn6wb06lKINoVu3K5jKzPCiITnWA5IuzWZqlJ8NqHaLWGYfbRbhPT4eDllb1koXuow
        rZ8ScDcyNywZXpS5BcbDeN81vaYiWroS2kHHqRjfNuZu6xSNm/zqFCGhsTfZX0bN0DROEz
        Gck8xSntGQNzaRBsYo1hAplhCB4gbG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643727229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXy0UvdmZm/AvivZJAx8/vusBk5thXGkbu1nvFIelh8=;
        b=ZeR6RSpA/9SRSvilh+l/LavwIFzcKNraGdAcI1uAsK6wOTWc3B1n97UGQlZ1o74z1Y06SP
        Aq6WFMtMdCyhycAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F2BD6A3B85;
        Tue,  1 Feb 2022 14:53:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7A97DA7A9; Tue,  1 Feb 2022 15:53:04 +0100 (CET)
Date:   Tue, 1 Feb 2022 15:53:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't hold CPU for too long when defragging a file
Message-ID: <20220201145304.GP14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 30, 2022 at 08:53:15PM +0800, Qu Wenruo wrote:
> There is a user report about "btrfs filesystem defrag" causing 120s
> timeout problem.

Do you have link of the report please?
