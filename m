Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA09673661
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjASLKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 06:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjASLJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 06:09:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69AF8;
        Thu, 19 Jan 2023 03:09:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FCC32068E;
        Thu, 19 Jan 2023 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674126595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAFJMryVcpyXrf5LWF121mC0VtNekDtxbPyfhUaS35I=;
        b=zXC+68UesRdukbwuvzkYCsexacnUQnwDXx7ug1mzCm+Q7559et+IfAr9c0E+1KQXj6eWv0
        IOVbd4FlDY5uNv07Q8NwQsvhjSraUE+4rcI8Uhi0/+NjoEzdTlPEikdqrNDsJQgIVVr8+q
        h6DmyZbBvzF4dBaOdXI73XV4X7sTZiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674126595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAFJMryVcpyXrf5LWF121mC0VtNekDtxbPyfhUaS35I=;
        b=mmeo0m1BYAyb43ucmzAJ9pA3LaocMk9SpyFdmQ/PaHHnGTzrtb+rAkUNju99dnPycCyel6
        JQ8WTW2Byz7OtYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2351A134F5;
        Thu, 19 Jan 2023 11:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZFqdBwMlyWMnNAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Jan 2023 11:09:55 +0000
Date:   Thu, 19 Jan 2023 12:04:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ye.xingchen@zte.com.cn
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: =?iso-8859-1?Q?R?=
 =?iso-8859-1?Q?emove_compilation_errors_when=A0-Werror=3Dmaybe-uninitiali?=
 =?iso-8859-1?Q?zed?=
Message-ID: <20230119110416.GG11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202301191357131455025@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301191357131455025@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 01:57:13PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> fs/btrfs/scrub.c: In function
> 'scrub_raid56_data_stripe_for_parity.isa.0':
> fs/btrfs/scrub.c:3297:9 error: 'ret' may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
> 
> fs/btrfs/scrub.c: In function
> 'scrub_simple_mirror':
> fs/btrfs/scrub.c:3530:9 error: 'ret' may be used uninitialized in this
> function [-Werror=maybe-uninitialized]

What compiler and version do you use?
