Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67635391D2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhEZQjC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 12:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhEZQiz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 12:38:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622047043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bd7zMJwwv2uPVde7KhlN62DSitZT/rnXB2GSeqtBqRs=;
        b=hNpua9UT7YWMUm4+liElS3IUD7+QLJpHdkvwm62EiJotcfZXQn6SqYyCjwkkHN63ebxwoc
        yp9TCGr99n6Y3L/291Baem1r26byIkBg7gFTJ12MVsXsrmDd/+KpOpHmnzMhh6XG29ji4j
        ZQ8dzLJBDBnM4ABUhpc6aLsvEPUjdHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622047043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bd7zMJwwv2uPVde7KhlN62DSitZT/rnXB2GSeqtBqRs=;
        b=poBDV+KOYNvHyAe6J8gx19OrgZLqsUOxUy/39vwKfyUSIzP4uwUs2uygv30aVmAZ69aooP
        J53WcqgFalBSGLBg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3FCAB29A;
        Wed, 26 May 2021 16:37:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09A52DA70B; Wed, 26 May 2021 18:34:45 +0200 (CEST)
Date:   Wed, 26 May 2021 18:34:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: optimize users of members of the struct
 compressed_bio
Message-ID: <20210526163445.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
 <19bd55230c326edc303c574acd2eb2e4312aa941.1622018450.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bd55230c326edc303c574acd2eb2e4312aa941.1622018450.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 26, 2021 at 04:40:54PM +0800, Anand Jain wrote:
> Commit
>  btrfs: reduce compressed_bio member's types
> reduced some of the members size.
> 
> It has its cascading effects which are done here.

Agreed, feel free to send it as proper patch(es) (also updating the
async_extent). The compression code uses a lot of types that are wider
than necessary, so optimizing that could improve the stack footprint.
