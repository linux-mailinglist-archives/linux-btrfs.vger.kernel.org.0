Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339EB15A98D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 13:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBLM6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 07:58:32 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41525 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLM6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 07:58:31 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so844760qvn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wg5tiWUY+invKMQrt46Rm/zXlyOQZNFLddFXm8QzJiE=;
        b=wJPgL+AnMM6esDC0X5PWL4dUqURS93RxYllwtKK8h1EirSPavJeQ6WP9224vANnDxj
         b3e0m2KofGume8753BGQTgOP91ht8DLfnojl2Xe72i5tvdYI40kG/+zsY7xsNsESN9sj
         LJjH2VRvhjwfSX7ZhUQketozvawy1HFpukk4G/Axb3etoPZ2DPd89IT0Dn/yNJ/jjFL6
         oa0KRhrRWozWqnnchmyd9Onko0d1ms7VLewTb/Wa6Ud/GOLg3LxYSkx6c4y2QJXFNFjc
         /qTcYtAMKLtcWvlsZEiWgDSoUayTVhMNEoRSxgOrQWuX1txqtOlCvj02aGrZCI3e+6p4
         +0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wg5tiWUY+invKMQrt46Rm/zXlyOQZNFLddFXm8QzJiE=;
        b=VdwE/HCaSDY6qOJXsGC0wA8n3XkX+FMHE0rlGhIjYUc1RZ+ehYMtEH0zZ95iSSrDGR
         HU4J6rjp/uhfPbBcYw9YjNJ51OaiKpmtpj/ChSHpLy2PoY1Smh3CuWMdoAojnHU0mw/f
         iBo0H/PDJgIN1e0nVt3P0E8A80Vl7u/oW5iHeZSpuxv0MnljE0sF/fjmFZWX3xZaQBdd
         LsmSGPKVKwaYvzzqmdLre759RXk9ny8etT7sNCVvF08MaNel/5RuJLgbIMeZJ1n+gmls
         NO11udCiGF/iLhzE/ucSAilMOK9eG/BUpc+LZ9oOqwaGLkhg6IdT71B4ZZHCBpCdwINN
         nsRg==
X-Gm-Message-State: APjAAAWqu2POCulLwEXnCh+WU1rRZqzEMocqskDs8/LYrvwsXctd0vjw
        9hK6FkTRwCkkR6A82jVfNh26fGha3kA=
X-Google-Smtp-Source: APXvYqzKmdEI8r51qgDeA3wnLGzsQsTBKFEcXrlizQq8egB2S8TCkPdN3GJQYeITfMCEi6ezaLKCxQ==
X-Received: by 2002:ad4:4e46:: with SMTP id eb6mr7274189qvb.64.1581512309931;
        Wed, 12 Feb 2020 04:58:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::de08])
        by smtp.gmail.com with ESMTPSA id 63sm135073qki.57.2020.02.12.04.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:58:29 -0800 (PST)
Subject: Re: [PATCH] btrfs: Only require sector size alignment for parent eb
 bytenr
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200212053040.23221-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9d4bfc49-f914-aa2f-2809-a65a267917a4@toxicpanda.com>
Date:   Wed, 12 Feb 2020 07:58:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212053040.23221-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 12:30 AM, Qu Wenruo wrote:
> [BUG]
> A completely sane converted fs will cause kernel warning at balance
> time:
> 
> [ 1557.188633] BTRFS info (device sda7): relocating block group 8162107392 flags data
> [ 1563.358078] BTRFS info (device sda7): found 11722 extents
> [ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total ptrs 213 free space 3458 owner 2
> [ 1563.358280] 	item 0 key (7984947200 169 0) itemoff 16250 itemsize 33
> [ 1563.358281] 		extent refs 1 gen 90 flags 2
> [ 1563.358282] 		ref#0: tree block backref root 4
> [ 1563.358285] 	item 1 key (7985602560 169 0) itemoff 16217 itemsize 33
> [ 1563.358286] 		extent refs 1 gen 93 flags 258
> [ 1563.358287] 		ref#0: shared block backref parent 7985602560
> [ 1563.358288] 			(parent 7985602560 is NOT ALIGNED to nodesize 16384)
> [ 1563.358290] 	item 2 key (7985635328 169 0) itemoff 16184 itemsize 33
> ...
> [ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent inline ref type 182
> [ 1563.358996] ------------[ cut here ]------------
> [ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766
> 
> Then with transaction abort, and obviously failed to balance the fs.
> 
> [CAUSE]
> That mentioned inline ref type 182 is completely sane, it's
> BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
> believe it's invalid.
> 
> Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
> type") introduced extra checks for backref type.
> 
> One of the requirement is, parent bytenr must be aligned to node size,
> which is not correct, especially for converted fs or mixed fs.
> 
> One tree block can start at any bytenr aligned to sector size. Node size
> should never be an alignment requirement.
> Thus such bad check is causing above bug.
> 
> [FIX]
> Change the alignment requirement from node size alignment to sector size
> alignment.
> 
> Also, to make our lives a little easier, also output @iref when
> btrfs_get_extent_inline_ref_type() failed, so we can locate the item
> easier.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205475
> Fixes: 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref type")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

We aren't allowed to have nodesize != sectorsize with mixed, exactly because you 
ended up with weirdly sized holes and such.  How is convert ending up with this 
problem?  Thanks,

Josef
