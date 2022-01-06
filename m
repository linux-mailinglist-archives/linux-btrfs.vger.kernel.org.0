Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315BE48664E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbiAFOtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 09:49:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38928 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiAFOtf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 09:49:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8F0D21F385;
        Thu,  6 Jan 2022 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641480574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+9T6m6wMaowPzT9objh+lChRC2PXZw2ElsfSTzxtrq0=;
        b=dIIFfLPHUb+dDVb3DiS8oqFtaK52onGQa01LPvQgCoGppUKAWrSgqcH9CcbLiDQTyV8Lup
        KwqM277ub5RU317fv0M9Qep+YCfSSwLgvbfbQ8ifH0LI+mLQCyRuH2DhnHqsUbomaGVR8d
        J82CJMbdNOTYtkFLwNmN23JqlkEq/bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641480574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+9T6m6wMaowPzT9objh+lChRC2PXZw2ElsfSTzxtrq0=;
        b=jvWPaQyg1qYojT8ldANrYw1XN87pi58hUz5b/gEB0ow13AUDbvbFCPoZTuFzIW8siZ6E1Q
        3GJ+DfPxkn71tBDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5C315A3B81;
        Thu,  6 Jan 2022 14:49:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9AFCDA7A9; Thu,  6 Jan 2022 15:49:03 +0100 (CET)
Date:   Thu, 6 Jan 2022 15:49:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH][V2] btrfs-progs: allow autodetect_object_types() to
 handle link.
Message-ID: <20220106144903.GB14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <da4a4e0cf18df259e63c19872093bf12635da576.1641415488.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4a4e0cf18df259e63c19872093bf12635da576.1641415488.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 09:45:52PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The function autodetect_object_types() tries to detect the type of
> btrfs object passed. If it is an "inode" type (e.g. file) this function
> returns the type as "inode". If it is a block device, it return it as
> "block device".
> However it doesn't handle the case where the object passed is a link
> to a block device (which could be a valid btrfs device). For example
> LVM/DM creates link to block devices. In this case it should return
> the type as "block device".
> 
> This patch replace the lstat() call with a stat().
> 
> Reported-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

Added to devel, thanks.
