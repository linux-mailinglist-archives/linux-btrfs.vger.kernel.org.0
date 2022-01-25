Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB849B8D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583707AbiAYQfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 11:35:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37298 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379839AbiAYQds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 11:33:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 847761F380;
        Tue, 25 Jan 2022 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643128426;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJmJL5UxFlc6fZCNy3BAQXc45Snx52JPjZuTalRhuWo=;
        b=2VZOaZKaN5XfPhGcqNE87GlHAk3/V2YGa6soamTD0E0BpMm0LEj8pN3GTy8HhyILKY0Fzr
        bRCow7+/AlEQDudCyWAL7zOZRcO+tTC11ZwzjRadO+JvogZnhI4OLfDLFIZvXDjcFPPiYH
        Z0sFiqpT/em8hz2T3DX1nZVhw/awUXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643128426;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJmJL5UxFlc6fZCNy3BAQXc45Snx52JPjZuTalRhuWo=;
        b=lgFndCyk/c/l8ClZ8hXpiApyJhSr2GlBFJFWWnrJqasPogQX85W5eqX0nHVA47tsg7ArVP
        uGR+WMkbV2mLzMBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7C641A42AE;
        Tue, 25 Jan 2022 16:33:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3167DDA7A9; Tue, 25 Jan 2022 17:33:06 +0100 (CET)
Date:   Tue, 25 Jan 2022 17:33:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: make generic_err print physical address of
 extent buffer
Message-ID: <20220125163305.GS14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20220121093429.1840437-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121093429.1840437-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 05:34:29PM +0800, Su Yue wrote:
> Unlike kernel, we have cached physical address of extent_buffer in
> dev_bytenr. Print it for better debug experience.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to devel, thanks.
