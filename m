Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623B33DA832
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhG2QBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 12:01:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhG2QAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 12:00:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 094B720061;
        Thu, 29 Jul 2021 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627574384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SmVnE3uDw5KUKwnUhCaGsvydswHkUKVIOupdm97yRs=;
        b=dhHytPHE58xyU9DPVOlj/Bixnfo9zAmw8r/PpTCOsjf2BrJ8Epn5sIvxwOn4HazIQE04Iw
        DZnC0C14CuBL76qluVaWZN1JlTAAS56Xlifls6P/OA0K2koZWBEED+ScxPsFXHPweww7+z
        B3tqHOsA4fDRxPDtTmCuPgdjS24WOik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627574384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SmVnE3uDw5KUKwnUhCaGsvydswHkUKVIOupdm97yRs=;
        b=rqFzpTD0w2A7zWrPArEetL3LfXh+cbuX/ei5G3icBBiTzKQa4YO3c2TMpasya0k/dMBFbk
        j+xmmafYVkyIQFAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F984A3B8A;
        Thu, 29 Jul 2021 15:59:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08290DA882; Thu, 29 Jul 2021 17:56:56 +0200 (CEST)
Date:   Thu, 29 Jul 2021 17:56:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        boris@bur.io
Subject: Re: [PATCH] btrfs: print if fsverity support is built in when
 loading module
Message-ID: <20210729155656.GW5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        boris@bur.io
References: <20210728162209.29019-1-dsterba@suse.com>
 <12540898-56d3-53e5-df01-21189acb40e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12540898-56d3-53e5-df01-21189acb40e5@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 10:29:32PM +0800, Anand Jain wrote:
> On 29/07/2021 00:22, David Sterba wrote:
> > As fsverity support depends on a config option, print that at module
> > load time like we do for similar features.
> 
>   So similarly /sys/fs/btrfs/features/fsverity may be required too?

Yes, feel free to send a patch.
