Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0737B419E93
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhI0Suk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:50:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhI0Suj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:50:39 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id BB8E822292;
        Mon, 27 Sep 2021 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632768540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPO9m/ZU1aYXDrRGsf5QKlqiPhvypQm/FzCwU/yoqSk=;
        b=21acM/w+qHgacgQNF4T5d46pKAUIafRVpr0rTF1eoxrJMsM68oPW30N/cvRqtHLZolOb7g
        wd88HpaT/N3qnKtMHDoPj6nVwW1DO/jDX8K3xzmlVeO/BX3D0/gYxKDfraw7zkmauvOo4T
        78KUzLCTDkQ11MVfBGABpTI9GFQrgAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632768540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPO9m/ZU1aYXDrRGsf5QKlqiPhvypQm/FzCwU/yoqSk=;
        b=l/FcUg3Wsr3R1LhuYEyPC89wAKLffujA0g//+y9PirLLtlNtb+AaykmPYafl+8Fhn3Mv8B
        GbdwzYwtfNlL2MCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 8BA2025D43;
        Mon, 27 Sep 2021 18:49:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D0E2DA799; Mon, 27 Sep 2021 20:48:45 +0200 (CEST)
Date:   Mon, 27 Sep 2021 20:48:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5/5] btrfs-progs: use direct-IO for zoned device
Message-ID: <20210927184844.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-6-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927041554.325884-6-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 01:15:54PM +0900, Naohiro Aota wrote:
> We need to use direct-IO for zoned devices to preserve the write ordering.
> Instead of detecting if the device is zoned or not, we simply use direct-IO
> for any kind of device (even if emulated zoned mode on a regular device).

I think this should be ok, we don't want to mix direct io and buffered
writes and both main device opening wrappers do that. As long as it's
abstracted like that we don't need any special detection or flags in the
callers. I was thinking about adding one to open_ctree_flags but that
does not seem necessary.
