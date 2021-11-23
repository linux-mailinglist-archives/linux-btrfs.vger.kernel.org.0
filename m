Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906545A62E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 16:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhKWPGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 10:06:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47722 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhKWPGj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:06:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E1F111FD5A;
        Tue, 23 Nov 2021 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637679810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nla7zyUNLaWamG2rM2QPd/WH9zOOd8o/2QThn9ATvo=;
        b=k0wbYhgrNZPSt/5uxJ1UtlStEPNgDyqLdAbbb5nNf4sV7Qloa9+/foSZLqo3qXsoM9zGAn
        7lt6hQWW/5tiuFtwTm1RfenC6K4KKz9czaOXkYrrmj+4JRY53rqZjvnztA7yg+NKMuRDI6
        kPkpnUjKJypDFpzF0JDkBgMpdfW8Pdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637679810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nla7zyUNLaWamG2rM2QPd/WH9zOOd8o/2QThn9ATvo=;
        b=pnlMIgRP9bmYfX7ZzkrvZ2rsTQ3l2ZfRNqIz4dJZMLqSBKkAIczrKDZiifOzxwymVpZ9JC
        N5p/uwlsXH21yEDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D8838A3B81;
        Tue, 23 Nov 2021 15:03:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAB07DA735; Tue, 23 Nov 2021 16:03:23 +0100 (CET)
Date:   Tue, 23 Nov 2021 16:03:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: eliminate if in main loop in tree_search_offset
Message-ID: <20211123150323.GP28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211123072342.21371-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123072342.21371-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 09:23:42AM +0200, Nikolay Borisov wrote:
> Reshuffle the code inside the first loop of tree_search_offset so that
> one if() is eliminated and the becomes more linear.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> V2: 
>  * Set entry to NULL by default so that semantics is unchanged. 

Added to misc-next, thanks.
