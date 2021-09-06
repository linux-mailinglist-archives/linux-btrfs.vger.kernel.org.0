Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5F401C96
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbhIFNrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 09:47:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242478AbhIFNrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 09:47:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 04FA6220FA;
        Mon,  6 Sep 2021 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630935970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nhZkZo/PrYT3goX1seVcA8Fx0Ke1PMRocXzJY4tJjE=;
        b=dBlrvpESt1dItC2d61zaQaXXREoFWFwXc/76yuWzZhaO4kgaS0cbOLoaYCSUwryTHkZ8oW
        AccIsnRwW8uXNkv1nyjJLEA+k5IzIVvbbuUWSwLXjm95HXBBaSzu1b1jBRgUA0rEvmdG18
        YF/ZL1pcHJNFhVpNCRa1tgWIyaQyrxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630935970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nhZkZo/PrYT3goX1seVcA8Fx0Ke1PMRocXzJY4tJjE=;
        b=xR4APU6XPhhXx9g1Ns21iFQ5OEAuvOYUvUuw2VFzMu2kBNacPbOHcJoLWYy+3d+z5nfrsu
        H2dFdN5D1dKnqbDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1656A3B88;
        Mon,  6 Sep 2021 13:46:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E7DCDA781; Mon,  6 Sep 2021 15:46:06 +0200 (CEST)
Date:   Mon, 6 Sep 2021 15:46:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: props: init compression prop_handlers with
 field name
Message-ID: <20210906134606.GH3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210906133432.5485-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906133432.5485-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 06, 2021 at 01:34:32PM +0000, Sidong Yang wrote:
> Compression prop_handler is initialized without field name. This patch
> corrects that it's initialized with field name.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks, added to devel.
