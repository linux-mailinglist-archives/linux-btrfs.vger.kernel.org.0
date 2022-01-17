Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A83E490F44
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiAQRSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:18:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbiAQRSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 12:18:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED35C212C8;
        Mon, 17 Jan 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642439883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5s4KVtS/ez7aN4O4g5KHZN3Fa6oqkmMRzfDkIjwg6cM=;
        b=dHb41VRtrlYEoE3PrCoIDxq+3O+j3XzR74KZOB0D0zlJRzEzaVvupTDQRrSv0NCyE+h3vh
        ACi8XhAlkZMd9r7LHy7FIcEuCYotWsi9HInwsVxR2Q7j1GR3gEz0+UC9b7wT2TVAEC4eBD
        0oiBnW9pa/RO3xwaFJ1xzdXQVvgmsnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642439883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5s4KVtS/ez7aN4O4g5KHZN3Fa6oqkmMRzfDkIjwg6cM=;
        b=D128qOLOA8U/zdg7BG7BJ6N04RGNZZ1SrVkCYBkwtRSYkJyhPONuq+dR0O7U+j1eTKNYcs
        Rb8OBCEH4QWXSWDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E6752A3B87;
        Mon, 17 Jan 2022 17:18:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78091DA7A3; Mon, 17 Jan 2022 18:17:27 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:17:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: simplify fs_devices member access in
 btrfs_init_dev_replace_tgtdev
Message-ID: <20220117171726.GK14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <c4fbee1481dc132b77f2922acb3d679c9c7bf47b.1642434590.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fbee1481dc132b77f2922acb3d679c9c7bf47b.1642434590.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 11:50:39PM +0800, Anand Jain wrote:
> In btrfs_init_dev_replace_tgtdev() we dereference fs_info to get
> fs_devices many times, instead save a point to the fs_devices.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
