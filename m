Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD0F62460B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 16:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKJPfc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJPf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 10:35:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86AB5F79;
        Thu, 10 Nov 2022 07:35:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8096F22959;
        Thu, 10 Nov 2022 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668094525;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWGMqcTvBUZ8KkaaYB6Ti/Idg8VHTx4i1REOZXrCybU=;
        b=Zwr+QbfNeqhdMZKg/EYhU8sbL+O+Id4gEizDyosW9Hmty+AdDMK8Lh73iQ0LV1eT6O7JKg
        XA6upqwiZSXyNWyq/0yyi89ADnes80ZAGbH+xvcgJF18SkVUaPWp8In4VkV+YU+Lqp/vz3
        z/d5P2ssa0R34Edia9GVs/ogpT7SvtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668094525;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWGMqcTvBUZ8KkaaYB6Ti/Idg8VHTx4i1REOZXrCybU=;
        b=ckKcm3aQh5xEIIBrzVJX/5fq1x7GMTFJzLy5pyhCFD147knrpBEFzTz7uh7D42tcochrmf
        DAXP8IBzGW0VjpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4894813B58;
        Thu, 10 Nov 2022 15:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kqa8ED0abWOeSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Nov 2022 15:35:25 +0000
Date:   Thu, 10 Nov 2022 16:35:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Message-ID: <20221110153502.GH5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
 <20221110144630.GF5824@suse.cz>
 <3198e463-2002-dc08-6d27-d4d0468b6da8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3198e463-2002-dc08-6d27-d4d0468b6da8@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 10:59:56PM +0800, ChenXiaoSong wrote:
> I have _no_ link to the report, I just reproduce it in my own qemu vm, 
> and _no_ c or syz repro.

I see, we've got several reports from syzbot, I thought you're fixing one
of them.
