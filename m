Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18FC3D8F0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhG1N32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:29:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48688 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhG1N31 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:29:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 54AA1201A2;
        Wed, 28 Jul 2021 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627478965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dz3cIb5A1stLOlrkHtN/+9IuwzFhnD/ytPOA32Tkjak=;
        b=eS6suV5aSx/O6BUJG2BL6MIdo2/ROr0VSY8HBMJo+3dHcwglJtXa7FVAFX4RhgK+K4kw19
        OzNLM2I2Vao6j7GKWRtreHAs6y7oUILgR2/7Qq/gdgW8Qh8DZySMknrEIHJush4o/Jk+n+
        SVrH7lvsBLHi/Y+SuO5yloMyGtxhD5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627478965;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dz3cIb5A1stLOlrkHtN/+9IuwzFhnD/ytPOA32Tkjak=;
        b=zsc1xnMwrTEJzD2JIdyZvm3qHyvN6xraHWaL2yXO9hXFO8HOjlPH9vaXTSPCve4YcFyOFN
        hd89JsiK0ZiAaDBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 490A9A3B84;
        Wed, 28 Jul 2021 13:29:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72678DA8A7; Wed, 28 Jul 2021 15:26:40 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:26:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 06/18] btrfs: rework lzo_decompress_bio() to make it
 subpage compatible
Message-ID: <20210728132640.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210726063507.160396-1-wqu@suse.com>
 <20210726063507.160396-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726063507.160396-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 02:34:55PM +0800, Qu Wenruo wrote:
> +		/* Check if the sector has enough space for a segment header */
> +		sector_bytes_left = sectorsize - cur_in % sectorsize;

For clarity and ease of reading, please put ( ) around the expressions
with %:

		sector_bytes_left = sectorsize - (cur_in % sectorsize);
