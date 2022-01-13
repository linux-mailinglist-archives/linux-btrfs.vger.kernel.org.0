Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECBF48DBB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiAMQ01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 11:26:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiAMQ00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 11:26:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D90081F3BA;
        Thu, 13 Jan 2022 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642091185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWNs6pi3ChrNWBkJ0xq8CBjBDqs2+PgF/fYLTY89g/Y=;
        b=d7tHMIJ7NavS1AhzfdobZnuDrNIS0jfhV5k8pDIbqNGNfF1yaPsTtovdSKEqi9yaInlpn4
        w3V1eVpDLn4BD9rSnUBwJqOusB04khZg4yljVzskfRNfNwqYWhkRjdPgVqOFvNN2Zh1p2V
        kOARYJ1E33M9eDUw+NOZOb+ydkq0u+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642091185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWNs6pi3ChrNWBkJ0xq8CBjBDqs2+PgF/fYLTY89g/Y=;
        b=SCxRJbRPnk9VF9vjwsCmOYQtWwg0JQNlxiXozsnKM/+0kPeXif4F5cYQYR/egkbS2Jnzwp
        FxFc3LR/Udd0hcDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D1CD8A3B85;
        Thu, 13 Jan 2022 16:26:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7DD1DA781; Thu, 13 Jan 2022 17:25:51 +0100 (CET)
Date:   Thu, 13 Jan 2022 17:25:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix a bunch of typos
Message-ID: <20220113162551.GB14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20211106235742.13854-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106235742.13854-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 07, 2021 at 12:57:42AM +0100, Adam Borowski wrote:
> These have been detected by lintian and codespell.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Added to devel thanks.
