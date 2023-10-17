Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82F7CD114
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 01:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjJQX4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 19:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjJQX4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 19:56:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28689F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 16:56:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B98B1FD8F;
        Tue, 17 Oct 2023 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697586995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaKV0fZqUJinDYp5+A7qMi58h7ouyBLTpr0n8kcdu88=;
        b=FSlgPoWQ1t5hDcGMf9oUTPPtrVOIlWAz5S1Kuc8bdtEMrtpvWWMBmf9WnFgTF0KPZEfDHb
        HBYFJIxk7XEDvVCQjafl0NY8UUrQY4VwQ1qLC/vlU87T0OQlJTDUxgjfFnEPQvEPiJAfCL
        TsVqYTNy45HLFAgWjNP+a0dQXzxxpIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697586995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaKV0fZqUJinDYp5+A7qMi58h7ouyBLTpr0n8kcdu88=;
        b=3Rd8I6POeO8r4+r5VTH8I+IU8H5xvrG7GP3iHeztN2CBO4AtJocaQLLzt6urdF3e3JosGo
        sW7uCZuI/6Ay0XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B79B13438;
        Tue, 17 Oct 2023 23:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p0nUCTMfL2WJJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 23:56:35 +0000
Date:   Wed, 18 Oct 2023 01:49:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
Subject: Re: [PATCH 0/2 v2] btrfs-progs: mkfs: testing cloned-device
Message-ID: <20231017234945.GB26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696304038.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696304038.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.39
X-Spamd-Result: default: False [-5.39 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.59)[92.38%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 03, 2023 at 11:46:12AM +0800, Anand Jain wrote:
> v2:
> Worked on review comments from David.
> 
> --- v1 ---
> This patchset adds support for testing cloned-device in mkfs.
> So using mkfs.btrfs both option -U and -P a new device can be created
> to match the FSID and UUID of an existing device. This is useful for
> testing cloned-device.
> 
> Anand Jain (2):
>   btrfs-progs: document allowing duplicate fsid
>   btrfs-progs: add mkfs option for dev_uuid

Added to devel, thanks. I did some fixups, the device uuid is printed in
the summary and validation of the device uuid.
