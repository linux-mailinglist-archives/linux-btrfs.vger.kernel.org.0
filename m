Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACB422EF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhJERUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 13:20:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhJERUh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 13:20:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3F6EE20041;
        Tue,  5 Oct 2021 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633454326;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W39GNNh/+YQcaZ1waHe2IbPBnfIbQ2eGJZrqS1J6wKg=;
        b=I4xFO5JiKpjj2ccqrad3/fOTeoUoDDpsMg5JVUdM3rzW7sxg/feIrOGVut3UTqvYSclTvN
        yA9Z9g9tTCF5Rt5l4H42oIPAIbfaubHst1U75g3lM80/54w2a7c0yVBIiKQ4ga8fFoSbs2
        NV/1DjLhLMQkgTRAGcpM/E/2deG5QRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633454326;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W39GNNh/+YQcaZ1waHe2IbPBnfIbQ2eGJZrqS1J6wKg=;
        b=7XyuAz6lzdFFaQzfGtfx0kTSMyFquyccdmuC0IV10klkml6vtUaocvvq3b9LOXvrpfFbEI
        hMbUMCJ9Pj2qk8Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 37493A3B84;
        Tue,  5 Oct 2021 17:18:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DABCDA7F3; Tue,  5 Oct 2021 19:18:26 +0200 (CEST)
Date:   Tue, 5 Oct 2021 19:18:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: compression: update the comment for
 alloc_compressed_bio()
Message-ID: <20211005171826.GI9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211005062144.68489-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005062144.68489-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 02:21:44PM +0800, Qu Wenruo wrote:
> This comment will include all parameters, not only the new
> @next_stripe_start.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Merged to the commit introducing the parameter, thanks.
