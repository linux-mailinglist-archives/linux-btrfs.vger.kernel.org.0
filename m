Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617D64D8BF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 19:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbiCNS6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiCNS6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 14:58:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D387679
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 11:57:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 84D021F37E;
        Mon, 14 Mar 2022 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647284255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJrcUMqbaHaCWii0uaEPMekjsnKOyHRAW4V+MPjW8R0=;
        b=FIEXtgX5Mh7ExTJ6CDEgmQGBpQ5i4+WNhpFhM8FPTUJW9rWa2e3U/6u3DWCNlF/sW8aS7T
        noLFFpqfFg54+QFTpn92hEjiZgP4b9z+rar4gwalCE4WBsadu92LuYfA4yhCOSzR7U/jan
        dAOrrocRS5hKWttp9nGmeGhnO/fFGnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647284255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJrcUMqbaHaCWii0uaEPMekjsnKOyHRAW4V+MPjW8R0=;
        b=2DujkUpmK+WKB/TeJ7Zo1uGrqzxvoIibXlzY4wF0wCpIRjeav8WFAoYhJck3Cz7jW8UmTx
        p6UrfPFFI/xVNDAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7C546A3B81;
        Mon, 14 Mar 2022 18:57:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2833DA7E1; Mon, 14 Mar 2022 19:53:36 +0100 (CET)
Date:   Mon, 14 Mar 2022 19:53:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: btrfs_dev_replace_finishing use fs_devices pointer
Message-ID: <20220314185336.GL12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <98ecea7936c8b9abbc5a111942b2f95dc395bdb3.1647218125.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ecea7936c8b9abbc5a111942b2f95dc395bdb3.1647218125.git.anand.jain@oracle.com>
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

On Mon, Mar 14, 2022 at 10:09:29AM +0800, Anand Jain wrote:
> In the function btrfs_dev_replace_finishing, we dereferenced
> fs_info->fs_devices 6 times instead keep a pointer to the fs_devices.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
