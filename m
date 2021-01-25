Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1572C302C28
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbhAYUD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 15:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbhAYUDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 15:03:07 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4408C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:02:26 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so6798916qvd.0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nRELTcsUsqCX705U8IxnzBn+shulInkj4sNk+U13Iio=;
        b=cGauJafFghIE0qUcpZ93tlD/sWjul0eckD0IzK+Y0V5tOTlLvoIIk4xSwEItxLRuej
         AWx5iK9VJoQAZKeeieM6wRLhhrQy2WZ5JxGwbDMeeYYa8uRFImx4yRFfwO0n8p/H2EiM
         ELNKFfd+fC4kWfgZtspdkS4qf7ai1dhxcN30Lmay7r5x4QI4LifORzwGp7RhTgZ6DbP2
         zHNcqinE8yucrwySdz9rrQdSQC0KDksWsWwMhpMr2tZlmdwpZXTnZoTvyrzNUN+ZI4M0
         Dsq6SZsT5SBUGeZaOxkv7YwKbvhPPW4AksXvaM3xPByG4OpobUhIW/G75+ExuWNS3U8A
         t4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRELTcsUsqCX705U8IxnzBn+shulInkj4sNk+U13Iio=;
        b=I+5kh/PBPTrZEn/7FX9+kyhqCxfjr2TFVZYwepfJ4cGL81hoH5h04HOGvJJodLlzau
         ov5HXXcmIx4IkchA71ImxApHc4z1btV5iVGr/ET8IGjJimDk5hw1PrCPsGxH7lbwmzUb
         us4JV6+4FMI3jf/K3hE5IVNMYo0+BvK5nfxLUIyHxTz6Y9YjHYhFZ/MqVd+IJ8r484qQ
         zU9FGip75PWVfTsNYknbeh1FVVz3uUToUh0Q9WK/qX2G8Xw5XHvf+ml7ZI2aKm62TbJq
         lCZ906aeglmQktmQDN79WlICvMEhyiyJT51p1jSKT43Bw1ZSG37hNAVKYXUACYpb5lBu
         3xtw==
X-Gm-Message-State: AOAM532m5ktVzpASHGE1GDf+p4cnBTZhUcas2Vyfmp20S+J7a1IVnCg8
        g2NH5G4gnsY1F7BC7S1+zkgaGHm9QAtSSAMH
X-Google-Smtp-Source: ABdhPJyjKlkqvzVkV/Z2+LkMvaHXctOO8LsXVwRjOOcg+pNvt54FDI6bGn1KyPh9euu27vi1nOHChw==
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr2420833qvb.11.1611604945749;
        Mon, 25 Jan 2021 12:02:25 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::12e0? ([2620:10d:c091:480::1:8a2c])
        by smtp.gmail.com with ESMTPSA id c17sm12907102qkb.13.2021.01.25.12.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:02:24 -0800 (PST)
Subject: Re: [PATCH v4 12/18] btrfs: implement try_release_extent_buffer() for
 subpage metadata support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-13-wqu@suse.com>
 <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
 <20210123203650.GC1993@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d72e01a9-8816-2af7-6eb8-c625654d78ea@toxicpanda.com>
Date:   Mon, 25 Jan 2021 15:02:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123203650.GC1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/21 3:36 PM, David Sterba wrote:
> On Wed, Jan 20, 2021 at 10:05:56AM -0500, Josef Bacik wrote:
>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>>    int try_release_extent_buffer(struct page *page)
>>>    {
>>>    	struct extent_buffer *eb;
>>>    
>>> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
>>> +		return try_release_subpage_extent_buffer(page);
>>
>> You're using sectorsize again here.  I realize the problem is sectorsize !=
>> PAGE_SIZE, but sectorsize != nodesize all the time, so please change all of the
>> patches to check the actual relevant size for the data/metadata type.  Thanks,
> 
> We had a long discussion with Qu about that on slack some time ago.
> Right now we have sectorsize defining the data block size and also the
> metadata unit size and check that as a constraint.
> 
> This is not perfect and does not cover all possible page/data/metadata
> block size combinations and in the code looks odd, like in
> scrub_checksum_tree_block, see the comment.
> 
> Adding the subpage support is quite intrusive and we can't cover all
> size combinations at the same time so we agreed on first iteration where
> sectorsize is still used as the nodesize constraint. This allows to test
> the new code and the whole subpage infrastructure on real hw like arm64
> or ppc64.
> 
> That we'll need to decouple sectorsize from the metadata won't be
> forgotten, I've agreed with that conditionally and given how many
> patches are floating around it'll become even harder to move forward
> with the patches.
> 

Alright that's fine, I'll ignore the weird mismatch'ed checks for now.  Thanks,

Josef
