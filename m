Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D43F4B4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhHWNDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 09:03:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50056 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbhHWNDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 09:03:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21BE721FBF;
        Mon, 23 Aug 2021 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629723741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5r0y9sIiT9Gm5STlqwUXp8V6NH0byZmhr0RxgOiGC4=;
        b=GZWh03VI1cH2E2Rh8rpfWDVXsTDIDxiDyv2xnZgKUp6+VB8TzK3iKkQaN2UnK9G9XdgEBA
        tR0TmLEa5igf2cwnXkRr+vQUGnn7ip57cJnQUHIzzj9w0pkJhH+jFdK0oM1UnJQ55Ozwq2
        0CKJa8IdbYFWI4O02673gQzaG9PQfeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629723741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5r0y9sIiT9Gm5STlqwUXp8V6NH0byZmhr0RxgOiGC4=;
        b=lPrUWAXL1n02LYtcgsgPFSy8h78YVELDt6o5emDM9yIEJ/w++QMJfLMjrKN913OQo+dm6z
        wwkhJDoVJQAeMZDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16E4EA3E07;
        Mon, 23 Aug 2021 13:02:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9B1DDA725; Mon, 23 Aug 2021 14:59:21 +0200 (CEST)
Date:   Mon, 23 Aug 2021 14:59:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
Message-ID: <20210823125921.GA5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210818041548.5692-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818041548.5692-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 12:15:48PM +0800, Su Yue wrote:
> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
> list api") did conversion from fs_devices::seed to fs_devices::seed_list.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to misc-next, thanks.
