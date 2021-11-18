Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728E7455DD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhKROVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 09:21:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47190 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhKROVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 09:21:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 501C21FD35;
        Thu, 18 Nov 2021 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637245132;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8/KIVcnS8pWcfah4eSAeHSZ2eabvRj99qS5/pNvCtNM=;
        b=NDETvMhLy3TdE3fe6VAUEbId7yzqwhDS1aYifdUrl+/cPgAw7jD/oBF64vX/1Q4Ng6a5d8
        tkE+fkka2RZoMrGqHes1LGXp6j1y7KX1o5WMzqdYosSqMYEkJZZqEUkea71TUmGoq9sVnO
        Qpby0OcyiMey0qZtNvmmyP6OmpBVKgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637245132;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8/KIVcnS8pWcfah4eSAeHSZ2eabvRj99qS5/pNvCtNM=;
        b=jGYDPDmo7cx4mApjmKd4cAb263NisAZfsLaGFJahkCB5nU1341tnXS3AFF4K+kpZeN91CR
        DfgSjn5DAPPuvwAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 470DEA3B83;
        Thu, 18 Nov 2021 14:18:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97C7CDA735; Thu, 18 Nov 2021 15:18:47 +0100 (CET)
Date:   Thu, 18 Nov 2021 15:18:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 13/17] btrfs: add send stream v2 definitions
Message-ID: <20211118141847.GC28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:23PM -0800, Omar Sandoval wrote:
> @@ -113,6 +121,11 @@ enum {
>  	BTRFS_SEND_A_PATH_LINK,
>  
>  	BTRFS_SEND_A_FILE_OFFSET,
> +	/*
> +	 * In send stream v2, this attribute is special: it must be the last
> +	 * attribute in a command, its header contains only the type, and its
> +	 * length is implicitly the remaining length of the command.
> +	 */
>  	BTRFS_SEND_A_DATA,

I don't like the conditional meaning of the DATA attribute, I'd rather
see a new one that's v2+. It's adding a complexity that's not obvious
without some context.
