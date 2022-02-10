Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6484F4B15BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiBJTCt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:02:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBJTCs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:02:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747E191
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:02:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A327B1F399;
        Thu, 10 Feb 2022 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644519767;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qn55zQbLbk3c8jB+xPgJ7MSdLPW5iO5KEZYGCRQOoGc=;
        b=DMlmAZwg1OYEuWhjrvMGGM12hXQUUGIegRfkSB8Le/CqnfgEzzCyqt3xxbPTZIhgVNr3HL
        oI47UkNW0wur2MuitCzJs4BQn1EbpKoHfFtLOGVnKN5Z7gqI1d0vFyTYJ4unp9ySzHISmL
        2fwo4lUrVyPkBe8aiLNTnNOaD+CN74o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644519767;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qn55zQbLbk3c8jB+xPgJ7MSdLPW5iO5KEZYGCRQOoGc=;
        b=XvuqefixZNHg+QB7b4aZysAw/ydY4jDC7OWK0uc2VexEkrsK2wbgApb9dsUtncaMUAC4CY
        78xL5EggmVBKdgAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9BD26A3B83;
        Thu, 10 Feb 2022 19:02:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33AB5DA9BA; Thu, 10 Feb 2022 19:59:06 +0100 (CET)
Date:   Thu, 10 Feb 2022 19:59:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Remove an oudated comment
Message-ID: <20220210185906.GX12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220210125204.962999-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210125204.962999-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 12:52:04PM +0000, Sidong Yang wrote:
> It seems that btrfs_qgroup_inherit() works on subvolume creation and it
> copies limits when BTRFS_QGROUP_INHERIT_SET_LIMITS flags on.

I think we can delete the whole TODO comment from 2012.
