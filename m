Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D173F199B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhHSMm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:42:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhHSMm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:42:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F238A1FD3E;
        Thu, 19 Aug 2021 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629376910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ8ERHTPJYfcsrTjVsIY82+IUIL6WLE2IYSmX18CsBA=;
        b=tN4TMevXS7/i9TYp6f3Bno6KOFr/w7qzCX0DdDqcJPcFoQPz2rg+A5gYfDBMSrmlFQvpXa
        Oh1IlxJqsW/jfOsemC0YtmxP5/UvN+0YaDbkccAr9bgn3gY0xgtlEbZ6fuQh6rdv5eR9AN
        Rhku0dBPaDvgU4eZBrTzvhyggI9yKUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629376910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ8ERHTPJYfcsrTjVsIY82+IUIL6WLE2IYSmX18CsBA=;
        b=24y5UJ+luDyBUrJUfDNOEfUik7dWmCkfoxeHKast+wRZ2S+cNvyyqWZEbzV54puM3IMO/V
        5BlJkLyvmudDK/BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 658E0A3B94;
        Thu, 19 Aug 2021 12:41:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B71B5DA72C; Thu, 19 Aug 2021 14:38:53 +0200 (CEST)
Date:   Thu, 19 Aug 2021 14:38:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, fdmanana@suse.com
Subject: Re: [PATCH] btrfs: send: Simplify send_create_inode_if_needed
Message-ID: <20210819123853.GG5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, fdmanana@suse.com
References: <20210801233549.25480-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801233549.25480-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 01, 2021 at 08:35:49PM -0300, Marcos Paulo de Souza wrote:
> The out label is being overused, we can simply return if the condition
> permits.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to misc-next, with the if-else update, thanks.
