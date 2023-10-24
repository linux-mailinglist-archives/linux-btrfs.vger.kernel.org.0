Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D07D5C58
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 22:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJXUXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbjJXUXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 16:23:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D18E8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 13:23:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C803721C73;
        Tue, 24 Oct 2023 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698179019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuzpuOThUCRn/A15vKeNH4hW91VzDigksxOUCk6k5k0=;
        b=hML+tVQo4CIRW6pnUyilXl/CfprdiP56haSAveWth94vna4C9gxCsfM2UamERcAZ5Mjypy
        LG1prl4G8k43f5i3LcbV5alM2kpfCxzvdQrgT/gEAJDJC0DpxDQDwAQfSpf14YH9jE775s
        u7W4Ji9dlLoaRFHsmH2FMuoeFRBhqFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698179019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuzpuOThUCRn/A15vKeNH4hW91VzDigksxOUCk6k5k0=;
        b=sAWEYEnQM6vd++3TJtUSITC9GLAAAVwVmhEjGSKge6RjrDMp26ZN86ZEI8xyJRNQZlO0/m
        vph9nzRDRqYsjEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2A601391C;
        Tue, 24 Oct 2023 20:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k4DyJssnOGV8WgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 20:23:39 +0000
Date:   Tue, 24 Oct 2023 22:16:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: move space cache removal to rescue group
Message-ID: <20231024201645.GV26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b64e4bc22f58a826d65aae73c2eed9ca029f1dca.1698139433.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64e4bc22f58a826d65aae73c2eed9ca029f1dca.1698139433.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.86
X-Spamd-Result: default: False [-7.86 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.06)[60.82%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 07:53:57PM +1030, Qu Wenruo wrote:
> The option "--clear-space-cache" is not really that suitable for "btrfs
> check" group, as there are some concerns:
> 
> - Allowing transid mismatch
> - No leaf item checks
> 
>   Those behaviors are inherited from the default open ctree flags for
>   "btrfs check", which can be unsafe if the end user just wants to clear
>   the cache.
> 
> - Unclear if the the cache clearing would happen along with repair
> 
>   Thankfully the clearing of space cache is done without any repair
> 
> Thus there is a proposal to move space cache removal to rescue group,
> and this patch would do that exactly.
> 
> However this would lead to some behavior changes:
> 
> - Transid mismatch would be treated as error
> - Leaf items size/offset would still be checked
> 
>   If we hit any above error, we should just abort without doing any
>   write.
> 
> These change would increase the safety of the space cache removal, thus
> I believe it's worthy to introduce such behavior change.

I haven't thought about the safety reasons above initially but I agree
that it's better to let the normal checks happen before clearing the
caches.
