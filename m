Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74B33FDF93
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbhIAQRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 12:17:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47408 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhIAQRo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 12:17:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8EE8022567;
        Wed,  1 Sep 2021 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630513006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWSMchZddacTOjlQTfdbSi8hvg8k1wW1+gK9i1Kz3AU=;
        b=Oc0+XQWGarlqAoHGJasOA3l/AGc1zMHT8+76EZH8ppm/eSnVgClwQbzMvsm1BHQ9ByAAGn
        u6ONg8LDK4KNNHDsY1SCmIpgS4x7O26X3NdrD8q8NdD6ozvPvn27B/6ZGOsjwSa7aTR1/N
        Y6m4d9UuzpkpMkjS5tpMUuE89sI5egA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630513006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWSMchZddacTOjlQTfdbSi8hvg8k1wW1+gK9i1Kz3AU=;
        b=gkACFM5NuoirkH7KYxccTc4LGp91IJf3SrkplXAJGuJz50Vi5ZWTYQ5Dy4AWE7QYGSxgca
        10/MdvKT62+tvBAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 85A90A3BA7;
        Wed,  1 Sep 2021 16:16:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E9ABDA835; Wed,  1 Sep 2021 18:16:45 +0200 (CEST)
Date:   Wed, 1 Sep 2021 18:16:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        l@damenly.su
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
Message-ID: <20210901161645.GN3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
 <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
 <20210824161106.GD3379@twin.jikos.cz>
 <a3af668b-a91a-548f-4ec5-1104bd831a78@oracle.com>
 <20210831154008.GK3379@suse.cz>
 <27d0980b-6d04-ae45-701a-62660779b5ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d0980b-6d04-ae45-701a-62660779b5ed@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 01, 2021 at 04:18:41PM +0800, Anand Jain wrote:
> > But anyway now the 5.15 branch is out and there are several patches
> > regarding the devices so I'm going to spend time on that.
> 
>   Thx. That includes read_policy patchset as well? Let me know so that I
>   can refresh/resend.

Yeah we should finalize that, we have all the building blocks ready.
What's remaining is proper benchmarking, IIRC we haven't found a good
default policy yet.

> 
> >  Also because
> > the recent updates to loop devices started to trigger lockdep warnings
> > that make testing harder and we're missing lockdep in many tests.
> 
>   I am reviewing the patch 1 and 2 in Josef list.

Thanks, reviewing the whole batch should be easier now.
