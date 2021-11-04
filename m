Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE30F44580D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhKDRNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 13:13:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhKDRNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 13:13:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D06001FD74;
        Thu,  4 Nov 2021 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636045868;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CByc0ucpeUE5014jZzhrzI4Y8p2DtQrk8tqo5nMalFw=;
        b=PiFEwKlwOQJthD+RI56U0FttluQlAMLQeCHF1FwpdB7gKSJ4hjGCMlG1fahuXy5Ms2D1/L
        dOLUzcRMxfcErv7EcYGb3dreon/74ZpXc+No76tWEJHgUvqQUsDHSD32aIgmsKQl3Jm9+A
        Ili3+1rkO/1kOBP4knKhDqcCRWmL0Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636045868;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CByc0ucpeUE5014jZzhrzI4Y8p2DtQrk8tqo5nMalFw=;
        b=qS3qUvOurkPm0xN3BmqEX/d2FoKMSjief1+ZYTkN5VkvGkUX1ZXQyks7drs421SifF2GSL
        4evjqP3lGHQcfkDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C8C632C150;
        Thu,  4 Nov 2021 17:11:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B8C9DA781; Thu,  4 Nov 2021 18:10:32 +0100 (CET)
Date:   Thu, 4 Nov 2021 18:10:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix deadlock between quota enable and other quota
 operations
Message-ID: <20211104171032.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <3df4731012ac6dc17f9f3a33c519735fbe89fc84.1635355240.git.fdmanana@suse.com>
 <20211104150015.GY20319@twin.jikos.cz>
 <CAL3q7H4y1G8pBfGPXQ8ce=1Msq6SaEj_REbQyFuUONFxfpnoZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4y1G8pBfGPXQ8ce=1Msq6SaEj_REbQyFuUONFxfpnoZg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 03:23:40PM +0000, Filipe Manana wrote:
> Btw, I forgot to add the Fixes tag, the matching commit is
> 340f1aa27f367e ("btrfs: qgroups: Move transaction management inside
> btrfs_quota_enable/disable").
> It's from 2018, that's a bit old, not entirely sure if needed. If you
> want it, feel free to add it.

Thanks, I've updated the patch.
