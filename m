Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57946D4E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhLHN7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 08:59:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLHN7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 08:59:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AD92212C1;
        Wed,  8 Dec 2021 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638971777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aM7Ds9Uba3Ls3Ed08/7Ak75XDJmWW09L6/si3mkWngU=;
        b=kCFjp5pU1mQG67wZJ1VTxKmMo8kqghHOjoHymwvHM2wN8ELMIZEYqtjrORszaNphHa3PJ9
        C88bypUTpC4QfSz+KFGzz+GKgRM8WaeF0N/p8qaqve+q2trlIpw4vtwbWV2fG3FEZTER0Y
        k0jbbSAvhkOywuDWcAnaa0GuKooDs+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638971777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aM7Ds9Uba3Ls3Ed08/7Ak75XDJmWW09L6/si3mkWngU=;
        b=tGd7CjbZX4xhKIQvU6r6pqgxn4Aghinr7+u6Sjsi0FFZX5LdtB4bxEDfdAzdR5dOj+/rZn
        B4bOggCLQIlk9dDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id ED5BBA3B85;
        Wed,  8 Dec 2021 13:56:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9270CDA799; Wed,  8 Dec 2021 14:56:01 +0100 (CET)
Date:   Wed, 8 Dec 2021 14:56:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH] btrfs: zoned: convert comment to kernel-doc format
Message-ID: <20211208135601.GJ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20211203064820.27033-1-rdunlap@infradead.org>
 <20211207194820.GH28560@twin.jikos.cz>
 <28105cc3-88b0-763d-5bc5-06eb67ee130f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28105cc3-88b0-763d-5bc5-06eb67ee130f@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 04:43:15PM -0800, Randy Dunlap wrote:
> On 12/7/21 11:48, David Sterba wrote:
> > On Thu, Dec 02, 2021 at 10:48:20PM -0800, Randy Dunlap wrote:
> >> Complete kernel-doc notation for btrfs_zone_activate() to prevent
> >> kernel-doc warnings:
> >>
> >> zoned.c:1784: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >>  * Activate block group and underlying device zones
> >> zoned.c:1784: warning: missing initial short description on line:
> >>  * Activate block group and underlying device zones
> > 
> > We've been using a slightly different format than the strict kernel-doc,
> 
> I'm sorry to hear that.

I feels like the kdoc format is meant for generating documentation and
has some requirements that I do not consider too human friendly, like
mandating the function name AND the function description on the first
line no matter how long it is. I'd rather have something for developers
where first line is summary of what the function does and list of
parameters to verify.

> > in this cas the function name is not repeated (because it's right under
> > the comment), what we want is the argument list checks (order and
> > completeness).
> 
> Please just eliminate/prevent the warning then.
> I don't care how it's done.

It used to work and got changed/broken in 52042e2db452 ("scripts:
kernel-doc: validate kernel-doc markup with the actual names"), we
actually wanted to enable kdoc checks by default in our local Makefile.

We were working on that with Nikolay and he asked Mauro if the function
name could be optional. No answer so we get the warnings.
