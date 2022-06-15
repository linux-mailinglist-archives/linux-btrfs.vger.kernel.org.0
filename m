Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426754C8AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348791AbiFOMhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiFOMhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 08:37:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0711A17;
        Wed, 15 Jun 2022 05:37:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCBD21C57;
        Wed, 15 Jun 2022 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655296655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YLIsRrTNVKNWsVV6cBwgMPUHAX8zrsCLHmgPHgYmPg=;
        b=gzd7GOw9PGuontyw9ScLi+5HoU6i053i7NlflFMhEF0ucKsEAdSTfyOxn4KO72lDnlbfZs
        uwfHS3Ed81h926ihfBfAQV0EUartpHHiHFXQ62gJTRdo/uYoTet8wIuQsMnJju3wT3pNKu
        N66N+7EgrmV6lLuLYg/ZVXRqXt0OPKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655296655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YLIsRrTNVKNWsVV6cBwgMPUHAX8zrsCLHmgPHgYmPg=;
        b=qmEq6BPG15gbmIOrmGPsqpLsohXOy6bHHSd1hGL7JNeCybRKg1cDejhyXd3Gugq+/CxCkT
        811ZXmkRnp9oSLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42D3713A35;
        Wed, 15 Jun 2022 12:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tRZlD4/SqWItEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 12:37:35 +0000
Date:   Wed, 15 Jun 2022 14:33:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix typo in comment
Message-ID: <20220615123301.GW20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Xiang wangx <wangxiang@cdjrlc.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220609142405.51613-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609142405.51613-1-wangxiang@cdjrlc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 10:24:05PM +0800, Xiang wangx wrote:
> Delete the redundant word 'we'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Thanks, but we'd rather do typo fixes in bigger batches and the one you
fix does not cause confusion or is not a typo in some function name or
identifier.
