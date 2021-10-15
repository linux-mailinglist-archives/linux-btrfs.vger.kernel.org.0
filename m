Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4149642EEB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhJOKXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 06:23:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhJOKXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 06:23:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C7BD21FD39;
        Fri, 15 Oct 2021 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634293265;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5GaKTmeYdmqZD8ocSMe72Ne2xSV1eRN+NyQKT640qs=;
        b=G3Ym1dPjBDBqhEC6qJpnUlKYFK2JmUdARGWgX5b/P7T28lRLpsNwoFrqAI7cZAxHDyk2vN
        9BjmnHwWpAGRzsFrltSLWy6MAqpeS81RKGqLkNxcNCb7A5HnIiC2ZXyOqNlB7WqM3U0hP7
        Bd8/19ADyFpdgf/fd6kp6Jxq1+NXeIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634293265;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5GaKTmeYdmqZD8ocSMe72Ne2xSV1eRN+NyQKT640qs=;
        b=L2/EC0Mzwm3Dez3zTmEiRj4iKswyaijKa69GIWB8oJpd7CD+cfIQijrJn28n0sGZNcahJf
        OC9elpQ4IDSAuWBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C088EA3B89;
        Fri, 15 Oct 2021 10:21:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CF87DA7A3; Fri, 15 Oct 2021 12:20:40 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:20:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lost error handling when replaying directory
 deletes
Message-ID: <20211015102040.GA30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <d580b8836d741d5f474536ddcb262dcd26de6262.1634228346.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d580b8836d741d5f474536ddcb262dcd26de6262.1634228346.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 05:26:04PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At replay_dir_deletes(), if find_dir_range() returns an error we break out
> of the main while loop and then assign a value of 0 (success) to the 'ret'
> variable, resulting in completely ignoring that an error happened. Fix
> that by jumping to the 'out' label when find_dir_range() returns an error
> (negative value).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
