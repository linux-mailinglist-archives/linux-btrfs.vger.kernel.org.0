Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1C3FB913
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhH3Phh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 11:37:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58200 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhH3Phh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 11:37:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B2BB122093;
        Mon, 30 Aug 2021 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630337802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5owUn1CVmiCL9vf8pZ9FM+Yys3/QMS+AZd03ZO4Aa4=;
        b=T2sdfBOqVJynzz6HWgg4QU5LzK+LIjO4JmFGNfTQiFpxTn8R7Vkxtr4jBT0VSPhgeLE4cc
        ZjW7g/9hOl5BPLg3KV2tOXlQcw+2ZMCTXRu3lyfBUlvDoyiOF9mB+oTtevJsVKUHM8bXjy
        NU3Wy3fiCho60Rnf0c6bOCBr0mziN9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630337802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5owUn1CVmiCL9vf8pZ9FM+Yys3/QMS+AZd03ZO4Aa4=;
        b=5f8Qz65RJOcjqRNpAtjYyGXEAWrJLZVWgJ5VQQ0csKNj6gDfOvKhHsIWt0yyfFXo2Zmn0r
        BbReQ4oyFSmrinBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AA6C5A3B97;
        Mon, 30 Aug 2021 15:36:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67EC6DA733; Mon, 30 Aug 2021 17:33:52 +0200 (CEST)
Date:   Mon, 30 Aug 2021 17:33:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RESEND PATCH] btrfs: Refactor error handling in btrfs_zero_range
Message-ID: <20210830153351.GC3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210830142547.889802-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830142547.889802-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 05:25:47PM +0300, Nikolay Borisov wrote:
> The major complexity when it comes to error handling in btrfs_zero_range
> stems from the code executed under the 'reserve_space' label. Rather
> than it having an effect on the whole of btrfs_zero_range refactor it
> so that error handling specific to the functions called in this branch
> is contained only within the branch itself. This obviates the need for
> having the 'space_reserved' local flag since btrfs_free_reserved_data_space
> is called from the 2 error branches it's needed. Furthermore, this
> rids the code from the out label and enables converting most 'goto out'
> statements to simiple 'return ret' making the function easier to read.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> I sent this patch some time ago but didn't get any replies so now I'm resending
> it again.

I looked up previous postings, both marked as dropped but without mail
replies so I think we discussed that off list. Looking at it again I
don't like the course of the change, replacing gotos with returns, the
pattern does not look like the one where it's ok.
