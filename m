Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71D59EDAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiHWUnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiHWUm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:42:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7B27B
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 13:34:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 152681F890;
        Tue, 23 Aug 2022 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661286893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFZIYct8rJVZDwfUWVk0FhGwitSGqaXX8iCDJn4ijh4=;
        b=MUaS7SP8oK4luAs3NGhjwBk9dnQODvYuSMDZcoKdLZQPDbg6YH3SNOLhqG4FMuqSrau8Pu
        /irRRId8R2LLMtp0Bz9gvvfcbPOOcbNLEKYegFTk08FFIh+xgot2vyUGAvx9VjBLJ3K0Zs
        ORWe9IjEezYK6UJs+t6w9HbmwpuRIIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661286893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFZIYct8rJVZDwfUWVk0FhGwitSGqaXX8iCDJn4ijh4=;
        b=LLr1zPwQhlQxc109KwFk2nRcuUl/a90AskI5js9ZedTbh+6Ty6bYJ0wEoj/QxhjpIVf9IS
        4/v2G6PLCqk7mvAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC29A13A89;
        Tue, 23 Aug 2022 20:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N/iYOOw5BWPHBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 20:34:52 +0000
Date:   Tue, 23 Aug 2022 22:29:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix filesystem corruption caused by space
 cache race
Message-ID: <20220823202938.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <cover.1660690698.git.osandov@fb.com>
 <20220823172744.GK13489@twin.jikos.cz>
 <93a3faed499875c9ef51cf1b0acc29b213dbf28a.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a3faed499875c9ef51cf1b0acc29b213dbf28a.camel@scientia.org>
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

On Tue, Aug 23, 2022 at 09:20:57PM +0200, Christoph Anton Mitterer wrote:
> Any chance to get this ASAP in the stable kernels?

Yes, it'll be in the -rc3 batch and then it gets picked to stable within
a week, depending on the stable release schedule.
