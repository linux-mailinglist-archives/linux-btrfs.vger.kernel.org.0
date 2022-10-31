Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD66138F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiJaO1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJaO1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 10:27:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ECC64E3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 07:27:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DDA3338ED;
        Mon, 31 Oct 2022 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667226468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rajamOzwDEObBBRsSQLlo8PnNyxghu9etVy+NqO9Yes=;
        b=pTEiUi+7OCtAGdc2aPQuMG0AO0kG27CKCAn2YZy1PwSSrUYpsQMA3MCYwc6uoWT9vSlryN
        B+6fhtgkGH6GMbW+srBl7A2gp0jVVlpzaGz75uD8U0gmb1GWCvOOBF4HeF163989QHj9lJ
        qScATJEqUlfT1ttZ3Q45XpUSqs/8D0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667226468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rajamOzwDEObBBRsSQLlo8PnNyxghu9etVy+NqO9Yes=;
        b=/ouKOf7Ep/QMcPMfl5/TbwQdbgM51VCsl8NUSGDWti9YLvFUc5ZF9VBLcXOvgfEMn4dd+E
        gW0UZncaYCq3EeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D79913ABE;
        Mon, 31 Oct 2022 14:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yWNMDWTbX2NsegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 14:27:48 +0000
Date:   Mon, 31 Oct 2022 15:27:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: properly test for send_stream_version
Message-ID: <20221031142730.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e2742a8d9f88ccd7d46086dfff5d861579abfa0a.1666727387.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2742a8d9f88ccd7d46086dfff5d861579abfa0a.1666727387.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 25, 2022 at 03:49:56PM -0400, Josef Bacik wrote:
> We want to notrun if this test fails, not if it succeeds.  Additionally
> we want -s, as -q will still print an error if it gets ENOENT from the
> file we're trying to grep.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
