Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45F93F8AE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbhHZPVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 11:21:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhHZPVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 11:21:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D6212233C;
        Thu, 26 Aug 2021 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629991245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBprdSqD8VKP2rhFRgmlqwFIgjKC4P72prvIXotP8C8=;
        b=k1FOLiu3XinukZgZv6YhvDXJ8VK8TdCHiuTkUgsrAf0gvBM+KAKVpAO7DnCHKBVXJwztIj
        5cT+j5aHUwLEKcXyLu58UKiYpEUS1uZBCamGe16Kp78hX2hkqKWQYwGOZ8qQTQ8Ac75USF
        qX5yeWhm7flJMhYeEvlCyQLGpe5AmXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629991245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBprdSqD8VKP2rhFRgmlqwFIgjKC4P72prvIXotP8C8=;
        b=AJDxstaAfbnrULHrUyO+qNYab44yPp+1uDWo+6w3bbwubgRKw6uYwagFtUNIFk4cM2L1xG
        v9eKjFtsIvrBkdBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 05E70A3B89;
        Thu, 26 Aug 2021 15:20:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7220DA7F3; Thu, 26 Aug 2021 17:17:56 +0200 (CEST)
Date:   Thu, 26 Aug 2021 17:17:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3] btrfs: reflink: Initialize return value to 0 in
 btrfs_extent_same()
Message-ID: <20210826151756.GN3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20210826144436.19600-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826144436.19600-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 02:44:36PM +0000, Sidong Yang wrote:
> This patch fixes a warning reported by smatch. It reported that ret
> could be returned without initialized. 0 would be proper value for
> initializing ret. Because dedupe operations are supposed to to return
> 0 for a 0 length range.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>  - Removed assert and added initializing ret
> v3:
>  - Changed initializing value to 0

I've slightly rephrased the changelog, added to misc-next, thanks.
