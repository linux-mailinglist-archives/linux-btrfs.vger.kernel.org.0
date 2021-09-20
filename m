Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FBF4113AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhITLnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:43:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhITLnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:43:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CEB9D21DCC;
        Mon, 20 Sep 2021 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632138094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gg7NYEaNgRCqvlFbtiF8JLmwEYGv9e2nw8TNf/JQsAE=;
        b=GegjSLUsowHR2KncZACyWp+f6MyuLnnV6FEKRtPq42moypdRR+SGwfHWVK7rx0YuLziDSh
        BQT3Q8jQpbZ7KTmgLXLlpZc/MVlXWsaeiSnmM5hONhQkLUYGcVaKG4qxZs1QGggPqoIZxq
        9YYVJRSAq8kXk5iIxnaBrX6Sicni6Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632138094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gg7NYEaNgRCqvlFbtiF8JLmwEYGv9e2nw8TNf/JQsAE=;
        b=4BLK1qEclz+PzAoZNRB39qMFERk/A60s9quZZvS+cY7yi7W4tpt/Kf69wZ+6dGjSYDoGRA
        dEI9gn4zODtMwiBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C7DD8A3B87;
        Mon, 20 Sep 2021 11:41:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E805DA7FB; Mon, 20 Sep 2021 13:41:23 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:41:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/8] btrfs-progs: Add btrfs_is_empty_uuid
Message-ID: <20210920114123.GI9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-2-nborisov@suse.com>
 <15a241b0-e545-7603-f287-811216ca2eef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a241b0-e545-7603-f287-811216ca2eef@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 16, 2021 at 03:26:30PM +0800, Anand Jain wrote:
> On 14/09/2021 17:05, Nikolay Borisov wrote:
> > --- a/kernel-shared/uuid-tree.c
> > +++ b/kernel-shared/uuid-tree.c
> > @@ -109,3 +109,14 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
> >   					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> >   					  subvol_id);
> >   }
> > +
> > +int btrfs_is_empty_uuid(u8 *uuid)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
> > +		if (uuid[i])
> > +			return 0;
> > +	}
> > +	return 1;
> > +}
> > 
> 
>    You could use uuid_is_null(). No?

Yeah, no need to duplicate that.
