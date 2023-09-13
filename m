Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD69779EE3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIMQ1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQ1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 12:27:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4490
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 09:27:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C0E7218FB;
        Wed, 13 Sep 2023 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694622419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0WMuLjUhK2MpEho6VyOUwSVRk4SCIrJphUx14VmauE=;
        b=KmirrFSVihW5JvSliaxgtkEB15zuuJzcZ6KXy6qobEadCWFNf6kmqqCz163x27ptitk6OJ
        4R5tI8JpEp0z2J+ULLcjy/KYuEIOzH76ezSblFgkVWlBM5NoFXmaxDx8BR2TgIMj1YDvYq
        NZ7rQTr60woa3EocR0YnUj+W8ex2IHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694622419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0WMuLjUhK2MpEho6VyOUwSVRk4SCIrJphUx14VmauE=;
        b=LA9FT9/uDvni2t3yOQoEQFa7cdpKwh1jP1z4Z4zCGzz4RoGtZtdvZpvXheHxnZduv7w+Py
        WWUMM7u1rIJUsMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D76513582;
        Wed, 13 Sep 2023 16:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wXrMHdPiAWUuHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:26:59 +0000
Date:   Wed, 13 Sep 2023 18:26:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, gpiccoli@igalia.com, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: scan forget for no instance of dev
Message-ID: <20230913162657.GP20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d18a400b7708b2405278122c264357918be3bc5d.1694503804.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18a400b7708b2405278122c264357918be3bc5d.1694503804.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 12, 2023 at 03:39:59PM +0800, Anand Jain wrote:
> In commit d41f57d15a90 ("btrfs: scan but don't register device on single
> device filesystem"), the code scans the device but refrains from
> registering the single device filesystem. Consequently, there's no reason
> to report an error when running the 'btrfs device scan --forget <dev>'
> command for a single device if 'dev' is not present in the device_list.
> In such cases, returning success is the appropriate.

Right.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> This patch fixes the failure reported by the test cases in btrfs/254,
> due to the kernel commit d41f57d15a90. So this can be folded into it.

Folded, thanks.
