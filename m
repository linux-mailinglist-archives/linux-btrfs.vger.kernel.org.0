Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3248B255
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiAKQhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:37:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiAKQhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:37:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1EF321F3BA;
        Tue, 11 Jan 2022 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641919066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3maDyPKwBYUTeE+RnKxRNxc7cFXmG02fPbXV9ECDX8=;
        b=lgPNFOK4DFWUt2c+UyxqegzQrO1eC5BzMxGHyLSHpcdlxzTylO7Ea7CSvqUZaGgbzrDvUG
        DqfNsxgt6Kiy7EjrmVFnGoINuUHocWbT3XvPPuFfeWKZk5z7lR8RQVaMjLYm4kQLwyANQx
        kYCuRmg8ivtjEvoC88BCAMwGt5MpNPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641919066;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3maDyPKwBYUTeE+RnKxRNxc7cFXmG02fPbXV9ECDX8=;
        b=yQSkbB0I49FQ/0SJd0DQtQrT81P45yOZzq6ULw2jdPc9BhM0AbtQXGW3NOkw/s9JaxBTxa
        v0+j3MpKCOirvwDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1824AA3B84;
        Tue, 11 Jan 2022 16:37:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9908DA7A9; Tue, 11 Jan 2022 17:37:12 +0100 (CET)
Date:   Tue, 11 Jan 2022 17:37:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Muprhy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs-progs: Don't crash when processing a clone request
 during received
Message-ID: <20220111163712.GT14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Chris Muprhy <lists@colorremedies.com>
References: <20220110111201.1824108-1-nborisov@suse.com>
 <751714dd-57e2-9ee3-2180-1614eab2c3fe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <751714dd-57e2-9ee3-2180-1614eab2c3fe@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 01:13:46PM +0200, Nikolay Borisov wrote:
> 
> 
> On 10.01.22 г. 13:12, Nikolay Borisov wrote:
> > If subvol_uuid_search can't find the clone root then 'si' would either
> > be NULL or contain an errno. The behavior of this function was
> > changed as a result of commit
> > ac5954ee36a5 ("btrfs-progs: merge subvol_uuid_search helpers"). Before
> > this commit subvol_uuid_search() was a wrapper around subvol_uuid_search2
> > and it guaranteed to either return well-fromed 'si' or NULL. This was
> > sufficient for the check after the out label in process_clone.
> > 
> > Properly handle this new semantic by changing the simple null check to
> > IS_ERR_OR_NULL which covers all possible return value of
> > subvol_uuid_search.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > Reported-by: Chris Muprhy <lists@colorremedies.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com/
> 
> 
> Qu pointed me to
> https://patchwork.kernel.org/project/linux-btrfs/patch/20220102015016.48470-1-davispuh@gmail.com/
> 
> which is essentially the same patch. So you can drop this.

As suggested I've updated the changelog with yours as it's more
descriptive, thanks.
