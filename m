Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD83991EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFBRvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 13:51:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFBRvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 13:51:09 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A20B81FD30;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmghgJj5TOxWt7oAk6tmXYL4c5FHoFn9dS2PGd6Sm68=;
        b=BECU3UIPup7ss7EN/YzMrGSoFKSXeyXjgLZfXkhcuDELJFXxwjJOTW6XjxFvfU5TJaQB8q
        LBYLjTflRJvB56aqG361Cw5d8XoNS+TsGyI5afPblZBTCELpFqkAzCC0SWZvEL3hLlfpqR
        jhKImhEAmIjnLfkabkq7d1RX0xsCPCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmghgJj5TOxWt7oAk6tmXYL4c5FHoFn9dS2PGd6Sm68=;
        b=5REC4EMDCXldfnOiU+UWSQLNXaiNP+o+Qdlzw+cvH2CffoiHZx5Fh+x0BenvJddt3gJB8w
        WuZxJ23g6xYYpBBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 99399A3B84;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 440F7DA8A7; Wed,  2 Jun 2021 19:39:50 +0200 (CEST)
Date:   Wed, 2 Jun 2021 19:39:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
Message-ID: <20210602173949.GS31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, riteshh <riteshh@linux.ibm.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210602022239.7ueomwrumsbbc5wu@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602022239.7ueomwrumsbbc5wu@riteshh-domain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 02, 2021 at 07:52:39AM +0530, riteshh wrote:
> I have completed another 2 full iterations of testing this v4 with "-g all" on
> Power. There are no failures reported (other than the known ones mostly due to
> defrag disabled) and no kernel warnings/errors reported with v4 of your patch
> series (other than a known one causing transaction abort -28 msg, but that seems
> to be triggering even w/o your patch series i.e. with 64k blocksize too).
> 
> >From the test perspective, please feel free to add below for your v4.
> 
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> 		[ppc64]

Thank you very much for testing, I've added the tag to the series.
