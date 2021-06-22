Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578253B0284
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFVLQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 07:16:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46776 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFVLQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 07:16:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE0C61FD36;
        Tue, 22 Jun 2021 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624360454;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTnvvBEG4PwHNc/dpSrnvsjBsT+nMeHe0oE1Ui0HkvU=;
        b=BOBZ9xaMSqcwtAt1Pp8eP9E6nDqtwfVzJE/K0wN70/6mBLLGscB+WVAmfObHyjPyCOQMQP
        sJdW8JQQMuKzC6sVM9f2bRdieyC45A6UjNb7lt7QCNUiEbOXdo5zPbETGiAoVmvcuh7p5B
        6XscsMzFEx8E4uzfwQVHSl+tBocfQUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624360454;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTnvvBEG4PwHNc/dpSrnvsjBsT+nMeHe0oE1Ui0HkvU=;
        b=Lwc8V2l3CoZUrm38zjkhByTH4SSkWW7oqymf4SWYGT96otrGs82H0CjmtWSSp3gL2zA/lp
        lV4GcbECQ3R0rPAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AFE45A3B85;
        Tue, 22 Jun 2021 11:14:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05AABDA77B; Tue, 22 Jun 2021 13:11:23 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:11:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4][v2] btrfs: commit the transaction unconditionally
 for ensopc
Message-ID: <20210622111123.GE28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1624029337.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624029337.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 18, 2021 at 11:18:28AM -0400, Josef Bacik wrote:
> v1->v2:
> - added "btrfs: remove FLUSH_DELAYED_REFS from data enospc flushing" to deal
>   with me changing the docs and to reflect that we no longer need this step in
>   data enospc flushing.
> - Updated the 'rip out' patch to no longer include that particular part of the
>   documentation update.

Moved from topic branch to misc-next, thanks.
