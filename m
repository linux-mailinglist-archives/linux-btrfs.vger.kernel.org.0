Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9998E398E3A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhFBPT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 11:19:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52720 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFBPTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 11:19:55 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 97CFA224CD;
        Wed,  2 Jun 2021 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJTxhBGFQiyzel+sx2EdJVoeVETMQPyiykR/F5vU59E=;
        b=ipWCNxwEZyx8DE0K1ky9VgNwhM6HZ89Rtp4ifVSYpK6NTOexM0ezwgtLfc6wapsCi0T7TG
        bZjX7zRB1vkaMrA6nOyCX3r+0kjVnIi6zKzsgQG8wWuLoshD3qdcIjXWgV3MYpPLFiHNWa
        44EqvBPrwsELyhLlwNbRkJaDe1TnGJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJTxhBGFQiyzel+sx2EdJVoeVETMQPyiykR/F5vU59E=;
        b=6E07+H4ToLF85VPBeDRvoXOiKyMMPo84GOqATcUxxUwfMh53WdQAv3CHv4y8OTLG06kzRM
        pXa4+wJz8bE0//Bg==
Received: by relay2.suse.de (Postfix, from userid 51)
        id 954A2A3DEE; Wed,  2 Jun 2021 15:50:01 +0000 (UTC)
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AD3F3A7E41;
        Wed,  2 Jun 2021 14:37:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46B79DA734; Wed,  2 Jun 2021 16:34:45 +0200 (CEST)
Date:   Wed, 2 Jun 2021 16:34:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: Eliminate insert label in add_falloc_range
Message-ID: <20210602143445.GN31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210601060815.148705-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601060815.148705-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 01, 2021 at 09:08:15AM +0300, Nikolay Borisov wrote:
> By way of inverting the list_empty conditional the insert label can be
> eliminated, making the function's flow entirely linear.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>

Added to misc-next, thanks.
