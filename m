Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131AC499293
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 21:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381667AbiAXUVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 15:21:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53862 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356585AbiAXUTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 15:19:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 77EB41F380;
        Mon, 24 Jan 2022 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643055583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7+xBrMy8xbpGv/B/+bEarRYRWKOzOejGWNdx21pr+8=;
        b=0BwXKKY80oDJji+jcUJUOWVZ/9Rj4jFVEOAUgaA04Gy2JEQui2gMPkaR4Yzv8iornx5u+8
        3Caiox0NIZiXY68QsvYFBpFYqqVKZg3gxhy/vxM0VtSbIhTR1ooAiE3RxNa7C0gMa6L4dr
        PzbTmzjqKG4p6uHuppx8lwJtnYCZLQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643055583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7+xBrMy8xbpGv/B/+bEarRYRWKOzOejGWNdx21pr+8=;
        b=Fc9HySw2tPh1LrEQJvGpZRf5m/eeBOSfugLMCwqgI3t3HKXKgpOm0PDRluWeK+Y0mxpog2
        jfiAiSfps7hy/2Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1ACD1A3B87;
        Mon, 24 Jan 2022 20:19:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CB4EDA7A3; Mon, 24 Jan 2022 21:19:03 +0100 (CET)
Date:   Mon, 24 Jan 2022 21:19:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     cgel.zte@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs/btrfs: remove redundant ret variable
Message-ID: <20220124201903.GI14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, cgel.zte@gmail.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220111015716.649468-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111015716.649468-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 11, 2022 at 01:57:16AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from fs_path_add_path() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Added to misc-next, thanks.
