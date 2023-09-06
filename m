Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48F7942C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjIFSGv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbjIFSGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 14:06:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C677CE9;
        Wed,  6 Sep 2023 11:06:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD66321E64;
        Wed,  6 Sep 2023 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694023605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ey9UAaue26FUITi3Sy53sclXKow+Hnx0YF9+1WSZNJY=;
        b=tAxYGLulb0xgzy/Bz8EBaUFjGMoJE3VPf8VmuYkWPMhge7cD/jDrI4t30lDEG6NVvLo71y
        bonOxfF4z32lalvtueW/PvrgxmGGIwQf/8Y5VgpXOUZDPuEUVYCAHO7LcDMEfE078mUWJO
        KMoRqmrI1plA4BledpkzeMpaHGdWouc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694023605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ey9UAaue26FUITi3Sy53sclXKow+Hnx0YF9+1WSZNJY=;
        b=kVGf+10KN5ijz1TBYkECa3STZikvHA5ZczdrjONkPG1K4TooIKq2+g4ka83hlckNsw/Rvs
        6SKuHLA4QUPTj4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E34E1333E;
        Wed,  6 Sep 2023 18:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4o3aJbW/+GTwLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 18:06:45 +0000
Date:   Wed, 6 Sep 2023 20:00:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Btrfs: Replace obsolete wiki url with maintained doc url
Message-ID: <20230906180005.GV14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230822215158.10542-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822215158.10542-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 03:17:47AM +0530, Bhaskar Chowdhury wrote:
> Replaced and removed obsolete url with maintained url.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Added to misc-next with reworded subject and changelog, thanks.
