Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285EF54B41E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiFNPCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbiFNPC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 11:02:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C5205DB
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 08:02:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D53B1F930;
        Tue, 14 Jun 2022 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655218947;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJte+/mB1GwB8VhdCVroTxjZ1+52HmRpwt0E3Mhb4i8=;
        b=KUNA0fJe3SN8i9azd4Bskn3L1nBkSszfhVxZfPkisyAgy/C4eXeL7ADkf1rT5Ww1XYdLD3
        UglywXPnJoQ9qoWwsepj3DAPzoGppnfznIlQJ4Jd4LDXP0ugJL6703091D46hWXk+B+f7q
        5IIgulCdvu5SG4RhDKEXcPpVH/0pxGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655218947;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJte+/mB1GwB8VhdCVroTxjZ1+52HmRpwt0E3Mhb4i8=;
        b=WiC8bpOUTQgFQ6XPquJ23vCPfEord1XpcapyuHQyRBLYvgCYaZfSMOzm6ufoCHBQ10eb4e
        oR57qDi+OHHNykAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E02B1361C;
        Tue, 14 Jun 2022 15:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eOwaEgOjqGIrVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 15:02:27 +0000
Date:   Tue, 14 Jun 2022 16:57:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: reset block group chunk force if we have to wait
Message-ID: <20220614145754.GO20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
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

On Mon, Jun 13, 2022 at 06:31:17PM -0400, Josef Bacik wrote:
> If you try to force a chunk allocation,

Do you mean using the new sysfs force_chunk_allocation ? As the patch
stands I think it could be applied independently but not later than the
sysfs chunk series, or folded in but I'm not sure it's a good idea.
