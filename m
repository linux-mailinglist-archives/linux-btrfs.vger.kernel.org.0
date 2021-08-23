Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8663F4996
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhHWLVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:21:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhHWLU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:20:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA8B01FFA3;
        Mon, 23 Aug 2021 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629717614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sj2N06UyIBzYw9/VpZ5dRXSTItoRMlDNa19GjMaRN8=;
        b=WlbHDH4S7rHyGTOqK6IU6++0rquH7p0FjlcOz78NU+MvJC9e9WMXMjmktXN5w46E5AhzWh
        Vyrmkr87FLJZVAD+dJoStDhMqkdl0uq8aytA4TmuUAI41qbbCh12iIQRJ5oB0h1DwyQQb8
        KNDICAeipzwMSEgAQfsRnLrNWOh65BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629717614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sj2N06UyIBzYw9/VpZ5dRXSTItoRMlDNa19GjMaRN8=;
        b=ZlVA9B5UvCLrOGteX4imdi4JFZofV54NCFWV0pW1hO9/DdDYx4ReQGB6+2a34cRXUcOGx7
        K1NfiJkj13qEYeCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B9642A3BB8;
        Mon, 23 Aug 2021 11:20:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80AF7DA725; Mon, 23 Aug 2021 13:17:15 +0200 (CEST)
Date:   Mon, 23 Aug 2021 13:17:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in v5.14-rc1: f2165627319f btrfs: compression: don't
 try to compress if we don't have enough pages
Message-ID: <20210823111715.GW5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20210822055115.GD29026@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822055115.GD29026@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 22, 2021 at 01:51:15AM -0400, Zygo Blaxell wrote:
> Before this commit:
> 
> 	# head /dev/zero -c 4095 > inline
> 	# compsize inline
> 	Type       Perc     Disk Usage   Uncompressed Referenced  
> 	TOTAL        0%       18B         3.9K         3.9K       
> 	zstd         0%       18B         3.9K         3.9K       
> 
> After this commit:
> 
> 	# head /dev/zero -c 4095 > inline                                                                        
> 	# compsize inline                                                                                        
> 	Processed 1 file, 1 regular extents (1 refs), 0 inline.                                                                                      
> 	Type       Perc     Disk Usage   Uncompressed Referenced                                                                                     
> 	TOTAL      100%      4.0K         4.0K         4.0K                                                                                          
> 	none       100%      4.0K         4.0K         4.0K                                                                                          
> 
> This change makes the metadata sizes of trees of small files (e.g. source
> checkouts) blow up.
> 
> It looks like we need to look at the offset of the extent, as well as
> its length.

Thanks for the report, my bad, I'll look into it.
