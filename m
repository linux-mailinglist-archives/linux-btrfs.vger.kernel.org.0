Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39969856A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBOUTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 15:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOUTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 15:19:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5229143
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:19:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3967C33744;
        Wed, 15 Feb 2023 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676492358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mo22l+ZMRRy2cs0d6xjWq0O4pmfXdFoukV80xyK6Dg=;
        b=SeJM0z5AtcO3y6skry32E74YjCMtilf3UcmClG658/HL9LQ80h/ugyx5gYzvzJ/cGU0r9x
        8KpqtJMsijX0oGL5dopcfmK3jhLIjMvirGss4bmdbXI13bRDo1lcpq8w/UwEupovM3HwZ9
        6ANfCzevQkzEvYhP8wdvqhvKhqpKaLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676492358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mo22l+ZMRRy2cs0d6xjWq0O4pmfXdFoukV80xyK6Dg=;
        b=QePWc1hAu0KkN91qDv+m8wA1jEfN+630kj9bRlzyZLqt5TEH0HI/mchyVz8Ea8CAwHO+bp
        xlFOgK0OYJMPh5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08B7E134BA;
        Wed, 15 Feb 2023 20:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NWsnAUY+7WNDGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 20:19:18 +0000
Date:   Wed, 15 Feb 2023 21:13:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Message-ID: <20230215201325.GY28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230120074657.1095829-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120074657.1095829-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 20, 2023 at 08:46:57AM +0100, Christoph Hellwig wrote:
> These days all the operations that take locks in the raid56.c code
> are run from user context (mostly workqueues).  Drop all the irqsafe
> locking that is not required any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to for-next, thansk.
