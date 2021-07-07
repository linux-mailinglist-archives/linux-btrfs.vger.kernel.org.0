Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5B3BEA7B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhGGPPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:15:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41822 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhGGPPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:15:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D142D225D4;
        Wed,  7 Jul 2021 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625670746;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMAhYfgwZ6ktGU+w3NcAWSM90d1zd/UrZ0R+FT/l/iw=;
        b=b8ifOig0vWWQdOlfTGn5t++GOh5OiQgRBV6MGtxPDwE6YtYmnvXWNrev9SORJ7TJPcjJij
        GBib7aOFsNLDDSVWUCx8VBGFQuICq45wcT/0umdwQS045UsO8V26MxYxYMggZfURMYWdf/
        viBY7P6IseqK8BQ1Yz+ZBVq/1U/tEIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625670746;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMAhYfgwZ6ktGU+w3NcAWSM90d1zd/UrZ0R+FT/l/iw=;
        b=8c9/JvFQeFGCsA+2sHDBTkQB786SF1uPDB64it3XRKg6EEZVsmS0N5hPekLktKZtjfnIbj
        feX2+W4O2PjNpoBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CA555A3B9A;
        Wed,  7 Jul 2021 15:12:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 224ABDA6FD; Wed,  7 Jul 2021 17:09:53 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:09:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: check-integrity.c: drop unnecessary function
 prototype
Message-ID: <20210707150953.GN2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <4c86a5893d4d89f71e99f531b27728680f9c9e1b.1625475957.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c86a5893d4d89f71e99f531b27728680f9c9e1b.1625475957.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 05:06:18PM +0800, Anand Jain wrote:
> The functions prototype deleted as below aren't necessary as those
> functions are first defined before called. So they are removed here.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
