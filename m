Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BDC3D13D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhGUPh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 11:37:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhGUPh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 11:37:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 561E21FEB7;
        Wed, 21 Jul 2021 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626884282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTMfK5ebpU9HHSGev/JNtrwedyGgYkTBxaVZIVFk1ok=;
        b=m5ZY07DGjqr+QD1sG5vboFa9Clxw7FgS0dMbrQEe9UHXGBG2ivnF/0o1Qllp4DF1eidEPH
        6pX1/LEltGZVqsjwPTWqdyMxWCSjaxqcNQB5iH7GwFs6ciCKUmd9esoKzjKnCzSl1cI3QZ
        MmjzSwlk3MmY64Zu/ebcTZCA1sAjneo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626884282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTMfK5ebpU9HHSGev/JNtrwedyGgYkTBxaVZIVFk1ok=;
        b=GEL1MXgQ0iGcrAvHI2ie6rcB6Jvhjmt2GUGvsUcWDBQLaqIC1pmEHF2GdsO2XoPSLrDy8v
        W3FalA5lIeAe2OBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4C6A4A3B95;
        Wed, 21 Jul 2021 16:18:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18A22DA704; Wed, 21 Jul 2021 18:15:20 +0200 (CEST)
Date:   Wed, 21 Jul 2021 18:15:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/8] btrfs: no need to grab a reference to disk->part0
Message-ID: <20210721161520.GJ19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210721153523.103818-1-hch@lst.de>
 <20210721153523.103818-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721153523.103818-6-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:20PM +0200, Christoph Hellwig wrote:
> The struct block_device for the whole disk will not be freed while
> the disk in use, so don't bother to grab a reference to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>
