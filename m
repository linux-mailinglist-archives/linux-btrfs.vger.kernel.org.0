Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAE3ABD62
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFQU2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 16:28:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51128 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhFQU2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 16:28:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F70A21AC8;
        Thu, 17 Jun 2021 20:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623961585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fdq/mb/3atVjlCFxTzvhXnes3qlLANRcEhkHCKDzaDk=;
        b=twMsZF0gthqn84eZzG987S8RVmHPxgOVlXZqAtJjysx4NB5Kcb9qYAsVxdAZ/Jm4wNn8uz
        OOIeJGurUqjoF5MkW3GdyKEBJ5JULriv6xwHURjsgIdFsDmLDw1O6Kmi22eavMJlSRvnCg
        JXifvv8v9yAEb3VVv/K60npsBSxPnxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623961585;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fdq/mb/3atVjlCFxTzvhXnes3qlLANRcEhkHCKDzaDk=;
        b=BAkI7ADXq5ImaWBfvylWZcBGCFwoRZ4flSYR/R2dHddXCRsGdmSEgULIjJwOE8d6k60a1L
        vkpH59PJ6imE2/CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 078FCA3B85;
        Thu, 17 Jun 2021 20:26:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 278FEDB225; Thu, 17 Jun 2021 22:23:35 +0200 (CEST)
Date:   Thu, 17 Jun 2021 22:23:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: device: print num_stripes in usage
 command
Message-ID: <20210617202335.GX28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210608153520.820445-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608153520.820445-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 08, 2021 at 03:35:20PM +0000, Sidong Yang wrote:
> This patch prints num_stripes for striping profiles in device usage commands.
> It helps to see profiles easily. The output is like below.
> 
> /dev/vdc, ID: 1
>    Device size:             1.00GiB
>    Device slack:              0.00B
>    Data,RAID0/2:          912.62MiB
>    Metadata,RAID1:        102.38MiB
>    System,RAID1:            8.00MiB
>    Unallocated:             1.00MiB
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to devel with minor fixups, thanks.
